/****** Object:  StoredProcedure [dbo].[USP_SPR_FETCH_SUPPLIER_SETTINGS]    Script Date: 03-11-2021 11:54:08 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_FETCH_SUPPLIER_SETTINGS]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_FETCH_SUPPLIER_SETTINGS]    Script Date: 03-11-2021 11:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Author:  Vijayalaxmi baruah  
-- Create date: 03-Jan-2008 
-- Description: This procedure is used to obtain all the suppliers  
				--for which the import settings have been configured
-- =============================================  
CREATE PROCEDURE [dbo].[USP_SPR_FETCH_SUPPLIER_SETTINGS] (
	@SUPPID INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT START_NUM,END_NUM,FIELD_NAME,FILEMODE,ORDER_OF_FILE,DELIMITER,REMOVE_BLANK_FIELD,REMOVE_START_ZERO,DIVIDE_PRICE_BY_HUNDRED,PRICE_FILE_DEC_SEP
	FROM TBL_SPR_SUPP_IMPORT  
	WHERE ID_SUPPLIER=@SUPPID
	AND FLG_DELETE='False'
	
END
GO
