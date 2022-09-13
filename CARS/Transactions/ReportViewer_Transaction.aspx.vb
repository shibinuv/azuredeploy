Imports DevExpress.XtraReports.Web

Public Class ReportViewer_Transaction
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

            If Session("ReportSource") IsNot Nothing Then
                Dim cachedReportSource As CachedReportSourceWeb = Session("ReportSource")
                wrvReportViewer1.OpenReport(cachedReportSource)
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "ReportViewer_Transaction", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Private Sub ReportViewer_Init(sender As Object, e As EventArgs) Handles Me.Init

    End Sub
End Class