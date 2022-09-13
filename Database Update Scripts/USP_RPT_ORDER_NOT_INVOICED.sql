/****** Object:  StoredProcedure [dbo].[USP_RPT_ORDER_NOT_INVOICED]    Script Date: 11/17/2017 3:22:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_RPT_ORDER_NOT_INVOICED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[USP_RPT_ORDER_NOT_INVOICED]
GO
/****** Object:  StoredProcedure [dbo].[USP_RPT_ORDER_NOT_INVOICED]    Script Date: 11/17/2017 3:22:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_RPT_ORDER_NOT_INVOICED]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[USP_RPT_ORDER_NOT_INVOICED] AS' 
END
GO

ALTER PROCEDURE [dbo].[USP_RPT_ORDER_NOT_INVOICED]                          
(                             
    @IV_ID_DEPT_FROM  varchar(50),                          
    @IV_ID_DEPT_TO  varchar(50),                          
    @IV_DT_CREATED_FROM VARCHAR(30), --DATETIME,                          
    @IV_DT_CREATED_TO VARCHAR(30), --DATETIME,                          
    @IV_WO_STATUS_FROM VARCHAR(20),                          
    @IV_WO_STATUS_TO VARCHAR(20)      ,                    
    @IV_LANGUAGE VARCHAR(50)                      
                          
)                          
AS                           
BEGIN      

	DECLARE @LANG INT 
SELECT @LANG=ID_LANG FROM TBL_MAS_LANGUAGE WHERE LANG_NAME=@IV_LANGUAGE
                 
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

DECLARE @Y AS VARCHAR(50)
SELECT @Y=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_Y' AND ISDATA=1

DECLARE @N AS VARCHAR(50)
SELECT @N=ERR_DESC FROM TBL_MAS_ERR_MESSAGE WHERE ID_LANG=@LANG AND ERR_ID='D_N' AND ISDATA=1  
                    
    DECLARE @MAINQUERY AS VARCHAR(MAX)                          
    DECLARE @QUERY1 AS VARCHAR(MAX)                          
    DECLARE @QUERY2 AS VARCHAR(MAX)         
    DECLARE @QUERY3 AS VARCHAR(MAX)
    DECLARE @FromDate DATETIME
    DECLARE @ToDate DATETIME

 --Added for displaying the period ( from date  and to date ) in the report
    SET @FromDate = @IV_DT_CREATED_FROM 
	SET @ToDate = @IV_DT_CREATED_TO 
	
    IF((@IV_DT_CREATED_FROM IS NULL OR LEN(@IV_DT_CREATED_FROM) = 0 OR @IV_DT_CREATED_FROM ='') AND (@IV_DT_CREATED_TO IS NULL OR LEN(@IV_DT_CREATED_TO) = 0 OR @IV_DT_CREATED_TO ='') )
    BEGIN
    
		DECLARE @FROMYEAR VARCHAR(4)
		DECLARE @TOYEAR VARCHAR(4)
		DECLARE @FROMMONTH VARCHAR(2)
		DECLARE @TOMONTH VARCHAR(2)
		
		SELECT TOP 1 @FROMYEAR =DATEPART(YYYY,DT_ORDER) FROM TBL_WO_HEADER ORDER BY DT_ORDER ASC
		SET @TOYEAR = DATEPART(YYYY,GETDATE())
		SET @FROMMONTH = '1'
		SET @TOMONTH = DATEPART(MM,GETDATE())

		SET @FROMDATE = @FROMMONTH +'/'+'01'+'/'+ @FROMYEAR
		SET @TODATE = @TOMONTH +'/'+'01'+'/'+ @TOYEAR
		SELECT @TODATE = DATEADD(S,-1,DATEADD(MM, DATEDIFF(M,0,@TODATE)+1,0))
				
    END
       
        
-- ************************************        
-- Modified Date : 18th June 2008        
-- Bug ID      : 2926        
-- Description   : Added Top 1 to the select Department table statement                         
 
--Compacted since the length was exceeding 8000               
    DECLARE @STATUS AS INT                            
    SET @STATUS = 0                            
    SET @QUERY2 = ' (A.WO_STATUS = ''RINV'' OR A.WO_STATUS = ''PINV'' OR  A.WO_STATUS = ''JST'' OR A.WO_STATUS = ''JCD'' OR A.WO_STATUS = ''BAR'' OR A.WO_STATUS = ''RES'' OR A.WO_STATUS = ''CSA'' OR A.WO_STATUS = ''RWRK'')  '                          
 --SET @MAINQUERY =SELECT A.ID_WO_PREFIX,A.ID_DEPT, CASE WHEN A.ID_DEPT IS NOT NULL THEN (SELECT ISNULL(DPT_NAME,'' '') FROM TBL_MAS_DEPT WHERE ID_DEPT = A.ID_DEPT) ELSE '' '' END AS ''DEPTNAME'',A.ID_WO_NO,A.WO_STATUS,CASE WO_STATUS WHEN ''BAR'' THEN  ''' + @BAR +''' WHEN ''CSA'' THEN ''' + @CSA +''' WHEN ''DEL''  THEN ''' + @DEL +''' WHEN ''INV'' THEN ''' + @INV +''' WHEN ''JCD'' THEN ''' + @JCD +''' WHEN ''JST'' THEN ''' + @JST +''' WHEN ''RES'' THEN ''' + @RES +''' WHEN ''PINV'' THEN ''' + @PINV +''' WHEN ''RINV'' THEN ''' + @RINV +''' WHEN ''RWRK'' THEN ''' + @RWRK +''' ELSE '''' END AS WO_STATUSdesc,A.DT_CREATED,case when A.DT_CREATED is not null then cast(DBO.FN_MULTILINGUAL_DATE(convert(char(10),DT_CREATED,101),''' + @IV_LANGUAGE + ''') as varchar(10)) else '' '' end as DT_CREATEDML,A.ID_CUST_WO,A.WO_CUST_NAME,B.CHARGETIME,CASE WHEN B.CHARGETIME >= 0 THEN DBO.FN_MULTILINGUAL_NUMERIC(B.CHARGETIME,''' + @IV_LANGUAGE + ''') ELSE ''0.00'' END AS CHARGETIMEMULTILINGUAL,C.LASTCLOCKIN,case when C.LASTCLOCKIN is not null then cast(DBO.FN_MULTILINGUAL_DATE(convert(char(10),C.LASTCLOCKIN,101),''' + @IV_LANGUAGE + ''') as varchar(10)) else '' '' end as LASTCLOCKINML,D.SPAREAMOUT,H.TOTLABAMT,CASE WHEN D.SPAREAMOUT >= 0 THEN DBO.FN_MULTILINGUAL_NUMERIC(D.SPAREAMOUT,''' + @IV_LANGUAGE + ''') ELSE ''0.00'' END AS SPAREPARTMULTILINGUAL, CASE WHEN H.TOTLABAMT >= 0 THEN DBO.FN_MULTILINGUAL_NUMERIC(H.TOTLABAMT,''' + @IV_LANGUAGE + ''')  ELSE ''0.00''  END  AS TOTLABAMTMULTILINGUAL,  
	--E.TOTALAMOUNT,case when E.TOTALAMOUNT >= 0 then  dbo.FN_MULTILINGUAL_NUMERIC(E.TOTALAMOUNT,''' + @IV_LANGUAGE + ''')  else ''0.00'' end AS TOTALAMOUNTMULTILINGUAL,CASE WHEN F.READYTOINVOICE = ''Y'' THEN '''+ @Y + '''ELSE '''+ @N +''' END AS READYTOINVOICE, CASE WHEN G.NOCREDITCUST = ''Y'' THEN '''+ @Y + '''ELSE '''+ @N +''' END AS NOCREDITCUST, A.CREATED_BY ,CASE WHEN H.TOTGMAMT >= 0 THEN H.TOTGMAMT ELSE ''0.00'' END AS TOTGMAMTMULTILINGUAL,CASE WHEN H.TOTFIXEDPRICE >= 0 THEN  H.TOTFIXEDPRICE  ELSE ''0.00''  END  AS TOTFPAMTMULTILINGUAL,CASE WHEN I.WO_SPR_DISCPER = ''0.00'' THEN CAST(ISNULL(CAST(ISNULL(J.WO_TOT_SPARE_AMT,0) * (I.DBT_PER / 100)AS NUMERIC(12,5)) + CAST(ISNULL(J.WO_TOT_LAB_AMT,0) * (I.DBT_PER / 100)AS NUMERIC(12,5))+ CAST(ISNULL(J.WO_FIXED_PRICE,0) * (I.DBT_PER / 100)AS NUMERIC(12,5)) + CAST(ISNULL(J.WO_TOT_GM_AMT,0) * (I.DBT_PER / 100)AS NUMERIC(12,5)),0) - ISNULL((CASE WHEN J.WO_FIXED_PRICE=0.00 THEN CASE WHEN (J.WO_DISCOUNT = ''0.00'' and WO_TOT_DISC_AMT=''0.00'') AND I.WO_SPR_DISCPER=''0.00'' AND I.WO_GM_VATPER=''0.00'' AND I.WO_LBR_VATPER=''0.00'' THEN 0        
	-- WHEN I.WO_SPR_DISCPER=''1.00'' AND I.DBT_PER <> ''0.00'' AND I.DBT_AMT > 0.00 THEN CAST(ISNULL((J.WO_TOT_DISC_AMT * I.DBT_PER/100),0) as NUMERIC(12,5)) ELSE  CAST((select sum(WOJ.JOBI_SELL_PRICE * WOJ.JOBI_DELIVER_QTY * (WOJ.JOBI_DIS_PER)/100) from TBL_WO_JOB_DETAIL WOJ where ID_WODET_SEQ_JOB in (SELECT ID_WODET_SEQ FROM TBL_WO_DETAIL WHERE ID_WO_NO = J.ID_WO_NO and ID_JOB=J.ID_JOB and ID_WO_PREFIX=J.ID_WO_PREFIX)) * (DBT_PER / 100) + CAST((ISNULL(J.WO_TOT_GM_AMT,0) * (J.WO_DISCOUNT/ 100)) * (DBT_PER / 100) as NUMERIC(12,2)) + CAST((ISNULL(J.WO_TOT_LAB_AMT,0) * (J.WO_DISCOUNT/ 100)) * (DBT_PER / 100) as NUMERIC(12,2)) AS NUMERIC(12,5)) END ELSE 0 END),0) + ISNULL(dbo.FETCHOWNRISKAMOUNT(J.ID_WO_NO, J.ID_WO_PREFIX, J.ID_JOB, I.ID_JOB_DEB), 0) - ISNULL(J.OwnRiskVATAmt, 0)AS NUMERIC(12,5)) ELSE CAST(ISNULL(ISNULL(J.WO_TOT_SPARE_AMT,0) * (I.DBT_PER / 100) + ISNULL(J.WO_TOT_LAB_AMT,0) * (I.DBT_PER / 100)+ ISNULL(J.WO_FIXED_PRICE,0) * (I.DBT_PER / 100)+ ISNULL(J.WO_TOT_GM_AMT,0) * (I.DBT_PER / 100),0) AS NUMERIC(12,5))END AS  ''NET AMOUNT'',''' + convert(varchar(10),@FromDate,103) +  ''' AS FROMDATE,''' + convert(varchar(10),@ToDate,103)  + ''' AS TODATE INTO #TEMP1 FROM TBL_WO_HEADER AS A JOIN(SELECT ID_WO_NO,ID_WO_PREFIX,SUM(CONVERT(DECIMAL(8,2),(CASE WHEN ISNUMERIC(REPLACE(WO_CHRG_TIME,'','',''.'')) =0 THEN ''0.00'' ELSE REPLACE(WO_CHRG_TIME,'','',''.'')END)))AS CHARGETIME  FROM  TBL_WO_DETAIL WHERE JOB_STATUS NOT IN (''DEL'',''INV'') GROUP BY ID_WO_NO,ID_WO_PREFIX) AS B ON (A.ID_WO_PREFIX = B.ID_WO_PREFIX AND A.ID_WO_NO =B.ID_WO_NO) LEFT JOIN ( SELECT ACT.ID_WO_NO,ACT.ID_WO_PREFIX, MAX(DT_CLOCK_IN ) AS LASTCLOCKIN FROM TBL_TR_JOB_ACTUAL ACT,TBL_WO_DETAIL DET WHERE DET.ID_WO_NO=ACT.ID_WO_NO AND DET.ID_WO_PREFIX=ACT.ID_WO_PREFIX AND JOB_STATUS NOT IN (''DEL'',''INV'') GROUP BY ACT.ID_WO_NO,ACT.ID_WO_PREFIX) AS C ON (A.ID_WO_PREFIX = C.ID_WO_PREFIX AND A.ID_WO_NO =C.ID_WO_NO) LEFT JOIN ( SELECT ID_WO_NO,ID_WO_PREFIX,SUM(WO_TOT_SPARE_AMT) AS SPAREAMOUT FROM TBL_WO_DETAIL WHERE JOB_STATUS NOT IN (''DEL'',''INV'') 
 --   GROUP BY ID_WO_NO,ID_WO_PREFIX ) AS D ON (A.ID_WO_PREFIX = D.ID_WO_PREFIX AND A.ID_WO_NO =D.ID_WO_NO) LEFT JOIN ( SELECT ID_WO_NO,ID_WO_PREFIX,((SUM(WO_TOT_SPARE_AMT) + SUM(WO_FIXED_PRICE) + SUM(WO_TOT_GM_AMT) + SUM(WO_TOT_LAB_AMT) + SUM(WO_TOT_VAT_AMT)) - SUM(WO_TOT_DISC_AMT)) AS TOTALAMOUNT FROM TBL_WO_DETAIL WHERE JOB_STATUS NOT IN (''DEL'',''INV'')GROUP BY ID_WO_NO,ID_WO_PREFIX ) AS E ON (A.ID_WO_PREFIX = E.ID_WO_PREFIX AND A.ID_WO_NO =E.ID_WO_NO) LEFT JOIN ( SELECT ID_WO_NO,ID_WO_PREFIX,(CASE WHEN WO_STATUS=''RINV'' THEN ''Y'' ELSE ''N'' END) AS READYTOINVOICE FROM TBL_WO_HEADER WHERE WO_STATUS NOT IN (''DEL'',''INV''))AS F ON (A.ID_WO_PREFIX = F.ID_WO_PREFIX AND A.ID_WO_NO =F.ID_WO_NO) LEFT JOIN( SELECT ID_CUSTOMER ,(CASE WHEN FLG_CUST_NOCREDIT= ''TRUE'' THEN ''Y'' ELSE ''N'' END) AS NOCREDITCUST FROM TBL_MAS_CUSTOMER)AS G ON (A.ID_CUST_WO = G.ID_CUSTOMER ) LEFT JOIN ( SELECT ID_WO_NO,ID_WO_PREFIX,SUM(WO_TOT_LAB_AMT) AS TOTLABAMT,SUM(WO_TOT_GM_AMT) AS TOTGMAMT, SUM(WO_FIXED_PRICE) AS TOTFIXEDPRICE FROM TBL_WO_DETAIL WHERE JOB_STATUS NOT IN (''DEL'',''INV'') 
	--GROUP BY ID_WO_NO,ID_WO_PREFIX) AS H ON (A.ID_WO_PREFIX = H.ID_WO_PREFIX AND A.ID_WO_NO =H.ID_WO_NO) LEFT JOIN( SELECT ID_WO_NO,ID_WO_PREFIX,ID_JOB,WO_TOT_SPARE_AMT,WO_TOT_LAB_AMT,WO_FIXED_PRICE,WO_TOT_GM_AMT,WO_DISCOUNT,OwnRiskVATAmt,WO_TOT_DISC_AMT FROM TBL_WO_DETAIL) AS J ON (J.ID_WO_NO)=A.ID_WO_NO AND J.ID_WO_PREFIX=A.ID_WO_PREFIX LEFT JOIN ( SELECT ID_WO_PREFIX,ID_WO_NO,ID_JOB_ID,WO_SPR_DISCPER,DBT_PER,WO_GM_VATPER,DBT_AMT,WO_LBR_VATPER,ID_JOB_DEB FROM TBL_WO_DEBITOR_DETAIL
	--) AS I ON (I.ID_WO_NO)=J.ID_WO_NO AND I.ID_WO_PREFIX=J.ID_WO_PREFIX AND I.ID_JOB_ID=J.ID_JOB          
        
        
SET @MAINQUERY = 'SELECT A.ID_WO_PREFIX,A.ID_DEPT, CASE WHEN A.ID_DEPT IS NOT NULL THEN (SELECT ISNULL(DPT_NAME,'' '') FROM TBL_MAS_DEPT WHERE ID_DEPT = A.ID_DEPT) ELSE '' '' END AS ''DEPTNAME'',A.ID_WO_NO,A.WO_STATUS,CASE WO_STATUS WHEN ''BAR'' THEN  ''' + @BAR +''' WHEN ''CSA'' THEN ''' + @CSA +''' WHEN ''DEL''  THEN ''' + @DEL +''' WHEN ''INV'' THEN ''' + @INV +''' WHEN ''JCD'' THEN ''' + @JCD +''' WHEN ''JST'' THEN ''' + @JST +''' WHEN ''RES'' THEN ''' + @RES +''' WHEN ''PINV'' THEN ''' + @PINV +''' WHEN ''RINV'' THEN ''' + @RINV +''' WHEN ''RWRK'' THEN ''' + @RWRK +''' ELSE '''' END AS WO_STATUSdesc,A.DT_CREATED,case when A.DT_CREATED is not null then cast(DBO.FN_MULTILINGUAL_DATE(convert(char(10),DT_CREATED,101),''' + @IV_LANGUAGE + ''') as varchar(10)) else '' '' end as DT_CREATEDML,A.ID_CUST_WO,A.WO_CUST_NAME,B.CHARGETIME,CASE WHEN B.CHARGETIME >= 0 THEN DBO.FN_MULTILINGUAL_NUMERIC(B.CHARGETIME,''' + @IV_LANGUAGE + ''') ELSE ''0.00'' END AS CHARGETIMEMULTILINGUAL,C.LASTCLOCKIN,case when C.LASTCLOCKIN is not null then cast(DBO.FN_MULTILINGUAL_DATE(convert(char(10),C.LASTCLOCKIN,101),''' + @IV_LANGUAGE + ''') as varchar(10)) else '' '' end as LASTCLOCKINML,B.SPAREAMOUT,B.TOTLABAMT,CASE WHEN B.SPAREAMOUT >= 0 THEN DBO.FN_MULTILINGUAL_NUMERIC(B.SPAREAMOUT,''' + @IV_LANGUAGE + ''') ELSE ''0.00'' END AS SPAREPARTMULTILINGUAL, CASE WHEN B.TOTLABAMT >= 0 THEN DBO.FN_MULTILINGUAL_NUMERIC(B.TOTLABAMT,''' + @IV_LANGUAGE + ''')  ELSE ''0.00''  END  AS TOTLABAMTMULTILINGUAL,  
B.TOTALAMOUNT,case when B.TOTALAMOUNT >= 0 then  dbo.FN_MULTILINGUAL_NUMERIC(B.TOTALAMOUNT,''' + @IV_LANGUAGE + ''')  else ''0.00'' end AS TOTALAMOUNTMULTILINGUAL,CASE WHEN A.WO_STATUS=''RINV'' THEN '''+ @Y + '''ELSE '''+ @N +''' END AS READYTOINVOICE, CASE WHEN G.NOCREDITCUST = ''Y'' THEN '''+ @Y + '''ELSE '''+ @N +''' END AS NOCREDITCUST, A.CREATED_BY ,CASE WHEN B.TOTGMAMT >= 0 THEN B.TOTGMAMT ELSE ''0.00'' END AS TOTGMAMTMULTILINGUAL,CASE WHEN B.TOTFIXEDPRICE >= 0 THEN  B.TOTFIXEDPRICE  ELSE ''0.00''  END  AS TOTFPAMTMULTILINGUAL,CASE WHEN ISNULL((SELECT FLG_DPT_WareHouse FROM TBL_MAS_DEPT DEPT WHERE DEPT.ID_Dept=A.ID_Dept),0)=1 THEN (ISNULL(J.WO_TOT_SPARE_AMT,0)-ISNULL(J.WO_TOT_DISC_AMT,0)) ELSE CASE WHEN ISNULL(I.WO_SPR_DISCPER,0) = ''0.00'' THEN CAST(ISNULL(CAST(ISNULL(J.WO_TOT_SPARE_AMT,0) * (ISNULL(I.DBT_PER,0) / 100)AS NUMERIC(12,5)) + CAST(ISNULL(J.WO_TOT_LAB_AMT,0) * (ISNULL(I.DBT_PER,0) / 100)AS NUMERIC(12,5))+ CAST(ISNULL(J.WO_FIXED_PRICE,0) * (ISNULL(I.DBT_PER,0) / 100)AS NUMERIC(12,5)) + CAST(ISNULL(J.WO_TOT_GM_AMT,0) * (ISNULL(I.DBT_PER,0) / 100)AS NUMERIC(12,5)),0) - ISNULL((CASE WHEN J.WO_FIXED_PRICE=0.00 THEN CASE WHEN (J.WO_DISCOUNT = ''0.00'' and WO_TOT_DISC_AMT=''0.00'') AND ISNULL(I.WO_SPR_DISCPER,0)=''0.00'' AND ISNULL(I.WO_GM_VATPER,0)=''0.00'' AND ISNULL(I.WO_LBR_VATPER,0)=''0.00'' THEN 0 WHEN ISNULL(I.WO_SPR_DISCPER,0)=''1.00'' AND ISNULL(I.DBT_PER,0) <> ''0.00'' AND ISNULL(I.DBT_AMT,0) > 0.00 THEN CAST(ISNULL((J.WO_TOT_DISC_AMT * ISNULL(I.DBT_PER,0)/100),0) as NUMERIC(12,5)) ELSE  CAST((select sum(WOJ.JOBI_SELL_PRICE * WOJ.JOBI_DELIVER_QTY * (WOJ.JOBI_DIS_PER)/100) from TBL_WO_JOB_DETAIL WOJ where ID_WODET_SEQ_JOB in (SELECT ID_WODET_SEQ FROM TBL_WO_DETAIL WHERE ID_WO_NO = J.ID_WO_NO and ID_JOB=J.ID_JOB and ID_WO_PREFIX=J.ID_WO_PREFIX)) * (DBT_PER / 100) + CAST((ISNULL(J.WO_TOT_GM_AMT,0) * (J.WO_DISCOUNT/ 100)) * (DBT_PER / 100) as NUMERIC(12,2)) + CAST((ISNULL(J.WO_TOT_LAB_AMT,0) * (J.WO_DISCOUNT/ 100)) * (DBT_PER / 100) as NUMERIC(12,2)) AS NUMERIC(12,5)) END ELSE 0 END),0) + ISNULL(dbo.FETCHOWNRISKAMOUNT(J.ID_WO_NO, J.ID_WO_PREFIX, J.ID_JOB, ISNULL(I.ID_JOB_DEB,0)), 0) - ISNULL(J.OwnRiskVATAmt, 0)AS NUMERIC(12,5)) ELSE CAST(ISNULL(ISNULL(J.WO_TOT_SPARE_AMT,0) * (ISNULL(I.DBT_PER,0) / 100) + ISNULL(J.WO_TOT_LAB_AMT,0) * (ISNULL(I.DBT_PER,0) / 100)+ ISNULL(J.WO_FIXED_PRICE,0) * (ISNULL(I.DBT_PER,0) / 100)+ ISNULL(J.WO_TOT_GM_AMT,0) * (ISNULL(I.DBT_PER,0) / 100),0) - ISNULL((CASE WHEN J.WO_FIXED_PRICE=0.00 THEN CASE WHEN (J.WO_DISCOUNT = ''0.00'' and WO_TOT_DISC_AMT=''0.00'') AND ISNULL(I.WO_SPR_DISCPER,0)=''0.00'' AND ISNULL(I.WO_GM_VATPER,0)=''0.00'' AND ISNULL(I.WO_LBR_VATPER,0)=''0.00'' THEN 0 WHEN ISNULL(I.WO_SPR_DISCPER,0)=''1.00'' AND ISNULL(I.DBT_PER,0) <> ''0.00'' AND ISNULL(I.DBT_AMT,0) > 0.00 THEN CAST(ISNULL((J.WO_TOT_DISC_AMT * ISNULL(I.DBT_PER,0)/100),0) as NUMERIC(12,5)) ELSE  CAST((select sum(WOJ.JOBI_SELL_PRICE * WOJ.JOBI_DELIVER_QTY * (WOJ.JOBI_DIS_PER)/100) from TBL_WO_JOB_DETAIL WOJ where ID_WODET_SEQ_JOB in (SELECT ID_WODET_SEQ FROM TBL_WO_DETAIL WHERE ID_WO_NO = J.ID_WO_NO and ID_JOB=J.ID_JOB and ID_WO_PREFIX=J.ID_WO_PREFIX)) * (DBT_PER / 100) + CAST((ISNULL(J.WO_TOT_GM_AMT,0) * (J.WO_DISCOUNT/ 100)) * (DBT_PER / 100) as NUMERIC(12,2)) + CAST((ISNULL(J.WO_TOT_LAB_AMT,0) * (J.WO_DISCOUNT/ 100)) * (DBT_PER / 100) as NUMERIC(12,2)) AS NUMERIC(12,5)) END ELSE 0 END),0) + ISNULL(dbo.FETCHOWNRISKAMOUNT(J.ID_WO_NO, J.ID_WO_PREFIX, J.ID_JOB, ISNULL(I.ID_JOB_DEB,0)), 0) - ISNULL(J.OwnRiskVATAmt, 0) AS NUMERIC(12,5)) END END AS  ''NET AMOUNT'' ,'''  + convert(varchar(10),@FromDate,103) +  ''' AS FROMDATE,''' + convert(varchar(10),@ToDate,103)  + ''' AS TODATE 
 , convert(decimal(12,2),COST.COSTPRICE) AS COSTPRICE INTO #TEMP1 FROM TBL_WO_HEADER AS A JOIN(SELECT ID_WO_NO,ID_WO_PREFIX,SUM(WO_TOT_SPARE_AMT) AS SPAREAMOUT,SUM(CONVERT(DECIMAL(8,2),(CASE WHEN ISNUMERIC(REPLACE(WO_CHRG_TIME,'','',''.'')) =0 THEN ''0.00'' ELSE REPLACE(WO_CHRG_TIME,'','',''.'')END)))AS CHARGETIME ,((SUM(ISNULL(WO_TOT_SPARE_AMT,0)) + SUM(ISNULL(WO_FIXED_PRICE,0)) + SUM(ISNULL(WO_TOT_GM_AMT,0)) + SUM(ISNULL(WO_TOT_LAB_AMT,0)) + SUM(ISNULL(WO_TOT_VAT_AMT,0))) - SUM(ISNULL(WO_TOT_DISC_AMT,0))) AS TOTALAMOUNT,SUM(WO_TOT_LAB_AMT) AS TOTLABAMT,SUM(WO_TOT_GM_AMT) AS TOTGMAMT, SUM(WO_FIXED_PRICE) AS TOTFIXEDPRICE	 FROM  TBL_WO_DETAIL WHERE JOB_STATUS NOT IN (''DEL'',''INV'') GROUP BY ID_WO_NO,ID_WO_PREFIX) AS B ON (A.ID_WO_PREFIX = B.ID_WO_PREFIX AND A.ID_WO_NO =B.ID_WO_NO) LEFT JOIN ( SELECT ACT.ID_WO_NO,ACT.ID_WO_PREFIX, MAX(DT_CLOCK_IN ) AS LASTCLOCKIN FROM TBL_TR_JOB_ACTUAL ACT,TBL_WO_DETAIL DET WHERE DET.ID_WO_NO=ACT.ID_WO_NO AND DET.ID_WO_PREFIX=ACT.ID_WO_PREFIX AND JOB_STATUS NOT IN (''DEL'',''INV'') GROUP BY ACT.ID_WO_NO,ACT.ID_WO_PREFIX) AS C ON (A.ID_WO_PREFIX = C.ID_WO_PREFIX AND A.ID_WO_NO =C.ID_WO_NO) 
LEFT JOIN( SELECT ID_CUSTOMER ,(CASE WHEN FLG_CUST_NOCREDIT= ''TRUE'' THEN ''Y'' ELSE ''N'' END) AS NOCREDITCUST FROM TBL_MAS_CUSTOMER)AS G ON (A.ID_CUST_WO = G.ID_CUSTOMER ) LEFT JOIN( SELECT ID_WO_NO,ID_WO_PREFIX,ID_JOB,WO_TOT_SPARE_AMT,WO_TOT_LAB_AMT,WO_FIXED_PRICE,WO_TOT_GM_AMT,WO_DISCOUNT,OwnRiskVATAmt,WO_TOT_DISC_AMT FROM TBL_WO_DETAIL) AS J ON (J.ID_WO_NO)=A.ID_WO_NO AND J.ID_WO_PREFIX=A.ID_WO_PREFIX  LEFT JOIN ( SELECT ID_WO_PREFIX,ID_WO_NO,ID_JOB_ID,WO_SPR_DISCPER,DBT_PER,WO_GM_VATPER,DBT_AMT,WO_LBR_VATPER,ID_JOB_DEB FROM TBL_WO_DEBITOR_DETAIL ) AS I ON (I.ID_WO_NO)=J.ID_WO_NO AND I.ID_WO_PREFIX=J.ID_WO_PREFIX AND I.ID_JOB_ID=J.ID_JOB 
LEFT JOIN(SELECT SUM((JOBI_COST_PRICE)*(JOBI_DELIVER_QTY))
  AS COSTPRICE,ID_WO_NO,ID_WO_PREFIX FROM TBL_WO_JOB_DETAIL GROUP BY ID_WO_NO,ID_WO_PREFIX)AS COST ON(COST.ID_WO_NO)=J.ID_WO_NO AND
 COST.ID_WO_PREFIX=J.ID_WO_PREFIX'       
        
--print @MAINQUERY                
               
                          
--CONDITION FOR DEPEARTMENT FROM                          
PRINT LEN(@IV_ID_DEPT_FROM)                          
IF(@IV_ID_DEPT_FROM IS NOT NULL AND LEN(@IV_ID_DEPT_FROM) >0)                            
BEGIN                            
  SET @STATUS = 1                             
   SET @MAINQUERY = @MAINQUERY + ' WHERE A.ID_DEPT >= ( select min(id_dept) from tbl_mas_dept where DPT_Name =''' + @IV_ID_DEPT_FROM  + '''' + ') AND ' + @QUERY2                           
END                            
                       
--CONDITION FOR DEPEARTMENT TO                          
                            
IF(@IV_ID_DEPT_TO IS NOT NULL AND LEN(@IV_ID_DEPT_TO) >0)                            
BEGIN             
 IF(@STATUS = 1 )                            
 BEGIN                            
  SET @STATUS = 1                             
  SET @MAINQUERY = @MAINQUERY + ' AND A.ID_DEPT <= (select max(id_dept) from tbl_mas_dept where DPT_Name = ''' + @IV_ID_DEPT_TO  + ''''+ ') AND ' +@QUERY2                          
 END                            
 ELSE                            
 BEGIN                            
  SET @STATUS = 1                            
  SET @MAINQUERY = @MAINQUERY + ' WHERE A.ID_DEPT <= (select id_dept from tbl_mas_dept where DPT_Name = ''' + @IV_ID_DEPT_TO  + ''''+ ') AND ' +@QUERY2                            
 END                            
END                            
           
 --print @MAINQUERY                            
                          
--CONDITION DATE CREATED FROM                          
                          
IF(@IV_DT_CREATED_FROM IS NOT NULL AND LEN(@IV_DT_CREATED_FROM) >0)                            
BEGIN                            
 IF(@STATUS = 1 )                            
 BEGIN                            
  SET @STATUS = 1                             
 -- SET @MAINQUERY = @MAINQUERY + ' AND CONVERT(CHAR(10),A.DT_CREATED,101)>= ''' + @IV_DT_CREATED_FROM  + ''''+ ' AND '+@QUERY2                              
SET @MAINQUERY = @MAINQUERY + ' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),A.DT_CREATED,105),105) BETWEEN  CONVERT(VARCHAR(10),''' + @IV_DT_CREATED_FROM  + ''',105) AND CONVERT(VARCHAR(10),''' + @IV_DT_CREATED_TO  + ''',105)'  + 'AND '+ @QUERY2                              
 END                            
 ELSE                            
 BEGIN                            
  SET @STATUS = 1                            
 --SET @MAINQUERY = @MAINQUERY + ' WHERE CONVERT(CHAR(10),A.DT_CREATED,101)>= ''' + @IV_DT_CREATED_FROM  + ''''+ ' AND '+@QUERY2                          
SET @MAINQUERY = @MAINQUERY + ' WHERE CONVERT(DATETIME,CONVERT(VARCHAR(10),A.DT_CREATED,105),105) BETWEEN CONVERT(VARCHAR(10),''' + @IV_DT_CREATED_FROM  + ''',105) AND CONVERT(VARCHAR(10),''' + @IV_DT_CREATED_TO  + ''',105)   '+ ' AND '+@QUERY2                          
 END                            
END                            
                          
                          
--CONDITION DATE CREATED TO                          
                          
--IF(@IV_DT_CREATED_TO IS NOT NULL AND LEN(@IV_DT_CREATED_TO) >0)                            
--BEGIN                            
-- IF(@STATUS = 1 )                            
-- BEGIN                       
--  SET @STATUS = 1                             
--  SET @MAINQUERY = @MAINQUERY + ' AND CONVERT(CHAR(10),A.DT_CREATED,101)<= ''' + @IV_DT_CREATED_TO  + ''''+ ' AND ' +@QUERY2                            
-- END                            
-- ELSE                            
-- BEGIN                            
--  SET @STATUS = 1                            
--  SET @MAINQUERY = @MAINQUERY + ' WHERE CONVERT(CHAR(10),A.DT_CREATED,101)<= Convert(CHAR(10),''' + @IV_DT_CREATED_TO  + ''',101)'+ ' AND ' +@QUERY2                          
-- END                            
--END                            
                          
                          
--CONDITION STATUS FROM                          
                          
IF(@IV_WO_STATUS_FROM IS NOT NULL AND LEN(@IV_WO_STATUS_FROM) >0)                            
BEGIN                            
 IF(@STATUS = 1 )                            
 BEGIN                            
  SET @STATUS = 1                             
  SET @MAINQUERY = @MAINQUERY + ' AND A.WO_STATUS>= ''' + @IV_WO_STATUS_FROM  + ''''+ ' AND '+@QUERY2                           
 END                            
 ELSE                            
 BEGIN                            
  SET @STATUS = 1                            
  SET @MAINQUERY = @MAINQUERY + ' WHERE A.WO_STATUS>= ''' + @IV_WO_STATUS_FROM  + ''''+ ' AND ' +@QUERY2                           
 END                            
END                            
                          
                          
--CONDITION STATUS TO                          
                          
IF(@IV_WO_STATUS_TO IS NOT NULL AND LEN(@IV_WO_STATUS_TO) >0)                            
BEGIN                            
 IF(@STATUS = 1 )                            
 BEGIN                            
  SET @STATUS = 1                             
  SET @MAINQUERY = @MAINQUERY + ' AND A.WO_STATUS<= ''' + @IV_WO_STATUS_TO  + ''''+ ' AND ' +@QUERY2                           
 END                            
 ELSE                            
 BEGIN                            
  SET @STATUS = 1                            
  SET @MAINQUERY = @MAINQUERY + ' WHERE A.WO_STATUS <= ''' + @IV_WO_STATUS_TO  + ''''+ ' AND ' +@QUERY2                            
 END                            
END         

SET @QUERY3 = 'SELECT ID_WO_PREFIX,ID_DEPT,DEPTNAME,ID_WO_NO,WO_STATUS,WO_STATUSdesc,DT_CREATED,DT_CREATEDML,ID_CUST_WO,WO_CUST_NAME,CHARGETIME,CHARGETIMEMULTILINGUAL,LASTCLOCKIN,LASTCLOCKINML,SPAREAMOUT,TOTLABAMT,SPAREPARTMULTILINGUAL,TOTLABAMTMULTILINGUAL,TOTALAMOUNT,TOTALAMOUNTMULTILINGUAL,READYTOINVOICE,NOCREDITCUST,CREATED_BY,CAST(TOTGMAMTMULTILINGUAL AS DECIMAL(10,2))TOTGMAMTMULTILINGUAL,CAST(TOTFPAMTMULTILINGUAL AS DECIMAL(10,2))TOTFPAMTMULTILINGUAL,CAST(SUM([NET AMOUNT]) AS DECIMAL(10,2))AS TOTVATEX,CAST((TOTALAMOUNT-SUM([NET AMOUNT]))AS DECIMAL(10,2)) AS TOTVATAMT,  convert(datetime,FROMDATE,103)FROMDATE,convert(datetime,TODATE,103)TODATE,ISNULL(COSTPRICE,0)AS COSTPRICE FROM #TEMP1 GROUP BY CHARGETIME,CHARGETIMEMULTILINGUAL,ID_WO_PREFIX,ID_DEPT,DEPTNAME,ID_WO_NO,WO_STATUS,WO_STATUSdesc,DT_CREATED,DT_CREATEDML,ID_CUST_WO,WO_CUST_NAME,LASTCLOCKIN,LASTCLOCKINML,SPAREAMOUT,TOTLABAMT,SPAREPARTMULTILINGUAL,TOTLABAMTMULTILINGUAL,TOTALAMOUNT,TOTALAMOUNTMULTILINGUAL,READYTOINVOICE,NOCREDITCUST,CREATED_BY,TOTGMAMTMULTILINGUAL,TOTFPAMTMULTILINGUAL,FROMDATE,TODATE,COSTPRICE DROP TABLE #TEMP1'                   
                          
IF(@STATUS = 0 )                          
BEGIN                          
SET @MAINQUERY =@MAINQUERY + ' WHERE '+ @QUERY2                          
END                          
ELSE                          
BEGIN                          
SET @MAINQUERY =   @MAINQUERY   + @QUERY3                        
END      
                          
PRINT @MAINQUERY 
print LEN(@MAINQUERY)
pRINT lEN(@QUERY3)                              
EXEC (@MAINQUERY)                            
         END

GO
