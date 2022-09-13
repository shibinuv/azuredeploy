Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports System.Drawing
Imports System.Web.Script.Serialization.JavaScriptSerializer
Imports System.Object
Imports System.MarshalByRefObject
Imports System.Net.WebRequest
Imports System.Net.HttpWebRequest
Imports System.Net.HttpWebResponse
Imports System.Net
Imports System.Web
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls.WebParts
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Namespace CARS.Services.RepPackage
    Public Class RepPackage
        Shared objRepPackageBO As New RepPackageBO
        Shared objRepPackageDO As New RepPackageDO
        Shared objErrHandle As New MSGCOMMON.MsgErrorHndlr
        Shared objWOJ As New CARS.Services.WOJobDetails.WOJobDetails

        Public Function Add_RP_Head(ByVal RPitem As RepPackageBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objRepPackageDO.Add_RP_Head(RPitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.RepPackage", "Add_RP_Head", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function Add_RP_Item(ByVal RPitem As RepPackageBO) As Integer

            Dim strResult As Integer

            Dim login As String = HttpContext.Current.Session("UserID")
            Try
                strResult = objRepPackageDO.Add_RP_Item(RPitem, login)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.RepPackage", "Add_RP_Item", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function Fetch_RP_List(ByVal jobid As String, ByVal wh As String, ByVal make As String, ByVal title As String) As List(Of RepPackageBO)
            Dim dsRPItems As New DataSet
            Dim dtRPItems As DataTable
            Dim repPackageResult As New List(Of RepPackageBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsRPItems = objRepPackageDO.Fetch_RP_List(jobid, wh, make, title)

                If dsRPItems.Tables.Count > 0 Then
                    dtRPItems = dsRPItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtRPItems.Rows
                    Dim item As New RepPackageBO()


                    item.JOB_ID = dtrow("ID_RP_CODE").ToString
                    item.JOB_TITLE = dtrow("RP_DESC").ToString
                    item.MAKE = dtrow("ID_MAKE_RP").ToString
                    item.OPERATION_CODE = dtrow("OPERATION_CODE")
                    item.JOB_CLASS = dtrow("JOB_CLASS")
                    item.FIXED_PRICE = dtrow("FLG_FIX_PRICE")
                    item.ADD_GM = dtrow("FLG_GM_PRICE_CHNG")


                    repPackageResult.Add(item)

                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.RepPackage", "Fetch_RP_List", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return repPackageResult
        End Function

        Public Function FetchRPHead(ByVal packageNo As String) As List(Of RepPackageBO)
            Dim dsPackageItems As New DataSet
            Dim dtPackageItems As DataTable
            Dim packageResult As New List(Of RepPackageBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsPackageItems = objRepPackageDO.FetchRPHead(packageNo)

                If dsPackageItems.Tables.Count > 0 Then
                    dtPackageItems = dsPackageItems.Tables(0)
                End If

                For Each dtrow As DataRow In dtPackageItems.Rows
                    Dim rp As New RepPackageBO()
                    rp.JOB_ID = dtrow("ID_RP_CODE").ToString
                    rp.JOB_TITLE = dtrow("RP_DESC").ToString
                    rp.MAKE = dtrow("ID_MAKE_RP").ToString
                    rp.FIXED_PRICE = dtrow("FLG_FIX_PRICE").ToString
                    rp.JOB_CLASS = dtrow("JOB_CLASS").ToString
                    rp.OPERATION_CODE = dtrow("OPERATION_CODE").ToString
                    rp.ADD_GM = dtrow("FLG_GM_PRICE_CHNG").ToString
                    rp.SUPP_CURRENTNO = dtrow("SUPPLIER_ID").ToString

                    packageResult.Add(rp)

                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.RepPackage", "FetchRPHead", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return packageResult
        End Function

        Public Function FetchRPDetails(ByVal JOB_ID As String) As List(Of RepPackageBO)
            Dim dsRPList As New DataSet
            Dim dtRPList As DataTable
            Dim rpListResult As New List(Of RepPackageBO)()

            Try
                dsRPList = objRepPackageDO.FetchRPDetails(JOB_ID)

                If dsRPList.Tables.Count > 0 Then
                    dtRPList = dsRPList.Tables(0)
                End If

                For Each dtrow As DataRow In dtRPList.Rows
                    Dim rp As New RepPackageBO()
                    rp.ID_ITEM = dtrow("ID_ITEM_JOB").ToString
                    rp.ITEM_DESC = dtrow("LINE_DESCRIPTION").ToString
                    rp.LINE_TYPE = dtrow("LINE_TYPE").ToString
                    rp.ITEM_AVAIL_QTY = dtrow("RP_QTY").ToString
                    rp.ITEM_PRICE = dtrow("RP_ITEM_PRICE").ToString
                    rp.TOTAL_PRICE = dtrow("RP_TOTAL_PRICE").ToString
                    rp.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString
                    rp.ID_ITEM_CATG = dtrow("ID_ITEM_CATG").ToString
                    rp.ID_RP_CODE = dtrow("ID_RP_CODE").ToString
                    rp.ID_SPARE_SEQ = dtrow("ID_SPARE_SEQ").ToString

                    rpListResult.Add(rp)
                Next

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.RepPackage", "FetchRPDetails", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return rpListResult
        End Function

        Public Function Delete_RepairPackage(ByVal rp_code As String, ByVal rp_type As String, ByVal id_spareseq As String) As String
            Dim strResult As String = ""
            Try
                strResult = objRepPackageDO.DeleteRepairPackage(rp_code, HttpContext.Current.Session("UserID").ToString, rp_type, id_spareseq)

            Catch ex As Exception
                objErrHandle.WriteErrorLog(1, "Services.RepPackage", "Delete_RepairPackage", ex.Message, ex.GetBaseException.StackTrace.ToString.Trim, HttpContext.Current.Session("UserID"))
            End Try
            Return strResult

        End Function

        Public Function FetchRPDetailsWO(ByVal ID_RPKG_SEQ As String, ByVal JOB_ID As String) As List(Of RepPackageBO)
            Dim dsRPList As New DataSet
            Dim dtRPList As DataTable
            Dim rpListResult As New List(Of RepPackageBO)()

            Try
                dsRPList = objRepPackageDO.FetchRPDetailsWO(ID_RPKG_SEQ, JOB_ID)

                If dsRPList.Tables.Count > 0 Then
                    dtRPList = dsRPList.Tables(0)
                End If

                For Each dtrow As DataRow In dtRPList.Rows
                    Dim rp As New RepPackageBO()
                    rp.ID_ITEM = dtrow("ID_ITEM_JOB").ToString
                    rp.ITEM_DESC = dtrow("LINE_DESCRIPTION").ToString
                    rp.LINE_TYPE = dtrow("LINE_TYPE").ToString
                    rp.ITEM_AVAIL_QTY = dtrow("RP_QTY").ToString
                    rp.ITEM_PRICE = dtrow("RP_ITEM_PRICE").ToString
                    rp.TOTAL_PRICE = dtrow("RP_TOTAL_PRICE").ToString
                    rp.SUPP_CURRENTNO = dtrow("SUPP_CURRENTNO").ToString
                    rp.ID_ITEM_CATG = dtrow("ID_ITEM_CATG").ToString
                    rp.ID_WH_ITEM = dtrow("ID_WH_ITEM").ToString
                    rp.ITEM_AVAIL_QTY_WO = dtrow("ITEM_AVAIL_QTY").ToString

                    rpListResult.Add(rp)
                Next

            Catch ex As Exception
                Throw ex
            End Try
            Return rpListResult
        End Function

        Public Function Fetch_RP_List_WO(ByVal searchtext As String) As List(Of RepPackageBO)
            Dim dsRPItems As New DataSet
            Dim dtRPItems As DataTable
            Dim repPackageResult As New List(Of RepPackageBO)()
            Dim counter As Integer = 1
            Dim login As String = HttpContext.Current.Session("UserID")

            Try
                dsRPItems = objRepPackageDO.Fetch_RP_List_WO(searchtext, login)

                If dsRPItems.Tables.Count > 0 Then
                    dtRPItems = dsRPItems.Tables(0)

                    For Each dtrow As DataRow In dtRPItems.Rows
                        Dim item As New RepPackageBO()
                        item.ID_RPKG_SEQ = dtrow("ID_RPKG_SEQ").ToString
                        item.JOB_ID = dtrow("ID_RP_CODE").ToString
                        item.JOB_TITLE = dtrow("RP_DESC").ToString
                        item.MAKE = dtrow("ID_MAKE_RP").ToString
                        item.OPERATION_CODE = dtrow("OPERATION_CODE")
                        item.JOB_CLASS = dtrow("JOB_CLASS")
                        item.FIXED_PRICE = dtrow("FLG_FIX_PRICE")
                        item.ADD_GM = dtrow("FLG_GM_PRICE_CHNG")

                        repPackageResult.Add(item)
                    Next
                End If
            Catch ex As Exception
                Throw ex
            End Try
            Return repPackageResult
        End Function
    End Class
End Namespace