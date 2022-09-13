<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReportViewer_Transaction.aspx.vb" Inherits="CARS.ReportViewer_Transaction" %>

<%@ Register Assembly="DevExpress.XtraReports.v21.2.Web.WebForms, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
        <div>         
               <dx:ASPxWebDocumentViewer ID="wrvReportViewer1" ClientInstanceName="wrvReportViewer1" runat="server">
                   <SettingsTabPanel Position="Left"/>
               </dx:ASPxWebDocumentViewer>           
        </div>
    </form>
</body>
</html>
