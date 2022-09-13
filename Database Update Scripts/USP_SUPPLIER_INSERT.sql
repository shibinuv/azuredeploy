/****** Object:  StoredProcedure [dbo].[USP_SUPPLIER_INSERT]    Script Date: 29-03-2022 00:32:17 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SUPPLIER_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[USP_SUPPLIER_INSERT]    Script Date: 29-03-2022 00:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[USP_SUPPLIER_INSERT] 
(
    @ID_SUPPLIER varchar(30) = NULL,		-- Required
	@SUP_Name varchar(50),		-- Required
	@SUP_Contact_Name varchar(100)	= NULL,
	@SUP_Address1 varchar(100),	-- Required
    @SUP_Address2 varchar(100)	= NULL,
    @SUP_Zipcode varchar(100)	= NULL,
    @SUP_ID_Email varchar(100)	= NULL,
    @SUP_Phone_Off varchar(20)	= NULL,

    @SUP_Phone_Res varchar(20)	= NULL,
    @SUP_FAX varchar(20)	= NULL,
    @SUP_Phone_Mobile varchar(20)	= NULL,
	@CREATED_BY varchar(20)	= NULL,
    --@DT_CREATED datetime	= NULL,
    @MODIFIED_BY varchar(20)	= NULL,
    --@DT_MODIFIED datetime	= NULL,
    @SUP_SSN varchar(20)	= NULL,
    @SUP_REGION varchar(20)	= NULL,
    @SUP_BILLAddress1 varchar(100)	= NULL,
    @SUP_BILLAddress2 varchar(100)	= NULL,
	@SUP_BILLZipcode varchar(20)	= NULL,
    @LEADTIME varchar(20)	= NULL,
    @ORDER_FREQ varchar(20)	= NULL,
    @ID_ORDERTYPE varchar(20)	= NULL,
    @CLIENT_NO varchar(20)	= NULL,
    @WARRANTY varchar(20)	= NULL,
    @DESCRIPTION varchar(20)	= NULL,
    @ORDERDAY_MON bit	= NULL,
    @ORDERDAY_TUE bit	= NULL,
    @ORDERDAY_WED bit	= NULL,
	@ORDERDAY_THU bit	= NULL,
	@ORDERDAY_FRI bit	= NULL,
    
    @SUPP_CURRENTNO varchar(50)	= NULL,
    @SUP_CITY varchar(20)	= NULL,
    @SUP_COUNTRY varchar(10)	= NULL,
    @SUP_BILL_CITY varchar(10)	= NULL,
    @SUP_BILL_COUNTRY varchar(50)	= NULL,
    @FLG_SAME_ADDRESS bit = 0,
    @SUP_WEBPAGE varchar(50)	= NULL,
    @SUP_CURRENCY_CODE varchar(50)	= NULL,
	--Newly Added 29-12-2021
	@SUPPLIER_STOCK_ID varchar(20)=NULL,
	@DEALER_NO_SPARE varchar(50) = NULL,
	--End 
	--Newly Added 18-03-2022
	@FREIGHT_LIMIT smallint,
	@FREIGHT_PERC_BELOW smallint,
	@FREIGHT_PERC_ABOVE smallint,
	--End 
	@RETVAL					varchar(10) OUTPUT,
	@RETSUP				varchar(15) OUTPUT 
)

AS
BEGIN

DECLARE @DT_CREATED DATETIME = getdate()
DECLARE @DT_MODIFIED DATETIME = getdate()


IF @SUPP_CURRENTNO IS NULL OR @SUPP_CURRENTNO = ''
BEGIN
	DECLARE @START_NUM INT =  (SELECT TOP 1 SUPP_STARTNO FROM TBL_SPR_SUPPLIERNO ORDER BY ID_SUPPNO DESC) 
	DECLARE @NEXT_NUM INT = (SELECT TOP 1 t1.SUPP_CURRENTNO+1 FROM TBL_MAS_SUPPLIER t1 WHERE NOT EXISTS(SELECT * FROM TBL_MAS_SUPPLIER t2 where t2.SUPP_CURRENTNO = t1.SUPP_CURRENTNO + 1) and SUPP_CURRENTNO > @START_NUM ORDER BY CAST(t1.SUPP_CURRENTNO As INT))
	SET @SUPP_CURRENTNO = @NEXT_NUM
	IF LEN(@NEXT_NUM) = 0
	BEGIN
		SET @SUPP_CURRENTNO = @START_NUM
	END
END


PRINT @SUPP_CURRENTNO

-- Insert Statement if customer does not exist
IF NOT EXISTS (SELECT * FROM TBL_MAS_SUPPLIER WHERE SUPP_CURRENTNO = @SUPP_CURRENTNO)
BEGIN
	INSERT INTO [dbo].[TBL_MAS_SUPPLIER]
				(
      [SUP_Name]
      ,[SUP_Contact_Name]
      ,[SUP_Address1]
      ,[SUP_Address2]
      ,[SUP_Zipcode]
      ,[SUP_ID_Email]
      ,[SUP_Phone_Off]
      ,[SUP_Phone_Res]
      ,[SUP_FAX]
      ,[SUP_Phone_Mobile]
      ,[CREATED_BY]
      ,[DT_CREATED]
      ,[MODIFIED_BY]
      ,[DT_MODIFIED]
      ,[SUP_SSN]
      ,[SUP_REGION]
      ,[SUP_BILLAddress1]
      ,[SUP_BILLAddress2]
      ,[SUP_BILLZipcode]
      ,[LEADTIME]
      ,[ORDER_FREQ]
      ,[ID_ORDERTYPE]
      ,[CLIENT_NO]
      ,[WARRANTY]
      ,[DESCRIPTION]
      ,[ORDERDAY_MON]
      ,[ORDERDAY_TUE]
      ,[ORDERDAY_WED]
      ,[ORDERDAY_THU]
      ,[ORDERDAY_FRI]
      ,[SUPP_CURRENTNO]
      ,[SUP_CITY]
      ,[SUP_COUNTRY]
      ,[SUP_BILL_CITY]
      ,[SUP_BILL_COUNTRY]
      ,[FLG_SAME_ADDRESS]
      ,[SUP_WEBPAGE]
	  ,[SUP_CURRENCY_CODE]
	  --Newly Added 29-12-2021
	  ,[SUPPLIER_STOCK_ID]
	  ,[DEALER_NO_SPARE]
	  --Newly Added 18-03-2022
	  ,[FREIGHT_LIMIT]
	  ,[FREIGHT_PERC_BELOW]
	  ,[FREIGHT_PERC_ABOVE])
			VALUES
				(
      @SUP_Name
      ,@SUP_Contact_Name
      ,@SUP_Address1
      ,@SUP_Address2
      ,@SUP_Zipcode
      ,@SUP_ID_Email
      ,@SUP_Phone_Off
      ,@SUP_Phone_Res
      ,@SUP_FAX
      ,@SUP_Phone_Mobile
      ,@CREATED_BY
      ,@DT_CREATED
      ,@MODIFIED_BY
      ,@DT_MODIFIED
      ,@SUP_SSN
      ,@SUP_REGION
      ,@SUP_BILLAddress1
      ,@SUP_BILLAddress2
      ,@SUP_BILLZipcode
      ,@LEADTIME
      ,@ORDER_FREQ
      ,@ID_ORDERTYPE
      ,@CLIENT_NO
      ,@WARRANTY
      ,@DESCRIPTION
      ,@ORDERDAY_MON
      ,@ORDERDAY_TUE
      ,@ORDERDAY_WED
      ,@ORDERDAY_THU
      ,@ORDERDAY_FRI
      ,@SUPP_CURRENTNO
      ,@SUP_CITY
      ,@SUP_COUNTRY
      ,@SUP_BILL_CITY
      ,@SUP_BILL_COUNTRY
      ,@FLG_SAME_ADDRESS
      ,@SUP_WEBPAGE
	  ,@SUP_CURRENCY_CODE
	  --Newly Added 29-12-2021
	  ,@SUPPLIER_STOCK_ID 
	  ,@DEALER_NO_SPARE
	   --Newly Added 18-03-2022
	  ,@FREIGHT_LIMIT
	  ,@FREIGHT_PERC_BELOW
	  ,@FREIGHT_PERC_ABOVE)
		SET @RETVAL = 'INSFLG'
END
ELSE IF EXISTS (SELECT * FROM TBL_MAS_SUPPLIER WHERE SUPP_CURRENTNO = @SUPP_CURRENTNO) 
BEGIN
	UPDATE [dbo].[TBL_MAS_SUPPLIER]
	SET
		[SUP_Name] = @SUP_Name
      ,[SUP_Contact_Name] = @SUP_Contact_Name
      ,[SUP_Address1] = @SUP_Address1
      ,[SUP_Address2] = @SUP_Address2
      ,[SUP_Zipcode] = @SUP_Zipcode
      ,[SUP_ID_Email] = @SUP_ID_Email
      ,[SUP_Phone_Off] = @SUP_Phone_Off
      ,[SUP_Phone_Res] = @SUP_Phone_Res
      ,[SUP_FAX] = @SUP_FAX
      ,[SUP_Phone_Mobile] = @SUP_Phone_Mobile
      ,[MODIFIED_BY] = @MODIFIED_BY
      ,[DT_MODIFIED] = @DT_MODIFIED
      ,[SUP_SSN] = @SUP_SSN
      ,[SUP_REGION] = @SUP_REGION
      ,[SUP_BILLAddress1] = @SUP_BILLAddress1
      ,[SUP_BILLAddress2] = @SUP_BILLAddress2
      ,[SUP_BILLZipcode] = @SUP_BILLZipcode
      ,[LEADTIME] = @LEADTIME
      ,[ORDER_FREQ] = @ORDER_FREQ
      ,[ID_ORDERTYPE] = @ID_ORDERTYPE
      ,[CLIENT_NO] = @CLIENT_NO
      ,[WARRANTY] = @WARRANTY
      ,[DESCRIPTION] = @DESCRIPTION
      ,[ORDERDAY_MON] = @ORDERDAY_MON
      ,[ORDERDAY_TUE] = @ORDERDAY_TUE
      ,[ORDERDAY_WED] = @ORDERDAY_WED
      ,[ORDERDAY_THU] = @ORDERDAY_THU
      ,[ORDERDAY_FRI] = @ORDERDAY_FRI
      ,[SUPP_CURRENTNO] = @SUPP_CURRENTNO
      ,[SUP_CITY] = @SUP_CITY
      ,[SUP_COUNTRY] = @SUP_COUNTRY
      ,[SUP_BILL_CITY] = @SUP_BILL_CITY
      ,[SUP_BILL_COUNTRY] = @SUP_BILL_COUNTRY
      ,[FLG_SAME_ADDRESS] = @FLG_SAME_ADDRESS
      ,[SUP_WEBPAGE] = 	@SUP_WEBPAGE
	  ,[SUP_CURRENCY_CODE] = @SUP_CURRENCY_CODE
	  --Newly Added 29-12-2021
	  ,[SUPPLIER_STOCK_ID]=@SUPPLIER_STOCK_ID 
	  ,[DEALER_NO_SPARE]=@DEALER_NO_SPARE 
	  --Newly Added 18-03-2022
	  ,[FREIGHT_LIMIT] = @FREIGHT_LIMIT
	  ,[FREIGHT_PERC_BELOW] = @FREIGHT_PERC_BELOW
	  ,[FREIGHT_PERC_ABOVE] = @FREIGHT_PERC_ABOVE
	WHERE 
		ID_SUPPLIER = @ID_SUPPLIER
	SET @RETVAL = 'UPDFLG'
	END
	SET @RETSUP = @SUPP_CURRENTNO
END

PRINT @RETVAL
GO
