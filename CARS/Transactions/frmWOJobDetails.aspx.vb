Imports System.Web.Services
Imports CARS.CoreLibrary
Imports CARS.CoreLibrary.CARS
Imports System.Web.Security
Imports System.Web.UI
Imports Encryption
Imports System.Math
Imports Newtonsoft.Json
Imports System.Reflection
Imports System.Windows.Forms
Imports System.IO
Imports System
Imports System.Threading
Imports DotNetDLL
Imports System.Net
Imports System.Xml.Serialization
Imports System.Xml
Imports System.Data.SqlClient
Imports CARS.CoreLibrary.CARS.Services
Imports System.Globalization
Imports DevExpress.XtraReports.Web
Imports CARS.CoreLibrary.StockQuantityBO
Imports Newtonsoft.Json.Linq

Public Class frmWOJobDetails
    Inherits System.Web.UI.Page
    Shared commonUtil As New Utilities.CommonUtility
    Shared loginName As String
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared dtCaption As DataTable
    Shared details As New List(Of WOJobDetailBO)()
    Shared objWOJServ As New Services.WOJobDetails.WOJobDetails
    Shared objWOJDetailsBO As New CARS.CoreLibrary.WOJobDetailBO
    Shared objServCustomer As New Services.Customer.CustomerDetails
    Shared objWOJobDetailsDO As New CARS.CoreLibrary.CARS.WOJobDetailDO.WOJobDetailDO
    Shared objWOHeaderBO As New CARS.CoreLibrary.WOHeaderBO
    Shared objWOHeaderDO As New CARS.CoreLibrary.CARS.WOHeader.WOHeaderDO
    Shared objEnumsBO As New CARS.CoreLibrary.Enums
    Dim objuserper As New UserAccessPermissionsBO
    Shared objConfigUserBO As New CARS.CoreLibrary.ConfigUsersBO
    Shared objConfigUserDO As New ConfigUsers.ConfigUsersDO
    Shared objUserService As New CARS.CoreLibrary.CARS.Services.ConfigUsers.Users
    Shared detailUser As New List(Of ConfigUsersBO)()
    Shared objInvDetDO As New CARS.CoreLibrary.CARS.InvDetailDO.InvDetailDO
    Shared WShop As New Verksted("WEBCAS") 'Lager en ny instans av DotNetLib.dll.Verksted, med kundens distkode
    Shared sqlConnectionString As String
    Shared sqlConnection As SqlClient.SqlConnection
    Shared sqlCommand As SqlClient.SqlCommand
    Shared bargainSmsApi As String = "https://cars-web-api-production.herokuapp.com/api/v3/quote/"
    Shared POservice As New Services.PurchaseOrder.PurchaseOrder
    Shared POheaderBO As New PurchaseOrderHeaderBO
    Shared objPODO As New PurchaseOrderDO
    Shared objRepPackSer As New Services.RepPackage.RepPackage()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        EnableViewState = False
        sqlConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        sqlConnection = New SqlClient.SqlConnection(sqlConnectionString)
        hdnPageSize.Value = System.Configuration.ConfigurationManager.AppSettings("PageSize")
        'Session("Decimal_Seperator") = ConfigurationManager.AppSettings.Get("ReportDecimalSeperator").ToString()
        If Session("UserID") Is Nothing Or Session("UserPageperDT") Is Nothing Then
            Response.Redirect("~/frmLogin.aspx")
        Else
            loginName = CType(Session("UserID"), String)
        End If
        Dim ordDate As String
        ordDate = Date.Now.ToString 'objCommonUtil.GetCurrentLanguageDate(dsReturnVal.regFoerstegNorge)
        RTlblOrderDate.Text = commonUtil.GetCurrentLanguageDate(ordDate)
        'hdnPageSize.Value = System.Configuration.ConfigurationManager.AppSettings("PageSize")
        'If Not IsPostBack Then
        Dim idWoNo As String = Request.QueryString("Wonumber")
        Dim idWoPr As String = Request.QueryString("WOPrefix")
        dtCaption = DirectCast(Cache("Caption"), System.Data.DataTable)
        hdnSelect.Value = dtCaption.Select("TAG='select'")(0)(1)

        WShop.serviceEndpoint = "http://www.carsweb.no/CarsService/CarsService.Verksted.svc?wsdl"  'Setter endpoint for GlobalServicen
    End Sub
    Shared Sub ConstructInvBasisXml(ByVal idWoNo As String, ByVal idWoPr As String)
        Dim dsWOJobs As New DataSet 'No of Jobs
        Dim dtWOJobs As New DataTable 'No of Jobs
        Dim dsWODetails As New DataSet  'Job Number and totals
        Dim dtWODetails As New DataTable 'Job Number and totals
        Dim strJobNo As String
        Dim InvoiceListXML As String = ""
        objWOHeaderBO.Id_WO_NO = idWoNo
        objWOHeaderBO.Id_WO_Prefix = idWoPr
        objWOHeaderBO.Created_By = loginName
        dsWOJobs = objWOHeaderDO.Fetch_WOHeader(objWOHeaderBO)
        If (dsWOJobs.Tables.Count > 0) Then
            dtWOJobs = dsWOJobs.Tables(3)

            If (dtWOJobs.Rows.Count > 0) Then
                For Each dtwojobsrow As DataRow In dtWOJobs.Rows
                    Dim details As New List(Of WOJobDetailBO)()
                    strJobNo = dtwojobsrow("Id_Job").ToString()
                    objWOJDetailsBO.Id_Job = strJobNo
                    objWOJDetailsBO.Id_WO_NO = idWoNo
                    objWOJDetailsBO.Id_WO_Prefix = idWoPr
                    dsWODetails = objWOJobDetailsDO.WorkDetails(objWOJDetailsBO)
                    If dsWODetails.Tables.Count > 0 Then
                        dtWODetails = dsWODetails.Tables(0)
                        For Each dtwodetrow As DataRow In dtWODetails.Rows
                            InvoiceListXML += "<INV_GENERATE " _
                            + " ID_WO_PREFIX=""" + commonUtil.ConvertStr(idWoPr) + """ " _
                            + " ID_WO_NO=""" + commonUtil.ConvertStr(idWoNo) + """ " _
                            + " ID_WODET_SEQ=""" + commonUtil.ConvertStr(dtwodetrow("ID_WODET_SEQ")) + """ " _
                            + " ID_JOB_DEB=""" + commonUtil.ConvertStr(dtwodetrow("ID_JOB_DEB")) + """ " _
                            + " FLG_BATCH=""" + commonUtil.ConvertStr(dtwodetrow("FLG_CUST_BATCHINV")) + """ " _
                            + " IV_DATE =""" + "" + """ " _
                         + "/>"
                        Next
                    End If
                Next
            End If
        End If

        InvoiceListXML = "<ROOT>" + InvoiceListXML + "</ROOT>"
        HttpContext.Current.Session("xmlInvNos") = InvoiceListXML
        HttpContext.Current.Session("RptType") = "INVOICEBASIS"


    End Sub
    Shared Sub ConstructInvoiceXml(ByVal idWoNo As String, ByVal idWoPr As String)
        Dim dsWOJobs As New DataSet 'No of Jobs
        Dim dtWOJobs As New DataTable 'No of Jobs
        Dim dsWODetails As New DataSet  'Job Number and totals
        Dim dtWODetails As New DataTable 'Job Number and totals
        Dim strJobNo As String
        Dim InvoiceListXML As String = ""
        Dim strRetVal As String = ""
        Dim strInvLstXml As String = ""
        objWOHeaderBO.Id_WO_NO = idWoNo
        objWOHeaderBO.Id_WO_Prefix = idWoPr
        objWOHeaderBO.Created_By = loginName
        dsWOJobs = objWOHeaderDO.Fetch_WOHeader(objWOHeaderBO)
        If (dsWOJobs.Tables.Count > 0) Then
            dtWOJobs = dsWOJobs.Tables(3)

            If (dtWOJobs.Rows.Count > 0) Then
                For Each dtwojobsrow As DataRow In dtWOJobs.Rows
                    Dim details As New List(Of WOJobDetailBO)()
                    strJobNo = dtwojobsrow("Id_Job").ToString()
                    objWOJDetailsBO.Id_Job = strJobNo
                    objWOJDetailsBO.Id_WO_NO = idWoNo
                    objWOJDetailsBO.Id_WO_Prefix = idWoPr
                    dsWODetails = objWOJobDetailsDO.WorkDetails(objWOJDetailsBO)
                    If dsWODetails.Tables.Count > 0 Then
                        dtWODetails = dsWODetails.Tables(0)
                        For Each dtwodetrow As DataRow In dtWODetails.Rows
                            InvoiceListXML += "<INV_GENERATE " _
                            + " ID_WO_PREFIX=""" + commonUtil.ConvertStr(idWoPr) + """ " _
                            + " ID_WO_NO=""" + commonUtil.ConvertStr(idWoNo) + """ " _
                            + " ID_WODET_SEQ=""" + commonUtil.ConvertStr(dtwodetrow("ID_WODET_SEQ")) + """ " _
                            + " ID_JOB_DEB=""" + commonUtil.ConvertStr(dtwodetrow("ID_JOB_DEB")) + """ " _
                            + " FLG_BATCH=""" + commonUtil.ConvertStr(dtwodetrow("FLG_CUST_BATCHINV")) + """ " _
                            + " IV_DATE =""" + "" + """ " _
                         + "/>"
                        Next
                    End If
                Next
            End If
        End If

        InvoiceListXML = "<ROOT>" + InvoiceListXML + "</ROOT>"
        strRetVal = objInvDetDO.Generate_Invoices_Intermediate(InvoiceListXML, loginName, strInvLstXml)
        strInvLstXml = strInvLstXml.Replace("INVNO", "ID_INV_NO")
        HttpContext.Current.Session("xmlInvNos") = strInvLstXml
        HttpContext.Current.Session("RptType") = "INVOICE"


    End Sub

    <WebMethod()>
    Public Shared Function FetchJoBNo(ByVal idWONO As String, ByVal idWOPrefix As String, ByVal userId As String) As String
        Dim strJobNo As String

        Try
            objWOJDetailsBO.Id_WO_NO = idWONO
            objWOJDetailsBO.Id_WO_Prefix = idWOPrefix
            objWOJDetailsBO.Created_By = userId

            strJobNo = objWOJServ.FetchJobNo(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "FetchJoBNo", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strJobNo
    End Function
    <WebMethod()>
    Public Shared Function BindGrid(ByVal idWONO As String, ByVal idWOPrefix As String, ByVal userId As String) As WOJobDetailBO()
        Try
            objWOJDetailsBO.Id_WO_NO = idWONO
            objWOJDetailsBO.Id_WO_Prefix = idWOPrefix
            objWOJDetailsBO.Created_By = userId
            details = objWOJServ.BindGrid(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadPriceCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function GetSpares(ByVal spName As String, ByVal idCustomer As String, ByVal vehId As String) As WOJobDetailBO()
        Dim details As New List(Of WOJobDetailBO)()
        Try
            If (spName.Length >= 3) Then
                objWOJDetailsBO.Id_Item = spName
                objWOJDetailsBO.Id_Customer = idCustomer
                objWOJDetailsBO.WO_Id_Veh = vehId
                objWOJDetailsBO.Created_By = loginName
                details = objWOJServ.Fetch_Spares(objWOJDetailsBO)
            End If
        Catch exth As System.Threading.ThreadAbortException
            Throw exth
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "GetSpares", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function GetSparesList(ByVal spName As String, ByVal idCustomer As String, ByVal vehId As String, ByVal make As String, ByVal supplier As String, ByVal location As String, ByVal FlgstockItem As String, ByVal FlgStockItemStatus As String, ByVal FlgNonStockItemStatus As String) As WOJobDetailBO()
        Dim details As New List(Of WOJobDetailBO)()
        Try
            If (spName.Length >= 3) Then
                objWOJDetailsBO.Id_Item = spName
                objWOJDetailsBO.Id_Customer = idCustomer
                objWOJDetailsBO.WO_Id_Veh = vehId
                objWOJDetailsBO.Sp_Make = make
                objWOJDetailsBO.SP_SupplierID = supplier
                objWOJDetailsBO.Sp_Location = location
                objWOJDetailsBO.Sp_FlgStockItem = FlgstockItem
                objWOJDetailsBO.SP_FlgStockItemStatus = FlgStockItemStatus
                objWOJDetailsBO.SP_FlgNonStockItemStatus = FlgNonStockItemStatus
                objWOJDetailsBO.Created_By = loginName
                details = objWOJServ.Fetch_SparesList(objWOJDetailsBO)
            End If
        Catch exth As System.Threading.ThreadAbortException
            Throw exth
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "GetSpares", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function AddSpareLine(ByVal idWONO As String, ByVal idWOPrefix As String) As WOJobDetailBO()
        Try
            details = objWOJServ.AddSpareLine(idWONO, idWOPrefix)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "AddSpareLine", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function LoadHourlyPrice(ByVal idCust As String, ByVal userid As String, ByVal idMakeRP As String, ByVal idRPPCD_Hp As String, ByVal jobPCD_Hp As String, ByVal vehGrp As String, ByVal jobId As String, ByVal chkChrgStdTime As String, ByVal hpmode As String) As WOJobDetailBO()
        Try
            objWOJDetailsBO.Id_Customer = idCust 'HttpContext.Current.Session("IdCustomer")
            objWOJDetailsBO.Created_By = userid
            objWOJDetailsBO.Id_Make_Rp = IIf(idMakeRP = "", HttpContext.Current.Session("ID_MAKE_HP"), idMakeRP)
            objWOJDetailsBO.Id_RpPcd_Hp = IIf(idRPPCD_Hp = "", Nothing, idRPPCD_Hp)
            objWOJDetailsBO.Id_Jobpcd_WO = IIf(jobPCD_Hp = "", Nothing, jobPCD_Hp)
            objWOJDetailsBO.Veh_Grp = HttpContext.Current.Session("VehGroup")
            details = objWOJServ.FetchHourlyPrice(objWOJDetailsBO, hpmode)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadHourlyPrice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function LoadConfig(ByVal idWONO As String, ByVal idWOPrefix As String, ByVal userId As String, ByVal idMakeRP As String, ByVal idModelRP As String, ByVal idJob As String) As Collection
        Dim dtConfig As New Collection
        Try

            objWOJDetailsBO.Id_WO_NO = idWONO
            objWOJDetailsBO.Id_WO_Prefix = idWOPrefix
            objWOJDetailsBO.Created_By = userId
            objWOJDetailsBO.Id_Make_Rp = idMakeRP
            objWOJDetailsBO.Id_Model_Rp = idModelRP
            objWOJDetailsBO.Id_Job = idJob

            dtConfig = objWOJServ.Load_ConfigDetails(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadConfig", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return dtConfig
    End Function
    <WebMethod()>
    Public Shared Function LoadGMHPVat(ByVal idCust As String, ByVal idVehSeq As String, ByVal idItem As String, ByVal idMake As String) As WOJobDetailBO()
        Try
            objWOJDetailsBO.Id_Customer = idCust
            objWOJDetailsBO.WO_Id_Veh = idVehSeq
            objWOJDetailsBO.Id_Gm_Vat = HttpContext.Current.Session("ID_GMVAT")
            objWOJDetailsBO.Id_Hp_Vat = HttpContext.Current.Session("ID_HPVAT")
            objWOJDetailsBO.Id_Item = idItem
            objWOJDetailsBO.Id_Make = idMake
            details = objWOJServ.LoadGMHPVat(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadHourlyPrice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function GetSpareById(ByVal spName As String, ByVal idCustomer As String, ByVal vehId As String) As WOJobDetailBO()
        Dim details As New List(Of WOJobDetailBO)()
        Try
            'If (spName.Length >= 3) Then
            objWOJDetailsBO.Id_Item = spName
            objWOJDetailsBO.Id_Customer = idCustomer '"16525" 'HttpContext.Current.Session("IdCustomer") ' custId
            objWOJDetailsBO.WO_Id_Veh = vehId '"7508" 'HttpContext.Current.Session("Veh_Seq_No") 'vehId
            objWOJDetailsBO.Created_By = loginName
            details = objWOJServ.Get_Spare(objWOJDetailsBO)
            'End If
        Catch exth As System.Threading.ThreadAbortException
            Throw exth
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "GetSpares", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function LoadRepairCode() As WOJobDetailBO()
        Try
            details = objWOJServ.Load_RepairCode()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadRepairCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function LoadWorkCode() As WOJobDetailBO()
        Try
            details = objWOJServ.Load_WorkCode()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadWorkCode", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function SaveJobDet(ByVal jobIdXmls As String, ByVal spareXmls As String, ByVal discXmls As String, ByVal mechXmls As String, ByVal idWODetSeq As String, ByVal idWONO As String, ByVal idWOPrefix As String,
        ByVal idRpgCatgWO As String, ByVal idRpgCodeWO As String, ByVal idRepCodeWO As String, ByVal idWorkCodeWO As String, ByVal woFixedPrice As String, ByVal idJobPcdWO As String, ByVal woPlannedTime As String,
        ByVal woHourleyPrice As String, ByVal woClkTime As String, ByVal woChrgTime As String, ByVal flgChrgStdTime As String, ByVal woStdTime As String, ByVal statReq As String, ByVal woJobTxt As String,
        ByVal woOwnRiskAmt As String, ByVal woTotLabAmt As String, ByVal woTotSpareAmt As String, ByVal woTotGmAmt As String, ByVal woTotVatAmt As String, ByVal woTotDiscAmt As String, ByVal jobStatus As String,
        ByVal woOwnPayVat As String, ByVal idDefectNoteSeq As String, ByVal totalamt As String, ByVal idMechComp As String, ByVal woOwnRiskCust As String, ByVal woOwnCrCust As String,
        ByVal idSerCallNo As String, ByVal woGmPer As String, ByVal woGmVatPer As String, ByVal woLbrVatPer As String, ByVal woInclVat As String, ByVal woDiscount As String, ByVal subrepCodeWO As String,
        ByVal ownriskvat As String, ByVal flgSprsts As String, ByVal salesman As String, ByVal flgVatFree As String, ByVal costPrice As String, ByVal finalTotal As String, ByVal finalVat As String, ByVal finalDiscount As String,
        ByVal woChrgTimeFp As String, ByVal woTotLabAmtFp As String, ByVal woTotSpareAmtFp As String, ByVal woTotGmAmtFp As String, ByVal woTotVatAmtFp As String, ByVal woTotDiscAmtFp As String,
        ByVal woIntNote As String, ByVal idJob As String, ByVal flgawaitingSp As String, ByVal mode As String, ByVal idMech As String, ByVal woOwnRiskDesc As String, ByVal woOwnRiskSlNo As String) As String()
        Dim strResult As String()
        Dim WO_Own_Risk_Amt, WO_Tot_Lab_Amt, WO_Tot_Spare_Amt, WO_Tot_Gm_Amt, WO_Tot_Vat_Amt, WO_Tot_Disc_Amt As String
        Try

            WO_Own_Risk_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woOwnRiskAmt = "", 0D, woOwnRiskAmt))
            WO_Tot_Lab_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotLabAmt = "", 0D, woTotLabAmt))
            WO_Tot_Spare_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotSpareAmt = "", 0D, woTotSpareAmt))
            WO_Tot_Gm_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotGmAmt = "", 0D, woTotGmAmt))
            WO_Tot_Vat_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotVatAmt = "", 0D, woTotVatAmt))

            WO_Tot_Disc_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotDiscAmt = "", 0D, woTotDiscAmt))

            objWOJDetailsBO.Id_Wodet_Seq = idWODetSeq
            objWOJDetailsBO.Id_WO_NO = idWONO 'pass as parameter
            objWOJDetailsBO.Id_WO_Prefix = idWOPrefix 'pass as parameter
            objWOJDetailsBO.Id_Rpg_Catg_WO = Nothing
            objWOJDetailsBO.Id_Rpg_Code_WO = Nothing
            objWOJDetailsBO.Id_Rep_Code_WO = IIf(idRepCodeWO = "", 1, idRepCodeWO)
            objWOJDetailsBO.Id_Work_Code_WO = idWorkCodeWO
            objWOJDetailsBO.WO_Fixed_Price = IIf(woFixedPrice = "", 0, woFixedPrice)
            objWOJDetailsBO.Id_Jobpcd_WO = idJobPcdWO
            objWOJDetailsBO.WO_Planned_Time = "0"
            objWOJDetailsBO.WO_Hourley_Price = woHourleyPrice
            objWOJDetailsBO.WO_Clk_Time = woClkTime
            objWOJDetailsBO.WO_Chrg_Time = woChrgTime
            objWOJDetailsBO.Flg_Chrg_Std_Time = flgChrgStdTime
            objWOJDetailsBO.WO_Std_Time = woStdTime
            objWOJDetailsBO.Flg_Stat_Req = IIf(statReq = "", 0, statReq)
            objWOJDetailsBO.WO_Job_Txt = "" 'pass as parameter
            objWOJDetailsBO.WO_Own_Risk_Amt = Convert.ToDecimal(WO_Own_Risk_Amt)
            objWOJDetailsBO.WO_Tot_Lab_Amt = Convert.ToDecimal(WO_Tot_Lab_Amt)
            objWOJDetailsBO.WO_Tot_Spare_Amt = Convert.ToDecimal(WO_Tot_Spare_Amt)
            objWOJDetailsBO.WO_Tot_Gm_Amt = Convert.ToDecimal(WO_Tot_Gm_Amt)
            objWOJDetailsBO.WO_Tot_Vat_Amt = Convert.ToDecimal(WO_Tot_Vat_Amt)
            objWOJDetailsBO.WO_Tot_Disc_Amt = Convert.ToDecimal(WO_Tot_Disc_Amt)
            objWOJDetailsBO.Job_Status = jobStatus
            objWOJDetailsBO.Created_By = loginName
            objWOJDetailsBO.Dt_Created = Now
            objWOJDetailsBO.WO_Own_Pay_Vat = woOwnPayVat
            'objWOJobDetailsBO.Dis_Doc
            objWOJDetailsBO.Id_Def_Seq = idDefectNoteSeq
            objWOJDetailsBO.Tot_Amount = IIf(totalamt = "", 0, totalamt)
            'objWOJDetailsBO.Mechanic_Doc
            objWOJDetailsBO.Mech_Compt_Description = idMechComp
            objWOJDetailsBO.WO_Own_Risk_Cust = woOwnRiskCust
            objWOJDetailsBO.WO_Own_Cr_Cust = woOwnCrCust
            objWOJDetailsBO.Id_Ser_Call = idSerCallNo
            objWOJDetailsBO.WO_Gm_Per = woGmPer
            objWOJDetailsBO.WO_Gm_Vatper = woGmVatPer
            objWOJDetailsBO.WO_Lbr_Vatper = woLbrVatPer
            objWOJDetailsBO.Bus_Pek_Control_Num = ""
            objWOJDetailsBO.WO_PKKDate = Nothing
            objWOJDetailsBO.WO_Incl_Vat = woInclVat
            If (woDiscount = "undefined") Then
                objWOJDetailsBO.WO_Discount = 0
            Else
                objWOJDetailsBO.WO_Discount = IIf(woDiscount = "", 0, woDiscount)
            End If
            objWOJDetailsBO.Id_Subrep_Code_WO = IIf(subrepCodeWO = "", 0, subrepCodeWO)
            objWOJDetailsBO.WO_Ownriskvat = IIf(ownriskvat = "", 0, ownriskvat)
            objWOJDetailsBO.Flg_Sprsts = flgawaitingSp
            objWOJDetailsBO.Salesman = "" 'VA Orders
            objWOJDetailsBO.Flg_Vat_Free = "0" 'VA Orders
            objWOJDetailsBO.Cost_Price = costPrice
            objWOJDetailsBO.Final_Total = IIf(finalTotal = "", 0, finalTotal)
            objWOJDetailsBO.Final_Vat = IIf(finalVat = "", 0, finalVat)
            objWOJDetailsBO.Final_Discount = finalDiscount
            objWOJDetailsBO.Id_Job = idJob
            objWOJDetailsBO.WO_Chrg_Time_Fp = woChrgTimeFp
            objWOJDetailsBO.WO_Tot_Lab_Amt_Fp = IIf(woTotLabAmtFp = "", 0, woTotLabAmtFp)
            objWOJDetailsBO.WO_Tot_Spare_Amt_Fp = IIf(woTotSpareAmtFp = "", 0, woTotSpareAmtFp)
            objWOJDetailsBO.WO_Tot_Gm_Amt_Fp = IIf(woTotGmAmtFp = "", 0, woTotGmAmtFp)
            objWOJDetailsBO.WO_Tot_Vat_Amt_Fp = IIf(woTotVatAmtFp = "", 0, woTotVatAmtFp)
            objWOJDetailsBO.WO_Tot_Disc_Amt_Fp = IIf(woTotDiscAmtFp = "", 0, woTotDiscAmtFp)
            objWOJDetailsBO.WO_Int_Note = woIntNote
            objWOJDetailsBO.Id_Job_Deb = woOwnRiskCust 'pass customer
            objWOJDetailsBO.Job_Doc = IIf(spareXmls = "", Nothing, spareXmls)
            objWOJDetailsBO.WO_Doc = IIf(jobIdXmls = "", Nothing, jobIdXmls)
            objWOJDetailsBO.Dis_Doc = IIf(discXmls = "", Nothing, discXmls)
            objWOJDetailsBO.Mechanic_Doc = IIf(mechXmls = "", Nothing, mechXmls)
            objWOJDetailsBO.IdMech = IIf(idMech = "undefined", "", idMech)
            objWOJDetailsBO.WO_Own_Risk_Desc = woOwnRiskDesc
            objWOJDetailsBO.WO_Own_Risk_SlNo = woOwnRiskSlNo
            strResult = objWOJServ.Save_GridJobDetails(objWOJDetailsBO, mode)
            'ConstructInvBasisXml(idWONO, idWOPrefix)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "saveJobDet", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function Get_vat_Dis(ByVal idItem As String, ByVal idJobDeb As String, ByVal idVeh As String, ByVal idMake As String, ByVal idWh As String) As String
        Dim discSeq As String
        Try
            objWOJDetailsBO.Created_By = loginName
            objWOJDetailsBO.Id_Job_Deb = idJobDeb
            objWOJDetailsBO.Id_Item_Job = idItem
            objWOJDetailsBO.WO_Id_Veh = idVeh
            objWOJDetailsBO.Id_Make = idMake
            objWOJDetailsBO.Id_Wh_Item = idWh

            discSeq = objWOJobDetailsDO.Get_vat_Dis(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "Get_vat_Dis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return discSeq
    End Function
    <WebMethod()>
    Public Shared Function Fetch_Sp_Make(ByVal q As String) As WOJobDetailBO()
        Dim makeDetails As New List(Of WOJobDetailBO)()
        Try
            makeDetails = objWOJServ.FetchSpareMake(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "Fetch_Sp_Make", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return makeDetails.ToList.ToArray
    End Function
    <WebMethod()>
    Public Shared Function Fetch_Sp_Supplier(ByVal q As String) As WOJobDetailBO()
        Dim makeDetails As New List(Of WOJobDetailBO)()
        Try
            makeDetails = objWOJServ.FetchSpareSupplier(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "Fetch_Sp_Make", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return makeDetails.ToList.ToArray
    End Function
    <WebMethod()>
    Public Shared Function Fetch_Sp_Location(ByVal q As String) As WOJobDetailBO()
        Dim makeDetails As New List(Of WOJobDetailBO)()
        Try
            makeDetails = objWOJServ.FetchSpareLocation(q)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "Fetch_Sp_Make", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return makeDetails.ToList.ToArray
    End Function
    <WebMethod()>
    Public Shared Function Load_WorkOrderDetails(ByVal idWONO As String, ByVal idWOPrefix As String) As WOJobDetailBO()
        Try
            objWOJDetailsBO.Id_WO_NO = idWONO
            objWOJDetailsBO.Id_WO_Prefix = idWOPrefix
            objWOJDetailsBO.Created_By = loginName
            details = objWOJServ.LoadWorkOrderDetails(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "Load_WorkOrderDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function DeleteSaveJobDet(ByVal jobIdXmls As String, ByVal spareXmls As String, ByVal discXmls As String, ByVal mechXmls As String, ByVal idWODetSeq As String, ByVal idWONO As String, ByVal idWOPrefix As String,
        ByVal idRpgCatgWO As String, ByVal idRpgCodeWO As String, ByVal idRepCodeWO As String, ByVal idWorkCodeWO As String, ByVal woFixedPrice As String, ByVal idJobPcdWO As String, ByVal woPlannedTime As String,
        ByVal woHourleyPrice As String, ByVal woClkTime As String, ByVal woChrgTime As String, ByVal flgChrgStdTime As String, ByVal woStdTime As String, ByVal statReq As String, ByVal woJobTxt As String,
        ByVal woOwnRiskAmt As String, ByVal woTotLabAmt As String, ByVal woTotSpareAmt As String, ByVal woTotGmAmt As String, ByVal woTotVatAmt As String, ByVal woTotDiscAmt As String, ByVal jobStatus As String,
        ByVal woOwnPayVat As String, ByVal idDefectNoteSeq As String, ByVal totalamt As String, ByVal idMechComp As String, ByVal woOwnRiskCust As String, ByVal woOwnCrCust As String,
        ByVal idSerCallNo As String, ByVal woGmPer As String, ByVal woGmVatPer As String, ByVal woLbrVatPer As String, ByVal woInclVat As String, ByVal woDiscount As String, ByVal subrepCodeWO As String,
        ByVal ownriskvat As String, ByVal flgSprsts As String, ByVal salesman As String, ByVal flgVatFree As String, ByVal costPrice As String, ByVal finalTotal As String, ByVal finalVat As String, ByVal finalDiscount As String,
        ByVal woChrgTimeFp As String, ByVal woTotLabAmtFp As String, ByVal woTotSpareAmtFp As String, ByVal woTotGmAmtFp As String, ByVal woTotVatAmtFp As String, ByVal woTotDiscAmtFp As String,
        ByVal woIntNote As String, ByVal idJob As String, ByVal flgawaitingSp As String, ByVal mode As String, ByVal idMech As String, ByVal woOwnRiskDesc As String, ByVal woOwnRiskSlNo As String) As String()
        Dim strResult As String()
        Dim WO_Own_Risk_Amt, WO_Tot_Lab_Amt, WO_Tot_Spare_Amt, WO_Tot_Gm_Amt, WO_Tot_Vat_Amt, WO_Tot_Disc_Amt As String
        Try

            WO_Own_Risk_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woOwnRiskAmt = "", 0D, woOwnRiskAmt))
            WO_Tot_Lab_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotLabAmt = "", 0D, woTotLabAmt))
            WO_Tot_Spare_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotSpareAmt = "", 0D, woTotSpareAmt))
            WO_Tot_Gm_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotGmAmt = "", 0D, woTotGmAmt))
            WO_Tot_Vat_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotVatAmt = "", 0D, woTotVatAmt))
            WO_Tot_Disc_Amt = commonUtil.GetCurrentLanguageNoFormat(CType(HttpContext.Current.Session("Current_Language"), String), IIf(woTotDiscAmt = "", 0D, woTotDiscAmt))

            objWOJDetailsBO.Id_Wodet_Seq = idWODetSeq
            objWOJDetailsBO.Id_WO_NO = idWONO 'pass as parameter
            objWOJDetailsBO.Id_WO_Prefix = idWOPrefix 'pass as parameter
            objWOJDetailsBO.Id_Rpg_Catg_WO = Nothing
            objWOJDetailsBO.Id_Rpg_Code_WO = Nothing
            objWOJDetailsBO.Id_Rep_Code_WO = IIf(idRepCodeWO = "", 1, idRepCodeWO)
            objWOJDetailsBO.Id_Work_Code_WO = idWorkCodeWO
            objWOJDetailsBO.WO_Fixed_Price = IIf(woFixedPrice = "", 0, woFixedPrice)
            objWOJDetailsBO.Id_Jobpcd_WO = idJobPcdWO
            objWOJDetailsBO.WO_Planned_Time = "0"
            objWOJDetailsBO.WO_Hourley_Price = woHourleyPrice
            objWOJDetailsBO.WO_Clk_Time = woClkTime
            objWOJDetailsBO.WO_Chrg_Time = woChrgTime
            objWOJDetailsBO.Flg_Chrg_Std_Time = flgChrgStdTime
            objWOJDetailsBO.WO_Std_Time = woStdTime
            objWOJDetailsBO.Flg_Stat_Req = IIf(statReq = "", 0, statReq)
            objWOJDetailsBO.WO_Job_Txt = "" 'pass as parameter
            objWOJDetailsBO.WO_Own_Risk_Amt = Convert.ToDecimal(WO_Own_Risk_Amt)
            objWOJDetailsBO.WO_Tot_Lab_Amt = Convert.ToDecimal(WO_Tot_Lab_Amt)
            objWOJDetailsBO.WO_Tot_Spare_Amt = Convert.ToDecimal(WO_Tot_Spare_Amt)
            objWOJDetailsBO.WO_Tot_Gm_Amt = Convert.ToDecimal(WO_Tot_Gm_Amt)
            objWOJDetailsBO.WO_Tot_Vat_Amt = Convert.ToDecimal(WO_Tot_Vat_Amt)
            objWOJDetailsBO.WO_Tot_Disc_Amt = Convert.ToDecimal(WO_Tot_Disc_Amt)
            objWOJDetailsBO.Job_Status = jobStatus
            objWOJDetailsBO.Created_By = loginName
            objWOJDetailsBO.Dt_Created = Now
            objWOJDetailsBO.WO_Own_Pay_Vat = woOwnPayVat
            'objWOJobDetailsBO.Dis_Doc
            objWOJDetailsBO.Id_Def_Seq = idDefectNoteSeq
            objWOJDetailsBO.Tot_Amount = IIf(totalamt = "", 0, totalamt)
            'objWOJDetailsBO.Mechanic_Doc
            objWOJDetailsBO.Mech_Compt_Description = idMechComp
            objWOJDetailsBO.WO_Own_Risk_Cust = woOwnRiskCust
            objWOJDetailsBO.WO_Own_Cr_Cust = woOwnCrCust
            objWOJDetailsBO.Id_Ser_Call = idSerCallNo
            objWOJDetailsBO.WO_Gm_Per = woGmPer
            objWOJDetailsBO.WO_Gm_Vatper = woGmVatPer
            objWOJDetailsBO.WO_Lbr_Vatper = woLbrVatPer
            objWOJDetailsBO.Bus_Pek_Control_Num = ""
            objWOJDetailsBO.WO_PKKDate = Nothing
            objWOJDetailsBO.WO_Incl_Vat = woInclVat
            If (woDiscount = "undefined") Then
                objWOJDetailsBO.WO_Discount = 0
            Else
                objWOJDetailsBO.WO_Discount = IIf(woDiscount = "", 0, woDiscount)
            End If
            objWOJDetailsBO.Id_Subrep_Code_WO = IIf(subrepCodeWO = "", 0, subrepCodeWO)
            objWOJDetailsBO.WO_Ownriskvat = IIf(ownriskvat = "", 0, ownriskvat)
            objWOJDetailsBO.Flg_Sprsts = flgawaitingSp
            objWOJDetailsBO.Salesman = "" 'VA Orders
            objWOJDetailsBO.Flg_Vat_Free = "0" 'VA Orders
            objWOJDetailsBO.Cost_Price = costPrice
            objWOJDetailsBO.Final_Total = IIf(finalTotal = "", 0, finalTotal)
            objWOJDetailsBO.Final_Vat = IIf(finalVat = "", 0, finalVat)
            objWOJDetailsBO.Final_Discount = finalDiscount
            objWOJDetailsBO.Id_Job = idJob
            objWOJDetailsBO.WO_Chrg_Time_Fp = woChrgTimeFp
            objWOJDetailsBO.WO_Tot_Lab_Amt_Fp = IIf(woTotLabAmtFp = "", 0, woTotLabAmtFp)
            objWOJDetailsBO.WO_Tot_Spare_Amt_Fp = IIf(woTotSpareAmtFp = "", 0, woTotSpareAmtFp)
            objWOJDetailsBO.WO_Tot_Gm_Amt_Fp = IIf(woTotGmAmtFp = "", 0, woTotGmAmtFp)
            objWOJDetailsBO.WO_Tot_Vat_Amt_Fp = IIf(woTotVatAmtFp = "", 0, woTotVatAmtFp)
            objWOJDetailsBO.WO_Tot_Disc_Amt_Fp = IIf(woTotDiscAmtFp = "", 0, woTotDiscAmtFp)
            objWOJDetailsBO.WO_Int_Note = woIntNote
            objWOJDetailsBO.Id_Job_Deb = woOwnRiskCust 'pass customer
            objWOJDetailsBO.Job_Doc = spareXmls
            objWOJDetailsBO.WO_Doc = jobIdXmls
            objWOJDetailsBO.Dis_Doc = discXmls
            objWOJDetailsBO.Mechanic_Doc = IIf(mechXmls = "", Nothing, mechXmls)
            objWOJDetailsBO.IdMech = IIf(idMech = "undefined", "", idMech)
            objWOJDetailsBO.WO_Own_Risk_Desc = woOwnRiskDesc
            objWOJDetailsBO.WO_Own_Risk_SlNo = woOwnRiskSlNo
            strResult = objWOJServ.Delete_Save_JobDetails(objWOJDetailsBO, mode)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "DeleteSaveJobDet", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function SaveSparesSett(ByVal makeIdXml As String, ByVal suppIdXmls As String, ByVal locXmls As String, ByVal FlgstockItem As String, ByVal FlgStockItemStatus As String, ByVal FlgNonStockItemStatus As String) As String
        Dim strResult As String
        Try
            objWOJDetailsBO.Id_Make = makeIdXml
            objWOJDetailsBO.Sp_Location = locXmls
            objWOJDetailsBO.SP_SupplierName = suppIdXmls
            objWOJDetailsBO.SP_FlgStockItemStatus = FlgStockItemStatus
            objWOJDetailsBO.SP_FlgNonStockItemStatus = FlgNonStockItemStatus
            objWOJDetailsBO.Sp_FlgStockItem = FlgstockItem
            objWOJDetailsBO.Created_By = loginName
            strResult = objWOJServ.SaveSpareSett(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "SaveSparesSett", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function DeleteTextline(ByVal idWoItemSeq As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim strResult As String

        Try
            objWOJDetailsBO.Id_WO_NO = idWONO
            objWOJDetailsBO.Id_WO_Prefix = idWOPrefix
            objWOJDetailsBO.Id_WOItem_Seq = idWoItemSeq

            strResult = objWOJServ.DeleteTextLine(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "FetchJoBNo", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function DeleteJobDebitor(ByVal jobIdXmls As String) As String()
        Dim strResult As String()
        Try
            objWOJDetailsBO.Id_WO_NO = jobIdXmls.ToString()
            strResult = objWOJServ.Delete_Job_Debitor(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "DeleteJobDebitor", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function FetchDelJobDet(ByVal idWoNo As String, ByVal idWoPr As String) As WOJobDetailBO()
        Try
            objWOJDetailsBO.Id_WO_NO = idWoNo
            objWOJDetailsBO.Id_WO_Prefix = idWoPr
            details = objWOJServ.FetchDeleteJob(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadHourlyPrice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function Invoice(ByVal idWoNo As String, ByVal idWoPr As String) As String()
        Dim strRetVal As String()
        Try

            objWOJDetailsBO.Id_WO_NO = idWoNo
            objWOJDetailsBO.Id_WO_Prefix = idWoPr
            'details = objWOJServ.FetchDeleteJob(objWOJDetailsBO)
            strRetVal = objWOJServ.InvoiceProcess(idWoNo, idWoPr)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "Invoice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRetVal
    End Function

    <WebMethod()>
    Public Shared Function InvoiceBasis(ByVal idWoNo As String, ByVal idWoPr As String) As String
        Dim strRetVal As String = ""
        Try
            objWOJDetailsBO.Id_WO_NO = idWoNo
            objWOJDetailsBO.Id_WO_Prefix = idWoPr
            'details = objWOJServ.FetchDeleteJob(objWOJDetailsBO)
            strRetVal = objWOJServ.InvoiceBasisProcess(idWoNo, idWoPr)

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRetVal
    End Function
    <WebMethod()>
    Public Shared Function LoadJobCard() As String
        Dim reportRequest As String = ""
        Dim rnd As New Random()
        Try
            Dim WONO As String = HttpContext.Current.Session("WONO")
            Dim WOPREFIX As String = HttpContext.Current.Session("WOPR")

            HttpContext.Current.Session("xmlInvNos") = "<ROOT><WONOPREFIX  ID_WO_PREFIX='" + commonUtil.ConvertStr(HttpContext.Current.Session("WOPR").ToString()) + "'  ID_WO_NO='" + commonUtil.ConvertStr(HttpContext.Current.Session("WONO").ToString()) + "'/></ROOT>"
            HttpContext.Current.Session("RptType") = "WOJobCard"
            reportRequest = "../Reports/frmShowReports.aspx?ReportHeader=" + commonUtil.fnEncryptQString("WOJobCard") + "&InvoiceType=" + commonUtil.fnEncryptQString("WOJobCard") + "&Rpt=" + commonUtil.fnEncryptQString("INVOICEPRINT") + "&scrid=" + rnd.Next().ToString()

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadReport", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return reportRequest
    End Function

    <WebMethod()>
    Public Shared Function LoadReport(ByVal reportType As String) As String
        Dim strVal As String = "True"
        Dim orderType As String = ""
        Dim reportRequest As String = ""
        Dim rnd As New Random()
        'Dim default_pickd As Double = 0
        Dim ds As New DataSet
        Dim dt As New DataTable
        Try
            Dim WONO As String = HttpContext.Current.Session("WONO")
            Dim WOPREFIX As String = HttpContext.Current.Session("WOPR")
            objWOHeaderBO.Id_WO_NO = WONO
            objWOHeaderBO.Id_WO_Prefix = WOPREFIX
            objWOHeaderBO.Created_By = HttpContext.Current.Session("USERID")
            Dim woHeader As DataSet = objWOHeaderDO.Fetch_WOHeader(objWOHeaderBO)
            If woHeader.Tables(0).Rows.Count > 0 Then
                orderType = woHeader.Tables(0).Rows(0)("WOH_TYPE")
                If (orderType = "CRSL") Then
                    orderType = "ORDER"
                End If
            End If

            Select Case reportType
                Case "PICKINGLIST"
                    reportRequest = "../Reports/frmShowReports.aspx?ReportHeader=" + commonUtil.fnEncryptQString("PICKINGLIST") + "&Rpt=" + commonUtil.fnEncryptQString("PICKINGLIST") + "&OrderType=" + commonUtil.fnEncryptQString(orderType) + "&scrid=" + rnd.Next().ToString()
                Case "DELIVERYNOTE"
                    reportRequest = "../Reports/frmShowReports.aspx?ReportHeader=" + commonUtil.fnEncryptQString("DELIVERYNOTE") + "&Rpt=" + commonUtil.fnEncryptQString("DELIVERYNOTE") + "&OrderType=" + commonUtil.fnEncryptQString(orderType) + "&scrid=" + rnd.Next().ToString()
                Case "WorkOrderSpares"
                    reportRequest = "../Reports/frmShowReports.aspx?ReportHeader=" + commonUtil.fnEncryptQString("WorkOrderSpares") + "&Rpt=" + commonUtil.fnEncryptQString("WorkOrderSpares") + "&scrid=" + rnd.Next().ToString()
                Case "JOBCARD"
                    HttpContext.Current.Session("xmlInvNos") = "<ROOT><WONOPREFIX  ID_WO_PREFIX='" + commonUtil.ConvertStr(HttpContext.Current.Session("WOPR").ToString()) + "'  ID_WO_NO='" + commonUtil.ConvertStr(HttpContext.Current.Session("WONO").ToString()) + "'/></ROOT>"
                    HttpContext.Current.Session("RptType") = "WOJobCard"
                    reportRequest = "../Reports/frmShowReports.aspx?ReportHeader=" + commonUtil.fnEncryptQString("WOJobCard") + "&InvoiceType=" + commonUtil.fnEncryptQString("WOJobCard") + "&Rpt=" + commonUtil.fnEncryptQString("INVOICEPRINT") + "&scrid=" + rnd.Next().ToString()
            End Select

            If (reportType = "DELIVERYNOTE") Then
                details = objWOJServ.LoadReport(reportType, reportRequest)
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadReport", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return reportRequest
    End Function


    <WebMethod()>
    Public Shared Function loadXtraCheck(ByVal refnr As String, ByVal regnr As String) As XtraCheckBO()
        Dim XtraCheckDetails As New List(Of XtraCheckBO)()
        Try
            If (refnr <> "" Or regnr <> "") Then
                XtraCheckDetails = objWOJServ.loadXtraCheck(refnr, regnr)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Master_frmVehicleDetail", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
        End Try
        Return XtraCheckDetails.ToList.ToArray

    End Function



    <WebMethod()>
    Public Shared Function SaveXtraCheck(ByVal regno As String, ByVal refno As String, ByVal motoroil As String, ByVal motoroilAnnot As String, ByVal motoroilSMS As String, ByVal cflevel As String, ByVal cflevelAnnot As String, ByVal cflevelSMS As String, ByVal cftemp As String, ByVal cftempAnnot As String, ByVal cftempSMS As String, ByVal brakefluid As String, ByVal brakefluidAnnot As String, ByVal brakefluidSMS As String, ByVal battery As String, ByVal batteryAnnot As String, ByVal batterySMS As String, ByVal vipesfront As String, ByVal vipesfrontAnnot As String, ByVal vipesfrontSMS As String, ByVal vipesrear As String, ByVal vipesrearAnnot As String, ByVal vipesrearSMS As String, ByVal lightsfront As String, ByVal lightsfrontAnnot As String, ByVal lightsfrontSMS As String, ByVal lightsrear As String, ByVal lightsrearAnnot As String, ByVal lightsrearSMS As String, ByVal shockabsorberfront As String, ByVal shockabsorberfrontAnnot As String, ByVal shockabsorberfrontSMS As String, ByVal shockabsorberrear As String, ByVal shockabsorberrearAnnot As String, ByVal shockabsorberrearSMS As String, ByVal tiresfront As String, ByVal tiresfrontAnnot As String, ByVal tiresfrontSMS As String, ByVal tiresrear As String, ByVal tiresrearAnnot As String, ByVal tiresrearSMS As String, ByVal suspensionfront As String, ByVal suspensionfrontAnnot As String, ByVal suspensionfrontSMS As String, ByVal suspensionrear As String, ByVal suspensionrearAnnot As String, ByVal suspensionrearSMS As String, ByVal brakesfront As String, ByVal brakesfrontAnnot As String, ByVal brakesfrontSMS As String, ByVal brakesrear As String, ByVal brakesrearAnnot As String, ByVal brakesrearSMS As String, ByVal exhaust As String, ByVal exhaustAnnot As String, ByVal exhaustSMS As String, ByVal sealedengine As String, ByVal sealedengineAnnot As String, ByVal sealedengineSMS As String, ByVal sealedgearbox As String, ByVal sealedgearboxAnnot As String, ByVal sealedgearboxSMS As String, ByVal generalAnnot As String) As String
        Dim strRetVal As String = ""
        Try
            strRetVal = objWOJobDetailsDO.SaveXtraCheck(regno, refno, motoroil, motoroilAnnot, motoroilSMS, cflevel, cflevelAnnot, cflevelSMS, cftemp, cftempAnnot, cftempSMS, brakefluid, brakefluidAnnot, brakefluidSMS, battery, batteryAnnot, batterySMS, vipesfront, vipesfrontAnnot, vipesfrontSMS, vipesrear, vipesrearAnnot, vipesrearSMS, lightsfront, lightsfrontAnnot, lightsfrontSMS, lightsrear, lightsrearAnnot, lightsrearSMS, shockabsorberfront, shockabsorberfrontAnnot, shockabsorberfrontSMS, shockabsorberrear, shockabsorberrearAnnot, shockabsorberrearSMS, tiresfront, tiresfrontAnnot, tiresfrontSMS, tiresrear, tiresrearAnnot, tiresrearSMS, suspensionfront, suspensionfrontAnnot, suspensionfrontSMS, suspensionrear, suspensionrearAnnot, suspensionrearSMS, brakesfront, brakesfrontAnnot, brakesfrontSMS, brakesrear, brakesrearAnnot, brakesrearSMS, exhaust, exhaustAnnot, exhaustSMS, sealedengine, sealedengineAnnot, sealedengineSMS, sealedgearbox, sealedgearboxAnnot, sealedgearboxSMS, generalAnnot)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRetVal
    End Function

    <WebMethod()>
    Public Shared Function UpdVehicle(ByVal vehicleId As String, ByVal customerId As String) As String
        Dim strRetVal As String = ""
        Try
            strRetVal = objWOJServ.UpdateVehOwner(vehicleId, customerId)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRetVal
    End Function
    <WebMethod()>
    Public Shared Function EHF(ByVal idWoNo As String, ByVal idWoPr As String) As String
        Dim strRetVal As String = ""
        Try
            strRetVal = objWOJServ.GenerateXML(idWoNo, idWoPr)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "GenerateXML", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strRetVal
    End Function


    'Public Sub VisResultat(appr As AppResponse)
    '    If String.IsNullOrEmpty(appr.error) Or appr.error = "OK" Then
    '        generalAnnotation2.Text = appr.dataToWrite
    '    Else
    '        generalAnnotation2.Text = appr.error
    '    End If
    'End Sub

    '<WebMethod()>
    'Public Shared Sub SetControlText(ByVal ctl As Windows.Forms.Control, ByVal txt As String) 'To display mobile answer on form, as answer originates from separate thread
    '    If ctl.InvokeRequired Then
    '        ctl.BeginInvoke(New Action(Of Windows.Forms.Control, String)(AddressOf SetControlText), ctl, txt)
    '    Else
    '        ctl.Text = txt
    '    End If
    'End Sub
    'Public Sub BtnXtrasjekk_Click(sender As Object, e As EventArgs) Handles btnXtrasjekken.Click
    '    'Dim appr As AppResponse = WShop.GetServiceData(servicetype, ordrenummer, regnummer, verkstednavn, verkstedtelefon, kundenavn, kundemobil, xtrasjekkpunkter.....)
    '    Dim appr As AppResponse = WShop.GetServiceData(CARS.CoreLibrary.CARS.Services.Enums.Enums.xtrasjekk, "123456", "KH83796", "WebCars", "94439070", "Martin Omnes", "41679234", "12", "15", "17", "20")
    '    'AddHandler AppSearch.ResponseReceived, AddressOf ResponsArrived 'Subscribe to AppAnswerReceived event
    '    VisResultat(appr)
    'End Sub

    <WebMethod()>
    Public Shared Function SendXtraMobile(ByVal deptId As String, ByVal senderSMS As String, ByVal userId As String, ByVal userPsw As String, ByVal smsOperatorLink As String, ByVal custMob As String, ByVal custName As String, ByVal regNo As String, ByVal orderId As String, ByVal result As String) As String
        Dim testvalue As String
        Try
            Dim appr As AppResponse = WShop.GetServiceData(objEnumsBO.xtrasjekk, orderId, regNo, senderSMS, "32242070", custName, custMob, result)
            AddHandler AppSearch.ResponseReceived, AddressOf ResponsArrived 'Subscribe to AppAnswerReceived event
            If String.IsNullOrEmpty(appr.error) Or appr.error = "OK" Then
                testvalue = appr.dataToWrite
                testvalue += "OK"
            Else
                testvalue = appr.error
            End If


        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return testvalue
    End Function

    <WebMethod()>
    Public Shared Function SendBargainMobile(ByVal deptId As String, ByVal senderSMS As String, ByVal userId As String, ByVal userPsw As String, ByVal smsOperatorLink As String, ByVal custMob As String, ByVal custName As String, ByVal regNo As String, ByVal orderId As String, ByVal result As String, ByVal text As String, ByVal amount As String) As String
        Dim testvalue As String = ""
        Try
            Dim txt = "Hei.Vi har nå sett over dekkene du har her hos oss.Det er behov for nye dekk. Foreslår å montere nye dekk med 40 % rabatt"
            'Dim appr As AppResponse = WShop.GetServiceData(servicetype, ordrenummer, regnummer, verkstednavn, verkstedtelefon, kundenavn, kundemobil, tilbudstekst, beløp, antall minutter å sjekke for svar)
            Dim appr As AppResponse = WShop.GetServiceData(Enums.tilbud, orderId, regNo, senderSMS, "32242070", custName, custMob, text, amount, "14400")
            AddHandler AppSearch.ResponseReceived, AddressOf ResponsArrived 'Subscribe to AppAnswerReceived event
            If String.IsNullOrEmpty(appr.error) Or appr.error = "OK" Then
                testvalue = appr.dataToWrite
                testvalue += "OK"
            Else
                testvalue = appr.error
            End If

        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "InvoiceBasis", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return testvalue
    End Function

    <WebMethod()>
    Public Shared Function ResponsArrived(sender As Object, e As CustArgs) 'Do something with mobile answer
        Try
            Dim fil As String = ConfigurationManager.AppSettings("LogFolder") + "TestResp" + e.OrderNo + ".txt"
            Utility.WriteTest(e.Text, fil, False)

            Try
                objWOJServ.SaveServiceResponse(e.OrderNo, e.Text, e.Status, e.Service, loginName)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "GenerateXML", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End Try
        Catch ex As Exception
            Utility.WriteEventToCarsLog("Feil ved event mottak", ex.Message)

            'MessageBox.Show(ex.Message)
        End Try

    End Function

    <WebMethod()>
    Public Shared Function FetchOfferAmount(ByVal orderno As String) As WOJobDetailBO()
        Try
            objWOJDetailsBO.Id_WO_NO = orderno
            details = objWOJServ.FetchOfferAmount(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadHourlyPrice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return details.ToList.ToArray()


    End Function

    <WebMethod()>
    Public Shared Function LoadOrderSpareStatus() As WOJobDetailBO()
        Dim spareStatus As New List(Of WOJobDetailBO)()
        Try
            'spareStatus = objWOJServ.LoadOrderSpareStatus()
            spareStatus = objWOJServ.LoadOrderSparePartStatus()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "LoadOrderSpareStatus", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return spareStatus.ToList.ToArray()
    End Function

    <WebMethod()>
    Public Shared Function UpdateEniroDetails(ByVal custId As String, ByVal lastName As String, ByVal firstName As String, ByVal middleName As String, ByVal visitAdd As String, ByVal billAdd As String, ByVal zipCode As String, ByVal zipPlace As String, ByVal phone As String, ByVal mobile As String, ByVal born As String, ByVal ssn As String) As String
        Dim strResult As String = ""

        Try

            objWOJDetailsBO.Id_Customer = custId
            objWOJDetailsBO.LastName = lastName
            objWOJDetailsBO.FirstName = firstName
            objWOJDetailsBO.MiddleName = middleName
            If visitAdd = " " Then
                objWOJDetailsBO.VisitAddress = ""
            Else
                objWOJDetailsBO.VisitAddress = visitAdd
            End If
            objWOJDetailsBO.BillingAddress = billAdd
            objWOJDetailsBO.ZipCode = zipCode
            objWOJDetailsBO.ZipPlace = zipPlace
            objWOJDetailsBO.Phone = phone
            objWOJDetailsBO.Mobile = mobile
            objWOJDetailsBO.Born = commonUtil.GetDefaultDate_MMDDYYYY(born)
            objWOJDetailsBO.SSN = ssn
            objWOJDetailsBO.Id_Login = loginName

            strResult = objWOJServ.UpdateEniroDetails(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "UpdateEniroDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function

    <WebMethod()>
    Public Shared Function FetchSPFromNBKCart(ByVal apiUser As String, ByVal idCustomer As String, ByVal vehId As String) As WOJobDetailBO()
        Dim woDetailList As New List(Of WOJobDetailBO)()
        Dim counter As Integer = 0
        Try
            woDetailList = CallNBK_API(apiUser, idCustomer, vehId)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                woDetailList = CallNBK_API(apiUser, idCustomer, vehId)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "FetchSPFromNBKCart", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return woDetailList.ToList.ToArray()
    End Function
    <WebMethod()>
    Public Shared Function FetchLabourFromNBKCart(ByVal apiUser As String, ByVal password As String, ByVal nbkLabourPercent As Decimal) As LabourDetails()
        Dim labourDetailsList As New List(Of LabourDetails)()
        Dim counter As Integer = 0
        Try
            labourDetailsList = CallNBK_LabourAPI(apiUser, password, nbkLabourPercent)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                labourDetailsList = CallNBK_LabourAPI(apiUser, password, nbkLabourPercent)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "FetchLabourFromNBKCart", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return labourDetailsList.ToList.ToArray()
    End Function

    Public Shared Function Deserialize(Of T As Class) _
             (ByVal input As String) As T
        Dim ser As XmlSerializer = New XmlSerializer(GetType(T))
        Using sr As StringReader = New StringReader(input)
            Return CType(ser.Deserialize(sr), T)
        End Using
    End Function

    Public Shared Function CallNBK_API(apiUser As String, idCustomer As String, vehicleID As String) As List(Of WOJobDetailBO)
        Dim apiPath As String = ""
        Dim xmlResponseString As String = ""
        Dim strResult As String = ""
        Dim count As Integer = 0
        Dim woDetailList As New List(Of WOJobDetailBO)()
        Dim retObjWOJobDetailBO As WOJobDetailBO
        apiPath = "https://gw2.autodata.no/cars9000/AD_NBK_OLI.php?user=" + apiUser + "&func=d"
        Dim uri As Uri = New Uri(apiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                xmlResponseString = reader.ReadToEnd()
                If xmlResponseString <> "" And xmlResponseString <> "0" Then
                    Dim xmlObject As xml = Deserialize(Of xml)(xmlResponseString)
                    Dim beholdning As String = ""
                    Dim pris As String = ""
                    Dim antall As String = ""
                    count = xmlObject.kurv.edbnr.Length
                    Dim dsWOJSpares As New DataSet
                    Dim dtWOJSpares As New DataTable
                    Dim sourceEncoding As Encoding = Encoding.GetEncoding(1252)
                    For i = 0 To xmlObject.kurv.edbnr.Length - 1
                        objWOJDetailsBO = New CARS.CoreLibrary.WOJobDetailBO
                        retObjWOJobDetailBO = New CARS.CoreLibrary.WOJobDetailBO
                        objWOJDetailsBO.ADLev = xmlObject.kurv.AD_lev.ToString
                        objWOJDetailsBO.EdbNr = xmlObject.kurv.edbnr(i).edbnr
                        objWOJDetailsBO.Alfa = System.Web.HttpUtility.UrlDecode(xmlObject.kurv.edbnr(i).alfa, sourceEncoding)
                        objWOJDetailsBO.ArtNr = xmlObject.kurv.edbnr(i).artnr
                        objWOJDetailsBO.VareNavn = System.Web.HttpUtility.UrlDecode(xmlObject.kurv.edbnr(i).varenavn, sourceEncoding)

                        beholdning = xmlObject.kurv.edbnr(i).beholdning
                        pris = xmlObject.kurv.edbnr(i).pris
                        antall = xmlObject.kurv.edbnr(i).antall
                        objWOJDetailsBO.Beholdning = System.Web.HttpUtility.UrlDecode(beholdning.Trim, sourceEncoding)
                        objWOJDetailsBO.Priss = System.Web.HttpUtility.UrlDecode(pris.Trim, sourceEncoding)
                        objWOJDetailsBO.Antall = System.Web.HttpUtility.UrlDecode(antall.Trim, sourceEncoding)
                        objWOJDetailsBO.Id_Login = HttpContext.Current.Session("UserID")
                        strResult = objWOJServ.ImportNBKData(objWOJDetailsBO)

                        If strResult = "1" Then
                            objWOJDetailsBO.Id_Item = objWOJDetailsBO.Alfa & objWOJDetailsBO.ArtNr
                            'objWOJDetailsBO.Id_Item = "1062999"
                            objWOJDetailsBO.WO_Id_Veh = vehicleID
                            objWOJDetailsBO.Id_Customer = idCustomer
                            objWOJDetailsBO.Created_By = HttpContext.Current.Session("UserID")

                            retObjWOJobDetailBO = objWOJServ.GetSpareDetails(objWOJDetailsBO)
                            woDetailList.Add(retObjWOJobDetailBO)

                        End If
                    Next
                End If
            End Using
        Else
            Dim woJobDetail As New WOJobDetailBO
            woJobDetail.IsValidResponse = False
            woDetailList.Add(woJobDetail)
        End If

        Return woDetailList
    End Function
    Public Shared Function CallNBK_LabourAPI(apiUser As String, password As String, nbkLabourPercent As Decimal) As List(Of LabourDetails)
        Dim labourApiPath As String = ""
        Dim strResult As String = ""
        Dim labourDetailsList As New List(Of LabourDetails)()
        'Dim labourDetailsResponseRet() As LabourDetails
        labourApiPath = "https://gw2.autodata.no/nbk/get_nbk_vkurv.php?uid=" + apiUser + "&pwd=" + password
        Dim uri As Uri = New Uri(labourApiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                ' strResult = "[{""key"":""001135"",""ltyp"":""0001"",""repnr"":""1C03005000"",""aw_betegnelse"":""Utskifting av oljefilter motor                              "",""time"":"" ""}]"

                strResult = HttpUtility.HtmlDecode(reader.ReadToEnd().Trim)
                If strResult <> """" And strResult <> "" And strResult <> "0" Then
                    Dim labourInfoResponse As LabourDetails() = JsonConvert.DeserializeObject(Of LabourDetails())(strResult)
                    If labourInfoResponse IsNot Nothing Then
                        For i = 0 To labourInfoResponse.Length - 1
                            labourInfoResponse(i).time = Regex.Replace(labourInfoResponse(i).time.Trim, "[^\d]", "")
                            If labourInfoResponse(i).aw_betegnelse.Trim <> "" Then
                                Dim woJobDetail As New LabourDetails
                                woJobDetail.aw_betegnelse = labourInfoResponse(i).aw_betegnelse.Trim
                                If labourInfoResponse(i).time.Trim() <> "" And Not labourInfoResponse(i).aw_betegnelse.Contains("001") Then
                                    woJobDetail.time = labourInfoResponse(i).time.Trim
                                    woJobDetail.aw_betegnelse = labourInfoResponse(i).aw_betegnelse.Trim
                                Else
                                    woJobDetail.time = 0
                                    woJobDetail.aw_betegnelse = woJobDetail.aw_betegnelse.Replace("001", "")
                                End If

                                woJobDetail.key = labourInfoResponse(i).key.Trim
                                woJobDetail.labourTime = Decimal.Parse(woJobDetail.time) / 100
                                woJobDetail.ltyp = labourInfoResponse(i).ltyp.Trim
                                woJobDetail.repnr = labourInfoResponse(i).repnr.Trim
                                woJobDetail.labourPercentage = nbkLabourPercent
                                woJobDetail.labourTimeWithPerAdded = (woJobDetail.labourTime + (woJobDetail.labourTime * woJobDetail.labourPercentage / 100)).ToString()
                                labourDetailsList.Add(woJobDetail)
                            End If

                        Next
                    End If

                End If
            End Using
        End If

        Return labourDetailsList
    End Function
    Protected Overrides Sub InitializeCulture()
        MyBase.InitializeCulture()
        If (ConfigurationManager.AppSettings("Culture") IsNot Nothing) Then
            Dim ci As New CultureInfo(ConfigurationManager.AppSettings("Culture").ToString())
            Thread.CurrentThread.CurrentCulture = ci
            Thread.CurrentThread.CurrentUICulture = ci

        End If
    End Sub
    Protected Sub cbStockQuantity_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            gvStockQty.JSProperties("cpErrorMessage") = ""
            Dim paramSpareIds As String = e.Parameter
            Dim supplierStockId As String = hdnSupplierStockId.Value
            Dim dealerNoSpare As String = hdnDealerNoSpare.Value
            Dim stockQtyList As New List(Of StockQuantityBO)()
            Dim counter As Integer = 0
            If (Not paramSpareIds Is String.Empty) Then
                Dim paramSpareId = paramSpareIds.Split(";")

                For Each spareID As String In paramSpareId
                    If (Not spareID Is String.Empty) Then
                        Try
                            stockQtyList.Add(CallStockQty_API(supplierStockId, dealerNoSpare, spareID, hdnJobGridSparesJson.Value))
                        Catch ex As Exception
                            If ex.HResult = "-2146233079" And counter = 0 Then
                                counter = counter + 1
                                stockQtyList.Add(CallStockQty_API(supplierStockId, dealerNoSpare, spareID, hdnJobGridSparesJson.Value))
                            Else
                                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "CallStockQty_API", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
                            End If
                        End Try

                    End If
                Next
            End If

            If stockQtyList.Count > 0 Then
                For Each stockQty In stockQtyList
                    If stockQty.antallLev Is Nothing And stockQty.antallSogb Is Nothing Then
                        gvStockQty.JSProperties("cpErrorMessage") = "ConfigError"
                    Else
                        gvStockQty.JSProperties("cpErrorMessage") = ""
                    End If
                Next
                Session("StockQuantityList") = stockQtyList
                gvStockQty.Selection.UnselectAll()
                gvStockQty.DataSource = Session("StockQuantityList")
                gvStockQty.DataBind()
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "cbStockQuantity_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Public Shared Function CallStockQty_API(lev As String, knr As String, spareId As String, jobGridSparesJson As String) As StockQuantityBO
        Dim apiPath As String = ""
        Dim xmlResponseString As String = ""
        Dim sourceEncoding As Encoding = Encoding.GetEncoding(1252)
        Dim objStockQuantityBO As New StockQuantityBO
        Dim xmlDoc As New XmlDocument
        apiPath = "https://gw2.autodata.no/cars9000/qpc_beh.php?lev=" + lev + "&knr=" + knr + "&art=" + spareId + ";"
        Dim uri As Uri = New Uri(apiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                xmlResponseString = reader.ReadToEnd()
                If xmlResponseString <> "" And xmlResponseString <> "0" Then
                    Dim woSpareJsonArray As JArray = JArray.Parse(jobGridSparesJson)
                    Dim woSpareList = woSpareJsonArray.ToList()
                    'Dim xmlStockQuantity As xmlStockQty = Deserialize(Of xmlStockQty)(xmlResponseString)
                    objStockQuantityBO.spareID = spareId

                    Dim spareDetails = (From spare In woSpareList
                                        Where spare("id") = objStockQuantityBO.spareID).ToList()(0)

                    objStockQuantityBO.bestilt = IIf(spareDetails IsNot Nothing, spareDetails("bestilt"), 0)

                    If Not xmlResponseString.Contains("<FEIL>") Then
                        xmlDoc.LoadXml(xmlResponseString)
                        Dim levNode As XmlNodeList = xmlDoc.SelectNodes("/xml/autodata/lev" + lev + "/post")
                        Dim sogbNode As XmlNodeList = xmlDoc.SelectNodes("/xml/autodata/sogb/art")

                        If (levNode IsNot Nothing) Then
                            For Each node As XmlElement In levNode
                                objStockQuantityBO.alfaLev = IIf(node("alfa") IsNot Nothing, node("alfa").InnerText.Trim, "")
                                objStockQuantityBO.antallLev = IIf(node("antall") IsNot Nothing, node("antall").InnerText.Trim, "0")
                                objStockQuantityBO.artnrLev = IIf(node("artnr") IsNot Nothing, node("artnr").InnerText.Trim, "")
                                objStockQuantityBO.bruttoLev = IIf(node("brutto") IsNot Nothing, node("brutto").InnerText.Trim, "")
                                objStockQuantityBO.merknadLev = IIf(node("merknad") IsNot Nothing, node("merknad").InnerText.Trim, "")
                                objStockQuantityBO.navnLev = IIf(node("navn") IsNot Nothing, System.Web.HttpUtility.UrlDecode(node("navn").InnerText.Trim, sourceEncoding), "")
                                objStockQuantityBO.nettoLev = IIf(node("netto") IsNot Nothing, node("netto").InnerText.Trim, "")
                                objStockQuantityBO.nrLev = node.Attributes("nr").Value.Trim
                            Next
                        End If

                        If (sogbNode IsNot Nothing) Then
                            For Each node As XmlElement In sogbNode
                                objStockQuantityBO.alfaSogb = IIf(node("alfa") IsNot Nothing, node("alfa").InnerText.Trim, "")
                                objStockQuantityBO.antallSogb = IIf(node("antall") IsNot Nothing, node("antall").InnerText.Trim, "0")
                                objStockQuantityBO.artnrSogb = IIf(node("artnr") IsNot Nothing, node("artnr").InnerText.Trim, "")
                                objStockQuantityBO.navnSogb = IIf(node("navn") IsNot Nothing, System.Web.HttpUtility.UrlDecode(node("navn").InnerText.Trim, sourceEncoding), "")
                                objStockQuantityBO.noSogb = node.Attributes("no").Value.Trim
                            Next
                        End If
                    End If
                End If
            End Using
        End If
        Return objStockQuantityBO
    End Function
    Protected Sub gvStockQty_BatchUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs)
        Try
        Dim stockQtyList As List(Of StockQuantityBO) = Session("StockQuantityList")
        For Each item In e.UpdateValues
            Dim query = (From stock As StockQuantityBO In stockQtyList
                         Where stock.spareID = item.Keys(0)).ToList()(0)

            query.bestilt = item.NewValues("bestilt")
            stockQtyList.RemoveAll(Function(obj) obj.spareID = item.Keys(0))
            stockQtyList.Add(query)
        Next
        gvStockQty.DataSource = stockQtyList
        gvStockQty.DataBind()
        e.Handled = True
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "gvStockQty_BatchUpdate", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    <WebMethod()>
    Public Shared Function BargainSMSNew(ByVal jsonBargainData As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim counter As Integer = 0
        Dim responseId As String = String.Empty
        Dim apiToken As String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiaXNzIjoiQ2Fyc1dlYiIsInVzZXJuYW1lIjoiY2FycyIsImV4cCI6MTkyMDU0OTk0NiwidHlwZSI6IkFQSSIsImlhdCI6MTYwNTAxNzE0Nn0.gUGGFxhFT4oVF_x362BRCMRhDe-q6WwhNTfvzzBqf7s"
        Dim contentType = "application/json"
        Try
            responseId = PostMessage(jsonBargainData, bargainSmsApi, apiToken, contentType, idWONO, idWOPrefix)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                responseId = PostMessage(jsonBargainData, bargainSmsApi, apiToken, contentType, idWONO, idWOPrefix)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "BargainSMSNew", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return responseId
    End Function

    Shared Function PostMessage(ByVal _request As String, ByVal _endpoint As String, ByVal _token As String, ByVal _contentType As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim responseString As String = String.Empty
        Dim responseId As String = String.Empty

        Dim uri As Uri = New Uri(_endpoint)
            Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
            Dim postDataBytes() As Byte = Encoding.UTF8.GetBytes(_request)
            req.ContentType = _contentType
            req.Method = "POST"
            req.Headers.Add("authorization", _token)
            req.ContentLength = postDataBytes.Length
            ServicePointManager.Expect100Continue = True
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3
            Using stream As Stream = req.GetRequestStream()
                stream.Write(postDataBytes, 0, postDataBytes.Length)
            End Using

            Dim Res As WebResponse = req.GetResponse()
            Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
            If httpWebResponse.StatusCode = HttpStatusCode.OK Then
                Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                    responseString = reader.ReadToEnd()
                    If responseString <> "" Then
                        Dim jsonObject As JObject = JObject.Parse(responseString)
                        responseId = jsonObject("id").ToString

                    'Saving the Bargain Id to TBL_WO_HEADER table
                    objWOHeaderBO.IdBargain = responseId
                    objWOHeaderBO.Id_WO_NO = idWONO
                    objWOHeaderBO.Id_WO_Prefix = idWOPrefix
                    objWOHeaderBO.Modified_By = loginName
                    objWOJServ.Modify_WO_Header("BARGAINID", objWOHeaderBO)
                    Dim objNotification As New Notification
                    Dim objNotificationBO As New NotificationBO
                    objNotificationBO.Mode = "INSERT"
                    objNotificationBO.IdBargain = responseId
                    objNotificationBO.WO_NO = idWONO
                    objNotificationBO.WO_PREFIX = idWOPrefix
                    objNotificationBO.WO_JOB_NO = 0
                    objNotificationBO.CreatedBy = loginName
                    objNotification.ManageBargainSMS(objNotificationBO)
                    End If

                End Using
            End If

        Return responseId
    End Function
    Protected Sub cbPanel_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim objXML As New XmlDocument
            Dim strInvoice As String = String.Empty
            If HttpContext.Current.Session("RptType") IsNot Nothing Then
                Dim myRep
                If HttpContext.Current.Session("RptType") = "INVOICEBASIS" Then
                    myRep = New dxInvoiceBasis()
                    myRep.Name = "Report Invoice Basis " + DateTime.Now
                    myRep.Parameters("IsInvoiceBasis").Value = False
                    myRep.Parameters("RPT_NO_OF_DIGITS").Value = IIf(System.Configuration.ConfigurationManager.AppSettings("DecimalPlaces") IsNot Nothing, System.Configuration.ConfigurationManager.AppSettings("DecimalPlaces"), 2)
                    myRep.Parameters("paramInvXml").Value = IIf(HttpContext.Current.Session("xmlInvNos") IsNot Nothing, HttpContext.Current.Session("xmlInvNos"), "<ROOT></ROOT>")
                    myRep.Parameters("paramType").Value = IIf(HttpContext.Current.Session("RptType") IsNot Nothing, HttpContext.Current.Session("RptType"), "INVOICEBASIS")
                ElseIf HttpContext.Current.Session("RptType") = "INVOICE" Then
                    myRep = New dxWorkOrderInvoice()
                    myRep.Parameters("RPT_NO_OF_DIGITS").Value = IIf(System.Configuration.ConfigurationManager.AppSettings("DecimalPlaces") IsNot Nothing, System.Configuration.ConfigurationManager.AppSettings("DecimalPlaces"), 2)
                    myRep.Parameters("paramInvXml").Value = IIf(HttpContext.Current.Session("xmlInvNos") IsNot Nothing, HttpContext.Current.Session("xmlInvNos"), "<ROOT></ROOT>")
                    myRep.Parameters("paramType").Value = IIf(HttpContext.Current.Session("RptType") IsNot Nothing, HttpContext.Current.Session("RptType"), "INVOICE")
                    Dim strXML As String = CStr(Session("xmlInvNos")).ToString()
                    objXML.LoadXml(strXML)
                    Dim xmlNode As XmlNodeList = objXML.SelectNodes("//ID_INV_NO")
                    'For Each xnode As XmlNode In xmlNode
                    strInvoice = xmlNode(0).Attributes("ID_INV_NO").Value
                    'Next
                    myRep.Name = strInvoice.Trim
                ElseIf HttpContext.Current.Session("RptType") = "WOJobCard" Then
                    myRep = New dxJobCard()
                    myRep.Name = "Job Card " + DateTime.Now
                    myRep.Parameters("pIV_WO_NO").Value = commonUtil.ConvertStr(HttpContext.Current.Session("WOPR").ToString()) + commonUtil.ConvertStr(HttpContext.Current.Session("WONO").ToString())
                    myRep.Parameters("pLanguage").Value = ConfigurationManager.AppSettings("Language")
                Else
                    Return
                End If
                'myRep.Parameters("paramInvXml").Value = IIf(HttpContext.Current.Session("xmlInvNos") IsNot Nothing, HttpContext.Current.Session("xmlInvNos"), "<ROOT></ROOT>")
                'myRep.Parameters("paramType").Value = IIf(HttpContext.Current.Session("RptType") IsNot Nothing, HttpContext.Current.Session("RptType"), "INVOICEBASIS") '"INVOICEBASIS"
                'myRep.Parameters("RPT_NO_OF_DIGITS").Value = IIf(System.Configuration.ConfigurationManager.AppSettings("DecimalPlaces") IsNot Nothing, System.Configuration.ConfigurationManager.AppSettings("DecimalPlaces"), 2)
                myRep.RequestParameters = False
                myRep.ApplyLocalization(System.Configuration.ConfigurationManager.AppSettings("Culture"))

                Dim cachedReportSource = New CachedReportSourceWeb(myRep)
                Session("ReportSource") = cachedReportSource
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "cbPanel_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    <WebMethod()>
    Public Shared Function FetchBargainStatus(ByVal bargainId As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim counter As Integer = 0
        Dim response As String = String.Empty
        Try
            response = CallBargainStatus_API(bargainId, idWONO, idWOPrefix)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                response = CallBargainStatus_API(bargainId, idWONO, idWOPrefix)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "FetchBargainStatus", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return response
    End Function

    Public Shared Function CallBargainStatus_API(bargainId As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim bargainAccepted As Integer = 0
        Dim apiPath As String = ""
        Dim responseString As String = ""
        apiPath = "http://cars-web-api-production.herokuapp.com/api/v3/quote/" + bargainId
        Dim uri As Uri = New Uri(apiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                responseString = reader.ReadToEnd()
                If responseString <> "" And responseString <> "0" Then
                    Dim jsonObject As JObject = JObject.Parse(responseString)
                    Dim booked As String = jsonObject("booked").ToString
                    Dim status As String = jsonObject("status").ToString
                    If booked = "" And status = "1" Then
                        bargainAccepted = 0
                    Else
                        bargainAccepted = 1
                    End If
                End If
            End Using
        End If
        If (bargainAccepted = 1) Then
            objWOHeaderBO.IsBargainAccepted = True
            objWOHeaderBO.Id_WO_NO = idWONO
            objWOHeaderBO.Id_WO_Prefix = idWOPrefix
            objWOHeaderBO.Modified_By = loginName
            objWOJServ.Modify_WO_Header("BARGAINFLAG", objWOHeaderBO)
        End If
        Return responseString
    End Function
    <WebMethod()>
    Public Shared Function FetchXtraSchemeStatus(ByVal xtraschemeId As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim counter As Integer = 0
        Dim response As String = String.Empty
        Try
            response = CallXtraSchemeStatus_API(xtraschemeId, idWONO, idWOPrefix)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                response = CallXtraSchemeStatus_API(xtraschemeId, idWONO, idWOPrefix)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "FetchXtraSchemeStatus", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return response
    End Function
    Public Shared Function CallXtraSchemeStatus_API(xtraschemeId As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim xtraSchemeAccepted As Integer = 0
        Dim apiPath As String = ""
        Dim responseString As String = ""
        apiPath = "http://cars-web-api-production.herokuapp.com/api/v3/info/" + xtraschemeId
        Dim uri As Uri = New Uri(apiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                responseString = reader.ReadToEnd()
                If responseString <> "" And responseString <> "0" Then
                    Dim jsonObject As JObject = JObject.Parse(responseString)
                    Dim booked As String = jsonObject("booked").ToString
                    Dim order As String = jsonObject("order").ToString
                    If booked = "" And order = "" Then
                        xtraSchemeAccepted = 0
                    Else
                        xtraSchemeAccepted = 1
                    End If
                End If
            End Using
        End If
        If (xtraSchemeAccepted = 1) Then
            objWOHeaderBO.IsXtraSchemeAccepted = True
            objWOHeaderBO.Id_WO_NO = idWONO
            objWOHeaderBO.Id_WO_Prefix = idWOPrefix
            objWOHeaderBO.Modified_By = loginName
            objWOJServ.Modify_WO_Header("XTRAFLAG", objWOHeaderBO)
        End If
        Return responseString
    End Function
    <WebMethod()>
    Public Shared Function SaveXtraSchemeId(ByVal idXtraScheme As String, ByVal idWONO As String, ByVal idWOPrefix As String) As String
        Dim responseString As String = ""
        Try
            objWOHeaderBO.IdXtraScheme = idXtraScheme
            objWOHeaderBO.Id_WO_NO = idWONO
            objWOHeaderBO.Id_WO_Prefix = idWOPrefix
            objWOHeaderBO.Modified_By = loginName
            responseString = objWOJServ.Modify_WO_Header("XTRAID", objWOHeaderBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "SaveXtraSchemeId", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return responseString
    End Function
    Public Shared Function CallSendPurchase_API(url As String, lev As String, poNumber As String) As String
        Dim responseString As String = ""
        Dim ordrenr As String = ""
        Dim xmlDoc As New XmlDocument
        Dim uri As Uri = New Uri(url)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                responseString = reader.ReadToEnd()
                If responseString <> "" And responseString <> "0" Then
                    xmlDoc.LoadXml(responseString)

                    Dim levNode As XmlNodeList = xmlDoc.SelectNodes("/xml/autodata/LEV" + lev)
                    If (levNode IsNot Nothing) Then
                        For Each node As XmlElement In levNode
                            ordrenr = IIf(node("ordrenr") IsNot Nothing, node("ordrenr").InnerText.Trim, "")
                        Next
                    End If
                End If

                If ordrenr <> "" Then
                    POservice.Modify_PO_Details(poNumber, ordrenr)
                End If
            End Using
        End If

        Return responseString
    End Function
    Protected Sub cbSendPurchase_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)
        Try
            Dim retString As String = ""
            Dim WONumber As String = e.Parameter.ToString()
            cbSendPurchase.JSProperties("cpPONumber") = ""
            Dim sendPurchaseApiUrl As String = "https://gw2.autodata.no/cars9000/qpc_bestill.php" + "?lev=" + hdnSupplierStockId.Value.ToString() + "&knr=" + hdnDealerNoSpare.Value.ToString()
            Dim counter As Integer = 0
            Dim sourceEncoding As Encoding = Encoding.GetEncoding("UTF-8")
            Dim stockQtyList As List(Of StockQuantityBO) = Session("StockQuantityList")
            Dim userWareHouse As String = objWOJServ.GetWarehouse()
            Dim POitem As PurchaseOrderItemsBO
            'To get the next PO Number and Prefix
            Dim poNumAndPrefix() As String = POservice.generate_PO_number(hdnIdDeptWo.Value.ToString(), userWareHouse)
            Dim poPrefix As String = poNumAndPrefix(0)
            Dim poNumber As String = poNumAndPrefix(1)
            'Dim annotation As String = "Cars%20best.nr.%20" + poNumber + "%20dette%20er%20en%20testbestilling,%20skal%20makuleres"
            Dim annotation As String = txtAPIAnnotation.Text
            cbSendPurchase.JSProperties("cpPONumber") = poNumber
            Dim expectedDelDate As DateTime
            If (txtDeliveryDate.Text = "") Then
                expectedDelDate = DateTime.Now
            Else
                expectedDelDate = Convert.ToDateTime(txtDeliveryDate.Text)
            End If
            POheaderBO.ID_WAREHOUSE = userWareHouse
            POheaderBO.ID_DEPT = hdnIdDeptWo.Value.ToString()
            POheaderBO.PREFIX = poPrefix
            POheaderBO.NUMBER = poNumber
            POheaderBO.CREATED_BY = loginName
            POheaderBO.DT_CREATED = DateTime.Now
            POheaderBO.DT_EXPECTED_DELIVERY = expectedDelDate.ToString("yyyyMMdd")
            POheaderBO.FINISHED = 0
            POheaderBO.DT_CREATED_SIMPLE = DateTime.Now.ToString("yyyyMMdd")
            POheaderBO.ID_ORDERTYPE = ""
            POheaderBO.ANNOTATION = "ORDER NO: " + WONumber
            POheaderBO.DELIVERED = 0
            POheaderBO.SUPP_CURRENTNO = hdnSupplierCurrentNo.Value.ToString()
            POheaderBO.DELIVERY_METHOD = ""
            POheaderBO.STATUS = 0

            'Saving the PO Header
            Dim strResult As Integer = POservice.SavePurchaseOrder(POheaderBO)

            'Send Purchase API url
            Dim selectedRows = gvStockQty.GetSelectedFieldValues("spareID")
            Dim woSpareJsonString As String = hdnJobGridSparesJson.Value
            Dim woSpareJsonArray As JArray = JArray.Parse(woSpareJsonString)
            Dim woSpareList = woSpareJsonArray.ToList()
            If selectedRows.Count > 0 Then
                sendPurchaseApiUrl = sendPurchaseApiUrl + "&rader=0" + selectedRows.Count.ToString + "&"
                For Each row In selectedRows
                    Dim sparePartId As String = row.ToString
                    Dim sparePartDesc As String = gvStockQty.GetRowValuesByKeyValue(sparePartId, "navnLev").ToString
                    Dim bestilt As Integer = Integer.Parse(gvStockQty.GetRowValuesByKeyValue(sparePartId, "bestilt").ToString)
                    If (bestilt > 0) Then
                        Dim spareDetails = (From spare In woSpareList
                                            Where spare("id") = row.ToString).ToList()(0)
                        'query.id_wo_item_seq
                        counter = counter + 1
                        sendPurchaseApiUrl = sendPurchaseApiUrl + "vare0" + counter.ToString() + "=" + sparePartId.Substring(0, 3) + "|" + sparePartId.Substring(3, sparePartId.Length - 3) + "|" + bestilt.ToString() + "00&"

                        POitem = New PurchaseOrderItemsBO
                        POitem.ANNOTATION = "ORDER NO: " + WONumber
                        POitem.POPREFIX = poPrefix
                        POitem.PONUMBER = poNumber
                        POitem.ID_PO = objPODO.Fetch_PO_id(poNumber)
                        POitem.SUPP_CURRENTNO = hdnSupplierCurrentNo.Value.ToString
                        POitem.ID_ITEM = sparePartId
                        POitem.ITEM_DESC = sparePartDesc
                        POitem.ORDERQTY = bestilt

                        POitem.ID_ITEM_CATG = ""
                        POitem.ITEM_CATG_DESC = ""
                        POitem.COST_PRICE1 = IIf(spareDetails IsNot Nothing, spareDetails("cost_price"), 0)
                        POitem.ITEM_PRICE = IIf(spareDetails IsNot Nothing, spareDetails("price"), 0)
                        POitem.NET_PRICE = 0
                        POitem.BASIC_PRICE = 0
                        POitem.TOTALCOST = POitem.ORDERQTY * POitem.COST_PRICE1
                        POitem.BACKORDERQTY = IIf(spareDetails IsNot Nothing, spareDetails("bo_qty"), 0)
                        POitem.CONFIRMQTY = 0
                        POitem.DELIVERED = False
                        POitem.ID_WOITEM_SEQ = IIf(spareDetails IsNot Nothing, spareDetails("id_wo_item_seq"), 0)
                        POitem.REST_FLG = 1
                        'Adding PO Item
                        retString = POservice.Add_PO_Item_New(POitem)
                    End If
                Next
                sendPurchaseApiUrl = sendPurchaseApiUrl + "merknad=" + HttpUtility.UrlPathEncode(annotation) + "&rekv=" + txtRegNo.Text + "&frakt= "
                CallSendPurchase_API(sendPurchaseApiUrl, hdnSupplierStockId.Value.ToString(), poNumber)
            End If
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "cbSendPurchase_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    Protected Sub cbRepPack_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Try
            Dim searchtext As String = e.Parameter.ToString()
            lbRepPakHead.DataSource = objRepPackSer.Fetch_RP_List_WO(searchtext)
            lbRepPakHead.DataBind()
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "cbRepPack_Callback", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
    End Sub
    <WebMethod()>
    Public Shared Function SaveReturnSpare(ByVal idItem As String, ByVal itemDesc As String, ByVal returnQty As String, ByVal salePrice As String, ByVal costPrice As String, ByVal idMake As String, ByVal woPrefix As String, ByVal woNum As String) As String()
        Dim strResult As String() = {"", ""}
        Try
            objWOJDetailsBO.Id_Item = idItem
            objWOJDetailsBO.Item_Sp_Desc = itemDesc
            objWOJDetailsBO.Return_Qty = returnQty
            objWOJDetailsBO.Sp_Item_Price = salePrice
            objWOJDetailsBO.Sp_Cost_Price = costPrice
            objWOJDetailsBO.SuppCurrNo = idMake
            objWOJDetailsBO.Id_WO_Prefix = woPrefix
            objWOJDetailsBO.Id_WO_NO = woNum
            strResult = objWOJServ.Save_Return_Spare(objWOJDetailsBO)
        Catch ex As Exception
            objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "SaveReturnSpare", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
        End Try
        Return strResult
    End Function
    <WebMethod()>
    Public Shared Function GetSparePrice(ByVal spIdItem As String, ByVal suppCurrNo As String, ByVal suppStockId As String, ByVal dealerNoSpare As String, idWH As String) As StockQuantityBO
        Dim woStockQty As New StockQuantityBO
        Dim counter As Integer = 0
        Try
            woStockQty = CallHentPris_API(spIdItem, suppCurrNo, suppStockId, dealerNoSpare, idWH)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                woStockQty = CallHentPris_API(spIdItem, suppCurrNo, suppStockId, dealerNoSpare, idWH)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "GetSparePrice", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return woStockQty
    End Function
    Public Shared Function CallHentPris_API(spIdItem As String, suppCurrNo As String, suppStockId As String, dealerNoSpare As String, idWH As String) As StockQuantityBO
        Dim xmlResponseString As String = ""
        Dim objStockQuantityBO As New StockQuantityBO
        Dim xmlDoc As New XmlDocument
        Dim apiPath As String = "https://gw.autodata.no/cars9000/qpc_beh.php?lev=" + suppStockId + "&knr=" + dealerNoSpare + "&art=" + spIdItem
        Dim uri As Uri = New Uri(apiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        req.ContentType = "application/json"
        req.Method = "GET"
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                xmlResponseString = reader.ReadToEnd()
                Dim sourceEncoding As Encoding = Encoding.GetEncoding(1252)
                If xmlResponseString <> "" And xmlResponseString <> "0" Then
                    objStockQuantityBO.spareID = spIdItem
                    If Not xmlResponseString.Contains("<FEIL>") Then
                        xmlDoc.LoadXml(xmlResponseString)
                        Dim levNode As XmlNodeList = xmlDoc.SelectNodes("/xml/autodata/lev" + suppStockId + "/post")
                        Dim sogbNode As XmlNodeList = xmlDoc.SelectNodes("/xml/autodata/sogb/art")

                        If (levNode IsNot Nothing) Then
                            For Each node As XmlElement In levNode
                                objStockQuantityBO.alfaLev = IIf(node("alfa") IsNot Nothing, node("alfa").InnerText.Trim, "")
                                objStockQuantityBO.antallLev = IIf(node("antall") IsNot Nothing, node("antall").InnerText.Trim, "0")
                                objStockQuantityBO.artnrLev = IIf(node("artnr") IsNot Nothing, node("artnr").InnerText.Trim, "")
                                objStockQuantityBO.bruttoLev = IIf(node("brutto") IsNot Nothing, node("brutto").InnerText.Trim, "")
                                objStockQuantityBO.merknadLev = IIf(node("merknad") IsNot Nothing, node("merknad").InnerText.Trim, "")
                                objStockQuantityBO.navnLev = IIf(node("navn") IsNot Nothing, System.Web.HttpUtility.UrlDecode(node("navn").InnerText.Trim, sourceEncoding), "")
                                objStockQuantityBO.nettoLev = IIf(node("netto") IsNot Nothing, node("netto").InnerText.Trim, "")
                                objStockQuantityBO.nrLev = node.Attributes("nr").Value.Trim
                            Next
                        End If

                        If (sogbNode IsNot Nothing) Then
                            For Each node As XmlElement In sogbNode
                                objStockQuantityBO.alfaSogb = IIf(node("alfa") IsNot Nothing, node("alfa").InnerText.Trim, "")
                                objStockQuantityBO.antallSogb = IIf(node("antall") IsNot Nothing, node("antall").InnerText.Trim, "0")
                                objStockQuantityBO.artnrSogb = IIf(node("artnr") IsNot Nothing, node("artnr").InnerText.Trim, "")
                                objStockQuantityBO.navnSogb = IIf(node("navn") IsNot Nothing, System.Web.HttpUtility.UrlDecode(node("navn").InnerText.Trim, sourceEncoding), "")
                                objStockQuantityBO.noSogb = node.Attributes("no").Value.Trim
                            Next
                        End If

                        If (Not objStockQuantityBO.navnLev.Contains("FEIL")) Then
                            Dim retString As String = ""
                            Dim objWOJobDetailBO As New WOJobDetailBO()
                            objWOJobDetailBO.Sp_Cost_Price = objStockQuantityBO.nettoLev.Trim()
                            objWOJobDetailBO.Pris = objStockQuantityBO.bruttoLev.Trim()
                            objWOJobDetailBO.WebSparePartId = objStockQuantityBO.alfaLev.Trim() + " " + objStockQuantityBO.artnrLev.Trim()
                            objWOJobDetailBO.SuppCurrNo = suppCurrNo
                            objWOJobDetailBO.Id_Item = objStockQuantityBO.spareID
                            objWOJobDetailBO.Id_Warehouse = idWH
                            objWOJobDetailBO.Id_Login = loginName
                            retString = objWOJServ.Update_SP_Prices(objWOJobDetailBO)

                            objStockQuantityBO.isValid = IIf(retString = "UPDATED", True, False)

                        End If

                    End If
                End If
            End Using
        End If
        Return objStockQuantityBO
    End Function
    <WebMethod()>
    Public Shared Function FetchBilglassportalen(ByVal bgpOrderNo As String, idCustomer As String, vehicleID As String) As WOJobDetailBO()
        Dim objWOJobDetList As New List(Of WOJobDetailBO)()
        Dim counter As Integer = 0
        Try
            objWOJobDetList = CallBilglassportalen_API(bgpOrderNo, idCustomer, vehicleID)
        Catch ex As Exception
            If ex.HResult = "-2146233079" And counter = 0 Then
                counter = counter + 1
                objWOJobDetList = CallBilglassportalen_API(bgpOrderNo, idCustomer, vehicleID)
            Else
                objErrHandle.WriteErrorLog(1, "Transactions_frmWOJobDetails", "FetchBilglassportalen", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, loginName)
            End If
        End Try
        Return objWOJobDetList.ToList.ToArray()
    End Function
    Public Shared Function CallBilglassportalen_API(ByVal bgpOrderNo As String, idCustomer As String, vehicleID As String) As List(Of WOJobDetailBO)
        Dim objBilglassportalenBOList As New List(Of BilglassportalenBO)
        Dim xmlResponseString As String = ""
        Dim apiToken = "Bearer KR702giegku6VWUM9FYogg"
        Dim xmlDoc As New XmlDocument
        Dim apiPath As String = " https://test.bilglassportalen.no/service/assignmentdetails?reference=" + bgpOrderNo
        Dim uri As Uri = New Uri(apiPath)
        Dim req As HttpWebRequest = CType(WebRequest.Create(uri), HttpWebRequest)
        Dim retObjWOJobDetailBO As WOJobDetailBO
        Dim strResult As String = ""
        Dim woDetailList As New List(Of WOJobDetailBO)()
        req.ContentType = "application/json"
        req.Method = "GET"
        req.Headers.Add("authorization", apiToken)
        ServicePointManager.Expect100Continue = True
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls Or SecurityProtocolType.Tls12 Or SecurityProtocolType.Ssl3

        Dim Res As WebResponse = req.GetResponse()
        Dim httpWebResponse As HttpWebResponse = CType(Res, HttpWebResponse)
        If httpWebResponse.StatusCode = HttpStatusCode.OK Then
            Using reader As StreamReader = New StreamReader(Res.GetResponseStream())
                xmlResponseString = reader.ReadToEnd()
                If xmlResponseString <> "" And xmlResponseString <> "0" Then
                    xmlDoc.LoadXml(xmlResponseString)
                    Dim articleNode As XmlNodeList = xmlDoc.SelectNodes("Bilglassportalen/Article")
                    If articleNode IsNot Nothing Then
                        For Each node As XmlElement In articleNode
                            Dim objBilglassportalenBO As New BilglassportalenBO()
                            objBilglassportalenBO.ArticleNumber = IIf(node("ArticleNumber") IsNot Nothing, node("ArticleNumber").InnerText.Trim, "")
                            objBilglassportalenBO.ArticleDescription = IIf(node("ArticleDescription") IsNot Nothing, node("ArticleDescription").InnerText.Trim, "")
                            objBilglassportalenBO.Quantity = IIf(node("Quantity") IsNot Nothing, node("Quantity").InnerText.Trim, "")
                            objBilglassportalenBO.UnitPrice = IIf(node("UnitPrice") IsNot Nothing, node("UnitPrice").InnerText.Trim, "")
                            objBilglassportalenBO.Discount = IIf(node("Discount") IsNot Nothing, node("Discount").InnerText.Trim, "")
                            objBilglassportalenBO.CostPrice = IIf(node("CostPrice") IsNot Nothing, node("CostPrice").InnerText.Trim, "")
                            objBilglassportalenBO.IdLogin = loginName
                            'retObjWOJobDetailBO = New CoreLibrary.WOJobDetailBO

                            strResult = objWOJServ.ImportBGPData(objBilglassportalenBO)

                            If strResult = "1" Then

                                objWOJDetailsBO.Id_Item = objBilglassportalenBO.ArticleNumber
                                objWOJDetailsBO.WO_Id_Veh = vehicleID
                                objWOJDetailsBO.Id_Customer = idCustomer
                                objWOJDetailsBO.Created_By = HttpContext.Current.Session("UserID")

                                retObjWOJobDetailBO = objWOJServ.GetSpareDetails(objWOJDetailsBO)
                                retObjWOJobDetailBO.Jobi_Order_Qty = objBilglassportalenBO.Quantity
                                retObjWOJobDetailBO.Jobi_Deliver_Qty = objBilglassportalenBO.Quantity
                                woDetailList.Add(retObjWOJobDetailBO)

                            End If
                        Next
                    End If
                End If
            End Using
        Else
            Dim woJobDetail As New WOJobDetailBO
            woJobDetail.IsValidResponse = False
            woDetailList.Add(woJobDetail)
        End If

        Return woDetailList
    End Function
End Class