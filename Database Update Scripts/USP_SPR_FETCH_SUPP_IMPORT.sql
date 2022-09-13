/****** Object:  StoredProcedure [dbo].[USP_SPR_FETCH_SUPP_IMPORT]    Script Date: 03-11-2021 11:57:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_FETCH_SUPP_IMPORT]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_FETCH_SUPP_IMPORT]    Script Date: 03-11-2021 11:57:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*************************************** Application: MSG *************************************************************
* Module	: Supplier Import
* File name	: USP_SPR_FETCH_SUPP_IMPORT.PRC
* Purpose	: To fetch LSUPP_IMPORT records
* Author	: Venkatesh Prasad
* Date		: 03.01.2008
*********************************************************************************************************************/
/*********************************************************************************************************************  
I/P : -- Input Parameters
O/P :-- Output Parameters
Error Code
Description
INT.VerNO :  
********************************************************************************************************************/
--'*********************************************************************************'*********************************
--'* Modified History	:   
--'* S.No 	RFC No/Bug ID			Date	     		Author		Description	
--*#0001#
--'*********************************************************************************'*********************************

CREATE PROCEDURE [dbo].[USP_SPR_FETCH_SUPP_IMPORT] (@ID_SUPPLIER As Int)
AS

BEGIN 

	SELECT c.[Name] As FieldName
	FROM syscolumns c INNER JOIN sysobjects o ON o.id = c.id 
	WHERE o.name = 'TBL_SPR_GLOBALSPAREPART' 
			AND c.[Name]NOT IN ('ID_MAKE','ID_ITEM_CATG','ID_ITEM_CATG','ACCOUNT_CODE','FLG_CALC_PRICE',
								'ITEM_REORDER_LEVEL','ID_VAT_CODE','DT_MODIFIED','CREATED_BY','FLG_DUTY','DT_CREATED','MODIFIED_BY','IS_SPARE_P','IS_SPARE_A','SUPP_CURRENTNO','PANT_NO')
	AND c.[Name] NOT IN 
		( SELECT FIELD_NAME 
			FROM TBL_SPR_SUPP_IMPORT 
				WHERE ID_SUPPLIER=@ID_SUPPLIER AND (FLG_DELETE is null or FLG_DELETE<>1))
	UNION
	SELECT 'Replacement_Code'  where not exists (SELECT 1
	FROM TBL_SPR_SUPP_IMPORT 
	WHERE FIELD_NAME in ('Replacement_Code') AND ID_SUPPLIER=@ID_SUPPLIER AND (FLG_DELETE is null or FLG_DELETE<>1))
	UNION
	SELECT 'Replacement_Number' as Replacement_Spare where not exists (SELECT 1
	FROM TBL_SPR_SUPP_IMPORT 
	WHERE FIELD_NAME in ('Replacement_Number') AND ID_SUPPLIER=@ID_SUPPLIER AND (FLG_DELETE is null or FLG_DELETE<>1)) 
	


	SELECT  ID_SUPP_IMPORT,FIELD_NAME,isNull(START_NUM,0) AS START_NUM,isNull(END_NUM,0) AS END_NUM,FILEMODE,isNull(ORDER_OF_FILE,0) AS ORDER_OF_FILE,DELIMITER,isNull(SUPP_LAYOUT_NAME,'') AS SUPP_LAYOUT_NAME,isNull(REMOVE_START_ZERO,0) AS REMOVE_START_ZERO,isNull(REMOVE_BLANK_FIELD,0) AS REMOVE_BLANK_FIELD,isNull(DIVIDE_PRICE_BY_HUNDRED,0) AS DIVIDE_PRICE_BY_HUNDRED,isNull(PRICE_FILE_DEC_SEP,'.') AS PRICE_FILE_DEC_SEP
	FROM TBL_SPR_SUPP_IMPORT 
	WHERE ID_SUPPLIER=@ID_SUPPLIER AND (FLG_DELETE is null or FLG_DELETE<>1)

END



GO
