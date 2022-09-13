<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class rptCountingList
    Inherits DevExpress.XtraReports.UI.XtraReport

    'XtraReport overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
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
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim StoredProcQuery1 As DevExpress.DataAccess.Sql.StoredProcQuery = New DevExpress.DataAccess.Sql.StoredProcQuery()
        Dim QueryParameter1 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter2 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(rptCountingList))
        Dim XrSummary1 As DevExpress.XtraReports.UI.XRSummary = New DevExpress.XtraReports.UI.XRSummary()
        Me.SqlDataSource1 = New DevExpress.DataAccess.Sql.SqlDataSource(Me.components)
        Me.Title = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.DetailCaption1 = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.DetailData1 = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.DetailData3_Odd = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.PageInfo = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.TopMargin = New DevExpress.XtraReports.UI.TopMarginBand()
        Me.BottomMargin = New DevExpress.XtraReports.UI.BottomMarginBand()
        Me.pageInfo1 = New DevExpress.XtraReports.UI.XRPageInfo()
        Me.pageInfo2 = New DevExpress.XtraReports.UI.XRPageInfo()
        Me.ReportHeader = New DevExpress.XtraReports.UI.ReportHeaderBand()
        Me.label1 = New DevExpress.XtraReports.UI.XRLabel()
        Me.GrpHCountingNo = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.table1 = New DevExpress.XtraReports.UI.XRTable()
        Me.tableRow1 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.tableCell1 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell2 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell3 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell4 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell5 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell6 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell7 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell8 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell9 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell10 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell11 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.Detail = New DevExpress.XtraReports.UI.DetailBand()
        Me.table2 = New DevExpress.XtraReports.UI.XRTable()
        Me.tableRow2 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.tableCell12 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell13 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell14 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell15 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell16 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell17 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell18 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell19 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell20 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell21 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell22 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.IdItem = New DevExpress.XtraReports.Parameters.Parameter()
        Me.LineNo = New DevExpress.XtraReports.Parameters.Parameter()
        Me.CalculatedField1 = New DevExpress.XtraReports.UI.CalculatedField()
        Me.XrLabel2 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel1 = New DevExpress.XtraReports.UI.XRLabel()
        CType(Me.table1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.table2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me, System.ComponentModel.ISupportInitialize).BeginInit()
        '
        'SqlDataSource1
        '
        Me.SqlDataSource1.ConnectionName = "localhost_CARSDEV_RELEASE_DP_REL_Connection"
        Me.SqlDataSource1.Name = "SqlDataSource1"
        StoredProcQuery1.Name = "USP_FETCH_COUNTING_DEV"
        QueryParameter1.Name = "@ID_ITEM"
        QueryParameter1.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter1.Value = New DevExpress.DataAccess.Expression("?IdItem", GetType(String))
        QueryParameter2.Name = "@LINE_NO"
        QueryParameter2.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter2.Value = New DevExpress.DataAccess.Expression("?LineNo", GetType(String))
        StoredProcQuery1.Parameters.Add(QueryParameter1)
        StoredProcQuery1.Parameters.Add(QueryParameter2)
        StoredProcQuery1.StoredProcName = "USP_FETCH_COUNTING_DEV"
        Me.SqlDataSource1.Queries.AddRange(New DevExpress.DataAccess.Sql.SqlQuery() {StoredProcQuery1})
        Me.SqlDataSource1.ResultSchemaSerializable = resources.GetString("SqlDataSource1.ResultSchemaSerializable")
        '
        'Title
        '
        Me.Title.BackColor = System.Drawing.Color.Transparent
        Me.Title.BorderColor = System.Drawing.Color.Black
        Me.Title.Borders = DevExpress.XtraPrinting.BorderSide.None
        Me.Title.BorderWidth = 1.0!
        Me.Title.Font = New System.Drawing.Font("Arial", 14.25!)
        Me.Title.ForeColor = System.Drawing.Color.FromArgb(CType(CType(75, Byte), Integer), CType(CType(75, Byte), Integer), CType(CType(75, Byte), Integer))
        Me.Title.Name = "Title"
        Me.Title.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        '
        'DetailCaption1
        '
        Me.DetailCaption1.BackColor = System.Drawing.Color.FromArgb(CType(CType(75, Byte), Integer), CType(CType(75, Byte), Integer), CType(CType(75, Byte), Integer))
        Me.DetailCaption1.BorderColor = System.Drawing.Color.White
        Me.DetailCaption1.Borders = DevExpress.XtraPrinting.BorderSide.Left
        Me.DetailCaption1.BorderWidth = 2.0!
        Me.DetailCaption1.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold)
        Me.DetailCaption1.ForeColor = System.Drawing.Color.White
        Me.DetailCaption1.Name = "DetailCaption1"
        Me.DetailCaption1.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.DetailCaption1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'DetailData1
        '
        Me.DetailData1.BorderColor = System.Drawing.Color.Transparent
        Me.DetailData1.Borders = DevExpress.XtraPrinting.BorderSide.Left
        Me.DetailData1.BorderWidth = 2.0!
        Me.DetailData1.Font = New System.Drawing.Font("Arial", 8.25!)
        Me.DetailData1.ForeColor = System.Drawing.Color.Black
        Me.DetailData1.Name = "DetailData1"
        Me.DetailData1.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.DetailData1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'DetailData3_Odd
        '
        Me.DetailData3_Odd.BackColor = System.Drawing.Color.FromArgb(CType(CType(231, Byte), Integer), CType(CType(231, Byte), Integer), CType(CType(231, Byte), Integer))
        Me.DetailData3_Odd.BorderColor = System.Drawing.Color.Transparent
        Me.DetailData3_Odd.Borders = DevExpress.XtraPrinting.BorderSide.None
        Me.DetailData3_Odd.BorderWidth = 1.0!
        Me.DetailData3_Odd.Font = New System.Drawing.Font("Arial", 8.25!)
        Me.DetailData3_Odd.ForeColor = System.Drawing.Color.Black
        Me.DetailData3_Odd.Name = "DetailData3_Odd"
        Me.DetailData3_Odd.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.DetailData3_Odd.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'PageInfo
        '
        Me.PageInfo.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold)
        Me.PageInfo.ForeColor = System.Drawing.Color.FromArgb(CType(CType(75, Byte), Integer), CType(CType(75, Byte), Integer), CType(CType(75, Byte), Integer))
        Me.PageInfo.Name = "PageInfo"
        Me.PageInfo.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        '
        'TopMargin
        '
        Me.TopMargin.Name = "TopMargin"
        '
        'BottomMargin
        '
        Me.BottomMargin.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel1, Me.XrLabel2, Me.pageInfo1, Me.pageInfo2})
        Me.BottomMargin.Name = "BottomMargin"
        '
        'pageInfo1
        '
        Me.pageInfo1.Name = "pageInfo1"
        Me.pageInfo1.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime
        Me.pageInfo1.StyleName = "PageInfo"
        '
        'pageInfo2
        '
        Me.pageInfo2.Name = "pageInfo2"
        Me.pageInfo2.StyleName = "PageInfo"
        Me.pageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'ReportHeader
        '
        Me.ReportHeader.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.label1})
        Me.ReportHeader.Name = "ReportHeader"
        '
        'label1
        '
        Me.label1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "")})
        Me.label1.Name = "label1"
        Me.label1.StyleName = "Title"
        Me.label1.StylePriority.UseTextAlignment = False
        Me.label1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter
        '
        'GrpHCountingNo
        '
        Me.GrpHCountingNo.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.table1})
        Me.GrpHCountingNo.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GrpHCountingNo.Name = "GrpHCountingNo"
        '
        'table1
        '
        Me.table1.Name = "table1"
        Me.table1.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.tableRow1})
        '
        'tableRow1
        '
        Me.tableRow1.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.tableCell1, Me.tableCell2, Me.tableCell3, Me.tableCell4, Me.tableCell5, Me.tableCell6, Me.tableCell7, Me.tableCell8, Me.tableCell9, Me.tableCell10, Me.tableCell11})
        Me.tableRow1.Name = "tableRow1"
        '
        'tableCell1
        '
        Me.tableCell1.Borders = DevExpress.XtraPrinting.BorderSide.None
        Me.tableCell1.Name = "tableCell1"
        Me.tableCell1.StyleName = "DetailCaption1"
        Me.tableCell1.StylePriority.UseBorders = False
        Me.tableCell1.StylePriority.UseTextAlignment = False
        Me.tableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell2
        '
        Me.tableCell2.Name = "tableCell2"
        Me.tableCell2.StyleName = "DetailCaption1"
        '
        'tableCell3
        '
        Me.tableCell3.Name = "tableCell3"
        Me.tableCell3.StyleName = "DetailCaption1"
        '
        'tableCell4
        '
        Me.tableCell4.Name = "tableCell4"
        Me.tableCell4.StyleName = "DetailCaption1"
        '
        'tableCell5
        '
        Me.tableCell5.Name = "tableCell5"
        Me.tableCell5.StyleName = "DetailCaption1"
        '
        'tableCell6
        '
        Me.tableCell6.Name = "tableCell6"
        Me.tableCell6.StyleName = "DetailCaption1"
        '
        'tableCell7
        '
        Me.tableCell7.Name = "tableCell7"
        Me.tableCell7.StyleName = "DetailCaption1"
        '
        'tableCell8
        '
        Me.tableCell8.Name = "tableCell8"
        Me.tableCell8.StyleName = "DetailCaption1"
        Me.tableCell8.StylePriority.UseTextAlignment = False
        Me.tableCell8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell9
        '
        Me.tableCell9.Name = "tableCell9"
        Me.tableCell9.StyleName = "DetailCaption1"
        Me.tableCell9.StylePriority.UseTextAlignment = False
        Me.tableCell9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell10
        '
        Me.tableCell10.Name = "tableCell10"
        Me.tableCell10.StyleName = "DetailCaption1"
        Me.tableCell10.StylePriority.UseTextAlignment = False
        Me.tableCell10.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell11
        '
        Me.tableCell11.Name = "tableCell11"
        Me.tableCell11.StyleName = "DetailCaption1"
        '
        'Detail
        '
        Me.Detail.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.table2})
        Me.Detail.Name = "Detail"
        '
        'table2
        '
        Me.table2.Name = "table2"
        Me.table2.OddStyleName = "DetailData3_Odd"
        Me.table2.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.tableRow2})
        '
        'tableRow2
        '
        Me.tableRow2.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.tableCell12, Me.tableCell13, Me.tableCell14, Me.tableCell15, Me.tableCell16, Me.tableCell17, Me.tableCell18, Me.tableCell19, Me.tableCell20, Me.tableCell21, Me.tableCell22})
        Me.tableRow2.Name = "tableRow2"
        '
        'tableCell12
        '
        Me.tableCell12.Borders = DevExpress.XtraPrinting.BorderSide.None
        Me.tableCell12.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ID_COUNT]")})
        Me.tableCell12.Name = "tableCell12"
        Me.tableCell12.StyleName = "DetailData1"
        Me.tableCell12.StylePriority.UseBorders = False
        Me.tableCell12.StylePriority.UseTextAlignment = False
        Me.tableCell12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell13
        '
        Me.tableCell13.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[COUNTING_PREFIX]")})
        Me.tableCell13.Name = "tableCell13"
        Me.tableCell13.StyleName = "DetailData1"
        '
        'tableCell14
        '
        Me.tableCell14.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[COUNTING_NO]")})
        Me.tableCell14.Name = "tableCell14"
        Me.tableCell14.StyleName = "DetailData1"
        '
        'tableCell15
        '
        Me.tableCell15.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[COUNTING_DATE]")})
        Me.tableCell15.Name = "tableCell15"
        Me.tableCell15.StyleName = "DetailData1"
        '
        'tableCell16
        '
        Me.tableCell16.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[DESCRIPTION]")})
        Me.tableCell16.Name = "tableCell16"
        Me.tableCell16.StyleName = "DetailData1"
        '
        'tableCell17
        '
        Me.tableCell17.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ID_ITEM]")})
        Me.tableCell17.Name = "tableCell17"
        Me.tableCell17.StyleName = "DetailData1"
        '
        'tableCell18
        '
        Me.tableCell18.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[SUPP_CURRENTNO]")})
        Me.tableCell18.Name = "tableCell18"
        Me.tableCell18.StyleName = "DetailData1"
        '
        'tableCell19
        '
        Me.tableCell19.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[AVG_PRICE]")})
        Me.tableCell19.Name = "tableCell19"
        Me.tableCell19.StyleName = "DetailData1"
        Me.tableCell19.StylePriority.UseTextAlignment = False
        Me.tableCell19.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell20
        '
        Me.tableCell20.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[SELLING_PRICE]")})
        Me.tableCell20.Name = "tableCell20"
        Me.tableCell20.StyleName = "DetailData1"
        Me.tableCell20.StylePriority.UseTextAlignment = False
        Me.tableCell20.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell21
        '
        Me.tableCell21.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[COST_PRICE1]")})
        Me.tableCell21.Name = "tableCell21"
        Me.tableCell21.StyleName = "DetailData1"
        Me.tableCell21.StylePriority.UseTextAlignment = False
        Me.tableCell21.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'tableCell22
        '
        Me.tableCell22.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[LINE_NO]")})
        Me.tableCell22.Name = "tableCell22"
        Me.tableCell22.StyleName = "DetailData1"
        '
        'IdItem
        '
        Me.IdItem.Name = "IdItem"
        '
        'LineNo
        '
        Me.LineNo.Name = "LineNo"
        '
        'CalculatedField1
        '
        Me.CalculatedField1.DataMember = "USP_FETCH_COUNTING_DEV"
        Me.CalculatedField1.Name = "CalculatedField1"
        Me.CalculatedField1.Scripts.OnGetValue = "CalculatedField1_GetValue"
        '
        'XrLabel2
        '
        Me.XrLabel2.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumSum( [SELLING_PRICE])")})
        Me.XrLabel2.Multiline = True
        Me.XrLabel2.Name = "XrLabel2"
        Me.XrLabel2.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel2.StylePriority.UseTextAlignment = False
        XrSummary1.Running = DevExpress.XtraReports.UI.SummaryRunning.Report
        Me.XrLabel2.Summary = XrSummary1
        Me.XrLabel2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLabel1
        '
        Me.XrLabel1.Multiline = True
        Me.XrLabel1.Name = "XrLabel1"
        Me.XrLabel1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        '
        'rptCountingList
        '
        Me.Bands.AddRange(New DevExpress.XtraReports.UI.Band() {Me.TopMargin, Me.BottomMargin, Me.ReportHeader, Me.GrpHCountingNo, Me.Detail})
        Me.CalculatedFields.AddRange(New DevExpress.XtraReports.UI.CalculatedField() {Me.CalculatedField1})
        Me.ComponentStorage.AddRange(New System.ComponentModel.IComponent() {Me.SqlDataSource1})
        Me.DataMember = "USP_FETCH_COUNTING_DEV"
        Me.DataSource = Me.SqlDataSource1
        Me.Landscape = True
        Me.LocalizationItems.AddRange(New DevExpress.XtraReports.Localization.LocalizationItem() {New DevExpress.XtraReports.Localization.LocalizationItem(Me.BottomMargin, "Default", "HeightF", 52.79164!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.Detail, "Default", "HeightF", 32.33331!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GrpHCountingNo, "Default", "HeightF", 28.0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.label1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(0!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.label1, "Default", "SizeF", New System.Drawing.SizeF(900.0!, 24.19433!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.label1, "Default", "Text", "Counting List English"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.label1, "nb-NO", "Text", "Telleliste"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.pageInfo1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(0!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.pageInfo1, "Default", "SizeF", New System.Drawing.SizeF(450.0!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.pageInfo2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(450.0!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.pageInfo2, "Default", "SizeF", New System.Drawing.SizeF(450.0!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.pageInfo2, "Default", "TextFormatString", "Page {0} of {1}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.ReportHeader, "Default", "HeightF", 60.0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me, "Default", "Font", New System.Drawing.Font("Arial", 9.75!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me, "Default", "Margins", New System.Drawing.Printing.Margins(100, 100, 100, 53)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.table1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(0!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.table1, "Default", "SizeF", New System.Drawing.SizeF(900.0!, 28.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.table2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(0!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.table2, "Default", "SizeF", New System.Drawing.SizeF(900.0!, 25.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell1, "Default", "Text", "ID COUNT"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell1, "nb-NO", "Text", "ID ANTALL"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell1, "Default", "Weight", 0.06983844757080078R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell10, "Default", "Text", "COST PRICE1"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell10, "nb-NO", "Text", "KOSTPRIS 1"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell10, "Default", "Weight", 0.090978130764431425R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell11, "Default", "Text", "LINE NO"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell11, "nb-NO", "Text", "LINJE NR"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell11, "Default", "Weight", 0.060883119371202256R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell12, "Default", "Weight", 0.06983844757080078R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell13, "Default", "Weight", 0.070640885040102561R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell14, "Default", "Weight", 0.086820966736279342R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell15, "Default", "Weight", 0.147197283364128R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell16, "Default", "Weight", 0.11488142272081825R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell17, "Default", "Weight", 0.084177517949799135R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell18, "Default", "Weight", 0.094555460023291141R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell19, "Default", "TextFormatString", "{0:C2}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell19, "Default", "Weight", 0.077533789740668407R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell2, "Default", "Text", "COUNTING PREFIX"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell2, "nb-NO", "Text", "TELLEPREFIKS"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell2, "Default", "Weight", 0.070640884618209554R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell20, "Default", "TextFormatString", "{0:C2}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell20, "Default", "Weight", 0.10249300638834635R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell21, "Default", "TextFormatString", "{0:C2}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell21, "Default", "Weight", 0.090978130764431425R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell22, "Default", "Weight", 0.060883110894097224R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell3, "Default", "Text", "COUNTING NO"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell3, "nb-NO", "Text", "TELLER NR"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell3, "Default", "Weight", 0.0868209666577876R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell4, "Default", "Text", "COUNTING DATE"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell4, "nb-NO", "Text", "TELLEDATO"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell4, "Default", "Weight", 0.14719728367809515R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell5, "Default", "Text", "DESCRIPTION"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell5, "nb-NO", "Text", "BESKRIVELSE"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell5, "Default", "Weight", 0.11488142290723584R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell6, "Default", "Text", "ID ITEM"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell6, "nb-NO", "Text", "ID-VARE"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell6, "Default", "Weight", 0.084177518185274344R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell7, "Default", "Text", "SUPP CURRENTNO"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell7, "Default", "Weight", 0.094555459787815932R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell8, "Default", "Text", "AVG PRICE"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell8, "nb-NO", "Text", "GJENNOMSNITTLIG PRIS"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell8, "Default", "Weight", 0.077533789740668407R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell9, "Default", "Text", "SELLING PRICE"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell9, "nb-NO", "Text", "SALGSPRIS"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableCell9, "Default", "Weight", 0.10249300638834635R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableRow1, "Default", "Weight", 1.0R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.tableRow2, "Default", "Weight", 11.5R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(204.5703!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "SizeF", New System.Drawing.SizeF(100.0!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "Text", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(542.2437!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "SizeF", New System.Drawing.SizeF(221.0812!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "Text", "XrLabel2")})
        Me.PageHeight = 850
        Me.PageWidth = 1100
        Me.Parameters.AddRange(New DevExpress.XtraReports.Parameters.Parameter() {Me.IdItem, Me.LineNo})
        Me.ScriptsSource = "" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "private void CalculatedField1_GetValue(object sender, DevExpress.XtraReports." &
    "UI.GetValueEventArgs e) {" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "    string ad = XrLabel2.Value.ToString();" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "    e.Val" &
    "ue = ad.ToString();" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "}" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10)
        Me.StyleSheet.AddRange(New DevExpress.XtraReports.UI.XRControlStyle() {Me.Title, Me.DetailCaption1, Me.DetailData1, Me.DetailData3_Odd, Me.PageInfo})
        Me.Version = "20.2"
        CType(Me.table1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.table2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me, System.ComponentModel.ISupportInitialize).EndInit()

    End Sub

    Friend WithEvents SqlDataSource1 As DevExpress.DataAccess.Sql.SqlDataSource
    Friend WithEvents Title As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents DetailCaption1 As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents DetailData1 As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents DetailData3_Odd As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents PageInfo As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents TopMargin As DevExpress.XtraReports.UI.TopMarginBand
    Friend WithEvents BottomMargin As DevExpress.XtraReports.UI.BottomMarginBand
    Friend WithEvents pageInfo1 As DevExpress.XtraReports.UI.XRPageInfo
    Friend WithEvents pageInfo2 As DevExpress.XtraReports.UI.XRPageInfo
    Friend WithEvents ReportHeader As DevExpress.XtraReports.UI.ReportHeaderBand
    Friend WithEvents label1 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GrpHCountingNo As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents table1 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents tableRow1 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents tableCell1 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell2 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell3 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell4 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell5 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell6 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell7 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell8 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell9 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell10 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell11 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents Detail As DevExpress.XtraReports.UI.DetailBand
    Friend WithEvents table2 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents tableRow2 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents tableCell12 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell13 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell14 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell15 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell16 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell17 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell18 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell19 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell20 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell21 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell22 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents IdItem As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents LineNo As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents CalculatedField1 As DevExpress.XtraReports.UI.CalculatedField
    Friend WithEvents XrLabel2 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel1 As DevExpress.XtraReports.UI.XRLabel
End Class
