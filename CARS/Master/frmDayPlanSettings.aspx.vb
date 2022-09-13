Imports Encryption
Imports MSGCOMMON
Imports System.Web.Services
Imports CARS.CoreLibrary.CARS
Imports CARS.CoreLibrary
Imports DevExpress.Web
Imports System.Globalization
Imports System.Threading

Public Class frmDayPlanSettings
    Inherits System.Web.UI.Page

    Shared dtDPDetails As New DataTable()
    Shared dsDPDetails As New DataSet
    Shared objDPSettBO As New DayPlanSettingsBO
    Shared objDPSettDO As New DayPlanSettings.DayPlanSettingsDO
    Shared objDPSettServ As New Services.ConfigDayPlanSettings.DayPlanSettings
    Shared loginName As String
    Shared commonUtil As New Utilities.CommonUtility
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared details As New List(Of DayPlanSettingsBO)()
    Shared appointmentStartTime As String
    Shared appointmentStopTime As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                loginName = CType(Session("UserID"), String)
            End If
            EnableViewState = False
            gvOrderStatus.JSProperties("cpdelexists") = ""
            'gvOrderStatus.EnableViewState = False
            FetchAllOrderStatus()


        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Private Sub FetchAllOrderStatus()
        Try
            dsDPDetails = objDPSettServ.LoadWOOrderStatus()
            If (dsDPDetails.Tables.Count > 0) Then
                gvOrderStatus.DataSource = dsDPDetails.Tables(0)
                gvOrderStatus.DataBind()

                gvApptStatus.DataSource = dsDPDetails.Tables(2)
                gvApptStatus.DataBind()

                dtDPDetails = dsDPDetails.Tables(1)

                If dtDPDetails.Rows.Count > 0 Then

                    txtHistoryLimit.Text = dtDPDetails.Rows(0)("HISTORY_LIMIT").ToString()
                    txtLastAppmntNum.Text = dtDPDetails.Rows(0)("LAST_APPOINTMENT_NUMBER").ToString()
                    cbShwSatSund.Checked = Convert.ToBoolean(dtDPDetails.Rows(0)("DISPLAY_SATSUN").ToString())
                    ddlMinAppmtTime.SelectedValue = dtDPDetails.Rows(0)("MINIMUM_APPOINTMENT_TIME").ToString()
                    hdnIdAppmntConfigSettings.Value = dtDPDetails.Rows(0)("ID_CONFIG_APPOINTMENT").ToString()

                    appointmentStartTime = dtDPDetails.Rows(0)("APPOINTMENT_START_TIME_HOUR").ToString() + ":" + dtDPDetails.Rows(0)("APPOINTMENT_START_TIME_MINUTES").ToString()
                    appointmentStopTime = dtDPDetails.Rows(0)("APPOINTMENT_STOP_TIME_HOUR").ToString() + ":" + dtDPDetails.Rows(0)("APPOINTMENT_STOP_TIME_MINUTES").ToString()

                    appointmentStartTime = Date.Now().Date + " " + appointmentStartTime
                    appointmentStopTime = Date.Now().Date + " " + appointmentStopTime

                    txtAppmntStartTime.DateTime = appointmentStartTime
                    txtAppmntStopTime.DateTime = appointmentStopTime
                    ddlMechanicPerPage.SelectedValue = dtDPDetails.Rows(0)("MECHANIC_PER_PAGE").ToString()
                    rbByStandard.Checked = dtDPDetails.Rows(0)("CTRL_BY_STANDARD")
                    rbByStatus.Checked = dtDPDetails.Rows(0)("CTRL_BY_STATUS")
                    rbByMechanic.Checked = dtDPDetails.Rows(0)("CTRL_BY_MECHANIC")
                    cbShowOnHold.Checked = Convert.ToBoolean(dtDPDetails.Rows(0)("SHOW_ONHOLD_ON_LOAD").ToString())

                End If

            End If


        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "FetchAllOrderStatus", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub

    Protected Sub gvOrderStatus_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Dim strResult As String = ""
        gvOrderStatus.JSProperties("cpdelexists") = ""
        For Each item In e.InsertValues

            Try
                objDPSettBO = New DayPlanSettingsBO()
                objDPSettBO.OrderStatusCode = item.NewValues(2)
                objDPSettBO.OrderStatusDesc = item.NewValues(0)
                objDPSettBO.OrderStatusColor = item.NewValues(1)
                objDPSettBO.Mode = "I"
                objDPSettServ.SaveOrderStatus(objDPSettBO)


            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvOrderStatus_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next

        For Each item In e.UpdateValues
            Try
                objDPSettBO = New DayPlanSettingsBO()
                objDPSettBO.OrderStatusCode = item.NewValues(2)
                objDPSettBO.OrderStatusDesc = item.NewValues(0)
                objDPSettBO.OrderStatusColor = item.NewValues(1)
                objDPSettBO.IdOrderStatus = item.Keys.Values(0)
                objDPSettBO.Mode = "U"
                Dim res As String = objDPSettServ.SaveOrderStatus(objDPSettBO)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvOrderStatus_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        For Each item In e.DeleteValues
            Try
                objDPSettBO = New DayPlanSettingsBO()
                objDPSettBO.IdOrderStatus = item.Keys.Values(0)
                objDPSettBO.OrderStatusCode = item.Values(1)
                objDPSettBO.OrderStatusDesc = item.Values(2)
                objDPSettBO.OrderStatusColor = item.Values(3)

                objDPSettBO.Mode = "D"
                strResult = objDPSettServ.SaveOrderStatus(objDPSettBO)

                If (strResult = "STATUS_USED") Then
                    gvOrderStatus.JSProperties("cpdelexists") = "EXISTS"
                End If

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvOrderStatus_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        e.Handled = True
        FetchAllOrderStatus()

    End Sub

    <WebMethod()>
    Public Shared Function SaveAppmntConfigSettings(ByVal appmntStartTime As String, ByVal appmntStopTime As String, ByVal lastAppmntNum As String, ByVal historyLimit As String, ByVal minAppmntTime As String, ByVal dispShwSatSund As String, ByVal mechanicPerPage As String, ByVal idAppmntConfigSettings As String, ByVal ctrlByStatus As String, ByVal ctrlByStandard As String, ByVal ctrlByMechanic As String, ByVal showOnHoldOnPageLoad As String) As String()
        Dim strRes As String()
        Try
            Dim objItemsBO As New DayPlanSettingsBO

            Dim startTime As String()
            Dim stopTime As String()

            If (appmntStartTime.Contains(".")) Then
                startTime = appmntStartTime.Split(".")
                stopTime = appmntStopTime.Split(".")
            ElseIf (appmntStartTime.Contains(":")) Then
                startTime = appmntStartTime.Split(":")
                stopTime = appmntStopTime.Split(":")
            End If


            objItemsBO.IdConfigAppmnt = IIf(idAppmntConfigSettings = "", "0", idAppmntConfigSettings)
            objItemsBO.LastAppmntNum = lastAppmntNum
            objItemsBO.MinAppmntTime = minAppmntTime

            If (startTime.Length > 1) Then

                objItemsBO.AppmntStartTimeHr = startTime(0).ToString()
                objItemsBO.AppmntStartTimeMin = startTime(1).ToString()

                objItemsBO.AppmntStopTimeHr = stopTime(0).ToString()
                objItemsBO.AppmntStopTimeMin = stopTime(1).ToString()
            End If


            objItemsBO.HistoryLimit = historyLimit
            objItemsBO.DispShwSatSund = dispShwSatSund
            objItemsBO.MechanicPerPage = mechanicPerPage
            objItemsBO.ControlledByStandard = Convert.ToBoolean(ctrlByStandard)
            objItemsBO.ControlledByStatus = Convert.ToBoolean(ctrlByStatus)
            objItemsBO.ControlledByMechanic = Convert.ToBoolean(ctrlByMechanic)
            objItemsBO.ShowOnHoldOnLoad = Convert.ToBoolean(showOnHoldOnPageLoad)
            strRes = objDPSettServ.Save_AppmntConfigSettings(objItemsBO)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "SaveAppmntConfigSettings", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRes
    End Function

    Protected Sub gvOrderStatus_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)
        Try
            If (e.IsNewRow = True) Then

                Dim dtOrdStat As DataTable = gvOrderStatus.DataSource

                If (dtOrdStat.Rows.Count > 0) Then
                    For Each dRow As DataRow In dtOrdStat.Rows
                        If e.NewValues("ORDER_STATUS_CODE") IsNot Nothing Then
                            If e.NewValues("ORDER_STATUS_CODE").ToString().ToLower() = dRow("ORDER_STATUS_CODE").ToString().ToLower() Then
                                e.RowError = "Order Status already exists."
                            End If
                        End If
                    Next
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvOrderStatus_RowValidating", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try

    End Sub

    Protected Sub gvApptStatus_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs)
        For Each item In e.InsertValues

            Try
                objDPSettBO = New DayPlanSettingsBO()
                objDPSettBO.AppointmentStatusCode = item.NewValues("APPOINTMENT_STATUS_CODE")
                objDPSettBO.AppointmentStatusColor = item.NewValues("APPOINTMENT_STATUS_COLOR")
                objDPSettBO.Mode = "I"
                objDPSettServ.SaveAppointmentStatus(objDPSettBO)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvApptStatus_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        For Each item In e.UpdateValues

            Try
                objDPSettBO = New DayPlanSettingsBO()
                objDPSettBO.AppointmentStatusCode = item.NewValues("APPOINTMENT_STATUS_CODE")
                objDPSettBO.AppointmentStatusColor = item.NewValues("APPOINTMENT_STATUS_COLOR")
                objDPSettBO.IdAppointmentStatus = item.Keys(0)
                objDPSettBO.Mode = "U"
                objDPSettServ.SaveAppointmentStatus(objDPSettBO)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvApptStatus_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        For Each item In e.DeleteValues

            Try
                objDPSettBO = New DayPlanSettingsBO()
                objDPSettBO.IdAppointmentStatus = item.Keys(0)
                objDPSettBO.Mode = "D"
                objDPSettServ.SaveAppointmentStatus(objDPSettBO)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvApptStatus_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
        Next
        e.Handled = True
        FetchAllOrderStatus()
    End Sub

    Protected Sub gvApptStatus_RowValidating(sender As Object, e As Data.ASPxDataValidationEventArgs)
        Try
            If (e.IsNewRow = True) Then

                Dim dtAptStat As DataTable = gvApptStatus.DataSource

                If (dtAptStat.Rows.Count > 0) Then
                    For Each dRow As DataRow In dtAptStat.Rows
                        If e.NewValues("APPOINTMENT_STATUS_CODE") IsNot Nothing Then
                            If e.NewValues("APPOINTMENT_STATUS_CODE").ToString().ToLower() = dRow("APPOINTMENT_STATUS_CODE").ToString().ToLower() Then
                                e.RowError = "Appointment Status already exists."
                            End If
                        End If
                    Next
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmDayPlanSettings", "gvApptStatus_RowValidating", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci
        End If
    End Sub
End Class