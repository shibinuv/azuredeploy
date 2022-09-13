create PROCEDURE [dbo].[USP_GENERATE_TP_SELECTION]
(
	
	@WAREHOUSE int,
	@DEPARTMENT int,
	@TIRETYPE int,
	@SPIKESORNOT int,
	@RIMTYPE int,
	@TIREBRAND int,
	@TIREQUALITY int,
	@TIREDEPTH DECIMAL(13,2),
	@LOCATIONFROM VARCHAR(50),
	@LOCATIONTO VARCHAR(50)

)
AS
BEGIN
DECLARE @MAINQRY AS NVARCHAR(MAX)
DECLARE @CQRY AS NVARCHAR(MAX) = ''


SET @MAINQRY = N'SELECT TP.custName, TP.custmName, TP.custlName, TP.tirePackageNo, TP.refNo, TP.regNo, TP.tireDimFront, TP.tireDimBack, TP.location, TP.tireTypeDesc, TP.tireSpikesDesc, TP.tireRimDesc, TP.tireBrandDesc, TP.tireQualityDesc 
FROM TBL_TIRE_ORDER_PACKAGE TP
INNER JOIN TBL_TIRE_PACKAGE_DEPTH PD ON PD.TIRE_PACKAGE_NO = TP.tirePackageNo AND PD.CLOSED = 0
 where isFinished=0 '

--SELECT *, DEPTH1L, DEPTH2L, DEPTH1R, DEPTH2R  FROM TBL_TIRE_PACKAGE_DEPTH
--NEED TO CONVERT VALUES TO VARCHAR BECAUSE EVERYTHING IS A GIANT STRING.
	IF @TIRETYPE <> 0
		SET @CQRY = 'AND TP.TireTypeVal = ' + CONVERT(VARCHAR,@TIRETYPE) + ' '
	
	IF @SPIKESORNOT <> 0
		SET @CQRY = @CQRY + 'AND TP.TireSpikesVal = ''' + CONVERT(VARCHAR,@SPIKESORNOT) + ' ' 
	IF @RIMTYPE <> 0
		SET @CQRY = @CQRY + 'AND TP.tireRimVal = ' + CONVERT(VARCHAR,@RIMTYPE) + ' ' 
	IF @tireBrand <> 0
		SET @CQRY = @CQRY + 'AND TP.tireBrandVal = ' + CONVERT(VARCHAR,@TIREBRAND) + ' ' 
	IF @TIREQUALITY <> 0
		SET @CQRY = @CQRY + 'AND TP.tireQualityVal = ' + CONVERT(VARCHAR,@TIREQUALITY) + ' ' 
	IF @LOCATIONFROM <> '0' AND @LOCATIONTO <> '0'
		SET @CQRY = @CQRY + 'AND TP.location >= ''' + CONVERT(VARCHAR,@LOCATIONFROM)+'%''' + ' AND TP.location <= ''' + CONVERT(VARCHAR,@LOCATIONTO)+'%''' 
	IF @TIREDEPTH <> 0
		SET @CQRY = @CQRY + 'AND (PD.DEPTH1L <= ' + CONVERT(VARCHAR,@TIREDEPTH) + ' OR PD.DEPTH2L <= ' + CONVERT(VARCHAR,@TIREDEPTH) + 'OR PD.DEPTH1R <= ' + CONVERT(VARCHAR,@TIREDEPTH) + 'OR PD.DEPTH2R <= ' + CONVERT(VARCHAR,@TIREDEPTH) + ') '

	IF @CQRY <> ''
		SET @MAINQRY = @MAINQRY + @CQRY
		print @MAINQRY

	EXEC (@MAINQRY) 	

  

 
END


--SET @MAINQRY = N'SELECT IM.ID_ITEM
--	, IM.ITEM_DESC
--	, (SELECT CATG_DESC FROM TBL_MAS_ITEM_CATG IC WHERE IC.ID_ITEM_CATG = IM.ID_ITEM_CATG) AS ITEM_CATG_DESC 
--	,IM.ID_WH_ITEM
--	,IM.ID_ITEM_CATG
--	,IM.ITEM_AVAIL_QTY AS STOCKBEFORECOUNT
--	,ISNULL(IM.LOCATION, '''') as LOCATION
--	,(SELECT ISNULL((SELECT TOP (1) CO.LAST_COUNTED_DATE FROM TBL_SPR_COUNTING CO WHERE CO.ID_ITEM = IM.ID_ITEM AND CO.ID_WH = IM.ID_WH_ITEM and co.SUPP_CURRENTNO = im.SUPP_CURRENTNO ORDER BY LAST_COUNTED_DATE DESC), NULL)) AS LAST_COUNTED_DATE
--	,(SELECT ISNULL((SELECT TOP (1) COALESCE(CO.CREATED_BY, '''') FROM TBL_SPR_COUNTING CO WHERE CO.ID_ITEM = IM.ID_ITEM AND CO.ID_WH = IM.ID_WH_ITEM and co.SUPP_CURRENTNO = im.SUPP_CURRENTNO ORDER BY DT_CREATED DESC), '''')) AS CREATED_BY
--	,IM.SUPP_CURRENTNO
--	,IM.AVG_PRICE
--	,IM.ITEM_PRICE
--	,IM.COST_PRICE1
--	FROM TBL_MAS_ITEM_MASTER IM
--	WHERE IM.ID_WH_ITEM ='+ CONVERT(VARCHAR(10),@warehouseId)+' AND NOT IM.ID_ITEM IN (SELECT ID_ITEM FROM TBL_SPR_COUNTING WHERE CLOSED = 0)'




--IF @sparefrom <> '' AND @spareto <> '' 
--		SET @CQRY = @CQRY + ' AND (IM.ID_ITEM between ''' + @sparefrom + '%'' AND ''' + @spareTo + '%'')'
						                                        

--	IF @locationFrom <> '' AND @locationTo <> ''
--		SET @CQRY = @CQRY + ' AND (IM.LOCATION between ''' + @locationFrom + '%'' AND ''' + @locationTo + '%'')'


--	IF @stock = 1
--		SET @CQRY = @CQRY + ' AND IM.ITEM_AVAIL_QTY > 0'
	
--	IF @nolocation = 1
--		SET @CQRY = @CQRY + ' AND IM.LOCATION IS NULL OR IM.LOCATION = '''''
		
	
--	IF @sortBy = '1' 
--		SET @CQRY = @CQRY +  ' ORDER BY IM.ID_ITEM ASC'

--	ELSE IF @sortBy = '2' 
--		SET @CQRY = @CQRY +  ' ORDER BY IM.ITEM_DESC ASC'

--	ELSE IF @sortBy = '3' 
--		SET @CQRY = @CQRY +  ' ORDER BY IM.LOCATION ASC'