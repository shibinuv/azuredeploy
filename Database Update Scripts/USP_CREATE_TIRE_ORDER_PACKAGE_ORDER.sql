/****** Object:  StoredProcedure [dbo].[USP_CREATE_TIRE_ORDER_PACKAGE_ORDER]    Script Date: 01-12-2021 12:52:57 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CREATE_TIRE_ORDER_PACKAGE_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[USP_CREATE_TIRE_ORDER_PACKAGE_ORDER]    Script Date: 01-12-2021 12:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*************************************** Application: MSG *************************************************************  
* Module : ORDER  
* File name : 
* Purpose : TIRE HOTEL PACKAGE TRANSFER TO ORDER
* Author : 
* Date  : Nov-2021
*********************************************************************************************************************/  
/*********************************************************************************************************************    
I/P : -- Input Parameters  
O/P : -- Output Parameters  
 
Error Code  

********************************************************************************************************************/  
--'*********************************************************************************'*********************************  
--'* Modified History :     
--'* S.No  RFC No/Bug ID   Date        Author  Description   
--*  
--'*********************************************************************************'*********************************  
CREATE PROC [dbo].[USP_CREATE_TIRE_ORDER_PACKAGE_ORDER]  
(  
	@Tire_Seq_No as varchar(100), -- To fetch the order head information	
	@IV_USERID	varchar(20),
	@IV_RETVALUE  Varchar(50)  output   
)  
AS  
BEGIN  
	
	declare @iv_id_job int
	declare @iv_veh_seq varchar(100)
	declare @iv_mech_id varchar(20)
	declare @iv_lab_desc varchar(200)
	declare @iv_xmlwoDoc_str nvarchar(MAX)=''
	declare @iv_XMLMECHDOC_str nvarchar(MAX)=''
	declare @0V_RETWONO nvarchar(MAX)
	declare @0V_RETVALUE nvarchar(MAX)
	declare @iv_wo_no varchar(100)
	declare @iv_sub_str varchar(100)
	declare @iv_wo_prefix varchar(100)
	
	declare @hp_amount decimal(13,2)
	declare @VEH_VAT varchar(10)
	declare @mech_count int = 1
	declare @IV_CREATED_BY    VARCHAR(20)            
	declare @ID_DT_DELIVERY    VARCHAR(30)            
	declare @ID_DT_FINISH    VARCHAR(30)            
	declare @ID_DT_ORDER    VARCHAR(30)            
	declare @IV_ID_CUST_WO    VARCHAR(10)            
	declare @IV_CUST_GROUP_ID     VARCHAR(10)            
	declare @IV_ID_PAY_TERMS_WO      VARCHAR(10)            
	declare @IV_ID_PAY_TYPE_WO       VARCHAR(10)            
	declare @IV_ID_VEH_SEQ_WO   INT              
	declare @IV_ID_WO_NO    VARCHAR(10)            
	declare @II_ID_ZIPCODE_WO     VARCHAR(50)              
	declare @IV_WO_ANNOT    VARCHAR(200)            
	declare @IV_WO_CUST_NAME   VARCHAR(100)            
	declare @IV_WO_CUST_PERM_ADD1    VARCHAR(50)            
	declare @IV_WO_CUST_PERM_ADD2    VARCHAR(50)            
	declare @IV_WO_CUST_PHONE_HOME      VARCHAR(20)            
	declare @IV_WO_CUST_PHONE_MOBILE    VARCHAR(20)            
	declare @IV_WO_CUST_PHONE_OFF       VARCHAR(20)            
	declare @IV_WO_STATUS    VARCHAR(20)            
	declare @IV_WO_TM_DELIV    VARCHAR(10)            
	declare @IV_WO_TYPE_WOH    VARCHAR(20)            
	declare @ID_WO_VEH_HRS    DECIMAL(9,2)             
	declare @ID_WO_VEH_INTERN_NO        VARCHAR(15)            
	declare @ID_WO_VEH_MILEAGE          INT              
	declare @IV_WO_VEH_REG_NO   VARCHAR(15)            
	declare @IV_WO_VEH_VIN    VARCHAR(20)            
	declare @II_WO_VEH_MODEL   VARCHAR(10)            
	declare @IV_WO_VEH_MAKE    VARCHAR(10)       
	declare @iv_WO_VEH_Make_Name	VARCHAR(10)       
	declare @IV_CUSTPCOUNTRY   VARCHAR(50)            
	declare @IV_CUSTPSTATE    VARCHAR(50) 
	declare @IV_PKKDate       VARCHAR(50)    
	declare @BUS_PEK_PREVIOUS_NUM VARCHAR(10) = NULL
	declare @BUS_PEK_CONTROL_NUM VARCHAR(20)
	declare @UPDATE_VEH_FLAG	BIT   
	declare @FLG_CONFIGZIPCODE	BIT
	declare @IV_DEPT_ACCNT_NUM VARCHAR(50)
	declare @VA_COST_PRICE decimal(13,2)
	declare @VA_SELL_PRICE decimal(13,2)
	declare @VA_NUMBER VARCHAR(20)
	declare @REGN_DATE VARCHAR(30)
	declare @VEH_TYPE VARCHAR(30)
	declare @VEH_GRP_DESC VARCHAR(10)
	declare @FLG_UPD_MILEAGE BIT
	declare @IV_INT_NOTE   VARCHAR(200)   
	declare @iv_created_date VARCHAR(30)
	declare @iv_ord_date VARCHAR(30) --Should this be current date or appointment date
	declare @ov_HP_PRICE  decimal(11,2)
	declare @ov_HP_DESC   varchar(500)
	declare @iv_hp_time decimal(13,2)
	declare @gm_per decimal(13,2)
	declare @gm_amount decimal(13,2)
	declare @wo_disc_per decimal(5,2)
	declare @hp_disc decimal(5,2)
	declare @gm_disc decimal(5,2)
	declare @id_subs as int      
	declare @id_dept as int      
	declare @hp_vat decimal(10,2)
	declare @gm_vat decimal(10,2) 
	declare @hp_vat_disc decimal(13,2)
	declare @gm_vat_disc decimal(13,2)
	declare @hp_vat_amt decimal(13,2)
	declare @gm_vat_amt decimal(13,2)
	declare @tot_lab_vat_disc decimal(13,2)
	declare @tot_gm_vat_disc decimal(13,2)
	declare @tot_job_disc decimal(13,2)
	declare @total_vat_amt decimal(13,2)
	declare @total_amt decimal(13,2)
	declare @final_total decimal(13,2)
	declare @hp_vat_code varchar(10)
	declare @gm_vat_code varchar(10)
	
	declare @final_job_total decimal(13,2)=0.00--@final_total
	declare @total_job_vat_amt decimal(13,2)=0.00 --@total_vat_amt
	declare @hp_job_amount decimal(13,2)=0.00 --@hp_amount
	declare @hp_job_disc decimal(13,2)=0.00 --@hp_disc
	declare @gm_job_amount decimal(13,2)=0.00 --@gm_amount
	declare @gm_job_disc decimal(13,2)=0.00 --@gm_disc
	declare @iv_job_hp_time decimal(13,2)=0.00 --@iv_hp_time
	declare @tot_job_disc_final decimal(13,2)=0.00 --@tot_job_disc
	declare @job_id int = 1

	select  @id_subs = id_subsidery_user,@id_dept = id_dept_user from tbl_mas_users where id_login = @iv_userid      

	set @iv_created_date=GETDATE()
	set @iv_ord_date=GETDATE()
	Set	@iv_CREATED_BY=@iv_userid
	Set	@id_DT_DELIVERY=N''
	Set	@id_DT_FINISH=N''
	Set	@id_DT_ORDER=@iv_ord_date 
	Set	@iv_ID_WO_NO=N''
	Set	@iv_WO_ANNOT=N''
	Set	@iv_WO_STATUS=N'CSA'
	Set	@iv_WO_TM_DELIV=N''
	Set	@iv_WO_TYPE_WOH=N'ORD'
	Set	@id_WO_VEH_HRS=0
	Set	@IV_CUSTPSTATE=N'' -- Could not find
	Set	@IV_CUSTPCOUNTRY=N''
	Set	@IV_PKKDate=NULL
	Set	@BUS_PEK_PREVIOUS_NUM=NULL
	Set	@BUS_PEK_CONTROL_NUM=NULL
	Set	@UPDATE_VEH_FLAG=0
	Set	@FLG_CONFIGZIPCODE=0
	Set	@IV_DEPT_ACCNT_NUM=N''
	Set	@VA_COST_PRICE=0
	Set	@VA_SELL_PRICE=0
	Set	@VA_NUMBER=NULL
	Set	@FLG_UPD_MILEAGE=0
	Set	@IV_INT_NOTE=N''

/***************GET INTERNAL NO, VIN NO, SEQ NO OF VEHICLE FROM VEHICLE TABLE BASED ON TIRE HOTEL PACKAGE******************/
	select @iv_ID_CUST_WO = custNo, @iv_WO_VEH_REG_NO = regNo
	from TBL_TIRE_ORDER_PACKAGE where Seq_No = @Tire_Seq_No

	select @iv_WO_VEH_Make_Name = ID_MAKE_VEH, --currently make name is being stored in vehicle table
		@id_WO_VEH_INTERN_NO = VEH_INTERN_NO,
		@iv_WO_VEH_VIN = VEH_VIN,
		@iv_ID_VEH_SEQ_WO = ID_VEH_SEQ,
		@VEH_TYPE = VEH_TYPE,
		@REGN_DATE = DT_VEH_ERGN,
		@id_WO_VEH_MILEAGE=VEH_MILEAGE,
		@ii_WO_VEH_Model = ID_MODEL_VEH,
		@VEH_GRP_DESC = ID_GROUP_VEH,
		@VEH_VAT = ID_VAT_CD from TBL_MAS_VEHICLE where VEH_REG_NO=@iv_WO_VEH_REG_NO

	select @IV_WO_VEH_MAKE = ID_MAKE from TBL_MAS_MAKE
	where ID_MAKE_NAME = @iv_WO_VEH_Make_Name

	select @iv_WO_CUST_NAME = CUST_NAME,
		@iv_CUST_GROUP_ID = ID_CUST_GROUP,
		@iv_WO_CUST_PHONE_OFF = CUST_PHONE_OFF,
		@iv_WO_CUST_PHONE_HOME = CUST_PHONE_HOME,
		@iv_WO_CUST_PHONE_MOBILE = CUST_PHONE_MOBILE,
		@iv_WO_CUST_PERM_ADD1 = CUST_PERM_ADD1,
		@iv_WO_CUST_PERM_ADD2 = CUST_PERM_ADD2,
		@ii_ID_ZIPCODE_WO = ID_CUST_BILL_ZIPCODE,
		@iv_ID_PAY_TYPE_WO = ID_CUST_PAY_TYPE,
		@iv_ID_PAY_TERMS_WO = ID_CUST_PAY_TERM,
		@IV_CUSTPCOUNTRY = CUST_COUNTRY,
		@wo_disc_per = isnull(CUST_DISC_LABOUR,0)
	from TBL_MAS_CUSTOMER where ID_CUSTOMER = @IV_ID_CUST_WO

	exec usp_WO_HEADER_INSERT 
	 @IV_CREATED_BY	,
	 @ID_DT_DELIVERY	,
	 @ID_DT_FINISH	,
	 @ID_DT_ORDER	,
	 @IV_ID_CUST_WO	,
	 @IV_CUST_GROUP_ID	,
	 @IV_ID_PAY_TERMS_WO	,
	 @IV_ID_PAY_TYPE_WO	,
	 @IV_ID_VEH_SEQ_WO	,
	 @IV_ID_WO_NO	,
	 @II_ID_ZIPCODE_WO	,
	 @IV_WO_ANNOT	,
	 @IV_WO_CUST_NAME	,
	 @IV_WO_CUST_PERM_ADD1	,
	 @IV_WO_CUST_PERM_ADD2	,
	 @IV_WO_CUST_PHONE_HOME	,
	 @IV_WO_CUST_PHONE_MOBILE	,
	 @IV_WO_CUST_PHONE_OFF	,
	 @IV_WO_STATUS	,
	 @IV_WO_TM_DELIV	,
	 @IV_WO_TYPE_WOH	,
	 @ID_WO_VEH_HRS	,
	 @ID_WO_VEH_INTERN_NO	,
	 @ID_WO_VEH_MILEAGE	,
	 @IV_WO_VEH_REG_NO	,
	 @IV_WO_VEH_VIN	,
	 @II_WO_VEH_MODEL	,
	 @iv_WO_VEH_Make_Name	,
	 @IV_CUSTPCOUNTRY	,
	 @IV_CUSTPSTATE	,
	 @IV_PKKDate	,
	 @BUS_PEK_PREVIOUS_NUM	,
	 @BUS_PEK_CONTROL_NUM	,
	 @0V_RETVALUE	OUTPUT,
	 @0V_RETWONO	OUTPUT,
	 @UPDATE_VEH_FLAG	,
	 @FLG_CONFIGZIPCODE	,
	 @IV_DEPT_ACCNT_NUM	,
	 @VA_COST_PRICE	,
	 @VA_SELL_PRICE	,
	 @VA_NUMBER	,
	 @REGN_DATE,
	 @VEH_TYPE	,
	 @VEH_GRP_DESC 	,
	 @FLG_UPD_MILEAGE	,
	 @IV_INT_NOTE	

	SELECT @iv_wo_no = SUBSTRING(@0V_RETWONO, 1, CHARINDEX(';', @0V_RETWONO)-1)
	SELECT @iv_sub_str = SUBSTRING(@0V_RETWONO, CHARINDEX(';', @0V_RETWONO)+1, LEN(@0V_RETWONO))
	SELECT @iv_wo_prefix = SUBSTRING(@iv_sub_str, 1, CHARINDEX(';', @iv_sub_str)-1)

	exec [USP_CREATE_TIRE_ORDER_PACKAGE_JOB]	@Tire_Seq_No, 
	@IV_USERID,
	@iv_wo_no,
	@iv_wo_prefix,
	1,
	@IV_WO_VEH_MAKE,
	@VEH_GRP_DESC,
	@IV_ID_CUST_WO ,
	@id_subs, 
	@id_dept,
	@VEH_VAT,
	@wo_disc_per,
	@job_id,
	''


	SET @IV_RETVALUE = 'INS' +';'+ @IV_WO_PREFIX +';'+@IV_WO_NO


	PRINT @IV_RETVALUE
END  
  
GO
