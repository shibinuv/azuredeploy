Public Class ItemImportableBO



    Private _orderprefix As String
    Private _id_item As String
    Private _id_item_catg As String
    Private _warehouse As Int64
    Private _id_warehouse As String
    Private _created_by As String
    Private _dt_created As String
    Private _modified_by As String
    Private _modified_by_id_dept As String
    Private _dt_modified As String
    Private _supp_currentno As Int64
    Private _flg_imported As Boolean
    Private _moduleType As String
    Private _orderline As String
    Private _orderseq As Int64
    Private _ordernumber As String
    Private _purchase_type As String
    Private _quantity As Decimal








    Public Property ORDERPREFIX() As String
        Get
            Return _orderprefix
        End Get
        Set(ByVal value As String)
            _orderprefix = value
        End Set
    End Property

    Public Property ID_ITEM() As String
        Get
            Return _id_item
        End Get
        Set(ByVal value As String)
            _id_item = value
        End Set
    End Property


    Public Property ID_ITEM_CATG() As String
        Get
            Return _id_item_catg
        End Get
        Set(ByVal value As String)
            _id_item_catg = value
        End Set
    End Property



    Public Property WAREHOUSE() As Int64
        Get
            Return _warehouse
        End Get
        Set(ByVal value As Int64)
            _warehouse = value
        End Set
    End Property


    Public Property MODIFIED_BY_ID_DEPT As String
        Get
            Return _modified_by_id_dept
        End Get
        Set(ByVal value As String)
            _modified_by_id_dept = value
        End Set
    End Property



    Public Property CREATED_BY() As String
            Get
                Return _created_by

            End Get
            Set(ByVal value As String)
                _created_by = value
            End Set
        End Property

        Public Property DT_CREATED() As String
            Get
                Return _dt_created
            End Get
            Set(ByVal value As String)
                _dt_created = value
            End Set
        End Property

        Public Property MODIFIED_BY() As String
            Get
                Return _modified_by
            End Get
            Set(ByVal value As String)
                _modified_by = value
            End Set
        End Property



    Public Property SUPP_CURRENTNO() As Int64
        Get
            Return _supp_currentno
        End Get
        Set(ByVal value As Int64)
            _supp_currentno = value
        End Set
    End Property

    Public Property FLG_IMPORTED() As String
        Get
            Return _flg_imported
        End Get
        Set(ByVal value As String)
            _flg_imported = value
        End Set
    End Property


    Public Property MODULETYPE() As String
        Get
            Return _moduleType
        End Get
        Set(ByVal value As String)
            _moduleType = value
        End Set
    End Property

    Public Property ORDERSEQ() As String
        Get
            Return _orderseq
        End Get
        Set(ByVal value As String)
            _orderseq = value
        End Set
    End Property

    Public Property ORDERLINE() As String
        Get
            Return _orderline
        End Get
        Set(ByVal value As String)
            _orderline = value
        End Set
    End Property

    Public Property ORDERNUMBER() As String
        Get
            Return _ordernumber
        End Get
        Set(ByVal value As String)
            _ordernumber = value
        End Set
    End Property

    Public Property PURCHASE_TYPE() As String
        Get
            Return _purchase_type
        End Get
        Set(ByVal value As String)
            _purchase_type = value
        End Set
    End Property



    Public Property QUANTITY() As Decimal
        Get
            Return _quantity
        End Get
        Set(ByVal value As Decimal)
            _quantity = value
        End Set
    End Property


End Class
