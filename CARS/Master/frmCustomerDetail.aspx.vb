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
Imports CARS.CoreLibrary.CARS.Services
Imports Encryption
Imports MSGCOMMON
Imports System.Web.Services
Imports System.Threading
Imports System.Globalization
Imports CARS.CoreLibrary.CARS
Imports Newtonsoft.Json
Imports System.Reflection
Imports DotNetDLL
Imports System.Xml.Serialization
Imports System.Xml

Imports Newtonsoft.Json.Linq


Public Class frmCustomerDetail
    Inherits System.Web.UI.Page
    Shared ddLangName As String = "ctl00$cntMainPanel$Language" 'Localization
    Public Const PostBackEventTarget As String = "__EVENTTARGET" 'Localization
    Shared objCustomerService As New CARS.CoreLibrary.CARS.Services.Customer.CustomerDetails
    Shared objWOJServ As New Services.WOJobDetails.WOJobDetails
    Shared objWOJDetailsBO As New CARS.CoreLibrary.WOJobDetailBO
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared commonUtil As New Utilities.CommonUtility
    Shared OErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared loginName As String
    Shared objCustBo As New CustomerBO
    Shared WShop As New Verksted("WEB") 'Lager en ny instans av DotNetLib.dll.Verksted, med kundens distkode
    Shared objEnumsBO As New CARS.CoreLibrary.Enums
    Shared gdprSmsAPI As String = "https://cars-web-api-production.herokuapp.com/api/v3/consent/"


    'Localization start ##############################################
    'Protected Overrides Sub InitializeCulture()
    '    Dim selectedValue As String
    '    Dim lang As String = Request.Form("Language")
    '    If Request(PostBackEventTarget) <> "" Then
    '        Dim controlID As String = Request(PostBackEventTarget)
    '        If controlID.Equals(ddLangName) Then
    '            selectedValue = Request.Form(Request(PostBackEventTarget))
    '            Select Case selectedValue
    '                Case "0"
    '                    SetCulture("nb-NO", "nb-NO")
    '                Case "1"
    '                    SetCulture("en-GB", "nb-NO")
    '                Case "2"
    '                    SetCulture("de-DE", "nb-NO")
    '                Case Else
    '            End Select
    '            If Session("MyUICulture").ToString <> "" And Session("MyCulture").ToString <> "" Then
    '                Thread.CurrentThread.CurrentUICulture = CType(Session.Item("MyUICulture"), CultureInfo)
    '                Thread.CurrentThread.CurrentCulture = CType(Session.Item("MyCulture"), CultureInfo)
    '            End If
    '        End If
    '    End If
    '    MyBase.InitializeCulture()
    'End Sub
    'Protected Sub SetCulture(name As String, locale As String)
    '    Thread.CurrentThread.CurrentUICulture = New CultureInfo(name)
    '    Thread.CurrentThread.CurrentCulture = New CultureInfo(locale)
    '    Session("MyUICulture") = Thread.CurrentThread.CurrentUICulture
    '    Session("MyCulture") = Thread.CurrentThread.CurrentCulture
    'End Sub

    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (Session("culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(Session("culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci
        End If
    End Sub



    'Localization end #################################################

    'Protected Sub cbCheckedChange(sender As Object, e As EventArgs)
    '    If cbPrivOrSub.Checked = True Then
    '        txtCompany.Visible = False
    '    Else
    '        txtCompany.Visible = True
    '    End If
    'End Sub


    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

        End If
        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            loginName = CType(Session("UserID"), String)
        End If
        WShop.serviceEndpoint = "http://www.carsweb.no/CarsService/CarsService.Verksted.svc?wsdl"  'Setter endpoint for GlobalServicen
        Try
            Dim strscreenName As String
            Dim dtCaption As DataTable
            loginName = CType(Session("UserID"), String)
            If Not IsPostBack Then
                dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)
                strscreenName = IO.Path.GetFileName(Me.Request.PhysicalPath)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "master_Customer_Details", "Page_Load", ex.Message, loginName)
        End Try
    End Sub


    'Protected Sub btnprivCustSMS_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnprivCustSMS.Click
    '    Session("MobileNo") = txtprivCustMobile.Text
    '    Session("Name") = txtFirstname.Text + " " + txtMiddlename.Text + " " + txtLastname.Text
    '    Session("Email") = txtprivCustEmail.Text
    '    ClientScript.RegisterStartupScript(Me.GetType(), "script", "window.open('frmSendSMS.aspx'), 'SendSMS'", True)

    'End Sub

    <WebMethod()>
    Public Shared Function GetZipCodes(ByVal zipCode As String) As List(Of String)
        Dim retZipCodes As New List(Of String)()
        Try
            retZipCodes = commonUtil.getZipCodes(zipCode, loginName)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "GetZipCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return retZipCodes
    End Function


    <WebMethod()>
    Public Shared Function FetchCustomerDetails(ByVal custId As String) As CustomerBO()
        Dim custDetails As New List(Of CustomerBO)()
        Try
            custDetails = objCustomerService.FetchCustomerDetails(custId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return custDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function FetchGdprDetails(ByVal custId As String) As CustomerBO()
        Dim custDetails As New List(Of CustomerBO)()
        Try
            custDetails = objCustomerService.FetchGdprDetails(custId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return custDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function GetCustomerContact(ByVal custId As String) As CustomerBO()
        Dim custContact As New List(Of CustomerBO)()
        Try
            custContact = objCustomerService.getCustomerContact(custId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "GetCustomerContact", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return custContact.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function InsertCustomerDetails(ByVal Customer As String) As String()
        Dim strResult As String()
        Dim dsReturnValStr As String = ""
        Dim cust As CustomerBO = JsonConvert.DeserializeObject(Of CustomerBO)(Customer)
        Try
            cust.CUST_NAME = cust.CUST_FIRST_NAME + " " + cust.CUST_MIDDLE_NAME + " " + cust.CUST_LAST_NAME
            Console.WriteLine(cust.CUST_FIRST_NAME)
            strResult = objCustomerService.Insert_Customer(cust)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function InsertGDPRDetails(ByVal Customer As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""
        Dim cust As CustomerBO = JsonConvert.DeserializeObject(Of CustomerBO)(Customer)
        Try
            strResult = objCustomerService.Insert_GDPR(cust)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function InsertGdprResponse(ByVal custId As String, ByVal manSms As String, ByVal manMail As String, ByVal pkkSms As String, ByVal pkkMail As String, ByVal servSms As String, ByVal servMail As String, ByVal utsTilbSms As String, ByVal utsTilbMail As String, ByVal xtraSms As String, ByVal xtraMail As String, ByVal remSms As String, ByVal remMail As String, ByVal infoSms As String, ByVal infoMail As String, ByVal oppfSms As String, ByVal oppfMail As String, ByVal markSms As String, ByVal markMail As String, ByVal responseDate As String) As String


        Dim strResult As String
        Dim dsReturnValStr As String = ""
        Try
            strResult = objCustomerService.Insert_GDPR_Response(custId, manSms, manMail, pkkSms, pkkMail, servSms, servMail, utsTilbSms, utsTilbMail, xtraSms, xtraMail, remSms, remMail, infoSms, infoMail, oppfSms, oppfMail, markSms, markMail, responseDate)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function InsertCCPFunction(ByVal code As String, ByVal description As String)
        Dim strResult As String()
        Try
            strResult = objCustomerService.CCP_Function_Insert(code, description)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCCPFunction", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function InsertCCPTitle(ByVal code As String, ByVal description As String)
        Dim strResult As String()
        Try
            strResult = objCustomerService.CCP_Title_Insert(code, description)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCCPTitle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function FetchEniro(ByVal search As String) As CustomerBO()
        Dim details As New List(Of CustomerBO)()
        Try
            details = objCustomerService.GetEniroData(search)
            Dim dt As New DataTable()
            dt.TableName = "localCustDetails"
            For Each [property] As PropertyInfo In details(0).[GetType]().GetProperties()
                dt.Columns.Add(New DataColumn([property].Name, [property].PropertyType))
            Next

            For Each vehicle As CustomerBO In details
                Dim newRow As DataRow = dt.NewRow()
                For Each [property] As PropertyInfo In vehicle.[GetType]().GetProperties()
                    newRow([property].Name) = vehicle.[GetType]().GetProperty([property].Name).GetValue(vehicle, Nothing)
                Next
                dt.Rows.Add(newRow)
            Next
            HttpContext.Current.Session("CustomerDet") = dt

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "LoadSubsidiary", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function SendSMS(ByVal deptId As String, ByVal senderSMS As String, ByVal userId As String, ByVal userPsw As String, ByVal smsOperatorLink As String, ByVal smsNumber As String, ByVal smsText As String) As List(Of CustomerBO)

        Dim objEniroDetails As New List(Of CustomerBO)()
        'Dim IdArr As Array
        Dim num As String = smsNumber

        Try
            Dim contactLink As String = ""
            Dim custDetails As String = ""
            Dim url As String = "https://admin.intouch.no/smsgateway/sendSms?sender=" + senderSMS + "&targetNumbers=" + num + "&sms=" + smsText + "&userName=" + userId + "&password=" + userPsw
            Dim request As Net.HttpWebRequest = DirectCast(Net.WebRequest.Create(url), Net.HttpWebRequest)
            Dim response As Net.HttpWebResponse = DirectCast(request.GetResponse(), Net.HttpWebResponse)
            Dim reader As StreamReader = New StreamReader(response.GetResponseStream())
            Dim json As String = reader.ReadToEnd
            'Dim o As JObject = JObject.Parse(json)
            'Dim i As Integer = 1
            'Dim results = o("result")

            Return objEniroDetails
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    <WebMethod()>
    Public Shared Function LoadEniroDet(ByVal EniroId As String) As CustomerBO()
        Try
            Dim details As New List(Of CustomerBO)()
            details = objCustomerService.LoadEniroDetails(EniroId)
            Return details.ToList.ToArray
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_CustomerDetail", "LoadEniroDet", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Function



    <WebMethod()>
    Public Shared Function BindContact(ByVal Id As String) As List(Of String)
        Try
            Dim retDet As New List(Of String)()
            retDet = objCustomerService.BindContact(Id)
            Return retDet
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_CustomerDetail", "LoadEniroDet", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Function

    <WebMethod()>
    Public Shared Function getBrregData(ByVal Search As String) As CustomerBO.Brregdata()
        Try
            Dim details As New List(Of CustomerBO.Brregdata)()
            details = objCustomerService.getBrregData(Search)
            Return details.ToList.ToArray
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_CustomerDetail", "getBrregData", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Function

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function Company_List(ByVal q As String) As CustomerBO()
        Dim vehDetails As New List(Of CustomerBO)()
        Try
            vehDetails = objCustomerService.Company_List(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transaction_frmWOSearch", "Vehicle_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return vehDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function LoadSalesman() As CustomerBO()
        Dim Salesman As New List(Of CustomerBO)()
        Try
            Salesman = objCustomerService.FetchSalesman()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Salesman.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetSalesman(ByVal loginId As String) As CustomerBO()
        Dim Salesman As New List(Of CustomerBO)()
        Try
            Salesman = objCustomerService.GetSalesman(loginId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Salesman.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadBranch() As CustomerBO()
        Dim Branch As New List(Of CustomerBO)()
        Try
            Branch = objCustomerService.FetchBranch()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Branch.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetBranch(ByVal branchId As String) As CustomerBO()
        Dim Branch As New List(Of CustomerBO)()
        Try
            Branch = objCustomerService.GetBranch(branchId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Branch.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadCategory() As CustomerBO()
        Dim Category As New List(Of CustomerBO)()
        Try
            Category = objCustomerService.FetchCategory()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Category.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetCategory(ByVal categoryId As String) As CustomerBO()
        Dim Category As New List(Of CustomerBO)()
        Try
            Category = objCustomerService.GetCategory(categoryId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Category.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function LoadSalesGroup() As CustomerBO()
        Dim SalesGroup As New List(Of CustomerBO)()
        Try
            SalesGroup = objCustomerService.FetchSalesGroup()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return SalesGroup.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetSalesGroup(ByVal salesgroupId As String) As CustomerBO()
        Dim SalesGroup As New List(Of CustomerBO)()
        Try
            SalesGroup = objCustomerService.GetSalesGroup(salesgroupId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return SalesGroup.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadPaymentTerms() As CustomerBO()
        Dim PaymentTerms As New List(Of CustomerBO)()
        Try
            PaymentTerms = objCustomerService.FetchPaymentTerms()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return PaymentTerms.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetPaymentTerms(ByVal paymentTermsId As String) As CustomerBO()
        Dim PaymentTerms As New List(Of CustomerBO)()
        Try
            PaymentTerms = objCustomerService.GetPaymentTerms(paymentTermsId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return PaymentTerms.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadCardType() As CustomerBO()
        Dim CardType As New List(Of CustomerBO)()
        Try
            CardType = objCustomerService.FetchCardType()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return CardType.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetCardType(ByVal cardTypeId As String) As CustomerBO()
        Dim CardType As New List(Of CustomerBO)()
        Try
            CardType = objCustomerService.GetCardType(cardTypeId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return CardType.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadCurrencyType() As CustomerBO()
        Dim CurrencyType As New List(Of CustomerBO)()
        Try
            CurrencyType = objCustomerService.FetchCurrencyType()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return CurrencyType.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function GetCurrencyType(ByVal currencyId As String) As CustomerBO()
        Dim CurrencyType As New List(Of CustomerBO)()
        Try
            CurrencyType = objCustomerService.GetCurrencyType(currencyId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return CurrencyType.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function AddBranch(ByVal branchCode As String, ByVal branchText As String, ByVal branchNote As String, ByVal branchAnnot As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Try
            objCustBo.BRANCH_CODE = branchCode
            objCustBo.BRANCH_TEXT = branchText
            objCustBo.BRANCH_NOTE = branchNote
            objCustBo.BRANCH_ANNOT = branchAnnot

            strResult = objCustomerService.Add_Branch(objCustBo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function DeleteBranch(ByVal branchId As String) As CustomerBO()
        Dim Branch As New List(Of CustomerBO)()
        Try
            Branch = objCustomerService.DeleteBranch(branchId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Branch.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function AddCategory(ByVal categoryCode As String, ByVal categoryText As String, ByVal categoryAnnot As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Try
            objCustBo.CATEGORY_CODE = categoryCode
            objCustBo.CATEGORY_TEXT = categoryText
            objCustBo.CATEGORY_ANNOT = categoryAnnot

            strResult = objCustomerService.Add_Category(objCustBo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function



    <WebMethod()>
    Public Shared Function DeleteCategory(ByVal categoryId As String) As CustomerBO()
        Dim Category As New List(Of CustomerBO)()
        Try
            Category = objCustomerService.DeleteCategory(categoryId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Category.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function AddSalesGroup(ByVal salesgroupCode As String, ByVal salesgroupText As String, ByVal salesgroupInv As String, ByVal salesgroupVat As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Try
            objCustBo.SALESGROUP_CODE = salesgroupCode
            objCustBo.SALESGROUP_TEXT = salesgroupText
            objCustBo.SALESGROUP_INVESTMENT = salesgroupInv
            objCustBo.SALESGROUP_VAT = salesgroupVat

            strResult = objCustomerService.Add_SalesGroup(objCustBo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function DeleteSalesGroup(ByVal salesgroupId As String) As CustomerBO()
        Dim SalesGroup As New List(Of CustomerBO)()
        Try
            SalesGroup = objCustomerService.DeleteSalesGroup(salesgroupId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return SalesGroup.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function AddPaymentTerms(ByVal paytermsCode As String, ByVal paytermsText As String, ByVal paytermsDays As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Try
            objCustBo.PAYMENT_TERMS_CODE = paytermsCode
            objCustBo.PAYMENT_TERMS_TEXT = paytermsText
            objCustBo.PAYMENT_TERMS_DAYS = paytermsDays

            strResult = objCustomerService.Add_PaymentTerms(objCustBo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function DeletePaymentTerms(ByVal paymenttermsId As String) As CustomerBO()
        Dim PaymentTerms As New List(Of CustomerBO)()
        Try
            PaymentTerms = objCustomerService.DeletePaymentTerms(paymenttermsId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return PaymentTerms.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function AddCardType(ByVal cardtypeCode As String, ByVal cardtypeText As String, ByVal cardtypeCustno As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Try
            objCustBo.CARD_TYPE_CODE = cardtypeCode
            objCustBo.CARD_TYPE_TEXT = cardtypeText
            objCustBo.CARD_TYPE_CUSTNO = cardtypeCustno

            strResult = objCustomerService.Add_CardType(objCustBo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function DeleteCardType(ByVal cardtypeId As String) As CustomerBO()
        Dim CardType As New List(Of CustomerBO)()
        Try
            CardType = objCustomerService.DeleteCardType(cardtypeId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return CardType.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function AddCurrencyType(ByVal currencyCode As String, ByVal currencyText As String, ByVal currencyRate As String) As String
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        Try
            objCustBo.CURRENCY_TYPE_CODE = currencyCode
            objCustBo.CURRENCY_TYPE_TEXT = currencyText
            objCustBo.CURRENCY_TYPE_RATE = currencyRate

            strResult = objCustomerService.Add_CurrencyType(objCustBo)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "AddVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function DeleteCurrency(ByVal currencyId As String) As CustomerBO()
        Dim Currency As New List(Of CustomerBO)()
        Try
            Currency = objCustomerService.DeleteCurrency(currencyId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return Currency.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function fetch_activities(customer_id) As CustomerBO()
        Dim activities As New List(Of CustomerBO)()
        Try
            activities = objCustomerService.fetch_activities(customer_id)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadWarrantyCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return activities.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function LoadCustomerTemplate() As CustomerBO()
        Dim CustomerTemplate As New List(Of CustomerBO)()
        Try
            CustomerTemplate = objCustomerService.LoadCustomerTemplate()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadWarrantyCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return CustomerTemplate.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function FetchCustomerTemplate(ByVal tempId As String) As CustomerBO()
        Dim custDetails As New List(Of CustomerBO)()
        Try
            custDetails = objCustomerService.FetchCustomerTemplate(tempId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return custDetails.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function InsertCustomerTemplate(ByVal Customer As String) As String()
        Dim strResult As String()
        Dim dsReturnValStr As String = ""
        Dim cust As CustomerBO = JsonConvert.DeserializeObject(Of CustomerBO)(Customer)
        Try
            cust.CUST_NAME = cust.CUST_FIRST_NAME + " " + cust.CUST_MIDDLE_NAME + " " + cust.CUST_LAST_NAME
            Console.WriteLine(cust.CUST_FIRST_NAME)
            strResult = objCustomerService.InsertCustomerTemplate(cust)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function LoadContactType() As CustomerBO()
        Dim ContactType As New List(Of CustomerBO)()
        Try
            ContactType = objCustomerService.FetchContactType()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadWarrantyCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return ContactType.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function LoadContact(ByVal custId As String) As CustomerBO.ContactInformation()
        Dim ContactType As New List(Of CustomerBO.ContactInformation)()
        Try
            ContactType = objCustomerService.FetchContact(custId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_VehicleDetail", "LoadWarrantyCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return ContactType.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function AddCustomerContact(ByVal seq As String, ByVal contactType As String, ByVal customerId As String, ByVal contactValue As String, ByVal contactStandard As Boolean)
        Dim strResult As String = ""
        Dim dsReturnValStr As String = ""
        If (seq.Length < 1) Then
            seq = ""
        End If
        Try
            objCustBo.CONTACT_TYPE = contactType
            objCustBo.CONTACT_DESCRIPTION = contactValue
            objCustBo.CONTACT_STANDARD = contactStandard
            objCustBo.ID_CUSTOMER = customerId
            objCustBo.USER_LOGIN = loginName

            strResult = objCustomerService.Add_CustomerContact(objCustBo, seq)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "AddCustomer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function AddCustomerContactPerson(ByVal CustomerCP As String) As String
        Dim strResult As String
        Dim dsReturnValStr As String = ""
        Dim custCP As CustomerBO.ContactPerson = JsonConvert.DeserializeObject(Of CustomerBO.ContactPerson)(CustomerCP)
        Try
            strResult = objCustomerService.Add_CustomerContactPerson(custCP)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "InsertCustomerContactPerson", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function FetchCustomerContactPerson(ByVal ID_CP As String, ByVal CP_CUSTOMER_ID As String)
        Dim custDetails As New List(Of CustomerBO.ContactPerson)()
        Try
            custDetails = objCustomerService.Fetch_CustomerContactPerson(ID_CP, CP_CUSTOMER_ID)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return custDetails.ToList.ToArray
    End Function
    <WebMethod()>
    Public Shared Function DeleteCustomerContactPerson(ByVal ID_CP As String)
        Dim strResult As String = ""
        Try
            strResult = objCustomerService.Delete_CustomerContactPerson(ID_CP)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_CustomerDetails", "DeleteContactPerson", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function Fetch_CCP_Title(ByVal q As String)
        Dim ccpTitle As New List(Of CustomerBO.ContactPersonTitle)()
        Try
            ccpTitle = objCustomerService.Fetch_CCP_Title(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return ccpTitle.ToList.ToArray
    End Function
    <WebMethod()>
    Public Shared Function Fetch_CCP_Function(ByVal q As String)
        Dim ccpFunction As New List(Of CustomerBO.ContactPersonFunction)()
        Try
            ccpFunction = objCustomerService.Fetch_CCP_Function(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCustomerDetail", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return ccpFunction.ToList.ToArray
    End Function

    <WebMethod()>
    Public Shared Function DeleteContact(ByVal CustomerSeq As String)
        Dim strResult As String = ""
        Try
            strResult = objCustomerService.Delete_Contact(CustomerSeq)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_CustomerDetails", "DeleteContact", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function StandardContact(ByVal CustomerSeq As String)
        Dim strResult As String = ""
        Try
            strResult = objCustomerService.Standard_Contact(CustomerSeq)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_CustomerDetails", "StandardContact", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function SendGdprMobile(ByVal deptId As String, ByVal senderSMS As String, ByVal userId As String, ByVal userPsw As String, ByVal smsOperatorLink As String, ByVal custMob As String, ByVal custName As String, ByVal custId As String, ByVal orderId As String, ByVal result As String, ByVal text As String, ByVal amount As String) As String
        Dim testvalue As String = ""
        Try
            Dim txt = "Hei.Vi har nå sett over dekkene du har her hos oss.Det er behov for nye dekk. Foreslår å montere nye dekk med 40 % rabatt"
            'Dim appr As AppResponse = WShop.GetServiceData(servicetype, ordrenummer, regnummer, verkstednavn, verkstedtelefon, kundenavn, kundemobil, tilbudstekst, beløp, antall minutter å sjekke for svar)
            Dim appr As AppResponse = WShop.GetServiceData(objEnumsBO.gdpr, custId, custName, custMob, senderSMS, "32242070")
            'AddHandler AppSearch.ResponseReceived, AddressOf ResponsArrived 'Subscribe to AppAnswerReceived event
            'If String.IsNullOrEmpty(appr.error) Or appr.error = "OK" Then
            '    testvalue = appr.dataToWrite
            '    testvalue += "OK"
            'Else
            '    testvalue = appr.error
            'End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return testvalue
    End Function

    <WebMethod()>
    Public Shared Function ResponsArrived(ByVal responseId As String) As String 'Do something with mobile answer
        Dim bargainAccepted As Integer = 0
        Dim apiPath As String = ""
        Dim responseString As String = ""
        apiPath = "http://cars-web-api-production.herokuapp.com/api/v3/consent/" + responseId
        Dim uri As Uri = New Uri(apiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                responseString = reader.ReadToEnd()
                If responseString <> "" And responseString <> "0" Then

                    Dim jsonObject As JObject = JObject.Parse(responseString)
                    'responseString = jsonObject("answered").ToString


                End If
            End Using
        End If

        Return responseString
    End Function

    <WebMethod()>
    Public Shared Function GdprSMSNew(ByVal jsonGdprData As String) As String
        Dim counter As Integer = 0
        Dim responseId As String = String.Empty
        Dim apiToken As String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiaXNzIjoiQ2Fyc1dlYiIsInVzZXJuYW1lIjoiY2FycyIsImV4cCI6MTkyMDU0OTk0NiwidHlwZSI6IkFQSSIsImlhdCI6MTYwNTAxNzE0Nn0.gUGGFxhFT4oVF_x362BRCMRhDe-q6WwhNTfvzzBqf7s"
        Dim contentType = "application/json"
        Try
            responseId = PostMessage(jsonGdprData, gdprSmsAPI, apiToken, contentType)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                responseId = PostMessage(jsonGdprData, gdprSmsAPI, apiToken, contentType)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "BargainSMSNew", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return responseId
    End Function

    Shared Function PostMessage(ByVal _request As String, ByVal _endpoint As String, ByVal _token As String, ByVal _contentType As String) As String
        Dim responseString As String = String.Empty
        Dim responseId As String = String.Empty

        Dim uri As Uri = New Uri(_endpoint)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        Dim postDataBytes() As Byte = Encoding.UTF8.GetBytes(_request)
        req.ContentType = _contentType
        req.Method = "POST"
        req.Headers.Add("authorization", _token)
        req.ContentLength = postDataBytes.Length
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3
        Using stream As Stream = req.GetRequestStream()
            stream.Write(postDataBytes, 0, postDataBytes.Length)
        End Using

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                responseString = reader.ReadToEnd()
                If responseString <> "" Then
                    Dim jsonObject As JObject = JObject.Parse(responseString)
                    responseId = jsonObject("uuid").ToString

                    'Saving the Bargain Id to TBL_WO_HEADER table
                    objCustBo.ID_CUSTOMER = responseId

                    objCustBo.MODIFIED_BY = loginName
                    'objCustomerService.Modify_WO_Header("BARGAINID", objWOHeaderBO)
                End If

            End Using
        End If

        Return responseId
    End Function

End Class





'Partial Class frmCustomerDetail
'    Protected Sub cbCheckedChange(sender As Object, e As EventArgs)
'        If cbPrivOrSub.Checked = True Then
'            txtCompany.Visible = False

'        Else
'            txtCompany.Visible = True

'        End If
'    End Sub
'End Class