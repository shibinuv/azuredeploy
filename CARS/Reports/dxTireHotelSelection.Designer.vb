<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Public Class dxTireHotelSelection
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
        Dim QueryParameter3 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter4 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter5 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter6 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter7 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter8 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter9 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim QueryParameter10 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(dxTireHotelSelection))
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
        Me.GroupHeader1 = New DevExpress.XtraReports.UI.GroupHeaderBand()
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
        Me.tableCell12 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell13 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell14 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.Detail = New DevExpress.XtraReports.UI.DetailBand()
        Me.table2 = New DevExpress.XtraReports.UI.XRTable()
        Me.tableRow2 = New DevExpress.XtraReports.UI.XRTableRow()
        Me.tableCell15 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell16 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell17 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell18 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell19 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell20 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell21 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell22 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell23 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell24 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell25 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell26 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell27 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.tableCell28 = New DevExpress.XtraReports.UI.XRTableCell()
        Me.pWarehouse = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pDepartment = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pTireType = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pSpikesornot = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pRimType = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pTireBrand = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pTireQuality = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pDepth = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pLocationFrom = New DevExpress.XtraReports.Parameters.Parameter()
        Me.pLocationTo = New DevExpress.XtraReports.Parameters.Parameter()
        CType(Me.table1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.table2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me, System.ComponentModel.ISupportInitialize).BeginInit()
        '
        'SqlDataSource1
        '
        Me.SqlDataSource1.ConnectionName = "localhost_CARS"
        Me.SqlDataSource1.Name = "SqlDataSource1"
        StoredProcQuery1.Name = "USP_GENERATE_TP_SELECTION"
        QueryParameter1.Name = "@WAREHOUSE"
        QueryParameter1.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter1.Value = New DevExpress.DataAccess.Expression("?pWarehouse", GetType(Integer))
        QueryParameter2.Name = "@DEPARTMENT"
        QueryParameter2.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter2.Value = New DevExpress.DataAccess.Expression("?pDepartment", GetType(Integer))
        QueryParameter3.Name = "@TIRETYPE"
        QueryParameter3.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter3.Value = New DevExpress.DataAccess.Expression("?pTireType", GetType(Integer))
        QueryParameter4.Name = "@SPIKESORNOT"
        QueryParameter4.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter4.Value = New DevExpress.DataAccess.Expression("?pSpikesornot", GetType(Integer))
        QueryParameter5.Name = "@RIMTYPE"
        QueryParameter5.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter5.Value = New DevExpress.DataAccess.Expression("?pRimType", GetType(Integer))
        QueryParameter6.Name = "@TIREBRAND"
        QueryParameter6.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter6.Value = New DevExpress.DataAccess.Expression("?pTireBrand", GetType(Integer))
        QueryParameter7.Name = "@TIREQUALITY"
        QueryParameter7.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter7.Value = New DevExpress.DataAccess.Expression("?pTireQuality", GetType(Integer))
        QueryParameter8.Name = "@TIREDEPTH"
        QueryParameter8.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter8.Value = New DevExpress.DataAccess.Expression("?pDepth", GetType(Decimal))
        QueryParameter9.Name = "@LOCATIONFROM"
        QueryParameter9.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter9.Value = New DevExpress.DataAccess.Expression("?pLocationFrom", GetType(String))
        QueryParameter10.Name = "@LOCATIONTO"
        QueryParameter10.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter10.Value = New DevExpress.DataAccess.Expression("?pLocationTo", GetType(String))
        StoredProcQuery1.Parameters.Add(QueryParameter1)
        StoredProcQuery1.Parameters.Add(QueryParameter2)
        StoredProcQuery1.Parameters.Add(QueryParameter3)
        StoredProcQuery1.Parameters.Add(QueryParameter4)
        StoredProcQuery1.Parameters.Add(QueryParameter5)
        StoredProcQuery1.Parameters.Add(QueryParameter6)
        StoredProcQuery1.Parameters.Add(QueryParameter7)
        StoredProcQuery1.Parameters.Add(QueryParameter8)
        StoredProcQuery1.Parameters.Add(QueryParameter9)
        StoredProcQuery1.Parameters.Add(QueryParameter10)
        StoredProcQuery1.StoredProcName = "USP_GENERATE_TP_SELECTION"
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
        Me.Title.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(70, Byte), Integer), CType(CType(80, Byte), Integer))
        Me.Title.Name = "Title"
        Me.Title.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        '
        'DetailCaption1
        '
        Me.DetailCaption1.BackColor = System.Drawing.Color.FromArgb(CType(CType(69, Byte), Integer), CType(CType(94, Byte), Integer), CType(CType(178, Byte), Integer))
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
        Me.DetailData3_Odd.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
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
        Me.PageInfo.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(70, Byte), Integer), CType(CType(80, Byte), Integer))
        Me.PageInfo.Name = "PageInfo"
        Me.PageInfo.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        '
        'TopMargin
        '
        Me.TopMargin.Name = "TopMargin"
        '
        'BottomMargin
        '
        Me.BottomMargin.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.pageInfo1, Me.pageInfo2})
        Me.BottomMargin.Name = "BottomMargin"
        '
        'pageInfo1
        '
        Me.pageInfo1.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.pageInfo1.Name = "pageInfo1"
        Me.pageInfo1.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime
        Me.pageInfo1.SizeF = New System.Drawing.SizeF(484.5!, 23.0!)
        Me.pageInfo1.StyleName = "PageInfo"
        '
        'pageInfo2
        '
        Me.pageInfo2.LocationFloat = New DevExpress.Utils.PointFloat(484.0!, 0!)
        Me.pageInfo2.Name = "pageInfo2"
        Me.pageInfo2.SizeF = New System.Drawing.SizeF(558.0001!, 23.0!)
        Me.pageInfo2.StyleName = "PageInfo"
        Me.pageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.pageInfo2.TextFormatString = "Page {0} of {1}"
        '
        'ReportHeader
        '
        Me.ReportHeader.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.label1})
        Me.ReportHeader.HeightF = 60.0!
        Me.ReportHeader.Name = "ReportHeader"
        '
        'label1
        '
        Me.label1.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.label1.Name = "label1"
        Me.label1.SizeF = New System.Drawing.SizeF(969.0!, 24.19433!)
        Me.label1.StyleName = "Title"
        Me.label1.StylePriority.UseTextAlignment = False
        Me.label1.Text = "Dekkhotell utvalg"
        Me.label1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter
        '
        'GroupHeader1
        '
        Me.GroupHeader1.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.table1})
        Me.GroupHeader1.GroupUnion = DevExpress.XtraReports.UI.GroupUnion.WithFirstDetail
        Me.GroupHeader1.HeightF = 28.0!
        Me.GroupHeader1.Name = "GroupHeader1"
        '
        'table1
        '
        Me.table1.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.table1.Name = "table1"
        Me.table1.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.tableRow1})
        Me.table1.SizeF = New System.Drawing.SizeF(1042.0!, 28.0!)
        '
        'tableRow1
        '
        Me.tableRow1.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.tableCell1, Me.tableCell2, Me.tableCell3, Me.tableCell4, Me.tableCell5, Me.tableCell6, Me.tableCell7, Me.tableCell8, Me.tableCell9, Me.tableCell10, Me.tableCell11, Me.tableCell12, Me.tableCell13, Me.tableCell14})
        Me.tableRow1.Name = "tableRow1"
        Me.tableRow1.Weight = 1.0R
        '
        'tableCell1
        '
        Me.tableCell1.Borders = DevExpress.XtraPrinting.BorderSide.None
        Me.tableCell1.Name = "tableCell1"
        Me.tableCell1.StyleName = "DetailCaption1"
        Me.tableCell1.StylePriority.UseBorders = False
        Me.tableCell1.Text = "Kundenr"
        Me.tableCell1.Weight = 0.061539586583891005R
        '
        'tableCell2
        '
        Me.tableCell2.Name = "tableCell2"
        Me.tableCell2.StyleName = "DetailCaption1"
        Me.tableCell2.Text = "Navn"
        Me.tableCell2.Weight = 0.11335975510769941R
        '
        'tableCell3
        '
        Me.tableCell3.Name = "tableCell3"
        Me.tableCell3.StyleName = "DetailCaption1"
        Me.tableCell3.Text = "Tlf."
        Me.tableCell3.Weight = 0.059769495967093057R
        '
        'tableCell4
        '
        Me.tableCell4.Name = "tableCell4"
        Me.tableCell4.StyleName = "DetailCaption1"
        Me.tableCell4.Text = "Pakkenr"
        Me.tableCell4.Weight = 0.068012126076020335R
        '
        'tableCell5
        '
        Me.tableCell5.Name = "tableCell5"
        Me.tableCell5.StyleName = "DetailCaption1"
        Me.tableCell5.Text = "Refnr"
        Me.tableCell5.Weight = 0.076045617836979648R
        '
        'tableCell6
        '
        Me.tableCell6.Name = "tableCell6"
        Me.tableCell6.StyleName = "DetailCaption1"
        Me.tableCell6.Text = "Regnr"
        Me.tableCell6.Weight = 0.072477615782580218R
        '
        'tableCell7
        '
        Me.tableCell7.Name = "tableCell7"
        Me.tableCell7.StyleName = "DetailCaption1"
        Me.tableCell7.Text = "Dim foran"
        Me.tableCell7.Weight = 0.074305365711834881R
        '
        'tableCell8
        '
        Me.tableCell8.Name = "tableCell8"
        Me.tableCell8.StyleName = "DetailCaption1"
        Me.tableCell8.Text = "Dim bak"
        Me.tableCell8.Weight = 0.071528738451557911R
        '
        'tableCell9
        '
        Me.tableCell9.Name = "tableCell9"
        Me.tableCell9.StyleName = "DetailCaption1"
        Me.tableCell9.Text = "Lokasjon"
        Me.tableCell9.Weight = 0.081541643669616928R
        '
        'tableCell10
        '
        Me.tableCell10.Name = "tableCell10"
        Me.tableCell10.StyleName = "DetailCaption1"
        Me.tableCell10.Text = "Dekktype"
        Me.tableCell10.Weight = 0.085817957190564023R
        '
        'tableCell11
        '
        Me.tableCell11.Name = "tableCell11"
        Me.tableCell11.StyleName = "DetailCaption1"
        Me.tableCell11.Text = "Pigg?"
        Me.tableCell11.Weight = 0.05420205106707239R
        '
        'tableCell12
        '
        Me.tableCell12.Name = "tableCell12"
        Me.tableCell12.StyleName = "DetailCaption1"
        Me.tableCell12.Text = "Felgtype"
        Me.tableCell12.Weight = 0.08872843383320167R
        '
        'tableCell13
        '
        Me.tableCell13.Name = "tableCell13"
        Me.tableCell13.StyleName = "DetailCaption1"
        Me.tableCell13.Text = "Dekkmerke"
        Me.tableCell13.Weight = 0.0872770609423599R
        '
        'tableCell14
        '
        Me.tableCell14.Name = "tableCell14"
        Me.tableCell14.StyleName = "DetailCaption1"
        Me.tableCell14.Text = "Dekkvalitet"
        Me.tableCell14.Weight = 0.080730134338275014R
        '
        'Detail
        '
        Me.Detail.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.table2})
        Me.Detail.HeightF = 25.0!
        Me.Detail.Name = "Detail"
        '
        'table2
        '
        Me.table2.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.table2.Name = "table2"
        Me.table2.OddStyleName = "DetailData3_Odd"
        Me.table2.Rows.AddRange(New DevExpress.XtraReports.UI.XRTableRow() {Me.tableRow2})
        Me.table2.SizeF = New System.Drawing.SizeF(1042.0!, 25.0!)
        '
        'tableRow2
        '
        Me.tableRow2.Cells.AddRange(New DevExpress.XtraReports.UI.XRTableCell() {Me.tableCell15, Me.tableCell16, Me.tableCell17, Me.tableCell18, Me.tableCell19, Me.tableCell20, Me.tableCell21, Me.tableCell22, Me.tableCell23, Me.tableCell24, Me.tableCell25, Me.tableCell26, Me.tableCell27, Me.tableCell28})
        Me.tableRow2.Name = "tableRow2"
        Me.tableRow2.Weight = 11.5R
        '
        'tableCell15
        '
        Me.tableCell15.Borders = DevExpress.XtraPrinting.BorderSide.None
        Me.tableCell15.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[custNo]")})
        Me.tableCell15.Name = "tableCell15"
        Me.tableCell15.StyleName = "DetailData1"
        Me.tableCell15.StylePriority.UseBorders = False
        Me.tableCell15.Weight = 0.061539590097431873R
        '
        'tableCell16
        '
        Me.tableCell16.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[FULLNAME]")})
        Me.tableCell16.Name = "tableCell16"
        Me.tableCell16.StyleName = "DetailData1"
        Me.tableCell16.Weight = 0.11335974894682743R
        '
        'tableCell17
        '
        Me.tableCell17.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[MOBILE]")})
        Me.tableCell17.Name = "tableCell17"
        Me.tableCell17.StyleName = "DetailData1"
        Me.tableCell17.Weight = 0.059769499640845679R
        '
        'tableCell18
        '
        Me.tableCell18.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tirePackageNo]")})
        Me.tableCell18.Name = "tableCell18"
        Me.tableCell18.StyleName = "DetailData1"
        Me.tableCell18.Weight = 0.0680121623953624R
        '
        'tableCell19
        '
        Me.tableCell19.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[refNo]")})
        Me.tableCell19.Name = "tableCell19"
        Me.tableCell19.StyleName = "DetailData1"
        Me.tableCell19.Weight = 0.076045621096872379R
        '
        'tableCell20
        '
        Me.tableCell20.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[regNo]")})
        Me.tableCell20.Name = "tableCell20"
        Me.tableCell20.StyleName = "DetailData1"
        Me.tableCell20.Weight = 0.072477610851370458R
        '
        'tableCell21
        '
        Me.tableCell21.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireDimFront]")})
        Me.tableCell21.Name = "tableCell21"
        Me.tableCell21.StyleName = "DetailData1"
        Me.tableCell21.Weight = 0.074305302914466756R
        '
        'tableCell22
        '
        Me.tableCell22.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireDimBack]")})
        Me.tableCell22.Name = "tableCell22"
        Me.tableCell22.StyleName = "DetailData1"
        Me.tableCell22.Weight = 0.071528801100510575R
        '
        'tableCell23
        '
        Me.tableCell23.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[location]")})
        Me.tableCell23.Name = "tableCell23"
        Me.tableCell23.StyleName = "DetailData1"
        Me.tableCell23.Weight = 0.081541591349405557R
        '
        'tableCell24
        '
        Me.tableCell24.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireTypeDesc]")})
        Me.tableCell24.Name = "tableCell24"
        Me.tableCell24.StyleName = "DetailData1"
        Me.tableCell24.Weight = 0.0858179492324542R
        '
        'tableCell25
        '
        Me.tableCell25.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireSpikesDesc]")})
        Me.tableCell25.Name = "tableCell25"
        Me.tableCell25.StyleName = "DetailData1"
        Me.tableCell25.Weight = 0.054202060464046992R
        '
        'tableCell26
        '
        Me.tableCell26.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireRimDesc]")})
        Me.tableCell26.Name = "tableCell26"
        Me.tableCell26.StyleName = "DetailData1"
        Me.tableCell26.Weight = 0.0887284255788496R
        '
        'tableCell27
        '
        Me.tableCell27.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireBrandDesc]")})
        Me.tableCell27.Name = "tableCell27"
        Me.tableCell27.StyleName = "DetailData1"
        Me.tableCell27.Weight = 0.087276942924915182R
        '
        'tableCell28
        '
        Me.tableCell28.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireQualityDesc]")})
        Me.tableCell28.Name = "tableCell28"
        Me.tableCell28.StyleName = "DetailData1"
        Me.tableCell28.Weight = 0.08073017118425084R
        '
        'pWarehouse
        '
        Me.pWarehouse.Name = "pWarehouse"
        Me.pWarehouse.Type = GetType(Integer)
        Me.pWarehouse.ValueInfo = "0"
        '
        'pDepartment
        '
        Me.pDepartment.Name = "pDepartment"
        Me.pDepartment.Type = GetType(Integer)
        Me.pDepartment.ValueInfo = "0"
        '
        'pTireType
        '
        Me.pTireType.Name = "pTireType"
        Me.pTireType.Type = GetType(Integer)
        Me.pTireType.ValueInfo = "0"
        '
        'pSpikesornot
        '
        Me.pSpikesornot.Name = "pSpikesornot"
        Me.pSpikesornot.Type = GetType(Integer)
        Me.pSpikesornot.ValueInfo = "0"
        '
        'pRimType
        '
        Me.pRimType.Name = "pRimType"
        Me.pRimType.Type = GetType(Integer)
        Me.pRimType.ValueInfo = "0"
        '
        'pTireBrand
        '
        Me.pTireBrand.Name = "pTireBrand"
        Me.pTireBrand.Type = GetType(Integer)
        Me.pTireBrand.ValueInfo = "0"
        '
        'pTireQuality
        '
        Me.pTireQuality.Name = "pTireQuality"
        Me.pTireQuality.Type = GetType(Integer)
        Me.pTireQuality.ValueInfo = "0"
        '
        'pDepth
        '
        Me.pDepth.Name = "pDepth"
        Me.pDepth.Type = GetType(Decimal)
        Me.pDepth.ValueInfo = "0"
        '
        'pLocationFrom
        '
        Me.pLocationFrom.Name = "pLocationFrom"
        '
        'pLocationTo
        '
        Me.pLocationTo.Name = "pLocationTo"
        '
        'dxTireHotelSelection
        '
        Me.Bands.AddRange(New DevExpress.XtraReports.UI.Band() {Me.TopMargin, Me.BottomMargin, Me.ReportHeader, Me.GroupHeader1, Me.Detail})
        Me.ComponentStorage.AddRange(New System.ComponentModel.IComponent() {Me.SqlDataSource1})
        Me.DataMember = "USP_GENERATE_TP_SELECTION"
        Me.DataSource = Me.SqlDataSource1
        Me.Font = New System.Drawing.Font("Arial", 9.75!)
        Me.Landscape = True
        Me.Margins = New System.Drawing.Printing.Margins(57, 70, 100, 100)
        Me.PageHeight = 827
        Me.PageWidth = 1169
        Me.PaperKind = System.Drawing.Printing.PaperKind.A4
        Me.Parameters.AddRange(New DevExpress.XtraReports.Parameters.Parameter() {Me.pWarehouse, Me.pDepartment, Me.pTireType, Me.pSpikesornot, Me.pRimType, Me.pTireBrand, Me.pTireQuality, Me.pDepth, Me.pLocationFrom, Me.pLocationTo})
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
    Friend WithEvents GroupHeader1 As DevExpress.XtraReports.UI.GroupHeaderBand
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
    Friend WithEvents tableCell12 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell13 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell14 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents Detail As DevExpress.XtraReports.UI.DetailBand
    Friend WithEvents table2 As DevExpress.XtraReports.UI.XRTable
    Friend WithEvents tableRow2 As DevExpress.XtraReports.UI.XRTableRow
    Friend WithEvents tableCell15 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell16 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell17 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell18 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell19 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell20 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell21 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell22 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell23 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell24 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell25 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell26 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell27 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents tableCell28 As DevExpress.XtraReports.UI.XRTableCell
    Friend WithEvents pWarehouse As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pDepartment As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pTireType As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pSpikesornot As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pRimType As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pTireBrand As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pTireQuality As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pDepth As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pLocationFrom As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents pLocationTo As DevExpress.XtraReports.Parameters.Parameter
End Class
