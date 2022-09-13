USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_TIRE_PACKAGE_NO_LIST]    Script Date: 18.11.2021 10:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[USP_TIRE_PACKAGE_NO_LIST]
(
	
	@Warehouse int,
	@tpNo varchar(30),
	@refNo varchar(30),
	@custNo varchar(30),
	@closed varchar(30),
	@tireType varchar(30) = 0,
	@tireQuality varchar(30) = 0

)
AS
BEGIN
 
 DECLARE @MAINQRY AS NVARCHAR(MAX)
DECLARE @CQRY AS NVARCHAR(MAX) = ''
DECLARE @ORDERBY as NVARCHAR(MAX) = ' order by regDate desc'
--DECLARE @THE_PRICETYPE varchar(60)

--SELECT @THE_PRICETYPE = PRICETYPE 
--FROM TBL_SPR_SUPPLIERCONFIG
--WHERE ((SUPP_CURRENTNO LIKE @SUPP_CURRENTNO) AND SUPP_ORDERTYPE LIKE @ID_ORDERTYPE)
--print(@THE_PRICETYPE)

SET @MAINQRY = N'select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isFinished FROM TBL_TIRE_ORDER_PACKAGE '-- where isFinished = 0 '
SET @CQRY = 'WHERE isFinished = ' + @closed
	
	IF @tpNo <> '' 
		--SET @CQRY = ' AND (IM.ID_ITEM like ''' + @sparefrom + '%'')'
		SET @CQRY = @CQRY + ' AND tirePackageNo = ''' + @tpNo+'''' 
						                                        

	IF @refNo <> '' 
		SET @CQRY = @CQRY + ' AND refNo = ''' + @refNo+'''' 
	IF @custNo <> '' 
		SET @CQRY = @CQRY + ' AND custNo = ' + @custNo
	
	IF @tireType > '0' 
		SET @CQRY = @CQRY + ' AND tireTypeVal = ' + @tireType
	IF @tireQuality > '0' 
		SET @CQRY = @CQRY + ' AND tireQualityVal = ' + @tireQuality

	

	IF @CQRY <> ''
		SET @MAINQRY = @MAINQRY + @CQRY
		print @MAINQRY

	EXEC (@MAINQRY + @ORDERBY) 	

--SELECT distinct COUNTING_NO, COUNTING_PREFIX, DT_CREATED, CREATED_BY, SUPP_CURRENTNO, 
--(SELECT SUP_Name FROM TBL_MAS_SUPPLIER MS WHERE MS.SUPP_CURRENTNO = CO.SUPP_CURRENTNO) AS SUP_Name, CLOSED, DIFFERENCE 
--from TBL_SPR_COUNTING CO 
--WHERE ID_WH =1  order by DT_CREATED asc


--select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isActive FROM TBL_TIRE_ORDER_PACKAGE where isActive = 1 order by regDate desc


--IF @tpNo <> ''
--	select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isActive FROM TBL_TIRE_ORDER_PACKAGE where isActive = 1 and tirePackageNo = @tpNo order by regDate desc
--else if @refNo <> ''
--	select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isActive FROM TBL_TIRE_ORDER_PACKAGE where isActive = 1 and refNo = @refNo order by regDate desc
--else if @custNo <> ''
--select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isActive FROM TBL_TIRE_ORDER_PACKAGE where isActive = 1 and refNo = @refNo order by regDate desc
--else if @tireType >'0' 
--select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isActive FROM TBL_TIRE_ORDER_PACKAGE where isActive = 1 and tireTypeVal = @tireType order by regDate desc
--else if @tireQuality > '0'
--select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isActive FROM TBL_TIRE_ORDER_PACKAGE where isActive = 1 and tireQualityVal = @tireQuality order by regDate desc
--else  
--select refNo, regNo, custNo, custName, custmName, custlName, tirePackageNo, location, tireTypeDesc, tireQualityDesc, tireAxleNoDesc, isActive FROM TBL_TIRE_ORDER_PACKAGE where isActive = 1 order by regDate desc

 
 
END

