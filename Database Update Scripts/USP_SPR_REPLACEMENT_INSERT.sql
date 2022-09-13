USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_REPLACEMENT_INSERT]    Script Date: 07.04.2020 08:03:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[USP_SPR_REPLACEMENT_INSERT]
	-- Add the parameters for the stored procedure here
@USER	varchar(50),
@MAIN_ITEM VARCHAR(50),
@PREV_ITEM VARCHAR(50),
@NEW_ITEM VARCHAR(50),
@SUPP_CURRENTNO VARCHAR(50),


@RET_VAL VARCHAR(10) OUTPUT	
AS
IF NOT EXISTS (SELECT * FROM TBL_SPR_REPLACEMENT WHERE THIS_ID_ITEM = @MAIN_ITEM AND THIS_SUPP_CURRENTNO = @SUPP_CURRENTNO)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	IF @NEW_ITEM <> '' 
	INSERT INTO [TBL_SPR_REPLACEMENT]
           ([THIS_ID_ITEM]
           ,[REPLACE_ID_ITEM]
           ,[REPLACEMENTCODE]
           ,[REPLACEMENTQTY]
           ,[REPLACEMENT_MAIN]
           ,[DESCRIPTION]
           ,[CREATED_BY]
           ,[DT_CREATED]
           ,[THIS_SUPP_CURRENTNO]
           ,[REPLACE_SUPP_CURRENTNO]           
           		   )
     VALUES
           (@MAIN_ITEM
           ,@NEW_ITEM
		   ,1
		   ,1
		   ,''
		   ,''
		   ,@USER
		   ,GETDATE()
		   ,@SUPP_CURRENTNO
		   ,@SUPP_CURRENTNO
		  
		   )

		   IF(@@ERROR >0)
		SET @RET_VAL =0
	ELSE
		SET @RET_VAL = 1
END

IF NOT EXISTS (SELECT * FROM TBL_SPR_REPLACEMENT WHERE REPLACE_ID_ITEM = @MAIN_ITEM AND REPLACE_SUPP_CURRENTNO = @SUPP_CURRENTNO )
BEGIN

	IF @PREV_ITEM <> ''
	INSERT INTO [TBL_SPR_REPLACEMENT]
           ([THIS_ID_ITEM]
           ,[REPLACE_ID_ITEM]
           ,[REPLACEMENTCODE]
           ,[REPLACEMENTQTY]
           ,[REPLACEMENT_MAIN]
           ,[DESCRIPTION]
           ,[CREATED_BY]
           ,[DT_CREATED]
           ,[THIS_SUPP_CURRENTNO]
           ,[REPLACE_SUPP_CURRENTNO]
           )
     VALUES
           (@PREV_ITEM
           ,@MAIN_ITEM
		   ,1
		   ,1
		   ,''
		   ,''
		   ,@USER
		   ,GETDATE()
		   ,@SUPP_CURRENTNO
		   ,@SUPP_CURRENTNO
		   
		   )
	
	IF(@@ERROR >0)
		SET @RET_VAL =0
	ELSE
		SET @RET_VAL = 2

END

IF EXISTS (SELECT * FROM TBL_SPR_REPLACEMENT WHERE THIS_ID_ITEM = @MAIN_ITEM AND THIS_SUPP_CURRENTNO = @SUPP_CURRENTNO ) 
BEGIN
UPDATE [TBL_SPR_REPLACEMENT]
   SET [REPLACE_ID_ITEM] = @NEW_ITEM
      ,[MODIFIED_BY] = @USER
      ,[DT_MODIFIED] = GETDATE()
      ,[THIS_SUPP_CURRENTNO] = @SUPP_CURRENTNO
      ,[REPLACE_SUPP_CURRENTNO] = @SUPP_CURRENTNO
      
	  WHERE THIS_ID_ITEM= @MAIN_ITEM AND THIS_SUPP_CURRENTNO = @SUPP_CURRENTNO
	  SET @RET_VAL = 3
END

IF EXISTS (SELECT * FROM TBL_SPR_REPLACEMENT WHERE REPLACE_ID_ITEM = @MAIN_ITEM AND REPLACE_SUPP_CURRENTNO = @SUPP_CURRENTNO ) 
BEGIN
UPDATE [TBL_SPR_REPLACEMENT]
   SET [THIS_ID_ITEM] = @PREV_ITEM
      ,[MODIFIED_BY] = @USER
      ,[DT_MODIFIED] = GETDATE()
      ,[THIS_SUPP_CURRENTNO] = @SUPP_CURRENTNO
      ,[REPLACE_SUPP_CURRENTNO] = @SUPP_CURRENTNO

	  WHERE REPLACE_ID_ITEM= @MAIN_ITEM AND REPLACE_SUPP_CURRENTNO = @SUPP_CURRENTNO 
	  SET @RET_VAL = 4

END
