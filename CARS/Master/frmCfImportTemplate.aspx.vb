Imports System.Globalization
Imports System.Threading
Imports System.Web.Services
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS.CustomerExport
Imports DevExpress.Web

Public Class frmCfImportTemplate
    Inherits System.Web.UI.Page
    Shared objCustImpDO As New CustomerExportDO
    Shared objCustImpBO As New CustomerExportBO
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
                'ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute("~/frmLogin.aspx"))
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If
            BindCustImportGrid()
            BindCustBalImportGrid()
            GetCulture()
            BindImportConfigGrid()
            BindImportCondGrid()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    Private Sub BindCustImportGrid()
        Try
            objCustImpBO.FileType = "IMPORT"
            objCustImpBO.FileName = "CustomerImport.aspx"
            gvCustImport.DataSource = objCustImpDO.FetchFieldConfiguration(objCustImpBO)
            gvCustImport.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "BindCustImportGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    Private Sub BindCustBalImportGrid()
        Try
            objCustImpBO.FileType = "IMPORT"
            objCustImpBO.FileName = "CustomerBalanceImport.aspx"
            gvCustBalImport.DataSource = objCustImpDO.FetchFieldConfiguration(objCustImpBO)
            gvCustBalImport.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "BindInvJnlImportGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try

    End Sub
    Public Sub BindImportConfigGrid()
        Try

            Dim templateId = IIf(Session("ImportTemplateId") IsNot Nothing, Session("ImportTemplateId"), "0")

            If hdnCurrTabId.Value = "first" Then
                objCustImpBO.FileName = "CustomerImport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustImpBO.FileName = "CustomerBalanceImport.aspx"
            End If

            objCustImpBO.FileType = "IMPORT"
            objCustImpBO.TemplateId = templateId
            Dim dsImpCfGrid As DataSet = objCustImpDO.FetchConfigurationNew(objCustImpBO)
            Session("dsImpCfGrid") = dsImpCfGrid
            gvImportConfig.JSProperties("cpTotalRowCount") = dsImpCfGrid.Tables(1).Rows.Count
            gvImportConfig.JSProperties("cpTopElement") = dsImpCfGrid.Tables(1).Rows(0).Item("FIELD_NAME")
            gvImportConfig.DataSource = dsImpCfGrid.Tables(1)
            gvImportConfig.DataBind()

            'gvImportCond.DataSource = dsImpCfGrid.Tables(2)
            'gvImportCond.DataBind()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "BindImportConfigGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Public Sub BindImportCondGrid()
        Try

            Dim templateId = IIf(Session("ImportTemplateId") IsNot Nothing, Session("ImportTemplateId"), "0")

            If hdnCurrTabId.Value = "first" Then
                objCustImpBO.FileName = "CustomerImport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustImpBO.FileName = "CustomerBalanceImport.aspx"
            End If

            objCustImpBO.FileType = "IMPORT"
            objCustImpBO.TemplateId = templateId
            Dim dsImpCfGrid As DataSet = objCustImpDO.FetchConfigurationNew(objCustImpBO)
            Session("dsImpCfGrid") = dsImpCfGrid
            'gvImportConfig.JSProperties("cpTotalRowCount") = dsImpCfGrid.Tables(1).Rows.Count
            'gvImportConfig.JSProperties("cpTopElement") = dsImpCfGrid.Tables(1).Rows(0).Item("FIELD_NAME")
            'gvImportConfig.DataSource = dsImpCfGrid.Tables(1)
            'gvImportConfig.DataBind()

            gvImportCond.DataSource = dsImpCfGrid.Tables(2)
            gvImportCond.DataBind()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "BindImportCondGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
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
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "GetDefaultValue", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub
    Protected Sub cbImportConfigGrid_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim cbParam As String = e.Parameter
            Dim cbParams As String() = cbParam.Split(";")
            Session("ImportTemplateId") = cbParams(0)
            objCustImpBO.FileType = cbParams(1)
            objCustImpBO.FileName = cbParams(2)
            objCustImpBO.TemplateId = cbParams(0)
            Dim dsImpCfGrid As DataSet = objCustImpDO.FetchConfigurationNew(objCustImpBO)
            Session("dsImpCfGrid") = dsImpCfGrid
            gvImportConfig.DataSource = dsImpCfGrid.Tables(1)
            gvImportConfig.DataBind()
            gvImportCond.DataSource = dsImpCfGrid.Tables(2)
            gvImportCond.DataBind()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "cbImportConfigGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub
    <WebMethod()>
    Public Shared Function loadControls(ByVal fileType As String, ByVal fileName As String, ByVal templateId As String) As CustomerExportBO()
        Try
            HttpContext.Current.Session("ImportTemplateId") = templateId
            objCustImpBO.FileType = fileType
            objCustImpBO.FileName = fileName
            objCustImpBO.TemplateId = templateId
            details = objCusExpSvc.FetchExportConfigEdit(objCustImpBO)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "loadControls", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function loadCharSetControls(ByVal CharSet As String) As CustomerExportBO()
        Try
            objCustImpBO.CharacterSet = CharSet
            details = objCusExpSvc.SetCulturInfo(objCustImpBO)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "loadCharSetControls", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return details.ToList.ToArray()
    End Function
    Protected Sub cbCustImportGrid_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim strVal As String = ""
            Dim cbParam As String = e.Parameter
            Dim cbParams As String() = cbParam.Split(";")
            If cbParams.Length > 0 Then
                If cbParams(0) = "DEL" Then
                    objCustImpBO.FileType = "IMPORT"
                    objCustImpBO.FileName = "CustomerImport.aspx"
                    objCustImpBO.TemplateId = cbParams(1)
                    strVal = objCusExpSvc.DeleteConfiguration(objCustImpBO)
                    cbCustImportGrid.JSProperties("cpDelStrVal") = objCustImpBO.TemplateId + " " + strVal
                ElseIf cbParams(0) = "FETCH" Then
                    cbCustImportGrid.JSProperties("cpDelStrVal") = ""
                End If
            End If

            BindCustImportGrid()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "cbCustImportGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Protected Sub cbCustBalImportGrid_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim strVal As String = ""
            Dim cbParam As String = e.Parameter
            Dim cbParams As String() = cbParam.Split(";")
            If cbParams.Length > 0 Then
                If cbParams(0) = "DEL" Then
                    objCustImpBO.FileType = "IMPORT"
                    objCustImpBO.FileName = "CustomerBalanceImport.aspx"
                    objCustImpBO.TemplateId = cbParams(1)
                    strVal = objCusExpSvc.DeleteConfiguration(objCustImpBO)
                    cbCustBalImportGrid.JSProperties("cpDelStrVal") = objCustImpBO.TemplateId + " " + strVal
                ElseIf cbParams(0) = "FETCH" Then
                    cbCustBalImportGrid.JSProperties("cpDelStrVal") = ""
                End If
            End If

            BindCustBalImportGrid()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "cbCustBalImportGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Protected Sub cbSaveImportConfig_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)
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
            For i = 0 To gvImportConfig.VisibleRowCount - 1 Step 1
                Dim values As Object() = TryCast(gvImportConfig.GetRowValues(i, New String() {"FIELD_ID", "POSITION_FROM", "FIELD_LENGTH", "ORDER_IN_FILE", "DECIMAL_DIVIDE", "FIXED_VALUE", "ENCLOSING_CHAR"}), Object())
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



            objCustImpBO.FileType = "IMPORT"

            If hdnCurrTabId.Value = "first" Then
                objCustImpBO.FileName = "CustomerImport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustImpBO.FileName = "CustomerBalanceImport.aspx"
            End If

            If templateId = "0" Then
                objCustImpBO.TemplateId = Nothing
            Else

                objCustImpBO.TemplateId = templateId
            End If
            objCustImpBO.TemplateName = txtImportTypeName.Text
            objCustImpBO.CharacterSet = ddlCharSet.SelectedItem.Value
            objCustImpBO.DecimalDelimiter = ddlDecDelimiter.Value
            objCustImpBO.ThousandsDelimiter = ddlThousDelimiter.Value
            objCustImpBO.DateFormat = ddlDate.Value
            objCustImpBO.TimeFormat = ddlTime.Value
            If rbFixed.Checked Then
                objCustImpBO.FileMode = "FIXED"
            Else
                objCustImpBO.FileMode = "DELIMETER"
            End If

            objCustImpBO.DelimiterOther = txtOtherDelimiter.Text
            objCustImpBO.Description = txtDesc.Text
            objCustImpBO.Configuration = StrIntXMLs
            objCustImpBO.SpecialDelimiter = ddlSpDelimiter.Value
            objCustImpBO.UserId = loginName
            objCustImpBO.Condition = Session("xmlCondition")
            strRetVal = objCusExpSvc.SaveExportConfig(objCustImpBO)
            cbSaveImportConfig.JSProperties("cpReturnString") = strRetVal
            Session("newTemplateId") = strRetVal
            BindImportConfigGrid()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "cbSaveImportConfig_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub gvImportConfig_CellEditorInitialize(sender As Object, e As DevExpress.Web.ASPxGridViewEditorEventArgs)
        Try
            If rbDelimiter.Checked Then
                If e.Column.FieldName = "POSITION_FROM" Or e.Column.FieldName = "FIELD_LENGTH" Then
                    e.Editor.Enabled = False
                    e.Editor.BackColor = System.Drawing.Color.LightGray
                Else
                    e.Editor.Enabled = True
                End If
            ElseIf rbFixed.Checked Then
                If e.Column.FieldName = "ORDER_IN_FILE" Then
                    e.Editor.Enabled = False
                    e.Editor.BackColor = System.Drawing.Color.LightGray
                Else
                    e.Editor.Enabled = True
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "gvExportConfig_CellEditorInitialize", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub gvImportConfig_HtmlDataCellPrepared(sender As Object, e As DevExpress.Web.ASPxGridViewTableDataCellEventArgs)
        Try
            If rbDelimiter.Checked Then
                If e.DataColumn.FieldName = "POSITION_FROM" Or e.DataColumn.FieldName = "FIELD_LENGTH" Then
                    e.Cell.BackColor = System.Drawing.Color.LightGray
                End If
            ElseIf rbFixed.Checked Then
                If e.DataColumn.FieldName = "ORDER_IN_FILE" Then
                    e.Cell.BackColor = System.Drawing.Color.LightGray
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "gvExportConfig_HtmlDataCellPrepared", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub gvImportConfig_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
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
            For i = 0 To gvImportConfig.VisibleRowCount - 1 Step 1
                Dim values As Object() = TryCast(gvImportConfig.GetRowValues(i, New String() {"FIELD_ID", "POSITION_FROM", "FIELD_LENGTH", "ORDER_IN_FILE", "DECIMAL_DIVIDE", "FIXED_VALUE", "ENCLOSING_CHAR"}), Object())
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

            objCustImpBO.FileType = "IMPORT"

            If hdnCurrTabId.Value = "first" Then
                objCustImpBO.FileName = "CustomerImport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustImpBO.FileName = "CustomerBalanceImport.aspx"
            End If

            If templateId = "0" Then
                objCustImpBO.TemplateId = Nothing
            Else

                objCustImpBO.TemplateId = templateId
            End If
            objCustImpBO.TemplateName = txtImportTypeName.Text
            objCustImpBO.CharacterSet = ddlCharSet.SelectedItem.Value
            objCustImpBO.DecimalDelimiter = ddlDecDelimiter.Value
            objCustImpBO.ThousandsDelimiter = ddlThousDelimiter.Value
            objCustImpBO.DateFormat = ddlDate.Value
            objCustImpBO.TimeFormat = ddlTime.Value
            If rbFixed.Checked Then
                objCustImpBO.FileMode = "FIXED"
            Else
                objCustImpBO.FileMode = "DELIMETER"
            End If

            objCustImpBO.DelimiterOther = txtOtherDelimiter.Text
            objCustImpBO.Description = txtDesc.Text
            objCustImpBO.Configuration = StrIntXMLs
            objCustImpBO.SpecialDelimiter = ddlSpDelimiter.Value
            objCustImpBO.UserId = loginName
            objCustImpBO.Condition = IIf(Session("xmlCondition") IsNot Nothing, Session("xmlCondition"), Nothing)
            strRetVal = objCusExpSvc.SaveExportConfig(objCustImpBO)
            gvImportConfig.JSProperties("cpReturnString") = strRetVal
            Session("newTemplateId") = strRetVal
            BindImportConfigGrid()
            e.Handled = True

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "gvImportConfig_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub
    'Public Sub BindImportCondGrid()
    '    Try
    '        Dim templateId = IIf(Session("ImportTemplateId") IsNot Nothing, Session("ImportTemplateId"), "0")

    '        If hdnCurrTabId.Value = "first" Then
    '            objCustImpBO.FileName = "CustomerImport.aspx"
    '        ElseIf hdnCurrTabId.Value = "second" Then
    '            objCustImpBO.FileName = "CustomerBalanceImport.aspx"
    '        End If

    '        objCustImpBO.FileType = "IMPORT"
    '        objCustImpBO.TemplateId = templateId
    '        gvImportCond.DataSource = objCustImpDO.FetchConfiguration(objCustImpBO).Tables(2)
    '        gvImportCond.DataBind()

    '    Catch ex As Exception
    '        objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "BindImportCondGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
    '    End Try
    'End Sub

    Protected Sub gvImportCond_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        Dim strRetVal As String
        Dim StrIntXMLs As String = String.Empty
        Dim templateId As String = Session("newTemplateId")
        Dim fieldId As String = String.Empty
        Dim posFrom As String = String.Empty
        Dim fieldlength As String = String.Empty
        Dim ordInFile As String = String.Empty
        Dim conditionVal As String = String.Empty
        Dim fieldName As String = String.Empty
        For i = 0 To gvImportCond.VisibleRowCount - 1 Step 1
            Dim StrIntXML As String = String.Empty
            Dim values As Object() = TryCast(gvImportCond.GetRowValues(i, New String() {"FIELD_ID", "POSITION_FROM", "FIELD_LENGTH", "ORDER_IN_FILE", "CONDITION_VALUE", "FIELD_NAME"}), Object())
            If values IsNot Nothing Then
                fieldId = values(0).ToString
                posFrom = values(1).ToString
                fieldlength = values(2).ToString
                ordInFile = values(3).ToString
                conditionVal = values(4).ToString
                fieldName = values(5).ToString
            End If

            Dim queryUpdate As Array = (From item In e.UpdateValues
                                        Where item.NewValues("FIELD_NAME") = fieldName).ToArray()

            If queryUpdate.Length > 0 Then

                posFrom = IIf(queryUpdate(0).NewValues("POSITION_FROM") IsNot Nothing, queryUpdate(0).NewValues("POSITION_FROM"), "")
                fieldlength = IIf(queryUpdate(0).NewValues("FIELD_LENGTH") IsNot Nothing, queryUpdate(0).NewValues("FIELD_LENGTH"), "")
                ordInFile = IIf(queryUpdate(0).NewValues("ORDER_IN_FILE") IsNot Nothing, queryUpdate(0).NewValues("ORDER_IN_FILE"), "")
                conditionVal = IIf(queryUpdate(0).NewValues("CONDITION_VALUE") IsNot Nothing, queryUpdate(0).NewValues("CONDITION_VALUE"), "")

            End If

            Dim queryDelete As Array = (From item In e.DeleteValues
                                        Where item.Values("FIELD_NAME") = fieldName).ToArray()

            If queryDelete.Length > 0 Then
                Continue For
            End If


            StrIntXML = "<Condition TEMPLATE_ID= """ + templateId + """ FIELD_ID= """ + fieldId + """ POSITION_FROM= """ + posFrom +
        """ FIELD_LENGTH= """ + fieldlength + """ ORDER_IN_FILE= """ + ordInFile + """ CONDITION_VALUE=""" + conditionVal + """/>"
            StrIntXMLs += StrIntXML
        Next

        For Each item In e.InsertValues
            fieldId = IIf(item.NewValues("FIELD_NAME") IsNot Nothing, item.NewValues("FIELD_NAME"), "")
            If fieldId = "" Then
                Continue For
            End If
            posFrom = IIf(item.NewValues("POSITION_FROM") IsNot Nothing, item.NewValues("POSITION_FROM"), "")
            fieldlength = IIf(item.NewValues("FIELD_LENGTH") IsNot Nothing, item.NewValues("FIELD_LENGTH"), "")
            ordInFile = IIf(item.NewValues("ORDER_IN_FILE") IsNot Nothing, item.NewValues("ORDER_IN_FILE"), "")
            conditionVal = IIf(item.NewValues("CONDITION_VALUE") IsNot Nothing, item.NewValues("CONDITION_VALUE"), "")

            Dim StrIntXML As String = String.Empty
            StrIntXML = "<Condition TEMPLATE_ID= """ + templateId + """ FIELD_ID= """ + fieldId + """ POSITION_FROM= """ + posFrom +
            """ FIELD_LENGTH= """ + fieldlength + """ ORDER_IN_FILE= """ + ordInFile + """ CONDITION_VALUE=""" + conditionVal + """/>"

            StrIntXMLs += StrIntXML
        Next

        StrIntXMLs = "<ROOT>" + StrIntXMLs + "</ROOT>"
        Session("xmlCondition") = StrIntXMLs

        If templateId = "0" Then
            objCustImpBO.TemplateId = Nothing
        Else

            objCustImpBO.TemplateId = templateId
        End If
        objCustImpBO.TemplateName = txtImportTypeName.Text
        objCustImpBO.CharacterSet = ddlCharSet.SelectedItem.Value
        objCustImpBO.DecimalDelimiter = ddlDecDelimiter.Value
        objCustImpBO.ThousandsDelimiter = ddlThousDelimiter.Value
        objCustImpBO.DateFormat = ddlDate.Value
        objCustImpBO.TimeFormat = ddlTime.Value
        If rbFixed.Checked Then
            objCustImpBO.FileMode = "FIXED"
        Else
            objCustImpBO.FileMode = "DELIMETER"
        End If

        objCustImpBO.DelimiterOther = txtOtherDelimiter.Text
        objCustImpBO.Description = txtDesc.Text
        objCustImpBO.SpecialDelimiter = ddlSpDelimiter.Value
        objCustImpBO.UserId = loginName
        objCustImpBO.Condition = StrIntXMLs 'IIf(Session("xmlCondition") IsNot Nothing, Session("xmlCondition"), Nothing)
        strRetVal = objCusExpSvc.SaveExportCondition(objCustImpBO)
        'gvImportConfig.JSProperties("cpReturnString") = strRetVal
        BindImportCondGrid()

        e.Handled = True
    End Sub

    Protected Sub gvImportCond_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)
        Try
            If rbDelimiter.Checked Then
                If e.DataColumn.FieldName = "POSITION_FROM" Or e.DataColumn.FieldName = "FIELD_LENGTH" Then
                    e.Cell.BackColor = System.Drawing.Color.LightGray
                End If
            ElseIf rbFixed.Checked Then
                If e.DataColumn.FieldName = "ORDER_IN_FILE" Then
                    e.Cell.BackColor = System.Drawing.Color.LightGray
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "gvImportCond_HtmlDataCellPrepared", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub gvImportCond_CellEditorInitialize(sender As Object, e As ASPxGridViewEditorEventArgs)
        Try
            Dim templateId = IIf(Session("ImportTemplateId") IsNot Nothing, Session("ImportTemplateId"), "0")

            If hdnCurrTabId.Value = "first" Then
                objCustImpBO.FileName = "CustomerImport.aspx"
            ElseIf hdnCurrTabId.Value = "second" Then
                objCustImpBO.FileName = "CustomerBalanceImport.aspx"
            End If

            objCustImpBO.FileType = "IMPORT"
            objCustImpBO.TemplateId = templateId

            If e.Column.FieldName = "FIELD_NAME" Then
                If Session("dsImpCfGrid") IsNot Nothing Then
                    Dim combo As ASPxComboBox = TryCast(e.Editor, ASPxComboBox)
                    Dim dt As DataTable = Session("dsImpCfGrid").Tables(1)
                    combo.ValueField = "FIELD_ID"
                    combo.TextField = "FIELD_NAME"
                    combo.ValueType = GetType(String)
                    combo.DataSource = dt
                    combo.DataBindItems()
                    'combo.SelectedIndex = 1
                End If

            End If


            If rbDelimiter.Checked Then
                If e.Column.FieldName = "POSITION_FROM" Or e.Column.FieldName = "FIELD_LENGTH" Then
                    e.Editor.Enabled = False
                    e.Editor.BackColor = System.Drawing.Color.LightGray
                Else
                    e.Editor.Enabled = True
                End If
            ElseIf rbFixed.Checked Then
                If e.Column.FieldName = "ORDER_IN_FILE" Then
                    e.Editor.Enabled = False
                    e.Editor.BackColor = System.Drawing.Color.LightGray
                Else
                    e.Editor.Enabled = True
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "gvImportCond_CellEditorInitialize", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
    End Sub

    Protected Sub gvImportCond_InitNewRow(sender As Object, e As Data.ASPxDataInitNewRowEventArgs)
        'e.NewValues("FIELD_NAME") = "Cust Id"

    End Sub

    Protected Sub cbGetCondition_Callback(source As Object, e As CallbackEventArgs)
        Try
            Dim strRetVal As String
            Dim StrIntXMLs As String = String.Empty
            Dim templateId As String = hdnTemplateId.Value
            Dim fieldId As String = String.Empty
            Dim posFrom As String = String.Empty
            Dim fieldlength As String = String.Empty
            Dim ordInFile As String = String.Empty
            Dim conditionVal As String = String.Empty
            For i = 0 To gvImportCond.VisibleRowCount - 1 Step 1
                Dim StrIntXML As String = String.Empty
                Dim values As Object() = TryCast(gvImportCond.GetRowValues(i, New String() {"FIELD_ID", "POSITION_FROM", "FIELD_LENGTH", "ORDER_IN_FILE", "CONDITION_VALUE"}), Object())
                If values IsNot Nothing Then
                    fieldId = values(0).ToString
                    posFrom = values(1).ToString
                    fieldlength = values(2).ToString
                    ordInFile = values(3).ToString
                    conditionVal = values(4).ToString
                End If

                StrIntXML = "<Condition TEMPLATE_ID= """ + templateId + """ FIELD_ID= """ + fieldId + """ POSITION_FROM= """ + posFrom +
            """ FIELD_LENGTH= """ + fieldlength + """ ORDER_IN_FILE= """ + ordInFile + """ CONDITION_VALUE=""" + conditionVal + """/>"
                StrIntXMLs += StrIntXML
            Next

            StrIntXMLs = "<ROOT>" + StrIntXMLs + "</ROOT>"
            Session("xmlCondition") = StrIntXMLs

            If templateId = "0" Then
                objCustImpBO.TemplateId = Nothing
            Else

                objCustImpBO.TemplateId = templateId
            End If
            objCustImpBO.TemplateName = txtImportTypeName.Text
            objCustImpBO.CharacterSet = ddlCharSet.SelectedItem.Value
            objCustImpBO.DecimalDelimiter = ddlDecDelimiter.Value
            objCustImpBO.ThousandsDelimiter = ddlThousDelimiter.Value
            objCustImpBO.DateFormat = ddlDate.Value
            objCustImpBO.TimeFormat = ddlTime.Value
            If rbFixed.Checked Then
                objCustImpBO.FileMode = "FIXED"
            Else
                objCustImpBO.FileMode = "DELIMETER"
            End If

            objCustImpBO.DelimiterOther = txtOtherDelimiter.Text
            objCustImpBO.Description = txtDesc.Text
            objCustImpBO.SpecialDelimiter = ddlSpDelimiter.Value
            objCustImpBO.UserId = loginName
            objCustImpBO.Condition = StrIntXMLs 'IIf(Session("xmlCondition") IsNot Nothing, Session("xmlCondition"), Nothing)
            strRetVal = objCusExpSvc.SaveExportCondition(objCustImpBO)
            'gvImportConfig.JSProperties("cpReturnString") = strRetVal
            BindImportCondGrid()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmCfImportTemplate", "cbGetCondition_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, Session("UserID"))
        End Try
        'Session("xmlCondition") = ""

    End Sub

    Protected Sub gvImportCond_RowValidating(sender As Object, e As Data.ASPxDataValidationEventArgs)
        gvImportCond.JSProperties("cpHasErrors") = False
        gvImportCond.JSProperties("cpErrorMessage") = ""
        Dim fieldName As String = ""

        fieldName = e.NewValues("FIELD_NAME")

        For i = 0 To gvImportConfig.VisibleRowCount - 1 Step 1
            Dim rowvalues As Object() = TryCast(gvImportCond.GetRowValues(i, New String() {"FIELD_NAME", "FIELD_ID"}), Object())
            If rowvalues(1) IsNot Nothing Then
                If rowvalues(1).ToString = fieldName Then
                    e.RowError = "Cannot add duplicate field.'" + rowvalues(0) + "' is already configured."
                    gvImportCond.JSProperties("cpHasErrors") = True
                    gvImportCond.JSProperties("cpErrorMessage") = "Cannot add duplicate field.'" + rowvalues(0) + "' is already configured."
                End If
            End If
        Next

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