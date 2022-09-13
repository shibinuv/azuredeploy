Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Data.SqlClient
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CustomEventsData
Imports DevExpress.Utils
Imports DevExpress.Web
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Internal
Imports DevExpress.Web.ASPxScheduler.Localization
Imports DevExpress.XtraScheduler
Imports DevExpress.XtraScheduler.Localization
Imports DevExpress.XtraScheduler.Tools
Imports DevExpress.Web.ASPxScheduler.Controls
Imports CARS.CoreLibrary.CARS.DayPlanSettings

Partial Public Class AppointmentForm
    Inherits SchedulerFormControl
    'Inherits System.Web.UI.UserControl
    Dim myApointmentId As Integer = 0
    Shared objAppDO As New AppointmentDO
    Dim LoginName As String = ""
    Dim currentDate As New DateTime
    Dim currentMec As String
    Private dsApptSetting As DataSet = New DataSet
    Private objDayPlanSettingsDO As New DayPlanSettingsDO
    Private dtApptSetting As New DataTable
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
                Response.Redirect("~/frmLogin.aspx")
            Else
                LoginName = CType(Session("UserID"), String)
            End If
            Dim ds As New DataSet
            ds = objAppDO.FetchVehicleList()
            Session("VehicleList") = ds.Tables(6)
            cbMake.DataSource = Session("VehicleList")
            'cbMake.It
            cbMake.ValueField = "ID_MAKE_VEH"
            cbMake.TextField = "MAKE"
            cbMake.DataBind()
            dsApptSetting = objDayPlanSettingsDO.FetchAllOrderStatuses()
            If (dsApptSetting.Tables.Count > 0) Then
                dtApptSetting = dsApptSetting.Tables(1)
                If dtApptSetting.Rows.Count > 0 Then
                    gvAppointmentDetails.JSProperties("cpIsCtrlByStatus") = dtApptSetting.Rows(0)("CTRL_BY_STATUS")
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "AppointmentForm", "Page_Load", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
        End Try
    End Sub
    Public Overrides ReadOnly Property ClassName() As String
        Get
            Return "ASPxAppointmentForm"
        End Get
    End Property
    Public ReadOnly Property ResourceDataSource() As IEnumerable
        Get
            Return CType(Parent, AppointmentFormTemplateContainer).ResourceDataSource
        End Get
    End Property
    Public Function FetchGridViewData(AppointmentId As Integer) As DataSet
        Dim ds As DataSet = objAppDO.FetchAppointmentDetails(AppointmentId)
        Return ds
    End Function

    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)
        Localize()
    End Sub

    Private Sub Localize()
        btnOk.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonOk)
        btnCancel.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonCancel)
        btnDelete.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonDelete)
        btnOk.Wrap = DefaultBoolean.False
        btnCancel.Wrap = DefaultBoolean.False
        btnDelete.Wrap = DefaultBoolean.False
    End Sub
    Public Overrides Sub DataBind()
        MyBase.DataBind()
        Try
            Dim container As AppointmentFormTemplateContainer = CType(Parent, AppointmentFormTemplateContainer)
            Dim apt As Appointment = container.Appointment
            Dim appointmentStorage As IAppointmentStorageBase = container.Control.Storage.Appointments
            Dim label As IAppointmentLabel = appointmentStorage.Labels.GetById(apt.LabelKey)
            Dim status As IAppointmentStatus = appointmentStorage.Statuses.GetById(apt.StatusKey)

            edtLabel.ValueType = apt.LabelKey.GetType()
            edtLabel.SelectedIndex = appointmentStorage.Labels.IndexOf(label)
            edtStatus.ValueType = apt.StatusKey.GetType()
            edtStatus.SelectedIndex = appointmentStorage.Statuses.IndexOf(status)

            PopulateResourceEditors(apt, container)
            If (apt.ResourceId.GetType() <> EmptyResourceId.Id.GetType) Then
                edtResource.ValueField = apt.ResourceId.ToString()
            End If
            'BindSubjectCombobox()

            'cbSubject.Value = container.Subject
            tbSubject.Text = container.Subject.ToString()

            cbxFirma.Checked = If(container.Appointment.CustomFields("ApptCustomerFirm") IsNot Nothing, container.Appointment.CustomFields("ApptCustomerFirm"), False)
            tbCustomerNo.Text = If(container.Appointment.CustomFields("ApptCustomerNumber") IsNot Nothing, container.Appointment.CustomFields("ApptCustomerNumber").ToString(), "")
            tbFirstName.Text = If(container.Appointment.CustomFields("ApptFirstName") IsNot Nothing, container.Appointment.CustomFields("ApptFirstName").ToString(), "")
            'txtTesting.Text = If(container.Appointment.CustomFields("ApptTestInfo") IsNot Nothing, container.Appointment.CustomFields("ApptTestInfo").ToString(), "") 'container.Appointment.CustomFields("ApptTestInfo").ToString()
            tbMiddleName.Text = If(container.Appointment.CustomFields("ApptMiddleName") IsNot Nothing, container.Appointment.CustomFields("ApptMiddleName").ToString(), "")
            tbLastName.Text = If(container.Appointment.CustomFields("ApptLastName") IsNot Nothing, container.Appointment.CustomFields("ApptLastName").ToString(), "")
            tbRefNo.Text = If(container.Appointment.CustomFields("ApptVehicleRefNo") IsNot Nothing, container.Appointment.CustomFields("ApptVehicleRefNo").ToString(), "")
            tbRegNo.Text = If(container.Appointment.CustomFields("ApptVehicleRegNo") IsNot Nothing, container.Appointment.CustomFields("ApptVehicleRegNo").ToString(), "")
            tbChNo.Text = If(container.Appointment.CustomFields("ApptVehicleChNo") IsNot Nothing, container.Appointment.CustomFields("ApptVehicleChNo").ToString(), "")
            txtSrchVeh.Text = If(container.Appointment.CustomFields("ApptCustomVehicleNo") IsNot Nothing, container.Appointment.CustomFields("ApptCustomVehicleNo").ToString(), "")
            cbxPerCheck.Checked = If(container.Appointment.CustomFields("ApptVehiclePerCheck") IsNot Nothing, container.Appointment.CustomFields("ApptVehiclePerCheck"), False)
            cbxRentalCar.Checked = If(container.Appointment.CustomFields("ApptVehicleRentalCar") IsNot Nothing, container.Appointment.CustomFields("ApptVehicleRentalCar"), False)
            cbxPerService.Checked = If(container.Appointment.CustomFields("ApptVehiclePerService") IsNot Nothing, container.Appointment.CustomFields("ApptVehiclePerService"), False)

            cbMake.DataSource = Session("VehicleList")
            txtbxModel.Text = If(container.Appointment.CustomFields("ApptVehicleModel") IsNot Nothing, container.Appointment.CustomFields("ApptVehicleModel"), "")

            If (container.Appointment.CustomFields("ApptVehicleMake") IsNot Nothing) Then
                cbMake.Value = If(container.Appointment.CustomFields("ApptVehicleMake") IsNot Nothing, container.Appointment.CustomFields("ApptVehicleMake").ToString(), 0)
            End If

            tbCustomInfo.Text = If(container.Appointment.CustomFields("ApptCustomInfo") IsNot Nothing, container.Appointment.CustomFields("ApptCustomInfo").ToString(), "")

            BindListBox(apt.Start, apt.ResourceId.ToString())
            currentMec = apt.ResourceId.ToString()
            currentDate = apt.Start
            If (currentMec <> "DevExpress.XtraScheduler.EmptyResourceId") Then
                lblLeaveDetails.Text = GetMechName(currentMec)
                lblSelectedDate.Text = currentDate.ToString().Substring(0, 10)
            End If


            'btnOk.ClientSideEvents.Click = container.SaveHandler;
            btnCancel.ClientSideEvents.Click = container.CancelHandler
            btnDelete.ClientSideEvents.Click = container.DeleteHandler
            JSProperties.Add("cpHasExceptions", apt.HasExceptions)
            If (apt.CustomFields("ApptWONONumInfo") = "0" Or apt.CustomFields("ApptWONONumInfo") Is Nothing) Then
                EnableControls()
            Else
                DisableControls()
            End If

            myApointmentId = container.Appointment.CustomFields.Item("ApptCustomInfo")

            If ((HttpContext.Current.Session("isEditing") Is Nothing) Or (HttpContext.Current.Session("isEditing") = "no")) Then
                gvAppointmentDetails.DataSource = FetchGridViewData(myApointmentId)
                CType(gvAppointmentDetails.Columns("RESOURCE_ID"), GridViewDataComboBoxColumn).PropertiesComboBox.DataSource = Session("Test")
                gvAppointmentDetails.DataBind()
            End If

            If HttpContext.Current.Session("isExtOpenApt") IsNot Nothing Then
                If HttpContext.Current.Session("isExtOpenApt") = "yes" Then
                    gvAppointmentDetails.DataSource = FetchGridViewData(myApointmentId)
                    CType(gvAppointmentDetails.Columns("RESOURCE_ID"), GridViewDataComboBoxColumn).PropertiesComboBox.DataSource = Session("Test")
                    gvAppointmentDetails.DataBind()
                End If
            End If
            If myApointmentId > 0 Then
                Session("Edit") = "yes"
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "AppointmentForm", "DataBind", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
        End Try

    End Sub
    Private Function GetMechName(currentMec As String) As String
        Dim selResourceName As String = ""
        Try
            Dim dsAll As DataSet = HttpContext.Current.Session("Test")
            Dim dt As DataTable = dsAll.Tables(0)

            'to get gridview id to update on drag
            'combo.ValueField = "ResourceID"
            'combo.TextField = "ResourceName"
            Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                .resName = schdata.Field(Of String)("ResourceName"),
                .resId = schdata.Field(Of String)("ResourceID")
                }).Where(Function(Mechanic) Mechanic.resId = currentMec)

            selResourceName = gdata(0).resName

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "AppointmentForm", "GetMechName", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
        End Try
        Return selResourceName
    End Function
    Public Sub DisableControls()
        cbxFirma.Enabled = False
        tbCustomerNo.Enabled = False
        tbFirstName.Enabled = False
        tbMiddleName.Enabled = False
        tbLastName.Enabled = False
        tbRefNo.Enabled = False
        tbRegNo.Enabled = False
        tbChNo.Enabled = False
        txtSrchVeh.Enabled = False
        cbxPerCheck.Enabled = False
        cbxRentalCar.Enabled = False
        cbxPerService.Enabled = False
        cbMake.Enabled = False
        txtbxModel.Enabled = False

    End Sub
    Public Sub EnableControls()
        cbxFirma.Enabled = True
        tbCustomerNo.Enabled = True
        tbFirstName.Enabled = True
        tbMiddleName.Enabled = True
        tbLastName.Enabled = True
        tbRefNo.Enabled = True
        tbRegNo.Enabled = True
        tbChNo.Enabled = True
        txtSrchVeh.Enabled = True
        cbxPerCheck.Enabled = True
        cbxRentalCar.Enabled = True
        cbxPerService.Enabled = True
        cbMake.Enabled = True
        txtbxModel.Enabled = True

    End Sub
    Public Sub BindListBox(start As Date, idLogin As String)
        lbLeaveDetails.DataSource = objAppDO.FetchLeaveDetails(start, idLogin)
        lbLeaveDetails.DataBind()
    End Sub
    Private Sub BindSubjectCombobox()
        Dim subjectList As New List(Of String)()
        subjectList.Add("Car Wash")
        subjectList.Add("Engine Oil Change")
        subjectList.Add("Engine Tuning")
        subjectList.Add("Greasing Components")
        cbSubject.DataSource = subjectList
        cbSubject.DataBind()
    End Sub
    Public ReadOnly Property ResourceSharing() As Boolean
        Get
            Return CType(Parent, AppointmentFormTemplateContainer).Control.Storage.ResourceSharing
        End Get
    End Property
    Private Sub PopulateResourceEditors(ByVal apt As Appointment, ByVal container As AppointmentFormTemplateContainer)
        Try
            If ResourceSharing Then
                Dim edtMultiResource As ASPxListBox = TryCast(ddResource.FindControl("edtMultiResource"), ASPxListBox)
                If edtMultiResource Is Nothing Then
                    Return
                End If
                SetListBoxSelectedValues(edtMultiResource, apt.ResourceIds)
                Dim multiResourceString As List(Of String) = GetListBoxSelectedItemsText(edtMultiResource)
                Dim stringResourceNone As String = SchedulerLocalizer.GetString(SchedulerStringId.Caption_ResourceNone)
                ddResource.Value = stringResourceNone

                If multiResourceString.Count > 0 Then
                    ddResource.Value = String.Join(", ", multiResourceString.ToArray())
                End If
                ddResource.JSProperties.Add("cp_Caption_ResourceNone", stringResourceNone)

            Else
                If Not Object.Equals(apt.ResourceId, EmptyResourceId.Id) Then
                    edtResource.Value = apt.ResourceId.ToString()
                Else
                    edtResource.Value = SchedulerIdHelper.EmptyResourceId
                End If
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "AppointmentForm", "PopulateResourceEditors", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
        End Try

    End Sub
    Private Function GetListBoxSelectedItemsText(ByVal listBox As ASPxListBox) As List(Of String)
        Dim result As New List(Of String)()
        For Each editItem As ListEditItem In listBox.Items
            If editItem.Selected Then
                result.Add(editItem.Text)
            End If
        Next editItem
        Return result
    End Function
    Private Sub SetListBoxSelectedValues(ByVal listBox As ASPxListBox, ByVal values As IEnumerable)
        listBox.Value = Nothing
        For Each value As Object In values
            Dim item As ListEditItem = listBox.Items.FindByValue(value.ToString())
            If item IsNot Nothing Then
                item.Selected = True
            End If
        Next value
    End Sub
    Protected Overrides Sub PrepareChildControls()
        Dim container As AppointmentFormTemplateContainer = CType(Parent, AppointmentFormTemplateContainer)
        Dim control As ASPxScheduler = container.Control

        AppointmentRecurrenceForm1.EditorsInfo = New EditorsInfo(control, control.Styles.FormEditors, control.Images.FormEditors, control.Styles.Buttons)
        MyBase.PrepareChildControls()
    End Sub
    Protected Overrides Function GetChildEditors() As ASPxEditBase()
        Dim edits() As ASPxEditBase = {lblSubject, cbSubject, tbSubject, lblLabel, edtLabel, lblStartDate, edtStartDate, lblEndDate, edtEndDate, lblStatus, edtStatus, tbDescription, edtStartTime, edtEndTime, GetMultiResourceEditor()}
        Return edits
    End Function
    Protected Overrides Function GetChildButtons() As ASPxButton()
        Dim buttons() As ASPxButton = {btnOk, btnCancel, btnDelete}
        Return buttons
    End Function
    Protected Overrides Function GetChildControls() As Control()
        Return New Control() {ValidationContainer, AppointmentRecurrenceForm1}
    End Function
    Private Function GetMultiResourceEditor() As ASPxEditBase
        If ddResource IsNot Nothing Then
            Return TryCast(ddResource.FindControl("edtMultiResource"), ASPxEditBase)
        End If
        Return Nothing
    End Function
    Protected Overrides Function GetDefaultButton() As WebControl
        Return btnOk
    End Function
    Protected Sub gvAppointmentDetails_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        If (tbCustomInfo.Text = "") Then
            Dim customEvent As New CustomEvent
            customEvent.OwnerId = ddResource.Value
            customEvent.StartTime = edtStartTime.DateTime
            customEvent.EndTime = edtEndTime.DateTime
            customEvent.EventType = 0
            customEvent.AllDay = 0
            'customEvent.Subject = cbSubject.Value
            customEvent.Subject = tbSubject.Text
            customEvent.Label = edtLabel.Value
            customEvent.Description = tbDescription.Text
            customEvent.Status = edtStatus.Value
            customEvent.CustomFirstName = tbFirstName.Text
            customEvent.CustomMiddleName = tbMiddleName.Text
            customEvent.CustomLastName = tbLastName.Text
            customEvent.CustomCustomerFirm = cbxFirma.Checked
            customEvent.CustomCustomerNumber = tbCustomerNo.Text
            customEvent.CustomVehicleChNo = tbChNo.Text
            customEvent.CustomVehicleRefNo = tbRefNo.Text
            customEvent.CustomVehicleRegNo = tbRegNo.Text
            customEvent.CustomVehicleId = Convert.ToInt32(txtSrchVeh.Text)
            customEvent.CustomVehicleRentalCar = cbxRentalCar.Checked
            customEvent.CustomVehiclePerCheck = cbxPerCheck.Checked
            customEvent.CustomVehiclePerService = cbxPerService.Checked
            customEvent.CustomVehicleMake = cbMake.Value
            customEvent.CustomVehicleModel = txtbxModel.Text

            Dim ceds As New CustomEventDataSource
            myApointmentId = ceds.InsertValues(customEvent, LoginName)
            'tbCustomInfo.Value = myApointmentId.ToString()

        Else
            myApointmentId = tbCustomInfo.Text
        End If

        gvAppointmentDetails.JSProperties("cpAptValue") = myApointmentId.ToString()

        For Each item In e.InsertValues
            Try
                'AppointmentId = item.NewValues("AppointmentId")
                Dim dateTimeFrom As Date = item.NewValues("START_TIME")
                dateTimeFrom = CDate(item.NewValues("START_DATE").ToString().Substring(0, 10) & " " & FormatDateTime(dateTimeFrom, DateFormat.ShortTime))

                Dim dateTimeTo As Date = item.NewValues("END_TIME")
                dateTimeTo = CDate(item.NewValues("END_DATE").ToString().Substring(0, 10) & " " & FormatDateTime(dateTimeTo, DateFormat.ShortTime))
                edtStatus.SelectedIndex = 0
                Dim overTime As Boolean = hdnOverTime.Get("OverTime")
                objAppDO.ProcessAppointmentDetails("INSERT", 0, item.NewValues("START_DATE"), dateTimeFrom, item.NewValues("END_DATE"), dateTimeTo, item.NewValues("TEXT"), item.NewValues("RESERVATION"), item.NewValues("SEARCH"), myApointmentId, item.NewValues("RESOURCE_ID"), LoginName, item.NewValues("COLOR_CODE"), 0, item.NewValues("TEXT_LINE1"), item.NewValues("TEXT_LINE2"), item.NewValues("TEXT_LINE3"), item.NewValues("TEXT_LINE4"), item.NewValues("TEXT_LINE5"), edtStatus.Value, overTime)
                'Dim abc = hdnRowInsert.Get("RowInsert").ToString()
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "AppointmentForm", "InsertValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
            End Try
        Next
        For Each item In e.UpdateValues
            Try
                'AppointmentId = item.NewValues("AppointmentId")
                Dim dateTimeFrom As Date = item.NewValues("START_TIME")
                dateTimeFrom = CDate(item.NewValues("START_DATE").ToString().Substring(0, 10) & " " & FormatDateTime(dateTimeFrom, DateFormat.ShortTime))

                Dim dateTimeTo As Date = item.NewValues("END_TIME")
                dateTimeTo = CDate(item.NewValues("END_DATE").ToString().Substring(0, 10) & " " & FormatDateTime(dateTimeTo, DateFormat.ShortTime))
                Dim overTime As Boolean = hdnOverTime.Get("OverTime")
                objAppDO.ProcessAppointmentDetails("UPDATE", item.Keys(0), item.NewValues("START_DATE"), dateTimeFrom, item.NewValues("END_DATE"), dateTimeTo, item.NewValues("TEXT"), item.NewValues("RESERVATION"), item.NewValues("SEARCH"), myApointmentId, item.NewValues("RESOURCE_ID"), LoginName, item.NewValues("COLOR_CODE"), 0, item.NewValues("TEXT_LINE1"), item.NewValues("TEXT_LINE2"), item.NewValues("TEXT_LINE3"), item.NewValues("TEXT_LINE4"), item.NewValues("TEXT_LINE5"), edtStatus.Value, overTime)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "AppointmentForm", "UpdateValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
            End Try
        Next
        For Each item In e.DeleteValues
            Try
                'AppointmentId = item.Values("AppointmentId")
                objAppDO.ProcessAppointmentDetails("DELETE", item.Keys(0), Date.Now, Date.Now, Date.Now, Date.Now, "", "", "", myApointmentId, "", LoginName, "", 0, "", "", "", "", "", 1, False)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "AppointmentForm", "DeleteValues", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
            End Try
        Next
        e.Handled = True
        Try
            Dim ds As DataSet = New DataSet()
            ds = FetchGridViewData(myApointmentId)
            gvAppointmentDetails.DataSource = ds
            CType(gvAppointmentDetails.Columns("RESOURCE_ID"), GridViewDataComboBoxColumn).PropertiesComboBox.DataSource = Session("Test")
            gvAppointmentDetails.DataBind()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "AppointmentForm", "gvAppointmentDetails_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
        End Try
    End Sub

    Protected Sub gvAppointmentDetails_CellEditorInitialize(sender As Object, e As ASPxGridViewEditorEventArgs)
        If e.Column.FieldName = "RESOURCE_ID" Then
            Dim combo As ASPxComboBox = TryCast(e.Editor, ASPxComboBox)
            Dim ds As DataSet = objAppDO.FetchMechanicDetails()
            Session("Test") = ds
            combo.ValueField = "ResourceID"
            combo.TextField = "ResourceName"
            combo.ValueType = GetType(String)
            combo.DataSource = Session("Test")
            combo.DataBindItems()
        End If

    End Sub

    Protected Sub gvAppointmentDetails_RowValidating(sender As Object, e As DevExpress.Web.Data.ASPxDataValidationEventArgs)
        Dim id As Int32 = 0
        If (e.IsNewRow Or e.Keys.Count < 1) Then
            id = 0
        Else
            id = e.Keys(0)
        End If
        Dim curAppointmentId As Integer = 0
        If (tbCustomInfo.Text <> "") Then
            curAppointmentId = tbCustomInfo.Text
        Else
            curAppointmentId = myApointmentId
        End If


        If (curAppointmentId > 0) Then

            Dim ds As DataSet = FetchGridViewData(curAppointmentId)
            If (ds IsNot Nothing) Then
                Dim rowCount As Integer = Convert.ToInt32(ds.Tables(0).Rows.Count)
                For i As Integer = 0 To rowCount - 1
                    Dim row As DataRow = ds.Tables(0).Rows(i)
                    Dim currentId As Int32 = row.Item("ID_APPOINTMENT_DETAILS")
                    Dim currentMechanicEntry As String = e.NewValues("RESOURCE_ID")
                    Dim oldmechanicValue As String = row.ItemArray(6)
                    Dim startDateTime As Date = e.NewValues("START_TIME")
                    startDateTime = CDate(e.NewValues("START_DATE").ToString.Substring(0, 10) & " " & FormatDateTime(startDateTime, DateFormat.ShortTime))
                    Dim endDateTime As Date = e.NewValues("END_TIME")
                    endDateTime = CDate(e.NewValues("END_DATE").ToString.Substring(0, 10) & " " & FormatDateTime(endDateTime, DateFormat.ShortTime))
                    If (id <> currentId) Then
                        If (currentMechanicEntry.ToLower() = oldmechanicValue.ToLower()) Then
                            If ((startDateTime = row.ItemArray(1))) Then
                                If (endDateTime = (row.ItemArray(2))) Then
                                    e.RowError = "Cannot add duplicate Appointment For Same Mechanic"
                                End If
                            End If
                        End If
                    End If

                Next
            End If
        End If
    End Sub

    Protected Sub cbMecDetails_Callback(sender As Object, e As CallbackEventArgsBase)
        Try

            If (e.Parameter.Count > 0) Then
                Dim paramText As String = e.Parameter.ToString
                Dim paramTexts() As String = paramText.Split("$")
                If (paramTexts.Count > 1) Then
                    currentDate = paramTexts(0).Trim()
                    currentMec = paramTexts(1).Trim()
                    lblLeaveDetails.Text = paramTexts(2).Trim()
                    lblSelectedDate.Text = currentDate.ToString().Substring(0, 10)
                    BindListBox(currentDate, currentMec)
                End If
            Else
                Dim start As New Date
                If (start = currentDate Or currentMec = "DevExpress.XtraScheduler.EmptyResourceId") Then
                    Dim parameters As String() = Session("MecIdFromDate").Split("$")
                    currentDate = parameters(0).Trim()
                    currentMec = parameters(1).Trim()
                    lblLeaveDetails.Text = currentMec
                    lblSelectedDate.Text = currentDate.ToString().Substring(0, 10)
                End If

                BindListBox(currentDate, currentMec)
                'gvAppointmentDetails.Columns("RESOURCE_ID").
                lblLeaveDetails.Text = GetMechName(currentMec)
                lblSelectedDate.Text = currentDate.ToString().Substring(0, 10)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "AppointmentForm", "cbMecDetails_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, LoginName)
        End Try
    End Sub

    Protected Sub gvAppointmentDetails_PageSizeChanged(sender As Object, e As EventArgs)
        If (tbCustomInfo.Text <> "") Then
            Dim apptId As Integer = tbCustomInfo.Text
            gvAppointmentDetails.JSProperties("cpAptValue") = apptId.ToString()
            gvAppointmentDetails.DataSource = FetchGridViewData(apptId)
            CType(gvAppointmentDetails.Columns("RESOURCE_ID"), GridViewDataComboBoxColumn).PropertiesComboBox.DataSource = Session("Test")
            gvAppointmentDetails.DataBind()
        End If
    End Sub

    Protected Sub gvAppointmentDetails_PageIndexChanged(sender As Object, e As EventArgs)
        If (tbCustomInfo.Text <> "") Then
            Dim apptId As Integer = tbCustomInfo.Text
            gvAppointmentDetails.JSProperties("cpAptValue") = apptId.ToString()
            gvAppointmentDetails.DataSource = FetchGridViewData(apptId)
            CType(gvAppointmentDetails.Columns("RESOURCE_ID"), GridViewDataComboBoxColumn).PropertiesComboBox.DataSource = Session("Test")
            gvAppointmentDetails.DataBind()
        End If
    End Sub

    Protected Sub gvAppointmentDetails_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs)
        If (e.ButtonType = DevExpress.Web.ColumnCommandButtonType.PreviewChanges) Then
            e.Visible = False
        End If

    End Sub

End Class

Public Class CustomAppointmentSaveCallbackCommand
    Inherits AppointmentFormSaveCallbackCommand
    Private Property hdnSaveState As ASPxHiddenField
    Public Sub New(ByVal control As ASPxScheduler)
        MyBase.New(control)
    End Sub

    Protected Friend Shadows ReadOnly Property Controller() As CustomAppointmentFormController
        Get
            Return CType(MyBase.Controller, CustomAppointmentFormController)
        End Get
    End Property

    Protected Overrides Function CreateAppointmentFormController(ByVal apt As DevExpress.XtraScheduler.Appointment) As AppointmentFormController
        Return New CustomAppointmentFormController(Control, apt)
    End Function

    Protected Overrides Function FindControlByID(ByVal id As String) As Control
        Return FindTemplateControl(TemplateContainer, id)
    End Function

    Private Function FindTemplateControl(ByVal RootControl As System.Web.UI.Control, ByVal id As String) As System.Web.UI.Control
        Dim foundedControl As System.Web.UI.Control = RootControl.FindControl(id)
        If foundedControl Is Nothing Then
            For Each item As System.Web.UI.Control In RootControl.Controls
                foundedControl = FindTemplateControl(item, id)
                If foundedControl IsNot Nothing Then
                    Exit For
                End If
            Next item
        End If
        Return foundedControl
    End Function

    Protected Overrides Sub AssignControllerValues()
        MyBase.AssignControllerValues()

        'Dim cbSubject As ASPxComboBox = TryCast(FindControlByID("cbSubject"), ASPxComboBox)
        Dim tbSubject As ASPxTextBox = TryCast(FindControlByID("tbSubject"), ASPxTextBox)
        Dim tbCustomerNo As ASPxTextBox = TryCast(FindControlByID("tbCustomerNo"), ASPxTextBox)
        Dim tbCustomFirstName As ASPxTextBox = TryCast(FindControlByID("tbFirstName"), ASPxTextBox)
        Dim tbCustomMiddleName As ASPxTextBox = TryCast(FindControlByID("tbMiddleName"), ASPxTextBox)
        Dim tbCustomLastName As ASPxTextBox = TryCast(FindControlByID("tbLastName"), ASPxTextBox)
        Dim tbRegNo As ASPxTextBox = TryCast(FindControlByID("tbRegNo"), ASPxTextBox)
        Dim tbRefNo As ASPxTextBox = TryCast(FindControlByID("tbRefNo"), ASPxTextBox)
        Dim tbChNo As ASPxTextBox = TryCast(FindControlByID("tbChNo"), ASPxTextBox)
        'Dim txtTestInfo As ASPxTextBox = TryCast(FindControlByID("txtTesting"), ASPxTextBox)
        Dim tbCustomInfo As ASPxTextBox = TryCast(FindControlByID("tbCustomInfo"), ASPxTextBox)

        Dim txtSrchVeh As TextBox = TryCast(FindControlByID("txtSrchVeh"), TextBox)

        Dim cbxFirma As ASPxCheckBox = TryCast(FindControlByID("cbxFirma"), ASPxCheckBox)

        Dim cbxRentalCar As ASPxCheckBox = TryCast(FindControlByID("cbxRentalCar"), ASPxCheckBox)
        Dim cbxPerService As ASPxCheckBox = TryCast(FindControlByID("cbxPerService"), ASPxCheckBox)
        Dim cbxPerCheck As ASPxCheckBox = TryCast(FindControlByID("cbxPerCheck"), ASPxCheckBox)
        Dim ddlMake As DropDownList = TryCast(FindControlByID("ddlMake"), DropDownList)
        Dim txtbxModel As TextBox = TryCast(FindControlByID("txtbxModel"), TextBox)
        Dim cbMake As ASPxComboBox = TryCast(FindControlByID("cbMake"), ASPxComboBox)

        Controller.Subject = tbSubject.Text
        Controller.CustomerNumberField = tbCustomerNo.Text
        Controller.FirstNameField = tbCustomFirstName.Text
        Controller.MiddleNameField = tbCustomMiddleName.Text
        Controller.LastNameField = tbCustomLastName.Text
        Controller.VehicleRegNoField = tbRegNo.Text
        Controller.VehicleRefNoField = tbRefNo.Text
        Controller.VehicleChNoField = tbChNo.Text
        Controller.CustomerFirmField = cbxFirma.Checked
        If txtSrchVeh.Text = "" Then
            Controller.CustomVehicleNoField = 0
        Else
            Controller.CustomVehicleNoField = Convert.ToInt32(txtSrchVeh.Text)
        End If

        Controller.VehicleRentalCarField = cbxRentalCar.Checked
        Controller.VehiclePerServiceField = cbxPerService.Checked
        Controller.VehiclePerCheckField = cbxPerCheck.Checked
        Controller.VehicleMakeField = IIf(cbMake.Value = Nothing, 0, cbMake.Value)
        Controller.VehicleModelField = txtbxModel.Text
        'Controller.TestInfoField = txtTestInfo.Text
        Controller.CustomInfoField = tbCustomInfo.Text
        hdnSaveState = CType(TemplateContainer.FindControl("hdnSaveState"), ASPxHiddenField)
    End Sub
    Protected Overrides Function CanContinueExecute() As Boolean
        Dim saveAptState As Boolean = hdnSaveState.Get("SaveAptState")
        If saveAptState Then
            HttpContext.Current.Session("aptSavedState") = Controller.EditedAppointmentCopy
            HttpContext.Current.Session("aptUpdateOnOk") = True
            HttpContext.Current.Session("Edit") = "no"
            Return False
        End If
        HttpContext.Current.Session("aptSavedState") = Nothing
        'HttpContext.Current.Session("aptUpdateOnOk") = hdnSaveState.Get("UpdateOnOk")
        Return MyBase.CanContinueExecute()

    End Function
End Class


Public Class CustomAppointmentFormController
    Inherits AppointmentFormController

    Public Sub New(ByVal control As ASPxScheduler, ByVal apt As Appointment)
        MyBase.New(control, apt)
    End Sub

    Public Property CustomerNumberField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptCustomerNumber"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptCustomerNumber") = value
        End Set
    End Property

    Public Property CustomerFirmField() As Boolean
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptCustomerFirm"))
        End Get
        Set(ByVal value As Boolean)
            EditedAppointmentCopy.CustomFields("ApptCustomerFirm") = value
        End Set
    End Property

    Private Property SourceCustomerNumberField() As String
        Get
            Return CStr(SourceAppointment.CustomFields("ApptCustomerNumber"))
        End Get
        Set(ByVal value As String)
            SourceAppointment.CustomFields("ApptCustomerNumber") = value
        End Set
    End Property
    Public Property FirstNameField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptFirstName"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptFirstName") = value
        End Set
    End Property

    Private Property SourceFirstNameField() As String
        Get
            Return CStr(SourceAppointment.CustomFields("ApptFirstName"))
        End Get
        Set(ByVal value As String)
            SourceAppointment.CustomFields("ApptFirstName") = value
        End Set
    End Property
    Public Property MiddleNameField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptMiddleName"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptMiddleName") = value
        End Set
    End Property

    Private Property SourceMiddleNameField() As String
        Get
            Return CStr(SourceAppointment.CustomFields("ApptMiddleName"))
        End Get
        Set(ByVal value As String)
            SourceAppointment.CustomFields("ApptMiddleName") = value
        End Set
    End Property
    Public Property LastNameField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptLastName"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptLastName") = value
        End Set
    End Property
    Private Property SourceLastNameField() As String
        Get
            Return CStr(SourceAppointment.CustomFields("ApptLastName"))
        End Get
        Set(ByVal value As String)
            SourceAppointment.CustomFields("ApptLastName") = value
        End Set
    End Property
    Public Property VehicleRefNoField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehicleRefNo"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptVehicleRefNo") = value
        End Set
    End Property
    Public Property VehicleRegNoField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehicleRegNo"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptVehicleRegNo") = value
        End Set
    End Property
    Public Property VehicleChNoField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehicleChNo"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptVehicleChNo") = value
        End Set
    End Property
    Public Property CustomVehicleNoField() As Integer
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptCustomVehicleNo"))
        End Get
        Set(ByVal value As Integer)
            EditedAppointmentCopy.CustomFields("ApptCustomVehicleNo") = value
        End Set
    End Property

    Public Property VehicleRentalCarField() As Boolean
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehicleRentalCar"))
        End Get
        Set(ByVal value As Boolean)
            EditedAppointmentCopy.CustomFields("ApptVehicleRentalCar") = value
        End Set
    End Property
    Public Property VehiclePerServiceField() As Boolean
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehiclePerService"))
        End Get
        Set(ByVal value As Boolean)
            EditedAppointmentCopy.CustomFields("ApptVehiclePerService") = value
        End Set
    End Property
    Public Property VehiclePerCheckField() As Boolean
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehiclePerCheck"))
        End Get
        Set(ByVal value As Boolean)
            EditedAppointmentCopy.CustomFields("ApptVehiclePerCheck") = value
        End Set
    End Property
    Public Property VehicleMakeField() As Integer
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehicleMake"))
        End Get
        Set(ByVal value As Integer)
            EditedAppointmentCopy.CustomFields("ApptVehicleMake") = value
        End Set
    End Property

    Public Property VehicleModelField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptVehicleModel"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptVehicleModel") = value
        End Set
    End Property

    Public Property CustomInfoField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("ApptCustomInfo"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("ApptCustomInfo") = value
        End Set
    End Property

    Private Property SourceCustomInfoField() As String
        Get
            Return CStr(SourceAppointment.CustomFields("ApptCustomInfo"))
        End Get
        Set(ByVal value As String)
            SourceAppointment.CustomFields("ApptCustomInfo") = value
        End Set
    End Property

    Public Overrides Function IsAppointmentChanged() As Boolean
        Dim isChanged As Boolean = MyBase.IsAppointmentChanged()
        Return isChanged OrElse SourceFirstNameField <> FirstNameField
    End Function





End Class