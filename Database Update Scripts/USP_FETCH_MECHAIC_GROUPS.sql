/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHAIC_GROUPS]    Script Date: 27-04-2021 12:02:00 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_MECHAIC_GROUPS]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHAIC_GROUPS]    Script Date: 27-04-2021 12:02:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_MECHAIC_GROUPS]
	
AS
BEGIN
	
SELECT * FROM TBL_MECHANIC_GROUP
END
GO
