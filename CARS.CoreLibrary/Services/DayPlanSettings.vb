
Imports System.Web

Namespace CARS.Services.ConfigDayPlanSettings
    Public Class DayPlanSettings

        Shared objDayPlanSettDO As New CARS.DayPlanSettings.DayPlanSettingsDO
        Shared objCommonUtil As New CARS.Utilities.CommonUtility
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
        Public Function LoadWOOrderStatus() As DataSet
            Dim dsFetchOrdStatus As DataSet
            Dim details As New List(Of DayPlanSettingsBO)()

            Try
                dsFetchOrdStatus = objDayPlanSettDO.FetchAllOrderStatuses()

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigDayPlanSettings", "LoadWOOrderStatus", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            ' Return details.ToList
            Return dsFetchOrdStatus
        End Function

        Public Function SaveOrderStatus(ByVal objDPSettingsBO As DayPlanSettingsBO) As String
            Dim strResult As String = ""
            Try
                strResult = objDayPlanSettDO.Save_WOOrderStatus(objDPSettingsBO, HttpContext.Current.Session("UserID").ToString())
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigDayPlanSettings", "SaveOrderStatus", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function
        Public Function SaveAppointmentStatus(ByVal objDPSettingsBO As DayPlanSettingsBO) As String
            Dim strResult As String = ""
            Try
                strResult = objDayPlanSettDO.Save_AppointmentStatus(objDPSettingsBO, HttpContext.Current.Session("UserID").ToString())
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigDayPlanSettings", "SaveOrderStatus", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function

        Public Function Save_AppmntConfigSettings(ByVal objItemsBO As DayPlanSettingsBO) As String()
            Dim strResult As String = ""
            Dim strResVal As Array
            Try
                strResult = objDayPlanSettDO.Save_ConfigAppmntSettings(objItemsBO, HttpContext.Current.Session("UserID").ToString())
                strResVal = strResult.Split(",")
                ' Dim strValue = objErrHandle.GetErrorDesc("MTEMPLATE").ToString
                If strResVal(0) = "INSERTED" Then
                    strResVal(0) = "INSERTED"
                    strResVal(1) = objErrHandle.GetErrorDescParameter("INS")
                ElseIf strResVal(0) = "UPDATED" Then
                    strResVal(0) = "UPDATED"
                    strResVal(1) = objErrHandle.GetErrorDescParameter("UPD")
                ElseIf strResVal(0) = "ERROR" Then
                    strResVal(0) = "ERROR"
                    strResVal(1) = objErrHandle.GetErrorDescParameter("DUPSAVE")
                End If
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.ConfigDayPlanSettings", "Save_AppmntConfigSettings", ex.Message, HttpContext.Current.Session("UserID"))
            End Try
            Return strResVal
        End Function


    End Class
End Namespace

