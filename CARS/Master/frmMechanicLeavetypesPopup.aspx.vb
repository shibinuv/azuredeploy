Imports CARS.CoreLibrary.CARS.Services.ConfigMechanicLeaveTypes
Imports CARS.CoreLibrary.CARS.Services
Imports System.Data
Imports System
Imports System.Configuration
Imports System.Data.Common
Imports System.Web.UI
Imports System.Web.UI.WebControls
Public Class frmMechanicLeaveTypesPopup
    Inherits System.Web.UI.Page
    Shared _loginName As String
    Shared loginName As String
    Shared objMechanicLeaveTypes As MechanicLeaveTypes
    Shared objMechanicLeaveTypesBO As CoreLibrary.MechanicLeaveTypesBO
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Dim ds As DataSet
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            loginName = CType(Session("UserID"), String)
        End If
        EnableViewState = False
        objMechanicLeaveTypes = New MechanicLeaveTypes()
        ds = objMechanicLeaveTypes.FetchLeaveTypes
        gvLeaveTypes.DataSource = ds
        gvLeaveTypes.DataBind()


    End Sub

    Protected Sub gvLeaveTypes_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)

        For Each item In e.InsertValues

            Try
                objMechanicLeaveTypesBO = New CoreLibrary.MechanicLeaveTypesBO()
                objMechanicLeaveTypesBO.Leave_Description = item.NewValues(0)
                objMechanicLeaveTypesBO.Leave_Code = item.NewValues(1)
                objMechanicLeaveTypesBO.Approve_Code = item.NewValues(2)

                objMechanicLeaveTypes = New MechanicLeaveTypes()
                objMechanicLeaveTypes.AddLeaveTypes(objMechanicLeaveTypesBO, loginName)

                ds = objMechanicLeaveTypes.FetchLeaveTypes
                gvLeaveTypes.DataSource = ds

                gvLeaveTypes.DataBind()


            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "gvLeaveTypes_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        gvLeaveTypes.DataBind()
        For Each item In e.UpdateValues
            Try
                objMechanicLeaveTypesBO = New CoreLibrary.MechanicLeaveTypesBO()
                objMechanicLeaveTypesBO.Leave_Description = item.NewValues(0)
                objMechanicLeaveTypesBO.Leave_Code = item.NewValues(1)
                objMechanicLeaveTypesBO.Approve_Code = item.NewValues(2)
                objMechanicLeaveTypesBO.Id_Leave_Types = item.Keys.Values(0)
                objMechanicLeaveTypes = New MechanicLeaveTypes()

                objMechanicLeaveTypes.ModifyLeaveTypes(objMechanicLeaveTypesBO, loginName)
                ds = objMechanicLeaveTypes.FetchLeaveTypes
                gvLeaveTypes.DataSource = ds

                gvLeaveTypes.DataBind()
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "gvLeaveTypes_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next

        For Each item In e.DeleteValues
            Try
                objMechanicLeaveTypesBO = New CoreLibrary.MechanicLeaveTypesBO()
                objMechanicLeaveTypesBO.Id_Leave_Types = item.Keys.Values(0)
                objMechanicLeaveTypes = New MechanicLeaveTypes()
                objMechanicLeaveTypes.DeleteLeaveTypes(objMechanicLeaveTypesBO)

                ds = objMechanicLeaveTypes.FetchLeaveTypes
                gvLeaveTypes.DataSource = ds

                gvLeaveTypes.DataBind()
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicLeaveTypes", "gvLeaveTypes_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        e.Handled = True
    End Sub
End Class