/****** Object:  StoredProcedure [dbo].[USP_MAS_SAVE_TEMPLTE_CONDITION]    Script Date: 22-04-2022 10:51:54 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_MAS_SAVE_TEMPLTE_CONDITION]
GO
/****** Object:  StoredProcedure [dbo].[USP_MAS_SAVE_TEMPLTE_CONDITION]    Script Date: 22-04-2022 10:51:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE Procedure [dbo].[USP_MAS_SAVE_TEMPLTE_CONDITION]
@Template_ID int = NULL,
@Configuration NVARCHAR(MAX)=NULL,
@Condition NVARCHAR(MAX) = NULL,
@FILE_TYPE	varchar(20),
@FILE_NAME	varchar(50),
@TEMPLATE_NAME	varchar(50),
@CHARACTER_SET	varchar(20),
@DECIMAL_DELIMITER	varchar(10),
@THOUSANDS_DELIMITER	varchar(5),
@DATE_FORMAT	varchar(20),
@TIME_FORMAT	varchar(20),
@FILE_MODE	varchar(10),
@DELIMITER	varchar(6),
@DELIMITER_OTHER	varchar(5),
@DESCRIPTION	varchar(100),
@UserID Varchar(20),
@FLF_BL_SPAC BIT,
@BLANK_SPACES INT,
@0V_RETVALUE varchar(20) OUTPUT
AS
BEGIN
	BEGIN TRY       
	BEGIN TRANSACTION
		SET @0V_RETVALUE = NULL
		IF @Template_ID IS NULL
		BEGIN		
			IF(ISNULL((SELECT COUNT(*) FROM TBL_MAS_TEMPLATE_CONFIGURATION WHERE TEMPLATE_NAME = @TEMPLATE_NAME AND [FILE_NAME] =@FILE_NAME AND FILE_TYPE =@FILE_TYPE),0) = 0 )
			BEGIN
				INSERT INTO TBL_MAS_TEMPLATE_CONFIGURATION(FILE_TYPE,[FILE_NAME],TEMPLATE_NAME,CHARACTER_SET,DECIMAL_DELIMITER,THOUSANDS_DELIMITER,DATE_FORMAT,TIME_FORMAT,FILE_MODE,DELIMITER,DELIMITER_OTHER,DESCRIPTION,INSERT_BY,FLG_BL_SPACS,BLAN_SPACS)
					VALUES(@FILE_TYPE,@FILE_NAME,@TEMPLATE_NAME,@CHARACTER_SET,@DECIMAL_DELIMITER,@THOUSANDS_DELIMITER,@DATE_FORMAT,@TIME_FORMAT,@FILE_MODE,@DELIMITER,@DELIMITER_OTHER,@DESCRIPTION,@UserID,@FLF_BL_SPAC,@BLANK_SPACES)
				SET @Template_ID= @@IDENTITY
			END
			ELSE
			BEGIN
				SET @0V_RETVALUE = 'EXISTS'
			END
		END
		ELSE
		BEGIN
			IF((SELECT COUNT(*) FROM TBL_MAS_TEMPLATE_CONFIGURATION WHERE TEMPLATE_NAME = @TEMPLATE_NAME AND [FILE_NAME] =@FILE_NAME AND FILE_TYPE =@FILE_TYPE AND Template_ID <> @Template_ID) = 0 )
			BEGIN	
				UPDATE TBL_MAS_TEMPLATE_CONFIGURATION SET TEMPLATE_NAME=@TEMPLATE_NAME,CHARACTER_SET=@CHARACTER_SET,DECIMAL_DELIMITER=@DECIMAL_DELIMITER,THOUSANDS_DELIMITER=@THOUSANDS_DELIMITER,DATE_FORMAT=@DATE_FORMAT,TIME_FORMAT=@TIME_FORMAT,FILE_MODE=@FILE_MODE,DELIMITER=@DELIMITER,DELIMITER_OTHER=@DELIMITER_OTHER,DESCRIPTION = @DESCRIPTION,UPDATED_BY = @UserId,UPDATE_DATE = getdate(),FLG_BL_SPACS = @FLF_BL_SPAC,BLAN_SPACS = @BLANK_SPACES
					WHERE Template_ID =@Template_ID AND FILE_TYPE=@FILE_TYPE AND [FILE_NAME]=@FILE_NAME
			END
			ELSE
			BEGIN
				SET @0V_RETVALUE = 'EXISTS'
			END
		END
		
		IF @0V_RETVALUE IS NULL
		BEGIN
			--DECLARE @iConfiguration INT

			--DELETE FROM TBL_MAS_FIELD_CONFIGURATION WHERE Template_ID =@Template_ID

			--EXEC SP_XML_PREPAREDOCUMENT @iConfiguration OUTPUT, @Configuration
			
			--INSERT INTO TBL_MAS_FIELD_CONFIGURATION(TEMPLATE_ID,FIELD_ID,POSITION_FROM,FIELD_LENGTH,ORDER_IN_FILE,DECIMAL_DIVIDE,FIXED_VALUE,FIELD_ENCLOSING_CH,AR_VAT_FREE,AR_VAT_PAYING,GL_VAT_FREE,GL_VAT_PAYING,INSERT_BY)
			--SELECT  CASE TEMPLATE_ID WHEN 0 THEN @Template_ID ELSE CAST(TEMPLATE_ID AS INT) END as TEMPLATE_ID,FIELD_ID,
			--		CASE POSITION_FROM WHEN 0 THEN NULL ELSE CAST(POSITION_FROM AS INT) END AS POSITION_FROM,
			--		CASE FIELD_LENGTH WHEN 0 THEN NULL ELSE CAST(FIELD_LENGTH AS INT) END AS FIELD_LENGTH,
			--		CASE ORDER_IN_FILE WHEN 0 THEN NULL ELSE CAST(ORDER_IN_FILE AS INT) END AS ORDER_IN_FILE,
			--		CASE DECIMAL_DIVIDE WHEN 0 THEN NULL ELSE CAST(DECIMAL_DIVIDE AS DECIMAL(3,2)) END AS DECIMAL_DIVIDE,
			--		CASE FIXED_VALUE WHEN '' THEN NULL ELSE FIXED_VALUE END AS FIXED_VALUE,
			--		CASE FIELD_ENCLOSING_CH WHEN '' THEN NULL ELSE FIELD_ENCLOSING_CH END AS FIELD_ENCLOSING_CH,
			--		CASE AR_VAT_FREE WHEN '' THEN NULL ELSE CAST(AR_VAT_FREE AS INT) END AS AR_VAT_FREE,
			--		CASE AR_VAT_PAYING WHEN '' THEN NULL ELSE CAST(AR_VAT_PAYING AS INT) END AS AR_VAT_PAYING,
			--		CASE GL_VAT_FREE WHEN '' THEN NULL ELSE CAST(GL_VAT_FREE AS INT) END AS GL_VAT_FREE,
			--		CASE GL_VAT_PAYING WHEN '' THEN NULL ELSE CAST(GL_VAT_PAYING AS INT) END AS GL_VAT_PAYING,
			--		@UserID AS INSERT_BY  FROM OPENXML (@iConfiguration, '/ROOT/Configuration',1)
			--		WITH(TEMPLATE_ID	int,
			--			FIELD_ID	int,
			--			POSITION_FROM	int,
			--			FIELD_LENGTH	int,
			--			ORDER_IN_FILE	int,
			--			DECIMAL_DIVIDE	FLOAT,
			--			FIXED_VALUE	varchar(50),
			--			FIELD_ENCLOSING_CH varchar(10),
			--			AR_VAT_FREE int,
			--			AR_VAT_PAYING int,
			--			GL_VAT_FREE int,
			--			GL_VAT_PAYING int) 

			--EXEC SP_XML_REMOVEDOCUMENT @iConfiguration

			IF @Condition IS NOT NULL
			BEGIN
				DECLARE @iCondition INT
				DELETE FROM TBL_MAS_FIELD_CONDITIONS WHERE Template_ID =@Template_ID	
				EXEC SP_XML_PREPAREDOCUMENT @iCondition OUTPUT, @Condition
				INSERT INTO TBL_MAS_FIELD_CONDITIONS(TEMPLATE_ID,FIELD_ID,POSITION_FROM,FIELD_LENGTH,ORDER_IN_FILE,CONDITION_VALUE,INSERT_BY)
				SELECT  CASE TEMPLATE_ID WHEN 0 THEN @Template_ID ELSE TEMPLATE_ID END as TEMPLATE_ID,FIELD_ID,
						CASE POSITION_FROM WHEN 0 THEN NULL ELSE POSITION_FROM END AS POSITION_FROM,
						CASE FIELD_LENGTH WHEN 0 THEN NULL ELSE FIELD_LENGTH END AS FIELD_LENGTH,
						CASE ORDER_IN_FILE WHEN 0 THEN NULL ELSE ORDER_IN_FILE END AS ORDER_IN_FILE,
						CASE CONDITION_VALUE WHEN '' THEN NULL ELSE CONDITION_VALUE END AS CONDITION_VALUE,
						
						@UserID AS INSERT_BY  FROM OPENXML (@iCondition, '/ROOT/Condition',1)
						WITH(TEMPLATE_ID	int,
							FIELD_ID	int,
							POSITION_FROM	int,
							FIELD_LENGTH	int,
							ORDER_IN_FILE	int,
							CONDITION_VALUE	varchar(15))
				EXEC SP_XML_REMOVEDOCUMENT @iCondition
			END
		END
		
		COMMIT TRANSACTION      
		
	END TRY       
	BEGIN CATCH            
		IF (XACT_STATE()) = -1            
		BEGIN                 
			ROLLBACK TRANSACTION 
			
			SET @0V_RETVALUE = @@ERROR              
		END;            
		IF (XACT_STATE()) = 1            
		BEGIN             
			COMMIT TRANSACTION              
		END                   
	END CATCH
	

END

GO
