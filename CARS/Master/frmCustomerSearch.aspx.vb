Imports System.Data
Imports Encryption
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Net.WebRequest
Imports System.Net.HttpWebRequest
Imports System.Net.HttpWebResponse
Imports System.Net
Imports System.Web.Services
Imports CARS.CoreLibrary
Imports MSGCOMMON
Imports CARS.CoreLibrary.CARS
Imports System.Xml
Public Class frmCustomerSearch
    Inherits System.Web.UI.Page
    Shared dtSubDetails As New DataTable()
    Shared dsSubDetails As New DataSet
    Shared objZipCodeBO As New ZipCodesBO
    Shared objZipCodeDO As New ZipCodes.ZipCodesDO
    Shared objVehicleDO As New VehicleDO
    Shared loginName As String
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared objVehicleBO As New VehicleBO
    Shared objVehicleService As New CARS.CoreLibrary.CARS.Services.Vehicle.VehicleDetails
    Shared objCustBO As New CustomerBO
    Shared objServCustomer As New Services.Customer.CustomerDetails
    Shared objServOrder As New Services.Order.OrderDetails
    Shared objInvDetServ As New Services.InvDetail.InvDetail
    Shared objItemBO As New ItemsBO
    Shared objServItems As New Services.Items.ItemsDetail

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
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
            hdnPageSize.Value = System.Configuration.ConfigurationManager.AppSettings("PageSize")
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOSearchPopup", "Page_Load", ex.Message, loginName)
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function Customer_Search(ByVal q As String, ByVal isPrivate As String, ByVal isCompany As String) As CustomerBO()
        Dim custDetails As New List(Of CustomerBO)()
        Try
            custDetails = objServCustomer.CustomerSearch(q, isPrivate, isCompany)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearchPopup", "Customer_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return custDetails.ToList.ToArray
    End Function

End Class