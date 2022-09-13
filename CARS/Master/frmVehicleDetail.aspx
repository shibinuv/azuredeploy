<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmVehicleDetail.aspx.vb" Inherits="CARS.frmVehicleDetail" MasterPageFile="~/MasterPage.Master" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="Server">

    <style type="text/css">
        .ui-jqgrid-disablePointerEvents {
            pointer-events: none;
        }

        .ui-jqgrid tr.ui-row-ltr td {
            text-align: center;
        }

        .context-menu-list {
            z-index: 10;
        }

        .ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover, .ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus {
            border: 1px solid #999999;
            font-weight: normal;
            color: #212121;
            background-color: white;
        }

        /*added for dialog close button..*/
        .ui-dialog .ui-dialog-titlebar-close span {
            display: block;
            margin-bottom: 0px;
            padding: 0px;
            margin-left: -9px;
            margin-top: -9px;
        }

        .ui-dialog .ui-dialog-titlebar button.ui-button:focus,
        .ui-dialog .ui-dialog-titlebar button.ui-button.ui-state-focus,
        .ui-dialog .ui-dialog-titlebar button.ui-button.ui-state-active,
        .ui-dialog .ui-dialog-titlebar button.ui-button.ui-state-hover {
            outline: none;
        }
@import url("https://fonts.googleapis.com/css?family=Inconsolata:700");
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/*.container {
  position: absolute;
  margin: auto;
  top: 0;
  left: 22%;
  bottom: -30px;
  width: 300px;
  height: 100px;
}
.container .search {
  position: absolute;
  margin: auto;
  top: 0;
  right: 0;
  bottom: 0px;
  left: 22%;
  width: 33px;
  height: 33px;
  background: #2185d0;
  border-radius: 50%;
  transition: all 1s;
  z-index: 4;
  box-shadow: 0 0 25px 0 rgba(0, 0, 0, 0.4);
}
.container .search:hover {
  cursor: pointer;
}
.container .search::before {
  content: "";
  position: absolute;
  margin: auto;
  top: 16px;
  right: 0;
  bottom: 0;
  left: 14px;
  width: 10px;
  height: 2px;
  background: white;
  transform: rotate(45deg);
  transition: all 0.5s;
}
.container .search::after {
  content: "";
  position: absolute;
  margin: auto;
  top: -2.5px;
  right: 0;
  bottom: 0;
  left: -2.5px;
  width: 9px;
  height: 9px;
  border-radius: 50%;
  border: 2px solid white;
  transition: all 0.5s;
}*/
.vehSearch {
  color: black;
  box-shadow: 0 0 25px 0 #2185d0, 0 20px 25px 0 rgba(0, 0, 0, 0.1) !important;
  transition: all 1s;
  z-index: 5;
  font-weight: bolder;
  letter-spacing: 0.1em;
}
/*.container input:hover {
  cursor: pointer;
}
.container input:focus {
  width: 200px;
  opacity: 1;
  cursor: text;
}
.container input:focus ~ .search {
  right: -250px;
  background: #151515;
  z-index: 6;
}
.container input:focus ~ .search::before {
  top: 0;
  left: 0;
  width: 25px;
}
.container input:focus ~ .search::after {
  top: 0;
  left: 0;
  width: 25px;
  height: 2px;
  border: none;
  background: white;
  border-radius: 0%;
  transform: rotate(-45deg);
}
.container input::placeholder {
  color: white;
  opacity: 0.5;
  font-weight: bolder;
}*/
   /*placeholder styling*/

   ::-webkit-input-placeholder { /* Chrome/Opera/Safari */
  color: black !important;
}
::-moz-placeholder { /* Firefox 19+ */
color: black !important;
}
:-ms-input-placeholder { /* IE 10+ */
color: black !important;
}
:-moz-placeholder { /* Firefox 18- */
 color: black !important;
}
.outerPannel {
    width: 100%;
    height: 10%;
}

/*------------------------DragNDrop css classes--------------------------*/
#drop-area {
  border: 2px dashed #ccc;
  border-radius: 20px;
  width: 400px;
  font-family: sans-serif;
  margin: 100px auto;
  padding: 20px;
}
#drop-area.highlight {
  border-color: purple;
}
p {
  margin-top: 0;
}
.my-form {
  margin-bottom: 10px;
}
#gallery {
  margin-top: 10px;
}
#gallery img {
  width: 150px;
  margin-bottom: 10px;
  margin-right: 10px;
  vertical-align: middle;
}
.button {
  display: inline-block;
  padding: 10px;
  background: #ccc;
  cursor: pointer;
  border-radius: 5px;
  border: 1px solid #ccc;
}
.button:hover {
  background: #ddd;
}
.customRadioButton{
    padding-right:10%;
    padding-left:10%;
}
.customTextBox {
    height:48px;
    border-color: #dbdbdb;
    border-radius: 6px;
}
fieldset{ 
    border-color:#dbdbdb; 
    border-radius:4px;       
}
/*#
{
  display: none;
}*/

    </style>

    <script type="text/javascript">

        /* 
            saveCustomer() :
            Function that was previously called by a "save" button.
            This button now instead shows more information of customer when clicked
            So this function is no longer being called by this button, and perhaps its not used at all?
            Lets just keep it for now
            -Koenraad
        */
        function saveCustomer() {
            var customer = {};
            $('[data-submit]').each(function (index, elem) {
                var st = $(elem).data('submit');
                var dv = $(elem).val();
                console.log(index + ' i was runned ' + st + 'and has the value of ' + dv);
                customer[st] = dv;
            });
            console.log(customer);
            console.log(customer.CUST_FIRST_NAME);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCustomerDetail.aspx/InsertCustomerDetails",
                data: "{'Customer': '" + JSON.stringify(customer) + "'}",
                dataType: "json",
                //async: false,//Very important
                success: function (data) {
                    console.log('success' + data.d);
                },
                success: function (data) {
                    if (data.d == "INSFLG") {
                        systemMSG('success', 'Kunden har blitt lagret!', 4000);
                    }
                    else if (data.d == "UPDFLG") {
                        systemMSG('success', 'Kunden har blitt oppdatert!', 4000);
                    }
                    else if (data.d == "ERRFLG") {
                        systemMSG('error', 'Det oppstod en feil ved lagring av kunde! Sjekk inndata!', 4000);
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }

        function FetchCustomerDetails() {

            $.ajax({
                type: "POST",
                url: "frmCustomerDetail.aspx/FetchCustomerDetails",
                data: "{custId: '" + $('#<%=txtCustNo.ClientID()%>').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#<%=txtCustAdd1.ClientID()%>').val(data.d[0].CUST_PERM_ADD1);
                    $('#<%=txtCustVisitZip.ClientID()%>').val(data.d[0].ID_CUST_PERM_ZIPCODE);
                    $('#<%=txtCustVisitPlace.ClientID()%>').val(data.d[0].CUST_PERM_CITY);
                    $('#<%=txtCustBillAdd.ClientID()%>').val(data.d[0].CUST_BILL_ADD1);
                    $('#<%=txtCustBillZip.ClientID()%>').val(data.d[0].ID_CUST_BILL_ZIPCODE);
                    $('#<%=txtCustBillPlace.ClientID()%>').val(data.d[0].CUST_BILL_CITY);
                    $('#<%=txtCustMail.ClientID()%>').val(data.d[0].CUST_ID_EMAIL);
                    $('#<%=txtCustFirstName.ClientID()%>').val(data.d[0].CUST_FIRST_NAME);
                    $('#<%=txtCustMiddleName.ClientID()%>').val(data.d[0].CUST_MIDDLE_NAME);
                    $('#<%=txtCustLastName.ClientID()%>').val(data.d[0].CUST_LAST_NAME);
                    $('#<%=txtCustOrgNo.ClientID()%>').val(data.d[0].CUST_SSN_NO);
                    $('#<%=txtCustPersonNo.ClientID()%>').val(data.d[0].CUST_BORN);


                    //CUST_PHONE_ALT	txtPhoneSwitchboard	txtCustSwitchboard	txtprivCustAltPhone
                    //CUST_PHONE_MOBILE	txtPhoneMobile	txtCustMobile	txtprivCustMobile
                    //CUST_FAX	txtPhoneFax	txtCustFax	txtprivCustFax
                    //CUST_PHONE_OFF	txtPhoneDirect	txtCustDirect	txtprivCustDirect
                    //CUST_PHONE_HOME	txtPhonePrivate	txtCustPrivate	txtprivCustPrivate
                    //CUST_ID_EMAIL	txtPhoneEmail	txtCustEmail	txtprivCustEmail
                    //CUST_INV_EMAIL	txtPhoneInvEmail	txtCustInvEmail	txtprivCustInvEmail
                    //CUST_HOMEPAGE	txtPhoneHomepage	txtCustHomepage	
                },
                failure: function () {
                    alert("Failed!");
                }
            });

        };


        $(document).ready(function () {
          
            function FetchVehicleDetails(regNo, refNo, vehId, type) {
                console.log('fetchvehicle');
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/FetchVehicleDetails",
                    data: "{'refNo':'" + refNo + "', 'regNo':'" + regNo + "', 'vehId':'" + vehId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (data) {
                        if (data.d.length != 0) {
                            console.log('Success response');
                            var r;
                            if (type != "load") {
                                //r = confirm(GetMultiMessage('VEH_EXISTS', '', ''));
                                r = true;
                            }
                            else {
                                r = true;
                            }

                            if (r == true) {
                                var vehModel = data.d[0].Model;
                                var vehType = data.d[0].VehType;

                                $('#<%=drpMakeCodes.ClientID%>').val(data.d[0].MakeCodeNo);
                                if ($('#<%=txtRegNoCreate.ClientID%>').val() != "") {
                                    $('#<%=txtRegNo.ClientID%>').val($('#<%=txtRegNoCreate.ClientID%>').val())
                                }
                                if (type === "load") { // RegNo usually fetched from popup, needs to be fetched from db on load. This might have to be changed to default in order to prevent data missmatch.
                                    $('#<%=txtRegNo.ClientID%>').val(data.d[0].VehRegNo);
                                }
                                else {
                                    $('#<%=txtRegNo.ClientID%>').val(data.d[0].VehRegNo);
                                }
                                $('#<%=txtIntNo.ClientID%>').val(data.d[0].IntNo);
                                loadXtraCheck();
                              
                                $('#<%=ddlVehType.ClientID%> ').val(data.d[0].New_Used);
                                $('#<%=ddlVehStatus.ClientID%>').val(data.d[0].VehStatus);
                                $('#<%=txtGeneralMake.ClientID%>').val(data.d[0].Make);
                                //Load the model dropdown correctly when data is null or empty 
                                if (data.d[0].Model != "") {
                                    $('#<%=cmbModelForm.ClientID%>').val(data.d[0].Model);
                                }
                                else {
                                    $('#<%=cmbModelForm.ClientID%>')[0].selectedIndex = 0;
                                }
                                $('#<%=ddlVatCode.ClientID%>').val(data.d[0].vatCode);
                                console.log(data.d[0].vatCode);

                                $('#<%=txtVehicleType.ClientID%>').val(data.d[0].VehType);
                                $('#<%=txtRegDate.ClientID%>').val(data.d[0].RegDate);
                                $('#<%=txtDeregDate.ClientID%>').val(data.d[0].DeRegDate);
                                $('#<%=txtTotWeight.ClientID%>').val(data.d[0].TotalWeight);
                                $('#<%=txtNetWeight.ClientID%>').val(data.d[0].NetWeight);
                                $('#<%=txtRegDateNorway.ClientID%>').val(data.d[0].RegDateNorway);
                                $('#<%=txtLastRegDate.ClientID%>').val(data.d[0].LastRegDate);
                                $('#<%=txtRegyr.ClientID%>').val(data.d[0].RegYear);
                                $('#<%=txtModelyr.ClientID%>').val(data.d[0].ModelYear);
                                $('#<%=txtColor.ClientID%>').val(data.d[0].Color);
                                $('#<%=txtTechVin.ClientID%>').val(data.d[0].VehVin);
                                $('#<%=txtVinNo.ClientID%>').val(data.d[0].VehVin);
                                $('#<%=txtType.ClientID%>').val(data.d[0].ModelType);
                                $('#<%=txtMaxRoofLoad.ClientID%>').val(data.d[0].Max_Rf_Load);
                                
                                $('#<%=txtCategory.ClientID%>').val(data.d[0].Category);
                                $('#<%=txtGeneralAnnotation.ClientID%>').val(data.d[0].Annotation);
                                if (data.d[0].Annotation != "") {
                                    $('#exclamIcon').show();
                                }
                                else {
                                    $('#exclamIcon').hide();
                                }
                                $('#<%=txtGeneralNote.ClientID%>').val(data.d[0].Note);
                                if (data.d[0].Note != "") {
                                    $('#exclamIcon2').show();
                                }
                                else {
                                    $('#exclamIcon2').hide();
                                }
                                $('#<%=drpWarrantyCode.ClientID%>').val(data.d[0].Warranty_Code);
                                $('#<%=txtProjectNo.ClientID%>').val(data.d[0].Project_No);
                                $('#<%=txtLastContactDate.ClientID%>').val(data.d[0].Last_Contact_Date);
                                $('#<%=txtPracticalLoad.ClientID%>').val(data.d[0].Practical_Load);
                                $('#<%=txtEarlyRegNo1.ClientID%>').val(data.d[0].Earlier_Regno_1);
                                $('#<%=txtEarlyRegNo2.ClientID%>').val(data.d[0].Earlier_Regno_2);
                                $('#<%=txtEarlyRegNo3.ClientID%>').val(data.d[0].Earlier_Regno_3);
                                $('#<%=txtEarlyRegNo4.ClientID%>').val(data.d[0].Earlier_Regno_4);
                                $('#<%=txtTechVehGrp.ClientID%>').val(data.d[0].VehGrp);
                                $('#<%=txtMileage.ClientID%>').val(data.d[0].Mileage);
                                $('#<%=txtMileageDate.ClientID%>').val(data.d[0].MileageRegDate);
                                $('#<%=txtHours.ClientID%>').val(data.d[0].VehicleHrs);
                                $('#<%=txtHoursDate.ClientID%>').val(data.d[0].VehicleHrsDate);
                                if (data.d[0].Machine_W_Hrs == 0) {
                                    $("#<%=cbMachineHours.ClientID%>").attr('checked', false);
                                    $('#<%=lblMileage.ClientID%>').show();
                                    $('#<%=txtMileage.ClientID%>').show();
                                    $('#<%=lblMileageDate.ClientID%>').show();
                                    $('#<%=txtMileageDate.ClientID%>').show();
                                    $('#<%=lblHours.ClientID%>').hide();
                                    $('#<%=txtHours.ClientID%>').hide();
                                    $('#<%=lblHoursDate.ClientID%>').hide();
                                    $('#<%=txtHoursDate.ClientID%>').hide();
                                }
                                else {
                                    $("#<%=cbMachineHours.ClientID%>").attr('checked', true);
                                    $('#<%=lblMileage.ClientID%>').hide();
                                    $('#<%=txtMileage.ClientID%>').hide();
                                    $('#<%=lblMileageDate.ClientID%>').hide();
                                    $('#<%=txtMileageDate.ClientID%>').hide();
                                    $('#<%=lblHours.ClientID%>').show();
                                    $('#<%=txtHours.ClientID%>').show();
                                    $('#<%=lblHoursDate.ClientID%>').show();
                                    $('#<%=txtHoursDate.ClientID%>').show();
                                }
                                $('#<%=txtTechPick.ClientID%>').val(data.d[0].PickNo);
                                $('#<%=txtTechMake.ClientID%>').val(data.d[0].MakeCodeNo);
                                $('#<%=txtTechRicambiNo.ClientID%>').val(data.d[0].RicambiNo);
                                $('#<%=txtTechEngineNo.ClientID%>').val(data.d[0].EngineNum);
                                $('#<%=txtTechFuelCode.ClientID%>').val(data.d[0].FuelCode);
                                if (data.d[0].FuelCode == "1") {
                                    $('#<%=txtTechFuelName.ClientID%>').val("Bensin");
                                }
                                if (data.d[0].FuelCode == "2") {
                                    $('#<%=txtTechFuelName.ClientID%>').val("Diesel");
                                }
                                $('#<%=txtTechFuelCard.ClientID%>').val(data.d[0].FuelCard);
                                $('#<%=txtTechGearBox.ClientID%>').val(data.d[0].GearBox_Desc);
                                $('#<%=txtTechWarehouse.ClientID%>').val(data.d[0].WareHouse);
                                $('#<%=txtTechKeyNo.ClientID%>').val(data.d[0].KeyNo);
                                $('#<%=txtTechDoorKeyNo.ClientID%>').val(data.d[0].DoorKeyNo);

                                $('#<%=txtTechInteriorCode.ClientID%>').val(data.d[0].InteriorCode);
                                $('#<%=txtTechPurchaseNo.ClientID%>').val(data.d[0].PurchaseNo);
                                $('#<%=txtTechAddonGrp.ClientID%>').val(data.d[0].AddonGroup);
                                $('#<%=txtTechDateExpectedIn.ClientID%>').val(data.d[0].Date_Expected_In);
                                $('#<%=txtTechTireInfo.ClientID%>').val(data.d[0].Tires);
                                $('#<%=txtTechServiceCategory.ClientID%>').val(data.d[0].Service_Category);
                                $('#<%=txtTechApprovalNo.ClientID%>').val(data.d[0].No_Approval_No);
                                $('#<%=txtTechEUApprovalNo.ClientID%>').val(data.d[0].Eu_Approval_No);
                                $('#<%=txtTechProductNo.ClientID%>').val(data.d[0].ProductNo);
                                $('#<%=txtTechElCode.ClientID%>').val(data.d[0].ElCode);
                                $('#<%=txtTechTakenInDate.ClientID%>').val(data.d[0].Taken_In_Date);
                                $('#<%=txtTechMileageTakenIn.ClientID%>').val(data.d[0].Taken_In_Mileage);
                                $('#<%=txtTechDeliveryDate.ClientID%>').val(data.d[0].Delivery_Date);
                                $('#<%=txtTechMileageDelivered.ClientID%>').val(data.d[0].Delivery_Mileage);
                                $('#<%=txtTechServiceDate.ClientID%>').val(data.d[0].Service_Date);
                                $('#<%=txtTechMileageService.ClientID%>').val(data.d[0].Service_Mileage);
                                $('#<%=txtTechCallInDate.ClientID%>').val(data.d[0].Call_In_Date);
                                $('#<%=txtTechMileageCallIn.ClientID%>').val(data.d[0].Call_In_Mileage);
                                $('#<%=txtTechCleanedDate.ClientID%>').val(data.d[0].Cleaned_Date);
                                $('#<%=txtTechTechdocNo.ClientID%>').val(data.d[0].TechDocNo);
                                $('#<%=txtTechLength.ClientID%>').val(data.d[0].Length);
                                $('#<%=txtTechWidth.ClientID%>').val(data.d[0].Width);
                                $('#<%=txtTechNoise.ClientID%>').val(data.d[0].Noise_On_Veh);
                                $('#<%=txtTechEffect.ClientID%>').val(data.d[0].EngineEff);
                                $('#<%=txtTechPistonDisp.ClientID%>').val(data.d[0].PisDisplacement);
                                $('#<%=txtTechRoundperMin.ClientID%>').val(data.d[0].Rounds);

                                if (data.d[0].Used_Imported == 0) {
                                    $("#<%=cbTechUsedImported.ClientID%>").prop('checked', false);
                                }
                                else {
                                    $("#<%=cbTechUsedImported.ClientID%>").prop('checked', true);
                                }
                                if (data.d[0].Pressure_Mech_Brakes == 0) {
                                    $("#<%=cbTechPressureMechBrakes.ClientID%>").prop('checked', false);
                                }
                                else {
                                    $("#<%=cbTechPressureMechBrakes.ClientID%>").prop('checked', true);
                                }
                                if (data.d[0].Towbar == 0) {
                                    $("#<%=cbTechTowbar.ClientID%>").prop('checked', false);
                                }
                                else {
                                    $("#<%=cbTechTowbar.ClientID%>").prop('checked', true);
                                }
                                if (data.d[0].Service_Book == 0) {
                                    $("#<%=cbTechServiceBook.ClientID%>").prop('checked', false);
                                }
                                else {
                                    $("#<%=cbTechServiceBook.ClientID%>").prop('checked', true);
                                }
                                $('#<%=txtTechLastPkkOk.ClientID%>').val(data.d[0].LastPKK_AppDate);
                                $('#<%=txtTechNextPkk.ClientID%>').val(data.d[0].NxtPKK_Date);
                                $('#<%=txtTechLastInvoicedPkk.ClientID%>').val(data.d[0].Last_PKK_Invoiced);
                                if (data.d[0].Call_In_Service == 0) {
                                    $("#<%=cbTechCallInService.ClientID%>").prop('checked', false);
                                }
                                else {
                                    $("#<%=cbTechCallInService.ClientID%>").prop('checked', true);
                                }
                                $('#<%=txtTechCallInMonth.ClientID%>').val(data.d[0].Call_In_Month_Service);
                                $('#<%=txtTechMileage.ClientID%>').val(data.d[0].Call_In_Mileage_Service);
                                if (data.d[0].Do_Not_Call_PKK == 0) {
                                    $("#<%=cbTechDoNotCallPkk.ClientID%>").prop('checked', false);
                                }
                                else {
                                    $("#<%=cbTechDoNotCallPkk.ClientID%>").prop('checked', true);
                                }
                                $('#<%=txtTechDeviationsPkk.ClientID%>').val(data.d[0].Deviations_PKK);
                                $('#<%=txtTechYearlyMileage.ClientID%>').val(data.d[0].Yearly_Mileage);
                                $('#<%=txtTechRadioCode.ClientID%>').val(data.d[0].Radio_Code);
                                $('#<%=txtTechStartImmobilizer.ClientID%>').val(data.d[0].Start_Immobilizer);
                                $('#<%=txtTechQtyKeys.ClientID%>').val(data.d[0].Qty_Keys);
                                $('#<%=txtTechKeyTag.ClientID%>').val(data.d[0].KeyTagNo);
                                //tabeconomy
                                $('#<%=txtEcoSalespriceNet.ClientID%>').val(data.d[0].SalesPriceNet);
                                $('#<%=txtEcoSalesSale.ClientID%>').val(data.d[0].SalesSale);
                                $('#<%=txtEcoSalesEquipment.ClientID%>').val(data.d[0].SalesEquipment);
                                $('#<%=txtEcoRegCost.ClientID%>').val(data.d[0].RegCosts);
                                $('#<%=txtEcoDiscount.ClientID%>').val(data.d[0].Discount);
                                $('#<%=txtEcoNetSalesPrice.ClientID%>').val(data.d[0].NetSalesPrice);
                                $('#<%=txtEcoFixCost.ClientID%>').val(data.d[0].FixCost);
                                $('#<%=txtEcoAssistSales.ClientID%>').val(data.d[0].AssistSales);
                                $('#<%=txtEcoCostAfterSale.ClientID%>').val(data.d[0].CostAfterSales);
                                $('#<%=txtEcoContributionsToday.ClientID%>').val(data.d[0].ContributionsToday);
                                $('#<%=txtEcoSalesPriceGross.ClientID%>').val(data.d[0].SalesPriceGross);
                                $('#<%=txtEcoRegFee.ClientID%>').val(data.d[0].RegFee);
                                $('#<%=txtEcoVat.ClientID%>').val(data.d[0].Vat);
                                $('#<%=txtEcoVehTotAmount.ClientID%>').val(data.d[0].TotAmount);
                                $('#<%=txtEcoWreckingAmount.ClientID%>').val(data.d[0].WreckingAmount);
                                $('#<%=txtEcoYearlyFee.ClientID%>').val(data.d[0].YearlyFee);
                                $('#<%=txtEcoInsurance.ClientID%>').val(data.d[0].Insurance);
                                $('#<%=txtEcoCostPriceNet.ClientID%>').val(data.d[0].CostPriceNet);
                                $('#<%=txtEcoInsuranceBonus.ClientID%>').val(data.d[0].InsuranceBonus);
                                $('#<%=txtEcoInntakeSaler.ClientID%>').val(data.d[0].CostSales);
                                $('#<%=txtEcoCostBeforeSale.ClientID%>').val(data.d[0].CostBeforeSale);
                                $('#<%=txtEcoSalesProvision.ClientID%>').val(data.d[0].SalesProvision);
                                $('#<%=txtEcoCommitDay.ClientID%>').val(data.d[0].CommitDay);
                                $('#<%=txtEcoAddedInterests.ClientID%>').val(data.d[0].AddedInterests);
                                $('#<%=txtEcoCostEquipment.ClientID%>').val(data.d[0].CostEquipment);
                                $('#<%=txtEcoTotalCost.ClientID%>').val(data.d[0].TotalCost);
                                $('#<%=txtEcoCreditNote.ClientID%>').val(data.d[0].CreditNoteNo);
                                $('#<%=txtEcoCreditDate.ClientID%>').val(data.d[0].CreditNoteDate);
                                $('#<%=txtEcoInvoiceNo.ClientID%>').val(data.d[0].InvoiceNo);
                                $('#<%=txtEcoInvoiceDate.ClientID%>').val(data.d[0].InvoiceDate);
                                $('#<%=txtEcoRebuy.ClientID%>').val(data.d[0].RebuyDate);
                                $('#<%=txtEcoRebuyPrice.ClientID%>').val(data.d[0].RebuyPrice);
                                $('#<%=txtEcoCostKm.ClientID%>').val(data.d[0].CostPerKm);
                                $('#<%=txtEcoTurnover.ClientID%>').val(data.d[0].Turnover);
                                $('#<%=txtEcoProgress.ClientID%>').val(data.d[0].Progress);
                                //tabCustomer
                                $('#<%=txtCustNo.ClientID%>').val(data.d[0].Customer);
                                if (data.d[0].Customer != '') {
                                    FetchCustomerDetails();
                                }
                                //tabtrailer
                                $('#<%=txtTraAxle1.ClientID%>').val(data.d[0].Axle1);
                                $('#<%=txtTraAxle2.ClientID%>').val(data.d[0].Axle2);
                                $('#<%=txtTraAxle3.ClientID%>').val(data.d[0].Axle3);
                                $('#<%=txtTraAxle4.ClientID%>').val(data.d[0].Axle4);
                                $('#<%=txtTraAxle5.ClientID%>').val(data.d[0].Axle5);
                                $('#<%=txtTraAxle6.ClientID%>').val(data.d[0].Axle6);
                                $('#<%=txtTraAxle7.ClientID%>').val(data.d[0].Axle7);
                                $('#<%=txtTraAxle8.ClientID%>').val(data.d[0].Axle8);
                                $('#<%=txtTraDesc.ClientID%>').val(data.d[0].TrailerDesc);
                                //tabcertificate
                                $('#<%=txtCertTireDimFront.ClientID%>').val(data.d[0].StdTyreFront);
                                $('#<%=txtCertTireDimBack.ClientID%>').val(data.d[0].StdTyreBack);
                                $('#<%=txtCertLiFront.ClientID%>').val(data.d[0].MinLi_Front);
                                $('#<%=txtCertLiBack.ClientID%>').val(data.d[0].MinLi_Back);
                                $('#<%=txtCertMinInpressFront.ClientID%>').val(data.d[0].Min_Inpress_Front);
                                $('#<%=txtCertMinInpressBack.ClientID%>').val(data.d[0].Min_Inpress_Back);
                                $('#<%=txtCertRimFront.ClientID%>').val(data.d[0].Std_Rim_Front);
                                $('#<%=txtCertRimBack.ClientID%>').val(data.d[0].Std_Rim_Back);
                                $('#<%=txtCertminSpeedFront.ClientID%>').val(data.d[0].Min_Front);
                                $('#<%=txtCertMinSpeedBack.ClientID%>').val(data.d[0].Min_Back);
                                $('#<%=txtCertMaxWidthFront.ClientID%>').val(data.d[0].Max_Tyre_Width_Frnt);
                                $('#<%=txtCertMaxWidthBack.ClientID%>').val(data.d[0].Max_Tyre_Width_Bk);
                                $('#<%=txtCertAxlePressureFront.ClientID%>').val(data.d[0].AxlePrFront);
                                $('#<%=txtCertAxlePressureBack.ClientID%>').val(data.d[0].AxlePrBack);
                                $('#<%=txtCertAxleQty.ClientID%>').val(data.d[0].Axles_Number);
                                $('#<%=txtCertAxleWithTraction.ClientID%>').val(data.d[0].Axles_Number_Traction);
                                $('#<%=txtCertGear.ClientID%>').val(data.d[0].Wheels_Traction);
                                $('#<%=txtCertTrailerWeightBrakes.ClientID%>').val(data.d[0].TrailerWth_Brks);
                                $('#<%=txtCertTrailerWeight.ClientID%>').val(data.d[0].TrailerWthout_Brks);
                                $('#<%=txtCertWeightTowbar.ClientID%>').val(data.d[0].Max_Wt_TBar);
                                $('#<%=txtCertLengthTowbar.ClientID%>').val(data.d[0].Len_TBar);
                                $('#<%=txtCertTotalTrailerWeight.ClientID%>').val(data.d[0].TotalTrailerWeight);
                                $('#<%=txtCertSeats.ClientID%>').val(data.d[0].Seats);
                                $('#<%=txtCertValidFrom.ClientID%>').val(data.d[0].ValidFrom);
                                $('#<%=txtCertEuVersion.ClientID%>').val(data.d[0].EU_Version);
                                $('#<%=txtCertEuVariant.ClientID%>').val(data.d[0].EU_Variant);
                                $('#<%=txtCertEuronorm.ClientID%>').val(data.d[0].EU_Norm);
                                $('#<%=txtCertCo2Emission.ClientID%>').val(data.d[0].CO2_Emission);
                                $('#<%=txtCertMakeParticleFilter.ClientID%>').val(data.d[0].Make_Part_Filter);
                                $('#<%=txtCertChassi.ClientID%>').val(data.d[0].Chassi_Desc);
                                $('#<%=txtCertIdentity.ClientID%>').val(data.d[0].Identity_Annot);
                                $('#<%=txtCertCertificate.ClientID%>').val(data.d[0].Cert_Text);
                                $('#<%=txtCertNotes.ClientID%>').val(data.d[0].Annot);
                                if ($('#<%=txtRegNo.ClientID%>').val() != '') {
                                    loadImages($('#<%=txtRegNo.ClientID%>').val());
                                }
                                if (data.d[0].ID_BUYER != '' && data.d[0].ID_BUYER != null) {
                                    FetchBuyerCustomerDetails(data.d[0].ID_BUYER);
                                    tbBuyerNo.SetText(data.d[0].ID_BUYER.trim());
                                }
                                else {
                                    $('#<%=rbBuyerL.ClientID%>').attr('checked', false);
                                    $('#<%=rbBuyerV.ClientID%>').attr('checked', false);
                                    tbBuyerNo.SetText("");
                                    tbBuyerName.SetText("");
                                }
                                if (data.d[0].ID_LEASING != '' && data.d[0].ID_LEASING != null) {
                                    // Fetch Leasing and Owner Cust Details
                                    FetchLeasingCustomerDetails(data.d[0].ID_LEASING);
                                    tbLeasingNo.SetText(data.d[0].ID_LEASING.trim());
                                    tbOwnerNo.SetText(data.d[0].ID_OWNER.trim());
                                }
                                else {

                                    tbOwnerNo.SetText("");
                                    tbOwnerName.SetText("");
                                    tbLeasingNo.SetText("");
                                    tbLeasingName.SetText("");
                                }

                                if (data.d[0].ID_DRIVER != '' && data.d[0].ID_DRIVER != null) {

                                    FetchDriverCustomerDetails(data.d[0].ID_DRIVER);
                                    tbDriverNo.SetText(data.d[0].ID_DRIVER.trim());
                                }
                                else {
                                    tbDriverNo.SetText("");
                                    tbDriverName.SetText("");
                                }
                                overlay('off', '');
                                $('#<%=txtTechTectyl.ClientID%>').val(data.d[0].DT_VEH_TECTYL);
                                $('#<%=txtPkkDate.ClientID%>').val(data.d[0].DT_VEH_PKK);
                                $('#<%=txtPkkAfterDate.ClientID%>').val(data.d[0].DT_VEH_PKK_AFTER);
                                $('#<%=txtPerServiceDate.ClientID%>').val(data.d[0].DT_VEH_PER_SERVICE);
                                $('#<%=txtRentalCarDate.ClientID%>').val(data.d[0].DT_VEH_RENTAL_CAR);
                                $('#<%=txtMoistControl.ClientID%>').val(data.d[0].DT_VEH_MOIST_CTRL);
                            }
                        }
                        else {
                            var res = GetMultiMessage('0008', '', '');
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            //Moved this into get ready for it to be closed on escape binding when opened as pop-up
            function overlay(state, mod) {
                $('body').focus();
                if (mod == "") {
                    $('.modal').addClass('hidden');
                }
                else {
                    $('#' + mod).removeClass('hidden');
                }
                if (state == "") {
                    $('.overlayHide').toggleClass('ohActive');
                } else if (state == "on") {
                    $('.overlayHide').addClass('ohActive');
                } else {
                    $('.overlayHide').removeClass('ohActive');
                }
            }

            var getUrlParameter = function getUrlParameter(sParam) {
                var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;

                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');

                    if (sParameterName[0] === sParam) {
                        return sParameterName[1] === undefined ? true : sParameterName[1];
                    }
                }
            };

            var srchVeh = "";
            srchVeh = getUrlParameter('vehId');

            //if (window.parent != undefined && window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchVeh') != null) {
            //    srchVeh = window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchVeh').value;
            //}
            $('#<%=txtRegNoCreate.ClientID%>').val(srchVeh); //window.opener.parent.document.getElementById('ctl00_cntMainPanel_txtSrchVeh').value

            //Check the page name from where it is called before hiding the banners
            var pageNameFrom = getUrlParameter('pageName');

            if (pageNameFrom == "OrderHead" && pageNameFrom != undefined) {
                //$('#topBanner').hide();
                //$('#topNav').hide();
                //$('#carsSideBar').hide();
                $('#mainHeader').hide();
                $('#second').hide();

                $('#<%=txtRefNoCreate.ClientID%>').val("");
            }
            else if (pageNameFrom == "TireHotel" && pageNameFrom != undefined) {
                //$('#topBanner').hide();
                //$('#topNav').hide();
                //$('#carsSideBar').hide();
                $('#mainHeader').hide();
                $('#second').hide();

                $('#<%=txtRefNoCreate.ClientID%>').val("");
            }
            else if (pageNameFrom == "AppointmentFormVehicle" && pageNameFrom != undefined) {
                $('#mainHeader').hide();
                $('#second').hide();

                $('#<%=txtRefNoCreate.ClientID%>').val("");
                //window.parent.$('.ui-dialog-content:visible').dialog('close');
            }

            loadInit();

            function loadInit() {
                setTab('General');
                //Loading all drop down boxes
                loadNewUsedCode();
                loadStatusCode();
                $('#ctl00_cntMainPanel_ddlVehicleType option[value="2"]').prop('selected', true);
                $('#ctl00_cntMainPanel_ddlVehicleStatus option[value="6"]').prop('selected', true);
                getNewUsedRefNo();
                $('.mil').show();
                $('.hrs').hide();
                loadWarrantyCode();
                loadMakeCode();
                loadModel();
                loadEditMake();
                loadVatCode();
                $('.TechGeneral, .GenGeneral, .CustGeneral').show();
                $('.GenDate, .GenPKKService, .GenPictures, .TechMeasure, .TechInterior, .TechCertificate, .CustService, .CustPreviousInfo, .CustBilXtra').hide();
                $('#txtVehSearch').focus();

            }
            var vehId = getUrlParameter('vehId');
            var veh = getUrlParameter('veh');
            var regno = getUrlParameter('regno');
            var refno = getUrlParameter('refno');
            if (typeof refno !== "undefined" && veh != "new") {
                (typeof regno == "undefined") ? regno = '' : regno = regno;
                (typeof veh == "undefined") ? veh = '' : veh = veh;
                FetchVehicleDetails(regno, refno, veh, 'load');
                
            }
            else if (typeof regno !== "undefined" && veh == "new") {
                $('#<%=txtRegNoCreate.ClientID%>').val(regno);
                overlay('on', 'modNewVehicle');
            }
            else if (typeof vehId !== "undefined" && veh == "new") {
                $('#<%=txtRegNoCreate.ClientID%>').val(vehId);
                overlay('on', 'modNewVehicle');
            }
            else {
                //overlay('off', 'modNewVehicle');
            }

            /*
                Button that "onclick" opens a popupwindow and provides more info about customer by providing custId to the popup
                Location: Dashboard->Vehicle->Customer
                Calls   : moreInfo
                ↓ ↓ ↓ 
            */

            //var nestedData = [
            //    { fakturainfo: "Fakturanr: 123 - kundenr: 10000 - fakturadato: 08.10.2019", varenr: "5000", beskrivelse: "MOTOR", arbeid: "", antall: "1" },
            //    {fakturainfo: "Fakturanr: 123 - kundenr: 10000 - fakturadato: 08.10.2019", varenr: "", beskrivelse: "", arbeid: "Arbeid", antall: "5"},
            //    { fakturainfo: "Fakturanr: 124 - kundenr: 12000 - fakturadato: 06.10.2019", varenr: "9", beskrivelse: "Kontantvare", arbeid: "", antall: "3" },
            //    { fakturainfo: "Fakturanr: 124 - kundenr: 12000 - fakturadato: 06.10.2019", varenr: "", beskrivelse: "", arbeid: "Service", antall: "5" },
            //    { fakturainfo: "Fakturanr: 124 - kundenr: 12000 - fakturadato: 06.10.2019", varenr: "5000", beskrivelse: "bremser", arbeid: "", antall: "4" },
            //    { fakturainfo: "Fakturanr: 124 - kundenr: 12000 - fakturadato: 06.10.2019", varenr: "", beskrivelse: "", arbeid: "Arbeid", antall: "2" }
            //]

            //$("#history-table").tabulator( {
            //    height: "311px",
            //    layout: "fitColumns",
            //    resizableColumns: false,
            //    groupBy: "fakturainfo",
            //    groupStartOpen: false,
            //    data: nestedData,
            //    columns: [
            //        { title: "Fakturanr", field: "fakturainfo", visible: false },
            //        { title: "varenr", field: "varenr" },
            //        { title: "beskrivelse", field: "beskrivelse" },
            //        { title: "arbeid", field: "arbeid" },
            //        { title: "antall", field: "antall" },
            //    ],
                
            //});
            $("#history-table").tabulator({

                height: 400, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 

                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                index: "NUMBER",
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string
                persistentSort: true, //Enable sort persistence
                responsiveLayout: "collapse",

                // Return value + "<span style='color:#d00; margin-left:10px;'>(" + count + Str() + "<span style='margin-right:300px;'>";
                //column definition in the columns array

                selectableCheck: function (row) {

                    var selectedRows = $("#history-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        if (row.getData().ID_INV_NO == selectedRows[0].getData().ID_INV_NO) {
                            return false;
                        }
                    }


                    return true; //alow selection of rows where the age is greater than 18
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    initModalView(row);
                },
                rowContext: function (e, row) {
                    //e - the click event object
                    //row - row component
                    //alert();
                    //e.preventDefault(); // prevent the browsers default context menu form appearing.
                },

                rowDeleted: function (row) {
                    //row - row component

                },


                ajaxResponse: function (url, params, response) {


                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //Return the d Property Of a response json Object
                },

                headerFilterPlaceholder: "Filtrer data", //set column header placeholder text
                columns: [ //Define Table Columns


                    { title: "Fakturadato", field: "DT_INVOICE", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Fakturanr", field: "ID_INV_NO", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Ordrenr", field: "ORDERNO", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Ordredato", field: "DT_CREATED", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Km.stand", field: "Mileage", sorter: "date", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Mekaniker", field: "MECHANIC", sorter: "date", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Signatur", field: "CreatedBy", align: "center", headerFilter: "input", minWidth: 120 },
                    

                ],


                //footerElement: $("<div class='tabulator-footer'></div>")[0], //sette [0] bak for å fungere,
                footerElement: $('<div class="tabulator-footer"></div>')[0]
            });

            

            $("#history-detail-table").tabulator({
                // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                height: 340,
                layout: "fitColumns", //fit columns to width of table (optional)
                selectable: false,     //true means we can select multiple rows   
                placeholder: "Ingen linjer", //display message to user on empty table

                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string

                columns: [ //Define Table Columns
                   
                    { title: "Varenr", field: "ID_ITEM", align: "center", width: 300 },
                    { title: "Beskrivelse", field: "ITEM_DESC", align: "center" },
                    { title: "Antall", field: "ITEM_QTY", align: "center", width: 150 },
                    { title: "Pris", field: "ITEM_PRICE", align: "center", width: 150 },
                    { title: "Mva", field: "ITEM_VAT", align: "center", width: 150 },
                    { title: "Total", field: "ITEM_TOTAL", align: "center", width: 150 }

                ],
               
                selectableCheck: function (row) {

                },
                rowSelectionChanged: function (data, rows) {
                    //rows - array of row components for the selected rows in order of selection
                    //data - array of data objects for the selected rows in order of selection
 
                },

                ajaxResponse: function (url, params, response) {

                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //return the d property of a response json object
                },
                dataLoading: function (data) { //we need this because data that comes in is strings, cant be 
                    //data - the data loading into the table
                },

                rowUpdated: function (row) {
                    //row - row component

                 
                },

                rowAdded: function (row) {
                    //row - row component
                 
                  
                },

                footerElement: $("<div class='tabulator-footer'></div>")[0]
            });

            function initModalView(row) {

                //brings over various variables from grid to the modal window
                var invno = row.getCell("ID_INV_NO").getValue();



                $('#pomodal_details_ponumber').text(row.getCell("ORDERNO").getValue());
                $('#pomodal_details_supplier').text(invno);
                

                $('#redRibbonPOmodal').text(invno);
                //(fourth step)

                $('#modal_po_steps').modal('show');
                $("#history-detail-table").tabulator("redraw");
              
                $("#history-detail-table").tabulator("setData", "frmVehicleDetail.aspx/Fetch_Invoice_Lines", { 'InvNo': invno });
               
                $("#history-detail-table").tabulator("redraw", true);
                $('#modal_po_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh         

            };


            
        function doDirtyWork(num, boxName)
        {
            var boxState;

            if (boxName.includes("SMS"))
            {
              
                if (num == 1) {
                    $(boxName).children(":first").addClass("large black checkmark icon")
                }
               
                }
            
            if(boxName.includes("Annot") && num != "")
            {
                $(boxName).children(":first").addClass("alarm icon")
                $(boxName).val(num)
                var temp = boxName.replace("#", "")
                var temp2 = "#txtForm" + temp
                $(temp2).val(num)
                }
         
            if (num == "0")  { boxState = "GoodBox"; $(boxName + boxState).addClass("large black checkmark icon")}
            else if (num == "1")  { boxState = "OKBox";$(boxName + boxState).addClass("large black checkmark icon") }
            else if (num == "2")  { boxState = "BadBox";$(boxName + boxState).addClass("large black checkmark icon")}
            //else {  }
          
            //alert(boxName + boxState)
            
        }
                                       
            //loads in the current XtraCheck scheme for this 
            function loadXtraCheck() {
                $('.XtraCheck').removeClass('large black checkmark icon');

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../transactions/frmWOJobDetails.aspx/loadXtraCheck",
                    data: "{'refnr':'" + $('#<%=txtIntNo.ClientID%>').val() + "',regnr:'" + $('#<%=txtRegNo.ClientID%>').val() + "'}",
        dataType: "json",
        async: true,//Very important
        success: function (Result) {
            if (Result.d.length > 0) {

                doDirtyWork(Result.d[0].MOTOROIL, "#engineOil");
                doDirtyWork(Result.d[0].MOTOROIL_ANNOT, "#engineOilAnnot");
                doDirtyWork(Result.d[0].MOTOROIL_SMS, "#engineOilSMS");
                doDirtyWork(Result.d[0].FREEZE_LEVEL, "#cFLevel");
                doDirtyWork(Result.d[0].FREEZE_LEVEL_ANNOT, "#cFLevelAnnot");
                doDirtyWork(Result.d[0].FREEZE_LEVEL_SMS, "#cFlevelSMS");
                doDirtyWork(Result.d[0].FREEZE_POINT, "#cFTemp");
                doDirtyWork(Result.d[0].FREEZE_POINT_ANNOT, "#cfTempAnnot")
                doDirtyWork(Result.d[0].FREEZE_POINT_SMS, "#cFtempSMS")
                doDirtyWork(Result.d[0].BRAKEFLUID, "#brakeFluid");
                doDirtyWork(Result.d[0].BRAKEFLUID_ANNOT, "#brakeFluidAnnot");
                doDirtyWork(Result.d[0].BRAKEFLUID_SMS, "#brakeFluidSMS");
                doDirtyWork(Result.d[0].BATTERY, "#battery");
                doDirtyWork(Result.d[0].BATTERY_ANNOT, "#batteryAnnot");
                doDirtyWork(Result.d[0].BATTERY_SMS, "#batterySMS");
                doDirtyWork(Result.d[0].WINDSCREEN_WIPER_FRONT, "#vipesFront");
                doDirtyWork(Result.d[0].WINDSCREEN_WIPER_FRONT_ANNOT, "#vipesFrontAnnot");
                doDirtyWork(Result.d[0].WINDSCREEN_WIPER_FRONT_SMS, "#vipesFrontSMS");
                doDirtyWork(Result.d[0].WINDSCREEN_WIPER_REAR, "#vipesBack");
                doDirtyWork(Result.d[0].WINDSCREEN_WIPER_REAR_ANNOT, "#vipesBackAnnot");
                doDirtyWork(Result.d[0].WINDSCREEN_WIPER_REAR_SMS, "#vipesBackSMS");
                doDirtyWork(Result.d[0].LIGHT_BULB_FRONT, "#lightsFront");
                doDirtyWork(Result.d[0].LIGHT_BULB_FRONT_ANNOT, "#lightsFrontAnnot");
                doDirtyWork(Result.d[0].LIGHT_BULB_FRONT_SMS, "#lightsFrontSMS");
                doDirtyWork(Result.d[0].LIGHT_BULB_REAR, "#lightsBack");
                doDirtyWork(Result.d[0].LIGHT_BULB_REAR_ANNOT, "#lightsBackAnnot");
                doDirtyWork(Result.d[0].LIGHT_BULB_REAR_SMS, "#lightsBackSMS");
                doDirtyWork(Result.d[0].SHOCK_ABSORBER_FRONT, "#bumperFront");
                doDirtyWork(Result.d[0].SHOCK_ABSORBER_FRONT_ANNOT, "#bumperFrontAnnot");
                doDirtyWork(Result.d[0].SHOCK_ABSORBER_FRONT_SMS, "#bumperFrontSMS");
                doDirtyWork(Result.d[0].SHOCK_ABSORBER_REAR, "#bumperBack");
                doDirtyWork(Result.d[0].SHOCK_ABSORBER_REAR_ANNOT, "#bumperBackAnnot");
                doDirtyWork(Result.d[0].SHOCK_ABSORBER_REAR_SMS, "#bumperBackSMS");
                doDirtyWork(Result.d[0].TIRE_FRONT, "#tiresFront");
                doDirtyWork(Result.d[0].TIRE_FRONT_ANNOT, "#tiresFrontAnnot");
                doDirtyWork(Result.d[0].TIRE_FRONT_SMS, "#tiresFrontSMS");
                doDirtyWork(Result.d[0].TIRE_REAR, "#tiresBack");
                doDirtyWork(Result.d[0].TIRE_REAR_ANNOT, "#tiresBackAnnot");
                doDirtyWork(Result.d[0].TIRE_REAR_SMS, "#tiresBackSMS");
                doDirtyWork(Result.d[0].SUSPENSION_FRONT, "#suspensionFront");
                doDirtyWork(Result.d[0].SUSPENSION_FRONT_ANNOT, "#suspensionFrontAnnot");
                doDirtyWork(Result.d[0].SUSPENSION_FRONT_SMS, "#suspensionFrontSMS");
                doDirtyWork(Result.d[0].SUSPENSION_REAR, "#suspensionBack");
                doDirtyWork(Result.d[0].SUSPENSION_REAR_ANNOT, "#suspensionBackAnnot");
                doDirtyWork(Result.d[0].SUSPENSION_REAR_SMS, "#suspensionBackSMS");
                doDirtyWork(Result.d[0].BRAKES_FRONT, "#brakesFront");
                doDirtyWork(Result.d[0].BRAKES_FRONT_ANNOT, "#brakesFrontAnnot");
                doDirtyWork(Result.d[0].BRAKES_FRONT_SMS, "#brakesFrontSMS");
                doDirtyWork(Result.d[0].BRAKES_REAR, "#brakesBack");
                doDirtyWork(Result.d[0].BRAKES_REAR_ANNOT, "#brakesBackAnnot");
                doDirtyWork(Result.d[0].BRAKES_REAR_SMS, "#brakesBackSMS");
                doDirtyWork(Result.d[0].EXHAUST, "#exhaust");
                doDirtyWork(Result.d[0].EXHAUST_ANNOT, "#exhaustAnnotIcon");
                doDirtyWork(Result.d[0].EXHAUST_SMS, "#exhaustSMS");
                doDirtyWork(Result.d[0].DENSITY_MOTOR, "#sealedEngine");
                doDirtyWork(Result.d[0].DENSITY_MOTOR_ANNOT, "#sealedEngineAnnot");
                doDirtyWork(Result.d[0].DENSITY_MOTOR_SMS, "#sealedEngineSMS");
                doDirtyWork(Result.d[0].DENSITY_GEARBOX, "#sealedGearbox");
                doDirtyWork(Result.d[0].DENSITY_GEARBOX_ANNOT, "#sealedGearboxAnnot");
                doDirtyWork(Result.d[0].DENSITY_GEARBOX_SMS, "#sealedGearboxSMS");

            }
        }
    });


            }
            
          
           


            //autocomplete for cusatomer search in local DB
            $('#txtVehSearch').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Transactions/frmWoSearch.aspx/Vehicle_Search",
                        data: "{q:'" + $('#txtVehSearch').val() + "'}",
                        dataType: "json",
                        success: function (data) {

                            console.log($('#txtVehSearch').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i kjøretøyregister. Vil du opprette ny?', value: $('#txtVehSearch').val(), val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.VehRegNo + " - " + item.IntNo + " - " + item.VehVin + " - " + item.CustomerName,
                                        val: item.IntNo,
                                        value: item.VehRegNo + " - " + item.IntNo + " - " + item.VehVin
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
                    //alert(i.item.val);
                   
                      
                    if (i.item.val != 'new') {
                        $('#aspnetForm')[0].reset();
                        FetchVehicleDetails('', i.item.val, '');
                       
                        //$(this).val('');
                        return false;
                     }
                     else {
                        overlay('on', 'modNewVehicle');
                        $('#<%=txtRegNoCreate.ClientID%>').val($('#txtVehSearch').val())
                     }   
                    }
            });

            $('#btnMoreInfo').click(function () {
                if ($('#<%=txtCustNo.ClientID%>').val().length > 0) {
                    var custId = $('#<%=txtCustNo.ClientID%>').val();
                    moreInfo('../Master/frmCustomerDetail.aspx?cust=' + custId + '&pageName=Vehicle', 'Kundedetaljer');
                }
                else {
                    moreInfo('../Master/frmCustomerDetail.aspx?pageName=Vehicle', 'Kundedetaljer');
                }
            });

            //IS BIND DEPRECATED?
            /* MODAL FUNCTIONS */
            $(document).bind('keydown', function (e) { // BIND ESCAPE TO CLOSE
                if (e.which == 27) {
                    overlay('off', '');
                }
            });
            $(".modClose").on('click', function (e) {
                overlay('off', '');
            });


            $('#<%=btnFetchMVR.ClientID%>').on('click', function (e) {
                if ($('#<%=txtIntNo.ClientID%>').val() != "") {
                    FetchMVR();                    
                }
                else {
                    //Changed by ABS
                    //FetchVehicleDetails($('#<%=txtIntNo.ClientID%>').val(),'', '');
                    FetchVehicleDetails($('#<%=txtRegNo.ClientID%>').val(), '', '');
                }

            });

            $('#<%=btnFetchVehDet.ClientID%>').on('click', function (e) {
                if ($('#<%=txtIntNo.ClientID%>').val() != "") {
                    if ($('#<%=txtRegNo.ClientID%>').val() != "") {
                        FetchNewVehDetails();
                    }
                    else {
                        alert("Invalid Reg No");
                    }
                     


                 } else {
                     alert("Invalid Internal No");
                 }

             });


            $("#<%=cbMachineHours.ClientID%>").on("click", function () {
                mhToggle();
            });
            function mhToggle() {
                //$("#<%=cbMachineHours.ClientID%>").prop('checked', !$("#<%=cbMachineHours.ClientID%>").prop('checked'));
                if ($("#<%=cbMachineHours.ClientID%>").is(':checked')) {
                    $('.mil').hide();
                    $('.hrs').show();
                }
                else {
                    $('.mil').show();
                    $('.hrs').hide();
                }
            }

            $('#<%=lblHours.ClientID%>').hide();
            $('#<%=txtHours.ClientID%>').hide();
            $('#<%=lblHoursDate.ClientID%>').hide();
            $('#<%=txtHoursDate.ClientID%>').hide();
            //Temporary hides the newvehicle pop up when doing action on the page. Must be fixed in a permanent good way
            <%--if ($('#<%=txtRegNo.ClientID%>').val() != "") {
                 $('#modNewVehicle').addClass('hidden');
                 $('.overlayHide').removeClass('ohActive');
             }
             else {
                 $('#modNewVehicle').removeClass('hidden');
                 $('.overlayHide').addClass('ohActive');
             }--%>

            $('.menu .item')
               .tab()
            ; //activate the tabs

            function setTab(cTab) {
                var regState = true;
                var tabID = "";
                tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
                var tab;
                (tabID == "") ? tab = cTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
                (tab == 'General') ? regState = false : regState = true; // Check for current tab
                $('#<%=txtRegNo.ClientID%>').prop('disabled', regState); // Sets state of txtRegno field
            }

            $('.cTab').on('click', function (e) {
                setTab($(this));
            });

            $('#<%=btnNewVehicleOK.ClientID%>').on('click', function () {
                overlay('off', '');
                //Refno will be set in insert cript in DB and redirected
                <%--if ($('#<%=txtRefNoCreate.ClientID%>').val() != "") {
                    $('#<%=txtIntNo.ClientID%>').val($('#<%=txtRefNoCreate.ClientID%>').val());
                }--%>
                $('#<%=txtRegNo.ClientID%>').val($('#<%=txtRegNoCreate.ClientID%>').val());
                $('#<%=ddlVehType.ClientID%>').val($('#<%=ddlVehicleType.ClientID%>').val());
                $('#<%=ddlVehStatus.ClientID%>').val($('#<%=ddlVehicleStatus.ClientID%>').val());
                $('#btnSaveVehicle').prop('disabled', false);
                $('#<%=txtRegNo.ClientID%>').focus();
               
                $('#<%=txtIntNo.ClientID%>').val($('#<%=txtRefNoCreate.ClientID%>').val());
            });
            $('#<%=txtRegNoCreate.ClientID()%>').on('blur', function () {
                FetchVehicleDetails($('#<%=txtRegNoCreate.ClientID%>').val(), '', '', '');
            });


            $('#<%=btnNewVehicleCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modNewVehicle').addClass('hidden');
                $('#btnSaveVehicle').prop('disabled', true);
                $('#<%=txtRegNo.ClientID%>').focus();
            });

            $('#btnNewVehicle').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modNewVehicle').removeClass('hidden');
                $('#btnSaveVehicle').prop('disabled', false);
                $('#ddlVehType').val(-1);
                $('#ddlVehStatus').val(-1);
                $('#<%=txtRefNoCreate.ClientID%>').val('');
                <%-- $('#<%=txtRegNoCreate.ClientID%>').val('');--%>
                
                $('#ctl00_cntMainPanel_ddlVehicleType option[value="2"]').prop('selected', true);
                $('#ctl00_cntMainPanel_ddlVehicleStatus option[value="6"]').prop('selected', true);
                getNewUsedRefNo();
                $('#<%=txtRegNoCreate.ClientID%>').focus();

            });

            $('.modClose').on('click', function () {
                $('#modNewVehicle').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                $('#btnSaveVehicle').prop('disabled', true);
            });

            $('#documents').on('click', function () {
               
                if ($('#<%=txtIntNo.ClientID%>').val() != "") {
                    loadDocuments($('#<%=txtRegNo.ClientID%>').val());
                }
                else {
                    swal("Du må først hente opp et kjøretøy.");
                }
                
            });
           

            //Activate modal for earlier regnos
            $("#btnGeneralPrevRegno").on("click", function () {
                $("#modGeneralPrevRegno").modal('show');
            })

           

            //activates modal for mobility warranty
            $("#btnMobWarranty").on("click", function () {
                $("#modMobilityWarranty").modal('show');
            });

            //Activate modal for PKK results
            $("#btnPKKResult").on("click", function () {
                $("#modDatePKKResult").modal('show');
            })

            $("#resetRadioOptions").on("click", function () {
                $("#vikingMob").attr('checked', false);
                $("#bilxtraMob").attr('checked', false);
            });

            //Certificate buttons for modal
            $("#btnCertAnnotation").on("click", function () {
                $("#modCertificateAnnot").modal('show');
            });

            $("#btnCertTrailer").on("click", function () {
                $("#modCertificateTrailer").modal('show');
            })

            $("#btnProspect").on("click", function () {
                $("#modProspect").modal('show');
            })


            //btn on General page to view different data

            $('#btnGen1').on('click', function () {
                $('.GenGeneral').show();
                $('#btnGen1').removeClass('carsButtonBlueInverted');
                $('#btnGen1').addClass('carsButtonBlueNotInverted');
                $('#btnGen2').removeClass('carsButtonBlueNotInverted');
                $('#btnGen2').addClass('carsButtonBlueInverted');
                $('#btnGen3').removeClass('carsButtonBlueNotInverted');
                $('#btnGen3').addClass('carsButtonBlueInverted');
                $('#btnGen4').addClass('carsButtonBlueInverted');
                $('#btnGen4').removeClass('carsButtonBlueNotInverted');

                $('.GenDate, .GenPKKService, .GenPictures').hide();

            });
            $('#btnGen2').on('click', function () {
                $('.GenDate').show();
                $('.GenGeneral, .GenPKKService, .GenPictures').hide();
                $('#btnGen1').addClass('carsButtonBlueInverted');
                $('#btnGen1').removeClass('carsButtonBlueNotInverted');
                $('#btnGen2').removeClass('carsButtonBlueInverted');
                $('#btnGen2').addClass('carsButtonBlueNotInverted');
                $('#btnGen3').removeClass('carsButtonBlueNotInverted');
                $('#btnGen3').addClass('carsButtonBlueInverted');
                $('#btnGen4').addClass('carsButtonBlueInverted');
                $('#btnGen4').removeClass('carsButtonBlueNotInverted');
            });
            $('#btnGen3').on('click', function () {
                $('.GenPKKService').show();
                $('.GenGeneral, .GenDate, .GenPictures').hide();

                $('#btnGen1').addClass('carsButtonBlueInverted');
                $('#btnGen1').removeClass('carsButtonBlueNotInverted');
                $('#btnGen2').addClass('carsButtonBlueInverted');
                $('#btnGen2').removeClass('carsButtonBlueNotInverted');
                $('#btnGen3').addClass('carsButtonBlueNotInverted');
                $('#btnGen3').removeClass('carsButtonBlueInverted');
                $('#btnGen4').addClass('carsButtonBlueInverted');
                $('#btnGen4').removeClass('carsButtonBlueNotInverted');
                
            });
            $('#btnGen4').on('click', function () {
                $('.GenPictures').show();
                $('.GenGeneral, .GenDate, .GenPKKService').hide();

                $('#btnGen1').addClass('carsButtonBlueInverted');
                $('#btnGen1').removeClass('carsButtonBlueNotInverted');
                $('#btnGen2').addClass('carsButtonBlueInverted');
                $('#btnGen2').removeClass('carsButtonBlueNotInverted');
                $('#btnGen3').addClass('carsButtonBlueInverted');
                $('#btnGen3').removeClass('carsButtonBlueNotInverted');
                $('#btnGen4').addClass('carsButtonBlueNotInverted');
                $('#btnGen4').removeClass('carsButtonBlueInverted');
                if ($('#<%=txtRegNo.ClientID%>').val() == '') {
                    swal("Du må hente opp kjøretøy før du får se bilder!");
                }
                
            });

            
          <%-- $('#<%=BtnUploadFile.ClientID%>').click(function (e) {
                e.preventDefault();
               
            });--%>

            //btn on technical page to view different data
            
            $('#btnTech1').on('click', function () {
                $('.TechGeneral').show();
                $('#btnTech1').removeClass('carsButtonBlueInverted');
                $('#btnTech1').addClass('carsButtonBlueNotInverted');
                $('#btnTech2').removeClass('carsButtonBlueNotInverted');
                $('#btnTech2').addClass('carsButtonBlueInverted');
                $('#btnTech3').removeClass('carsButtonBlueNotInverted');
                $('#btnTech3').addClass('carsButtonBlueInverted');
                $('#btnTech4').removeClass('carsButtonBlueNotInverted');
                $('#btnTech4').addClass('carsButtonBlueInverted');

                $('.TechCertificate, .TechMeasure, .TechInterior').hide();
               
            });
            $('#btnTech2').on('click', function () {
                $('.TechCertificate').show();
                $('.TechGeneral, .TechInterior, .TechMeasure').hide();
                $('#btnTech1').addClass('carsButtonBlueInverted');
                $('#btnTech1').removeClass('carsButtonBlueNotInverted');
                $('#btnTech2').removeClass('carsButtonBlueInverted');
                $('#btnTech2').addClass('carsButtonBlueNotInverted');
                $('#btnTech3').removeClass('carsButtonBlueNotInverted');
                $('#btnTech3').addClass('carsButtonBlueInverted');
                $('#btnTech4').removeClass('carsButtonBlueNotInverted');
                $('#btnTech4').addClass('carsButtonBlueInverted');
            });
            $('#btnTech3').on('click', function () {
                $('.TechMeasure').show();
                $('.TechGeneral, .TechCertificate, .TechInterior').hide();

                $('#btnTech1').addClass('carsButtonBlueInverted');
                $('#btnTech1').removeClass('carsButtonBlueNotInverted');
                $('#btnTech2').addClass('carsButtonBlueInverted');
                $('#btnTech2').removeClass('carsButtonBlueNotInverted');
                $('#btnTech3').addClass('carsButtonBlueNotInverted');
                $('#btnTech3').removeClass('carsButtonBlueInverted');
                $('#btnTech4').removeClass('carsButtonBlueNotInverted');
                $('#btnTech4').addClass('carsButtonBlueInverted');
            });
            $('#btnTech4').on('click', function () {
                $('.TechInterior').show();
                $('.TechGeneral, .TechCertificate, .TechMeasure').hide();

                $('#btnTech1').addClass('carsButtonBlueInverted');
                $('#btnTech1').removeClass('carsButtonBlueNotInverted');
                $('#btnTech2').addClass('carsButtonBlueInverted');
                $('#btnTech2').removeClass('carsButtonBlueNotInverted');
                $('#btnTech3').removeClass('carsButtonBlueNotInverted');
                $('#btnTech3').addClass('carsButtonBlueInverted');
                $('#btnTech4').addClass('carsButtonBlueNotInverted');
                $('#btnTech4').removeClass('carsButtonBlueInverted');
            });

            //Econopmy button clicks
            $("#btnEco1").on("click", function () {
                $("#modEcoInfo").modal('show');
            })

            $('#btnCust1').on('click', function () {
                $('.CustGeneral').show();
                $('#btnCust1').removeClass('carsButtonBlueInverted');
                $('#btnCust1').addClass('carsButtonBlueNotInverted');
                $('#btnCust2').removeClass('carsButtonBlueNotInverted');
                $('#btnCust2').addClass('carsButtonBlueInverted');
                $('#btnCust3').removeClass('carsButtonBlueNotInverted');
                $('#btnCust3').addClass('carsButtonBlueInverted');
                $('#btnCust4').removeClass('carsButtonBlueNotInverted');
                $('#btnCust4').addClass('carsButtonBlueInverted');

                $('.CustService, .CustPreviousInfo, .CustBilXtra').hide();

            });
            $('#btnCust2').on('click', function () {
                $('.CustService').show();
                $('.CustGeneral, .CustPreviousInfo, .CustBilXtra').hide();
                $('#btnCust1').addClass('carsButtonBlueInverted');
                $('#btnCust1').removeClass('carsButtonBlueNotInverted');
                $('#btnCust2').removeClass('carsButtonBlueInverted');
                $('#btnCust2').addClass('carsButtonBlueNotInverted');
                $('#btnCust3').removeClass('carsButtonBlueNotInverted');
                $('#btnCust3').addClass('carsButtonBlueInverted');
                $('#btnCust4').removeClass('carsButtonBlueNotInverted');
                $('#btnCust4').addClass('carsButtonBlueInverted');

            });
            $('#btnCust3').on('click', function () {
                $('.CustPreviousInfo').show();
                $('.CustGeneral, .CustService, .CustBilXtra').hide();

                $('#btnCust1').addClass('carsButtonBlueInverted');
                $('#btnCust1').removeClass('carsButtonBlueNotInverted');
                $('#btnCust2').addClass('carsButtonBlueInverted');
                $('#btnCust2').removeClass('carsButtonBlueNotInverted');
                $('#btnCust3').addClass('carsButtonBlueNotInverted');
                $('#btnCust3').removeClass('carsButtonBlueInverted');
                $('#btnCust4').removeClass('carsButtonBlueNotInverted');
                $('#btnCust4').addClass('carsButtonBlueInverted');

            });
            $('#btnCust4').on('click', function () {
                $('.CustBilXtra').show();
                $('.CustGeneral, .CustService, .CustPreviousInfo').hide();

                $('#btnCust1').addClass('carsButtonBlueInverted');
                $('#btnCust1').removeClass('carsButtonBlueNotInverted');
                $('#btnCust2').addClass('carsButtonBlueInverted');
                $('#btnCust2').removeClass('carsButtonBlueNotInverted');
                $('#btnCust3').removeClass('carsButtonBlueNotInverted');
                $('#btnCust3').addClass('carsButtonBlueInverted');
                $('#btnCust4').addClass('carsButtonBlueNotInverted');
                $('#btnCust4').removeClass('carsButtonBlueInverted');
            });
            

            //Contextmenu for Vegvesen
            $.contextMenu({
                selector: '#<%=txtRegNo.ClientID%>',
                items: {
                    vegvesen: {
                        name: "Åpne i Vegvesen",
                        callback: function (key, opt) {
                            window.open('http://www.vegvesen.no/Kjoretoy/Eie+og+vedlikeholde/EU-kontroll/Kontrollfrist?ticket=74DFF3E8A21733B50546C640D6B752F8&registreringsnummer=' + $(this).val() + '&captcha=');
                        }
                    },
                    brreg: {
                        name: "Åpne i Brreg",
                        callback: function (key, opt) {
                            window.open('https://w2.brreg.no/motorvogn/heftelser_motorvogn.jsp?regnr=' + $(this).val());
                        }
                    },
                }
            });

            //Make edit mod scripts
            $('#<%=btnEditMake.ClientID%>').on('click', function () {
                overlay('on', 'modEditMake');
            });

            $('#<%=btnEditMakeCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modEditMake').addClass('hidden');
            });
            $('#<%=btnEditMakeNew.ClientID%>').on('click', function () {
                $('#<%=txtEditMakeCode.ClientID%>').val('');
                $('#<%=txtEditMakeDescription.ClientID%>').val('');
                $('#<%=txtEditMakePriceCode.ClientID%>').val('');
                $('#<%=txtEditMakeDiscount.ClientID%>').val('');
                $('#<%=txtEditMakeVat.ClientID%>').val('')
                $('#<%=lblEditMakeStatus.ClientID%>').html('Oppretter nytt bilmerke.')
            });

            function loadEditMake() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadEditMake",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpEditMakeList.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpEditMakeList.ClientID%>').append($("<option></option>").val(value.MakeCode).html(value.MakeName));
                        });
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            $('#<%=drpEditMakeList.ClientID%>').change(function () {
                var makeId = this.value;
                getEditMake(makeId);
            });

            function getEditMake(makeId) {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/GetEditMake",
                    data: "{makeId: '" + makeId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        console.log(Result);
                        console.log(Result.d[0].Cost_Price);
                        $('#<%=txtEditMakeCode.ClientID%>').val(Result.d[0].MakeCode);
                        $('#<%=txtEditMakeDescription.ClientID%>').val(Result.d[0].MakeName);
                        $('#<%=txtEditMakePriceCode.ClientID%>').val(Result.d[0].Cost_Price);
                        $('#<%=txtEditMakeDiscount.ClientID%>').val(Result.d[0].Description);
                        $('#<%=txtEditMakeVat.ClientID%>').val(Result.d[0].VanNo);

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            $('#<%=btnEditMakeSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modEditMake').addClass('hidden');
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddEditMake",
                    data: "{editMakeCode: '" + $('#<%=txtEditMakeCode.ClientID%>').val() + "', editMakeDesc:'" + $('#<%=txtEditMakeDescription.ClientID%>').val() + "', editMakePriceCode:'" + $('#<%=txtEditMakePriceCode.ClientID%>').val() + "', editMakeDiscount:'" + $('#<%=txtEditMakeDiscount.ClientID%>').val() + "', editMakeVat:'" + $('#<%=txtEditMakeVat.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {

                        var res = 'Bilmerke er lagt til.';
                        alert(res);


                    },
                    error: function (result) {
                        alert("Error. Something wrong happened!");
                    }
                });
                //loadEditMake();
                //test
            });

            $('#<%=btnEditMakeDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtEditMakeCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeleteBranch",
                        data: "{editMakeId: '" + $('#<%=txtEditMakeCode.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //console.log(Result);
                        <%--$('#<%=lblAdvBranchStatus.ClientID%>').html($('#<%=txtAdvBranchCode.ClientID%>').val() + " er slettet.");
                    $('#<%=txtAdvBranchCode.ClientID%>').val('');
                    $('#<%=txtAdvBranchText.ClientID%>').val('');
                    $('#<%=txtAdvBranchNote.ClientID%>').val('');
                    $('#<%=txtAdvBranchRef.ClientID%>').val('');
                    loadBranch();--%>

                    },
                        failure: function () {
                            alert("Failed!");
                        }
                    });
                }
                else {
                    $('#<%=lblEditMakeStatus.ClientID%>').html('Vennligst først velg yrkeskoden i listen til venstre før du klikker slett.');
                }


            });

            /*------------End of make edit mod scripts-------------------------------------------------------------------------------------------*/

            $('#<%=btnEquipment.ClientID%>').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modWebEquipment').removeClass('hidden');
            });

            $('#btnSaveEquipment').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modWebEquipment').addClass('hidden');
            });
            $('.modCloseEquipment').on('click', function () {
                $('#modWebEquipment').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });

            $('#btnPrintVehicle').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modPrintVehicle').removeClass('hidden');
            });
            $('.modClosePrint').on('click', function () {
                $('#modPrintVehicle').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });

            /*Annotation on the general tab*/
            $('#btnAddAnnotation').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modGeneralAnnotation').removeClass('hidden');
            });
            $('.modCloseGeneralAnnotation').on('click', function () {
                $('#modGeneralAnnotation').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#<%=btnSaveGeneralAnnotation.ClientID%>').on('click', function () {
                $('#modGeneralAnnotation').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#<%=txtGeneralAnnotation.ClientID%>').val() != "") {
                    $('#exclamIcon').show();
                }
                else {
                    $('#exclamIcon').hide();
                }
            });

            /*Note on the general tab*/
            $('#btnAddNote').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modGeneralNote').removeClass('hidden');
            });
            $('.modCloseGeneralNote').on('click', function () {
                $('#modGeneralNote').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#<%=btnSaveGeneralNote.ClientID%>').on('click', function () {
                $('#modGeneralNote').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#<%=txtGeneralNote.ClientID%>').val() != "") {
                    $('#exclamIcon2').show();
                }
                else {
                    $('#exclamIcon2').hide();
                }
            });

            //ENIRO FUNCTIONS
            $('#<%=CustSelect.ClientID%>').change(function () {
                var eniroId = this.value;
                LoadEniroDet(eniroId);
            });

            //New customer popup
            $('.modCloseCust').on('click', function () {
                $('#modNewCust').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });

            //Code for customer page
            //Eniro customer search functionality

            $('#<%=btnSearchEniro.ClientID%>').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modNewCust').removeClass('hidden');
                FetchEniro($('#<%=txtCustSearchEniro.ClientID()%>').val());
            });

            $('#<%=btnEniroFetch.ClientID%>').on('click', function () {
                FetchEniro($('#<%=txtEniro.ClientID()%>').val());
            });

            function FetchEniro(eniroId) {
                $('#<%=txtCustSearchEniro.ClientID%>').val(eniroId);
                $('#<%=txtEniro.ClientID%>').val(eniroId);

                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/FetchEniro",
                    data: "{search: '" + eniroId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length != 0) {
                            $('#<%=CustSelect.ClientID%>').empty();
                            var res = data.d;
                            $.each(res, function (key, value) {
                                var name = value.CUST_FIRST_NAME + " " + value.CUST_MIDDLE_NAME + " " + value.CUST_LAST_NAME + " - " + value.CUST_PERM_ADD1 + " - " + value.ID_CUST_PERM_ZIPCODE + " " + value.CUST_PERM_ADD2 + " - " + value.CUST_PHONE_MOBILE;
                                $('#<%=CustSelect.ClientID%>').append($("<option></option>").val(value.ENIRO_ID).html(name));
                                 });
                             }
                             else {
                                 alert('No customer was found. Please search with something else as your data.')
                             }
                    },
                    failure: function () {
                        alert("Failed!");
                    },
                    select: function (e, i) {
                        alert('hi');

                    },
                });
                 }

            function LoadEniroDet(eniroId) {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadEniroDet",
                    data: "{EniroId: '" + eniroId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length != 0) {
                            $('#<%=txtCustFirstName.ClientID%>').val(data.d[0].CUST_FIRST_NAME);
                            $('#<%=txtCustMiddleName.ClientID%>').val(data.d[0].CUST_MIDDLE_NAME);
                            $('#<%=txtCustLastName.ClientID%>').val(data.d[0].CUST_LAST_NAME);
                            $('#<%=txtCustAdd1.ClientID%>').val(data.d[0].CUST_PERM_ADD1);
                            $('#<%=txtCustPersonNo.ClientID%>').val(data.d[0].CUST_BORN);
                            $('#<%=txtCustOrgNo.ClientID%>').val(data.d[0].CUST_SSN_NO);
                            $('#<%=txtCustVisitZip.ClientID%>').val(data.d[0].ID_CUST_PERM_ZIPCODE);
                            $('#<%=txtCustVisitPlace.ClientID%>').val(data.d[0].CUST_PERM_ADD2);
                            $('#<%=lblCustEniroId.ClientID%>').text(data.d[0].ENIRO_ID);
                            if (data.d[0].PHONE_TYPE == 'M') {
                                $('#<%=txtCustPhone.ClientID%>').val(data.d[0].CUST_PHONE_MOBILE);
                            }
                            if (data.d[0].PHONE_TYPE == 'T') {
                                $('#<%=txtCustPhone2.ClientID%>').val(data.d[0].CUST_PHONE_MOBILE);
                            }

                            $('#modNewCust').addClass('hidden');
                            $('.overlayHide').removeClass('ohActive');
                            $('#<%=txtCustSearchEniro.ClientID%>').val('');
                        }
                        else {
                            systemMSG('error', 'No customer was found. Please search with something else as your data.', 4000);
                        }
                    },
                    failure: function () {
                        systemMSG('error', 'Something wen wrong.', 4000);
                    }
                });
            }



            //taken from frmWOJobDetails.aspx
            function validateCust(CustomerId) {
                var strRetVal;
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../Transactions/frmWOHead.aspx/ValidateCustomer",
                    data: "{IdCustomer: '" + CustomerId + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        strRetVal = data.d.toString()

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
                return strRetVal;
            }



            $('#<%=txtCustSearchEniro.ClientID%>').autocomplete(
            {
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Transactions/frmWoSearch.aspx/Customer_Search",
                        data: "{q:'" + $('#<%=txtCustSearchEniro.ClientID%>').val() + "', 'isPrivate': '" + true + "', 'isCompany': '" + true + "'}",
                        dataType: "json",
                        success: function (data) {

                            console.log($('#<%=txtCustSearchEniro.ClientID%>').val());
                             if (data.d.length === 0)  // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                             {
                                 response([{ label: 'Ingen treff i lokalt kunderegister. Vil du opprette ny kunde?', value: $('#<%=txtCustSearchEniro.ClientID%>').val(), val: 'new' }]);
                            }
                            else
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.ID_CUSTOMER + " - " + item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME + " - " + item.CUST_PHONE_MOBILE,
                                        val: item.ID_CUSTOMER,
                                        value: item.ID_CUSTOMER + " - " + item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME
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
                    //alert(i.item.val);
                    if (i.item.val != 'new') {
                        $('#<%=txtCustFirstName.ClientID%>').val('');
                        $('#<%=txtCustMiddleName.ClientID%>').val('');
                        $('#<%=txtCustLastName.ClientID%>').val('');
                        $('#<%=txtCustAdd1.ClientID%>').val('');
                        $('#<%=txtCustVisitZip.ClientID%>').val('');
                        $('#<%=txtCustVisitPlace.ClientID%>').val('');
                        $('#<%=txtCustBillAdd.ClientID%>').val('');
                        $('#<%=txtCustBillZip.ClientID%>').val('');
                        $('#<%=txtCustBillPlace.ClientID%>').val('');
                        $('#<%=txtCustPhone.ClientID%>').val('');
                        $('#<%=txtCustPhone2.ClientID%>').val('');
                        $('#<%=txtCustMail.ClientID%>').val('');
                        $('#<%=txtCustPersonNo.ClientID%>').val('');
                        $('#<%=txtCustOrgNo.ClientID%>').val('');

                        $('#<%=txtCustNo.ClientID()%>').val(i.item.val);
                        FetchCustomerDetails(i.item.val);
                    }
                    else {
                        console.log("Inside else statement of select of autocomplete");
                        var custId = $('#<%=txtCustSearchEniro.ClientID%>').val();
                        console.log("Cust id is " + custId);
                        moreInfo("../Master/frmCustomerDetail.aspx?" + "&pageName=Vehicle");
                    }
                }
            });


            /*Autocomplete on the vehicle group*/
            $(function () {
                $('#<%=txtTechVehGrpName.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "frmVehicleDetail.aspx/GetVehGroup",
                            data: "{'VehGrp':'" + $('#<%=txtTechVehGrpName.ClientID%>').val() + "'}",
                            dataType: "json",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[1] + "-" + item.split('-')[2],
                                        val: item.split('-')[0],
                                        value: item.split('-')[2],
                                        desc: item.split('-')[1],
                                        id: item.split('-')[1],

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
                    minLength: 0,
                    select: function (e, i) {
                        $("#<%=txtTechVehGrp.ClientID%>").val(i.item.id);
                        $("#<%=txtTechVehGrpName.ClientID%>").val(i.item.value);
                        //alert(i.item.val); //gir rett id i tbl_mas_settings tabellen
                    },

                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                }
                )
            });

            /*Autocomplete on the fuelcode*/
            $(function () {
                $('#<%=txtTechFuelCode.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "frmVehicleDetail.aspx/GetFuelCode",
                            data: "{'FuelCode':'" + $('#<%=txtTechFuelCode.ClientID%>').val() + "'}",
                            dataType: "json",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[1],
                                        val: item.split('-')[0],
                                        value: item.split('-')[0],
                                        desc: item.split('-')[1],


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
                    minLength: 0,
                    select: function (e, i) {
                        $("#<%=txtTechFuelCode.ClientID%>").val(i.item.value);
                        $("#<%=txtTechFuelName.ClientID%>").val(i.item.desc);
                        //alert(i.item.val); //gir rett id i tbl_mas_settings tabellen
                    },

                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                }
                )
            });

            /*Autocomplete on the WAREHOUSE*/
            $(function () {
                $('#<%=txtTechWarehouse.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "frmVehicleDetail.aspx/GetWareHouse",
                            data: "{'WH':'" + $('#<%=txtTechWarehouse.ClientID%>').val() + "'}",
                            dataType: "json",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0] + "-" + item.split('-')[1] + "-" + item.split('-')[2],
                                        val: item.split('-')[0],
                                        value: item.split('-')[0],
                                        name: item.split('-')[1],
                                        location: item.split('-')[2],

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
                    minLength: 0,
                    select: function (e, i) {
                        $("#<%=txtTechWarehouse.ClientID%>").val(i.item.val);
                        $("#<%=txtTechWarehouseName.ClientID%>").val(i.item.name + " - " + i.item.location);
                        //alert(i.item.val); //gir rett id i tbl_mas_settings tabellen
                    },

                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                }
                )
            });


            //Autocomplete for zip codes
            $('#<%=txtCustVisitZip.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmVehicleDetail.aspx/GetZipCodes",
                        data: "{'zipCode':'" + $('#<%=txtCustVisitZip.ClientID%>').val() + "'}",
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
                    $("#<%=txtCustVisitZip.ClientID%>").val(i.item.val);
                    $("#<%=txtCustVisitPlace.ClientID%>").val(i.item.city);
                },
            });

            $('#<%=txtCustBillZip.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmVehicleDetail.aspx/GetZipCodes",
                        data: "{'zipCode':'" + $('#<%=txtCustBillZip.ClientID%>').val() + "'}",
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
                    $("#<%=txtCustBillZip.ClientID%>").val(i.item.val);
                    $("#<%=txtCustBillPlace.ClientID%>").val(i.item.city);
                },
            });

            /*BilXtrasjekk notatkode*/
            $('.engineOilAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modEngineOil').removeClass('hidden');
            });
            $('.modCloseEngineOil').on('click', function () {
                $('#modEngineOil').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveEngineOilAnnot').on('click', function () {
                $('#modEngineOil').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormEngineOilAnnot').val() != "") {
                    $('.engineOilAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.engineOilAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.cFLevelAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modcFLevel').removeClass('hidden');
            });
            $('.modClosecFLevel').on('click', function () {
                $('#modcFLevel').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSavecFLevelAnnot').on('click', function () {
                $('#modcFLevel').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormcFLevelAnnot').val() != "") {
                    $('.cFLevelAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.cFLevelAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.cfTempAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modcfTemp').removeClass('hidden');
            });
            $('.modClosecfTemp').on('click', function () {
                $('#modcfTemp').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSavecfTempAnnot').on('click', function () {
                $('#modcfTemp').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($("#<%=txtFormcfTempAnnot.ClientID%>").val() != "") {
                    $('.cfTempAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.cfTempAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.brakeFluidAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modbrakeFluid').removeClass('hidden');
            });
            $('.modCloseBrakeFluid').on('click', function () {
                $('#modbrakeFluid').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveBrakeFluidAnnot').on('click', function () {
                $('#modbrakeFluid').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormBrakeFluidAnnot').val() != "") {
                    $('.brakeFluidAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.brakeFluidAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.batteryAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modBattery').removeClass('hidden');
            });
            $('.modCloseBattery').on('click', function () {
                $('#modBattery').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveBatteryAnnot').on('click', function () {
                $('#modBattery').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormBatteryAnnot').val() != "") {
                    $('.batteryAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.batteryAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.vipesFrontAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modVipesFront').removeClass('hidden');
            });
            $('.modCloseVipesFront').on('click', function () {
                $('#modVipesFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveVipesFrontAnnot').on('click', function () {
                $('#modVipesFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormVipesFrontAnnot').val() != "") {
                    $('.vipesFrontAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.vipesFrontAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.vipesBackAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modVipesBack').removeClass('hidden');
            });
            $('.modCloseVipesBack').on('click', function () {
                $('#modVipesBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveVipesBackAnnot').on('click', function () {
                $('#modVipesBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormVipesBackAnnot').val() != "") {
                    $('.vipesBackAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.vipesBackAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.lightsFrontAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modLightsFront').removeClass('hidden');
            });
            $('.modCloseLightsFront').on('click', function () {
                $('#modLightsFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveLightsFrontAnnot').on('click', function () {
                $('#modLightsFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormLightsFrontAnnot').val() != "") {
                    $('.lightsFrontAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.lightsFrontAnnotIcon').removeClass('alarm icon');
                }
            });
            $('.lightsBackAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modLightsBack').removeClass('hidden');
            });
            $('.modCloseLightsBack').on('click', function () {
                $('#modLightsBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveLightsBackAnnot').on('click', function () {
                $('#modLightsBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormLightsBackAnnot').val() != "") {
                    $('.lightsBackAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.lightsBackAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.bumperFrontAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modBumperFront').removeClass('hidden');
            });
            $('.modCloseBumperFront').on('click', function () {
                $('#modBumperFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveBumperFrontAnnot').on('click', function () {
                $('#modBumperFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormBumperFrontAnnot').val() != "") {
                    $('.bumperFrontAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.bumperFrontAnnotIcon').removeClass('alarm icon');
                }
            });
            $('.bumperBackAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modBumperBack').removeClass('hidden');
            });
            $('.modCloseBumperBack').on('click', function () {
                $('#modBumperBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveBumperBackAnnot').on('click', function () {
                $('#modBumperBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormBumperBackAnnot').val() != "") {
                    $('.bumperBackAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.bumperBackAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.tiresFrontAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modTiresFront').removeClass('hidden');
            });
            $('.modCloseTiresFront').on('click', function () {
                $('#modTiresFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveTiresFrontAnnot').on('click', function () {
                $('#modTiresFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormTiresFrontAnnot').val() != "") {
                    $('.tiresFrontAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.tiresFrontAnnotIcon').removeClass('alarm icon');
                }
            });
            $('.tiresBackAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modTiresBack').removeClass('hidden');
            });
            $('.modCloseTiresBack').on('click', function () {
                $('#modTiresBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveTiresBackAnnot').on('click', function () {
                $('#modTiresBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormTiresBackAnnot').val() != "") {
                    $('.tiresBackAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.tiresBackAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.suspensionFrontAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modSuspensionFront').removeClass('hidden');
            });
            $('.modCloseSuspensionFront').on('click', function () {
                $('#modSuspensionFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveSuspensionFrontAnnot').on('click', function () {
                $('#modSuspensionFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormSuspensionFrontAnnot').val() != "") {
                    $('.suspensionFrontAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.suspensionFrontAnnotIcon').removeClass('alarm icon');
                }
            });
            $('.suspensionBackAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modSuspensionBack').removeClass('hidden');
            });
            $('.modCloseSuspensionBack').on('click', function () {
                $('#modSuspensionBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveSuspensionBackAnnot').on('click', function () {
                $('#modSuspensionBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormSuspensionBackAnnot').val() != "") {
                    $('.suspensionBackAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.suspensionBackAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.brakesFrontAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modBrakesFront').removeClass('hidden');
            });
            $('.modCloseBrakesFront').on('click', function () {
                $('#modBrakesFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveBrakesFrontAnnot').on('click', function () {
                $('#modBrakesFront').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormBrakesFrontAnnot').val() != "") {
                    $('.brakesFrontAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.brakesFrontAnnotIcon').removeClass('alarm icon');
                }
            });
            $('.brakesBackAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modBrakesBack').removeClass('hidden');
            });
            $('.modCloseBrakesBack').on('click', function () {
                $('#modBrakesBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveBrakesBackAnnot').on('click', function () {
                $('#modBrakesBack').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormBrakesBackAnnot').val() != "") {
                    $('.brakesBackAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.brakesBackAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.exhaustAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modExhaust').removeClass('hidden');
            });
            $('.modCloseExhaust').on('click', function () {
                $('#modExhaust').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveExhaustAnnot').on('click', function () {
                $('#modExhaust').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormExhaustAnnot').val() != "") {
                    $('.exhaustAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.exhaustAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.sealedEngineAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modSealedEngine').removeClass('hidden');
            });
            $('.modCloseSealedEngine').on('click', function () {
                $('#modSealedEngine').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveSealedEngineAnnot').on('click', function () {
                $('#modSealedEngine').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormSealedEngineAnnot').val() != "") {
                    $('.sealedEngineAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.sealedEngineAnnotIcon').removeClass('alarm icon');
                }
            });

            $('.sealedGearboxAnnot').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modSealedGearbox').removeClass('hidden');
            });
            $('.modCloseSealedGearbox').on('click', function () {
                $('#modSealedGearbox').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
            });
            $('#btnSaveSealedGearboxAnnot').on('click', function () {
                $('#modSealedGearbox').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                if ($('#txtFormSealedGearboxAnnot').val() != "") {
                    $('.sealedGearboxAnnotIcon').addClass('alarm icon');
                }
                else {
                    $('.sealedGearboxAnnotIcon').removeClass('alarm icon');
                }
            });







            /*Code for the "BilXtra-sjekken" to add/remove the check mark*/
            /*Motorolje*/
           

            /*STARTER UTSKRIFT AV VALGT RAPPORT*/
            $('#btnStartPrint').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modPrintVehicle').addClass('hidden');
                window.print();
            });

            //constrainInput: false gjør at en ikke trenger punktumer
            $('#txtLastRegDate').datepicker($.datepicker.regional["no"]);





            $('#<%=txtMileage.ClientID%>').blur(function () {
                if ($('#<%=txtMileage.ClientID%>').val() != '') {
                    $('#<%=txtMileageDate.ClientID%>').datepicker('setDate', new Date());
                    $('#<%=txtType.ClientID%>').focus();
                }

            });
            $('#<%=txtHours.ClientID%>').blur(function () {
                if ($('#<%=txtHours.ClientID%>').val() != '') {
                    $('#<%=txtHoursDate.ClientID%>').datepicker('setDate', new Date());
                    $('#<%=txtType.ClientID%>').focus();
                }
            });

            $.datepicker.setDefaults($.datepicker.regional["no"]);
            $('#<%=txtRegDate.ClientID%>,#<%=txtRegDateNorway.ClientID%>,#<%=txtLastRegDate.ClientID%>,#<%=txtDeregDate.ClientID%>,#<%=txtMileageDate.ClientID%>,#<%=txtHoursDate.ClientID%>,#<%=txtTechDateExpectedIn.ClientID%>,#<%=txtTechTakenInDate.ClientID%>,#<%=txtTechDeliveryDate.ClientID%>,#<%=txtTechServiceDate.ClientID%>,#<%=txtTechCallInDate.ClientID%>,#<%=txtTechCleanedDate.ClientID%>,#<%=txtTechLastPkkOk.ClientID%>,#<%=txtTechNextPkk.ClientID%>,#<%=txtTechLastInvoicedPkk.ClientID%>,#<%=txtEcoCreditDate.ClientID%>,#<%=txtEcoInvoiceDate.ClientID%>,#<%=txtEcoRebuy.ClientID%>,#<%=txtTechTectyl.ClientID%>,#<%=txtPkkDate.ClientID%>,#<%=txtPkkAfterDate.ClientID%>,#<%=txtPerServiceDate.ClientID%>,#<%=txtRentalCarDate.ClientID%>,#<%=txtMoistControl.ClientID%>').datepicker({
                showWeek: true,
                dateFormat: 'dd.mm.yy',
                //showOn: "button",
                //buttonImage: "../images/calendar_icon.gif",
                //buttonImageOnly: true,
                //buttonText: "Velg dato",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+1"

            });
            $('#btnEmptyScreen').on('click', function (e) {
                $('#aspnetForm')[0].reset();
                $('#exclamIcon').hide();
                $('#exclamIcon2').hide();

           });
            //$("#btnEmptyScreen").datepicker($.datepicker.regional["no"]);
            //alert('heisan');

            //$('#btnFetchMVR').on('click', function (e) {
            //    e.preventDefault();
            //});

            $('#btnSaveVehicle').on('click', function () {
                //debugger;
                var vehType = "";
                var vehStatus = "";
                var model = "";
                var machineHrs = "";
                var usedImported = "";
                var pressureMechBrakes = "";
                var towbar = "";
                var serviceBook = "";
                var callInToService = "";
                var doNotCallPKK = "";


                if ($('#<%=ddlVehType.ClientID%> :selected')[0].value != "-1") {
                         vehType = $('#<%=ddlVehType.ClientID%> :selected')[0].value;
                 }
                if ($('#<%=ddlVehStatus.ClientID%> :selected')[0].value != "-1") {
                    vehStatus = $('#<%=ddlVehStatus.ClientID%> :selected')[0].value;
                 }
                if ($('#<%=cmbModelForm.ClientID%>')[0].selectedIndex != "0") {
                    model = $('#<%=cmbModelForm.ClientID%>').val();
                 }
                    <%-- if ($('#<%=cmbModelForm.ClientID%> :selected')[0].value != "-1") {
                         model = $('#<%=cmbModelForm.ClientID%> :selected')[0].value;
                 }--%>
                machineHrs = $('#<%=cbMachineHours.ClientID%>')[0].checked;
                usedImported = $('#<%=cbTechUsedImported.ClientID%>')[0].checked;
                pressureMechBrakes = $('#<%=cbTechPressureMechBrakes.ClientID%>')[0].checked;
                towbar = $('#<%=cbTechTowbar.ClientID%>')[0].checked;
                serviceBook = $('#<%=cbTechServiceBook.ClientID%>')[0].checked;
                callInToService = $('#<%=cbTechCallInService.ClientID%>')[0].checked;
                doNotCallPKK = $('#<%=cbTechDoNotCallPkk.ClientID%>')[0].checked;
                if ($('#<%=txtIntNo.ClientID%>').val() == "") {
                    swal("Du må legge på et refnummer på kjøretøyet før du lagrer!");
                       
                }
                else {
                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmVehicleDetail.aspx/AddVehicle",
                    data: "{refNo: '" + $('#<%=txtIntNo.ClientID%>').val() + "', regNo:'" + $('#<%=txtRegNo.ClientID%>').val() + "', chassi_vin:'" + $('#<%=txtVinNo.ClientID%>').val() + "', vehType:'" + vehType + "', vehStatus:'" + vehStatus + "', makeCode:'" + $('#<%=drpMakeCodes.ClientID%> :selected')[0].text + "', model:'" + model + "', vehicleType:'" + $('#<%=txtVehicleType.ClientID%>').val() + "', annotation:'" + $('#<%=txtGeneralAnnotation.ClientID%>').val() + "', note:'" + $('#<%=txtGeneralNote.ClientID%>').val() + "', modelYear:'" + $('#<%=txtModelyr.ClientID%>').val() + "', regYear:'" + $('#<%=txtRegyr.ClientID%>').val() + "', regDate:'" + $('#<%=txtRegDate.ClientID%>').val() + "', regDateNor:'" + $('#<%=txtRegDateNorway.ClientID%>').val() + "', lastRegDate:'" + $('#<%=txtLastRegDate.ClientID%>').val() + "', deregDate:'" + $('#<%=txtDeregDate.ClientID%>').val() + "', color:'" + $('#<%=txtColor.ClientID%>').val() + "', mileage:'" + $('#<%=txtMileage.ClientID%>').val() + "', mileageDate:'" + $('#<%=txtMileageDate.ClientID%>').val() + "', hours:'" + $('#<%=txtHours.ClientID%>').val() + "', hoursDate:'" + $('#<%=txtHoursDate.ClientID%>').val() + "', machineHrs:'" + machineHrs + "', category:'" + $('#<%=txtCategory.ClientID%>').val() + "', modelType:'" + $('#<%=txtType.ClientID%>').val() + "', warrantyCode:'" + $('#<%=drpWarrantyCode.ClientID%>').val() + "', netWeight:'" + $('#<%=txtNetWeight.ClientID%>').val() + "', totWeight:'" + $('#<%=txtTotWeight.ClientID%>').val() + "', projNo:'" + $('#<%=txtProjectNo.ClientID%>').val() + "', lastContDate:'" + $('#<%=txtLastContactDate.ClientID%>').val() + "', practicalLoad:'" + $('#<%=txtPracticalLoad.ClientID%>').val() + "', maxRoofLoad:'" + $('#<%=txtMaxRoofLoad.ClientID%>').val() + "', earlrRegNo1:'" + $('#<%=txtEarlyRegNo1.ClientID%>').val() + "', earlrRegNo2:'" + $('#<%=txtEarlyRegNo2.ClientID%>').val() + "', earlrRegNo3:'" + $('#<%=txtEarlyRegNo3.ClientID%>').val() + "', earlrRegNo4:'" + $('#<%=txtEarlyRegNo4.ClientID%>').val() + "', vehGroup:'" + $('#<%=txtTechVehGrp.ClientID%>').val() + "', pickNo:'" + $('#<%=txtTechPick.ClientID%>').val() + "', makeCodeNo:'" + $('#<%=txtTechMake.ClientID%>').val() + "', ricambiNo:'" + $('#<%=txtTechRicambiNo.ClientID%>').val() + "', engineNo:'" + $('#<%=txtTechEngineNo.ClientID%>').val() + "', fuelCode:'" + $('#<%=txtTechFuelCode.ClientID%>').val() + "', fuelCard:'" + $('#<%=txtTechFuelCard.ClientID%>').val() + "', gearBox:'" + $('#<%=txtTechGearBox.ClientID%>').val() +
                         "', wareHouse:'" + $('#<%=txtTechWarehouse.ClientID%>').val() + "', keyNo:'" + $('#<%=txtTechKeyNo.ClientID%>').val() + "', doorKeyNo:'" + $('#<%=txtTechDoorKeyNo.ClientID%>').val() + "', controlForm:'" + "" + "', interiorCode:'" + $('#<%=txtTechInteriorCode.ClientID%>').val() + "', purchaseNo:'" + $('#<%=txtTechPurchaseNo.ClientID%>').val() + "', addonGroup:'" + $('#<%=txtTechAddonGrp.ClientID%>').val() +
                         "', dateExpectedIn:'" + $('#<%=txtTechDateExpectedIn.ClientID%>').val() + "', tires:'" + $('#<%=txtTechTireInfo.ClientID%>').val() + "', serviceCategory:'" + $('#<%=txtTechServiceCategory.ClientID%>').val() + "', noApprovalNo:'" + $('#<%=txtTechApprovalNo.ClientID%>').val() + "', euApprovalNo:'" + $('#<%=txtTechEUApprovalNo.ClientID%>').val() + "', vanNo:'" + $('#<%=txtTechVanNo.ClientID%>').val() + "', productNo:'" + $('#<%=txtTechProductNo.ClientID%>').val() +
                         "', elCode:'" + $('#<%=txtTechElCode.ClientID%>').val() + "', takenInDate:'" + $('#<%=txtTechTakenInDate.ClientID%>').val() + "', takenInDateMileage:'" + $('#<%=txtTechMileageTakenIn.ClientID%>').val() + "', deliveryDate:'" + $('#<%=txtTechDeliveryDate.ClientID%>').val() + "', deliveryDateMileage:'" + $('#<%=txtTechMileageDelivered.ClientID%>').val() + "', serviceDate:'" + $('#<%=txtTechServiceDate.ClientID%>').val() + "', serviceDateMileage:'" + $('#<%=txtTechMileageService.ClientID%>').val() + "', callInDate:'" + $('#<%=txtTechCallInDate.ClientID%>').val() + "', callInDateMileage:'" + $('#<%=txtTechMileageCallIn.ClientID%>').val() + "', cleanedDate:'" + $('#<%=txtTechCleanedDate.ClientID%>').val() +
                         "', techdocNo:'" + $('#<%=txtTechTechdocNo.ClientID%>').val() + "', length:'" + $('#<%=txtTechLength.ClientID%>').val() + "', width:'" + $('#<%=txtTechWidth.ClientID%>').val() + "', noise:'" + $('#<%=txtTechNoise.ClientID%>').val() + "', effectkW:'" + $('#<%=txtTechEffect.ClientID%>').val() + "', pistonDisp:'" + $('#<%=txtTechPistonDisp.ClientID%>').val() + "', rounds:'" + $('#<%=txtTechRoundperMin.ClientID%>').val() + "', usedImported:'" + usedImported + "', pressureMechBrakes:'" + pressureMechBrakes + "', towbar:'" + towbar + "', serviceBook:'" + serviceBook + "', lastPKKApproved:'" + $('#<%=txtTechLastPkkOk.ClientID%>').val() + "', nextPKK:'" + $('#<%=txtTechNextPkk.ClientID%>').val() +
                         "', lastPKKInvoiced:'" + $('#<%=txtTechLastInvoicedPkk.ClientID%>').val() + "', callInToService:'" + callInToService + "', callInMonth:'" + $('#<%=txtTechCallInMonth.ClientID%>').val() + "', techMileage:'" + $('#<%=txtTechMileage.ClientID%>').val() + "', doNotCallPKK:'" + doNotCallPKK + "', deviationPKK:'" + $('#<%=txtTechDeviationsPkk.ClientID%>').val() + "', yearlyMileage:'" + $('#<%=txtTechYearlyMileage.ClientID%>').val() + "', radioCode:'" + $('#<%=txtTechRadioCode.ClientID%>').val() + "', startImmobilizer:'" + $('#<%=txtTechStartImmobilizer.ClientID%>').val() + "', qtyKeys:'" + $('#<%=txtTechQtyKeys.ClientID%>').val() + "', keyTag:'" + $('#<%=txtTechKeyTag.ClientID%>').val() +
                         "', salesPriceNet:'" + $('#<%=txtEcoSalespriceNet.ClientID%>').val() + "', salesSale:'" + $('#<%=txtEcoSalesSale.ClientID%>').val() + "', salesEquipment:'" + $('#<%=txtEcoSalesEquipment.ClientID%>').val() + "', regCosts:'" + $('#<%=txtEcoRegCost.ClientID%>').val() + "', discount:'" + $('#<%=txtEcoDiscount.ClientID%>').val() + "', netSalesPrice:'" + $('#<%=txtEcoNetSalesPrice.ClientID%>').val() + "', fixCost:'" + $('#<%=txtEcoFixCost.ClientID%>').val() + "', assistSales:'" + $('#<%=txtEcoAssistSales.ClientID%>').val() + "', costAfterSale:'" + $('#<%=txtEcoCostAfterSale.ClientID%>').val() + "', contributionsToday:'" + $('#<%=txtEcoContributionsToday.ClientID%>').val() + "', salesPriceGross:'" + $('#<%=txtEcoSalesPriceGross.ClientID%>').val() + "', regFee:'" + $('#<%=txtEcoRegFee.ClientID%>').val() + "', vat:'" + $('#<%=txtEcoVat.ClientID%>').val() + "', totAmount:'" + $('#<%=txtEcoVehTotAmount.ClientID%>').val() + "', wreckingAmount:'" + $('#<%=txtEcoWreckingAmount.ClientID%>').val() + "', yearlyFee:'" + $('#<%=txtEcoYearlyFee.ClientID%>').val() + "', insurance:'" + $('#<%=txtEcoInsurance.ClientID%>').val() + "', costPriceNet:'" + $('#<%=txtEcoCostPriceNet.ClientID%>').val() + "', insuranceBonus:'" + $('#<%=txtEcoInsuranceBonus.ClientID%>').val() + "', costSales:'" + $('#<%=txtEcoInntakeSaler.ClientID%>').val() + "', costBeforeSale:'" + $('#<%=txtEcoCostBeforeSale.ClientID%>').val() + "', salesProvision:'" + $('#<%=txtEcoSalesProvision.ClientID%>').val() + "', commitDay:'" + $('#<%=txtEcoCommitDay.ClientID%>').val() + "', addedInterests:'" + $('#<%=txtEcoAddedInterests.ClientID%>').val() + "', costEquipment:'" + $('#<%=txtEcoCostEquipment.ClientID%>').val() + "', totalCost:'" + $('#<%=txtEcoTotalCost.ClientID%>').val() +
                         "', creditNoteNo:'" + $('#<%=txtEcoCreditNote.ClientID%>').val() + "', creditNoteDate:'" + $('#<%=txtEcoCreditDate.ClientID%>').val() + "', invoiceNo:'" + $('#<%=txtEcoInvoiceNo.ClientID%>').val() + "', invoiceDate:'" + $('#<%=txtEcoInvoiceDate.ClientID%>').val() + "', rebuyDate:'" + $('#<%=txtEcoRebuy.ClientID%>').val() + "', rebuyPrice:'" + $('#<%=txtEcoRebuyPrice.ClientID%>').val() + "', costPerKm:'" + $('#<%=txtEcoCostKm.ClientID%>').val() + "', turnover:'" + $('#<%=txtEcoTurnover.ClientID%>').val() + "', progress:'" + $('#<%=txtEcoProgress.ClientID%>').val() +
                         "', axle1:'" + $('#<%=txtTraAxle1.ClientID%>').val() + "', axle2:'" + $('#<%=txtTraAxle2.ClientID%>').val() + "', axle3:'" + $('#<%=txtTraAxle3.ClientID%>').val() + "', axle4:'" + $('#<%=txtTraAxle4.ClientID%>').val() + "', axle5:'" + $('#<%=txtTraAxle5.ClientID%>').val() + "', axle6:'" + $('#<%=txtTraAxle6.ClientID%>').val() + "', axle7:'" + $('#<%=txtTraAxle7.ClientID%>').val() + "', axle8:'" + $('#<%=txtTraAxle8.ClientID%>').val() + "', trailerDesc:'" + $('#<%=txtTraDesc.ClientID%>').val() +
                            "', tireDimFront:'" + $('#<%=txtCertTireDimFront.ClientID%>').val() + "', tireDimBack:'" + $('#<%=txtCertTireDimBack.ClientID%>').val() + "', minliFront:'" + $('#<%=txtCertLiFront.ClientID%>').val() + "', minliBack:'" + $('#<%=txtCertLiBack.ClientID%>').val() + "', minInpressFront:'" + $('#<%=txtCertMinInpressFront.ClientID%>').val() + "', minInpressBack:'" + $('#<%=txtCertMinInpressBack.ClientID%>').val() + "', stdRimFront:'" + $('#<%=txtCertRimFront.ClientID%>').val() + "', stdRimBack:'" + $('#<%=txtCertRimBack.ClientID%>').val() + "', minSpeedFront:'" + $('#<%=txtCertminSpeedFront.ClientID%>').val() + "', minSpeedBack:'" + $('#<%=txtCertMinSpeedBack.ClientID%>').val() + "', maxTrackFront:'" + $('#<%=txtCertMaxWidthFront.ClientID%>').val() + "', maxTrackBack:'" + $('#<%=txtCertMaxWidthBack.ClientID%>').val() + "', axlePressureFront:'" + $('#<%=txtCertAxlePressureFront.ClientID%>').val() + "', axlePressureBack:'" + $('#<%=txtCertAxlePressureBack.ClientID%>').val() + "', qtyAxles:'" + $('#<%=txtCertAxleQty.ClientID%>').val() + "', operativeAxles:'" + $('#<%=txtCertAxleWithTraction.ClientID%>').val() + "', driveWheel:'" + $('#<%=txtCertGear.ClientID%>').val() + "', trailerWithBrakes:'" + $('#<%=txtCertTrailerWeightBrakes.ClientID%>').val() + "', trailerWeight:'" + $('#<%=txtCertTrailerWeight.ClientID%>').val() + "', maxLoadTowbar:'" + $('#<%=txtCertWeightTowbar.ClientID%>').val() + "', lengthToTowbar:'" + $('#<%=txtCertLengthTowbar.ClientID%>').val() + "', totalTrailerWeight:'" + $('#<%=txtCertTotalTrailerWeight.ClientID%>').val() + "', seats:'" + $('#<%=txtCertSeats.ClientID%>').val() + "', validFrom:'" + $('#<%=txtCertValidFrom.ClientID%>').val() + "', euVersion:'" + $('#<%=txtCertEuVersion.ClientID%>').val() + "', euVariant:'" + $('#<%=txtCertEuVariant.ClientID%>').val() + "', euronorm:'" + $('#<%=txtCertEuronorm.ClientID%>').val() + "', co2Emission:'" + $('#<%=txtCertCo2Emission.ClientID%>').val() + "', makeParticleFilter:'" + $('#<%=txtCertMakeParticleFilter.ClientID%>').val() + "', chassiText:'" + $('#<%=txtCertChassi.ClientID%>').val() + "', identity:'" + $('#<%=txtCertIdentity.ClientID%>').val() + "', certificate:'" + $('#<%=txtCertCertificate.ClientID%>').val() + "', certificateAnnotation:'" + $('#<%=txtCertNotes.ClientID%>').val() + "', idCustomer:'" + $('#<%=txtCustNo.ClientID%>').val() + "', idVatCode:'" + $('#<%=ddlVatCode.ClientID%>').val() + "', idOwnerId:'" + tbOwnerNo.GetText() + "', idLeasingId:'" + tbLeasingNo.GetText() + "', idBuyerId:'" + tbBuyerNo.GetText() + "', idDriverId:'" + tbDriverNo.GetText() + "'}",
                         dataType: "json",
                    success: function (data) {
                        //debugger;
                        console.log(data.d[0]);
                             if (data.d[0] == "INSFLG") {
                                 var res = GetMultiMessage('MSG126', '', '');
                                 //alert(res);
                                 systemMSG('success', 'Kjøretøydetaljer ble lagret', 4000);
                                 $('#<%=txtIntNo.ClientID%>').val(data.d[2]);
                             var idVehSeq = data.d[1].toString();
                             if (window.parent != undefined && window.parent != null && window.parent.length > 0) {
                                 if (pageNameFrom == "Vehicle") { window.parent.document.getElementById('ctl00_cntMainPanel_txtCustNo').value = data.d[1]; }
                                 else if (pageNameFrom == "AppointmentFormVehicle") {
                                     
                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_txtSrchVeh').value = data.d[1];
                                     
                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbRegNo_I').value = $('#<%=txtRegNo.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbChNo_I').value = $('#<%=txtVinNo.ClientID%>').val();
                                     
                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbRefNo_I').value = $('#<%=txtIntNo.ClientID%>').val();
                                     //window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_cbMake_I').value = ($('#<%=drpMakeCodes.ClientID%> :selected').text()).trim(); 
                                     window.parent.cbMake.SetText($('#<%=drpMakeCodes.ClientID%> :selected').text().trim()); 
                                     //window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchVeh').value = idVehSeq;
                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_txtbxModel').value=$('#<%=txtVehicleType.ClientID%>').val();
                                     
                                     //window.parent.FillVehDetails(data.d[1]);
                                     window.parent.$('.ui-dialog-content:visible').dialog('close');
                                     if ($('#<%=txtCustNo.ClientID%>').val().trim() != "") {
                                         window.parent.tbCustomerNo.SetText($('#<%=txtCustNo.ClientID%>').val());
                                         window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbFirstName_I').value = $('#<%=txtCustFirstName.ClientID%>').val();

                                         window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbMiddleName_I').value = $('#<%=txtCustMiddleName.ClientID%>').val();

                                         window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbLastName_I').value = $('#<%=txtCustLastName.ClientID%>').val();

                                         window.parent.cbxFirma.SetChecked($('#<%=chkPrivOrSub.ClientID%>').is(':checked'));
                                     }

                                     return;
                                 }
                                 else if (pageNameFrom == "TireHotel") {
                                     //debugger;
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtTireRefNo').value = $('#<%=txtIntNo.ClientID%>').val();

                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtTireRegNo').value = $('#<%=txtRegNo.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateMake').value = ($('#<%=drpMakeCodes.ClientID%> :selected').text()).trim(); 

                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateModel').value = $('#<%=txtVehicleType.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateOrgTireDimFront').value = $('#<%=txtCertTireDimFront.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateOrgTireDimBack').value = $('#<%=txtCertTireDimBack.ClientID%>').val();                                     
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtTireDimFront').value = $('#<%=txtCertTireDimFront.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtTireDimBack').value = $('#<%=txtCertTireDimBack.ClientID%>').val(); 
                                     var refValue = $('#<%=txtIntNo.ClientID%>').val().slice(2);
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtTirePackageNo').value = refValue;
                                     window.parent.FetchCustomerDetails($('#<%=txtCustNo.ClientID%>').val());
                                     window.parent.$('.ui-dialog-content:visible').dialog('close');
                                 }
                                 var idModel;
                                 var make = $('#<%=drpMakeCodes.ClientID%>').val();
                                 var model = $('#<%=cmbModelForm.ClientID%> :selected')[0].innerText;

                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtRegNo').value = $('#<%=txtRegNo.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtVIN').value = $('#<%=txtVinNo.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtMileage').value = $('#<%=txtMileage.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtHours').value = $('#<%=txtHours.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtInternalNo').value = $('#<%=txtIntNo.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_ddlMake').value = $('#<%=drpMakeCodes.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchVeh').value = idVehSeq;

                                 if ($("#<%=txtCustNo.ClientID%>").val().length > 0) {
                                     window.parent.FillCustDet($("#<%=txtCustNo.ClientID%>").val());
                                 }

                                 idModel = $('#<%=cmbModelForm.ClientID%>').val();
                                 //FetchModelId(make, model);
                                 //window.parent.document.getElementById('ctl00_cntMainPanel_ddlModel').value = idModel; // Commented this line because of the error

                                 //window.opener.document.getElementById('ctl00_cntMainPanel_ddlModel option:contains("' + $('#<%=cmbModelForm.ClientID%> :selected')[0].innerText + '")');//.attr('selected', 'selected');
                                 // window.self.close();
                                 window.parent.$('.ui-dialog-content:visible').dialog('close');
                             }
                         }
                         else if (data.d[0] == "UPDFLG") {
                             var res = GetMultiMessage('UPDATED', '', '');
                             //alert(res);
                             systemMSG('success', 'Kjøretøydetaljer ble oppdatert', 4000);
                             var idVehSeq = data.d[1].toString();
                             // $('#<%=txtIntNo.ClientID%>').val(data.d[2]);
                             if (window.parent != undefined && window.parent != null && window.parent.length > 0) {
                                 var idModel;
                                <%-- var make = $('#<%=drpMakeCodes.ClientID%>').val();
                                 var model = $('#<%=cmbModelForm.ClientID%> :selected')[0].innerText;--%>
                                 if (pageNameFrom == "AppointmentFormVehicle") {

                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_txtSrchVeh').value = data.d[1];

                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbRegNo_I').value = $('#<%=txtRegNo.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbChNo_I').value = $('#<%=txtVinNo.ClientID%>').val();

                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbRefNo_I').value = $('#<%=txtIntNo.ClientID%>').val();
                                 //window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_cbMake_I').value = ($('#<%=drpMakeCodes.ClientID%> :selected').text()).trim();
                                 window.parent.cbMake.SetText($('#<%=drpMakeCodes.ClientID%> :selected').text().trim());
                                     //window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchVeh').value = idVehSeq;
                                     window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_txtbxModel').value = $('#<%=txtVehicleType.ClientID%>').val();


                                     //window.parent.FillVehDetails(data.d[1]);
                                     window.parent.$('.ui-dialog-content:visible').dialog('close');
                                if ($('#<%=txtCustNo.ClientID%>').val().trim() != "") {
                                    window.parent.tbCustomerNo.SetText($('#<%=txtCustNo.ClientID%>').val());
                                    window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbFirstName_I').value = $('#<%=txtCustFirstName.ClientID%>').val();

                                    window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbMiddleName_I').value = $('#<%=txtCustMiddleName.ClientID%>').val();

                                    window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbLastName_I').value = $('#<%=txtCustLastName.ClientID%>').val();

                                    window.parent.cbxFirma.SetChecked($('#<%=chkPrivOrSub.ClientID%>').is(':checked'));
                                }
                                
                                return;
                                 }
                                 else if (pageNameFrom == "TireHotel") {
                                     //debugger;
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtTireRefNo').value = $('#<%=txtIntNo.ClientID%>').val();

                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtTireRegNo').value = $('#<%=txtRegNo.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateMake').value = ($('#<%=drpMakeCodes.ClientID%> :selected').text()).trim();

                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateModel').value = $('#<%=txtVehicleType.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateOrgTireDimFront').value = $('#<%=txtCertTireDimFront.ClientID%>').val();
                                     window.parent.document.getElementById('ctl00_cntMainPanel_txtCreateOrgTireDimBack').value = $('#<%=txtCertTireDimBack.ClientID%>').val();                                     
                                    
                                     window.parent.FetchCustomerDetails($('#<%=txtCustNo.ClientID%>').val());
                                     window.parent.$('.ui-dialog-content:visible').dialog('close');
                                 }

                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtRegNo').value = $('#<%=txtRegNo.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtVIN').value = $('#<%=txtVinNo.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtMileage').value = $('#<%=txtMileage.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtHours').value = $('#<%=txtHours.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtInternalNo').value = $('#<%=txtIntNo.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_ddlMake').value = $('#<%=drpMakeCodes.ClientID%>').val();
                                 window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchVeh').value = idVehSeq;

                                 if ($("#<%=txtCustNo.ClientID%>").val().length > 0) {
                                     window.parent.FillCustDet($("#<%=txtCustNo.ClientID%>").val());
                                 }

                                 idModel = $('#<%=cmbModelForm.ClientID%>').val();
                                 //FetchModelId(make, model);
                                 window.parent.document.getElementById('ctl00_cntMainPanel_ddlModel').value = idModel;
                                 window.parent.$('.ui-dialog-content:visible').dialog('close');
                             }
                         }
                     },
                         error: function (result) {
                             alert("Error");
                         }
                     });
                }
            });

            function sendData(make, num) {
               
                var regnr =  $('#<%=txtRegNo.ClientID%>').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmVehicleDetail.aspx/INSERT_EXTRA",
                    data: "{'regnr':'" + regnr + "','OIL':'" + model + "'}",
                    //data: {},
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        modelId = data.d.toString();
                    }
                });

                return modelId;
            }



            function FetchModelId(make, model) {
                var modelId = "";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmVehicleDetail.aspx/FetchModel",
                    data: "{'IdMake':'" + make + "','Model':'" + model + "'}",
                    //data: {},
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        modelId = data.d.toString();
                    }
                });

                return modelId;
            }

            function loadMakeCode() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadMakeCode",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpMakeCodes.ClientID%>').empty();
                        $('#<%=drpMakeCodes.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpMakeCodes.ClientID%>').append($("<option></option>").val(value.Id_Make_Veh).html(value.MakeName));

                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            function loadModel() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadModel",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //debugger;
                        Result = Result.d;
                        $('#<%=cmbModelForm.ClientID%>').empty();
                        $('#<%=cmbModelForm.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $.each(Result, function (key, value) {
                            $('#<%=cmbModelForm.ClientID%>').append($("<option></option>").val(value.Id_Model).html(value.Model_Desc));
                            $('#<%=cmbModelForm.ClientID%>')[0].selectedIndex = 5;
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function loadVatCode() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadVatCode",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {

                        Result = Result.d;
                        $('#<%=ddlVatCode.ClientID%>').empty();


                        $.each(Result, function (key, value) {

                            $('#<%=ddlVatCode.ClientID%>').append($("<option></option>").val(value.vatCode).html(value.vatDesc));
                            $('#<%=ddlVatCode.ClientID%>')[0].selectedIndex = 0;
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }


            function loadImages(regNo) {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadImages",
                    data: "{'regNo':'" + regNo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        
                        Result = Result.d;
                        var row = 0;
                        var column = 0;
                        var content = "<table>"
                        var content2 = ""
                        var x = 0;
                        $.each(Result, function (key, value) {
                            
                            //$('#pictureTable').append('<tr><td><a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 100px"/></a></td><td>more data</td></tr>');
                            
                                //alert(value.FILEPATH);
                            
                            //if (column == 0) {
                            //    $('#mainPicture').append('<a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 500px" /></a>');
                            //    column = 1;
                            //}
                            
                            //else if (column == 1) {
                            //    content += '<tr><td><a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 100px"/></a></td>';
                            //    column = 2;
                                    
                                   
                            //}
                            //else {
                            //    content += '<td><a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 100px"/></a></td></tr>';
                            //    column = 1;
                                    
                            //}

                            content += '<tr><td><a href="#" onclick="viewPicture(this)" value= "' + value.FILEPATH + '">' + value.FILENAME + '</a></td></tr>';
                            //x = x + 1; 
                            //content2 += '<li><a href="#" onclick="viewPicture(this)" value= "' + value.FILEPATH + '">' + value.FILENAME + '</a></li>';
                            //content += '<li id="openImage" value="' + value.FILEPATH + '">' + value.FILENAME + '</li>';
                            x = x + 1; 
                          

                            //mainPicture



                            
                        });
                        content = content + "</table>"
                        $('#pictureTable').append(content);
                        //$('#pictureUl').append(content2);
                        
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function loadDocuments(regNo) {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadDocs",
                    data: "{'regNo':'" + regNo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {

                        Result = Result.d;
                        var row = 0;
                        var column = 0;
                        var content = "<table>"
                        var content2 = ""
                        var x = 0;
                        $.each(Result, function (key, value) {

                            //$('#pictureTable').append('<tr><td><a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 100px"/></a></td><td>more data</td></tr>');

                            //alert(value.FILEPATH);

                            //if (column == 0) {
                            //    $('#mainPicture').append('<a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 500px" /></a>');
                            //    column = 1;
                            //}

                            //else if (column == 1) {
                            //    content += '<tr><td><a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 100px"/></a></td>';
                            //    column = 2;


                            //}
                            //else {
                            //    content += '<td><a href="' + value.FILEPATH + '" target="_blank"><img src="' + value.FILEPATH + '" style="max-width: 100px"/></a></td></tr>';
                            //    column = 1;

                            //}

                            content += '<tr><td><a href="#" onclick="viewDocument(this)" value= "' + value.FILEPATH + '">' + value.FILENAME + '</a></td></tr>';
                            //x = x + 1; 
                            //content2 += '<li><a href="#" onclick="viewPicture(this)" value= "' + value.FILEPATH + '">' + value.FILENAME + '</a></li>';
                            //content += '<li id="openImage" value="' + value.FILEPATH + '">' + value.FILENAME + '</li>';
                            x = x + 1;


                            //mainPicture




                        });
                        content = content + "</table>"
                        $('#documentTable').append(content);
                        //$('#pictureUl').append(content2);

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }
           

            //$("#pictureUl .openImage").on('click', function (e) {
               
            //    alert("You clicked !");
            //});
            //$('.openImage').click(function (e) {
            //    console.log("clicked the list");
            //    var href = $(this).val();
            //    alert("You clicked " + href + " !");
            //    //alert($(this).find("a[href]").attr('href'));
            //    //$('#mainPicture').empty();
            //    //$('#mainPicture').append('<img src="' + href + '" style="max-width: 500px" />');
            //});

            function loadNewUsedCode() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadNewUsedCode",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=ddlVehicleType.ClientID%>').empty();
                        $('#<%=ddlVehType.ClientID%>').empty();
                        $('#<%=ddlVehType.ClientID%>').prepend("<option value='-1'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=ddlVehicleType.ClientID%>').append($("<option></option>").val(value.RefnoCode).html(value.RefnoDescription));
                            $('#<%=ddlVehType.ClientID%>').append($("<option></option>").val(value.RefnoCode).html(value.RefnoDescription));
                            $('#<%=txtRefNoCreate.ClientID%>').val(value.refno);
                        });


                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }
            //Fetches the refno value based on the selected new/used value with a standard of value 2 which is "brukt bil"
            function getNewUsedRefNo() {

                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/GetNewUsedRefNo",
                    data: '{refNo: ' + $('#<%=ddlVehicleType.ClientID%> option:selected').val() + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $.each(Result.d, function (key, value) {
                            $('#<%=txtRefNoCreate.ClientID%>').val(value.RefnoPrefix + value.RefnoCount);
                        })
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            //Fetches the refno value based on the selected new/used value with a standard of value 2 which is "brukt bil"
            function setNewUsedRefNo() {

                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/SetNewUsedRefNo",
                    data: '{refNoType: ' + $('#<%=ddlVehType.ClientID%> option:selected').val() + 'refNo: ' + $('#<%=txtIntNo.ClientID%>').val() + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $.each(Result.d, function (key, value) {
                            $('#<%=txtIntNo.ClientID%>').val(value.RefnoPrefix + value.RefnoCount);
                        })
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            //updates and fetches the correct refno value based on the selected new/used value with a standard of value 2 which is "brukt bil"
            $('#<%=txtRefNoCreate.ClientID%>').on('blur', function () {

                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/FetchVehicleDetails",
                    data: "{'refNo':'" + $('#<%=txtRefNoCreate.ClientID%>').val() + "', 'regNo':'" + '' + "', 'vehId':'" + '' + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d[0] == null) {
                            console.log('OK');
                        } else {
                            console.log('Error');
                            $('.overlayHide').removeClass('ohActive');
                            $('#modNewVehicle').addClass('hidden');
                            $('#mceMSG').html('Refnr er allerede i bruk på et kjøretøy ' + data.d[0].VehRegNo + ' ' + data.d[0].Make + ' ' + data.d[0].Id_Veh_Seq + ', vil du åpne kjøretøy for redigering eller vil du prøve et annet nummer?')
                            $('#modVehicleExists').modal('setting', {
                                autofocus: false,
                                onShow: function () {
                                },
                                onDeny: function () {
                                    $('.overlayHide').addClass('ohActive');
                                    $('#modNewVehicle').removeClass('hidden');
                                    $('#<%=txtRefNoCreate.ClientID%>').val('');
                                    $('#<%=txtRefNoCreate.ClientID%>').focus();
                                },
                                onApprove: function () {
                                    FetchVehicleDetails(data.d[0].VehRegNo, '', '', '');
                                }
                            }).modal('show');
                        }
                    }
                });
            });


            //on selected change on new/used, it sends the correct value to get the new refno to the new added vehicle.
            $('#<%=ddlVehicleType.ClientID%>').on('change', function () {
                //alert(this.value); // or $(this).val()
                getNewUsedRefNo($(this).val());
            });

            function loadStatusCode() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadStatusCode",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=ddlVehicleStatus.ClientID%>').empty();
                        $('#<%=ddlVehStatus.ClientID%>').empty();
                        $('#<%=ddlVehStatus.ClientID%>').prepend("<option value='-1'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=ddlVehicleStatus.ClientID%>').append($("<option></option>").val(value.StatusCode).html(value.StatusDesc));
                            $('#<%=ddlVehStatus.ClientID%>').append($("<option></option>").val(value.StatusCode).html(value.StatusDesc));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function loadWarrantyCode() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadWarrantyCode",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpWarrantyCode.ClientID%>').empty();
                        $('#<%=drpWarrantyCode.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpWarrantyCode.ClientID%>').append($("<option></option>").val(value.WarrantyCodes).html(value.WarrantyDesc));

                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }
            $('#invoicehistory').click(function () {
                $("#history-table").tabulator("setData", "frmVehicleDetail.aspx/Fetch_Invoices", { 'Refno': $('#<%=txtIntNo.ClientID%>').val() })
                    .then(function () {
                        //run code after table has been successfuly updated
                        $("#history-table").tabulator("redraw", true);
                        var rowCount = $("#history-table").tabulator("getDataCount");
                        //$('#rowcounter').text(rowCount);
                    })
                    .catch(function (error) {
                        //handle error loading data
                    });
            });

            

            function FetchMVR() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/FetchMVRDetails",
                    data: "{regNo: '" + $('#<%=txtRegNo.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length != 0) {

                            var vehModel = data.d[0].Model;
                            var vehType = data.d[0].VehType;
                            var modelType = vehModel;
                            <%--$('#<%=drpMakeCodes.ClientID%>').val(data.d[0].MakeCode);--%>
                            //$('#<%=drpMakeCodes.ClientID%> option:contains("' + data.d[0].Make + '")').attr('selected', 'selected');
                            $('#<%=drpMakeCodes.ClientID%>').val(data.d[0].MakeCode);
                            $('#<%=txtGeneralMake.ClientID%>').val(data.d[0].Make);
                            $('#<%=txtVehicleType.ClientID%>').val(modelType);


                            /*Issue #22. Setting correct regdate based on 2 fields from MVR that needs to be split to work properly*/
                            if (data.d[0].RegYear) { }
                            var reg = data.d[0].RegYear;
                            //console.log(reg);
                            var lengthCheck = reg.toString().length;
                            //console.log(lengthCheck);
                            if (lengthCheck == 1) {
                                var month = '01';
                                var day = '01';
                                //alert(day + " " + month);
                                $('#<%=txtRegDate.ClientID%>').val(day + '.' + month + '.' + data.d[0].ModelYear);
                                 }
                                 if (lengthCheck == 3) {
                                     var month = '0' + reg.toString().substring(0, 1);
                                     var day = reg.toString().substring(1, 3);
                                     //alert(day + " " + month);
                                     $('#<%=txtRegDate.ClientID%>').val(day + '.' + month + '.' + data.d[0].ModelYear);
                                 }
                                 if (lengthCheck == 4) {
                                     var month = reg.toString().substring(0, 2);
                                     var day = reg.toString().substring(2, 4);
                                     //alert(day + " " + month);
                                     $('#<%=txtRegDate.ClientID%>').val(day + '.' + month + '.' + data.d[0].ModelYear);
                                 }

                            //$('#<%=txtRegDate.ClientID%>').val(data.d[0].RegYear + "." + data.d[0].ModelYear);
                            $('#<%=txtDeregDate.ClientID%>').val(data.d[0].DeRegDate);
                            $('#<%=txtTotWeight.ClientID%>').val(data.d[0].TotalWeight);
                            $('#<%=txtNetWeight.ClientID%>').val(data.d[0].NetWeight);
                            $('#<%=txtRegDateNorway.ClientID%>').val(data.d[0].RegDateNorway);
                            $('#<%=txtLastRegDate.ClientID%>').val(data.d[0].LastRegDate);
                            $('#<%=txtRegyr.ClientID%>').val(data.d[0].ModelYear);
                            $('#<%=txtModelyr.ClientID%>').val(data.d[0].ModelYear);
                            $('#<%=txtColor.ClientID%>').val(data.d[0].Color);
                            $('#<%=txtTechVin.ClientID%>').val(data.d[0].VehVin);
                            $('#<%=txtVinNo.ClientID%>').val(data.d[0].VehVin);
                            $('#<%=txtType.ClientID%>').val(vehType);
                            $('#<%=txtMaxRoofLoad.ClientID%>').val(data.d[0].Max_Rf_Load);
                            //input data to techincal tab
                            $('#<%=txtTechMake.ClientID%>').val(data.d[0].MakeCode);
                            $('#<%=txtTechMakeName.ClientID%>').val(data.d[0].Make);
                            $('#<%=txtTechGearBox.ClientID%>').val(data.d[0].GearBox_Desc);
                            $('#<%=txtTechEUApprovalNo.ClientID%>').val(data.d[0].EU_Main_Num);
                            $('#<%=txtTechVehGrp.ClientID%>').val(data.d[0].VehGrp);
                            if ($('#<%=txtTechVehGrp.ClientID%>').val() == '101') {
                                $('#<%=txtTechVehGrpName.ClientID%>').val('Personbil');
                                 }
                                 $('#<%=txtTechFuelCode.ClientID%>').val(data.d[0].FuelType);
                            if ($('#<%=txtTechFuelCode.ClientID%>').val() == '1') {
                                $('#<%=txtTechFuelName.ClientID%>').val('Bensin');
                                     $('#<%=txtWebFuelType.ClientID%>').val('Bensin');
                                 }
                                 else if ($('#<%=txtTechFuelCode.ClientID%>').val() == '2') {
                                     $('#<%=txtTechFuelName.ClientID%>').val('Diesel');
                                 $('#<%=txtWebFuelType.ClientID%>').val('Diesel');
                             }
                         $('#<%=txtTechEngineNo.ClientID%>').val(data.d[0].EngineNum);
                            $('#<%=txtTechNextPkk.ClientID%>').val(data.d[0].NxtPKK_Date);
                            $('#<%=txtTechLastPkkOk.ClientID%>').val(data.d[0].LastPKK_AppDate);
                            $('#<%=txtTechApprovalNo.ClientID%>').val(data.d[0].ApprovalNo);
                            $('#<%=txtTechLength.ClientID%>').val(data.d[0].Length);
                            $('#<%=txtTechWidth.ClientID%>').val(data.d[0].Width);
                            $('#<%=txtTechNoise.ClientID%>').val(data.d[0].Noise_On_Veh);
                            $('#<%=txtTechEffect.ClientID%>').val(data.d[0].EngineEff);
                            $('#<%=txtTechPistonDisp.ClientID%>').val(data.d[0].PisDisplacement);
                            $('#<%=txtTechRoundperMin.ClientID%>').val(data.d[0].Rounds);
                            //input data into web tab
                            $('#<%=txtWebMake.ClientID%>').val(data.d[0].Make);
                            $('#<%=txtWebModel.ClientID%>').val(data.d[0].Model);
                            $('#<%=txtWebGearBox.ClientID%>').val(data.d[0].GearBox_Desc);
                            $('#<%=txtWebModelYear.ClientID%>').val(data.d[0].ModelYear);
                            $('#<%=txtWebMainColor.ClientID%>').val(data.d[0].Color);
                            $('#<%=txtWebRegDate.ClientID%>').val(data.d[0].RegDateNorway);
                            $('#<%=txtWebChassi.ClientID%>').val(data.d[0].Chassi_Desc);
                            $('#<%=txtWebRegNo.ClientID%>').val(data.d[0].VehRegNo);
                            $('#<%=txtWebSeatQty.ClientID%>').val(data.d[0].Veh_Seat);
                            //Calculates the BHP based on the kW in Tech Page
                            if ($('#<%=txtTechEffect.ClientID%>').val() != '') {
                                $('#<%=txtWebBHP.ClientID%>').val(Math.round(parseInt($('#<%=txtTechEffect.ClientID%>').val()) * '1.36'));
                                 }
                            //input data into certificate tab
                                 $('#<%=txtCertTireDimFront.ClientID%>').val(data.d[0].StdTyreFront);
                            $('#<%=txtCertTireDimBack.ClientID%>').val(data.d[0].StdTyreBack);
                            $('#<%=txtCertLiFront.ClientID%>').val(data.d[0].MinLi_Front);
                            $('#<%=txtCertLiBack.ClientID%>').val(data.d[0].MinLi_Back);
                            $('#<%=txtCertMinInpressFront.ClientID%>').val(data.d[0].Min_Inpress_Front);
                            $('#<%=txtCertMinInpressBack.ClientID%>').val(data.d[0].Min_Inpress_Back);
                            $('#<%=txtCertRimFront.ClientID%>').val(data.d[0].Std_Rim_Front);
                            $('#<%=txtCertRimBack.ClientID%>').val(data.d[0].Std_Rim_Back);
                            $('#<%=txtCertminSpeedFront.ClientID%>').val(data.d[0].Min_Front);
                            $('#<%=txtCertMinSpeedBack.ClientID%>').val(data.d[0].Min_Back);
                            $('#<%=txtCertMaxWidthFront.ClientID%>').val(data.d[0].Max_Tyre_Width_Frnt);
                            $('#<%=txtCertMaxWidthBack.ClientID%>').val(data.d[0].Max_Tyre_Width_Bk);
                            $('#<%=txtCertAxlePressureFront.ClientID%>').val(data.d[0].AxlePrFront);
                            $('#<%=txtCertAxlePressureBack.ClientID%>').val(data.d[0].AxlePrBack);
                            $('#<%=txtCertAxleQty.ClientID%>').val(data.d[0].Axles_Number);
                            $('#<%=txtCertAxleWithTraction.ClientID%>').val(data.d[0].Axles_Number_Traction);
                            $('#<%=txtMaxRoofLoad.ClientID%>').val(data.d[0].Max_Rf_Load);
                            $('#<%=txtCertTrailerWeightBrakes.ClientID%>').val(data.d[0].TrailerWth_Brks);
                            $('#<%=txtCertTrailerWeight.ClientID%>').val(data.d[0].TrailerWthout_Brks);
                            $('#<%=txtCertWeightTowbar.ClientID%>').val(data.d[0].Max_Wt_TBar);
                            $('#<%=txtCertLengthTowbar.ClientID%>').val(data.d[0].Len_TBar);
                            $('#<%=txtCertTotalTrailerWeight.ClientID%>').val(data.d[0].TotalWeight);
                            $('#<%=txtCertSeats.ClientID%>').val(data.d[0].Veh_Seat);
                            $('#<%=txtCertEuronorm.ClientID%>').val(data.d[0].EU_Norm);
                            $('#<%=txtCertEuVariant.ClientID%>').val(data.d[0].EU_Variant);
                            $('#<%=txtCertEuVersion.ClientID%>').val(data.d[0].EU_Version);
                            $('#<%=txtCertCo2Emission.ClientID%>').val(data.d[0].CO2_Emission);
                            $('#<%=txtCertChassi.ClientID%>').val(data.d[0].Chassi_Desc);
                            $('#<%=txtCertCertificate.ClientID%>').val(data.d[0].Cert_Text);
                            $('#<%=txtCertIdentity.ClientID%>').val(data.d[0].Identity_Annot);
                            $('#<%=txtCertGear.ClientID%>').val(data.d[0].Wheels_Traction);
                            $('#<%=txtCertMakeParticleFilter.ClientID%>').val(data.d[0].Make_Part_Filter);
                            $('#<%=txtTechCleanedDate.ClientID%>').datepicker('setDate', new Date());
                        }
                        else {
                            alert('No vehicle available in MVR service! Are you sure the registration number is correct?')
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function FetchNewVehDetails() {
              
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/FetchNewVehDetails",
                    data: "{regNo: '" + $('#<%=txtRegNo.ClientID%>').val().toUpperCase() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length != 0) {
                            if (data.d[0].VehRegNo != '' && data.d[0].VehRegNo != null) {
                                var vehModel = data.d[0].Model;
                                var vehType = data.d[0].VehType;
                                var modelType = vehModel;

                                $('#<%=drpMakeCodes.ClientID%>').val(data.d[0].MakeCode);
                                $('#<%=txtGeneralMake.ClientID%>').val(data.d[0].Make);
                                // $('#<%=txtVehicleType.ClientID%>').val(modelType);
                                $('#<%=txtVehicleType.ClientID%>').val(vehType);


                                if (data.d[0].RegYear != "") {
                                    $('#<%=txtRegDate.ClientID%>').val(validdateFormat(data.d[0].RegYear));
                                } else {
                                    $('#<%=txtRegDate.ClientID%>').val("");
                                }

                                if (data.d[0].DeRegDate != "") {
                                    $('#<%=txtDeregDate.ClientID%>').val(data.d[0].DeRegDate);
                                } else {
                                    $('#<%=txtDeregDate.ClientID%>').val("");
                                }


                                $('#<%=txtTotWeight.ClientID%>').val(data.d[0].TotalWeight);
                                $('#<%=txtNetWeight.ClientID%>').val(data.d[0].NetWeight);

                                if (data.d[0].RegDateNorway != "") {
                                   // $('#<%=txtRegDateNorway.ClientID%>').val(validdateFormat(data.d[0].RegDateNorway));
                                     $('#<%=txtRegDateNorway.ClientID%>').val(data.d[0].RegDateNorway);
                                } else {
                                    $('#<%=txtRegDateNorway.ClientID%>').val("");
                                }

                                if (data.d[0].LastRegDate != "") {
                                    $('#<%=txtLastRegDate.ClientID%>').val(data.d[0].LastRegDate);
                                } else {
                                    $('#<%=txtLastRegDate.ClientID%>').val("");
                                }

                                var reg = data.d[0].RegYear;
                                var modyear;
                                if (reg != null) {
                                    var dRlengthCheck = reg.toString().length;
                                    if (dRlengthCheck == 8) {
                                        modyear = reg.toString().substring(0, 4);
                                    }
                                }

                                $('#<%=txtRegyr.ClientID%>').val(modyear);
                                $('#<%=txtModelyr.ClientID%>').val(modyear);
                                $('#<%=txtColor.ClientID%>').val(data.d[0].Color);
                                $('#<%=txtTechVin.ClientID%>').val(data.d[0].VehVin);
                                $('#<%=txtVinNo.ClientID%>').val(data.d[0].VehVin);
                                $('#<%=txtType.ClientID%>').val(modelType);
                                $('#<%=txtMaxRoofLoad.ClientID%>').val(data.d[0].Max_Rf_Load);
                                //input data to techincal tab
                                $('#<%=txtTechMake.ClientID%>').val(data.d[0].MakeCode);
                                $('#<%=txtTechMakeName.ClientID%>').val(data.d[0].Make);
                                $('#<%=txtTechGearBox.ClientID%>').val(data.d[0].GearBox_Desc);
                                $('#<%=txtTechEUApprovalNo.ClientID%>').val(data.d[0].EU_Main_Num);
                                $('#<%=txtTechVehGrp.ClientID%>').val(data.d[0].VehGrp);
                                $('#<%=txtTechVehGrpName.ClientID%>').val(data.d[0].VEHGRPNAME);
                                
                                <%--if (data.d[0].FuelType == '1,5') {
                                    $('#<%=txtTechFuelCode.ClientID%>').val('15');
                                }
                                else {
                                    $('#<%=txtTechFuelCode.ClientID%>').val(data.d[0].FuelType);
                                }--%>
                                
                                if (data.d[0].FuelType.indexOf(',') != -1) {
                                    strs = data.d[0].FuelType.split(',');
                                    let value = strs[0] + strs[1];
                                    $('#<%=txtTechFuelCode.ClientID%>').val(value);
                                }
                                else {
                                    $('#<%=txtTechFuelCode.ClientID%>').val(data.d[0].FuelType);
                                }

                                if ($('#<%=txtTechFuelCode.ClientID%>').val() == '1') {
                                    $('#<%=txtTechFuelName.ClientID%>').val('Bensin');
                                    $('#<%=txtWebFuelType.ClientID%>').val('Bensin');
                                }
                                else if ($('#<%=txtTechFuelCode.ClientID%>').val() == '2') {
                                    $('#<%=txtTechFuelName.ClientID%>').val('Diesel');
                                    $('#<%=txtWebFuelType.ClientID%>').val('Diesel');
                                }
                                else if ($('#<%=txtTechFuelCode.ClientID%>').val() == '15') {
                                    $('#<%=txtTechFuelName.ClientID%>').val('Hybrid');
                                    $('#<%=txtWebFuelType.ClientID%>').val('Hybrid');
                                }
                                else if ($('#<%=txtTechFuelCode.ClientID%>').val() == '5') {
                                    $('#<%=txtTechFuelName.ClientID%>').val('Elektrisk');
                                    $('#<%=txtWebFuelType.ClientID%>').val('Elektrisk');
                                }
                                $('#<%=txtTechEngineNo.ClientID%>').val(data.d[0].EngineNum);
								   $('#<%=txtTechNoise.ClientID%>').val(data.d[0].Noise_On_Veh);

                                if (data.d[0].EngineEff.indexOf('.') != -1) {
                                    strs = data.d[0].EngineEff.split('.');
                                    let value = Number(strs[0]) + Number(strs[1]);
                                    $('#<%=txtTechEffect.ClientID%>').val(value);
                                }
                                else {
                                    $('#<%=txtTechEffect.ClientID%>').val(data.d[0].EngineEff);
                                }

                              
                                $('#<%=txtTechPistonDisp.ClientID%>').val(data.d[0].PisDisplacement);
                                $('#<%=txtTechRoundperMin.ClientID%>').val(data.d[0].Rounds);
                                //input data into web tab
                                $('#<%=txtWebMake.ClientID%>').val(data.d[0].Make);
                                $('#<%=txtWebModel.ClientID%>').val(data.d[0].Model);
                                $('#<%=txtWebGearBox.ClientID%>').val(data.d[0].GearBox_Desc);
                                $('#<%=txtWebModelYear.ClientID%>').val(modyear);
                                $('#<%=txtWebMainColor.ClientID%>').val(data.d[0].Color);

                                if (data.d[0].RegDateNorway != "") {
                                    $('#<%=txtWebRegDate.ClientID%>').val(data.d[0].RegDateNorway);
                                } else {
                                    $('#<%=txtWebRegDate.ClientID%>').val("");
                                }


                                $('#<%=txtWebChassi.ClientID%>').val(data.d[0].Chassi_Desc);
                                $('#<%=txtWebRegNo.ClientID%>').val(data.d[0].VehRegNo);
                                $('#<%=txtWebSeatQty.ClientID%>').val(data.d[0].Veh_Seat);
                                //Calculates the BHP based on the kW in Tech Page
                                if ($('#<%=txtTechEffect.ClientID%>').val() != '') {
                                    $('#<%=txtWebBHP.ClientID%>').val(Math.round(parseInt($('#<%=txtTechEffect.ClientID%>').val()) * '1.36'));
                                }
                                //input data into certificate tab
                                $('#<%=txtCertTireDimFront.ClientID%>').val(data.d[0].StdTyreFront);
                                $('#<%=txtCertTireDimBack.ClientID%>').val(data.d[0].StdTyreBack);
                                $('#<%=txtCertLiFront.ClientID%>').val(data.d[0].MinLi_Front);
                                $('#<%=txtCertLiBack.ClientID%>').val(data.d[0].MinLi_Back);
                                $('#<%=txtCertMinInpressFront.ClientID%>').val(data.d[0].Min_Inpress_Front);
                                $('#<%=txtCertMinInpressBack.ClientID%>').val(data.d[0].Min_Inpress_Back);
                                $('#<%=txtCertRimFront.ClientID%>').val(data.d[0].Std_Rim_Front);
                                $('#<%=txtCertRimBack.ClientID%>').val(data.d[0].Std_Rim_Back);
                                $('#<%=txtCertminSpeedFront.ClientID%>').val(data.d[0].Min_Front);
                                $('#<%=txtCertMinSpeedBack.ClientID%>').val(data.d[0].Min_Back);
                                $('#<%=txtCertMaxWidthFront.ClientID%>').val(data.d[0].Max_Tyre_Width_Frnt);
                                $('#<%=txtCertMaxWidthBack.ClientID%>').val(data.d[0].Max_Tyre_Width_Bk);
                                $('#<%=txtCertAxlePressureFront.ClientID%>').val(data.d[0].AxlePrFront);
                                $('#<%=txtCertAxlePressureBack.ClientID%>').val(data.d[0].AxlePrBack);
                                $('#<%=txtCertAxleQty.ClientID%>').val(data.d[0].Axles_Number);
                                $('#<%=txtCertAxleWithTraction.ClientID%>').val(data.d[0].Axles_Number_Traction);
                                $('#<%=txtMaxRoofLoad.ClientID%>').val(data.d[0].Max_Rf_Load);
                                $('#<%=txtCertTrailerWeightBrakes.ClientID%>').val(data.d[0].TrailerWth_Brks);
                                $('#<%=txtCertTrailerWeight.ClientID%>').val(data.d[0].TrailerWthout_Brks);
                                $('#<%=txtCertWeightTowbar.ClientID%>').val(data.d[0].Max_Wt_TBar);
                                $('#<%=txtCertLengthTowbar.ClientID%>').val(data.d[0].Len_TBar);
                                $('#<%=txtCertTotalTrailerWeight.ClientID%>').val(data.d[0].TotalWeight);
                                $('#<%=txtCertSeats.ClientID%>').val(data.d[0].Veh_Seat);
                                $('#<%=txtCertEuronorm.ClientID%>').val(data.d[0].EU_Norm);
                                $('#<%=txtCertEuVariant.ClientID%>').val(data.d[0].EU_Variant);
                                $('#<%=txtCertEuVersion.ClientID%>').val(data.d[0].EU_Version);
                                $('#<%=txtCertCo2Emission.ClientID%>').val(data.d[0].CO2_Emission);
                                $('#<%=txtCertChassi.ClientID%>').val(data.d[0].Chassi_Desc);
                                $('#<%=txtCertCertificate.ClientID%>').val(data.d[0].Cert_Text);
                                $('#<%=txtCertIdentity.ClientID%>').val(data.d[0].Identity_Annot);
                                $('#<%=txtCertGear.ClientID%>').val(data.d[0].Wheels_Traction);
                                $('#<%=txtCertMakeParticleFilter.ClientID%>').val(data.d[0].Make_Part_Filter);
                                $('#<%=txtTechCleanedDate.ClientID%>').datepicker('setDate', new Date());
                                tbDriverName.SetText("");
                                tbDriverNo.SetText(""); 

                                //Check if the customer exists already 
                                //If the customer exists already , we need to load it
                                //If the customer does not exists then we need to create it and then load it
                                //NewVehDet.Customer = o("registration_info")("")
                                //need to check

                                var iscomp = false;
                                //alert(data.d[0].LESSE_NAME != "");
                                if (data.d[0].LESSE_NAME != "" && data.d[0].LESSE_NAME != null) {
                                    hdnCallbackValues.Set("LeeseExists", true);
                                    if (data.d[0].LESSE_BIRTH_NO != "" && data.d[0].LESSE_BIRTH_NO != null) {
                                        if (data.d[0].LESSE_BIRTH_NO.length == 9) {
                                            iscomp = true;
                                        }
                                    }
                                    if (iscomp) {                                        
                                        cbMultiCust.PerformCallback(data.d[0].LESSE_NAME + ";" + data.d[0].LESSE_NAME + ";" + iscomp + ";" + "lesse");
                                    }
                                    else {
                                        cbMultiCust.PerformCallback(data.d[0].LESSE_FIRSTNAME + ";" + data.d[0].LESSE_LASTNAME + ";" + iscomp + ";" + "lesse"); //, iscomp,owner or lessetype
                                    }

                                    //if record is more than 1 then only show the popup else no need
                                    tbBuyerName.SetText(data.d[0].LESSE_NAME);
                                    $('#<%=rbBuyerL.ClientID%>').attr('checked', true);
                                    $('#<%=rbBuyerV.ClientID%>').attr('checked', true);
                                    //alert("Exists");
                                }
                                else {
                                    // alert("Does not Exists")
                                    hdnCallbackValues.Set("LeeseExists", false);
                                    tbLeasingName.SetText("");
                                    tbOwnerName.SetText("");
                                    tbBuyerName.SetText("");
                                    $('#<%=rbBuyerL.ClientID%>').attr('checked', false);
                                    $('#<%=rbBuyerV.ClientID%>').attr('checked', false);
                                }

                                if (data.d[0].OWNER_ORG_NAME != "" && data.d[0].OWNER_ORG_NAME != null) {
                                    if (data.d[0].OWNER_BIRTH_ORG_NO != "" && data.d[0].OWNER_BIRTH_ORG_NO != null) {
                                        if (data.d[0].OWNER_BIRTH_ORG_NO.length == 9) {
                                            iscomp = true;
                                        }
                                        else {
                                            iscomp = false;
                                        }
                                    }
                                    if (iscomp) {
                                        cbOwnerMultiCust.PerformCallback(data.d[0].OWNER_ORG_NAME + ";" + data.d[0].OWNER_ORG_NAME + ";" + iscomp + ";" + "owner"); //, iscomp,owner or lessetype
                                    }
                                    else {
                                        cbOwnerMultiCust.PerformCallback(data.d[0].OWNER_FIRST_NAME + ";" + data.d[0].OWNER_LAST_NAME + ";" + iscomp + ";" + "owner"); //, iscomp,owner or lessetype
                                    }
                                    if (hdnCallbackValues.Get("LeeseExists")) {
                                        tbLeasingName.SetText(data.d[0].OWNER_ORG_NAME);
                                        tbOwnerName.SetText(data.d[0].OWNER_ORG_NAME);
                                    }
                                    else {
                                        tbLeasingName.SetText("");
                                        tbOwnerName.SetText("");
                                    }
                                }

                            }
                            else {
                                alert('No vehicle available in this service! Are you sure the registration number is correct?')
                            }

                        }else {
                            alert('No vehicle available in this service! Are you sure the registration number is correct?')
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function validdateFormat(dt) {     
                //console.log(dt);
                if (dt != null) {
                    var dRlengthCheck = dt.toString().length;
                    if (dRlengthCheck == 8) {
                        var dyear = dt.toString().substring(0, 4);
                        var dmonth = dt.toString().substring(4, 6);
                        var dday = dt.toString().substring(6, 8);
                        return dday + '.' + dmonth + '.' + dyear;
                    }
                }                
            }

            /*Updates dropdown for makecode/name when a makecode on technical is inserted and it exist in the list.*/
            $('#<%=txtTechMake.ClientID()%>').on('blur', function () {
                $('#<%=drpMakeCodes.ClientID%>').val($('#<%=txtTechMake.ClientID()%>').val());

            });
            $('#<%=drpMakeCodes.ClientID%>').on('change', function () {
                $('#<%=txtTechMake.ClientID()%>').val($('#<%=drpMakeCodes.ClientID%>').val());

            });


            /*TabEconomy calculations*/
            $('#<%=txtEcoSalespriceNet.ClientID%>, #<%=txtEcoSalesSale.ClientID%>, #<%=txtEcoDiscount.ClientID%>').blur(function () {
                $('#<%=txtEcoNetSalesPrice.ClientID%>, #<%=txtEcoAssistSales.ClientID%>, #<%=txtEcoContributionsToday.ClientID%>').val((isNaN(parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) + (isNaN(parseInt($('#<%=txtEcoSalesSale.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalesSale.ClientID%>').val())) - (isNaN(parseInt($('#<%=txtEcoDiscount.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoDiscount.ClientID%>').val())) - (isNaN(parseInt($('#<%=txtEcoTotalCost.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoTotalCost.ClientID%>').val())));
                $('#<%=txtEcoSalesPriceGross.ClientID%>').val((isNaN(parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())));
                $('#<%=txtEcoVehTotAmount.ClientID%>').val((isNaN(parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) + (isNaN(parseInt($('#<%=txtEcoRegFee.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoRegFee.ClientID%>').val())));

            });
            $('#<%=txtEcoRegFee.ClientID%>').blur(function () {
                $('#<%=txtEcoVehTotAmount.ClientID%>').val((isNaN(parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) + (isNaN(parseInt($('#<%=txtEcoRegFee.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoRegFee.ClientID%>').val())));
            });

            $('#<%=txtEcoCostPriceNet.ClientID%>, #<%=txtEcoInsuranceBonus.ClientID%>, #<%=txtEcoInntakeSaler.ClientID%>, #<%=txtEcoSalesProvision.ClientID%>').blur(function () {
                $('#<%=txtEcoTotalCost.ClientID%>').val((isNaN(parseInt($('#<%=txtEcoCostPriceNet.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoCostPriceNet.ClientID%>').val())) - (isNaN(parseInt($('#<%=txtEcoInsuranceBonus.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoInsuranceBonus.ClientID%>').val())) - (isNaN(parseInt($('#<%=txtEcoInntakeSaler.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoInntakeSaler.ClientID%>').val())) + (isNaN(parseInt($('#<%=txtEcoSalesProvision.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalesProvision.ClientID%>').val())));
                $('#<%=txtEcoNetSalesPrice.ClientID%>, #<%=txtEcoAssistSales.ClientID%>, #<%=txtEcoContributionsToday.ClientID%>').val((isNaN(parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalespriceNet.ClientID%>').val())) + (isNaN(parseInt($('#<%=txtEcoSalesSale.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoSalesSale.ClientID%>').val())) - (isNaN(parseInt($('#<%=txtEcoDiscount.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoDiscount.ClientID%>').val())) - (isNaN(parseInt($('#<%=txtEcoTotalCost.ClientID%>').val())) ? 0 : parseInt($('#<%=txtEcoTotalCost.ClientID%>').val())));
            });
            $('#<%=txtRegNoCreate.ClientID%>').focus();

            $('#btnLeasing').click(function () {
                //alert("Leasing Clicked");
                popupLeasing.Show();
            });
        });

        function viewPicture(elm) {
            var x = elm.getAttribute('value');
            //console.log(x);
             $('#mainPicture').empty();
             $('#mainPicture').append('<img src="' + x + '" style="max-width: 500px; height:auto" />');
          
        }
        function viewDocument(elm) {
            var x = elm.getAttribute('value');
            alert(x);
            //console.log(x);
            //$('#mainDocument').empty();
            //$('#mainDocument').append('<img src="' + x + '" style="max-width: 500px; height:auto" />');
            window.open(x, "_blank");
        }

        
        function OnLesseDoubleClick(s, e) {
            var selectedItem = lbMultipleCustomer.GetSelectedItem().text;//
            var selectedCustId = selectedItem.split(';');

            $('#<%=txtCustNo.ClientID()%>').val(selectedCustId[0]);
            FetchCustomerDetails();
            tbBuyerNo.SetText(selectedCustId[0]);
            FetchBuyerCustomerDetails(selectedCustId[0]);
            popupCustomerList.Hide();
            
        }

        function OncbMultiCustEndCallback(s, e) {
            if (lbMultipleCustomer.GetItemCount() == 1 || lbMultipleCustomer.GetItemCount() == 0) {
                if (hdnCallbackValues.Get("LeeseExists")) {
                    if (cbMultiCust.cpCustType == "lesse") {
                        var customerId = "";
                        if (s.cpCustID != "" && s.cpCustID != null && s.cpCustID != undefined) {
                            customerId = s.cpCustID;
                            $('#<%=txtCustNo.ClientID()%>').val(customerId);
                            FetchCustomerDetails();
                            tbBuyerNo.SetText(customerId);
                        }
                    }
                    else {
                        tbBuyerNo.SetText("");
                        tbOwnerNo.SetText("");
                        tbLeasingNo.SetText("");
                    }
                }
            }
            else if (lbMultipleCustomer.GetItemCount() > 1) {
                //alert("AAA");
                popupCustomerList.Show();
                //popupOwnerCustomerList.Show();
            }            
        }

        function OncbOwnerMultiCustEndCallback(s, e) {
            var customerId = "";
            if (lbOwnerMultipleCustomer.GetItemCount() == 1 || lbOwnerMultipleCustomer.GetItemCount() == 0) {
                if (hdnCallbackValues.Get("LeeseExists")) {
                    if (s.cpCustID != "" && s.cpCustID != null && s.cpCustID != undefined) {
                        customerId = s.cpCustID;
                        hdnOwnerId.Set("OwnerId", customerId);
                        tbOwnerNo.SetText(customerId);
                        tbLeasingNo.SetText(customerId);
                    }
                }
                else {                    
                    if (s.cpCustID != "" && s.cpCustID != null && s.cpCustID != undefined) {
                        customerId = s.cpCustID;
                        $('#<%=txtCustNo.ClientID()%>').val(customerId);
                        FetchCustomerDetails();
                        hdnOwnerId.Set("OwnerId", "");
                        tbBuyerNo.SetText("");
                        tbOwnerNo.SetText("");
                        tbLeasingNo.SetText("");
                    }
                }                
            }
            else if (lbOwnerMultipleCustomer.GetItemCount() > 1) {
                popupOwnerCustomerList.Show();
            }            
        }

        function OnOwnerDoubleClick(s, e) {
            if (hdnCallbackValues.Get("LeeseExists")) {
                var selectedItem = lbOwnerMultipleCustomer.GetSelectedItem().text;
                var selectedCustId = selectedItem.split(';');
                hdnOwnerId.Set("OwnerId", selectedCustId[0]);
                tbOwnerNo.SetText(selectedCustId[0]);
                tbLeasingNo.SetText(selectedCustId[0]);
                FetchLeasingCustomerDetails(selectedCustId[0]);
                popupOwnerCustomerList.Hide();
                
            }
            else {
                var selectedItem = lbOwnerMultipleCustomer.GetSelectedItem().text;
                var selectedCustId = selectedItem.split(';');
                $('#<%=txtCustNo.ClientID()%>').val(selectedCustId[0]);
                FetchCustomerDetails();
                hdnOwnerId.Set("OwnerId", "");
                tbBuyerNo.SetText("");
                tbOwnerNo.SetText("");
                tbLeasingNo.SetText("");
                tbBuyerName.SetText("");
                tbLeasingName.SetText("");
                tbOwnerName.SetText("");
                popupOwnerCustomerList.Hide();
            }            
        }

        function FetchBuyerCustomerDetails(customerNo) {
            $.ajax({
                type: "POST",
                url: "frmCustomerDetail.aspx/FetchCustomerDetails",
                data: "{custId: '" + customerNo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    var custName = '';
                    custName = data.d[0].CUST_FIRST_NAME + ' ' + data.d[0].CUST_MIDDLE_NAME + ' ' + data.d[0].CUST_LAST_NAME;
                    //tbOwnerName.SetText(custName.trim());
                    tbBuyerName.SetText(custName.trim());
                    $('#<%=rbBuyerL.ClientID%>').attr('checked', true);
                    $('#<%=rbBuyerV.ClientID%>').attr('checked', true);

                },
                failure: function () {
                    alert("Failed!");
                }
            });
        }

        function FetchLeasingCustomerDetails(customerNo) {
            $.ajax({
                type: "POST",
                url: "frmCustomerDetail.aspx/FetchCustomerDetails",
                data: "{custId: '" + customerNo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    var custName = '';
                    custName = data.d[0].CUST_FIRST_NAME + ' ' + data.d[0].CUST_MIDDLE_NAME + ' ' + data.d[0].CUST_LAST_NAME;
                    tbLeasingName.SetText(custName.trim());
                    tbOwnerName.SetText(custName.trim());
                },
                failure: function () {
                    alert("Failed!");
                }
            });
        }

        function autoCompleteDriverName(s, e) {
            $(s.GetInputElement()).autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Transactions/frmWoSearch.aspx/Customer_Search",
                        data: "{q:'" + request.term + "', 'isPrivate': '" + true + "', 'isCompany': '" + true + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log(request.term);
                            if (data.d.length === 0)  // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Unable to find record ', value: ' ', val: ' ' }]);
                            }
                            else
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.ID_CUSTOMER + " - " + item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME + " - " + item.CUST_PHONE_MOBILE,
                                        val: item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME,
                                        value: item.ID_CUSTOMER
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
                    tbDriverName.SetText(i.item.val);
                    
                }
            });
        }

        function FetchDriverCustomerDetails(customerNo) {
            $.ajax({
                type: "POST",
                url: "frmCustomerDetail.aspx/FetchCustomerDetails",
                data: "{custId: '" + customerNo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    var custName = '';
                    custName = data.d[0].CUST_FIRST_NAME + ' ' + data.d[0].CUST_MIDDLE_NAME + ' ' + data.d[0].CUST_LAST_NAME;
                    tbDriverName.SetText(custName.trim());
                    <%--tbBuyerName.SetText(custName.trim());
                    $('#<%=rbBuyerL.ClientID%>').attr('checked', true);
                    $('#<%=rbBuyerV.ClientID%>').attr('checked', true);--%>

                },
                failure: function () {
                    alert("Failed!");
                }
            });
        }

    </script>
    <asp:HiddenField ID="hdnSelect" runat="server" />
    <div class="overlayHide">
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
    </div>
     
    <dx:ASPxHiddenField ID="hdnCallbackValues" ClientInstanceName="hdnCallbackValues" runat="server"></dx:ASPxHiddenField>
    <dx:ASPxHiddenField ID="hdnOwnerId" ClientInstanceName="hdnOwnerId" runat="server"></dx:ASPxHiddenField>
    <dx:ASPxPopupControl ID="popupCustomerList" runat="server" ClientInstanceName="popupCustomerList" PopupHorizontalAlign="Center" Modal="True" HeaderText="Leasing Customer List" PopupVerticalAlign="Middle" Top="250" Left="650" Width="400px" Height="250px" CloseAction="None" Theme="Office365" CloseAnimationType="Fade" ShowCloseButton="False" AllowDragging="True" meta:resourcekey="popupCustomerListResource1">
        <ContentCollection>
            <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource1">
                <dx:ASPxCallbackPanel ID="cbMultiCust" ClientInstanceName="cbMultiCust" runat="server" OnCallback="cbMultiCust_Callback" ClientSideEvents-EndCallback="OncbMultiCustEndCallback" meta:resourcekey="cbMultiCustResource1">
<ClientSideEvents EndCallback="OncbMultiCustEndCallback"></ClientSideEvents>
                    <PanelCollection>
                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">
                            <div>
                                <dx:ASPxListBox ID="lbMultipleCustomer" ClientInstanceName="lbMultipleCustomer" runat="server" ValueType="System.String" Width="100%" Height="250" ItemStyle-Height="10%" CaptionCellStyle-Height="8px" Theme="Office365" meta:resourcekey="lbMultipleCustomerResource1">

<ItemStyle Height="10%"></ItemStyle>

                                   <ClientSideEvents ItemDoubleClick="OnLesseDoubleClick" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="ID_CUSTOMER" Caption="Customer ID" meta:resourcekey="ListBoxColumnResource1" />
                                        <dx:ListBoxColumn FieldName="CUST_NAME" Caption="Name" meta:resourcekey="ListBoxColumnResource2" />
                                         <dx:ListBoxColumn FieldName="CUST_PERM_ADD1" Caption="Address" meta:resourcekey="ListBoxColumnResource3" />
                                    </Columns>

<CaptionCellStyle Height="8px"></CaptionCellStyle>
                                </dx:ASPxListBox>
                            </div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
       <%-- <FooterContentTemplate>
            <div style="text-align:center">
                <dx:ASPxButton ID="btnOk" runat="server" CssClass="ui btn mini" Text="Ok" AutoPostBack="False" ClientSideEvents-Click="OnOkbtnClick"></dx:ASPxButton>
            </div>
        </FooterContentTemplate>--%>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="popupOwnerCustomerList" runat="server" ClientInstanceName="popupOwnerCustomerList" PopupHorizontalAlign="LeftSides" Modal="True" HeaderText="Owner Customer List" PopupVerticalAlign="Above" Top="250" Left="850" Width="400px" Height="250px" CloseAction="None" Theme="Office365" CloseAnimationType="Fade" ShowCloseButton="False" AllowDragging="True" meta:resourcekey="popupOwnerCustomerListResource1">
        <ContentCollection>
            <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource2">
                <dx:ASPxCallbackPanel ID="cbOwnerMultiCust" ClientInstanceName="cbOwnerMultiCust" OnCallback="cbOwnerMultiCust_Callback" ClientSideEvents-EndCallback="OncbOwnerMultiCustEndCallback" runat="server" meta:resourcekey="cbOwnerMultiCustResource1">
<ClientSideEvents EndCallback="OncbOwnerMultiCustEndCallback"></ClientSideEvents>
                    <PanelCollection>
                        <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource2">
                            <div>
                                <dx:ASPxListBox ID="lbOwnerMultipleCustomer" ClientInstanceName="lbOwnerMultipleCustomer" runat="server" ValueType="System.String" Width="100%" Height="250" ItemStyle-Height="10%" CaptionCellStyle-Height="8px" Theme="Office365" meta:resourcekey="lbOwnerMultipleCustomerResource1">

<ItemStyle Height="10%"></ItemStyle>

                                   <ClientSideEvents ItemDoubleClick="OnOwnerDoubleClick" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="ID_CUSTOMER" Caption="Customer ID" meta:resourcekey="ListBoxColumnResource4" />
                                        <dx:ListBoxColumn FieldName="CUST_NAME" Caption="Name" meta:resourcekey="ListBoxColumnResource5" />
                                         <dx:ListBoxColumn FieldName="CUST_PERM_ADD1" Caption="Address" meta:resourcekey="ListBoxColumnResource6" />
                                    </Columns>

<CaptionCellStyle Height="8px"></CaptionCellStyle>
                                </dx:ASPxListBox>
                            </div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="popupLeasing" runat="server" ClientInstanceName="popupLeasing" HeaderStyle-ForeColor="#6666ff" PopupHorizontalAlign="Center" Modal="True" HeaderText="Referanse Kunder" PopupVerticalAlign="Middle" Top="250" Left="650" Width="750px" Height="350px" CloseAction="CloseButton" Theme="Office365" AllowDragging="True" meta:resourcekey="popupLeasingResource1">
<HeaderStyle ForeColor="#6666FF"></HeaderStyle>
        <ContentCollection>
            <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource3">
                <div style="display: flex">
                    <div style="width: 20%; padding-right: 1%">
                        <div style="padding-bottom: 8px;padding-left:60px">
                            <dx:ASPxLabel ID="lblCustomerNo" runat="server" Text="Kundenr." Font-Bold="true" Font-Size="Small" meta:resourcekey="lblCustomerNoResource1"></dx:ASPxLabel>
                        </div>
                        <div class="fields">
                            <div class="two wide field" style="padding-bottom: 4px">
                                <dx:ASPxTextBox ID="tbOwnerNo" ClientInstanceName="tbOwnerNo" runat="server" Width="100%" Caption="Eier &nbsp;&nbsp;&nbsp;&nbsp;" CaptionSettings-ShowColon="false" FocusedStyle-Border-BorderColor="#2185d0" CssClass="customTextBox" Font-Size="Medium" meta:resourcekey="tbOwnerNoResource1">
<CaptionSettings ShowColon="False"></CaptionSettings>

<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="two wide field" style="padding-bottom: 4px">
                                <dx:ASPxTextBox ID="tbBuyerNo" ClientInstanceName="tbBuyerNo" runat="server" Width="100%" Caption="Kjøper&nbsp;" CaptionSettings-ShowColon="false" Font-Size="Medium" FocusedStyle-Border-BorderColor="#2185d0" CssClass="customTextBox" meta:resourcekey="tbBuyerNoResource1">
<CaptionSettings ShowColon="False"></CaptionSettings>

<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="two wide field" style="padding-bottom: 4px">
                                <dx:ASPxTextBox ID="tbLeasingNo" ClientInstanceName="tbLeasingNo" runat="server" Width="100%" Caption="Leasing " CaptionSettings-ShowColon="false" Font-Size="Medium" FocusedStyle-Border-BorderColor="#2185d0" CssClass="customTextBox" meta:resourcekey="tbLeasingNoResource1">
<CaptionSettings ShowColon="False"></CaptionSettings>

<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="two wide field">
                                <dx:ASPxTextBox ID="tbDriverNo" ClientInstanceName="tbDriverNo" runat="server" Width="100%" Caption="Fører &nbsp;&nbsp;" ClientSideEvents-Init="autoCompleteDriverName" CaptionSettings-ShowColon="false" FocusedStyle-Border-BorderColor="#2185d0" Font-Size="Medium" CssClass="customTextBox" meta:resourcekey="tbDriverNoResource1">
<ClientSideEvents Init="autoCompleteDriverName"></ClientSideEvents>

<CaptionSettings ShowColon="False"></CaptionSettings>

<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                        </div>
                    </div>
                    <div style="width: 50%; padding-right: 1%">
                        <div style="padding-bottom: 8px">
                            <dx:ASPxLabel ID="lblName" runat="server" Text="Navn" Font-Bold="true" Font-Size="Small" meta:resourcekey="lblNameResource1"></dx:ASPxLabel>
                        </div>
                        <div class="fields">
                            <div class="two wide field" style="padding-bottom: 4px">
                                <dx:ASPxTextBox ID="tbOwnerName" ClientInstanceName="tbOwnerName" runat="server" Width="100%" Font-Size="Medium" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbOwnerNameResource1">
<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="two wide field" style="padding-bottom: 4px">
                                <dx:ASPxTextBox ID="tbBuyerName" runat="server" ClientInstanceName="tbBuyerName" Width="100%" Font-Size="Medium" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbBuyerNameResource1">
<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="two wide field" style="padding-bottom: 4px">
                                <dx:ASPxTextBox ID="tbLeasingName" ClientInstanceName="tbLeasingName" runat="server" Width="100%" Font-Size="Medium" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbLeasingNameResource1">
<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="two wide field">
                                <dx:ASPxTextBox ID="tbDriverName" ClientInstanceName="tbDriverName" runat="server" Width="100%" Font-Size="Medium" CssClass="customTextBox"  FocusedStyle-Border-BorderColor="#2185d0" meta:resourcekey="tbDriverNameResource1">
<FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                        </div>
                    </div>
                    <div></div>
                    <div style="width: 30%">
                        <asp:Panel ID="mtPanel" runat="server" GroupingText="Faktura Stiles Til" Font-Bold="true" Font-Size="Small" CssClass="outerPannel" meta:resourcekey="mtPanelResource1">
                            <div class="fields">
                                  <div style="display:flex">
                                      <div style="padding-left:10px;padding-right:10px">
                                          <dx:ASPxLabel ID="lbLager" runat="server" Text="Lager" meta:resourcekey="lbLagerResource1" ></dx:ASPxLabel>
                                      </div>
                                      <div style="padding-right:15px;padding-left:2px">
                                           <dx:ASPxLabel ID="lbVerksted" runat="server" Text="Verksted" meta:resourcekey="lbVerkstedResource1"></dx:ASPxLabel>
                                      </div>                                        
                                     <div>
                                         <dx:ASPxLabel ID="lbBilsalg" runat="server" Text="Bilsalg" meta:resourcekey="lbBilsalgResource1"></dx:ASPxLabel>
                                     </div>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="two wide field">
                                    <asp:RadioButton ID="rbOwnerL" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbOwnerLResource1" />
                                    <asp:RadioButton ID="rbOwnerV" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbOwnerVResource1" />
                                    <asp:RadioButton ID="rbOwnerB" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbOwnerBResource1" />
                                </div>

                                <div class="two wide field">
                                    <asp:RadioButton ID="rbBuyerL" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbBuyerLResource1" />
                                    <asp:RadioButton ID="rbBuyerV" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbBuyerVResource1" />
                                    <asp:RadioButton ID="rbBuyerB" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbBuyerBResource1" />
                                </div>

                                <div class="two wide field">
                                    <asp:RadioButton ID="rbLeasingL" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbLeasingLResource1" />
                                    <asp:RadioButton ID="rbLeasingV" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbLeasingVResource1" />
                                    <asp:RadioButton ID="rbLeasingB" runat="server" Font-Size="Medium" Height="48" CssClass="customRadioButton" meta:resourcekey="rbLeasingBResource1" />
                                </div>

                                <div class="two wide field">
                                    <asp:RadioButton ID="rbDriverL" runat="server" Font-Size="Medium" Height="42" CssClass="customRadioButton" meta:resourcekey="rbDriverLResource1" />
                                    <asp:RadioButton ID="rbDriverV" runat="server" Font-Size="Medium" Height="42" CssClass="customRadioButton" meta:resourcekey="rbDriverVResource1" />
                                    <asp:RadioButton ID="rbDriverB" runat="server" Font-Size="Medium" Height="42" CssClass="customRadioButton" meta:resourcekey="rbDriverBResource1" />
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
                <p></p>
                <div style="float:right">
                    <dx:ASPxButton ID="btnExit" runat="server" Text ="Avslutt" CssClass="ui button wide" AutoPostBack="false" ClientSideEvents-Click="function(s,e){popupLeasing.Hide();}" UseSubmitBehavior="false" meta:resourcekey="btnExitResource1">
<ClientSideEvents Click="function(s,e){popupLeasing.Hide();}"></ClientSideEvents>
                    </dx:ASPxButton>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <%--Added on 07-0-2021 End--%>

    <div class="ui grid">
        <div class="sixteen wide column">
            
            <div class="ui form">
                <div class="fields">
                    &nbsp;
                
                    </div>
                <div class="fields">
                    <div class="two wide field">
                        <label>
                            <asp:Label ID="lblRefNo" Text="RefNo" runat="server" meta:resourcekey="lblRefNoResource1"></asp:Label></label>
                        <asp:TextBox ID="txtIntNo" runat="server" meta:resourcekey="txtIntNoResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                    <div class="regno char field">
                        <label>
                            <asp:Label ID="lblRegNo" Text="RegNo" runat="server" meta:resourcekey="lblRegNoResource1"></asp:Label></label>
                        <%--<input type="text" id="txtRegNo" class="texttest">--%>
                        <asp:TextBox ID="txtRegNo" runat="server" Style="text-transform: uppercase;
    " meta:resourcekey="txtRegNoResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                    <div class="one wide field">
                        <label>&nbsp;</label>
                        <div class="ui mini input">
                            <input type="button" id="btnFetchMVR" runat="server" class="ui btn mini" value="Fetch" visible="false" />
                            <%--<asp:Button runat="server" value="Hent" Text="Hent" Width="50px" id="btnFetchMVR" class="ui btn" />--%>

                            <input type="button" id="btnFetchVehDet" runat="server" class="ui btn mini" value="Fetch" />
                        </div>
                    </div>
                    <div class="one wide field">
                        </div>
                    <div class="three wide field">
                        <label>&nbsp;</label>
                       
                            <input id="txtVehSearch" type="text" class="carsInput vehSearch" placeholder="Søk etter bil.." />
                            <div class="search"></div>
                        

                    </div>
                    <div class="one wide field">
                        <asp:TextBox ID="txtVinNo" runat="server" Enabled="False" meta:resourcekey="txtVinNoResource1" CssClass="carsInput hidden"></asp:TextBox>
                    </div>
                    <div class="one wide field">
                    </div>
                    <div class="two wide field">
                        <label id="lblCreateNewUsed" runat="server">New/Used*</label>

                        <select id="ddlVehType" runat="server" class="carsInput" disabled="disabled">
                            <option value="-1">Velg..</option>
                            <option value="0">Nytt kjøretøy</option>
                            <option value="1">Import Bil</option>
                            <option value="2">Brukt Bil</option>
                            <option value="3">Ny Elbil</option>
                            <option value="4">Ny maskin</option>
                            <option value="5">Brukt maskin</option>
                            <option value="6">Ny Båt</option>
                            <option value="7">Brukt Båt</option>
                            <option value="8">Ny Bobil</option>
                            <option value="9">Brukt Bobil</option>
                            <option value="10">Leiebil</option>
                            <option value="11">Kommisjon brukt</option>
                            <option value="12">Kommisjon ny</option>
                        </select>

                    </div>
                    <div class="two wide field">
                        <label id="lblCreateStatus" runat="server">Status*</label>
                        <select id="ddlVehStatus" runat="server" class="carsInput" disabled="disabled"></select>
                    </div>
                    <div class="one wide field">
                    </div>
                    <div class="two wide field">
                        <label id="Label14" class="" runat="server">Opprettet dato:</label>
                        27.08.2019
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modNewVehicle" class="modal hidden">
        <div class="modHeader">
            <h2 id="lblNewVehicle" runat="server">New vehicle</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Nytt kjøretøy</label>
                    <div class="ui small info message">
                        <p id="lblChooseStatus" runat="server">Velg bilstatus før du går videre</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form ">
                        <div class="fields">
                            <div class="eight wide field">
                                <asp:Label ID="lblRefNoCreate" Text="Refnr." runat="server" meta:resourcekey="lblRefNoCreateResource1"></asp:Label>
                                <asp:TextBox ID="txtRefNoCreate" runat="server" meta:resourcekey="txtRefNoCreateResource1" CssClass="CarsBoxes"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <asp:Label ID="lblRegNoCreate" Text="Regnr." runat="server" meta:resourcekey="lblRegNoCreateResource1"></asp:Label>
                                <asp:TextBox ID="txtRegNoCreate" Style="text-transform: uppercase;" runat="server" meta:resourcekey="txtRegNoCreateResource1" CssClass="CarsBoxes"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblNewUsed" runat="server">New/Used*</label>

                                <select id="ddlVehicleType" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemNewVehicle">Nytt kjøretøy</option>
                                    <option value="1" id="ddlItemNewImportVehicle">Import Bil</option>
                                    <option value="2" selected="selected" id="ddlItemUsedVehicle">Brukt Bil</option>
                                    <option value="3" id="ddlItemNewElVehicle">Ny Elbil</option>
                                    <option value="4" id="ddlItemNewMachine">Ny maskin</option>
                                    <option value="5" id="ddlItemUsedMachine">Brukt maskin</option>
                                    <option value="6" id="ddlItemNewBoat">Ny Båt</option>
                                    <option value="7" id="ddlItemUsedBoat">Brukt Båt</option>
                                    <option value="8" id="ddlItemNewHouseCar">Ny Bobil</option>
                                    <option value="9" id="ddlItemUsedHouseCar">Brukt Bobil</option>
                                    <option value="10" id="ddlItemRentalVehicle">Leiebil</option>
                                    <option value="11" id="ddlItemCommisionUsed">Kommisjon brukt</option>
                                    <option value="12" id="ddlItemCommissionNew">Kommisjon ny</option>
                                </select>

                            </div>
                            <div class="eight wide field">
                                <label id="lblVehicleStatus" runat="server">Status</label>
                                <select id="ddlVehicleStatus" runat="server" size="13" class="wide dropdownList"></select>
                                <%--<asp:DropDownList ID="drpVehicleStatus" CssClass="dropdowns" runat="server"></asp:DropDownList>--%>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnNewVehicleOK" runat="server" class="ui btn wide" value="OK" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnNewVehicleCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal for sjekking av eksisterende kundenummer --%>
    <div id="modVehicleExists" class="ui modal">
        <div class="header">
            Advarsel!
        </div>
        <div class="image content">
            <div class="image">
                <i class="warning icon"></i>
            </div>
            <div class="description">
                <p id="mceMSG"></p>
            </div>
        </div>
        <div class="actions">
            <div class="ui button ok">Se på kjøretøy</div>
            <div class="ui button cancel">Prøv nytt refnr</div>
        </div>
    </div>

    <div class="ui top attached tabular menu">
        <a class="item active" data-tab="first">Hoved</a>
       <%-- <a class="item" data-tab="second">Dato</a>--%>
        <a class="item " data-tab="third">Teknisk</a>
        <a class="item " data-tab="fourth">Økonomi</a>
        <a class="item " data-tab="fifth">Kunde</a>
        <a class="item " id="invoicehistory" data-tab="sixth">Historie</a>
        <a class="item " id="documents" data-tab="seventh">Dokument</a>
        <a class="item " data-tab="eight">Bilsalg</a>
        <a class="item " data-tab="twelvfth">Tilhenger</a>
        <%--<a class="item " data-tab="thirteenth">Vognkort</a>--%>
        <a class="item " data-tab="fourteenth">Skjema</a>
    </div>

    <div class="ui bottom attached tab segment active" data-tab="first">
        <div id="tabGeneral">

            <div class="ui form stackable two column grid">
                <div class="thirteen wide column">
                    <%--left column--%>

                <div class="GenGeneral">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="lblVehicleModel" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Vehicle model:</h3>
                        <%--vehicle model panel--%>
                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="lblGeneralMake" runat="server">Bilmerke</label>
                            </div>
                            <div class="three wide field">
                                <asp:DropDownList ID="drpMakeCodes" CssClass="carsInput" runat="server" meta:resourcekey="drpMakeCodesResource1"></asp:DropDownList>

                            </div>
                            <div class="two wide field">
                                <label>
                                    <asp:Literal ID="lblModelType" runat="server" Text="Model type" meta:resourcekey="lblModelTypeResource1"></asp:Literal></label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtVehicleType" meta:resourcekey="txtVehicleTypeResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <label id="lblVehicleType" runat="server">Type</label>

                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtType" meta:resourcekey="txtTypeResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            
                           

                        </div>
                        <div class="hidden">
                            <asp:TextBox ID="txtTechMakeName" runat="server" meta:resourcekey="txtTechMakeNameResource1"></asp:TextBox>
                            <asp:TextBox ID="txtGeneralMake" runat="server" meta:resourcekey="txtGeneralMakeResource1"></asp:TextBox>
                            <input type="button" id="btnEditMake" runat="server" class="ui btn mini" value=" + " />
                        </div>
                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="lblModelForm" runat="server">ModelForm</label>
                            </div>
                            <div class="three wide field">
                                <asp:DropDownList ID="cmbModelForm" CssClass="carsInput" runat="server" meta:resourcekey="cmbModelFormResource1"></asp:DropDownList>
                            </div>
                            <div class="two wide field">
                                    <label id="lblAddonGroup" runat="server">Addon Group</label>
                                </div>
                            <div class="one wide field">
                                   <asp:TextBox ID="txtTechAddonGrp" runat="server" meta:resourcekey="txtTechAddonGrpResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label>&nbsp;</label>
                                    <asp:TextBox ID="txtTechAddonName" runat="server" meta:resourcekey="txtTechAddonNameResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            <div class="two wide field">
                            <label id="lblWarrantyCode" runat="server">Warranty Code</label>
                            </div>
                            <div class="three wide field">
                                  <asp:DropDownList ID="drpWarrantyCode" CssClass="carsInput" runat="server" meta:resourcekey="drpWarrantyCodeResource1"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="inline fields">
                             <div class="two wide field">
                                <label id="lblModelYear" runat="server">Mod.year</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtModelyr" meta:resourcekey="txtModelyrResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <label id="lblColor" runat="server">Color</label>

                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtColor" meta:resourcekey="txtColorResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                             <div class="two wide field">
                             <label id="lblGearbox" runat="server">Gearbox</label>
                                 </div>
                             <div class="three wide field">
                                    <asp:TextBox ID="txtTechGearBox" runat="server" meta:resourcekey="txtTechGearBoxResource1" CssClass="carsInput"></asp:TextBox>
                            </div>

                        </div>

                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="lblProjectNumber" runat="server">ProjectNo</label>

                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtProjectNo" meta:resourcekey="txtProjectNoResource1" CssClass="carsInput"></asp:TextBox>
                            </div>

                            <div class="two wide field">
                                    <label id="lblFuelCode" runat="server">FuelCode</label>
                                   
                                </div>
                             <div class="one wide field">
                             <asp:TextBox ID="txtTechFuelCode" runat="server" meta:resourcekey="txtTechFuelCodeResource1" CssClass="carsInput"></asp:TextBox>
                                 </div>
                                <div class="two wide field">
                                    <asp:TextBox ID="txtTechFuelName" runat="server" meta:resourcekey="txtTechFuelNameResource1" CssClass="carsInput"></asp:TextBox>
                                    </div>
                              <div class="two wide field">
                             <label id="lblCategory" runat="server">Category</label>
                            </div>
                            <div class="three wide field">
                              <asp:TextBox runat="server" ID="txtCategory" meta:resourcekey="txtCategoryResource1" CssClass="carsInput"></asp:TextBox>
                            </div>

                        </div>
                        <div class="inline fields">
                            <div class="two wide field mil">
                                <label>
                                    <asp:Label ID="lblMileage" Text="Mileage" runat="server" CssClass="mil" meta:resourcekey="lblMileageResource1"></asp:Label>
                                </label>
                            </div>
                            <div class="two wide field hrs">
                                <label>
                                    <asp:Label ID="lblHours" Text="Hours" runat="server" CssClass="hrs" meta:resourcekey="lblHoursResource1"></asp:Label>
                                </label>
                            </div>
                            <div class="three wide field mil">
                                <asp:TextBox runat="server" ID="txtMileage" CssClass="carsInput mil" meta:resourcekey="txtMileageResource1"></asp:TextBox>
                            </div>
                            <div class="three wide field hrs">
                                <asp:TextBox runat="server" ID="txtHours" CssClass="carsInput hrs" meta:resourcekey="txtHoursResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field mil">
                                <label>
                                    <asp:Label ID="lblMileageDate" Text="Mileage Date" runat="server" CssClass="mil" meta:resourcekey="lblMileageDateResource1"></asp:Label>
                                </label>
                            </div>
                            <div class="two wide field hrs">
                                <label>
                                    <asp:Label ID="lblHoursDate" Text="Hours Date" runat="server" CssClass="hrs" meta:resourcekey="lblHoursDateResource1"></asp:Label>
                                </label>
                            </div>
                            <div class="three wide field mil">
                                <asp:TextBox runat="server" ID="txtMileageDate" CssClass="carsInput mil" meta:resourcekey="txtMileageDateResource1"></asp:TextBox>

                            </div>
                            <div class="three wide field hrs">
                                <asp:TextBox runat="server" ID="txtHoursDate" CssClass="carsInput hrs" meta:resourcekey="txtHoursDateResource1"></asp:TextBox>
                            </div>
                            <div class="three wide field">
                                <label id="switchMachineHours">
                                    <asp:CheckBox ID="cbMachineHours" Text="Machine W/Hours" runat="server" meta:resourcekey="cbMachineHoursResource1" />
                                </label>
                            </div>
                        </div>
                        <div class="fields">
                             
                        </div>
                        <div class="fields"></div>
                        <div class="fields">
                            <div class="three wide field">
                                <button type="button" id="btnAddAnnotation" class="ui button carsButtonBlueInverted wide"><i class="exclamation triangle icon" id="exclamIcon" style="color:red;display:none"></i>Anmerkning</button>
                            </div>
                            <div class="three wide field">
                                <button type="button" id="btnAddNote" class="ui button carsButtonBlueInverted wide" value="Notat"><i class="exclamation triangle icon" id="exclamIcon2" style="color:red;display:none"></i>Notat</button>
                            </div>
                            <div class="three wide field">
                                    <button class="ui carsButtonBlueInverted button wide" type="button" id="btnMobWarranty">Mobilitetsgaranti</button>
                                </div>
                            <div class="three wide field">
                                <button type="button" id="btnGeneralPrevRegno" class="ui button carsButtonBlueInverted wide" value="Tidl. regnr">Tidl. regnr</button>
                            </div>
                            
                        </div>
                    </div>
                    <%--end vehicle model panel--%>
                    </div>
                <div class="GenDate">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H11" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Registreringsdatoer</h3>
                        <div class="ui divider"></div>

                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="lblRegYear" runat="server">Reg.year</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtRegyr" meta:resourcekey="txtRegyrResource1" CssClass="carsInput"></asp:TextBox>
                            </div>


                            <div class="two wide field">
                                <label id="lblRegDate" runat="server">RegDate</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtRegDate" meta:resourcekey="txtRegDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="three wide field">
                                <label id="lblPkkDate" runat="server">Periodisk kontroll dato</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtPkkDate" CssClass="carsInput" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="lblRegDateNO" runat="server">RegDate NO</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtRegDateNorway" meta:resourcekey="txtRegDateNorwayResource1" CssClass="carsInput"></asp:TextBox>
                            </div>


                            <div class="two wide field">
                                <label id="lblLastRegDate" runat="server">LastRegDate</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtLastRegDate" meta:resourcekey="txtLastRegDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="three wide field">
                                <label id="lblPkkAfterDate" runat="server">Etterkontroll dato</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtPkkAfterDate" CssClass="carsInput" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="lblDeregDate" runat="server">DeRegDate</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtDeregDate" runat="server" meta:resourcekey="txtAdvSalesmanResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <label id="Label15" runat="server">Tectyl dato</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtTechTectyl" runat="server" CssClass="carsInput" Enabled="false"></asp:TextBox>
                            </div>

                            <div class="three wide field">
                                <label id="lblPerServiceDate" runat="server">Periodisk service dato</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox runat="server" ID="txtPerServiceDate" CssClass="carsInput" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="lblRentalCarDate" runat="server">Leiebil dato</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtRentalCarDate" runat="server" CssClass="carsInput" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <label id="lblMoistControl" runat="server">Fuktkontroll dato</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtMoistControl" runat="server" CssClass="carsInput" Enabled="false"></asp:TextBox>
                            </div>

                            <div class="three wide field">
                                
                            </div>
                            <div class="three wide field">
                                
                            </div>
                        </div>
                        <h3 id="H4" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Ordredatoer</h3>
                        <div class="ui divider"></div>
                        <div class="inline fields">
                            <div class="three wide field">
                                <label id="lblTakenInDate" runat="server">Taken in Date</label>

                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechTakenInDate" runat="server" Columns="10" meta:resourcekey="txtTechTakenInDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>


                            <div class="three wide field">
                                <label id="lblMileageTakenIn" runat="server">Mileage</label>

                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechMileageTakenIn" runat="server" meta:resourcekey="txtTechMileageTakenInResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>

                        <div class="inline fields">
                            <div class="three wide field">
                                <label id="lblDeliveryDate" runat="server">Delivery Date</label>

                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechDeliveryDate" runat="server" meta:resourcekey="txtTechDeliveryDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>


                            <div class="three wide field">
                                <label id="lblMileageDelivered" runat="server">Mileage</label>

                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechMileageDelivered" runat="server" meta:resourcekey="txtTechMileageDeliveredResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>

                        <div class="inline fields">
                            <div class="three wide field">
                                <label id="lblServiceDate" runat="server">Service Date</label>


                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechServiceDate" runat="server" meta:resourcekey="txtTechServiceDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>

                            <div class="three wide field">
                                <label id="lblMileageService" runat="server">Mileage</label>


                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechMileageService" runat="server" meta:resourcekey="txtTechMileageServiceResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>

                        <div class="inline fields">
                            <div class="three wide field">
                                <label id="lblCallInDate" runat="server">Call in Date</label>

                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechCallInDate" runat="server" meta:resourcekey="txtTechCallInDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>


                            <div class="three wide field">
                                <label id="lblMileageCallIn" runat="server">Mileage</label>

                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechMileageCallIn" runat="server" meta:resourcekey="txtTechMileageCallInResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="three wide field">
                                <label id="lblCleanedDate" runat="server">Cleaned date</label>

                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtTechCleanedDate" runat="server" meta:resourcekey="txtTechCleanedDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>


                            <div class="three wide field">
                                 <label id="lblLastContactDate" runat="server">Last contact Date</label>
                              
                            </div>
                            <div class="five wide field">
                                  <asp:TextBox runat="server" ID="txtLastContactDate" meta:resourcekey="txtLastContactDateResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>

                    </div>
                </div>
                    <div class="GenPKKService">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <div class="eight wide column">
                        <h3 id="H18" runat="server" class="ui blue top medium header left aligned" style="border-color: blue !important">PKK</h3>
                             <button class="ui button carsButtonBlueInverted inheaderButton" type="button" id="btnPKKResult">PKK resultat</button>
                            </div>
                        <div class="ui divider"></div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Literal ID="liTechLastPkkOk" runat="server" Text="Last PKK Approved" meta:resourcekey="liTechLastPkkOkResource1"></asp:Literal></label>
                            </div>
                            <div class="four wide field">
                                <asp:TextBox ID="txtTechLastPkkOk" runat="server" meta:resourcekey="txtTechLastPkkOkResource1" CssClass="carsInput"></asp:TextBox>
                            </div>


                            <div class="four wide field">
                                <label>
                                    <asp:Literal ID="liTechNextPkk" runat="server" Text="Next PKK" meta:resourcekey="liTechNextPkkResource1"></asp:Literal></label>
                            </div>
                            <div class="four wide field">
                                <asp:TextBox ID="txtTechNextPkk" runat="server" meta:resourcekey="txtTechNextPkkResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Literal ID="liTechLastInvoicedPkk" runat="server" Text="Last invoiced PKK" meta:resourcekey="liTechLastInvoicedPkkResource1"></asp:Literal></label>
                            </div>
                            <div class="four wide field">
                                <asp:TextBox ID="txtTechLastInvoicedPkk" runat="server" meta:resourcekey="txtTechLastInvoicedPkkResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label>
                                    <asp:CheckBox ID="cbTechDoNotCallPkk" CssClass="center" runat="server" Text="Do not call in for Pkk" meta:resourcekey="cbTechDoNotCallPkkResource1" />
                                </label>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label class="centerlabel">
                                    <asp:Literal ID="liTechDeviationsPkk" runat="server" Text="Avvik PKK" meta:resourcekey="liTechDeviationsPkkResource1"></asp:Literal></label>
                            </div>
                            <div class="four wide field">
                                <asp:TextBox ID="txtTechDeviationsPkk" runat="server" meta:resourcekey="txtTechDeviationsPkkResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            
                        </div>
                        <h3 id="H5" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Service</h3>
                        <div class="ui divider"></div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:CheckBox ID="cbTechCallInService" runat="server" Text="Call in to service" meta:resourcekey="cbTechCallInServiceResource1" CssClass="CarsBoxes" />
                                </label>
                            </div>
                            <div class="four wide field">
                                    <label>
                                        <asp:CheckBox ID="cbTechServiceBook" runat="server" Text="Servicehefte" meta:resourcekey="cbTechServiceBookResource1" />
                                    </label>
                                </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label class="centerlabel">
                                    <asp:Literal ID="liTechCallInMonth" runat="server" Text="Måned" meta:resourcekey="liTechCallInMonthResource1"></asp:Literal></label>
                            </div>
                            <div class="four wide field">
                                <asp:TextBox ID="txtTechCallInMonth" runat="server" meta:resourcekey="txtTechCallInMonthResource1" CssClass="carsInput"></asp:TextBox>
                                <asp:TextBox ID="txtTechCallInMonthDesc" runat="server" meta:resourcekey="txtTechCallInMonthResource1" Visible="False"></asp:TextBox>
                            </div>
                            <div class="four wide field">
                                <label class="centerlabel">
                                    <asp:Literal ID="liTechMileage" runat="server" Text="Km.stand" meta:resourcekey="liTechMileageResource1"></asp:Literal></label>
                            </div>
                            <div class="four wide field">
                                <asp:TextBox ID="txtTechMileage" runat="server" meta:resourcekey="txtTechMileageResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>
                            <div class="inline fields">
                                <div class="four wide field">
                                <label class="centerlabel">
                                    <asp:Literal ID="liTechYearlyMileage" runat="server" Text="Årlig kjørte Km." meta:resourcekey="liTechYearlyMileageResource1"></asp:Literal></label>
                            </div>
                            <div class="four wide field">
                                <asp:TextBox ID="txtTechYearlyMileage" runat="server" meta:resourcekey="txtTechYearlyMileageResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            </div>
                    </div>

                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H10" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Andre innstillinger</h3>
                        <div class="ui divider"></div>
                        <div class="fields">
                            <div class="eight wide field">
                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnInvSettings">Faktura innst.</button>
                            </div>
                            <div class="eight wide field">
                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnWhat">???</button>
                            </div>
                        </div>
                    </div>
                    </div>
                    <div class="GenPictures">
                        

                <div class="five wide column">
              
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H22" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Bilder</h3>               
                        <div class="ui divider"></div>
                        <div class="fields">
                            <div class="four wide field"> <asp:FileUpload ID="uploadPicture" class="ui file" runat="server" meta:resourcekey="uploadPictureResource1"/>
                                <asp:Button ID="BtnUploadFile" class="ui button carsButtonBlueInverted" runat="server" Text="Last opp vedlegg" OnClick="BtnUploadFile_Click" CausesValidation="False" meta:resourcekey="BtnUploadFileResource1"></asp:Button>
                                <%--<button class="ui button carsButtonBlueInverted" runat="server" id="btnUploadFile" OnClick="btnUploadFile_Click"  style="margin-top: 10px;"><i class="upload icon"></i>Last opp</button>--%>
                                  <div class="fields"> 
                                       <div class="eight wide field">
                                           <div id="pictureTable"></div>
                                           </div>
                                       <div class="four wide field">
                                <ul id="pictureUl"></ul>
                                      </div>
                                      </div>
                            </div>                        
                            <div class="eight wide field">
                                <div id="mainPicture"></div>
                               
                            </div>  
                             
                            <div class="four wide field">
                               <div id="drop-area">
                                  <form class="my-form">
                                    <p>Upload multiple files with the file dialog or by dragging and dropping images onto the dashed region</p>
                                    <input type="file" id="fileElem" multiple accept="image/*"  onchange="handleFiles(this.files)"/>
                                     
                                    <label class="button" for="fileElem">Select some files</label>
                                  </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="H23" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Dokumenter</h3>               
                        </div>
                        </div>
                    </div>
                </div>
                 <div class="three wide column">
                        <div class="ui form">
                            <%--<div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">--%>
                            <h3 id="H19" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Velg fra listen</h3>
                                <div class="fields">
                                <button type="button" id="btnGen1" class="ui button carsButtonBlueNotInverted wide">Generelt</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnGen2" class="ui button carsButtonBlueInverted wide">Dato</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnGen3" class="ui button carsButtonBlueInverted wide">PKK/Service</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnGen4" class="ui button carsButtonBlueInverted wide">Bilder</button> 
                                </div>
                            <%--</div>--%>
                        </div>
                    </div>
            </div>
        </div>
    </div>

    <%--End tab general--%>

    <div class="ui small modal" id="modGeneralPrevRegno">
        <div class="ui blue top medium header center aligned" style="text-align: center;">Tidligere registreringsnummer</div>
        <div class="content">
            <div class="ui form ">
                 <div class="ui divided grid">
                <div class="eight wide column">
                    
                            <div class="inline fields">
                                <div class="eight wide field">
                                   <label>
                                        <asp:Literal ID="liEarlyRegNo1" runat="server" meta:resourcekey="liEarlyRegNo1Resource1" Text="Early regno 1"></asp:Literal>
                                    </label>
                                </div>
                                <div class="eight wide field">
                                   <asp:TextBox ID="txtEarlyRegNo1" runat="server" meta:resourcekey="txtEarlyRegNo1Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                    <div class="inline fields">
                                <div class="eight wide field">
                                   <label>
                                        <asp:Literal ID="liEarlyRegNo2" runat="server" meta:resourcekey="liEarlyRegNo2Resource1" Text="Early regno 2"></asp:Literal>
                                    </label>
                                </div>
                                <div class="eight wide field">
                                   <asp:TextBox ID="txtEarlyRegNo2" runat="server" meta:resourcekey="txtEarlyRegNo2Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                    
					</div>
                     <div class="eight wide column">
                    
                            <div class="inline fields">
                                <div class="eight wide field">
                                   <label>
                                        <asp:Literal ID="liEarlyRegNo3" runat="server" meta:resourcekey="liEarlyRegNo3Resource1" Text="Early regno 3"></asp:Literal>
                                    </label>
                                </div>
                                <div class="eight wide field">
                                  <asp:TextBox ID="txtEarlyRegNo3" runat="server" meta:resourcekey="txtEarlyRegNo3Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                    <div class="inline fields">
                                <div class="eight wide field">
                                   <label>
                                        <asp:Literal ID="liEarlyRegNo4" runat="server" meta:resourcekey="liEarlyRegNo4Resource1" Text="Early regno 4"></asp:Literal>
                                    </label>
                                </div>
                                <div class="eight wide field">
                                  <asp:TextBox ID="txtEarlyRegNo4" runat="server" meta:resourcekey="txtEarlyRegNo4Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                    
					</div>
                </div>
         </div>
    </div>
    <div class="actions">
        <div class="ui approve success button">OK</div>
        <div class="ui cancel button">Avbryt</div>
    </div>
    
</div>

    <div class="ui small modal" id="modDatePKKResult">
        <div class="ui blue top medium header center aligned" style="text-align: center;">Resultat av siste EU kontroll</div>
        <div class="content">
            <div class="ui form ">
                
                <div class="sixteen wide column">
                    
                            <div class="inline fields">
                                <div class="three wide field">
                                   <label>
                                        <asp:Literal ID="Literal1" runat="server" meta:resourcekey="liEarlyRegNo1Resource1" Text="Antall 1-feil"></asp:Literal>
                                    </label>
                                </div>
                                <div class="three wide field">
                                   <asp:TextBox ID="TextBox9" runat="server" meta:resourcekey="txtEarlyRegNo1Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                 <div class="two wide field">
                               
                                </div>
                               <div class="three wide field">
                                   <label>
                                        <asp:Literal ID="Literal6" runat="server" meta:resourcekey="liEarlyRegNo2Resource1" Text="Godkjent"></asp:Literal>
                                    </label>
                                </div>
                                <div class="three wide field">
                                   <asp:TextBox ID="TextBox14" runat="server" Enabled="False" meta:resourcekey="txtEarlyRegNo2Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                               
                            </div>
                    <div class="inline fields">
                                
                                <div class="three wide field">
                                   <label>
                                        <asp:Literal ID="Literal4" runat="server" meta:resourcekey="liEarlyRegNo1Resource1" Text="Antall 2-feil"></asp:Literal>
                                    </label>
                                </div>
                                <div class="three wide field">
                                   <asp:TextBox ID="TextBox12" runat="server" meta:resourcekey="txtEarlyRegNo1Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                           <div class="two wide field">
                               
                                </div>
                                
                        <div class="three wide field">
                                   <label>
                                        <asp:Literal ID="Literal8" runat="server" meta:resourcekey="liEarlyRegNo2Resource1" Text="Kontrolldato"></asp:Literal>
                                    </label>
                                </div>
                                <div class="three wide field">
                                   <asp:TextBox ID="TextBox16" runat="server" Enabled="False" meta:resourcekey="txtEarlyRegNo2Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                    <div class="inline fields"> 
                        <div class="three wide field">
                        <label>
                            <asp:Literal ID="Literal3" runat="server" meta:resourcekey="liEarlyRegNo2Resource1" Text="Antall 3-feil"></asp:Literal>
                        </label>
                        </div>
                        <div class="three wide field">
                            <asp:TextBox ID="TextBox11" runat="server" meta:resourcekey="txtEarlyRegNo2Resource1" CssClass="carsInput"></asp:TextBox>
                        </div>
                        <div class="two wide field">
                               
                        </div>
                        <div class="four wide field">
                            <button class="ui button carsButtonBlueInverted wide" style="padding:0.5em 1.5em 0.5em !important" type="button" id="btnGetPKKResult">Hent resultat</button>
                        </div>
                    </div>
                </div>
         </div>
    </div>
    <div class="actions">
        <div class="ui cancel button">Lukk</div>
    </div> 
</div>

    <%-- makeEdit Modal --%>
    <div id="modEditMake" class="modal hidden">
        <div class="modHeader">
            <h2 id="lblEditMake" runat="server"></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Nytt kjøretøy</label>
                    <div class="ui small info message">
                        <p id="lblEditMakeStatus" runat="server">Bilmerke status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label4" runat="server">Bilmerkeliste</label>
                                <select id="drpEditMakeList" runat="server" size="13" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblEditMakeCode" Text="Fabrikatkode" runat="server" meta:resourcekey="lblEditMakeCodeResource1" CssClass="CarsBoxes"></asp:Label></label>
                                    <asp:TextBox ID="txtEditMakeCode" runat="server" meta:resourcekey="txtEditMakeCodeResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblEditMakeDescription" Text="Beskrivelse" runat="server" meta:resourcekey="lblEditMakeDescriptionResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtEditMakeDescription" runat="server" meta:resourcekey="txtEditMakeDescriptionResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="hidden">
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblEditMakePriceCode" Text="Priskode" runat="server" meta:resourcekey="lblEditMakePriceCodeResource1"></asp:Label></label>
                                        <asp:TextBox ID="txtEditMakePriceCode" runat="server" meta:resourcekey="txtEditMakePriceCodeResource1" CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblEditMakeDiscount" Text="Rabatt" runat="server" meta:resourcekey="lblEditMakeDiscountResource1"></asp:Label></label>
                                        <asp:TextBox ID="txtEditMakeDiscount" runat="server" meta:resourcekey="txtEditMakeDiscountResource1" CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblEditMakeVat" Text="Mva kode" runat="server" meta:resourcekey="lblEditMakeVatResource1"></asp:Label></label>
                                        <asp:TextBox ID="txtEditMakeVat" runat="server" meta:resourcekey="txtEditMakeVatResource1" CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnEditMakeNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnEditMakeDelete" runat="server" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnEditMakeSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnEditMakeCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modGeneralAnnotation" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation</h2>
            <div class="modCloseGeneralAnnotation"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3 id="lblModAnnotation" runat="server">Annotation:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtGeneralAnnotation" TextMode="MultiLine" runat="server" meta:resourcekey="txtGeneralAnnotationResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveGeneralAnnotation" runat="server" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modGeneralNote" class="modal hidden">
        <div class="modHeader">
            <h2 id="lblModNote" runat="server">Annotation</h2>
            <div class="modCloseGeneralNote"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Note</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtGeneralNote" TextMode="MultiLine" runat="server" meta:resourcekey="txtGeneralNoteResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" runat="server" id="btnSaveGeneralNote" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- New tab for Tecnical --%>
    <div class="ui bottom attached tab segment" data-tab="third">
        <div id="tabTechnical">
            <div class="ui grid">

                <div class="thirteen wide column">
                    <div class="TechGeneral">
                    <div class="ui form">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);min-height: 30em !important;">
                            <h3 id="lblTechnicalData" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Tekniske data</h3>
                              <div class="ui divider"></div>
                            <div class="inline fields">
                                 <div class="hidden"><asp:TextBox ID="txtTechVehGrp" runat="server" meta:resourcekey="txtTechVehGrpResource1" CssClass="carsInput"></asp:TextBox></div>
                            <div class="two wide field">
                                <label id="lblVehicleGroup" runat="server">Veh.group</label>
                            </div>
                            <div class="three wide field">
                              <asp:TextBox ID="txtTechVehGrpName" runat="server" meta:resourcekey="txtTechVehGrpNameResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <label id="lblPickNo" runat="server">PickNo</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtTechPick" runat="server" meta:resourcekey="txtTechPickResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                               <label id="lblRicambiNo" runat="server">RicambiNo</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtTechRicambiNo" runat="server" meta:resourcekey="txtTechRicambiNoResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>
                            <div class="inline fields">
                            <div class="two wide field">
                                 <label id="lblEngineNo" runat="server">Engine No</label>
                            </div>
                            <div class="three wide field">
                          <asp:TextBox ID="txtTechEngineNo" runat="server" meta:resourcekey="txtTechEngineNoResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                                <div class="two wide field">
                                <label id="lblMakeCode" runat="server">Fabr.kode</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtTechMake" runat="server" meta:resourcekey="txtTechMakeResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                          <div class="two wide field">
                                <label id="lblVinNo" runat="server">VIN No</label>
                            </div>
                            <div class="three wide field">
                                <asp:TextBox ID="txtTechVin" runat="server" meta:resourcekey="txtTechVinResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                           
                        </div>
                            

                          
                            <div class="inline fields">
                            <div class="two wide field">
                                 <label id="lblTechDocNo" runat="server">Techdoc No</label>
                            </div>
                            <div class="three wide field">
                             <asp:TextBox ID="txtTechTechdocNo" runat="server" meta:resourcekey="txtTechTechdocNoResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                              <label id="lblFuelCard" runat="server">Fuel Card</label>
                            </div>
                            <div class="three wide field">
                              <asp:TextBox ID="txtTechFuelCard" runat="server" meta:resourcekey="txtTechFuelCardResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                            <label id="lblMomskode" runat="server">Momskode</label>
                            </div>
                            <div class="three wide field">
                                 <asp:DropDownList ID="ddlVatCode" CssClass="carsInput" runat="server" meta:resourcekey="ddlVatCodeResource"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="inline fields">
                           
                            <div class="two wide field">
                            
                            </div>
                            <div class="three wide field">
                            
                            </div>
                            <div class="two wide field">
                           
                            </div>
                            <div class="three wide field">
                                
                            </div>
                        </div>
                            <div class="fields">
                                <div class="four wide field">
                                    <label>
                                        <asp:CheckBox ID="cbTechPressureMechBrakes" runat="server" Text="Trykkluftmek. bremser" meta:resourcekey="cbTechPressureMechBrakesResource1" />
                                    </label>
                                </div>
                                <div class="four wide field">
                                    <label>
                                        <asp:CheckBox ID="cbTechTowbar" runat="server" Text="Tilhengerfeste" meta:resourcekey="cbTechTowbarResource1" />
                                    </label>
                                </div>
                                <div class="four wide field">
                                <label>
                                    <asp:CheckBox ID="cbTechUsedImported" runat="server" Text="Used imported" meta:resourcekey="cbTechUsedImportedResource1" />
                                </label>
                            </div>
                                 
                            </div>
                            <h3 id="lblDetails" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Tekniske detaljer</h3>
                              <div class="ui divider"></div>
                            <div class="fields">
                                
                                <div class="four wide field">
                                    <label id="lblProductNumber" runat="server">Produktnr.</label>
                                    <asp:TextBox ID="txtTechProductNo" runat="server" meta:resourcekey="txtTechProductNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblElCode" runat="server">El.kode?</label>
                                    <asp:TextBox ID="txtTechElCode" runat="server" meta:resourcekey="txtTechElCodeResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblPurchaseOrder" runat="server">Purchase Ord.</label>
                                    <asp:TextBox ID="txtTechPurchaseNo" runat="server" meta:resourcekey="txtTechPurchaseNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblTires" runat="server">Tires</label>
                                    <asp:TextBox ID="txtTechTireInfo" runat="server" meta:resourcekey="txtTechTireInfoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>

                            </div>
                            <div class="fields">
                                
                                
                                
                            </div>
                         
                            <div class="fields">
                                <div class="four wide field">
                                    <label id="lblServiceCategory" runat="server">Serv.Cat</label>
                                    <asp:TextBox ID="txtTechServiceCategory" runat="server" meta:resourcekey="txtTechServiceCategoryResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblNOApprovalNo" runat="server">NO Approval No</label>
                                    <asp:TextBox ID="txtTechApprovalNo" runat="server" meta:resourcekey="txtTechApprovalNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblEUApprovalNo" runat="server">EU Approval No</label>
                                    <asp:TextBox ID="txtTechEUApprovalNo" runat="server" meta:resourcekey="txtTechEUApprovalNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblVanNumber" runat="server">VAN No</label>
                                    <asp:TextBox ID="txtTechVanNo" runat="server" meta:resourcekey="txtTechVanNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields"></div>
                        </div>
                    </div>
                </div>
                    <div class="TechCertificate">
                        <div class="ui form">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);min-height: 30em !important;">
                        <h3 id="lblCertVehicleCertification" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Vehicle certification:</h3>
                            <div class="inline fields">
                                <div class="two wide field">
                                    <label id="lblCertTireDimFront" runat="server">Tire dim. front</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertTireDimFront" meta:resourcekey="txtCertTireDimFrontResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                
                                <div class="two wide field">
                                    <label id="lblCertTireDimBack" runat="server">Tire dim. back</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertTireDimBack" meta:resourcekey="txtCertTireDimBackResource1" CssClass="carsInput"></asp:TextBox>
                                        
                                </div>

                                <div class="two wide field">
                                    <label id="lblCertLiPlyratFront" runat="server">LI (Plyrat) front</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertLiFront" meta:resourcekey="txtCertLiFrontResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                </div>
                            <div class="inline fields">
                                <div class="two wide field">
                                    <label id="lblCertLiPlyratBack" runat="server">LI (Plyrat) back</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertLiBack" meta:resourcekey="txtCertLiBackResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                
                                <div class="two wide field">
                                    <label id="lblCertMinInpressFront" runat="server">Min. inpress front</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertMinInpressFront" meta:resourcekey="txtCertMinInpressFrontResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                <div class="two wide field">
                                    <label id="lblCertMinInpressBack" runat="server">Min. inpress back</label>
                                     </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertMinInpressBack" meta:resourcekey="txtCertMinInpressBackResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                                
                                
                            <div class="inline fields">
                                
                                <div class="two wide field">
                                    <label id="lblCertStdRimFront" runat="server">Std rim front</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertRimFront" meta:resourcekey="txtCertRimFrontResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblCertStdRimBack" runat="server">Std rim back</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertRimBack" meta:resourcekey="txtCertRimBackResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblCertMinSpeedFront" runat="server">Min. speed front</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertminSpeedFront" meta:resourcekey="txtCertminSpeedFrontResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                            <div class="inline fields">
                                <div class="two wide field">
                                    <label id="lblCertMinSpeedBack" runat="server">Min. speed back</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertMinSpeedBack" meta:resourcekey="txtCertMinSpeedBackResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblCertMaxWheelWidthFront" runat="server">Max wheel-width front</label>
                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertMaxWidthFront" meta:resourcekey="txtCertMaxWidthFrontResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblCertMaxWheelWidthBack" runat="server">Max wheel-width back</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertMaxWidthBack" meta:resourcekey="txtCertMaxWidthBackResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                
                                <div class="two wide field">
                                    <label id="lblCertAxlePressureFront" runat="server">Axel pressure front</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertAxlePressureFront" meta:resourcekey="txtCertAxlePressureFrontResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblCertAxlePressureBack" runat="server">Axle pressure back</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertAxlePressureBack" meta:resourcekey="txtCertAxlePressureBackResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblCertNumberOfAxles" runat="server">No. of axles</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertAxleQty" meta:resourcekey="txtCertAxleQtyResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                 <div class="two wide field">
                                    <label id="lblCertAxlesWithTraction" runat="server">Axles with traction</label>
                                     </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertAxleWithTraction" meta:resourcekey="txtCertAxleWithTractionResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblCertGear" runat="server">Drivhjul</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtCertGear" meta:resourcekey="txtCertGearResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <label id="lblMaxRoofLoad" runat="server">Max roof weight</label>
                                    </div>
                                    <div class="three wide field">
                                    <asp:TextBox runat="server" ID="txtMaxRoofLoad" meta:resourcekey="txtCertMaxRoofWeightResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                               
                            </div>
                            <div class="fields" style="margin-top: 3rem;">


                                        <div class="three wide field">
                                            <button class="ui button carsButtonBlueInverted wide" type="button" id="btnCertAnnotation">Merknader</button>
                                        </div>
                                        <div class="three wide field">
                                            <button class="ui button carsButtonBlueInverted wide" type="button" id="btnCertTrailer">Xtra-sjekk</button>
                                        </div>
                               
                                    </div>
                        </div>
                        
                    </div>
                    </div>
                    <div class="TechMeasure">
                        <div class="ui form">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);min-height: 30em !important;">
                            <h3 id="measuresData" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Måledata</h3>
                            <div class="fields">
                                <div class="five wide field">
                                    <label id="lblLength" runat="server">Length</label>
                                    <asp:TextBox ID="txtTechLength" runat="server" meta:resourcekey="txtTechLengthResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblWidth" runat="server">Width</label>
                                    <asp:TextBox ID="txtTechWidth" runat="server" meta:resourcekey="txtTechWidthResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblStdNoise" runat="server">Std. noise</label>
                                    <asp:TextBox ID="txtTechNoise" runat="server" meta:resourcekey="txtTechNoiseResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="five wide field">
                                    <label id="lblEffectKw" runat="server">Effect kW</label>
                                    <asp:TextBox ID="txtTechEffect" runat="server" meta:resourcekey="txtTechEffectResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblPistonDisp" runat="server">Piston disp</label>
                                    <asp:TextBox ID="txtTechPistonDisp" runat="server" meta:resourcekey="txtTechPistonDispResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblRoundMin" runat="server">Rounds/min</label>
                                    <asp:TextBox ID="txtTechRoundperMin" runat="server" meta:resourcekey="txtTechRoundperMinResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>

                            <div class="fields">
                                <div class="five wide field">
                                    <label id="lblNetWeight" runat="server">Net Weight</label>
                                    <asp:TextBox runat="server" ID="txtNetWeight" meta:resourcekey="txtNetWeightResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblTotWeight" runat="server">Tot Weight</label>
                                    <asp:TextBox runat="server" ID="txtTotWeight" meta:resourcekey="txtTotWeightResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblPracticalLoad" runat="server">"Nyttelast"</label>
                                    <asp:TextBox runat="server" ID="txtPracticalLoad" meta:resourcekey="txtPracticalLoadResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>





                            
                        </div>
                        </div>
                    </div>
                    <div class="TechInterior">
                        <div class="ui form">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);min-height: 30em !important;">
                            <h3 id="interiorData" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important;">Interiør data</h3>
                            <div class="ui form">
                                <div class="fields">
                                    <div class="four wide field">
                                        <label>
                                            <asp:Literal ID="liTechRadioCode" runat="server" Text="Radiokode" meta:resourcekey="liTechRadioCodeResource1"></asp:Literal></label>
                                        <asp:TextBox ID="txtTechRadioCode" runat="server" meta:resourcekey="txtTechRadioCodeResource1" CssClass="carsInput"></asp:TextBox>
                                    </div>
                                    <div class="four wide field">
                                        <label>
                                            <asp:Literal ID="liTechStartImmobilizer" runat="server" Text="Startsperrekode" meta:resourcekey="liTechStartImmobilizerResource1"></asp:Literal></label>
                                        <asp:TextBox ID="txtTechStartImmobilizer" runat="server" meta:resourcekey="txtTechStartImmobilizerResource1" CssClass="carsInput"></asp:TextBox>
                                    </div>
                                    <div class="four wide field">
                                    <label id="lblInterorCode" runat="server">Interior Code</label>
                                    <asp:TextBox ID="txtTechInteriorCode" runat="server" meta:resourcekey="txtTechInteriorCodeResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                                <div class="fields">
                                    <div class="four wide field">
                                        <label id="lblKeyNumber" runat="server">KeyNo</label>
                                        <asp:TextBox ID="txtTechKeyNo" runat="server" meta:resourcekey="txtTechKeyNoResource1" CssClass="carsInput"></asp:TextBox>
                                    </div>
                                    <div class="four wide field">
                                        <label id="lblDoorKey" runat="server">Door key</label>
                                        <asp:TextBox ID="txtTechDoorKeyNo" runat="server" meta:resourcekey="txtTechDoorKeyNoResource1" CssClass="carsInput"></asp:TextBox>
                                    </div>
                                
                                
                                    <div class="four wide field">
                                        <label>
                                            <asp:Literal ID="liTechQtyKeys" runat="server" Text="Ant. nøkler" meta:resourcekey="liTechQtyKeysResource1"></asp:Literal></label>
                                        <asp:TextBox ID="txtTechQtyKeys" runat="server" meta:resourcekey="txtTechQtyKeysResource1" CssClass="carsInput"></asp:TextBox>
                                    </div>
                                  
                               </div>
                                   <div class="fields">
                                         <div class="four wide field">
                                        <label>
                                            <asp:Literal ID="liTechKeyTag" runat="server" Text="Nøkkeltagnr." meta:resourcekey="liTechKeyTagResource1"></asp:Literal></label>
                                        <asp:TextBox ID="txtTechKeyTag" runat="server" meta:resourcekey="txtTechKeyTagResource1" CssClass="carsInput"></asp:TextBox>
                                    </div>
                                   </div>
                            </div>
                        </div>
                    </div>
                    </div>
            </div>
                <div class="three wide column">
                        <div class="ui form">
                            <%--<div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">--%>
                            <h3 id="H17" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Velg fra listen</h3>
                                <div class="fields">
                                <button type="button" id="btnTech1" class="ui button carsButtonBlueNotInverted wide">Generelt</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnTech2" class="ui button carsButtonBlueInverted wide">Vognkort</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnTech3" class="ui button carsButtonBlueInverted wide">Måledata</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnTech4" class="ui button carsButtonBlueInverted wide">Interiørdata</button> 
                                </div>
                            <%--</div>--%>
                        </div>
                    </div>
                <div class="eight wide column">
                    
                    </div>
                    <div class="eight wide column">
                        
                </div>
            </div>
        </div>
    </div>
    <%-- New tab for Economy --%>
    <div class="ui bottom attached tab segment" data-tab="fourth">
        <div id="tabEconomy">
            <div class="ui grid">

                <div class="five wide column">
                    <div class="ui form">

                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblContribution" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Bidrag</h3>
                            <div class="ui divider"></div>

                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSalesPriceExVat" runat="server">Salgspris eks. mva</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoSalespriceNet" runat="server" meta:resourcekey="txtEcoSalespriceNetResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSalesFees" runat="server">Salgs salær</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoSalesSale" runat="server" meta:resourcekey="txtEcoSalesSaleResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSalesEquipment" runat="server">Sale equipment</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoSalesEquipment" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoSalesEquipmentResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblRegistrationCosts" runat="server">Reg omkostninger</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoRegCost" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoRegCostResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSubtractedDiscount" runat="server">- Rabatt</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoDiscount" runat="server" meta:resourcekey="txtEcoDiscountResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSalesPriceNet" runat="server">Netto Salgspris</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoNetSalesPrice" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoNetSalesPriceResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSubtractedCosts" runat="server">- Selvkost</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoFixCost" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoFixCostResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblAssistSales" runat="server">Bidrag ved salg</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoAssistSales" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoAssistSalesResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCostAfterSale" runat="server">Cost after sale</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoCostAfterSale" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoCostAfterSaleResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblContributionToday" runat="server">Contributions today</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoContributionsToday" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoContributionsTodayResource1"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="five wide column">
                    <div class="ui form">

                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblVehiclePrice" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Bilpris</h3>
                            <div class="ui divider"></div>

                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSalesPriceGross" runat="server">Salgspris inkl. mva</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoSalesPriceGross" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoSalesPriceGrossResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblRegistrationFee" runat="server">Reg. avgift</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoRegFee" runat="server" meta:resourcekey="txtEcoRegFeeResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblVatFromSalesprice" runat="server">MVA av salgspris</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoVat" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoVatResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblTotalVehicleAmount" runat="server">Total bilpris</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoVehTotAmount" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoVehTotAmountResource1"></asp:TextBox>
                                </div>
                            </div>

                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblEquipmentAmount" runat="server">Bidrag utstyr</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoEquipmentAmount" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoEquipmentAmountResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblWreckingAmount" runat="server">Vrakpant</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoWreckingAmount" runat="server" meta:resourcekey="txtEcoWreckingAmountResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblYearlyFee" runat="server">Årsavgift</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoYearlyFee" runat="server" meta:resourcekey="txtEcoYearlyFeeResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblInsurance" runat="server">Forsikring</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoInsurance" runat="server" meta:resourcekey="txtEcoInsuranceResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                <button type="button" id="btnEco1" class="ui button carsButtonBlueInverted wide">Vis mer</button> 
                                </div>
                                </div>

                        </div>
                    </div>
                </div>

                <div class="five wide column">
                    <div class="ui form">

                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblCosts" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Selvkost:</h3>
                            <div class="ui divider"></div>

                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCostPriceNet" runat="server">Inntakspris eks. mva</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoCostPriceNet" runat="server" meta:resourcekey="txtEcoCostPriceNetResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblInsuranceBonus" runat="server">Oppnådd bonus</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoInsuranceBonus" runat="server" meta:resourcekey="txtEcoInsuranceBonusResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCostFee" runat="server">Inntaks salær</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoInntakeSaler" runat="server" meta:resourcekey="txtEcoInntakeSalerResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCostBeforeSale" runat="server">Påkost før salg</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoCostBeforeSale" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoCostBeforeSaleResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblSalesProvision" runat="server">Selger provisjon</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoSalesProvision" runat="server" meta:resourcekey="txtEcoSalesProvisionResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCommitDay" runat="server">Kommisjonsdager</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoCommitDay" runat="server" meta:resourcekey="txtEcoCommitDayResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblAddedInterests" runat="server">Påløpte renter</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoAddedInterests" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoAddedInterestsResource1"></asp:TextBox>
                                </div>
                            </div>

                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCostEquipment" runat="server">Kost utstyr</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoCostEquipment" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoCostEquipmentResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblTotalCost" runat="server">Selvkost</label>
                                </div>
                                <div class="eight wide field">
                                    <asp:TextBox ID="txtEcoTotalCost" runat="server" CssClass="carsInput fixed" meta:resourcekey="txtEcoTotalCostResource1"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="one wide column">
                    </div>
               <div class="five wide column">
                    </div>
              
            </div>

        </div>
    </div>

    <div class="ui small modal" id="modEcoInfo">
        <div class="ui blue top medium header center aligned" style="text-align: center;">kjøp og salg</div>
        <div class="content">
            <div class="ui form ">
                <div class="ui divided grid">
                <div class="eight wide column">
                    
                            <h3 id="H6" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Credit note/ taken in:</h3>
                            <div class="fields">
                                <div class="six wide field">
                                    <label>Credit note No</label>
                                    <asp:TextBox ID="txtEcoCreditNote" runat="server" meta:resourcekey="txtEcoCreditNoteResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label>&nbsp;</label>
                                    <input type="button" id="btnEcoShowCreditNote" class="ui btn" value="Vis" />
                                </div>
                                <div class="six wide field">
                                    <label>Credit note date</label>
                                    <asp:TextBox ID="txtEcoCreditDate" runat="server" meta:resourcekey="txtEcoCreditDateResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                   <h3 id="H7" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Invoice/ Sale:</h3>
                            <div class="fields">
                                <div class="six wide field">
                                    <label>Invoice No</label>
                                    <asp:TextBox ID="txtEcoInvoiceNo" runat="server" meta:resourcekey="txtEcoInvoiceNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label>&nbsp;</label>
                                    <input type="button" id="btnEcoShowInvoice" class="ui btn" value="Vis" />
                                </div>
                                <div class="six wide field">
                                    <label>Credit note date</label>
                                    <asp:TextBox ID="txtEcoInvoiceDate" runat="server" meta:resourcekey="txtEcoInvoiceDateResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                    
                    </div>
                         <div class="eight wide column">   
                            <h3 id="H8" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Rebuy:</h3>
                            <div class="fields">
                                <div class="twelve wide field">
                                    <label>Date</label>
                                    <asp:TextBox ID="txtEcoRebuy" runat="server" meta:resourcekey="txtEcoRebuyResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                             <h3 id="H9" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Turnover:</h3>
                            <div class="fields">
                                <div class="four wide field">
                                    <label>Rebuy price</label>
                                    <asp:TextBox ID="txtEcoRebuyPrice" runat="server" meta:resourcekey="txtEcoRebuyPriceResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label>Cost pr km.</label>
                                    <asp:TextBox ID="txtEcoCostKm" runat="server" meta:resourcekey="txtEcoCostKmResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label>Turnover</label>
                                    <asp:TextBox ID="txtEcoTurnover" runat="server" meta:resourcekey="txtEcoTurnoverResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label>Progress/Drift</label>
                                    <asp:TextBox ID="txtEcoProgress" runat="server" meta:resourcekey="txtEcoProgressResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>

                 </div>
            
        </div>
                </div>
        </div>
        <div class="actions">
            <div class="ui cancel button">Lukk</div>
        </div>
    </div>

    <div id="modNewCust" class="modal hidden">
        <div class="modHeader">
            <h2 id="H1" runat="server">New Customer</h2>
            <div class="modCloseCust"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <%-- <div class="ui form">
                    <div class="field">
                        <label class="sr-only">Nytt kjøretøy</label>
                        <div class="ui small info message">
                            <p id="P1" runat="server">Velg bilstatus før du går videre</p>
                        </div>
                    </div>
                </div>--%>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form ">
                        <div class="fields">
                            <div class="wide field">
                                <asp:Label ID="Label1" Text="Søk etter kunde (Tlf, navn, sted, etc.)" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <asp:TextBox ID="txtEniro" runat="server" meta:resourcekey="txtEniroResource1" CssClass="CarsBoxes"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnEniroFetch" runat="server" class="ui mini icon input" value="Fetch" style="width: 50%" />
                            </div>
                        </div>
                        <div class="fields">
                            <div class="wide field">
                                <label id="Label3" runat="server">Customer</label>
                                <select id="CustSelect" runat="server" size="13" class="wide dropdownList">
                                </select>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--TABCUSTOMER--%>
    <div class="ui bottom attached tab segment" data-tab="fifth">
        <div id="tabCustomer">
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">

                        <div class="fields">
                            <div class="four wide field">
                            </div>
                            <div class="six wide field">
                                <label>Søk etter kunde (Tlf, navn, sted, etc.)</label>
                                <asp:TextBox ID="txtCustSearchEniro" runat="server" meta:resourcekey="txtCustSearchEniroResource1" CssClass="carsInput"></asp:TextBox>
                                <asp:Label ID="lblContactResults" runat="server" CssClass="lblContactResults" meta:resourcekey="lblContactResultsResource1"></asp:Label>
                            </div>
                            <div class="one wide field">
                                <label>EniroId</label>
                                <asp:Label ID="lblCustEniroId" runat="server" data-submit="CUST_ENIRO_ID" meta:resourcekey="lblCustEniroIdResource1"></asp:Label>
                            </div>
                            <div class="three wide field">
                                <label>&nbsp;</label>
                                <div class="ui mini icon input">
                                    <%--<asp:Button runat="server" Text="Fetch" ID="btnSearchEniro" CssClass="ui btn" />--%>
                                    <input type="button" id="btnSearchEniro" runat="server" value="Fetch" class="ui btn mini" />

                                </div>

                            </div>
</div>
                        </div>
                         </div>
                         <div class="thirteen wide column">
                            <div class="ui form">
                                <div class="CustGeneral">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Kundedetaljer</h3>
                            <label style="margin-bottom: 0.5em !important; display: block !important">
                                <asp:CheckBox ID="chkPrivOrSub" runat="server" Text="Company" data-submit="FLG_PRIVATE_COMP" meta:resourcekey="chkPrivOrSubResource1" />
                                <asp:CheckBox ID="chkProspect" runat="server" Text="Prospect" data-submit="FLG_PROSPECT" meta:resourcekey="chkProspectResource1" />
                            </label>
                            <div class="ui divider"></div>

                            <div class="fields" id="priv">
                                <%--Customer info panel--%>

                                <div class="hidden">
                                    <asp:TextBox ID="txtEniroId" runat="server" data-submit="ENIRO_ID" meta:resourcekey="txtEniroIdResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field" data-type="po">
                                    <label>
                                        <asp:Label ID="lblFirstname" Text="First name" runat="server" meta:resourcekey="lblFirstnameResource1" Style="font-weight: 900 !important"></asp:Label>
                                    </label>
                                    <asp:TextBox ID="txtCustFirstName" runat="server" data-submit="CUST_FIRST_NAME" meta:resourcekey="txtCustFirstNameResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field" data-type="po">
                                    <asp:Label ID="lblMiddlename" Text="Middle name" runat="server" meta:resourcekey="lblMiddlenameResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustMiddleName" runat="server" data-submit="CUST_MIDDLE_NAME" meta:resourcekey="txtCustMiddleNameResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <asp:Label ID="lblLastname" Text="Last name" runat="server" data-type="po" meta:resourcekey="lblLastnameResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:Label ID="lblCompany" Text="Company" runat="server" data-type="co" meta:resourcekey="lblCompanyResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustLastName" runat="server" data-submit="CUST_LAST_NAME" meta:resourcekey="txtCustLastNameResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>Customer No</label>
                                    <asp:TextBox ID="txtCustNo" runat="server" data-submit="ID_CUSTOMER" meta:resourcekey="txtCustNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>

                                <div id="ddlContactPersonContainer" class="six wide field" data-type="co">
                                    <asp:Label ID="lblContactPerson" Text="Contact person" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblContactPersonResource1"></asp:Label>
                                    <asp:DropDownList ID="ddlContactPerson" CssClass="carsInput" runat="server" data-submit="ID_CP" meta:resourcekey="ddlContactPersonResource1"></asp:DropDownList>
                                </div>


                                <div data-type="co" class="six wide field">
                                    <asp:Label ID="lblContactPersonTitle" Text="Contact title" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblContactPersonTitleResource1"></asp:Label>
                                    <asp:TextBox ID="txtContactPersonTitle" runat="server" ReadOnly="True" CssClass="carsInput" meta:resourcekey="txtContactPersonTitleResource1"></asp:TextBox>
                                </div>

                            </div>



                            <div class="fields">
                                <div class="four wide field">
                                    <asp:Label ID="lblPermAdd" Text="Visit address" runat="server" meta:resourcekey="lblPermAddResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustAdd1" runat="server" data-submit="CUST_PERM_ADD1" meta:resourcekey="txtCustAdd1Resource1" CssClass="carsInput"></asp:TextBox>
                                    <asp:TextBox ID="txtPermAdd2" runat="server" Visible="False" data-submit="CUST_PERM_ADD2" CssClass="mt3" meta:resourcekey="txtPermAdd2Resource1"></asp:TextBox>
                                </div>


                                <div class="two wide field">
                                    <asp:Label ID="lblPermZip" Text="Zipcode" runat="server" meta:resourcekey="lblPermZipResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustVisitZip" runat="server" data-submit="ID_CUST_PERM_ZIPCODE" meta:resourcekey="txtCustVisitZipResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <asp:Label ID="lblPermCity" Text="City" runat="server" meta:resourcekey="lblPermCityResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustVisitPlace" runat="server" meta:resourcekey="txtCustVisitPlaceResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <asp:Label ID="lblPermCounty" Text="County(fyl)" runat="server" meta:resourcekey="lblPermCountyResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtPermCounty" runat="server" meta:resourcekey="txtPermCountyResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <asp:Label ID="lblPermCountry" Text="Country" runat="server" meta:resourcekey="lblPermCountryResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtPermCountry" runat="server" meta:resourcekey="txtPermCountryResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>

                            <div class="fields">
                                <div class="four wide field">
                                    <asp:Label ID="lblBillAdd" Text="Postal address" runat="server" meta:resourcekey="lblBillAddResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustBillAdd" runat="server" data-submit="CUST_BILL_ADD1" meta:resourcekey="txtCustBillAddResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="two wide field">
                                    <asp:Label ID="lblBillZip" Text="Zipcode" runat="server" meta:resourcekey="lblBillZipResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustBillZip" runat="server" data-submit="ID_CUST_BILL_ZIPCODE" meta:resourcekey="txtCustBillZipResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <asp:Label ID="lblBillCity" Text="City" runat="server" meta:resourcekey="lblBillCityResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtCustBillPlace" runat="server" meta:resourcekey="txtCustBillPlaceResource1" CssClass="carsInput"></asp:TextBox>
                                </div>


                                <div class="three wide field">
                                    <asp:Label ID="lblBillCounty" Text="County(fyl)" runat="server" meta:resourcekey="lblBillCountyResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtBillCounty" runat="server" meta:resourcekey="txtBillCountyResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <asp:Label ID="lblBillCountry" Text="Country" runat="server" meta:resourcekey="lblBillCountryResource1" Style="font-weight: 900 !important"></asp:Label>
                                    <asp:TextBox ID="txtBillCountry" runat="server" meta:resourcekey="txtBillCountryResource1" CssClass="carsInput"></asp:TextBox>
                                </div>

                            </div>
                            <div class="fields">
                                <div class="three wide field">
                                    <label>Phone1</label>
                                    <asp:TextBox ID="txtCustPhone" runat="server" meta:resourcekey="txtCustPhoneResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>Phone2</label>
                                    <asp:TextBox ID="txtCustPhone2" runat="server" meta:resourcekey="txtCustPhone2Resource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="six wide field">
                                    <label>Mail</label>
                                    <asp:TextBox ID="txtCustMail" runat="server" meta:resourcekey="txtCustMailResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label>&nbsp;</label>
                                    <div class="ui mini icon input">
                                    </div>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label>Fødselsdato:</label>
                                    <asp:TextBox ID="txtCustPersonNo" runat="server" meta:resourcekey="txtCustPersonNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="eight wide field">
                                    <label>Foretaksnr:</label>
                                    <asp:TextBox ID="txtCustOrgNo" runat="server" meta:resourcekey="txtCustOrgNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>


                            <div class="fields" style="margin-top: 3rem;">


                                <div class="four wide field">
                                    <button class="ui carsButtonBlueInverted button wide" type="button" id="btnCustNotes">Notater</button>
                                </div>
                                <div class="four wide field">
                                    <button class="ui carsButtonBlueInverted button wide" type="button" id="btnMoreInfo">Se mer info</button>
                                </div>

                                
                                <div class="four wide field">
                                    <button class="ui carsButtonBlueInverted button wide" type="button" id="btnWashCustomer">Vask</button>
                                </div>

                                 <div class="four wide field">
                                    <button class="ui carsButtonBlueInverted button wide" type="button" id="btnLeasing">Leasing</button>
                                </div>
                            </div>

                        </div>
</div>
                                <div class="CustService">
                                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="H14" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Serviceavtale</h3>
                               <input type="checkbox" id="cbServiceDeal" class="inHeaderCheckbox" runat="server" style="width: 20px; height: 20px;" />
                            <div class="fields">
                                <div class="five wide field">
                                    <label>To date</label>
                                    <asp:TextBox ID="txtCustToDate" runat="server" meta:resourcekey="txtCustToDateResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label>DealNo</label>
                                    <asp:TextBox ID="txtCustDealNo" runat="server" meta:resourcekey="txtCustDealNoResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label>Period</label>
                                    <asp:TextBox ID="txtCustServicePeriod" runat="server" meta:resourcekey="txtCustServicePeriodResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="one wide field">
                                </div>
                            </div>
                            <div class="fields">
                                <div class="five wide field">
                                    <label>Price ex. Vat</label>
                                    <asp:TextBox ID="txtCustServiceNetPrice" runat="server" meta:resourcekey="txtCustServiceNetPriceResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label>Yearly milage</label>
                                    <asp:TextBox ID="txtCustServiceMileage" runat="server" meta:resourcekey="txtCustServiceMileageResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="six wide field">
                                </div>
                            </div>
                        </div>
                                </div>

<div class="CustPreviousInfo">
    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="H12" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Previous info:</h3>
                            <div class="fields">
                                <div class="six wide field">
                                    <label>Insurance company</label>
                                    <asp:TextBox ID="txtCustPrevOwner" runat="server" meta:resourcekey="txtCustPrevOwnerResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>Selger inn</label>
                                    <asp:TextBox ID="txtCustSalesmanIn" runat="server" meta:resourcekey="txtCustSalesmanInResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>Selger ut</label>
                                    <asp:TextBox ID="txtCustSalesmanOut" runat="server" meta:resourcekey="txtCustSalesmanOutResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>Mechanic</label>
                                    <asp:TextBox ID="txtCustMechanic" runat="server" meta:resourcekey="txtCustMechanicResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
        <div class="fields">
                                <div class="six wide field">
                                    <label>Debt</label>
                                    <asp:TextBox ID="txtCustDebt" runat="server" meta:resourcekey="txtCustDebtResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="ten wide field">
                                    <label>Creditor</label>
                                    <asp:TextBox ID="txtCustCreditor" runat="server" meta:resourcekey="txtCustCreditorResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="ten wide field">
                                    <label>Insurance name</label>
                                    <asp:TextBox ID="txtCustInsurance" runat="server" meta:resourcekey="txtCustInsuranceResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="six wide field">
                                </div>
                            </div>
                        </div>
</div>

<div class="CustBilXtra">
    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="H13" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">BilXtra</h3>
                            <div class="fields">
                                <div class="six wide field">
                                    <label>Grossistnr</label>
                                    <asp:TextBox ID="TextBox15" runat="server" meta:resourcekey="txtCustPrevOwnerResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>verkstednr</label>
                                    <asp:TextBox ID="TextBox17" runat="server" meta:resourcekey="txtCustSalesmanInResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>Ekst refnr</label>
                                    <asp:TextBox ID="TextBox18" runat="server" meta:resourcekey="txtCustSalesmanOutResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="three wide field">
                                    <label>Ekst kundenr</label>
                                    <asp:TextBox ID="TextBox19" runat="server" meta:resourcekey="txtCustMechanicResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                        </div>
</div>
                         
                   </div> 
                </div>
                <div class="three wide column">
                        <div class="ui form">
                            <%--<div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">--%>
                            <h3 id="H20" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Velg fra listen</h3>
                                <div class="fields">
                                <button type="button" id="btnCust1" class="ui button carsButtonBlueNotInverted wide">Generelt</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnCust2" class="ui button carsButtonBlueInverted wide">Serviceavtale</button> 
                                </div>
                                <div class="fields">
                                <button type="button" id="btnCust3" class="ui button carsButtonBlueInverted wide">Tidligere info</button> 
                                </div>
                               <div class="fields">
                                <button type="button" id="btnCust4" class="ui button carsButtonBlueInverted wide">BilXtra</button> 
                                </div>
                            <%--</div>--%>
                        </div>
                    </div>
            </div>
        </div>
    </div>

    <div class="ui small modal" id="modMobilityWarranty">
        <div class="header" style="text-align: center">Mobilitetsgaranti</div>
        <div class="content">
            <div class="ui form ">
                <div class="ui divided grid">
                <div class="eight wide column">
                <div class="grouped fields">
                    <label>Velg hvilken type mobilitetsgaranti:</label>
                    <div class="field">
                      <div class="ui radio checkbox">
                        <input type="radio" id="vikingMob" name="mobWar" disabled="disabled"/>
                        <label>Viking mobilitetgaranti</label>
                      </div>
                    </div>
                    <div class="field">
                      <div class="ui radio checkbox">
                        <input type="radio" id="bilxtraMob" name="mobWar" disabled="disabled" />
                        <label>Bilxtra mobilitetsgaranti</label>
                      </div>
                    </div>
                  </div>
                    </div>

                    
                <div class="eight wide column">
                    <div class="fields">
                        <div class="sixteen wide inline field">
                             <label>
                                <asp:Label ID="Label11" Text="Eksisterende garanti:" runat="server" meta:resourcekey="lblEditMakeDiscountResource1"></asp:Label>
                             </label>
                            <asp:Label ID="Label12" Text="Ingen" runat="server" meta:resourcekey="lblEditMakeDiscountResource1"></asp:Label>
                        </div>
                         </div>
                    <div class="fields">
                        <div class="eight wide field">
                             <label>
                                <asp:Label ID="Label9" Text="Sendt" runat="server" meta:resourcekey="lblEditMakeDiscountResource1"></asp:Label>
                             </label>
                            <asp:TextBox ID="TextBox6" runat="server" meta:resourcekey="txtGeneralNoteResource1" CssClass="carsInput"></asp:TextBox>
                        </div>
                        <div class="eight wide field">
                             <label>
                                <asp:Label ID="Label13" Text="Klokken" runat="server" meta:resourcekey="lblEditMakeDiscountResource1"></asp:Label>
                             </label>
                            <asp:TextBox ID="TextBox8" runat="server" meta:resourcekey="txtGeneralNoteResource1" CssClass="carsInput"></asp:TextBox>
                        </div>
                         </div>
                    <div class="fields">
                        <div class="eight wide field">
                             <label>
                                <asp:Label ID="Label10" Text="Gyldig til" runat="server" meta:resourcekey="lblEditMakeDiscountResource1"></asp:Label>
                             </label>
                            <asp:TextBox ID="TextBox7" runat="server" meta:resourcekey="txtGeneralNoteResource1" CssClass="carsInput"></asp:TextBox>
                        </div>
                    </div>
                    </div>
            </div>
                </div>

           

        </div>
        <div class="actions">
            <div class="ui button" id="resetRadioOptions">Tøm valg</div>
            <div class="ui approve success button">OK</div>
            <div class="ui cancel button">Avbryt</div>
        </div>
    </div>

    <div class="ui bottom attached tab segment" data-tab="sixth">
        <div id="tabHistory">
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                         <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="H21" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Historie</h3>
                             <div class="ui divider"></div>
                             <div id="history-table" class="mytabulatorclass"></div>
                         </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="ui bottom attached tab segment" data-tab="seventh">
        <div id="tabDocument">
            <div class="ui grid">
                <div class="five wide column">
              
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H2" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Dokumenter</h3>               
                        <div class="ui divider"></div>
                        <div class="fields">
                            <div class="four wide field"> <asp:FileUpload ID="uploadDocuments" class="ui file" runat="server" meta:resourcekey="uploadPictureResource1"/>
                                <asp:Button ID="btnUploadDoc" class="ui button carsButtonBlueInverted" runat="server" Text="Last opp vedlegg" OnClick="BtnUploadFile_Click" CausesValidation="False" meta:resourcekey="BtnUploadFileResource1"></asp:Button>
                                <%--<button class="ui button carsButtonBlueInverted" runat="server" id="btnUploadFile" OnClick="btnUploadFile_Click"  style="margin-top: 10px;"><i class="upload icon"></i>Last opp</button>--%>
                                  <div class="fields"> 
                                       <div class="eight wide field">
                                           <div id="documentTable"></div>
                                           </div>
                                       <div class="four wide field">
                                <ul id="docUl"></ul>
                                      </div>
                                      </div>
                            </div>                        
                            <div class="eight wide field">
                                <div id="mainDocument"></div>
                               
                            </div>  
                             
                            <div class="four wide field">
                               
                            </div>
                        </div>
                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="H24" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Dokumenter</h3>               
                        </div>
                        </div>
            </div>
        </div>
    </div>

    <div class="ui bottom attached tab segment" data-tab="eight">
        <div id="tabWeb">
            <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H16" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Web publisering</h3>
                <div class="ui grid">
                    <div class="four wide column">
                        <div class="ui form">

                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebMake" runat="server">Merke</label>
                                    <asp:TextBox ID="txtWebMake" runat="server" meta:resourcekey="txtWebMakeResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebModel" runat="server">Modell</label>
                                    <asp:TextBox ID="txtWebModel" runat="server" meta:resourcekey="txtWebModelResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebDescription" runat="server">Description</label>
                                    <asp:TextBox ID="txtWebDesc" runat="server" meta:resourcekey="txtWebDescResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebGearbox" runat="server">Girkasse</label>
                                    <asp:TextBox ID="txtWebGearBox" runat="server" meta:resourcekey="txtWebGearBoxResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebGearboxDescription" runat="server">Gir betegnelse</label>
                                    <asp:TextBox ID="txtWebGearDesc" runat="server" meta:resourcekey="txtWebGearDescResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebTraction" runat="server">Hjuldrift</label>
                                    <asp:TextBox ID="txtWebTraction" runat="server" meta:resourcekey="txtWebTractionResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebTractionDescription" runat="server">Hjulbeskrivelse</label>
                                    <asp:TextBox ID="txtWebTractionDesc" runat="server" meta:resourcekey="txtWebTractionDescResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="four wide field">
                                    <label id="lblWarehouseNo" runat="server">WH</label>
                                    <asp:TextBox ID="txtTechWarehouse" runat="server" meta:resourcekey="txtTechWarehouseResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="eight wide field">
                                    <label>&nbsp;</label>
                                    <asp:TextBox ID="txtTechWarehouseName" runat="server" meta:resourcekey="txtTechWarehouseNameResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                            <div class="five wide field">
                                    <label id="lblDateExpectedIn" runat="server">Date in</label>
                                    <asp:TextBox ID="txtTechDateExpectedIn" runat="server" meta:resourcekey="txtTechDateExpectedInResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="Label16" runat="server">Inbytte på bil</label>
                                    <asp:TextBox ID="TextBox10" runat="server" meta:resourcekey="txtTechDateExpectedInResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="Label17" runat="server">Innbyttebil</label>
                                    <asp:TextBox ID="TextBox13" runat="server" meta:resourcekey="txtTechDateExpectedInResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>

                            <div class="fields">
                            <div class="five wide field">
                                    <label>
                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Reservert kunde" meta:resourcekey="cbWebAsShownResource1" />
                                    </label>
                                </div>
                                <div class="five wide field">
                                    <label id="Label19" runat="server">Reservert</label>
                                    <asp:TextBox ID="TextBox21" runat="server" meta:resourcekey="txtTechDateExpectedInResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                   <label>
                                        <asp:CheckBox ID="CheckBox3" runat="server" Text="Betalt OK" meta:resourcekey="cbWebAsShownResource1" />
                                    </label>
                                </div>
                                </div>

                        </div>
                    </div>

                    <div class="two wide column">
                        <div class="ui form">
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebModelYear" runat="server">Årsmodell</label>
                                    <asp:TextBox ID="txtWebModelYear" runat="server" meta:resourcekey="txtWebModelYearResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebPrice" runat="server">Prisantydning</label>
                                    <asp:TextBox ID="txtWebVehiclePrice" runat="server" meta:resourcekey="txtWebVehiclePriceResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebMileage" runat="server">Kilometerstand</label>
                                    <asp:TextBox ID="txtWebMileage" runat="server" meta:resourcekey="txtWebMileageResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebFuel" runat="server">Drivstoff</label>
                                    <asp:TextBox ID="txtWebFuelType" runat="server" meta:resourcekey="txtWebFuelTypeResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebEffectBHP" runat="server">Effekt HK</label>
                                    <asp:TextBox ID="txtWebBHP" runat="server" meta:resourcekey="txtWebBHPResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebCylinderLitres" runat="server">Sylinder ltr.</label>
                                    <asp:TextBox ID="txtWebCylinderLtrs" runat="server" meta:resourcekey="txtWebCylinderLtrsResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="two wide column">
                        <div class="ui form">
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label>
                                        <asp:CheckBox ID="cbWebAsShown" runat="server" Text="As shown" meta:resourcekey="cbWebAsShownResource1" />
                                    </label>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label>
                                        <asp:CheckBox ID="cbWebInclYearlyFee" runat="server" Text="Incl. yearly fee" meta:resourcekey="cbWebInclYearlyFeeResource1" />
                                    </label>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label>
                                        <asp:CheckBox ID="cbWebinclRegFee" runat="server" Text="Incl. reg. fee" meta:resourcekey="cbWebinclRegFeeResource1" />
                                    </label>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label>
                                        <asp:CheckBox ID="cbWebInclRegCosts" runat="server" Text="Incl. Reg. costs" meta:resourcekey="cbWebInclRegCostsResource1" />
                                    </label>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    &nbsp; 
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <input type="button" id="btnEquipment" runat="server" class="ui btn wide" value="Utstyr" />
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    &nbsp;  
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <input type="button" id="btnPublish" runat="server" class="ui btn wide" value="Publiser" />
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    &nbsp;  
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label>
                                        <asp:CheckBox ID="cbWebPublish" runat="server" Text="Publish" meta:resourcekey="cbWebPublishResource1" />
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="four wide column">
                        <div class="ui form">
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebMainColor" runat="server">Hovedfarge</label>
                                    <asp:TextBox ID="txtWebMainColor" runat="server" meta:resourcekey="txtWebMainColorResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebColorDescription" runat="server">Farge beskr.</label>
                                    <asp:TextBox ID="txtWebColorDesc" runat="server" meta:resourcekey="txtWebColorDescResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebInteriorColor" runat="server">Interiør farge</label>
                                    <asp:TextBox ID="txtWebInteriorColor" runat="server" meta:resourcekey="txtWebInteriorColorResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebChassi" runat="server">Karosseri</label>
                                    <asp:TextBox ID="txtWebChassi" runat="server" meta:resourcekey="txtWebChassiResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="lblWebFirstTimeReg" runat="server">1. gang reg.</label>
                                    <asp:TextBox ID="txtWebRegDate" runat="server" meta:resourcekey="txtWebRegDateResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="eight wide field">
                                    <label id="lblWebRegno" runat="server">Regnr</label>
                                    <asp:TextBox ID="txtWebRegNo" runat="server" meta:resourcekey="txtWebRegNoResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="five wide field">
                                    <label id="lblWebDoorQty" runat="server">Antall dører</label>
                                    <asp:TextBox ID="txtWebDoorQty" runat="server" meta:resourcekey="txtWebDoorQtyResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblWebSeatQty" runat="server">Antall seter</label>
                                    <asp:TextBox ID="txtWebSeatQty" runat="server" meta:resourcekey="txtWebSeatQtyResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblWebOwnerQty" runat="server">Antall eiere</label>
                                    <asp:TextBox ID="txtWebOwnerQty" runat="server" meta:resourcekey="txtWebOwnerQtyResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="one wide field">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="four wide column">
                        <div class="ui form">
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <b id="lblWebHeaderSalesPlace" runat="server">Sales place (where the car is):</b>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebAddress" runat="server">Address</label>
                                    <asp:TextBox ID="txtWebAddress" runat="server" meta:resourcekey="txtWebAddressResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="four wide field">
                                    <label id="lblWebZipcode" runat="server">Zipcode</label>
                                    <asp:TextBox ID="txtWebZip" runat="server" meta:resourcekey="txtWebZipResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="twelve wide field">
                                    <label id="lblWebPlace" runat="server">Place</label>
                                    <asp:TextBox ID="txtWebPlace" runat="server" meta:resourcekey="txtWebPlaceResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebCountry" runat="server">Country</label>
                                    <asp:TextBox ID="txtWebCountry" runat="server" meta:resourcekey="txtWebCountryResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="ui form">
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <b id="lblWebHeaderContactPerson" runat="server">Contact person:</b>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebName" runat="server">Name</label>
                                    <asp:TextBox ID="txtWebName" runat="server" meta:resourcekey="txtWebNameResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblWebMail" runat="server">E-mail</label>
                                    <asp:TextBox ID="txtWebMail" runat="server" meta:resourcekey="txtWebMailResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="lblWebPhone1" runat="server">Phone 1</label>
                                    <asp:TextBox ID="txtWebPhone1" runat="server" meta:resourcekey="txtWebPhone1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="eight wide field">
                                    <label id="lblWebPhone2" runat="server">Phone 2</label>
                                    <asp:TextBox ID="txtWebPhone2" runat="server" meta:resourcekey="txtWebPhone2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                  <div class="ui form">
                <div class="fields">&nbsp;</div>
                    <div class="fields">
                        <div class="three wide field">
                            <button type="button" id="btnProspect" class="ui button carsButtonBlueInverted wide">Prospekt</button>
                        </div>
                        
                        <div class="three wide field">
                            <button type="button" id="btnPlakat" class="ui button carsButtonBlueInverted wide" value="Notat">Plakat</button>
                        </div>
                        <div class="three wide field">
                            <button type="button" id="btnFormidling" class="ui button carsButtonBlueInverted wide" value="Tidl. regnr">Formidling</button>
                        </div>
                    </div>
                    </div>
                
            </div>
        </div>
    </div>

    <div id="modWebEquipment" class="modal hidden">
        <div class="modHeader">
            <h2 id="lblModVehicleEquipment" runat="server">Vehicle equipment</h2>
            <div class="modCloseEquipment"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Vehicle equipment</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="two wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Multimedia:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <label>
                                <asp:CheckBox ID="cbEqCdPlayer" runat="server" Text="CD-Player" meta:resourcekey="cbEqCdPlayerResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqRadio" runat="server" Text="Radio" meta:resourcekey="cbEqRadioResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSpeakers" runat="server" Text="Speakers" meta:resourcekey="cbEqSpeakersResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqBandPlayer" runat="server" Text="Kasett spiller" meta:resourcekey="cbEqBandPlayerResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqCDChanger" runat="server" Text="CD changer" meta:resourcekey="cbEqCDChangerResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqMP3player" runat="server" Text="MP3-player" meta:resourcekey="cbEqMP3playerResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSubwoofer" runat="server" Text="Subwoofer" meta:resourcekey="cbEqSubwooferResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqDVDVideo" runat="server" Text="DVD-Video" meta:resourcekey="cbEqDVDVideoResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqDVDAudio" runat="server" Text="DVD-Audio" meta:resourcekey="cbEqDVDAudioResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqScreen" runat="server" Text="Screen" meta:resourcekey="cbEqScreenResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSacdPlayer" runat="server" Text="SACD-Player" meta:resourcekey="cbEqSacdPlayerResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqNavigation" runat="server" Text="Navigation" meta:resourcekey="cbEqNavigationResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqRemoteControl" runat="server" Text="Remote Control" meta:resourcekey="cbEqRemoteControlResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSteeringControl" runat="server" Text="Steering control" meta:resourcekey="cbEqSteeringControlResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqPhone" runat="server" Text="Phone" meta:resourcekey="cbEqPhoneResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqTV" runat="server" Text="TV" meta:resourcekey="cbEqTVResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqDrivingCpu" runat="server" Text="Driving computer" meta:resourcekey="cbEqDrivingCpuResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqOutputAUX" runat="server" Text="Output to AUX" meta:resourcekey="cbEqOutputAUXResource1" />
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqMMadd1" runat="server" meta:resourcekey="txtEqMMadd1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqMMAdd2" runat="server" meta:resourcekey="txtEqMMAdd2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="four wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Comfort:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="eight wide field">
                            <label>
                                <asp:CheckBox ID="cbEqCentralLock" runat="server" Text="Central lock" meta:resourcekey="cbEqCentralLockResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqAirCondition" runat="server" Text="Aircondition" meta:resourcekey="cbEqAirConditionResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElClimate" runat="server" Text="El.Climat" meta:resourcekey="cbEqElClimateResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqEngineVarmer" runat="server" Text="Engine varmer" meta:resourcekey="cbEqEngineVarmerResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqCupeVarm" runat="server" Text="Cupe varmer" meta:resourcekey="cbEqCupeVarmResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqAutomaticGear" runat="server" Text="Automatic gear" meta:resourcekey="cbEqAutomaticGearResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqHandlingControl" runat="server" Text="Handling Control" meta:resourcekey="cbEqHandlingControlResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElJustableMirror" runat="server" Text="El. justable mirrors" meta:resourcekey="cbEqElJustableMirrorResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElClosingMirrors" runat="server" Text="El. closing mirrors" meta:resourcekey="cbEqElClosingMirrorsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElVarmingMirrors" runat="server" Text="El. varming mirrors" meta:resourcekey="cbEqElVarmingMirrorsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqHatch" runat="server" Text="Hatch/Takluke" meta:resourcekey="cbEqHatchResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElCab" runat="server" Text="El. Cabriolet" meta:resourcekey="cbEqElCabResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqCruiseControl" runat="server" Text="Cruise control" meta:resourcekey="cbEqCruiseControlResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqRainSensor" runat="server" Text="Rain sensor" meta:resourcekey="cbEqRainSensorResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqMultiFunctionSteering" runat="server" Text="Multi function steeringwheel" meta:resourcekey="cbEqMultiFunctionSteeringResource1" />
                            </label>
                        </div>
                        <div class="eight wide field">
                            <label>
                                <asp:CheckBox ID="cbEqElWindows" runat="server" Text="El. windows" meta:resourcekey="cbEqElWindowsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElJustSeats" runat="server" Text="El. justable seats" meta:resourcekey="cbEqElJustSeatsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElCurtain" runat="server" Text="Electrical curtain" meta:resourcekey="cbEqElCurtainResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElAntenna" runat="server" Text="El. Antenna" meta:resourcekey="cbEqElAntennaResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqAirVentilatedChairs" runat="server" Text="Air ventilated seats" meta:resourcekey="cbEqAirVentilatedChairsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqHeightJustableSeats" runat="server" Text="Height justable seats" meta:resourcekey="cbEqHeightJustableSeatsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqJustableSteering" runat="server" Text="Adjustable Steering" meta:resourcekey="cbEqJustableSteeringResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqColoredGlass" runat="server" Text="Colored glass" meta:resourcekey="cbEqColoredGlassResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqArmLean" runat="server" Text="Arm lean middle" meta:resourcekey="cbEqArmLeanResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqAirSuspension" runat="server" Text="Air suspension" meta:resourcekey="cbEqAirSuspensionResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSunCurtain" runat="server" Text="Sun curtain" meta:resourcekey="cbEqSunCurtainResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqVarmSoothingFront" runat="server" Text="Varm soothing front" meta:resourcekey="cbEqVarmSoothingFrontResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqVarmingSeats" runat="server" Text="Varming seats" meta:resourcekey="cbEqVarmingSeatsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqMemorySeats" runat="server" Text="Memory in seats" meta:resourcekey="cbEqMemorySeatsResource1" />
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqCoAdd1" runat="server" meta:resourcekey="txtEqCoAdd1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqCoAdd2" runat="server" meta:resourcekey="txtEqCoAdd2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>

                        </div>
                    </div>
                </div>
            </div>

            <div class="four wide column">
                <div class="ui form">

                    <div class="fields">
                        <div class="eight wide field">
                            <div class="fields">
                                <label>
                                    <h3>Safety:</h3>
                                </label>
                            </div>
                            <label>
                                <asp:CheckBox ID="cbEqABSBrakes" runat="server" Text="ABS brakes" meta:resourcekey="cbEqABSBrakesResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqAirBag" runat="server" Text="Air bag" meta:resourcekey="cbEqAirBagResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqXenonLight" runat="server" Text="Xenon light" meta:resourcekey="cbEqXenonLightResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqAntiSpin" runat="server" Text="Anti spin" meta:resourcekey="cbEqAntiSpinResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqESP" runat="server" Text="ESP" meta:resourcekey="cbEqESPResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqDimCenterMirror" runat="server" Text="Dim center mirror" meta:resourcekey="cbEqDimCenterMirrorResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqHandsfree" runat="server" Text="Handsfree mobile" meta:resourcekey="cbEqHandsfreeResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqParkingSystem" runat="server" Text="Parking system" meta:resourcekey="cbEqParkingSystemResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqElVarmingFrontWindow" runat="server" Text="El. varming front window" meta:resourcekey="cbEqElVarmingFrontWindowResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEq4WD" runat="server" Text="4WD" meta:resourcekey="cbEq4WDResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqDiffBrake" runat="server" Text="Differential brakes" meta:resourcekey="cbEqDiffBrakeResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqLevelRegulator" runat="server" Text="Level regulator" meta:resourcekey="cbEqLevelRegulatorResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqLightWasher" runat="server" Text="Frontlight washer" meta:resourcekey="cbEqLightWasherResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqDirectionsInMirrors" runat="server" Text="Directions in side mirrors" meta:resourcekey="cbEqDirectionsInMirrorsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqExtraLights" runat="server" Text="Extra lights" meta:resourcekey="cbEqExtraLightsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqAlarm" runat="server" Text="Alarm" meta:resourcekey="cbEqAlarmResource1" />
                            </label>

                        </div>
                        <div class="eight wide field">
                            <label>
                                <asp:CheckBox ID="cbEqKeylessGo" runat="server" Text="Keyless Go" meta:resourcekey="cbEqKeylessGoResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqStartBlock" runat="server" Text="Start block" meta:resourcekey="cbEqStartBlockResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqParkSensor" runat="server" Text="Park sensor" meta:resourcekey="cbEqParkSensorResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqBackingCamera" runat="server" Text="Backing camera" meta:resourcekey="cbEqBackingCameraResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqIntegratedChildSeats" runat="server" Text="Integrated child seats" meta:resourcekey="cbEqIntegratedChildSeatsResource1" />
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqSaAdd1" runat="server" meta:resourcekey="txtEqSaAdd1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqSaAdd2" runat="server" meta:resourcekey="txtEqSaAdd2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                            <div class="fields">
                                <label>
                                    <h3>Sport:</h3>
                                </label>
                            </div>
                            <label>
                                <asp:CheckBox ID="cbEqSportSteeringwheel" runat="server" Text="Sports steeringwheel" meta:resourcekey="cbEqSportSteeringwheelResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqLoweredChassi" runat="server" Text="Lowered chassi" meta:resourcekey="cbEqLoweredChassiResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSportsSeats" runat="server" Text="Sports seats" meta:resourcekey="cbEqSportsSeatsResource1" />
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqSpAdd1" runat="server" meta:resourcekey="txtEqSpAdd1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqSpAdd2" runat="server" meta:resourcekey="txtEqSpAdd2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="four wide column">
                <div class="ui form">
                    <div class="fields">
                        <div class="eight wide field">
                            <div class="fields">
                                <label>
                                    <h3>Utseende:</h3>
                                </label>
                            </div>
                            <label>
                                <asp:CheckBox ID="cbEqAluminiumRims" runat="server" Text="Aluminium rims" meta:resourcekey="cbEqAluminiumRimsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqRails" runat="server" Text="Rails" meta:resourcekey="cbEqRailsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqLeather" runat="server" Text="Leather" meta:resourcekey="cbEqLeatherResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqWoodenInterior" runat="server" Text="Wooden interior" meta:resourcekey="cbEqWoodenInteriorResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqMirrors" runat="server" Text="Mirrors" meta:resourcekey="cbEqMirrorsResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqBumpers" runat="server" Text="Bumpers" meta:resourcekey="cbEqBumpersResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSpoilerBack" runat="server" Text="Rear Spoiler" meta:resourcekey="cbEqSpoilerBackResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqPartLeather" runat="server" Text="Partially leather" meta:resourcekey="cbEqPartLeatherResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqMetalicPaint" runat="server" Text="Metalic paint" meta:resourcekey="cbEqMetalicPaintResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqDarkSideScreens" runat="server" Text="Dark side screens" meta:resourcekey="cbEqDarkSideScreensResource1" />
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqLoAdd1" runat="server" meta:resourcekey="txtEqLoAdd1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqLoAdd2" runat="server" meta:resourcekey="txtEqLoAdd2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                        </div>
                        <div class="eight wide field">
                            <div class="fields">
                                <label>
                                    <h3 id="lblOthers" runat="server">Others:</h3>
                                </label>
                            </div>
                            <label>
                                <asp:CheckBox ID="cbEqTowbar" runat="server" Text="Tilhengerfeste" meta:resourcekey="cbEqTowbarResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSkiBag" runat="server" Text="Ski bag" meta:resourcekey="cbEqSkiBagResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqSkiBox" runat="server" Text="Ski box" meta:resourcekey="cbEqSkiBoxResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEqLoadroomMat" runat="server" Text="Load room mat" meta:resourcekey="cbEqLoadroomMatResource1" />
                            </label>
                            <label>
                                <asp:CheckBox ID="cbEq12V" runat="server" Text="12V" meta:resourcekey="cbEq12VResource1" />
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqOtAdd1" runat="server" meta:resourcekey="txtEqOtAdd1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                            <label>
                                <asp:TextBox ID="txtEqOtAdd2" runat="server" meta:resourcekey="txtEqOtAdd2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                            </label>
                        </div>
                    </div>
                </div>
                <input type="button" id="btnSaveEquipment" runat="server" class="ui btn" value="Save" />
            </div>
        </div>
        &nbsp;
    </div>

    <div class="ui large modal" id="modProspect">
        <div class="ui blue top medium header center aligned" style="text-align: center;">Prospekt</div>
        <div class="content">
            <div class="ui grid">
                <div class="eight wide column">
                    <div class="ui form">

                        <h3 class="ui top attached tiny header" id="lblProsProspect" runat="server">Prospect:</h3>
                        <div class="ui attached segment">
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblProsTitle" runat="server">Title</label>
                                    <asp:TextBox runat="server" ID="txtProsTitle" TextMode="MultiLine" Height="15px" meta:resourcekey="txtProsTitleResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblProsDescription" runat="server">Description</label>
                                    <asp:TextBox runat="server" ID="txtProsDesc" TextMode="MultiLine" Height="30px" meta:resourcekey="txtProsDescResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="twelve wide field">
                                    <label id="lblProsVideoUrl" runat="server">Video URL</label>
                                    <asp:TextBox runat="server" ID="txtProsVideoUrl" Text="Https://" meta:resourcekey="txtProsVideoUrlResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    &nbsp;
                                            <label>
                                                <asp:CheckBox runat="server" ID="cbProsShowOnMonitor" Text="Show on monitor" meta:resourcekey="cbProsShowOnMonitorResource1"></asp:CheckBox></label>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="twelve wide field">
                                    <label id="lblProsTopLogoPath" runat="server">Top logo path</label>
                                    <asp:TextBox runat="server" ID="txtProsTopLogoPath" Text="Https://" meta:resourcekey="txtProsTopLogoPathResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    &nbsp;
                                             <input type="button" runat="server" id="btnProsFindTopLogo" class="ui btn wide" value="Find target" />
                                </div>
                            </div>
                            <div class="fields">
                                <div class="twelve wide field">
                                    <label id="lblProsBottomLogoPath" runat="server">Bottom logo path</label>
                                    <asp:TextBox runat="server" ID="txtProsBottomLogoPath" Text="Https://" meta:resourcekey="txtProsBottomLogoPathResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    &nbsp;
                                             <input type="button" runat="server" id="btnProsBottomLogoPath" class="ui btn wide" value="Find target" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--Other half of the tabProspect page which is blank--%>
                <div class="six wide column">
                    <div class="ui form">
                        <h3 id="H3" class="ui top attached tiny header" runat="server">Vehicle dates and mileage:</h3>
                        <div class="ui attached segment">
                            <div class="fields">
                                <div class="sixteen wide field">
                                    <a href="../Images/LINCOLN1.jpg" target="_blank">
                                        <img src="../Images/LINCOLN1.jpg" width="80%" alt="Image of vehicle" /></a>
                                </div>

                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <a href="../Images/LINCOLN2.jpg" target="_blank">
                                        <img src="../Images/LINCOLN1.jpg" width="80%" alt="Image of vehicle" /></a>
                                </div>
                                <div class="eight wide field">
                                    &nbsp;
                                </div>
                            </div>

                        </div>



                    </div>
                </div>
            </div>
    </div>
    <div class="actions">
        <div class="ui approve success button">OK</div>
        <div class="ui cancel button">Avbryt</div>
    </div>
    
</div>

    <div class="ui bottom attached tab segment" data-tab="twelvfth">
        <div id="tabTrailer">
            <div class="ui grid">
                <div class="ten wide column">
                    <div class="ui form">
                          <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="lblTrailerChassi" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Trailer chassi:</h3>
                            <div class="fields">
                                <div class="four wide field">
                                    <label id="lblTrailerAxle1" runat="server">Axle 1</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle1" meta:resourcekey="txtTraAxle1Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblTrailerAxle2" runat="server">Axle 2</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle2" meta:resourcekey="txtTraAxle2Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblTrailerAxle3" runat="server">Axle 3</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle3" meta:resourcekey="txtTraAxle3Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblTrailerAxle4" runat="server">Axle 4</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle4" meta:resourcekey="txtTraAxle4Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="four wide field">
                                    <label id="lblTrailerAxle5" runat="server">Axle 5</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle5" meta:resourcekey="txtTraAxle5Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblTrailerAxle6" runat="server">Axle 6</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle6" meta:resourcekey="txtTraAxle6Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblTrailerAxle7" runat="server">Axle 7</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle7" meta:resourcekey="txtTraAxle7Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="lblTrailerAxle8" runat="server">Axle 8</label>
                                    <asp:TextBox runat="server" ID="txtTraAxle8" meta:resourcekey="txtTraAxle8Resource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
                <div class="six wide column">
                    <div class="ui form">
                          <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H15" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Beskrivelse:</h3>
                           <div class="fields">
                                <div class="sixteen wide field">
                                    <label id="lblTrailerDescription" runat="server">Description</label>
                                    <asp:TextBox runat="server" ID="txtTraDesc" TextMode="MultiLine" Height="65px" meta:resourcekey="txtTraDescResource1" CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--<div class="ui bottom attached tab segment" data-tab="thirteenth">
        <div id="tabCertificate">
            <div class="ui grid">
                <div class="sixteen wide column">
                    
                   
                </div>

            </div>



        </div>
    </div>--%>
        <div class="ui small modal" id="modCertificateAnnot">
        <div class="ui blue top medium header center aligned" style="text-align: center;">Merknader</div>
        <div class="content">
            <div class="ui form ">
                <div class="ui divided grid">
                <div class="sixteen wide column">
               
                            <div class="inline fields">
                                <div class="three wide field">
                                    <label>
                                        <asp:Literal ID="liCertChassi" runat="server" Text="Frame/Chassis" meta:resourcekey="liCertChassiResource1"></asp:Literal>
                                    </label>
                                    </div>
                                <div class="fourteen wide field">
                                    <asp:TextBox runat="server" ID="txtCertChassi" meta:resourcekey="txtCertChassiResource1" CssClass="carsInput"></asp:TextBox>
                               </div>
                                </div>
                    <div class="inline fields">
                                 <div class="three wide field">
                                    <label>
                                        <asp:Literal ID="liCertCertificate" runat="server" Text="Certificate" meta:resourcekey="liCertCertificateResource1"></asp:Literal>
                                    </label>
                                     </div>
                         <div class="fourteen wide field">
                                    <asp:TextBox runat="server" ID="txtCertCertificate" meta:resourcekey="txtCertCertificateResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inline fields">
                                 <div class="three wide field">
                                    <label>
                                        <asp:Literal ID="liCertIdentity" runat="server" Text="Identity" meta:resourcekey="liCertIdentityResource1"></asp:Literal>
                                    </label>
                                     </div>
                                 <div class="fourteen wide field">
                                    <asp:TextBox runat="server" ID="txtCertIdentity" meta:resourcekey="txtCertIdentityResource1" CssClass="carsInput"></asp:TextBox>
                                     </div>
                                </div>
                                <div class="inline fields">
                                     <div class="three wide field">
                                    <label>
                                        <asp:Literal ID="liCertNote" runat="server" Text="Notes" meta:resourcekey="liCertNoteResource1"></asp:Literal>
                                    </label>
                                         </div>
                                     <div class="fourteen wide field">
                                    <asp:TextBox runat="server" ID="txtCertNotes" meta:resourcekey="txtCertNotesResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                    </div>
                            </div>
  
            </div>
                </div>

        </div>
        <div class="actions">
            <div class="ui cancel button">Lukk</div>
        </div>
    </div>

    <div class="ui small modal" id="modCertificateTrailer">
        <div class="ui blue top medium header center aligned" style="text-align: center;">Tilhenger etc.</div>
        <div class="content">
            <div class="ui form ">
                <div class="ui divided grid">
                <div class="eight wide column">
                    
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertTrailerWeightWBrakes" runat="server">Trailer weight w/brakes</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertTrailerWeightBrakes" meta:resourcekey="txtCertTrailerWeightBrakesResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                    <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertTrailerWeight" runat="server">Trailer weight</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertTrailerWeight" meta:resourcekey="txtCertTrailerWeightResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                   
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertMaxWeightTowbar" runat="server">Max weight towbar</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertWeightTowbar" meta:resourcekey="txtCertWeightTowbarResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                    <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertLengthToTowbar" runat="server">Length to towbar</label>
                                     </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertLengthTowbar" meta:resourcekey="txtCertLengthTowbarResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertTotTrailerWeight" runat="server">Total Trailer weight</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertTotalTrailerWeight" meta:resourcekey="txtCertTotalTrailerWeightResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                                <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertNumberOfSeats" runat="server">No. of seats</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertSeats" meta:resourcekey="txtCertSeatsResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                    </div>
                         <div class="eight wide column">   
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertValidFrom" runat="server">Valid from</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertValidFrom" meta:resourcekey="txtCertValidFromResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                             <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertEuVersion" runat="server">EU version</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertEuVersion" meta:resourcekey="txtCertEuVersionResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertEuVariant" runat="server">EU variant</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertEuVariant" meta:resourcekey="txtCertEuVariantResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                             <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertEuronorm" runat="server">Euronorm</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertEuronorm" meta:resourcekey="txtCertEuronormResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                            <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertCO2Emission" runat="server">CO2 emission</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertCo2Emission" meta:resourcekey="txtCertCo2EmissionResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                </div>
                             <div class="inline fields">
                                <div class="eight wide field">
                                    <label id="lblCertMakeParticleFilter" runat="server">Make particle filter</label>
                                    </div>
                                <div class="eight wide field">
                                    <asp:TextBox runat="server" ID="txtCertMakeParticleFilter" meta:resourcekey="txtCertMakeParticleFilterResource1" CssClass="carsInput"></asp:TextBox>
                                </div>
                                
                            </div>


                 </div>
            
        </div>
                </div>
        </div>
        <div class="actions">
            <div class="ui cancel button">Lukk</div>
        </div>
    </div>






    <div class="ui bottom attached tab segment" data-tab="fourteenth">
        <div id="tabForm">
            <div class="ui grid">
                <div class="two wide column"></div>
                <div class="twelve wide column">
                    <div class="ui form">
                        <div class="fields">
                            <table class="ui celled structured table" style="height: 80%;">
                                <thead style="text-align:center">
                                    <tr>
                                        <th colspan="2">BilXtra - Gratis Xtrasjekk</th>
                                        <th style="background-color: #ff6666; width:120px;">Bør utbedres</th>
                                        <th style="background-color: #FFFF55; width:120px;">Under oppsyn</th>
                                        <th style="background-color: #00CC00; width:120px;">OK</th>
                                        <th style="width:120px;">Anm.</th>
                                        <th style="width:120px;">SMS</th>
                                    </tr>
                                </thead>
                                <tbody style="text-align:center">
                                    <tr>
                                        <td>Motorolje</td>
                                        <td>Nivå</td>
                                        <td id="engineOilBad">
                                            <i class="XtraCheck engineOil" id="engineOilBadBox"></i>
                                        </td>
                                        <td id="engineOilOK">
                                           <i class="XtraCheck engineOil" id="engineOilOKBox"></i>
                                        </td>
                                        <td id="engineOilGood">
                                            <i class="XtraCheck engineOil" id="engineOilGoodBox"></i>
                                        </td>
                                        <td id="engineOilAnnot">
                                            <i class="XtraCheck engineOil"  id="engineOilAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="engineOilSMS">
                                            <i class="XtraCheck engineOil" id="engineOilSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">Frostvæske</td>
                                        <td>Nivå</td>
                                        <td id="cFLevelBad">
                                            <i class="XtraCheck cFLevel" id="cFLevelBadBox"></i>
                                        </td>
                                        <td id="cFLevelOK">
                                            <i class="XtraCheck cFLevel" id="cFLevelOKBox"></i>
                                        </td>
                                        <td id="cFLevelGood">
                                            <i class="XtraCheck cFLevel" id="cFLevelGoodBox"></i>
                                        </td>
                                        <td id="cFLevelAnnot">
                                            <i class="XtraCheck cFLevel" id="cFLevelAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="cFlevelSMS">
                                            <i class="XtraCheck cFLevel" id="cFLEVELSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Frysepunkt</td>
                                        <td id="cFTempBad">
                                            <i class="XtraCheck cFTemp" id="cFTempBadBox"></i>
                                        </td>
                                        <td id="cFTempOK">
                                            <i class="XtraCheck cFTemp" id="cFTempOKBox"></i>
                                        </td>
                                        <td id="cFTempGood">
                                            <i class="XtraCheck cFTemp" id="cFTempGoodBox"></i>
                                        </td>
                                        <td id="cfTempAnnot">
                                            <i class="XtraCheck cFTemp" id="cfTempAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="cFtempSMS">
                                            <i class="XtraCheck cFTemp" id="cFTempSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Bremsevæske</td>
                                        <td>Nivå</td>
                                        <td id="brakeFluidBad">
                                            <i class="XtraCheck brakeFluid"  id="brakeFluidBadBox"></i>
                                        </td>
                                        <td id="brakeFluidOK">
                                            <i class="XtraCheck brakeFluid" id="brakeFluidOKBox"></i>
                                        </td>
                                        <td id="brakeFluidGood">
                                            <i class="XtraCheck brakeFluid" id="brakeFluidGoodBox"></i>
                                        </td>
                                        <td id="brakeFluidAnnot">
                                            <i class="XtraCheck brakeFluid" id="brakeFluidAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="brakeFluidSMS">
                                            <i class="XtraCheck brakeFluid" id="brakeFluidSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Batteri</td>
                                        <td>Nivå</td>
                                        <td id="batteryBad">
                                            <i class="XtraCheck battery" id="batteryBadBox"></i>
                                        </td>
                                        <td id="batteryOK">
                                            <i class="XtraCheck battery" id="batteryOKBox"></i>
                                        </td>
                                        <td id="batteryGood">
                                            <i class="XtraCheck battery" id="batteryGoodBox"></i>
                                        </td>
                                        <td id="batteryAnnot">
                                            <i class="XtraCheck battery" id="batteryAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="batterySMS">
                                            <i class="XtraCheck battery" id="batterySMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">Vindusvisker</td>
                                        <td>Foran</td>
                                        <td id="vipesFrontBad">
                                            <i class="XtraCheck vipesFront" id="vipesFrontBadBox"></i>
                                        </td>
                                        <td id="vipesFrontOK">
                                            <i class="XtraCheck vipesFront" id="vipesFrontOKBox"></i>
                                        </td>
                                        <td id="vipesFrontGood">
                                            <i class="XtraCheck vipesFront" id="vipesFrontGoodBox"></i>
                                        </td>
                                        <td id="vipesFrontAnnot">
                                            <i class="XtraCheck vipesFront" id="vipesFrontAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="vipesFrontSMS">
                                            <i class="XtraCheck vipesFront" id="vipesFrontSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Bak</td>
                                        <td id="vipesBackBad">
                                            <i class="XtraCheck vipesBack" id="vipesBackBadBox"></i>
                                        </td>
                                        <td id="vipesBackOK">
                                            <i class="XtraCheck vipesBack" id="vipesBackOKBox"></i>
                                        </td>
                                        <td id="vipesBackGood">
                                            <i class="XtraCheck vipesBack" id="vipesBackGoodBox"></i>
                                        </td>
                                        <td id="vipesBackAnnot">
                                            <i  class="XtraCheck vipesBack" id="vipesBackAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="vipesBackSMS">
                                            <i class="XtraCheck vipesBack" id="vipesBackSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">Lyspærer</td>
                                        <td>Foran</td>
                                        <td id="lightsFrontBad">
                                            <i class="XtraCheck lightsFront" id="lightsFrontBadBox"></i>
                                        </td>
                                        <td id="lightsFrontOK">
                                            <i class="XtraCheck lightsFront" id="lightsFrontOKBox"></i>
                                        </td>
                                        <td id="lightsFrontGood">
                                            <i class="XtraCheck lightsFront" id="lightsFrontGoodBox"></i>
                                        </td>
                                        <td id="lightsFrontAnnot">
                                            <i class="XtraCheck lightsFront" id="lightsFrontAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="lightsFrontSMS">
                                            <i class="XtraCheck lightsFront" id="lightsFrontSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Bak</td>
                                        <td id="lightsBackBad">
                                            <i class="XtraCheck lightsBack" id="lightsBackBadBox"></i>
                                        </td>
                                        <td id="lightsBackOK">
                                            <i class="XtraCheck lightsBack" id="lightsBackOKBox"></i>
                                        </td>
                                        <td id="lightsBackGood">
                                            <i class="XtraCheck lightsBack" id="lightsBackGoodBox"></i>
                                        </td>
                                        <td id="lightsBackAnnot">
                                            <i class="XtraCheck lightsBack" id="lightsBackAnnotIcon"></i>
                                        </td>
                                       <td class="SMSXTRACHECK" id="lightsBackSMS">
                                            <i class="XtraCheck lightsBack" id="lightsBackSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">Støtdempere</td>
                                        <td>Foran</td>
                                        <td id="bumperFrontBad">
                                            <i class="XtraCheck bumperFront" id="bumperFrontBadBox"></i>
                                        </td>
                                        <td id="bumperFrontOK">
                                            <i  class="XtraCheck bumperFront" id="bumperFrontOKBox"></i>
                                        </td>
                                        <td id="bumperFrontGood">
                                            <i class="XtraCheck bumperFront" id="bumperFrontGoodBox"></i>
                                        </td>
                                        <td id="bumperFrontAnnot">
                                            <i class="XtraCheck bumperFront" id="bumperFrontAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="bumperFrontSMS">
                                            <i class="XtraCheck bumperFront" id="bumperFrontSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Bak</td>
                                        <td id="bumperBackBad">
                                            <i class="XtraCheck bumperBack" id="bumperBackBadBox"></i>
                                        </td>
                                        <td id="bumperBackOK">
                                            <i class="XtraCheck bumperBack" id="bumperBackOKBox"></i>
                                        </td>
                                        <td id="bumperBackGood">
                                            <i class="XtraCheck bumperBack" id="bumperBackGoodBox"></i>
                                        </td>
                                        <td id="bumperBackAnnot">
                                            <i class="XtraCheck bumperBack" id="bumperBackAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="bumperBackSMS">
                                            <i class="XtraCheck bumperBack" id="bumperBackSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">Dekk</td>
                                        <td>Foran</td>
                                        <td id="tiresFrontBad">
                                            <i  class="XtraCheck tiresFront" id="tiresFrontBadBox"></i>
                                        </td>
                                        <td id="tiresFrontOK">
                                            <i class="XtraCheck tiresFront" id="tiresFrontOKBox"></i>
                                        </td>
                                        <td id="tiresFrontGood">
                                            <i class="XtraCheck tiresFront" id="tiresFrontGoodBox"></i>
                                        </td>
                                        <td id="tiresFrontAnnot">
                                            <i class="XtraCheck tiresFront" id="tiresFrontAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="tiresFrontSMS">
                                            <i class="XtraCheck tiresFront" id="tiresFrontSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Bak</td>
                                        <td id="tiresBackBad">
                                            <i class="XtraCheck tiresBack" id="tiresBackBadBox"></i>
                                        </td>
                                        <td id="tiresBackOK">
                                            <i class="XtraCheck tiresBack" id="tiresBackOKBox"></i>
                                        </td>
                                        <td id="tiresBackGood">
                                            <i class="XtraCheck tiresBack" id="tiresBackGoodBox"></i>
                                        </td>
                                        <td id="tiresBackAnnot">
                                            <i class="XtraCheck tiresBack" id="tiresBackAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="tiresBackSMS">
                                            <i class="XtraCheck tiresBack" id="tiresBackSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Forstilling</td>
                                        <td></td>
                                        <td id="suspensionFrontBad">
                                            <i class="XtraCheck suspensionFront" id="suspensionFrontBadBox"></i>
                                        </td>
                                        <td id="suspensionFrontOK">
                                            <i class="XtraCheck suspensionFront" id="suspensionFrontOKBox"></i>
                                        </td>
                                        <td id="suspensionFrontGood">
                                            <i class="XtraCheck suspensionFront" id="suspensionFrontGoodBox"></i>
                                        </td>
                                        <td id="suspensionFrontAnnot">
                                            <i class="XtraCheck suspensionFront" id="suspensionFrontAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="suspensionFrontSMS">
                                            <i class="XtraCheck suspensionFront" id="suspensionFrontSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Bakstilling</td>
                                        <td></td>
                                        <td id="suspensionBackBad">
                                            <i class="XtraCheck suspensionBack" id="suspensionBackBadBox"></i>
                                        </td>
                                        <td id="suspensionBackOK">
                                            <i class="XtraCheck suspensionBack" id="suspensionBackOKBox"></i>
                                        </td>
                                        <td id="suspensionBackGood">
                                            <i class="XtraCheck suspensionBack" id="suspensionBackGoodBox"></i>
                                        </td>
                                        <td id="suspensionBackAnnot">
                                            <i class="XtraCheck suspensionBack" id="suspensionBackAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="suspensionBackSMS">
                                            <i class="XtraCheck suspensionBack" id="suspensionBackSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">Bremser</td>
                                        <td>Klosser foran</td>
                                        <td id="brakesFrontBad">
                                            <i class="XtraCheck brakesFront" id="brakesFrontBadBox"></i>
                                        </td>
                                        <td id="brakesFrontOK">
                                            <i class="XtraCheck brakesFront" id="brakesFrontOKBox"></i>
                                        </td>
                                        <td id="brakesFrontGood">
                                            <i class="XtraCheck brakesFront" id="brakesFrontGoodBox"></i>
                                        </td>
                                        <td id="brakesFrontAnnot">
                                            <i class="XtraCheck brakesFront" id="brakesFrontAnnotIcon"></i>
                                        </td>
                                       <td class="SMSXTRACHECK" id="brakesFrontSMS">
                                            <i class="XtraCheck brakesFront" id="brakesFrontSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Klosser bak</td>
                                        <td id="brakesBackBad">
                                            <i class="XtraCheck brakesBack" id="brakesBackBadBox"></i>
                                        </td>
                                        <td id="brakesBackOK">
                                            <i class="XtraCheck brakesBack" id="brakesBackOKBox"></i>
                                        </td>
                                        <td id="brakesBackGood">
                                            <i class="XtraCheck brakesBack" id="brakesBackGoodBox"></i>
                                        </td>
                                        <td id="brakesBackAnnot">
                                            <i class="XtraCheck brakesBack" id="brakesBackAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="brakesBackSMS">
                                            <i class="XtraCheck brakesBack" id="brakesBackSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Eksosanlegg</td>
                                        <td></td>
                                        <td id="exhaustBad">
                                            <i "XtraCheck exhaust id="exhaustBadBox"></i>
                                        </td>
                                        <td id="exhaustOK">
                                            <i "XtraCheck exhaust id="exhaustOKBox"></i>
                                        </td>
                                        <td id="exhaustGood">
                                            <i "XtraCheck exhaust id="exhaustGoodBox"></i>
                                        </td>
                                        <td id="exhaustAnnot">
                                            <i "XtraCheck exhaust id="exhaustAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="exhaustSMS">
                                            <i "XtraCheck exhaust id="exhaustSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">Tetthet</td>
                                        <td>Motor</td>
                                        <td id="sealedEngineBad">
                                            <i id="sealedEngineBadBox"></i>
                                        </td>
                                        <td id="sealedEngineOK">
                                            <i id="sealedEngineOKBox"></i>
                                        </td>
                                        <td id="sealedEngineGood">
                                            <i id="sealedEngineGoodBox"></i>
                                        </td>
                                        <td id="sealedEngineAnnot">
                                            <i id="sealedEngineAnnotIcon"></i>
                                        </td>
                                        <td class="SMSXTRACHECK" id="sealedEngineSMS">
                                            <i id="sealedEngineSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Girkasse</td>
                                        <td id="sealedGearboxBad">
                                            <i id="sealedGearboxBadBox"></i>
                                        </td>
                                        <td id="sealedGearboxOK">
                                            <i id="sealedGearboxOKBox"></i>
                                        </td>
                                        <td id="sealedGearboxGood">
                                            <i id="sealedGearboxGoodBox"></i>
                                        </td>
                                        <td id="sealedGearboxAnnot">
                                            <i id="sealedGearboxAnnotIcon"></i>
                                        </td>
                                       <td class="SMSXTRACHECK" id="sealedGearboxSMS">
                                            <i id="sealedGearboxSMSBox"></i>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7">
                                            <label>Beskrivelse</label>
                                             <textarea id="generalAnnotation" class="CarsBoxes" style="height:100px;width:100%"></textarea>
                                            <%--<asp:TextBox runat="server" ID="generalAnnotation" TextMode="MultiLine" Rows="4" meta:resourcekey="txtFormDescriptionResource1" CssClass="CarsBoxes"></asp:TextBox>--%>
                                        </td>
                                    </tr>
                                    
                                </tbody>



                            </table>

                        </div>
                    </div>
                </div>
                <div class="two wide column"></div>
            </div>
        </div>
    </div>
    <div id="tabBottom">
        <div class="ui form">
            <div class="inline fields">
                <div class="four wide field"></div>
                <div class="two wide field">
                    <div id="btnEmptyScreen" class="ui button wide negative">Tøm</div>
                </div>
                <div class="two wide field">
                    <div id="btnPrintVehicle" class="ui button wide">Skriv ut</div>
                </div>
                <div class="two wide field">
                    <div id="btnNewVehicle" class="ui button wide blue">Nytt kjøretøy</div>
                </div>
                <div class="two wide field">
                    <div id="btnSaveVehicle" class="ui button wide positive">Lagre</div>
                </div>
                <div class="four wide field"></div>
            </div>
        </div>
    </div>

    <%-- POP UP BOXES FOR ANNOTATION ON THE BILXTRA fORM TAB  --%>
    <div id="modEngineOil" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Engine Oil</h2>
            <div class="modCloseEngineOil"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Engine Oil</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormEngineOilAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormEngineOilAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveEngineOilAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modcFLevel" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on cold fluid level</h2>
            <div class="modClosecFLevel"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on cold fluid level</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormcFLevelAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormcFLevelAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSavecFLevelAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modcfTemp" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on cold fluid temperature</h2>
            <div class="modClosecfTemp"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on cold fluid temperature</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormcfTempAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormcfTempAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSavecfTempAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modbrakeFluid" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on brake fluid level</h2>
            <div class="modCloseBrakeFluid"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on brake fluid level</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormBrakeFluidAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormBrakeFluidAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveBrakeFluidAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modBattery" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on battery</h2>
            <div class="modCloseBattery"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on battery</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormBatteryAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormBatteryAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveBatteryAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modVipesFront" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on vipes front</h2>
            <div class="modCloseVipesFront"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on vipes front</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormVipesFrontAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormVipesFrontAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveVipesFrontAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modVipesBack" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on vipes back</h2>
            <div class="modCloseVipesBack"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on vipes back</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormVipesBackAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormVipesBackAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveVipesBackAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modLightsFront" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on lights front</h2>
            <div class="modCloseLightsFront"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on lights front</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormLightsFrontAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormLightsFrontAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveLightsFrontAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modLightsBack" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on lights back</h2>
            <div class="modCloseLightsBack"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on lights back</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormLightsBackAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormLightsBackAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveLightsBackAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modBumperFront" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on lights front</h2>
            <div class="modCloseBumperFront"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Bumper front</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormBumperFrontAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormBumperFrontAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveBumperFrontAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modBumperBack" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Bumper back</h2>
            <div class="modCloseBumperBack"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Bumper back</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormBumperBackAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormBumperBackAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveBumperBackAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modTiresFront" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Tires front</h2>
            <div class="modCloseTiresFront"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Tires front</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormTiresFrontAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormTiresFrontAnnotResource1" CssClass="CarsBoxes"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveTiresFrontAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modTiresBack" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Tires back</h2>
            <div class="modCloseTiresBack"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Tires back</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormTiresBackAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormTiresBackAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveTiresBackAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modSuspensionFront" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Suspension front</h2>
            <div class="modCloseSuspensionFront"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Suspension front</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormSuspensionFrontAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormSuspensionFrontAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveSuspensionFrontAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modSuspensionBack" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Suspension back</h2>
            <div class="modCloseSuspensionBack"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Suspension back</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormSuspensionBackAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormSuspensionBackAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveSuspensionBackAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modBrakesFront" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Brakes front</h2>
            <div class="modCloseBrakesFront"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Brakes front</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormBrakesFrontAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormBrakesFrontAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveBrakesFrontAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modBrakesBack" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Brakes back</h2>
            <div class="modCloseBrakesBack"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Brakes back</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormBrakesBackAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormBrakesBackAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveBrakesBackAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modExhaust" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Exhaust</h2>
            <div class="modCloseExhaust"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Exhaust</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormExhaustAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormExhaustAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveExhaustAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modSealedEngine" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Sealed Engine</h2>
            <div class="modCloseSealedEngine"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Sealed Engine</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormSealedEngineAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormSealedEngineAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveSealedEngineAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modSealedGearbox" class="modal hidden">
        <div class="modHeader">
            <h2>Annotation on Sealed Gearbox</h2>
            <div class="modCloseSealedGearbox"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Annotation on Sealed Gearbox</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Note:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:TextBox ID="txtFormSealedGearboxAnnot" TextMode="MultiLine" runat="server" meta:resourcekey="txtFormSealedGearboxAnnotResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <input type="button" class="ui btn" id="btnSaveSealedGearboxAnnot" value="Lagre" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            &nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- END OF POP UP BOXES FOR ANNOTATION ON THE BILXTRA fORM TAB  --%>

    <div class="fullscreen ui modal" id="modal_po_steps">
        <a class="ui red ribbon label" id="redRibbonPOmodal"></a>
        <i class="close icon"></i>
        <div class="header">
           
        </div>


        <div class="content">
          
            <div class="modal_po_divstep1">
                    
                    <div class="ui header">Fakturalinjer</div>
                    <div class="fields">
                        <div class="six wide field">
                            <div class="ui blue horizontal label">Ordrenummer</div>
                            <a class="detail" id="pomodal_details_ponumber"></a>

                            <div class="ui blue horizontal label" style="margin-left: 2em">fakturanummer</div>
                            <a class="detail" id="pomodal_details_supplier"></a>
                        </div>

                    </div>
                    <div class="fields">
                        <div class="six wide field">
                            <div class="ui small right labeled input" style="margin-top: 2em" id="txtbxSparepartModalparent">
                            <label for="amount" class="ui label" id="lblSparepartModalAddNewItem">+</label>
                             <input type="text" placeholder="Søk vare" id="txtbxSparepartModal" />     
                                
                            </div>                                                    

                        </div>                                      

                        </div>


                    <div id="history-detail-table" class="mytabulatorclass"></div>



                </div>

        

        </div>
        <div class="actions">
       

            <div class="ui positive right labeled icon button" id="po_modal_next">
                <div>Lukk</div> 
                 
                <i class="chevron right icon"></i>
            </div>



        </div>
    </div>

    <div id="modPrintVehicle" class="modal hidden">
        <div class="modHeader">
            <h2>Utskriftsalternativer</h2>
            <div class="modClosePrint"><i class="remove icon"></i></div>
        </div>
        <div class="ui form">
            <div class="field">
                <label class="sr-only">Utskriftsalternativer</label>
            </div>
        </div>
        <div class="ui grid">
            <div class="one wide column"></div>
            <div class="six wide column">
                <div class="ui form">
                    <div class="fields">
                        <label>
                            <h3>Rapporttype:</h3>
                        </label>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <asp:RadioButtonList ID="rblVehicleReportList" runat="server" meta:resourcekey="rblVehicleReportListResource1">
                                <asp:ListItem Selected="True" Text="Car information" Value="0" meta:resourcekey="ListItemResource1" />
                                <asp:ListItem Text="Vehicle prospect" Value="1" meta:resourcekey="ListItemResource2" />
                                <asp:ListItem Text="Vehicle poster" Value="2" meta:resourcekey="ListItemResource3" />
                                <asp:ListItem Text="Vehicle sales prospect" Value="3" meta:resourcekey="ListItemResource4" />
                                <asp:ListItem Text="Used car warranty" Value="4" meta:resourcekey="ListItemResource5" />
                                <asp:ListItem Text="Complete vehicle history" Value="5" meta:resourcekey="ListItemResource6" />
                                <asp:ListItem Text="Vehicle key tag" Value="6" meta:resourcekey="ListItemResource7" />
                                <asp:ListItem Text="Vehicle history with sales" Value="7" meta:resourcekey="ListItemResource8" />
                                <asp:ListItem Text="Vehicle history without sales" Value="8" meta:resourcekey="ListItemResource9" />
                                <asp:ListItem Text="Vehicle Certificate" Value="9" meta:resourcekey="ListItemResource10" />
                                <asp:ListItem Text="BilXtra - Xtrasjekk" Value="10" meta:resourcekey="ListItemResource11" />
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>
            </div>

            <div class="sixteen wide column">
                <div class="ui form">
                    <div class="fields">
                        <div class="one wide field">
                        </div>
                        <div class="fourteen wide field">
                            <input type="button" id="btnStartPrint" class="ui btn" value="Skriv ut" />
                        </div>
                        <div class="one wide field">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        &nbsp;
    </div>

    <script type="text/javascript">
        let dropArea = document.getElementById('drop-area')

        //dropArea.addEventListener('dragenter', handlerFunction, false)
        //dropArea.addEventListener('dragleave', handlerFunction, false)
        //dropArea.addEventListener('dragover', handlerFunction, false)
        //dropArea.addEventListener('drop', handlerFunction, false)
        dropArea.addEventListener('drop', handleDrop, false)

            ;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                dropArea.addEventListener(eventName, preventDefaults, false)
            })

            ;['dragenter', 'dragover'].forEach(eventName => {
                dropArea.addEventListener(eventName, highlight, false)
            })

            ;['dragleave', 'drop'].forEach(eventName => {
                dropArea.addEventListener(eventName, unhighlight, false)
            })

        function highlight(e) {
            dropArea.classList.add('highlight')
        }

        function unhighlight(e) {
            dropArea.classList.remove('highlight')
        }

      
        function handleDrop(e) {
            let dt = e.dataTransfer
            let files = dt.files
            fileElem.files = e.dataTransfer.files
            alert("filelement!!!!!: " + document.getElementById('fileElem').value);
            handleFiles(files)
        }
        function handleFiles(files) {
            alert("HandleFiles viser: " + files);            
            ([...files]).forEach(uploadFile)
        }
        function uploadFile(file) {     
            var formdata = new FormData();
            formdata.append('filep', file)

                var objArr = [];
                objArr.push({
                    "filename": $("#fileElem").val(),
                    "regno" : $('#<%=txtRegNo.ClientID%>').val()
                });
            
             var datpJson = JSON.stringify(objArr);
            //alert(datpJson);

            
            //alert("Du har dratt og sluppen en fil over riktig område! ");
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmVehicleDetail.aspx/UploadData",
                //data: datpJson,
                data: "{formdata:'" + datpJson + "'}",
                dataType: "json",                
                success: function (data) {

                  
                },
                error: function (xhr, status, error) {
                   
                }
            });
        }

        $('#fileElem').on('change', function () {
            alert("Det ligger en verdi i dragNdrop: " + $(this).text());
        });
       

        function preventDefaults(e) {
            e.preventDefault()
            e.stopPropagation()
        }

       
      
    </script>
</asp:Content>
