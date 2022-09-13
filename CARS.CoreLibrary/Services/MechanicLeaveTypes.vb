Imports CARS.CoreLibrary.CARS.MechanicLeaveTypes
Imports System
Imports System.Configuration
Imports System.Data.Common
Imports System.Data
Imports System.Web
Namespace CARS.Services.ConfigMechanicLeaveTypes

    Public Class MechanicLeaveTypes
        Shared objMechanicLeaveTypesDO As New MechanicLeaveTypesDO
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
        Shared dataSet As DataSet
        Shared objMechanicLeaveTypesBO As MechanicLeaveTypesBO
        Public Function FetchLeaveTypes() As DataSet

            Try
                dataSet = objMechanicLeaveTypesDO.Fetch_LeaveTypes()

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicLeaveTypes", "FetchLeaveTypes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return dataSet
        End Function

        Public Function AddLeaveTypes(bo As MechanicLeaveTypesBO, admin As String) As String
            Dim strRes As String = ""
            Try
                strRes = objMechanicLeaveTypesDO.Add_LeaveTypes(bo.Leave_Code, bo.Leave_Description, bo.Approve_Code, admin)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicLeaveTypes", "AddLeaveTypes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strRes
        End Function

        Public Function ModifyLeaveTypes(bo As MechanicLeaveTypesBO, admin As String)

            Try
                objMechanicLeaveTypesDO.Modify_LeaveTypes(bo.Id_Leave_Types, bo.Leave_Code, bo.Leave_Description, bo.Approve_Code, admin)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicLeaveTypes", "ModifyLeaveTypes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try

        End Function

        Public Function DeleteLeaveTypes(bo As MechanicLeaveTypesBO) As String
            Dim strResult As String = ""
            Try
                strResult = objMechanicLeaveTypesDO.Delete_LeaveTypes(bo.Id_Leave_Types)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicLeaveTypes", "RemoveLeaveTypes", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function
    End Class
End Namespace
