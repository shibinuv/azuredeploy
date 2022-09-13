Imports System.ServiceModel

' NOTE: You can use the "Rename" command on the context menu to change the interface name "IDPService" in both code and config file together.
<ServiceContract()>
Public Interface IDPService


    <OperationContract()>
    <WebInvoke(Method:="GET", RequestFormat:=WebMessageFormat.Json, ResponseFormat:=WebMessageFormat.Json, BodyStyle:=WebMessageBodyStyle.Wrapped)>
    Function InsertUserDetails(ByVal mechanicInfo As String, ByVal loginId As String) As List(Of UserDetails)

    <WebInvoke(Method:="GET", RequestFormat:=WebMessageFormat.Json, ResponseFormat:=WebMessageFormat.Json, BodyStyle:=WebMessageBodyStyle.Wrapped)>
    Function FetchMechanicDetails(ByVal objUserDet As String) As List(Of UserDetails)

    <WebInvoke(Method:="GET", RequestFormat:=WebMessageFormat.Json, ResponseFormat:=WebMessageFormat.Json, BodyStyle:=WebMessageBodyStyle.Wrapped)>
    Function LoadMechanicDetails(ByVal idPlanSeq As String) As List(Of UserDetails)

    <WebInvoke(Method:="GET", RequestFormat:=WebMessageFormat.Json, ResponseFormat:=WebMessageFormat.Json, BodyStyle:=WebMessageBodyStyle.Wrapped)>
    Function DelMechanicDetails(ByVal idPlanSeq As String) As String
End Interface
Public Class UserDetails
    Private _mechanicId As String = String.Empty
    Private _planTimeFrom As String = String.Empty
    Private _planTimeTo As String = String.Empty
    Private _plandate As String = String.Empty
    Private _createdBy As String
    Private _deptId As Integer
    Private _desc As String = String.Empty
    Private _title As String = String.Empty
    Private _message As String
    Private _idPlanSeq As String
    Private _planDateFrom As String
    Private _planDateTo As String
    <DataMember> _
    Public Property MechanicId() As String
        Get
            Return _mechanicId
        End Get

        Set(value As String)
            _mechanicId = value
        End Set
    End Property
    <DataMember> _
    Public Property PlanTimeFrom() As String
        Get
            Return _planTimeFrom
        End Get

        Set(value As String)
            _planTimeFrom = value
        End Set
    End Property
    <DataMember> _
    Public Property PlanTimeTo() As String


        Get
            Return _planTimeTo
        End Get

        Set(value As String)
            _planTimeTo = value
        End Set
    End Property
    <DataMember> _
    Public Property PlanDate() As String
        Get
            Return _plandate
        End Get

        Set(value As String)
            _plandate = value
        End Set
    End Property
    <DataMember> _
    Public Property CreatedBy() As String
        Get
            Return _createdBy
        End Get

        Set(value As String)
            _createdBy = value
        End Set
    End Property
    <DataMember> _
    Public Property DeptId() As Integer
        Get
            Return _deptId
        End Get

        Set(value As Integer)
            _deptId = value
        End Set
    End Property
    <DataMember> _
    Public Property Description() As String
        Get
            Return _desc
        End Get

        Set(value As String)
            _desc = value
        End Set
    End Property
    <DataMember> _
    Public Property Title() As String
        Get
            Return _title
        End Get

        Set(value As String)
            _title = value
        End Set
    End Property
    <DataMember> _
    Public Property Message() As String
        Get
            Return _message
        End Get

        Set(value As String)
            _message = value
        End Set
    End Property
    <DataMember> _
    Public Property IdPlanSeq() As String
        Get
            Return _idPlanSeq
        End Get

        Set(value As String)
            _idPlanSeq = value
        End Set
    End Property
    <DataMember> _
    Public Property PlanDateFrom() As String
        Get
            Return _planDateFrom
        End Get

        Set(value As String)
            _planDateFrom = value
        End Set
    End Property
    <DataMember> _
    Public Property PlanDateTo() As String
        Get
            Return _planDateTo
        End Get

        Set(value As String)
            _planDateTo = value
        End Set
    End Property

End Class
