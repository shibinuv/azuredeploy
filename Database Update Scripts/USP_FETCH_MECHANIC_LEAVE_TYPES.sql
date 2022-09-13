/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:43:17 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_MECHANIC_LEAVE_TYPES]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
	-- Author:		
	-- Create date: 04-12-2020
	-- Description:	 To Fetch Mechanic Leave Types Details
	-- =============================================
	CREATE PROCEDURE [dbo].[USP_FETCH_MECHANIC_LEAVE_TYPES] 
		
	AS
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Insert statements for procedure here
		SELECT * FROM TBL_MECHANIC_LEAVE_TYPES;
	RETURN 
	END
GO
