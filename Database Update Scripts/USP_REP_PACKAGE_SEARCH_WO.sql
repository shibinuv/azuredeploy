/****** Object:  StoredProcedure [dbo].[USP_REP_PACKAGE_SEARCH_WO]    Script Date: 24-02-2022 10:36:32 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_REP_PACKAGE_SEARCH_WO]
GO
/****** Object:  StoredProcedure [dbo].[USP_REP_PACKAGE_SEARCH_WO]    Script Date: 24-02-2022 10:36:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================================
-- Author:		Anuj Dahal
-- Create date: 18-02-2022
-- Description:	To Search the RepairPackage from WOJobDetails Page
-- ===============================================================
CREATE PROCEDURE [dbo].[USP_REP_PACKAGE_SEARCH_WO] 

 @ID_SEARCH AS VARCHAR(50),
 @USER AS VARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	ID_RPKG_SEQ,
	ID_RP_CODE,
	RP_DESC,
	ID_MAKE_RP,
	OPERATION_CODE,
	JOB_CLASS,
	FLG_FIX_PRICE,
	FLG_GM_PRICE_CHNG 
	FROM TBL_MAS_REP_PACKAGE 
	WHERE ID_RP_CODE  LIKE '%'+@ID_SEARCH+'%' OR RP_DESC LIKE '%'+@ID_SEARCH+'%' OR RP_JOB_TEXT  LIKE '%'+@ID_SEARCH+'%'

END
GO
