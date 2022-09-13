﻿Imports Microsoft.VisualBasic
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
Namespace CARS.WOJobDetailDO
    Public Class WOJobDetailDO
        Dim ConnectionString As String
        Shared objCommonUtil As New CARS.Utilities.CommonUtility
        Dim objDB As Database
        Dim strStatus As String
        Public Sub New()
            ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            objDB = New SqlDatabase(ConnectionString)
        End Sub
        Public Function Load_ConfigDetails(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("usp_WO_LOAD_CONFIG")
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@IV_ID_USERID", DbType.String, objWOJobDetailsBO.Created_By)
                    objDB.AddInParameter(objcmd, "@IV_ID_MAKE_RP", DbType.String, objWOJobDetailsBO.Id_Make_Rp)
                    objDB.AddInParameter(objcmd, "@IV_ID_MODEL_RP", DbType.String, objWOJobDetailsBO.Id_Model_Rp)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_Spares(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("usp_WO_LOAD_SPARES")
                    objDB.AddInParameter(objcmd, "@iv_ItemDesc", DbType.String, objWOJobDetailsBO.Id_Item)
                    objDB.AddInParameter(objcmd, "@IV_ID_CUST", DbType.String, objWOJobDetailsBO.Id_Customer)
                    objDB.AddInParameter(objcmd, "@IV_ID_VEH", DbType.String, objWOJobDetailsBO.WO_Id_Veh)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, objWOJobDetailsBO.Created_By)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_SparesList(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("usp_WO_LOAD_SPARES_LIST")
                    objDB.AddInParameter(objcmd, "@iv_ItemDesc", DbType.String, objWOJobDetailsBO.Id_Item)
                    objDB.AddInParameter(objcmd, "@IV_ID_CUST", DbType.String, objWOJobDetailsBO.Id_Customer)
                    objDB.AddInParameter(objcmd, "@IV_ID_VEH", DbType.String, objWOJobDetailsBO.WO_Id_Veh)
                    objDB.AddInParameter(objcmd, "@SP_MAKE", DbType.String, objWOJobDetailsBO.Sp_Make)
                    objDB.AddInParameter(objcmd, "@SP_SUPPLIER", DbType.String, objWOJobDetailsBO.SP_SupplierID)
                    objDB.AddInParameter(objcmd, "@SP_LOCATION", DbType.String, objWOJobDetailsBO.Sp_Location)
                    objDB.AddInParameter(objcmd, "@StockItem", DbType.String, objWOJobDetailsBO.Sp_FlgStockItem)
                    objDB.AddInParameter(objcmd, "@flg_stockitem_status", DbType.String, objWOJobDetailsBO.SP_FlgStockItemStatus)
                    objDB.AddInParameter(objcmd, "@flg_nonstockitem_status", DbType.String, objWOJobDetailsBO.SP_FlgNonStockItemStatus)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, objWOJobDetailsBO.Created_By)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function


        Public Function Load_WorkOrderDetails(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_TOTAL_VIEW_NEW")
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@ID_JOB", DbType.String, objWOJobDetailsBO.Id_Job)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function WorkDetails(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_DEBITOR_DETAIL_VIEW_NEW")
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@ID_JOB", DbType.String, objWOJobDetailsBO.Id_Job)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Load_GMHP_VAT(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_LOAD_VAT_GMHP")
                    objDB.AddInParameter(objcmd, "@IV_ID_CUST", DbType.String, objWOJobDetailsBO.Id_Customer)
                    objDB.AddInParameter(objcmd, "@IV_ID_VEH", DbType.String, objWOJobDetailsBO.WO_Id_Veh)
                    objDB.AddInParameter(objcmd, "@IV_ID_HPVAT", DbType.String, objWOJobDetailsBO.Id_Hp_Vat)
                    objDB.AddInParameter(objcmd, "@IV_ID_GMVAT", DbType.String, objWOJobDetailsBO.Id_Gm_Vat)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, objWOJobDetailsBO.Created_By)
                    objDB.AddInParameter(objcmd, "@IV_ID_ITEM", DbType.String, objWOJobDetailsBO.Id_Item)
                    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, objWOJobDetailsBO.Id_Make)

                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function




        Public Function loadXtraCheck(ByVal refnr As String, ByVal regnr As String) As DataSet
            Try
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_VEHICLE_XTRACHECK_GET")
                    objDB.AddInParameter(objCMD, "@REFNO", DbType.String, refnr)
                    objDB.AddInParameter(objCMD, "@REGNO", DbType.String, regnr)
                    Return objDB.ExecuteDataSet(objCMD)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function


        Public Function SaveXtraCheck(ByVal regno As String, ByVal refno As String, ByVal motoroil As String, ByVal motoroilAnnot As String, ByVal motoroilSMS As String, ByVal cflevel As String, ByVal cflevelAnnot As String, ByVal cflevelSMS As String, ByVal cftemp As String, ByVal cftempAnnot As String, ByVal cfSMS As String, ByVal brakefluid As String, ByVal brakefluidAnnot As String, ByVal brakefluidSMS As String, ByVal battery As String, ByVal batteryAnnot As String, ByVal batterySMS As String, ByVal vipesfront As String, ByVal vipesfrontAnnot As String, ByVal vipesfrontSMS As String, ByVal vipesrear As String, ByVal vipesrearAnnot As String, ByVal vipesrearSMS As String, ByVal lightsfront As String, ByVal lightsfrontAnnot As String, ByVal lightsfrontSMS As String, ByVal lightsrear As String, ByVal lightsrearAnnot As String, ByVal lightsrearSMS As String, ByVal shockabsorberfront As String, ByVal shockabsorberfrontAnnot As String, ByVal shockabsorberfrontSMS As String, ByVal shockabsorberrear As String, ByVal shockabsorberrearAnnot As String, ByVal shockabsorberrearSMS As String, ByVal tiresfront As String, ByVal tiresfrontAnnot As String, ByVal tiresfrontSMS As String, ByVal tiresrear As String, ByVal tiresrearAnnot As String, ByVal tiresrearSMS As String, ByVal suspensionfront As String, ByVal suspensionfrontAnnot As String, ByVal suspensionfrontSMS As String, ByVal suspensionrear As String, ByVal suspensionrearAnnot As String, ByVal suspensionrearSMS As String, ByVal brakesfront As String, ByVal brakesfrontAnnot As String, ByVal brakesfrontSMS As String, ByVal brakesrear As String, ByVal brakesrearAnnot As String, ByVal brakesrearSMS As String, ByVal exhaust As String, ByVal exhaustAnnot As String, ByVal exhaustSMS As String, ByVal sealedengine As String, ByVal sealedengineAnnot As String, ByVal sealedengineSMS As String, ByVal sealedgearbox As String, ByVal sealedgearboxAnnot As String, ByVal sealedgearboxSMS As String, ByVal generalannotation As String) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_VEHICLE_XTRACHECK_INSERT")
                    objDB.AddInParameter(objcmd, "@REFNR", DbType.String, refno)
                    objDB.AddInParameter(objcmd, "@REGISTRATIONNR", DbType.String, regno)
                    objDB.AddInParameter(objcmd, "@MOTOROIL", DbType.String, motoroil)
                    objDB.AddInParameter(objcmd, "@MOTOROIL_ANNOT", DbType.String, motoroilAnnot)
                    objDB.AddInParameter(objcmd, "@MOTOROIL_SMS", DbType.String, motoroilSMS)
                    objDB.AddInParameter(objcmd, "@FREEZE_LEVEL", DbType.String, cflevel)
                    objDB.AddInParameter(objcmd, "@FREEZE_LEVEL_ANNOT", DbType.String, cflevelAnnot)
                    objDB.AddInParameter(objcmd, "@FREEZE_LEVEL_SMS", DbType.String, cflevelSMS)
                    objDB.AddInParameter(objcmd, "@FREEZE_POINT", DbType.String, cftemp)
                    objDB.AddInParameter(objcmd, "@FREEZE_POINT_ANNOT", DbType.String, cftempAnnot)
                    objDB.AddInParameter(objcmd, "@FREEZE_POINT_SMS", DbType.String, cfSMS)
                    objDB.AddInParameter(objcmd, "@BRAKEFLUID", DbType.String, brakefluid)
                    objDB.AddInParameter(objcmd, "@BRAKEFLUID_ANNOT", DbType.String, brakefluidAnnot)
                    objDB.AddInParameter(objcmd, "@BRAKEFLUID_SMS", DbType.String, brakefluidSMS)
                    objDB.AddInParameter(objcmd, "@BATTERY", DbType.String, battery)
                    objDB.AddInParameter(objcmd, "@BATTERY_ANNOT", DbType.String, batteryAnnot)
                    objDB.AddInParameter(objcmd, "@BATTERY_SMS", DbType.String, batterySMS)
                    objDB.AddInParameter(objcmd, "@WINDSCREEN_WIPER_FRONT", DbType.String, vipesfront)
                    objDB.AddInParameter(objcmd, "@WINDSCREEN_WIPER_FRONT_ANNOT", DbType.String, vipesfrontAnnot)
                    objDB.AddInParameter(objcmd, "@WINDSCREEN_WIPER_FRONT_SMS", DbType.String, vipesfrontSMS)
                    objDB.AddInParameter(objcmd, "@WINDSCREEN_WIPER_REAR", DbType.String, vipesrear)
                    objDB.AddInParameter(objcmd, "@WINDSCREEN_WIPER_REAR_ANNOT", DbType.String, vipesrearAnnot)
                    objDB.AddInParameter(objcmd, "@WINDSCREEN_WIPER_REAR_SMS", DbType.String, vipesrearSMS)
                    objDB.AddInParameter(objcmd, "@LIGHT_BULB_FRONT", DbType.String, lightsfront)
                    objDB.AddInParameter(objcmd, "@LIGHT_BULB_FRONT_ANNOT", DbType.String, lightsfrontAnnot)
                    objDB.AddInParameter(objcmd, "@LIGHT_BULB_FRONT_SMS", DbType.String, lightsfrontSMS)
                    objDB.AddInParameter(objcmd, "@LIGHT_BULB_REAR", DbType.String, lightsrear)
                    objDB.AddInParameter(objcmd, "@LIGHT_BULB_REAR_ANNOT", DbType.String, lightsrearAnnot)
                    objDB.AddInParameter(objcmd, "@LIGHT_BULB_REAR_SMS", DbType.String, lightsrearSMS)
                    objDB.AddInParameter(objcmd, "@SHOCK_ABSORBER_FRONT", DbType.String, shockabsorberfront)
                    objDB.AddInParameter(objcmd, "@SHOCK_ABSORBER_FRONT_ANNOT", DbType.String, shockabsorberfrontAnnot)
                    objDB.AddInParameter(objcmd, "@SHOCK_ABSORBER_FRONT_SMS", DbType.String, shockabsorberfrontSMS)
                    objDB.AddInParameter(objcmd, "@SHOCK_ABSORBER_REAR", DbType.String, shockabsorberrear)
                    objDB.AddInParameter(objcmd, "@SHOCK_ABSORBER_REAR_ANNOT", DbType.String, shockabsorberrearAnnot)
                    objDB.AddInParameter(objcmd, "@SHOCK_ABSORBER_REAR_SMS", DbType.String, shockabsorberrearSMS)
                    objDB.AddInParameter(objcmd, "@TIRE_FRONT", DbType.String, tiresfront)
                    objDB.AddInParameter(objcmd, "@TIRE_FRONT_ANNOT", DbType.String, tiresfrontAnnot)
                    objDB.AddInParameter(objcmd, "@TIRE_FRONT_SMS", DbType.String, tiresfrontSMS)
                    objDB.AddInParameter(objcmd, "@TIRE_REAR", DbType.String, tiresrear)
                    objDB.AddInParameter(objcmd, "@TIRE_REAR_ANNOT", DbType.String, tiresrearAnnot)
                    objDB.AddInParameter(objcmd, "@TIRE_REAR_SMS", DbType.String, tiresrearSMS)
                    objDB.AddInParameter(objcmd, "@SUSPENSION_FRONT", DbType.String, suspensionfront)
                    objDB.AddInParameter(objcmd, "@SUSPENSION_FRONT_ANNOT", DbType.String, suspensionfrontAnnot)
                    objDB.AddInParameter(objcmd, "@SUSPENSION_FRONT_SMS", DbType.String, suspensionfrontSMS)
                    objDB.AddInParameter(objcmd, "@SUSPENSION_REAR", DbType.String, suspensionrear)
                    objDB.AddInParameter(objcmd, "@SUSPENSION_REAR_ANNOT", DbType.String, suspensionrearAnnot)
                    objDB.AddInParameter(objcmd, "@SUSPENSION_REAR_SMS", DbType.String, suspensionrearSMS)
                    objDB.AddInParameter(objcmd, "@BRAKES_FRONT", DbType.String, brakesfront)
                    objDB.AddInParameter(objcmd, "@BRAKES_FRONT_ANNOT", DbType.String, brakesfrontAnnot)
                    objDB.AddInParameter(objcmd, "@BRAKES_FRONT_SMS", DbType.String, brakesfrontSMS)
                    objDB.AddInParameter(objcmd, "@BRAKES_REAR", DbType.String, brakesrear)
                    objDB.AddInParameter(objcmd, "@BRAKES_REAR_ANNOT", DbType.String, brakesrearAnnot)
                    objDB.AddInParameter(objcmd, "@BRAKES_REAR_SMS", DbType.String, brakesrearSMS)
                    objDB.AddInParameter(objcmd, "@EXHAUST", DbType.String, exhaust)
                    objDB.AddInParameter(objcmd, "@EXHAUST_ANNOT", DbType.String, exhaustAnnot)
                    objDB.AddInParameter(objcmd, "@EXHAUST_SMS", DbType.String, exhaustSMS)
                    objDB.AddInParameter(objcmd, "@DENSITY_MOTOR", DbType.String, sealedengine)
                    objDB.AddInParameter(objcmd, "@DENSITY_MOTOR_ANNOT", DbType.String, sealedengineAnnot)
                    objDB.AddInParameter(objcmd, "@DENSITY_MOTOR_SMS", DbType.String, sealedengineSMS)
                    objDB.AddInParameter(objcmd, "@DENSITY_GEARBOX", DbType.String, sealedgearbox)
                    objDB.AddInParameter(objcmd, "@DENSITY_GEARBOX_ANNOT", DbType.String, sealedgearboxAnnot)
                    objDB.AddInParameter(objcmd, "@DENSITY_GEARBOX_SMS", DbType.String, sealedgearboxSMS)
                    objDB.AddInParameter(objcmd, "@GENERAL_ANNOT", DbType.String, generalannotation)
                    objDB.ExecuteDataSet(objcmd)



                    Return "ok"
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_Hourly_Price(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_GetHPPrice")
                    objDB.AddInParameter(objcmd, "@iv_UserID", DbType.String, objWOJobDetailsBO.Created_By)
                    objDB.AddInParameter(objcmd, "@iv_ID_MAKE_HP", DbType.String, objWOJobDetailsBO.Id_Make_Rp)
                    objDB.AddInParameter(objcmd, "@iv_ID_CUSTOMER", DbType.String, objWOJobDetailsBO.Id_Customer)
                    objDB.AddInParameter(objcmd, "@iv_ID_RPPCD_HP", DbType.String, objWOJobDetailsBO.Id_RpPcd_Hp)
                    objDB.AddInParameter(objcmd, "@iv_ID_JOBPCD_HP", DbType.String, objWOJobDetailsBO.Id_Jobpcd_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_VEHGRP", DbType.String, objWOJobDetailsBO.Veh_Grp)
                    objDB.AddInParameter(objcmd, "@iv_ID_MECHPCD_HP", DbType.String, objWOJobDetailsBO.Mechpcd_HP)
                    objDB.AddOutParameter(objcmd, "@ov_HP_PRICE", DbType.Decimal, 100)
                    objDB.AddOutParameter(objcmd, "@ov_HP_DESC", DbType.String, 200)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function GetUsersWarehouse(ByVal strLogin As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_USERS_WAREHOUSE")
                    objDB.AddInParameter(objcmd, "@IV_ID_LOGIN", DbType.String, strLogin)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_StockItem_Status(ByVal Id_Item As String, ByVal Id_Make As String, ByVal Id_Wh As Integer) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_STOCK_STATUS")
                    objDB.AddInParameter(objcmd, "@SPAREID", DbType.String, Id_Item)
                    objDB.AddInParameter(objcmd, "@Make", DbType.String, Id_Make)
                    objDB.AddInParameter(objcmd, "@Wh_Item", DbType.Int32, Id_Wh)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_SparePartStockQty_Details(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SPR_FETCH_OWN_SPAREPART")
                    objDB.AddInParameter(objcmd, "@ID_MAKE_NAMEF", DbType.String, objWOJobDetailsBO.Id_Make_NameF)
                    objDB.AddInParameter(objcmd, "@ID_MAKE_NAMET", DbType.String, objWOJobDetailsBO.Id_Make_NameT)
                    objDB.AddInParameter(objcmd, "@CATEGORYF", DbType.String, objWOJobDetailsBO.CategoryF)
                    objDB.AddInParameter(objcmd, "@CATEGORYT", DbType.String, objWOJobDetailsBO.CategoryT)
                    objDB.AddInParameter(objcmd, "@ID_ITEM_MODELF", DbType.String, objWOJobDetailsBO.Id_Item_ModelF)
                    objDB.AddInParameter(objcmd, "@ID_ITEM_MODELT", DbType.String, objWOJobDetailsBO.Id_Item_ModelT)
                    objDB.AddInParameter(objcmd, "@ID_ITEMF", DbType.String, objWOJobDetailsBO.Id_ItemF)
                    objDB.AddInParameter(objcmd, "@ID_ITEMT", DbType.String, objWOJobDetailsBO.Id_ItemF)
                    objDB.AddInParameter(objcmd, "@ITEM_DESCF", DbType.String, objWOJobDetailsBO.Item_DescF)
                    objDB.AddInParameter(objcmd, "@ITEM_DESCT", DbType.String, objWOJobDetailsBO.Item_DescT)
                    objDB.AddInParameter(objcmd, "@ID_SUP_NAMEF", DbType.String, objWOJobDetailsBO.Id_Sup_NameF)
                    objDB.AddInParameter(objcmd, "@ID_SUP_NAMET", DbType.String, objWOJobDetailsBO.Id_Sup_NameT)
                    objDB.AddInParameter(objcmd, "@ID_REPLACESPAREF", DbType.String, objWOJobDetailsBO.Id_ReplaceSpareF)
                    objDB.AddInParameter(objcmd, "@ID_REPLACESPARET", DbType.String, objWOJobDetailsBO.Id_ReplaceSpareT)
                    objDB.AddInParameter(objcmd, "@ID_WH_ITEMS", DbType.String, objWOJobDetailsBO.Id_Wh_Item)
                    objDB.AddInParameter(objcmd, "@PageIndex", DbType.Int32, Convert.ToInt32(objWOJobDetailsBO.PageIndex))
                    objDB.AddInParameter(objcmd, "@PageSize", DbType.Int32, Convert.ToInt32(objWOJobDetailsBO.PageSize))
                    objDB.AddInParameter(objcmd, "@SortExpression", DbType.String, objWOJobDetailsBO.SortExpression)
                    objDB.AddInParameter(objcmd, "@UserID", DbType.String, objWOJobDetailsBO.Created_By)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_Job_No(ByVal objWOJobDetailsBO As WOJobDetailBO) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_FETCHJOB")
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddOutParameter(objcmd, "@OV_MAXID", DbType.Int32, 10)
                    objDB.ExecuteDataSet(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@OV_MAXID").ToString
                End Using
            Catch ex As Exception
                Throw ex
            End Try
            Return strStatus
        End Function
        Public Function GetRCWCDetails() As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_GETRCWCDETAILS")
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Save_WOJobDetails(ByVal objWOJobDetailsBO As WOJobDetailBO) As String()
            Dim strResult As String = ""
            Dim strArray As Array
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_INSERT")
                    objDB.AddInParameter(objcmd, "@iv_xmljobDoc", DbType.String, objWOJobDetailsBO.Job_Doc) 'check datatype
                    objDB.AddInParameter(objcmd, "@iv_xmlwoDoc", DbType.String, objWOJobDetailsBO.WO_Doc)
                    objDB.AddInParameter(objcmd, "@iv_ID_WODET_SEQ", DbType.Int32, objWOJobDetailsBO.Id_Wodet_Seq)
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@iv_ID_RPG_CATG_WO", DbType.String, objWOJobDetailsBO.Id_Rpg_Catg_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_RPG_CODE_WO", DbType.String, objWOJobDetailsBO.Id_Rpg_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_REP_CODE_WO", DbType.Int32, objWOJobDetailsBO.Id_Rep_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_WORK_CODE_WO", DbType.String, objWOJobDetailsBO.Id_Work_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_WO_FIXED_PRICE", DbType.Decimal, objWOJobDetailsBO.WO_Fixed_Price)
                    objDB.AddInParameter(objcmd, "@iv_ID_JOBPCD_WO", DbType.String, objWOJobDetailsBO.Id_Jobpcd_WO)
                    objDB.AddInParameter(objcmd, "@iv_WO_PLANNED_TIME", DbType.String, objWOJobDetailsBO.WO_Planned_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_HOURLEY_PRICE", DbType.Decimal, Convert.ToDecimal(objWOJobDetailsBO.WO_Hourley_Price))
                    objDB.AddInParameter(objcmd, "@iv_WO_CLK_TIME", DbType.String, objWOJobDetailsBO.WO_Clk_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_CHRG_TIME", DbType.String, objCommonUtil.GetDefaultNoFormat(String.Empty, objWOJobDetailsBO.WO_Chrg_Time))
                    objDB.AddInParameter(objcmd, "@iv_FLG_CHRG_STD_TIME", DbType.Boolean, objWOJobDetailsBO.Flg_Chrg_Std_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_STD_TIME", DbType.String, objWOJobDetailsBO.WO_Std_Time)
                    objDB.AddInParameter(objcmd, "@iv_FLG_STAT_REQ", DbType.Int32, objWOJobDetailsBO.Stat_Req)
                    objDB.AddInParameter(objcmd, "@iv_WO_JOB_TXT", DbType.String, objWOJobDetailsBO.WO_Job_Txt)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Own_Risk_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_LAB_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Lab_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_SPARE_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Spare_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_GM_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Gm_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_VAT_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Vat_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_DISC_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Disc_Amt)
                    objDB.AddInParameter(objcmd, "@iv_JOB_STATUS", DbType.String, objWOJobDetailsBO.Job_Status)
                    objDB.AddInParameter(objcmd, "@iv_CREATED_BY", DbType.String, objWOJobDetailsBO.Created_By)
                    objDB.AddInParameter(objcmd, "@iv_DT_CREATED", DbType.String, objWOJobDetailsBO.Dt_Created)
                    objDB.AddInParameter(objcmd, "@ib_WO_OWN_PAY_VAT", DbType.Boolean, objWOJobDetailsBO.WO_Own_Pay_Vat)
                    objDB.AddInParameter(objcmd, "@id_WO_DT_PLANNED", DbType.String, objWOJobDetailsBO.Dt_Planned)
                    objDB.AddInParameter(objcmd, "@iv_XMLDISDOC", DbType.String, objWOJobDetailsBO.Dis_Doc)
                    objDB.AddInParameter(objcmd, "@II_ID_DEF_SEQ", DbType.Int32, objWOJobDetailsBO.Id_Def_Seq)
                    objDB.AddInParameter(objcmd, "@iv_TOTALAMT", DbType.Decimal, Convert.ToDecimal(objWOJobDetailsBO.Tot_Amount))
                    objDB.AddInParameter(objcmd, "@iv_XMLMECHDOC", DbType.String, objWOJobDetailsBO.Mechanic_Doc)
                    objDB.AddInParameter(objcmd, "@ii_ID_MECH_COMP", DbType.String, objWOJobDetailsBO.Mech_Compt_Description)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_CUST", DbType.String, objWOJobDetailsBO.WO_Own_Risk_Cust)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_CR_CUST", DbType.String, objWOJobDetailsBO.WO_Own_Cr_Cust)
                    objDB.AddInParameter(objcmd, "@ii_ID_SER_CALLNO", DbType.Int32, objWOJobDetailsBO.Id_Ser_Call)
                    objDB.AddInParameter(objcmd, "@II_WO_GM_PER", DbType.Decimal, Convert.ToDecimal(objWOJobDetailsBO.WO_Gm_Per))
                    objDB.AddInParameter(objcmd, "@II_WO_GM_VATPER", DbType.Decimal, objWOJobDetailsBO.WO_Gm_Vatper)
                    objDB.AddInParameter(objcmd, "@II_WO_LBR_VATPER", DbType.Decimal, objWOJobDetailsBO.WO_Lbr_Vatper)
                    objDB.AddInParameter(objcmd, "@BUS_PEK_CONTROL_NUM", DbType.String, objWOJobDetailsBO.Bus_Pek_Control_Num)
                    objDB.AddInParameter(objcmd, "@IV_PKKDATE", DbType.String, objWOJobDetailsBO.WO_PKKDate)
                    objDB.AddInParameter(objcmd, "@WO_INCL_VAT", DbType.Boolean, objWOJobDetailsBO.WO_Incl_Vat)
                    objDB.AddInParameter(objcmd, "@WO_DISCOUNT", DbType.Decimal, objWOJobDetailsBO.WO_Discount)
                    objDB.AddInParameter(objcmd, "@ID_SUBREP_CODE_WO", DbType.Int32, objWOJobDetailsBO.Id_Subrep_Code_WO)
                    objDB.AddInParameter(objcmd, "@WO_OWNRISKVAT", DbType.Decimal, objWOJobDetailsBO.WO_Ownriskvat)
                    objDB.AddInParameter(objcmd, "@IV_FLG_SPRSTS", DbType.Boolean, objWOJobDetailsBO.Flg_Sprsts)
                    objDB.AddInParameter(objcmd, "@SALESMAN", DbType.String, objWOJobDetailsBO.Salesman)
                    objDB.AddInParameter(objcmd, "@FLG_VAT_FREE", DbType.Boolean, objWOJobDetailsBO.Flg_Vat_Free)
                    objDB.AddInParameter(objcmd, "@COST_PRICE", DbType.Decimal, Convert.ToDecimal(objWOJobDetailsBO.Cost_Price))
                    objDB.AddInParameter(objcmd, "@WO_FINAL_TOTAL", DbType.Decimal, objWOJobDetailsBO.Final_Total)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_VAT", DbType.Decimal, objWOJobDetailsBO.Final_Vat)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_DISCOUNT", DbType.Decimal, objWOJobDetailsBO.Final_Discount)
                    objDB.AddInParameter(objcmd, "@ID_JOB", DbType.Int32, objWOJobDetailsBO.Id_Job)
                    objDB.AddInParameter(objcmd, "@iv_WO_CHRG_TIME_FP", DbType.String, objWOJobDetailsBO.WO_Chrg_Time_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_LAB_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Lab_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_SPARE_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Spare_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_GM_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Gm_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_VAT_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Vat_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_DISC_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Disc_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_INT_NOTE", DbType.String, objWOJobDetailsBO.WO_Int_Note)
                    objDB.AddInParameter(objcmd, "@iv_WO_ID_MECHANIC", DbType.String, objWOJobDetailsBO.IdMech)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_DESC", DbType.String, objWOJobDetailsBO.WO_Own_Risk_Desc)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_SL_NO", DbType.Int32, objWOJobDetailsBO.WO_Own_Risk_SlNo)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)
                    objDB.AddOutParameter(objcmd, "@iv_ID_JOB", DbType.Int32, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strResult = objDB.GetParameterValue(objcmd, "@OV_RETVALUE") + ";"
                    strArray = strResult.Split(";")
                    ' strRetVal(1) = objDB.GetParameterValue(objcmd, "@iv_ID_JOB").ToString
                End Using

            Catch ex As Exception
                Throw ex
            End Try
            Return strArray
        End Function

        Public Function Get_vat_Dis(ByVal objWOJobDetailsBO As WOJobDetailBO) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_PLAN_MINIWO_GET_VAT_DISC")
                    objDB.AddInParameter(objcmd, "@IV_ID_USER", DbType.String, objWOJobDetailsBO.Created_By)
                    objDB.AddInParameter(objcmd, "@iv_ID_CUST", DbType.String, objWOJobDetailsBO.Id_Job_Deb)
                    objDB.AddInParameter(objcmd, "@iv_ID_ITEM", DbType.String, objWOJobDetailsBO.Id_Item_Job)
                    objDB.AddInParameter(objcmd, "@IV_VAT_VEH", DbType.String, objWOJobDetailsBO.WO_Id_Veh)
                    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, objWOJobDetailsBO.Id_Make)
                    objDB.AddInParameter(objcmd, "@IV_ID_WH", DbType.Int16, objWOJobDetailsBO.Id_Wh_Item)
                    objDB.AddOutParameter(objcmd, "@OD_DISC", DbType.String, 50)
                    objDB.AddOutParameter(objcmd, "@OD_VAT", DbType.String, 50)
                    objDB.ExecuteDataSet(objcmd)
                    strStatus = objDB.GetParameterValue(objcmd, "@OD_DISC").ToString + ";" + objDB.GetParameterValue(objcmd, "@OD_VAT").ToString
                End Using
            Catch ex As Exception
                Throw ex
            End Try
            Return strStatus
        End Function
        Public Function FetchSpareMake(ByVal idMake As String) As DataSet
            Try
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPARE_FETCH_MAKE_LOCATION")
                    objDB.AddInParameter(objCMD, "@ID_MAKE", DbType.String, idMake)
                    Return objDB.ExecuteDataSet(objCMD)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function FetchSpareSupplier(ByVal idSupplier As String) As DataSet
            Try
                Using objCMD As DbCommand = objDB.GetStoredProcCommand("USP_SPR_GET_SUPPLIER")
                    objDB.AddInParameter(objCMD, "@SUPPLIER", DbType.String, idSupplier)
                    Return objDB.ExecuteDataSet(objCMD)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_WO_ClkTime(ByVal Id_WO_NO As String, ByVal Id_WO_Prefix As String, ByVal Id_Job As Integer) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_CLOCKTIME")
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@ID_JOB", DbType.Int32, Id_Job)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Update_WOJobDetails(ByVal objWOJobDetailsBO As WOJobDetailBO) As String()
            Dim strRetVal As String = ""
            Dim strArray As Array
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_DETAILS_UPDATE")
                    objDB.AddInParameter(objcmd, "@iv_xmljobDoc", DbType.String, objWOJobDetailsBO.Job_Doc) 'check datatype
                    objDB.AddInParameter(objcmd, "@iv_xmlwoDoc", DbType.String, objWOJobDetailsBO.WO_Doc)
                    objDB.AddInParameter(objcmd, "@iv_ID_WODET_SEQ", DbType.Int32, objWOJobDetailsBO.Id_Wodet_Seq)
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@iv_ID_RPG_CATG_WO", DbType.String, objWOJobDetailsBO.Id_Rpg_Catg_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_RPG_CODE_WO", DbType.String, objWOJobDetailsBO.Id_Rpg_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_REP_CODE_WO", DbType.Int32, objWOJobDetailsBO.Id_Rep_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_WORK_CODE_WO", DbType.String, objWOJobDetailsBO.Id_Work_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_WO_FIXED_PRICE", DbType.Decimal, objWOJobDetailsBO.WO_Fixed_Price)
                    objDB.AddInParameter(objcmd, "@iv_ID_JOBPCD_WO", DbType.String, objWOJobDetailsBO.Id_Jobpcd_WO)
                    objDB.AddInParameter(objcmd, "@iv_WO_PLANNED_TIME", DbType.String, objWOJobDetailsBO.WO_Planned_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_HOURLEY_PRICE", DbType.Decimal, Convert.ToDecimal(IIf(objWOJobDetailsBO.WO_Hourley_Price = "", 0, objWOJobDetailsBO.WO_Hourley_Price)))
                    objDB.AddInParameter(objcmd, "@iv_WO_CLK_TIME", DbType.String, objWOJobDetailsBO.WO_Clk_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_CHRG_TIME", DbType.String, objCommonUtil.GetDefaultNoFormat(String.Empty, objWOJobDetailsBO.WO_Chrg_Time))
                    objDB.AddInParameter(objcmd, "@iv_FLG_CHRG_STD_TIME", DbType.Boolean, objWOJobDetailsBO.Flg_Chrg_Std_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_STD_TIME", DbType.String, objWOJobDetailsBO.WO_Std_Time)
                    objDB.AddInParameter(objcmd, "@iv_FLG_STAT_REQ", DbType.Int32, objWOJobDetailsBO.Stat_Req)
                    objDB.AddInParameter(objcmd, "@iv_WO_JOB_TXT", DbType.String, objWOJobDetailsBO.WO_Job_Txt)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Own_Risk_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_LAB_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Lab_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_SPARE_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Spare_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_GM_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Gm_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_VAT_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Vat_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_DISC_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Disc_Amt)
                    objDB.AddInParameter(objcmd, "@iv_JOB_STATUS", DbType.String, objWOJobDetailsBO.Job_Status)
                    objDB.AddInParameter(objcmd, "@iv_MODIFIED_BY", DbType.String, objWOJobDetailsBO.Modified_By)
                    objDB.AddInParameter(objcmd, "@iv_DT_MODIFIED", DbType.String, objWOJobDetailsBO.Dt_Modified)
                    objDB.AddInParameter(objcmd, "@iv_ID_JOB", DbType.Int16, objWOJobDetailsBO.Id_Job)
                    objDB.AddInParameter(objcmd, "@iv_XMLDISDOC", DbType.String, objWOJobDetailsBO.Dis_Doc)
                    objDB.AddInParameter(objcmd, "@id_WO_DT_PLANNED", DbType.String, objWOJobDetailsBO.Dt_Planned)
                    objDB.AddInParameter(objcmd, "@iv_TOTALAMT", DbType.Decimal, objWOJobDetailsBO.Tot_Amount)
                    objDB.AddInParameter(objcmd, "@ib_WO_OWN_PAY_VAT", DbType.Boolean, objWOJobDetailsBO.WO_Own_Pay_Vat)
                    objDB.AddInParameter(objcmd, "@II_ID_DEF_SEQ", DbType.Int32, objWOJobDetailsBO.Id_Def_Seq)
                    objDB.AddInParameter(objcmd, "@ii_ID_MECH_COMP", DbType.String, objWOJobDetailsBO.Mech_Compt_Description)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_CUST", DbType.String, objWOJobDetailsBO.WO_Own_Risk_Cust)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_CR_CUST", DbType.String, objWOJobDetailsBO.WO_Own_Cr_Cust)
                    objDB.AddInParameter(objcmd, "@ii_ID_SER_CALLNO", DbType.Int32, objWOJobDetailsBO.Id_Ser_Call)
                    objDB.AddInParameter(objcmd, "@II_WO_GM_PER", DbType.Decimal, objWOJobDetailsBO.WO_Gm_Per)
                    objDB.AddInParameter(objcmd, "@II_WO_GM_VATPER", DbType.Decimal, objWOJobDetailsBO.WO_Gm_Vatper)
                    objDB.AddInParameter(objcmd, "@II_WO_LBR_VATPER", DbType.Decimal, objWOJobDetailsBO.WO_Lbr_Vatper)
                    objDB.AddInParameter(objcmd, "@BUS_PEK_CONTROL_NUM", DbType.String, objWOJobDetailsBO.Bus_Pek_Control_Num)
                    objDB.AddInParameter(objcmd, "@IV_PKKDATE", DbType.String, objWOJobDetailsBO.WO_PKKDate)
                    objDB.AddInParameter(objcmd, "@iv_XMLMECHDOC", DbType.String, objWOJobDetailsBO.Mechanic_Doc)
                    objDB.AddInParameter(objcmd, "@WO_INCL_VAT", DbType.Boolean, objWOJobDetailsBO.WO_Incl_Vat)
                    objDB.AddInParameter(objcmd, "@WO_DISCOUNT", DbType.Decimal, objWOJobDetailsBO.WO_Discount)
                    objDB.AddInParameter(objcmd, "@ID_SUBREP_CODE_WO", DbType.Int32, objWOJobDetailsBO.Id_Subrep_Code_WO)
                    objDB.AddInParameter(objcmd, "@WO_OWNRISKVAT", DbType.Decimal, objWOJobDetailsBO.WO_Ownriskvat)
                    objDB.AddInParameter(objcmd, "@IV_FLG_SPRSTS", DbType.Boolean, objWOJobDetailsBO.Flg_Sprsts)
                    objDB.AddInParameter(objcmd, "@SALESMAN", DbType.String, objWOJobDetailsBO.Salesman)
                    objDB.AddInParameter(objcmd, "@FLG_VAT_FREE", DbType.Boolean, objWOJobDetailsBO.Flg_Vat_Free)
                    objDB.AddInParameter(objcmd, "@COST_PRICE", DbType.Decimal, objWOJobDetailsBO.Cost_Price)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_TOTAL", DbType.Decimal, objWOJobDetailsBO.Final_Total)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_VAT", DbType.Decimal, objWOJobDetailsBO.Final_Vat)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_DISCOUNT", DbType.Decimal, objWOJobDetailsBO.Final_Discount)
                    objDB.AddInParameter(objcmd, "@iv_WO_CHRG_TIME_FP", DbType.String, objWOJobDetailsBO.WO_Chrg_Time_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_LAB_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Lab_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_SPARE_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Spare_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_GM_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Gm_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_VAT_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Vat_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_DISC_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Disc_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_INT_NOTE", DbType.String, objWOJobDetailsBO.WO_Int_Note)
                    objDB.AddInParameter(objcmd, "@iv_WO_ID_MECHANIC", DbType.String, objWOJobDetailsBO.IdMech)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_DESC", DbType.String, objWOJobDetailsBO.WO_Own_Risk_Desc)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_SL_NO", DbType.Int32, objWOJobDetailsBO.WO_Own_Risk_SlNo)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strRetVal = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString + ";"
                    strArray = strRetVal.Split(";")
                    'strRetVal(1) = "1" 'objDB.GetParameterValue(objcmd, "@iv_ID_JOB").ToString
                End Using

            Catch ex As Exception
                Throw ex
            End Try
            Return strArray
        End Function
        Public Function GetSubRepairCode(ByVal Id_Rep_Code As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_SUBREPAIRCODE_FETCH")
                    objDB.AddInParameter(objcmd, "@ID_REP_CODE", DbType.Int16, Convert.ToInt32(Id_Rep_Code))
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Cust_CostPriceDetails(ByVal custId As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCHCUST_COSTPRICE")
                    objDB.AddInParameter(objcmd, "@iv_CUST", DbType.String, custId)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Fetch_RPSpareDetails(ByVal repPkgSeq As String, ByVal custId As String, ByVal vehId As String, ByVal userId As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_RP_SPARES_VIEW")
                    objDB.AddInParameter(objcmd, "@ID_RPKG_SEQ", DbType.Int16, Convert.ToInt16(repPkgSeq))
                    objDB.AddInParameter(objcmd, "@IV_ID_CUST", DbType.String, custId)
                    objDB.AddInParameter(objcmd, "@IV_ID_VEH", DbType.String, vehId)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, userId)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Load_Mechanics(ByVal idWONO As String, ByVal idWOPrefix As String, ByVal jobId As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_LOADMECHANICS")
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, idWONO)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, idWOPrefix)
                    objDB.AddInParameter(objcmd, "@II_ID_JOB", DbType.String, jobId)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function GetJobText(ByVal opertaionCode As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_GET_JOBTEXT")
                    objDB.AddInParameter(objcmd, "@Opertaion_Code", DbType.String, opertaionCode)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function GetAllJobCodes(ByVal jobText As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MAS_JOBTEXT_ALPHA_SEARCH_ALL")
                    objDB.AddInParameter(objcmd, "@IV_JOBTEXT", DbType.String, jobText)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_ClockTime(ByVal idWONO As String, ByVal idWOPrefix As String, ByVal idJob As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_FETCH_MINS")
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, idWONO)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, idWOPrefix)
                    objDB.AddInParameter(objcmd, "@II_ID_JOB", DbType.String, idJob)
                    objDB.AddOutParameter(objcmd, "@OI_MINS", DbType.Int16, 1)

                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_SpareStatus(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCHSPARE_STATUS")
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_JOB", DbType.String, objWOJobDetailsBO.Id_Job)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_ReplacementSpares(ByVal spareId As String, ByVal spareMake As String, ByVal userId As String, ByVal flag As String) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_REPLACEMENT")
                    objDB.AddInParameter(objcmd, "@IV_ID_LOCALSPAREPART", DbType.String, spareId)
                    objDB.AddInParameter(objcmd, "@IV_ID_MAKE", DbType.String, spareMake)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, userId)
                    objDB.AddInParameter(objcmd, "@FLAG", DbType.String, flag)
                    Return objDB.ExecuteScalar(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function UpdateDeliveryNotePrevPrinted(ByVal idWONO As String, ByVal idWOPrefix As String, ByVal idWOJobNO As String)
            Dim count As Integer = 0
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_Upd_DeliveryNotePrevPrinted")
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, idWONO)
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, idWOPrefix)
                    objDB.AddInParameter(objcmd, "@ID_WO_JOBNO", DbType.String, idWOJobNO)
                    count = objDB.ExecuteNonQuery(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
            Return count
        End Function
        Public Function UpdatePickingListPrevPrinted(ByVal idWONO As String, ByVal idWOPrefix As String, ByVal idWOJobNO As String)
            Dim count As Integer = 0
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_Upd_PickingListPrevPrinted")
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, idWONO)
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, idWOPrefix)
                    objDB.AddInParameter(objcmd, "@ID_WO_JOBNO", DbType.String, idWOJobNO)
                    count = objDB.ExecuteNonQuery(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
            Return count
        End Function
        Public Function Get_Spare(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_GET_SPARE")
                    objDB.AddInParameter(objcmd, "@iv_ItemDesc", DbType.String, objWOJobDetailsBO.Id_Item)
                    objDB.AddInParameter(objcmd, "@IV_ID_CUST", DbType.String, objWOJobDetailsBO.Id_Customer)
                    objDB.AddInParameter(objcmd, "@IV_ID_VEH", DbType.String, objWOJobDetailsBO.WO_Id_Veh)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, objWOJobDetailsBO.Created_By)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function Update_Delete_WOJobDetails(ByVal objWOJobDetailsBO As WOJobDetailBO) As String()
            Dim strRetVal As String = ""
            Dim strArray As Array
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_DETAILS_DELETE_UPDATE")
                    objDB.AddInParameter(objcmd, "@iv_xmljobDoc", DbType.String, objWOJobDetailsBO.Job_Doc) 'check datatype
                    objDB.AddInParameter(objcmd, "@iv_xmlwoDoc", DbType.String, objWOJobDetailsBO.WO_Doc)
                    objDB.AddInParameter(objcmd, "@iv_ID_WODET_SEQ", DbType.Int32, objWOJobDetailsBO.Id_Wodet_Seq)
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@iv_ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@iv_ID_RPG_CATG_WO", DbType.String, objWOJobDetailsBO.Id_Rpg_Catg_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_RPG_CODE_WO", DbType.String, objWOJobDetailsBO.Id_Rpg_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_REP_CODE_WO", DbType.Int32, objWOJobDetailsBO.Id_Rep_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_ID_WORK_CODE_WO", DbType.String, objWOJobDetailsBO.Id_Work_Code_WO)
                    objDB.AddInParameter(objcmd, "@iv_WO_FIXED_PRICE", DbType.Decimal, objWOJobDetailsBO.WO_Fixed_Price)
                    objDB.AddInParameter(objcmd, "@iv_ID_JOBPCD_WO", DbType.String, objWOJobDetailsBO.Id_Jobpcd_WO)
                    objDB.AddInParameter(objcmd, "@iv_WO_PLANNED_TIME", DbType.String, objWOJobDetailsBO.WO_Planned_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_HOURLEY_PRICE", DbType.Decimal, Convert.ToDecimal(IIf(objWOJobDetailsBO.WO_Hourley_Price = "", 0, objWOJobDetailsBO.WO_Hourley_Price)))
                    objDB.AddInParameter(objcmd, "@iv_WO_CLK_TIME", DbType.String, objWOJobDetailsBO.WO_Clk_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_CHRG_TIME", DbType.String, objCommonUtil.GetDefaultNoFormat(String.Empty, objWOJobDetailsBO.WO_Chrg_Time))
                    objDB.AddInParameter(objcmd, "@iv_FLG_CHRG_STD_TIME", DbType.Boolean, objWOJobDetailsBO.Flg_Chrg_Std_Time)
                    objDB.AddInParameter(objcmd, "@iv_WO_STD_TIME", DbType.String, objWOJobDetailsBO.WO_Std_Time)
                    objDB.AddInParameter(objcmd, "@iv_FLG_STAT_REQ", DbType.Int32, objWOJobDetailsBO.Stat_Req)
                    objDB.AddInParameter(objcmd, "@iv_WO_JOB_TXT", DbType.String, objWOJobDetailsBO.WO_Job_Txt)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Own_Risk_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_LAB_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Lab_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_SPARE_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Spare_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_GM_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Gm_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_VAT_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Vat_Amt)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_DISC_AMT", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Disc_Amt)
                    objDB.AddInParameter(objcmd, "@iv_JOB_STATUS", DbType.String, objWOJobDetailsBO.Job_Status)
                    objDB.AddInParameter(objcmd, "@iv_MODIFIED_BY", DbType.String, objWOJobDetailsBO.Modified_By)
                    objDB.AddInParameter(objcmd, "@iv_DT_MODIFIED", DbType.String, objWOJobDetailsBO.Dt_Modified)
                    objDB.AddInParameter(objcmd, "@iv_ID_JOB", DbType.Int16, objWOJobDetailsBO.Id_Job)
                    objDB.AddInParameter(objcmd, "@iv_XMLDISDOC", DbType.String, objWOJobDetailsBO.Dis_Doc)
                    objDB.AddInParameter(objcmd, "@id_WO_DT_PLANNED", DbType.String, objWOJobDetailsBO.Dt_Planned)
                    objDB.AddInParameter(objcmd, "@iv_TOTALAMT", DbType.Decimal, objWOJobDetailsBO.Tot_Amount)
                    objDB.AddInParameter(objcmd, "@ib_WO_OWN_PAY_VAT", DbType.Boolean, objWOJobDetailsBO.WO_Own_Pay_Vat)
                    objDB.AddInParameter(objcmd, "@II_ID_DEF_SEQ", DbType.Int32, objWOJobDetailsBO.Id_Def_Seq)
                    objDB.AddInParameter(objcmd, "@ii_ID_MECH_COMP", DbType.String, objWOJobDetailsBO.Mech_Compt_Description)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_CUST", DbType.String, objWOJobDetailsBO.WO_Own_Risk_Cust)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_CR_CUST", DbType.String, objWOJobDetailsBO.WO_Own_Cr_Cust)
                    objDB.AddInParameter(objcmd, "@ii_ID_SER_CALLNO", DbType.Int32, objWOJobDetailsBO.Id_Ser_Call)
                    objDB.AddInParameter(objcmd, "@II_WO_GM_PER", DbType.Decimal, objWOJobDetailsBO.WO_Gm_Per)
                    objDB.AddInParameter(objcmd, "@II_WO_GM_VATPER", DbType.Decimal, objWOJobDetailsBO.WO_Gm_Vatper)
                    objDB.AddInParameter(objcmd, "@II_WO_LBR_VATPER", DbType.Decimal, objWOJobDetailsBO.WO_Lbr_Vatper)
                    objDB.AddInParameter(objcmd, "@BUS_PEK_CONTROL_NUM", DbType.String, objWOJobDetailsBO.Bus_Pek_Control_Num)
                    objDB.AddInParameter(objcmd, "@IV_PKKDATE", DbType.String, objWOJobDetailsBO.WO_PKKDate)
                    objDB.AddInParameter(objcmd, "@iv_XMLMECHDOC", DbType.String, objWOJobDetailsBO.Mechanic_Doc)
                    objDB.AddInParameter(objcmd, "@WO_INCL_VAT", DbType.Boolean, objWOJobDetailsBO.WO_Incl_Vat)
                    objDB.AddInParameter(objcmd, "@WO_DISCOUNT", DbType.Decimal, objWOJobDetailsBO.WO_Discount)
                    objDB.AddInParameter(objcmd, "@ID_SUBREP_CODE_WO", DbType.Int32, objWOJobDetailsBO.Id_Subrep_Code_WO)
                    objDB.AddInParameter(objcmd, "@WO_OWNRISKVAT", DbType.Decimal, objWOJobDetailsBO.WO_Ownriskvat)
                    objDB.AddInParameter(objcmd, "@IV_FLG_SPRSTS", DbType.Boolean, objWOJobDetailsBO.Flg_Sprsts)
                    objDB.AddInParameter(objcmd, "@SALESMAN", DbType.String, objWOJobDetailsBO.Salesman)
                    objDB.AddInParameter(objcmd, "@FLG_VAT_FREE", DbType.Boolean, objWOJobDetailsBO.Flg_Vat_Free)
                    objDB.AddInParameter(objcmd, "@COST_PRICE", DbType.Decimal, objWOJobDetailsBO.Cost_Price)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_TOTAL", DbType.Decimal, objWOJobDetailsBO.Final_Total)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_VAT", DbType.Decimal, objWOJobDetailsBO.Final_Vat)
                    objDB.AddInParameter(objcmd, "@WO_FINAL_DISCOUNT", DbType.Decimal, objWOJobDetailsBO.Final_Discount)
                    objDB.AddInParameter(objcmd, "@iv_WO_CHRG_TIME_FP", DbType.String, objWOJobDetailsBO.WO_Chrg_Time_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_LAB_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Lab_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_SPARE_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Spare_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_GM_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Gm_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_VAT_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Vat_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_TOT_DISC_AMT_FP", DbType.Decimal, objWOJobDetailsBO.WO_Tot_Disc_Amt_Fp)
                    objDB.AddInParameter(objcmd, "@iv_WO_INT_NOTE", DbType.String, objWOJobDetailsBO.WO_Int_Note)
                    objDB.AddInParameter(objcmd, "@iv_WO_ID_MECHANIC", DbType.String, objWOJobDetailsBO.IdMech)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_DESC", DbType.String, objWOJobDetailsBO.WO_Own_Risk_Desc)
                    objDB.AddInParameter(objcmd, "@iv_WO_OWN_RISK_SL_NO", DbType.Int32, objWOJobDetailsBO.WO_Own_Risk_SlNo)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strRetVal = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString + ";"
                    strArray = strRetVal.Split(";")
                    'strRetVal(1) = "1" 'objDB.GetParameterValue(objcmd, "@iv_ID_JOB").ToString
                End Using

            Catch ex As Exception
                Throw ex
            End Try
            Return strArray
        End Function
        Public Function Save_SpSettings(ByVal objWOJobDetailsBO As WOJobDetailBO) As String
            Dim strRetVal As String = ""
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_SPARE_SETT")
                    objDB.AddInParameter(objcmd, "@SP_MAKE", DbType.String, objWOJobDetailsBO.Id_Make) 'check datatype
                    objDB.AddInParameter(objcmd, "@SP_SUPPLIER", DbType.String, objWOJobDetailsBO.SP_SupplierName)
                    objDB.AddInParameter(objcmd, "@SP_LOCATION", DbType.String, objWOJobDetailsBO.Sp_Location)
                    objDB.AddInParameter(objcmd, "@StockItem", DbType.Boolean, objWOJobDetailsBO.Sp_FlgStockItem)
                    objDB.AddInParameter(objcmd, "@Flg_stockitem_status", DbType.Boolean, objWOJobDetailsBO.SP_FlgStockItemStatus)
                    objDB.AddInParameter(objcmd, "@Flg_nonstockitem_status", DbType.String, objWOJobDetailsBO.SP_FlgNonStockItemStatus)
                    objDB.AddInParameter(objcmd, "@CreatedBy", DbType.String, objWOJobDetailsBO.Created_By)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strRetVal = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                End Using

            Catch ex As Exception
                Throw ex
            End Try
            Return strRetVal
        End Function
        Public Function Del_TextLine(ByVal objWOJobDetailsBO As WOJobDetailBO) As String
            Dim strRetVal As String = ""
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_DEL_SPARE_TEXTLINE")
                    objDB.AddInParameter(objcmd, "@Id_Wo_No", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@Id_Wo_Pr", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@Id_WoItem_Seq", DbType.String, objWOJobDetailsBO.Id_WOItem_Seq)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 10)

                    objDB.ExecuteNonQuery(objcmd)
                    strRetVal = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                End Using

            Catch ex As Exception
                Throw ex
            End Try
            Return strRetVal
        End Function
        Public Function Delete_Job_Debitor(ByVal objWOJobDetailsBO As WOJobDetailBO) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("usp_WO_DEBITOR_DELETE")
                    objDB.AddInParameter(objcmd, "@iv_xmlDoc", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddOutParameter(objcmd, "@ov_RetValue", DbType.String, 10)
                    objDB.AddOutParameter(objcmd, "@ov_CntDelete", DbType.String, 2000)
                    objDB.AddOutParameter(objcmd, "@ov_DeletedCfg", DbType.String, 2000)
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = CStr(objDB.GetParameterValue(objcmd, "@ov_RetValue") + "," + Replace(CStr(IIf(IsDBNull(objDB.GetParameterValue(objcmd, "@ov_DeletedCfg")), "", objDB.GetParameterValue(objcmd, "@ov_DeletedCfg"))), ",", "") + "," + Replace(CStr(IIf(IsDBNull(objDB.GetParameterValue(objcmd, "@ov_CntDelete")), "", objDB.GetParameterValue(objcmd, "@ov_CntDelete"))), ",", ""))
                End Using
                Return strStatus
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function LoadDelJobDet(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_DEBTOR_JOB_CHECK")
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@ID_USER", DbType.String, System.Web.HttpContext.Current.Session("UserID"))
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function LoadWorkOrderSpares(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_RPT_WORKORDERSPARES")
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, objWOJobDetailsBO.Id_WO_Prefix)

                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function UpdVehOwner(ByVal objWOJobDetailsBO As WOJobDetailBO) As String
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_UPDATE_VEHICLE_OWNER")
                    objDB.AddInParameter(objcmd, "@ID_VEH_SEQ", DbType.Int32, objWOJobDetailsBO.WO_Id_Veh)
                    objDB.AddInParameter(objcmd, "@ID_CUSTOMER_VEH", DbType.String, objWOJobDetailsBO.Id_Customer)
                    objDB.AddOutParameter(objcmd, "@OV_RETVAL", DbType.String, 20)
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = CStr(objDB.GetParameterValue(objcmd, "@OV_RETVAL"))
                End Using
                Return strStatus
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function UPDATECREDITNOTESTOCK(ByVal idWONO As String, ByVal idWOPrefix As String) As String
            Dim strRetVal As String = ""
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_UPDATE_STOCK_CREDITNOTE")
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, idWONO)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, idWOPrefix)
                    objDB.AddInParameter(objcmd, "@CREATED_BY", DbType.String, HttpContext.Current.Session("UserID"))
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 20)
                    objDB.ExecuteNonQuery(objcmd)
                    strStatus = CStr(objDB.GetParameterValue(objcmd, "@OV_RETVALUE"))
                End Using
            Catch ex As Exception
                Throw ex
            End Try
            Return strRetVal
        End Function
        Public Function Fetch_EHF_Info(ByVal idInvNo As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_REP_INVOICE_EHF")
                    objDB.AddInParameter(objcmd, "@ID_INV_NO", DbType.String, idInvNo)
                    objDB.AddInParameter(objcmd, "@TYPE", DbType.String, "INVOICE")
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function
        Public Function Fetch_INV_Info(ByVal idWoNo As String, ByVal idWoPr As String) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_FETCH_INVOICENOS")
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, idWoNo)
                    objDB.AddInParameter(objcmd, "@ID_WO_PREFIX", DbType.String, idWoPr)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function SaveServiceResponse(ByVal order As String, ByVal text As String, ByVal status As String, ByVal service As String, ByVal loginName As String) As String
            Try
                Dim strStatus As String
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_INSERT_WEBSERVICE_RESPONSE")
                    objDB.AddInParameter(objcmd, "@ORDERNO", DbType.String, order)
                    objDB.AddInParameter(objcmd, "@TEXT", DbType.String, text)
                    objDB.AddInParameter(objcmd, "@STATUS", DbType.String, status)
                    objDB.AddInParameter(objcmd, "@SERVICE", DbType.String, service)
                    objDB.AddInParameter(objcmd, "@LOGIN", DbType.String, loginName)
                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Catch ex As Exception
                        Throw ex
                    End Try
                End Using
                'Return strStatus


            Catch ex As Exception
                Throw ex
            End Try
            Return strStatus
        End Function

        Public Function FetchOfferAmount(ByVal objWOJobDetailsBO As WOJobDetailBO) As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_FETCH_ORDER_AMOUNT")
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, objWOJobDetailsBO.Id_WO_NO)
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function LoadOrderSpareStatus() As DataSet
            Try
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_WO_ORDER_SPARE_STATUS_FETCH")
                    Return objDB.ExecuteDataSet(objcmd)
                End Using
            Catch ex As Exception
                Throw ex
            End Try
        End Function

        Public Function UpdateEniroDetails(ByVal objWOJDBO As WOJobDetailBO) As String
            Try
                Dim strStatus As String
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_CUSTOMER_ENIRO_UPDATE")
                    objDB.AddInParameter(objcmd, "@ID_CUSTOMER", DbType.String, objWOJDBO.Id_Customer)
                    objDB.AddInParameter(objcmd, "@LAST_NAME", DbType.String, objWOJDBO.LastName)
                    objDB.AddInParameter(objcmd, "@FIRST_NAME", DbType.String, objWOJDBO.FirstName)
                    objDB.AddInParameter(objcmd, "@MIDDLE_NAME", DbType.String, objWOJDBO.MiddleName)
                    objDB.AddInParameter(objcmd, "@VISIT_ADDRESS", DbType.String, objWOJDBO.VisitAddress)
                    objDB.AddInParameter(objcmd, "@BILLING_ADDRESS", DbType.String, objWOJDBO.BillingAddress)
                    objDB.AddInParameter(objcmd, "@ZIP_CODE", DbType.String, objWOJDBO.ZipCode)
                    objDB.AddInParameter(objcmd, "@ZIP_PLACE", DbType.String, objWOJDBO.ZipPlace)
                    objDB.AddInParameter(objcmd, "@PHONE", DbType.String, objWOJDBO.Phone)
                    objDB.AddInParameter(objcmd, "@MOBILE", DbType.String, objWOJDBO.Mobile)
                    objDB.AddInParameter(objcmd, "@BORN", DbType.String, objWOJDBO.Born)
                    objDB.AddInParameter(objcmd, "@SSN", DbType.String, objWOJDBO.SSN)
                    objDB.AddInParameter(objcmd, "@LOGIN", DbType.String, objWOJDBO.Id_Login)

                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                Return strStatus

            Catch ex As Exception
                Throw ex
            End Try

        End Function

        Public Function ImportNBKData(ByVal objWOJDBO As WOJobDetailBO) As String
            Try
                Dim strStatus As String = ""
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_IMPORT_NBK_DATA")
                    objDB.AddInParameter(objcmd, "@IV_AD_LEV", DbType.String, objWOJDBO.ADLev)
                    objDB.AddInParameter(objcmd, "@IV_EDBNR", DbType.String, objWOJDBO.EdbNr)
                    objDB.AddInParameter(objcmd, "@IV_ALFA", DbType.String, objWOJDBO.Alfa)
                    objDB.AddInParameter(objcmd, "@IV_ARTNR", DbType.String, objWOJDBO.ArtNr)
                    objDB.AddInParameter(objcmd, "@IV_VARENAVN", DbType.String, objWOJDBO.VareNavn)
                    objDB.AddInParameter(objcmd, "@IV_BEHOLDNIND", DbType.Decimal, Convert.ToDecimal(objWOJDBO.Beholdning))
                    objDB.AddInParameter(objcmd, "@IV_PRIS", DbType.Decimal, Convert.ToDecimal(objWOJDBO.Priss))
                    objDB.AddInParameter(objcmd, "@IV_ANTALL", DbType.Decimal, Convert.ToDecimal(objWOJDBO.Antall))
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, objWOJDBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, objWOJDBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@IV_CREATEDBY", DbType.String, objWOJDBO.Id_Login)

                    objDB.AddOutParameter(objcmd, "@IV_RESULT", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@IV_RESULT").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                Return strStatus

            Catch ex As Exception
                Throw ex
            End Try

        End Function
        Public Function ModifyWOHeader(ByVal mode As String, ByVal objWOHeaderBO As WOHeaderBO) As String
            Try
                Dim strStatus As String
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_MODIFY_WO_HEAD")
                    objDB.AddInParameter(objcmd, "@MODE", DbType.String, mode)
                    objDB.AddInParameter(objcmd, "@ID_WO_NO", DbType.String, objWOHeaderBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@ID_PREFIX", DbType.String, objWOHeaderBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@USER_ID", DbType.String, objWOHeaderBO.Modified_By)

                    If mode.Contains("BARGAIN") Then
                    objDB.AddInParameter(objcmd, "@ID_BARGAIN", DbType.String, objWOHeaderBO.IdBargain)
                    objDB.AddInParameter(objcmd, "@IS_BARGAIN_ACCEPTED", DbType.Boolean, objWOHeaderBO.IsBargainAccepted)
                    ElseIf mode.Contains("XTRA") Then
                        objDB.AddInParameter(objcmd, "@ID_BARGAIN", DbType.String, objWOHeaderBO.IdXtraScheme)
                        objDB.AddInParameter(objcmd, "@IS_BARGAIN_ACCEPTED", DbType.Boolean, objWOHeaderBO.IsXtraSchemeAccepted)
                    End If

                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                Return strStatus

            Catch ex As Exception
                Throw ex
            End Try

        End Function
        Public Function SaveReturnSpare(ByVal objWOJDBO As WOJobDetailBO, ByVal user As String) As String()
            Try
                Dim strStatus As String() = {"", ""}
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_SAVE_RETURN_SPARES")
                    objDB.AddInParameter(objcmd, "@IV_ID_ITEM", DbType.String, objWOJDBO.Id_Item)
                    objDB.AddInParameter(objcmd, "@IV_ITEM_DESC", DbType.String, objWOJDBO.Item_Sp_Desc)
                    objDB.AddInParameter(objcmd, "@IV_QTY_RETURNED", DbType.Int32, objWOJDBO.Return_Qty)
                    objDB.AddInParameter(objcmd, "@IV_SALE_PRICE", DbType.Decimal, objWOJDBO.Sp_Item_Price)
                    objDB.AddInParameter(objcmd, "@IV_COST_PRICE", DbType.Decimal, objWOJDBO.Sp_Cost_Price)
                    objDB.AddInParameter(objcmd, "@IV_SUPPLIER_NO", DbType.String, objWOJDBO.SuppCurrNo)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, objWOJDBO.Id_WO_Prefix)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, objWOJDBO.Id_WO_NO)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, user)

                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)
                    objDB.AddOutParameter(objcmd, "@OV_ITEM_RETURN_NUM", DbType.Int32, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus(0) = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                        strStatus(1) = objDB.GetParameterValue(objcmd, "@OV_ITEM_RETURN_NUM").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                Return strStatus

            Catch ex As Exception
                Throw ex
            End Try

        End Function
        Public Function UpdateSPPrices(ByVal objWOJDBO As WOJobDetailBO) As String
            Try
                Dim strStatus As String = ""
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_UPD_CP_SP_Spares")
                    objDB.AddInParameter(objcmd, "@IV_ID_ITEM", DbType.String, objWOJDBO.Id_Item)
                    objDB.AddInParameter(objcmd, "@IV_SUPP_CURR_NO", DbType.String, objWOJDBO.SuppCurrNo)
                    objDB.AddInParameter(objcmd, "@IV_SALES_PRICE", DbType.Decimal, objWOJDBO.Pris)
                    objDB.AddInParameter(objcmd, "@IV_COST_PRICE", DbType.Decimal, objWOJDBO.Sp_Cost_Price)
                    objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, objWOJDBO.Id_Login)
                    objDB.AddInParameter(objcmd, "@IV_SPAREPART_ID", DbType.String, objWOJDBO.WebSparePartId)
                    objDB.AddInParameter(objcmd, "@IV_ID_WH", DbType.Int32, objWOJDBO.Id_Warehouse)

                    objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    Catch ex As Exception
                        Throw
                    End Try
                End Using
                Return strStatus

            Catch ex As Exception
                Throw ex
            End Try

        End Function
        Public Function ImportBGPData(ByVal objbgpBO As BilglassportalenBO) As String
            Try
                Dim strStatus As String = ""
                Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_IMPORT_BGP_DATA")
                    objDB.AddInParameter(objcmd, "@IV_ARTICLE_NUM", DbType.String, objbgpBO.ArticleNumber)
                    objDB.AddInParameter(objcmd, "@IV_ARTICLE_DESC", DbType.String, objbgpBO.ArticleDescription)

                    If objbgpBO.Quantity.Contains(".") Then
                        objDB.AddInParameter(objcmd, "@IV_QUANTITY", DbType.Decimal, Convert.ToDecimal(objbgpBO.Quantity.Replace(".", ",")))
                    Else
                        objDB.AddInParameter(objcmd, "@IV_QUANTITY", DbType.Decimal, Convert.ToDecimal(objbgpBO.Quantity))
                    End If

                    If objbgpBO.UnitPrice.Contains(".") Then
                        objDB.AddInParameter(objcmd, "@IV_UNIT_PRICE", DbType.Decimal, Convert.ToDecimal(objbgpBO.UnitPrice.Replace(".", ",")))
                    Else
                        objDB.AddInParameter(objcmd, "@IV_UNIT_PRICE", DbType.Decimal, Convert.ToDecimal(objbgpBO.UnitPrice))
                    End If

                    If objbgpBO.CostPrice.Contains(".") Then
                        objDB.AddInParameter(objcmd, "@IV_COST_PRICE", DbType.Decimal, Convert.ToDecimal(objbgpBO.CostPrice.Replace(".", ",")))
                    Else
                        objDB.AddInParameter(objcmd, "@IV_COST_PRICE", DbType.Decimal, Convert.ToDecimal(objbgpBO.CostPrice))
                    End If

                    If objbgpBO.Discount.Contains(".") Then
                        objDB.AddInParameter(objcmd, "@IV_DISCOUNT", DbType.Decimal, Convert.ToDecimal(objbgpBO.Discount.Replace(".", ",")))
                    Else
                        objDB.AddInParameter(objcmd, "@IV_DISCOUNT", DbType.Decimal, Convert.ToDecimal(objbgpBO.Discount))
                    End If

                    objDB.AddInParameter(objcmd, "@IV_ID_WO_PREFIX", DbType.String, objbgpBO.IdWOPre)
                    objDB.AddInParameter(objcmd, "@IV_ID_WO_NO", DbType.String, objbgpBO.IdWONo)
                    objDB.AddInParameter(objcmd, "@IV_CREATEDBY", DbType.String, objbgpBO.IdLogin)

                    objDB.AddOutParameter(objcmd, "@IV_RESULT", DbType.String, 50)
                    Try
                        objDB.ExecuteNonQuery(objcmd)
                        strStatus = objDB.GetParameterValue(objcmd, "@IV_RESULT").ToString
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

