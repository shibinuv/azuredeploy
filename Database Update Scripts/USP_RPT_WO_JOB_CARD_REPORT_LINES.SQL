
GO
/****** Object:  StoredProcedure [dbo].[USP_RPT_WO_JOB_CARD_REPORT]    Script Date: 03.03.2022 15:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
--sp_helptext usp_rpt_wo_job_card_report  
  
 -- usp_rpt_wo_job_card_report 'anw5381','English'    
      
/*************************************** APPLICATION: MSG *************************************************************                
* MODULE     : REPORT               
* FILE NAME  : USP_RPT_WO_JOB_CARD_REPORT.RPC      
* PURPOSE    : TO CREATE REPORT ON JOB CARD                 
* AUTHOR     : MARTIN                
* DATE       : 04.03.2022      
*********************************************************************************************************************/                
      
/*********************************************************************************************************************                  
I/P : -- INPUT PARAMETERS                
O/P : -- OUTPUT PARAMETERS                
ERROR CODE                
DESCRIPTION                
********************************************************************************************************************/                
     --- [USP_RPT_WO_JOB_CARD_REPORT] 'abs431','English'
alter PROCEDURE [dbo].[USP_RPT_WO_JOB_CARD_REPORT_LINES]        
(        
 @IV_WO_NO VARCHAR(20)             
)        
AS        
 BEGIN      
 select JD.ID_ITEM_JOB, IIF(JD.TEXT = '', JD.ITEM_DESC ,JD.TEXT) AS ITEM_DESC, (Case When JD.JOBI_ORDER_QTY = 0.00 Then NULL Else JD.JOBI_ORDER_QTY End) AS JOBI_ORDER_QTY,
 (Case When JD.JOBI_DELIVER_QTY = 0.00 Then NULL Else JD.JOBI_DELIVER_QTY End) AS JOBI_DELIVER_QTY, JD.SL_NO, WD.ID_JOB, 
 (SELECT DESCRIPTION FROM TBL_MAS_SETTINGS WHERE ID_SETTINGS = WD.ID_WORK_CODE_WO) AS WORK_CODE
 from TBL_WO_JOB_DETAIL JD
 INNER JOIN TBL_WO_DETAIL WD ON Wd.ID_WO_PREFIX = JD.ID_WO_PREFIX AND WD.ID_WO_NO = JD.ID_WO_NO AND WD.ID_WODET_SEQ = JD.ID_WODET_SEQ_JOB
 WHERE LTRIM(RTRIM(JD.ID_WO_PREFIX)) + LTRIM(RTRIM(JD.ID_WO_NO)) = @IV_WO_NO


UNION ALL
(
 select null AS ID_ITEM_,LD.WO_LABOUR_DESC, LD.WO_LABOUR_HOURS,LD.WO_LABOUR_HOURS, LD.SL_NO, WD.ID_JOB, (SELECT DESCRIPTION FROM TBL_MAS_SETTINGS WHERE ID_SETTINGS=WD.ID_WORK_CODE_WO) AS WORK_CODE 
 from TBL_WO_LABOUR_DETAIL LD 
  INNER JOIN TBL_WO_DETAIL WD ON WD.ID_WODET_SEQ = LD.ID_WODET_SEQ
 where LD.ID_WODET_SEQ IN (select ID_WODET_SEQ from TBL_WO_DETAIL JD WHERE LTRIM(RTRIM(JD.ID_WO_PREFIX)) + LTRIM(RTRIM(JD.ID_WO_NO)) = @IV_WO_NO)
)

ORDER BY SL_NO ASC
        
 END      
      
--Select * from TBL_WO_DETAIL  
--SELECT DESCRIPTION FROM TBL_MAS_SETTINGS WHERE ID_SETTINGS=


--SELECT * FROM TBL_WO_DETAIL WHERE ID_WO_NO='54455'
--SELECT * FROM TBL_WO_LABOUR_DETAIL WHERE ID_WODET_SEQ=155683