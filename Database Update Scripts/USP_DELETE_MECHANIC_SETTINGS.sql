/****** Object:  StoredProcedure [dbo].[USP_DELETE_MECHANIC_SETTINGS]    Script Date: 06-01-2021 19:55:26 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_DELETE_MECHANIC_SETTINGS]
GO
/****** Object:  StoredProcedure [dbo].[USP_DELETE_MECHANIC_SETTINGS]    Script Date: 06-01-2021 19:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_DELETE_MECHANIC_SETTINGS] 
	@ID_MECHANIC_SETTINGS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM TBL_MECHANIC_SETTINGS WHERE ID_MECHANIC_SETTINGS=@ID_MECHANIC_SETTINGS
END
GO
