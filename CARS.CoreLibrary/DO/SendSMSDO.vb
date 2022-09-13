Imports Microsoft.VisualBasic
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.Common
Imports System.Security.Cryptography
Imports System.IO
Imports CARS.CoreLibrary
Imports System.Web
Namespace CARS.SendSMSDO
    Public Class SendSMSDO
        Dim ConnectionString As String
        Shared objCommonUtil As New CARS.Utilities.CommonUtility
        Dim objDB As Database
        Dim strStatus As String
        Public Sub New()
            ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            objDB = New SqlDatabase(ConnectionString)
        End Sub

        Public Function SaveSMSConfig(ByVal userId As String, ByVal userPassword As String, ByVal senderMail As String, ByVal senderSMS As String, ByVal smsOperator As String, ByVal department As String, ByVal smsIntouch As String, ByVal smsCerum As String, ByVal smsGlobi As String, ByVal smsCountingStart As String, ByVal smsCountingNo As String, ByVal smsType As String, ByVal postText As String, ByVal cbGreetVisit As String, ByVal txtGreetVisit As String, ByVal cbGreetMobility As String, ByVal txtGreetMobility As String, ByVal cbFollowUpAfterVisit As String, ByVal cbFollowUpAfterVisitShowSMS As String, ByVal txtFollowupAfterVisitDays As String, ByVal txtFollowupAfterVisitAmount As String, ByVal txtFollowupAfterVisitText As String, ByVal cbConfirmAppointment As String, ByVal cbConfirmAppointmentShowSms As String, ByVal cbconfirmNoTime As String, ByVal txtConfirmText As String, ByVal cbConfirmHandingIn As String, ByVal cbConfirmHandingInShowSMS As String, ByVal cbConfirmHandingInNoTime As String, ByVal txtHoursBeforeAgreed As String, ByVal txtHoursBeforeAgreedClock As String, ByVal txtConfirmHandingInText As String, ByVal cbConfirmHandingOut As String, ByVal cbConfirmHandingOutShowSMS As String, ByVal txtMinBeforeFinish As String, ByVal txtConfirmHandingOutText As String, ByVal cbFollowUp As String, ByVal cbFollowUpShowSMS As String, ByVal txtFollowUpDaysAfter As String, ByVal txtcbFollowUpText As String, ByVal cbConfirmReceive As String, ByVal cbConfirmReceiveShowSMS As String, ByVal txtArrivalOrdParts As String, ByVal loginName As String) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MAS_SMS_CONFIG_INSERT")


                    objDB.AddInParameter(objcmd, "@USER_ID", DbType.String, userId)
                    objDB.AddInParameter(objcmd, "@USER_PASSWORD", DbType.String, userPassword)
                    objDB.AddInParameter(objcmd, "@SENDER_SMS", DbType.String, senderSMS)
                    objDB.AddInParameter(objcmd, "@SENDER_MAIL", DbType.String, senderMail)
                    objDB.AddInParameter(objcmd, "@OPERATOR_TELE", DbType.String, smsIntouch)
                    objDB.AddInParameter(objcmd, "@OPERATOR_CERUM", DbType.String, smsCerum)
                    objDB.AddInParameter(objcmd, "@OPERATOR_GLOBI", DbType.String, smsGlobi)
                    objDB.AddInParameter(objcmd, "@SMS_TYPE", DbType.String, smsType)
                    objDB.AddInParameter(objcmd, "@SMS_OPERATOR_LINK", DbType.String, smsOperator)
                    objDB.AddInParameter(objcmd, "@SMS_COUNTING_START", DbType.String, smsCountingStart)
                    objDB.AddInParameter(objcmd, "@SMS_COUNTING_NO", DbType.String, smsCountingNo)
                    objDB.AddInParameter(objcmd, "@POST_TEXT", DbType.String, postText)
                    objDB.AddInParameter(objcmd, "@SMS_AFTER_VISIT", DbType.Boolean, cbGreetVisit)
                    objDB.AddInParameter(objcmd, "@SMS_AFTER_VISIT_TEXT", DbType.String, txtGreetVisit)
                    objDB.AddInParameter(objcmd, "@SMS_MOB_WARRANTY", DbType.Boolean, cbGreetMobility)
                    objDB.AddInParameter(objcmd, "@SMS_MOB_WARRANTY_TEXT", DbType.String, txtGreetMobility)
                    objDB.AddInParameter(objcmd, "@FOLLOWUP_AFTER_VISIT", DbType.Boolean, cbFollowUpAfterVisit)
                    objDB.AddInParameter(objcmd, "@FOLLOWUP_AFTER_VISIT_SHOW_SMS", DbType.Boolean, cbFollowUpAfterVisitShowSMS)
                    objDB.AddInParameter(objcmd, "@FOLLOWUP_AFTER_VISIT_DAYS", DbType.String, txtFollowupAfterVisitDays)
                    objDB.AddInParameter(objcmd, "@FOLLOWUP_AFTER_VISIT_MIN_AMOUNT", DbType.String, txtFollowupAfterVisitAmount)
                    objDB.AddInParameter(objcmd, "@FOLLOWUP_AFTER_VISIT_TEXT", DbType.String, txtFollowupAfterVisitText)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_APPOINTMENT", DbType.Boolean, cbConfirmAppointment)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_APPOINTMENT_SHOW_SMS", DbType.Boolean, cbConfirmAppointmentShowSms)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_APPOINTMENT_NO_TIME", DbType.Boolean, cbconfirmNoTime)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_APPOINTMENT_TEXT", DbType.String, txtConfirmText)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY", DbType.Boolean, cbConfirmHandingIn)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_SHOW_SMS", DbType.Boolean, cbConfirmHandingInShowSMS)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_NO_TIME", DbType.Boolean, cbConfirmHandingInNoTime)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_DAYS", DbType.String, txtHoursBeforeAgreed)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_TEXT", DbType.String, txtConfirmHandingInText)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_HOURS", DbType.String, txtHoursBeforeAgreedClock)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_OUT", DbType.Boolean, cbConfirmHandingOut)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_OUT_SHOW_SMS", DbType.Boolean, cbConfirmHandingOutShowSMS)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_OUT_MINS_BEFORE", DbType.String, txtMinBeforeFinish)
                    objDB.AddInParameter(objcmd, "@AUTO_CONFIRM_DELIVERY_OUT_TEXT", DbType.String, txtConfirmHandingOutText)
                    objDB.AddInParameter(objcmd, "@AUTO_FOLLOWUP_AFTER_VISIT", DbType.Boolean, cbFollowUp)
                    objDB.AddInParameter(objcmd, "@AUTO_FOLLOWUP_AFTER_VISIT_SHOW_SMS", DbType.Boolean, cbFollowUpShowSMS)
                    objDB.AddInParameter(objcmd, "@AUTO_FOLLOWUP_AFTER_VISIT_DAYS", DbType.String, txtFollowUpDaysAfter)
                    objDB.AddInParameter(objcmd, "@AUTO_FOLLOWUP_AFTER_VISIT_TEXT", DbType.String, txtcbFollowUpText)
                    objDB.AddInParameter(objcmd, "@AUTO_ARRIVAL_PURCHASED_SPARES", DbType.Boolean, cbConfirmReceive)
                    objDB.AddInParameter(objcmd, "@AUTO_ARRIVAL_PURCHASED_SPARES_SHOW_SMS", DbType.Boolean, cbConfirmReceiveShowSMS)
                    objDB.AddInParameter(objcmd, "@AUTO_ARRIVAL_PURCHASED_SPARES_TEXT", DbType.String, txtArrivalOrdParts)
                    objDB.AddInParameter(objcmd, "@DEPARTMENT", DbType.String, department)
                    objDB.AddInParameter(objcmd, "@LOGIN", DbType.String, loginName)

                    objDB.ExecuteDataSet(objcmd)



                    Return "ok"
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function LoadSMSConfig(ByVal department As String, ByVal loginName As String) As DataSet
            Try
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_MAS_SMS_CONFIG_FETCH")
                    objDB.AddInParameter(objCMD, "@DEPARTMENT", DbType.String, department)
                    objDB.AddInParameter(objCMD, "@LOGIN", DbType.String, loginName)
                    Return objDB.ExecuteDataSet(objCMD)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function SaveSMS(ByVal dept As String, ByVal phoneFrom As String, ByVal phoneTo As String, ByVal messageType As String, ByVal messageText As String, ByVal loginName As String, ByVal time As String) As String
            Try
                Dim strStatus As String
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_INSERT_MAS_SMS_CONTROL")
                    objDB.AddInParameter(objcmd, "@DEPARTMENT", DbType.String, dept)
                    objDB.AddInParameter(objcmd, "@PHONE_FROM", DbType.String, phoneFrom)
                    objDB.AddInParameter(objcmd, "@PHONE_TO", DbType.String, phoneTo)
                    objDB.AddInParameter(objcmd, "@MESSAGE_TYPE", DbType.String, messageType)
                    objDB.AddInParameter(objcmd, "@MESSAGE_TEXT", DbType.String, messageText)
                    objDB.AddInParameter(objcmd, "@LOGIN", DbType.String, loginName)
                    objDB.AddInParameter(objcmd, "@LINK_ID", DbType.String, "")
                    objDB.AddInParameter(objcmd, "@ORDRE_ID", DbType.String, "")
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                'Return strStatus
                If strStatus <> "" Then

                    Try
                        Dim contactLink As String = ""
                        Dim custDetails As String = ""
                        Dim url As String = "https://admin.intouch.no/smsgateway/sendSms?sender=WebCars&targetNumbers=" + phoneTo + "&sms=" + messageText + "&userName=Cars&password=tkb28&deliveryReportUrl=http://79.161.39.70/SMSReporting/api/Rep&batchId=P" + strStatus
                        If time <> "" Then
                            url += "&sendTime=" + time
                        End If

                        Dim request As Net.HttpWebRequest = DirectCast(Net.WebRequest.Create(url), Net.HttpWebRequest)
                        Dim response As Net.HttpWebResponse = DirectCast(request.GetResponse(), Net.HttpWebResponse)
                        Dim statusCode = response.StatusCode
                        Dim statusDesc = response.StatusDescription
                        Dim reader As StreamReader = New StreamReader(response.GetResponseStream())
                        Dim json As String = reader.ReadToEnd

                        Return statusDesc
                    Catch ex As Exception
                        Throw ex
                    End Try
                End If

            Catch ex As Exception
                Throw ex
            End Try
        End Function



        Public Function SendSMSGlobal(ByVal dept As String, ByVal senderSMS As String, ByVal phoneTo As String, ByVal messageType As String, ByVal messageText As String, ByVal time As String, ByVal userId As String, ByVal userPassword As String, ByVal smsOperatorLink As String, ByVal linkId As String, ByVal loginName As String, ByVal orderId As String) As String
            Try
                Dim strStatus As String
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_INSERT_MAS_SMS_CONTROL")
                    objDB.AddInParameter(objcmd, "@DEPARTMENT", DbType.String, dept)
                    objDB.AddInParameter(objcmd, "@PHONE_FROM", DbType.String, senderSMS)
                    objDB.AddInParameter(objcmd, "@PHONE_TO", DbType.String, phoneTo)
                    objDB.AddInParameter(objcmd, "@MESSAGE_TYPE", DbType.String, messageType)
                    objDB.AddInParameter(objcmd, "@MESSAGE_TEXT", DbType.String, messageText)
                    objDB.AddInParameter(objcmd, "@LOGIN", DbType.String, loginName)
                    objDB.AddInParameter(objcmd, "@LINK_ID", DbType.String, linkId)
                    objDB.AddInParameter(objcmd, "@ORDRE_ID", DbType.String, orderId)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                'Return strStatus
                If strStatus <> "" Then

                    Try
                        Dim contactLink As String = ""
                        Dim custDetails As String = ""
                        Dim url As String = "https://admin.intouch.no/smsgateway/sendSms?sender=" + senderSMS + "&targetNumbers=" + phoneTo + "&sms=" + messageText + "&userName=" + userId + "&password=" + userPassword + "&deliveryReportUrl=" + smsOperatorLink + "&batchId=P" + strStatus
                        If time <> "" Then
                            url += "&sendTime=" + time
                        End If

                        Dim request As Net.HttpWebRequest = DirectCast(Net.WebRequest.Create(url), Net.HttpWebRequest)
                        Dim response As Net.HttpWebResponse = DirectCast(request.GetResponse(), Net.HttpWebResponse)
                        Dim statusCode = response.StatusCode
                        Dim statusDesc = response.StatusDescription
                        Dim reader As StreamReader = New StreamReader(response.GetResponseStream())
                        Dim json As String = reader.ReadToEnd

                        Return statusDesc
                    Catch ex As Exception
                        Throw ex
                    End Try
                End If

            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Fetch_SMSHistory() As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MAS_SMS_GET_HISTORY")

                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Dim theex = ex.GetType()
                Throw ex
            End Try
        End Function

        Public Function SaveMessageTemplate(ByVal tempId As String, ByVal tempText As String, ByVal tempType As String, ByVal _loginName As String) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_INSERT_DEPTMESSAGES_XTRACHECK")

                    objDB.AddInParameter(objcmd, "@TEMP_ID", DbType.String, tempId)
                    objDB.AddInParameter(objcmd, "@TEMP_TEXT", DbType.String, tempText)
                    objDB.AddInParameter(objcmd, "@TEMP_TYPE", DbType.String, tempType)
                    objDB.AddInParameter(objcmd, "@USER_ID", DbType.String, _loginName)

                    objDB.ExecuteDataSet(objcmd)



                    Return "OK"
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

    End Class
End Namespace

