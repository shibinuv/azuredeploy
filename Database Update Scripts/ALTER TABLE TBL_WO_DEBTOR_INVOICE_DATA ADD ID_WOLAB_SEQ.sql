IF NOT EXISTS(SELECT * FROM syscolumns WHERE id=object_id('TBL_WO_DEBTOR_INVOICE_DATA') AND name='ID_WOLAB_SEQ')
BEGIN 
ALTER TABLE TBL_WO_DEBTOR_INVOICE_DATA 
ADD ID_WOLAB_SEQ INT
END