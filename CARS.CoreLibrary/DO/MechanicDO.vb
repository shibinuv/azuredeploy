Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Public Class MechanicDO
    Dim objDB As Database
    Dim ConnectionString As String
    Dim dsMechanicSetting As New DataSet
    Dim dsMechanicConfigSetting As New DataSet
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
    Public Function Mechanic_Search(ByVal custName As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_USER_DETAILS")
                objDB.AddInParameter(objCMD, "@term", DbType.String, custName)

                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Fetch_LeaveCode(ByVal custName As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_LEAVE_CODES")
                objDB.AddInParameter(objCMD, "@term", DbType.String, custName)

                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Fetch_LeaveTypes() As DataSet
        Try

            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_LEAVE_TYPES")

                Return objDB.ExecuteDataSet(objCMD)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function FetchMechanic(objMec As MechanicBO) As DataSet
        Try

            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_SETTINGS_FROMDATE")

                objDB.AddInParameter(objCMD, "@MECHANIC_NAME", DbType.String, "")
                objDB.AddInParameter(objCMD, "@FROM_DATE", DbType.DateTime, objMec.FromDate)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
            Return dsMechanicSetting
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Add_MechanicSettings(ByVal idMechanicSettings As Integer, ByVal fromDate As Date, ByVal toDate As Date, ByVal fromTime As String, ByVal toTime As String, ByVal leaveCode As String, ByVal leaveReason As String, ByVal comments As String, ByVal mechanicName As String, ByVal idLogin As String, ByVal admin As String, ByVal idLeaveTypes As Int32) As DataSet
        Try
            ' Dim dsMechanicLeaveTypes As New DataSet
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_ADD_MECHANIC_SETTINGS")
                objDB.AddInParameter(objCMD, "@ID_MECHANIC_SETTINGS", DbType.Int32, idMechanicSettings)
                objDB.AddInParameter(objCMD, "@ID_LOGIN", DbType.String, idLogin)
                objDB.AddInParameter(objCMD, "@MECHANIC_NAME", DbType.String, mechanicName.Trim())
                objDB.AddInParameter(objCMD, "@FROM_DATE", DbType.Date, fromDate)
                    objDB.AddInParameter(objCMD, "@FROM_TIME", DbType.Time, fromTime)
                    objDB.AddInParameter(objCMD, "@TO_DATE", DbType.Date, toDate)
                objDB.AddInParameter(objCMD, "@TO_TIME", DbType.Time, toTime)
                objDB.AddInParameter(objCMD, "@LEAVE_CODE", DbType.String, leaveCode)
                objDB.AddInParameter(objCMD, "@LEAVE_REASON", DbType.String, leaveReason)
                objDB.AddInParameter(objCMD, "@COMMENTS", DbType.String, comments)
                objDB.AddInParameter(objCMD, "@ID_LEAVE_TYPES", DbType.Int32, idLeaveTypes)

                If (idMechanicSettings = 0) Then

                    objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, admin)
                    objDB.AddInParameter(objCMD, "@MODIFIED_BY", DbType.String, "")
                Else

                    objDB.AddInParameter(objCMD, "@MODIFIED_BY", DbType.String, admin)
                    objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, "")
                End If

                dsMechanicSetting = objDB.ExecuteDataSet(objCMD)
            End Using
            Return dsMechanicSetting
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Add_Mechanic_Config_Setting(bo As MechanicConfigSettingBO) As Integer
        Dim returnValue As Integer
        Try

            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_ADD_MECHANIC_CONFIG_SETTINGS")

            objDB.AddInParameter(objCMD, "@MECHANIC_NAME", DbType.String, bo.MechanicName)
                objDB.AddInParameter(objCMD, "@MECHANIC_ID", DbType.String, bo.MechanicId)

                objDB.AddInParameter(objCMD, "@FLG_FLEX_TIME", DbType.Int32, bo.FlexTime)
                objDB.AddInParameter(objCMD, "@ACTIVE_MEK", DbType.Int32, bo.ActiveMek)
                objDB.AddInParameter(objCMD, "@PASSIVE_MEK", DbType.Int32, bo.PassiveMek)
                objDB.AddInParameter(objCMD, "@ADMINISTRATION_MEK", DbType.Int32, bo.AdministrationMek)
                objDB.AddInParameter(objCMD, "@STANDARD_FROM_TIME", DbType.DateTime, bo.StandardFromTime)
                objDB.AddInParameter(objCMD, "@MONDAY_FROM_TIME", DbType.DateTime, bo.MondayFromTime)
                objDB.AddInParameter(objCMD, "@TUESDAY_FROM_TIME", DbType.DateTime, bo.TuesdayFromTime)
                objDB.AddInParameter(objCMD, "@WEDNESDAY_FROM_TIME", DbType.DateTime, bo.WednesdayFromTime)
                objDB.AddInParameter(objCMD, "@THURSDAY_FROM_TIME", DbType.DateTime, bo.ThursdayFromTime)
                objDB.AddInParameter(objCMD, "@FRIDAY_FROM_TIME", DbType.DateTime, bo.FridayFromTime)
                objDB.AddInParameter(objCMD, "@SATURDAY_FROM_TIME", DbType.DateTime, bo.SaturdayFromTime)
                objDB.AddInParameter(objCMD, "@SUNDAY_FROM_TIME", DbType.DateTime, bo.SundayFromTime)
                objDB.AddInParameter(objCMD, "@LUNCH_FROM_TIME", DbType.DateTime, bo.LunchFromTime)

                objDB.AddInParameter(objCMD, "@STANDARD_TO_TIME", DbType.DateTime, bo.StandardToTime)
                objDB.AddInParameter(objCMD, "@MONDAY_TO_TIME", DbType.DateTime, bo.MondayToTime)
                objDB.AddInParameter(objCMD, "@TUESDAY_TO_TIME", DbType.DateTime, bo.TuesdayToTime)
                objDB.AddInParameter(objCMD, "@WEDNESDAY_TO_TIME", DbType.DateTime, bo.WednesdayToTime)
                objDB.AddInParameter(objCMD, "@THURSDAY_TO_TIME", DbType.DateTime, bo.ThursdayToTime)
                objDB.AddInParameter(objCMD, "@FRIDAY_TO_TIME", DbType.DateTime, bo.FridayToTime)
                objDB.AddInParameter(objCMD, "@SATURDAY_TO_TIME", DbType.DateTime, bo.SaturdayToTime)
                objDB.AddInParameter(objCMD, "@SUNDAY_TO_TIME", DbType.DateTime, bo.SundayToTime)
                objDB.AddInParameter(objCMD, "@LUNCH_TO_TIME", DbType.DateTime, bo.LunchToTime)

                objDB.AddInParameter(objCMD, "@ALT_STANDARD_FROM_TIME", DbType.DateTime, bo.AltStandardFromTime)
                objDB.AddInParameter(objCMD, "@ALT_MONDAY_FROM_TIME", DbType.DateTime, bo.AltMondayFromTime)
                objDB.AddInParameter(objCMD, "@ALT_TUESDAY_FROM_TIME", DbType.DateTime, bo.AltTuesdayFromTime)
                objDB.AddInParameter(objCMD, "@ALT_WEDNESDAY_FROM_TIME", DbType.DateTime, bo.AltWednesdayFromTime)
                objDB.AddInParameter(objCMD, "@ALT_THURSDAY_FROM_TIME", DbType.DateTime, bo.AltThursdayFromTime)
                objDB.AddInParameter(objCMD, "@ALT_FRIDAY_FROM_TIME", DbType.DateTime, bo.AltFridayFromTime)
                objDB.AddInParameter(objCMD, "@ALT_SATURDAY_FROM_TIME", DbType.DateTime, bo.AltSaturdayFromTime)
                objDB.AddInParameter(objCMD, "@ALT_SUNDAY_FROM_TIME", DbType.DateTime, bo.AltSundayFromTime)
                objDB.AddInParameter(objCMD, "@ALT_LUNCH_FROM_TIME", DbType.DateTime, bo.AltLunchFromTime)

                objDB.AddInParameter(objCMD, "@ALT_STANDARD_TO_TIME", DbType.DateTime, bo.AltStandardToTime)
                objDB.AddInParameter(objCMD, "@ALT_MONDAY_TO_TIME", DbType.DateTime, bo.AltMondayToTime)
                objDB.AddInParameter(objCMD, "@ALT_TUESDAY_TO_TIME", DbType.DateTime, bo.AltTuesdayToTime)
                objDB.AddInParameter(objCMD, "@ALT_WEDNESDAY_TO_TIME", DbType.DateTime, bo.AltWednesdayToTime)
                objDB.AddInParameter(objCMD, "@ALT_THURSDAY_TO_TIME", DbType.DateTime, bo.AltThursdayToTime)
                objDB.AddInParameter(objCMD, "@ALT_FRIDAY_TO_TIME", DbType.DateTime, bo.AltFridayToTime)
                objDB.AddInParameter(objCMD, "@ALT_SATURDAY_TO_TIME", DbType.DateTime, bo.AltSaturdayToTime)
                objDB.AddInParameter(objCMD, "@ALT_SUNDAY_TO_TIME", DbType.DateTime, bo.AltSundayToTime)
                objDB.AddInParameter(objCMD, "@ALT_LUNCH_TO_TIME", DbType.DateTime, bo.AltLunchToTime)
                objDB.AddInParameter(objCMD, "@ID_MEC_GROUP", DbType.Int32, bo.MechanicGroupId)
                objDB.AddInParameter(objCMD, "@MEC_GROUP_NAME", DbType.String, bo.MechanicGroupName)
                objDB.AddInParameter(objCMD, "@ID_MEC_GROUPINGS", DbType.String, bo.MechanicGroupIds)

                objDB.AddInParameter(objCMD, "@USER_NAME", DbType.String, bo.CreatedBy)
            returnValue = objDB.ExecuteNonQuery(objCMD)
        End Using
        Catch ex As Exception
                Throw ex
        End Try
        Return returnValue
        End Function

    Friend Function Fetch_Mechanic_Details_On_Grid(objMec As MechanicBO) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_SETTINGS_FROMDATE")

                objDB.AddInParameter(objCMD, "@MECHANIC_NAME", DbType.String, objMec.Mechanic_Name.Trim())
                objDB.AddInParameter(objCMD, "@FROM_DATE", DbType.DateTime, objMec.FromDate)
                objDB.AddInParameter(objCMD, "@ID_LOGIN", DbType.String, objMec.Id_Login.Trim())
                Return objDB.ExecuteDataSet(objCMD)
            End Using

        Catch ex As Exception
            Throw ex
        End Try
    End Function
        Friend Sub Delete_Mechanic_Settings(idMechanicSettings As Integer)
            Try
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_DELETE_MECHANIC_SETTINGS")

                    objDB.AddInParameter(objCMD, "@ID_MECHANIC_SETTINGS", DbType.Int32, idMechanicSettings)
                    objDB.ExecuteNonQuery(objCMD)
                End Using

            Catch ex As Exception
                Throw ex
            End Try
        End Sub
    Public Function FetchMechanicConfigSettings(mechanicName As String, mechanicId As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_CONFIG_SETTINGS")

                objDB.AddInParameter(objCMD, "@MECHANIC_NAME", DbType.String, mechanicName.Trim)
                objDB.AddInParameter(objCMD, "@MECHANIC_ID", DbType.String, mechanicId.Trim)
                dsMechanicConfigSetting = objDB.ExecuteDataSet(objCMD)
            End Using
            Return dsMechanicConfigSetting
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Fetch_MechanicGroups() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHAIC_GROUPS")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class
