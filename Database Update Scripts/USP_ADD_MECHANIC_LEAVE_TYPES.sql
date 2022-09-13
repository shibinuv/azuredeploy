/****** Object:  StoredProcedure [dbo].[USP_ADD_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:44:34 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_ADD_MECHANIC_LEAVE_TYPES]
GO
/****** Object:  StoredProcedure [dbo].[USP_ADD_MECHANIC_LEAVE_TYPES]    Script Date: 06-01-2021 19:44:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
	-- Author:		
	-- Create date: 04-12-2020
	-- Description:	 To Add Mechanic Leave Types Details
	-- =============================================
	CREATE PROCEDURE [dbo].[USP_ADD_MECHANIC_LEAVE_TYPES] 
	@LEAVE_CODE varchar(20),
    @LEAVE_DESCRIPTION varchar(50),
    @APPROVE_CODE varchar(20),
	@CREATED_BY varchar(20),
	@RES_OUTPUT Varchar(50)='ERROR' OUTPUT
	
	AS
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Insert statements for procedure here

		IF EXISTS(SELECT ID_LEAVE_TYPES FROM TBL_MECHANIC_LEAVE_TYPES WHERE LEAVE_CODE = @LEAVE_CODE )
		BEGIN
			SET @RES_OUTPUT='CODE_EXISTS'
		END
		ELSE
		BEGIN
			INSERT INTO TBL_MECHANIC_LEAVE_TYPES
              (LEAVE_CODE, LEAVE_DESCRIPTION, APPROVE_CODE,CREATED_BY,DT_CREATED)
			VALUES
              (@LEAVE_CODE, @LEAVE_DESCRIPTION, @APPROVE_CODE,@CREATED_BY,GETDATE()) 

			  SET @RES_OUTPUT='INSERTED'
		END
		
	END
GO
