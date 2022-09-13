Declare @menID int
Declare @modulID int


/* For adding New Parent Menu */
IF NOT EXISTS ( SELECT * FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_SCR='Accounting' and NAME_MODULE ='LA ACCOUNTING'  ) 
BEGIN
	INSERT INTO TBL_UTIL_MOD_DETAILS(NAME_SCR,NAME_URL,NAME_MODULE,Module_level,Flg) 
	VALUES('Accounting','','LA ACCOUNTING',NULL,1)

	SET @menID = @@IDENTITY
END

/* For adding language to New Parent Menu */
IF NOT EXISTS(SELECT LANG_DESCRIPTION FROM TBL_UTIL_LANG_DETAILS WHERE ID_SCR = @menID)
BEGIN
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menID,'Accounting')
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menID,'Accounting')
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menID,'Regnskap')

END

/* For adding New Child Menu */
IF NOT EXISTS(SELECT NAME_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR ='Account Export' and  NAME_MODULE = 'LA ACCOUNTING')
BEGIN
    Declare @menuID int
    Declare @moduleID int
    SELECT @moduleID = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Accounting' AND NAME_MODULE='LA ACCOUNTING'
               
    INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('Account Export','/Transactions/frmLAExport.aspx','LA ACCOUNTING',@moduleID,1)
    SET @menuID = @@IDENTITY
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID,'Account Export')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID,'Overfør journal')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID,'Kontoexport')
END

/* For adding New Child Menu */
IF NOT EXISTS(SELECT NAME_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR ='Invoice Export' and  NAME_MODULE = 'LA ACCOUNTING')
BEGIN
    Declare @menuID2 int
    Declare @moduleID2 int
    SELECT @moduleID2 = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Accounting' AND NAME_MODULE='LA ACCOUNTING'
               
    INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('Invoice Export','/Transactions/frmLAInvExport.aspx','LA ACCOUNTING',@moduleID2,1)
    SET @menuID2 = @@IDENTITY
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID2,'Invoice Export')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID2,'Overførte fakturaer')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID2,'Rechnungsexport')
END

/* For adding New Child Menu */
IF NOT EXISTS(SELECT NAME_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR ='Code List' and  NAME_MODULE = 'LA ACCOUNTING')
BEGIN
    Declare @menuID3 int
    Declare @moduleID3 int
    SELECT @moduleID3 = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Accounting' AND NAME_MODULE='LA ACCOUNTING'
               
    INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('Code List','/Transactions/frmLACodeList.aspx','LA ACCOUNTING',@moduleID3,1)
    SET @menuID3 = @@IDENTITY
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID3,'Code List')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID3,'Kontoplan')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID3,'Kontenplan')
END

/* For adding New Child Menu */
IF NOT EXISTS(SELECT NAME_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR ='LA Matrix' and  NAME_MODULE = 'LA ACCOUNTING')
BEGIN
    Declare @menuID4 int
    Declare @moduleID4 int
    SELECT @moduleID4 = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Accounting' AND NAME_MODULE='LA ACCOUNTING'
               
    INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('LA Matrix','/Transactions/frmLAMatrix.aspx','LA ACCOUNTING',@moduleID4,1)
    SET @menuID4 = @@IDENTITY
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID4,'LA Matrix')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID4,'Ny konto')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID4,'Neues Konto')
END

/* For adding New Child Menu */
IF NOT EXISTS(SELECT NAME_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR ='LA Import' and  NAME_MODULE = 'LA ACCOUNTING')
BEGIN
    Declare @menuID5 int
    Declare @moduleID5 int
    SELECT @moduleID5 = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Accounting' AND NAME_MODULE='LA ACCOUNTING'
               
    INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('LA Import','/Transactions/frmLAImport.aspx','LA ACCOUNTING',@moduleID5,1)
    SET @menuID5 = @@IDENTITY
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID5,'LA Import')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID5,'Kundeimport')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID5,'Kundenimport')
END


/* For adding New Child Menu */
IF NOT EXISTS(SELECT NAME_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR ='LA Settings' and  NAME_MODULE = 'LA ACCOUNTING')
BEGIN
    Declare @menuID6 int
    Declare @moduleID6 int
    SELECT @moduleID6 = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Accounting' AND NAME_MODULE='LA ACCOUNTING'
               
    INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('LA Settings','/Master/frmcfimporttemplate.aspx','LA ACCOUNTING',@moduleID6,1)
    SET @menuID6 = @@IDENTITY
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID6,'LA Settings')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID6,'Innstillinger')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID6,'Einstellungen')


	----LA Setttings Child----------------------------------------------------------------------

	 -- 1st Sub Child
	Declare @menuID7 int
    Declare @moduleID7 int
	SELECT @moduleID7 = @menuID6
	
	INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('Import Template','/Master/frmcfimporttemplate.aspx','LA ACCOUNTING',@moduleID7,1)
	SET @menuID7 = @@IDENTITY
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID7,'Import Template')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID7,'Oppsett kundeimport')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID7,'Kundenimport einrichten') 

	--2nd Sub Child
	Declare @menuID8 int
    Declare @moduleID8 int
	SELECT  @moduleID8 = @menuID6
	
	INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('Accounting File','/Master/frmCfLA.aspx','LA ACCOUNTING',@moduleID8,1)
	SET @menuID8 = @@IDENTITY
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID8,'Accounting File')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID8,'Oppsett regnskapsfil')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID8,'Buchhaltungsdatei einrichten') 

	--3rd Sub Child		
	Declare @menuID9 int
    Declare @moduleID9 int
	SELECT  @moduleID9 = @menuID6
	
	INSERT INTO TBL_UTIL_MOD_DETAILS VALUES('Export Template','/Master/frmcfexporttemplate.aspx','LA ACCOUNTING',@moduleID9,1)
	SET @menuID9 = @@IDENTITY
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID9,'Export Template')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID9,'Overføringsmaler')
    INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID9,'Buchhaltungsdatei einrichten') 


END





GO
