Imports System.Data.Common
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Namespace CARS.HP

    Public Class HPRateDO
        Dim ConnectionString As String
        Dim objDB As Database
        Dim strStatus As String
        Public Sub New()
            ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            objDB = New SqlDatabase(ConnectionString)
        End Sub
        Public Function FetchAllDepartments(ByVal objConfigDeptBO As ConfigDepartmentBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FetchDepartment")
                    objDB.AddInParameter(objcmd, "@ID_USER", DbType.String, objConfigDeptBO.LoginId)
                    objDB.AddInParameter(objcmd, "@IV_LANG", DbType.String, System.Configuration.ConfigurationManager.AppSettings("Language").ToString())
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Search_HPRate(ByVal DepFrom As Integer, ByVal DepTo As Integer) As DataTable
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_HP_SEARCH")
                    objDB.AddInParameter(objcmd, "@iv_DepFrom", DbType.String, DepFrom)
                    objDB.AddInParameter(objcmd, "@iv_DepTo", DbType.String, DepTo)
                    Return objDB.ExecuteDataSet(objcmd).Tables(0)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function FetchCmb_Rate(ByVal UserID As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TR_HP_FATCHALL")
                    objDB.AddInParameter(objcmd, "@iv_UserID", DbType.String, UserID)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_Rate(ByVal HP_SEQ As Integer) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_HP_DETAIL_VIEW")
                    objDB.AddInParameter(objcmd, "@iv_ID_HP_SEQ", DbType.String, HP_SEQ)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)

                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Add_Rate(objHPRateBO As HPRateBO) As String

            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_HP_DETAIL_INSERT")
                    objDB.AddInParameter(objcmd, "@iv_ID_MAKE_HP", DbType.String, NullCheckString(objHPRateBO.PID_MAKE_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_DEPT_HP", DbType.Int32, objHPRateBO.PID_DEPT_HP)
                    objDB.AddInParameter(objcmd, "@iv_ID_MECHPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_MECHPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_RPPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_RPPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_CUSTPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_CUSTPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_VEHGRP_HP", DbType.String, NullCheckString(objHPRateBO.PID_VEHGRP_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_JOBPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_JOBPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_INV_LABOR_TEXT", DbType.String, NullCheckString(objHPRateBO.PINV_LABOR_TEXT))
                    objDB.AddInParameter(objcmd, "@iv_HP_PRICE", DbType.Decimal, objHPRateBO.PHP_PRICE)
                    objDB.AddInParameter(objcmd, "@iv_HP_COST", DbType.Decimal, objHPRateBO.PHP_COST)
                    objDB.AddInParameter(objcmd, "@iv_FLG_TAKE_MECHNIC_COST", DbType.Boolean, objHPRateBO.PFLG_TAKE_MECHNIC_COST)
                    objDB.AddInParameter(objcmd, "@iv_HP_ACC_CODE", DbType.String, NullCheckString(objHPRateBO.PHP_ACC_CODE))
                    objDB.AddInParameter(objcmd, "@iv_CREATED_BY", DbType.String, NullCheckString(objHPRateBO.PCREATED_BY))
                    objDB.AddInParameter(objcmd, "@iv_HP_VAT", DbType.String, NullCheckString(objHPRateBO.PHP_VAT))

                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Return strStatus
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Update_Rate(objHPRateBO As HPRateBO) As String

            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_HP_DETAIL_MODIFY")
                    objDB.AddInParameter(objcmd, "@iv_ID_HP_SEQ", DbType.Int32, objHPRateBO.PID_HP_SEQ)
                    objDB.AddInParameter(objcmd, "@iv_ID_MAKE_HP", DbType.String, NullCheckString(objHPRateBO.PID_MAKE_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_DEPT_HP", DbType.Int32, objHPRateBO.PID_DEPT_HP)
                    objDB.AddInParameter(objcmd, "@iv_ID_MECHPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_MECHPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_RPPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_RPPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_CUSTPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_CUSTPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_VEHGRP_HP", DbType.String, NullCheckString(objHPRateBO.PID_VEHGRP_HP))
                    objDB.AddInParameter(objcmd, "@iv_ID_JOBPCD_HP", DbType.String, NullCheckString(objHPRateBO.PID_JOBPCD_HP))
                    objDB.AddInParameter(objcmd, "@iv_INV_LABOR_TEXT", DbType.String, NullCheckString(objHPRateBO.PINV_LABOR_TEXT))
                    objDB.AddInParameter(objcmd, "@iv_HP_PRICE", DbType.Decimal, objHPRateBO.PHP_PRICE)
                    objDB.AddInParameter(objcmd, "@iv_HP_COST", DbType.Decimal, objHPRateBO.PHP_COST)
                    objDB.AddInParameter(objcmd, "@iv_FLG_TAKE_MECHNIC_COST", DbType.Boolean, objHPRateBO.PFLG_TAKE_MECHNIC_COST)
                    objDB.AddInParameter(objcmd, "@iv_HP_ACC_CODE", DbType.String, NullCheckString(objHPRateBO.PHP_ACC_CODE))
                    objDB.AddInParameter(objcmd, "@iv_MODIFIED_BY", DbType.String, NullCheckString(objHPRateBO.PMODIFIED_BY))
                    objDB.AddInParameter(objcmd, "@iv_HP_VAT", DbType.String, objHPRateBO.PHP_VAT)

                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Return strStatus

                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Delete_Rate(ByVal strXML As String, ByRef Deleted As String, ByRef CannotDelete As String) As String

            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_HP_DETAIL_DELETE")
                    objDB.AddInParameter(objcmd, "@iv_xmlDoc", DbType.String, strXML)
                    objDB.AddOutParameter(objcmd, "@ov_RetValue", DbType.String, 10)
                    objDB.AddOutParameter(objcmd, "@ov_CntDelete", DbType.String, 10)
                    objDB.AddOutParameter(objcmd, "@ov_DeletedCfg", DbType.String, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strStatus =
                    Deleted = NullCheck(objDB.GetParameterValue(objcmd, "@ov_DeletedCfg").ToString)
                    CannotDelete = NullCheck(objDB.GetParameterValue(objcmd, "@ov_CntDelete").ToString)
                    Return objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Private Function NullCheckString(ByVal str As String) As String
            If str Is Nothing Or str = "" Then Return Nothing
            Return str
        End Function
        Private Function NullCheck(ByVal StrValue As Object) As String
            Try
                If IsDBNull(StrValue) Then
                    Return ""
                Else
                    Return CStr(StrValue).Trim
                End If
            Catch ex As Exception
                Throw ex
            End Try
        End Function
    End Class

End Namespace
