Imports System.Web.Services
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS
Imports System.Web.Security
Imports System.Web.UI
Imports Encryption
Imports CARS.CoreLibrary.CARS.Department
Imports DevExpress.Web
Imports CARS.CoreLibrary.CARS.Services.HP
Imports System.Globalization
Imports System.Threading

Public Class frmCfHourlyPrice
    Inherits System.Web.UI.Page
    Shared objConfigBO As New ConfigSettingsBO
    Shared objConfigDO As New ConfigSettings.ConfigSettingsDO
    Shared objConfigHPServ As New Services.ConfigHourlyPrice.ConfigHourlyPrice
    Shared commonUtil As New Utilities.CommonUtility
    Shared loginName As String
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of ConfigSettingsBO)()
    Dim objuserper As New UserAccessPermissionsBO
    Shared dtCaption As DataTable
    Shared objHPRate As New HPRate
    Private objHPRateBO As New HPRateBO
    Shared objConfigSettingsDO As New CoreLibrary.CARS.ConfigSettings.ConfigSettingsDO
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            EnableViewState = False
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If
            dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)
            hdnSelect.Value = dtCaption.Select("TAG='select'")(0)(1)

            hdnPageSize.Value = System.Configuration.ConfigurationManager.AppSettings("PageSize")

            'SetPermission()
            Session("Select") = GetLocalResourceObject("genSelect")
            Dim dsDept As DataSet
            Dim objDeptDO As New ConfigDepartmentDO()
            Dim objConfigDeptBO As New ConfigDepartmentBO()

            If Not IsCallback Then
                FetchAllddValues()
                objConfigDeptBO.LoginId = loginName.ToString
                dsDept = objDeptDO.FetchAllDepartments(objConfigDeptBO)

                cmbDepFrom.DataSource = dsDept.Tables(0)
                cmbDepFrom.TextField = "DEPARTMENTNAME"
                cmbDepFrom.ValueField = "DEPARTMENTID"
                cmbDepFrom.DataBind()
                cmbDepFrom.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
                cmbDepFrom.SelectedIndex = 1

                cmbDepTo.DataSource = dsDept.Tables(0)
                cmbDepTo.TextField = "DEPARTMENTNAME"
                cmbDepTo.ValueField = "DEPARTMENTID"
                cmbDepTo.DataBind()
                cmbDepTo.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
                cmbDepTo.SelectedIndex = 1
            End If

            If Session("HPGridData") IsNot Nothing Then
                gvHourlyPrice.DataSource = Session("HPGridData")
                gvHourlyPrice.DataBind()
            End If
            FetchAllGridData()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub cbHPGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim deptFrom As Integer
            Dim deptTo As Integer
            Dim params As String = e.Parameter
            Dim param As String() = params.Split(";")
            Dim strResult As String = String.Empty
            If param.Count > 1 Then
                deptFrom = Integer.Parse(param(0))
                deptTo = Integer.Parse(param(1))
                LoadHPGrid(deptFrom, deptTo)

            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "cbHPGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Private Sub LoadHPGrid(deptFrom As Integer, deptTo As Integer)
        Try
            Session("HPGridData") = objHPRate.Search_HPRate(deptFrom, deptTo)
            gvHourlyPrice.DataSource = Session("HPGridData")
            gvHourlyPrice.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "LoadHPGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Private Sub FetchAllddValues()
        Try
            Dim dsHPConfig As DataSet
            dsHPConfig = objHPRate.FetchCmb_Rate(loginName)
            Dim dvDepartment As DataView
            dvDepartment = dsHPConfig.Tables(0).DefaultView
            dvDepartment.Sort = "DPT_Name"

            ' -- -- Table 0 = Department List
            cmbDepartmentCode.DataSource = dvDepartment
            cmbDepartmentCode.TextField = "DPT_Name"
            cmbDepartmentCode.ValueField = "ID_Dept"
            cmbDepartmentCode.DataBind()
            cmbDepartmentCode.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            '-- Table 1 = Make List 
            If dsHPConfig.Tables(1).Rows.Count > 0 Then
                cmbMake.DataSource = dsHPConfig.Tables(1)
                cmbMake.TextField = "DESCRIPTION"
                cmbMake.ValueField = "ID_SETTINGS"
                cmbMake.DataBind()
            End If
            cmbMake.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            '-- Table 2 = Machanic Price Code List
            If dsHPConfig.Tables(2).Rows.Count > 0 Then
                cmbMechanicPriceCode.DataSource = dsHPConfig.Tables(2)
                cmbMechanicPriceCode.TextField = "DESCRIPTION"
                cmbMechanicPriceCode.ValueField = "ID_SETTINGS"
                cmbMechanicPriceCode.DataBind()
            End If
            cmbMechanicPriceCode.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            '-- Table 3 = Repair Package Price Code List
            If dsHPConfig.Tables(3).Rows.Count > 0 Then
                cmbRPPriceCode.DataSource = dsHPConfig.Tables(3)
                cmbRPPriceCode.TextField = "DESCRIPTION"
                cmbRPPriceCode.ValueField = "ID_SETTINGS"
                cmbRPPriceCode.DataBind()
            End If
            cmbRPPriceCode.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            '-- Table 4 = Customer Price Code List
            If dsHPConfig.Tables(4).Rows.Count > 0 Then
                cmbCustomerPriceCode.DataSource = dsHPConfig.Tables(4)
                cmbCustomerPriceCode.TextField = "DESCRIPTION"
                cmbCustomerPriceCode.ValueField = "ID_SETTINGS"
                cmbCustomerPriceCode.DataBind()
            End If
            cmbCustomerPriceCode.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            '-- Table 5 = Vehicle Group List
            If dsHPConfig.Tables(5).Rows.Count > 0 Then
                cmbVehicleGroup.DataSource = dsHPConfig.Tables(5)
                cmbVehicleGroup.TextField = "DESCRIPTION"
                cmbVehicleGroup.ValueField = "ID_SETTINGS"
                cmbVehicleGroup.DataBind()
            End If
            cmbVehicleGroup.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            '-- Table 6 = Price Code on Job List
            If dsHPConfig.Tables(6).Rows.Count > 0 Then
                cmbPriceCodeOnJob.DataSource = dsHPConfig.Tables(6)
                cmbPriceCodeOnJob.TextField = "DESCRIPTION"
                cmbPriceCodeOnJob.ValueField = "ID_SETTINGS"
                cmbPriceCodeOnJob.DataBind()
            End If
            cmbPriceCodeOnJob.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

            '-- Table 7 = VAT Code
            If dsHPConfig.Tables(7).Rows.Count > 0 Then
                cmbVAT.DataSource = dsHPConfig.Tables(7)
                cmbVAT.TextField = "DESCRIPTION"
                cmbVAT.ValueField = "ID_SETTINGS"
                cmbVAT.DataBind()
            End If
            cmbVAT.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
        Catch ex As Exception
            Dim oErrHandle As New MSGCOMMON.MsgErrorHndlr
            oErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchAllddValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Private Sub PopulateBO()
        Try
            objHPRateBO.PID_MAKE_HP = IIf(cmbMake.Value Is Nothing Or cmbMake.Value = "0", "", cmbMake.Value)
            objHPRateBO.PID_DEPT_HP = IIf(cmbDepartmentCode.Value Is Nothing Or cmbDepartmentCode.Value = "0", "", cmbDepartmentCode.Value)
            objHPRateBO.PID_MECHPCD_HP = IIf(cmbMechanicPriceCode.Value Is Nothing Or cmbMechanicPriceCode.Value = "0", "", cmbMechanicPriceCode.Value)
            objHPRateBO.PID_RPPCD_HP = IIf(cmbRPPriceCode.Value Is Nothing Or cmbRPPriceCode.Value = "0", "", cmbRPPriceCode.Value)
            objHPRateBO.PID_CUSTPCD_HP = IIf(cmbCustomerPriceCode.Value Is Nothing Or cmbCustomerPriceCode.Value = "0", "", cmbCustomerPriceCode.Value)
            objHPRateBO.PID_VEHGRP_HP = IIf(cmbVehicleGroup.Value Is Nothing Or cmbVehicleGroup.Value = "0", "", cmbVehicleGroup.Value)
            objHPRateBO.PID_JOBPCD_HP = IIf(cmbPriceCodeOnJob.Value Is Nothing Or cmbPriceCodeOnJob.Value = "0", "", cmbPriceCodeOnJob.Value)
            objHPRateBO.PINV_LABOR_TEXT = txtTextforLabour.Text.Trim
            'objHPRateBO.PHP_PRICE = Val(NumCurrencyConverter.GetDefaultNoFormat(Session("Current_Language"), txtPrice.Text.Trim))
            objHPRateBO.PHP_PRICE = txtPrice.Text.Trim
            If LTrim(RTrim(txtCost.Text)) <> "" Then
                'objHPRateBO.PHP_COST = Val(NumCurrencyConverter.GetDefaultNoFormat(Session("Current_Language"), txtCost.Text.Trim))
                objHPRateBO.PHP_COST = txtCost.Text.Trim
            Else
                objHPRateBO.PHP_COST = 0
            End If
            objHPRateBO.PFLG_TAKE_MECHNIC_COST = chkMechnaicCode.Checked
            objHPRateBO.PHP_ACC_CODE = CType(IIf(txtAccountCode.Text.Trim = "", Nothing, txtAccountCode.Text.Trim), String)
            objHPRateBO.PCREATED_BY = loginName
            objHPRateBO.PMODIFIED_BY = loginName
            objHPRateBO.PHP_VAT = cmbVAT.Value
        Catch ex As Exception
            Dim oErrHandle As New MSGCOMMON.MsgErrorHndlr
            oErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "PopulateBO", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub cbHPDetails_Callback(sender As Object, e As CallbackEventArgsBase)
        If hdnHPMode.Value = "Add" Then
            PopulateScreenAdd()
        ElseIf hdnHPMode.Value = "Edit" Then
            Dim intHPID As String = hdnHPSeqId.Value
            PopulateScreen(intHPID)
        End If

    End Sub

    Private Sub PopulateScreen(intHPID As Integer)
        Try
            FetchAllddValues()
            Dim objHPRateBO As New HPRateBO
            objHPRateBO = objHPRate.Fetch_Rate(intHPID)

            cmbDepartmentCode.Value = objHPRateBO.PID_DEPT_HP.ToString

            If (IsNothing(objHPRateBO.PID_MAKE_HP) = False) Then
                cmbMake.Value = objHPRateBO.PID_MAKE_HP
                cmbMake.Enabled = False
            Else
                cmbMake.SelectedIndex = 0
                cmbMake.Enabled = False
            End If

            If (IsNothing(objHPRateBO.PID_MECHPCD_HP) = False) Then
                cmbMechanicPriceCode.Value = objHPRateBO.PID_MECHPCD_HP
                cmbMechanicPriceCode.Enabled = False
            Else
                cmbMechanicPriceCode.SelectedIndex = 0
                cmbMechanicPriceCode.Enabled = False
            End If
            If (IsNothing(objHPRateBO.PID_RPPCD_HP) = False) Then
                cmbRPPriceCode.Value = objHPRateBO.PID_RPPCD_HP
                cmbRPPriceCode.Enabled = False
            Else
                cmbRPPriceCode.SelectedIndex = 0
                cmbRPPriceCode.Enabled = False
            End If


            If (IsNothing(objHPRateBO.PID_CUSTPCD_HP) = False) Then
                cmbCustomerPriceCode.Value = objHPRateBO.PID_CUSTPCD_HP
            Else
                cmbCustomerPriceCode.SelectedIndex = 0
            End If

            If (IsNothing(objHPRateBO.PID_VEHGRP_HP) = False) Then
                cmbVehicleGroup.Value = objHPRateBO.PID_VEHGRP_HP
                cmbVehicleGroup.Enabled = False
            Else
                cmbVehicleGroup.SelectedIndex = 0
                cmbVehicleGroup.Enabled = False
            End If


            If (IsNothing(objHPRateBO.PID_JOBPCD_HP) = False) Then
                cmbPriceCodeOnJob.Value = objHPRateBO.PID_JOBPCD_HP
                cmbPriceCodeOnJob.Enabled = False
            Else
                cmbPriceCodeOnJob.SelectedIndex = 0
                cmbPriceCodeOnJob.Enabled = False
            End If

            If (IsNothing(objHPRateBO.PHP_VAT) = False) Then
                cmbVAT.Value = objHPRateBO.PHP_VAT
            Else
                cmbVAT.SelectedIndex = 0
            End If

            txtTextforLabour.Text = objHPRateBO.PINV_LABOR_TEXT
            txtPrice.Text = objHPRateBO.PHP_PRICE.ToString

            If objHPRateBO.PFLG_TAKE_MECHNIC_COST Then
                txtCost.Text = ""
                txtCost.Enabled = False
                chkMechnaicCode.Checked = objHPRateBO.PFLG_TAKE_MECHNIC_COST
            Else
                txtCost.Text = IIf(objHPRateBO.PHP_COST = Nothing, "", objHPRateBO.PHP_COST).ToString
                txtCost.Enabled = True
                chkMechnaicCode.Checked = objHPRateBO.PFLG_TAKE_MECHNIC_COST
            End If

            txtAccountCode.Text = objHPRateBO.PHP_ACC_CODE

        Catch ex As Exception
            Dim oErrHandle As New MSGCOMMON.MsgErrorHndlr
            oErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "PopulateScreen", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Private Sub PopulateScreenAdd()
        Try
            FetchAllddValues()

            cmbDepartmentCode.SelectedIndex = 0

            cmbMake.SelectedIndex = 0
            cmbMake.Enabled = True

            cmbMechanicPriceCode.SelectedIndex = 0
            cmbMechanicPriceCode.Enabled = True

            cmbRPPriceCode.SelectedIndex = 0
            cmbRPPriceCode.Enabled = True

            cmbCustomerPriceCode.SelectedIndex = 0
            cmbCustomerPriceCode.Enabled = True

            cmbVehicleGroup.SelectedIndex = 0
            cmbVehicleGroup.Enabled = True

            cmbPriceCodeOnJob.SelectedIndex = 0
            cmbPriceCodeOnJob.Enabled = True

            cmbVAT.SelectedIndex = 0
            cmbVAT.Enabled = True

            txtTextforLabour.Text = ""
            txtPrice.Text = ""
            txtCost.Text = ""
            chkMechnaicCode.Checked = False
            txtAccountCode.Text = ""
            txtCost.Enabled = True
        Catch ex As Exception
            Dim oErrHandle As New MSGCOMMON.MsgErrorHndlr
            oErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "PopulateScreenAdd", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub cbSaveHPDetails_Callback(source As Object, e As CallbackEventArgs)
        Try
            Dim cbparam As String = e.Parameter
            Dim strResult As String = String.Empty
            cbSaveHPDetails.JSProperties("cpSaveStrResult") = Nothing
            cbSaveHPDetails.JSProperties("cpDelStrResult") = Nothing
            If cbparam = "SAVE" Then
                If hdnHPMode.Value = "Add" Then
                    PopulateBO()
                    strResult = objHPRate.Add_Rate(objHPRateBO)
                ElseIf hdnHPMode.Value = "Edit" Then
                    objHPRateBO.PID_HP_SEQ = hdnHPSeqId.Value
                    PopulateBO()
                    strResult = objHPRate.Update_Rate(objHPRateBO)
                End If
                cbSaveHPDetails.JSProperties("cpSaveStrResult") = strResult
            ElseIf cbparam = "DELETE" Then
                Dim deleteXML As String = ""
                Dim selectedItems As New List(Of Object)
                selectedItems = gvHourlyPrice.GetSelectedFieldValues("ID_HP_SEQ")
                For i = 0 To selectedItems.Count - 1

                    deleteXML += "<HP ID_HP_SEQ=""" + selectedItems(i).ToString + """/>"
                Next
                If deleteXML = "" Then Exit Sub
                deleteXML = "<ROOT>" + deleteXML + "</ROOT>"

                Dim strDeleted As String = ""
                Dim strCannotDeleted As String = ""
                Dim result As String = objHPRate.Delete_Rate(deleteXML, strDeleted, strCannotDeleted)
                cbSaveHPDetails.JSProperties("cpDelStrResult") = result
            End If


        Catch ex As Exception
            Dim oErrHandle As New MSGCOMMON.MsgErrorHndlr
            oErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "cbSaveHPDetails_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Sub FetchAllGridData()
        Dim dsHPConfig As New DataSet
        Dim dtHPConfig As New DataTable
        Try
            dsHPConfig = objConfigSettingsDO.Fetch_HPConfiguration()
            If dsHPConfig.Tables.Count > 0 Then
                If (dsHPConfig.Tables(0).Rows.Count > 0) Then
                    dtHPConfig = dsHPConfig.Tables(0)
                    gvPrCodeCust.DataSource = dtHPConfig
                    gvPrCodeCust.DataBind()
                End If

                If (dsHPConfig.Tables(1).Rows.Count > 0) Then
                    dtHPConfig = dsHPConfig.Tables(1)
                    gvPrCodeRpkg.DataSource = dtHPConfig
                    gvPrCodeRpkg.DataBind()
                End If

                If (dsHPConfig.Tables(2).Rows.Count > 0) Then
                    dtHPConfig = dsHPConfig.Tables(2)
                    gvPrCodeJob.DataSource = dtHPConfig
                    gvPrCodeJob.DataBind()
                End If

                If (dsHPConfig.Tables(3).Rows.Count > 0) Then
                    dtHPConfig = dsHPConfig.Tables(3)
                    gvPrCodeMech.DataSource = dtHPConfig
                    gvPrCodeMech.DataBind()
                End If
                If (dsHPConfig.Tables(4).Rows.Count > 0) Then
                    dtHPConfig = dsHPConfig.Tables(4)
                    gvPrCodeMake.DataSource = dtHPConfig
                    gvPrCodeMake.DataBind()
                End If
                If (dsHPConfig.Tables(5).Rows.Count > 0) Then
                    dtHPConfig = dsHPConfig.Tables(5)
                    gvPrCodeVehGrp.DataSource = dtHPConfig
                    gvPrCodeVehGrp.DataBind()
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchAllGridData", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Sub FetchPCOnCustValue()
        Dim dsHPConfig As New DataSet
        Dim dtHPConfig As New DataTable
        Try
            dsHPConfig = objConfigSettingsDO.Fetch_HPConfiguration()
            If dsHPConfig.Tables.Count > 0 Then
                dtHPConfig = dsHPConfig.Tables(0)
                gvPrCodeCust.DataSource = dtHPConfig
                gvPrCodeCust.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchPCOnCustValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub gvPrCodeCust_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Dim strXMLDocMasAdd As String = ""
        Dim strXMLDocMasAdds As String = ""
        Dim strXMLDocMasUpd As String = ""
        Dim strXMLDocMasUpds As String = ""
        Dim strXMLDocMasDel As String = ""
        Dim strXMLDocMasDels As String = ""
        Dim strResult As String()
        gvPrCodeCust.JSProperties("cpRetValSave") = New List(Of ConfigSettingsBO)()
        gvPrCodeCust.JSProperties("cpRetValDel") = {}
        Try
            For Each item In e.InsertValues
                strXMLDocMasAdd = ""
                strXMLDocMasAdd = "<insert ID_CONFIG=""" + "HP-CU-PC" + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasAdds += strXMLDocMasAdd
            Next
            If (e.InsertValues.Count > 0) Then
                strXMLDocMasAdds = "<root>" + strXMLDocMasAdds + "</root>"
                details = commonUtil.AddConfigDetails(strXMLDocMasAdds)
                gvPrCodeCust.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If
            For Each item In e.UpdateValues
                strXMLDocMasUpd = ""
                strXMLDocMasUpd = "<MODIFY ID_CONFIG=""" + "HP-CU-PC" + """ ID_SETTINGS=""" + item.Keys(0).ToString + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasUpds += strXMLDocMasUpd
            Next
            If (e.UpdateValues.Count > 0) Then
                strXMLDocMasUpds = "<ROOT>" + strXMLDocMasUpds + "</ROOT>"
                details = commonUtil.UpdateConfigDetails(strXMLDocMasUpds)
                gvPrCodeCust.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If

            For Each item In e.DeleteValues
                strXMLDocMasDel = ""
                strXMLDocMasDel = "<delete><HP-CU-PC ID_SETTINGS= """ + item.Keys(0).ToString + """ ID_CONFIG=""" + "HP-CU-PC" + """ DESCRIPTION= """ + item.Values("DESCRIPTION") + """/></delete>"
                strXMLDocMasDels += strXMLDocMasDel
            Next
            If (e.DeleteValues.Count > 0) Then
                strXMLDocMasDels = "<root>" + strXMLDocMasDels + "</root>"
                strResult = objConfigHPServ.DeleteConfig(strXMLDocMasDels)
                gvPrCodeCust.JSProperties("cpRetValDel") = strResult
            End If
            FetchPCOnCustValue()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "gvPrCodeCust_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub FetchPCOnRpkgValue()
        Dim dsHPConfig As New DataSet
        Dim dtHPConfig As New DataTable
        Try
            dsHPConfig = objConfigSettingsDO.Fetch_HPConfiguration()
            If dsHPConfig.Tables.Count > 0 Then
                dtHPConfig = dsHPConfig.Tables(1)
                gvPrCodeRpkg.DataSource = dtHPConfig
                gvPrCodeRpkg.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchPCOnRpkgValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub gvPrCodeRpkg_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Dim strXMLDocMasAdd As String = ""
        Dim strXMLDocMasAdds As String = ""
        Dim strXMLDocMasUpd As String = ""
        Dim strXMLDocMasUpds As String = ""
        Dim strXMLDocMasDel As String = ""
        Dim strXMLDocMasDels As String = ""
        Dim strResult As String()
        gvPrCodeRpkg.JSProperties("cpRetValSave") = New List(Of ConfigSettingsBO)()
        gvPrCodeRpkg.JSProperties("cpRetValDel") = {}
        Try
            For Each item In e.InsertValues
                strXMLDocMasAdd = ""
                strXMLDocMasAdd = "<insert ID_CONFIG=""" + "HP-RP-PC" + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasAdds += strXMLDocMasAdd
            Next
            If (e.InsertValues.Count > 0) Then
                strXMLDocMasAdds = "<root>" + strXMLDocMasAdds + "</root>"
                details = commonUtil.AddConfigDetails(strXMLDocMasAdds)
                gvPrCodeRpkg.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If
            For Each item In e.UpdateValues
                strXMLDocMasUpd = ""
                strXMLDocMasUpd = "<MODIFY ID_CONFIG=""" + "HP-RP-PC" + """ ID_SETTINGS=""" + item.Keys(0).ToString + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasUpds += strXMLDocMasUpd
            Next
            If (e.UpdateValues.Count > 0) Then
                strXMLDocMasUpds = "<ROOT>" + strXMLDocMasUpds + "</ROOT>"
                details = commonUtil.UpdateConfigDetails(strXMLDocMasUpds)
                gvPrCodeRpkg.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If

            For Each item In e.DeleteValues
                strXMLDocMasDel = ""
                strXMLDocMasDel = "<delete><HP-RP-PC ID_SETTINGS= """ + item.Keys(0).ToString + """ ID_CONFIG=""" + "HP-CU-PC" + """ DESCRIPTION= """ + item.Values("DESCRIPTION") + """/></delete>"
                strXMLDocMasDels += strXMLDocMasDel
            Next
            If (e.DeleteValues.Count > 0) Then
                strXMLDocMasDels = "<root>" + strXMLDocMasDels + "</root>"
                strResult = objConfigHPServ.DeleteConfig(strXMLDocMasDels)
                gvPrCodeRpkg.JSProperties("cpRetValDel") = strResult
            End If
            FetchPCOnRpkgValue()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "gvPrCodeRpkg_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub FetchPCOnJobValue()
        Dim dsHPConfig As New DataSet
        Dim dtHPConfig As New DataTable
        Try
            dsHPConfig = objConfigSettingsDO.Fetch_HPConfiguration()
            If dsHPConfig.Tables.Count > 0 Then
                dtHPConfig = dsHPConfig.Tables(2)
                gvPrCodeJob.DataSource = dtHPConfig
                gvPrCodeJob.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchPCOnJobValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub gvPrCodeJob_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Dim strXMLDocMasAdd As String = ""
        Dim strXMLDocMasAdds As String = ""
        Dim strXMLDocMasUpd As String = ""
        Dim strXMLDocMasUpds As String = ""
        Dim strXMLDocMasDel As String = ""
        Dim strXMLDocMasDels As String = ""
        Dim strResult As String()
        gvPrCodeJob.JSProperties("cpRetValSave") = New List(Of ConfigSettingsBO)()
        gvPrCodeJob.JSProperties("cpRetValDel") = {}
        Try
            For Each item In e.InsertValues
                strXMLDocMasAdd = ""
                strXMLDocMasAdd = "<insert ID_CONFIG=""" + "HP-JOB-PC" + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasAdds += strXMLDocMasAdd
            Next
            If (e.InsertValues.Count > 0) Then
                strXMLDocMasAdds = "<root>" + strXMLDocMasAdds + "</root>"
                details = commonUtil.AddConfigDetails(strXMLDocMasAdds)
                gvPrCodeJob.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If
            For Each item In e.UpdateValues
                strXMLDocMasUpd = ""
                strXMLDocMasUpd = "<MODIFY ID_CONFIG=""" + "HP-JOB-PC" + """ ID_SETTINGS=""" + item.Keys(0).ToString + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasUpds += strXMLDocMasUpd
            Next
            If (e.UpdateValues.Count > 0) Then
                strXMLDocMasUpds = "<ROOT>" + strXMLDocMasUpds + "</ROOT>"
                details = commonUtil.UpdateConfigDetails(strXMLDocMasUpds)
                gvPrCodeJob.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If

            For Each item In e.DeleteValues
                strXMLDocMasDel = ""
                strXMLDocMasDel = "<delete><HP-JOB-PC ID_SETTINGS= """ + item.Keys(0).ToString + """ ID_CONFIG=""" + "HP-CU-PC" + """ DESCRIPTION= """ + item.Values("DESCRIPTION") + """/></delete>"
                strXMLDocMasDels += strXMLDocMasDel
            Next
            If (e.DeleteValues.Count > 0) Then
                strXMLDocMasDels = "<root>" + strXMLDocMasDels + "</root>"
                strResult = objConfigHPServ.DeleteConfig(strXMLDocMasDels)
                gvPrCodeJob.JSProperties("cpRetValDel") = strResult
            End If
            FetchPCOnJobValue()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "gvPrCodeJob_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub FetchPCOnMechValue()
        Dim dsHPConfig As New DataSet
        Dim dtHPConfig As New DataTable
        Try
            dsHPConfig = objConfigSettingsDO.Fetch_HPConfiguration()
            If dsHPConfig.Tables.Count > 0 Then
                dtHPConfig = dsHPConfig.Tables(3)
                gvPrCodeMech.DataSource = dtHPConfig
                gvPrCodeMech.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchPCOnMechValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub gvPrCodeMech_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Dim strXMLDocMasAdd As String = ""
        Dim strXMLDocMasAdds As String = ""
        Dim strXMLDocMasUpd As String = ""
        Dim strXMLDocMasUpds As String = ""
        Dim strXMLDocMasDel As String = ""
        Dim strXMLDocMasDels As String = ""
        Dim strResult As String()
        gvPrCodeMech.JSProperties("cpRetValSave") = New List(Of ConfigSettingsBO)()
        gvPrCodeMech.JSProperties("cpRetValDel") = {}
        Try
            For Each item In e.InsertValues
                strXMLDocMasAdd = ""
                strXMLDocMasAdd = "<insert ID_CONFIG=""" + "HP-MEC-PC" + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasAdds += strXMLDocMasAdd
            Next
            If (e.InsertValues.Count > 0) Then
                strXMLDocMasAdds = "<root>" + strXMLDocMasAdds + "</root>"
                details = commonUtil.AddConfigDetails(strXMLDocMasAdds)
                gvPrCodeMech.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If
            For Each item In e.UpdateValues
                strXMLDocMasUpd = ""
                strXMLDocMasUpd = "<MODIFY ID_CONFIG=""" + "HP-MEC-PC" + """ ID_SETTINGS=""" + item.Keys(0).ToString + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasUpds += strXMLDocMasUpd
            Next
            If (e.UpdateValues.Count > 0) Then
                strXMLDocMasUpds = "<ROOT>" + strXMLDocMasUpds + "</ROOT>"
                details = commonUtil.UpdateConfigDetails(strXMLDocMasUpds)
                gvPrCodeMech.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If

            For Each item In e.DeleteValues
                strXMLDocMasDel = ""
                strXMLDocMasDel = "<delete><HP-MEC-PC ID_SETTINGS= """ + item.Keys(0).ToString + """ ID_CONFIG=""" + "HP-CU-PC" + """ DESCRIPTION= """ + item.Values("DESCRIPTION") + """/></delete>"
                strXMLDocMasDels += strXMLDocMasDel
            Next
            If (e.DeleteValues.Count > 0) Then
                strXMLDocMasDels = "<root>" + strXMLDocMasDels + "</root>"
                strResult = objConfigHPServ.DeleteConfig(strXMLDocMasDels)
                gvPrCodeMech.JSProperties("cpRetValDel") = strResult
            End If
            FetchPCOnMechValue()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "gvPrCodeMech_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub FetchPCOnMakeValue()
        Dim dsHPConfig As New DataSet
        Dim dtHPConfig As New DataTable
        Try
            dsHPConfig = objConfigSettingsDO.Fetch_HPConfiguration()
            If dsHPConfig.Tables.Count > 0 Then
                dtHPConfig = dsHPConfig.Tables(4)
                gvPrCodeMake.DataSource = dtHPConfig
                gvPrCodeMake.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchPCOnMakeValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub gvPrCodeMake_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Dim strXMLDocMasAdd As String = ""
        Dim strXMLDocMasAdds As String = ""
        Dim strXMLDocMasUpd As String = ""
        Dim strXMLDocMasUpds As String = ""
        Dim strXMLDocMasDel As String = ""
        Dim strXMLDocMasDels As String = ""
        Dim strResult As String()
        gvPrCodeMake.JSProperties("cpRetValSave") = New List(Of ConfigSettingsBO)()
        gvPrCodeMake.JSProperties("cpRetValDel") = {}
        Try
            For Each item In e.InsertValues
                strXMLDocMasAdd = ""
                strXMLDocMasAdd = "<insert ID_CONFIG=""" + "HP-MAKE-PC" + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasAdds += strXMLDocMasAdd
            Next
            If (e.InsertValues.Count > 0) Then
                strXMLDocMasAdds = "<root>" + strXMLDocMasAdds + "</root>"
                details = commonUtil.AddConfigDetails(strXMLDocMasAdds)
                gvPrCodeMake.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If
            For Each item In e.UpdateValues
                strXMLDocMasUpd = ""
                strXMLDocMasUpd = "<MODIFY ID_CONFIG=""" + "HP-MAKE-PC" + """ ID_SETTINGS=""" + item.Keys(0).ToString + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasUpds += strXMLDocMasUpd
            Next
            If (e.UpdateValues.Count > 0) Then
                strXMLDocMasUpds = "<ROOT>" + strXMLDocMasUpds + "</ROOT>"
                details = commonUtil.UpdateConfigDetails(strXMLDocMasUpds)
                gvPrCodeMake.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If

            For Each item In e.DeleteValues
                strXMLDocMasDel = ""
                strXMLDocMasDel = "<delete><HP-MAKE-PC ID_SETTINGS= """ + item.Keys(0).ToString + """ ID_CONFIG=""" + "HP-CU-PC" + """ DESCRIPTION= """ + item.Values("DESCRIPTION") + """/></delete>"
                strXMLDocMasDels += strXMLDocMasDel
            Next
            If (e.DeleteValues.Count > 0) Then
                strXMLDocMasDels = "<root>" + strXMLDocMasDels + "</root>"
                strResult = objConfigHPServ.DeleteConfig(strXMLDocMasDels)
                gvPrCodeMake.JSProperties("cpRetValDel") = strResult
            End If
            FetchPCOnMakeValue()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "gvPrCodeMake_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub FetchPCOnVehGrpValue()
        Dim dsHPConfig As New DataSet
        Dim dtHPConfig As New DataTable
        Try
            dsHPConfig = objConfigSettingsDO.Fetch_HPConfiguration()
            If dsHPConfig.Tables.Count > 0 Then
                dtHPConfig = dsHPConfig.Tables(5)
                gvPrCodeVehGrp.DataSource = dtHPConfig
                gvPrCodeVehGrp.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "FetchPCOnVehGrpValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub gvPrCodeVehGrp_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Dim strXMLDocMasAdd As String = ""
        Dim strXMLDocMasAdds As String = ""
        Dim strXMLDocMasUpd As String = ""
        Dim strXMLDocMasUpds As String = ""
        Dim strXMLDocMasDel As String = ""
        Dim strXMLDocMasDels As String = ""
        Dim strResult As String()
        gvPrCodeVehGrp.JSProperties("cpRetValSave") = New List(Of ConfigSettingsBO)()
        gvPrCodeVehGrp.JSProperties("cpRetValDel") = {}
        Try
            For Each item In e.InsertValues
                strXMLDocMasAdd = ""
                strXMLDocMasAdd = "<insert ID_CONFIG=""" + "HP-VHG-PC" + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasAdds += strXMLDocMasAdd
            Next
            If (e.InsertValues.Count > 0) Then
                strXMLDocMasAdds = "<root>" + strXMLDocMasAdds + "</root>"
                details = commonUtil.AddConfigDetails(strXMLDocMasAdds)
                gvPrCodeVehGrp.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If
            For Each item In e.UpdateValues
                strXMLDocMasUpd = ""
                strXMLDocMasUpd = "<MODIFY ID_CONFIG=""" + "HP-VHG-PC" + """ ID_SETTINGS=""" + item.Keys(0).ToString + """ DESCRIPTION=""" + item.NewValues("DESCRIPTION").Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMasUpds += strXMLDocMasUpd
            Next
            If (e.UpdateValues.Count > 0) Then
                strXMLDocMasUpds = "<ROOT>" + strXMLDocMasUpds + "</ROOT>"
                details = commonUtil.UpdateConfigDetails(strXMLDocMasUpds)
                gvPrCodeVehGrp.JSProperties("cpRetValSave") = details.ToList.ToArray()
            End If

            For Each item In e.DeleteValues
                strXMLDocMasDel = ""
                strXMLDocMasDel = "<delete><HP-VHG-PC ID_SETTINGS= """ + item.Keys(0).ToString + """ ID_CONFIG=""" + "HP-CU-PC" + """ DESCRIPTION= """ + item.Values("DESCRIPTION") + """/></delete>"
                strXMLDocMasDels += strXMLDocMasDel
            Next
            If (e.DeleteValues.Count > 0) Then
                strXMLDocMasDels = "<root>" + strXMLDocMasDels + "</root>"
                strResult = objConfigHPServ.DeleteConfig(strXMLDocMasDels)
                gvPrCodeVehGrp.JSProperties("cpRetValDel") = strResult
            End If
            FetchPCOnVehGrpValue()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfHourlyPrice", "gvPrCodeVehGrp_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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