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
Imports DevExpress.Web
Imports DevExpress.XtraReports.Web
Imports System.Data.SqlClient

Public Class TireHotel
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of ConfigDepartmentBO)()
    Shared objConfigDeptBO As New ConfigDepartmentBO
    Shared objConfigDeptDO As New Department.ConfigDepartmentDO
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared _loginName As String
    Shared objSMSBO As New CARS.CoreLibrary.SendSMSBO
    Shared objSMSDO As New CARS.CoreLibrary.CARS.SendSMSDO.SendSMSDO
    Shared TirePackageService As New Services.TirePackage.TirePackage
    Shared objTPDO As New TirePackageDO
    Shared wareHouseDetails As New List(Of ConfigWarehouseBO)()
    Shared objConfigWHServ As New Services.ConfigWarehouse.ConfigWarehouse
    Shared sqlConnectionString As String
    Shared sqlConnection As SqlClient.SqlConnection
    Dim tirePackageNo As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            EnableViewState = False
            Dim strscreenName As String
            Dim dtCaption As DataTable
            _loginName = CType(Session("UserID"), String)
            sqlConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            sqlConnection = New SqlClient.SqlConnection(sqlConnectionString)
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
    Public Shared Function getLoginName() As String
        Return _loginName
    End Function

    <WebMethod()>
    Public Shared Function FetchCurrentDepartment() As ConfigDepartmentBO()
        Try
            objConfigDeptBO.LoginId = IIf(_loginName Is Nothing, HttpContext.Current.Session("UserID"), _loginName)
            details = commonUtil.FetchAllDepartment(objConfigDeptBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfDepartment", "FetchAllDepartments", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return details.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadWarehouseDetails() As ConfigWarehouseBO()
        Try
            wareHouseDetails = objConfigWHServ.GetWarehouseDetails(IIf(_loginName Is Nothing, HttpContext.Current.Session("UserID"), _loginName))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_Config_Warehouse", "LoadWarehouseDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return wareHouseDetails.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function Fetch_TP_List(ByVal wh As String, ByVal tpNo As String, ByVal closed As String, ByVal refNo As String, ByVal custNo As String, ByVal tireType As String, ByVal tireQuality As String) As List(Of TirePackageBO)

        Dim tirePackageItems As New List(Of TirePackageBO)()
        Try
            tirePackageItems = TirePackageService.Fetch_TP_List(wh, tpNo, closed, refNo, custNo, tireType, tireQuality)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return tirePackageItems
    End Function

    <WebMethod()>
    Public Shared Function LoadTireMake() As TirePackageBO()
        Dim Make As New List(Of TirePackageBO)()
        Try
            Make = TirePackageService.FetchTireMake()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadTireType() As TirePackageBO()
        Dim Make As New List(Of TirePackageBO)()
        Try
            Make = TirePackageService.FetchTireType()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function getTireType(ByVal value As String) As TirePackageBO()
        Dim Make As New List(Of TirePackageBO)()
        Try
            Make = TirePackageService.getTireType(value)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadTireSpike() As TirePackageBO()
        Dim Make As New List(Of TirePackageBO)()
        Try
            Make = TirePackageService.FetchTireSpike()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadTireRimType() As TirePackageBO()
        Dim Make As New List(Of TirePackageBO)()
        Try
            Make = TirePackageService.FetchTireRimType()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadTireQuality() As TirePackageBO()
        Dim Make As New List(Of TirePackageBO)()
        Try
            Make = TirePackageService.FetchTireQuality()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadTireDepth() As TirePackageBO()
        Dim Make As New List(Of TirePackageBO)()
        Try
            Make = TirePackageService.FetchTireDepth()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadMakeCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return Make.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function FindVehicleList(ByVal search As String) As List(Of TirePackageBO)

        Dim vehicleList As New List(Of TirePackageBO)()
        Try
            vehicleList = TirePackageService.FindVehicleList(search)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return vehicleList
    End Function

    <WebMethod()>
    Public Shared Function FetchVehicleDetails(ByVal refNo As String) As List(Of TirePackageBO)

        Dim vehicleItem As New List(Of TirePackageBO)()
        Try
            vehicleItem = TirePackageService.FetchVehicleDetails(refNo)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return vehicleItem
    End Function

    <WebMethod()>
    Public Shared Function FindCustomerList(ByVal search As String) As List(Of TirePackageBO)

        Dim vehicleList As New List(Of TirePackageBO)()
        Try
            vehicleList = TirePackageService.FindCustomerList(search)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return vehicleList
    End Function

    <WebMethod()>
    Public Shared Function FetchCustomerDetails(ByVal custNo As String) As List(Of TirePackageBO)

        Dim customerItem As New List(Of TirePackageBO)()
        Try
            customerItem = TirePackageService.FetchCustomerDetails(custNo)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return customerItem
    End Function

    <WebMethod()>
    Public Shared Function Add_TP_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim TPitem As TirePackageBO = JsonConvert.DeserializeObject(Of TirePackageBO)(item)
        Try
            strResult = TirePackageService.Add_TP_Item(TPitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function FetchTirePackageDetails(ByVal packageNo As String) As List(Of TirePackageBO)

        Dim packageItem As New List(Of TirePackageBO)()
        Try
            packageItem = TirePackageService.FetchTirePackageDetails(packageNo)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return packageItem
    End Function

    <WebMethod()>
    Public Shared Function Close_TP_Item(ByVal item As String) As Integer
        Dim strResult As Integer
        Dim TPitem As TirePackageBO = JsonConvert.DeserializeObject(Of TirePackageBO)(item)
        Try
            strResult = TirePackageService.Close_TP_Item(TPitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function AddTireDepth(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim TPDitem As TirePackageBO = JsonConvert.DeserializeObject(Of TirePackageBO)(item)
        Try
            strResult = TirePackageService.AddTireDepth(TPDitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function FetchTirePackageDepth(ByVal packageNo As String) As List(Of TirePackageBO)

        Dim packageItem As New List(Of TirePackageBO)()
        Try
            packageItem = TirePackageService.FetchTirePackageDepth(packageNo)
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try


        Return packageItem
    End Function

    <WebMethod()>
    Public Shared Function LoadListCustVehicle(ByVal custId As String) As TirePackageBO()
        Dim CustVehicle As New List(Of TirePackageBO)()
        Try
            CustVehicle = TirePackageService.LoadListCustVehicle(custId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return CustVehicle.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function Delete_TP_Item(ByVal item As String) As Integer
        Dim strResult As Integer
        Try
            strResult = TirePackageService.Delete_TP_Item(item)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder.aspx", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    Protected Sub rbOrdersMenu_Init(sender As Object, e As EventArgs)
        Try
            rbOrdersMenu.Items.Add(GetLocalResourceObject("rbCreateOrder"), "CreateNewOrder")
            rbOrdersMenu.Items.Add(GetLocalResourceObject("rbCreateOrderGoto"), "CreateNewGotoOrder")
            rbOrdersMenu.SelectedIndex = 0
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_TireHotel", "rbOrdersMenu_Init", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
    End Sub
    Protected Sub cbTransferOrder_Callback(source As Object, e As CallbackEventArgs)
        If e.Parameter <> "" Then
            Dim item As String = e.Parameter
            Try
                Dim TPitem As TirePackageBO = JsonConvert.DeserializeObject(Of TirePackageBO)(item)
                If hdnTransferOrder.Value = "CreateNewOrder" Then 'Not Implemented
                    Dim strResCreateOrder As String = ConvertTireHotelToOrder(TPitem.tireSeqNumber)
                    cbTransferOrder.JSProperties("cpOrderStatus") = strResCreateOrder
                ElseIf hdnTransferOrder.Value = "CreateNewGotoOrder" Then
                    Dim strResOrdGoTo As String = ConvertTireHotelToOrder(TPitem.tireSeqNumber)
                    Dim strOrd As String() = strResOrdGoTo.Split(";")
                    If strOrd.Length > 1 Then
                        If strOrd(0) = "INS" Then
                            Dim strWOPrefix As String = strOrd(1)
                            Dim strWONO As String = strOrd(2)
                            Dim strPath As String = "~/Transactions/frmWOJobDetails.aspx?Wonumber=" + strWONO + "&WOPrefix=" + strWOPrefix + "&Mode=Edit&TabId=2&Flag=Ser&blWOsearch=true"
                            ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute(strPath))
                        End If
                    End If
                End If

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Transaction_TireHotel", "cbTransferOrder_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
            End Try
        End If

    End Sub

    Public Function ConvertTireHotelToOrder(hireHotelSeqNo As String) As String
        Dim strRes As String = ""
        Try

            strRes = TirePackageService.CreateOrderOnTireHotel(hireHotelSeqNo, Session("UserID"))

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_TireHotel", "CreateOrderOnTireHotel", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strRes
    End Function

    <WebMethod()>
    Public Shared Function FetchDeliveryReport(ByVal number As String) As String
        Dim vehDetails As String = ""
        Try

            Dim myRep As New dxTireDeliveryReport()
            myRep.Name = "Report TireDelivery " + DateTime.Now
            myRep.RequestParameters = False
            myRep.Parameters("pTirePackageNo").Value = number



            ' myRep.ApplyLocalization(System.Configuration.ConfigurationManager.AppSettings("Culture"))
            HttpContext.Current.Session("myRep") = myRep
            'Dim cachedReportSource = New CachedReportSourceWeb(myRep)
            'HttpContext.Current.Session("ReportSource") = cachedReportSource

            vehDetails = "Success"

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return vehDetails
    End Function

    Protected Sub cbTireDelivery_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            If Not (HttpContext.Current.Session("myRep") Is Nothing) Then
                Dim cachedReportSource = New CachedReportSourceWeb(HttpContext.Current.Session("myRep"))
                HttpContext.Current.Session("ReportSource") = cachedReportSource
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "cbXtraCheck_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function GENERATE_TP_SELECTION(ByVal warehouse As String, ByVal department As String, ByVal tiretype As String, ByVal spikesornot As String, ByVal rimtype As String, ByVal tirebrand As String, ByVal tirequality As String, ByVal tiredepth As String, ByVal locationfrom As String, ByVal locationto As String) As TirePackageBO()
        Dim tpDetails As New List(Of TirePackageBO)()
        Try

            tpDetails = TirePackageService.GENERATE_TP_SELECTION(warehouse, department, tiretype, spikesornot, rimtype, tirebrand, tirequality, tiredepth, locationfrom, locationto)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return tpDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function FetchReportValues(ByVal warehouse As String, ByVal department As String, ByVal tiretype As String, ByVal spikesornot As String, ByVal rimtype As String, ByVal tirebrand As String, ByVal tirequality As String, ByVal tiredepth As String, ByVal locationfrom As String, ByVal locationto As String) As String
        Dim vehDetails As String = ""
        Try

            Dim myRep As New dxTireHotelSelection()
            myRep.Name = "Report Tire hotel selection " + DateTime.Now
            myRep.RequestParameters = False
            myRep.Parameters("pWarehouse").Value = warehouse
            myRep.Parameters("pDepartment").Value = department
            myRep.Parameters("pTireType").Value = tiretype
            myRep.Parameters("pSpikesornot").Value = spikesornot

            myRep.Parameters("pRimType").Value = rimtype
            myRep.Parameters("pTireBrand").Value = tirebrand
            myRep.Parameters("pTireQuality").Value = tirequality
            myRep.Parameters("pDepth").Value = tiredepth
            myRep.Parameters("pLocationFrom").Value = locationfrom
            myRep.Parameters("pLocationTo").Value = locationto


            ' myRep.ApplyLocalization(System.Configuration.ConfigurationManager.AppSettings("Culture"))
            HttpContext.Current.Session("myRep") = myRep
            'Dim cachedReportSource = New CachedReportSourceWeb(myRep)
            'HttpContext.Current.Session("ReportSource") = cachedReportSource

            vehDetails = "Success"

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return vehDetails
    End Function

    Protected Sub cbTPSelection_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            If Not (HttpContext.Current.Session("myRep") Is Nothing) Then
                Dim cachedReportSource = New CachedReportSourceWeb(HttpContext.Current.Session("myRep"))
                HttpContext.Current.Session("ReportSource") = cachedReportSource
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "cbXtraCheck_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function FillSMSTexts(ByVal type As String) As List(Of ListItem)

        Dim query As String = "SELECT [ID_MESSAGES], [COMMERCIAL_TEXT] FROM [TBL_MAS_DEPT_MESSAGES] where ID_DEPT='22' and MESSAGE_TYPE='" + type + "'"
        Dim constr As String = sqlConnectionString
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand(query)
                Dim texts As New List(Of ListItem)()
                cmd.CommandType = CommandType.Text
                cmd.Connection = con
                con.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    While sdr.Read()
                        texts.Add(New ListItem() With {
                  .Value = sdr("ID_MESSAGES").ToString(),
                  .Text = sdr("COMMERCIAL_TEXT").ToString()
                })
                    End While
                End Using
                con.Close()
                Return texts
            End Using
        End Using

    End Function

    <WebMethod()>
    Public Shared Function SaveMessageTemplate(ByVal tempId As String, ByVal tempText As String, ByVal tempType As String) As String
        Dim strRetVal As String = ""
        Try
            strRetVal = objSMSDO.SaveMessageTemplate(tempId, tempText, tempType, _loginName)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return strRetVal
    End Function

End Class