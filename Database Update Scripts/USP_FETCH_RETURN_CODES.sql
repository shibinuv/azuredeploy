/****** Object:  StoredProcedure [dbo].[USP_FETCH_RETURN_CODES]    Script Date: 11-03-2022 15:33:31 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_RETURN_CODES]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_RETURN_CODES]    Script Date: 11-03-2022 15:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Praveen
-- Create date: <Create Date,,>
-- Description:	To fetch the Return Codes based on the Search parameter
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_RETURN_CODES]
@IV_SEARCH VARCHAR(50)=''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @IV_SEARCH =''
	BEGIN
		SELECT * FROM TBL_SPARES_RETURN_CODES
	END
	ELSE
	BEGIN
		SELECT * FROM TBL_SPARES_RETURN_CODES WHERE RETURN_CODE LIKE '%' + @IV_SEARCH + '%'
	END
END
GO
