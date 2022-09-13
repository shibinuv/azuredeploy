/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_CONFIG_SETTINGS]    Script Date: 20-05-2022 18:53:15 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_MECHANIC_CONFIG_SETTINGS]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_CONFIG_SETTINGS]    Script Date: 20-05-2022 18:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_MECHANIC_CONFIG_SETTINGS] 
	@MECHANIC_NAME varchar(30),
	@MECHANIC_ID varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM TBL_MECHANIC_CONFIG_SETTINGS WHERE (MECHANIC_ID =@MECHANIC_ID AND MECHANIC_NAME=@MECHANIC_NAME  )
END
GO
