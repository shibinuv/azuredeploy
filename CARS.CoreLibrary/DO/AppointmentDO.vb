Imports System.Data.Common
Imports System.Web
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Public Class AppointmentDO
    Dim objDB As Database
    Dim ConnectionString As String
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub
    Public Function FetchAppointments() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_APPOINTMENTS")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function FetchMechanicDetails() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_DETAILS")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Function FetchLabelColor() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_LABEL_COLOR")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function FetchAppointmentDetails(appointmentId As Integer) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_APPOINTMENT_DETAILS")
                objDB.AddInParameter(objCMD, "@APPOINTMENT_ID", DbType.Int32, appointmentId)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function ProcessOrders(appointmentId As Integer, idAppointmentDetails As Integer, WO_NO As String, WOSTATUS As String, WO_PREFIX As String) As String
        Dim strResult As String = ""
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_CREATE_APPOINTMENT_JOB_UPDATE")
                objDB.AddInParameter(objCMD, "@IV_APPOINTMENT_ID", DbType.Int32, appointmentId)
                objDB.AddInParameter(objCMD, "@IV_USERID", DbType.String, HttpContext.Current.Session("UserID"))
                objDB.AddInParameter(objCMD, "@IV_WO_PREFIX", DbType.String, WO_PREFIX)
                objDB.AddInParameter(objCMD, "@IV_WO_NO", DbType.String, WO_NO)
                objDB.AddOutParameter(objCMD, "@IV_RETVALUE", DbType.String, 50)
                'objDB.AddInParameter(objCMD, "@ID_JOB", DbType.Int32, 0)

                Return objDB.ExecuteNonQuery(objCMD)
                strResult = objDB.GetParameterValue(objCMD, "@IV_RETVALUE")
            End Using

        Catch ex As Exception
            Throw ex
        End Try
        Return strResult

    End Function
    Public Function ProcessAppointment(action As String, appointmentId As Integer, startDate As DateTime, endDate As DateTime, subject As String, appointmentType As String,
                                description As String, status As String, label As String, resourceId As String, resourceIDs As String, customerNo As String, firstName As String, middleName As String,
                                lastName As String, firm As Integer, regNo As String, refNo As String, chNo As String, rentalCar As Integer, periodicCheck As Integer, periodicService As Integer, customInfo As String, vehicleID As Integer, vehicleMake As Integer, vehicleModel As String, loginName As String) As Integer
        Try
            Dim latestAppointmenID As Integer
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_PROCESS_APPOINTMENTS_HEADER")

                objDB.AddInParameter(objCMD, "@ACTION", DbType.String, action)
                objDB.AddInParameter(objCMD, "@APPOINTMENT_ID", DbType.Int32, Convert.ToInt32(customInfo))
                objDB.AddInParameter(objCMD, "@APPOINTMENT_TYPE", DbType.Int32, appointmentType)
                objDB.AddInParameter(objCMD, "@START_DATE", DbType.DateTime, startDate)
                objDB.AddInParameter(objCMD, "@END_DATE", DbType.DateTime, endDate)
                objDB.AddInParameter(objCMD, "@SUBJECT", DbType.String, subject)
                objDB.AddInParameter(objCMD, "@DESCRIPTION", DbType.String, description)
                objDB.AddInParameter(objCMD, "@STATUS", DbType.String, status)
                objDB.AddInParameter(objCMD, "@LABEL", DbType.String, label)
                objDB.AddInParameter(objCMD, "@RESOURCE_IDs", DbType.String, resourceIDs)
                objDB.AddInParameter(objCMD, "@CUSTOMER_FIRST_NAME", DbType.String, firstName)
                objDB.AddInParameter(objCMD, "@CUSTOMER_MIDDLE_NAME", DbType.String, middleName)
                objDB.AddInParameter(objCMD, "@CUSTOMER_LAST_NAME", DbType.String, lastName)
                objDB.AddInParameter(objCMD, "@CUSTOMER_FIRM", DbType.Int32, firm)
                objDB.AddInParameter(objCMD, "@VEHICLE_REG_NO", DbType.String, regNo)
                objDB.AddInParameter(objCMD, "@VEHICLE_REF_NO", DbType.String, refNo)
                objDB.AddInParameter(objCMD, "@VEHICLE_CH_NO", DbType.String, chNo)
                objDB.AddInParameter(objCMD, "@VEHICLE_RENTAL_CAR", DbType.String, rentalCar)
                objDB.AddInParameter(objCMD, "@VEHICLE_PERIODIC_CHECK", DbType.String, periodicCheck)
                objDB.AddInParameter(objCMD, "@VEHICLE_PERIODIC_SERVICE", DbType.String, periodicService)
                objDB.AddInParameter(objCMD, "@CUSTOMER_NUMBER", DbType.String, customerNo)
                objDB.AddInParameter(objCMD, "@ID_VEH_SEQ_WO", DbType.Int32, vehicleID)
                objDB.AddInParameter(objCMD, "@WO_VEH_MAK_MOD_MAP", DbType.Int32, vehicleMake)
                objDB.AddInParameter(objCMD, "@WO_VEH_MOD", DbType.String, vehicleModel)
                objDB.AddInParameter(objCMD, "@USER", DbType.String, loginName)
                objDB.AddOutParameter(objCMD, "@LATEST_ID", DbType.Int32, 50)

                objDB.ExecuteNonQuery(objCMD)
                latestAppointmenID = objDB.GetParameterValue(objCMD, "@LATEST_ID")
                Return latestAppointmenID
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub ProcessAppointmentDetails(Action As String, GridViewId As Integer, StartDate As DateTime, StartTime As DateTime, EndDate As DateTime, EndTime As DateTime, Text As String, Reservation As String, Search As String, AppointmentId As Integer, ResourceId As String, LoginName As String, ColorCode As String, JobStatusId As Integer, textLine1 As String, textLine2 As String, textLine3 As String, textLine4 As String, textLine5 As String, sparePartStatus As Integer, overtime As Boolean)
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_PROCESS_APPOINTMENT_DETAILS_SPLIT")
                objDB.AddInParameter(objCMD, "@ACTION", DbType.String, Action)
                objDB.AddInParameter(objCMD, "@ID_APPOINTMENT_DETAILS", DbType.Int32, GridViewId)
                objDB.AddInParameter(objCMD, "@START_DATE", DbType.DateTime, StartTime)
                objDB.AddInParameter(objCMD, "@END_DATE", DbType.DateTime, EndTime)
                objDB.AddInParameter(objCMD, "@RESERVATION", DbType.String, Reservation)
                objDB.AddInParameter(objCMD, "@SEARCH", DbType.String, Search)
                objDB.AddInParameter(objCMD, "@TEXT", DbType.String, Text)
                objDB.AddInParameter(objCMD, "@APPOINTMENT_ID", DbType.Int32, AppointmentId)
                objDB.AddInParameter(objCMD, "@RESOURCE_ID", DbType.String, ResourceId)
                objDB.AddInParameter(objCMD, "@START_TIME", DbType.DateTime, StartTime)
                objDB.AddInParameter(objCMD, "@END_TIME", DbType.DateTime, EndTime)
                objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, LoginName)
                objDB.AddInParameter(objCMD, "@COLOR_CODE", DbType.String, ColorCode)
                objDB.AddInParameter(objCMD, "@JOB_STATUS_ID", DbType.Int32, JobStatusId)
                objDB.AddInParameter(objCMD, "@TEXT_LINE1", DbType.String, textLine1)
                objDB.AddInParameter(objCMD, "@TEXT_LINE2", DbType.String, textLine2)
                objDB.AddInParameter(objCMD, "@TEXT_LINE3", DbType.String, textLine3)
                objDB.AddInParameter(objCMD, "@TEXT_LINE4", DbType.String, textLine4)
                objDB.AddInParameter(objCMD, "@TEXT_LINE5", DbType.String, textLine5)
                objDB.AddInParameter(objCMD, "@SPARE_PART_STATUS", DbType.Int32, sparePartStatus)
                objDB.AddInParameter(objCMD, "@overtime", DbType.Boolean, overtime)
                objDB.ExecuteNonQuery(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub ModifyAppointmentDetails(IdAppointmentDetails As Integer, StartDate As DateTime, EndDate As DateTime, ResourceId As String, ResourceIDs As String, sparePartStatus As Integer)
        Try
        Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_MODIFY_APPOINTMENT_DETAILS")

            objDB.AddInParameter(objCMD, "@ID_APPOINTMENT_DETAILS", DbType.Int32, IdAppointmentDetails)
            objDB.AddInParameter(objCMD, "@START_DATE", DbType.DateTime, StartDate)
            objDB.AddInParameter(objCMD, "@END_DATE", DbType.DateTime, EndDate)
            objDB.AddInParameter(objCMD, "@RESOURCE_ID", DbType.String, ResourceId)
            objDB.AddInParameter(objCMD, "@RESOURCE_IDs", DbType.String, ResourceIDs)
                objDB.AddInParameter(objCMD, "@APT_SAPRE_PART_STATUS", DbType.Int32, sparePartStatus)

                objDB.ExecuteNonQuery(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function FetchVehicleList() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("usp_WO_HEADER_LOAD")

                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Function FetchExistingOrders(customerNo As String, vehicleID As Integer, selGridViewId As Integer, selApptId As Integer) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_ORDER_LIST")
                objDB.AddInParameter(objCMD, "@ID_CUST_WO", DbType.String, customerNo)
                objDB.AddInParameter(objCMD, "@ID_VEH_SEQ_WO", DbType.Int32, vehicleID)
                objDB.AddInParameter(objCMD, "@ID_APT_DTL", DbType.Int32, selGridViewId)
                objDB.AddInParameter(objCMD, "@ID_APT_HDR", DbType.Int32, selApptId)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Function FetchLeaveDetails(start As Date, idLogin As String)
        Dim checkDate As New Date
        Try
            If (start <> checkDate Or idLogin <> "DevExpress.XtraScheduler.EmptyResourceId") Then
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_DAY_DETAILS")
                    objDB.AddInParameter(objCMD, "@FROM_DATE", DbType.DateTime, start)
                    objDB.AddInParameter(objCMD, "@ID_LOGIN", DbType.String, idLogin)
                    Return objDB.ExecuteDataSet(objCMD)
                End Using
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function CreateOrderOnAppointment(appointmentId As Integer, appmntDetId As Integer, customerId As String, vehicleId As Integer, resourceId As String, userId As String) As String
        Dim ov_Status As String = ""
        Dim ov_NewOrderDetails As String = ""
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_CREATE_APPOINTMENT_JOB")
                objDB.AddInParameter(objCMD, "@iv_appointment_id", DbType.Int32, appointmentId)
                'objDB.AddInParameter(objCMD, "@iv_appointment_detail_id", DbType.Int32, appmntDetId)
                objDB.AddInParameter(objCMD, "@IV_USERID", DbType.String, userId)
                'objDB.AddInParameter(objCMD, "@iv_created_date", DbType.String, Nothing)
                'objDB.AddInParameter(objCMD, "@iv_ord_date", DbType.String, Nothing)
                objDB.AddOutParameter(objCMD, "@iv_retvalue", DbType.String, 50)
                objDB.ExecuteNonQuery(objCMD)
                ov_Status = objDB.GetParameterValue(objCMD, "@iv_retvalue")
            End Using

        Catch ex As Exception
            Throw ex
        End Try

        Return ov_Status
    End Function

    Public Function FetchMechHolidays() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECH_HOLIDAYS")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch Ex As Exception
            Throw Ex
        End Try

    End Function
    Public Function ProcessOnHoldAppointment(idAppointmentDetails As Integer, action As String, startDate As DateTime, endDate As DateTime, resourceId As String) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_PROCESS_ONHOLD_APPOINTMENT")
                objDB.AddInParameter(objCMD, "@ACTION", DbType.String, action)
                objDB.AddInParameter(objCMD, "@ID_APT_DTL", DbType.Int32, idAppointmentDetails)
                'objDB.AddInParameter(objCMD, "@ID_APT_HDR", DbType.Int32, appointmentId)
                objDB.AddInParameter(objCMD, "@START_DATE", DbType.DateTime, startDate)
                objDB.AddInParameter(objCMD, "@END_DATE", DbType.DateTime, endDate)
                objDB.AddInParameter(objCMD, "@RESOURCE_ID", DbType.String, resourceId)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch Ex As Exception
            Throw Ex
        End Try

    End Function

    Public Function CopyAppointment(AppointmentId As Integer, AppmntDetId As Integer, StartDate As DateTime, StartTime As DateTime, EndDate As DateTime, EndTime As DateTime, ResourceId As String, LoginName As String) As String
        Dim ov_Status As String = ""
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_COPY_APPOINTMENT")
                objDB.AddInParameter(objCMD, "@APPOINTMENT_ID", DbType.Int32, AppointmentId)
                objDB.AddInParameter(objCMD, "@ID_APPOINTMENT_DETAILS", DbType.Int32, AppmntDetId)
                objDB.AddInParameter(objCMD, "@START_DATE", DbType.DateTime, StartTime)
                objDB.AddInParameter(objCMD, "@START_TIME", DbType.DateTime, StartTime)
                objDB.AddInParameter(objCMD, "@END_DATE", DbType.DateTime, EndTime)
                objDB.AddInParameter(objCMD, "@END_TIME", DbType.DateTime, EndTime)
                objDB.AddInParameter(objCMD, "@RESOURCE_ID", DbType.String, ResourceId)
                objDB.AddInParameter(objCMD, "@CREATED_BY", DbType.String, LoginName)
                objDB.AddOutParameter(objCMD, "@IV_RETVALUE", DbType.String, 50)
                objDB.ExecuteNonQuery(objCMD)
                ov_Status = objDB.GetParameterValue(objCMD, "@IV_RETVALUE")
            End Using
        Catch ex As Exception
            Throw ex
        End Try
        Return ov_Status
    End Function

    Public Function FetchTreeListMechanicDetails() As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_MECHANIC_DETAILS_NEW")
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Function FetchAllAppointments(user As String, selDate As DateTime, isHistory As Boolean) As DataSet
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_ALL_APPOINTMENTS")
                objDB.AddInParameter(objCMD, "@IV_USER_ID", DbType.String, user)
                objDB.AddInParameter(objCMD, "@IV_SEL_DATETIME", DbType.DateTime, selDate)
                objDB.AddInParameter(objCMD, "@IV_IS_HISTORY", DbType.Boolean, isHistory)
                Return objDB.ExecuteDataSet(objCMD)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function DeleteAppointmentDetExt(gridViewId As Integer, aptId As Integer, user As String) As String
        Dim retVal As String = ""
        Try
            Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_DELETE_APPOINTMENT_DETAILS_EXT")
                objDB.AddInParameter(objCMD, "@ID_APPOINTMENT_DETAILS", DbType.Int32, gridViewId)
                objDB.AddInParameter(objCMD, "@APPOINTMENT_ID", DbType.Int32, aptId)
                objDB.AddInParameter(objCMD, "@MODIFIED_BY", DbType.String, user)
                objDB.AddOutParameter(objCMD, "@OV_RETVALUE", DbType.String, 50)
                objDB.ExecuteNonQuery(objCMD)
                retVal = objDB.GetParameterValue(objCMD, "@OV_RETVALUE")
            End Using
        Catch ex As Exception
            Throw ex
        End Try
        Return retVal
    End Function
End Class
