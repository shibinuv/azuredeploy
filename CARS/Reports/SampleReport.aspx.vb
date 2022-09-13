Imports DevExpress.XtraReports.Web

Public Class SampleReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs)
        Dim myRep = New rptCountingList()
        myRep.Parameters("IdItem").Value = "1161698"
        myRep.Parameters("LineNo").Value = "4"
        myRep.RequestParameters = False
        Dim cachedReportSource = New CachedReportSourceWeb(myRep)

        ASPxWebDocumentViewer1.OpenReport(cachedReportSource)
    End Sub
End Class