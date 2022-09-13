/****** Object:  StoredProcedure [dbo].[USP_FETCH_APPOINTMENT_DETAILS]    Script Date: 30-03-2021 17:32:16 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_APPOINTMENT_DETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_APPOINTMENT_DETAILS]    Script Date: 30-03-2021 17:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	To Fetch Appointment Details for each Appointment Id
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_APPOINTMENT_DETAILS]
	@APPOINTMENT_ID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *,CAST(APPOINTMENT_ID as varchar(20))+' - ' + CAST(ID_APPOINTMENT_DETAILS as varchar(20)) As ID_DISPLAY_DATA FROM TBL_APPOINTMENT_DETAILS where APPOINTMENT_ID=@APPOINTMENT_ID AND isnull(JOB_STATUS,'') NOT IN ('DEL','ONHOLD')
END
GO
