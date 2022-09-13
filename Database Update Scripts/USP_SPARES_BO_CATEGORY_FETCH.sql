/****** Object:  StoredProcedure [dbo].[USP_SPARES_BO_CATEGORY_FETCH]    Script Date: 20-10-2021 16:23:45 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPARES_BO_CATEGORY_FETCH]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPARES_BO_CATEGORY_FETCH]    Script Date: 20-10-2021 16:23:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_SPARES_BO_CATEGORY_FETCH]
	@Supp_CurrNo VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN
		
		SELECT distinct
			CATG.ID_ITEM_CATG,
			CATG.CATG_DESC AS CATEGORY
		FROM
			TBL_MAS_ITEM_CATG  CATG
		WHERE
			CATG.SUPP_CURRENTNO = @Supp_CurrNo
			ORDER BY CATG.CATG_DESC
		
	END
	



END
GO
