/****** Object:  StoredProcedure [dbo].[USP_MANAGE_NOTIFICATION]    Script Date: 24-08-2022 19:23:30 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_MANAGE_NOTIFICATION]
GO
/****** Object:  StoredProcedure [dbo].[USP_MANAGE_NOTIFICATION]    Script Date: 24-08-2022 19:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_MANAGE_NOTIFICATION]
	@MODE varchar(20)  NULL, -- Can be FETCH , UPDATE or INSERT based on the user requirement
	@Iv_IdNotification int NULL,
	@Iv_IsNotification bit NULL,
	@Iv_NotificationMessage varchar(max) NULL,
	@Iv_WO_NO varchar(50) NULL,
	@Iv_WO_PREFIX varchar(50) NULL,
	@Iv_WO_JOB_NO varchar(50) NULL,
	@Iv_MessageText varchar(max) NULL,
	@Iv_User varchar(100) NULL
	--@Ov_RetVal varchar(10) OUTPUT 
AS
BEGIN
	--SET @Ov_RetVal = 0
   IF (@MODE = 'FETCH')
   BEGIN 
		SELECT IdNotification,IsNotification,CreatedDate FROM TBL_CONFIG_NOTIFICATION
   END
   ELSE IF (@MODE ='UPDATE')
   BEGIN
		IF EXISTS (SELECT *  FROM TBL_CONFIG_NOTIFICATION WHERE IdNotification = @Iv_IdNotification)
		BEGIN
			UPDATE TBL_CONFIG_NOTIFICATION SET 
			IsNotification = @Iv_IsNotification , 
			ModifiedBy = @Iv_User, 
			ModifiedDate = GETDATE() 
			WHERE IdNotification = @Iv_IdNotification

			--IF @@ERROR <> 0                         
			--BEGIN       
			--	SET @Ov_RetVal = @@ERROR                     
			--END 
		END
   END
   ELSE IF (@MODE ='INSERT')
   BEGIN
		INSERT INTO TBL_CONFIG_NOTIFICATION (
		NotificationMessage,
		NotificationType,
		IsNotification,
		WO_NO,
		WO_PREFIX,
		WO_JOB_NO,
		CreatedBy,
		CreatedDate
		)
		VALUES (
		@Iv_NotificationMessage,
		1,
		0,
		@Iv_WO_NO,
		@Iv_WO_PREFIX,
		@Iv_WO_JOB_NO,
		@Iv_User,
		GETDATE()
		)

		EXEC [USP_SAVE_WO_TEXTLINES] @ID_WO_NO= @Iv_WO_NO,@ID_WO_PREFIX=@Iv_WO_PREFIX,@ID_USER=@Iv_User,@MESSAGE=@Iv_MessageText

		--IF @@ERROR <> 0                         
		--BEGIN       
		--	SET @Ov_RetVal = @@ERROR                     
		--END 
   END

END
GO
