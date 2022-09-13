/****** Object:  StoredProcedure [dbo].[USP_UPD_RETURN_ORDERS]    Script Date: 11-03-2022 15:38:47 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_UPD_RETURN_ORDERS]
GO
/****** Object:  StoredProcedure [dbo].[USP_UPD_RETURN_ORDERS]    Script Date: 11-03-2022 15:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Praveen
-- Create date: <Create Date,,>
-- Description:	To Update the Annotation,Status update of the Spares in ReturnOrder
-- =============================================
CREATE PROCEDURE [dbo].[USP_UPD_RETURN_ORDERS]
@IV_RETURN_NO INT,
@IV_USERID VARCHAR(50),
@IV_ANNOTATION VARCHAR(200)= '',
@IV_ISCREDITED BIT=0,
@OV_RETVAL VARCHAR(50)='' OUTPUT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS(SELECT * FROM TBL_MAS_ITEM_HEADER_RETURN WHERE ID_RETURN_NUM = @IV_RETURN_NO)
	BEGIN
		UPDATE TBL_MAS_ITEM_HEADER_RETURN
		SET ANNOTATION = @IV_ANNOTATION,
			MODIFIED_BY = @IV_USERID,
			DT_MODIFIED = GETDATE()			
		WHERE ID_RETURN_NUM = @IV_RETURN_NO		

		IF @IV_ISCREDITED = 1
		BEGIN
			UPDATE TBL_MAS_ITEM_HEADER_RETURN
			SET  			
			IS_CREDITED = @IV_ISCREDITED,
			DT_CREDITED =  GETDATE() ,
			RETURN_STATUS = 'CREDITED',
			MODIFIED_BY = @IV_USERID,
			DT_MODIFIED = GETDATE()
			WHERE ID_RETURN_NUM = @IV_RETURN_NO		
		END
		
		IF @@ERROR <> 0 	
			SET @OV_RETVAL = @@ERROR
		ELSE
			SET @OV_RETVAL = 'UPDATED'

	END
	ELSE
	BEGIN 
		SET @OV_RETVAL = 'NOT_EXISTS'
	END 

 
END
GO
