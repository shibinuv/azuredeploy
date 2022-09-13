/****** Object:  StoredProcedure [dbo].[USP_DELETE_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:45:46 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_DELETE_MECHANIC_LEAVE_TYPES]
GO
/****** Object:  StoredProcedure [dbo].[USP_DELETE_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
	-- Author:		
	-- Create date: 01-12-2020
	-- Description:	 To Delete Mechanic Leave Types Value
	-- =============================================
	CREATE PROCEDURE [dbo].[USP_DELETE_MECHANIC_LEAVE_TYPES] 
	@ID_LEAVE_TYPES int,
    @RES_OUTPUT Varchar(50)='ERROR' OUTPUT,
	@RES_OUTPUT_CODE Varchar(50)='ERROR' OUTPUT
	AS
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		DECLARE @LEAVE_CODE VARCHAR(50)
		-- Insert statements for procedure here

		IF EXISTS(SELECT LEAVE_CODE FROM TBL_MECHANIC_SETTINGS WHERE ID_LEAVE_TYPES = @ID_LEAVE_TYPES)
		BEGIN
		    SELECT @LEAVE_CODE = LEAVE_CODE FROM TBL_MECHANIC_SETTINGS WHERE ID_LEAVE_TYPES = @ID_LEAVE_TYPES
			SET @RES_OUTPUT_CODE = @LEAVE_CODE
			SET @RES_OUTPUT = 'CODE_USED'		
		END
		ELSE
		BEGIN
			  DELETE FROM TBL_MECHANIC_LEAVE_TYPES
              WHERE ID_LEAVE_TYPES=@ID_LEAVE_TYPES 

			   SET @RES_OUTPUT_CODE = 'DELETED'
			   SET @RES_OUTPUT ='DELETED'
		END			  


	END
GO
