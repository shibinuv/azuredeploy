Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System
Imports System.Configuration
Imports System.Data.Common
Namespace CARS.MechanicLeaveTypes
    Public Class MechanicLeaveTypesDO

        Dim ConnectionString As String = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        Dim objDB As Database = New SqlDatabase(ConnectionString)
        Dim dsMechanicLeaveTypes As New DataSet
        Dim strStatus As String

        Public Function Fetch_LeaveTypes() As DataSet
            Try

                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_LEAVE_TYPES")

                    dsMechanicLeaveTypes = objDB.ExecuteDataSet(objCMD)
                End Using
                Return dsMechanicLeaveTypes
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Add_LeaveTypes(ByVal leaveCode As String, ByVal leaveDescription As String, ByVal approveCode As String, ByVal admin As String) As String
            Try
                ' Dim dsMechanicLeaveTypes As New DataSet
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_ADD_MECHANIC_LEAVE_TYPES")
                    objDB.AddInParameter(objCMD, "@LEAVE_CODE", DbType.String, leaveCode)
                    objDB.AddInParameter(objCMD, "@LEAVE_DESCRIPTION", DbType.String, leaveDescription)
                    objDB.AddInParameter(objCMD, "@APPROVE_CODE", DbType.String, approveCode)
                    objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, admin)
                    objDB.AddOutParameter(objCMD, "@RES_OUTPUT", DbType.String, 50)
                    'dsMechanicLeaveTypes = objDB.ExecuteDataSet(objCMD)
                    objDB.ExecuteNonQuery(objCMD)
                    strStatus = objDB.GetParameterValue(objCMD, "@RES_OUTPUT").ToString
                End Using
                'Return dsMechanicLeaveTypes
                Return strStatus
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Delete_LeaveTypes(ByVal idLeaveTypes As Integer) As String
            Try
                ' Dim dsMechanicLeaveTypes As New DataSet
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_DELETE_MECHANIC_LEAVE_TYPES")
                    objDB.AddInParameter(objCMD, "@ID_LEAVE_TYPES", DbType.Int32, idLeaveTypes)
                    objDB.AddOutParameter(objCMD, "@RES_OUTPUT", DbType.String, 50)
                    objDB.AddOutParameter(objCMD, "@RES_OUTPUT_CODE", DbType.String, 50)
                    'dsMechanicLeaveTypes = objDB.ExecuteDataSet(objCMD)
                    strStatus = objDB.ExecuteNonQuery(objCMD)
                    strStatus = objDB.GetParameterValue(objCMD, "@RES_OUTPUT").ToString + "," + objDB.GetParameterValue(objCMD, "@RES_OUTPUT_CODE").ToString
                End Using
                'Return dsMechanicLeaveTypes
                Return strStatus
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Modify_LeaveTypes(ByVal idLeaveTypes As Integer, ByVal leaveCode As String, ByVal leaveDescription As String, ByVal approveCode As String, ByVal admin As String) As DataSet
            Try
                'Dim dsMechanicLeaveTypes As New DataSet
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_MODIFY_MECHANIC_LEAVE_TYPES")
                    objDB.AddInParameter(objCMD, "@ID_LEAVE_TYPES", DbType.Int32, idLeaveTypes)
                    objDB.AddInParameter(objCMD, "@LEAVE_CODE", DbType.String, leaveCode)
                    objDB.AddInParameter(objCMD, "@LEAVE_DESCRIPTION", DbType.String, leaveDescription)
                    objDB.AddInParameter(objCMD, "@APPROVE_CODE", DbType.String, approveCode)
                    objDB.AddInParameter(objCMD, "@MODIFIED_BY", DbType.String, admin)


                    dsMechanicLeaveTypes = objDB.ExecuteDataSet(objCMD)
                End Using
                Return dsMechanicLeaveTypes
            Catch ex As Exception
                Throw ex
            End Try
        End Function
    End Class
End Namespace
