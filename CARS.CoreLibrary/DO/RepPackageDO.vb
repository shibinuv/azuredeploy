Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Imports System.Web.Services

Public Class RepPackageDO
    Dim ConnectionString As String
    Dim objDB As Database
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
    Public Function Add_RP_Head(ByVal RPitem As RepPackageBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer
            Dim outParam As String = ""

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_PACKAGE_HEAD_INSERT")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@JOB_ID", DbType.String, RPitem.JOB_ID)
                objDB.AddInParameter(objcmd, "@JOB_TITLE", DbType.String, RPitem.JOB_TITLE)
                objDB.AddInParameter(objcmd, "@MAKE", DbType.String, RPitem.MAKE)
                objDB.AddInParameter(objcmd, "@OPERATION_CODE", DbType.String, RPitem.OPERATION_CODE)
                objDB.AddInParameter(objcmd, "@JOB_CLASS", DbType.String, RPitem.JOB_CLASS)
                objDB.AddInParameter(objcmd, "@SUPPLIER_ID", DbType.String, RPitem.SUPPLIER_ID)
                objDB.AddInParameter(objcmd, "@FIXED_PRICE", DbType.String, RPitem.FIXED_PRICE)
                objDB.AddInParameter(objcmd, "@ADD_GM", DbType.String, RPitem.ADD_GM)

                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                Try
                    objDB.ExecuteNonQuery(objcmd)
                    outParam = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    If (outParam = "INSFLG") Then
                        strStatus = 0
                    Else
                        strStatus = 1
                    End If
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

    Public Function Add_RP_Item(ByVal RPitem As RepPackageBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_PACKAGE_DETAIL_INSERT")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@JOB_ID", DbType.String, RPitem.JOB_ID)
                objDB.AddInParameter(objcmd, "@ID_ITEM", DbType.String, RPitem.ID_ITEM)
                objDB.AddInParameter(objcmd, "@ITEM_DESC", DbType.String, RPitem.ITEM_DESC)
                objDB.AddInParameter(objcmd, "@LINE_TYPE", DbType.String, RPitem.LINE_TYPE)
                objDB.AddInParameter(objcmd, "@ITEM_AVAIL_QTY", DbType.String, RPitem.ITEM_AVAIL_QTY)
                objDB.AddInParameter(objcmd, "@ITEM_PRICE", DbType.String, RPitem.ITEM_PRICE)
                objDB.AddInParameter(objcmd, "@TOTAL_PRICE", DbType.String, RPitem.TOTAL_PRICE)
                objDB.AddInParameter(objcmd, "@SUPP_CURRENTNO", DbType.String, RPitem.SUPP_CURRENTNO)
                objDB.AddInParameter(objcmd, "@ID_ITEM_CATG", DbType.String, RPitem.ID_ITEM_CATG)


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

    Public Function Fetch_RP_List(ByVal jobid As String, ByVal wh As String, ByVal make As String, ByVal title As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MAS_REP_PACKAGE_LIST_FETCH")
                objDB.AddInParameter(objcmd, "@JOB_ID", DbType.String, jobid)
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.String, wh)
                objDB.AddInParameter(objcmd, "@MAKE", DbType.String, make)
                objDB.AddInParameter(objcmd, "@TITLE", DbType.String, title)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchRPHead(ByVal packageNo As String) As DataSet
        Try

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_PACKAGE_FETCH_HEAD")
                objDB.AddInParameter(objcmd, "@packageNo", DbType.String, packageNo)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchRPDetails(ByVal JOB_ID As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_PACKAGE_FETCH_DETAILS")
                objDB.AddInParameter(objcmd, "@JOB_ID", DbType.String, JOB_ID)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function DeleteRepairPackage(ByVal rp_code As String, ByVal userId As String, ByVal rp_type As String, ByVal id_spareseq As String) As String
        Dim outParam As String = ""
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REPPKG_DELETE")
                objDB.AddInParameter(objcmd, "@IV_RP_CODE", DbType.String, rp_code)
                objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, userId)
                objDB.AddInParameter(objcmd, "@IV_RP_TYPE", DbType.String, rp_type)
                objDB.AddInParameter(objcmd, "@ID_SPARE_SEQ", DbType.Int32, Convert.ToInt16(id_spareseq))
                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)
                objDB.ExecuteNonQuery(objcmd)
                outParam = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString

            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
        Return outParam
    End Function

    Public Function FetchRPDetailsWO(ByVal ID_RPKG_SEQ As String, ByVal JOB_ID As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_PACKAGE_FETCH_DETAILS_WO")
                objDB.AddInParameter(objcmd, "@ID_RPKG_SEQ", DbType.Int32, Integer.Parse(ID_RPKG_SEQ))
                objDB.AddInParameter(objcmd, "@JOB_ID", DbType.String, JOB_ID)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function
    Public Function Fetch_RP_List_WO(ByVal searchtext As String, ByVal user As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_PACKAGE_SEARCH_WO")
                objDB.AddInParameter(objcmd, "@ID_SEARCH", DbType.String, searchtext)
                objDB.AddInParameter(objcmd, "@USER", DbType.String, user)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function
End Class
