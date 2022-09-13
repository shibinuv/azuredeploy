USE [CARSDEV]
GO

/****** Object:  StoredProcedure [dbo].[USP_FETCH_CUSTOMER_ACTIVITIES]    Script Date: 12.06.2019 15:20:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_CUSTOMER_ACTIVITIES]
	@CUST_ID VARCHAR(10)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM TBL_MAS_CUSTOMER_ACTIVITY
	WHERE CUSTOMER_ID = @CUST_ID
END
GO

