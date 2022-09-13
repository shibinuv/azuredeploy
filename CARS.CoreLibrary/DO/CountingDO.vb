Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Imports System.Web.Services

Public Class CountingDO
    Dim ConnectionString As String
    Dim objDB As Database
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub

    Public Function LoadUsers(ByVal deptID As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_GET_USERS")
                objDB.AddInParameter(objcmd, "@DeptId", DbType.Int32, deptID)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function generate_CL_number(ByVal deptID As Integer, ByVal wh As Integer) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_GENERATE_COUNTINGNUMBER")
                objDB.AddInParameter(objcmd, "@DeptId", DbType.Int32, deptID)
                objDB.AddInParameter(objcmd, "@WarehouseId", DbType.Int32, wh)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function set_CL_number(ByVal deptID As Integer, ByVal wh As Integer) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_UPDATE_CURNO_COUNTINGCONFIG")
                objDB.AddInParameter(objcmd, "@DeptId", DbType.Int32, deptID)
                objDB.AddInParameter(objcmd, "@WarehouseId", DbType.Int32, wh)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Fetch_CL_Items(ByVal supplier As String, ByVal wh As String, ByVal login As String, ByVal sparefrom As String, ByVal spareto As String, ByVal locfrom As String, ByVal locto As String, ByVal stock As String, ByVal nolocation As String, ByVal sortby As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_FETCH_ITEMS")
                objDB.AddInParameter(objcmd, "@supplier", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@warehouseId", DbType.String, wh)
                objDB.AddInParameter(objcmd, "@user", DbType.String, login)
                objDB.AddInParameter(objcmd, "@spareFrom", DbType.String, sparefrom)
                objDB.AddInParameter(objcmd, "@spareTo", DbType.String, spareto)
                objDB.AddInParameter(objcmd, "@locationFrom", DbType.String, locfrom)
                objDB.AddInParameter(objcmd, "@locationTo", DbType.String, locto)
                objDB.AddInParameter(objcmd, "@stock", DbType.String, stock)
                objDB.AddInParameter(objcmd, "@nolocation", DbType.String, nolocation)
                objDB.AddInParameter(objcmd, "@sortBy", DbType.String, sortby)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function Fetch_CL_No(ByVal supplier As String, ByVal wh As String, ByVal countingNo As String, ByVal closed As String, ByVal dateFrom As String, ByVal dateTo As String, ByVal spareNo As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_NO_FETCH")
                objDB.AddInParameter(objcmd, "@supplier", DbType.String, supplier)
                objDB.AddInParameter(objcmd, "@Warehouse", DbType.String, wh)
                objDB.AddInParameter(objcmd, "@countingNo", DbType.String, countingNo)
                objDB.AddInParameter(objcmd, "@closed", DbType.String, closed)
                objDB.AddInParameter(objcmd, "@dateFrom", DbType.String, dateFrom)
                objDB.AddInParameter(objcmd, "@dateTo", DbType.String, dateTo)
                objDB.AddInParameter(objcmd, "@spareNo", DbType.String, spareNo)


                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function Add_CL_Item(ByVal CLitem As CountingBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_ADD_ITEM")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@COUNTING_PREFIX", DbType.String, CLitem.COUNTING_PREFIX)
                objDB.AddInParameter(objcmd, "@COUNTING_NO", DbType.String, CLitem.COUNTING_NO)
                objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, CLitem.DESCRIPTION)
                objDB.AddInParameter(objcmd, "@LINE_NO", DbType.String, CLitem.LINE_NO)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, CLitem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@STOCKAFTERCOUNT", DbType.String, CLitem.STOCKAFTERCOUNT)
                objDB.AddInParameter(objcmd, "@ADJUSTMENT", DbType.String, CLitem.ADJUSTMENT)
                objDB.AddInParameter(objcmd, "@DIFFERENCE", DbType.String, CLitem.DIFFERENCE)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, CLitem.SUPP_CURRENTNO)
                objDB.AddInParameter(objcmd, "@ID_WH", DbType.Int32, CLitem.ID_WH)
                objDB.AddInParameter(objcmd, "@STOCKBEFORECOUNT", DbType.String, CLitem.STOCKBEFORECOUNT)
                objDB.AddInParameter(objcmd, "@AVG_PRICE", DbType.String, CLitem.AVG_PRICE)
                objDB.AddInParameter(objcmd, "@SELLING_PRICE", DbType.String, CLitem.ITEM_PRICE)
                objDB.AddInParameter(objcmd, "@COST_PRICE", DbType.String, CLitem.COST_PRICE1)
                objDB.AddInParameter(objcmd, "@LOCATION", DbType.String, CLitem.LOCATION)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, CLitem.ID_ITEM_CATG)
                objDB.AddInParameter(objcmd, "@COUNTED_BY", DbType.String, CLitem.COUNTED_BY)

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

    Public Function Update_CL_Item(ByVal CLitem As String, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_UPDATE_ITEM")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@CLITEMS", DbType.String, CLitem)
                'objDB.AddInParameter(objcmd, "@COUNTING_NO", DbType.String, CLitem.COUNTING_NO)
                'objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, CLitem.DESCRIPTION)
                'objDB.AddInParameter(objcmd, "@LINE_NO", DbType.String, CLitem.LINE_NO)
                'objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, CLitem.ID_ITEM)
                'objDB.AddInParameter(objcmd, "@STOCKAFTERCOUNT", DbType.String, CLitem.STOCKAFTERCOUNT)
                'objDB.AddInParameter(objcmd, "@ADJUSTMENT", DbType.String, CLitem.ADJUSTMENT)
                'objDB.AddInParameter(objcmd, "@DIFFERENCE", DbType.String, CLitem.DIFFERENCE)
                'objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, CLitem.SUPP_CURRENTNO)
                'objDB.AddInParameter(objcmd, "@ID_WH", DbType.Int32, CLitem.ID_WH)
                'objDB.AddInParameter(objcmd, "@STOCKBEFORECOUNT", DbType.String, CLitem.STOCKBEFORECOUNT)
                'objDB.AddInParameter(objcmd, "@AVG_PRICE", DbType.String, CLitem.AVG_PRICE)
                'objDB.AddInParameter(objcmd, "@SELLING_PRICE", DbType.String, CLitem.ITEM_PRICE)
                'objDB.AddInParameter(objcmd, "@COST_PRICE", DbType.String, CLitem.COST_PRICE1)
                'objDB.AddInParameter(objcmd, "@LOCATION", DbType.String, CLitem.LOCATION)
                'objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, CLitem.ID_ITEM_CATG)
                ''objDB.AddInParameter(objcmd, "@DT_MODIFIED", DbType.DateTime, CLitem.DT_MODIFIED)
                'objDB.AddInParameter(objcmd, "@MODIFIED_BY", DbType.String, CLitem.MODIFIED_BY)
                'objDB.AddInParameter(objcmd, "@COUNTED_BY", DbType.String, CLitem.COUNTED_BY)

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

    Public Function Close_CL_Item(ByVal CLitem As CountingBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_CLOSE_ITEM")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@COUNTING_PREFIX", DbType.String, CLitem.COUNTING_PREFIX)
                objDB.AddInParameter(objcmd, "@COUNTING_NO", DbType.String, CLitem.COUNTING_NO)
                objDB.AddInParameter(objcmd, "@DESCRIPTION", DbType.String, CLitem.DESCRIPTION)
                objDB.AddInParameter(objcmd, "@LINE_NO", DbType.String, CLitem.LINE_NO)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, CLitem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@STOCKAFTERCOUNT", DbType.String, CLitem.STOCKAFTERCOUNT)
                objDB.AddInParameter(objcmd, "@ADJUSTMENT", DbType.String, CLitem.ADJUSTMENT)
                objDB.AddInParameter(objcmd, "@DIFFERENCE", DbType.String, CLitem.DIFFERENCE)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, CLitem.SUPP_CURRENTNO)
                objDB.AddInParameter(objcmd, "@ID_WH", DbType.Int32, CLitem.ID_WH)
                objDB.AddInParameter(objcmd, "@STOCKBEFORECOUNT", DbType.String, CLitem.STOCKBEFORECOUNT)
                objDB.AddInParameter(objcmd, "@AVG_PRICE", DbType.String, CLitem.AVG_PRICE)
                objDB.AddInParameter(objcmd, "@SELLING_PRICE", DbType.String, CLitem.ITEM_PRICE)
                objDB.AddInParameter(objcmd, "@COST_PRICE", DbType.String, CLitem.COST_PRICE1)
                objDB.AddInParameter(objcmd, "@LOCATION", DbType.String, CLitem.LOCATION)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, CLitem.ID_ITEM_CATG)
                objDB.AddInParameter(objcmd, "@MODIFIED_BY", DbType.String, CLitem.MODIFIED_BY)
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

    Public Function Delete_CL_Item(ByVal CLitem As CountingBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_DELETE_LIST")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@COUNTING_PREFIX", DbType.String, CLitem.COUNTING_PREFIX)
                objDB.AddInParameter(objcmd, "@COUNTING_NO", DbType.String, CLitem.COUNTING_NO)
                objDB.AddInParameter(objcmd, "@CLOSED", DbType.Boolean, CLitem.CLOSED)

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

    Public Function FetchCountingList(ByVal CLNo As String, ByVal wh As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_SEARCH")
                objDB.AddInParameter(objcmd, "@CLNo", DbType.String, CLNo)
                objDB.AddInParameter(objcmd, "@Warehouse", DbType.String, wh)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchCountingListDetails(ByVal CLPrefix As String, ByVal CLNo As String, ByVal wh As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_FETCH_DETAILS")
                objDB.AddInParameter(objcmd, "@CLNo", DbType.String, CLNo)
                objDB.AddInParameter(objcmd, "@CLPrefix", DbType.String, CLPrefix)
                objDB.AddInParameter(objcmd, "@Warehouse", DbType.String, wh)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchItemDetails(ByVal spareNo As String, ByVal itemQty As String, ByVal wh As String) As DataSet
        Try

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_COUNTING_FETCH_SCANNER_ITEM")
                objDB.AddInParameter(objcmd, "@spareNo", DbType.String, spareNo)
                objDB.AddInParameter(objcmd, "@itemQty", DbType.String, itemQty)
                objDB.AddInParameter(objcmd, "@warehouse", DbType.String, wh)

                Return objDB.ExecuteDataSet(objcmd)

            End Using

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

End Class
