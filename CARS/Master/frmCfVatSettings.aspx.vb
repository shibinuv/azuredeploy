Imports System.Data
Imports Encryption
Imports MSGCOMMON
Imports System.Web.Services
Imports CARS.CoreLibrary.CARS
Imports CARS.CoreLibrary
Imports System.Web.UI
Imports CARS.CoreLibrary.CARS.Services
Imports System.Reflection
Imports Newtonsoft.Json
Imports DevExpress.Web
Imports System.Globalization
Imports System.Threading

Public Class frmCfVatSettings
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared loginName As String
    Shared objItemsDO As New ItemsDO
    Shared objSupService As New CARS.CoreLibrary.CARS.Services.Supplier.SupplierDetail
    Shared objItemsBO As New ItemsBO
    Shared objItemsService As New CARS.CoreLibrary.CARS.Services.Items.ItemsDetail
    Shared objConfigSettingsDO As New CoreLibrary.CARS.ConfigSettings.ConfigSettingsDO
    Shared objConfigWODO As New CoreLibrary.CARS.ConfigWorkOrder.ConfigWorkOrderDO
    Shared objConfigGenServ As New Services.ConfigGeneral.ConfigGeneral
    Shared commonUtil As New Utilities.CommonUtility
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If

            loginName = HttpContext.Current.Session("UserID")
            EnableViewState = False

            hdnPageSize.Value = System.Configuration.ConfigurationManager.AppSettings("PageSize")

            Session("Select") = GetLocalResourceObject("genSelect")
            cbVatCode.SelectedIndex = 0
            BindSpCatgGrid()
            LoadVatCodeSettings()
            LoadVatCodeGrid()
            If Not IsCallback Then
                LoadVatSettingsComboboxes()
                LoadVatCodes()
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Private Sub BindSpCatgGrid()
        Dim dsSpCatgDet As New DataSet
        Try
            dsSpCatgDet = objItemsDO.LoadSparePartCategory()
            HttpContext.Current.Session("SparePartCategory") = dsSpCatgDet
            gvSpCatgConfig.DataSource = dsSpCatgDet
            gvSpCatgConfig.DataBind()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "BindSpCatgGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub

    Public Sub LoadVatCodes()

        Dim dsVatCodesDet As New DataSet
        Try
            dsVatCodesDet = objItemsDO.Fetch_VATCode()
            HttpContext.Current.Session("VatCodes") = dsVatCodesDet

            If (dsVatCodesDet.Tables(0).Rows.Count > 0) Then
                cbVatCode.DataSource = dsVatCodesDet.Tables(0)
                cbVatCode.ValueField = "ID_SETTINGS"
                cbVatCode.TextField = "DESCRIPTION"
                cbVatCode.DataBind()
            End If
            cbVatCode.Items.Insert(0, New ListEditItem(Session("Select"), "0"))


        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "LoadVatCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Protected Sub spCatgGrid_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            spCatgGrid.JSProperties("cpDelStrVal") = {}
            spCatgGrid.JSProperties("cpSaveStrVal") = {}
            Dim str As String = cbVatCode.Value
            Dim suppCurr As String = txtSupplierSearch.Value
            Dim strRes As String()
            Dim strVal As String = ""
            Dim cbParam As String = e.Parameter
            Dim cbParams As String() = cbParam.Split(";")
            If cbParams.Length > 0 Then
                If cbParams(0) = "DELETE" Then
                    objItemsBO.ID_ITEM_CATG = cbParams(1)
                    strRes = objItemsService.DeleteSpCatgDetails(objItemsBO.ID_ITEM_CATG)
                    spCatgGrid.JSProperties("cpDelStrVal") = strRes

                ElseIf cbParams(0) = "SAVE" Then

                    spCatgGrid.JSProperties("cpDelStrVal") = ""
                    objItemsBO.ID_ITEM_DISC_CODE_BUYING = Nothing
                    objItemsBO.ID_ITEM_DISC_CODE_SELL = Nothing
                    objItemsBO.ID_SUPPLIER_ITEM = IIf(hdnSupplierId.Value = "0", Nothing, hdnSupplierId.Value)
                    objItemsBO.SUPP_CURRENTNO = IIf(hdnSuppCurrNo.Value = "0", Nothing, hdnSuppCurrNo.Value)
                    objItemsBO.ID_MAKE = Nothing
                    objItemsBO.CATEGORY = txtCatg.Value.ToString()
                    objItemsBO.DESCRIPTION = txtDesc.Value.ToString()
                    objItemsBO.INITIALCLASSCODE = Nothing
                    objItemsBO.ID_VAT_CODE = IIf(hdnVatCodeId.Value = "0", Nothing, hdnVatCodeId.Value)
                    objItemsBO.ACCOUNT_CODE = txtAccntCode.Value.ToString()
                    objItemsBO.FLG_ALLOW_BCKORD = chkAllBO.Checked
                    objItemsBO.FLG_CNT_STOCK = chkCntStock.Checked
                    objItemsBO.FLG_ALLOW_CLASSIFICATION = chkAllClass.Checked
                    objItemsBO.CREATED_BY = loginName
                    objItemsBO.ID_ITEM_CATG = hdnSpCatgId.Value

                    If (hdnMode.Value = "Edit" And hdnSpCatgId.Value > 0) Then
                        'strRes = objItemsService.UpdSpCatgDetails(objItemsBO)
                        strRes = objItemsService.UpdSpareCategoryDetails(objItemsBO)
                        spCatgGrid.JSProperties("cpSaveStrVal") = strRes
                    ElseIf hdnMode.Value = "Add" Then
                        strRes = objItemsService.AddSpCatgDetails(objItemsBO)
                        spCatgGrid.JSProperties("cpSaveStrVal") = strRes
                    End If


                End If
            End If


            'Reload the grid again
            BindSpCatgGrid()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "spCatgGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function Supplier_Search(ByVal q As String) As SupplierBO()
        Dim spareDetails As New List(Of SupplierBO)()
        Try
            spareDetails = objSupService.Supplier_Search(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "Supplier_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function GetSpCatgDetails(ByVal idItemCatg As String) As Microsoft.VisualBasic.Collection
        Dim details As New Microsoft.VisualBasic.Collection
        Try
            details = objItemsService.GetSparePartCategoryDetails(idItemCatg)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "GetSpCatgDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details
    End Function

    Public Sub LoadVatCodeSettings()
        Try
            Dim dsConfig As New DataSet
            dsConfig = objConfigSettingsDO.Fetch_VATCodes()
            gvVatSettings.DataSource = dsConfig
            gvVatSettings.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "LoadVatCodeSettings", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Public Sub LoadVatSettingsComboboxes()
        Try
            Dim dsListData As DataSet = objConfigWODO.GetDisListData()
            ddlVATCodeCustGrp.DataSource = dsListData.Tables(2)
            ddlVATCodeCustGrp.ValueField = "ID_SETTINGS"
            ddlVATCodeCustGrp.TextField = "DESCRIPTION"
            ddlVATCodeCustGrp.DataBind()

            ddlVATCodeOrdLine.DataSource = dsListData.Tables(2)
            ddlVATCodeOrdLine.ValueField = "ID_SETTINGS"
            ddlVATCodeOrdLine.TextField = "DESCRIPTION"
            ddlVATCodeOrdLine.DataBind()

            ddlVATCodeProdGrp.DataSource = dsListData.Tables(2)
            ddlVATCodeProdGrp.ValueField = "ID_SETTINGS"
            ddlVATCodeProdGrp.TextField = "DESCRIPTION"
            ddlVATCodeProdGrp.DataBind()

            ddlVATCodeVeh.DataSource = dsListData.Tables(2)
            ddlVATCodeVeh.ValueField = "ID_SETTINGS"
            ddlVATCodeVeh.TextField = "DESCRIPTION"
            ddlVATCodeVeh.DataBind()

            ddlVATCodeCustGrp.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
            ddlVATCodeOrdLine.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
            ddlVATCodeProdGrp.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
            ddlVATCodeVeh.Items.Insert(0, New ListEditItem(Session("Select"), "0"))

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "LoadVatSettingsComboboxes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Protected Sub cbVatSettingGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim mode As String = hdnMode.Value
            Dim strXMLDoc As String
            Dim strRes As String() = {}
            Dim objWOServ As New Services.ConfigWO.ConfigWorkOrder
            Dim cbParams() As String = e.Parameter.Split(";")
            cbVatSettingGrid.JSProperties("cpVatCodeRetStr") = strRes
            If cbParams.Count > 0 Then

                If cbParams(0) = "SAVE" Then
                    Dim vatCodeId As String = hdnVatCodeId.Value

                    Dim vatcodeoncust As String = ddlVATCodeCustGrp.Value
                    Dim vatcodeonordline As String = ddlVATCodeOrdLine.Text

                    Dim vatcodeonveh As String = IIf(ddlVATCodeVeh.Value = "0", "", ddlVATCodeVeh.Value)
                    Dim vatcodeonitem As String = IIf(ddlVATCodeProdGrp.Value = "0", "", ddlVATCodeProdGrp.Value)
                    Dim vatacccode As String = txtAccountCode.Text

                    If (mode = "Add") Then
                        strXMLDoc = ""
                        strXMLDoc = "<VAT><VAT_ITEM>" + vatcodeonitem.ToString() + "</VAT_ITEM><VAT_CUAST>" + vatcodeoncust.ToString() + "</VAT_CUAST><VAT_VEH>" + vatcodeonveh.ToString() + "</VAT_VEH><VAT_PER>" + vatcodeonordline.ToString() + "</VAT_PER><CREATED_BY>" + loginName.ToString() + "</CREATED_BY><ACCOUNTCODE>" + vatacccode.ToString() + "</ACCOUNTCODE></VAT>"
                        strXMLDoc = "<ROOT>" + strXMLDoc + "</ROOT>"
                        strRes = objWOServ.SaveVATCode(strXMLDoc)
                    Else
                        strXMLDoc = ""
                        strXMLDoc = "<VAT><ID_VAT_SEQ>" + vatCodeId.ToString() + "</ID_VAT_SEQ><VAT_ITEM>" + vatcodeonitem.ToString() + "</VAT_ITEM><VAT_CUAST>" + vatcodeoncust.ToString() + "</VAT_CUAST><VAT_VEH>" + vatcodeonveh.ToString() + "</VAT_VEH><VAT_PER>" + vatcodeonordline.ToString() + "</VAT_PER><ACCOUNTCODE>" + vatacccode.ToString() + "</ACCOUNTCODE></VAT>"
                        strXMLDoc = "<ROOT>" + strXMLDoc + "</ROOT>"
                        strRes = objWOServ.UpdateVATCode(strXMLDoc)
                    End If
                ElseIf cbParams(0) = "DELETE" Then
                    Dim vatCodeIdxml = ""
                    Dim vatCodeIdxmls = ""
                    If (cbParams.Count > 1) Then
                        Dim vatCodeId As String = cbParams(1)
                        vatCodeIdxml = "<VAT><ID_VAT_SEQ>" + vatCodeId + "</ID_VAT_SEQ></VAT>"
                        vatCodeIdxmls = "<ROOT>" + vatCodeIdxml + "</ROOT>"
                        strRes = objWOServ.DeleteVATCode(vatCodeIdxmls)
                    End If
                End If

                cbVatSettingGrid.JSProperties("cpVatCodeRetStr") = strRes
            End If

            LoadVatCodeSettings()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "cbVatSettingGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Sub LoadVatCodeGrid()
        Dim configDetails As New DataSet
        Try
            configDetails = objConfigSettingsDO.Fetch_TRConfiguration(HttpContext.Current.Session("UserID").ToString(), "DISCD", "VAT", "LEAVE_RESN", Nothing, Nothing)
            gvVatCode.DataSource = configDetails.Tables(1)
            gvVatCode.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "LoadVatCodeGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub cbVatCodeGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim mode As String = hdnMode.Value
            Dim strXMLDocMas As String
            Dim strRes As String() = {}
            Dim configdetails As New List(Of ConfigSettingsBO)()
            Dim cbParams() As String = e.Parameter.Split(";")
            cbVatCodeGrid.JSProperties("cpVatCodeDelStr") = strRes
            cbVatCodeGrid.JSProperties("cpVatCodeSaveStr") = Nothing
            If cbParams.Count > 0 Then

                If cbParams(0) = "SAVE" Then
                    Dim vatCodeId As String = hdnVatCodeId.Value
                    Dim vatcode As String = txtVATCode.Text
                    Dim vatper As String = hdnVatPercent.Value
                    Dim extvatcode As String = IIf(txtExtVAT.Text.Trim = "", "0", txtExtVAT.Text)
                    Dim extvataccntcode As String = txtExtAcc.Text

                    If (mode = "Add") Then

                        strXMLDocMas = ""
                        strXMLDocMas = "<insert ID_CONFIG=""" + "VAT" + """ DESCRIPTION=""" + vatcode.Trim + """ VAT_PERCENTAGE=""" + vatper + """ EXT_VAT_CODE=""" + extvatcode + """ EXT_ACC_CODE=""" + extvataccntcode + """/>"
                        strXMLDocMas = "<root>" + strXMLDocMas + "</root>"
                        configdetails = commonUtil.AddConfigDetails(strXMLDocMas)

                    Else

                        strXMLDocMas = ""
                        strXMLDocMas = "<MODIFY ID_CONFIG=""" + "VAT" + """ ID_SETTINGS=""" + vatCodeId + """ DESCRIPTION=""" + vatcode.Trim + """ VAT_PERCENTAGE=""" + vatper + """ EXT_VAT_CODE=""" + extvatcode + """ EXT_ACC_CODE=""" + extvataccntcode + """/>"
                        strXMLDocMas = "<ROOT>" + strXMLDocMas + "</ROOT>"
                        configdetails = commonUtil.UpdateConfigDetails(strXMLDocMas)

                    End If

                    cbVatCodeGrid.JSProperties("cpVatCodeSaveStr") = configdetails
                ElseIf cbParams(0) = "DELETE" Then

                    Dim vatCodeIdxml = ""
                    Dim vatCodeIdxmls = ""
                    If (cbParams.Count > 1) Then
                        Dim vatCodeId As String = cbParams(1)
                        Dim descList = gvVatCode.GetSelectedFieldValues({"DESCRIPTION", "ID_SETTINGS"})

                        If descList.Count > 0 Then

                            Dim query = (From items In descList
                                         Where items(1).ToString = vatCodeId).ToArray()
                            If query.Count > 0 Then
                                Dim description As String = query(0)(0)
                                vatCodeIdxml = "<delete><VAT ID_SETTINGS= """ + vatCodeId + """ ID_CONFIG= """ + "VAT" + """ DESCRIPTION= """ + description + """/></delete>"
                                vatCodeIdxmls = "<root>" + vatCodeIdxml + "</root>"
                                strRes = commonUtil.DeleteConfig(vatCodeIdxmls)
                            End If
                        End If
                    End If
                End If

                cbVatCodeGrid.JSProperties("cpVatCodeDelStr") = strRes
            End If

            LoadVatCodeGrid()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmCfVatSettings", "cbVatSettingGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
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
    Protected Sub cbVatCodeSettings_Callback(sender As Object, e As CallbackEventArgsBase)
        LoadVatSettingsComboboxes()
    End Sub

    Protected Sub cbSpCategory_Callback(sender As Object, e As CallbackEventArgsBase)
        LoadVatCodes()
    End Sub
End Class