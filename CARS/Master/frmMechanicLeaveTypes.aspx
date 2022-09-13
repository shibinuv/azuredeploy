<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmMechanicLeaveTypes.aspx.vb" Inherits="CARS.frmMechanicLeaveTypes" %>
<%@ Register assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">

 <script type="text/javascript"> 
     function OnBatchStartEdit(s, e) {
         if (e.visibleIndex >= 0 && e.focusedColumn.fieldName == "LEAVE_CODE") {
             e.cancel = true;
             gvLeaveTypes.SetFocusedCell(e.visibleIndex, 3);
             s.batchEditApi.StartEdit(e.visibleIndex, 3);
         }
     }

     function OnEndCallBack(s, e) {           
            if (s.cpdelexists != '') {
                if (s.cpdelexists == "EXISTS") {
                    if (s.cpdelcode != '') {
                        alert(s.cpdelcode + "<%=GetLocalResourceObject("errRecExists")%>");
                    }                    
                }                
            }            
        }
</script>

    <div id="aGVLeaveTypes" class="ui raised segment signup inactive"  style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
   
        <h3 id="lblDPSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrMecLvType")%></h3>
    
        <dx:ASPxGridView ID="gvLeaveTypes" runat="server" ClientInstanceName="gvLeaveTypes" OnRowValidating="gvLeaveTypes_RowValidating" style= "-moz-border-radius: 10px ;border-radius: 10px;" Width="100%" AutoGenerateColumns="False" OnBatchUpdate="gvLeaveTypes_BatchUpdate" KeyFieldName="ID_LEAVE_TYPES" Theme="Office2010Blue" CssClass="carsInput" meta:resourcekey="gvLeaveTypesResource1" >
            <SettingsEditing Mode="Batch" />
            <ClientSideEvents BatchEditStartEditing="OnBatchStartEdit" EndCallback="OnEndCallBack"/>
            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <SettingsBehavior AllowFocusedRow="true" />
            <Styles>
                <FocusedRow BackColor="#d6eef2" ForeColor="Black">
                </FocusedRow>
            </Styles>
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButton="True" VisibleIndex="0" ShowClearFilterButton="True" meta:resourcekey="GridViewCommandColumnResource1">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID_LEAVE_TYPES" ReadOnly="True" VisibleIndex="1" Visible="false" meta:resourcekey="GridViewDataTextColumnResource1" >
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LEAVE_CODE" VisibleIndex="2" Caption="Leave Code" PropertiesTextEdit-MaxLength="20" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Please provide a Leave Code" meta:resourcekey="GridViewDataTextColumnResource2">
                    <PropertiesTextEdit>
                        <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[a-zA-Z ]+$" RegularExpression-ErrorText="Special Characters and Numerics not allowed">
                        <RegularExpression ErrorText="Special Characters and Numerics not allowed" ValidationExpression="^[a-zA-Z ]+$"></RegularExpression>
                        <RequiredField IsRequired="True" ErrorText="Please enter a Leave Code"></RequiredField>
                    </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle Font-Bold="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LEAVE_DESCRIPTION" VisibleIndex="3" Caption="Leave Description" PropertiesTextEdit-MaxLength="50" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Please provide a Leave Description" meta:resourcekey="GridViewDataTextColumnResource3">
                    <PropertiesTextEdit>
                        <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[a-zA-Z ]+$" RegularExpression-ErrorText="Special Characters and Numerics not allowed">
                        <RegularExpression ErrorText="Special Characters and Numerics not allowed" ValidationExpression="^[a-zA-Z ]+$"></RegularExpression>
                        <RequiredField IsRequired="True" ErrorText="Please enter a Leave Description"></RequiredField>
                    </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle Font-Bold="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="APPROVE_CODE" VisibleIndex="4" Caption="Approve Code" PropertiesTextEdit-MaxLength="20" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Please provide a Approve Code" meta:resourcekey="GridViewDataTextColumnResource4">
                    <PropertiesTextEdit>
                        <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[a-zA-Z ]+$" RegularExpression-ErrorText="Special Characters and Numerics not allowed" >
                        <RegularExpression ErrorText="Special Characters and Numerics not allowed" ValidationExpression="^[a-zA-Z ]+$"></RegularExpression>
                        <RequiredField IsRequired="True" ErrorText="Please enter a Approve Code"></RequiredField>
                    </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle Font-Bold="True" />
                </dx:GridViewDataTextColumn>                
            </Columns>
            <Settings VerticalScrollableHeight="300" ShowFilterRow="True" />
            <SettingsPager PageSize="10">
                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
            </SettingsPager>
       </dx:ASPxGridView>
  </div>
</asp:Content>
