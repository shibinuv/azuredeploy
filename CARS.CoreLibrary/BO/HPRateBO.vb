Public Class HPRateBO
#Region "Variable"
    Private ID_HP_SEQ As Integer
    Private ID_MAKE_HP As String
    Private ID_DEPT_HP As Integer
    Private ID_MECHPCD_HP As String
    Private ID_RPPCD_HP As String
    Private ID_CUSTPCD_HP As String
    Private ID_VEHGRP_HP As String
    Private ID_JOBPCD_HP As String
    Private INV_LABOR_TEXT As String
    Private HP_PRICE As Decimal
    Private HP_COST As Decimal
    Private FLG_TAKE_MECHNIC_COST As Boolean
    Private HP_ACC_CODE As String
    Private DT_EFF_FROM As DateTime
    Private DT_EFF_TO As DateTime
    Private CREATED_BY As String
    Private DT_CREATED As DateTime
    Private MODIFIED_BY As String
    Private DT_MODIFIED As DateTime
    Private HP_VAT As String
#End Region

#Region "Property"
    Public Property PHP_VAT() As String
        Get
            Return HP_VAT
        End Get
        Set(ByVal Value As String)
            HP_VAT = Value
        End Set
    End Property


    Public Property PCREATED_BY() As String
        Get
            Return CREATED_BY
        End Get
        Set(ByVal Value As String)
            CREATED_BY = Value
        End Set
    End Property



    Public Property PDT_CREATED() As DateTime
        Get
            Return DT_CREATED
        End Get
        Set(ByVal Value As DateTime)
            DT_CREATED = Value
        End Set
    End Property




    Public Property PDT_EFF_FROM() As DateTime
        Get
            Return DT_EFF_FROM
        End Get
        Set(ByVal Value As DateTime)
            DT_EFF_FROM = Value
        End Set
    End Property

    Public Property PDT_EFF_TO() As DateTime
        Get
            Return DT_EFF_TO
        End Get
        Set(ByVal Value As DateTime)
            DT_EFF_TO = Value
        End Set
    End Property




    Public Property PDT_MODIFIED() As DateTime
        Get
            Return DT_MODIFIED
        End Get
        Set(ByVal Value As DateTime)
            DT_MODIFIED = Value
        End Set
    End Property




    Public Property PHP_ACC_CODE() As String
        Get
            Return HP_ACC_CODE
        End Get
        Set(ByVal Value As String)
            HP_ACC_CODE = Value
        End Set
    End Property


    Public Property PHP_PRICE() As Decimal
        Get
            Return HP_PRICE
        End Get
        Set(ByVal Value As Decimal)
            HP_PRICE = Value
        End Set
    End Property

    Public Property PHP_COST() As Decimal
        Get
            Return HP_COST
        End Get
        Set(ByVal Value As Decimal)
            HP_COST = Value
        End Set
    End Property

    Public Property PFLG_TAKE_MECHNIC_COST() As Boolean
        Get
            Return FLG_TAKE_MECHNIC_COST
        End Get
        Set(ByVal Value As Boolean)
            FLG_TAKE_MECHNIC_COST = Value
        End Set
    End Property

    Public Property PID_CUSTPCD_HP() As String
        Get
            Return ID_CUSTPCD_HP
        End Get
        Set(ByVal Value As String)
            ID_CUSTPCD_HP = Value
        End Set
    End Property



    Public Property PID_DEPT_HP() As Integer
        Get
            Return ID_DEPT_HP
        End Get
        Set(ByVal Value As Integer)
            ID_DEPT_HP = Value
        End Set
    End Property

    Public Property PID_HP_SEQ() As Integer
        Get
            Return ID_HP_SEQ
        End Get
        Set(ByVal Value As Integer)
            ID_HP_SEQ = Value
        End Set
    End Property

    Public Property PID_JOBPCD_HP() As String
        Get
            Return ID_JOBPCD_HP
        End Get
        Set(ByVal Value As String)
            ID_JOBPCD_HP = Value
        End Set
    End Property




    Public Property PID_MAKE_HP() As String
        Get
            Return ID_MAKE_HP
        End Get
        Set(ByVal Value As String)
            ID_MAKE_HP = Value
        End Set
    End Property


    Public Property PID_MECHPCD_HP() As String
        Get
            Return ID_MECHPCD_HP
        End Get
        Set(ByVal Value As String)
            ID_MECHPCD_HP = Value
        End Set
    End Property



    Public Property PID_RPPCD_HP() As String
        Get
            Return ID_RPPCD_HP
        End Get
        Set(ByVal Value As String)
            ID_RPPCD_HP = Value
        End Set
    End Property

    Public Property PID_VEHGRP_HP() As String
        Get
            Return ID_VEHGRP_HP
        End Get
        Set(ByVal Value As String)
            ID_VEHGRP_HP = Value
        End Set
    End Property

    Public Property PINV_LABOR_TEXT() As String
        Get
            Return INV_LABOR_TEXT
        End Get
        Set(ByVal Value As String)
            INV_LABOR_TEXT = Value
        End Set
    End Property

    Public Property PMODIFIED_BY() As String
        Get
            Return MODIFIED_BY
        End Get
        Set(ByVal Value As String)
            MODIFIED_BY = Value
        End Set
    End Property
#End Region
End Class
