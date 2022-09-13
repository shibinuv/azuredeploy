/****** Object:  StoredProcedure [dbo].[USP_CREATE_APPOINTMENT_JOB_UPDATE]    Script Date: 22-07-2021 16:22:58 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CREATE_APPOINTMENT_JOB_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[USP_CREATE_APPOINTMENT_JOB_UPDATE]    Script Date: 22-07-2021 16:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** Application: MSG *************************************************************  
* Module : PLANNING  
* File name : 
* Purpose : To add the appointment as a job to an existing order
* Author : 
* Date  : Feb-2021
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
CREATE PROC [dbo].[USP_CREATE_APPOINTMENT_JOB_UPDATE]  
(  
	@iv_appointment_id as varchar(100), -- To fetch the order head information	
	@iv_userid	varchar(20),
	@iv_wo_prefix varchar(100),
	@iv_wo_no varchar(100),
	@iv_retvalue  Varchar(100)  output   
)  
AS  
BEGIN  

	declare @iv_veh_seq varchar(100)             
	declare @iv_mech_id varchar(20)
	declare @iv_lab_desc varchar(200)
	declare @iv_xmlwoDoc_str nvarchar(MAX)=''
	declare @iv_XMLMECHDOC_str nvarchar(MAX)=''
	declare @0V_RETWONO nvarchar(MAX)
	declare @0V_RETVALUE nvarchar(MAX)
	--declare @iv_wo_no varchar(100)
	declare @iv_sub_str varchar(100)
	--declare @iv_wo_prefix varchar(100)
	declare @iv_appointment_detail_id as varchar(100) -- To fetch labour detail information
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
	declare @hp_disc decimal(15,2)
	declare @gm_disc decimal(15,2)
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
	declare @appointment_det_id int
	declare @final_job_total decimal(13,2)=0.00--@final_total
	declare @total_job_vat_amt decimal(13,2)=0.00 --@total_vat_amt
	declare @hp_job_amount decimal(13,2)=0.00 --@hp_amount
	declare @hp_job_disc decimal(13,2)=0.00 --@hp_disc
	declare @gm_job_amount decimal(13,2)=0.00 --@gm_amount
	declare @gm_job_disc decimal(13,2)=0.00 --@gm_disc
	declare @iv_job_hp_time decimal(13,2)=0.00 --@iv_hp_time
	declare @tot_job_disc_final decimal(13,2)=0.00 --@tot_job_disc
	declare @id_job int
	declare @appointment_job_id int
	declare @job_id int

	select @job_id = isnull(max(Id_JOB),0)+1 from TBL_WO_DETAIL where ID_WO_NO=@iv_wo_no and ID_WO_PREFIX=@iv_wo_prefix

	select  @id_subs = id_subsidery_user,@id_dept = id_dept_user from tbl_mas_users where id_login = @iv_userid      
	select    
		@gm_per = wo_gar_matprice_per
		/*id_wo_config,      
		id_subsidery_wo,      
		id_dept_wo,      
		dt_eff_from,      
		dt_eff_to,      
		wo_prefix,      
		wo_series,      
		wo_vat_calcrisk,         
		wo_charege_base,      
		wo_discount_base,
		use_delv_address ,
		wo_id_settings ,
		use_def_cust,
		id_customer ,
		use_cnfrm_dia,
		use_save_job_grid,
		use_va_acc_code,
		va_acc_code,
		use_all_spare_search*/ -- Uncomment if required later
	 from tbl_mas_wo_configuration      
	 where  getdate() between dt_eff_from and dt_eff_to      
	 and id_subsidery_wo = @id_subs and id_dept_wo = @id_dept      

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

	select @iv_ID_CUST_WO = CUSTOMER_NUMBER,
		@iv_WO_VEH_REG_NO = VEHICLE_REG_NO,
		@id_WO_VEH_INTERN_NO = VEHICLE_REF_NO,
		@iv_WO_VEH_VIN = VEHICLE_CH_NO,
		@iv_ID_VEH_SEQ_WO = ID_VEH_SEQ_WO
	from TBL_APPOINTMENTS_HEADER where APPOINTMENT_ID = @iv_appointment_id

	select @iv_WO_VEH_Make_Name = ID_MAKE_VEH, --currently make name is being stored in vehicle table
		@VEH_TYPE = VEH_TYPE,
		@REGN_DATE = DT_VEH_ERGN,
		@id_WO_VEH_MILEAGE=VEH_MILEAGE,
		@ii_WO_VEH_Model = ID_MODEL_VEH,
		@VEH_GRP_DESC = ID_GROUP_VEH,
		@VEH_VAT = ID_VAT_CD from TBL_MAS_VEHICLE where ID_VEH_SEQ=@IV_ID_VEH_SEQ_WO

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

	select distinct APPOINTMENT_ID,ID_JOB into #TBL_APPOINTMENT_DETAILS from TBL_APPOINTMENT_DETAILS where APPOINTMENT_ID=@iv_appointment_id and isnull(JOB_STATUS,'') NOT IN ('DEL') AND ID_WO_NO IS NULL

	/*START PARSING APPOINTMENT DETAILS*/
	declare appointment_jobs cursor 
	for select ID_JOB from #TBL_APPOINTMENT_DETAILS 
	open appointment_jobs
	fetch next from appointment_jobs 
	into @appointment_job_id
	while @@fetch_status = 0
	begin

	exec [USP_CREATE_APPOINTMENT_JOB_ORDER]	@IV_APPOINTMENT_ID, 
	@IV_USERID,
	@iv_wo_no,
	@iv_wo_prefix,
	@appointment_job_id,
	@IV_WO_VEH_MAKE,
	@VEH_GRP_DESC,
	@IV_ID_CUST_WO ,
	@id_subs, 
	@id_dept,
	@VEH_VAT,
	@wo_disc_per,
	@job_id,
	''

	set @job_id = @job_id + 1
	fetch next from appointment_jobs 
	into @appointment_job_id

	end
	close appointment_jobs
	deallocate appointment_jobs		

	DROP TABLE #TBL_APPOINTMENT_DETAILS

	SET @IV_RETVALUE = 'UPD' +';'+ @IV_WO_PREFIX +';'+@IV_WO_NO


	DECLARE @LABEL INT,@WO_ORDER_STATUS VARCHAR(30),@APPOINTMENT_COLOR varchar(40),@ID_SPARE_STATUS int=0
	SELECT @WO_ORDER_STATUS = WO_STATUS FROM TBL_WO_HEADER WHERE ID_WO_NO = @IV_WO_NO AND ID_WO_PREFIX = @IV_WO_PREFIX
	SELECT @LABEL=ID_ORDER_STATUS,@APPOINTMENT_COLOR=ORDER_STATUS_COLOR FROM TBL_WO_ORDER_STATUS WHERE ORDER_STATUS_CODE = @WO_ORDER_STATUS
	-- When there are multiple Lines need to pick the first line
	SELECT @ID_SPARE_STATUS=APT_SAPRE_PART_STATUS from TBL_APPOINTMENT_DETAILS WHERE APPOINTMENT_ID=@IV_APPOINTMENT_ID AND ISNULL(JOB_STATUS,'') <> 'DEL' ORDER BY DT_CREATED DESC

	-- CHANGES START
		DECLARE @CONTROLLED_BY_STATUS bit
		SELECT @CONTROLLED_BY_STATUS=CTRL_BY_STATUS from TBL_APPOINTMENT_CONFIG_SETTINGS

		IF(@CONTROLLED_BY_STATUS = 1)
		BEGIN
			DECLARE @APPOINTMENT_COLOR_ID int
			SELECT @APPOINTMENT_COLOR_ID=ID_APPOINTMENT_COLOR FROM TBL_APPOINTMENT_COLOR WHERE APPOINTMENT_COLOR_CODE = @APPOINTMENT_COLOR
			UPDATE TBL_APPOINTMENT_DETAILS SET COLOR_CODE=@APPOINTMENT_COLOR, COLOR_ID=@APPOINTMENT_COLOR_ID WHERE APPOINTMENT_ID=@IV_APPOINTMENT_ID  AND ISNULL(JOB_STATUS,'') <> 'DEL'
		END
	-- CHANGES END
	IF EXISTS(SELECT * FROM TBL_WO_HEADER where ID_WO_NO=@IV_WO_NO AND ID_WO_PREFIX=@IV_WO_PREFIX)
		BEGIN
			UPDATE TBL_WO_HEADER SET ID_SPARE_STATUS=@ID_SPARE_STATUS where ID_WO_NO=@IV_WO_NO AND ID_WO_PREFIX=@IV_WO_PREFIX
		END

	UPDATE TBL_APPOINTMENTS_HEADER
	SET ID_WO_NO = @IV_WO_NO,ID_WO_PREFIX = @IV_WO_PREFIX,WO_STATUS = @WO_ORDER_STATUS,LABEL =  @LABEL	
	WHERE APPOINTMENT_ID = @IV_APPOINTMENT_ID  AND ISNULL(WO_STATUS,'') <> 'DEL'

	--update TBL_APPOINTMENT_DETAILS
	--	set ID_WO_NO=@iv_wo_no,ID_WO_PREFIX=@iv_wo_prefix,ID_JOB=@id_job
	--where APPOINTMENT_ID=@iv_appointment_id

	PRINT @iv_xmlwoDoc_str
	PRINT @iv_XMLMECHDOC_str
	PRINT @iv_retvalue
END  
  
GO
