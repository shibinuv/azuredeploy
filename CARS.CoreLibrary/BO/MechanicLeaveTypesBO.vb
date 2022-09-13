Public Class MechanicLeaveTypesBO
#Region "Variable"
    Private _id_leave_types As Integer
    Private _leave_code As String
    Private _leave_description As String
    Private _approve_code As String
    Private _created_by As String
    Private _dt_created As DateTime
    Private _modified_by As String
    Private _dt_modified As DateTime

#End Region
#Region "Property"
    Public Property Id_Leave_Types() As Integer
        Get
            Return _id_leave_types
        End Get
        Set(ByVal value As Integer)
            _id_leave_types = value
        End Set
    End Property
    Public Property Leave_Code() As String
        Get
            Return _leave_code
        End Get
        Set(ByVal value As String)
            _leave_code = value
        End Set
    End Property
    Public Property Leave_Description() As String
        Get
            Return _leave_description
        End Get
        Set(ByVal value As String)
            _leave_description = value
        End Set
    End Property
    Public Property Approve_Code() As String
        Get
            Return _approve_code

        End Get
        Set(ByVal value As String)
            _approve_code = value
        End Set
    End Property
    Public Property Created_By() As String
        Get
            Return _created_by

        End Get
        Set(ByVal value As String)
            _created_by = value
        End Set
    End Property
    Public Property Dt_Created() As DateTime
        Get
            Return _dt_created

        End Get
        Set(ByVal value As DateTime)
            _dt_created = value
        End Set
    End Property
    Public Property Modified_By() As String
        Get
            Return _modified_by

        End Get
        Set(ByVal value As String)
            _modified_by = value
        End Set
    End Property
    Public Property Dt_Modified() As DateTime
        Get
            Return _dt_modified


        End Get
        Set(ByVal value As DateTime)
            _dt_modified = value
        End Set
    End Property
#End Region
End Class
