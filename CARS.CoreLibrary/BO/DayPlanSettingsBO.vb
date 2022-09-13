Public Class DayPlanSettingsBO

#Region "Variables"
    Private _idorderstatus As Integer
    Private _orderstatuscode As String
    Private _orderstatusdesc As String
    Private _orderstatuscolor As String
    Private _createdBy As String
    Private _createddate As String
    Private _modifieddate As String
    Private _modifiedby As String
    Private _mode As String

    Private _idconfigAppmnt As String
    Private _appmntStartTimeHr As String
    Private _appmntStartTimeMin As String
    Private _appmntStopTimeHr As String
    Private _appmntStopTimeMin As String
    Private _lastAppmntNum As String
    Private _historyLimit As String
    Private _minAppmntTime As String
    Private _dispShwSatSund As String
    Private _mechanicPerPage As String

    Private _idapptstatus As Integer
    Private _appttatuscode As String
    Private _apptstatuscolor As String
    Private _ctrlByStd As Boolean
    Private _ctrlByStatus As Boolean
    Private _ctrlByMechanic As Boolean

    Private _showOnHoldOnLoad As Boolean

#End Region

#Region "Property"
    Public Property IdOrderStatus() As Integer
        Get
            Return _idorderstatus
        End Get
        Set(ByVal Value As Integer)
            _idorderstatus = Value
        End Set
    End Property
    Public Property OrderStatusCode() As String
        Get
            Return _orderstatuscode
        End Get
        Set(ByVal Value As String)
            _orderstatuscode = Value
        End Set
    End Property
    Public Property OrderStatusDesc() As String
        Get
            Return _orderstatusdesc
        End Get
        Set(ByVal Value As String)
            _orderstatusdesc = Value
        End Set
    End Property
    Public Property OrderStatusColor() As String
        Get
            Return _orderstatuscolor
        End Get
        Set(ByVal Value As String)
            _orderstatuscolor = Value
        End Set
    End Property

    Public Property CreatedBy() As String
        Get
            Return _createdBy
        End Get
        Set(ByVal Value As String)
            _createdBy = Value
        End Set
    End Property

    Public Property CreatedDate() As String
        Get
            Return _createddate
        End Get
        Set(ByVal Value As String)
            _createddate = Value
        End Set
    End Property
    Public Property ModifiedDate() As String
        Get
            Return _modifieddate
        End Get
        Set(ByVal Value As String)
            _modifieddate = Value
        End Set
    End Property
    Public Property ModifiedBy() As String
        Get
            Return _modifiedby
        End Get
        Set(ByVal Value As String)
            _modifiedby = Value
        End Set
    End Property

    Public Property Mode() As String
        Get
            Return _mode
        End Get
        Set(ByVal Value As String)
            _mode = Value
        End Set
    End Property

    Public Property IdConfigAppmnt() As String
        Get
            Return _idconfigAppmnt
        End Get
        Set(ByVal Value As String)
            _idconfigAppmnt = Value
        End Set
    End Property

    Public Property AppmntStartTimeHr() As String
        Get
            Return _appmntStartTimeHr
        End Get
        Set(ByVal Value As String)
            _appmntStartTimeHr = Value
        End Set
    End Property
    Public Property AppmntStartTimeMin() As String
        Get
            Return _appmntStartTimeMin
        End Get
        Set(ByVal Value As String)
            _appmntStartTimeMin = Value
        End Set
    End Property

    Public Property AppmntStopTimeHr() As String
        Get
            Return _appmntStopTimeHr
        End Get
        Set(ByVal Value As String)
            _appmntStopTimeHr = Value
        End Set
    End Property

    Public Property AppmntStopTimeMin() As String
        Get
            Return _appmntStopTimeMin
        End Get
        Set(ByVal Value As String)
            _appmntStopTimeMin = Value
        End Set
    End Property

    Public Property LastAppmntNum() As String
        Get
            Return _lastAppmntNum
        End Get
        Set(ByVal Value As String)
            _lastAppmntNum = Value
        End Set
    End Property

    Public Property HistoryLimit() As String
        Get
            Return _historyLimit
        End Get
        Set(ByVal Value As String)
            _historyLimit = Value
        End Set
    End Property

    Public Property MinAppmntTime() As String
        Get
            Return _minAppmntTime
        End Get
        Set(ByVal Value As String)
            _minAppmntTime = Value
        End Set
    End Property

    Public Property DispShwSatSund() As String
        Get
            Return _dispShwSatSund
        End Get
        Set(ByVal Value As String)
            _dispShwSatSund = Value
        End Set
    End Property

    Public Property MechanicPerPage() As String
        Get
            Return _mechanicPerPage
        End Get
        Set(ByVal Value As String)
            _mechanicPerPage = Value
        End Set
    End Property
    Public Property IdAppointmentStatus() As Integer
        Get
            Return _idapptstatus
        End Get
        Set(ByVal Value As Integer)
            _idapptstatus = Value
        End Set
    End Property
    Public Property AppointmentStatusColor() As String
        Get
            Return _apptstatuscolor
        End Get
        Set(ByVal Value As String)
            _apptstatuscolor = Value
        End Set
    End Property
    Public Property AppointmentStatusCode() As String
        Get
            Return _appttatuscode
        End Get
        Set(ByVal Value As String)
            _appttatuscode = Value
        End Set
    End Property

    Public Property ControlledByStandard() As Boolean
        Get
            Return _ctrlByStd
        End Get
        Set(ByVal Value As Boolean)
            _ctrlByStd = Value
        End Set
    End Property

    Public Property ControlledByStatus() As Boolean
        Get
            Return _ctrlByStatus
        End Get
        Set(ByVal Value As Boolean)
            _ctrlByStatus = Value
        End Set
    End Property

    Public Property ControlledByMechanic() As Boolean
        Get
            Return _ctrlByMechanic
        End Get
        Set(ByVal Value As Boolean)
            _ctrlByMechanic = Value
        End Set
    End Property

    Public Property ShowOnHoldOnLoad() As Boolean
        Get
            Return _ShowOnHoldOnLoad
        End Get
        Set(ByVal Value As Boolean)
            _ShowOnHoldOnLoad = Value
        End Set
    End Property
#End Region


End Class
