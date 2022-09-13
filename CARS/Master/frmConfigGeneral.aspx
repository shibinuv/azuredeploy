<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmConfigGeneral.aspx.vb" Inherits="CARS.frmConfigGeneral" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style type="text/css">
        .gridView .dxgvDataRow_Office2010Blue {
            height: 20px;
            font-size: small;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            loadGenSettings();
            loadConfig();
            $('.menu .item')
                .tab()
                ; //activate the tabs

            setTab('tabGenSett');

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
            $('#btnImportZipcode').on('click', function () {
                var cnt = "";
                var ins = "";
                var upd = "";
                var btn = $(this);
                btn.addClass('loading').prop('disabled', true);
                $.ajax({
                    type: 'POST',
                    url: 'frmUpZipCodes.aspx/Update_ZipCodes',
                    data: '{}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: "json",
                    async: true,
                    success: function (Result) {
                        cnt= Result.d[0];
                        ins = Result.d[1] == 0 ? '<%=GetLocalResourceObject("genNo")%>' : Result.d[1];
                        upd = Result.d[2] == 0 ? '<%=GetLocalResourceObject("genNo")%>' : Result.d[2];
                        //var resString = 'Det ble lest ' + cnt + ' postnummer. ' + ins + ' av disse var nye og ' + upd + ' postnummer ble oppdatert med ny informasjon.';
                        systemMSG('success', `<%=GetLocalResourceObject("genZipUpdate")%>`, 6000);
                        if (Result.d.length > 0) {
                            btn.removeClass('loading').prop('disabled', false);
                        }
                        cbZipCode.PerformCallback();
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            });
        });
       
        function loadGenSettings() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmConfigGeneral.aspx/LoadGenSettings",
                data: "{}",
                dataType: "json",
                async: false,//Very important
                success: function (data) {
                    if (data.d.length > 0) {
                        if (data.d[2][0].Description != "0" || data.d[2][0].Description != "") {
                            $('#<%=cmbTimeFormat.ClientID%>').val(data.d[2][0].Description);
                        } else {
                            $('#<%=cmbTimeFormat.ClientID%>')[0].selectedIndex = 0;
                        }

                        if (data.d[3][0].Description != "0" || data.d[3][0].Description != "") {
                            $('#<%=cmbUnitofTimings.ClientID%>').val(data.d[3][0].Description);
                         } else {
                             $('#<%=cmbUnitofTimings.ClientID%>')[0].selectedIndex = 0;
                        }

                        if (data.d[4][0].Description != "0" || data.d[4][0].Description != "") {
                            $('#<%=ddlCurrency.ClientID%> option:contains("' + data.d[4][0].Description + '")').attr('selected', 'selected');
                         } else {
                             $('#<%=ddlCurrency.ClientID%>')[0].selectedIndex = 0;
                        }

                        if (data.d[5][0].Description != "") {
                            $('#<%=txtMinimumSplits.ClientID%>').val(data.d[5][0].Description);
                         } else {
                             $('#<%=txtMinimumSplits.ClientID%>').val("");
                        }

                        if (data.d[6][0].Description == "true") {
                            $("#<%=cbSubRepairCode.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbSubRepairCode.ClientID%>").attr('checked', false);
                        }

                        if (data.d[7][0].Description == "true") {
                            $("#<%=cbSubDayPlan.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbSubDayPlan.ClientID%>").attr('checked', false);
                        }

                        if (data.d[8][0].Description == "true") {
                            $("#<%=cbJobCard.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbJobCard.ClientID%>").attr('checked', false);
                        }

                        if (data.d[9][0].Description == "true") {
                            $("#<%=cbEditStdTime.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbEditStdTime.ClientID%>").attr('checked', false);
                        }

                        if (data.d[10][0].Description == "true") {
                            $("#<%=cbViewGarSummary.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbViewGarSummary.ClientID%>").attr('checked', false);
                        }

                        if (data.d[11][0].Description == "true") {
                            $("#<%=cbMonday.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbMonday.ClientID%>").attr('checked', false);
                        }

                        if (data.d[12][0].Description == "true") {
                            $("#<%=cbVhReg.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbVhReg.ClientID%>").attr('checked', false);
                        }

                        if (data.d[13][0].Description == "true") {
                            $("#<%=cbUseInvPdf.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbUseInvPdf.ClientID%>").attr('checked', false);
                        }

                        if (data.d[14][0].Description == "true") {
                            $("#<%=cbUseDynCT.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbUseDynCT.ClientID%>").attr('checked', false);
                        }

                        if (data.d[15][0].Description == "true") {
                            $("#<%=cbUseDBSLnk.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbUseDBSLnk.ClientID%>").attr('checked', false);
                        }

                        if (data.d[16][0].Description == "true") {
                            $("#<%=cbUseApprove.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbUseApprove.ClientID%>").attr('checked', false);
                        }

                        if (data.d[17][0].Description == "true") {
                            $("#<%=cbUseMechGrid.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbUseMechGrid.ClientID%>").attr('checked', false);
                        }

                        if (data.d[18][0].Description == "true") {
                            $("#<%=cbSortbyLoc.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbSortbyLoc.ClientID%>").attr('checked', false);
                        }

                        if (data.d[19][0].Description == "true") {
                            $("#<%=cbStdTime.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbStdTime.ClientID%>").attr('checked', false);
                        }

                        if (data.d[20][0].Description == "true") {
                            $("#<%=cbChgTime.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbChgTime.ClientID%>").attr('checked', false);
                        }

                        if (data.d[21][0].Description == "true") {
                            $("#<%=cbMileage.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbMileage.ClientID%>").attr('checked', false);
                        }

                        if (data.d[22][0].Description == "true") {
                            $("#<%=cbSaveUdDp.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbSaveUdDp.ClientID%>").attr('checked', false);
                        }

                        if (data.d[23][0].Description == "true") {
                            $("#<%=cbDispIntNote.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbDispIntNote.ClientID%>").attr('checked', false);
                        }

                        if (data.d[24][0].Description == "true") {
                            $("#<%=cbSpBO.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbSpBO.ClientID%>").attr('checked', false);
                        }

                        if (data.d[25][0].Description == "true") {
                            $("#<%=cbWOSpares.ClientID%>").attr('checked', true);
                         } else {
                             $("#<%=cbWOSpares.ClientID%>").attr('checked', false);
                        }
                    }
                }
            });
        }

        function saveGenSettings() {
            var timeFormat = $('#<%=cmbTimeFormat.ClientID%>').val();
            var unitOfTime = $('#<%=cmbUnitofTimings.ClientID%>').val();
            var currency = $('#<%=ddlCurrency.ClientID%>').val();
            var minSplits = $('#<%=txtMinimumSplits.ClientID%>').val();
            var useSubRepCode = $("#<%=cbSubRepairCode.ClientID%>").is(':checked');
            var useAutoResize = $("#<%=cbSubDayPlan.ClientID%>").is(':checked');
            var useDynClkTime = $("#<%=cbUseDynCT.ClientID%>").is(':checked');
            var useNewJobCard = $("#<%=cbJobCard.ClientID%>").is(':checked');
            var useEdtStdTime = $("#<%=cbEditStdTime.ClientID%>").is(':checked');
            var useViewGarSum = $("#<%=cbViewGarSummary.ClientID%>").is(':checked');
            var useMondStDay = $("#<%=cbMonday.ClientID%>").is(':checked');
            var useVehRegn = $("#<%=cbVhReg.ClientID%>").is(':checked');
            var useInvPdf = $("#<%=cbUseInvPdf.ClientID%>").is(':checked');
            var useDBS = $("#<%=cbUseDBSLnk.ClientID%>").is(':checked');
            var useApprIR = $("#<%=cbUseApprove.ClientID%>").is(':checked');
            var useMechGrid = $("#<%=cbUseMechGrid.ClientID%>").is(':checked');
            var useSortPL = $("#<%=cbSortbyLoc.ClientID%>").is(':checked');
            var useValStdTime = $("#<%=cbStdTime.ClientID%>").is(':checked');
            var useEdtChgTime = $("#<%=cbChgTime.ClientID%>").is(':checked');
            var useValMileage = $("#<%=cbMileage.ClientID%>").is(':checked');
            var useSavUpdDP = $("#<%=cbSaveUdDp.ClientID%>").is(':checked');
            var useIntNote = $("#<%=cbDispIntNote.ClientID%>").is(':checked');
            var useGrpSPBO = $("#<%=cbSpBO.ClientID%>").is(':checked');
            var useDispWOSpares = $("#<%=cbWOSpares.ClientID%>").is(':checked');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmConfigGeneral.aspx/SaveGenSettings",
                data: "{timeFormat: '" + timeFormat + "', unitOfTime:'" + unitOfTime + "', currency:'" + currency + "', minSplits:'" + minSplits + "', useSubRepCode:'" + useSubRepCode + "', useAutoResize:'" + useAutoResize + "', useDynClkTime:'" + useDynClkTime + "', useNewJobCard:'" + useNewJobCard + "', useEdtStdTime:'" + useEdtStdTime + "', useViewGarSum:'" + useViewGarSum + "', useMondStDay:'" + useMondStDay + "', useVehRegn:'" + useVehRegn + "', useInvPdf:'" + useInvPdf + "', useDBS:'" + useDBS + "', useApprIR:'" + useApprIR + "', useMechGrid:'" + useMechGrid + "', useSortPL:'" + useSortPL + "', useValStdTime:'" + useValStdTime + "', useEdtChgTime:'" + useEdtChgTime + "', useValMileage:'" + useValMileage + "', useSavUpdDP:'" + useSavUpdDP + "', useIntNote:'" + useIntNote + "', useGrpSPBO:'" + useGrpSPBO + "', useDispWOSpares:'" + useDispWOSpares + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    data = data.d[0];
                    if (data != "") {
                        loadGenSettings();
                        systemMSG('success', '<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                    }
                    else {
                        systemMSG('success', '<%=GetLocalResourceObject("errAlreadyExists")%>', 6000);
                    }
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }
        
        function OnBatchEditStartEditing(s, e) {
            //alert(e.focusedColumn.val());
            if (e.focusedColumn.fieldName == "ZIPCODE") {
                if (e.visibleIndex >= 0) { 
                    e.cancel = true;
                    gvZipCode.SetFocusedCell(e.visibleIndex, 2);
                    s.batchEditApi.StartEdit(e.visibleIndex, 2);
                }

            }
        } 

        function OngvZipCodeEndCallback(s, e) {
            if (e.command == 'UPDATEEDIT') {

                if (s.cpZipInsResult != undefined && s.cpZipInsResult == "0") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecInserted")%>', 6000);
                }

                if (s.cpZipUpdResult != undefined && s.cpZipUpdResult == "0") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecUpdated")%>', 6000);
                }
                console.log(s.cpZipDelResult);
                if (s.cpZipDelResult != undefined) {
                    if (s.cpZipDelResult[0] == "DEL") {
                        systemMSG('success', '<%=GetLocalResourceObject("genRecDeleted")%>', 6000);
                    }
                    else if (s.cpZipDelResult[0] == "NDEL") {
                        systemMSG('error', '<%=GetLocalResourceObject("errDelErr")%>', 6000);
                    }
                }
            }
        }

        function OngvDiscCodeEndCallback(s, e) {

            if (e.command == 'UPDATEEDIT') {
                
                if (s.cpDCInsResult != undefined && s.cpDCInsResult.length > 0) {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecInserted")%>', 6000);
                }
                
                if (s.cpDCUpdResult != undefined && s.cpDCUpdResult.length > 0) {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecUpdated")%>', 6000);
                }
                
                if (s.cpDCDelResult != undefined) {
                    if (s.cpDCDelResult[0] == "DEL") {
                        systemMSG('success', '<%=GetLocalResourceObject("genRecDeleted")%>', 6000);
                    }
                    else if (s.cpDCDelResult[0] == "NDEL") {
                        systemMSG('error', '<%=GetLocalResourceObject("errDelErr")%>', 6000);
                    }
                }
            }
        }

        function OngvReasonFrLvEndCallback(s, e) {
            if (e.command == 'UPDATEEDIT') {
                console.log(s.cpRLInsResult);
                if (s.cpRLInsResult != undefined && s.cpRLInsResult.length > 0) {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecInserted")%>', 6000);
                }
                console.log(s.cpRLUpdResult);
                if (s.cpRLUpdResult != undefined && s.cpRLUpdResult.length > 0) {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecUpdated")%>', 6000);
                }
                console.log(s.cpRLDelResult);
                if (s.cpRLDelResult != undefined) {
                    if (s.cpRLDelResult[0] == "DEL") {
                        systemMSG('success', '<%=GetLocalResourceObject("genRecDeleted")%>', 6000);

                    }
                    else if (s.cpRLDelResult[0] == "NDEL") {
                        systemMSG('error', '<%=GetLocalResourceObject("errDelErr")%>', 6000);
                    }
                }
            }
        }

        function OngvStationTypeEndCallback(s, e) {
            if (e.command == 'UPDATEEDIT') {
                if (s.cpSTInsResult != undefined && s.cpSTInsResult.length > 0) {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecInserted")%>', 6000);
                }
                
                if (s.cpSTUpdResult != undefined && s.cpSTUpdResult.length > 0) {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecUpdated")%>', 6000);
                }
                
                if (s.cpSTDelResult != undefined) {
                    if (s.cpSTDelResult[0] == "DEL") {
                        systemMSG('success', '<%=GetLocalResourceObject("genRecDeleted")%>', 6000);

                    }
                    else if (s.cpSTDelResult[0] == "NDEL") {
                        systemMSG('error', '<%=GetLocalResourceObject("errDelErr")%>', 6000);
                    }
                }
            }
        }

        function loadSMSSettings(data) {
            $('#<%=txtSMSMailServer.ClientID%>').val(data[0].SmsServer);
            $('#<%=txtSMSPrefix.ClientID%>').val(data[0].SmsPrefix);
            $('#<%=txtSMSSuffix.ClientID%>').val(data[0].SmsSuffix);
            $('#<%=txtSMSCtryCode.ClientID%>').val(data[0].SmsCtryCde);
            $('#<%=txtSMSNoChars.ClientID%>').val(data[0].SmsNoChars);
            $('#<%=txtSMSStartDigits.ClientID%>').val(data[0].SmsStDigit);
            if (data[0].SmsMailUsr == "false") {
                $("#<%=cbSMSUseEmail.ClientID%>").attr('checked', false);
            } else {
                $("#<%=cbSMSUseEmail.ClientID%>").attr('checked', true);
            }

            return true;
        }

        function loadConfig() {
            var mydata;
            var pageSize = document.getElementById('<%=hdnPageSize.ClientID%>').value;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfGeneral.aspx/LoadConfig",
                data: "{}",
                dataType: "json",
                async: false,//Very important
                success: function (data) {
                    loadSMSSettings(data.d[3]);
                }
            });
        }

        function saveSMSSettings() {
            var smsServer = $('#<%=txtSMSMailServer.ClientID%>').val();
            var smsPrefix = $('#<%=txtSMSPrefix.ClientID%>').val();
            var smsSuffix = $('#<%=txtSMSSuffix.ClientID%>').val();
            var smsCtryCode = $('#<%=txtSMSCtryCode.ClientID%>').val();
            var smsNoChars = $("#<%=txtSMSNoChars.ClientID%>").val();
            var smsStDigit = $("#<%=txtSMSStartDigits.ClientID%>").val();
            var smsMailUsr = $("#<%=cbSMSUseEmail.ClientID%>").is(':checked').toString();

            var result = fnValidateSMSGeneral();
            if (result == true) {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCfGeneral.aspx/SaveSMSSettings",
                    data: "{smsServer: '" + smsServer + "', smsPrefix:'" + smsPrefix + "', smsSuffix:'" + smsSuffix + "', smsCtryCode:'" + smsCtryCode + "', smsNoChars:'" + smsNoChars + "', smsStDigit:'" + smsStDigit + "', smsMailUsr:'" + smsMailUsr + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        data = data.d[0];
                        if (data != "") {
                            systemMSG('success','<%=GetLocalResourceObject("genRecSaved")%>', 6000);
                        }
                        else {
                            systemMSG('error', '<%=GetLocalResourceObject("errAlreadyExists")%>', 6000);
                        }
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
            }
        }

        function fnValidateSMSGeneral() {
            if ($('#<%=txtSMSMailServer.ClientID%>').val().trim() == "") {
                swal('<%=GetLocalResourceObject("errMailServerEmpty")%>');
                return false;
            }

            if (!(ValidateNumber($('#<%=txtSMSNoChars.ClientID%>')))) {
                swal('<%=GetLocalResourceObject("errNumersOnlySMSNoChars")%>');
                return false;
            }

            var ctrycode = $('#<%=txtSMSCtryCode.ClientID%>').val();
            var arrctrycode = ctrycode.split("+");

            if (ctrycode == "+") {
                swal('<%=GetLocalResourceObject("errCtryCode")%>');
                return false;
            }
            else {
                if (arrctrycode.length == 1) {
                    //Prefix not given
                    var fieldvalue = arrctrycode[0];
                    var valuelength = fieldvalue.length;

                    for (var ct = 0; ct <= valuelength - 1; ct++) {
                        var Onechar = fieldvalue.charAt(ct);
                        if (Onechar < "0" || Onechar > "9") {
                            swal('<%=GetLocalResourceObject("errCtryCode")%>');
                            return false;
                        }
                    }
                }
                if (arrctrycode.length == 2) {
                    //Prefix given
                    var fieldvalue = arrctrycode[1];
                    var valuelength = fieldvalue.length;

                    for (var ct = 0; ct <= valuelength - 1; ct++) {
                        var Onechar = fieldvalue.charAt(ct);
                        if (Onechar < "0" || Onechar > "9") {
                            swal('<%=GetLocalResourceObject("errCtryCode")%>');
                            return false;
                        }
                    }
                }
                if (arrctrycode.length > 2) {
                    //Invalid chars
                    swal('<%=GetLocalResourceObject("errCtryCode")%>');
                    return false;
                }
            }

            var startdigits = $('#<%=txtSMSStartDigits.ClientID%>').val();
            var arrdigits = startdigits.split("/");

            if (trimtext(startdigits) != "") {
                if (startdigits == "/") {
                    swal('<%=GetLocalResourceObject("errStdgtNum")%>');
                    return false;
                }
                for (var ct = 0; ct <= arrdigits.length - 1; ct++) {
                    var Onechar = arrdigits[ct];
                    if (Onechar < 0 || Onechar > 9) {
                        //var msg = GetMultiMessage('STSINGLE', '', '');
                        swal('<%=GetLocalResourceObject("errStSingle")%>');
                        return false;
                    }
                    if ((Onechar < "0" || Onechar > "9") && Onechar != "/") {
                        //var msg = GetMultiMessage('STDGTNUM', '', '');
                        swal('<%=GetLocalResourceObject("errStdgtNum")%>');
                        return false;
                    }

                    var fieldvalue = Onechar;
                    var valuelength = fieldvalue.length;

                    for (var innerct = 0; innerct <= valuelength - 1; innerct++) {
                        var innerOnechar = fieldvalue.charAt(innerct);
                        if (innerOnechar < "0" || innerOnechar > "9") {
                            //var msg = GetMultiMessage('STDGTNUM', '', '');
                            swal('<%=GetLocalResourceObject("errStdgtNum")%>');
                            return false;
                        }
                    }
                }
            }

            return true;
        }

        function trimtext(stringToTrim) {
            return stringToTrim.replace(/^\s+|\s+$/g, "");
        }

        function ValidateNumber(field) {
            // This function verifies whether the value entered contains numbers.
            var FieldValue;
            var FieldLength;
            var Onechar;

            FieldValue = field.val();
            //console.log(field.val());
            FieldLength = FieldValue.length;
            //console.log(FieldLength);
            Onechar = FieldValue.charAt(0);
            //to check each charecter lies in between the numbers.
            for (IntCount = 0; IntCount < FieldLength; IntCount++) {
                Onechar = FieldValue.charAt(IntCount);
                if (Onechar < "0" || Onechar > "9") {
                    //swal('Rab Column should be integer only.');
                    return false;
                }
            }
            return true;
        }

        function OngvDeptMessEndCallback(s, e) {
            if (e.command == 'UPDATEEDIT') {
                
                if (s.cpDMInsResult != undefined && s.cpDMInsResult == "INSERTED") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecInserted")%>', 6000);
                }
                
                if (s.cpDMUpdResult != undefined && s.cpDMUpdResult == "UPDATED") {
                    systemMSG('success', '<%=GetLocalResourceObject("genRecUpdated")%>', 6000);
                }
                
                if (s.cpDMDelResult != undefined && s.cpDMDelResult != "") {
                    if (s.cpDMDelResult == "DELETED") {
                        systemMSG('success', '<%=GetLocalResourceObject("genRecDeleted")%>', 6000);
                    }
                    else {
                        systemMSG('error', '<%=GetLocalResourceObject("errDelErr")%>', 6000);
                    }
                }
            }
        }
    </script>
    <div >
        <div id="systemMessage" class="ui message"> </div>
        <asp:Label ID="lblHead" runat="server" meta:resourcekey="lblHeadResource1"></asp:Label>
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
        <asp:HiddenField ID="hdnPageSize" runat="server" />
        <asp:HiddenField ID="hdnEditCap" runat="server" />
        <asp:HiddenField ID="hdnMode" runat="server" />
        <asp:HiddenField ID="hdnSelect" runat="server" />
        <asp:HiddenField ID="hdnZipCodeId" runat="server" />
        <asp:HiddenField ID="hdnDiscCodeId" runat="server" />
        <asp:HiddenField ID="hdnVATCodeId" runat="server" />
        <asp:HiddenField ID="hdnReasonId" runat="server" />
        <asp:HiddenField ID="hdnStationTypeId" runat="server" />
        <asp:HiddenField ID="hdnDeptMessId" runat="server" />
    </div>
    <div>
        <div class="ui one column grid">
            <div class="stretched row">
                <div class="sixteen wide column">
                    <div class="ui top attached tabular menu">
                        <a class="cTab item active" data-tab="tabGenSett"><%=GetLocalResourceObject("hdrGeneralSett")%></a>
                        <a class="cTab item" data-tab="tabZipCode"><%=GetLocalResourceObject("hdrZipCode")%></a>
                        <a class="cTab item" data-tab="tabDiscCode"><%=GetLocalResourceObject("hdrDiscCode")%></a>
                        <a class="cTab item" data-tab="tabReasonForLeave"><%=GetLocalResourceObject("hdrReasonFrLv")%></a>
                        <a class="cTab item" data-tab="tabStationType"><%=GetLocalResourceObject("hdrStationType")%></a>
                        <a class="cTab item" data-tab="tabSMSSettings"><%=GetLocalResourceObject("hdrSMSSett")%></a>
                        <a class="cTab item" data-tab="tabDeptMess"><%=GetLocalResourceObject("hdrDeptMessage")%></a>
                    </div>
                    <%--########################################## General Settings ##########################################--%>
                    <div class="ui bottom attached tab segment active" data-tab="tabGenSett">
                        <div id="tabGenSetting">
                            <div>
                                <div id="divGenSett" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblGenSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrGeneralSett")%></h3>
                                    <div class="ui form" style="width: 100%;">
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblTimeFormat" runat="server" Text="Time Format" meta:resourcekey="lblTimeFormatResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:DropDownList ID="cmbTimeFormat" runat="server" Width="156px" CssClass="drpdwm" meta:resourcekey="cmbTimeFormatResource1"></asp:DropDownList>
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblUnitofTimings" runat="server" Text="Unit of Timings" meta:resourcekey="lblUnitofTimingsResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:DropDownList ID="cmbUnitofTimings" runat="server" Width="156px" CssClass="drpdwm" meta:resourcekey="cmbUnitofTimingsResource1"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblCurrency" runat="server" Text="Currency" meta:resourcekey="lblCurrencyResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:DropDownList ID="ddlCurrency" runat="server" Width="156px" CssClass="drpdwm" meta:resourcekey="ddlCurrencyResource1">
                                                    <asp:ListItem Text="NOR" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                    <asp:ListItem Text="INR" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblMinimumSplits" runat="server" Text="Minimum Splitting Time" meta:resourcekey="lblMinimumSplitsResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:TextBox ID="txtMinimumSplits" runat="server" CssClass="inp" MaxLength="10" Width="110px" onchange="fnValidateTime();" meta:resourcekey="txtMinimumSplitsResource1"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblSubRepairCode" runat="server" Text="Use Sub-Repair code" meta:resourcekey="lblSubRepairCodeResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbSubRepairCode" runat="server" meta:resourcekey="cbSubRepairCodeResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lbldayPlanCode" runat="server" Text="Auto-Resize Planned Job" meta:resourcekey="lbldayPlanCodeResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbSubDayPlan" runat="server" meta:resourcekey="cbSubDayPlanResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblUseDynCT" runat="server" Text="Use Dynamic Clock Time" meta:resourcekey="lblUseDynCTResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbUseDynCT" runat="server" meta:resourcekey="cbUseDynCTResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblJobCard" runat="server" Text="Use new layout for Job Card" meta:resourcekey="lblJobCardResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbJobCard" runat="server" meta:resourcekey="cbJobCardResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblEditStdTime" runat="server" Text="Editing Std Time" meta:resourcekey="lblEditStdTimeResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbEditStdTime" runat="server" meta:resourcekey="cbEditStdTimeResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblViewGarSummary" runat="server" Text="View Garage Summary" meta:resourcekey="lblViewGarSummaryResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbViewGarSummary" runat="server" meta:resourcekey="cbViewGarSummaryResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblMonday" runat="server" Text="Monday As StartDay" meta:resourcekey="lblMondayResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbMonday" runat="server" meta:resourcekey="cbMondayResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblVhReg" runat="server" Text="Use Veh.Registration on Dayplan" meta:resourcekey="lblVhRegResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbVhReg" runat="server" meta:resourcekey="cbVhRegResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblUseInvPdf" runat="server" Text="Use Inv Pdf" meta:resourcekey="lblUseInvPdfResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbUseInvPdf" runat="server" meta:resourcekey="cbUseInvPdfResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblUseDBSLnk" runat="server" Text="Use DBS File Upload" meta:resourcekey="lblUseDBSLnkResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbUseDBSLnk" runat="server" meta:resourcekey="cbUseDBSLnkResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblUseApprove" runat="server" Text="Use Approve in IR" meta:resourcekey="lblUseApproveResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbUseApprove" runat="server" meta:resourcekey="cbUseApproveResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblUseMechGrid" runat="server" Text="Use MechGrid" meta:resourcekey="lblUseMechGridResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbUseMechGrid" runat="server" meta:resourcekey="cbUseMechGridResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblSortByLoc" runat="server" Text="Sort Picking List by Location" meta:resourcekey="lblSortByLocResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbSortbyLoc" runat="server" meta:resourcekey="cbSortbyLocResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblStdTime" runat="server" Text="Validate Std Time" meta:resourcekey="lblStdTimeResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbStdTime" runat="server" meta:resourcekey="cbStdTimeResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblChgTime" runat="server" Text="Edit Chg Time" meta:resourcekey="lblChgTimeResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbChgTime" runat="server" meta:resourcekey="cbChgTimeResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblMileage" runat="server" Text="Validate Mileage" meta:resourcekey="lblMileageResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbMileage" runat="server" meta:resourcekey="cbMileageResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblSaveUdDp" runat="server" Text="Save/Update DayPlan" meta:resourcekey="lblSaveUdDpResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbSaveUdDp" runat="server" meta:resourcekey="cbSaveUdDpResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblDispIntNote" runat="server" Text="Internal Note" meta:resourcekey="lblDispIntNoteResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbDispIntNote" runat="server" meta:resourcekey="cbDispIntNoteResource1" />
                                            </div>
                                        </div>
                                        <div class="four fields">
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblSpBO" runat="server" Text="Group Spare Parts in BO" meta:resourcekey="lblSpBOResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbSpBO" runat="server" meta:resourcekey="cbSpBOResource1" />
                                            </div>
                                            <div class="field" style="width: 180px">
                                                <asp:Label ID="lblDispWOSpares" runat="server" Text="Display WO Spares" meta:resourcekey="lblDispWOSparesResource1"></asp:Label>
                                            </div>
                                            <div class="field" style="width: 200px">
                                                <asp:CheckBox ID="cbWOSpares" runat="server" meta:resourcekey="cbWOSparesResource1" />
                                            </div>
                                        </div>
                                        <div style="text-align: center">
                                            <input id="btnSaveGenSett" class="ui button" value='<%=GetLocalResourceObject("btnSave")%>' type="button" onclick="saveGenSettings()" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--########################################## Zip Code ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabZipCode">
                        <div id="tabZipCode">
                            <div id="divZipCode" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="lblZipCode" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrZipCode")%></h3>
                                   
                                <div style="text-align: right">
                                    <button id="btnImportZipcode" class="ui primary button" type="button"><%=GetLocalResourceObject("btnUpdateZipCode")%></button>
                                </div>
                                <p></p>
                                <dx:ASPxCallbackPanel ID="cbZipCode" ClientInstanceName="cbZipCode" runat="server" OnCallback="cbZipCode_Callback" meta:resourcekey="cbZipCodeResource1">

                                    <PanelCollection>
                                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">
                                            <dx:ASPxGridView ID="gvZipCode" ClientInstanceName="gvZipCode" runat="server" KeyFieldName="ZIPCODE" OnBatchUpdate="gvZipCode_BatchUpdate" Theme="Office2010Blue" Width="100%" CssClass="gridView" meta:resourcekey="gvZipCodeResource1">
                                                <SettingsEditing Mode="Batch"></SettingsEditing>
                                                <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEditing" EndCallback="OngvZipCodeEndCallback"/>
                                                <SettingsPager PageSize="15">
                                                    <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                                </SettingsPager>
                                                <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                </SettingsPopup>

                                                <SettingsSearchPanel Visible="true" />
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="10%" meta:resourcekey="GridViewCommandColumnResource1"></dx:GridViewCommandColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ZIPCODE" Caption="Zip Code" Width="20%" meta:resourcekey="GridViewDataTextColumnResource1">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                            </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="COUNTRY" Caption="Country" Width="30%" meta:resourcekey="GridViewDataTextColumnResource2">
                                                        <PropertiesTextEdit>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="STATE" Caption="State" Width="20%" meta:resourcekey="GridViewDataTextColumnResource3">
                                                        <PropertiesTextEdit>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CITY" Caption="City" Width="20%" meta:resourcekey="GridViewDataTextColumnResource4">
                                                        <PropertiesTextEdit>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                                
                            </div>
                        </div>
                    </div>

                    <%--########################################## Discount Code ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabDiscCode">
                        <div id="tabDiscountCode">
                            <div id="divDiscCode" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="lblDiscCode" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrDiscCode")%></h3>
                                <dx:ASPxCallbackPanel ID="cbDiscCode" ClientInstanceName="cbDiscCode" runat="server" meta:resourcekey="cbDiscCodeResource1">

                                    <PanelCollection>
                                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource2">
                                            <dx:ASPxGridView ID="gvDiscCode" ClientInstanceName="gvDiscCode" KeyFieldName="ID_SETTINGS" runat="server" OnBatchUpdate="gvDiscCode_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" meta:resourcekey="gvDiscCodeResource1">
                                                <ClientSideEvents EndCallback="OngvDiscCodeEndCallback" />
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
                                                    <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource5">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource6"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_CONFIG" Visible="false" meta:resourcekey="GridViewDataTextColumnResource7"></dx:GridViewDataTextColumn>

                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                        </div>
                    </div>

                    <%--########################################## Reason For Leave ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabReasonForLeave">
                        <div id="tabReasonFrLv">
                            <div id="divReasonFrLv" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="H1" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrReasonFrLv")%></h3>
                                <dx:ASPxCallbackPanel ID="cbReasonFrLv" ClientInstanceName="cbReasonFrLv" runat="server" meta:resourcekey="cbReasonFrLvResource1">

                                    <PanelCollection>
                                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource3">
                                            <dx:ASPxGridView ID="gvReasonFrLv" ClientInstanceName="gvReasonFrLv" KeyFieldName="ID_SETTINGS" runat="server" OnBatchUpdate="gvReasonFrLv_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" meta:resourcekey="gvReasonFrLvResource1">
                                                <ClientSideEvents EndCallback="OngvReasonFrLvEndCallback" />
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
                                                    <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" Width="80%" meta:resourcekey="GridViewDataTextColumnResource8">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource9"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_CONFIG" Visible="false" meta:resourcekey="GridViewDataTextColumnResource10"></dx:GridViewDataTextColumn>

                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                        </div>
                    </div>

                    <%--########################################## Station Type ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabStationType">
                        <div id="tabStationType">
                            <div id="divStationType" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="lblStationType" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrStationType")%></h3>
                                <dx:ASPxCallbackPanel ID="cbStationType" ClientInstanceName="cbStationType" runat="server" meta:resourcekey="cbStationTypeResource1">

                                    <PanelCollection>
                                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource4">
                                            <dx:ASPxGridView ID="gvStationType" ClientInstanceName="gvStationType" KeyFieldName="ID_STYPE" runat="server" OnBatchUpdate="gvStationType_BatchUpdate" Theme="Office2010Blue" Width="50%" CssClass="gridView" meta:resourcekey="gvStationTypeResource1">
                                                <ClientSideEvents EndCallback="OngvStationTypeEndCallback" />
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
                                                    <dx:GridViewDataTextColumn FieldName="TYPE_STATION" Caption="Station Type" Width="80%" meta:resourcekey="GridViewDataTextColumnResource11">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_STYPE" Visible="false" meta:resourcekey="GridViewDataTextColumnResource12"></dx:GridViewDataTextColumn>

                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                        </div>
                    </div>

                    <%--########################################## SMS Settings ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabSMSSettings">
                        <div id="tabSMSSettings">
                            <div id="divSMSSettings" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="lblSMSSettings" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrSMSSett")%></h3>
                                <div class="ui form" style="width: 100%;">
                                    <div class="four fields">
                                        <div class="field" style="width: 180px">
                                            <asp:Label ID="lblSMSMailServer" runat="server" Text="SMS Mail Server" meta:resourcekey="lblSMSMailServerResource1"></asp:Label>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:TextBox ID="txtSMSMailServer" padding="0em" runat="server" meta:resourcekey="txtSMSMailServerResource1"></asp:TextBox>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:Label ID="lblSMSPrefix" runat="server" Text="SMS Prefix" meta:resourcekey="lblSMSPrefixResource1"></asp:Label>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:TextBox ID="txtSMSPrefix" padding="0em" runat="server" meta:resourcekey="txtSMSPrefixResource1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="four fields">
                                        <div class="field" style="width: 180px">
                                            <asp:Label ID="lblSMSSuffix" runat="server" Text="SMS Suffix" meta:resourcekey="lblSMSSuffixResource1"></asp:Label>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:TextBox ID="txtSMSSuffix" padding="0em" runat="server" meta:resourcekey="txtSMSSuffixResource1"></asp:TextBox>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:Label ID="lblSMSCtryCode" runat="server" Text="Country Code" meta:resourcekey="lblSMSCtryCodeResource1"></asp:Label>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:TextBox ID="txtSMSCtryCode" padding="0em" runat="server" meta:resourcekey="txtSMSCtryCodeResource1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="four fields">
                                        <div class="field" style="width: 180px">
                                            <asp:Label ID="lblSMSNoChars" runat="server" Text="No of Characters in SMS Number" meta:resourcekey="lblSMSNoCharsResource1"></asp:Label>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:TextBox ID="txtSMSNoChars" padding="0em" runat="server" meta:resourcekey="txtSMSNoCharsResource1"></asp:TextBox>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:Label ID="lblSMSStartDigits" runat="server" Text="Start Digit(s) [Eg: 4/9]" meta:resourcekey="lblSMSStartDigitsResource1"></asp:Label>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:TextBox ID="txtSMSStartDigits" padding="0em" runat="server" meta:resourcekey="txtSMSStartDigitsResource1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="four fields">
                                        <div class="field" style="width: 180px">
                                            <asp:Label ID="lblSMSUseEMail" runat="server" Text="Use E-Mail address on user" meta:resourcekey="lblSMSUseEMailResource1"></asp:Label>
                                        </div>
                                        <div class="field" style="width: 180px">
                                            <asp:CheckBox ID="cbSMSUseEmail" runat="server" meta:resourcekey="cbSMSUseEmailResource1" />
                                        </div>
                                    </div>
                                </div>

                                <div style="text-align: center">
                                    <input id="btnSaveSMS" class="ui button" value='<%=GetLocalResourceObject("btnSave")%>' type="button" onclick="saveSMSSettings()" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--########################################## Department Messages ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabDeptMess">
                        <div id="tabDeptMess">
                            <div id="divDeptMess" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="lblDeptMess" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrDeptMessage")%></h3>
                                <dx:ASPxCallbackPanel ID="cbDeptMess" ClientInstanceName="cbDeptMess" runat="server" meta:resourcekey="cbDeptMessResource1">

                                    <PanelCollection>
                                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource5">
                                            <dx:ASPxGridView ID="gvDeptMess" ClientInstanceName="gvDeptMess" KeyFieldName="ID_MESSAGES" runat="server" OnBatchUpdate="gvDeptMess_BatchUpdate" OnCellEditorInitialize="gvDeptMess_CellEditorInitialize" Theme="Office2010Blue" Width="80%" CssClass="gridView" meta:resourcekey="gvDeptMessResource1">
                                                <ClientSideEvents EndCallback="OngvDeptMessEndCallback" />
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
                                                    <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButton="true" ShowDeleteButton="true" Width="20%" Caption=" " meta:resourcekey="GridViewCommandColumnResource5"></dx:GridViewCommandColumn>
                                                    <dx:GridViewDataComboBoxColumn FieldName="DPT_NAME" Caption="Department" Width="20%" meta:resourcekey="GridViewDataComboBoxColumnResource1">
                                                        <PropertiesComboBox TextField="DPT_NAME" ValueField="ID_DEPT" ValueType="System.String" ClientInstanceName="cbDepartment">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </PropertiesComboBox>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataComboBoxColumn>
                                                    <dx:GridViewDataTextColumn FieldName="COMMERCIAL_TEXT" Caption="Commercial Text" Width="40%" meta:resourcekey="GridViewDataTextColumnResource13">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="DETAIL_TEXT" Caption="Detail Text" Width="40%" meta:resourcekey="GridViewDataTextColumnResource14">
                                                        <%--<PropertiesTextEdit>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true"></ValidationSettings>
                                                            </PropertiesTextEdit>--%>
                                                        <HeaderStyle Font-Bold="True" />
                                                    </dx:GridViewDataTextColumn>

                                                    <dx:GridViewDataTextColumn FieldName="ID_MESSAGES" Visible="false" meta:resourcekey="GridViewDataTextColumnResource15"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_DEPT" Visible="false" meta:resourcekey="GridViewDataTextColumnResource16"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_DEPT" Visible="false" meta:resourcekey="GridViewDataTextColumnResource17"></dx:GridViewDataTextColumn>

                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
