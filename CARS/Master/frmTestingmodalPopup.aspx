<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmTestingmodalPopup.aspx.vb" Inherits="CARS.frmTestingmodalPopup" %>
<%@ Register assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">


    


    <dx:ASPxPopupControl ID="popup" runat="server" Height="50%" Width="50%" ClientInstanceName="popup" Modal="True">
        <ContentCollection>
				<dx:PopupControlContentControl runat="server">
				</dx:PopupControlContentControl>
			</ContentCollection>
			<Windows>
				<dx:PopupWindow ContentUrl="frmMechanicLeaveTypesPopup.aspx" HeaderText="Mechanic Leave Types" Name="mlt"
					Text="Mechanic Leave Types" Height="500px" Left="200"  Width="1000px" Modal="True" Top="100">
					<ContentCollection>
						<dx:PopupControlContentControl runat="server">
						</dx:PopupControlContentControl>
					</ContentCollection>
				</dx:PopupWindow>
			</Windows>
    </dx:ASPxPopupControl>
	  <dx:ASPxLabel runat="server" Text ="Add Mechanic leave Types" Theme="Office2010Blue"></dx:ASPxLabel> 
    <dx:ASPxButton ID="btn" runat="server" AutoPostBack="False" text="+"  class="mini ui button" style="color: #21BA45; background-color: white">
		<ClientSideEvents Click="function (s, e) {
			
			popup.ShowWindow(popup.GetWindow(0));
		}" />
    </dx:ASPxButton>
</asp:Content>

