Imports System.Globalization
Imports System.Threading
Imports System.Web.Services
Imports CARS.CoreLibrary
Imports DevExpress.Web

Public Class frmCfExportTemplate
    Inherits System.Web.UI.Page
    Shared objCommonUtil As New CoreLibrary.CARS.Utilities.CommonUtility
    Shared objCustExpDO As New CoreLibrary.CARS.CustomerExport.CustomerExportDO
    Shared objCustExpBO As New CustomerExportBO
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared objCusExpSvc As New CoreLibrary.CARS.Services.CustomerExport.CustomerExport
    Shared details As New List(Of CustomerExportBO)()
    Dim strText As String
    Dim strValue As String
    Shared loginName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            EnableViewState = False
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If
            BindCustExportGrid()
            BindInvJnlExportGrid()
            BindExportConfigGrid()
            GetCulture()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    Private Sub BindCustExportGrid()
        Try
            objCustExpBO.FileType = "EXPORT"
            objCustExpBO.FileName = "CustomerExport.aspx"
            gvCustExport.DataSource = objCustExpDO.FetchFieldConfiguration(objCustExpBO)
            gvCustExport.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "BindCustExportGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    Private Sub BindInvJnlExportGrid()
        Try
            objCustExpBO.FileType = "EXPORT"
            objCustExpBO.FileName = "InvoiceJournalExport.aspx"
            gvInvJournalExport.DataSource = objCustExpDO.FetchFieldConfiguration(objCustExpBO)
            gvInvJournalExport.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "BindInvJnlExportGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    Private Sub GetCulture()
        Dim ci As CultureInfo() = CultureInfo.GetCultures(CultureTypes.SpecificCultures)
        For i As Integer = 0 To ci.Length - 1
            'Default value for Char Set
            strText = ci(i).EnglishName
            strValue = ci(i).Name
            GetDefaultValue(ddlCharSet, strText, strValue, CultureInfo.CurrentCulture.ToString())
        Next
        SetCultureInfo()
    End Sub
    Private Sub SetCultureInfo()
        Dim info As CultureInfo = New CultureInfo(ddlCharSet.Value.ToString())

        'Default Value for Decimal Delimiter
        strText = info.NumberFormat.CurrencyDecimalSeparator
        ddlDecDelimiter.Items.Clear()
        ddlDecDelimiter.Items.Add(New ListEditItem(strText, strText))
        'Default Value for Thousand Delimiter
        strText = info.NumberFormat.CurrencyGroupSeparator
        ddlThousDelimiter.Items.Clear()
        ddlThousDelimiter.Items.Add(New ListEditItem(strText, strText))

        'Default Value for Date
        strText = info.DateTimeFormat.ShortDatePattern
        ddlDate.Items.Clear()
        ddlDate.Items.Add(New ListEditItem(strText, strText))


        'Default Value for Time
        strText = info.DateTimeFormat.ShortTimePattern
        ddlTime.Items.Clear()
        ddlTime.Items.Add(New ListEditItem(strText, strText))

    End Sub
    Private Sub GetDefaultValue(ByVal ddl As ASPxComboBox, ByVal Text As String, ByVal Value As String, ByVal IndexValue As String)
        Try
            If Not (ddl.Items.Contains(ddl.Items.FindByText(Text))) Then
                ddl.Items.Add(New ListEditItem(Text, Value))
            End If
            ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(IndexValue))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "GetDefaultValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    <WebMethod()>
    Public Shared Function loadCharSetControls(ByVal CharSet As String) As CustomerExportBO()
        Try
            objCustExpBO.CharacterSet = CharSet
            details = objCusExpSvc.SetCulturInfo(objCustExpBO)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "loadCharSetControls", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return details.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function loadControls(ByVal fileType As String, ByVal fileName As String, ByVal templateId As String) As CustomerExportBO()
        Try
            HttpContext.Current.Session("ExportTemplateId") = templateId
            objCustExpBO.FileType = fileType
            objCustExpBO.FileName = fileName
            objCustExpBO.TemplateId = templateId
            details = objCusExpSvc.FetchExportConfigEdit(objCustExpBO)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "loadControls", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return details.ToList.ToArray()
    End Function

    Protected Sub cbExportConfigGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim cbParam As String = e.Parameter
            Dim cbParams As String() = cbParam.Split(";")
            Session("ExportTemplateId") = cbParams(0)
            objCustExpBO.FileType = cbParams(1)
            objCustExpBO.FileName = cbParams(2)
            objCustExpBO.TemplateId = cbParams(0)
            gvExportConfig.DataSource = objCustExpDO.FetchConfiguration(objCustExpBO).Tables(1)
            gvExportConfig.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "cbExportConfigGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub

    Public Sub BindExportConfigGrid()
        Try
            Dim templateId = IIf(Session("ExportTemplateId") IsNot Nothing, Session("ExportTemplateId"), "0")

            If hdnCurrTabId.Value = "first" Then
                objCustExpBO.FileName = "CustomerExport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustExpBO.FileName = "InvoiceJournalExport.aspx"
            End If

            objCustExpBO.FileType = "EXPORT"
            objCustExpBO.TemplateId = templateId
            gvExportConfig.DataSource = objCustExpDO.FetchConfiguration(objCustExpBO).Tables(1)
            gvExportConfig.DataBind()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "BindExportConfigGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub

    Protected Sub gvExportConfig_CellEditorInitialize(sender As Object, e As ASPxGridViewEditorEventArgs)
        Try
            If rbDelimiter.Checked Then
                If e.Column.FieldName = "POSITION_FROM" Or e.Column.FieldName = "FIELD_LENGTH" Then
                    e.Editor.Enabled = False
                    e.Editor.BackColor = System.Drawing.Color.LightGray
                Else
                    e.Editor.Enabled = True
                    'e.Editor.BackColor = System.Drawing.Color.White
                End If
            ElseIf rbFixed.Checked Then
                If e.Column.FieldName = "ORDER_IN_FILE" Or e.Column.FieldName = "ENCLOSING_CHAR" Then
                    e.Editor.Enabled = False
                    e.Editor.BackColor = System.Drawing.Color.LightGray
                Else
                    e.Editor.Enabled = True
                    'e.Editor.BackColor = System.Drawing.Color.White
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "gvExportConfig_CellEditorInitialize", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub

    Protected Sub gvExportConfig_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)
        Try
            If rbDelimiter.Checked Then
                If e.DataColumn.FieldName = "POSITION_FROM" Or e.DataColumn.FieldName = "FIELD_LENGTH" Then
                    e.Cell.BackColor = System.Drawing.Color.LightGray
                Else
                    'e.Cell.BackColor = System.Drawing.Color.White
                End If
            ElseIf rbFixed.Checked Then
                If e.DataColumn.FieldName = "ORDER_IN_FILE" Or e.DataColumn.FieldName = "ENCLOSING_CHAR" Then
                    e.Cell.BackColor = System.Drawing.Color.LightGray
                Else
                    'e.Cell.BackColor = System.Drawing.Color.White
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "gvExportConfig_HtmlDataCellPrepared", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub

    Protected Sub gvExportConfig_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Try
            Dim StrIntXMLs As String = String.Empty
            Dim templateId As String = hdnTemplateId.Value
            Dim fieldId As String = String.Empty
            Dim posFrom As String = String.Empty
            Dim fieldlength As String = String.Empty
            Dim ordInFile As String = String.Empty
            Dim decimalDivide As String = String.Empty
            Dim fxdInfo As String = String.Empty
            Dim encChar As String = String.Empty
            Dim StrIntXML As String = String.Empty
            Dim i As Integer
            Dim fileMode As String = String.Empty
            Dim strRetVal As String
            For i = 0 To gvExportConfig.VisibleRowCount - 1 Step 1
                Dim values As Object() = TryCast(gvExportConfig.GetRowValues(i, New String() {"FIELD_ID", "POSITION_FROM", "FIELD_LENGTH", "ORDER_IN_FILE", "DECIMAL_DIVIDE", "FIXED_VALUE", "ENCLOSING_CHAR"}), Object())
                fieldId = values(0).ToString
                posFrom = values(1).ToString
                fieldlength = values(2).ToString
                ordInFile = values(3).ToString
                decimalDivide = values(4).ToString
                fxdInfo = values(5).ToString
                encChar = values(6).ToString
                Dim query As Array = (From item In e.UpdateValues
                                      Where item.Keys(0).ToString = fieldId).ToArray()

                If query.Length > 0 Then

                    posFrom = IIf(query(0).NewValues("POSITION_FROM") IsNot Nothing, query(0).NewValues("POSITION_FROM"), "")
                    fieldlength = IIf(query(0).NewValues("FIELD_LENGTH") IsNot Nothing, query(0).NewValues("FIELD_LENGTH"), "")
                    ordInFile = IIf(query(0).NewValues("ORDER_IN_FILE") IsNot Nothing, query(0).NewValues("ORDER_IN_FILE"), "")
                    decimalDivide = IIf(query(0).NewValues("DECIMAL_DIVIDE") IsNot Nothing, query(0).NewValues("DECIMAL_DIVIDE"), "")
                    fxdInfo = IIf(query(0).NewValues("FIXED_VALUE") IsNot Nothing, query(0).NewValues("FIXED_VALUE"), "")
                    encChar = IIf(query(0).NewValues("ENCLOSING_CHAR") IsNot Nothing, query(0).NewValues("ENCLOSING_CHAR"), "")

                End If

                StrIntXML = "<Configuration TEMPLATE_ID= """ + templateId + """ FIELD_ID= """ + fieldId + """ POSITION_FROM= """ + posFrom +
            """ FIELD_LENGTH= """ + fieldlength + """ ORDER_IN_FILE= """ + ordInFile + """ DECIMAL_DIVIDE= """ + decimalDivide + """ FIXED_VALUE= """ +
            fxdInfo + """ FIELD_ENCLOSING_CH= """ + encChar + """/>"
                StrIntXMLs += StrIntXML
            Next

            StrIntXMLs = "<ROOT>" + StrIntXMLs + "</ROOT>"



            objCustExpBO.FileType = "EXPORT"

            If hdnCurrTabId.Value = "first" Then
                objCustExpBO.FileName = "CustomerExport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustExpBO.FileName = "InvoiceJournalExport.aspx"
            End If

            If templateId = "0" Then
                objCustExpBO.TemplateId = Nothing
            Else

                objCustExpBO.TemplateId = templateId
            End If
            objCustExpBO.TemplateName = txtExportTypeName.Text
            objCustExpBO.CharacterSet = ddlCharSet.SelectedItem.Value
            objCustExpBO.DecimalDelimiter = ddlDecDelimiter.Value
            objCustExpBO.ThousandsDelimiter = ddlThousDelimiter.Value
            objCustExpBO.DateFormat = ddlDate.Value
            objCustExpBO.TimeFormat = ddlTime.Value
            If rbFixed.Checked Then
                objCustExpBO.FileMode = "FIXED"
            Else
                objCustExpBO.FileMode = "DELIMETER"
            End If

            objCustExpBO.DelimiterOther = txtOtherDelimiter.Text
            objCustExpBO.Description = txtDesc.Text
            objCustExpBO.Configuration = StrIntXMLs
            objCustExpBO.SpecialDelimiter = ddlSpDelimiter.Value
            objCustExpBO.UserId = loginName
            strRetVal = objCusExpSvc.SaveExportConfigEdit(objCustExpBO)
            gvExportConfig.JSProperties("cpReturnString") = strRetVal
            BindExportConfigGrid()
            e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "gvExportConfig_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub

    Protected Sub cbCustExportGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Dim strVal As String = ""
        Dim cbParam As String = e.Parameter
        Dim cbParams As String() = cbParam.Split(";")
        If cbParams.Length > 0 Then
            If cbParams(0) = "DEL" Then
                objCustExpBO.FileType = "EXPORT"
                objCustExpBO.FileName = "CustomerExport.aspx"
                objCustExpBO.TemplateId = cbParams(1)
                strVal = objCusExpSvc.DeleteConfiguration(objCustExpBO)
                cbCustExportGrid.JSProperties("cpDelStrVal") = objCustExpBO.TemplateId + " " + strVal
            ElseIf cbParams(0) = "FETCH" Then
                cbCustExportGrid.JSProperties("cpDelStrVal") = ""
            End If
        End If

        BindCustExportGrid()
    End Sub

    Protected Sub cbSaveExportConfig_Callback(source As Object, e As CallbackEventArgs)
        Try
            Dim StrIntXMLs As String = String.Empty
            Dim templateId As String = hdnTemplateId.Value
            Dim fieldId As String = String.Empty
            Dim posFrom As String = String.Empty
            Dim fieldlength As String = String.Empty
            Dim ordInFile As String = String.Empty
            Dim decimalDivide As String = String.Empty
            Dim fxdInfo As String = String.Empty
            Dim encChar As String = String.Empty
            Dim StrIntXML As String = String.Empty
            Dim i As Integer
            Dim fileMode As String = String.Empty
            Dim strRetVal As String
            For i = 0 To gvExportConfig.VisibleRowCount - 1 Step 1
                Dim values As Object() = TryCast(gvExportConfig.GetRowValues(i, New String() {"FIELD_ID", "POSITION_FROM", "FIELD_LENGTH", "ORDER_IN_FILE", "DECIMAL_DIVIDE", "FIXED_VALUE", "ENCLOSING_CHAR"}), Object())
                fieldId = values(0).ToString
                posFrom = values(1).ToString
                fieldlength = values(2).ToString
                ordInFile = values(3).ToString
                decimalDivide = values(4).ToString
                fxdInfo = values(5).ToString
                encChar = values(6).ToString

                StrIntXML = "<Configuration TEMPLATE_ID= """ + templateId + """ FIELD_ID= """ + fieldId + """ POSITION_FROM= """ + posFrom +
            """ FIELD_LENGTH= """ + fieldlength + """ ORDER_IN_FILE= """ + ordInFile + """ DECIMAL_DIVIDE= """ + decimalDivide + """ FIXED_VALUE= """ +
            fxdInfo + """ FIELD_ENCLOSING_CH= """ + encChar + """/>"
                StrIntXMLs += StrIntXML
            Next

            StrIntXMLs = "<ROOT>" + StrIntXMLs + "</ROOT>"



            objCustExpBO.FileType = "EXPORT"

            If hdnCurrTabId.Value = "first" Then
                objCustExpBO.FileName = "CustomerExport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustExpBO.FileName = "InvoiceJournalExport.aspx"
            End If

            If templateId = "0" Then
                objCustExpBO.TemplateId = Nothing
            Else

                objCustExpBO.TemplateId = templateId
            End If
            objCustExpBO.TemplateName = txtExportTypeName.Text
            objCustExpBO.CharacterSet = ddlCharSet.SelectedItem.Value
            objCustExpBO.DecimalDelimiter = ddlDecDelimiter.Value
            objCustExpBO.ThousandsDelimiter = ddlThousDelimiter.Value
            objCustExpBO.DateFormat = ddlDate.Value
            objCustExpBO.TimeFormat = ddlTime.Value
            If rbFixed.Checked Then
                objCustExpBO.FileMode = "FIXED"
            Else
                objCustExpBO.FileMode = "DELIMETER"
            End If

            objCustExpBO.DelimiterOther = txtOtherDelimiter.Text
            objCustExpBO.Description = txtDesc.Text
            objCustExpBO.Configuration = StrIntXMLs
            objCustExpBO.SpecialDelimiter = ddlSpDelimiter.Value
            objCustExpBO.UserId = loginName
            strRetVal = objCusExpSvc.SaveExportConfigEdit(objCustExpBO)
            cbSaveExportConfig.JSProperties("cpReturnString") = strRetVal
            BindExportConfigGrid()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfExportTemplate", "cbSaveExportConfig_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub cbInvJournalExportGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Dim strVal As String = ""
        Dim cbParam As String = e.Parameter
        Dim cbParams As String() = cbParam.Split(";")
        If cbParams.Length > 0 Then
            If cbParams(0) = "DEL" Then
                objCustExpBO.FileType = "EXPORT"
                objCustExpBO.FileName = "InvoiceJournalExport.aspx"
                objCustExpBO.TemplateId = cbParams(1)
                strVal = objCusExpSvc.DeleteConfiguration(objCustExpBO)
                cbInvJournalExportGrid.JSProperties("cpDelStrVal") = objCustExpBO.TemplateId + " " + strVal
            ElseIf cbParams(0) = "FETCH" Then
                cbInvJournalExportGrid.JSProperties("cpDelStrVal") = ""
            End If
        End If

        BindInvJnlExportGrid()
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