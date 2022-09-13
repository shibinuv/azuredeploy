<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfigSparePartContent.aspx.vb" Inherits="CARS.ConfigSparePartContent" MasterPageFile="~/MasterPage.Master" %>
<%@ Register assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<asp:Content runat="server" ContentPlaceHolderID="cntMainPanel" ID="Content1">
       
    <script type="text/javascript" >
        function OnBatchEditStartEditing(s, e) {  
           
        }  

        function OnBatchEditEndEditing(s, e) {
            
        }

        function OnEndCallBack(s, e) {           
            
        }



    </script>

    <div>
      
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr"></asp:Label>
        <asp:HiddenField ID="hdnPageSize" runat="server" Value="5" />
        <asp:HiddenField ID="hdnSelect" runat="server" />
        <asp:HiddenField ID="hdnEditCap" runat="server" Value="Edit" />
        <asp:HiddenField ID="hdnMode" runat="server" />
        <asp:HiddenField ID="hdnSpCatgId" runat="server" />
        <asp:HiddenField ID="hdnSupplierId" runat="server" />
    </div>
    <div class="ui raised segment signup inactive"  style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);" >
         <h3 id="lblDPSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Spare Part Category Configuration </h3>

        <div class="ui one column grid">
            <div class="stretched row">
                <div class="sixteen wide column">
                    <dx:ASPxGridView runat="server" ID="gvSpCatgConfig" ClientInstanceName="gvSpCatgConfig" style= "-moz-border-radius: 10px ;border-radius: 10px;" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID_LEAVE_TYPES" Theme="Office2010Blue" CssClass="carsInput">
                        <SettingsEditing Mode="Batch" />
                        <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEditing" BatchEditEndEditing="OnBatchEditEndEditing" EndCallback="OnEndCallBack"/>
                        <Settings ShowFilterRow="True" />
                        <SettingsSearchPanel Visible="True" />
                        <SettingsPopup>
                            <FilterControl AutoUpdatePosition="False"></FilterControl>
                        </SettingsPopup>
                        <SettingsBehavior AllowFocusedRow="true" />
                        <Styles>
                            <FocusedRow BackColor="#d6eef2" ForeColor="Black">
                            </FocusedRow>
                        </Styles>
                        <Columns>
                             <dx:GridViewCommandColumn VisibleIndex="0" ShowNewButton="true" ShowEditButton="true" ShowDeleteButton="true" ShowClearFilterButton="True"></dx:GridViewCommandColumn>
                             <dx:GridViewDataTextColumn FieldName="ID_SPCATEGORY" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>

                        </Columns>

                    </dx:ASPxGridView>
                </div>
            </div>
        </div>

    </div> 
    

</asp:Content>
