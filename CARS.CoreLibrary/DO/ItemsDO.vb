Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Imports Newtonsoft.Json
Imports CARS.CoreLibrary.CARS
Imports CARS.CoreLibrary

Public Class ItemsDO
    Shared commonUtil As New Utilities.CommonUtility
    Dim ConnectionString As String
    Dim objDB As Database
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
    Public Function Fetch_Item_Details(ByVal objItem As ItemsBO) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_ITEM_FETCH")
                objDB.AddInParameter(objCMD, "@ID_ITEM_ID", DbType.String, objItem.ID_ITEM)
                objDB.AddInParameter(objCMD, "@ID_ITEM_MAKE", DbType.String, objItem.ID_MAKE)
                objDB.AddInParameter(objCMD, "@ID_ITEM_WH", DbType.String, objItem.ID_WH_ITEM)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function LoadMakeCodes() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_CONFIG_MAKE_FETCH")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function LoadCategory(ByVal q As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_CONFIG_CATEGORY_FETCH")
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, q)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function LoadUnitItem() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_ARTICLE_UNITMEAS")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function SparePart_Search(ByVal sparePart As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_SEARCH")
                objDB.AddInParameter(objCMD, "@ID_SEARCH", DbType.String, sparePart)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Supplier_Search(ByVal supplier As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_SUPPLIER_LIST")
                objDB.AddInParameter(objCMD, "@ID_SEARCH", DbType.String, supplier)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Fetch_SparePart_Details(ByVal sparePartId As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_SPAREPART_DETAILS")
                objDB.AddInParameter(objcmd, "@ID_SPARE", DbType.String, sparePartId)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function saveNewItem(ByVal supplier As String, ByVal item_catg As String, ByVal id_item As String, ByVal item_desc As String, ByVal id_wh As String, ByVal login As String) As String
        Try
            Dim strStatus As String

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_INSERT_NEW")

                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@ITEM_DESC", DbType.String, item_desc)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, item_catg)
                objDB.AddInParameter(objcmd, "@CREATED_BY", DbType.String, login)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@ID_WH_ITEM", DbType.String, id_wh)

                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = "123"


                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function Insert_SparePart(ByVal objItem As ItemsBO, ByVal login As String) As String
        Try
            Dim strStatus As String

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_INSERT")
                'objDB.AddInParameter(objcmd, "@IV_VEH_REG_NO", DbType.String, objCustBO.VehRegNo)
                'objDB.AddInParameter(objcmd, "@CUST_CREDIT_LIMIT", DbType.Decimal, objCustBO.CUST_CREDIT_LIMIT)

                'objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)
                'objDB.AddOutParameter(objcmd, "@OI_ID_VEH_SEQ", DbType.String, 50)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, objItem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@ITEM_DESC", DbType.String, objItem.ITEM_DESC)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, objItem.ID_ITEM_CATG)
                objDB.AddInParameter(objcmd, "@CREATED_BY", DbType.String, login)
                objDB.AddInParameter(objcmd, "@MODIFIED_BY", DbType.String, login)
                objDB.AddInParameter(objcmd, "@ID_MAKE", DbType.String, objItem.ID_MAKE)
                objDB.AddInParameter(objcmd, "@ID_WH_ITEM", DbType.String, objItem.ID_WH_ITEM)
                objDB.AddInParameter(objcmd, "@ID_SUPPLIER_ITEM", DbType.String, objItem.ID_SUPPLIER_ITEM)
                'objDB.AddInParameter(objcmd, "@ITEM_DISC_CODE", DbType.String, objItem.ITEM_DISC_CODE_BUY)
                If objItem.ITEM_DISC_CODE_BUY = "" Then
                    objDB.AddInParameter(objcmd, "@ITEM_DISC_CODE_BUY", DbType.String, "")
                Else
                    objDB.AddInParameter(objcmd, "@ITEM_DISC_CODE_BUY", DbType.String, objItem.ITEM_DISC_CODE_BUY)
                End If
                objDB.AddInParameter(objcmd, "@LOCATION", DbType.String, objItem.LOCATION)
                objDB.AddInParameter(objcmd, "@ALT_LOCATION", DbType.String, objItem.ALT_LOCATION)
                objDB.AddInParameter(objcmd, "@WEIGHT", DbType.String, objItem.WEIGHT)
                'objDB.AddInParameter(objcmd, "@ITEM_AVAIL_QTY", DbType.String, objItem.ITEM_AVAIL_QTY)
                If objItem.ITEM_AVAIL_QTY.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@ITEM_AVAIL_QTY", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@ITEM_AVAIL_QTY", DbType.Decimal, objItem.ITEM_AVAIL_QTY)
                End If
                objDB.AddInParameter(objcmd, "@ANNOTATION", DbType.String, objItem.ANNOTATION)
                If objItem.BASIC_PRICE.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@BASIC_PRICE", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@BASIC_PRICE", DbType.String, objItem.BASIC_PRICE)
                End If
                If objItem.COST_PRICE1.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@COST_PRICE1", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@COST_PRICE1", DbType.String, objItem.COST_PRICE1)
                End If
                If objItem.AVG_PRICE.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@AVG_PRICE", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@AVG_PRICE", DbType.String, objItem.AVG_PRICE)
                End If
                If objItem.NET_PRICE.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@NET_PRICE", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@NET_PRICE", DbType.String, objItem.NET_PRICE)
                End If
                If objItem.ITEM_PRICE.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@ITEM_PRICE", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@ITEM_PRICE", DbType.String, objItem.ITEM_PRICE)
                End If
                objDB.AddInParameter(objcmd, "@FLG_STOCKITEM", DbType.String, objItem.FLG_STOCKITEM)
                objDB.AddInParameter(objcmd, "@FLG_OBSOLETE_SPARE", DbType.String, objItem.FLG_OBSOLETE_SPARE)
                objDB.AddInParameter(objcmd, "@FLG_SAVE_TO_NONSTOCK", DbType.String, objItem.FLG_SAVE_TO_NONSTOCK)
                objDB.AddInParameter(objcmd, "@FLG_LABELS", DbType.String, objItem.FLG_LABELS)
                objDB.AddInParameter(objcmd, "@FLG_VAT_INCL", DbType.String, objItem.FLG_VAT_INCL)
                objDB.AddInParameter(objcmd, "@FLG_BLOCK_AUTO_ORD", DbType.String, objItem.FLG_BLOCK_AUTO_ORD)
                objDB.AddInParameter(objcmd, "@FLG_ALLOW_DISCOUNT", DbType.String, objItem.FLG_ALLOW_DISCOUNT)
                objDB.AddInParameter(objcmd, "@DEPOSITREFUND_ID_ITEM", DbType.String, objItem.DEPOSITREFUND_ID_ITEM)       'PANT'
                objDB.AddInParameter(objcmd, "@DEPOSITREFUND_SUPP_CURRENTNO", DbType.String, objItem.DEPOSITREFUND_SUPP_CURRENTNO) 'PANT'

                objDB.AddInParameter(objcmd, "@ENV_ID_iTEM", DbType.String, objItem.ENV_ID_ITEM)      'SUBNR'
                objDB.AddInParameter(objcmd, "@ENV_ID_MAKE", DbType.String, objItem.ENV_ID_MAKE) 'SUBNR'
                objDB.AddInParameter(objcmd, "@ENV_ID_WAREHOUSE", DbType.String, objItem.ENV_ID_WAREHOUSE)       'SUBNR'



                objDB.AddInParameter(objcmd, "@FLG_AUTO_ARRIVAL", DbType.String, objItem.FLG_AUTO_ARRIVAL)
                objDB.AddInParameter(objcmd, "@FLG_OBTAIN_SPARE", DbType.String, objItem.FLG_OBTAIN_SPARE)
                objDB.AddInParameter(objcmd, "@FLG_AUTOADJUST_PRICE", DbType.String, objItem.FLG_AUTOADJUST_PRICE)
                objDB.AddInParameter(objcmd, "@FLG_REPLACEMENT_PURCHASE", DbType.String, objItem.FLG_REPLACEMENT_PURCHASE)
                objDB.AddInParameter(objcmd, "@FLG_EFD", DbType.String, objItem.FLG_EFD)
                If objItem.DISCOUNT.ToString.Length > 0 Then
                    objDB.AddInParameter(objcmd, "@DISCOUNT", DbType.String, objItem.DISCOUNT)
                End If
                objDB.AddInParameter(objcmd, "@ID_UNIT_ITEM", DbType.String, objItem.ID_UNIT_ITEM)
                objDB.AddInParameter(objcmd, "@PACKAGE_QTY", DbType.String, objItem.PACKAGE_QTY)
                If objItem.MIN_STOCK.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@MIN_STOCK", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@MIN_STOCK", DbType.Decimal, objItem.MIN_STOCK)
                End If
                If objItem.MAX_PURCHASE.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@MAX_PURCHASE", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@MAX_PURCHASE", DbType.Decimal, objItem.MAX_PURCHASE)
                End If
                If objItem.MIN_PURCHASE.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@MIN_PURCHASE", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@MIN_PURCHASE", DbType.Decimal, objItem.MIN_PURCHASE)
                End If
                If objItem.CONSUMPTION_ESTIMATED.ToString = "" Then
                    objDB.AddInParameter(objcmd, "@CONSUMPTION_ESTIMATED", DbType.Decimal, 0.0)
                Else
                    objDB.AddInParameter(objcmd, "@CONSUMPTION_ESTIMATED", DbType.Decimal, objItem.CONSUMPTION_ESTIMATED)
                End If
                objDB.AddInParameter(objcmd, "@BARCODE_NUMBER", DbType.String, objItem.BARCODE_NUMBER)
                objDB.AddInParameter(objcmd, "@TEXT", DbType.String, objItem.TEXT)

                objDB.AddInParameter(objcmd, "@ACCOUNT_CODE", DbType.String, objItem.ACCOUNT_CODE)
                objDB.AddOutParameter(objcmd, "@RETVAL", DbType.String, 10)
                objDB.AddOutParameter(objcmd, "@RETSPARE", DbType.String, 15)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    'strStatus = "123"
                    strStatus = objDB.GetParameterValue(objcmd, "@RETVAL").ToString + ";" + objDB.GetParameterValue(objcmd, "@RETSPARE").ToString

                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Friend Function get_campaignprices(id_item As String, suppcurrentno As String) As DataSet

        Try

            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ITEM_CAMPAIGNPRICE_GET")
                objDB.AddInParameter(objCMD, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objCMD, "@SUPP_CURRENTNO", DbType.String, suppcurrentno)

                Return objDB.ExecuteDataSet(objCMD)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Friend Function addCampaignPrice(ByVal suppcurrentno As String, ByVal id_item As String, ByVal start_date As String, ByVal end_date As String, ByVal price As String, ByVal login As String) As String

        Try
            Dim strStatus As String

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ITEM_CAMPAIGNPRICE_INSERT")

                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, suppcurrentno)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@START_DATE", DbType.String, start_date)
                objDB.AddInParameter(objcmd, "@END_DATE", DbType.String, end_date)
                objDB.AddInParameter(objcmd, "@CAMPAIGN_PRICE", DbType.String, price)
                objDB.AddInParameter(objcmd, "@CREATED_BY", DbType.String, login)

                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = "123"


                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus

        Catch ex As Exception
            Throw ex
        End Try

    End Function


    Public Function FetchItemsHistory(ByVal ID_ITEM As String, ID_MAKE As String, ID_WAREHOUSE As Integer) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_ITEM_HISTORY")
                objDB.AddInParameter(objcmd, "@ID_ITEM ", DbType.String, ID_ITEM)
                objDB.AddInParameter(objcmd, "@ID_MAKE ", DbType.String, ID_MAKE)
                objDB.AddInParameter(objcmd, "@ID_WAREHOUSE ", DbType.Int32, ID_WAREHOUSE)
                'test
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetEditMake(ByVal makeId As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_GET_MAS_EDITMAKE")
                objDB.AddInParameter(objcmd, "@ID_MAKE", DbType.String, makeId)
                Return objDB.ExecuteDataSet(objcmd)

            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Fetch_VATCode() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_VATCODE")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Fetch_EnvSparePart_Details(ByVal sparePartId As String, ByVal name As String, ByVal userId As String, ByVal idWh As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_ENVSEARCHDETAILS")
                objDB.AddInParameter(objcmd, "@SPAREPART", DbType.String, sparePartId)
                objDB.AddInParameter(objcmd, "@NAME", DbType.String, name)
                objDB.AddInParameter(objcmd, "@IV_ID_LOGIN", DbType.String, userId)
                objDB.AddInParameter(objcmd, "@ID_WH", DbType.String, idWh)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Save_EnvFeeSettings(ByVal objItem As ItemsBO) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_ENVFEESETTINGS")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, objItem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@FLG_ENVFEE", DbType.String, Convert.ToBoolean(objItem.FLG_EFD))
                objDB.AddInParameter(objcmd, "@MIN_AMT", DbType.Decimal, objItem.MIN_AMT)
                objDB.AddInParameter(objcmd, "@MAX_AMT", DbType.Decimal, objItem.MAX_AMT)
                objDB.AddInParameter(objcmd, "@ADDED_FEE_PERCENTAGE", DbType.Decimal, objItem.ADDED_FEE_PERC)
                objDB.AddInParameter(objcmd, "@NAME", DbType.String, objItem.ENV_NAME)
                objDB.AddInParameter(objcmd, "@VAT_CODE", DbType.String, objItem.ENV_VATCODE)
                objDB.AddInParameter(objcmd, "@CREATED_BY", DbType.String, objItem.CREATED_BY)
                objDB.AddInParameter(objcmd, "@ID_MAKE", DbType.String, objItem.ENV_ID_MAKE)
                objDB.AddInParameter(objcmd, "@ID_WAREHOUSE", DbType.String, objItem.ENV_ID_WAREHOUSE)
                objDB.AddOutParameter(objcmd, "@FLG_RETURN", DbType.String, 10)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@FLG_RETURN").ToString + "," + objDB.GetParameterValue(objcmd, "@FLG_RETURN").ToString
                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Delete_EnvSparePart_Details(ByVal sparePartId As String, ByVal spMake As String, ByVal idWh As String) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_Del_EnvFeeDetails")
                objDB.AddInParameter(objcmd, "@SPNO", DbType.String, sparePartId)
                objDB.AddInParameter(objcmd, "@Make", DbType.String, spMake)
                objDB.AddInParameter(objcmd, "@WareHouseid", DbType.String, idWh)
                objDB.AddOutParameter(objcmd, "@FLG_RETURN", DbType.String, 10)
                objDB.ExecuteNonQuery(objcmd)
                strStatus = objDB.GetParameterValue(objcmd, "@FLG_RETURN").ToString + "," + objDB.GetParameterValue(objcmd, "@FLG_RETURN").ToString
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function LoadSupplier(ByVal supplier As String, ByVal login As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_BO_SUPPLIER_FETCH")
                objDB.AddInParameter(objcmd, "@IV_CUST", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@IV_ID_LOGIN", DbType.String, login)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function LoadDiscCodes(ByVal supplier As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DISCOUNTCODE_FETCH")
                objDB.AddInParameter(objcmd, "@DISCOUNTCODE", DbType.String, IIf(supplier = "", Nothing, supplier))
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function LoadSparePartCategory() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPARTCATG_FETCH")
                objDB.AddInParameter(objcmd, "@IV_Lang", DbType.String, System.Configuration.ConfigurationManager.AppSettings("Language").ToString())
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function AddSpCatgDetails(ByVal objItem As ItemsBO) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPARTCATG_INSERT")
                objDB.AddInParameter(objcmd, "@ID_DISCOUNTCODEBUY", DbType.Int32, objItem.ID_ITEM_DISC_CODE_BUYING)
                objDB.AddInParameter(objcmd, "@ID_DISCOUNTCODESELL", DbType.Int32, objItem.ID_ITEM_DISC_CODE_SELL)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, objItem.SUPP_CURRENTNO) 'ID_SUPPLIER_ITEM
                objDB.AddInParameter(objcmd, "@ID_MAKE", DbType.String, objItem.ID_SUPPLIER_ITEM) 'ID_MAKE 
                objDB.AddInParameter(objcmd, "@CATEGORY", DbType.String, objItem.CATEGORY)
                objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, objItem.DESCRIPTION)
                objDB.AddInParameter(objcmd, "@INITIALCLASSCODE", DbType.String, objItem.INITIALCLASSCODE)
                objDB.AddInParameter(objcmd, "@VATCODE", DbType.String, objItem.ID_VAT_CODE)
                objDB.AddInParameter(objcmd, "@ACCOUNTCODE", DbType.String, objItem.ACCOUNT_CODE)
                objDB.AddInParameter(objcmd, "@FLG_ALLOWBO", DbType.Boolean, objItem.FLG_ALLOW_BCKORD)
                objDB.AddInParameter(objcmd, "@FLG_COUNTSTOCK", DbType.Boolean, objItem.FLG_CNT_STOCK)
                objDB.AddInParameter(objcmd, "@FLG_ALLOWCLASS", DbType.Boolean, objItem.FLG_ALLOW_CLASSIFICATION)
                objDB.AddInParameter(objcmd, "@CREATEDBY", DbType.String, objItem.CREATED_BY)
                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.Boolean, 1)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 100)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString + "," + objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function UpdSpCatgDetails(ByVal objItem As ItemsBO) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPARTCATG_MODIFY")
                objDB.AddInParameter(objcmd, "@ID_DISCOUNTCODEBUY", DbType.Int32, objItem.ID_ITEM_DISC_CODE_BUYING)
                objDB.AddInParameter(objcmd, "@ID_DISCOUNTCODESELL", DbType.Int32, objItem.ID_ITEM_DISC_CODE_SELL)
                objDB.AddInParameter(objcmd, "@ID_SUPPLIER", DbType.Int32, objItem.ID_SUPPLIER_ITEM)
                objDB.AddInParameter(objcmd, "@ID_MAKE", DbType.String, objItem.SUPP_CURRENTNO) 'ID_MAKE
                objDB.AddInParameter(objcmd, "@CATEGORY", DbType.String, objItem.CATEGORY)
                objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, objItem.DESCRIPTION)
                objDB.AddInParameter(objcmd, "@INITIALCLASSCODE", DbType.String, objItem.INITIALCLASSCODE)
                objDB.AddInParameter(objcmd, "@VATCODE", DbType.String, objItem.ID_VAT_CODE)
                objDB.AddInParameter(objcmd, "@ACCOUNTCODE", DbType.String, objItem.ACCOUNT_CODE)
                objDB.AddInParameter(objcmd, "@FLG_ALLOWBO", DbType.Boolean, objItem.FLG_ALLOW_BCKORD)
                objDB.AddInParameter(objcmd, "@FLG_COUNTSTOCK", DbType.Boolean, objItem.FLG_CNT_STOCK)
                objDB.AddInParameter(objcmd, "@FLG_ALLOWCLASS", DbType.Boolean, objItem.FLG_ALLOW_CLASSIFICATION)
                objDB.AddInParameter(objcmd, "@MODIFIEDBY", DbType.String, objItem.CREATED_BY)
                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.Boolean, 10)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 100)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString + "," + objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function SparePart_Search_Only_SparePart(q As String) As DataSet
        Try


            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_SEARCH_ONLY_SPAREPART")
                objDB.AddInParameter(objCMD, "@ID_ITEM", DbType.String, q)

                Return objDB.ExecuteDataSet(objCMD)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function DeleteSpCatgDet(ByVal idItemCatg As String) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPARTCATG_DELETE")
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, idItemCatg)
                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.Boolean, 10)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 100)
                objDB.ExecuteNonQuery(objcmd)
                strStatus = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString + "," + objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function AddDiscCodeDetails(ByVal objItem As ItemsBO) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DISCOUNTCODE_INSERT")
                objDB.AddInParameter(objcmd, "@ID_MAKE", DbType.String, objItem.SUPPLIER_NUMBER)
                objDB.AddInParameter(objcmd, "@DISCOUNTCODE", DbType.String, objItem.ITEM_DISC_CODE_BUYING)
                objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, objItem.DESCRIPTION)
                objDB.AddInParameter(objcmd, "@CREATED_BY", DbType.String, objItem.CREATED_BY)
                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.Boolean, 10)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 200)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString + "," + objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function UpdDiscCodeDetails(ByVal objItem As ItemsBO) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DISCOUNTCODE_MODIFY")
                objDB.AddInParameter(objcmd, "@ID_MAKE", DbType.String, objItem.SUPPLIER_NUMBER)
                objDB.AddInParameter(objcmd, "@DISCOUNTCODE", DbType.String, objItem.ITEM_DISC_CODE_BUYING)
                objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, objItem.DESCRIPTION)
                objDB.AddInParameter(objcmd, "@MODIFIED_BY", DbType.String, objItem.CREATED_BY)
                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.Boolean, 10)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 200)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString + "," + objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function DeleteDiscCodeDetails(ByVal idItemCatg As String) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_DISCOUNTCODE_DELETE")
                objDB.AddInParameter(objcmd, "@ID_DISCOUNTCODE", DbType.String, idItemCatg)
                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.Boolean, 10)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 200)
                objDB.ExecuteNonQuery(objcmd)
                strStatus = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString + "," + objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function SparePart_Popup(ByVal sparePart As String, ByVal mustHaveQuantity As String, ByVal isStockItem As String, ByVal isNotStockItem As String, ByVal loc As String, ByVal supp As String, ByVal nonStock As Boolean, ByVal accurateSearch As String) As DataSet
        Try
            If (nonStock) Then
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_SEARCH_POPUP_NONSTOCK")
                    objDB.AddInParameter(objCMD, "@ID_SEARCH", DbType.String, sparePart)
                    objDB.AddInParameter(objCMD, "@SUPPLIER", DbType.String, supp)
                    Return objDB.ExecuteDataSet(objCMD)
                End Using
            Else
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_SEARCH_POPUP")
                    objDB.AddInParameter(objCMD, "@ID_SEARCH", DbType.String, sparePart)
                    objDB.AddInParameter(objCMD, "@ID_MUSTHAVEQUANTITY", DbType.Boolean, mustHaveQuantity)
                    objDB.AddInParameter(objCMD, "@ID_ISSTOCKITEM", DbType.Boolean, isStockItem)
                    objDB.AddInParameter(objCMD, "@ID_ISNOTSTOCKITEM", DbType.Boolean, isNotStockItem)
                    objDB.AddInParameter(objCMD, "@LOCATION", DbType.String, loc)
                    objDB.AddInParameter(objCMD, "@SUPPLIER", DbType.String, supp)
                    objDB.AddInParameter(objCMD, "@ACCURATESEARCH", DbType.Boolean, accurateSearch)

                    Return objDB.ExecuteDataSet(objCMD)
                End Using
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function return_item(ByVal returned_item As ItemsBO) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_STOCK_ADJUSTMENT_UPDATE_QTY")


                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, returned_item.STOCK_ADJ_ID_ITEM)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, returned_item.STOCK_ADJ_SUPPLIER)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, returned_item.STOCK_ADJ_CATG)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, returned_item.STOCK_ADJ_WAREHOUSE)
                objDB.AddInParameter(objcmd, "@OLDQTY", DbType.Int32, returned_item.STOCK_ADJ_OLD_QTY)
                objDB.AddInParameter(objcmd, "@CHANGEDQTY", DbType.Int32, returned_item.STOCK_ADJ_CHANGED_QTY)
                objDB.AddInParameter(objcmd, "@NEWQTY", DbType.Int32, returned_item.STOCK_ADJ_NEW_QTY)
                objDB.AddInParameter(objcmd, "@SIGNATURE", DbType.String, returned_item.STOCK_ADJ_SIGNATURE)
                objDB.AddInParameter(objcmd, "@COMMENT", DbType.String, returned_item.STOCK_ADJ_TEXT)
                objDB.AddInParameter(objcmd, "@TYPE", DbType.String, returned_item.STOCK_ADJ_TYPE)
                objDB.AddInParameter(objcmd, "@ADJ_NO", DbType.String, returned_item.STOCK_ADJ_NO)






                Try
                    objDB.ExecuteNonQuery(objcmd)

                    'strStatus = objDB.GetParameterValue(objcmd, "@RETVAL").ToString + ";" + objDB.GetParameterValue(objcmd, "@RETSPARE").ToString
                    strStatus = 1
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return strStatus

        Catch ex As Exception
            Throw
        End Try



    End Function

    Public Function SaveImportableItem(ByVal ItemImportable As ItemImportableBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_IMPORT_LIST_INSERT")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, ItemImportable.ID_ITEM)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, ItemImportable.ID_ITEM_CATG)
                objDB.AddInParameter(objcmd, "@QUANTITY", DbType.Decimal, ItemImportable.QUANTITY)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, ItemImportable.SUPP_CURRENTNO)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.Int32, ItemImportable.WAREHOUSE)
                objDB.AddInParameter(objcmd, "@PURCHASE_TYPE", DbType.String, ItemImportable.PURCHASE_TYPE)
                objDB.AddInParameter(objcmd, "@MODULE", DbType.String, ItemImportable.MODULETYPE)
                objDB.AddInParameter(objcmd, "@ORDERPREFIX", DbType.String, ItemImportable.ORDERPREFIX)
                objDB.AddInParameter(objcmd, "@ORDERNUMBER", DbType.String, ItemImportable.ORDERNUMBER)
                objDB.AddInParameter(objcmd, "@ORDERSEQ", DbType.Int64, ItemImportable.ORDERSEQ)
                objDB.AddInParameter(objcmd, "@ORDERLINE", DbType.String, ItemImportable.ORDERLINE)
                objDB.AddInParameter(objcmd, "@FLG_IMPORTED", DbType.Boolean, ItemImportable.FLG_IMPORTED)


                Try
                    objDB.ExecuteNonQuery(objcmd)

                    'strStatus = objDB.GetParameterValue(objcmd, "@RETVAL").ToString + ";" + objDB.GetParameterValue(objcmd, "@RETSPARE").ToString
                    strStatus = 1
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return strStatus

        Catch ex As Exception
            Throw
        End Try



    End Function

    Public Function AddReplacements(ByVal mainItem As String, ByVal prevItem As String, ByVal newItem As String, ByVal suppCurrentno As String, ByVal login As String) As String
        Try
            Dim strStatus As String

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_REPLACEMENT_INSERT")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@MAIN_ITEM", DbType.String, mainItem)
                objDB.AddInParameter(objcmd, "@PREV_ITEM", DbType.String, prevItem)
                objDB.AddInParameter(objcmd, "@NEW_ITEM", DbType.String, newItem)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, suppCurrentno)

                objDB.AddOutParameter(objcmd, "@RET_VAL", DbType.String, 200)
                Try
                    objDB.ExecuteNonQuery(objcmd)

                    strStatus = objDB.GetParameterValue(objcmd, "@RET_VAL").ToString
                    'strStatus = 1
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return strStatus

        Catch ex As Exception
            Throw
        End Try



    End Function

    Public Function Add_PO_Item(ByVal POitem As PurchaseOrderItemsBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_ADD_POITEM")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@ID_PO", DbType.String, POitem.ID_PO)
                objDB.AddInParameter(objcmd, "@POPREFIX", DbType.String, POitem.POPREFIX)
                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, POitem.PONUMBER)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, POitem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@ITEM_DESC", DbType.String, POitem.ITEM_DESC)
                objDB.AddInParameter(objcmd, "@ITEM_CATG_DESC", DbType.String, POitem.ITEM_CATG_DESC)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, POitem.ID_ITEM_CATG)
                objDB.AddInParameter(objcmd, "@ORDERQTY", DbType.Decimal, POitem.ORDERQTY)
                objDB.AddInParameter(objcmd, "@COST_PRICE1", DbType.Decimal, POitem.COST_PRICE1)
                objDB.AddInParameter(objcmd, "@ITEM_PRICE", DbType.Decimal, POitem.ITEM_PRICE)
                objDB.AddInParameter(objcmd, "@BASIC_PRICE", DbType.Decimal, POitem.BASIC_PRICE)
                objDB.AddInParameter(objcmd, "@NET_PRICE", DbType.Decimal, POitem.NET_PRICE)
                objDB.AddInParameter(objcmd, "@TOTALCOST", DbType.Decimal, POitem.TOTALCOST)
                objDB.AddInParameter(objcmd, "@BACKORDERQTY", DbType.Decimal, POitem.BACKORDERQTY)
                objDB.AddInParameter(objcmd, "@CONFIRMQTY", DbType.Decimal, POitem.CONFIRMQTY)
                objDB.AddInParameter(objcmd, "@DELIVERED", DbType.Boolean, POitem.DELIVERED)
                objDB.AddInParameter(objcmd, "@ANNOTATION", DbType.String, POitem.ANNOTATION)
                objDB.AddInParameter(objcmd, "@REST_FLG", DbType.Boolean, POitem.REST_FLG)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, POitem.SUPP_CURRENTNO)

                If POitem.ID_WOITEM_SEQ = "" Then
                    objDB.AddInParameter(objcmd, "@ID_WOITEM_SEQ", DbType.Int64, -1)

                Else
                    objDB.AddInParameter(objcmd, "@ID_WOITEM_SEQ", DbType.Int64, POitem.ID_WOITEM_SEQ)
                End If

                Try
                    objDB.ExecuteNonQuery(objcmd)


                    strStatus = 1
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return strStatus

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try



    End Function


    Public Function Fetch_replacement_items(ByVal id_item As String, ByVal supplier As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_REPLACEMENTITEMS")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supplier)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function


    Public Function Fetch_Orders(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ITEM_FETCH_SOLD_GRID")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, catg)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, "1")
                objDB.AddInParameter(objcmd, "@FUNCTION_VALUE", DbType.String, functionValue)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function
    Public Function Fetch_PurchaseOrders(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ITEM_FETCH_SOLD_GRID")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, catg)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, "1")
                objDB.AddInParameter(objcmd, "@FUNCTION_VALUE", DbType.String, functionValue)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function
    Public Function Fetch_StockAdjustments(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ITEM_FETCH_SOLD_GRID")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, catg)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, "1")
                objDB.AddInParameter(objcmd, "@FUNCTION_VALUE", DbType.String, functionValue)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function UpdateStockAdjustmentValue(ByVal id_item As String, ByVal supplier As String, ByVal category As String, ByVal warehouse As String, ByVal oldqty As String, ByVal changedqty As String, ByVal newqty As String, ByVal signature As String, ByVal comment As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_STOCK_ADJUSTMENT_UPDATE_QTY")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, category)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, warehouse)
                objDB.AddInParameter(objcmd, "@OLDQTY", DbType.Decimal, oldqty)
                objDB.AddInParameter(objcmd, "@CHANGEDQTY", DbType.Decimal, changedqty)
                objDB.AddInParameter(objcmd, "@NEWQTY", DbType.Decimal, newqty)
                objDB.AddInParameter(objcmd, "@SIGNATURE", DbType.String, signature)
                objDB.AddInParameter(objcmd, "@COMMENT", DbType.String, comment)
                objDB.AddInParameter(objcmd, "@ADJ_NO", DbType.String, "")
                objDB.AddInParameter(objcmd, "@TYPE", DbType.String, "MANUELT")

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function
    Public Function UpdateStockQty(ByVal id_item As String, ByVal supplier As String, ByVal category As String, ByVal warehouse As String, ByVal newqty As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_STOCK_ADJUSTMENT_STOCK_UPDATE")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, category)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, warehouse)
                objDB.AddInParameter(objcmd, "@NEWQTY", DbType.Decimal, newqty)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function UpdatePriceAdjustment(ByVal id_item As String, ByVal supplier As String, ByVal category As String, ByVal warehouse As String, ByVal oldprice As Decimal, ByVal changedprice As Decimal, ByVal newprice As Decimal, ByVal signature As String, ByVal comment As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PRICE_ADJUSTMENT_UPDATE")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, category)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, warehouse)
                objDB.AddInParameter(objcmd, "@OLDPRICE", DbType.Decimal, oldprice)
                objDB.AddInParameter(objcmd, "@CHANGEDPRICE", DbType.Decimal, changedprice)
                objDB.AddInParameter(objcmd, "@NEWPRICE", DbType.Decimal, newprice)
                objDB.AddInParameter(objcmd, "@SIGNATURE", DbType.String, signature)
                objDB.AddInParameter(objcmd, "@COMMENT", DbType.String, comment)


                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function
    Public Function Fetch_PriceAdjustments(ByVal id_item As String, ByVal supplier As String, ByVal catg As String, ByVal functionValue As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ITEM_FETCH_SOLD_GRID")
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, catg)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, "1")
                objDB.AddInParameter(objcmd, "@FUNCTION_VALUE", DbType.String, functionValue)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function Fetch_DiscountCodes(ByVal q As String, ByVal supplier As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_DISCOUNTCODES")
                objDB.AddInParameter(objCMD, "@ID_SEARCH", DbType.String, q)
                objDB.AddInParameter(objCMD, "@SUPPLIER", DbType.String, supplier)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function FetchBasicCalcVal(ByVal discount As String, ByVal supplier As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_ITEM_FETCH_BASIC_CALCULATION_VALUE")
                objDB.AddInParameter(objcmd, "@DISCOUNT", DbType.String, discount)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)


                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function SparePart_Search(ByVal q As String, ByVal isStock As String, ByVal isControl As String, ByVal isNotControl As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_GRID_SEARCH")
                objDB.AddInParameter(objCMD, "@ID_SEARCH", DbType.String, q)
                objDB.AddInParameter(objCMD, "@ISSTOCK", DbType.Boolean, isStock)
                objDB.AddInParameter(objCMD, "@ISCONTROL", DbType.Boolean, isControl)
                objDB.AddInParameter(objCMD, "@ISNOTCONTROL", DbType.Boolean, isNotControl)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GetReplacement(ByVal item As String, ByVal supp As String, ByVal catg As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPART_FETCH_REPLACEMENT_LIST")
                objDB.AddInParameter(objcmd, "@ITEM", DbType.String, item)
                objDB.AddInParameter(objcmd, "@SUPP", DbType.String, supp)
                objDB.AddInParameter(objcmd, "@CATG", DbType.String, catg)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function UpdSpareCategoryDetails(ByVal objItem As ItemsBO) As String
        Dim strStatus As String
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_SPAREPARTCATG_UPDATE")
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.Int32, objItem.ID_ITEM_CATG)
                objDB.AddInParameter(objcmd, "@ID_DISCOUNTCODEBUY", DbType.Int32, objItem.ID_ITEM_DISC_CODE_BUYING)
                objDB.AddInParameter(objcmd, "@ID_DISCOUNTCODESELL", DbType.Int32, objItem.ID_ITEM_DISC_CODE_SELL)
                objDB.AddInParameter(objcmd, "@ID_SUPPLIER", DbType.Int32, objItem.ID_SUPPLIER_ITEM)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, objItem.SUPP_CURRENTNO) 'ID_MAKE
                objDB.AddInParameter(objcmd, "@CATEGORY", DbType.String, objItem.CATEGORY)
                objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, objItem.DESCRIPTION)
                objDB.AddInParameter(objcmd, "@INITIALCLASSCODE", DbType.String, objItem.INITIALCLASSCODE)
                objDB.AddInParameter(objcmd, "@VATCODE", DbType.String, objItem.ID_VAT_CODE)
                objDB.AddInParameter(objcmd, "@ACCOUNTCODE", DbType.String, objItem.ACCOUNT_CODE)
                objDB.AddInParameter(objcmd, "@FLG_ALLOWBO", DbType.Boolean, objItem.FLG_ALLOW_BCKORD)
                objDB.AddInParameter(objcmd, "@FLG_COUNTSTOCK", DbType.Boolean, objItem.FLG_CNT_STOCK)
                objDB.AddInParameter(objcmd, "@FLG_ALLOWCLASS", DbType.Boolean, objItem.FLG_ALLOW_CLASSIFICATION)
                objDB.AddInParameter(objcmd, "@MODIFIEDBY", DbType.String, objItem.CREATED_BY)
                objDB.AddOutParameter(objcmd, "@ISSUCCESS", DbType.Boolean, 10)
                objDB.AddOutParameter(objcmd, "@ERRMSG", DbType.String, 100)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@ISSUCCESS").ToString + "," + objDB.GetParameterValue(objcmd, "@ERRMSG").ToString
                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class