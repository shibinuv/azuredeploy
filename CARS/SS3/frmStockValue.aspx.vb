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

Public Class frmStockValue
    Inherits System.Web.UI.Page
    Shared commonUtil As New Utilities.CommonUtility
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of ConfigDepartmentBO)()
    Shared objConfigDeptBO As New ConfigDepartmentBO
    Shared objConfigDeptDO As New Department.ConfigDepartmentDO
    Shared wareHouseDetails As New List(Of ConfigWarehouseBO)()
    Shared objConfigWHServ As New Services.ConfigWarehouse.ConfigWarehouse
    Shared _loginName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            _loginName = CType(Session("UserID"), String)
            EnableViewState = False
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
    Public Shared Function FetchCountingReport(ByVal priceTypeValue As String, ByVal wh As String) As String
        Dim spareDetails As String = ""
        Try

            Dim myRep As New dxStockValue()
            myRep.Name = "Report Stockvalue " + DateTime.Now
            myRep.RequestParameters = False
            myRep.Parameters("pPriceTypeValue").Value = priceTypeValue
            myRep.Parameters("pWh").Value = wh




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

    Protected Sub cbStockValue_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
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