Imports CARS.CoreLibrary.CARS.HP

Namespace CARS.Services.HP
    Public Class HPRate
        Private objDO As New HPRateDO
        Public Function Search_HPRate(ByVal DepFrom As Integer, ByVal DepTo As Integer) As DataTable
            Try
                Return objDO.Search_HPRate(DepFrom, DepTo)
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function FetchCmb_Rate(ByVal UserID As String) As DataSet
            Try
                Return objDO.FetchCmb_Rate(UserID)
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_Rate(ByVal HP_SEQ As Integer) As HPRateBO
            Dim dsHPRate As New DataSet
            Dim dtHPRate As New DataTable
            Dim hpRateDetails As New HPRateBO
            Try
                dsHPRate = objDO.Fetch_Rate(HP_SEQ)
                dtHPRate = dsHPRate.Tables(0)

                If dtHPRate.Rows.Count > 0 Then
                    hpRateDetails.PID_HP_SEQ = Convert.ToInt32(dtHPRate.Rows(0).Item("ID_HP_SEQ"))
                    hpRateDetails.PID_MAKE_HP = GetStringValue(dtHPRate.Rows(0).Item("ID_MAKE_HP"))
                    hpRateDetails.PID_DEPT_HP = GetIntegerValue(dtHPRate.Rows(0).Item("ID_DEPT_HP"))
                    hpRateDetails.PID_MECHPCD_HP = GetStringValue(dtHPRate.Rows(0).Item("ID_MECHPCD_HP"))
                    hpRateDetails.PID_RPPCD_HP = GetStringValue(dtHPRate.Rows(0).Item("ID_RPPCD_HP"))
                    hpRateDetails.PID_CUSTPCD_HP = GetStringValue(dtHPRate.Rows(0).Item("ID_CUSTPCD_HP"))
                    hpRateDetails.PID_VEHGRP_HP = GetStringValue(dtHPRate.Rows(0).Item("ID_VEHGRP_HP"))
                    hpRateDetails.PID_JOBPCD_HP = GetStringValue(dtHPRate.Rows(0).Item("ID_JOBPCD_HP"))
                    hpRateDetails.PINV_LABOR_TEXT = GetStringValue(dtHPRate.Rows(0).Item("INV_LABOR_TEXT"))
                    hpRateDetails.PHP_PRICE = GetDecimalValue(dtHPRate.Rows(0).Item("HP_PRICE"))
                    hpRateDetails.PHP_COST = GetDecimalValue(dtHPRate.Rows(0).Item("HP_COST"))
                    hpRateDetails.PFLG_TAKE_MECHNIC_COST = GetBooleanValue(dtHPRate.Rows(0).Item("FLG_TAKE_MECHNIC_COST"))
                    hpRateDetails.PHP_ACC_CODE = GetStringValue(dtHPRate.Rows(0).Item("HP_ACC_CODE"))
                    hpRateDetails.PDT_EFF_FROM = GetDateTimeValue(dtHPRate.Rows(0).Item("DT_EFF_FROM"))
                    hpRateDetails.PDT_EFF_TO = GetDateTimeValue(dtHPRate.Rows(0).Item("DT_EFF_TO"))
                    hpRateDetails.PCREATED_BY = GetStringValue(dtHPRate.Rows(0).Item("CREATED_BY"))
                    hpRateDetails.PDT_CREATED = GetDateTimeValue(dtHPRate.Rows(0).Item("DT_CREATED"))
                    hpRateDetails.PMODIFIED_BY = GetStringValue(dtHPRate.Rows(0).Item("MODIFIED_BY"))
                    hpRateDetails.PDT_MODIFIED = GetDateTimeValue(dtHPRate.Rows(0).Item("DT_MODIFIED"))
                    hpRateDetails.PHP_VAT = GetStringValue(dtHPRate.Rows(0).Item("HP_VAT"))
                End If
            Catch ex As Exception
                Throw ex
            End Try
            Return hpRateDetails
        End Function
        Public Function Add_Rate(objHPRateBO As HPRateBO) As String
            Try
                Return objDO.Add_Rate(objHPRateBO)
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Update_Rate(objHPRateBO As HPRateBO) As String
            Try
                Return objDO.Update_Rate(objHPRateBO)
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Delete_Rate(ByVal strXML As String, ByRef Deleted As String, ByRef CannotDelete As String) As String
            Try
                Return objDO.Delete_Rate(strXML, Deleted, CannotDelete)
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function GetStringValue(ByVal obj As Object) As String
            If obj Is Nothing Then Return Nothing
            If IsDBNull(obj) Then Return Nothing
            Return obj.ToString
        End Function
        Public Function GetIntegerValue(ByVal obj As Object) As Integer
            Try
                If obj Is Nothing Then Return Nothing
                If IsDBNull(obj) Then Return Nothing
                Return Convert.ToInt32(obj)
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function GetDecimalValue(ByVal obj As Object) As Decimal
            Try
                If obj Is Nothing Then Return Nothing
                If IsDBNull(obj) Then Return Nothing
                Return Convert.ToDecimal(obj)
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function GetBooleanValue(ByVal obj As Object) As Boolean
            Try
                If obj Is Nothing Then Return Nothing
                If IsDBNull(obj) Then Return Nothing
                Return Convert.ToBoolean(obj)
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function GetDateTimeValue(ByVal obj As Object) As DateTime
            Try
                If obj Is Nothing Then Return Nothing
                If IsDBNull(obj) Then Return Nothing
                Return Convert.ToDateTime(obj)
            Catch ex As Exception
                Throw ex
            End Try
        End Function
    End Class
End Namespace