/****** Object:  StoredProcedure [dbo].[USP_REPPKG_DELETE]    Script Date: 21-02-2022 10:29:53 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_REPPKG_DELETE]
GO
/****** Object:  StoredProcedure [dbo].[USP_REPPKG_DELETE]    Script Date: 21-02-2022 10:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Praveen
-- Create date: <Create Date,,>
-- Description:	Deleting repair package header and lines
-- =============================================
CREATE PROCEDURE [dbo].[USP_REPPKG_DELETE]
@IV_RP_CODE VARCHAR(50),
@IV_USERID VARCHAR(50),
@IV_RP_TYPE VARCHAR(50),  --RP_HEAD \ RP_LINES
@ID_SPARE_SEQ INT = 0,
@OV_RETVALUE VARCHAR(50) ='' OUTPUT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (@IV_RP_TYPE = 'RP_HEAD' AND @ID_SPARE_SEQ = 0)
	BEGIN
		IF EXISTS(SELECT * FROM TBL_MAS_REP_PACKAGE WHERE ID_RP_CODE = @IV_RP_CODE )
		BEGIN
			DELETE TBL_MAS_REP_SPARE_MAPPING
			WHERE ID_RP_CODE = @IV_RP_CODE 

			DELETE TBL_MAS_REP_PACKAGE 
			WHERE ID_RP_CODE = @IV_RP_CODE 
			

			IF @@ERROR <> 0 	
				SET @OV_RETVALUE = @@ERROR
			ELSE
				SET @OV_RETVALUE = 'DELETED'
		
		END
		ELSE
		BEGIN 
			SET @OV_RETVALUE = 'NEXISTS' -- RECORD DOES NOT EXISTS
		END	
	END
	ELSE IF (@IV_RP_TYPE = 'RP_LINES' AND @ID_SPARE_SEQ >0) -- only the lines are deleted 
	BEGIN
		IF EXISTS(SELECT * FROM TBL_MAS_REP_SPARE_MAPPING WHERE ID_RP_CODE = @IV_RP_CODE AND ID_SPARE_SEQ = @ID_SPARE_SEQ  )
		BEGIN
			DELETE TBL_MAS_REP_SPARE_MAPPING 
			WHERE ID_SPARE_SEQ = @ID_SPARE_SEQ AND ID_RP_CODE = @IV_RP_CODE

			IF @@ERROR <> 0 	
				SET @OV_RETVALUE = @@ERROR
			ELSE
				SET @OV_RETVALUE = 'DELETED'
		END
		ELSE
		BEGIN
			SET @OV_RETVALUE = 'NEXISTS' -- RECORD DOES NOT EXISTS
		END
	END
	
END
GO
