/****** Object:  StoredProcedure [dbo].[USP_MODIFY_PO_DETAILS]    Script Date: 11-02-2022 19:56:00 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_MODIFY_PO_DETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_MODIFY_PO_DETAILS]    Script Date: 11-02-2022 19:56:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Anuj Dahal
-- Create date: 10-02-222
-- Description:	To Update the TBL_SPR_PO_ITEM
-- =============================================
CREATE PROCEDURE  [dbo].[USP_MODIFY_PO_DETAILS]
	@USER VARCHAR(50),
	@PONUMBER VARCHAR(50),
	@API_ORDER_NO VARCHAR(50),
	@OV_RETVALUE VARCHAR(20) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT * FROM TBL_SPR_PO_HEADER WHERE NUMBER=@PONUMBER)
	BEGIN
		IF(@API_ORDER_NO <> '' OR @API_ORDER_NO <> NULL)
		BEGIN
			UPDATE TBL_SPR_PO_HEADER SET 
			API_ORDER_NO=@API_ORDER_NO,
			STATUS=1,
			MODIFIED_BY=@USER,
			DT_MODIFIED=GETDATE()
			WHERE NUMBER=@PONUMBER

			SET @OV_RETVALUE= 'UPDFLG'
		END
	END
	ELSE
	SET @OV_RETVALUE= 'FAIL'
END
GO
