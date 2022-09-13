<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmCfHourlyPrice.aspx.vb" Inherits="CARS.frmCfHourlyPrice" MasterPageFile="~/MasterPage.Master"   meta:resourcekey="PageResource1"  %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cntMainPanel">
    <style type="text/css">
        .gridView .dxgvDataRow_Office2010Blue {
            height: 20px;
            font-size: small;
        }

        #gridHP {
            display: none;
        }

        #btnDelete {
            display: none;
        }

        .customComboBox {
            height: 10% !important;
            border-color: #dbdbdb;
            border-radius: 6px;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $('.menu .item')
                .tab()
                ; //activate the tabs

            setTab('tabHP');

            function setTab(cTab) {

                var tabID = "";
                tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
                var tab;
                (tabID == "") ? tab = cTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
                //console.log(tabID);
            }

            $('.cTab').on('click', function (e) {
                setTab($(this));
            });

        });//end of ready

        function SearchDepartment() {
            var deptFrom = cmbDepFrom.GetValue();
            var deptTo = cmbDepTo.GetValue();
            cbHPGrid.PerformCallback(deptFrom + ";" + deptTo);
        }
        function AddHourlyPriceDet() {
            $('#<%=hdnHPMode.ClientID%>').val("Add");
            popupHourlyPrice.Show();
            cbHPDetails.PerformCallback();
        }
        function OnSaveBtnClick() {
            if (!HPClientValidate()) {
                return false;
            }
            cbSaveHPDetails.PerformCallback("SAVE");
            popupHourlyPrice.Hide();
        }
        function OncbHPGridEndCallback(s, e) {
            //console.log(gvHourlyPrice.GetVisibleRowsOnPage());
            if (gvHourlyPrice.GetVisibleRowsOnPage() > 0) {
                $('#gridHP').show();
                $('#btnDelete').show();
            }
            else {
                $('#gridHP').hide();
                $('#btnDelete').hide();
            }
        }
        function OncbSaveHPDetailsEndCallback(s, e) {
            if (s.cpSaveStrResult != null && s.cpSaveStrResult != undefined) {
                if (s.cpSaveStrResult == "INSFLG") {
                    systemMSG('error', '<%=GetLocalResourceObject("errRecExists")%>', 6000);
                }
                else {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                }
            }
            //console.log(s.cpDelStrResult);
            if (s.cpDelStrResult != null && s.cpDelStrResult != undefined) {
                if (s.cpDelStrResult == "0") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecDel")%>', 6000);
                }
                else {
                    systemMSG('error', '<%=GetLocalResourceObject("errDelFail")%>', 6000);
                }
            }
            var deptFrom = cmbDepFrom.GetValue();
            var deptTo = cmbDepTo.GetValue();
            cbHPGrid.PerformCallback(deptFrom + ";" + deptTo);
        }

        function OnGvHourlyPriceCustomButtonClick(s, e) {
            $('#<%=hdnHPMode.ClientID%>').val("Edit");
            var hpSeqId = gvHourlyPrice.GetRowKey(e.visibleIndex);
            $('#<%=hdnHPSeqId.ClientID%>').val(hpSeqId);
            popupHourlyPrice.Show();
            cbHPDetails.PerformCallback(hpSeqId);
        }
        function DeleteHourlyPrice() {

            var selectedList = gvHourlyPrice.GetSelectedKeysOnPage();
            if (selectedList.length > 0) {
                swal({
                    title: '<%=GetLocalResourceObject("genDelCnf")%>',
                    text: '<%=GetLocalResourceObject("genDelWar")%>',
                    icon: "warning",
                    buttons: ['Cancel', 'Ok'],

                })
                    .then((willDelete) => {
                        if (willDelete) {
                            cbSaveHPDetails.PerformCallback('DELETE');
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
        function OnchkMechnaicCodeValueChanged(s, e) {
            if (chkMechnaicCode.GetChecked()) {
                txtCost.SetText("");
                txtCost.SetEnabled(false);
            }
            else {
                txtCost.SetEnabled(true);
                txtCost.SetText("");
            }
        }
        function HPClientValidate() {
            var ctrlName = '<%=GetLocalResourceObject("lblDepartmentCodeResource1.Text")%>';
            if (cmbDepartmentCode.GetSelectedIndex() == "0") {
                swal(`<%=GetLocalResourceObject("errSelectCtrl")%>`);
                cmbDepartmentCode.SetFocus();
                return false;
            }

            if (!(validateAlphabets(txtTextforLabour.GetText()))) {
                swal('<%=GetLocalResourceObject("errNoSpclChars")%>');
                txtTextforLabour.SetFocus();
                return false;
            }

            ctrlName = '<%=GetLocalResourceObject("lblTextforLabourResource1.Text")%>';
            if (!(ValidateSingleQuote(txtTextforLabour.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSglQt")%>`);
                return false;
            }
            ctrlName = '<%=GetLocalResourceObject("lblPriceResource1.Text")%>';
            if (txtPrice.GetText() == "") {
                swal(`<%=GetLocalResourceObject("errEmtVal")%>`);
                txtPrice.SetFocus();
                return false;
            }

            if (!(gfi_ValidateNumDotValue(txtPrice.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvVal")%>`);
                txtPrice.SetFocus();
                return false;
            }

            if (!fn_ValidateDecimalValue(txtPrice.GetText(), '<%= Session("Decimal_Seperator") %>')) {
                swal(`<%=GetLocalResourceObject("errInvVal")%>`);
                txtPrice.SetFocus();
                return false;
            }

            ctrlName = '<%=GetLocalResourceObject("lblCostResource1.Text")%>';
            if (!chkMechnaicCode.GetChecked()) {
                if (txtCost.GetText() == "") {
                    swal(`<%=GetLocalResourceObject("errEmtVal")%>`);
                    return false;
                }

                if (!(gfi_ValidateNumDotValue(txtCost.GetText()))) {
                    swal(`<%=GetLocalResourceObject("errInvVal")%>`);
                    return false;
                }
            }

            if (!fn_ValidateDecimalValue(txtCost.GetText(), '<%= Session("Decimal_Seperator") %>')) {
                swal(`<%=GetLocalResourceObject("errInvVal")%>`);
                txtCost.SetFocus();
                return false;
            }
            ctrlName = '<%=GetLocalResourceObject("lblAccountCodeResource1.Text")%>';
            if (txtAccountCode.GetText() == "") {
                swal(`<%=GetLocalResourceObject("errEmtVal")%>`);
                return false;
            }

            if (!(validateAlphabets(txtAccountCode.GetText()))) {
                swal('<%=GetLocalResourceObject("errNoSpclChars")%>');
                txtAccountCode.SetFocus();
                return false;
            }

            if (!(ValidateSingleQuote(txtAccountCode.GetText()))) {
                swal('<%=GetLocalResourceObject("errInvSglQt")%>');
                return false;
            }
            ctrlName = '<%=GetLocalResourceObject("lblVATResource1.Text")%>';
            if (cmbVAT.GetSelectedIndex() == "0") {
                swal(`<%=GetLocalResourceObject("errSelectCtrl")%>`);
                cmbVAT.SetFocus();
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
        function ValidateSingleQuote(value) {
            var FieldValue;
            var FieldLength;
            var Onechar;

            FieldValue = value;
            FieldLength = FieldValue.length;
            Onechar = FieldValue.charAt(0);

            for (IntCount = 0; IntCount < FieldLength; IntCount++) {
                Onechar = FieldValue.charAt(IntCount);
                if (Onechar == "'") {
                    return false;
                }
            }
            return true;
        }
        function OnPrCodeCustEndCallback(s, e) {
            if (e.command == "UPDATEEDIT") {
                var saveData = s.cpRetValSave;
                var deleteData = s.cpRetValDel;
                //console.log(saveData);
                //console.log(deleteData);
                if (saveData != undefined && saveData != null) {
                    if (saveData.length > 0) {
                        if (saveData.RetVal_Saved != "" || saveData.RetVal_NotSaved == "") {
                            systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                        }
                        else {
                            systemMSG('error', '<%=GetLocalResourceObject("errRecExists")%>', 6000);
                        }
                    }

                }

                if (deleteData != undefined && deleteData != null) {
                    if (deleteData.length > 0) {
                        if (deleteData[0] == "DEL") {
                            systemMSG('success', '<%=GetLocalResourceObject("genRecDel")%>', 6000);
                        }
                        else if (deleteData[0] == "NDEL") {
                            systemMSG('error', '<%=GetLocalResourceObject("errDelFail")%>', 6000);
                        }
                    }
                }

            }

        }

    </script>

    <div class="ui one column grid">
        <div class="stretched row">
            <div class="sixteen wide column">
                <div class="ui top attached tabular menu">
                     <a class="cTab item active" data-tab="tabHP"><%=GetLocalResourceObject("hdrHP")%></a>
                    <a class="cTab item" data-tab="tabHPConf"><%=GetLocalResourceObject("hdrHPConf")%></a>
                </div>
                <div id="systemMessage" class="ui message"></div>
                <div class="ui bottom attached tab segment " data-tab="tabHPConf">
                    <div id="tabHPConf">
                        <div>
                            <asp:HiddenField ID="hdnPageSize" runat="server" />
                            <asp:HiddenField ID="hdnMode" runat="server" />
                            <asp:HiddenField ID="hdnSelect" runat="server" />
                        </div>
                        <%--Price Code for Customer--%>
                        <div class="ui secondary vertical menu" style="width: 50.2%; margin: -0.2rem; background-color: #c9d7f1">
                            <a class="item" id="a13" runat="server"><%=GetLocalResourceObject("hdrPCCust")%></a>
                        </div>
                        <dx:ASPxGridView ID="gvPrCodeCust" ClientInstanceName="gvPrCodeCust" KeyFieldName="ID_SETTINGS" runat="server" Paddings-PaddingBottom="3px" OnBatchUpdate="gvPrCodeCust_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" AutoGenerateColumns="False" meta:resourcekey="gvPrCodeCustResource1">
                            <ClientSideEvents EndCallback="OnPrCodeCustEndCallback" />
                            <SettingsEditing Mode="Batch"></SettingsEditing>
                            <SettingsPager PageSize="15">
                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                            </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="true" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="20%" meta:resourcekey="GridViewCommandColumnResource1"></dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource1">
                                    <PropertiesTextEdit>
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                            <RequiredField IsRequired="True"></RequiredField>
                                            <RegularExpression ValidationExpression="^[a-zA-Z0-9 ÆØÅæøå]+$" ErrorText="Special Characters are not allowed" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <HeaderStyle Font-Bold="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource2"></dx:GridViewDataTextColumn>

                            </Columns>

                            <Paddings PaddingBottom="3px"></Paddings>
                        </dx:ASPxGridView>
                        <p></p>
                        <%--Price Code for Repair Package--%>
                        <div class="ui secondary vertical menu" style="width: 50.2%; margin: -0.2rem; background-color: #c9d7f1">
                            <a class="item" id="a14" runat="server"><%=GetLocalResourceObject("hdrPCRepPkg")%></a>
                        </div>
                        <dx:ASPxGridView ID="gvPrCodeRpkg" ClientInstanceName="gvPrCodeRpkg" KeyFieldName="ID_SETTINGS" runat="server" OnBatchUpdate="gvPrCodeRpkg_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" AutoGenerateColumns="False" meta:resourcekey="gvPrCodeRpkgResource1">
                            <ClientSideEvents EndCallback="OnPrCodeCustEndCallback" />
                            <SettingsEditing Mode="Batch"></SettingsEditing>
                            <SettingsPager PageSize="15">
                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                            </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />

                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="true" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="20%" meta:resourcekey="GridViewCommandColumnResource2"></dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource3">
                                    <PropertiesTextEdit>
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                            <RequiredField IsRequired="True"></RequiredField>
                                            <RegularExpression ValidationExpression="^[a-zA-Z0-9 ÆØÅæøå]+$" ErrorText="Special Characters are not allowed" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <HeaderStyle Font-Bold="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource4"></dx:GridViewDataTextColumn>

                            </Columns>
                        </dx:ASPxGridView>
                        <p></p>
                        <%--Price Code on Job--%>
                        <div class="ui secondary vertical menu" style="width: 50.2%; margin: -0.2rem; background-color: #c9d7f1">
                            <a class="item" id="a15" runat="server"><%=GetLocalResourceObject("hdrPCJob")%></a>
                        </div>
                        <dx:ASPxGridView ID="gvPrCodeJob" ClientInstanceName="gvPrCodeJob" KeyFieldName="ID_SETTINGS" runat="server" OnBatchUpdate="gvPrCodeJob_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" AutoGenerateColumns="False" meta:resourcekey="gvPrCodeJobResource1">
                            <ClientSideEvents EndCallback="OnPrCodeCustEndCallback" />
                            <SettingsEditing Mode="Batch"></SettingsEditing>
                            <SettingsPager PageSize="15">
                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                            </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />

                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="true" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="20%" meta:resourcekey="GridViewCommandColumnResource3"></dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource5">
                                    <PropertiesTextEdit>
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                            <RequiredField IsRequired="True"></RequiredField>
                                            <RegularExpression ValidationExpression="^[a-zA-Z0-9 ÆØÅæøå]+$" ErrorText="Special Characters are not allowed" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <HeaderStyle Font-Bold="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource6"></dx:GridViewDataTextColumn>

                            </Columns>
                        </dx:ASPxGridView>
                        <p></p>
                        <%--Price Code for Mechanic--%>
                        <div class="ui secondary vertical menu" style="width: 50.2%; margin: -0.2rem; background-color: #c9d7f1">
                            <a class="item" id="a16" runat="server"><%=GetLocalResourceObject("hdrPCMec")%></a>
                        </div>
                        <dx:ASPxGridView ID="gvPrCodeMech" ClientInstanceName="gvPrCodeMech" KeyFieldName="ID_SETTINGS" runat="server" Paddings-PaddingBottom="1" OnBatchUpdate="gvPrCodeMech_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" AutoGenerateColumns="False" meta:resourcekey="gvPrCodeMechResource1">
                            <ClientSideEvents EndCallback="OnPrCodeCustEndCallback" />
                            <SettingsEditing Mode="Batch"></SettingsEditing>
                            <SettingsPager PageSize="15">
                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                            </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />

                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="true" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="20%" meta:resourcekey="GridViewCommandColumnResource4"></dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource7">
                                    <PropertiesTextEdit>
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                            <RequiredField IsRequired="True"></RequiredField>
                                            <RegularExpression ValidationExpression="^[a-zA-Z0-9 ÆØÅæøå]+$" ErrorText="Special Characters are not allowed" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <HeaderStyle Font-Bold="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource8"></dx:GridViewDataTextColumn>

                            </Columns>

                            <Paddings PaddingBottom="1px"></Paddings>
                        </dx:ASPxGridView>
                        <p></p>
                        <%--Price Code for Make--%>
                        <div class="ui secondary vertical menu" style="width: 50.2%; margin: -0.2rem; background-color: #c9d7f1">
                            <a class="item" id="a17" runat="server"><%=GetLocalResourceObject("hdrPCMake")%></a>
                        </div>
                        <dx:ASPxGridView ID="gvPrCodeMake" ClientInstanceName="gvPrCodeMake" KeyFieldName="ID_SETTINGS" runat="server" OnBatchUpdate="gvPrCodeMake_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" AutoGenerateColumns="False" meta:resourcekey="gvPrCodeMakeResource1">
                            <ClientSideEvents EndCallback="OnPrCodeCustEndCallback" />
                            <SettingsEditing Mode="Batch"></SettingsEditing>
                            <SettingsPager PageSize="15">
                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                            </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />

                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="true" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="20%" meta:resourcekey="GridViewCommandColumnResource5"></dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource9">
                                    <PropertiesTextEdit>
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                            <RequiredField IsRequired="True"></RequiredField>
                                            <RegularExpression ValidationExpression="^[a-zA-Z0-9 ÆØÅæøå]+$" ErrorText="Special Characters are not allowed" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <HeaderStyle Font-Bold="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource10"></dx:GridViewDataTextColumn>

                            </Columns>
                        </dx:ASPxGridView>
                        <p></p>
                        <%--Price Code for Vehicle Group--%>
                        <div class="ui secondary vertical menu" style="width: 50.2%; margin: -0.2rem; background-color: #c9d7f1">
                            <a class="item" id="a18" runat="server"><%=GetLocalResourceObject("hdrPCVeh")%></a>
                        </div>
                        <dx:ASPxGridView ID="gvPrCodeVehGrp" ClientInstanceName="gvPrCodeVehGrp" KeyFieldName="ID_SETTINGS" runat="server" OnBatchUpdate="gvPrCodeVehGrp_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" AutoGenerateColumns="False" meta:resourcekey="gvPrCodeVehGrpResource1">
                            <ClientSideEvents EndCallback="OnPrCodeCustEndCallback" />
                            <SettingsEditing Mode="Batch"></SettingsEditing>
                            <SettingsPager PageSize="15">
                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                            </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />

                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="true" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="20%" meta:resourcekey="GridViewCommandColumnResource6"></dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource11">
                                    <PropertiesTextEdit>
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                            <RequiredField IsRequired="True"></RequiredField>
                                            <RegularExpression ValidationExpression="^[a-zA-Z0-9 ÆØÅæøå]+$" ErrorText="Special Characters are not allowed" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <HeaderStyle Font-Bold="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource12"></dx:GridViewDataTextColumn>

                            </Columns>
                        </dx:ASPxGridView>
                    </div>
                </div>
                <div class="ui bottom attached tab segment active" data-tab="tabHP">
                    <div id="tabHP">
                        <asp:HiddenField ID="hdnHPMode" runat="server" />
                        <asp:HiddenField ID="hdnHPSeqId" runat="server" />
                        <div id="divHP" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblHP" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrHP")%></h3>
                            <div class="ui form">
                                <div class="inline fields">

                                    <div class="four wide field">
                                        <asp:Label ID="lblDepFrom" runat="server" Text="Department From" meta:resourcekey="lblDepFromResource1"></asp:Label>
                                        <dx:ASPxComboBox ID="cmbDepFrom" ClientInstanceName="cmbDepFrom" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbDepFromResource1"></dx:ASPxComboBox>
                                    </div>

                                    <div class="three wide field">
                                        <asp:Label ID="lblDepTo" runat="server" Text="To" meta:resourcekey="lblDepToResource1"></asp:Label>
                                        <dx:ASPxComboBox ID="cmbDepTo" ClientInstanceName="cmbDepTo" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbDepToResource1"></dx:ASPxComboBox>
                                    </div>

                                    <div class="one wide field">
                                        <input id="btnSearch" class="ui button" type="button" value='<%=GetLocalResourceObject("btnSearch")%>' onclick="SearchDepartment()" />
                                    </div>

                                </div>
                                <p></p>
                                <div class="inline fields" style="text-align: center">
                                    <div class="seven wide field"></div>
                                    <div class="one wide field">
                                        <input id="btnAdd" class="ui button blue" type="button" value='<%=GetLocalResourceObject("btnAdd")%>' onclick="AddHourlyPriceDet()" />
                                    </div>
                                    <div class="one wide field">
                                        <input id="btnDelete" class="ui button negative" type="button" value='<%=GetLocalResourceObject("btnDelete")%>' onclick="DeleteHourlyPrice()" />
                                    </div>
                                    <%--<div class="one wide field">
                                            <input id="btnPrint" class="ui button blue" type="button" value='Print' />
                                        </div>--%>
                                </div>

                            </div>
                            <div class="gridHP" id="gridHP">
                                <dx:ASPxCallbackPanel ID="cbHPGrid" ClientInstanceName="cbHPGrid" runat="server" OnCallback="cbHPGrid_Callback" meta:resourcekey="cbHPGridResource1">
                                    <ClientSideEvents EndCallback="OncbHPGridEndCallback" />
                                    <PanelCollection>
                                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">
                                            <dx:ASPxGridView ID="gvHourlyPrice" ClientInstanceName="gvHourlyPrice" runat="server" KeyFieldName="ID_HP_SEQ" Theme="Office2010Blue" Width="100%" CssClass="gridView" meta:resourcekey="gvHourlyPriceResource1">
                                                <SettingsEditing Mode="Batch"></SettingsEditing>
                                                <ClientSideEvents CustomButtonClick="OnGvHourlyPriceCustomButtonClick" />
                                                <SettingsPager PageSize="15">
                                                    <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                                </SettingsPager>
                                                <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                </SettingsPopup>
                                                <Settings ShowPreview="false" ShowStatusBar="Hidden" />
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" Width="2%" meta:resourcekey="GridViewCommandColumnResource7"></dx:GridViewCommandColumn>
                                                    <dx:GridViewDataTextColumn FieldName="DEPT_HP" Caption="Dept Code" Width="8%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource13">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="MAKE_HP" Caption="Make" Width="5%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource14">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="MECHPCD_HP" Caption="Mec. Price Code" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource15">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CUSTPCD_HP" Caption="Cust Price Code" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource16">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="VEHGRP_HP" Caption="Vehicle Group" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource17">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="JOBPCD_HP" Caption="Price Code Job" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource18">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="INV_LABOR_TEXT" Caption="Lab text" Width="20%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource19">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="HP_PRICE" Caption="Price" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource20">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="HP_COST" Caption="Cost" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource21">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="HP_ACC_CODE" Caption="Account Code" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource22">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="hp_vat" Caption="VAT" Width="5%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource23">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewCommandColumn Width="5%" Caption=" " meta:resourcekey="GridViewCommandColumnResource8">
                                                        <CustomButtons>
                                                            <dx:GridViewCommandColumnCustomButton ID="btnEditHPDet" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource1"></dx:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dx:GridViewCommandColumn>
                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                                <dx:ASPxCallback ID="cbSaveHPDetails" ClientInstanceName="cbSaveHPDetails" ClientSideEvents-EndCallback="OncbSaveHPDetailsEndCallback" OnCallback="cbSaveHPDetails_Callback" runat="server"></dx:ASPxCallback>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div>
        <dx:ASPxPopupControl runat="server" ID="popupHourlyPrice" ClientInstanceName="popupHourlyPrice" PopupHorizontalAlign="Center" Modal="True" PopupVerticalAlign="Middle" Top="170" Left="350" Width="1000px" Height="550px" ScrollBars="Vertical" CloseAction="CloseButton" Theme="Office365" HeaderText="Hourly Price Details" meta:resourcekey="popupHourlyPriceResource1">

            <ContentCollection>
                <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource1">
                    <dx:ASPxCallbackPanel ID="cbHPDetails" ClientInstanceName="cbHPDetails" runat="server" OnCallback="cbHPDetails_Callback" meta:resourcekey="cbHPDetailsResource1">
                        <%--<ClientSideEvents EndCallback="OncbHPGridEndCallback" />--%>
                        <PanelCollection>
                            <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource2">
                                <div class="sixteen wide column">
                                    <div>
                                        <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                                            <a id="A12" runat="server" class="active item">Hourly Price</a>
                                        </div>
                                        <div class="ui form">
                                            <div class="inline fields">
                                                <div class="seven wide column">
                                                    <div class="ui form">

                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblDepartmentCode" runat="server" Text="Department Code" meta:resourcekey="lblDepartmentCodeResource1"></asp:Label>
                                                                <span class="mand">*</span>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxComboBox ID="cmbDepartmentCode" ClientInstanceName="cmbDepartmentCode" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbDepartmentCodeResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>

                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblCatg" runat="server" Text="Make Price Code" meta:resourcekey="lblCatgResource1"></asp:Label>

                                                            </div>
                                                            <div class="eight wide field">

                                                                <dx:ASPxComboBox ID="cmbMake" ClientInstanceName="cmbMake" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbMakeResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>
                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblMechanicPriceCode" runat="server" Text="Mechanic Price Code" meta:resourcekey="lblMechanicPriceCodeResource1"></asp:Label>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxComboBox ID="cmbMechanicPriceCode" ClientInstanceName="cmbMechanicPriceCode" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbMechanicPriceCodeResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>
                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblRPPriceCode" runat="server" Text="Repair Package Price Code" meta:resourcekey="lblRPPriceCodeResource1"></asp:Label>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxComboBox ID="cmbRPPriceCode" ClientInstanceName="cmbRPPriceCode" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbRPPriceCodeResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>
                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblCustomerPriceCode" runat="server" Text="Customer Price Code " meta:resourcekey="lblCustomerPriceCodeResource1"></asp:Label>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxComboBox ID="cmbCustomerPriceCode" ClientInstanceName="cmbCustomerPriceCode" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbCustomerPriceCodeResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>
                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblVehicleGroup" runat="server" Text="Vehicle Group" meta:resourcekey="lblVehicleGroupResource1"></asp:Label>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxComboBox ID="cmbVehicleGroup" ClientInstanceName="cmbVehicleGroup" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbVehicleGroupResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="seven wide column">
                                                    <div class="ui form">

                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblPriceCodeOnJob" runat="server" Text="Price Code On Job" meta:resourcekey="lblPriceCodeOnJobResource1"></asp:Label>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxComboBox ID="cmbPriceCodeOnJob" ClientInstanceName="cmbPriceCodeOnJob" runat="server" CssClass="customComboBox" Theme="Metropolis" Width="280px" meta:resourcekey="cmbPriceCodeOnJobResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>

                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblTextforLabour" runat="server" Text="Text for Labour" meta:resourcekey="lblTextforLabourResource1"></asp:Label>

                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxTextBox ID="txtTextforLabour" ClientInstanceName="txtTextforLabour" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtTextforLabourResource1"></dx:ASPxTextBox>
                                                            </div>
                                                        </div>

                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblPrice" runat="server" Text="Price" meta:resourcekey="lblPriceResource1"></asp:Label>
                                                                <span class="mand">*</span>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxTextBox ID="txtPrice" ClientInstanceName="txtPrice" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtPriceResource1"></dx:ASPxTextBox>
                                                            </div>
                                                        </div>

                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblCost" runat="server" Text="Cost" meta:resourcekey="lblCostResource1"></asp:Label>
                                                                <span class="mand">*</span>
                                                            </div>
                                                            <div class="four wide field">
                                                                <dx:ASPxTextBox ID="txtCost" ClientInstanceName="txtCost" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtCostResource1"></dx:ASPxTextBox>

                                                            </div>
                                                            <div class="six wide field">
                                                                <dx:ASPxCheckBox ID="chkMechnaicCode" ClientInstanceName="chkMechnaicCode" runat="server" Text="Calculate from Mec.details" Theme="Metropolis" ClientSideEvents-ValueChanged="OnchkMechnaicCodeValueChanged" meta:resourcekey="chkMechnaicCodeResource1">
                                                                    <ClientSideEvents ValueChanged="OnchkMechnaicCodeValueChanged"></ClientSideEvents>
                                                                </dx:ASPxCheckBox>
                                                            </div>
                                                        </div>
                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblAccountCode" runat="server" Text="Account Code" meta:resourcekey="lblAccountCodeResource1"></asp:Label>
                                                                <span class="mand">*</span>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxTextBox ID="txtAccountCode" ClientInstanceName="txtAccountCode" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtAccountCodeResource1"></dx:ASPxTextBox>
                                                            </div>
                                                        </div>
                                                        <div class="inline fields">
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblVAT" runat="server" Text="VAT" meta:resourcekey="lblVATResource1"></asp:Label>
                                                                <span class="mand">*</span>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <dx:ASPxComboBox ID="cmbVAT" ClientInstanceName="cmbVAT" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cmbVATResource1"></dx:ASPxComboBox>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                    <p></p>
                    <div style="text-align: center">
                        <input id="btnSave" class="ui button positive" value='<%=GetLocalResourceObject("btnSave")%>' type="button" onclick="OnSaveBtnClick()" />
                        &nbsp;<input id="btnCancel" class="ui button red" value='<%=GetLocalResourceObject("btnCancel")%>' type="button" onclick="popupHourlyPrice.Hide();" />
                    </div>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </div>

</asp:Content>