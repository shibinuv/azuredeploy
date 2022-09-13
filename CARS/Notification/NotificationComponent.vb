Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Linq
Imports System.Web
Imports CARS.CARSConfigEntities
Imports Microsoft.AspNet.SignalR


Public Class NotificationComponent
    Shared connectionString As String = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
    Shared command As SqlCommand = Nothing
    Shared dependency As SqlDependency = Nothing
    Shared connection As SqlConnection = Nothing

    Public Sub RegisterNotification(currentTime As DateTime)
        Try
            connection = New SqlConnection(connectionString)
            command = New SqlCommand("SELECT IdNotification,IsNotification,CreatedDate FROM [dbo].TBL_CONFIG_NOTIFICATION Where [CreatedDate]> @AddedOn", connection)
            command.Parameters.AddWithValue("@AddedOn", currentTime)
            If (connection.State <> System.Data.ConnectionState.Open) Then
                connection.Open()
            End If
            command.Notification = Nothing
            Dim sqlDep As SqlDependency = New SqlDependency(command)
            AddHandler sqlDep.OnChange, New OnChangeEventHandler(AddressOf dependency_OnChange)
            Using reader As SqlDataReader = command.ExecuteReader()

            End Using

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Public Sub dependency_OnChange(ByVal obj As Object, ByVal e As SqlNotificationEventArgs)
        Try
            If e.Type = SqlNotificationType.Change Then

                Dim sqlDep As SqlDependency = TryCast(obj, SqlDependency)
                RemoveHandler sqlDep.OnChange, New OnChangeEventHandler(AddressOf dependency_OnChange)
                Dim context = GlobalHost.ConnectionManager.GetHubContext(Of NotificationHub)()
                context.Clients.All.notify("added")

                RegisterNotification(DateTime.Now)
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Public Function GetNotification(ByVal afterDate As DateTime) As List(Of CONFIG_NOTIFI.TBL_CONFIG_NOTIFICATION)
        Using dc As CARSEntities = New CARSEntities()
            Return dc.TBL_CONFIG_NOTIFICATION.Where(Function(a) a.IsNotification = False).OrderByDescending(Function(a) a.CreatedDate).ToList()
        End Using
    End Function

End Class

