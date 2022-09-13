/****** Object:  StoredProcedure [dbo].[USP_CHECK_CUSTOMER_EXISTS]    Script Date: 15-07-2021 13:47:35 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CHECK_CUSTOMER_EXISTS]
GO
/****** Object:  StoredProcedure [dbo].[USP_CHECK_CUSTOMER_EXISTS]    Script Date: 15-07-2021 13:47:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_CHECK_CUSTOMER_EXISTS]
@CUST_FIRST_NAME VARCHAR(50),
@CUST_LAST_NAME VARCHAR(50),
@IsCOMPANY BIT


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET @CUST_FIRST_NAME='M'
	--SET @CUST_LAST_NAME='O'
	IF @IsCOMPANY = 1
	BEGIN
		SELECT * FROM TBL_MAS_CUSTOMER C WHERE C.CUST_LAST_NAME LIKE  '%' + @CUST_LAST_NAME + '%' AND C.FLG_PRIVATE_COMP=@IsCOMPANY
	END
	ELSE
	BEGIN
		SELECT * FROM TBL_MAS_CUSTOMER C WHERE C.CUST_FIRST_NAME LIKE  '%' + @CUST_FIRST_NAME + '%' AND C.CUST_LAST_NAME LIKE  '%' + @CUST_LAST_NAME + '%' AND C.FLG_PRIVATE_COMP=@IsCOMPANY

	END

END
GO
