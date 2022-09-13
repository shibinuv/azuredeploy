IF NOT EXISTS(SELECT ID_ITEM FROM TBL_MAS_ITEM_MASTER WHERE ID_ITEM = '8')
BEGIN
	Insert into TBL_MAS_ITEM_MASTER(
	ID_ITEM,
	ITEM_DESC,
	ITEM_DESC_NAME2,
	ID_UNIT_ITEM,
	ID_MAKE,
	ID_ITEM_MODEL,
	ID_ITEM_CATG,
	ID_SUPPLIER_ITEM,
	ITEM_AVAIL_QTY,
	ID_WH_ITEM,
	ITEM_REORDER_LEVEL,
	ITEM_DISC_CODE,
	ITEM_DISC_CODE_BUY,
	BASIC_PRICE,
	ITEM_PRICE,
	COST_PRICE1,
	NET_PRICE,
	LOCATION,
	PACKAGE_QTY,
	ID_VAT_CODE,
	ACCOUNT_CODE,
	FLG_ALLOW_BCKORD,
	FLG_CALC_PRICE,
	FLG_CNT_STOCK,
	FLG_DUTY,
	CREATED_BY,
	DT_CREATED,
	MODIFIED_BY,
	DT_MODIFIED,
	Class_Code,
	ID_SPCATEGORY,
	AVG_PRICE,
	QTY_NOT_DELIVERED,
	QTY_BO_SUPPLIER,
	LAST_BUY_PRICE,
	DT_LAST_BUY,
	MIN_STOCK,
	MAX_STOCK,
	FLG_BLOCK_AUTO_ORD,
	TD_CALC,
	FLG_STOCKITEM,
	VA_EXCHANGE_VEH,
	VA_ORDER_COST,
	FLG_STOCKITEM_STATUS,
	ENV_ID_ITEM,
	ENV_ID_MAKE,
	ENV_ID_WAREHOUSE,
	FLG_EFD,
	ALT_LOCATION,
	ANNOTATION,
	FLG_VAT_INCL,
	FLG_OBTAIN_SPARE,
	FLG_OBSOLETE_SPARE,
	FLG_AUTOADJUST_PRICE,
	FLG_LABELS,
	FLG_ALLOW_DISCOUNT,
	DISCOUNT,
	LAST_COST_PRICE,
	TEXT,
	FLG_AUTO_ARRIVAL,
	FLG_REPLACEMENT_PURCHASE,
	FLG_SAVE_TO_NONSTOCK,
	WEIGHT,
	SUPP_CURRENTNO,
	MAX_PURCHASE,
	MIN_PURCHASE,
	CONSUMPTION_ESTIMATED,
	SUBNR_ID_ITEM,
	SUBNR_SUPP_CURRENTNO,
	BARCODE_NUMBER,
	DEPOSITREFUND_ID_ITEM,
	DEPOSITREFUND_SUPP_CURRENTNO
	)values
	(
	'8',
	'DEFAULT VARE',
	NULL,
	0,
	50000,
	NULL,
	40,
	NULL,
	0,
	1,
	NULL,
	NULL,
	'',
	0,
	0,
	0,
	0,
	'',
	0,
	NULL,
	NULL,
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
	0,
	NULL,
	NULL,
	NULL,
	NULL,
	0,
	NULL,
	1,
	0,
	1,
	NULL,
	NULL,
	NULL,
	'',
	'',
	NULL,
	1,
	'',
	'',
	0,
	0,
	0,
	0,
	0,
	0,
	NULL,
	NULL,
	NULL,
	0,
	0,
	1,
	'',
	50000,
	0,
	0,
	0,
	NULL,
	NULL,
	'',
	'',
	NULL)
END












