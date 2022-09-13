/****** Object:  StoredProcedure [dbo].[USP_PROCESS_ONHOLD_APPOINTMENT]    Script Date: 11-06-2021 18:36:15 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_PROCESS_ONHOLD_APPOINTMENT]
GO
/****** Object:  StoredProcedure [dbo].[USP_PROCESS_ONHOLD_APPOINTMENT]    Script Date: 11-06-2021 18:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_PROCESS_ONHOLD_APPOINTMENT] 
	@ACTION VARCHAR(40),
	@ID_APT_DTL int,
	--@ID_APT_HDR int,
	@START_DATE datetime,
	@END_DATE datetime,
	@RESOURCE_ID varchar(max)
AS
BEGIN
	
	IF @ACTION = 'FETCH'
		BEGIN
			--SELECT * FROM TBL_APPOINTMENT_DETAILS WHERE isNULL(JOB_STATUS,'')='ONHOLD'     CAST(APPOINTMENT_ID as varchar(20))+'-' + CAST(APT_SERIAL_NO as varchar(20)) As APPOINTMENT_ID
			SELECT AD.*,ISNULL(AH.ID_WO_NO,'') AS WONO ,AH.CUSTOMER_FIRST_NAME,AH.CUSTOMER_MIDDLE_NAME,Ah.CUSTOMER_LAST_NAME,AH.VEHICLE_REG_NO,CAST(AD.APPOINTMENT_ID as varchar(20))+'-' + CAST(AD.APT_SERIAL_NO as varchar(20)) As APPOINTMENT_NO,AH.WO_VEH_MAK_MOD_MAP,AH.WO_VEH_MOD,MAK.Desc_Govt AS VEH_MAKE
			FROM TBL_APPOINTMENT_DETAILS AD
			INNER JOIN TBL_APPOINTMENTS_HEADER AH ON AH.APPOINTMENT_ID = AD.APPOINTMENT_ID 
			INNER JOIN TBL_MAP_MAKE_GOVT_ABS MAK ON MAK.MAKE_CODE_GOVT=AH.WO_VEH_MAK_MOD_MAP
			WHERE ISNULL(JOB_STATUS,'')='ONHOLD'
			--SELECT MAKE_CODE_GOVT AS ID_MAKE_VEH, DESC_GOVT AS MAKE FROM TBL_MAP_MAKE_GOVT_ABS ORDER BY DESC_GOVT   
		END
	IF @Action = 'UPDATEONHOLD'
		BEGIN
			UPDATE TBL_APPOINTMENT_DETAILS SET JOB_STATUS='ONHOLD' WHERE ID_APPOINTMENT_DETAILS=@ID_APT_DTL
		END
	IF @Action = 'UPDATE'
		BEGIN
			--UPDATE TBL_APPOINTMENT_DETAILS SET JOB_STATUS='NA' WHERE ID_APPOINTMENT_DETAILS=@ID_APT_DTL
			
					

			--DECLARE @WO_NUM  varchar(30)
			DECLARE @ResourceIds varchar(max)
			--SELECT @WO_NUM=ID_WO_NO FROM TBL_APPOINTMENTS_HEADER WHERE APPOINTMENT_ID=@ID_APT_HDR
			SET @ResourceIds ='<ResourceIds><ResourceId Type="System.String" Value="'+ @RESOURCE_ID +'"/></ResourceIds>'
			--IF  @WO_NUM IS NULL OR @WO_NUM  =  '0' 
			BEGIN
				UPDATE TBL_APPOINTMENT_DETAILS 
				SET JOB_STATUS='',
				START_DATE = @START_DATE,
				END_DATE = @END_DATE,
				START_TIME = @START_DATE,
				END_TIME = @END_DATE,
				RESOURCE_IDs = @ResourceIds,
				RESOURCE_ID = @RESOURCE_ID 
				WHERE ID_APPOINTMENT_DETAILS = @ID_APT_DTL


				-- This is to update the Job accordingly after OnHold is back to Appointment
				DECLARE @TOT_JOB int, @APPOINTMENT_ID int
				DECLARE @ID_JOB int
				
				SELECT @APPOINTMENT_ID = APPOINTMENT_ID FROM TBL_APPOINTMENT_DETAILS WHERE ID_APPOINTMENT_DETAILS = @ID_APT_DTL
				SELECT @ID_JOB =ID_JOB FROM TBL_APPOINTMENT_DETAILS WHERE APPOINTMENT_ID = @APPOINTMENT_ID 
				AND RESOURCE_ID=@RESOURCE_ID AND CAST(@START_DATE AS DATE)=CAST(START_DATE AS DATE) AND JOB_STATUS <>'DEL' AND ID_APPOINTMENT_DETAILS <> @ID_APT_DTL

				SELECT @TOT_JOB=MAX(ISNULL(ID_JOB,0)) FROM TBL_APPOINTMENT_DETAILS WHERE APPOINTMENT_ID = @APPOINTMENT_ID AND JOB_STATUS <>'DEL' AND ID_APPOINTMENT_DETAILS <> @ID_APT_DTL
				IF  (ISNULL(@ID_JOB,0)=0)
					BEGIN
						SET @ID_JOB=ISNULL(@TOT_JOB,0)+1
					END 

				UPDATE TBL_APPOINTMENT_DETAILS 
				SET ID_JOB = @ID_JOB
				WHERE ID_APPOINTMENT_DETAILS = @ID_APT_DTL	

				DECLARE @WORKFROM DATETIME
				DECLARE @WORKTO DATETIME
				DECLARE @LUNCHFROM DATETIME
				DECLARE @LUNCHTO DATETIME
				DECLARE @ISOVERTIME BIT =0
				DECLARE @DAYOFWEEK VARCHAR(MAX)
				DECLARE @STARTTIME AS TIME,@ENDTIME AS TIME,@WORKFROMTIME AS TIME,@WORKTOTIME AS TIME , @LUNCHFROMTIME AS TIME , @LUNCHTOTIME AS TIME
				BEGIN							
						SET @dayOfWeek=DATENAME(WEEKDAY, @START_DATE)
							
						IF @dayOfWeek='Sunday'
								Select @workFrom=SUNDAY_FROM_TIME,@workTo=SUNDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
							ELSE IF @dayOfWeek='Monday'
								Select @workFrom=MONDAY_FROM_TIME,@workTo=MONDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
							ELSE IF @dayOfWeek='Tuesday'
								Select @workFrom=TUESDAY_FROM_TIME,@workTo=TUESDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
							ELSE IF @dayOfWeek='Wednesday'
								Select @workFrom=WEDNESDAY_FROM_TIME,@workTo=WEDNESDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
							ELSE IF @dayOfWeek='Thursday'
								Select @workFrom=THURSDAY_FROM_TIME,@workTo=THURSDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
							ELSE IF @dayOfWeek='Friday'
								Select @workFrom=FRIDAY_FROM_TIME,@workTo=FRIDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
							ELSE IF @dayOfWeek='Saturday'
								Select @workFrom=SATURDAY_FROM_TIME,@workTo=SATURDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID



						SELECT @STARTTIME = CONVERT(VARCHAR(5), @START_DATE, 108) , @WORKFROMTIME=CONVERT(VARCHAR(5), @WORKFROM, 108), 
						@ENDTIME = CONVERT(VARCHAR(5), @END_DATE, 108) , @WORKTOTIME = CONVERT(VARCHAR(5), @WORKTO, 108) , @LUNCHFROMTIME = CONVERT(VARCHAR(5), @LUNCHFROM, 108),	
						@LUNCHTOTIME = CONVERT(VARCHAR(5), @LUNCHTO, 108)

						SELECT CONVERT(VARCHAR(5), @STARTTIME, 108) STARTTIME,CONVERT(VARCHAR(5), @ENDTIME, 108) ENDTIME,
						CONVERT(VARCHAR(5), @WORKFROMTIME, 108) WORKFROMTIME ,CONVERT(VARCHAR(5), @WORKTOTIME, 108) WORKTOTIME,
						CONVERT(VARCHAR(5), @LUNCHFROMTIME, 108)  LUNCHFROMTIME, CONVERT(VARCHAR(5), @LUNCHTOTIME, 108) LUNCHTOTIME

						IF (CONVERT(VARCHAR(5), @startTime, 108) < CONVERT(VARCHAR(5), @workFromTime, 108)) OR (CONVERT(VARCHAR(5), @endTime, 108) > CONVERT(VARCHAR(5), @workToTime, 108))
						BEGIN							
							--select 1
							SELECT @isOverTime=1 
						END
						--ELSE IF CONVERT(VARCHAR(5), @startTime, 108) <= CONVERT(VARCHAR(5), @lunchFromTime, 108) AND CONVERT(VARCHAR(5), @endTime, 108) > CONVERT(VARCHAR(5), @lunchToTime, 108)
						--BEGIN
						--	--select 2
						--	SELECT @isOverTime=1 
						--END
						--ELSE IF CONVERT(VARCHAR(5), @startTime, 108) >= CONVERT(VARCHAR(5), @lunchFromTime, 108) AND CONVERT(VARCHAR(5), @endTime, 108) <= CONVERT(VARCHAR(5), @lunchToTime, 108)
						--BEGIN
						--	--select 3
						--	SELECT @isOverTime=1 
						--END
						--ELSE IF CONVERT(VARCHAR(5), @startTime, 108) >= CONVERT(VARCHAR(5), @lunchFromTime, 108) AND CONVERT(VARCHAR(5), @startTime, 108) < CONVERT(VARCHAR(5), @lunchToTime, 108)
						--BEGIN
						--	--select 4
						--	SELECT @isOverTime=1 
						--END
						--ELSE IF CONVERT(VARCHAR(5), @endTime, 108) > CONVERT(VARCHAR(5), @lunchFromTime, 108) AND CONVERT(VARCHAR(5), @endTime, 108) <= CONVERT(VARCHAR(5), @lunchToTime, 108)
						--BEGIN				
						--	--select 5
						--	SELECT @isOverTime=1 
						--END
	
					END

				UPDATE TBL_APPOINTMENT_DETAILS SET IS_OVER_TIME =@isOverTime 	WHERE ID_APPOINTMENT_DETAILS = @ID_APT_DTL


				DECLARE @ID_WO_NO Varchar(10)
				DECLARE @ID_WO_PREFIX Varchar(3)
				DECLARE @MECH_NAME VARCHAR(40)

				-- Mechanic Column Order Changes
				SELECT @ID_WO_NO = ISNULL(ID_WO_NO,''),@ID_WO_PREFIX = ISNULL(ID_WO_PREFIX,'') FROM TBL_APPOINTMENT_DETAILS WHERE  ID_APPOINTMENT_DETAILS=@ID_APT_DTL

				IF EXISTS (SELECT * FROM TBL_WO_HEADER WHERE ID_WO_NO = @ID_WO_NO and ID_WO_PREFIX = @ID_WO_PREFIX)
				BEGIN

					SELECT @MECH_NAME = First_Name +' '+ Last_Name FROM TBL_MAS_USERS WHERE ID_LOGIN = @RESOURCE_ID

					UPDATE TBL_WO_HEADER 
					SET MechId = @RESOURCE_ID,MechName = @MECH_NAME
					WHERE ID_WO_NO = @ID_WO_NO and ID_WO_PREFIX = @ID_WO_PREFIX
				END

			END
			
		END

		IF @Action='GRIDUPDATE'
		BEGIN
			UPDATE TBL_APPOINTMENT_DETAILS SET JOB_STATUS='',START_DATE=@START_DATE,END_DATE=@END_DATE,START_TIME=@START_DATE,END_TIME=@END_DATE WHERE ID_APPOINTMENT_DETAILS=@ID_APT_DTL
		END


	
		
END
GO
