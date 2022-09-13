<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class dxTireDeliveryReport
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
        Dim CustomSqlQuery1 As DevExpress.DataAccess.Sql.CustomSqlQuery = New DevExpress.DataAccess.Sql.CustomSqlQuery()
        Dim QueryParameter1 As DevExpress.DataAccess.Sql.QueryParameter = New DevExpress.DataAccess.Sql.QueryParameter()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(dxTireDeliveryReport))
        Me.SqlDataSource1 = New DevExpress.DataAccess.Sql.SqlDataSource(Me.components)
        Me.Title = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.PageInfo = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.DetailData1Vertical = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.DetailData1VerticalFirstRow = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.DetailData1VerticalLastRow = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.DetailData1VerticalRow_Even = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.HeaderData1Vertical = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.HeaderData1VerticalFirstRow = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.HeaderData1VerticalLastRow = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.HeaderData1VerticalRow_Even = New DevExpress.XtraReports.UI.XRControlStyle()
        Me.TopMargin = New DevExpress.XtraReports.UI.TopMarginBand()
        Me.XrLabel12 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel10 = New DevExpress.XtraReports.UI.XRLabel()
        Me.label1 = New DevExpress.XtraReports.UI.XRLabel()
        Me.BottomMargin = New DevExpress.XtraReports.UI.BottomMarginBand()
        Me.pageInfo2 = New DevExpress.XtraReports.UI.XRPageInfo()
        Me.pageInfo1 = New DevExpress.XtraReports.UI.XRPageInfo()
        Me.ReportHeader = New DevExpress.XtraReports.UI.ReportHeaderBand()
        Me.VerticalHeader = New DevExpress.XtraReports.UI.VerticalHeaderBand()
        Me.XrLabel24 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel23 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel22 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel15 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel18 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel16 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel17 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel19 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel20 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel21 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel25 = New DevExpress.XtraReports.UI.XRLabel()
        Me.VerticalDetail = New DevExpress.XtraReports.UI.VerticalDetailBand()
        Me.XrLine1 = New DevExpress.XtraReports.UI.XRLine()
        Me.XrLabel9 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel13 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel14 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel3 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel2 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel1 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel4 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel5 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel6 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel7 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel8 = New DevExpress.XtraReports.UI.XRLabel()
        Me.XrLabel11 = New DevExpress.XtraReports.UI.XRLabel()
        Me.pTirePackageNo = New DevExpress.XtraReports.Parameters.Parameter()
        CType(Me, System.ComponentModel.ISupportInitialize).BeginInit()
        '
        'SqlDataSource1
        '
        Me.SqlDataSource1.ConnectionName = "localhost_CARS"
        Me.SqlDataSource1.Name = "SqlDataSource1"
        CustomSqlQuery1.Name = "TBL_TIRE_ORDER_PACKAGE_1"
        QueryParameter1.Name = "TIREPACKAGENO"
        QueryParameter1.Type = GetType(DevExpress.DataAccess.Expression)
        QueryParameter1.Value = New DevExpress.DataAccess.Expression("?pTirePackageNo", GetType(String))
        CustomSqlQuery1.Parameters.Add(QueryParameter1)
        CustomSqlQuery1.Sql = resources.GetString("CustomSqlQuery1.Sql")
        Me.SqlDataSource1.Queries.AddRange(New DevExpress.DataAccess.Sql.SqlQuery() {CustomSqlQuery1})
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
        'PageInfo
        '
        Me.PageInfo.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold)
        Me.PageInfo.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(70, Byte), Integer), CType(CType(80, Byte), Integer))
        Me.PageInfo.Name = "PageInfo"
        Me.PageInfo.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        '
        'DetailData1Vertical
        '
        Me.DetailData1Vertical.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.DetailData1Vertical.BorderColor = System.Drawing.Color.White
        Me.DetailData1Vertical.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.DetailData1Vertical.BorderWidth = 2.0!
        Me.DetailData1Vertical.Font = New System.Drawing.Font("Arial", 8.25!)
        Me.DetailData1Vertical.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.DetailData1Vertical.Name = "DetailData1Vertical"
        Me.DetailData1Vertical.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.DetailData1Vertical.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'DetailData1VerticalFirstRow
        '
        Me.DetailData1VerticalFirstRow.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.DetailData1VerticalFirstRow.BorderColor = System.Drawing.Color.White
        Me.DetailData1VerticalFirstRow.Borders = CType((DevExpress.XtraPrinting.BorderSide.Top Or DevExpress.XtraPrinting.BorderSide.Right), DevExpress.XtraPrinting.BorderSide)
        Me.DetailData1VerticalFirstRow.BorderWidth = 2.0!
        Me.DetailData1VerticalFirstRow.Font = New System.Drawing.Font("Arial", 8.25!)
        Me.DetailData1VerticalFirstRow.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.DetailData1VerticalFirstRow.Name = "DetailData1VerticalFirstRow"
        Me.DetailData1VerticalFirstRow.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.DetailData1VerticalFirstRow.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'DetailData1VerticalLastRow
        '
        Me.DetailData1VerticalLastRow.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.DetailData1VerticalLastRow.BorderColor = System.Drawing.Color.White
        Me.DetailData1VerticalLastRow.Borders = CType((DevExpress.XtraPrinting.BorderSide.Right Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.DetailData1VerticalLastRow.BorderWidth = 2.0!
        Me.DetailData1VerticalLastRow.Font = New System.Drawing.Font("Arial", 8.25!)
        Me.DetailData1VerticalLastRow.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.DetailData1VerticalLastRow.Name = "DetailData1VerticalLastRow"
        Me.DetailData1VerticalLastRow.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.DetailData1VerticalLastRow.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'DetailData1VerticalRow_Even
        '
        Me.DetailData1VerticalRow_Even.BackColor = System.Drawing.Color.Transparent
        Me.DetailData1VerticalRow_Even.BorderColor = System.Drawing.Color.White
        Me.DetailData1VerticalRow_Even.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.DetailData1VerticalRow_Even.BorderWidth = 2.0!
        Me.DetailData1VerticalRow_Even.Font = New System.Drawing.Font("Arial", 8.25!)
        Me.DetailData1VerticalRow_Even.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.DetailData1VerticalRow_Even.Name = "DetailData1VerticalRow_Even"
        Me.DetailData1VerticalRow_Even.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.DetailData1VerticalRow_Even.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'HeaderData1Vertical
        '
        Me.HeaderData1Vertical.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.HeaderData1Vertical.BorderColor = System.Drawing.Color.White
        Me.HeaderData1Vertical.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.HeaderData1Vertical.BorderWidth = 2.0!
        Me.HeaderData1Vertical.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold)
        Me.HeaderData1Vertical.ForeColor = System.Drawing.Color.White
        Me.HeaderData1Vertical.Name = "HeaderData1Vertical"
        Me.HeaderData1Vertical.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.HeaderData1Vertical.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'HeaderData1VerticalFirstRow
        '
        Me.HeaderData1VerticalFirstRow.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.HeaderData1VerticalFirstRow.BorderColor = System.Drawing.Color.White
        Me.HeaderData1VerticalFirstRow.Borders = CType((DevExpress.XtraPrinting.BorderSide.Top Or DevExpress.XtraPrinting.BorderSide.Right), DevExpress.XtraPrinting.BorderSide)
        Me.HeaderData1VerticalFirstRow.BorderWidth = 2.0!
        Me.HeaderData1VerticalFirstRow.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold)
        Me.HeaderData1VerticalFirstRow.ForeColor = System.Drawing.Color.White
        Me.HeaderData1VerticalFirstRow.Name = "HeaderData1VerticalFirstRow"
        Me.HeaderData1VerticalFirstRow.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.HeaderData1VerticalFirstRow.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'HeaderData1VerticalLastRow
        '
        Me.HeaderData1VerticalLastRow.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.HeaderData1VerticalLastRow.BorderColor = System.Drawing.Color.White
        Me.HeaderData1VerticalLastRow.Borders = CType((DevExpress.XtraPrinting.BorderSide.Right Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.HeaderData1VerticalLastRow.BorderWidth = 2.0!
        Me.HeaderData1VerticalLastRow.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold)
        Me.HeaderData1VerticalLastRow.ForeColor = System.Drawing.Color.White
        Me.HeaderData1VerticalLastRow.Name = "HeaderData1VerticalLastRow"
        Me.HeaderData1VerticalLastRow.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.HeaderData1VerticalLastRow.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'HeaderData1VerticalRow_Even
        '
        Me.HeaderData1VerticalRow_Even.BackColor = System.Drawing.Color.FromArgb(CType(CType(106, Byte), Integer), CType(CType(131, Byte), Integer), CType(CType(201, Byte), Integer))
        Me.HeaderData1VerticalRow_Even.BorderColor = System.Drawing.Color.White
        Me.HeaderData1VerticalRow_Even.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.HeaderData1VerticalRow_Even.BorderWidth = 2.0!
        Me.HeaderData1VerticalRow_Even.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold)
        Me.HeaderData1VerticalRow_Even.ForeColor = System.Drawing.Color.White
        Me.HeaderData1VerticalRow_Even.Name = "HeaderData1VerticalRow_Even"
        Me.HeaderData1VerticalRow_Even.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.HeaderData1VerticalRow_Even.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'TopMargin
        '
        Me.TopMargin.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel12, Me.XrLabel10, Me.label1})
        Me.TopMargin.ForeColor = System.Drawing.Color.Empty
        Me.TopMargin.HeightF = 256.25!
        Me.TopMargin.Name = "TopMargin"
        Me.TopMargin.StylePriority.UseForeColor = False
        '
        'XrLabel12
        '
        Me.XrLabel12.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel12.LocationFloat = New DevExpress.Utils.PointFloat(380.9846!, 223.25!)
        Me.XrLabel12.Multiline = True
        Me.XrLabel12.Name = "XrLabel12"
        Me.XrLabel12.Padding = New DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100.0!)
        Me.XrLabel12.SizeF = New System.Drawing.SizeF(110.0!, 23.0!)
        Me.XrLabel12.StylePriority.UseFont = False
        Me.XrLabel12.StylePriority.UseTextAlignment = False
        Me.XrLabel12.Text = "Registrert dato:"
        Me.XrLabel12.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight
        '
        'XrLabel10
        '
        Me.XrLabel10.BackColor = System.Drawing.Color.Transparent
        Me.XrLabel10.BorderColor = System.Drawing.Color.White
        Me.XrLabel10.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel10.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel10.BorderWidth = 2.0!
        Me.XrLabel10.CanGrow = False
        Me.XrLabel10.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[regDate]")})
        Me.XrLabel10.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel10.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel10.LocationFloat = New DevExpress.Utils.PointFloat(490.9846!, 223.25!)
        Me.XrLabel10.Name = "XrLabel10"
        Me.XrLabel10.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel10.SizeF = New System.Drawing.SizeF(159.0154!, 22.99998!)
        Me.XrLabel10.StyleName = "DetailData1VerticalRow_Even"
        Me.XrLabel10.StylePriority.UseBackColor = False
        Me.XrLabel10.StylePriority.UseBorderColor = False
        Me.XrLabel10.StylePriority.UseBorderDashStyle = False
        Me.XrLabel10.StylePriority.UseBorders = False
        Me.XrLabel10.StylePriority.UseBorderWidth = False
        Me.XrLabel10.StylePriority.UseFont = False
        Me.XrLabel10.StylePriority.UseForeColor = False
        Me.XrLabel10.StylePriority.UsePadding = False
        Me.XrLabel10.StylePriority.UseTextAlignment = False
        Me.XrLabel10.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel10.WordWrap = False
        '
        'label1
        '
        Me.label1.Font = New System.Drawing.Font("Arial", 20.0!, System.Drawing.FontStyle.Bold)
        Me.label1.LocationFloat = New DevExpress.Utils.PointFloat(161.4584!, 70.41667!)
        Me.label1.Name = "label1"
        Me.label1.SizeF = New System.Drawing.SizeF(329.5262!, 54.50001!)
        Me.label1.StyleName = "Title"
        Me.label1.StylePriority.UseFont = False
        Me.label1.StylePriority.UseTextAlignment = False
        Me.label1.Text = "DEKK INNLEVERING"
        Me.label1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter
        '
        'BottomMargin
        '
        Me.BottomMargin.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.pageInfo2})
        Me.BottomMargin.Name = "BottomMargin"
        '
        'pageInfo2
        '
        Me.pageInfo2.LocationFloat = New DevExpress.Utils.PointFloat(325.0!, 9.999974!)
        Me.pageInfo2.Name = "pageInfo2"
        Me.pageInfo2.SizeF = New System.Drawing.SizeF(325.0!, 23.0!)
        Me.pageInfo2.StyleName = "PageInfo"
        Me.pageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight
        Me.pageInfo2.TextFormatString = "Page {0} of {1}"
        '
        'pageInfo1
        '
        Me.pageInfo1.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.pageInfo1.LocationFloat = New DevExpress.Utils.PointFloat(0.00003178914!, 600.4584!)
        Me.pageInfo1.Name = "pageInfo1"
        Me.pageInfo1.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime
        Me.pageInfo1.SizeF = New System.Drawing.SizeF(325.0!, 23.0!)
        Me.pageInfo1.StyleName = "PageInfo"
        Me.pageInfo1.StylePriority.UseFont = False
        Me.pageInfo1.StylePriority.UseTextAlignment = False
        Me.pageInfo1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        '
        'ReportHeader
        '
        Me.ReportHeader.HeightF = 60.0!
        Me.ReportHeader.Name = "ReportHeader"
        '
        'VerticalHeader
        '
        Me.VerticalHeader.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.XrLabel24, Me.XrLabel23, Me.XrLabel22, Me.XrLabel15, Me.XrLabel18, Me.XrLabel16, Me.XrLabel17, Me.XrLabel19, Me.XrLabel20, Me.XrLabel21, Me.XrLabel25})
        Me.VerticalHeader.HeightF = 655.6667!
        Me.VerticalHeader.Name = "VerticalHeader"
        Me.VerticalHeader.RepeatEveryPage = True
        Me.VerticalHeader.WidthF = 143.75!
        '
        'XrLabel24
        '
        Me.XrLabel24.BackColor = System.Drawing.Color.FromArgb(CType(CType(106, Byte), Integer), CType(CType(131, Byte), Integer), CType(CType(201, Byte), Integer))
        Me.XrLabel24.BorderColor = System.Drawing.Color.White
        Me.XrLabel24.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel24.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel24.BorderWidth = 2.0!
        Me.XrLabel24.CanGrow = False
        Me.XrLabel24.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel24.ForeColor = System.Drawing.Color.White
        Me.XrLabel24.LocationFloat = New DevExpress.Utils.PointFloat(0!, 570.3753!)
        Me.XrLabel24.Name = "XrLabel24"
        Me.XrLabel24.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel24.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel24.StyleName = "HeaderData1VerticalRow_Even"
        Me.XrLabel24.StylePriority.UseBackColor = False
        Me.XrLabel24.StylePriority.UseBorderColor = False
        Me.XrLabel24.StylePriority.UseBorderDashStyle = False
        Me.XrLabel24.StylePriority.UseBorders = False
        Me.XrLabel24.StylePriority.UseBorderWidth = False
        Me.XrLabel24.StylePriority.UseFont = False
        Me.XrLabel24.StylePriority.UseForeColor = False
        Me.XrLabel24.StylePriority.UsePadding = False
        Me.XrLabel24.StylePriority.UseTextAlignment = False
        Me.XrLabel24.Text = "Kundens signatur:"
        Me.XrLabel24.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel24.WordWrap = False
        '
        'XrLabel23
        '
        Me.XrLabel23.BackColor = System.Drawing.Color.FromArgb(CType(CType(106, Byte), Integer), CType(CType(131, Byte), Integer), CType(CType(201, Byte), Integer))
        Me.XrLabel23.BorderColor = System.Drawing.Color.White
        Me.XrLabel23.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel23.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel23.BorderWidth = 2.0!
        Me.XrLabel23.CanGrow = False
        Me.XrLabel23.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel23.ForeColor = System.Drawing.Color.White
        Me.XrLabel23.LocationFloat = New DevExpress.Utils.PointFloat(0!, 224.1666!)
        Me.XrLabel23.Name = "XrLabel23"
        Me.XrLabel23.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel23.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel23.StyleName = "HeaderData1VerticalRow_Even"
        Me.XrLabel23.StylePriority.UseBackColor = False
        Me.XrLabel23.StylePriority.UseBorderColor = False
        Me.XrLabel23.StylePriority.UseBorderDashStyle = False
        Me.XrLabel23.StylePriority.UseBorders = False
        Me.XrLabel23.StylePriority.UseBorderWidth = False
        Me.XrLabel23.StylePriority.UseFont = False
        Me.XrLabel23.StylePriority.UseForeColor = False
        Me.XrLabel23.StylePriority.UsePadding = False
        Me.XrLabel23.StylePriority.UseTextAlignment = False
        Me.XrLabel23.Text = "Dekkmerke"
        Me.XrLabel23.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel23.WordWrap = False
        '
        'XrLabel22
        '
        Me.XrLabel22.BackColor = System.Drawing.Color.FromArgb(CType(CType(106, Byte), Integer), CType(CType(131, Byte), Integer), CType(CType(201, Byte), Integer))
        Me.XrLabel22.BorderColor = System.Drawing.Color.White
        Me.XrLabel22.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel22.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel22.BorderWidth = 2.0!
        Me.XrLabel22.CanGrow = False
        Me.XrLabel22.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel22.ForeColor = System.Drawing.Color.White
        Me.XrLabel22.LocationFloat = New DevExpress.Utils.PointFloat(0!, 168.1666!)
        Me.XrLabel22.Name = "XrLabel22"
        Me.XrLabel22.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel22.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel22.StyleName = "HeaderData1VerticalRow_Even"
        Me.XrLabel22.StylePriority.UseBackColor = False
        Me.XrLabel22.StylePriority.UseBorderColor = False
        Me.XrLabel22.StylePriority.UseBorderDashStyle = False
        Me.XrLabel22.StylePriority.UseBorders = False
        Me.XrLabel22.StylePriority.UseBorderWidth = False
        Me.XrLabel22.StylePriority.UseFont = False
        Me.XrLabel22.StylePriority.UseForeColor = False
        Me.XrLabel22.StylePriority.UsePadding = False
        Me.XrLabel22.StylePriority.UseTextAlignment = False
        Me.XrLabel22.Text = "Dekktype"
        Me.XrLabel22.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel22.WordWrap = False
        '
        'XrLabel15
        '
        Me.XrLabel15.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.XrLabel15.BorderColor = System.Drawing.Color.White
        Me.XrLabel15.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel15.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel15.BorderWidth = 2.0!
        Me.XrLabel15.CanGrow = False
        Me.XrLabel15.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel15.ForeColor = System.Drawing.Color.White
        Me.XrLabel15.LocationFloat = New DevExpress.Utils.PointFloat(0!, 84.16659!)
        Me.XrLabel15.Name = "XrLabel15"
        Me.XrLabel15.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel15.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel15.StyleName = "HeaderData1Vertical"
        Me.XrLabel15.StylePriority.UseBackColor = False
        Me.XrLabel15.StylePriority.UseBorderColor = False
        Me.XrLabel15.StylePriority.UseBorderDashStyle = False
        Me.XrLabel15.StylePriority.UseBorders = False
        Me.XrLabel15.StylePriority.UseBorderWidth = False
        Me.XrLabel15.StylePriority.UseFont = False
        Me.XrLabel15.StylePriority.UseForeColor = False
        Me.XrLabel15.StylePriority.UsePadding = False
        Me.XrLabel15.StylePriority.UseTextAlignment = False
        Me.XrLabel15.Text = "Registreringsnr."
        Me.XrLabel15.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel15.WordWrap = False
        '
        'XrLabel18
        '
        Me.XrLabel18.BackColor = System.Drawing.Color.FromArgb(CType(CType(106, Byte), Integer), CType(CType(131, Byte), Integer), CType(CType(201, Byte), Integer))
        Me.XrLabel18.BorderColor = System.Drawing.Color.White
        Me.XrLabel18.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel18.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel18.BorderWidth = 2.0!
        Me.XrLabel18.CanGrow = False
        Me.XrLabel18.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel18.ForeColor = System.Drawing.Color.White
        Me.XrLabel18.LocationFloat = New DevExpress.Utils.PointFloat(0!, 56.16659!)
        Me.XrLabel18.Name = "XrLabel18"
        Me.XrLabel18.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel18.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel18.StyleName = "HeaderData1VerticalRow_Even"
        Me.XrLabel18.StylePriority.UseBackColor = False
        Me.XrLabel18.StylePriority.UseBorderColor = False
        Me.XrLabel18.StylePriority.UseBorderDashStyle = False
        Me.XrLabel18.StylePriority.UseBorders = False
        Me.XrLabel18.StylePriority.UseBorderWidth = False
        Me.XrLabel18.StylePriority.UseFont = False
        Me.XrLabel18.StylePriority.UseForeColor = False
        Me.XrLabel18.StylePriority.UsePadding = False
        Me.XrLabel18.StylePriority.UseTextAlignment = False
        Me.XrLabel18.Text = "Dekkpakkenr."
        Me.XrLabel18.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel18.WordWrap = False
        '
        'XrLabel16
        '
        Me.XrLabel16.BackColor = System.Drawing.Color.FromArgb(CType(CType(106, Byte), Integer), CType(CType(131, Byte), Integer), CType(CType(201, Byte), Integer))
        Me.XrLabel16.BorderColor = System.Drawing.Color.White
        Me.XrLabel16.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel16.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel16.BorderWidth = 2.0!
        Me.XrLabel16.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel16.ForeColor = System.Drawing.Color.White
        Me.XrLabel16.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.XrLabel16.Name = "XrLabel16"
        Me.XrLabel16.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel16.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel16.StyleName = "HeaderData1VerticalRow_Even"
        Me.XrLabel16.StylePriority.UseBackColor = False
        Me.XrLabel16.StylePriority.UseBorderColor = False
        Me.XrLabel16.StylePriority.UseBorderDashStyle = False
        Me.XrLabel16.StylePriority.UseBorders = False
        Me.XrLabel16.StylePriority.UseBorderWidth = False
        Me.XrLabel16.StylePriority.UseFont = False
        Me.XrLabel16.StylePriority.UseForeColor = False
        Me.XrLabel16.StylePriority.UsePadding = False
        Me.XrLabel16.StylePriority.UseTextAlignment = False
        Me.XrLabel16.Text = "Kundenummer"
        Me.XrLabel16.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel16.WordWrap = False
        '
        'XrLabel17
        '
        Me.XrLabel17.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.XrLabel17.BorderColor = System.Drawing.Color.White
        Me.XrLabel17.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel17.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel17.BorderWidth = 2.0!
        Me.XrLabel17.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel17.ForeColor = System.Drawing.Color.White
        Me.XrLabel17.LocationFloat = New DevExpress.Utils.PointFloat(0!, 28.0!)
        Me.XrLabel17.Name = "XrLabel17"
        Me.XrLabel17.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel17.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel17.StyleName = "HeaderData1Vertical"
        Me.XrLabel17.StylePriority.UseBackColor = False
        Me.XrLabel17.StylePriority.UseBorderColor = False
        Me.XrLabel17.StylePriority.UseBorderDashStyle = False
        Me.XrLabel17.StylePriority.UseBorders = False
        Me.XrLabel17.StylePriority.UseBorderWidth = False
        Me.XrLabel17.StylePriority.UseFont = False
        Me.XrLabel17.StylePriority.UseForeColor = False
        Me.XrLabel17.StylePriority.UsePadding = False
        Me.XrLabel17.StylePriority.UseTextAlignment = False
        Me.XrLabel17.Text = "Kundenavn"
        Me.XrLabel17.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel17.WordWrap = False
        '
        'XrLabel19
        '
        Me.XrLabel19.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.XrLabel19.BorderColor = System.Drawing.Color.White
        Me.XrLabel19.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel19.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel19.BorderWidth = 2.0!
        Me.XrLabel19.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel19.ForeColor = System.Drawing.Color.White
        Me.XrLabel19.LocationFloat = New DevExpress.Utils.PointFloat(0!, 140.1666!)
        Me.XrLabel19.Name = "XrLabel19"
        Me.XrLabel19.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel19.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel19.StyleName = "HeaderData1Vertical"
        Me.XrLabel19.StylePriority.UseBackColor = False
        Me.XrLabel19.StylePriority.UseBorderColor = False
        Me.XrLabel19.StylePriority.UseBorderDashStyle = False
        Me.XrLabel19.StylePriority.UseBorders = False
        Me.XrLabel19.StylePriority.UseBorderWidth = False
        Me.XrLabel19.StylePriority.UseFont = False
        Me.XrLabel19.StylePriority.UseForeColor = False
        Me.XrLabel19.StylePriority.UsePadding = False
        Me.XrLabel19.StylePriority.UseTextAlignment = False
        Me.XrLabel19.Text = "Antall dekk"
        Me.XrLabel19.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel19.WordWrap = False
        '
        'XrLabel20
        '
        Me.XrLabel20.BackColor = System.Drawing.Color.FromArgb(CType(CType(106, Byte), Integer), CType(CType(131, Byte), Integer), CType(CType(201, Byte), Integer))
        Me.XrLabel20.BorderColor = System.Drawing.Color.White
        Me.XrLabel20.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel20.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel20.BorderWidth = 2.0!
        Me.XrLabel20.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel20.ForeColor = System.Drawing.Color.White
        Me.XrLabel20.LocationFloat = New DevExpress.Utils.PointFloat(0!, 112.1666!)
        Me.XrLabel20.Name = "XrLabel20"
        Me.XrLabel20.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel20.SizeF = New System.Drawing.SizeF(143.75!, 28.0!)
        Me.XrLabel20.StyleName = "HeaderData1VerticalRow_Even"
        Me.XrLabel20.StylePriority.UseBackColor = False
        Me.XrLabel20.StylePriority.UseBorderColor = False
        Me.XrLabel20.StylePriority.UseBorderDashStyle = False
        Me.XrLabel20.StylePriority.UseBorders = False
        Me.XrLabel20.StylePriority.UseBorderWidth = False
        Me.XrLabel20.StylePriority.UseFont = False
        Me.XrLabel20.StylePriority.UseForeColor = False
        Me.XrLabel20.StylePriority.UsePadding = False
        Me.XrLabel20.StylePriority.UseTextAlignment = False
        Me.XrLabel20.Text = "Dekklokasjon"
        Me.XrLabel20.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel20.WordWrap = False
        '
        'XrLabel21
        '
        Me.XrLabel21.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.XrLabel21.BorderColor = System.Drawing.Color.White
        Me.XrLabel21.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel21.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel21.BorderWidth = 2.0!
        Me.XrLabel21.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel21.ForeColor = System.Drawing.Color.White
        Me.XrLabel21.LocationFloat = New DevExpress.Utils.PointFloat(0!, 196.1666!)
        Me.XrLabel21.Name = "XrLabel21"
        Me.XrLabel21.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel21.SizeF = New System.Drawing.SizeF(143.75!, 28.00002!)
        Me.XrLabel21.StyleName = "HeaderData1Vertical"
        Me.XrLabel21.StylePriority.UseBackColor = False
        Me.XrLabel21.StylePriority.UseBorderColor = False
        Me.XrLabel21.StylePriority.UseBorderDashStyle = False
        Me.XrLabel21.StylePriority.UseBorders = False
        Me.XrLabel21.StylePriority.UseBorderWidth = False
        Me.XrLabel21.StylePriority.UseFont = False
        Me.XrLabel21.StylePriority.UseForeColor = False
        Me.XrLabel21.StylePriority.UsePadding = False
        Me.XrLabel21.StylePriority.UseTextAlignment = False
        Me.XrLabel21.Text = "Pigg/uten pigg"
        Me.XrLabel21.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel21.WordWrap = False
        '
        'XrLabel25
        '
        Me.XrLabel25.BackColor = System.Drawing.Color.FromArgb(CType(CType(83, Byte), Integer), CType(CType(110, Byte), Integer), CType(CType(190, Byte), Integer))
        Me.XrLabel25.BorderColor = System.Drawing.Color.White
        Me.XrLabel25.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel25.Borders = CType((DevExpress.XtraPrinting.BorderSide.Right Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrLabel25.BorderWidth = 2.0!
        Me.XrLabel25.Font = New System.Drawing.Font("Arial", 10.0!, System.Drawing.FontStyle.Bold)
        Me.XrLabel25.ForeColor = System.Drawing.Color.White
        Me.XrLabel25.LocationFloat = New DevExpress.Utils.PointFloat(0!, 252.1666!)
        Me.XrLabel25.Name = "XrLabel25"
        Me.XrLabel25.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel25.SizeF = New System.Drawing.SizeF(143.75!, 73.8334!)
        Me.XrLabel25.StyleName = "HeaderData1VerticalLastRow"
        Me.XrLabel25.StylePriority.UseBackColor = False
        Me.XrLabel25.StylePriority.UseBorderColor = False
        Me.XrLabel25.StylePriority.UseBorderDashStyle = False
        Me.XrLabel25.StylePriority.UseBorders = False
        Me.XrLabel25.StylePriority.UseBorderWidth = False
        Me.XrLabel25.StylePriority.UseFont = False
        Me.XrLabel25.StylePriority.UseForeColor = False
        Me.XrLabel25.StylePriority.UsePadding = False
        Me.XrLabel25.StylePriority.UseTextAlignment = False
        Me.XrLabel25.Text = "Anmerkninger"
        Me.XrLabel25.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.XrLabel25.WordWrap = False
        '
        'VerticalDetail
        '
        Me.VerticalDetail.Controls.AddRange(New DevExpress.XtraReports.UI.XRControl() {Me.pageInfo1, Me.XrLine1, Me.XrLabel9, Me.XrLabel13, Me.XrLabel14, Me.XrLabel3, Me.XrLabel2, Me.XrLabel1, Me.XrLabel4, Me.XrLabel5, Me.XrLabel6, Me.XrLabel7, Me.XrLabel8, Me.XrLabel11})
        Me.VerticalDetail.HeightF = 655.6667!
        Me.VerticalDetail.Name = "VerticalDetail"
        Me.VerticalDetail.WidthF = 458.8415!
        '
        'XrLine1
        '
        Me.XrLine1.LocationFloat = New DevExpress.Utils.PointFloat(0!, 588.9167!)
        Me.XrLine1.Name = "XrLine1"
        Me.XrLine1.SizeF = New System.Drawing.SizeF(401.9664!, 23.0!)
        '
        'XrLabel9
        '
        Me.XrLabel9.BackColor = System.Drawing.Color.Transparent
        Me.XrLabel9.BorderColor = System.Drawing.Color.White
        Me.XrLabel9.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel9.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel9.BorderWidth = 2.0!
        Me.XrLabel9.CanGrow = False
        Me.XrLabel9.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireBrandDesc]")})
        Me.XrLabel9.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel9.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel9.LocationFloat = New DevExpress.Utils.PointFloat(0.00003147125!, 224.1666!)
        Me.XrLabel9.Name = "XrLabel9"
        Me.XrLabel9.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel9.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel9.StyleName = "DetailData1VerticalRow_Even"
        Me.XrLabel9.StylePriority.UseBackColor = False
        Me.XrLabel9.StylePriority.UseBorderColor = False
        Me.XrLabel9.StylePriority.UseBorderDashStyle = False
        Me.XrLabel9.StylePriority.UseBorders = False
        Me.XrLabel9.StylePriority.UseBorderWidth = False
        Me.XrLabel9.StylePriority.UseFont = False
        Me.XrLabel9.StylePriority.UseForeColor = False
        Me.XrLabel9.StylePriority.UsePadding = False
        Me.XrLabel9.StylePriority.UseTextAlignment = False
        Me.XrLabel9.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel9.WordWrap = False
        '
        'XrLabel13
        '
        Me.XrLabel13.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.XrLabel13.BorderColor = System.Drawing.Color.White
        Me.XrLabel13.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel13.Borders = CType((DevExpress.XtraPrinting.BorderSide.Right Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrLabel13.BorderWidth = 2.0!
        Me.XrLabel13.CanGrow = False
        Me.XrLabel13.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[custlName]")})
        Me.XrLabel13.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel13.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel13.LocationFloat = New DevExpress.Utils.PointFloat(230.0!, 28.00001!)
        Me.XrLabel13.Name = "XrLabel13"
        Me.XrLabel13.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel13.SizeF = New System.Drawing.SizeF(130.0!, 28.0!)
        Me.XrLabel13.StyleName = "DetailData1VerticalLastRow"
        Me.XrLabel13.StylePriority.UseBackColor = False
        Me.XrLabel13.StylePriority.UseBorderColor = False
        Me.XrLabel13.StylePriority.UseBorderDashStyle = False
        Me.XrLabel13.StylePriority.UseBorders = False
        Me.XrLabel13.StylePriority.UseBorderWidth = False
        Me.XrLabel13.StylePriority.UseFont = False
        Me.XrLabel13.StylePriority.UseForeColor = False
        Me.XrLabel13.StylePriority.UsePadding = False
        Me.XrLabel13.StylePriority.UseTextAlignment = False
        Me.XrLabel13.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel13.WordWrap = False
        '
        'XrLabel14
        '
        Me.XrLabel14.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.XrLabel14.BorderColor = System.Drawing.Color.White
        Me.XrLabel14.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel14.Borders = CType((DevExpress.XtraPrinting.BorderSide.Right Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrLabel14.BorderWidth = 2.0!
        Me.XrLabel14.CanGrow = False
        Me.XrLabel14.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[custmName]")})
        Me.XrLabel14.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel14.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel14.LocationFloat = New DevExpress.Utils.PointFloat(115.0!, 28.00001!)
        Me.XrLabel14.Name = "XrLabel14"
        Me.XrLabel14.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel14.SizeF = New System.Drawing.SizeF(115.0!, 28.0!)
        Me.XrLabel14.StyleName = "DetailData1VerticalLastRow"
        Me.XrLabel14.StylePriority.UseBackColor = False
        Me.XrLabel14.StylePriority.UseBorderColor = False
        Me.XrLabel14.StylePriority.UseBorderDashStyle = False
        Me.XrLabel14.StylePriority.UseBorders = False
        Me.XrLabel14.StylePriority.UseBorderWidth = False
        Me.XrLabel14.StylePriority.UseFont = False
        Me.XrLabel14.StylePriority.UseForeColor = False
        Me.XrLabel14.StylePriority.UsePadding = False
        Me.XrLabel14.StylePriority.UseTextAlignment = False
        Me.XrLabel14.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel14.WordWrap = False
        '
        'XrLabel3
        '
        Me.XrLabel3.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.XrLabel3.BorderColor = System.Drawing.Color.White
        Me.XrLabel3.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel3.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel3.BorderWidth = 2.0!
        Me.XrLabel3.CanGrow = False
        Me.XrLabel3.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[custName]")})
        Me.XrLabel3.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel3.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel3.LocationFloat = New DevExpress.Utils.PointFloat(0!, 28.00001!)
        Me.XrLabel3.Name = "XrLabel3"
        Me.XrLabel3.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel3.SizeF = New System.Drawing.SizeF(115.0!, 28.0!)
        Me.XrLabel3.StyleName = "DetailData1Vertical"
        Me.XrLabel3.StylePriority.UseBackColor = False
        Me.XrLabel3.StylePriority.UseBorderColor = False
        Me.XrLabel3.StylePriority.UseBorderDashStyle = False
        Me.XrLabel3.StylePriority.UseBorders = False
        Me.XrLabel3.StylePriority.UseBorderWidth = False
        Me.XrLabel3.StylePriority.UseFont = False
        Me.XrLabel3.StylePriority.UseForeColor = False
        Me.XrLabel3.StylePriority.UsePadding = False
        Me.XrLabel3.StylePriority.UseTextAlignment = False
        Me.XrLabel3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel3.WordWrap = False
        '
        'XrLabel2
        '
        Me.XrLabel2.BackColor = System.Drawing.Color.Transparent
        Me.XrLabel2.BorderColor = System.Drawing.Color.White
        Me.XrLabel2.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel2.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel2.BorderWidth = 2.0!
        Me.XrLabel2.CanGrow = False
        Me.XrLabel2.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[custNo]")})
        Me.XrLabel2.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel2.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel2.LocationFloat = New DevExpress.Utils.PointFloat(0!, 0!)
        Me.XrLabel2.Name = "XrLabel2"
        Me.XrLabel2.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel2.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel2.StyleName = "DetailData1VerticalRow_Even"
        Me.XrLabel2.StylePriority.UseBackColor = False
        Me.XrLabel2.StylePriority.UseBorderColor = False
        Me.XrLabel2.StylePriority.UseBorderDashStyle = False
        Me.XrLabel2.StylePriority.UseBorders = False
        Me.XrLabel2.StylePriority.UseBorderWidth = False
        Me.XrLabel2.StylePriority.UseFont = False
        Me.XrLabel2.StylePriority.UseForeColor = False
        Me.XrLabel2.StylePriority.UsePadding = False
        Me.XrLabel2.StylePriority.UseTextAlignment = False
        Me.XrLabel2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel2.WordWrap = False
        '
        'XrLabel1
        '
        Me.XrLabel1.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.XrLabel1.BorderColor = System.Drawing.Color.White
        Me.XrLabel1.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel1.Borders = CType((DevExpress.XtraPrinting.BorderSide.Top Or DevExpress.XtraPrinting.BorderSide.Right), DevExpress.XtraPrinting.BorderSide)
        Me.XrLabel1.BorderWidth = 2.0!
        Me.XrLabel1.CanGrow = False
        Me.XrLabel1.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[regNo]")})
        Me.XrLabel1.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel1.LocationFloat = New DevExpress.Utils.PointFloat(0!, 84.16659!)
        Me.XrLabel1.Name = "XrLabel1"
        Me.XrLabel1.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel1.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel1.StyleName = "DetailData1VerticalFirstRow"
        Me.XrLabel1.StylePriority.UseBackColor = False
        Me.XrLabel1.StylePriority.UseBorderColor = False
        Me.XrLabel1.StylePriority.UseBorderDashStyle = False
        Me.XrLabel1.StylePriority.UseBorders = False
        Me.XrLabel1.StylePriority.UseBorderWidth = False
        Me.XrLabel1.StylePriority.UseFont = False
        Me.XrLabel1.StylePriority.UseForeColor = False
        Me.XrLabel1.StylePriority.UsePadding = False
        Me.XrLabel1.StylePriority.UseTextAlignment = False
        Me.XrLabel1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel1.WordWrap = False
        '
        'XrLabel4
        '
        Me.XrLabel4.BackColor = System.Drawing.Color.Transparent
        Me.XrLabel4.BorderColor = System.Drawing.Color.White
        Me.XrLabel4.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel4.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel4.BorderWidth = 2.0!
        Me.XrLabel4.CanGrow = False
        Me.XrLabel4.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tirePackageNo]")})
        Me.XrLabel4.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel4.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel4.LocationFloat = New DevExpress.Utils.PointFloat(0!, 56.00001!)
        Me.XrLabel4.Name = "XrLabel4"
        Me.XrLabel4.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel4.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel4.StyleName = "DetailData1VerticalRow_Even"
        Me.XrLabel4.StylePriority.UseBackColor = False
        Me.XrLabel4.StylePriority.UseBorderColor = False
        Me.XrLabel4.StylePriority.UseBorderDashStyle = False
        Me.XrLabel4.StylePriority.UseBorders = False
        Me.XrLabel4.StylePriority.UseBorderWidth = False
        Me.XrLabel4.StylePriority.UseFont = False
        Me.XrLabel4.StylePriority.UseForeColor = False
        Me.XrLabel4.StylePriority.UsePadding = False
        Me.XrLabel4.StylePriority.UseTextAlignment = False
        Me.XrLabel4.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel4.WordWrap = False
        '
        'XrLabel5
        '
        Me.XrLabel5.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.XrLabel5.BorderColor = System.Drawing.Color.White
        Me.XrLabel5.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel5.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel5.BorderWidth = 2.0!
        Me.XrLabel5.CanGrow = False
        Me.XrLabel5.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[qtyTire]")})
        Me.XrLabel5.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel5.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel5.LocationFloat = New DevExpress.Utils.PointFloat(0!, 140.1666!)
        Me.XrLabel5.Name = "XrLabel5"
        Me.XrLabel5.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel5.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel5.StyleName = "DetailData1Vertical"
        Me.XrLabel5.StylePriority.UseBackColor = False
        Me.XrLabel5.StylePriority.UseBorderColor = False
        Me.XrLabel5.StylePriority.UseBorderDashStyle = False
        Me.XrLabel5.StylePriority.UseBorders = False
        Me.XrLabel5.StylePriority.UseBorderWidth = False
        Me.XrLabel5.StylePriority.UseFont = False
        Me.XrLabel5.StylePriority.UseForeColor = False
        Me.XrLabel5.StylePriority.UsePadding = False
        Me.XrLabel5.StylePriority.UseTextAlignment = False
        Me.XrLabel5.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel5.WordWrap = False
        '
        'XrLabel6
        '
        Me.XrLabel6.BackColor = System.Drawing.Color.Transparent
        Me.XrLabel6.BorderColor = System.Drawing.Color.White
        Me.XrLabel6.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel6.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel6.BorderWidth = 2.0!
        Me.XrLabel6.CanGrow = False
        Me.XrLabel6.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[location]")})
        Me.XrLabel6.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel6.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel6.LocationFloat = New DevExpress.Utils.PointFloat(0!, 112.1666!)
        Me.XrLabel6.Name = "XrLabel6"
        Me.XrLabel6.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel6.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel6.StyleName = "DetailData1VerticalRow_Even"
        Me.XrLabel6.StylePriority.UseBackColor = False
        Me.XrLabel6.StylePriority.UseBorderColor = False
        Me.XrLabel6.StylePriority.UseBorderDashStyle = False
        Me.XrLabel6.StylePriority.UseBorders = False
        Me.XrLabel6.StylePriority.UseBorderWidth = False
        Me.XrLabel6.StylePriority.UseFont = False
        Me.XrLabel6.StylePriority.UseForeColor = False
        Me.XrLabel6.StylePriority.UsePadding = False
        Me.XrLabel6.StylePriority.UseTextAlignment = False
        Me.XrLabel6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel6.WordWrap = False
        '
        'XrLabel7
        '
        Me.XrLabel7.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.XrLabel7.BorderColor = System.Drawing.Color.White
        Me.XrLabel7.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel7.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel7.BorderWidth = 2.0!
        Me.XrLabel7.CanGrow = False
        Me.XrLabel7.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireSpikesDesc]")})
        Me.XrLabel7.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel7.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel7.LocationFloat = New DevExpress.Utils.PointFloat(0.00003178914!, 196.1666!)
        Me.XrLabel7.Name = "XrLabel7"
        Me.XrLabel7.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel7.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel7.StyleName = "DetailData1Vertical"
        Me.XrLabel7.StylePriority.UseBackColor = False
        Me.XrLabel7.StylePriority.UseBorderColor = False
        Me.XrLabel7.StylePriority.UseBorderDashStyle = False
        Me.XrLabel7.StylePriority.UseBorders = False
        Me.XrLabel7.StylePriority.UseBorderWidth = False
        Me.XrLabel7.StylePriority.UseFont = False
        Me.XrLabel7.StylePriority.UseForeColor = False
        Me.XrLabel7.StylePriority.UsePadding = False
        Me.XrLabel7.StylePriority.UseTextAlignment = False
        Me.XrLabel7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel7.WordWrap = False
        '
        'XrLabel8
        '
        Me.XrLabel8.BackColor = System.Drawing.Color.Transparent
        Me.XrLabel8.BorderColor = System.Drawing.Color.White
        Me.XrLabel8.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel8.Borders = DevExpress.XtraPrinting.BorderSide.Right
        Me.XrLabel8.BorderWidth = 2.0!
        Me.XrLabel8.CanGrow = False
        Me.XrLabel8.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireTypeDesc]")})
        Me.XrLabel8.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel8.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel8.LocationFloat = New DevExpress.Utils.PointFloat(0.00003178914!, 168.1666!)
        Me.XrLabel8.Name = "XrLabel8"
        Me.XrLabel8.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel8.SizeF = New System.Drawing.SizeF(145.8333!, 28.0!)
        Me.XrLabel8.StyleName = "DetailData1VerticalRow_Even"
        Me.XrLabel8.StylePriority.UseBackColor = False
        Me.XrLabel8.StylePriority.UseBorderColor = False
        Me.XrLabel8.StylePriority.UseBorderDashStyle = False
        Me.XrLabel8.StylePriority.UseBorders = False
        Me.XrLabel8.StylePriority.UseBorderWidth = False
        Me.XrLabel8.StylePriority.UseFont = False
        Me.XrLabel8.StylePriority.UseForeColor = False
        Me.XrLabel8.StylePriority.UsePadding = False
        Me.XrLabel8.StylePriority.UseTextAlignment = False
        Me.XrLabel8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft
        Me.XrLabel8.WordWrap = False
        '
        'XrLabel11
        '
        Me.XrLabel11.BackColor = System.Drawing.Color.FromArgb(CType(CType(243, Byte), Integer), CType(CType(245, Byte), Integer), CType(CType(248, Byte), Integer))
        Me.XrLabel11.BorderColor = System.Drawing.Color.White
        Me.XrLabel11.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid
        Me.XrLabel11.Borders = CType((DevExpress.XtraPrinting.BorderSide.Right Or DevExpress.XtraPrinting.BorderSide.Bottom), DevExpress.XtraPrinting.BorderSide)
        Me.XrLabel11.BorderWidth = 2.0!
        Me.XrLabel11.CanGrow = False
        Me.XrLabel11.ExpressionBindings.AddRange(New DevExpress.XtraReports.UI.ExpressionBinding() {New DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[tireAnnot]")})
        Me.XrLabel11.Font = New System.Drawing.Font("Arial", 10.0!)
        Me.XrLabel11.ForeColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer), CType(CType(51, Byte), Integer))
        Me.XrLabel11.LocationFloat = New DevExpress.Utils.PointFloat(0!, 252.1666!)
        Me.XrLabel11.Multiline = True
        Me.XrLabel11.Name = "XrLabel11"
        Me.XrLabel11.Padding = New DevExpress.XtraPrinting.PaddingInfo(6, 6, 0, 0, 100.0!)
        Me.XrLabel11.SizeF = New System.Drawing.SizeF(360.0!, 73.83337!)
        Me.XrLabel11.StyleName = "DetailData1VerticalLastRow"
        Me.XrLabel11.StylePriority.UseBackColor = False
        Me.XrLabel11.StylePriority.UseBorderColor = False
        Me.XrLabel11.StylePriority.UseBorderDashStyle = False
        Me.XrLabel11.StylePriority.UseBorders = False
        Me.XrLabel11.StylePriority.UseBorderWidth = False
        Me.XrLabel11.StylePriority.UseFont = False
        Me.XrLabel11.StylePriority.UseForeColor = False
        Me.XrLabel11.StylePriority.UsePadding = False
        Me.XrLabel11.StylePriority.UseTextAlignment = False
        Me.XrLabel11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft
        Me.XrLabel11.TextTrimming = System.Drawing.StringTrimming.Word
        '
        'pTirePackageNo
        '
        Me.pTirePackageNo.Name = "pTirePackageNo"
        '
        'dxTireDeliveryReport
        '
        Me.Bands.AddRange(New DevExpress.XtraReports.UI.Band() {Me.TopMargin, Me.BottomMargin, Me.ReportHeader, Me.VerticalHeader, Me.VerticalDetail})
        Me.ComponentStorage.AddRange(New System.ComponentModel.IComponent() {Me.SqlDataSource1})
        Me.DataMember = "TBL_TIRE_ORDER_PACKAGE_1"
        Me.DataSource = Me.SqlDataSource1
        Me.Font = New System.Drawing.Font("Arial", 9.75!)
        Me.Margins = New System.Drawing.Printing.Margins(100, 100, 256, 100)
        Me.Parameters.AddRange(New DevExpress.XtraReports.Parameters.Parameter() {Me.pTirePackageNo})
        Me.StyleSheet.AddRange(New DevExpress.XtraReports.UI.XRControlStyle() {Me.Title, Me.PageInfo, Me.DetailData1Vertical, Me.DetailData1VerticalFirstRow, Me.DetailData1VerticalLastRow, Me.DetailData1VerticalRow_Even, Me.HeaderData1Vertical, Me.HeaderData1VerticalFirstRow, Me.HeaderData1VerticalLastRow, Me.HeaderData1VerticalRow_Even})
        Me.Version = "20.2"
        Me.VerticalContentSplitting = DevExpress.XtraPrinting.VerticalContentSplitting.Smart
        CType(Me, System.ComponentModel.ISupportInitialize).EndInit()

    End Sub

    Friend WithEvents SqlDataSource1 As DevExpress.DataAccess.Sql.SqlDataSource
    Friend WithEvents Title As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents PageInfo As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents DetailData1Vertical As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents DetailData1VerticalFirstRow As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents DetailData1VerticalLastRow As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents DetailData1VerticalRow_Even As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents HeaderData1Vertical As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents HeaderData1VerticalFirstRow As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents HeaderData1VerticalLastRow As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents HeaderData1VerticalRow_Even As DevExpress.XtraReports.UI.XRControlStyle
    Friend WithEvents TopMargin As DevExpress.XtraReports.UI.TopMarginBand
    Friend WithEvents BottomMargin As DevExpress.XtraReports.UI.BottomMarginBand
    Friend WithEvents pageInfo1 As DevExpress.XtraReports.UI.XRPageInfo
    Friend WithEvents pageInfo2 As DevExpress.XtraReports.UI.XRPageInfo
    Friend WithEvents ReportHeader As DevExpress.XtraReports.UI.ReportHeaderBand
    Friend WithEvents label1 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents VerticalHeader As DevExpress.XtraReports.UI.VerticalHeaderBand
    Friend WithEvents VerticalDetail As DevExpress.XtraReports.UI.VerticalDetailBand
    Friend WithEvents pTirePackageNo As DevExpress.XtraReports.Parameters.Parameter
    Friend WithEvents XrLabel12 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel10 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel18 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel16 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel17 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel19 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel20 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel21 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel25 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel13 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel14 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel3 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel2 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel1 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel4 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel5 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel6 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel7 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel11 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel23 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel22 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel15 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel9 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel8 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLabel24 As DevExpress.XtraReports.UI.XRLabel
    Friend WithEvents XrLine1 As DevExpress.XtraReports.UI.XRLine
End Class
