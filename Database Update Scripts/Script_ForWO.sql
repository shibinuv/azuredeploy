---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------

/* WORK ORDER */

DECLARE @ID_SCR_INV INT , @ID_SCR_WO_JOB INT
SELECT @ID_SCR_INV = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='WORK ORDER' AND NAME_SCR ='Invoice' AND NAME_URL='/Transactions/frmInvoice.aspx'

SELECT @ID_SCR_WO_JOB = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='WORK ORDER' AND NAME_SCR ='Work Order Job Details' AND NAME_URL='/Transactions/frmWOJobDetails.aspx'

UPDATE TBL_UTIL_MOD_DETAILS SET NAME_SCR = 'Work Order Job Details' ,NAME_URL='/Transactions/frmWOJobDetails.aspx'
WHERE ID_SCR = @ID_SCR_INV

UPDATE TBL_UTIL_MOD_DETAILS SET NAME_SCR = 'Invoice' ,NAME_URL='/Transactions/frmInvoice.aspx'
WHERE ID_SCR = @ID_SCR_WO_JOB

--To update the text for both in lang tables
SELECT * INTO #Temp_INV
FROM TBL_UTIL_LANG_DETAILS WHERE ID_SCR = @ID_SCR_INV

SELECT * INTO #Temp_WOJOB
FROM TBL_UTIL_LANG_DETAILS WHERE ID_SCR = @ID_SCR_WO_JOB

Update TBL_UTIL_LANG_DETAILS SET ID_SCR = @ID_SCR_WO_JOB
WHERE SLNO in (SELECT SLNO FROM #Temp_INV)

DROP TABLE #Temp_INV
------------------------------------------------------------------------------------------------------------------

UPDATE TBL_UTIL_LANG_DETAILS SET ID_SCR = @ID_SCR_INV
WHERE SLNO in (SELECT SLNO FROM #Temp_WOJOB)

DROP TABLE #Temp_WOJOB



GO
