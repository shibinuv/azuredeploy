Public Class SendSMSBO
    Public Property USER_ID As String
    Public Property USER_PASSWORD As String
    Public Property SENDER_SMS As String
    Public Property SENDER_MAIL As String
    Public Property SMS_SUPPLIER As String
    Public Property SMS_TYPE As String
    Public Property SMS_OPERATOR_LINK As String
    Public Property POST_TEXT As String
    Public Property SMS_AFTER_VISIT As Boolean
    Public Property SMS_AFTER_VISIT_TEXT As String
    Public Property SMS_MOB_WARRANTY As Boolean

    Public Property SMS_MOB_WARRANTY_TEXT As String
    Public Property FOLLOWUP_AFTER_VISIT As Boolean

    Public Property FOLLOWUP_AFTER_VISIT_SHOW_SMS As Boolean
    Public Property FOLLOWUP_AFTER_VISIT_DAYS As String
    Public Property FOLLOWUP_AFTER_VISIT_MIN_AMOUNT As String
    Public Property FOLLOWUP_AFTER_VISIT_TEXT As String
    Public Property LOGIN As String
    Public Property AUTO_CONFIRM_APPOINTMENT As Boolean
    Public Property AUTO_CONFIRM_APPOINTMENT_SHOW_SMS As Boolean
    Public Property AUTO_CONFIRM_APPOINTMENT_NO_TIME As Boolean
    Public Property AUTO_CONFIRM_APPOINTMENT_TEXT As String
    Public Property AUTO_CONFIRM_DELIVERY As Boolean
    Public Property AUTO_CONFIRM_DELIVERY_SHOW_SMS As Boolean
    Public Property AUTO_CONFIRM_NO_TIME As Boolean
    Public Property AUTO_CONFIRM_DELIVERY_TEXT As String
    Public Property AUTO_CONFIRM_DELIVERY_OUT As Boolean
    Public Property AUTO_CONFIRM_DELIVERY_OUT_SHOW_SMS As Boolean

    Public Property AUTO_CONFIRM_DELIVERY_OUT_MINS_BEFORE As String
    Public Property AUTO_CONFIRM_DELIVERY_OUT_TEXT As String
    Public Property AUTO_FOLLOWUP_AFTER_VISIT As Boolean
    Public Property AUTO_FOLLOWUP_AFTER_VISIT_SHOW_SMS As Boolean
    Public Property AUTO_FOLLOWUP_AFTER_VISIT_DAYS As String
    Public Property AUTO_FOLLOWUP_AFTER_VISIT_TEXT As String
    Public Property AUTO_ARRIVAL_PURCHASED_SPARES As Boolean
    Public Property AUTO_ARRIVAL_PURCHASED_SPARES_SHOW_SMS As Boolean
    Public Property AUTO_ARRIVAL_PURCHASED_SPARES_TEXT As String
    Public Property DEPARTMENT As String
    Public Property OPERATOR_TELE As String
    Public Property OPERATOR_CERUM As String
    Public Property OPERATOR_GLOBI As String
    Public Property SMS_COUNTING_START As String
    Public Property SMS_COUNTING_NO As String
    Public Property AUTO_CONFIRM_DELIVERY_DAYS As String
    Public Property AUTO_CONFIRM_DELIVERY_HOURS As String

    'VERDIER SOM BRUKES TIL SMS TABELLEN
    Public Property DATO As String
    Public Property TID As String
    Public Property DISTKODE As String
    Public Property FIRMA As String
    Public Property FRATLF As String
    Public Property TILTLF As String
    Public Property STATUS As String
    Public Property TYPE As String
    Public Property BATCH As String
    Public Property NUMSMS As String
    Public Property LAND As String
    Public Property FILENAME As String
    Public Property LINKSTART As String
    Public Property LINKFINISHED As String
    Public Property MELDINGSTYPE As String
    Public Property MELDINGSTEKST As String
    Public Property SUB_NAME As String
    Public Property SUB_ID As String
    Public Property SUB_PHONE As String
    Public Property LINKID As String
End Class
