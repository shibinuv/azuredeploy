USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_CUSTOMER_SEARCH]    Script Date: 19.03.2020 11.49.26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[USP_SPAREPART_GRID_SEARCH]   
(
	@ID_SEARCH VARCHAR(255),
	@ISSTOCK AS BIT,
	@ISCONTROL AS BIT  ,
	@ISNOTCONTROL AS BIT
)
AS  
DECLARE @string as varchar(255) = @ID_SEARCH  
DECLARE @string_cut as varchar (255) = REPLACE(@string, ' ', ';')  
DECLARE @parsed_query as nvarchar(2000)  
DECLARE @i int = 1  
DECLARE @query_col as nvarchar(1000) = 'ISNULL(ID_ITEM,'''') + ISNULL(ITEM_DESC,'''') + ISNULL(SUP_Name,'''') + ISNULL(LOCATION,'''')' -- SEARCHABLE COLUMNS  
SELECT * INTO #tmp_patterns FROM dbo.ParseValues(@string_cut, ';')  
  
  
DECLARE @stringCount as int = (SELECT COUNT(*) FROM #tmp_patterns)  
  
SELECT TOP 0  
 [ID_ITEM]
      ,[ITEM_DESC]
      ,[ITEM_DESC_NAME2]
      ,[ID_UNIT_ITEM]
      ,[ID_MAKE]
      ,[ID_ITEM_MODEL]
      ,[ID_ITEM_CATG]
      ,[ID_SUPPLIER_ITEM]
      ,[ITEM_AVAIL_QTY]
      ,[ID_WH_ITEM]
      ,[ITEM_REORDER_LEVEL]
      ,[ITEM_DISC_CODE]
      ,[ITEM_DISC_CODE_BUY]
      ,[BASIC_PRICE]
      ,[ITEM_PRICE]
      ,[COST_PRICE1]
      ,[NET_PRICE]
      ,[LOCATION]
      ,[PACKAGE_QTY]
      ,[ID_VAT_CODE]
      ,[ACCOUNT_CODE]
      ,[FLG_ALLOW_BCKORD]
      ,[FLG_CALC_PRICE]
      ,[FLG_CNT_STOCK]
      ,[FLG_DUTY]
      ,TMI.[CREATED_BY]
      ,TMI.[DT_CREATED]
      ,TMI.[MODIFIED_BY]
      ,TMI.[DT_MODIFIED]
      ,[Class_Code]
      ,[ID_SPCATEGORY]
      ,[AVG_PRICE]
      ,[QTY_NOT_DELIVERED]
      ,[QTY_BO_SUPPLIER]
      ,[LAST_BUY_PRICE]
      ,[DT_LAST_BUY]
      ,[MIN_STOCK]
      ,[MAX_STOCK]
	  ,[MIN_PURCHASE]
      ,[MAX_PURCHASE]
	  ,[CONSUMPTION_ESTIMATED] 
      ,[FLG_BLOCK_AUTO_ORD]
      ,[TD_CALC]
      ,[FLG_STOCKITEM]
      ,[VA_EXCHANGE_VEH]
      ,[VA_ORDER_COST]
      ,[FLG_STOCKITEM_STATUS]
      ,[ENV_ID_ITEM]
      ,[ENV_ID_MAKE]
      ,[ENV_ID_WAREHOUSE]
      ,[FLG_EFD]
      ,[ALT_LOCATION]
      ,[ANNOTATION]
      ,[FLG_VAT_INCL]
      ,[FLG_OBTAIN_SPARE]
      ,[FLG_OBSOLETE_SPARE]
      ,[FLG_AUTOADJUST_PRICE]
      ,[FLG_LABELS]
      ,[FLG_ALLOW_DISCOUNT]
      ,[DISCOUNT]
      ,[LAST_COST_PRICE]
	  ,TMI.[SUPP_CURRENTNO]
	  ,TMS.SUP_Name
 INTO #tmp_res   
FROM   
 TBL_MAS_ITEM_MASTER TMI  
 inner join  
  TBL_MAS_SUPPLIER TMS
  on TMI.SUPP_CURRENTNO = TMS.SUPP_CURRENTNO  

WHILE @i <= @stringCount  
BEGIN  
 DECLARE @value as varchar(150) = (SELECT Val FROM dbo.ParseValues(@string_cut, ';') WHERE ID = @i)  
 INSERT INTO   
  #tmp_res   
 SELECT   
  [ID_ITEM]
      ,[ITEM_DESC]
      ,[ITEM_DESC_NAME2]
      ,[ID_UNIT_ITEM]
      ,[ID_MAKE]
      ,[ID_ITEM_MODEL]
      ,[ID_ITEM_CATG]
      ,[ID_SUPPLIER_ITEM]
      ,[ITEM_AVAIL_QTY]
      ,[ID_WH_ITEM]
      ,[ITEM_REORDER_LEVEL]
      ,[ITEM_DISC_CODE]
      ,[ITEM_DISC_CODE_BUY]
      ,[BASIC_PRICE]
      ,[ITEM_PRICE]
      ,[COST_PRICE1]
      ,[NET_PRICE]
      ,[LOCATION]
      ,[PACKAGE_QTY]
      ,[ID_VAT_CODE]
      ,[ACCOUNT_CODE]
      ,[FLG_ALLOW_BCKORD]
      ,[FLG_CALC_PRICE]
      ,[FLG_CNT_STOCK]
      ,[FLG_DUTY]
      ,TMI.[CREATED_BY]
      ,TMI.[DT_CREATED]
      ,TMI.[MODIFIED_BY]
      ,TMI.[DT_MODIFIED]
      ,[Class_Code]
      ,[ID_SPCATEGORY]
      ,[AVG_PRICE]
      ,[QTY_NOT_DELIVERED]
      ,[QTY_BO_SUPPLIER]
      ,[LAST_BUY_PRICE]
      ,[DT_LAST_BUY]
      ,[MIN_STOCK]
      ,[MAX_STOCK]
	  ,[MIN_PURCHASE]
      ,[MAX_PURCHASE]
	  ,[CONSUMPTION_ESTIMATED] 
      ,[FLG_BLOCK_AUTO_ORD]
      ,[TD_CALC]
      ,[FLG_STOCKITEM]
      ,[VA_EXCHANGE_VEH]
      ,[VA_ORDER_COST]
      ,[FLG_STOCKITEM_STATUS]
      ,[ENV_ID_ITEM]
      ,[ENV_ID_MAKE]
      ,[ENV_ID_WAREHOUSE]
      ,[FLG_EFD]
      ,[ALT_LOCATION]
      ,[ANNOTATION]
      ,[FLG_VAT_INCL]
      ,[FLG_OBTAIN_SPARE]
      ,[FLG_OBSOLETE_SPARE]
      ,[FLG_AUTOADJUST_PRICE]
      ,[FLG_LABELS]
      ,[FLG_ALLOW_DISCOUNT]
      ,[DISCOUNT]
      ,[LAST_COST_PRICE]
	  ,TMI.[SUPP_CURRENTNO]
	  ,TMS.SUP_Name
 FROM   
  TBL_MAS_ITEM_MASTER TMI  
   inner join  
  TBL_MAS_SUPPLIER TMS
  on TMI.SUPP_CURRENTNO = TMS.SUPP_CURRENTNO  
 WHERE   
  ISNULL(ID_ITEM,'') + ISNULL(ITEM_DESC,'') + ISNULL(TMS.SUP_Name,'') + ISNULL(LOCATION,'') LIKE '%' + @value + '%'  
 IF @i = 1   
  SET @parsed_query = CONCAT(@parsed_query,'SELECT DISTINCT TOP 100 * FROM #tmp_res WHERE ', @query_col, ' LIKE ''%', @value, '%'' ') -- ADDS BEGINNING STATEMENT  
 ELSE  
  SET @parsed_query = CONCAT(@parsed_query, 'AND ', @query_col, ' LIKE ''%', @value, '%'' ') -- ALL FOLLOWING STATEMENTS POST SELECT AND WHERE  
  
 SET @i = @i + 1  

 IF @ISSTOCK = 1  	 
	SET @parsed_query = @parsed_query + ' AND ITEM_AVAIL_QTY > 0.00'

 IF @ISCONTROL = 1 AND @ISNOTCONTROL = 0
	SET @parsed_query = @parsed_query + ' AND FLG_STOCKITEM_STATUS = 1'

 IF @ISNOTCONTROL = 1 AND @ISCONTROL = 0
	SET @parsed_query = @parsed_query + ' AND FLG_STOCKITEM_STATUS = 0'
END  
  
-- SELECT * FROM #tmp_res ORDER BY VEH_REG_NO ASC -- Matches all results from all queries  
EXECUTE sp_executesql @parsed_query -- Parsed dynamic query, must match all search queries in single row  
  
DROP TABLE #tmp_res  
DROP TABLE #tmp_patterns