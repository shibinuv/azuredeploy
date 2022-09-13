USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_COUNTING_CLOSE_ITEM]    Script Date: 06.11.2020 14:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  
ALTER PROCEDURE [dbo].[USP_SPR_COUNTING_CLOSE_ITEM]  
(  
	
	@USER VARCHAR(50), /*CURRENT USER WHO CREATES*/
	@COUNTING_PREFIX VARCHAR(50),
	@COUNTING_NO VARCHAR(50),
	@SUPP_CURRENTNO VARCHAR(50),
	@ID_ITEM VARCHAR(30),
	@DESCRIPTION VARCHAR(30),
	@LINE_NO VARCHAR(50),
	@COST_PRICE DECIMAL(13, 2),
	@SELLING_PRICE DECIMAL(13, 2),
	@AVG_PRICE DECIMAL(13, 2),
	@STOCKBEFORECOUNT DECIMAL(13, 2),
	@STOCKAFTERCOUNT DECIMAL(13, 2),
	@ID_WH INT,
	@ADJUSTMENT DECIMAL(13, 2),
	@DIFFERENCE DECIMAL(13, 2),
	@LOCATION VARCHAR(50),
	@ID_ITEM_CATG VARCHAR(50),
	--@DT_MODIFIED DATETIME,
	@MODIFIED_BY VARCHAR(20)
	


	 		 
) 
AS 
	
	BEGIN

	DECLARE @QTYSOLD DECIMAL(13, 2)
	SET @QTYSOLD = 0.00
	SET @QTYSOLD = (SELECT SUM(INVL_DELIVER_QTY) FROM TBL_INV_DETAIL_LINES WHERE ID_ITEM_INVL = 1161650 AND ID_MAKE=20308 AND ID_WAREHOUSE=1 AND DT_CREATED > (SELECT TOP(1) DT_CREATED FROM TBL_SPR_COUNTING WHERE COUNTING_PREFIX = 'T22' AND COUNTING_NO = 81))
	IF @QTYSOLD > 0.00                 
 BEGIN                          
  SET @STOCKAFTERCOUNT = (@STOCKAFTERCOUNT - @QTYSOLD)
 END            
	END 
	
	BEGIN
	    UPDATE [TBL_SPR_COUNTING]  
	
	 SET CLOSED = 1
           ,DT_MODIFIED = GETDATE()
		   ,MODIFIED_BY = @MODIFIED_BY
		   ,STOCKAFTERCOUNT = @STOCKAFTERCOUNT
	WHERE
	COUNTING_PREFIX = @COUNTING_PREFIX AND COUNTING_NO = @COUNTING_NO and ID_ITEM = @ID_ITEM and SUPP_CURRENTNO=@SUPP_CURRENTNO	
	  
	
	END
	BEGIN
	UPDATE TBL_MAS_ITEM_MASTER 
	SET ITEM_AVAIL_QTY=@STOCKAFTERCOUNT,
	DT_MODIFIED=GETDATE(),
	MODIFIED_BY = @MODIFIED_BY
	WHERE 
	ID_WH_ITEM=@ID_WH AND ID_ITEM = @ID_ITEM and SUPP_CURRENTNO=@SUPP_CURRENTNO

	END
	BEGIN
	IF @STOCKBEFORECOUNT <> @STOCKAFTERCOUNT
		INSERT INTO TBL_SPR_STOCK_ADJUSTMENTS
	   (STOCK_ADJ_TYPE,
	   STOCK_ADJ_ID_ITEM,
	   STOCK_ADJ_SUPPLIER,
	   STOCK_ADJ_CATG,
	   STOCK_ADJ_WAREHOUSE,
	   STOCK_ADJ_NO,
	   STOCK_ADJ_DATE,
	   STOCK_ADJ_SIGNATURE,
	   STOCK_ADJ_TEXT,
	   STOCK_ADJ_OLD_QTY,
	   STOCK_ADJ_CHANGED_QTY,
	   STOCK_ADJ_NEW_QTY)
	   VALUES(
		'TELLELISTE',
		@ID_ITEM,
		@SUPP_CURRENTNO,
		(SELECT ID_ITEM_CATG FROM TBL_MAS_ITEM_MASTER WHERE ID_ITEM = @ID_ITEM AND SUPP_CURRENTNO = @SUPP_CURRENTNO AND ID_WH_ITEM = @ID_WH),
		@ID_WH,
		@COUNTING_PREFIX+@COUNTING_NO,
		GETDATE(),
		@USER,
		'Oppdatert fra telleliste ' + @COUNTING_PREFIX+@COUNTING_NO,
		@STOCKBEFORECOUNT,
		@DIFFERENCE,
		@STOCKAFTERCOUNT
		)

	END
	--ELSE
	--BEGIN
	--	UPDATE TBL_SPR_PO_ITEM
	--	SET 
	--	    COST_PRICE1 = @COST_PRICE1,
	--		TOTALCOST = @TOTALCOST,
	--		REST_FLG = @REST_FLG,
	--		ORDERQTY = @ORDERQTY,
	--		REMAINING_QTY = @ORDERQTY,
			
	--		DT_MODIFIED = GETDATE(),
	--		MODIFIED_BY = @USER

	--	WHERE @PONUMBER = PONUMBER AND @ID_ITEM = ID_ITEM AND @ID_WOITEM_SEQ = ID_WOITEM_SEQ
	--END

	
		

