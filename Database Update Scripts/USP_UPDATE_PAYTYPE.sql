/****** Object:  StoredProcedure [dbo].[USP_UPDATE_PAYTYPE]    Script Date: 06/07/2016 15:51:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_UPDATE_PAYTYPE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[USP_UPDATE_PAYTYPE]
GO
/****** Object:  StoredProcedure [dbo].[USP_UPDATE_PAYTYPE]    Script Date: 06/07/2016 15:51:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_UPDATE_PAYTYPE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[USP_UPDATE_PAYTYPE]  
(
@ID_SUBSIDERY_INV  INT,          
@ID_DEPT_INV   INT,
@IV_XMLDOC     NTEXT,         
@CREATED_BY    VARCHAR(20),
@OV_RETVAL AS VARCHAR(20) OUTPUT
)             
AS
BEGIN 
	DECLARE @HDOC INT          
	EXEC SP_XML_PREPAREDOCUMENT @HDOC OUTPUT, @IV_XMLDOC  
	DECLARE @TABLE_SETTINGS_TEMP TABLE          
	   (          
		ID_INV_CONFIG INT,      
		ID_SETTINGS VARCHAR(10),      
		INV_INVNOSERIES INT,      
		INV_CRENOSEREIES INT,      
		CREATED_BY VARCHAR(20)      
	   ) 
	INSERT INTO @TABLE_SETTINGS_TEMP         
	   (ID_SETTINGS,INV_INVNOSERIES,INV_CRENOSEREIES)         
	SELECT ID_SETTINGS,INV_INVNOSERIES,INV_CRENOSEREIES         
	   FROM OPENXML (@HDOC,''ROOT/INV'',1)          
	   WITH (        
		 ID_SETTINGS VARCHAR(10),      
		 INV_INVNOSERIES INT,      
		 INV_CRENOSEREIES INT      
		)            
   EXEC SP_XML_REMOVEDOCUMENT @HDOC     

	DECLARE @NEWIDCONFIG AS INT 
	DECLARE @ID_SETT AS INT   
    SET @NEWIDCONFIG = 0    
    
     SELECT @NEWIDCONFIG =  ID_INV_CONFIG  FROM TBL_MAS_INV_CONFIGURATION     
     WHERE     
       ID_SUBSIDERY_INV = @ID_SUBSIDERY_INV     
       AND ID_DEPT_INV = @ID_DEPT_INV     
       AND DT_EFF_TO IS NULL     
      
      SELECT @ID_SETT = ID_SETTINGS FROM @TABLE_SETTINGS_TEMP
      update @TABLE_SETTINGS_TEMP set ID_INV_CONFIG = @NEWIDCONFIG,CREATED_BY = @CREATED_BY  
       
      --SELECT * FROM @TABLE_SETTINGS_TEMP
      --SELECT @NEWIDCONFIG AS ''CONFIG''
      --SELECT @ID_SETT AS ''ID_SETT''
      
     UPDATE CFG 
     SET INV_INVNOSERIES = TEMP.INV_INVNOSERIES , 
     INV_CRENOSEREIES = TEMP.INV_CRENOSEREIES ,
      MODIFIED_BY = NULL,      
      DT_MODIFIED = NULL
      FROM
     TBL_MAS_INV_NUMBER_CFG CFG
     INNER JOIN  @TABLE_SETTINGS_TEMP TEMP
     ON TEMP.ID_INV_CONFIG = CFG.ID_INV_CONFIG  
     WHERE CFG.ID_INV_CONFIG = @NEWIDCONFIG AND CFG.ID_SETTINGS = @ID_SETT
 
     SET @OV_RETVAL = ''UPD''	
       
 
 END' 
END
GO
