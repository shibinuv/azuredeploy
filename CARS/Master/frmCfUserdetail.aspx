<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmCfUserdetail.aspx.vb" Inherits="CARS.frmCfUserdetail" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cntMainPanel"> 
    <style>
        .gridView .dxgvDataRow_Office2010Blue {
            height: 30px;
            font-size: medium;
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
    <script type="text/javascript">
        $(document).ready(function () {
            $('.menu .item')
                .tab()
                ;
            $('#divGrids').hide();
            $('#divPerGrid').hide();
            $(document.getElementById('<%=hdnCommonMechId.ClientID%>')).val("");
            $('.cTab').on('click', function (e) {
                setTab($(this));
            });

            function setTab(cTab) {
                console.log(cTab);
                var tabID = "";
                tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
                var tab;
                (tabID == "") ? tab = cTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab

                console.log(tabID);
                if (tabID == "tabRole") {
                    var selectedList = gvUserDetails.GetSelectedKeysOnPage();
                    if (selectedList.length > 0) {
                        if (selectedList.length == 1) {
                            var idUser = selectedList[0];
                            var idRole = GetRoleId(idUser);
                            if (idRole != "0" && idRole != undefined) {
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
                        else {
                            swal('<%=GetLocalResourceObject("errSelectOnlyOneRec")%>');
                            $('#divGrids').hide();
                            return;
                        }
                    }
                    else {
                        swal('<%=GetLocalResourceObject("errSelectAnyRec")%>');
                        $('#divGrids').hide();
                        return;
                    }
                }
            }
            });

        function setTabExp(tabID, idRole) {
            console.log("aaa " + tabID);

            $('#tabRole').removeClass('active'); //To hide all the available tabs in page . 
            $('#tabUser').removeClass('active');
            //Need to remove class active for new tab if added any . 
            $('#tab' + tabID).addClass('active'); // Shows target tab and sets active class

            $('.cTab').removeClass('active'); // Removes the active class for all 
            $("#btn" + tabID).addClass('active'); // Sets active to clicked or active tab

            if (tabID == "Role") {
                console.log("bbb " + tabID);
                if (idRole != "0" && idRole != undefined) {
                    console.log("ccc " + idRole);
                    $('#divGrids').show();
                    $(document.getElementById('<%=hdnRoleId.ClientID%>')).val(idRole);
                    cbPerGrid.PerformCallback("FETCH;" + idRole);
                    cbPerCtrlGrid.PerformCallback("FETCH;" + idRole);
                    cbChkLayout.PerformCallback(idRole);
                }
            }
        }
        function OnbtnEditUserDetClick(s, e) {
            var idUser = gvUserDetails.GetRowKey(e.visibleIndex);
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Edit");
            cbUserDetailsPopup.PerformCallback("FETCH;" + idUser);
            popupUserDetails.Show();
        }
        function OngvUserDetailsRowDblClick(s, e) {
            var idUser = gvUserDetails.GetRowKey(e.visibleIndex);
            var idRole = GetRoleId(idUser);
            setTabExp('Role', idRole);
        }
        function OncbUserDetailsPopupEndCallback(s, e) {
            if (s.cpIsFetch != null && s.cpIsFetch != undefined) {
                if (s.cpIsFetch) {
                    if (s.cpPassword != null && s.cpCnfPassword != null) {
                        tbPassword.SetText(s.cpPassword);
                        tbConfirm.SetText(s.cpCnfPassword);
                    }
                }
            }

            if (s.cpIsSave != null && s.cpIsSave != undefined) {
                if (s.cpIsSave) {
                    var saveresult = s.cpSaveResult.toString();
                    console.log(saveresult);
                    if (saveresult == 'PUID' || saveresult == 'INSFLG' || saveresult == 'UPDFLG') {
                        systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                    }
                    else if (saveresult == 'UPDERR' || saveresult == 'PLOGINIED' || saveresult == 'CMID' || saveresult == 'PLOGINIED') {
                        systemMSG('error', '<%=GetLocalResourceObject("errRecExists")%>', 6000);
                    }
                    else if (saveresult == 'CMID_N_Dept') {
                        //Need to show pop-up The Common Mechanic Id entered does not exist. Do you want to continue?
                        var r = confirm(GetMultiMessage('CMMID_N_DEPT', '', ''));
                        if (r == true) {
                            <%--$(document.getElementById('<%=hdnCommonMechId.ClientID%>')).val("True");
                                saveUserDetails();
                            }
                            else {
                                $(document.getElementById('<%=hdnCommonMechId.ClientID%>')).val("");--%>
                        }
                    }
                    else if (saveresult == 'CMID_Y_Dept') {
                        //Need to show pop-up The Common Mechanic Id entered already exists in another Department. Do you want to continue?
                        var r = confirm(GetMultiMessage('CMMID_Y_DEPT', '', ''));
                        if (r == true) {
                            <%--$(document.getElementById('<%=hdnCommonMechId.ClientID%>')).val("True");
                                saveUserDetails();
                            }
                            else {
                                $(document.getElementById('<%=hdnCommonMechId.ClientID%>')).val("");--%>
                        }
                    }
                    cbUserDetGrid.PerformCallback();

                    //Newly Added 19-07-2022
                    if (s.cpNewRoleID != "") {
                        var roleId = s.cpNewRoleID.toString();
                        setTabExp('Role', roleId);
                    }
                }
            }
        }
        function resetUserDet() {
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("");
            cbUserDetailsPopup.PerformCallback("RESET");
        }
        function addUserDetails() {
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Add");
            cbUserDetailsPopup.PerformCallback("RESET");
            popupUserDetails.Show();
        }
        function OncmbSubsidiaryChange(s, e) {
            var subId = cmbSubsidiary.GetValue();
            cbUserDetailsPopup.PerformCallback("LOADDEPT;" + subId);
        }
        function OncmbDepartmentChange(s, e) {
            var subId = cmbSubsidiary.GetValue();
            var deptId = cmbDepartment.GetValue();
            cbUserDetailsPopup.PerformCallback("LOADROLE;" + subId + ";" + deptId);
        }
        function OntbZipCodeInit(s, e) {
            console.log(tbZipCode.GetText());
            
            $(tbZipCode.GetInputElement()).autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCfUserdetail.aspx/GetZipCodes",
                        data: "{'zipCode':'" + tbZipCode.GetText() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0] + "-" + item.split('-')[3],
                                    val: item.split('-')[0],
                                    value: item.split('-')[0],
                                    country: item.split('-')[1],
                                    state: item.split('-')[2],
                                    city: item.split('-')[3],
                                }
                            }))
                        },
                        error: function (xhr, status, error) {
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error Response ' + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    tbZipCode.SetText(i.item.val);
                    tbCountry.SetText(i.item.country);
                    tbState.SetText(i.item.state);
                    tbCity.SetText(i.item.city);
                },
            });

        }

        function saveUserDetails() {

            var result = fnClientValidateUser();
            if (result == true) {
                cbUserDetailsPopup.PerformCallback("SAVE");
                popupUserDetails.Hide();
            }
        }

        function delUserDetails() {
            var selectedList = gvUserDetails.GetSelectedKeysOnPage();
            var userId = "";

            var userName = "";
            var userIdxml;
            var userIdxmls = "";
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
                                userId = selectedList[i];
                                userIdxml = "<Master><LOGINID>" + userId + "</LOGINID>" + "<FIRSTNAME>" + userName + "</FIRSTNAME></Master>";
                                userIdxmls += userIdxml;

                                roleId = GetRoleId(userId);
                                roleIdxml = "<ROLE><ID_ROLE>" + roleId + "</ID_ROLE>" + "<NM_ROLE>" + roleName + "</NM_ROLE></ROLE>";
                                roleIdxmls += roleIdxml;
                            }

            if (userIdxmls != "") {
                userIdxmls = "<ROOT>" + userIdxmls + "</ROOT>";
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCfUserdetail.aspx/DeleteUserDetails",
                    data: "{userid: '" + userIdxmls + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                                        console.log(data.d);
                                        if (data.d[0] == "0" || data.d[0] == "DEL") {
                                            systemMSG('success', '<%=GetLocalResourceObject("genRecDel")%>', 6000);
                                            if (roleIdxmls != "") {
                                                roleIdxmls = "<ROOT>" + roleIdxmls + "</ROOT>";
                                                $.ajax({
                                                    type: "POST",
                                                    contentType: "application/json; charset=utf-8",
                                                    url: "frmCfUserdetail.aspx/DeleteRole",
                                                    data: "{roleIdxmls: '" + roleIdxmls + "'}",
                                                    dataType: "json",
                                                    success: function (data) {
                                                        if (data.d[0] == "DEL") {
                                                            systemMSG('success', '<%=GetLocalResourceObject("genRecDel")%>', 6000);
                        }
                                        else if (data.d[0] == "NDEL") {
                                            systemMSG('error', '<%=GetLocalResourceObject("errDelFailed")%>', 6000);
                        }                        
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
                                            }
            }
            else {
                                            systemMSG('error', '<%=GetLocalResourceObject("errDelFailed")%>', 6000);
                                        }
                                        cbUserDetGrid.PerformCallback();
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
        function OnchkMechCheckedChanged(s, e) {
            if (chkMech.GetChecked()) {
                chkMechActive.SetEnabled(true);
                tbCommonMechId.SetEnabled(true);
            }
            else {
                chkMechActive.SetChecked(false);
                chkMechActive.SetEnabled(false);
                tbCommonMechId.SetEnabled(false);
            }
        }
        function fnClientValidateUser() {
            var zipCode = tbZipCode.GetText();
            var ctrlname = '<%=GetLocalResourceObject("lblLoginResource1.Text")%>';

            if (tbLoginName.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errEmptyVal")%>`);
                tbLoginName.Focus();
                return false;
            }
            if (!(gfb_ValidateAlphabetsValue(tbLoginName.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbLoginName.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblUserIdResource1.Text")%>';
            if (tbUserId.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errEmptyVal")%>`);
                tbUserId.Focus();
                return false;
            }
            if (!(gfb_ValidateAlphabetsValue(tbUserId.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbUserId.Focus();
                return false;
            }

            if (!(gfi_ValidateAlphaSpaceValue(tbUserId.GetText()))) {
                swal('<%=GetLocalResourceObject("errInvSpaceUid")%>');
                tbUserId.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblFNameResource1.Text")%>';
            if (tbFName.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errEmptyVal")%>`);
                tbFName.Focus();
                return false;
            }
            if (!(gfb_ValidateAlphabetsValue(tbFName.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbFName.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblLNameResource1.Text")%>';
            if (tbLName.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errEmptyVal")%>`);
                tbLName.Focus();
                return false;
            }
            if (!(gfb_ValidateAlphabetsValue(tbLName.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbLName.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblPasswordResource1.Text")%>';
            if (tbPassword.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errEmptyVal")%>`);
                tbPassword.Focus();
                return false;
            }
            if (!(gfb_ValidateAlphabetsValue(tbPassword.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbPassword.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblConfirmResource1.Text")%>';
            if (tbConfirm.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errEmptyVal")%>`);
                tbConfirm.Focus();
                return false;
            }
            if (!(gfb_ValidateAlphabetsValue(tbConfirm.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbConfirm.Focus();
                return false;
            }

            if (tbConfirm.GetText() != tbPassword.GetText() || tbConfirm.GetText().length != tbPassword.GetText().length) {
                swal('<%=GetLocalResourceObject("errPwNotMatch")%>');
                tbPassword.SetText("");
                tbConfirm.SetText("");
                tbPassword.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblAddrLine1Resource1.Text")%>';
            if (!(gfb_ValidateAlphabetsValue(tbAddrLine1.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbAddrLine1.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblAddrLine2Resource1.Text")%>';
            if (!(gfb_ValidateAlphabetsValue(tbAddrLine2.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                tbAddrLine2.Focus();
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblTelNoPersonResource1.Text")%>';
            if (!(gfi_ValidatePhoneNumberValue(tbTelNoPersonal.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvValue")%>`);
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblMobileNoResource1.Text")%>';
            if (!(gfi_ValidatePhoneNumberValue(tbMobile.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvValue")%>`);
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblFaxResource1.Text")%>';
            if (!(gfi_ValidatePhoneNumberValue(tbFaxNo.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvValue")%>`);
                return false;
            }
            ctrlname = '<%=GetLocalResourceObject("lblEmailResource1.Text")%>';
            if (!(gfi_ValidateEmailValue(tbEmail.GetText()))) {
                swal(`<%=GetLocalResourceObject("errInvValue")%>`);
                tbEmail.Focus();
                return false;
            }

            if (zipCode != "") {
                ctrlname = '<%=GetLocalResourceObject("lblCityResource1.Text")%>';
                if (!(gfb_ValidateAlphabetsValue(tbCity.GetText()))) {
                    swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                    tbCity.Focus();
                    return false;
                }
                ctrlname = '<%=GetLocalResourceObject("lblCountryResource1.Text")%>';
                if (!(gfb_ValidateAlphabetsValue(tbCountry.GetText()))) {
                    swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                    tbCountry.Focus();
                    return false;
                }
                ctrlname = '<%=GetLocalResourceObject("lblStateResource1.Text")%>';
                if (!(gfb_ValidateAlphabetsValue(tbState.GetText()))) {
                    swal(`<%=GetLocalResourceObject("errInvSpecialChar")%>`);
                    tbState.Focus();
                    return false;
                }
            }
            return true;
        }
        //Roles page
        function SaveRole() {
            var result = fnClientValidate();
            if (result == true) {
                var roleId = document.getElementById('<%=hdnRoleId.ClientID%>').value;
                $.ajax({
                    type: "POST",
                    url: "frmCfUserdetail.aspx/SaveRoleDetails",
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
                                    url: "frmCfUserdetail.aspx/DeleteRole",
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
            console.log($(document.getElementById('<%=hdnRoleId.ClientID%>')).val());
            //var idRole = drpRole.GetValue();
            var idRole = $(document.getElementById('<%=hdnRoleId.ClientID%>')).val();
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
            //var idRole = drpRole.GetValue();
            var idRole = $(document.getElementById('<%=hdnRoleId.ClientID%>')).val();
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
                //var idRole = drpRole.GetValue();
                var idRole = $(document.getElementById('<%=hdnRoleId.ClientID%>')).val();
                console.log(s.cpStrResult)
                if (s.cpStrResult != null && s.cpStrResult != undefined && s.cpStrResult != "") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                }
                cbPerGrid.PerformCallback("FETCH;" + idRole);
            }
        }
        function OngvCtrlPermissionsEndCallback(s, e) {
            if (e.command == 'UPDATEEDIT') {
                //var idRole = drpRole.GetValue();
                var idRole = $(document.getElementById('<%=hdnRoleId.ClientID%>')).val();
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
        function GetRoleId(loginId) {
            var RoleId = 0;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfUserdetail.aspx/FetchUser",
                data: "{loginId: '" + loginId + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (data) {                    
                    if (data.d.length > 0) {
                        mydata = data;
                        RoleId = data.d[0].Id_Role_User;
                    }
                    else {
                        RoleId = 0;
                    }
                }
            });
            console.log(RoleId);
            return RoleId;
        }
    </script>

    <div id="systemMessage" class="ui message"></div>
              <asp:HiddenField ID="hdnMode" runat="server" />
              <asp:HiddenField ID="hdnCommonMechId" runat="server" />            
    <%--Roles Page--%>
    <asp:HiddenField ID="hdnRoleId" runat="server" />
    <asp:HiddenField ID="hdnXML" runat="server" />
    <dx:ASPxHiddenField ID="hdnXMLNew" ClientInstanceName="hdnXMLNew" runat="server"></dx:ASPxHiddenField>
    <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
    <div class="ui one column grid">
        <div class="stretched row">
            <div class="sixteen wide column">
                <div class="ui top attached tabular menu">
                    <a class="cTab item active" data-tab="tabUser" id="btnUser"><%=GetLocalResourceObject("hdrUser")%></a>
                    <a class="cTab item" data-tab="tabRole" id="btnRole"><%=GetLocalResourceObject("hdrRoles")%></a>
        </div>
                <%--########################################## User ##########################################--%>
                <div class="ui bottom attached tab segment active" data-tab="tabUser" id="tabUser">
        <div>
                        <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                            <a id="aAccessRt" runat="server" class="active item"><%=GetLocalResourceObject("hdrUserConfig")%></a>
                        </div>
                        <dx:ASPxCallbackPanel ID="cbUserDetGrid" ClientInstanceName="cbUserDetGrid" runat="server" OnCallback="cbUserDetGrid_Callback" meta:resourcekey="cbUserDetGridResource1">
                            <PanelCollection>
                                <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">
            <div>
                                        <dx:ASPxGridView ID="gvUserDetails" ClientInstanceName="gvUserDetails" runat="server" Theme="Office2010Blue" Width="80%" KeyFieldName="ID_Login" CssClass="gridView" meta:resourcekey="gvUserDetailsResource1">
                                            <SettingsPager PageSize="15">
                                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                            </SettingsPager>
                                            <ClientSideEvents CustomButtonClick="OnbtnEditUserDetClick" RowDblClick="OngvUserDetailsRowDblClick" />
                                            <Settings ShowPreview="false" ShowStatusBar="Hidden" />
                                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                            <Styles>
                                                <FocusedRow BackColor="#d6eef2" ForeColor="Black"></FocusedRow>
                                            </Styles>

                                            <SettingsPopup>
                                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                                            </SettingsPopup>
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" Width="1%"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID_Login" Visible="false" Width="1%"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="First_Name" Caption="First Name" ReadOnly="true" Width="20%" meta:resourcekey="GridViewDataTextColumnResource22">
                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID_Subsidery_User" Caption="Subsidiary" ReadOnly="true" Width="20%" meta:resourcekey="GridViewDataTextColumnResource33">
                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID_Dept_User" Caption="Department" ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataTextColumnResource44">
                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID_Login" ReadOnly="true" Caption="Login Name" Width="20%" meta:resourcekey="GridViewDataTextColumnResource55">
                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Phone" ReadOnly="true" Caption="Telephone" Width="10%" meta:resourcekey="GridViewDataTextColumnResource66">
                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID_Email" ReadOnly="true" Caption="Email" Width="10%" meta:resourcekey="GridViewDataTextColumnResource77">
                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewCommandColumn Caption=" " Width="10%">
                                                    <CustomButtons>
                                                        <dx:GridViewCommandColumnCustomButton ID="btnEditUserDet" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource11"></dx:GridViewCommandColumnCustomButton>
                                                    </CustomButtons>
                                                </dx:GridViewCommandColumn>
                                            </Columns>
                                        </dx:ASPxGridView>
            </div>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                        <p></p>
                        <div style="text-align: center; width: 80%">
                            <input id="btnAddUserDet" type="button" value='<%=GetLocalResourceObject("btnAdd")%>' class="ui button blue" onclick="addUserDetails()" />
                            <input id="btnDeleteUserdet" type="button" value='<%=GetLocalResourceObject("btnDelete")%>' class="ui button red" onclick="delUserDetails()" />
            </div>
                        <div>
                            <dx:ASPxPopupControl runat="server" ID="popupUserDetails" ClientInstanceName="popupUserDetails" Modal="True" HeaderText="User Details" PopupHorizontalAlign="WindowCenter" Top="130" Width="1100px" Height="650px" CloseAction="CloseButton" Theme="Office365" ScrollBars="Auto" meta:resourcekey="popupUserDetailsResource1">
                                <ContentCollection>
                                    <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource1">
                                        <dx:ASPxCallbackPanel ID="cbUserDetailsPopup" ClientInstanceName="cbUserDetailsPopup" runat="server" OnCallback="cbUserDetailsPopup_Callback" Width="100%" meta:resourcekey="cbUserDetailsPopupResource1">
                                            <ClientSideEvents EndCallback="OncbUserDetailsPopupEndCallback" />
                                            <PanelCollection>
                                                <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource2">
                                                    <div class="ui form" style="width: 100%;">
            <div id="divUserDetails" class="ui raised segment signup inactive">
                <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                    <a class="active item" id="aheader" runat="server" >Users</a>
                </div>     
                
                <div class="ui form" style="width: 100%;">
                                                                <div class="four fields">
                                                                    <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                        <asp:Label ID="lblSubsidiary" runat="server" Text="Subsidiary" meta:resourcekey="lblSubsidiaryResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="field" style="width: 200px">
                                                                        <%--<asp:DropDownList runat="server" ID="ddlSubsidiary"></asp:DropDownList>--%>
                                                                        <dx:ASPxComboBox ID="cmbSubsidiary" ClientInstanceName="cmbSubsidiary" CssClass="customComboBox" Theme="Metropolis" runat="server" meta:resourcekey="cmbSubsidiaryResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OncmbSubsidiaryChange" />
                                                                        </dx:ASPxComboBox>
                        </div>
                                                                    <div class="field" style="width: 50px"></div>
                                                                    <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                        <asp:Label ID="lblDepartment" runat="server" Text="Department" meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="field" style="width: 200px">
                                                                        <%--<asp:DropDownList runat="server" ID="ddlDept"></asp:DropDownList>--%>
                                                                        <dx:ASPxComboBox ID="cmbDepartment" ClientInstanceName="cmbDepartment" CssClass="customComboBox" Theme="Metropolis" runat="server" meta:resourcekey="cmbDepartmentResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OncmbDepartmentChange" />
                                                                        </dx:ASPxComboBox>
                        </div>
                                                                    <div class="field" style="padding-left: 1em; width: 130px">
                                                                        <asp:Label ID="lblMech" runat="server" Text="Is Mechanic" meta:resourcekey="lblMechResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="field" style="width: 20px">
                                                                        <dx:ASPxCheckBox ID="chkMech" ClientInstanceName="chkMech" runat="server" Theme="Office2010Blue" Enabled="true" meta:resourcekey="chkMechResource1">
                                                                            <ClientSideEvents CheckedChanged="OnchkMechCheckedChanged" />
                                                                        </dx:ASPxCheckBox>
                                                                    </div>
                                                                    <div class="field" style="width: 40px"></div>
                                                                    <div class="field" style="padding-left: 0.55em; width: 60px">
                                                                        <asp:Label ID="lblMechActive" runat="server" Text="Active" meta:resourcekey="lblMechActiveResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="field" style="width: 20px">
                                                                        <dx:ASPxCheckBox ID="chkMechActive" ClientInstanceName="chkMechActive" runat="server" Theme="Office2010Blue" Enabled="true" meta:resourcekey="chkMechActiveResource1"></dx:ASPxCheckBox>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblRole" runat="server" Text="Role" meta:resourcekey="lblRoleResource1" Visible="false"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxComboBox ID="cmbRole" ClientInstanceName="cmbRole" CssClass="customComboBox" ClientVisible="false" Theme="Metropolis" runat="server" meta:resourcekey="cmbRoleResource1"></dx:ASPxComboBox>
                                                                        </div>
                                                                        <div class="field" style="width: 50px"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblLogin" runat="server" Text="Login Name" meta:resourcekey="lblLoginResource1"></asp:Label><span class="mand">*</span>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbLoginName" ClientInstanceName="tbLoginName" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbLoginNameResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 50px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblUserId" runat="server" Text="User Id" meta:resourcekey="lblUserIdResource1"></asp:Label><span class="mand">*</span>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbUserId" ClientInstanceName="tbUserId" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbUserIdResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblFName" runat="server" Text="First Name" meta:resourcekey="lblFNameResource1"></asp:Label><span class="mand">*</span>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbFName" ClientInstanceName="tbFName" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbFNameResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 50px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblLName" runat="server" Text="Last Name" meta:resourcekey="lblLNameResource1"></asp:Label><span class="mand">*</span>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbLName" ClientInstanceName="tbLName" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbLNameResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblPassword" runat="server" Text="Password" meta:resourcekey="lblPasswordResource1"></asp:Label><span class="mand">*</span>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <dx:ASPxTextBox ID="tbPassword" ClientInstanceName="tbPassword" CssClass="customComboBox" runat="server" Password="True" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbPasswordResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblConfirm" runat="server" Text="Confirm Password" meta:resourcekey="lblConfirmResource1"></asp:Label><span class="mand">*</span>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbConfirm" ClientInstanceName="tbConfirm" CssClass="customComboBox" runat="server" Password="True" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbConfirmResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblLang" runat="server" Text="Language" meta:resourcekey="lblLangResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <dx:ASPxComboBox ID="cmbLang" ClientInstanceName="cmbLang" CssClass="customComboBox" Theme="Metropolis" runat="server" meta:resourcekey="cmbLangResource1"></dx:ASPxComboBox>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblTelNoPerson" runat="server" Text="Telephone No.(Personal)" meta:resourcekey="lblTelNoPersonResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbTelNoPersonal" ClientInstanceName="tbTelNoPersonal" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbTelNoPersonalResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblMobileNo" runat="server" Text="Mobile No" meta:resourcekey="lblMobileNoResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <dx:ASPxTextBox ID="tbMobile" ClientInstanceName="tbMobile" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbMobileResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblFax" runat="server" Text="Fax No." meta:resourcekey="lblFaxResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbFaxNo" ClientInstanceName="tbFaxNo" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbFaxNoResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblEmail" runat="server" Text="Email" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <dx:ASPxTextBox ID="tbEmail" ClientInstanceName="tbEmail" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbEmailResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblCommonMechId" runat="server" Text="Common Mechanic ID." meta:resourcekey="lblCommonMechIdResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbCommonMechId" ClientInstanceName="tbCommonMechId" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbCommonMechIdResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblAutoCorrectionTime" runat="server" Text="Auto Correction Time?" meta:resourcekey="lblAutoCorrectionTimeResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <dx:ASPxRadioButtonList ID="rblAutoCorr" ClientInstanceName="rblAutoCorr" runat="server" CellSpacing="20" RepeatDirection="Horizontal" Theme="Office2010Blue" meta:resourcekey="rblAutoCorrResource1">
                                                                                <Items>
                                                                                    <dx:ListEditItem Value="1" Text="Yes" meta:resourcekey="ListEditItemResource1" />
                                                                                    <dx:ListEditItem Value="0" Text="No" meta:resourcekey="ListEditItemResource2" />
                                                                                </Items>
                                                                            </dx:ASPxRadioButtonList>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblSSN" runat="server" Text="Social Security Number" meta:resourcekey="lblSSNResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbSSN" ClientInstanceName="tbSSN" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbSSNResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblWorkHrsFrm" runat="server" Text="Work Hours From" meta:resourcekey="lblWorkHrsFrmResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <dx:ASPxTextBox ID="tbWorkHrsFrm" ClientInstanceName="tbWorkHrsFrm" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbWorkHrsFrmResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblWorkHrsTo" runat="server" Text="Work Hours To" meta:resourcekey="lblWorkHrsToResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <dx:ASPxTextBox ID="tbWorkHrsTo" ClientInstanceName="tbWorkHrsTo" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbWorkHrsToResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label ID="lblEAccnt" runat="server" Text="E-mail Account" meta:resourcekey="lblEAccntResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <dx:ASPxComboBox ID="cmbEAccnt" ClientInstanceName="cmbEAccnt" CssClass="customComboBox" Theme="Metropolis" runat="server" meta:resourcekey="cmbEAccntResource1"></dx:ASPxComboBox>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label ID="lblWrkHrs" runat="server" Text="Fetch Work Hours from Day Plan" meta:resourcekey="lblWrkHrsResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 40px">
                                                                            <dx:ASPxCheckBox ID="chkWrkHrs" ClientInstanceName="chkWrkHrs" runat="server" Theme="Office2010Blue" Enabled="true" meta:resourcekey="chkWrkHrsResource1"></dx:ASPxCheckBox>
                                                                        </div>
                                                                        <div class="field" style="width: 10px"></div>
                                                                        <div class="field" style="padding-left: 0.55em; width: 100px">
                                                                            <asp:Label ID="lblDuser" runat="server" Text="Dummy User" meta:resourcekey="lblDuserResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 50px">
                                                                            <dx:ASPxCheckBox ID="chkDuser" ClientInstanceName="chkDuser" runat="server" Theme="Office2010Blue" Enabled="true" meta:resourcekey="chkDuserResource1"></dx:ASPxCheckBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                                                                    <a class="active item" runat="server" id="aAddrCom"><%=GetLocalResourceObject("hdrAddressCom")%></a>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label runat="server" ID="lblAddrLine1" Text="Address Line 1" meta:resourcekey="lblAddrLine1Resource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <%--<asp:TextBox ID="txtAddrLine1" runat="server"></asp:TextBox>--%>
                                                                            <dx:ASPxTextBox ID="tbAddrLine1" ClientInstanceName="tbAddrLine1" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbAddrLine1Resource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 50px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label runat="server" ID="lblAddrLine2" Text="Address Line 2" meta:resourcekey="lblAddrLine2Resource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <%--<asp:TextBox ID="txtAddrLine2" runat="server"></asp:TextBox>--%>
                                                                            <dx:ASPxTextBox ID="tbAddrLine2" ClientInstanceName="tbAddrLine2" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbAddrLine2Resource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label runat="server" ID="lblZipCode" Text="ZipCode" meta:resourcekey="lblZipCodeResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 180px">
                                                                            <%-- <input type="text" runat="server" id="txtZipCode" />--%>
                                                                            <dx:ASPxTextBox ID="tbZipCode" ClientInstanceName="tbZipCode" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbZipCodeResource1">
                                                                                <ClientSideEvents Init="OntbZipCodeInit" />

                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 70px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label runat="server" ID="lblCity" Text="City" meta:resourcekey="lblCityResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <%--<asp:TextBox ID="txtCity" runat="server"></asp:TextBox>--%>
                                                                            <dx:ASPxTextBox ID="tbCity" ClientInstanceName="tbCity" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbCityResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="ui form" style="width: 100%;">
                                                                    <div class="four fields">
                                                                        <div class="field" style="padding-left: 0.55em; width: 150px">
                                                                            <asp:Label runat="server" ID="lblCountry" Text="Country" meta:resourcekey="lblCountryResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <%--<asp:TextBox ID="txtCountry" runat="server"></asp:TextBox>--%>
                                                                            <dx:ASPxTextBox ID="tbCountry" ClientInstanceName="tbCountry" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbCountryResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="field" style="width: 50px"></div>
                                                                        <div class="field" style="padding-left: 1em; width: 150px">
                                                                            <asp:Label runat="server" ID="lblState" Text="State" meta:resourcekey="lblStateResource1"></asp:Label>
                                                                        </div>
                                                                        <div class="field" style="width: 200px">
                                                                            <%-- <asp:TextBox ID="txtState" runat="server"></asp:TextBox>--%>
                                                                            <dx:ASPxTextBox ID="tbState" ClientInstanceName="tbState" CssClass="customComboBox" runat="server" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbStateResource1">
                                                                                <FocusedStyle>
                                                                                    <Border BorderColor="#2185D0"></Border>
                                                                                </FocusedStyle>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div style="text-align: center">
                                                                    <input id="btnSave" class="ui button blue" value='<%=GetLocalResourceObject("btnSave")%>' type="button" onclick="saveUserDetails()" />
                                                                    &nbsp;<input id="btnReset" class="ui button" value='<%=GetLocalResourceObject("btnReset")%>' type="button" style="background-color: #E0E0E0" onclick="resetUserDet()" />
                                                                </div>
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
                    </div>
                </div>
                <%--########################################## Role ##########################################--%>
                <div class="ui bottom attached tab segment" data-tab="tabRole" id="tabRole">
                    <div>
                        <div id="divRoles" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                                <a id="header" runat="server" class="active item"><%=GetLocalResourceObject("hdrRoles")%></a>
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
                                                    <div>
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
                                                    </div>
                                                    <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                                                        <a id="a1" runat="server" class="active item"><%=GetLocalResourceObject("hdrGeneral")%></a>
                                                    </div>

                                                    <div class="inline fields">
                                                        <div class="two wide field">
                                                            <asp:Label ID="lblStartScreen" runat="server" Text="Start Screen" Width="100px" meta:resourcekey="lblStartScreenResource1"></asp:Label>
                                                        </div>
                                                        <div class="four wide field">
                                                            <dx:ASPxComboBox ID="drpStartScreen" ClientInstanceName="drpStartScreen" CssClass="customComboBox" Theme="Metropolis" Width="290px" runat="server" meta:resourcekey="drpStartScreenResource1"></dx:ASPxComboBox>
                                                        </div>
                                                        <div class="three wide field">
                                                            <dx:ASPxCheckBox ID="cbNbkSettings" runat="server" ClientInstanceName="cbNbkSettings" Text="Nbk Settings" Theme="Office2010Blue" meta:resourcekey="cbNbkSettingsResource1" />
                                                        </div>
                                                        <div class="three wide field">
                                                            <dx:ASPxCheckBox ID="cbAccounting" runat="server" ClientInstanceName="cbAccounting" Text="Accounting" Theme="Office2010Blue" meta:resourcekey="cbAccountingResource1" />
                                                        </div>
                                                        <div class="three wide field">
                                                            <dx:ASPxCheckBox ID="cbSparePartOrder" runat="server" ClientInstanceName="cbCarSales" Text="Spare Part Order" Theme="Office2010Blue" meta:resourcekey="cbSparePartOrderResource1" />
                                                        </div>
                                                    </div>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </div>
                                    <div class="four wide field"></div>
                                    <div style="text-align: center">
                                        <input id="btnSaveRole" type="button" value='<%=GetLocalResourceObject("btnSave")%>' class="ui button blue" onclick="FinalSaveRole()" />
                                        <input id="btnResetRole" type="button" value='<%=GetLocalResourceObject("btnReset")%>' class="ui button negative" onclick="ResetAll()" />
                                    </div>
                                    <div class="four wide field"></div>
                                    <div class="four wide field"></div>
                                </div>
                            </div>
                            <div>
                        </div>                    
               </div>
             </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

