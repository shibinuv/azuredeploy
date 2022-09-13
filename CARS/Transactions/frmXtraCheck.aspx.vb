Imports System.Web.Services
Imports System.Data.SqlClient
Imports DevExpress.XtraReports.Web
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS

Public Class frmXtraCheck

    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared sqlConnectionString As String
    Shared sqlConnection As SqlClient.SqlConnection
    Shared sqlCommand As SqlClient.SqlCommand
    Shared _loginName As String
    Shared objSendSMSServ As New Services.SendSMS.SendSMS
    Shared objSMSBO As New CARS.CoreLibrary.SendSMSBO
    Shared objSMSDO As New CARS.CoreLibrary.CARS.SendSMSDO.SendSMSDO
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            EnableViewState = False
            sqlConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            sqlConnection = New SqlClient.SqlConnection(sqlConnectionString)
            _loginName = CType(Session("UserID"), String)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    <WebMethod()>
    Public Shared Function FillSMSTexts() As List(Of ListItem)

        Dim query As String = "SELECT [ID_MESSAGES], [COMMERCIAL_TEXT] FROM [TBL_MAS_DEPT_MESSAGES] where ID_DEPT='22' and MESSAGE_TYPE='XTRACHECK'"
        Dim constr As String = sqlConnectionString
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand(query)
                Dim texts As New List(Of ListItem)()
                cmd.CommandType = CommandType.Text
                cmd.Connection = con
                con.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    While sdr.Read()
                        texts.Add(New ListItem() With {
                  .Value = sdr("ID_MESSAGES").ToString(),
                  .Text = sdr("COMMERCIAL_TEXT").ToString()
                })
                    End While
                End Using
                con.Close()
                Return texts
            End Using
        End Using

    End Function

    <WebMethod()>
    Public Shared Function FetchReportValues(ByVal badmotoroil As String, ByVal badcflevel As String, ByVal badcftemp As String, ByVal badbrakefluid As String, ByVal badbattery As String, ByVal badvipesfront As String, ByVal badvipesrear As String, ByVal badlightsfront As String, ByVal badlightsrear As String, ByVal badshockabsorberfront As String, ByVal badshockabsorberrear As String, ByVal badtiresfront As String, ByVal badtiresrear As String, ByVal badsuspensionfront As String, ByVal badsuspensionrear As String, ByVal badbrakesfront As String, ByVal badbrakesrear As String, ByVal badexhaust As String, ByVal badsealedengine As String, ByVal badsealedgearbox As String, ByVal badwindshield As String, ByVal mediummotoroil As String, ByVal mediumcflevel As String, ByVal mediumcftemp As String, ByVal mediumbrakefluid As String, ByVal mediumbattery As String, ByVal mediumvipesfront As String, ByVal mediumvipesrear As String, ByVal mediumlightsfront As String, ByVal mediumlightsrear As String, ByVal mediumshockabsorberfront As String, ByVal mediumshockabsorberrear As String, ByVal mediumtiresfront As String, ByVal mediumtiresrear As String, ByVal mediumsuspensionfront As String, ByVal mediumsuspensionrear As String, ByVal mediumbrakesfront As String, ByVal mediumbrakesrear As String, ByVal mediumexhaust As String, ByVal mediumsealedengine As String, ByVal mediumsealedgearbox As String, ByVal mediumwindshield As String) As String
        Dim vehDetails As String = ""
        Try

            Dim myRep As New dxXtracheckSelection()
            myRep.Name = "Report XtraCheck " + DateTime.Now
            myRep.RequestParameters = False
            myRep.Parameters("pbadmotoroil").Value = badmotoroil
            myRep.Parameters("pbadcflevel").Value = badcflevel
            myRep.Parameters("pbadcftemp").Value = badcftemp
            myRep.Parameters("pbadbrakefluid").Value = badbrakefluid

            myRep.Parameters("pbadbattery").Value = badbattery
            myRep.Parameters("pbadvipesfront").Value = badvipesfront
            myRep.Parameters("pbadvipesrear").Value = badvipesrear
            myRep.Parameters("pbadlightsfront").Value = badlightsfront
            myRep.Parameters("pbadlightsrear").Value = badlightsrear
            myRep.Parameters("pbadshockabsorberfront").Value = badshockabsorberfront
            myRep.Parameters("pbadshockabsorberrear").Value = badshockabsorberrear
            myRep.Parameters("pbadtiresfront").Value = badtiresfront
            myRep.Parameters("pbadtiresrear").Value = badtiresrear
            myRep.Parameters("pbadsuspensionfront").Value = badsuspensionfront
            myRep.Parameters("pbadsuspensionrear").Value = badsuspensionrear
            myRep.Parameters("pbadbrakesfront").Value = badbrakesfront
            myRep.Parameters("pbadbrakesrear").Value = badbrakesrear
            myRep.Parameters("pbadexhaust").Value = badexhaust
            myRep.Parameters("pbadsealedengine").Value = badsealedengine
            myRep.Parameters("pbadsealedgearbox").Value = badsealedgearbox
            myRep.Parameters("pbadwindshield").Value = badwindshield
            myRep.Parameters("pmediummotoroil").Value = mediummotoroil
            myRep.Parameters("pmediumcflevel").Value = mediumcflevel
            myRep.Parameters("pmediumcftemp").Value = mediumcftemp
            myRep.Parameters("pmediumbrakefluid").Value = mediumbrakefluid
            myRep.Parameters("pmediumbattery").Value = mediumbattery
            myRep.Parameters("pmediumvipesfront").Value = mediumvipesfront
            myRep.Parameters("pmediumvipesrear").Value = mediumvipesrear
            myRep.Parameters("pmediumlightsfront").Value = mediumlightsfront
            myRep.Parameters("pmediumlightsrear").Value = mediumlightsrear
            myRep.Parameters("pmediumshockabsorberfront").Value = mediumshockabsorberfront
            myRep.Parameters("pmediumshockabsorberrear").Value = mediumshockabsorberrear
            myRep.Parameters("pmediumtiresfront").Value = mediumtiresfront
            myRep.Parameters("pmediumtiresrear").Value = mediumtiresrear
            myRep.Parameters("pmediumsuspensionfront").Value = mediumsuspensionfront
            myRep.Parameters("pmediumsuspensionrear").Value = mediumsuspensionrear
            myRep.Parameters("pmediumbrakesfront").Value = mediumbrakesfront
            myRep.Parameters("pmediumbrakesrear").Value = mediumbrakesrear
            myRep.Parameters("pmediumexhaust").Value = mediumexhaust
            myRep.Parameters("pmediumsealedengine").Value = mediumsealedengine
            myRep.Parameters("pmediumsealedgearbox").Value = mediumsealedgearbox
            myRep.Parameters("pmediumwindshield").Value = mediumwindshield


            ' myRep.ApplyLocalization(System.Configuration.ConfigurationManager.AppSettings("Culture"))
            HttpContext.Current.Session("myRep") = myRep
            'Dim cachedReportSource = New CachedReportSourceWeb(myRep)
            'HttpContext.Current.Session("ReportSource") = cachedReportSource

            vehDetails = "Success"

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return vehDetails
    End Function

    Protected Sub cbXtraCheck_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            If Not (HttpContext.Current.Session("myRep") Is Nothing) Then
                Dim cachedReportSource = New CachedReportSourceWeb(HttpContext.Current.Session("myRep"))
                HttpContext.Current.Session("ReportSource") = cachedReportSource
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmXtraCheck", "cbXtraCheck_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function SaveMessageTemplate(ByVal tempId As String, ByVal tempText As String, ByVal tempType As String) As String
        Dim strRetVal As String = ""
        Try
            strRetVal = objSMSDO.SaveMessageTemplate(tempId, tempText, tempType, _loginName)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return strRetVal
    End Function

End Class