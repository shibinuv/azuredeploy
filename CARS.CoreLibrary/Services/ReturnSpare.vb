Imports System.Web
Namespace CARS.Services.ReturnSpare
    Public Class ReturnSpare
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
        Shared objRetSprBO As New ReturnSpareBO
        Shared objRetSprDO As New CARS.ReturnSpareDO.ReturnSpareDO
        Public Function Fetch_Return_Spare_Header(searchStr As String) As DataSet
            Dim dsResult As New DataSet
            Dim loginName As String = HttpContext.Current.Session("UserID")
            Try
                dsResult = objRetSprDO.FetchReturnSpareHeader(searchStr, loginName)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ReturnSpare", "Fetch_Return_Spare_Header", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return dsResult
        End Function

        Public Function Fetch_Return_Spare_Details(returnNumber As Integer) As DataSet
            Dim dsResult As New DataSet
            Dim loginName As String = HttpContext.Current.Session("UserID")
            Try
                dsResult = objRetSprDO.FetchReturnSpareDetails(returnNumber, loginName)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ReturnSpare", "Fetch_Return_Spare_Details", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return dsResult
        End Function
        Public Function Fetch_Return_Code(q As String) As List(Of ReturnSpareBO)
            Dim dsRetCode As New DataSet
            Dim dtRetCode As DataTable
            Dim retCodeCodeResult As New List(Of ReturnSpareBO)()
            Try
                dsRetCode = objRetSprDO.FetchReturnCode(q)

                If dsRetCode.Tables.Count > 0 Then
                    dtRetCode = dsRetCode.Tables(0)
                End If
                'If q <> String.Empty Then
                For Each dtrow As DataRow In dtRetCode.Rows
                        Dim rsc As New ReturnSpareBO()
                        rsc.ReturnCodeDesc = dtrow("RETURN_DESCRIPTION").ToString
                        rsc.ReturnCode = Integer.Parse(dtrow("RETURN_CODE"))

                        retCodeCodeResult.Add(rsc)
                    Next
                'End If
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ReturnSpare", "Fetch_Return_Code", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))

            End Try
            Return retCodeCodeResult
        End Function

        Public Function Modify_Return_Code(idItemDltret As Integer, returnCode As String) As String
            Dim strResult As String = ""
            Dim loginName As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objRetSprDO.ModifyReturnCode(idItemDltret, returnCode, loginName)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ReturnSpare", "Modify_Return_Code", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function

        Public Function Update_Return_Orders(objRetSprBO As ReturnSpareBO) As String
            Dim strResult As String = ""
            Dim loginName As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objRetSprDO.ModifyReturnSpareHead(objRetSprBO, loginName)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ReturnSpare", "Update_Return_Orders", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function
        Public Function Update_Prices_ReturnOrder(ByVal objRetSprBO As ReturnSpareBO) As String
            Dim strResult As String = ""
            Dim loginName As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objRetSprDO.UpdatePricesReturnOrder(objRetSprBO, loginName)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ReturnSpare", "Update_Prices_ReturnOrder", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function
    End Class
End Namespace
