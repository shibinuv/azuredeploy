/****** Object:  StoredProcedure [dbo].[USP_PROCESS_APPOINTMENT_DETAILS_SPLIT]    Script Date: 29-06-2021 18:46:58 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_PROCESS_APPOINTMENT_DETAILS_SPLIT]
GO
/****** Object:  StoredProcedure [dbo].[USP_PROCESS_APPOINTMENT_DETAILS_SPLIT]    Script Date: 29-06-2021 18:46:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_PROCESS_APPOINTMENT_DETAILS_SPLIT] 
	   @Action VARCHAR(30)
      ,@ID_APPOINTMENT_DETAILS INT = 0
      ,@START_DATE DateTime = NULL
	  ,@START_TIME DateTime= NULL
	  ,@END_DATE DateTime = NULL
	  ,@END_TIME DateTime = NULL
      ,@TEXT VARCHAR(30) = NULL
	  ,@RESERVATION VARCHAR(50) = NULL
	  ,@SEARCH VARCHAR(30) = NULL
	  ,@APPOINTMENT_ID int = 0
	  ,@RESOURCE_ID varchar(max) = NULL
	  ,@CREATED_BY varchar(30) = NULL,

	  --NEWLY ADDED
	  @COLOR_CODE varchar(40) = NULL,
	  @JOB_STATUS_ID int = 0,

	  --27-04-2021
	  @TEXT_LINE1 varchar(50) = NULL,
	  @TEXT_LINE2 varchar(50) = NULL,
	  @TEXT_LINE3 varchar(50) = NULL,
	  @TEXT_LINE4 varchar(50) = NULL,
	  @TEXT_LINE5 varchar(50) = NULL,

	  @SPARE_PART_STATUS int = NULL,

	  @overtime bit = 0 --Added for overtime
AS
BEGIN
	
    SET NOCOUNT ON;
 

		DECLARE  @TEMP_APPOINTMENT TABLE(
		ID_LOGIN varchar(50),
		FROM_TIME datetime,		
		TO_TIME datetime		
		)

	  	DECLARE @WORKFROM DATETIME
		DECLARE @WORKTO DATETIME
		DECLARE @DAYOFWEEK VARCHAR(MAX)
		DECLARE @displaysatsun bit

		DECLARE @datemin int 


		INSERT INTO @TEMP_APPOINTMENT VALUES(@RESOURCE_ID,@START_TIME,@END_TIME);


		WITH E00(Number) AS (SELECT 1 UNION ALL SELECT 1)
			,E02(Number) AS (SELECT 1 FROM E00 a, E00 b)
			,E04(Number) AS (SELECT 1 FROM E02 a, E02 b)
			,E08(Number) AS (SELECT 1 FROM E04 a, E04 b)
			,CTE_Numbers(Number) AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL) ) FROM E08)

		SELECT ROW_NUMBER() OVER(ORDER BY ID_LOGIN) AS 'ROWNUM',
			T.ID_LOGIN
			,CASE WHEN CA.Number0 = 0
			THEN FROM_TIME
			ELSE DATEADD(day, CA.Number0, CAST(T.FROM_TIME as date))
			END AS new_date_from
			,
	
			CASE WHEN CA.Number0 = DATEDIFF(day, T.FROM_TIME, T.TO_TIME)
			THEN TO_TIME
			ELSE
				DATEADD(Minute,-1,
					CAST(
						DATEADD(day, CA.Number0 + 1, CAST(T.FROM_TIME as date)) as datetime)
						)
			END AS new_date_to
			into #templist
		FROM
			@TEMP_APPOINTMENT AS T
			CROSS APPLY
			(
				SELECT CTE_Numbers.Number - 1 AS Number0
				FROM CTE_Numbers
				WHERE CTE_Numbers.Number <= DATEDIFF(day, T.FROM_TIME, T.TO_TIME) + 1
			) AS CA
	
		ORDER BY
			new_date_from
		;


		declare @maxrow int
		declare @CTR int
		declare @TR int
		declare @row int=1
		declare @update int
		
		select @maxrow = max(ROWNUM) from #templist
		
	--select '#templist - before update',FORMAT(new_date_from, 'dddd'),* from #templist

	/*Parse the records*/

	WHILE(@row<=@maxrow)
	begin

		select @dayOfWeek=FORMAT(new_date_from, 'dddd') from #templist where ROWNUM = @row

			IF @dayOfWeek='Sunday'
				Select @workFrom=SUNDAY_FROM_TIME,@workTo=SUNDAY_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
			ELSE IF @dayOfWeek='Monday'
				Select @workFrom=MONDAY_FROM_TIME,@workTo=MONDAY_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
			ELSE IF @dayOfWeek='Tuesday'
				Select @workFrom=TUESDAY_FROM_TIME,@workTo=TUESDAY_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
			ELSE IF @dayOfWeek='Wednesday'
				Select @workFrom=WEDNESDAY_FROM_TIME,@workTo=WEDNESDAY_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
			ELSE IF @dayOfWeek='Thursday'
				Select @workFrom=THURSDAY_FROM_TIME,@workTo=THURSDAY_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
			ELSE IF @dayOfWeek='Friday'
				Select @workFrom=FRIDAY_FROM_TIME,@workTo=FRIDAY_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID
			ELSE IF @dayOfWeek='Saturday'
				Select @workFrom=SATURDAY_FROM_TIME,@workTo=SATURDAY_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@RESOURCE_ID

		update #templist set new_date_from = CONVERT(VARCHAR(10),new_date_from,121)+' '+CONVERT(VARCHAR(8),@workFrom,108) where ROWNUM = @row and ROWNUM <> 1
		
		if(@overtime=1 and @row =1 and @maxrow =1)
		begin
			SELECT @datemin = DATEDIFF(MINUTE, CONVERT(VARCHAR(10),new_date_to,121)+' '+CONVERT(VARCHAR(8),@workTo,108) , new_date_to) FROM #templist where ROWNUM = 1 
			 
			update #templist set new_date_to = CONVERT(VARCHAR(10),new_date_to,121)+' '+CONVERT(VARCHAR(8),@workTo,108) where ROWNUM = 1 
			
			insert into #templist 
				select @row +1, ID_LOGIN,(CONVERT(VARCHAR(10),new_date_from+1,121))+' '+CONVERT(VARCHAR(8),@workFrom,108), DATEADD(MINUTE,@datemin,((CONVERT(VARCHAR(10),new_date_from+1,121))+' '+CONVERT(VARCHAR(8),@workFrom,108))) from #templist
			
			set @maxrow = 2
		end
		else
		begin
			update #templist set new_date_to = CONVERT(VARCHAR(10),new_date_to,121)+' '+CONVERT(VARCHAR(8),@workTo,108) where ROWNUM = @row and ROWNUM <> @maxrow
		end
		
		--select '#templist - after update',FORMAT(new_date_from, 'dddd'),* from #templist
		
		SELECT @displaysatsun = DISPLAY_SATSUN FROM TBL_APPOINTMENT_CONFIG_SETTINGS


		set @CTR = @row

		if(@workFrom = @workTo OR (@displaysatsun = 0 AND (@dayOfWeek = 'Saturday' OR @dayOfWeek = 'Sunday')))		
		begin
			WHILE(@CTR<=@maxrow)
			begin
				update #templist set new_date_from=new_date_from+1,new_date_to=new_date_to+1 where ROWNUM = @CTR
				set @CTR = @CTR + 1
			end
			set @update=1
		end
		else
		begin
				select @START_DATE = new_date_from,@END_DATE = new_date_to from #templist where ROWNUM = @CTR

				IF(@CTR > 1) --TEXT LINES ARE ENTERED ONLY FOR THE FIRST RECORD
				BEGIN
					SET @TEXT_LINE1 = ''
					SET @TEXT_LINE2 = ''
					SET @TEXT_LINE3 = ''
					SET @TEXT_LINE4 = ''
					SET @TEXT_LINE5 = ''

					SET @Action='INSERT' 
					SET @ID_APPOINTMENT_DETAILS = 0
				END

				exec [USP_PROCESS_APPOINTMENT_DETAILS] 
				   @Action
				  ,@ID_APPOINTMENT_DETAILS
				  ,@START_DATE
				  ,@START_DATE
				  ,@END_DATE
				  ,@END_DATE
				  ,@TEXT
				  ,@RESERVATION
				  ,@SEARCH
				  ,@APPOINTMENT_ID
				  ,@RESOURCE_ID
				  ,@CREATED_BY
				  ,@COLOR_CODE
				  ,@JOB_STATUS_ID
				  ,@TEXT_LINE1
				  ,@TEXT_LINE2
				  ,@TEXT_LINE3 
				  ,@TEXT_LINE4
				  ,@TEXT_LINE5
				  ,@SPARE_PART_STATUS
		end

	if(@update=1)
		set @update=0
	else
		set @row = @row + 1
	end

	--select '#templist - after update',FORMAT(new_date_from, 'dddd'),* from #templist
	drop table #templist


END
GO
