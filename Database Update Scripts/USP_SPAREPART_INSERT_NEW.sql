USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPAREPART_INSERT_NEW]    Script Date: 19.05.2020 13:10:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[USP_SPAREPART_INSERT_NEW] 
(
    @ID_ITEM varchar(30),		-- Required
	@SUPP_CURRENTNO varchar(10),		-- Required
	@ID_WH_ITEM int,			-- Required
	@ID_ITEM_CATG varchar(10),	-- Required
    @ITEM_DESC varchar(100)	,
	 @CREATED_BY varchar(100)	
    
)

AS
BEGIN

DECLARE @DT_CREATED DATETIME = getdate()
DECLARE @DT_MODIFIED DATETIME = getdate()
--DECLARE @ID_ITEM_CATG INT = (SELECT TOP 1 ID_ITEM_CATG FROM TBL_MAS_ITEM_CATG WHERE ID_MAKE = @ID_MAKE ORDER BY ID_ITEM_CATG ASC)




PRINT @ID_ITEM

-- Insert Statement if customer does not exist
--IF NOT EXISTS (SELECT * FROM TBL_MAS_ITEM_MASTER WHERE ID_ITEM = @ID_ITEM and ID_MAKE = @ID_MAKE and ID_WH_ITEM = @ID_WH_ITEM) AND LEN(@ID_ITEM) > 0
BEGIN
	INSERT INTO [dbo].[TBL_MAS_ITEM_MASTER]
				
	  ([ID_ITEM]
      ,[ITEM_DESC]
      ,[ID_ITEM_CATG]
      ,[ID_MAKE]
      ,[SUPP_CURRENTNO]
	  ,[ID_WH_ITEM]
	  ,[CREATED_BY]
	  ,[DT_CREATED]
	  ,[BASIC_PRICE]
	  ,[ITEM_PRICE]
	  ,[COST_PRICE1]
	  ,[NET_PRICE]
	  ,[AVG_PRICE]
	  ,[MIN_STOCK]
	  ,[MAX_PURCHASE]
	  ,[MIN_PURCHASE]
	  ,[CONSUMPTION_ESTIMATED]
	  ,[ITEM_AVAIL_QTY]
      )
			VALUES
				(@ID_ITEM ,
    @ITEM_DESC ,
    @ID_ITEM_CATG ,
    @SUPP_CURRENTNO,
	@SUPP_CURRENTNO,
	@ID_WH_ITEM,
	@CREATED_BY,
	getdate(),
	0.00,
	0.00,
	0.00,
	0.00,
	0.00,
	0.00,
	0.00,
	0.00,
	0.00,
	0.00

    
			)
		
END

END


