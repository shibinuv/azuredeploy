/****** Object:  StoredProcedure [dbo].[USP_WO_REPLACEMENT]    Script Date: 07-10-2021 20:04:38 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_WO_REPLACEMENT]
GO
/****** Object:  StoredProcedure [dbo].[USP_WO_REPLACEMENT]    Script Date: 07-10-2021 20:04:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*************************************** Application: MSG *************************************************************      
* Module : Work Order     
* File name :USP_WO_REPLACEMENT.prc      
* Purpose : To Get New Replacement SparePart ID, by passing old id    
* Author :    
* Date  : 17.07.2008    
*********************************************************************************************************************/      
CREATE  PROC [dbo].[USP_WO_REPLACEMENT]     
(    
   
 @IV_ID_LOCALSPAREPART VARCHAR(20) , 
 @IV_ID_MAKE  VARCHAR(20) ,                
 @IV_USERID  VARCHAR(20),
 @FLAG VARCHAR(10)       
)

AS      
BEGIN 

	DECLARE @WAREHOUSEID INT  
	SELECT @WAREHOUSEID=ID_WAREHOUSE FROM TBL_MAS_USERS   
	INNER JOIN TBL_SPR_DEPT_WH ON ID_DEPARTMENT =ID_DEPT_USER 
	AND FLG_DEFAULT=1 WHERE ID_LOGIN =@IV_USERID  

	IF @FLAG = 'NEW'
	BEGIN
		SELECT DISTINCT REPLACE_ID_ITEM
		FROM TBL_MAS_ITEM_MASTER MAS1
		INNER JOIN
		TBL_SPR_REPLACEMENT REP
		ON REP.THIS_ID_ITEM=@IV_ID_LOCALSPAREPART
		AND REP.THIS_ID_ITEM=MAS1.ID_ITEM
		AND REP.THIS_SUPP_CURRENTNO=MAS1.SUPP_CURRENTNO
		And REP.THIS_SUPP_CURRENTNO=@IV_ID_MAKE
		INNER JOIN
		TBL_MAS_ITEM_MASTER MAS2
		ON MAS1.ID_WH_ITEM=MAS2.ID_WH_ITEM
		AND MAS2.ID_ITEM=REP.REPLACE_ID_ITEM
		AND MAS1.ID_WH_ITEM=@WAREHOUSEID
	END
	-- ***********************************
	-- Modified Date : 26th February 2009
	-- Bug ID		 : Warrenty List V15 - 233
	ELSE
	BEGIN
		SELECT DISTINCT THIS_ID_ITEM
		FROM TBL_MAS_ITEM_MASTER MAS1
		INNER JOIN
		TBL_SPR_REPLACEMENT REP
		ON REP.REPLACE_ID_ITEM=@IV_ID_LOCALSPAREPART
		AND REP.REPLACE_ID_ITEM=MAS1.ID_ITEM
		AND REP.THIS_SUPP_CURRENTNO=MAS1.SUPP_CURRENTNO
		And REP.THIS_SUPP_CURRENTNO=@IV_ID_MAKE
		INNER JOIN
		TBL_MAS_ITEM_MASTER MAS2
		ON MAS1.ID_WH_ITEM=MAS2.ID_WH_ITEM
		AND MAS2.ID_ITEM=REP.THIS_ID_ITEM
		AND MAS1.ID_WH_ITEM=@WAREHOUSEID
	END
-- **************** End OF MOdification **************
END  


--USP_WO_REPLACEMENT 'Y SPARE 2','YMAKE','admin'

GO
