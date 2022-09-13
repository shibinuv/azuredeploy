/****** Object:  StoredProcedure [dbo].[USP_Fetch_Department_New]    Script Date: 27-05-2022 18:09:26 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_Fetch_Department_New]
GO
/****** Object:  StoredProcedure [dbo].[USP_Fetch_Department_New]    Script Date: 27-05-2022 18:09:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
create Procedure [dbo].[USP_Fetch_Department_New]    
(    
	@ID_Department as int    
)        
as    
begin        
	select 
		ID_Dept,
		ID_SUBSIDERY_DEPT,
		DPT_Name,
		DPT_Mgr_Name,
		DPT_Address1,     
		DPT_Location,
		DPT_Phone,    
		DPT_Phone_Mobile,
		FLG_DPT_WareHouse,    
		DPT_ID_Zipcode as ID_ZIPCODE,
		DPT_Address2,      
		TMD.CREATED_BY,
		TMD.DT_CREATED,     
		TMD.MODIFIED_BY,
		TMD.DT_MODIFIED ,
		DPT_ACCCODE,DEPTDISCODE,     
		ID_MAKE, 
		ID_ITEM_CATEG,
		RP_ID_MAKE,
		RP_ID_ITEM_CATG, 
		Flg_Validation_Req,
		FLG_EXPORT_SUPPLIER, 
		OWNRISK_ACCTCODE,
		LUNCH_WITHDRAW,
		FROM_TIME,
		TO_TIME,
		 FLG_INTCUST_EXP,
		 ID_TEMPLATE,
		 TMZ.ZIP_CITY AS City,
		 C.DESCRIPTION AS COUNTRY,
		 S.DESCRIPTION AS STATE
	from TBL_MAS_DEPT   TMD  
	
	left outer join 

	TBL_MAS_ZIPCODE TMZ
	ON TMD.DPT_ID_Zipcode = TMZ.ZIP_ZIPCODE

	left outer join TBL_MAS_CONFIG_DETAILS c on c.ID_PARAM=TMZ.ZIP_ID_COUNTRY 
left outer join TBL_MAS_CONFIG_DETAILS s on s.ID_PARAM=TMZ.ZIP_ID_STATE

	where ID_Dept = @ID_Department      
end      
      
      
    
--USP_Fetch_Department 2    
  
  
GO
