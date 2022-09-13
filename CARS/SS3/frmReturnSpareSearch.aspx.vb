Imports System.Globalization
Imports System.IO
Imports System.Net
Imports System.Threading
Imports System.Web.Services
Imports System.Xml
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS.Services
Imports DevExpress.XtraReports.Web

Public Class frmReturnSpareSearch
    Inherits System.Web.UI.Page
    Shared loginName As String
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared objRetSprBO As New ReturnSpareBO
    Shared objRetSpr As New CoreLibrary.CARS.Services.ReturnSpare.ReturnSpare
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            EnableViewState = False
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If

            gvRetSprList.DataSource = FetchReturnSpareHeader("")
            gvRetSprList.DataBind()

            If txtReturnNum.Text IsNot Nothing And txtReturnNum.Text IsNot "" Then
                Dim dsRetSprDtl As New DataSet
                dsRetSprDtl = objRetSpr.Fetch_Return_Spare_Details(txtReturnNum.Text)
                gvRetSprDtl.DataSource = dsRetSprDtl
                gvRetSprDtl.DataBind()
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Public Function FetchReturnSpareHeader(searchStr As String) As DataSet
        Dim strResult As New DataSet
        Try
            strResult = objRetSpr.Fetch_Return_Spare_Header(searchStr)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "FetchReturnSpareHeader", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return strResult
    End Function

    Protected Sub cbRetSprDtl_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim dsRetSprDtl As New DataSet
            Dim dtRetSprDtl As New DataTable
            Dim returnNumber As Integer = Integer.Parse(e.Parameter)
            dsRetSprDtl = objRetSpr.Fetch_Return_Spare_Details(returnNumber)

            If dsRetSprDtl IsNot Nothing Then
                dtRetSprDtl = dsRetSprDtl.Tables(0)
                If dtRetSprDtl.Rows.Count > 0 Then

                    Dim dtRow As DataRow = dtRetSprDtl.Rows(0)
                    Dim retStatus As String = IIf(IsDBNull(dtRow("RETURN_STATUS")), "", dtRow("RETURN_STATUS"))
                    txtReturnNum.Text = IIf(IsDBNull(dtRow("ID_RETURN_NUM")), "", dtRow("ID_RETURN_NUM"))

                    If retStatus = "OPEN" Then
                        cbxIsCredited.Checked = False
                        cbxIsCredited.Checked = False
                        gvRetSprDtl.Enabled = True
                        cbxIsCredited.Disabled = True
                        txtAnnotation.Enabled = True
                    ElseIf retStatus = "RETURNED" Then
                        gvRetSprDtl.Enabled = False
                        cbxIsCredited.Disabled = False
                        txtAnnotation.Enabled = False
                    ElseIf retStatus = "CREDITED" Then
                        cbxIsCredited.Checked = True
                        gvRetSprDtl.Enabled = False
                        cbxIsCredited.Disabled = True
                        txtAnnotation.Enabled = False
                    End If

                    If IsDBNull(dtRow("DT_RETURNED")) Then
                        txtDateRetToSup.Text = ""
                    Else
                        txtDateRetToSup.Text = Date.Parse(dtRow("DT_RETURNED")).ToShortDateString
                    End If

                    If IsDBNull(dtRow("DT_CREATED")) Then
                        txtReturnDate.Text = ""
                    Else
                        txtReturnDate.Text = Date.Parse(dtRow("DT_CREATED")).ToShortDateString
                    End If

                    If IsDBNull(dtRow("DT_CREDITED")) Then
                        txtDtCredited.Text = ""
                    Else
                        txtDtCredited.Text = Date.Parse(dtRow("DT_CREDITED")).ToShortDateString
                    End If

                    txtRetSupplier.Text = IIf(IsDBNull(dtRow("SUPPLIER_NO")), "", dtRow("SUPPLIER_NO"))
                    lblSupplierName.Text = IIf(IsDBNull(dtRow("SUPPLIER_NAME")), "", dtRow("SUPPLIER_NAME"))
                    txtRetStatus.Text = retStatus
                    txtAnnotation.Text = IIf(IsDBNull(dtRow("ANNOTATION")), "", dtRow("ANNOTATION"))

                End If
            End If

            gvRetSprDtl.DataSource = dsRetSprDtl
            gvRetSprDtl.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "cbRetSprDtl_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function AutofillReturnCode(ByVal q As String) As ReturnSpareBO()
        Dim returnCodeDetails As New List(Of ReturnSpareBO)()
        Try
            returnCodeDetails = objRetSpr.Fetch_Return_Code(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "AutofillReturnCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return returnCodeDetails.ToList.ToArray
    End Function
    Protected Sub gvRetSprDtl_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Try
            Dim dsRetSprDtl As New DataSet
            Dim returnNo As String = txtReturnNum.Text
            Dim strResult As String = ""
            Dim idItemDltret As Integer
            Dim returnCode As String
            For Each item In e.UpdateValues
                idItemDltret = item.Keys(0)
                returnCode = item.NewValues("RETURN_CODE")
                strResult = objRetSpr.Modify_Return_Code(idItemDltret, returnCode)
                If strResult = "UPDATED" Then
                    gvRetSprDtl.JSProperties("cpIsRetCodeUpd") = True
                Else
                    gvRetSprDtl.JSProperties("cpIsRetCodeUpd") = False
                End If
            Next
            If returnNo IsNot "" Then
                dsRetSprDtl = objRetSpr.Fetch_Return_Spare_Details(returnNo)
                gvRetSprDtl.DataSource = dsRetSprDtl
                gvRetSprDtl.DataBind()
                e.Handled = True
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "gvRetSprDtl_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function GetSparePrice(ByVal spIdItem As String, ByVal suppCurrNo As String, ByVal idItemRetNo As String, ByVal returnNo As String) As StockQuantityBO
        Dim suppStockId As String = ""
        Dim dealerNoSpare As String = ""
        Dim woStockQty As New StockQuantityBO
        Dim dsConfigStatus As New DataSet
        Dim counter As Integer = 0
        Dim userName As String = HttpContext.Current.Session("UserID")
        Try
            Dim objConfigWODO As New CoreLibrary.CARS.ConfigWorkOrder.ConfigWorkOrderDO
            dsConfigStatus = objConfigWODO.GetConfigWorkOrder(userName)
            If dsConfigStatus IsNot Nothing Then
                suppStockId = IIf(IsDBNull(dsConfigStatus.Tables(0).Rows(0)("SUPP_STOCK_ID")), "", dsConfigStatus.Tables(0).Rows(0)("SUPP_STOCK_ID").ToString)
                dealerNoSpare = IIf(IsDBNull(dsConfigStatus.Tables(0).Rows(0)("DEALER_NO")), "", dsConfigStatus.Tables(0).Rows(0)("DEALER_NO").ToString)
            End If
            woStockQty = CallHentPris_API(spIdItem, suppCurrNo, suppStockId, dealerNoSpare, idItemRetNo, returnNo)

        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                woStockQty = CallHentPris_API(spIdItem, suppCurrNo, suppStockId, dealerNoSpare, idItemRetNo, returnNo)
            Else
                objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "GetSparePrice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, userName)
            End If
        End Try
        Return woStockQty
    End Function
    Public Shared Function CallHentPris_API(spIdItem As String, suppCurrNo As String, suppStockId As String, dealerNoSpare As String, idItemRetNo As String, returnNo As String) As StockQuantityBO
        Dim xmlResponseString As String = ""
        Dim objStockQuantityBO As New StockQuantityBO
        Dim xmlDoc As New XmlDocument
        Dim apiPath As String = "https://gw.autodata.no/cars9000/qpc_beh.php?lev=" + suppStockId + "&knr=" + dealerNoSpare + "&art=" + spIdItem
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
                xmlResponseString = reader.ReadToEnd()
                Dim sourceEncoding As Encoding = Encoding.GetEncoding(1252)
                If xmlResponseString <> "" And xmlResponseString <> "0" Then
                    objStockQuantityBO.spareID = spIdItem
                    If Not xmlResponseString.Contains("<FEIL>") Then
                        xmlDoc.LoadXml(xmlResponseString)
                        Dim levNode As XmlNodeList = xmlDoc.SelectNodes("/xml/autodata/lev" + suppStockId + "/post")
                        Dim sogbNode As XmlNodeList = xmlDoc.SelectNodes("/xml/autodata/sogb/art")

                        If (levNode IsNot Nothing) Then
                            For Each node As XmlElement In levNode
                                objStockQuantityBO.alfaLev = IIf(node("alfa") IsNot Nothing, node("alfa").InnerText.Trim, "")
                                objStockQuantityBO.antallLev = IIf(node("antall") IsNot Nothing, node("antall").InnerText.Trim, "0")
                                objStockQuantityBO.artnrLev = IIf(node("artnr") IsNot Nothing, node("artnr").InnerText.Trim, "")
                                objStockQuantityBO.bruttoLev = IIf(node("brutto") IsNot Nothing, node("brutto").InnerText.Trim, "")
                                objStockQuantityBO.merknadLev = IIf(node("merknad") IsNot Nothing, node("merknad").InnerText.Trim, "")
                                objStockQuantityBO.navnLev = IIf(node("navn") IsNot Nothing, System.Web.HttpUtility.UrlDecode(node("navn").InnerText.Trim, sourceEncoding), "")
                                objStockQuantityBO.nettoLev = IIf(node("netto") IsNot Nothing, node("netto").InnerText.Trim, "")
                                objStockQuantityBO.nrLev = node.Attributes("nr").Value.Trim
                            Next
                        End If

                        If (sogbNode IsNot Nothing) Then
                            For Each node As XmlElement In sogbNode
                                objStockQuantityBO.alfaSogb = IIf(node("alfa") IsNot Nothing, node("alfa").InnerText.Trim, "")
                                objStockQuantityBO.antallSogb = IIf(node("antall") IsNot Nothing, node("antall").InnerText.Trim, "0")
                                objStockQuantityBO.artnrSogb = IIf(node("artnr") IsNot Nothing, node("artnr").InnerText.Trim, "")
                                objStockQuantityBO.navnSogb = IIf(node("navn") IsNot Nothing, System.Web.HttpUtility.UrlDecode(node("navn").InnerText.Trim, sourceEncoding), "")
                                objStockQuantityBO.noSogb = node.Attributes("no").Value.Trim
                            Next
                        End If

                        If (Not objStockQuantityBO.navnLev.Contains("FEIL")) Then
                            Dim retString As String = ""
                            Dim objRetSprBO As New ReturnSpareBO()
                            objRetSprBO.IdItemReturnNo = idItemRetNo
                            objRetSprBO.ReturnNo = returnNo
                            objRetSprBO.CostPrice = objStockQuantityBO.nettoLev.Trim()
                            objRetSprBO.SalePrice = objStockQuantityBO.bruttoLev.Trim()
                            objRetSprBO.WebSparePartId = objStockQuantityBO.alfaLev.Trim() + " " + objStockQuantityBO.artnrLev.Trim()
                            objRetSprBO.SupplierNo = suppCurrNo
                            objRetSprBO.IdItem = objStockQuantityBO.spareID
                            retString = objRetSpr.Update_Prices_ReturnOrder(objRetSprBO)

                            objStockQuantityBO.isValid = IIf(retString = "UPDATED", True, False)

                        End If

                    End If
                End If
            End Using
        End If
        Return objStockQuantityBO
    End Function

    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function UpdateReturnOrders(ByVal isCredited As String, ByVal ReturnNo As String, ByVal Annotation As String) As String
        Dim objRetSprBO As New ReturnSpareBO
        objRetSprBO.IsCredited = Boolean.Parse(isCredited)
        objRetSprBO.ReturnNo = ReturnNo
        objRetSprBO.Annotation = Annotation

        Dim strResult As String = ""
        Try
            strResult = objRetSpr.Update_Return_Orders(objRetSprBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "UpdateReturnOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return strResult
    End Function

    Protected Sub cbPanel_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim ReturnNo As Integer = 0
            If (e.Parameter.Length > 0) Then
                ReturnNo = Integer.Parse(e.Parameter)
            End If
            Dim myRep = New dxReturnSpareParts()
            myRep.Name = "Return Spare Report " + ReturnNo.ToString()
            myRep.Parameters("pReturnCode").Value = ""
            myRep.Parameters("pReturnNo").Value = ReturnNo
            myRep.Parameters("pUserId").Value = loginName
            myRep.RequestParameters = False
            myRep.ApplyLocalization(ConfigurationManager.AppSettings("Culture"))
            Dim cachedReportSource = New CachedReportSourceWeb(myRep)
            Session("ReportSource") = cachedReportSource

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "cbPanel_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Protected Sub cbRetSprHrd_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            gvRetSprList.DataSource = FetchReturnSpareHeader("")
            gvRetSprList.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "cbRetSprHrd_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Protected Overrides Sub InitializeCulture()
        Try
            MyBase.InitializeCulture()
            If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
                Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
                Thread.CurrentThread.CurrentCulture = ci
                Thread.CurrentThread.CurrentUICulture = ci
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_frmReturnSpareSearch", "InitializeCulture", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub
End Class