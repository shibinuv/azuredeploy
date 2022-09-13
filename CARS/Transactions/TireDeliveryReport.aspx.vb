Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports System.Drawing
Imports System.Web.Script.Serialization.JavaScriptSerializer
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Object
Imports System.MarshalByRefObject
Imports System.Net.WebRequest
Imports System.Net.HttpWebRequest
Imports System.Net.HttpWebResponse
Imports System.Net
Imports Encryption
Imports MSGCOMMON
Imports System.Web.Services
Imports CARS.CoreLibrary.CARS
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS.Services
Imports System.Reflection
Imports System.Web.Script.Serialization

Public Class TireDeliveryReport
    Inherits System.Web.UI.Page
    Dim sqlConnectionString As String
    Dim sqlConnection As SqlClient.SqlConnection
    Dim sqlCommand As SqlClient.SqlCommand
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        sqlConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        sqlConnection = New SqlClient.SqlConnection(sqlConnectionString)
        If Request.QueryString("tirePackage") IsNot Nothing Then
            'lblTirePackageNo.Text = Request.QueryString("tirePackage").ToString()
            'lblDateNow.Text = FormatDateTime(Now, DateFormat.ShortDate)
            'lblTimeNow.Text = Date.Now.Hour.ToString
            'lblTimeNow.Text += ":" + Date.Now.Minute.ToString
            'lblTimeNow.Text += ":" + Date.Now.Second.ToString
            'Call FillData()
            'lblPageNow.Text = "1 av 1"

        End If

    End Sub

    'Public Sub FillData()
    '    sqlCommand = New SqlClient.SqlCommand("SELECT custName, regDate, regNo, qtyTire, tireSpikesDesc, tireBrandDesc, location, tireAnnot from TBL_TIRE_ORDER_PACKAGE where tirePackageNo='151133 S'")
    '    sqlCommand.Connection = sqlConnection
    '    sqlConnection.Open()

    '    Try
    'sqlCommand.Parameters.AddWithValue("@tirePackageNo", lblTirePackageNo.Text)
    'Dim dr As SqlClient.SqlDataReader
    'dr = sqlCommand.ExecuteReader()

    'While dr.Read
    'lblOwner.Text = dr(0)
    'lblRegDate.Text = dr(1)
    'lblRegNo.Text = dr(2)
    'lblTireQty.Text = dr(3)
    'If dr(4) = "Velg..." Then
    '    lblTireSpikes.Text = "Ikke aktuelt"
    'Else
    '    lblTireSpikes.Text = dr(4)
    'End If
    'If dr(5) = "Velg..." Then
    '    lblTireBrand.Text = "Ikke oppgitt"
    'Else
    '    lblTireBrand.Text = dr(5)
    'End If
    'lblTireLocation.Text = dr(6)
    'lblTireAnnot.Text = dr(7)

    'End While
    'dr.Close()
    'Catch ex As SqlException

    'Finally
    'sqlConnection.Close()
    'End Try
    'End Sub

End Class