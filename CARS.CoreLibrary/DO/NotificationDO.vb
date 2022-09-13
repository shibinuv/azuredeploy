
Imports System.Data.Common
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Public Class NotificationDO

    Dim ConnectionString As String
    Dim objDB As Database
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
    Public Function Manage_Notification(ByVal objNotificationBO As NotificationBO) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MANAGE_NOTIFICATION")
                objDB.AddInParameter(objcmd, "@MODE", DbType.String, objNotificationBO.Mode)
                objDB.AddInParameter(objcmd, "@Iv_IdNotification", DbType.Int32, objNotificationBO.IdNotification)
                objDB.AddInParameter(objcmd, "@Iv_IsNotification", DbType.Boolean, objNotificationBO.IsNotification)
                objDB.AddInParameter(objcmd, "@Iv_NotificationMessage", DbType.String, objNotificationBO.NotificationMessage)
                objDB.AddInParameter(objcmd, "@Iv_WO_NO", DbType.String, objNotificationBO.WO_NO)
                objDB.AddInParameter(objcmd, "@Iv_WO_PREFIX", DbType.String, objNotificationBO.WO_PREFIX)
                objDB.AddInParameter(objcmd, "@Iv_WO_JOB_NO", DbType.Int32, objNotificationBO.WO_JOB_NO)
                objDB.AddInParameter(objcmd, "@Iv_User", DbType.String, objNotificationBO.CreatedBy)
                objDB.AddInParameter(objcmd, "@Iv_MessageText", DbType.String, objNotificationBO.MessageText)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Manage_BargainSMS(ByVal objNotificationBO As NotificationBO) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MANAGE_BARGAINSMS")
                objDB.AddInParameter(objcmd, "@MODE", DbType.String, objNotificationBO.Mode)
                objDB.AddInParameter(objcmd, "@Iv_IdBargain", DbType.String, objNotificationBO.IdBargain)
                objDB.AddInParameter(objcmd, "@Iv_IsAccepted", DbType.Boolean, objNotificationBO.IsAccepted)
                objDB.AddInParameter(objcmd, "@Iv_WO_NO", DbType.String, objNotificationBO.WO_NO)
                objDB.AddInParameter(objcmd, "@Iv_WO_PREFIX", DbType.String, objNotificationBO.WO_PREFIX)
                objDB.AddInParameter(objcmd, "@Iv_WO_JOB_NO", DbType.Int32, objNotificationBO.WO_JOB_NO)
                objDB.AddInParameter(objcmd, "@Iv_User", DbType.String, objNotificationBO.CreatedBy)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class


