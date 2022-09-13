Imports System.Data.Common
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Namespace CARS.DayPlanSettings
    Public Class DayPlanSettingsDO
        Dim ConnectionString As String
        Dim objDB As Database
        Dim strStatus As String

        Public Sub New()
            ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            objDB = New SqlDatabase(ConnectionString)
        End Sub
        Public Function FetchAllOrderStatuses() As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_WO_STATUS_COLOR")
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Save_WOOrderStatus(ByVal objDayPlanSettingsBO As DayPlanSettingsBO, ByVal userId As String) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_WORK_ORDER_STATUS")
                    objDB.AddInParameter(objcmd, "@MODE", DbType.String, objDayPlanSettingsBO.Mode)
                    objDB.AddInParameter(objcmd, "@ID_ORDER_STATUS", DbType.Int32, objDayPlanSettingsBO.IdOrderStatus)
                    objDB.AddInParameter(objcmd, "@ORDER_STATUS_CODE", DbType.String, objDayPlanSettingsBO.OrderStatusCode)
                    objDB.AddInParameter(objcmd, "@ORDER_STATUS_DESC", DbType.String, objDayPlanSettingsBO.OrderStatusDesc)
                    objDB.AddInParameter(objcmd, "@ORDER_STATUS_COLOR", DbType.String, objDayPlanSettingsBO.OrderStatusColor)
                    objDB.AddInParameter(objcmd, "@USER", DbType.String, userId)
                    objDB.AddOutParameter(objcmd, "@RES_OUTPUT", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@RES_OUTPUT").ToString '+ "," + objDB.GetParameterValue(objcmd, "@RES_OUTPUT").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                Return strStatus
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Save_AppointmentStatus(ByVal objDayPlanSettingsBO As DayPlanSettingsBO, ByVal userId As String) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_APPOINTMENT_STATUS")
                    objDB.AddInParameter(objcmd, "@MODE", DbType.String, objDayPlanSettingsBO.Mode)
                    objDB.AddInParameter(objcmd, "@ID_APPT_STATUS", DbType.Int32, objDayPlanSettingsBO.IdAppointmentStatus)
                    objDB.AddInParameter(objcmd, "@APPT_STATUS_CODE", DbType.String, objDayPlanSettingsBO.AppointmentStatusCode)
                    objDB.AddInParameter(objcmd, "@APPT_STATUS_COLOR", DbType.String, objDayPlanSettingsBO.AppointmentStatusColor)
                    objDB.AddInParameter(objcmd, "@USER", DbType.String, userId)
                    objDB.AddOutParameter(objcmd, "@RES_OUTPUT", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@RES_OUTPUT").ToString()
                    Catch ex As Exception
                        Throw ex
                    End Try
                End Using
                Return strStatus
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Save_ConfigAppmntSettings(ByVal objDayPlanSettingsBO As DayPlanSettingsBO, ByVal userId As String) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_APPOINTMENT_CONFIG_SETTINGS")
                    objDB.AddInParameter(objcmd, "@ID_CONFIG_APPOINTMENT", DbType.Int32, Convert.ToInt32(objDayPlanSettingsBO.IdConfigAppmnt))
                    objDB.AddInParameter(objcmd, "@LAST_APPOINTMENT_NUMBER", DbType.Int32, Convert.ToInt32(objDayPlanSettingsBO.LastAppmntNum))
                    objDB.AddInParameter(objcmd, "@MINIMUM_APPOINTMENT_TIME", DbType.Int32, Convert.ToInt32(objDayPlanSettingsBO.MinAppmntTime))
                    objDB.AddInParameter(objcmd, "@APPOINTMENT_START_TIME_HOUR", DbType.String, objDayPlanSettingsBO.AppmntStartTimeHr)
                    objDB.AddInParameter(objcmd, "@APPOINTMENT_START_TIME_MINUTES", DbType.String, objDayPlanSettingsBO.AppmntStartTimeMin)
                    objDB.AddInParameter(objcmd, "@APPOINTMENT_STOP_TIME_HOUR", DbType.String, objDayPlanSettingsBO.AppmntStopTimeHr)
                    objDB.AddInParameter(objcmd, "@APPOINTMENT_STOP_TIME_MINUTES", DbType.String, objDayPlanSettingsBO.AppmntStopTimeMin)
                    objDB.AddInParameter(objcmd, "@HISTORY_LIMIT", DbType.Int32, Convert.ToInt32(objDayPlanSettingsBO.HistoryLimit))
                    objDB.AddInParameter(objcmd, "@DISPLAY_SATSUN", DbType.Boolean, Convert.ToBoolean(objDayPlanSettingsBO.DispShwSatSund))
                    objDB.AddInParameter(objcmd, "@MECHANIC_PER_PAGE", DbType.Int32, Convert.ToInt32(objDayPlanSettingsBO.MechanicPerPage))
                    objDB.AddInParameter(objcmd, "@USER", DbType.String, userId)
                    objDB.AddInParameter(objcmd, "@CTRL_BY_STD", DbType.Boolean, Convert.ToBoolean(objDayPlanSettingsBO.ControlledByStandard))
                    objDB.AddInParameter(objcmd, "@CTRL_BY_MEC", DbType.Boolean, Convert.ToBoolean(objDayPlanSettingsBO.ControlledByMechanic))
                    objDB.AddInParameter(objcmd, "@CTRL_BY_STATUS", DbType.Boolean, Convert.ToBoolean(objDayPlanSettingsBO.ControlledByStatus))
                    objDB.AddInParameter(objcmd, "@SHOW_ONHOLD_ONLOAD", DbType.Boolean, objDayPlanSettingsBO.ShowOnHoldOnLoad)
                    objDB.AddOutParameter(objcmd, "@RES_OUTPUT", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@RES_OUTPUT").ToString + "," + objDB.GetParameterValue(objcmd, "@RES_OUTPUT").ToString
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

