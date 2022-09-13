/****** Object:  StoredProcedure [dbo].[USP_FETCH_LABEL_COLOR]    Script Date: 20-04-2021 17:09:04 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_LABEL_COLOR]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_LABEL_COLOR]    Script Date: 20-04-2021 17:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	To Fetch Colors configured for each status
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_LABEL_COLOR] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --select * from TBL_WO_ORDER_STATUS -- Changed after adding new Table TBL_APPOINTMENT_COLOR
	select ID_APPOINTMENT_COLOR AS ID_ORDER_STATUS,APPOINTMENT_COLOR_CODE AS ORDER_STATUS_COLOR,APPOINTMENT_COLOR_CODE AS ORDER_STATUS_CODE from TBL_APPOINTMENT_COLOR

	SELECT ID_APPOINTMENT_STATUS,APPOINTMENT_STATUS_CODE,APPOINTMENT_STATUS_COLOR FROM TBL_APPOINTMENT_STATUS

	select * from TBL_WO_ORDER_STATUS
END
GO
