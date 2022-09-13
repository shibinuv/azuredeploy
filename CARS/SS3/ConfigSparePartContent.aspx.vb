Public Class ConfigSparePartContent
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared loginName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If

            loginName = HttpContext.Current.Session("UserID")
            EnableViewState = False


        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "ConfigSparePartContent", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try


    End Sub

End Class