USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_SPAREPART_FETCH_REPLACEMENT_LIST]    Script Date: 03.04.2020 07:55:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** APPLICATION: MSG *************************************************************        
* MODULE	:      
* FILE NAME : USP_DEPTS_FETCH.PRC        
* PURPOSE	: TO FETCH THE MECHANICS DEPARTMENTS
* AUTHOR	: 
* DATE		: 27.09.2006        
*********************************************************************************************************************/        
/*********************************************************************************************************************          
I/P : -- INPUT PARAMETERS  @P_IVWO, @P_IVPREFIX        
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
        
ALTER PROCEDURE [dbo].[USP_SPR_SPAREPART_FETCH_REPLACEMENT_LIST]  
(
	@ITEM VARCHAR(100),
	@SUPP VARCHAR(100),
	@CATG VARCHAR(100)


)       
AS        
BEGIN       
declare @tempitem as varchar(100)
declare @supplier nvarchar(100)
set @tempitem = @ITEM
set @supplier = @SUPP
if OBJECT_ID('#MOTEMP') is not null
begin
DROP TABLE #MOTEMP
end

CREATE TABLE #MOTEMP(
THIS_ID_ITEM NVARCHAR(30),
ITEM_DESC NVARCHAR(100),
QTY DECIMAL (18,2))  
	
WHILE EXISTS(Select THIS_ID_ITEM From TBL_SPR_REPLACEMENT where REPLACE_ID_ITEM=@tempitem)
Begin
INSERT INTO #MOTEMP Select THIS_ID_ITEM, (select ITEM_DESC from TBL_MAS_ITEM_MASTER where SUPP_CURRENTNO = @supp and ID_ITEM_CATG = @CATG AND id_item = @tempitem) as ITEM_DESC, (select ITEM_AVAIL_QTY from TBL_MAS_ITEM_MASTER where SUPP_CURRENTNO = @supplier and id_item = @tempitem) as QTY From TBL_SPR_REPLACEMENT where REPLACE_ID_ITEM=@tempitem

set @tempitem = (Select THIS_ID_ITEM From TBL_SPR_REPLACEMENT where REPLACE_ID_ITEM=@tempitem)
   
    --Do some processing here


End
set @tempitem = @ITEM
WHILE EXISTS(Select REPLACE_ID_ITEM From TBL_SPR_REPLACEMENT where THIS_ID_ITEM=@tempitem)
Begin
INSERT INTO #MOTEMP Select REPLACE_ID_ITEM, (select ITEM_DESC from TBL_MAS_ITEM_MASTER where SUPP_CURRENTNO = @supp and ID_ITEM_CATG = @CATG and id_item = @tempitem) as ITEM_DESC, (select ITEM_AVAIL_QTY from TBL_MAS_ITEM_MASTER where SUPP_CURRENTNO = @supp and id_item = @tempitem) as QTY From TBL_SPR_REPLACEMENT where THIS_ID_ITEM=@tempitem

set @tempitem = (Select REPLACE_ID_ITEM From TBL_SPR_REPLACEMENT where THIS_ID_ITEM=@tempitem)
   
    --Do some processing here


End

select * from #MOTEMP

END        

