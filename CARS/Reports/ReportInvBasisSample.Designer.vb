<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class ReportInvBasisSample
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(ReportInvBasisSample))
        Dim XrSummary1 As DevExpress.XtraReports.UI.XRSummary = New DevExpress.XtraReports.UI.XRSummary()
        Me.paramInvXml = New DevExpress.XtraReports.Parameters.Parameter()
        Me.paramType = New DevExpress.XtraReports.Parameters.Parameter()
        Me.TopMargin = New DevExpress.XtraReports.UI.TopMarginBand()
        Me.BottomMargin = New DevExpress.XtraReports.UI.BottomMarginBand()
        Me.Detail = New DevExpress.XtraReports.UI.DetailBand()
        Me.XrTable1 = New DevExpress.XtraReports.UI.XRTable()
        Me.XrTableRow1 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell1 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell2 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell3 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell4 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell5 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell6 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.SqlDataSource1 = New DevExpress.DataAccess.Sql.SqlDataSource(Me.components)
        Me.XrPictureBox1 = New DevExpress.XtraReports.UI.XRPictureBox()
        Me.ReportHeader = New DevExpress.XtraReports.UI.ReportHeaderBand()
        Me.PageHeader = New DevExpress.XtraReports.UI.PageHeaderBand()
        Me.XrLabel56 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel2 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrRichText7 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText6 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText5 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText4 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText3 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrPageInfo1 = New DevExpress.XtraReports.UI.XRPageInfo()
        Me.XrLabel1 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLine1 = New DevExpress.XtraReports.UI.XRLine()
        Me.GroupHeaderWONO = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.XrTable2 = New DevExpress.XtraReports.UI.XRTable()
        Me.XrTableRow2 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell7 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell8 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell9 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell10 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell11 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell12 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrCrossBandBox1 = New DevExpress.XtraReports.UI.XRCrossBandBox()
        Me.XpPageSelector1 = New DevExpress.Xpo.XPPageSelector(Me.components)
        Me.GroupHeaderInvoiceNo1 = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.XrLabel54 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel51 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel52 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel53 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel32 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel33 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel25 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel26 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel19 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel31 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel24 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel27 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel28 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel29 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel30 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel17 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel18 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel20 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel21 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel22 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel23 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel10 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel11 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel12 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel13 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel14 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel15 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel16 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel9 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel8 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel7 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel6 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel5 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel4 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel3 = New DevExpress.XtraReports.UI.XRLabel()
        Me.IsInvoiceBasis = New DevExpress.XtraReports.Parameters.Parameter()
        Me.WoNo = New DevExpress.XtraReports.UI.CalculatedField()
        Me.GroupHeaderJOBNO = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.XrLabel49 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel34 = New DevExpress.XtraReports.UI.XRLabel()
        Me.GroupFooter1 = New DevExpress.XtraReports.UI.GroupFooterBand()
        Me.XrLabel50 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel35 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel36 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel37 = New DevExpress.XtraReports.UI.XRLabel()
        Me.ReportFooter = New DevExpress.XtraReports.UI.ReportFooterBand()
        Me.XrLabel43 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel55 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel48 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel47 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel46 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel45 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel44 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel42 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel41 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel40 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel39 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel38 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLine2 = New DevExpress.XtraReports.UI.XRLine()
        Me.REDUCTIONAMTVAT = New DevExpress.XtraReports.UI.CalculatedField()
        Me.PageFooter = New DevExpress.XtraReports.UI.PageFooterBand()
        CType(Me.XrTable1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText7, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText6, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText5, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText4, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrTable2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me, System.ComponentModel.ISupportInitialize).BeginInit()
        '
        'paramInvXml
        '
        Me.paramInvXml.Name = "paramInvXml"
        '
        'paramType
        '
        Me.paramType.Name = "paramType"
        '
        'TopMargin
        '
        Me.TopMargin.Name = "TopMargin"
        '
        'BottomMargin
        '
        Me.BottomMargin.Name = "BottomMargin"
        '
        'Detail
        '
        Me.Detail.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrTable1})
        Me.Detail.Name = "Detail"
        '
        'XrTable1
        '
        Me.XrTable1.Name = "XrTable1"
        Me.XrTable1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96.0!)
        Me.XrTable1.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.XrTableRow1})
        '
        'XrTableRow1
        '
        Me.XrTableRow1.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell1, Me.XrTableCell2, Me.XrTableCell3, Me.XrTableCell4, Me.XrTableCell5, Me.XrTableCell6})
        Me.XrTableRow1.Name = "XrTableRow1"
        '
        'XrTableCell1
        '
        Me.XrTableCell1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[SPAREPARTNO/LABOURID]")})
        Me.XrTableCell1.Multiline = True
        Me.XrTableCell1.Name = "XrTableCell1"
        Me.XrTableCell1.StylePriority.UseFont = False
        Me.XrTableCell1.StylePriority.UseTextAlignment = False
        Me.XrTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrTableCell2
        '
        Me.XrTableCell2.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[SPAREPARTNAME/LABOUR]")})
        Me.XrTableCell2.Multiline = True
        Me.XrTableCell2.Name = "XrTableCell2"
        Me.XrTableCell2.StylePriority.UseFont = False
        '
        'XrTableCell3
        '
        Me.XrTableCell3.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[PRICE]")})
        Me.XrTableCell3.Multiline = True
        Me.XrTableCell3.Name = "XrTableCell3"
        Me.XrTableCell3.StylePriority.UseFont = False
        Me.XrTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell4
        '
        Me.XrTableCell4.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[DELIVEREDQTY/TIME]")})
        Me.XrTableCell4.Multiline = True
        Me.XrTableCell4.Name = "XrTableCell4"
        Me.XrTableCell4.StylePriority.UseFont = False
        Me.XrTableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell5
        '
        Me.XrTableCell5.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[DISCOUNT]")})
        Me.XrTableCell5.Multiline = True
        Me.XrTableCell5.Name = "XrTableCell5"
        Me.XrTableCell5.StylePriority.UseFont = False
        Me.XrTableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell6
        '
        Me.XrTableCell6.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[TOTALAMOUNT]")})
        Me.XrTableCell6.Multiline = True
        Me.XrTableCell6.Name = "XrTableCell6"
        Me.XrTableCell6.StylePriority.UseFont = False
        Me.XrTableCell6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'SqlDataSource1
        '
        Me.SqlDataSource1.ConnectionName = "localhost_CARS"
        Me.SqlDataSource1.Name = "SqlDataSource1"
        StoredProcQuery1.Name = "USP_REP_INVOICE_WORKORDER"
        QueryParameter1.Name = "@INV_NOS_WOSXML"
        QueryParameter1.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter1.Value = New DevExpress.DataAccess.Expression("?paramInvXml", GetType(String))
        QueryParameter2.Name = "@TYPE"
        QueryParameter2.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter2.Value = New DevExpress.DataAccess.Expression("?paramType", GetType(String))
        StoredProcQuery1.Parameters.Add(QueryParameter1)
        StoredProcQuery1.Parameters.Add(QueryParameter2)
        StoredProcQuery1.StoredProcName = "USP_REP_INVOICE_WORKORDER"
        Me.SqlDataSource1.Queries.AddRange(New DevExpress.DataAccess.Sql.SqlQuery() {StoredProcQuery1})
        Me.SqlDataSource1.ResultSchemaSerializable = resources.GetString("SqlDataSource1.ResultSchemaSerializable")
        '
        'XrPictureBox1
        '
        Me.XrPictureBox1.ImageSource = New DevExpress.XtraPrinting.Drawing.ImageSource("img", resources.GetString("XrPictureBox1.ImageSource"))
        Me.XrPictureBox1.Name = "XrPictureBox1"
        Me.XrPictureBox1.Sizing = DevExpress.XtraPrinting.ImageSizeMode.ZoomImage
        '
        'ReportHeader
        '
        Me.ReportHeader.Name = "ReportHeader"
        '
        'PageHeader
        '
        Me.PageHeader.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel56, Me.XrLabel2, Me.XrRichText7, Me.XrRichText6, Me.XrRichText5, Me.XrRichText4, Me.XrRichText3, Me.XrPageInfo1, Me.XrLabel1, Me.XrPictureBox1})
        Me.PageHeader.Name = "PageHeader"
        '
        'XrLabel56
        '
        Me.XrLabel56.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "LocalDateTimeNow()")})
        Me.XrLabel56.Multiline = True
        Me.XrLabel56.Name = "XrLabel56"
        Me.XrLabel56.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel56.StylePriority.UseFont = False
        '
        'XrLabel2
        '
        Me.XrLabel2.Multiline = True
        Me.XrLabel2.Name = "XrLabel2"
        Me.XrLabel2.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel2.StylePriority.UseFont = False
        '
        'XrRichText7
        '
        Me.XrRichText7.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'NO 986870504 MVA'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText7.Name = "XrRichText7"
        Me.XrRichText7.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText7.SerializableRtfString = resources.GetString("XrRichText7.SerializableRtfString")
        Me.XrRichText7.StylePriority.UseFont = False
        '
        'XrRichText6
        '
        Me.XrRichText6.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'Telefon 32242070 Fax 32242071'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText6.Name = "XrRichText6"
        Me.XrRichText6.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText6.SerializableRtfString = resources.GetString("XrRichText6.SerializableRtfString")
        Me.XrRichText6.StylePriority.UseFont = False
        '
        'XrRichText5
        '
        Me.XrRichText5.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'3403 Lier'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText5.Name = "XrRichText5"
        Me.XrRichText5.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText5.SerializableRtfString = resources.GetString("XrRichText5.SerializableRtfString")
        Me.XrRichText5.StylePriority.UseFont = False
        '
        'XrRichText4
        '
        Me.XrRichText4.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'Fossveien 25'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText4.Name = "XrRichText4"
        Me.XrRichText4.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText4.SerializableRtfString = resources.GetString("XrRichText4.SerializableRtfString")
        Me.XrRichText4.StylePriority.UseFont = False
        '
        'XrRichText3
        '
        Me.XrRichText3.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'Cars Software AS'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText3.Name = "XrRichText3"
        Me.XrRichText3.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText3.SerializableRtfString = resources.GetString("XrRichText3.SerializableRtfString")
        Me.XrRichText3.StylePriority.UseFont = False
        '
        'XrPageInfo1
        '
        Me.XrPageInfo1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "ForeColor", "Blue")})
        Me.XrPageInfo1.Name = "XrPageInfo1"
        Me.XrPageInfo1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrPageInfo1.StylePriority.UseFont = False
        '
        'XrLabel1
        '
        Me.XrLabel1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[HEADERTITLE]")})
        Me.XrLabel1.Multiline = True
        Me.XrLabel1.Name = "XrLabel1"
        Me.XrLabel1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel1.StylePriority.UseFont = False
        '
        'XrLine1
        '
        Me.XrLine1.Name = "XrLine1"
        '
        'GroupHeaderWONO
        '
        Me.GroupHeaderWONO.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrTable2})
        Me.GroupHeaderWONO.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("WoNo", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeaderWONO.Level = 1
        Me.GroupHeaderWONO.Name = "GroupHeaderWONO"
        '
        'XrTable2
        '
        Me.XrTable2.Name = "XrTable2"
        Me.XrTable2.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96.0!)
        Me.XrTable2.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.XrTableRow2})
        '
        'XrTableRow2
        '
        Me.XrTableRow2.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell7, Me.XrTableCell8, Me.XrTableCell9, Me.XrTableCell10, Me.XrTableCell11, Me.XrTableCell12})
        Me.XrTableRow2.Name = "XrTableRow2"
        '
        'XrTableCell7
        '
        Me.XrTableCell7.Multiline = True
        Me.XrTableCell7.Name = "XrTableCell7"
        Me.XrTableCell7.StylePriority.UseFont = False
        Me.XrTableCell7.StylePriority.UseTextAlignment = False
        Me.XrTableCell7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrTableCell8
        '
        Me.XrTableCell8.Multiline = True
        Me.XrTableCell8.Name = "XrTableCell8"
        Me.XrTableCell8.StylePriority.UseFont = False
        '
        'XrTableCell9
        '
        Me.XrTableCell9.Multiline = True
        Me.XrTableCell9.Name = "XrTableCell9"
        Me.XrTableCell9.StylePriority.UseFont = False
        Me.XrTableCell9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell10
        '
        Me.XrTableCell10.Multiline = True
        Me.XrTableCell10.Name = "XrTableCell10"
        Me.XrTableCell10.StylePriority.UseFont = False
        Me.XrTableCell10.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell11
        '
        Me.XrTableCell11.Multiline = True
        Me.XrTableCell11.Name = "XrTableCell11"
        Me.XrTableCell11.StylePriority.UseFont = False
        Me.XrTableCell11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell12
        '
        Me.XrTableCell12.Multiline = True
        Me.XrTableCell12.Name = "XrTableCell12"
        Me.XrTableCell12.StylePriority.UseFont = False
        Me.XrTableCell12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrCrossBandBox1
        '
        Me.XrCrossBandBox1.AnchorVertical = CType((DevExpress.XtraReports.UI.VerticalAnchorStyles.Top Or DevExpress.XtraReports.UI.VerticalAnchorStyles.Bottom), DevExpress.XtraReports.UI.VerticalAnchorStyles)
        Me.XrCrossBandBox1.EndBand = Me.GroupHeaderWONO
        Me.XrCrossBandBox1.Name = "XrCrossBandBox1"
        Me.XrCrossBandBox1.StartBand = Me.GroupHeaderWONO
        '
        'GroupHeaderInvoiceNo1
        '
        Me.GroupHeaderInvoiceNo1.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel54, Me.XrLabel51, Me.XrLabel52, Me.XrLabel53, Me.XrLabel32, Me.XrLabel33, Me.XrLabel25, Me.XrLabel26, Me.XrLabel19, Me.XrLabel31, Me.XrLabel24, Me.XrLabel27, Me.XrLabel28, Me.XrLabel29, Me.XrLabel30, Me.XrLabel17, Me.XrLabel18, Me.XrLabel20, Me.XrLabel21, Me.XrLabel22, Me.XrLabel23, Me.XrLabel10, Me.XrLabel11, Me.XrLabel12, Me.XrLabel13, Me.XrLabel14, Me.XrLabel15, Me.XrLabel16, Me.XrLabel9, Me.XrLabel8, Me.XrLabel7})
        Me.GroupHeaderInvoiceNo1.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("INVOICENO", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeaderInvoiceNo1.KeepTogether = True
        Me.GroupHeaderInvoiceNo1.Level = 2
        Me.GroupHeaderInvoiceNo1.Name = "GroupHeaderInvoiceNo1"
        Me.GroupHeaderInvoiceNo1.PageBreak = DevExpress.XtraReports.UI.PageBreak.BeforeBand
        '
        'XrLabel54
        '
        Me.XrLabel54.Multiline = True
        Me.XrLabel54.Name = "XrLabel54"
        Me.XrLabel54.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel54.StylePriority.UseFont = False
        '
        'XrLabel51
        '
        Me.XrLabel51.Multiline = True
        Me.XrLabel51.Name = "XrLabel51"
        Me.XrLabel51.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel51.StylePriority.UseFont = False
        '
        'XrLabel52
        '
        Me.XrLabel52.Multiline = True
        Me.XrLabel52.Name = "XrLabel52"
        Me.XrLabel52.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel52.StylePriority.UseFont = False
        '
        'XrLabel53
        '
        Me.XrLabel53.Multiline = True
        Me.XrLabel53.Name = "XrLabel53"
        Me.XrLabel53.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel53.StylePriority.UseFont = False
        '
        'XrLabel32
        '
        Me.XrLabel32.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[FIRSTREGISTRATIONDATE]")})
        Me.XrLabel32.Multiline = True
        Me.XrLabel32.Name = "XrLabel32"
        Me.XrLabel32.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel32.StylePriority.UseFont = False
        '
        'XrLabel33
        '
        Me.XrLabel33.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[DUEDATE]")})
        Me.XrLabel33.Multiline = True
        Me.XrLabel33.Name = "XrLabel33"
        Me.XrLabel33.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel33.StylePriority.UseFont = False
        '
        'XrLabel25
        '
        Me.XrLabel25.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[INVOICEDATE]")})
        Me.XrLabel25.Multiline = True
        Me.XrLabel25.Name = "XrLabel25"
        Me.XrLabel25.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel25.StylePriority.UseFont = False
        '
        'XrLabel26
        '
        Me.XrLabel26.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[INVOICEDATE]")})
        Me.XrLabel26.Multiline = True
        Me.XrLabel26.Name = "XrLabel26"
        Me.XrLabel26.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel26.StylePriority.UseFont = False
        '
        'XrLabel19
        '
        Me.XrLabel19.Multiline = True
        Me.XrLabel19.Name = "XrLabel19"
        Me.XrLabel19.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel19.StylePriority.UseFont = False
        '
        'XrLabel31
        '
        Me.XrLabel31.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", resources.GetString("XrLabel31.ExpressionBindings"))})
        Me.XrLabel31.Multiline = True
        Me.XrLabel31.Name = "XrLabel31"
        Me.XrLabel31.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel31.StylePriority.UseFont = False
        '
        'XrLabel24
        '
        Me.XrLabel24.Multiline = True
        Me.XrLabel24.Name = "XrLabel24"
        Me.XrLabel24.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        '
        'XrLabel27
        '
        Me.XrLabel27.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[CUSTOMERNAME]")})
        Me.XrLabel27.Multiline = True
        Me.XrLabel27.Name = "XrLabel27"
        Me.XrLabel27.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel27.StylePriority.UseFont = False
        '
        'XrLabel28
        '
        Me.XrLabel28.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Iif(?IsInvoiceBasis,'XXXX',[INVOICENO])")})
        Me.XrLabel28.Multiline = True
        Me.XrLabel28.Name = "XrLabel28"
        Me.XrLabel28.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel28.StylePriority.UseFont = False
        '
        'XrLabel29
        '
        Me.XrLabel29.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER.WORKORDERPREFIX] + [USP_REP_INVOICE_WORKORDER.WORKORDE" &
                    "RNO]")})
        Me.XrLabel29.Multiline = True
        Me.XrLabel29.Name = "XrLabel29"
        Me.XrLabel29.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel29.StylePriority.UseFont = False
        '
        'XrLabel30
        '
        Me.XrLabel30.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[CUSTOMERID]")})
        Me.XrLabel30.Multiline = True
        Me.XrLabel30.Name = "XrLabel30"
        Me.XrLabel30.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel30.StylePriority.UseFont = False
        '
        'XrLabel17
        '
        Me.XrLabel17.Multiline = True
        Me.XrLabel17.Name = "XrLabel17"
        Me.XrLabel17.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel17.StylePriority.UseFont = False
        '
        'XrLabel18
        '
        Me.XrLabel18.Multiline = True
        Me.XrLabel18.Name = "XrLabel18"
        Me.XrLabel18.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel18.StylePriority.UseFont = False
        '
        'XrLabel20
        '
        Me.XrLabel20.Multiline = True
        Me.XrLabel20.Name = "XrLabel20"
        Me.XrLabel20.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel20.StylePriority.UseFont = False
        '
        'XrLabel21
        '
        Me.XrLabel21.Multiline = True
        Me.XrLabel21.Name = "XrLabel21"
        Me.XrLabel21.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel21.StylePriority.UseFont = False
        '
        'XrLabel22
        '
        Me.XrLabel22.Multiline = True
        Me.XrLabel22.Name = "XrLabel22"
        Me.XrLabel22.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel22.StylePriority.UseFont = False
        '
        'XrLabel23
        '
        Me.XrLabel23.Multiline = True
        Me.XrLabel23.Name = "XrLabel23"
        Me.XrLabel23.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel23.StylePriority.UseFont = False
        '
        'XrLabel10
        '
        Me.XrLabel10.Multiline = True
        Me.XrLabel10.Name = "XrLabel10"
        Me.XrLabel10.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        '
        'XrLabel11
        '
        Me.XrLabel11.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[VEHICLEMILEAGE]")})
        Me.XrLabel11.Multiline = True
        Me.XrLabel11.Name = "XrLabel11"
        Me.XrLabel11.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel11.StylePriority.UseFont = False
        '
        'XrLabel12
        '
        Me.XrLabel12.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[VIN]")})
        Me.XrLabel12.Multiline = True
        Me.XrLabel12.Name = "XrLabel12"
        Me.XrLabel12.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel12.StylePriority.UseFont = False
        '
        'XrLabel13
        '
        Me.XrLabel13.Multiline = True
        Me.XrLabel13.Name = "XrLabel13"
        Me.XrLabel13.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        '
        'XrLabel14
        '
        Me.XrLabel14.Multiline = True
        Me.XrLabel14.Name = "XrLabel14"
        Me.XrLabel14.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        '
        'XrLabel15
        '
        Me.XrLabel15.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[VEHICLEREGISTRATIONNO]")})
        Me.XrLabel15.Multiline = True
        Me.XrLabel15.Name = "XrLabel15"
        Me.XrLabel15.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel15.StylePriority.UseFont = False
        '
        'XrLabel16
        '
        Me.XrLabel16.Multiline = True
        Me.XrLabel16.Name = "XrLabel16"
        Me.XrLabel16.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        '
        'XrLabel9
        '
        Me.XrLabel9.Multiline = True
        Me.XrLabel9.Name = "XrLabel9"
        Me.XrLabel9.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel9.StylePriority.UseFont = False
        '
        'XrLabel8
        '
        Me.XrLabel8.Multiline = True
        Me.XrLabel8.Name = "XrLabel8"
        Me.XrLabel8.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel8.StylePriority.UseFont = False
        '
        'XrLabel7
        '
        Me.XrLabel7.Multiline = True
        Me.XrLabel7.Name = "XrLabel7"
        Me.XrLabel7.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel7.StylePriority.UseFont = False
        '
        'XrLabel6
        '
        Me.XrLabel6.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([OWNRISKAMOUNT]==0,False,True)" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrLabel6.Multiline = True
        Me.XrLabel6.Name = "XrLabel6"
        Me.XrLabel6.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel6.StylePriority.UseFont = False
        Me.XrLabel6.StylePriority.UseTextAlignment = False
        Me.XrLabel6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrLabel5
        '
        Me.XrLabel5.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([REDUCTION_AMOUNT]==0,False,True)")})
        Me.XrLabel5.Multiline = True
        Me.XrLabel5.Name = "XrLabel5"
        Me.XrLabel5.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel5.StylePriority.UseFont = False
        Me.XrLabel5.StylePriority.UseTextAlignment = False
        Me.XrLabel5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrLabel4
        '
        Me.XrLabel4.Multiline = True
        Me.XrLabel4.Name = "XrLabel4"
        Me.XrLabel4.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel4.StylePriority.UseFont = False
        Me.XrLabel4.StylePriority.UseTextAlignment = False
        Me.XrLabel4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        '
        'XrLabel3
        '
        Me.XrLabel3.Multiline = True
        Me.XrLabel3.Name = "XrLabel3"
        Me.XrLabel3.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel3.StylePriority.UseFont = False
        '
        'IsInvoiceBasis
        '
        Me.IsInvoiceBasis.AllowNull = True
        Me.IsInvoiceBasis.Name = "IsInvoiceBasis"
        Me.IsInvoiceBasis.Type = GetType(Boolean)
        Me.IsInvoiceBasis.Visible = False
        '
        'WoNo
        '
        Me.WoNo.DataMember = "USP_REP_INVOICE_WORKORDER"
        Me.WoNo.Expression = "[WORKORDERPREFIX]+[WORKORDERNO]"
        Me.WoNo.Name = "WoNo"
        '
        'GroupHeaderJOBNO
        '
        Me.GroupHeaderJOBNO.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel49, Me.XrLabel34})
        Me.GroupHeaderJOBNO.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("JOBNUMBER", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeaderJOBNO.Name = "GroupHeaderJOBNO"
        '
        'XrLabel49
        '
        Me.XrLabel49.Multiline = True
        Me.XrLabel49.Name = "XrLabel49"
        Me.XrLabel49.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel49.StylePriority.UseFont = False
        '
        'XrLabel34
        '
        Me.XrLabel34.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[JOBNUMBER]")})
        Me.XrLabel34.Multiline = True
        Me.XrLabel34.Name = "XrLabel34"
        Me.XrLabel34.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel34.StylePriority.UseFont = False
        '
        'GroupFooter1
        '
        Me.GroupFooter1.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel50, Me.XrLabel35, Me.XrLabel36, Me.XrLabel37, Me.XrLabel4, Me.XrLabel5, Me.XrLabel6})
        Me.GroupFooter1.Name = "GroupFooter1"
        Me.GroupFooter1.PageBreak = DevExpress.XtraReports.UI.PageBreak.AfterBand
        '
        'XrLabel50
        '
        Me.XrLabel50.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[REDUCTIONAMTVAT]")})
        Me.XrLabel50.Multiline = True
        Me.XrLabel50.Name = "XrLabel50"
        Me.XrLabel50.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel50.StylePriority.UseFont = False
        Me.XrLabel50.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLabel35
        '
        Me.XrLabel35.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "sumRunningSum([GARAGEMATERIALAMT])")})
        Me.XrLabel35.Multiline = True
        Me.XrLabel35.Name = "XrLabel35"
        Me.XrLabel35.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel35.StylePriority.UseFont = False
        Me.XrLabel35.StylePriority.UseTextAlignment = False
        XrSummary1.Running = DevExpress.XtraReports.UI.SummaryRunning.Group
        Me.XrLabel35.Summary = XrSummary1
        Me.XrLabel35.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLabel36
        '
        Me.XrLabel36.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[REDUCTION_AMOUNT]"), New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([REDUCTION_AMOUNT]==0,False,True)" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrLabel36.Multiline = True
        Me.XrLabel36.Name = "XrLabel36"
        Me.XrLabel36.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel36.StylePriority.UseFont = False
        '
        'XrLabel37
        '
        Me.XrLabel37.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[OWNRISKAMOUNT]"), New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([OWNRISKAMOUNT]==0,False,True)" & Global.Microsoft.VisualBasic.ChrW(10) & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrLabel37.Multiline = True
        Me.XrLabel37.Name = "XrLabel37"
        Me.XrLabel37.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel37.StylePriority.UseFont = False
        '
        'ReportFooter
        '
        Me.ReportFooter.Name = "ReportFooter"
        '
        'XrLabel43
        '
        Me.XrLabel43.Multiline = True
        Me.XrLabel43.Name = "XrLabel43"
        Me.XrLabel43.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel43.StylePriority.UseFont = False
        '
        'XrLabel55
        '
        Me.XrLabel55.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ROUNDEDAMOUNT]")})
        Me.XrLabel55.Multiline = True
        Me.XrLabel55.Name = "XrLabel55"
        Me.XrLabel55.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel55.StylePriority.UseFont = False
        Me.XrLabel55.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLabel48
        '
        Me.XrLabel48.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[KIDNO]")})
        Me.XrLabel48.Multiline = True
        Me.XrLabel48.Name = "XrLabel48"
        Me.XrLabel48.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel48.StylePriority.UseFont = False
        '
        'XrLabel47
        '
        Me.XrLabel47.Multiline = True
        Me.XrLabel47.Name = "XrLabel47"
        Me.XrLabel47.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel47.StylePriority.UseFont = False
        '
        'XrLabel46
        '
        Me.XrLabel46.Multiline = True
        Me.XrLabel46.Name = "XrLabel46"
        Me.XrLabel46.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel46.StylePriority.UseFont = False
        '
        'XrLabel45
        '
        Me.XrLabel45.Multiline = True
        Me.XrLabel45.Name = "XrLabel45"
        Me.XrLabel45.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel45.StylePriority.UseFont = False
        '
        'XrLabel44
        '
        Me.XrLabel44.Multiline = True
        Me.XrLabel44.Name = "XrLabel44"
        Me.XrLabel44.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel44.StylePriority.UseFont = False
        '
        'XrLabel42
        '
        Me.XrLabel42.Multiline = True
        Me.XrLabel42.Name = "XrLabel42"
        Me.XrLabel42.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel42.StylePriority.UseFont = False
        '
        'XrLabel41
        '
        Me.XrLabel41.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TOTALVATAMOUNT]")})
        Me.XrLabel41.Multiline = True
        Me.XrLabel41.Name = "XrLabel41"
        Me.XrLabel41.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel41.StylePriority.UseFont = False
        '
        'XrLabel40
        '
        Me.XrLabel40.Multiline = True
        Me.XrLabel40.Name = "XrLabel40"
        Me.XrLabel40.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel40.StylePriority.UseFont = False
        '
        'XrLabel39
        '
        Me.XrLabel39.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[INVOICESUM]")})
        Me.XrLabel39.Multiline = True
        Me.XrLabel39.Name = "XrLabel39"
        Me.XrLabel39.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel39.StylePriority.UseFont = False
        '
        'XrLabel38
        '
        Me.XrLabel38.Multiline = True
        Me.XrLabel38.Name = "XrLabel38"
        Me.XrLabel38.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel38.StylePriority.UseFont = False
        '
        'XrLine2
        '
        Me.XrLine2.Name = "XrLine2"
        '
        'REDUCTIONAMTVAT
        '
        Me.REDUCTIONAMTVAT.DataMember = "USP_REP_INVOICE_WORKORDER"
        Me.REDUCTIONAMTVAT.Expression = "[XrLabel35]"
        Me.REDUCTIONAMTVAT.FieldType = DevExpress.XtraReports.UI.FieldType.[Decimal]
        Me.REDUCTIONAMTVAT.Name = "REDUCTIONAMTVAT"
        Me.REDUCTIONAMTVAT.Scripts.OnGetValue = "REDUCTIONAMTVAT_GetValue"
        '
        'PageFooter
        '
        Me.PageFooter.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel43, Me.XrLabel55, Me.XrLabel48, Me.XrLabel47, Me.XrLabel46, Me.XrLabel45, Me.XrLabel44, Me.XrLabel42, Me.XrLabel41, Me.XrLabel40, Me.XrLabel39, Me.XrLabel38, Me.XrLabel3, Me.XrLine1, Me.XrLine2})
        Me.PageFooter.Name = "PageFooter"
        '
        'ReportInvBasisSample
        '
        Me.Bands.AddRange(New DevExpress.XtraReports.UI.Band() {Me.TopMargin, Me.BottomMargin, Me.Detail, Me.ReportHeader, Me.PageHeader, Me.GroupHeaderWONO, Me.GroupHeaderInvoiceNo1, Me.GroupHeaderJOBNO, Me.GroupFooter1, Me.ReportFooter, Me.PageFooter})
        Me.CalculatedFields.AddRange(New DevExpress.XtraReports.UI.CalculatedField() {Me.WoNo, Me.REDUCTIONAMTVAT})
        Me.ComponentStorage.AddRange(New System.ComponentModel.IComponent() {Me.SqlDataSource1, Me.XpPageSelector1})
        Me.CrossBandControls.AddRange(New DevExpress.XtraReports.UI.XRCrossBandControl() {Me.XrCrossBandBox1})
        Me.DataMember = "USP_REP_INVOICE_WORKORDER"
        Me.DataSource = Me.SqlDataSource1
        Me.LocalizationItems.AddRange(New DevExpress.XtraReports.Localization.LocalizationItem() {New DevExpress.XtraReports.Localization.LocalizationItem(Me.BottomMargin, "Default", "HeightF", 46.44782!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.Detail, "Default", "HeightF", 30.69795!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupFooter1, "Default", "HeightF", 62.26037!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupFooter1, "en-US", "HeightF", 55.76541!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupHeaderInvoiceNo1, "Default", "HeightF", 170.6251!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupHeaderJOBNO, "Default", "HeightF", 22.02101!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupHeaderJOBNO, "en-US", "HeightF", 21.64602!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupHeaderWONO, "Default", "HeightF", 46.0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.IsInvoiceBasis, "Default", "Description", "Is Invoice Basis "), New DevExpress.XtraReports.Localization.LocalizationItem(Me.PageFooter, "Default", "HeightF", 150.6146!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.PageHeader, "Default", "HeightF", 183.0832!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.ReportFooter, "Default", "HeightF", 2.676773!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.ReportHeader, "Default", "HeightF", 0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me, "Default", "Font", New System.Drawing.Font("Arial", 9.75!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me, "Default", "Margins", New System.Drawing.Printing.Margins(30, 11, 17, 46)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.TopMargin, "Default", "HeightF", 17.0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrCrossBandBox1, "Default", "EndPointFloat", New DevExpress.Utils.PointFloat(0.00001589457!, 45.95826!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrCrossBandBox1, "Default", "StartPointFloat", New DevExpress.Utils.PointFloat(0.00001589457!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrCrossBandBox1, "Default", "WidthF", 785.9999!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "Font", New System.Drawing.Font("Arial", 11.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(27.08333!, 125.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "SizeF", New System.Drawing.SizeF(160.4167!, 22.99998!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "Text", "XrLabel1"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel10, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 84.12502!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel10, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 48.54171!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 66.33336!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel13, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 123.4584!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel13, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel14, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 30.75006!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel14, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel15, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel15, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 12.00006!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel15, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel15, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel16, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 105.6667!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel16, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 47.58339!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "Default", "Text", "Forfallsdato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "en-US", "Text", "Due Date"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 65.37505!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "Default", "Text", "Reg. dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "en-US", "Text", "Reg. date"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 86.91669!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "Default", "Text", "Referanse"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "en-US", "Text", "Reference"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(227.0833!, 145.0416!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "SizeF", New System.Drawing.SizeF(144.7917!, 22.99999!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "nb-NO", "Text", "Foretaksregistere"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 122.5001!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "Default", "Text", "Kundemotta"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "en-US", "Text", "Customer service"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 29.79174!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "Default", "Text", "Faktura nr"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "en-US", "Text", "Invoice No"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 11.04174!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "Default", "Text", "Ordrenr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "en-US", "Text", "Order no."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 104.7084!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "Default", "Text", "Kundenr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "en-US", "Text", "Customer no."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel24, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(543.3336!, 86.91673!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel24, "Default", "SizeF", New System.Drawing.SizeF(98.33313!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(653.7504!, 10.00004!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "SizeF", New System.Drawing.SizeF(118.7499!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "TextFormatString", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(653.7504!, 27.79169!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "SizeF", New System.Drawing.SizeF(116.6666!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "Text", "XXXX"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "TextFormatString", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(543.3336!, 122.5001!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "Default", "SizeF", New System.Drawing.SizeF(157.7082!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel28, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel28, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(543.3336!, 29.79174!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel28, "Default", "SizeF", New System.Drawing.SizeF(98.33319!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel28, "Default", "Text", "XXXX"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel29, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel29, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(543.3336!, 11.04174!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel29, "Default", "SizeF", New System.Drawing.SizeF(98.33313!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel29, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(30.20835!, 24.65623!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "Default", "SizeF", New System.Drawing.SizeF(42.70833!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "Default", "Text", "NOK"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel30, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel30, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(543.3336!, 104.7084!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel30, "Default", "SizeF", New System.Drawing.SizeF(98.33319!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel30, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "Font", New System.Drawing.Font("Arial", 11.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(10.00001!, 10.00004!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "SizeF", New System.Drawing.SizeF(165.0!, 148.25!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "Text", "CustomerDetails"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(653.7504!, 65.37505!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "SizeF", New System.Drawing.SizeF(116.6666!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "Text", "XXXX"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "TextFormatString", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(653.7504!, 47.58339!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "SizeF", New System.Drawing.SizeF(118.7499!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "TextFormatString", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(42.70829!, 2.427071!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(49.54648!, 2.427101!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "Default", "SizeF", New System.Drawing.SizeF(58.08334!, 17.16687!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel35, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel35, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel35, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(690.9278!, 4.44266!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel35, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(690.9278!, 1.195211!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel35, "Default", "SizeF", New System.Drawing.SizeF(85.07214!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(690.9278!, 22.23434!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(690.9278!, 18.98689!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "Default", "SizeF", New System.Drawing.SizeF(85.07214!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "Default", "Text", "Reduction Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(690.9278!, 40.02597!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(690.9278!, 36.77852!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "Default", "SizeF", New System.Drawing.SizeF(85.07214!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "Default", "Text", "Own Risk Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(72.91668!, 24.65623!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "SizeF", New System.Drawing.SizeF(102.0834!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "Text", "Nettobelop :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "en-US", "Text", "Net amount :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel39, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel39, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel39, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(188.5417!, 24.65623!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel39, "Default", "SizeF", New System.Drawing.SizeF(96.875!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(27.08331!, 4.442736!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(27.08331!, 1.195288!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "Default", "SizeF", New System.Drawing.SizeF(135.4167!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "Default", "Text", "Verkstedmatriell"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "en-US", "Text", "Garage Material"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(302.5042!, 24.65623!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "SizeF", New System.Drawing.SizeF(95.38751!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "Text", "MVA belop :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "en-US", "Text", "MVA amount :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(419.8333!, 24.65623!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "Default", "SizeF", New System.Drawing.SizeF(123.5003!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(557.2918!, 24.65623!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "SizeF", New System.Drawing.SizeF(98.84442!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "Text", "A BETALE :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "en-US", "Text", "TO PAY :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(653.7504!, 79.33356!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "SizeF", New System.Drawing.SizeF(104.3754!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "Text", "Totals"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "en-US", "Visible", False), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(30.20841!, 95.91681!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "SizeF", New System.Drawing.SizeF(180.2084!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "Text", "Swift no.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(30.20841!, 79.33356!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "SizeF", New System.Drawing.SizeF(180.2084!, 16.58326!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "Text", "Betales til kontonr.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "en-US", "Text", "Paid to account no.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(302.5042!, 95.91681!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "SizeF", New System.Drawing.SizeF(102.0834!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "Text", "Iban no.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(302.5042!, 79.33356!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "SizeF", New System.Drawing.SizeF(102.0834!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "Text", "Kidnummer:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "en-US", "Text", "Kid number:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(419.8333!, 79.33356!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "SizeF", New System.Drawing.SizeF(188.5419!, 16.58326!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "Text", "Nettobelop :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 2.427071!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 3.031301!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "SizeF", New System.Drawing.SizeF(31.24999!, 15.95847!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "en-US", "SizeF", New System.Drawing.SizeF(38.08819!, 15.95847!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "Text", "JOB"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(27.08331!, 22.23436!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(27.08331!, 18.98691!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "Default", "SizeF", New System.Drawing.SizeF(135.4167!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "Default", "Text", "Reduction Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 10.00001!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(292.8206!, 6.752561!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "SizeF", New System.Drawing.SizeF(100.0!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "Text", "XrLabel50"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(195.8333!, 29.79174!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "Default", "Text", "Refnr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel52, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel52, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(195.8333!, 47.58346!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel52, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel52, "Default", "Text", "Km. stand"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(195.8333!, 12.00006!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "Default", "SizeF", New System.Drawing.SizeF(89.58333!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "Default", "Text", "Regnr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "en-US", "Text", "Reg no."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "nb-NO", "Text", "Regnr ."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(195.8333!, 65.37505!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "Default", "Text", "Ch.nr"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "en-US", "Text", "Ch.no"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(672.5003!, 24.65623!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "Default", "SizeF", New System.Drawing.SizeF(100.0!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "Default", "Text", "XrLabel55"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(455.8336!, 145.0416!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "SizeF", New System.Drawing.SizeF(144.7917!, 22.99999!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(27.08331!, 40.02598!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "en-US", "LocationFloat", New DevExpress.Utils.PointFloat(27.08331!, 36.77853!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "Default", "SizeF", New System.Drawing.SizeF(135.4167!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "Default", "Text", "Own Risk Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(195.8333!, 86.91669!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "Default", "SizeF", New System.Drawing.SizeF(89.58333!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "Default", "Text", "Rekv. Nr"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(195.8333!, 104.7084!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "Default", "Text", "Lev. Dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(195.8333!, 122.5001!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "Default", "Text", "Rep. dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(10.00001!, 1.656214!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine1, "Default", "SizeF", New System.Drawing.SizeF(760.417!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(9.999974!, 41.23948!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine2, "Default", "SizeF", New System.Drawing.SizeF(760.417!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(666.0416!, 145.0416!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "SizeF", New System.Drawing.SizeF(104.3754!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "TextFormatString", "Page {0} of {1}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPictureBox1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(27.08329!, 10.00001!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPictureBox1, "Default", "SizeF", New System.Drawing.SizeF(223.9585!, 112.5833!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText3, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText3, "en-US", "Font", New System.Drawing.Font("Arial", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText3, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(501.0416!, 23.20838!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText3, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText4, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText4, "en-US", "Font", New System.Drawing.Font("Arial", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText4, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(501.0416!, 43.08338!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText4, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText5, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText5, "en-US", "Font", New System.Drawing.Font("Arial", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText5, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(501.0416!, 62.95837!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText5, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87499!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText6, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText6, "en-US", "Font", New System.Drawing.Font("Arial", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText6, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(501.0416!, 82.83335!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText6, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText7, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText7, "en-US", "Font", New System.Drawing.Font("Arial", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText7, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(501.0416!, 102.7083!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText7, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(9.999978!, 2.848975!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable1, "Default", "SizeF", New System.Drawing.SizeF(765.9999!, 25.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(10.00001!, 9.999974!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable2, "Default", "SizeF", New System.Drawing.SizeF(765.9999!, 25.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell1, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell1, "Default", "Text", "XrTableCell1"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell1, "Default", "Weight", 1.6723922471493351R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "Default", "Text", "Antal"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "en-US", "Text", "Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "Default", "Weight", 2.0R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "Default", "Text", "Rabatt"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "en-US", "Text", "Discount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "Default", "Weight", 2.0R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell12, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell12, "en-US", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell12, "Default", "Text", "Sum"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell12, "Default", "Weight", 1.8208361641573025R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell2, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell2, "Default", "Text", "XrTableCell2"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell2, "Default", "Weight", 2.7933226757348661R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell3, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell3, "Default", "Text", "XrTableCell3"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell3, "Default", "Weight", 1.3816138799236486R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell4, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell4, "Default", "Text", "XrTableCell4"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell4, "Default", "Weight", 2.0R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell5, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell5, "Default", "Text", "XrTableCell5"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell5, "Default", "TextFormatString", "{0}%"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell5, "Default", "Weight", 2.0173479632388176R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell6, "Default", "Font", New System.Drawing.Font("Arial", 10.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell6, "Default", "Text", "XrTableCell6"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell6, "Default", "Weight", 1.8299802691805907R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "Default", "Text", "Beskrivelse"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "en-US", "Text", "Description"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "Default", "Weight", 1.6413222731538688R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell8, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell8, "Default", "Weight", 2.78935837145151R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "Default", "Font", New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "Default", "Text", "Pris"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "en-US", "Text", "Price"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "Default", "Weight", 1.3847038299288759R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableRow1, "Default", "Weight", 11.5R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableRow2, "Default", "Weight", 11.5R)})
        Me.Parameters.AddRange(New DevExpress.XtraReports.Parameters.Parameter() {Me.paramInvXml, Me.paramType, Me.IsInvoiceBasis})
        Me.Version = "21.2"
        CType(Me.XrTable1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText7, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText6, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText5, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText4, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrTable2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me, System.ComponentModel.ISupportInitialize).EndInit()

    End Sub

    Friend WithEvents paramInvXml As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents paramType As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents TopMargin As DevExpress.XtraReports.UI.TopMarginBand
    Friend WithEvents BottomMargin As DevExpress.XtraReports.UI.BottomMarginBand
    Friend WithEvents Detail As DevExpress.XtraReports.UI.DetailBand
    Friend WithEvents SqlDataSource1 As DevExpress.DataAccess.Sql.SqlDataSource
    Friend WithEvents XrTable1 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents XrTableRow1 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents XrTableCell1 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell2 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell3 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell4 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell5 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell6 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrPictureBox1 As DevExpress.XtraReports.UI.XRPictureBox
    Friend WithEvents ReportHeader As DevExpress.XtraReports.UI.ReportHeaderBand
    Friend WithEvents PageHeader As DevExpress.XtraReports.UI.PageHeaderBand
    Friend WithEvents XrLine1 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrRichText7 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText6 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText5 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText4 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText3 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrPageInfo1 As DevExpress.XtraReports.UI.XRPageInfo
    Friend WithEvents XrLabel1 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GroupHeaderWONO As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents XrTable2 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents XrTableRow2 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents XrTableCell7 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell8 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell9 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell10 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell11 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell12 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrCrossBandBox1 As DevExpress.XtraReports.UI.XRCrossBandBox
    Friend WithEvents XpPageSelector1 As DevExpress.Xpo.XPPageSelector
    Friend WithEvents XrLabel2 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GroupHeaderInvoiceNo1 As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents XrLabel31 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel24 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel27 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel28 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel29 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel30 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel17 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel18 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel19 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel20 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel21 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel22 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel23 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel10 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel11 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel12 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel13 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel14 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel15 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel16 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel9 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel8 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel7 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel6 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel5 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel4 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel3 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel32 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel33 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel25 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel26 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents IsInvoiceBasis As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents WoNo As DevExpress.XtraReports.UI.CalculatedField
    Friend WithEvents GroupHeaderJOBNO As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents XrLabel34 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GroupFooter1 As DevExpress.XtraReports.UI.GroupFooterBand
    Friend WithEvents XrLabel35 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel36 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel37 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents ReportFooter As DevExpress.XtraReports.UI.ReportFooterBand
    Friend WithEvents XrLine2 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLabel43 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel42 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel41 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel40 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel39 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel38 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel48 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel47 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel46 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel45 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel44 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel49 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents REDUCTIONAMTVAT As DevExpress.XtraReports.UI.CalculatedField
    Friend WithEvents XrLabel50 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel54 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel51 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel52 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel53 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel55 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel56 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents PageFooter As DevExpress.XtraReports.UI.PageFooterBand
End Class
