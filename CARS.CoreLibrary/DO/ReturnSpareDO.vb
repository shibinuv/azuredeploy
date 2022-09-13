Imports System.Data.Common
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Namespace CARS.ReturnSpareDO
    Public Class ReturnSpareDO
        Dim ConnectionString As String
        Shared objCommonUtil As New CARS.Utilities.CommonUtility
        Dim objDB As Database
        Dim strStatus As String
        Public Sub New()
            ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            objDB = New SqlDatabase(ConnectionString)
        End Sub

        Public Function FetchReturnSpareHeader(searchStr As String, user As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SEARCH_RETURN_SPARES")
                    objDB.AddInParameter(objcmd, "@ID_SEARCH", DbType.String, searchStr)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, user)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function FetchReturnSpareDetails(returnNumber As Integer, user As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_GET_RETURNSPARE")
                    objDB.AddInParameter(objcmd, "@IV_RETURN_NO", DbType.Int32, returnNumber)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, user)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function FetchReturnCode(searchStr As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_RETURN_CODES")
                    objDB.AddInParameter(objcmd, "@IV_SEARCH", DbType.String, searchStr)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function ModifyReturnCode(idItemDltret As Integer, returnCode As String, user As String) As String
            Dim strStatus As String = ""
            Try

                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_RETURN_CODE")
                    objDB.AddInParameter(objcmd, "@IV_ID_ITEM_DETAILS_RETURN", DbType.Int32, idItemDltret)
                    objDB.AddInParameter(objcmd, "@IV_RETURN_CODE", DbType.String, returnCode)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, user)

                    objDB.AddOutParameter(objcmd, "@IV_RETVAL", DbType.String, 50)
                    objDB.ExecuteNonQuery(objcmd)

                    strStatus = CStr(objDB.GetParameterValue(objcmd, "@IV_RETVAL"))
                End Using
            Catch ex As Exception
                Throw ex
            End Try
            Return strStatus
        End Function

        Public Function ModifyReturnSpareHead(objRetSprBO As ReturnSpareBO, user As String) As String
            Dim strStatus As String = ""
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_UPD_RETURN_ORDERS")
                    objDB.AddInParameter(objcmd, "@IV_RETURN_NO", DbType.Int32, objRetSprBO.ReturnNo)
                    objDB.AddInParameter(objcmd, "@IV_ISCREDITED", DbType.Boolean, objRetSprBO.IsCredited)
                    objDB.AddInParameter(objcmd, "@IV_ANNOTATION", DbType.String, objRetSprBO.Annotation)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, user)

                    objDB.AddOutParameter(objcmd, "@OV_RETVAL", DbType.String, 50)
                    objDB.ExecuteNonQuery(objcmd)

                    strStatus = CStr(objDB.GetParameterValue(objcmd, "@OV_RETVAL"))
                End Using
            Catch ex As Exception
                Throw ex
            End Try
            Return strStatus
        End Function
        Public Function UpdatePricesReturnOrder(ByVal objRetSprBO As ReturnSpareBO, user As String) As String
            Try
                Dim strStatus As String = ""
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_UPD_CPSP_RETURN_ORDERS")
                    objDB.AddInParameter(objcmd, "@IV_RETURN_NO", DbType.String, objRetSprBO.ReturnNo)
                    objDB.AddInParameter(objcmd, "@IV_ID_ITEM_RET_NO", DbType.Int32, objRetSprBO.IdItemReturnNo)
                    objDB.AddInParameter(objcmd, "@IV_ID_ITEM", DbType.String, objRetSprBO.IdItem)
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURRENT_NO", DbType.String, objRetSprBO.SupplierNo)
                    objDB.AddInParameter(objcmd, "@IV_SALES_PRICE", DbType.Decimal, objRetSprBO.SalePrice)
                    objDB.AddInParameter(objcmd, "@IV_COST_PRICE", DbType.Decimal, objRetSprBO.CostPrice)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, user)
                    objDB.AddInParameter(objcmd, "@IV_WEB_SPAREPARTD_ID", DbType.String, objRetSprBO.WebSparePartId)

                    objDB.AddOutParameter(objcmd, "@OV_RETVAL", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVAL").ToString
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
End Namespace
