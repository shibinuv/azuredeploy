Imports Microsoft.AspNet.SignalR

Public Class NotificationHub
    Inherits Hub

    'Public Sub Hello()
    '    Clients.All.Hello()
    'End Sub
    Public Shared Sub Send()
        'Dim context As IHubContext = GlobalHost.ConnectionManager.GetHubContext(Of NotificationHub)()
        'context.Clients.All.displayStatus()
    End Sub


End Class
