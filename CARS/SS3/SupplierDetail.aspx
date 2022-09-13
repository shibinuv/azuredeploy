<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SupplierDetail.aspx.vb" Inherits="CARS.SupplierDetail" MasterPageFile="~/MasterPage.Master" meta:resourcekey="PageResource2" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">


<style type="text/css">

   
    @import url('https://fonts.googleapis.com/css?family=Open+Sans:600');

    .ui.inverted.green.button:hover {
        background-color: #22be34 !important;
    }
    .ui.inverted.primary.button:hover{
        background-color: #54C8FF !important;
    }
    .ui.inverted.red.button:hover{
        background-color: #FF695E !important;
    }
    

    .mytabulatorclass {
        border-radius: 0px;
        border-top: 0px;
    }

    .ui.tabular.menu  {
        border-bottom: 2px solid #2185D0;
        
    }

    .ui.tabular.menu .item {
        font-weight: bold;
        
    }
    .ui.tabular.menu .active.item { 
        color: #ffffff;
        background-color: #2185D0;
        font-weight: bold;

    }
   .ui.tabular.menu .item:hover
    {
       background-color: rgba(33, 150, 243, 0.22);
    }
   .ui.tabular.menu .active.item:hover
    {
       background-color: #2185D0;
    }

   .ui.list .list > .item .header, .ui.list > .item .header {
        font-family: 'Open Sans', sans-serif;
   }

   .ui.selection.list .list > .item, .ui.selection.list > .item:hover {
       
   }

   body {
     
    /*background: linear-gradient(90deg, rgba(127,127,213,0.2) 0%, rgba(116, 162, 249, 0.25) 33%, rgba(234, 145, 145, 0.11) 100%);*/
    /*background: linear-gradient(90deg, rgba(127,127,213,0.2) 0%, rgba(116, 162, 249, 0.25) 33%, rgba(189, 203, 220, 0.2) 100%);*/
   }
   /*#drop-area {
  border: 2px dashed #ccc;
  border-radius: 20px;
  width: 300px;
  height:200px;
  font-family: sans-serif;
  margin: 10px auto;
  padding: 20px;
}
#drop-area.highlight {
  border-color: purple;
}*/
 .customSpace{
     width:10px;
 }
 .radioButtonGroup {
  border-radius: 7px;
  border: 2px solid ;
  padding: 20px;
}
 .customComboBox {
        height: 10% !important;
        border-color: #dbdbdb;
        border-radius: 6px;
    }
 .dropZoneExternal > div,
.dropZoneExternal > img
{
    position: absolute;
}
.dropZoneExternal
{
    position: relative;
    border: 1px dashed skyblue !important;
    cursor: pointer;
    border-radius:5px;
}
.dropZoneExternal,
.dragZoneText
{
    width: 100%;
    max-width: 300px;
    min-width: 286px;
    height: 300px;
}
#dragZone
{
    width: 100%;
    display: table;
}
#uploadedImage
{
    width: 100%;
}
.dropZoneText
{
    width: 300px;
    height: 150px;
    color: #fff;
    background-color: #888;
}
#dropZone
{
    top: 0;
    padding: 100px 25px;
}
.uploadControlDropZone,
.hidden
{
    display: none;
}
.dropZoneText,
.dragZoneText
{
    display: table-cell;
    vertical-align: middle;
    text-align: center;
    font-size: 20pt;
}
.dragZoneText
{
    color: #808080;
}
.dxucInlineDropZoneSys span
{
    color: blue!important;
    font-size: 10pt;
    font-weight: normal!important;
}
.validationMessage
{
    padding: 0 20px;
    text-align: center;
}
.uploadContainer
{
    width: 100%;
    max-width: 350px;
    min-width: 286px;
    margin-top: 10px;
}
.Note
{
    max-width: 500px;
}
    </style>

   <script type="text/javascript">

       var custvar = {};
       var contvar = {};
       var genInvalid = "";
       var genValueGreater = "";
       var genEntVal = "";
       var allowImport = false;
       $(document).ready(function ()

       {
           var debug = true;
           var mode = 'add';
           loadInit();
           function loadInit()
           {
               getDiscountCodes();
               //$('.PriceCalculation').hide();
               $('.ImportPriceFile').hide();
               // Added this code to Show PriceCalculation div on load
               $('.PriceCalculation').show();
               //$("#btnStartCalculation").attr('disabled', true);
               $('#<%=btnStartCalculation.ClientID%>').attr("disabled", "disabled");
               $('#<%=btnImport.ClientID%>').attr("disabled", "disabled");

               $('#btnGen1').addClass('carsButtonBlueInverted');
               $('#btnGen1').removeClass('carsButtonBlueNotInverted');
               $('#btnGen2').removeClass('carsButtonBlueInverted');
               $('#btnGen2').addClass('carsButtonBlueNotInverted');
           }
           // START GEN MOD SCRIPTS
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
           $(document).bind('keydown', function (e) { // BIND ESCAPE TO CLOSE
               if (e.which == 27) {
                   overlay('off', '');
               }
           });
           $(".modClose").on('click', function (e) {
               overlay('off', '');
           });

           $('.menu .item')
               .tab()
               ;

           function collectGroupData(dataTag)
           {
               dataCollection = {};
               $('[data-' + dataTag + ']').each(function (index, elem) {
                   var st = $(elem).data(dataTag);
                   var dv = '';
                   var elemType = $(elem).prop('nodeName');
                   switch (elemType) {
                       case 'INPUT':
                           dv = $(elem).val();
                           break;
                       case 'TEXTAREA':
                           dv = $(elem).val();
                           break;
                       case 'SELECT':
                           dv = $(elem).val();
                           break;
                       case 'LABEL':
                           dv = $(elem).html();
                           break;
                       case 'SPAN':
                           if ($(elem).children('input').is(':checked')) {
                               dv = '1';
                           } else {
                               dv = '0';
                           }
                           break;
                       default:
                           dv = '01';
                   }
                   if (debug) {
                       console.log(index + ' Added ' + dataTag + ': ' + st + ' with value: ' + dv + ' and type: ' + elemType);
                   }
                   dataCollection[st] = $.trim(dv);
               });
               return dataCollection;
           }
           var ajaxConfig = {
               type: "POST", //set request type to Position
               contentType: 'application/json; charset=utf-8', //set specific content type
           };
          
           // END GEN MOD SCRIPTS
           //function setTab(cTab)
           //{
           //    var tabID = "";
           //    tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
           //    var tab;
           //    (tabID == "") ? tab = cTab : tab = tabID;
             
           //    $('.tTab').addClass('hidden'); // Hides all tabs
           //    $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
           //    $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
           //    $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
           //}

           //$('.cTab').on('click', function (e) {
               
           //    setTab($(this));
           //});

            /* ------------------------------------------------------------------
                       SUPPLIER SEARCH FUNCTIONS
                        -------------------------------------------------------------------*/
            
           $('#txtSupplierSearch').autocomplete({


                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "SupplierDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#txtSupplierSearch').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#txtSupplierSearch').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager', value: " ", val: 'new' }]);
                                
                            } else
                                response($.map(data.d, function (item) {
                                    
                                    return {
                                        label: item.SUPP_CURRENTNO + " - " + item.SUP_Name + " - " + item.SUP_CITY + " - " + item.ID_SUPPLIER,
                                        val: item.SUPP_CURRENTNO,
                                        name: item.SUP_Name,
                                        value: item.ITEM_DESC
                                       
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
                    e.preventDefault()
                    
                    
                    if (i.item.val != 'new')
                    {
                        $('#txtSupplierSearch').val(i.item.name)
                        $('#suppnameparagraph').text(i.item.name);
                        FetchSupplierDetails(i.item.val);
                        
                        getOrdertypes($('#txtSupplierId').val());
                        $("#discount-table").tabulator("setData", "SupplierDetail.aspx/getDiscountData", { 'SUPP_CURRENTNO': i.item.val, 'ID_ORDERTYPE': "" });
                    
                        $('#txtbxDiscountPercentage').prop("disabled", false);

                    }
                    else
                    {
                        $('#aspnetForm')[0].reset();
                        $('#<%=txtSupplierName.ClientID%>').focus();
                        
                    }
                                      
                }
            });

           function FetchSupplierDetails(ID_SUPPLIER) {
                cpChange = '';
                $.ajax({
                    type: "POST",
                    url: "SupplierDetail.aspx/FetchSupplierDetail",
                    data: "{ID_SUPPLIER: '" + ID_SUPPLIER + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        console.log(data.d[0]);
                        $('#txtSupplierId').val(data.d[0].SUPP_CURRENTNO);
                        //Newly added Code .
                        hdnSuppCurNo.SetText(data.d[0].SUPP_CURRENTNO);
                        hdnSupplierID.SetText(data.d[0].ID_SUPPLIER);
                        
                        //$("#btnStartCalculation").prop('disabled', false);
                        //document.getElementById("btnStartCalculation").disabled = true;
                        //$('#btnStartCalculation').removeAttr('disabled');

                        if (data.d[0].SUPP_CURRENTNO != "" && data.d[0].SUPP_CURRENTNO != null) {
                            $('#<%=btnStartCalculation.ClientID%>').attr("disabled", false);
                            $('#<%=btnImport.ClientID%>').attr("disabled", false);
                            if (rbCalculateGlobal.GetChecked()) {
                                cbCategoryLoad.PerformCallback("GLOBAL");
                                cbDiscountCode.PerformCallback("GLOBAL");
                                Reset();
                            }
                            cbSparePartGroup.PerformCallback();
                        }
                        $('#<%=txtSupplierName.ClientID%>').val(data.d[0].SUP_Name);
                        $('#<%=txtPermAdd1.ClientID%>').val(data.d[0].SUP_Address1);
                        $('#<%=txtPermZip.ClientID%>').val(data.d[0].SUP_Zipcode);
                        $('#<%=txtPermCity.ClientID%>').val(data.d[0].SUP_CITY);
                        $('#<%=txtPermCounty.ClientID%>').val(data.d[0].SUP_REGION);
                        $('#<%=txtPermCountry.ClientID%>').val(data.d[0].SUP_COUNTRY);
                        $('#<%=txtSupplierMail.ClientID%>').val(data.d[0].SUP_ID_Email);
                        $('#<%=txtSupplierPhone.ClientID%>').val(data.d[0].SUP_Phone_Off);
                        $('#<%=txtAdvSupplierId.ClientID%>').val(data.d[0].ID_SUPPLIER);
                        $('#<%=txtSupplierContactPerson.ClientID%>').val(data.d[0].SUP_Contact_Name);
                        $('#<%=lblSupplierDateCreated.ClientID%>').html(data.d[0].DT_CREATED + " by " + data.d[0].CREATED_BY);
                        $('#<%=txtBillAdd1.ClientID%>').val(data.d[0].SUP_BILLAddress1);
                        $('#<%=txtBillZip.ClientID%>').val(data.d[0].SUP_BILLZipcode);
                        $('#<%=txtBillCity.ClientID%>').val(data.d[0].SUP_BILL_CITY);
                        $('#<%=txtBillCountry.ClientID%>').val(data.d[0].SUP_BILL_COUNTRY);
                        if (data.d[0].FLG_SAME_ADDRESS === 'True') {
                            $("#<%=chkSameAdd.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=chkSameAdd.ClientID%>").prop('checked', false);
                        }
                        $('#<%=txtSupplierWebPage.ClientID%>').val(data.d[0].SUP_WEBPAGE);

                        if (data.d[0].CURRENCY_CODE != '') {
                            FetchCurrencyDetails(data.d[0].CURRENCY_CODE);
                        }

                        $('#<%=txtAdvCurrencyId.ClientID%>').val(data.d[0].CURRENCY_CODE);
                                                         
                        $('#<%=txtSupplierStockId.ClientID%>').val(data.d[0].SUPPLIER_STOCK_ID);
                        $('#<%=txtDealerNo.ClientID%>').val(data.d[0].DEALER_NO_SPARE);
                        $('#<%=txtFreightLimit.ClientID%>').val(data.d[0].FREIGHT_LIMIT);
                        $('#<%=txtFreightPerAbove.ClientID%>').val(data.d[0].FREIGHT_PERC_ABOVE);
                        $('#<%=txtFreightPerBelow.ClientID%>').val(data.d[0].FREIGHT_PERC_BELOW);
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                
           };
           
        

           function saveSupplier()
           {
               
               var sup = collectGroupData('submit');
               
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "SupplierDetail.aspx/InsertSupplier",                   
                    data: "{Supplier:'" + JSON.stringify(sup) + "'}",
                    dataType: "json",
                    //async: false,//Very important
                    success: function (data)
                    {
                        $('.loading').removeClass('loading');
                        
                        if (data.d[0] == "INSFLG")
                        {
                            //if we have a parentwindow in background that needs input values to be set
                            if (window.parent != undefined && window.parent != null && window.parent.length > 0)
                            {                                                     
                                saveInputBackToParentWindow(data.d[1]);                            
                                window.parent.$('.ui-dialog-content:visible').dialog('close');
                            }
                            else
                            {    
                                $('#txtSupplierId').val(data.d[1]);
                            }
                            systemMSG('success', 'The spare part has been saved!', 4000);
                            
                        }
                        else if (data.d[0] == "UPDFLG")
                        {
                            //if we have a parentwindow in background that needs input values to be set
                            if (window.parent != undefined && window.parent != null && window.parent.length > 0) {
                                saveInputBackToParentWindow(data.d[1]);
                                window.parent.$('.ui-dialog-content:visible').dialog('close');
                            }
                            
                            systemMSG('success', 'Spare Part post has been updated!', 4000);                           
                            
                        }
                        else if (data.d[0] == "ERRFLG")
                        {
                            systemMSG('error', 'An error occured while trying to save the spare part, please check input data.', 4000);
                        }
                        
                    },
                    error: function (xhr, ajaxOptions, thrownError)
                    {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
           }

           function saveInputBackToParentWindow(supplierId)
           {
               console.log("suppid is " + supplierId);
               if (window.parent.document.getElementById('ctl00_cntMainPanel_txtInfoSupplier') != null && window.parent.document.getElementById('ctl00_cntMainPanel_txtInfoSupplierName') != null) {
                   window.parent.document.getElementById('ctl00_cntMainPanel_txtInfoSupplier').value = supplierId;
                   window.parent.document.getElementById('ctl00_cntMainPanel_txtInfoSupplierName').value = $('#<%=txtSupplierName.ClientID%>').val();
               }
           }

           $('#ID_SUPPLIER_WRAPPER').on('click', function () {
                if ($('#txtSupplierId').prop('disabled') && $('#txtSupplierId').val().length == 0) {
                    console.log('read only true');
                    $('#modSupplierLock').modal('setting', {
                        onDeny: function () {
                            $('#txtSupplierSearch').focus();
                        },
                        onApprove: function () {
                            $('#txtSupplierId').removeAttr('disabled').removeAttr('readonly').focus();
                            console.log('Enabled the #ID_SUPPLIER field');
                        },
                        onShow: function () {
                            $(this).children('ui.button.ok.positive').focus();
                        }
                    }).modal('show');
                }
           });

           $('#txtSupplierId').on('blur', function () {
              
                $.ajax({
                    type: "POST",
                    url: "SupplierDetail.aspx/FetchSupplierDetail",
                    data: "{ID_SUPPLIER: '" + $('#txtSupplierId').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        console.log(data.d[0]);
                        if (data.d[0] == null) {
                            console.log('OK');
                        } else {
                            console.log('Error');
                            $('#mseMSG').html('Nummer er allerede i bruk på ' + data.d[0].SUP_Name + ', vil du åpne leverandør for redigering eller vil du prøve et annet nummer?')
                            $('#modSupplierExists').modal('setting', {
                                onDeny: function () {
                                   $('#txtSupplierId').val('');
                                    $('#txtSupplierId').focus();
                                },
                                onApprove: function () {
                                    FetchSupplierDetails($('#txtSupplierId').val());
                                }
                            }).modal('show');
                        }
                    }
                });
               
           });

           //autocomplete for listing of the currency
          
            $('#<%=txtAdvCurrencyId.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "SupplierDetail.aspx/Currency_Search",
                        data: "{q:'" + $('#<%=txtAdvCurrencyId.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#<%=txtAdvCurrencyId.ClientID%>').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i leveradør register. Opprette ny?', value: '0', val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    
                                    return {
                                        label: item.ID_CURRENCY + " - " + item.CURRENCY_CODE + " - " + item.CURRENCY_DESCRIPTION,
                                        val: item.CURRENCY_CODE,
                                        value: item.CURRENCY_CODE,
                                        currencyName: item.CURRENCY_DESCRIPTION,
                                        currencyRate: item.CURRENCY_RATE
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
                    //window.location.replace("../master/frmCustomerDetail.aspx?cust=" + i.item.ID_ITEM);
                    $('#<%=txtAdvCurrencyId.ClientID%>').val(i.item.val);
                    //$('#<%=lblAdvCurrencyDesc.ClientID%>').html(i.item.currencyName + " - Rate: " + i.item.currencyRate);
                    //$('#<%=txtAdvCurrencyId.ClientID%>').focus();
                    FetchCurrencyDetails($('#<%=txtAdvCurrencyId.ClientID%>').val());
                }
           });

           function getOrdertypes(suppcurrentno, id) {
                $.ajax({
                    type: "POST",
                    url: "PurchaseOrder.aspx/getOrdertypes",
                    data: "{suppcurrentno: '" + suppcurrentno + "', 'id': '" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                     
                        if (id) {
                            //we get a specific ordertype
                            
                            $('#ddlNewOrdertypePricetype').val(data.d[0].PRICETYPE);
                            $('#txtbxNewOrdertypeOrdertype').val(data.d[0].SUPP_ORDERTYPE);
                            $('#txtbxNewOrdertypeDescription').val(data.d[0].SUPP_ORDERTYPE_DESC);
                        }
                        else
                        {
                    
                            $('#ddlOrdertypesModal').empty();                            
                            $('#dropdown_modal_ordertype').find('option').not(':first').remove();
                            $.each(data.d, function (key, value) {                            
                                $('#ddlOrdertypesModal').append($("<option></option>").val(value.SUPP_ORDERTYPE).html(value.SUPP_ORDERTYPE));
                                $('#dropdown_modal_ordertype').append($("<option></option>").val(value.SUPP_ORDERTYPE).html(value.SUPP_ORDERTYPE));

                            });
                        }
                       

                },
                    failure: function () {
                        alert("Failed!");
                    }
                });
        }


           function getDiscountCodes(id) {
                $.ajax({
                    type: "POST",
                    url: "SupplierDetail.aspx/getDiscountCodes",
                    data: "{'id': '" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {

                        if (id || id == "") {
                            //we get a specific ordertype
                            $('#txtbxNewDiscountCode').val(data.d[0].DISCOUNTCODE);
                            $('#txtbxNewDiscountCodeDescription').val(data.d[0].DISCOUNTCODE_TEXT);
                            $('#txtSearchText').val(data.d[0].DISCOUNTCODE_TEXT);
                        }
                        else
                        {   
                            $('#dropdown_modal_discountcode').find('option').not(':first').remove();
                            $('#ddlDiscountCodesModal').empty();
                            $('#dropdown_discountcode').empty();
                            $.each(data.d, function (key, value) {                            
                                $('#ddlDiscountCodesModal').append($("<option></option>").val(value.DISCOUNTCODE).html(value.DISCOUNTCODE));
                             
                                $('#dropdown_discountcode').append($("<option></option>").val(value.DISCOUNTCODE).html(value.DISCOUNTCODE));
                            });

                        }
                       

                },
                    failure: function () {
                        alert("Failed!");
                    }
                });
           }


           $('#ddlDiscountCodesModal').change(function () {
                if (this.value != '*') {
                    var discountcode = this.value;
                    getDiscountCodes(discountcode);
                }
                else {
                    $('#txtbxNewDiscountCode').val('');
                    $('#txtbxNewDiscountCodeDescription').val('');
                  
                }
                
           });
      
         

           

           $('#btnDiscountCodeNew').on('click', function () {

               var alreadyStar = false;
               $("#ddlDiscountCodesModal option").each(function (i) {
                   if ($(this).val() == '*') {
                       alreadyStar = true;
                       
                   }
               });
             
                
               if (!alreadyStar) {
                   $('#ddlDiscountCodesModal').append($("<option></option>").val("*").html("*"));
               }
               $('#ddlDiscountCodesModal option:eq("*")').prop('selected', true)
               $('option[value="*"]').prop("selected", true);
               $('#txtbxNewDiscountCode').val('');
               $('#txtbxNewDiscountCodeDescription').val('');
                
                
           });

           $('#btnOrdertypeNew').on('click', function () {

               var alreadyStar = false;
               $("#ddlOrdertypesModal option").each(function (i) {
                   if ($(this).val() == '*') {
                       alreadyStar = true;

                   }
               });


               if (!alreadyStar) {
                   $('#ddlOrdertypesModal').append($("<option></option>").val("*").html("*"));
               }
               $('#ddlOrdertypesModal option:eq("*")').prop('selected', true)
               $('option[value="*"]').prop("selected", true);
               $('#txtbxNewOrdertypeOrdertype').val('');
               $('#txtbxNewOrdertypeDescription').val('');


           });

           $("body").on('keydown', '#txtbxDiscountPercentage', function (e) {
               var keyCode = e.keyCode || e.which;
              
               if (keyCode == 9) {  //hit tab
                   var id_ordertype = $('#dropdown_modal_ordertype').dropdown('get value');
                   if (id_ordertype == null || id_ordertype == "0") {
                       id_ordertype = "";
                   }
                   var discountcode = $('#dropdown_discountcode').find(":selected").text();
                   var suppcurrentno = $('#txtSupplierId').val();
                   var discountpercentage = $('#txtbxDiscountPercentage').val();

                   saveDiscount(discountcode, id_ordertype, suppcurrentno, discountpercentage);
                   
               }
           });

           $('#btnDiscountCodeSave').on('click', function () {

               var alreadyCode = false;
               var newCode = ($('#txtbxNewDiscountCode').val()).trim()
               newCode = newCode.toLowerCase();
               $("#ddlDiscountCodesModal option").each(function (i) {
                   if ((($(this).val()).trim()).toLowerCase() == newCode) {
                       alreadyCode = true;
              
                       
                   }
               });
               if (alreadyCode) {
                   systemMSG('error', 'Kan ikke lagre, da denne rabattkoden allerede finnes i systemet', 5000);

               }
               else {
                   saveDiscountCode(($('#txtbxNewDiscountCode').val()).trim(), $('#txtbxNewDiscountCodeDescription').val());
               }
           });

           $('#btnDiscountCodeDelete').on('click', function () {
               if ($('#txtbxNewDiscountCode').val() != "") {
                   $.ajax({
                       type: "POST",
                       url: "SupplierDetail.aspx/deleteDiscountCode",

                       data: "{discountcode:'" + $('#txtbxNewDiscountCode').val() + "',supplier:'" + $('#txtSupplierId').val() + "'}",
                       contentType: "application/json; charset=utf-8",
                       dataType: "json",
                       async: false,
                       success: function (data) {
                           //console.log(data.d);
                           if (data.d == "0") {
                               systemMSG('success', 'Rabattkode slettet.', 5000);
                               getDiscountCodes();
                           }
                           else {
                               systemMSG('error', 'Kan ikke slette rabattkode, da denne er i bruk!', 5000);
                           }
                           //$("#discount-table").tabulator("setData", "SupplierDetail.aspx/getDiscountData", {'SUPP_CURRENTNO': $('#txtSupplierId').val(), 'ID_ORDERTYPE': ordertype });

                       },
                       failure: function () {
                           alert("Failed!");
                       }
                   });
               }
               else {
                   swal("Velg en rabattkode før du prøver å slette.");
               }
               
           });
         
           $('#dropdown_modal_discountcode').dropdown();

           $('#btnOrdertypeSave').on('click', function () {

               var alreadyCode = false;
               var newCode = ($('#txtbxNewOrdertypeOrdertype').val()).trim()
               newCode = newCode.toLowerCase();
               $("#ddlOrdertypesModal option").each(function (i) {
                   if ((($(this).val()).trim()).toLowerCase() == newCode) {
                       alreadyCode = true;


                   }
               });
               if (alreadyCode) {
                   systemMSG('error', 'Kan ikke lagre, da denne ordretypen for allerede finnes i systemet', 5000);

               }
               else {
                       saveOrderType(($('#txtbxNewOrdertypeOrdertype').val()).trim(), $('#txtbxNewOrdertypeDescription').val(), $("#ddlNewOrdertypePricetype option:selected").text(), $('#txtbxNewOrdertypeSupplier').val());
                }
           });

           //$('#ddlOrdertypesModal').dropdown();

           function saveDiscountCode(discountcode, description)
           {
               $.ajax({
                    type: "POST",
                    url: "SupplierDetail.aspx/saveDiscountCode",
                         
                    data: "{discountcode:'" + discountcode + "',description:'" + description + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //console.log(data.d);
                      
                       systemMSG('success', 'Ny rabattkode lagret', 5000);
                       getDiscountCodes();
                       
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
           }

           function saveOrderType(ordertype, description, pricetype, supplier) {
               $.ajax({
                   type: "POST",
                   url: "SupplierDetail.aspx/saveOrderType",

                   data: "{ordertype:'" + ordertype + "',description:'" + description + "',pricetype:'" + pricetype + "',supplier:'" + supplier + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,
                   success: function (data) {
                       //console.log(data.d);

                       systemMSG('success', 'Ny ordretype lagret', 5000);
                       getOrdertypes(supplier);

                   },
                   failure: function () {
                       alert("Failed!");
                   }
               });
           }

           function saveDiscount(discountcode, id_ordertype, suppcurrentno, discountpercentage) {
               $.ajax({
                   type: "POST",
                   url: "SupplierDetail.aspx/saveDiscount",

                   data: "{discountcode:'" + discountcode + "',id_ordertype:'" + id_ordertype + "',suppcurrentno:'" + suppcurrentno  + "',discountpercentage:'" + discountpercentage + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,
                   success: function (data) {
                       //console.log(data.d);

                       systemMSG('success', 'Ny rabatt lagret', 5000);
                       $("#discount-table").tabulator("setData", "SupplierDetail.aspx/getDiscountData", { 'SUPP_CURRENTNO':suppcurrentno, 'ID_ORDERTYPE': id_ordertype});

                   },
                   failure: function () {
                       alert("Failed!");
                   }
               });
           }

           function FetchCurrencyDetails(CURRENCY_CODE) {
               console.log(CURRENCY_CODE);
                cpChange = '';
                $.ajax({
                    type: "POST",
                    url: "SupplierDetail.aspx/FetchCurrencyDetail",
                    data: "{CURRENCY_CODE: '" + CURRENCY_CODE + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //console.log(data.d);
                      
                        $('#<%=txtAdvCurrencyId.ClientID%>').val(data.d.CURRENCY_CODE);
                        $('#<%=lblAdvCurrencyDesc.ClientID%>').html(data.d.CURRENCY_DESCRIPTION + " - Rate: " + data.d.CURRENCY_RATE);
                        //$('#<%=txtAdvCurrencyId.ClientID%>').focus();
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
           };

           $("#btnAddDiscountCode").on('click', function (e) {
               overlay('on', 'modNewDiscountCode');
           });

           $('#addOrderType').on('click', function () {
                $('#txtbxNewOrdertypeSupplier').val($('#txtSupplierId').val());
                
                overlay('on', 'modNewOrdertype');
           });

           $('#ddlOrdertypesModal').change(function () {
                if (this.value != '*') {
                    var id = this.value;
                    getOrdertypes($('#txtSupplierId').val(), id);
                }
                else {
                    $('#txtbxNewOrdertypePricetype').val('');
                    $('#txtbxNewOrdertypeOrdertype').val('');
                    $('#txtbxNewOrdertypeDescription').val('');
                }
                
           });

           $('#dropdown_modal_ordertype').change(function () {
               if (this.value == 0) this.value = "";               
                $("#discount-table").tabulator("setData", "SupplierDetail.aspx/getDiscountData", { 'SUPP_CURRENTNO':  $('#txtSupplierId').val(), 'ID_ORDERTYPE': this.value });
                
            });

           $("#btnSupEmptyScreen").on('click', function (e) {
                $(this).addClass('loading');
                $('#aspnetForm')[0].reset();
                $('.loading').removeClass('loading');
            });

           $('#btnSupSave').on('click', function (e) {

               console.log('button clicked');
               if (requiredFields(true, 'data-submit') === true) {
                   $(this).addClass('loading');
                   saveSupplier();

               }
           });

           $('#<%=btnSupplierOpenMail.ClientID%>').on('click', function (e) {
               var email = $('#<%=txtSupplierMail.ClientID%>').val();
               //var subject = '';
               //var emailBody = '';
               //var attach = 'path';
            
               document.location = "mailto:" + email;
           });
           $('#<%=btnOpenWebPage.ClientID%>').on('click', function (e) {
                var url = $('#<%=txtSupplierWebPage.ClientID%>').val();
                window.open(url, '_blank');
           });

           $('#<%=chkSameAdd.ClientID%>').on('click', function (e) {
                setBillAdd();
           });

           function sameAdressIsChecked() {
                if ($('#<%=chkSameAdd.ClientID%>').is(':checked'))
                    return true;
                else
                    return false;
           }

           function setBillAdd() {
                if (sameAdressIsChecked()) {
                    $('#<%=txtBillAdd1.ClientID%>').val($('#<%=txtPermAdd1.ClientID%>').val()).prop('disabled', true);
                    $('#<%=txtBillAdd2.ClientID%>').val($('#<%=txtPermAdd2.ClientID%>').val()).prop('disabled', true);
                    $('#<%=txtBillZip.ClientID%>').val($('#<%=txtPermZip.ClientID%>').val()).prop('disabled', true);
                    $('#<%=txtBillCity.ClientID%>').val($('#<%=txtPermCity.ClientID%>').val()).prop('disabled', true);
                    $('#<%=txtBillCounty.ClientID%>').val($('#<%=txtPermCounty.ClientID%>').val()).prop('disabled', true);
                    $('#<%=txtBillCountry.ClientID%>').val($('#<%=txtPermCountry.ClientID%>').val()).prop('disabled', true);
                }
                else {
                    $('#<%=txtBillAdd1.ClientID%>').prop('disabled', false);
                    $('#<%=txtBillAdd2.ClientID%>').prop('disabled', false);
                    $('#<%=txtBillZip.ClientID%>').prop('disabled', false);
                    $('#<%=txtBillCity.ClientID%>').prop('disabled', false);
                    $('#<%=txtBillCounty.ClientID%>').prop('disabled', false);
                    $('#<%=txtBillCountry.ClientID%>').prop('disabled', false);
                }
           }

           /* On click for searchbutton and the show/hide icon. Hides the container div that contains input fields etc so that only our table is displayed */

           

           

           


           function activateEdit(row)
           {
               var ordertype = $('#dropdown_modal_ordertype').val();
               if (ordertype == 0) {
                   ordertype = "";
               }

               swal({
                   title: "Er du sikker?",
                   text: "Hvis du sletter vil du måtte opprette rabattkoden på nytt!",
                   icon: "warning",
                   buttons: true,
                   dangerMode: true,
               })
                   .then((willDelete) => {
                       if (willDelete) {
                           $.ajax({
                               type: "POST",
                               url: "SupplierDetail.aspx/deleteDiscount",

                               data: "{discountcode:'" + row + "',ordertype:'" + ordertype + "',supplier:'" + $('#txtSupplierId').val() + "'}",
                               contentType: "application/json; charset=utf-8",
                               dataType: "json",
                               async: false,
                               success: function (data) {
                                   console.log(data.d);

                                   systemMSG('success', 'Rabatt slettet.', 5000);
                                   $("#discount-table").tabulator("setData", "SupplierDetail.aspx/getDiscountData", { 'SUPP_CURRENTNO': $('#txtSupplierId').val(), 'ID_ORDERTYPE': ordertype });
                                   swal("Rabattkoden er nå slettet!", {
                                       icon: "success",
                                   });
                               },
                               failure: function () {
                                   alert("Failed!");
                               }
                           });


                           
                       } else {
                           swal("Rabattkoden blir stående som den er.");
                       }
                   });
           }

           //custom formatter definition
           var editIcon = function (cell, formatterParams, onRendered) { //plain text value
               return '<i class="orange pencil alternate icon"></i>';
           };
           var trashIcon = function (cell, formatterParams, onRendered) { //plain text value
               return '<i class="trash icon"></i>';
           };
      

           //column definition in the columns array
           

           $("#discount-table").tabulator({
           height: 340, // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
           layout: "fitColumns", //fit columns to width of table (optional)                  
           ajaxConfig:"POST", //ajax HTTP request type
           ajaxContentType:"json", // send parameters to the server as a JSON encoded string
               selectableCheck: function (row) {

                   var selectedRows = $("#discount-table").tabulator("getSelectedRows");
                   if (selectedRows.length !== 0) {
                       if (row.getData().DISCOUNTCODE == selectedRows[0].getData().DISCOUNTCODE) {
                           return false;
                       }
                   }


                   return true; //alow selection of rows where the age is greater than 18
               },

               columns: [ //Define Table Columns
               
               { title: "Rabattkode", field: "DISCOUNTCODE", align: "center" },
               { title: "Tekst", field: "DISCOUNT_DESCRIPTION", align: "center" },
               { title: "Rabatt %", field: "DISCPERCOST", align: "center" },           
               { title: "Resting", field: "DELIVERED", align: "center", formatter: "tickCross" },
                   { formatter: trashIcon, align: "center", width: 90, cellClick: function (e, cell) { activateEdit(cell.getData().DISCOUNTCODE)}}

           ],
           ajaxResponse: function (url, params, response) {
                    console.log("url is: " + url);
                    console.log("params is: " + params);                  
                    
                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //return the d property of a response json object
               }, 
           footerElement: $("<div class='tabulator-footer'> <div class='ui form stackable two column grid'> <div class='sixteen wide column'><div class='fields'><div class='two wide field'><label id='lbl1' style='text-align: left'>Rabattkode</label><select id='dropdown_discountcode'></select></div><div class='four wide field'><label id='lbl2' style='text-align: left'>Tekst</label><input type='text' ReadOnly='true' id='txtSearchText'></div><div class='one wide field'><label id='lbl3' style='text-align: left'>% sats</label><input type='text' id='txtbxDiscountPercentage' disabled='true'></div></div></div></div></div>")[0],

       });
       $(window).resize(function () {
           $("#discount-table").tabulator("redraw", true); //trigger full rerender including all data and rows
       });

       $('#dropdown_discountcode').on('change', function (e) {

        
           var discountcode = this.value;
           getDiscountCodes(discountcode);
           
       });
           $('#btnGen1').on('click', function () {
               $('.ImportPriceFile').show();
               $('.PriceCalculation').hide();
               $('#btnGen1').removeClass('carsButtonBlueInverted');
               $('#btnGen1').addClass('carsButtonBlueNotInverted');
               $('#btnGen2').removeClass('carsButtonBlueNotInverted');
               $('#btnGen2').addClass('carsButtonBlueInverted');

               $('.GenDate, .GenPKKService, .GenPictures').hide();

           });
           $('#btnGen2').on('click', function () {
               $('.PriceCalculation').show();
               $('.ImportPriceFile').hide();
               $('#btnGen1').addClass('carsButtonBlueInverted');
               $('#btnGen1').removeClass('carsButtonBlueNotInverted');
               $('#btnGen2').removeClass('carsButtonBlueInverted');
               $('#btnGen2').addClass('carsButtonBlueNotInverted');
           });
            
       });
           
     
        window.onbeforeunload = confirmExit;
        function confirmExit() {
            if (checkSaveVar()) {

            } else {
                return "Det kan være ulagrede endringer på siden, er du sikker på at du vil lukke siden?";
            }
        }
        function setSaveVar() {
            supvar = collectGroupData('submit');
            
        }
        function checkSaveVar() {
            contvar = collectGroupData('submit');
            //if (JSON.stringify(custvar) === JSON.stringify(contvar)) {
            if(objectEquals(supvar, contvar)){
                return true;
            }
            else {
                return false;
            }
        }
        function clearSaveVar() {
            supvar = {};
       }
       function OnddlWarehouseFromChange() {
           //document.getElementById('<%= ddlWarehouseTo.ClientID %>').value = document.getElementById('<%= ddlWarehouseFrom.ClientID %>').value

           //if (rbCalculateLocal.GetChecked()) {
            ddlWarehouseTo.SetValue(ddlWarehouseFrom.GetValue());
            cbCategoryLoad.PerformCallback("LOCAL;" + ddlWarehouseFrom.GetValue());
            cbClassCode.PerformCallback("LOAD_CLASSCODE;" + txtPartNoFrom.GetText() + ";" + txtPartNoTo.GetText());
            cbLocation.PerformCallback();
            cbDiscountCode.PerformCallback("LOCAL");
           //}
           txtPartNoFrom.SetText("");
           txtPartNoTo.SetText(""); 
           
       }
       
       function OnddlWarehouseToChange() {
           cbCategoryLoad.PerformCallback("LOCAL;" + ddlWarehouseFrom.GetValue());
           //cbClassCode.PerformCallback("LOAD_CLASSCODE;");
           cbClassCode.PerformCallback("LOAD_CLASSCODE;" + txtPartNoFrom.GetText() + ";" + txtPartNoTo.GetText());
           cbLocation.PerformCallback();
           cbDiscountCode.PerformCallback("LOCAL");
           txtPartNoFrom.SetText("");
           txtPartNoTo.SetText("");

       }
       function OnddlCategoryFromChange(s, e) {
           //alert(ddlClassCodeFrom.GetSelectedItem());
           txtPartNoFrom.SetText("");
           txtPartNoTo.SetText("");
           ddlCatTo.SetValue(ddlCatFrom.GetValue());
           if (rbCalculateLocal.GetChecked()) {
               
               //cbClassCode.PerformCallback("LOAD_CLASSCODE;");
               cbClassCode.PerformCallback("LOAD_CLASSCODE;" + txtPartNoFrom.GetText() + ";" + txtPartNoTo.GetText());
               cbLocation.PerformCallback();
               cbDiscountCode.PerformCallback("LOCAL");
           }
           
           else if (rbCalculateGlobal.GetChecked()) {

               cbDiscountCode.PerformCallback("GLOBAL");
           }
       }
       function OnddlCategoryToChange(s, e) {
           
           txtPartNoFrom.SetText("");
           txtPartNoTo.SetText("");
           if (rbCalculateLocal.GetChecked()) {

               //cbClassCode.PerformCallback("LOAD_CLASSCODE;");
               cbClassCode.PerformCallback("LOAD_CLASSCODE;" + txtPartNoFrom.GetText() + ";" + txtPartNoTo.GetText());
               cbLocation.PerformCallback();
               cbDiscountCode.PerformCallback("LOCAL");
           }

           else if (rbCalculateGlobal.GetChecked()) {
               cbDiscountCode.PerformCallback("GLOBAL");
           }
       }
       
       function OnddlClassCodeFromChange(s, e) {
           ddlClassCodeTo.SetValue(ddlClassCodeFrom.GetValue());
           cbLocation.PerformCallback();
           cbDiscountCode.PerformCallback("LOCAL");
       }
       function OntxtPartNoFromLostFocus(s, e) {
           txtPartNoTo.SetText(txtPartNoFrom.GetValue());
           if (rbCalculateLocal.GetChecked()) {

               //cbClassCode.PerformCallback("LOAD_CLASSCODE;");
               cbClassCode.PerformCallback("LOAD_CLASSCODE;" + txtPartNoFrom.GetText() + ";" + txtPartNoTo.GetText());
               cbLocation.PerformCallback();
               cbDiscountCode.PerformCallback("LOCAL");
           }

           else if (rbCalculateGlobal.GetChecked()) {
               cbDiscountCode.PerformCallback("GLOBAL");
           }
       }
       function OnddlLocationFromChange(s, e) {
           ddlLocationTo.SetValue(ddlLocationFrom.GetValue());
           cbDiscountCode.PerformCallback("LOCAL");
       }
       function OntxtPartNoToTextChanged(s, e) {
           if (rbCalculateLocal.GetChecked()) {

               //cbClassCode.PerformCallback("LOAD_CLASSCODE;");
               cbClassCode.PerformCallback("LOAD_CLASSCODE;" + txtPartNoFrom.GetText() + ";" + txtPartNoTo.GetText());
               cbLocation.PerformCallback();
               cbDiscountCode.PerformCallback("LOCAL");
           }

           else if (rbCalculateGlobal.GetChecked()) {
               cbDiscountCode.PerformCallback("GLOBAL");
           }
       }
       function OnddlDiscountCodeFromChange(s, e) {
           ddlDiscountCodeTo.SetValue(ddlDiscountCodeFrom.GetValue());
       }
       function StartCalc() {
           
           var decimalSeperator = '<%=Session("Decimal_Seperator")%>';
           
           if (hdnSuppCurNo.GetText() == "" || hdnSuppCurNo.GetText() == null) {
               swal('<%=GetLocalResourceObject("GenSelectSupplier")%>');
               return false;
           }

           if (rbCalculateLocal.GetChecked()) {
               if (!fnClientValidate(ddlWarehouseFrom, ddlWarehouseTo)) {
                   return false;
               }
           }
           genEntVal = '<%=GetLocalResourceObject("lblWarehouseResource1.Text")%>';
           if (ddlWarehouseFrom.GetSelectedIndex() != 0 && ddlWarehouseTo.GetSelectedIndex() == 0) {
               //swal("Please enter value in Warehouse To");
               swal(`<%=GetLocalResourceObject("GenEnterValueTo")%>`);
               ddlWarehouseTo.Focus();
               return false;
           }
           else if (ddlWarehouseFrom.GetSelectedIndex() == 0 && ddlWarehouseTo.GetSelectedIndex() != 0) {
               //swal("Please enter value in Warehouse From");
               swal(`<%=GetLocalResourceObject("GenEnterValueFrom")%>`);
               ddlWarehouseFrom.Focus();
               return false;
           }
           genEntVal = '<%=GetLocalResourceObject("lblClassCodeResource1.Text")%>'
           if (ddlClassCodeFrom.GetSelectedIndex() != 0 && ddlClassCodeTo.GetSelectedIndex() == 0) {
              // swal("Please enter value in ClassCode To");
               swal(`<%=GetLocalResourceObject("GenEnterValueTo")%>`);
               ddlClassCodeTo.Focus();
               return false;
           }
           else if (ddlClassCodeFrom.GetSelectedIndex() == 0 && ddlClassCodeTo.GetSelectedIndex() != 0) {
               //swal("Please enter value in ClassCode From");
               swal(`<%=GetLocalResourceObject("GenEnterValueFrom")%>`);
               ddlClassCodefrom.Focus();
               return false;
           }
           genEntVal = '<%=GetLocalResourceObject("lblCategoryResource1.Text")%>'
           if (ddlCatFrom.GetSelectedIndex() != 0 && ddlCatTo.GetSelectedIndex() == 0) {
               //swal("Please enter value in Category To");
               swal(`<%=GetLocalResourceObject("GenEnterValueTo")%>`);
               ddlCatTo.Focus();
               return false;
           }
           else if (ddlCatFrom.GetSelectedIndex() == 0 && ddlCatTo.GetSelectedIndex() != 0) {
               //swal("Please enter value in Category From");
               swal(`<%=GetLocalResourceObject("GenEnterValueFrom")%>`);
               ddlCatTo.Focus();
               return false;
           }
           genEntVal = '<%=GetLocalResourceObject("lblLocationResource1.Text")%>'
           if ((ddlLocationFrom.GetSelectedIndex() != 0 && ddlLocationTo.GetSelectedIndex() == 0)) {
               //swal("Please enter value in Location To");
               swal(`<%=GetLocalResourceObject("GenEnterValueTo")%>`);
               ddlLocationTo.Focus();
               return false;
           }
           else if (ddlLocationFrom.GetSelectedIndex() == 0 && ddlLocationTo.GetSelectedIndex() != 0) {
               //swal("Please enter value in Location From");
               swal(`<%=GetLocalResourceObject("GenEnterValueFrom")%>`);
               ddlLocationFrom.Focus();
               return false;
           }
           genEntVal = '<%=GetLocalResourceObject("lblPartNoResource1.Text")%>';
           if (txtPartNoFrom.GetText() != "" && txtPartNoTo.GetText() == 0) {
               //swal("Please enter value in PartNo To");
               swal(`<%=GetLocalResourceObject("GenEnterValueTo")%>`);
               txtPartNoTo.Focus();
               return false;
           }
           else if (txtPartNoFrom.GetText() == "" && txtPartNoTo.GetText() != "") {
               //swal("Please enter value in PartNo From");
               swal(`<%=GetLocalResourceObject("GenEnterValueFrom")%>`);
               txtPartNoFrom.Focus();
               return false;
           }
           genEntVal = '<%=GetLocalResourceObject("lblDiscountCodeResource1.Text")%>';
           if (ddlDiscountCodeFrom.GetSelectedIndex() != 0 && ddlDiscountCodeTo.GetSelectedIndex() == 0) {
               //swal("Please enter value in DiscountCode To");
               swal(`<%=GetLocalResourceObject("GenEnterValueTo")%>`);
               ddlDiscountCodeTo.Focus();
               return false;
           }
           else if (ddlDiscountCodeFrom.GetSelectedIndex() == 0 && ddlDiscountCodeTo.GetSelectedIndex() != 0) {
               //swal("Please enter value in DiscountCode From");
               swal(`<%=GetLocalResourceObject("GenEnterValueFrom")%>`);
               ddlDiscountCodeFrom.Focus();
               return false;
           }
           
           genInvalid = '<%=GetLocalResourceObject("lblBasicPriceResource1.Text")%>';
           if (!fn_ValidateDecimalValue(txtBasicPrice.GetText(), decimalSeperator)) {
               //alert("BasicPrice is invalid");
               swal(`<%=GetLocalResourceObject("GenIsInvalid")%>`);
               return false;
           }
           genInvalid = '<%=GetLocalResourceObject("lblCostPriceResource1.Text")%>';
           if (!fn_ValidateDecimalValue(txtCostPrice.GetText(), decimalSeperator)) {
               swal(`<%=GetLocalResourceObject("GenIsInvalid")%>`);
               //alert("CostPrice is invalid");
               return false;
           }
           genInvalid = '<%=GetLocalResourceObject("lblNetPriceResource1.Text")%>';
           if (!fn_ValidateDecimalValue(txtNetPrice.GetText(), decimalSeperator)) {
               //alert("NetPrice is invalid");
               swal(`<%=GetLocalResourceObject("GenIsInvalid")%>`);
               return false;
           }
           genInvalid = '<%=GetLocalResourceObject("lblSellPriceResource1.Text")%>';
           if (!fn_ValidateDecimalValue(txtSellPrice.GetText(), decimalSeperator)) {
               //alert("SellPrice is invalid");
               swal(`<%=GetLocalResourceObject("GenIsInvalid")%>`);
               return false;
           }
           genValueGreater = '<%=GetLocalResourceObject("lblBasicPriceResource1.Text")%>';
           if (txtBasicPrice.GetText() > 100) {
               //alert(GetMultiMessage('VALNGRE', GetMultiMessage('MARKSP', '', ''), ''));
               //swal("Value cannot be greater than 100 in BasicPrice")
               swal(`<%=GetLocalResourceObject("GenValueGreaterThan100")%>`);
               txtBasicPrice.SetText("");
               txtBasicPrice.Focus();
               return false;
           }
           genValueGreater = '<%=GetLocalResourceObject("lblCostPriceResource1.Text")%>';
           if (txtCostPrice.GetText() > 100) {
               //swal("Value cannot be greater than 100 in CostPrice")
               swal(`<%=GetLocalResourceObject("GenValueGreaterThan100")%>`);
               txtCostPrice.SetText("");
               txtCostPrice.Focus();
               return false;
           }
           genValueGreater = '<%=GetLocalResourceObject("lblNetPriceResource1.Text")%>';
           if (txtNetPrice.GetText() > 100) {
               //swal("Value cannot be greater than 100 in NetPrice")
               swal(`<%=GetLocalResourceObject("GenValueGreaterThan100")%>`);
               txtNetPrice.SetText("");
               txtNetPrice.Focus();
               return false;
           }
           genValueGreater = '<%=GetLocalResourceObject("lblSellPriceResource1.Text")%>';
           if (txtSellPrice.GetText() > 100) {
               //swal("Value cannot be greater than 100 in SellPrice")
               swal(`<%=GetLocalResourceObject("GenValueGreaterThan100")%>`);
               txtSellPrice.SetText("");
               txtSellPrice.Focus();
               return false;
           }
           cbStartCalculation.PerformCallback();
           
       }
       

       function OncbCategoryLoadEndCallback(s, e) {
           ddlCatFrom.SetSelectedIndex(0);
           ddlCatTo.SetSelectedIndex(0);
           ddlDiscountCodeFrom.SetSelectedIndex(0);
           ddlDiscountCodeTo.SetSelectedIndex(0);
       }
       function OncbPartNoLoadEndCallback(s, e) {
           ddlClassCodeFrom.SetSelectedIndex(0);
           ddlClassCodeTo.SetSelectedIndex(0);
       }
       function OncbClassCodeEndCallback(s, e) {
           
           ddlClassCodeFrom.SetSelectedIndex(0);
           ddlClassCodeTo.SetSelectedIndex(0);
       }
       function OncbLocationEndCallback(s, e) {
           ddlLocationFrom.SetSelectedIndex(0);
           ddlLocationTo.SetSelectedIndex(0);
       }
       function OncbDiscountCodeEndCallback(s, e) {
           ddlDiscountCodeFrom.SetSelectedIndex(0);
           ddlDiscountCodeTo.SetSelectedIndex(0);
           lblError.SetText("");
       }
       function fnClientValidate(controlName1, controlName2) {

           if (controlName1.GetSelectedIndex() == 0 && controlName2.GetSelectedIndex() == 0) {
               //var message = GetMultiMessage('0007', GetMultiMessage('70371', '', ''), '');

               swal('<%=GetLocalResourceObject("GenSelectWarehouse")%>');
               controlName1.Focus();
               return false;
           }
           return true;
       }
       function Reset() {
           ddlWarehouseTo.SetSelectedIndex(0);
           ddlWarehouseFrom.SetSelectedIndex(0);
           ddlCatFrom.SetSelectedIndex(0);
           ddlCatTo.SetSelectedIndex(0);
           ddlLocationFrom.SetSelectedIndex(0);
           ddlLocationTo.SetSelectedIndex(0);
           ddlClassCodeFrom.SetSelectedIndex(0);
           ddlClassCodeTo.SetSelectedIndex(0);
           ddlDiscountCodeFrom.SetSelectedIndex(0);
           ddlDiscountCodeTo.SetSelectedIndex(0);
           txtPartNoFrom.SetText("");
           txtPartNoTo.SetText("");
           txtBasicPrice.SetText("");
           txtCostPrice.SetText("");
           txtNetPrice.SetText("");
           txtSellPrice.SetText("");
           lblError.SetText("");
       }
       function OnrbPriceAdjustmentCheckChanged(s, e) {
           if (s.GetChecked()) {
               rbRoundingToClosest50.SetEnabled(false);
               rbRoundToClosestInt.SetEnabled(false);
               rbRoundingToClosest50.SetChecked(false);
               rbRoundToClosestInt.SetChecked(false);
           }
       }
       function OnrbRoundingCheckChanged(s,e) {
           if (s.GetChecked()) {
               rbRoundingToClosest50.SetEnabled(true);
               rbRoundToClosestInt.SetEnabled(true);
               rbRoundingToClosest50.SetChecked(true);
           }
       }
        function OnrbPriceAdjustmentInit(s, e){
            if (s.GetChecked()) {
                rbRoundingToClosest50.SetEnabled(false);
                rbRoundToClosestInt.SetEnabled(false);
            }
       }
       function OnrbCalculateLocalCheckedChanged(s, e) {

           Reset();
           if (!s.GetChecked()) {
               ddlWarehouseFrom.SetEnabled(false);
               ddlWarehouseTo.SetEnabled(false);
               ddlClassCodeFrom.SetEnabled(false);
               ddlClassCodeTo.SetEnabled(false);
               ddlLocationFrom.SetEnabled(false);
               ddlLocationTo.SetEnabled(false);
               cbCategoryLoad.PerformCallback("GLOBAL");
               cbDiscountCode.PerformCallback("GLOBAL");
           }
           else { 
               ddlWarehouseFrom.SetEnabled(true);
               ddlWarehouseTo.SetEnabled(true);
               ddlClassCodeFrom.SetEnabled(true);
               ddlClassCodeTo.SetEnabled(true);
               ddlLocationFrom.SetEnabled(true);
               ddlLocationTo.SetEnabled(true);
           }
       }
       
       function OntxtPartNoFromInit(s, e) {

           //debugger;
           var suppCurrNo = hdnSuppCurNo.GetText();
           if (rbCalculateGlobal.GetChecked()) {
               $(s.GetInputElement()).autocomplete({
                   selectFirst: true,
                   autoFocus: true,
                   minLength: 4,
                   source: function (request, response) {
                       $.ajax({
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           //url: "LocalSPDetail.aspx/SparePart_Search1",
                           url: "SupplierDetail.aspx/SparePart_Search",
                           //data: "{q:'" + request.term + "',localGlobal:'" + "GLOBAL" + "'}",
                           data: "{q:'" + request.term + "', 'localGlobal': '" + "GLOBAL" + "', 'suppCurrNo': '" + suppCurrNo + "'}",
                           dataType: "json",
                           maxJsonLength: 100000,
                           success: function (data) {

                               if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                   response([{ label: '<%=GetLocalResourceObject("GenNoRecordFound")%>', value: ' ', val: 'new' }]);
                               } else
                                   response($.map(data.d, function (item) {
                                       //imake = item.ID_MAKE;
                                       //iid = item.ID_ITEM;
                                       //iwh = '1';
                                       return {
                                           label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC,
                                           val: item.ID_ITEM,
                                           value: item.ID_ITEM,
                                           make: item.ID_MAKE
                                           //warehouse: item.ID_WH_ITEM //+ " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
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

                       if (i.item.val != "new") {
                       <%--$('#<%=txtInfoSupplier.ClientID%>').val('');
                        loadCategory();
                        FetchSparePartDetails(i.item.val, i.item.make, i.item.warehouse);

                        $('#txtSpareSearch').val('')
                        e.preventDefault();


                        $('#<%=lblNewItem.ClientID%>').css("visibility", "hidden");
                        $('#aspnetForm input').removeAttr('disabled');

                        $('#<%=txtSpareNo.ClientID%>').attr("disabled", "disabled");
                        $('#<%=txtsparedesc.ClientID%>').attr("disabled", "disabled");
                        $('#<%=txtInfoSupplier.ClientID%>').attr("disabled", "disabled");
                        $('#<%=txtInfoSupplierName.ClientID%>').attr("disabled", "disabled");
                        $('.ui.attached.tabular.menu > .item').removeClass('disabled');
                        $('.disabledBox').attr("disabled", "disabled");
                        $('#txtbxCampaignPrice').removeAttr("disabled");--%>
                           s.SetValue(i.item.val);
                           //txtPartNoTo.SetText(i.item.val);
                       }
                       else {
                           //openSparepartGridWindow("LocalSPDetail");
                           //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                           //alert(i.item.val);
                           s.SetValue("");
                           //txtPartNoTo.SetText("");
                       }

                   }
               });
           }
           else {
               var suppCurrNo = hdnSuppCurNo.GetText();
               $(s.GetInputElement()).autocomplete({
                   selectFirst: true,
                   autoFocus: true,
                   source: function (request, response) {
                       $.ajax({
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           //url: "LocalSPDetail.aspx/SparePart_Search1",
                           url: "SupplierDetail.aspx/SparePart_Search",
                           //data: "{q:'" + request.term + "',localGlobal:'" + "LOCAL" + "'}",
                           data: "{q:'" + request.term + "', 'localGlobal': '" + "LOCAL" + "', 'suppCurrNo': '" + suppCurrNo + "'}",
                           dataType: "json",
                           maxJsonLength: 100000,
                           success: function (data) {

                               if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                   response([{ label: '<%=GetLocalResourceObject("GenNoRecordFound")%>', value: ' ', val: 'new' }]);
                           } else
                               response($.map(data.d, function (item) {

                                   return {
                                       label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC,
                                       val: item.ID_ITEM,
                                       value: item.ID_ITEM,
                                       make: item.ID_MAKE
                                       
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

                       if (i.item.val != "new") {
                       
                           s.SetValue(i.item.val);
                           
                       }
                       else {

                           s.SetValue("");

                       }

                   }
               });
           }
           
       }
       
       function ValidateSupCurrNoEmpty(s, e) {
           if (hdnSuppCurNo.GetText() == "" || hdnSuppCurNo.GetText() == null) {
               swal('<%=GetLocalResourceObject("GenSelectSupplier")%>');
               return false;
           }
       }
       function OnrbCalculateGlobalInit(s, e) {           
           ddlWarehouseFrom.SetEnabled(false);
           ddlWarehouseTo.SetEnabled(false);
           ddlClassCodeFrom.SetEnabled(false);
           ddlClassCodeTo.SetEnabled(false);
           ddlLocationFrom.SetEnabled(false);
           ddlLocationTo.SetEnabled(false);
       }
       function setElementVisible(elementId, visible) {
           document.getElementById(elementId).className = visible ? "" : "hidden";
       }
       function onFileUploadComplete(s, e) {         
           if (e.callbackData) {               
               lblFileName.SetText('<%=GetLocalResourceObject("READFILESUCCESS")%>'+" " + e.callbackData);
               allowImport=true
           }
       }
       function OncbImportClickEndCallback(s, e) {
           lblFileName.SetText('<%=GetLocalResourceObject("READFILESUCCESS")%>');
           if (cbImportClick.cpStrResult != null && cbImportClick.cpStrResult != "") {
               swal(cbImportClick.cpStrResult);
           }
           allowImport = false;
           LoadingPanel.Hide();
       }
       function OnbtnImportClick() {
           var decimalSeperator = '<%=Session("Decimal_Seperator")%>';
           if (!fn_ValidateDecimalValue($('#<%=txtPerBasicPrice.ClientID%>').val(), decimalSeperator)) {
               swal('<%=GetLocalResourceObject("INVBASICPRICE")%>');
               return false;
           }
           if (!fn_ValidateDecimalValue($('#<%=txtPerCostPrice.ClientID%>').val(), decimalSeperator)) {
               swal('<%=GetLocalResourceObject("INVCOSTPRICE")%>');
               return false;
           }
           if (!fn_ValidateDecimalValue($('#<%=txtPerNetPrice.ClientID%>').val(), decimalSeperator)) {
               swal('<%=GetLocalResourceObject("INVNETPRICE")%>');
               return false;
           }
           if (!fn_ValidateDecimalValue($('#<%=txtPerSellPrice.ClientID%>').val(), decimalSeperator)) {
               swal('<%=GetLocalResourceObject("INVSELLPRICE")%>');
               return false;
           }

           if (hdnSuppCurNo.GetText() == "") {
               swal('<%=GetLocalResourceObject("GenSelectSupplier")%>');
           }
           else if (ddlSparePartGroup.GetSelectedIndex() == 0){
               swal('<%=GetLocalResourceObject("INVSPCATG")%>');
           }
           else if (!allowImport) {
               swal('<%=GetLocalResourceObject("UPPFIMP")%>');
           }
           else if ($('#<%=rbNoCreateGlobalSprPrt.ClientID%>').is(':checked')) {
               swal('<%=GetLocalResourceObject("CRUPDGLBLSPARES")%>');
           }
           else {
               cbImportClick.PerformCallback();
               LoadingPanel.Show();
           }
       }
       function cbSparePartGroupEndCallback(s, e) {
           ddlSparePartGroup.SetSelectedIndex(0);
       }
   </script>
    <asp:HiddenField ID="hdnSelect" runat="server" />
    <div class="overlayHide"></div>
    <div id="systemMessage" class="ui message"> </div>
    
    <%-- Modal for sjekking av eksisterende kundenummer --%>
    <div id="modSupplierExists" class="ui modal">
        <div class="header">
            Advarsel!
        </div>
        <div class="image content">
            <div class="image">
                <i class="warning icon"></i>
            </div>
            <div class="description">
                <p id="mseMSG"></p>
            </div>
        </div>
        <div class="actions">
            <div class="ui button ok">Se på leverandør</div>
            <div class="ui button cancel">Prøv nytt nummer</div>
        </div>
    </div>
    <div id="modSupplierLock" class="ui modal">
        <div class="header">
            <asp:Literal runat="server" ID="SupplierLockHead" meta:resourcekey="SupplierLockHeadResource1" Text="Advarsel!"></asp:Literal>
        </div>
        <div class="image content">
            <div class="image">
                <i class="warning icon"></i>
            </div>
            <div class="description">
                <p><asp:Label runat="server" ID="SupplierLock1" meta:resourcekey="SupplierLock1Resource1" Text="Leverandørnummer er låst for manuell inntasting. Dette nummeret blir automatisk tildelt ved lagring av leverandør."></asp:Label></p>
                <p><asp:Literal runat="server" ID="SupplierLock2" meta:resourcekey="SupplierLock2Resource1" Text="Ønsker du å søke opp leverandør, trykk avbryt og bruk søkefeltet til høyre."></asp:Literal></p>
                <p><asp:Literal runat="server" ID="SupplierLock3" meta:resourcekey="SupplierLock3Resource1" Text="For å tildele manuelt leverandørnummer, velg &quot;lås opp&quot; for å låse opp feltet for inntasting."></asp:Literal></p>
            </div>
        </div>
        <div class="actions">
            <div class="ui button ok positive"><asp:Literal runat="server" ID="SupplierLockOK" meta:resourcekey="SupplierLockOKResource1" Text="Lås opp"></asp:Literal></div>
            <div class="ui button cancel negative"><asp:Literal runat="server" ID="SupplierLockCancel" meta:resourcekey="SupplierLockCancelResource1" Text="Avbryt"></asp:Literal></div>
        </div>
    </div>

    <%-- Modal for sjekking av eksisterende kundenummer --%>
    <div id="modCustomerExists" class="ui modal">
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
            <div class="ui button ok">Se på leverandør</div>
            <div class="ui button cancel">Prøv nytt nummer</div>
        </div>
    </div>
    <%-- Modal for Eniro search pop up --%>
    <div id="modNewCust" class="modal hidden">
        <div class="modHeader">
            <h2 id="H1" runat="server">Find Customer</h2>
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
                                <asp:Label ID="Label1" Text="Søk etter leverandør (Tlf, navn, sted, etc.)" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <asp:TextBox ID="txtEniro" runat="server" meta:resourcekey="txtEniroResource1"></asp:TextBox>
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

    <div class="ui one column grid">
        <div class="stretched row">

            <div class="sixteen wide column" style="background-color: rgba(248, 247, 252, 0.2)">
               
                    <div class="ui form raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Søk</h3>
                        <div class="ui stackable grid">
                            <div id="ID_SUPPLIER_WRAPPER" class="four wide computer four wide tablet column">
                                <div class="inline fields">
                                    <label for="txtSupplierId" id="lblSupplierId" runat="server">
                                        <asp:Label ID="lblsuppId" runat="server" Text="Leverandørnr." meta:resourcekey="lHeadResource1"></asp:Label></label>
                                        <input type="text" id="txtSupplierId" data-submit="SUPP_CURRENTNO" disabled="disabled" />
                                </div>
                            </div>
                            <div class="six wide computer six wide tablet column ">
                                <div class="inline fields">
                                    <label for="txtSuppId">
                                        <asp:Label ID="lblHead" runat="server" Text="Leverandørsøk" meta:resourcekey="lHeadResource1"></asp:Label></label>
                                    <div class="ui input">
                                        <input type="text" placeholder="Søk leverandør" id="txtSupplierSearch" />
                                    </div>

                                </div>
                            </div>
                            <div class="four wide computer six wide tablet column ">
                                <div class="inline fields">
                                    <p id="suppnameparagraph" style="font-size: 22px; font-weight:bold; font-family: 'Open Sans', sans-serif;"></p>

                                </div>
                            </div>

                        </div>
                    </div>

                
                    <div class="ui top attached tabular menu">
                        <a class="item active" data-tab="first">Generelt</a>
                        <a class="item" data-tab="second">Avansert</a>
                        <a class="item" data-tab="third">Rabatt</a>
                        <a class="item" data-tab="fourth">Price File</a>
                    </div>
                    <div class="ui bottom attached active tab segment" data-tab="first">
                        <div id="tabSupplier">
                            <div class="ui grid">
                                <div class="eleven wide column">
                                    <div class="ui form">
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblSupDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Detaljer</h3>
                                            <%--Customer info panel--%>
                                            <label>
                                                <asp:CheckBox ID="chkPrivOrSub" runat="server" Text="Company" CssClass="inHeaderCheckbox" data-submit="FLG_PRIVATE_COMP" meta:resourcekey="chkPrivOrSubResource1" />
                                            </label>
                                             <div class="fields">
                                                <div class="ten wide column" data-type="po">
                                                    <asp:Label ID="lblSupplierName" Text="Supplier name" runat="server" meta:resourcekey="lblSuppliernameResource1"></asp:Label>
                                                    <asp:TextBox ID="txtSupplierName" runat="server" data-submit="SUP_Name" data-required="REQUIRED" meta:resourcekey="txtFirstnameResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                               
                                           
                                                 </div>
                                            <div class="fields">
                                                <div class="ui grid">
                                                    <div id="panelPermAdd" class="sixteen wide computer sixteen wide tablet sixteen wide mobile column">
                                                        <div class="column">
                                                            <asp:Label ID="lblPermAdd" Text="Visit address" runat="server" meta:resourcekey="lblPermAddResource1"></asp:Label>
                                                            <asp:TextBox ID="txtPermAdd1" runat="server" data-submit="SUP_Address1" meta:resourcekey="txtPermAdd1Resource1" CssClass="carsInput"></asp:TextBox>
                                                            <asp:TextBox ID="txtPermAdd2" runat="server" Visible="False" data-submit="CUST_PERM_ADD2" CssClass="mt3" meta:resourcekey="txtPermAdd2Resource1"></asp:TextBox>
                                                        </div>
                                                        <div class="column">
                                                            <div class="ui two column stackable grid">
                                                                <div class="column">
                                                                    <div class="ui grid">
                                                                        <div class="five wide column">
                                                                            <asp:Label ID="lblPermZip" Text="Zipcode" runat="server" meta:resourcekey="lblPermZipResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtPermZip" runat="server" data-submit="SUP_Zipcode" meta:resourcekey="txtPermZipResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                        <div class="eleven wide column">
                                                                            <asp:Label ID="lblPermCity" Text="City" runat="server" meta:resourcekey="lblPermCityResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtPermCity" runat="server" data-submit="SUP_CITY" meta:resourcekey="txtPermCityResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="column">
                                                                    <div class="ui two column grid">
                                                                        <div class="column">
                                                                            <asp:Label ID="lblPermCounty" Text="County(fyl)" runat="server" meta:resourcekey="lblPermCountyResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtPermCounty" runat="server" data-submit="SUP_REGION" meta:resourcekey="txtPermCountyResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                        <div class="column">
                                                                            <asp:Label ID="lblPermCountry" Text="Country" runat="server" meta:resourcekey="lblPermCountryResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtPermCountry" runat="server" data-submit="SUP_COUNTRY" meta:resourcekey="txtPermCountryResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="panelBillAdd" class="sixteen wide computer sixteen wide tablet sixteen wide mobile column">
                                                        <div class="column">
                                                            <asp:Label ID="lblBillAdd" Text="Postal address" runat="server" meta:resourcekey="lblBillAddResource1"></asp:Label>
                                                            <label>
                                                                <asp:CheckBox ID="chkSameAdd" runat="server" Text="Same as visit address" CssClass="inLblCheckbox" data-submit="FLG_SAME_ADDRESS" meta:resourcekey="chkSameAddResource1" />
                                                            </label>
                                                            <asp:TextBox ID="txtBillAdd1" runat="server" data-submit="SUP_BILLAddress1" meta:resourcekey="txtBillAdd1Resource1" CssClass="carsInput"></asp:TextBox>
                                                            <asp:TextBox ID="txtBillAdd2" runat="server" Visible="False" data-submit="CUST_BILL_ADD2" CssClass="mt3" meta:resourcekey="txtBillAdd2Resource1"></asp:TextBox>
                                                        </div>
                                                        <div class="column">
                                                            <div class="ui two column stackable grid">
                                                                <div class="column">
                                                                    <div class="ui grid">
                                                                        <div class="five wide column">
                                                                            <asp:Label ID="lblBillZip" Text="Zipcode" runat="server" meta:resourcekey="lblBillZipResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtBillZip" runat="server" data-submit="SUP_BILLZipcode" meta:resourcekey="txtBillZipResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                        <div class="eleven wide column">
                                                                            <asp:Label ID="lblBillCity" Text="City" runat="server" meta:resourcekey="lblBillCityResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtBillCity" runat="server" data-submit="SUP_BILL_CITY" meta:resourcekey="txtBillCityResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="column">
                                                                    <div class="ui two column grid">
                                                                        <div class="column">
                                                                            <asp:Label ID="lblBillCounty" Text="County(fyl)" runat="server" meta:resourcekey="lblBillCountyResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtBillCounty" runat="server" meta:resourcekey="txtBillCountyResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                        <div class="column">
                                                                            <asp:Label ID="lblBillCountry" Text="Country" runat="server" meta:resourcekey="lblBillCountryResource1"></asp:Label>
                                                                            <asp:TextBox ID="txtBillCountry" runat="server" data-submit="SUP_BILL_COUNTRY" meta:resourcekey="txtBillCountryResource1" CssClass="carsInput"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H13" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Menu pricing / EPC Program path</h3>
                                            <div class="ui form ">
                                                <div class="fields">
                                                    <div class="four wide field">
                                                        <asp:Label ID="lblCompanyPersonFind" Text="Menu pricing:" runat="server" meta:resourcekey="lblCompanyPersonFindResource1"></asp:Label>
                                                    </div>
                                                    <div class="eight wide field">
                                                        <asp:TextBox ID="txtCompanyPersonFind" runat="server" meta:resourcekey="txtCompanyPerson2Resource1" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                    <div class="four wide field">
                                                        <input type="button" id="btnSupplierMenuPricing" runat="server" class="ui btn" value="Finn mål" meta:resourcekey="btnCompanyPersonResource1" />
                                                    </div>
                                                </div>
                                                <div class="fields">
                                                    <div class="four wide field">
                                                        <asp:Label ID="lblSupplierEPC" Text="Electronic parts catalogue:" runat="server" meta:resourcekey="lblCompanyPersonFindResource1"></asp:Label>
                                                    </div>
                                                    <div class="eight wide field">
                                                        <asp:TextBox ID="txtSupplierEPC" runat="server" CssClass="carsInput" meta:resourcekey="txtCompanyPerson2Resource1"></asp:TextBox>
                                                    </div>
                                                    <div class="four wide field">
                                                        <input type="button" id="btnSupplierEPC" runat="server" class="ui btn" value="Finn mål" meta:resourcekey="btnCompanyPersonResource1" />
                                                    </div>
                                                </div>
                                                <div class="fields">
                                                    <div class="four wide field">
                                                        <asp:Label ID="lblSupplierEAC" Text="Electronic accessories Catalogue:" runat="server" meta:resourcekey="lblCompanyPersonFindResource1"></asp:Label>
                                                    </div>
                                                    <div class="eight wide field">
                                                        <asp:TextBox ID="txtSupplierEAC" runat="server" CssClass="carsInput" meta:resourcekey="txtCompanyPerson2Resource1"></asp:TextBox>
                                                    </div>
                                                    <div class="four wide field">
                                                        <input type="button" id="btnSupplierEAC" runat="server" class="ui btn" value="Finn mål" meta:resourcekey="btnCompanyPersonResource1" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

          
            
            <%-- End Left Column --%>

            <div class="five wide column">
                <%-- Start Right Column --%>
                <div class="ui form">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H14" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Contact</h3>
                        <div class="fields">
                            <div class="ten wide field">
                                <label id="lblSupplierContactPerson" runat="server">Contact person</label>
                                <asp:TextBox ID="txtSupplierContactPerson" runat="server" data-submit="SUP_Contact_Name" meta:resourcekey="txtEcoSalespriceNetResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="six wide field">
                                <label id="lblSupplierPhone" runat="server">Phone number</label>
                                <asp:TextBox ID="txtSupplierPhone" runat="server" data-submit="SUP_Phone_Off" meta:resourcekey="txtEcoSalesSaleResource1" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="fourteen wide field">
                                <label id="lblSupplierMail" runat="server">Mail</label>
                                <asp:TextBox ID="txtSupplierMail" runat="server" data-submit="SUP_ID_Email" CssClass="carsInput fixed" meta:resourcekey="txtEcoSalesEquipmentResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <label>&nbsp;</label>
                                <input type="button" id="btnSupplierOpenMail" runat="server" value="Åpne" class="ui btn mini" />
                            </div>
                        </div>
                        <div class="fields">
                            <div class="fourteen wide field">
                                <label id="lblSupplierWebPage" runat="server">WebPage</label>
                                <asp:TextBox ID="txtSupplierWebPage" runat="server" data-submit="SUP_WEBPAGE" Text="Http://www." CssClass="carsInput fixed" meta:resourcekey="txtEcoRegCostResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <label>&nbsp;</label>
                                <input type="button" id="btnOpenWebPage" runat="server" value="Åpne" class="ui btn mini" />
                            </div>
                        </div>
                        
                    </div>
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H15" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Supplier options</h3>
                        <div class="fields">
                            <div class="four wide field">
                                <asp:Label ID="lblSupplierDateCreatedInfo" Text="Date created:" runat="server" meta:resourcekey="lblAdvVendorNoResource1"></asp:Label>
                                </div>
                            <div class="twelve wide field">
                                <asp:Label ID="lblSupplierDateCreated" Text="28/12/2016" runat="server" meta:resourcekey="lblAdvVendorNoResource1"></asp:Label>
                                </div>
                            </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label><asp:CheckBox ID="cbSupplierFinance" runat="server" Text="Finance supplier" meta:resourcekey="cbSupplierFinanceResource1" /></label>
                                </div>
                            <div class="eight wide field">
                                <label><asp:CheckBox ID="cbSupplierStockQtyDelivered" runat="server" Text="Stock qty delivered" meta:resourcekey="cbSupplierStockQtyDeliveredResource1" /></label>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label><asp:CheckBox ID="cbSupplierInvJournalFTP" runat="server" Text="Invoice journal to FTP" meta:resourcekey="cbSupplierInvJournalFTPResource1" /></label>
                                </div>
                            <div class="eight wide field">
                                <label><asp:CheckBox ID="cbSupplierNonStockSale" runat="server" Text="Non-stock sale" meta:resourcekey="cbSupplierNonStockSaleResource1" /></label>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                              
                                </div>
                            <div class="eight wide field">
                                <label><asp:CheckBox ID="cbSupplierRebuyAccepted" runat="server" Text="Return accepted" meta:resourcekey="cbSupplierRebuyAcceptedResource1" /></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
                    <div class="ui bottom attached tab segment" data-tab="second">
                        <div id="tabAdvanced" class="tTab">
                            <div class="ui grid">
                                <div class="eight wide column">
                                    <div class="ui form">
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H16" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Leverandør</h3>
                                            <div class="fields">
                                                <div class="three wide field">
                                                    <label id="lblAdvSupplierId" runat="server">Supplier ID</label>
                                                    <asp:TextBox ID="txtAdvSupplierId" data-submit="ID_SUPPLIER" runat="server" CssClass="carsInput" meta:resourcekey="txtAdvSupplierIdResource1"></asp:TextBox>
                                                </div>
                                                <div class="two wide field">
                                                    <label>&nbsp;</label>
                                                    <asp:Literal ID="liAdvSupplierIdDesc" runat="server" Text="Default" meta:resourcekey="liAdvSupplierIdDescResource1"></asp:Literal>
                                                </div>
                                                <div class="three wide field">
                                                    <label id="lblSupplierStockId" runat="server">Supplier Stock ID</label>
                                                    <asp:TextBox ID="txtSupplierStockId" data-submit="SUPPLIER_STOCK_ID" runat="server" CssClass="carsInput" meta:resourcekey="txtSupplierStockIdResource1"></asp:TextBox>
                                                </div>
                                                <div class="three wide field">
                                                    <label id="lblAdvCurrencyId" runat="server">Currency code</label>
                                                    <asp:TextBox ID="txtAdvCurrencyId" data-submit="CURRENCY_CODE" runat="server" CssClass="carsInput" meta:resourcekey="txtAdvCurrencyIdResource1"></asp:TextBox>
                                                </div>
                                                <div class="six wide field">
                                                    <label>&nbsp;</label>
                                                    <asp:Label ID="lblAdvCurrencyDesc" runat="server" Text="Default" meta:resourcekey="lblAdvCurrencyDescResource1"></asp:Label>
                                                </div>

                                            </div>
                                            <div class="fields">
                                                <div class="three wide field">
                                                    <label id="lblAdvProductCode" runat="server">Product code</label>
                                                    <asp:TextBox ID="txtAdvProductCode" runat="server" CssClass="carsInput" meta:resourcekey="txtAdvProductCodeResource1"></asp:TextBox>
                                                </div>
                                                <div class="two wide field">
                                                    <label>&nbsp;</label>
                                                    <asp:Literal ID="liAdvProductCodeDesc" runat="server" Text="Default" meta:resourcekey="liAdvProductCodeDescResource1"></asp:Literal>
                                                </div>
                                                <div class="three wide field">
                                                    <label id="lblDealerNo" runat="server">Dealer No.</label>
                                                    <asp:TextBox ID="txtDealerNo" data-submit="DEALER_NO_SPARE" runat="server" CssClass="carsInput" meta:resourcekey="txtDealerNoResource1"></asp:TextBox>
                                                </div>
                                                <div class="three wide field">
                                                    <label id="lblAdvSparePrefix" runat="server">Spare prefix</label>
                                                    <asp:TextBox ID="txtAdvSparePrefix" runat="server" CssClass="carsInput" meta:resourcekey="txtAdvSparePrefixResource1"></asp:TextBox>
                                                </div>
                                                <div class="three wide field">
                                                    <label id="lblAdvDeliveryTime" runat="server">Delivery time</label>
                                                    <asp:TextBox ID="txtAdvDeliveryTime" runat="server" CssClass="carsInput" meta:resourcekey="txtAdvDeliveryTimeResource1"></asp:TextBox>
                                                </div>
                                                <div class="three wide field">
                                                    <label id="lblAdvNSCCode" runat="server">NSC code</label>
                                                    <asp:TextBox ID="txtAdvNSCCode" runat="server" CssClass="carsInput" meta:resourcekey="txtAdvNSCCodeResource1"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        
                                         <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H17" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">FTP-Server for pris oppdatering</h3>
                                            <div class="fields">
                                                <div class="eight wide field">
                                                    <label id="lblAdvFTPHostName" runat="server">Host name</label>
                                                    <asp:TextBox ID="txtAdvFTPHostName" runat="server" meta:resourcekey="txtTechWarehouseResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                                <div class="eight wide field">
                                                    <label id="lblAdvFTPPathFolder" runat="server">folder path</label>
                                                    <asp:TextBox ID="txtAdvFTPPathFolder" runat="server" meta:resourcekey="txtTechWarehouseNameResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="fields">
                                                <div class="eight wide field">
                                                    <label id="lblAdvFTPUserName" runat="server">User name</label>
                                                    <asp:TextBox ID="txtAdvFTPUserName" runat="server" meta:resourcekey="txtTechControlFormResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                                <div class="eight wide field">
                                                    <label id="lblAdvFTPPassword" runat="server">Password</label>
                                                    <asp:TextBox ID="txtAdvFTPPassword" runat="server" meta:resourcekey="txtTechWarehouseNameResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H18" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Web login / Ekstern FTP-Server for ordrer</h3>
                                            <div class="fields">
                                                <div class="eight wide field">
                                                    <label id="lblAdvWebHostName" runat="server">Host name</label>
                                                    <asp:TextBox ID="txtAdvWebHostName" runat="server" meta:resourcekey="txtTechWarehouseResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                                <div class="eight wide field">
                                                    <label id="lblAdvWebPathFolder" runat="server">folder path</label>
                                                    <asp:TextBox ID="txtAdvWebPathFolder" runat="server" meta:resourcekey="txtTechWarehouseNameResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="fields">
                                                <div class="eight wide field">
                                                    <label id="lblAdvWebUserName" runat="server">User name</label>
                                                    <asp:TextBox ID="txtAdvWebUserName" runat="server" meta:resourcekey="txtTechControlFormResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                                <div class="eight wide field">
                                                    <label id="lblAdvWebPassword" runat="server">Password</label>
                                                    <asp:TextBox ID="txtAdvWebPassword" runat="server" meta:resourcekey="txtTechWarehouseNameResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="eight wide column">
                                    <div class="ui form">
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H19" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Automatic update</h3>
                                            <div class="fields">
                                                <div class="five wide field">
                                                    <label>
                                                        <asp:CheckBox ID="cbAdvUpdateDescription" runat="server" Text="Description" meta:resourcekey="cbAdvUpdateDescriptionResource1" /></label>
                                                </div>
                                                <div class="five wide field">
                                                    <label>
                                                        <asp:CheckBox ID="cbAdvUpdateProductGroup" runat="server" Text="Product group" meta:resourcekey="cbAdvUpdateProductGroupResource1" /></label>
                                                </div>
                                                <div class="five wide field">
                                                    <label>
                                                        <asp:CheckBox ID="cbAdvUpdateDiscount" runat="server" Text="Discount code" meta:resourcekey="cbAdvUpdateDiscountResource1" /></label>
                                                </div>
                                                <div class="one wide field">
                                                </div>
                                            </div>
                                            <div class="fields">
                                                <div class="five wide field">
                                                    <label>
                                                        <asp:CheckBox ID="cbAdvUpdateCostPrice" runat="server" Text="Cost price" meta:resourcekey="cbAdvUpdateCostPriceResource1" /></label>
                                                </div>
                                                <div class="five wide field">
                                                    <label>
                                                        <asp:CheckBox ID="cbAdvUpdateNetPrice" runat="server" Text="Net Price" meta:resourcekey="cbAdvUpdateNetPriceResource1" /></label>
                                                </div>
                                                <div class="five wide field">
                                                    <label>
                                                        <asp:CheckBox ID="cbAdvUpdateNonStock" runat="server" Text="Non-Stock" meta:resourcekey="cbAdvUpdateNonStockResource1" /></label>
                                                </div>
                                                <div class="one wide field">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="six wide field">
                                                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H20" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Vehicle price margin</h3>
                                                    <div class="fields">
                                                        <div class="eight wide field">
                                                            <label id="lblAdvBaseMargin" runat="server">Base margin</label>
                                                            <asp:TextBox ID="txtAdvBaseMargin" runat="server" meta:resourcekey="txtTechLengthResource1" CssClass="carsInput"></asp:TextBox>
                                                        </div>
                                                        <div class="eight wide field">
                                                            <label id="lblAdvFranchiseMargin" runat="server">Franchise margin</label>
                                                            <asp:TextBox ID="txtAdvFranchiseMargin" runat="server" meta:resourcekey="txtTechWidthResource1" CssClass="carsInput"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="ten wide field">
                                                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H21" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Calculation on update</h3>

                                                    <div class="fields">
                                                        <div class="four wide field">
                                                            <label id="lblFreightPerBelow" runat="server">Frakt %</label>
                                                            <asp:TextBox ID="txtFreightPerBelow" runat="server" CssClass="carsInput" data-submit="FREIGHT_PERC_BELOW"></asp:TextBox>
                                                        </div>
                                                        <div class="four wide field">
                                                            <label id="lblFreightLimit" runat="server">Frakt > Kr.</label>
                                                            <asp:TextBox ID="txtFreightLimit" runat="server" CssClass="carsInput" data-submit="FREIGHT_LIMIT"></asp:TextBox>
                                                        </div>
                                                        <%--<div class="four wide field">
                                                            <label id="lblRoundMin" runat="server">Time %</label>
                                                            <asp:TextBox ID="txtTechRoundperMin" runat="server" meta:resourcekey="txtTechRoundperMinResource1" CssClass="carsInput"></asp:TextBox>
                                                        </div>--%>
                                                        <div class="four wide field">
                                                            <label id="lblFreightPerAbove" runat="server">Frakt > Kr.%</label>
                                                            <asp:TextBox ID="txtFreightPerAbove" runat="server" CssClass="carsInput" data-submit="FREIGHT_PERC_ABOVE"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <h3 id="interiorData" class="ui top attached tiny header" runat="server">Diverse:</h3>
                                        <div class="ui attached segment">

                                            <div class="ui form">
                                                <div class="fields">
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="ui bottom attached tab segment" data-tab="third">
                        <div id="tabDiscount" class="tTab">

                            <div class="inline fields">
                                <div class="ten wide field">
                                    <div class="ui blue label" style="min-width: 120px; text-align: center">
                                        Bestillingstype                                            
                                    </div>

                                    <select class="ui dropdown" id="dropdown_modal_ordertype">
                                        <option value="0"></option>

                                    </select>
                                    <div id="addOrderType" class="ui mini icon top left pointing green dropdown button">
                                        <i class="plus icon"></i>
                                    </div>
                                </div>

                            </div>

                            <div class="ten wide field">
                                <h3 class="ui  attached header" style="background: #435d7d; color: aliceblue; font-family: 'Roboto', sans-serif; text-indent: 3em; padding: 0.6em; font-weight: bold; font-size: 22px; margin-top: 1em;">Rabatter
                                    <button class="ui positive button right floated" id="btnAddDiscountCode" type="button">
                                        <i class="plus icon"></i>
                                        Ny rabattkode
                                    </button>
                                </h3>

                                <div id="discount-table" class="mytabulatorclass"></div>


                            </div>

                        </div>
                    </div>
                <div class="ui bottom attached tab segment" data-tab="fourth">
                    <div id="tabPriceFile" class="tTab">

                        <div class="ui grid">
                            <div class="thirteen wide column">
                                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <div class="ImportPriceFile">                                       
                                        <div class="ui grid">
                                            <div class="six wide column">
                                                <div class="ui form">

                                                    <dx:ASPxCallbackPanel ID="cbSparePartGroup" ClientInstanceName="cbSparePartGroup" OnCallback="cbSparePartGroup_Callback" ClientSideEvents-EndCallback="cbSparePartGroupEndCallback" runat="server">
                                                        <PanelCollection>
                                                            <dx:PanelContent>
                                                                <div class="inline fields">
                                                                    <div class="six wide field">
                                                                        <asp:Label ID="lblSparePartGroup" runat="server" Text="Varegruppe" meta:resourcekey="lblSparePartGroupResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="eight wide field">
                                                                        <%--<asp:DropDownList ID="ddlSparePartGroup" runat="server" class="carsInput" meta:resourcekey="ddlSparePartGroupResource1"></asp:DropDownList>--%>
                                                                        <dx:ASPxComboBox ID="ddlSparePartGroup" ClientInstanceName="ddlSparePartGroup" CssClass="customComboBox" Theme="Metropolis" runat="server" Width="100%" meta:resourcekey="ddlSparePartGroupResource1">
                                                                            <ClientSideEvents DropDown="ValidateSupCurrNoEmpty"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <dx:ASPxLoadingPanel ID="LoadingPanel" runat="server" ClientInstanceName="LoadingPanel" Modal="True"></dx:ASPxLoadingPanel>
                                                    <div class="inline fields">
                                                        <div class="six wide field">
                                                            <asp:Label ID="lblPerBasicPrice" runat="server" Text="Påslag % for basis pris" meta:resourcekey="lblPerBasicPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="eight wide field">
                                                            <div class="ui input">
                                                                <asp:TextBox ID="txtPerBasicPrice" runat="server" CssClass="customComboBox" meta:resourcekey="txtPerBasicPriceResource1"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="inline fields">
                                                        <div class="six wide field">
                                                            <asp:Label ID="lblPerCostPrice" runat="server" Text="Påslag % for kostpris" meta:resourcekey="lblPerCostPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="eight wide field">
                                                            <div class="ui input">
                                                                <asp:TextBox ID="txtPerCostPrice" runat="server" CssClass="customComboBox" meta:resourcekey="txtPerCostPriceResource1"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="inline fields">
                                                        <div class="six wide field">
                                                            <asp:Label ID="lblPerNetPrice" runat="server" Text="Påslag % for nettopris" meta:resourcekey="lblPerNetPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="eight wide field">
                                                            <div class="ui input">
                                                                <asp:TextBox ID="txtPerNetPrice" runat="server" CssClass="customComboBox" meta:resourcekey="txtPerNetPriceResource1"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="inline fields">
                                                        <div class="six wide field">
                                                            <asp:Label ID="lblPerSalesPrice" runat="server" Text="Påslag % for salgspris" meta:resourcekey="lblPerSalesPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="eight wide field">
                                                            <div class="ui input">
                                                                <asp:TextBox ID="txtPerSellPrice" runat="server" CssClass="customComboBox" meta:resourcekey="txtPerSalesPriceResource1"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="inline fields">
                                                        <div class="four wide field"></div>
                                                        <div class="four wide field">
                                                            <input type="button" id="btnImport" runat="server" onclick="OnbtnImportClick()" class="ui button blue" value="Import" />
                                                        </div>
                                                        <div class="two wide field"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="five wide column">
                                                <div class="ui form">
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui radio checkbox">
                                                                <asp:RadioButton ID="rbNoCreateGlobalSprPrt" runat="server" Text="Ingen generering/oppdatering av Non-stock " GroupName="r1" meta:resourcekey="rbCreateGlobalSprPrtResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui radio checkbox">
                                                                <asp:RadioButton ID="rbDeleteGlobalSprPrt" runat="server" Text="Generer non-stock kartotek på ny " GroupName="r1" meta:resourcekey="rbDeleteGlobalSprPrtResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui radio checkbox">
                                                                <asp:RadioButton ID="rbUpdateGlobalSprPrt" runat="server" Checked="true" Text="Oppdatere Non-stock kartotek" GroupName="r1" meta:resourcekey="rbUpdateGlobalSprPrtResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="chkUpdateTechDocNo" runat="server" Text="Oppdater TechDoc nr" Enabled="false" meta:resourcekey="chkUpdateTechDocNoResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="chkConvertSprPrt" runat="server" Text="Konverter varenr" Enabled="false" meta:resourcekey="chkConvertSprPrtResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="chkUpdateLocalSprPrt" runat="server" Text="Oppdater eget varelager" meta:resourcekey="chkUpdateLocalSprPrtResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="chkUpdateSprJobPackage" runat="server" Text="Oppdater operasjoner" meta:resourcekey="chkUpdateSprJobPackageResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="fields">
                                                        <div class="five wide column">
                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="chkUpdateReplacementNo" runat="server" Enabled="false" Text="Oppdater erstatninger" meta:resourcekey="chkUpdateReplacementNoResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="three wide column">
                                                <div class="four wide field">                                                   
                                                    <div id="externalDropZone" class="dropZoneExternal">
                                                        <div id="dragZone">
                                                            <span class="dragZoneText"><%=GetLocalResourceObject("spnDragFile")%></span>
                                                        </div>
                                                        <div id="dropZone" class="hidden">
                                                            <span class="dropZoneText"><%=GetLocalResourceObject("spnDropFile")%></span>
                                                        </div>
                                                    </div>
                                                    <div class="uploadContainer">
                                                        <dx:ASPxUploadControl ID="UploadControl" UploadMode="Advanced" AutoStartUpload="true" ClientInstanceName="UploadControl" OnFileUploadComplete="UploadControl_FileUploadComplete" runat="server" Width="100%" ShowProgressPanel="True" DialogTriggerID="externalDropZone" meta:resourcekey="UploadControlResource1">
                                                            <AdvancedModeSettings EnableFileList="true" EnableDragAndDrop="true" EnableMultiSelect="false" ExternalDropZoneID="externalDropZone" />
                                                            <ValidationSettings AllowedFileExtensions=".txt" ErrorStyle-CssClass="validationMessage" />
                                                            <BrowseButton Text="Select a file for upload" />
                                                            <DropZoneStyle CssClass="uploadControlDropZone" />                                                            
                                                            <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                                        </dx:ASPxUploadControl>
                                                    </div>
                                                    <div>
                                                        <dx:ASPxLabel ID="lblFileName" ClientInstanceName="lblFileName" runat="server" Text=""></dx:ASPxLabel>
                                                    </div>
                                                    <dx:ASPxCallbackPanel ID="cbImportClick" ClientVisible="false" ClientSideEvents-EndCallback="OncbImportClickEndCallback" runat="server"  ClientInstanceName="cbImportClick" OnCallback="cbImportClick_Callback1" Width="200px">
                                                        <%--<PanelCollection>
                                                            <dx:PanelContent>
                                                    
                                                            </dx:PanelContent>
                                                        </PanelCollection>--%>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="PriceCalculation">
                                         <div class="ui grid">
                                            <div class="ten wide column">
                                                <div class="ui form">
                                                    <div class="inline fields">
                                                        <div class="one wide fields" style="padding-right: 35%">
                                                        </div>
                                                        <div class="two wide fields">
                                                            <dx:ASPxRadioButton ID="rbCalculateGlobal"  ClientInstanceName="rbCalculateGlobal" Checked="True" ClientSideEvents-Init="OnrbCalculateGlobalInit"  Text="Kakuler bakgrunnsregister" GroupName="r2" runat="server" meta:resourcekey="rbCalculateGlobalResource1"></dx:ASPxRadioButton>
                                                        <div class="customSpace"></div>
                                                            <dx:ASPxRadioButton ID="rbCalculateLocal"   ClientInstanceName="rbCalculateLocal" ClientSideEvents-CheckedChanged="OnrbCalculateLocalCheckedChanged" Text="Kakuler lokale varer" GroupName="r2" runat="server" meta:resourcekey="rbCalculateLocalResource1"></dx:ASPxRadioButton>
                                                        </div>
                                                    </div>
                                                    <div style="display: flex;">
                                                        <div class="one wide fields"></div>
                                                        <div class="one wide fields"></div>
                                                        <div style="padding-left: 40%;"></div>
                                                        <div style="width: 180%">
                                                            <dx:ASPxLabel ID="lblFrom" runat="server" Text="Fra" meta:resourcekey="lblFromResource1"></dx:ASPxLabel>
                                                        </div>
                                                            <div>
                                                            <dx:ASPxLabel ID="lblTo" runat="server" Text="Til" meta:resourcekey="lblToResource1"></dx:ASPxLabel>
                                                        </div>
                                                        <div class="one wide fields"></div>
                                                    </div>
                                                    <dx:ASPxTextBox ID="hdnSuppCurNo" ClientInstanceName="hdnSuppCurNo" ClientVisible="false" runat="server" ></dx:ASPxTextBox>
                                                    <dx:ASPxTextBox ID="hdnSupplierID" ClientInstanceName="hdnSupplierID" ClientVisible="false" runat="server"></dx:ASPxTextBox>
                                                    <dx:ASPxCallbackPanel ID="cbWareHouse" ClientInstanceName="cbWareHouse" OnCallback="cbPriceCalculation_Callback" runat="server" meta:resourcekey="cbWareHouseResource1">
                                                        <PanelCollection>
                                                            <dx:PanelContent meta:resourcekey="PanelContentResource1">
                                                                <div class="inline fields">
                                                                    <div class="one wide fields"></div>
                                                                    <div class="one wide fields">
                                                                        <asp:Label ID="lblWarehouse" runat="server" Text="Lagersted" meta:resourcekey="lblWarehouseResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="one wide fields">                                                                        
                                                                        <dx:ASPxComboBox ID="ddlWarehouseFrom" OnInit="ddlWarehouseFrom_Init1" ClientInstanceName="ddlWarehouseFrom" CssClass="customComboBox" Theme="Metropolis" runat="server" ClientSideEvents-SelectedIndexChanged="OnddlWarehouseFromChange" ValueType="System.String" meta:resourcekey="ddlWarehouseFromResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OnddlWarehouseFromChange" DropDown="ValidateSupCurrNoEmpty"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>                                                                       

                                                                    <div class="customSpace"></div>
                                                                        <dx:ASPxComboBox ID="ddlWarehouseTo" CssClass="customComboBox" Theme="Metropolis" ClientInstanceName="ddlWarehouseTo" runat="server" class="carsInput" ClientSideEvents-SelectedIndexChanged="OnddlWarehouseToChange" ValueType="System.String" meta:resourcekey="ddlWarehouseToResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OnddlWarehouseToChange" DropDown="ValidateSupCurrNoEmpty"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>                                                                        
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <div class="inline fields">
                                                        <div class="one wide fields"></div>
                                                        <div class="one wide fields">
                                                            <asp:Label ID="lblMake" runat="server" Visible="False" Text="Fabrikat" meta:resourcekey="lblMakeResource1"></asp:Label>
                                                        </div>
                                                        <div class="one wide fields">
                                                            <asp:DropDownList ID="ddlMake" runat="server" Visible="False" class="carsInput" meta:resourcekey="ddlMakeResource1"></asp:DropDownList>

                                                        </div>
                                                    </div>
                                                    <dx:ASPxCallbackPanel ID="cbCategoryLoad" ClientInstanceName="cbCategoryLoad" ClientSideEvents-EndCallback="OncbCategoryLoadEndCallback" OnCallback="cbCategoryLoad_Callback" runat="server" meta:resourcekey="cbCategoryLoadResource1">
                                                        <ClientSideEvents EndCallback="OncbCategoryLoadEndCallback"></ClientSideEvents>
                                                        <PanelCollection>
                                                            <dx:PanelContent meta:resourcekey="PanelContentResource2">
                                                                <div class="inline fields">
                                                                    <div class="one wide fields"></div>
                                                                    <div class="one wide fields">
                                                                        <asp:Label ID="lblCategory" runat="server" Text="Varegruppe" meta:resourcekey="lblCategoryResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="one wide fields">                                                                        
                                                                        <dx:ASPxComboBox ID="ddlCatFrom" CssClass="customComboBox" Theme="Metropolis" ClientSideEvents-DropDown="ValidateSupCurrNoEmpty" OnInit="ddlCatFrom_Init" ClientInstanceName="ddlCatFrom" ClientSideEvents-SelectedIndexChanged="OnddlCategoryFromChange" class="carsInput" runat="server" meta:resourcekey="ddlCatFromResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OnddlCategoryFromChange"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>
                                                                        <div class="customSpace"></div>
                                                                        <dx:ASPxComboBox ID="ddlCatTo" CssClass="customComboBox" Theme="Metropolis" ClientSideEvents-DropDown="ValidateSupCurrNoEmpty" ClientInstanceName="ddlCatTo" ClientSideEvents-SelectedIndexChanged="OnddlCategoryToChange" class="carsInput" runat="server" meta:resourcekey="ddlCatToResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OnddlCategoryToChange"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>                                                                        
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <dx:ASPxCallbackPanel ID="cbPartNoLoad" ClientInstanceName="cbPartNoLoad" ClientSideEvents-EndCallback="OncbPartNoLoadEndCallback" OnCallback="cbPartNoLoad_Callback" runat="server" meta:resourcekey="cbPartNoLoadResource1">
                                                        <PanelCollection>
                                                            <dx:PanelContent meta:resourcekey="PanelContentResource3">
                                                                <div class="inline fields">
                                                                    <div class="one wide fields"></div>
                                                                    <div class="one wide fields">
                                                                        <asp:Label ID="lblPartNo" runat="server" Text="Delenr" meta:resourcekey="lblPartNoResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="one wide fields">
                                                                        <div class="ui input">
                                                                            <dx:ASPxTextBox ID="txtPartNoFrom" CssClass="customComboBox" ClientInstanceName="txtPartNoFrom" ClientSideEvents-LostFocus="OntxtPartNoFromLostFocus" runat="server" meta:resourcekey="txtPartNoFromResource1">
                                                                                <ClientSideEvents LostFocus="OntxtPartNoFromLostFocus" UserInput="OntxtPartNoFromInit"></ClientSideEvents>
                                                                            </dx:ASPxTextBox>                                                                            
                                                                        </div>
                                                                        <div class="customSpace"></div>
                                                                        <div class="ui input">
                                                                            <dx:ASPxTextBox ID="txtPartNoTo" ClientInstanceName="txtPartNoTo" ClientSideEvents-TextChanged="OntxtPartNoToTextChanged" ClientSideEvents-UserInput="OntxtPartNoFromInit" CssClass="customComboBox" runat="server" meta:resourcekey="txtPartNoToResource1"></dx:ASPxTextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <dx:ASPxCallbackPanel ID="cbClassCode" ClientInstanceName="cbClassCode" ClientSideEvents-EndCallback="OncbClassCodeEndCallback" OnCallback="cbClassCode_Callback" runat="server" meta:resourcekey="cbClassCodeResource1">
                                                        <ClientSideEvents EndCallback="OncbClassCodeEndCallback"></ClientSideEvents>
                                                        <PanelCollection>
                                                            <dx:PanelContent meta:resourcekey="PanelContentResource4">
                                                                <div class="inline fields">
                                                                    <div class="one wide fields"></div>
                                                                    <div class="one wide fields">
                                                                        <asp:Label ID="lblClassCode" runat="server" Text="Klasse" meta:resourcekey="lblClassCodeResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="one wide fields">
                                                                        <dx:ASPxComboBox ID="ddlClassCodeFrom" ClientInstanceName="ddlClassCodeFrom" runat="server" CssClass="customComboBox" Theme="Metropolis" ClientSideEvents-SelectedIndexChanged="OnddlClassCodeFromChange" meta:resourcekey="ddlClassCodeFromResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OnddlClassCodeFromChange"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>
                                                                        
                                                                        <div class="customSpace"></div>
                                                                        
                                                                        <dx:ASPxComboBox ID="ddlClassCodeTo" ClientInstanceName="ddlClassCodeTo" runat="server" CssClass="customComboBox" Theme="Metropolis" ValueType="System.String" meta:resourcekey="ddlClassCodeToResource1"></dx:ASPxComboBox>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <dx:ASPxCallbackPanel ID="cbLocation" ClientInstanceName="cbLocation" ClientSideEvents-EndCallback="OncbLocationEndCallback" OnCallback="cbLocation_Callback" runat="server" meta:resourcekey="cbLocationResource1">
                                                        <ClientSideEvents EndCallback="OncbLocationEndCallback"></ClientSideEvents>
                                                        <PanelCollection>
                                                            <dx:PanelContent meta:resourcekey="PanelContentResource5">
                                                                <div class="inline fields">
                                                                    <div class="one wide fields"></div>
                                                                    <div class="one wide fields">
                                                                        <asp:Label ID="lblLocation" runat="server" Text="Lokasjon" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="one wide fields">
                                                                        
                                                                        <dx:ASPxComboBox ID="ddlLocationFrom" ClientInstanceName="ddlLocationFrom" ClientSideEvents-SelectedIndexChanged="OnddlLocationFromChange" runat="server" CssClass="customComboBox" Theme="Metropolis" ValueType="System.String" meta:resourcekey="ddlLocationFromResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OnddlLocationFromChange"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>
                                                                        <div class="customSpace"></div>
                                                                        
                                                                        <dx:ASPxComboBox ID="ddlLocationTo" ClientInstanceName="ddlLocationTo" runat="server" CssClass="customComboBox" Theme="Metropolis" ValueType="System.String" meta:resourcekey="ddlLocationToResource1"></dx:ASPxComboBox>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <dx:ASPxCallbackPanel ID="cbDiscountCode" ClientInstanceName="cbDiscountCode" ClientSideEvents-EndCallback="OncbDiscountCodeEndCallback" OnCallback="cbDiscountCode_Callback" runat="server" meta:resourcekey="cbDiscountCodeResource1">
                                                        <PanelCollection>
                                                            <dx:PanelContent meta:resourcekey="PanelContentResource6">
                                                                <div class="inline fields">
                                                                    <div class="one wide fields"></div>
                                                                    <div class="one wide fields">
                                                                        <asp:Label ID="lblDiscountCode" runat="server" Text="Rabattkode(kjøp)" meta:resourcekey="lblDiscountCodeResource1"></asp:Label>
                                                                    </div>
                                                                    <div class="one wide fields">
                                                                       
                                                                        <dx:ASPxComboBox ID="ddlDiscountCodeFrom" ClientInstanceName="ddlDiscountCodeFrom" ClientSideEvents-SelectedIndexChanged="OnddlDiscountCodeFromChange" runat="server" CssClass="customComboBox" Theme="Metropolis" ValueType="System.String" meta:resourcekey="ddlDiscountCodeFromResource1">
                                                                            <ClientSideEvents SelectedIndexChanged="OnddlDiscountCodeFromChange"></ClientSideEvents>
                                                                        </dx:ASPxComboBox>
                                                                        <div class="customSpace"></div>
                                                                        
                                                                        <dx:ASPxComboBox ID="ddlDiscountCodeTo" ClientInstanceName="ddlDiscountCodeTo" runat="server" CssClass="customComboBox" Theme="Metropolis" ValueType="System.String" meta:resourcekey="ddlDiscountCodeToResource1"></dx:ASPxComboBox>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <%--Basic Price--%>
                                                    <div class="inline fields">
                                                        <div class="one wide fields"></div>
                                                        <div class="one wide fields">
                                                            <asp:Label ID="lblBasicPrice" runat="server" Text="Veil.Pris" meta:resourcekey="lblBasicPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="one wide fields">
                                                            <div class="ui input">
                                                                <dx:ASPxTextBox ID="txtBasicPrice" ClientInstanceName="txtBasicPrice" CssClass="customComboBox" runat="server" meta:resourcekey="txtBasicPriceResource1"></dx:ASPxTextBox>
                                                            </div>
                                                            <div class="customSpace"></div>
                                                            <div style="width: 168px">
                                                               </div>
                                                        </div>
                                                    </div>
                                                    <%--Cost Price --%>
                                                    <div class="inline fields">
                                                        <div class="one wide fields"></div>
                                                        <div class="one wide fields">
                                                            <asp:Label ID="lblCostPrice" runat="server" Text="kostpris økning" meta:resourcekey="lblCostPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="one wide fields">
                                                            <div class="ui input">
                                                                <dx:ASPxTextBox ID="txtCostPrice" ClientInstanceName="txtCostPrice" CssClass="customComboBox" runat="server" meta:resourcekey="txtCostPriceResource1"></dx:ASPxTextBox>
                                                            </div>
                                                            <div class="customSpace"></div>
                                                            <div style="width: 168px"></div>
                                                        </div>
                                                    </div>
                                                    <%--Net Price --%>
                                                    <div class="inline fields">
                                                        <div class="one wide fields"></div>
                                                        <div class="one wide fields">
                                                            <asp:Label ID="lblNetPrice" runat="server" Text="nettpris økning" meta:resourcekey="lblNetPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="one wide fields">
                                                            <div class="ui input">
                                                                <dx:ASPxTextBox ID="txtNetPrice" ClientInstanceName="txtNetPrice" CssClass="customComboBox" runat="server" meta:resourcekey="txtNetPriceResource1"></dx:ASPxTextBox>
                                                            </div>
                                                            <div class="customSpace"></div>

                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="cbCorrectCostPrice" runat="server" Visible="False" Text="Korrigere kostpris" meta:resourcekey="cbCorrectCostPriceResource1" />
                                                            </div>
                                                            <div style="width: 152px"></div>
                                                        </div>
                                                    </div>
                                                    <%--Sale Price--%>
                                                    <div class="inline fields">
                                                        <div class="one wide fields"></div>
                                                        <div class="one wide fields">
                                                            <asp:Label ID="lblSellPrice" runat="server" Text="salgspris økning" meta:resourcekey="lblSellPriceResource1"></asp:Label>
                                                        </div>
                                                        <div class="one wide fields">
                                                            <div class="ui input">
                                                                <dx:ASPxTextBox ID="txtSellPrice" ClientInstanceName="txtSellPrice" CssClass="customComboBox" runat="server" meta:resourcekey="txtSellPriceResource1"></dx:ASPxTextBox>
                                                            </div>
                                                            <div class="customSpace"></div>

                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="cbCalculatedBasedOnDisMatrix" runat="server" Visible="False" Text="Kalkuler basert på rabattmatrise" meta:resourcekey="cbCalculatedBasedOnDisMatrixResource1" />
                                                            </div>
                                                            <div style="width: 152px"></div>
                                                        </div>
                                                    </div>

                                                    <div class="inline fields">
                                                        <div class="one wide fields">
                                                            
                                                        </div>
                                                        <div class="one wide fields">
                                                            
                                                            <div class="ui checkbox">
                                                                <asp:CheckBox ID="cbCalculateBlockedArticle" runat="server" Text="kalkuler sperrede artikler"  meta:resourcekey="cbCalculateBlockedArticleResource1" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <dx:ASPxCallbackPanel ID="cbStartCalculation" ClientInstanceName="cbStartCalculation" OnCallback="cbStartCalculation_Callback" runat="server" meta:resourcekey="cbStartCalculationResource1">
                                                        <PanelCollection>
                                                            <dx:PanelContent meta:resourcekey="PanelContentResource7">
                                                                <div class="inline fields">
                                                                    <div class="three wide fields"></div>
                                                                    <div class="thirteen wide field">
                                                                        <%--<asp:Label ID="lblError" runat="server" Width="400px" CssClass="lblMsg"></asp:Label>--%>
                                                                        <dx:ASPxLabel ID="lblError" ClientInstanceName="lblError" Font-Size="Small" runat="server" Text=""></dx:ASPxLabel>
                                                                    </div>
                                                                    <div class="two wide field"></div>
                                                                </div>
                                                                <div class="inline fields">
                                                                    <div class="one wide fields"></div>
                                                                    <div class="four wide field"></div>
                                                                    <div class="five wide field">
                                                                        <input type="button" id="btnStartCalculation" onclick="StartCalc()" runat="server" class="ui button blue" value="Start kalkulasjon" meta:resourcekey="btnStartCalculationResource1" />
                                                                        &nbsp;
                                                                    </div>
                                                                    <div class="four wide field">
                                                                        <input type="button" id="btnReset" runat="server" onclick="Reset()" class="ui button blue" value="Nullstill" meta:resourcekey="btnResetResource1" />
                                                                        &nbsp;
                                                                    </div>
                                                                    <div class="two wide field"></div>
                                                                </div>

                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                            <div class="one wide column"></div>
                                            <div class="four wide column">
                                                <div class="ui form">
                                                    <div class="inline fields"></div>
                                                    <div class="inline fields"></div>
                                                    <div class="inline fields"></div>
                                                    <div class="radioButtonGroup">
                                                        <div class="inline fields">
                                                            <div class="three wide fields">

                                                              <%--  <div class="ui radio checkbox">--%>
                                                                    <dx:ASPxRadioButton ID="rbRounding" ClientInstanceName="rbRounding" Text="Avrunding" ClientSideEvents-CheckedChanged="OnrbRoundingCheckChanged" GroupName="r3" runat="server" meta:resourcekey="rbRoundingResource1" ></dx:ASPxRadioButton>
                                                                    <%--<asp:RadioButton ID="rbRounding" runat="server" Text="Avrunding" onclick="OnrbRoundingClick()" GroupName="r3" meta:resourcekey="rbRoundingResource1" />--%>
                                                               <%-- </div>--%>

                                                                <div class="customSpace"></div>

                                                               <%-- <div class="ui radio checkbox">--%>
                                                                <dx:ASPxRadioButton ID="rbPriceAdjustment" ClientInstanceName="rbPriceAdjustment" ClientSideEvents-Init="OnrbPriceAdjustmentInit" Checked="True" runat="server"  ClientSideEvents-CheckedChanged="OnrbPriceAdjustmentCheckChanged"  Text="Prisjustering" GroupName="r3" meta:resourcekey="rbPriceAdjustmentResource1"></dx:ASPxRadioButton>
                                                                    <%--<asp:RadioButton ID="rbPriceAdjustment" runat="server" Checked="True" onclick="OnrbPriceAdjustmentClick()" Text="Prisjustering" GroupName="r3" meta:resourcekey="rbPriceAdjustmentResource1" />--%>
                                                               <%-- </div>--%>

                                                            </div>
                                                        </div>
                                                        <div class="inline fields">

                                                            <div class="three wide fields">
                                                                
                                                              <%--  <div class="ui radio checkbox">--%>
                                                                    <dx:ASPxRadioButton ID="rbRoundingToClosest50"  ClientInstanceName="rbRoundingToClosest50" Text="Avrund til nærmeste 50 øre" GroupName="r4" meta:resourcekey="rbRoundingToClosest50Resource1" runat="server"></dx:ASPxRadioButton>
                                                                    <%--<asp:RadioButton ID="rbRoundingToClosest50" runat="server" Text="Avrund til nærmeste 50 øre" GroupName="r4" meta:resourcekey="rbRoundingToClosest50Resource1" />--%>
                                                                <%--</div>--%>

                                                            </div>
                                                        </div>
                                                        <div class="inline fields">

                                                            <div class="three wide fields">
                                                                <%--<div class="ui radio checkbox">--%>
                                                                    <dx:ASPxRadioButton ID="rbRoundToClosestInt" ClientInstanceName="rbRoundToClosestInt" runat="server" Text="Avrund til nærmeste hele krone" GroupName="r4" meta:resourcekey="rbRoundToClosestIntResource1"></dx:ASPxRadioButton>
                                                                    <%--<asp:RadioButton ID="rbRoundToClosestInt" runat="server" Text="Avrund til nærmeste hele krone" GroupName="r4" meta:resourcekey="rbRoundToClosestIntResource1" />--%>
                                                                <%--</div>--%>

                                                            </div>
                                                        </div>
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
                                    <h3 id="H10" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Velg fra listen</h3>
                                    <div class="fields">
                                        <button type="button" id="btnGen2" class="ui button carsButtonBlueInverted wide">Price Calculation</button>
                                    </div>
                                    <div class="fields">
                                        <button type="button" id="btnGen1" class="ui button carsButtonBlueNotInverted wide">Import Price File</button>
                                    </div>
                                    <%--</div>--%>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                
            </div>
        </div>
    </div>






    <%--                    ############################### BOTTOM ##########################################--%>
    <div id="tabBottom">
        <div class="ui divider"></div>
        <div class="ui grid">
            <div class="sixteen wide column">
                <div class="ui form">
                    <div class="ui huge basic icon buttons">
                        <button class="ui inverted green button " title="Lagre" id="btnSupSave" type="button" ><i class="save icon "></i></button>
                        <button class="ui inverted red button " title="Tøm" id="btnSupEmptyScreen" type="button" ><i class="cancel icon "></i></button>
                        <button class="ui inverted primary button " title="Ny leverandør" id="btnSupNewSupplier" type="button" ><i class="upload icon "></i></button>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- Customer notes Modal --%>
    <div id="modUpdateCustTemp" class="modal hidden">
        <div class="modHeader">
            <h2 id="H9" runat="server">Customer template update</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Customer template update</label>
                    <div class="ui small info message">
                        <p id="PasswordMsg" runat="server">Write the password to update the template and click OK.</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="sixteen wide field">
                                <label for="txtPassword">
                                    <asp:Literal ID="liPassword" Text="Password" runat="server" meta:resourcekey="liPasswordResource1"></asp:Literal>
                                </label>
                                <asp:TextBox ID="txtCustTempPassword" TextMode="Password" runat="server" meta:resourcekey="txtCustTempPasswordResource1" ></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            &nbsp;
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnSaveTemplate" runat="server" class="ui btn wide" value="OK" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnCancelTemplate" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <%-- WashCustomer Modal --%>
    <div id="modWashCustomer" class="ui modal">
        <i class="close icon"></i>
        <div class="header">
            Wash Customer
        </div>
        <div class="content">
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="inline fields">
                            <div class="four wide field">
                                 &nbsp;
                            </div>
                            <div class="five wide field">
                                Local data
                            </div>
                            <div class="five wide field">
                                Eniro data
                            </div>
                            <div class="two wide field">
                                Oppdatere?
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label><asp:Label ID="lblWashLastName" Text="Last name/ Subsidiary" runat="server" meta:resourcekey="lblWashLastNameResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalLastName" runat="server" meta:resourcekey="txtWashLocalLastNameResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroLastName" runat="server" meta:resourcekey="txtWashEniroLastNameResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <span class="ui checkbox">
                                    <asp:CheckBox ID="chkWashLastName" runat="server" meta:resourcekey="chkWashLastNameResource1"></asp:CheckBox>
                                    <label for="ctl00_cntMainPanel_chkContactType"></label>
                                </span>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label><asp:Label ID="lblWashFirstName" Text="First name" runat="server" meta:resourcekey="lblWashFirstNameResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalFirstName" runat="server" meta:resourcekey="txtWashLocalFirstNameResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                              <asp:TextBox ID="txtWashEniroFirstName" runat="server" meta:resourcekey="txtWashEniroFirstNameResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashFirstName" runat="server" meta:resourcekey="chkWashFirstNameResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashMiddleName" Text="Middle name" runat="server" meta:resourcekey="lblWashMiddleNameResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                               <asp:TextBox ID="txtWashLocalMiddleName" runat="server" meta:resourcekey="txtWashLocalMiddleNameResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                            <asp:TextBox ID="txtWashEniroMiddleName" runat="server" meta:resourcekey="txtWashEniroMiddleNameResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashMiddleName" runat="server" meta:resourcekey="chkWashMiddleNameResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashVisitAdress" Text="Visit address" runat="server" meta:resourcekey="lblWashVisitAdressResource1"></asp:Label></label>
                               <label></label>
                            </div>
                            <div class="five wide field">
                               <asp:TextBox ID="txtWashLocalVisitAddress" runat="server" meta:resourcekey="txtWashLocalVisitAddressResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                              <asp:TextBox ID="txtWashEniroVisitAddress" runat="server" meta:resourcekey="txtWashEniroVisitAddressResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashVisitAddress" runat="server" meta:resourcekey="chkWashVisitAddressResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashBillAddress" Text="Bill address" runat="server" meta:resourcekey="lblWashBillAddressResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalBillAddress" runat="server" meta:resourcekey="txtWashLocalBillAddressResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                            <asp:TextBox ID="txtWashEniroBillAddress" runat="server" meta:resourcekey="txtWashEniroBillAddressResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashBillAddress" runat="server" meta:resourcekey="chkWashBillAddressResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashZipCode" Text="Postnr" runat="server" meta:resourcekey="lblWashZipCodeResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalZipCode" runat="server" meta:resourcekey="txtWashLocalZipCodeResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                            <asp:TextBox ID="txtWashEniroZipCode" runat="server" meta:resourcekey="txtWashEniroZipCodeResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashZipCode" runat="server" meta:resourcekey="chkWashZipCodeResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashZipPlace" Text="Sted" runat="server" meta:resourcekey="lblWashZipPlaceResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalZipPlace" runat="server" meta:resourcekey="txtWashLocalZipPlaceResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                              <asp:TextBox ID="txtWashEniroZipPlace" runat="server" meta:resourcekey="txtWashEniroZipPlaceResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashZipPlace" runat="server" meta:resourcekey="chkWashZipPlaceResource1"></asp:CheckBox>
                            </div>
                        </div>

                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashPhone" Text="Telefon" runat="server" meta:resourcekey="lblWashPhoneResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalPhone" runat="server" meta:resourcekey="txtWashLocalPhoneResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                            <asp:TextBox ID="txtWashEniroPhone" runat="server" meta:resourcekey="txtWashEniroPhoneResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashPhone" runat="server" meta:resourcekey="chkWashPhoneResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashMobile" Text="Mobil" runat="server" meta:resourcekey="lblWashMobileResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalMobile" runat="server" meta:resourcekey="txtWashLocalMobileResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                            <asp:TextBox ID="txtWashEniroMobile" runat="server" meta:resourcekey="txtWashEniroMobileResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashMobile" runat="server" meta:resourcekey="chkWashMobileResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashBorn" Text="Born" runat="server" meta:resourcekey="lblWashBornResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalBorn" runat="server" meta:resourcekey="txtWashLocalBornResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                            <asp:TextBox ID="txtWashEniroBorn" runat="server" meta:resourcekey="txtWashEniroBornResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashBorn" runat="server" meta:resourcekey="chkWashBornResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                               <label><asp:Label ID="lblWashSsnNo" Text="SSN No" runat="server" meta:resourcekey="lblWashSsnNoResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalSsnNo" runat="server" meta:resourcekey="txtWashLocalSsnNoResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                            <asp:TextBox ID="txtWashEniroSsnNo" runat="server" meta:resourcekey="txtWashEniroSsnNoResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashSsnNo" runat="server" meta:resourcekey="chkWashSsnNoResource1"></asp:CheckBox>
                            </div>
                        </div>
                </div>
            </div>
        </div>

    </div>
    <div class="actions">
        <div class="ui button ok positive">Oppdater</div>
        <div class="ui button cancel negative">Avbryt</div>
    </div>
    </div>



    <%-- Customer notes Modal --%>
    <div id="modCustNotes" class="modal hidden">
        <div class="modHeader">
            <h2 id="H8" runat="server">Notat</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Notat</label>
                    <div class="ui small info message">
                        <p id="P1" runat="server">Legg inn notater på leverandøren.</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="sixteen wide field">
                                <label for="txtNotes">
                                    <asp:Literal ID="liNotes" Text="Notes" runat="server" meta:resourcekey="liNotesResource1"></asp:Literal>
                                </label>
                                <asp:TextBox runat="server" ID="txtNotes" TextMode="MultiLine" CssClass="texttest" Height="181px" data-submit="CUST_NOTES" meta:resourcekey="txtNotesResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            &nbsp;
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnCustNotesSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnCustNotesCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Salesman Modal --%>
    <div id="modAdvSalesman" class="modal hidden">
        <div class="modHeader">
            <h2 id="lblAdvSalesman" runat="server">Salesman</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Nytt kjøretøy</label>
                    <div class="ui small info message">
                        <p id="lblAdvSalesmanStatus" runat="server">Salesman status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblNewUsed" runat="server">New/Used*</label>
                                <select id="drpSalesman" runat="server" size="13" class="wide dropdownList"></select>
                                <%--<select id="ddlSalesman" runat="server" size="13" class="wide dropdownList">
                                    
                                    <option value="11" id="ddlItemCommisionUsed">Kommisjon brukt</option>
                                    <option value="12" id="ddlItemCommissionNew">Kommisjon ny</option>
                                </select>--%>
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanCode" Text="Kode" runat="server" meta:resourcekey="lblAdvSalesmanCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanLogin" runat="server" meta:resourcekey="txtAdvSalesmanLoginResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanFname" Text="First name" runat="server" meta:resourcekey="lblAdvSalesmanFnameResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanFname" runat="server" meta:resourcekey="txtAdvSalesmanFnameResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanLname" Text="Last name" runat="server" meta:resourcekey="lblAdvSalesmanLnameResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanLname" runat="server" meta:resourcekey="txtAdvSalesmanLnameResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanDept" Text="Department" runat="server" meta:resourcekey="lblAdvSalesmanDeptResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanDept" runat="server" meta:resourcekey="txtAdvSalesmanDeptResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanPassword" Text="Password" runat="server" meta:resourcekey="lblAdvSalesmanPasswordResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanPassword" runat="server" meta:resourcekey="txtAdvSalesmanPasswordResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanPhone" Text="Telefon" runat="server" meta:resourcekey="lblAdvSalesmanPhoneResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanPhone" runat="server" meta:resourcekey="txtAdvSalesmanPhoneResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvSalesmanNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvSalesmanDelete" runat="server" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesmanSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesmanCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Branch Modal --%>
    <div id="modAdvBranch" class="modal hidden">
        <div class="modHeader">
            <h2 id="H2" runat="server">Branch</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Nytt yrke</label>
                    <div class="ui small info message">
                        <p id="lblAdvBranchStatus" runat="server">Yrke status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label2" runat="server">Yrke</label>
                                <select id="drpBranch" runat="server" size="10" class="wide dropdownList"></select>
                                <%--<select id="Select1" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemBranch">bransjeliste</option>
                                    
                                </select>--%>
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchCode" Text="Kode" runat="server" meta:resourcekey="lblAdvBranchCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchCode" runat="server" meta:resourcekey="txtAdvBranchCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchText" Text="Tekst" runat="server" meta:resourcekey="lblAdvBranchTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchText" runat="server" meta:resourcekey="txtAdvBranchTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchNote" Text="Merk" runat="server" meta:resourcekey="lblAdvBranchNoteResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchNote" runat="server" meta:resourcekey="txtAdvBranchNoteResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchRef" Text="Referanse" runat="server" meta:resourcekey="lblAdvBranchRefResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchRef" runat="server" meta:resourcekey="txtAdvBranchRefResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvBranchNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvBranchDelete" runat="server" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvBranchSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvBranchCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Category Modal --%>
    <div id="modAdvCategory" class="modal hidden">
        <div class="modHeader">
            <h2 id="H3" runat="server">Category</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Ny kategori</label>
                    <div class="ui small info message">
                        <p id="lblAdvCategoryStatus" runat="server">Kategori status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label4" runat="server">Category list</label>
                                <select id="drpAdvCategory" runat="server" size="10" class="wide dropdownList"></select>
                                <%--<select id="Select2" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemCategory">God kunde</option>
                                </select>--%>
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryCode" Text="Kode" runat="server" meta:resourcekey="lblAdvCategoryCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryCode" runat="server" meta:resourcekey="txtAdvCategoryCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryText" Text="Tekst" runat="server" meta:resourcekey="lblAdvCategoryTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryText" runat="server" meta:resourcekey="txtAdvCategoryTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryNote" Text="Merk" runat="server" meta:resourcekey="lblAdvCategoryNoteResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryNote" runat="server" meta:resourcekey="txtAdvCategoryNoteResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryRef" Text="Referanse" runat="server" meta:resourcekey="lblAdvCategoryRefResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryRef" runat="server" meta:resourcekey="txtAdvCategoryRefResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvCategoryNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvCategoryDelete" runat="server" class="ui btn wide" value="Slett" />

                                    </div>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCategorySave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCategoryCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Salesgroup Modal --%>
    <div id="modAdvSalesGroup" class="modal hidden">
        <div class="modHeader">
            <h2 id="H4" runat="server">Sales group</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Salgsgruppe</label>
                    <div class="ui small info message">
                        <p id="lblAdvSalesGroupStatus" runat="server">Salgsgruppe status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblAdvSalesGroupList" runat="server">Sales group list</label>
                                <select id="drpAdvSalesGroup" runat="server" size="13" class="wide dropdownList"></select>
                                <%--<select id="Select3" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemSalesGroup0">10 - Salg deler</option>
                                    <option value="1" id="ddlItemSalesGroup1">20 - Salg verksted</option>
                                    <option value="2" id="ddlItemSalesGroup2">30 - Salg brukte biler</option>
                                </select>--%>
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupCode" Text="Kode" runat="server" meta:resourcekey="lblAdvSalesGroupCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupCode" runat="server" meta:resourcekey="txtAdvSalesGroupCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupText" Text="Tekst" runat="server" meta:resourcekey="lblAdvSalesGroupTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupText" runat="server" meta:resourcekey="txtAdvSalesGroupTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupInv" Text="Inv." runat="server" meta:resourcekey="lblAdvSalesGroupInvResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupInv" runat="server" meta:resourcekey="txtAdvSalesGroupInvResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupVat" Text="Fri/Pl./Utl." runat="server" meta:resourcekey="lblAdvSalesGroupVatResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupVat" runat="server" meta:resourcekey="txtAdvSalesGroupVatResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvSalesGroupNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>

                                    <div class="field">
                                        <input type="button" id="btnAdvSalesGroupDelete" runat="server" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesGroupSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesGroupCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Payment Terms Modal --%>
    <div id="modAdvPaymentTerms" class="modal hidden">
        <div class="modHeader">
            <h2 id="H5" runat="server">Payment terms</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Bet.betingelser</label>
                    <div class="ui small info message">
                        <p id="lblAdvPayTermsStatus" runat="server">Bet.betingelser status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label5" runat="server">Payment terms</label>
                                <select id="drpAdvPaymentTerms" runat="server" size="13" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvPayTermsCode" Text="Kode" runat="server" meta:resourcekey="lblAdvPayTermsCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvPayTermsCode" runat="server" meta:resourcekey="txtAdvPayTermsCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvPayTermsText" Text="Tekst" runat="server" meta:resourcekey="lblAdvPayTermsTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvPayTermsText" runat="server" meta:resourcekey="txtAdvPayTermsTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvPayTermsDays" Text="Dager" runat="server" meta:resourcekey="lblAdvPayTermsDaysResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvPayTermsDays" runat="server" meta:resourcekey="txtAdvPayTermsDaysResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvPayTermsNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvPayTermsDelete" runat="server" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvPayTermsSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvPayTermsCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Credit Card Modal --%>
    <div id="modAdvCreditCardType" class="modal hidden">
        <div class="modHeader">
            <h2 id="H6" runat="server">Credit card type</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Credit card type</label>
                    <div class="ui small info message">
                        <p id="lblAdvCreditCardStatus" runat="server">Kred.kort type status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label6" runat="server">Kred.kort type</label>
                                <select id="drpAdvCardType" runat="server" size="10" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCredCardTypeCode" Text="Kode" runat="server" meta:resourcekey="lblAdvCredCardTypeCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCredCardTypeCode" runat="server" meta:resourcekey="txtAdvCredCardTypeCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCredCardTypeText" Text="Tekst" runat="server" meta:resourcekey="lblAdvCredCardTypeTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCredCardTypeText" runat="server" meta:resourcekey="txtAdvCredCardTypeTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCredCardTypeCustNo" Text="Kundenr" runat="server" meta:resourcekey="lblAdvCredCardTypeCustNoResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCredCardTypeCustNo" runat="server" meta:resourcekey="txtAdvCredCardTypeCustNoResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">

                                    <div class="field">
                                        <input type="button" id="btnAdvCredCardTypeNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvCredCardTypeDelete" runat="server" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCredCardTypeSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCredCardTypeCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Currency Code Modal --%>
    <div id="modAdvCurrencyCode" class="modal hidden">
        <div class="modHeader">
            <h2 id="H7" runat="server">Currency code</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Currency code</label>
                    <div class="ui small info message">
                        <p id="lblAdvCurrencyStatus" runat="server">Valutakode status</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label7" runat="server">Kred.kort type</label>
                                <select id="drpAdvCurrencyType" runat="server" size="10" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCurCodeCode" Text="Kode" runat="server" meta:resourcekey="lblAdvCurCodeCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCurCodeCode" runat="server" meta:resourcekey="txtAdvCurCodeCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCurCodeText" Text="Tekst" runat="server" meta:resourcekey="lblAdvCurCodeTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCurCodeText" runat="server" meta:resourcekey="txtAdvCurCodeTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCurCodeValue" Text="Nkr." runat="server" meta:resourcekey="lblAdvCurCodeValueResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCurCodeValue" runat="server" meta:resourcekey="txtAdvCurCodeValueResource1"></asp:TextBox>
                                </div>
                                <div class="two fields">

                                    <div class="field">
                                        <input type="button" id="btnAdvCurCodeNew" runat="server" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvCurCodeDelete" runat="server" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCurCodeSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCurCodeCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <%-- New discountCODE Modal, css descrived in cars.css --%>
    <div id="modNewDiscountCode" class="modal hidden">
        <div class="modHeader">
            <h2 id="H11" runat="server">Rabattkode</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Nytt kjøretøy</label>
                    <div class="ui small info message hidden">
                        <p id="P2" runat="server">Ordretypestatus</p>
                    </div>
                    <div class="ui success message">
                        <div class="header">Form Completed</div>
                        <p>You're all signed up for the newsletter.</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label9" runat="server">Rabattkoder</label>
                                <select id="ddlDiscountCodesModal" size="13" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>Rabattkode</label>
                                    <input type="text" id="txtbxNewDiscountCode" />
                                </div>
                                <div class="field">
                                    <label>Beskrivelse</label>
                                    <input type="text" id="txtbxNewDiscountCodeDescription" />
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnDiscountCodeNew" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnDiscountCodeDelete" class="ui btn wide" value="Slett" />
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">

                            <div class="eight wide field">
                                <div class="ui btn wide positive right labeled icon button " id="btnDiscountCodeSave">
                                    <div>Lagre</div>

                                    <i class="checkmark icon"></i>
                                </div>

                            </div>
                            <div class="eight wide field">
                                <div class="ui btn wide negative right labeled icon button" id="btnDiscountCodeCancel">
                                    <div>Avbryt</div>

                                    <i class="window close icon"></i>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
         <%-- New ordertype Modal, css descrived in cars.css --%>
    <div id="modNewOrdertype" class="modal hidden">
        <div class="modHeader">
            <h2 id="H12" runat="server">Bestillingstype</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Nytt kjøretøy</label>
                    <div class="ui small info message hidden">
                        <p id="P3" runat="server">Ordretypestatus</p>
                    </div>
                    <div class="ui success message">
                        <div class="header">Form Completed</div>
                        <p>You're all signed up for the newsletter.</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label10" runat="server">Bestillingstyper</label>
                                <select id="ddlOrdertypesModal" size="13" class="wide dropdownList"></select>
                                
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>Leverandør</label>
                                    <input type="text" id="txtbxNewOrdertypeSupplier" readonly=""/>
                                </div>
                                <div class="field">
                                    <label>Bestillingstype</label>
                                    <input type="text" id="txtbxNewOrdertypeOrdertype" />
                                </div>
                                <div class="field">
                                    <label>Beskrivelse</label>
                                    <input type="text" id="txtbxNewOrdertypeDescription" />
                                </div>


                                <div class="field">
                                <label>Pristype</label>
                                    <select name="Pristype" id="ddlNewOrdertypePricetype" style="z-index:1000 !important">
                                        <option value="0">-- Velg --</option>
                                        <option value="COST_PRICE">Kostpris</option>
                                        <option value="NET_PRICE">Nettopris</option>
                                        <option value="ITEM_PRICE">Salgspris</option>
                                        <option value="BASIC_PRICE">Basispris</option>
                                    </select>
                                    
                                </div>
                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnOrdertypeNew" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnOrdertypeDelete" class="ui btn wide" value="Slett"/>
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                         
                            <div class="eight wide field">
                                <div class="ui btn wide positive right labeled icon button " id="btnOrdertypeSave" >
                                    <div>Lagre</div>

                                    <i class="checkmark icon"></i>
                                </div>

                            </div>
                            <div class="eight wide field">
                                <div class="ui btn wide negative right labeled icon button" id="btnOrdertypeCancel">
                                    <div>Avbryt</div>

                                    <i class="window close icon"></i>

                                </div>

                            </div>
                            
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Modal for adding contact information --%>
    <div id="modContact" class="ui small modal">
        <i class="close icon"></i>
        <div class="header">
            New contact information
        </div>
        <div class="content">
            <div class="description">
                <div class="ui action input">
                    <div class="inline three field">
                    <input id="txtContactType" type="text" runat="server" />
                        <asp:DropDownList ID="drpContactType" CssClass="ui compact selection dropdown" runat="server" meta:resourcekey="drpContactTypeResource1"></asp:DropDownList>
                        <asp:CheckBox ID="chkContactType" CssClass="ui checkbox" Text="Standard?" runat="server" meta:resourcekey="chkContactTypeResource1" />
                    </div>
                </div>

            </div>
        </div>
        <div class="actions">
            <div class="ui red button cancel">
                <i class="remove icon"></i>
                Cancel
            </div>
            <div class="ui green button ok">
                <i class="checkmark icon"></i>
                Save
            </div>
        </div>
    </div>

    <div class="ui tiny modal" id="modal_new_discountcode">
        
    <div class="header" style="text-indent:5rem">Opprett ny rabatt</div>
     
        <div class="content">
            <div class="ui stackable form">
              
                    <div class="inline fields">
                        <div class="two wide field">
                        </div>

                        <div class="ten wide field">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Kode                                            
                            </div>
                            <select class="ui dropdown" id="dropdown_modal_discountcode">         
                                <option value=""></option> 
                             
                            </select>
                    
                        </div>
                        <div class="two wide field">
                            
                        </div>

                    </div>



                <div class="inline fields">
                    <div class="two wide field">
                        </div>
                        <div class="ten wide field">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Forklaring                                            
                            </div>
                            <input type="text"  id="txtbxSupplierModalx" />
                            
                        </div>
                     
                    </div>
                    <div class="inline fields">
                    <div class="two wide field">
                        </div>
                        <div class="ten wide field" style="max-width: 340px"">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Sats %                                            
                            </div>
                            <input type="text"  id="txtbxSupplierModala" />
                       </div>
                        </div>
                        <div class="inline fields">
                        <div class="two wide field">
                        </div>
                        <div class="seven wide field" style="max-width: 360px">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Resting                                            
                            </div>
                            <div class="ui checkbox">
                                <input type="checkbox" name="example">
                                <label></label>
                            </div>

                        </div>
                        </div>

                    </div>
        
        </div>
        <div class="actions">
            <div class="ui positive button">Lagre</div>          
            <div class="ui negative button">Avbryt</div>
        </div>
    </div>
</asp:Content>
 