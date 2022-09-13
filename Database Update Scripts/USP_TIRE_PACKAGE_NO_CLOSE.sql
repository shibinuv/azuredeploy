USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_TIRE_PACKAGE_NO_CLOSE]    Script Date: 07.12.2021 09:59:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  
ALTER PROCEDURE [dbo].[USP_TIRE_PACKAGE_NO_CLOSE]  
(  
	@packageNo VARCHAR(50) /*CURRENT USER WHO CREATES*/
) 
AS  
  
BEGIN  
		
	IF(EXISTS(SELECT * FROM TBL_TIRE_ORDER_PACKAGE WHERE [tirePackageNo] = @packageNo and isFinished = 0))

	BEGIN
	
	update TBL_TIRE_ORDER_PACKAGE
	SET
		isFinished = 1
	 WHERE [tirePackageNo] = @packageNo and isFinished = 0
	 UPDATE TBL_TIRE_PACKAGE_DEPTH
		SET CLOSED = 1
		WHERE TIRE_PACKAGE_NO = @packageNo AND CLOSED = 0
	END
	--BEGIN
	--	UPDATE TBL_TIRE_PACKAGE_DEPTH
	--	SET CLOSED = 1
	--	WHERE TIRE_PACKAGE_NO = @packageNo AND CLOSED = 0
	--END
END