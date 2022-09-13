Imports CARS.CoreLibrary.CARS
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports System.Data.Common
Imports System.Web.Services

Public Class TirePackageDO
    Dim ConnectionString As String
    Dim objDB As Database
    Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
    Shared objCommonUtil As New Utilities.CommonUtility
    Public Sub New()
        ConnectionString = System.Configuration.ConfigurationManager.AppSettings("MSGConstr")
        objDB = New SqlDatabase(ConnectionString)
    End Sub

    Public Function Fetch_TP_List(ByVal wh As String, ByVal tpNo As String, ByVal closed As String, ByVal refNo As String, ByVal custNo As String, ByVal tireType As String, ByVal tireQuality As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_NO_LIST")
                objDB.AddInParameter(objcmd, "@Warehouse", DbType.String, wh)
                objDB.AddInParameter(objcmd, "@tpNo", DbType.String, tpNo)
                objDB.AddInParameter(objcmd, "@closed", DbType.String, closed)
                objDB.AddInParameter(objcmd, "@refNo", DbType.String, refNo)
                objDB.AddInParameter(objcmd, "@custNo", DbType.String, custNo)
                objDB.AddInParameter(objcmd, "@tireType", DbType.String, tireType)
                objDB.AddInParameter(objcmd, "@tireQuality", DbType.String, tireQuality)


                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchTireMake() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TIREMAKE")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function FetchTireType() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TIRETYPE")
                objDB.AddInParameter(objcmd, "@value", DbType.String, "")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function getTireType(value) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TIRETYPE")
                objDB.AddInParameter(objcmd, "@value", DbType.String, value)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function FetchTireSpike() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TIRESPIKE")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function FetchTireRimType() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TIRE_RIMTYPE")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function FetchTireQuality() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TIRE_QUALITY")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function FetchTireDepth() As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TIRE_DEPTH")
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function FindVehicleList(ByVal search As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_VEHICLE_LIST")
                objDB.AddInParameter(objcmd, "@Search", DbType.String, search)

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchVehicleDetails(ByVal refNo As String) As DataSet
        Try

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_VEHICLE_DETAIL")
                objDB.AddInParameter(objcmd, "@refNo", DbType.String, refNo)


                Return objDB.ExecuteDataSet(objcmd)

            End Using

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FindCustomerList(ByVal search As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_CUSTOMER_DETAIL")
                objDB.AddInParameter(objcmd, "@Search", DbType.String, search)
                objDB.AddInParameter(objcmd, "@custNo", DbType.String, "")

                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchCustomerDetails(ByVal custNo As String) As DataSet
        Try

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_CUSTOMER_DETAIL")
                objDB.AddInParameter(objcmd, "@Search", DbType.String, "")
                objDB.AddInParameter(objcmd, "@custNo", DbType.String, custNo)


                Return objDB.ExecuteDataSet(objcmd)

            End Using

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function Add_TP_Item(ByVal TPitem As TirePackageBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer
            Dim outParam As String = ""

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_NO_INSERT")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@refNo", DbType.String, TPitem.refNo)
                objDB.AddInParameter(objcmd, "@regNo", DbType.String, TPitem.regNo)
                objDB.AddInParameter(objcmd, "@custNo", DbType.String, TPitem.custNo)
                objDB.AddInParameter(objcmd, "@custName", DbType.String, TPitem.custName)
                objDB.AddInParameter(objcmd, "@tirePackageNo", DbType.String, TPitem.tirePackageNo)
                objDB.AddInParameter(objcmd, "@qtyTire", DbType.String, TPitem.qtyTire)
                objDB.AddInParameter(objcmd, "@tireDimFront", DbType.String, TPitem.tireDimFront)
                objDB.AddInParameter(objcmd, "@tireDimBack", DbType.String, TPitem.tireDimBack)
                objDB.AddInParameter(objcmd, "@location", DbType.String, TPitem.location)
                objDB.AddInParameter(objcmd, "@tireTypeVal", DbType.String, TPitem.tireTypeVal)
                objDB.AddInParameter(objcmd, "@tireTypeDesc", DbType.String, TPitem.tireTypeDesc)
                objDB.AddInParameter(objcmd, "@tireSpikesVal", DbType.String, TPitem.tireSpikesVal)
                objDB.AddInParameter(objcmd, "@tireSpikesDesc", DbType.String, TPitem.tireSpikesDesc)
                objDB.AddInParameter(objcmd, "@tireRimVal", DbType.String, TPitem.tireRimVal)
                objDB.AddInParameter(objcmd, "@tireRimDesc", DbType.String, TPitem.tireRimDesc)
                objDB.AddInParameter(objcmd, "@tireBrandVal", DbType.String, TPitem.tireBrandVal)
                objDB.AddInParameter(objcmd, "@tireBrandDesc", DbType.String, TPitem.tireBrandDesc)
                objDB.AddInParameter(objcmd, "@tireQualityVal", DbType.String, TPitem.tireQualityVal)
                objDB.AddInParameter(objcmd, "@tireQualityDesc", DbType.String, TPitem.tireQualityDesc)
                objDB.AddInParameter(objcmd, "@tireAxleNoVal", DbType.String, TPitem.tireAxleNoVal)
                objDB.AddInParameter(objcmd, "@tireAxleNoDesc", DbType.String, TPitem.tireAxleNoDesc)
                'objDB.AddInParameter(objcmd, "@outDate", DbType.String, TPitem.outDate)
                objDB.AddInParameter(objcmd, "@outDate", DbType.String, IIf(TPitem.outDate = "", "", objCommonUtil.GetDefaultDate_MMDDYYYY(TPitem.outDate)))
                objDB.AddInParameter(objcmd, "@tireBolts", DbType.String, TPitem.tireBolts)
                objDB.AddInParameter(objcmd, "@tireCap", DbType.String, TPitem.tireCap)
                objDB.AddInParameter(objcmd, "@tireAnnot", DbType.String, TPitem.tireAnnot)
                objDB.AddInParameter(objcmd, "@custmName", DbType.String, TPitem.custmName)
                objDB.AddInParameter(objcmd, "@custlName", DbType.String, TPitem.custlName)
                objDB.AddInParameter(objcmd, "@tirePackageVal", DbType.String, TPitem.tirePackageVal)
                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                Try
                    objDB.ExecuteNonQuery(objcmd)
                    outParam = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    If (outParam = "INSFLG") Then
                        strStatus = 0
                    Else
                        strStatus = 1
                    End If
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return strStatus

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchTirePackageDetails(ByVal packageNo As String) As DataSet
        Try

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_TP_DETAIL")
                objDB.AddInParameter(objcmd, "@packageNo", DbType.String, packageNo)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function Close_TP_Item(ByVal TPitem As TirePackageBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer


            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_NO_CLOSE")
                objDB.AddInParameter(objcmd, "@packageNo", DbType.String, TPitem.tirePackageNo)
                Try
                    objDB.ExecuteNonQuery(objcmd)
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try
            End Using
            Return strStatus
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function AddTireDepth(ByVal TPDitem As TirePackageBO, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer
            Dim outParam As String = ""

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_ADD_DEPTH")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@refNo", DbType.String, TPDitem.refNo)
                objDB.AddInParameter(objcmd, "@regNo", DbType.String, TPDitem.regNo)
                objDB.AddInParameter(objcmd, "@tirePackageNo", DbType.String, TPDitem.tirePackageNo)
                objDB.AddInParameter(objcmd, "@tireAxleNoVal", DbType.String, TPDitem.tireAxleNoVal)
                If TPDitem.tireDepth1L = "" Then
                    TPDitem.tireDepth1L = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth1L", DbType.Decimal, TPDitem.tireDepth1L)
                If TPDitem.tireDepth2L = "" Then
                    TPDitem.tireDepth2L = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth2L", DbType.Decimal, TPDitem.tireDepth2L)
                If TPDitem.tireDepth2L2 = "" Then
                    TPDitem.tireDepth2L2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth2L2", DbType.Decimal, TPDitem.tireDepth2L2)
                If TPDitem.tireDepth3L = "" Then
                    TPDitem.tireDepth3L = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth3L", DbType.Decimal, TPDitem.tireDepth3L)
                If TPDitem.tireDepth3L2 = "" Then
                    TPDitem.tireDepth3L2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth3L2", DbType.Decimal, TPDitem.tireDepth3L2)
                If TPDitem.tireDepth4L = "" Then
                    TPDitem.tireDepth4L = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth4L", DbType.Decimal, TPDitem.tireDepth4L)
                If TPDitem.tireDepth4L2 = "" Then
                    TPDitem.tireDepth4L2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth4L2", DbType.Decimal, TPDitem.tireDepth4L2)
                If TPDitem.tireDepth5L = "" Then
                    TPDitem.tireDepth5L = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth5L", DbType.Decimal, TPDitem.tireDepth5L)
                If TPDitem.tireDepth5L2 = "" Then
                    TPDitem.tireDepth5L2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth5L2", DbType.Decimal, TPDitem.tireDepth5L2)
                If TPDitem.tireDepth6L = "" Then
                    TPDitem.tireDepth6L = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth6L", DbType.Decimal, TPDitem.tireDepth6L)
                If TPDitem.tireDepth6L2 = "" Then
                    TPDitem.tireDepth6L2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth6L2", DbType.Decimal, TPDitem.tireDepth6L2)
                If TPDitem.tireDepth1R = "" Then
                    TPDitem.tireDepth1R = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth1R", DbType.Decimal, TPDitem.tireDepth1R)
                If TPDitem.tireDepth2R = "" Then
                    TPDitem.tireDepth2R = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth2R", DbType.Decimal, TPDitem.tireDepth2R)
                If TPDitem.tireDepth2R2 = "" Then
                    TPDitem.tireDepth2R2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth2R2", DbType.Decimal, TPDitem.tireDepth2R2)
                If TPDitem.tireDepth3R = "" Then
                    TPDitem.tireDepth3R = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth3R", DbType.Decimal, TPDitem.tireDepth3R)
                If TPDitem.tireDepth3R2 = "" Then
                    TPDitem.tireDepth3R2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth3R2", DbType.Decimal, TPDitem.tireDepth3R2)
                If TPDitem.tireDepth4R = "" Then
                    TPDitem.tireDepth4R = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth4R", DbType.Decimal, TPDitem.tireDepth4R)
                If TPDitem.tireDepth4R2 = "" Then
                    TPDitem.tireDepth4R2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth4R2", DbType.Decimal, TPDitem.tireDepth4R2)
                If TPDitem.tireDepth5R = "" Then
                    TPDitem.tireDepth5R = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth5R", DbType.Decimal, TPDitem.tireDepth5R)
                If TPDitem.tireDepth5R2 = "" Then
                    TPDitem.tireDepth5R2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth5R2", DbType.Decimal, TPDitem.tireDepth5R2)
                If TPDitem.tireDepth6R = "" Then
                    TPDitem.tireDepth6R = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth6R", DbType.Decimal, TPDitem.tireDepth6R)
                If TPDitem.tireDepth6R2 = "" Then
                    TPDitem.tireDepth6R2 = 0.00
                End If
                objDB.AddInParameter(objcmd, "@tireDepth6R2", DbType.Decimal, TPDitem.tireDepth6R2)


                objDB.AddOutParameter(objcmd, "@OV_RETVALUE", DbType.String, 50)

                Try
                    objDB.ExecuteNonQuery(objcmd)
                    outParam = objDB.GetParameterValue(objcmd, "@OV_RETVALUE").ToString
                    If (outParam = "INSFLG") Then
                        strStatus = 0
                    Else
                        strStatus = 1
                    End If
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return strStatus

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function FetchTirePackageDepth(ByVal packageNo As String) As DataSet
        Try

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_FETCH_DEPTH")
                objDB.AddInParameter(objcmd, "@packageNo", DbType.String, packageNo)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function LoadListCustVehicle(ByVal custId As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_LOAD_LIST_CUSTOMER_VEHICLES")
                objDB.AddInParameter(objcmd, "@CUSTID", DbType.String, custId)
                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function CreateOrderOnTireHotel(ByVal hireHotelSeqNo As String, ByVal userId As String) As String
        Dim outParam As String = ""

        Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_CREATE_TIRE_ORDER_PACKAGE_ORDER")
            objDB.AddInParameter(objcmd, "@Tire_Seq_No", DbType.String, hireHotelSeqNo)
            objDB.AddInParameter(objcmd, "@IV_USERID", DbType.String, userId)
            objDB.AddOutParameter(objcmd, "@IV_RETVALUE", DbType.String, 50)
            Try
                objDB.ExecuteNonQuery(objcmd)
                outParam = objDB.GetParameterValue(objcmd, "@IV_RETVALUE").ToString
                Return outParam
            Catch ex As Exception
                Dim theex = ex.GetType()
                Throw ex
            End Try

        End Using
    End Function

    Public Function Delete_TP_Item(ByVal TPitem As String, ByVal login As String) As Integer
        Try
            Dim strStatus As Integer = 0

            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_TIRE_PACKAGE_DELETE")

                objDB.AddInParameter(objcmd, "@USER", DbType.String, login)
                objDB.AddInParameter(objcmd, "@TIREPACKAGENO", DbType.String, TPitem)
                objDB.AddInParameter(objcmd, "@CLOSED", DbType.Boolean, 0)

                Try
                    objDB.ExecuteNonQuery(objcmd)


                    strStatus = 1
                Catch ex As Exception
                    Dim theex = ex.GetType()
                    Throw ex
                End Try

            End Using
            Return strStatus

        Catch ex As Exception
            Dim theex = ex.GetType()
            Throw ex
        End Try
    End Function

    Public Function GENERATE_TP_SELECTION(ByVal warehouse As String, ByVal department As String, ByVal tiretype As String, ByVal spikesornot As String, ByVal rimtype As String, ByVal tirebrand As String, ByVal tirequality As String, ByVal tiredepth As String, ByVal locationfrom As String, ByVal locationto As String) As DataSet
        Try
            Using objcmd As DbCommand = objDB.GetStoredProcCommand("USP_GENERATE_TP_SELECTION")
                objDB.AddInParameter(objcmd, "@WAREHOUSE", DbType.Int32, warehouse)
                objDB.AddInParameter(objcmd, "@DEPARTMENT", DbType.Int32, department)
                objDB.AddInParameter(objcmd, "@TIRETYPE", DbType.Int32, tiretype)
                objDB.AddInParameter(objcmd, "@SPIKESORNOT", DbType.Int32, spikesornot)
                objDB.AddInParameter(objcmd, "@RIMTYPE", DbType.Int32, rimtype)
                objDB.AddInParameter(objcmd, "@TIREBRAND", DbType.Int32, tirebrand)
                objDB.AddInParameter(objcmd, "@TIREQUALITY", DbType.Int32, tirequality)
                objDB.AddInParameter(objcmd, "@TIREDEPTH", DbType.Decimal, tiredepth)
                objDB.AddInParameter(objcmd, "@LOCATIONFROM", DbType.String, locationfrom)
                objDB.AddInParameter(objcmd, "@LOCATIONTO", DbType.String, locationto)


                Return objDB.ExecuteDataSet(objcmd)
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function


End Class
