/****** Object:  StoredProcedure [dbo].[USP_SPR_PO_UPATETOBACKORDER]    Script Date: 08-04-2022 10:19:52 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_PO_UPATETOBACKORDER]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_PO_UPATETOBACKORDER]    Script Date: 08-04-2022 10:19:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Praveen
-- Create date: 24-03-2022
-- Description:	This procedure is used to update the workorder job qty with the updated qty when update to back order is clicked
-- =============================================
CREATE PROCEDURE [dbo].[USP_SPR_PO_UPATETOBACKORDER] 
	-- Add the parameters for the stored procedure here
	@WOSeqNo int = null, 
	@POQuantity int = null,
	@CreatedBy varchar(20),
	@ID_PO INT,
    @id_item varchar(30),
	@IV_Return int output,
	@UpdtWOSeqNo int output
AS
BEGIN
	SET NOCOUNT ON;


	declare @OV_RETVALUE varchar(200)
	declare @WOSeqNo_New int
	DECLARE @JOB_QTY DECIMAL
	DECLARE @BACK_QTY DECIMAL
		
	DECLARE @ID_WO_NO VARCHAR(10)
	DECLARE @WH_STATUS BIT
	DECLARE @ID_WO_PREFIX VARCHAR(3)
	DECLARE @ID_JOB	INT
	DECLARE @USERID VARCHAR(50)
	DECLARE @WOSEQEXIST INT
	DECLARE @WOSEQEXISTT INT
	DECLARE @WOSEQMAX INT
	DECLARE @USE_MANUAL_RWRK AS BIT
	DECLARE @BOJQTY AS INT 
	DECLARE @BOQTY AS INT
	DECLARE @STOCKITEM AS INT
    DECLARE @TOTALCNT AS INT 
    DECLARE @FLG_SPRSTS AS VARCHAR(3)
    DECLARE @ID_WO_NO_new VARCHAR(10)
	DECLARE @ID_WO_PREFIX_new VARCHAR(3)
	DECLARE @ID_JOB_new	INT
	DECLARE @WO_TYPE_WOH As VARCHAR(10)
    --Row 639
    
    Declare @Use_Approve varchar(10)
	declare @id_make varchar(20)
	declare @id_wh_item varchar(20)
	declare @Quantity decimal(13,2)
	declare @CostPrice decimal(13,2)

       SELECT @Use_Approve= [DESCRIPTION] FROM TBL_MAS_SETTINGS WHERE ID_CONFIG ='USEAPPROVE'
       --SELECT '@Use_Approve',@Use_Approve

	
		declare @AvailQty decimal(13,2)
		declare @AvgPrice decimal(13,2)	
		declare @AvgPrice_before decimal(13,2)
		declare @AvgPrice_after decimal(13,2)
		declare @TotalQty decimal(13,2)
			
	
		select @AvailQty=im.ITEM_AVAIL_QTY,@AvgPrice=AVG_PRICE ,@Quantity= po.DELIVERED_QTY
		,@CostPrice = po.COST_PRICE1--,@id_item=po.ID_ITEM
		,@id_wh_item=im.ID_WH_ITEM
		from tbl_mas_item_master im 
		inner join  TBL_SPR_PO_ITEM po
		on im.ID_ITEM=po.ID_ITEM
		--and im.ID_MAKE=ir.ID_MAKE
		--and im.ID_WH_ITEM=po.ID_WH_ITEM
		where  ID_PO = @ID_PO	
		AND im.ID_ITEM = @id_item
		AND PO.ID_ITEM = @id_item		
		AND PO.ID_WOITEM_SEQ= @WOSeqNo

		--select '@AvailQty',@AvailQty
		set @AvgPrice_before = (@AvailQty*isnull(@AvgPrice,0))
		set @AvgPrice_after = (@Quantity*isnull(@CostPrice,0))
		set @TotalQty = @AvailQty + @Quantity	
					
		if @TotalQty=0 
		set @AvgPrice=0
		else
		set @AvgPrice=(@AvgPrice_before + @AvgPrice_after)/@TotalQty
	
		
	
		DECLARE @ID_WODET_SEQ AS INT,@SUBID AS INT ,@DEPTID AS INT,@FixedPrice as decimal(20,2)
		
		SELECT @ID_WODET_SEQ = ID_WODET_SEQ_JOB ,@ID_WO_PREFIX = ID_WO_PREFIX,@ID_WO_NO = ID_WO_NO FROM TBL_WO_JOB_DETAIL WHERE  ID_WOITEM_SEQ = @WOSeqNo
        SELECT @SUBID = ID_Subsidery,@DeptID = ID_Dept ,@WO_TYPE_WOH = WO_TYPE_WOH FROM TBL_WO_HEADER WHERE  ID_WO_PREFIX = @ID_WO_PREFIX and ID_WO_NO = @ID_WO_NO 
		
		
		SELECT @FLG_SPRSTS = FLG_SPRSTATUS ,@FixedPrice=isnull(WO_FIXED_PRICE,0) FROM TBL_WO_DETAIL 
		WHERE ID_WO_NO = @ID_WO_NO AND ID_WO_PREFIX=@ID_WO_PREFIX 
		AND ID_WODET_SEQ =@ID_WODET_SEQ

		SELECT @WH_STATUS = ISNULL(FLG_DPT_WareHouse,0) FROM TBL_MAS_DEPT WHERE ID_Dept=@DEPTID
		set @OV_RETVALUE = -1
		set @WOSeqNo_New = -1
	
	if (Exists (SELECT ID_WOITEM_SEQ FROM TBL_INV_DETAIL_LINES INVLINES INNER JOIN TBL_INV_HEADER IHEADER
		ON  INVLINES.ID_INV_NO = IHEADER.ID_INV_NO  AND ID_CN_NO IS NULL WHERE ID_WOITEM_SEQ = @WOSeqNo ))
	begin
		
		DECLARE @ID_WORDER VARCHAR(10)
		DECLARE @ID_WPREFIX VARCHAR(3)
		DECLARE @ID_WOJOB	INT 
		DECLARE @WOSeqNo_First INT
		--DECLARE @WO_TYPE_WOH As VARCHAR(10)

		Select @ID_WORDER = Wod.ID_WO_No, @ID_WPREFIX= wod.ID_WO_Prefix , @ID_WOJOB = wod.id_job  
		From TBL_WO_DETAIL wod
		inner join TBL_WO_JOB_DETAIL woj on  wod.ID_WO_NO = woj.ID_WO_NO and wod.ID_WO_PREFIX = woj.ID_WO_PREFIX
		Where woj.ID_WOITEM_SEQ = @WOSeqNo	
		   
    
		
		Select TOP 1 @WOSeqNo_First = woj.ID_WOITEM_SEQ 
		from tbl_wo_detail wod
			inner join TBL_WO_JOB_DETAIL woj on  wod.ID_WO_NO = woj.ID_WO_NO and wod.ID_WO_PREFIX = woj.ID_WO_PREFIX
		Where woj.ID_WO_NO = @ID_WORDER
			AND woj.ID_WO_PREFIX = @ID_WPREFIX 
			AND wod.id_job = @ID_WOJOB 
		ORDER BY woj.DT_CREATED ASC
      
		If Exists(
			SELECT WOJ.ID_WODET_SEQ_JOB FROM TBL_WO_JOB_DETAIL WOJ 
			--pk
			--INNER JOIN TBL_SPR_PURCHASEORDER PO	ON WOJ.ID_WOITEM_SEQ = PO.ID_WOITEM_SEQ 
			INNER JOIN TBL_SPR_PO_ITEM PO	ON WOJ.ID_WOITEM_SEQ = PO.ID_WOITEM_SEQ 
			INNER JOIN TBL_WO_DETAIL WOD ON WOD.ID_WO_NO = WOJ.ID_WO_NO AND WOD.ID_WO_PREFIX = WOJ.ID_WO_PREFIX
			WHERE WOJ.ID_WO_NO = @ID_WORDER  AND WOJ.ID_WO_PREFIX = @ID_WPREFIX  AND WOD.ID_JOB = @ID_WOJOB
			AND PO.ID_ITEM = @id_item
			AND PO.ID_PO=@ID_PO
			AND PO.ID_WOITEM_SEQ= @WOSeqNo
		)		
		
		BEGIN

			If Not Exists(
				SELECT PO.ID_WOITEM_SEQ FROM TBL_WO_JOB_DETAIL WOJ 
				--pk
				--INNER JOIN TBL_SPR_PURCHASEORDER PO	ON WOJ.ID_WOITEM_SEQ = PO.ID_WOITEM_SEQ 
				INNER JOIN TBL_SPR_PO_ITEM PO	ON WOJ.ID_WOITEM_SEQ = PO.ID_WOITEM_SEQ 
				INNER JOIN TBL_WO_DETAIL WOD ON WOD.ID_WO_NO = WOJ.ID_WO_NO AND WOD.ID_WO_PREFIX = WOJ.ID_WO_PREFIX
				WHERE WOJ.ID_WO_NO = @ID_WORDER  AND WOJ.ID_WO_PREFIX = @ID_WPREFIX  AND WOD.ID_JOB = @ID_WOJOB 
		 		AND  PO.ID_WOITEM_SEQ > @WOSEQNO AND WOJ.JOBI_BO_QTY > 0.00
		 		AND PO.ID_ITEM = @id_item
				AND PO.ID_PO=@ID_PO
				AND PO.ID_WOITEM_SEQ= @WOSeqNo
			)
			BEGIN
			
				DECLARE @ID_WODET_INV INT
				SELECT @ID_WODET_INV	=	WOJD.ID_WODET_SEQ_JOB FROM TBL_WO_DETAIL WOD
					INNER JOIN TBL_WO_JOB_DETAIL WOJD ON WOD.ID_WODET_SEQ=WOJD.ID_WODET_SEQ_JOB
					WHERE WOJD.ID_WOITEM_SEQ = @WOSeqNo   

       
				--pk is this needed???
				exec USP_SPR_IR_WO_Insert @ID_WODET_INV, @POQuantity, @CreatedBy,@WOSeqNo,@OV_RETVALUE output,@WOSeqNo_New output
				select @WOSeqNo_New as SeqNumber, @OV_RETVALUE as ReturnVal
				
				Declare @ID_WOITEM_SEQ As Int
				Select @ID_WOITEM_SEQ =ID_WOITEM_SEQ From TBL_WO_JOB_DETAIL where ID_WODET_SEQ_JOB = @WOSeqNo_New
				
				--pk @WOSeqNo_New is this needed???
				
				IF @OV_RETVALUE = '0'
				begin
				
						--update tbl_spr_purchaseorder set ID_WOITEM_SEQ = @WOSeqNo_New where ID_WOITEM_SEQ= (select ID_WOITEM_SEQ from tbl_Spr_purchaseorder where  id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir))
					declare @WOSeqNo_OLD int
					set @WOSeqNo_OLD= (select ID_WOITEM_SEQ from tbl_wo_job_detail where ID_WOITEM_SEQ=
					(select ID_WOITEM_SEQ from TBL_SPR_PO_ITEM where  id_po=@ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo AND ID_WOITEM_SEQ= @WOSeqNo))
				   
					update TBL_SPR_PO_ITEM 
					set ID_WOITEM_SEQ = @ID_WOITEM_SEQ 
					--,ID_WOITEM_SEQ_NEW=@WOSeqNo_OLD
					where 
					ID_WOITEM_SEQ = (@WOSeqNo_OLD)
					AND ID_PO=@ID_PO
					AND ID_ITEM = @id_item

					set @iv_return = 1
					set @UpdtWOSeqNo=@WOSeqNo_New
						
		
					SELECT @JOB_QTY = jobi_bo_qty FROM tbl_wo_job_detail WHERE ID_WOITEM_SEQ= @WOSeqNo	
					--pk 
					--SELECT @BACK_QTY = BACKORDERQTY FROM TBL_SPR_PURCHASEORDER WHERE ID_PO =(SELECT ID_PO FROM TBL_SPR_INWARDREGISTER WHERE ID_IR= @ID_IR)
					SELECT @BACK_QTY = REMAINING_QTY FROM TBL_SPR_PO_ITEM WHERE ID_PO = @ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo

					IF @JOB_QTY <> @BACK_QTY
					BEGIN	
						DECLARE @DELQTY1 DECIMAL
						--pk how to get delivered qty???
						select @DELQTY1 = DELIVERED_QTY from TBL_SPR_PO_ITEM where ID_PO= @ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo

						IF @DELQTY1 > @JOB_QTY 
						BEGIN

							update tbl_wo_job_detail 
							set							
							JOBI_DELIVER_QTY = JOBI_DELIVER_QTY + @JOB_QTY 
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ	
							
							update tbl_wo_job_detail 
							set jobi_bo_qty = JOBI_ORDER_QTY - JOBI_DELIVER_QTY
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ
										
							set @iv_return = 1
							set @UpdtWOSeqNo=@WOSeqNo_New
							
							if @FixedPrice=0.0 
							begin
					          exec USP_WO_RECALCULATEJOBTOT_NEWOREDER @ID_WOITEM_SEQ	
							end
						
					--ADDED FOR -ROW- 236
					SELECT @USE_MANUAL_RWRK = USE_MANUAL_RWRK FROM 
					TBL_MAS_WO_CONFIGURATION
					WHERE	
					ID_SUBSIDERY_WO = @SUBID	AND 
					ID_DEPT_WO		= @DEPTID  AND
					DT_EFF_TO > getdate()
					
				IF @USE_MANUAL_RWRK = 0
					BEGIN		
							
							SELECT @BOJQTY= SUM(JOBI_BO_QTY)     
							FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
							AND ID_WO_PREFIX = @ID_WO_PREFIX 
											AND ID_WODET_SEQ_JOB = @ID_WODET_SEQ   
							GROUP BY ID_WODET_SEQ_JOB
				              
							 
							SELECT @BOQTY= SUM(JOBI_BO_QTY)     
							FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
							AND ID_WO_PREFIX = @ID_WO_PREFIX 
                					GROUP BY ID_WO_NO,ID_WO_PREFIX

											
							SET @BOJQTY =ISNULL(@BOJQTY,0)
							SET @BOQTY =ISNULL(@BOQTY,0)

					IF @FLG_SPRSTS = '1'
					   BEGIN
								UPDATE TBL_WO_DETAIL
								SET JOB_STATUS = 'CSA'
								WHERE ID_WODET_SEQ = @ID_WODET_SEQ
					   END
					ELSE
						BEGIN
		

							 SELECT @TOTALCNT = COUNT(WOJ.ID_WODET_SEQ_JOB) FROM TBL_MAS_ITEM_MASTER MSTR
							 INNER JOIN TBL_WO_JOB_DETAIL WOJ 
							 ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
							 AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
							 AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
							 WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ
			 
			 
							SELECT @STOCKITEM =COUNT(FLG_STOCKITEM) FROM TBL_MAS_ITEM_MASTER MSTR
							INNER JOIN TBL_WO_JOB_DETAIL WOJ 
							ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
							AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
							AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
							WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ AND MSTR.FLG_STOCKITEM = 1
					
				  								
							SET @BOJQTY =ISNULL(@BOJQTY,0)
						
							
							
						   IF @TOTALCNT = @STOCKITEM 
						       BEGIN	
					

										IF @BOJQTY  = 0 
										BEGIN                 
										UPDATE TBL_WO_DETAIL
														SET JOB_STATUS = 'RWRK'
										WHERE ID_WODET_SEQ = @ID_WODET_SEQ and @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
										
										/*Change to update status for TBL_PLAN_JOB_DETAIL*/
											IF EXISTS(SELECT * FROM TBL_PLAN_JOB_DETAIL WHERE ID_WO_NO_JOB = @ID_WO_NO AND ID_WO_PREFIX  = @ID_WO_PREFIX AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ))  
												BEGIN
															UPDATE  TBL_PLAN_JOB_DETAIL 
															  SET STATUS = 'RWRK'
															WHERE    
															ID_WO_NO_JOB      = @ID_WO_NO  
															AND ID_WO_PREFIX  = @ID_WO_PREFIX  
															AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ)  and @WO_TYPE_WOH <>'CRSL'              
															AND @WH_STATUS = 0

												END
									   /****Change End****/		

								END

									IF @BOQTY  = 0 
										BEGIN                 
											UPDATE TBL_WO_HEADER
															SET WO_STATUS = 'RWRK'
											WHERE ID_WO_NO = @ID_WO_NO AND ID_WO_PREFIX =@ID_WO_PREFIX AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
										END
										
							END	
			           END
				END

							UPDATE 
							ITEM 
							SET
							ITEM.ITEM_AVAIL_QTY=ITEM.ITEM_AVAIL_QTY - @JOB_QTY
							FROM 
							TBL_SPR_PO_ITEM PO 
							INNER JOIN  
							TBL_MAS_ITEM_MASTER ITEM
							ON 
							ITEM.ID_ITEM=PO.ID_ITEM AND
							ITEM.SUPP_CURRENTNO=PO.SUPP_CURRENTNO	AND
							ID_PO=@ID_PO
							AND PO.ID_ITEM = @id_item AND PO.ID_WOITEM_SEQ= @WOSeqNo
						END
						ELSE
						BEGIN
							update tbl_wo_job_detail 
							set 
							jobi_bo_qty = (select REMAINING_QTY from TBL_SPR_PO_ITEM where id_po=@ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo),
							--JOBI_DELIVER_QTY=JOBI_DELIVER_QTY + (select DELIVEREDQTY from tbl_spr_inwardregister where id_ir= @id_ir)
							JOBI_DELIVER_QTY=JOBI_DELIVER_QTY + (select DELIVERED_QTY from TBL_SPR_PO_ITEM where id_po=@ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo)
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ
							
							update tbl_wo_job_detail 
							set jobi_bo_qty = JOBI_ORDER_QTY - JOBI_DELIVER_QTY
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ
							
							
							
							set @iv_return = 1
							set @UpdtWOSeqNo=@WOSeqNo_New
							
						if @FixedPrice=0.0 
							begin
					          exec USP_WO_RECALCULATEJOBTOT_NEWOREDER @ID_WOITEM_SEQ	
							end
						
							
							
					--ADDED FOR -ROW- 236
						
								
					SELECT @USE_MANUAL_RWRK = USE_MANUAL_RWRK FROM 
					TBL_MAS_WO_CONFIGURATION
					WHERE	
					ID_SUBSIDERY_WO = @SUBID	AND 
					ID_DEPT_WO		= @DEPTID  AND
					DT_EFF_TO > getdate()
					
			 IF @USE_MANUAL_RWRK = 0
				BEGIN
				
	  
					  SELECT @BOJQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
										AND ID_WODET_SEQ_JOB = @ID_WODET_SEQ   
						GROUP BY ID_WODET_SEQ_JOB
		               
					 
					  SELECT @BOQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
                				GROUP BY ID_WO_NO,ID_WO_PREFIX

									
					  SET @BOJQTY =ISNULL(@BOJQTY,0)
					  SET @BOQTY =ISNULL(@BOQTY,0)
				     IF @FLG_SPRSTS = '1'
							 BEGIN
									UPDATE TBL_WO_DETAIL
									SET JOB_STATUS = 'CSA'
									WHERE ID_WODET_SEQ = @ID_WODET_SEQ
							END
				      ELSE
							BEGIN
						
								
					
								 SELECT @TOTALCNT = COUNT(WOJ.ID_WODET_SEQ_JOB) FROM TBL_MAS_ITEM_MASTER MSTR
								 INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								 ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								 AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								 AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								 WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ
				 
				 
								SELECT @STOCKITEM =COUNT(FLG_STOCKITEM) FROM TBL_MAS_ITEM_MASTER MSTR
								INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ AND MSTR.FLG_STOCKITEM = 1
								IF @TOTALCNT = @STOCKITEM 
						   BEGIN
						  
					         
									IF @BOJQTY  = 0 
									BEGIN                 
										UPDATE TBL_WO_DETAIL
														SET JOB_STATUS = 'RWRK'
										WHERE ID_WODET_SEQ = @ID_WODET_SEQ AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
										
										/*Change to update status for TBL_PLAN_JOB_DETAIL*/
											IF EXISTS(SELECT * FROM TBL_PLAN_JOB_DETAIL WHERE ID_WO_NO_JOB = @ID_WO_NO AND ID_WO_PREFIX  = @ID_WO_PREFIX AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ))  
												BEGIN
															UPDATE  TBL_PLAN_JOB_DETAIL 
															  SET STATUS = 'RWRK'
															WHERE    
															ID_WO_NO_JOB      = @ID_WO_NO  
															AND ID_WO_PREFIX  = @ID_WO_PREFIX  
															AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ)  AND  @WO_TYPE_WOH <>'CRSL'              
															AND @WH_STATUS = 0

												END
									   /****Change End****/		
									END

									IF @BOQTY  = 0 
									BEGIN                 
										UPDATE TBL_WO_HEADER
														SET WO_STATUS = 'RWRK'
										WHERE ID_WO_NO = @ID_WO_NO AND ID_WO_PREFIX =@ID_WO_PREFIX AND @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
									END
									END
							END
				END

							UPDATE 
							ITEM 
							SET
							ITEM.ITEM_AVAIL_QTY=ITEM.ITEM_AVAIL_QTY - @JOB_QTY
							FROM 
							TBL_SPR_PO_ITEM PO 
							INNER JOIN  
							TBL_MAS_ITEM_MASTER ITEM
							ON 
							ITEM.ID_ITEM=PO.ID_ITEM AND
							ITEM.SUPP_CURRENTNO=PO.SUPP_CURRENTNO	AND
							ID_PO=@ID_PO						
							AND PO.ID_ITEM = @id_item
							AND PO.ID_WOITEM_SEQ= @WOSeqNo
						
					END

						SELECT @ID_WO_NO=ID_WO_NO,@ID_WO_PREFIX=ID_WO_PREFIX,@ID_JOB=ID_JOB,@USERID=CREATED_BY
						FROM TBL_WO_DETAIL
						WHERE ID_WODET_SEQ = (SELECT ID_WODET_SEQ_JOB	FROM TBL_WO_JOB_DETAIL WHERE ID_WOITEM_SEQ=@WOSeqNo_New)

						EXEC USP_WO_RECALCULATEJOBTOT @ID_WO_NO,@ID_WO_PREFIX,@ID_JOB,@USERID
						
						
						SELECT @ID_WO_NO_new=ID_WO_NO,@ID_WO_PREFIX_new=ID_WO_PREFIX,@ID_JOB_new=isnull(ID_JOB,0),@USERID=CREATED_BY
						FROM TBL_WO_DETAIL
						WHERE ID_WODET_SEQ =@WOSeqNo_New
						
		
						--EXEC USP_UPDATE_IR_WODETAIL @ID_WO_PREFIX_new,@ID_WO_NO_new,@ID_JOB_new,@USERID
						
						--DECLARE @IRNUMBER AS VARCHAR(30)	
						--SELECT @IRNUMBER = IRNUMBER FROM TBL_SPR_INWARDREGISTER WHERE ID_IR = @ID_IR
						/*IF EXISTS(SELECT * FROM TBL_SPR_INWARDREGISTER WHERE IRNUMBER = @IRNUMBER)
						BEGIN
							UPDATE TBL_SPR_INWARDREGISTER SET FLG_UPDATE_BO = 1 WHERE IRNUMBER = @IRNUMBER
							if ISNULL(@Use_Approve,'False')='True' 
							begin
							UPDATE TBL_SPR_INWARDREGISTER SET FLG_APPROVE = 1 WHERE IRNUMBER = @IRNUMBER
				            update tbl_mas_item_master
							set AVG_PRICE =case when  @AvgPrice= 0 then AVG_PRICE else @AvgPrice end
							where id_item =@id_item and id_make=@id_make and id_wh_item = @id_wh_item

							end
						END*/
					END
				end
				else
				begin
					set @iv_return = 0
					raiserror('Unable to create a duplicate work order',16,1)
				end
			
			END	
			ELSE
			BEGIN
			    
			    SET @OV_RETVALUE = '0'
			    Select TOP 1 @WOSeqNo_New = ID_WODET_SEQ from TBL_WO_DETAIL order by ID_WODET_SEQ desc
			   	select @WOSeqNo_New as SeqNumber, @OV_RETVALUE as ReturnVal	
			  	Select  TOP 1 @ID_WOITEM_SEQ =woj.ID_WOITEM_SEQ From TBL_WO_JOB_DETAIL  woj
				inner join TBL_MAS_ITEM_MASTER mas
				on mas.ID_ITEM = woj.ID_ITEM_JOB
				inner join TBL_SPR_PO_ITEM PO 
				on mas.ID_ITEM=PO.ID_ITEM AND
				ID_PO=@ID_PO
				where woj.ID_WODET_SEQ_JOB = @WOSeqNo_New
			  	AND PO.ID_ITEM = @id_item
				 AND PO.ID_WOITEM_SEQ= @WOSeqNo
				set @iv_return = 1
				set @UpdtWOSeqNo=@WOSeqNo_New	
				
				
				IF @OV_RETVALUE = '0'
				begin
				
						--update tbl_spr_purchaseorder set ID_WOITEM_SEQ = @WOSeqNo_New where ID_WOITEM_SEQ= (select ID_WOITEM_SEQ from tbl_Spr_purchaseorder where  id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir))
					--declare @WOSeqNo_OLD int
					set @WOSeqNo_OLD= (select ID_WOITEM_SEQ from tbl_wo_job_detail where ID_WOITEM_SEQ=
					(select ID_WOITEM_SEQ from TBL_SPR_PO_ITEM where  id_po=@ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo))
					
					/*	
					update tbl_spr_purchaseorder set ID_WOITEM_SEQ = @ID_WOITEM_SEQ where 
					ID_WOITEM_SEQ_NEW= (@WOSeqNo_OLD)
					*/
					
				    print @WOSeqNo_OLD
				    print @ID_WOITEM_SEQ
					set @iv_return = 1
					set @UpdtWOSeqNo=@WOSeqNo_New
							
				-- Modified Date : 17th March 2010
				-- Bug ID : Even after invoice, qty should update for newer job				
					SELECT @JOB_QTY = jobi_bo_qty FROM tbl_wo_job_detail WHERE ID_WOITEM_SEQ= @WOSeqNo			
					--select @BACK_QTY = BackOrderQty from TBL_SPR_PURCHASEORDER_OLD where id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir)			
					select @BACK_QTY =  REMAINING_QTY from TBL_SPR_PO_ITEM where id_po = ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo		
					IF @JOB_QTY <> @BACK_QTY
					BEGIN				
						--DECLARE @DELQTY1 DECIMAL
						select @DELQTY1 = DELIVERED_QTY from TBL_SPR_PO_ITEM where id_po=@ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo
						IF @DELQTY1 > @JOB_QTY 
						BEGIN

							update tbl_wo_job_detail 
							set 
							--jobi_bo_qty = (select BackOrderQty from tbl_spr_purchaseorder where id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir)),
								JOBI_DELIVER_QTY=JOBI_DELIVER_QTY + @JOB_QTY --(select DELIVEREDQTY from tbl_spr_inwardregister where id_ir= @id_ir)
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ	
							
							update tbl_wo_job_detail 
							set jobi_bo_qty = JOBI_ORDER_QTY - JOBI_DELIVER_QTY
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ
										
							set @iv_return = 1
							set @UpdtWOSeqNo=@WOSeqNo_New
							
				        if @FixedPrice=0.0 
							begin
					          exec USP_WO_RECALCULATEJOBTOT_NEWOREDER @ID_WOITEM_SEQ	
							end
						
							
					--ADDED FOR -ROW- 236
								
					
					SELECT @USE_MANUAL_RWRK = USE_MANUAL_RWRK FROM 
					TBL_MAS_WO_CONFIGURATION
					WHERE	
					ID_SUBSIDERY_WO = @SUBID	AND 
					ID_DEPT_WO		= @DEPTID  AND
					DT_EFF_TO > getdate()
					
				IF @USE_MANUAL_RWRK = 0
					BEGIN


					 
					  SELECT @BOJQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
										AND ID_WODET_SEQ_JOB = @ID_WODET_SEQ   
						GROUP BY ID_WODET_SEQ_JOB
		              
					  
					  SELECT @BOQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
                				GROUP BY ID_WO_NO,ID_WO_PREFIX

									
							SET @BOJQTY =ISNULL(@BOJQTY,0)
							SET @BOQTY =ISNULL(@BOQTY,0)
						IF @FLG_SPRSTS = '1'
							BEGIN
								UPDATE TBL_WO_DETAIL
								SET JOB_STATUS = 'CSA'
								WHERE ID_WODET_SEQ = @ID_WODET_SEQ
							END
					   ELSE
							BEGIN	
							
					           SELECT @TOTALCNT = COUNT(WOJ.ID_WODET_SEQ_JOB) FROM TBL_MAS_ITEM_MASTER MSTR
								 INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								 ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								 AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								 AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								 WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ
				 
				 
								SELECT @STOCKITEM =COUNT(FLG_STOCKITEM) FROM TBL_MAS_ITEM_MASTER MSTR
								INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ AND MSTR.FLG_STOCKITEM = 1
								IF @TOTALCNT = @STOCKITEM 
							     BEGIN
						        	
														
										IF @BOJQTY  = 0 
										BEGIN                 
											UPDATE TBL_WO_DETAIL
															SET JOB_STATUS = 'RWRK'
											WHERE ID_WODET_SEQ = @ID_WODET_SEQ AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
											
											/*Change to update status for TBL_PLAN_JOB_DETAIL*/
												IF EXISTS(SELECT * FROM TBL_PLAN_JOB_DETAIL WHERE ID_WO_NO_JOB = @ID_WO_NO AND ID_WO_PREFIX  = @ID_WO_PREFIX AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ))  
													BEGIN
																UPDATE  TBL_PLAN_JOB_DETAIL 
																  SET STATUS = 'RWRK'
																WHERE    
																ID_WO_NO_JOB      = @ID_WO_NO  
																AND ID_WO_PREFIX  = @ID_WO_PREFIX  
																AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ)  AND  @WO_TYPE_WOH <>'CRSL'
																AND @WH_STATUS = 0              

													END
										   /****Change End****/		
										END

										IF @BOQTY  = 0 
										BEGIN                 
											UPDATE TBL_WO_HEADER
															SET WO_STATUS = 'RWRK'
											WHERE ID_WO_NO = @ID_WO_NO AND ID_WO_PREFIX =@ID_WO_PREFIX AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
										END
									END	
							END
					END

							UPDATE 
							ITEM 
							SET
							ITEM.ITEM_AVAIL_QTY=ITEM.ITEM_AVAIL_QTY - @JOB_QTY
							FROM 
							TBL_SPR_PO_ITEM PO 
							INNER JOIN  
							TBL_MAS_ITEM_MASTER ITEM
							ON 
							ITEM.ID_ITEM=PO.ID_ITEM AND
							ITEM.SUPP_CURRENTNO=PO.SUPP_CURRENTNO	AND
							ID_PO=@ID_PO
							AND PO.ID_WOITEM_SEQ= @WOSeqNo
							
						END
						ELSE
						BEGIN
							update tbl_wo_job_detail 
							set 
							--jobi_bo_qty = (select BackOrderQty from tbl_spr_purchaseorder where id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir)),
							JOBI_DELIVER_QTY=JOBI_DELIVER_QTY + (select DELIVERED_QTY from TBL_SPR_PO_ITEM where id_po=@ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo)
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ
							
							update tbl_wo_job_detail 
							set jobi_bo_qty = JOBI_ORDER_QTY - JOBI_DELIVER_QTY
							where  ID_WOITEM_SEQ = @ID_WOITEM_SEQ
						
							set @iv_return = 1
							set @UpdtWOSeqNo=@WOSeqNo_New

			        if @FixedPrice=0.0 
							begin
					          exec USP_WO_RECALCULATEJOBTOT_NEWOREDER @ID_WOITEM_SEQ	
							end
						
					--ADDED FOR -ROW- 236
					
					SELECT @USE_MANUAL_RWRK = USE_MANUAL_RWRK FROM 
					TBL_MAS_WO_CONFIGURATION
					WHERE	
					ID_SUBSIDERY_WO = @SUBID	AND 
					ID_DEPT_WO		= @DEPTID  AND
					DT_EFF_TO > getdate()
					
				IF @USE_MANUAL_RWRK = 0
				  BEGIN


					  
					  SELECT @BOJQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
										AND ID_WODET_SEQ_JOB = @ID_WODET_SEQ   
						GROUP BY ID_WODET_SEQ_JOB
		              
					 
					  SELECT @BOQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
                				GROUP BY ID_WO_NO,ID_WO_PREFIX

									
							SET @BOJQTY =ISNULL(@BOJQTY,0)
							SET @BOQTY =ISNULL(@BOQTY,0)
						IF @FLG_SPRSTS = '1'
							 BEGIN
									UPDATE TBL_WO_DETAIL
									SET JOB_STATUS = 'CSA'
									WHERE ID_WODET_SEQ = @ID_WODET_SEQ
							END
						 ELSE
							BEGIN
						         SELECT @TOTALCNT = COUNT(WOJ.ID_WODET_SEQ_JOB) FROM TBL_MAS_ITEM_MASTER MSTR
								 INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								 ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								 AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								 AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								 WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ
				 
				 
								SELECT @STOCKITEM =COUNT(FLG_STOCKITEM) FROM TBL_MAS_ITEM_MASTER MSTR
								INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ AND MSTR.FLG_STOCKITEM = 1
									IF @TOTALCNT = @STOCKITEM 
							        BEGIN	

										IF @BOJQTY  = 0 
										BEGIN                 
															UPDATE TBL_WO_DETAIL
															SET JOB_STATUS = 'RWRK'
															WHERE ID_WODET_SEQ = @ID_WODET_SEQ AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
											
											/*Change to update status for TBL_PLAN_JOB_DETAIL*/
												IF EXISTS(SELECT * FROM TBL_PLAN_JOB_DETAIL WHERE ID_WO_NO_JOB = @ID_WO_NO AND ID_WO_PREFIX  = @ID_WO_PREFIX AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ))  
													BEGIN
																UPDATE  TBL_PLAN_JOB_DETAIL 
																  SET STATUS = 'RWRK'
																WHERE    
																ID_WO_NO_JOB      = @ID_WO_NO  
																AND ID_WO_PREFIX  = @ID_WO_PREFIX  
																AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ) AND  @WO_TYPE_WOH <>'CRSL'               
																AND @WH_STATUS = 0

													END
										   /****Change End****/		
											END

										IF @BOQTY  = 0 
										BEGIN                 
										UPDATE TBL_WO_HEADER
														SET WO_STATUS = 'RWRK'
										WHERE ID_WO_NO = @ID_WO_NO AND ID_WO_PREFIX =@ID_WO_PREFIX AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
										END
								  END	
							END
						END

							UPDATE 
							ITEM 
							SET
							ITEM.ITEM_AVAIL_QTY=ITEM.ITEM_AVAIL_QTY - @JOB_QTY
							FROM 
							TBL_SPR_PO_ITEM PO 
							INNER JOIN  
							TBL_MAS_ITEM_MASTER ITEM
							ON 
							ITEM.ID_ITEM=PO.ID_ITEM AND
							ITEM.SUPP_CURRENTNO=PO.SUPP_CURRENTNO	AND
							ID_PO=@ID_PO
							AND PO.ID_ITEM = @id_item
							AND PO.ID_WOITEM_SEQ= @WOSeqNo
							--UPDATE 
							--TBL_MAS_ITEM_MASTER
							--SET
							--ITEM_AVAIL_QTY=ITEM_AVAIL_QTY - DELIVEREDQTY
							--FROM 
							--TBL_SPR_INWARDREGISTER REG 
							--INNER JOIN  
							--TBL_MAS_ITEM_MASTER ITEM
							--ON 
							--ITEM.ID_ITEM=REG.ID_ITEM AND
							--ITEM.ID_MAKE=REG.ID_MAKE	AND
							--ITEM.ID_WH_ITEM=REG.ID_WH_ITEM AND
							--ID_IR=@id_ir
						END

						SELECT @ID_WO_NO=ID_WO_NO,@ID_WO_PREFIX=ID_WO_PREFIX,@ID_JOB=ID_JOB,@USERID=CREATED_BY
						FROM TBL_WO_DETAIL
						WHERE ID_WODET_SEQ = (SELECT	ID_WODET_SEQ_JOB	FROM TBL_WO_JOB_DETAIL WHERE ID_WOITEM_SEQ=@WOSeqNo_New)

 						EXEC USP_WO_RECALCULATEJOBTOT @ID_WO_NO,@ID_WO_PREFIX,@ID_JOB,@USERID
 						
 						
                        SELECT @ID_WO_NO_new=ID_WO_NO,@ID_WO_PREFIX_new=ID_WO_PREFIX,@ID_JOB_new=isnull(ID_JOB,0),@USERID=CREATED_BY
						FROM TBL_WO_DETAIL
						WHERE ID_WODET_SEQ =@WOSeqNo_New
						
		
						/*EXEC USP_UPDATE_IR_WODETAIL @ID_WO_PREFIX_new,@ID_WO_NO_new,@ID_JOB_new,@USERID
						--DECLARE @IRNUMBER AS VARCHAR(30)	
						SELECT @IRNUMBER = IRNUMBER FROM TBL_SPR_INWARDREGISTER WHERE ID_IR = @ID_IR
						IF EXISTS(SELECT * FROM TBL_SPR_INWARDREGISTER WHERE IRNUMBER = @IRNUMBER)
						BEGIN
							UPDATE TBL_SPR_INWARDREGISTER SET FLG_UPDATE_BO = 1 WHERE IRNUMBER = @IRNUMBER
								if ISNULL(@Use_Approve,'False')='True' 
							begin
							UPDATE TBL_SPR_INWARDREGISTER SET FLG_APPROVE = 1 WHERE IRNUMBER = @IRNUMBER
                            update tbl_mas_item_master
							set AVG_PRICE =case when  @AvgPrice= 0 then AVG_PRICE else @AvgPrice end
							where id_item =@id_item and id_make=@id_make and id_wh_item = @id_wh_item
							end
						END*/
					END
				end
				else
				begin
					set @iv_return = 0
					raiserror('Unable to create a duplicate work order',16,1)
				end
				
			END					
			
		END
		Else
		BEGIN
		    Set @OV_RETVALUE = 0
			select @WOSeqNo_First as SeqNumber, @OV_RETVALUE as ReturnVal		
			set @iv_return = 1
			set @UpdtWOSeqNo=@WOSeqNo_First	
		END
			-- End OF Modification 
	end
	else
	begin	
		-- *********************************************
				-- Modified Date : 5th September 2008
				-- Bug No		 : 2925	
			SELECT @JOB_QTY = jobi_bo_qty FROM tbl_wo_job_detail WHERE ID_WOITEM_SEQ= @WOSeqNo			
			--select @BACK_QTY = BackOrderQty from TBL_SPR_PURCHASEORDER_OLD where id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir)			
			select @BACK_QTY =  REMAINING_QTY from TBL_SPR_PO_ITEM where id_po = ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo
			select @JOB_QTY,@BACK_QTY
			IF @JOB_QTY <> @BACK_QTY
			BEGIN
					
				DECLARE @DELQTY DECIMAL
				select @DELQTY = DELIVERED_QTY from TBL_SPR_PO_ITEM where id_po=@ID_PO AND ID_WOITEM_SEQ= @WOSeqNo AND ID_ITEM = @id_item
				IF @DELQTY > @JOB_QTY 
					BEGIN
					 
						update tbl_wo_job_detail 
						set 
						--jobi_bo_qty = (select BackOrderQty from tbl_spr_purchaseorder where id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir)),
						JOBI_DELIVER_QTY=JOBI_DELIVER_QTY +  @JOB_QTY --(select DELIVEREDQTY from tbl_spr_inwardregister where id_ir= @id_ir)
						where  ID_WOITEM_SEQ= @WOSeqNo	
						
						update tbl_wo_job_detail 
						set jobi_bo_qty = JOBI_ORDER_QTY - JOBI_DELIVER_QTY
						where  ID_WOITEM_SEQ = @WOSeqNo
										
						set @iv_return = 1
						set @UpdtWOSeqNo=@WOSeqNo
						
						--ADDED FOR -ROW- 236
				if @FixedPrice=0.0 
							begin
					          exec USP_WO_RECALCULATEJOBTOT_NEWOREDER @ID_WOITEM_SEQ	
							end
						
					
					
					SELECT @USE_MANUAL_RWRK = USE_MANUAL_RWRK FROM 
					TBL_MAS_WO_CONFIGURATION
					WHERE	
					ID_SUBSIDERY_WO = @SUBID	AND 
					ID_DEPT_WO		= @DEPTID  AND
					DT_EFF_TO > getdate()
					
				IF @USE_MANUAL_RWRK = 0
				  BEGIN
					  
					  SELECT @BOJQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
										AND ID_WODET_SEQ_JOB = @ID_WODET_SEQ   
						GROUP BY ID_WODET_SEQ_JOB
		              
					 
					  SELECT @BOQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
                				GROUP BY ID_WO_NO,ID_WO_PREFIX

									
						SET @BOJQTY =ISNULL(@BOJQTY,0)
						SET @BOQTY =ISNULL(@BOQTY,0)
						IF @FLG_SPRSTS = '1'
							BEGIN
								UPDATE TBL_WO_DETAIL
								SET JOB_STATUS = 'CSA'
								WHERE ID_WODET_SEQ = @ID_WODET_SEQ
							END
					   ELSE
						   BEGIN
						        SELECT @TOTALCNT = COUNT(WOJ.ID_WODET_SEQ_JOB) FROM TBL_MAS_ITEM_MASTER MSTR
								 INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								 ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								 AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								 AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								 WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ
				 
				 
								SELECT @STOCKITEM =COUNT(FLG_STOCKITEM) FROM TBL_MAS_ITEM_MASTER MSTR
								INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ AND MSTR.FLG_STOCKITEM = 1
								IF @TOTALCNT = @STOCKITEM 
							   BEGIN
						      
										IF @BOJQTY  = 0 
										BEGIN                 
											UPDATE TBL_WO_DETAIL
															SET JOB_STATUS = 'RWRK'
											WHERE ID_WODET_SEQ = @ID_WODET_SEQ AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
										
										/*Change to update status for TBL_PLAN_JOB_DETAIL*/
											IF EXISTS(SELECT * FROM TBL_PLAN_JOB_DETAIL WHERE ID_WO_NO_JOB = @ID_WO_NO AND ID_WO_PREFIX  = @ID_WO_PREFIX AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ))  
												BEGIN
															UPDATE  TBL_PLAN_JOB_DETAIL 
															SET STATUS = 'RWRK'
															WHERE    
															ID_WO_NO_JOB      = @ID_WO_NO  
															AND ID_WO_PREFIX  = @ID_WO_PREFIX  
															AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ) AND  @WO_TYPE_WOH <>'CRSL'               
															AND @WH_STATUS = 0

												END
									   /****Change End****/		
										END

										IF @BOQTY  = 0 
										BEGIN                 
										      UPDATE TBL_WO_HEADER
											  SET WO_STATUS = 'RWRK'
										      WHERE ID_WO_NO = @ID_WO_NO AND ID_WO_PREFIX =@ID_WO_PREFIX AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
										END
							  END	
						   END	
				   END				

						
						   UPDATE 
							 ITEM 
							SET
							 ITEM.ITEM_AVAIL_QTY=ITEM.ITEM_AVAIL_QTY - @JOB_QTY
							FROM 
							TBL_SPR_PO_ITEM PO 
							INNER JOIN  
							TBL_MAS_ITEM_MASTER ITEM
							ON 
							ITEM.ID_ITEM=PO.ID_ITEM AND
							ITEM.SUPP_CURRENTNO=PO.SUPP_CURRENTNO	AND
							ID_PO=@ID_PO
							AND PO.ID_ITEM = @id_item
							AND PO.ID_WOITEM_SEQ= @WOSeqNo
						--UPDATE 
						--		TBL_MAS_ITEM_MASTER
						--SET
						--		ITEM_AVAIL_QTY=ITEM_AVAIL_QTY - @JOB_QTY 
						--FROM 
						--		TBL_SPR_INWARDREGISTER REG 
						--			INNER JOIN  
						--		TBL_MAS_ITEM_MASTER ITEM
						--ON 
						--		ITEM.ID_ITEM=REG.ID_ITEM AND
						--		ITEM.ID_MAKE=REG.ID_MAKE	AND
						--		ITEM.ID_WH_ITEM=REG.ID_WH_ITEM AND
						--		ID_IR=@id_ir	
					END
					ELSE
					BEGIN
					  
						update tbl_wo_job_detail 
						set 
						--jobi_bo_qty = (select BackOrderQty from tbl_spr_purchaseorder where id_po=(select id_po from tbl_spr_inwardregister where id_ir= @id_ir)),
						JOBI_DELIVER_QTY=JOBI_DELIVER_QTY + (select DELIVERED_QTY from TBL_SPR_PO_ITEM where id_po=@ID_PO AND ID_ITEM = @id_item AND ID_WOITEM_SEQ= @WOSeqNo)
						where  ID_WOITEM_SEQ= @WOSeqNo	
						
						update tbl_wo_job_detail 
						set jobi_bo_qty = JOBI_ORDER_QTY - JOBI_DELIVER_QTY
						where  ID_WOITEM_SEQ = @WOSeqNo
									
						set @iv_return = 1
						set @UpdtWOSeqNo=@WOSeqNo
						
			if @FixedPrice=0.0 
							begin
					          exec USP_WO_RECALCULATEJOBTOT_NEWOREDER @ID_WOITEM_SEQ	
							end
						
							
						--ADDED FOR -ROW- 236
								
					SELECT @USE_MANUAL_RWRK = USE_MANUAL_RWRK FROM 
					TBL_MAS_WO_CONFIGURATION
					WHERE	
					ID_SUBSIDERY_WO = @SUBID	AND 
					ID_DEPT_WO		= @DEPTID  AND
					DT_EFF_TO > getdate()
					
				IF @USE_MANUAL_RWRK = 0
			      BEGIN
				  
					  SELECT @BOJQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
										AND ID_WODET_SEQ_JOB = @ID_WODET_SEQ   
						GROUP BY ID_WODET_SEQ_JOB
		             					 
					  SELECT @BOQTY= SUM(JOBI_BO_QTY)     
						FROM TBL_WO_JOB_DETAIL JOB WHERE ID_WO_NO = @ID_WO_NO       
						AND ID_WO_PREFIX = @ID_WO_PREFIX 
                				GROUP BY ID_WO_NO,ID_WO_PREFIX

						
					  SET @BOJQTY =ISNULL(@BOJQTY,0)
					  SET @BOQTY =ISNULL(@BOQTY,0)
					IF @FLG_SPRSTS = '1'
						 BEGIN
								UPDATE TBL_WO_DETAIL
								SET JOB_STATUS = 'CSA'
								WHERE ID_WODET_SEQ = @ID_WODET_SEQ
						END
					 ELSE
						BEGIN
					            SELECT @TOTALCNT = COUNT(WOJ.ID_WODET_SEQ_JOB) FROM TBL_MAS_ITEM_MASTER MSTR
								 INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								 ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								 AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								 AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								 WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ
				 
				 
								SELECT @STOCKITEM =COUNT(FLG_STOCKITEM) FROM TBL_MAS_ITEM_MASTER MSTR
								INNER JOIN TBL_WO_JOB_DETAIL WOJ 
								ON MSTR.ID_ITEM = WOJ.ID_ITEM_JOB 
								AND MSTR.ID_ITEM_CATG = WOJ.ID_ITEM_CATG_JOB
								AND MSTR.ID_WH_ITEM = WOJ.ID_WAREHOUSE
								WHERE  WOJ.ID_WO_NO = @ID_WO_NO AND WOJ.ID_WO_PREFIX = @ID_WO_PREFIX AND WOJ.ID_WODET_SEQ_JOB=@ID_WODET_SEQ AND MSTR.FLG_STOCKITEM = 1
								IF @TOTALCNT = @STOCKITEM 
			       BEGIN	
			          
							IF @BOJQTY  = 0 
							BEGIN                 
											UPDATE TBL_WO_DETAIL
											SET JOB_STATUS = 'RWRK'
							WHERE ID_WODET_SEQ = @ID_WODET_SEQ AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
							
							/*Change to update status for TBL_PLAN_JOB_DETAIL*/
								IF EXISTS(SELECT * FROM TBL_PLAN_JOB_DETAIL WHERE ID_WO_NO_JOB = @ID_WO_NO AND ID_WO_PREFIX  = @ID_WO_PREFIX AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ))  
									BEGIN
												UPDATE  TBL_PLAN_JOB_DETAIL 
												SET STATUS = 'RWRK'
												WHERE    
												ID_WO_NO_JOB      = @ID_WO_NO  
												AND ID_WO_PREFIX  = @ID_WO_PREFIX  
												AND ID_JOB = (SELECT ID_JOB FROM TBL_WO_DETAIL WHERE ID_WODET_SEQ = @ID_WODET_SEQ) AND  @WO_TYPE_WOH <>'CRSL'               
												AND @WH_STATUS = 0

									END
						   /****Change End****/		
							END

							IF @BOQTY  = 0 
							BEGIN                 
								UPDATE TBL_WO_HEADER
								SET WO_STATUS = 'RWRK'
								WHERE ID_WO_NO = @ID_WO_NO AND ID_WO_PREFIX =@ID_WO_PREFIX AND  @WO_TYPE_WOH <>'CRSL' AND @WH_STATUS = 0
							END
					END	
					    END
					END
					
					
					        UPDATE 
							    ITEM 
							SET
							    ITEM.ITEM_AVAIL_QTY=ITEM.ITEM_AVAIL_QTY - @JOB_QTY
							FROM 
							TBL_SPR_PO_ITEM PO 
							INNER JOIN  
							TBL_MAS_ITEM_MASTER ITEM
							ON 
							ITEM.ID_ITEM=PO.ID_ITEM AND
							ITEM.SUPP_CURRENTNO=PO.SUPP_CURRENTNO	AND
							ID_PO=@ID_PO
							AND PO.ID_ITEM = @id_item
							AND PO.ID_WOITEM_SEQ= @WOSeqNo
					END
		
			SELECT @ID_WO_NO=ID_WO_NO,@ID_WO_PREFIX=ID_WO_PREFIX,@ID_JOB=ID_JOB,@USERID=CREATED_BY
			FROM TBL_WO_DETAIL
			WHERE ID_WODET_SEQ = (SELECT	ID_WODET_SEQ_JOB	FROM TBL_WO_JOB_DETAIL WHERE ID_WOITEM_SEQ=@WOSeqNo)


		         	EXEC USP_WO_RECALCULATEJOBTOT @ID_WO_NO,@ID_WO_PREFIX,@ID_JOB,@USERID
		
	                 	SELECT @ID_WO_NO_new=ID_WO_NO,@ID_WO_PREFIX_new=ID_WO_PREFIX,@ID_JOB_new=isnull(ID_JOB,0),@USERID=CREATED_BY
						FROM TBL_WO_DETAIL
						WHERE ID_WODET_SEQ =@WOSeqNo_New

			/*			EXEC USP_UPDATE_IR_WODETAIL @ID_WO_PREFIX_new,@ID_WO_NO_new,@ID_JOB_new,@USERID
			
			SELECT @IRNUMBER = IRNUMBER FROM TBL_SPR_INWARDREGISTER WHERE ID_IR = @ID_IR
					IF EXISTS(SELECT * FROM TBL_SPR_INWARDREGISTER WHERE IRNUMBER = @IRNUMBER)
					BEGIN
						UPDATE TBL_SPR_INWARDREGISTER SET FLG_UPDATE_BO = 1 WHERE IRNUMBER = @IRNUMBER
							if @Use_Approve='True' 
							begin
							UPDATE TBL_SPR_INWARDREGISTER SET FLG_APPROVE = 1 WHERE IRNUMBER = @IRNUMBER
                            update tbl_mas_item_master
							set AVG_PRICE =case when  @AvgPrice= 0 then AVG_PRICE else @AvgPrice end
							where id_item =@id_item and id_make=@id_make and id_wh_item = @id_wh_item
							end
					END
					*/
			END 
			ELSE
			begin				
			--select '@BACK_QTY ', @BACK_QTY
				if (@BACK_QTY >0) 
				begin	
					set @iv_return = 1
					set @UpdtWOSeqNo=@WOSeqNo
				end	
				else
					--select ERROR_MESSAGE()
					--raiserror('UUPDBOSNALINV',17,1)
					print 'BO Qty is 0'
					
					
			end
			-- ********************* End Of Modification *************
		end

END
GO
