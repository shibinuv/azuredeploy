<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Public Class dxWorkOrderInvoice
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(dxWorkOrderInvoice))
        Dim XrSummary1 As DevExpress.XtraReports.UI.XRSummary = New DevExpress.XtraReports.UI.XRSummary()
        Dim XrSummary2 As DevExpress.XtraReports.UI.XRSummary = New DevExpress.XtraReports.UI.XRSummary()
        Me.paramInvXml = New DevExpress.XtraReports.Parameters.Parameter()
        Me.paramType = New DevExpress.XtraReports.Parameters.Parameter()
        Me.TopMargin = New DevExpress.XtraReports.UI.TopMarginBand()
        Me.BottomMargin = New DevExpress.XtraReports.UI.BottomMarginBand()
        Me.Detail = New DevExpress.XtraReports.UI.DetailBand()
        Me.XrLabel3 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrTable1 = New DevExpress.XtraReports.UI.XRTable()
        Me.XrTableRow1 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell1 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell2 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell3 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell4 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell5 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.SqlDataSource1 = New DevExpress.DataAccess.Sql.SqlDataSource(Me.components)
        Me.ReportHeader = New DevExpress.XtraReports.UI.ReportHeaderBand()
        Me.PageHeader = New DevExpress.XtraReports.UI.PageHeaderBand()
        Me.XrLabel2 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel1 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLine3 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrPageInfo1 = New DevExpress.XtraReports.UI.XRPageInfo()
        Me.XrLabel56 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrPictureBox1 = New DevExpress.XtraReports.UI.XRPictureBox()
        Me.XrRichText6 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText4 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText5 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText3 = New DevExpress.XtraReports.UI.XRRichText()
        Me.XrRichText7 = New DevExpress.XtraReports.UI.XRRichText()
        Me.GroupHeaderInvoiceNoA = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.XrLabel22 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel29 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel33 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel8 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel9 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel16 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel15 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel14 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel13 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel12 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel11 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel10 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel23 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel21 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel20 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel18 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel17 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel30 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel28 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel27 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel24 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel31 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel19 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel26 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel7 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel32 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel53 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel52 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel51 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel54 = New DevExpress.XtraReports.UI.XRLabel()
        Me.GroupHeaderWONO = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.XrLabel50 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel43 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrTable2 = New DevExpress.XtraReports.UI.XRTable()
        Me.XrTableRow2 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.XrTableCell7 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell8 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell9 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell10 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell11 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrTableCell12 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.XrCrossBandBox1 = New DevExpress.XtraReports.UI.XRCrossBandBox()
        Me.GroupHeaderJOBNO = New DevExpress.XtraReports.UI.GroupHeaderBand()
        Me.XrLabel49 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel34 = New DevExpress.XtraReports.UI.XRLabel()
        Me.GroupFooter1 = New DevExpress.XtraReports.UI.GroupFooterBand()
        Me.XrLabel37 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel5 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel4 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel6 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel36 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel35 = New DevExpress.XtraReports.UI.XRLabel()
        Me.PageFooter = New DevExpress.XtraReports.UI.PageFooterBand()
        Me.XrLabel41 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLine1 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLine2 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLabel25 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel38 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel39 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel40 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel42 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel44 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel45 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel46 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel47 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel48 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel55 = New DevExpress.XtraReports.UI.XRLabel()
        Me.ReportFooter = New DevExpress.XtraReports.UI.ReportFooterBand()
        Me.UnitOfWork1 = New DevExpress.Xpo.UnitOfWork(Me.components)
        Me.UnitOfWork2 = New DevExpress.Xpo.UnitOfWork(Me.components)
        Me.UnitOfWork3 = New DevExpress.Xpo.UnitOfWork(Me.components)
        Me.RPT_NO_OF_DIGITS = New DevExpress.XtraReports.Parameters.Parameter()
        Me.GroupFooter2 = New DevExpress.XtraReports.UI.GroupFooterBand()
        Me.GroupFooter3 = New DevExpress.XtraReports.UI.GroupFooterBand()
        CType(Me.XrTable1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText6, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText4, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText5, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrRichText7, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.XrTable2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.UnitOfWork1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.UnitOfWork2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.UnitOfWork3, System.ComponentModel.ISupportInitialize).BeginInit()
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
        Me.Detail.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel3, Me.XrTable1})
        Me.Detail.KeepTogether = True
        Me.Detail.Name = "Detail"
        '
        'XrLabel3
        '
        Me.XrLabel3.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([TOTALAMOUNT],?RPT_NO_OF_DIGITS)")})
        Me.XrLabel3.Multiline = True
        Me.XrLabel3.Name = "XrLabel3"
        Me.XrLabel3.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel3.StylePriority.UseTextAlignment = False
        Me.XrLabel3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTable1
        '
        Me.XrTable1.Name = "XrTable1"
        Me.XrTable1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96.0!)
        Me.XrTable1.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.XrTableRow1})
        '
        'XrTableRow1
        '
        Me.XrTableRow1.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.XrTableCell1, Me.XrTableCell2, Me.XrTableCell3, Me.XrTableCell4, Me.XrTableCell5})
        Me.XrTableRow1.Name = "XrTableRow1"
        '
        'XrTableCell1
        '
        Me.XrTableCell1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[SPAREPARTNO/LABOURID]")})
        Me.XrTableCell1.Multiline = True
        Me.XrTableCell1.Name = "XrTableCell1"
        '
        'XrTableCell2
        '
        Me.XrTableCell2.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER].[SPAREPARTNAME/LABOUR]")})
        Me.XrTableCell2.Multiline = True
        Me.XrTableCell2.Name = "XrTableCell2"
        '
        'XrTableCell3
        '
        Me.XrTableCell3.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([USP_REP_INVOICE_WORKORDER].[PRICE],?RPT_NO_OF_DIGITS)")})
        Me.XrTableCell3.Multiline = True
        Me.XrTableCell3.Name = "XrTableCell3"
        Me.XrTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell4
        '
        Me.XrTableCell4.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([USP_REP_INVOICE_WORKORDER].[DELIVEREDQTY/TIME],?RPT_NO_OF_DIGITS)")})
        Me.XrTableCell4.Multiline = True
        Me.XrTableCell4.Name = "XrTableCell4"
        Me.XrTableCell4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrTableCell5
        '
        Me.XrTableCell5.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([USP_REP_INVOICE_WORKORDER].[DISCOUNT],?RPT_NO_OF_DIGITS)")})
        Me.XrTableCell5.Multiline = True
        Me.XrTableCell5.Name = "XrTableCell5"
        Me.XrTableCell5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
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
        'ReportHeader
        '
        Me.ReportHeader.Name = "ReportHeader"
        '
        'PageHeader
        '
        Me.PageHeader.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel2, Me.XrLabel1, Me.XrLine3, Me.XrPageInfo1, Me.XrLabel56, Me.XrPictureBox1, Me.XrRichText6, Me.XrRichText4, Me.XrRichText5, Me.XrRichText3, Me.XrRichText7})
        Me.PageHeader.Name = "PageHeader"
        '
        'XrLabel2
        '
        Me.XrLabel2.Multiline = True
        Me.XrLabel2.Name = "XrLabel2"
        Me.XrLabel2.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel2.StylePriority.UseFont = False
        '
        'XrLabel1
        '
        Me.XrLabel1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[HEADERTITLE]")})
        Me.XrLabel1.Multiline = True
        Me.XrLabel1.Name = "XrLabel1"
        Me.XrLabel1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel1.StylePriority.UseFont = False
        '
        'XrLine3
        '
        Me.XrLine3.Name = "XrLine3"
        '
        'XrPageInfo1
        '
        Me.XrPageInfo1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "ForeColor", "Blue")})
        Me.XrPageInfo1.Name = "XrPageInfo1"
        Me.XrPageInfo1.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrPageInfo1.StylePriority.UseFont = False
        '
        'XrLabel56
        '
        Me.XrLabel56.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "LocalDateTimeNow()")})
        Me.XrLabel56.Multiline = True
        Me.XrLabel56.Name = "XrLabel56"
        Me.XrLabel56.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel56.StylePriority.UseFont = False
        '
        'XrPictureBox1
        '
        Me.XrPictureBox1.ImageSource = New DevExpress.XtraPrinting.Drawing.ImageSource("img", resources.GetString("XrPictureBox1.ImageSource"))
        Me.XrPictureBox1.Name = "XrPictureBox1"
        Me.XrPictureBox1.Sizing = DevExpress.XtraPrinting.ImageSizeMode.ZoomImage
        '
        'XrRichText6
        '
        Me.XrRichText6.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'Telefon 32242070 Fax 32242071'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText6.Name = "XrRichText6"
        Me.XrRichText6.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText6.SerializableRtfString = resources.GetString("XrRichText6.SerializableRtfString")
        Me.XrRichText6.StylePriority.UseFont = False
        '
        'XrRichText4
        '
        Me.XrRichText4.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'Fossveien 25'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText4.Name = "XrRichText4"
        Me.XrRichText4.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText4.SerializableRtfString = resources.GetString("XrRichText4.SerializableRtfString")
        Me.XrRichText4.StylePriority.UseFont = False
        '
        'XrRichText5
        '
        Me.XrRichText5.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'3403 Lier'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText5.Name = "XrRichText5"
        Me.XrRichText5.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText5.SerializableRtfString = resources.GetString("XrRichText5.SerializableRtfString")
        Me.XrRichText5.StylePriority.UseFont = False
        '
        'XrRichText3
        '
        Me.XrRichText3.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'Cars Software AS'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText3.Name = "XrRichText3"
        Me.XrRichText3.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText3.SerializableRtfString = resources.GetString("XrRichText3.SerializableRtfString")
        Me.XrRichText3.StylePriority.UseFont = False
        '
        'XrRichText7
        '
        Me.XrRichText7.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "'<b>'+'NO 986870504 MVA'+'</b>'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrRichText7.Name = "XrRichText7"
        Me.XrRichText7.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrRichText7.SerializableRtfString = resources.GetString("XrRichText7.SerializableRtfString")
        Me.XrRichText7.StylePriority.UseFont = False
        '
        'GroupHeaderInvoiceNoA
        '
        Me.GroupHeaderInvoiceNoA.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel22, Me.XrLabel29, Me.XrLabel33, Me.XrLabel8, Me.XrLabel9, Me.XrLabel16, Me.XrLabel15, Me.XrLabel14, Me.XrLabel13, Me.XrLabel12, Me.XrLabel11, Me.XrLabel10, Me.XrLabel23, Me.XrLabel21, Me.XrLabel20, Me.XrLabel18, Me.XrLabel17, Me.XrLabel30, Me.XrLabel28, Me.XrLabel27, Me.XrLabel24, Me.XrLabel31, Me.XrLabel19, Me.XrLabel26, Me.XrLabel7, Me.XrLabel32, Me.XrLabel53, Me.XrLabel52, Me.XrLabel51, Me.XrLabel54})
        Me.GroupHeaderInvoiceNoA.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("INVOICENO", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeaderInvoiceNoA.KeepTogether = True
        Me.GroupHeaderInvoiceNoA.Level = 2
        Me.GroupHeaderInvoiceNoA.Name = "GroupHeaderInvoiceNoA"
        Me.GroupHeaderInvoiceNoA.PageBreak = DevExpress.XtraReports.UI.PageBreak.BeforeBand
        '
        'XrLabel22
        '
        Me.XrLabel22.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "false" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrLabel22.Multiline = True
        Me.XrLabel22.Name = "XrLabel22"
        Me.XrLabel22.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel22.StylePriority.UseFont = False
        '
        'XrLabel29
        '
        Me.XrLabel29.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[USP_REP_INVOICE_WORKORDER.WORKORDERPREFIX] + [USP_REP_INVOICE_WORKORDER.WORKORDE" &
                    "RNO]"), New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "false")})
        Me.XrLabel29.Multiline = True
        Me.XrLabel29.Name = "XrLabel29"
        Me.XrLabel29.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel29.StylePriority.UseFont = False
        '
        'XrLabel33
        '
        Me.XrLabel33.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Substring([DUEDATE],0,10)" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrLabel33.Multiline = True
        Me.XrLabel33.Name = "XrLabel33"
        Me.XrLabel33.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel33.StylePriority.UseFont = False
        '
        'XrLabel8
        '
        Me.XrLabel8.Multiline = True
        Me.XrLabel8.Name = "XrLabel8"
        Me.XrLabel8.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel8.StylePriority.UseFont = False
        '
        'XrLabel9
        '
        Me.XrLabel9.Multiline = True
        Me.XrLabel9.Name = "XrLabel9"
        Me.XrLabel9.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel9.StylePriority.UseFont = False
        '
        'XrLabel16
        '
        Me.XrLabel16.Multiline = True
        Me.XrLabel16.Name = "XrLabel16"
        Me.XrLabel16.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel16.StylePriority.UseFont = False
        '
        'XrLabel15
        '
        Me.XrLabel15.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[VEHICLEREGISTRATIONNO]")})
        Me.XrLabel15.Multiline = True
        Me.XrLabel15.Name = "XrLabel15"
        Me.XrLabel15.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel15.StylePriority.UseFont = False
        '
        'XrLabel14
        '
        Me.XrLabel14.Multiline = True
        Me.XrLabel14.Name = "XrLabel14"
        Me.XrLabel14.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel14.StylePriority.UseFont = False
        '
        'XrLabel13
        '
        Me.XrLabel13.Multiline = True
        Me.XrLabel13.Name = "XrLabel13"
        Me.XrLabel13.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel13.StylePriority.UseFont = False
        '
        'XrLabel12
        '
        Me.XrLabel12.Multiline = True
        Me.XrLabel12.Name = "XrLabel12"
        Me.XrLabel12.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel12.StylePriority.UseFont = False
        '
        'XrLabel11
        '
        Me.XrLabel11.Multiline = True
        Me.XrLabel11.Name = "XrLabel11"
        Me.XrLabel11.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel11.StylePriority.UseFont = False
        '
        'XrLabel10
        '
        Me.XrLabel10.Multiline = True
        Me.XrLabel10.Name = "XrLabel10"
        Me.XrLabel10.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel10.StylePriority.UseFont = False
        '
        'XrLabel23
        '
        Me.XrLabel23.Multiline = True
        Me.XrLabel23.Name = "XrLabel23"
        Me.XrLabel23.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel23.StylePriority.UseFont = False
        '
        'XrLabel21
        '
        Me.XrLabel21.Multiline = True
        Me.XrLabel21.Name = "XrLabel21"
        Me.XrLabel21.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel21.StylePriority.UseFont = False
        '
        'XrLabel20
        '
        Me.XrLabel20.Multiline = True
        Me.XrLabel20.Name = "XrLabel20"
        Me.XrLabel20.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel20.StylePriority.UseFont = False
        '
        'XrLabel18
        '
        Me.XrLabel18.Multiline = True
        Me.XrLabel18.Name = "XrLabel18"
        Me.XrLabel18.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel18.StylePriority.UseFont = False
        '
        'XrLabel17
        '
        Me.XrLabel17.Multiline = True
        Me.XrLabel17.Name = "XrLabel17"
        Me.XrLabel17.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel17.StylePriority.UseFont = False
        '
        'XrLabel30
        '
        Me.XrLabel30.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[CUSTOMERID]")})
        Me.XrLabel30.Multiline = True
        Me.XrLabel30.Name = "XrLabel30"
        Me.XrLabel30.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel30.StylePriority.UseFont = False
        '
        'XrLabel28
        '
        Me.XrLabel28.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Bookmark", "[INVOICENO]"), New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[INVOICENO]")})
        Me.XrLabel28.Multiline = True
        Me.XrLabel28.Name = "XrLabel28"
        Me.XrLabel28.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel28.StylePriority.UseFont = False
        '
        'XrLabel27
        '
        Me.XrLabel27.Multiline = True
        Me.XrLabel27.Name = "XrLabel27"
        Me.XrLabel27.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel27.StylePriority.UseFont = False
        '
        'XrLabel24
        '
        Me.XrLabel24.Multiline = True
        Me.XrLabel24.Name = "XrLabel24"
        Me.XrLabel24.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel24.StylePriority.UseFont = False
        '
        'XrLabel31
        '
        Me.XrLabel31.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", resources.GetString("XrLabel31.ExpressionBindings"))})
        Me.XrLabel31.Multiline = True
        Me.XrLabel31.Name = "XrLabel31"
        Me.XrLabel31.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel31.StylePriority.UseFont = False
        '
        'XrLabel19
        '
        Me.XrLabel19.Multiline = True
        Me.XrLabel19.Name = "XrLabel19"
        Me.XrLabel19.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel19.StylePriority.UseFont = False
        '
        'XrLabel26
        '
        Me.XrLabel26.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Substring([INVOICEDATE],0,10)" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrLabel26.Multiline = True
        Me.XrLabel26.Name = "XrLabel26"
        Me.XrLabel26.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel26.StylePriority.UseFont = False
        '
        'XrLabel7
        '
        Me.XrLabel7.Multiline = True
        Me.XrLabel7.Name = "XrLabel7"
        Me.XrLabel7.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel7.StylePriority.UseFont = False
        '
        'XrLabel32
        '
        Me.XrLabel32.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Substring([FIRSTREGISTRATIONDATE],0,10 )")})
        Me.XrLabel32.Multiline = True
        Me.XrLabel32.Name = "XrLabel32"
        Me.XrLabel32.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel32.StylePriority.UseFont = False
        '
        'XrLabel53
        '
        Me.XrLabel53.Multiline = True
        Me.XrLabel53.Name = "XrLabel53"
        Me.XrLabel53.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel53.StylePriority.UseFont = False
        '
        'XrLabel52
        '
        Me.XrLabel52.Multiline = True
        Me.XrLabel52.Name = "XrLabel52"
        Me.XrLabel52.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel52.StylePriority.UseFont = False
        '
        'XrLabel51
        '
        Me.XrLabel51.Multiline = True
        Me.XrLabel51.Name = "XrLabel51"
        Me.XrLabel51.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel51.StylePriority.UseFont = False
        '
        'XrLabel54
        '
        Me.XrLabel54.Multiline = True
        Me.XrLabel54.Name = "XrLabel54"
        Me.XrLabel54.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel54.StylePriority.UseFont = False
        '
        'GroupHeaderWONO
        '
        Me.GroupHeaderWONO.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel50, Me.XrLabel43, Me.XrTable2})
        Me.GroupHeaderWONO.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("WORKORDERNO", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeaderWONO.KeepTogether = True
        Me.GroupHeaderWONO.Level = 1
        Me.GroupHeaderWONO.Name = "GroupHeaderWONO"
        '
        'XrLabel50
        '
        Me.XrLabel50.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ORDERDATE]")})
        Me.XrLabel50.Multiline = True
        Me.XrLabel50.Name = "XrLabel50"
        Me.XrLabel50.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel50.StylePriority.UseFont = False
        '
        'XrLabel43
        '
        Me.XrLabel43.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[WORKORDERPREFIX]+[WORKORDERNO]")})
        Me.XrLabel43.Multiline = True
        Me.XrLabel43.Name = "XrLabel43"
        Me.XrLabel43.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel43.StylePriority.UseFont = False
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
        Me.XrTableCell12.StylePriority.UseTextAlignment = False
        Me.XrTableCell12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrCrossBandBox1
        '
        Me.XrCrossBandBox1.AnchorVertical = CType((DevExpress.XtraReports.UI.VerticalAnchorStyles.Top Or DevExpress.XtraReports.UI.VerticalAnchorStyles.Bottom), DevExpress.XtraReports.UI.VerticalAnchorStyles)
        Me.XrCrossBandBox1.EndBand = Me.GroupHeaderWONO
        Me.XrCrossBandBox1.Name = "XrCrossBandBox1"
        Me.XrCrossBandBox1.StartBand = Me.GroupHeaderWONO
        '
        'GroupHeaderJOBNO
        '
        Me.GroupHeaderJOBNO.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel49, Me.XrLabel34})
        Me.GroupHeaderJOBNO.GroupFields.AddRange(New DevExpress.XtraReports.UI.GroupField() {New DevExpress.XtraReports.UI.GroupField("JOBNUMBER", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)})
        Me.GroupHeaderJOBNO.KeepTogether = True
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
        Me.GroupFooter1.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel37, Me.XrLabel5, Me.XrLabel4, Me.XrLabel6, Me.XrLabel36, Me.XrLabel35})
        Me.GroupFooter1.KeepTogether = True
        Me.GroupFooter1.Name = "GroupFooter1"
        '
        'XrLabel37
        '
        Me.XrLabel37.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([OWNRISKAMOUNT]==0,False,True)" & Global.Microsoft.VisualBasic.ChrW(10) & Global.Microsoft.VisualBasic.ChrW(10)), New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([OWNRISKAMOUNT],?RPT_NO_OF_DIGITS)")})
        Me.XrLabel37.Multiline = True
        Me.XrLabel37.Name = "XrLabel37"
        Me.XrLabel37.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel37.StylePriority.UseFont = False
        Me.XrLabel37.StylePriority.UseTextAlignment = False
        Me.XrLabel37.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLabel5
        '
        Me.XrLabel5.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([REDUCTION_AMOUNT]==0,False,True)")})
        Me.XrLabel5.Multiline = True
        Me.XrLabel5.Name = "XrLabel5"
        Me.XrLabel5.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel5.StylePriority.UseFont = False
        '
        'XrLabel4
        '
        Me.XrLabel4.Multiline = True
        Me.XrLabel4.Name = "XrLabel4"
        Me.XrLabel4.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel4.StylePriority.UseFont = False
        '
        'XrLabel6
        '
        Me.XrLabel6.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([OWNRISKAMOUNT]==0,False,True)" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.XrLabel6.Multiline = True
        Me.XrLabel6.Name = "XrLabel6"
        Me.XrLabel6.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel6.StylePriority.UseFont = False
        '
        'XrLabel36
        '
        Me.XrLabel36.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Visible", "Iif([REDUCTION_AMOUNT]==0,False,True)" & Global.Microsoft.VisualBasic.ChrW(10)), New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([REDUCTION_AMOUNT],?RPT_NO_OF_DIGITS)")})
        Me.XrLabel36.Multiline = True
        Me.XrLabel36.Name = "XrLabel36"
        Me.XrLabel36.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel36.StylePriority.UseFont = False
        Me.XrLabel36.StylePriority.UseTextAlignment = False
        Me.XrLabel36.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLabel35
        '
        Me.XrLabel35.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round(sumRunningSum([GARAGEMATERIALAMT]),?RPT_NO_OF_DIGITS)")})
        Me.XrLabel35.Multiline = True
        Me.XrLabel35.Name = "XrLabel35"
        Me.XrLabel35.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel35.StylePriority.UseFont = False
        Me.XrLabel35.StylePriority.UseTextAlignment = False
        XrSummary1.Running = DevExpress.XtraReports.UI.SummaryRunning.Group
        Me.XrLabel35.Summary = XrSummary1
        Me.XrLabel35.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'PageFooter
        '
        Me.PageFooter.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel41, Me.XrLine1, Me.XrLine2, Me.XrLabel25, Me.XrLabel38, Me.XrLabel39, Me.XrLabel40, Me.XrLabel42, Me.XrLabel44, Me.XrLabel45, Me.XrLabel46, Me.XrLabel47, Me.XrLabel48, Me.XrLabel55})
        Me.PageFooter.Name = "PageFooter"
        '
        'XrLabel41
        '
        Me.XrLabel41.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([TOFINDVAT],?RPT_NO_OF_DIGITS)")})
        Me.XrLabel41.Multiline = True
        Me.XrLabel41.Name = "XrLabel41"
        Me.XrLabel41.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel41.StylePriority.UseFont = False
        XrSummary2.Running = DevExpress.XtraReports.UI.SummaryRunning.Page
        Me.XrLabel41.Summary = XrSummary2
        Me.XrLabel41.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'XrLine1
        '
        Me.XrLine1.Name = "XrLine1"
        '
        'XrLine2
        '
        Me.XrLine2.Name = "XrLine2"
        '
        'XrLabel25
        '
        Me.XrLabel25.Multiline = True
        Me.XrLabel25.Name = "XrLabel25"
        Me.XrLabel25.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel25.StylePriority.UseFont = False
        '
        'XrLabel38
        '
        Me.XrLabel38.Multiline = True
        Me.XrLabel38.Name = "XrLabel38"
        Me.XrLabel38.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel38.StylePriority.UseFont = False
        '
        'XrLabel39
        '
        Me.XrLabel39.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([INVOICESUM],?RPT_NO_OF_DIGITS)")})
        Me.XrLabel39.Multiline = True
        Me.XrLabel39.Name = "XrLabel39"
        Me.XrLabel39.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel39.StylePriority.UseFont = False
        '
        'XrLabel40
        '
        Me.XrLabel40.Multiline = True
        Me.XrLabel40.Name = "XrLabel40"
        Me.XrLabel40.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel40.StylePriority.UseFont = False
        '
        'XrLabel42
        '
        Me.XrLabel42.Multiline = True
        Me.XrLabel42.Name = "XrLabel42"
        Me.XrLabel42.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel42.StylePriority.UseFont = False
        '
        'XrLabel44
        '
        Me.XrLabel44.Multiline = True
        Me.XrLabel44.Name = "XrLabel44"
        Me.XrLabel44.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel44.StylePriority.UseFont = False
        '
        'XrLabel45
        '
        Me.XrLabel45.Multiline = True
        Me.XrLabel45.Name = "XrLabel45"
        Me.XrLabel45.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel45.StylePriority.UseFont = False
        '
        'XrLabel46
        '
        Me.XrLabel46.Multiline = True
        Me.XrLabel46.Name = "XrLabel46"
        Me.XrLabel46.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel46.StylePriority.UseFont = False
        '
        'XrLabel47
        '
        Me.XrLabel47.Multiline = True
        Me.XrLabel47.Name = "XrLabel47"
        Me.XrLabel47.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel47.StylePriority.UseFont = False
        '
        'XrLabel48
        '
        Me.XrLabel48.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[KIDNO]")})
        Me.XrLabel48.Multiline = True
        Me.XrLabel48.Name = "XrLabel48"
        Me.XrLabel48.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel48.StylePriority.UseFont = False
        '
        'XrLabel55
        '
        Me.XrLabel55.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "Round([ROUNDEDTOTAL],?RPT_NO_OF_DIGITS)")})
        Me.XrLabel55.Multiline = True
        Me.XrLabel55.Name = "XrLabel55"
        Me.XrLabel55.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel55.StylePriority.UseFont = False
        Me.XrLabel55.StylePriority.UseTextAlignment = False
        Me.XrLabel55.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        '
        'ReportFooter
        '
        Me.ReportFooter.Name = "ReportFooter"
        '
        'RPT_NO_OF_DIGITS
        '
        Me.RPT_NO_OF_DIGITS.Name = "RPT_NO_OF_DIGITS"
        Me.RPT_NO_OF_DIGITS.Type = GetType(Integer)
        Me.RPT_NO_OF_DIGITS.ValueInfo = "2"
        '
        'GroupFooter2
        '
        Me.GroupFooter2.Level = 1
        Me.GroupFooter2.Name = "GroupFooter2"
        '
        'GroupFooter3
        '
        Me.GroupFooter3.Level = 2
        Me.GroupFooter3.Name = "GroupFooter3"
        '
        'dxWorkOrderInvoice
        '
        Me.Bands.AddRange(New DevExpress.XtraReports.UI.Band() {Me.TopMargin, Me.BottomMargin, Me.Detail, Me.ReportHeader, Me.PageHeader, Me.GroupHeaderInvoiceNoA, Me.GroupHeaderWONO, Me.GroupHeaderJOBNO, Me.GroupFooter1, Me.PageFooter, Me.ReportFooter, Me.GroupFooter2, Me.GroupFooter3})
        Me.ComponentStorage.AddRange(New System.ComponentModel.IComponent() {Me.SqlDataSource1})
        Me.CrossBandControls.AddRange(New DevExpress.XtraReports.UI.XRCrossBandControl() {Me.XrCrossBandBox1})
        Me.DataMember = "USP_REP_INVOICE_WORKORDER"
        Me.DataSource = Me.SqlDataSource1
        Me.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Bookmark", "'INVOICE NUMBER'" & Global.Microsoft.VisualBasic.ChrW(10))})
        Me.LocalizationItems.AddRange(New DevExpress.XtraReports.Localization.LocalizationItem() {New DevExpress.XtraReports.Localization.LocalizationItem(Me.BottomMargin, "Default", "HeightF", 0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.Detail, "Default", "HeightF", 25.0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me, "Default", "Font", New System.Drawing.Font("Arial", 9.75!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me, "Default", "Margins", New System.Drawing.Printing.Margins(23, 20, 0, 0)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupFooter1, "Default", "HeightF", 67.1657!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupFooter2, "Default", "HeightF", 0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupFooter3, "Default", "HeightF", 0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupHeaderInvoiceNoA, "Default", "HeightF", 160.4171!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupHeaderJOBNO, "Default", "HeightF", 17.16687!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.GroupHeaderWONO, "Default", "HeightF", 69.8335!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.PageFooter, "Default", "HeightF", 108.2503!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.PageHeader, "Default", "HeightF", 194.8749!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.ReportFooter, "Default", "HeightF", 0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.ReportHeader, "Default", "HeightF", 0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.RPT_NO_OF_DIGITS, "Default", "Description", "RPT_NO_OF_DIGITS"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.TopMargin, "Default", "HeightF", 0!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrCrossBandBox1, "Default", "EndPointFloat", New DevExpress.Utils.PointFloat(0!, 67.792!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrCrossBandBox1, "Default", "StartPointFloat", New DevExpress.Utils.PointFloat(0!, 22.9585!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrCrossBandBox1, "Default", "WidthF", 807.0001!), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(23.66666!, 131.2083!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "SizeF", New System.Drawing.SizeF(155.2083!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel1, "Default", "Text", "XrLabel1"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel10, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(306.4872!, 90.08331!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel10, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(306.4872!, 54.50001!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel11, "nb-NO", "Text", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(306.4872!, 72.29166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel12, "nb-NO", "Text", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel13, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(306.4872!, 129.4167!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel13, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel14, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(306.4872!, 36.70835!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel14, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel15, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(306.4872!, 17.95835!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel15, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel15, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel16, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(306.4872!, 111.625!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel16, "Default", "SizeF", New System.Drawing.SizeF(152.2876!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 35.75001!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "Default", "Text", "Forfallsdato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "en-US", "Text", "Due Date"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel17, "nb-NO", "Text", "Forfalls dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 53.54166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "Default", "Text", "Reg. dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel18, "en-US", "Text", "Reg. date"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 75.08329!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "Default", "Text", "Referanse"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel19, "en-US", "Text", "Reference"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(239.2917!, 148.2499!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "SizeF", New System.Drawing.SizeF(144.7917!, 22.99999!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel2, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 110.6668!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "Default", "Text", "Kundemotta"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel20, "en-US", "Text", "Customer service"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 17.95835!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "Default", "Text", "Faktura nr"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel21, "en-US", "Text", "Invoice no."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 129.4167!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "Default", "Text", "Ordrenr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "en-US", "Text", "Order no."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel22, "nb-NO", "Text", "Ordre nr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 92.875!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "Default", "SizeF", New System.Drawing.SizeF(87.5!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "Default", "Text", "Kundenr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "en-US", "Text", "Customer no"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel23, "nb-NO", "Text", "Kunde nr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel24, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(557.0004!, 75.08335!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel24, "Default", "SizeF", New System.Drawing.SizeF(98.33313!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(15.58295!, 23.00002!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "SizeF", New System.Drawing.SizeF(42.70833!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel25, "Default", "Text", "NOK"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(669.3334!, 17.95835!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "SizeF", New System.Drawing.SizeF(116.6666!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel26, "Default", "Text", "XXXX"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(557.0004!, 110.6668!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "Default", "SizeF", New System.Drawing.SizeF(157.7082!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel27, "nb-NO", "Text", ""), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel28, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(557.0004!, 17.95835!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel28, "Default", "SizeF", New System.Drawing.SizeF(98.33319!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel29, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(557.0004!, 129.4167!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel29, "Default", "SizeF", New System.Drawing.SizeF(98.33307!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel29, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(656.1361!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "Default", "SizeF", New System.Drawing.SizeF(140.864!, 25.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel3, "Default", "Text", "XrLabel3"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel30, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(557.0004!, 92.875!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel30, "Default", "SizeF", New System.Drawing.SizeF(98.33319!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel30, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(23.66666!, 8.666706!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "SizeF", New System.Drawing.SizeF(165.0!, 148.25!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel31, "Default", "Text", "CustomerDetails"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(669.3334!, 55.54171!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "SizeF", New System.Drawing.SizeF(116.6666!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel32, "Default", "Text", "XXXX"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(669.3334!, 37.75005!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "SizeF", New System.Drawing.SizeF(116.6666!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel33, "Default", "Text", "Foretaksregisteret"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(50.16662!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel34, "Default", "SizeF", New System.Drawing.SizeF(58.08334!, 17.16687!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel35, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(711.9279!, 6.895367!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel35, "Default", "SizeF", New System.Drawing.SizeF(85.07214!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(711.9279!, 24.68705!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "Default", "SizeF", New System.Drawing.SizeF(85.07214!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel36, "Default", "Text", "Reduction Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(711.9279!, 42.47867!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "Default", "SizeF", New System.Drawing.SizeF(85.07214!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel37, "Default", "Text", "Own Risk Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(58.29128!, 23.00002!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "SizeF", New System.Drawing.SizeF(102.0834!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "Default", "Text", "Nettobelop :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel38, "en-US", "Text", "Net amount :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel39, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel39, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(160.3747!, 23.00002!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel39, "Default", "SizeF", New System.Drawing.SizeF(96.875!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(20.00004!, 6.895367!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "Default", "SizeF", New System.Drawing.SizeF(135.4167!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "Default", "Text", "Verkstedmatriell"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel4, "en-US", "Text", "Garage Material"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(257.2497!, 23.00002!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "SizeF", New System.Drawing.SizeF(95.38751!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "Default", "Text", "MVA belop :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel40, "en-US", "Text", "MVA amount :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(352.6372!, 23.00002!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "Default", "SizeF", New System.Drawing.SizeF(100.0!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel41, "Default", "Text", "XrLabel41"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(562.8748!, 23.00002!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "SizeF", New System.Drawing.SizeF(98.84442!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "Default", "Text", "A BETALE :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel42, "en-US", "Text", "TO PAY:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "SizeF", New System.Drawing.SizeF(125.2101!, 22.9585!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel43, "Default", "Text", "XrLabel43"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(20.67723!, 79.16654!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "SizeF", New System.Drawing.SizeF(180.2084!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel44, "Default", "Text", "Swift no.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(20.67723!, 62.58329!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "SizeF", New System.Drawing.SizeF(180.2084!, 16.58326!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "Default", "Text", "Betales til kontonr.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel45, "en-US", "Text", "Paid to account no.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(371.094!, 79.16654!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "SizeF", New System.Drawing.SizeF(102.0834!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel46, "Default", "Text", "Iban no.:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(371.094!, 62.58329!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "SizeF", New System.Drawing.SizeF(102.0834!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "Default", "Text", "Kidnummer:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel47, "en-US", "Text", "Kid number:"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(473.1773!, 62.58329!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "SizeF", New System.Drawing.SizeF(188.5419!, 16.58326!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel48, "Default", "Text", "Nettobelop :"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "SizeF", New System.Drawing.SizeF(37.25001!, 17.16687!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel49, "Default", "Text", "JOB"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(20.00004!, 24.68699!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "Default", "SizeF", New System.Drawing.SizeF(135.4167!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel5, "Default", "Text", "Reduction Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(157.2497!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "SizeF", New System.Drawing.SizeF(100.0!, 22.9585!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "Text", "XrLabel50"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel50, "Default", "TextFormatString", "{0:d}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(209.5!, 35.75004!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "Default", "Text", "Refnr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "en-US", "Text", "Ref no."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel51, "nb-NO", "Text", "Ref nr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel52, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(209.5!, 53.54176!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel52, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel52, "Default", "Text", "Km. stand"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(209.5!, 17.95835!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "Default", "SizeF", New System.Drawing.SizeF(89.58333!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "Default", "Text", "Regnr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "en-US", "Text", "Reg no."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel53, "nb-NO", "Text", "Reg nr."), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(209.5!, 71.33334!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "Default", "Text", "Ch.nr"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel54, "en-US", "Text", "Ch.no"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "Default", "Font", New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(697.0!, 23.00002!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "Default", "SizeF", New System.Drawing.SizeF(100.0!, 16.58325!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel55, "Default", "Text", "XrLabel55"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(469.5002!, 148.2499!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "nb-NO", "LocationFloat", New DevExpress.Utils.PointFloat(473.1773!, 148.2499!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "SizeF", New System.Drawing.SizeF(196.3535!, 22.99998!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "nb-NO", "SizeF", New System.Drawing.SizeF(188.542!, 22.99998!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "Text", "Date Time"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel56, "Default", "TextFormatString", "{0:d-MMM-yy  H:mm:ss}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(20.00004!, 42.47861!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "Default", "SizeF", New System.Drawing.SizeF(135.4167!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel6, "Default", "Text", "Own Risk Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(209.5!, 92.87497!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "Default", "SizeF", New System.Drawing.SizeF(89.58333!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "Default", "Text", "Rekv. Nr"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel7, "nb-NO", "Text", "Rekv. nr"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(209.5!, 110.6667!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79165!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "Default", "Text", "Lev. Dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "en-US", "Text", "Lev. Date"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel8, "nb-NO", "Text", "Lev. dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(209.5!, 128.4584!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "Default", "SizeF", New System.Drawing.SizeF(89.58334!, 17.79166!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "Default", "Text", "Rep. dato"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLabel9, "en-US", "Text", "Rep. date"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine1, "Default", "SizeF", New System.Drawing.SizeF(790.5415!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 39.58327!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine2, "Default", "SizeF", New System.Drawing.SizeF(790.5415!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine3, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 171.2499!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrLine3, "Default", "SizeF", New System.Drawing.SizeF(785.5417!, 14.33331!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(681.6247!, 148.2499!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "SizeF", New System.Drawing.SizeF(104.3754!, 23.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPageInfo1, "Default", "TextFormatString", "Page {0} of {1}"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPictureBox1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(23.66666!, 5.541595!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrPictureBox1, "Default", "SizeF", New System.Drawing.SizeF(223.9585!, 112.5833!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText3, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText3, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(538.7083!, 21.875!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText3, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText4, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText4, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(538.7083!, 41.75!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText4, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText5, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText5, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(538.7083!, 61.625!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText5, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87499!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText6, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText6, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(538.7083!, 81.49999!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText6, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText7, "Default", "Font", New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText7, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(538.7083!, 101.3749!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrRichText7, "Default", "SizeF", New System.Drawing.SizeF(247.2917!, 19.87498!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable1, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(11.45829!, 0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable1, "Default", "SizeF", New System.Drawing.SizeF(644.6777!, 25.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable2, "Default", "LocationFloat", New DevExpress.Utils.PointFloat(9.999998!, 34.83353!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTable2, "Default", "SizeF", New System.Drawing.SizeF(787.0!, 25.0!)), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell1, "Default", "Text", "XrTableCell1"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell1, "Default", "Weight", 0.22053610311627986R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "Default", "Text", "Antal"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "en-US", "Text", "Amount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell10, "Default", "Weight", 2.0R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "Default", "Text", "Rabatt"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "en-US", "Text", "Discount"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell11, "Default", "Weight", 2.0R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell12, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell12, "Default", "Text", "Sum"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell12, "Default", "Weight", 2.1398476504841888R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell2, "Default", "Text", "XrTableCell2"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell2, "Default", "Weight", 0.42949063716203673R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell3, "Default", "Text", "XrTableCell3"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell3, "Default", "Weight", 0.13903022671577503R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell4, "Default", "Text", "XrTableCell4"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell4, "Default", "Weight", 0.27240637207499147R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell5, "Default", "Text", "XrTableCell5"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell5, "Default", "TextFormatString", "{0}%"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell5, "Default", "Weight", 0.27240596164974357R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "Default", "Text", "Beskrivelse"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "en-US", "Text", "Description"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell7, "Default", "Weight", 1.6413222731538688R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell8, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell8, "Default", "Weight", 3.1533067520374209R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "Default", "Font", New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "Default", "Text", "Pris"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "en-US", "Text", "Price"), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableCell9, "Default", "Weight", 1.0207554493429649R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableRow1, "Default", "Weight", 11.5R), New DevExpress.XtraReports.Localization.LocalizationItem(Me.XrTableRow2, "Default", "Weight", 11.5R)})
        Me.Parameters.AddRange(New DevExpress.XtraReports.Parameters.Parameter() {Me.paramInvXml, Me.paramType, Me.RPT_NO_OF_DIGITS})
        Me.Version = "21.2"
        CType(Me.XrTable1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText6, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText4, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText5, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrRichText7, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.XrTable2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.UnitOfWork1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.UnitOfWork2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.UnitOfWork3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me, System.ComponentModel.ISupportInitialize).EndInit()

    End Sub

    Friend WithEvents paramInvXml As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents paramType As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents TopMargin As DevExpress.XtraReports.UI.TopMarginBand
    Friend WithEvents BottomMargin As DevExpress.XtraReports.UI.BottomMarginBand
    Friend WithEvents Detail As DevExpress.XtraReports.UI.DetailBand
    Friend WithEvents SqlDataSource1 As DevExpress.DataAccess.Sql.SqlDataSource
    Friend WithEvents ReportHeader As DevExpress.XtraReports.UI.ReportHeaderBand
    Friend WithEvents PageHeader As DevExpress.XtraReports.UI.PageHeaderBand
    Friend WithEvents XrRichText6 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText4 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText5 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText3 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrRichText7 As DevExpress.XtraReports.UI.XRRichText
    Friend WithEvents XrPictureBox1 As DevExpress.XtraReports.UI.XRPictureBox
    Friend WithEvents XrPageInfo1 As DevExpress.XtraReports.UI.XRPageInfo
    Friend WithEvents XrLabel56 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLine3 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLabel1 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GroupHeaderInvoiceNoA As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents XrLabel2 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel33 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel8 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel9 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel16 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel15 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel14 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel13 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel12 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel11 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel10 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel23 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel22 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel21 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel20 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel18 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel17 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel30 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel29 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel28 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel27 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel24 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel31 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel19 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel26 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel7 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel32 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel53 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel52 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel51 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel54 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrTable1 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents XrTableRow1 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents XrTableCell1 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell2 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell3 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell4 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents XrTableCell5 As DevExpress.XtraReports.UI.XRTableCell
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
    Friend WithEvents XrLabel3 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GroupHeaderJOBNO As DevExpress.XtraReports.UI.GroupHeaderBand
    Friend WithEvents XrLabel49 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel34 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents GroupFooter1 As DevExpress.XtraReports.UI.GroupFooterBand
    Friend WithEvents PageFooter As DevExpress.XtraReports.UI.PageFooterBand
    Friend WithEvents XrLabel37 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel5 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel4 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel6 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel36 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel35 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents ReportFooter As DevExpress.XtraReports.UI.ReportFooterBand
    Friend WithEvents XrLine1 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLine2 As DevExpress.XtraReports.UI.XRLine
    Friend WithEvents XrLabel25 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel38 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel39 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel40 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel42 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel44 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel45 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel46 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel47 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel48 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel55 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel41 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents UnitOfWork1 As DevExpress.Xpo.UnitOfWork
    Friend WithEvents UnitOfWork2 As DevExpress.Xpo.UnitOfWork
    Friend WithEvents UnitOfWork3 As DevExpress.Xpo.UnitOfWork
    Friend WithEvents RPT_NO_OF_DIGITS As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents GroupFooter2 As DevExpress.XtraReports.UI.GroupFooterBand
    Friend WithEvents GroupFooter3 As DevExpress.XtraReports.UI.GroupFooterBand
    Friend WithEvents XrLabel50 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel43 As DevExpress.XtraReports.UI.XRLabel
End Class
