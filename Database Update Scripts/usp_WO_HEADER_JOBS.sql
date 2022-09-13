/****** Object:  StoredProcedure [dbo].[usp_WO_HEADER_JOBS]    Script Date: 07-10-2021 20:05:38 ******/
DROP PROCEDURE IF EXISTS [dbo].[usp_WO_HEADER_JOBS]
GO
/****** Object:  StoredProcedure [dbo].[usp_WO_HEADER_JOBS]    Script Date: 07-10-2021 20:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC USP_WO_HEADER_JOBS '438','WOW','admin'    
        
/*************************************** Application: MSG *************************************************************            
* Module : Transactions            
* File name : usp_WO_HEADER_JOBS.PRC            
* Purpose : To Load Work Order Job Information.             
* Author : M.Thiyagarajan.            
* Date  : 31.07.2006            
*********************************************************************************************************************/            
/*********************************************************************************************************************              
I/P : -- Input Parameters            
O/P : -- Output Parameters            
Error Code            
Description    INT.VerNO : NOV21.0          
********************************************************************************************************************/            
--'*********************************************************************************'*********************************            
--'* Modified History :               
--'* S.No  RFC No/Bug ID   Date        Author  Description             
--*#0001#            
--'*********************************************************************************'*********************************            
 --Declare @iv_ID_WO_NO varchar(10)   
 --set @iv_ID_WO_NO= '10001'                          
 --case when charindex('';'',dbo.fnGetInvoiceNos(WOH.WO_NUMBER))>0 as  
/*********************Begin of Modification******************      
                'Modified Date : 17-May-2008      
                'Description   :  Fixed Price       
                'Bug           : 2-4-59;2466      
                chkFixedPrice_Checked()      
                'Change End  */            
--  IF @iv_DICOUNT_BASE = 'GAMT'                  
--   SET @iv_SQL = @iv_SQL + '((WO_TOT_LAB_AMT + WO_TOT_SPARE_AMT + WO_TOT_GM_AMT) - WO_TOT_DISC_AMT ) + WO_TOT_VAT_AMT AS JOB_AMT'                  
--  ELSE                  
--   SET @iv_SQL = @iv_SQL + '(WO_TOT_LAB_AMT + WO_TOT_SPARE_AMT + WO_TOT_GM_AMT) + WO_TOT_VAT_AMT - WO_TOT_DISC_AMT AS JOB_AMT'                  
-- END    
--Bug ID:_ SS2_24  
		--Date :- 24-july-2008  
		--Desc :-4-Missing_Functions_SS1&SS2.doc, Should come with IN-VAT and EX-Vat 

		/*  
		Modified Date : 24-July-2008      
		Description   : To display Job Status   
		*/ 

 --bUG id :- System text for Data, Date 12-May-2009, Original on 11-May-2009, Commented portion moved to Top

CREATE PROCEDURE [dbo].[usp_WO_HEADER_JOBS]            
(                  
 @iv_ID_WO_NO varchar(10),                  
 @iv_ID_PR_NO varchar(3) ,        
 @iv_UserID   varchar(20),
 @IV_Lang VARCHAR(30)='ENGLISH'                 
)                  
AS                  
BEGIN              

		BEGIN TRY

		DECLARE @LANG INT  
		SELECT @LANG=ID_LANG FROM TBL_MAS_LANGUAGE WHERE LANG_NAME=@iv_Lang

		DECLARE @INV AS VARCHAR(20)
		SELECT @INV=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_INV' AND ISDATA=1

		DECLARE @DEL AS VARCHAR(20)
		SELECT @DEL=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_DEL' AND ISDATA=1

		DECLARE @RES AS VARCHAR(20)
		SELECT @RES=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_RES' AND ISDATA=1

		DECLARE @PINV AS VARCHAR(20)
		SELECT @PINV=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_PINV' AND ISDATA=1

		DECLARE @BAR AS VARCHAR(20)
		SELECT @BAR=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_BAR' AND ISDATA=1

		DECLARE @CSA AS VARCHAR(20)
		SELECT @CSA=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_CSA' AND ISDATA=1

		DECLARE @JST AS VARCHAR(20)
		SELECT @JST=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_JST' AND ISDATA=1

		DECLARE @RINV AS VARCHAR(20)
		SELECT @RINV=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_RINV' AND ISDATA=1

		DECLARE @JCD AS VARCHAR(20)
		SELECT @JCD=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_JCD' AND ISDATA=1
		
		DECLARE @RWRK AS VARCHAR(20)
		SELECT @RWRK=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_RWRK' AND ISDATA=1

		DECLARE @STR AS VARCHAR(20)
		SELECT @STR=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_STR' AND ISDATA=1
		
		DECLARE @CON AS VARCHAR(20)
		SELECT @CON=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_CON' AND ISDATA=1
		           
		DECLARE @iv_DICOUNT_BASE VARCHAR(10)                  
		DECLARE @iv_SQL VARCHAR(2000)                  
		DECLARE @iv_JODID INT  
		             
		---Getting the Discount Calculation from config settings                  
		SELECT @iv_DICOUNT_BASE = WO_DISCOUNT_BASE FROM TBL_MAS_WO_CONFIGURATION                   
		WHERE GETDATE() BETWEEN DT_EFF_FROM AND DT_EFF_TO                  
		---FETCHING AND CALCULATING JOB DETAILS                  
		           
			SET @iv_SQL = ''                  
			SET @iv_SQL = 'SELECT ID_JOB,WO_JOB_TXT,'''' STATUS,'        
			SET @iv_SQL = @iv_SQL +'dbo.USP_FN_RecalcHPPrice('+ ''''+ @iv_UserID +'''' + ','+ ''''+ @iv_ID_WO_NO +'''' + ','          
			SET @iv_SQL = @iv_SQL + ''''+ @iv_ID_PR_NO +''''+',ID_JOB,' + Cast(@LANG as VARCHAR(10)) + ') AS HPFlag,'                 
			SET @iv_SQL = @iv_SQL + 'case when charindex('';'',dbo.fn_WO_DEBITOR (ID_JOB,'                  
			SET @iv_SQL = @iv_SQL + ''''+ @iv_ID_WO_NO +'''' + ','                  
			SET @iv_SQL = @iv_SQL + ''''+ @iv_ID_PR_NO +'''' + ')) > 0 then                  
			substring(Isnull(dbo.fn_WO_DEBITOR(ID_JOB,'''+ @iv_ID_WO_NO +''','''+@iv_ID_PR_NO+'''),''''),2,len(Isnull(dbo.fn_WO_DEBITOR(ID_JOB,'''+@iv_ID_WO_NO+''','''+@iv_ID_PR_NO+'''),''''))-1)                   
			else ''''                  
			END AS ''deb'','                  
			BEGIN          

		   
		IF @iv_DICOUNT_BASE = 'GAMT'                  
			SET @iv_SQL = @iv_SQL + '((ISNULL(WO_TOT_LAB_AMT,0) + ISNULL(WO_TOT_SPARE_AMT,0) + ISNULL(WO_TOT_GM_AMT,0) + ISNULL(WO_FIXED_PRICE,0)) - ISNULL(WO_TOT_DISC_AMT,0) ) + ISNULL(WO_TOT_VAT_AMT,0) AS JOB_AMT'                 
		ELSE                  
			SET @iv_SQL = @iv_SQL + '(ISNULL(WO_TOT_LAB_AMT,0) + ISNULL(WO_TOT_SPARE_AMT,0) + ISNULL(WO_TOT_GM_AMT,0) + ISNULL(WO_FIXED_PRICE,0)) + ISNULL(WO_TOT_VAT_AMT,0) - ISNULL(WO_TOT_DISC_AMT,0) AS JOB_AMT,'             
		END           
		

		 
		IF @iv_DICOUNT_BASE = 'GAMT'     
			SET @iv_SQL = @iv_SQL + '((ISNULL(WO_TOT_LAB_AMT,0) + ISNULL(WO_TOT_SPARE_AMT,0) + ISNULL(WO_TOT_GM_AMT,0) + ISNULL(WO_FIXED_PRICE,0)) - ISNULL(WO_TOT_DISC_AMT,0) - ISNULL(OwnRiskVATAmt,0)) AS JOB_EXVAT_AMT'                  
		ELSE                  
			SET @iv_SQL = @iv_SQL + '(ISNULL(WO_TOT_LAB_AMT,0) + ISNULL(WO_TOT_SPARE_AMT,0) + ISNULL(WO_TOT_GM_AMT,0) + ISNULL(WO_FIXED_PRICE,0))  - ISNULL(WO_TOT_DISC_AMT,0) - ISNULL(OwnRiskVATAmt,0) AS JOB_EXVAT_AMT'                   
		 
			SET @iv_SQL = @iv_SQL + ', '  
			SET @iv_SQL = @iv_SQL + 'CASE WHEN JOB_STATUS = ''INV'' THEN ''' + @INV +''''       
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''DEL'' THEN ''' + @DEL +''''           
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''RES'' THEN ''' + @RES +''''          
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''PINV'' THEN ''' + @PINV +''''            
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''BAR'' THEN ''' + @BAR +''''           
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''CSA'' THEN ''' + @CSA +''''      
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''JST'' THEN ''' + @JST +''''      
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''RINV'' THEN ''' + @RINV +''''    
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''JCD'' THEN ''' + @JCD +''''  
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''RWRK'' THEN ''' + @RWRK +''''     
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''STR'' THEN ''' + @STR +''''     
			SET @iv_SQL = @iv_SQL + ' WHEN JOB_STATUS = ''CON'' THEN ''' + @CON +''''     
			SET @iv_SQL = @iv_SQL + ' ELSE '''''          
			SET @iv_SQL = @iv_SQL + ' END  AS ''JOB_STATUS'''  
		
			SET @iv_SQL = @iv_SQL + ' FROM TBL_WO_DETAIL WHERE ID_WO_NO ='''+ @iv_ID_WO_NO +''''                  
			SET @iv_SQL = @iv_SQL + ' and  ID_WO_PREFIX ='''+ @iv_ID_PR_NO +''''                  
			SET @iv_SQL = @iv_SQL + ' and JOB_STATUS <> ''DEL'' '                   
	         
	         PRINT  @iv_SQL 
			EXEC(@iv_SQL)                  
		    
		END TRY
		BEGIN CATCH
			-- Execute error retrieval routine.
			EXECUTE usp_GetErrorInfo;
		END CATCH;             
END   
       
      
--[usp_WO_HEADER_JOBS] '345880','ZWK','ZENUSER'
GO
