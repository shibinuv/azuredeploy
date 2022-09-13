
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Imports System.Web
Namespace CARS.Services.ConfigMechanicSettings
Public Class Mechanic
    Shared objMecDO As New MechanicDO
    Shared dataSet As DataSet
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Dim objDB As Database
    Dim ConnectionString As String
    Dim dsMechanicSetting As New DataSet
        Dim dsMechanicConfigSetting As New DataSet
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
    Public Function MechanicSearch(ByVal q As String) As List(Of MechanicBO)
        Dim dsMechanic As New DataSet
        Dim dtMechanic As DataTable
        Dim mechanicSearchResult As New List(Of MechanicBO)()

        Try
            dsMechanic = objMecDO.Mechanic_Search(q)

            If dsMechanic.Tables.Count > 0 Then
                dtMechanic = dsMechanic.Tables(0)
            End If
            If q <> String.Empty Then
                For Each dtrow As DataRow In dtMechanic.Rows
                    Dim mcr As New MechanicBO()
                    mcr.Id_Login = dtrow("ID_Login").ToString
                    mcr.First_Name = dtrow("First_Name").ToString
                    mcr.Last_Name = dtrow("Last_Name").ToString

                    mechanicSearchResult.Add(mcr)
                Next
            End If
        Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "MechanicSearch", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return mechanicSearchResult
    End Function
    Public Function FetchLeaveCode(ByVal q As String) As List(Of MechanicLeaveTypesBO)
        Dim dsMechanic As New DataSet
        Dim dtMechanic As DataTable
        Dim mechanicLeaveCodeResult As New List(Of MechanicLeaveTypesBO)()

        Try
            dsMechanic = objMecDO.Fetch_LeaveCode(q)

            If dsMechanic.Tables.Count > 0 Then
                dtMechanic = dsMechanic.Tables(0)
            End If
            If q <> String.Empty Then
                For Each dtrow As DataRow In dtMechanic.Rows
                    Dim mcr As New MechanicLeaveTypesBO()
                    mcr.Leave_Description = dtrow("LEAVE_DESCRIPTION").ToString
                    mcr.Leave_Code = dtrow("LEAVE_CODE").ToString
                        mcr.Id_Leave_Types = dtrow("ID_LEAVE_TYPES").ToString

                        mechanicLeaveCodeResult.Add(mcr)
                    Next
                End If
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "FetchLeaveCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))

            End Try
            Return mechanicLeaveCodeResult
        End Function
        Public Function FetchLeaveTypes() As DataSet
            Dim ds As New DataSet
            ds = objMecDO.Fetch_LeaveTypes()
            Return ds
        End Function
        Public Function FetchMechanicSetting(objMec As MechanicBO) As DataSet
            Try
                dataSet = objMecDO.FetchMechanic(objMec)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "FetchMechanicSetting", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))

            End Try
            Return dataSet
        End Function

        Public Function AddMechanicSettings(bo As MechanicBO, admin As String) As DataSet
            Dim ds As New DataSet
            Try
                ds = objMecDO.Add_MechanicSettings(bo.IdMechanicSettings, bo.FromDate, bo.ToDate, bo.Fromtime, bo.Totime, bo.Leave_Code, bo.Leave_Reason, bo.Comments, bo.Mechanic_Name, bo.Id_Login, admin, bo.IdLeaveTypes)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "AddMechanicSettings", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return ds

    End Function

    Public Function AddMechanicConfigSetting(bo As MechanicConfigSettingBO) As Integer
        Dim returnValue As New Integer
        Try
            returnValue = objMecDO.Add_Mechanic_Config_Setting(bo)
        Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "AddMechanicConfigSetting", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return returnValue

    End Function

        Public Sub DeleteMechanicSettings(bo As MechanicBO)
            Try
                objMecDO.Delete_Mechanic_Settings(bo.IdMechanicSettings)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "DeleteMechanicSettings", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))

            End Try
        End Sub
        Public Function FetchMechanicDetailsOnGrid(objMec As MechanicBO) As DataSet
            Dim result As Integer = 1
            Try
                dsMechanicSetting = objMecDO.Fetch_Mechanic_Details_On_Grid(objMec)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "FetchMechanicDetailsOnGrid", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))

            End Try
            Return dsMechanicSetting
        End Function
        Public Function FetchMechanicDetailsOnScreen(objMecConfigSetting As MechanicConfigSettingBO) As DataSet

            Try
                dsMechanicConfigSetting = objMecDO.FetchMechanicConfigSettings(objMecConfigSetting.MechanicName, objMecConfigSetting.MechanicId)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigMechanicSettings", "FetchMechanicDetailsOnScreen", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))

            End Try
            Return dsMechanicConfigSetting
        End Function
        Public Function FetchMechanicGroups() As DataSet
            Dim ds As New DataSet
            ds = objMecDO.Fetch_MechanicGroups()
            Return ds
        End Function
End Class
End Namespace