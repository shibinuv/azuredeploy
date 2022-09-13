/****** Object:  StoredProcedure [dbo].[USP_SEARCH_RETURN_SPARES]    Script Date: 11-03-2022 15:24:05 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SEARCH_RETURN_SPARES]
GO
/****** Object:  StoredProcedure [dbo].[USP_SEARCH_RETURN_SPARES]    Script Date: 11-03-2022 15:24:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Praveen
-- Create date: <Create Date,,>
-- Description:	To load all the returned spares and also search for the returned spares using returnno , sparepart name
-- =============================================
CREATE PROCEDURE [dbo].[USP_SEARCH_RETURN_SPARES]
 @ID_SEARCH AS VARCHAR(50)='',
 @IV_USERID VARCHAR(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 
	 -- IF THERE IS NO @ID_SEARCH THEN RETURN ALL RECORDS 

	 IF (@ID_SEARCH ='')
	 BEGIN
		SELECT DISTINCT IH.ID_RETURN_NUM , ID.SUPPLIER_NO , IH.DT_RETURNED , IH.DT_CREDITED , (IH.ID_WO_PREFIX+IH.ID_WO_NO ) AS WONUM,IH.RETURN_STATUS
		FROM TBL_MAS_ITEM_HEADER_RETURN IH
		INNER JOIN TBL_MAS_ITEM_DETAILS_RETURN ID ON ID.ID_RETURN_NUM = ID.ID_RETURN_NUM WHERE ID.ID_RETURN_NUM = IH.ID_RETURN_NUM
	 END
	 ELSE
	 BEGIN
		SELECT DISTINCT IH.ID_RETURN_NUM , ID.SUPPLIER_NO , IH.DT_RETURNED , IH.DT_CREDITED , (IH.ID_WO_PREFIX+IH.ID_WO_NO ) AS WONUM,RETURN_STATUS
		FROM TBL_MAS_ITEM_HEADER_RETURN IH
		INNER JOIN TBL_MAS_ITEM_DETAILS_RETURN ID ON ID.ID_RETURN_NUM = ID.ID_RETURN_NUM 
		WHERE (IH.ID_WO_PREFIX+IH.ID_WO_NO)  LIKE '%'+@ID_SEARCH+'%' 
		OR ID.ID_ITEM LIKE '%'+@ID_SEARCH+'%' AND ID.ID_RETURN_NUM = IH.ID_RETURN_NUM

	 END
END
GO
