IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='PK_MAS_SUPPLIER')
BEGIN
	ALTER TABLE [dbo].TBL_MAS_SUPPLIER DROP CONSTRAINT [PK_MAS_SUPPLIER]
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='PK_TBL_MAS_SUPPLIER')
BEGIN
	ALTER TABLE [dbo].[TBL_MAS_CONFIG_FUEL_IMPORT] DROP CONSTRAINT [FK_TBL_CONFIG_FUEL_IMPORT_TBL_MAS_SUPPLIER]
	ALTER TABLE [dbo].[TBL_MAS_VEH_MANAGE_CARD] DROP CONSTRAINT [FK_TBL_MAS_VEH_MANAGE_CARD_TBL_MAS_SUPPLIER]
	ALTER TABLE [dbo].[TBL_SPR_IRIMPORT_SCHEDULE] DROP CONSTRAINT [FK_TBL_MAS_IRIMPORT_SCHEDULE_TBL_MAS_SUPPLIER]
	ALTER TABLE [dbo].[TBL_SPR_SUPPLIER_REPLACEMENTCODE] DROP CONSTRAINT [FK_TBL_SPR_SUPPLIER_REPLACEMENTCODE_TBL_SPR_SUPPLIER]
	ALTER TABLE [dbo].[TBL_SPR_SUPPLIERCONFIG] DROP CONSTRAINT [FK_TBL_SUPPLIERCONFIG_TBL_MAS_SUPPLIER]
	ALTER TABLE [dbo].[TBL_SPR_SUPP_IMPORT] DROP CONSTRAINT [FK_TBL_SPR_SUPP_IMPORT_TBL_MAS_SUPPLIER]
	ALTER TABLE [dbo].[TBL_SPR_DISCOUNTMATRIXBUY] DROP CONSTRAINT [FK_TBL_DISCOUNTMATRIXBUY_TBL_MAS_SUPPLIER]
	ALTER TABLE [dbo].[TBL_MAS_SUPPLIER] DROP CONSTRAINT [PK_TBL_MAS_SUPPLIER]
END
IF NOT EXISTS (SELECT * FROM TBL_MAS_SUPPLIER WHERE SUPP_CURRENTNO = '50000')
BEGIN 
	INSERT [dbo].[TBL_MAS_SUPPLIER] ([SUP_Name], [SUP_Contact_Name], [SUP_Address1], [SUP_Address2], [SUP_Zipcode], [SUP_ID_Email], [SUP_Phone_Off], [SUP_Phone_Res], [SUP_FAX], [SUP_Phone_Mobile], [CREATED_BY], [DT_CREATED], [MODIFIED_BY], [DT_MODIFIED], [SUP_SSN], [SUP_REGION], [SUP_BILLAddress1], [SUP_BILLAddress2], [SUP_BILLZipcode], [LEADTIME], [ORDER_FREQ], [ID_ORDERTYPE], [CLIENT_NO], [WARRANTY], [DESCRIPTION], [ORDERDAY_MON], [ORDERDAY_TUE], [ORDERDAY_WED], [ORDERDAY_THU], [ORDERDAY_FRI], [SUPP_CURRENTNO], [SUP_CITY], [SUP_COUNTRY], [SUP_BILL_CITY], [SUP_BILL_COUNTRY], [FLG_SAME_ADDRESS], [SUP_WEBPAGE]) VALUES (N'STANDARD LEVERAND�R', N'UKJENT', N'UKJENT', N'0', N'', N'', N'', NULL, NULL, NULL, N'22admin', CAST(0x0000A70B00D1680A AS DateTime), N'22admin', CAST(0x0000A70B00D1680A AS DateTime), NULL, N'', N'', NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'50000', N'', N'', N'', N'', 0, N'Http://www.')
END
GO
ALTER TABLE [dbo].[TBL_MAS_SUPPLIER] ALTER COLUMN SUPP_CURRENTNO VARCHAR(50) NOT NULL

ALTER TABLE [dbo].[TBL_MAS_SUPPLIER] ADD CONSTRAINT [PK_TBL_MAS_SUPPLIER] PRIMARY KEY 
(
	[ID_SUPPLIER] ASC,
	[SUPP_CURRENTNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	
ALTER TABLE [dbo].[TBL_MAS_VEH_MANAGE_CARD] 
	ADD [SUPP_CURRENTNO] varchar(50) NULL,
	CONSTRAINT [FK_TBL_MAS_VEH_MANAGE_CARD_TBL_MAS_SUPPLIER] FOREIGN KEY([ID_SUPPLIER], [SUPP_CURRENTNO])
REFERENCES [dbo].[TBL_MAS_SUPPLIER] ([ID_SUPPLIER], [SUPP_CURRENTNO])
GO

ALTER TABLE [dbo].[TBL_MAS_VEH_MANAGE_CARD] CHECK CONSTRAINT [FK_TBL_MAS_VEH_MANAGE_CARD_TBL_MAS_SUPPLIER]
GO

ALTER TABLE [dbo].[TBL_SPR_IRIMPORT_SCHEDULE]  WITH CHECK 
	ADD [SUPP_CURRENTNO] varchar(50) NULL,
	CONSTRAINT [FK_TBL_MAS_IRIMPORT_SCHEDULE_TBL_MAS_SUPPLIER] FOREIGN KEY([ID_SUPPLIER], [SUPP_CURRENTNO])
REFERENCES [dbo].[TBL_MAS_SUPPLIER] ([ID_SUPPLIER], [SUPP_CURRENTNO])
GO

ALTER TABLE [dbo].[TBL_SPR_IRIMPORT_SCHEDULE] CHECK CONSTRAINT [FK_TBL_MAS_IRIMPORT_SCHEDULE_TBL_MAS_SUPPLIER]
GO

ALTER TABLE [dbo].[TBL_SPR_SUPPLIER_REPLACEMENTCODE]  WITH NOCHECK 
	ADD [SUPP_CURRENTNO] varchar(50) NULL,
	CONSTRAINT [FK_TBL_SPR_SUPPLIER_REPLACEMENTCODE_TBL_SPR_SUPPLIER] FOREIGN KEY([ID_SUPPLIER], [SUPP_CURRENTNO])
REFERENCES [dbo].[TBL_MAS_SUPPLIER] ([ID_SUPPLIER], [SUPP_CURRENTNO])
GO

ALTER TABLE [dbo].[TBL_SPR_SUPPLIER_REPLACEMENTCODE] CHECK CONSTRAINT [FK_TBL_SPR_SUPPLIER_REPLACEMENTCODE_TBL_SPR_SUPPLIER]
GO

ALTER TABLE [dbo].[TBL_SPR_SUPPLIERCONFIG]  WITH NOCHECK 
	ADD [SUPP_CURRENTNO] varchar(50) NULL,
	CONSTRAINT [FK_TBL_SUPPLIERCONFIG_TBL_MAS_SUPPLIER] FOREIGN KEY([ID_SUPPLIER], [SUPP_CURRENTNO])
REFERENCES [dbo].[TBL_MAS_SUPPLIER] ([ID_SUPPLIER], [SUPP_CURRENTNO])
GO

ALTER TABLE [dbo].[TBL_SPR_SUPPLIERCONFIG] CHECK CONSTRAINT [FK_TBL_SUPPLIERCONFIG_TBL_MAS_SUPPLIER]
GO

ALTER TABLE [dbo].[TBL_SPR_SUPP_IMPORT]  WITH CHECK 
	ADD [SUPP_CURRENTNO] varchar(50) NULL,
	CONSTRAINT [FK_TBL_SPR_SUPP_IMPORT_TBL_MAS_SUPPLIER] FOREIGN KEY([ID_SUPPLIER], [SUPP_CURRENTNO])
REFERENCES [dbo].[TBL_MAS_SUPPLIER] ([ID_SUPPLIER], [SUPP_CURRENTNO])
GO

ALTER TABLE [dbo].[TBL_SPR_SUPP_IMPORT] CHECK CONSTRAINT [FK_TBL_SPR_SUPP_IMPORT_TBL_MAS_SUPPLIER]
GO

ALTER TABLE [dbo].[TBL_SPR_DISCOUNTMATRIXBUY]  WITH NOCHECK 
	ADD [SUPP_CURRENTNO] varchar(50) NULL,
	CONSTRAINT [FK_TBL_DISCOUNTMATRIXBUY_TBL_MAS_SUPPLIER] FOREIGN KEY([ID_SUPPLIER], [SUPP_CURRENTNO])
REFERENCES [dbo].[TBL_MAS_SUPPLIER] ([ID_SUPPLIER], [SUPP_CURRENTNO])
GO

ALTER TABLE [dbo].[TBL_SPR_DISCOUNTMATRIXBUY] CHECK CONSTRAINT [FK_TBL_DISCOUNTMATRIXBUY_TBL_MAS_SUPPLIER]
GO
IF EXISTS (SELECT * FROM TBL_MAS_SUPPLIER WHERE SUPP_CURRENTNO = '50000')
BEGIN
	UPDATE [dbo].[TBL_MAS_ITEM_MASTER]
	SET ID_SUPPLIER_ITEM = (SELECT ID_SUPPLIER FROM TBL_MAS_SUPPLIER WHERE SUPP_CURRENTNO = '50000')
	WHERE ID_SUPPLIER_ITEM IS NULL
END
GO

DROP INDEX [IX_MAS_ID_SUPPLIER] ON [dbo].[TBL_MAS_ITEM_MASTER]
GO

ALTER TABLE [dbo].[TBL_MAS_ITEM_MASTER]	ALTER COLUMN ID_SUPPLIER_ITEM VARCHAR(50) NOT NULL
Go

CREATE NONCLUSTERED INDEX [IX_MAS_ID_SUPPLIER] ON [dbo].[TBL_MAS_ITEM_MASTER]
(
	[ID_SUPPLIER_ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TBL_MAS_ITEM_MASTER]  WITH CHECK 
	ADD CONSTRAINT [FK_TBL_MAS_ITEM_MASTER_TBL_MAS_SUPPLIER] FOREIGN KEY([ID_SUPPLIER_ITEM], [SUPP_CURRENTNO])
REFERENCES [dbo].[TBL_MAS_SUPPLIER] ([ID_SUPPLIER], [SUPP_CURRENTNO])

ALTER TABLE [dbo].[TBL_MAS_ITEM_MASTER] ADD [SUPP_CURRENTNO] varchar(50) NULL

IF EXISTS (SELECT * FROM TBL_MAS_SUPPLIER WHERE SUPP_CURRENTNO = '50000')
BEGIN
	UPDATE IM
	SET IM.SUPP_CURRENTNO = MS.SUPP_CURRENTNO
	FROM
	[DBO].[TBL_MAS_SUPPLIER] MS
	INNER JOIN [dbo].[TBL_MAS_ITEM_MASTER] IM
		ON IM.ID_SUPPLIER_ITEM = MS.ID_SUPPLIER
END

ALTER TABLE [dbo].[TBL_MAS_ITEM_MASTER]	ALTER COLUMN SUPP_CURRENTNO VARCHAR(50) NOT NULL
Go