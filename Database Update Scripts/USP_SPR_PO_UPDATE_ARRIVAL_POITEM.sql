/****** Object:  StoredProcedure [dbo].[USP_SPR_PO_UPDATE_ARRIVAL_POITEM]    Script Date: 29-03-2022 00:37:20 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_PO_UPDATE_ARRIVAL_POITEM]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_PO_UPDATE_ARRIVAL_POITEM]    Script Date: 29-03-2022 00:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery47.sql|7|0|C:\Users\ADMINI~1\AppData\Local\Temp\2\~vsC84F.sql


  
CREATE PROCEDURE [dbo].[USP_SPR_PO_UPDATE_ARRIVAL_POITEM]  
(  
	
	@USER VARCHAR(50), /*CURRENT USER WHO CREATES*/
	
	@PONUMBER VARCHAR(50),
	@ID_ITEM VARCHAR(30),
	@REMAINING_QTY DECIMAL(13,2),
	@DELIVERED_QTY DECIMAL(13,2),
	@COST_PRICE1 DECIMAL(13,2),
	@ITEM_PRICE DECIMAL(13,2),
	@ID_WOITEM_SEQ VARCHAR(30),
	@SUPP_CURRENTNO VARCHAR(50),
	@ID_ITEM_CATG VARCHAR(50),
	@ID_WAREHOUSE INT	                       		 
) 
AS  
  
BEGIN  

		declare @ID_PO INT

		SELECT @ID_PO = ID_PO FROM TBL_SPR_PO_ITEM WHERE @PONUMBER = PONUMBER AND @ID_ITEM = ID_ITEM AND @ID_WOITEM_SEQ = ID_WOITEM_SEQ

		UPDATE TBL_SPR_PO_ITEM
		SET 
		    DELIVERED_QTY = DELIVERED_QTY + @DELIVERED_QTY,					
			REMAINING_QTY = REMAINING_QTY - @DELIVERED_QTY,
			COST_PRICE1 = @COST_PRICE1,
			ITEM_PRICE = @ITEM_PRICE,
			DT_MODIFIED = GETDATE(),
			MODIFIED_BY = @USER
		WHERE @PONUMBER = PONUMBER AND @ID_ITEM = ID_ITEM AND @ID_WOITEM_SEQ = ID_WOITEM_SEQ

		declare @availQty as decimal
		declare @avgPrice as decimal

		
		SET @avgPrice = (SELECT IM.AVG_PRICE
                  FROM TBL_MAS_ITEM_MASTER IM
                  WHERE ID_ITEM = @ID_ITEM
			      AND   SUPP_CURRENTNO = @SUPP_CURRENTNO
			      AND ID_ITEM_CATG = @ID_ITEM_CATG
			      AND ID_WH_ITEM = @ID_WAREHOUSE)

		print @avgPrice

		SET @availQty = (SELECT IM.ITEM_AVAIL_QTY 
                  FROM TBL_MAS_ITEM_MASTER IM
                  WHERE ID_ITEM = @ID_ITEM
			      AND   SUPP_CURRENTNO = @SUPP_CURRENTNO
			      AND ID_ITEM_CATG = @ID_ITEM_CATG
			      AND ID_WH_ITEM = @ID_WAREHOUSE)
	  
	  print @availQty

	  IF @DELIVERED_QTY <> 0
	      IF @avgPrice is null or @avgPrice = 0
	          SET @avgPrice = ( @DELIVERED_QTY * @COST_PRICE1) / (@DELIVERED_QTY)

	      ELSE
			  SET @avgPrice = ((@availQty * @avgPrice) + ( @DELIVERED_QTY * @COST_PRICE1)) / (@availQty + @DELIVERED_QTY)

	  





	   UPDATE TBL_MAS_ITEM_MASTER		
			SET 
				AVG_PRICE = @avgPrice,
				ITEM_AVAIL_QTY = ITEM_AVAIL_QTY + @DELIVERED_QTY,
				COST_PRICE1 = @COST_PRICE1,
				ITEM_PRICE = @ITEM_PRICE,
				LAST_COST_PRICE = @COST_PRICE1,
				LAST_BUY_PRICE = @COST_PRICE1,
				DT_LAST_BUY = GETDATE()

			WHERE ID_ITEM = @ID_ITEM
			AND   SUPP_CURRENTNO = @SUPP_CURRENTNO
			AND ID_ITEM_CATG = @ID_ITEM_CATG
			AND ID_WH_ITEM = @ID_WAREHOUSE
		
		UPDATE TBL_SPR_PO_ITEM 			
			SET REMAINING_QTY = 0
		WHERE (DELIVERED_QTY >= ORDERQTY
		OR REST_FLG = 0) AND @PONUMBER = PONUMBER AND @ID_ITEM = ID_ITEM AND @ID_WOITEM_SEQ = ID_WOITEM_SEQ
	  
		UPDATE TBL_SPR_PO_ITEM 			
			SET DELIVERED = 1
		WHERE REMAINING_QTY = 0 AND @PONUMBER = PONUMBER AND @ID_ITEM = ID_ITEM AND @ID_WOITEM_SEQ = ID_WOITEM_SEQ

		EXEC USP_SPR_PO_UPATETOBACKORDER @ID_WOITEM_SEQ,
			@DELIVERED_QTY,
			@USER,
			@ID_PO,
			@ID_ITEM,
			NULL,
			NULL
END
GO
