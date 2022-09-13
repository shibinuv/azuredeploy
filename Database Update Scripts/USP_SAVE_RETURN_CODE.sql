/****** Object:  StoredProcedure [dbo].[USP_SAVE_RETURN_CODE]    Script Date: 11-03-2022 15:43:15 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SAVE_RETURN_CODE]
GO
/****** Object:  StoredProcedure [dbo].[USP_SAVE_RETURN_CODE]    Script Date: 11-03-2022 15:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Praveen
-- Create date: <Create Date,,>
-- Description:	To Update the Return Code for the spare part returned
-- =============================================
CREATE PROCEDURE [dbo].[USP_SAVE_RETURN_CODE]
@IV_ID_ITEM_DETAILS_RETURN INT,
@IV_RETURN_CODE	VARCHAR(50),
@IV_USERID VARCHAR(50),
@IV_RETVAL VARCHAR(50)='' OUTPUT
AS
BEGIN	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS( SELECT * FROM TBL_MAS_ITEM_DETAILS_RETURN WHERE ID_ITEM_DETAILS_RETURN = @IV_ID_ITEM_DETAILS_RETURN)
	BEGIN
		UPDATE TBL_MAS_ITEM_DETAILS_RETURN
		SET 
		RETURN_CODE = @IV_RETURN_CODE,
		MODIFIED_BY = @IV_USERID,
		DT_MODIFIED = GETDATE()
		WHERE ID_ITEM_DETAILS_RETURN = @IV_ID_ITEM_DETAILS_RETURN

		IF @@ERROR <> 0 	
		   SET @IV_RETVAL = @@ERROR
		 ELSE
		   SET @IV_RETVAL= 'UPDATED'

	END
	ELSE
	BEGIN 
		SET @IV_RETVAL= 'NOT_EXISTS'
	END 


END
GO
