/****** Object:  StoredProcedure [dbo].[USP_CREATE_APPOINTMENT_JOB_ORDER]    Script Date: 28-05-2021 16:03:29 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CREATE_APPOINTMENT_JOB_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[USP_CREATE_APPOINTMENT_JOB_ORDER]    Script Date: 28-05-2021 16:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*************************************** Application: MSG *************************************************************  
* Module : PLANNING  
* File name : 
* Purpose : To add the appointment as a job for an order
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
CREATE PROC [dbo].[USP_CREATE_APPOINTMENT_JOB_ORDER]  
(  
	@IV_APPOINTMENT_ID as varchar(100), -- To fetch the order head information	
	@IV_USERID	varchar(20),
	@iv_wo_no varchar(100),
	@iv_wo_prefix varchar(100),
	@iv_id_job int,
	@IV_WO_VEH_MAKE    VARCHAR(10),
	@VEH_GRP_DESC VARCHAR(10),
	@IV_ID_CUST_WO    VARCHAR(10)   ,
	@id_subs as int     , 
	@id_dept as int    ,
	@VEH_VAT varchar(10),
	@wo_disc_per decimal(5,2),
	@job_id int,
	@IV_RETVALUE  Varchar(50)  output   
)  
AS  
BEGIN  
	
	declare  @iv_appointment_detail_id int
	declare @iv_lab_desc varchar(200)	
	declare @iv_mech_id varchar(20)
	declare @iv_hp_time decimal(13,2)
	declare @appointment_det_id int
	declare @ov_HP_PRICE  decimal(11,2)
	declare @ov_HP_DESC   varchar(500)
	declare @hp_vat_code varchar(10)
	declare @gm_vat_code varchar(10)
	declare @hp_vat decimal(10,2)
	declare @gm_vat decimal(10,2) 
	--SELECT @0V_RETVALUE '@0V_RETVALUE',@0V_RETWONO '@0V_RETWONO
	declare @hp_amount decimal(13,2)
	declare @gm_per decimal(13,2)
	declare @gm_amount decimal(13,2)
	declare @hp_disc decimal(5,2)
	declare @gm_disc decimal(5,2)
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
	declare @final_job_total decimal(13,2)=0.00--@final_total
	declare @total_job_vat_amt decimal(13,2)=0.00 --@total_vat_amt
	declare @hp_job_amount decimal(13,2)=0.00 --@hp_amount
	declare @hp_job_disc decimal(13,2)=0.00 --@hp_disc
	declare @gm_job_amount decimal(13,2)=0.00 --@gm_amount
	declare @gm_job_disc decimal(13,2)=0.00 --@gm_disc
	declare @iv_job_hp_time decimal(13,2)=0.00 --@iv_hp_time
	declare @tot_job_disc_final decimal(13,2)=0.00 --@tot_job_disc
	declare @iv_xmlwoDoc_str nvarchar(MAX)=''
	declare @iv_XMLMECHDOC_str nvarchar(MAX)=''
	declare @iv_xmljobDoc_str nvarchar(MAX)=''
	declare @iv_XMLDISDOC_str nvarchar(MAX)=''
	declare @mech_count int = 1
	declare @iv_created_date VARCHAR(30)

	declare @app_textline1 varchar(50)
	declare @app_textline2 varchar(50)
	declare @app_textline3 varchar(50)
	declare @app_textline4 varchar(50)
	declare @app_textline5 varchar(50)
	declare @textcount int
	declare @id_wh varchar(10)
	--SELECT @iv_wo_prefix '@iv_wo_prefix',@iv_wo_no '@iv_wo_no'
	select top 1 @id_wh = ID_WH from TBL_MAS_ITEM_WAREHOUSE where ID_SUBSIDERY=@id_subs

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


	/*START PARSING APPOINTMENT DETAILS*/
	declare appointment_details cursor 
	for select id_appointment_details from TBL_APPOINTMENT_DETAILS where appointment_id = @iv_appointment_id and isnull(JOB_STATUS,'') NOT IN('DEL') and ID_JOB = @iv_id_job
	open appointment_details
	fetch next from appointment_details 
	into @appointment_det_id
	while @@fetch_status = 0
	begin

	select @iv_appointment_detail_id=ID_APPOINTMENT_DETAILS,
			@iv_lab_desc = [RESERVATION],--CHANGED FROM TEXT to RESERVATION
			@iv_mech_id = RESOURCE_ID,
			@iv_hp_time = DATEDIFF(MI,START_TIME,END_TIME)/60.00 
		from TBL_APPOINTMENT_DETAILS where id_appointment_details = @appointment_det_id and isnull(JOB_STATUS,'')NOT IN('DEL')

	exec USP_WO_GetHPPrice
	 @iv_userid,        
	 @iv_WO_VEH_Make,
	 @IV_ID_CUST_WO,        
	 NULL,        
	 NULL,        
	 @VEH_GRP_DESC,  
	 N'',   
	 @ov_HP_PRICE  output,        
	 @ov_HP_DESC  output      

	 set @hp_vat_code = @ov_HP_DESC

	 exec usp_rp_gmprice_fetch @IV_ID_CUST_WO, @id_subs, @id_dept,@gm_vat_code output

	 SELECT                     
	  @hp_vat = ISNULL(VAT_PER,'0.00')                                             
	 FROM                     
	 TBL_VAT_DETAIL                    
	 WHERE                    
	 VAT_CUST =(SELECT ID_VAT_CD FROM TBL_MAS_CUST_GROUP WHERE ID_CUST_GRP_SEQ = 
	 (SELECT ID_CUST_GROUP FROM TBL_MAS_CUSTOMER WHERE ID_CUSTOMER=@IV_ID_CUST_WO))                     
	  AND                    
	 VAT_VEH = @VEH_VAT                  
	  AND                    
	 VAT_ITEM = (SELECT DISTINCT HP_Vat FROM TBL_MAS_HP_RATE WHERE HP_Vat =@hp_vat_code)              
	  AND                    
	 GETDATE() BETWEEN DT_EFF_FROM AND DT_EFF_TO   
	 
	-- select '@VEH_VAT', @VEH_VAT,'@IV_ID_CUST_WO',@IV_ID_CUST_WO,'@gm_vat_code',@gm_vat_code

	 SELECT                     
	  @gm_vat = ISNULL(VAT_PER,'0.00')                 
	 FROM                     
	 TBL_VAT_DETAIL                    
	 WHERE                    
	 VAT_CUST =(SELECT ID_VAT_CD FROM TBL_MAS_CUST_GROUP WHERE ID_CUST_GRP_SEQ = 
		(SELECT ID_CUST_GROUP FROM TBL_MAS_CUSTOMER WHERE ID_CUSTOMER=@IV_ID_CUST_WO))                     
	  AND                    
	 VAT_VEH = @VEH_VAT                   
	  AND                    
	 VAT_ITEM = (SELECT DISTINCT ID_Vat FROM TBL_MAS_CUST_GRP_GM_PRICE_MAP WHERE ID_Vat =@gm_vat_code)              
	  AND                    
	 GETDATE() BETWEEN DT_EFF_FROM AND DT_EFF_TO 

	 --select '@gm_vat',@gm_vat


	 set @hp_amount = @ov_HP_PRICE * @iv_hp_time
	 set @gm_amount = @hp_amount * (@gm_per/100.00)
	 set @total_amt = @hp_amount + @gm_amount
	 set @hp_disc  = @hp_amount * (@wo_disc_per/100.00)
	 set @gm_disc   = @gm_amount * (@wo_disc_per/100.00)
	 
	 set @hp_vat_amt = @hp_amount * (@hp_vat/100.00)
	 set @gm_vat_amt = @gm_amount * (@gm_vat/100.00)

	 set @tot_lab_vat_disc = @hp_vat_amt * (@wo_disc_per/100.00)
	 set @tot_gm_vat_disc = @gm_vat_amt * (@wo_disc_per/100.00)
	 set @total_vat_amt = @hp_vat_amt + @gm_vat_amt

	 set @tot_job_disc = @hp_disc + @gm_disc + @tot_lab_vat_disc + @tot_gm_vat_disc

	 set @final_total = @total_amt + @total_vat_amt - @tot_job_disc

	 set @final_job_total = @final_job_total + @final_total
	 set @total_job_vat_amt = @total_job_vat_amt+ @total_vat_amt --@total_vat_amt
	 set @hp_job_amount =  @hp_job_amount+@hp_amount--@hp_amount
	 set @hp_job_disc = @hp_job_disc+@hp_disc--@hp_disc
	 set @gm_job_amount = @gm_job_amount+@gm_amount--@gm_amount
	 set @gm_job_disc = @gm_job_disc+@gm_disc--@gm_disc
	 set @iv_job_hp_time = @iv_job_hp_time+@iv_hp_time --@iv_hp_time
	 set @tot_job_disc_final = @tot_job_disc_final+@tot_job_disc --@tot_job_disc

	 select @iv_id_job 'id_job',@hp_amount '@hp_amount',@gm_amount '@gm_amount',@hp_disc '@hp_disc',@gm_disc '@gm_disc',@tot_lab_vat_disc '@tot_lab_vat_disc',@tot_gm_vat_disc '@tot_gm_vat_disc',@hp_vat_amt '@hp_vat_amt',@gm_vat_amt '@gm_vat_amt',@total_vat_amt '@total_vat_amt',@tot_job_disc '@tot_job_disc',@total_amt ' @total_amt',@final_total '@final_total'
	 select @iv_id_job 'id_job',@final_job_total '@final_job_total ',@total_job_vat_amt  '@total_job_vat_amt  ',	@hp_job_amount  '@hp_job_amount  ',	@hp_job_disc  '@hp_job_disc  ',	@gm_job_amount '@gm_job_amount  ',	@gm_job_disc  '@gm_job_disc  ',	@iv_job_hp_time  '@iv_job_hp_time  ',@tot_job_disc_final  '@tot_job_disc_final  '

	set @iv_XMLMECHDOC_str = @iv_XMLMECHDOC_str + '<insert ID_MECH="'+@iv_mech_id+'" Id_Sl_No="'+convert(varchar(20),@mech_count)+'" ID_WOLAB_SEQ = "" LabourDesc = "'+@iv_lab_desc+'"  Wo_Lab_Hrs = "'+convert(varchar(20),@iv_hp_time)+'" HourlyPr = "'+convert(varchar(20),@ov_HP_PRICE)+'" WO_Lab_Discount = "'+convert(varchar(20),@wo_disc_per)+'"  
	LineType ="L" />'

	---------START - NEW CHANGES FOR ADDING TEXT LINES--------------
	--TBL_APPOINTMENT_TEXT_JOB  -- NEW TABLE TO HOLD THE ALREADY INSERTED TEXT LINES
	set @textcount = 1
	SELECT @app_textline1 = trim(isnull(TEXT_LINE1,'')), @app_textline2 = trim(isnull(TEXT_LINE2,'')), @app_textline3 = trim(isnull(TEXT_LINE3,'')), @app_textline4 = trim(isnull(TEXT_LINE4,'')), @app_textline5 = trim(isnull(TEXT_LINE5,'')) FROM TBL_APPOINTMENT_DETAILS WHERE ID_APPOINTMENT_DETAILS = @appointment_det_id 
	if(@app_textline1<>'')
		BEGIN
			set @iv_xmljobDoc_str = @iv_xmljobDoc_str + '<insert ID_ITEM_JOB ="" ID_MAKE_JOB = "" ID_WAREHOUSE = "'+@id_wh+'" ID_ITEM_CATG_JOB = "" JOBI_ORDER_QTY = "0" JOBI_DELIVER_QTY= "0" JOBI_BO_QTY ="0.00" JOBI_DIS_PER ="0" JOBI_VAT_PER ="0" ORDER_LINE_TEXT =""  JOBI_SELL_PRICE ="0" JOBI_COST_PRICE = "0.0" ID_CUST_WO = "'+@IV_ID_CUST_WO+'" TEXT ="'+@app_textline1+'" TD_CALC ="True " ITEM_DESC="" PICKINGLIST_PREV_PRINTED ="False" DELIVERYNOTE_PREV_PRINTED ="False" PREV_PICKED ="0" SPARE_TYPE="ORD" FLG_FORCE_VAT ="False "  FLG_EDIT_SP="False" EXPORT_TYPE="" Id_Sl_No="'+convert(varchar(20),@mech_count+@textcount)+'" LineType ="T" SPARE_DISCOUNT="0" />'
			set @iv_XMLDISDOC_str = @iv_XMLDISDOC_str + '<insert ID_DEBTOR ="'+@IV_ID_CUST_WO+'" ID_ITEM = "" ID_MAKE = "" ID_WAREHOUSE = "'+@id_wh+'" DBT_VAT_AMOUNT = "0" DBT_DIS_AMT="0" JOB_VAT_PER="0" JOB_VAT_SEQ="0" JOB_DIS_SEQ="0" JOB_DIS_PER="0" />'
			set @textcount = @textcount + 1
		END
	if(@app_textline2<>'')
		BEGIN
			set @iv_xmljobDoc_str = @iv_xmljobDoc_str + '<insert ID_ITEM_JOB ="" ID_MAKE_JOB = "" ID_WAREHOUSE = "'+@id_wh+'" ID_ITEM_CATG_JOB = "" JOBI_ORDER_QTY = "0" JOBI_DELIVER_QTY= "0" JOBI_BO_QTY ="0.00" JOBI_DIS_PER ="0" JOBI_VAT_PER ="0" ORDER_LINE_TEXT =""  JOBI_SELL_PRICE ="0" JOBI_COST_PRICE = "0.0" ID_CUST_WO = "'+@IV_ID_CUST_WO+'" TEXT ="'+@app_textline2+'" TD_CALC ="True " ITEM_DESC="" PICKINGLIST_PREV_PRINTED ="False" DELIVERYNOTE_PREV_PRINTED ="False" PREV_PICKED ="0" SPARE_TYPE="ORD" FLG_FORCE_VAT ="False "  FLG_EDIT_SP="False" EXPORT_TYPE="" Id_Sl_No="'+convert(varchar(20),@mech_count+@textcount)+'" LineType ="T" SPARE_DISCOUNT="0" />'
			set @iv_XMLDISDOC_str = @iv_XMLDISDOC_str + '<insert ID_DEBTOR ="'+@IV_ID_CUST_WO+'" ID_ITEM = "" ID_MAKE = "" ID_WAREHOUSE = "'+@id_wh+'" DBT_VAT_AMOUNT = "0" DBT_DIS_AMT="0" JOB_VAT_PER="0" JOB_VAT_SEQ="0" JOB_DIS_SEQ="0" JOB_DIS_PER="0" />'
			set @textcount = @textcount + 1
		END
	if(@app_textline3<>'')
		BEGIN
			set @iv_xmljobDoc_str = @iv_xmljobDoc_str + '<insert ID_ITEM_JOB ="" ID_MAKE_JOB = "" ID_WAREHOUSE = "'+@id_wh+'" ID_ITEM_CATG_JOB = "" JOBI_ORDER_QTY = "0" JOBI_DELIVER_QTY= "0" JOBI_BO_QTY ="0.00" JOBI_DIS_PER ="0" JOBI_VAT_PER ="0" ORDER_LINE_TEXT =""  JOBI_SELL_PRICE ="0" JOBI_COST_PRICE = "0.0" ID_CUST_WO = "'+@IV_ID_CUST_WO+'" TEXT ="'+@app_textline3+'" TD_CALC ="True " ITEM_DESC="" PICKINGLIST_PREV_PRINTED ="False" DELIVERYNOTE_PREV_PRINTED ="False" PREV_PICKED ="0" SPARE_TYPE="ORD" FLG_FORCE_VAT ="False "  FLG_EDIT_SP="False" EXPORT_TYPE="" Id_Sl_No="'+convert(varchar(20),@mech_count+@textcount)+'" LineType ="T" SPARE_DISCOUNT="0" />'
			set @iv_XMLDISDOC_str = @iv_XMLDISDOC_str + '<insert ID_DEBTOR ="'+@IV_ID_CUST_WO+'" ID_ITEM = "" ID_MAKE = "" ID_WAREHOUSE = "'+@id_wh+'" DBT_VAT_AMOUNT = "0" DBT_DIS_AMT="0" JOB_VAT_PER="0" JOB_VAT_SEQ="0" JOB_DIS_SEQ="0" JOB_DIS_PER="0" />'
			set @textcount = @textcount + 1
		END
	if(@app_textline4<>'')
		BEGIN
			set @iv_xmljobDoc_str = @iv_xmljobDoc_str + '<insert ID_ITEM_JOB ="" ID_MAKE_JOB = "" ID_WAREHOUSE = "'+@id_wh+'" ID_ITEM_CATG_JOB = "" JOBI_ORDER_QTY = "0" JOBI_DELIVER_QTY= "0" JOBI_BO_QTY ="0.00" JOBI_DIS_PER ="0" JOBI_VAT_PER ="0" ORDER_LINE_TEXT =""  JOBI_SELL_PRICE ="0" JOBI_COST_PRICE = "0.0" ID_CUST_WO = "'+@IV_ID_CUST_WO+'" TEXT ="'+@app_textline4+'" TD_CALC ="True " ITEM_DESC="" PICKINGLIST_PREV_PRINTED ="False" DELIVERYNOTE_PREV_PRINTED ="False" PREV_PICKED ="0" SPARE_TYPE="ORD" FLG_FORCE_VAT ="False "  FLG_EDIT_SP="False" EXPORT_TYPE="" Id_Sl_No="'+convert(varchar(20),@mech_count+@textcount)+'" LineType ="T" SPARE_DISCOUNT="0" />'
			set @iv_XMLDISDOC_str = @iv_XMLDISDOC_str + '<insert ID_DEBTOR ="'+@IV_ID_CUST_WO+'" ID_ITEM = "" ID_MAKE = "" ID_WAREHOUSE = "'+@id_wh+'" DBT_VAT_AMOUNT = "0" DBT_DIS_AMT="0" JOB_VAT_PER="0" JOB_VAT_SEQ="0" JOB_DIS_SEQ="0" JOB_DIS_PER="0" />'
			set @textcount = @textcount + 1
		END
	if(@app_textline5<>'')
		BEGIN
			set @iv_xmljobDoc_str = @iv_xmljobDoc_str + '<insert ID_ITEM_JOB ="" ID_MAKE_JOB = "" ID_WAREHOUSE = "'+@id_wh+'" ID_ITEM_CATG_JOB = "" JOBI_ORDER_QTY = "0" JOBI_DELIVER_QTY= "0" JOBI_BO_QTY ="0.00" JOBI_DIS_PER ="0" JOBI_VAT_PER ="0" ORDER_LINE_TEXT =""  JOBI_SELL_PRICE ="0" JOBI_COST_PRICE = "0.0" ID_CUST_WO = "'+@IV_ID_CUST_WO+'" TEXT ="'+@app_textline5+'" TD_CALC ="True " ITEM_DESC="" PICKINGLIST_PREV_PRINTED ="False" DELIVERYNOTE_PREV_PRINTED ="False" PREV_PICKED ="0" SPARE_TYPE="ORD" FLG_FORCE_VAT ="False "  FLG_EDIT_SP="False" EXPORT_TYPE="" Id_Sl_No="'+convert(varchar(20),@mech_count+@textcount)+'" LineType ="T" SPARE_DISCOUNT="0" />'
			set @iv_XMLDISDOC_str = @iv_XMLDISDOC_str + '<insert ID_DEBTOR ="'+@IV_ID_CUST_WO+'" ID_ITEM = "" ID_MAKE = "" ID_WAREHOUSE = "'+@id_wh+'" DBT_VAT_AMOUNT = "0" DBT_DIS_AMT="0" JOB_VAT_PER="0" JOB_VAT_SEQ="0" JOB_DIS_SEQ="0" JOB_DIS_PER="0" />'
			set @textcount = @textcount + 1
		END
	-------------------END - NEW CHANGES FOR ADDING TEXT LINES-------------------------------

	--set @mech_count = @mech_count + 1
	set @mech_count = @mech_count + @textcount

	fetch next from appointment_details 
	into @appointment_det_id

	end
	close appointment_details
	deallocate appointment_details	

	set @iv_xmlwoDoc_str = N'<root><insert ID_DETAIL="'+@iv_ID_CUST_WO+'" 
		DEBITOR_TYPE="C" 
		DBT_AMT="'+convert(varchar(20),@final_job_total)+'" 
		DBT_PER="100.00"
		PWO_VAT_PERCENTAGE="1.00" 
		PWO_GM_PER="1.00" 
		PWO_GM_VATPER="1.00" 
		PWO_LBR_VATPER="1.00" 
		PWO_SPR_DISCPER="1.00"  
		PWO_FIXED_VATPER = "1.00" 
		ORG_PER="100.00" 
		JOB_VAT_AMOUNT="'+convert(varchar(20),@total_job_vat_amt)+'" 
		LABOUR_AMOUNT="'+convert(varchar(20),@hp_job_amount)+'" 
		LABOUR_DISCOUNT="'+convert(varchar(20),@hp_job_disc)+'" 
		GM_AMOUNT="'+convert(varchar(20),@gm_job_amount)+'" 
		GM_DISCOUNT="'+convert(varchar(20),@gm_job_disc)+'" 
		OWNRISK_AMOUNT="0.00" 
		SP_VAT="0.00" 
		SP_AMT_DEB="0.00" 
		LineType ="L" 
		CUST_TYPE="OHC" 
		WO_OWN_RISK_DESC = "" 
		REDUCTION_PER="0" 
		REDUCTION_BEFORE_OR="0" 
		REDUCTION_AFTER_OR="0" 
		REDUCTION_AMOUNT="0" 
		DBT_DIS_PER="'+convert(varchar(20),@wo_disc_per)+'" 
		DEB_STATUS=""  /></root>' 

	
	set @iv_XMLMECHDOC_str = N'<root>'+@iv_XMLMECHDOC_str+'</root>'
	set @iv_xmljobDoc_str = N'<root>'+@iv_xmljobDoc_str+'</root>'
	set @iv_XMLDISDOC_str = N'<root>'+@iv_XMLDISDOC_str+'</root>'


	exec USP_WO_INSERT 
		@iv_xmljobDoc=@iv_xmljobDoc_str,
		@iv_xmlwoDoc=@iv_xmlwoDoc_str,
		@iv_ID_WODET_SEQ=1,
		@iv_ID_WO_NO=@iv_wo_no,
		@iv_ID_WO_PREFIX=@iv_wo_prefix,
		@iv_ID_RPG_CATG_WO=NULL,
		@iv_ID_RPG_CODE_WO=NULL,
		@iv_ID_REP_CODE_WO=1,
		@iv_ID_WORK_CODE_WO=N'129',
		@iv_WO_FIXED_PRICE=0,
		@iv_ID_JOBPCD_WO=N'0',
		@iv_WO_PLANNED_TIME=N'0',
		@iv_WO_HOURLEY_PRICE=@ov_HP_PRICE,
		@iv_WO_CLK_TIME=@iv_job_hp_time,
		@iv_WO_CHRG_TIME=@iv_job_hp_time,
		@iv_FLG_CHRG_STD_TIME=0,
		@iv_WO_STD_TIME=N'0',
		@iv_FLG_STAT_REQ=0,
		@iv_WO_JOB_TXT=N'',
		@iv_WO_OWN_RISK_AMT=0,
		@iv_WO_TOT_LAB_AMT=@hp_job_amount,
		@iv_WO_TOT_SPARE_AMT=0,
		@iv_WO_TOT_GM_AMT=@gm_job_amount,
		@iv_WO_TOT_VAT_AMT=@total_job_vat_amt,
		@iv_WO_TOT_DISC_AMT=@tot_job_disc_final,
		@iv_JOB_STATUS=N'CSA',
		@iv_CREATED_BY=@iv_userid,
		@iv_DT_CREATED=@iv_created_date,
		@ib_WO_OWN_PAY_VAT=0,
		@id_WO_DT_PLANNED=NULL,
		@iv_XMLDISDOC=@iv_XMLDISDOC_str,
		@II_ID_DEF_SEQ=0,
		@iv_TOTALAMT=@final_job_total,
		@iv_XMLMECHDOC=@iv_XMLMECHDOC_str,
		@ii_ID_MECH_COMP=N'0',
		@iv_WO_OWN_RISK_CUST=@iv_ID_CUST_WO,
		@iv_WO_OWN_CR_CUST=N'',
		@ii_ID_SER_CALLNO=0,
		@II_WO_GM_PER=@gm_per,
		@II_WO_GM_VATPER=@gm_vat,
		@II_WO_LBR_VATPER=@hp_vat,
		@BUS_PEK_CONTROL_NUM=N'',
		@IV_PKKDATE=NULL,
		@WO_INCL_VAT=0,
		@WO_DISCOUNT=0,
		@ID_SUBREP_CODE_WO=0,
		@WO_OWNRISKVAT=0,
		@IV_FLG_SPRSTS=0,
		@SALESMAN=N'',
		@FLG_VAT_FREE=0,
		@COST_PRICE=0,
		@WO_FINAL_TOTAL=@final_job_total, --updated from @total_amt
		@WO_FINAL_VAT=@total_job_vat_amt,
		@WO_FINAL_DISCOUNT=@tot_job_disc_final,
		@ID_JOB=@job_id,
		@iv_WO_CHRG_TIME_FP=N'1',
		@iv_WO_TOT_LAB_AMT_FP=@hp_job_amount,
		@iv_WO_TOT_SPARE_AMT_FP=0,
		@iv_WO_TOT_GM_AMT_FP=@gm_job_amount,
		@iv_WO_TOT_VAT_AMT_FP=0,
		@iv_WO_TOT_DISC_AMT_FP=0,
		@iv_WO_INT_NOTE=N'',
		@iv_WO_ID_MECHANIC=N'',
		@iv_WO_OWN_RISK_DESC=N'',
		@iv_WO_OWN_RISK_SL_NO=0,
		@OV_RETVALUE='',
		@iv_ID_JOB=''

	--ENTER TEXT LINES
		exec USP_WO_INSERT 
		@iv_xmljobDoc=N'<root></root>',
		@iv_xmlwoDoc=@iv_xmlwoDoc_str,
		@iv_ID_WODET_SEQ=1,
		@iv_ID_WO_NO=@iv_wo_no,
		@iv_ID_WO_PREFIX=@iv_wo_prefix,
		@iv_ID_RPG_CATG_WO=NULL,
		@iv_ID_RPG_CODE_WO=NULL,
		@iv_ID_REP_CODE_WO=1,
		@iv_ID_WORK_CODE_WO=N'129',
		@iv_WO_FIXED_PRICE=0,
		@iv_ID_JOBPCD_WO=N'0',
		@iv_WO_PLANNED_TIME=N'0',
		@iv_WO_HOURLEY_PRICE=@ov_HP_PRICE,
		@iv_WO_CLK_TIME=@iv_job_hp_time,
		@iv_WO_CHRG_TIME=@iv_job_hp_time,
		@iv_FLG_CHRG_STD_TIME=0,
		@iv_WO_STD_TIME=N'0',
		@iv_FLG_STAT_REQ=0,
		@iv_WO_JOB_TXT=N'',
		@iv_WO_OWN_RISK_AMT=0,
		@iv_WO_TOT_LAB_AMT=@hp_job_amount,
		@iv_WO_TOT_SPARE_AMT=0,
		@iv_WO_TOT_GM_AMT=@gm_job_amount,
		@iv_WO_TOT_VAT_AMT=@total_job_vat_amt,
		@iv_WO_TOT_DISC_AMT=@tot_job_disc_final,
		@iv_JOB_STATUS=N'CSA',
		@iv_CREATED_BY=@iv_userid,
		@iv_DT_CREATED=@iv_created_date,
		@ib_WO_OWN_PAY_VAT=0,
		@id_WO_DT_PLANNED=NULL,
		@iv_XMLDISDOC=N'<root></root>',
		@II_ID_DEF_SEQ=0,
		@iv_TOTALAMT=@final_job_total,
		@iv_XMLMECHDOC=@iv_XMLMECHDOC_str,
		@ii_ID_MECH_COMP=N'0',
		@iv_WO_OWN_RISK_CUST=@iv_ID_CUST_WO,
		@iv_WO_OWN_CR_CUST=N'',
		@ii_ID_SER_CALLNO=0,
		@II_WO_GM_PER=@gm_per,
		@II_WO_GM_VATPER=@gm_vat,
		@II_WO_LBR_VATPER=@hp_vat,
		@BUS_PEK_CONTROL_NUM=N'',
		@IV_PKKDATE=NULL,
		@WO_INCL_VAT=0,
		@WO_DISCOUNT=0,
		@ID_SUBREP_CODE_WO=0,
		@WO_OWNRISKVAT=0,
		@IV_FLG_SPRSTS=0,
		@SALESMAN=N'',
		@FLG_VAT_FREE=0,
		@COST_PRICE=0,
		@WO_FINAL_TOTAL=@final_job_total, --updated from @total_amt
		@WO_FINAL_VAT=@total_job_vat_amt,
		@WO_FINAL_DISCOUNT=@tot_job_disc_final,
		@ID_JOB=@job_id,
		@iv_WO_CHRG_TIME_FP=N'1',
		@iv_WO_TOT_LAB_AMT_FP=@hp_job_amount,
		@iv_WO_TOT_SPARE_AMT_FP=0,
		@iv_WO_TOT_GM_AMT_FP=@gm_job_amount,
		@iv_WO_TOT_VAT_AMT_FP=0,
		@iv_WO_TOT_DISC_AMT_FP=0,
		@iv_WO_INT_NOTE=N'',
		@iv_WO_ID_MECHANIC=N'',
		@iv_WO_OWN_RISK_DESC=N'',
		@iv_WO_OWN_RISK_SL_NO=0,
		@OV_RETVALUE='',
		@iv_ID_JOB=''
	-------------------------------------------
	-------------------------------------------

	--SET @0V_RETVALUE = 'INSERTED'

	SET @IV_RETVALUE = 'INS' +';'+ @IV_WO_PREFIX +';'+@IV_WO_NO+';'+cast(@job_id as varchar)

	DECLARE @WO_ORDER_STATUS VARCHAR(30)
	SELECT @WO_ORDER_STATUS = WO_STATUS FROM TBL_WO_HEADER WHERE ID_WO_NO = @IV_WO_NO AND ID_WO_PREFIX = @IV_WO_PREFIX

	UPDATE TBL_APPOINTMENT_DETAILS
	SET ID_WO_NO = @IV_WO_NO,ID_WO_PREFIX = @IV_WO_PREFIX , JOB_ID = @job_id --,JOB_STATUS = @WO_ORDER_STATUS 
	WHERE APPOINTMENT_ID = @IV_APPOINTMENT_ID AND isnull(JOB_STATUS,'') NOT IN('DEL') and ID_JOB=@iv_id_job --,'ONHOLD'

	-- this is to update status for all appmnt lines except OnHold lines
	UPDATE TBL_APPOINTMENT_DETAILS
	SET JOB_STATUS = @WO_ORDER_STATUS 
	WHERE APPOINTMENT_ID = @IV_APPOINTMENT_ID AND isnull(JOB_STATUS,'') NOT IN('DEL','ONHOLD') and ID_JOB=@iv_id_job 

	PRINT @iv_xmlwoDoc_str
	PRINT @iv_XMLMECHDOC_str
	PRINT @IV_RETVALUE
END  
  

GO
