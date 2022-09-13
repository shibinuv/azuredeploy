/****** Object:  StoredProcedure [dbo].[USP_UPDATE_ROLE_DETAILS]    Script Date: 21-07-2022 18:55:56 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_UPDATE_ROLE_DETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_UPDATE_ROLE_DETAILS]    Script Date: 21-07-2022 18:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Anuj
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_UPDATE_ROLE_DETAILS]
	 @ID_ROLE INT ,
	 @IV_ID_SCR_START_ROLE INT,
	 @IV_FLG_NBK BIT,
	 @IV_FLG_SPAREPARTORDER BIT,
	 @IV_FLG_ACCOUNTING BIT,
	 @IV_ID_USER varchar(30),
	 @OV_RET_VAL varchar(30) OUTPUT
AS
BEGIN	
	IF EXISTS (SELECT * FROM TBL_MAS_ROLE WHERE ID_ROLE=@ID_ROLE)
	BEGIN
		UPDATE TBL_MAS_ROLE SET 

		ID_SCR_START_ROLE= @IV_ID_SCR_START_ROLE,
		FLG_NBK=@IV_FLG_NBK,
		FLG_ACCOUNTING=@IV_FLG_ACCOUNTING,
		FLG_SPAREPARTORDER=@IV_FLG_SPAREPARTORDER,
		MODIFIED_BY=@IV_ID_USER,
		DT_MODIFIED=GETDATE()

		FROM TBL_MAS_ROLE 
		WHERE ID_ROLE=@ID_ROLE

		SET @OV_RET_VAL= 'UPD'
	END
	ELSE
	BEGIN
		SET @OV_RET_VAL= 'EXT'
	END
	
END
GO
