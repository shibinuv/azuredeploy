<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmCfExportTemplate.aspx.vb" Inherits="CARS.frmCfExportTemplate" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style type="text/css">
        .gridView .dxgvDataRow_Office2010Blue {
            height: 25px;
            font-size: small;
        }

        .customComboBox {
            height: 10% !important;
            border-color: #dbdbdb;
            border-radius: 6px;
        }

        .statusBar a:first-child {
            display: none;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            //alert(GetMultiMessage('0012', GetMultiMessage('', '', ''), ''));
            $('.menu .item')
                .tab()
                ; //activate the tabs

            setTab('first');

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
                $('#<%=hdnCurrTabId.ClientID%>').val(tabID)
            }

            $('.cTab').on('click', function (e) {
                setTab($(this));
                lblErrorMsg.SetText("");
            });

            $('#btnAddCustExport').click(function () {
                txtExportTypeName.SetText("");
                txtDesc.SetText("");
                rbFixed.SetChecked(false);
                rbDelimiter.SetChecked(false);
                txtDesc.SetText("");
                //ddlSpDelimiter.AddItem("Select", 0);
                ddlSpDelimiter.SetSelectedIndex(0);
                ddlDate.SetSelectedIndex(0);
                ddlTime.SetSelectedIndex(0);
                ddlThousDelimiter.SetSelectedIndex(0);
                ddlDecDelimiter.SetSelectedIndex(0);
                txtOtherDelimiter.SetEnabled(false);
                var fileType = "EXPORT";
                var fileName = "CustomerExport.aspx";
                $(document.getElementById('<%=hdnTemplateId.ClientID%>')).val("0");
                $(document.getElementById('<%=hdnMode.ClientID%>')).val("ADD");
                <%--$('#<%=ddlSpDelimiter.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");--%>
                cbExportConfigGrid.PerformCallback(0 + ";" + fileType + ";" + fileName);
                popupExportConfig.SetHeaderText('<%=GetLocalResourceObject("hdrCustExp")%>');
                popupExportConfig.Show();
            });

           $('#btnAddInvJournalExport').click(function () {
                txtExportTypeName.SetText("");
                txtDesc.SetText("");
                rbFixed.SetChecked(false);
                rbDelimiter.SetChecked(false);
                txtDesc.SetText("");
                ddlSpDelimiter.SetSelectedIndex(0);
                txtOtherDelimiter.SetEnabled(false);
                var fileType = "EXPORT";
                var fileName = "InvoiceJournalExport.aspx";
                $(document.getElementById('<%=hdnTemplateId.ClientID%>')).val("0");
                $(document.getElementById('<%=hdnMode.ClientID%>')).val("ADD");
                cbExportConfigGrid.PerformCallback(0 + ";" + fileType + ";" + fileName);
                popupExportConfig.SetHeaderText('<%=GetLocalResourceObject("hdrInvJnlExpo")%>');
                popupExportConfig.Show();
            });
            $('#btnDeleteCustExport').click(function () {
                var fileType = "EXPORT";
                var fileName = "CustomerExport.aspx";
                var selectedList = gvCustExport.GetSelectedKeysOnPage();
                console.log(selectedList);
                var resultmsg = "";
                if (selectedList.length > 0) {
                    swal({
                        title: '<%=GetLocalResourceObject("genDelText")%>',
                        text: '<%=GetLocalResourceObject("genDelTextConf")%>',
                        icon: "warning",
                        buttons: ['<%=GetLocalResourceObject("btnCancelResource1.Text")%>', '<%=GetLocalResourceObject("btnOkResource1.Text")%>'],

                    })
                        .then((willDelete) => {
                            if (willDelete) {
                                var ids = "";
                                for (var i = 0; i < selectedList.length; i++) {
                                    ids += selectedList[i] + " ";
                                    templateId = selectedList[i];
                                    cbCustExportGrid.PerformCallback("DEL;" + templateId);
                                }
                                console.log(resultmsg);
                                //swal(id + "deleted");
                            }
                            else {
                                return false;
                            }

                        });
                }
                else {
                    swal('<%=GetLocalResourceObject("genSelectDelItem")%>'); 
                }

            });

            $('#btnDeleteInvJournalExport').click(function () {
                var fileType = "EXPORT";
                var fileName = "InvoiceJournalExport.aspx";
                var selectedList = gvInvJournalExport.GetSelectedKeysOnPage();
                console.log(selectedList);
                var resultmsg = "";
                if (selectedList.length > 0) {
                    swal({
                        title: '<%=GetLocalResourceObject("genDelText")%>',
                        text: '<%=GetLocalResourceObject("genDelTextConf")%>',
                        icon: "warning",
                        buttons: ['<%=GetLocalResourceObject("btnCancelResource1.Text")%>', '<%=GetLocalResourceObject("btnOkResource1.Text")%>'],

                    })
                        .then((willDelete) => {
                            if (willDelete) {
                                var ids = "";
                                for (var i = 0; i < selectedList.length; i++) {
                                    ids += selectedList[i] + " ";
                                    templateId = selectedList[i];
                                    cbInvJournalExportGrid.PerformCallback("DEL;" + templateId);
                                }
                                console.log(resultmsg);
                                //swal(id + "deleted");
                            }
                            else {
                                return false;
                            }

                        });
                }
                else {
                    swal('<%=GetLocalResourceObject("genSelectDelItem")%>'); 
                }

            });

        });//End of ready 

        function OnEditButtonClick(s, e) {
            if (e.buttonID == 'btnEditCustExp') {
                var index = gvCustExport.GetFocusedRowIndex();
                var templateId = gvCustExport.batchEditApi.GetCellValue(index, "TEMPLATE_ID");
                $(document.getElementById('<%=hdnTemplateId.ClientID%>')).val(templateId);
                $(document.getElementById('<%=hdnMode.ClientID%>')).val("EDIT");
                var fileType = "EXPORT";
                var fileName = "CustomerExport.aspx";
                loadAllControls(fileType, fileName, templateId);
                cbExportConfigGrid.PerformCallback(templateId + ";" + fileType + ";" + fileName);
                popupExportConfig.SetHeaderText('<%=GetLocalResourceObject("hdrCustExp")%>');
                popupExportConfig.Show();

            }
            else if (e.buttonID == 'btnEditInvJnlExp') {
                var index = gvInvJournalExport.GetFocusedRowIndex();
                var templateId = gvInvJournalExport.batchEditApi.GetCellValue(index, "TEMPLATE_ID");
                $(document.getElementById('<%=hdnTemplateId.ClientID%>')).val(templateId);
                $(document.getElementById('<%=hdnMode.ClientID%>')).val("EDIT");
                var fileType = "EXPORT";
                var fileName = "InvoiceJournalExport.aspx";
                loadAllControls(fileType, fileName, templateId);
                cbExportConfigGrid.PerformCallback(templateId + ";" + fileType + ";" + fileName);
                popupExportConfig.SetHeaderText('<%=GetLocalResourceObject("hdrInvJnlExpo")%>');
                popupExportConfig.Show();

            }
        }
        function loadAllControls(fileType, fileName, templateId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfExportTemplate.aspx/loadControls",
                data: "{'fileType':'" + fileType + "','fileName':'" + fileName + "','templateId':'" + templateId + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (data) {
                    data = data.d;
                    var fileMode;
                    console.log(data[0]);
                    txtExportTypeName.SetText(data[0].TemplateName);
                    txtDesc.SetText(data[0].Description);
                    txtOtherDelimiter.SetText(data[0].DelimiterOther);
                    ddlCharSet.SetValue(data[0].CharacterSet);
                    ddlDecDelimiter.ClearItems();
                    ddlThousDelimiter.ClearItems();
                    ddlDate.ClearItems();
                    ddlTime.ClearItems();

                    var decDelim = data[0].DecimalDelimiter;
                    ddlDecDelimiter.AddItem(decDelim, decDelim);
                    ddlThousDelimiter.AddItem(data[0].ThousandsDelimiter, data[0].ThousandsDelimiter);
                    ddlDate.AddItem(data[0].DateFormat, data[0].DateFormat);
                    ddlTime.AddItem(data[0].TimeFormat, data[0].TimeFormat);

                    ddlDecDelimiter.SetValue(decDelim);
                    ddlThousDelimiter.SetValue(data[0].ThousandsDelimiter);
                    ddlDate.SetValue(data[0].DateFormat);
                    ddlTime.SetValue(data[0].TimeFormat);


                    fileMode = data[0].FileMode;

                    if (fileMode == "FIXED") {
                        rbFixed.SetChecked(true);
                        ddlSpDelimiter.SetEnabled(false);
                    }
                    else {
                        rbDelimiter.SetChecked(true);
                        ddlSpDelimiter.SetEnabled(true);
                    }
                    
                    ddlSpDelimiter.SetValue(data[0].SpecialDelimiter);

                    if (ddlSpDelimiter.GetValue() == "Others") {
                        txtOtherDelimiter.SetEnabled(true);
                    }
                    else {
                        txtOtherDelimiter.SetEnabled(false);
                    }
                }
            });
        }
        function OnddlCharSetValueChanged(s, e) {
            var CharSet = ddlCharSet.GetValue();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfExportTemplate.aspx/loadCharSetControls",
                data: "{'CharSet':'" + CharSet + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (data) {
                    data = data.d;
                    var decDelim = data[0].DecimalDelimiter;
                    console.log(data[0]);

                    ddlDecDelimiter.ClearItems();
                    ddlThousDelimiter.ClearItems();
                    ddlDate.ClearItems();
                    ddlTime.ClearItems();

                    ddlDecDelimiter.AddItem(decDelim, decDelim);
                    ddlThousDelimiter.AddItem(data[0].ThousandsDelimiter, data[0].ThousandsDelimiter);
                    ddlDate.AddItem(data[0].DateFormat, data[0].DateFormat);
                    ddlTime.AddItem(data[0].TimeFormat, data[0].TimeFormat);

                    ddlDecDelimiter.SetValue(decDelim);
                    ddlThousDelimiter.SetValue(data[0].ThousandsDelimiter);
                    ddlDate.SetValue(data[0].DateFormat);
                    ddlTime.SetValue(data[0].TimeFormat);

                    ddlDecDelimiter.SetText(decDelim);
                    ddlThousDelimiter.SetText(data[0].ThousandsDelimiter);
                    ddlDate.SetText(data[0].DateFormat);
                    ddlTime.SetText(data[0].TimeFormat);


                }
            });
        }
        function OnrbFixedCheckedChanged(s, e) {
            gvExportConfig.Refresh();
            if (rbFixed.GetChecked()) {
                ddlSpDelimiter.SetEnabled(false);
            }
        }
        function OnrbDelimiterCheckedChanged(s, e) {
            gvExportConfig.Refresh();
            if (rbDelimiter.GetChecked()) {
                ddlSpDelimiter.SetEnabled(true);
            }
        }
        function OnddlSpDelimiterValueChanged(s, e) {
            var delim = ddlSpDelimiter.GetValue();

            if (delim == "Others") {
                txtOtherDelimiter.SetEnabled(true);
            }
            else {
                txtOtherDelimiter.SetEnabled(false);
            }
        }
        function OnCancelBtnClick(s, e) {
            if (gvExportConfig.batchEditApi.HasChanges()) {
                gvExportConfig.CancelEdit();
            }
            lblErrorMsg.SetText("");
            cbCustExportGrid.PerformCallback("FETCH");
            cbInvJournalExportGrid.PerformCallback("FETCH");
            txtExportTypeName.SetText("");
            txtDesc.SetText("");
            rbFixed.SetChecked(false);
            rbDelimiter.SetChecked(false);
            txtDesc.SetText("");
            popupExportConfig.Hide();
        }
        function OnSaveBtnClick(s, e) {
            if (!DoValidate()) {
                return false;
            }
            if (gvExportConfig.batchEditApi.HasChanges()) {
                gvExportConfig.UpdateEdit();
            }
            else {
                cbSaveExportConfig.PerformCallback();
            }
            popupExportConfig.Hide();
        }
        function OncbSaveExportConfigEndCallback(s, e) {
            console.log(s.cpReturnString);
            if (s.cpReturnString != null && s.cpReturnString != "") {
                lblErrorMsg.SetText('<%=GetLocalResourceObject("genSavedSuccess")%>');
            }
        }
        function OngvExportConfigEndCallback(s, e) {
            if (s.cpReturnString != null && s.cpReturnString != "") {
                lblErrorMsg.SetText('<%=GetLocalResourceObject("genSavedSuccess")%>');
            }
        }
        function OnpopupExportConfigClosing(s, e) {
            if (gvExportConfig.batchEditApi.HasChanges()) {
                gvExportConfig.CancelEdit();
            }
            cbCustExportGrid.PerformCallback("FETCH");
            cbInvJournalExportGrid.PerformCallback("FETCH");
        }
        function OncbCustExportGridEndCallback(s, e) {
            if (cbCustExportGrid.cpDelStrVal != undefined) {
                if (cbCustExportGrid.cpDelStrVal != "") {
                    //lblErrorMsg.SetText(cbCustExportGrid.cpDelStrVal);
                    lblErrorMsg.SetText('<%=GetLocalResourceObject("genDelSuccess")%>');
                }
            }
        }
        function OncbInvJournalExportGridEndCallback(s, e) {
            if (cbInvJournalExportGrid.cpDelStrVal != undefined) {
                if (cbInvJournalExportGrid.cpDelStrVal != "") {
                    lblErrorMsg.SetText('<%=GetLocalResourceObject("genDelSuccess")%>');
                }
            }
        }
        function DoValidate() {
            if (txtExportTypeName.GetText() == "") {
                swal('<%=GetLocalResourceObject("errEmptyExpType")%>');
                txtExportTypeName.SetFocus();
                return false;
            }
            if (!rbDelimiter.GetChecked() && !rbFixed.GetChecked()) {
                swal('<%=GetLocalResourceObject("errSelFileType")%>');
                rbDelimiter.SetFocus();
                return false;
            }
            if (txtOtherDelimiter.GetText() == "" && ddlSpDelimiter.GetValue() == "Others") {
                swal('<%=GetLocalResourceObject("errSelOthDel")%>');
                rbDelimiter.SetFocus();
                return false;
            }
            var templateName = "";
            var templateId = "";
            if ($('#<%=hdnCurrTabId.ClientID%>').val() == "first") {
                for (var i = 0; i < gvCustExport.GetVisibleRowsOnPage(); i++) {
                    templateName = gvCustExport.batchEditApi.GetCellValue(i, "TEMPLATE_NAME");
                    templateId = gvCustExport.batchEditApi.GetCellValue(i, "TEMPLATE_ID");
                    console.log(templateName);
                    if (templateId != $(document.getElementById('<%=hdnTemplateId.ClientID%>')).val()) {
                        if (txtExportTypeName.GetText() == templateName) {
                            swal('<%=GetLocalResourceObject("errDupExpName")%>');
                                return false;
                            }
                    }
                    
                }
            }
            else if ($('#<%=hdnCurrTabId.ClientID%>').val() == "second") {
                for (var i = 0; i < gvInvJournalExport.GetVisibleRowsOnPage(); i++) {
                    templateName = gvInvJournalExport.batchEditApi.GetCellValue(i, "TEMPLATE_NAME");
                    templateId = gvInvJournalExport.batchEditApi.GetCellValue(i, "TEMPLATE_ID");
                    console.log(templateId +"->" + $(document.getElementById('<%=hdnTemplateId.ClientID%>')).val());
                    if (templateId != $(document.getElementById('<%=hdnTemplateId.ClientID%>')).val()) {
                        if (txtExportTypeName.GetText() == templateName) {
                            swal('<%=GetLocalResourceObject("errDupExpName")%>');
                            return false;
                        }
                    }
                }
            }

            return true;
        }
    </script>

    <asp:HiddenField ID="hdnCurrTabId" runat="server" />
    <asp:HiddenField ID="hdnMode" runat="server" />
    <asp:HiddenField ID="hdnTemplateId" runat="server" />

    <div class="ui one column grid">
        <div class="stretched row">
            <div class="sixteen wide column">
                <div class="ui top attached tabular menu">
                    <a class="cTab item active" data-tab="first"><%=GetLocalResourceObject("hdrCustExp")%></a>
                    <a class="cTab item" data-tab="second"><%=GetLocalResourceObject("hdrInvJnlExpo")%></a>
                </div>
                <div style="text-align: center">
                    <dx:ASPxLabel ID="lblErrorMsg" ClientInstanceName="lblErrorMsg" runat="server" Font-Size="Small" ForeColor="Green" meta:resourcekey="lblErrorMsgResource1"></dx:ASPxLabel>
                </div>
                <%--########################################## CustomerExport ##########################################--%>
                <div class="ui bottom attached tab segment active" data-tab="first">
                    <div id="tabCustExport">
                        <div>
                            <div id="divCustExport" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="lblCustExportHdr" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrCustExp")%></h3>

                                <div class="sixteen wide column">
                                    <dx:ASPxCallbackPanel ID="cbCustExportGrid" ClientInstanceName="cbCustExportGrid" OnCallback="cbCustExportGrid_Callback" runat="server" meta:resourcekey="cbCustExportGridResource1">
                                        <ClientSideEvents EndCallback="OncbCustExportGridEndCallback" />
                                        <PanelCollection>
                                            <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">
                                                <dx:ASPxGridView ID="gvCustExport" Width="100%" ClientInstanceName="gvCustExport" KeyFieldName="TEMPLATE_ID" runat="server" CssClass="gridView" Theme="Office2010Blue" Settings-ShowPreview="false" Settings-ShowStatusBar="Hidden" Style="-moz-border-radius: 10px; border-radius: 10px;" meta:resourcekey="gvCustExportResource1">
                                                    <SettingsEditing Mode="Batch"></SettingsEditing>
                                                    <ClientSideEvents CustomButtonClick="OnEditButtonClick" />
                                                    <SettingsPopup>
                                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                    </SettingsPopup>

                                                    <Settings ShowStatusBar="Hidden"></Settings>

                                                    <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                    <SettingsSearchPanel Visible="True" />
                                                    <Styles>
                                                        <FocusedRow BackColor="#d6eef2" ForeColor="Black">
                                                        </FocusedRow>
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" meta:resourcekey="GridViewCommandColumnResource1" />
                                                        <dx:GridViewDataTextColumn Caption="TEMPLATE" FieldName="TEMPLATE_ID" VisibleIndex="1" Width="10%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource1">
                                                            <HeaderStyle Font-Bold="True" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="EXPORT TYPE NAME" FieldName="TEMPLATE_NAME" VisibleIndex="2" Width="30%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource2">
                                                            <HeaderStyle Font-Bold="True" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="DESCRIPTION" VisibleIndex="3" Caption="DESCRIPTION" Width="50%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource3">
                                                            <HeaderStyle Font-Bold="True" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewCommandColumn VisibleIndex="4" Width="10%" Caption=" " meta:resourcekey="GridViewCommandColumnResource2">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton ID="btnEditCustExp" Styles-Style-CssClass="" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource1"></dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                    <SettingsPager PageSize="10">
                                                        <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                                    </SettingsPager>
                                                </dx:ASPxGridView>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>

                                </div>
                            </div>
                            <p></p>
                            <div class="six fields">
                                <div style="text-align: center">
                                    <input id="btnAddCustExport"  class="ui button blue" type="button" value='<%=GetLocalResourceObject("btnAddResource1.Text")%>' />
                                    <%--<asp:Button ID="btnAddCustExport" runat="server" Text="Add" class="ui button blue" meta:resourcekey="btnAddResource1" UseSubmitBehavior="false"/>--%>
                                    <input id="btnDeleteCustExport" class="ui button red" type="button" value='<%=GetLocalResourceObject("btnDelResource1.Text")%>'/>
                                    <%--<asp:Button ID="btnDeleteCustExport" class="ui button red" runat="server" Text="Delete" meta:resourcekey="btnDelResource1"/>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--########################################## InvoiceJournalExport##########################################--%>
                <div class="ui bottom attached tab segment" data-tab="second">
                    <div id="tabInvJournalExport">
                        <div id="divInvJournalExport" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblInvJournalExportHdr" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrInvJnlExpo")%></h3>


                            <div class="sixteen wide column">
                                <dx:ASPxCallbackPanel ID="cbInvJournalExportGrid" ClientInstanceName="cbInvJournalExportGrid" OnCallback="cbInvJournalExportGrid_Callback" runat="server" meta:resourcekey="cbInvJournalExportGridResource1">
                                    <ClientSideEvents EndCallback="OncbInvJournalExportGridEndCallback" />
                                    <PanelCollection>
                                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource2">
                                            <dx:ASPxGridView ID="gvInvJournalExport" Width="100%" ClientInstanceName="gvInvJournalExport" KeyFieldName="TEMPLATE_ID" runat="server" CssClass="gridView" Theme="Office2010Blue" Settings-ShowPreview="false" Settings-ShowStatusBar="Hidden" Style="-moz-border-radius: 10px; border-radius: 10px;" meta:resourcekey="gvInvJournalExportResource1">
                                                <SettingsEditing Mode="Batch"></SettingsEditing>
                                                <ClientSideEvents CustomButtonClick="OnEditButtonClick" />
                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                </SettingsPopup>

                                                <Settings ShowStatusBar="Hidden"></Settings>

                                                <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                <SettingsSearchPanel Visible="True" />
                                                <Styles>
                                                    <FocusedRow BackColor="#d6eef2" ForeColor="Black">
                                                    </FocusedRow>
                                                </Styles>
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" meta:resourcekey="GridViewCommandColumnResource3" />
                                                    <dx:GridViewDataTextColumn FieldName="TEMPLATE_ID" Caption="TEMPLATE_ID" VisibleIndex="1" Width="10%" meta:resourcekey="GridViewDataTextColumnResource4">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="TEMPLATE_NAME" Caption="TEMPLATE_NAME" VisibleIndex="2" Width="30%" meta:resourcekey="GridViewDataTextColumnResource5">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="DESCRIPTION" VisibleIndex="3" Caption="DESCRIPTION" Width="50%" meta:resourcekey="GridViewDataTextColumnResource6">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewCommandColumn VisibleIndex="4" Width="10%" Caption=" " meta:resourcekey="GridViewCommandColumnResource4">
                                                        <CustomButtons>
                                                            <dx:GridViewCommandColumnCustomButton ID="btnEditInvJnlExp" Styles-Style-CssClass="" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource2"></dx:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dx:GridViewCommandColumn>
                                                </Columns>
                                                <SettingsPager PageSize="10">
                                                    <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                                </SettingsPager>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                            </div>
                            <p></p>
                            <div class="six fields">
                                <div style="text-align: center">
                                    <input id="btnAddInvJournalExport" class="ui button blue" value='<%=GetLocalResourceObject("btnAddResource1.Text")%>' type="button" />
                                    <%--<asp:Button ID="btnAddInvJournalExport" runat="server" Text="Add" class="ui button blue" meta:resourcekey="btnAddResource1" />
                                    <asp:Button ID="btnDeleteInvJournalExport" runat="server" Text="Delete" class="ui button red" meta:resourcekey="btnDelResource1"/>--%>
                                    <input id="btnDeleteInvJournalExport" class="ui button red" value='<%=GetLocalResourceObject("btnDelResource1.Text")%>' type="button" />
                                </div>
                            </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <dx:ASPxPopupControl ID="popupExportConfig" runat="server" ClientInstanceName="popupExportConfig" PopupHorizontalAlign="Center" Modal="True" PopupVerticalAlign="Middle" Top="100" Left="350" Width="1100px" Height="700px" ScrollBars="Vertical" CloseAction="CloseButton" Theme="Office365" meta:resourcekey="popupExportConfigResource1" >
            <ClientSideEvents Closing="OnpopupExportConfigClosing" />
            <ContentCollection>
                <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource1">

                    <div class="sixteen wide column">
                        <div>
                            <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                                <a id="A3" runat="server" class="active item"><%=GetLocalResourceObject("hdrMainInfo")%></a>
                            </div>
                            <div class="ui form">
                                <div class="inline fields">
                                    <%--<div class="one wide column"></div>--%>
                                    <div class="seven wide column">
                                        <div class="ui form">

                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblExportType" runat="server" Text="Export Type" meta:resourcekey="lblExportTypeResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">
                                                    <dx:ASPxTextBox ID="txtExportTypeName" ClientInstanceName="txtExportTypeName" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtExportTypeNameResource1"></dx:ASPxTextBox>
                                                </div>

                                            </div>

                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblDate" runat="server" Text="Date Format" meta:resourcekey="lblDateResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">
                                                    <dx:ASPxComboBox ID="ddlDate" ClientInstanceName="ddlDate" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="240px" meta:resourcekey="ddlDateResource1">
                                                    </dx:ASPxComboBox>
                                                </div>
                                            </div>
                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblTime" runat="server" Text="Time Format" meta:resourcekey="lblTimeResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">
                                                    <dx:ASPxComboBox ID="ddlTime" ClientInstanceName="ddlTime" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="240px" meta:resourcekey="ddlTimeResource1">
                                                    </dx:ASPxComboBox>
                                                </div>
                                            </div>
                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblFile" runat="server" Text="File" meta:resourcekey="lblFileResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">
                                                    <dx:ASPxRadioButton ID="rbFixed" runat="server" ClientInstanceName="rbFixed" GroupName="rbFile" Text="Fixed Length" Font-Size="Small" Theme="Office2010Blue" meta:resourcekey="rbFixedResource1">
                                                        <ClientSideEvents CheckedChanged="OnrbFixedCheckedChanged" />
                                                    </dx:ASPxRadioButton>
                                                    <dx:ASPxRadioButton ID="rbDelimiter" ClientInstanceName="rbDelimiter" runat="server" GroupName="rbFile" Text="Delimeter" Font-Size="Small" Theme="Office2010Blue" meta:resourcekey="rbDelimiterResource1">
                                                        <ClientSideEvents CheckedChanged="OnrbDelimiterCheckedChanged" />
                                                    </dx:ASPxRadioButton>
                                                </div>

                                            </div>


                                        </div>
                                    </div>

                                    <div class="seven wide column">
                                        <div class="ui form">

                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblCharSet" runat="server" Text="Character Set" meta:resourcekey="lblCharSetResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">
                                                    <dx:ASPxComboBox ID="ddlCharSet" ClientInstanceName="ddlCharSet" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="100%" meta:resourcekey="ddlCharSetResource1">
                                                        <ClientSideEvents ValueChanged="OnddlCharSetValueChanged" />
                                                    </dx:ASPxComboBox>
                                                </div>
                                            </div>
                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblDecimal" runat="server" Text="Decimal Delimiter" meta:resourcekey="lblDecimalResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">
                                                    <dx:ASPxComboBox ID="ddlDecDelimiter" ClientInstanceName="ddlDecDelimiter" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="100%" meta:resourcekey="ddlDecDelimiterResource1">
                                                    </dx:ASPxComboBox>
                                                </div>
                                            </div>
                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblThousand" runat="server" Text="Thousands Delimiter" meta:resourcekey="lblThousandResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">
                                                    <dx:ASPxComboBox ID="ddlThousDelimiter" ClientInstanceName="ddlThousDelimiter" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="100%" meta:resourcekey="ddlThousDelimiterResource1">
                                                    </dx:ASPxComboBox>

                                                </div>
                                            </div>


                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblSpDelimeter" runat="server" Text="Delimeter" meta:resourcekey="lblSpDelimeterResource1"></asp:Label>
                                                </div>
                                                <div class="eight wide field">

                                                    <dx:ASPxComboBox ID="ddlSpDelimiter" ClientInstanceName="ddlSpDelimiter" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="100%" meta:resourcekey="ddlSpDelimiterResource1">
                                                        <ClientSideEvents ValueChanged="OnddlSpDelimiterValueChanged" />
                                                        <Items>
                                                            <dx:ListEditItem Value="\t" Text="Tab" meta:resourcekey="ListEditItemResource1"></dx:ListEditItem>
                                                            <dx:ListEditItem Value=";" Text="Semicolon" meta:resourcekey="ListEditItemResource2"></dx:ListEditItem>
                                                            <dx:ListEditItem Value="," Text="Comma" meta:resourcekey="ListEditItemResource3"></dx:ListEditItem>
                                                            <dx:ListEditItem Value=" " Text="Space" meta:resourcekey="ListEditItemResource4"></dx:ListEditItem>
                                                            <dx:ListEditItem Value="Others" Text="Others" meta:resourcekey="ListEditItemResource5"></dx:ListEditItem>
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                    <dx:ASPxTextBox ID="txtOtherDelimiter" ClientInstanceName="txtOtherDelimiter" runat="server" CssClass="customComboBox" meta:resourcekey="txtOtherDelimiterResource1"></dx:ASPxTextBox>
                                                </div>

                                            </div>

                                        </div>
                                    </div>


                                </div>
                            </div>

                            <div class="ui form">
                                <div class="nine wide column">
                                    <div class="inline fields">
                                        <div class="three wide field">
                                            <asp:Label ID="lblDesc" runat="server" Text="Description" meta:resourcekey="lblDescResource1"></asp:Label>
                                        </div>
                                        <div class="nine wide field">
                                            <dx:ASPxTextBox ID="txtDesc" ClientInstanceName="txtDesc" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtDescResource1"></dx:ASPxTextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <dx:ASPxCallbackPanel ID="cbExportConfigGrid" ClientInstanceName="cbExportConfigGrid" OnCallback="cbExportConfigGrid_Callback" runat="server" meta:resourcekey="cbExportConfigGridResource1">
                        <PanelCollection>
                            <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource3">
                                <div class="sixteen wide column">
                                    <div>
                                        <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                                            <a id="A1" runat="server" class="active item"><%=GetLocalResourceObject("hdrFileInfo")%></a>
                                        </div>
                                        <div class="ui form">
                                            <dx:ASPxGridView ID="gvExportConfig" Width="100%" ClientInstanceName="gvExportConfig" KeyFieldName="FIELD_ID" runat="server" OnCellEditorInitialize="gvExportConfig_CellEditorInitialize" OnHtmlDataCellPrepared="gvExportConfig_HtmlDataCellPrepared" OnBatchUpdate="gvExportConfig_BatchUpdate" CssClass="gridView" Theme="Office2010Blue" Settings-ShowPreview="false" Settings-ShowStatusBar="Hidden" meta:resourcekey="gvExportConfigResource1">
                                                <SettingsEditing Mode="Batch"></SettingsEditing>
                                                <ClientSideEvents EndCallback="OngvExportConfigEndCallback" />

                                                <Settings ShowStatusBar="Hidden"></Settings>

                                                <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />

                                                <Styles>
                                                    <FocusedRow BackColor="#d6eef2" ForeColor="Black">
                                                    </FocusedRow>
                                                </Styles>

                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                </SettingsPopup>
                                                <Columns>
                                                    <%--<dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" />--%>
                                                    <dx:GridViewDataTextColumn FieldName="FIELD_ID" Caption="FIELD_ID" VisibleIndex="1" Visible="false" meta:resourcekey="GridViewDataTextColumnResource7">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="FIELD_NAME" Caption="FIELD NAME" VisibleIndex="2" Width="30%" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource8">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="POSITION_FROM" VisibleIndex="3" Caption="POSITION FROM" Width="20%" meta:resourcekey="GridViewDataTextColumnResource9">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[0-9]+$" RegularExpression-ErrorText="Numerics only allowed">
                                                                <RegularExpression ErrorText="Numerics only allowed" ValidationExpression="^[0-9]+$"></RegularExpression>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="FIELD_LENGTH" VisibleIndex="4" Caption="FIELD LENGTH" Width="20%" meta:resourcekey="GridViewDataTextColumnResource10">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[0-9]+$" RegularExpression-ErrorText="Numerics only allowed">
                                                                <RegularExpression ErrorText="Numerics only allowed" ValidationExpression="^[0-9]+$"></RegularExpression>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ORDER_IN_FILE" VisibleIndex="5" Caption="ORDER IN FILE" Width="20%" meta:resourcekey="GridViewDataTextColumnResource11">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[0-9]+$" RegularExpression-ErrorText="Numerics only allowed">
                                                                <RegularExpression ErrorText="Numerics only allowed" ValidationExpression="^[0-9]+$"></RegularExpression>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <%--<dx:GridViewDataTextColumn FieldName="DECIMAL_DIVIDE" VisibleIndex="6" Caption="DECIMAL_DIVIDE" Width="20%">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>--%>
                                                    <dx:GridViewDataTextColumn FieldName="FIXED_VALUE" VisibleIndex="7" Caption="FIXED VALUE" Width="10%" meta:resourcekey="GridViewDataTextColumnResource12">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RegularExpression-ValidationExpression="^[A-Za-z0-9_-]*$" RegularExpression-ErrorText="Numerics only allowed">
                                                                <RegularExpression ErrorText="Numerics only allowed" ValidationExpression="^[A-Za-z0-9_-]*$"></RegularExpression>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ENCLOSING_CHAR" VisibleIndex="8" Caption="ENCLOSING CHARACTER" Width="10%" meta:resourcekey="GridViewDataTextColumnResource13">
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>

                                                </Columns>
                                                <SettingsPager PageSize="10">
                                                    <%--<PageSizeItemSettings Visible="true" ShowAllItem="true" />--%>
                                                </SettingsPager>
                                            </dx:ASPxGridView>
                                        </div>
                                        <p></p>
                                        <div style="text-align: center">
                                            <input id="btnSave" class="ui button positive" value='<%=GetLocalResourceObject("btnSaveResource1.Text")%>' type="button" onclick="OnSaveBtnClick()" />
                                            &nbsp;<input id="btnCancel" class="ui button red" value='<%=GetLocalResourceObject("btnCancelResource1.Text")%>' type="button" onclick="OnCancelBtnClick()" />
                                        </div>
                                    </div>
                                </div>

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                    <dx:ASPxCallback ID="cbSaveExportConfig" ClientInstanceName="cbSaveExportConfig" OnCallback="cbSaveExportConfig_Callback" runat="server">
                        <ClientSideEvents EndCallback="OncbSaveExportConfigEndCallback" />
                    </dx:ASPxCallback>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </div>
</asp:Content>
