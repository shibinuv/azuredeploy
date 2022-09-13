Imports System.Data.Common
Imports System.Data.SqlClient
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Public Class SupplierImportConfigDO
    Private _id_supp_import As Integer = 0
    Private _id_supplier As Integer = 0
    Private _field_name As String = String.Empty
    Private _start_num As Integer = 0
    Private _end_num As Integer = 0
    Private _created_By As String = String.Empty
    Private _dt_Created As DateTime = Now.Today()
    Private _modified_By As String = String.Empty
    Private _dt_Modified As DateTime = Now.Today()
    Private _fileMode As String = String.Empty
    Private _delimiter As String = String.Empty
    Private _orderOfFile As Integer = 0
    Private _layout_name As String = String.Empty
    Private _remove_start_zero As Boolean = False
    Private _remove_blank_field As Boolean = False
    Private _divide_price_by_hundred As Boolean = False
    Private _pricefile_dec_sep As String
    Dim objDB As Database
    Dim ConnectionString As String
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
    Public Property SupplierImportId() As Integer
        Get
            Return _id_supp_import
        End Get
        Set(ByVal value As Integer)
            _id_supp_import = value
        End Set
    End Property

    Public Property SupplierId() As Integer
        Get
            Return _id_supplier
        End Get
        Set(ByVal value As Integer)
            _id_supplier = value
        End Set
    End Property

    Public Property StartNumber() As Integer
        Get
            Return _start_num
        End Get
        Set(ByVal value As Integer)
            _start_num = value
        End Set
    End Property

    Public Property EndNumber() As Integer
        Get
            Return _end_num
        End Get
        Set(ByVal value As Integer)
            _end_num = value
        End Set
    End Property

    Public Property FieldName() As String
        Get
            Return _field_name
        End Get
        Set(ByVal value As String)
            _field_name = value
        End Set
    End Property

    Public Property CreateBy() As String
        Get
            Return _created_By
        End Get
        Set(ByVal value As String)
            _created_By = value
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
            Return _modified_By
        End Get
        Set(ByVal value As String)
            _modified_By = value
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
    ''' <summary>
    ''' Gets the list of suppliers.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function GetSuppliersList() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_SUPPLIER_LIST")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Function GetDataForGrid(ByVal idSupplier As Integer) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_SUPP_IMPORT")
                objDB.AddInParameter(objcmd, "@ID_SUPPLIER", DbType.Int32, idSupplier)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    ''' <summary>
    ''' Saves the modified supplier configuration details.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ModifyConfig() As String
        Dim status As String = String.Empty
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_MODIFY_SUPP_IMPORT")
                objDB.AddInParameter(objcmd, "@ID_SUPP_IMPORT", DbType.Int32, SupplierImportId)
                objDB.AddInParameter(objcmd, "@StartNo", DbType.Int32, StartNumber)
                objDB.AddInParameter(objcmd, "@EndNo", DbType.Int32, EndNumber)
                objDB.AddInParameter(objcmd, "@ModifyBy", DbType.String, ModifyBy)
                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 100)
                objDB.AddInParameter(objcmd, "@OrderNo", DbType.Int32, OrderOfFile)
                objDB.ExecuteNonQuery(objcmd)
                status = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
            End Using
        Catch ex As Exception
            Throw ex
        End Try

        Return status
    End Function

    Public Function SaveConfig() As String
        Dim status As String = String.Empty
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ADD_SUPP_IMPORT")
                objDB.AddInParameter(objcmd, "@Id_Supplier", DbType.Int32, SupplierId)
                objDB.AddInParameter(objcmd, "@StartNo", DbType.Int32, StartNumber)
                objDB.AddInParameter(objcmd, "@EndNo", DbType.Int32, EndNumber)
                objDB.AddInParameter(objcmd, "@Field_Name", DbType.String, FieldName)
                objDB.AddInParameter(objcmd, "@CreatedBy", DbType.String, CreateBy)
                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 100)
                objDB.AddInParameter(objcmd, "@Order_Of_file", DbType.Int32, OrderOfFile)
                objDB.AddInParameter(objcmd, "@FileMode", DbType.String, FileMode)
                objDB.AddInParameter(objcmd, "@Delimiter", DbType.String, Delimiter)
                objDB.AddInParameter(objcmd, "@SUPP_LAYOUT_NAME", DbType.String, LayoutName)
                objDB.AddInParameter(objcmd, "@REMOVE_START_ZERO", DbType.Boolean, RemoveStartZero)
                objDB.AddInParameter(objcmd, "@REMOVE_BLANK_FIELD", DbType.Boolean, RemoveBlankField)
                objDB.AddInParameter(objcmd, "@DIVIDE_PRICE_BY_HUNDRED", DbType.Boolean, DividePriceByHundred)
                objDB.AddInParameter(objcmd, "@PRICE_FILE_DEC_SEP", DbType.String, PriceFileDecimalSeperator)
                objDB.ExecuteNonQuery(objcmd)
                status = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
            End Using
        Catch ex As Exception
            Throw ex
        End Try
        Return status
    End Function
    Public Function DeleteConfig() As String
        Dim status As String = String.Empty
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DELETE_SUPP_IMPORT")
                objDB.AddInParameter(objcmd, "@ID_SUPP_IMPORT", DbType.Int32, SupplierImportId)
                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 100)
                objDB.ExecuteNonQuery(objcmd)
                status = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
            End Using
        Catch ex As Exception
            Throw ex
        End Try
        Return status
    End Function
End Class
