
GO

/****** Object:  StoredProcedure [dbo].[USP_PROCESS_ORDER]    Script Date: 01-03-2021 12:27:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	To Attach an appointment to existing work order 
-- =============================================
CREATE PROCEDURE [dbo].[USP_PROCESS_ORDER] 
	@ID_APPOINTMENT_DETAILS int,
	@ID_WO_NO int,
	@APPOINTMENT_ID int,
	@ID_WO_STATUS varchar(30) = NULL,
	@ID_WO_PREFIX varchar(30) = NULL,
	@ID_JOB int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
	DECLARE @LABEL int
  
	SELECT @LABEL=ID_ORDER_STATUS FROM TBL_WO_ORDER_STATUS WHERE ORDER_STATUS_CODE=@ID_WO_STATUS;
	UPDATE TBL_APPOINTMENTS_HEADER SET LABEL =@LABEL,ID_WO_NO=@ID_WO_NO, WO_STATUS=@ID_WO_STATUS,ID_WO_PREFIX=@ID_WO_PREFIX where APPOINTMENT_ID=@APPOINTMENT_ID
	UPDATE TBL_APPOINTMENT_DETAILS SET ID_WO_NO=@ID_WO_NO,ID_WO_PREFIX=@ID_WO_PREFIX,JOB_STATUS = @ID_WO_STATUS where ID_APPOINTMENT_DETAILS=@ID_APPOINTMENT_DETAILS AND isNull(JOB_STATUS,'') <>'DEL'

END
GO


