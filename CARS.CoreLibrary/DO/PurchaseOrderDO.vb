Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Imports System.Web.Services

Public Class PurchaseOrderDO
    Dim ConnectionString As String
    Dim objDB As Database
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub

    Public Function FetchPurchaseOrders(ByVal POnum As String, ByVal supplier As String, ByVal fromDate As Integer, ByVal toDate As Integer, ByVal spareNumber As String, ByVal isDelivered As String, ByVal isConfirmedOrder As String, ByVal isUnconfirmedOrder As String, ByVal isExactPOnum As String, ByVal isExactSupp As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_FETCH_HEADER")
                objDB.AddInParameter(objcmd, "@NUMBER", DbType.String, POnum)
                objDB.AddInParameter(objcmd, "@SUPPLIER", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@FROMDATE", DbType.Int32, fromDate)
                objDB.AddInParameter(objcmd, "@TODATE", DbType.Int32, toDate)
                objDB.AddInParameter(objcmd, "@CONFIRMED", DbType.Boolean, isConfirmedOrder)
                objDB.AddInParameter(objcmd, "@UNCONFIRMED", DbType.Boolean, isUnconfirmedOrder)
                objDB.AddInParameter(objcmd, "@IS_EXACT_PONUM", DbType.Boolean, isExactPOnum)
                objDB.AddInParameter(objcmd, "@IS_EXACT_SUPP", DbType.Boolean, isExactSupp)
                objDB.AddInParameter(objcmd, "@SPARENUMBER", DbType.String, spareNumber)


                If (String.Compare("%", isDelivered) = 0) Then
                    objDB.AddInParameter(objcmd, "@ISDELIVERED", DbType.Int32, 2)
                Else
                    objDB.AddInParameter(objcmd, "@ISDELIVERED", DbType.Boolean, isDelivered)
                End If

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function Fetch_PO_Items(ByVal POnum As String, ByVal supp_currentno As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_FETCH_ITEMS")
                objDB.AddInParameter(objcmd, "@NUMBER", DbType.String, POnum)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supp_currentno)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function fetch_po_items_indelivery(ByVal POnum As String, ByVal supp_currentno As String, ByVal id_item As String) As Decimal
        Try
            Dim indelivery As Decimal
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_FETCH_ITEMS_INDELIVERY")
                objDB.AddInParameter(objcmd, "@NUMBER", DbType.String, POnum)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supp_currentno)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                Try
                    indelivery = objDB.ExecuteScalar(objcmd)

                Catch ex As Exception

                End Try


            End Using
            Return indelivery
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function importPOitemsFromWO(ByVal supp_currentno As String, ByVal id_ordertype As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_FETCH_BACKORDER_ITEMS")
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supp_currentno)
                objDB.AddInParameter(objcmd, "@ID_ORDERTYPE", DbType.String, id_ordertype)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function generate_PO_number(ByVal deptID As Integer, ByVal warehouseID As Integer) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_GENERATE_PONUMBER")
                objDB.AddInParameter(objcmd, "@DeptId", DbType.Int32, deptID)
                objDB.AddInParameter(objcmd, "@WarehouseId", DbType.Int32, warehouseID)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function SavePurchaseOrder(ByVal PurchaseOrderItem As PurchaseOrderHeaderBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_CREATE_POHEADER")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@PREFIX", DbType.String, PurchaseOrderItem.PREFIX)
                objDB.AddInParameter(objcmd, "@NUMBER", DbType.String, PurchaseOrderItem.NUMBER)
                objDB.AddInParameter(objcmd, "@ID_ORDERTYPE", DbType.String, PurchaseOrderItem.ID_ORDERTYPE)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, PurchaseOrderItem.SUPP_CURRENTNO)
                objDB.AddInParameter(objcmd, "@ID_DEPT", DbType.Int32, PurchaseOrderItem.ID_DEPT)
                objDB.AddInParameter(objcmd, "@ID_WAREHOUSE", DbType.Int32, PurchaseOrderItem.ID_WAREHOUSE)
                objDB.AddInParameter(objcmd, "@DT_CREATED_SIMPLE", DbType.Int32, PurchaseOrderItem.DT_CREATED_SIMPLE)
                objDB.AddInParameter(objcmd, "@DT_EXPECTED_DELIVERY", DbType.Int64, PurchaseOrderItem.DT_EXPECTED_DELIVERY)
                objDB.AddInParameter(objcmd, "@DELIVERY_METHOD", DbType.String, PurchaseOrderItem.DELIVERY_METHOD)
                objDB.AddInParameter(objcmd, "@STATUS", DbType.String, PurchaseOrderItem.STATUS)
                objDB.AddInParameter(objcmd, "@ANNOTATION", DbType.String, PurchaseOrderItem.ANNOTATION)
                objDB.AddInParameter(objcmd, "@FINISHED", DbType.String, PurchaseOrderItem.FINISHED)


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

    Public Function generate_automatic_suggestion(supp_currentno As String, ByVal method As String, ByVal order_max As Boolean) As DataSet

        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_GENERATE_AUTOMATIC")

                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supp_currentno)
                objDB.AddInParameter(objcmd, "@METHOD", DbType.String, method)
                objDB.AddInParameter(objcmd, "@MAX", DbType.Boolean, order_max)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function


    Public Function updateArrivalPOitem(ByVal POitem As PurchaseOrderItemsBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_UPDATE_ARRIVAL_POITEM")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, POitem.PONUMBER)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, POitem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@REMAINING_QTY", DbType.Decimal, POitem.REMAINING_QTY)
                objDB.AddInParameter(objcmd, "@DELIVERED_QTY", DbType.Decimal, POitem.DELIVERED_QTY)
                objDB.AddInParameter(objcmd, "@COST_PRICE1", DbType.Decimal, POitem.COST_PRICE1)
                objDB.AddInParameter(objcmd, "@ITEM_PRICE", DbType.Decimal, POitem.ITEM_PRICE)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, POitem.SUPP_CURRENTNO)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, POitem.ID_ITEM_CATG)
                objDB.AddInParameter(objcmd, "@ID_WAREHOUSE", DbType.Int64, 1)

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

    Public Function updatePOitem(ByVal ponumber As String, ByVal orderqty As String, ByVal buycost As String, ByVal totalcost As String, ByVal delivered As Boolean, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_UPDATE_POITEMS")

                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, ponumber)
                objDB.AddInParameter(objcmd, "@ORDERQTY", DbType.Decimal, orderqty)
                objDB.AddInParameter(objcmd, "@COST_PRICE1", DbType.Decimal, buycost)
                objDB.AddInParameter(objcmd, "@TOTALCOST", DbType.Decimal, totalcost)
                objDB.AddInParameter(objcmd, "@DELIVERED", DbType.Boolean, delivered)
                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)

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
            Throw
        End Try



    End Function

    Public Function deletePOitem(ByVal ponumber As String, ByVal id_woitem_seq As Integer, ByVal id_item As String, ByVal login As String) As Integer
        Try
            Dim retVal As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_DELETE_POITEM")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, ponumber)
                objDB.AddInParameter(objcmd, "@ID_WOITEM_SEQ", DbType.Int64, id_woitem_seq)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)


                Try
                    retVal = objDB.ExecuteScalar(objcmd)


                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return retVal

        Catch ex As Exception
            Throw
        End Try



    End Function

    Function getOrdertypes(ByVal suppcurrentno As String, ByVal id As String) As DataSet

        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_ORDERTYPE_FOR_SUPPLIER")
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, suppcurrentno)
                If id = "undefined" Then
                    id = ""
                End If
                objDB.AddInParameter(objcmd, "@SUPP_ORDERTYPE", DbType.String, id)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function addOrdertype(ByVal objSupplier As SupplierBO) As String
        Try
            Dim strStatus As String
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_INSERT_ORDERTYPE")
                objDB.AddInParameter(objcmd, "@IV_ORDERTYPE", DbType.String, objSupplier.SUPP_ORDERTYPE)
                objDB.AddInParameter(objcmd, "@IV_DESCRIPTION", DbType.String, objSupplier.SUPP_ORDERTYPE_DESC)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, objSupplier.SUPP_CURRENTNO)
                objDB.AddInParameter(objcmd, "@PRICETYPE", DbType.String, objSupplier.PRICETYPE)
                objDB.AddInParameter(objcmd, "@IV_CREATED_BY", DbType.String, objSupplier.CREATED_BY)
                objDB.AddInParameter(objcmd, "@FLG_DEFAULT", DbType.String, 0)

                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                Try
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                Catch ex As Exception
                    Throw
                End Try
            End Using
            Return strStatus

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Friend Function generate_automatic_po_items(supp_currentno As String, id_item_from As String, id_item_to As String, main_method As String, id_warehouse As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_GENERATE_AUTOMATIC")
                objDB.AddInParameter(objcmd, "@USER", DbType.String, "79adm")
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supp_currentno)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function deletePO(ByVal ponumber As String, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_DELETE_PO")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, ponumber)



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
            Throw
        End Try



    End Function


    Public Function setPOtoSent(ByVal ponumber As String, ByVal sentorfinished As Boolean, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_SETSTATUS_POITEMS")

                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, ponumber)
                objDB.AddInParameter(objcmd, "@SENTORFINISHED", DbType.Boolean, sentorfinished)
                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)

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
            Throw
        End Try



    End Function
    Public Function updateItemStock(ByVal supp_currentno As String, ByVal id_item As String, ByVal id_item_catg As String, ByVal items_delivered As Decimal, ByVal id_warehouse As Integer, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_ITEM_STOCK_UPDATE")

                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supp_currentno)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, id_item_catg)
                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@ITEMS_DELIVERED", DbType.Decimal, items_delivered)
                objDB.AddInParameter(objcmd, "@ID_WAREHOUSE", DbType.Int64, id_warehouse)

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
            Throw
        End Try



    End Function


    Public Function Fetch_PO_id(ByVal ponum As String) As Integer
        Try
            Dim id As Integer

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_FETCH_HEADER_ID")

                objDB.AddInParameter(objcmd, "@NUMBER", DbType.String, ponum)


                Try
                    id = objDB.ExecuteScalar(objcmd)


                Catch ex As Exception

                End Try

            End Using
            Return id

        Catch ex As Exception
            Dim theex = ex.GetType()

            Throw ex
        End Try

    End Function

    Public Function getCostPrice(ByVal itemID As String, ByVal suppcurrentno As String, ByVal orderType As String) As Decimal
        Try
            Dim costPrice As Decimal

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PRICE_FETCH")

                objDB.AddInParameter(objcmd, "@ID_ORDERTYPE", DbType.String, orderType)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, suppcurrentno)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, itemID)


                Try
                    costPrice = objDB.ExecuteScalar(objcmd)

                Catch ex As Exception

                End Try

            End Using
            Return costPrice

        Catch ex As Exception
            Dim theex = ex.GetType()

            Throw ex
        End Try

    End Function

    Public Function insert_global_to_item_master(ByVal supp_currentno As String, ByVal id_item As String, ByVal id_item_catg As String, ByVal id_warehouse As Integer, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPAREPART_INSERT_GLOBAL_TO_ITEM_MASTER")

                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, supp_currentno)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, id_item)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, id_item_catg)
                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@ID_WH_ITEM", DbType.Int64, id_warehouse)

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
            Throw
        End Try



    End Function

    Public Function Add_PO_Item_New(ByVal POitem As PurchaseOrderItemsBO, ByVal login As String) As String
        Try
            'Dim strStatus As Integer = 0
            Dim retString As String
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_PO_ADD_POITEM_NEW")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@ID_PO", DbType.Int64, POitem.ID_PO)
                objDB.AddInParameter(objcmd, "@POPREFIX", DbType.String, POitem.POPREFIX)
                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, POitem.PONUMBER)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, POitem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@ITEM_DESC", DbType.String, POitem.ITEM_DESC)
                objDB.AddInParameter(objcmd, "@ITEM_CATG_DESC", DbType.String, DBNull.Value)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, DBNull.Value)
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

                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                    retString = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString

                    'strStatus = 1
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return retString

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try



    End Function
    Public Function ModifyPODetails(login As String, poNumber As String, apiOrderNo As String) As String
        Try
            Dim retString As String
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MODIFY_PO_DETAILS")
                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@PONUMBER", DbType.String, poNumber)
                objDB.AddInParameter(objcmd, "@API_ORDER_NO", DbType.String, apiOrderNo)

                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                Try
                    objDB.ExecuteNonQuery(objcmd)
                    retString = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return retString

        Catch ex As Exception
            Throw
        End Try

    End Function
End Class
