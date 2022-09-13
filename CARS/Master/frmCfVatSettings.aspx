<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmCfVatSettings.aspx.vb" Inherits="CARS.frmCfVatSettings" MasterPageFile="~/MasterPage.Master" meta:resourcekey="PageResource1" %>

<%@ Register assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content runat="server" ContentPlaceHolderID="cntMainPanel" ID="Content1">
    <style type="text/css">
        .gridView .dxgvDataRow_Office2010Blue {
            height: 20px;
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

            var d = "";
            var type = "";
            var ctrlname = "";
                $('.menu .item')
                .tab()
                ; //activate the tabs

            //setTab('tabVatSett');

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
                if (tabID = "tabVatSett") {
                    cbVatCodeSettings.PerformCallback();
                }
                if (tabID = "tabSpContent") {
                    cbSpCategory.PerformCallback();
                }
            }

            $('.cTab').on('click', function (e) {
                setTab($(this));
            });


             $("#<%=txtSupplierSearch.ClientID%>").autocomplete({ 
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCfVatSettings.aspx/Supplier_Search",
                        data: "{q:'" + $("#<%=txtSupplierSearch.ClientID%>").val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($("#<%=txtSupplierSearch.ClientID%>").val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: '<%=GetLocalResourceObject("genNoRecords")%>', value: " ", val: 'new' }]);
                                
                            } else
                                response($.map(data.d, function (item) {
                                    
                                    return {
                                        label: item.SUPP_CURRENTNO + " - " + item.SUP_Name + " - " + item.SUP_CITY + " - " + item.ID_SUPPLIER,
                                        val: item.SUPP_CURRENTNO,
                                        name: item.SUP_Name,
                                        value: item.ID_SUPPLIER
                                       
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    e.preventDefault();                    
                    
                    if (i.item.val != 'new')
                    {
                        $("#<%=txtSupplierSearch.ClientID%>").val(i.item.name)
                        $('#suppname').text(i.item.name);

                        //FetchSupplierDetails(i.item.val);   
                        console.log("val=>" + i.item.val + " value=>" + i.item.value + " name=>" + i.item.name);
                        $(document.getElementById('<%=hdnSupplierId.ClientID%>')).val(i.item.value);
                        $(document.getElementById('<%=hdnSuppCurrNo.ClientID%>')).val(i.item.val);
                    }
                    else
                    {
                        $('#aspnetForm')[0].reset();                       
                        
                    }
                                      
                }
            });



        }); //end of ready



        function OnEditButtonClick(s, e) {

            var index = gvSpCatgConfig.GetFocusedRowIndex();
            var spCatgId = s.GetRowKey(e.visibleIndex); //gvSpCatgConfig.batchEditApi.GetCellValue(index, "ID_ITEM_CATG");

            GetSpCatgDetails(spCatgId);

            var spSuppCurrNo = gvSpCatgConfig.batchEditApi.GetCellValue(index, "SUPP_CURRENTNO");
            var suppId = gvSpCatgConfig.batchEditApi.GetCellValue(index, "ID_SUPPLIER");
            var suppName  = gvSpCatgConfig.batchEditApi.GetCellValue(index, "SUPPLIER");

            $(document.getElementById('<%=hdnSpCatgId.ClientID%>')).val(spCatgId);
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Edit");
            $(document.getElementById('<%=hdnSupplierId.ClientID%>')).val(suppId);
            $(document.getElementById('<%=hdnSuppCurrNo.ClientID%>')).val(spSuppCurrNo);

            $("#<%=txtSupplierSearch.ClientID%>").val(suppName);        
            
            popupSpCatg.SetHeaderText('');
            popupSpCatg.Show();

        }

      function GetSpCatgDetails(idItemCatg) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfVatSettings.aspx/GetSpCatgDetails",
                data: "{idItemCatg: '" + idItemCatg +  "'}",
                dataType: "json",
                async: false,//Very important
                success: function (data) {
                    if (data.d.length > 0) {
                        console.log(data.d[0]);
                        $('#<%=txtSupplierSearch.ClientID%>').val(data.d[0].SUP_Name);
                        txtAccntCode.SetText(data.d[0].ACCOUNT_CODE);
                        txtCatg.SetText(data.d[0].CATEGORY);
                         txtDesc.SetText(data.d[0].DESCRIPTION);
                                           

                        if (data.d[0].ID_VAT_CODE == 0) {
                           cbVatCode.SetValue('0');
                        }
                        else {
                            cbVatCode.SetValue(data.d[0].ID_VAT_CODE);
                        }
                        

                        if (data.d[0].FLG_ALLOW_BCKORD == true) {
                            $("#<%=chkAllBO.ClientID%>").attr('checked', true);
                        } else {
                            $("#<%=chkAllBO.ClientID%>").attr('checked', false);
                        }

                        if (data.d[0].FLG_CNT_STOCK == true) {
                            $("#<%=chkCntStock.ClientID%>").attr('checked', true);
                        } else {
                            $("#<%=chkCntStock.ClientID%>").attr('checked', false);
                        }

                        if (data.d[0].FLG_ALLOW_CLASSIFICATION == true) {
                            $("#<%=chkAllClass.ClientID%>").attr('checked', true);
                        } else {
                            $("#<%=chkAllClass.ClientID%>").attr('checked', false);
                        }

                    }
                }
            });
        }

        
        function OncbspCatgGridEndCallback(s, e) {
            type = '<%=GetLocalResourceObject("hdrSpareContent")%>';
            //console.log(spCatgGrid.cpSaveStrVal);
            console.log(spCatgGrid.cpDelStrVal);

            if (spCatgGrid.cpSaveStrVal != undefined && spCatgGrid.cpSaveStrVal.length > 0) {

                if (spCatgGrid.cpSaveStrVal[0] == "UPDATED") {
                    systemMSG('success', `<%=GetLocalResourceObject("genUpdSuccess")%>`, 6000);
                }
                else if (spCatgGrid.cpSaveStrVal[0] == "INSERTED") {
                    systemMSG('success', `<%=GetLocalResourceObject("genInsSuccess")%>`, 6000);
                }
                else if (spCatgGrid.cpSaveStrVal[0] == "AEXISTS") {
                    systemMSG('error', '<%=GetLocalResourceObject("errOprFail")%>', 6000);
                }
                else if (spCatgGrid.cpSaveStrVal[0].tostring() == "false") {
                    systemMSG('error', spCatgGrid.cpSaveStrVal[1],6000)
                }
            }

            if (spCatgGrid.cpDelStrVal != undefined) {
                if (spCatgGrid.cpDelStrVal[0] == "DELETED") {
                    //lblErrorMsg.SetText('Record sucessfully deleted');
                    systemMSG('success', `<%=GetLocalResourceObject("genDelSuccess")%>`, 6000);
                }
            }
        }
        function OnCancelBtnClick(s, e) {
            $("#<%=txtSupplierSearch.ClientID%>").val('');
            txtCatg.SetText('');
            txtDesc.SetText('');
            txtAccntCode.SetText('');

            $("#<%=chkAllBO.ClientID%>").attr('checked', false);
            $("#<%=chkCntStock.ClientID%>").attr('checked', false);
            $("#<%=chkAllClass.ClientID%>").attr('checked', false);
            popupSpCatg.Hide();
        }

        function OnSaveBtnClick(s, e) {
            if (!fnValidateSPContent()) {
                return;
            }
            var vatC = cbVatCode.GetValue();
             $(document.getElementById('<%=hdnVatCodeId.ClientID%>')).val(cbVatCode.GetValue());
            spCatgGrid.PerformCallback("SAVE");
            popupSpCatg.Hide();
        }

        function AddSpCatg() {
            popupSpCatg.SetHeaderText('');
            $(document.getElementById('<%=hdnSpCatgId.ClientID%>')).val("0");
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Add");           
            $("#<%=txtSupplierSearch.ClientID%>").val('');
            txtCatg.SetText('');
            txtDesc.SetText('');
            txtAccntCode.SetText('');
            cbVatCode.SetValue(0);
            $("#<%=chkAllBO.ClientID%>").attr('checked', false);
            $("#<%=chkCntStock.ClientID%>").attr('checked', false);
            $("#<%=chkAllClass.ClientID%>").attr('checked', false);
             popupSpCatg.Show();
        }

        function DeleteSpCatg() {
              var selectedList = gvSpCatgConfig.GetSelectedKeysOnPage();
                var resultmsg = "";
                if (selectedList.length > 0) {
                    swal({
                        title: '<%=GetLocalResourceObject("genDelCnf")%>' ,
                        text: '<%=GetLocalResourceObject("genDelWar")%>',
                        icon: "warning",
                        buttons: ['Cancel', 'Ok'],

                    })
                        .then((willDelete) => {
                            if (willDelete) {
                                var ids = "";
                                for (var i = 0; i < selectedList.length; i++) {
                                    ids += selectedList[i] + " ";
                                    spCatgId = selectedList[i];
                                    spCatgGrid.PerformCallback("DELETE;" + spCatgId);
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
        function saveVATCodeSett() {
            if (fnValidVatSettData()) {
                cbVatSettingGrid.PerformCallback("SAVE");
                popupVatSetting.Hide();
            }
        }
        function OnVatSettEditButtonClick(s, e) {
            popupVatSetting.SetHeaderText('');
            $('#<%=hdnMode.ClientID%>').val("Edit");
            var vatCodeId = gvVatSettings.GetRowKey(e.visibleIndex);
            $('#<%=hdnVATCodeId.ClientID%>').val(vatCodeId)
            var vatCodeItem= gvVatSettings.batchEditApi.GetCellValue(e.visibleIndex, "VatCodeonItem");
            var vatCodeCust = gvVatSettings.batchEditApi.GetCellValue(e.visibleIndex, "VatCodeonCust");
            var vatCodeOrder = gvVatSettings.batchEditApi.GetCellValue(e.visibleIndex, "VatCodeonOrderLine");
            var vatCodevehicle = gvVatSettings.batchEditApi.GetCellValue(e.visibleIndex, "VatCodeonVehicle");
            var vatCodeAccountCode = gvVatSettings.batchEditApi.GetCellValue(e.visibleIndex, "vat_AccCode");

            if (vatCodeItem == undefined || vatCodeItem == "") {
                ddlVATCodeProdGrp.SetValue("0");
            }
            else {
                ddlVATCodeProdGrp.SetText(vatCodeItem);
            }

            if (vatCodeCust == undefined || vatCodeCust == "") {
                ddlVATCodeCustGrp.SetValue("0");
            }
            else {
                ddlVATCodeCustGrp.SetText(vatCodeCust);
            }

            if (vatCodeOrder == undefined || vatCodeOrder == "") {
                ddlVATCodeOrdLine.SetValue("0");
            }
            else {
                ddlVATCodeOrdLine.SetText(vatCodeOrder);
            }

            if (vatCodevehicle == undefined || vatCodevehicle == "") {
                ddlVATCodeVeh.SetValue("0");
            }
            else {
                ddlVATCodeVeh.SetText(vatCodevehicle);
            }
            
            txtAccountCode.SetText(vatCodeAccountCode);
            popupVatSetting.Show();
        }
        function addVATCodeSett() {
            popupVatSetting.SetHeaderText('');
            $('#<%=hdnVATCodeId.ClientID%>').val("");
            ddlVATCodeProdGrp.SetValue(0);
            ddlVATCodeCustGrp.SetValue(0);
            ddlVATCodeOrdLine.SetValue(0);
            ddlVATCodeVeh.SetValue(0);
            txtAccountCode.SetText("");
            $('#<%=hdnMode.ClientID%>').val("Add");
            popupVatSetting.Show();
        }

        function cancelVATCodeSett() {
            ddlVATCodeProdGrp.SetValue(0);
            ddlVATCodeCustGrp.SetValue(0);
            ddlVATCodeOrdLine.SetValue(0);
            ddlVATCodeVeh.SetValue(0);
            txtAccountCode.SetText("");
            popupVatSetting.Hide();
        }
        function delVATCodeSett() {
            var selectedList = gvVatSettings.GetSelectedKeysOnPage();
            var vatCodeId = "";
            if (selectedList.length > 0) {
                swal({
                    title: '<%=GetLocalResourceObject("genDelCnf")%>',
                    text: '<%=GetLocalResourceObject("genDelWar")%>',
                    icon: "warning",
                    buttons: ['Cancel', 'Ok'],

                })
                    .then((willDelete) => {
                        if (willDelete) {
                            var ids = "";
                            for (var i = 0; i < selectedList.length; i++) {
                                ids += selectedList[i] + " ";
                                vatCodeId = selectedList[i];
                                console.log(vatCodeId);
                                cbVatSettingGrid.PerformCallback("DELETE;" + vatCodeId);
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
        function OncbVatCodeSettGridEndCallback(s, e) {
            //console.log(s.cpVatCodeRetStr[0]);
            //console.log(s.cpVatCodeRetStr);
            type = '<%=GetLocalResourceObject("hdrVatSetting")%>';
            //if (e.command == 'UPDATEEDIT') {
            if (s.cpVatCodeRetStr != undefined && s.cpVatCodeRetStr.length > 0) {
                if (s.cpVatCodeRetStr[0] == "SAVED") {
                    systemMSG('success', `<%=GetLocalResourceObject("genInsSuccess")%>`, 6000);
                }
                else if (s.cpVatCodeRetStr[0] == "UPDATED") {
                    systemMSG('success', `<%=GetLocalResourceObject("genUpdSuccess")%>`, 6000);

                }
                else if (s.cpVatCodeRetStr[0] == "DEL") {
                    systemMSG('success', `<%=GetLocalResourceObject("genDelSuccess")%>`, 6000);
                }
                else {
                    systemMSG('error', '<%=GetLocalResourceObject("errOprFail")%>', 6000);
                }
                    
                }
            //}
        }
        function OnVatCodeEditButtonClick(s, e) {
            popupVatCode.SetHeaderText('');
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Edit");
            var vatCodeId = gvVatCode.GetRowKey(e.visibleIndex);
            $('#<%=hdnVATCodeId.ClientID%>').val(vatCodeId);
            var vatDesc = gvVatCode.batchEditApi.GetCellValue(e.visibleIndex, "DESCRIPTION");
            var vatPer = gvVatCode.batchEditApi.GetCellValue(e.visibleIndex, "VAT_PERCENTAGE");
            var extVatCode = gvVatCode.batchEditApi.GetCellValue(e.visibleIndex, "EXT_VAT_CODE");
            var extAccCode = gvVatCode.batchEditApi.GetCellValue(e.visibleIndex, "EXT_ACC_CODE");

            
            txtVATCode.SetText(vatDesc);
            txtVatPercentage.SetText(vatPer);
            txtExtVAT.SetText(extVatCode);
            txtExtAcc.SetText(extAccCode);

            txtVATCode.SetEnabled(false);
            popupVatCode.Show();
        }
        function addVATCode() {
            popupVatCode.SetHeaderText('');
            popupVatCode.Show();
            $('#<%=hdnVATCodeId.ClientID%>').val("");
            txtVATCode.SetText("");
            txtVatPercentage.SetText("");
            txtExtVAT.SetText("");
            txtExtAcc.SetText("");
            $(document.getElementById('<%=hdnMode.ClientID%>')).val("Add");
            txtVATCode.SetFocus();
            txtVATCode.SetEnabled(true);
        }
        function saveVATCode() {
            if (!fnValidateVATCode()) {
                return;
            }
           var seperator = '<%= Session("Decimal_Seperator") %>';
            var vatPer = txtVatPercentage.GetText();
            //console.log(fnformatDecimalValue(vatPer, seperator));
            $(document.getElementById('<%=hdnVatPercent.ClientID%>')).val(fnformatDecimalValue(vatPer, seperator));
            cbVatCodeGrid.PerformCallback("SAVE");
            popupVatCode.Hide();
        }
        function delVATCode() {
            var selectedList = gvVatCode.GetSelectedKeysOnPage();
            var vatCodeId = "";
            if (selectedList.length > 0) {
                swal({
                    title: '<%=GetLocalResourceObject("genDelCnf")%>',
                    text: '<%=GetLocalResourceObject("genDelWar")%>',
                    icon: "warning",
                    buttons: ['Cancel', 'Ok'],

                })
                    .then((willDelete) => {
                        if (willDelete) {
                            var ids = "";
                            for (var i = 0; i < selectedList.length; i++) {
                                ids += selectedList[i] + " ";
                                vatCodeId = selectedList[i];
                                console.log(vatCodeId);
                                cbVatCodeGrid.PerformCallback("DELETE;" + vatCodeId);
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
        function OncbVatCodeGridEndCallback(s, e) {
            //console.log(s.cpVatCodeSaveStr);
            //console.log(s.cpVatCodeDelStr);
            type = '<%=GetLocalResourceObject("hdrVatCode")%>';
            if (s.cpVatCodeSaveStr != null && s.cpVatCodeSaveStr.length > 0) {
                if (s.cpVatCodeSaveStr.RetVal_Saved != "" || s.cpVatCodeSaveStr .RetVal_NotSaved == "") {
                    systemMSG('success', `<%=GetLocalResourceObject("genSaveSuccess")%>`, 6000);
                }
            }

            if (s.cpVatCodeDelStr != undefined &&s.cpVatCodeDelStr.length > 0) {
                if (s.cpVatCodeDelStr[0] == "DEL") {
                    systemMSG('success', `<%=GetLocalResourceObject("genDelSuccess")%>`, 6000);
                }
                else if (s.cpVatCodeDelStr[0] == "NDEL") {
                    systemMSG('error', '<%=GetLocalResourceObject("errVATCodeInUse")%>', 6000);
                }
            }

        }
        function cancelVATCode() {
            txtVATCode.SetText("");
            txtVatPercentage.SetText("");
            txtExtVAT.SetText("");
            txtExtAcc.SetText("");
            popupVatCode.Hide();
            txtVATCode.SetEnabled(true);
        }
        function fnValidVatSettData() {
            
            if (ddlVATCodeCustGrp.GetValue() == "0") {
                //var msg = GetMultiMessage('0007', GetMultiMessage('0154', '', ''), '');
                var msg = '<%=GetLocalResourceObject("errSelVATCust")%>';
                swal(msg);
                return false;
            }

            if (ddlVATCodeOrdLine.GetValue() == "0") {
                //var msg = GetMultiMessage('0007', GetMultiMessage('VATONLINE', '', ''), '');
                var msg = '<%=GetLocalResourceObject("errSelVATOdr")%>';
                swal(msg);
                return false;
            }

           <%-- if (!(gfi_CheckEmpty($('#<%=txtAccountCode.ClientID%>'), '0788', ''))) {
                return false;
            }--%>

            ctrlname = '<%=GetLocalResourceObject("lblAccCodeResource1.Text")%>'; 
            //console.log('<%=GetLocalResourceObject("lblAccCodeResource1.Text")%>')
            if (txtAccountCode.GetText() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                return false;
            }
            return true;
        }

        function fnValidateVATCode() {
            ctrlname = '<%=GetLocalResourceObject("lblVATCodeResource1.Text")%>';
            if (txtVATCode.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                txtVATCode.SetFocus();
                return false;
            }

            if (!validateAlphabets(txtVATCode.GetText())) {
                swal(`<%=GetLocalResourceObject("errInvalid")%>`);
                txtVATCode.SetFocus();
                return false;
            }
            var gmr;
            gmr = txtVatPercentage.GetText();

            ctrlname = '<%=GetLocalResourceObject("lblVatPercentageResource1.Text")%>';
            if (txtVatPercentage.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                return false;
            }
            if (!fn_ValidateDecimalValue(txtVatPercentage.GetText(), '<%= Session("Decimal_Seperator") %>')) {
                swal(`<%=GetLocalResourceObject("errInvalid")%>`);
                txtVatPercentage.SetFocus();
                return false;
            }

            if (gmr > 100 || gmr == '.') {
                swal(`<%=GetLocalResourceObject("errInvalid")%>`);
                return false;
            }
            if (txtExtVAT.GetText() != "") {
                if (!validateNumerics(txtExtVAT.GetText())) {
                    swal('<%=GetLocalResourceObject("errNumVATCode")%>');
                    txtExtVAT.SetFocus();
                    return false;
                }
            }
            ctrlname = '<%=GetLocalResourceObject("lblExtAccCodeResource1.Text")%>';
            if (txtExtAcc.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                txtExtAcc.SetFocus();
                return false;
            }

            return true;

        }
        function fnValidateSPContent() {
            ctrlname = '<%=GetLocalResourceObject("lblSuppCurrNoResource1.Text")%>';
            if ($('#<%=txtSupplierSearch.ClientID%>').val().trim() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                return false;
            }
            <%--if (!validateAlphabets($('#<%=txtSupplierSearch.ClientID%>').val())) {
                swal("Invalid Supp Curr No !");
                return false;
            }--%>

            ctrlname = '<%=GetLocalResourceObject("lblCatgResource1.Text")%>';
            if (!validateAlphabets(txtCatg.GetText())) {
                swal(`<%=GetLocalResourceObject("errInvalid")%>`);
                return false;
            }

            if (txtCatg.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                return false;
            }
            
            ctrlname = '<%=GetLocalResourceObject("lblDescResource1.Text")%>';
            if (txtDesc.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                return false;
            }

            if (!validateAlphabets(txtDesc.GetText())) {
                swal(`<%=GetLocalResourceObject("errInvalid")%>`);
                return false;
            }
  
            if (cbVatCode.GetSelectedIndex() == 0) {
                swal('<%=GetLocalResourceObject("errSelVATCode")%>');
                return false;
            }

            ctrlname = '<%=GetLocalResourceObject("lblAccntCodeResource1.Text")%>';
            if (txtAccntCode.GetText().trim() == "") {
                swal(`<%=GetLocalResourceObject("errCntEmpty")%>`);
                return false;
            }
            if (!validateAlphabets(txtAccntCode.GetText())) {
                swal(`<%=GetLocalResourceObject("errInvalid")%>`);
                return false;
            }
            
            return true;

        }
        function validateAlphabets(value){
            var isValid = false;
            var regex = /^[a-zA-Z0-9 -&]*$/;
            isValid = regex.test(value);
            return isValid;
        }
        function validateNumerics(value) {
            var isValid = false;
            var regex = /^[0-9]+$/;
            isValid = regex.test(value);
            return isValid;
        }
    </script>

     <div>
      <div id="systemMessage" class="ui message"> </div>
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
        <asp:HiddenField ID="hdnPageSize" runat="server" Value="5" />
        <asp:HiddenField ID="hdnSelect" runat="server" />
        <asp:HiddenField ID="hdnEditCap" runat="server" Value="Edit" />
        <asp:HiddenField ID="hdnMode" runat="server" />
        <asp:HiddenField ID="hdnSpCatgId" runat="server" />
        <asp:HiddenField ID="hdnSupplierId" runat="server" />
         <asp:HiddenField ID="hdnVatCodeId" runat="server" />
          <asp:HiddenField ID="hdnSuppCurrNo" runat="server" />
        <asp:HiddenField ID="hdnVatPercent" runat="server" />
    </div>

    <div>
        <div class="ui one column grid">
            <div class="stretched row">
                <div class="sixteen wide column">
                    <div class="ui top attached tabular menu">
                        <a class="cTab item active" data-tab="tabVatSett"><%=GetLocalResourceObject("hdrVatSetting")%></a>
                        <a class="cTab item" data-tab="tabVat"><%=GetLocalResourceObject("hdrVatCode")%></a>
                        <a class="cTab item" data-tab="tabSpContent"><%=GetLocalResourceObject("hdrSpareContent")%></a>
                    </div>

                     <%--########################################## Vat Settings ##########################################--%>
                     <div class="ui bottom attached tab segment active" data-tab="tabVatSett">                        
                         <div id="tabVatSettings">
                             <div id="divVatSett" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                 <h3 id="lblVatSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrVatSetting")%></h3>
                                 <%--<asp:Label ID="lblTimeFormat" runat="server" Text="Time Format"></asp:Label>--%>
                                  <div class="ui one column grid">
                                    <div class="stretched row">
                                        <div class="sixteen wide column">
                                            <dx:ASPxCallbackPanel ID="cbVatSettingGrid" ClientInstanceName="cbVatSettingGrid" runat="server" OnCallback="cbVatSettingGrid_Callback" meta:resourcekey="cbVatSettingGridResource1">
                                                <ClientSideEvents EndCallback="OncbVatCodeSettGridEndCallback" />
                                                <PanelCollection>
                                                    <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">

                                                        <dx:ASPxGridView runat="server" ID="gvVatSettings" ClientInstanceName="gvVatSettings" Style="-moz-border-radius: 10px; border-radius: 10px;" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID_VAT_SEQ" Theme="Office2010Blue" CssClass="gridView" meta:resourcekey="gvVatSettingsResource1">
                                                            <SettingsEditing Mode="Batch"></SettingsEditing>
                                                            <ClientSideEvents CustomButtonClick="OnVatSettEditButtonClick" />
                                                            <SettingsSearchPanel Visible="True" />
                                                            
                                                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                            <SettingsPopup>
                                                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                            </SettingsPopup>
                                                            <Styles>
                                                                <FocusedRow BackColor="#d6eef2" ForeColor="Black"></FocusedRow>                                                                
                                                            </Styles>
                                                           
                                                            <Settings ShowPreview="false" ShowStatusBar="Hidden" />
                                                            <Columns>
                                                                <%--<dx:GridViewCommandColumn VisibleIndex="0" ShowNewButton="true" ShowEditButton="true" ShowDeleteButton="true" ShowClearFilterButton="True"></dx:GridViewCommandColumn>--%>
                                                                <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" width="2%" meta:resourcekey="GridViewCommandColumnResource1"/>
                                                                <dx:GridViewDataTextColumn FieldName="ID_VAT_SEQ" Visible="false" meta:resourcekey="GridViewDataTextColumnResource1"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VatCodeonItem" Caption="VAT Code on Product Group" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource2">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VatCodeonCust" Caption="VAT Code on Customer Group" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource3">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VatCodeonVehicle" Caption="VAT Code on Vehicle" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource4">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VatCodeonOrderLine" Caption="VAT Code on Order line" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource5">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="vat_AccCode" Caption="Account code" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource6">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataDateColumn FieldName="LastChangedon" Caption="Last changed on" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataDateColumnResource1">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataTextColumn FieldName="LastChangedby" Caption="Last changed by" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource7">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="STATUS" Caption="Status" ReadOnly="true" Width="5%" Visible="false" meta:resourcekey="GridViewDataTextColumnResource8"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewCommandColumn VisibleIndex="10" Width="5%" Caption=" " meta:resourcekey="GridViewCommandColumnResource2">
                                                                    <CustomButtons>
                                                                        <dx:GridViewCommandColumnCustomButton ID="btnEditVatSett" Styles-Style-CssClass="" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource1"></dx:GridViewCommandColumnCustomButton>
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
                                </div>      
                             </div>
                             <p></p>
                            <div class="six fields">
                                <div style="text-align: center">
                                    <input id="btnAddVATCodeSett" class="ui button blue" type="button" value='<%=GetLocalResourceObject("btnAdd")%>' onclick="addVATCodeSett()" />
                                    <input id="btnDelVATCodeSett" class="ui button red" type="button" value='<%=GetLocalResourceObject("btnDelete")%>' onclick="delVATCodeSett()" />
                                </div>
                            </div>
                         </div>                       
                     </div>

                    <%--########################################## Vat Code ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabVat">
                        <div id="tabVatC">
                            <div id="divVatC"  class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                 <h3 id="lblVatC" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrVatCode")%></h3>
                                 <div class="ui one column grid">
                                    <div class="stretched row">
                                        <div class="sixteen wide column">
                                            <dx:ASPxCallbackPanel ID="cbVatCodeGrid" ClientInstanceName="cbVatCodeGrid" runat="server" OnCallback="cbVatCodeGrid_Callback" meta:resourcekey="cbVatCodeGridResource1">
                                                <ClientSideEvents EndCallback="OncbVatCodeGridEndCallback" />
                                                <PanelCollection>
                                                    <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource2">

                                                        <dx:ASPxGridView runat="server" ID="gvVatCode" ClientInstanceName="gvVatCode" Style="-moz-border-radius: 10px; border-radius: 10px;" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID_SETTINGS" Theme="Office2010Blue" CssClass="gridView" meta:resourcekey="gvVatCodeResource1">
                                                            <SettingsEditing Mode="Batch"></SettingsEditing>
                                                            <ClientSideEvents CustomButtonClick="OnVatCodeEditButtonClick" />
                                                            <SettingsSearchPanel Visible="True" />
                                                            
                                                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                            <SettingsPopup>
                                                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                            </SettingsPopup>
                                                            <Styles>
                                                                <FocusedRow BackColor="#d6eef2" ForeColor="Black"></FocusedRow>                                                                
                                                            </Styles>
                                                           
                                                            <Settings ShowPreview="false" ShowStatusBar="Hidden" />
                                                            <Columns>
                                                                <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" width="10%" meta:resourcekey="GridViewCommandColumnResource3"/>
                                                                <dx:GridViewDataTextColumn FieldName="ID_SETTINGS" Visible="false" meta:resourcekey="GridViewDataTextColumnResource9"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" ReadOnly="true" Width="20%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource10">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VAT_PERCENTAGE" Caption="VAT %" ReadOnly="true" Width="20%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource11">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="EXT_VAT_CODE" Caption="Ext VAT Code" ReadOnly="true" Width="15%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource12">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="EXT_ACC_CODE" Caption="Ext Accnt Code" ReadOnly="true" Width="15%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource13">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataDateColumn FieldName="ID_CONFIG" ReadOnly="true" Visible="false" meta:resourcekey="GridViewDataDateColumnResource2"></dx:GridViewDataDateColumn>
                                                                <dx:GridViewCommandColumn VisibleIndex="10" Width="10%" Caption=" " meta:resourcekey="GridViewCommandColumnResource4">
                                                                    <CustomButtons>
                                                                        <dx:GridViewCommandColumnCustomButton ID="btnEditVatCode" Styles-Style-CssClass="" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource2"></dx:GridViewCommandColumnCustomButton>
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
                                </div>
                            </div>
                            <p></p>
                            <div class="six fields">
                                <div style="text-align: center">
                                <input id="btnAddVATCode" type="button" value='<%=GetLocalResourceObject("btnAdd")%>' class="ui button blue" onclick="addVATCode()"/>
                                <input id="btnDelVATCode" type="button" value='<%=GetLocalResourceObject("btnDelete")%>' class="ui button red" onclick="delVATCode()"/>
                            </div>
                                </div>
                        </div>
                    </div>

                    <%--########################################## Spare Part ##########################################--%>
                    <div class="ui bottom attached tab segment" data-tab="tabSpContent">
                        <div id="tabSpareContent">
                            <div id="divSpContent" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                 <h3 id="H2" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrSpareContent")%></h3>
                                <div class="ui one column grid">
                                    <div class="stretched row">
                                        <div class="sixteen wide column">
                                            <dx:ASPxCallbackPanel ID="spCatgGrid" ClientInstanceName="spCatgGrid" runat="server" OnCallback="spCatgGrid_Callback" meta:resourcekey="spCatgGridResource1">
                                                <ClientSideEvents EndCallback="OncbspCatgGridEndCallback" />
                                                <PanelCollection>
                                                    <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource3">

                                                        <dx:ASPxGridView runat="server" ID="gvSpCatgConfig" ClientInstanceName="gvSpCatgConfig" Style="-moz-border-radius: 10px; border-radius: 10px;" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID_ITEM_CATG" Theme="Office2010Blue" CssClass="gridView" meta:resourcekey="gvSpCatgConfigResource1">
                                                            <SettingsEditing Mode="Batch"></SettingsEditing>
                                                            <ClientSideEvents CustomButtonClick="OnEditButtonClick" />
                                                            <SettingsSearchPanel Visible="True" />
                                                            
                                                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                            <SettingsPopup>
                                                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                            </SettingsPopup>
                                                            <Styles>
                                                                <FocusedRow BackColor="#d6eef2" ForeColor="Black"></FocusedRow>                                                                
                                                            </Styles>
                                                           
                                                            <Settings ShowPreview="false" ShowStatusBar="Hidden" />
                                                            <Columns>
                                                                <%--<dx:GridViewCommandColumn VisibleIndex="0" ShowNewButton="true" ShowEditButton="true" ShowDeleteButton="true" ShowClearFilterButton="True"></dx:GridViewCommandColumn>--%>
                                                                <dx:GridViewCommandColumn ShowSelectCheckbox="true" SelectAllCheckboxMode="Page" meta:resourcekey="GridViewCommandColumnResource5" />
                                                                <dx:GridViewDataTextColumn FieldName="ID_ITEM_CATG" Visible="false" meta:resourcekey="GridViewDataTextColumnResource14"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ID_SUPPLIER" Caption="Supplier ID" ReadOnly="true" Width="5%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource15">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="SUPPLIER" Caption="Supplier Name" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource16">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="CATEGORY" Caption="Category" ReadOnly="true" Width="5%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource17">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="DESCRIPTION" Caption="Description" ReadOnly="true" Width="20%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource18">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VATCODE" Caption="Vatcode" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource19">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ID_VATCODE" Caption="ID_VAT_CODE" ReadOnly="true" Width="10%" Visible="false" meta:resourcekey="GridViewDataTextColumnResource20"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ACCOUNTCODE" Caption="Account Code" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource21">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="FLG_COUNTSTOCK" Caption="Count Stock" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource22">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="FLG_ALLOWBO" Caption="Allow Backord" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource23">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="FLG_ALLOWCLASS" Caption="Allow Classification" ReadOnly="true" Width="10%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource24">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="SUPP_CURRENTNO" Caption="Supp Curr No" ReadOnly="true" Width="6%" HeaderStyle-Font-Bold="true" meta:resourcekey="GridViewDataTextColumnResource25">
<HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                 <dx:GridViewDataTextColumn FieldName="FLG_ALLOWBO_L" Caption="FLG_ALLOWBO_L" ReadOnly="true" Width="6%" Visible="false" meta:resourcekey="GridViewDataTextColumnResource26"></dx:GridViewDataTextColumn>
                                                                 <dx:GridViewDataTextColumn FieldName="FLG_COUNTSTOCK_L" Caption="FLG_COUNTSTOCK_L" ReadOnly="true" Width="6%" Visible="false" meta:resourcekey="GridViewDataTextColumnResource27"></dx:GridViewDataTextColumn>
                                                                 <dx:GridViewDataTextColumn FieldName="FLG_ALLOWCLASS_L" Caption="FLG_ALLOWCLASS_L" ReadOnly="true" Width="6%" Visible="false" meta:resourcekey="GridViewDataTextColumnResource28"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewCommandColumn VisibleIndex="11" Width="10%" Caption=" " meta:resourcekey="GridViewCommandColumnResource6">
                                                                    <CustomButtons>
                                                                        <dx:GridViewCommandColumnCustomButton ID="btnEditSpCatg" Styles-Style-CssClass="" Text="Edit" meta:resourcekey="GridViewCommandColumnCustomButtonResource3"></dx:GridViewCommandColumnCustomButton>
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
                                </div>

                            </div>
                            <p></p>
                            <div class="six fields">
                                <div style="text-align: center">
                                    <input id="btnAddSpCatg" class="ui button blue" type="button" value='<%=GetLocalResourceObject("btnAdd")%>' onclick="AddSpCatg()" />
                                    <input id="btnDeleteSpCatg" class="ui button red" type="button" value='<%=GetLocalResourceObject("btnDelete")%>' onclick="DeleteSpCatg()" />
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <div>
        <dx:ASPxPopupControl runat="server" ID="popupSpCatg" ClientInstanceName="popupSpCatg" PopupHorizontalAlign="Center" Modal="True" PopupVerticalAlign="Middle" Top="200" Left="400" Width="900px" Height="400px" ScrollBars="Vertical" CloseAction="CloseButton" Theme="Office365" meta:resourcekey="popupSpCatgResource1">
             <%--<ClientSideEvents Closing="OnpopupImportConfigClosing" />--%>
             <ContentCollection>
                 <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource1">
                    
                     <div class="sixteen wide column">
                         <div>
                             <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                                <a id="A3" runat="server" class="active item"><%=GetLocalResourceObject("hdrSpareContent")%></a>
                            </div>
                            <div class="ui form">
                                <div class="inline fields">
                                     <div class="seven wide column">
                                          <div class="ui form">

                                             <div class="inline fields">
                                                  <div class="six wide field">
                                                      <asp:Label ID="lblSuppCurrNo" runat="server" Text="Supp Curr No" meta:resourcekey="lblSuppCurrNoResource1" ></asp:Label> <span class="mand">*</span>
                                                  </div>
                                                  <div class="eight wide field">
                                                      <%--<dx:ASPxTextBox ID="txtSuppCurrNo" ClientInstanceName="txtSuppCurrNo" CssClass="customComboBox" runat="server"  Width="300px"></dx:ASPxTextBox>--%>
                                                      <input type="text" placeholder="Søk leverandør" id="txtSupplierSearch" style="width:190px" runat="server"/>
                                                  &nbsp;</div>
                                              </div>                                           

                                             <div class="inline fields">
                                                 <div class="six wide field">
                                                     <asp:Label ID="lblCatg" runat="server" Text="Category" meta:resourcekey="lblCatgResource1"></asp:Label> <span class="mand">*</span>
                                                 </div>
                                                 <div class="eight wide field">
                                                     <dx:ASPxTextBox ID="txtCatg" ClientInstanceName="txtCatg" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtCatgResource1"></dx:ASPxTextBox>
                                                 </div>
                                             </div>
                                            <dx:ASPxCallbackPanel ID="cbSpCategory" ClientInstanceName="cbSpCategory" runat="server" OnCallback="cbSpCategory_Callback">
                                                <PanelCollection>
                                                    <dx:PanelContent runat="server">
                                             <div class="inline fields">
                                                 <div class="six wide field">
                                                     <asp:Label ID="lblVC" runat="server" Text="VAT Code" meta:resourcekey="lblVCResource1"></asp:Label> <span class="mand">*</span>
                                                 </div>
                                                 <div class="eight wide field">
                                                     <dx:ASPxComboBox ID="cbVatCode" ClientInstanceName="cbVatCode" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="cbVatCodeResource1"></dx:ASPxComboBox>
                                                 </div>
                                             </div>
                                                    </dx:PanelContent>
                                                </PanelCollection>
                                            </dx:ASPxCallbackPanel>
                                         </div>
                                      <div class="ui form">
                                               <div class="inline fields">
                                                 <div class="six wide field">
                                                    <asp:Label ID="lblCntStock" runat="server" Text="Count Stock" meta:resourcekey="lblCntStockResource1"></asp:Label>
                                                 </div>
                                                 <div class="eight wide field">
                                                     <asp:CheckBox ID="chkCntStock" runat="server" Style="display: inline-block;height:35px;padding-top:10px" meta:resourcekey="chkCntStockResource1"/>    
                                                 </div>
                                             </div>
                                         </div>

                                     </div>
                                    <div class="seven wide column">
                                        <div class="ui form">                                            

                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblDesc" runat="server" Text="Description" meta:resourcekey="lblDescResource1"></asp:Label><span class="mand">*</span>
                                                </div>
                                                <div class="eight wide field">
                                                   <dx:ASPxTextBox ID="txtDesc" ClientInstanceName="txtDesc" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtDescResource1" ></dx:ASPxTextBox>
                                                </div>
                                            </div>

                                            <div class="inline fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblAccntCode" runat="server" Text="Account Code" meta:resourcekey="lblAccntCodeResource1" ></asp:Label> <span class="mand">*</span>
                                                </div>
                                                <div class="eight wide field">
                                                     <dx:ASPxTextBox ID="txtAccntCode" ClientInstanceName="txtAccntCode" runat="server" CssClass="customComboBox" Width="300px" meta:resourcekey="txtAccntCodeResource1" ></dx:ASPxTextBox>
                                                </div>
                                            </div>

                                            <div class="inline fields">
                                                  <div class="six wide field">
                                                      <asp:Label ID="lblAllBO" runat="server" Text="Allow Back Order" meta:resourcekey="lblAllBOResource1" ></asp:Label>
                                                  </div>
                                                  <div class="eight wide field">
                                                      <asp:CheckBox ID="chkAllBO" runat="server" Style="display: inline-block;height:35px;padding-top:10px" meta:resourcekey="chkAllBOResource1"/>     
                                                  </div>
                                              </div>                                           

                                        </div>
                                        <div class="ui form">
                                             <div class="inline fields">
                                                 <div class="six wide field">
                                                     <asp:Label ID="lblAllClass" runat="server" Text="Allow Classification" meta:resourcekey="lblAllClassResource1"></asp:Label>
                                                 </div>
                                                 <div class="eight wide field">
                                                     <asp:CheckBox ID="chkAllClass" runat="server" Style="display: inline-block;height:35px;padding-top:10px" meta:resourcekey="chkAllClassResource1"/>    
                                                 </div>
                                             </div>
                                        </div>


                                    </div>
                                </div>
                            </div>

                         </div>

                     </div>
                     
                     <p></p>
                    <div style="text-align: center">
                        <input id="btnSave" class="ui button positive" value='<%=GetLocalResourceObject("btnSave")%>' type="button" onclick="OnSaveBtnClick()" />
                        &nbsp;<input id="btnCancel" class="ui button red" value='<%=GetLocalResourceObject("btnCancel")%>' type="button" onclick="OnCancelBtnClick()" />
                    </div>
                 </dx:PopupControlContentControl>
             </ContentCollection>
        </dx:ASPxPopupControl>
    </div>

    <div>
        <dx:ASPxPopupControl runat="server" ID="popupVatSetting" ClientInstanceName="popupVatSetting" PopupHorizontalAlign="Center" Modal="True" PopupVerticalAlign="Middle" Top="230" Left="580" Width="550px" Height="400px" ScrollBars="Vertical" CloseAction="CloseButton" Theme="Office365" meta:resourcekey="popupVatSettingResource1">
             
             <ContentCollection>
                 <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource2">
                    <dx:ASPxCallbackPanel ID="cbVatCodeSettings" ClientInstanceName="cbVatCodeSettings" runat="server" OnCallback="cbVatCodeSettings_Callback">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                    
                    <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                    <a class="active item" id="a5" runat="server" ><%=GetLocalResourceObject("hdrVatSetting")%></a>
                </div>  
                     <div class="ui form">
                         <div class="inline fields">
                             <div class="seven wide column">
                                  <div class="ui form">
                                     <div class="tewelve wide field">
                                         <asp:Label ID="lblvatcodeprogrp" runat="server" Text="VAT Code on Product Group" meta:resourcekey="lblvatcodeprogrpResource1"></asp:Label>
                                     </div>
                                     <div class="tewelve wide field">
                                         <dx:ASPxComboBox ID="ddlVATCodeProdGrp" ClientInstanceName="ddlVATCodeProdGrp" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="ddlVATCodeProdGrpResource1"></dx:ASPxComboBox>
                                     </div>
                                <p></p>
                                     <div class="tewelve wide field">
                                         <asp:Label ID="lblvatcodevech" runat="server" Text="VAT Code on Vehicle" meta:resourcekey="lblvatcodevechResource1"></asp:Label>
                                     </div>
                                     <div class="tewelve wide field">
                                         <dx:ASPxComboBox ID="ddlVATCodeVeh" ClientInstanceName="ddlVATCodeVeh" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="ddlVATCodeVehResource1"></dx:ASPxComboBox>
                                     </div>
                              <p></p>

                                     <div class="tewelve wide field">
                                         <asp:Label ID="lblAccCode" runat="server" Text="VAT Account Code" meta:resourcekey="lblAccCodeResource1"></asp:Label><span class="mand">*</span>
                                     </div>
                                     <div class="tewelve wide field">
                                         <dx:ASPxTextBox ID="txtAccountCode" ClientInstanceName="txtAccountCode" runat="server" CssClass="customComboBox" Width="195px" meta:resourcekey="txtAccountCodeResource1"></dx:ASPxTextBox>
                                     </div>
                                        </div>
                             </div>
                             <div class="seven wide column">
                                  <div class="ui form">
                                     <div class="tewelve wide field">
                                         <asp:Label ID="lblvatcustgrp" runat="server" Text="VAT Code on Customer Group" meta:resourcekey="lblvatcustgrpResource1"></asp:Label><span class="mand">*</span>
                                     </div>
                                     <div class="tewelve wide field">
                                         <dx:ASPxComboBox ID="ddlVATCodeCustGrp" ClientInstanceName="ddlVATCodeCustGrp" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="ddlVATCodeCustGrpResource1"></dx:ASPxComboBox>
                                     </div>
                                      <p></p>
                                     <div class="tewelve wide field">
                                         <asp:Label ID="lblvatordline" runat="server" Text="VAT Code on Order Line" meta:resourcekey="lblvatordlineResource1"></asp:Label><span class="mand">*</span>
                                     </div>
                                     <div class="tewelve wide field">
                                         <dx:ASPxComboBox ID="ddlVATCodeOrdLine" ClientInstanceName="ddlVATCodeOrdLine" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="195px" meta:resourcekey="ddlVATCodeOrdLineResource1"></dx:ASPxComboBox>
                                     </div>
                                      <p></p>
                                      <div class="tewelve wide field" style="height:60px">
                                         
                                     </div>
                                     </div>
                                 
                             </div>
                         </div>
                     </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
               <p></p>
                <div style="text-align:center">
                    <input id="btnSaveVATCodeSett" class="ui button positive" value='<%=GetLocalResourceObject("btnSave")%>' type="button" onclick="saveVATCodeSett()"/> 
                    &nbsp;<input id="btnCancelVATCodeSett" class="ui button red" value='<%=GetLocalResourceObject("btnCancel")%>' type="button" onclick="cancelVATCodeSett()" />
                </div> 
                 </dx:PopupControlContentControl>
             </ContentCollection>
        </dx:ASPxPopupControl>
    </div>
    <div>
        <dx:ASPxPopupControl runat="server" ID="popupVatCode" ClientInstanceName="popupVatCode" PopupHorizontalAlign="Center" Modal="True" PopupVerticalAlign="Middle" Top="220" Left="550" Width="650px" Height="300px" ScrollBars="Vertical" CloseAction="CloseButton" Theme="Office365" meta:resourcekey="popupVatCodeResource1">
             <ContentCollection>
                 <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource3">
                    
                    <div class="ui secondary vertical menu" style="width: 100%; background-color: #c9d7f1">
                        <a class="active item" id="a7" runat="server" ><%=GetLocalResourceObject("hdrVatCode")%></a>
                    </div>
                    <div class="ui form" style="width: 100%;">
                        <div class="four fields">
                            <div class="field" style="width:180px">
                                <asp:Label ID="lblVATCode" runat="server" Text="VAT Code" meta:resourcekey="lblVATCodeResource1"></asp:Label><span class="mand">*</span>
                            </div>
                            <div class="field" style="width:120px">
                                <%--<asp:TextBox ID="txtVATCode"  padding="0em" runat="server" MaxLength="3"></asp:TextBox>--%>
                                <dx:ASPxTextBox ID="txtVATCode" ClientInstanceName="txtVATCode" runat="server" CssClass="customComboBox" MaxLength="3" Width="100px" meta:resourcekey="txtVATCodeResource1"></dx:ASPxTextBox>
                            </div>    
                            <div class="field" style="width:180px">
                                <asp:Label ID="lblVatPercentage" runat="server" Text="VAT Percentage" meta:resourcekey="lblVatPercentageResource1"></asp:Label><span class="mand">*</span>
                            </div>
                            <div class="field" style="width:120px">
                                <%--<asp:TextBox ID="txtVatPercentage"  padding="0em" runat="server" MaxLength="6"></asp:TextBox>--%>
                                <dx:ASPxTextBox ID="txtVatPercentage" ClientInstanceName="txtVatPercentage" runat="server" CssClass="customComboBox" MaxLength="6" Width="100px" meta:resourcekey="txtVatPercentageResource1"></dx:ASPxTextBox>
                            </div>     
                        </div>
                         <div class="four fields">
                            <div class="field" style="width:180px">
                                <asp:Label ID="lblExtVATCode" runat="server" Text="External VAT Code" meta:resourcekey="lblExtVATCodeResource1"></asp:Label>
                            </div>
                            <div class="field" style="width:120px">
                                <%--<asp:TextBox ID="txtExtVAT"  padding="0em" runat="server" MaxLength="1"></asp:TextBox>--%>
                                <dx:ASPxTextBox ID="txtExtVAT" ClientInstanceName="txtExtVAT" runat="server" CssClass="customComboBox" MaxLength="1" Width="100px" meta:resourcekey="txtExtVATResource1"></dx:ASPxTextBox>
                            </div>  
                             <div class="field" style="width:180px">
                                <asp:Label ID="lblExtAccCode" runat="server" Text="Account Code" meta:resourcekey="lblExtAccCodeResource1"></asp:Label><span class="mand">*</span>
                            </div>
                            <div class="field" style="width:120px">
                                <%--<asp:TextBox ID="txtExtAcc"  padding="0em" runat="server" MaxLength="20"></asp:TextBox>--%>
                                <dx:ASPxTextBox ID="txtExtAcc" ClientInstanceName="txtExtAcc" runat="server" CssClass="customComboBox" MaxLength="20" Width="100px" meta:resourcekey="txtExtAccResource1"></dx:ASPxTextBox>
                            </div>     
                        </div>
                    </div> 
                    <p></p>
                    <div style="text-align:center">
                        <input id="btnSaveVATCode" class="ui button positive" value='<%=GetLocalResourceObject("btnSave")%>' type="button" onclick="saveVATCode()"/>
                        &nbsp;<input id="btnCancelVATCode" class="ui button red" value='<%=GetLocalResourceObject("btnCancel")%>' type="button" onclick="cancelVATCode()" />
                    </div>               
                
                 </dx:PopupControlContentControl>
             </ContentCollection>
        </dx:ASPxPopupControl>
    </div>
</asp:Content>