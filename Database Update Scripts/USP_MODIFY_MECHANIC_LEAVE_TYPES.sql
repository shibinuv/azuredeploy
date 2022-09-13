/****** Object:  StoredProcedure [dbo].[USP_MODIFY_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:47:09 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_MODIFY_MECHANIC_LEAVE_TYPES]
GO
/****** Object:  StoredProcedure [dbo].[USP_MODIFY_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:47:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
	-- Author:		
	-- Create date: 04-12-2020
	-- Description:	 To Modify Mechanic Leave Types Details
	-- =============================================
	CREATE PROCEDURE [dbo].[USP_MODIFY_MECHANIC_LEAVE_TYPES]
	@ID_LEAVE_TYPES int,
	@LEAVE_CODE varchar(20),
    @LEAVE_DESCRIPTION varchar(50),
    @APPROVE_CODE varchar(20),
	@MODIFIED_BY varchar(20)
	
	AS
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Insert statements for procedure here
		 Update TBL_MECHANIC_LEAVE_TYPES
    SET         LEAVE_CODE = COALESCE(@LEAVE_CODE,LEAVE_CODE),
                LEAVE_DESCRIPTION = COALESCE(@LEAVE_DESCRIPTION,LEAVE_DESCRIPTION),
                APPROVE_CODE = COALESCE(@APPROVE_CODE,APPROVE_CODE),
				MODIFIED_BY = COALESCE(@MODIFIED_BY,MODIFIED_BY),
				DT_MODIFIED = GETDATE()

    Where       ID_LEAVE_TYPES = COALESCE(@ID_LEAVE_TYPES,ID_LEAVE_TYPES)
	END
GO
