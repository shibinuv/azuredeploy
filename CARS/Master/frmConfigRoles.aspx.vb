Imports System.Globalization
Imports System.Threading
Imports System.Web.Services
Imports System.Xml
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS
Imports DevExpress.Web

Public Class frmConfigRoles
    Inherits System.Web.UI.Page
    Shared loginName As String
    Dim objConfigSubDO As New Subsidiary.ConfigSubsidiaryDO
    Dim objConfigDeptDO As New Department.ConfigDepartmentDO
    Dim objConfigRoleDO As New CoreLibrary.CARS.Role.ConfigRoleDO
    Shared objConfigRoleServ As New Services.ConfigRole.Role
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared id_role_acc As Integer
    Shared StrIntXMLs As String = String.Empty
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            EnableViewState = False
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If
            Session("Select") = GetLocalResourceObject("genSelect")
            Dim subsideryId = Session("UserSubsidiary")
            Dim departmentId = Session("UserDept")

            LoadSubsidary()

            If subsideryId IsNot Nothing And subsideryId <> "" Then
                drpSubsidiary.Value = subsideryId
                LoadDepartment(subsideryId)
            Else
                LoadDepartment(drpSubsidiary.Value)
            End If

            If departmentId IsNot Nothing And departmentId <> "" Then
                drpDepartment.Value = departmentId
            End If

            If subsideryId IsNot Nothing And subsideryId <> "" And departmentId IsNot Nothing And departmentId <> "" Then
                LoadRolesGrid(subsideryId, departmentId)
            Else
                LoadRolesGrid(0, 0)
            End If

            If Not HttpContext.Current.Session("dtPermission") Is Nothing Then
                gvPermissions.DataSource = HttpContext.Current.Session("dtPermission")
                gvPermissions.DataBind()
            End If

            If Not HttpContext.Current.Session("dtPerCtrl") Is Nothing Then
                gvCtrlPermissions.DataSource = HttpContext.Current.Session("dtPerCtrl")
                gvCtrlPermissions.DataBind()
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Private Sub LoadSubsidary()
        Try
            Dim dsFetchAllSub As New DataSet
            Dim objConfigSubBO As New ConfigSubsidiaryBO
            objConfigSubBO.UserID = loginName.ToString()
            dsFetchAllSub = objConfigSubDO.FetchAllSubsidiary(objConfigSubBO)
            drpSubsidiary.DataSource = dsFetchAllSub.Tables(0)
            drpSubsidiary.ValueField = "SubsidiaryID"
            drpSubsidiary.TextField = "SubsidiaryName"
            drpSubsidiary.DataBind()
            drpSubsidiary.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
            drpSubsidiary.SelectedIndex = 0
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "LoadSubsidary", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Private Sub LoadDepartment(subId As String)
        Try
            Dim dsFetchDept As New DataSet
            Dim objConfigDeptBO As New ConfigDepartmentBO
            objConfigDeptBO.LoginId = loginName.ToString()
            objConfigDeptBO.SubsideryId = subId
            dsFetchDept = objConfigDeptDO.GetDepartments(objConfigDeptBO)
            drpDepartment.DataSource = dsFetchDept.Tables(0)
            drpDepartment.ValueField = "ID_Dept"
            drpDepartment.TextField = "DPT_Name"
            drpDepartment.DataBind()
            drpDepartment.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            If dsFetchDept.Tables(0).Rows.Count > 0 Then
                drpDepartment.SelectedIndex = 1
            Else
                drpDepartment.SelectedIndex = 0
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "LoadDepartment", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Private Sub LoadRolesGrid(subId As String, deptId As String)
        Try
            Dim objConfigRoleDO As New CoreLibrary.CARS.Role.ConfigRoleDO
            Dim dsFetchRole As New DataSet
            Dim objConfigRoleBO As New ConfigRoleBO
            objConfigRoleBO.Id_Subsidery_Role = subId
            objConfigRoleBO.Id_Dept_Role = deptId

            dsFetchRole = objConfigRoleDO.Fetch_Role(objConfigRoleBO)
            gvRoles.DataSource = dsFetchRole.Tables(0)
            gvRoles.DataBind()

            drpRole.ValueField = "ID_ROLE"
            drpRole.TextField = "NM_ROLE"
            drpRole.DataSource = dsFetchRole.Tables(0)
            drpRole.DataBind()
            drpRole.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
            drpRole.SelectedIndex = 0

            If dsFetchRole.Tables(0).Rows.Count > 0 Then
                gvRoles.ClientVisible = True
            Else
                gvRoles.ClientVisible = False
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "LoadRolesGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Private Sub LoadAllScreens()
        Try
            Dim dsScreen As New DataSet
            Dim objConfigRoleBO As New ConfigRoleBO
            dsScreen = objConfigRoleDO.Scr_Name_Fetch(objConfigRoleBO)
            drpStartScreen.DataSource = dsScreen.Tables(0)
            drpStartScreen.ValueField = "ID_SCR"
            drpStartScreen.TextField = "NAME_SCR"
            drpStartScreen.DataBind()
            'drpStartScreen.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "LoadAllScreens", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub cbRolesGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim params As String() = e.Parameter.Split(";")
            If params.Count > 1 Then
                Dim subsideryId = params(0).ToString()
                Dim departmentId = params(1).ToString()
                LoadRolesGrid(subsideryId, departmentId)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "cbRolesGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try


    End Sub

    Protected Sub cbEditRoles_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            LoadAllScreens()
            If hdnMode.Value = "Edit" Then

                Dim params As String() = e.Parameter.Split(";")
                If params.Count > 2 Then
                    Dim subsideryId = params(1).ToString()
                    Dim departmentId = params(2).ToString()
                    LoadRolesGrid(subsideryId, departmentId)

                    Dim visibleIndex As Integer = params(0)
                    Dim rowValues As Object() = TryCast(gvRoles.GetRowValues(visibleIndex, New String() {"ID_ROLE", "ID_SCR_START_ROLE", "NM_ROLE", "FLG_SYSADMIN", "FLG_SUBSIDADMIN", "FLG_DEPTADMIN", "FLG_NBK", "FLG_ACCOUNTING", "FLG_SPAREPARTORDER"}), Object())
                    Dim idRole As Integer = rowValues(0)
                    Dim idStartScr As String = rowValues(1).ToString()
                    Dim roleName As String = rowValues(2).ToString()
                    Dim admin As Boolean = rowValues(3)
                    Dim subAdmin As Boolean = rowValues(4)
                    Dim deptAdmin As Boolean = rowValues(5)
                    Dim flgNbk As Boolean = rowValues(6)
                    Dim flgAccounting As Boolean = rowValues(7)
                    Dim flgSPOrder As Boolean = rowValues(8)

                    drpStartScreen.Value = idStartScr
                    txtRole.Text = roleName
                    rbaddadmin.Checked = admin
                    rbaddsubadmin.Checked = subAdmin
                    rbadddepadmin.Checked = deptAdmin
                    If Not admin Then
                        rbaddadmin.Enabled = False
                    Else
                        rbaddadmin.Enabled = True
                    End If

                    If Not subAdmin Then
                        rbaddsubadmin.Enabled = False
                    Else
                        rbaddsubadmin.Enabled = True
                    End If

                    If Not deptAdmin Then
                        rbadddepadmin.Enabled = False
                    Else
                        rbadddepadmin.Enabled = True
                    End If

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


            ElseIf hdnMode.Value = "Add" Then
                Dim params As String() = e.Parameter.Split(";")
                If params.Count > 1 Then
                    Dim subsideryId = params(0).ToString()
                    Dim departmentId = params(1).ToString()
                    drpStartScreen.SelectedIndex = 0
                    txtRole.Text = ""
                    rbaddadmin.Checked = False
                    rbaddsubadmin.Checked = False
                    rbadddepadmin.Checked = False

                    rbaddadmin.Enabled = True
                    rbaddsubadmin.Enabled = True
                    rbadddepadmin.Enabled = True

                    If subsideryId = "0" And departmentId = "0" Then
                        rbaddadmin.Checked = True
                        rbaddadmin.Enabled = True
                        rbaddsubadmin.Enabled = False
                        rbadddepadmin.Enabled = False
                    ElseIf subsideryId <> "0" And departmentId = "0" Then
                        rbaddsubadmin.Checked = True
                        rbaddadmin.Enabled = False
                        rbaddsubadmin.Enabled = True
                        rbadddepadmin.Enabled = False
                    Else
                        rbadddepadmin.Checked = True
                        rbaddadmin.Enabled = False
                        rbaddsubadmin.Enabled = False
                        rbadddepadmin.Enabled = True
                    End If

                    cbNbkSettings.Checked = False
                    cbAccounting.Checked = False
                    cbSparePartOrder.Checked = False
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "cbEditRoles_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "SaveRoleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "DeleteRoles", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "LoadPermissions", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "CheckBoxDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "LoadCtlPermissions", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "cbGrids_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try


    End Sub

    Protected Sub cbChkLayout_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            chkBoxFrmLayout.Items.Clear()
            Dim roleId As String = e.Parameter
            CheckBoxDetails(roleId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "cbChkLayout_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub cbPerCtrlGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim params As String() = e.Parameter.Split(";")
            If params.Count > 1 Then
                If params(0).ToString = "FETCH" Then
                    Dim roleId As String = params(1).ToString
                    LoadCtlPermissions(roleId)
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
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "cbPerCtrlGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "gvPermissions_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigRoles", "gvCtrlPermissions_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci

        End If
    End Sub
End Class