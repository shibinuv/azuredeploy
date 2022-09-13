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
Imports Microsoft.VisualBasic
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Imports Newtonsoft.Json
Imports System.Net
Imports System.Text
Imports Newtonsoft.Json.Linq
Imports System.Globalization

Namespace CARS.Services.Vehicle
    Public Class VehicleDetails
        Shared objCommonUtil As New CARS.Utilities.CommonUtility
        Shared objVehicleDO As New VehicleDO
        Shared objVehicleBO As New VehicleBO
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
        Dim objDB As Database
        Dim ConnectionString As String
        Shared objWOHDO As New CARS.WOHeader.WOHeaderDO


        Shared user1 As String = "dag@cars.no"
        Shared pass As String = "cars2020"
        Shared tokenType As String = "Bearer"
        Shared token As String = ""
        Shared expires As String = ""
        Shared message As String = ""
        Shared errors As String = ""
        Shared vehicleurl As String = "https://api.rodboka.no/api/"

        Public Sub New()
            ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
            objDB = New SqlDatabase(ConnectionString)
        End Sub

        Public Function GetMVRData(ByVal regNo As String) As List(Of VehicleBO)
            Dim objMVRDetails As New List(Of VehicleBO)()
            Dim MvrDet As New VehicleBO()
            Dim myService1 As New no.pkk.app.emsService
            Dim dsReturnVal As no.pkk.app.bildataWS = myService1.vkData("IdCars1250", "IdCars1250", 47, True, 0, True, regNo.ToString())

            If dsReturnVal.status = 0 Then
                If dsReturnVal.akseltrykkBak IsNot Nothing Then
                    MvrDet.AxlePrBack = dsReturnVal.akseltrykkBak.ToString()
                Else
                    dsReturnVal.akseltrykkBak = ""
                    MvrDet.AxlePrBack = dsReturnVal.akseltrykkBak
                End If
                MvrDet.VehRegNo = dsReturnVal.kjennemerke.ToString()
                MvrDet.VehVin = dsReturnVal.understellsnummer.ToString()
                If (IsDBNull(dsReturnVal.regFoerstegNorge)) Then
                    MvrDet.RegDateNorway = ""
                Else
                    MvrDet.RegDateNorway = objCommonUtil.GetCurrentLanguageDate(dsReturnVal.regFoerstegNorge)
                End If
                MvrDet.MakeCode = dsReturnVal.merkekode.ToString()
                MvrDet.Make = dsReturnVal.merkeNavn.ToString()
                MvrDet.Model = dsReturnVal.modellbetegnelse.ToString()
                MvrDet.VehType = dsReturnVal.typebetegnelse.ToString()
                MvrDet.ApprovalNo = dsReturnVal.typegodkjenningsnr.ToString()
                MvrDet.VehGrp = dsReturnVal.kjoretoygruppe.ToString()
                If dsReturnVal.farge IsNot Nothing Then
                    If dsReturnVal.farge = "" Then
                        MvrDet.Color = ""
                    Else
                        MvrDet.Color = dsReturnVal.farge.ToString()
                    End If
                Else
                    dsReturnVal.farge = ""
                    MvrDet.Color = dsReturnVal.farge
                End If
                MvrDet.FuelType = dsReturnVal.drivstoff.ToString()
                If dsReturnVal.motorytelse IsNot Nothing Then
                    If dsReturnVal.motorytelse = "" Then
                        MvrDet.EngineEff = 0
                    Else
                        MvrDet.EngineEff = dsReturnVal.motorytelse.ToString()
                    End If
                Else
                    dsReturnVal.motorytelse = 0
                    MvrDet.EngineEff = dsReturnVal.motorytelse
                End If
                If dsReturnVal.slagvolum IsNot Nothing Then
                    MvrDet.PisDisplacement = dsReturnVal.slagvolum
                Else
                    dsReturnVal.slagvolum = ""
                    MvrDet.PisDisplacement = dsReturnVal.slagvolum
                End If

                If dsReturnVal.bredde IsNot Nothing Then
                    MvrDet.Width = dsReturnVal.bredde.ToString()
                Else
                    dsReturnVal.bredde = 0
                    MvrDet.Width = dsReturnVal.bredde
                End If
                If dsReturnVal.lengde IsNot Nothing Then
                    MvrDet.Length = dsReturnVal.lengde.ToString()
                Else
                    dsReturnVal.lengde = 0
                    MvrDet.Length = dsReturnVal.lengde
                End If
                If dsReturnVal.stdDekkForan IsNot Nothing Then
                    MvrDet.StdTyreFront = dsReturnVal.stdDekkForan.ToString()
                Else
                    dsReturnVal.stdDekkForan = ""
                    MvrDet.StdTyreFront = dsReturnVal.stdDekkForan
                End If
                If dsReturnVal.minLIforan IsNot Nothing Then
                    MvrDet.MinLi_Front = dsReturnVal.minLIforan.ToString()
                Else
                    dsReturnVal.minHastForan = ""
                    MvrDet.MinLi_Front = dsReturnVal.minLIforan
                End If
                If dsReturnVal.minHastForan IsNot Nothing Then
                    MvrDet.Min_Front = dsReturnVal.minHastForan.ToString()
                Else
                    dsReturnVal.minHastForan = ""
                    MvrDet.Min_Front = dsReturnVal.minHastForan
                End If
                If dsReturnVal.stdFelgForan IsNot Nothing Then
                    MvrDet.Std_Rim_Front = dsReturnVal.stdFelgForan.ToString()
                Else
                    dsReturnVal.stdFelgForan = ""
                    MvrDet.Std_Rim_Front = dsReturnVal.stdFelgForan
                End If

                If dsReturnVal.minInnpressForan IsNot Nothing Then
                    MvrDet.Min_Inpress_Front = dsReturnVal.minInnpressForan.ToString()
                Else
                    dsReturnVal.minInnpressForan = ""
                    MvrDet.Min_Inpress_Front = dsReturnVal.minInnpressForan
                End If
                If dsReturnVal.maksSporvForan IsNot Nothing Then
                    MvrDet.Max_Tyre_Width_Frnt = dsReturnVal.maksSporvForan.ToString()
                Else
                    dsReturnVal.maksSporvForan = ""
                    MvrDet.Max_Tyre_Width_Frnt = dsReturnVal.maksSporvForan
                End If
                If dsReturnVal.stdDekkBak IsNot Nothing Then
                    MvrDet.StdTyreBack = dsReturnVal.stdDekkBak.ToString()
                Else
                    dsReturnVal.stdDekkBak = ""
                    MvrDet.StdTyreBack = dsReturnVal.stdDekkBak
                End If
                If dsReturnVal.minLIbak IsNot Nothing Then
                    MvrDet.MinLi_Back = dsReturnVal.minLIforan.ToString()
                Else
                    dsReturnVal.minLIbak = ""
                    MvrDet.MinLi_Back = dsReturnVal.minLIbak
                End If
                If dsReturnVal.minHastBak IsNot Nothing Then
                    MvrDet.Min_Back = dsReturnVal.minHastBak.ToString()
                Else
                    dsReturnVal.minHastBak = ""
                    MvrDet.Min_Back = dsReturnVal.minHastBak
                End If
                If dsReturnVal.stdFelgBak IsNot Nothing Then
                    MvrDet.Std_Rim_Back = dsReturnVal.stdFelgBak.ToString()
                Else
                    dsReturnVal.minHastBak = ""
                    MvrDet.Std_Rim_Back = dsReturnVal.stdFelgBak
                End If
                If dsReturnVal.minInnpressBak IsNot Nothing Then
                    MvrDet.Min_Inpress_Back = dsReturnVal.minInnpressBak.ToString()
                Else
                    dsReturnVal.minInnpressBak = ""
                    MvrDet.Min_Inpress_Back = dsReturnVal.minInnpressBak
                End If
                If dsReturnVal.maksSporvBak IsNot Nothing Then
                    MvrDet.Max_Tyre_Width_Bk = dsReturnVal.maksSporvBak.ToString()
                Else
                    dsReturnVal.maksSporvBak = ""
                    MvrDet.Max_Tyre_Width_Bk = dsReturnVal.maksSporvBak
                End If
                MvrDet.TotalWeight = dsReturnVal.totalvekt.ToString()
                If dsReturnVal.egenvekt IsNot Nothing Then
                    MvrDet.NetWeight = dsReturnVal.egenvekt.ToString()
                Else
                    dsReturnVal.egenvekt = ""
                    MvrDet.NetWeight = dsReturnVal.egenvekt
                End If
                If dsReturnVal.akseltrykkForan IsNot Nothing Then
                    MvrDet.AxlePrFront = dsReturnVal.akseltrykkForan.ToString()
                Else
                    dsReturnVal.akseltrykkForan = ""
                    MvrDet.AxlePrFront = dsReturnVal.akseltrykkForan
                End If
                If dsReturnVal.akseltrykkBak IsNot Nothing Then
                    MvrDet.AxlePrBack = dsReturnVal.akseltrykkBak.ToString()
                Else
                    dsReturnVal.akseltrykkBak = ""
                    MvrDet.AxlePrBack = dsReturnVal.akseltrykkBak
                End If
                If dsReturnVal.maxBelTilhFeste IsNot Nothing Then
                    MvrDet.Max_Wt_TBar = dsReturnVal.maxBelTilhFeste.ToString()
                Else
                    dsReturnVal.maxBelTilhFeste = ""
                    MvrDet.Max_Wt_TBar = dsReturnVal.maxBelTilhFeste
                End If
                If dsReturnVal.lngdTilhKobl IsNot Nothing Then
                    MvrDet.Len_TBar = dsReturnVal.lngdTilhKobl.ToString()
                Else
                    dsReturnVal.lngdTilhKobl = ""
                    MvrDet.Len_TBar = dsReturnVal.lngdTilhKobl
                End If
                If dsReturnVal.maxTaklast IsNot Nothing Then
                    MvrDet.Max_Rf_Load = dsReturnVal.maxTaklast.ToString()
                Else
                    dsReturnVal.maxTaklast = ""
                    MvrDet.Max_Rf_Load = dsReturnVal.lngdTilhKobl
                End If
                If dsReturnVal.motormerking IsNot Nothing Then
                    MvrDet.EngineNum = dsReturnVal.motormerking.ToString()
                Else
                    dsReturnVal.motormerking = ""
                    MvrDet.EngineNum = dsReturnVal.motormerking
                End If
                If (IsDBNull(dsReturnVal.nestePKK)) Then
                    MvrDet.NxtPKK_Date = ""
                Else
                    MvrDet.NxtPKK_Date = objCommonUtil.GetCurrentLanguageDate(dsReturnVal.nestePKK)
                End If
                MvrDet.ModelYear = dsReturnVal.regAAr.ToString()

                If dsReturnVal.regFgang IsNot Nothing Then
                    MvrDet.RegYear = dsReturnVal.regFgang.ToString()
                Else
                    dsReturnVal.regFgang = ""
                    MvrDet.RegYear = dsReturnVal.regFgang
                End If
                If (IsDBNull(dsReturnVal.sisteRegDato)) Then
                    MvrDet.LastRegDate = ""
                Else
                    MvrDet.LastRegDate = objCommonUtil.GetCurrentLanguageDate(dsReturnVal.sisteRegDato)
                End If
                If (IsDBNull(dsReturnVal.sistPKKgodkj)) Then
                    MvrDet.LastPKK_AppDate = ""
                Else
                    MvrDet.LastPKK_AppDate = objCommonUtil.GetCurrentLanguageDate(dsReturnVal.sistPKKgodkj)
                End If
                If (IsDBNull(dsReturnVal.avregDato)) Then
                    MvrDet.DeRegDate = ""
                Else
                    MvrDet.DeRegDate = objCommonUtil.GetCurrentLanguageDate(dsReturnVal.avregDato)
                End If
                If dsReturnVal.sitteplasser IsNot Nothing Then
                    MvrDet.Veh_Seat = dsReturnVal.sitteplasser.ToString()
                Else
                    dsReturnVal.sitteplasser = ""
                    MvrDet.Veh_Seat = dsReturnVal.sitteplasser
                End If
                If dsReturnVal.vognkortAnm IsNot Nothing Then
                    MvrDet.Cert_Text = dsReturnVal.vognkortAnm.ToString()
                Else
                    dsReturnVal.vognkortAnm = ""
                    MvrDet.Cert_Text = dsReturnVal.vognkortAnm
                End If
                If dsReturnVal.co2Utslipp IsNot Nothing Then
                    MvrDet.CO2_Emission = dsReturnVal.co2Utslipp.ToString()
                Else
                    dsReturnVal.co2Utslipp = ""
                    MvrDet.CO2_Emission = dsReturnVal.co2Utslipp
                End If
                If dsReturnVal.EUvariant IsNot Nothing Then
                    MvrDet.EU_Variant = dsReturnVal.EUvariant.ToString()
                Else
                    dsReturnVal.EUvariant = ""
                    MvrDet.EU_Variant = dsReturnVal.EUvariant
                End If
                If dsReturnVal.EUversjon IsNot Nothing Then
                    MvrDet.EU_Version = dsReturnVal.EUversjon.ToString()
                Else
                    dsReturnVal.EUversjon = ""
                    MvrDet.EU_Version = dsReturnVal.EUversjon
                End If
                If dsReturnVal.girkasse IsNot Nothing Then
                    MvrDet.GearBox_Desc = dsReturnVal.girkasse.ToString()
                Else
                    dsReturnVal.girkasse = ""
                    MvrDet.GearBox_Desc = dsReturnVal.girkasse
                End If
                MvrDet.Chassi_Desc = dsReturnVal.rammeKarosseri.ToString()
                If dsReturnVal.tilhVktMbrems IsNot Nothing Then
                    MvrDet.TrailerWth_Brks = dsReturnVal.tilhVktMbrems.ToString()
                Else
                    dsReturnVal.tilhVktMbrems = ""
                    MvrDet.TrailerWth_Brks = dsReturnVal.tilhVktMbrems
                End If
                If dsReturnVal.tilhVktUbrems IsNot Nothing Then
                    MvrDet.TrailerWthout_Brks = dsReturnVal.tilhVktUbrems.ToString()
                Else
                    dsReturnVal.tilhVktUbrems = ""
                    MvrDet.TrailerWthout_Brks = dsReturnVal.tilhVktUbrems
                End If
                MvrDet.Axles_Number = dsReturnVal.antAksler.ToString()
                If dsReturnVal.antAkslerDrift IsNot Nothing Then
                    MvrDet.Axles_Number_Traction = dsReturnVal.antAkslerDrift.ToString()
                Else
                    dsReturnVal.antAkslerDrift = ""
                    MvrDet.Axles_Number_Traction = dsReturnVal.antAkslerDrift
                End If
                If dsReturnVal.standStoy IsNot Nothing Then
                    MvrDet.Noise_On_Veh = dsReturnVal.standStoy.ToString()
                Else
                    dsReturnVal.standStoy = ""
                    MvrDet.Noise_On_Veh = dsReturnVal.standStoy
                End If
                If dsReturnVal.omdreininger IsNot Nothing Then
                    MvrDet.Rounds = dsReturnVal.omdreininger.ToString()
                Else
                    dsReturnVal.omdreininger = ""
                    MvrDet.Rounds = dsReturnVal.omdreininger
                End If
                If dsReturnVal.euHovednummer IsNot Nothing Then
                    MvrDet.EU_Main_Num = dsReturnVal.euHovednummer.ToString()
                Else
                    dsReturnVal.euHovednummer = ""
                    MvrDet.EU_Main_Num = dsReturnVal.euHovednummer
                End If
                MvrDet.EU_Norm = dsReturnVal.euronorm.ToString()
                MvrDet.Identity_Annot = dsReturnVal.identitetAnm.ToString()
                MvrDet.Wheels_Traction = dsReturnVal.drivendeHjul.ToString()
                MvrDet.Make_Part_Filter = dsReturnVal.fabPartFilter.ToString()
                objMVRDetails.Add(MvrDet)
            End If
            MvrDet.Status = dsReturnVal.status.ToString()
            Return objMVRDetails
        End Function
        'Public Function GetVehicle(ByVal vehicleRegNo As String) As List(Of VehicleBO)
        '    Dim dsVehicle As New DataSet
        '    Dim dtVehicle As DataTable
        '    Dim retVehicle As New List(Of VehicleBO)()
        '    Try
        '        dsVehicle = objVehicleDO.Get_Vehicle(vehicleRegNo)

        '        If dsVehicle.Tables.Count > 0 Then
        '            If dsVehicle.Tables(0).Rows.Count > 0 Then
        '                dtVehicle = dsVehicle.Tables(0)
        '            End If
        '        End If
        '        If vehicleRegNo <> String.Empty Then
        '            For Each dtrow As DataRow In dtVehicle.Rows
        '                'retVehicle.Id_Veh_Seq = dtrow("ID_VEH_SEQ").ToString()
        '                'retVehicle.VehRegNo = dtrow("VEH_REG_NO").ToString()
        '            Next
        '        End If
        '    Catch ex As Exception
        '        Throw ex
        '    End Try
        '    Return retVehicle
        'End Function
        Public Function Add_Vehicle(ByVal objVehicleBO As VehicleBO) As String()
            Dim strResult As String = ""
            Dim strVehSeq As String
            Dim strRefNo As String = ""
            Dim strArray As Array
            Try
                strResult = objVehicleDO.Add_Vehicle(objVehicleBO)
                strArray = strResult.Split(",")
                strResult = strArray(0)
                strVehSeq = strArray(1)
                strRefNo = strArray(2)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "Add_Vehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strArray
        End Function

        Public Function VehicleSearch(ByVal q As String) As List(Of VehicleBO)
            Dim dsVehicle As New DataSet
            Dim dtVehicle As DataTable
            Dim vehicleSearchResult As New List(Of VehicleBO)()
            Try
                dsVehicle = objVehicleDO.Vehicle_Search(q)

                If dsVehicle.Tables.Count > 0 Then
                    dtVehicle = dsVehicle.Tables(0)
                End If
                If q <> String.Empty Then
                    For Each dtrow As DataRow In dtVehicle.Rows
                        Dim vsr As New VehicleBO()
                        vsr.Id_Veh_Seq = dtrow("ID_VEH_SEQ").ToString
                        vsr.VehRegNo = dtrow("VEH_REG_NO").ToString
                        vsr.IntNo = dtrow("VEH_INTERN_NO").ToString
                        vsr.VehVin = dtrow("VEH_VIN").ToString
                        vsr.Make = dtrow("ID_MAKE_VEH").ToString
                        vsr.Model = dtrow("ID_MODEL_VEH").ToString
                        vsr.VehType = dtrow("VEH_TYPE").ToString
                        vsr.Customer = dtrow("ID_CUSTOMER_VEH").ToString
                        vsr.ModelType = dtrow("VEH_MODEL_TYPE").ToString
                        vsr.CustomerName = dtrow("CUST_NAME").ToString
                        If (dtrow("DT_VEH_ERGN").ToString() = "") Then
                            vsr.RegDate = ""
                        Else
                            vsr.RegDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_ERGN").ToString())
                        End If
                        vsr.RegYear = IIf(IsDBNull(dtrow("VEH_REGYEAR")), 0, dtrow("VEH_REGYEAR").ToString())
                        vsr.Mileage = dtrow("VEH_MILEAGE").ToString
                        vsr.VehType = dtrow("VEH_TYPE").ToString()
                        vsr.New_Used = dtrow("VEH_NEW_USED").ToString()
                        vehicleSearchResult.Add(vsr)
                    Next
                End If
            Catch ex As Exception
                Throw ex
            End Try
            Return vehicleSearchResult
        End Function

        Public Function FetchVehicleDetails(ByVal vehicleRefNo As String, ByVal vehicleRegNo As String, ByVal vehicleSeqId As String) As List(Of VehicleBO)
            Dim dsVehicle As New DataSet
            Dim dtVehicle As DataTable
            Dim retVehicle As New List(Of VehicleBO)()
            Try
                dsVehicle = objVehicleDO.Fetch_Vehicle_Details(vehicleRefNo, vehicleRegNo, vehicleSeqId)

                If dsVehicle.Tables.Count > 0 Then
                    dtVehicle = dsVehicle.Tables(0)
                End If
                If vehicleRegNo <> String.Empty Or vehicleSeqId <> String.Empty Or vehicleRefNo <> String.Empty Then
                    For Each dtrow As DataRow In dtVehicle.Rows
                        Dim vehDet As New VehicleBO()
                        vehDet.Id_Veh_Seq = dtrow("ID_VEH_SEQ").ToString()
                        vehDet.VehRegNo = dtrow("VEH_REG_NO").ToString()
                        vehDet.IntNo = dtrow("VEH_INTERN_NO").ToString()
                        vehDet.VehVin = dtrow("VEH_VIN").ToString()
                        vehDet.Make = dtrow("ID_MAKE_VEH").ToString()
                        vehDet.Model = dtrow("ID_MODEL_VEH").ToString()

                        If (dtrow("ID_VAT_CD").ToString() = "") Then
                            vehDet.vatCode = "100"
                        Else
                            vehDet.vatCode = dtrow("ID_VAT_CD").ToString()
                        End If

                        vehDet.VehType = dtrow("VEH_TYPE").ToString()
                        If (dtrow("DT_VEH_ERGN").ToString() = "") Then
                            vehDet.RegDate = ""
                        Else
                            vehDet.RegDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_ERGN").ToString())
                        End If

                        vehDet.Mileage = IIf(IsDBNull(dtrow("VEH_MILEAGE")), 0, dtrow("VEH_MILEAGE").ToString())


                        If (dtrow("DT_VEH_MIL_REGN").ToString() = "") Then
                            vehDet.MileageRegDate = ""
                        Else
                            vehDet.MileageRegDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_MIL_REGN").ToString())
                        End If
                        vehDet.VehicleHrs = IIf(IsDBNull(dtrow("VEH_HRS")), 0, dtrow("VEH_HRS").ToString())
                        If (dtrow("DT_VEH_HRS_ERGN").ToString() = "") Then
                            vehDet.VehicleHrsDate = ""
                        Else
                            vehDet.VehicleHrsDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_HRS_ERGN").ToString())
                        End If
                        vehDet.ModelYear = IIf(IsDBNull(dtrow("VEH_MDL_YEAR")), 0, dtrow("VEH_MDL_YEAR").ToString())
                        vehDet.Id_Group_Veh = dtrow("ID_GROUP_VEH").ToString()
                        vehDet.Customer = dtrow("ID_CUSTOMER_VEH").ToString()
                        vehDet.Annotation = dtrow("VEH_ANNOT").ToString()
                        vehDet.RefNo = dtrow("VEH_REFNO").ToString()
                        vehDet.New_Used = dtrow("VEH_NEW_USED").ToString()
                        vehDet.VehStatus = dtrow("VEH_STATUS").ToString()
                        vehDet.ModelType = dtrow("VEH_MODEL_TYPE").ToString()
                        vehDet.RegYear = IIf(IsDBNull(dtrow("VEH_REGYEAR")), 0, dtrow("VEH_REGYEAR").ToString())
                        If (dtrow("VEH_REG_DATE_NO").ToString() = "") Then
                            vehDet.RegDateNorway = ""
                        Else
                            vehDet.RegDateNorway = objCommonUtil.GetCurrentLanguageDate(dtrow("VEH_REG_DATE_NO").ToString())
                        End If
                        If (dtrow("VEH_LAST_REGDATE").ToString() = "") Then
                            vehDet.LastRegDate = ""
                        Else
                            vehDet.LastRegDate = objCommonUtil.GetCurrentLanguageDate(dtrow("VEH_LAST_REGDATE").ToString())
                        End If
                        If (dtrow("VEH_DEREG_DATE").ToString() = "") Then
                            vehDet.DeRegDate = ""
                        Else
                            vehDet.DeRegDate = objCommonUtil.GetCurrentLanguageDate(dtrow("VEH_DEREG_DATE").ToString())
                        End If
                        vehDet.Category = dtrow("VEH_CATEGORY").ToString()

                        vehDet.Machine_W_Hrs = IIf(IsDBNull(dtrow("VEH_MACHINE_W_HOURS")), False, dtrow("VEH_MACHINE_W_HOURS").ToString())

                        vehDet.Color = dtrow("VEH_COLOR").ToString()
                        vehDet.Warranty_Code = dtrow("VEH_WARRANTY_CODE").ToString()
                        vehDet.NetWeight = dtrow("VEH_NET_WEIGHT").ToString()
                        vehDet.TotalWeight = dtrow("VEH_TOT_WEIGHT").ToString()
                        vehDet.Project_No = dtrow("VEH_PROJECT_NO").ToString()
                        If (dtrow("VEH_LAST_CONTACT_DATE").ToString() = "") Then
                            vehDet.Last_Contact_Date = ""
                        Else
                            vehDet.Last_Contact_Date = objCommonUtil.GetCurrentLanguageDate(dtrow("VEH_LAST_CONTACT_DATE").ToString())
                        End If
                        vehDet.Practical_Load = dtrow("VEH_PRACTICAL_LOAD").ToString()
                        vehDet.Max_Rf_Load = dtrow("VEH_MAX_ROOF_LOAD").ToString()
                        vehDet.Earlier_Regno_1 = dtrow("VEH_EARLIER_REGNO_1").ToString()
                        vehDet.Earlier_Regno_2 = dtrow("VEH_EARLIER_REGNO_2").ToString()
                        vehDet.Earlier_Regno_3 = dtrow("VEH_EARLIER_REGNO_3").ToString()
                        vehDet.Earlier_Regno_4 = dtrow("VEH_EARLIER_REGNO_4").ToString()
                        vehDet.VehGrp = dtrow("ID_GROUP_VEH").ToString()
                        vehDet.Note = dtrow("VEH_NOTE").ToString()
                        vehDet.PickNo = dtrow("PICK").ToString()

                        vehDet.MakeCodeNo = dtrow("VEH_MAKE_CODE").ToString()
                        vehDet.RicambiNo = dtrow("VEH_RICAMBI_NO").ToString()
                        vehDet.EngineNum = dtrow("VEH_ENGINE_NO").ToString()
                        vehDet.FuelCode = dtrow("VEH_FUEL_CODE").ToString()
                        vehDet.FuelCard = dtrow("VEH_FUEL_CARD").ToString()
                        vehDet.GearBox_Desc = dtrow("VEH_GEAR_BOX").ToString()

                        vehDet.WareHouse = dtrow("VEH_WAREHOUSE").ToString()
                        vehDet.KeyNo = dtrow("VEH_KEYNO").ToString()
                        vehDet.DoorKeyNo = dtrow("VEH_DOOR_KEYNO").ToString()
                        vehDet.ControlForm = dtrow("VEH_CONTROL_FORM").ToString()
                        vehDet.InteriorCode = dtrow("VEH_INTEROR_CODE").ToString()
                        vehDet.PurchaseNo = dtrow("VEH_PURCHASE_NO").ToString()
                        vehDet.AddonGroup = dtrow("VEH_ADDON_GROUP").ToString()
                        If (dtrow("DT_VEH_EXPECTED_IN").ToString() = "") Then
                            vehDet.Date_Expected_In = ""
                        Else
                            vehDet.Date_Expected_In = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_EXPECTED_IN").ToString())
                        End If
                        vehDet.Tires = dtrow("VEH_TIRES").ToString()
                        vehDet.Service_Category = dtrow("VEH_SERVICE_CATEGORY").ToString()
                        vehDet.No_Approval_No = dtrow("VEH_NO_APPROVAL_NO").ToString()
                        vehDet.Eu_Approval_No = dtrow("VEH_EU_APPROVAL_NO").ToString()
                        vehDet.ProductNo = dtrow("VEH_PRODUCT_NO").ToString()
                        vehDet.ElCode = dtrow("VEH_EL_CODE").ToString()
                        If (dtrow("DT_VEH_TAKEN_IN").ToString() = "") Then
                            vehDet.Taken_In_Date = ""
                        Else
                            vehDet.Taken_In_Date = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_TAKEN_IN").ToString())
                        End If
                        vehDet.Taken_In_Mileage = IIf(IsDBNull(dtrow("VEH_TAKEN_IN_MILEAGE")), 0, dtrow("VEH_TAKEN_IN_MILEAGE").ToString())
                        If (dtrow("DT_VEH_DELIVERY").ToString() = "") Then
                            vehDet.Delivery_Date = ""
                        Else
                            vehDet.Delivery_Date = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_DELIVERY").ToString())
                        End If
                        vehDet.Delivery_Mileage = IIf(IsDBNull(dtrow("VEH_DELIVERY_MILEAGE")), 0, dtrow("VEH_DELIVERY_MILEAGE").ToString())
                        If (dtrow("DT_VEH_SERVICE").ToString() = "") Then
                            vehDet.Service_Date = ""
                        Else
                            vehDet.Service_Date = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_SERVICE").ToString())
                        End If
                        vehDet.Service_Mileage = IIf(IsDBNull(dtrow("VEH_SERVICE_MILEAGE")), 0, dtrow("VEH_SERVICE_MILEAGE").ToString())
                        If (dtrow("DT_VEH_CALL_IN").ToString() = "") Then
                            vehDet.Call_In_Date = ""
                        Else
                            vehDet.Call_In_Date = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_CALL_IN").ToString())
                        End If
                        vehDet.Call_In_Mileage = IIf(IsDBNull(dtrow("VEH_CALL_IN_MILEAGE")), 0, dtrow("VEH_CALL_IN_MILEAGE").ToString())
                        If (dtrow("DT_VEH_CLEANED").ToString() = "") Then
                            vehDet.Cleaned_Date = ""
                        Else
                            vehDet.Cleaned_Date = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_CLEANED").ToString())
                        End If
                        vehDet.TechDocNo = dtrow("VEH_TECHDOC_NO").ToString()
                        vehDet.Length = IIf(IsDBNull(dtrow("VEH_LENGTH")), 0, dtrow("VEH_LENGTH").ToString())
                        vehDet.Width = IIf(IsDBNull(dtrow("VEH_WIDTH")), 0, dtrow("VEH_WIDTH").ToString())
                        vehDet.Noise_On_Veh = IIf(IsDBNull(dtrow("VEH_NOISE")), 0, dtrow("VEH_NOISE").ToString())
                        vehDet.EngineEff = IIf(IsDBNull(dtrow("VEH_EFFECT_KW")), 0, dtrow("VEH_EFFECT_KW").ToString())
                        vehDet.PisDisplacement = dtrow("VEH_PISTON_DISPLACEMENT").ToString()
                        vehDet.Rounds = dtrow("VEH_ROUNDS_PER_MIN").ToString()
                        vehDet.Used_Imported = IIf(IsDBNull(dtrow("VEH_USED_IMPORTED")), False, dtrow("VEH_USED_IMPORTED").ToString())
                        vehDet.Pressure_Mech_Brakes = IIf(IsDBNull(dtrow("VEH_PRESSURE_MECH_BRAKES")), False, dtrow("VEH_PRESSURE_MECH_BRAKES").ToString())
                        vehDet.Towbar = IIf(IsDBNull(dtrow("VEH_TOWBAR")), False, dtrow("VEH_TOWBAR").ToString())
                        vehDet.Service_Book = IIf(IsDBNull(dtrow("VEH_SERVICE_BOOK")), False, dtrow("VEH_SERVICE_BOOK").ToString())
                        If (dtrow("DT_LAST_PKK_APPROVED").ToString() = "") Then
                            vehDet.LastPKK_AppDate = ""
                        Else
                            vehDet.LastPKK_AppDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_LAST_PKK_APPROVED").ToString())
                        End If
                        If (dtrow("DT_NEXT_PKK").ToString() = "") Then
                            vehDet.NxtPKK_Date = ""
                        Else
                            vehDet.NxtPKK_Date = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_NEXT_PKK").ToString())
                        End If
                        If (dtrow("DT_LAST_PKK_INVOICED").ToString() = "") Then
                            vehDet.Last_PKK_Invoiced = ""
                        Else
                            vehDet.Last_PKK_Invoiced = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_LAST_PKK_INVOICED").ToString())
                        End If
                        vehDet.Call_In_Service = IIf(IsDBNull(dtrow("VEH_CALL_IN_SERVICE")), False, dtrow("VEH_CALL_IN_SERVICE").ToString())
                        vehDet.Call_In_Month_Service = IIf(IsDBNull(dtrow("VEH_CALL_IN_MONTH")), 0, dtrow("VEH_CALL_IN_MONTH").ToString())
                        vehDet.Call_In_Mileage_Service = IIf(IsDBNull(dtrow("VEH_CALL_IN_SERVICE_MILEAGE")), 0, dtrow("VEH_CALL_IN_SERVICE_MILEAGE").ToString())
                        vehDet.Do_Not_Call_PKK = IIf(IsDBNull(dtrow("VEH_DO_NOT_CALL_PKK")), False, dtrow("VEH_DO_NOT_CALL_PKK").ToString())
                        vehDet.Deviations_PKK = dtrow("VEH_DEVIATIONS_PKK").ToString()
                        vehDet.Yearly_Mileage = IIf(IsDBNull(dtrow("VEH_YEARLY_MILAGE")), 0, dtrow("VEH_YEARLY_MILAGE").ToString())
                        vehDet.Radio_Code = dtrow("VEH_RADIO_CODE").ToString()
                        vehDet.Start_Immobilizer = dtrow("VEH_START_IMMOBILIZER").ToString()
                        vehDet.Qty_Keys = IIf(IsDBNull(dtrow("VEH_QTY_KEYS")), 0, dtrow("VEH_QTY_KEYS").ToString())
                        vehDet.KeyTagNo = dtrow("VEH_KEYTAG_NO").ToString()
                        'fetching tabEconomy
                        vehDet.SalesPriceNet = IIf(IsDBNull(dtrow("VEH_SALESPRICE_NET")), 0, dtrow("VEH_SALESPRICE_NET").ToString())
                        vehDet.SalesSale = IIf(IsDBNull(dtrow("VEH_SALARY")), 0, dtrow("VEH_SALARY").ToString())
                        vehDet.SalesEquipment = IIf(IsDBNull(dtrow("VEH_SALES_EQUIPMENT")), 0D, dtrow("VEH_SALES_EQUIPMENT").ToString())
                        vehDet.RegCosts = IIf(IsDBNull(dtrow("VEH_REG_COSTS")), 0, dtrow("VEH_REG_COSTS").ToString())
                        vehDet.Discount = IIf(IsDBNull(dtrow("VEH_DISCOUNT")), 0, dtrow("VEH_DISCOUNT").ToString())
                        vehDet.NetSalesPrice = IIf(IsDBNull(dtrow("VEH_NET_SALESPRICE")), 0, dtrow("VEH_NET_SALESPRICE").ToString())
                        vehDet.FixCost = IIf(IsDBNull(dtrow("VEH_FIX_COST")), 0, dtrow("VEH_FIX_COST").ToString())
                        vehDet.AssistSales = IIf(IsDBNull(dtrow("VEH_ASSIST_SALE")), 0, dtrow("VEH_ASSIST_SALE").ToString())
                        vehDet.CostAfterSales = IIf(IsDBNull(dtrow("VEH_COST_AFTER_SALE")), 0, dtrow("VEH_COST_AFTER_SALE").ToString())
                        vehDet.ContributionsToday = IIf(IsDBNull(dtrow("VEH_CONTRIBUTION_TODAY")), 0, dtrow("VEH_CONTRIBUTION_TODAY").ToString())
                        vehDet.SalesPriceGross = IIf(IsDBNull(dtrow("VEH_SALESPRICE_GROSS")), 0, dtrow("VEH_SALESPRICE_GROSS").ToString())
                        vehDet.RegFee = IIf(IsDBNull(dtrow("VEH_REG_FEE")), 0, dtrow("VEH_REG_FEE").ToString())
                        vehDet.Vat = IIf(IsDBNull(dtrow("VEH_VAT")), 0, dtrow("VEH_VAT").ToString())
                        vehDet.TotAmount = IIf(IsDBNull(dtrow("VEH_TOTAL_AMOUNT")), 0, dtrow("VEH_TOTAL_AMOUNT").ToString())
                        vehDet.WreckingAmount = IIf(IsDBNull(dtrow("VEH_WRECKING_AMOUNT")), 0, dtrow("VEH_WRECKING_AMOUNT").ToString())
                        vehDet.YearlyFee = IIf(IsDBNull(dtrow("VEH_YEARLY_FEE")), 0, dtrow("VEH_YEARLY_FEE").ToString())
                        vehDet.Insurance = IIf(IsDBNull(dtrow("VEH_INSURANCE")), 0, dtrow("VEH_INSURANCE").ToString())
                        vehDet.CostPriceNet = IIf(IsDBNull(dtrow("VEH_COSTPRICE_NET")), 0, dtrow("VEH_COSTPRICE_NET").ToString())
                        vehDet.InsuranceBonus = IIf(IsDBNull(dtrow("VEH_INSURANCE_BONUS")), 0, dtrow("VEH_INSURANCE_BONUS").ToString())
                        vehDet.CostSales = IIf(IsDBNull(dtrow("VEH_COST_SALE")), 0, dtrow("VEH_COST_SALE").ToString())
                        vehDet.CostBeforeSale = IIf(IsDBNull(dtrow("VEH_COST_BEFORE_SALE")), 0, dtrow("VEH_COST_BEFORE_SALE").ToString())
                        vehDet.SalesProvision = IIf(IsDBNull(dtrow("VEH_SALES_PROVISION")), 0, dtrow("VEH_SALES_PROVISION").ToString())
                        vehDet.CommitDay = IIf(IsDBNull(dtrow("VEH_COMMIT_DAYS")), 0, dtrow("VEH_COMMIT_DAYS").ToString())
                        vehDet.AddedInterests = IIf(IsDBNull(dtrow("VEH_ADDED_INTERESTS")), 0, dtrow("VEH_ADDED_INTERESTS").ToString())
                        vehDet.CostEquipment = IIf(IsDBNull(dtrow("VEH_COST_EQUIPMENT")), 0, dtrow("VEH_COST_EQUIPMENT").ToString())
                        vehDet.TotalCost = IIf(IsDBNull(dtrow("VEH_TOTAL_COST")), 0, dtrow("VEH_TOTAL_COST").ToString())

                        vehDet.CreditNoteNo = dtrow("VEH_CREDITNOTE_NO").ToString()
                        If (dtrow("DT_CREDITNOTE").ToString() = "") Then
                            vehDet.CreditNoteDate = ""
                        Else
                            vehDet.CreditNoteDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_CREDITNOTE").ToString())
                        End If
                        vehDet.InvoiceNo = dtrow("VEH_INVOICE_NO").ToString()
                        If (dtrow("DT_INVOICE").ToString() = "") Then
                            vehDet.InvoiceDate = ""
                        Else
                            vehDet.InvoiceDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_INVOICE").ToString())
                        End If
                        If (dtrow("DT_REBUY").ToString() = "") Then
                            vehDet.RebuyDate = ""
                        Else
                            vehDet.RebuyDate = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_REBUY").ToString())
                        End If
                        vehDet.RebuyPrice = IIf(IsDBNull(dtrow("VEH_REBUY_PRICE")), 0, dtrow("VEH_REBUY_PRICE").ToString())
                        vehDet.CostPerKm = IIf(IsDBNull(dtrow("VEH_COST_PER_KM")), 0, dtrow("VEH_COST_PER_KM").ToString())
                        vehDet.Turnover = IIf(IsDBNull(dtrow("VEH_TURNOVER")), 0, dtrow("VEH_TURNOVER").ToString())
                        vehDet.Progress = IIf(IsDBNull(dtrow("VEH_PROGRESS")), 0, dtrow("VEH_PROGRESS").ToString())
                        vehDet.Axle1 = dtrow("VEH_AXLE1").ToString()
                        vehDet.Axle2 = dtrow("VEH_AXLE2").ToString()
                        vehDet.Axle3 = dtrow("VEH_AXLE3").ToString()
                        vehDet.Axle4 = dtrow("VEH_AXLE4").ToString()
                        vehDet.Axle5 = dtrow("VEH_AXLE5").ToString()
                        vehDet.Axle6 = dtrow("VEH_AXLE6").ToString()
                        vehDet.Axle7 = dtrow("VEH_AXLE7").ToString()
                        vehDet.Axle8 = dtrow("VEH_AXLE8").ToString()
                        vehDet.TrailerDesc = dtrow("VEH_TRAILER_DESC").ToString()

                        'fetch certificate tab
                        vehDet.StdTyreFront = dtrow("VEH_STD_TIRE_FRONT").ToString()
                        vehDet.StdTyreBack = dtrow("VEH_STD_TIRE_BACK").ToString()
                        vehDet.MinLi_Front = dtrow("VEH_MINLI_FRONT").ToString()
                        vehDet.MinLi_Back = dtrow("VEH_MINLI_BACK").ToString()
                        vehDet.Min_Inpress_Front = dtrow("VEH_MIN_INPRESS_FRONT").ToString()
                        vehDet.Min_Inpress_Back = dtrow("VEH_MIN_INPRESS_BACK").ToString()
                        vehDet.Std_Rim_Front = dtrow("VEH_STD_RIM_FRONT").ToString()
                        vehDet.Std_Rim_Back = dtrow("VEH_STD_RIM_BACK").ToString()
                        vehDet.Min_Front = dtrow("VEH_MIN_SPEED_FRONT").ToString()
                        vehDet.Min_Back = dtrow("VEH_MIN_SPEED_BACK").ToString()
                        vehDet.Max_Tyre_Width_Frnt = dtrow("VEH_MAX_TRACK_FRONT").ToString()
                        vehDet.Max_Tyre_Width_Bk = dtrow("VEH_MAX_TRACK_BACK").ToString()
                        vehDet.AxlePrFront = dtrow("VEH_ALLOWABLE_WEIGHT_FRONT").ToString()
                        vehDet.AxlePrBack = dtrow("VEH_ALLOWABLE_WEIGHT_BACK").ToString()
                        vehDet.Axles_Number = dtrow("VEH_QTY_AXLES").ToString()
                        vehDet.Axles_Number_Traction = dtrow("VEH_OPERATIVE_AXLES").ToString()
                        vehDet.Wheels_Traction = dtrow("VEH_DRIVE_WHEEL").ToString()
                        vehDet.TrailerWth_Brks = dtrow("VEH_TRAILER_WEIGHT_W_BRAKES").ToString()
                        vehDet.TrailerWthout_Brks = dtrow("VEH_TRAILER_WEIGHT_WO_BRAKES").ToString()
                        vehDet.Max_Wt_TBar = dtrow("VEH_MAX_LOAD_TOWBAR").ToString()
                        vehDet.Len_TBar = dtrow("VEH_LENGTH_TO_TOWBAR").ToString()
                        vehDet.TotalTrailerWeight = dtrow("VEH_TOTAL_TRAILER_WEIGHT").ToString()
                        vehDet.Seats = dtrow("VEH_SEATS").ToString()
                        If (dtrow("DT_VALID_FROM").ToString() = "") Then
                            vehDet.ValidFrom = ""
                        Else
                            vehDet.ValidFrom = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VALID_FROM").ToString())
                        End If
                        vehDet.EU_Version = dtrow("VEH_EU_VERSION").ToString()
                        vehDet.EU_Variant = dtrow("VEH_EU_VARIANT").ToString()
                        vehDet.EU_Norm = dtrow("VEH_EURONORM").ToString()
                        vehDet.CO2_Emission = dtrow("VEH_CO2_EMISSION").ToString()
                        vehDet.Make_Part_Filter = dtrow("VEH_MAKE_PARTICLE_FILTER").ToString()
                        vehDet.Chassi_Desc = dtrow("VEH_CHASSI").ToString()
                        vehDet.Identity_Annot = dtrow("VEH_IDENTITY").ToString()
                        vehDet.Cert_Text = dtrow("VEH_CERTIFICATE").ToString()
                        vehDet.Annot = dtrow("VEH_ANNOTATIONS").ToString()

                        vehDet.ID_BUYER = dtrow("BUYER_CUST_ID").ToString()
                        vehDet.ID_OWNER = dtrow("OWNER_CUST_ID").ToString()
                        vehDet.ID_LEASING = dtrow("LEASING_CUST_ID").ToString()
                        vehDet.ID_DRIVER = dtrow("DRIVER_CUST_ID").ToString()
                        If (dtrow("DT_VEH_PKK").ToString() = "") Then
                            vehDet.DT_VEH_PKK = ""
                        Else
                            vehDet.DT_VEH_PKK = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_PKK").ToString())
                        End If
                        If (dtrow("DT_VEH_PKK_AFTER").ToString() = "") Then
                            vehDet.DT_VEH_PKK_AFTER = ""
                        Else
                            vehDet.DT_VEH_PKK_AFTER = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_PKK_AFTER").ToString())
                        End If
                        If (dtrow("DT_VEH_PER_SERVICE").ToString() = "") Then
                            vehDet.DT_VEH_PER_SERVICE = ""
                        Else
                            vehDet.DT_VEH_PER_SERVICE = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_PER_SERVICE").ToString())
                        End If
                        If (dtrow("DT_VEH_RENTAL_CAR").ToString() = "") Then
                            vehDet.DT_VEH_RENTAL_CAR = ""
                        Else
                            vehDet.DT_VEH_RENTAL_CAR = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_RENTAL_CAR").ToString())
                        End If
                        If (dtrow("DT_VEH_MOIST_CTRL").ToString() = "") Then
                            vehDet.DT_VEH_MOIST_CTRL = ""
                        Else
                            vehDet.DT_VEH_MOIST_CTRL = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_MOIST_CTRL").ToString())
                        End If
                        If (dtrow("DT_VEH_TECTYL").ToString() = "") Then
                            vehDet.DT_VEH_TECTYL = ""
                        Else
                            vehDet.DT_VEH_TECTYL = objCommonUtil.GetCurrentLanguageDate(dtrow("DT_VEH_TECTYL").ToString())
                        End If
                        retVehicle.Add(vehDet)
                    Next
                End If
            Catch ex As Exception
                Throw ex
            End Try
            Return retVehicle
        End Function

        Public Function GENERATE_XTRA_VEHICLES(ByVal badmotoroil As String, ByVal badcflevel As String, ByVal badcftemp As String, ByVal badbrakefluid As String, ByVal badbattery As String, ByVal badvipesfront As String, ByVal badvipesrear As String, ByVal badlightsfront As String, ByVal badlightsrear As String, ByVal badshockabsorberfront As String, ByVal badshockabsorberrear As String, ByVal badtiresfront As String, ByVal badtiresrear As String, ByVal badsuspensionfront As String, ByVal badsuspensionrear As String, ByVal badbrakesfront As String, ByVal badbrakesrear As String, ByVal badexhaust As String, ByVal badsealedengine As String, ByVal badsealedgearbox As String, ByVal badwindshield As String, ByVal mediummotoroil As String, ByVal mediumcflevel As String, ByVal mediumcftemp As String, ByVal mediumbrakefluid As String, ByVal mediumbattery As String, ByVal mediumvipesfront As String, ByVal mediumvipesrear As String, ByVal mediumlightsfront As String, ByVal mediumlightsrear As String, ByVal mediumshockabsorberfront As String, ByVal mediumshockabsorberrear As String, ByVal mediumtiresfront As String, ByVal mediumtiresrear As String, ByVal mediumsuspensionfront As String, ByVal mediumsuspensionrear As String, ByVal mediumbrakesfront As String, ByVal mediumbrakesrear As String, ByVal mediumexhaust As String, ByVal mediumsealedengine As String, ByVal mediumsealedgearbox As String, ByVal mediumwindshield As String) As List(Of VehicleBO)
            Dim dsVehicle As New DataSet
            Dim dtVehicle As DataTable
            Dim retVehicle As New List(Of VehicleBO)()
            Try
                dsVehicle = objVehicleDO.GENERATE_XTRA_VEHICLES(badmotoroil, badcflevel, badcftemp, badbrakefluid, badbattery, badvipesfront, badvipesrear, badlightsfront, badlightsrear, badshockabsorberfront, badshockabsorberrear, badtiresfront, badtiresrear, badsuspensionfront, badsuspensionrear, badbrakesfront, badbrakesrear, badexhaust, badsealedengine, badsealedgearbox, badwindshield, mediummotoroil, mediumcflevel, mediumcftemp, mediumbrakefluid, mediumbattery, mediumvipesfront, mediumvipesrear, mediumlightsfront, mediumlightsrear, mediumshockabsorberfront, mediumshockabsorberrear, mediumtiresfront, mediumtiresrear, mediumsuspensionfront, mediumsuspensionrear, mediumbrakesfront, mediumbrakesrear, mediumexhaust, mediumsealedengine, mediumsealedgearbox, mediumwindshield)

                If dsVehicle.Tables.Count > 0 Then
                    HttpContext.Current.Session("XtraVehicles") = dsVehicle
                    dtVehicle = dsVehicle.Tables(0)
                End If

                For Each dtrow As DataRow In dtVehicle.Rows
                    Dim vehDet As New VehicleBO()

                    vehDet.VehRegNo = dtrow("REGISTRATIONNR").ToString()
                    vehDet.VehVin = dtrow("VEH_TYPE").ToString()
                    vehDet.Make = dtrow("ID_MAKE_VEH").ToString()
                    vehDet.Model = dtrow("VEH_TYPE").ToString()
                    vehDet.Customer = dtrow("ID_CUSTOMER_VEH").ToString()
                    vehDet.RefNo = dtrow("REFNR").ToString()
                    vehDet.CustomerName = dtrow("CUST_NAME").ToString()
                    vehDet.MOBILE = dtrow("CONTACT_VALUE").ToString()
                    vehDet.MAIL = dtrow("MAIL").ToString()

                    retVehicle.Add(vehDet)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return retVehicle
        End Function

        Public Function LoadImages(ByVal regNo As String) As List(Of VehicleBO)
            Dim dsLoadImage As New DataSet
            Dim dtLoadImage As DataTable
            Dim imageList As New List(Of VehicleBO)()
            Try
                dsLoadImage = objVehicleDO.LoadImages(regNo)
                dtLoadImage = dsLoadImage.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtLoadImage.Rows
                    Dim ImageListDet As New VehicleBO()
                    ImageListDet.FILENAME = dtrow("FILE_NAME").ToString()
                    ImageListDet.FILEPATH = dtrow("FILE_PATH").ToString()
                    imageList.Add(ImageListDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchNewUsedCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return imageList.ToList
        End Function

        Public Function LoadDocs(ByVal regNo As String) As List(Of VehicleBO)
            Dim dsLoadImage As New DataSet
            Dim dtLoadImage As DataTable
            Dim imageList As New List(Of VehicleBO)()
            Try
                dsLoadImage = objVehicleDO.LoadDocs(regNo)
                dtLoadImage = dsLoadImage.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtLoadImage.Rows
                    Dim ImageListDet As New VehicleBO()
                    ImageListDet.FILENAME = dtrow("FILE_NAME").ToString()
                    ImageListDet.FILEPATH = dtrow("FILE_PATH").ToString()
                    imageList.Add(ImageListDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchNewUsedCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return imageList.ToList
        End Function

        Public Function FetchNewUsedCode() As List(Of VehicleBO)
            Dim dsFetchNewUsed As New DataSet
            Dim dtNewUsedCodes As DataTable
            Dim newUsedList As New List(Of VehicleBO)()
            Try
                dsFetchNewUsed = objVehicleDO.FetchNewUsedCodes()
                dtNewUsedCodes = dsFetchNewUsed.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtNewUsedCodes.Rows
                    Dim NewUsedDet As New VehicleBO()
                    NewUsedDet.RefnoCode = dtrow("Refno_Code").ToString()
                    NewUsedDet.RefnoDescription = dtrow("Refno_Description").ToString()
                    NewUsedDet.RefnoPrefix = dtrow("Refno_Prefix").ToString()
                    NewUsedDet.RefnoCount = dtrow("Refno_Count").ToString()
                    newUsedList.Add(NewUsedDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchNewUsedCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return newUsedList.ToList
        End Function
        Public Function GetNewUsedRefNo(ByVal refNo As String) As List(Of VehicleBO)
            Dim dsFetchNewUsed As New DataSet
            Dim dtNewUsedCodes As DataTable
            Dim newUsedList As New List(Of VehicleBO)()
            Try
                dsFetchNewUsed = objVehicleDO.GetNewUsedRefNo(refNo)
                dtNewUsedCodes = dsFetchNewUsed.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtNewUsedCodes.Rows
                    Dim RefnoDet As New VehicleBO()
                    RefnoDet.RefnoCode = dtrow("refno_code").ToString()
                    RefnoDet.RefnoPrefix = dtrow("refno_prefix").ToString()
                    RefnoDet.RefnoCount = dtrow("refno_count").ToString()
                    newUsedList.Add(RefnoDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchRefNo", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return newUsedList.ToList
        End Function
        Public Function SetNewUsedRefNo(ByVal refNoType As String, ByVal refNo As String) As List(Of VehicleBO)
            Dim dsFetchNewUsed As New DataSet
            Dim dtNewUsedCodes As DataTable
            Dim newUsedList As New List(Of VehicleBO)()
            Try
                dsFetchNewUsed = objVehicleDO.SetNewUsedRefNo(refNoType, refNo)
                dtNewUsedCodes = dsFetchNewUsed.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtNewUsedCodes.Rows
                    Dim RefnoDet As New VehicleBO()
                    RefnoDet.RefnoCode = dtrow("refno_code").ToString()
                    RefnoDet.RefnoPrefix = dtrow("refno_prefix").ToString()
                    RefnoDet.RefnoCount = dtrow("refno_count").ToString()
                    newUsedList.Add(RefnoDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchRefNo", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return newUsedList.ToList
        End Function

        Public Function FetchStatusCode() As List(Of VehicleBO)
            Dim dsFetchStatus As New DataSet
            Dim dtStatusCodes As DataTable
            Dim statusList As New List(Of VehicleBO)()
            Try
                dsFetchStatus = objVehicleDO.FetchStatusCodes()
                dtStatusCodes = dsFetchStatus.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtStatusCodes.Rows
                    Dim statusDet As New VehicleBO()
                    statusDet.StatusCode = dtrow("SettingsCode").ToString()
                    statusDet.StatusDesc = dtrow("SettingDescription").ToString()
                    statusList.Add(statusDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchStatusCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return statusList.ToList
        End Function

        Public Function FetchWarrantyCode() As List(Of VehicleBO)
            Dim dsFetchAllWarranty As New DataSet
            Dim dtWarrantyCodes As DataTable
            Dim warranty As New List(Of VehicleBO)()
            Try
                dsFetchAllWarranty = objVehicleDO.FetchAllWarrantyCodes()
                dtWarrantyCodes = dsFetchAllWarranty.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtWarrantyCodes.Rows
                    Dim warrantyDet As New VehicleBO()
                    warrantyDet.WarrantyCodes = dtrow("SettingsCode").ToString()
                    warrantyDet.WarrantyDesc = dtrow("SettingDescription").ToString()
                    warranty.Add(warrantyDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchWarrantyCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return warranty.ToList
        End Function

        Public Function FetchMakeCode() As List(Of VehicleBO)
            Dim dsFetchAllMakes As New DataSet
            Dim dtMakeCodes As DataTable
            Dim Make As New List(Of VehicleBO)()
            Try
                dsFetchAllMakes = objVehicleDO.FetchAllMakeCodes()
                dtMakeCodes = dsFetchAllMakes.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtMakeCodes.Rows
                    Dim makeDet As New VehicleBO()
                    makeDet.Id_Make_Veh = dtrow("ID_MAKE").ToString()
                    makeDet.MakeName = dtrow("ID_MAKE_NAME").ToString()
                    Make.Add(makeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "FetchMakeCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return Make.ToList
        End Function

        Public Function GetVehGroup(ByVal VehGrp As String) As List(Of String)
            Dim retVehGroup As New List(Of String)()
            Dim dsVehGroup As New DataSet
            Dim dtVehGroup As New DataTable
            Try
                objVehicleBO.VehGrp = VehGrp
                dsVehGroup = objVehicleDO.Fetch_VehGroup(objVehicleBO.VehGrp)

                If dsVehGroup.Tables.Count > 0 Then
                    If dsVehGroup.Tables(0).Rows.Count > 0 Then
                        dtVehGroup = dsVehGroup.Tables(0)
                    End If
                End If
                For Each dtrow As DataRow In dtVehGroup.Rows
                    retVehGroup.Add(String.Format("{0}-{1}-{2}", dtrow("ID_SETTINGS"), dtrow("Description"), dtrow("REMARKS")))
                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "getVehGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return retVehGroup
        End Function

        Public Function GetFuelCode(ByVal FuelCode As String) As List(Of String)
            Dim retFuelCode As New List(Of String)()
            Dim dsFuelCode As New DataSet
            Dim dtFuelCode As New DataTable
            Try
                objVehicleBO.FuelCode = FuelCode
                dsFuelCode = objVehicleDO.Fetch_FuelCode(objVehicleBO.FuelCode)

                If dsFuelCode.Tables.Count > 0 Then
                    If dsFuelCode.Tables(0).Rows.Count > 0 Then
                        dtFuelCode = dsFuelCode.Tables(0)
                    End If
                End If
                For Each dtrow As DataRow In dtFuelCode.Rows
                    retFuelCode.Add(String.Format("{0}-{1}", dtrow("SettingsCode"), dtrow("SettingDescription")))
                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "getFuelCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return retFuelCode
        End Function

        Public Function GetWareHouse(ByVal WH As String) As List(Of String)
            Dim retWareHouse As New List(Of String)()
            Dim dsWareHouse As New DataSet
            Dim dtWareHouse As New DataTable
            Try
                objVehicleBO.WareHouse = WH
                dsWareHouse = objVehicleDO.Fetch_WareHouse(objVehicleBO.WareHouse)

                If dsWareHouse.Tables.Count > 0 Then
                    If dsWareHouse.Tables(0).Rows.Count > 0 Then
                        dtWareHouse = dsWareHouse.Tables(0)
                    End If
                End If
                For Each dtrow As DataRow In dtWareHouse.Rows
                    retWareHouse.Add(String.Format("{0}-{1}-{2}", dtrow("ID_DEPT"), dtrow("DPT_NAME"), dtrow("DPT_LOCATION")))
                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "getWareHouse", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return retWareHouse
        End Function
        Public Function GetVehicle(ByVal vehicleRegNo As String) As List(Of String)
            Dim dsVehicle As New DataSet
            Dim dtVehicle As New DataTable
            Dim retVehicle As New List(Of String)()
            Try
                dsVehicle = objVehicleDO.GetVehicle(vehicleRegNo)

                If dsVehicle.Tables.Count > 0 Then
                    If dsVehicle.Tables(0).Rows.Count > 0 Then
                        dtVehicle = dsVehicle.Tables(0)
                    End If
                End If
                If vehicleRegNo <> String.Empty Then
                    If dtVehicle.Rows.Count > 0 Then
                        For Each dtrow As DataRow In dtVehicle.Rows
                            retVehicle.Add(String.Format("{0}", dtrow("ACRESULT")))
                        Next
                    End If
                End If
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Vehicle.vb", "GetVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return retVehicle
        End Function
        Public Function Fetch_VehConfig() As List(Of VehicleBO)
            Dim dsVehConfig As New DataSet
            Dim dtVehConfig As DataTable
            Dim details As New List(Of VehicleBO)()
            Try
                dsVehConfig = objVehicleDO.Fetch_VehConfig()

                If dsVehConfig.Tables.Count > 0 Then
                    If dsVehConfig.Tables(1).Rows.Count > 0 Then
                        dtVehConfig = dsVehConfig.Tables(1)
                        For Each dtrow As DataRow In dtVehConfig.Rows
                            Dim vehDet As New VehicleBO()
                            vehDet.Id_Settings = dtrow("ID_SETTINGS").ToString()
                            vehDet.Description = dtrow("DESCRIPTION").ToString()
                            details.Add(vehDet)
                        Next
                    End If
                End If

            Catch ex As Exception
                Throw ex
            End Try
            Return details.ToList
        End Function
        Public Function Fetch_Model(ByVal objVehicleBO As VehicleBO) As List(Of VehicleBO)
            Dim dsVehConfig As New DataSet
            Dim dtVehConfig As DataTable
            Dim details As New List(Of VehicleBO)()
            Try
                dsVehConfig = objVehicleDO.Fetch_VehModel(objVehicleBO)
                If dsVehConfig.Tables.Count > 0 Then
                    HttpContext.Current.Session("RPMOdel") = dsVehConfig.Tables(1)
                    If dsVehConfig.Tables(0).Rows.Count > 0 Then
                        dtVehConfig = dsVehConfig.Tables(0)
                        For Each dtrow As DataRow In dtVehConfig.Rows
                            Dim vehDet As New VehicleBO()
                            vehDet.Id_Model = dtrow("ID_MG_SEQ").ToString()
                            vehDet.Model_Desc = dtrow("MG_ID_MODEL_GRP").ToString()
                            details.Add(vehDet)
                        Next
                    End If
                End If

            Catch ex As Exception
                Throw ex
            End Try
            Return details.ToList
        End Function
        Public Function Fetch_RPModel() As List(Of VehicleBO)
            Dim dsVehConfig As New DataSet
            Dim dtVehConfig As DataTable
            Dim details As New List(Of VehicleBO)()
            Try
                dsVehConfig = HttpContext.Current.Session("RPMOdel")

                If dsVehConfig.Tables.Count > 0 Then
                    If dsVehConfig.Tables(0).Rows.Count > 0 Then
                        dtVehConfig = dsVehConfig.Tables(0)
                        For Each dtrow As DataRow In dtVehConfig.Rows
                            Dim vehDet As New VehicleBO()
                            vehDet.Id_Model = dtrow("ID_MODEL").ToString()
                            vehDet.Model_Desc = dtrow("MODEL_ID_MAKE").ToString()
                            details.Add(vehDet)
                        Next
                    End If
                End If

            Catch ex As Exception
                Throw ex
            End Try
            Return details.ToList
        End Function

        Public Function FetchEditMake() As List(Of VehicleBO)
            Dim dsFetchMake As New DataSet
            Dim dtMake As DataTable
            Dim Make As New List(Of VehicleBO)()
            Try
                dsFetchMake = objVehicleDO.FetchEditMake()
                dtMake = dsFetchMake.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtMake.Rows
                    Dim makeDet As New VehicleBO()
                    makeDet.MakeCode = dtrow("ID_MAKE").ToString()
                    makeDet.MakeName = dtrow("ID_MAKE_NAME").ToString()
                    Make.Add(makeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Customer.vb", "FetchCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return Make.ToList
        End Function

        Public Function GetEditMake(ByVal makeId As String) As List(Of VehicleBO)
            Dim dsGetMake As New DataSet
            Dim dtGetMake As DataTable
            Dim Make As New List(Of VehicleBO)()
            Try
                dsGetMake = objVehicleDO.GetEditMake(makeId)
                dtGetMake = dsGetMake.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtGetMake.Rows
                    Dim getMakeDet As New VehicleBO()
                    getMakeDet.MakeCode = dtrow("ID_MAKE").ToString()
                    getMakeDet.MakeName = dtrow("ID_MAKE_NAME").ToString()
                    If (IsDBNull(dtrow("ID_MAKE_PRICECODE").ToString())) Then
                        getMakeDet.Cost_Price = ""
                    Else
                        getMakeDet.Cost_Price = dtrow("ID_MAKE_PRICECODE").ToString()
                    End If
                    If (IsDBNull(dtrow("MAKEDISCODE").ToString())) Then
                        getMakeDet.Description = ""
                    Else
                        getMakeDet.Description = dtrow("MAKEDISCODE").ToString()
                    End If
                    If (IsDBNull(dtrow("MAKE_VATCODE").ToString())) Then
                        getMakeDet.VanNo = ""
                    Else
                        getMakeDet.VanNo = dtrow("MAKE_VATCODE").ToString()
                    End If
                    Make.Add(getMakeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Customer.vb", "FetchCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return Make.ToList
        End Function
        Public Function Add_EditMake(ByVal strXMLSettingsVehMake As String) As String
            Dim strResult As String = ""
            Try
                strResult = objVehicleDO.Add_EditMake(strXMLSettingsVehMake)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "Add_Vehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function
        Public Function DeleteEditMake(ByVal editMakeId As String) As List(Of VehicleBO)
            Dim dsGetBranch As New DataSet

            Dim Branch As New List(Of VehicleBO)()
            Try
                objVehicleDO.Delete_EditMake(editMakeId)

                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Customer.vb", "FetchCustomerGroup", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return Branch.ToList
        End Function
        Public Function GetModel(ByVal IdMake As String, ByVal Model As String) As String
            Dim dsRes As New DataSet
            Dim strResult As String
            Try
                objVehicleBO.Id_Make_Veh = IdMake
                objVehicleBO.Model_Desc = Model
                dsRes = objVehicleDO.GetModel(objVehicleBO)
                If dsRes.Tables(0).Rows.Count > 0 Then
                    strResult = dsRes.Tables(0).Rows(0)("ID_MG_SEQ").ToString
                End If
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "GetModel", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function
        Public Function LoadModel() As List(Of VehicleBO)
            Dim details As New List(Of VehicleBO)()
            Dim dsVEHDetails As New DataSet
            Dim dtVEHDetails As New DataTable
            Try
                dsVEHDetails = objWOHDO.Fetch_WO_Config()
                If dsVEHDetails.Tables.Count > 0 Then
                    If dsVEHDetails.Tables(11).Rows.Count > 0 Then
                        dtVEHDetails = dsVEHDetails.Tables(11)
                        For Each dtrow As DataRow In dtVEHDetails.Rows
                            Dim vehDet As New VehicleBO()
                            vehDet.Id_Model = dtrow("ID_MODEL").ToString()
                            vehDet.Model_Desc = dtrow("MODEL_DESC").ToString()
                            details.Add(vehDet)
                        Next
                    End If
                End If
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "LoadModel", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return details.ToList
        End Function

        Public Function LoadVatCode() As List(Of VehicleBO)

            Dim details As New List(Of VehicleBO)()
            Dim dsVEHDetails As New DataSet
            Dim dtVEHDetails As New DataTable

            Try

                dsVEHDetails = objVehicleDO.Fetch_VatCode()
                If dsVEHDetails.Tables.Count > 0 Then

                    dtVEHDetails = dsVEHDetails.Tables(0)
                    For Each dtrow As DataRow In dtVEHDetails.Rows
                        Dim vehDet As New VehicleBO()
                        vehDet.vatCode = dtrow("ID_SETTINGS").ToString()
                        vehDet.vatDesc = dtrow("DESCRIPTION").ToString()
                        details.Add(vehDet)
                    Next

                End If

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "LoadMomskode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return details.ToList
        End Function

        Public Function Fetch_Invoices(ByVal Refno As String) As List(Of VehicleBO)
            Dim dsInvList As New DataSet
            Dim dtInvList As DataTable
            Dim invListResult As New List(Of VehicleBO)()

            Try
                dsInvList = objVehicleDO.Fetch_Invoices(Refno)

                If dsInvList.Tables.Count > 0 Then
                    dtInvList = dsInvList.Tables(0)
                End If
                If Refno <> String.Empty Then
                    For Each dtrow As DataRow In dtInvList.Rows
                        Dim il As New VehicleBO()

                        il.ID_INV_NO = dtrow("ID_INV_NO").ToString
                        il.DT_INVOICE = dtrow("DT_INVOICE").ToString
                        il.ORDERNO = dtrow("ORDERNO").ToString
                        il.DT_CREATED = dtrow("DT_CREATED").ToString

                        il.Mileage = dtrow("MILEAGE").ToString
                        il.MECHANIC = dtrow("MECHANIC").ToString
                        il.CreatedBy = dtrow("CREATED_BY").ToString

                        invListResult.Add(il)
                    Next
                End If
            Catch ex As Exception
                Throw ex
            End Try
            Return invListResult
        End Function

        Public Function Fetch_Invoice_Lines(ByVal InvNo As String) As List(Of VehicleBO)
            Dim dsInvLines As New DataSet
            Dim dtInvLines As DataTable
            Dim invLinesResult As New List(Of VehicleBO)()

            Try
                dsInvLines = objVehicleDO.Fetch_Invoice_Lines(InvNo)

                If dsInvLines.Tables.Count > 0 Then
                    dtInvLines = dsInvLines.Tables(0)
                End If

                For Each dtrow As DataRow In dtInvLines.Rows
                    Dim item As New VehicleBO()

                    item.ID_INV_NO = dtrow("INV_NO")
                    item.ID_WOITEM_SEQ = dtrow("WODET_SEQ").ToString
                    item.ID_ITEM = dtrow("ID_ITEM").ToString
                    item.ITEM_DESC = dtrow("ITEM_DESC").ToString
                    item.ITEM_QTY = dtrow("ITEM_QTY")
                    item.ITEM_PRICE = dtrow("ITEM_PRICE")
                    item.ITEM_VAT = dtrow("ITEM_VAT")
                    item.ITEM_TOTAL = dtrow("ITEM_TOTAL")
                    item.DT_CREATED = dtrow("DT_CREATED").ToString

                    invLinesResult.Add(item)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return invLinesResult
        End Function

        Public Function GetNewVehDetailsData(ByVal regNo As String) As List(Of VehicleBO)
            Try
                Dim objNewVehDetails As New List(Of VehicleBO)()
                Dim NewVehDet As New VehicleBO()
                Dim vehjs As String = ""
                Dim json As String = ""

                'KH83796
                'If token! = "" Then
                GetToken()
                'End If

                json = GetVehData(regNo, True, True, True, True)

                Dim RegInforesponse = JsonConvert.DeserializeObject(Of Rootobject)(json)
                Dim o As JObject = JObject.Parse(json)
                If Not o("technical_data") Is Nothing AndAlso o("technical_data").Count > 0 Then

                    NewVehDet.VehRegNo = o("technical_data")("reg_nr").ToString()
                    NewVehDet.VehVin = o("technical_data")("chassis_nr").ToString()

                    If (o("technical_data")("forste_reg_dato_norge_import") Is Nothing Or o("technical_data")("forste_reg_dato_norge_import").ToString() = "") Then
                        NewVehDet.RegDateNorway = ""
                    Else
                        Dim regDateNor As DateTime = Convert.ToDateTime(DateTime.ParseExact(o("technical_data")("forste_reg_dato_norge_import").ToString(), "yyyyMMdd", CultureInfo.InvariantCulture))
                        ' Dim dateddMMyyyy As String = regDateNor.ToString("dd-MM-yyyy")
                        NewVehDet.RegDateNorway = objCommonUtil.GetCurrentLanguageDate(regDateNor)
                    End If

                    NewVehDet.MakeCode = o("technical_data")("merkekode")
                    NewVehDet.Make = o("technical_data")("merkenavn")
                    NewVehDet.Model = o("technical_data")("typegod_typekode")
                    NewVehDet.VehType = o("technical_data")("modellnavn")
                    NewVehDet.ApprovalNo = o("technical_data")("nasjonalt_godkj_nr")
                    NewVehDet.VehGrp = o("technical_data")("avgiftskode")
                    NewVehDet.VEHGRPNAME = o("technical_data")("kjennemerke_farge")
                    NewVehDet.EngineNum = o("technical_data")("motorkode")
                    NewVehDet.FuelType = o("technical_data")("drivstoffkode")

                    If o("technical_data")("fargekode") IsNot Nothing Then
                        NewVehDet.Color = o("technical_data")("fargekode")
                    Else
                        NewVehDet.Color = ""
                    End If


                    If o("technical_data")("motor_slagvolum") IsNot Nothing Then
                        NewVehDet.PisDisplacement = o("technical_data")("motor_slagvolum")
                    Else
                        NewVehDet.PisDisplacement = ""
                    End If

                    If o("technical_data")("bredde") IsNot Nothing Then
                        NewVehDet.Width = o("technical_data")("bredde")
                    Else
                        NewVehDet.Width = ""
                    End If

                    If o("technical_data")("lengde") IsNot Nothing Then
                        NewVehDet.Length = o("technical_data")("lengde")
                    Else
                        NewVehDet.Length = ""
                    End If

                    'Changed to Split with *
                    If (o("technical_data")("dekkdim_aksel_1_forfra").ToString().Contains("*")) Then
                        Dim StdTyreFrontData = o("technical_data")("dekkdim_aksel_1_forfra").ToString().Split("*")
                        NewVehDet.StdTyreFront = StdTyreFrontData(0)
                    Else
                        NewVehDet.StdTyreFront = o("technical_data")("dekkdim_aksel_1_forfra")
                    End If

                    If (o("technical_data")("lastind_dekk_aksel_1").ToString().Contains("*")) Then
                        Dim MinLiFrontData = o("technical_data")("lastind_dekk_aksel_1").ToString().Split("*")
                        NewVehDet.MinLi_Front = MinLiFrontData(0)
                    Else
                        NewVehDet.MinLi_Front = o("technical_data")("lastind_dekk_aksel_1")
                    End If

                    If (o("technical_data")("hastind_dekk_aksel_1").ToString().Contains("*")) Then
                        Dim MinFrontData = o("technical_data")("hastind_dekk_aksel_1").ToString().Split("*")
                        NewVehDet.Min_Front = MinFrontData(0)
                    Else
                        NewVehDet.Min_Front = o("technical_data")("hastind_dekk_aksel_1")
                    End If

                    If (o("technical_data")("felgdim_aksel_1").ToString().Contains("*")) Then
                        Dim StdRimFrontData = o("technical_data")("felgdim_aksel_1").ToString().Split("*")
                        NewVehDet.Std_Rim_Front = StdRimFrontData(0)
                    Else
                        NewVehDet.Std_Rim_Front = o("technical_data")("felgdim_aksel_1")
                    End If

                    If (o("technical_data")("innpress_aksel_1").ToString().Contains("*")) Then
                        Dim MinInpressFrontData = o("technical_data")("innpress_aksel_1").ToString().Split("*")
                        NewVehDet.Min_Inpress_Front = MinInpressFrontData(0)
                    Else
                        NewVehDet.Min_Inpress_Front = o("technical_data")("innpress_aksel_1")
                    End If

                    If (o("technical_data")("dekkdim_aksel_2_forfra").ToString().Contains("*")) Then
                        Dim StdTyreBackData = o("technical_data")("dekkdim_aksel_2_forfra").ToString().Split("*")
                        NewVehDet.StdTyreBack = StdTyreBackData(0)
                    Else
                        NewVehDet.StdTyreBack = o("technical_data")("dekkdim_aksel_2_forfra")
                    End If

                    If (o("technical_data")("lastind_dekk_aksel_2").ToString().Contains("*")) Then
                        Dim MinLiBackData = o("technical_data")("lastind_dekk_aksel_2").ToString().Split("*")
                        NewVehDet.MinLi_Back = MinLiBackData(0)
                    Else
                        NewVehDet.MinLi_Back = o("technical_data")("lastind_dekk_aksel_2")
                    End If

                    If (o("technical_data")("hastind_dekk_aksel_2").ToString().Contains("*")) Then
                        Dim MinBackData = o("technical_data")("hastind_dekk_aksel_2").ToString().Split("*")
                        NewVehDet.Min_Back = MinBackData(0)
                    Else
                        NewVehDet.Min_Back = o("technical_data")("hastind_dekk_aksel_2")
                    End If

                    If (o("technical_data")("felgdim_aksel_2").ToString().Contains("*")) Then
                        Dim StdRimBackData = o("technical_data")("felgdim_aksel_2").ToString().Split("*")
                        NewVehDet.Std_Rim_Back = StdRimBackData(0)
                    Else
                        NewVehDet.Std_Rim_Back = o("technical_data")("felgdim_aksel_2")
                    End If

                    If (o("technical_data")("innpress_aksel_2").ToString().Contains("*")) Then
                        Dim MinInpressBackData = o("technical_data")("innpress_aksel_2").ToString().Split("*")
                        NewVehDet.Min_Inpress_Back = MinInpressBackData(0)
                    Else
                        NewVehDet.Min_Inpress_Back = o("technical_data")("innpress_aksel_2")
                    End If
                    NewVehDet.Max_Tyre_Width_Frnt = o("technical_data")("sporvidde_aksel_1")
                    NewVehDet.Max_Tyre_Width_Bk = o("technical_data")("sporvidde_aksel_2")
                    NewVehDet.TotalWeight = o("technical_data")("totalvekt")
                    NewVehDet.NetWeight = o("technical_data")("egenvekt_u_forer")
                    NewVehDet.Max_Wt_TBar = o("technical_data")("max_vekt_pa_hengerfeste")


                    'If (o("pkk")("dato_neste_eu_kontroll") Is Nothing Or o("pkk")("dato_neste_eu_kontroll").ToString() = "") Then
                    '    NewVehDet.NxtPKK_Date = ""
                    'Else
                    '    Dim nxtPkkDat As DateTime = Convert.ToDateTime(DateTime.ParseExact(o("pkk")("dato_neste_eu_kontroll").ToString(), "yyyyMMdd", CultureInfo.InvariantCulture))
                    '    ' Dim dateddMMyyyy As String = regDateNor.ToString("dd-MM-yyyy")
                    '    NewVehDet.NxtPKK_Date = objCommonUtil.GetCurrentLanguageDate(nxtPkkDat)
                    'End If


                    If (o("technical_data")("forste_reg_dato") Is Nothing) Then
                        NewVehDet.RegYear = ""
                    Else
                        NewVehDet.RegYear = o("technical_data")("forste_reg_dato")
                    End If

                    If (o("technical_data")("fgreg_dato_eier") Is Nothing Or o("technical_data")("fgreg_dato_eier").ToString() = "") Then
                        NewVehDet.LastRegDate = ""
                    Else
                        Dim lastRegDat As DateTime = Convert.ToDateTime(DateTime.ParseExact(o("technical_data")("fgreg_dato_eier").ToString(), "yyyyMMdd", CultureInfo.InvariantCulture))
                        NewVehDet.LastRegDate = objCommonUtil.GetCurrentLanguageDate(lastRegDat)
                    End If

                    'If (o("pkk")("dato_siste_eu_kontroll") Is Nothing Or o("pkk")("dato_siste_eu_kontroll").ToString() = "") Then
                    '    NewVehDet.LastPKK_AppDate = ""
                    'Else
                    '    Dim lastPkkAppDat As DateTime = Convert.ToDateTime(DateTime.ParseExact(o("pkk")("dato_siste_eu_kontroll").ToString(), "yyyyMMdd", CultureInfo.InvariantCulture))
                    '    NewVehDet.LastPKK_AppDate = objCommonUtil.GetCurrentLanguageDate(lastPkkAppDat)
                    'End If

                    If (o("technical_data")("avreg_dato") Is Nothing Or o("technical_data")("avreg_dato").ToString() = "") Then
                        NewVehDet.DeRegDate = ""
                    Else
                        Dim lastDeRegDat As DateTime = Convert.ToDateTime(DateTime.ParseExact(o("technical_data")("avreg_dato").ToString(), "yyyyMMdd", CultureInfo.InvariantCulture))
                        NewVehDet.DeRegDate = objCommonUtil.GetCurrentLanguageDate(lastDeRegDat)
                    End If

                    If (o("technical_data")("sitteplasser_foran") Is Nothing) Then
                        NewVehDet.Veh_Seat = ""
                    Else
                        NewVehDet.Veh_Seat = o("technical_data")("sitteplasser_foran")
                    End If


                    If (o("technical_data")("co2_utslipp") Is Nothing) Then
                        NewVehDet.CO2_Emission = ""
                    Else
                        NewVehDet.CO2_Emission = o("technical_data")("co2_utslipp")
                    End If

                    If (o("technical_data")("typegod_variant") Is Nothing) Then
                        NewVehDet.EU_Variant = ""
                    Else
                        NewVehDet.EU_Variant = o("technical_data")("typegod_variant")
                    End If

                    If (o("technical_data")("typegod_versjon") Is Nothing) Then
                        NewVehDet.EU_Version = ""
                    Else
                        NewVehDet.EU_Version = o("technical_data")("typegod_versjon")
                    End If

                    If (o("technical_data")("girkasse_type") Is Nothing) Then
                        NewVehDet.GearBox_Desc = ""
                    Else
                        NewVehDet.GearBox_Desc = o("technical_data")("girkasse_type")
                    End If


                    If (o("technical_data")("max_tilhengervekt_m_brems") Is Nothing) Then
                        NewVehDet.TrailerWth_Brks = ""
                    Else
                        NewVehDet.TrailerWth_Brks = o("technical_data")("max_tilhengervekt_m_brems")
                    End If

                    If (o("technical_data")("max_tilhengervekt_u_brems") Is Nothing) Then
                        NewVehDet.TrailerWthout_Brks = ""
                    Else
                        NewVehDet.TrailerWthout_Brks = o("technical_data")("max_tilhengervekt_u_brems")
                    End If

                    NewVehDet.Axles_Number = o("technical_data")("antall_aksler_totalt")

                    If (o("technical_data")("aksler_drift") Is Nothing) Then
                        NewVehDet.Axles_Number_Traction = ""
                    Else
                        NewVehDet.Axles_Number_Traction = o("technical_data")("aksler_drift")
                    End If

                    If (o("technical_data")("standard_stoy") Is Nothing) Then
                        NewVehDet.Noise_On_Veh = ""
                    Else
                        NewVehDet.Noise_On_Veh = o("technical_data")("standard_stoy")
                    End If

                    If (o("technical_data")("typegod_hovednr") Is Nothing) Then
                        NewVehDet.EU_Main_Num = ""
                    Else
                        NewVehDet.EU_Main_Num = o("technical_data")("typegod_hovednr")
                    End If

                    NewVehDet.EU_Norm = o("technical_data")("utslipp_euronorm")
                    Dim stName As String = ""
                    If (o("technical_data")("medeier_fornavn") Is Nothing) Then
                        stName = ""
                    Else
                        stName = o("technical_data")("medeier_fornavn").ToString() + o("technical_data")("medeier_mellomnavn").ToString() + o("technical_data")("medeier_etternavn").ToString() + "," + o("technical_data")("medeier_fodsel_org_nr").ToString() + "," + o("technical_data")("medeier_adressee").ToString() + "," + o("technical_data")("medeier_postnr").ToString() + "," + o("technical_data")("medeier_poststed").ToString()
                    End If
                    NewVehDet.Identity_Annot = stName

                    NewVehDet.Make_Part_Filter = o("technical_data")("partikkelfilter")

                    NewVehDet.ModelYear = o("technical_data")("forste_reg_dato")


                    If (o("technical_data")("motoreffekt_kw") Is Nothing Or o("technical_data")("motoreffekt_kw").ToString() = "") Then
                        NewVehDet.EngineEff = "0"
                    Else
                        NewVehDet.EngineEff = o("technical_data")("motoreffekt_kw")
                    End If

                    If (o("technical_data")("tillatt_last_aksel_1") Is Nothing Or o("technical_data")("tillatt_last_aksel_1").ToString() = "") Then
                        NewVehDet.AxlePrFront = "0"
                    Else
                        NewVehDet.AxlePrFront = o("technical_data")("tillatt_last_aksel_1")
                    End If

                    If (o("technical_data")("tillatt_last_aksel_2") Is Nothing Or o("technical_data")("tillatt_last_aksel_2").ToString() = "") Then
                        NewVehDet.AxlePrBack = "0"
                    Else
                        NewVehDet.AxlePrBack = o("technical_data")("tillatt_last_aksel_2")
                    End If

                    NewVehDet.Wheels_Traction = "" 'not sure which field
                    NewVehDet.Len_TBar = ""         'not available
                    NewVehDet.Max_Rf_Load = ""      'not available
                    NewVehDet.Cert_Text = ""        'not available
                    NewVehDet.Chassi_Desc = ""      'not available
                    NewVehDet.Rounds = ""           'not available


                    If Not o("registration_info") Is Nothing AndAlso o("registration_info").Count > 0 Then
                        If o("registration_info")("eier_for_etter_org_navn") Is Nothing Then
                            NewVehDet.OWNER_ORG_NAME = ""
                        Else
                            NewVehDet.OWNER_ORG_NAME = o("registration_info")("eier_for_etter_org_navn")
                        End If
                        If o("registration_info")("eier_etternavn") Is Nothing Then
                            NewVehDet.OWNER_LAST_NAME = ""
                        Else
                            NewVehDet.OWNER_LAST_NAME = o("registration_info")("eier_etternavn")
                        End If
                        If o("registration_info")("eier_fornavn") Is Nothing Then
                            NewVehDet.OWNER_FIRST_NAME = ""
                        Else
                            NewVehDet.OWNER_FIRST_NAME = o("registration_info")("eier_fornavn")
                        End If
                        If o("registration_info")("eier_mellomnavn") Is Nothing Then
                            NewVehDet.OWNER_MIDDLE_NAME = ""
                        Else
                            NewVehDet.OWNER_MIDDLE_NAME = o("registration_info")("eier_mellomnavn")
                        End If
                        If o("registration_info")("fodsel_org_nr") Is Nothing Then
                            NewVehDet.OWNER_BIRTH_ORG_NO = ""
                        Else
                            NewVehDet.OWNER_BIRTH_ORG_NO = o("registration_info")("fodsel_org_nr")
                        End If
                        If o("registration_info")("status_eier_dod_folkeregister") Is Nothing Then
                            NewVehDet.OWNER_STATUS_DOD_FOLKREG = ""
                        Else
                            NewVehDet.OWNER_STATUS_DOD_FOLKREG = o("registration_info")("status_eier_dod_folkeregister")
                        End If

                        If o("registration_info")("eier_adresse") Is Nothing Then
                            NewVehDet.OWNER_ADDRESS = ""
                        Else
                            NewVehDet.OWNER_ADDRESS = o("registration_info")("eier_adresse")
                        End If

                        If o("registration_info")("eier_postnr") Is Nothing Then
                            NewVehDet.OWNER_POSTNO = ""
                        Else
                            NewVehDet.OWNER_POSTNO = o("registration_info")("eier_postnr")
                        End If

                        If o("registration_info")("eier_poststed") Is Nothing Then
                            NewVehDet.OWNER_POSTOFF = ""
                        Else
                            NewVehDet.OWNER_POSTOFF = o("registration_info")("eier_poststed")
                        End If

                        If o("registration_info")("eier_kommune_nummer") Is Nothing Then
                            NewVehDet.OWNER_COMM_NUM = ""
                        Else
                            NewVehDet.OWNER_COMM_NUM = o("registration_info")("eier_kommune_nummer")
                        End If

                        If o("registration_info")("eier_fylke") Is Nothing Then
                            NewVehDet.OWNER_COUNTY = ""
                        Else
                            NewVehDet.OWNER_COUNTY = o("registration_info")("eier_fylke")
                        End If

                        If o("registration_info")("leasingtaker_navn") Is Nothing Then
                            NewVehDet.LESSE_NAME = ""
                        Else
                            NewVehDet.LESSE_NAME = o("registration_info")("leasingtaker_navn").ToString()
                        End If

                        If o("registration_info")("leasingtaker_etternavn") Is Nothing Then
                            NewVehDet.LESSE_LASTNAME = ""
                        Else
                            NewVehDet.LESSE_LASTNAME = o("registration_info")("leasingtaker_etternavn")
                        End If

                        If o("registration_info")("leasingtaker_fornavn") Is Nothing Then
                            NewVehDet.LESSE_FIRSTNAME = ""
                        Else
                            NewVehDet.LESSE_FIRSTNAME = o("registration_info")("leasingtaker_fornavn")
                        End If

                        If o("registration_info")("leasingtaker_mellomnavn") Is Nothing Then
                            NewVehDet.LESSE_MIDDLENAME = ""
                        Else
                            NewVehDet.LESSE_MIDDLENAME = o("registration_info")("leasingtaker_mellomnavn")
                        End If

                        If o("registration_info")("leasingtaker_fodsel_onr") Is Nothing Then
                            NewVehDet.LESSE_BIRTH_NO = ""
                        Else
                            NewVehDet.LESSE_BIRTH_NO = o("registration_info")("leasingtaker_fodsel_onr")
                        End If

                        If o("registration_info")("leasingtaker_addresse") Is Nothing Then
                            NewVehDet.LESSE_ADDRESS = ""
                        Else
                            NewVehDet.LESSE_ADDRESS = o("registration_info")("leasingtaker_addresse")
                        End If

                        If o("registration_info")("leasingtaker_postnr") Is Nothing Then
                            NewVehDet.LESSE_POSTNR = ""
                        Else
                            NewVehDet.LESSE_POSTNR = o("registration_info")("leasingtaker_postnr")
                        End If

                        If o("registration_info")("leasingtaker_poststed") Is Nothing Then
                            NewVehDet.LESSE_POSTOFF = ""
                        Else
                            NewVehDet.LESSE_POSTOFF = o("registration_info")("leasingtaker_poststed")
                        End If

                    End If

                Else
                    NewVehDet.VehRegNo = ""
                End If

                objNewVehDetails.Add(NewVehDet)

                HttpContext.Current.Session("NewVehDetails") = objNewVehDetails

                Return objNewVehDetails
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "GetNewVehDetailsData", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try

        End Function

        Public Function CustomerCheck(strFName As String, strLName As String, isCompany As Boolean) As DataSet
            Dim dscustExist As New DataSet
            Try
                dscustExist = objVehicleDO.Fetch_CheckCustomer(strFName, strLName, isCompany)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "CustomerCheck", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return dscustExist
        End Function


        Public Sub GetToken()
            Dim tokjs As String = PostTokenRequest(user1, pass, vehicleurl + "login")
            If tokjs.Length > 0 Then
                If (tokjs.Contains("{")) Then
                    'Dim svar = JsonConvert.DeserializeAnonymousType(jj, New With {Dim token_type As String, token As String, expires_at As String, message As String, errors As String))
                    Dim svar = JsonConvert.DeserializeAnonymousType(tokjs, New With {Key .token_type = "", .token = "", .expires_at = "", .message = "", .errors = ""})
                    tokenType = svar.token_type
                    token = svar.token
                    expires = svar.expires_at
                    message = svar.message
                    errors = svar.errors

                    'If (Not String.IsNullOrEmpty(message)) Then
                    '    lblMessage.Text = message + "\r\n" + errors
                    'Else
                    '    lblMessage.Text = jj
                    'End If

                End If
            End If


        End Sub
        Public Function PostTokenRequest(_user As String, _password As String, _endpoint As String)
            Try
                Dim json As String = ""
                Dim req As WebRequest = WebRequest.Create(_endpoint)
                Dim postData As String = "email=" + _user + "&" + "password=" + _password
                Dim postDataBytes As Byte() = Encoding.UTF8.GetBytes(postData)
                req.ContentType = "application/x-www-form-urlencoded"
                req.Method = "POST"

                'ServicePointManager.SecurityProtocol Or= SecurityProtocolType.Tls12 Or SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls;

                Using stream1 As Stream = req.GetRequestStream()
                    stream1.Write(postDataBytes, 0, postDataBytes.Length)
                End Using

                Dim respo As WebResponse = req.GetResponse()
                Dim Res As Stream = respo.GetResponseStream()

                Using reader As StreamReader = New StreamReader(Res)
                    json = reader.ReadToEnd()
                End Using

                Return json
            Catch ex As Exception
                Return "Error: " + ex.Message
            End Try
        End Function
        Private Function GetVehData(regno As String, reginfo As Boolean, pkkinfo As Boolean, techinfo As Boolean, prices As Boolean) As String
            Dim EndPoint As String = vehicleurl + "registration-plate/" + regno

            Dim json As String = ""
            Try
                Dim service As String = "?access="

                If (reginfo) Then
                    service += "registration_info,"
                End If

                If (pkkinfo) Then
                    service += "pkk,"
                End If

                If (techinfo) Then
                    service += "technical_data,"
                End If

                If (prices) Then
                    service += "prices,"
                End If

                service = service.Remove(service.Length - 1, 1)

                Dim uri As Uri = New Uri(EndPoint + service)

                Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
                req.ContentType = "application/xml"
                req.Method = "GET"
                req.Headers.Add("authorization", tokenType + " " + token)
                ServicePointManager.Expect100Continue = True
                'ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls

                Dim Res As WebResponse = req.GetResponse()
                Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                    json = reader.ReadToEnd()
                End Using

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Vehicle", "GetVehData", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return json.ToString()
        End Function
    End Class

    Public Class Rootobject
        Public Property registration_info As Registration_Info
    End Class

    Public Class Registration_Info
        Public Property reg_nr As String
        Public Property eier_for_etter_org_navn As String
        Public Property eier_etternavn As String
        Public Property eier_fornavn As String
        Public Property eier_mellomnavn As String
        Public Property fodsel_org_nr As Integer
        Public Property status_eier_dod_folkeregister As String
        Public Property eier_adresse As String
        Public Property eier_postnr As Integer
        Public Property eier_poststed As String
        Public Property eier_kommune_nummer As Integer
        Public Property eier_fylke As String
        Public Property medeier_navn As String
        Public Property medeier_etternavn As String
        Public Property medeier_fornavn As String
        Public Property medeier_mellomnavn As String
        Public Property medeier_fodsel_org_nr As String
        Public Property medeier_adressee As String
        Public Property medeier_postnr As String
        Public Property medeier_poststed As String
        Public Property leasingtaker_navn As String
        Public Property leasingtaker_etternavn As String
        Public Property leasingtaker_fornavn As String
        Public Property leasingtaker_mellomnavn As String
        Public Property leasingtaker_fodsel_onr As String
        Public Property leasingtaker_addresse As String
        Public Property leasingtaker_postnr As String
        Public Property leasingtaker_poststed As String
        Public Property merkenavn As String
        Public Property modellnavn As String
    End Class

End Namespace
