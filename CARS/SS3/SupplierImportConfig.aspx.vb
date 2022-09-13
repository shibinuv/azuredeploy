Imports CARS.CoreLibrary

Public Class SupplierImportConfig
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Private LoginName As String = ""
    Shared ddItemSelect As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            LoginName = CType(Session("UserID"), String)
        End If
        EnableViewState = False
        gvwSupplierConfig.SettingsCommandButton.EditButton.Text = GetLocalResourceObject("btnEdit")
        gvwSupplierConfig.SettingsCommandButton.DeleteButton.Text = GetLocalResourceObject("btnDelete")
        If Not IsPostBack Then
            ddlFieldName.Attributes.Add("onClick", "return CheckSupplier()")
            ddlFieldName.Items.Add(New ListItem(ddItemSelect, "0"))
        Else
            If (ddlSupplier.SelectedValue <> "0") Then
                GetGridData(ddlSupplier.SelectedValue)
            End If
        End If
    End Sub
    Protected Sub GetSupplier()
        Dim suppImport As New SupplierImportConfigBO()
        Dim SuppliersList As New DataTable()
        Try
            SuppliersList = suppImport.GetSuppliersList().Tables(0)
            ddlSupplier.Items.Clear()

            ddlSupplier.DataSource = SuppliersList
            ddlSupplier.DataValueField = "ID_SUPPLIER"
            ddlSupplier.DataTextField = "SUP_Name"
            ddlSupplier.DataBind()
            ddlSupplier.Items.Insert(0, New ListItem(ddItemSelect, "0"))
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_SupplierImportConfig", "GetSupplier", ex.Message, ex.ToString().Trim, Session("UserID"))
        Finally
            SuppliersList.Dispose()
        End Try
    End Sub

    Public Function GetExistingSupplier()
        Dim suppImport As New SupplierImportConfigBO()
        Dim SuppliersList As New DataTable()
        Try
            SuppliersList = suppImport.GetSuppliersList().Tables(1)
            ddlExistingSuppliers.Items.Clear()
            ddlExistingSuppliers.Items.Add(New ListItem(ddItemSelect, "0"))
            ddlExistingSuppliers.DataSource = SuppliersList
            ddlExistingSuppliers.DataValueField = "ID_SUPPLIER"
            ddlExistingSuppliers.DataTextField = "SUP_Name"
            ddlExistingSuppliers.DataBind()
            Return True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_SupplierImportConfig", "GetExistingSupplier", ex.Message, ex.ToString().Trim, Session("UserID"))
        Finally
            SuppliersList.Dispose()
        End Try
    End Function

    Protected Sub cbSupplerImportMain_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Dim suppImport As New SupplierImportConfigBO()
        Dim SuppliersImport As New DataSet()
        Dim drSettings As DataRow
        Try
            SuppliersImport = suppImport.GetDataForGrid(ddlSupplier.SelectedValue)
            ViewState("SuppliersImport") = SuppliersImport
            ddlFieldName.Items.Clear()

            ddlFieldName.DataSource = SuppliersImport.Tables(0)
            ddlFieldName.DataValueField = "FieldName"
            ddlFieldName.DataTextField = "FieldName"
            ddlFieldName.DataBind()
            ddlFieldName.Items.Insert(0, New ListItem(ddItemSelect, "0"))
            If SuppliersImport.Tables(1).Rows.Count > 0 Then
                rbFixed.Enabled = False
                rbDelimiter.Enabled = False
                ddlSpDelimiter.Enabled = False
                txtOtherDelimiter.Enabled = False
                'gvwSupplierConfig.DataSource = SuppliersImport.Tables(1)
                'gvwSupplierConfig.DataBind()
                
                
                drSettings = SuppliersImport.Tables(1).Rows(0)
                If (Not IsDBNull(drSettings("FILEMODE"))) Then
                    If drSettings("FILEMODE") = "Fixed" Then
                        rbFixed.Checked = True
                        rbDelimiter.Checked = False
                        txtStartsFrom.Enabled = True
                        txtEndsAt.Enabled = True
                        txtOrderFile.Enabled = False
                    Else
                        rbFixed.Checked = False
                        rbDelimiter.Checked = True
                        If (Not IsDBNull(drSettings("DELIMITER"))) Then
                            If drSettings("DELIMITER").ToString = "\t" Or drSettings("DELIMITER").ToString = ";" Or drSettings("DELIMITER").ToString = "," Or drSettings("DELIMITER").ToString = " " Then
                                ddlSpDelimiter.SelectedValue = drSettings("DELIMITER")
                                txtOtherDelimiter.Text = ""

                            Else
                                ddlSpDelimiter.SelectedValue = "Others"
                                txtOtherDelimiter.Text = drSettings("DELIMITER").ToString
                            End If
                        End If
                        txtStartsFrom.Enabled = False
                        txtEndsAt.Enabled = False
                        txtOrderFile.Enabled = True
                    End If
                Else
                    rbFixed.Checked = True
                    rbDelimiter.Checked = False
                    txtStartsFrom.Enabled = True
                    txtEndsAt.Enabled = True
                    txtOrderFile.Enabled = False
                End If

                If (Not IsDBNull(drSettings("SUPP_LAYOUT_NAME"))) Then
                    txtLayoutName.Text = drSettings("SUPP_LAYOUT_NAME").ToString()
                End If
                If (Not drSettings("REMOVE_START_ZERO")) Then
                    cbRemoveStartZeros.Checked = False
                Else
                    cbRemoveStartZeros.Checked = True
                End If
                If (Not drSettings("REMOVE_BLANK_FIELD")) Then
                    cbRemoveBlankFields.Checked = False
                Else
                    cbRemoveBlankFields.Checked = True
                End If
                If (Not drSettings("DIVIDE_PRICE_BY_HUNDRED")) Then
                    cbDividePriceByHundred.Checked = False
                Else
                    cbDividePriceByHundred.Checked = True
                End If
                If Not IsDBNull(drSettings("PRICE_FILE_DEC_SEP")) Then
                    ddlPriceFileDecSep.SelectedValue = drSettings("PRICE_FILE_DEC_SEP")
                Else
                    ddlPriceFileDecSep.SelectedValue = "."
                End If
            Else
               
                
                rbFixed.Checked = True
                rbDelimiter.Checked = False
                ddlSpDelimiter.SelectedValue = "Select"
                txtOrderFile.Enabled = False
                txtOrderFile.Text = ""
                rbFixed.Checked = True
                txtStartsFrom.Enabled = True
                txtEndsAt.Enabled = True
                cbRemoveStartZeros.Checked = False
                cbRemoveBlankFields.Checked = False
                cbDividePriceByHundred.Checked = False
                rbFixed.Enabled = True
                rbDelimiter.Enabled = True
                ddlSpDelimiter.Enabled = True
                txtOtherDelimiter.Enabled = True
                txtOtherDelimiter.Text = ""
                txtLayoutName.Text = ""
                ddlPriceFileDecSep.SelectedIndex = 0
                gvwSupplierConfig.DataSource = Nothing
                gvwSupplierConfig.DataBind()

            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_SupplierImportConfig", "ddlSupplier_SelectedIndexChanged", ex.Message, ex.ToString().Trim, Session("UserID"))
        Finally
            If Not (SuppliersImport Is Nothing) Then
                SuppliersImport.Dispose()
            End If
        End Try
    End Sub

    Protected Sub ddlFieldName_Init(sender As Object, e As EventArgs)
        ddItemSelect = GetLocalResourceObject("ddItemSelect").ToString()
        GetSupplier()
        GetExistingSupplier()
    End Sub

    Protected Sub cbSupplierConfig_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            If (e.Parameter.Count > 0) Then
                Dim paramText As String = e.Parameter.ToString
                Dim paramTexts() As String = paramText.Split(";")
                Dim supplierId As Integer = CInt(paramTexts(0))
                If (paramTexts(1) = "SAVE") Then
                    cbSupplierConfig.JSProperties("cpRefresh") = "SAVE"
                    Dim suppImport As New SupplierImportConfigBO()
                    Dim result As String = String.Empty
                    Dim suppliersImport As New DataSet()
                    suppImport.FieldName = paramTexts(2)
                    suppImport.SupplierId = supplierId
                    If txtStartsFrom.Text <> "" Then
                        suppImport.StartNumber = Integer.Parse(txtStartsFrom.Text.Trim())
                    End If
                    If txtEndsAt.Text <> "" Then
                        suppImport.EndNumber = Integer.Parse(txtEndsAt.Text.Trim())
                    End If
                    suppImport.CreateBy = CType(Session("UserID"), String)
                    If rbFixed.Checked Then
                        suppImport.FileMode = "Fixed"
                    Else
                        suppImport.FileMode = "Delimiter"
                    End If
                    If txtOrderFile.Text <> "" Then
                        suppImport.OrderOfFile = Integer.Parse(txtOrderFile.Text.Trim())
                    End If
                    If (rbDelimiter.Checked) Then
                        If Not ddlSpDelimiter.SelectedValue = "Select" Then

                            If Not ddlSpDelimiter.SelectedValue = "Others" Then

                                suppImport.Delimiter = ddlSpDelimiter.SelectedValue
                            Else
                                suppImport.Delimiter = txtOtherDelimiter.Text

                            End If
                        Else
                            suppImport.Delimiter = txtOtherDelimiter.Text
                        End If

                    End If
                    suppImport.LayoutName = txtLayoutName.Text.Trim()
                    suppImport.RemoveStartZero = cbRemoveStartZeros.Checked
                    suppImport.RemoveBlankField = cbRemoveBlankFields.Checked
                    suppImport.DividePriceByHundred = cbDividePriceByHundred.Checked
                    suppImport.PriceFileDecimalSeperator = ddlPriceFileDecSep.SelectedValue
                    result = suppImport.SaveConfig()
                Else
                    cbSupplierConfig.JSProperties("cpRefresh") = "FETCH"
                End If
                GetGridData(supplierId)
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_SupplierImportConfig", "cbSupplierConfig_Callback", ex.Message, ex.ToString().Trim, Session("UserID"))
        End Try

    End Sub

    Private Sub GetGridData(supplierID As Integer)
        Dim suppImport As New SupplierImportConfigBO()
        Dim SuppliersImport As New DataSet()
        SuppliersImport = suppImport.GetDataForGrid(supplierId)
            ViewState("SuppliersImport") = SuppliersImport
            If SuppliersImport.Tables(1).Rows.Count > 0 Then
                gvwSupplierConfig.DataSource = SuppliersImport.Tables(1)
                gvwSupplierConfig.DataBind()
            Else
                gvwSupplierConfig.DataSource = Nothing
                gvwSupplierConfig.DataBind()
            End If
    End Sub
    Protected Sub gvwSupplierConfig_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Try
            Dim suppImport As New SupplierImportConfigBO()
            Dim result As String = String.Empty
            For Each item In e.UpdateValues
                
                Dim idSuppImport As Integer = item.Keys(0)
                Dim startNum As Integer = item.NewValues("START_NUM")
                Dim endNum As Integer = item.NewValues("END_NUM")
                Dim orderOfFile As Integer = item.NewValues("END_NUM")
                suppImport.SupplierImportId = idSuppImport
                suppImport.StartNumber = startNum
                suppImport.EndNumber = endNum
                suppImport.OrderOfFile = item.NewValues("ORDER_OF_FILE")
                suppImport.ModifyBy = CType(Session("UserID"), String)
                result = suppImport.ModifyConfig

            Next
            For Each item In e.DeleteValues
                suppImport.SupplierImportId = item.Keys(0)
                result = suppImport.DeleteConfig()
            Next
            e.Handled = True
            GetGridData(ddlSupplier.SelectedValue)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "SS3_SupplierImportConfig", "gvwSupplierConfig_BatchUpdate", ex.Message, ex.ToString().Trim, Session("UserID"))
        End Try
    End Sub
    Protected Sub cbExistingSupplier_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        GetExistingSupplier()
    End Sub
End Class