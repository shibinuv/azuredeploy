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
Imports System.Globalization
Imports System.Threading

Public Class LocalSPDetail
    Inherits System.Web.UI.Page
    Shared objVehicleService As New CARS.CoreLibrary.CARS.Services.Vehicle.VehicleDetails
    Shared objCustService As New CARS.CoreLibrary.CARS.Services.Customer.CustomerDetails
    Shared objItemsService As New CARS.CoreLibrary.CARS.Services.Items.ItemsDetail
    Shared objVehBo As New VehicleBO
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of VehicleBO)()
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared _loginName As String
    Shared loginName As String
    Shared objCustomerService As New Customer.CustomerDetails
    Shared objCVehSrv As New Services.ConfigVehicle.ConfigVehicle
    Shared configDetails As New List(Of ConfigVehicleBO)()
    Shared objConfigWHServ As New Services.ConfigWarehouse.ConfigWarehouse
    Shared wareHouseDetails As New List(Of ConfigWarehouseBO)()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim strscreenName As String
            Dim dtCaption As DataTable
            _loginName = CType(Session("UserID"), String)
            loginName = CType(Session("UserID"), String)
            txtStockAdjSignature.Text = _loginName
            If Not IsPostBack Then
                dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)

                strscreenName = IO.Path.GetFileName(Me.Request.PhysicalPath)
                hdnSelect.Value = dtCaption.Select("TAG='select'")(0)(1)




            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function saveNewItem(ByVal supplier As String, ByVal item_catg As String, ByVal id_item As String, ByVal item_desc As String, ByVal id_wh As String) As String()
        Dim strResult As String()
        Dim dsReturnValStr As String = ""

        Try

            strResult = objItemsService.saveNewItem(supplier, item_catg, id_item, item_desc, id_wh)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "saveNewItem", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function


    <WebMethod()>
    Public Shared Function get_campaignprices(ByVal id_item As String, ByVal suppcurrentno As String) As ItemsBO()
        Dim itemDetails As New List(Of ItemsBO)()
        Try
            itemDetails = objItemsService.get_campaignprices(id_item, suppcurrentno)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "get_campaignprices", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return itemDetails.ToList.ToArray
    End Function


    <WebMethod()>
    Public Shared Function addCampaignPrice(ByVal suppcurrentno As String, ByVal id_item As String, ByVal start_date As String, ByVal end_date As String, ByVal price As String) As String()
        Dim strResult As String()
        Dim dsReturnValStr As String = ""

        Try

            strResult = objItemsService.addCampaignPrice(suppcurrentno, id_item, start_date, end_date, price)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "addCampaignPrice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function InsertSparePart(ByVal SparePart As String) As String()
        Dim strResult As String()
        Dim dsReturnValStr As String = ""
        Dim spare As ItemsBO = JsonConvert.DeserializeObject(Of ItemsBO)(SparePart)
        Try
            Console.WriteLine(spare.ID_ITEM)
            strResult = objItemsService.Insert_SparePart(spare)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "InsertSparePart", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function FetchMVRDetails(ByVal regNo As String) As VehicleBO()
        Try
            details = objVehicleService.GetMVRData(regNo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "FetchMVRDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return details.ToList.ToArray
    End Function


    <WebMethod()>
    Public Shared Function GetVehGroup(ByVal VehGrp As String) As List(Of String)
        Dim retVehGroup As New List(Of String)()
        Try
            retVehGroup = objVehicleService.GetVehGroup(VehGrp)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "GetVehGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return retVehGroup
    End Function
    <WebMethod()>
    Public Shared Function GetFuelCode(ByVal FuelCode As String) As List(Of String)
        Dim retFuelCode As New List(Of String)()
        Try
            retFuelCode = objVehicleService.GetFuelCode(FuelCode)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "GetFuelCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return retFuelCode
    End Function

    <WebMethod()>
    Public Shared Function GetWareHouse(ByVal WH As String) As List(Of String)
        Dim retWareHouse As New List(Of String)()
        Try
            retWareHouse = objVehicleService.GetWareHouse(WH)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "GetWareHouse", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return retWareHouse
    End Function

    <WebMethod()>
    Public Shared Function LoadWarehouseDetails() As ConfigWarehouseBO()
        Try
            wareHouseDetails = objConfigWHServ.GetWarehouseDetails(_loginName.ToString)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadWarehouseDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return wareHouseDetails.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetZipCodes(ByVal zipCode As String) As List(Of String)
        Dim retZipCodes As New List(Of String)()
        Try
            retZipCodes = commonUtil.getZipCodes(zipCode, loginName)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "GetZipCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return retZipCodes
    End Function
    <WebMethod()>
    Public Shared Function FetchVehicleDetails(ByVal refNo As String, ByVal regNo As String, ByVal vehId As String) As VehicleBO()
        Dim vehDetails As New List(Of VehicleBO)()
        Try
            If (refNo <> "" Or vehId <> "" Or regNo <> "") Then
                vehDetails = objVehicleService.FetchVehicleDetails(refNo, regNo, vehId)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return vehDetails.ToList.ToArray
    End Function
    <WebMethod()>
    Public Shared Function LoadNewUsedCode() As VehicleBO()
        Dim newUsedList As New List(Of VehicleBO)()
        Try
            newUsedList = objVehicleService.FetchNewUsedCode()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadWarrantyCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return newUsedList.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetNewUsedRefNo(ByVal refNo As String) As VehicleBO()
        Dim newUsedList As New List(Of VehicleBO)()
        Try
            newUsedList = objVehicleService.GetNewUsedRefNo(refNo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "GetNewUsedRefNo", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return newUsedList.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function SetNewUsedRefNo(ByVal refNoType As String, ByVal refNo As String) As VehicleBO()
        Dim newUsedList As New List(Of VehicleBO)()
        Try
            newUsedList = objVehicleService.SetNewUsedRefNo(refNoType, refNo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SetNewUsedRefNo", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return newUsedList.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadStatusCode() As VehicleBO()
        Dim statusList As New List(Of VehicleBO)()
        Try
            statusList = objVehicleService.FetchStatusCode()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadStatusCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return statusList.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadMakeCode() As VehicleBO()
        Dim Make As New List(Of VehicleBO)()
        Try
            Make = objItemsService.LoadMakeCode()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadMakeCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function SaveSpCatgDetails(ByVal idSupplier As String, ByVal catg As String, ByVal desc As String, ByVal mode As String) As String()
        Dim strRes As String()
        Try
            Dim objItemsBO As New ItemsBO
            objItemsBO.ID_ITEM_DISC_CODE_BUYING = "0"
            objItemsBO.ID_ITEM_DISC_CODE_SELL = "0"
            objItemsBO.ID_SUPPLIER_ITEM = IIf(idSupplier = "0", Nothing, idSupplier)
            objItemsBO.ID_MAKE = ""
            objItemsBO.CATEGORY = catg
            objItemsBO.DESCRIPTION = desc
            objItemsBO.INITIALCLASSCODE = ""
            objItemsBO.ID_VAT_CODE = "0"
            objItemsBO.ACCOUNT_CODE = "0"
            objItemsBO.FLG_ALLOW_BCKORD = 0
            objItemsBO.FLG_CNT_STOCK = 0
            objItemsBO.FLG_ALLOW_CLASSIFICATION = 0
            objItemsBO.CREATED_BY = "22admin"

            If (mode = "Edit") Then
                strRes = objItemsService.UpdSpCatgDetails(objItemsBO)
            ElseIf mode = "Add" Then
                strRes = objItemsService.AddSpCatgDetails(objItemsBO)
            End If


        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SaveSpCatgDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strRes
    End Function

    <WebMethod()>
    Public Shared Function LoadCategory(ByVal q As String) As ItemsBO()
        Dim Category As New List(Of ItemsBO)()
        Try
            Category = objItemsService.LoadCategory(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadCategory", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Category.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadUnitItem() As ItemsBO()
        Dim Unit As New List(Of ItemsBO)()
        Try
            Unit = objItemsService.LoadUnitItem()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadUnitItem", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Unit.ToList.ToArray()
    End Function

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function SparePart_Search1(ByVal q As String) As ItemsBO()
        Dim spareDetails As New List(Of ItemsBO)()
        Try
            spareDetails = objItemsService.SparePartSearch(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SparePart_Search1", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails.ToList.ToArray
    End Function

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function Supplier_Search(ByVal q As String) As ItemsBO()
        Dim supDetails As New List(Of ItemsBO)()
        Try
            supDetails = objItemsService.SupplierSearch(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Supplier_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return supDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function FetchSparePartDetails(ByVal spareId As String) As ItemsBO()
        Dim spareDetails As New List(Of ItemsBO)()
        Try
            spareDetails = objItemsService.FetchSparePartDetails(spareId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "FetchSparePartDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails.ToList.ToArray
    End Function
    <WebMethod()>
    Public Shared Function FetchItemsDetail(ByVal ID_ITEM_ID As String, ByVal ID_ITEM_MAKE As String, ByVal ID_ITEM_WH As String)
        Dim itemsDetail As New ItemsBO
        Dim itemsRes As New ItemsBO
        itemsDetail.ID_ITEM = ID_ITEM_ID
        itemsDetail.ID_WH_ITEM = ID_ITEM_WH
        itemsDetail.ID_MAKE = ID_ITEM_MAKE

        Try
            itemsRes = objItemsService.Fetch_Items_Detail(itemsDetail)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "FetchItemsDetail", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return itemsRes
        'Return JsonConvert.SerializeObject(itemsRes)
    End Function

    <WebMethod()>
    Public Shared Function LoadEditMake() As VehicleBO()
        Dim EditMake As New List(Of VehicleBO)()
        Try
            EditMake = objVehicleService.FetchEditMake()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadEditMake", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return EditMake.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetEditMake(ByVal makeId As String) As VehicleBO()
        Dim EditMake As New List(Of VehicleBO)()
        Try
            EditMake = objVehicleService.GetEditMake(makeId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "GetEditMake", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return EditMake.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function AddEditMake(ByVal editMakeCode As String, ByVal editMakeDesc As String, ByVal editMakePriceCode As String, ByVal editMakeDiscount As String, ByVal editMakeVat As String, ByVal mode As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Dim strXMLSettingsVehMake As String = ""
        Dim strXMLSettingsModel As String = ""
        Try
            If mode = "add" Then
                strXMLSettingsVehMake = "<root><insert ID_MAKE= """ + editMakeCode + """ ID_MAKE_NAME= """ + editMakeDesc + """ ID_MAKE_PRICECODE= """ + editMakePriceCode + """ MAKEDISCODE= """ + editMakeDiscount + """ MAKE_VATCODE= """ + editMakeVat + """ /></root>"
                strXMLSettingsModel = "<ROOT></ROOT>"
                'objVehBo.MakeCode = editMakeCode
                'objVehBo.MakeName = editMakeDesc
                'objVehBo.Cost_Price = editMakePriceCode
                'objVehBo.Description = editMakeDiscount
                'objVehBo.VanNo = editMakeVat
                strResult = objVehicleService.Add_EditMake(strXMLSettingsVehMake)
            Else
                strXMLSettingsVehMake = "<ROOT><MODIFY ID_MAKE= """ + editMakeCode + """ ID_MAKE_NAME= """ + editMakeDesc + """ ID_MAKE_PRICECODE= """ + editMakePriceCode + """ MAKEDISCODE= """ + editMakeDiscount + """ MAKE_VATCODE= """ + editMakeVat + """ /></ROOT>"
                strXMLSettingsModel = "<ROOT></ROOT>"
                configDetails = objCVehSrv.UpdateVehMakeModelConfig(strXMLSettingsVehMake, strXMLSettingsModel, loginName)
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "AddEditMake", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function DeleteEditMake(ByVal editMakeId As String) As VehicleBO()
        Dim EditMake As New List(Of VehicleBO)()
        Try
            'EditMake = objVehicleService.DeleteBranch(editMakeId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "DeleteEditMake", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return EditMake.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function FetchModel(ByVal IdMake As String, ByVal Model As String) As String
        Dim IdModel As String = ""
        Try
            IdModel = objVehicleService.GetModel(IdMake, Model)

        Catch exth As System.Threading.ThreadAbortException
            Throw exth
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "FetchModel", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return IdModel.ToString()
    End Function
    <WebMethod()>
    Public Shared Function LoadModel() As VehicleBO()
        Try
            details = objVehicleService.LoadModel()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "LoadModel", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function FetchItemsHistory(ByVal ID_ITEM As String, ByVal ID_MAKE As String, ByVal ID_WAREHOUSE As String)
        Dim itemsHistory As New List(Of ItemsBO.ItemsHistory)()
        Try
            itemsHistory = objItemsService.Fetch_ItemsHistory(ID_ITEM, ID_MAKE, ID_WAREHOUSE)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "FetchItemsHistory", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return itemsHistory.ToList
    End Function


    <WebMethod()>
    Public Shared Function SparePart_Search(ByVal q As String, ByVal mustHaveQuantity As String, ByVal isStockItem As String, ByVal isNotStockItem As String, ByVal loc As String, ByVal supp As String, ByVal nonStock As Boolean, ByVal accurateSearch As Boolean) As ItemsBO()

        Dim itemDetails As New List(Of ItemsBO)()
        Try
            itemDetails = objItemsService.SparePartPopup(q, mustHaveQuantity, isStockItem, isNotStockItem, loc, supp, nonStock, accurateSearch)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SparePart_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return itemDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function SparePart_Search_Only_SparePart(ByVal q As String) As ItemsBO()


        Dim itemDetails As New List(Of ItemsBO)()
        Try
            itemDetails = objItemsService.SparePart_Search_Only_SparePart(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SparePart_Search_Only_SparePart", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return itemDetails.ToList.ToArray
    End Function


    <WebMethod()>
    Public Shared Function SparePart_Search_Short(ByVal q As String, ByVal supp As String) As ItemsBO()

        If (supp Is Nothing Or supp = "") Then
            supp = "%"
        End If
        If (q Is Nothing Or q = "") Then
            q = "%"
        End If
        Dim must As String = False
        Dim isStock As String = False
        Dim isNon As String = False
        Dim loc As String = "%"
        Dim nonstock As String = False


        Dim itemDetails As ItemsBO()
        Try
            itemDetails = SparePart_Search(q, must, isStock, isNon, loc, supp, nonstock, False)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SparePart_Search_Short", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return itemDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function Fetch_replacement_items(ByVal supp_currentno As String, ByVal id_item As String) As List(Of ItemsBO)

        Dim Orders As New List(Of ItemsBO)
        Try
            Orders = objItemsService.Fetch_replacement_items(supp_currentno, id_item)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Fetch_replacement_items", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return Orders
    End Function

    <WebMethod()>
    Public Shared Function Fetch_Orders(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As List(Of ItemsBO)

        Dim Orders As New List(Of ItemsBO)
        Try
            Orders = objItemsService.Fetch_Orders(id_item, supplier, catg, functionValue)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Fetch_Orders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return Orders
    End Function
    <WebMethod()>
    Public Shared Function Fetch_PurchaseOrders(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As List(Of ItemsBO)

        Dim PurchaseOrders As New List(Of ItemsBO)
        Try
            PurchaseOrders = objItemsService.Fetch_PurchaseOrders(id_item, supplier, catg, functionValue)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return PurchaseOrders
    End Function
    <WebMethod()>
    Public Shared Function Fetch_StockAdjustments(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As List(Of ItemsBO)

        Dim StockAdjustments As New List(Of ItemsBO)
        Try
            StockAdjustments = objItemsService.Fetch_StockAdjustments(id_item, supplier, catg, functionValue)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Fetch_StockAdjustments", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return StockAdjustments
    End Function
    <WebMethod()>
    Public Shared Function UpdateStockAdjustmentValue(ByVal id_item As String, ByVal supplier As String, ByVal category As String, ByVal warehouse As String, ByVal oldqty As String, ByVal changedqty As String, ByVal newqty As String, ByVal signature As String, ByVal comment As String) As ItemsBO()
        Dim getStockAdjustmentValue As New List(Of ItemsBO)()
        Try
            getStockAdjustmentValue = objItemsService.UpdateStockAdjustmentValue(id_item, supplier, category, warehouse, oldqty, changedqty, newqty, signature, comment)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "UpdateStockAdjustmentValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return getStockAdjustmentValue.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function UpdateStockQty(ByVal id_item As String, ByVal supplier As String, ByVal category As String, ByVal warehouse As String, ByVal newqty As String) As ItemsBO()
        Dim getStockQty As New List(Of ItemsBO)()
        Try
            getStockQty = objItemsService.UpdateStockQty(id_item, supplier, category, warehouse, newqty)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "UpdateStockQty", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return getStockQty.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function UpdatePriceAdjustment(ByVal id_item As String, ByVal supplier As String, ByVal category As String, ByVal warehouse As String, ByVal oldprice As Decimal, ByVal changedprice As Decimal, ByVal newprice As Decimal, ByVal signature As String, ByVal comment As String) As ItemsBO()
        Dim getPriceAdjustmentValue As New List(Of ItemsBO)()
        Try
            getPriceAdjustmentValue = objItemsService.UpdatePriceAdjustment(id_item, supplier, category, warehouse, oldprice, changedprice, newprice, signature, comment)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "UpdatePriceAdjustment", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return getPriceAdjustmentValue.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function Fetch_PriceAdjustments(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As List(Of ItemsBO)

        Dim StockAdjustments As New List(Of ItemsBO)
        Try
            StockAdjustments = objItemsService.Fetch_PriceAdjustments(id_item, supplier, catg, functionValue)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Fetch_PriceAdjustments", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return StockAdjustments
    End Function

    <WebMethod()>
    Public Shared Function Fetch_DiscountCodes(ByVal q As String, ByVal supplier As String) As ItemsBO()
        Dim spareDetails As New List(Of ItemsBO)()
        Try
            spareDetails = objItemsService.Fetch_DiscountCodes(q, supplier)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Fetch_DiscountCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function FetchBasicCalcVal(ByVal discount As String, ByVal supplier As String) As ItemsBO()
        Dim getPriceAdjustmentValue As New List(Of ItemsBO)()
        Try
            getPriceAdjustmentValue = objItemsService.FetchBasicCalcVal(discount, supplier)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "FetchBasicCalcVal", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return getPriceAdjustmentValue.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function return_item(ByVal returned_item As String) As Integer
        Dim strResult As Integer

        Dim returned_it As ItemsBO = JsonConvert.DeserializeObject(Of ItemsBO)(returned_item)
        Try
            strResult = objItemsService.return_item(returned_it)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "return_item", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function


    <WebMethod()>
    Public Shared Function SaveImportableItem(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim itemImportable As ItemImportableBO = JsonConvert.DeserializeObject(Of ItemImportableBO)(item)
        Try
            strResult = objItemsService.SaveImportableItem(itemImportable)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SaveImportableItem", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function Add_PO_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim POitem As PurchaseOrderItemsBO = JsonConvert.DeserializeObject(Of PurchaseOrderItemsBO)(item)
        Try
            strResult = objItemsService.Add_PO_Item(POitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "Add_PO_Item", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function SaveReplacements(ByVal mainItem As String, ByVal prevItem As String, ByVal newItem As String, ByVal suppCurrentno As String) As String
        Dim strResult As String
        Try
            strResult = objItemsService.AddReplacements(mainItem, prevItem, newItem, suppCurrentno)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "SaveReplacements", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function GetReplacementList(ByVal item As String, ByVal supp As String, ByVal catg As String) As List(Of ItemsBO)
        Dim strResult As New List(Of ItemsBO)()
        Try

            strResult = objItemsService.GetReplacementList(item, supp, catg)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "GetReplacementList", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function
    Protected Overrides Sub InitializeCulture()
        Try
            MyBase.InitializeCulture()
            If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
                Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
                Thread.CurrentThread.CurrentCulture = ci
                Thread.CurrentThread.CurrentUICulture = ci
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_LocalSPDetail", "InitializeCulture", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

End Class


