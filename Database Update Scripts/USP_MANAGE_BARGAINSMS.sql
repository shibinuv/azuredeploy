/****** Object:  StoredProcedure [dbo].[USP_MANAGE_BARGAINSMS]    Script Date: 24-08-2022 19:26:38 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_MANAGE_BARGAINSMS]
GO
/****** Object:  StoredProcedure [dbo].[USP_MANAGE_BARGAINSMS]    Script Date: 24-08-2022 19:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_MANAGE_BARGAINSMS]
	@MODE varchar(20)  NULL, -- Can be FETCH , UPDATE or INSERT based on the user requirement
	@Iv_IdBargain varchar(max) NULL,
	@Iv_IsAccepted bit NULL,
	@Iv_WO_NO varchar(50) NULL,
	@Iv_WO_PREFIX varchar(50) NULL,
	@Iv_WO_JOB_NO int NULL,
	@Iv_User varchar(100) NULL
	--@Ov_RetVal varchar(10) OUTPUT 
AS
BEGIN
	--SET @Ov_RetVal = 0
   IF (@MODE = 'FETCH')
   BEGIN 
		SELECT BargainId,WO_NO,WO_PREFIX,IsAccepted,CreatedDate FROM TBL_BARGAIN_SMS_DETAILS where IsAccepted <> 1
   END
   ELSE IF (@MODE ='UPDATE')
   BEGIN
		IF EXISTS (SELECT *  FROM TBL_BARGAIN_SMS_DETAILS WHERE BargainId = @Iv_IdBargain)
		BEGIN
			UPDATE TBL_BARGAIN_SMS_DETAILS SET 
			IsAccepted = @Iv_IsAccepted , 
			ModifiedBy = @Iv_User, 
			ModifiedDate = GETDATE() 
			WHERE  BargainId = @Iv_IdBargain

			SELECT ID_SMS_DETAILS,WO_NO,WO_PREFIX,IsAccepted,CreatedDate FROM TBL_BARGAIN_SMS_DETAILS where IsAccepted <> 1
			--IF @@ERROR <> 0                         
			--BEGIN       
			--	SET @Ov_RetVal = @@ERROR                     
			--END 
		END
   END
   ELSE IF (@MODE ='INSERT')
   BEGIN
		INSERT INTO TBL_BARGAIN_SMS_DETAILS (
		BargainId,
		IsAccepted,
		WO_NO,
		WO_PREFIX,
		WO_JOB_NO,
		CreatedBy,
		CreatedDate
		)
		VALUES (
		@Iv_IdBargain,
		0,
		@Iv_WO_NO,
		@Iv_WO_PREFIX,
		@Iv_WO_JOB_NO,
		@Iv_User,
		GETDATE()
		)

		SELECT ID_SMS_DETAILS,WO_NO,WO_PREFIX,IsAccepted,CreatedDate FROM TBL_BARGAIN_SMS_DETAILS where IsAccepted <> 1
		--IF @@ERROR <> 0                         
		--BEGIN       
		--	SET @Ov_RetVal = @@ERROR                     
		--END 
   END

END
GO
