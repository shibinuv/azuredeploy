Imports System.Globalization
Imports System.IO
Imports System.Net
Imports System.Threading
Imports System.Web.Services
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS
Imports CARS.CoreLibrary.CARS.ZipCodes

Public Class frmConfigGeneral
    Inherits System.Web.UI.Page
    Shared objConfigZipCodeDO As New CoreLibrary.CARS.ZipCodes.ZipCodesDO
    Shared objConfigSettingsDO As New CoreLibrary.CARS.ConfigSettings.ConfigSettingsDO
    Shared dtCaption As DataTable
    Shared commonUtil As New Utilities.CommonUtility
    Shared objZipCodesBO As New ZipCodesBO
    Shared objConfigGenServ As New Services.ConfigGeneral.ConfigGeneral
    Shared configdetails As New List(Of ConfigSettingsBO)()
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared loginName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            EnableViewState = False
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If
            Dim strscreenName As String = ""
            dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)
            hdnSelect.Value = dtCaption.Select("TAG='select'")(0)(1)
            hdnPageSize.Value = System.Configuration.ConfigurationManager.AppSettings("PageSize")
            strscreenName = "frmCfGeneral.aspx"

            cmbTimeFormat.Items.Clear()
            cmbTimeFormat.Items.Add(dtCaption.Select("TAG='select'")(0)(1))
            cmbTimeFormat.AppendDataBoundItems = True
            commonUtil.ddlGetValue(strscreenName, cmbTimeFormat)

            cmbUnitofTimings.Items.Clear()
            cmbUnitofTimings.Items.Add(dtCaption.Select("TAG='select'")(0)(1))
            cmbUnitofTimings.AppendDataBoundItems = True
            commonUtil.ddlGetValue(strscreenName, cmbUnitofTimings)
            Dim dsGenSettings As DataSet = objConfigZipCodeDO.Fetch_AllZipCode()
            Dim dsConfGen As DataSet = objConfigSettingsDO.Fetch_TRConfiguration(HttpContext.Current.Session("UserID").ToString(), "DISCD", "VAT", "LEAVE_RESN", Nothing, Nothing)
            gvZipCode.DataSource = dsGenSettings.Tables(0)
            gvZipCode.DataBind()
            gvDiscCode.DataSource = dsConfGen.Tables(0)
            gvDiscCode.DataBind()
            gvReasonFrLv.DataSource = dsConfGen.Tables(2)
            gvReasonFrLv.DataBind()

            gvStationType.DataSource = objConfigSettingsDO.Fetch_StationType()
            gvStationType.DataBind()

            gvDeptMess.DataSource = dsConfGen.Tables(5)
            gvDeptMess.DataBind()

            Session("dsDepartment") = objConfigSettingsDO.Fetch_AllDepartment()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub

    Protected Sub cbZipCode_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim dsGenSettings As DataSet = objConfigZipCodeDO.Fetch_AllZipCode()
            gvZipCode.DataSource = dsGenSettings.Tables(0)
            gvZipCode.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "cbZipCode_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    <WebMethod()>
    Public Shared Function LoadGenSettings() As Collection
        Dim configDetails As New Collection
        Try
            configDetails = objConfigGenServ.FetchAllZipCode()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "LoadGenSettings", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return configDetails
    End Function
    <WebMethod()>
    Public Shared Function SaveGenSettings(ByVal timeFormat As String, ByVal unitOfTime As String, ByVal currency As String, ByVal minSplits As String,
                                      ByVal useSubRepCode As String, ByVal useAutoResize As String, ByVal useDynClkTime As String, ByVal useNewJobCard As String,
                                      ByVal useEdtStdTime As String, ByVal useViewGarSum As String, ByVal useMondStDay As String, ByVal useVehRegn As String,
                                      ByVal useInvPdf As String, ByVal useDBS As String, ByVal useApprIR As String, ByVal useMechGrid As String,
                                      ByVal useSortPL As String, ByVal useValStdTime As String, ByVal useEdtChgTime As String, ByVal useValMileage As String,
                                      ByVal useSavUpdDP As String, ByVal useIntNote As String, ByVal useGrpSPBO As String, ByVal useDispWOSpares As String) As String
        Dim strResult As String = ""
        Try
            strResult = objConfigGenServ.SaveGenSettings(timeFormat, unitOfTime, currency, minSplits, useSubRepCode, useAutoResize, useDynClkTime, useNewJobCard, useEdtStdTime, useViewGarSum, useMondStDay, useVehRegn, useInvPdf, useDBS, useApprIR, useMechGrid, useSortPL, useValStdTime, useEdtChgTime, useValMileage, useSavUpdDP, useIntNote, useGrpSPBO, useDispWOSpares)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "SaveGenSettings", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    Protected Sub gvZipCode_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Try
            gvZipCode.JSProperties("cpZipInsResult") = ""
            gvZipCode.JSProperties("cpZipUpdResult") = ""
            gvZipCode.JSProperties("cpZipDelResult") = {"", ""}
            Dim strResult As String = ""
            Dim pczipcodeId As String
            Dim pczipcodeIdxml As String
            Dim pczipcodeIdxmls As String = ""

            For Each item In e.InsertValues

                objZipCodesBO.ZipCode = item.NewValues("ZIPCODE")
                objZipCodesBO.Country = item.NewValues("COUNTRY")
                objZipCodesBO.State = item.NewValues("STATE")
                objZipCodesBO.City = item.NewValues("CITY")

                strResult = objConfigGenServ.SaveZipCodes(objZipCodesBO, "Add")
                gvZipCode.JSProperties("cpZipInsResult") = strResult
            Next

            For Each item In e.UpdateValues

                objZipCodesBO.ZipCode = item.NewValues("ZIPCODE")
                objZipCodesBO.Country = item.NewValues("COUNTRY")
                objZipCodesBO.State = item.NewValues("STATE")
                objZipCodesBO.City = item.NewValues("CITY")

                strResult = objConfigGenServ.SaveZipCodes(objZipCodesBO, "Edit")
                gvZipCode.JSProperties("cpZipUpdResult") = strResult
            Next

            For Each item In e.DeleteValues
                pczipcodeId = item.Keys(0)
                pczipcodeIdxml = "<CONFIG IDZIP= """"  ZIPCODE= """ + pczipcodeId + """/>"
                pczipcodeIdxmls += pczipcodeIdxml
            Next

            If e.DeleteValues.Count > 0 Then
                Dim strResults As String()
                pczipcodeIdxmls = "<ROOT>" + pczipcodeIdxmls + "</ROOT>"
                strResults = objConfigGenServ.DeleteZipCode(pczipcodeIdxmls)
                gvZipCode.JSProperties("cpZipDelResult") = strResults
            End If

            Dim dsGenSettings As DataSet = objConfigZipCodeDO.Fetch_AllZipCode()
            gvZipCode.DataSource = dsGenSettings.Tables(0)
            gvZipCode.DataBind()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "gvZipCode_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try


    End Sub

    Protected Sub gvDiscCode_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Try
            gvDiscCode.JSProperties("cpDCInsResult") = ""
            gvDiscCode.JSProperties("cpDCUpdResult") = ""
            gvDiscCode.JSProperties("cpDCDelResult") = {"", ""}
            Dim strXMLDocMas As String = ""
            Dim discCodeId As String = ""
            Dim discCodeDesc As String = ""
            Dim discCodeIdxml As String = ""
            Dim discCodeIdxmls As String = ""
            For Each item In e.InsertValues
                Dim desc As String = item.NewValues("DESCRIPTION")
                strXMLDocMas = ""
                strXMLDocMas = "<insert ID_CONFIG=""" + "DISCD" + """ DESCRIPTION=""" + desc.Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMas = "<root>" + strXMLDocMas + "</root>"
                configdetails = commonUtil.AddConfigDetails(strXMLDocMas)
                gvDiscCode.JSProperties("cpDCInsResult") = configdetails
            Next

            For Each item In e.UpdateValues
                Dim desc As String = item.NewValues("DESCRIPTION")
                Dim idsettings As String = item.Keys(0)
                strXMLDocMas = ""
                strXMLDocMas = "<MODIFY ID_CONFIG=""" + "DISCD" + """ ID_SETTINGS=""" + idsettings + """ DESCRIPTION=""" + desc.Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMas = "<ROOT>" + strXMLDocMas + "</ROOT>"
                configdetails = commonUtil.UpdateConfigDetails(strXMLDocMas)
                gvDiscCode.JSProperties("cpDCUpdResult") = configdetails
            Next

            For Each item In e.DeleteValues
                discCodeId = item.Keys(0)
                discCodeDesc = item.Values("DESCRIPTION")
                discCodeIdxml = "<delete><DISCD ID_SETTINGS= """ + discCodeId + """ ID_CONFIG= ""DISCD"" DESCRIPTION= """ + discCodeDesc + """/></delete>"
                discCodeIdxmls += discCodeIdxml
            Next

            If e.DeleteValues.Count > 0 Then
                Dim strResult As String()
                discCodeIdxmls = "<root>" + discCodeIdxmls + "</root>"
                strResult = commonUtil.DeleteConfig(discCodeIdxmls)
                gvDiscCode.JSProperties("cpDCDelResult") = strResult
            End If

            Dim dsConfGen As DataSet = objConfigSettingsDO.Fetch_TRConfiguration(HttpContext.Current.Session("UserID").ToString(), "DISCD", "VAT", "LEAVE_RESN", Nothing, Nothing)
            gvDiscCode.DataSource = dsConfGen.Tables(0)
            gvDiscCode.DataBind()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "gvDiscCode_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function Update_ZipCodes()
        Try
            Dim url As String = "http://www.bring.no/radgivning/sende-noe/adressetjenester/postnummer/_attachment/615728?_ts=14fd0e1cc58?_download=true"
            Dim dsZipCodes As DataSet = New DataSet
            Dim dtZipCodes As New DataTable("zip_codes")
            Dim zipCodes As New List(Of ZipCodesBO)
            Dim client As WebClient = New WebClient()
            Dim sr As StreamReader = New StreamReader(client.OpenRead(url), System.Text.Encoding.Default)
            Dim srRte As String = sr.ReadToEnd
            Dim zipCodesArray = srRte.Split(ControlChars.CrLf)
            Dim doZipCodes As New ZipCodesDO

            dtZipCodes.Columns.Add("zip_code") 'postnummer
            dtZipCodes.Columns.Add("zip_city") 'poststed
            dtZipCodes.Columns.Add("county_municipality") 'fylke/ kommune (kommunekode)
            dtZipCodes.Columns.Add("municipality_name") 'Kommunenavn
            dtZipCodes.Columns.Add("category") 'Kategori

            For Each item As String In zipCodesArray
                Dim items As String() = item.Split(ControlChars.Tab)
                If items.Length = 5 Then
                    Dim row As DataRow = dtZipCodes.NewRow()
                    row(0) = items(0).Replace(vbCr, "").Replace(vbLf, "")
                    row(1) = items(1)
                    row(2) = items(2)
                    row(3) = items(3)
                    row(4) = items(4)
                    dtZipCodes.Rows.Add(row)
                End If
            Next
            Dim retStr = doZipCodes.ImportZipCode(dtZipCodes)

            sr.Close()
            sr.Dispose()

            Return retStr.Split(",")
            dtZipCodes.Dispose()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "Update_ZipCodes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Function

    Public Shared Function GetJson(ByVal dt As DataTable) As String
        Try
            Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim rows As New List(Of Dictionary(Of String, Object))
            Dim row As Dictionary(Of String, Object)

            For Each dr As DataRow In dt.Rows
                row = New Dictionary(Of String, Object)
                For Each col As DataColumn In dt.Columns
                    row.Add(col.ColumnName, dr(col))
                Next
                rows.Add(row)
            Next
            Return serializer.Serialize(rows)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "GetJson", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Function
    Protected Sub gvReasonFrLv_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Try
            gvReasonFrLv.JSProperties("cpRLInsResult") = ""
            gvReasonFrLv.JSProperties("cpRLUpdResult") = ""
            gvReasonFrLv.JSProperties("cpRLDelResult") = {"", ""}
            Dim strXMLDocMas As String = ""
            Dim reasonId As String = ""
            Dim reasonDesc As String = ""
            Dim reasonIdxml As String = ""
            Dim reasonIdxmls As String = ""
            For Each item In e.InsertValues
                reasonDesc = item.NewValues("DESCRIPTION")
                strXMLDocMas = ""
                strXMLDocMas = "<insert ID_CONFIG=""" + "LEAVE_RESN" + """ DESCRIPTION=""" + reasonDesc.Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMas = "<root>" + strXMLDocMas + "</root>"
                configdetails = commonUtil.AddConfigDetails(strXMLDocMas)
                gvReasonFrLv.JSProperties("cpRLInsResult") = configdetails
            Next

            For Each item In e.UpdateValues
                reasonDesc = item.NewValues("DESCRIPTION")
                Dim idsettings As String = item.Keys(0)
                strXMLDocMas = ""
                strXMLDocMas = "<MODIFY ID_CONFIG=""" + "LEAVE_RESN" + """ ID_SETTINGS=""" + idsettings + """ DESCRIPTION=""" + reasonDesc.Trim.Replace("<", "&lt;").Replace(">", "&gt;") + """/>"
                strXMLDocMas = "<ROOT>" + strXMLDocMas + "</ROOT>"
                configdetails = commonUtil.UpdateConfigDetails(strXMLDocMas)
                gvReasonFrLv.JSProperties("cpRLUpdResult") = configdetails
            Next

            For Each item In e.DeleteValues
                reasonId = item.Keys(0)
                reasonDesc = item.Values("DESCRIPTION")
                reasonIdxml = "<delete><TR-COUT ID_SETTINGS= """ + reasonId + """ ID_CONFIG= ""LEAVE_RESN""  DESCRIPTION= """ + reasonDesc + """/></delete>'"
                reasonIdxmls += reasonIdxml
            Next

            If e.DeleteValues.Count > 0 Then
                Dim strResult As String()
                reasonIdxmls = "<root>" + reasonIdxmls + "</root>"
                strResult = commonUtil.DeleteConfig(reasonIdxmls)
                gvReasonFrLv.JSProperties("cpRLDelResult") = strResult
            End If

            Dim dsConfGen As DataSet = objConfigSettingsDO.Fetch_TRConfiguration(HttpContext.Current.Session("UserID").ToString(), "DISCD", "VAT", "LEAVE_RESN", Nothing, Nothing)
            gvReasonFrLv.DataSource = dsConfGen.Tables(2)
            gvReasonFrLv.DataBind()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "gvReasonFrLv_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub gvStationType_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Dim strXMLDocMas As String = ""
        Dim stationType As String = ""
        Dim statTypeIdxml As String = ""
        Dim statTypeIdxmls As String = ""

        Try
            For Each item In e.InsertValues
                stationType = item.NewValues("TYPE_STATION")
                strXMLDocMas = ""
                strXMLDocMas = "<insert TYPE_STATION=""" + stationType + """/>"
                strXMLDocMas = "<root>" + strXMLDocMas + "</root>"
                configdetails = objConfigGenServ.AddStationType(strXMLDocMas)
                gvStationType.JSProperties("cpSTInsResult") = configdetails
            Next

            For Each item In e.UpdateValues
                stationType = item.NewValues("TYPE_STATION")
                strXMLDocMas = "<MODIFY ID_STYPE=""" + item.Keys(0).ToString + """ TYPE_STATION=""" + stationType + """/>"
                strXMLDocMas = "<ROOT>" + strXMLDocMas + "</ROOT>"
                configdetails = objConfigGenServ.UpdateStationType(strXMLDocMas)
                gvStationType.JSProperties("cpSTUpdResult") = configdetails
            Next

            For Each item In e.DeleteValues
                stationType = item.Values("TYPE_STATION")
                statTypeIdxml = "<delete><ST-TYPE ID_STYPE= """ + item.Keys(0).ToString + """ TYPE_STATION= """ + stationType + """/></delete>"
                statTypeIdxmls += statTypeIdxml
            Next

            If e.DeleteValues.Count > 0 Then
                Dim strResult As String()
                statTypeIdxmls = "<root>" + statTypeIdxmls + "</root>"
                strResult = objConfigGenServ.DeleteStationType(statTypeIdxmls)
                gvStationType.JSProperties("cpSTDelResult") = strResult
            End If

            gvStationType.DataSource = objConfigSettingsDO.Fetch_StationType()
            gvStationType.DataBind()
            e.Handled = True

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmConfigGeneral", "gvStationType_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub gvDeptMess_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Try
            gvDeptMess.JSProperties("cpDMInsResult") = ""
            gvDeptMess.JSProperties("cpDMUpdResult") = ""
            gvDeptMess.JSProperties("cpDMDelResult") = ""

            Dim strXMLDocMess As String = ""
            Dim deptMessId As String = ""
            Dim deptMessIdxml As String = ""
            Dim deptMessIdxmls As String = ""

            Dim dtAllDept As DataTable = Session("dsDepartment").Tables(0)
            For Each item In e.InsertValues
                strXMLDocMess = ""
                strXMLDocMess = "<INSERT ID_DEPT=""" + item.NewValues("DPT_NAME") + """ COMMERCIAL_TEXT=""" + item.NewValues("COMMERCIAL_TEXT") + """ DETAIL_TEXT=""" + item.NewValues("DETAIL_TEXT") + """ CREATED_BY=""" + loginName + """/>"
                strXMLDocMess = "<ROOT>" + strXMLDocMess + "</ROOT>"
                'strXMLDocMess = objConfigGenServ.AddDeptMessage(strXMLDocMess, item.NewValues("DPT_NAME"), "")
                strXMLDocMess = objConfigSettingsDO.AddDeptMessage(strXMLDocMess)
                gvDeptMess.JSProperties("cpDMInsResult") = strXMLDocMess
            Next

            For Each item In e.UpdateValues
                Dim query = (From items In dtAllDept.AsEnumerable()
                             Where items.Field(Of String)("DPT_NAME") = item.NewValues("DPT_NAME")).ToArray()
                strXMLDocMess = ""
                If query.Length > 0 Then

                    strXMLDocMess = "<MODIFY ID_MESSAGES=""" + item.Keys(0).ToString + """ ID_DEPT=""" + query(0)("ID_DEPT").ToString + """ COMMERCIAL_TEXT=""" + item.NewValues("COMMERCIAL_TEXT") + """ DETAIL_TEXT=""" + item.NewValues("DETAIL_TEXT") + """ MODIFIED_BY=""" + loginName + """/>"
                Else
                    strXMLDocMess = "<MODIFY ID_MESSAGES=""" + item.Keys(0).ToString + """ ID_DEPT=""" + item.NewValues("DPT_NAME") + """ COMMERCIAL_TEXT=""" + item.NewValues("COMMERCIAL_TEXT") + """ DETAIL_TEXT=""" + item.NewValues("DETAIL_TEXT") + """ MODIFIED_BY=""" + loginName + """/>"
                End If
                strXMLDocMess = "<ROOT>" + strXMLDocMess + "</ROOT>"
                'strXMLDocMess = objConfigGenServ.UpdateDeptMessage(strXMLDocMess, item.NewValues("DPT_NAME"), item.Keys(0).ToString)
                strXMLDocMess = objConfigSettingsDO.UpdateDeptMessage(strXMLDocMess)
                gvDeptMess.JSProperties("cpDMUpdResult") = strXMLDocMess
            Next

            For Each item In e.DeleteValues
                deptMessId = item.Keys(0).ToString
                deptMessIdxml = "<DELETE><DELETE ID_MESSAGES= """ + deptMessId + """/></DELETE>"
                deptMessIdxmls += deptMessIdxml
            Next

            If e.DeleteValues.Count > 0 Then
                Dim strResult As String
                deptMessIdxmls = "<ROOT>" + deptMessIdxmls + "</ROOT>"
                strResult = objConfigGenServ.DeleteDeptMessage(deptMessIdxmls)
                gvDeptMess.JSProperties("cpDMDelResult") = strResult
            End If

            Dim dsConfGen As DataSet = objConfigSettingsDO.Fetch_TRConfiguration(HttpContext.Current.Session("UserID").ToString(), "DISCD", "VAT", "LEAVE_RESN", Nothing, Nothing)
            gvDeptMess.DataSource = dsConfGen.Tables(5)
            gvDeptMess.DataBind()
            e.Handled = True

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub gvDeptMess_CellEditorInitialize(sender As Object, e As DevExpress.Web.ASPxGridViewEditorEventArgs)

        If e.Column.FieldName = "DPT_NAME" Then
            If Session("dsDepartment") Is Nothing Then
                Session("dsDepartment") = objConfigSettingsDO.Fetch_AllDepartment()
            End If

            Dim combo As DevExpress.Web.ASPxComboBox = TryCast(e.Editor, DevExpress.Web.ASPxComboBox)
            Dim dt As DataTable = Session("dsDepartment").Tables(0)

            combo.ValueField = "ID_DEPT"
            combo.TextField = "DPT_NAME"
            combo.ValueType = GetType(String)
            combo.DataSource = dt
            combo.DataBindItems()
        End If

    End Sub

    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci

        End If
    End Sub
End Class