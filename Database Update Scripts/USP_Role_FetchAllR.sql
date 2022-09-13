/****** Object:  StoredProcedure [dbo].[USP_Role_FetchAllR]    Script Date: 17-06-2022 16:24:09 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_Role_FetchAllR]
GO
/****** Object:  StoredProcedure [dbo].[USP_Role_FetchAllR]    Script Date: 17-06-2022 16:24:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************** Application: MSG *************************************************************
* Module	: Role 
* File name	: [USP_Role_FetchAll]l.PRC
* Purpose	: Select all Role,with their Corresponding ID
* Author	: G.narayana Rao
* Date		: 25.08.2006
*********************************************************************************************************************/
/*********************************************************************************************************************  
I/P : -- Input Parameters
		
@ID_SUBSIDERY_ROLE 
 @ID_DEPT_ROLE 
O/P : -- Output Parameters
		NA
Error Code
INT.VerNO : NOV21.0 
********************************************************************************************************************/
--'*********************************************************************************'*********************************
--'* Modified History	:   
--'* S.No 	RFC No/Bug ID			Date	     		Author		RP_CL_DES	
--* #0001#
--'*********************************************************************************'*********************************
/*
exec  USP_Role_FetchAllR 1,1
exec  USP_Role_FetchAllR 0,0
*/



CREATE PROCEDURE [dbo].[USP_Role_FetchAllR]

(
 @ID_SUBSIDERY_ROLE int ,
 @ID_DEPT_ROLE int 
)
as
Begin
if  (@ID_SUBSIDERY_ROLE= 0 and  @ID_DEPT_ROLE =0)
	begin
		select ID_ROLE,
			NM_ROLE,
			ID_SUBSIDERY_ROLE,
			ID_DEPT_ROLE,
			ID_SCR_START_ROLE,
			isnull(FLG_SYSADMIN,'0') as FLG_SYSADMIN,
			isnull(FLG_SUBSIDADMIN,'0') as FLG_SUBSIDADMIN,
			isnull(FLG_DEPTADMIN,'0') as FLG_DEPTADMIN,
			CREATED_BY,
			DT_CREATED,
			MODIFIED_BY,
			DT_MODIFIED,
			isnull(FLG_NBK,'0') as FLG_NBK,
			isnull(FLG_ACCOUNTING,'0') as FLG_ACCOUNTING,
			isnull(FLG_SPAREPARTORDER,'0') as FLG_SPAREPARTORDER
		from
			 TBL_MAS_ROLE
		where ID_SUBSIDERY_ROLE is null and ID_DEPT_ROLE is null


		end
else if  (@ID_SUBSIDERY_ROLE <> 0 and  @ID_DEPT_ROLE =0)
	begin
		select ID_ROLE,
				NM_ROLE,
				ID_SUBSIDERY_ROLE,
				ID_DEPT_ROLE,
				ID_SCR_START_ROLE,
				isnull(FLG_SYSADMIN,'0') as FLG_SYSADMIN,
				isnull(FLG_SUBSIDADMIN,'0') as FLG_SUBSIDADMIN,
				isnull(FLG_DEPTADMIN,'0') as FLG_DEPTADMIN,
				CREATED_BY,
				DT_CREATED,
				MODIFIED_BY,
				DT_MODIFIED,
				isnull(FLG_NBK,'0') as FLG_NBK,
			isnull(FLG_ACCOUNTING,'0') as FLG_ACCOUNTING,
			isnull(FLG_SPAREPARTORDER,'0') as FLG_SPAREPARTORDER
		from
				 TBL_MAS_ROLE
		where ID_SUBSIDERY_ROLE= @ID_SUBSIDERY_ROLE and ID_DEPT_ROLE is null
		end
else
begin
select ID_ROLE,
			NM_ROLE,
			ID_SUBSIDERY_ROLE,
			ID_DEPT_ROLE,
			ID_SCR_START_ROLE,
			isnull(FLG_SYSADMIN,'0') as FLG_SYSADMIN,
			isnull(FLG_SUBSIDADMIN,'0') as FLG_SUBSIDADMIN,
			isnull(FLG_DEPTADMIN,'0') as FLG_DEPTADMIN,
			CREATED_BY,
			DT_CREATED,
			MODIFIED_BY,
			DT_MODIFIED,
			isnull(FLG_NBK,'0') as FLG_NBK,
			isnull(FLG_ACCOUNTING,'0') as FLG_ACCOUNTING,
			isnull(FLG_SPAREPARTORDER,'0') as FLG_SPAREPARTORDER
			
     from
		 TBL_MAS_ROLE
	where ID_SUBSIDERY_ROLE= @ID_SUBSIDERY_ROLE and ID_DEPT_ROLE=@ID_DEPT_ROLE
End
end
GO
