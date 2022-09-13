Imports System.Drawing
Imports System.Globalization
Imports System.Threading
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS
Imports DevExpress.Web
Public Class MasterPage
    Inherits System.Web.UI.MasterPage
    Dim objConfigRoleBO As New ConfigRoleBO
    Dim objConfigRoleMenu As New Services.ConfigRole.Role
    Dim objConfigRoleDO As New CoreLibrary.CARS.Role.ConfigRoleDO
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        EnableViewState = False
        Page.Header.DataBind()
        hlnkMSGLogout.NavigateUrl = "~/frmLogin.aspx"

        If Session("UserId") Is Nothing Then
            RTLblUser.Text = "'" + "ABS-10 User" + "'"
        Else
            If Not Page.IsPostBack Then
                RTLblUser.Text = "'" + Session("UserId") + "'" ' + Request.PhysicalPath.ToString()
                RTlblver.Text = IIf(System.Configuration.ConfigurationManager.AppSettings("Version") Is Nothing, "", System.Configuration.ConfigurationManager.AppSettings("Version"))
            End If
        End If
        If Session("ParamSelLang") IsNot Nothing Then
            cbSelectLanguage.Value = Session("ParamSelLang").ToString
        Else
            cbSelectLanguage.SelectedIndex = 0
        End If
        Dim ds As New DataSet
        ds = Session("usermenu")
        If (ds Is Nothing) Then
            objConfigRoleBO.User = Session("UserId")
            objConfigRoleBO.LanguageId = ConfigurationManager.AppSettings("Language")
            ds = objConfigRoleMenu.FetchAllMenuData(objConfigRoleBO)
            Session("usermenu") = ds
        End If
        DrawUserMenu(ds)
    End Sub

    Protected Sub callbackLanguage_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)
        Dim cbparam As String = e.Parameter
        Session("ParamSelLang") = e.Parameter
        HttpContext.Current.Session("culture") = cbparam
        If HttpContext.Current.Session("culture") = "en-US" Then
            HttpContext.Current.Session("Current_Language") = "ENGLISH"
            HttpContext.Current.Session("Decimal_Seperator") = "."
            HttpContext.Current.Session("Thousand_Seperator") = ","
            HttpRuntime.Cache.Insert("CarsCulture", "en-US")
            'ElseIf HttpContext.Current.Session("culture") = "nb-NO" Then
        Else
            HttpContext.Current.Session("Current_Language") = "NORWEGIAN"
            HttpContext.Current.Session("Decimal_Seperator") = ","
            HttpContext.Current.Session("Thousand_Seperator") = " "
            HttpRuntime.Cache.Insert("CarsCulture", "nb-NO")
        End If
        'Dim currPage As String = Me.Page.Request.FilePath
        Dim currPage As String = Request.Url.PathAndQuery
        ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute(currPage))
        'Server.Transfer(Request.Url.PathAndQuery, False)
    End Sub
    'To create a sidebar Menu to navigate to different page based on User permission
    Private Sub DrawUserMenu(ByVal ds As DataSet)
        Try
            Dim m As DevExpress.Web.MenuItem
            Dim i As Integer
            Dim dr As DataRow
            Dim lev As String
            Dim home As DevExpress.Web.MenuItem = New DevExpress.Web.MenuItem
            Dim DsUserScr As DataSet
            Dim DrUserScr As DataRow
            Dim startPage As String = ""
            'Adding the home Menu to navigate to a User Start Screen if configured 
            DsUserScr = objConfigRoleDO.GetUserStartScreen(CType(Session("UserID"), String))
            DrUserScr = DsUserScr.Tables(0).Rows(0)
            startPage = DrUserScr(0).ToString()
            home.ItemStyle.CssClass = "fas fa-home"
            home.NavigateUrl = Application("AppPath") & startPage
            home.Text = ""
            home.Name = "Home"
            mMain.Items.Add(home)
            For i = 0 To ds.Tables("TBL_UTIL_MOD_DETAILS").Rows.Count - 1

                m = New DevExpress.Web.MenuItem
                dr = ds.Tables("TBL_UTIL_MOD_DETAILS").Rows(i)
                m.Text = ""
                lev = dr("parentid").ToString()
                m.Name = dr("text").ToString()
                'Checking if the Menu is a Root Menu or not
                If lev = "" Then
                    submenus(m, ds.Tables("TBL_UTIL_MOD_DETAILS"), dr("MenuID").ToString(), dr("text").ToString(), dr("header_id"))

                    'Adding a icon to different menus based on the NAME_MODULE column value from table
                    m.ItemStyle.CssClass = "fas fa-users"
                    If (dr("NAME_MODULE") = "CUSTOMER") Then
                        m.ItemStyle.CssClass = "fas fa-users"
                    End If
                    If (dr("NAME_MODULE") = "VEHICLE") Then
                        m.ItemStyle.CssClass = "fas fa-car"
                    End If
                    If (dr("NAME_MODULE") = "WORK ORDER") Then
                        m.ItemStyle.CssClass = "fas fa-file-alt"
                    End If
                    If (dr("NAME_MODULE") = "TIME REGISTRATION") Then
                        m.ItemStyle.CssClass = "fas fa-clock"
                    End If
                    If (dr("NAME_MODULE") = "SPARES") Then
                        m.ItemStyle.CssClass = "fas fa-gem"
                    End If
                    If (dr("NAME_MODULE") = "PLANNING") Then
                        m.ItemStyle.CssClass = "far fa-calendar-alt"
                    End If
                    If (dr("NAME_MODULE") = "CONFIGURATION") Then
                        m.ItemStyle.CssClass = "fas fa-cog"
                    End If
                    If (dr("NAME_MODULE") = "HOTELS") Then
                        m.ItemStyle.CssClass = "fas fa-hotel"
                    End If
                    If (dr("NAME_MODULE") = "LA ACCOUNTING") Then
                        m.ItemStyle.CssClass = "fas fa-chart-line"
                    End If
                    ' Adding a root menu Item 
                    mMain.Items.Add(m)
                    If (dr("DESCRIPTION").ToString() <> "") Then
                        m.NavigateUrl = Application("AppPath") & dr("DESCRIPTION").ToString()
                    Else
                        m.NavigateUrl = ""
                    End If
                End If
            Next
        Catch exth As System.Threading.ThreadAbortException
            Throw exth
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub submenus(ByRef menuItemParent As DevExpress.Web.MenuItem, ByVal dt As DataTable, ByVal intmenuID As Integer, ByVal MenuName As String, ByVal headerId As Integer)
        Dim i As Integer
        Dim SitePath As String
        Dim menuItem As DevExpress.Web.MenuItem
        Dim headerMenu As DevExpress.Web.MenuItem
        Dim drSubMenu As DataRow
        Dim drs() As DataRow
        Dim drHead() As DataRow

        SitePath = Application("AppPath")
        'Checking if the Header Submenu for a Parent menu is configured
        drHead = dt.Select("menuid='" + headerId.ToString + "'")
        If (drHead.Count > 0) Then
            'Adding the Header Submenu at top of the SubMenu list 
            headerMenu = New DevExpress.Web.MenuItem
            headerMenu.Text = MenuName.ToUpper()
            headerMenu.ItemStyle.CssClass = "dividerHeader"
            headerMenu.NavigateUrl = SitePath & drHead(0)("DESCRIPTION").ToString()
            If drHead(0)("ENABLED") = 1 Then
                headerMenu.Enabled = True
                headerMenu.ItemStyle.ForeColor = ColorTranslator.FromHtml("#4183C4")
            Else
                headerMenu.Enabled = False
                headerMenu.ItemStyle.ForeColor = Color.Gray
            End If
            menuItemParent.Items.Add(headerMenu)
        End If
        'Checking if other Submenu is available for same parentid 
        drs = dt.Select("parentid='" + intmenuID.ToString() + "'")

        For i = 0 To drs.Length - 1
            menuItem = New DevExpress.Web.MenuItem
            drSubMenu = drs(i)
            'Adding only those submenus which is not a header
            If drSubMenu("MenuID") <> headerId Then
                'Adding a header SubMenu if it is not already added or incase if a header submenu is not configured
                If MenuName <> "" And i = 0 And drHead.Count = 0 Then
                    menuItem.Text = MenuName.ToUpper()
                    menuItem.ItemStyle.CssClass = "dividerHeader"
                    menuItem.ItemStyle.ForeColor = ColorTranslator.FromHtml("#4183C4")
                Else
                    menuItem.Text = drSubMenu("text").ToString()
                    menuItem.ItemStyle.CssClass = "subMenuItem"
                End If
                If drSubMenu("ENABLED") = 1 Then
                    menuItem.Enabled = True
                    menuItem.ItemStyle.ForeColor = Color.Black
                Else
                    menuItem.Enabled = False
                    menuItem.ItemStyle.ForeColor = Color.Gray
                End If
                menuItem.NavigateUrl = SitePath & drSubMenu("DESCRIPTION").ToString()
                menuItemParent.Items.Add(menuItem)
                submenus(menuItem, dt, drSubMenu("MenuID").ToString(), "", 0)
            End If
        Next
    End Sub
End Class