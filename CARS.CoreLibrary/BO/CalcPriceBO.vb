Imports System.Data.Common
Imports System.IO
Imports System.Xml.Serialization

Public Class CalcPriceBO
    Private _login As String
    Private _fromCategoryID As String
    Private _toCategoryID As String
    Private _fromSparePartID As String
    Private _toSparePartID As String
    Private intWHFrom As Integer
    Private intWHTo As Integer
    Private _fromWarehouseName As String
    Private _toWarehouseName As String
    Private _fromClassCodeID As String
    Private _toClassCodeID As String
    Private _fromLocation As String
    Private _toLocation As String
    Private _fromDiscountCodeBuying As String
	Private _toDiscountCodeBuying As String
	Private _makeID As String
	Private _sup_currNo As String
	Private _errorMessageFrom As String
	Private _errorMessageTo As String
	Private _createdBy As String
	Private dtDate_Created As Date
	Private _modifiedBy As String
	Private dtDate_Modified As Date
	Private _markupSellingPrice As Decimal
	Private _markupCostPrice As Decimal
	Private _markupNetPrice As Decimal
	Private _markupBasicPrice As Decimal
	Private _isAdjustCost As Boolean
	Private _costPriceFrom As String
	Private _roundingRules As Decimal
	Private _isCalculationBlocked As Boolean
	Private _isAdjustSP As Boolean
	Private _isSuccess As Boolean
	Private _errMsg As String
	Private _isRounding As Boolean
	Private _isRounding50 As Boolean
	Private _countValue As Integer
    Private _idItemCatg As String
    Private _priceFile As String
    Private _supplier_id As String

    Private _id_item As String
    Private _itemDescName2 As String
    Private _idUnitItem As String
    Private _itemDesc As String
    Private _idItemModel As String
    Private _itemDiscCodeBuy As String
    Private _itemPrice As Decimal
    Private _basicPrice As Decimal
    Private _costPrice1 As Decimal
    Private _costPrice2 As Decimal
    Private _itemDiscCode As Integer
    Private _packageQty As Integer
    Private _IdCurrency As Integer
    Private _isCalcPrice As Boolean
    Private _isDbSuccess As String
    Private _delete_global_spr_part As Boolean
    Private _update_global_spr_part As Boolean
    Private _update_local_spr_part As Boolean
    Private _update__spr_job_package As Boolean
    Private _barcode_number As String
    Private _calcPriceDO As CalcPriceDO = New CalcPriceDO()
#Region "Properties"
    Public Property Login() As String
        Get
            Return _login
        End Get
        Set(ByVal value As String)
            _login = value
        End Set
    End Property
	Public Property CategoryIDFrom() As String
		Get
			Return _fromCategoryID
		End Get
		Set(ByVal value As String)
			_fromCategoryID = value
		End Set
	End Property

	Public Property CategoryIDTo() As String
		Get
			Return _toCategoryID
		End Get
		Set(ByVal value As String)
			_toCategoryID = value
		End Set
	End Property

	Public Property SparePartIDFrom() As String
		Get
			Return _fromSparePartID
		End Get
		Set(ByVal value As String)
			_fromSparePartID = value
		End Set
	End Property

	Public Property SparePartIDTo() As String
		Get
			Return _toSparePartID
		End Get
		Set(ByVal value As String)
			_toSparePartID = value
		End Set
	End Property

	Public Property IDWHFrom() As Integer
		Get
			Return intWHFrom
		End Get
		Set(ByVal value As Integer)
			intWHFrom = value
		End Set
	End Property

	Public Property IDWHTo() As Integer
		Get
			Return intWHTo
		End Get
		Set(ByVal value As Integer)
			intWHTo = value
		End Set
	End Property

	Public Property WarehouseNameFrom() As String
		Get
			Return _fromWarehouseName
		End Get
		Set(ByVal value As String)
			_fromWarehouseName = value
		End Set
	End Property

	Public Property WarehouseNameTo() As String
		Get
			Return _toWarehouseName
		End Get
		Set(ByVal value As String)
			_toWarehouseName = value
		End Set
	End Property

	Public Property ClassCodeIDFrom() As String
		Get
			Return _fromClassCodeID
		End Get
		Set(ByVal value As String)
			_fromClassCodeID = value
		End Set
	End Property
	Public Property ClassCodeIDTo() As String
		Get
			Return _toClassCodeID
		End Get
		Set(ByVal value As String)
			_toClassCodeID = value
		End Set
	End Property

	Public Property LocationFrom() As String
		Get
			Return _fromLocation
		End Get
		Set(ByVal value As String)
			_fromLocation = value
		End Set
	End Property

	Public Property LocationTo() As String
		Get
			Return _toLocation
		End Get
		Set(ByVal value As String)
			_toLocation = value
		End Set
	End Property

	Public Property DiscountCodeBuyingFrom() As String
		Get
			Return _fromDiscountCodeBuying
		End Get
		Set(ByVal value As String)
			_fromDiscountCodeBuying = value
		End Set
	End Property

	Public Property DiscountCodeBuyingTo() As String
		Get
			Return _toDiscountCodeBuying
		End Get
		Set(ByVal value As String)
			_toDiscountCodeBuying = value
		End Set
	End Property
	Public Property MakeID() As String
		Get
			Return _makeID
		End Get
		Set(ByVal value As String)
			_makeID = value
		End Set
	End Property
	Public Property SuppCurrNo() As String
		Get
			Return _sup_currNo
		End Get
		Set(ByVal value As String)
			_sup_currNo = value
		End Set
	End Property

	Public Property ErrorMessageFrom() As String
		Get
			Return _errorMessageFrom
		End Get
		Set(ByVal value As String)
			_errorMessageFrom = value
		End Set
	End Property

	Public Property ErrorMessageTo() As String
		Get
			Return _errorMessageTo
		End Get
		Set(ByVal value As String)
			_errorMessageTo = value
		End Set
	End Property
	Public Property CreatedBy() As String
		Get
			Return _createdBy
		End Get
		Set(ByVal value As String)
			_createdBy = value
		End Set
	End Property
	Public Property DtCreated() As Date
		Get
			Return dtDate_Created
		End Get
		Set(ByVal value As Date)
			dtDate_Created = value
		End Set
	End Property

	Public Property ModifiedBy() As String
		Get
			Return _modifiedBy
		End Get
		Set(ByVal value As String)
			_modifiedBy = value
		End Set
	End Property

	Public Property DtModified() As Date
		Get
			Return dtDate_Modified
		End Get
		Set(ByVal value As Date)
			dtDate_Modified = value
		End Set
	End Property

	Public Property MarkupSellingPrice() As Decimal
		Get
			Return _markupSellingPrice
		End Get
		Set(ByVal value As Decimal)
			_markupSellingPrice = value
		End Set
	End Property

	Public Property MarkupCostPrice() As Decimal
		Get
			Return _markupCostPrice
		End Get
		Set(ByVal value As Decimal)
			_markupCostPrice = value
		End Set
	End Property

	Public Property MarkupNetPrice() As Decimal
		Get
			Return _markupNetPrice
		End Get
		Set(ByVal value As Decimal)
			_markupNetPrice = value
		End Set
	End Property
	Public Property MarkupBasicPrice() As Decimal
		Get
			Return _markupBasicPrice
		End Get
		Set(ByVal value As Decimal)
			_markupBasicPrice = value
		End Set
	End Property

	Public Property IsAdjustCost() As Boolean
		Get
			Return _isAdjustCost
		End Get
		Set(ByVal value As Boolean)
			_isAdjustCost = value
		End Set
	End Property

	Public Property CostPriceFrom() As String
		Get
			Return _costPriceFrom
		End Get
		Set(ByVal value As String)
			_costPriceFrom = value
		End Set
	End Property

	Public Property RoundingRules() As Decimal
		Get
			Return _roundingRules
		End Get
		Set(ByVal value As Decimal)
			_roundingRules = value
		End Set
	End Property

	Public Property IsCalculationBlocked() As Boolean
		Get
			Return _isCalculationBlocked
		End Get
		Set(ByVal value As Boolean)
			_isCalculationBlocked = value
		End Set
	End Property
	Public Property IsAdjustSP() As Boolean
		Get
			Return _isAdjustSP
		End Get
		Set(ByVal value As Boolean)
			_isAdjustSP = value
		End Set
	End Property

	Public Property Success() As Boolean
		Get
			Return _isSuccess
		End Get
		Set(ByVal value As Boolean)
			_isSuccess = value
		End Set
	End Property
	Public Property ErrorMessage() As String
		Get
			Return _errMsg
		End Get
		Set(ByVal value As String)
			_errMsg = value
		End Set
	End Property

	Public Property IsRounding() As Boolean
		Get
			Return _isRounding
		End Get
		Set(ByVal value As Boolean)
			_isRounding = value
		End Set
	End Property

	Public Property IsRounding50() As Boolean
		Get
			Return _isRounding50
		End Get
		Set(ByVal value As Boolean)
			_isRounding50 = value
		End Set
	End Property
	Public Property CountValue() As Integer
		Get
			Return _countValue
		End Get
		Set(ByVal value As Integer)
			_countValue = value
		End Set
	End Property
    Public Property IdItemCategory() As String
        Get
            Return _idItemCatg
        End Get
        Set(ByVal value As String)
            _idItemCatg = value
        End Set
    End Property
    Public Property PriceFile() As String
        Get
            Return _priceFile
        End Get
        Set(ByVal value As String)
            _priceFile = value
        End Set
    End Property

    Public Property SupplierID() As String
        Get
            Return _supplier_id
        End Get
        Set(ByVal value As String)
            _supplier_id = value
        End Set
    End Property
    'Newly Added 07-10-2021
    Public Property IdItem() As String
        Get
            Return _id_item
        End Get
        Set(ByVal value As String)
            _id_item = value
        End Set
    End Property
    Public Property ItemDescName2() As String
        Get
            Return _itemDescName2
        End Get
        Set(ByVal value As String)
            _itemDescName2 = value
        End Set
    End Property
    Public Property IdItemModel() As String
        Get
            Return _idItemModel
        End Get
        Set(ByVal value As String)
            _idItemModel = value
        End Set
    End Property

    Public Property IdUnitItem() As String
        Get
            Return _idUnitItem
        End Get
        Set(ByVal value As String)
            _idUnitItem = value
        End Set
    End Property
    Public Property ItemDiscCodeBuy() As String
        Get
            Return _itemDiscCodeBuy
        End Get
        Set(ByVal value As String)
            _itemDiscCodeBuy = value
        End Set
    End Property
    Public Property ItemDescription() As String
        Get
            Return _itemDesc
        End Get
        Set(ByVal value As String)
            _itemDesc = value
        End Set
    End Property
    Public Property ItemPrice() As Decimal
        Get
            Return _itemPrice
        End Get
        Set(ByVal value As Decimal)
            _itemPrice = value
        End Set
    End Property
    Public Property BasicPrice() As Decimal
        Get
            Return _basicPrice
        End Get
        Set(ByVal value As Decimal)
            _basicPrice = value
        End Set
    End Property
    Public Property CostPrice1() As Decimal
        Get
            Return _costPrice1
        End Get
        Set(ByVal value As Decimal)
            _costPrice1 = value
        End Set
    End Property

    Public Property CostPrice2() As Decimal
        Get
            Return _costPrice2
        End Get
        Set(ByVal value As Decimal)
            _costPrice2 = value
        End Set
    End Property

    Public Property ItemDiscCode() As Integer
        Get
            Return _itemDiscCode
        End Get
        Set(ByVal value As Integer)
            _itemDiscCode = value
        End Set
    End Property

    Public Property PackageQty() As Integer
        Get
            Return _packageQty
        End Get
        Set(ByVal value As Integer)
            _packageQty = value
        End Set
    End Property

    Public Property IdCurrency() As Integer
        Get
            Return _IdCurrency
        End Get
        Set(ByVal value As Integer)
            _IdCurrency = value
        End Set
    End Property

    Public Property CalcPrice() As Boolean
        Get
            Return _isCalcPrice
        End Get
        Set(ByVal value As Boolean)
            _isCalcPrice = value
        End Set
    End Property
    Public Property DBSuccess() As String
        Get
            Return _isDbSuccess
        End Get
        Set(ByVal value As String)
            _isDbSuccess = value
        End Set
    End Property
    Public Property IsDeleteGlobalSP() As Boolean
        Get
            Return _delete_global_spr_part
        End Get
        Set(ByVal value As Boolean)
            _delete_global_spr_part = value
        End Set
    End Property
    Public Property IsUpdateGlobalSP() As Boolean
        Get
            Return _update_global_spr_part
        End Get
        Set(ByVal value As Boolean)
            _update_global_spr_part = value
        End Set
    End Property
    Public Property IsUpdateLocalSP() As Boolean
        Get
            Return _update_local_spr_part
        End Get
        Set(ByVal value As Boolean)
            _update_local_spr_part = value
        End Set
    End Property
    Public Property IsUpdateSPJobPackage() As Boolean
        Get
            Return _update__spr_job_package
        End Get
        Set(ByVal value As Boolean)
            _update__spr_job_package = value
        End Set
    End Property
    Public Property Barcode_Number() As String
        Get
            Return _barcode_number
        End Get
        Set(ByVal value As String)
            _barcode_number = value
        End Set
    End Property
#End Region
    Public Function FetchWarehouse() As DataSet
        _calcPriceDO.Login = Login
        Return _calcPriceDO.FetchWarehouse()
    End Function
	Public Function GetCategory() As DataSet
		Dim category As New DataSet
		Try
			'_calcPriceDO.MakeIDFrom = MakeID
			'_calcPriceDO.MakeIDTo = MakeID

			_calcPriceDO.SuppCurrNo = SuppCurrNo
			_calcPriceDO.WarehouseNameFrom = WarehouseNameFrom
			_calcPriceDO.WarehouseNameTo = WarehouseNameTo
			category = _calcPriceDO.GetCategory
			Return category
		Catch ex As Exception
			Throw ex
		End Try
	End Function
	Public Function GetClassCode() As DataSet
		Dim classCode As DataSet
		Try
			_calcPriceDO.WarehouseNameFrom = WarehouseNameFrom
			_calcPriceDO.WarehouseNameTo = WarehouseNameTo
			'_calcPriceDO.MakeIDFrom = MakeID
			'_calcPriceDO.MakeIDTo = MakeID
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			_calcPriceDO.CategoryIDFrom = CategoryIDFrom
			_calcPriceDO.CategoryIDTo = CategoryIDTo
			_calcPriceDO.SparePartIDFrom = SparePartIDFrom
			_calcPriceDO.SparePartIDTo = SparePartIDTo

			classCode = _calcPriceDO.FetchClassCode
			Return classCode
		Catch ex As Exception
			Throw ex
		End Try
	End Function
	Public Function GetLocation() As DataSet
		Dim location As DataSet
		Try
			_calcPriceDO.WarehouseNameFrom = WarehouseNameFrom
			_calcPriceDO.WarehouseNameTo = WarehouseNameTo
			'_calcPriceDO.MakeIDFrom = MakeID
			'_calcPriceDO.MakeIDTo = MakeID
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			_calcPriceDO.CategoryIDFrom = CategoryIDFrom
			_calcPriceDO.CategoryIDTo = CategoryIDTo
			_calcPriceDO.SparePartIDFrom = SparePartIDFrom
			_calcPriceDO.SparePartIDTo = SparePartIDTo
			_calcPriceDO.ClassCodeIDFrom = ClassCodeIDFrom
			_calcPriceDO.ClassCodeIDTo = ClassCodeIDTo

			location = _calcPriceDO.GetLocation
			Return location
		Catch ex As Exception
			Throw ex
		End Try
	End Function

	Public Function GetDiscountCodeBuy() As DataSet
		Dim discountCodeBuy As DataSet
		Try
			_calcPriceDO.WarehouseNameFrom = WarehouseNameFrom
			_calcPriceDO.WarehouseNameTo = WarehouseNameTo
			'_calcPriceDO.MakeIDFrom = MakeID
			'_calcPriceDO.MakeIDTo = MakeID
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			_calcPriceDO.CategoryIDFrom = CategoryIDFrom
			_calcPriceDO.CategoryIDTo = CategoryIDTo
			_calcPriceDO.SparePartIDFrom = SparePartIDFrom
			_calcPriceDO.SparePartIDTo = SparePartIDTo
			_calcPriceDO.ClassCodeIDFrom = ClassCodeIDFrom
			_calcPriceDO.ClassCodeIDTo = ClassCodeIDTo
			_calcPriceDO.LocationFrom = LocationFrom
			_calcPriceDO.LocationTo = LocationTo

			discountCodeBuy = _calcPriceDO.GetDiscountCodeBuy
			Return discountCodeBuy
		Catch ex As Exception
			Throw ex
		End Try
	End Function

	Public Function GetCategoryGlobal() As DataSet
		Dim categoryGlobal As DataSet
		Try
			'_calcPriceDO.MakeID = MakeID
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			categoryGlobal = _calcPriceDO.GetCategoryGlobal
		Catch ex As Exception
			Throw ex
		End Try
		Return categoryGlobal
	End Function

	Public Function GetDiscountCodeBuyGlobal() As DataSet
		Dim discountCodeBuyGlobal As DataSet
		Try
			'_calcPriceDO.MakeID = MakeID
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			_calcPriceDO.CategoryIDFrom = CategoryIDFrom
			_calcPriceDO.CategoryIDTo = CategoryIDTo
			_calcPriceDO.SparePartIDFrom = SparePartIDFrom
			_calcPriceDO.SparePartIDTo = SparePartIDTo

			discountCodeBuyGlobal = _calcPriceDO.GetDiscountCodeBuyGlobal
			Return discountCodeBuyGlobal
		Catch ex As Exception
			Throw ex
		End Try
	End Function

	Public Function SparePartNoCheck(message) As DataSet
		Dim classCode As DataSet
		Try
			_calcPriceDO.WarehouseNameFrom = WarehouseNameFrom
			_calcPriceDO.WarehouseNameTo = WarehouseNameTo
			'_calcPriceDO.MakeID = MakeID
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			_calcPriceDO.CategoryIDFrom = CategoryIDFrom
			_calcPriceDO.CategoryIDTo = CategoryIDTo
			_calcPriceDO.SparePartIDFrom = SparePartIDFrom
			_calcPriceDO.SparePartIDTo = SparePartIDTo

			classCode = _calcPriceDO.SparePartNoCheck(message)

			ErrorMessageFrom = _calcPriceDO.ErrorMessageFrom
			ErrorMessageTo = _calcPriceDO.ErrorMessageTo
			Return classCode
		Catch ex As Exception
			Throw ex
		End Try
	End Function

	Public Sub UpdateGlobalSparePart()
		Try
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			_calcPriceDO.CategoryIDFrom = CategoryIDFrom
			_calcPriceDO.CategoryIDTo = CategoryIDTo
			_calcPriceDO.SparePartIDFrom = SparePartIDFrom
			_calcPriceDO.SparePartIDTo = SparePartIDTo
			_calcPriceDO.DiscountCodeBuyingFrom = DiscountCodeBuyingFrom
			_calcPriceDO.DiscountCodeBuyingTo = DiscountCodeBuyingTo

			_calcPriceDO.MarkupCostPrice = MarkupCostPrice
			_calcPriceDO.MarkupSellingPrice = MarkupSellingPrice
			_calcPriceDO.MarkupNetPrice = MarkupNetPrice
			_calcPriceDO.MarkupBasicPrice = MarkupBasicPrice

			_calcPriceDO.CostPriceFrom = CostPriceFrom
			_calcPriceDO.IsRounding = IsRounding
			_calcPriceDO.IsRounding50 = IsRounding50

			_calcPriceDO.IsCalculationBlocked = IsCalculationBlocked
			_calcPriceDO.IsAdjustCost = IsAdjustCost
			_calcPriceDO.IsAdjustSP = IsAdjustCost

			_calcPriceDO.CreatedBy = CreatedBy
			_calcPriceDO.ModifiedBy = ModifiedBy
			_calcPriceDO.UpdateGlobalSparePart()
			Success = _calcPriceDO.Success
			ErrorMessage = _calcPriceDO.ErrorMessage
			CountValue = _calcPriceDO.CountValue

		Catch ex As Exception
			Throw ex
		End Try
	End Sub

	Public Function SparePartSearch(ByVal q As String, ByVal localGlobal As String) As List(Of ItemsBO)
		Dim dsSparePart As New DataSet
		Dim dtSparePart As DataTable
		Dim sparePartSearchResult As New List(Of ItemsBO)()
		Try
			_calcPriceDO.SuppCurrNo = SuppCurrNo
			dsSparePart = _calcPriceDO.SparePart_Search(q, localGlobal)

			If dsSparePart.Tables.Count > 0 Then
				dtSparePart = dsSparePart.Tables(0)
			End If
			If q <> String.Empty Then
				For Each dtrow As DataRow In dtSparePart.Rows
					Dim csr As New ItemsBO()
					csr.ID_MAKE = dtrow("ID_MAKE").ToString
					csr.ID_ITEM = dtrow("ID_ITEM").ToString
					csr.ITEM_DESC = dtrow("ITEM_DESC").ToString
					'csr.ITEM_AVAIL_QTY = dtrow("ITEM_AVAIL_QTY").ToString
					'csr.LOCATION = dtrow("LOCATION").ToString
					'csr.ID_WH_ITEM = dtrow("ID_WH_ITEM").ToString
					'csr.LAST_COST_PRICE = dtrow("LAST_COST_PRICE").ToString
					csr.ITEM_PRICE = dtrow("ITEM_PRICE").ToString
					csr.ENV_ID_MAKE = dtrow("SUPP_CURRENTNO").ToString
					sparePartSearchResult.Add(csr)
				Next
			End If
		Catch ex As Exception
			Throw ex
		End Try
		Return sparePartSearchResult
	End Function
    Public Sub UpdateLocalSparePart()
        Try
            _calcPriceDO.SuppCurrNo = SuppCurrNo
            _calcPriceDO.CategoryIDFrom = CategoryIDFrom
            _calcPriceDO.CategoryIDTo = CategoryIDTo
            _calcPriceDO.SparePartIDFrom = SparePartIDFrom
            _calcPriceDO.SparePartIDTo = SparePartIDTo
            _calcPriceDO.DiscountCodeBuyingFrom = DiscountCodeBuyingFrom
            _calcPriceDO.DiscountCodeBuyingTo = DiscountCodeBuyingTo

            _calcPriceDO.WarehouseNameFrom = WarehouseNameFrom
            _calcPriceDO.WarehouseNameTo = WarehouseNameTo
            _calcPriceDO.LocationFrom = LocationFrom
            _calcPriceDO.LocationTo = LocationTo
            _calcPriceDO.ClassCodeIDFrom = ClassCodeIDFrom
            _calcPriceDO.ClassCodeIDTo = ClassCodeIDTo

            _calcPriceDO.MarkupCostPrice = MarkupCostPrice
            _calcPriceDO.MarkupSellingPrice = MarkupSellingPrice
            _calcPriceDO.MarkupNetPrice = MarkupNetPrice
            _calcPriceDO.MarkupBasicPrice = MarkupBasicPrice

            _calcPriceDO.CostPriceFrom = CostPriceFrom
            _calcPriceDO.IsRounding = IsRounding
            _calcPriceDO.IsRounding50 = IsRounding50

            _calcPriceDO.IsCalculationBlocked = IsCalculationBlocked
            _calcPriceDO.IsAdjustCost = IsAdjustCost
            _calcPriceDO.IsAdjustSP = IsAdjustCost

            _calcPriceDO.CreatedBy = CreatedBy
            _calcPriceDO.ModifiedBy = ModifiedBy
            _calcPriceDO.UpdateLocalSparePart()
            Success = _calcPriceDO.Success
            ErrorMessage = _calcPriceDO.ErrorMessage
            CountValue = _calcPriceDO.CountValue

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function FetchSparePartGroup() As DataSet
        _calcPriceDO.SuppCurrNo = SuppCurrNo
        Return _calcPriceDO.FetchSparePartGroup()
    End Function
    Public Sub InsertPricefileDetails(NoCrtUpdateSP As Boolean, DltAndAddSPReg As Boolean, UpdateSPReg As Boolean, UpdateLocalSP As Boolean, UpdateSPOnJobPkg As Boolean)
        With _calcPriceDO
            .IdItemCategory = IdItemCategory
            .SuppCurrNo = SuppCurrNo
            .MarkupBasicPrice = MarkupBasicPrice
            .MarkupSellingPrice = MarkupSellingPrice
            .MarkupCostPrice = MarkupCostPrice
            .MarkupNetPrice = MarkupNetPrice
            .PriceFile = PriceFile
            .CreatedBy = CreatedBy
            .InsertPricefileDetails(NoCrtUpdateSP, DltAndAddSPReg, UpdateSPReg, UpdateLocalSP, UpdateSPOnJobPkg)
            ' DbSuccess = .DBSuccess
        End With

    End Sub
    Public Function GetSupplierSettings() As DataSet
        Try
            _calcPriceDO.SupplierID = SupplierID
            Dim dsSuppSettings As DataSet = _calcPriceDO.GetSupplierSettings
            Return dsSuppSettings
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetUOM() As DataSet
        Dim uom As New ConfigUnitOfMeasurementDO
        Dim dsUOM As DataSet
        dsUOM = _calcPriceDO.FetchUnitOfMeasurement
        Return dsUOM
    End Function

    Public Function GetDiscountCode() As DataSet
        Try
            _calcPriceDO.MakeID = MakeID
            Return _calcPriceDO.FetchDiscountCode()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function FetchDiscountMatrixBuy() As DataSet
        Dim dsDmBuy As DataSet = Nothing
        Try
            dsDmBuy = _calcPriceDO.FetchDiscountMatrixBuy
            Return dsDmBuy
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GetSPRCurrency() As DataSet
        Dim dsCurr As DataSet = Nothing
        Try
            dsCurr = _calcPriceDO.GetSPRCurrency
            Return dsCurr
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub ImportGlobalSpareParts()
        'Dim addSparePart As New GlobalSparePartDO
        Dim addSparePart As New CalcPriceDO
        With addSparePart
            .SuppCurrNo = SuppCurrNo
            .IdItemCategory = IdItemCategory
            .IdItem = IdItem
            .ItemDescription = ItemDescription
            If (ItemDiscCodeBuy <> "") Then
                .ItemDiscCodeBuy = ItemDiscCodeBuy
            Else
                .ItemDiscCodeBuy = DBNull.Value.ToString()
            End If
            If (ItemDiscCode <> 0) Then
                .ItemDiscCode = ItemDiscCode
            Else
                .ItemDiscCode = 0
            End If
            If (IdCurrency <> 0) Then
                .IDCurrency = IdCurrency
            Else
                .IDCurrency = 0
            End If

            If (IdUnitItem <> "") Then
                .IdUnitItem = IdUnitItem
            Else
                .IdUnitItem = DBNull.Value.ToString
            End If

            If PackageQty <> 0 Then
                .PackageQty = PackageQty
            Else
                .PackageQty = 0
            End If

            If ItemDescName2 <> "" Then
                .ItemDescName2 = ItemDescName2
            Else
                .ItemDescName2 = DBNull.Value.ToString
            End If

            If IdItemModel <> "" Then
                .IdItemModel = IdItemModel
            Else
                .IdItemModel = DBNull.Value.ToString
            End If

            If CostPrice1 <> 0 Then
                .CostPrice1 = CostPrice1
            Else
                .CostPrice1 = 0.0
            End If
            If CostPrice2 <> 0 Then
                .CostPrice2 = CostPrice2
            Else
                .CostPrice2 = 0.0
            End If
            If BasicPrice <> 0 Then
                .BasicPrice = BasicPrice
            Else
                .BasicPrice = 0.0
            End If
            If ItemPrice <> 0 Then
                .ItemPrice = ItemPrice
            Else
                .ItemPrice = 0.0
            End If
            If CalcPrice Then
                .CalcPrice = 1
            Else
                .CalcPrice = 0
            End If
            .IsDeleteGlobalSP = IsDeleteGlobalSP
            .IsUpdateGlobalSP = IsUpdateGlobalSP
            .IsUpdateLocalSP = IsUpdateLocalSP
            .IsUpdateSPJobPackage = IsUpdateSPJobPackage
            .Barcode_Number = Barcode_Number
            .CreatedBy = CreatedBy
            .ModifiedBy = ModifiedBy
            .ImportGlobalSpareParts()
            DBSuccess = .DBSuccess
        End With
    End Sub
    Public Sub DeleteGlobalSparePart()
        _calcPriceDO.SupplierID = SupplierID
        _calcPriceDO.SuppCurrNo = SuppCurrNo
        _calcPriceDO.DeleteGlobalSparePart()
        DBSuccess = _calcPriceDO.DBSuccess

    End Sub
	Public Sub SaveGlobalEnvFee()
		_calcPriceDO.SuppCurrNo = SuppCurrNo
		_calcPriceDO.CreatedBy = CreatedBy
		_calcPriceDO.ItemDescription = ItemDescription
		_calcPriceDO.SaveGlobalEnvFee()

	End Sub
End Class
