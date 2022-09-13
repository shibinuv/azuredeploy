Imports System.Web.Services
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS
Imports System.Web.Security
Imports System.Web.UI
Imports Encryption
Imports DevExpress.Web
Imports System.Xml
Imports System.Globalization
Imports System.Threading
Public Class frmCfUserdetail
    Inherits System.Web.UI.Page
    Shared dtUserDetails As New DataTable()
    Shared dsUserDetails As New DataSet
    Shared objConfigUserBO As New CARS.CoreLibrary.ConfigUsersBO
    Shared objConfigUserDO As New ConfigUsers.ConfigUsersDO
    Shared objConfigSubBO As New ConfigSubsidiaryBO
    Shared objConfigSubDO As New Subsidiary.ConfigSubsidiaryDO
    Shared objConfigDeptBO As New ConfigDepartmentBO
    Shared commonUtil As New Utilities.CommonUtility
    Shared loginName As String
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of ConfigUsersBO)()
    Shared objUserService As New CARS.CoreLibrary.CARS.Services.ConfigUsers.Users
    Shared objRoleService As New CARS.CoreLibrary.CARS.Services.ConfigRole.Role
    Shared objConfigRoleBO As New CARS.CoreLibrary.ConfigRoleBO
    Shared objZipCodeBO As New ZipCodesBO
    Shared objZipCodeDO As New ZipCodes.ZipCodesDO
    Shared objEncryption As New Encryption64
    Shared dtCaption As DataTable
    Shared objConfigDeptDO As New CoreLibrary.CARS.Department.ConfigDepartmentDO
    Shared objConfigRoleDO As New CoreLibrary.CARS.Role.ConfigRoleDO
    Shared objConfigRoleServ As New Services.ConfigRole.Role
    Shared id_role_acc As Integer
    Shared StrIntXMLs As String = String.Empty
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If

            LoadUserDetails()
            If Not IsCallback Then
                FillDefaultValues()
                LoadSubsidiaryUser()
                LoadDepartmentUser(0)
                LoadEmailAccnt(0)
                LoadRole(0, 0)
            End If

            'Roles
            Session("Select") = GetLocalResourceObject("genSelect")
            Dim subsideryId = Session("UserSubsidiary")
            Dim departmentId = Session("UserDept")

            If Not HttpContext.Current.Session("dtPermission") Is Nothing Then
                gvPermissions.DataSource = HttpContext.Current.Session("dtPermission")
                gvPermissions.DataBind()
            End If

            If Not HttpContext.Current.Session("dtPerCtrl") Is Nothing Then
                gvCtrlPermissions.DataSource = HttpContext.Current.Session("dtPerCtrl")
                gvCtrlPermissions.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Sub FillDefaultValues()
        Try
            Dim dsLang As New DataSet
            dsLang = commonUtil.Fetch_Config()
            If dsLang.Tables.Count > 0 Then
                'Lang dd
                If dsLang.Tables(3).Rows.Count > 0 Then
                    cmbLang.Items.Clear()
                    Dim dvLanguage As DataView
                    dvLanguage = dsLang.Tables(3).DefaultView
                    dvLanguage.Sort = "LANG_NAME"
                    cmbLang.DataSource = dvLanguage
                    cmbLang.TextField = "LANG_NAME"
                    cmbLang.ValueField = "ID_LANG"
                    cmbLang.DataBind()
                    cmbLang.Items.Insert(0, New DevExpress.Web.ListEditItem(Session("Select"), 0))
                    cmbLang.SelectedIndex = 0
                Else
                    cmbLang.Items.Insert(0, New DevExpress.Web.ListEditItem(Session("Select"), 0))
                End If
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "FillDefaultValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub cbUserDetGrid_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            LoadUserDetails()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "cbUserDetGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Private Sub LoadUserDetails()
        Try
            objConfigUserBO.Id_Login = loginName
            gvUserDetails.DataSource = objConfigUserDO.Fetch_Users(objConfigUserBO)
            gvUserDetails.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadUserDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub cbUserDetailsPopup_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim param As String = e.Parameter
            Dim params() As String = param.Split(";")
            Dim objConfigUserBoDet As New ConfigUsersBO
            cbUserDetailsPopup.JSProperties("cpIsFetch") = False
            cbUserDetailsPopup.JSProperties("cpIsSave") = False
            cbUserDetailsPopup.JSProperties("cpNewRoleID") = ""
            If params.Count > 1 Then
                If params(0) = "FETCH" Then
                    Dim loginId As String = params(1)
                    objConfigUserBO.Id_Login = loginId
                    details = objUserService.FetchUser(objConfigUserBO)
                    If details.Count > 0 Then
                        cbUserDetailsPopup.JSProperties("cpIsFetch") = True
                        LoadSubsidiaryUser()
                        FillDefaultValues()
                        objConfigUserBoDet = details(0)
                        tbLoginName.Text = objConfigUserBoDet.Id_Login
                        tbFName.Text = objConfigUserBoDet.First_Name
                        tbLName.Text = objConfigUserBoDet.Last_Name
                        tbAddrLine1.Text = objConfigUserBoDet.Address1
                        tbAddrLine2.Text = objConfigUserBoDet.Address2
                        'tbPassword.Text = objConfigUserBoDet.Password
                        cbUserDetailsPopup.JSProperties("cpPassword") = objConfigUserBoDet.Password
                        tbMobile.Text = objConfigUserBoDet.Mobileno
                        tbFaxNo.Text = objConfigUserBoDet.FaxNo
                        cmbEAccnt.Value = objConfigUserBoDet.Id_Email
                        tbCommonMechId.Text = objConfigUserBoDet.Common_Mechanic_Id
                        tbCountry.Text = objConfigUserBoDet.Id_Country
                        tbCity.Text = objConfigUserBoDet.Id_City
                        'tbConfirm.Text = objConfigUserBoDet.Confirm_Password
                        cbUserDetailsPopup.JSProperties("cpCnfPassword") = objConfigUserBoDet.Confirm_Password
                        tbSSN.Text = objConfigUserBoDet.Social_Security_Num
                        tbWorkHrsFrm.Text = objConfigUserBoDet.Workhrs_Frm
                        tbWorkHrsTo.Text = objConfigUserBoDet.Workhrs_To
                        tbTelNoPersonal.Text = objConfigUserBoDet.Phone
                        tbUserId.Text = objConfigUserBoDet.Userid
                        tbZipCode.Text = objConfigUserBoDet.Id_Zip_Users
                        tbEmail.Text = objConfigUserBoDet.Id_Email
                        tbState.Text = objConfigUserBoDet.Id_State
                        If objConfigUserBoDet.Id_Subsidery_User = 0 Or objConfigUserBoDet.Id_Subsidery_User = "" Then
                            cmbSubsidiary.SelectedIndex = 0
                        Else
                            cmbSubsidiary.Value = objConfigUserBoDet.Id_Subsidery_User
                            LoadDepartmentUser(objConfigUserBoDet.Id_Subsidery_User)
                            LoadEmailAccnt(objConfigUserBoDet.Id_Subsidery_User)
                            LoadRole(objConfigUserBoDet.Id_Subsidery_User, objConfigUserBoDet.Id_Dept)
                        End If

                        If objConfigUserBoDet.Id_Lang = 0 Then
                            cmbLang.SelectedIndex = 0
                        Else
                            cmbLang.Value = objConfigUserBoDet.Id_Lang.ToString
                        End If

                        If objConfigUserBoDet.Id_Dept = 0 Or objConfigUserBoDet.Id_Dept = "" Then
                            cmbDepartment.SelectedIndex = 0
                        Else
                            cmbDepartment.Value = objConfigUserBoDet.Id_Dept
                        End If

                        If objConfigUserBoDet.Id_Email_Acct = 0 Then
                            cmbEAccnt.SelectedIndex = 0
                        Else
                            cmbEAccnt.Value = objConfigUserBoDet.Id_Email_Acct.ToString
                        End If

                        If objConfigUserBoDet.Id_Role_User = 0 Or objConfigUserBoDet.Id_Role_User = "" Then
                            cmbRole.SelectedIndex = 0
                        Else
                            cmbRole.Value = objConfigUserBoDet.Id_Role_User
                        End If

                        If Not objConfigUserBoDet.Flg_Mechanic Then
                            chkMech.Checked = False
                            chkMechActive.Enabled = False
                            'rblAutoCorr.Enabled = False
                        Else
                            chkMech.Checked = True
                            chkMechActive.Enabled = True
                            'rblAutoCorr.Enabled = True
                        End If

                        If Not objConfigUserBoDet.Flg_Duser Then
                            chkDuser.Checked = False
                        Else
                            chkDuser.Checked = True
                        End If
                        If Not objConfigUserBoDet.Flg_Use_Idletime Then
                            Dim AutoCorrectNo As DevExpress.Web.ListEditItem = rblAutoCorr.Items.FindByValue("0")
                            AutoCorrectNo.Selected = True
                        Else
                            Dim AutoCorrectYes As DevExpress.Web.ListEditItem = rblAutoCorr.Items.FindByValue("1")
                            AutoCorrectYes.Selected = True
                        End If
                        If objConfigUserBoDet.Flg_Workhrs Then
                            chkWrkHrs.Checked = True
                        Else
                            chkWrkHrs.Checked = False
                        End If
                        cmbSubsidiary.Focus()
                    End If
                ElseIf params(0) = "LOADDEPT" Then
                    FillDefaultValues()
                    LoadSubsidiaryUser()
                    Dim subId As String = params(1).ToString
                    LoadDepartmentUser(subId)
                    LoadEmailAccnt(subId)
                    LoadRole(subId, 0)
                    cmbDepartment.SelectedIndex = 0
                    cmbRole.SelectedIndex = 0
                    cmbEAccnt.SelectedIndex = 0
                ElseIf params(0) = "LOADROLE" Then
                    FillDefaultValues()
                    LoadSubsidiaryUser()
                    Dim subId As String = params(1).ToString
                    Dim deptId As String = params(2).ToString
                    LoadDepartmentUser(subId)
                    LoadEmailAccnt(subId)
                    LoadRole(subId, deptId)
                    cmbRole.SelectedIndex = 0
                End If
            Else
                If params(0) = "RESET" Then
                    ClearControls()
                ElseIf params(0) = "SAVE" Then
                    Dim strResult As String = ""
                    Dim dsReturnValStr As String = ""
                    Dim password As String = ""
                    Dim confPasswd As String = ""
                    cbUserDetailsPopup.JSProperties("cpIsSave") = True
                    Dim strResults As String() = {}
                    Dim idRole As Integer = 0
                    'Save Role first 
                    If hdnMode.Value = "Add" Then
                        Dim objConfigRoleBO As New ConfigRoleBO
                        objConfigRoleBO.Id_Role = "0"
                        objConfigRoleBO.Nm_Role = tbUserId.Text + "_admin"
                        objConfigRoleBO.Id_Subsidery_Role = IIf(cmbSubsidiary.Value = "0", "0", cmbSubsidiary.Value)
                        objConfigRoleBO.Id_Dept_Role = IIf(cmbDepartment.Value = "0", "0", cmbDepartment.Value)
                        'objConfigRoleBO.Id_Scr_Start_Role = 248 'Currently is hardcoded need to check
                        objConfigRoleBO.Id_Scr_Start_Role = GetDefaultStartScreenId()
                        objConfigRoleBO.Flg_Sysadmin = False
                        objConfigRoleBO.Flg_Subsidadmin = False
                        objConfigRoleBO.Flg_Deptadmin = True
                        objConfigRoleBO.Created_By = loginName
                        objConfigRoleBO.FlgNbkSett = False
                        objConfigRoleBO.FlgAccounting = False
                        objConfigRoleBO.FlgSPOrder = False
                        strResults = objConfigRoleServ.AddNewRole(objConfigRoleBO)
                        If strResults.Count > 1 Then
                            If strResults(0) = "OK" Then
                                idRole = strResults(1)
                                cbUserDetailsPopup.JSProperties("cpNewRoleID") = idRole.ToString()
                            End If
                        End If
                    ElseIf hdnMode.Value = "Edit" Then
                        idRole = cmbRole.Value
                    End If

                    password = objEncryption.Encrypt(tbPassword.Text, ConfigurationManager.AppSettings.Get("encKey"))
                    confPasswd = objEncryption.Encrypt(tbConfirm.Text, ConfigurationManager.AppSettings.Get("encKey"))

                    objConfigUserBO.Id_Subsidery_User = IIf(cmbSubsidiary.Value = "0", "0", cmbSubsidiary.Value)
                    objConfigUserBO.Id_Dept = IIf(cmbDepartment.Value = "0", "0", cmbDepartment.Value)
                    'objConfigUserBO.Id_Role_User = cmbRole.Value
                    objConfigUserBO.Id_Role_User = idRole
                    objConfigUserBO.Flg_Mechanic = chkMech.Checked
                    objConfigUserBO.Flg_Mech_Isactive = chkMechActive.Checked
                    objConfigUserBO.Id_Login = tbLoginName.Text
                    objConfigUserBO.Userid = tbUserId.Text
                    objConfigUserBO.First_Name = tbFName.Text
                    objConfigUserBO.Last_Name = tbLName.Text
                    objConfigUserBO.Password = password
                    objConfigUserBO.Confirm_Password = confPasswd
                    objConfigUserBO.Id_Lang = IIf(cmbLang.Value = "0", Nothing, cmbLang.Value)
                    objConfigUserBO.Phone = tbTelNoPersonal.Text
                    objConfigUserBO.Mobileno = tbMobile.Text
                    objConfigUserBO.Address1 = tbAddrLine1.Text
                    objConfigUserBO.Address2 = tbAddrLine2.Text
                    objConfigUserBO.Id_Zip_Users = tbZipCode.Text
                    objConfigUserBO.Workhrs_Frm = tbWorkHrsFrm.Text
                    objConfigUserBO.Workhrs_To = tbWorkHrsTo.Text
                    objConfigUserBO.Social_Security_Num = tbSSN.Text
                    objConfigUserBO.Flg_Workhrs = chkWrkHrs.Checked
                    objConfigUserBO.Flg_Duser = chkDuser.Checked
                    If (hdnCommonMechId.Value = "True") Then
                        objConfigUserBO.Iscommon_Mechanic = True
                    Else
                        objConfigUserBO.Iscommon_Mechanic = False
                    End If

                    If (chkMech.Checked) Then
                        objConfigUserBO.Flg_Use_Idletime = rblAutoCorr.Value
                        If tbCommonMechId.Text <> "" Then
                            objConfigUserBO.Common_Mechanic_Id = tbCommonMechId.Text
                        Else
                            objConfigUserBO.Common_Mechanic_Id = Nothing
                        End If
                    Else
                        objConfigUserBO.Flg_Use_Idletime = Nothing
                        objConfigUserBO.Common_Mechanic_Id = Nothing
                    End If

                    objConfigUserBO.Id_Email_Acct = IIf(cmbEAccnt.Value = "0", Nothing, cmbEAccnt.Value)
                    objConfigUserBO.Id_Email = tbEmail.Text
                    objConfigUserBO.FaxNo = tbFaxNo.Text
                    objConfigUserBO.Id_Country = IIf(tbCountry.Text = "", "", tbCountry.Text)
                    objConfigUserBO.Id_State = IIf(tbState.Text = "", "", tbState.Text)
                    objConfigUserBO.Id_City = IIf(tbCity.Text = "", "", tbCity.Text)
                    objConfigUserBO.Created_By = loginName
                    objConfigUserBO.Flg_Resource = 0
                    objConfigUserBO.Resource_Name = ""

                    strResult = objUserService.SaveUserDetails(objConfigUserBO, hdnMode.Value)
                    cbUserDetailsPopup.JSProperties("cpSaveResult") = strResult
                    If (tbZipCode.Text = "") Then
                        objConfigUserBO.Id_Zip_Users = Nothing
                    Else
                        objZipCodeBO.ZipCode = tbZipCode.Text
                        objZipCodeBO.Country = tbCountry.Text
                        objZipCodeBO.State = tbState.Text
                        objZipCodeBO.City = tbCity.Text
                        objZipCodeBO.CreatedBy = loginName
                        dsReturnValStr = objZipCodeDO.Add_ZipCode(objZipCodeBO)
                        objConfigUserBO.Id_Zip_Users = tbZipCode.Text
                    End If
                End If
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "cbUserDetailsPopup_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Public Sub LoadSubsidiaryUser()
        Try
            If (loginName = Nothing) Then
                loginName = HttpContext.Current.Session("UserID").ToString()
            End If
            objConfigSubBO.UserID = loginName.ToString()
            cmbSubsidiary.DataSource = objConfigSubDO.FetchAllSubsidiary(objConfigSubBO)
            cmbSubsidiary.ValueField = "SubsidiaryID"
            cmbSubsidiary.TextField = "SubsidiaryName"
            cmbSubsidiary.DataBind()

            cmbSubsidiary.Items.Insert(0, New DevExpress.Web.ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadSubsidiaryUser", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Sub LoadDepartmentUser(ByVal subId As String)
        Try
            objConfigDeptBO.LoginId = loginName.ToString()
            objConfigDeptBO.SubsideryId = subId
            cmbDepartment.DataSource = objConfigDeptDO.GetDepartments(objConfigDeptBO)
            cmbDepartment.ValueField = "ID_Dept"
            cmbDepartment.TextField = "DPT_Name"
            cmbDepartment.DataBind()

            cmbDepartment.Items.Insert(0, New DevExpress.Web.ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadDepartmentUser", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Sub LoadEmailAccnt(ByVal subId As String)
        Try
            objConfigUserBO.Id_Subsidery_User = subId
            cmbEAccnt.DataSource = objConfigUserDO.Fetch_EmailAcct(objConfigUserBO)
            cmbEAccnt.ValueField = "Id_Email_Acct"
            cmbEAccnt.TextField = "Setting_Name"
            cmbEAccnt.DataBind()

            cmbEAccnt.Items.Insert(0, New DevExpress.Web.ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadEmailAccnt", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Sub LoadRole(ByVal subId As String, ByVal deptId As String)
        Try
            objConfigRoleBO.Id_Subsidery_Role = Convert.ToInt32(subId)
            objConfigRoleBO.Id_Dept_Role = Convert.ToInt32(deptId)
            cmbRole.DataSource = objConfigRoleDO.Fetch_Role(objConfigRoleBO)
            cmbRole.ValueField = "ID_Role"
            cmbRole.TextField = "NM_ROLE"
            cmbRole.DataBind()

            cmbRole.Items.Insert(0, New DevExpress.Web.ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadEmailAccnt", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Sub ClearControls()
        Try
            FillDefaultValues()
            LoadUserDetails()
            LoadSubsidiaryUser()
            LoadDepartmentUser(0)
            LoadEmailAccnt(0)
            LoadRole(0, 0)

            tbLoginName.Text = ""
            tbFName.Text = ""
            tbLName.Text = ""
            tbAddrLine1.Text = ""
            tbAddrLine2.Text = ""
            tbPassword.Text = ""
            tbMobile.Text = ""
            tbEmail.Text = ""
            tbFaxNo.Text = ""
            tbCommonMechId.Text = ""
            tbCountry.Text = ""
            tbCity.Text = ""
            tbState.Text = ""
            tbConfirm.Text = ""
            tbSSN.Text = ""
            tbWorkHrsFrm.Text = ""
            tbWorkHrsTo.Text = ""
            tbTelNoPersonal.Text = ""
            tbUserId.Text = ""
            tbZipCode.Text = ""

            cmbSubsidiary.SelectedIndex = 0

            cmbLang.SelectedIndex = 0

            cmbDepartment.SelectedIndex = 0

            cmbEAccnt.SelectedIndex = 0

            cmbRole.SelectedIndex = 0

            chkMech.Checked = False

            chkDuser.Checked = False

            Dim AutoCorrectNo As DevExpress.Web.ListEditItem = rblAutoCorr.Items.FindByValue("0")
            AutoCorrectNo.Selected = True

            Dim AutoCorrectYes As DevExpress.Web.ListEditItem = rblAutoCorr.Items.FindByValue("1")
            AutoCorrectYes.Selected = False
            chkWrkHrs.Checked = False

            cmbSubsidiary.Focus()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "ClearControls", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    <WebMethod()> _
    Public Shared Function GetZipCodes(ByVal zipCode As String) As List(Of String)
        Dim retZipCodes As New List(Of String)()
        Try
            retZipCodes = commonUtil.getZipCodes(zipCode, loginName)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "GetZipCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return retZipCodes
    End Function
    <WebMethod()> _
    Public Shared Function DeleteUserDetails(ByVal userid As String) As String()
        Dim strResult As String() = {}
        Try
            objConfigUserBO.Userid = userid.ToString()
            strResult = objUserService.DeleteUserDetails(objConfigUserBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "DeleteUserDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    Private Sub LoadAllScreens()
        Try
            Dim dsScreen As New DataSet
            Dim objConfigRoleBO As New ConfigRoleBO
            dsScreen = objConfigRoleDO.Scr_Name_Fetch(objConfigRoleBO)
            drpStartScreen.DataSource = dsScreen.Tables(0)
            drpStartScreen.ValueField = "ID_SCR"
            drpStartScreen.TextField = "NAME_SCR"
            drpStartScreen.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadAllScreens", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    <WebMethod()>
    Public Shared Function SaveRoleDetails(ByVal roleId As String, ByVal roleNm As String, ByVal subId As String, ByVal deptId As String, ByVal startScrRoleId As String,
                                           ByVal flgSysAdmin As String, ByVal flgSubAdmin As String, ByVal flgDeptAdmin As String, ByVal mode As String,
                                           ByVal flgNbkSett As String, ByVal flgAccounting As String, ByVal flgSPOrder As String) As String
        Dim strResult As String = ""
        Try
            Dim objConfigRoleBO As New ConfigRoleBO
            objConfigRoleBO.Id_Role = roleId
            objConfigRoleBO.Nm_Role = roleNm
            objConfigRoleBO.Id_Subsidery_Role = subId
            objConfigRoleBO.Id_Dept_Role = deptId
            objConfigRoleBO.Id_Scr_Start_Role = startScrRoleId
            objConfigRoleBO.Flg_Sysadmin = flgSysAdmin
            objConfigRoleBO.Flg_Subsidadmin = flgSubAdmin
            objConfigRoleBO.Flg_Deptadmin = flgDeptAdmin
            objConfigRoleBO.Created_By = loginName
            objConfigRoleBO.FlgNbkSett = flgNbkSett
            objConfigRoleBO.FlgAccounting = flgAccounting
            objConfigRoleBO.FlgSPOrder = flgSPOrder
            strResult = objConfigRoleServ.SaveRoleDetails(objConfigRoleBO, mode)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "SaveRoleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function DeleteRole(ByVal roleIdxmls As String) As String()
        Dim strResult As String()
        Try
            Dim objConfigRoleBO As New ConfigRoleBO
            objConfigRoleBO.StrDelRole = roleIdxmls.ToString
            strResult = objConfigRoleServ.RemoveRole(objConfigRoleBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "DeleteRoles", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    Private Sub LoadPermissions(roleId As String)
        Try
            Dim dsRoleAcc As New DataSet
            Dim dtRoleAcc As New DataTable
            Dim objConfigRoleBO As New ConfigRoleBO
            objConfigRoleBO.Id_Role = roleId
            objConfigRoleBO.User = loginName
            dsRoleAcc = objConfigRoleDO.RoleAccess(objConfigRoleBO)

            If dsRoleAcc.Tables.Count > 0 Then
                HttpContext.Current.Session("dtPermission") = dsRoleAcc.Tables(0)
                If dsRoleAcc.Tables(0).Rows.Count > 0 Then
                    dtRoleAcc = dsRoleAcc.Tables(0)
                    gvPermissions.DataSource = dtRoleAcc
                    gvPermissions.DataBind()
                Else
                    gvPermissions.DataSource = {}
                    gvPermissions.DataBind()
                End If
                gvPermissions.JSProperties("cpPerGridRowCnt") = dtRoleAcc.Rows.Count
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadPermissions", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Private Sub CheckBoxDetails(roleId As String)
        Try
            Dim dsRoleAcc As New DataSet
            Dim dtRoleAcc As New DataTable
            Dim objConfigRoleBO As New ConfigRoleBO
            objConfigRoleBO.Id_Role = roleId
            objConfigRoleBO.User = loginName
            dsRoleAcc = objConfigRoleDO.RoleAccess(objConfigRoleBO)
            If dsRoleAcc.Tables(1).Rows.Count > 0 Then
                dtRoleAcc = dsRoleAcc.Tables(1)
                chkBoxFrmLayout.Items.Clear()
                If dtRoleAcc.Rows.Count >= 50 Then
                    chkBoxFrmLayout.ColumnCount = 5
                Else
                    chkBoxFrmLayout.ColumnCount = 4
                End If
                For Each dtrow As DataRow In dtRoleAcc.Rows
                    Dim roleAcc As New ConfigRoleBO()
                    Dim cb As ASPxCheckBox = New ASPxCheckBox()
                    cb.ID = dtrow("ID_SCR").ToString()
                    cb.ClientInstanceName = dtrow("ID_SCR").ToString()
                    cb.ClientIDMode = ClientIDMode.Static
                    cb.Font.Size = 7
                    cb.ForeColor = Drawing.Color.Black
                    cb.Theme = "Office2010Blue"
                    Dim li1 As LayoutItem = New LayoutItem("")
                    li1.Controls.Add(cb)
                    chkBoxFrmLayout.Items.Add(li1)
                    cb.Text = dtrow("NAME_SCR").ToString()
                    chkSelectAll.ClientVisible = True
                Next
            Else
                chkSelectAll.ClientVisible = False
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "CheckBoxDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Private Sub LoadCtlPermissions(roleId As String)
        Try
            Dim dsRoleAcc As New DataSet
            Dim dtRoleAcc As New DataTable
            Dim objConfigRoleBO As New ConfigRoleBO
            objConfigRoleBO.Id_Role = roleId
            objConfigRoleBO.User = loginName
            dsRoleAcc = objConfigRoleDO.RoleAccess(objConfigRoleBO)
            If dsRoleAcc.Tables.Count > 0 Then
                If dsRoleAcc.Tables(2).Rows.Count > 0 Then
                    HttpContext.Current.Session("dtPerCtrl") = dsRoleAcc.Tables(2)
                    dtRoleAcc = dsRoleAcc.Tables(2)
                    gvCtrlPermissions.DataSource = dtRoleAcc
                    gvCtrlPermissions.DataBind()
                    gvCtrlPermissions.JSProperties("cpPerCtlGridRowCnt") = dtRoleAcc.Rows.Count
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "LoadCtlPermissions", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Sub cbGrids_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim params As String() = e.Parameter.Split(";")
            If params.Count > 1 Then
                If params(0).ToString = "FETCH" Then
                    Dim roleId As String = params(1).ToString
                    LoadPermissions(roleId)
                    cbPerGrid.JSProperties("cpIsAdd") = True
                ElseIf params(0).ToString = "ADD" Then
                    Dim scrIdxmls As String = ""
                    Dim dtRoles As DataTable
                    Dim dr As DataRow
                    Dim roleId As String = params(1).ToString
                    scrIdxmls = hdnXMLNew.Get("xmlString")
                    dtRoles = HttpContext.Current.Session("dtPermission")

                    If scrIdxmls <> "" Then
                        Dim xmldoc As New XmlDocument()
                        xmldoc.LoadXml(scrIdxmls)
                        Dim nodes As XmlNodeList = xmldoc.DocumentElement.SelectNodes("/Root/Master")
                        'Dim id_role_acc As Integer = 111111 'check

                        For Each node As XmlNode In nodes
                            dr = dtRoles.NewRow()
                            dr("ID_ACCESS_NO") = id_role_acc
                            dr("ID_SCR_UTIL") = node.Item("ScrId").InnerText
                            dr("NAME_SCR") = node.Item("ScrName").InnerText
                            dr("ACC_READ") = 1
                            dr("ACC_WRITE") = 1
                            dr("ACC_CREATE") = 1
                            dr("ACC_PRINT") = 1
                            dr("ACC_DELETE") = 1
                            dr("ID_ROLE_ACCESS") = roleId
                            dtRoles.Rows.Add(dr)
                            id_role_acc = id_role_acc + 1
                        Next
                        dtRoles.AcceptChanges()
                        HttpContext.Current.Session("dtPermission") = dtRoles
                    End If
                    gvPermissions.DataSource = dtRoles
                    gvPermissions.DataBind()

                    gvPermissions.JSProperties("cpPerGridRowCnt") = dtRoles.Rows.Count
                    cbPerGrid.JSProperties("cpIsAdd") = True
                ElseIf params(0).ToString = "SAVE" Then
                    StrIntXMLs = ""
                    Dim scrId As String
                    Dim roleId As String = params(1).ToString
                    Dim name As String = String.Empty
                    Dim StrIntXML As String = String.Empty
                    Dim accRead As Boolean
                    Dim accWrite As Boolean
                    Dim accCreate As Boolean
                    Dim accDel As Boolean
                    Dim accPrint As Boolean
                    Dim conId As String = "-1"
                    For i = 0 To gvPermissions.VisibleRowCount - 1 Step 1
                        Dim values As Object() = TryCast(gvPermissions.GetRowValues(i, New String() {"ID_SCR_UTIL", "NAME_SCR", "ACC_READ", "ACC_WRITE", "ACC_CREATE", "ACC_DELETE", "ACC_PRINT"}), Object())
                        scrId = values(0).ToString
                        name = values(1).ToString
                        accRead = values(2)
                        accWrite = values(3)
                        accCreate = values(4)
                        accDel = values(5)
                        accPrint = values(6)
                        StrIntXML = "<ROLE><IDR>" + roleId + "</IDR>" + "<S>" + scrId + "</S>" + "<T>" + conId + "</T>" + "<R>" + accRead.ToString + "</R>" + "<W>" + accWrite.ToString + "</W>" + "<C>" + accCreate.ToString + "</C>" + "<P>" + accPrint.ToString + "</P>" + "<D>" + accDel.ToString + "</D></ROLE>"
                        StrIntXMLs += StrIntXML
                        cbPerGrid.JSProperties("cpIsAdd") = False
                    Next
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "cbGrids_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try


    End Sub
    Protected Sub cbChkLayout_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            chkBoxFrmLayout.Items.Clear()
            Dim roleId As String = e.Parameter
            CheckBoxDetails(roleId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "cbChkLayout_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Sub cbPerCtrlGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim params As String() = e.Parameter.Split(";")
            LoadAllScreens()
            If params.Count > 1 Then
                If params(0).ToString = "FETCH" Then
                    Dim roleId As String = params(1).ToString
                    LoadCtlPermissions(roleId)
                    FetchRoleDetails(roleId)
                    cbPerCtrlGrid.JSProperties("cpIsSave") = False
                ElseIf params(0).ToString = "SAVE" Then
                    Dim strResult As String = ""
                    Dim scrId As String = "-1"
                    Dim roleId As String = params(1).ToString
                    Dim name As String = String.Empty
                    Dim StrIntXML As String = String.Empty
                    Dim accRead As Boolean
                    Dim accWrite As Boolean
                    Dim accCreate As Boolean
                    Dim accDel As Boolean
                    Dim accPrint As Boolean
                    Dim conId As String = String.Empty
                    Dim objConfigRoleBO As New CARS.CoreLibrary.ConfigRoleBO
                    For i = 0 To gvCtrlPermissions.VisibleRowCount - 1 Step 1
                        Dim values As Object() = TryCast(gvCtrlPermissions.GetRowValues(i, New String() {"ID_CON_UTIL", "NAME_CONTROL", "HAS_ACCESS"}), Object())
                        conId = values(0).ToString
                        name = values(1).ToString
                        accRead = False
                        accWrite = values(2)
                        accCreate = False
                        accDel = False
                        accPrint = False
                        StrIntXML = "<ROLE><IDR>" + roleId + "</IDR>" + "<S>" + scrId + "</S>" + "<T>" + conId + "</T>" + "<R>" + accRead.ToString + "</R>" + "<W>" + accWrite.ToString + "</W>" + "<C>" + accCreate.ToString + "</C>" + "<P>" + accPrint.ToString + "</P>" + "<D>" + accDel.ToString + "</D></ROLE>"
                        StrIntXMLs += StrIntXML
                    Next
                    StrIntXMLs = "<ROOT>" + StrIntXMLs + "</ROOT>"
                    objConfigRoleBO.Scrlroleupdate = StrIntXMLs
                    objConfigRoleBO.Id_Role = roleId
                    objConfigRoleBO.Created_By = loginName
                    strResult = objConfigRoleServ.FinalSaveRole(objConfigRoleBO)
                    cbPerCtrlGrid.JSProperties("cpIsSave") = True
                    cbPerCtrlGrid.JSProperties("cpStrResult") = strResult

                    'Newly Added 18-07-2022
                    Dim retVal As String
                    objConfigRoleBO.Id_Scr_Start_Role = drpStartScreen.Value
                    objConfigRoleBO.FlgNbkSett = cbNbkSettings.Checked
                    objConfigRoleBO.FlgAccounting = cbAccounting.Checked
                    objConfigRoleBO.FlgSPOrder = cbSparePartOrder.Checked
                    objConfigRoleBO.Modified_By = loginName
                    retVal = objConfigRoleServ.UpdateRoleDetails(objConfigRoleBO)

                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "cbPerCtrlGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Sub gvPermissions_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Try
            StrIntXMLs = ""
            Dim scrId As String
            Dim roleId As String = hdnRoleId.Value.ToString
            Dim name As String = String.Empty
            Dim StrIntXML As String = String.Empty
            Dim accRead As Boolean
            Dim accWrite As Boolean
            Dim accCreate As Boolean
            Dim accDel As Boolean
            Dim accPrint As Boolean
            Dim conId As String = "-1"
            For i = 0 To gvPermissions.VisibleRowCount - 1 Step 1
                Dim values As Object() = TryCast(gvPermissions.GetRowValues(i, New String() {"ID_SCR_UTIL", "NAME_SCR", "ACC_READ", "ACC_WRITE", "ACC_CREATE", "ACC_DELETE", "ACC_PRINT"}), Object())
                scrId = values(0).ToString
                name = values(1).ToString
                accRead = values(2)
                accWrite = values(3)
                accCreate = values(4)
                accDel = values(5)
                accPrint = values(6)
                Dim query As Array = (From item In e.UpdateValues
                                      Where item.Keys(0).ToString = scrId).ToArray()

                If query.Length > 0 Then
                    accRead = IIf(query(0).NewValues("ACC_READ") IsNot Nothing, query(0).NewValues("ACC_READ"), False)
                    accWrite = IIf(query(0).NewValues("ACC_WRITE") IsNot Nothing, query(0).NewValues("ACC_WRITE"), False)
                    accCreate = IIf(query(0).NewValues("ACC_CREATE") IsNot Nothing, query(0).NewValues("ACC_CREATE"), False)
                    accDel = IIf(query(0).NewValues("ACC_DELETE") IsNot Nothing, query(0).NewValues("ACC_DELETE"), False)
                    accPrint = IIf(query(0).NewValues("ACC_PRINT") IsNot Nothing, query(0).NewValues("ACC_PRINT"), False)
                End If

                StrIntXML = "<ROLE><IDR>" + roleId + "</IDR>" + "<S>" + scrId + "</S>" + "<T>" + conId + "</T>" + "<R>" + accRead.ToString + "</R>" + "<W>" + accWrite.ToString + "</W>" + "<C>" + accCreate.ToString + "</C>" + "<P>" + accPrint.ToString + "</P>" + "<D>" + accDel.ToString + "</D></ROLE>"
                StrIntXMLs += StrIntXML
            Next
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "gvPermissions_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Sub gvCtrlPermissions_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Try
            Dim strResult As String = ""
            Dim scrId As String = "-1"
            Dim roleId As String = hdnRoleId.Value.ToString
            Dim name As String = String.Empty
            Dim StrIntXML As String = String.Empty
            Dim accRead As Boolean
            Dim accWrite As Boolean
            Dim accCreate As Boolean
            Dim accDel As Boolean
            Dim accPrint As Boolean
            Dim conId As String = String.Empty
            Dim objConfigRoleBO As New CARS.CoreLibrary.ConfigRoleBO
            For i = 0 To gvCtrlPermissions.VisibleRowCount - 1 Step 1
                Dim values As Object() = TryCast(gvCtrlPermissions.GetRowValues(i, New String() {"ID_CON_UTIL", "NAME_CONTROL", "HAS_ACCESS"}), Object())
                conId = values(0).ToString
                name = values(1).ToString
                accRead = False
                accWrite = values(2)
                accCreate = False
                accDel = False
                accPrint = False
                Dim query As Array = (From item In e.UpdateValues
                                      Where item.Keys(0).ToString = conId).ToArray()

                If query.Length > 0 Then
                    accWrite = IIf(query(0).NewValues("ACC_READ") IsNot Nothing, query(0).NewValues("HAS_ACCESS"), False)
                End If

                StrIntXML = "<ROLE><IDR>" + roleId + "</IDR>" + "<S>" + scrId + "</S>" + "<T>" + conId + "</T>" + "<R>" + accRead.ToString + "</R>" + "<W>" + accWrite.ToString + "</W>" + "<C>" + accCreate.ToString + "</C>" + "<P>" + accPrint.ToString + "</P>" + "<D>" + accDel.ToString + "</D></ROLE>"
                StrIntXMLs += StrIntXML
            Next
            StrIntXMLs = "<ROOT>" + StrIntXMLs + "</ROOT>"
            objConfigRoleBO.Scrlroleupdate = StrIntXMLs
            objConfigRoleBO.Id_Role = roleId
            objConfigRoleBO.Created_By = loginName
            strResult = objConfigRoleServ.FinalSaveRole(objConfigRoleBO)
            gvCtrlPermissions.JSProperties("cpStrResult") = strResult
            LoadCtlPermissions(roleId)
            e.Handled = True

            'Newly Added 18-07-2022
            Dim retVal As String
            objConfigRoleBO.Id_Scr_Start_Role = drpStartScreen.Value
            objConfigRoleBO.FlgNbkSett = cbNbkSettings.Checked
            objConfigRoleBO.FlgAccounting = cbAccounting.Checked
            objConfigRoleBO.FlgSPOrder = cbSparePartOrder.Checked
            objConfigRoleBO.Modified_By = loginName
            retVal = objConfigRoleServ.UpdateRoleDetails(objConfigRoleBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "gvCtrlPermissions_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    <WebMethod()> _
    Public Shared Function FetchUser(ByVal loginId As String) As ConfigUsersBO()
        Try
            objConfigUserBO.Id_Login = loginId
            details = objUserService.FetchUser(objConfigUserBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "FetchUser", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    Public Sub FetchRoleDetails(ByVal roleId As String)
        Dim idStartScr As String = "0"
        Dim flgNbk As Boolean
        Dim flgAccounting As Boolean
        Dim flgSPOrder As Boolean
        Dim dsRoleDet As New DataSet
        Dim dtRoleDet As New DataTable
        Dim objConfigRoleBO As New ConfigRoleBO
        Try
            objConfigRoleBO.Id_Role = roleId
            dsRoleDet = objConfigRoleDO.FetchRoleDetails(objConfigRoleBO)
            If dsRoleDet.Tables.Count > 0 Then
                dtRoleDet = dsRoleDet.Tables(0)

                If dtRoleDet.Rows.Count > 0 Then
                    idStartScr = IIf(IsDBNull(dtRoleDet.Rows(0)("ID_SCR_START_ROLE")), "0", dtRoleDet.Rows(0)("ID_SCR_START_ROLE").ToString)
                    flgNbk = IIf(IsDBNull(dtRoleDet.Rows(0)("FLG_NBK")), False, dtRoleDet.Rows(0)("FLG_NBK"))
                    flgAccounting = IIf(IsDBNull(dtRoleDet.Rows(0)("FLG_ACCOUNTING")), False, dtRoleDet.Rows(0)("FLG_ACCOUNTING"))
                    flgSPOrder = IIf(IsDBNull(dtRoleDet.Rows(0)("FLG_SPAREPARTORDER")), False, dtRoleDet.Rows(0)("FLG_SPAREPARTORDER"))
                End If

                drpStartScreen.Value = idStartScr

                If Not flgNbk Then
                    cbNbkSettings.Checked = False
                Else
                    cbNbkSettings.Checked = True
                End If

                If Not flgAccounting Then
                    cbAccounting.Checked = False
                Else
                    cbAccounting.Checked = True
                End If

                If Not flgSPOrder Then
                    cbSparePartOrder.Checked = False
                Else
                    cbSparePartOrder.Checked = True
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "FetchRoleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Private Function GetDefaultStartScreenId() As Integer
        Dim startScreenId As Integer
        Try
            Dim dsMenu As DataSet = CType(Session("usermenu"), DataSet)
            Dim dtMenu As DataTable = dsMenu.Tables(0)

            If dtMenu.Rows.Count > 0 Then
                Dim startScrRow = From row In dtMenu.Rows
                                  Where row("NAME_MODULE") = "WORK ORDER" And row("DESCRIPTION") = "/Transactions/frmWOSearch.aspx"
                                  Select row
                If startScrRow.Count > 0 Then
                    startScreenId = CInt(startScrRow(0)(0))
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfUserdetail", "GetDefaultStartScreenId", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return startScreenId
    End Function
    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci
        End If
    End Sub
End Class