/****** Object:  StoredProcedure [dbo].[USP_TIRE_PACKAGE_FETCH_TP_DETAIL]    Script Date: 01-12-2021 12:42:35 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_TIRE_PACKAGE_FETCH_TP_DETAIL]
GO
/****** Object:  StoredProcedure [dbo].[USP_TIRE_PACKAGE_FETCH_TP_DETAIL]    Script Date: 01-12-2021 12:42:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[USP_TIRE_PACKAGE_FETCH_TP_DETAIL]
(
	@packageNo varchar(30)
)
AS
BEGIN
select refNo, regNo, custNo, tirePackageNo, qtyTire, location, tireTypeVal, tireQualityVal, tireAxleNoVal, tireDimFront, tireDimBack, tireSpikesVal, tireBrandVal, tireBolts, tireCap, tireAnnot, tirePackageVal, outDate, tireRimVal,Seq_No
FROM TBL_TIRE_ORDER_PACKAGE where tirePackageNo = @packageNo and isFinished = 0


 
END

GO
