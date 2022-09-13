Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports System.Drawing
Imports System.Web.Script.Serialization.JavaScriptSerializer
Imports System.Object
Imports System.MarshalByRefObject
Imports System.Net.WebRequest
Imports System.Net.HttpWebRequest
Imports System.Net.HttpWebResponse
Imports System.Net
Imports System.Web
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls.WebParts
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS.Services
Imports Encryption
Imports MSGCOMMON
Imports System.Web.Services
Imports System.Threading
Imports System.Globalization
Imports CARS.CoreLibrary.CARS
Imports Newtonsoft.Json
Imports System.Reflection
Imports DevExpress.Web
Imports DevExpress.Web.Internal

Public Class SupplierDetail
    Inherits System.Web.UI.Page
    Shared ddLangName As String = "ctl00$cntMainPanel$Language" 'Localization
    Public Const PostBackEventTarget As String = "__EVENTTARGET" 'Localization
    Shared objSupService As New CARS.CoreLibrary.CARS.Services.Supplier.SupplierDetail
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared loginName As String
    Shared objSupBo As New SupplierBO
    Dim _calculatePrice As New CalcPriceBO
    Shared uploadsDirectory As String = ""
    Shared fileName As String = ""
    Const logFileFolder As String = "SupplierImportLog"
    Dim newlog As DirectoryInfo
    Dim logfilepath As String = String.Empty
    Dim max As Integer = 100000
    Dim builder As StringBuilder = New StringBuilder(max)
    Dim serverdate As String
    Dim servertime As String
    Dim priceFileLangConfig As String
    Dim _flgImpFail As Boolean = True
    'Localization start ##############################################
    'Protected Overrides Sub InitializeCulture()
    '    Dim selectedValue As String
    '    Dim lang As String = Request.Form("Language")
    '    If Request(PostBackEventTarget) <> "" Then
    '        Dim controlID As String = Request(PostBackEventTarget)
    '        If controlID.Equals(ddLangName) Then
    '            selectedValue = Request.Form(Request(PostBackEventTarget))
    '            Select Case selectedValue
    '                Case "0"
    '                    SetCulture("nb-NO", "nb-NO")
    '                Case "1"
    '                    SetCulture("en-GB", "nb-NO")
    '                Case "2"
    '                    SetCulture("de-DE", "nb-NO")
    '                Case Else
    '            End Select
    '            If Session("MyUICulture").ToString <> "" And Session("MyCulture").ToString <> "" Then
    '                Thread.CurrentThread.CurrentUICulture = CType(Session.Item("MyUICulture"), CultureInfo)
    '                Thread.CurrentThread.CurrentCulture = CType(Session.Item("MyCulture"), CultureInfo)
    '            End If
    '        End If
    '    End If
    '    MyBase.InitializeCulture()
    'End Sub
    'Protected Sub SetCulture(name As String, locale As String)
    '    Thread.CurrentThread.CurrentUICulture = New CultureInfo(name)
    '    Thread.CurrentThread.CurrentCulture = New CultureInfo(locale)
    '    Session("MyUICulture") = Thread.CurrentThread.CurrentUICulture
    '    Session("MyCulture") = Thread.CurrentThread.CurrentCulture
    'End Sub

    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (Session("culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(Session("culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci
        End If
    End Sub



    'Localization end #################################################

    'Protected Sub cbCheckedChange(sender As Object, e As EventArgs)
    '    If cbPrivOrSub.Checked = True Then
    '        txtCompany.Visible = False
    '    Else
    '        txtCompany.Visible = True
    '    End If
    'End Sub


    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        EnableViewState = False
        'txtSellPrice.JSProperties("cpDecimalSeperator") = Configuration
        uploadsDirectory = ConfigurationManager.AppSettings("UploadsFolder")
        'priceFileLangConfig = ConfigurationManager.AppSettings("PriceFileLangConfig")
        If Not IsPostBack Then
            Session("Select") = GetLocalResourceObject("ddItemSelect")
            'LoadWareHouse(loginName)
            LoadWareHouse(Session("UserID"))
            ddlClassCodeFrom.Items.Add(New ListEditItem(Session("Select"), 0))
            ddlClassCodeTo.Items.Add(New ListEditItem(Session("Select"), 0))
            ddlCatFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            ddlCatTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            ddlLocationFrom.Items.Add(New ListEditItem(Session("Select"), 0))
            ddlLocationTo.Items.Add(New ListEditItem(Session("Select"), 0))
            ddlDiscountCodeFrom.Items.Add(New ListEditItem(Session("Select"), 0))
            ddlDiscountCodeTo.Items.Add(New ListEditItem(Session("Select"), 0))
            ddlClassCodeFrom.SelectedIndex = 0
            ddlClassCodeTo.SelectedIndex = 0
            ddlCatFrom.SelectedIndex = 0
            ddlCatTo.SelectedIndex = 0
            ddlLocationFrom.SelectedIndex = 0
            ddlLocationTo.SelectedIndex = 0
            ddlDiscountCodeFrom.SelectedIndex = 0
            ddlDiscountCodeTo.SelectedIndex = 0
            ddlWarehouseFrom.SelectedIndex = 0
            ddlWarehouseTo.SelectedIndex = 0

            ddlSparePartGroup.Items.Add(New ListEditItem(Session("Select"), 0))
            ddlSparePartGroup.SelectedIndex = 0
        End If
        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            loginName = CType(Session("UserID"), String)
        End If

        Try
            Dim strscreenName As String
            Dim dtCaption As DataTable
            loginName = CType(Session("UserID"), String)
            If Not IsPostBack Then
                dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)
                strscreenName = IO.Path.GetFileName(Me.Request.PhysicalPath)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "master_Customer_Details", "Page_Load", ex.Message, loginName)
        End Try
    End Sub


    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function Supplier_Search(ByVal q As String) As SupplierBO()
        Dim spareDetails As New List(Of SupplierBO)()
        Try
            spareDetails = objSupService.Supplier_Search(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "Customer_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function FetchSupplierDetail(ByVal ID_SUPPLIER As String)
        Dim supplierDetail As New SupplierBO
        Dim supplierRes As New List(Of SupplierBO)
        supplierDetail.ID_SUPPLIER = ID_SUPPLIER

        Try
            supplierRes = objSupService.Fetch_Supplier_Detail(supplierDetail)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return supplierRes.ToList.ToArray
        'Return JsonConvert.SerializeObject(itemsRes)
    End Function

    <WebMethod()>
    Public Shared Function FetchCurrencyDetail(ByVal CURRENCY_CODE As String)
        Dim currDetail As New SupplierBO
        Dim currRes As New SupplierBO
        currDetail.CURRENCY_CODE = CURRENCY_CODE

        Try
            currRes = objSupService.Fetch_Currency_Detail(currDetail)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return currRes
        'Return JsonConvert.SerializeObject(itemsRes)
    End Function

    <WebMethod()>
    Public Shared Function getDiscountData(ByVal SUPP_CURRENTNO As String, ByVal ID_ORDERTYPE As String) As SupplierBO()
        Dim discountDetail As New SupplierBO
        Dim discountRes As New List(Of SupplierBO)()

        discountDetail.SUPP_CURRENTNO = SUPP_CURRENTNO
        discountDetail.ID_ORDERTYPE = ID_ORDERTYPE

        Try
            discountRes = objSupService.getDiscountData(discountDetail)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return discountRes.ToList.ToArray

    End Function

    <WebMethod()>
    Public Shared Function getDiscountCodes(ByVal id As String) As SupplierBO()
        Dim discountcodes As New List(Of SupplierBO)()
        Try
            discountcodes = objSupService.getDiscountCodes(id)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return discountcodes.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function InsertSupplier(ByVal Supplier As String) As String()
        Dim strResult As String()
        Dim dsReturnValStr As String = ""
        Dim sup As SupplierBO = JsonConvert.DeserializeObject(Of SupplierBO)(Supplier)
        Try
            Console.WriteLine(sup.ID_SUPPLIER)
            strResult = objSupService.Insert_Supplier(sup)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function saveDiscountCode(ByVal discountcode As String, ByVal description As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""

        Try

            strResult = objSupService.saveDiscountCode(discountcode, description)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function saveOrderType(ByVal ordertype As String, ByVal description As String, ByVal pricetype As String, ByVal supplier As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""

        Try

            strResult = objSupService.saveOrderType(ordertype, description, pricetype, supplier, loginName)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function saveDiscount(ByVal discountcode As String, ByVal id_ordertype As String, ByVal suppcurrentno As String, ByVal discountpercentage As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""

        Try

            strResult = objSupService.saveDiscount(discountcode, id_ordertype, suppcurrentno, discountpercentage)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function deleteDiscount(ByVal discountcode As String, ByVal ordertype As String, ByVal supplier As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""

        Try

            strResult = objSupService.deleteDiscount(discountcode, ordertype, supplier)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function deleteDiscountCode(ByVal discountcode As String, ByVal supplier As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""
        Try
            strResult = objSupService.deleteDiscountCode(discountcode, supplier)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function Currency_Search(ByVal q As String) As SupplierBO()
        Dim currencyDetails As New List(Of SupplierBO)()
        Try
            currencyDetails = objSupService.Currency_Search(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "Customer_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return currencyDetails.ToList.ToArray
    End Function

    Private Sub LoadWareHouse(ByVal loginName As String)
        Try
            ddlWarehouseFrom.Items.Clear()
            ddlWarehouseTo.Items.Clear()

            _calculatePrice.Login = loginName
            Dim warehouse As DataSet = _calculatePrice.FetchWarehouse()
            If (warehouse.Tables.Count > 0) Then
                warehouse.Tables(0).TableName = "WareHouse"
            End If
            If (warehouse.Tables("WareHouse").Rows.Count > 0) Then

                ddlWarehouseFrom.DataSource = warehouse.Tables("WareHouse")
                ddlWarehouseFrom.ValueField = "WH_Name"
                ddlWarehouseFrom.TextField = "WH_Name"
                ddlWarehouseFrom.DataBind()

                ddlWarehouseTo.DataSource = warehouse.Tables("WareHouse")
                ddlWarehouseTo.ValueField = "WH_Name"
                ddlWarehouseTo.TextField = "WH_Name"
                ddlWarehouseTo.DataBind()

                ddlWarehouseTo.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
                ddlWarehouseFrom.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub cbPriceCalculation_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Dim callbackParam As String = e.Parameter
        Dim callbackParams() = callbackParam.Split(";")
        If (callbackParams(0) = "LOCAL") Then
            Try
                'LoadWareHouse(Session("UserID"))
                'ddlWarehouseTo.SelectedValue = ddlWarehouseFrom.SelectedValue
                If ddlWarehouseFrom.SelectedIndex = 0 Then
                    txtSellPrice.Text = ""
                    txtCostPrice.Text = ""
                    txtBasicPrice.Text = ""
                    txtNetPrice.Text = ""
                    txtSellPrice.Enabled = False
                    txtCostPrice.Enabled = False
                    txtBasicPrice.Enabled = False
                    txtNetPrice.Enabled = False

                    SparePartTextClear()
                ElseIf Not ddlWarehouseFrom.SelectedIndex = 0 Then
                    'LoadCategory(Nothing, callbackParams(1), callbackParams(1))
                    ddlWarehouseTo.Focus()
                    SparePartTextClear()
                End If

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "SupplierDetails", "cbPriceCalculation_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
            End Try
        End If
        If (callbackParams(0) = "LOAD_CLASSCODE") Then
            Try
                ddlCatTo.Value = ddlCatFrom.Value
                If rbCalculateGlobal.Checked Then
                    'LoadDiscountCodeBuyGlobal()
                    'ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "", "focusJS('" & txtSparePartNoFrom.ClientID & "');", True)
                ElseIf rbCalculateLocal.Checked Then
                    'LoadCategory(Nothing, ddlWarehouseFrom.Text, ddlWarehouseTo.Text)
                    SparePartTextClear()
                End If
            Catch exth As System.Threading.ThreadAbortException
                Throw exth
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "SupplierDetails", "cbPriceCalculation_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
            End Try
        End If

    End Sub
    Private Sub SparePartTextClear()
        txtPartNoFrom.Text = ""
        'txtCustTempPassword.Text = ""
        txtPartNoTo.Text = ""
    End Sub
    ''' <summary>
    ''' Gets Category from Local SparePart
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub LoadCategory(ByVal suppCurrNo As String, ByVal warehouseNameFrom As String, ByVal warehouseNameTo As String)
        Try
            ddlCatFrom.Items.Clear()
            ddlCatTo.Items.Clear()

            '_calculatePrice.MakeID = makeID  IIf(ddlCatFrom.Text = Session("Select") Or ddlCatFrom.Text = "", Nothing, ddlCatFrom.Text)
            _calculatePrice.SuppCurrNo = IIf(suppCurrNo = "" Or suppCurrNo = Nothing, Nothing, suppCurrNo.Trim)
            _calculatePrice.WarehouseNameFrom = warehouseNameFrom
            _calculatePrice.WarehouseNameTo = warehouseNameTo
            Dim category As DataSet = _calculatePrice.GetCategory()

            If (category.Tables.Count > 0) Then
                category.Tables(0).TableName = "Category"
            End If
            If (category.Tables("Category").Rows.Count > 0) Then
                ddlCatFrom.DataSource = category
                ddlCatFrom.ValueField = "ID_SPCATEGORY"
                ddlCatFrom.TextField = "CATEGORY"
                ddlCatFrom.DataBind()

                ddlCatTo.DataSource = category
                ddlCatTo.ValueField = "ID_SPCATEGORY"
                ddlCatTo.TextField = "CATEGORY"
                ddlCatTo.DataBind()
            End If
            ddlCatTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            ddlCatFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetails", "LoadCategory", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
        End Try
    End Sub
    Private Sub LoadClassCode(classCodeIdFrom As String, classCodeIdTo As String)
        Try
            _calculatePrice = New CalcPriceBO
            ddlClassCodeFrom.Items.Clear()
            ddlClassCodeTo.Items.Clear()

            If rbCalculateLocal.Checked Then
                If ddlWarehouseFrom.SelectedIndex <= 0 Then
                    _calculatePrice.WarehouseNameFrom = Nothing
                Else
                    _calculatePrice.WarehouseNameFrom = ddlWarehouseFrom.SelectedItem.Text
                End If
                If ddlWarehouseTo.SelectedIndex <= 0 Then
                    _calculatePrice.WarehouseNameTo = Nothing
                Else
                    _calculatePrice.WarehouseNameTo = ddlWarehouseTo.SelectedItem.Text
                End If
            End If
            '_calculatePrice.MakeID = IIf(ddlMake.SelectedIndex = 0, Nothing, ddlMake.SelectedItem.Text)
            '_calculatePrice.MakeID = Nothing 'IIf(ddlMake.SelectedIndex = 0, Nothing, ddlMake.SelectedItem.Value)

            _calculatePrice.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)
            _calculatePrice.CategoryIDFrom = IIf(ddlCatFrom.Text = Session("Select") Or ddlCatFrom.Text = "", Nothing, ddlCatFrom.Text)
            _calculatePrice.CategoryIDTo = IIf(ddlCatTo.Text = Session("Select") Or ddlCatTo.Text = "", Nothing, ddlCatTo.Text)
            '_calculatePrice.SparePartIDFrom = IIf(txtPartNoFrom.Text = Nothing, Nothing, txtPartNoFrom.Text)
            '_calculatePrice.SparePartIDTo = IIf(txtPartNoTo.Text = Nothing, Nothing, txtPartNoTo.Text)
            _calculatePrice.SparePartIDFrom = IIf(classCodeIdFrom = "", Nothing, classCodeIdFrom)
            _calculatePrice.SparePartIDTo = IIf(classCodeIdTo = "", Nothing, classCodeIdFrom)
            Dim classCode As DataSet = _calculatePrice.GetClassCode()
            If (classCode.Tables.Count > 0) Then
                If (classCode.Tables.Count = 1) Then
                    classCode.Tables(0).TableName = "ClassCode"
                Else
                    classCode.Tables(1).TableName = "ClassCode" 'Changed to Table(1) from table(0)
                End If

                If (classCode.Tables("ClassCode").Rows.Count > 0) Then
                    ddlClassCodeFrom.DataSource = classCode.Tables("ClassCode") 'Added Table(1)
                    ddlClassCodeFrom.ValueField = "Class_Code"
                    ddlClassCodeFrom.TextField = "Class_Code"
                    ddlClassCodeFrom.DataBind()

                    ddlClassCodeTo.DataSource = classCode.Tables("ClassCode") 'Added Table(1)
                    ddlClassCodeTo.ValueField = "Class_Code"
                    ddlClassCodeTo.TextField = "Class_Code"
                    ddlClassCodeTo.DataBind()

                End If

            End If
            ddlClassCodeFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            ddlClassCodeTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetails", "LoadClassCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
        End Try
    End Sub

    Private Sub LoadLocation()
        Try
            ddlLocationFrom.Items.Clear()
            ddlLocationTo.Items.Clear()


            '_calculatePrice.WarehouseNameFrom = IIf(ddlWareHouseFrom.SelectedIndex = 0, Nothing, ddlWareHouseFrom.SelectedItem.Text)
            '_calculatePrice.WarehouseNameTo = IIf(ddlWareHouseTo.SelectedIndex = 0, Nothing, ddlWareHouseTo.SelectedItem.Text)
            If ddlWarehouseFrom.SelectedIndex <= 0 Then
                _calculatePrice.WarehouseNameFrom = Nothing
            Else
                _calculatePrice.WarehouseNameFrom = ddlWarehouseFrom.SelectedItem.Text
            End If
            If ddlWarehouseTo.SelectedIndex <= 0 Then
                _calculatePrice.WarehouseNameTo = Nothing
            Else
                _calculatePrice.WarehouseNameTo = ddlWarehouseTo.SelectedItem.Text
            End If
            '_calculatePrice.MakeID = IIf(ddlMake.SelectedIndex = 0, Nothing, ddlMake.SelectedItem.Text)
            '_calculatePrice.MakeID = Nothing 'IIf(ddlMake.SelectedIndex = 0, Nothing, ddlMake.SelectedItem.Value)

            _calculatePrice.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)
            _calculatePrice.CategoryIDFrom = IIf(ddlCatFrom.Text = Session("Select") Or ddlCatFrom.Text = "", Nothing, ddlCatFrom.Text)
            _calculatePrice.CategoryIDTo = IIf(ddlCatTo.Text = Session("Select") Or ddlCatTo.Text = "", Nothing, ddlCatTo.Text)
            _calculatePrice.SparePartIDFrom = IIf(txtPartNoFrom.Text = Nothing, Nothing, txtPartNoFrom.Text)
            _calculatePrice.SparePartIDTo = IIf(txtPartNoTo.Text = Nothing, Nothing, txtPartNoTo.Text)
            _calculatePrice.ClassCodeIDFrom = IIf(ddlClassCodeFrom.Text = Session("Select") Or ddlClassCodeFrom.Text = "", Nothing, ddlClassCodeFrom.Value)
            _calculatePrice.ClassCodeIDTo = IIf(ddlClassCodeTo.Text = Session("Select") Or ddlClassCodeTo.Text = "", Nothing, ddlClassCodeTo.Value)

            Dim location As DataSet = _calculatePrice.GetLocation()
            If (location.Tables.Count > 0) Then
                location.Tables(0).TableName = "Location"
                If (location.Tables("Location").Rows.Count > 0) Then
                    ddlLocationFrom.DataSource = location
                    ddlLocationFrom.ValueField = "LOCATION"
                    ddlLocationFrom.TextField = "LOCATION"
                    ddlLocationFrom.DataBind()

                    ddlLocationTo.DataSource = location
                    ddlLocationTo.ValueField = "LOCATION"
                    ddlLocationTo.TextField = "LOCATION"
                    ddlLocationTo.DataBind()

                End If
            End If
            ddlLocationFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            ddlLocationTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetails", "LoadLocation", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
        End Try
    End Sub

    Private Sub LoadDiscountCodeBuy()
        Try
            ddlDiscountCodeFrom.Items.Clear()
            ddlDiscountCodeTo.Items.Clear()

            If rbCalculateLocal.Checked Then
                '_calculatePrice.WarehouseNameFrom = IIf(ddlWareHouseFrom.SelectedIndex = 0, Nothing, ddlWareHouseFrom.SelectedItem.Text)
                '_calculatePrice.WarehouseNameTo = IIf(ddlWareHouseTo.SelectedIndex = 0, Nothing, ddlWareHouseTo.SelectedItem.Text)
                If ddlWarehouseFrom.SelectedIndex <= 0 Then
                    _calculatePrice.WarehouseNameFrom = Nothing
                Else
                    _calculatePrice.WarehouseNameFrom = ddlWarehouseFrom.SelectedItem.Text
                End If
                If ddlWarehouseTo.SelectedIndex <= 0 Then
                    _calculatePrice.WarehouseNameTo = Nothing
                Else
                    _calculatePrice.WarehouseNameTo = ddlWarehouseTo.SelectedItem.Text
                End If
                _calculatePrice.ClassCodeIDFrom = IIf(ddlClassCodeFrom.Text = Session("Select") Or ddlClassCodeFrom.Value = "0", Nothing, ddlClassCodeFrom.Value)
                _calculatePrice.ClassCodeIDTo = IIf(ddlClassCodeTo.Text = Session("Select") Or ddlClassCodeTo.Value = "0", Nothing, ddlClassCodeTo.Value)
                _calculatePrice.LocationFrom = IIf(ddlLocationFrom.Text = Session("Select") Or ddlLocationFrom.Value = "0", Nothing, ddlLocationFrom.Value)
                _calculatePrice.LocationTo = IIf(ddlLocationTo.Text = Session("Select") Or ddlLocationTo.Value = "0", Nothing, ddlLocationTo.Value)
            End If
            ' _calculatePrice.MakeID = Nothing 'IIf(ddlMake.SelectedIndex = 0, Nothing, ddlMake.SelectedItem.Value)
            _calculatePrice.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)
            _calculatePrice.CategoryIDFrom = IIf(ddlCatFrom.Text = Session("Select") Or ddlCatFrom.Text = Session("Select"), Nothing, ddlCatFrom.Text)
            _calculatePrice.CategoryIDTo = IIf(ddlCatTo.Text = Session("Select") Or ddlCatTo.Text = Session("Select"), Nothing, ddlCatTo.Text)
            _calculatePrice.SparePartIDFrom = IIf(txtPartNoFrom.Text = Nothing, Nothing, txtPartNoFrom.Text)
            _calculatePrice.SparePartIDTo = IIf(txtPartNoTo.Text = Nothing, Nothing, txtPartNoTo.Text)

            Dim discountCodeBuy As DataSet = _calculatePrice.GetDiscountCodeBuy()
            If (discountCodeBuy.Tables.Count > 0) Then
                discountCodeBuy.Tables(0).TableName = "DisccodeBuy"

                If (discountCodeBuy.Tables("DisccodeBuy").Rows.Count > 0) Then
                    ddlDiscountCodeFrom.DataSource = discountCodeBuy
                    ddlDiscountCodeFrom.ValueField = "DISCOUNTCODE" 'Changed from ID_DISCOUNTCODE to DISCOUNTCODE
                    ddlDiscountCodeFrom.TextField = "DISCOUNTCODE"
                    ddlDiscountCodeFrom.DataBind()

                    ddlDiscountCodeTo.DataSource = discountCodeBuy
                    ddlDiscountCodeTo.ValueField = "DISCOUNTCODE"  'Changed from ID_DISCOUNTCODE to DISCOUNTCODE
                    ddlDiscountCodeTo.TextField = "DISCOUNTCODE"
                    ddlDiscountCodeTo.DataBind()

                End If
            End If
            ddlDiscountCodeFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            ddlDiscountCodeTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetails", "LoadDiscountCodeBuy", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
        End Try
    End Sub

    Private Sub LoadDiscountCodeBuyGlobal()
        Try
            ddlDiscountCodeFrom.Items.Clear()
            ddlDiscountCodeTo.Items.Clear()

            '_calculatePrice.MakeID = Nothing 'IIf(ddlMake.SelectedIndex = 0, Nothing, ddlMake.SelectedItem.Value)

            _calculatePrice.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)
            _calculatePrice.CategoryIDFrom = IIf(ddlCatFrom.Text = Session("Select"), Nothing, ddlCatFrom.Text)
            _calculatePrice.CategoryIDTo = IIf(ddlCatTo.Text = Session("Select"), Nothing, ddlCatTo.Text)
            _calculatePrice.SparePartIDFrom = IIf(txtPartNoFrom.Text = Nothing, Nothing, txtPartNoFrom.Text)
            _calculatePrice.SparePartIDTo = IIf(txtPartNoTo.Text = Nothing, Nothing, txtPartNoTo.Text)

            Dim discountCodeBuyGlobal As DataSet = _calculatePrice.GetDiscountCodeBuyGlobal()
            If (discountCodeBuyGlobal.Tables.Count > 0) Then
                discountCodeBuyGlobal.Tables(0).TableName = "DisCodeBuyGlobal"

                If (discountCodeBuyGlobal.Tables("DisCodeBuyGlobal").Rows.Count > 0) Then
                    ddlDiscountCodeFrom.DataSource = discountCodeBuyGlobal
                    ddlDiscountCodeFrom.ValueField = "ITEM_DISC_CODE_BUY"
                    ddlDiscountCodeFrom.TextField = "ITEM_DISC_CODE_BUY"
                    ddlDiscountCodeFrom.DataBind()

                    ddlDiscountCodeTo.DataSource = discountCodeBuyGlobal
                    ddlDiscountCodeTo.ValueField = "ITEM_DISC_CODE_BUY"
                    ddlDiscountCodeTo.TextField = "ITEM_DISC_CODE_BUY"
                    ddlDiscountCodeTo.DataBind()

                    discountCodeBuyGlobal.Clear()
                End If
                ddlDiscountCodeFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
                ddlDiscountCodeTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetails", "LoadDiscountCodeBuyGlobal", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
        End Try
    End Sub

    Protected Sub ddlWarehouseFrom_Init1(sender As Object, e As EventArgs)
        ' If Not IsPostBack Then
        LoadWareHouse(Session("UserID"))
        'LoadCategory(Nothing, ddlWarehouseFrom.SelectedItem.Text, ddlWarehouseTo.SelectedItem.Text)
        ' End If
    End Sub

    Protected Sub ddlCatFrom_Init(sender As Object, e As EventArgs)
        If (Not ddlWarehouseFrom.SelectedItem Is Nothing) Then
            LoadCategory(Nothing, ddlWarehouseFrom.SelectedItem.Text, ddlWarehouseTo.SelectedItem.Text)
        End If

    End Sub

    Protected Sub cbCategoryLoad_Callback(sender As Object, e As CallbackEventArgsBase)
        Dim callbackParam As String = e.Parameter
        Dim callbackParams() = callbackParam.Split(";")
        If (callbackParams(0) = "LOCAL") Then
            Try
                'LoadWareHouse(Session("UserID"))
                'ddlWarehouseTo.SelectedValue = ddlWarehouseFrom.SelectedValue
                If ddlWarehouseFrom.SelectedIndex = 0 Then
                    txtSellPrice.Text = ""
                    txtCostPrice.Text = ""
                    txtBasicPrice.Text = ""
                    txtNetPrice.Text = ""
                    txtSellPrice.Enabled = False
                    txtCostPrice.Enabled = False
                    txtBasicPrice.Enabled = False
                    txtNetPrice.Enabled = False
                    ddlCatFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
                    ddlCatTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
                    SparePartTextClear()
                ElseIf Not ddlWarehouseFrom.SelectedIndex = 0 Then
                    'LoadCategory(Nothing, callbackParams(1), callbackParams(1))

                    LoadCategory(hdnSuppCurNo.Text, ddlWarehouseFrom.SelectedItem.Text, ddlWarehouseTo.SelectedItem.Text)
                    ddlWarehouseTo.Focus()
                    SparePartTextClear()
                End If

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "SupplierDetails", "cbCategoryLoad_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
            End Try
        ElseIf (callbackParams(0) = "GLOBAL") Then
            Try
                ddlCatFrom.Items.Clear()
                ddlCatTo.Items.Clear()

                '_calculatePrice.MakeID = Nothing 'IIf(ddlMake.SelectedIndex = 0, Nothing, ddlMake.SelectedItem.Value)
                _calculatePrice.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)
                Dim categoryGlobal As DataSet = _calculatePrice.GetCategoryGlobal()

                If (categoryGlobal.Tables.Count > 0) Then
                    categoryGlobal.Tables(0).TableName = "CategoryGlobal"
                End If
                If (categoryGlobal.Tables("CategoryGlobal").Rows.Count > 0) Then
                    ddlCatFrom.DataSource = categoryGlobal
                    ddlCatFrom.ValueField = "ID_ITEM_CATG"
                    ddlCatFrom.TextField = "CATG_DESC"
                    ddlCatFrom.DataBind()

                    ddlCatTo.DataSource = categoryGlobal
                    ddlCatTo.ValueField = "ID_ITEM_CATG"
                    ddlCatTo.TextField = "CATG_DESC"
                    ddlCatTo.DataBind()

                End If
                ddlCatFrom.Items.Insert(0, New ListEditItem(Session("Select"), 0))
                ddlCatTo.Items.Insert(0, New ListEditItem(Session("Select"), 0))
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "SupplierDetails", "cbCategoryLoad_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
            End Try
        End If

    End Sub

    Protected Sub cbPartNoLoad_Callback(sender As Object, e As CallbackEventArgsBase)

    End Sub

    Protected Sub cbClassCode_Callback(sender As Object, e As CallbackEventArgsBase)
        Dim callbackParam As String = e.Parameter
        Dim callbackParams() = callbackParam.Split(";")
        If (callbackParams(0) = "LOAD_CLASSCODE") Then
            Try
                'ddlCatTo.Value = ddlCatFrom.Value
                If rbCalculateGlobal.Checked Then
                    'LoadDiscountCodeBuyGlobal()
                    'ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "", "focusJS('" & txtSparePartNoFrom.ClientID & "');", True)
                ElseIf rbCalculateLocal.Checked Then
                    'LoadCategory(Nothing, ddlWarehouseFrom.Text, ddlWarehouseTo.Text)
                    SparePartTextClear()
                    LoadClassCode(callbackParams(1), callbackParams(2))
                End If
            Catch exth As System.Threading.ThreadAbortException
                Throw exth
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "SupplierDetails", "cbPriceCalculation_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
                'Throw ex
            End Try
        End If
    End Sub

    Protected Sub cbStartCalculation_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim isSuccess As Boolean
            Dim errorMessage As String
            Dim count As Integer = 0
            Dim message As String

            '_calculatePrice.MakeID = Nothing

            _calculatePrice.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)
            _calculatePrice.CategoryIDFrom = IIf(ddlCatFrom.Text = Session("Select"), Nothing, ddlCatFrom.Text)
            _calculatePrice.CategoryIDTo = IIf(ddlCatTo.Text = Session("Select"), Nothing, ddlCatTo.Text)
            _calculatePrice.SparePartIDFrom = IIf(txtPartNoFrom.Text = Nothing, Nothing, txtPartNoFrom.Text)
            _calculatePrice.SparePartIDTo = IIf(txtPartNoTo.Text = Nothing, Nothing, txtPartNoTo.Text)
            _calculatePrice.DiscountCodeBuyingFrom = IIf(ddlDiscountCodeFrom.Text = Session("Select"), Nothing, ddlDiscountCodeFrom.Text)
            _calculatePrice.DiscountCodeBuyingTo = IIf(ddlDiscountCodeTo.Text = Session("Select"), Nothing, ddlDiscountCodeTo.Text)

            _calculatePrice.MarkupSellingPrice = IIf(txtSellPrice.Text = Nothing Or txtSellPrice.Text = "", 0D, txtSellPrice.Text)
            _calculatePrice.MarkupCostPrice = IIf(txtCostPrice.Text = Nothing Or txtCostPrice.Text = "", 0D, txtCostPrice.Text)
            _calculatePrice.MarkupNetPrice = IIf(txtNetPrice.Text = Nothing Or txtNetPrice.Text = "", 0D, txtNetPrice.Text)
            _calculatePrice.MarkupBasicPrice = IIf(txtBasicPrice.Text = Nothing Or txtBasicPrice.Text = "", 0D, txtBasicPrice.Text)

            _calculatePrice.IsAdjustCost = False 'IIf(chkAdjCostPrice.Checked, True, False)
            _calculatePrice.IsAdjustSP = False 'IIf(chkAdjSellPrice.Checked, True, False)

            _calculatePrice.IsRounding = IIf(Not rbRounding.Checked, False, rbRounding.Checked)
            _calculatePrice.IsRounding50 = IIf(Not rbRoundingToClosest50.Checked, False, rbRoundingToClosest50.Checked)

            '_calculatePrice.RoundingRules = IIf(txtRoundRules.Text = Nothing, 0, txtRoundRules.Text)
            '_calculatePrice.CostPriceFrom = IIf(rdoSellPrice.Checked, "SELLING PRICE", "BASIC PRICE")

            _calculatePrice.IsCalculationBlocked = IIf(cbCalculateBlockedArticle.Checked, True, False)

            _calculatePrice.CreatedBy = Session("UserName")
            _calculatePrice.ModifiedBy = Session("UserName")

            message = "CalcPrice"

            If (rbCalculateGlobal.Checked) Then
                _calculatePrice.SparePartNoCheck("GLOBAL")
                lblError.ForeColor = Drawing.Color.Red
                If (_calculatePrice.ErrorMessageFrom = Nothing And _calculatePrice.ErrorMessageTo = Nothing) Then
                    ' Calls function that calculates and saves Global SparePart prices
                    _calculatePrice.UpdateGlobalSparePart()

                ElseIf _calculatePrice.ErrorMessageFrom = "Out of Range From" And _calculatePrice.ErrorMessageTo = "Out of Range To" Then
                    lblError.Text = GetLocalResourceObject("GenSpNotExist")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageFrom = "Out of Range From" Then
                    lblError.Text = GetLocalResourceObject("GenSpNoExFro")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageTo = "Out of Range To" Then
                    lblError.Text = GetLocalResourceObject("GenSpNoExTo")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageFrom = "Invalid item From" And _calculatePrice.ErrorMessageTo = "Invalid item To" Then
                    lblError.Text = GetLocalResourceObject("GenSpInvalid")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageFrom = "Invalid item From" Then
                    lblError.Text = GetLocalResourceObject("GenSpInvFro")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageTo = "Invalid item To" Then
                    lblError.Text = GetLocalResourceObject("GenSpInvTo")
                    Exit Sub
                End If
            Else
                _calculatePrice.WarehouseNameFrom = IIf(ddlWarehouseFrom.SelectedIndex <= 0, Nothing, ddlWarehouseFrom.SelectedItem.Text)
                _calculatePrice.WarehouseNameTo = IIf(ddlWarehouseTo.SelectedIndex <= 0, Nothing, ddlWarehouseTo.SelectedItem.Text)
                _calculatePrice.ClassCodeIDFrom = IIf(ddlClassCodeFrom.Text = Session("Select") Or ddlClassCodeFrom.Value = "0", Nothing, ddlClassCodeFrom.Value)
                _calculatePrice.ClassCodeIDTo = IIf(ddlClassCodeTo.Text = Session("Select") Or ddlClassCodeTo.Value = "0", Nothing, ddlClassCodeTo.Value)
                _calculatePrice.LocationFrom = IIf(ddlLocationFrom.Text = Session("Select") Or ddlLocationFrom.Value = "0", Nothing, ddlLocationFrom.Value)
                _calculatePrice.LocationTo = IIf(ddlLocationTo.Text = Session("Select") Or ddlLocationTo.Value = "0", Nothing, ddlLocationTo.Value)

                _calculatePrice.SparePartNoCheck("LOCAL")
                lblError.ForeColor = Drawing.Color.Red
                If (_calculatePrice.ErrorMessageFrom = Nothing And _calculatePrice.ErrorMessageTo = Nothing) Then
                    ' Calls function that calculates and saves Local SparePart prices
                    _calculatePrice.UpdateLocalSparePart()
                ElseIf _calculatePrice.ErrorMessageFrom = "Out of Range From" And _calculatePrice.ErrorMessageTo = "Out of Range To" Then
                    lblError.Text = GetLocalResourceObject("GenSpNotExist")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageFrom = "Out of Range From" Then
                    lblError.Text = GetLocalResourceObject("GenSpNoExFro")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageTo = "Out of Range To" Then
                    lblError.Text = GetLocalResourceObject("GenSpNoExTo")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageFrom = "Invalid item From" And _calculatePrice.ErrorMessageTo = "Invalid item To" Then
                    lblError.Text = GetLocalResourceObject("GenSpInvalid")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageFrom = "Invalid item From" Then
                    lblError.Text = GetLocalResourceObject("GenSpInvFro")
                    Exit Sub
                ElseIf _calculatePrice.ErrorMessageTo = "Invalid item To" Then
                    lblError.Text = GetLocalResourceObject("GenSpInvTo")
                    Exit Sub
                End If
            End If


            'Maintains the boolean value whether the calculation successfull or not
            isSuccess = _calculatePrice.Success
            'Maintains error message in case of failure
            errorMessage = _calculatePrice.ErrorMessage
            count = _calculatePrice.CountValue

            'Displays appropriate message
            If (isSuccess) Then
                If (rbCalculateGlobal.Checked And count > 0) Then
                    lblError.ForeColor = Drawing.Color.Green
                    lblError.Text = count.ToString() + " " + GetLocalResourceObject("GenSavedSucessGlobal")
                ElseIf (count = 0) Then
                    lblError.ForeColor = Drawing.Color.Green
                    lblError.Text = GetLocalResourceObject("GenNoUpdate")
                End If

                If Not (rbCalculateGlobal.Checked And count > 0) Then
                    lblError.ForeColor = Drawing.Color.Green
                    lblError.Text = count.ToString() + " " + GetLocalResourceObject("GenSavedSucessLocal")
                ElseIf (count = 0) Then
                    lblError.ForeColor = Drawing.Color.Green
                    lblError.Text = GetLocalResourceObject("GenNoUpdate")
                End If
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetails", "cbStartCalculation_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserName"))
        End Try

    End Sub

    Protected Sub cbLocation_Callback(sender As Object, e As CallbackEventArgsBase)
        LoadLocation()
    End Sub

    Protected Sub cbDiscountCode_Callback(sender As Object, e As CallbackEventArgsBase)
        Dim callbackParam As String = e.Parameter
        Dim callbackParams() = callbackParam.Split(";")
        If (callbackParams(0) = "LOCAL") Then
            LoadDiscountCodeBuy()
        ElseIf (callbackParams(0) = "GLOBAL") Then
            LoadDiscountCodeBuyGlobal()
        End If

    End Sub

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function SparePart_Search(ByVal q As String, ByVal localGlobal As String, suppCurrNo As String) As ItemsBO()
        Dim spareDetails As New List(Of ItemsBO)()
        Dim _calcPrice As New CalcPriceBO
        Try
            _calcPrice.SuppCurrNo = If(suppCurrNo = "", Nothing, suppCurrNo.Trim())
            spareDetails = _calcPrice.SparePartSearch(q, localGlobal)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "Customer_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails.ToList.ToArray
    End Function
    Protected Sub UploadControl_FileUploadComplete(sender As Object, e As FileUploadCompleteEventArgs)
        fileName = e.UploadedFile.FileName
        If (e.IsValid) Then
            If Not Directory.Exists(uploadsDirectory) Then
                Directory.CreateDirectory(uploadsDirectory)
            End If
            e.UploadedFile.SaveAs(uploadsDirectory + e.UploadedFile.FileName)
            e.CallbackData = fileName
        End If
    End Sub
    Protected Sub cbImportClick_Callback1(sender As Object, e As CallbackEventArgsBase)
        Dim read As StreamReader = Nothing
        Dim curLine As String
        Dim globalPart As CalcPriceBO
        Dim calcPriceBO As CalcPriceBO = New CalcPriceBO()
        'Comments: Error records has to be logged in seperate log file, instead of Application log file
        Dim logfilestream As FileStream
        Dim logpath As String = String.Empty
        'Dim separator As String = System.Globalization.CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator
        'Dim separator As String = ConfigurationManager.AppSettings("PriceFileDecimalSeperator").ToString() ' We need check if priceFile is having . in place of , for norwegian
        Dim separator As String
        logpath = ConfigurationManager.AppSettings("MSG_Error_Log_Path").ToString()

        newlog = New DirectoryInfo(logpath + logFileFolder + "\")
        logfilepath = newlog.FullName + "ImportSupplierLog.txt"
        If Not newlog.Exists() Then
            newlog.Create()
            logfilestream = File.Create(logfilepath)
            logfilestream.Close()
        Else
            If File.Exists(logfilepath) Then
                File.Delete(logfilepath)
            End If
            logfilestream = File.Create(logfilepath)
            logfilestream.Close()
        End If
        getCurrDateTime()
        builder.Append(vbCrLf)
        ConstructFile("================================================================================")
        ConstructFile("Log written on:" + ": " + serverdate + "  " + servertime)
        ConstructFile("================================================================================")
        builder.Append(vbCrLf)
        calcPriceBO.IdItemCategory = ddlSparePartGroup.Value
        calcPriceBO.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)
        calcPriceBO.MarkupSellingPrice = IIf(txtPerSellPrice.Text.Trim = "" Or txtPerSellPrice.Text = Nothing, 0, txtPerSellPrice.Text.Trim)
        calcPriceBO.MarkupBasicPrice = IIf(txtPerBasicPrice.Text.Trim = "" Or txtPerBasicPrice.Text = Nothing, 0, txtPerBasicPrice.Text.Trim) ' txtPerBasicPrice.Text.Trim
        calcPriceBO.MarkupCostPrice = IIf(txtPerCostPrice.Text.Trim = "" Or txtPerCostPrice.Text = Nothing, 0, txtPerCostPrice.Text.Trim) 'txtPerCostPrice.Text.Trim
        calcPriceBO.MarkupNetPrice = IIf(txtPerNetPrice.Text.Trim = "" Or txtPerNetPrice.Text = Nothing, 0, txtPerNetPrice.Text.Trim) 'txtPerNetPrice.Text.Trim
        calcPriceBO.PriceFile = fileName
        calcPriceBO.CreatedBy = Session("UserID")
        Dim noCrtUpdateSP As Boolean = rbNoCreateGlobalSprPrt.Checked
        Dim dltAndAddSPReg As Boolean = rbDeleteGlobalSprPrt.Checked
        Dim updateSPReg As Boolean = rbUpdateGlobalSprPrt.Checked
        Dim updateLocalSP As Boolean = chkUpdateLocalSprPrt.Checked
        Dim updateSPOnJobPkg As Boolean = chkUpdateSprJobPackage.Checked
        calcPriceBO.SupplierID = IIf(hdnSupplierID.Text = "" Or hdnSupplierID.Text = Nothing, Nothing, hdnSupplierID.Text.Trim)
        Try
            calcPriceBO.InsertPricefileDetails(noCrtUpdateSP, dltAndAddSPReg, updateSPReg, updateLocalSP, updateSPOnJobPkg)
            If dltAndAddSPReg Then
                calcPriceBO.DeleteGlobalSparePart()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_SupplierDetail", "cbImportClick_Callback1", ex.ToString, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
        Try
            Dim fs As FileStream
            fs = New FileStream(uploadsDirectory & fileName, FileMode.Open, FileAccess.Read)
            'read = New StreamReader(fs, System.Text.Encoding.Default)
            read = New StreamReader(fs)

            While (read.Peek <> -1)
                globalPart = New CalcPriceBO
                Dim discBuy = "", discSell = ""
                curLine = read.ReadLine()
                If curLine.Trim() <> "" Then

                    Dim sparePartFrom, sparePartTo, descFrom, descTo, modelCodeFrom, modelCodeTo, uomFrom, uomTo As Integer
                    Dim discCodeFrom, discCodeTo, sellPriceFrom, sellPriceTo, currFrom, currTo, pkgQtyFrom, pkgQtyTo, itemDescFrom, itemDescTo As Integer
                    Dim basepriceFrom, basepriceTo, discCodeBuyFrom, discCodebuyTo, repCodeFrom, repCodeTo As Integer
                    Dim costPrice1From, costPrice1To, costPrice2From, costPrice2To, replaceSpareFrom, replaceSpareTo, barcodeNumFrom, barcodeNumTo As Integer
                    Dim spareOrder, descOrder, modelCodeOrder, uomOrder, discCOdeOrder, sellPriceOrder, currOrder, pkgQtyOrder, itemDescOrder, barcodeNumOrder As Integer
                    Dim basepriceOrder, disccodebuyOrder, repCodeOrder, costPrice1Order, costPrice2Order, replaceSpareOrder As Integer
                    Dim removeStartZeros, removeBlankFields, dividePriceByHundred As Boolean
                    Dim repCode = ""
                    Dim replacespare As String = String.Empty
                    Dim FileMode As String = String.Empty
                    Dim Delimiter As String = String.Empty
                    Dim costPrice1 = 0.0, costPrice2 = 0.0
                    Dim dsSettings As DataSet
                    Dim suppSetting As New CalcPriceBO
                    suppSetting.SupplierID = IIf(hdnSupplierID.Text = "" Or hdnSupplierID.Text = Nothing, Nothing, hdnSupplierID.Text.Trim)
                    Dim maxLength As Integer = 0
                    dsSettings = suppSetting.GetSupplierSettings()
                    If Not IsNothing(dsSettings) Then
                        'modify to fetch the data for supplier
                        Dim dr() As DataRow

                        ''Spare part number
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ID_ITEM'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If (Not IsDBNull(dr(0)("FILEMODE"))) Then
                            FileMode = dr(0)("FILEMODE")
                        Else
                            FileMode = ""
                        End If
                        'Newly Added
                        If FileMode = "Fixed" Then
                            maxLength = Convert.ToInt32(dsSettings.Tables(0).Compute("max([END_NUM])", String.Empty))
                        End If

                        If maxLength <> 0 And maxLength > curLine.Length Then
                            cbImportClick.JSProperties("cpStrResult") = GetLocalResourceObject("INVALIDFILE")
                            Return
                        End If

                        If (Not IsDBNull(dr(0)("DELIMITER"))) Then
                            Delimiter = dr(0)("DELIMITER")
                            If Delimiter = "\t" Then
                                Delimiter = CType(vbTab, Char)
                            End If
                        Else
                            Delimiter = ""
                        End If

                        If (Not IsDBNull(dr(0)("REMOVE_BLANK_FIELD"))) Then
                            removeBlankFields = dr(0)("REMOVE_BLANK_FIELD")
                        Else
                            removeBlankFields = False
                        End If

                        If (Not IsDBNull(dr(0)("REMOVE_START_ZERO"))) Then
                            removeStartZeros = dr(0)("REMOVE_START_ZERO")
                        Else
                            removeStartZeros = False
                        End If

                        If (Not IsDBNull(dr(0)("DIVIDE_PRICE_BY_HUNDRED"))) Then
                            dividePriceByHundred = dr(0)("DIVIDE_PRICE_BY_HUNDRED")
                        Else
                            dividePriceByHundred = False
                        End If
                        If (Not IsDBNull(dr(0)("PRICE_FILE_DEC_SEP"))) Then
                            separator = dr(0)("PRICE_FILE_DEC_SEP")
                        Else
                            separator = "."
                        End If

                        If separator = "." Then
                            priceFileLangConfig = "en-US"
                        ElseIf separator = "," Then
                            priceFileLangConfig = "no-NB"
                        End If
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                spareOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                sparePartFrom = dr(0)("START_NUM")
                                sparePartTo = dr(0)("END_NUM")
                            End If
                        End If

                        'item desc
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ITEM_DESC'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                descOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                descFrom = dr(0)("START_NUM")
                                descTo = dr(0)("END_NUM")
                            End If
                        End If

                        'model code
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ID_ITEM_MODEL'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                modelCodeOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                modelCodeFrom = dr(0)("START_NUM")
                                modelCodeTo = dr(0)("END_NUM")
                            End If
                        End If

                        'UOM
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ID_UNIT_ITEM'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                uomOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                uomFrom = dr(0)("START_NUM")
                                uomTo = dr(0)("END_NUM")
                            End If
                        End If

                        'discCodeSell
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ITEM_DISC_CODE'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                discCOdeOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                discCodeFrom = dr(0)("START_NUM")
                                discCodeTo = dr(0)("END_NUM")
                            End If
                        End If

                        'discCodeBuy
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ITEM_DISC_CODE_BUY'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                disccodebuyOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                discCodeBuyFrom = dr(0)("START_NUM")
                                discCodebuyTo = dr(0)("END_NUM")
                            End If
                        End If

                        'Sell price
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ITEM_PRICE'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                sellPriceOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                sellPriceFrom = dr(0)("START_NUM")
                                sellPriceTo = dr(0)("END_NUM")
                            End If
                        End If

                        'basic price 
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='BASIC_PRICE'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                basepriceOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                basepriceFrom = dr(0)("START_NUM")
                                basepriceTo = dr(0)("END_NUM")
                            End If
                        End If

                        'item desc 2 
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ITEM_DESC_NAME2'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                itemDescOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                itemDescFrom = dr(0)("START_NUM")
                                itemDescTo = dr(0)("END_NUM")
                            End If
                        End If

                        'currency id 
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='ID_CURRENCY'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                currOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                currFrom = dr(0)("START_NUM")
                                currTo = dr(0)("END_NUM")
                            End If
                        End If

                        'package qty 
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='PACKAGE_QTY'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                pkgQtyOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                pkgQtyFrom = dr(0)("START_NUM")
                                pkgQtyTo = dr(0)("END_NUM")
                            End If
                        End If

                        'replacement code
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='Replacement_Code'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                repCodeOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                repCodeFrom = dr(0)("START_NUM")
                                repCodeTo = dr(0)("END_NUM")
                            End If
                        End If

                        'replacement Number
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='Replacement_Number'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                replaceSpareOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                replaceSpareFrom = dr(0)("START_NUM")
                                replaceSpareTo = dr(0)("END_NUM")
                            End If
                        End If

                        'CostPrice1
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='COST_PRICE1'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                costPrice1Order = dr(0)("ORDER_OF_FILE")
                            Else
                                costPrice1From = dr(0)("START_NUM")
                                costPrice1To = dr(0)("END_NUM")
                            End If
                        End If

                        'CostPrice2
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='COST_PRICE2'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                costPrice2Order = dr(0)("ORDER_OF_FILE")
                            Else
                                costPrice2From = dr(0)("START_NUM")
                                costPrice2To = dr(0)("END_NUM")
                            End If
                        End If

                        'Barcode Number
                        dr = dsSettings.Tables(0).Select("FIELD_NAME='BARCODE_NUMBER'", "FIELD_NAME", DataViewRowState.CurrentRows)
                        If dr.Length > 0 Then
                            If IIf(IsDBNull(dr(0)("ORDER_OF_FILE")) = True, 0, dr(0)("ORDER_OF_FILE")) <> 0 Then
                                barcodeNumOrder = dr(0)("ORDER_OF_FILE")
                            Else
                                barcodeNumFrom = dr(0)("START_NUM")
                                barcodeNumTo = dr(0)("END_NUM")
                            End If
                        End If

                        With globalPart
                            Dim i = curLine.Length
                            Dim Order() As String

                            .SuppCurrNo = hdnSuppCurNo.Text.Trim()
                            .IdItemCategory = ddlSparePartGroup.Value
                            Dim spare As String = String.Empty
                            If FileMode = "Fixed" Or FileMode = "" Then
                                If sparePartFrom <> 0 And sparePartTo <> 0 And sparePartFrom <= curLine.Length And ((sparePartTo - sparePartFrom) + sparePartFrom) <= curLine.Length Then
                                    spare = curLine.Substring((sparePartFrom - 1), (sparePartTo - (sparePartFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And spareOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                spare = Order(spareOrder - 1).ToString
                                If dsSettings.Tables(0).Rows.Count > Order.Length Then
                                    cbImportClick.JSProperties("cpStrResult") = GetLocalResourceObject("INVALIDFILE")
                                    Return
                                End If
                            End If
                            If removeBlankFields Then
                                spare = spare.Trim()
                            End If

                            'Removed Since ID_ITEM is a unique key field in Table
                            'If removeStartZeros Then
                            '    Dim re As Regex = New Regex("^0+", RegexOptions.Singleline)
                            '    spare = re.Replace(spare, "")
                            'End If

                            spare = RemoveSpecialCharacters(spare)
                            .IdItem = spare

                            If FileMode = "Fixed" Or FileMode = "" Then
                                If repCodeFrom <> 0 And repCodeFrom <= curLine.Length Then 'And repCodeTo <> 0 And repCodeFrom <= curLine.Length And ((repCodeTo - repCodeFrom) + repCodeFrom) <= curLine.Length Then
                                    'repCode = curLine.Substring((repCodeFrom - 1), (repCodeTo - (repCodeFrom - 1))).Trim
                                    repCode = curLine.Substring((repCodeFrom - 1), (repCodeTo - (repCodeFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And repCodeOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                repCode = Order(repCodeOrder - 1).ToString
                            End If

                            'if replacement code is O then this field becomes the new spare part number
                            Dim description As String = String.Empty
                            If FileMode = "Fixed" Or FileMode = "" Then
                                If descFrom <> 0 And descTo <> 0 And descFrom <= curLine.Length And ((descTo - descFrom) + descFrom) <= curLine.Length Then
                                    Dim spare1 As String = String.Empty
                                    'description = curLine.Substring((descFrom - 1), (descTo - (descFrom - 1))).Trim
                                    description = curLine.Substring((descFrom - 1), (descTo - (descFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And descOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                description = Order(descOrder - 1).ToString
                            End If
                            If removeBlankFields Then
                                description = description.Trim()
                            End If
                            If removeStartZeros Then
                                Dim re As Regex = New Regex("^0+", RegexOptions.Singleline)
                                description = re.Replace(description, "")
                            End If
                            .ItemDescription = description

                            If FileMode = "Fixed" Or FileMode = "" Then
                                If itemDescFrom <> 0 And itemDescTo <> 0 And itemDescFrom <= curLine.Length And ((itemDescTo - itemDescFrom) + itemDescFrom) <= curLine.Length Then
                                    '.ItemDescName2 = curLine.Substring((itemDescFrom - 1), (itemDescTo - (itemDescFrom - 1))).Trim
                                    .ItemDescName2 = curLine.Substring((itemDescFrom - 1), (itemDescTo - (itemDescFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And itemDescOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                .ItemDescName2 = Order(itemDescOrder - 1).ToString
                            End If


                            If FileMode = "Fixed" Or FileMode = "" Then
                                If modelCodeFrom <> 0 And modelCodeTo <> 0 And modelCodeFrom <= curLine.Length And ((modelCodeTo - modelCodeFrom) + modelCodeFrom) <= curLine.Length Then
                                    '.IdItemModel = curLine.Substring((modelCodeFrom - 1), (modelCodeTo - (modelCodeFrom - 1))).Trim
                                    .IdItemModel = curLine.Substring((modelCodeFrom - 1), (modelCodeTo - (modelCodeFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And modelCodeOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                .IdItemModel = Order(modelCodeOrder - 1).ToString
                            End If
                            .IdUnitItem = DBNull.Value.ToString

                            Dim uomDesc As String
                            If FileMode = "Fixed" Or FileMode = "" Then
                                If uomFrom <> 0 And uomTo <> 0 And uomFrom <= curLine.Length And ((uomTo - uomFrom) + uomFrom) <= curLine.Length Then
                                    uomDesc = curLine.Substring((uomFrom - 1), (uomTo - (uomFrom - 1))).Trim
                                    Dim dsUOM As DataSet = .GetUOM()
                                    Dim dvuom As DataView = dsUOM.Tables(0).DefaultView
                                    dvuom.RowFilter = "UNIT_DESC='" + uomDesc.Trim() + "'"
                                    If dvuom.Count > 0 Then
                                        .IdUnitItem = dvuom(0)("ID_UNIT")
                                    Else
                                        WriteGlobalLog(GetLocalResourceObject("INVUNITITEM").ToString(), .IdItem)
                                    End If
                                End If
                            ElseIf FileMode = "Delimiter" And uomOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                uomDesc = Order(uomOrder - 1).ToString
                                Dim dsUOM As DataSet = .GetUOM()
                                Dim dvuom As DataView = dsUOM.Tables(0).DefaultView
                                dvuom.RowFilter = "UNIT_DESC='" + uomDesc.Trim() + "'"
                                If dvuom.Count > 0 Then
                                    .IdUnitItem = dvuom(0)("ID_UNIT")
                                Else
                                    WriteGlobalLog(GetLocalResourceObject("INVIDITEM").ToString(), .IdItem)
                                End If
                            End If
                            If FileMode = "Fixed" Or FileMode = "" Then
                                If discCodeFrom <> 0 And discCodeTo <> 0 And discCodeFrom <= curLine.Length And ((discCodeTo - discCodeFrom) + discCodeFrom) <= curLine.Length Then
                                    'discSell = curLine.Substring((discCodeFrom - 1), (discCodeTo - (discCodeFrom - 1))).Trim
                                    discSell = curLine.Substring((discCodeFrom - 1), (discCodeTo - (discCodeFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And discCOdeOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                discSell = Order(discCOdeOrder - 1).ToString
                            End If

                            If FileMode = "Fixed" Or FileMode = "" Then
                                If discCodeBuyFrom <> 0 And discCodebuyTo <> 0 And discCodeBuyFrom <= curLine.Length And ((discCodebuyTo - discCodeBuyFrom) + discCodeBuyFrom) <= curLine.Length Then
                                    'discBuy = curLine.Substring((discCodeBuyFrom - 1), (discCodebuyTo - (discCodeBuyFrom - 1))).Trim
                                    discBuy = curLine.Substring((discCodeBuyFrom - 1), (discCodebuyTo - (discCodeBuyFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And disccodebuyOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                discBuy = Order(disccodebuyOrder - 1).ToString
                            End If

                            If discBuy = "" Then
                                .ItemDiscCodeBuy = ""
                            End If

                            'Selling Price
                            Dim sellPrice1 As Decimal
                            Dim provider As CultureInfo = New CultureInfo(priceFileLangConfig)
                            If FileMode = "Fixed" Or FileMode = "" Then
                                If sellPriceFrom <> 0 And sellPriceTo <> 0 And sellPriceFrom <= curLine.Length And ((sellPriceTo - sellPriceFrom) + sellPriceFrom) <= curLine.Length Then
                                    Dim Reg_exp As New Regex("^-{0,1}\d*\" + separator + "{0,1}\d+$")

                                    If Not Reg_exp.IsMatch(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom))).Trim) Then
                                        WriteGlobalLog(GetLocalResourceObject("INVSELLPRICE").ToString(), .IdItem)
                                    Else
                                        'sellPrice1 = Decimal.Parse(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom - 1))).Trim)
                                        sellPrice1 = Decimal.Parse(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom))).Trim, provider)
                                    End If
                                End If
                            ElseIf FileMode = "Delimiter" And sellPriceOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                Dim Reg_exp As New Regex("^-{0,1}\d*\" + separator + "{0,1}\d+$")
                                If Not Reg_exp.IsMatch(Order(sellPriceOrder - 1).ToString.Trim) Then
                                    WriteGlobalLog(GetLocalResourceObject("INVSELLPRICE").ToString(), .IdItem)
                                Else
                                    sellPrice1 = Decimal.Parse(Order(sellPriceOrder - 1).ToString.Trim, provider)
                                End If
                            End If
                            .ItemPrice = sellPrice1
                            If Not .ItemPrice.ToString.Contains(separator) Then
                                If dividePriceByHundred Then
                                    .ItemPrice = .ItemPrice / 100
                                End If
                            End If
                            .ItemPrice = .ItemPrice + (.ItemPrice * Decimal.Parse(IIf(txtPerSellPrice.Text.ToString.Trim = "", 0, txtPerSellPrice.Text.ToString.Trim)) / 100)

                            'BasicPrice
                            Dim basicPrice As Decimal
                            If FileMode = "Fixed" Or FileMode = "" Then

                                If basepriceFrom <> 0 And basepriceTo <> 0 And basepriceFrom <= curLine.Length And ((basepriceTo - basepriceFrom) + basepriceFrom) <= curLine.Length Then
                                    Dim Reg_exp As New Regex("^-{0,1}\d*\" + separator + "{0,1}\d+$")

                                    'If Not Reg_exp.IsMatch(curLine.Substring((basepriceFrom - 1), (basepriceTo - (basepriceFrom - 1))).Trim) Then
                                    If Not Reg_exp.IsMatch(curLine.Substring((basepriceFrom - 1), (basepriceTo - (basepriceFrom))).Trim) Then
                                        WriteGlobalLog(GetLocalResourceObject("INVBASICPRICE").ToString(), .IdItem)
                                    Else
                                        ''basicPrice = Decimal.Parse(curLine.Substring((basepriceFrom - 1), (basepriceTo - (basepriceFrom - 1))).Trim)
                                        basicPrice = Decimal.Parse(curLine.Substring((basepriceFrom - 1), (basepriceTo - (basepriceFrom))).Trim, provider)
                                        'basicPrice = Decimal.Parse(curLine.Substring((basepriceFrom - 1), (basepriceTo - (basepriceFrom))).Trim)
                                    End If
                                Else
                                    'basicPrice = Decimal.Parse(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom - 1))).Trim)
                                    basicPrice = Decimal.Parse(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom))).Trim, provider)
                                    ' basicPrice = Decimal.Parse(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom))).Trim)
                                End If
                            Else
                                If FileMode = "Delimiter" And basepriceOrder <> 0 Then
                                    Order = curLine.Split(Delimiter)
                                    Dim Reg_exp As New Regex("^-{0,1}\d*\" + separator + "{0,1}\d+$")
                                    If Not Reg_exp.IsMatch(Order(basepriceOrder - 1).ToString.Trim) Then
                                        WriteGlobalLog(GetLocalResourceObject("INVBASICPRICE").ToString(), .IdItem)
                                    Else
                                        basicPrice = Decimal.Parse(Order(basepriceOrder - 1).ToString.Trim, provider)
                                    End If
                                Else
                                    Order = curLine.Split(Delimiter)
                                    basicPrice = Decimal.Parse(Order(sellPriceOrder - 1).ToString.Trim, provider)
                                End If

                            End If
                            .BasicPrice = basicPrice
                            If Not .BasicPrice.ToString.Contains(separator) Then
                                If dividePriceByHundred Then
                                    .BasicPrice = .BasicPrice / 100
                                End If
                            End If
                            .BasicPrice = .BasicPrice + (.BasicPrice * Decimal.Parse(IIf(txtPerBasicPrice.Text.ToString.Trim = "", 0, txtPerBasicPrice.Text.ToString.Trim)) / 100)

                            'replacecode
                            If replaceSpareFrom <> 0 And replaceSpareTo <> 0 And replaceSpareFrom <= curLine.Length Then 'And ((replaceSpareTo - replaceSpareFrom) + replaceSpareFrom) <= curLine.Length Then
                                If ((replaceSpareTo - replaceSpareFrom) + replaceSpareFrom) <= curLine.Length Then
                                    replacespare = curLine.Substring((replaceSpareFrom - 1), (replaceSpareTo - (replaceSpareFrom - 1))).Trim
                                Else
                                    'replacespare = curLine.Substring((replaceSpareFrom - 1), (curLine.Length - (replaceSpareFrom - 1))).Trim
                                    replacespare = curLine.Substring((replaceSpareFrom - 1), (curLine.Length - (replaceSpareFrom))).Trim
                                End If

                            ElseIf FileMode = "Delimiter" And replaceSpareOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                replacespare = Order(replaceSpareOrder - 1).ToString
                            End If
                            'Cost Price 
                            Dim costPrice As Decimal
                            If costPrice1From <> 0 And costPrice1To <> 0 And costPrice1From <= curLine.Length And ((costPrice1To - costPrice1From) + costPrice1From) <= curLine.Length Then
                                'costPrice = Decimal.Parse(curLine.Substring((costPrice1From - 1), (costPrice1To - (costPrice1From - 1))).Trim)
                                costPrice = Decimal.Parse(curLine.Substring((costPrice1From - 1), (costPrice1To - (costPrice1From))).Trim, provider)
                            ElseIf FileMode = "Delimiter" And costPrice1Order <> 0 Then
                                Order = curLine.Split(Delimiter)
                                costPrice = Decimal.Parse(Order(costPrice1Order - 1).ToString.Trim, provider)

                            End If
                            .CostPrice1 = costPrice
                            If Not .CostPrice1.ToString.Contains(separator) Then
                                If dividePriceByHundred Then
                                    .CostPrice1 = .CostPrice1 / 100
                                End If
                            End If
                            .CostPrice1 = .CostPrice1 + (.CostPrice1 * Decimal.Parse(IIf(txtPerCostPrice.Text.ToString.Trim = "", 0, txtPerCostPrice.Text.ToString.Trim)) / 100)
                            'Cost Price 2
                            Dim costPricnew As Decimal
                            If costPrice2From <> 0 And costPrice2To <> 0 And costPrice2From <= curLine.Length And ((costPrice2To - costPrice2From) + costPrice2From) <= curLine.Length Then
                                'costPricnew = Decimal.Parse(curLine.Substring((costPrice2From - 1), (costPrice2To - (costPrice2From - 1))).Trim)
                                costPricnew = Decimal.Parse(curLine.Substring((costPrice2From - 1), (costPrice2To - (costPrice2From))).Trim, provider)
                            ElseIf FileMode = "Delimiter" And costPrice2Order <> 0 Then
                                Order = curLine.Split(Delimiter)
                                costPricnew = Decimal.Parse(Order(costPrice2Order - 1).ToString.Trim, provider)

                            End If
                            .CostPrice2 = costPricnew
                            .CostPrice2 = .CostPrice2 + (.CostPrice2 * Decimal.Parse(IIf(txtPerNetPrice.Text.ToString.Trim = "", 0, txtPerNetPrice.Text.ToString.Trim)) / 100)

                            discBuy = "" 'Since discount Codes are not part of PriceFile  

                            If discBuy <> "" Then
                                Dim dsDiscCode As DataSet
                                Dim discCode As New CalcPriceBO
                                discCode.MakeID = Nothing 'Need to check
                                dsDiscCode = discCode.GetDiscountCode
                                If Not IsNothing(dsDiscCode) Then
                                    If dsDiscCode.Tables(0).Rows.Count > 0 Then
                                        Dim dvDiscCode As DataView
                                        dvDiscCode = dsDiscCode.Tables(0).DefaultView
                                        'dvDiscCode.RowFilter = "ID_MAKE='" + .IdMake + "' and DISCOUNTCODE='" + discBuy + "'"
                                        If dvDiscCode.Count > 0 Then
                                            .ItemDiscCodeBuy = dvDiscCode(0)("ID_DISCOUNTCODE")
                                        Else
                                            WriteGlobalLog(GetLocalResourceObject("INVDISCCODE").ToString(), .IdItem)
                                        End If

                                        'dvDiscCode.RowFilter = "ID_MAKE='" + .IdMake + "' and DISCOUNTCODE='" + discSell + "'"
                                        If dvDiscCode.Count > 0 Then
                                            .ItemDiscCode = dvDiscCode(0)("ID_DISCOUNTCODE")
                                        Else
                                            WriteGlobalLog(GetLocalResourceObject("INVDISCCODE").ToString(), .IdItem)
                                        End If
                                    End If
                                Else
                                    WriteGlobalLog(GetLocalResourceObject("INVDISCCODE").ToString(), .IdItem)
                                End If
                                If costPrice1To = 0 Or costPrice2To = 0 Then
                                    If .ItemDiscCodeBuy <> "" Then
                                        Dim objDiscMatrixBuy As New CalcPriceBO
                                        Dim dsDMBuy As DataSet
                                        dsDMBuy = objDiscMatrixBuy.FetchDiscountMatrixBuy
                                        If Not IsNothing(dsDMBuy) Then
                                            Dim dvDisc As DataView

                                            dvDisc = dsDMBuy.Tables(0).DefaultView
                                            Dim strFilter As String
                                            'strFilter = "ID_MAKE='" + .IdMake + "' and ID_SUPPLIER=" + hdnSupplierID.Text + " and ID_DISCOUNTCODE=" + .ItemDiscCodeBuy
                                            dvDisc.RowFilter = strFilter

                                            Dim cp1DiscPer, cp2DiscPer As Decimal

                                            If dvDisc.Count > 0 Then
                                                Dim sellPrice As Decimal = 0
                                                If sellPriceFrom <> 0 And sellPriceTo <> 0 And sellPriceFrom <= curLine.Length And ((sellPriceTo - sellPriceFrom) + sellPriceFrom) <= curLine.Length Then
                                                    Dim Reg_exp As New Regex("^-{0,1}\d*\" + separator + "{0,1}\d+$")
                                                    If Not Reg_exp.IsMatch(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom - 1))).Trim) Then
                                                        WriteGlobalLog(GetLocalResourceObject("INVSELLPRICE").ToString(), .IdItem)
                                                    Else
                                                        sellPrice = Decimal.Parse(curLine.Substring((sellPriceFrom - 1), (sellPriceTo - (sellPriceFrom - 1))).Trim, provider) '* 100
                                                    End If
                                                Else
                                                    If FileMode = "DELIMITER" And sellPriceOrder <> 0 Then
                                                        Order = curLine.Split(Delimiter)
                                                        'costPricnew = Order(sellPriceOrder - 1).ToString
                                                        sellPrice = Order(sellPriceOrder - 1).ToString
                                                    End If
                                                End If

                                                If costPrice1From <> 0 And costPrice1To <> 0 And costPrice1From <= curLine.Length And ((costPrice1To - costPrice1From) + costPrice1From) <= curLine.Length Then
                                                Else
                                                    Dim sellPriceDis As Decimal
                                                    cp1DiscPer = dvDisc(0)("DISCPERCOST1")
                                                    If Not sellPrice1.ToString.Contains(separator) Then
                                                        If dividePriceByHundred Then
                                                            sellPriceDis = sellPrice1 / 100
                                                        Else
                                                            sellPriceDis = sellPrice1
                                                        End If
                                                    Else
                                                        sellPriceDis = sellPrice1
                                                    End If

                                                    costPrice1 = sellPriceDis + (sellPriceDis * Decimal.Parse(IIf(txtPerCostPrice.Text.ToString.Trim = "", 0, txtPerCostPrice.Text.ToString)) / 100) '-(.ItemPrice * cp1DiscPer) / 100

                                                    .CostPrice1 = costPrice1 - (costPrice1 * cp1DiscPer / 100)
                                                End If

                                                If costPrice2From <> 0 And costPrice2To <> 0 And costPrice2From <= curLine.Length And ((costPrice2To - costPrice2From) + costPrice2From) <= curLine.Length Then
                                                Else
                                                    Dim sellPriceDis1 As Decimal
                                                    If Not sellPrice1.ToString.Contains(separator) Then
                                                        If dividePriceByHundred Then
                                                            sellPriceDis1 = sellPrice1 / 100
                                                        Else
                                                            sellPriceDis1 = sellPrice1
                                                        End If
                                                    Else
                                                        sellPriceDis1 = sellPrice1
                                                    End If
                                                    cp2DiscPer = dvDisc(0)("DISCPERCOST2")
                                                    costPrice2 = sellPriceDis1 + (sellPriceDis1 * Decimal.Parse(IIf(txtPerNetPrice.Text.ToString.Trim = "", 0, txtPerNetPrice.Text.ToString)) / 100) '-(.ItemPrice * cp1DiscPer) / 100

                                                    costPrice2 = costPrice2 - (costPrice2 * cp2DiscPer / 100)
                                                    .CostPrice2 = costPrice2
                                                End If
                                            Else

                                            End If
                                        Else

                                        End If
                                    Else
                                        WriteGlobalLog(GetLocalResourceObject("INVDISCCODE").ToString(), .IdItem)
                                    End If

                                End If
                            End If

                            If pkgQtyFrom <> 0 And pkgQtyTo <> 0 And pkgQtyFrom <= curLine.Length And ((pkgQtyTo - pkgQtyFrom) + pkgQtyFrom) <= curLine.Length Then
                                Dim pkg As String
                                pkg = curLine.Substring((pkgQtyFrom - 1), (pkgQtyTo - (pkgQtyFrom - 1))).Trim
                                Dim Reg_exp As New Regex("^\d+$")
                                If Not Reg_exp.IsMatch(curLine.Substring((pkgQtyFrom - 1), (pkgQtyTo - (pkgQtyFrom - 1))).Trim) Then
                                    WriteGlobalLog(GetLocalResourceObject("INVPKGQTY").ToString(), .IdItem)
                                Else
                                    .PackageQty = curLine.Substring((pkgQtyFrom - 1), (pkgQtyTo - (pkgQtyFrom - 1))).Trim
                                End If
                                'If pkg <> "" Then
                                '    .PackageQty = CInt(pkg)
                                'End If
                            ElseIf FileMode = "Delimiter" And pkgQtyOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                .PackageQty = Order(pkgQtyOrder - 1).ToString
                            Else
                                .PackageQty = 1
                            End If
                            .IdCurrency = 0

                            Dim curId As String
                            If currFrom <> 0 And currTo <> 0 And currFrom <= curLine.Length And ((currTo - currFrom) + currFrom) <= curLine.Length Then
                                curId = curLine.Substring((currFrom - 1), (currTo - (currFrom - 1))).Trim
                                Dim dsCurrency As DataSet = .GetSPRCurrency
                                Dim dvCurr As DataView
                                dvCurr = dsCurrency.Tables(0).DefaultView
                                dvCurr.RowFilter = "DESCRIPTION='" + curId.Trim + "'"
                                If dvCurr.Count > 0 Then
                                    .IdCurrency = dvCurr(0)("ID_PARAM")
                                Else
                                    WriteGlobalLog(GetLocalResourceObject("INVCURRENCY").ToString(), .IdItem)
                                End If
                            ElseIf FileMode = "Delimiter" And currOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                curId = Order(currOrder - 1).ToString
                                Dim dsCurrency As DataSet = .GetSPRCurrency
                                Dim dvCurr As DataView
                                dvCurr = dsCurrency.Tables(0).DefaultView
                                dvCurr.RowFilter = "DESCRIPTION='" + curId.Trim + "'"
                                If dvCurr.Count > 0 Then
                                    .IdCurrency = dvCurr(0)("ID_PARAM")
                                Else
                                    WriteGlobalLog(GetLocalResourceObject("INVCURRENCY").ToString(), .IdItem)
                                End If
                            End If

                            'Barcode number
                            Dim barcodeNumber As String = String.Empty
                            If FileMode = "Fixed" Or FileMode = "" Then
                                If barcodeNumFrom <> 0 And barcodeNumTo <> 0 And barcodeNumFrom <= curLine.Length And ((barcodeNumTo - barcodeNumFrom) + barcodeNumFrom) <= curLine.Length Then
                                    'description = curLine.Substring((descFrom - 1), (descTo - (descFrom - 1))).Trim
                                    barcodeNumber = curLine.Substring((barcodeNumFrom - 1), (barcodeNumTo - (barcodeNumFrom))).Trim
                                End If
                            ElseIf FileMode = "Delimiter" And barcodeNumOrder <> 0 Then
                                Order = curLine.Split(Delimiter)
                                barcodeNumber = Order(barcodeNumOrder - 1).ToString
                            End If
                            If removeBlankFields Then
                                barcodeNumber = barcodeNumber.Trim()
                            End If
                            If removeStartZeros Then
                                Dim re As Regex = New Regex("^0+", RegexOptions.Singleline)
                                barcodeNumber = re.Replace(barcodeNumber, "")
                            End If

                            .Barcode_Number = barcodeNumber
                            .CalcPrice = 1
                            .CreatedBy = Session("UserID")
                            .ModifiedBy = Session("UserID")
                            .IsDeleteGlobalSP = rbDeleteGlobalSprPrt.Checked
                            .IsUpdateGlobalSP = rbUpdateGlobalSprPrt.Checked
                            .IsUpdateLocalSP = chkUpdateLocalSprPrt.Checked
                            .IsUpdateSPJobPackage = chkUpdateSprJobPackage.Checked
                            Dim strResult As String
                            Try
                                .ImportGlobalSpareParts()
                                strResult = .DBSuccess
                                Select Case strResult
                                    Case "INS"
                                        _flgImpFail = False
                                    Case "UPDATED"
                                        _flgImpFail = False
                                    Case "CONFIG"
                                        _flgImpFail = True
                                        cbImportClick.JSProperties("cpStrResult") = GetLocalResourceObject("INVCONFIGIMPORT").ToString()
                                        builder.Append(vbCrLf)
                                        ConstructFile("================================================================================")
                                        WriteRowInFile(builder)
                                        Exit Sub
                                    Case Else
                                        WriteGlobalLog(GetLocalResourceObject("SPARESIMPORTFAILED").ToString(), .IdItem)
                                        _flgImpFail = True
                                End Select
                            Catch ex As Exception
                                Throw ex
                            End Try
                        End With

                    End If
                End If
            End While
            If _flgImpFail Then
                cbImportClick.JSProperties("cpStrResult") = GetLocalResourceObject("SPARESIMPORTFAILED").ToString()
            Else
                'Saving Enviromental Fee
                calcPriceBO.ItemDescription = "Enviromental Fee"
                calcPriceBO.SaveGlobalEnvFee()
                cbImportClick.JSProperties("cpStrResult") = GetLocalResourceObject("SPARESIMPORTSUCCESS").ToString()
            End If
            builder.Append(vbCrLf)
            ConstructFile("================================================================================")
            WriteRowInFile(builder)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_SupplierDetail", "PriceFieImport", ex.ToString, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        Finally
            read.Dispose()
            'Deleting the Price file if it exists 
            If File.Exists(uploadsDirectory + fileName) Then
                File.Delete(uploadsDirectory + fileName)
            End If
        End Try
    End Sub
    Public Sub ConstructFile(ByVal param As String)
        Try
            builder.Append(param)
            builder.Append(vbCrLf)
            If (builder.Length + 100 >= max) Then
                WriteRowInFile(builder)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetail", "ConstructFile", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    Public Sub WriteRowInFile(ByVal builder As StringBuilder)
        Try
            Dim logfile As FileStream
            Dim objStreamWriter As StreamWriter

            logfile = New FileStream(logfilepath, FileMode.Append, FileAccess.Write)
            objStreamWriter = New StreamWriter(logfile)
            objStreamWriter.WriteLine(builder)
            objStreamWriter.Close()

            'closing the file stream
            logfile.Close()

            builder.Remove(0, builder.Length)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetail", "WriteRowInFile", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub
    Private Sub WriteGlobalLog(ByVal errormsg As String, Optional ByVal iditem As String = "")
        Try
            builder.Append(vbCrLf)
            If iditem <> "" Then
                ConstructFile(iditem + " - " + errormsg)
            Else
                ConstructFile(errormsg)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetail", "WriteLog", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub
    Public Function RemoveSpecialCharacters(originalString As String) As String
        Dim returnString As String = originalString
        returnString = Regex.Replace(originalString, "[^0-9a-zA-Z\w]+", "") '. ^ $ * + - ? ( ) [ ] { } \ | — /
        Return returnString
    End Function
    Public Sub getCurrDateTime()
        Dim dsSetDate As DataSet
        Try
            dsSetDate = commonUtil.FetchCurrentDateTime()
            serverdate = commonUtil.GetCurrentLanguageDate(dsSetDate.Tables(0).Rows(0).Item(0).ToString)
            servertime = dsSetDate.Tables(0).Rows(0).Item(1).ToString
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetail", "getCurrDateTime", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub cbSparePartGroup_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            _calculatePrice.SuppCurrNo = IIf(hdnSuppCurNo.Text = "" Or hdnSuppCurNo.Text = Nothing, Nothing, hdnSuppCurNo.Text.Trim)

            Dim spGroup As DataSet = _calculatePrice.FetchSparePartGroup()
            If (spGroup.Tables.Count > 0) Then
                spGroup.Tables(0).TableName = "SparePartGroup"
            End If
            If (spGroup.Tables("SparePartGroup").Rows.Count > 0) Then
                ddlSparePartGroup.DataSource = spGroup.Tables("SparePartGroup")
                ddlSparePartGroup.ValueField = "ID_ITEM_CATG"
                ddlSparePartGroup.TextField = "CATEGORY"
                ddlSparePartGroup.DataBind()
            End If
            ddlSparePartGroup.Items.Insert(0, New ListEditItem(Session("Select"), "0"))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SupplierDetail", "cbSparePartGroup_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
End Class
