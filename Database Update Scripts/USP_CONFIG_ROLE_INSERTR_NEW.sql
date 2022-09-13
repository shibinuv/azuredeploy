/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ROLE_INSERTR_NEW]    Script Date: 21-07-2022 18:49:39 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CONFIG_ROLE_INSERTR_NEW]
GO
/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ROLE_INSERTR_NEW]    Script Date: 21-07-2022 18:49:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[USP_CONFIG_ROLE_INSERTR_NEW]
(
		@IV_NM_ROLE					VARCHAR(50) ,
		@IV_ID_SUBSIDERY_ROLE		 INT,
		@IV_ID_DEPT_ROLE			INT,
		@IV_ID_SCR_START_ROLE       INT,
		@IV_FLG_SYSADMIN			BIT,
		@IV_FLG_SUBSIDADMIN			BIT,
		@IV_FLG_DEPTADMIN			BIT,
		@IV_USERID					VARCHAR(20),
		@IV_STATUS					VARCHAR(20) OUTPUT,
		@IV_FLG_NBK					BIT,
		@IV_FLG_ACCOUNTING			BIT,
		@IV_FLG_SPAREPARTORDER		BIT,
		@IV_ROLE_ID					INT OUTPUT
)

AS
BEGIN 
	DECLARE @COUNT INT
	DECLARE @COUNTD INT
	DECLARE @COUNTS INT
	DECLARE @SUB INT
	DECLARE @DEP INT
	
	SET		@COUNT =0
	SET		@COUNTD =0
	SET		@COUNTS =0

	SELECT 
			@COUNT=COUNT(*) 
	FROM 
			TBL_MAS_ROLE
	WHERE
			ID_DEPT_ROLE		=@IV_ID_DEPT_ROLE		AND  
			ID_SUBSIDERY_ROLE	=@IV_ID_SUBSIDERY_ROLE	AND 
			NM_ROLE	=@IV_NM_ROLE
	
	 
	IF	@IV_ID_SUBSIDERY_ROLE=0
	BEGIN
		SET @SUB=NULL
		SELECT 
			@COUNTS=COUNT(*) 
		FROM 
			TBL_MAS_ROLE
		WHERE
			ID_SUBSIDERY_ROLE	IS NULL	AND 
			NM_ROLE	=@IV_NM_ROLE
	END 
	ELSE
		SET @SUB=@IV_ID_SUBSIDERY_ROLE
		IF @IV_ID_DEPT_ROLE=0
		BEGIN
		SET @DEP=NULL
		SELECT 
			@COUNTD=COUNT(*) 
		FROM 
			TBL_MAS_ROLE
		WHERE
			ID_SUBSIDERY_ROLE	=@SUB	AND 
			NM_ROLE	=@IV_NM_ROLE
		END
	ELSE
		SET @DEP=@IV_ID_DEPT_ROLE

	IF @COUNT>0 OR @COUNTD>0 OR @COUNTS>0
	BEGIN
		SET @IV_STATUS='EXITS'
		SET @IV_ROLE_ID=0
		PRINT @IV_STATUS
		RETURN
	END


			INSERT INTO TBL_MAS_ROLE
					(
						NM_ROLE,
						ID_SUBSIDERY_ROLE,
						ID_DEPT_ROLE,
						ID_SCR_START_ROLE,
						FLG_SYSADMIN,
						FLG_SUBSIDADMIN,
						FLG_DEPTADMIN,
						CREATED_BY,
						DT_CREATED,
						FLG_NBK,
						FLG_ACCOUNTING,
						FLG_SPAREPARTORDER
					)
			VALUES
					(	
						@IV_NM_ROLE	,				
						@SUB,		
						@DEP,			
						@IV_ID_SCR_START_ROLE ,      
						@IV_FLG_SYSADMIN,			
						@IV_FLG_SUBSIDADMIN	,		
						@IV_FLG_DEPTADMIN,			
						@IV_USERID,	
						GETDATE(),
						@IV_FLG_NBK,
						@IV_FLG_ACCOUNTING,
						@IV_FLG_SPAREPARTORDER
					 )
		SET @IV_ROLE_ID=@@IDENTITY
		SET @IV_STATUS='OK'

		PRINT @IV_STATUS
END
GO
