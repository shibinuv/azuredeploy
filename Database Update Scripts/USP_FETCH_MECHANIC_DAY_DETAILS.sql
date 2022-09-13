/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_DAY_DETAILS]    Script Date: 22-06-2021 13:07:55 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_MECHANIC_DAY_DETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_DAY_DETAILS]    Script Date: 22-06-2021 13:07:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_MECHANIC_DAY_DETAILS]
	@ID_LOGIN varchar(30),
	@FROM_DATE datetime
AS
BEGIN

	DECLARE @MECH_TEMP_TABLE table(ID_LOGIN varchar(30),MECHANIC_NAME varchar(50),FROM_TIME datetime,TO_TIME datetime,REASON varchar(50));
	DECLARE @WORKFROM DATETIME
	DECLARE @WORKTO DATETIME
	DECLARE @LUNCHFROM DATETIME
	DECLARE @LUNCHTO DATETIME
	DECLARE @DAYOFWEEK VARCHAR(MAX)

  
	  /*MECH SETTINGS*/

		DECLARE  @TEMP_HOLIDAY TABLE(
		ID_LOGIN varchar(50),
		FROM_DATE datetime,	
		FROM_TIME datetime,		
		TO_DATE datetime,		
		TO_TIME datetime,
		REASON varchar(50)
		)

		INSERT INTO @TEMP_HOLIDAY 
		select ID_LOGIN,FROM_DATE,FROM_TIME,TO_DATE,TO_TIME,LEAVE_REASON from TBL_MECHANIC_SETTINGS where ID_LOGIN=@ID_LOGIN and FROM_DATE<=@FROM_DATE --and TO_TIME>=@FROM_DATE

		declare @startday datetime ;
		declare @endday datetime;

		--SELECT @startday = FROM_DATE, @endday = TO_DATE FROM @TEMP_HOLIDAY where ID_LOGIN = 'pv24';

		
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
			END AS new_date_to,
			T.REASON
			into #templist
		FROM
			@TEMP_HOLIDAY AS T
			CROSS APPLY
			(
				SELECT CTE_Numbers.Number - 1 AS Number0
				FROM CTE_Numbers
				WHERE CTE_Numbers.Number <= DATEDIFF(day, T.FROM_TIME, T.TO_TIME) + 1
			) AS CA
	
		ORDER BY
			new_date_from
		;
	  /*MECH SETTINGS*/


 SET @dayOfWeek=DATENAME(WEEKDAY, @FROM_DATE)  
         
 IF @dayOfWeek='Sunday'  
  Select @workFrom=SUNDAY_FROM_TIME,@workTo=SUNDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@ID_LOGIN  
 ELSE IF @dayOfWeek='Monday'  
  Select @workFrom=MONDAY_FROM_TIME,@workTo=MONDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@ID_LOGIN  
 ELSE IF @dayOfWeek='Tuesday'  
  Select @workFrom=TUESDAY_FROM_TIME,@workTo=TUESDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@ID_LOGIN  
 ELSE IF @dayOfWeek='Wednesday'  
  Select @workFrom=WEDNESDAY_FROM_TIME,@workTo=WEDNESDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@ID_LOGIN  
 ELSE IF @dayOfWeek='Thursday'  
  Select @workFrom=THURSDAY_FROM_TIME,@workTo=THURSDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@ID_LOGIN  
 ELSE IF @dayOfWeek='Friday'  
  Select @workFrom=FRIDAY_FROM_TIME,@workTo=FRIDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@ID_LOGIN  
 ELSE IF @dayOfWeek='Saturday'  
  Select @workFrom=SATURDAY_FROM_TIME,@workTo=SATURDAY_TO_TIME ,@lunchFrom=LUNCH_FROM_TIME,@lunchTo=LUNCH_TO_TIME from TBL_MECHANIC_CONFIG_SETTINGS WHERE MECHANIC_ID=@ID_LOGIN  
   
 SET @workFrom=CONCAT(CONVERT(varchar(10), @FROM_DATE,111),' ',CONVERT(varchar(12),CAST(@workFrom AS TIME)))  
 SET @workTo=CONCAT(CONVERT(varchar(10), @FROM_DATE,111),' ',CONVERT(varchar(12),CAST(@workTo AS TIME)))  
 SET @lunchFrom=CONCAT(CONVERT(varchar(10), @FROM_DATE,111),' ',CONVERT(varchar(12),CAST(@lunchFrom AS TIME)))  
 SET @lunchTo=CONCAT(CONVERT(varchar(10), @FROM_DATE,111),' ',CONVERT(varchar(12),CAST(@lunchTo AS TIME)))  
  -- If Leave Exist for a mechanic in a particular day  
 IF exists(select * FROM #templist where ID_LOGIN=@ID_LOGIN AND CONVERT(DATE, new_date_from) = CONVERT(DATE, @FROM_DATE))  
  BEGIN  

   insert @MECH_TEMP_TABLE SELECT ID_LOGIN,ID_LOGIN,new_date_from,new_date_to,REASON  --'LEAVE'  
   FROM #templist where ID_LOGIN=@ID_LOGIN AND CONVERT(DATE, new_date_from) = CONVERT(DATE, @FROM_DATE)  
  END  


   DECLARE @APT_START_TIME As DateTime  
   DECLARE @APT_END_TIME As DateTime  
  
   SELECT @APT_START_TIME= START_TIME,@APT_END_TIME=END_TIME FROM TBL_APPOINTMENT_DETAILS where RESOURCE_ID=@ID_LOGIN AND START_DATE >= CONVERT(DATE, @FROM_DATE) AND JOB_STATUS NOT IN ('DEL','ONHOLD')  
  
   insert @MECH_TEMP_TABLE SELECT RESOURCE_ID AS ID_LOGIN,RESOURCE_ID, START_TIME ,END_TIME,APPOINTMENT_ID As REASON  
   FROM TBL_APPOINTMENT_DETAILS where RESOURCE_ID=@ID_LOGIN AND  CONVERT(DATE,START_DATE)= CONVERT(DATE, @FROM_DATE) AND JOB_STATUS NOT IN ('DEL','ONHOLD')  
  
    CREATE TABLE [dbo].[ReservationDetails](  
    [SessionID] [int] IDENTITY(1,1) NOT NULL,  
    [UserID] [bigint]  NULL,  
    [ExpectedStart] [datetime] NOT NULL,  
    [ExpectedEnd] [datetime] NOT NULL,  
    [Reason] varchar(30))  
  
    insert [ReservationDetails] SELECT APPOINTMENT_ID, START_TIME AS [ExpectedStart] ,END_TIME As [ExpectedEnd],APPOINTMENT_ID As REASON  
    FROM TBL_APPOINTMENT_DETAILS where RESOURCE_ID=@ID_LOGIN AND CONVERT(DATE,START_DATE)= CONVERT(DATE, @FROM_DATE) AND JOB_STATUS NOT IN ('DEL','ONHOLD')  
    INSERT INTO ReservationDetails (ExpectedStart,ExpectedEnd)  
    VALUES (@LUNCHFROM,@LUNCHTO)  
  
    IF exists(select * FROM #templist where ID_LOGIN=@ID_LOGIN AND CONVERT(DATE, new_date_from) = CONVERT(DATE, @FROM_DATE))  
    BEGIN  
     insert [ReservationDetails] SELECT 1,new_date_from,new_date_to,REASON--'LEAVE'
     FROM #templist where ID_LOGIN=@ID_LOGIN AND CONVERT(DATE, new_date_from) = CONVERT(DATE, @FROM_DATE)  
    END  
  
    declare @starttime datetime=@workFrom   
    declare @endtime datetime=@workTo   
  
  
    --===== Create number table on-the-fly  
    ;WITH Num1 (n) AS (  
    SELECT 1 as n  
    UNION ALL SELECT n+1 as n  
    FROM Num1 Where n<101),  
    Num2 (n) AS (SELECT 1 FROM Num1 AS X, Num1 AS Y),  
    Nums (n) AS (SELECT ROW_NUMBER() OVER(ORDER BY n) FROM Num2)  
   
    ,mytime as (  
    select  dateadd(minute,n-1, starttime) dt    
    from (select @starttime starttime) t   
    cross apply (select n from Nums) d(n)  
     WHERE dateadd(minute,n-1,starttime)<=@endtime  
    )  
  
    ,mycte2 as (  
    select dt  
    , DATEADD(minute, - ROW_NUMBER() OVER( ORDER BY dt), dt) AS grp   
    from mytime m  
    where not exists (select *   
    from ReservationDetails r   
    where dt > ExpectedStart and dt<ExpectedEnd)  
    )  
  
  select row_number() Over(order by grp) rn,  
    CONVERT(VARCHAR(5), min(dt), 108)  as FROM_TIME  
    ,CONVERT(VARCHAR(5), max(dt), 108)  as TO_TIME  
    ,'Ledig' AS REASON  
    INTO #TEMPDATA1  
    from mycte2  
      
    group by grp  
   
    --insert INTO @MECH_TEMP_TABLE values(@ID_LOGIN,@ID_LOGIN,@LUNCHFROM,@LUNCHTO,'Lunch');  

    select FROM_TIME,TO_TIME,REASON from #TEMPDATA1 where FROM_TIME<>TO_TIME  
    UNION ALL  
    SELECT CONVERT(VARCHAR(5), FROM_TIME, 108)  AS FROM_TIME,CONVERT(VARCHAR(5), TO_TIME, 108) AS TO_TIME,REASON FROM @MECH_TEMP_TABLE   
    order by FROM_TIME  
  
    drop table ReservationDetails  
    drop table #TEMPDATA1  
  
  
    drop table #templist
END  
GO
