Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports System.Drawing
Imports System.Web.Script.Serialization.JavaScriptSerializer
Imports System.Object
Imports System.MarshalByRefObject
Imports System.Net.WebRequest
Imports System.Net.HttpWebRequest
Imports System.Net.HttpWebResponse
Imports System.Net
Imports System.Web
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls.WebParts
Imports CARS.CoreLibrary
Imports System.Web.Services
Imports CARS.CoreLibrary.CARS
Imports Newtonsoft.Json.Linq

Public Class frmSendSMS
    Inherits System.Web.UI.Page

    Shared objCustomerService As New CARS.CoreLibrary.CARS.Services.Customer.CustomerDetails
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared loginName As String
    Shared objCustBo As New CustomerBO
    Shared objSendSMSServ As New Services.SendSMS.SendSMS
    Shared objSMSBO As New CARS.CoreLibrary.SendSMSBO
    Shared objServCustomer As New Services.Customer.CustomerDetails
    Shared objSMSDO As New CARS.CoreLibrary.CARS.SendSMSDO.SendSMSDO
    Shared commonUtil As New Utilities.CommonUtility
    Shared sqlConnectionString As String
    Shared sqlConnection As SqlClient.SqlConnection
    Shared sqlCommand As SqlClient.SqlCommand

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        sqlConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        sqlConnection = New SqlClient.SqlConnection(sqlConnectionString)
        Dim mobno As String = CType("", String)
        Dim name As String = CType("", String)
        Dim email As String = CType("", String)
        If Not (Session.Item("MobileNo") Is Nothing) Then
            mobno = CType(Session.Item("MobileNo"), String)
        End If
        If Not (Session.Item("Name") Is Nothing) Then
            name = CType(Session.Item("Name"), String)
        End If
        If Not (Session.Item("Email") Is Nothing) Then
            email = CType(Session.Item("Email"), String)
        End If

        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            loginName = CType(Session("UserID"), String)
        End If
        txtMobile.Text = mobno
        txtEmail.Text = email
        txtName.Text = name
        txtStatus.Text = loginName
        'lblSMSText.Text = "SMS Text til " + name

    End Sub

    <WebMethod()>
    Public Shared Function SendSMS(ByVal num As String, ByVal message As String, ByVal time As String, ByVal id As String, ByVal user As String, ByVal password As String, ByVal dru As String) As String
        'Dim dsCustomer As New DataSet
        'Dim dtCustomer As DataTable
        'Dim dtContact As New DataTable
        'dtContact.Columns.Add("ID")
        'dtContact.Columns.Add("PHONE_TYPE")
        'dtContact.Columns.Add("CUST_PH_MOBILE")
        'dtContact.Columns.Add("CUST_PH_OFF")
        'Dim rUser As DataRow
        'Dim objEniroDetails As New List(Of CustomerBO)()
        'Dim IdArr As Array
        'Dim num As String = sms
        'Dim message As String = message

        Try
            Dim contactLink As String = ""
            Dim custDetails As String = ""

            Dim url As String = "https://admin.intouch.no/smsgateway/sendSms?sender=WebCars&targetNumbers=" + num + "&sms=" + message + "&userName=" + user + "&password=" + password + "&deliveryReportUrl=" + dru + "&batchId=P" + id
            If time <> "" Then
                url += "&sendTime=" + time
            End If

            Dim request As Net.HttpWebRequest = DirectCast(Net.WebRequest.Create(url), Net.HttpWebRequest)
            Dim response As Net.HttpWebResponse = DirectCast(request.GetResponse(), Net.HttpWebResponse)
            Dim statusCode = response.StatusCode
            Dim statusDesc = response.StatusDescription
            Dim reader As StreamReader = New StreamReader(response.GetResponseStream())
            Dim json As String = reader.ReadToEnd
            'Dim o As JObject = JObject.Parse(json)
            'Dim i As Integer = 1
            'Dim results = o("result")


            'For Each resultProperty In results.Value(Of JObject)()
            '    'Only get properties like "1" inside the root "result" property
            '    If Not Integer.TryParse(resultProperty.Key, Nothing) Then Continue For
            '    'Approach 2: Deserialize the listing into a .Net object
            '    Dim serializer As JsonSerializer = New JsonSerializer()
            '    Dim resultObject As CustomerBO.Result = JsonConvert.DeserializeObject(Of CustomerBO.Result)(resultProperty.Value.ToString())

            '    Dim CustDet As New CustomerBO()
            '    For Each duplicateObject In resultObject.listing.duplicates
            '        Dim tlf As String = ""
            '        Dim firstName As String = ""
            '        Dim middleName As String = ""

            '        If Not String.IsNullOrWhiteSpace(duplicateObject.fornavn) AndAlso duplicateObject.fornavn.Contains(" ") Then
            '            Dim name = duplicateObject.fornavn
            '            firstName = name.Substring(0, name.IndexOf(" "))
            '            middleName = name.Substring(name.IndexOf(" ") + 1)
            '        Else
            '            firstName = duplicateObject.fornavn
            '        End If

            '        If Not duplicateObject.apparattype Is Nothing Then
            '            rUser = dtContact.NewRow()
            '            IdArr = duplicateObject.id.ToString.Split("")
            '            Id = IdArr(0)
            '            rUser("ID") = Id
            '            rUser("PHONE_TYPE") = duplicateObject.apparattype
            '            If duplicateObject.apparattype = "M" Then
            '                rUser("CUST_PH_MOBILE") = duplicateObject.tlfnr
            '                rUser("CUST_PH_OFF") = ""
            '            ElseIf duplicateObject.apparattype = "T" Then
            '                rUser("CUST_PH_MOBILE") = ""
            '                rUser("CUST_PH_OFF") = duplicateObject.tlfnr
            '            Else
            '                rUser("CUST_PH_MOBILE") = ""
            '                rUser("CUST_PH_OFF") = duplicateObject.tlfnr
            '            End If
            '            dtContact.Rows.Add(rUser)
            '        End If

            '        If (firstName <> "" Or duplicateObject.etternavn <> "") Then
            '            CustDet.CUST_SSN_NO = duplicateObject.foretaksnr
            '            CustDet.CUST_PHONE_MOBILE = duplicateObject.tlfnr
            '            CustDet.CUST_PERM_ADD1 = duplicateObject.veinavn + " " + duplicateObject.husnr
            '            CustDet.CUST_PERM_ADD2 = duplicateObject.poststed
            '            CustDet.ID_CUST_PERM_ZIPCODE = duplicateObject.postnr
            '            CustDet.CUST_FIRST_NAME = IIf(firstName Is Nothing = True, "", firstName)
            '            CustDet.CUST_MIDDLE_NAME = middleName
            '            CustDet.CUST_LAST_NAME = duplicateObject.etternavn
            '            CustDet.CUST_BORN = Convert.ToDateTime(duplicateObject.fodselsdato).ToString("dd.MM.yyyy")
            '            CustDet.ENIRO_ID = duplicateObject.idlinje
            '            CustDet.PHONE_TYPE = duplicateObject.apparattype
            '            CustDet.CUST_COUNTY = duplicateObject.fylke
            '            CustDet.ID_CUST = Id

            '        End If
            '    Next
            '    objEniroDetails.Add(CustDet)
            'Next
            'HttpContext.Current.Session("CustContact") = dtContact
            Return statusDesc
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    <WebMethod()>
    Public Shared Function FillSMSTexts() As List(Of ListItem)

        Dim query As String = "SELECT [ID_MESSAGES], [COMMERCIAL_TEXT] FROM [TBL_MAS_DEPT_MESSAGES] where ID_DEPT='22'"
        Dim constr As String = sqlConnectionString
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand(Query)
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
    Public Shared Function FillDeptList() As List(Of ListItem)

        Dim query As String = "SELECT ID_Dept, DPT_Name FROM TBL_MAS_DEPT"
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
                      .Value = sdr("ID_Dept").ToString(),
                      .Text = sdr("DPT_Name").ToString()
                    })
                    End While
                End Using
                con.Close()
                Return texts
            End Using
        End Using

    End Function

    <WebMethod()>
    Public Shared Function SaveSMSConfig(ByVal userId As String, ByVal userPassword As String, ByVal senderMail As String, ByVal senderSMS As String, ByVal smsOperator As String, ByVal department As String, ByVal smsIntouch As String, ByVal smsCerum As String, ByVal smsGlobi As String, ByVal smsCountingStart As String, ByVal smsCountingNo As String, ByVal smsType As String, ByVal postText As String, ByVal cbGreetVisit As String, ByVal txtGreetVisit As String, ByVal cbGreetMobility As String, ByVal txtGreetMobility As String, ByVal cbFollowUpAfterVisit As String, ByVal cbFollowUpAfterVisitShowSMS As String, ByVal txtFollowupAfterVisitDays As String, ByVal txtFollowupAfterVisitAmount As String, ByVal txtFollowupAfterVisitText As String, ByVal cbConfirmAppointment As String, ByVal cbConfirmAppointmentShowSms As String, ByVal cbconfirmNoTime As String, ByVal txtConfirmText As String, ByVal cbConfirmHandingIn As String, ByVal cbConfirmHandingInShowSMS As String, ByVal cbConfirmHandingInNoTime As String, ByVal txtHoursBeforeAgreed As String, ByVal txtHoursBeforeAgreedClock As String, ByVal txtConfirmHandingInText As String, ByVal cbConfirmHandingOut As String, ByVal cbConfirmHandingOutShowSMS As String, ByVal txtMinBeforeFinish As String, ByVal txtConfirmHandingOutText As String, ByVal cbFollowUp As String, ByVal cbFollowUpShowSMS As String, ByVal txtFollowUpDaysAfter As String, ByVal txtcbFollowUpText As String, ByVal cbConfirmReceive As String, ByVal cbConfirmReceiveShowSMS As String, ByVal txtArrivalOrdParts As String) As String
        Dim strRetVal As String = ""
        Try
            strRetVal = objSMSDO.SaveSMSConfig(userId, userPassword, senderMail, senderSMS, smsOperator, department, smsIntouch, smsCerum, smsGlobi, smsCountingStart, smsCountingNo, smsType, postText, cbGreetVisit, txtGreetVisit, cbGreetMobility, txtGreetMobility, cbFollowUpAfterVisit, cbFollowUpAfterVisitShowSMS, txtFollowupAfterVisitDays, txtFollowupAfterVisitAmount, txtFollowupAfterVisitText, cbConfirmAppointment, cbConfirmAppointmentShowSms, cbconfirmNoTime, txtConfirmText, cbConfirmHandingIn, cbConfirmHandingInShowSMS, cbConfirmHandingInNoTime, txtHoursBeforeAgreed, txtHoursBeforeAgreedClock, txtConfirmHandingInText, cbConfirmHandingOut, cbConfirmHandingOutShowSMS, txtMinBeforeFinish, txtConfirmHandingOutText, cbFollowUp, cbFollowUpShowSMS, txtFollowUpDaysAfter, txtcbFollowUpText, cbConfirmReceive, cbConfirmReceiveShowSMS, txtArrivalOrdParts, loginName)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRetVal
    End Function

    <WebMethod()>
    Public Shared Function LoadSMSConfig(ByVal department As String) As SendSMSBO()
        Dim login As String = HttpContext.Current.Session("UserID")
        Dim SMSDetails As New List(Of SendSMSBO)()
        Try

            SMSDetails = objSendSMSServ.LoadSMSConfig(department, login)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return SMSDetails.ToList.ToArray

    End Function

    <WebMethod()>
    Public Shared Function SaveSMS(ByVal dept As String, ByVal phoneFrom As String, ByVal phoneTo As String, ByVal messageType As String, ByVal messageText As String, ByVal time As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""
        Dim login As String = HttpContext.Current.Session("UserID")
        Try

            '    objVehBo.IntNo = refNo.ToString()
            '    objVehBo.VehRegNo = regNo.ToString()

            '    If callInDate <> "" Then
            '        objVehBo.Call_In_Date = commonUtil.GetDefaultDate_MMDDYYYY(callInDate)
            '    Else
            '        objVehBo.Call_In_Date = Nothing
            '    End If

            '    If wreckingAmount <> "" Then
            '        objVehBo.WreckingAmount = wreckingAmount
            '    Else
            '        objVehBo.WreckingAmount = 0.0
            '    End If

            '    objVehBo.CreatedBy = _loginName


            strResult = objSendSMSServ.SaveSMS(dept, phoneFrom, phoneTo, messageType, messageText, login, time)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Login)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function SendSMSGlobal(ByVal dept As String, ByVal senderSMS As String, ByVal phoneTo As String, ByVal messageType As String, ByVal messageText As String, ByVal time As String, ByVal userId As String, ByVal userPassword As String, ByVal smsOperatorLink As String, ByVal linkId As String, ByVal orderId As String) As String
        Dim login As String = HttpContext.Current.Session("UserID")
        Dim strResult As String
        Dim dsReturnValStr As String = ""
        Try


            strResult = objSendSMSServ.SendSMSGlobal(dept, senderSMS, phoneTo, messageType, messageText, time, userId, userPassword, smsOperatorLink, linkId, login, orderId)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, login)
        End Try
        Return strResult
    End Function


    <WebMethod()>
    Public Shared Function saveXtraCheckResult(ByVal linkId As String, ByVal orderId As String, ByVal regId As String, ByVal msgType As String, ByVal created As String, ByVal expires As String, ByVal result As String, ByVal ordered As String, ByVal booked As String) As String

        sqlConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        sqlConnection = New SqlClient.SqlConnection(sqlConnectionString)

        sqlConnection.Open()
        sqlCommand = New SqlClient.SqlCommand("INSERT INTO SMS_DETAILS                    
  (                     
	LinkId,
	OrdreId,
	RegId,
	MeldingsType,
	Created,
	Expires,
	Result,
	Ordered,
	Booked                 
	                  
	                     
  )                    
  VALUES(     
	@LINK_ID,
	@ORDER_ID,
	@REGNR_ID,
	@MESSAGE_TYPE,
	DATEADD(SECOND, CONVERT(int,LEFT(@CREATEDDATE, 10)) , '1970/01/01 00:00:00'),
	DATEADD(SECOND, CONVERT(int,LEFT(@EXPIREDDATE, 10)) , '1970/01/01 00:00:00'),
	@RESULT,
	@ORDERED,
	DATEADD(SECOND, CONVERT(int,LEFT(@BOOKEDDATE, 10)) , '1970/01/01 00:00:00')
  )         ")
        sqlCommand.Connection = sqlConnection
        sqlCommand.Parameters.Add("@LINK_ID", SqlDbType.VarChar).Value = linkId
        sqlCommand.Parameters.Add("@ORDER_ID", SqlDbType.VarChar).Value = orderId
        sqlCommand.Parameters.Add("@REGNR_ID", SqlDbType.VarChar).Value = regId
        sqlCommand.Parameters.Add("@MESSAGE_TYPE", SqlDbType.VarChar).Value = msgType
        sqlCommand.Parameters.Add("@CREATEDDATE", SqlDbType.BigInt).Value = created
        sqlCommand.Parameters.Add("@EXPIREDDATE", SqlDbType.BigInt).Value = expires
        sqlCommand.Parameters.Add("@RESULT", SqlDbType.VarChar).Value = result
        sqlCommand.Parameters.Add("@ORDERED", SqlDbType.VarChar).Value = ordered
        sqlCommand.Parameters.Add("@BOOKEDDATE", SqlDbType.BigInt).Value = booked

        sqlCommand.CommandType = CommandType.Text

        Try

            sqlCommand.ExecuteNonQuery()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)

        Finally
            sqlConnection.Close()
            sqlConnection.Dispose()

        End Try
        Return "OK"
    End Function

    <WebMethod()>
    Public Shared Function getLinkId(ByVal orderId As String, ByVal msgType As String) As String

        sqlConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        sqlConnection = New SqlClient.SqlConnection(sqlConnectionString)

        Dim query As String = "Select TOP(1) LinkId FROM SMS WHERE OrdreId='" + orderId + "' AND MeldingsType='" + msgType + "' ORDER BY id DESC"
        Dim constr As String = sqlConnectionString
        Dim linkId As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand(query)

                cmd.CommandType = CommandType.Text
                cmd.Connection = con
                con.Open()
                linkId = cmd.ExecuteScalar()

            End Using
            con.Close()
            Return linkId
        End Using

    End Function



    <WebMethod()>
    Public Shared Function Fetch_SMSHistory() As List(Of SendSMSBO)

        Dim SMS As New List(Of SendSMSBO)
        Try
            SMS = objSendSMSServ.Fetch_SMSHistory()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_PurchaseOrder", "Fetch_PurchaseOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try


        Return SMS
    End Function

End Class