USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_INSERT_SUPPNO]    Script Date: 25.05.2020 22:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[USP_SPR_ITEM_CAMPAIGNPRICE_INSERT]
(
	@SUPP_CURRENTNO VARCHAR(100),
	@ID_ITEM VARCHAR(100),
	@START_DATE INT,
	@END_DATE INT,
	@CAMPAIGN_PRICE DECIMAL(18,0),
	@CREATED_BY VARCHAR(100)
)
AS
BEGIN
     
	   INSERT INTO TBL_SPR_ITEM_CAMPAIGNPRICE(
				SUPP_CURRENTNO,
				ID_ITEM,
				START_DATE,
				END_DATE,
				CAMPAIGN_PRICE,
				CREATED_BY,
				DT_CREATED)

		VALUES(
		@SUPP_CURRENTNO,
				@ID_ITEM,
				@START_DATE,
				@END_DATE,
				@CAMPAIGN_PRICE,
				@CREATED_BY,
				GETDATE())
	
	
	

END
