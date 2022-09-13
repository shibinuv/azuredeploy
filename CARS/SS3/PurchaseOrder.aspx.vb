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
Imports System.Web.Script.Serialization
Imports System.Windows
Imports System.Net.Mail
Imports DevExpress.XtraReports.Web

Public Class PurchaseOrder
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of ConfigDepartmentBO)()
    Shared objConfigDeptBO As New ConfigDepartmentBO
    Shared objConfigDeptDO As New Department.ConfigDepartmentDO
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared _loginName As String
    Shared POservice As New Services.PurchaseOrder.PurchaseOrder
    Shared objPODO As New PurchaseOrderDO
    Shared wareHouseDetails As New List(Of ConfigWarehouseBO)()
    Shared objConfigWHServ As New Services.ConfigWarehouse.ConfigWarehouse
    Shared objItemsService As New Items.ItemsDetail
    Shared objSupplierBO As New SupplierBO


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            EnableViewState = False
            Dim strscreenName As String
            Dim dtCaption As DataTable
            _loginName = CType(Session("UserID"), String)

            If Not IsPostBack Then
                dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)

                strscreenName = IO.Path.GetFileName(Me.Request.PhysicalPath)
                hdnSelect.Value = dtCaption.Select("TAG='select'")(0)(1)

            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function SavePurchaseOrderHead(ByVal PurchaseOrderHead As String) As Integer
        Dim strResult As Integer

        Dim POheader As PurchaseOrderHeaderBO = JsonConvert.DeserializeObject(Of PurchaseOrderHeaderBO)(PurchaseOrderHead)
        Try
            strResult = POservice.SavePurchaseOrder(POheader)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function



    <WebMethod()>
    Public Shared Function importPOitemsFromWO(ByVal supp_currentno As String, ByVal id_ordertype As String) As List(Of PurchaseOrderItemsBO)

        Dim purchaseOrderItems As New List(Of PurchaseOrderItemsBO)()
        Try
            purchaseOrderItems = POservice.importPOitemsFromWO(supp_currentno, id_ordertype)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return purchaseOrderItems
    End Function

    <WebMethod()>
    Public Shared Function Add_PO_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim POitem As PurchaseOrderItemsBO = JsonConvert.DeserializeObject(Of PurchaseOrderItemsBO)(item)
        Try
            strResult = POservice.Add_PO_Item(POitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function updateArrivalPOitem(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim POitem As PurchaseOrderItemsBO = JsonConvert.DeserializeObject(Of PurchaseOrderItemsBO)(item)
        Try
            strResult = POservice.updateArrivalPOitem(POitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function FetchCurrentDepartment() As ConfigDepartmentBO()
        Try
            objConfigDeptBO.LoginId = HttpContext.Current.Session("UserID").ToString
            details = commonUtil.FetchAllDepartment(objConfigDeptBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfDepartment", "FetchAllDepartments", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return details.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadWarehouseDetails() As ConfigWarehouseBO()
        Try
            wareHouseDetails = objConfigWHServ.GetWarehouseDetails(_loginName.ToString)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_Config_Warehouse", "LoadWarehouseDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return wareHouseDetails.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GeneratePOnumber(ByVal deptID As Integer, ByVal warehouseID As Integer) As String()
        Dim poNumAndPrefix(1) As String
        Try
            poNumAndPrefix = POservice.generate_PO_number(deptID, warehouseID)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return poNumAndPrefix
    End Function

    <WebMethod()>
    Public Shared Function Fetch_PurchaseOrders(ByVal POnum As String, ByVal supplier As String, ByVal fromDate As Integer, ByVal toDate As Integer, ByVal spareNumber As String, ByVal isDelivered As String, ByVal isConfirmedOrder As String, ByVal isUnconfirmedOrder As String, ByVal isExactPOnum As String, ByVal isExactSupp As String) As List(Of PurchaseOrderHeaderBO)

        Dim purchaseOrders As New List(Of PurchaseOrderHeaderBO)()
        Try
            purchaseOrders = POservice.FetchPurchaseOrders(POnum, supplier, fromDate, toDate, spareNumber, isDelivered, isConfirmedOrder, isUnconfirmedOrder, isExactPOnum, isExactSupp)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return purchaseOrders
    End Function

    <WebMethod()>
    Public Shared Function stupidtest(ByVal name As String, ByVal age As String)

        Dim purchaseOrders As New List(Of PurchaseOrderHeaderBO)()
        Try
            Dim s As String
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return purchaseOrders
    End Function


    <WebMethod()>
    Public Function updateItemStock(ByVal supp_currentno As String, ByVal id_item As String, ByVal id_item_catg As String, ByVal items_delivered As Decimal, ByVal id_warehouse As String) As Integer

        Dim res As Integer
        Try
            res = POservice.updatePOitem(supp_currentno, id_item, id_item_catg, items_delivered, id_warehouse)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return res
    End Function
    <WebMethod()>
    Public Shared Function Fetch_PO_Items(ByVal POnum As String, ByVal isDeliveryTable As Boolean, ByVal supp_currentno As String) As List(Of PurchaseOrderItemsBO)

        Dim purchaseOrderItems As New List(Of PurchaseOrderItemsBO)()
        Try
            purchaseOrderItems = POservice.Fetch_PO_Items(POnum, isDeliveryTable, supp_currentno)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return purchaseOrderItems
    End Function

    <WebMethod()>
    Public Shared Function generate_automatic_suggestion(ByVal supp_currentno As String, ByVal method As String, ByVal order_max As Boolean) As List(Of PurchaseOrderItemsBO)

        Dim purchaseOrderItems As New List(Of PurchaseOrderItemsBO)()
        Try
            purchaseOrderItems = POservice.generate_automatic_suggestion(supp_currentno, method, order_max)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return purchaseOrderItems
    End Function



    <WebMethod()>
    Public Shared Function fetch_po_items_indelivery(ByVal POnum As String, ByVal supp_currentno As String, ByVal id_item As String) As Decimal

        Dim indelivery As Decimal
        Try
            indelivery = objPODO.fetch_po_items_indelivery(POnum, supp_currentno, id_item)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return indelivery
    End Function




    <WebMethod()>
    Public Shared Function updatePOitem(ByVal ponumber As String, ByVal orderqty As String, ByVal buycost As String, ByVal totalcost As String, ByVal delivered As Boolean) As Integer


    End Function

    <WebMethod()>
    Public Shared Function openMail() As Integer
        'Dim mailMessage As New MailMessage()
        'Dim filename As String = AppDomain.CurrentDomain.BaseDirectory + "\mymessage.eml"
        'mailMessage.Save(filename)

        Process.Start("mailto:mail@example.com?subject=Hello&body=Test")
        Return 1
    End Function


    <WebMethod()>
    Public Shared Function deletePOitem(ByVal ponumber As String, ByVal id_woitem_seq As Integer, ByVal id_item As String) As Integer
        Dim login As String = HttpContext.Current.Session("UserID")
        Dim res As Integer
        Try
            res = objPODO.deletePOitem(ponumber, id_woitem_seq, id_item, login)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return res
    End Function

    <WebMethod()>
    Public Shared Function deletePO(ByVal ponumber As String) As Integer
        Dim login As String = HttpContext.Current.Session("UserID")
        Dim res As Integer
        Try
            res = objPODO.deletePO(ponumber, login)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return res
    End Function

    <WebMethod()>
    Public Shared Function insert_global_to_item_master(ByVal supp_currentno As String, ByVal id_item As String, ByVal id_item_catg As String, ByVal id_warehouse As Integer) As Integer
        Dim login As String = HttpContext.Current.Session("UserID")
        Dim res As Integer
        Try
            res = POservice.insert_global_to_item_master(supp_currentno, id_item, id_item_catg, id_warehouse)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return res
    End Function
    <WebMethod()>
    Public Shared Function setPOtoSent(ByVal ponumber As String, ByVal sentorfinished As Boolean) As Integer

        Dim res As Integer
        Try
            res = POservice.setPOtoSent(ponumber, sentorfinished)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return res
    End Function

    ''SPAREPART SEARCH FUNCTIONS. NEARLY EQUIVALENT TO THOSE IN LOCALSPDETAIL.ASPX.VB. MUCH TIDIER TO HAVE THEM HERE 
    <WebMethod()>
    Public Shared Function SparePart_Search(ByVal q As String, ByVal mustHaveQuantity As String, ByVal isStockItem As String, ByVal isNotStockItem As String, ByVal loc As String, ByVal supp As String, ByVal nonStock As Boolean, ByVal accurateSearch As String) As ItemsBO()

        Dim itemDetails As New List(Of ItemsBO)()
        Try
            itemDetails = objItemsService.SparePartPopup(q, mustHaveQuantity, isStockItem, isNotStockItem, loc, supp, nonStock, accurateSearch)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "SparePart_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return itemDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function SparePart_Search_Short(ByVal q As String, ByVal supp As String, ByVal accurateSearch As String) As ItemsBO()

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
            itemDetails = SparePart_Search(q, must, isStock, isNon, loc, supp, nonstock, accurateSearch)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "SparePart_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return itemDetails.ToList.ToArray
    End Function




    <WebMethod()>
    Public Shared Function Fetch_PO_id(ByVal ponum As String) As Integer

        Dim id As Integer
        Try
            id = objPODO.Fetch_PO_id(ponum)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "SparePart_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return id
    End Function

    <WebMethod()>
    Public Shared Function getCostPrice(ByVal itemID As String, ByVal suppcurrentno As String, ByVal orderType As String) As Decimal

        Dim costPrice As Decimal
        Try
            costPrice = objPODO.getCostPrice(itemID, suppcurrentno, orderType)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "SparePart_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

        Return costPrice
    End Function



    <WebMethod()>
    Public Shared Function getOrdertypes(ByVal suppcurrentno As String, ByVal id As String) As SupplierBO()
        Dim ordertypes As New List(Of SupplierBO)()
        Try
            ordertypes = POservice.getOrdertypes(suppcurrentno, id)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return ordertypes.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function addOrdertype(ByVal ordertype As String, ByVal suppcurrentno As String, ByVal description As String, ByVal pricetype As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Try
            objSupplierBO.SUPP_ORDERTYPE = ordertype
            objSupplierBO.SUPP_ORDERTYPE_DESC = description
            objSupplierBO.SUPP_CURRENTNO = suppcurrentno
            objSupplierBO.PRICETYPE = pricetype
            objSupplierBO.CREATED_BY = _loginName


            strResult = POservice.addOrdertype(objSupplierBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function



    <WebMethod()>
    Public Shared Function generate_automatic_po_items(ByVal supp_currentno As String, ByVal id_item_from As String, ByVal id_item_to As String, ByVal main_method As String, ByVal id_warehouse As String) As List(Of PurchaseOrderItemsBO)

        Dim purchaseOrderItems As New List(Of PurchaseOrderItemsBO)()
        Try
            purchaseOrderItems = POservice.generate_automatic_po_items(supp_currentno, id_item_from, id_item_to, main_method, id_warehouse)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return purchaseOrderItems
    End Function
    Protected Sub cbPanel_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Dim myRep
        Dim cbParam As String = e.Parameter
        Dim cbParams As String() = cbParam.Split(";")
        If cbParam.Length > 1 Then
            Dim PONum As String = cbParams(0).Trim
            Dim RepType As String = cbParams(1).Trim
            If RepType = "ODR" Then
                myRep = New dxPOReport()
                myRep.Parameters("paramPONum").Value = PONum
            ElseIf RepType = "ALL" Then
                myRep = New dxPOReportAllSpr()
                myRep.Parameters("paramPONum").Value = PONum
                myRep.Parameters("paramUserId").Value = _loginName
            End If

            myRep.RequestParameters = False
            Dim cachedReportSource = New CachedReportSourceWeb(myRep)
            Session("ReportSource") = cachedReportSource
        End If
    End Sub

    Protected Sub cbBOReport_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Dim myRep


        myRep = New dxPurchaseOrderBOReady()

        myRep.RequestParameters = False
        Dim cachedReportSource = New CachedReportSourceWeb(myRep)
        Session("ReportSource") = cachedReportSource

    End Sub
End Class

