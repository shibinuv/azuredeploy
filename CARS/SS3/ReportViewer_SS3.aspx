<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReportViewer_SS3.aspx.vb" Inherits="CARS.ReportViewer_SS3" %>


<%@ Register Assembly="DevExpress.XtraReports.v21.2.Web.WebForms, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>         
            <dx:ASPxWebDocumentViewer ID="wrvReportViewer1" ClientInstanceName="wrvReportViewer1" runat="server" TabIndex="4">
                <SettingsTabPanel Position="Left"/>
            </dx:ASPxWebDocumentViewer>
        </div>
        <div>
            
        </div>
    </form>
</body>
</html>
