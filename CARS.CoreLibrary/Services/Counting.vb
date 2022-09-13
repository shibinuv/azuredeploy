Imports System.Web

Namespace CARS.Services.Counting

    Public Class Counting
        Shared objCountingDO As New CountingDO
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr

        Public Function LoadUsers(ByVal deptID As String) As List(Of CountingBO)
            Dim dsFetchTireType As New DataSet
            Dim dtTireType As DataTable
            Dim tireType As New List(Of CountingBO)()
            Try
                dsFetchTireType = objCountingDO.LoadUsers(deptID)
                dtTireType = dsFetchTireType.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtTireType.Rows
                    Dim userDet As New CountingBO()
                    userDet.ID_LOGIN = dtrow("ID_Login").ToString()
                    userDet.FIRST_NAME = dtrow("First_Name").ToString()
                    userDet.LAST_NAME = dtrow("Last_Name").ToString()
                    tireType.Add(userDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchMakeCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tireType.ToList
        End Function

        Public Function generate_CL_number(ByVal deptID As Integer, ByVal warehouseID As Integer) As String()

            Dim dsCLnumber As New DataSet
            Dim dtCLnumber As New DataTable
            Dim CLnumber As String
            Dim CLprefix As String
            Dim numbers(1) As String

            Try
                dsCLnumber = objCountingDO.generate_CL_number(deptID, warehouseID)
                CLnumber = dsCLnumber.Tables(0).Rows(0).Item(2)
                CLprefix = dsCLnumber.Tables(0).Rows(0).Item(1)
                numbers(0) = CLprefix
                numbers(1) = CLnumber
            Catch ex As Exception
                Dim theex = ex.GetType()


                Throw ex
            End Try
            Return numbers
        End Function

        Public Function set_CL_number(ByVal deptID As Integer, ByVal warehouseID As Integer) As String()

            Dim dsCLnumber As New DataSet
            Dim dtCLnumber As New DataTable
            Dim CLnumber As String
            Dim CLprefix As String
            Dim numbers(1) As String

            Try
                dsCLnumber = objCountingDO.set_CL_number(deptID, warehouseID)

            Catch ex As Exception
                Dim theex = ex.GetType()


                Throw ex
            End Try
            Return numbers
        End Function

        Public Function Fetch_CL_Items(ByVal supplier As String, ByVal wh As String, ByVal sparefrom As String, ByVal spareto As String, ByVal locfrom As String, ByVal locto As String, ByVal stock As String, ByVal nolocation As String, ByVal sortby As String) As List(Of CountingBO)
            Dim dsCountingItems As New DataSet
            Dim dtCountingItems As DataTable
            Dim countingResult As New List(Of CountingBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsCountingItems = objCountingDO.Fetch_CL_Items(supplier, wh, login, sparefrom, spareto, locfrom, locto, stock, nolocation, sortby)

                If dsCountingItems.Tables.Count > 0 Then
                    dtCountingItems = dsCountingItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtCountingItems.Rows
                    Dim item As New CountingBO()

                    item.LINE_NO = counter
                    item.ID_ITEM = dtrow("ID_ITEM").ToString
                    item.ITEM_DESC = dtrow("ITEM_DESC").ToString
                    item.ITEM_CATG_DESC = dtrow("ITEM_CATG_DESC").ToString
                    item.ID_ITEM_CATG = dtrow("ID_ITEM_CATG").ToString
                    item.ID_WH = dtrow("ID_WH_ITEM")
                    item.STOCKBEFORECOUNT = IIf(IsDBNull(dtrow("STOCKBEFORECOUNT")), "", dtrow("STOCKBEFORECOUNT").ToString)
                    item.LOCATION = dtrow("LOCATION")
                    item.LAST_COUNTED_DATE = IIf(IsDBNull(dtrow("LAST_COUNTED_DATE")), "", dtrow("LAST_COUNTED_DATE").ToString)
                    If (dtrow("CREATED_BY") = Nothing) Then
                        item.CREATED_BY = ""
                    Else
                        item.CREATED_BY = dtrow("CREATED_BY")
                    End If
                    item.ADJUSTMENT = "0,00"
                    item.STOCKAFTERCOUNT = If(IsDBNull(dtrow("STOCKBEFORECOUNT")), "", dtrow("STOCKBEFORECOUNT").ToString)
                    item.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO")
                    item.AVG_PRICE = IIf(IsDBNull(dtrow("AVG_PRICE")), "0,00", dtrow("AVG_PRICE").ToString())
                    item.ITEM_PRICE = IIf(IsDBNull(dtrow("ITEM_PRICE")), "0,00", dtrow("ITEM_PRICE").ToString())
                    item.COST_PRICE1 = IIf(IsDBNull(dtrow("COST_PRICE1")), "0,00", dtrow("COST_PRICE1").ToString())
                    countingResult.Add(item)
                    counter += 1
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return countingResult
        End Function

        Public Function Fetch_CL_No(ByVal supplier As String, ByVal wh As String, ByVal countingNo As String, ByVal closed As String, ByVal dateFrom As String, ByVal dateTo As String, ByVal spareNo As String) As List(Of CountingBO)
            Dim dsCountingItems As New DataSet
            Dim dtCountingItems As DataTable
            Dim countingResult As New List(Of CountingBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsCountingItems = objCountingDO.Fetch_CL_No(supplier, wh, countingNo, closed, dateFrom, dateTo, spareNo)

                If dsCountingItems.Tables.Count > 0 Then
                    dtCountingItems = dsCountingItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtCountingItems.Rows
                    Dim item As New CountingBO()


                    item.COUNTING_PREFIX = dtrow("COUNTING_PREFIX").ToString
                    item.COUNTING_NO = dtrow("COUNTING_NO").ToString
                    item.CREATED_BY = dtrow("CREATED_BY").ToString
                    item.CLOSED = dtrow("CLOSED")
                    item.DIFFERENCE = dtrow("DIFFERENCE")
                    item.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO")
                    item.SUP_NAME = dtrow("SUP_Name")
                    If (dtrow("DT_CREATED") = "01.01.1900") Then
                        item.DT_CREATED = ""
                    Else
                        item.DT_CREATED = dtrow("DT_CREATED")
                    End If

                    countingResult.Add(item)

                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return countingResult
        End Function

        Public Function Add_CL_Item(ByVal CLitem As CountingBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objCountingDO.Add_CL_Item(CLitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function Update_CL_Item(ByVal CLitem As String) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objCountingDO.Update_CL_Item(CLitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function Close_CL_Item(ByVal CLitem As CountingBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objCountingDO.Close_CL_Item(CLitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function Delete_CL_Item(ByVal CLitem As CountingBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objCountingDO.Delete_CL_Item(CLitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function FetchCountingList(ByVal CLNo As String, ByVal wh As String) As List(Of CountingBO)
            Dim dsCountingList As New DataSet
            Dim dtCountingList As DataTable
            Dim countingListResult As New List(Of CountingBO)()

            Try
                dsCountingList = objCountingDO.FetchCountingList(CLNo, wh)

                If dsCountingList.Tables.Count > 0 Then
                    dtCountingList = dsCountingList.Tables(0)
                End If

                For Each dtrow As DataRow In dtCountingList.Rows
                    Dim cl As New CountingBO()

                    cl.COUNTING_PREFIX = dtrow("COUNTING_PREFIX").ToString
                    cl.COUNTING_NO = dtrow("COUNTING_NO").ToString
                    cl.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString
                    cl.SUP_NAME = dtrow("SUPP_NAME").ToString

                    countingListResult.Add(cl)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return countingListResult
        End Function

        Public Function FetchCountingListDetails(ByVal CLPrefix As String, ByVal CLNo As String, ByVal wh As String) As List(Of CountingBO)
            Dim dsCountingList As New DataSet
            Dim dtCountingList As DataTable
            Dim countingListResult As New List(Of CountingBO)()

            Try
                dsCountingList = objCountingDO.FetchCountingListDetails(CLPrefix, CLNo, wh)

                If dsCountingList.Tables.Count > 0 Then
                    dtCountingList = dsCountingList.Tables(0)
                End If

                For Each dtrow As DataRow In dtCountingList.Rows
                    Dim cl As New CountingBO()
                    cl.LINE_NO = dtrow("LINE_NO").ToString
                    cl.ID_ITEM = dtrow("ID_ITEM").ToString
                    cl.ITEM_DESC = dtrow("DESCRIPTION").ToString
                    cl.LOCATION = dtrow("LOCATION").ToString
                    cl.LAST_COUNTED_DATE = dtrow("LAST_COUNTED_DATE").ToString
                    cl.CREATED_BY = dtrow("CREATED_BY").ToString
                    cl.STOCKBEFORECOUNT = dtrow("STOCKBEFORECOUNT").ToString
                    cl.DIFFERENCE = dtrow("DIFFERENCE").ToString
                    cl.STOCKAFTERCOUNT = dtrow("STOCKAFTERCOUNT").ToString
                    cl.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString
                    cl.AVG_PRICE = dtrow("AVG_PRICE").ToString
                    cl.ITEM_PRICE = dtrow("SELLING_PRICE").ToString
                    cl.COST_PRICE1 = dtrow("COST_PRICE1").ToString
                    cl.DT_MODIFIED = dtrow("DT_MODIFIED").ToString
                    cl.MODIFIED_BY = dtrow("MODIFIED_BY").ToString
                    cl.COUNTED_BY = dtrow("COUNTED_BY").ToString
                    countingListResult.Add(cl)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return countingListResult
        End Function

        Public Function FetchItemDetails(ByVal spareNo As String, ByVal itemQty As String, ByVal wh As String) As List(Of CountingBO)
            Dim dsCountingItems As New DataSet
            Dim dtCountingItems As DataTable
            Dim countingResult As New List(Of CountingBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsCountingItems = objCountingDO.FetchItemDetails(spareNo, itemQty, wh)

                If dsCountingItems.Tables.Count > 0 Then
                    dtCountingItems = dsCountingItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtCountingItems.Rows
                    Dim item As New CountingBO()
                    item.RETURN_VALUE = dtrow("OV_RETVALUE").ToString
                    If (item.RETURN_VALUE = "EXSIST") Then
                        item.ID_ITEM = dtrow("ID_ITEM").ToString
                        item.ITEM_DESC = dtrow("ITEM_DESC").ToString
                        item.ID_ITEM_CATG = dtrow("ID_ITEM_CATG").ToString
                        item.ID_WH = dtrow("ID_WH_ITEM")
                        item.STOCKBEFORECOUNT = IIf(IsDBNull(dtrow("STOCKBEFORECOUNT")), "", dtrow("STOCKBEFORECOUNT").ToString)
                        item.LOCATION = dtrow("LOCATION")
                        item.LAST_COUNTED_DATE = IIf(IsDBNull(dtrow("LAST_COUNTED_DATE")), "", dtrow("LAST_COUNTED_DATE").ToString)
                        If (dtrow("CREATED_BY") = Nothing) Then
                            item.CREATED_BY = ""
                        Else
                            item.CREATED_BY = dtrow("CREATED_BY")
                        End If
                        item.ADJUSTMENT = "0,00"

                        item.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO")
                        item.AVG_PRICE = IIf(IsDBNull(dtrow("AVG_PRICE")), "0,00", dtrow("AVG_PRICE").ToString())
                        item.ITEM_PRICE = IIf(IsDBNull(dtrow("ITEM_PRICE")), "0,00", dtrow("ITEM_PRICE").ToString())
                        item.COST_PRICE1 = IIf(IsDBNull(dtrow("COST_PRICE1")), "0,00", dtrow("COST_PRICE1").ToString())
                    End If

                    countingResult.Add(item)

                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return countingResult
        End Function

    End Class

End Namespace