USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_TIMEREG_HISTORY_FETCH]    Script Date: 27.03.2020 08.47.13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
/*************************************** APPLICATION: MSG *************************************************************  
* MODULE : MASTER  
* FILE NAME : USP_MAS_VEHICLE_SEARCH.PRC  
* PURPOSE : TO SEARCH VEHICLE INFORMATION.   
* AUTHOR : MARTIN.  
* DATE  : 25.03.2020  
*********************************************************************************************************************/  
/*********************************************************************************************************************    
I/P : -- INPUT PARAMETERS  
O/P : -- OUTPUT PARAMETERS  
ERROR CODE  
DESCRIPTION  
INT.VerNO : NOV21.0  
********************************************************************************************************************/  
--'*********************************************************************************'*********************************  
--'* MODIFIED HISTORY :     
--'* S.NO  RFC NO/BUG ID   DATE        AUTHOR  DESCRIPTION   
--*#0001#  
--'*********************************************************************************'*********************************  
 CREATE PROCEDURE [dbo].[USP_TIMEREG_HISTORY_FETCH]  
(      
	@ORDERNO		VARCHAR(20),   
	@MECH			VARCHAR(20),
	@CLOCKINDATE	VARCHAR(20),
	@CLOCKIN		BIT,
	@CLOCKINORDER   BIT
)  
AS  
--BEGIN  
--	SELECT TR.ID_TR_SEQ, ISNULL(TR.ID_WO_NO, '') AS ID_WO_NO, ISNULL(TR.ID_JOB, '') AS ID_JOB, TR.ID_MEC_TR, LD.SL_NO, LD.WO_LABOUR_DESC, TR.DT_CLOCK_IN, TR.DT_CLOCK_OUT, TR.TOTAL_CLOCKED_TIME  FROM TBL_TR_JOB_ACTUAL TR LEFT JOIN TBL_WO_LABOUR_DETAIL LD ON TR.ID_WO_LAB_SEQ = LD.ID_WOLAB_SEQ
--	ORDER BY TR.DT_CREATED DESC
--END  

BEGIN
DECLARE @MAINQRY AS NVARCHAR(MAX)
DECLARE @CQRY AS NVARCHAR(MAX) = ''

SET @MAINQRY = N'SELECT TR.ID_TR_SEQ, ISNULL(TR.ID_WO_NO, '''') AS ID_WO_NO, ISNULL(TR.ID_JOB, '''') AS ID_JOB, TR.ID_MEC_TR, LD.SL_NO, LD.WO_LABOUR_DESC, TR.DT_CLOCK_IN, TR.DT_CLOCK_OUT, TR.TOTAL_CLOCKED_TIME  
FROM TBL_TR_JOB_ACTUAL TR LEFT JOIN TBL_WO_LABOUR_DETAIL LD ON TR.ID_WO_LAB_SEQ = LD.ID_WOLAB_SEQ WHERE TR.ID_TR_SEQ > 0'

	IF @ORDERNO <> ''
		SET @CQRY = @CQRY + ' AND TR.ID_WO_PREFIX+TR.ID_WO_NO = '''+ @ORDERNO+''''
						                                        

	IF @MECH <> '' 
		SET @CQRY = @CQRY + ' AND TR.ID_MEC_TR = ''' + @MECH + ''''


	IF @CLOCKINDATE <> ''
		SET @CQRY = @CQRY + ' AND TR.DT_CLOCK_IN > ''' + @CLOCKINDATE +'''' + ' AND TR.DT_CLOCK_IN < ''' + @CLOCKINDATE + ' 23:59:59'''
	
	IF @CLOCKIN = 1 AND  @CLOCKINORDER = 0
		SET @CQRY = @CQRY +  ' AND ID_WO_NO IS NULL'

	ELSE IF @CLOCKIN = 0 AND  @CLOCKINORDER = 1
		SET @CQRY = @CQRY +  ' AND ID_WO_NO IS NOT NULL'


	IF @CQRY <> ''
		SET @MAINQRY = @MAINQRY + @CQRY + ' ORDER BY TR.DT_CREATED DESC'
		print @MAINQRY

	EXEC (@MAINQRY) 	

END
  
