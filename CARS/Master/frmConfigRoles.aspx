<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmConfigRoles.aspx.vb" Inherits="CARS.frmConfigRoles" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style>
        .gridView .dxgvDataRow_Office2010Blue {
            height: 20px;
            font-size: small;
        }

        .customComboBox {
            height: 10% !important;
            border-color: #dbdbdb;
            border-radius: 6px;
        }

        .dxflItem_Office365 {
            padding: 1px 0;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('#divGrids').hide();
            $('#divPerGrid').hide();
        });

        function OndrpSelectedIndexChanged(s, e) {
            var subId = drpSubsidiary.GetValue();
            var deptId = drpDepartment.GetValue();
            console.log(subId + ";" + deptId);
            cbRolesGrid.PerformCallback(subId + ";" + deptId);
            $('#divGrids').hide();
        }
        function OnbtnEditRolesClick(s, e) {
            var idRole = gvRoles.GetRowKey(e.visibleIndex);
            var subId = drpSubsidiary.GetValue();
            var deptId = drpDepartment.GetValue();
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Edit");
            $(document.getElementById('<%=hdnRoleId.ClientID%>')).val(idRole);
            cbEditRoles.PerformCallback(e.visibleIndex + ";" + subId + ";" + deptId);
            popupEditRoles.Show();
        }
        function addRoleDetails() {
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Add");
            $(document.getElementById('<%=hdnRoleId.ClientID%>')).val("0");
            var subId = drpSubsidiary.GetValue();
            var deptId = drpDepartment.GetValue();
            //console.log(subId + ";" + deptId);
            cbEditRoles.PerformCallback(subId + ";" + deptId);
            popupEditRoles.Show();
        }
        function CancelRole(s, e) {
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("");
            popupEditRoles.Hide();
        }
        function SaveRole() {
            var result = fnClientValidate();
            if (result == true) {
                var roleId = document.getElementById('<%=hdnRoleId.ClientID%>').value;
                $.ajax({
                    type: "POST",
                    url: "frmConfigRoles.aspx/SaveRoleDetails",
                    data: "{roleId: '" + roleId + "',roleNm: '" + txtRole.GetText() + "', subId:'" + drpSubsidiary.GetValue() + "', deptId:'" + drpDepartment.GetValue() + "', startScrRoleId:'" + drpStartScreen.GetValue() + "', flgSysAdmin:'" + rbaddadmin.GetChecked() + "', flgSubAdmin:'" + rbaddsubadmin.GetChecked() + "', flgDeptAdmin:'" + rbadddepadmin.GetChecked() + "', mode:'" + $('#<%=hdnMode.ClientID%>').val() + "', flgNbkSett:'" + cbNbkSettings.GetChecked() + "', flgAccounting:'" + cbAccounting.GetChecked() + "', flgSPOrder:'" + cbCarSales.GetChecked() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        if (Result.d == "NOSCREEN") {
                            systemMSG('error', '<%=GetLocalResourceObject("errNoPermisson")%>', 6000);
                        }
                        else if (Result.d == "EXITS") {
                            systemMSG('error', '<%=GetLocalResourceObject("errRecExists")%>', 6000);
                        }
                        else if (Result.d == "OK") {
                            systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                        }
                        else {
                            systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                        }
                        var subId = drpSubsidiary.GetValue();
                        var deptId = drpDepartment.GetValue();
                        console.log(subId + ";" + deptId);
                        cbRolesGrid.PerformCallback(subId + ";" + deptId);
                        popupEditRoles.Hide();
                        $('#divGrids').hide();
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }
        }
        function fnClientValidate() {
            if (txtRole.GetText() == "") {
                swal('<%=GetLocalResourceObject("errEmptyRole")%>');
                return false;
            }
            if (!(validateAlphabets(txtRole.GetText()))) {
                swal('<%=GetLocalResourceObject("errRoleInvalid")%>');
                return false;
            }
            return true;
        }
        function validateAlphabets(value) {
            var isValid = false;
            var regex = /^[a-zA-Z0-9 -& ÆØÅæøå]*$/;
            isValid = regex.test(value);
            return isValid;
        }
        function delRoles() {

            var selectedList = gvRoles.GetSelectedKeysOnPage();
            var row;
            var roleId;
            var roleName = "";
            var roleIdxml;
            var roleIdxmls = "";
            if (selectedList.length > 0) {
                swal({
                    title: '<%=GetLocalResourceObject("genDelCnf")%>',
                    text: '<%=GetLocalResourceObject("genDelWar")%>',
                    icon: "warning",
                    buttons: ['Cancel', 'Ok'],

                })
                    .then((willDelete) => {
                        if (willDelete) {
                            for (var i = 0; i < selectedList.length; i++) {
                                roleId = selectedList[i];
                                roleIdxml = "<ROLE><ID_ROLE>" + roleId + "</ID_ROLE>" + "<NM_ROLE>" + roleName + "</NM_ROLE></ROLE>";
                                roleIdxmls += roleIdxml;
                            }

                            if (roleIdxmls != "") {
                                roleIdxmls = "<ROOT>" + roleIdxmls + "</ROOT>";
                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "frmConfigRoles.aspx/DeleteRole",
                                    data: "{roleIdxmls: '" + roleIdxmls + "'}",
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.d[0] == "DEL") {
                                            systemMSG('success', '<%=GetLocalResourceObject("genRecDel")%>', 6000);
                                        }
                                        else if (data.d[0] == "NDEL") {
                                            systemMSG('error', '<%=GetLocalResourceObject("errDelFailed")%>', 6000); 
                                        }
                                        var subId = drpSubsidiary.GetValue();
                                        var deptId = drpDepartment.GetValue();
                                        console.log(subId + ";" + deptId);
                                        cbRolesGrid.PerformCallback(subId + ";" + deptId);
                                    },
                                    error: function (result) {
                                        alert("Error");
                                    }
                                });
                            }
                        }
                        else {
                            return false;
                        }

                    });
            }
            else {
                swal('<%=GetLocalResourceObject("errSelEtryDel")%>');
            }
        }
        function OndrpRoleValueChanged(s, e) {
            var idRole = drpRole.GetValue();

            if (idRole != "0") {
                $('#divGrids').show();
                $(document.getElementById('<%=hdnRoleId.ClientID%>')).val(idRole);
                cbPerGrid.PerformCallback("FETCH;" + idRole);
                cbPerCtrlGrid.PerformCallback("FETCH;" + idRole);
                cbChkLayout.PerformCallback(idRole);
            }
            else {
                $('#divGrids').hide();
            }
            
        }
        function createRolesXml(control) {
            if (control.GetParentControl() === chkBoxFrmLayout && control instanceof ASPxClientEdit) {
                var scrId;
                var scrName;
                var scrIdxml;
                var scrIdxmls = "";
                if (control.GetChecked() && control.GetEnabled()) {
                    scrId = control.name;
                    scrName = control.GetText();
                    control.SetEnabled(false);
                    scrIdxml = "<Master><ScrId>" + scrId + "</ScrId>" + "<ScrName>" + scrName + "</ScrName></Master>";
                    scrIdxmls += scrIdxml;
                    //console.log(oldXml);
                    var oldXml = hdnXML;
                    hdnXML = oldXml + scrIdxmls;
                }
            }

        }
        function AddScRole() {
            hdnXMLNew.Set("xmlString", "");
            hdnXML = "";
            ASPxClientControl.GetControlCollection().ForEachControl(createRolesXml);
            if (hdnXML != "") {
                hdnXML = "<Root>" + hdnXML + "</Root>";
            }
            hdnXMLNew.Set("xmlString", hdnXML);
            console.log(hdnXMLNew.Get("xmlString"));
            var idRole = drpRole.GetValue();
            cbPerGrid.PerformCallback("ADD;" + idRole);

        }
        function CanceScrlRole() {
            if (gvPermissions.batchEditApi.HasChanges()) {
                gvPermissions.CancelEdit();
            }
            ASPxClientControl.GetControlCollection().ForEachControl(DeSelectAllcb);
            var idRole = drpRole.GetValue();
            cbPerGrid.PerformCallback("FETCH;" + idRole);
        }
        function SelectAllCbClick(s, e) {
            ASPxClientControl.GetControlCollection().ForEachControl(SelectAllcbs);
        }
        function SelectAllcbs(control) {
            if (control.GetParentControl() === chkBoxFrmLayout && control instanceof ASPxClientEdit) {
                if (chkSelectAll.GetChecked()) {
                    control.SetChecked(true);
                }
                else {
                    control.SetChecked(false);
                }
            }
        }
        function DeSelectAllcb(control) {
            if (control.GetParentControl() === chkBoxFrmLayout && control instanceof ASPxClientEdit) {
                control.SetChecked(false);
                control.SetEnabled(true);
            }
        }
        function FinalSaveRole() {
            var idRole = drpRole.GetValue();
            if (gvPermissions.batchEditApi.HasChanges()) {
                gvPermissions.UpdateEdit();
            }
            else {
                cbPerGrid.PerformCallback("SAVE;" + idRole);
            }
            if (gvCtrlPermissions.batchEditApi.HasChanges()) {
                gvCtrlPermissions.UpdateEdit();
            }
            else {
                cbPerCtrlGrid.PerformCallback("SAVE;" + idRole);
            }
        }
        function OncbPerCtrlGridEndCallback(s, e) {
            console.log(s.cpIsSave);
            if (s.cpIsSave) {
                var idRole = drpRole.GetValue();
                console.log(s.cpStrResult)
                if (s.cpStrResult != null && s.cpStrResult != undefined && s.cpStrResult != "") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                }
                cbPerGrid.PerformCallback("FETCH;" + idRole);
            }
        }
        function OngvCtrlPermissionsEndCallback(s, e) {
            if (e.command == 'UPDATEEDIT') {
                var idRole = drpRole.GetValue();
                if (s.cpStrResult != null && s.cpStrResult != undefined && s.cpStrResult != "") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                }
                cbPerGrid.PerformCallback("FETCH;" + idRole);
            }
        }
        function OncbPerGridEndCallback(s, e) {
            if (s.cpIsAdd != null && s.cpIsAdd != undefined) {
                if (s.cpIsAdd) {
                    if (gvPermissions.GetVisibleRowsOnPage() > 0) {
                        $('#divPerGrid').show();
                    }
                    else {
                        $('#divPerGrid').hide();
                    }
                }
            }
        }
        function ResetAll() {
            if (gvPermissions.batchEditApi.HasChanges()) {
                gvPermissions.CancelEdit();
            }
            if (gvCtrlPermissions.batchEditApi.HasChanges()) {
                gvCtrlPermissions.CancelEdit();
            }
            location.reload();
        }
    </script>
    <div class="ui form" style="width: 100%">
        <div id="systemMessage" class="ui message"></div>
        <asp:HiddenField ID="hdnMode" runat="server" />
        <asp:HiddenField ID="hdnRoleId" runat="server" />
        <asp:HiddenField ID="hdnXML" runat="server" />
        <%--<asp:HiddenField ID="hdnXMLNew" runat="server" />--%>
        <dx:ASPxHiddenField ID="hdnXMLNew" ClientInstanceName="hdnXMLNew" runat="server"></dx:ASPxHiddenField>
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
        <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
            <a id="header" runat="server" class="active item"><%=GetLocalResourceObject("hdrRoles")%></a>
        </div>
        <div class="two fields">
            <div class="field" style="padding-left: 0.55em; width: 200px">
                <asp:Label ID="lblSubsId" runat="server" Text="Subsidiary ID" meta:resourcekey="lblSubsIdResource1"></asp:Label>
            </div>
            <div class="field" style="width: 250px">
                <dx:ASPxComboBox ID="drpSubsidiary" ClientInstanceName="drpSubsidiary" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="drpSubsidiaryResource1">
                    <ClientSideEvents SelectedIndexChanged="OndrpSelectedIndexChanged" />
                </dx:ASPxComboBox>
            </div>
        </div>
        <div class="two fields">
            <div class="field" style="padding-left: 0.55em; width: 200px">
                <asp:Label ID="lblDeptId" runat="server" Text="Department ID" meta:resourcekey="lblDeptIdResource1"></asp:Label>
            </div>
            <div class="field" style="width: 250px">
                <dx:ASPxComboBox ID="drpDepartment" ClientInstanceName="drpDepartment" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="drpDepartmentResource1">
                    <ClientSideEvents SelectedIndexChanged="OndrpSelectedIndexChanged" />
                </dx:ASPxComboBox>
            </div>

        </div>
    </div>
    <div>
        <dx:ASPxCallbackPanel ID="cbRolesGrid" ClientInstanceName="cbRolesGrid" runat="server" OnCallback="cbRolesGrid_Callback" meta:resourcekey="cbRolesGridResource1">
            <%-- <ClientSideEvents EndCallback="OncbRolesGridEndCallback" />--%>
            <PanelCollection>
                <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">
                    <div class="ui form">
                        <div>
                            <dx:ASPxGridView ID="gvRoles" ClientInstanceName="gvRoles" runat="server" Theme="Office2010Blue" Width="60%" KeyFieldName="ID_ROLE" CssClass="gridView" meta:resourcekey="gvRolesResource1">
                                <SettingsPager>
                                    <PageSizeItemSettings Visible="false" ShowAllItem="true" Position="Left" />
                                </SettingsPager>
                                <ClientSideEvents CustomButtonClick="OnbtnEditRolesClick" />
                                <SettingsEditing Mode="Batch"></SettingsEditing>
                                <Settings ShowPreview="false" ShowStatusBar="Hidden" />

                                <SettingsPopup>
                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                </SettingsPopup>
                                <Columns>
                                    <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" Width="10%" meta:resourcekey="GridViewCommandColumnResource1"></dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID_SCR_START_ROLE" Visible="false" Width="1%" meta:resourcekey="GridViewDataTextColumnResource1"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NM_ROLE" Caption="Role" ReadOnly="true" Width="50%" meta:resourcekey="GridViewDataTextColumnResource2">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="FLG_SYSADMIN" Caption="Admin" ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource1">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="FLG_SUBSIDADMIN" Caption="Subsidary Admin" ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource2">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="FLG_DEPTADMIN" Caption="Dept Admin" ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource3">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="FLG_NBK" Visible="false" meta:resourcekey="GridViewDataCheckColumnResource4"></dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="FLG_ACCOUNTING" Visible="false" meta:resourcekey="GridViewDataCheckColumnResource5"></dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="FLG_SPAREPARTORDER" Visible="false" meta:resourcekey="GridViewDataCheckColumnResource6"></dx:GridViewDataCheckColumn>
                                    <dx:GridViewCommandColumn Caption=" " Width="10%" meta:resourcekey="GridViewCommandColumnResource2">
                                        <CustomButtons>
                                            <dx:GridViewCommandColumnCustomButton ID="btnEditRoles" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource1"></dx:GridViewCommandColumnCustomButton>
                                        </CustomButtons>
                                    </dx:GridViewCommandColumn>
                                </Columns>
                            </dx:ASPxGridView>
                        </div>
                        <div class="four wide field"></div>

                        <div class="inline fields">
                            <div class="four wide field"></div>
                            <div class="two wide field">
                                <input id="btnAddT"  type="button" value='<%=GetLocalResourceObject("btnAdd")%>'  class="ui button blue" onclick="addRoleDetails()" />
                                &nbsp;<input id="btnDeleteT"  type="button" value='<%=GetLocalResourceObject("btnDelete")%>'  class="ui button negative" onclick="delRoles()" />
                            </div>
                        </div>
                        <div class="four wide field"></div>
                        <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                            <a id="aAccessRt" runat="server" class="active item"><%=GetLocalResourceObject("hdrAccessRights")%></a>
                        </div>
                        <div class="inline fields">
                            <div class="two wide field">
                                <asp:Label ID="lblRoles" runat="server" Text="Roles" meta:resourcekey="lblRolesResource1"></asp:Label><span class="mand">*</span>
                            </div>
                            <div class="three wide field">
                                <dx:ASPxComboBox ID="drpRole" ClientInstanceName="drpRole" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="drpRoleResource1">
                                    <ClientSideEvents ValueChanged="OndrpRoleValueChanged" />
                                </dx:ASPxComboBox>
                            </div>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>

    </div>

    <div id="divGrids">
        <div class="ui form">
            <dx:ASPxCallbackPanel ID="cbPerGrid" ClientInstanceName="cbPerGrid" runat="server" OnCallback="cbGrids_Callback" meta:resourcekey="cbPerGridResource1">
                <ClientSideEvents EndCallback="OncbPerGridEndCallback" />
                <PanelCollection>
                    <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource2">
                        <div id="divPerGrid">
                            <dx:ASPxGridView ID="gvPermissions" ClientInstanceName="gvPermissions" runat="server" Theme="Office2010Blue" Width="60%" KeyFieldName="ID_SCR_UTIL" CssClass="gridView" OnBatchUpdate="gvPermissions_BatchUpdate" meta:resourcekey="gvPermissionsResource1">
                                <SettingsPager>
                                    <PageSizeItemSettings Visible="false" ShowAllItem="true" Position="Right" />
                                </SettingsPager>
                                <SettingsEditing Mode="Batch"></SettingsEditing>
                                <Settings ShowPreview="false" ShowStatusBar="Hidden" />

                                <SettingsPopup>
                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                </SettingsPopup>
                                <Columns>
                                    <%--<dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page"></dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID_SCR_START_ROLE" Visible="false" Width="1%"></dx:GridViewDataTextColumn>--%>
                                    <dx:GridViewDataTextColumn FieldName="NAME_SCR" Caption="Screen Name" ReadOnly="true" Width="50%" meta:resourcekey="GridViewDataTextColumnResource3">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="ACC_READ" Caption="Read" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource7">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="ACC_WRITE" Caption="Write" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource8">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="ACC_CREATE" Caption="Create" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource9">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="ACC_PRINT" Caption="Print" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource10">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="ACC_DELETE" Caption="Delete" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource11">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                            </dx:ASPxGridView>
                        </div>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
            <dx:ASPxCallbackPanel ID="cbChkLayout" ClientInstanceName="cbChkLayout" runat="server" OnCallback="cbChkLayout_Callback" meta:resourcekey="cbChkLayoutResource1">
                <PanelCollection>
                    <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource3">
                        <div style="padding-left: 20px">
                            <dx:ASPxCheckBox ID="chkSelectAll" ClientInstanceName="chkSelectAll" Text="Select All" ClientSideEvents-CheckedChanged="SelectAllCbClick" runat="server" Theme="Office2010Blue" Font-Size="7" meta:resourcekey="chkSelectAllResource1">
                                <ClientSideEvents CheckedChanged="SelectAllCbClick"></ClientSideEvents>
                            </dx:ASPxCheckBox>
                        </div>
                        <div>
                            <dx:ASPxFormLayout ID="chkBoxFrmLayout" ClientInstanceName="chkBoxFrmLayout" runat="server" Width="100%" Theme="Office365" meta:resourcekey="chkBoxFrmLayoutResource1"></dx:ASPxFormLayout>
                        </div>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
            <div style="text-align: center">
                <input id="btnAddScRole" type="button" value='<%=GetLocalResourceObject("btnAdd")%>' class="ui button positive" onclick="AddScRole()" />
                <input id="btnCanscrRole" type="button" value='<%=GetLocalResourceObject("btnCancel")%>' class="ui button negative" onclick="CanceScrlRole()" />
            </div>
            <div class="four wide field"></div>
            <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                <a id="aCtrlRt" runat="server" class="active item"><%=GetLocalResourceObject("hdrControlRights")%></a>
            </div>
            <div>
                <dx:ASPxCallbackPanel ID="cbPerCtrlGrid" ClientInstanceName="cbPerCtrlGrid" runat="server" OnCallback="cbPerCtrlGrid_Callback" meta:resourcekey="cbPerCtrlGridResource1">
                    <ClientSideEvents EndCallback="OncbPerCtrlGridEndCallback" />
                    <PanelCollection>
                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource4">
                            <dx:ASPxGridView ID="gvCtrlPermissions" ClientInstanceName="gvCtrlPermissions" runat="server" Theme="Office2010Blue" Width="60%" KeyFieldName="ID_CON_UTIL" CssClass="gridView" OnBatchUpdate="gvCtrlPermissions_BatchUpdate" meta:resourcekey="gvCtrlPermissionsResource1">
                                <SettingsPager PageSize="10">
                                    <PageSizeItemSettings Visible="false" ShowAllItem="true" />
                                </SettingsPager>
                                <ClientSideEvents EndCallback="OngvCtrlPermissionsEndCallback" />
                                <SettingsEditing Mode="Batch"></SettingsEditing>
                                <Settings ShowPreview="false" ShowStatusBar="Hidden" />

                                <SettingsPopup>
                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                </SettingsPopup>
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="NAME_CONTROL" Caption="Control Name" ReadOnly="true" Width="90%" meta:resourcekey="GridViewDataTextColumnResource4">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="HAS_ACCESS" Caption="Has Access" Width="10%" meta:resourcekey="GridViewDataCheckColumnResource12">
                                        <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                            </dx:ASPxGridView>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </div>
            <div class="four wide field"></div>
            <div style="text-align: center">
                <input id="btnSave" type="button" value='<%=GetLocalResourceObject("btnSave")%>' class="ui button blue" onclick="FinalSaveRole()" />
                <input id="btnReset" type="button" value='<%=GetLocalResourceObject("btnReset")%>' class="ui button negative" onclick="ResetAll()" />
            </div>
            <div class="four wide field"></div>
            <div class="four wide field"></div>
        </div>
    </div>

    <div>
        <dx:ASPxPopupControl runat="server" ID="popupEditRoles" ClientInstanceName="popupEditRoles" PopupHorizontalAlign="Center" Modal="True" HeaderText="Roles" PopupVerticalAlign="Middle" Top="250" Left="600" Width="510px" Height="250px" CloseAction="CloseButton" Theme="Office365" meta:resourcekey="popupEditRolesResource1">
            <ContentCollection>
                <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource1">
                    <dx:ASPxCallbackPanel ID="cbEditRoles" ClientInstanceName="cbEditRoles" runat="server" OnCallback="cbEditRoles_Callback" Width="100%" meta:resourcekey="cbEditRolesResource1">
                        <PanelCollection>
                            <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource5">
                                <div class="ui form" style="width: 100%;">
                                    <div id="divEdit">
                                        <p></p>
                                        <div id="divEdit1" class="inline fields">
                                            <div class="tewelve wide field">
                                                <div class="field" style="padding: 3px">
                                                    <asp:Label ID="lblRole" runat="server" Text="Role" Width="84px" meta:resourcekey="lblRoleResource1"></asp:Label><span class="mand">*</span>
                                                </div>
                                                <div class="field" style="padding: 3px">
                                                    <%--<asp:TextBox ID="txtRole" runat="server" CssClass="inp" MaxLength="20" Width="174px"></asp:TextBox>--%>
                                                    <dx:ASPxTextBox ID="txtRole" ClientInstanceName="txtRole" CssClass="customComboBox" runat="server" Width="180px" meta:resourcekey="txtRoleResource1"></dx:ASPxTextBox>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="inline fields">
                                            <div class="tewelve wide field">
                                                <div class="field" style="padding: 3px">
                                                    <asp:Label ID="lblStartScreen" runat="server" Text="Start Screen" Width="100px" meta:resourcekey="lblStartScreenResource1"></asp:Label>
                                                </div>
                                                <div class="field" style="padding: 3px">
                                                    <%--<asp:DropDownList ID="drpStartScreen" runat="server" CssClass="drpdwm"></asp:DropDownList>--%>
                                                    <dx:ASPxComboBox ID="drpStartScreen" ClientInstanceName="drpStartScreen" CssClass="customComboBox" Theme="Metropolis" Width="290px" runat="server" meta:resourcekey="drpStartScreenResource1"></dx:ASPxComboBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="inline fields">
                                            <div class="ten wide field">
                                            </div>
                                        </div>
                                        <div id="divEdit2" class="inline fields">
                                            <div class="five wide field">
                                                <%-- <asp:RadioButton ID="rbaddadmin" runat="server" Text="Admin" style="padding-right:20px;"   />--%>
                                                <dx:ASPxRadioButton ID="rbaddadmin" ClientInstanceName="rbaddadmin" Text="Admin" runat="server" GroupName="adm" Theme="Office2010Blue" meta:resourcekey="rbaddadminResource1" />
                                            </div>

                                            <div class="five wide field">
                                                <%--<asp:RadioButton ID="rbaddsubadmin" runat="server" Text="Subsidiary Admin"/>--%>
                                                <dx:ASPxRadioButton ID="rbaddsubadmin" ClientInstanceName="rbaddsubadmin" Text="Subsidiary Admin" runat="server" GroupName="adm" Theme="Office2010Blue" meta:resourcekey="rbaddsubadminResource1" />
                                            </div>
                                            <div class="six wide field">
                                                <%--<asp:RadioButton ID="rbadddepadmin" runat="server" Text="Department Admin"/>--%>
                                                <dx:ASPxRadioButton ID="rbadddepadmin" ClientInstanceName="rbadddepadmin" Text="Department Admin" runat="server" GroupName="adm" Theme="Office2010Blue" meta:resourcekey="rbadddepadminResource1" />
                                            </div>
                                        </div>
                                        <div class="inline fields">
                                            <div class="five wide field">
                                                <dx:ASPxCheckBox ID="cbNbkSettings" runat="server" ClientInstanceName="cbNbkSettings" Text="Nbk Settings" Theme="Office2010Blue" meta:resourcekey="cbNbkSettingsResource1" />
                                            </div>
                                            <div class="five wide field">
                                                <dx:ASPxCheckBox ID="cbAccounting" runat="server" ClientInstanceName="cbAccounting" Text="Accounting" Theme="Office2010Blue" meta:resourcekey="cbAccountingResource1" />
                                            </div>
                                            <div class="six wide field">
                                                <dx:ASPxCheckBox ID="cbSparePartOrder" runat="server" ClientInstanceName="cbCarSales" Text="Spare Part Order" Theme="Office2010Blue" meta:resourcekey="cbSparePartOrderResource1" />
                                            </div>
                                        </div>
                                        <div class="inline fields">
                                            <div class="ten wide field">
                                            </div>
                                        </div>
                                        <div id="divEdit3" style="text-align: center;">
                                            <input id="btnRolesAdd" type="button" value='<%=GetLocalResourceObject("btnSave")%>' class="ui button positive" onclick="SaveRole()" />
                                            &nbsp;<input id="btnRolesAddCancel" type="button" value='<%=GetLocalResourceObject("btnCancel")%>' class="ui button negative" onclick="CancelRole()" />

                                        </div>

                                    </div>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </div>

</asp:Content>
