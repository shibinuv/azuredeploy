Imports DevExpress.XtraReports.Web

Public Class ReportViewer_SS3
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("ReportSource") IsNot Nothing Then
            Dim cachedReportSource As CachedReportSourceWeb = Session("ReportSource")
            wrvReportViewer1.OpenReport(cachedReportSource)
        End If
    End Sub

End Class