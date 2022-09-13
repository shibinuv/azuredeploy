Imports System.Web

Namespace CARS.Services.TirePackage
    Public Class TirePackage
        Shared objTirePackageDO As New TirePackageDO
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
        Shared objCommonUtil As New Utilities.CommonUtility


        Public Function Fetch_TP_List(ByVal wh As String, ByVal tpNo As String, ByVal closed As String, ByVal refNo As String, ByVal custNo As String, ByVal tireType As String, ByVal tireQuality As String) As List(Of TirePackageBO)
            Dim dsTirePackageItems As New DataSet
            Dim dtTirePackageItems As DataTable
            Dim tirePackageResult As New List(Of TirePackageBO)()
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsTirePackageItems = objTirePackageDO.Fetch_TP_List(wh, tpNo, closed, refNo, custNo, tireType, tireQuality)

                If dsTirePackageItems.Tables.Count > 0 Then
                    dtTirePackageItems = dsTirePackageItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtTirePackageItems.Rows
                    Dim item As New TirePackageBO()



                    item.refNo = dtrow("refNo").ToString
                    item.regNo = dtrow("regNo").ToString
                    item.custNo = dtrow("custNo")
                    item.custName = dtrow("custName") + " " + dtrow("custmName") + " " + dtrow("custlName")
                    item.tirePackageNo = dtrow("tirePackageNo")
                    item.location = dtrow("location")
                    item.tireTypeDesc = dtrow("tireTypeDesc")
                    item.tireQualityDesc = dtrow("tireQualityDesc")
                    item.isFinished = dtrow("isFinished")


                    tirePackageResult.Add(item)

                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "Fetch_TP_List", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tirePackageResult
        End Function

        Public Function FetchTireMake() As List(Of TirePackageBO)
            Dim dsFetchAllMakes As New DataSet
            Dim dtMakeCodes As DataTable
            Dim Make As New List(Of TirePackageBO)()
            Try
                dsFetchAllMakes = objTirePackageDO.FetchTireMake()
                dtMakeCodes = dsFetchAllMakes.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtMakeCodes.Rows
                    Dim makeDet As New TirePackageBO()
                    'makeDet.Id_Make_Veh = dtrow("ID_MAKE").ToString()
                    'makeDet.MakeName = dtrow("ID_MAKE_NAME").ToString()
                    Make.Add(makeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchTireMake", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return Make.ToList
        End Function

        Public Function FetchTireType() As List(Of TirePackageBO)
            Dim dsFetchTireType As New DataSet
            Dim dtTireType As DataTable
            Dim tireType As New List(Of TirePackageBO)()
            Try
                dsFetchTireType = objTirePackageDO.FetchTireType()
                dtTireType = dsFetchTireType.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtTireType.Rows
                    Dim tireTypeDet As New TirePackageBO()
                    tireTypeDet.tireTypeVal = dtrow("TireId").ToString()
                    tireTypeDet.tireTypeDesc = dtrow("TireType").ToString()
                    tireTypeDet.tirePackageVal = dtrow("TireTypeVariable").ToString()
                    tireType.Add(tireTypeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchTireType", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tireType.ToList
        End Function

        Public Function getTireType(ByVal value As String) As List(Of TirePackageBO)
            Dim dsFetchTireType As New DataSet
            Dim dtTireType As DataTable
            Dim tireType As New List(Of TirePackageBO)()
            Try
                dsFetchTireType = objTirePackageDO.getTireType(value)
                dtTireType = dsFetchTireType.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtTireType.Rows
                    Dim tireTypeDet As New TirePackageBO()
                    tireTypeDet.tireTypeVal = dtrow("TireId").ToString()
                    tireTypeDet.tireTypeDesc = dtrow("TireType").ToString()
                    tireTypeDet.tirePackageVal = dtrow("TireTypeVariable").ToString()
                    tireType.Add(tireTypeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "getTireType", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tireType.ToList
        End Function

        Public Function FetchTireSpike() As List(Of TirePackageBO)
            Dim dsFetchTireType As New DataSet
            Dim dtTireType As DataTable
            Dim tireType As New List(Of TirePackageBO)()
            Try
                dsFetchTireType = objTirePackageDO.FetchTireSpike()
                dtTireType = dsFetchTireType.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtTireType.Rows
                    Dim tireTypeDet As New TirePackageBO()
                    tireTypeDet.tireSpikesVal = dtrow("TireId").ToString()
                    tireTypeDet.tireSpikesDesc = dtrow("TireSpikes").ToString()
                    tireType.Add(tireTypeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchTireSpike", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tireType.ToList
        End Function

        Public Function FetchTireRimType() As List(Of TirePackageBO)
            Dim dsFetchTireType As New DataSet
            Dim dtTireType As DataTable
            Dim tireType As New List(Of TirePackageBO)()
            Try
                dsFetchTireType = objTirePackageDO.FetchTireRimType()
                dtTireType = dsFetchTireType.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtTireType.Rows
                    Dim tireTypeDet As New TirePackageBO()
                    tireTypeDet.tireRimVal = dtrow("TireId").ToString()
                    tireTypeDet.tireRimDesc = dtrow("TireRimType").ToString()
                    tireType.Add(tireTypeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchTireRimType", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tireType.ToList
        End Function

        Public Function FetchTireQuality() As List(Of TirePackageBO)
            Dim dsFetchTireType As New DataSet
            Dim dtTireType As DataTable
            Dim tireType As New List(Of TirePackageBO)()
            Try
                dsFetchTireType = objTirePackageDO.FetchTireQuality()
                dtTireType = dsFetchTireType.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtTireType.Rows
                    Dim tireTypeDet As New TirePackageBO()
                    tireTypeDet.tireQualityVal = dtrow("TireQuality").ToString()
                    tireTypeDet.tireQualityDesc = dtrow("TireQualityText").ToString()
                    tireType.Add(tireTypeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchTireQuality", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tireType.ToList
        End Function

        Public Function FetchTireDepth() As List(Of TirePackageBO)
            Dim dsFetchTireType As New DataSet
            Dim dtTireType As DataTable
            Dim tireType As New List(Of TirePackageBO)()
            Try
                dsFetchTireType = objTirePackageDO.FetchTireDepth()
                dtTireType = dsFetchTireType.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtTireType.Rows
                    Dim tireTypeDet As New TirePackageBO()
                    tireTypeDet.tireDepthVal = dtrow("TireDepth").ToString()
                    tireTypeDet.tireDepthDesc = dtrow("TireDepthText").ToString()
                    tireType.Add(tireTypeDet)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchTireDepth", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return tireType.ToList
        End Function


        Public Function FindVehicleList(ByVal search As String) As List(Of TirePackageBO)
            Dim dsVehicleList As New DataSet
            Dim dtVehicleList As DataTable
            Dim vehicleListResult As New List(Of TirePackageBO)()

            Try
                dsVehicleList = objTirePackageDO.FindVehicleList(search)

                If dsVehicleList.Tables.Count > 0 Then
                    dtVehicleList = dsVehicleList.Tables(0)
                End If

                For Each dtrow As DataRow In dtVehicleList.Rows
                    Dim vl As New TirePackageBO()

                    vl.refNo = dtrow("VEH_INTERN_NO").ToString
                    vl.regNo = dtrow("VEH_REG_NO").ToString
                    vl.make = dtrow("ID_MAKE_VEH").ToString
                    vl.model = dtrow("VEH_TYPE").ToString
                    vl.tireDimFront = dtrow("VEH_STD_TIRE_FRONT").ToString
                    vl.tireDimBack = dtrow("VEH_STD_TIRE_BACK").ToString
                    vl.vehicle_group = dtrow("ID_GROUP_VEH").ToString
                    'vl.id_customer = dtrow("ID_CUSTOMER_VEH").ToString
                    'vl.custfName = dtrow("CUST_FIRST_NAME").ToString
                    'vl.custmName = dtrow("CUST_MIDDLE_NAME").ToString
                    'vl.custlName = dtrow("CUST_LAST_NAME").ToString
                    'vl.flg_private_comp = dtrow("FLG_PRIVATE_COMP").ToString
                    'vl.cust_add1 = dtrow("CUST_PERM_ADD1").ToString
                    'vl.cust_zipcode = dtrow("ID_CUST_PERM_ZIPCODE").ToString
                    'vl.cust_place = dtrow("CUST_PERM_PLACE").ToString
                    'vl.custmobile = dtrow("CUST_PHONE_MOBILE").ToString
                    'vl.custmail = dtrow("CUST_MAIL_ADDRESS").ToString

                    vehicleListResult.Add(vl)
                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FindVehicleList", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return vehicleListResult
        End Function

        Public Function FetchVehicleDetails(ByVal refNo As String) As List(Of TirePackageBO)
            Dim dsVehicleItems As New DataSet
            Dim dtVehicleItems As DataTable
            Dim vehicleResult As New List(Of TirePackageBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsVehicleItems = objTirePackageDO.FetchVehicleDetails(refNo)

                If dsVehicleItems.Tables.Count > 0 Then
                    dtVehicleItems = dsVehicleItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtVehicleItems.Rows
                    Dim vl As New TirePackageBO()
                    vl.refNo = dtrow("VEH_INTERN_NO").ToString
                    vl.regNo = dtrow("VEH_REG_NO").ToString
                    vl.make = dtrow("ID_MAKE_VEH").ToString
                    vl.model = dtrow("VEH_TYPE").ToString
                    vl.tireDimFront = dtrow("VEH_STD_TIRE_FRONT").ToString
                    vl.tireDimBack = dtrow("VEH_STD_TIRE_BACK").ToString
                    vl.vehicle_group = dtrow("ID_GROUP_VEH").ToString
                    vl.id_customer = dtrow("ID_CUSTOMER_VEH").ToString
                    'vl.custfName = dtrow("CUST_FIRST_NAME").ToString
                    'vl.custmName = dtrow("CUST_MIDDLE_NAME").ToString
                    'vl.custlName = dtrow("CUST_LAST_NAME").ToString
                    'vl.flg_private_comp = dtrow("FLG_PRIVATE_COMP").ToString
                    'vl.cust_add1 = dtrow("CUST_PERM_ADD1").ToString
                    'vl.cust_zipcode = dtrow("ID_CUST_PERM_ZIPCODE").ToString
                    'vl.cust_place = dtrow("CUST_PERM_PLACE").ToString
                    'vl.custmobile = dtrow("CUST_PHONE_MOBILE").ToString
                    'vl.custmail = dtrow("CUST_MAIL_ADDRESS").ToString

                    vehicleResult.Add(vl)

                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchVehicleDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return vehicleResult
        End Function

        Public Function FindCustomerList(ByVal search As String) As List(Of TirePackageBO)
            Dim dsCustomerList As New DataSet
            Dim dtCustomerList As DataTable
            Dim customerListResult As New List(Of TirePackageBO)()

            Try
                dsCustomerList = objTirePackageDO.FindCustomerList(search)

                If dsCustomerList.Tables.Count > 0 Then
                    dtCustomerList = dsCustomerList.Tables(0)
                End If

                For Each dtrow As DataRow In dtCustomerList.Rows
                    Dim cl As New TirePackageBO()
                    cl.id_customer = dtrow("ID_CUSTOMER").ToString
                    cl.custfName = dtrow("CUST_FIRST_NAME").ToString
                    cl.custmName = dtrow("CUST_MIDDLE_NAME").ToString
                    cl.custlName = dtrow("CUST_LAST_NAME").ToString
                    cl.flg_private_comp = dtrow("FLG_PRIVATE_COMP").ToString
                    cl.cust_add1 = dtrow("CUST_PERM_ADD1").ToString
                    cl.cust_zipcode = dtrow("ID_CUST_PERM_ZIPCODE").ToString
                    cl.cust_place = dtrow("CUST_PERM_PLACE").ToString
                    cl.custmobile = dtrow("CUST_PHONE_MOBILE").ToString
                    cl.custmail = dtrow("CUST_MAIL_ADDRESS").ToString

                    customerListResult.Add(cl)
                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FindCustomerList", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return customerListResult
        End Function

        Public Function FetchCustomerDetails(ByVal custNo As String) As List(Of TirePackageBO)
            Dim dsCustomerItems As New DataSet
            Dim dtCustomerItems As DataTable
            Dim customerResult As New List(Of TirePackageBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsCustomerItems = objTirePackageDO.FetchCustomerDetails(custNo)

                If dsCustomerItems.Tables.Count > 0 Then
                    dtCustomerItems = dsCustomerItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtCustomerItems.Rows
                    Dim cl As New TirePackageBO()
                    cl.id_customer = dtrow("ID_CUSTOMER").ToString
                    cl.custfName = dtrow("CUST_FIRST_NAME").ToString
                    cl.custmName = dtrow("CUST_MIDDLE_NAME").ToString
                    cl.custlName = dtrow("CUST_LAST_NAME").ToString
                    cl.flg_private_comp = dtrow("FLG_PRIVATE_COMP").ToString
                    cl.cust_add1 = dtrow("CUST_PERM_ADD1").ToString
                    cl.cust_zipcode = dtrow("ID_CUST_PERM_ZIPCODE").ToString
                    cl.cust_place = dtrow("CUST_PERM_PLACE").ToString
                    cl.custmobile = dtrow("CUST_PHONE_MOBILE").ToString
                    cl.custmail = dtrow("CUST_MAIL_ADDRESS").ToString

                    customerResult.Add(cl)

                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "FetchCustomerDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return customerResult
        End Function

        Public Function Add_TP_Item(ByVal TPitem As TirePackageBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objTirePackageDO.Add_TP_Item(TPitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.TirePackage", "Add_TP_Item", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function FetchTirePackageDetails(ByVal packageNo As String) As List(Of TirePackageBO)
            Dim dsPackageItems As New DataSet
            Dim dtPackageItems As DataTable
            Dim packageResult As New List(Of TirePackageBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsPackageItems = objTirePackageDO.FetchTirePackageDetails(packageNo)

                If dsPackageItems.Tables.Count > 0 Then
                    dtPackageItems = dsPackageItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtPackageItems.Rows
                    Dim tp As New TirePackageBO()
                    tp.refNo = dtrow("refNo").ToString
                    tp.regNo = dtrow("regNo").ToString
                    tp.custNo = dtrow("custNo").ToString
                    tp.tirePackageNo = dtrow("tirePackageNo").ToString
                    tp.qtyTire = dtrow("qtyTire").ToString
                    tp.location = dtrow("location").ToString
                    tp.tireTypeVal = dtrow("tireTypeVal").ToString
                    tp.tireDimFront = dtrow("tireDimFront").ToString
                    tp.tireDimBack = dtrow("tireDimBack").ToString
                    tp.tireSpikesVal = dtrow("tireSpikesVal").ToString
                    tp.tireRimVal = dtrow("tireRimVal").ToString
                    tp.tireBrandVal = dtrow("tireBrandVal").ToString
                    tp.tireQualityVal = dtrow("tireQualityVal").ToString
                    tp.tireAxleNoVal = dtrow("tireAxleNoVal").ToString
                    'tp.outDate = dtrow("outDate").ToString
                    tp.outDate = objCommonUtil.GetCurrentLanguageDate(dtrow("outDate").ToString)
                    tp.tireBolts = dtrow("tireBolts").ToString
                    tp.tireCap = dtrow("tireCap").ToString
                    tp.tireAnnot = dtrow("tireAnnot").ToString
                    tp.tirePackageVal = dtrow("tirePackageVal").ToString
                    tp.tireSeqNumber = dtrow("Seq_No").ToString

                    packageResult.Add(tp)

                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.TirePackage", "FetchTirePackageDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return packageResult
        End Function

        Public Function Close_TP_Item(ByVal TPitem As TirePackageBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objTirePackageDO.Close_TP_Item(TPitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.TirePackage", "Close_TP_Item", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function AddTireDepth(ByVal TPDitem As TirePackageBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objTirePackageDO.AddTireDepth(TPDitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.TirePackage", "AddTireDepth", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function FetchTirePackageDepth(ByVal packageNo As String) As List(Of TirePackageBO)
            Dim dsPackageItems As New DataSet
            Dim dtPackageItems As DataTable
            Dim packageResult As New List(Of TirePackageBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsPackageItems = objTirePackageDO.FetchTirePackageDepth(packageNo)

                If dsPackageItems.Tables.Count > 0 Then
                    dtPackageItems = dsPackageItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtPackageItems.Rows
                    Dim tp As New TirePackageBO()
                    If (IsDBNull(dtrow("TIRE_PACKAGE_NO").ToString())) Then
                        tp.refNo = ""
                        tp.regNo = ""
                        tp.tirePackageNo = ""
                        tp.tireAxleNoVal = 0
                        tp.tireDepth1L = ""
                        tp.tireDepth2L = ""
                        tp.tireDepth2L2 = ""
                        tp.tireDepth3L = ""
                        tp.tireDepth3L2 = ""
                        tp.tireDepth4L = ""
                        tp.tireDepth4L2 = ""
                        tp.tireDepth5L = ""
                        tp.tireDepth5L2 = ""
                        tp.tireDepth6L = ""
                        tp.tireDepth6L2 = ""
                        tp.tireDepth1R = ""
                        tp.tireDepth2R = ""
                        tp.tireDepth2R2 = ""
                        tp.tireDepth3R = ""
                        tp.tireDepth3R2 = ""
                        tp.tireDepth4R = ""
                        tp.tireDepth4R2 = ""
                        tp.tireDepth5R = ""
                        tp.tireDepth5R2 = ""
                        tp.tireDepth6R = ""
                        tp.tireDepth6R2 = ""
                    Else
                        tp.refNo = IIf(IsDBNull(dtrow("REF_NO")), "", dtrow("REF_NO").ToString())
                        tp.regNo = IIf(IsDBNull(dtrow("REG_NO")), "", dtrow("REG_NO").ToString())
                        tp.tirePackageNo = IIf(IsDBNull(dtrow("TIRE_PACKAGE_NO")), "", dtrow("TIRE_PACKAGE_NO").ToString())
                        tp.tireAxleNoVal = IIf(IsDBNull(dtrow("AXLE_NO_VAL")), "", dtrow("AXLE_NO_VAL").ToString())
                        tp.tireDepth1L = IIf(IsDBNull(dtrow("DEPTH1L")), "", dtrow("DEPTH1L").ToString())
                        tp.tireDepth2L = IIf(IsDBNull(dtrow("DEPTH2L")), "", dtrow("DEPTH2L").ToString())
                        tp.tireDepth2L2 = IIf(IsDBNull(dtrow("DEPTH2L2")), "", dtrow("DEPTH2L2").ToString())
                        tp.tireDepth3L = IIf(IsDBNull(dtrow("DEPTH3L")), "", dtrow("DEPTH3L").ToString())
                        tp.tireDepth3L2 = IIf(IsDBNull(dtrow("DEPTH3L2")), "", dtrow("DEPTH3L2").ToString())
                        tp.tireDepth4L = IIf(IsDBNull(dtrow("DEPTH4L")), "", dtrow("DEPTH4L").ToString())
                        tp.tireDepth4L2 = IIf(IsDBNull(dtrow("DEPTH4L2")), "", dtrow("DEPTH4L2").ToString())
                        tp.tireDepth5L = IIf(IsDBNull(dtrow("DEPTH5L")), "", dtrow("DEPTH5L").ToString())
                        tp.tireDepth5L2 = IIf(IsDBNull(dtrow("DEPTH5L2")), "", dtrow("DEPTH5L2").ToString())
                        tp.tireDepth6L = IIf(IsDBNull(dtrow("DEPTH6L")), "", dtrow("DEPTH6L").ToString())
                        tp.tireDepth6L2 = IIf(IsDBNull(dtrow("DEPTH6L2")), "", dtrow("DEPTH6L2").ToString())
                        tp.tireDepth1R = IIf(IsDBNull(dtrow("DEPTH1R")), "", dtrow("DEPTH1R").ToString())
                        tp.tireDepth2R = IIf(IsDBNull(dtrow("DEPTH2R")), "", dtrow("DEPTH2R").ToString())
                        tp.tireDepth2R2 = IIf(IsDBNull(dtrow("DEPTH2R2")), "", dtrow("DEPTH2R2").ToString())
                        tp.tireDepth3R = IIf(IsDBNull(dtrow("DEPTH3R")), "", dtrow("DEPTH3R").ToString())
                        tp.tireDepth3R2 = IIf(IsDBNull(dtrow("DEPTH3R2")), "", dtrow("DEPTH3R2").ToString())
                        tp.tireDepth4R = IIf(IsDBNull(dtrow("DEPTH4R")), "", dtrow("DEPTH4R").ToString())
                        tp.tireDepth4R2 = IIf(IsDBNull(dtrow("DEPTH4R2")), "", dtrow("DEPTH4R2").ToString())
                        tp.tireDepth5R = IIf(IsDBNull(dtrow("DEPTH5R")), "", dtrow("DEPTH5R").ToString())
                        tp.tireDepth5R2 = IIf(IsDBNull(dtrow("DEPTH5R2")), "", dtrow("DEPTH5R2").ToString())
                        tp.tireDepth6R = IIf(IsDBNull(dtrow("DEPTH6R")), "", dtrow("DEPTH6R").ToString())
                        tp.tireDepth6R2 = IIf(IsDBNull(dtrow("DEPTH6R2")), "", dtrow("DEPTH6R2").ToString())
                    End If

                    packageResult.Add(tp)

                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.TirePackage", "FetchTirePackageDepth", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return packageResult
        End Function

        Public Function LoadListCustVehicle(ByVal custId As String) As List(Of TirePackageBO)
            Dim dsFetchCustVehicle As New DataSet
            Dim dtFetchCustVehicle As DataTable
            Dim ListCustVehicle As New List(Of TirePackageBO)()
            Try
                dsFetchCustVehicle = objTirePackageDO.LoadListCustVehicle(custId)
                dtFetchCustVehicle = dsFetchCustVehicle.Tables(0)
                'HttpContext.Current.Session("dvSubsidiaryList") = dtSubDetails.DefaultView
                For Each dtrow As DataRow In dtFetchCustVehicle.Rows
                    Dim CustVehicle As New TirePackageBO()
                    CustVehicle.refNo = dtrow("VEH_INTERN_NO").ToString()
                    CustVehicle.regNo = dtrow("VEH_REG_NO").ToString()
                    CustVehicle.make = dtrow("ID_MAKE_VEH").ToString()
                    CustVehicle.model = dtrow("VEH_TYPE").ToString()
                    CustVehicle.regDate = dtrow("VEH_MDL_YEAR").ToString()
                    ListCustVehicle.Add(CustVehicle)
                Next
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "LoadListCustVehicle", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return ListCustVehicle.ToList
        End Function

        Public Function CreateOrderOnTireHotel(ByVal hireHotelSeqNo As String, ByVal userId As String) As String
            Dim strResult As String = ""
            Try
                strResult = objTirePackageDO.CreateOrderOnTireHotel(hireHotelSeqNo, userId)
            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "TirePackage.vb", "CreateOrderOnTireHotel", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult
        End Function

        Public Function Delete_TP_Item(ByVal TPitem As String) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objTirePackageDO.Delete_TP_Item(TPitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.Customer", "Insert_Customer", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function GENERATE_TP_SELECTION(ByVal warehouse As String, ByVal department As String, ByVal tiretype As String, ByVal spikesornot As String, ByVal rimtype As String, ByVal tirebrand As String, ByVal tirequality As String, ByVal tiredepth As String, ByVal locationfrom As String, ByVal locationto As String) As List(Of TirePackageBO)
            Dim dsTpSelection As New DataSet
            Dim dtTpSelection As DataTable
            Dim retTpSelection As New List(Of TirePackageBO)()
            Try
                dsTpSelection = objTirePackageDO.GENERATE_TP_SELECTION(warehouse, department, tiretype, spikesornot, rimtype, tirebrand, tirequality, tiredepth, locationfrom, locationto)

                If dsTpSelection.Tables.Count > 0 Then
                    HttpContext.Current.Session("TPSelection") = dsTpSelection
                    dtTpSelection = dsTpSelection.Tables(0)
                End If

                For Each dtrow As DataRow In dtTpSelection.Rows
                    Dim tpDet As New TirePackageBO()
                    tpDet.custNo = dtrow("custNo").ToString()
                    tpDet.regNo = dtrow("regNo").ToString()
                    tpDet.refNo = dtrow("refNo").ToString()
                    tpDet.custfName = dtrow("custName").ToString()
                    tpDet.custmName = dtrow("custmName").ToString()
                    If tpDet.custmName <> "" Then
                        tpDet.custfName += " " + dtrow("custmName").ToString()
                    End If
                    tpDet.custfName += " " + dtrow("custlName").ToString()
                    tpDet.custlName = dtrow("custlName").ToString()
                    tpDet.custmobile = dtrow("MOBILE").ToString()
                    tpDet.tirePackageNo = dtrow("tirePackageNo").ToString()
                    tpDet.tireDimFront = dtrow("tireDimFront").ToString()
                    tpDet.tireDimBack = dtrow("tireDimBack").ToString()
                    tpDet.location = dtrow("location").ToString()
                    tpDet.tireTypeDesc = dtrow("tireTypeDesc").ToString()
                    tpDet.tireSpikesDesc = dtrow("tireSpikesDesc").ToString()
                    tpDet.tireRimDesc = dtrow("tireRimDesc").ToString()
                    tpDet.tireBrandDesc = dtrow("tireBrandDesc").ToString()
                    tpDet.tireQualityDesc = dtrow("tireQualityDesc").ToString()

                    retTpSelection.Add(tpDet)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return retTpSelection
        End Function

    End Class
End Namespace