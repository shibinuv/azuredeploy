Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Web
Imports System.Xml

Namespace CustomEventsData
    Public Class CustomEvent
        Private id_Renamed As Object
        Private start As Date
        Private [end] As Date
        Private subject_Renamed As String
        Private status_Renamed As Integer
        Private description_Renamed As String
        Private label_Renamed As Long
        Private location_Renamed As String
        Private allday_Renamed As Boolean
        Private eventType_Renamed As Integer
        Private recurrenceInfo_Renamed As String
        Private reminderInfo_Renamed As String
        Private ownerId_Renamed As Object
        Private price_Renamed As Double
        Private contactInfo_Renamed As String
        Private customFirstName_Renamed As String
        Private customMiddleName_Renamed As String
        Private customLastName_Renamed As String
        Private customCustomerFirm_Renamed As Boolean
        Private customCustomerNumber_Renamed As String
        Private customVehicleRefNo_Renamed As String
        Private customVehicleRegNo_Renamed As String
        Private customVehicleChNo_Renamed As String
        Private customVehicleId_Renamed As Integer
        Private customVehicleRentalCar_Renamed As Boolean
        Private customVehiclePerService_Renamed As Boolean
        Private customVehiclePerCheck_Renamed As Boolean
        Private customVehicleMake_Renamed As Integer
        Private customVehicleModel_Renamed As String
        Private testInfo_Renamed As String
        Private customInfo_Renamed As String
        Private isOT As Boolean
        Private idWoNo As String
        Private ttDisplayData As String
        Private aptNoDisplayData As String
        Private is_Order_flg As Integer
        Private apptDetId As Integer
        Private idWoPrefix As string
        Public Sub New()
        End Sub
        Public Property IsOverTime() As Boolean
            Get
                Return isOT
            End Get
            Set(ByVal value As Boolean)
                isOT = value
            End Set
        End Property
        Public Property CustomVehicleMake() As Integer
            Get
                Return customVehicleMake_Renamed
            End Get
            Set(ByVal value As Integer)
                customVehicleMake_Renamed = value
            End Set
        End Property

        Public Property CustomVehicleModel() As String
            Get
                Return customVehicleModel_Renamed
            End Get
            Set(ByVal value As String)
                customVehicleModel_Renamed = value
            End Set
        End Property

        Public Property StartTime() As Date
            Get
                Return start
            End Get
            Set(ByVal value As Date)
                start = value
            End Set
        End Property
        Public Property EndTime() As Date
            Get
                Return [end]
            End Get
            Set(ByVal value As Date)
                [end] = value
            End Set
        End Property
        Public Property Subject() As String
            Get
                Return subject_Renamed
            End Get
            Set(ByVal value As String)
                subject_Renamed = value
            End Set
        End Property
        Public Property Status() As Integer
            Get
                Return status_Renamed
            End Get
            Set(ByVal value As Integer)
                status_Renamed = value
            End Set
        End Property
        Public Property Description() As String
            Get
                Return description_Renamed
            End Get
            Set(ByVal value As String)
                description_Renamed = value
            End Set
        End Property
        Public Property Label() As Long
            Get
                Return label_Renamed
            End Get
            Set(ByVal value As Long)
                label_Renamed = value
            End Set
        End Property
        Public Property Location() As String
            Get
                Return location_Renamed
            End Get
            Set(ByVal value As String)
                location_Renamed = value
            End Set
        End Property
        Public Property AllDay() As Boolean
            Get
                Return allday_Renamed
            End Get
            Set(ByVal value As Boolean)
                allday_Renamed = value
            End Set
        End Property
        Public Property EventType() As Integer
            Get
                Return eventType_Renamed
            End Get
            Set(ByVal value As Integer)
                eventType_Renamed = value
            End Set
        End Property
        Public Property RecurrenceInfo() As String
            Get
                Return recurrenceInfo_Renamed
            End Get
            Set(ByVal value As String)
                recurrenceInfo_Renamed = value
            End Set
        End Property
        Public Property ReminderInfo() As String
            Get
                Return reminderInfo_Renamed
            End Get
            Set(ByVal value As String)
                reminderInfo_Renamed = value
            End Set
        End Property
        Public Property OwnerId() As Object
            Get
                Return ownerId_Renamed
            End Get
            Set(ByVal value As Object)
                ownerId_Renamed = value
            End Set
        End Property
        Public Property Id() As Object
            Get
                Return id_Renamed
            End Get
            Set(ByVal value As Object)
                id_Renamed = value
            End Set
        End Property
        Public Property Price() As Double
            Get
                Return price_Renamed
            End Get
            Set(ByVal value As Double)
                price_Renamed = value
            End Set
        End Property
        Public Property ContactInfo() As String
            Get
                Return contactInfo_Renamed
            End Get
            Set(ByVal value As String)
                contactInfo_Renamed = value
            End Set
        End Property
        Public Property CustomCustomerNumber() As String
            Get
                Return customCustomerNumber_Renamed
            End Get
            Set(ByVal value As String)
                customCustomerNumber_Renamed = value
            End Set
        End Property
        Public Property CustomFirstName() As String
            Get
                Return customFirstName_Renamed
            End Get
            Set(ByVal value As String)
                customFirstName_Renamed = value
            End Set
        End Property
        Public Property CustomMiddleName() As String
            Get
                Return customMiddleName_Renamed
            End Get
            Set(ByVal value As String)
                customMiddleName_Renamed = value
            End Set
        End Property
        Public Property CustomLastName() As String
            Get
                Return customLastName_Renamed
            End Get
            Set(ByVal value As String)
                customLastName_Renamed = value
            End Set
        End Property
        Public Property TestInfo() As String
            Get
                Return testInfo_Renamed
            End Get
            Set(ByVal value As String)
                testInfo_Renamed = value
            End Set
        End Property
        Public Property CustomInfo() As String
            Get
                Return customInfo_Renamed
            End Get
            Set(ByVal value As String)
                customInfo_Renamed = value
            End Set
        End Property

        Public Property CustomVehicleRefNo() As String
            Get
                Return customVehicleRefNo_Renamed
            End Get
            Set(ByVal value As String)
                customVehicleRefNo_Renamed = value
            End Set
        End Property
        Public Property CustomVehicleRegNo() As String
            Get
                Return customVehicleRegNo_Renamed
            End Get
            Set(ByVal value As String)
                customVehicleRegNo_Renamed = value
            End Set
        End Property

        Public Property CustomVehicleChNo() As String
            Get
                Return customVehicleChNo_Renamed
            End Get
            Set(ByVal value As String)
                customVehicleChNo_Renamed = value
            End Set
        End Property
        Public Property CustomCustomerFirm() As Boolean
            Get
                Return customCustomerFirm_Renamed
            End Get
            Set(ByVal value As Boolean)
                customCustomerFirm_Renamed = value
            End Set
        End Property
        Public Property CustomVehicleId() As Integer
            Get
                Return customVehicleId_Renamed
            End Get
            Set(ByVal value As Integer)
                customVehicleId_Renamed = value
            End Set
        End Property
        Public Property CustomVehicleRentalCar() As Boolean
            Get
                Return customVehicleRentalCar_Renamed
            End Get
            Set(ByVal value As Boolean)
                customVehicleRentalCar_Renamed = value
            End Set
        End Property
        Public Property CustomVehiclePerService() As Boolean
            Get
                Return customVehiclePerService_Renamed
            End Get
            Set(ByVal value As Boolean)
                customVehiclePerService_Renamed = value
            End Set
        End Property
        Public Property CustomVehiclePerCheck() As Boolean
            Get
                Return customVehiclePerCheck_Renamed
            End Get
            Set(ByVal value As Boolean)
                customVehiclePerCheck_Renamed = value
            End Set
        End Property
        Public Property WONONum() As String
            Get
                Return idWoNo
            End Get
            Set(ByVal value As String)
                idWoNo = value
            End Set
        End Property
        Public Property TooltipDisplayData() As String
            Get
                Return ttDisplayData
            End Get
            Set(ByVal value As String)
                ttDisplayData = value
            End Set
        End Property
        Public Property AptNumberDisplayData() As String
            Get
                Return aptNoDisplayData
            End Get
            Set(ByVal value As String)
                aptNoDisplayData = value
            End Set
        End Property
        Public Property IsOrder() As Integer
            Get
                Return is_Order_flg
            End Get
            Set(ByVal value As Integer)
                is_Order_flg = value
            End Set
        End Property
        Public Property AppointmentDetId() As Integer
            Get
                Return apptDetId
            End Get
            Set(ByVal value As Integer)
                apptDetId = value
            End Set
        End Property
        Public Property WOPrefix() As String
            Get
                Return idWoPrefix
            End Get
            Set(ByVal value As String)
                idWoPrefix = value
            End Set
        End Property
    End Class


    Public Class CustomResource
        Private m_name As String
        Private m_res_id As String

        Public Property Name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Public Property ResID() As String
            Get
                Return m_res_id
            End Get
            Set(ByVal value As String)
                m_res_id = value
            End Set
        End Property
        Private privateColor As String
        Public Property Color() As String
            Get
                Return privateColor
            End Get
            Set(ByVal value As String)
                privateColor = value
            End Set
        End Property
        Public Property MECHANIC_ID() As String
        Public Property STANDARD_FROM_TIME() As DateTime
        Public Property STANDARD_TO_TIME() As DateTime
        Public Property MONDAY_FROM_TIME() As DateTime
        Public Property MONDAY_TO_TIME() As DateTime
        Public Property TUESDAY_FROM_TIME() As DateTime
        Public Property TUESDAY_TO_TIME() As DateTime
        Public Property WEDNESDAY_FROM_TIME() As DateTime
        Public Property WEDNESDAY_TO_TIME() As DateTime
        Public Property THURSDAY_FROM_TIME() As DateTime
        Public Property THURSDAY_TO_TIME() As DateTime
        Public Property FRIDAY_FROM_TIME() As DateTime
        Public Property FRIDAY_TO_TIME() As DateTime
        Public Property SATURDAY_FROM_TIME() As DateTime
        Public Property SATURDAY_TO_TIME() As DateTime
        Public Property SUNDAY_FROM_TIME() As DateTime
        Public Property SUNDAY_TO_TIME() As DateTime
        Public Property LUNCH_FROM_TIME() As DateTime
        Public Property LUNCH_TO_TIME() As DateTime
        'Newly Added
        Public Property PARENTRESID() As String
        Public Property MECHANIC_TYPE() As String
        'Newly Added
        Public Sub New()
        End Sub
    End Class

    <Serializable>
    Public Class CustomEventList
        Inherits BindingList(Of CustomEvent)

        Public Sub AddRange(ByVal events As CustomEventList)
            For Each customEvent As CustomEvent In events
                Me.Add(customEvent)
            Next customEvent
        End Sub
        Public Function GetEventIndex(ByVal eventId As Object) As Integer
            For i As Integer = 0 To Count - 1
                If Me(i).Id Is eventId Then
                    Return i
                End If
            Next i
            Return -1
        End Function
    End Class

    Public Class CustomEventDataSource
        Shared objAppDO As New AppointmentDO
        Dim connection As SqlConnection = New SqlConnection()
        Private events_Renamed As CustomEventList
        Public Sub New(ByVal events As CustomEventList)
            If events Is Nothing Then
                ' DevExpress.XtraScheduler.Native.Exceptions.ThrowArgumentNullException("events")
            End If
            Me.events_Renamed = events
        End Sub
        Public Sub New()
            Me.New(New CustomEventList())
        End Sub
        Public Property Events() As CustomEventList
            Get
                Return events_Renamed
            End Get
            Set(ByVal value As CustomEventList)
                events_Renamed = value
            End Set
        End Property
        Public ReadOnly Property Count() As Integer
            Get
                Return Events.Count
            End Get
        End Property

#Region "ObjectDataSource methods"
        Public Function InsertMethodHandler(ByVal customEvent As CustomEvent) As Object
            'Dim id As Object = customEvent.GetHashCode()
            'customEvent.Id = id
            'InsertValues(customEvent)
            'Return id
            'If (HttpContext.Current.Session("isCopy") = "yes" And customEvent.AptNumberDisplayData Is Nothing) Then
            If Not (customEvent.CustomInfo Is Nothing) AndAlso Not (customEvent.AptNumberDisplayData Is Nothing) Then
                CopyAppointment(customEvent)
                Return 0
            End If

            If HttpContext.Current.Session("aptUpdateOnOk") IsNot Nothing And HttpContext.Current.Session("aptUpdateOnOk") = True Then
                Dim loginName As String = HttpContext.Current.Session("UserID").ToString()
                objAppDO.ProcessAppointment("UPDATE", customEvent.Id, customEvent.StartTime, customEvent.EndTime, customEvent.Subject, customEvent.EventType, customEvent.Description, customEvent.Status, customEvent.Label, 0, customEvent.OwnerId, customEvent.CustomCustomerNumber, customEvent.CustomFirstName, customEvent.CustomMiddleName, customEvent.CustomLastName, IIf(customEvent.CustomCustomerFirm, 1, 0), customEvent.CustomVehicleRegNo, customEvent.CustomVehicleRefNo, customEvent.CustomVehicleChNo, IIf(customEvent.CustomVehicleRentalCar, 1, 0), IIf(customEvent.CustomVehiclePerCheck, 1, 0), IIf(customEvent.CustomVehiclePerService, 1, 0), customEvent.CustomInfo, customEvent.CustomVehicleId, customEvent.CustomVehicleMake, customEvent.CustomVehicleModel, loginName)
                HttpContext.Current.Session("aptUpdateOnOk") = False
            End If

        End Function

        Public Function CopyAppointment(customEvent As CustomEvent) As String
            Dim strval As String = ""
            Try
                Dim myApointmentId As Integer = Convert.ToInt32(customEvent.CustomInfo.ToString())
                'myApointmentId = InsertValues(customEvent, HttpContext.Current.Session("UserID").ToString())

                Dim dateTimeFrom As Date = customEvent.StartTime 'item.NewValues("START_TIME")
                dateTimeFrom = CDate(customEvent.StartTime.ToString().Substring(0, 10) & " " & FormatDateTime(dateTimeFrom, DateFormat.ShortTime))

                Dim dateTimeTo As Date = customEvent.EndTime ' item.NewValues("END_TIME")
                dateTimeTo = CDate(customEvent.EndTime.ToString().Substring(0, 10) & " " & FormatDateTime(dateTimeTo, DateFormat.ShortTime))

                Dim resourceId As String = GetResourceIdFromXML(customEvent.OwnerId.ToString())
                strval = objAppDO.CopyAppointment(myApointmentId, customEvent.AppointmentDetId, customEvent.StartTime, dateTimeFrom, customEvent.EndTime, dateTimeTo, resourceId, HttpContext.Current.Session("UserID").ToString())

            Catch ex As Exception
                Throw ex
            End Try

            Return strval
        End Function


        Public Function InsertValues(ByVal customEvent As CustomEvent, ByVal loginName As String) As Integer
            Try

                Return objAppDO.ProcessAppointment("INSERT", 0, customEvent.StartTime, customEvent.EndTime, customEvent.Subject, customEvent.EventType, customEvent.Description, customEvent.Status, customEvent.Label, 0, customEvent.OwnerId, customEvent.CustomCustomerNumber, customEvent.CustomFirstName, customEvent.CustomMiddleName, customEvent.CustomLastName, IIf(customEvent.CustomCustomerFirm, 1, 0), customEvent.CustomVehicleRegNo, customEvent.CustomVehicleRefNo, customEvent.CustomVehicleChNo, IIf(customEvent.CustomVehicleRentalCar, 1, 0), IIf(customEvent.CustomVehiclePerCheck, 1, 0), IIf(customEvent.CustomVehiclePerService, 1, 0), customEvent.CustomInfo, customEvent.CustomVehicleId, customEvent.CustomVehicleMake, customEvent.CustomVehicleModel, loginName)

            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Sub DeleteMethodHandler(ByVal customEvent As CustomEvent)
            Try
                Dim eventIndex As Integer = Events.GetEventIndex(customEvent.Id)
                If eventIndex >= 0 Then
                    Events.RemoveAt(eventIndex)
                End If
                Dim dsAll As DataSet = HttpContext.Current.Session("AllScheduler")
                Dim dt As DataTable = dsAll.Tables(0)
                Dim selRecord As Integer = customEvent.Id

                'to get gridview id to update on drag
                Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
                .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
                .Id = schdata.Field(Of Integer)("APPOINTMENT_ID"),
                .AptId = schdata.Field(Of Integer)("ID_APT_HDR")
                }).Where(Function(customer) customer.Id = selRecord)

                Dim selGridViewId As Integer = gdata(0).gvId
                Dim appointmentntmentId As Integer = gdata(0).AptId
                objAppDO.ProcessAppointmentDetails("DELETE", selGridViewId, Date.Now, Date.Now, Date.Now, Date.Now, "", "", "", appointmentntmentId, "", "", "", 0, "", "", "", "", "", 1, False)
            Catch ex As Exception
                Throw ex
            End Try
        End Sub
        Public Sub UpdateMethodHandler(ByVal customEvent As CustomEvent)
            If (HttpContext.Current.Session("Edit") = "yes") Then
                HttpContext.Current.Session("Edit") = "no"
            Else
                'updateGridView
                UpdateGridViewData(customEvent)
                HttpContext.Current.Session("Edit") = "no"
            End If
            UpdateData(customEvent)

        End Sub
        Public Sub UpdateData(customEvent As CustomEvent)
            Try
                Dim loginName As String = HttpContext.Current.Session("UserID").ToString()
                objAppDO.ProcessAppointment("UPDATE", customEvent.Id, customEvent.StartTime, customEvent.EndTime, customEvent.Subject, customEvent.EventType, customEvent.Description, customEvent.Status, customEvent.Label, 0, customEvent.OwnerId, customEvent.CustomCustomerNumber, customEvent.CustomFirstName, customEvent.CustomMiddleName, customEvent.CustomLastName, IIf(customEvent.CustomCustomerFirm, 1, 0), customEvent.CustomVehicleRegNo, customEvent.CustomVehicleRefNo, customEvent.CustomVehicleChNo, IIf(customEvent.CustomVehicleRentalCar, 1, 0), IIf(customEvent.CustomVehiclePerCheck, 1, 0), IIf(customEvent.CustomVehiclePerService, 1, 0), customEvent.CustomInfo, customEvent.CustomVehicleId, customEvent.CustomVehicleMake, customEvent.CustomVehicleModel, loginName)

            Catch ex As Exception
                Throw ex
            End Try
        End Sub

        Public Sub UpdateGridViewData(customEvent As CustomEvent)
            ' we need to rework for dragging different time and different mechanic
            Try

                Dim dsAll As DataSet = HttpContext.Current.Session("AllScheduler")
                Dim dt As DataTable = dsAll.Tables(0)
                Dim selRecord As Integer = customEvent.Id

                'to get gridview id to update on drag
                Dim gdata = dt.AsEnumerable().Select(Function(schdata) New With {
            .gvId = schdata.Field(Of Integer)("ID_APT_DTL"),
            .Id = schdata.Field(Of Integer)("APPOINTMENT_ID")
            }).Where(Function(customer) customer.Id = selRecord)

                Dim selGridViewId As Integer = gdata(0).gvId
                Dim resourceId As String = GetResourceIdFromXML(customEvent.OwnerId.ToString())
                objAppDO.ModifyAppointmentDetails(Convert.ToInt32(selGridViewId), customEvent.StartTime, customEvent.EndTime, resourceId, customEvent.OwnerId, customEvent.Status)

            Catch ex As Exception
                Throw ex
            End Try
        End Sub

        Public Sub ChangeAppointmentDetails(appointmentDetId As Integer, startTime As Date, endTime As Date, resourceId As String, resourceIds As String, sparePartStatus As Integer)
            Try
                objAppDO.ModifyAppointmentDetails(appointmentDetId, startTime, endTime, resourceId, resourceIds, sparePartStatus)

            Catch ex As Exception
                Throw ex
            End Try
        End Sub

        Public Function GetResourceIdFromXML(ByVal xmlString As String) As String
            Dim sr As New System.IO.StringReader(xmlString)
            Dim xmlDoc As New XmlDocument
            Try
                xmlDoc.Load(sr)
                Dim reader As New XmlNodeReader(xmlDoc)
                While reader.Read()
                    Select Case reader.NodeType
                        Case XmlNodeType.Element
                            If reader.Name = "ResourceId" Then
                                Return reader.GetAttribute("Value")
                            End If
                    End Select
                End While
                Return "0"
            Catch ex As Exception
                Throw ex
            End Try

        End Function
        Public Function SelectMethodHandler() As IEnumerable
            Try
                Dim result As New CustomEventList()
                result.AddRange(Events)

                Dim listOfdata As List(Of CustomEvent) = FetchDataAsList()

                Return listOfdata
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function FetchDataAsList() As List(Of CustomEvent)
            Dim MyClassList As New List(Of CustomEvent)
            Try

                Dim ds As DataSet = objAppDO.FetchAppointments
                Dim TheClassInstance As New CustomEvent

                Dim MyDataRow As DataRow
                Dim rowCount As Integer = Convert.ToInt32(ds.Tables(0).Rows.Count)
                HttpContext.Current.Session("AllScheduler") = ds
                For Each MyDataRow In ds.Tables(0).Rows
                    TheClassInstance = New CustomEvent

                    TheClassInstance.Id = MyDataRow("APPOINTMENT_ID")
                    TheClassInstance.Label = IIf(IsDBNull(MyDataRow("LABEL")), 1, MyDataRow("LABEL"))
                    TheClassInstance.Status = IIf(IsDBNull(MyDataRow("APT_SAPRE_PART_STATUS")), 1, MyDataRow("APT_SAPRE_PART_STATUS"))
                    TheClassInstance.EndTime = MyDataRow("END_DATE")
                    TheClassInstance.StartTime = MyDataRow("START_DATE")

                    TheClassInstance.OwnerId = MyDataRow("RESOURCE_IDs")
                    TheClassInstance.Subject = IIf(IsDBNull(MyDataRow("DESCRIPTION")), "", MyDataRow("DESCRIPTION"))
                    TheClassInstance.Description = IIf(IsDBNull(MyDataRow("DESCRIPTION")), "", MyDataRow("DESCRIPTION"))
                    'TheClassInstance.Status = IIf(IsDBNull(MyDataRow("STATUS")), 1, MyDataRow("STATUS"))
                    TheClassInstance.Status = IIf(IsDBNull(MyDataRow("APT_SAPRE_PART_STATUS")), 1, MyDataRow("APT_SAPRE_PART_STATUS"))
                    TheClassInstance.CustomInfo = MyDataRow("ID_APT_HDR").ToString()
                    TheClassInstance.CustomFirstName = IIf(IsDBNull(MyDataRow("CUSTOMER_FIRST_NAME")), "", MyDataRow("CUSTOMER_FIRST_NAME"))
                    TheClassInstance.CustomMiddleName = IIf(IsDBNull(MyDataRow("CUSTOMER_MIDDLE_NAME")), "", MyDataRow("CUSTOMER_MIDDLE_NAME"))
                    TheClassInstance.CustomLastName = IIf(IsDBNull(MyDataRow("CUSTOMER_LAST_NAME")), "", MyDataRow("CUSTOMER_LAST_NAME"))
                    TheClassInstance.CustomCustomerNumber = IIf(IsDBNull(MyDataRow("CUSTOMER_NUMBER")), "", MyDataRow("CUSTOMER_NUMBER"))
                    TheClassInstance.CustomVehicleChNo = IIf(IsDBNull(MyDataRow("VEHICLE_CH_NO")), "", MyDataRow("VEHICLE_CH_NO")) 'MyDataRow("VEHICLE_CH_NO")
                    TheClassInstance.CustomVehicleRefNo = IIf(IsDBNull(MyDataRow("VEHICLE_REF_NO")), "", MyDataRow("VEHICLE_REF_NO")) 'MyDataRow("VEHICLE_REF_NO")
                    TheClassInstance.CustomVehicleRegNo = IIf(IsDBNull(MyDataRow("VEHICLE_REG_NO")), "", MyDataRow("VEHICLE_REG_NO")) 'MyDataRow("VEHICLE_REG_NO")
                    TheClassInstance.CustomCustomerFirm = IIf(IsDBNull(MyDataRow("CUSTOMER_FIRM")), False, MyDataRow("CUSTOMER_FIRM")) 'MyDataRow("CUSTOMER_FIRM") 
                    TheClassInstance.CustomVehicleId = IIf(IsDBNull(MyDataRow("ID_VEH_SEQ_WO")), 0, MyDataRow("ID_VEH_SEQ_WO"))
                    TheClassInstance.CustomVehicleMake = IIf(IsDBNull(MyDataRow("WO_VEH_MAK_MOD_MAP")), 0, MyDataRow("WO_VEH_MAK_MOD_MAP"))
                    TheClassInstance.CustomVehicleModel = IIf(IsDBNull(MyDataRow("WO_VEH_MOD")), 0, MyDataRow("WO_VEH_MOD"))
                    TheClassInstance.WONONum = IIf(IsDBNull(MyDataRow("ID_WO_NO")), "0", MyDataRow("ID_WO_NO").ToString)
                    TheClassInstance.TooltipDisplayData = TheClassInstance.CustomInfo + "$" + TheClassInstance.CustomVehicleRegNo + "$" + TheClassInstance.CustomFirstName + " " + TheClassInstance.CustomMiddleName + " " + TheClassInstance.CustomLastName + "$" + IIf(IsDBNull(MyDataRow("DESCRIPTION")), "", MyDataRow("DESCRIPTION"))
                    TheClassInstance.IsOverTime = IIf(IsDBNull(MyDataRow("IS_OVER_TIME")), False, MyDataRow("IS_OVER_TIME"))
                    TheClassInstance.AptNumberDisplayData = MyDataRow("ID_APT_HDR").ToString() + "-" + IIf(IsDBNull(MyDataRow("APT_SERIAL_NO")), "1", MyDataRow("APT_SERIAL_NO").ToString())
                    TheClassInstance.IsOrder = IIf(IsDBNull(MyDataRow("IS_ORDER")), 0, MyDataRow("IS_ORDER"))
                    TheClassInstance.AppointmentDetId = MyDataRow("ID_APT_DTL")
                    TheClassInstance.WOPrefix = IIf(IsDBNull(MyDataRow("ID_WO_PREFIX")), "0", MyDataRow("ID_WO_PREFIX").ToString)
                    MyClassList.Add(TheClassInstance)

                    'Everytime you loop you're adding an instance of the class to the list
                Next
            Catch ex As Exception
                Throw ex
            End Try
            Return MyClassList
        End Function

#End Region
        Public Function ObtainLastInsertedId() As Object
            If Count < 1 Then
                Return Nothing
            End If
            Return Events(Count - 1).Id
        End Function
    End Class

    Public Class CustomResourceDataSource

        Private resources_Renamed As BindingList(Of CustomResource)
        Public Sub New(ByVal parResources As BindingList(Of CustomResource))
            If parResources Is Nothing Then
                ' DevExpress.XtraScheduler.Native.Exceptions.ThrowArgumentNullException("Resources")
            End If
            Me.Resources = parResources
        End Sub
        Public Sub New()
            Me.New(New BindingList(Of CustomResource)())

        End Sub
        Public Property Resources() As BindingList(Of CustomResource)
            Get
                Return resources_Renamed
            End Get
            Set(ByVal value As BindingList(Of CustomResource))
                resources_Renamed = value
            End Set
        End Property

#Region "ObjectDataSource methods"
        Public Function SelectMethodHandler() As IEnumerable
            Return Resources
        End Function
#End Region
    End Class

    Public Class CustomTreeListResourceDataSource
        Private resources_Renamed As BindingList(Of CustomResource)
        Public Sub New(ByVal parResources As BindingList(Of CustomResource))
            If parResources Is Nothing Then
                ' DevExpress.XtraScheduler.Native.Exceptions.ThrowArgumentNullException("Resources")
            End If
            Me.Resources = parResources
        End Sub
        Public Sub New()
            Me.New(New BindingList(Of CustomResource)())

        End Sub
        Public Property Resources() As BindingList(Of CustomResource)
            Get
                Return resources_Renamed
            End Get
            Set(ByVal value As BindingList(Of CustomResource))
                resources_Renamed = value
            End Set
        End Property

#Region "ObjectDataSource methods"
        Public Function SelectMethodHandler() As IEnumerable
            Return Resources
        End Function
#End Region
    End Class
End Namespace
