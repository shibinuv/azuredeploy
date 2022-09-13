<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Public Class dxJobCard
    Inherits DevExpress.XtraReports.UI.XtraReport

    'XtraReport overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Designer
    'It can be modified using the Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim StoredProcQuery1 As DevExpress.DataAccess.Sql.StoredProcQuery = New DevExpress.DataAccess.Sql.StoredProcQuery()
        Dim QueryParameter1 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter2 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim StoredProcQuery2 As DevExpress.DataAccess.Sql.StoredProcQuery = New DevExpress.DataAccess.Sql.StoredProcQuery()
        Dim QueryParameter3 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(dxJobCard))
        Me.Detail = New DevExpress.XtraReports.UI.DetailBand()
        Me.XrLabel6 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel3 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel2 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel1 = New DevExpress.XtraReports.UI.XRLabel()
        Me.TopMargin = New DevExpress.XtraReports.UI.TopMarginBand()
        Me.XrPictureBox1 = New DevExpress.XtraReports.UI.XRPictureBox()
        Me.XrLabel19 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel18 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrPageInfo1 = New DevExpress.XtraReports.UI.XRPageInfo()
        Me.BottomMargin = New DevExpress.XtraReports.UI.BottomMarginBand()
        Me.GroupHeader2 = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.customerTable = New DevExpress.XtraReports.UI.XRTable()
        Me.customerNameRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell1 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerName = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerContactNameRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell2 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerTableCell1 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerContactName = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerAddressRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell3 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerTableCell2 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerAddress = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell7 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerCityRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell4 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerTableCell3 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerCity = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerCountryRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell5 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerTableCell4 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.customerCountry = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorTable = New DevExpress.XtraReports.UI.XRTable()
        Me.vendorNameRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell8 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorName = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorContactNameRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell9 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorContactName = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrLabel4 = New DevExpress.XtraReports.UI.XRLabel()
        Me.vendorAddressRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell10 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorAddress = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorCityRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell11 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorCity = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorCountryRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell12 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorCountry = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorWebsiteRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell13 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorWebsite = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorEmailRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell14 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorEmail = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorPhoneRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell15 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.vendorPhone = New DevExpress.XtraReports.UI.XRTableCell()
        Me.SubBand1 = New DevExpress.XtraReports.UI.SubBand()
        Me.xrLine1 = New DevExpress.XtraReports.UI.XRLine()
        Me.invoiceNumberTable = New DevExpress.XtraReports.UI.XRTable()
        Me.invoiceNumberRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.invoiceLabel = New DevExpress.XtraReports.UI.XRTableCell()
        Me.invoiceNumber = New DevExpress.XtraReports.UI.XRTableCell()
        Me.invoiceDatesTable = New DevExpress.XtraReports.UI.XRTable()
        Me.invoiceDateRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.invoiceDateCaption = New DevExpress.XtraReports.UI.XRTableCell()
        Me.invoiceDate = New DevExpress.XtraReports.UI.XRTableCell()
        Me.invoiceDueDateRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.invoiceDueDateCaption = New DevExpress.XtraReports.UI.XRTableCell()
        Me.invoiceDueDate = New DevExpress.XtraReports.UI.XRTableCell()
        Me.GroupFooter1 = New DevExpress.XtraReports.UI.GroupFooterBand()
        Me.GroupHeader1 = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.xrLine2 = New DevExpress.XtraReports.UI.XRLine()
        Me.headerTable = New DevExpress.XtraReports.UI.XRTable()
        Me.headerTableRow = New DevExpress.XtraReports.UI.XRTableRow()
        Me.quantityCaption = New DevExpress.XtraReports.UI.XRTableCell()
        Me.productNameCaption = New DevExpress.XtraReports.UI.XRTableCell()
        Me.unitPriceCaption = New DevExpress.XtraReports.UI.XRTableCell()
        Me.lineTotalCaption = New DevExpress.XtraReports.UI.XRTableCell()
        Me.SqlDataSource1 = New DevExpress.DataAccess.Sql.SqlDataSource(Me.components)
        Me.baseControlStyle = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.pIV_WO_NO = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pLanguage = New DevExpress.XtraReports.Parameters.Parameter()
        Me.GroupHeader3 = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.XrLabel8 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel9 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel7 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel5 = New DevExpress.XtraReports.UI.XRLabel()
        Me.ReportFooter = New DevExpress.XtraReports.UI.ReportFooterBand()
        Me.XrLine10 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine9 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine8 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine7 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine6 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine5 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine4 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine3 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLabel15 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel16 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel14 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel17 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel13 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel12 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel11 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel10 = New DevExpress.XtraReports.UI.XRLabel()
        CType(Me.customerTable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.vendorTable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.invoiceNumberTable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.invoiceDatesTable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.headerTable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me, System.ComponentModel.ISupportInitialize).BeginInit()
        '
        'Detail
        '
        Me.Detail.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel6, Me.XrLabel3, Me.XrLabel2, Me.XrLabel1})
        Me.Detail.HeightF = 28.08329!
        Me.Detail.KeepTogether = True
        Me.Detail.Name = "Detail"
        Me.Detail.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100.0!)
        Me.Detail.StyleName = "baseControlStyle"
        Me.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrLabel6
        '
        Me.XrLabel6.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[JOBI_DELIVER_QTY]")})
        Me.XrLabel6.LocationFloat = New DevExpress.Utils.PointFloat(554.0133!, 0!)
        Me.XrLabel6.Multiline = True
        Me.XrLabel6.Name = "XrLabel6"
        Me.XrLabel6.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel6.SizeF = New System.Drawing.SizeF(71.98657!, 23.0!)
        Me.XrLabel6.Text = "XrLabel6"
        Me.XrLabel6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLabel3
        '
        Me.XrLabel3.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ID_ITEM_JOB]")})
        Me.XrLabel3.LocationFloat = New DevExpress.Utils.PointFloat(10.00001!, 0!)
        Me.XrLabel3.Multiline = True
        Me.XrLabel3.Name = "XrLabel3"
        Me.XrLabel3.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel3.SizeF = New System.Drawing.SizeF(143.083!, 23.0!)
        Me.XrLabel3.Text = "XrLabel3"
        '
        'XrLabel2
        '
        Me.XrLabel2.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ITEM_DESC]")})
        Me.XrLabel2.LocationFloat = New DevExpress.Utils.PointFloat(153.083!, 0!)
        Me.XrLabel2.Multiline = True
        Me.XrLabel2.Name = "XrLabel2"
        Me.XrLabel2.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel2.SizeF = New System.Drawing.SizeF(315.0771!, 23.0!)
        Me.XrLabel2.Text = "XrLabel2"
        '
        'XrLabel1
        '
        Me.XrLabel1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[JOBI_ORDER_QTY]")})
        Me.XrLabel1.LocationFloat = New DevExpress.Utils.PointFloat(468.1601!, 0!)
        Me.XrLabel1.Multiline = True
        Me.XrLabel1.Name = "XrLabel1"
        Me.XrLabel1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel1.SizeF = New System.Drawing.SizeF(85.85333!, 23.0!)
        Me.XrLabel1.Text = "XrLabel1"
        Me.XrLabel1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'TopMargin
        '
        Me.TopMargin.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrPictureBox1, Me.XrLabel19, Me.XrLabel18, Me.XrPageInfo1})
        Me.TopMargin.HeightF = 129.1667!
        Me.TopMargin.Name = "TopMargin"
        Me.TopMargin.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100.0!)
        Me.TopMargin.StylePriority.UseBackColor = False
        Me.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrPictureBox1
        '
        Me.XrPictureBox1.ImageUrl = "Images\cars.png"
        Me.XrPictureBox1.LocationFloat = New DevExpress.Utils.PointFloat(153.1248!, 19.16668!)
        Me.XrPictureBox1.Name = "XrPictureBox1"
        Me.XrPictureBox1.SizeF = New System.Drawing.SizeF(100.0!, 100.0!)
        Me.XrPictureBox1.Sizing = DevExpress.XtraPrinting.ImageSizeMode.ZoomImage
        '
        'XrLabel19
        '
        Me.XrLabel19.Font = New System.Drawing.Font("Arial", 20.0!)
        Me.XrLabel19.LocationFloat = New DevExpress.Utils.PointFloat(253.1248!, 31.20832!)
        Me.XrLabel19.Multiline = True
        Me.XrLabel19.Name = "XrLabel19"
        Me.XrLabel19.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel19.SizeF = New System.Drawing.SizeF(372.8754!, 39.66667!)
        Me.XrLabel19.StylePriority.UseFont = False
        Me.XrLabel19.StylePriority.UseTextAlignment = False
        Me.XrLabel19.Text = "Arbeidsordre"
        Me.XrLabel19.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter
        '
        'XrLabel18
        '
        Me.XrLabel18.LocationFloat = New DevExpress.Utils.PointFloat(472.8751!, 80.125!)
        Me.XrLabel18.Multiline = True
        Me.XrLabel18.Name = "XrLabel18"
        Me.XrLabel18.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel18.SizeF = New System.Drawing.SizeF(100.0!, 23.0!)
        Me.XrLabel18.StylePriority.UseTextAlignment = False
        Me.XrLabel18.Text = "Side: "
        Me.XrLabel18.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrPageInfo1
        '
        Me.XrPageInfo1.LocationFloat = New DevExpress.Utils.PointFloat(572.8751!, 80.125!)
        Me.XrPageInfo1.Name = "XrPageInfo1"
        Me.XrPageInfo1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrPageInfo1.SizeF = New System.Drawing.SizeF(53.125!, 23.0!)
        Me.XrPageInfo1.StylePriority.UseTextAlignment = False
        Me.XrPageInfo1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'BottomMargin
        '
        Me.BottomMargin.HeightF = 75.0!
        Me.BottomMargin.Name = "BottomMargin"
        Me.BottomMargin.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100.0!)
        Me.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'GroupHeader2
        '
        Me.GroupHeader2.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.customerTable, Me.vendorTable})
        Me.GroupHeader2.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("InvoiceNumber", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeader2.HeightF = 205.4167!
        Me.GroupHeader2.Level = 2
        Me.GroupHeader2.Name = "GroupHeader2"
        Me.GroupHeader2.StyleName = "baseControlStyle"
        Me.GroupHeader2.StylePriority.UseBackColor = False
        Me.GroupHeader2.SubBands.AddRange(New DevExpress.XtraReports.UI.SubBand() {Me.SubBand1})
        '
        'customerTable
        '
        Me.customerTable.LocationFloat = New DevExpress.Utils.PointFloat(318.2585!, 0!)
        Me.customerTable.Name = "customerTable"
        Me.customerTable.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.customerNameRow, Me.customerContactNameRow, Me.customerAddressRow, Me.customerCityRow, Me.customerCountryRow})
        Me.customerTable.SizeF = New System.Drawing.SizeF(307.7415!, 125.0!)
        '
        'customerNameRow
        '
        Me.customerNameRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell1, Me.customerName})
        Me.customerNameRow.Name = "customerNameRow"
        Me.customerNameRow.Weight = 1.0R
        '
        'XrTableCell1
        '
        Me.XrTableCell1.Multiline = True
        Me.XrTableCell1.Name = "XrTableCell1"
        Me.XrTableCell1.StylePriority.UseFont = False
        Me.XrTableCell1.StylePriority.UsePadding = False
        Me.XrTableCell1.StylePriority.UseTextAlignment = False
        Me.XrTableCell1.Text = "Navn"
        Me.XrTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.XrTableCell1.Weight = 0.96562628075759793R
        '
        'customerName
        '
        Me.customerName.CanShrink = True
        Me.customerName.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[WO_CUST_NAME]")})
        Me.customerName.Name = "customerName"
        Me.customerName.StylePriority.UseFont = False
        Me.customerName.StylePriority.UsePadding = False
        Me.customerName.Weight = 2.3140517242440457R
        '
        'customerContactNameRow
        '
        Me.customerContactNameRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell2, Me.customerTableCell1, Me.customerContactName})
        Me.customerContactNameRow.Name = "customerContactNameRow"
        Me.customerContactNameRow.Weight = 1.0R
        '
        'XrTableCell2
        '
        Me.XrTableCell2.Multiline = True
        Me.XrTableCell2.Name = "XrTableCell2"
        Me.XrTableCell2.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.XrTableCell2.StylePriority.UseFont = False
        Me.XrTableCell2.StylePriority.UsePadding = False
        Me.XrTableCell2.StylePriority.UseTextAlignment = False
        Me.XrTableCell2.Text = "Adresse"
        Me.XrTableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.XrTableCell2.Weight = 0.68229953380824515R
        '
        'customerTableCell1
        '
        Me.customerTableCell1.CanShrink = True
        Me.customerTableCell1.Name = "customerTableCell1"
        Me.customerTableCell1.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.customerTableCell1.StylePriority.UseFont = False
        Me.customerTableCell1.StylePriority.UsePadding = False
        Me.customerTableCell1.StylePriority.UseTextAlignment = False
        Me.customerTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.customerTableCell1.Weight = 0.012910336556358426R
        '
        'customerContactName
        '
        Me.customerContactName.CanShrink = True
        Me.customerContactName.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[WO_CUST_PERM_ADD1]")})
        Me.customerContactName.Name = "customerContactName"
        Me.customerContactName.StylePriority.UseFont = False
        Me.customerContactName.StylePriority.UsePadding = False
        Me.customerContactName.Weight = 1.6221703156727465R
        '
        'customerAddressRow
        '
        Me.customerAddressRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell3, Me.customerTableCell2, Me.customerAddress, Me.XrTableCell7})
        Me.customerAddressRow.Name = "customerAddressRow"
        Me.customerAddressRow.Weight = 1.0R
        '
        'XrTableCell3
        '
        Me.XrTableCell3.Multiline = True
        Me.XrTableCell3.Name = "XrTableCell3"
        Me.XrTableCell3.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.XrTableCell3.StylePriority.UsePadding = False
        Me.XrTableCell3.StylePriority.UseTextAlignment = False
        Me.XrTableCell3.Text = "XrTableCell3"
        Me.XrTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.XrTableCell3.Weight = 0.021314498654930528R
        '
        'customerTableCell2
        '
        Me.customerTableCell2.CanShrink = True
        Me.customerTableCell2.Name = "customerTableCell2"
        Me.customerTableCell2.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.customerTableCell2.StylePriority.UsePadding = False
        Me.customerTableCell2.StylePriority.UseTextAlignment = False
        Me.customerTableCell2.Text = "Sted"
        Me.customerTableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.customerTableCell2.Weight = 0.96562595959542852R
        '
        'customerAddress
        '
        Me.customerAddress.CanShrink = True
        Me.customerAddress.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[ZIP_ZIPCODE]")})
        Me.customerAddress.Name = "customerAddress"
        Me.customerAddress.Weight = 0.6932451609503324R
        '
        'XrTableCell7
        '
        Me.XrTableCell7.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[ZIP_CITY]")})
        Me.XrTableCell7.Multiline = True
        Me.XrTableCell7.Name = "XrTableCell7"
        Me.XrTableCell7.Text = "XrTableCell7"
        Me.XrTableCell7.Weight = 1.5994923858009535R
        '
        'customerCityRow
        '
        Me.customerCityRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell4, Me.customerTableCell3, Me.customerCity})
        Me.customerCityRow.Name = "customerCityRow"
        Me.customerCityRow.Weight = 1.0R
        '
        'XrTableCell4
        '
        Me.XrTableCell4.Multiline = True
        Me.XrTableCell4.Name = "XrTableCell4"
        Me.XrTableCell4.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.XrTableCell4.StylePriority.UsePadding = False
        Me.XrTableCell4.StylePriority.UseTextAlignment = False
        Me.XrTableCell4.Text = "Land"
        Me.XrTableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.XrTableCell4.Weight = 0.68229953380824515R
        '
        'customerTableCell3
        '
        Me.customerTableCell3.CanShrink = True
        Me.customerTableCell3.Name = "customerTableCell3"
        Me.customerTableCell3.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.customerTableCell3.StylePriority.UsePadding = False
        Me.customerTableCell3.StylePriority.UseTextAlignment = False
        Me.customerTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.customerTableCell3.Weight = 0.012910336556358426R
        '
        'customerCity
        '
        Me.customerCity.CanShrink = True
        Me.customerCity.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[COUNTRY_NAME]")})
        Me.customerCity.Name = "customerCity"
        Me.customerCity.Weight = 1.6221703156727465R
        '
        'customerCountryRow
        '
        Me.customerCountryRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell5, Me.customerTableCell4, Me.customerCountry})
        Me.customerCountryRow.Name = "customerCountryRow"
        Me.customerCountryRow.Weight = 1.0R
        '
        'XrTableCell5
        '
        Me.XrTableCell5.Multiline = True
        Me.XrTableCell5.Name = "XrTableCell5"
        Me.XrTableCell5.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.XrTableCell5.StylePriority.UsePadding = False
        Me.XrTableCell5.StylePriority.UseTextAlignment = False
        Me.XrTableCell5.Text = "Telefon"
        Me.XrTableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.XrTableCell5.Weight = 0.68229953380824515R
        '
        'customerTableCell4
        '
        Me.customerTableCell4.CanShrink = True
        Me.customerTableCell4.Name = "customerTableCell4"
        Me.customerTableCell4.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.customerTableCell4.StylePriority.UsePadding = False
        Me.customerTableCell4.StylePriority.UseTextAlignment = False
        Me.customerTableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.customerTableCell4.Weight = 0.012910336556358426R
        '
        'customerCountry
        '
        Me.customerCountry.CanShrink = True
        Me.customerCountry.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[WO_CUST_PHONE_MOBILE]")})
        Me.customerCountry.Name = "customerCountry"
        Me.customerCountry.Weight = 1.6221703156727465R
        '
        'vendorTable
        '
        Me.vendorTable.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.vendorTable.Name = "vendorTable"
        Me.vendorTable.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.vendorNameRow, Me.vendorContactNameRow, Me.vendorAddressRow, Me.vendorCityRow, Me.vendorCountryRow, Me.vendorWebsiteRow, Me.vendorEmailRow, Me.vendorPhoneRow})
        Me.vendorTable.SizeF = New System.Drawing.SizeF(253.1248!, 200.0!)
        '
        'vendorNameRow
        '
        Me.vendorNameRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell8, Me.vendorName})
        Me.vendorNameRow.Name = "vendorNameRow"
        Me.vendorNameRow.Weight = 1.0R
        '
        'XrTableCell8
        '
        Me.XrTableCell8.Font = New System.Drawing.Font("Segoe UI", 9.75!)
        Me.XrTableCell8.Multiline = True
        Me.XrTableCell8.Name = "XrTableCell8"
        Me.XrTableCell8.StylePriority.UseFont = False
        Me.XrTableCell8.StylePriority.UsePadding = False
        Me.XrTableCell8.Text = "Refnr"
        Me.XrTableCell8.Weight = 0.3731783377422474R
        '
        'vendorName
        '
        Me.vendorName.CanShrink = True
        Me.vendorName.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[WO_VEH_INTERN_NO]")})
        Me.vendorName.Font = New System.Drawing.Font("Segoe UI", 9.75!)
        Me.vendorName.Name = "vendorName"
        Me.vendorName.StylePriority.UseFont = False
        Me.vendorName.StylePriority.UsePadding = False
        Me.vendorName.Weight = 0.55304031300286538R
        '
        'vendorContactNameRow
        '
        Me.vendorContactNameRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell9, Me.vendorContactName})
        Me.vendorContactNameRow.Name = "vendorContactNameRow"
        Me.vendorContactNameRow.Weight = 1.0R
        '
        'XrTableCell9
        '
        Me.XrTableCell9.Multiline = True
        Me.XrTableCell9.Name = "XrTableCell9"
        Me.XrTableCell9.StylePriority.UseFont = False
        Me.XrTableCell9.StylePriority.UsePadding = False
        Me.XrTableCell9.Text = "Regnr"
        Me.XrTableCell9.Weight = 0.37317498770049362R
        '
        'vendorContactName
        '
        Me.vendorContactName.CanShrink = True
        Me.vendorContactName.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel4})
        Me.vendorContactName.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[WO_VEH_REG_NO]")})
        Me.vendorContactName.Name = "vendorContactName"
        Me.vendorContactName.StylePriority.UseFont = False
        Me.vendorContactName.StylePriority.UsePadding = False
        Me.vendorContactName.Weight = 0.55304366304461916R
        '
        'XrLabel4
        '
        Me.XrLabel4.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[WO_VEH_REG_NO]")})
        Me.XrLabel4.LocationFloat = New DevExpress.Utils.PointFloat(0.0009183884!, 2.000031!)
        Me.XrLabel4.Multiline = True
        Me.XrLabel4.Name = "XrLabel4"
        Me.XrLabel4.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel4.SizeF = New System.Drawing.SizeF(303.5407!, 23.0!)
        Me.XrLabel4.Text = "XrLabel4"
        '
        'vendorAddressRow
        '
        Me.vendorAddressRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell10, Me.vendorAddress})
        Me.vendorAddressRow.Name = "vendorAddressRow"
        Me.vendorAddressRow.Weight = 1.0R
        '
        'XrTableCell10
        '
        Me.XrTableCell10.Multiline = True
        Me.XrTableCell10.Name = "XrTableCell10"
        Me.XrTableCell10.StylePriority.UseFont = False
        Me.XrTableCell10.Text = "Merke"
        Me.XrTableCell10.Weight = 0.3731783377422474R
        '
        'vendorAddress
        '
        Me.vendorAddress.CanShrink = True
        Me.vendorAddress.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT.ID_MAKE_NAME]")})
        Me.vendorAddress.Name = "vendorAddress"
        Me.vendorAddress.StylePriority.UseFont = False
        Me.vendorAddress.Weight = 0.55304031300286538R
        '
        'vendorCityRow
        '
        Me.vendorCityRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell11, Me.vendorCity})
        Me.vendorCityRow.Name = "vendorCityRow"
        Me.vendorCityRow.Weight = 1.0R
        '
        'XrTableCell11
        '
        Me.XrTableCell11.Multiline = True
        Me.XrTableCell11.Name = "XrTableCell11"
        Me.XrTableCell11.StylePriority.UseFont = False
        Me.XrTableCell11.Text = "Modell"
        Me.XrTableCell11.Weight = 0.3731783377422474R
        '
        'vendorCity
        '
        Me.vendorCity.CanShrink = True
        Me.vendorCity.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT.VEHICLE_TYPE]")})
        Me.vendorCity.Name = "vendorCity"
        Me.vendorCity.StylePriority.UseFont = False
        Me.vendorCity.Weight = 0.55304031300286538R
        '
        'vendorCountryRow
        '
        Me.vendorCountryRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell12, Me.vendorCountry})
        Me.vendorCountryRow.Name = "vendorCountryRow"
        Me.vendorCountryRow.Weight = 1.0R
        '
        'XrTableCell12
        '
        Me.XrTableCell12.Multiline = True
        Me.XrTableCell12.Name = "XrTableCell12"
        Me.XrTableCell12.StylePriority.UseFont = False
        Me.XrTableCell12.Text = "Km.stand"
        Me.XrTableCell12.Weight = 0.3731783377422474R
        '
        'vendorCountry
        '
        Me.vendorCountry.CanShrink = True
        Me.vendorCountry.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[WO_VEH_MILEAGE]")})
        Me.vendorCountry.Name = "vendorCountry"
        Me.vendorCountry.StylePriority.UseFont = False
        Me.vendorCountry.Weight = 0.55304031300286538R
        '
        'vendorWebsiteRow
        '
        Me.vendorWebsiteRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell13, Me.vendorWebsite})
        Me.vendorWebsiteRow.Name = "vendorWebsiteRow"
        Me.vendorWebsiteRow.Weight = 1.0R
        '
        'XrTableCell13
        '
        Me.XrTableCell13.Multiline = True
        Me.XrTableCell13.Name = "XrTableCell13"
        Me.XrTableCell13.StylePriority.UseFont = False
        Me.XrTableCell13.Text = "Chassisnr"
        Me.XrTableCell13.Weight = 0.3731783377422474R
        '
        'vendorWebsite
        '
        Me.vendorWebsite.CanShrink = True
        Me.vendorWebsite.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[WO_VEH_VIN]")})
        Me.vendorWebsite.Name = "vendorWebsite"
        Me.vendorWebsite.StylePriority.UseFont = False
        Me.vendorWebsite.Weight = 0.55304031300286538R
        '
        'vendorEmailRow
        '
        Me.vendorEmailRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell14, Me.vendorEmail})
        Me.vendorEmailRow.Name = "vendorEmailRow"
        Me.vendorEmailRow.Weight = 1.0R
        '
        'XrTableCell14
        '
        Me.XrTableCell14.Multiline = True
        Me.XrTableCell14.Name = "XrTableCell14"
        Me.XrTableCell14.StylePriority.UseFont = False
        Me.XrTableCell14.Text = "Modellgruppe"
        Me.XrTableCell14.Weight = 0.37317498770049362R
        '
        'vendorEmail
        '
        Me.vendorEmail.CanShrink = True
        Me.vendorEmail.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[ID_MODELGRP_NAME]")})
        Me.vendorEmail.Name = "vendorEmail"
        Me.vendorEmail.StylePriority.UseFont = False
        Me.vendorEmail.Weight = 0.55304366304461916R
        '
        'vendorPhoneRow
        '
        Me.vendorPhoneRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell15, Me.vendorPhone})
        Me.vendorPhoneRow.Name = "vendorPhoneRow"
        Me.vendorPhoneRow.Weight = 1.0R
        '
        'XrTableCell15
        '
        Me.XrTableCell15.Multiline = True
        Me.XrTableCell15.Name = "XrTableCell15"
        Me.XrTableCell15.StylePriority.UseFont = False
        Me.XrTableCell15.Text = "1 reg.dato"
        Me.XrTableCell15.Weight = 0.3731783377422474R
        '
        'vendorPhone
        '
        Me.vendorPhone.CanShrink = True
        Me.vendorPhone.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[DT_VEH_ERGN]")})
        Me.vendorPhone.Name = "vendorPhone"
        Me.vendorPhone.StylePriority.UseFont = False
        Me.vendorPhone.TextFormatString = "{0:d MMMM, yyyy}"
        Me.vendorPhone.Weight = 0.55304031300286538R
        '
        'SubBand1
        '
        Me.SubBand1.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.xrLine1, Me.invoiceNumberTable, Me.invoiceDatesTable})
        Me.SubBand1.HeightF = 68.75!
        Me.SubBand1.KeepTogether = True
        Me.SubBand1.Name = "SubBand1"
        '
        'xrLine1
        '
        Me.xrLine1.ForeColor = System.Drawing.Color.Gray
        Me.xrLine1.LocationFloat = New DevExpress.Utils.PointFloat(0.0002066294!, 56.00007!)
        Me.xrLine1.Name = "xrLine1"
        Me.xrLine1.SizeF = New System.Drawing.SizeF(625.9999!, 10.0!)
        Me.xrLine1.StylePriority.UseForeColor = False
        '
        'invoiceNumberTable
        '
        Me.invoiceNumberTable.LocationFloat = New DevExpress.Utils.PointFloat(10.00026!, 10.00001!)
        Me.invoiceNumberTable.Name = "invoiceNumberTable"
        Me.invoiceNumberTable.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.invoiceNumberRow})
        Me.invoiceNumberTable.SizeF = New System.Drawing.SizeF(303.5414!, 46.00004!)
        '
        'invoiceNumberRow
        '
        Me.invoiceNumberRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.invoiceLabel, Me.invoiceNumber})
        Me.invoiceNumberRow.Name = "invoiceNumberRow"
        Me.invoiceNumberRow.Weight = 1.0R
        '
        'invoiceLabel
        '
        Me.invoiceLabel.Font = New System.Drawing.Font("Segoe UI", 20.0!, System.Drawing.FontStyle.Bold)
        Me.invoiceLabel.Name = "invoiceLabel"
        Me.invoiceLabel.StylePriority.UseFont = False
        Me.invoiceLabel.StylePriority.UseTextAlignment = False
        Me.invoiceLabel.Text = "ORDRE:"
        Me.invoiceLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.BottomLeft
        Me.invoiceLabel.Weight = 0.69306814226787872R
        '
        'invoiceNumber
        '
        Me.invoiceNumber.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[ID_WO_NO]")})
        Me.invoiceNumber.Font = New System.Drawing.Font("Segoe UI", 14.0!)
        Me.invoiceNumber.Name = "invoiceNumber"
        Me.invoiceNumber.StylePriority.UseFont = False
        Me.invoiceNumber.StylePriority.UseTextAlignment = False
        Me.invoiceNumber.TextAlignment = DevExpress.XtraPrinting.TextAlignment.BottomLeft
        Me.invoiceNumber.TextFormatString = "#{0}"
        Me.invoiceNumber.Weight = 1.243162990493514R
        '
        'invoiceDatesTable
        '
        Me.invoiceDatesTable.LocationFloat = New DevExpress.Utils.PointFloat(323.9602!, 10.00001!)
        Me.invoiceDatesTable.Name = "invoiceDatesTable"
        Me.invoiceDatesTable.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.invoiceDateRow, Me.invoiceDueDateRow})
        Me.invoiceDatesTable.SizeF = New System.Drawing.SizeF(302.0399!, 46.0!)
        '
        'invoiceDateRow
        '
        Me.invoiceDateRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.invoiceDateCaption, Me.invoiceDate})
        Me.invoiceDateRow.Name = "invoiceDateRow"
        Me.invoiceDateRow.Weight = 0.92R
        '
        'invoiceDateCaption
        '
        Me.invoiceDateCaption.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.invoiceDateCaption.Name = "invoiceDateCaption"
        Me.invoiceDateCaption.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.invoiceDateCaption.StylePriority.UseFont = False
        Me.invoiceDateCaption.StylePriority.UsePadding = False
        Me.invoiceDateCaption.StylePriority.UseTextAlignment = False
        Me.invoiceDateCaption.Text = "ORDREDATO:"
        Me.invoiceDateCaption.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.invoiceDateCaption.Weight = 0.67534864661118454R
        '
        'invoiceDate
        '
        Me.invoiceDate.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[DT_ORDER]")})
        Me.invoiceDate.Font = New System.Drawing.Font("Segoe UI", 9.0!)
        Me.invoiceDate.Name = "invoiceDate"
        Me.invoiceDate.StylePriority.UseFont = False
        Me.invoiceDate.TextFormatString = "{0:d MMMM, yyyy}"
        Me.invoiceDate.Weight = 1.1122876097263821R
        '
        'invoiceDueDateRow
        '
        Me.invoiceDueDateRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.invoiceDueDateCaption, Me.invoiceDueDate})
        Me.invoiceDueDateRow.Name = "invoiceDueDateRow"
        Me.invoiceDueDateRow.Weight = 0.91999999999999993R
        '
        'invoiceDueDateCaption
        '
        Me.invoiceDueDateCaption.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.invoiceDueDateCaption.Name = "invoiceDueDateCaption"
        Me.invoiceDueDateCaption.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 10, 0, 0, 100.0!)
        Me.invoiceDueDateCaption.StylePriority.UseFont = False
        Me.invoiceDueDateCaption.StylePriority.UsePadding = False
        Me.invoiceDueDateCaption.StylePriority.UseTextAlignment = False
        Me.invoiceDueDateCaption.Text = "FERDIG DATO:"
        Me.invoiceDueDateCaption.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.invoiceDueDateCaption.Weight = 0.67534864661118454R
        '
        'invoiceDueDate
        '
        Me.invoiceDueDate.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_RPT_WO_JOB_CARD_REPORT].[DT_FINISH]")})
        Me.invoiceDueDate.Font = New System.Drawing.Font("Segoe UI", 9.0!)
        Me.invoiceDueDate.Name = "invoiceDueDate"
        Me.invoiceDueDate.StylePriority.UseFont = False
        Me.invoiceDueDate.TextFormatString = "{0:d MMMM, yyyy}"
        Me.invoiceDueDate.Weight = 1.1122876097263821R
        '
        'GroupFooter1
        '
        Me.GroupFooter1.HeightF = 43.12515!
        Me.GroupFooter1.Name = "GroupFooter1"
        Me.GroupFooter1.PrintAtBottom = True
        Me.GroupFooter1.StyleName = "baseControlStyle"
        '
        'GroupHeader1
        '
        Me.GroupHeader1.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.xrLine2, Me.headerTable})
        Me.GroupHeader1.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("ID_WO_NO", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeader1.HeightF = 35.0!
        Me.GroupHeader1.KeepTogether = True
        Me.GroupHeader1.Level = 1
        Me.GroupHeader1.Name = "GroupHeader1"
        Me.GroupHeader1.StyleName = "baseControlStyle"
        '
        'xrLine2
        '
        Me.xrLine2.ForeColor = System.Drawing.Color.Gray
        Me.xrLine2.LineStyle = System.Drawing.Drawing2D.DashStyle.Dash
        Me.xrLine2.LocationFloat = New DevExpress.Utils.PointFloat(0!, 25.0!)
        Me.xrLine2.Name = "xrLine2"
        Me.xrLine2.SizeF = New System.Drawing.SizeF(625.9999!, 10.0!)
        Me.xrLine2.StylePriority.UseForeColor = False
        '
        'headerTable
        '
        Me.headerTable.LocationFloat = New DevExpress.Utils.PointFloat(10.00001!, 0!)
        Me.headerTable.Name = "headerTable"
        Me.headerTable.Padding = New DevExpress.XtraPrinting.PaddingInfo(0, 0, 5, 0, 100.0!)
        Me.headerTable.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.headerTableRow})
        Me.headerTable.SizeF = New System.Drawing.SizeF(616.0002!, 25.0!)
        Me.headerTable.StylePriority.UsePadding = False
        '
        'headerTableRow
        '
        Me.headerTableRow.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.quantityCaption, Me.productNameCaption, Me.unitPriceCaption, Me.lineTotalCaption})
        Me.headerTableRow.Name = "headerTableRow"
        Me.headerTableRow.Weight = 11.5R
        '
        'quantityCaption
        '
        Me.quantityCaption.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.quantityCaption.Name = "quantityCaption"
        Me.quantityCaption.StylePriority.UseFont = False
        Me.quantityCaption.StylePriority.UseTextAlignment = False
        Me.quantityCaption.Text = "VARENR"
        Me.quantityCaption.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.quantityCaption.Weight = 0.54040182354155153R
        '
        'productNameCaption
        '
        Me.productNameCaption.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.productNameCaption.Name = "productNameCaption"
        Me.productNameCaption.Padding = New DevExpress.XtraPrinting.PaddingInfo(5, 0, 5, 0, 100.0!)
        Me.productNameCaption.StylePriority.UseFont = False
        Me.productNameCaption.StylePriority.UsePadding = False
        Me.productNameCaption.Text = "BESKRIVELSE"
        Me.productNameCaption.Weight = 1.1899961790519682R
        '
        'unitPriceCaption
        '
        Me.unitPriceCaption.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.unitPriceCaption.Name = "unitPriceCaption"
        Me.unitPriceCaption.StylePriority.UseFont = False
        Me.unitPriceCaption.StylePriority.UseTextAlignment = False
        Me.unitPriceCaption.Text = "BESTILT"
        Me.unitPriceCaption.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.unitPriceCaption.Weight = 0.32425420593409959R
        '
        'lineTotalCaption
        '
        Me.lineTotalCaption.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.lineTotalCaption.Name = "lineTotalCaption"
        Me.lineTotalCaption.StylePriority.UseFont = False
        Me.lineTotalCaption.StylePriority.UseTextAlignment = False
        Me.lineTotalCaption.Text = "LEVERT"
        Me.lineTotalCaption.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.lineTotalCaption.Weight = 0.27188270910810558R
        '
        'SqlDataSource1
        '
        Me.SqlDataSource1.ConnectionName = "localhost_CARS"
        Me.SqlDataSource1.Name = "SqlDataSource1"
        StoredProcQuery1.Name = "USP_RPT_WO_JOB_CARD_REPORT"
        QueryParameter1.Name = "@IV_WO_NO"
        QueryParameter1.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter1.Value = New DevExpress.DataAccess.Expression("?pIV_WO_NO", GetType(String))
        QueryParameter2.Name = "@IV_LANGUAGE"
        QueryParameter2.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter2.Value = New DevExpress.DataAccess.Expression("?pLanguage", GetType(String))
        StoredProcQuery1.Parameters.Add(QueryParameter1)
        StoredProcQuery1.Parameters.Add(QueryParameter2)
        StoredProcQuery1.StoredProcName = "USP_RPT_WO_JOB_CARD_REPORT"
        StoredProcQuery2.Name = "USP_RPT_WO_JOB_CARD_REPORT_LINES"
        QueryParameter3.Name = "@IV_WO_NO"
        QueryParameter3.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter3.Value = New DevExpress.DataAccess.Expression("?pIV_WO_NO", GetType(String))
        StoredProcQuery2.Parameters.Add(QueryParameter3)
        StoredProcQuery2.StoredProcName = "USP_RPT_WO_JOB_CARD_REPORT_LINES"
        Me.SqlDataSource1.Queries.AddRange(New DevExpress.DataAccess.Sql.SqlQuery() {StoredProcQuery1, StoredProcQuery2})
        Me.SqlDataSource1.ResultSchemaSerializable = resources.GetString("SqlDataSource1.ResultSchemaSerializable")
        '
        'baseControlStyle
        '
        Me.baseControlStyle.Font = New System.Drawing.Font("Segoe UI", 9.75!)
        Me.baseControlStyle.Name = "baseControlStyle"
        Me.baseControlStyle.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        '
        'pIV_WO_NO
        '
        Me.pIV_WO_NO.Name = "pIV_WO_NO"
        '
        'pLanguage
        '
        Me.pLanguage.Name = "pLanguage"
        '
        'GroupHeader3
        '
        Me.GroupHeader3.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel8, Me.XrLabel9, Me.XrLabel7, Me.XrLabel5})
        Me.GroupHeader3.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("ID_JOB", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeader3.HeightF = 24.79165!
        Me.GroupHeader3.KeepTogether = True
        Me.GroupHeader3.Name = "GroupHeader3"
        '
        'XrLabel8
        '
        Me.XrLabel8.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[WORK_CODE]")})
        Me.XrLabel8.LocationFloat = New DevExpress.Utils.PointFloat(229.1247!, 0!)
        Me.XrLabel8.Multiline = True
        Me.XrLabel8.Name = "XrLabel8"
        Me.XrLabel8.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel8.SizeF = New System.Drawing.SizeF(100.0!, 23.0!)
        Me.XrLabel8.Text = "XrLabel8"
        '
        'XrLabel9
        '
        Me.XrLabel9.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel9.LocationFloat = New DevExpress.Utils.PointFloat(153.083!, 0!)
        Me.XrLabel9.Multiline = True
        Me.XrLabel9.Name = "XrLabel9"
        Me.XrLabel9.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel9.SizeF = New System.Drawing.SizeF(76.04169!, 23.0!)
        Me.XrLabel9.StylePriority.UseFont = False
        Me.XrLabel9.Text = "Jobbkode:"
        '
        'XrLabel7
        '
        Me.XrLabel7.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ID_JOB]")})
        Me.XrLabel7.LocationFloat = New DevExpress.Utils.PointFloat(72.87467!, 1.791636!)
        Me.XrLabel7.Multiline = True
        Me.XrLabel7.Name = "XrLabel7"
        Me.XrLabel7.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel7.SizeF = New System.Drawing.SizeF(60.36062!, 23.0!)
        Me.XrLabel7.StylePriority.UseTextAlignment = False
        Me.XrLabel7.Text = "XrLabel7"
        Me.XrLabel7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrLabel5
        '
        Me.XrLabel5.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel5.LocationFloat = New DevExpress.Utils.PointFloat(10.00026!, 1.791636!)
        Me.XrLabel5.Multiline = True
        Me.XrLabel5.Name = "XrLabel5"
        Me.XrLabel5.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel5.SizeF = New System.Drawing.SizeF(62.87441!, 23.0!)
        Me.XrLabel5.StylePriority.UseFont = False
        Me.XrLabel5.Text = "Jobbnr:"
        '
        'ReportFooter
        '
        Me.ReportFooter.Borders = DevExpress.XtraPrinting.BorderSide.None
        Me.ReportFooter.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLine10, Me.XrLine9, Me.XrLine8, Me.XrLine7, Me.XrLine6, Me.XrLine5, Me.XrLine4, Me.XrLine3, Me.XrLabel15, Me.XrLabel16, Me.XrLabel14, Me.XrLabel17, Me.XrLabel13, Me.XrLabel12, Me.XrLabel11, Me.XrLabel10})
        Me.ReportFooter.HeightF = 100.0834!
        Me.ReportFooter.KeepTogether = True
        Me.ReportFooter.Name = "ReportFooter"
        Me.ReportFooter.PrintAtBottom = True
        Me.ReportFooter.StylePriority.UseBorders = False
        '
        'XrLine10
        '
        Me.XrLine10.LocationFloat = New DevExpress.Utils.PointFloat(522.8905!, 59.375!)
        Me.XrLine10.Name = "XrLine10"
        Me.XrLine10.SizeF = New System.Drawing.SizeF(69.73572!, 40.70835!)
        '
        'XrLine9
        '
        Me.XrLine9.LocationFloat = New DevExpress.Utils.PointFloat(389.61!, 59.375!)
        Me.XrLine9.Name = "XrLine9"
        Me.XrLine9.SizeF = New System.Drawing.SizeF(67.65231!, 40.70835!)
        '
        'XrLine8
        '
        Me.XrLine8.LocationFloat = New DevExpress.Utils.PointFloat(101.9844!, 59.375!)
        Me.XrLine8.Name = "XrLine8"
        Me.XrLine8.SizeF = New System.Drawing.SizeF(128.0699!, 40.70835!)
        '
        'XrLine7
        '
        Me.XrLine7.LocationFloat = New DevExpress.Utils.PointFloat(572.8751!, 0!)
        Me.XrLine7.Name = "XrLine7"
        Me.XrLine7.SizeF = New System.Drawing.SizeF(48.8175!, 40.70835!)
        '
        'XrLine6
        '
        Me.XrLine6.LocationFloat = New DevExpress.Utils.PointFloat(426.4935!, 0!)
        Me.XrLine6.Name = "XrLine6"
        Me.XrLine6.SizeF = New System.Drawing.SizeF(45.77732!, 40.70835!)
        '
        'XrLine5
        '
        Me.XrLine5.LocationFloat = New DevExpress.Utils.PointFloat(297.9994!, 0!)
        Me.XrLine5.Name = "XrLine5"
        Me.XrLine5.SizeF = New System.Drawing.SizeF(45.77732!, 40.70835!)
        '
        'XrLine4
        '
        Me.XrLine4.LocationFloat = New DevExpress.Utils.PointFloat(184.277!, 0!)
        Me.XrLine4.Name = "XrLine4"
        Me.XrLine4.SizeF = New System.Drawing.SizeF(45.77732!, 40.70835!)
        '
        'XrLine3
        '
        Me.XrLine3.LocationFloat = New DevExpress.Utils.PointFloat(72.87467!, 0!)
        Me.XrLine3.Name = "XrLine3"
        Me.XrLine3.SizeF = New System.Drawing.SizeF(45.77732!, 40.70835!)
        '
        'XrLabel15
        '
        Me.XrLabel15.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel15.LocationFloat = New DevExpress.Utils.PointFloat(475.9151!, 59.375!)
        Me.XrLabel15.Multiline = True
        Me.XrLabel15.Name = "XrLabel15"
        Me.XrLabel15.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel15.SizeF = New System.Drawing.SizeF(46.97543!, 23.0!)
        Me.XrLabel15.StylePriority.UseFont = False
        Me.XrLabel15.Text = "Stopp:"
        '
        'XrLabel16
        '
        Me.XrLabel16.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel16.LocationFloat = New DevExpress.Utils.PointFloat(343.7767!, 59.375!)
        Me.XrLabel16.Multiline = True
        Me.XrLabel16.Name = "XrLabel16"
        Me.XrLabel16.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel16.SizeF = New System.Drawing.SizeF(45.83328!, 23.0!)
        Me.XrLabel16.StylePriority.UseFont = False
        Me.XrLabel16.Text = "Start:"
        '
        'XrLabel14
        '
        Me.XrLabel14.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel14.LocationFloat = New DevExpress.Utils.PointFloat(475.9151!, 0!)
        Me.XrLabel14.Multiline = True
        Me.XrLabel14.Name = "XrLabel14"
        Me.XrLabel14.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel14.SizeF = New System.Drawing.SizeF(96.95996!, 23.0!)
        Me.XrLabel14.StylePriority.UseFont = False
        Me.XrLabel14.Text = "Spylervæske:"
        '
        'XrLabel17
        '
        Me.XrLabel17.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel17.LocationFloat = New DevExpress.Utils.PointFloat(0!, 59.375!)
        Me.XrLabel17.Multiline = True
        Me.XrLabel17.Name = "XrLabel17"
        Me.XrLabel17.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel17.SizeF = New System.Drawing.SizeF(101.9853!, 23.0!)
        Me.XrLabel17.StylePriority.UseFont = False
        Me.XrLabel17.Text = "Ny km.stand:"
        '
        'XrLabel13
        '
        Me.XrLabel13.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel13.LocationFloat = New DevExpress.Utils.PointFloat(230.0543!, 0!)
        Me.XrLabel13.Multiline = True
        Me.XrLabel13.Name = "XrLabel13"
        Me.XrLabel13.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel13.SizeF = New System.Drawing.SizeF(81.24997!, 23.0!)
        Me.XrLabel13.StylePriority.UseFont = False
        Me.XrLabel13.Text = "Diff. oljer:"
        '
        'XrLabel12
        '
        Me.XrLabel12.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel12.LocationFloat = New DevExpress.Utils.PointFloat(343.7767!, 0!)
        Me.XrLabel12.Multiline = True
        Me.XrLabel12.Name = "XrLabel12"
        Me.XrLabel12.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel12.SizeF = New System.Drawing.SizeF(82.71678!, 23.0!)
        Me.XrLabel12.StylePriority.UseFont = False
        Me.XrLabel12.Text = "Frostvæske:"
        '
        'XrLabel11
        '
        Me.XrLabel11.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel11.LocationFloat = New DevExpress.Utils.PointFloat(118.652!, 0!)
        Me.XrLabel11.Multiline = True
        Me.XrLabel11.Name = "XrLabel11"
        Me.XrLabel11.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel11.SizeF = New System.Drawing.SizeF(65.625!, 23.0!)
        Me.XrLabel11.StylePriority.UseFont = False
        Me.XrLabel11.Text = "Aut.oljer:"
        '
        'XrLabel10
        '
        Me.XrLabel10.Font = New System.Drawing.Font("Segoe UI", 9.75!, System.Drawing.FontStyle.Bold)
        Me.XrLabel10.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.XrLabel10.Multiline = True
        Me.XrLabel10.Name = "XrLabel10"
        Me.XrLabel10.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel10.SizeF = New System.Drawing.SizeF(72.87467!, 23.0!)
        Me.XrLabel10.StylePriority.UseFont = False
        Me.XrLabel10.Text = "Motorolje:"
        '
        'dxJobCard
        '
        Me.Bands.AddRange(New DevExpress.XtraReports.UI.Band() {Me.Detail, Me.TopMargin, Me.BottomMargin, Me.GroupHeader2, Me.GroupFooter1, Me.GroupHeader1, Me.GroupHeader3, Me.ReportFooter})
        Me.ComponentStorage.AddRange(New System.ComponentModel.IComponent() {Me.SqlDataSource1})
        Me.DataMember = "USP_RPT_WO_JOB_CARD_REPORT_LINES"
        Me.DataSource = Me.SqlDataSource1
        Me.Font = New System.Drawing.Font("Arial", 9.75!)
        Me.Margins = New System.Drawing.Printing.Margins(101, 100, 129, 75)
        Me.PageHeight = 1169
        Me.PageWidth = 827
        Me.PaperKind = System.Drawing.Printing.PaperKind.A4
        Me.Parameters.AddRange(New DevExpress.XtraReports.Parameters.Parameter() {Me.pIV_WO_NO, Me.pLanguage})
        Me.StyleSheet.AddRange(New DevExpress.XtraReports.UI.XRControlStyle() {Me.baseControlStyle})
        Me.Version = "21.2"
        CType(Me.customerTable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.vendorTable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.invoiceNumberTable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.invoiceDatesTable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.headerTable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me, System.ComponentModel.ISupportInitialize).EndInit()

    End Sub

    Friend WithEvents Detail As DevExpress.XtraReports.UI.DetailBand
    Friend WithEvents TopMargin As DevExpress.XtraReports.UI.TopMarginBand
    Friend WithEvents BottomMargin As DevExpress.XtraReports.UI.BottomMarginBand
    Friend WithEvents GroupHeader2 As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents customerTable As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents customerNameRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents customerName As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerContactNameRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents customerTableCell1 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerContactName As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerAddressRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents customerTableCell2 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerAddress As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerCountryRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents customerTableCell4 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerCountry As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorTable As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents vendorAddressRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents vendorAddress As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorCityRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents vendorCity As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorCountryRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents vendorCountry As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorWebsiteRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents vendorWebsite As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorEmailRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents vendorEmail As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorPhoneRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents vendorPhone As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents SubBand1 As DevExpress.XtraReports.UI.SubBand
    Friend WithEvents xrLine1 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents invoiceNumberTable As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents invoiceNumberRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents invoiceLabel As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents invoiceNumber As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents invoiceDatesTable As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents invoiceDateRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents invoiceDateCaption As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents invoiceDate As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents invoiceDueDateRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents invoiceDueDateCaption As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents invoiceDueDate As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents GroupFooter1 As DevExpress.XtraReports.UI.GroupFooterBand
    Friend WithEvents GroupHeader1 As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents xrLine2 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents headerTable As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents headerTableRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents quantityCaption As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents productNameCaption As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents unitPriceCaption As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents lineTotalCaption As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents SqlDataSource1 As DevExpress.DataAccess.Sql.SqlDataSource
    Friend WithEvents baseControlStyle As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents pIV_WO_NO As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pLanguage As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents XrLabel2 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel1 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel3 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents vendorContactNameRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents vendorContactName As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrLabel4 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel6 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrTableCell1 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell2 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell3 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell7 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerCityRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents XrTableCell4 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerTableCell3 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents customerCity As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell5 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorNameRow As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents XrTableCell8 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents vendorName As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell9 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell10 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell11 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell12 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell13 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell14 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell15 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents GroupHeader3 As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents XrLabel9 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel7 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel5 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel8 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents ReportFooter As DevExpress.XtraReports.UI.ReportFooterBand
    Friend WithEvents XrLabel13 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel12 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel11 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel10 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel17 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel16 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel15 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel14 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel19 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel18 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrPageInfo1 As DevExpress.XtraReports.UI.XRPageInfo
    Friend WithEvents XrLine10 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine9 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine8 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine7 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine6 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine5 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine4 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine3 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrPictureBox1 As DevExpress.XtraReports.UI.XRPictureBox
End Class
