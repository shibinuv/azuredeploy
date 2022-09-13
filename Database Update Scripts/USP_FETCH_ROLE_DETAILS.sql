/****** Object:  StoredProcedure [dbo].[USP_FETCH_ROLE_DETAILS]    Script Date: 21-07-2022 18:54:27 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_ROLE_DETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_ROLE_DETAILS]    Script Date: 21-07-2022 18:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Anuj
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_ROLE_DETAILS]
	 @ID_ROLE INT  
AS
BEGIN	
	SELECT ID_ROLE,
	ID_SCR_START_ROLE,
	FLG_NBK,
	FLG_SPAREPARTORDER,
	FLG_ACCOUNTING
	FROM TBL_MAS_ROLE 
	WHERE ID_ROLE=@ID_ROLE
END
GO
