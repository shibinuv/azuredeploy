Public Class PurchaseOrderItemsBO

    Private _id_po As String
    Private _polineno As String
    Private _poprefix As String
    Private _ponumber As String
    Private _id_item As String
    Private _item_desc As String
    Private _id_item_catg As String
    Private _item_catg_desc As String

    Private _orderqty As Decimal
    Private _max_purchase As Decimal
    Private _min_purchase As Decimal
    Private _consumption_estimated As Decimal

    Private _min_stock As Decimal
    Private _delivered_qty As Decimal
    Private _remaining_qty As Decimal
    Private _cost_price1 As Decimal
    Private _net_price As Decimal
    Private _basic_price As Decimal
    Private _item_price As Decimal
    Private _totalcost As Decimal
    Private _backorderqty As String
    Private _id_woitem_seq As String
    Private _confirmqty As String
    Private _created_by As String
    Private _modified_by As String
    Private _dt_created As String
    Private _dt_modified As String
    Private _delivered As String
    Private _annotation As String
    Private _rest_flg As Boolean
    Private _item_avail_qty As Decimal
    Private _supp_currentno As String
    Private _indelivery As Decimal
    Private _id_wo_no_and_prefix As String
    Private _location As String
    Private _item_disc_code_buy As String

    Private _freight_limit As String
    Private _freight_perc_above As String
    Private _freight_perc_below As String



    Public Property ID_PO() As String
        Get
            Return _id_po
        End Get
        Set(ByVal value As String)
            _id_po = value
        End Set
    End Property

    Public Property POLINENO() As String
        Get
            Return _polineno
        End Get
        Set(ByVal value As String)
            _polineno = value
        End Set
    End Property

    Public Property POPREFIX() As String
        Get
            Return _poprefix
        End Get
        Set(ByVal value As String)
            _poprefix = value
        End Set
    End Property

    Public Property PONUMBER() As String
        Get
            Return _ponumber
        End Get
        Set(ByVal value As String)
            _ponumber = value
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

    Public Property ITEM_DESC() As String
        Get
            Return _item_desc
        End Get
        Set(ByVal value As String)
            _item_desc = value
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
    Public Property ITEM_CATG_DESC() As String
        Get
            Return _item_catg_desc
        End Get
        Set(ByVal value As String)
            _item_catg_desc = value
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

    Public Property DT_MODIFED() As String
        Get
            Return _dt_modified
        End Get
        Set(ByVal value As String)
            _dt_modified = value
        End Set
    End Property



    Public Property ORDERQTY() As Decimal
        Get
            Return _orderqty
        End Get
        Set(ByVal value As Decimal)
            _orderqty = value
        End Set
    End Property

    Public Property DELIVERED_QTY() As Decimal
        Get
            Return _delivered_qty
        End Get
        Set(ByVal value As Decimal)
            _delivered_qty = value
        End Set
    End Property



    Public Property REMAINING_QTY() As Decimal
        Get
            Return _remaining_qty
        End Get
        Set(ByVal value As Decimal)
            _remaining_qty = value
        End Set
    End Property

    Public Property COST_PRICE1() As Decimal
        Get
            Return _cost_price1
        End Get
        Set(ByVal value As Decimal)
            _cost_price1 = value
        End Set
    End Property

    Public Property ITEM_PRICE() As Decimal
        Get
            Return _item_price
        End Get
        Set(ByVal value As Decimal)
            _item_price = value
        End Set
    End Property
    Public Property NET_PRICE() As Decimal
        Get
            Return _net_price
        End Get
        Set(ByVal value As Decimal)
            _net_price = value
        End Set
    End Property
    Public Property BASIC_PRICE() As Decimal
        Get
            Return _basic_price
        End Get
        Set(ByVal value As Decimal)
            _basic_price = value
        End Set
    End Property

    Public Property TOTALCOST() As Decimal
        Get
            Return _totalcost
        End Get
        Set(ByVal value As Decimal)
            _totalcost = value
        End Set
    End Property





    Public Property BACKORDERQTY() As String
        Get
            Return _backorderqty
        End Get
        Set(ByVal value As String)
            _backorderqty = value
        End Set
    End Property

    Public Property ID_WOITEM_SEQ() As String
        Get
            Return _id_woitem_seq
        End Get
        Set(ByVal value As String)
            _id_woitem_seq = value
        End Set
    End Property

    Public Property CONFIRMQTY() As String
        Get
            Return _confirmqty
        End Get
        Set(ByVal value As String)
            _confirmqty = value
        End Set
    End Property

    Public Property DELIVERED() As String
        Get
            Return _delivered
        End Get
        Set(ByVal value As String)
            _delivered = value
        End Set
    End Property

    Public Property ANNOTATION() As String
        Get
            Return _annotation
        End Get
        Set(ByVal value As String)
            _annotation = value
        End Set
    End Property

    Public Property REST_FLG() As Boolean
        Get
            Return _rest_flg
        End Get
        Set(ByVal value As Boolean)
            _rest_flg = value
        End Set
    End Property

    Public Property ITEM_AVAIL_QTY() As Decimal
        Get
            Return _item_avail_qty
        End Get
        Set(ByVal value As Decimal)
            _item_avail_qty = value
        End Set
    End Property

    Public Property SUPP_CURRENTNO() As String
        Get
            Return _supp_currentno
        End Get
        Set(ByVal value As String)
            _supp_currentno = value
        End Set
    End Property

    Public Property INDELIVERY() As Decimal
        Get
            Return _indelivery
        End Get
        Set(ByVal value As Decimal)
            _indelivery = value
        End Set
    End Property

    Public Property MIN_STOCK() As Decimal
        Get
            Return _min_stock
        End Get
        Set(ByVal value As Decimal)
            _min_stock = value
        End Set
    End Property

    Public Property MIN_PURCHASE() As Decimal
        Get
            Return _min_purchase
        End Get
        Set(ByVal value As Decimal)
            _min_purchase = value
        End Set
    End Property

    Public Property MAX_PURCHASE() As Decimal
        Get
            Return _max_purchase
        End Get
        Set(ByVal value As Decimal)
            _max_purchase = value
        End Set
    End Property

    Public Property CONSUMPTION_ESTIMATED() As Decimal
        Get
            Return _consumption_estimated
        End Get
        Set(ByVal value As Decimal)
            _consumption_estimated = value
        End Set
    End Property





    Public Property ID_WO_NO_AND_PREFIX() As String
        Get
            Return _id_wo_no_and_prefix
        End Get
        Set(ByVal value As String)
            _id_wo_no_and_prefix = value
        End Set
    End Property

    Public Property LOCATION() As String
        Get
            Return _location
        End Get
        Set(ByVal value As String)
            _location = value
        End Set
    End Property


    Public Property ITEM_DISC_CODE_BUY() As String
        Get
            Return _item_disc_code_buy
        End Get
        Set(ByVal value As String)
            _item_disc_code_buy = value
        End Set
    End Property

    Public Property FREIGHT_LIMIT() As String
        Get
            Return _freight_limit
        End Get
        Set(ByVal value As String)
            _freight_limit = value
        End Set
    End Property

    Public Property FREIGHT_PERC_ABOVE() As String
        Get
            Return _freight_perc_above
        End Get
        Set(ByVal value As String)
            _freight_perc_above = value
        End Set
    End Property

    Public Property FREIGHT_PERC_BELOW() As String
        Get
            Return _freight_perc_below
        End Get
        Set(ByVal value As String)
            _freight_perc_below = value
        End Set
    End Property

End Class
