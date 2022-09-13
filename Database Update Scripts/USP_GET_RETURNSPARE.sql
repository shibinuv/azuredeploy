/****** Object:  StoredProcedure [dbo].[USP_GET_RETURNSPARE]    Script Date: 11-03-2022 15:25:35 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_GET_RETURNSPARE]
GO
/****** Object:  StoredProcedure [dbo].[USP_GET_RETURNSPARE]    Script Date: 11-03-2022 15:25:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Praveen
-- Create date: <Create Date,,>
-- Description:	To fetch the returned sparepart details using returnno 
-- =============================================
CREATE PROCEDURE [dbo].[USP_GET_RETURNSPARE]
 @IV_RETURN_NO AS INT,
 @IV_USERID VARCHAR(50)	
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM TBL_MAS_ITEM_DETAILS_RETURN WHERE ID_RETURN_NUM = @IV_RETURN_NO)
	BEGIN		
		DECLARE @SUPPLIER_NAME AS VARCHAR(100)
		DECLARE @SUPPLIER_CURR_NO AS VARCHAR(20)

		SELECT @SUPPLIER_CURR_NO=SUPPLIER_NO FROM TBL_MAS_ITEM_DETAILS_RETURN WHERE ID_RETURN_NUM = @IV_RETURN_NO

		SELECT @SUPPLIER_NAME=SUP_Name FROM TBL_MAS_SUPPLIER WHERE SUPP_CURRENTNO = @SUPPLIER_CURR_NO

		SELECT IDR.ID_ITEM_DETAILS_RETURN,
		IDR.ID_RETURN_NUM,
		IDR.ID_ITEM,
		IDR.ITEM_DESC,
		IDR.QTY_RETURNED,
		IDR.SALE_PRICE,
		IDR.COST_PRICE,
		IDR.RETURN_CODE,
		IDR.SUPPLIER_NO,
		(IDR.ID_WO_PREFIX + IDR.ID_WO_NO) AS WONUM,
		IHR.DT_RETURNED AS DT_RETURNED,
		IHR.DT_CREATED AS DT_CREATED,
		IHR.DT_CREDITED AS DT_CREDITED,
		IHR.RETURN_STATUS AS RETURN_STATUS,
		IHR.ANNOTATION AS ANNOTATION,
		@SUPPLIER_NAME AS SUPPLIER_NAME,
		IDR.DT_CREATED AS DT_CREATED_DTL
		FROM TBL_MAS_ITEM_DETAILS_RETURN IDR INNER JOIN  TBL_MAS_ITEM_HEADER_RETURN IHR 
		ON IDR.ID_RETURN_NUM=IHR.ID_RETURN_NUM 
		WHERE IDR.ID_RETURN_NUM = @IV_RETURN_NO
	END

END
GO
