USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_TIRE_PACKAGE_NO_INSERT]    Script Date: 25.11.2021 12:52:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  
ALTER PROCEDURE [dbo].[USP_TIRE_PACKAGE_NO_INSERT]  
(  
	
	@USER VARCHAR(50), /*CURRENT USER WHO CREATES*/
	@refNo VARCHAR(50),
	@regNo VARCHAR(50), 
	@custNo VARCHAR(50), 
	@custName VARCHAR(100), 
	@tirePackageNo VARCHAR(50), 
	@qtyTire VARCHAR(50), 
	@tireDimFront VARCHAR(50), 
	@tireDimBack VARCHAR(50), 
	@location VARCHAR(50), 
	@tireTypeVal int, 
	@tireTypeDesc VARCHAR(50), 
	@tireSpikesVal int, 
	@tireSpikesDesc VARCHAR(50), 
	@tireRimVal int,
	@tireRimDesc VARCHAR(50), 
	@tireBrandVal int, 
	@tireBrandDesc VARCHAR(50), 
	@tireQualityVal int, 
	@tireQualityDesc VARCHAR(50), 
	@tireAxleNoVal int, 
	@tireAxleNoDesc VARCHAR(50), 
	@outDate datetime, 
	@tireBolts varchar(10),
	@tireCap varchar(10), 
	@tireAnnot VARCHAR(50),
	@custmName VARCHAR(100),
	@custlName VARCHAR(100),
	@tirePackageVal VARCHAR(10),
	
	@OV_RETVALUE   VARCHAR(10) OUTPUT  
	 
) 
AS  
  
BEGIN  
		
	IF(NOT EXISTS(SELECT * FROM TBL_TIRE_ORDER_PACKAGE WHERE [tirePackageNo] = @tirePackageNo and isFinished = 0))

	BEGIN
	    INSERT INTO TBL_TIRE_ORDER_PACKAGE(
		[refNo],
		[regNo],
		[custNo],
		[custName],
		[tirePackageNo],
		[qtyTire],
		[tireDimFront],
		[tireDimBack],
		[location],
		[tireTypeVal],
		[tireTypeDesc],
		[tireSpikesVal],
		[tireSpikesDesc],
		[tireRimVal],
		[tireRimDesc],
		[tireBrandVal],
		[tireBrandDesc],
		[tireQualityVal],
		[tireQualityDesc],
		tireAxleNoVal,
		tireAxleNoDesc,
		[regDate],
		[outDate],
		[tireBolts],
		[tireCap], 
		[tireAnnot],
		custmName,
		custlName,
		[isFinished],
		tirePackageVal) 
		values (
		@refNo, 
		@regNo, 
		@custNo, 
		@custName, 
		@tirePackageNo, 
		@qtyTire, 
		@tireDimFront, 
		@tireDimBack, 
		@location, 
		@tireTypeVal, 
		@tireTypeDesc, 
		@tireSpikesVal, 
		@tireSpikesDesc, 
		@tireRimVal,
		@tireRimDesc, 
		@tireBrandVal, 
		@tireBrandDesc, 
		@tireQualityVal, 
		@tireQualityDesc, 
		@tireAxleNoVal, 
		@tireAxleNoDesc, 
		GETDATE(), 
		@outDate, 
		@tireBolts,
		@tireCap, 
		@tireAnnot,
		@custmName,
		@custlName,
		0,
		@tirePackageVal)

		 SET @OV_RETVALUE = 'INSFLG'  


	END
ELSE
	BEGIN
	update TBL_TIRE_ORDER_PACKAGE
	SET
		[refNo] = @refNo,
		[regNo] = @regNo,
		[custNo] = @custNo,
		[custName] = @custName,
		[qtyTire] = @qtyTire,
		[tireDimFront] = @tireDimFront,
		[tireDimBack] = @tireDimBack,
		[location] = @location,
		[tireTypeVal] = @tireTypeVal,
		[tireTypeDesc] = @tireTypeDesc,
		[tireSpikesVal] = @tireSpikesVal,
		[tireSpikesDesc] = @tireSpikesDesc,
		[tireRimVal] = @tireRimVal,
		[tireRimDesc] = @tireRimDesc,
		[tireBrandVal] = @tireBrandVal,
		[tireBrandDesc] = @tireBrandDesc,
		[tireQualityVal] = @tireQualityVal,
		[tireQualityDesc] = @tireQualityDesc,
		tireAxleNoVal = @tireAxleNoVal,
		tireAxleNoDesc = @tireAxleNoDesc,
		[outDate] = @outDate,
		[tireBolts] = @tireBolts,
		[tireCap] = @tireCap, 
		[tireAnnot] = @tireAnnot,
		custmName = @custmName,
		custlName = @custlName
	 WHERE [tirePackageNo] = @tirePackageNo and isFinished = 0
	
	SET @OV_RETVALUE = 'UPDFLG'  
	END
	--ELSE
	--RETURN ERRFLG
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

	
		

END