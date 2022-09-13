<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmDayPlanSettings.aspx.vb" Inherits="CARS.frmDayPlanSettings" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style type="text/css">
        .customTimebox {           
            border-radius: 4px;
            border-color: #dbdbdb;
        }
    </style>
   <script type="text/javascript">
       $(document).ready(function () {

           $('.menu .item')
                .tab()
                ; //activate the tabs

           setTab('WOStatus');

           function setTab(cTab) {

                var tabID = "";
                tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
                var tab;
                (tabID == "") ? tab = cTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
            }

           $('.cTab').on('click', function (e) {               
                setTab($(this));
            });


           $('#btnSaveAppointmentConfig').on('click', function (e) {
               if ($('#<%=txtLastAppmntNum.ClientID%>').val() == "") {
                   swal('<%=GetLocalResourceObject("errLastAptNoEmpty")%>');
                return false;
               }
               if ($('#<%=txtHistoryLimit.ClientID%>').val() == "") {
                   swal('<%=GetLocalResourceObject("errHtryLtEmpty")%>');
                return false;
            }
               if ($('#<%=txtLastAppmntNum.ClientID%>').val() < 0) {
                   swal('<%=GetLocalResourceObject("errLstApptNoNeg")%>');
                   return false;
               }
               if ($('#<%=txtHistoryLimit.ClientID%>').val() < 0) {
                   swal('<%=GetLocalResourceObject("errHtryNoNeg")%>');
                   return false;
               }
              
                saveAppmntConfig();
            });
           
           function saveAppmntConfig() {
              
              <%-- var appmntStartTime = $('#<%=txtAppmntStartTime.ClientID%>').val();
               var appmntStopTime = $('#<%=txtAppmntStopTime.ClientID%>').val();--%>

           <%-- var appmntStartTime = $('#<%=txtAppmntStartTim.ClientID%>').val();
               var appmntStopTime = $('#<%=txtAppmntStopTim.ClientID%>').val();--%>

               var appmntStartTime = txtAppmntStartTime.GetText();
               var appmntStopTime = txtAppmntStopTime.GetText();

               var lastAppmntNum = $('#<%=txtLastAppmntNum.ClientID%>').val();
               var historyLimit = $('#<%=txtHistoryLimit.ClientID%>').val();
               var minAppmntTime = $('#<%=ddlMinAppmtTime.ClientID%>').val();
               var mechanicPerPage = $('#<%=ddlMechanicPerPage.ClientID%>').val();
               var dispShwSatSund = $("#<%=cbShwSatSund.ClientID%>").is(':checked');
               var idAppmntConfigSettings = $("#<%=hdnIdAppmntConfigSettings.ClientID%>").val();

               var ctrlByStatus = $("#<%=rbByStatus.ClientID%>").is(':checked');
               var ctrlByStandard = $("#<%=rbByStandard.ClientID%>").is(':checked');
                var ctrlByMechanic = $("#<%=rbByMechanic.ClientID%>").is(':checked');
               var showOnHoldOnPageLoad = $("#<%=cbShowOnHold.ClientID%>").is(':checked');
               $.ajax({
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   url: "frmDayPlanSettings.aspx/SaveAppmntConfigSettings",
                   data: "{appmntStartTime: '" + appmntStartTime + "', appmntStopTime:'" + appmntStopTime + "', lastAppmntNum:'" + lastAppmntNum + "', historyLimit:'" + historyLimit + "', minAppmntTime:'" + minAppmntTime + "', dispShwSatSund:'" + dispShwSatSund + "', mechanicPerPage:'" + mechanicPerPage + "', ctrlByStatus:'" + ctrlByStatus + "', ctrlByStandard:'" + ctrlByStandard + "', ctrlByMechanic:'" + ctrlByMechanic + "', idAppmntConfigSettings:'" + idAppmntConfigSettings + "', showOnHoldOnPageLoad:'" + showOnHoldOnPageLoad + "'}",
                   dataType: "json",
                   async: false,
                   success: function (data) {
                       if (data.d[0] == "INSERTED" || data.d[0] == "UPDATED") {
                           $('#<%=RTlblError.ClientID%>').text('<%=GetLocalResourceObject("genSaveSuccess")%>');
                           $('#<%=RTlblError.ClientID%>').removeClass();
                           $('#<%=RTlblError.ClientID%>').addClass("lblMessage");
                       }
                       else {
                           $('#<%=RTlblError.ClientID%>').text('<%=GetLocalResourceObject("errSaveFail")%>');
                           $('#<%=RTlblError.ClientID%>').removeClass();
                           $('#<%=RTlblError.ClientID%>').addClass("lblErr");
                       }
                   },
                   error: function (result) {
                       alert("Error");
                   }
               });
           }
       });


   </script>

    <script type="text/javascript">

        function OnBatchEditStartEditing(s, e) {  
            //alert(e.focusedColumn.val());
            if (e.focusedColumn.fieldName == "ORDER_STATUS_CODE") {  
                var editor = s.GetEditor(e.focusedColumn.fieldName); 
                
                if (e.visibleIndex >= 0) {
                   // editor.SetEnabled(false);  
                    e.cancel = true;
                gvOrderStatus.SetFocusedCell(e.visibleIndex, 3);
                    s.batchEditApi.StartEdit(e.visibleIndex, 3);
                }
                  
            }  
        }  

          function OnBatchEditEndEditing(s, e) {
            let column = s.GetColumnByField("ORDER_STATUS_COLOR");
            if (column != null) {
                let hexValue = e.rowValues[column.index].value;
                let hexText = ">" + hexValue + "<";
                e.rowValues[column.index].text = e.rowValues[column.index].text.replace(hexText, "");
            }
        }

        function OnColorSelect(s, e) {
            s.GetInputElement().style.display='none';
        }

        function OnEndCallBack(s, e) {           
            if (s.cpdelexists != '') {
                if (s.cpdelexists == "EXISTS") {
                    swal('<%=GetLocalResourceObject("errStInUse")%>');
                }                
            }
            
        }

        function OnBatchEditStartEditingApp(s, e) {
            if (e.focusedColumn.fieldName == "APPOINTMENT_STATUS_CODE") {
                if (e.visibleIndex >= 0) {
                    e.cancel = true;
                    gvApptStatus.SetFocusedCell(e.visibleIndex, 3);
                    s.batchEditApi.StartEdit(e.visibleIndex, 3);
                }
            }
        }

    </script>

    
    <div>
        <asp:Label ID="RTlblError" runat="server"  CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
        <asp:HiddenField id="hdnIdAppmntConfigSettings" runat="server" />
        
    </div>


    <div class="ui one column grid">
        <div class="stretched row">
            <div class="sixteen wide column">
                 <div class="ui top attached tabular menu">
                    <a class="item active" data-tab="first"><%=GetLocalResourceObject("hdrWOStatus")%></a>
                    <a class="item" data-tab="second"><%=GetLocalResourceObject("hdrAptSett")%></a>                  
                      <a class="item" data-tab="third"><%=GetLocalResourceObject("hdrApptStSett")%></a> 
                </div>

                  <%--########################################## WorkOrderStatus ##########################################--%>

                 <div class="ui bottom attached tab segment active" data-tab="first">
                     <div id="tabWOStatus">
                         <div >
                             <div class="sixteen wide column">
                                 <div id="divDPSDetails" class="ui raised segment signup inactive"  style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <%--<h3 id="lblDPSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">DayPlan Settings</h3>--%>

                                    <%--<div >--%>
                                        <dx:ASPxGridView ID="gvOrderStatus" Width="100%"  style= "-moz-border-radius: 10px ;border-radius: 10px;" ClientInstanceName="gvOrderStatus" OnBatchUpdate="gvOrderStatus_BatchUpdate" OnRowValidating="gvOrderStatus_RowValidating" KeyFieldName="ID_ORDER_STATUS" runat="server" Theme="Office2010Blue" AutoGenerateColumns="False" meta:resourcekey="gvOrderStatusResource1" >
                                            <SettingsEditing Mode="Batch" ></SettingsEditing>
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
                                             <dx:GridViewCommandColumn VisibleIndex="0" ShowNewButton="true" ShowEditButton="true" ShowDeleteButton="true" ShowClearFilterButton="True" meta:resourcekey="GridViewCommandColumnResource1"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID_ORDER_STATUS" VisibleIndex="1" Visible="false" meta:resourcekey="GridViewDataTextColumnResource1"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" FieldName="ORDER_STATUS_CODE" PropertiesTextEdit-ValidationSettings-Display="Dynamic" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Please enter status code"  Caption="STATUS CODE" VisibleIndex="2" PropertiesTextEdit-MaxLength="10" meta:resourcekey="GridViewDataTextColumnResource2">
                                                      <PropertiesTextEdit>
                                                         <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[a-zA-Z ]+$" RegularExpression-ErrorText="Special Characters and Numerics not allowed">
                                                             <RegularExpression ErrorText="Special Characters and Numerics not allowed" ValidationExpression="^[a-zA-Z ]+$"></RegularExpression>
                                                            <RequiredField IsRequired="True" ErrorText="Please enter a Status Code"></RequiredField>
                                                         </ValidationSettings>
                                                      </PropertiesTextEdit>
                                                    <HeaderStyle Font-Bold="True" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-Display="Dynamic" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Please enter a description" FieldName="ORDER_STATUS_DESC" VisibleIndex="3" Caption="DESCRIPTION" PropertiesTextEdit-MaxLength="50" meta:resourcekey="GridViewDataTextColumnResource3">
                                                    <PropertiesTextEdit>
                                                         <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[a-zA-Z ]+$" RegularExpression-ErrorText="Special Characters and Numerics not allowed">
                                                            <RegularExpression ErrorText="Special Characters and Numerics not allowed" ValidationExpression="^[a-zA-Z ]+$"></RegularExpression>
                                                            <RequiredField IsRequired="True" ErrorText="Please enter a Description"></RequiredField>
                                                         </ValidationSettings>
                                                      </PropertiesTextEdit>
                                                    <HeaderStyle Font-Bold="True" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataColorEditColumn  FieldName="ORDER_STATUS_COLOR" Caption="COLOR" VisibleIndex="4" meta:resourcekey="GridViewDataColorEditColumnResource1" >                                                   
                                                    <HeaderStyle Font-Bold="True" />
                                                    <DataItemTemplate>
                                                     <div style="width: 100%; height: 20px; border: #9f9f9f 1px solid; background-color: <%#Container.Text%>"></div>
                                                    </DataItemTemplate>
                                                    <%--<PropertiesColorEdit  ClientSideEvents-Init="function(s,e){s.GetInputElement().style.display='none'; }"></PropertiesColorEdit>--%>
                                                    <%--<PropertiesColorEdit ClientSideEvents-Init="OnColorSelect"></PropertiesColorEdit>--%>
                                                </dx:GridViewDataColorEditColumn>
                                            </Columns>
                                             <SettingsPager PageSize="10">
                                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                             </SettingsPager>
                                        </dx:ASPxGridView>
                                    <%--</div>--%>

                                    

                                </div>
                             </div>


                         </div>
                     </div>
                 </div>

                 <%--########################################## AppointmentSettings ##########################################--%>

                 <div class="ui bottom attached tab segment" data-tab="second">
                     <div class="ui form stackable two column grid">
                        <div class="thirteen wide column">

                          <div class="inline fields">
                             <div class="four wide field">
                                <label id="lblLastAppmntNum" runat="server"><%=GetLocalResourceObject("lblLastAppmntNum")%></label>
                             </div>

                             <div class="three wide field">
                                 <asp:TextBox runat="server" Enabled="False" ID="txtLastAppmntNum" meta:resourcekey="txtLastAppmntNumResource1" TextMode="Number" min="1" style="height:100%"></asp:TextBox>
                             </div>
                              <div class="one wide field"></div>
                             <div class="four wide field">
                                <label id="lblMinAppmntTime" runat="server"><%=GetLocalResourceObject("lblMinAppmntTime")%></label>
                            </div>
 
                             <div class="three wide field">
                                 <asp:DropDownList ID="ddlMinAppmtTime" runat="server" meta:resourcekey="ddlMinAppmtTimeResource1" Width="93%">
                                     <asp:ListItem Text="15" Value="15" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                      <asp:ListItem Text="30" Value="30" meta:resourcekey="ListItemResource2" ></asp:ListItem>
                                      <asp:ListItem Text="60" Value="60" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                 </asp:DropDownList>
                             </div>
                           </div> 

                         <div class="inline fields">
                             <div class=" four wide field">
                                 <label id="lblAppmntStartTime" runat="server"><%=GetLocalResourceObject("lblAppmntStartTime")%></label>
                             </div>                            
                             <div class="three wide field">                                                                  
                                 <dx:ASPxTimeEdit ID="txtAppmntStartTime" runat="server" ClientInstanceName="txtAppmntStartTime" CaptionSettings-ShowColon="false"
                                     CssClass="customTimebox" FocusedStyle-Border-BorderColor="#2185d0" DisplayFormatString="HH:mm" DateTime="06/07/2022 08:00:00" AllowNull="False"
                                     Border-BorderStyle="Double" SpinButtons-DecrementImage-Height="100%" SpinButtons-IncrementImage-Height="100%" Width="100%" Theme="MetropolisBlue" meta:resourcekey="txtAppmntStartTimeResource1" >
                                 </dx:ASPxTimeEdit>
                             </div>
                             <div class="one wide field"></div>
                             <div class=" four wide field">
                                 <label id="lblAppmntStopTime" runat="server"><%=GetLocalResourceObject("lblAppmntStopTime")%></label>
                             </div>
                             <div class="three wide field">
                                  <dx:ASPxTimeEdit id="txtAppmntStopTime" runat="server" ClientInstanceName="txtAppmntStopTime" CaptionSettings-ShowColon="false" 
                                      CssClass="customTimebox" FocusedStyle-Border-BorderColor="#2185d0" DisplayFormatString="HH:mm" DateTime="06/07/2022 18:00:00"  AllowNull="False"
                                      Border-BorderStyle="Double" SpinButtons-DecrementImage-Height="100%" SpinButtons-IncrementImage-Height="100%" Width="100%" Theme="MetropolisBlue" meta:resourcekey="txtAppmntStopTimeResource1" ></dx:ASPxTimeEdit>
                              </div>
                         </div>

                          <div class="inline fields">
                              <div class="four wide field">
                                <label id="lblHistoryLimit" runat="server"><%=GetLocalResourceObject("lblHistoryLimit")%></label>
                             </div>

                              <div class="three wide field">
                                 <asp:TextBox runat="server" ID="txtHistoryLimit" meta:resourcekey="txtHistoryLimitResource1" TextMode="Number" required="true" min="1"></asp:TextBox>
                             </div>
                              <div class="one wide field"></div>
                              <div class="four wide field">
                                <label id="lblShwSatSund" runat="server"><%=GetLocalResourceObject("lblShwSatSund")%></label>
                             </div>

                              <div class="one wide field">                                  
                                  <asp:CheckBox ID="cbShwSatSund" runat="server" meta:resourcekey="cbShwSatSundResource1"  Style="display: inline-block;"/>                                   
                             </div>
                              
                         </div>   
                            <div class="inline fields">

                                <div class="four wide field">
                                    <label id="lblMechanicPerPage" runat="server"><%=GetLocalResourceObject("lblMechanicPerPage")%></label>
                                </div>

                                <div class="three wide field">
                                    <asp:DropDownList ID="ddlMechanicPerPage" runat="server" meta:resourcekey="ddlMechanicPerPageResource1" Width="93%">
                                        <asp:ListItem Text="1" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                        <asp:ListItem Text="2" Value="2" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                        <asp:ListItem Text="3" Value="3" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                        <asp:ListItem Text="4" Value="4" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                        <asp:ListItem Text="5" Value="5" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="one wide field"></div>
                                <div class="four wide field">
                                    <label id="lblControlledBy" runat="server"><%=GetLocalResourceObject("lblControlledBy")%></label> 
                                    </div>
                                <div class="three wide field">
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <asp:RadioButton ID="rbByStandard" GroupName="controlledBy" runat="server" Checked="True" meta:resourcekey="rbByStandardResource1" />
                                            <label>
                                                <asp:Literal ID="lblByStandard" runat="server" Text="Standard" meta:resourcekey="lblByStandardResource1"></asp:Literal></label>
                                        </div>
                                    </div>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <asp:RadioButton ID="rbByStatus" GroupName="controlledBy" runat="server" meta:resourcekey="rbByStatusResource1" />
                                            <label>
                                                <asp:Literal ID="lblByStatus" runat="server" Text="Status" meta:resourcekey="lblByStatusResource1"></asp:Literal></label>
                                        </div>
                                    </div>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <asp:RadioButton ID="rbByMechanic" GroupName="controlledBy" runat="server" meta:resourcekey="rbByMechanicResource1" />
                                            <label>
                                                <asp:Literal ID="lblByMechanic" runat="server" Text="Mechanic" meta:resourcekey="lblByMechanicResource1"></asp:Literal></label>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                         
                          <div class="inline fields">
                                <div class="four wide field">
                                    <label id="lblShowOnHold" runat="server"><%=GetLocalResourceObject("lblShowOnHold")%></label>
                                </div>
                                <div class="one wide field">
                                    <asp:CheckBox ID="cbShowOnHold" runat="server" meta:resourcekey="cbShowOnHoldResource1" Style="display: inline-block;" />
                                </div>
                            </div>

                          <div class="inline fields">
                                <div class="four wide field"></div>
                                <div class="four wide field"></div>                         
                                <div class="two wide field">
                                    <div id="btnSaveAppointmentConfig" class="ui button wide positive"><%=GetLocalResourceObject("btnSave")%></div>                     
                                </div>
                                <div class="four wide field"></div>
                             
                            </div>

                        </div>

                     </div>
                 </div>

                 <%--########################################## AppointmentStatusSettings ##########################################--%>
                 <div class="ui bottom attached tab segment" data-tab="third">
                     <div id="tabAppointmentStatus">
                         <div >
                             <div class="sixteen wide column">
                                 <div class="ui raised segment signup inactive"  style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                 <dx:ASPxGridView ID="gvApptStatus" Width="100%"  style= "-moz-border-radius: 10px ;border-radius: 10px;" ClientInstanceName="gvApptStatus" OnBatchUpdate="gvApptStatus_BatchUpdate" OnRowValidating="gvApptStatus_RowValidating" KeyFieldName="ID_APPOINTMENT_STATUS" runat="server" Theme="Office2010Blue" AutoGenerateColumns="False" meta:resourcekey="gvApptStatusResource1" >
                                            <SettingsEditing Mode="Batch" ></SettingsEditing>
                                           <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEditingApp" /> <%--BatchEditEndEditing="OnBatchEditEndEditing" EndCallback="OnEndCallBack"/>--%>
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
                                             <dx:GridViewCommandColumn VisibleIndex="0" ShowNewButton="true" ShowEditButton="true" ShowDeleteButton="true" ShowClearFilterButton="True" meta:resourcekey="GridViewCommandColumnResource2"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID_APPOINTMENT_STATUS" VisibleIndex="1" Visible="false" meta:resourcekey="GridViewDataTextColumnResource4"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" FieldName="APPOINTMENT_STATUS_CODE" PropertiesTextEdit-ValidationSettings-Display="Dynamic" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Please enter Appointment status code"  Caption="APPOINTMENT STATUS CODE" VisibleIndex="2" PropertiesTextEdit-MaxLength="30" meta:resourcekey="GridViewDataTextColumnResource5">
                                                      <PropertiesTextEdit>
                                                         <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[a-zA-Z ]+$" RegularExpression-ErrorText="Special Characters and Numerics not allowed">
<RegularExpression ErrorText="Special Characters and Numerics not allowed" ValidationExpression="^[a-zA-Z ]+$"></RegularExpression>
                                                            <RequiredField IsRequired="True" ErrorText="Please enter a Appointment Status Code"></RequiredField>
                                                         </ValidationSettings>
                                                      </PropertiesTextEdit>
                                                    <HeaderStyle Font-Bold="True" />
                                                </dx:GridViewDataTextColumn>
                                                
                                                <dx:GridViewDataColorEditColumn  FieldName="APPOINTMENT_STATUS_COLOR" Caption="COLOR" VisibleIndex="3" meta:resourcekey="GridViewDataColorEditColumnResource2" >                                                   
                                                    <HeaderStyle Font-Bold="True" />
                                                    <DataItemTemplate>
                                                     <div style="width: 100%; height: 20px; border: #9f9f9f 1px solid; background-color: <%# Container.Text %>"></div>
                                                    </DataItemTemplate>
                                                   
                                                </dx:GridViewDataColorEditColumn>
                                            </Columns>
                                             <SettingsPager PageSize="10">
                                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                             </SettingsPager>
                                        </dx:ASPxGridView>
                                 </div>
                             </div>
                         </div>
                         </div>
                     </div>
            </div>
        </div>
    </div>





</asp:Content>
