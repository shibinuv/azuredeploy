Public Class SupplierImportConfigBO
#Region "Member Variables"
    Private _supplierImportId As Integer = 0
    Private _supplierId As Integer = 0
    Private _fieldName As String = String.Empty
    Private _startNumber As Integer = 0
    Private _endNumber As Integer = 0
    Private _createdBy As String = String.Empty
    Private _dt_Created As DateTime = Now.Today()
    Private _modifiedBy As String = String.Empty
    Private _dt_Modified As DateTime = Now.Today()
    Private _suppConfigDO As SupplierImportConfigDO = New SupplierImportConfigDO()
    Private _fileMode As String = String.Empty
    Private _delimiter As String = String.Empty
    Private _orderOfFile As Integer = 0
    Private _layout_name As String = String.Empty
    Private _remove_start_zero As Boolean = False
    Private _remove_blank_field As Boolean = False
    Private _divide_price_by_hundred As Boolean = False
    Private _pricefile_dec_sep As String
#End Region

#Region "Properties"
    Public Property SupplierImportId() As Integer
        Get
            Return _supplierImportId
        End Get
        Set(ByVal value As Integer)
            _supplierImportId = value
        End Set
    End Property

    Public Property SupplierId() As Integer
        Get
            Return _supplierId
        End Get
        Set(ByVal value As Integer)
            _supplierId = value
        End Set
    End Property

    Public Property StartNumber() As Integer
        Get
            Return _startNumber
        End Get
        Set(ByVal value As Integer)
            _startNumber = value
        End Set
    End Property

    Public Property EndNumber() As Integer
        Get
            Return _endNumber
        End Get
        Set(ByVal value As Integer)
            _endNumber = value
        End Set
    End Property

    Public Property FieldName() As String
        Get
            Return _fieldName
        End Get
        Set(ByVal value As String)
            _fieldName = value
        End Set
    End Property

    Public Property CreateBy() As String
        Get
            Return _createdBy
        End Get
        Set(ByVal value As String)
            _createdBy = value
        End Set
    End Property

    Public Property DateCreated() As DateTime
        Get
            Return _dt_Created
        End Get
        Set(ByVal value As DateTime)
            _dt_Created = value
        End Set
    End Property

    Public Property ModifyBy() As String
        Get
            Return _modifiedBy
        End Get
        Set(ByVal value As String)
            _modifiedBy = value
        End Set
    End Property

    Public Property DateModified() As DateTime
        Get
            Return _dt_Modified
        End Get
        Set(ByVal value As DateTime)
            _dt_Modified = value
        End Set
    End Property

    Public Property FileMode() As String
        Get
            Return _fileMode
        End Get
        Set(ByVal value As String)
            _fileMode = value
        End Set
    End Property
    Public Property Delimiter() As String
        Get
            Return _delimiter
        End Get
        Set(ByVal value As String)
            _delimiter = value
        End Set
    End Property
    Public Property OrderOfFile() As Integer
        Get
            Return _orderOfFile
        End Get
        Set(ByVal value As Integer)
            _orderOfFile = value
        End Set
    End Property
    Public Property LayoutName() As String
        Get
            Return _layout_name
        End Get
        Set(ByVal value As String)
            _layout_name = value
        End Set
    End Property
    Public Property RemoveStartZero() As Boolean
        Get
            Return _remove_start_zero
        End Get
        Set(ByVal value As Boolean)
            _remove_start_zero = value
        End Set
    End Property
    Public Property RemoveBlankField() As Boolean
        Get
            Return _remove_blank_field
        End Get
        Set(ByVal value As Boolean)
            _remove_blank_field = value
        End Set
    End Property

    Public Property DividePriceByHundred() As Boolean
        Get
            Return _divide_price_by_hundred
        End Get
        Set(ByVal value As Boolean)
            _divide_price_by_hundred = value
        End Set
    End Property
    Public Property PriceFileDecimalSeperator() As String
        Get
            Return _pricefile_dec_sep
        End Get
        Set(ByVal value As String)
            _pricefile_dec_sep = value
        End Set
    End Property
#End Region
    ''' <summary>
    ''' Gets the list of suppliers.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function GetSuppliersList() As DataSet
        Return _suppConfigDO.GetSuppliersList
    End Function
    ''' <summary>
    ''' Gets the Supplier configuration for selected supplier.
    ''' </summary>
    ''' <param name="idSupplier"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function GetDataForGrid(ByVal idSupplier As Integer) As DataSet
        Return _suppConfigDO.GetDataForGrid(idSupplier)
    End Function
    ''' <summary>
    ''' Saves the modified supplier configuration details.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ModifyConfig() As String
        _suppConfigDO.SupplierImportId = SupplierImportId
        _suppConfigDO.StartNumber = StartNumber
        _suppConfigDO.EndNumber = EndNumber
        _suppConfigDO.OrderOfFile = OrderOfFile
        _suppConfigDO.ModifyBy = ModifyBy
        Return _suppConfigDO.ModifyConfig
    End Function
    ''' <summary>
    ''' Saves the newly created supplier configuration.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function SaveConfig() As String
        _suppConfigDO.SupplierId = SupplierId
        _suppConfigDO.StartNumber = StartNumber
        _suppConfigDO.EndNumber = EndNumber
        _suppConfigDO.FieldName = FieldName
        _suppConfigDO.CreateBy = CreateBy
        _suppConfigDO.FileMode = FileMode
        _suppConfigDO.OrderOfFile = OrderOfFile
        _suppConfigDO.Delimiter = Delimiter
        _suppConfigDO.LayoutName = LayoutName
        _suppConfigDO.RemoveStartZero = RemoveStartZero
        _suppConfigDO.RemoveBlankField = RemoveBlankField
        _suppConfigDO.DividePriceByHundred = DividePriceByHundred
        _suppConfigDO.PriceFileDecimalSeperator = PriceFileDecimalSeperator
        Return _suppConfigDO.SaveConfig()
    End Function
    ''' <summary>
    ''' Delete selected supplier configuration.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function DeleteConfig() As String
        _suppConfigDO.SupplierImportId = SupplierImportId
        Return _suppConfigDO.DeleteConfig()
    End Function
End Class
