USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_RPT_WO_JOB_CARD_REPORT]    Script Date: 04.03.2022 14:53:57 ******/
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
* AUTHOR     : JERIN S.                
* DATE       : 21.06.2007      
*********************************************************************************************************************/                
      
/*********************************************************************************************************************                  
I/P : -- INPUT PARAMETERS                
O/P : -- OUTPUT PARAMETERS                
ERROR CODE                
DESCRIPTION                
********************************************************************************************************************/                
     --- [USP_RPT_WO_JOB_CARD_REPORT] 'abs431','English'
ALTER PROCEDURE [dbo].[USP_RPT_WO_JOB_CARD_REPORT]        
(        
 @IV_WO_NO  VARCHAR(20),      
    @IV_LANGUAGE VARCHAR(50)          
)        
AS        
 BEGIN      
  DECLARE @I_NULLCHECK INT      
        SET @I_NULLCHECK = 0    
  DECLARE @WORKNO AS VARCHAR(20)    
      
        DECLARE @V1 TABLE      
        (      
   ID_WO_NO    VARCHAR(100),      
   WO_CUST_NAME   VARCHAR(100),      
   WO_CUST_PERM_ADD1  VARCHAR(100),      
   WO_CUST_PERM_ADD2  VARCHAR(100),      
   WO_CUST_PHONE_OFF  VARCHAR(20),      
   WO_CUST_PHONE_HOME  VARCHAR(20),      
   WO_CUST_PHONE_MOBILE VARCHAR(20),      
   DT_ORDER      VARCHAR(10),      
   DT_FINISH     VARCHAR(10),      
   WO_TYPE_WOH    VARCHAR(10),      
   WO_VEH_REG_NO    VARCHAR(100),      
   WO_VEH_VIN       VARCHAR(100),      
   DT_VEH_ERGN      VARCHAR(100),      
   VEHICLE_TYPE     VARCHAR(100),      
   WO_VEH_INTERN_NO  VARCHAR(100),      
   WO_VEH_MILEAGE   INT,      
   ID_MODELGRP_NAME  VARCHAR(100),      
   ID_MAKE_NAME    VARCHAR(100),   
-- **********************************************************  
-- Modified Date :-  07-MAY-2008  
-- Description   :-  Sending Mail Code  
-- bug No        :-   2456  
-- ***********************   
   --ZIP_ZIPCODE     INT,      
ZIP_ZIPCODE     varchar(10),      
--Change end   
   ZIP_ID_COUNTRY   INT,      
   COUNTRY_NAME   VARCHAR(100),      
   ZIP_CITY    VARCHAR(100),      
   ZIP_ID_STATE   INT,      
   STATE_NAME    VARCHAR(100)      
)      
      
      
INSERT  @V1      
(      
  ID_WO_NO,      
  WO_CUST_NAME,      
  WO_CUST_PERM_ADD1,       
  WO_CUST_PERM_ADD2,      
  WO_CUST_PHONE_OFF,      
  WO_CUST_PHONE_HOME,      
  WO_CUST_PHONE_MOBILE,      
  DT_ORDER,      
  DT_FINISH,      
  WO_TYPE_WOH,      
  WO_VEH_REG_NO,      
  WO_VEH_VIN ,      
  DT_VEH_ERGN,      
  VEHICLE_TYPE,      
  WO_VEH_INTERN_NO,      
  WO_VEH_MILEAGE,      
  ID_MODELGRP_NAME ,      
  ID_MAKE_NAME,      
  ZIP_ZIPCODE,      
  ZIP_ID_COUNTRY,      
  COUNTRY_NAME,      
  ZIP_CITY,      
  ZIP_ID_STATE,      
  STATE_NAME      
)      
      
 SELECT  @IV_WO_NO,      
   WOH.WO_CUST_NAME,       
   WOH.WO_CUST_PERM_ADD1,      
   WOH.WO_CUST_PERM_ADD2,      
   WOH.WO_CUST_PHONE_OFF,      
   WOH.WO_CUST_PHONE_HOME,      
   WOH.WO_CUST_PHONE_MOBILE,      
   CONVERT(VARCHAR(10),WOH.DT_ORDER,103)  AS 'DT_ORDER',      
   CONVERT(VARCHAR(10),WOH.DT_FINISH,103) AS 'DT_FINISH',      
   WOH.WO_TYPE_WOH,      
   WOH.WO_VEH_REG_NO,      
   WOH.WO_VEH_VIN,      
   (SELECT CONVERT(VARCHAR(10),DT_VEH_ERGN,103) FROM TBL_MAS_VEHICLE WHERE VEH_INTERN_NO = WOH.WO_VEH_INTERN_NO) AS DT_VEH_ERGN,           
   (SELECT VEH_TYPE FROM TBL_MAS_VEHICLE WHERE VEH_INTERN_NO = WOH.WO_VEH_INTERN_NO),      
   WOH.WO_VEH_INTERN_NO,      
   WOH.WO_VEH_MILEAGE,      
   (SELECT VEH_ENGINE_NO FROM TBL_MAS_VEHICLE WHERE VEH_INTERN_NO = WOH.WO_VEH_INTERN_NO),     
   (SELECT ID_MAKE_VEH FROM TBL_MAS_VEHICLE WHERE VEH_INTERN_NO = WOH.WO_VEH_INTERN_NO),      
   ZCODE.ZIP_ZIPCODE,      
   ZCODE.ZIP_ID_COUNTRY,      
   CNFIG.DESCRIPTION AS 'COUNTRY_NAME',      
   ZCODE.ZIP_CITY,      
   ZCODE.ZIP_ID_STATE,      
   CNFIG2.DESCRIPTION AS 'STATE_NAME'       
      
      
   FROM  TBL_WO_HEADER WOH,      
      TBL_MAS_ZIPCODE ZCODE,      
                  TBL_MAS_CONFIG_DETAILS CNFIG,      
                  TBL_MAS_CONFIG_DETAILS CNFIG2      
   WHERE   LTRIM(RTRIM(WOH.ID_WO_PREFIX)) + LTRIM(RTRIM(WOH.ID_WO_NO)) = @IV_WO_NO       
      AND ZCODE.ZIP_ZIPCODE = WOH.ID_ZIPCODE_WO      
     -- AND CNFIG.ID_CONFIG = 'CTRY'       
         AND CNFIG.ID_PARAM = ZCODE.ZIP_ID_COUNTRY      
   --   AND CNFIG2.ID_CONFIG = 'STATE'       
      AND CNFIG2.ID_PARAM = ZCODE.ZIP_ID_STATE      
      
/*  
'-----------------------------------------------  
'Modified Date : 23-May-08  
'Description    : To display make and model  
'bug No         : 2691  
'-------------------------------------------------  
*/      
  --SELECT @I_NULLCHECK = ID_VEH_SEQ_WO FROM TBL_WO_HEADER WHERE LTRIM(RTRIM(ID_WO_NO)) + LTRIM(RTRIM(ID_WO_PREFIX)) = @IV_WO_NO       
  SELECT @I_NULLCHECK = ID_VEH_SEQ_WO FROM TBL_WO_HEADER WHERE LTRIM(RTRIM(ID_WO_PREFIX)) + LTRIM(RTRIM(ID_WO_NO)) = @IV_WO_NO   
------------ End Of Fix for bug 2691 -------------  
  
        IF (@I_NULLCHECK <> 0)       
  BEGIN      
              UPDATE @V1      
                SET DT_VEH_ERGN      = tab1.VDT_VEH_ERGN,      
                    VEHICLE_TYPE     = tab1.VEH_TYPE,       
         ID_MODELGRP_NAME = tab1.ID_MODELGRP_NAME,      
                    ID_MAKE_NAME     = tab1.ID_MAKE_NAME      
               from      
      
   (SELECT  CONVERT(VARCHAR(10),VEH.DT_VEH_ERGN,103) 'VDT_VEH_ERGN',      
                       VEH.VEH_TYPE  'VEH_TYPE',      
                 MODGRP.ID_MODELGRP_NAME as 'ID_MODELGRP_NAME',      
                       MAK.ID_MAKE_NAME as 'ID_MAKE_NAME'      
            
      
   FROM  TBL_WO_HEADER WOH      
      ,TBL_MAS_MAKE MAK      
      ,TBL_MAS_MODELGROUP MODGRP      
      ,TBL_MAS_VEHICLE VEH      
            
   WHERE   (LTRIM(RTRIM(WOH.ID_WO_PREFIX)) + LTRIM(RTRIM(WOH.ID_WO_NO)) = @IV_WO_NO       
     AND VEH.ID_VEH_SEQ  = WOH.ID_VEH_SEQ_WO        
     AND VEH.ID_MAKE_VEH = MAK.ID_MAKE      
     AND VEH.ID_MODEL_VEH =MODGRP.ID_MODELGRP)) tab1      
                              
           End              
        
-- *********************************************************  
 -- Modified Date : 21st July 2008  
 -- Bug No   : SS2_ 29 (Missing Functions)  
SELECT  @WORKNO  = LTRIM(RTRIM(JOB.ID_WO_PREFIX)) + LTRIM(RTRIM(JOB.ID_WO_NO)) FROM TBL_WO_JOB_DETAIL JOB   
     WHERE LTRIM(RTRIM(JOB.ID_WO_PREFIX)) + LTRIM(RTRIM(JOB.ID_WO_NO)) = @IV_WO_NO  
PRINT @WORKNO  
  
IF @WORKNO IS NOT NULL  
BEGIN   
-- ************* End OF Modification ************************  
 select V1.ID_WO_NO,      
  WO_CUST_NAME,      
  WO_CUST_PERM_ADD1,       
  WO_CUST_PERM_ADD2,      
  WO_CUST_PHONE_OFF,      
  WO_CUST_PHONE_HOME,      
  WO_CUST_PHONE_MOBILE,      
  DT_ORDER,      
  CAST(DBO.FN_MULTILINGUAL_DATE(CONVERT(CHAR(10),DT_ORDER,103),'' + @IV_LANGUAGE + '')  AS VARCHAR(10))  AS DT_ORDER,      
--  DT_FINISH,      
  CAST(DBO.FN_MULTILINGUAL_DATE(CONVERT(CHAR(10),DT_FINISH,103),'' + @IV_LANGUAGE + '')  AS VARCHAR(10))  AS DT_FINISH,      
  WO_TYPE_WOH,      
  WO_VEH_REG_NO,      
  WO_VEH_VIN ,      
  DT_VEH_ERGN,      
  VEHICLE_TYPE,      
  WO_VEH_INTERN_NO,      
  WO_VEH_MILEAGE,      
  ID_MODELGRP_NAME ,      
  ID_MAKE_NAME,      
  ZIP_ZIPCODE,      
  ZIP_ID_COUNTRY,      
  COUNTRY_NAME,      
  ZIP_CITY,      
  ZIP_ID_STATE,      
  STATE_NAME,      
  JOB.ID_ITEM_JOB,      
      
      JOB.JOBI_ORDER_QTY,      
--  DBO.FN_MULTILINGUAL_NUMERIC(JOB.JOBI_ORDER_QTY,'' + @IV_LANGUAGE + '') AS JOBI_ORDER_QTY,      
      JOB.JOBI_DELIVER_QTY,      
--  DBO.FN_MULTILINGUAL_NUMERIC(JOB.JOBI_DELIVER_QTY,'' + @IV_LANGUAGE + '') AS JOBI_DELIVER_QTY,      
  ITEM.ITEM_DESC,      
        ITEM.LOCATION      
from  @V1 v1 ,      
      TBL_WO_JOB_DETAIL JOB,      
   TBL_MAS_ITEM_MASTER ITEM      
--------ZSL Changes related to TBl_MAS_ITEM_MASTER Composite Key 12-Dec-07---------       
/*WHERE LTRIM(RTRIM(JOB.ID_WO_PREFIX)) + LTRIM(RTRIM(JOB.ID_WO_NO)) = @IV_WO_NO         
   AND LTRIM(RTRIM(JOB.ID_ITEM_JOB)) = LTRIM(RTRIM(ITEM.ID_ITEM))        
      AND V1.ID_WO_NO = @IV_WO_NO  */      
      
WHERE LTRIM(RTRIM(JOB.ID_WO_PREFIX)) + LTRIM(RTRIM(JOB.ID_WO_NO)) = @IV_WO_NO         
   AND LTRIM(RTRIM(JOB.ID_ITEM_JOB)) = LTRIM(RTRIM(ITEM.ID_ITEM))       
   AND LTRIM(RTRIM(JOB.ID_MAKE_JOB)) = LTRIM(RTRIM(ITEM.ID_MAKE))       
      AND V1.ID_WO_NO = @IV_WO_NO        
-------------------------------ZSL Changes End-------------------------------------         
   --SELECT * FROM @V1          
   END  
-- *********************************************************  
 -- Modified Date : 21st July 2008  
 -- Bug No   : SS2_ 29 (Missing Functions)  
ELSE  
  BEGIN  
   select V1.ID_WO_NO,      
    WO_CUST_NAME,      
    WO_CUST_PERM_ADD1,       
    WO_CUST_PERM_ADD2,      
    WO_CUST_PHONE_OFF,      
    WO_CUST_PHONE_HOME,      
    WO_CUST_PHONE_MOBILE,      
    DT_ORDER,      
    CAST(DBO.FN_MULTILINGUAL_DATE(CONVERT(CHAR(10),DT_ORDER,103),'' + @IV_LANGUAGE + '')  AS VARCHAR(10))  AS DT_ORDER,       
    CAST(DBO.FN_MULTILINGUAL_DATE(CONVERT(CHAR(10),DT_FINISH,103),'' + @IV_LANGUAGE + '')  AS VARCHAR(10))  AS DT_FINISH,      
    WO_TYPE_WOH,      
    WO_VEH_REG_NO,      
    WO_VEH_VIN ,      
    DT_VEH_ERGN,      
    VEHICLE_TYPE,      
    WO_VEH_INTERN_NO,      
    WO_VEH_MILEAGE,      
    ID_MODELGRP_NAME ,      
    ID_MAKE_NAME,      
    ZIP_ZIPCODE,      
    ZIP_ID_COUNTRY,      
    COUNTRY_NAME,      
    ZIP_CITY,      
    ZIP_ID_STATE,      
    STATE_NAME         
    from  @V1 v1           
  WHERE V1.ID_WO_NO = @IV_WO_NO        
 END  
-- ************* End OF Modification ************************  
        
 END      
      
      
/*      
      
SELECT * FROM TBL_WO_JOB_DETAIL       
      
SELECT * FROM TBL_WO_HEADER      
      
EXEC USP_RPT_WO_JOB_CARD_REPORT  'WO1003', 'NORWEGIAN'      
      
select  dt_Order,      
        CONVERT(CHAR(10),DT_ORDER,101),      
        CAST(DBO.FN_MULTILINGUAL_DATE(CONVERT(CHAR(10),DT_ORDER,103),'NORWEGIAN')  AS VARCHAR(10)),      
        CAST(DBO.FN_MULTILINGUAL_DATE(CONVERT(CHAR(10),DT_ORDER,110),'NORWEGIAN')  AS VARCHAR(10))        
from tbl_wo_header       
where ID_WO_NO = '1003'      
*/   
  
  
--exec [USP_RPT_WO_JOB_CARD_REPORT] 'anw5381','English'  
  
--sp_helptext UPS_RPT_DETAIL  
--  
--    
--    
--        
--ALTER PROCEDURE UPS_RPT_DETAIL          
--(@IV_SCREENNAME VARCHAR(100),          
--@IV_LANGUAGENAME VARCHAR(100))          
--AS           
--BEGIN          
--          
--  DECLARE @COUNT AS INT          
--  SET @COUNT = 0          
--      
-- if (@IV_SCREENNAME is null or len(@IV_SCREENNAME) = 0)      
-- begin      
-- set @IV_SCREENNAME = 'Invoice'      
-- end      
--          
--  SELECT @COUNT = COUNT(*) FROM TBL_MAS_RPT_DETAIL          
--  WHERE RPT_SCRname = @IV_SCREENNAME          
--  AND rpt_languageid =          
--  (SELECT ID_LANG FROM TBL_MAS_LANGUAGE WHERE LANG_NAME = @IV_LANGUAGENAME)          
--          
--  IF(@COUNT > 0)          
--  BEGIN          
--    SELECT * FROM TBL_MAS_RPT_DETAIL          
--    WHERE RPT_SCRname = @IV_SCREENNAME          
--    AND rpt_languageid =          
--    (SELECT ID_LANG FROM TBL_MAS_LANGUAGE WHERE LANG_NAME = @IV_LANGUAGENAME)          
--     ORDER BY SLNO          
--  END          
--  ELSE          
--  BEGIN          
--    SELECT * FROM TBL_MAS_RPT_DETAIL          
--    WHERE RPT_SCRname = @IV_SCREENNAME          
--    AND rpt_languageid =          
--    (SELECT ID_LANG FROM TBL_MAS_LANGUAGE WHERE LANG_NAME = 'ENGLISH')          
--     ORDER BY SLNO          
--  END          
--          
--            
--END          
--          
--/*          
--EXEC UPS_RPT_DETAIL '','ENGLISH'          
--EXEC UPS_RPT_DETAIL 'TOTALCOST','GERMAN'          
--          
--select * from TBL_MAS_RPT_DETAIL          
--          
--*/    
--  
--EXEC UPS_RPT_DETAIL 'WJC','ENGLISH'  
  
  