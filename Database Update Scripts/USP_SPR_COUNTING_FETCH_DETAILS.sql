USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_COUNTING_FETCH_DETAILS]    Script Date: 01.03.2022 14:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[USP_SPR_COUNTING_FETCH_DETAILS]
(
	
	@CLPrefix varchar(30),
	@CLNo varchar(30),
	@Warehouse int
	
)
AS
BEGIN

SELECT CO.LINE_NO,
CO.ID_ITEM,
CO.DESCRIPTION,
CO.LOCATION,
(SELECT TOP (1) ISNULL(LAST_COUNTED_DATE,'') from TBL_SPR_COUNTING CO2 WHERE CO2.ID_ITEM = CO.ID_ITEM AND CO2.SUPP_CURRENTNO = CO.SUPP_CURRENTNO AND CO2.ID_WH = CO.ID_WH ORDER BY COUNTING_DATE DESC) AS LAST_COUNTED_DATE,
(SELECT TOP (1) ISNULL(CREATED_BY,'') from TBL_SPR_COUNTING CO2 WHERE CO2.ID_ITEM = CO.ID_ITEM AND CO2.SUPP_CURRENTNO = CO.SUPP_CURRENTNO AND CO2.ID_WH = CO.ID_WH ORDER BY COUNTING_DATE DESC) AS CREATED_BY,
CO.STOCKBEFORECOUNT,
CO.DIFFERENCE,
CO.STOCKAFTERCOUNT,
SUPP_CURRENTNO,
CO.ID_ITEM_CATG,
CO.AVG_PRICE,
CO.SELLING_PRICE,
CO.COST_PRICE1,
CO.DT_MODIFIED,
CO.MODIFIED_BY,
CO.COUNTED_BY,
CO.COUNTING_PREFIX,
CO.COUNTING_NO,
(CO.DIFFERENCE * AVG_PRICE) AS SPARE_VALUE,
(CO.STOCKBEFORECOUNT * AVG_PRICE) AS BEFORE_COST,
(CO.STOCKAFTERCOUNT * AVG_PRICE) AS AFTER_COST

FROM TBL_SPR_COUNTING CO
WHERE CO.COUNTING_PREFIX = @CLPrefix and COUNTING_NO = @CLNo


	 
  

 
END

