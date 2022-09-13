Imports System.Web.Services
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS
Imports CARS.CoreLibrary.CARS.Services.ConfigMechanicSettings
Imports CARS.CoreLibrary.MechanicBO
Imports DevExpress.Web
Public Class frmMechanicSetting
    Inherits System.Web.UI.Page
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared objMechanic As New Mechanic
    Shared loginName As String
    Dim ds As DataSet
    Shared objMechanicBO As CoreLibrary.MechanicBO

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            loginName = CType(Session("UserID"), String)
        End If
        Try
            EnableViewState = False
            If Not IsPostBack Then
                Session("mechData") = Nothing
                Session("leaveTypeData") = Nothing
                LoadMechanic()
                If (dateSelector.Value Is Nothing) Then
                    dateSelector.Date = DateTime.Now
                End If
                dateSelector.MinDate = DateTime.Now
                txtLoginName.Text = String.Empty
                txtUserId.Text = String.Empty
                Session("leaveTypeData") = objMechanic.FetchLeaveTypes()
                lbLeaveTypes.DataSource = Session("leaveTypeData")

                lbLeaveTypes.DataBind()
            End If
            If IsPostBack Then
                If Not (Session("mechData") Is Nothing) Then
                    ds = Session("mechData")
                    gvMechanic.DataSource = ds
                    gvMechanic.DataBind()
                End If

                If Not (Session("leaveTypeData") Is Nothing) Then
                    Session("leaveTypeData") = objMechanic.FetchLeaveTypes()
                    lbLeaveTypes.DataSource = Session("leaveTypeData")
                    lbLeaveTypes.DataBind()

                End If
            End If
            Dim columnFromDate As DevExpress.Web.GridViewDataDateColumn = CType(gvMechanic.DataColumns("FROM_DATE"), DevExpress.Web.GridViewDataDateColumn)
            Dim columnToDate As DevExpress.Web.GridViewDataDateColumn = CType(gvMechanic.DataColumns("TO_DATE"), DevExpress.Web.GridViewDataDateColumn)
            columnFromDate.PropertiesDateEdit.MinDate = Date.Now.Date
            columnToDate.PropertiesDateEdit.MinDate = Date.Now.Date

            BindMechanicGroupDropDown()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master-frmMechanicSetting", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
    End Sub
    Public Sub BindMechanicGroupDropDown()
        Dim checkListBox As ASPxListBox = checkComboBox.FindControl("checkListBox")
        ddlMecGroup.DataValueField = "ID_MEC_GROUP"
        ddlMecGroup.DataTextField = "MEC_GROUP_NAME"
        'ddlMecGroup.DataSource = objMechanic.FetchMechanicGroups()
        'ddlMecGroup.DataBind()
        ddlMecGroup.Items.Insert(0, New ListItem("Select", 0))
        Dim dt As New DataTable
        Dim ds As DataSet = objMechanic.FetchMechanicGroups()
        If (ds.Tables.Count > 0) Then
            dt = ds.Tables(0)
            If dt.Rows.Count > 0 Then
                Dim i = 0
                For Each MyDataRow In ds.Tables(0).Rows
                    ddlMecGroup.Items.Insert(CInt(MyDataRow("ID_MEC_GROUP")), New ListItem(MyDataRow("MEC_GROUP_NAME").ToString, CInt(MyDataRow("ID_MEC_GROUP"))))
                    checkListBox.Items.Insert(i, New ListEditItem(MyDataRow("MEC_GROUP_NAME").ToString, CInt(MyDataRow("ID_MEC_GROUP"))))
                    i = i + 1
                Next

            End If
        End If
    End Sub
    Public Sub LoadMechanic()
        Try
            objMechanicBO = New MechanicBO
            objMechanicBO.FromDate = DateTime.Now
            ds = objMechanic.FetchMechanicSetting(objMechanicBO)
            Session("mechData") = ds
            gvMechanic.DataSource = ds
            gvMechanic.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master-frmMechanicSetting", "LoadMechanic", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub
    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function Mechanic_Search(ByVal q As String) As MechanicBO()
        Dim mechanicDetails As New List(Of MechanicBO)()
        Try
            mechanicDetails = objMechanic.MechanicSearch(q)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master-frmMechanicSetting", "Mechanic_Search", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return mechanicDetails.ToList.ToArray
    End Function
    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function AutofillLeaveCode(ByVal q As String) As MechanicLeaveTypesBO()
        Dim mechanicLeaveCodeDetails As New List(Of MechanicLeaveTypesBO)()
        Try
            mechanicLeaveCodeDetails = objMechanic.FetchLeaveCode(q)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master-frmMechanicSetting", "AutofillLeaveCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return mechanicLeaveCodeDetails.ToList.ToArray
    End Function
    Protected Sub teStandardFrom_ValueChanged(sender As Object, e As EventArgs)

        If (teStandardFrom.Value IsNot "") Then
            Dim standardFromValue As String = teStandardFrom.Value

            teMondayFrom.Value = standardFromValue
            teTuesdayFrom.Value = standardFromValue
            teWednesdayFrom.Value = standardFromValue
            teThursdayFrom.Value = standardFromValue
            teFridayFrom.Value = standardFromValue
        End If
    End Sub
    Protected Sub gvMechanic_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        For Each item In e.InsertValues

            Try
                Dim idcode As String = "0"
                objMechanicBO = New MechanicBO
                Dim dateTimeTo As Date = item.NewValues("TO_TIME")
                dateTimeTo = CDate(item.NewValues("TO_DATE") & " " & FormatDateTime(dateTimeTo, DateFormat.ShortTime))

                Dim dateTimeFrom As Date = item.NewValues("FROM_TIME")
                dateTimeFrom = CDate(item.NewValues("FROM_DATE") & " " & FormatDateTime(dateTimeFrom, DateFormat.ShortTime))

                objMechanicBO.IdMechanicSettings = 0
                objMechanicBO.Comments = item.NewValues("COMMENTS")
                objMechanicBO.Mechanic_Name = item.NewValues("MECHANIC_NAME")
                objMechanicBO.ToDate = item.NewValues("TO_DATE")
                objMechanicBO.Id_Login = item.NewValues("ID_LOGIN")
                objMechanicBO.Fromtime = dateTimeFrom.ToString
                objMechanicBO.Leave_Reason = item.NewValues("LEAVE_REASON")
                objMechanicBO.Totime = dateTimeTo.ToString
                objMechanicBO.FromDate = item.NewValues("FROM_DATE")
                objMechanicBO.Leave_Code = item.NewValues("LEAVE_CODE")

                objMechanicBO.IdLeaveTypes = 0 'Convert.ToInt32(idcode)

                objMechanic.AddMechanicSettings(objMechanicBO, loginName)
                objMechanicBO.FromDate = dateSelector.Date
                ds = objMechanic.FetchMechanicDetailsOnGrid(objMechanicBO)
                Session("mechData") = ds
                gvMechanic.DataSource = ds
                gvMechanic.DataBind()

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicSetting", "gvLeaveTypes_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            e.Handled = True
        Next
        For Each item In e.UpdateValues

            Try
                objMechanicBO = New MechanicBO
                Dim dateTimeTo As Date = item.NewValues("TO_TIME")
                dateTimeTo = CDate(item.NewValues("TO_DATE") & " " & FormatDateTime(dateTimeTo, DateFormat.ShortTime))

                Dim dateTimeFrom As Date = item.NewValues("FROM_TIME")
                dateTimeFrom = CDate(item.NewValues("FROM_DATE") & " " & FormatDateTime(dateTimeFrom, DateFormat.ShortTime))

                objMechanicBO.IdMechanicSettings = item.Keys(0)
                objMechanicBO.Comments = item.NewValues("COMMENTS")
                objMechanicBO.Mechanic_Name = item.NewValues("MECHANIC_NAME")
                objMechanicBO.ToDate = item.NewValues("TO_DATE")
                objMechanicBO.Id_Login = item.NewValues("ID_LOGIN")
                objMechanicBO.Fromtime = dateTimeFrom.ToString
                objMechanicBO.Leave_Reason = item.NewValues("LEAVE_REASON")
                objMechanicBO.Totime = dateTimeTo.ToString
                objMechanicBO.FromDate = item.NewValues("FROM_DATE")
                objMechanicBO.Leave_Code = item.NewValues("LEAVE_CODE")
                objMechanicBO.IdLeaveTypes = 0

                objMechanic.AddMechanicSettings(objMechanicBO, loginName)
                objMechanicBO.FromDate = dateSelector.Date
                ds = objMechanic.FetchMechanicDetailsOnGrid(objMechanicBO)
                Session("mechData") = ds
                gvMechanic.DataSource = ds
                gvMechanic.DataBind()

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicSetting", "gvLeaveTypes_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            e.Handled = True
        Next

        For Each item In e.DeleteValues
            Try
                objMechanicBO = New MechanicBO
                objMechanicBO.IdMechanicSettings = item.Keys(0)
                objMechanic.DeleteMechanicSettings(objMechanicBO)
                Dim textBoxValue As String() = txtMechanic.Text.Split(New Char() {"-"c})
                objMechanicBO.Mechanic_Name = textBoxValue(1)
                objMechanicBO.FromDate = dateSelector.Date
                ds = objMechanic.FetchMechanicDetailsOnGrid(objMechanicBO)
                gvMechanic.DataSource = ds
                Session("mechData") = ds
                gvMechanic.DataBind()
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "frmMechanicSetting", "gvLeaveTypes_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            e.Handled = True
        Next
    End Sub


    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function SaveMechanicConfigDetails(mechanicId As String, mechanicName As String, standardFrom As String, mondayFrom As String, tuesdayFrom As String, wednesdayFrom As String, thursdayFrom As String, fridayFrom As String,
    saturdayFrom As String, sundayFrom As String, lunchFrom As String, standardTo As String, mondayTo As String, tuesdayTo As String, wednesdayTo As String,
     thursdayTo As String, fridayTo As String, saturdayTo As String, sundayTo As String, lunchTo As String, altStandardFrom As String, altMondayFrom As String, altTuesdayFrom As String, altWednesdayFrom As String, altThursdayFrom As String, altFridayFrom As String,
    altSaturdayFrom As String, altSundayFrom As String, altLunchFrom As String, altStandardTo As String, altMondayTo As String, altTuesdayTo As String, altWednesdayTo As String,
     altThursdayTo As String, altFridayTo As String, altSaturdayTo As String, altSundayTo As String, altLunchTo As String, activeRBChecked As String, flexTimeCbChecked As String, administrationRBChecked As String, idMecGroup As String, mecGroupName As String, mecGroupIds As String) As Integer

        Dim myString As String = standardFrom
        Dim objMecConfSet As MechanicConfigSettingBO = New MechanicConfigSettingBO()

        If (activeRBChecked = "true") Then
            objMecConfSet.ActiveMek = 1
            objMecConfSet.PassiveMek = 0
            objMecConfSet.AdministrationMek = 0
        ElseIf (administrationRBChecked = "true") Then

            objMecConfSet.PassiveMek = 0
            objMecConfSet.ActiveMek = 0
            objMecConfSet.AdministrationMek = 1
        Else
            objMecConfSet.PassiveMek = 1
            objMecConfSet.ActiveMek = 0
            objMecConfSet.AdministrationMek = 0
        End If

        If (flexTimeCbChecked = "true") Then
            objMecConfSet.FlexTime = 1
        Else
            objMecConfSet.FlexTime = 0
        End If

        objMecConfSet.StandardFromTime = standardFrom
        objMecConfSet.MondayFromTime = mondayFrom
        objMecConfSet.TuesdayFromTime = tuesdayFrom
        objMecConfSet.WednesdayFromTime = wednesdayFrom
        objMecConfSet.ThursdayFromTime = thursdayFrom
        objMecConfSet.FridayFromTime = fridayFrom
        objMecConfSet.SaturdayFromTime = saturdayFrom
        objMecConfSet.SundayFromTime = sundayFrom
        objMecConfSet.LunchFromTime = lunchFrom

        objMecConfSet.StandardToTime = standardTo
        objMecConfSet.MondayToTime = mondayTo
        objMecConfSet.TuesdayToTime = tuesdayTo
        objMecConfSet.WednesdayToTime = wednesdayTo
        objMecConfSet.ThursdayToTime = thursdayTo
        objMecConfSet.FridayToTime = fridayTo
        objMecConfSet.SaturdayToTime = saturdayTo
        objMecConfSet.SundayToTime = sundayTo
        objMecConfSet.LunchToTime = lunchTo

        objMecConfSet.AltStandardFromTime = altStandardFrom
        objMecConfSet.AltMondayFromTime = altMondayFrom
        objMecConfSet.AltTuesdayFromTime = altTuesdayFrom
        objMecConfSet.AltWednesdayFromTime = altWednesdayFrom
        objMecConfSet.AltThursdayFromTime = altThursdayFrom
        objMecConfSet.AltFridayFromTime = altFridayFrom
        objMecConfSet.AltSaturdayFromTime = altSaturdayFrom
        objMecConfSet.AltSundayFromTime = altSundayFrom
        objMecConfSet.AltLunchFromTime = altLunchFrom

        objMecConfSet.AltStandardToTime = altStandardTo
        objMecConfSet.AltMondayToTime = altMondayTo
        objMecConfSet.AltTuesdayToTime = altTuesdayTo
        objMecConfSet.AltWednesdayToTime = altWednesdayTo
        objMecConfSet.AltThursdayToTime = altThursdayTo
        objMecConfSet.AltFridayToTime = altFridayTo
        objMecConfSet.AltSaturdayToTime = altSaturdayTo
        objMecConfSet.AltSundayToTime = altSundayTo
        objMecConfSet.AltLunchToTime = altLunchTo
        objMecConfSet.CreatedBy = loginName

        objMecConfSet.MechanicId = mechanicId

        objMecConfSet.MechanicName = mechanicName
        If (CInt(idMecGroup) <> 0) Then
            objMecConfSet.MechanicGroupId = CInt(idMecGroup)
        End If
        objMecConfSet.MechanicGroupName = mecGroupName
        objMecConfSet.MechanicGroupIds = mecGroupIds
        Dim result As Integer = objMechanic.AddMechanicConfigSetting(objMecConfSet)
        'If (result.CompareTo(0)) Then
        '    resultLabel.Text = "Sucessfully Saved"
        'Else
        '    resultLabel.Text = "Result Failed to Save"
        'End If
        'resultLabel.Text = "Result = " + result

        Return result
    End Function

    Protected Sub mecCallback_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)
        Dim mechanicId As String = IIf(hdnMechanicId.Value Is Nothing, "", hdnMechanicId.Value)
        Dim fullParameter As String() = e.Parameter.Split(New Char() {"%"c})
        ds = FetchMecDetailsToGrid(fullParameter(0), fullParameter(1), mechanicId)
        Session("mechData") = ds
        Dim mechanicDataSet As DataSet = PopulateMechanicDetailsOnScreen(fullParameter(0), mechanicId)
        Session("mechanicConfigSession") = mechanicDataSet
    End Sub
    Protected Function LoadConfigSettings()
        Dim mechanicDataSet As New DataSet
        mechanicDataSet = Session("mechanicConfigSession")

        Dim rowCount As Integer = Convert.ToInt32(mechanicDataSet.Tables(0).Rows.Count)
        If (rowCount > 0) Then
            Dim row As DataRow = mechanicDataSet.Tables(0).Rows(0)

            'teStandardFrom.DateTime = DateTime.Now
            teStandardFrom.DateTime = row.Item("STANDARD_FROM_TIME").ToString()
            teStandardTo.DateTime = row.Item("STANDARD_TO_TIME").ToString()
            teMondayFrom.DateTime = row.Item("MONDAY_FROM_TIME").ToString()
            teMondayTo.DateTime = row.Item("MONDAY_TO_TIME").ToString()
            teTuesdayFrom.DateTime = row.Item("TUESDAY_FROM_TIME").ToString()
            teTuesdayTo.DateTime = row.Item("TUESDAY_TO_TIME").ToString()
            teWednesdayFrom.DateTime = row.Item("WEDNESDAY_FROM_TIME").ToString()
            teWednesdayTo.DateTime = row.Item("WEDNESDAY_TO_TIME").ToString()
            teThursdayFrom.DateTime = row.Item("THURSDAY_FROM_TIME").ToString()
            teThursdayTo.DateTime = row.Item("THURSDAY_TO_TIME").ToString()
            teFridayFrom.DateTime = row.Item("FRIDAY_FROM_TIME").ToString()
            teFridayTo.DateTime = row.Item("FRIDAY_TO_TIME").ToString()
            teSaturdayFrom.DateTime = row.Item("SATURDAY_FROM_TIME").ToString()
            teSaturdayTo.DateTime = row.Item("SATURDAY_TO_TIME").ToString()
            teSundayFrom.DateTime = row.Item("SUNDAY_FROM_TIME").ToString()
            teSundayTo.DateTime = row.Item("SUNDAY_TO_TIME").ToString()
            teLunchFrom.DateTime = row.Item("LUNCH_FROM_TIME").ToString()
            teLunchTo.DateTime = row.Item("LUNCH_TO_TIME").ToString()

            teStandardFromNext.DateTime = row.Item("ALT_STANDARD_FROM_TIME").ToString()
            teStandardToNext.DateTime = row.Item("ALT_STANDARD_TO_TIME").ToString()
            teMondayFromNext.DateTime = row.Item("ALT_MONDAY_FROM_TIME").ToString()
            teMondayToNext.DateTime = row.Item("ALT_MONDAY_TO_TIME").ToString()
            teTuesdayFromNext.DateTime = row.Item("ALT_TUESDAY_FROM_TIME").ToString()
            teTuesdayToNext.DateTime = row.Item("ALT_TUESDAY_TO_TIME").ToString()
            teWednesdayFromNext.DateTime = row.Item("ALT_WEDNESDAY_FROM_TIME").ToString()
            teWednesdayToNext.DateTime = row.Item("ALT_WEDNESDAY_TO_TIME").ToString()
            teThursdayFromNext.DateTime = row.Item("ALT_THURSDAY_FROM_TIME").ToString()
            teThursdayToNext.DateTime = row.Item("ALT_THURSDAY_TO_TIME").ToString()
            teFridayFromNext.DateTime = row.Item("ALT_FRIDAY_FROM_TIME").ToString()
            teFridayToNext.DateTime = row.Item("ALT_FRIDAY_TO_TIME").ToString()
            teSaturdayFromNext.DateTime = row.Item("ALT_SATURDAY_FROM_TIME").ToString()
            teSaturdayToNext.DateTime = row.Item("ALT_SATURDAY_TO_TIME").ToString()
            teSundayFromNext.DateTime = row.Item("ALT_SUNDAY_FROM_TIME").ToString()
            teSundayToNext.DateTime = row.Item("ALT_SUNDAY_TO_TIME").ToString()
            teLunchFromNext.DateTime = row.Item("ALT_LUNCH_FROM_TIME").ToString()
            teLunchToNext.DateTime = row.Item("ALT_LUNCH_TO_TIME")

            If (row.Item("ACTIVE_MEK")) Then
                rbLabel.Text = "ACTIVE"
            ElseIf (row.Item("PASSIVE_MEK")) Then
                rbLabel.Text = "PASSIVE"
            ElseIf (row.Item("ADMINISTRATION_MEK")) Then
                rbLabel.Text = "ADMIN"
            End If
            'BindMechanicGroupDropDown()
            cbxFlexTime.Checked = Convert.ToBoolean(row.Item("FLG_FLEX_TIME").ToString())
            cbLabel.Text = row.Item("FLG_FLEX_TIME").ToString()
            callBkPanel.JSProperties("cpMecGroupSelectedValue") = IIf(IsDBNull(row.Item("ID_MEC_GROUP")), "0", row.Item("ID_MEC_GROUP").ToString)
            callBkPanel.JSProperties("cpMecGroupName") = IIf(IsDBNull(row.Item("MEC_GROUP_NAME")), "", row.Item("MEC_GROUP_NAME").ToString)
            ddlMecGroup.SelectedValue = "1"
        Else
            LoadDefaultTimings()
        End If
    End Function
    Public Sub LoadDefaultTimings()
        Dim todaysdate As String = String.Format("{0:dd/MM/yyyy}", DateTime.Now)

        Dim defaultFromTime As DateTime = todaysdate + " 08:00"
        Dim defaultToTime As DateTime = todaysdate + " 16:00"
        Dim defaultLunchFromTime As DateTime = todaysdate + " 12:00"
        Dim defaultLunchToTime As DateTime = todaysdate + " 13:00"

        teStandardFrom.DateTime = defaultFromTime
        teStandardTo.DateTime = defaultToTime
        teMondayFrom.DateTime = defaultFromTime
        teMondayTo.DateTime = defaultToTime
        teTuesdayFrom.DateTime = defaultFromTime
        teTuesdayTo.DateTime = defaultToTime
        teWednesdayFrom.DateTime = defaultFromTime
        teWednesdayTo.DateTime = defaultToTime
        teThursdayFrom.DateTime = defaultFromTime
        teThursdayTo.DateTime = defaultToTime
        teFridayFrom.DateTime = defaultFromTime
        teFridayTo.DateTime = defaultToTime
        teSaturdayFrom.DateTime = defaultFromTime
        teSaturdayTo.DateTime = defaultToTime
        teSundayFrom.DateTime = defaultFromTime
        teSundayTo.DateTime = defaultToTime
        teLunchFrom.DateTime = defaultLunchFromTime
        teLunchTo.DateTime = defaultLunchToTime
        callBkPanel.JSProperties("cpMecGroupName") = ""
    End Sub
    Public Function PopulateMechanicDetailsOnScreen(mechanicFullName As String, mechanicId As String) As DataSet
        Dim mechanicDataSet As DataSet
        Dim MechanicConfigSettingBO As New MechanicConfigSettingBO
        MechanicConfigSettingBO.MechanicName = mechanicFullName
        MechanicConfigSettingBO.MechanicId = mechanicId
        mechanicDataSet = objMechanic.FetchMechanicDetailsOnScreen(MechanicConfigSettingBO)
        Return mechanicDataSet
    End Function
    Public Function FetchMecDetailsToGrid(mechanicFullName As String, dateSelectorValue As String, mechanicId As String) As DataSet

        Dim objMec As MechanicBO = New MechanicBO()
        objMec.Mechanic_Name = mechanicFullName.Trim()
        objMec.FromDate = dateSelectorValue
        objMec.Id_Login = mechanicId
        Dim ds1 As DataSet = New DataSet
        ds1 = objMechanic.FetchMechanicDetailsOnGrid(objMec)
        Return ds1
    End Function

    Protected Sub gvMechanic_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)
        Try
            Dim id As Int32
            If (e.IsNewRow) Then
                id = 0
            Else
                id = e.Keys(0)

            End If

            Dim ds As DataSet = gvMechanic.DataSource
            Dim rowCount As Integer = Convert.ToInt32(ds.Tables(0).Rows.Count)
            For i As Integer = 0 To rowCount - 1
                Dim row As DataRow = ds.Tables(0).Rows(i)
                Dim currentId As Int32 = row.Item("ID_MECHANIC_SETTINGS")
                Dim currentMechanicEntry As String = e.NewValues("ID_LOGIN")
                Dim oldmechanicValue As String = row.ItemArray(1)
                Dim dateTimeFrom As Date = e.NewValues("FROM_TIME")
                dateTimeFrom = CDate(e.NewValues("FROM_DATE") & " " & FormatDateTime(dateTimeFrom, DateFormat.ShortTime))
                Dim dateTimeto As Date = e.NewValues("TO_TIME")
                dateTimeto = CDate(e.NewValues("TO_DATE") & " " & FormatDateTime(dateTimeto, DateFormat.ShortTime))
                If (id <> currentId) Then

                    If (currentMechanicEntry.ToLower() = oldmechanicValue.ToLower()) Then
                        If ((e.NewValues("FROM_DATE") = row.ItemArray(3))) Then
                            If (dateTimeFrom = (row.ItemArray(4))) Then
                                e.RowError = "Cannot add duplicate leave for Same Mechanic"
                            End If
                        End If

                        'If (e.NewValues("FROM_DATE") >= row.ItemArray(3) And e.NewValues("FROM_DATE") <= row.ItemArray(5)) Then
                        '    e.RowError = "Leaves are Conflicting for Same Mechanic"
                        'End If

                        'If (e.NewValues("TO_DATE") >= row.ItemArray(3) And e.NewValues("TO_DATE") <= row.ItemArray(5)) Then
                        '    e.RowError = "Leaves are Conflicting for Same Mechanic"
                        'End If

                        If (dateTimeFrom >= row.Item("FROM_TIME") And dateTimeFrom <= row.Item("TO_TIME")) Then
                            e.RowError = "Leaves are Conflicting for Same Mechanic"
                        End If

                        If (dateTimeto >= row.Item("FROM_TIME") And dateTimeto <= row.Item("TO_TIME")) Then
                            e.RowError = "Leaves are Conflicting for Same Mechanic"
                        End If

                    End If
                End If
            Next

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "frmMechanicSetting", "gvMechanic_RowValidating", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try

    End Sub

    Protected Sub callBkPanel_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Dim fullParameter As String() = e.Parameter.Split(New Char() {"%"c})
        'ds = FetchMecDetailsToGrid(fullParameter(0), fullParameter(1))
        'Session("mechData") = ds
        Dim mechanicId As String = IIf(hdnMechanicId.Value Is Nothing, "", hdnMechanicId.Value)
        Dim mechanicDataSet As DataSet = PopulateMechanicDetailsOnScreen(fullParameter(0), mechanicId)
        Session("mechanicConfigSession") = mechanicDataSet
        LoadConfigSettings()
    End Sub

    Protected Sub myCallBack_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Session("leaveTypeData") = objMechanic.FetchLeaveTypes()
        lbLeaveTypes.DataSource = Session("leaveTypeData")
        lbLeaveTypes.DataBind()
    End Sub
End Class

