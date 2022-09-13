Imports System.Data.Common
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Public Class CalcPriceDO
    Private _login As String
    Dim objDB As Database
    Dim ConnectionString As String
    Private _fromCategoryID As String
    Private _toCategoryID As String
    Private _fromSparePartID As String
    Private _toSparePartID As String
    Private _categoryFrom, _categoryTo As String
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
    Private strMakeFrom As String
    Private strMakeTo As String
    Private _makeIDfrom As String
    Private _makeIDto As String
    Private _makeID As String
    Private _sup_currNo As String
    Private _errorMessageFrom As String
    Private _errorMessageTo As String
    Private _markupSellingPrice As Decimal
    Private _markupCostPrice As Decimal
    Private _markupNetPrice As Decimal
    Private _markupBasicPrice As Decimal
    Private _isAdjustCost As Boolean
    Private _costPriceFrom As String
    Private _roundingRules As Decimal
    Private _isCalculationBlocked As Boolean
    Private _isAdjustSP As Boolean
    Private _isRounding As Boolean
    Private _isRounding50 As Boolean
    Private _isSuccess As Boolean
    Private _errMsg As String
    Private _createdBy As String
    Private dtDate_Created As Date
    Private _modifiedBy As String
    Private dtDate_Modified As Date
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
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
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

    Public Property WarehouseIDFrom() As Integer
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

    Public Property MakeFrom() As String
        Get
            Return strMakeFrom
        End Get
        Set(ByVal value As String)
            strMakeFrom = value
        End Set
    End Property
    Public Property MakeTo() As String
        Get
            Return strMakeTo
        End Get
        Set(ByVal value As String)
            strMakeTo = value
        End Set
    End Property
    Public Property MakeIDFrom() As String
        Get
            Return _makeIDfrom
        End Get
        Set(ByVal value As String)
            _makeIDfrom = value
        End Set
    End Property
    Public Property MakeIDTo() As String
        Get
            Return _makeIDto
        End Get
        Set(ByVal value As String)
            _makeIDto = value
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
    Public Property ErrorMessageTo() As String
        Get
            Return _errorMessageTo
        End Get
        Set(ByVal value As String)
            _errorMessageTo = value
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
    Public Function FetchWarehouse() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_WAREHOUSE_FETCH")
                objDB.AddInParameter(objcmd, "@IV_LOGINID", DbType.String, Login)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetCategory() As DataSet
        Try
            'Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_CATEGORY_FETCH")
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPARES_CATEGORY_FETCH")
                'If MakeIDFrom Is Nothing Then
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, DBNull.Value)
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, MakeIDFrom.Trim)
                'End If
                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If
                If WarehouseNameFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, WarehouseNameFrom.Trim)
                End If
                If WarehouseNameTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, WarehouseNameTo.Trim)
                End If
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function FetchClassCode() As DataSet
        Try
            'Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_CLASSCODE_FETCH")
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPARES_CLASSCODE_FETCH")

                If WarehouseNameFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, WarehouseNameFrom.Trim)
                End If
                If WarehouseNameTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, WarehouseNameTo.Trim)
                End If
                'If MakeIDFrom Is Nothing Then
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDFROM", DbType.String, DBNull.Value)
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDFROM", DbType.String, MakeIDFrom.Trim)
                'End If

                'objDB.AddInParameter(objcmd, "@IV_MAKEIDFROM", DbType.String, "DIV")
                'If MakeIDTo Is Nothing Then
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDTO", DbType.String, DBNull.Value)
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDTO", DbType.String, MakeIDTo.Trim)
                'End If
                'objDB.AddInParameter(objcmd, "@IV_MAKEIDTO", DbType.String, "DIV")

                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                If CategoryIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, CategoryIDFrom.Trim)
                End If
                If CategoryIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, CategoryIDTo.Trim)
                End If

                If SparePartIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, SparePartIDFrom.Trim)
                End If
                If SparePartIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, SparePartIDTo.Trim)
                End If

                Return objDB.ExecuteDataSet(objcmd)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GetLocation() As DataSet
        Try
            'Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_LOCATION_FETCH")
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPARES_LOCATION_FETCH")

                If WarehouseNameFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, WarehouseNameFrom.Trim)
                End If
                If WarehouseNameTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, WarehouseNameTo.Trim)
                End If
                'If MakeIDFrom Is Nothing Then
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDFROM", DbType.String, "DIV")
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDFROM", DbType.String, MakeIDFrom.Trim)
                'End If
                'If MakeIDTo Is Nothing Then
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDTO", DbType.String, "DIV")
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_MAKEIDTO", DbType.String, MakeIDTo.Trim)
                'End If

                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                If CategoryIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, CategoryIDFrom.Trim)
                End If
                If CategoryIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, CategoryIDTo.Trim)
                End If

                If SparePartIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, SparePartIDFrom.Trim)
                End If
                If SparePartIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, SparePartIDTo.Trim)
                End If

                If ClassCodeIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODEFROM", DbType.String, ClassCodeIDFrom.Trim)
                End If
                If ClassCodeIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODETO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODETO", DbType.String, ClassCodeIDTo.Trim)
                End If

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function GetDiscountCodeBuy() As DataSet
        Try
            'Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DISCODEBUY_FETCH")
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPARES_DISCODEBUY_FETCH")

                If WarehouseNameFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, WarehouseNameFrom.Trim)
                End If
                If WarehouseNameTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, WarehouseNameTo.Trim)
                End If
                'If MakeID Is Nothing Then
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, "DIV")
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, MakeID.Trim)
                'End If

                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                If CategoryIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, CategoryIDFrom.Trim)
                End If
                If CategoryIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, CategoryIDTo.Trim)
                End If

                If SparePartIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, SparePartIDFrom.Trim)
                End If
                If SparePartIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, SparePartIDTo.Trim)
                End If

                If ClassCodeIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODEFROM", DbType.String, ClassCodeIDFrom.Trim)
                End If
                If ClassCodeIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODETO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODETO", DbType.String, ClassCodeIDTo.Trim)
                End If

                If LocationFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_LOCFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_LOCFROM", DbType.String, LocationFrom.Trim)
                End If
                If LocationTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_LOCTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_LOCTO", DbType.String, LocationTo.Trim)
                End If

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function


    Public Function GetCategoryGlobal() As DataSet
        Try

            'Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_CATEGORYGLOBAL_FETCH")
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPARES_CATEGORYGLOBAL_FETCH")

                'If MakeID <> "" Then
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, MakeID)
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, DBNull.Value)
                'End If

                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                Return objDB.ExecuteDataSet(objcmd)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GetDiscountCodeBuyGlobal() As DataSet

        Try
            ' Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DISCODEBUYGLOBAL_FETCH")
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPARES_DISCODEBUYGLOBAL_FETCH")

                'If MakeID <> "" Then
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, MakeID)
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, DBNull.Value)
                'End If

                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                If CategoryIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, CategoryIDFrom.Trim)
                End If
                If CategoryIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, CategoryIDTo.Trim)
                End If

                If SparePartIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, SparePartIDFrom.Trim)
                End If
                If SparePartIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, SparePartIDTo.Trim)
                End If
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function SparePartNoCheck(ByVal message As String) As DataSet

        Try
            Dim sparePartCheck As DataSet
            'Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPARTNOCHECK")
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPARTNOCHECK_NEW")

                If WarehouseNameFrom <> Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, WarehouseNameFrom)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, DBNull.Value)
                End If

                If WarehouseNameTo <> Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, WarehouseNameTo)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, DBNull.Value)
                End If

                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                'If MakeID <> "" Then
                '    objDB.AddInParameter(objcmd, "@IV_MAKE", DbType.String, MakeID)
                'Else
                '    objDB.AddInParameter(objcmd, "@IV_MAKE", DbType.String, "DIV")
                'End If

                If CategoryIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, CategoryIDFrom.Trim)
                End If
                If CategoryIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, CategoryIDTo.Trim)
                End If

                If SparePartIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, SparePartIDFrom.Trim)
                End If

                If SparePartIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, SparePartIDTo.Trim)
                End If

                If message = "" Then
                    objDB.AddInParameter(objcmd, "@IV_LOCALGLOBAL", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_LOCALGLOBAL", DbType.String, message)
                End If

                objDB.AddOutParameter(objcmd, "@OV_FROM", DbType.String, 200)
                objDB.AddOutParameter(objcmd, "@OV_TO", DbType.String, 200)

                sparePartCheck = objDB.ExecuteDataSet(objcmd)

                'If objDB.GetParameterValue(objcmd, "@OV_FROM") <> "" Then
                'ErrorMessageFrom = objDB.GetParameterValue(objcmd, "@OV_FROM").ToString
                'Else
                '    ErrorMessageFrom = DBNull.Value
                'End If

                ErrorMessageFrom = objDB.GetParameterValue(objcmd, "@OV_FROM").ToString
                ErrorMessageTo = objDB.GetParameterValue(objcmd, "@OV_TO").ToString

                Return sparePartCheck

            End Using

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function UpdateGlobalSparePart() As DataSet

        Try
            Dim sparePartCheck As DataSet
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_GLOBALPRICE_UPDATE_NEW")


                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                If CategoryIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, CategoryIDFrom.Trim)
                End If
                If CategoryIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, CategoryIDTo.Trim)
                End If

                If SparePartIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, SparePartIDFrom.Trim)
                End If

                If SparePartIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, SparePartIDTo.Trim)
                End If

                If DiscountCodeBuyingFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYFROM", DbType.String, DiscountCodeBuyingFrom.Trim)
                End If

                If DiscountCodeBuyingTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYTO", DbType.String, DiscountCodeBuyingTo.Trim)
                End If

                If MarkupSellingPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPSELL", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPSELL", DbType.Decimal, MarkupSellingPrice)
                End If

                If MarkupCostPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPCOST", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPCOST", DbType.Decimal, MarkupCostPrice)
                End If

                If MarkupNetPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPNET", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPNET", DbType.Decimal, MarkupNetPrice)
                End If

                If MarkupBasicPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPBASIC", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPBASIC", DbType.Decimal, MarkupBasicPrice)
                End If

                If CostPriceFrom Is String.Empty Then
                    objDB.AddInParameter(objcmd, "@IV_COSTPRICEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_COSTPRICEFROM", DbType.String, CostPriceFrom)
                End If

                If Not IsCalculationBlocked Then
                    objDB.AddInParameter(objcmd, "@IV_CALCBLOCK", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CALCBLOCK", DbType.Boolean, IsCalculationBlocked)
                End If

                If Not IsAdjustCost Then
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTCOST", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTCOST", DbType.Boolean, IsAdjustCost)
                End If

                If Not IsAdjustSP Then
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTSP", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTSP", DbType.Boolean, IsAdjustSP)
                End If

                If Not IsRounding Then
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING", DbType.Boolean, IsRounding)
                End If

                If Not IsRounding50 Then
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING_50", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING_50", DbType.Boolean, IsRounding50)
                End If

                If CreatedBy Is String.Empty Then
                    objDB.AddInParameter(objcmd, "@IV_CREATEDBY", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CREATEDBY", DbType.String, CreatedBy)
                End If

                If ModifiedBy Is String.Empty Then
                    objDB.AddInParameter(objcmd, "@IV_MODIFIEDBY", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MODIFIEDBY", DbType.String, ModifiedBy)
                End If

                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.String, 200)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 200)
                objDB.AddOutParameter(objcmd, "@COUNTVAR", DbType.Int32, 200)

                sparePartCheck = objDB.ExecuteDataSet(objcmd)

                Success = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString
                ErrorMessage = objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
                CountValue = objDB.GetParameterValue(objcmd, "@COUNTVAR")

                Return sparePartCheck

            End Using

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function SparePart_Search(ByVal sparePart As String, ByVal localGlobal As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_SEARCH_NEW")
                objDB.AddInParameter(objCMD, "@ID_SEARCH", DbType.String, sparePart)
                objDB.AddInParameter(objCMD, "@IV_LOCALGLOBAL", DbType.String, localGlobal)
                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objCMD, "@IV_SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objCMD, "@IV_SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)

                End If
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function UpdateLocalSparePart() As DataSet
        Try
            Dim sparePartCheck As DataSet
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_LOCALPRICE_UPDATE_NEW")

                If SuppCurrNo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, SuppCurrNo.Trim)
                End If

                If CategoryIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATFROM", DbType.String, CategoryIDFrom.Trim)
                End If
                If CategoryIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CATTO", DbType.String, CategoryIDTo.Trim)
                End If

                If SparePartIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDFROM", DbType.String, SparePartIDFrom.Trim)
                End If

                If SparePartIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_SPAREIDTO", DbType.String, SparePartIDTo.Trim)
                End If

                If DiscountCodeBuyingFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYFROM", DbType.String, DiscountCodeBuyingFrom.Trim)
                End If

                If DiscountCodeBuyingTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_DISCODEBUYTO", DbType.String, DiscountCodeBuyingTo.Trim)
                End If

                If WarehouseNameFrom <> Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, WarehouseNameFrom)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMEFROM", DbType.String, DBNull.Value)
                End If

                If WarehouseNameTo <> Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, WarehouseNameTo)
                Else
                    objDB.AddInParameter(objcmd, "@IV_WHNAMETO", DbType.String, DBNull.Value)
                End If

                If ClassCodeIDFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODEFROM", DbType.String, ClassCodeIDFrom.Trim)
                End If
                If ClassCodeIDTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODETO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CLASSCODETO", DbType.String, ClassCodeIDTo.Trim)
                End If

                If LocationFrom Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_LOCFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_LOCFROM", DbType.String, LocationFrom.Trim)
                End If
                If LocationTo Is Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_LOCTO", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_LOCTO", DbType.String, LocationTo.Trim)
                End If

                If MarkupSellingPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPSELL", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPSELL", DbType.Decimal, MarkupSellingPrice)
                End If

                If MarkupCostPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPCOST", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPCOST", DbType.Decimal, MarkupCostPrice)
                End If

                If MarkupNetPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPNET", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPNET", DbType.Decimal, MarkupNetPrice)
                End If

                If MarkupBasicPrice = Nothing Then
                    objDB.AddInParameter(objcmd, "@IV_MARKUPBASIC", DbType.Decimal, 0)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MARKUPBASIC", DbType.Decimal, MarkupBasicPrice)
                End If

                If CostPriceFrom Is String.Empty Then
                    objDB.AddInParameter(objcmd, "@IV_COSTPRICEFROM", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_COSTPRICEFROM", DbType.String, CostPriceFrom)
                End If

                If Not IsCalculationBlocked Then
                    objDB.AddInParameter(objcmd, "@IV_CALCBLOCK", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CALCBLOCK", DbType.Boolean, IsCalculationBlocked)
                End If

                If Not IsAdjustCost Then
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTCOST", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTCOST", DbType.Boolean, IsAdjustCost)
                End If

                If Not IsAdjustSP Then
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTSP", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ADJUSTSP", DbType.Boolean, IsAdjustSP)
                End If

                If Not IsRounding Then
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING", DbType.Boolean, IsRounding)
                End If

                If Not IsRounding50 Then
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING_50", DbType.String, False)
                Else
                    objDB.AddInParameter(objcmd, "@IV_ROUNDING_50", DbType.Boolean, IsRounding50)
                End If

                If CreatedBy Is String.Empty Then
                    objDB.AddInParameter(objcmd, "@IV_CREATEDBY", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_CREATEDBY", DbType.String, CreatedBy)
                End If

                If ModifiedBy Is String.Empty Then
                    objDB.AddInParameter(objcmd, "@IV_MODIFIEDBY", DbType.String, DBNull.Value)
                Else
                    objDB.AddInParameter(objcmd, "@IV_MODIFIEDBY", DbType.String, ModifiedBy)
                End If

                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.String, 200)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 200)
                objDB.AddOutParameter(objcmd, "@COUNTVAR", DbType.Int32, 200)

                sparePartCheck = objDB.ExecuteDataSet(objcmd)

                Success = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString
                ErrorMessage = objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
                CountValue = objDB.GetParameterValue(objcmd, "@COUNTVAR")

                Return sparePartCheck

            End Using

        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Function FetchSparePartGroup() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPARES_BO_CATEGORY_FETCH")
                objDB.AddInParameter(objcmd, "@Supp_CurrNo", DbType.String, SuppCurrNo)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Sub InsertPricefileDetails(NoCrtUpdateSP As Boolean, DltAndAddSPReg As Boolean, UpdateSPReg As Boolean, UpdateLocalSP As Boolean, UpdateSPOnJobPkg As Boolean)
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_IMPORTPRICEFILE_NEW")
                objDB.AddInParameter(objCMD, "@ID_ITEM_CATG", DbType.String, IdItemCategory)
                objDB.AddInParameter(objCMD, "@ID_SUPPLIER", DbType.String, SuppCurrNo)
                objDB.AddInParameter(objCMD, "@MarkupforSellPrice", DbType.String, MarkupSellingPrice)
                objDB.AddInParameter(objCMD, "@MarkupforBasicPrice", DbType.String, MarkupBasicPrice)
                objDB.AddInParameter(objCMD, "@MarkupforCostPrice1", DbType.String, MarkupCostPrice)
                objDB.AddInParameter(objCMD, "@MarkupforCostPrice2", DbType.String, MarkupNetPrice)
                objDB.AddInParameter(objCMD, "@PriceFileName", DbType.String, PriceFile)
                objDB.AddInParameter(objCMD, "@NO_CRT_UPD_SP_REG", DbType.Boolean, NoCrtUpdateSP)
                objDB.AddInParameter(objCMD, "@DLT_AND_ADD_SP_REG", DbType.Boolean, DltAndAddSPReg)
                objDB.AddInParameter(objCMD, "@UPDATE_SP_REG", DbType.Boolean, UpdateSPReg)
                objDB.AddInParameter(objCMD, "@UPDATE_LOCAL_SP", DbType.Boolean, UpdateLocalSP)
                objDB.AddInParameter(objCMD, "@UPDATE_SP_ON_JOB_PKG", DbType.Boolean, UpdateSPOnJobPkg)
                objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, CreatedBy)
                'objDB.AddInParameter(objCMD, "@ID_JOB", DbType.Int32, 0)

                objDB.ExecuteNonQuery(objCMD)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function GetSupplierSettings() As DataSet
        Dim dsSuppSettings As DataSet
        dsSuppSettings = Nothing
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_SUPPLIER_SETTINGS")
                objDB.AddInParameter(objCMD, "@SUPPID", DbType.String, SupplierID)
                dsSuppSettings = objDB.ExecuteDataSet(objCMD)
            End Using
            Return dsSuppSettings
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function FetchUnitOfMeasurement() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_UOM")
                Return objDB.ExecuteDataSet(objCMD)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function FetchDiscountCode() As DataSet
        Dim SqlParam(0) As SqlClient.SqlParameter
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DISCOUNTCODE_FETCH")
                objDB.AddInParameter(objCMD, "@ID_MAKE", DbType.String, MakeID.Trim())
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function FetchDiscountMatrixBuy() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_DMBUY")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetSPRCurrency() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("usp_spr_fetch_currency")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Sub ImportGlobalSpareParts()
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_IMPORTSUPP_SAVE_GLOBALSPAREPART_NEW")
                objDB.AddInParameter(objCMD, "@ID_ITEM", DbType.String, IdItem)
                objDB.AddInParameter(objCMD, "@ITEM_DESC", DbType.String, ItemDescription)
                objDB.AddInParameter(objCMD, "@ITEM_DESC_NAME2", DbType.String, ItemDescName2)
                If (IdUnitItem <> "") Then
                    objDB.AddInParameter(objCMD, "@ID_UNIT_ITEM", DbType.String, IdUnitItem)
                Else
                    objDB.AddInParameter(objCMD, "@ID_UNIT_ITEM", DbType.String, DBNull.Value)
                End If
                objDB.AddInParameter(objCMD, "@ID_MAKE", DbType.String, SuppCurrNo)
                objDB.AddInParameter(objCMD, "@ID_ITEM_MODEL", DbType.String, IdItemModel)
                objDB.AddInParameter(objCMD, "@ID_ITEM_CATG", DbType.String, IdItemCategory)
                If ItemDiscCode <> 0 Then
                    objDB.AddInParameter(objCMD, "@ITEM_DISC_CODE", DbType.String, ItemDiscCode)
                Else
                    objDB.AddInParameter(objCMD, "@ITEM_DISC_CODE", DbType.String, DBNull.Value)
                End If

                If ItemDiscCodeBuy <> "" Then
                    objDB.AddInParameter(objCMD, "@ITEM_DISC_CODE_BUY", DbType.String, ItemDiscCodeBuy)
                Else
                    objDB.AddInParameter(objCMD, "@ITEM_DISC_CODE_BUY", DbType.String, DBNull.Value)
                End If
                objDB.AddInParameter(objCMD, "@BASIC_PRICE", DbType.Decimal, BasicPrice)
                objDB.AddInParameter(objCMD, "@ITEM_PRICE", DbType.Decimal, ItemPrice)
                objDB.AddInParameter(objCMD, "@COST_PRICE1", DbType.Decimal, CostPrice1)
                objDB.AddInParameter(objCMD, "@COST_PRICE2", DbType.Decimal, CostPrice2)
                objDB.AddInParameter(objCMD, "@FLG_CALC_PRICE", DbType.Boolean, CalcPrice)
                objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, CreatedBy)
                objDB.AddInParameter(objCMD, "@PACKAGE_QTY", DbType.Int32, PackageQty)
                If IdCurrency <> 0 Then
                    objDB.AddInParameter(objCMD, "@CURRENCY", DbType.Int32, IdCurrency)
                Else
                    objDB.AddInParameter(objCMD, "@CURRENCY", DbType.Int32, DBNull.Value)
                End If
                objDB.AddInParameter(objCMD, "@MODIFIED_BY", DbType.String, ModifiedBy)
                objDB.AddInParameter(objCMD, "@IS_UPDATE_GBL_SP", DbType.Boolean, IsUpdateGlobalSP)
                objDB.AddInParameter(objCMD, "@IS_UPDATE_LCL_SP", DbType.Boolean, IsUpdateLocalSP)
                objDB.AddInParameter(objCMD, "@IS_DLT_ADDGBL_SP", DbType.Boolean, IsDeleteGlobalSP)
                objDB.AddInParameter(objCMD, "@IS_UPDATE_SP_JOB_PKG", DbType.Boolean, IsUpdateSPJobPackage)
                If Barcode_Number <> Nothing Then
                    objDB.AddInParameter(objCMD, "@BARCODE", DbType.String, Barcode_Number)
                Else
                    objDB.AddInParameter(objCMD, "@BARCODE", DbType.String, DBNull.Value)
                End If
                objDB.AddOutParameter(objCMD, "@OV_RETVALUE", DbType.String, 20)
                objDB.ExecuteNonQuery(objCMD)
                DBSuccess = objDB.GetParameterValue(objCMD, "@OV_RETVALUE").ToString
            End Using

        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Sub DeleteGlobalSparePart()
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_DELETE_GLOBALSPAREPART_NEW")
                objDB.AddInParameter(objCMD, "@ID_SUPPLIER", DbType.String, SupplierID)
                objDB.AddInParameter(objCMD, "@SUPP_CURRENTNO", DbType.String, SuppCurrNo)
                objDB.AddOutParameter(objCMD, "@OV_RETVALUE", DbType.String, 20)
                objDB.ExecuteNonQuery(objCMD)
                DBSuccess = objDB.GetParameterValue(objCMD, "@OV_RETVALUE").ToString
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub SaveGlobalEnvFee()
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_GLOBAL_ENV_FEES")
                objDB.AddInParameter(objCMD, "@SUPP_CURR_NO", DbType.String, SuppCurrNo)
                objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, CreatedBy)
                objDB.AddInParameter(objCMD, "@DESC_NEW", DbType.String, ItemDescription)
                objDB.ExecuteNonQuery(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try


    End Sub
End Class
