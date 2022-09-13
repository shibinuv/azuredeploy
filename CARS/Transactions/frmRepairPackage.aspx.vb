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

Public Class frmRepairPackage
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of ConfigDepartmentBO)()
    Shared objConfigDeptBO As New ConfigDepartmentBO
    Shared objConfigDeptDO As New Department.ConfigDepartmentDO
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared _loginName As String
    Shared RepairPackageService As New Services.RepPackage.RepPackage
    Shared objRPDO As New TirePackageDO
    Shared wareHouseDetails As New List(Of ConfigWarehouseBO)()
    Shared objConfigWHServ As New Services.ConfigWarehouse.ConfigWarehouse


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Dim strscreenName As String
            Dim dtCaption As DataTable
            _loginName = CType(Session("UserID"), String)

            If Not IsPostBack Then
                dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)

                strscreenName = IO.Path.GetFileName(Me.Request.PhysicalPath)
                hdnSelect.Value = dtCaption.Select("TAG='select'")(0)(1)

            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function Add_RP_Head(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim RPitem As RepPackageBO = JsonConvert.DeserializeObject(Of RepPackageBO)(item)
        Try
            strResult = RepairPackageService.Add_RP_Head(RPitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "Add_RP_Head", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function Add_RP_Item(ByVal item As String) As Integer
        Dim strResult As Integer

        Dim RPitem As RepPackageBO = JsonConvert.DeserializeObject(Of RepPackageBO)(item)
        Try
            strResult = RepairPackageService.Add_RP_Item(RPitem)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "Add_RP_Item", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function Fetch_RP_List(ByVal jobid As String, ByVal wh As String, ByVal make As String, ByVal title As String) As List(Of RepPackageBO)

        Dim RPList As New List(Of RepPackageBO)()
        Try
            RPList = RepairPackageService.Fetch_RP_List(jobid, wh, make, title)
        Catch ex As Exception
            Dim theex = ex.GetType()
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "Fetch_RP_List", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try


        Return RPList
    End Function

    <WebMethod()>
    Public Shared Function FetchRPHead(ByVal packageNo As String) As List(Of RepPackageBO)
        Dim packageItem As New List(Of RepPackageBO)()
        Try
            packageItem = RepairPackageService.FetchRPHead(packageNo)
        Catch ex As Exception
            Dim theex = ex.GetType()
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "FetchRPHead", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return packageItem
    End Function

    <WebMethod()>
    Public Shared Function FetchRPDetails(ByVal JOB_ID As String) As List(Of RepPackageBO)
        Dim repPackageItems As New List(Of RepPackageBO)()
        Try
            repPackageItems = RepairPackageService.FetchRPDetails(JOB_ID)
        Catch ex As Exception
            Dim theex = ex.GetType()
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "FetchRPDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return repPackageItems
    End Function

    <WebMethod()>
    Public Shared Function Delete_RepairPackage(ByVal rp_code As String, ByVal rp_type As String, ByVal id_spareseq As String) As String
        Dim repPkgStatus As String = ""
        Try
            repPkgStatus = RepairPackageService.Delete_RepairPackage(rp_code, rp_type, id_spareseq)
        Catch ex As Exception
            Dim theex = ex.GetType()
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "Delete_RepairPackage", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, _loginName)
        End Try
        Return repPkgStatus
    End Function

    <WebMethod()>
    Public Shared Function FetchRPDetailsWO(ByVal JOB_ID As String, ByVal ID_RPKG_SEQ As String) As List(Of RepPackageBO)

        Dim repPackageItems As New List(Of RepPackageBO)()
        Try
            repPackageItems = RepairPackageService.FetchRPDetailsWO(ID_RPKG_SEQ, JOB_ID)
        Catch ex As Exception
            Dim theex = ex.GetType()
            objErrHandle.WriteErrorLog(1, "Transactions_frmRepairPackage", "FetchRPDetailsWO", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, CType(HttpContext.Current.Session("UserID"), String))
        End Try

        Return repPackageItems
    End Function
End Class