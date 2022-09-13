/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_SETTINGS_FROMDATE]    Script Date: 20-05-2022 18:51:23 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_MECHANIC_SETTINGS_FROMDATE]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_SETTINGS_FROMDATE]    Script Date: 20-05-2022 18:51:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_MECHANIC_SETTINGS_FROMDATE] 
	@MECHANIC_NAME varchar(30) = NULL,
	@FROM_DATE datetime ,
	@ID_LOGIN varchar(30) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @MECHANIC_NAME = ''
	BEGIN
	SELECT * from TBL_MECHANIC_SETTINGS where FROM_DATE >= CONVERT(DATE, @FROM_DATE) 
	END
	SELECT * from TBL_MECHANIC_SETTINGS where FROM_DATE >= CONVERT(DATE, @FROM_DATE)    AND MECHANIC_NAME=@MECHANIC_NAME AND ID_LOGIN=@ID_LOGIN
END
GO
