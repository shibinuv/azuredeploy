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
Imports DevExpress.XtraReports.Web

Public Class CountingSystem
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of ConfigDepartmentBO)()
    Shared objConfigDeptBO As New ConfigDepartmentBO
    Shared objConfigDeptDO As New Department.ConfigDepartmentDO
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared _loginName As String
    Shared countingService As New Services.Counting.Counting
    Shared objCLDO As New CountingDO
    Shared wareHouseDetails As New List(Of ConfigWarehouseBO)()
    Shared objConfigWHServ As New Services.ConfigWarehouse.ConfigWarehouse
    Shared objItemsService As New Items.ItemsDetail

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
    Public Shared Function FetchCurrentDepartment() As ConfigDepartmentBO()
        Try
            objConfigDeptBO.LoginId = _loginName.ToString
            details = commonUtil.FetchAllDepartment(objConfigDeptBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfDepartment", "FetchAllDepartments", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
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
    Public Shared Function LoadUsers(ByVal deptID As String) As CountingBO()
        Dim Make As New List(Of CountingBO)()
        Try
            Make = countingService.LoadUsers(deptID)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GenerateCLnumber(ByVal deptID As Integer, ByVal warehouseID As Integer) As String()
        Dim clNumAndPrefix(1) As String
        Try
            clNumAndPrefix = countingService.generate_CL_number(deptID, warehouseID)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return clNumAndPrefix
    End Function


    <WebMethod()>
    Public Shared Function setCLnumber(ByVal deptID As Integer, ByVal warehouseID As Integer) As String()
        Dim clNumAndPrefix(1) As String
        Try
            clNumAndPrefix = countingService.set_CL_number(deptID, warehouseID)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return clNumAndPrefix
    End Function

    <WebMethod()>
    Public Shared Function Fetch_CL_Items(ByVal supplier As String, ByVal wh As String, ByVal sparefrom As String, ByVal spareto As String, ByVal locfrom As String, ByVal locto As String, ByVal stock As String, ByVal nolocation As String, ByVal sortby As String) As List(Of CountingBO)

        Dim countingItems As New List(Of CountingBO)()
        Try
            countingItems = countingService.Fetch_CL_Items(supplier, wh, sparefrom, spareto, locfrom, locto, stock, nolocation, sortby)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return countingItems
    End Function

    <WebMethod()>
    Public Shared Function Fetch_CountingListDetails(ByVal CLPrefix As String, ByVal CLNo As String, ByVal wh As String) As List(Of CountingBO)

        Dim countingItems As New List(Of CountingBO)()
        Try
            countingItems = countingService.FetchCountingListDetails(CLPrefix, CLNo, wh)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return countingItems
    End Function

    <WebMethod()>
    Public Shared Function Fetch_CL_No(ByVal supplier As String, ByVal wh As String, ByVal countingNo As String, ByVal closed As String, ByVal dateFrom As String, ByVal dateTo As String, ByVal spareNo As String) As List(Of CountingBO)

        Dim countingItems As New List(Of CountingBO)()
        Try
            countingItems = countingService.Fetch_CL_No(supplier, wh, countingNo, closed, dateFrom, dateTo, spareNo)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return countingItems
    End Function

    <WebMethod()>
    Public Shared Function Add_CL_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim CLitem As CountingBO = JsonConvert.DeserializeObject(Of CountingBO)(item)
        Try
            strResult = countingService.Add_CL_Item(CLitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function Update_CL_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        'Dim CLitem As CountingBO = JsonConvert.DeserializeObject(Of CountingBO)(item)
        Try
            strResult = countingService.Update_CL_Item(item)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function Close_CL_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim CLitem As CountingBO = JsonConvert.DeserializeObject(Of CountingBO)(item)
        Try
            strResult = countingService.Close_CL_Item(CLitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function Delete_CL_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim CLitem As CountingBO = JsonConvert.DeserializeObject(Of CountingBO)(item)
        Try
            strResult = countingService.Delete_CL_Item(CLitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function getLoginName() As String
        Return _loginName
    End Function

    <WebMethod()>
    Public Shared Function FetchCountingList(ByVal CLNo As String, ByVal wh As String) As List(Of CountingBO)

        Dim countingList As New List(Of CountingBO)()
        Try
            countingList = countingService.FetchCountingList(CLNo, wh)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return countingList
    End Function

    <WebMethod()>
    Public Shared Function FetchItemDetails(ByVal spareNo As String, ByVal itemQty As String, ByVal wh As String) As List(Of CountingBO)

        Dim countingItems As New List(Of CountingBO)()
        Try
            countingItems = countingService.FetchItemDetails(spareNo, itemQty, wh)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return countingItems
    End Function

    <WebMethod()>
    Public Shared Function FetchCountingReport(ByVal clprefix As String, ByVal clno As String, ByVal wh As String, ByVal login As String) As String
        Dim spareDetails As String = ""
        Try

            Dim myRep As New dxCountingList()
            myRep.Name = "Report Countinglist " + DateTime.Now
            myRep.RequestParameters = False
            myRep.Parameters("pclPrefix").Value = clprefix
            myRep.Parameters("pclNo").Value = clno
            myRep.Parameters("pWh").Value = wh
            myRep.Parameters("pLogin").Value = login



            '' myRep.ApplyLocalization(System.Configuration.ConfigurationManager.AppSettings("Culture"))
            HttpContext.Current.Session("myRep") = myRep
            'Dim cachedReportSource = New CachedReportSourceWeb(myRep)
            'HttpContext.Current.Session("ReportSource") = cachedReportSource

            spareDetails = "Success"

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "countingsystem", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails
    End Function

    <WebMethod()>
    Public Shared Function FetchCountingResult(ByVal clprefix As String, ByVal clno As String, ByVal wh As String, ByVal login As String) As String
        Dim spareDetails As String = ""
        Try

            Dim myRep As New dxCountingListResult()
            myRep.Name = "Report Countinglist Result " + DateTime.Now
            myRep.RequestParameters = False
            myRep.Parameters("pPrefix").Value = clprefix
            myRep.Parameters("pClno").Value = clno
            myRep.Parameters("pWh").Value = wh
            'myRep.Parameters("pLogin").Value = login



            '' myRep.ApplyLocalization(System.Configuration.ConfigurationManager.AppSettings("Culture"))
            HttpContext.Current.Session("myRep") = myRep
            'Dim cachedReportSource = New CachedReportSourceWeb(myRep)
            'HttpContext.Current.Session("ReportSource") = cachedReportSource

            spareDetails = "Success"

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "countingsystem", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return spareDetails
    End Function

    Protected Sub cbCountingList_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            If Not (HttpContext.Current.Session("myRep") Is Nothing) Then
                Dim cachedReportSource = New CachedReportSourceWeb(HttpContext.Current.Session("myRep"))
                HttpContext.Current.Session("ReportSource") = cachedReportSource
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "cbXtraCheck_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    Protected Sub cbCountingListResult_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            If Not (HttpContext.Current.Session("myRep") Is Nothing) Then
                Dim cachedReportSource = New CachedReportSourceWeb(HttpContext.Current.Session("myRep"))
                HttpContext.Current.Session("ReportSource") = cachedReportSource
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "cbXtraCheck_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

End Class