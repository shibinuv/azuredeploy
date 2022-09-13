Imports System
Imports System.Web.UI
Imports DevExpress.Web.ASPxScheduler
Public Class CustomToolTip
    Inherits ASPxSchedulerToolTipBase

    Public Overrides ReadOnly Property ToolTipShowStem() As Boolean
        Get
            Return False
        End Get
    End Property
    Public Overrides ReadOnly Property ClassName() As String
        Get
            Return "ASPxClientAppointmentToolTip"
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'DevExpress.Web.ASPxWebControl.RegisterBaseScript(Page);


    End Sub
    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)

    End Sub
    Protected Overrides Function GetChildControls() As Control()

        Dim controls_Renamed() As Control = {buttonDiv, lblSubject, lblInterval, lblDescription, lblOrderDetails, lblOverTime, lblCustomData}
        Return controls_Renamed
    End Function

    Public Sub GetIsOverTime()

        Dim str As String = ""
        If (str = "") Then
            Dim val As String = ""
        End If

    End Sub


End Class