Imports System.Web

Namespace CARS.Services.PurchaseOrder

    Public Class PurchaseOrder
        Shared objPODO As New PurchaseOrderDO
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr

        Public Function FetchPurchaseOrders(ByVal POnum As String, ByVal supplier As String, ByVal fromDate As Integer, ByVal toDate As Integer, ByVal spareNumber As String, ByVal isDelivered As String, ByVal isConfirmedOrder As String, ByVal isUnconfirmedOrder As String, ByVal isExactPOnum As String, ByVal isExactSupp As String) As List(Of PurchaseOrderHeaderBO)
            Dim dsPurchaseOrder As New DataSet
            Dim dtPurchaseOrder As DataTable
            Dim purchaseOrderSearchResult As New List(Of PurchaseOrderHeaderBO)()

            Try
                dsPurchaseOrder = objPODO.FetchPurchaseOrders(POnum, supplier, fromDate, toDate, spareNumber, isDelivered, isConfirmedOrder, isUnconfirmedOrder, isExactPOnum, isExactSupp)

                If dsPurchaseOrder.Tables.Count > 0 Then
                    dtPurchaseOrder = dsPurchaseOrder.Tables(0)
                End If
                If supplier <> String.Empty Then
                    For Each dtrow As DataRow In dtPurchaseOrder.Rows
                        Dim po As New PurchaseOrderHeaderBO()

                        po.NUMBER = dtrow("NUMBER").ToString
                        po.ID_ORDERTYPE = dtrow("ID_ORDERTYPE").ToString
                        po.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString
                        po.SUPP_NAME = dtrow("SUPP_NAME").ToString

                        po.DT_EXPECTED_DELIVERY = convertDate(dtrow("DT_EXPECTED_DELIVERY").ToString)
                        po.DT_CREATED_SIMPLE = convertDate(dtrow("DT_CREATED_SIMPLE").ToString)
                        po.DELIVERY_METHOD = dtrow("DELIVERY_METHOD").ToString
                        po.STATUS = dtrow("STATUS").ToString

                        po.FINISHED = dtrow("FINISHED").ToString
                        po.ANNOTATION = dtrow("ANNOTATION").ToString



                        purchaseOrderSearchResult.Add(po)
                    Next
                End If
            Catch ex As Exception
                Throw ex
            End Try
            Return purchaseOrderSearchResult
        End Function


        Public Function Fetch_PO_Items(ByVal POnum As String, ByVal isDeliveryTable As Boolean,  ByVal supp_currentno As String) As List(Of PurchaseOrderItemsBO)
            Dim dsPurchaseOrderItems As New DataSet
            Dim dtPurchaseOrderItems As DataTable
            Dim purchaseOrderSearchResult As New List(Of PurchaseOrderItemsBO)()

            Try
                dsPurchaseOrderItems = objPODO.Fetch_PO_Items(POnum, supp_currentno)

                If dsPurchaseOrderItems.Tables.Count > 0 Then
                    dtPurchaseOrderItems = dsPurchaseOrderItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtPurchaseOrderItems.Rows
                    Dim item As New PurchaseOrderItemsBO()

                    item.REMAINING_QTY = dtrow("REMAINING_QTY")
                    If isDeliveryTable Then
                        If item.REMAINING_QTY = 0 Then Continue For

                    End If

                    item.ID_ITEM = dtrow("ID_ITEM").ToString
                    item.ITEM_DESC = dtrow("ITEM_DESC").ToString
                    item.ITEM_CATG_DESC = dtrow("ITEM_CATG_DESC").ToString
                    item.ID_ITEM_CATG = dtrow("ID_ITEM_CATG").ToString
                    item.ORDERQTY = dtrow("ORDERQTY")
                    item.DELIVERED_QTY = dtrow("DELIVERED_QTY")
                    item.TOTALCOST = dtrow("TOTALCOST")
                    item.INDELIVERY = dtrow("INDELIVERY")
                    item.ID_WOITEM_SEQ = dtrow("ID_WOITEM_SEQ").ToString
                    If item.ID_WOITEM_SEQ = -1 Then
                        item.ID_WOITEM_SEQ = ""
                    End If
                    item.ID_WO_NO_AND_PREFIX = dtrow("ID_WO_PREFIX").ToString + dtrow("ID_WO_NO").ToString
                    item.COST_PRICE1 = (dtrow("COST_PRICE"))
                    If item.COST_PRICE1 = -1 Or isDeliveryTable = 0 Then
                        item.COST_PRICE1 = (dtrow("COST_PRICE1"))
                    End If

                    item.ITEM_PRICE = dtrow("ITEM_PRICE")
                    item.NET_PRICE = dtrow("NET_PRICE")
                    item.BASIC_PRICE = dtrow("BASIC_PRICE")
                    item.ITEM_DISC_CODE_BUY = dtrow("ITEM_DISC_CODE_BUY")
                    ''IF this is during delivery(ankomst) then we need to calculate the additional cost for net price(påslag)


                    item.REST_FLG = dtrow("REST_FLG").ToString
                    item.DELIVERED = dtrow("DELIVERED").ToString
                    item.ITEM_AVAIL_QTY = dtrow("ITEM_AVAIL_QTY")
                    item.LOCATION = dtrow("LOCATION")
                    item.ANNOTATION = dtrow("ANNOTATION").ToString
                    item.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString



                    purchaseOrderSearchResult.Add(item)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return purchaseOrderSearchResult
        End Function



        Public Function importPOitemsFromWO(ByVal supp_currentno As String, ByVal id_ordertype As String) As List(Of PurchaseOrderItemsBO)
            Dim dsPurchaseOrderItems As New DataSet
            Dim dtPurchaseOrderItems As DataTable
            Dim purchaseOrderSearchResult As New List(Of PurchaseOrderItemsBO)()

            Try
                dsPurchaseOrderItems = objPODO.importPOitemsFromWO(supp_currentno, id_ordertype)

                If dsPurchaseOrderItems.Tables.Count > 0 Then
                    dtPurchaseOrderItems = dsPurchaseOrderItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtPurchaseOrderItems.Rows
                    Dim item As New PurchaseOrderItemsBO()

                    item.ID_ITEM = dtrow("ID_ITEM_JOB").ToString
                    item.ITEM_DESC = dtrow("ITEM_DESC").ToString
                    item.ITEM_CATG_DESC = dtrow("ITEM_CATG_DESC").ToString
                    item.ID_ITEM_CATG = dtrow("ID_ITEM_CATG_JOB").ToString
                    item.ORDERQTY = dtrow("JOBI_BO_QTY")
                    item.COST_PRICE1 = dtrow("COST_PRICE1")
                    item.BASIC_PRICE = dtrow("BASIC_PRICE")
                    item.NET_PRICE = dtrow("NET_PRICE")
                    item.ITEM_PRICE = dtrow("ITEM_PRICE")
                    item.TOTALCOST = item.COST_PRICE1 * item.ORDERQTY
                    item.REMAINING_QTY = dtrow("JOBI_BO_QTY")
                    item.ID_WOITEM_SEQ = dtrow("ID_WOITEM_SEQ").ToString
                    item.ID_WO_NO_AND_PREFIX = dtrow("ID_WO_PREFIX").ToString + dtrow("ID_WO_NO").ToString
                    item.SUPP_CURRENTNO = dtrow("ID_MAKE_JOB").ToString
                    item.ITEM_AVAIL_QTY = dtrow("ITEM_AVAIL_QTY")
                    item.INDELIVERY = dtrow("IN_DELIVERY")
                    item.ANNOTATION = dtrow("TEXT").ToString
                    item.REST_FLG = 1
                    purchaseOrderSearchResult.Add(item)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return purchaseOrderSearchResult
        End Function




        Public Function convertDate(ByVal thedate As String) As String
            Dim theyear = thedate.Substring(0, 4)
            Dim themonth = thedate.Substring(4, 2)
            Dim theday = thedate.Substring(6, 2)
            Dim thefinaldate = theday + "-" + themonth + "-" + theyear
            Return thefinaldate
        End Function

        Public Function generate_PO_number(ByVal deptID As Integer, ByVal warehouseID As Integer) As String()

            Dim dsPOnumber As New DataSet
            Dim dtPOnumber As New DataTable
            Dim POnumber As String
            Dim POprefix As String
            Dim numbers(1) As String


            Try
                dsPOnumber = objPODO.generate_PO_number(deptID, warehouseID)
                POnumber = dsPOnumber.Tables(0).Rows(0).Item(2)
                POprefix = dsPOnumber.Tables(0).Rows(0).Item(1)
                numbers(0) = POprefix
                numbers(1) = POnumber
            Catch ex As Exception
                Dim theex = ex.GetType()


                Throw ex
            End Try
            Return numbers
        End Function

        Public Function SavePurchaseOrder(ByVal POheader As PurchaseOrderHeaderBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objPODO.SavePurchaseOrder(POheader, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function


        Public Function generate_automatic_suggestion(ByVal supp_currentno As String, ByVal method As String, ByVal order_max As Boolean) As List(Of PurchaseOrderItemsBO)
            Dim dsPurchaseOrderItems As New DataSet
            Dim dtPurchaseOrderItems As DataTable
            Dim purchaseOrderSearchResult As New List(Of PurchaseOrderItemsBO)()

            Try
                dsPurchaseOrderItems = objPODO.generate_automatic_suggestion(supp_currentno, method, order_max)

                If dsPurchaseOrderItems.Tables.Count > 0 Then
                    dtPurchaseOrderItems = dsPurchaseOrderItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtPurchaseOrderItems.Rows
                    Dim item As New PurchaseOrderItemsBO()

                    item.ID_ITEM = dtrow("ID_ITEM").ToString
                    item.ITEM_DESC = dtrow("ITEM_DESC").ToString
                    item.ORDERQTY = dtrow("ORDERQTY").ToString
                    item.MAX_PURCHASE = dtrow("MAX_PURCHASE").ToString
                    item.ITEM_AVAIL_QTY = dtrow("ITEM_AVAIL_QTY").ToString
                    item.INDELIVERY = dtrow("INDELIVERY").ToString
                    If item.ORDERQTY > item.MAX_PURCHASE Then
                        item.ORDERQTY = item.MAX_PURCHASE
                    End If

                    purchaseOrderSearchResult.Add(item)

                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return purchaseOrderSearchResult
        End Function


        Public Function updateItemStock(ByVal supp_currentno As String, ByVal id_item As String, ByVal id_item_catg As String, ByVal items_delivered As Decimal, ByVal id_warehouse As String) As Integer
            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objPODO.updateItemStock(supp_currentno, id_item, id_item_catg, items_delivered, id_warehouse, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function
        Public Function Add_PO_Item(ByVal POitem As PurchaseOrderItemsBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objPODO.Add_PO_Item(POitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function updateArrivalPOitem(ByVal POitem As PurchaseOrderItemsBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objPODO.updateArrivalPOitem(POitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function updatePOitem(ByVal ponumber As String, ByVal orderqty As String, ByVal buycost As String, ByVal totalcost As String, ByVal delivered As Boolean) As Integer
            Dim res As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                res = objPODO.updatePOitem(ponumber, orderqty, buycost, totalcost, delivered, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return res

        End Function



        Public Function setPOtoSent(ByVal ponumber As String, ByVal sentorfinished As Boolean) As Integer
            Dim res As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                res = objPODO.setPOtoSent(ponumber, sentorfinished, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return res

        End Function

        Public Function insert_global_to_item_master(ByVal supp_currentno As String, ByVal id_item As String, ByVal id_item_catg As String, ByVal id_warehouse As Integer) As Integer
            Dim res As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                res = objPODO.insert_global_to_item_master(supp_currentno, id_item, id_item_catg, id_warehouse, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return res

        End Function


        Public Function getOrdertypes(ByVal suppcurrentno As String, ByVal id As String) As List(Of SupplierBO)
            Dim dsOrdertype As New DataSet
            Dim dtOrdertype As DataTable
            Dim ordertype As New List(Of SupplierBO)()
            Try
                dsOrdertype = objPODO.getOrdertypes(suppcurrentno, id)
                dtOrdertype = dsOrdertype.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtOrdertype.Rows
                    Dim ordertypeDetails As New SupplierBO()
                    ordertypeDetails.SUPP_ORDERTYPE = dtrow("SUPP_ORDERTYPE").ToString()
                    ordertypeDetails.SUPP_ORDERTYPE_DESC = dtrow("SUPP_ORDERTYPE_DESC").ToString()
                    ordertypeDetails.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString()
                    ordertypeDetails.PRICETYPE = dtrow("PRICETYPE").ToString()

                    ordertype.Add(ordertypeDetails)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Customer.vb", "FetchCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return ordertype.ToList
        End Function

        Public Function addOrdertype(objSupplierBO As SupplierBO) As String

            Dim strResult As String = ""
            Try
                strResult = objPODO.addOrdertype(objSupplierBO)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "Add_Vehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function generate_automatic_po_items(supp_currentno As String, id_item_from As String, id_item_to As String, main_method As String, id_warehouse As String) As List(Of PurchaseOrderItemsBO)
            Dim dsPurchaseOrderItems As New DataSet
            Dim dtPurchaseOrderItems As DataTable
            Dim purchaseOrderSearchResult As New List(Of PurchaseOrderItemsBO)()

            Try
                dsPurchaseOrderItems = objPODO.generate_automatic_po_items(supp_currentno, id_item_from, id_item_to, main_method, id_warehouse)

                If dsPurchaseOrderItems.Tables.Count > 0 Then
                    dtPurchaseOrderItems = dsPurchaseOrderItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtPurchaseOrderItems.Rows
                    Dim item As New PurchaseOrderItemsBO()

                    item.REMAINING_QTY = dtrow("REMAINING_QTY")


                    item.ID_ITEM = dtrow("ID_ITEM").ToString
                    item.ITEM_DESC = dtrow("ITEM_DESC").ToString
                    item.ITEM_CATG_DESC = dtrow("ITEM_CATG_DESC").ToString
                    item.ID_ITEM_CATG = dtrow("ID_ITEM_CATG").ToString
                    item.ORDERQTY = dtrow("ORDERQTY")
                    item.DELIVERED_QTY = dtrow("DELIVERED_QTY")
                    item.TOTALCOST = dtrow("TOTALCOST")
                    item.INDELIVERY = dtrow("INDELIVERY")
                    item.ID_WOITEM_SEQ = dtrow("ID_WOITEM_SEQ").ToString
                    If item.ID_WOITEM_SEQ = -1 Then
                        item.ID_WOITEM_SEQ = ""
                    End If
                    item.ID_WO_NO_AND_PREFIX = dtrow("ID_WO_PREFIX").ToString + dtrow("ID_WO_NO").ToString

                    item.COST_PRICE1 = (dtrow("COST_PRICE1"))
                    item.ITEM_PRICE = dtrow("ITEM_PRICE")
                    item.NET_PRICE = dtrow("NET_PRICE")
                    item.BASIC_PRICE = dtrow("BASIC_PRICE")

                    item.REST_FLG = dtrow("REST_FLG").ToString
                    item.DELIVERED = dtrow("DELIVERED").ToString
                    item.ITEM_AVAIL_QTY = dtrow("ITEM_AVAIL_QTY")
                    item.LOCATION = dtrow("LOCATION")
                    item.ANNOTATION = dtrow("ANNOTATION").ToString
                    item.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString



                    purchaseOrderSearchResult.Add(item)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return purchaseOrderSearchResult
        End Function
        Public Function Add_PO_Item_New(ByVal POitem As PurchaseOrderItemsBO) As String

            Dim strResult As String = ""

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objPODO.Add_PO_Item_New(POitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.PurchaseOrder", "Add_PO_Item_New", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function Modify_PO_Details(poNumber As String, apiOrderNo As String) As String

            Dim strResult As String = ""

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objPODO.ModifyPODetails(login, poNumber, apiOrderNo)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.PurchaseOrder", "Modify_PO_Details", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function
    End Class

End Namespace