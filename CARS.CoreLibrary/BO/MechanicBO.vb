Public Class MechanicBO
#Region "Variable"

    Private _id_login As String
    Private _first_name As String
    Private _last_name As String
    'Private _from_date As Date
    'Private _to_date As Date
    'Private _from_time As DateTime
    'Private _to_time As DateTime
    'Private _leave_code As String
    'Private _leave_reason As String
    'Private comments As String
    'Private _mechanic_name As String
    'Private _id_login As String

#End Region
#Region "Property"

    Public Property Id_Login() As String
        Get
            Return _id_login
        End Get
        Set(ByVal value As String)
            _id_login = value
        End Set
    End Property
    Public Property First_Name() As String
        Get
            Return _first_name
        End Get
        Set(ByVal value As String)
            _first_name = value
        End Set
    End Property
    Public Property Last_Name() As String
        Get
            Return _last_name

        End Get
        Set(ByVal value As String)
            _last_name = value
        End Set
    End Property
    Public Property IdMechanicSettings As Integer
    Public Property IdLeaveTypes() As Integer
    Public Property FromDate() As Date
    Public Property ToDate() As Date
    Public Property Fromtime() As String
    Public Property Totime() As String
    Public Property Leave_Code() As String
    Public Property Leave_Reason() As String
    Public Property Comments() As String
    Public Property Mechanic_Name() As String
#End Region
End Class
