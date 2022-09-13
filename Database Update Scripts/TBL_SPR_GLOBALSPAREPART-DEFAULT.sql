IF NOT EXISTS(SELECT ID_ITEM FROM TBL_SPR_GLOBALSPAREPART WHERE ID_ITEM = '8')
BEGIN
	INSERT INTO TBL_SPR_GLOBALSPAREPART(
	ID_ITEM,
	ITEM_DESC_NAME2,
	ID_UNIT_ITEM,
	ITEM_DESC,
	ID_MAKE,
	ID_ITEM_MODEL,
	ID_ITEM_CATG,
	ITEM_REORDER_LEVEL,
	ITEM_DISC_CODE,
	ITEM_DISC_CODE_BUY,
	BASIC_PRICE,
	ITEM_PRICE,
	COST_PRICE1,
	NET_PRICE,
	PACKAGE_QTY,
	ID_VAT_CODE,
	ACCOUNT_CODE,
	FLG_CALC_PRICE,
	FLG_DUTY,
	CREATED_BY,
	DT_CREATED,
	MODIFIED_BY,
	DT_MODIFIED,
	ID_CURRENCY,
	ID_SPCATEGORY,
	SUPP_CURRENTNO,
	BARCODE_NUMBER
	)
	VALUES
	(
	'8',
	NULL,
	0,
	'DEFAULT VARE',
	50000,
	NULL,
	40,
	NULL,
	NULL,
	'',
	0,
	0,
	0,
	0,
	0,
	NULL,
	NULL,
	NULL,
	NULL,
	'22admin',
	GETDATE(),
	'22admin',
	GETDATE(),
	NULL,
	NULL,
	50000,
	NULL
	)
END