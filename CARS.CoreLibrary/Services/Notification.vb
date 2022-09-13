Imports System.Web

Public Class Notification
    Dim objNotificationDO As New NotificationDO
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Public Function ManageNotification(ByVal objNotificationBO As NotificationBO) As DataSet
        Try
            Return objNotificationDO.Manage_Notification(objNotificationBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Services.Notification", "ManageNotification", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Function

    Public Function ManageBargainSMS(ByVal objNotificationBO As NotificationBO) As DataSet
        Try
            Return objNotificationDO.Manage_BargainSMS(objNotificationBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Services.Notification", "ManageBargainSMS", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Function
End Class

