USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_GDPR_FETCH]    Script Date: 01.06.2022 09:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dag Jakobsen
-- Create date: 15.09.2015
-- Description:	To fetch customer details
-- Modified: 2015/12/2 TWN - Added new columns FLG_NO_GM and FLG_NO_ENV_FEE
-- =============================================
ALTER PROCEDURE [dbo].[USP_GDPR_FETCH]
	-- Add the parameters for the stored procedure here
	@ID_CUST varchar(10) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT [GDPR_ID]
      ,[CUST_NO]
      ,[MANUAL_SMS]
      ,[MANUAL_MAIL]
      ,[PKK_SMS]
      ,[PKK_MAIL]
      ,[SERVICE_SMS]
      ,[SERVICE_MAIL]
      ,[BARGAIN_SMS]
      ,[BARGAIN_MAIL]
      ,[XTRACHECK_SMS]
      ,[XTRACHECK_MAIL]
      ,[REMINDER_SMS]
      ,[REMINDER_MAIL]
      ,[INFO_SMS]
      ,[INFO_MAIL]
      ,[FOLLOWUP_SMS]
      ,[FOLLOWUP_MAIL]
      ,[MARKETING_SMS]
      ,[MARKETING_MAIL]
      ,[DT_RESPONSE]
      ,[DT_CREATED]
      ,[DT_CREATED_BY]
      ,[DT_MODIFIED]
      ,[DT_MODIFIED_BY]
	  ,[RESPONSE_ID]
  FROM [dbo].[TBL_MAS_CUSTOMER_GDPR]
 WHERE [CUST_NO] = @ID_CUST 
END
