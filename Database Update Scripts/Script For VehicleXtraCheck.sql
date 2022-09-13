
/* For adding New Parent Menu */
IF NOT EXISTS ( SELECT * FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_SCR='Vehicle XtraCheck' and NAME_MODULE ='VEHICLE'  ) 
BEGIN
	
	Declare @menuID int
    Declare @moduleID int
    SELECT @moduleID = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Vehicle' AND NAME_MODULE='VEHICLE' AND Module_level IS NULL


	INSERT INTO TBL_UTIL_MOD_DETAILS(NAME_SCR,NAME_URL,NAME_MODULE,Module_level,Flg) 
	VALUES('Vehicle XtraCheck','/Transactions/frmXtraCheck.aspx','VEHICLE',@moduleID,1)  

	SET @menuID = @@IDENTITY
END

/* For adding language to New Parent Menu */
IF NOT EXISTS(SELECT LANG_DESCRIPTION FROM TBL_UTIL_LANG_DETAILS WHERE ID_SCR = @menuID)
BEGIN
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(1,@menuID,'Vehicle XtraCheck')
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(2,@menuID,'Xtrash-Check-Auswahl')
	INSERT INTO TBL_UTIL_LANG_DETAILS VALUES(3,@menuID,'Xtrasjekk utvalg')

END

