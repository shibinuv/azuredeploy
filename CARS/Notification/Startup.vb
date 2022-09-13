
Imports Microsoft.Owin
Imports Owin

<Assembly: OwinStartup(GetType(CARSNotification.Startup))>
Namespace CARSNotification

    Public Class Startup
        Public Sub Configuration(ByVal app As IAppBuilder)
            app.MapSignalR()
        End Sub
    End Class

End Namespace