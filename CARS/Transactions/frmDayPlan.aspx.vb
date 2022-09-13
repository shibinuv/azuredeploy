Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.Web
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Internal
Imports DevExpress.XtraScheduler
Imports System.ComponentModel
Imports System.Data.SqlClient
Imports CARS.CoreLibrary.CustomEventsData
Imports CARS.CoreLibrary
Imports DevExpress.Web.ASPxScheduler.Rendering
Imports System.Drawing
Imports DevExpress.XtraScheduler.Tools
Imports CARS.CoreLibrary.CARS.DayPlanSettings
Imports System.Xml
Imports DevExpress.Web.ASPxScheduler.Services
Imports System.IO
Imports DevExpress.Web.ASPxTreeList

Public Class frmDayPlan
    Inherits System.Web.UI.Page
    Private objectInstance As CustomEventDataSource
    Private objectResourceInstance As CustomResourceDataSource
    Private WorkTimeDictionary As New Dictionary(Of String, List(Of CustomTimeInterval))()
    Private HolidayTimeDictionary As New Dictionary(Of String, List(Of HolidayTimeInterval))()
    Private loginName As String = ""
    Private holdayList As List(Of KeyValuePair(Of String, List(Of HolidayTimeInterval))) = New List(Of KeyValuePair(Of String, List(Of HolidayTimeInterval)))()
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr

    Private objDayPlanSettingsDO As New DayPlanSettingsDO
    Private dtApptSetting As New DataTable
    Private dsApptSetting As DataSet = New DataSet
    Private appointmentTimeScale As Integer = 30
    Private resourcePerPage As Integer = 3
    Private showSatSunDay As Boolean = False
    Private appointmentStartHour As Integer = 7
    Private appointmentEndHour As Integer = 20
    Private appointmentStartMinute As Integer = 0
    Private appointmentEndMinute As Integer = 0
    Dim objAppointmentDO As New AppointmentDO
    Private isSetOnHold As Boolean
    Private LunchWorkTimeDictionary As New Dictionary(Of String, List(Of CustomTimeInterval))()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If
            EnableViewState = False
            SchedulerCompatibility.Base64XmlObjectSerialization = False
            schdMechanics.JSProperties("cpRefresh") = ""
            schdMechanics.JSProperties("cpCallBackParameter") = ""
            schdMechanics.DayView.WorkTime = TimeOfDayInterval.Day
            schdMechanics.WorkWeekView.WorkTime = TimeOfDayInterval.Day
            schdMechanics.FullWeekView.WorkTime = TimeOfDayInterval.Day
            Dim objAppDO As New AppointmentDO
            Dim ds As DataSet = objAppDO.FetchAppointments
            HttpContext.Current.Session("AppointmentDataSource") = ds
            'loginName = CType(Session("UserID"), String)

            dsApptSetting = objDayPlanSettingsDO.FetchAllOrderStatuses()
            If (dsApptSetting.Tables.Count > 0) Then
                dtApptSetting = dsApptSetting.Tables(1)
            End If

            'Dim objAppointmentDO As New AppointmentDO
            Dim dsOnHoldApp As New DataSet
            dsOnHoldApp = objAppointmentDO.ProcessOnHoldAppointment(1, "FETCH", DateTime.Now, DateTime.Now, "")
            Session("OnHoldApp") = dsOnHoldApp
            gvOnHold.DataSource = Session("OnHoldApp")

            gvOnHold.DataBind()
            If Not IsPostBack Then
                isSetOnHold = False
                Session("isSetOnHold") = False
                If (dsApptSetting.Tables.Count > 0) Then
                    dtApptSetting = dsApptSetting.Tables(1)
                    If dtApptSetting.Rows.Count > 0 Then
                        appointmentTimeScale = dtApptSetting.Rows(0)("MINIMUM_APPOINTMENT_TIME")
                        resourcePerPage = IIf(IsDBNull(dtApptSetting.Rows(0)("MECHANIC_PER_PAGE")), 1, dtApptSetting.Rows(0)("MECHANIC_PER_PAGE"))
                        showSatSunDay = Convert.ToBoolean(dtApptSetting.Rows(0)("DISPLAY_SATSUN").ToString())
                        appointmentStartHour = dtApptSetting.Rows(0)("APPOINTMENT_START_TIME_HOUR")
                        appointmentEndHour = dtApptSetting.Rows(0)("APPOINTMENT_STOP_TIME_HOUR")
                        appointmentStartMinute = dtApptSetting.Rows(0)("APPOINTMENT_START_TIME_MINUTES")
                        appointmentEndMinute = dtApptSetting.Rows(0)("APPOINTMENT_STOP_TIME_MINUTES")

                        schdMechanics.DayView.VisibleTime = New TimeOfDayInterval(New TimeSpan(appointmentStartHour, appointmentStartMinute, 0), New TimeSpan(appointmentEndHour, appointmentEndMinute, 0))
                        schdMechanics.WorkWeekView.VisibleTime = New TimeOfDayInterval(New TimeSpan(appointmentStartHour, appointmentStartMinute, 0), New TimeSpan(appointmentEndHour, appointmentEndMinute, 0))
                        schdMechanics.FullWeekView.VisibleTime = New TimeOfDayInterval(New TimeSpan(appointmentStartHour, appointmentStartMinute, 0), New TimeSpan(appointmentEndHour, appointmentEndMinute, 0))

                        schdMechanics.DayView.TimeScale = New TimeSpan(0, appointmentTimeScale, 0)
                        schdMechanics.WorkWeekView.TimeScale = New TimeSpan(0, appointmentTimeScale, 0)
                        schdMechanics.FullWeekView.TimeScale = New TimeSpan(0, appointmentTimeScale, 0)
                        'schdMechanics.WorkWeekView.ResourcesPerPage = resourcePerPage
                        'schdMechanics.DayView.ResourcesPerPage = resourcePerPage
                        'schdMechanics.FullWeekView.ResourcesPerPage = resourcePerPage
                        If (showSatSunDay) Then
                            schdMechanics.Views.FullWeekView.Enabled = True
                            schdMechanics.Views.WorkWeekView.Enabled = False
                        Else
                            schdMechanics.Views.FullWeekView.Enabled = False
                            schdMechanics.Views.WorkWeekView.Enabled = True
                        End If
                        ASPxPanel1.SettingsCollapsing.ExpandOnPageLoad = Convert.ToBoolean(dtApptSetting.Rows(0)("SHOW_ONHOLD_ON_LOAD"))
                    End If
                End If
                Session("aptSavedState") = Nothing
                HttpContext.Current.Session("aptUpdateOnOk") = False
                dateSelector.Date = Date.Now
            Else
                If (dsApptSetting.Tables.Count > 0) Then
                    If dtApptSetting.Rows.Count > 0 Then

                        showSatSunDay = Convert.ToBoolean(dtApptSetting.Rows(0)("DISPLAY_SATSUN").ToString())
                        schdMechanics.JSProperties("cpIsCtrlByStatus") = dtApptSetting.Rows(0)("CTRL_BY_STATUS")
                        If (showSatSunDay) Then
                            schdMechanics.Views.FullWeekView.Enabled = True
                            schdMechanics.Views.WorkWeekView.Enabled = False
                        Else
                            schdMechanics.Views.FullWeekView.Enabled = False
                            schdMechanics.Views.WorkWeekView.Enabled = True
                        End If
                    End If
                End If

                If Session("dsAllApt") IsNot Nothing Then
                    gvAllAppointments.DataSource = Session("dsAllApt")
                    gvAllAppointments.DataBind()
                End If
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Private Sub frmDayPlan_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            LoadMechanicLeaves()
            LoadWorkTimeWithoutLunch()
            LoadLabelColor()
            LoadStatusColor()
            GetHolidays()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "frmDayPlan_Init", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub AddScheduleNewEventSubMenu(ByVal menu As ASPxSchedulerPopupMenu, ByVal caption As String)
        Dim newWithTemplateItem As New MenuItem(caption, "JobStatus")
        newWithTemplateItem.BeginGroup = True
        menu.Items.Insert(4, newWithTemplateItem)
        AddTemplatesSubMenuItems(newWithTemplateItem)
    End Sub
    Private Shared Sub AddTemplatesSubMenuItems(ByVal parentMenuItem As MenuItem)
        'parentMenuItem.Items.Add(New MenuItem("Routine ABCD", "Routine"))
        'parentMenuItem.Items.Add(New MenuItem("Follow-Up ABCD", "FollowUp"))
        Dim objAppDO As New AppointmentDO
        Dim ds As DataSet = objAppDO.FetchLabelColor()
        Dim MyDataRow As DataRow
        Dim rowCount As Integer = Convert.ToInt32(ds.Tables(2).Rows.Count)
        Dim subMenuName As String
        For Each MyDataRow In ds.Tables(2).Rows
            subMenuName = "JobStatus$" + MyDataRow("ID_ORDER_STATUS").ToString()
            parentMenuItem.Items.Add(New MenuItem(MyDataRow("ORDER_STATUS_DESC").ToString(), subMenuName))
        Next

    End Sub
    Public Sub LoadLabelColor()
        Try
            schdMechanics.Storage.Appointments.Labels.Clear()
            Dim objAppDO As New AppointmentDO
            Dim ds As DataSet = objAppDO.FetchLabelColor()
            Dim MyDataRow As DataRow
            Dim rowCount As Integer = Convert.ToInt32(ds.Tables(0).Rows.Count)
            For Each MyDataRow In ds.Tables(0).Rows
                schdMechanics.Storage.Appointments.Labels.Add(MyDataRow("ID_ORDER_STATUS"), MyDataRow("ORDER_STATUS_CODE").ToString(), MyDataRow("ORDER_STATUS_CODE").ToString(), ColorTranslator.FromHtml(MyDataRow("ORDER_STATUS_COLOR").ToString()))
            Next
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "LoadLabelColor", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Sub LoadStatusColor()
        Try
            schdMechanics.Storage.Appointments.Statuses.Clear()
            Dim objAppDO As New AppointmentDO
            Dim ds As DataSet = objAppDO.FetchLabelColor()
            Dim MyDataRow As DataRow
            Dim rowCount As Integer = Convert.ToInt32(ds.Tables(1).Rows.Count)
            For Each MyDataRow In ds.Tables(1).Rows
                schdMechanics.Storage.Appointments.Statuses.Add(schdMechanics.Storage.Appointments.Statuses.CreateNewStatus(MyDataRow("ID_APPOINTMENT_STATUS"), MyDataRow("APPOINTMENT_STATUS_CODE").ToString(), MyDataRow("APPOINTMENT_STATUS_CODE").ToString(), ColorTranslator.FromHtml(MyDataRow("APPOINTMENT_STATUS_COLOR").ToString())))
            Next

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "LoadStatusColor", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Private Sub GetHolidays()
        Try
            Dim workdays As WorkDaysCollection = schdMechanics.WorkDays
            Dim holidObj As New Microsoft.VisualBasic.Collection()
            Dim objAppDO As New AppointmentDO
            Dim dtHolid As DataTable = New DataTable()
            Dim dtMech As DataTable = New DataTable()
            Dim mechanicId As String = ""

            Dim ds As DataSet = objAppDO.FetchMechHolidays()

            If ds.Tables.Count > 0 Then
                dtHolid = ds.Tables(2)
                dtMech = ds.Tables(1)

                For Each dtMechrow As DataRow In dtMech.Rows
                    mechanicId = dtMechrow("MECHANIC_ID")
                    Dim holidTimes As New List(Of HolidayTimeInterval)()

                    For Each dtrow As DataRow In dtHolid.Rows
                        Dim holiday1 As DateTime = CType(dtrow("FROM_DATE"), DateTime)
                        Dim holidayToDate As DateTime = CType(dtrow("TO_DATE"), DateTime)
                        Dim holidayFromTime As DateTime = CType(dtrow("FROM_TIME"), DateTime)
                        Dim holidayToTime As DateTime = CType(dtrow("TO_TIME"), DateTime)

                        Dim mechId As String = CType(If(IsDBNull(dtrow("ID_LOGIN")), "", dtrow("ID_LOGIN")), String)

                        If (mechanicId = mechId) Then
                            Dim holidayTimes As New HolidayTimeInterval()
                            holidayTimes.MechHolidayDate = holiday1
                            holidayTimes.MechHolidayToDate = holidayToDate
                            holidayTimes.MechHolidayFromTime = (holidayFromTime.Hour * 60) + holidayFromTime.Minute
                            holidayTimes.MechHolidayToTime = (holidayToTime.Hour * 60) + holidayToTime.Minute
                            holidayTimes.MechId = mechId
                            holidayTimes.MechLeaveReason = CType(If(IsDBNull(dtrow("LEAVE_REASON")), "", dtrow("LEAVE_REASON")), String)
                            holidTimes.Add(holidayTimes)
                        End If
                    Next
                    HolidayTimeDictionary.Add(mechanicId, holidTimes)
                Next
            End If

            schdMechanics.JSProperties("cpMechHolidays") = HolidayTimeDictionary

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "GetHolidays", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub LoadMechanicLeaves()
        Try
            Dim resources As BindingList(Of CustomResource) = GetCustomResources()
            For Each item In resources
                Dim workTimes As New List(Of CustomTimeInterval)()


                Dim ConvStart As New Date
                ConvStart = item.STANDARD_FROM_TIME
                Dim stHr As Integer = ConvStart.Hour
                Dim stMin As Integer = ConvStart.Minute

                Dim ConvEnd As New Date
                ConvEnd = item.STANDARD_TO_TIME
                Dim endHr As Integer = ConvEnd.Hour
                Dim endMin As Integer = ConvEnd.Minute

                Dim stlunch As New Date
                stlunch = item.LUNCH_FROM_TIME
                Dim stlunchHr As Integer = stlunch.Hour
                Dim stlunchMin As Integer = stlunch.Minute

                Dim endlunch As New Date
                endlunch = item.LUNCH_TO_TIME
                Dim endlunchHr As Integer = endlunch.Hour
                Dim endlunchMin As Integer = endlunch.Minute

                'Monday 
                Dim MondStart As New Date
                MondStart = item.MONDAY_FROM_TIME
                Dim mondStHr As Integer = MondStart.Hour
                Dim mondStMin As Integer = MondStart.Minute

                Dim MondEnd As New Date
                MondEnd = item.MONDAY_TO_TIME
                Dim mondendHr As Integer = MondEnd.Hour
                Dim mondendMin As Integer = MondEnd.Minute

                'For entire day holiday or not configured both starttime and endtime is 00:00

                If mondStHr <> 0 And mondendHr <> 0 Then
                    Dim mondWorkTimes As New CustomTimeInterval()
                    mondWorkTimes.DayOfWeek = 1
                    mondWorkTimes.StartTime = (mondStHr * 60) + mondStMin ' Convert.ToInt32((mondStMin / 100) * 60)
                    mondWorkTimes.EndTime = (stlunchHr * 60) + stlunchMin 'Convert.ToInt32((stlunchMin / 100) * 60)
                    workTimes.Add(mondWorkTimes)

                    Dim mondWorkTimes2 As New CustomTimeInterval()
                    mondWorkTimes2.DayOfWeek = 1
                    mondWorkTimes2.StartTime = (endlunchHr * 60) + endlunchMin ' Convert.ToInt32((endlunchMin / 100) * 60)
                    mondWorkTimes2.EndTime = (mondendHr * 60) + mondendMin 'Convert.ToInt32((mondendMin / 100) * 60)
                    workTimes.Add(mondWorkTimes2)
                Else
                    Dim mondWorkTimes As New CustomTimeInterval()
                    mondWorkTimes.DayOfWeek = 1
                    mondWorkTimes.StartTime = (mondStHr * 60) + mondStMin 'Convert.ToInt32((mondStMin / 100) * 60)
                    mondWorkTimes.EndTime = (mondendHr * 60) + mondendMin 'Convert.ToInt32((mondendMin / 100) * 60)
                    workTimes.Add(mondWorkTimes)
                End If

                'Tuesday
                Dim TueStart As New Date
                TueStart = item.TUESDAY_FROM_TIME
                Dim tueStHr As Integer = TueStart.Hour
                Dim tueStMin As Integer = TueStart.Minute

                Dim TueEnd As New Date
                TueEnd = item.TUESDAY_TO_TIME
                Dim tueEndHr As Integer = TueEnd.Hour
                Dim tueEndMin As Integer = TueEnd.Minute

                If tueStHr <> 0 And tueEndHr <> 0 Then
                    Dim tueWorkTimes As New CustomTimeInterval()
                    tueWorkTimes.DayOfWeek = 2
                    tueWorkTimes.StartTime = (tueStHr * 60) + tueStMin ' Convert.ToInt32((tueStMin / 100) * 60)
                    tueWorkTimes.EndTime = (stlunchHr * 60) + stlunchMin 'Convert.ToInt32((stlunchMin / 100) * 60)
                    workTimes.Add(tueWorkTimes)

                    Dim tueWorkTimes2 As New CustomTimeInterval()
                    tueWorkTimes2.DayOfWeek = 2
                    tueWorkTimes2.StartTime = (endlunchHr * 60) + endlunchMin ' Convert.ToInt32((endlunchMin / 100) * 60)
                    tueWorkTimes2.EndTime = (tueEndHr * 60) + tueEndMin 'Convert.ToInt32((tueEndMin / 100) * 60)
                    workTimes.Add(tueWorkTimes2)
                Else
                    Dim tueWorkTimes As New CustomTimeInterval()
                    tueWorkTimes.DayOfWeek = 2
                    tueWorkTimes.StartTime = (tueStHr * 60) + tueStMin 'Convert.ToInt32((tueStMin / 100) * 60)
                    tueWorkTimes.EndTime = (tueEndHr * 60) + tueEndMin 'Convert.ToInt32((tueEndMin / 100) * 60)
                    workTimes.Add(tueWorkTimes)
                End If

                'Wednesday
                Dim WedStart As New Date
                WedStart = item.WEDNESDAY_FROM_TIME
                Dim wedStHr As Integer = WedStart.Hour
                Dim wedStMin As Integer = WedStart.Minute

                Dim WedEnd As New Date
                WedEnd = item.WEDNESDAY_TO_TIME
                Dim wedEndHr As Integer = WedEnd.Hour
                Dim wedEndMin As Integer = WedEnd.Minute

                If wedStHr <> 0 And wedEndHr <> 0 Then
                    Dim wedWorkTimes As New CustomTimeInterval()
                    wedWorkTimes.DayOfWeek = 3
                    wedWorkTimes.StartTime = (wedStHr * 60) + wedStMin  'Convert.ToInt32((wedStMin / 100) * 60)
                    wedWorkTimes.EndTime = (stlunchHr * 60) + stlunchMin 'Convert.ToInt32((stlunchMin / 100) * 60)
                    workTimes.Add(wedWorkTimes)

                    Dim wedWorkTimes2 As New CustomTimeInterval()
                    wedWorkTimes2.DayOfWeek = 3
                    wedWorkTimes2.StartTime = (endlunchHr * 60) + endlunchMin 'Convert.ToInt32((endlunchMin / 100) * 60)
                    wedWorkTimes2.EndTime = (wedEndHr * 60) + wedEndMin  'Convert.ToInt32((wedEndMin / 100) * 60)
                    workTimes.Add(wedWorkTimes2)
                Else
                    Dim wedWorkTimes As New CustomTimeInterval()
                    wedWorkTimes.DayOfWeek = 3
                    wedWorkTimes.StartTime = (wedStHr * 60) + wedStMin 'Convert.ToInt32((wedStMin / 100) * 60)
                    wedWorkTimes.EndTime = (wedEndHr * 60) + wedEndMin 'Convert.ToInt32((wedEndMin / 100) * 60)
                    workTimes.Add(wedWorkTimes)
                End If

                'Thursday
                Dim ThuStart As New Date
                ThuStart = item.THURSDAY_FROM_TIME
                Dim thurStHr As Integer = ThuStart.Hour
                Dim thurStMin As Integer = ThuStart.Minute

                Dim ThurEnd As New Date
                ThurEnd = item.THURSDAY_TO_TIME
                Dim thurEndHr As Integer = ThurEnd.Hour
                Dim thurEndMin As Integer = ThurEnd.Minute

                If thurStHr <> 0 And thurEndHr <> 0 Then
                    Dim thurWorkTimes As New CustomTimeInterval()
                    thurWorkTimes.DayOfWeek = 4
                    thurWorkTimes.StartTime = (thurStHr * 60) + thurStMin 'Convert.ToInt32((thurStMin / 100) * 60)
                    thurWorkTimes.EndTime = (stlunchHr * 60) + stlunchMin 'Convert.ToInt32((stlunchMin / 100) * 60)
                    workTimes.Add(thurWorkTimes)

                    Dim thurWorkTimes2 As New CustomTimeInterval()
                    thurWorkTimes2.DayOfWeek = 4
                    thurWorkTimes2.StartTime = (endlunchHr * 60) + endlunchMin 'Convert.ToInt32((endlunchMin / 100) * 60)
                    thurWorkTimes2.EndTime = (thurEndHr * 60) + thurEndMin 'Convert.ToInt32((thurEndMin / 100) * 60)
                    workTimes.Add(thurWorkTimes2)
                Else
                    Dim thurWorkTimes As New CustomTimeInterval()
                    thurWorkTimes.DayOfWeek = 4
                    thurWorkTimes.StartTime = (thurStHr * 60) + thurStMin 'Convert.ToInt32((thurStMin / 100) * 60)
                    thurWorkTimes.EndTime = (thurEndHr * 60) + thurEndMin 'Convert.ToInt32((thurEndMin / 100) * 60)
                    workTimes.Add(thurWorkTimes)
                End If

                'Friday
                Dim FridStart As New Date
                FridStart = item.FRIDAY_FROM_TIME
                Dim fridStHr As Integer = FridStart.Hour
                Dim fridStMin As Integer = FridStart.Minute

                Dim FridEnd As New Date
                FridEnd = item.FRIDAY_TO_TIME
                Dim fridEndHr As Integer = FridEnd.Hour
                Dim fridEndMin As Integer = FridEnd.Minute

                If fridStHr <> 0 And fridEndHr <> 0 Then
                    Dim fridWorkTimes As New CustomTimeInterval()
                    fridWorkTimes.DayOfWeek = 5
                    fridWorkTimes.StartTime = (fridStHr * 60) + fridStMin 'Convert.ToInt32((fridStMin / 100) * 60)
                    fridWorkTimes.EndTime = (stlunchHr * 60) + stlunchMin 'Convert.ToInt32((stlunchMin / 100) * 60)
                    workTimes.Add(fridWorkTimes)

                    Dim fridWorkTimes2 As New CustomTimeInterval()
                    fridWorkTimes2.DayOfWeek = 5
                    fridWorkTimes2.StartTime = (endlunchHr * 60) + endlunchMin 'Convert.ToInt32((endlunchMin / 100) * 60)
                    fridWorkTimes2.EndTime = (fridEndHr * 60) + fridEndMin 'Convert.ToInt32((fridEndMin / 100) * 60)
                    workTimes.Add(fridWorkTimes2)
                Else
                    Dim fridWorkTimes As New CustomTimeInterval()
                    fridWorkTimes.DayOfWeek = 5
                    fridWorkTimes.StartTime = (fridStHr * 60) + fridStMin 'Convert.ToInt32((fridStMin / 100) * 60)
                    fridWorkTimes.EndTime = (fridEndHr * 60) + fridEndMin 'Convert.ToInt32((fridEndMin / 100) * 60)
                    workTimes.Add(fridWorkTimes)
                End If

                'Saturday
                Dim SatStart As New Date
                SatStart = item.SATURDAY_FROM_TIME
                Dim satStHr As Integer = SatStart.Hour
                Dim satStMin As Integer = SatStart.Minute

                Dim SatEnd As New Date
                SatEnd = item.SATURDAY_TO_TIME
                Dim satEndHr As Integer = SatEnd.Hour
                Dim satEndMin As Integer = SatEnd.Minute

                If satStHr <> 0 And satEndHr <> 0 Then
                    Dim satWorkTimes As New CustomTimeInterval()
                    satWorkTimes.DayOfWeek = 6
                    satWorkTimes.StartTime = (satStHr * 60) + satStMin 'Convert.ToInt32((satStMin / 100) * 60)
                    satWorkTimes.EndTime = (stlunchHr * 60) + stlunchMin 'Convert.ToInt32((stlunchMin / 100) * 60)
                    workTimes.Add(satWorkTimes)

                    Dim satWorkTimes2 As New CustomTimeInterval()
                    satWorkTimes2.DayOfWeek = 6
                    satWorkTimes2.StartTime = (endlunchHr * 60) + endlunchMin 'Convert.ToInt32((endlunchMin / 100) * 60)
                    satWorkTimes2.EndTime = (satEndHr * 60) + satEndMin 'Convert.ToInt32((satEndMin / 100) * 60)
                    workTimes.Add(satWorkTimes2)
                Else
                    Dim satWorkTimes As New CustomTimeInterval()
                    satWorkTimes.DayOfWeek = 6
                    satWorkTimes.StartTime = (satStHr * 60) + satStMin 'Convert.ToInt32((satStMin / 100) * 60)
                    satWorkTimes.EndTime = (satEndHr * 60) + satEndMin 'Convert.ToInt32((satEndMin / 100) * 60)
                    workTimes.Add(satWorkTimes)
                End If
                'Sunday

                Dim SundStart As New Date
                SundStart = item.SUNDAY_FROM_TIME
                Dim sundStHr As Integer = SundStart.Hour
                Dim sundStMin As Integer = SundStart.Minute

                Dim SundEnd As New Date
                SundEnd = item.SUNDAY_TO_TIME
                Dim sundendHr As Integer = SundEnd.Hour
                Dim sundendMin As Integer = SundEnd.Minute

                'For entire day holiday or not configured both starttime and endtime is 00:00

                If sundStHr <> 0 And sundendHr <> 0 Then
                    Dim sundWorkTimes As New CustomTimeInterval()
                    sundWorkTimes.DayOfWeek = 0
                    sundWorkTimes.StartTime = (sundStHr * 60) + sundStMin 'Convert.ToInt32((sundStMin / 100) * 60)
                    sundWorkTimes.EndTime = (stlunchHr * 60) + stlunchMin 'Convert.ToInt32((stlunchMin / 100) * 60)
                    workTimes.Add(sundWorkTimes)

                    Dim sundWorkTimes2 As New CustomTimeInterval()
                    sundWorkTimes2.DayOfWeek = 0
                    sundWorkTimes2.StartTime = (endlunchHr * 60) + endlunchMin 'Convert.ToInt32((endlunchMin / 100) * 60)
                    sundWorkTimes2.EndTime = (sundendHr * 60) + sundendMin 'Convert.ToInt32((sundendMin / 100) * 60)
                    workTimes.Add(sundWorkTimes2)
                Else
                    Dim sundWorkTimes As New CustomTimeInterval()
                    sundWorkTimes.DayOfWeek = 0
                    sundWorkTimes.StartTime = (mondStHr * 60) + sundStMin 'Convert.ToInt32((sundStMin / 100) * 60)
                    sundWorkTimes.EndTime = (sundendHr * 60) + sundendMin 'Convert.ToInt32((sundendMin / 100) * 60)
                    workTimes.Add(sundWorkTimes)
                End If

                WorkTimeDictionary.Add(item.ResID, workTimes)
            Next item

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "LoadMechanicLeaves", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub LoadWorkTimeWithoutLunch()
        Try
            Dim resources As BindingList(Of CustomResource) = GetCustomResources()
            For Each item In resources
                Dim workTimes As New List(Of CustomTimeInterval)()

                Dim ConvStart As New Date
                ConvStart = item.STANDARD_FROM_TIME
                Dim stHr As Integer = ConvStart.Hour
                Dim stMin As Integer = ConvStart.Minute

                Dim ConvEnd As New Date
                ConvEnd = item.STANDARD_TO_TIME
                Dim endHr As Integer = ConvEnd.Hour
                Dim endMin As Integer = ConvEnd.Minute

                Dim stlunch As New Date
                stlunch = item.LUNCH_FROM_TIME
                Dim stlunchHr As Integer = stlunch.Hour
                Dim stlunchMin As Integer = stlunch.Minute

                Dim endlunch As New Date
                endlunch = item.LUNCH_TO_TIME
                Dim endlunchHr As Integer = endlunch.Hour
                Dim endlunchMin As Integer = endlunch.Minute

                'Monday 
                Dim MondStart As New Date
                MondStart = item.MONDAY_FROM_TIME
                Dim mondStHr As Integer = MondStart.Hour
                Dim mondStMin As Integer = MondStart.Minute

                Dim MondEnd As New Date
                MondEnd = item.MONDAY_TO_TIME
                Dim mondendHr As Integer = MondEnd.Hour
                Dim mondendMin As Integer = MondEnd.Minute

                'For entire day holiday or not configured both starttime and endtime is 00:00

                If mondStHr <> 0 And mondendHr <> 0 Then
                    Dim mondWorkTimes As New CustomTimeInterval()
                    mondWorkTimes.DayOfWeek = 1
                    mondWorkTimes.StartTime = (mondStHr * 60) + Convert.ToInt32((mondStMin / 100) * 60)
                    mondWorkTimes.EndTime = (mondendHr * 60) + Convert.ToInt32((mondendMin / 100) * 60)
                    mondWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    mondWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(mondWorkTimes)
                Else
                    Dim mondWorkTimes As New CustomTimeInterval()
                    mondWorkTimes.DayOfWeek = 1
                    mondWorkTimes.StartTime = (mondStHr * 60) + Convert.ToInt32((mondStMin / 100) * 60)
                    mondWorkTimes.EndTime = (mondendHr * 60) + Convert.ToInt32((mondendMin / 100) * 60)
                    mondWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    mondWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(mondWorkTimes)
                End If

                'Tuesday
                Dim TueStart As New Date
                TueStart = item.TUESDAY_FROM_TIME
                Dim tueStHr As Integer = TueStart.Hour
                Dim tueStMin As Integer = TueStart.Minute

                Dim TueEnd As New Date
                TueEnd = item.TUESDAY_TO_TIME
                Dim tueEndHr As Integer = TueEnd.Hour
                Dim tueEndMin As Integer = TueEnd.Minute

                If tueStHr <> 0 And tueEndHr <> 0 Then
                    Dim tueWorkTimes As New CustomTimeInterval()
                    tueWorkTimes.DayOfWeek = 2
                    tueWorkTimes.StartTime = (tueStHr * 60) + Convert.ToInt32((tueStMin / 100) * 60)
                    tueWorkTimes.EndTime = (tueEndHr * 60) + Convert.ToInt32((tueEndMin / 100) * 60)
                    tueWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    tueWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(tueWorkTimes)
                Else
                    Dim tueWorkTimes As New CustomTimeInterval()
                    tueWorkTimes.DayOfWeek = 2
                    tueWorkTimes.StartTime = (tueStHr * 60) + Convert.ToInt32((tueStMin / 100) * 60)
                    tueWorkTimes.EndTime = (tueEndHr * 60) + Convert.ToInt32((tueEndMin / 100) * 60)
                    tueWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    tueWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(tueWorkTimes)
                End If

                'Wednesday
                Dim WedStart As New Date
                WedStart = item.WEDNESDAY_FROM_TIME
                Dim wedStHr As Integer = WedStart.Hour
                Dim wedStMin As Integer = WedStart.Minute

                Dim WedEnd As New Date
                WedEnd = item.WEDNESDAY_TO_TIME
                Dim wedEndHr As Integer = WedEnd.Hour
                Dim wedEndMin As Integer = WedEnd.Minute

                If wedStHr <> 0 And wedEndHr <> 0 Then
                    Dim wedWorkTimes As New CustomTimeInterval()
                    wedWorkTimes.DayOfWeek = 3
                    wedWorkTimes.StartTime = (wedStHr * 60) + Convert.ToInt32((wedStMin / 100) * 60)
                    wedWorkTimes.EndTime = (wedEndHr * 60) + Convert.ToInt32((wedEndMin / 100) * 60)
                    wedWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    wedWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(wedWorkTimes)
                Else
                    Dim wedWorkTimes As New CustomTimeInterval()
                    wedWorkTimes.DayOfWeek = 3
                    wedWorkTimes.StartTime = (wedStHr * 60) + Convert.ToInt32((wedStMin / 100) * 60)
                    wedWorkTimes.EndTime = (wedEndHr * 60) + Convert.ToInt32((wedEndMin / 100) * 60)
                    wedWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    wedWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(wedWorkTimes)
                End If

                'Thursday
                Dim ThuStart As New Date
                ThuStart = item.THURSDAY_FROM_TIME
                Dim thurStHr As Integer = ThuStart.Hour
                Dim thurStMin As Integer = ThuStart.Minute

                Dim ThurEnd As New Date
                ThurEnd = item.THURSDAY_TO_TIME
                Dim thurEndHr As Integer = ThurEnd.Hour
                Dim thurEndMin As Integer = ThurEnd.Minute

                If thurStHr <> 0 And thurEndHr <> 0 Then
                    Dim thurWorkTimes As New CustomTimeInterval()
                    thurWorkTimes.DayOfWeek = 4
                    thurWorkTimes.StartTime = (thurStHr * 60) + Convert.ToInt32((thurStMin / 100) * 60)
                    thurWorkTimes.EndTime = (thurEndHr * 60) + Convert.ToInt32((thurEndMin / 100) * 60)
                    thurWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    thurWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(thurWorkTimes)

                Else
                    Dim thurWorkTimes As New CustomTimeInterval()
                    thurWorkTimes.DayOfWeek = 4
                    thurWorkTimes.StartTime = (thurStHr * 60) + Convert.ToInt32((thurStMin / 100) * 60)
                    thurWorkTimes.EndTime = (thurEndHr * 60) + Convert.ToInt32((thurEndMin / 100) * 60)
                    thurWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    thurWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(thurWorkTimes)
                End If

                'Friday
                Dim FridStart As New Date
                FridStart = item.FRIDAY_FROM_TIME
                Dim fridStHr As Integer = FridStart.Hour
                Dim fridStMin As Integer = FridStart.Minute

                Dim FridEnd As New Date
                FridEnd = item.FRIDAY_TO_TIME
                Dim fridEndHr As Integer = FridEnd.Hour
                Dim fridEndMin As Integer = FridEnd.Minute

                If fridStHr <> 0 And fridEndHr <> 0 Then
                    Dim fridWorkTimes As New CustomTimeInterval()
                    fridWorkTimes.DayOfWeek = 5
                    fridWorkTimes.StartTime = (fridStHr * 60) + Convert.ToInt32((fridStMin / 100) * 60)
                    fridWorkTimes.EndTime = (fridEndHr * 60) + Convert.ToInt32((fridEndMin / 100) * 60)
                    fridWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    fridWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(fridWorkTimes)

                Else
                    Dim fridWorkTimes As New CustomTimeInterval()
                    fridWorkTimes.DayOfWeek = 5
                    fridWorkTimes.StartTime = (fridStHr * 60) + Convert.ToInt32((fridStMin / 100) * 60)
                    fridWorkTimes.EndTime = (fridEndHr * 60) + Convert.ToInt32((fridEndMin / 100) * 60)
                    fridWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    fridWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(fridWorkTimes)
                End If

                'Saturday
                Dim SatStart As New Date
                SatStart = item.SATURDAY_FROM_TIME
                Dim satStHr As Integer = SatStart.Hour
                Dim satStMin As Integer = SatStart.Minute

                Dim SatEnd As New Date
                SatEnd = item.SATURDAY_TO_TIME
                Dim satEndHr As Integer = SatEnd.Hour
                Dim satEndMin As Integer = SatEnd.Minute

                If satStHr <> 0 And satEndHr <> 0 Then
                    Dim satWorkTimes As New CustomTimeInterval()
                    satWorkTimes.DayOfWeek = 6
                    satWorkTimes.StartTime = (satStHr * 60) + Convert.ToInt32((satStMin / 100) * 60)
                    satWorkTimes.EndTime = (satEndHr * 60) + Convert.ToInt32((satEndMin / 100) * 60)
                    satWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    satWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(satWorkTimes)

                Else
                    Dim satWorkTimes As New CustomTimeInterval()
                    satWorkTimes.DayOfWeek = 6
                    satWorkTimes.StartTime = (satStHr * 60) + Convert.ToInt32((satStMin / 100) * 60)
                    satWorkTimes.EndTime = (satEndHr * 60) + Convert.ToInt32((satEndMin / 100) * 60)
                    satWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    satWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(satWorkTimes)
                End If
                'Sunday

                Dim SundStart As New Date
                SundStart = item.SUNDAY_FROM_TIME
                Dim sundStHr As Integer = SundStart.Hour
                Dim sundStMin As Integer = SundStart.Minute

                Dim SundEnd As New Date
                SundEnd = item.SUNDAY_TO_TIME
                Dim sundendHr As Integer = SundEnd.Hour
                Dim sundendMin As Integer = SundEnd.Minute

                'For entire day holiday or not configured both starttime and endtime is 00:00

                If sundStHr <> 0 And sundendHr <> 0 Then
                    Dim sundWorkTimes As New CustomTimeInterval()
                    sundWorkTimes.DayOfWeek = 0
                    sundWorkTimes.StartTime = (sundStHr * 60) + Convert.ToInt32((sundStMin / 100) * 60)
                    sundWorkTimes.EndTime = (sundendHr * 60) + Convert.ToInt32((sundendMin / 100) * 60)
                    sundWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    sundWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(sundWorkTimes)

                Else
                    Dim sundWorkTimes As New CustomTimeInterval()
                    sundWorkTimes.DayOfWeek = 0
                    sundWorkTimes.StartTime = (mondStHr * 60) + Convert.ToInt32((sundStMin / 100) * 60)
                    sundWorkTimes.EndTime = (sundendHr * 60) + Convert.ToInt32((sundendMin / 100) * 60)
                    sundWorkTimes.LunchStartTime = (stlunchHr * 60) + Convert.ToInt32((stlunchMin / 100) * 60)
                    sundWorkTimes.LunchEndTime = (endlunchHr * 60) + Convert.ToInt32((endlunchMin / 100) * 60)
                    workTimes.Add(sundWorkTimes)
                End If

                LunchWorkTimeDictionary.Add(item.ResID, workTimes)
            Next item

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "LoadWorkTimeWithoutLunch", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Private Function GetExistingOrders()
        Try
            If schdMechanics.SelectedAppointments.Count > 0 Then
                Dim ds As DataSet = New DataSet()
                Dim vehicleNo As Integer
                Dim objAppDO As New AppointmentDO
                If schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo").ToString = "" Then
                    vehicleNo = 0
                Else
                    vehicleNo = Convert.ToInt32(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo").ToString)
                End If

                Dim dsAll As DataSet = HttpContext.Current.Session("AppointmentDataSource")
                Dim dt As DataTable = dsAll.Tables(0)

                Dim selRecord As Integer = schdMechanics.SelectedAppointments(0).Id
                'to get gridview id to update on drag
                Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                    .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                    .aptId = schdata.Field(Of Integer)("ID_APT_HDR"),
                    .Id = schdata.Field(Of Integer)("APPOINTMENT_ID")
                    }).Where(Function(customer) customer.Id = selRecord)

                Dim selGridViewId As Integer = gdata(0).gvId
                Dim selApptId As Integer = gdata(0).aptId

                ' Dim vehicleNo As Integer = IIf(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo") = "", 0, Convert.ToInt32(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo")))
                Dim customereNo As String = IIf(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomerNumber") = "", "", schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomerNumber").ToString())
                ds = objAppDO.FetchExistingOrders(customereNo, vehicleNo, selGridViewId, selApptId)
                If (ds.Tables(0).Rows.Count = 0) Then
                    lbExisOrders.JSProperties("cpRecordExist") = "NO"
                Else
                    lbExisOrders.JSProperties("cpRecordExist") = "YES"
                End If
                lbExisOrders.DataSource = ds

                lbExisOrders.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "GetExistingOrders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Function

    Protected Sub schedulerDayPlan_PopupMenuShowing(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxScheduler.PopupMenuShowingEventArgs)
        Try
            Dim popupmenu As ASPxSchedulerPopupMenu = e.Menu
            'CSS For Setting Context  Menu Height
            popupmenu.SubMenuStyle.CssClass = "popupMenu"
            RemoveMenuItem(popupmenu, "NewAllDayEvent")
            RemoveMenuItem(popupmenu, "NewRecurringAppointment")
            RemoveMenuItem(popupmenu, "NewRecurringEvent")
            ' RemoveMenuItem(popupmenu, "StatusSubMenu")
            RemoveMenuItem(popupmenu, "GotoThisDay")
            RemoveMenuItem(popupmenu, "GotoToday")
            RemoveMenuItem(popupmenu, "GotoDate")
            RemoveMenuItem(popupmenu, "SwitchViewMenu")
            RemoveMenuItem(popupmenu, "LabelSubMenu")


            If e.Menu.MenuId = SchedulerMenuItemId.DefaultMenu Then
                e.Menu.ClientSideEvents.PopUp = "onContextMenuPopup"
            Else
                e.Menu.ClientSideEvents.PopUp = "OnClientPopupMenuShowing"
            End If

            If schdMechanics.ActiveView IsNot schdMechanics.Views.MonthView Then
                e.Menu.Items(1).BeginGroup = False
                e.Menu.Items(2).BeginGroup = False
                e.Menu.Items(3).BeginGroup = False

                Dim openOrder As New DevExpress.Web.MenuItem("Open Order", "OpenOrder")
                e.Menu.Items.Insert(3, openOrder)
                AddScheduleNewEventSubMenu(popupmenu, "Job Status")
                Dim transferToOrder As New DevExpress.Web.MenuItem("Transfer To Order", "TransferToOrder")
                transferToOrder.BeginGroup = True
                e.Menu.Items.Insert(6, transferToOrder)
                e.Menu.Items.Insert(7, New DevExpress.Web.MenuItem("Set On Hold", "SetOnHold"))
                e.Menu.BeginGroup = True
                e.Menu.Items.Insert(8, New DevExpress.Web.MenuItem("New Appointment", "OpenNewApt"))
                'e.Menu.Items.Insert(9, New DevExpress.Web.MenuItem("OnHold  Appointment List", "GetOnHold"))

                'This is for time interval
                If e.Menu.MenuId = SchedulerMenuItemId.DefaultMenu Then
                    e.Menu.Items.RemoveAll(Function(i) i.Name.StartsWith("SwitchTimeScale"))
                End If

                If e.Menu.MenuId = DevExpress.XtraScheduler.SchedulerMenuItemId.AppointmentMenu Then
                    Dim newItemCopy As New DevExpress.Web.MenuItem()
                    newItemCopy.Name = "CopyAppointment"
                    newItemCopy.Text = "Copy"
                    newItemCopy.ItemStyle.Font.Bold = True
                    e.Menu.Items.Add(newItemCopy)

                    Dim newItemCut As New DevExpress.Web.MenuItem()
                    newItemCut.Name = "CutAppointment"
                    newItemCut.Text = "Cut"
                    newItemCut.ItemStyle.Font.Bold = True
                    e.Menu.Items.Add(newItemCut)

                    e.Menu.JSProperties("cpMenuName") = "AppointmentMenu"
                End If
                If e.Menu.MenuId = DevExpress.XtraScheduler.SchedulerMenuItemId.DefaultMenu Then
                    Dim newItemPaste As New DevExpress.Web.MenuItem()
                    newItemPaste.Name = "PasteAppointment"
                    newItemPaste.Text = "Paste"
                    newItemPaste.ItemStyle.Font.Bold = True
                    e.Menu.Items.Insert(0, newItemPaste)
                    e.Menu.JSProperties("cpMenuName") = "DefaultMenu"
                End If

                'If e.Menu.MenuId = SchedulerMenuItemId.AppointmentMenu Then
                '    e.Menu.ClientSideEvents.ItemClick = String.Format("function(s, e) {{ DefaultAppointmentMenuHandler({0}, s, e); }}", schdMechanics.ClientInstanceName)
                'End If
            End If
                       
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "schedulerDayPlan_PopupMenuShowing", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub RemoveMenuItem(ByVal menu As ASPxSchedulerPopupMenu, ByVal menuItemName As String)
        Try
            Dim item As MenuItem = menu.Items.FindByName(menuItemName)
            If item IsNot Nothing Then
                menu.Items.Remove(item)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "RemoveMenuItem", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub resourceDataSource_ObjectCreated(sender As Object, e As ObjectDataSourceEventArgs)
        'If Session("CustomResourceDataSource") Is Nothing Then
        Session("CustomResourceDataSource") = New CustomResourceDataSource(GetCustomResources())
        ' End If

        e.ObjectInstance = Session("CustomResourceDataSource")
    End Sub
    Private Function GetCustomResources() As BindingList(Of CustomResource)
        Dim resources As New BindingList(Of CustomResource)()
        Dim objAppDO As New AppointmentDO
        Dim ds As DataSet = objAppDO.FetchMechanicDetails()
        'Newly Added
        For Each MyDataRow In ds.Tables(1).Rows
            If (MyDataRow("MEC_GROUP_NAME") <> "Regular") Then
                resources.Add(CreateCustomResourceH(-1, MyDataRow("MEC_GROUP_NAME")))
            End If

        Next
        'resources.Add(CreateCustomResourceH(-1, "Painter"))
        'resources.Add(CreateCustomResourceH(-1, "Service"))
        'resources.Add(CreateCustomResourceH(-1, "Technician"))
        'Newly Added
        For Each MyDataRow In ds.Tables(0).Rows
            resources.Add(CreateCustomResource(MyDataRow))
        Next
        Return resources
    End Function
    'Newly Added
    Private Function CreateCustomResourceH(ByVal parent_id As Integer, ByVal caption As String) As CustomResource
        Dim resdata As New CustomResource()

        resdata.ResID = caption
        resdata.Name = caption
        'resdata.Color = CType(If(IsDBNull(dtrow("Color")), "", dtrow("Color")), String)
        resdata.MECHANIC_ID = caption
        resdata.STANDARD_FROM_TIME = CType(Date.Now, DateTime)
        resdata.STANDARD_TO_TIME = CType(Date.Now, DateTime)
        resdata.MONDAY_FROM_TIME = CType(Date.Now, DateTime)
        resdata.MONDAY_TO_TIME = CType(Date.Now, DateTime)
        resdata.TUESDAY_FROM_TIME = CType(Date.Now, DateTime)
        resdata.TUESDAY_TO_TIME = CType(Date.Now, DateTime)
        resdata.WEDNESDAY_FROM_TIME = CType(Date.Now, DateTime)
        resdata.WEDNESDAY_TO_TIME = CType(Date.Now, DateTime)
        resdata.THURSDAY_FROM_TIME = CType(Date.Now, DateTime)
        resdata.THURSDAY_TO_TIME = CType(Date.Now, DateTime)
        resdata.FRIDAY_FROM_TIME = CType(Date.Now, DateTime)
        resdata.FRIDAY_TO_TIME = CType(Date.Now, DateTime)
        resdata.SATURDAY_FROM_TIME = CType(Date.Now, DateTime)
        resdata.SATURDAY_TO_TIME = CType(Date.Now, DateTime)
        resdata.SUNDAY_FROM_TIME = CType(Date.Now, DateTime)
        resdata.SUNDAY_TO_TIME = CType(Date.Now, DateTime)
        resdata.LUNCH_FROM_TIME = CType(Date.Now, DateTime)
        resdata.LUNCH_TO_TIME = CType(Date.Now, DateTime)
        resdata.PARENTRESID = parent_id
        resdata.MECHANIC_TYPE = caption + " - " + resdata.ResID

        Return resdata
    End Function
    'Newly Added
    Private Function CreateCustomResource(dtrow As DataRow) As CustomResource
        Dim resdata As New CustomResource()
        Try
            resdata.ResID = dtrow("ResourceID").ToString()
            resdata.Name = dtrow("ResourceName").ToString()
            'resdata.Color = CType(If(IsDBNull(dtrow("Color")), "", dtrow("Color")), String)
            resdata.MECHANIC_ID = If(IsDBNull(dtrow("MECHANIC_ID")), "", dtrow("MECHANIC_ID").ToString())
            resdata.STANDARD_FROM_TIME = CType(dtrow("STANDARD_FROM_TIME"), DateTime)
            resdata.STANDARD_TO_TIME = CType(dtrow("STANDARD_TO_TIME"), DateTime)
            resdata.MONDAY_FROM_TIME = CType(dtrow("MONDAY_FROM_TIME"), DateTime)
            resdata.MONDAY_TO_TIME = CType(dtrow("MONDAY_TO_TIME"), DateTime)
            resdata.TUESDAY_FROM_TIME = CType(dtrow("TUESDAY_FROM_TIME"), DateTime)
            resdata.TUESDAY_TO_TIME = CType(dtrow("TUESDAY_TO_TIME"), DateTime)
            resdata.WEDNESDAY_FROM_TIME = CType(dtrow("WEDNESDAY_FROM_TIME"), DateTime)
            resdata.WEDNESDAY_TO_TIME = CType(dtrow("WEDNESDAY_TO_TIME"), DateTime)
            resdata.THURSDAY_FROM_TIME = CType(dtrow("THURSDAY_FROM_TIME"), DateTime)
            resdata.THURSDAY_TO_TIME = CType(dtrow("THURSDAY_TO_TIME"), DateTime)
            resdata.FRIDAY_FROM_TIME = CType(dtrow("FRIDAY_FROM_TIME"), DateTime)
            resdata.FRIDAY_TO_TIME = CType(dtrow("FRIDAY_TO_TIME"), DateTime)
            resdata.SATURDAY_FROM_TIME = CType(dtrow("SATURDAY_FROM_TIME"), DateTime)
            resdata.SATURDAY_TO_TIME = CType(dtrow("SATURDAY_TO_TIME"), DateTime)
            resdata.SUNDAY_FROM_TIME = CType(dtrow("SUNDAY_FROM_TIME"), DateTime)
            resdata.SUNDAY_TO_TIME = CType(dtrow("SUNDAY_TO_TIME"), DateTime)
            resdata.LUNCH_FROM_TIME = CType(dtrow("LUNCH_FROM_TIME"), DateTime)
            resdata.LUNCH_TO_TIME = CType(dtrow("LUNCH_TO_TIME"), DateTime)
            'Newly Added
            'resdata.PARENTRESID = 0
            'resdata.MECHANIC_TYPE = "Regular"
            'If (resdata.ResID = "lv25" Or resdata.ResID = "pv24") Then
            '    resdata.PARENTRESID = "Painter"
            '    resdata.MECHANIC_TYPE = "Painter" + " - " + resdata.ResID
            'End If
            'If (resdata.ResID = "lv39" Or resdata.ResID = "NPavi") Then
            '    resdata.PARENTRESID = "Service"
            '    resdata.MECHANIC_TYPE = "Service" + " - " + resdata.ResID
            'End If
            'Newly Added

            If dtrow("MEC_TYPE").ToString() = "Regular" Then
                resdata.PARENTRESID = 0
                resdata.MECHANIC_TYPE = "Regular"
            Else
                resdata.PARENTRESID = dtrow("MEC_TYPE").ToString()
                resdata.MECHANIC_TYPE = dtrow("MEC_TYPE").ToString()
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "CreateCustomResource", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

        Return resdata
    End Function

    Protected Sub appointmentDataSource_ObjectCreated(sender As Object, e As ObjectDataSourceEventArgs)
        Me.objectInstance = New CustomEventDataSource(GetCustomEvents())
        e.ObjectInstance = Me.objectInstance
    End Sub
    Private Function GetCustomEvents() As CustomEventList
        Dim resources As CustomResourceDataSource = TryCast(Session("CustomResourceDataSource"), CustomResourceDataSource)

        Dim events_Renamed As CustomEventList = TryCast(Session("CustomEventListData"), CustomEventList)
        If events_Renamed Is Nothing Then
            events_Renamed = New CustomEventList()
            Session("CustomEventListData") = events_Renamed
        End If
        Return events_Renamed
    End Function

    Protected Sub schdMechanics_BeforeExecuteCallbackCommand(sender As Object, e As SchedulerCallbackCommandEventArgs)
        If e.CommandId = SchedulerCallbackCommandId.AppointmentSave Then
            e.Command = New CustomAppointmentSaveCallbackCommand(DirectCast(sender, ASPxScheduler))
        End If

        If e.CommandId = SchedulerCallbackCommandId.MenuAppointment Or e.CommandId = SchedulerCallbackCommandId.MenuView Then
            HttpContext.Current.Session("isEditing") = "no"
        End If

    End Sub

    Protected Sub schdMechanics_AppointmentRowInserted(sender As Object, e As ASPxSchedulerDataInsertedEventArgs)
        e.KeyFieldValue = Me.objectInstance.ObtainLastInsertedId()
    End Sub

    Protected Sub schdMechanics_AfterExecuteCallbackCommand(sender As Object, e As SchedulerCallbackCommandEventArgs)
        If (e.CommandId = SchedulerCallbackCommandId.AppointmentSave Or e.CommandId = SchedulerCallbackCommandId.AppointmentsChange) Then
            schdMechanics.JSProperties("cpRefresh") = "true"
        End If
        If Session("isSetOnHold") Then
            Dim selectionStart As DateTime = schdMechanics.ActiveView.SelectedInterval.Start
            Session("isSetOnHold") = False
            schdMechanics.ActiveView.SetSelection(New TimeInterval(selectionStart, (CType(schdMechanics.ActiveView, DayView)).TimeScale), schdMechanics.SelectedResource)
        End If
    End Sub
    Protected Sub schdMechanics_InitAppointmentDisplayText(sender As Object, e As AppointmentDisplayTextEventArgs)
        Try
            If Not (e.Appointment Is Nothing) AndAlso Not (e.Appointment.CustomFields("ApptVehicleRegNo") Is Nothing) AndAlso Not (e.Appointment.CustomFields("ApptAptNumberDisplayData") Is Nothing) Then
                e.Text = "Appt No : " + e.Appointment.CustomFields("ApptAptNumberDisplayData").ToString() + Environment.NewLine + e.Appointment.CustomFields("ApptVehicleRegNo").ToString() + Environment.NewLine + e.Appointment.Description.ToString() + Environment.NewLine + e.Appointment.CustomFields("ApptFirstName").ToString() + " " + e.Appointment.CustomFields("ApptMiddleName").ToString() + " " + e.Appointment.CustomFields("ApptLastName").ToString()
                e.Description = ""
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "schdMechanics_InitAppointmentDisplayText", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub schdMechanics_CustomJSProperties(sender As Object, e As CustomJSPropertiesEventArgs)
        e.Properties("cpCustomWorkTime") = WorkTimeDictionary
        e.Properties("cpLunchCustomWorkTime") = LunchWorkTimeDictionary
        e.Properties("cpWidth") = 200 * schdMechanics.ActiveView.GetResources().Count
    End Sub
    Protected Sub SubjectLbl_Init(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim label = DirectCast(sender, ASPxLabel)
            Dim container = CType(label.NamingContainer.NamingContainer, VerticalAppointmentTemplateContainer)
            If Not (container.AppointmentViewInfo.Appointment Is Nothing) AndAlso Not (container.AppointmentViewInfo.Appointment.CustomFields("ApptVehicleRegNo") Is Nothing) AndAlso Not (container.AppointmentViewInfo.Appointment.CustomFields("ApptAptNumberDisplayData") Is Nothing) Then
                label.Text = "Appt No : " + container.AppointmentViewInfo.Appointment.CustomFields("ApptAptNumberDisplayData").ToString() + Environment.NewLine + container.AppointmentViewInfo.Appointment.CustomFields("ApptVehicleRegNo").ToString() + Environment.NewLine + container.AppointmentViewInfo.Appointment.Description.ToString() + Environment.NewLine + container.AppointmentViewInfo.Appointment.CustomFields("ApptFirstName").ToString() + " " + container.AppointmentViewInfo.Appointment.CustomFields("ApptMiddleName").ToString() + " " + container.AppointmentViewInfo.Appointment.CustomFields("ApptLastName").ToString()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "SubjectLbl_Init", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub panel1_Init(ByVal sender As Object, ByVal e As EventArgs)
        Dim panel = DirectCast(sender, ASPxPanel)
        Dim container = CType(panel.NamingContainer, VerticalAppointmentTemplateContainer)
        panel.BackColor = container.AppointmentViewInfo.AppointmentStyle.BackColor
    End Sub
    Protected Sub panel2_Init(ByVal sender As Object, ByVal e As EventArgs)
        Dim panel = DirectCast(sender, ASPxPanel)
        Dim container = CType(panel.NamingContainer.NamingContainer, VerticalAppointmentTemplateContainer)
        panel.BackColor = container.AppointmentViewInfo.StatusColor
    End Sub

    Protected Sub schdMechanics_HtmlTimeCellPrepared(handler As Object, e As ASPxSchedulerTimeCellPreparedEventArgs)
        Try

            e.Cell.CssClass &= " droppableScheduler"
            e.Cell.Attributes.Add("intResource", e.Resource.Id.ToString())
            e.Cell.Attributes.Add("intStart", e.Interval.Start.ToShortDateString() + " " + e.Interval.Start.ToShortTimeString())
            e.Cell.Attributes.Add("intEnd", e.Interval.End.ToShortDateString() + " " + e.Interval.End.ToShortTimeString())
            Dim intervalStart As Integer = e.Interval.Start.Hour * 60 + e.Interval.Start.Minute
            e.Cell.Attributes.Add("intervalStart", intervalStart)
            e.Cell.Attributes.Add("intDayOfWeek", e.Interval.Start.DayOfWeek)
            Dim timeCell As WebTimeCell = TryCast(e.Cell, WebTimeCell)

            If schdMechanics.ActiveView IsNot schdMechanics.Views.MonthView Then
                If timeCell IsNot Nothing Then
                    If (timeCell.Resource.Id.ToString() <> "DevExpress.XtraScheduler.EmptyResourceId") Then
                        If timeCell IsNot Nothing AndAlso WorkTimeDictionary.ContainsKey(timeCell.Resource.Id) Then
                            Dim workTimes As List(Of CustomTimeInterval) = WorkTimeDictionary(timeCell.Resource.Id)
                            Dim holidayTimes As List(Of HolidayTimeInterval) = New List(Of HolidayTimeInterval)()

                            Dim HolTimeDictionaryEach As New List(Of HolidayTimeInterval)()

                            If (HolidayTimeDictionary.ContainsKey(timeCell.Resource.Id)) Then
                                holidayTimes = HolidayTimeDictionary(timeCell.Resource.Id)
                            End If

                            'Dim result = holdayList.Where(Function(x) x.Key = timeCell.Resource.Id)

                            Dim holdReason As String = ""
                            Dim isWorkTime As Boolean = False
                            Dim isHoliday As Boolean = False
                            Dim holidayFromTime As New Date
                            Dim holidayToTime As New Date
                            Dim holidayFromHr As Integer
                            Dim holidayFromMin As Integer
                            Dim holidayToHr As Integer
                            Dim holidayToMin As Integer

                            Dim cellStartTime As Integer = timeCell.Interval.Start.Hour * 60 + timeCell.Interval.Start.Minute
                            Dim cellEndTime As Integer = timeCell.Interval.End.Hour * 60 + timeCell.Interval.End.Minute
                            Dim DayOfWeek As Integer = timeCell.Interval.Start.DayOfWeek

                            Dim stlunch As New Date
                            stlunch = CDate(e.Resource.CustomFields("LUNCH_FROM_TIME"))
                            Dim stlunchHr As Integer = stlunch.Hour
                            Dim stlunchMin As Integer = stlunch.Minute

                            Dim endlunch As New Date
                            endlunch = CDate(e.Resource.CustomFields("LUNCH_TO_TIME"))
                            Dim endlunchHr As Integer = endlunch.Hour
                            Dim endlunchMin As Integer = endlunch.Minute

                            Dim resourceLunchStart = stlunchHr * 60 + stlunchMin
                            Dim resourceLunchEnd = endlunchHr * 60 + endlunchMin

                            For Each item As CustomTimeInterval In workTimes
                                If item.StartTime <= cellStartTime AndAlso item.EndTime >= cellEndTime AndAlso item.DayOfWeek = DayOfWeek Then
                                    If (item.StartTime = 0 AndAlso item.EndTime = 0) Then
                                        isWorkTime = False
                                        Exit For
                                    Else
                                        isWorkTime = True
                                        Exit For
                                    End If
                                End If
                            Next item

                            For Each itemHold As HolidayTimeInterval In holidayTimes
                                Dim holdMech As String = ""
                                Dim holDate As Date = itemHold.MechHolidayDate.Date
                                Dim holdDay As Integer = itemHold.MechHolidayDate.Day

                                holidayFromHr = itemHold.MechHolidayFromTime
                                holidayToHr = itemHold.MechHolidayToTime
                                holdReason = itemHold.MechLeaveReason
                                holdMech = itemHold.MechId

                                If (holDate = timeCell.Interval.Start.Date And holdMech = timeCell.Resource.Id) Then
                                    'isWorkTime = False
                                    isHoliday = True
                                    Exit For
                                End If
                            Next itemHold

                            If (Not isWorkTime) OrElse cellEndTime = 0 Then
                                e.Cell.BackColor = System.Drawing.Color.AliceBlue
                                If (isHoliday) Then

                                    If cellStartTime >= holidayFromHr AndAlso cellEndTime <= holidayToHr Then
                                        e.Cell.BackColor = System.Drawing.Color.LightGray
                                    End If

                                    If (cellStartTime = holidayFromHr) Then
                                        e.Cell.Text = holdReason
                                        e.Cell.ToolTip = holdReason
                                    End If
                                    e.Cell.ToolTip = holdReason
                                End If

                                If cellStartTime >= resourceLunchStart AndAlso cellEndTime <= resourceLunchEnd Then
                                    e.Cell.BackColor = System.Drawing.Color.Pink
                                    e.Cell.ToolTip = "Lunch"
                                End If

                            Else
                                e.Cell.BackColor = System.Drawing.Color.White
                            End If

                            If (isHoliday) Then

                                If cellStartTime >= holidayFromHr AndAlso cellEndTime <= holidayToHr Then
                                    e.Cell.BackColor = System.Drawing.Color.LightGray
                                    e.Cell.ToolTip = holdReason
                                End If

                                If (cellStartTime = holidayFromHr) Then
                                    e.Cell.Text = holdReason
                                    e.Cell.ToolTip = holdReason
                                End If
                                'e.Cell.ToolTip = holdReason
                            End If


                        End If
                    End If
                End If
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "schdMechanics_HtmlTimeCellPrepared", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub schdMechanics_InitClientAppointment(sender As Object, args As InitClientAppointmentEventArgs)
        args.Properties.Add("WONONum", args.Appointment.CustomFields("ApptWONONumInfo"))
        args.Properties.Add("IsOverTime", args.Appointment.CustomFields("ApptIsOverTime"))
        args.Properties.Add("TooltipDisplayData", args.Appointment.CustomFields("ApptTooltipDisplayData"))
        args.Properties.Add("AptNumberDisplayData", args.Appointment.CustomFields("ApptAptNumberDisplayData"))
        args.Properties.Add("IsOrder", args.Appointment.CustomFields("ApptIsOrder"))
        args.Properties.Add("AppointmentDetId", args.Appointment.CustomFields("ApptAppointmentDetId"))
        args.Properties.Add("WOPrefix", args.Appointment.CustomFields("ApptWOPrefixInfo"))
        'schdMechanics.JSProperties("cpApptIsOverTime") = args.Appointment.CustomFields("ApptIsOverTime").ToString()
    End Sub
    Protected Sub cbOrderList_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim strOperation As String = ""
            Dim selectedItemText As String = e.Parameter.ToString
            Dim selectedItemTexts() As String = selectedItemText.Split(";")

            If selectedItemTexts.Length > 0 Then
                strOperation = selectedItemTexts(0).Trim()
            End If

            If strOperation = "ExistingOrder" Then
                If (selectedItemTexts.Length = 6) Then
                    Dim WO_NO As String = selectedItemTexts(1).Trim()
                    Dim WO_STATUS As String = selectedItemTexts(3).Trim()
                    Dim WO_PREFIX As String = selectedItemTexts(2).Trim()
                    Dim appointmentId As Integer = CInt(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomInfo"))
                    Dim dsAll As DataSet = HttpContext.Current.Session("AppointmentDataSource")
                    Dim dt As DataTable = dsAll.Tables(0)

                    Dim selRecord As Integer = schdMechanics.SelectedAppointments(0).Id
                    'to get gridview id to update on drag
                    Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                    .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                    .Id = schdata.Field(Of Integer)("APPOINTMENT_ID")
                    }).Where(Function(customer) customer.Id = selRecord)

                    Dim selGridViewId As Integer = gdata(0).gvId

                    Dim objAppDO As New AppointmentDO
                    Dim strResult As String = ""
                    'objAppDO.ProcessOrders(appointmentId, selGridViewId, WO_NO, WO_STATUS, WO_PREFIX)
                    strResult = objAppDO.ProcessOrders(appointmentId, selGridViewId, WO_NO, WO_STATUS, WO_PREFIX)

                Else
                    GetExistingOrders()
                End If
            End If

            If strOperation = "CreateOrder" Then
                Dim strResCreateOrder As String = ConvertAppointmentToOrder()
            ElseIf strOperation = "CreateOrderGoTo" Then
                Dim strResOrdGoTo As String = ConvertAppointmentToOrder()
                Dim strOrd As String() = strResOrdGoTo.Split(";")
                If strOrd.Length > 1 Then
                    If strOrd(0) = "INS" Then
                        Dim strWOPrefix As String = strOrd(1)
                        Dim strWONO As String = strOrd(2)
                        Dim strPath As String = "~/Transactions/frmWOJobDetails.aspx?Wonumber=" + strWONO + "&WOPrefix=" + strWOPrefix + "&Mode=Edit&TabId=2&Flag=Ser&blWOsearch=true"
                        'ASPxWebControl.RedirectOnCallback(strPath)
                        ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute(strPath))
                    End If
                End If
            ElseIf strOperation = "CreateBAROrder" Then
                Dim strInterval As String = schdMechanics.SelectedResource.Id
            ElseIf strOperation = "OpenOrder" Then
                Dim woNum As String = schdMechanics.SelectedAppointments(0).CustomFields("ApptWONONumInfo")
                Dim woPr As String = schdMechanics.SelectedAppointments(0).CustomFields("ApptWOPrefixInfo")
                Dim strPath As String = "~/Transactions/frmWOJobDetails.aspx?Wonumber=" + woNum + "&WOPrefix=" + woPr + "&Mode=Edit&TabId=2&Flag=Ser&blWOsearch=true"
                ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute(strPath))
            End If
            If (strOperation = "SetOnHold") Then
                ProcessOnHoldAppointment("UPDATEONHOLD")
                Session("isSetOnHold") = True
            End If
            If (strOperation = "GetOnHold") Then
                ProcessOnHoldAppointment("FETCH")
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "cbOrderList_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
    Public Sub ProcessOnHoldAppointment(action As String)
        Try
            If action = "UPDATEONHOLD" Then
                Dim dsAll As DataSet = HttpContext.Current.Session("AppointmentDataSource")
                Dim dt As DataTable = dsAll.Tables(0)
                Dim selRecord As Integer = schdMechanics.SelectedAppointments(0).Id
                'to get gridview id to update on drag
                Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
            .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
            .Id = schdata.Field(Of Integer)("APPOINTMENT_ID"),
            .appId = schdata.Field(Of Integer)("ID_APT_HDR")
            }).Where(Function(customer) customer.Id = selRecord)

                Dim selGridViewId As Integer = gdata(0).gvId
                Dim selAppointmentId As Integer = gdata(0).appId
                'Dim objAppointmentDO As New AppointmentDO

                objAppointmentDO.ProcessOnHoldAppointment(selGridViewId, action, DateTime.Now, DateTime.Now, "")

            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "ProcessOnHoldAppointment", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Public Function ConvertAppointmentToOrder() As String
        Dim strRes As String = ""
        Try
            Dim appointmentId As Integer = CInt(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomInfo"))
            Dim dsAll As DataSet = HttpContext.Current.Session("AppointmentDataSource")
            Dim dt As DataTable = dsAll.Tables(0)

            Dim selRecord As Integer = schdMechanics.SelectedAppointments(0).Id
            'to get gridview id to update on drag
            Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                    .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                    .Id = schdata.Field(Of Integer)("APPOINTMENT_ID"),
                    .customerId = schdata.Field(Of String)("CUSTOMER_NUMBER"),
                    .vehicleId = schdata.Field(Of Integer)("ID_VEH_SEQ_WO"),
                    .resourceId = schdata.Field(Of String)("RESOURCE_ID")
                    }).Where(Function(customer) customer.Id = selRecord)

            Dim appmntDetId As Integer = gdata(0).gvId
            Dim customerId As String = gdata(0).customerId
            Dim vehicleId As Integer = gdata(0).vehicleId
            Dim resourceId As String = gdata(0).resourceId

            Dim objAppDO As New AppointmentDO
            strRes = objAppDO.CreateOrderOnAppointment(appointmentId, appmntDetId, customerId, vehicleId, resourceId, loginName)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "ConvertAppointmentToOrder", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRes
    End Function

    Protected Sub lbExisOrders_CustomJSProperties(sender As Object, e As CustomJSPropertiesEventArgs)
        'e.Properties("")
    End Sub

    Protected Sub schdMechanics_AppointmentFormShowing(sender As Object, e As AppointmentFormEventArgs)
        If (e.Appointment.ResourceId.ToString() <> "DevExpress.XtraScheduler.EmptyResourceId") Then
            Session("MecIdFromDate") = e.Appointment.Start.ToString() + "$" + e.Appointment.ResourceId.ToString()
        End If
    End Sub

    Protected Sub schdMechanics_AppointmentChanging(sender As Object, e As PersistentObjectCancelEventArgs)
        If TypeOf e.[Object] Is Appointment Then
            If schdMechanics.SelectedAppointments.Count > 0 Then
                TryCast(e.[Object], Appointment).CustomFields("IsOverTime") = schdMechanics.SelectedAppointments(0).CustomFields("ApptIsOverTime")
            End If

        End If
    End Sub
    Protected Sub rbListOrdersMenu_Init(sender As Object, e As EventArgs)
        rbListOrdersMenu.Items.Add("Create Order", "CreateNewOrder")
        rbListOrdersMenu.Items.Add("Create Order and Go to Order", "CreateNewGotoOrder")
        rbListOrdersMenu.Items.Add("Transfer to Existing Order", "ExistingOrder")
        rbListOrdersMenu.SelectedIndex = 0
    End Sub


    'Order Popup Changes End
    Protected Sub cbOnHoldList_Callback(sender As Object, e As CallbackEventArgsBase)
        If e.Parameter.Count > 1 Then
            Dim apptDtlId As Integer

            Dim selectedItemText As String = e.Parameter.ToString
            Dim selectedItemTexts() As String = selectedItemText.Split(";")

            If selectedItemTexts.Count > 1 Then
                apptDtlId = CInt(selectedItemTexts(0).Trim)

                'Dim objAppointmentDO As New AppointmentDO
                Dim dsOnHoldApp As New DataSet
                dsOnHoldApp = objAppointmentDO.ProcessOnHoldAppointment(apptDtlId, "UPDATE", schdMechanics.ActiveView.SelectedInterval.Start, schdMechanics.ActiveView.SelectedInterval.End, schdMechanics.SelectedResource.Id)
            End If
        Else
            'Dim objAppointmentDO As New AppointmentDO
            Dim dsOnHoldApp As New DataSet
            dsOnHoldApp = objAppointmentDO.ProcessOnHoldAppointment(1, "FETCH", DateTime.Now, DateTime.Now, "")
            lbOnHoldApp.DataSource = dsOnHoldApp
            lbOnHoldApp.DataBind()
            'gvOnHold.DataSource = dsOnHoldApp
            'gvOnHold.DataBind()
        End If

    End Sub

    Protected Sub cbJobStatus_Callback(source As Object, e As CallbackEventArgs)
        Dim objAppDO As New AppointmentDO
        Dim loginName As String = HttpContext.Current.Session("UserID").ToString()
        Dim LabelId As Integer
        Dim apptId As Integer
        Dim apt As Appointment = schdMechanics.SelectedAppointments(0)
        Dim selGridViewId As Integer
        If (e.Parameter.Contains("JobStatus")) Then
            Dim paramTexts() As String = e.Parameter.Split("$")
            If (paramTexts.Count > 0 And schdMechanics.SelectedAppointments.Count > 0) Then
                LabelId = CInt(paramTexts(1).Trim)

                Dim dsAll As DataSet = HttpContext.Current.Session("AppointmentDataSource")
                Dim dt As DataTable = dsAll.Tables(0)

                Dim selRecord As Integer = apt.Id
                Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                   .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                   .aptId = schdata.Field(Of Integer)("ID_APT_HDR"),
                   .Id = schdata.Field(Of Integer)("APPOINTMENT_ID")
                   }).Where(Function(customer) customer.Id = selRecord)

                selGridViewId = gdata(0).gvId
            End If

        End If
        objAppDO.ProcessAppointmentDetails("UPDATE_JOB_STATUS", selGridViewId, DateTime.Now, DateTime.Now, DateTime.Now, DateTime.Now, "", "", "", 0, "", loginName, "", LabelId, "", "", "", "", "", 1, False)

    End Sub
    'Newly Added
    Protected Sub schdMechanics_FilterResource(sender As Object, e As PersistentObjectCancelEventArgs)
        Try
            If Not (resourceGroupList.IsCallback) Then
                Dim resourcesFilter As New List(Of String)()
                Dim selectedNodes As List(Of TreeListNode) = resourceGroupList.GetSelectedNodes()
                Dim selectedMec As String
                For i As Integer = 0 To selectedNodes.Count - 1
                    selectedMec = selectedNodes(i)("ResID")
                    If (selectedMec.Contains("_")) Then
                        selectedMec = selectedMec.Substring(0, selectedMec.IndexOf("_"))
                    End If
                    If (Not selectedNodes(i).HasChildren) Then
                        If Not (resourcesFilter.Contains(selectedMec)) Then
                            resourcesFilter.Add(selectedMec)
                        End If
                    End If
                Next i
                e.Cancel = Not resourcesFilter.Contains(((TryCast(e.Object, Resource)).Id))
                schdMechanics.SetVisibleResources(resourcesFilter)

                If resourceGroupList.SelectionCount < 1 And resourceGroupList.Nodes.Count > 0 Then
                    resourceGroupList.Nodes.Item(0).Selected = True
                End If
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "schdMechanics_FilterResource", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub gvOnHold_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        Try
            If e.RowType = GridViewRowType.Data Then
                e.Row.Attributes.Add("appGridIndex", e.VisibleIndex.ToString())
                'Dim appointmentNoInfo = e.GetValue("APPOINTMENT_NO").ToString().Split("-")
                e.Row.Attributes.Add("appAppointmentId", 0)
                e.Row.Attributes.Add("appAppointmentDetailsId", e.KeyValue)
                e.Row.Attributes.Add("appRegNo", e.GetValue("VEHICLE_REG_NO").ToString())
                'Session("OnHoldApp")
                Dim dsApp As DataSet = HttpContext.Current.Session("OnHoldApp")
                Dim dtApp As DataTable = dsApp.Tables(0)
                Dim dsAll As DataSet = HttpContext.Current.Session("OnHoldApp")
                Dim dt As DataTable = dsAll.Tables(0)
                Dim selRecord As Integer = e.KeyValue
                Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                   .startDate = schdata.Field(Of DateTime)("START_DATE"),
                   .endDate = schdata.Field(Of DateTime)("END_DATE"),
                   .Id = schdata.Field(Of Integer)("ID_APPOINTMENT_DETAILS"),
                      .vehRegNo = schdata.Field(Of String)("VEHICLE_REG_NO"),
                   .cusFName = schdata.Field(Of String)("CUSTOMER_FIRST_NAME"),
                   .cusMName = schdata.Field(Of String)("CUSTOMER_MIDDLE_NAME"),
                   .cusLName = schdata.Field(Of String)("CUSTOMER_LAST_NAME"),
                   .vehMake = schdata.Field(Of String)("VEH_MAKE"),'Here
                   .vehModel = schdata.Field(Of String)("WO_VEH_MOD"),
                   .reservation = schdata.Field(Of String)("RESERVATION"),
                   .appointmentNo = schdata.Field(Of String)("APPOINTMENT_NO")
                   }).Where(Function(customer) customer.Id = selRecord)

                Dim selStartDate As DateTime = gdata(0).startDate
                Dim selEndDate As DateTime = gdata(0).endDate
                Dim duration As TimeSpan = selEndDate - selStartDate
                e.Row.Attributes.Add("appDuration", duration.TotalMinutes)

                'e.Row.ToolTip = "Vehicle Registration No : " + gdata(0).vehRegNo.ToString() + Environment.NewLine + gdata(0).reservation + Environment.NewLine + gdata(0).cusFName + " " + gdata(0).cusMName + " " + gdata(0).cusLName + Environment.NewLine + gdata(0).vehMake.ToString() + " " + gdata(0).vehModel
                e.Row.ToolTip = gdata(0).appointmentNo + Environment.NewLine + gdata(0).cusFName + " " + gdata(0).cusMName + " " + gdata(0).cusLName + Environment.NewLine + gdata(0).vehRegNo.ToString() + Environment.NewLine + gdata(0).reservation + Environment.NewLine + gdata(0).vehMake.ToString() + Environment.NewLine + gdata(0).vehModel
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "gvOnHold_HtmlRowPrepared", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try


    End Sub

    Protected Sub gvOnHold_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)
        'Dim scheduler = DirectCast(sender, ASPxScheduler)
        Try
            Dim parameters() As String = e.Parameters.Split("|"c)
            If parameters(0) = "UPDATE" Then
                If parameters(3) <> "undefined" Or parameters(8) <> "undefined" Then

                    Dim dsOnHoldApp As New DataSet
                    Dim startDate = Date.Parse(parameters(5))
                    Dim endDate = Date.Parse(parameters(5)).AddMinutes(Convert.ToInt32(parameters(8)))
                    dsOnHoldApp = objAppointmentDO.ProcessOnHoldAppointment(parameters(4), "UPDATE", startDate, endDate, parameters(2))
                    schdMechanics.Storage.RefreshData()
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "gvOnHold_CustomCallback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    'Newly Added
    Protected Sub schdMechanics_CustomCallback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim events_Renamed As CustomEventList = TryCast(Session("CustomEventListData"), CustomEventList)
            If e.Parameter = "PasteAppointment" AndAlso hdCopiedAppointmentID.Value <> "" AndAlso hdType.Value.ToString().ToLower() = "copy" Then
                Dim copyAppointmentID As Integer = Convert.ToInt32(hdCopiedAppointmentID.Value)
                Dim sourceAppointment As Appointment = schdMechanics.Storage.Appointments.GetAppointmentById(copyAppointmentID)
                If sourceAppointment IsNot Nothing Then
                    Dim newAppointment As Appointment = schdMechanics.Storage.CreateAppointment(sourceAppointment.Type)
                    newAppointment.Description = sourceAppointment.Description
                    newAppointment.LabelKey = sourceAppointment.LabelKey
                    newAppointment.Location = sourceAppointment.Location
                    newAppointment.ResourceId = schdMechanics.SelectedResource.Id
                    newAppointment.Subject = sourceAppointment.Subject
                    newAppointment.StatusKey = sourceAppointment.StatusKey
                    newAppointment.Start = schdMechanics.SelectedInterval.Start
                    newAppointment.End = newAppointment.Start + sourceAppointment.Duration
                    newAppointment.CustomFields("ApptCustomInfo") = sourceAppointment.CustomFields("ApptCustomInfo")
                    newAppointment.CustomFields("ApptAptNumberDisplayData") = sourceAppointment.CustomFields("ApptAptNumberDisplayData")
                    newAppointment.CustomFields("ApptAppointmentDetId") = sourceAppointment.CustomFields("ApptAppointmentDetId")

                    schdMechanics.Storage.Appointments.Add(newAppointment)
                    schdMechanics.JSProperties("cpCallBackParameter") = "PasteAppointment"
                End If
            End If

            If e.Parameter = "PasteAppointment" AndAlso hdCopiedAppointmentID.Value <> "" AndAlso hdType.Value.ToString().ToLower() = "cut" Then
                Dim copyAppointmentID As Integer = Convert.ToInt32(hdCopiedAppointmentID.Value)
                Dim sourceAppointment As Appointment = schdMechanics.Storage.Appointments.GetAppointmentById(copyAppointmentID)
                If sourceAppointment IsNot Nothing Then
                    Dim newAppointment As Appointment = schdMechanics.Storage.CreateAppointment(sourceAppointment.Type)
                    newAppointment.Description = sourceAppointment.Description
                    newAppointment.LabelKey = sourceAppointment.LabelKey
                    newAppointment.Location = sourceAppointment.Location
                    newAppointment.ResourceId = schdMechanics.SelectedResource.Id
                    newAppointment.Subject = sourceAppointment.Subject
                    newAppointment.StatusKey = sourceAppointment.StatusKey
                    newAppointment.Start = schdMechanics.SelectedInterval.Start
                    newAppointment.End = newAppointment.Start + sourceAppointment.Duration
                    newAppointment.CustomFields("ApptCustomInfo") = sourceAppointment.CustomFields("ApptCustomInfo")
                    newAppointment.CustomFields("ApptAptNumberDisplayData") = sourceAppointment.CustomFields("ApptAptNumberDisplayData")
                    newAppointment.CustomFields("ApptAppointmentDetId") = sourceAppointment.CustomFields("ApptAppointmentDetId")

                    Dim appointmentDetId As Integer = Convert.ToInt32(sourceAppointment.CustomFields("ApptAppointmentDetId"))
                    Dim resourceIds As String = "<ResourceIds><ResourceId Type = ""System.String"" Value=""" + newAppointment.ResourceId.ToString() + """ /></ResourceIds>"

                    schdMechanics.JSProperties("cpCallBackParameter") = "PasteAppointment"
                    Dim objCustEvent As New CustomEventDataSource
                    objCustEvent.ChangeAppointmentDetails(appointmentDetId, newAppointment.Start, newAppointment.End, newAppointment.ResourceId, resourceIds, newAppointment.StatusKey)

                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "schdMechanics_CustomCallback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub resourceGroupList_SelectionChanged(sender As Object, e As EventArgs)
        Dim tree As ASPxTreeList = TryCast(sender, ASPxTreeList)
        If LastSelectedNodeKey.Contains("LastSelectedNodeKey") = True Then
            If Convert.ToBoolean(LastSelectedNodeKey.Get("IsNodeSelected")) = True Then

                Dim selectedNodeKey = LastSelectedNodeKey.Get("LastSelectedNodeKey").ToString()
                Dim selectedNode = tree.FindNodeByKeyValue(selectedNodeKey.ToString())

                If selectedNode.HasChildren Then
                    tree.UnselectAll()
                End If

                selectedNode.Selected = True
            End If
        End If
        tree.JSProperties("cpShouldUpdated") = True
    End Sub

    Protected Sub resourceGroupList_HtmlRowPrepared(sender As Object, e As TreeListHtmlRowEventArgs)
        e.Row.Attributes.Add("data-nodekey", e.NodeKey)
    End Sub

    <Web.Services.WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function DoCancel(ByVal cancel As String) As String
        HttpContext.Current.Session("Edit") = "no"
        HttpContext.Current.Session("aptSavedState") = Nothing
        Return ""
    End Function

    Protected Sub schdMechanics_InitNewAppointment(sender As Object, e As AppointmentEventArgs)
        Try
            Dim apt As Appointment = CType(Session("aptSavedState"), Appointment)
            If (apt IsNot Nothing) Then
                Dim aptStart As DateTime = e.Appointment.Start
                Dim aptEnd As DateTime = e.Appointment.End
                Dim resourceId As Object = e.Appointment.ResourceId
                'If apt.Description IsNot "" Then ' Need to Check this Condition Properly
                e.Appointment.Assign(apt)
                'hdnAddNewRow.Set("AddRow", True)
                e.Appointment.Start = aptStart
                e.Appointment.End = aptEnd
                e.Appointment.ResourceId = resourceId
                'Else
                '    Session("aptSavedState") = Nothing
                'End If

            Else
                Session("aptSavedState") = e.Appointment
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Protected Sub cbOrders_Callback(sender As Object, e As CallbackEventArgsBase)
        Try
            Dim strOperation As String = ""
            Dim selectedItemText As String = e.Parameter.ToString
            Dim selectedItemTexts() As String = selectedItemText.Split(";")

            If selectedItemTexts.Length > 0 Then
                strOperation = selectedItemTexts(0).Trim()
            End If

            If strOperation = "FETCH" Then
                If schdMechanics.SelectedAppointments.Count > 0 Then
                    Dim ds As DataSet = New DataSet()
                    Dim vehicleNo As Integer
                    Dim objAppDO As New AppointmentDO
                    If schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo").ToString = "" Then
                        vehicleNo = 0
                    Else
                        vehicleNo = Convert.ToInt32(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo").ToString)
                    End If

                    Dim dsAll As DataSet = HttpContext.Current.Session("AppointmentDataSource")
                    Dim dt As DataTable = dsAll.Tables(0)

                    Dim selRecord As Integer = schdMechanics.SelectedAppointments(0).Id
                    'to get gridview id to update on drag
                    Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                        .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                        .aptId = schdata.Field(Of Integer)("ID_APT_HDR"),
                        .Id = schdata.Field(Of Integer)("APPOINTMENT_ID")
                        }).Where(Function(customer) customer.Id = selRecord)

                    Dim selGridViewId As Integer = gdata(0).gvId
                    Dim selApptId As Integer = gdata(0).aptId

                    ' Dim vehicleNo As Integer = IIf(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo") = "", 0, Convert.ToInt32(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomVehicleNo")))
                    Dim customereNo As String = IIf(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomerNumber") = "", "", schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomerNumber").ToString())
                    ds = objAppDO.FetchExistingOrders(customereNo, vehicleNo, selGridViewId, selApptId)
                    If (ds.Tables(0).Rows.Count = 0) Then
                        lbOrdersList.JSProperties("cpRecordExist") = "NO"
                    Else
                        lbOrdersList.JSProperties("cpRecordExist") = "YES"
                    End If

                    lbOrdersList.DataSource = ds
                    lbOrdersList.DataBind()
                End If
            ElseIf strOperation = "CREATE_ORDER" Then
                Dim strResCreateOrder As String = ConvertAppointmentToOrder()
            ElseIf strOperation = "CREATE_ORDER_GOTO" Then
                Dim strResOrdGoTo As String = ConvertAppointmentToOrder()
                Dim strOrd As String() = strResOrdGoTo.Split(";")
                If strOrd.Length > 1 Then
                    If strOrd(0) = "INS" Then
                        Dim strWOPrefix As String = strOrd(1)
                        Dim strWONO As String = strOrd(2)
                        Dim strPath As String = "~/Transactions/frmWOJobDetails.aspx?Wonumber=" + strWONO + "&WOPrefix=" + strWOPrefix + "&Mode=Edit&TabId=2&Flag=Ser&blWOsearch=true"
                        'ASPxWebControl.RedirectOnCallback(strPath)
                        ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute(strPath))
                    End If
                End If
            ElseIf strOperation = "EXISTING_ORDER" Then
                If (selectedItemTexts.Length = 6) Then
                    Dim WO_PREFIX As String = selectedItemTexts(1).Trim()
                    Dim WO_STATUS As String = selectedItemTexts(3).Trim()
                    Dim WO_NO As String = selectedItemTexts(2).Trim()
                    Dim appointmentId As Integer = CInt(schdMechanics.SelectedAppointments(0).CustomFields("ApptCustomInfo"))
                    Dim dsAll As DataSet = HttpContext.Current.Session("AppointmentDataSource")
                    Dim dt As DataTable = dsAll.Tables(0)

                    Dim selRecord As Integer = schdMechanics.SelectedAppointments(0).Id
                    'to get gridview id to update on drag
                    Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                    .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                    .Id = schdata.Field(Of Integer)("APPOINTMENT_ID")
                    }).Where(Function(customer) customer.Id = selRecord)

                    Dim selGridViewId As Integer = gdata(0).gvId

                    Dim objAppDO As New AppointmentDO
                    Dim strResult As String = ""
                    strResult = objAppDO.ProcessOrders(appointmentId, selGridViewId, WO_NO, WO_STATUS, WO_PREFIX)

                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub resourceTreeListDataSource_ObjectCreated(sender As Object, e As ObjectDataSourceEventArgs)
        Session("CustomTreeListResourceDataSource") = New CustomTreeListResourceDataSource(GetCustomTreeListResources())
        ' End If
        e.ObjectInstance = Session("CustomTreeListResourceDataSource")
    End Sub
    Private Function GetCustomTreeListResources() As BindingList(Of CustomResource)
        Dim resources As New BindingList(Of CustomResource)()
        Dim objAppDO As New AppointmentDO
        Dim ds As DataSet = objAppDO.FetchTreeListMechanicDetails()
        'Newly Added
        For Each MyDataRow In ds.Tables(1).Rows
            If (MyDataRow("MEC_GROUP_NAME") <> "Regular") Then
                resources.Add(CreateCustomResourceH(-1, MyDataRow("MEC_GROUP_NAME")))
            End If

        Next
        'resources.Add(CreateCustomResourceH(-1, "Painter"))
        'resources.Add(CreateCustomResourceH(-1, "Service"))
        'resources.Add(CreateCustomResourceH(-1, "Technician"))
        'Newly Added
        For Each MyDataRow In ds.Tables(0).Rows
            resources.Add(CreateCustomResource(MyDataRow))
        Next
        Return resources
    End Function
    Protected Sub cbAllAptGrid_Callback(sender As Object, e As CallbackEventArgsBase)
        Dim objAppDO As New AppointmentDO
        Dim params As String = e.Parameter
        Dim param As String() = params.Split(";")
        Dim selDate As DateTime
        Dim isHistory As Boolean
        Dim dsApt As DataSet
        cbAllAptGrid.JSProperties("cpIsExtNewOpen") = False
        cbAllAptGrid.JSProperties("cpExtApptId") = 0
        cbAllAptGrid.JSProperties("cpDelRetVal") = ""
        Try
            If param.Count > 0 Then
                If param(0) = "FETCH" Then
                    selDate = dateSelector.Date
                    isHistory = chkhistoryApt.Checked
                    dsApt = objAppDO.FetchAllAppointments(loginName, selDate, isHistory)
                    Session("dsAllApt") = dsApt
                    gvAllAppointments.DataSource = dsApt
                    gvAllAppointments.DataBind()
                ElseIf param(0) = "OpenAptOrder" Then
                    If param.Count > 1 Then
                        Dim index As Integer = CInt(param(1))
                        Dim values As Object() = TryCast(gvAllAppointments.GetRowValues(index, New String() {"ID_WO_PREFIX", "ID_WO_NO"}), Object())
                        Dim woNum As String = values(1)
                        Dim woPr As String = values(0)
                        Dim strPath As String = "~/Transactions/frmWOJobDetails.aspx?Wonumber=" + woNum + "&WOPrefix=" + woPr + "&Mode=Edit&TabId=2&Flag=Ser&blWOsearch=true"
                        ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute(strPath))
                    End If
                ElseIf param(0) = "OpenApt" Then
                    cbAllAptGrid.JSProperties("cpIsExtNewOpen") = True
                    cbAllAptGrid.JSProperties("cpExtApptId") = CInt(param(1))
                    HttpContext.Current.Session("isExtOpenApt") = "yes"
                ElseIf param(0) = "DeleteAptExt" Then
                    Dim dsAllApt As DataSet = HttpContext.Current.Session("AllScheduler")
                    Dim dtAllApt As DataTable = dsAllApt.Tables(0)
                    Dim selRecord As Integer = CInt(param(1))
                    Dim retVal As String
                    Dim gdata = dtAllApt.AsEnumerable().Select(Function(schdata) New With {
                        .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                        .Id = schdata.Field(Of Integer)("APPOINTMENT_ID"),
                        .AptId = schdata.Field(Of Integer)("ID_APT_HDR")
                        }).Where(Function(customer) customer.Id = selRecord)

                    If gdata.Count > 0 Then
                        Dim selGridViewId As Integer = gdata(0).gvId
                        Dim appointmentntmentId As Integer = gdata(0).AptId
                        retVal = objAppDO.DeleteAppointmentDetExt(selGridViewId, appointmentntmentId, loginName)
                        cbAllAptGrid.JSProperties("cpDelRetVal") = retVal
                    End If

                    'ReBind the grid after the delete
                    selDate = dateSelector.Date
                    isHistory = chkhistoryApt.Checked
                    dsApt = objAppDO.FetchAllAppointments(loginName, selDate, isHistory)
                    Session("dsAllApt") = dsApt
                    gvAllAppointments.DataSource = dsApt
                    gvAllAppointments.DataBind()

                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "cbAllAptGrid_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub gvAllAppointments_ContextMenuInitialize(sender As Object, e As ASPxGridViewContextMenuInitializeEventArgs)
        Try
            If e.MenuType = GridViewContextMenuType.Rows Then
                e.ContextMenu.Items.Clear()
                e.ContextMenu.Items.Add("Open Appointment", "OpenApt").Image.IconID = "actions_right_16x16"
                e.ContextMenu.Items.Add("Open Order", "OpenAptOrder")
                e.ContextMenu.Items.Add("Transfer to order", "TransferAptOrder")
                e.ContextMenu.Items.Add("Delete", "DeleteAptExt").Image.IconID = "actions_cancel_16x16office2013"
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmDayPlan", "gvAllAppointments_ContextMenuInitialize", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub
End Class
Public Class CustomTimeInterval
    Private privateStartTime As Integer
    Public Property StartTime() As Integer
        Get
            Return privateStartTime
        End Get
        Set(ByVal value As Integer)
            privateStartTime = value
        End Set
    End Property
    Private privateEndTime As Integer
    Public Property EndTime() As Integer
        Get
            Return privateEndTime
        End Get
        Set(ByVal value As Integer)
            privateEndTime = value
        End Set
    End Property
    Private privateDayOfWeek As Integer
    Public Property DayOfWeek() As Integer
        Get
            Return privateDayOfWeek
        End Get
        Set(ByVal value As Integer)
            privateDayOfWeek = value
        End Set
    End Property
    Private lunchStart As Integer
    Public Property LunchStartTime() As Integer
        Get
            Return lunchStart
        End Get
        Set(ByVal value As Integer)
            lunchStart = value
        End Set
    End Property
    Private lunchEnd As Integer
    Public Property LunchEndTime() As Integer
        Get
            Return lunchEnd
        End Get
        Set(ByVal value As Integer)
            lunchEnd = value
        End Set
    End Property


End Class
Public Class HolidayTimeInterval
    Private holidayDate As DateTime
    Public Property MechHolidayDate() As DateTime
        Get
            Return holidayDate
        End Get
        Set(ByVal value As DateTime)
            holidayDate = value
        End Set
    End Property
    Private holidayMechId As String
    Public Property MechId() As String
        Get
            Return holidayMechId
        End Get
        Set(ByVal value As String)
            holidayMechId = value
        End Set
    End Property
    Private holidayReason As String
    Public Property MechLeaveReason() As String
        Get
            Return holidayReason
        End Get
        Set(ByVal value As String)
            holidayReason = value
        End Set
    End Property
    Private holidayToDate As DateTime
    Public Property MechHolidayToDate() As DateTime
        Get
            Return holidayToDate
        End Get
        Set(ByVal value As DateTime)
            holidayToDate = value
        End Set
    End Property
    Private holidayFromTime As Integer
    Public Property MechHolidayFromTime() As Integer
        Get
            Return holidayFromTime
        End Get
        Set(ByVal value As Integer)
            holidayFromTime = value
        End Set
    End Property
    Private holidayToTime As Integer
    Public Property MechHolidayToTime() As Integer
        Get
            Return holidayToTime
        End Get
        Set(ByVal value As Integer)
            holidayToTime = value
        End Set
    End Property

End Class



