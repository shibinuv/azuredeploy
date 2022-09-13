Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Resources
Imports System.Reflection
Imports CARS.CoreLibrary.CARS
Imports System.Web
Imports Encryption
Imports System.Configuration
Imports System
Imports MSGCOMMON
Imports System.Web.Security
Imports System.Data.Common
Imports System.Math
Imports System.Globalization
Imports CARS.CoreLibrary.CARS.Utilities
Imports System.Web.UI
Imports System.Xml

Namespace CARS.Services.SendSMS
    Public Class SendSMS
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
        Shared objSMSBO As New SendSMSBO
        Shared objSMSDO As New CARS.SendSMSDO.SendSMSDO
        Shared objCommonUtil As New CARS.Utilities.CommonUtility


        Public Function LoadSMSConfig(ByVal department As String, ByVal loginName As String) As List(Of SendSMSBO)
            Dim details As New List(Of SendSMSBO)()
            Dim dsSMSDetails As New DataSet
            Dim dtSMSDetails As New DataTable
            Try
                dsSMSDetails = objSMSDO.LoadSMSConfig(department, loginName)

                If dsSMSDetails.Tables.Count > 0 Then
                    dtSMSDetails = dsSMSDetails.Tables(0)
                End If

                'WorkCode Load                    
                For Each dtrow As DataRow In dtSMSDetails.Rows
                    Dim smsDet As New SendSMSBO()
                    smsDet.USER_ID = dtrow("USER_ID")
                    smsDet.USER_PASSWORD = dtrow("USER_PASSWORD")
                    smsDet.SENDER_SMS = dtrow("SENDER_SMS")
                    smsDet.SENDER_MAIL = dtrow("SENDER_MAIL")
                    smsDet.SMS_TYPE = dtrow("SMS_TYPE")
                    smsDet.SMS_OPERATOR_LINK = dtrow("SMS_OPERATOR_LINK")
                    smsDet.POST_TEXT = dtrow("POST_TEXT")
                    smsDet.SMS_AFTER_VISIT = dtrow("SMS_AFTER_VISIT")
                    smsDet.SMS_AFTER_VISIT_TEXT = dtrow("SMS_AFTER_VISIT_TEXT")
                    smsDet.SMS_MOB_WARRANTY = dtrow("SMS_MOB_WARRANTY")
                    smsDet.SMS_MOB_WARRANTY_TEXT = dtrow("SMS_MOB_WARRANTY_TEXT")
                    smsDet.FOLLOWUP_AFTER_VISIT = dtrow("FOLLOWUP_AFTER_VISIT")
                    smsDet.FOLLOWUP_AFTER_VISIT_SHOW_SMS = dtrow("FOLLOWUP_AFTER_VISIT_SHOW_SMS")
                    smsDet.FOLLOWUP_AFTER_VISIT_DAYS = dtrow("FOLLOWUP_AFTER_VISIT_DAYS")
                    smsDet.FOLLOWUP_AFTER_VISIT_MIN_AMOUNT = dtrow("FOLLOWUP_AFTER_VISIT_MIN_AMOUNT")
                    smsDet.FOLLOWUP_AFTER_VISIT_TEXT = dtrow("FOLLOWUP_AFTER_VISIT_TEXT")
                    smsDet.AUTO_CONFIRM_APPOINTMENT = dtrow("AUTO_CONFIRM_APPOINTMENT")
                    smsDet.AUTO_CONFIRM_APPOINTMENT_SHOW_SMS = dtrow("AUTO_CONFIRM_APPOINTMENT_SHOW_SMS")
                    smsDet.AUTO_CONFIRM_APPOINTMENT_NO_TIME = dtrow("AUTO_CONFIRM_APPOINTMENT_NO_TIME")
                    smsDet.AUTO_CONFIRM_APPOINTMENT_TEXT = dtrow("AUTO_CONFIRM_APPOINTMENT_TEXT")
                    smsDet.AUTO_CONFIRM_DELIVERY = dtrow("AUTO_CONFIRM_DELIVERY")
                    smsDet.AUTO_CONFIRM_DELIVERY_SHOW_SMS = dtrow("AUTO_CONFIRM_DELIVERY_SHOW_SMS")
                    smsDet.AUTO_CONFIRM_NO_TIME = dtrow("AUTO_CONFIRM_NO_TIME")
                    smsDet.AUTO_CONFIRM_DELIVERY_TEXT = dtrow("AUTO_CONFIRM_DELIVERY_TEXT")
                    smsDet.AUTO_CONFIRM_DELIVERY_OUT = dtrow("AUTO_CONFIRM_DELIVERY_OUT")
                    smsDet.AUTO_CONFIRM_DELIVERY_OUT_SHOW_SMS = dtrow("AUTO_CONFIRM_DELIVERY_OUT_SHOW_SMS")
                    smsDet.AUTO_CONFIRM_DELIVERY_OUT_MINS_BEFORE = dtrow("AUTO_CONFIRM_DELIVERY_OUT_MINS_BEFORE")
                    smsDet.AUTO_CONFIRM_DELIVERY_OUT_TEXT = dtrow("AUTO_CONFIRM_DELIVERY_OUT_TEXT")
                    smsDet.AUTO_FOLLOWUP_AFTER_VISIT = dtrow("AUTO_FOLLOWUP_AFTER_VISIT")
                    smsDet.AUTO_FOLLOWUP_AFTER_VISIT_SHOW_SMS = dtrow("AUTO_FOLLOWUP_AFTER_VISIT_SHOW_SMS")
                    smsDet.AUTO_FOLLOWUP_AFTER_VISIT_DAYS = dtrow("AUTO_FOLLOWUP_AFTER_VISIT_DAYS")
                    smsDet.AUTO_FOLLOWUP_AFTER_VISIT_TEXT = dtrow("AUTO_FOLLOWUP_AFTER_VISIT_TEXT")
                    smsDet.AUTO_ARRIVAL_PURCHASED_SPARES = dtrow("AUTO_ARRIVAL_PURCHASED_SPARES")
                    smsDet.AUTO_ARRIVAL_PURCHASED_SPARES_SHOW_SMS = dtrow("AUTO_ARRIVAL_PURCHASED_SPARES_SHOW_SMS")
                    smsDet.AUTO_ARRIVAL_PURCHASED_SPARES_TEXT = dtrow("AUTO_ARRIVAL_PURCHASED_SPARES_TEXT")
                    smsDet.DEPARTMENT = dtrow("DEPARTMENT")
                    smsDet.OPERATOR_TELE = dtrow("OPERATOR_TELE")
                    smsDet.OPERATOR_CERUM = dtrow("OPERATOR_CERUM")
                    smsDet.OPERATOR_GLOBI = dtrow("OPERATOR_GLOBI")
                    smsDet.SMS_COUNTING_START = dtrow("SMS_COUNTING_START")
                    smsDet.SMS_COUNTING_NO = dtrow("SMS_COUNTING_NO")
                    smsDet.AUTO_CONFIRM_DELIVERY_DAYS = dtrow("AUTO_CONFIRM_DELIVERY_DAYS")
                    smsDet.AUTO_CONFIRM_DELIVERY_HOURS = dtrow("AUTO_CONFIRM_DELIVERY_HOURS")
                    smsDet.SUB_ID = dtrow("SUB_ID")
                    smsDet.SUB_NAME = dtrow("SUB_NAME")
                    smsDet.SUB_PHONE = dtrow("SUB_PHONE")


                    details.Add(smsDet)
                Next


            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.WOJobDetails", "Load_WorkCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return details.ToList
        End Function

        Public Function SaveSMS(ByVal dept As String, ByVal phoneFrom As String, ByVal phoneTo As String, ByVal messageType As String, ByVal messageText As String, ByVal loginName As String, ByVal time As String) As String
            Dim strResult As String = ""
            'Dim strVehSeq As String
            'Dim strRefNo As String = ""
            'Dim strArray As Array
            Try
                strResult = objSMSDO.SaveSMS(dept, phoneFrom, phoneTo, messageType, messageText, loginName, time)
                'strArray = strResult.Split(",")
                'strResult = strArray(0)
                'strVehSeq = strArray(1)
                'strRefNo = strArray(2)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "Add_Vehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function

        Public Function SendSMSGlobal(ByVal dept As String, ByVal senderSMS As String, ByVal phoneTo As String, ByVal messageType As String, ByVal messageText As String, ByVal time As String, ByVal userId As String, ByVal userPassword As String, ByVal smsOperatorLink As String, ByVal linkId As String, ByVal loginName As String, ByVal orderId As String) As String
            Dim strResult As String = ""
            'Dim strVehSeq As String
            'Dim strRefNo As String = ""
            'Dim strArray As Array
            Try
                strResult = objSMSDO.SendSMSGlobal(dept, senderSMS, phoneTo, messageType, messageText, time, userId, userPassword, smsOperatorLink, linkId, loginName, orderId)
                'strArray = strResult.Split(",")
                'strResult = strArray(0)
                'strVehSeq = strArray(1)
                'strRefNo = strArray(2)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "Add_Vehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function

        Public Function Fetch_SMSHistory() As List(Of SendSMSBO)
            Dim dsSmsHistory As New DataSet
            Dim dtSmsHistory As DataTable
            Dim SMSSearchResult As New List(Of SendSMSBO)()

            Try
                dsSmsHistory = objSMSDO.Fetch_SMSHistory()

                If dsSmsHistory.Tables.Count > 0 Then
                    dtSmsHistory = dsSmsHistory.Tables(0)
                End If

                For Each dtrow As DataRow In dtSmsHistory.Rows
                        Dim item As New SendSMSBO()
                    Dim x() As String
                    item.TILTLF = dtrow("TilTlf").ToString
                    x = dtrow("Dato").ToString.Split()
                    item.DATO = x(0)
                    item.TID = x(1)
                    item.LOGIN = dtrow("OpprettetAv").ToString
                    item.MELDINGSTYPE = dtrow("Meldingstype").ToString
                    item.MELDINGSTEKST = dtrow("MeldingsTekst").ToString


                    SMSSearchResult.Add(item)
                    Next

            Catch ex As Exception
                Throw ex
            End Try
            Return SMSSearchResult
        End Function


    End Class
End Namespace




