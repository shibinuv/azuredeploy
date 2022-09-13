/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_USER_DETAILS]    Script Date: 27-04-2021 12:41:49 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_FETCH_MECHANIC_USER_DETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_MECHANIC_USER_DETAILS]    Script Date: 27-04-2021 12:41:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_FETCH_MECHANIC_USER_DETAILS]
@term varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

     SELECT ID_Login,First_Name,Last_Name FROM TBL_MAS_USERS 
	 WHERE Flg_Mechanic=1  AND 
	 (First_Name like '%'+ @term +'%' OR
	 Last_Name like '%'+ @term +'%' OR
	 ID_Login like '%'+ @term +'%')

END
GO
