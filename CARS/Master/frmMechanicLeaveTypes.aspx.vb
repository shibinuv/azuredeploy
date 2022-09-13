
Imports CARS.CoreLibrary.CARS.Services.ConfigMechanicLeaveTypes
Imports CARS.CoreLibrary.CARS.Services
Imports System.Data
Imports System
Imports System.Configuration
Imports System.Data.Common
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.Services
Imports System.Globalization
Imports System.Threading
Public Class frmMechanicLeaveTypes
    Inherits System.Web.UI.Page
    Shared _loginName As String
    Shared loginName As String
    Shared objMechanicLeaveTypes As MechanicLeaveTypes = New MechanicLeaveTypes()
    Shared objMechanicLeaveTypesBO As CoreLibrary.MechanicLeaveTypesBO
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Dim ds As DataSet
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            loginName = CType(Session("UserID"), String)
        End If
        Try
            EnableViewState = False
            'objMechanicLeaveTypes = New MechanicLeaveTypes()
            gvLeaveTypes.JSProperties("cpdelexists") = ""
            gvLeaveTypes.JSProperties("cpdelcode") = ""
            ds = objMechanicLeaveTypes.FetchLeaveTypes
            gvLeaveTypes.DataSource = ds
            gvLeaveTypes.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Protected Sub gvLeaveTypes_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        For Each item In e.InsertValues

            Try
                objMechanicLeaveTypesBO = New CoreLibrary.MechanicLeaveTypesBO()
                objMechanicLeaveTypesBO.Leave_Description = item.NewValues("LEAVE_DESCRIPTION")
                objMechanicLeaveTypesBO.Leave_Code = item.NewValues("LEAVE_CODE")
                objMechanicLeaveTypesBO.Approve_Code = item.NewValues("APPROVE_CODE")

                objMechanicLeaveTypes = New MechanicLeaveTypes()
                Dim st As String = objMechanicLeaveTypes.AddLeaveTypes(objMechanicLeaveTypesBO, loginName)

                ds = objMechanicLeaveTypes.FetchLeaveTypes
                gvLeaveTypes.DataSource = ds
                gvLeaveTypes.DataBind()

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "gvLeaveTypes_BatchUpdate_InsertValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        gvLeaveTypes.DataBind()
        For Each item In e.UpdateValues
            Try
                objMechanicLeaveTypesBO = New CoreLibrary.MechanicLeaveTypesBO()
                objMechanicLeaveTypesBO.Leave_Description = item.NewValues("LEAVE_DESCRIPTION")
                objMechanicLeaveTypesBO.Leave_Code = item.NewValues("LEAVE_CODE")
                objMechanicLeaveTypesBO.Approve_Code = item.NewValues("APPROVE_CODE")
                objMechanicLeaveTypesBO.Id_Leave_Types = item.Keys.Values(0)
                objMechanicLeaveTypes = New MechanicLeaveTypes()

                objMechanicLeaveTypes.ModifyLeaveTypes(objMechanicLeaveTypesBO, loginName)
                ds = objMechanicLeaveTypes.FetchLeaveTypes
                gvLeaveTypes.DataSource = ds

                gvLeaveTypes.DataBind()
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "gvLeaveTypes_BatchUpdate_UpdateValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next

        For Each item In e.DeleteValues
            Try
                objMechanicLeaveTypesBO = New CoreLibrary.MechanicLeaveTypesBO()
                objMechanicLeaveTypesBO.Id_Leave_Types = item.Keys.Values(0)
                objMechanicLeaveTypes = New MechanicLeaveTypes()
                'objMechanicLeaveTypes.DeleteLeaveTypes(objMechanicLeaveTypesBO)

                Dim strResult As String = objMechanicLeaveTypes.DeleteLeaveTypes(objMechanicLeaveTypesBO)

                Dim strResVal As Array
                strResVal = strResult.Split(",")

                If strResVal.Length > 0 Then
                    If strResVal(0) = "CODE_USED" Then
                        strResVal(0) = "CODE_USED"
                    End If

                    If (strResVal(0) = "CODE_USED") Then
                        gvLeaveTypes.JSProperties("cpdelexists") = "EXISTS"
                        gvLeaveTypes.JSProperties("cpdelcode") = strResVal(1)
                    End If
                End If

                ds = objMechanicLeaveTypes.FetchLeaveTypes
                gvLeaveTypes.DataSource = ds
                gvLeaveTypes.DataBind()
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "gvLeaveTypes_BatchUpdate_DeleteValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        e.Handled = True
    End Sub

    Protected Sub gvLeaveTypes_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        If (e.IsNewRow = True) Then
            Dim ds As DataSet = gvLeaveTypes.DataSource
            Dim rowCount As Integer = Convert.ToInt32(ds.Tables(0).Rows.Count)
            For i As Integer = 0 To rowCount - 1
                Dim row As DataRow = ds.Tables(0).Rows(i)
                Dim currentEntry As String = e.NewValues(1)
                Dim oldValue As String = row.ItemArray(1)
                If (currentEntry.ToLower() = oldValue.ToLower()) Then
                    e.RowError = "Leave Code already exists"
                End If

            Next
        End If

    End Sub

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function AddLeaveTypes(ByVal leaveCode As String, ByVal leaveDescription As String, ByVal mecLeaveId As String, ByVal approveCode As String) As String
        Dim strResult As String = ""
        Try
            objMechanicLeaveTypesBO = New CoreLibrary.MechanicLeaveTypesBO()
            objMechanicLeaveTypesBO.Leave_Code = leaveCode
            objMechanicLeaveTypesBO.Leave_Description = leaveDescription
            objMechanicLeaveTypesBO.Approve_Code = approveCode
            objMechanicLeaveTypes = New MechanicLeaveTypes()
            If (mecLeaveId <> "0") Then
                objMechanicLeaveTypesBO.Id_Leave_Types = Convert.ToInt32(mecLeaveId)
                objMechanicLeaveTypes.ModifyLeaveTypes(objMechanicLeaveTypesBO, loginName)
            Else
                strResult = objMechanicLeaveTypes.AddLeaveTypes(objMechanicLeaveTypesBO, loginName)
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "AddLeaveTypes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return strResult
    End Function
    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci
        End If
    End Sub
End Class