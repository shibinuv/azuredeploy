/****** Object:  StoredProcedure [dbo].[USP_FETCH_LEAVE_CODES]    Script Date: 06-01-2021 19:50:47 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_LEAVE_CODES]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_LEAVE_CODES]    Script Date: 06-01-2021 19:50:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_LEAVE_CODES] 
	-- Add the parameters for the stored procedure here
	@term varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT LEAVE_CODE,LEAVE_DESCRIPTION,ID_LEAVE_TYPES FROM TBL_MECHANIC_LEAVE_TYPES WHERE LEAVE_CODE like @term +'%'
END

GO
