/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ROLE_DELETE]    Script Date: 21-07-2022 18:47:54 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CONFIG_ROLE_DELETE]
GO
/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ROLE_DELETE]    Script Date: 21-07-2022 18:47:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** Application: MSG *************************************************************  
* Module : User Roles 
* File name : USP_CONFIG_ROLE_DELETE.prc  
* Purpose : 
* Author : Narayana Rao 
* Date  : 27.10.2006
*********************************************************************************************************************/  
/*********************************************************************************************************************    
I/P : -- Input Parameters  
O/P : -- Output Parameters  
Error Code  
Description  
INT.VerNO : NOV21.0 
********************************************************************************************************************/  
--'*********************************************************************************'*********************************  
--'* Modified History :     
--'* S.No  RFC No/Bug ID   Date        Author  Description   
--*#0001#   
--'*********************************************************************************'*********************************  


CREATE PROCEDURE [dbo].[USP_CONFIG_ROLE_DELETE]
(
	 @iv_xmlDoc     NTEXT,           --varchar(7000),
	 @ov_RetValue	varchar(20) output,
	 @ov_CntDelete  varchar(2000) output,
	 @ov_DeletedCfg varchar(2000) output
)
AS
BEGIN
	DECLARE @HDOC INT
	DECLARE @CONFIGLISTCND AS VARCHAR(2000)
	DECLARE @CFGLSTDELETED AS VARCHAR(2000)
    set @CONFIGLISTCND=''
	set @CFGLSTDELETED=''
	EXEC SP_XML_PREPAREDOCUMENT @HDOC OUTPUT, @iv_xmlDoc

	DECLARE @TABLE_ROLE_TEMP TABLE
		(
			ID_ROLE		VARCHAR(10),
			NM_ROLE		VARCHAR(50),
			DELETEFLAG	Bit		
		)
	BEGIN TRAN
	INSERT INTO @TABLE_ROLE_TEMP  
		(
			ID_ROLE	,
			NM_ROLE,		
			DELETEFLAG
		)
	SELECT ID_ROLE,NM_ROLE,'' 
	FROM OPENXML (@HDOC,'/ROOT/ROLE',2)
	WITH (ID_ROLE VARCHAR(10),NM_ROLE VARCHAR(20))

	SELECT * FROM @TABLE_ROLE_TEMP

	UPDATE @TABLE_ROLE_TEMP
	SET DELETEFLAG = 1
	WHERE ID_ROLE IN (	SELECT ID_ROLE_USER 
						FROM TBL_MAS_USERS	
					)
	SELECT ID_ROLE FROM @TABLE_ROLE_TEMP WHERE DELETEFLAG<>1
	set @ov_RetValue=0

	DELETE FROM TBL_MAS_ROLE_ACCESS WHERE ID_ROLE_ACCESS IN (SELECT ID_ROLE FROM @TABLE_ROLE_TEMP WHERE DELETEFLAG<>1)
	DELETE FROM TBL_MAS_ROLE WHERE ID_ROLE IN(SELECT ID_ROLE FROM @TABLE_ROLE_TEMP WHERE DELETEFLAG<>1) 

	IF @@eRROR = 0 
		 BEGIN	
			 SET @ov_RetValue = 'DEL'	
			COMMIT TRAN
		END
	ELSE
		BEGIN	
			SET @ov_RetValue = @@ERROR	
			 ROLLBACK TRAN
		END
	-- To fetch the records which cannot be deleted 
	-- ********************************************
		-- Modified Date : 4th September 2008
		-- Bug Id		 : 3402
	--SELECT  @CONFIGLISTCND = ISNULL(@CONFIGLISTCND + '; ' + NM_ROLE,ID_ROLE)
	SELECT  @CONFIGLISTCND = ISNULL(@CONFIGLISTCND + ', ' + NM_ROLE,ID_ROLE)
	-- ************* End Of Modification *********
	FROM    @TABLE_ROLE_TEMP WHERE DELETEFLAG = 1

	-- To fetch the records which can be deleted 
	-- ********************************************
		-- Modified Date : 4th September 2008
		-- Bug Id		 : 3402
	--SELECT  @CFGLSTDELETED = ISNULL(@CFGLSTDELETED + '; ' + NM_ROLE,ID_ROLE)
	  SELECT  @CFGLSTDELETED = ISNULL(@CFGLSTDELETED + ', ' + NM_ROLE,ID_ROLE)
	-- ************* End Of Modification *********
	FROM    @TABLE_ROLE_TEMP WHERE DELETEFLAG=0

	select @OV_CNTDELETE   =  @CONFIGLISTCND
	select @OV_DELETEDCFG  =  @CFGLSTDELETED
	
	EXEC SP_XML_REMOVEDOCUMENT @HDOC
END

/**

	
DEclarE  @ov_RetValue as	varchar(20) 
DEclarE @ov_CntDelete  as varchar(2000) 
DEclarE @ov_DeletedCfg as varchar(2000) 

EXEC USP_CONFIG_ROLE_DELETE  '<ROOT><ROLE><ID_ROLE>81</ID_ROLE><NM_ROLE>mek</NM_ROLE></ROLE></ROOT>',
	@ov_RetValue output,
	@ov_CntDelete output,
	@ov_DeletedCfg output

SELECT @ov_CntDelete
SELECT @ov_DeletedCfg 
SELECT @ov_RetValue



EXEC USP_CONFIG_ROLE_DELETE '<ROOT><ROLE><ID_ROLE>2</ID_ROLE><NM_ROLE>RAJA</NM_ROLE></ROLE>
<ROLE><ID_ROLE>53</ID_ROLE><NM_ROLE>RAJA</NM_ROLE></ROLE>
</ROOT>', @ov_RetValue,@ov_CntDelete ,@ov_DeletedCfg 
SELECT @ov_CntDelete
SELECT @ov_DeletedCfg 
select * from TBL_MAS_ROLE




exec USP_CONFIG_ROLE_DELETE
'<ROOT><ROLE><ID_ROLE>32</ID_ROLE><NM_ROLE>harikrishna</NM_ROLE></ROLE></ROOT>','','',''


**/



--select * from tbl_mas_customer











GO
