/****** Object:  StoredProcedure [dbo].[USP_RPT_RETURN_SPARE_DETAILS]    Script Date: 11-03-2022 15:26:49 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_RPT_RETURN_SPARE_DETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_RPT_RETURN_SPARE_DETAILS]    Script Date: 11-03-2022 15:26:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Praveen
-- Create date: <Create Date,,>
-- Description:	To display the detail info of Return Spare Report
-- =============================================
CREATE PROCEDURE [dbo].[USP_RPT_RETURN_SPARE_DETAILS] 
@IV_RETURN_NO VARCHAR(50),
@IV_USERID VARCHAR(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT ID_ITEM_DETAILS_RETURN,ID_RETURN_NUM,ID_ITEM,ITEM_DESC,QTY_RETURNED,SALE_PRICE,COST_PRICE,SUPPLIER_NO,ID_WO_PREFIX,ID_WO_NO,RETURN_CODE
	FROM TBL_MAS_ITEM_DETAILS_RETURN
	WHERE 
	ID_RETURN_NUM = @IV_RETURN_NO

END
GO
