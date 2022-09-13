/****** Object:  StoredProcedure [dbo].[USP_ADD_MECHANIC_SETTINGS]    Script Date: 06-01-2021 19:53:07 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_ADD_MECHANIC_SETTINGS]
GO
/****** Object:  StoredProcedure [dbo].[USP_ADD_MECHANIC_SETTINGS]    Script Date: 06-01-2021 19:53:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[USP_ADD_MECHANIC_SETTINGS]
	@ID_MECHANIC_SETTINGS int ,
	@ID_LOGIN varchar(20) NULL,
	@MECHANIC_NAME varchar(30) NULL,
	@FROM_DATE datetime NULL,
	@FROM_TIME datetime NULL,
	@TO_DATE datetime NULL,
	@TO_TIME datetime NULL,
	@LEAVE_CODE varchar(20) NULL,
	@LEAVE_REASON varchar(50) NULL,
	@COMMENTS varchar(60) NULL,
	@CREATED_BY varchar(30) NULL,
	@MODIFIED_BY varchar(30) NULL,
	@ID_LEAVE_TYPES int NULL
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select @ID_LEAVE_TYPES = ID_LEAVE_TYPES from TBL_MECHANIC_LEAVE_TYPES WHERE LEAVE_CODE = @LEAVE_CODE   

	if(@ID_MECHANIC_SETTINGS >0)
	BEGIN
	 update TBL_MECHANIC_SETTINGS 
	 set 
	   FROM_DATE = @FROM_DATE,
	   FROM_TIME = @FROM_TIME,
	   TO_DATE = @TO_DATE,
	   TO_TIME = @TO_TIME,
	   LEAVE_CODE = @LEAVE_CODE,
	   LEAVE_REASON = @LEAVE_REASON,
	   COMMENTS = @COMMENTS,
	   MECHANIC_NAME = MECHANIC_NAME,
	   ID_LOGIN = @ID_LOGIN,
	   MODIFIED_BY = @MODIFIED_BY,
	   DT_MODIFIED=GETDATE(),
	   ID_LEAVE_TYPES=@ID_LEAVE_TYPES
	   where ID_MECHANIC_SETTINGS = @ID_MECHANIC_SETTINGS
	END
	ELSE
	BEGIN
    -- Insert statements for procedure here
	INSERT INTO TBL_MECHANIC_SETTINGS(FROM_DATE,FROM_TIME,TO_DATE,TO_TIME,LEAVE_CODE,LEAVE_REASON,COMMENTS,MECHANIC_NAME,ID_LOGIN,CREATED_BY,DT_CREATED,ID_LEAVE_TYPES) 
            VALUES  (@FROM_DATE, @FROM_TIME, @TO_DATE,@TO_TIME,@LEAVE_CODE,@LEAVE_REASON,@COMMENTS,@MECHANIC_NAME,@ID_LOGIN,@CREATED_BY, GETDATE(),@ID_LEAVE_TYPES)
	END

END
GO
