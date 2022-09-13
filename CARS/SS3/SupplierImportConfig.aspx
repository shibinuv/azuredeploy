<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="SupplierImportConfig.aspx.vb" Inherits="CARS.SupplierImportConfig" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style>
        
    </style>
    <script type="text/javascript">
        var genIsEmpty = "";
        var genIsNum = "";
        $(document).ready(function () {
            $('#newSupplierImportConfig').hide();
            $('#SupplierConfigGrid').hide();
            $('#SaveCancelButton').hide();
        });
        function CheckSupplier() {
            if (<%="document.getElementById('" + ddlSupplier.ClientID + "').value"%> == 0) {

                swal('<%=GetLocalResourceObject("GenSelectFieldName")%>');
                <%="document.getElementById('" + ddlSupplier.ClientID + "').focus()"%>;
                return false;
            }

        }
        function CheckMainInformation() {

            if (document.getElementById('<%= rbFixed.ClientID%>').checked == true || document.getElementById('<%= rbDelimiter.ClientID%>').checked == true) {
                if (document.getElementById('<%= rbFixed.ClientID %>').checked == true) {
                    EnableOtherDelimiter();
                    document.getElementById('<%= txtOrderFile.ClientID%>').disabled = true;
                    document.getElementById('<%= txtStartsFrom.ClientID%>').disabled = false;
                    document.getElementById('<%= txtEndsAt.ClientID%>').disabled = false;
                }
                else {

                    EnableOtherDelimiter();
                    document.getElementById('<%= txtOrderFile.ClientID%>').disabled = false;
                    document.getElementById('<%= txtStartsFrom.ClientID%>').disabled = true;
                    document.getElementById('<%= txtEndsAt.ClientID%>').disabled = true;
                }
            }
            else {
                ShowHideDelimiter();
                EnableOtherDelimiter()
            }
        }
        //Function to Enabled and Disable Delimiter
        function ShowHideDelimiter() {
            document.getElementById('<%= ddlSpDelimiter.ClientID%>').disabled = true;
            document.getElementById('<%= txtOtherDelimiter.ClientID%>').disabled = true;
            if (document.getElementById('<%= rbDelimiter.ClientID%>').checked == true) {
                document.getElementById('<%= ddlSpDelimiter.ClientID%>').disabled = false;
                if (document.getElementById('<%= ddlSpDelimiter.ClientID%>').value == "Others") {
                    document.getElementById('<%= txtOtherDelimiter.ClientID%>').disabled = false;
                }
                else {
                    document.getElementById('<%= txtOtherDelimiter.ClientID%>').disabled = true;
                }
            }
            else if (document.getElementById('<%= rbFixed.ClientID %>').checked == true) {
                document.getElementById('<%= ddlSpDelimiter.ClientID%>').disabled = true;
                document.getElementById('<%= txtOtherDelimiter.ClientID%>').disabled = true;
            }
        }
        function EnableOtherDelimiter() {
            var ddlSpDelimiter = document.getElementById('<%= ddlSpDelimiter.ClientID%>');
             if (ddlSpDelimiter.selectedIndex != -1) {
                 if (ddlSpDelimiter.options[ddlSpDelimiter.selectedIndex].value == 'Others') {
                     document.getElementById('<%= txtOtherDelimiter.ClientID%>').disabled = false;
                }
                else {
                    document.getElementById('<%= txtOtherDelimiter.ClientID%>').value = '';
                    document.getElementById('<%= txtOtherDelimiter.ClientID%>').disabled = true;
                 }
             }
        }
        function onddlSupplierChange() {
            var supplierId = document.getElementById('<%= ddlSupplier.ClientID%>').value;            
            
            cbSupplerImportMain.PerformCallback();
            cbSupplierConfig.PerformCallback(supplierId + ";FETCH");
        }
        function onddlExistingSupplierChange() {
           
            if (document.getElementById('<%= ddlExistingSuppliers.ClientID%>').value != "0") {
                var supplierId = document.getElementById('<%= ddlExistingSuppliers.ClientID%>').value;
                $('#newSupplierImportConfig').show();
                $('#ExistingSupplier').hide();
                $('#SupplierConfigGrid').show();
                cbSupplierConfig.PerformCallback(supplierId + ";FETCH");
                document.getElementById('<%= ddlSupplier.ClientID%>').value = document.getElementById('<%= ddlExistingSuppliers.ClientID%>').value;
                cbSupplerImportMain.PerformCallback();
                $('#ExistingSupplier').hide();
                $('#SaveCancelButton').show();
                $('#NewButton').hide();
            }

        }
        
        function NewButtonClick() {
            $('#newSupplierImportConfig').show();
            $('#SupplierConfigGrid').hide();
            $('#ExistingSupplier').hide();
            $('#SaveCancelButton').show();
            $('#NewButton').hide();
            document.getElementById('<%= ddlSupplier.ClientID%>').value = "0";
            document.getElementById('<%= ddlExistingSuppliers.ClientID%>').value = "0";
            document.getElementById('<%= ddlFieldName.ClientID%>').value = "0";
            document.getElementById('<%= txtLayoutName.ClientID%>').value = "";
            document.getElementById('<%= txtEndsAt.ClientID%>').value = "";
            document.getElementById('<%= txtStartsFrom.ClientID%>').value = "";
            document.getElementById('<%= txtOrderFile.ClientID%>').value = "";
            document.getElementById('<%= cbDividePriceByHundred.ClientID%>').checked = false;
            document.getElementById('<%= cbRemoveStartZeros.ClientID%>').checked = false;
            document.getElementById('<%= cbRemoveBlankFields.ClientID%>').checked = false;
        }
        function CancelClick() {
            $('#SaveCancelButton').hide();
            $('#NewButton').show();
            $('#ExistingSupplier').show();
            $('#newSupplierImportConfig').hide();
            $('#SupplierConfigGrid').hide();
            document.getElementById('<%= ddlSupplier.ClientID%>').value = "0";
            document.getElementById('<%= ddlExistingSuppliers.ClientID%>').value="0";
            cbExistingSupplier.PerformCallback();
        }
        function OncbSupplierConfigEndCallback(s, e) {
            if (gvwSupplierConfig.GetVisibleRowsOnPage() == 0) {
                $('#SupplierConfigGrid').hide();
				} 
				else {
                $('#SupplierConfigGrid').show();
            }
            if (s.cpRefresh == "SAVE") {
                cbSupplerImportMain.PerformCallback();
            }
        }
        function SaveClick() {
            var supplierId = document.getElementById('<%= ddlSupplier.ClientID%>');
            var fieldName = document.getElementById('<%= ddlFieldName.ClientID%>');
            var startFrom =  $('#<%=txtStartsFrom.ClientID%>');
            var endsAt = $('#<%=txtEndsAt.ClientID%>');
            var orderFile = $('#<%=txtOrderFile.ClientID%>');
            var layoutName = $('#<%=txtLayoutName.ClientID%>');
            if (!FnDoValidate(supplierId, fieldName, startFrom, endsAt, orderFile, layoutName)) {
                
                return false;
            }
            else {
                cbSupplierConfig.PerformCallback(supplierId.value + ";SAVE;" + fieldName.value);
                
                startFrom.val("") ;
                endsAt.val("");
                orderFile.val("");
            }
        }
        function FnDoValidate(controlName1, controlName2, controlName3, controlName4, controlName5, controlName6) {
            if (controlName6.val() == "") {
                genIsEmpty = '<%=GetLocalResourceObject("lblLayoutNameResource1.Text")%>';
                swal(`<%=GetLocalResourceObject("GenIsEmptyErr")%>`);
                return false;
            }
            //Supplier selection
            if (controlName1.length > 0) {
                if (controlName1.selectedIndex == 0) {
                    swal('<%=GetLocalResourceObject("GenSelectSupplier")%>');
                    return false;
                }
            }
            //Column selection
            if (controlName2.length > 0) {

                if (controlName2.selectedIndex == 0) {
                    swal('<%=GetLocalResourceObject("GenSelectFieldName")%>');
                    return false;
                }
            }

            //StartNo
            if (document.getElementById('<%= rbFixed.ClientID %>').checked == true) {
                genIsEmpty = '<%=GetLocalResourceObject("lblStartsFromResource1.Text")%>';
                if (!gfi_CheckEmptyWithMessage(controlName3, `<%=GetLocalResourceObject("GenIsEmptyErr")%>` )) {
                    return false;
                }
                //StartNo numeric validation
                
                genIsNum= '<%=GetLocalResourceObject("lblStartsFromResource1.Text")%>';
                if (!gfi_ValidateNumberWithMessage(controlName3, '30125', `<%=GetLocalResourceObject("GenIsNumErr")%>`)) {
                    return false;
                }
                //StartNo numeric validation
                if (controlName3.val()== '0') {
                    swal('<%=GetLocalResourceObject("GenStartGreaterThanZero")%>');
                    return false;

                }
                genIsEmpty = '<%=GetLocalResourceObject("lblEndsAtResource1.Text")%>';
                //EndNo
                if (!gfi_CheckEmptyWithMessage(controlName4, `<%=GetLocalResourceObject("GenIsEmptyErr")%>` )) {
                    return false;
                }
                //EndNo numeric validation
                genIsNum = '<%=GetLocalResourceObject("lblEndsAtResource1.Text")%>';
                if (!gfi_ValidateNumberWithMessage(controlName4, '30126', `<%=GetLocalResourceObject("GenIsNumErr")%>`)) {
                    return false;
                }
                //StartNo < EndNo validation

                if (!(parseInt($('#<%=txtStartsFrom.ClientID%>').val(), 10) <= parseInt($('#<%=txtEndsAt.ClientID%>').val(), 10))) {
                    swal('<%=GetLocalResourceObject("GenStartLessThanEnd")%>');
                    return false;
                }

            }
            else {
                if (document.getElementById('<%= rbDelimiter.ClientID %>').checked == true) {
                    //OrderNo
                    genIsEmpty = '<%=GetLocalResourceObject("lblOrderFileResource1.Text")%>';
                    
                    if (!gfi_CheckEmptyWithMessage(controlName5, `<%=GetLocalResourceObject("GenIsEmptyErr")%>`)) {

                        return false;
                    }
                    //Order No numeric validation
                    genIsNum = '<%=GetLocalResourceObject("lblOrderFileResource1.Text")%>';
                    if (!gfi_ValidateNumberWithMessage(controlName5, '30134', `<%=GetLocalResourceObject("GenIsNumErr")%>`)) {
                        return false;
                    }
                    //Order No numeric validation
                    if (controlName5.val() == '0') {
                        swal('<%=GetLocalResourceObject("GenOrderFileGreaterThanZero")%>');
                        return false;

                    }
                }
            }
            
            return true;

        } 
        function OngvwSupplierConfigEndCallback(s, e) {
            if (e.command == "UPDATEEDIT") {
                cbSupplerImportMain.PerformCallback();
                if (gvwSupplierConfig.GetVisibleRowsOnPage() == 0) {
                    $('#SupplierConfigGrid').hide();
                }
                else {
                    $('#SupplierConfigGrid').show();
                }
            }
        }
        function OnGridFocusedCellChanging(s, e) {
            if (document.getElementById('<%= rbFixed.ClientID %>').checked == true) {
                if (e.cellInfo.column.fieldName == 'ORDER_OF_FILE') {
                    e.cancel = true;
                }
            }
            else {
                if (e.cellInfo.column.fieldName == 'START_NUM' || e.cellInfo.column.fieldName == 'END_NUM') {
                    e.cancel = true;
                }
            }
        }
        function OngvwSupplierConfigBatchEditRowValidating(s, e) {
           
            var grid = ASPxClientGridView.Cast(s);
            var cellInfoStartNum = e.validationInfo[grid.GetColumnByField("START_NUM").index];
            var cellInfoEndNum = e.validationInfo[grid.GetColumnByField("END_NUM").index];
            var cellInfoOrderOFFile = e.validationInfo[grid.GetColumnByField("ORDER_OF_FILE").index]; 
            
            if (document.getElementById('<%= rbFixed.ClientID %>').checked == true) {

                if (cellInfoStartNum.value == null || cellInfoStartNum.value == "") {
                    cellInfoStartNum.isValid = false;
                    genIsEmpty = '<%=GetLocalResourceObject("GridViewDataTextColumnResource3.Caption")%>';
                    cellInfoStartNum.errorText = `<%=GetLocalResourceObject("GenIsEmptyErr")%>`;
                    
                }
                if (cellInfoEndNum.value == null || cellInfoEndNum.value == "") {
                    cellInfoEndNum.isValid = false;
                    genIsEmpty = '<%=GetLocalResourceObject("GridViewDataTextColumnResource4.Caption")%>';
                    cellInfoEndNum.errorText = `<%=GetLocalResourceObject("GenIsEmptyErr")%>`;
                    
                }
            }
            else {
                if (cellInfoOrderOFFile.value == null || cellInfoOrderOFFile.value == "") {
                    cellInfoOrderOFFile.isValid = false;
                    genIsEmpty = '<%=GetLocalResourceObject("GridViewDataTextColumnResource5.Caption")%>';
                    cellInfoOrderOFFile.errorText = `<%=GetLocalResourceObject("GenIsEmptyErr")%>`;
                }
            }
        }
    </script>
    <div class="ui grid">
        <div class="sixteen wide column">
            <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                <h3 id="H23" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrSuppImportConfig")%></h3>
                <div class="eight wide column">
                    <div class="ui form">
                        <dx:ASPxCallbackPanel ID="cbExistingSupplier" ClientInstanceName="cbExistingSupplier" runat="server" OnCallback="cbExistingSupplier_Callback" meta:resourcekey="cbExistingSupplierResource1">
                            <PanelCollection>
                                <dx:PanelContent meta:resourcekey="PanelContentResource1">
                                    <div class="ExistingSupplier" id="ExistingSupplier">
                                        <div class="inline fields">
                                            <div class="two wide field">
                                                <asp:Label ID="lblExistingSuppliers" runat="server" Text="Existing One" meta:resourcekey="lblExistingSuppliersResource1"></asp:Label><span class="mand">*</span>
                                            </div>
                                            <div class="two wide field">
                                                <asp:DropDownList ID="ddlExistingSuppliers" runat="server" CssClass="carsInput" onchange="onddlExistingSupplierChange()" AppendDataBoundItems="True" meta:resourcekey="ddlExistingSuppliersResource1">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                        <dx:ASPxCallbackPanel ID="cbSupplerImportMain" ClientInstanceName="cbSupplerImportMain" runat="server" OnCallback="cbSupplerImportMain_Callback" meta:resourcekey="cbSupplerImportMainResource1">
                            <PanelCollection>
                                <dx:PanelContent meta:resourcekey="PanelContentResource2">
                                    <div id="newSupplierImportConfig" >
                                         <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblLayoutName" runat="server" Text="Layout Name" meta:resourcekey="lblLayoutNameResource1"></asp:Label><span class="mand">*</span>
                                        </div>
                                        <div class="two wide field">
                                            <asp:TextBox ID="txtLayoutName" runat="server" CssClass="carsInput" MaxLength="50" meta:resourcekey="txtLayoutNameResource1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblSupplier" runat="server" Text="Leverandør" meta:resourcekey="lblSupplierResource1"></asp:Label><span class="mand">*</span>
                                        </div>
                                        <div class="two wide field">
                                            <asp:DropDownList ID="ddlSupplier" ToolTipID="lblSupplier" runat="server" CssClass="carsInput" onchange="onddlSupplierChange()" meta:resourcekey="ddlSupplierResource1" >
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblFieldName" runat="server" Text="Feltnavn" meta:resourcekey="lblFieldNameResource1"></asp:Label><span class="mand">*</span>
                                        </div>
                                        <div class="two wide field">
                                            <asp:DropDownList ID="ddlFieldName" OnInit="ddlFieldName_Init" ToolTipID="lblFieldName" runat="server" CssClass="carsInput" meta:resourcekey="ddlFieldNameResource1">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblFile" runat="server" Text="Fil" meta:resourcekey="lblFileResource1"></asp:Label>
                                            <span class="mand">*</span>
                                        </div>
                                        <div class="two wide field">
                                            <asp:RadioButton ID="rbFixed" GroupName="rbFile"  runat="server" Text="Fast lengde" onclick="CheckMainInformation();" CssClass="ui radio checkbox" Checked="true" meta:resourcekey="rbFixedResource1" />
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                        </div>
                                        <div class="two wide field">
                                            <asp:RadioButton ID="rbDelimiter" GroupName="rbFile" runat="server" onclick="CheckMainInformation();" Text="Skilletegn" CssClass="ui radio checkbox" meta:resourcekey="rbDelimiterResource1" />
                                        </div>
                                        <div class="two wide field">
                                            <asp:DropDownList ID="ddlSpDelimiter" runat="server" CssClass="carsInput" onblur="CheckMainInformation();" meta:resourcekey="ddlSpDelimiterResource1">

                                                <asp:ListItem Value="\t" meta:resourcekey="ListItemResource1">Tab</asp:ListItem>
                                                <asp:ListItem Value=";" meta:resourcekey="ListItemResource2">Semicolon</asp:ListItem>
                                                <asp:ListItem Value="," meta:resourcekey="ListItemResource3">Comma</asp:ListItem>
                                                <asp:ListItem Value=" " meta:resourcekey="ListItemResource4">Space</asp:ListItem>
                                                <asp:ListItem Value="Others" meta:resourcekey="ListItemResource5">Others</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtOtherDelimiter" runat="server" CssClass="carsInput" meta:resourcekey="txtOtherDelimiterResource1" />
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblStartsFrom" runat="server" Text="Fra" meta:resourcekey="lblStartsFromResource1"></asp:Label><span class="mand">*</span>
                                        </div>
                                        <div class="two wide field">
                                            <asp:TextBox ID="txtStartsFrom" runat="server" CssClass="carsInput" MaxLength="30" meta:resourcekey="txtStartsFromResource1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblEndsAt" runat="server" Text="Til" meta:resourcekey="lblEndsAtResource1"></asp:Label><span class="mand">*</span>
                                        </div>
                                        <div class="two wide field">
                                            <asp:TextBox ID="txtEndsAt" runat="server" CssClass="carsInput" MaxLength="30" meta:resourcekey="txtEndsAtResource1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblOrderFile" runat="server" Text="Order Of File_N" meta:resourcekey="lblOrderFileResource1"></asp:Label><span class="mand">*</span>
                                        </div>
                                        <div class="two wide field">
                                            <asp:TextBox ID="txtOrderFile" runat="server" CssClass="carsInput" MaxLength="30" meta:resourcekey="txtOrderFileResource1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="two wide field">
                                            <asp:Label ID="lblPriceFileDecSep" runat="server" Text="Pricefile Decimal Seperator" meta:resourcekey="lblPriceFileDecSepResource1"></asp:Label>
                                        </div>
                                        <div class="two wide field">
                                             <asp:DropDownList ID="ddlPriceFileDecSep" runat="server" CssClass="carsInput" meta:resourcekey="ddlPriceFileDecSepResource1">
                                                <asp:ListItem Value="." >DecSep .</asp:ListItem>
                                                <asp:ListItem Value=",">DecSep ,</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <label>
                                            <asp:CheckBox ID="cbRemoveStartZeros" runat="server" Text="Fjern ledende nuller" CssClass="ui checkbox" meta:resourcekey="cbRemoveStartZerosResource1" /></label>
                                        <label>
                                            <asp:CheckBox ID="cbRemoveBlankFields" runat="server" Text="Fjern blanke felter" CssClass="ui checkbox" meta:resourcekey="cbRemoveBlankFieldsResource1" /></label>
                                        <label>
                                            <asp:CheckBox ID="cbDividePriceByHundred" runat="server" Text="Del priser på 100" CssClass="ui checkbox" meta:resourcekey="cbDividePriceByHundredResource1" /></label>
                                    </div>

                                    </div>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                        <div id="NewButton" class="NewButton">
                        <div class="inline fields">
                            <div class="two wide field"></div>
                            <div class="one wide field">
                                <input type="button" id="btnImport" runat="server" class="ui button blue" meta:resourcekey="btnNewResource1" value='Ny' onclick="NewButtonClick()"/>
                            </div>
                            <div class="two wide field"></div>
                        </div>
                            </div>
                        <div id="SaveCancelButton" class="SaveCancelButton">
                        <div class="inline fields">
                            <div class="two wide field"></div>
                            <div class="one wide field">
                                <input type="button" id="btnSave" runat="server" class="ui button blue" meta:resourcekey="btnSaveResource1" value='Lagre' onclick="SaveClick()"/>
                            </div>
                            <div class="one wide field">
                                <input type="button" id="btnCancel" runat="server" class="ui button red" meta:resourcekey="btnCancelResource1" value='Avbryt' onclick="CancelClick()" />
                            </div>
                            <div class="two wide field"></div>
                        </div>
                            </div>
                    </div>
                </div>
                <div class="six wide column">

                </div>
                <div id="SupplierConfigGrid" class="SupplierConfigGrid">
                    <dx:ASPxCallbackPanel ID="cbSupplierConfig" ClientInstanceName="cbSupplierConfig" ClientSideEvents-EndCallback="OncbSupplierConfigEndCallback" OnCallback="cbSupplierConfig_Callback" runat="server" meta:resourcekey="cbSupplierConfigResource1">
                        <ClientSideEvents EndCallback="OncbSupplierConfigEndCallback"></ClientSideEvents>
                        <PanelCollection>
                            <dx:PanelContent meta:resourcekey="PanelContentResource3">
                                <div>
                                    <dx:ASPxGridView ID="gvwSupplierConfig" ClientSideEvents-FocusedCellChanging="OnGridFocusedCellChanging" style= "border-radius: 5px;"  ClientSideEvents-EndCallback="OngvwSupplierConfigEndCallback" OnBatchUpdate="gvwSupplierConfig_BatchUpdate" SettingsEditing-Mode="Batch" ClientInstanceName="gvwSupplierConfig" Width="100%" runat="server" KeyFieldName="ID_SUPP_IMPORT" Theme="Office2010Blue" meta:resourcekey="gvwSupplierConfigResource1">
                                        <ClientSideEvents FocusedCellChanging="OnGridFocusedCellChanging" EndCallback="OngvwSupplierConfigEndCallback" BatchEditRowValidating="OngvwSupplierConfigBatchEditRowValidating"></ClientSideEvents>

                                        <SettingsEditing Mode="Batch"></SettingsEditing>
                                        <SettingsBehavior AllowFocusedRow="true" AllowSort="false" />
                                        <SettingsPopup>
                                            <FilterControl AutoUpdatePosition="False"></FilterControl>
                                        </SettingsPopup>
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" VisibleIndex="0" ShowClearFilterButton="True" meta:resourcekey="GridViewCommandColumnResource1">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="ID_SUPP_IMPORT" ReadOnly="True" VisibleIndex="1" Visible="false" meta:resourcekey="GridViewDataTextColumnResource1">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="FIELD_NAME" ReadOnly="True" VisibleIndex="2" Caption="Feltnavn" meta:resourcekey="GridViewDataTextColumnResource2" HeaderStyle-Font-Bold="true"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="START_NUM" VisibleIndex="3" Caption="Fra" meta:resourcekey="GridViewDataTextColumnResource3" HeaderStyle-Font-Bold="true"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="END_NUM" VisibleIndex="4" Caption="Til" meta:resourcekey="GridViewDataTextColumnResource4" HeaderStyle-Font-Bold="true"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ORDER_OF_FILE" VisibleIndex="5" Caption="Order of File_N" meta:resourcekey="GridViewDataTextColumnResource5" HeaderStyle-Font-Bold="true"></dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsPager PageSize="10">
                                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                             </SettingsPager>
                                    </dx:ASPxGridView>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
