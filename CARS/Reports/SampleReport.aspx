﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="SampleReport.aspx.vb" Inherits="CARS.SampleReport" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v21.2.Web.WebForms, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    
    <link href="<%# ResolveUrl("~/CSS/jquery-ui.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%# ResolveUrl("~/Content/ui.jqgrid.css")%>" rel="stylesheet" />
    <link href="<%# ResolveUrl("~/Content/themes/base/all.css")%>" rel="stylesheet" />

    <link href="<%# ResolveUrl("~/Content/semantic.css")%>" rel="stylesheet" />
        <link href="<%# ResolveUrl("~/Content/semantic.min.css")%>" rel="stylesheet" />
    <link href="<%# ResolveUrl("~/CSS/Msg.css")%>" rel="stylesheet" type="text/css" />    
    <link href="<%# ResolveUrl("~/CSS/jquery.contextMenu.min.css")%>" rel="stylesheet" type="text/css"  />
    <link href="../CSS/cars.css" rel="stylesheet" />
   
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    
    
    <div>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="ASPxButton" AutoPostBack="false" OnClick="ASPxButton1_Click"></dx:ASPxButton>
    </div>
    <div>
        <dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" runat="server"></dx:ASPxWebDocumentViewer>
    </div>
</asp:Content>