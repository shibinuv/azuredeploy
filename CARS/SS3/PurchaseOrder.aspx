<%@ Page Language="vb" AutoEventWireup="false"  CodeBehind="PurchaseOrder.aspx.vb" Inherits="CARS.PurchaseOrder" MasterPageFile="~/MasterPage.Master" meta:resourcekey="PageResource2" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    

    


    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js"></script>
   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.0.5/jspdf.plugin.autotable.js"></script>
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.js"></script>
 
  
    <style type="text/css">
        /*.dimmed.dimmable > .ui.animating.dimmer, .dimmed.dimmable > .ui.visible.dimmer, .ui.active.dimmer {
  display: flex;
  align-items: center;
  justify-content: center;
}*/
        /*.ui.modal,
.ui.active.modal {*/
        /*margin: 0 auto!important;
  top: auto !important;
  left: auto !important;
  transform-origin: center !important;*/


        /*.ui.modal:not(.compact) {
width: calc(90% - 50px) !important;
margin-left: 25px !important;
height: calc(80% - 50px) !important;
margin-top: 25px !important;
margin-bottom: 25px !important;
}*/


        .ui.form .field.success label {
            color: #308330;
        }

        .ui.form .field.success input {
            background: #f4faf4 none repeat scroll 0 0;
            border-color: #a3c293;
            border-radius: 0.285714rem;
            box-shadow: none;
            color: #308330;
        }
        /* Success Placeholder */
        .ui.form .success ::-webkit-input-placeholder {
            color: #5e9e5e;
        }

        .ui.form .success ::-ms-input-placeholder {
            color: #5e9e5e;
        }

        .ui.form .success ::-moz-placeholder {
            color: #5e9e5e;
        }

        .ui.form .success :focus::-webkit-input-placeholder {
            color: #558e55;
        }

        .ui.form .success :focus::-ms-input-placeholder {
            color: #558e55;
        }

        .ui.form .success :focus::-moz-placeholder {
            color: #558e55;
        }



        #btnSavePurchaseOrderSuggestion {
            margin-top: 3%;
        }

        /*setting z index to that value means that the datepicker will show in the modal and not below*/
        #ui-datepicker-div {
            z-index: 1151 !important;
        }


        .ui.checkbox label {
            font-size: 1em;
        }


        #lbl_del {
            opacity: 0.25;
        }

        #item-table-modal, #item-table-modal-confirmedOrder, #withoutorder-table {
            margin-top: 2em;
        }



        /*checkmark thing*/



        .circle-loader {
            margin-bottom: 3.5em;
            border: 1px solid rgba(0, 0, 0, 0.2);
            border-left-color: #5cb85c;
            animation: loader-spin 1.2s infinite linear;
            position: relative;
            display: inline-block;
            vertical-align: top;
            border-radius: 50%;
            width: 7em;
            height: 7em;
        }

        .load-complete {
            -webkit-animation: none;
            animation: none;
            border-color: #5cb85c;
            transition: border 500ms ease-out;
        }

        .checkmark2 {
            display: none;
        }

            .checkmark2.draw:after {
                animation-duration: 800ms;
                animation-timing-function: ease;
                animation-name: checkmark;
                transform: scaleX(-1) rotate(135deg);
            }

            .checkmark2:after {
                opacity: 1;
                height: 3.5em;
                width: 1.75em;
                transform-origin: left top;
                border-right: 3px solid #5cb85c;
                border-top: 3px solid #5cb85c;
                content: "";
                left: 1.75em;
                top: 3.5em;
                position: absolute;
            }

        @keyframes loader-spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        @keyframes checkmark2 {
            0% {
                height: 0;
                width: 0;
                opacity: 1;
            }

            20% {
                height: 0;
                width: 1.75em;
                opacity: 1;
            }

            40% {
                height: 3.5em;
                width: 1.75em;
                opacity: 1;
            }

            100% {
                height: 3.5em;
                width: 1.75em;
                opacity: 1;
            }
        }

        body.pushable {
            background: #fff !important;
        }
    </style>

    <script type="text/javascript">

        var openFrmCtxMenu = true;

        $(document).ready(function () {
            /*
             * 
                This method is called when the page is loaded to initialise different things
            */


            var departmentID = '';    //global variable in this file
            var warehouseID = '';     //global variable in this file
            var tabcounter = 0;

            var items = [];
            loadInit();
            function loadInit() {
                setTab('PurchaseOrders');

                getDepartmentID();
                getWarehouseID();
                getPOnumber();

                
                 $("#btnPrintReport").hide();
              
            }

            /* HOW TO AVOID GLOBALS:
            https://www.w3.org/wiki/JavaScript_best_practices#Avoid_globals
            globals are bad. So all our global variables should be encapsulated in this "namespace". Here we can change and retrieve values with getters and setters

            */
            myNameSpace = function () {

                var objectOfVariables = {
                    po_modal_state: 0,            //1:means that we are at the state where you still can add more spareparts to order 2:after pressing next and on "send order". 3: is final state
                    auto_modal_state: 0,
                    modal_withoutorder_state: 0,
                    po_modal_state_canclose: 0,
                    auto_modal_state_canclose: 0,
                    modal_withoutorder_state_canclose: 0,
                    po_modal_ddlnonstock: false,
                    po_modal_newPO: false,
                    row_position: 1,
                    item_catg_desc: -1,
                    id_item_catg: -1,
                    id_wh_item: -1,
                    cost_price1: -1,
                    item_price: -1,
                    basic_price: -1,
                    net_price: -1,
                    item_desc: "",
                    item_avail_qty: 0,
                    importedButDeletedRows: [],
                    po_delivered: false,
                    last_item_was_nonstock: false,
                    focus_set_once: false,

                };

                var item_arr = [];


                function set(variableToChange, newvalue, ponumber) {

                    var count = 0;

                    while (Object.keys(objectOfVariables)[count] != undefined)     //while we still have properties to loop over
                    {
                        if (Object.keys(objectOfVariables)[count] === variableToChange) {
                            if (variableToChange == "importedButDeletedRows") {
                                console.log("Legger inn denne");
                                console.log(newvalue);
                                objectOfVariables[variableToChange].push(newvalue);
                            }
                            else {
                                objectOfVariables[variableToChange] = newvalue;
                                console.log("Set variable : " + variableToChange + " to " + newvalue);

                            }


                        }
                        count++;
                    }
                }

                function get(variableToRetrieve, pop) {
                    var count = 0;
                    while (Object.keys(objectOfVariables)[count] != undefined)     //while we still have properties to loop over
                    {

                        if (Object.keys(objectOfVariables)[count] === variableToRetrieve) {

                            if (variableToRetrieve == "importedButDeletedRows") {
                                if (pop == 1) {
                                    return objectOfVariables[variableToRetrieve].pop();
                                }
                                else {
                                    return objectOfVariables[variableToRetrieve];
                                }

                            }

                            else {
                                return objectOfVariables[variableToRetrieve];
                            }


                        }
                        count++;
                    }

                }



                return {
                    /* public_call : internal call.  Can be the same such as init:init, or different such as set:change */

                    set: set,
                    get: get

                }
            }();



            /*
                This method is called when a tab is clicked, and loads the correct "page" with css etc
            */
            function setTab(currTab) {
                //currtab means currentTab             
                var tabID = "";

                tabID = $(currTab).data('tab') || currTab; // Checks if click or function call. If ctab is undefined, it is not a string, but instead an element with data
                var tab;
                (tabID == "") ? tab = currTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
                if (tabcounter > 0) {
                    //tabcounter will be 0 first time this method is called. Then we should not redraw the tabulator tables.
                    //however, whenever we switch tab, the tables should be redrawn. If not, often you will see a weird looking tabulator table
                    $("#PO-table").tabulator("redraw", true);
                    $("#Archived-table").tabulator("redraw", true);
                }


                tabcounter++;


            }
            //tabs with class .ctab have this onclick func that calls setTab for switching tabs
            $('.cTab').on('click', function (e) {
                setTab($(this));
            });



            var ajaxConfig = {
                type: "POST", //set request type to Position
                contentType: 'application/json; charset=utf-8', //set specific content type
            };


            function getPOnumber() {
                console.log("inside getponumber");
                console.log(departmentID + " " + warehouseID);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/GeneratePOnumber",
                    data: "{deptID:'" + departmentID + "',warehouseID:'" + warehouseID + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        {
                            if (data.d.length != 0) {
                                $('#pomodal_details_ponumber').text(data.d[1]);
                                $('#redRibbonPOmodal').text(data.d[1]);
                                $('#redRibbonPOmodal_withoutorder').text(data.d[1]);
                                $('#redRibbonAutomodal').text(data.d[1]);


                            }
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }

                });
            }



            function getWarehouseID() {
                console.log("inside getware");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/LoadWarehouseDetails",
                    data: '{}',
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        {
                            if (data.d.length != 0) {

                                warehouseID = data.d[0].WarehouseID;
                            }
                            else {
                                console.log("no len");
                            }
                        }
                    }
                });
            }

            function getDepartmentID() {
                console.log("getdepid inside");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/FetchCurrentDepartment",
                    data: "{}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        if (data.d.length != 0) {
                            departmentID = data.d[0].DeptId;

                        }
                        else {
                            console.log("a problem occured");
                        }
                    }
                });
            }


            $('#icon_sendviamail').on('click', function (e) {

                sendEmail();
            });

            function sendEmail() {
                try {
                    window.location.href = 'mailto:wamtraktorservice@gmail.com&subject=Bestilling BE78439&body=Hei, se vedlagt fil';
                }
                catch (err) {
                    alert(err.message);
                }
            }

            function sendEmailVB() {


                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/openMail",
                    data: "",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });

                return succeeded;
            }



            $('#icon_newPO').on('click', function (e) {
                initBeforeFirstModalStepView();
            });
            $('#icon_newPOautomatic').on('click', function (e) {
                $('#modal_auto_steps').modal('show');

                //content divs(tables)
                $('.modal_auto_divstep1').removeClass('hidden');
                $('.modal_auto_divstep2').addClass('hidden');
                $('.modal_auto_divstep3').addClass('hidden');
                $('.modal_auto_divstep4').addClass('hidden');
                $('.modal_auto_divstep5').addClass('hidden');
                $('#modal_auto_steps').modal('refresh');
            });

            $('#icon_withoutOrder').on('click', function (e) {
                initBeforeFirstModalStepViewWithoutOrder();
            });



            /* only called from the new po tab*/

            function saveNewPurchaseOrder(sendPO, withoutordertable, autoo) {

                if (withoutordertable) {
                    $('#redRibbonPOmodal_withoutorder').text(getPOnumber());    //gets updated PO
                    var ponumber = $('#redRibbonPOmodal_withoutorder').text();
                    var expdlvdate = convertDate($('#txtbxExpDeliveryxx').val());   //expected delivery date, can be null
                    var suppcurrentno = $('#pomodal_details_supplier_withoutorder').text();
                    var ordertype = $('#pomodal_details_ordertype_withoutorder').text();
                    var rows = $("#withoutorder-table").tabulator("getRows");

                }

                else if (autoo) {

                    $('#redRibbonAutomodal').text(getPOnumber());    //gets updated PO
                    var ponumber = $('#redRibbonAutomodal').text();
                    var expdlvdate = '20190218'   //expected delivery date, can be null
                    var suppcurrentno = $('#txtbxSuppcurrentnoModalAutomatic').val();

                    var ordertype = $("#dropdown_modal_ordertypes option:selected").text();
                    alert(ordertype);
                    var rows = $("#autoPOsuggestion-table").tabulator("getRows");
                }
                else {
                    $('#pomodal_details_ponumber').text(getPOnumber());    //gets updated PO
                    var ponumber = $('#pomodal_details_ponumber').text();
                    var expdlvdate = convertDate($('#txtbxExpDelivery').val());   //expected delivery date, can be null
                    var suppcurrentno = $('#txtbxSuppcurrentnoModal').val();
                    var ordertype = $('#pomodal_details_ordertype').text();
                    var rows = $("#item-table-modal").tabulator("getRows");
                }



                var purchaseOrderHead = createPOHeaderJSONstring(expdlvdate, ponumber, suppcurrentno, withoutordertable, ordertype, autoo);


                var succeeded = false;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/SavePurchaseOrderHead",
                    data: "{PurchaseOrderHead:'" + purchaseOrderHead + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {

                        if (data.d == 1) {
                            succeeded = true;

                        }


                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });

                if (!succeeded) { systemMSG('error', 'Noe gikk galt under lagring av bestillingen', 7000); }
                else {

                    for (i = 0; i < rows.length; i++) {
                        if (withoutordertable) {
                            var success = addItemToPO(rows[i], ponumber, true);
                        }

                        else if (autoo) {
                            var success = addItemToPO(rows[i], ponumber, false, true);
                        }
                        else {
                            var success = addItemToPO(rows[i], ponumber, false);
                        }

                        if (!success) {
                            systemMSG('Noe gikk galt med lagring av varer på bestilling', 7000);
                            break;
                        }

                    }



                    if (sendPO || withoutordertable) {
                        if (withoutordertable) {
                            setPOtoConfirmed($('#redRibbonPOmodal_withoutorder').text(), true);
                            systemMSG('success', 'Ankomstføring vellykket', 5000);
                        }
                        else {
                            systemMSG('success', 'Bestilling sendt', 5000);

                        }

                    }
                    else {
                        systemMSG('success', 'Bestillingsforslag lagret', 5000);
                    }
                }


            }


            function addItemToPO(row, ponumber, withoutordertable, autoOrder) {


                var itemobj = createPOItemJSONstring(row, ponumber, withoutordertable, autoOrder);

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/Add_PO_Item",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });

                return succeeded;
            }



            /*  Add fields to header-object, Then we store it back in a json string and return it to the calling method.
            */
            function createPOHeaderJSONstring(expdlvdate, ponum, suppcurrentno, withoutordertable, ordertype, autoo) {
                var purchaseOrderHeader = {};

                purchaseOrderHeader["NUMBER"] = ponum;
                purchaseOrderHeader["SUPP_CURRENTNO"] = suppcurrentno;
                purchaseOrderHeader["DT_EXPECTED_DELIVERY"] = expdlvdate;
                purchaseOrderHeader["DELIVERY_METHOD"] = 11;
                purchaseOrderHeader["ID_DEPT"] = departmentID;
                purchaseOrderHeader["ID_WAREHOUSE"] = warehouseID;
                purchaseOrderHeader["STATUS"] = false;
                purchaseOrderHeader["FINISHED"] = false;
                purchaseOrderHeader["CREATED_BY"] = ""
                purchaseOrderHeader["ANNOTATION"] = "COMMENT";
                purchaseOrderHeader["DT_CREATED_SIMPLE"] = expdlvdate;
                purchaseOrderHeader["ID_ORDERTYPE"] = ordertype;

                if (withoutordertable) {

                    purchaseOrderHeader["PREFIX"] = $('#redRibbonPOmodal_withoutorder').text().substring(0, 3);
                }

                else if (autoo) {
                    purchaseOrderHeader["PREFIX"] = $('#redRibbonAutomodal').text().substring(0, 3);
                }
                else {
                    purchaseOrderHeader["PREFIX"] = $('#pomodal_details_ponumber').text().substring(0, 3);

                }

                var jsonPO = JSON.stringify(purchaseOrderHeader);
                console.log(jsonPO);


                return jsonPO;
            }

            function createPOItemJSONstring(row, ponumber, withoutordertable, autoOrder) {


                var poid = fetch_PO_id(ponumber);

                var purchaseOrderItem = {};


                purchaseOrderItem["POPREFIX"] = ponumber.substring(0, 3);

                purchaseOrderItem["ID_PO"] = poid;
                purchaseOrderItem["PONUMBER"] = ponumber;
                purchaseOrderItem["ID_ITEM"] = row.getCell("ID_ITEM").getValue();
                purchaseOrderItem["ITEM_DESC"] = row.getCell("ITEM_DESC").getValue();

                purchaseOrderItem["ITEM_CATG_DESC"] = row.getCell("ITEM_CATG_DESC").getValue();
                purchaseOrderItem["ID_ITEM_CATG"] = row.getCell("ID_ITEM_CATG").getValue();
                purchaseOrderItem["ORDERQTY"] = row.getCell("ORDERQTY").getValue();
                purchaseOrderItem["REMAINING_QTY"] = row.getCell("ORDERQTY").getValue();

                purchaseOrderItem["COST_PRICE1"] = row.getCell("COST_PRICE1").getValue();
                purchaseOrderItem["ITEM_PRICE"] = row.getCell("ITEM_PRICE").getValue();
                purchaseOrderItem["NET_PRICE"] = row.getCell("NET_PRICE").getValue();
                purchaseOrderItem["BASIC_PRICE"] = row.getCell("BASIC_PRICE").getValue();

                purchaseOrderItem["TOTALCOST"] = row.getCell("TOTALCOST").getValue();


                purchaseOrderItem["REST_FLG"] = false;
                purchaseOrderItem["SUPP_CURRENTNO"] = row.getCell("SUPP_CURRENTNO").getValue();
                purchaseOrderItem["BACKORDERQTY"] = 0;
                purchaseOrderItem["CONFIRMQTY"] = 0;
                purchaseOrderItem["DELIVERED"] = false;

                if (!withoutordertable) {
                    purchaseOrderItem["ID_WOITEM_SEQ"] = row.getCell("ID_WOITEM_SEQ").getValue();
                    purchaseOrderItem["REST_FLG"] = row.getCell("REST_FLG").getValue();
                    purchaseOrderItem["ANNOTATION"] = row.getCell("ANNOTATION").getValue();
                }
                else {
                    purchaseOrderItem["ID_WOITEM_SEQ"] = "";
                    purchaseOrderItem["REST_FLG"] = false;
                    purchaseOrderItem["ANNOTATION"] = "";
                }

                var jsonPO = JSON.stringify(purchaseOrderItem);
                console.log(jsonPO);


                return jsonPO;
            }

            function fetch_PO_id(ponumber) {
                var id;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/Fetch_PO_id",
                    data: "{ponum:'" + ponumber + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        id = data.d;

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });

                return id;
            }



            function emptyFields() {

                $("#txtbxSupplierModal").val('');
                $("#txtbxSupplierModalparent").removeClass('error success');
                $("#txtbxSuppcurrentnoModal").val('');
                $("#dropdown_modal_ordertype").val('');
                $("#dropdown_modal_deliverymethod").val('');
                $("#txtbxExpDelivery").val('');


            }

            function checkTableForSimiliarItems(tablename, item_num) {
                var rows = $(tablename).tabulator("getRows");
                var ret = 1;
                if (rows.length !== 0) {
                    for (i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        data = row.getData();

                        if (data.ID_ITEM === item_num && ((data.ID_WOITEM_SEQ == "") || (typeof data.ID_WOITEM_SEQ == "undefined"))) {
                            $(tablename).tabulator("deselectRow"); //deselect all
                            $(tablename).tabulator("selectRow", row);        //select the existing item, easier to see for user

                            cell = row.getCell("ORDERQTY");
                            var cellElement = cell.getElement();


                            swal("OBS!", "Denne varen finnes allerede på bestillingen! Du kan endre antallet manuelt i tabellen", "warning")
                                .then((value) => {
                                    setTimeout(function () { $(tablename).tabulator("deselectRow", row); }, 4000);
                                    setTimeout(function () { $(cellElement).focus(); }, 1);
                                });
                            ret = 0;
                            break;
                        }
                    }

                }

                return ret;
            }







            /****              DATEPICKERS START                */


            //datepickers should now be bulletproof!! Some magic in onselect!

            $("#<%=txtbxDateFrom.ClientID%>").datepicker({
                showWeek: true,
                showOn: "button",
                buttonImage: "../images/calendar_icon.gif",
                buttonImageOnly: true,
                buttonText: "Velg dato",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+10",
                dateFormat: "dd-mm-yy",
                onSelect: function (date) {
                    var dt2 = $('#<%=txtbxDateTo.ClientID%>');
                    var startDate = $(this).datepicker('getDate');
                    var minDate = $(this).datepicker('getDate');
                    dt2.datepicker('setDate', minDate);
                    dt2.datepicker('option', 'minDate', minDate);

                }


            });

            $('#<%=txtbxDateTo.ClientID%>').datepicker({
                showWeek: true,
                showOn: "button",
                buttonImage: "../images/calendar_icon.gif",
                buttonImageOnly: true,
                buttonText: "Velg dato",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+10",
                dateFormat: "dd-mm-yy",
                onSelect: function (date) {
                    var dt1 = $('#<%=txtbxDateFrom.ClientID%>');
                    var dt1value = $('#<%=txtbxDateFrom.ClientID%>').val();
                    console.log(dt1value);
                    if (dt1value === undefined || dt1value === "") {
                        var thisdate = $(this).datepicker('getDate')
                        dt1.datepicker('setDate', thisdate);
                        $(this).datepicker('option', 'minDate', thisdate);
                    }
                }
            });


            $("#txtbxExpDelivery").datepicker({
                showWeek: true,
                showOn: "button",
                buttonImage: "../images/calendar_icon.gif",
                buttonImageOnly: true,
                buttonText: "Velg dato",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+10",
                dateFormat: "dd-mm-yy",
                minDate: 0,
                onSelect: function (date) {

                }



            });


            $("#txtbxExpectedDeliveryAutomatictab").datepicker({
                showWeek: true,
                showOn: "button",
                buttonImage: "../images/calendar_icon.gif",
                buttonImageOnly: true,
                buttonText: "Velg dato",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+10",
                dateFormat: "dd-mm-yy",
                minDate: 0,
                onSelect: function (date) {

                }



            });

            /****        DATEPICKERS END    */

            function convertDate(date) {
                var newDateFormat = date.split("-");
                var tmp = newDateFormat[0];
                newDateFormat[0] = newDateFormat[2];
                newDateFormat[2] = tmp;
                newDateFormat = newDateFormat.join("");
                return newDateFormat;
            }

            /* if two of these are active, disable the third. We dont want people to use all three input fields: that is useless*/

            $('#<%=txtbxPOnumbersearch.ClientID%>').on('input', function () {

                if ($(this).val().length && $('#<%=txtbxInfoSupplier.ClientID%>').val().length)
                    $('#<%=txtbxSparepartNumber.ClientID%>').prop('disabled', true);
                else
                    $('#<%=txtbxSparepartNumber.ClientID%>').prop('disabled', false);
            });

            $('#<%=txtbxInfoSupplier.ClientID%>').on('input', function () {

                if ($(this).val().length && $('#<%=txtbxPOnumbersearch.ClientID%>').val().length)
                    $('#<%=txtbxSparepartNumber.ClientID%>').prop('disabled', true);

                else if ($(this).val().length && $('#<%=txtbxSparepartNumber.ClientID%>').val().length)
                    $('#<%=txtbxPOnumbersearch.ClientID%>').prop('disabled', true);
                else {
                    $('#<%=txtbxPOnumbersearch.ClientID%>').prop('disabled', false);
                    $('#<%=txtbxSparepartNumber.ClientID%>').prop('disabled', false);
                }


            });


            $('#<%=txtbxSparepartNumber.ClientID%>').on('input', function () {

                if ($(this).val().length && $('#<%=txtbxInfoSupplier.ClientID%>').val().length)
                    $('#<%=txtbxPOnumbersearch.ClientID%>').prop('disabled', true);
                else
                    $('#<%=txtbxPOnumbersearch.ClientID%>').prop('disabled', false);
            });




            //function isValidNumber(evt, element) {

            //    var charCode = (evt.which) ? evt.which : event.keyCode


            //    if (

            //      (charCode != 46 || $(element).val().indexOf('.') != -1) && // “,” CHECK comma, AND ONLY ONE.
            //      (charCode < 48 || charCode > 57)
            //        )

            //        return false;

            //    return true;
            //}


            ////prevent from being able to copy/paste/cut. That would break the input restriction logic.
            //$('.inputNumberDot').bind("cut copy paste", function (e) { 
            //    e.preventDefault();
            //});

            //$('.inputNumberDot').keypress(function (event) {


            //    if ($(this).attr('id') === 'txtbxSparepartModal')
            //    {
            //        return (isValidNumber(event, this) && ($(this).val().length < 30));
            //    }
            //    return (isValidNumber(event, this) && ($(this).val().length < 6));
            //});

            $("#txtbxSupplierModalparent").on('keydown', '#txtbxSupplierModal', function (e) {
                var keyCode = e.keyCode || e.which;

                if (keyCode == 8) {

                    $("#txtbxSupplierModalparent").removeClass("success");
                    $("#txtbxSupplierModalparent").addClass("error");
                    $("#po_modal_next").addClass("disabled");
                }
            });


            $('#txtbxSupplierModal').on('keyup', function () {

                //if pressing enter or backspace and there is no text, just return
                if ($('#txtbxSupplierModal').val() === "") {
                    $("#txtbxSupplierModalparent").removeClass("success");
                    $("#txtbxSupplierModalparent").addClass("error");

                    return;
                }
            });

            $('#txtbxSparepartModal').on('keyup', function () {

                //if pressing enter or backspace and there is no text, just return

                $("#txtbxSparepartModalparent").removeClass("success");
                $("#txtbxSparepartModalparent").addClass("error");
                $("#modalPointingLabel").css('visibility', 'visible');

                return;


                /*
                   $.ajax({
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "PurchaseOrder.aspx/SparePart_Search",
                       data: "{'q': '" + $('#txtbxSparepartModal').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $("#pomodal_details_supplier").text() + "', 'nonStock': '" + myNameSpace.get("po_modal_ddlnonstock") + "', 'accurateSearch': '" + true + "'}",
                       dataType: "json",
                       async: false,
                       success: function (data) {
   
                           if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                               console.log("no hits");
                               if ($("#txtbxSparepartModalparent").hasClass("error") === false)
                               {
                                   $("#txtbxSparepartModalparent").removeClass("success");
                                   $("#txtbxSparepartModalparent").addClass("error");
             
                                   
                               }
                               
                           }
                           else
                           {
                               console.log("hitxx");
                               if ($("#txtbxSparepartModalparent").hasClass("error") === true)
                               {
                                   alert("HIT IN KEYUP");
                                   $("#txtbxSparepartModalparent").removeClass("error");
                                   $("#txtbxSparepartModalparent").addClass("success");
                                   
                                
                                   myNameSpace.set("item_catg_desc", i.item.catg_desc)
                                   myNameSpace.set("id_item_catg", i.item.id_item_catg)
   
                                   myNameSpace.set("cost_price1", i.item.cost_price1);
                                  
                                   myNameSpace.set("item_desc", i.item.desc);
                                   myNameSpace.set("item_avail_qty", i.item.item_avail_qty);
                                   
                                   
                                   
                               }
                               
                           }
                       },
                       error: function (xhr, status, error) {
                           alert("Error" + error);
                           var err = eval("(" + xhr.responseText + ")");
                           alert('Error: ' + err.Message);
                       }
                   });
                   */


            });



            //when pushing tab in last checkbox in modal, add new item to PO. does exactly the same as pressing the "legg til vare" button
            $("#txtbxSparepartModalparent").on('keydown', '#txtbxSparepartModal', function (e) {
                var keyCode = e.keyCode || e.which;

                if (keyCode == 8 || keyCode == 46) {

                }


                if (keyCode == 9) { //tab
                    e.preventDefault();
                    if ($("#txtbxSparepartModalparent").hasClass("success")) {
                        $("#txtbxSparepartModalparent").removeClass("error");
                        var ret = addItemToPOModal();


                    }

                }
            });

            $("#txtbxSupplierModalparent_withoutorder").on('keydown', '#txtbxSupplierModal_withoutorder', function (e) {
                var keyCode = e.keyCode || e.which;

                if (keyCode == 8) {

                    $("#txtbxSupplierModalparent_withoutorder").removeClass("success");
                    $("#txtbxSupplierModalparent_withoutorder").addClass("error");
                    $("#po_modal_next_withoutorder").addClass("disabled");
                }


            });


            $('#txtbxSupplierModal_withoutorder').on('keyup', function () {

                //if pressing enter or backspace and there is no text, just return
                if ($('#txtbxSupplierModal_withoutorder').val() === "") {
                    $("#txtbxSupplierModalparent_withoutorder").removeClass("success");
                    $("#txtbxSupplierModalparent_withoutorder").addClass("error");

                    return;
                }
            });

            $('#txtbxSparepartModal_withoutorder').on('keyup', function () {

                //if pressing enter or backspace and there is no text, just return

                $("#txtbxSparepartModalparent_withoutorder").removeClass("success");
                $("#txtbxSparepartModalparent_withoutorder").addClass("error");
                // $("#modalPointingLabel").css('visibility', 'visible');

                return;

            });

            //when pushing tab in last checkbox in modal, add new item to PO. does exactly the same as pressing the "legg til vare" button
            $("#txtbxSparepartModalparent_withoutorder").on('keydown', '#txtbxSparepartModal_withoutorder', function (e) {
                var keyCode = e.keyCode || e.which;


                if (keyCode == 8 || keyCode == 46) {

                }


                if (keyCode == 9) { //tab
                    e.preventDefault();
                    if ($("#txtbxSparepartModalparent_withoutorder").hasClass("success")) {
                        $("#txtbxSparepartModalparent_withoutorder").removeClass("error");
                        var ret = addItemToWithoutorderModal();

                        alert();
                    }

                }
            });

            function verifyInputCellEdit(cell) {
                row = cell.getRow();
                var items_ordered_qty = row.getCell("ORDERQTY");

                if (cell.getValue() <= 0) {
                    alert("Kan ikke sette antall til 0 eller lavere");
                    setTimeout(function () {
                        $(cellElement).focus();
                    }, 0);
                    return false;
                }

                else {
                    return true;
                }

            }


            //dont use clientid here because this textbox is semantics and not asp
            $('#txtbxSparepartModal').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "PurchaseOrder.aspx/SparePart_Search",
                        data: "{'q': '" + $('#txtbxSparepartModal').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $("#pomodal_details_supplier").text() + "', 'nonStock': '" + myNameSpace.get("po_modal_ddlnonstock") + "', 'accurateSearch': '" + false + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {

                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                if (myNameSpace.get("po_modal_ddlnonstock") == true) {
                                    if ($('#txtbxSparepartModal').val().length < 3) {
                                        response([{ label: 'Krever min 3 tegn for søk', value: $('#txtbxSparepartModal').val(), val: 'new' }]);
                                    }
                                    else {
                                        response([{ label: 'Ingen treff i non-stock', value: $('#txtbxSparepartModal').val(), val: 'new' }]);
                                    }
                                }
                                else {
                                    response([{ label: 'Ingen treff i lokalt lager. ', value: $('#txtbxSparepartModal').val(), val: 'new' }]);
                                }

                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_MAKE,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM,
                                        desc: item.ITEM_DESC,
                                        catg_desc: item.ITEM_CATG_DESC,
                                        id_item_catg: item.ID_ITEM_CATG,
                                        cost_price1: item.COST_PRICE1,
                                        item_price: item.ITEM_PRICE,
                                        net_price: item.NET_PRICE,
                                        basic_price: item.BASIC_PRICE,

                                        item_avail_qty: item.ITEM_AVAIL_QTY
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
                        e.preventDefault();
                        var alreadyInLocalStock = fetchLocalItem(i.item.value);

                        if (alreadyInLocalStock) {

                        }
                        else {
                            myNameSpace.set("item_catg_desc", i.item.catg_desc)
                            myNameSpace.set("id_item_catg", i.item.id_item_catg)

                            myNameSpace.set("cost_price1", i.item.cost_price1);
                            myNameSpace.set("item_price", i.item.item_price);
                            myNameSpace.set("net_price", i.item.net_price);
                            myNameSpace.set("basic_price", i.item.basic_price);

                            myNameSpace.set("item_desc", i.item.desc);
                            myNameSpace.set("item_avail_qty", i.item.item_avail_qty);
                        }


                        if (myNameSpace.get("po_modal_ddlnonstock") == true) {

                            myNameSpace.set("id_wh_item", i.item.warehouse);
                            myNameSpace.set("last_item_was_nonstock", true);
                        }
                        else {
                            myNameSpace.set("last_item_was_nonstock", false);
                        }



                        $("#txtbxSparepartModalparent").removeClass("error");
                        $("#txtbxSparepartModalparent").addClass("success");
                        $('#txtbxSparepartModal').val(i.item.value);



                    }
                    else {


                    }

                }
            });




            //dont use clientid here because this textbox is semantics and not asp
            $('#txtbxSparepartModal_withoutorder').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "PurchaseOrder.aspx/SparePart_Search",
                        data: "{'q': '" + $('#txtbxSparepartModal_withoutorder').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $("#pomodal_details_supplier_withoutorder").text() + "', 'nonStock': '" + myNameSpace.get("po_modal_ddlnonstock") + "', 'accurateSearch': '" + false + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {

                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                if (myNameSpace.get("po_modal_ddlnonstock") == true) {
                                    if ($('#txtbxSparepartModal_withoutorder').val().length < 3) {
                                        response([{ label: 'Krever min 3 tegn for søk', value: $('#txtbxSparepartModal_withoutorder').val(), val: 'new' }]);
                                    }
                                    else {
                                        response([{ label: 'Ingen treff i non-stock', value: $('#txtbxSparepartModal_withoutorder').val(), val: 'new' }]);
                                    }
                                }
                                else {
                                    response([{ label: 'Ingen treff i lokalt lager. ', value: $('#txtbxSparepartModal_withoutorder').val(), val: 'new' }]);
                                }

                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_MAKE,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM,
                                        desc: item.ITEM_DESC,
                                        catg_desc: item.ITEM_CATG_DESC,
                                        id_item_catg: item.ID_ITEM_CATG,
                                        cost_price1: item.COST_PRICE1,
                                        item_price: item.ITEM_PRICE,
                                        net_price: item.NET_PRICE,
                                        basic_price: item.BASIC_PRICE,

                                        item_avail_qty: item.ITEM_AVAIL_QTY
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
                        e.preventDefault();
                        var alreadyInLocalStock = fetchLocalItem($('#txtbxSparepartModal_withoutorder').val());

                        if (alreadyInLocalStock) {

                        }
                        else {
                            myNameSpace.set("item_catg_desc", i.item.catg_desc)
                            myNameSpace.set("id_item_catg", i.item.id_item_catg)

                            myNameSpace.set("cost_price1", i.item.cost_price1);
                            myNameSpace.set("item_price", i.item.item_price);
                            myNameSpace.set("net_price", i.item.net_price);
                            myNameSpace.set("basic_price", i.item.basic_price);

                            myNameSpace.set("item_desc", i.item.desc);
                            myNameSpace.set("item_avail_qty", i.item.item_avail_qty);
                        }


                        if (myNameSpace.get("po_modal_ddlnonstock") == true) {

                            myNameSpace.set("id_wh_item", i.item.warehouse);
                            myNameSpace.set("last_item_was_nonstock", true);
                        }
                        else {
                            myNameSpace.set("last_item_was_nonstock", false);
                        }



                        $("#txtbxSparepartModalparent_withoutorder").removeClass("error");
                        $("#txtbxSparepartModalparent_withoutorder").addClass("success");
                        $('#txtbxSparepartModal_withoutorder').val(i.item.value);



                    }
                    else {


                    }

                }
            });


            $('#<%=txtbxPOnumbersearch.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "PurchaseOrder.aspx/Fetch_PurchaseOrders",
                        data: "{'POnum': '" + $('#<%=txtbxPOnumbersearch.ClientID%>').val() + "', 'supplier': '" + "%" + "', 'fromDate': '" + 0 + "', 'toDate': '" + 0 + "', 'spareNumber': '" + "%" + "', 'isDelivered': '" + "%" + "', 'isConfirmedOrder': '" + true + "', 'isUnconfirmedOrder': '" + true + "', 'isExactPOnum': '" + false + "', 'isExactSupp': '" + false + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Ingen treff på bestillingsnummer', value: '0', val: 'new' }]);
                            }
                            else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.NUMBER,
                                        val: item.NUMBER,
                                        value: item.NUMBER

                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            console.log("err");
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }

                    });

                },

                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {

                    if (i.item.val != 'new') {
                        e.preventDefault();
                        $('#<%=txtbxPOnumbersearch.ClientID%>').val(i.item.val); //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory

                        //loadCategory();
                    }
                    else {


                    }

                }

            });
            //autocomplete for listing of the supplier


            $('#txtbxSupplierNameAutomatictab').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#txtbxSupplierNameAutomatictab').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#txtbxSupplierNameAutomatictab').val());

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Ingen treff i leverandørregister', value: '0', val: 'new' }]);
                            }
                            else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_SUPPLIER_ITEM + " - " + item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            console.log("err");
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }

                    });

                },

                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {

                    if (i.item.val != 'new') {
                        e.preventDefault();
                        $('#txtbxSupplierNameAutomatictab').val(i.item.supName); //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory
                        $('#txtbxSupplierIdAutomatictab').val(i.item.val);

                    }
                    else {


                    }

                }

            });



            $('#<%=txtbxInfoSupplier.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#<%=txtbxInfoSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#<%=txtbxInfoSupplier.ClientID%>').val());

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Ingen treff i leverandørregister', value: '0', val: 'new' }]);
                            }
                            else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_SUPPLIER_ITEM + " - " + item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            console.log("err");
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }

                    });

                },

                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {

                    if (i.item.val != 'new') {
                        e.preventDefault();
                        $('#<%=txtbxInfoSupplier.ClientID%>').val(i.item.val); //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory

                        //loadCategory();
                    }
                    else {

                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }

                }

            });



            //autocomplete for listing of the supplier


            $('#txtbxSupplierModal').autocomplete({

                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#txtbxSupplierModal').val() + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Fant ingen treff på leverandør', value: '', val: 'new' }]);
                                if ($("#txtbxSupplierModalparent").hasClass("success")) {
                                    $("#txtbxSupplierModalparent").removeClass("success");
                                }
                                $("#txtbxSupplierModalparent").addClass("error");

                            }
                            else

                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name,
                                        itemname: item.ID_SUPPLIER_ITEM

                                    }
                                }))

                        },
                        error: function (xhr, status, error) {
                            console.log("err");
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }

                    });

                },

                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {

                    if (i.item.val != 'new') {
                        e.preventDefault()

                        $('#txtbxSupplierModal').val(i.item.supName);
                        $('#txtbxSuppcurrentnoModal').val(i.item.val);
                        $('#pomodal_details_supplier').text(i.item.val);
                        $("#po_modal_next").removeClass("disabled");


                        if ($("#txtbxSupplierModalparent").hasClass("error")) {
                            $("#txtbxSupplierModalparent").removeClass("error");
                        }
                        $("#txtbxSupplierModalparent").addClass("success");
                        $("#addOrderType").removeClass("disabled");
                        getOrdertypes($('#txtbxSuppcurrentnoModal').val());


                    }
                    else {
                        e.preventDefault(); //prevents default behaviour which is setting input to something else
                        $('#txtbxSupplierModal').val('');
                        $("#addOrderType").addClass("disabled");
                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");

                    }

                },


            });


            //autocomplete for listing of the supplier


            $('#txtbxSupplierModal_withoutorder').autocomplete({

                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#txtbxSupplierModal_withoutorder').val() + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Fant ingen treff på leverandør', value: '', val: 'new' }]);
                                if ($("#txtbxSupplierModalparent_withoutorder").hasClass("success")) {
                                    $("#txtbxSupplierModalparent_withoutorder").removeClass("success");
                                }
                                $("#txtbxSupplierModalparent_withoutorder").addClass("error");

                            }
                            else

                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name,
                                        itemname: item.ID_SUPPLIER_ITEM

                                    }
                                }))

                        },
                        error: function (xhr, status, error) {
                            console.log("err");
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }

                    });

                },

                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {

                    if (i.item.val != 'new') {
                        e.preventDefault()

                        $('#txtbxSupplierModal_withoutorder').val(i.item.supName);
                        $('#txtbxSuppcurrentnoModalWithoutorder').val(i.item.val);

                        $("#po_modal_next_withoutorder").removeClass("disabled");


                        if ($("#txtbxSupplierModalparent_withoutorder").hasClass("error")) {
                            $("#txtbxSupplierModalparent_withoutorder").removeClass("error");
                        }
                        $("#txtbxSupplierModalparent_withoutorder").addClass("success");
                        $("#addOrderType").removeClass("disabled");



                    }
                    else {
                        e.preventDefault(); //prevents default behaviour which is setting input to something else
                        $('#txtbxSupplierModal_withoutorder').val('');
                        $("#addOrderType").addClass("disabled");
                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }

                },


            });



            $('#txtbxSupplierModalAutomatic').autocomplete({

                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#txtbxSupplierModalAutomatic').val() + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Fant ingen treff på leverandør', value: '', val: 'new' }]);
                                if ($("#txtbxSupplierModalparentAutomatic").hasClass("success")) {
                                    $("#txtbxSupplierModalparentAutomatic").removeClass("success");
                                }
                                $("#txtbxSupplierModalparentAutomatic").addClass("error");

                            }
                            else

                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name,
                                        itemname: item.ID_SUPPLIER_ITEM

                                    }
                                }))

                        },
                        error: function (xhr, status, error) {
                            console.log("err");
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }

                    });

                },

                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {

                    if (i.item.val != 'new') {
                        e.preventDefault()

                        $('#txtbxSupplierModalAutomatic').val(i.item.supName);
                        $('#txtbxSuppcurrentnoModalAutomatic').val(i.item.val);
                        //$('#pomodal_details_supplier').text(i.item.val);
                        //$("#po_modal_next").removeClass("disabled");


                        if ($("#txtbxSupplierModalparentAutomatic").hasClass("error")) {
                            $("#txtbxSupplierModalparentAutomatic").removeClass("error");
                        }
                        $("#txtbxSupplierModalparentAutomatic").addClass("success");
                        // $("#addOrderType").removeClass("disabled");



                    }
                    else {
                        e.preventDefault(); //prevents default behaviour which is setting input to something else
                        $('#txtbxSupplierModalAutomatic').val('');
                        //  $("#addOrderType").addClass("disabled");
                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }

                },


            });




            $('#lblSparepartModalAddNewItem').on('click', function () {
                openItemInformation();
            });





            $('#<%=txtbxPOnumbersearch.ClientID%>').on('keyup', function () {

            });

            $('#<%=txtbxPOnumbersearch.ClientID%>').on('keyup', function () {

            });






            $('#<%=txtbxSparepartNumber.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search_Short",
                        data: "{q:'" + $('#<%=txtbxSparepartNumber.ClientID%>').val() + "', 'supp': '" + $('#<%=txtbxInfoSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            console.log($('#<%=txtbxSparepartNumber.ClientID%>').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager', value: $('#<%=txtbxSparepartNumber.ClientID%>').val(), val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_ITEM + " - " + item.ITEM_DESC,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM,
                                        desc: item.ITEM_DESC


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
                        e.preventDefault();

                        $('#<%=txtbxSparepartNumber.ClientID%>').val(i.item.value);

                    }
                    else {


                    }

                }
            });



            <%--$('#txtbxSpareNum').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search",
                        data: "{'q': '" + $('#txtbxSpareNum').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $('#<%=txtbxSupplierNameNEWPO.ClientID%>').val() + "', 'nonStock': '" + myNameSpace.get("po_modal_ddlnonstock") + "', 'accurateSearch': '" + false + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d.length === 0)
                            { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                
                                if (myNameSpace.get("po_modal_ddlnonstock") == true)
                                {
                                    
                                    if ($('#txtbxSpareNum').val().length < 3)
                                    {
                                       
                                        response([{ label: 'Krever min 3 tegn for søk', value: $('#txtbxSpareNum').val(), val: 'new' }]);
                                    }
                                    else
                                    {
                                        response([{ label: 'Ingen treff i non-stock', value: $('#txtbxSpareNum').val(), val: 'new' }]);
                                    }
                                }
                                else
                                {
                                    response([{ label: 'Ingen treff i lokalt lager', value: $('#txtbxSpareNum').val(), val: 'new' }]);
                                }
                              
                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM + " - " + item.ITEM_CATG_DESC,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM,
                                        desc: item.ITEM_DESC,
                                        catg_desc: item.ITEM_CATG_DESC,
                                        id_item_catg: item.ID_ITEM_CATG,
                                        cost_price1: item.COST_PRICE1,
                                        item_price: item.ITEM_PRICE,
                                        net_price: item.NET_PRICE,
                                        basic_price: item.BASIC_PRICE,
                                        item_avail_qty: item.ITEM_AVAIL_QTY
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
                        e.preventDefault();
                        $('#txtbxSpareNum').val(i.item.val);
                        var alreadyInLocalStock = fetchLocalItem($('#txtbxSpareNum').val());
                        if (alreadyInLocalStock)
                        {
                            
                        }
                        else
                        {
                            myNameSpace.set("item_catg_desc", i.item.catg_desc)
                            myNameSpace.set("id_item_catg", i.item.id_item_catg)

                            myNameSpace.set("cost_price1", i.item.cost_price1);
                            myNameSpace.set("item_price", i.item.item_price);
                            myNameSpace.set("net_price", i.item.net_price);
                            myNameSpace.set("basic_price", i.item.basic_price);

                            myNameSpace.set("item_desc", i.item.desc);
                            myNameSpace.set("item_avail_qty", i.item.item_avail_qty);
                        }
                        if (myNameSpace.get("po_modal_ddlnonstock") == true)
                        {

                            myNameSpace.set("id_wh_item", i.item.warehouse);
                            myNameSpace.set("last_item_was_nonstock", true);
                        }
                        else
                        {
                            myNameSpace.set("last_item_was_nonstock", false);
                        }
                                                                      
             
                        
                   
                    }
                    else {


                    }

                }
            });--%>

            //new ordertype: when clicking + plus sign in before first modal step, you can add a new ordertype. So there opens a new modal where you can create this new ordertype


            //Ordretype

            $('#addOrderType').on('click', function () {
                $('#txtbxNewOrdertypeSupplier').val($('#txtbxSuppcurrentnoModal').val());

                overlay('on', 'modNewOrdertype');
            });

            $('#btnOrdertypeSave').on('click', function () {

                $('.overlayHide').removeClass('ohActive');
                $('#modNewOrdertype').addClass('hidden');
                alert($('#ddlNewOrdertypePricetype').dropdown('get text'));
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/addOrderType",
                    data: "{ordertype: '" + $('#txtbxNewOrdertypeOrdertype').val() + "', suppcurrentno:'" + $('#txtbxNewOrdertypeSupplier').val() + "', description:'" + $('#txtbxNewOrdertypeDescription').val() + "', pricetype:'" + $('#ddlNewOrdertypePricetype').dropdown('get text') + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "INSFLG") {
                            systemMSG('success', 'Bestillingstype lagret', 5000);
                        }
                        else if (data.d == "UPDFLG") {
                            systemMSG('success', 'Bestillingstype oppdatert', 5000);
                        }
                    },
                    error: function (result) {
                        systemMSG('error', 'En feil oppstod i lagring av bestillingstype', 5000);
                    }
                });
                // loadSalesGroup();

            });
            $('#btnOrdertypeCancel').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modNewOrdertype').addClass('hidden');
            });
            $('#btnOrdertypeNew').on('click', function () {

                $('#txtbxNewOrdertypeOrdertype').val('');
                $('#txtbxNewOrdertypeDescription').val('');
                $('#txtbxNewOrdertypePricetype').val('');
                $('#ddlOrdertypesModal').append($("<option></option>").val("*").html("*"));
                $('#ddlOrdertypesModal option:eq("*")').prop('selected', true)
                $('option[value="*"]').prop("selected", true);
                <%--$('#<%=lblAdvSalesmanStatus.ClientID%>').html('Oppretter ny selger.')--%>
            });


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

            $(".modClose").on('click', function (e) {
                overlay('off', '');
            });



            $('#ddlOrdertypesModal').change(function () {
                if (this.value != '*') {
                    var id = this.value;
                    getOrdertypes(20001, id);
                }
                else {
                    $('#txtbxNewOrdertypePricetype').val('');
                    $('#txtbxNewOrdertypeOrdertype').val('');
                    $('#txtbxNewOrdertypeDescription').val('');
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

                            $('#txtbxNewOrdertypePricetype').val(data.d[0].PRICETYPE);
                            $('#txtbxNewOrdertypeOrdertype').val(data.d[0].SUPP_ORDERTYPE);
                            $('#txtbxNewOrdertypeDescription').val(data.d[0].SUPP_ORDERTYPE_DESC);


                        }
                        else {


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

            //ordertype end


            function openItemInformation(id_item, supp_currentno) {

                moreInfo('../ss3/LocalSPDetail.aspx?id_make=' + supp_currentno + '&id_item=' + id_item + '&id_wh_item=' + 1 + '&pageName=PurchaseOrder', 'Varedetaljer');


            }

            function moreInfo(page, title) {

                var $dialog = $('<div id="testdialog"></div>')
                    .html('<iframe id="testifr" style="border: 0px;" src="' + page + '" width="1000px" height="800px"></iframe>')
                    .dialog
                    ({
                        autoOpen: false,
                        modal: true,
                        height: 800,
                        width: '80%',
                        title: title
                    });
                $dialog.dialog('open');
            }



            // $('.ui.dropdown').dropdown();


            /* Close actions are applied by default to all button actions, in addition an onApprove or onDeny callback will fire if the elements match either selector.
 
                 approve  : '.positive, .approve, .ok',
                 deny     : '.negative, .deny, .cancel' */

            //need this in order for dropdown to work!!

            $('#ddlLocalNonstock, #ddlLocalNonstockNew').dropdown({
                onChange: function () {

                    var currentSelection = $(this).dropdown('get value');


                    if (currentSelection === "non-stock") {
                        myNameSpace.set("po_modal_ddlnonstock", true);
                    }
                    else {
                        myNameSpace.set("po_modal_ddlnonstock", false);
                    }

                }


            });


            $('#modal_auto_steps').modal({
                allowMultiple: true,
                closable: false, //so that you cant close by just clicking outside modal 
                centered: false,
                selector: {

                    deny: '.actions .negative, .actions .deny, .actions .cancel, .close'
                },
                onDeny: function () {
                    if (myNameSpace.get("auto_modal_state") !== 3) {

                    }
                    $("#txtbxSparepartModal").val("");

                    $("#txtbxSparepartModalparent").removeClass("success");




                    //  emptyFields();
                    return false;
                },

                onApprove: function () {
                    returnValue = false;
                    if (myNameSpace.get("modal_withoutorder_state") === 1) //if we are at the final step in modal allow to close 
                    {
                        if (myNameSpace.get("modal_withoutorder_state_canclose") === 0) {
                            alert();
                            returnValue = false;
                            myNameSpace.set("modal_withoutorder_state_canclose", 1);
                        }
                        else {

                            returnValue = true;
                        }

                    }
                    return returnValue; //Return false as to not close modal dialog
                }
            });

            $('#modal_po_steps').modal({
                allowMultiple: true,
                closable: false, //so that you cant close by just clicking outside modal
                selector: {

                    deny: '.actions .negative, .actions .deny, .actions .cancel, .close'
                },
                onDeny: function () {
                    if (myNameSpace.get("po_modal_state") !== 3) {

                    }
                    $("#txtbxSparepartModal").val("");

                    $("#txtbxSparepartModalparent").removeClass("success");




                    emptyFields();
                    return false;
                },

                onApprove: function () {
                    returnValue = false;
                    if (myNameSpace.get("po_modal_state") === 4) //if we are at the final step in modal allow to close 
                    {
                        if (myNameSpace.get("po_modal_state_canclose") === 0) {

                            returnValue = false;
                            myNameSpace.set("po_modal_state_canclose", 1);
                        }
                        else {

                            returnValue = true;
                        }

                    }
                    return returnValue; //Return false as to not close modal dialog
                }
            });

            $(".ui modal close icon").on("click", function (e) {



            });

            $('#modal_withoutorder_steps').modal({
                allowMultiple: true,
                closable: false, //so that you cant close by just clicking outside modal
                selector: {

                    deny: '.actions .negative, .actions .deny, .actions .cancel, .close'
                },
                onDeny: function () {
                    if (myNameSpace.get("po_modal_state") !== 3) {

                    }
                    $("#txtbxSparepartModal").val("");

                    $("#txtbxSparepartModalparent").removeClass("success");




                    emptyFields();
                    return false;
                },

                onApprove: function () {
                    returnValue = false;
                    if (myNameSpace.get("po_modal_state") === 4) //if we are at the final step in modal allow to close 
                    {
                        if (myNameSpace.get("po_modal_state_canclose") === 0) {

                            returnValue = false;
                            myNameSpace.set("po_modal_state_canclose", 1);
                        }
                        else {

                            returnValue = true;
                        }

                    }
                    return returnValue; //Return false as to not close modal dialog
                }
            });

            $('#po_modal_import').on('click', function (e) {
                var table;

                table = "#item-table-modal";

                if (myNameSpace.get("importedButDeletedRows", 0).length != 0) //means we have local imports available: we first imported from db, then deleted and let them live in memory locally 
                {

                    var num_imports = parseInt($('#lbl_available_imports_modals').text());

                    for (i = 0; i < num_imports; i++) {
                        var items_local_import = myNameSpace.get("importedButDeletedRows", 1);
                        $(table).tabulator("addData", items_local_import, true);
                        $(table).tabulator("redraw", true);

                    }


                    $('#lbl_available_imports_modal').text(0);

                    $('#po_modal_import').addClass('disabled');
                }
                else     //we go to the db
                {
                    var importedItems;
                    var supp_currentno = $('#pomodal_details_supplier').text();
                    var id_ordertype = $('#pomodal_details_ordertype').text();
                    importedItems = getImportedOrderItems(supp_currentno, id_ordertype, true);


                    $(table).tabulator("addData", importedItems, true);
                    $(table).tabulator("redraw", true);

                    if (this.id == 'po_modal_import') { $('#modal_po_steps').modal('refresh'); } //refresh because modal exceeds so u cannot scroll if not refresh                  

                    $('#po_modal_import').addClass('disabled');

                    $('#lbl_available_imports_modal').text(0);
                }

            });



            $('#po_modal_update').on('click', function (e) {

                if (myNameSpace.get("po_modal_state") == 1)    //FIRST STEP IN MODAL. UPDATING ITEMS BEFORE SENDING THE ORDER
                {

                    var therows = $("#item-table-modal").tabulator("getRows");
                    var ponumber = $("#pomodal_details_ponumber").text();
                    for (i = 0; i < therows.length; i++) {

                        addItemToPO(therows[i], ponumber);
                    }

                }

                else if (myNameSpace.get("po_modal_state") == 3)   //THIRD STEP IN MODAL. ITEMS HAVE BEEN DELIVERED, LETS UPDATE
                {

                    var therows = $("#item-table-modal-delivery").tabulator("getRows");
                    var length = therows.length;
                    var i = 0;
                    while (i < length) {
                        var currentRow = therows[i];
                        var orderqty = currentRow.getCell("ORDERQTY").getValue();
                        var thisDelivery = currentRow.getCell("REMAINING_QTY").getValue();
                        var deliveredTotal = thisDelivery + currentRow.getCell("DELIVERED_QTY").getValue();
                        var rest_flg = currentRow.getCell("REST_FLG").getValue();


                        currentRow.getCell("DELIVERED_QTY").setValue(deliveredTotal);

                        ponumber = $('#redRibbonPOmodal').text();

                        updateArrivalPOitem(currentRow, ponumber);

                        currentRow.getCell("REMAINING_QTY").setValue(orderqty - deliveredTotal);

                        //this item has been delivered, lets remove it from table, put it in the next table and update DB
                        if ((deliveredTotal >= orderqty) || (rest_flg == false)) {

                            currentRow.getCell("REMAINING_QTY").setValue(0);
                            var updatedArr = $("#item-table-modal-delivery").tabulator("getRows");
                            var updatedLength = updatedArr.length;

                            if ((updatedLength) == 1) //this was the last row and all items on the PO has now been fully delivered
                            {

                                myNameSpace.set("po_delivered", true);
                                var porow = $("#PO-table").tabulator("getRow", $('#redRibbonPOmodal').text());

                                porow.getCell("FINISHED").setValue("True", true);
                                $('#po_modal_update').hide();
                                setPOtoConfirmed($('#redRibbonPOmodal').text(), true);

                                $('#item-table-modal-delivery').addClass('hidden');

                                $("#btnPrintReport").show();
                                $("#step_po_third").addClass("completed step");
                                initFourthModalStepView(porow, false, true);
                                systemMSG('success', 'Alle varelinjer er ankomstført', 5000);
                                makePOsearch();

                            }
                            //remove from this table

                            therows[i].delete();
                        }
                        i++;



                    }
                }


                $('#po_modal_update').addClass('disabled');
            });



            function updateArrivalPOitem(row, ponumber) {

                var purchaseOrderItem = {};

                var selectedRows = $("#PO-table").tabulator("getSelectedRows"); //because stupid suppcurrentno


                purchaseOrderItem["PONUMBER"] = ponumber;

                purchaseOrderItem["ID_ITEM"] = row.getCell("ID_ITEM").getValue();
                purchaseOrderItem["REMAINING_QTY"] = row.getCell("REMAINING_QTY").getValue();
                purchaseOrderItem["COST_PRICE1"] = row.getCell("COST_PRICE1").getValue();
                purchaseOrderItem["ITEM_PRICE"] = row.getCell("ITEM_PRICE").getValue();
                purchaseOrderItem["ID_WOITEM_SEQ"] = row.getCell("ID_WOITEM_SEQ").getValue();
                purchaseOrderItem["DELIVERED_QTY"] = row.getCell("REMAINING_QTY").getValue();
                purchaseOrderItem["SUPP_CURRENTNO"] = row.getCell("SUPP_CURRENTNO").getValue();
                purchaseOrderItem["ID_ITEM_CATG"] = row.getCell("ID_ITEM_CATG").getValue();
                purchaseOrderItem["ID_WAREHOUSE"] = 1;


                var jsonPOitem = JSON.stringify(purchaseOrderItem);

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/updateArrivalPOitem",
                    data: "{item:'" + jsonPOitem + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });

                return succeeded;
            }

            $('#auto_modal_next').on('click', function (e) {
                if (myNameSpace.get("auto_modal_state") == 0)     // first step in modal
                {
                    //content divs

                    $('.modal_auto_divstep1').addClass('hidden');
                    $('.modal_auto_divstep2').removeClass('hidden');
                    $('.modal_auto_divstep3').addClass('hidden');
                    $('.modal_auto_divstep4').addClass('hidden');
                    $('.modal_auto_divstep5').addClass('hidden');

                    //header steps
                    $("#step_auto_first").removeClass("active step");
                    $("#step_auto_first").addClass("completed step");
                    $("#step_auto_first").addClass("disabled step");
                    $("#step_auto_second").removeClass("disabled step");
                    $("#step_auto_second").addClass("active step");

                    //buttons
                    //$("#auto_modal_next").addClass("disabled");
                    $("#auto_modal_next").text("Generer forslag");
                    $("#auto_modal_next").append('<i class="sort numeric down icon"</i>');
                    $("#auto_modal_previous").removeClass("disabled");
                    $("#auto_modal_previous").show();

                    getPOnumber();
                    //update state
                    myNameSpace.set("auto_modal_state", 1);


                    $('#modal_auto_steps').modal('refresh'); //try without...not good without this

                }

                else if (myNameSpace.get("auto_modal_state") == 1)     //second step in modal
                {


                    $('.modal_auto_divstep1').addClass('hidden');
                    $('.modal_auto_divstep2').addClass('hidden');
                    $('.modal_auto_divstep3').removeClass('hidden');

                    //header steps
                    $("#step_auto_second").removeClass("active step");
                    $("#step_auto_second").addClass("completed step");
                    $("#step_auto_second").addClass("disabled step");
                    $("#step_auto_third").removeClass("disabled step");
                    $("#step_auto_third").addClass("active step");

                    //buttons
                    $("#auto_modal_previous").removeClass("disabled");
                    $("#auto_modal_next").text("Lag bestilling");
                    var supp_currentno = $('#txtbxSuppcurrentnoModalAutomatic').val()

                    $("#autoPOsuggestion-table").tabulator("setData", "PurchaseOrder.aspx/generate_automatic_suggestion", { 'supp_currentno': supp_currentno, 'method': $('input[name=example2]:checked').val(), 'order_max': $('#maxBox').is(":checked") });
                    //generate_automatic_po_items(20308, 20308);
                    //update state
                    myNameSpace.set("auto_modal_state", 2);
                    console.log("new state: " + myNameSpace.get("po_modal_state"));

                }
                else if (myNameSpace.get("auto_modal_state") == 2)   //third step in modal
                {


                    //if ($('#modal_po_confirmorder').modal('show'))    //  fix this!
                    if (confirm("Sende bestilling?")) {
                        // //content divs
                        // $('.modal_po_divstep2').addClass('hidden');
                        // $('.modal_po_divstep3').removeClass('hidden');

                        // $('#item-table-modal-delivery').removeClass('hidden');

                        // //header steps
                        // $("#step_po_second").removeClass("active step");
                        // $("#step_po_second").addClass("completed step");
                        // $("#step_po_second").addClass("disabled step")
                        // $("#step_po_third").removeClass("disabled step");
                        // $("#step_po_third").addClass("active step");

                        // //buttons                  
                        //// $("#po_modal_previous").hide();
                        // $("#po_modal_cancel").hide();
                        // $("#po_modal_import").hide();
                        // $('#po_modal_update').removeClass('disabled');
                        // $('#po_modal_update').show();

                        // $("#po_modal_next").text("Neste");
                        // $("#po_modal_next").append('<i class="chevron right icon"></i>');

                        saveNewPurchaseOrder(true, false, true);
                        setPOtoConfirmed($("#redRibbonAutomodal").text(), false);

                        //update state
                        myNameSpace.set("auto_modal_state", 3);
                        console.log("new state: " + myNameSpace.get("po_modal_state"));

                        systemMSG('success', 'Bestilling sendt', 5000);

                    }


                }

                else if (myNameSpace.get("po_modal_state") == 3)   //fourth step in modal and we click next, this is what we want to happen:
                {

                    //content divs

                    $('.modal_po_divstep3').addClass('hidden');
                    $('.modal_po_divstep4').removeClass('hidden');
                    $('#modal_extrainfo_fieldwrapper').addClass("hidden");

                    //header steps
                    $("#step_po_third").removeClass("active step");
                    $("#step_po_third").addClass("disabled step")
                    $("#step_po_fourth").removeClass("disabled step");
                    $("#step_po_fourth").addClass("active step");

                    //buttons                  
                    $("#po_modal_next").text("Lukk")
                    $("#po_modal_next").append('<i class="checkmark icon"></i>');
                    $("#po_modal_previous").removeClass("disabled");

                    $("#po_modal_previous").show();
                    $("#po_modal_update").hide();

                    var ponumber = $('#redRibbonPOmodal').text();

                    var supp_currentno = $('#pomodal_details_supplier4').text();

                    if (myNameSpace.get("po_delivered") == true) {

                        $("#po_modal_previous").hide();
                        //  $('.circle-loader').toggleClass('circle-loader');
                    }
                    else { $("#po_modal_previous").show(); }
                    $("#item-table-modal-final").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", { 'POnum': ponumber, 'isDeliveryTable': false, 'supp_currentno': supp_currentno });
                    myNameSpace.set("po_modal_state_canclose", 0);
                    myNameSpace.set("po_modal_state", 4);

                }
                else if (myNameSpace.get("po_modal_state") == 4)   //final step in modal
                {
                    
                }
                else   //should never enter here. added this in case someone added the wrong value for the modal state.
                {
                    alert("her skulle vi definitivt ikke havne!");
                }



            });

            $('#auto_modal_previous').on('click', function (e) {

                if (myNameSpace.get("auto_modal_state") == 1)     //second step in modal
                {

                    //content divs
                    $('.modal_auto_divstep2').addClass('hidden');
                    $('.modal_auto_divstep1').removeClass('hidden');

                    //header steps
                    $("#step_auto_second").removeClass("active step");
                    $("#step_auto_second").addClass("disabled step");
                    $("#step_auto_first").removeClass("disabled step");
                    $("#step_auto_first").removeClass("completed step");
                    $("#step_auto_first").addClass("active step");

                    $("#auto_modal_previous").addClass("disabled");
                    $("#auto_modal_next").text("Neste");
                    $("#auto_modal_next").append('<i class="chevron right icon"></i>');
                    myNameSpace.set("auto_modal_state", 0);

                }

                if (myNameSpace.get("auto_modal_state") == 2)     //second step in modal
                {
                    //content divs

                    $('.modal_auto_divstep3').addClass('hidden');
                    $('.modal_auto_divstep2').removeClass('hidden');

                    //header steps
                    $("#step_auto_third").removeClass("active step");
                    $("#step_auto_third").addClass("disabled step");
                    $("#step_auto_second").removeClass("completed step");
                    $("#step_auto_second").removeClass("disabled step");
                    $("#step_auto_second").addClass("active step");

                    //buttons
                    $("#auto_modal_previous").addClass("disabled");
                    $("#auto_modal_next").text("Neste");
                    $("#auto_modal_next").append('<i class="chevron right icon"</i>');
                    $('#modal_auto_steps').modal('refresh');
                    myNameSpace.set("auto_modal_state", 1);
                    console.log("new state: " + myNameSpace.get("auto_modal_state"));
                }




                if (myNameSpace.get("po_modal_state") == 4)     //second step in modal
                {
                    //content divs
                    $('.modal_po_divstep4').addClass('hidden');
                    $('.modal_po_divstep3').removeClass('hidden');

                    //header steps
                    $("#step_po_fourth").removeClass("active step");
                    $("#step_po_fourth").addClass("disabled step")
                    $("#step_po_third").removeClass("disabled step");
                    $("#step_po_third").addClass("active step");

                    //buttons

                    $("#po_modal_next").text("Neste");
                    $("#po_modal_next").append('<i class="chevron right icon"></i>');
                    $("#po_modal_previous").hide();
                    $("#po_modal_cancel").hide();
                    $("#po_modal_update").show();
                    myNameSpace.set("po_modal_state", 3);
                }
            });


            $('#po_modal_next').on('click', function (e) {
               
                if (myNameSpace.get("po_modal_state") == 0)     //before first step in modal
                {


                    //content divs                  
                    $('.modal_po_divstep0').addClass('hidden');
                    $('.modal_po_divstep1').removeClass('hidden');
                    $('.modal_po_divstep2').addClass('hidden');
                    $('.modal_po_divstep3').addClass('hidden');
                    $('.modal_po_divstep4').addClass('hidden');

                    //header steps
                    $("#step_po_before_first").removeClass("active step");
                    $("#step_po_before_first").addClass("completed step");
                    $("#step_po_before_first").addClass("disabled step");
                    $("#step_po_first").removeClass("disabled step");
                    $("#step_po_first").addClass("active step");

                    //buttons

                    $("#po_modal_next").addClass("disabled");
                    $("#po_modal_next").text("Lagre");
                    $("#po_modal_next").append('<i class="checkmark icon"</i>');
                    $("#po_modal_previous").removeClass("disabled");
                    $("#po_modal_import").removeClass("hidden");

                    $("#po_modal_previous").show();
                    $("#po_modal_import").show();

                    myNameSpace.set("po_modal_state", 1);

                    $("#item-table-modal").tabulator("redraw", true);
                    //update state
                    myNameSpace.set("po_modal_state", 1);
                    myNameSpace.set("po_modal_newPO", true);

                    $('#pomodal_details_ponumber').text($('#redRibbonPOmodal').text())

                    $('#modal_po_steps').modal('refresh'); //try without...not good without this

                    $("#btnPrintReport").hide();

                }

                else if (myNameSpace.get("po_modal_state") == 1)     //first step in modal(actually second)
                {
                    //if this is a completely new PO

                    if ((myNameSpace.get("po_modal_newPO") == true)) {

                        swal({
                            title: "Er du sikker?",
                            text: "Ønsker du å lagre bestillingsforslag?",
                            icon: "warning",
                            buttons: ["Avbryt", "Lagre"],

                        })
                            .then((willDelete) => {
                                if (willDelete) {

                                    saveNewPurchaseOrder(false);
                                    //emptyAllFields();
                                    $("#po_modal_previous").addClass("disabled");
                                    $("#po_modal_update").addClass("disabled");
                                    $("#po_modal_next").text("Bekreft bestilling");
                                    $("#po_modal_next").append('<i class="checkmark icon"></i>');
                                    $("#po_modal_update").show();
                                    myNameSpace.set("po_modal_newPO", false);
                                    makePOsearch(); //WE MAKE A NEW SEARCH SO THE PO TABLE IS BEING UPDATED
                                    systemMSG('success', 'Bestillingsforslag lagret', 5000);
                                }

                            });
                    }
                    //set


                    //else an already existing PO SUGGESTION, and we click "send bestilling"
                    else {

                        swal({
                            title: "Er du sikker?",
                            text: "Ønsker du å bekrefte bestillingsforslag? Når forslaget er bekreftet, kan ingen flere varer legges til",
                            icon: "warning",
                            buttons: ["Avbryt", "Bekreft"],

                        })
                            .then((willDelete) => {
                                if (willDelete) {


                                    $('.modal_po_divstep1').addClass('hidden');
                                    $('.modal_po_divstep2').removeClass('hidden');

                                    //header steps
                                    $("#step_po_first").removeClass("active step");
                                    $("#step_po_first").addClass("completed step");
                                    $("#step_po_first").addClass("disabled step");
                                    $("#step_po_second").removeClass("disabled step");
                                    $("#step_po_second").addClass("active step");

                                    //buttons

                                    $("#po_modal_import").hide();
                                    $("#po_modal_update").hide();
                                    $("#po_modal_next").text("Neste");
                                    $("#po_modal_next").append('<i class="pencil alternate icon"></i>');
                                    $("#btnDownloadPDF").show();
                                    $("#btnDownloadCSV").show();
                                    $("#po_modal_sendMenu").show();
                                    //update state
                                    myNameSpace.set("po_modal_state", 2);


                                    $("#item-table-modal-confirmedOrder").tabulator("redraw", true);
                                    //(fourth step gets values it needs)
                                    $('#pomodal_details_ponumber4').text($('#redRibbonPOmodal').text());
                                    $('#pomodal_details_supplier4').text($('#pomodal_details_supplier').text());

                                    var rows = $("#item-table-modal").tabulator("getRows");
                                    var row = rows[0];
                                    systemMSG('success', 'Bestillingsforslag bekreftet', 5000);
                                    $("#item-table-modal-confirmedOrder").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", { 'POnum': $('#redRibbonPOmodal').text(), 'isDeliveryTable': false, 'supp_currentno': row.getData().SUPP_CURRENTNO });
                                    setPOtoConfirmed($('#redRibbonPOmodal').text(), false);
                                    var porow = $("#PO-table").tabulator("getRow", $('#redRibbonPOmodal').text());
                                    porow.getCell("STATUS").setValue("True", true);
                                }

                            });
                    }




                    $("#btnPrintReport").hide();


                }
                else if (myNameSpace.get("po_modal_state") == 2)   //second step in modal, go to ankomstføring
                {


                    //content divs
                    $('.modal_po_divstep2').addClass('hidden');
                    $('.modal_po_divstep3').removeClass('hidden');

                    $('#item-table-modal-delivery').removeClass('hidden');

                    //header steps
                    $("#step_po_second").removeClass("active step");
                    $("#step_po_second").addClass("completed step");
                    $("#step_po_second").addClass("disabled step")
                    $("#step_po_third").removeClass("disabled step");
                    $("#step_po_third").addClass("active step");

                    //buttons                  
                    // $("#po_modal_previous").hide();
                    $("#po_modal_cancel").hide();
                    $("#po_modal_import").hide();
                    $("#po_modal_sendMenu").hide();
                    $('#po_modal_update').removeClass('disabled');
                    $('#po_modal_update').show();
                    $('#po_modal_previous').show();
                    $('#po_modal_previous').removeClass('disabled');
                    $("#po_modal_next").text("Neste");
                    $("#po_modal_next").append('<i class="chevron right icon"></i>');

                    //update state
                    myNameSpace.set("po_modal_state", 3);

                    var ponumber = $('#redRibbonPOmodal').text()

                    var rows = $("#item-table-modal-confirmedOrder").tabulator("getRows");
                    var row = rows[0];
                    var supp_currentno = row.getData().SUPP_CURRENTNO;
                    $("#item-table-modal-delivery").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", { 'POnum': ponumber, 'isDeliveryTable': true, 'supp_currentno': supp_currentno });
                    //systemMSG('success', 'Bestilling sendt', 5000);

                    $("#btnPrintReport").hide();
                }

                else if (myNameSpace.get("po_modal_state") == 3)   //third step in modal and we click next, this is what we want to happen:
                {

                    //$('#modal_extrainfo_fieldwrapper').addClass("hidden");

                    var ponumber = $('#redRibbonPOmodal').text();
                    var supp_currentno = $('#pomodal_details_supplier4').text();

                    //end
                    var porow = $("#PO-table").tabulator("getRow", $('#redRibbonPOmodal').text());
                    myNameSpace.set("po_modal_state_canclose", 0);
                    initFourthModalStepView(porow, true);

                    $("#btnPrintReport").show();
                }
                else if (myNameSpace.get("po_modal_state") == 4)   //final step in modal
                {
                   // alert("po_modal_next -->" + myNameSpace.get("po_modal_state") );
                    //$("#btnPrintReport").show();
                }
                else   //should never enter here. added this in case someone added the wrong value for the modal state.
                {
                    alert("her skulle vi definitivt ikke havne!");
                }



            });

            $('#po_modal_previous').on('click', function (e) {
               
                if (myNameSpace.get("po_modal_state") == 1)     //second step in modal
                {

                    //content divs
                    $('.modal_po_divstep1').addClass('hidden');
                    $('.modal_po_divstep0').removeClass('hidden');

                    //header steps
                    $("#step_po_first").removeClass("active step");
                    $("#step_po_first").addClass("disabled step");
                    $("#step_po_before_first").removeClass("disabled step");
                    $("#step_po_before_first").removeClass("completed step");
                    $("#step_po_before_first").addClass("active step");


                    $("#po_modal_previous").hide();
                    $("#po_modal_import").hide();
                    $("#po_modal_next").text("Neste");
                    $("#po_modal_next").append('<i class="chevron right icon"></i>');
                    myNameSpace.set("po_modal_state", 0);

                    $("#btnPrintReport").hide();
                }

                if (myNameSpace.get("po_modal_state") == 2)     //second step in modal
                {
                    //content divs
                    $('.modal_po_divstep2').addClass('hidden');
                    $('.modal_po_divstep1').removeClass('hidden');

                    //header steps
                    $("#step_po_second").removeClass("active step");
                    $("#step_po_second").addClass("disabled step");

                    $("#step_po_first").removeClass("completed step");
                    $("#step_po_first").removeClass("disabled step");
                    $("#step_po_first").addClass("active step");

                    //buttons
                    $("#po_modal_previous").addClass("disabled");
                    $("#po_modal_next").text("Neste");
                    $("#po_modal_next").append('<i class="chevron right icon"</i>');
                    $("#po_modal_import").show();
                    $("#po_modal_update").show();
                    $("#po_modal_import").removeClass("disabled");
                    $('#modal_po_steps').modal('refresh');
                    myNameSpace.set("po_modal_state", 1);
                    console.log("new state: " + myNameSpace.get("po_modal_state"));

                    $("#btnPrintReport").hide();
                }

                if (myNameSpace.get("po_modal_state") == 3)     //third step in modal
                {
                    var rows = $("#item-table-modal-delivery").tabulator("getRows");
                    var row = rows[0];
                    //content divs
                    $('.modal_po_divstep3').addClass('hidden');
                    $('.modal_po_divstep2').removeClass('hidden');

                    //header steps
                    $("#step_po_third").removeClass("active step");
                    $("#step_po_third").addClass("disabled step");

                    $("#step_po_second").removeClass("completed step");
                    $("#step_po_second").removeClass("disabled step");
                    $("#step_po_second").addClass("active step");

                    //buttons
                    $("#po_modal_previous").addClass("disabled");
                    $("#po_modal_next").text("Neste");
                    $("#po_modal_next").append('<i class="chevron right icon"</i>');
                    $("#po_modal_update").hide()
                    $("#po_modal_sendMenu").show()


                    $('#modal_po_steps').modal('refresh');
                    myNameSpace.set("po_modal_state", 2);
                    console.log("new state: " + myNameSpace.get("po_modal_state"));
                    $("#item-table-modal-confirmedOrder").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", { 'POnum': $('#redRibbonPOmodal').text(), 'isDeliveryTable': false, 'supp_currentno': row.getData().SUPP_CURRENTNO });
                    $("#item-table-modal-confirmedOrder").tabulator("redraw", true);

                    $("#btnPrintReport").hide();
                }

                if (myNameSpace.get("po_modal_state") == 4)     //second step in modal
                {

                    //content divs
                    $('.modal_po_divstep4').addClass('hidden');
                    $('.modal_po_divstep3').removeClass('hidden');

                    //header steps
                    $("#step_po_fourth").removeClass("active step");
                    $("#step_po_fourth").addClass("disabled step")
                    $("#step_po_third").removeClass("disabled step");
                    $("#step_po_third").addClass("active step");

                    //buttons

                    $("#po_modal_next").text("Neste");
                    $("#po_modal_next").append('<i class="chevron right icon"></i>');
                    $("#po_modal_previous").removeClass("disabled");
                    $("#po_modal_cancel").hide();
                    $("#po_modal_update").show();
                    myNameSpace.set("po_modal_state", 3);


                    $("#btnPrintReport").hide();
                }
            });





            $('#po_modal_next_withoutorder').on('click', function (e) {

                if (myNameSpace.get("modal_withoutorder_state") == 0)     //before first step in modal
                {
                    //content divs                  
                    $('.modal_withoutorder_divstep0').addClass('hidden');
                    $('.modal_withoutorder_divstep1').removeClass('hidden');


                    //header steps
                    $("#step_po_first_withoutorder").removeClass("active step");
                    $("#step_po_first_withoutorder").addClass("completed step");
                    $("#step_po_first_withoutorder").addClass("disabled step");
                    $("#step_po_second_withoutorder").removeClass("disabled step");
                    $("#step_po_second_withoutorder").addClass("active step");

                    //buttons

                    $("#po_modal_next_withoutorder").addClass("disabled");
                    $("#po_modal_next_withoutorder").text("Ankomstfør");
                    $("#po_modal_next_withoutorder").append('<i class="checkmark icon"</i>');
                    $("#po_modal_previous").removeClass("disabled");
                    $("#po_modal_previous").show();


                    $("#pomodal_details_ordertype_withoutorder").text($("#dropdown_modal_ordertype_withoutorder").dropdown('get value'));
                    $("#pomodal_details_supplier_withoutorder").text($("#txtbxSuppcurrentnoModalWithoutorder").val());

                    $("#item-table-modal").tabulator("redraw", true);
                    //update state
                    myNameSpace.set("modal_withoutorder_state", 1);
                    $("#withoutorder-table").tabulator("redraw", true);
                    $('#modal_withoutorder_steps').modal('refresh'); //try without...not good without this

                }



                else if (myNameSpace.get("modal_withoutorder_state") == 1)     //first step in modal(actually second)
                {
                    //if this is a completely new PO

                    swal({
                        title: "Er du sikker?",
                        text: "Ankomstføre varer?",
                        icon: "warning",
                        buttons: ["Avbryt", "Lagre"],

                    })
                        .then((willDelete) => {
                            if (willDelete) {

                                saveNewPurchaseOrder(false, true, false);
                                //emptyAllFields();
                                $("#po_modal_previous").addClass("disabled");

                                makePOsearch(); //WE MAKE A NEW SEARCH SO THE PO TABLE IS BEING UPDATED
                                systemMSG('success', 'Varer er ankomstført', 5000);
                            }

                        });
                }

            });







            $(document).on('click', '#btnZeroRowModal', function (e) {

                rows = $("#item-table-modal-delivery").tabulator("getSelectedRows");
                var i = 0;
                while (i != rows.length) {
                    rows[i].getCell("REMAINING_QTY").setValue(0);
                    i++;
                }
            });



            $("#btnPOsetStandard").on('click', function (e) {

                var columnLayout = $("#PO-table").tabulator("getColumnLayout");
                console.log("column layout:");
                console.log(columnLayout);
            });
            /* WHEN CLICKING THIS BUTTON, ITEM IS ADDED TO THE TABLE */


            function addItemToPOModal() {
                var item_catg_desc = myNameSpace.get("item_catg_desc");
                var id_item_catg = myNameSpace.get("id_item_catg");
                var item_desc = myNameSpace.get("item_desc");

                var item_price = myNameSpace.get("item_price").replace(',', '.');
                var cost_price1 = myNameSpace.get("cost_price1").replace(',', '.');
                var basic_price = myNameSpace.get("basic_price").replace(',', '.');
                var net_price = myNameSpace.get("net_price").replace(',', '.');

                var id_item = $("#txtbxSparepartModal").val();
                var qty = 1
                var total = cost_price1 * qty;

                var item_avail_qty = myNameSpace.get("item_avail_qty");
                var ponumber = $('#pomodal_details_ponumber').text();
                var supp_currentno = $('#pomodal_details_supplier').text();
                var indelivery = fetch_num_items_indelivery(ponumber, supp_currentno, id_item);


                if (myNameSpace.get("last_item_was_nonstock") == true) {

                    //this means we have searched and got an item that came from nonstock. We need to copy this item and insert it into tbl_mas_item_master table which is the local table
                    var id_wh_item = myNameSpace.get("id_wh_item")
                    insert_global_to_item_master(id_item, supp_currentno, id_item_catg, id_wh_item);
                }


                if (checkTableForSimiliarItems("#item-table-modal", id_item)) {

                    $("#item-table-modal").tabulator("addData", [{ ITEM_CATG_DESC: item_catg_desc, ID_ITEM_CATG: id_item_catg, ID_ITEM: id_item, ITEM_DESC: item_desc, ORDERQTY: qty, COST_PRICE1: cost_price1, ITEM_PRICE: item_price, NET_PRICE: net_price, BASIC_PRICE: basic_price, TOTALCOST: total, INDELIVERY: indelivery, ITEM_AVAIL_QTY: item_avail_qty, SUPP_CURRENTNO: supp_currentno, REST_FLG: true }], false)
                        .then(function (rows) {
                            //rows - array of the row components for the rows updated or added

                            $("#item-table-modal").tabulator("redraw", true);

                            //if this is a NEW PO, do NOT proceed with additemtoPO
                            if ((myNameSpace.get("po_modal_newPO") == true)) {

                                $("#po_modal_next").removeClass("disabled");
                                $('#txtbxSparepartModal').val("");
                                $("#txtbxSparepartModalparent").removeClass("success");


                                row = rows[0]
                                cell = row.getCell("ORDERQTY");
                                var cellElement = cell.getElement();


                                $(cellElement).focus();

                            }
                            else {
                                var row = rows[0];
                                //the adddata triggers a callback in the item-table-modal object that calls addItemToPo(database)

                                console.log(row);
                                $("#item-table-modal").tabulator("scrollToRow", row)
                                    .then(function () {
                                        addItemToPO(row, ponumber);

                                        $('#txtbxSparepartModal').val("");
                                        $("#txtbxSparepartModalparent").removeClass("success");
                                        $("#po_modal_next").removeClass("disabled");


                                        cell = row.getCell("ORDERQTY");
                                        var cellElement = cell.getElement();


                                        $(cellElement).focus();

                                        //run code after row has been scrolled to
                                    })
                                    .catch(function (error) {
                                        //handle error scrolling to row
                                        alert("error in scroll");
                                    });
                            }




                            //run code after data has been updated
                        })
                        .catch(function (error) {
                            //handle error updating data
                            console.log("critical error: " + error);
                        });

                    return 1;
                }
                else {
                    return 0;
                }
            }


            function addItemToWithoutorderModal() {
                var item_catg_desc = myNameSpace.get("item_catg_desc");
                var id_item_catg = myNameSpace.get("id_item_catg");
                var item_desc = myNameSpace.get("item_desc");

                var item_price = myNameSpace.get("item_price").replace(',', '.');
                var cost_price1 = myNameSpace.get("cost_price1").replace(',', '.');
                var basic_price = myNameSpace.get("basic_price").replace(',', '.');
                var net_price = myNameSpace.get("net_price").replace(',', '.');

                var id_item = $("#txtbxSparepartModal_withoutorder").val();
                var qty = 1
                var total = cost_price1 * qty;

                var item_avail_qty = myNameSpace.get("item_avail_qty");
                var ponumber = $('#redRibbonPOmodal_withoutorder').text();
                var supp_currentno = $('#pomodal_details_supplier').text();
                var indelivery = fetch_num_items_indelivery(ponumber, supp_currentno, id_item);


                if (myNameSpace.get("last_item_was_nonstock") == true) {
                    //this means we have searched and got an item that came from nonstock. We need to copy this item and insert it into tbl_mas_item_master table which is the local table
                    var id_wh_item = myNameSpace.get("id_wh_item")
                    insert_global_to_item_master(id_item, supp_currentno, id_item_catg, id_wh_item);
                }



                if (checkTableForSimiliarItems("#withoutorder-table", id_item)) {

                    $("#withoutorder-table").tabulator("addData", [{ ITEM_CATG_DESC: item_catg_desc, ID_ITEM_CATG: id_item_catg, ID_ITEM: id_item, ITEM_DESC: item_desc, ORDERQTY: qty, COST_PRICE1: cost_price1, ITEM_PRICE: item_price, NET_PRICE: net_price, BASIC_PRICE: basic_price, TOTALCOST: total, INDELIVERY: indelivery, ITEM_AVAIL_QTY: item_avail_qty, SUPP_CURRENTNO: supp_currentno, REST_FLG: true }], false)
                        .then(function (rows) {
                            //rows - array of the row components for the rows updated or added
                            $("#withoutorder-table").tabulator("redraw", true);

                            //if this is a NEW PO, do NOT proceed with additemtoPO

                            var row = rows[0];
                            //the adddata triggers a callback in the item-table-modal object that calls addItemToPo(database)

                            console.log(row);
                            $("#withoutorder-table").tabulator("scrollToRow", row)
                                .then(function () {
                                    addItemToPO(row, ponumber, true);

                                    $('#txtbxSparepartModal_withoutorder').val("");
                                    $("#txtbxSparepartModalparent_withoutorder").removeClass("success");
                                    $("#po_modal_next_withoutorder").removeClass("disabled");

                                    cell = row.getCell("ORDERQTY");
                                    var cellElement = cell.getElement();
                                    $(cellElement).focus();
                                    //run code after row has been scrolled to
                                })
                                .catch(function (error) {
                                    //handle error scrolling to row
                                    console.log(error)
                                    alert(error);
                                    alert("error in scroll DEBUG");
                                });

                            //run code after data has been updated
                        })
                        .catch(function (error) {
                            //handle error updating data
                            console.log("critical error: " + error);

                        });

                    return 1;
                }
                else {
                    return 0;
                }
            }

            function generate_automatic_po_items(id_item_from, supp_currentno, id_item_catg) {
                id_wh_item = warehouseID;
                var dataret = {};


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/generate_automatic_po_items",
                    data: "{'supp_currentno': '" + supp_currentno + "', 'id_item_from': '" + 22 + "', 'id_item_to': '" + 22 + "', 'main_method': '" + $('input[name=example2]:checked').val() + "', 'id_warehouse': '" + id_wh_item + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");

                        console.log(data.d);
                        //dataret = data.d[0];



                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
                return dataret;
            }

            function insert_global_to_item_master(id_item, supp_currentno, id_item_catg, id_wh_item) {
                id_wh_item = warehouseID;
                var dataret = {};


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "PurchaseOrder.aspx/insert_global_to_item_master",
                    data: "{'supp_currentno': '" + supp_currentno + "', 'id_item': '" + id_item + "', 'id_item_catg': '" + id_item_catg + "', 'id_warehouse': '" + id_wh_item + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");

                        console.log(data.d);
                        dataret = data.d[0];



                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
                return dataret;
            }


            $.contextMenu({
                selector: '#PO-table .tabulator-selected',   //only trigger contextmenu on selected rows in table
                items: {
                    open: {
                        name: "Åpne Bestilling",
                        icon: "paste",
                        callback: function (key, opt) {
                            //gets the selected row
                            var selectedRows = $("#PO-table").tabulator("getSelectedRows");
                            row = selectedRows[0];
                            openModalItemInformation(row, ""); //opens modal and shows information about the items on this order


                        }
                    },
                    brreg: {
                        name: "Bekreft bestilling",
                        icon: "fa-beer",
                        callback: function (key, opt) {
                            if (confirm("Bekreft bestilling?")) {
                                var rows = $("#PO-table").tabulator("getSelectedRows");
                                var row = rows[0];

                                var ponumber = row.getCell("NUMBER").getValue();
                                setPOtoConfirmed(ponumber, false);


                                // $("#item-table-modal-confirmedOrder").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", "{'POnum': '" + ponumber + "', 'isDeliveryTable': '" + false + "', 'supp_currentno': '" + supp_currentno + "'}", ajaxConfig);
                            }

                        },
                        disabled: function (key, opt) {
                            var rows = $("#PO-table").tabulator("getSelectedRows");
                            var row = rows[0];

                            if (row.getCell("STATUS").getValue() == 'True') {

                                return true;
                            }
                            else {

                                return false;
                            }

                        }
                    },

                    deletePO: {
                        name: "Slett bestilling",
                        icon: "attach",
                        callback: function (key, opt) {
                            if (confirm("Slette bestilling?")) {

                                deletePO();
                            }

                        },
                        disabled: function (key, opt) {
                            var rows = $("#PO-table").tabulator("getSelectedRows");
                            var row = rows[0];

                            if (row.getCell("STATUS").getValue() == 'True') {
                                return true;
                            }
                            else {
                                return false;
                            }

                        }
                    },

                    sub: {
                        "name": "Sub group",
                        "items": {
                            copy: {
                                name: "Kopier",
                                callback: function (key, opt) {

                                }
                            },

                            proff: {
                                name: "Åpne i Proff",
                                callback: function (key, opt) {

                                }
                            }
                        },
                        visible: function (key, opt) {
                            return false;
                        }
                    },
                    printRpt: {
                        "name": "Print",
                        "items": {
                            rptWithAllSpr: {
                                name: "Spares List",
                                callback: function (key, opt) {
                                    openFrmCtxMenu = true;
                                    var selectedRows = $("#PO-table").tabulator("getSelectedRows");
                                    row = selectedRows[0];
                                    ponumber = row.getCell("NUMBER").getValue();
                                    cbPanel.PerformCallback(ponumber + ";ALL");
                                }
                            }
                        }
                    }
                }
            });

            $('#icon_printBOReport').on('click', function (e) {
                cbBOReport.PerformCallback();

            });

            $('#searchbutton').on('click', function (e) {
                makePOsearch();

            });

            function makePOsearch() {
                var ponum = $('#<%=txtbxPOnumbersearch.ClientID%>').val();
                    console.log(ponum);
                    if (ponum == "" || ponum == undefined) {
                        ponum = "%";
                    }

                    var supp = $('#<%=txtbxInfoSupplier.ClientID%>').val();
                    if (supp == "" || supp == undefined) {
                        supp = "%";
                    }
                    var spare = $('#<%=txtbxSparepartNumber.ClientID%>').val();
                    if (spare == "" || spare == undefined) {
                        spare = "%";
                    }

                    var from = $('#<%=txtbxDateFrom.ClientID%>').val();
                    if (from == "" || from == undefined) {
                        from = 0;
                    }
                    else { from = convertDate(from); }

                    var to = $('#<%=txtbxDateTo.ClientID%>').val();
        if (to == "" || to == undefined) {
            to = 0;
        }
        else { to = convertDate(to); }



        $("#PO-table").tabulator("setData", "PurchaseOrder.aspx/Fetch_PurchaseOrders", { 'POnum': ponum, 'supplier': supp, 'fromDate': from, 'toDate': to, 'spareNumber': spare, 'isDelivered': false, 'isConfirmedOrder': $('#inp_confirmedOrder').is(":checked"), 'isUnconfirmedOrder': $('#inp_unconfirmedOrder').is(":checked"), 'isExactPOnum': false, 'isExactSupp': false })
            .then(function () {
                //run code after table has been successfuly updated
                $("#PO-table").tabulator("redraw", true);
                var rowCount = $("#PO-table").tabulator("getDataCount");
                $('#rowcounter').text(rowCount);
            })
            .catch(function (error) {
                //handle error loading data
            });

        $("#Archived-table").tabulator("setData", "PurchaseOrder.aspx/Fetch_PurchaseOrders", { 'POnum': ponum, 'supplier': supp, 'fromDate': from, 'toDate': to, 'spareNumber': spare, 'isDelivered': true, 'isConfirmedOrder': true, 'isUnconfirmedOrder': true, 'isExactPOnum': false, 'isExactSupp': false })
            .then(function () {
                //run code after table has been successfuly updated
                $("#Archived-table").tabulator("redraw", true);
                var rowCount = $("#Archived-table").tabulator("getDataCount");
                $('#rowcounterArchived').text(rowCount);
            })
            .catch(function (error) {
                //handle error loading data
            });

    }

    function getPurchaseOrderItems(ponumber) {
        var dataret = {};

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "PurchaseOrder.aspx/Fetch_PO_Item",
            data: "{'POnum': '" + ponumber + "', 'isDeliveryTable': '" + false + "'}",
            dataType: "json",
            async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
            success: function (data) {
                console.log("success");

                console.log(data.d);
                dataret = data.d[0];



            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }
        });
        return dataret;

    }

    /* When clicking delete item(fjern vare) delete the selected row */

    function deleteRowsFromTable(tablename) {
        var selectedRows = $(tablename).tabulator("getSelectedRows");
        var deleteLast = false;

        for (i = 0; i < selectedRows.length; i++) {
            if ($(tablename).tabulator("getRows").length === 1) {
                if (confirm("Du vil nå slette siste varen på bestillingen, og bestillingen vil bli slettet. Ønsker du dette?")) {
                    // deleteRowAjax(selectedRows[i]);    //deletes from db
                    deleteLast = true;
                }
                else { return; }

            }

            var ponumber;
            ponumber = $('#pomodal_details_ponumber').text();



            var ret = deleteRowAjax(selectedRows[i], ponumber);    //deletes from db. if 0, the row was not saved yet. If 1, the row was in db

            if (ret == 0) {

                dell(selectedRows[i]);
            }
            selectedRows[i].delete();          //deletes from table

            selectedRows[i].deselect();



        }
    }


    //muy importante lesson learned!!! DYNAMICALLY INSERTED HTML INSIDE JAVASCRIPT like I have done with footer-element inside tabulator-constructors
    //behave differently. They cannot be triggered the same way as if they were coded inside the html bit.
    //instead we use document.on etc..

    /* $('#btnDeleteRowModal').on('click', function (e) {

         ..

     });
     */
    $(document).on('click', '#btnDeleteRowModal', function (e) {
        if (confirm("Vil du slette varen(e)?")) {
            deleteRowsFromTable("#item-table-modal");
            $("#btnDeleteRowModal").addClass("disabled");
        }
    });





    function dell(row) {
        //the item has not been saved to the DB yet. 
        //if it has wo_item_seq, it means it is imported. Now we save it in memory, so that we can easily import it back locally if wanted
        //if it has no wo_item_seq, we just delete it.

        if (row.getData().ID_WOITEM_SEQ != "undefined") {

            myNameSpace.set("importedButDeletedRows", row.getData());
            var available_imports = $('#lbl_available_imports').text();
            var newVal = parseInt(available_imports) + 1
            $('#lbl_available_imports').text(newVal);

            $('#lbl_available_imports').transition('flash');

        }
    }


    function deleteRowAjax(row, ponumber) {
        var dataret = {};
        var id_woitem_seq = row.getData().ID_WOITEM_SEQ;
        if (id_woitem_seq == "") id_woitem_seq = -1;

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "PurchaseOrder.aspx/deletePOitem",
            data: "{ponumber:'" + ponumber + "',id_woitem_seq:'" + id_woitem_seq + "',id_item:'" + row.getData().ID_ITEM + "'}",
            dataType: "json",
            async: false,//Very important
            success: function (data) {
                {
                    if (data.d.length != 0) {

                        dataret = data.d;


                    }
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }

        });
        return dataret;
    }


    function fetchLocalItem(spareNum) {
        var dataret = {};
        var value = 0;


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "LocalSPDetail.aspx/SparePart_Search",
            data: "{'q': '" + spareNum + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $('#pomodal_details_supplier').text() + "', 'nonStock': '" + false + "', 'accurateSearch': '" + true + "'}",
            dataType: "json",
            async: false,//Very important
            success: function (data) {

                if (data.d.length != 0) {

                    dataret = data.d;
                    myNameSpace.set("item_catg_desc", data.d[0].ITEM_CATG_DESC)
                    myNameSpace.set("id_item_catg", data.d[0].ID_ITEM_CATG)

                    myNameSpace.set("cost_price1", data.d[0].COST_PRICE1);
                    myNameSpace.set("item_price", data.d[0].ITEM_PRICE);
                    myNameSpace.set("net_price", data.d[0].NET_PRICE);
                    myNameSpace.set("basic_price", data.d[0].BASIC_PRICE);

                    myNameSpace.set("item_desc", data.d[0].ITEM_DESC);
                    myNameSpace.set("item_avail_qty", data.d[0].ITEM_AVAIL_QTY);

                    value = 1;

                }

            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }

        });
        return value;
    }


    function fetch_num_items_indelivery(ponumber, supp_currentno, id_item) {
        var dataret = {};

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "PurchaseOrder.aspx/fetch_po_items_indelivery",
            data: "{POnum:'" + ponumber + "',supp_currentno:'" + supp_currentno + "',id_item:'" + id_item + "'}",
            dataType: "json",
            async: false,//Very important
            success: function (data) {
                {
                    if (data.d.length != 0) {

                        dataret = data.d;


                    }
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }

        });
        return dataret;
    }


    /** BEFORE ADDING AN ITEM TO THE TABLE, WE NEED TO VALIDATE THE FIELDS WHETHER THEY ARE FILLED CORRECTLY ETC **/
    function validFields(leverandor, ankomst, ordretype, forsendelse, varegruppe, nr, ant, kost, total) {

        var retValue = 1;
        var alreadyAlerted = 0;

        if ($.inArray(nr, items) !== -1) {

            alert("Denne varen er allerede lagt til!");
            retValue = 0;
            alreadyAlerted = 1;
        }

        if (leverandor == undefined || leverandor == "") {

            retValue = 0;
            if (!alreadyAlerted) {
                alert("Leverandør mangler");
                alreadyAlerted = 1;
            }

        }

        if (ankomst == undefined || ankomst == "") {

            retValue = 0;
            if (!alreadyAlerted) {
                alert("Forventet ankomstdato mangler");
                alreadyAlerted = 1;
            }
        }

        if (ordretype == undefined || ordretype == "") {

            retValue = 0;
            if (!alreadyAlerted) {
                alert("Bestillingstype mangler");
                alreadyAlerted = 1;
            }
        }
        if (forsendelse === undefined || forsendelse === "") {
            retValue = 0;
            if (!alreadyAlerted) {
                alert("Forsendelse mangler");
                alreadyAlerted = 1;
            }
        }


        if (nr === undefined || nr === "") {

            retValue = 0;
            if (!alreadyAlerted) {
                alert("Varenr mangler");
                alreadyAlerted = 1;
            }
        }


        return retValue;
    }


    $("#dropdown_modal_ordertype").change(function () {
        var val = $('#dropdown_modal_ordertype').dropdown('get value');

        $('#pomodal_details_ordertype').text(val);

        var supp_currentno = $('#txtbxSuppcurrentnoModal').val();
        getImportedOrderItems(supp_currentno, val, true)
    });


    function deletePO(ponumber) {
        var rowcount = $('#rowcounter').text();
        var selectedRows = $("#PO-table").tabulator("getSelectedRows");
        row = selectedRows[0];
        ponumber = row.getCell("NUMBER").getValue();

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "PurchaseOrder.aspx/deletePO",
            data: "{ponumber:'" + ponumber + "'}",
            dataType: "json",
            async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
            success: function (data) {


            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }
        });
        row.delete();
        $('#rowcounter').text(rowcount - 1);
    }

    function getImportedOrderItems(supp_currentno, id_ordertype, isModal) {
        var dataret = {};


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "PurchaseOrder.aspx/importPOitemsFromWO",
            data: "{'supp_currentno': '" + supp_currentno + "', 'id_ordertype': '" + id_ordertype + "'}",
            dataType: "json",
            async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
            success: function (data) {
                console.log("success");
                console.log("HERE");
                console.log(data.d);
                dataret = data.d;
                if (isModal) {
                    $('#lbl_available_imports_modal').text(data.d.length);
                    if (data.d.length > 0) {
                        $("#po_modal_import").removeClass("disabled");
                    }
                }



            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }
        });

        return dataret;

    }

    function initBeforeFirstModalStepViewAutomatic() {

        var deliverymethod = 11;
        //myNameSpace.set("po_modal_state", 0);

        //txtbxSupplierModalAutomatic.val("");
        //txtbxSupplierModalAutomatic.removeClass("success");
        //myNameSpace.set("po_modal_ddlnonstock", false);

        getPOnumber();

        //content divs(tables)
        //$('.modal_withoutorder_divstep0').removeClass('hidden');
        $('.modal_withoutorder_divstep1').addClass('hidden');
        $('.modal_withoutorder_divstep0').removeClass('hidden');



        //header steps
        $("#step_auto_first_withoutorder").removeClass("completed step");
        $("#step_auto_first_withoutorder").removeClass("disabled step");
        $("#step_auto_first_withoutorder").addClass("active step");

        $("#step_auto_second_withoutorder").removeClass("completed step");
        $("#step_auto_second_withoutorder").removeClass("active step");
        $("#step_auto_second_withoutorder").addClass("disabled step");

        $("#step_auto_third_withoutorder").removeClass("completed step");
        $("#step_auto_third_withoutorder").removeClass("active step");
        $("#step_auto_third_withoutorder").addClass("disabled step");

        $("#step_auto_third_withoutorder").removeClass("completed step");
        $("#step_auto_third_withoutorder").removeClass("active step");
        $("#step_auto_third_withoutorder").addClass("disabled step");

        //buttons
        $("#po_modal_next_withoutorder").text("Neste");
        $("#po_modal_next_withoutorder").append('<i class="chevron right icon"</i>');
        $("#po_modal_next_withoutorder").addClass("disabled");
        //$("#po_modal_previous").hide(); 
        //$("#po_modal_cancel").hide();
        $("#btnDownloadPDF_withoutorder").hide();
        $("#btnDownloadCSV_withoutorder").hide();

        var today = $.datepicker.formatDate('dd-mm-yy', new Date());
        $('#txtbxExpDeliveryxx').val(today)

        myNameSpace.set("modal_withoutorder_state", 0);

        $('#modal_withoutorder_steps').modal('show');

        $('#modal_withoutorder_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh




    }



    function initBeforeFirstModalStepViewWithoutOrder() {

        var deliverymethod = 11;
        //myNameSpace.set("po_modal_state", 0);

        //txtbxSupplierModalAutomatic.val("");
        //txtbxSupplierModalAutomatic.removeClass("success");
        //myNameSpace.set("po_modal_ddlnonstock", false);

        getPOnumber();

        //content divs(tables)
        //$('.modal_withoutorder_divstep0').removeClass('hidden');
        $('.modal_withoutorder_divstep1').addClass('hidden');
        $('.modal_withoutorder_divstep0').removeClass('hidden');



        //header steps
        $("#step_auto_first_withoutorder").removeClass("completed step");
        $("#step_auto_first_withoutorder").removeClass("disabled step");
        $("#step_auto_first_withoutorder").addClass("active step");

        $("#step_auto_second_withoutorder").removeClass("completed step");
        $("#step_auto_second_withoutorder").removeClass("active step");
        $("#step_auto_second_withoutorder").addClass("disabled step");

        $("#step_auto_third_withoutorder").removeClass("completed step");
        $("#step_auto_third_withoutorder").removeClass("active step");
        $("#step_auto_third_withoutorder").addClass("disabled step");

        $("#step_auto_third_withoutorder").removeClass("completed step");
        $("#step_auto_third_withoutorder").removeClass("active step");
        $("#step_auto_third_withoutorder").addClass("disabled step");

        //buttons
        $("#po_modal_next_withoutorder").text("Neste");
        $("#po_modal_next_withoutorder").append('<i class="chevron right icon"</i>');
        $("#po_modal_next_withoutorder").addClass("disabled");
        //$("#po_modal_previous").hide(); 
        //$("#po_modal_cancel").hide();
        $("#btnDownloadPDF_withoutorder").hide();
        $("#btnDownloadCSV_withoutorder").hide();

        var today = $.datepicker.formatDate('dd-mm-yy', new Date());
        $('#txtbxExpDeliveryxx').val(today)

        myNameSpace.set("modal_withoutorder_state", 0);

        $('#modal_withoutorder_steps').modal('show');

        $('#modal_withoutorder_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh




    }

    function first() {
        return new Promise(function (resolve, reject) {
            setTimeout(function () {

                $('.circle-loader').toggleClass('load-complete');
                $('.checkmark2').toggle();

                second();
            }, 2000);
        });
    }
    function second() {


        $(".modal_po_divstepCheckmark").fadeTo(1800, 0, function () {
            // Animation complete.
        });

        $(".modal_po_divstep4").fadeTo(2200, 1, function () {
            // Animation complete.
            $('.circle-loader').toggleClass('load-complete');
            $('.checkmark2').toggle();
        });

    }



    function setPOtoConfirmed(ponumber, sentorfinished) {

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "PurchaseOrder.aspx/setPOtoSent",
            data: "{ponumber:'" + ponumber + "', 'sentorfinished': '" + sentorfinished + "'}",
            dataType: "json",
            async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
            success: function (data) {
                dataret = data.d[0];



            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }
        });
    }

    function updatePOitem(ponumber, polineno, orderqty, buycost, totalcost, delivered) {


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "PurchaseOrder.aspx/updatePOitem",
            data: "{ponumber:'" + ponumber + "', 'polineno': '" + polineno + "', 'orderqty': '" + orderqty + "', 'buycost': '" + buycost + "', 'totalcost': '" + totalcost + "', 'delivered': '" + delivered + "'}",
            dataType: "json",
            async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
            success: function (data) {
                console.log("success");
                console.log(data.d);
                dataret = data.d[0];

            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
            }
        });
    }

    //function getPOlinenoAjax(row)
    //{
    //    var dataret = {};

    //    $.ajax({
    //        type: "POST",
    //        contentType: "application/json; charset=utf-8",
    //        url: "PurchaseOrder.aspx/getPOlineno",
    //        data: "{ponumber:'" + $('#pomodal_details_ponumber').text() + "',id_item:'" + row.getCell("ID_ITEM").getValue() + "',id_woitem_seq:'" + row.getCell("ID_WOITEM_SEQ").getValue() + "'}",
    //        dataType: "json",
    //        async: false,//Very important
    //        success: function (data) {
    //            {
    //                if (data.d.length != 0) {

    //                    dataret = data.d;
    //                }
    //            }
    //        },
    //        error: function (xhr, ajaxOptions, thrownError) {
    //            console.log(xhr.status);
    //            console.log(xhr.responseText);
    //            console.log(thrownError);
    //        }

    //    });

    //    return dataret;
    //}

    //function getPOlineno(tablename, id_item)
    //{
    //    var polineno = -1;
    //    console.log(id_item);

    //    therows = $(tablename).tabulator("getRows");
    //    for(i = 0; i < therows.length; i++)
    //    {

    //        if (therows[i].getData().ID_ITEM === id_item)
    //        {
    //            polineno = i+1;

    //        }
    //    }
    //    return polineno;

    //}


    function openModalItemInformation(row, table) {

        var confirmed;
        var finished;
        //checks if its a confirmed order and only to show the last tab in modal or if its not confirmed yet.
        if (table == "Archived") {
            finished = "True";
        }
        else {
            confirmed = row.getCell("STATUS").getValue();
            finished = row.getCell("FINISHED").getValue();
        }



        if (finished === "True") {

            $("#btnPrintReport").show();
            initFourthModalStepView(row, false);  //LAST
        }

        else if (confirmed === "True")   //third
        {
            $("#btnPrintReport").hide();
            initThirdModalStepView(row);
        }

        else  //not finished, not confirmed, so we open the FIRST STEP
        {
             $("#btnPrintReport").hide();
            initFirstModalStepView(row);

        }


    }

    function initBeforeFirstModalStepView() {

        var deliverymethod = 11;

        myNameSpace.set("po_delivered", false);
        $("#txtbxSparepartModal").val("");
        myNameSpace.set("po_modal_ddlnonstock", false);

        getPOnumber();


        //content divs(tables)
        $('.modal_po_divstep0').removeClass('hidden');
        $('.modal_po_divstep1').addClass('hidden');
        $('.modal_po_divstep2').addClass('hidden');
        $('.modal_po_divstep3').addClass('hidden');
        $('.modal_po_divstep4').addClass('hidden');
        $('.modal_po_divstepCheckmark').addClass('hidden');

        //header steps
        $("#step_po_before_first").removeClass("completed step");
        $("#step_po_before_first").removeClass("disabled step");
        $("#step_po_before_first").addClass("active step");

        $("#step_po_first").removeClass("completed step");
        $("#step_po_first").removeClass("active step");
        $("#step_po_first").addClass("disabled step");

        $("#step_po_second").removeClass("active step");
        $("#step_po_second").removeClass("completed step");
        $("#step_po_second").addClass("disabled step");

        $("#step_po_third").removeClass("active step");
        $("#step_po_third").removeClass("completed step");
        $("#step_po_third").addClass("disabled step");

        $("#step_po_fourth").removeClass("active step");
        $("#step_po_fourth").addClass("disabled step");


        //buttons
        $("#po_modal_next").text("Neste");
        $("#po_modal_next").append('<i class="chevron right icon"</i>');
        $("#po_modal_next").addClass("disabled");
        $("#po_modal_import").hide();
        $("#po_modal_update").hide();
        $("#po_modal_sendMenu").hide();
        $("#po_modal_previous").hide();
        $("#po_modal_cancel").hide();
        $("#btnDownloadPDF").hide();
        $("#btnDownloadCSV").hide();

        var today = $.datepicker.formatDate('dd-mm-yy', new Date());
        $('#txtbxExpDelivery').val(today)

        myNameSpace.set("po_modal_state", 0);

        $('#modal_po_steps').modal('show');

        $('#modal_po_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh

        $("#item-table-modal").tabulator("clearData");
    }


    function initFirstModalStepView(row) {
        //brings over various variables from grid to the modal window
        var ponumber = row.getCell("NUMBER").getValue();
        var supp_currentno = row.getCell("SUPP_CURRENTNO").getValue();
        var ordertype = row.getCell("ID_ORDERTYPE").getValue();

        //gets items 
        //var ret_data = getPurchaseOrderItems(ponumber);


        var deliverymethod = 11;

        myNameSpace.set("po_delivered", false);
        $("#txtbxSparepartModal").val("");
        myNameSpace.set("po_modal_ddlnonstock", false);
        $('#pomodal_details_ponumber').text(ponumber);
        $('#pomodal_details_supplier').text(supp_currentno);
        $('#pomodal_details_ordertype').text(ordertype);
        $('#pomodal_details_delmethod').text(deliverymethod);

        myNameSpace.set("po_modal_newPO", false);

        $('#redRibbonPOmodal').text(ponumber);
        //(fourth step)
        $('#pomodal_details_ponumber4').text(ponumber);
        $('#pomodal_details_supplier4').text(supp_currentno);

        //content divs(tables)

        $('.modal_po_divstep0').addClass('hidden');
        $('.modal_po_divstep1').removeClass('hidden');

        $('.modal_po_divstep2').addClass('hidden');
        $('.modal_po_divstep3').addClass('hidden');
        $('.modal_po_divstep4').addClass('hidden');
        $('.modal_po_divstepCheckmark').addClass('hidden');

        //header steps
        $("#step_po_before_first").removeClass("active step");
        $("#step_po_before_first").addClass("completed step");
        $("#step_po_before_first").addClass("disabled step");

        $("#step_po_first").removeClass("completed step");
        $("#step_po_first").removeClass("disabled step");
        $("#step_po_first").addClass("active step");

        $("#step_po_second").removeClass("active step");
        $("#step_po_second").removeClass("completed step");
        $("#step_po_second").addClass("disabled step");

        $("#step_po_third").removeClass("active step");
        $("#step_po_third").removeClass("completed step");
        $("#step_po_third").addClass("disabled step");

        $("#step_po_fourth").removeClass("active step");
        $("#step_po_fourth").addClass("disabled step");



        //buttons

        $("#po_modal_next").removeClass("disabled");
        $("#po_modal_next").text("Bekreft bestilling");
        $("#po_modal_next").append('<i class="checkmark icon"></i>');
        $("#po_modal_previous").addClass("disabled");
        $("#po_modal_previous").show();

        $("#po_modal_import").addClass("disabled");
        $("#po_modal_import").show();
        $("#btnDownloadPDF").hide();
        $("#btnDownloadCSV").hide();
        $("#po_modal_sendMenu").hide();
        $("#po_modal_update").show();
        $("#po_modal_update").addClass("disabled");
        $("#po_modal_cancel").remove();

        getImportedOrderItems(supp_currentno, ordertype, true);
        myNameSpace.set("po_modal_state", 1);

        $('#modal_po_steps').modal('show');
        $("#item-table-modal").tabulator("redraw");

        $("#item-table-modal").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", { 'POnum': ponumber, 'isDeliveryTable': false, 'supp_currentno': supp_currentno });
        $("#item-table-modal").tabulator("redraw", true);
        $('#modal_po_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
    }

    function initThirdModalStepView(row) {

        if (row != false) {
            var ponumber = row.getCell("NUMBER").getValue();
            var supp_currentno = row.getCell("SUPP_CURRENTNO").getValue();
        }
        else {
            var ponumber = 300000;
            var supp_currentno = 300000;
        }

        //labels
        $('#pomodal_details_ponumber4').text(ponumber);
        $('#pomodal_details_supplier4').text(supp_currentno);
        //$('#pomodal_details_ordertype4').text(ordertype);
        myNameSpace.set("po_delivered", false);
        //content divs
        $('.modal_po_divstep0').addClass('hidden');
        $('.modal_po_divstep1').addClass('hidden');
        $('.modal_po_divstep2').addClass('hidden');
        $('.modal_po_divstep4').addClass('hidden');
        $('.modal_po_divstep3').removeClass('hidden');
        $('#item-table-modal-delivery').removeClass('hidden');
        $('.modal_po_divstepCheckmark').addClass('hidden');


        //header steps
        $("#step_po_before_first").removeClass("active step");
        $("#step_po_before_first").addClass("completed step");
        $("#step_po_before_first").addClass("disabled step")
        $("#step_po_first").addClass("completed step");
        $("#step_po_first").addClass("disabled step");
        $("#step_po_second").removeClass("active step");
        $("#step_po_second").addClass("completed step");
        $("#step_po_second").addClass("disabled step")
        $("#step_po_fourth").removeClass("active step");
        $("#step_po_fourth").addClass("disabled step")
        $("#step_po_third").removeClass("disabled step");
        $("#step_po_third").removeClass("completed step");
        $("#step_po_third").addClass("active step");


        //buttons
        $("#po_modal_next").show();
        $("#po_modal_next").text("Neste");
        $("#po_modal_next").append('<i class="chevron right icon"></i>');
        $("#po_modal_update").show();
        $("#po_modal_sendMenu").hide();
        $('#po_modal_update').removeClass('disabled');
        $('#po_modal_previous').removeClass('disabled');
        $("#po_modal_previous").show();
        $("#po_modal_cancel").hide();
        $("#po_modal_import").hide();
        $('#redRibbonPOmodal').text(ponumber);
        $("#btnDownloadPDF").show();
        $("#btnDownloadCSV").show();

        //update state
        myNameSpace.set("po_modal_state", 3);
        //myNameSpace.set("po_modal_state_canclose", 1);
        console.log("new state: " + myNameSpace.get("po_modal_state"));

        $('#modal_po_steps').modal('show');
        if (row != false) {
            $("#item-table-modal-delivery").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", { 'POnum': ponumber, 'isDeliveryTable': true, 'supp_currentno': supp_currentno });
        }
        else {
            $("#item-table-modal-delivery").tabulator("clearData");
        }


        setTimeout(function () { $('.arrival').transition('flash'); $('.arrival').transition('flash'); }, 700);

    }

    function initFourthModalStepView(row, fromPreviousStep, justdelivered) {


        //$('#pomodal_details_ordertype4').text(ordertype);

        if (fromPreviousStep) {
            myNameSpace.set("po_modal_state_canclose", 0);
            myNameSpace.set("po_modal_state", 4);
            $("#po_modal_previous").show();

            $("#po_modal_previous").removeClass("disabled");
            var ponumber = $('#redRibbonPOmodal').text()
            var supp_currentno = row.getCell("SUPP_CURRENTNO").getValue();
        }
        else {
            var ponumber = row.getCell("NUMBER").getValue();
            var supp_currentno = row.getCell("SUPP_CURRENTNO").getValue();
            //labels
            $('#pomodal_details_ponumber4').text(ponumber);
            $('#pomodal_details_supplier4').text(supp_currentno);
            myNameSpace.set("po_modal_state_canclose", 1);
            myNameSpace.set("po_modal_state", 4);
            $('#modal_po_steps').modal('show');

            $("#po_modal_previous").hide();
        }
        $('#modal_po_steps').modal('refresh');
        //content divs
        $('.modal_po_divstep0').addClass('hidden');
        $('.modal_po_divstep1').addClass('hidden');
        $('.modal_po_divstep2').addClass('hidden');
        $('.modal_po_divstep3').addClass('hidden');
        $('.modal_po_divstepCheckmark').addClass('hidden');


        if (justdelivered) {
            $('.modal_po_divstepCheckmark').removeClass('hidden');
            $('.modal_po_divstep4').css('opacity', '0');
            $('.modal_po_divstepCheckmark').css('opacity', '1');
            first();
        }
        else {
            $('.modal_po_divstep4').css('opacity', '1');
        }
        $('.modal_po_divstep4').removeClass('hidden');

        //header steps
        $("#step_po_before_first").removeClass("active step");
        $("#step_po_before_first").addClass("completed step");
        $("#step_po_before_first").addClass("disabled step")

        $("#step_po_first").addClass("completed step");
        $("#step_po_first").addClass("disabled step");

        $("#step_po_second").removeClass("active step");
        $("#step_po_second").addClass("completed step");
        $("#step_po_second").addClass("disabled step");

        $("#step_po_third").removeClass("active step");
        if (!fromPreviousStep) $("#step_po_third").addClass("completed step");
        $("#step_po_third").addClass("disabled step");

        $("#step_po_fourth").removeClass("disabled step");
        $("#step_po_fourth").addClass("active step");


        //buttons
        $("#po_modal_next").text("Lukk");
        $("#po_modal_next").append('<i class="checkmark icon"></i>');
        $("#po_modal_update").hide();
        $("#po_modal_sendMenu").hide();
        $("#btnDownloadPDF").show();
        $("#btnDownloadCSV").show();
        $("#po_modal_import").hide();
        $("#po_modal_cancel").hide();
        $('#redRibbonPOmodal').text(ponumber);


        $("#item-table-modal-final").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", { 'POnum': ponumber, 'isDeliveryTable': false, 'supp_currentno': supp_currentno });

        //update state




    }


    $('#inp_confirmedOrder, #inp_unconfirmedOrder').on('click', function (e) {


        if ($(this).not(':checked').length) {
            if (this.id === "inp_confirmedOrder" && $("#inp_unconfirmedOrder").not(':checked').length) {

                $('#inp_unconfirmedOrder').prop('checked', true);
            }
            else if (this.id === "inp_unconfirmedOrder" && $("#inp_confirmedOrder").not(':checked').length) {
                $('#inp_confirmedOrder').prop('checked', true);
            }

        }
    });

    $('#inp_delivered, #inp_delivered_not').on('click', function (e) {


        if ($(this).not(':checked').length) {
            if (this.id === "inp_delivered" && $("#inp_delivered_not").not(':checked').length) {

                $('#inp_delivered_not').prop('checked', true);
            }
            else if (this.id === "inp_delivered_not" && $("#inp_delivered").not(':checked').length) {
                $('#inp_delivered').prop('checked', true);
            }

        }
    });

    $("#txtbxSpareNum").focus(function (e) {
        //stuff to do on mouseover
        if (!myNameSpace.get("focus_set_once")) {
            openOrCloseFieldArea($('#btnViewDetailsNEWPO'), e, '#btnViewDetailsNEWPO'.id);
            myNameSpace.set("focus_set_once", true)
        }


    });

    /* On click for searchbutton and the show/hide icon. Hides the container div that contains input fields etc so that only our table is displayed */
    $('#btnViewDetails, #searchbutton, #btnViewDetailsNEWPO').on('click', function (e) {
        openOrCloseFieldArea($(this), e, this.id);
    });

    function openOrCloseFieldArea(targetElement, e, id) {

        if (e) {
            e.preventDefault();
            e.stopPropagation();
        }
        var containerElement;
        if (id == "searchbutton") containerElement = $(targetElement).parent().parent().parent(); //fucking ridiculous hahahahha. 
        else containerElement = $(targetElement).parent().next();

        console.log("hey");
        console.log(containerElement);
        console.log("hey");

        var hiddenicon = false;
        if ($(containerElement).is(":hidden")) {
            hiddenicon = true;
        }

        $(containerElement).slideToggle(300);
        if (hiddenicon == true) {
            $(targetElement).find('i.icon').removeClass('down').addClass('up')
        }
        else {
            $(targetElement).find('i.icon').removeClass('up').addClass('down');
        }

        if ($(containerElement).is(":hidden")) {
            var hiddenicon = true;
        }
    }




    $('#btnDownloadCSV').on('click', function (e) {
        $("#item-table-modal").tabulator("download", "csv", "data.csv");
    });

    $('#btnDownloadPDF').on('click', function (e) {

        var currentTable;

        if (myNameSpace.get("po_modal_state") == 2) {
            currentTable = "#item-table-modal-confirmedOrder";

        }

        else if (myNameSpace.get("po_modal_state") == 3) {
            currentTable = "#item-table-modal-delivery";

        }

        else if (myNameSpace.get("po_modal_state") == 4) {
            currentTable = "#item-table-modal-final";

        }
        $(currentTable).tabulator("download", "pdf", "Bestilling " + $('#redRibbonPOmodal').text() + ".pdf", {
            orientation: "landscape", //set page orientation to portrait
            // title:"Bestillingsnummer : " + $('#pomodal_details_ponumber').text(), //add title to report

            autoTable: function (doc) {
                //doc - the jsPDF document object

                //add some text to the top left corner of the PDF
                //doc.text("Bestillingsnummer " + $('#pomodal_details_ponumber').text(), 15, 15);


                //return the autoTable config options object
                return {
                    //styles: {
                    //    fillColor: [96, 162, 227]
                    //},
                    margin: { top: 120 },
                    addPageContent: function (data) {
                        doc.text("Bestillingsnummer : " + $('#pomodal_details_ponumber').text(), 40, 40);
                        doc.text("Leverandør : " + $('#pomodal_details_supplier').text(), 40, 60);
                        doc.text("Dato : " + "11/1/11", 40, 80);
                        doc.text("Bestilt av : " + "Koenraad", 40, 100);
                    }

                };
            },
        });
    });


    $("input[name='example2']").on('change', function () {

    });

    $('#dropdown_modal_ordertype')
        .dropdown({
            clearable: true,
            placeholder: 'any'
        });


    /** THIS IS THE SECTION WHERE THE LOGIC BEHIND AUTOMATIC PURCHASEORDERS ARE HANDLED
    
     */

    function createAutomaticPurchaseOrder() {
        var supp_currentno, ordertype, shipping_method, expected_delivery, item_id_from, item_id_to;
        var setting_main = $('input[name=example2]:checked').val();  //gives the checked radio button. So either based on historic, this year, minimum and only items without minimum
        //historisk omsetning


    }








    /**  OUR TABLES CREATED BY THE GREAT TABULATOR PLUGIN. **/
    /**  THE TABULATOR WEBPAGE IS http://tabulator.info    HERE YOU CAN FIND ALL INFO YOU NEED ABOUT THIS TABLE PLUGIN **/





    /* TABLE IN MODAL FOR DISPLAYING ADDED ITEMS TO ORDER */


    var customSelectEditor = function (cell, onRendered, success, cancel) {
        //cell - the cell component for the editable cell
        //onRendered - function to call when the editor has been rendered
        //success - function to call to pass the succesfully updated value to Tabulator
        //cancel - function to call to abort the edit and return to a normal cell

        var editor = $("<input type='number'></input>");
        editor.css({
            "padding": "3px",
            "width": "100%",
            "box-sizing": "border-box",
        });
        //Set value of editor to the current value of the cell
        editor.val(cell.getValue());

        onRendered(function () {
            editor.focus();
            editor.css("height", "100%");
            editor.select();

        });

        var data = cell.getData();
        console.log(data);
        //when the value has been set, trigger the cell to update
        editor.on("change blur", function (e) {
            success(editor.val());


            setTimeout(function () {

                $('#txtbxSpareNum').focus();
            }, 0);
        });
        return editor[0];

    }
    //we can use cell.gettable to just use one frigging method
    var customSelectEditor2 = function (cell, onRendered, success, cancel) {
        //cell - the cell component for the editable cell
        //onRendered - function to call when the editor has been rendered
        //success - function to call to pass the succesfully updated value to Tabulator
        //cancel - function to call to abort the edit and return to a normal cell

        var editor = $("<input type='number'></input>");
        editor.css({
            "padding": "3px",
            "width": "100%",
            "box-sizing": "border-box",
        });
        //Set value of editor to the current value of the cell
        editor.val(cell.getValue());

        onRendered(function () {
            editor.focus();
            editor.css("height", "100%");
            editor.select();

        });

        var data = cell.getData();
        console.log(data);
        //when the value has been set, trigger the cell to update
        editor.on("change blur", function (e) {
            success(editor.val());


            setTimeout(function () {

                $('#txtbxSparepartModal').focus();
            }, 0);
        });
        return editor[0];

    }

    var customSelectEditor3 = function (cell, onRendered, success, cancel) {
        //cell - the cell component for the editable cell
        //onRendered - function to call when the editor has been rendered
        //success - function to call to pass the succesfully updated value to Tabulator
        //cancel - function to call to abort the edit and return to a normal cell

        var editor = $("<input type='number'></input>");
        editor.css({
            "padding": "3px",
            "width": "100%",
            "box-sizing": "border-box",
        });
        //Set value of editor to the current value of the cell
        editor.val(cell.getValue());

        onRendered(function () {
            editor.focus();
            editor.css("height", "100%");
            editor.select();

        });

        var data = cell.getData();
        console.log(data);
        //when the value has been set, trigger the cell to update
        editor.on("change blur", function (e) {
            success(editor.val());


            setTimeout(function () {

                $('#txtbxSparepartModal_withoutorder').focus();
            }, 0);
        });
        return editor[0];

    }
    //define custom accessor
    var booleanToYesNo = function (value, data, type, params, column) {
        //value - original value of the cell
        //data - the data for the row
        //type - the type of access occurring  (data|download|clipboard)
        //params - the accessorParams object passed from the column definition
        //column - column component for the column this accessor is bound to

        if (value == true) { value = "JA" };
        if (value == false) { value = "NEI" };
        return value; //return the new value for the cell data.
    }


    var infoIcon = function (cell, formatterParams) { //plain text value
        return "<i class='fas fa-info'></i>";
    };
    //Tabulator.prototype.extendModule("format", "formatters", {
    //    bold: function (cell, formatterParams) {
    //        return "<strong>" + cell.getValue() + "</strong>"; //make the contents of the cell bold
    //    },
    //    trafficLight: function (cell, formatterParams) {
    //        var value = "";
    //        alert(cell.getValue())
    //        if (cell.getValue() > 3) { value = "<i class='fa fa-circle' style='color: #2DC214;'></i>" }
    //        else if (cell.getValue() < 1) { value = "<i class='fa fa-circle' style='color: #CE1515;'></i>" }
    //        else  { value = "<i class='fa fa-circle' style='color: #f4e542;'></i>" }
    //        return value //make the contents of the cell uppercase
    //    }
    //});



    $("#withoutorder-table").tabulator({
        // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
        height: 340,
        layout: "fitColumns", //fit columns to width of table (optional)
        selectable: true,     //true means we can select multiple rows   
        placeholder: "Ingen varer", //display message to user on empty table
        ajaxConfig: "POST", //ajax HTTP request type
        ajaxContentType: "json", // send parameters to the server as a JSON encoded string

        columns: [ //Define Table Columns
            { formatter: infoIcon, width: 40, align: "center", cellClick: function (e, cell) { openItemInformation(cell.getData().ID_ITEM, cell.getData().SUPP_CURRENTNO) } },
            { title: "Varenr", field: "ID_ITEM", align: "center" },
            { title: "Varenavn", field: "ITEM_DESC", align: "center" },
            { title: "Varegruppe", field: "ITEM_CATG_DESC", align: "center" },
            {
                title: "Kostpris", field: "COST_PRICE1", align: "center", cssClass: "myEditableCell", editor: "number", editorParams: { min: 0, max: 999999, step: 0.01 }, formatter: "money", formatterParams: {
                    decimal: ",",
                    thousand: ".",
                    symbol: "",
                    symbolAfter: "p",
                    precision: 2,
                }
            },
            {
                title: "Totalkostnad", field: "TOTALCOST", align: "center", formatter: "money", formatterParams: {
                    decimal: ",",
                    thousand: ".",
                    symbol: "",
                    symbolAfter: "p",
                    precision: 2,
                }
            },
            { title: "I bestilling", field: "INDELIVERY", align: "center" },
            { title: "Beholdning", field: "ITEM_AVAIL_QTY", align: "center" },
            { title: "Bestill", field: "ORDERQTY", align: "center", cssClass: "myEditableCell", editor: customSelectEditor3 },
            { title: "VaregruppeID", field: "ID_ITEM_CATG", visible: false }, //create hidden column. only so that we can easily provide the id_item_catg
            { title: "Supp", field: "SUPP_CURRENTNO", visible: false },
            { title: "Salgspris", field: "ITEM_PRICE" },
            { title: "Nettopris", field: "NET_PRICE" },
            { title: "Veilende", field: "BASIC_PRICE" },

        ],
        downloadReady: function (fileContents, blob) {
            //fileContents - the unencoded contents of the file
            //blob - the blob object for the download

            //custom action to send blob to server could be included here
            //  sendEmail

            window.open(window.URL.createObjectURL(blob));

            return blob; //must return a blob to proceed with the download, return false to abort download
        },

        cellEdited: function (cell) {

            //IF cell is a totalcost cell, then do not trigger this. Totalcost gets edited but only through buy*orderqty
            if (cell.getField() !== "TOTALCOST") {
                var row = cell.getRow();
                var totalCell = row.getCell("TOTALCOST");
                var buycost = cell.getData().COST_PRICE1
                var orderqty = cell.getData().ORDERQTY;

                var total = cell.getData().COST_PRICE1 * cell.getData().ORDERQTY;

                totalCell.setValue(total, true);

                var delivered = false;

                var ponumber = $('#pomodal_details_ponumber').text();
                $('#po_modal_update').removeClass('disabled');

            }



        },


        rowSelectionChanged: function (data, rows) {
            //rows - array of row components for the selected rows in order of selection
            //data - array of data objects for the selected rows in order of selection
            if (rows.length === 0) {
                $("#btnDeleteRowModal").addClass("disabled");
            }
            else {
                $("#btnDeleteRowModal").removeClass("disabled");
            }
        },

        ajaxResponse: function (url, params, response) {
            console.log("url is: " + url);
            console.log("params is: " + params);

            //url - the URL of the request
            //params - the parameters passed with the request
            //response - the JSON object returned in the body of the response.

            return response.d; //return the d property of a response json object
        },
        dataLoading: function (data) { //we need this because data that comes in is strings, cant be 
            //data - the data loading into the table
        },



        rowAdded: function (row) {
            //row - row component
            $('#po_modal_update').removeClass('disabled');
            $('#modal_po_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
        },

        footerElement: $("<div class='tabulator-footer'><input type='button' id='btnDeleteRowModalWithoutorder' value='Fjern vare' class='ui button negative disabled'/></div>")[0]
    });

    $("#item-table-modal").tabulator({
        // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
        height: 340,
        layout: "fitColumns", //fit columns to width of table (optional)
        selectable: true,     //true means we can select multiple rows   
        placeholder: "Ingen varer", //display message to user on empty table
        ajaxConfig: "POST", //ajax HTTP request type
        ajaxContentType: "json", // send parameters to the server as a JSON encoded string

        columns: [ //Define Table Columns
            { formatter: infoIcon, width: 40, align: "center", cellClick: function (e, cell) { openItemInformation(cell.getData().ID_ITEM, cell.getData().SUPP_CURRENTNO) } },
            { title: "Varenr", field: "ID_ITEM", align: "center" },
            { title: "Varenavn", field: "ITEM_DESC", align: "center" },
            { title: "Varegruppe", field: "ITEM_CATG_DESC", align: "center" },
            {
                title: "Kostpris", field: "COST_PRICE1", align: "center", cssClass: "myEditableCell", editor: "number", editorParams: { min: 0, max: 999999, step: 0.01 }, formatter: "money", formatterParams: {
                    decimal: ",",
                    thousand: ".",
                    symbol: "",
                    symbolAfter: "p",
                    precision: 2,
                }
            },
            {
                title: "Totalkostnad", field: "TOTALCOST", align: "center", formatter: "money", formatterParams: {
                    decimal: ",",
                    thousand: ".",
                    symbol: "",
                    symbolAfter: "p",
                    precision: 2,
                }
            },
            { title: "I bestilling", field: "INDELIVERY", align: "center" },
            { title: "Beholdning", field: "ITEM_AVAIL_QTY", align: "center" },
            { title: "Bestill", field: "ORDERQTY", align: "center", cssClass: "myEditableCell", editor: customSelectEditor2 },
            { title: "Resting", field: "REST_FLG", align: "center", formatter: "tickCross", editor: "tickCross", accessorDownload: booleanToYesNo },
            { title: "Ordre", field: "ID_WO_NO_AND_PREFIX", align: "center" },
            { title: "Merket", field: "ANNOTATION", align: "center", editor: "input" },
            { title: "VaregruppeID", field: "ID_ITEM_CATG", visible: false }, //create hidden column. only so that we can easily provide the id_item_catg
            { title: "Supp", field: "SUPP_CURRENTNO", visible: false },
            { title: "OrdreNr", field: "ID_WOITEM_SEQ", visible: false },
            { title: "Salgspris", field: "ITEM_PRICE", visible: false },
            { title: "nettopris", field: "NET_PRICE", visible: false },
            { title: "Veilende", field: "BASIC_PRICE", visible: false },

        ],
        downloadReady: function (fileContents, blob) {
            //fileContents - the unencoded contents of the file
            //blob - the blob object for the download

            //custom action to send blob to server could be included here
            //  sendEmail

            window.open(window.URL.createObjectURL(blob));

            return blob; //must return a blob to proceed with the download, return false to abort download
        },

        cellEdited: function (cell) {

            //IF cell is a totalcost cell, then do not trigger this. Totalcost gets edited but only through buy*orderqty
            if (cell.getField() !== "TOTALCOST") {
                var row = cell.getRow();
                var totalCell = row.getCell("TOTALCOST");
                var buycost = cell.getData().COST_PRICE1
                var orderqty = cell.getData().ORDERQTY;

                var total = cell.getData().COST_PRICE1 * cell.getData().ORDERQTY;

                totalCell.setValue(total, true);

                var delivered = false;

                var ponumber = $('#pomodal_details_ponumber').text();
                $('#po_modal_update').removeClass('disabled');

            }



        },


        rowSelectionChanged: function (data, rows) {
            //rows - array of row components for the selected rows in order of selection
            //data - array of data objects for the selected rows in order of selection

            if (rows.length === 0) {

                $("#btnDeleteRowModal").addClass("disabled");
            }
            else {
                $("#btnDeleteRowModal").removeClass("disabled");
            }
        },

        ajaxResponse: function (url, params, response) {
            console.log("url is: " + url);
            console.log("params is: " + params);

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

            $('#po_modal_update').removeClass('disabled');
        },

        rowAdded: function (row) {
            //row - row component
            $('#po_modal_update').removeClass('disabled');
            $('#modal_po_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
        },

        footerElement: $("<div class='tabulator-footer'><input type='button' id='btnDeleteRowModal' value='Fjern vare' class='ui button negative disabled'/></div>")[0]
    });


    $("#item-table-modal-confirmedOrder").tabulator({
        // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
        height: 340,
        layout: "fitColumns", //fit columns to width of table (optional)
        selectable: true,     //true means we can select multiple rows   
        placeholder: "Ingen varer", //display message to user on empty table
        ajaxConfig: "POST", //ajax HTTP request type
        ajaxContentType: "json", // send parameters to the server as a JSON encoded string

        columns: [ //Define Table Columns
            { formatter: infoIcon, width: 40, align: "center", cellClick: function (e, cell) { openItemInformation(cell.getData().ID_ITEM, cell.getData().SUPP_CURRENTNO) } },
            { title: "Varenr", field: "ID_ITEM", align: "center" },
            { title: "Varenavn", field: "ITEM_DESC", align: "center" },
            { title: "Varegruppe", field: "ITEM_CATG_DESC", align: "center" },
            {
                title: "Kostpris", field: "COST_PRICE1", align: "center", formatter: "money", formatterParams: {
                    decimal: ",",
                    thousand: ".",
                    symbol: "",
                    symbolAfter: "p",
                    precision: 2,
                }
            },
            {
                title: "Totalkostnad", field: "TOTALCOST", align: "center", formatter: "money", formatterParams: {
                    decimal: ",",
                    thousand: ".",
                    symbol: "",
                    symbolAfter: "p",
                    precision: 2,
                }
            },
            { title: "I bestilling", field: "INDELIVERY", align: "center" },
            { title: "Beholdning", field: "ITEM_AVAIL_QTY", align: "center" },
            { title: "Bestill", field: "ORDERQTY", align: "center" },
            { title: "Resting", field: "REST_FLG", align: "center", formatter: "tickCross", accessorDownload: booleanToYesNo },
            { title: "Ordre", field: "ID_WO_NO_AND_PREFIX", align: "center" },
            { title: "Merket", field: "ANNOTATION", align: "center" },
            { title: "VaregruppeID", field: "ID_ITEM_CATG", visible: false }, //create hidden column. only so that we can easily provide the id_item_catg
            { title: "Supp", field: "SUPP_CURRENTNO", visible: false },
            { title: "OrdreNr", field: "ID_WOITEM_SEQ", visible: false },
            { title: "Salgspris", field: "ITEM_PRICE", visible: false },
            { title: "nettopris", field: "NET_PRICE", visible: false },
            { title: "Veilende", field: "BASIC_PRICE", visible: false },

        ],
        downloadReady: function (fileContents, blob) {
            //fileContents - the unencoded contents of the file
            //blob - the blob object for the download

            //custom action to send blob to server could be included here

            // sendEmailVB(blob);

            window.open(window.URL.createObjectURL(blob));

            return blob; //must return a blob to proceed with the download, return false to abort download
        },

        cellEdited: function (cell) {

            //IF cell is a totalcost cell, then do not trigger this. Totalcost gets edited but only through buy*orderqty


        },


        ajaxResponse: function (url, params, response) {
            console.log("url is: " + url);
            console.log("params is: " + params);

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





    ///* TABLE IN MODAL FOR SHOWING THE ITEMS THAT WERE BOUGHT AND HERE YOU CAN SET WHICH AND HOW MANY ARE DELIVERED */

    $("#item-table-modal-delivery").tabulator({
        // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
        // layout: "fitData", //fit columns to width of table (optional)
        height: 340,
        layout: "fitColumns",
        selectable: true,     //1 means we can select one row  
        ajaxConfig: "POST", //ajax HTTP request type
        ajaxContentType: "json", // send parameters to the server as a JSON encoded string

        columns: [ //Define Table Columns
            {//create column group
                title: "Vareinfo",
                columns: [
                    { formatter: infoIcon, width: 40, align: "center", cellClick: function (e, cell) { openItemInformation(cell.getData().ID_ITEM, cell.getData().SUPP_CURRENTNO) } },
                    { title: "Varenr", field: "ID_ITEM", align: "center" },
                    { title: "Varenavn", field: "ITEM_DESC", align: "center" },
                    { title: "Varegruppe", field: "ITEM_CATG_DESC", align: "center", visible: false },
                    { title: "VaregruppeID", field: "ID_ITEM_CATG", visible: false }, //create hidden column. only so that we can easily provide the id_item_catg
                    { title: "OrdreNrVare", field: "ID_WOITEM_SEQ", visible: false },
                    { title: "Nettopris", field: "NET_PRICE", align: "center", visible: false },
                    { title: "Veil. pris", field: "BASIC_PRICE", align: "center", visible: false },
                    { title: "Beholdning", field: "INDELIVERY", align: "center", visible: false },
                    { title: "Lokasjon", field: "LOCATION", align: "center", visible: false },
                    { title: "Rab", field: "ITEM_DISC_CODE_BUY", align: "center", visible: false },
                    { title: "Leverandør", field: "SUPP_CURRENTNO", visible: false },
                ],
            },

            //{ title: "Totalkostnad", field: "TOTALCOST", align: "center", formatterParams: { precision: 2 } },

            {//create column group
                title: "Prisdetaljer",
                columns: [

                    {
                        title: "Salgspris", field: "ITEM_PRICE", align: "center", editor: "number", cssClass: "myEditableCell", formatter: "money", formatterParams: {
                            decimal: ",",
                            thousand: ".",
                            symbol: "",
                            symbolAfter: "p",
                            precision: 2,
                        }
                    },
                    {
                        title: "Kostpris", field: "COST_PRICE1", align: "center", editor: "number", cssClass: "myEditableCell", formatter: "money", formatterParams: {
                            decimal: ",",
                            thousand: ".",
                            symbol: "",
                            symbolAfter: "p",
                            precision: 2,
                        }
                    }


                ],
            },

            {//create column group
                title: "Leveringsdetaljer",
                columns: [


                    { title: "Bestilt", field: "ORDERQTY", align: "center" },
                    { title: "Levert", field: "DELIVERED_QTY", align: "center" },
                    { title: "Ankommet", field: "REMAINING_QTY", align: "center", cssClass: "myEditableCell", editor: "number", editorParams: { min: 0, max: 999999, step: 1 } },




                ],
            },

            {//create column group
                title: "Diverse",
                columns: [

                    { title: "Resting", field: "REST_FLG", align: "center", formatter: "tickCross", accessorDownload: booleanToYesNo },
                    { title: "Ordre", field: "ID_WO_NO_AND_PREFIX", align: "center" },



                ],
            },


        ],

        ajaxResponse: function (url, params, response) {
            console.log("url is: " + url);
            console.log("params is: " + params);
            console.log(typeof (response.d[0].TOTALCOST));
            //url - the URL of the request
            //params - the parameters passed with the request
            //response - the JSON object returned in the body of the response.

            return response.d; //return the d property of a response json object
        },
        dataLoading: function (data) { //we need this because data that comes in is strings, cant be 
            //data - the data loading into the table
        },

        downloadReady: function (fileContents, blob) {
            //fileContents - the unencoded contents of the file
            //blob - the blob object for the download

            //custom action to send blob to server could be included here

            window.open(window.URL.createObjectURL(blob));

            return blob; //must return a blob to proceed with the download, return false to abort download
        },

        cellEdited: function (cell) {

            $('#po_modal_update').removeClass('disabled');

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

        rowSelected: function (row) {
            //row - row component for the selected row
            console.log("net price is: " + row.getCell("NET_PRICE").getValue())
            $('#modal_extrainfo_lbl_netprice2').text(row.getCell("NET_PRICE").getValue());
            $('#modal_extrainfo_lbl_basicprice2').text(row.getCell("BASIC_PRICE").getValue());
            $('#modal_extrainfo_lbl_stock2').text(row.getCell("INDELIVERY").getValue());
            $('#modal_extrainfo_lbl_loc2').text(row.getCell("LOCATION").getValue());
            $('#modal_extrainfo_lbl_discount2').text(row.getCell("ITEM_DISC_CODE_BUY").getValue());
            $('#modal_extrainfo_fieldwrapper').removeClass("hidden");

        },

        rowDeselected: function (row) {
            //row - row component for the deselected row                 
            $('#modal_extrainfo_fieldwrapper').addClass("hidden");

        },

        footerElement: $("<div class='tabulator-footer'><input type='button' id='btnZeroRowModal' value='Sett til 0' title='Markerte varelinjer vil få ankomst satt til 0' class='ui button yellow enabled'/></div>")[0]



    });

    /* TABLE IN MODAL FOR SHOWING THE ITEMS THAT WERE BOUGHT AND HERE YOU CAN SET WHICH AND HOW MANY ARE DELIVERED */

    $("#item-table-modal-final").tabulator({
        // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
        // layout: "fitData", //fit columns to width of table (optional)
        height: 340,
        layout: "fitColumns",
        selectable: true,     //true means we can select multiple rows
        ajaxConfig: "POST", //ajax HTTP request type
        ajaxContentType: "json", // send parameters to the server as a JSON encoded string


        columns: [ //Define Table Columns
            {//create column group
                title: "Vareinfo",
                columns: [
                    { formatter: infoIcon, width: 40, align: "center", cellClick: function (e, cell) { openItemInformation(cell.getData().ID_ITEM, cell.getData().SUPP_CURRENTNO) } },
                    { title: "Varenr", field: "ID_ITEM", align: "center" },
                    { title: "Varegruppe", field: "ITEM_CATG_DESC", align: "center" },
                    { title: "Leverandør", field: "SUPP_CURRENTNO", visible: false },

                ],
            },

            //{ title: "Totalkostnad", field: "TOTALCOST", align: "center", formatterParams: { precision: 2 } },

            {//create column group
                title: "Prisdetaljer",
                columns: [
                    { title: "Rab", field: "ITEM_DISC_CODE_BUY", align: "center" },
                    {
                        title: "Salgspris", field: "ITEM_PRICE", align: "center", formatter: "money", formatterParams: {
                            decimal: ",",
                            thousand: ".",
                            symbol: "",
                            symbolAfter: "p",
                            precision: 2,
                        }
                    },
                    {
                        title: "Kostpris", field: "COST_PRICE1", align: "center", formatter: "money", formatterParams: {
                            decimal: ",",
                            thousand: ".",
                            symbol: "",
                            symbolAfter: "p",
                            precision: 2,
                        }
                    },
                    {
                        title: "Nettopris", field: "NET_PRICE", align: "center", formatter: "money", formatterParams: {
                            decimal: ",",
                            thousand: ".",
                            symbol: "",
                            symbolAfter: "p",
                            precision: 2,
                        }
                    },
                    {
                        title: "Veil. pris", field: "BASIC_PRICE", align: "center", formatter: "money", formatterParams: {
                            decimal: ",",
                            thousand: ".",
                            symbol: "",
                            symbolAfter: "p",
                            precision: 2,
                        }
                    },

                ],
            },
            {//create column group
                title: "Leveringsdetaljer",
                columns: [
                    { title: "Ant. bestilt", field: "ORDERQTY", align: "center" },
                    { title: "Ant. levert", field: "DELIVERED_QTY", align: "center" },
                    { title: "Fullført", field: "DELIVERED", align: "center", formatter: "tickCross", accessorDownload: booleanToYesNo },


                ],
            },



        ],

        ajaxResponse: function (url, params, response) {
            console.log("url is: " + url);
            console.log("params is: " + params);
            console.log(typeof (response.d[0].TOTALCOST));
            //url - the URL of the request
            //params - the parameters passed with the request
            //response - the JSON object returned in the body of the response.

            return response.d; //return the d property of a response json object
        },
        dataLoading: function (data) { //we need this because data that comes in is strings, cant be 
            //data - the data loading into the table
        },

        cellEditing: function (cell) {
            //cell - cell component

            //cell = cell.getRow().deselect();

        },

        downloadReady: function (fileContents, blob) {
            //fileContents - the unencoded contents of the file
            //blob - the blob object for the download

            //custom action to send blob to server could be included here

            window.open(window.URL.createObjectURL(blob));

            return blob; //must return a blob to proceed with the download, return false to abort download
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




    });




    //    /* TABLE IN TAB PURCHASEORDERS FOR SEARCHING FOR POs */

    var windowHeight = $(window).height();
    var tableHeight = windowHeight / 1.8;



    $("#PO-table").tabulator({

        height: tableHeight, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
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

            var selectedRows = $("#PO-table").tabulator("getSelectedRows");
            if (selectedRows.length !== 0) {
                if (row.getData().NUMBER == selectedRows[0].getData().NUMBER) {
                    return false;
                }
            }


            return true; //alow selection of rows where the age is greater than 18
        },
        rowDblClick: function (e, row) {
            //e - the click event object
            //row - row component
            openModalItemInformation(row, "");
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


            { title: "Bestillingsnr", field: "NUMBER", align: "center", headerFilter: "input", minWidth: 120 },
            { title: "Leverandørnavn", field: "SUPP_NAME", align: "center", headerFilter: "input", minWidth: 120 },
            { title: "Leverandørnr", field: "SUPP_CURRENTNO", align: "center", headerFilter: "input", minWidth: 120 },
            { title: "Bestillingstype", field: "ID_ORDERTYPE", align: "center", headerFilter: "input", minWidth: 120 },
            { title: "Ordredato", field: "DT_CREATED_SIMPLE", sorter: "date", align: "center", headerFilter: "input", minWidth: 120 },
            { title: "Forventet levert", field: "DT_EXPECTED_DELIVERY", sorter: "date", align: "center", headerFilter: "input", minWidth: 120 },
            { title: "Bestilling bekreftet", field: "STATUS", align: "center", formatter: "tickCross", headerFilter: "input", headerFilterFunc: customHeaderFilter, minWidth: 120 },
            { title: "Levert", field: "FINISHED", align: "center", formatter: "tickCross", headerFilter: "input", headerFilterFunc: customHeaderFilter, visible: false, minWidth: 150 },


        ],


        //footerElement: $("<div class='tabulator-footer'></div>")[0], //sette [0] bak for å fungere,
        footerElement: $('<div class="tabulator-footer"><div class="ui labeled left floated button" tabindex="0"><div class="ui blue button"><i class="copy icon"></i> Bestillinger</div><a class="ui basic blue left pointing label" id="rowcounter"></a></div><button class="ui icon blue button" id="btnPOsetStandard"><i class="redo icon"></i></button></div>')[0]
    });



    //we add this customheaderfilter so that the user can type "ja" / "nei" instead of true/false. Users are not like us programmers;) true/false makes no sense to them
    function customHeaderFilter(headerValue, rowValue, rowData, filterParams) {
        //headerValue - the value of the header filter element
        //rowValue - the value of the column in this row
        //rowData - the data for the row being filtered
        //filterParams - params object passed to the headerFilterFuncParams property 
        var retval = false;
        if (headerValue.startsWith("j")) {
            console.log("rowval er " + rowValue);
            if (rowValue === "True") { retval = true; }
        }
        else if (headerValue.startsWith("n")) {
            console.log("rowval er " + rowValue);
            if (rowValue === "False") { retval = true; }
        }
        return retval; //must return a boolean, true if it passes the filter.
    }

    $(window).resize(function () {
        $("#PO-table").tabulator("redraw", true); //trigger full rerender including all data And rows


    });


    /* TABLE FOR SHOWING ARCHIVED PURCHASEORDERS */

    $("#Archived-table").tabulator({
        height: 510, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
        //minWidth: 20,
        movableColumns: true, //enable user movable rows
        layout: "fitColumns", //fit columns to width of table (optional) 

        selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
        placeholder: "No Data Available", //display message to user on empty table
        index: "NUMBER",
        ajaxConfig: "POST", //ajax HTTP request type
        ajaxContentType: "json", // send parameters to the server as a JSON encoded string
        persistentSort: true, //Enable sort persistence

        // Return value + "<span style='color:#d00; margin-left:10px;'>(" + count + Str() + "<span style='margin-right:300px;'>";
        //column definition in the columns array

        selectableCheck: function (row) {

            var selectedRows = $("#Archived-table").tabulator("getSelectedRows");
            if (selectedRows.length !== 0) {
                if (row.getData().NUMBER == selectedRows[0].getData().NUMBER) {
                    return false;
                }
            }


            return true; //alow selection of rows where the age is greater than 18
        },
        rowDblClick: function (e, row) {
            //e - the click event object
            //row - row component
            openModalItemInformation(row, "Archived");
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


            { title: "Bestillingsnr", field: "NUMBER", width: 150, align: "center", headerFilter: "input", },
            { title: "Leverandørnavn", field: "SUPP_NAME", align: "center", headerFilter: "input" },
            { title: "Leverandørnr", field: "SUPP_CURRENTNO", align: "center", headerFilter: "input" },
            { title: "Bestillingstype", field: "ID_ORDERTYPE", align: "center", headerFilter: "input" },
            { title: "Ordredato", field: "DT_CREATED_SIMPLE", sorter: "date", align: "center", headerFilter: "input" },
            { title: "Levert", field: "DT_EXPECTED_DELIVERY", sorter: "date", align: "center", headerFilter: "input", visible: false },

        ],


        //footerElement: $("<div class='tabulator-footer'></div>")[0], //sette [0] bak for å fungere,
        footerElement: $('<div class="tabulator-footer"><div class="ui labeled left floated button" tabindex="0"><div class="ui blue button"><i class="copy icon"></i> Bestillinger</div><a class="ui basic blue left pointing label" id="rowcounterArchived"></a></div><button class="ui icon blue button" id="btnPOsetStandard"><i class="redo icon"></i></button></div>')[0]
    });



    //we add this customheaderfilter so that the user can type "ja" / "nei" instead of true/false. Users are not like us programmers;) true/false makes no sense to them
    function customHeaderFilter(headerValue, rowValue, rowData, filterParams) {
        //headerValue - the value of the header filter element
        //rowValue - the value of the column in this row
        //rowData - the data for the row being filtered
        //filterParams - params object passed to the headerFilterFuncParams property 
        var retval = false;
        if (headerValue.startsWith("j")) {
            console.log("rowval er " + rowValue);
            if (rowValue === "True") { retval = true; }
        }
        else if (headerValue.startsWith("n")) {
            console.log("rowval er " + rowValue);
            if (rowValue === "False") { retval = true; }
        }
        return retval; //must return a boolean, true if it passes the filter.
    }

    $(window).resize(function () {
        $("#PO-table").tabulator("redraw", true); //trigger full rerender including all data And rows
    });




    $("#autoPOsuggestion-table").tabulator({
        height: 340, // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
        layout: "fitColumns", //fit columns to width of table (optional)                  
        ajaxConfig: "POST", //ajax HTTP request type
        ajaxContentType: "json", // send parameters to the server as a JSON encoded string


        columns: [ //Define Table Columns
            { title: "Varenr", field: "ID_ITEM", width: 150, align: "center" },
            { title: "Varenavn", field: "ITEM_DESC", align: "center", },
            { title: "i bestilling", field: "INDELIVERY", align: "center" },
            { title: "Beholdning", field: "ITEM_AVAIL_QTY", align: "center" },
            { title: "Bestille", field: "ORDERQTY", align: "center", editor: "number" },
            { title: "Resting", field: "REST_FLG", align: "center", formatter: "tickCross", editor: "tickCross" },
            { title: "VaregruppeID", field: "ID_ITEM_CATG", visible: false }, //create hidden column. only so that we can easily provide the id_item_catg
            { title: "Varegruppe", field: "ITEM_CATG_DESC", align: "center", visible: false },
            {
                title: "Kostpris", field: "COST_PRICE1", align: "center", visible: false, formatter: "money", formatterParams: {
                    decimal: ",",
                    thousand: ".",
                    symbol: "",
                    symbolAfter: "p",
                    precision: 2,
                }
            }


        ],

        ajaxResponse: function (url, params, response) {


            //url - the URL of the request
            //params - the parameters passed with the request
            //response - the JSON object returned in the body of the response.

            return response.d; //Return the d Property Of a response json Object
        },


    });


    $(window).resize(function () {
        $("#autoPOsuggestion-table").tabulator("redraw", true); //trigger full rerender including all data and rows
    });

    makePOsearch(); //added so that the table is populated with purchaseorders from the start

}); 
        function OnEndCallbackcbOpenReport(s, e) {
            $('#modal_po_steps').modal('hide');
            popupReport.ShowWindow(popupReport.GetWindow(0));
        }
        function OnpopupReportClosing(s, e) {
            if (!openFrmCtxMenu) {
            $('#modal_po_steps').modal('show');
            }
        }
        function PrintBtnClick() {
            $('#modal_po_steps').modal('hide');
            popupSelRepType.Show(); 
        }
        function RptPrintClick() {
            openFrmCtxMenu = false;
            var isRbPrintChecked = $('#rbRptWithAllSpr:checked').val(); 
            if (isRbPrintChecked == "true") {
                popupSelRepType.Hide();
                var poNum = $('#redRibbonPOmodal').text();
                cbPanel.PerformCallback(poNum + ";ALL");
            }
            else {
                popupSelRepType.Hide();
                var poNum = $('#redRibbonPOmodal').text();
                cbPanel.PerformCallback(poNum+";ODR");
            }
        }
    </script>


                                       <asp:HiddenField ID="hdnSelect" runat="server" />
    <div class="overlayHide">
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
    </div>
    <div id="systemMessage" class="ui message"></div>
   
    <div class="ui grid">
        <div id="tabFrame" class="sixteen wide column">
            <input type="button" id="btnPurchaseOrders" value="Åpne bestillinger" class="cTab ui btn" data-tab="PurchaseOrders" meta:resourcekey="btnOpenPurchases" />
            <input type="button" id="btnPurchaseOrdersArchived" value="Fullførte bestillinger" class="cTab ui btn" data-tab="PurchaseOrdersArchived" meta:resourcekey="btnCompletedPurchases" />
            <div class="ui icon top left pointing green dropdown button">
                <i class="plus icon"></i>
                <div class="menu">
                    <div class="header"><%=GetLocalResourceObject("headMenuOptions")%></div>

                    <div class="item">
                        <i class="dropdown icon"></i>
                        <span class="text"><%=GetLocalResourceObject("menuNew")%></span>
                        <div class="menu">
                            <div class="item" id="icon_newPO">
                                <i class="pencil icon"></i>
                                <%=GetLocalResourceObject("menuManualPurchaseOrder")%>
                            </div>
                            <div class="item" id="icon_newPOautomatic">
                                <i class="random icon"></i>
                                <%=GetLocalResourceObject("menuAutomaticPurchaseOrder")%>
                            </div>
                            <div class="item" id="icon_withoutOrder">
                                <i class="question icon"></i>
                                <%=GetLocalResourceObject("menuReceiveWithoutPurchaseOrder")%>
                            </div>
                        </div>
                    </div>
                    <div class="item"><%=GetLocalResourceObject("itemSettings")%></div>
                     <div class="item" id="icon_printBOReport"><%=GetLocalResourceObject("printBOReport")%></div>

                </div>
            </div>
        </div>
    </div>


    <%--Begin tab PurchaseOrders--%>

    <div id="tabPurchaseOrders" class="tTab">
        <div class="ui form stackable two column grid ">
            <div class="fifteen wide column">
                
                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headPurcaseOrderSearch")%><i class="fas fa-filter "  style="color: darkorange; margin-left:10rem; font-size: 16px"></i>Aktiv</h3>
                    <label class="inHeaderCheckbox">
                        <%=GetLocalResourceObject("lblShowHide")%>
                            <button id="btnViewDetails" class="ui btn mini">
                                <i class="caret down icon"></i>
                            </button>
                    </label>
                    <div class="searchvalues-container" style="display: none">
                        <div class="fields">
                            <div class="six wide field">
                            </div>
                            <div class="six wide field">
                            </div>

                        </div>
                        <div class="fields">
                            <div class="three wide field" style="max-width: 220px">
                                <label id="lblPOnumber" runat="server"><%=GetLocalResourceObject("lblPurcaseOrderNo")%></label>
                                <asp:TextBox ID="txtbxPOnumbersearch" CssClass="carsInput" runat="server" data-submit="ID_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                       
                            <div class="three wide field" style="max-width: 220px">
                                <label id="lblInfoSupplier" runat="server"><%=GetLocalResourceObject("lblSupplier")%></label>
                                <asp:TextBox ID="txtbxInfoSupplier" CssClass="carsInput" runat="server" data-submit="ID_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
   
                        
                            <div class="three wide field" style="max-width: 220px">
                                <label id="lblSparepartNumber" runat="server"><%=GetLocalResourceObject("lblSparePart")%></label>
                                <asp:TextBox ID="txtbxSparepartNumber" CssClass="carsInput" runat="server" data-submit="ITEM_DISC_CODE_BUY" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>
                        <div class="fields" >
                            <div class="three wide field" style="max-width: 220px">
                                <label id="lblDateFrom" runat="server"><%=GetLocalResourceObject("lblFromDate")%></label>
                                <asp:TextBox ID="txtbxDateFrom" CssClass="carsInput" runat="server" data-submit="ANNOTATION" meta:resourcekey="txtTechMakeResource1" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="three wide field" style="max-width: 220px">
                                <label id="lblDateTo" runat="server"><%=GetLocalResourceObject("lblToDate")%></label>
                                <asp:TextBox ID="txtbxDateTo" CssClass="carsInput" runat="server" data-submit="ANNOTATION" meta:resourcekey="txtTechMakeResource1" Enabled="False"></asp:TextBox>
                            </div>
                        </div>

                        <div class="fields">
                            <div class="four wide field">

                                <div class="ui toggle checkbox">
                                    <input id="inp_unconfirmedOrder" type="checkbox" name="public" checked="checked"/>
                                    <label><%=GetLocalResourceObject("lblForecast")%></label>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="four wide field">

                                <div class="ui toggle checkbox">
                                    <input id="inp_confirmedOrder" type="checkbox" name="public" checked="checked"/>
                                    <label><%=GetLocalResourceObject("lblPurcaseOrder")%></label>
                                </div>
                            </div>
                        </div>

                        


                        <div class="fields">
                            <div class="four wide field">

                                <input type="button" id="searchbutton" runat="server" class="ui orange button" meta:resourcekey="btnSearchButton" />



                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <%--End of Purchase order segment--%>

            


            <div class="fifteen wide column">
            
                <div id="PO-table" class="mytabulatorclass"></div>
                
            </div>

        </div>


    </div>

    <%--End tab PurchaseOrders--%>

    <div id="tabPurchaseOrdersArchived" class="tTab">
        <div class="ui form stackable two column grid ">

            <div class="fifteen wide column">
                    
                    

                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                <h3 id="H1" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Bestillingssøk arkiv</h3>
                    <label class="inHeaderCheckbox">
                        <%=GetLocalResourceObject("headShowHide")%>
                            <button id="btnViewDetailsArchived" class="ui btn mini">
                                <i class="caret down icon"></i>
                            </button>
                    </label>
                    <div class="searchvalues-container" style="display: none">
                        <div class="fields">
                            <div class="six wide field">
                            </div>
                            <div class="six wide field">
                            </div>

                        </div>
                        <div class="fields">
                            <div class="two wide field">
                                <label id="Label1" runat="server"><%=GetLocalResourceObject("lblPurchaseNo")%></label>
                                <asp:TextBox ID="TextBox2" runat="server" data-submit="ID_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>


                        </div>

                        <div class="fields">
                            <div class="two wide field">
                                <label id="Label2" runat="server"><%=GetLocalResourceObject("lblSupplier")%></label>
                                <asp:TextBox ID="TextBox3" runat="server" data-submit="ID_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>


                        </div>
                        <div class="fields">
                            <div class="two wide field">
                                <label id="Label3" runat="server"><%=GetLocalResourceObject("lblSparePart")%></label>
                                <asp:TextBox ID="TextBox4" runat="server" data-submit="ITEM_DISC_CODE_BUY" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>



                        </div>
                        <div class="fields">
                            <div class="one wide field">
                                <label id="Label4" runat="server"><%=GetLocalResourceObject("lblFromDate")%></label>
                                <asp:TextBox ID="TextBox5" runat="server" data-submit="ANNOTATION" meta:resourcekey="txtTechMakeResource1" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="one wide field">
                                <label id="Label5" runat="server"><%=GetLocalResourceObject("lblToDate")%></label>
                                <asp:TextBox ID="TextBox6" runat="server" data-submit="ANNOTATION" meta:resourcekey="txtTechMakeResource1" Enabled="False"></asp:TextBox>
                            </div>

                        </div>


                        <div class="fields">
                            <div class="three wide field">
                                <input type="button" id="searchbuttonArchived" value="Søk" class="ui orange button" />

                            </div>

                        </div>

                    </div>
                </div>
          </div>
            <%--End of Archived purchase order segment--%>
    <div class="fifteen wide column">
            
                <div id="Archived-table" class="mytabulatorclass"></div>
                
            </div>

        </div>


    </div>

    <%-- Salesman Modal, css descrived in cars.css --%>
    <div id="modNewOrdertype" class="modal hidden">
        <div class="modHeader">
            <h2 id="lblAdvSalesman" runat="server">Bestillingstype</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Nytt kjøretøy</label>
                    <div class="ui small info message hidden">
                        <p id="lblAdvSalesmanStatus" runat="server"><%=GetLocalResourceObject("lblOrderTypeStatus")%></p>
                    </div>
                    <div class="ui success message">
                        <div class="header"><%=GetLocalResourceObject("headFormComplete")%></div>
                        <p>You're all signed up for the newsletter.</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblNewUsed" runat="server">Bestillingstyper</label>
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
                                    <div class="ui selection dropdown"  style="z-index:1000 !important" id="ddlNewOrdertypePricetype">
                                        <input type="hidden" name="gender"/>
                                        <i class="dropdown icon"></i>
                                        <div class="default text">Pristype</div>
                                        <div class="menu" style="min-height: auto !important; height: 9em !important;">
                                            <div class="item" data-value="1">Kostpris</div>
                                            <div class="item" data-value="0">Nettopris</div>
                                            <div class="item" data-value="0">Salgspris</div>
                                            <div class="item" data-value="0">Basispris</div>
                                      
                                        </div>
                                    </div>
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
   

    <%--End tab NewPurchaseOrder--%>





    <%--MODALS--%>

    <div class="ui modal" id="randomModal">
        <i class="close icon"></i>
        <div class="header">
            Profile Picture
        </div>
        <div class="content">
            <div class="ui form">

                <div class="inline field">
                    <div class="ui toggle checkbox">
                        <input type="checkbox" tabindex="0" class="hidden">
                        <label>Toggle</label>
                    </div>
                </div>
            </div>
            
        </div>
        <div class="actions">
            <div class="ui black deny button">
                Nope
            </div>
            <div class="ui positive right labeled icon button">
                Yep, that's me
      <i class="checkmark icon"></i>
            </div>
        </div>
    </div>


    <div class="fullscreen ui modal" id="modal_po_steps">
        <a class="ui red ribbon label" id="redRibbonPOmodal"></a>
        <i class="close icon"></i>
        <div class="header">
             <div class="ui fluid five top attached steps"> 
                 <div class="active step" id="step_po_before_first">
                        <i class="clipboard list icon"></i>
                        <div class="content">
                            <div class="title"><%=GetLocalResourceObject("lblSupplierSetup")%></div>
                            <div class="description"><%=GetLocalResourceObject("lblSupplierSetupText")%></div>
                        </div>
                    </div>
                    <div class="disabled step" id="step_po_first">
                        <i class="shopping cart icon"></i>
                        <div class="content">
                            <div class="title"><%=GetLocalResourceObject("lblSupplierForecast")%></div>
                            <div class="description"><%=GetLocalResourceObject("lblSupplierForecastText")%></div>
                        </div>
                    </div>
                 <div class="disabled step" id="step_po_second">
                     <i class="shipping  fast icon"></i>
                     <div class="content">
                         <div class="title"><%=GetLocalResourceObject("lblPurchaseOverview")%></div>
                         <div class="description"><%=GetLocalResourceObject("lblPurchaseOverviewText")%></div>
                     </div>
                 </div>
                 <div class="disabled step" id="step_po_third">
                     <i class="pencil alternate icon"></i>
                     <div class="content">
                         <div class="title"><%=GetLocalResourceObject("lblPurchaseArrival")%></div>
                         <div class="description"><%=GetLocalResourceObject("lblPurchaseArrivalText")%></div>
                     </div>
                 </div>
                 <div class="disabled step" id="step_po_fourth">
                     <i class="info icon"></i>
                     <div class="content">
                         <div class="title"><%=GetLocalResourceObject("lblPurchaseDetails")%></div>
                         <div class="description"><%=GetLocalResourceObject("lblPurchaseDetailsText")%></div>
                     </div>
                 </div>

             </div>
        </div>


        <div class="content">
            <div class="modal_po_divstep0">
                <div class="ui header">Opprett forslag</div>
                <div class="ui stackable form">
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 400px" id="txtbxSupplierModalparent" >
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                               <%=GetLocalResourceObject("lblSupplier")%>                                         
                            </div>
                            <input type="text" placeholder="Søk leverandør" id="txtbxSupplierModal" />
                            
                        </div>
                        <div class="two wide field" style="max-width: 100px">
                        <input type="text" id="txtbxSuppcurrentnoModal" disabled="disabled"/>
                        </div>
                    </div>
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 340px">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                <%=GetLocalResourceObject("lblPurchaseType")%>                                        
                            </div>


                            <select class="ui dropdown" id="dropdown_modal_ordertype">
                                
                                <option value="0"></option> 
                            </select>
                        </div>



                        <div class="one wide field">
                            <div id="addOrderType" class="ui mini icon top left pointing green dropdown button disabled" >
                            <i class="plus icon"></i>
                            </div>
                       </div>
                    </div>
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 340px"">
                            <div class="ui blue label" style="min-width: 120px"; text-align: center">
                                <%=GetLocalResourceObject("lblSendingType")%>                                             
                            </div>
                            
                           
                            <div class="ui selection dropdown" id="dropdown_modal_deliverymethod">
                                <input type="hidden" name="gender" />
                                <i class="dropdown icon"></i>
                                <div class="default text">Søk Forsendelsesmåte</div>
                                <div class="menu">
                                 
                                    <div class="item" data-value="0">Tog</div>
                                    <div class="item" data-value="1">Bil</div>
                                </div>
                            </div>
                            </div>
                            <div class="one wide field">
                            <div id="addDeliveryMethod" class="ui mini icon top left pointing green dropdown button" >
                            <i class="plus icon"></i>
                            </div>
                       </div>
                        </div>
                        <div class="inline fields">
                        <div class="eight wide field" style="max-width: 360px">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                <%=GetLocalResourceObject("lblArrivalDate")%>                                           
                            </div>
                            <input type="text"  id="txtbxExpDelivery" disabled="disabled" style="font-weight:bold;"/>
                            <%--<asp:TextBox ID="txtbxExpDelivery" CssClass="NEWpodatepicker" runat="server" data-submit="SAVE_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1" ForeColor="Red" Enabled="false" ></asp:TextBox>--%>
                        
                        </div>
                        </div>

                    </div>
                </div>
            
       
         
         
          
       

            <div class="modal_po_divstep1">
                    
                    <div class="ui header">Legg til varer</div>
                    <div class="fields">
                        <div class="six wide field">
                            <div class="ui blue horizontal label"><%=GetLocalResourceObject("lblPurchaseNo")%> </div>
                            <a class="detail" id="pomodal_details_ponumber"></a>

                            <div class="ui blue horizontal label" style="margin-left: 2em"><%=GetLocalResourceObject("lblSupplier")%> </div>
                            <a class="detail" id="pomodal_details_supplier"></a>

                            <div class="ui blue horizontal label" style="margin-left: 2em""><%=GetLocalResourceObject("lblPurchaseType")%> </div>
                            <a class="detail" id="pomodal_details_ordertype"></a>

                            
                            
                           

                        </div>

                    </div>
                    <div class="fields">
                        <div class="six wide field">
                            <div class="ui small right labeled input" style="margin-top: 2em" id="txtbxSparepartModalparent">
                            <label for="amount" class="ui label" id="lblSparepartModalAddNewItem">+</label>
                             <input type="text" placeholder="Søk vare" id="txtbxSparepartModal" />
                                 
                                <div class="ui small dropdown label" id="ddlLocalNonstock">
                                    <div class="text">Lokal</div>
                                    <i class="dropdown icon"></i>
                                    <div class="menu">
                                        <div class="item"><%=GetLocalResourceObject("dropLocal")%></div>
                                        <div class="item"><%=GetLocalResourceObject("dropNonStock")%></div>
                                        
                                    </div>
                                </div>                              
                                
                            </div>                                                    
                            
                                

                        </div>                                      

                        </div>


                    <div id="item-table-modal" class="mytabulatorclass"></div>



                </div>

            <div class="modal_po_divstep2">
                <div class="ui header">Bestillingsdetaljer</div>
                <div class="fields">
                    <div class="three wide field">
                        <div class="ui blue horizontal label"><%=GetLocalResourceObject("lblExpectedDelivery")%></div>
                        <a class="detail" id="pomodal_details_expdel"></a>
                        <div class="ui blue horizontal label" style="margin-left: 2em"><%=GetLocalResourceObject("lblSendingType")%></div>
                        <a class="detail" id="pomodal_details_delmethod"></a>
                        <div class="ui blue horizontal label" style="margin-left: 2em"><%=GetLocalResourceObject("lblSupplier")%></div>
                        <a class="detail" id="pomodal_details_supp"></a>

                    </div>
                    
                    
                </div>
                <div id="item-table-modal-confirmedOrder" class="mytabulatorclass"></div>

            </div>
            <div class="modal_po_divstep3">
                <div class="ui header"><%=GetLocalResourceObject("lblArrivalofSpareParts")%></div>
                <div class="fields">
                    <div class="three wide field">
                    </div>
                    <div id="item-table-modal-delivery" class="mytabulatorclass"></div>

                </div>
                
                    <div class="ui bottom attached segment">
                        

                        <div class="inline fields">

                            <div id="modal_extrainfo_fieldwrapper" class="hidden">
                                
                                    <div class="ui label" id="modal_extrainfo_lbl_netprice" style="background-color: #cce2ff">Nettopris:</div>
                                    <div class="ui label" id="modal_extrainfo_lbl_netprice2"></div>
                                
                                
                                    <div class="ui  label" id="modal_extrainfo_lbl_basicprice" style="margin-left: 3rem; background-color: #cce2ff">Veil. pris:</div>
                                    <div class="ui label" id="modal_extrainfo_lbl_basicprice2"></div>
                               
                                    <div class="ui  label" id="modal_extrainfo_lbl_discount" style="margin-left: 3rem; background-color: #cce2ff">Rabattkode</div>
                                    <div class="ui label" id="modal_extrainfo_lbl_discount2"></div>
                               
                                    <div class="ui  label" id="modal_extrainfo_lbl_stock" style="margin-left: 3rem; background-color: #cce2ff">Beholdning:</div>
                                    <div class="ui label" id="modal_extrainfo_lbl_stock2"></div>
                                
                               
                                    <div class="ui  label" id="modal_extrainfo_lbl_loc" style="margin-left: 3rem; background-color: #cce2ff">Lokasjon:</div>
                                    <div class="ui label" id="modal_extrainfo_lbl_loc2"></div>
                                
                            </div>
                        </div>
                    </div>


            </div>

            <div class="modal_po_divstepCheckmark" style="z-index: 1; position: absolute; left: 50%; bottom: 25%;">

                <div class="circle-loader">
                    <div class="checkmark2 draw"></div>
                </div>

            </div>
            
       
            <div class="modal_po_divstep4" style="opacity:0">
                <div class="ui header"><%=GetLocalResourceObject("lblDeliveredAndCompletedSpares")%></div>
                <div class="fields">
                    <div class="six wide field">
                        <div class="ui blue horizontal label" style="margin-bottom: 2em" ><%=GetLocalResourceObject("lblPurchaseNo")%></div>
                            <a class="detail" id="pomodal_details_ponumber4"></a>

                            
                            <div class="ui blue horizontal label" style="margin-left: 2em"><%=GetLocalResourceObject("lblSupplier")%></div>
                            <a class="detail" id="pomodal_details_supplier4"></a>

                            <div class="ui blue horizontal label" style="margin-left: 2em""><%=GetLocalResourceObject("lblPurchaseType")%></div>
                            <a class="detail" id="pomodal_details_ordertype4"></a>
                    </div>                    
                    <div id="item-table-modal-final" class="mytabulatorclass"></div>
                </div>

            </div>
            

        </div>
        <div class="actions">
       
        <div class="ui grey enabled right labeled icon left floated  button" id="btnDownloadCSV"> 
                <%=GetLocalResourceObject("btnDownloadCsv")%> 
                <i class="file outline icon"></i>
        </div>

        <div class="ui grey enabled right labeled icon left floated button" id="btnDownloadPDF"> 
                <%=GetLocalResourceObject("btnDownloadPdf")%> 
                <i class="file pdf icon"></i>
        </div>
       

        <div class="ui icon right labeled top left pointing green left floated dropdown button" id="po_modal_sendMenu">
                        <%=GetLocalResourceObject("btnSend")%> 
                        <i class="paper plane outline icon"></i>
                        <div class="menu">
                            <div class="header"><%=GetLocalResourceObject("headMenuOptions")%> </div>

                                <div class="item" id="icon_sendviamail">
                                    <i class="at icon"></i>
                                    <%=GetLocalResourceObject("optSendPurchaceMail")%>                                                                   
                                </div>
                                <div class="item">
                                    <i class="pencil icon"></i>
                                    <%=GetLocalResourceObject("optPurchaseExport")%>    
                            </div>
                            </div>
                    </div>

                    <div class="ui blue button" id="btnPrintReport" onclick="PrintBtnClick()">
                        <i class="print icon left"></i>
                        Skriv ut
                    </div>

            <div class="ui labeled button disabled" tabindex="0" id="po_modal_import">
                   
                    <div class="ui blue button">
                        <i class="download icon"></i><%=GetLocalResourceObject("btnImport")%>  
                    </div>
                    <a class="ui basic left pointing blue label" id="lbl_available_imports_modal">0
                    </a>
                </div>
            
          

            <div class="ui disabled yellow enabled right labeled icon button" id="po_modal_update"> 
                <%=GetLocalResourceObject("btnUpdate")%>   
                <i class="retweet icon"></i>
            </div>
            <div class="ui red deny button" id="po_modal_cancel"> <%=GetLocalResourceObject("btnCancel")%>    </div>
            <div class="ui disabled left labeled icon button" id="po_modal_previous"> 
                <%=GetLocalResourceObject("btnPrevious")%>    
                <i class="chevron left icon"></i>
            </div>


            <div class="ui black right labeled icon button hidden" id="po_modal_pluckList">
                <div><%=GetLocalResourceObject("btnPickingList")%>   </div>
                <i class="clipboard icon"></i>
            </div>

            <div class="ui positive right labeled icon button" id="po_modal_next">
                <div> <div><%=GetLocalResourceObject("btnNext")%></div> 
                 
                <i class="chevron right icon"></i>
            </div>



        </div>
    </div>

    <div class="fullscreen ui modal" id="modal_withoutorder_steps">
        <a class="ui red ribbon label" id="redRibbonPOmodal_withoutorder"></a>
        <i class="close icon"></i>
        <div class="header">
             <div class="ui five top attached steps"> 
                 <div class="active step" id="step_po_first_withoutorder">
                        <i class="clipboard list icon"></i>
                        <div class="content">
                            <div class="title"><%=GetLocalResourceObject("lblSupplierSetup")%></div>
                            <div class="description"><%=GetLocalResourceObject("lblSupplierSetupText")%></div>
                        </div>
                    </div>                  
                 
                 <div class="disabled step" id="step_po_second_withoutorder">
                     <i class="pencil alternate icon"></i>
                     <div class="content">
                         <div class="title"><%=GetLocalResourceObject("lblPurchaseArrival")%></div>
                         <div class="description"><%=GetLocalResourceObject("lblPurchaseArrivalText")%></div>
                     </div>
                 </div>               

             </div>
        </div>


        <div class="content">
            <div class="modal_withoutorder_divstep0">
                <div class="ui header"><%=GetLocalResourceObject("lblAddSupplierDetails")%></div>
                <div class="ui stackable form">
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 400px" id="txtbxSupplierModalparent_withoutorder" >
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                <%=GetLocalResourceObject("lblSupplier")%>                                            
                            </div>
                            <input type="text" placeholder="Søk leverandør" id="txtbxSupplierModal_withoutorder" />
                            
                        </div>
                        <div class="two wide field" style="max-width: 100px">
                        <input type="text" id="txtbxSuppcurrentnoModalWithoutorder" disabled="disabled"/>
                        </div>
                    </div>
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 340px">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                <%=GetLocalResourceObject("lblPurchaseType")%>                                            
                            </div>                       
                        
                            <div class="ui selection dropdown" id="dropdown_modal_ordertype_withoutorder">
                                <input type="hidden" name="gender"/>
                                <i class="dropdown icon"></i>
                                <div class="default text">Søk Bestillingstype</div>
                                <div class="menu">
                                    
                                    <div class="item" data-value="RE">RE</div>
                                    <div class="item" data-value="LO">LO</div>
                                </div>
                            </div>
                        </div>



                        <div class="one wide field">
                            <div id="addOrderTypexx" class="ui mini icon top left pointing green dropdown button disabled" >
                            <i class="plus icon"></i>
                            </div>
                       </div>
                    </div>
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 340px"">
                            <div class="ui blue label" style="min-width: 120px"; text-align: center">
                                Forsendelsesmåte                                            
                            </div>
                            
                           
                            <div class="ui selection dropdown" id="dropdown_modal_deliverymethodxx">
                                <input type="hidden" name="gender" />
                                <i class="dropdown icon"></i>
                                <div class="default text">Søk Forsendelsesmåte</div>
                                <div class="menu">
                                 
                                    <div class="item" data-value="0">Tog</div>
                                    <div class="item" data-value="1">Bil</div>
                                </div>
                            </div>
                            </div>
                            <div class="one wide field">
                            <div id="addDeliveryMethodxx" class="ui mini icon top left pointing green dropdown button" >
                            <i class="plus icon"></i>
                            </div>
                       </div>
                        </div>
                        <div class="inline fields">
                        <div class="eight wide field" style="max-width: 360px">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Ankomstdato                                            
                            </div>
                            <input type="text"  id="txtbxExpDeliveryxx" disabled="disabled" style="font-weight:bold;"/>
                            <%--<asp:TextBox ID="txtbxExpDelivery" CssClass="NEWpodatepicker" runat="server" data-submit="SAVE_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1" ForeColor="Red" Enabled="false" ></asp:TextBox>--%>
                        
                        </div>
                        </div>

                    </div>
                </div>
            
       
       
   
         
          
       

            <div class="modal_withoutorder_divstep1">
                    
                    <div class="ui header">Legg til varer</div>
                    <div class="fields">
                        <div class="six wide field">                            

                            <div class="ui blue horizontal label" style="margin-left: 2em">Leverandør</div>
                            <a class="detail" id="pomodal_details_supplier_withoutorder"></a>

                            <div class="ui blue horizontal label" style="margin-left: 2em"">Bestillingstype</div>
                            <a class="detail" id="pomodal_details_ordertype_withoutorder"></a>
                            

                        </div>


                    </div>
                    <div class="fields">
                        <div class="six wide field">
                            <div class="ui small right labeled input" style="margin-top: 2em" id="txtbxSparepartModalparent_withoutorder">
                            <label for="amount" class="ui label" id="lblSparepartModalAddNewItemxx">+</label>
                             <input type="text" placeholder="Søk vare" id="txtbxSparepartModal_withoutorder" />
                                 
                                <div class="ui small dropdown label" id="ddlLocalNonstockxx">
                                    <div class="text">Lokal</div>
                                    <i class="dropdown icon"></i>
                                    <div class="menu">
                                        <div class="item">Lokal</div>
                                        <div class="item">Non-stock</div>
                                        
                                    </div>
                                </div>                              
                                
                            </div>                                                    
                                                          

                        </div>                                      

                        </div>

                    <div id="withoutorder-table" class="mytabulatorclass"></div>
                   

                </div>


        </div>
        <div class="actions">

            <div class="ui grey enabled right labeled icon left floated  button" id="btnDownloadCSV_withoutorder">
                <%=GetLocalResourceObject("btnDownloadCsv")%>   
                <i class="file outline icon"></i>
            </div>

            <div class="ui grey enabled right labeled icon left floated button" id="btnDownloadPDF_withoutorder">
                <%=GetLocalResourceObject("btnDownloadPdf")%>  
                <i class="file pdf icon"></i>
            </div>



            <div class="ui disabled left labeled icon button" id="po_modal_previous_withoutorder">
                <%=GetLocalResourceObject("btnPrevious")%>   
                <i class="chevron left icon"></i>
            </div>



            <div class="ui positive right labeled icon button" id="po_modal_next_withoutorder">
                <div><%=GetLocalResourceObject("btnNext")%>  </div>

                <i class="chevron right icon"></i>
            </div>



        </div>
    </div>
   



    <div class="fullscreen ui modal" id="modal_auto_steps">
        <a class="ui red ribbon label" id="redRibbonAutomodal"></a>
        <i class="close icon"></i>
        <div class="header">
             <div class="ui five top attached steps"> 
                 <div class="active step" id="step_auto_first">
                        <i class="clipboard list icon"></i>
                        <div class="content">
                            <div class="title"><%=GetLocalResourceObject("lblSupplierSetup")%>  </div>
                            <div class="description"><%=GetLocalResourceObject("lblSupplierSetupText")%>  </div>
                        </div>
                    </div>
                    <div class="disabled step" id="step_auto_second">
                        <i class="question icon"></i>
                        <div class="content">
                            <div class="title"><%=GetLocalResourceObject("lblPurchaseMethod")%></div>
                            <div class="description"><%=GetLocalResourceObject("lblPurchaseMethodText")%></div>
                        </div>
                    </div>
                 <div class="disabled step" id="step_auto_third">
                     <i class="question icon"></i>
                     <div class="content">
                         <div class="title"><%=GetLocalResourceObject("lblSendPurchase")%></div>
                         <div class="description"><%=GetLocalResourceObject("lblSendPurchaseText")%></div>
                     </div>
                 </div>
                 <div class="disabled step" id="step_auto_fourth">
                     <i class="question icon"></i>
                     <div class="content">
                         <div class="title"><%=GetLocalResourceObject("lblPurchaseArrival")%></div>
                         <div class="description"><%=GetLocalResourceObject("lblPurchaseArrivalText")%></div>
                     </div>
                 </div>
                 <div class="disabled step" id="step_auto_fifth">
                     <i class="question icon"></i>
                     <div class="content">
                         <div class="title"><%=GetLocalResourceObject("lblPurchaseDetails")%></div>
                         <div class="description"><%=GetLocalResourceObject("lblPurchaseDetailsText")%></div>
                     </div>
                 </div>

             </div>
        </div>


        <div class="content">
            <div class="modal_auto_divstep1">
                <div class="ui header">Opprett forslag</div>
                <div class="ui stackable form">
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 400px" id="txtbxSupplierModalparentAutomatic" >
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                <%=GetLocalResourceObject("lblSupplier")%>                                            
                            </div>
                            <input type="text" placeholder="Søk leverandør" id="txtbxSupplierModalAutomatic" />
                            
                        </div>
                        <div class="two wide field" style="max-width: 100px">
                        <input type="text" id="txtbxSuppcurrentnoModalAutomatic" disabled="disabled"/>
                        </div>
                    </div>
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 340px">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                <%=GetLocalResourceObject("lblPurchaseType")%>                                            
                            </div>                       
                        
                            <%--<div class="ui selection dropdown" id="dropdown_modal_ordertypes">
                                <input type="hidden" name="gender"/>
                                <i class="dropdown icon"></i>
                                <div class="default text">Søk Bestillingstype</div>
                                <div class="menu">
                                    
                                    <div class="item" data-value="RE">RE</div>
                                    <div class="item" data-value="LO">LO</div>
                                </div>
                            </div>--%>
                            <select name="frop" id="dropdown_modal_ordertypes">
                                <i class="dropdown icon"></i>
                              <option value="RE">RE</option>
                              <option value="LO">LO</option>
                              <option value="DO">DO</option>
                            </select>
                        </div>

                        <div class="one wide field">
                            <div id="addOrderTypes" class="ui mini icon top left pointing green dropdown button disabled" >
                            <i class="plus icon"></i>
                            </div>
                       </div>
                    </div>
                    <div class="inline fields">
                        <div class="eight wide field" style="max-width: 340px"">
                            <div class="ui blue label" style="min-width: 120px"; text-align: center">
                                <%=GetLocalResourceObject("lblSendingType")%>                                            
                            </div>
                                                 
                            <div class="ui selection dropdown" id="dropdown_modal_deliverymethods">
                                <input type="hidden" name="gender" />
                                <i class="dropdown icon"></i>
                                <div class="default text">Søk Forsendelsesmåte</div>
                                <div class="menu">
                                 
                                    <div class="item" data-value="0">Tog</div>
                                    <div class="item" data-value="1">Bil</div>
                                </div>
                            </div>
                            </div>
                            <div class="one wide field">
                            <div id="addDeliveryMethods" class="ui mini icon top left pointing green dropdown button" >
                            <i class="plus icon"></i>
                            </div>
                       </div>
                        </div>
                        <div class="inline fields">
                        <div class="eight wide field" style="max-width: 360px">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                <%=GetLocalResourceObject("lblArrivalDate")%>                                            
                            </div>
                            <input type="text"  id="txtbxExpDeliverys" disabled="disabled" style="font-weight:bold;"/>
                           
                        
                        </div>
                        </div>

                    </div>
                </div>
            
       
         
         
          
       

            <div class="modal_auto_divstep2">

                <div class="ui header"><%=GetLocalResourceObject("lblAutoPurchaseSettings")%></div>
                <div class="ui form stackable two column grid ">
                    <div class="four wide column">
                        <%-- START Middle Column --%>
                        <div class="ui form">
                            <h3 class="ui top attached tiny header">Bestillingsmetode</h3>
                            <div class="ui attached segment">
                                <div class="fields">
                                    <div class="grouped fields">
                                        <label><%=GetLocalResourceObject("lblBasedOn")%></label>
                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="example2" checked="checked" value="H" />
                                                <label><%=GetLocalResourceObject("lblHistoricalTurnover")%></label>
                                            </div>
                                        </div>
                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="example2" value="Y" />
                                                <label><%=GetLocalResourceObject("lblYearlyTurnover")%></label>
                                            </div>
                                        </div>
                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="example2" value="M" />
                                                <label><%=GetLocalResourceObject("lblMinimumQuantity")%></label>
                                            </div>
                                        </div>
                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="example2" value="W" />
                                                <label><%=GetLocalResourceObject("lblSparesWithoutMinimumQuantity")%></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="four wide column">
                <div class="ui form">
                    <h3 class="ui top attached tiny header"><%=GetLocalResourceObject("lblAssessmentsonGenerating")%></h3>
                    <div class="ui attached segment">
                        <div class="fields">
                            <div class="grouped fields">
                                <label><%=GetLocalResourceObject("lblBasedOn")%></label>
                                <div class="field">
                                    <div class="ui checkbox">
                                        <input type="checkbox" name="example3" id="maxBox" checked="checked"/>
                                        <label><%=GetLocalResourceObject("lblMaxQtyOrdered")%></label>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="ui checkbox">
                                        <input type="checkbox" name="example3"/>
                                        <label><%=GetLocalResourceObject("lblDprAssessment")%></label>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="ui checkbox">
                                        <input type="checkbox" name="example3"/>
                                        <label><%=GetLocalResourceObject("lblDiscountAssessment")%></label>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="ui checkbox">
                                        <input type="checkbox" name="example3"/>
                                        <label><%=GetLocalResourceObject("lblSameDiscountCheck")%></label>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="ui checkbox">
                                        <input type="checkbox" name="example3"/>
                                        <label><%=GetLocalResourceObject("lblCheckSeasonSpares")%></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="five wide column">

                <h3 id="lblPurchaseDetailsAutomatictabxxxxs" class="ui top attached tiny header"><%=GetLocalResourceObject("lblPurchaseDetails")%></h3>
                <div class="ui attached segment">
                                    
                    
                        <div class="inline fields">
                            <div class="five wide field">

                                <div id="lblSupplierNameAutomatictabsxxxx" class="ui blue horizontal label"><%=GetLocalResourceObject("lblFromSparePart")%></div>
                            </div>
                            <div class="five wide field">
                                <div class="ui small input">
                                    <asp:TextBox ID="TextBox1" runat="server" data-submit="SAVE_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>
                           
                           
                             </div>
                     <div class="inline fields"> 
                            <div class="five wide field">

                                <div id="lblSupplierNameAutomatictabssxxx" class="ui blue horizontal label"><%=GetLocalResourceObject("lblToSparePart")%></div>
                            </div>
                            <div class="five wide field">
                                <div class="ui small input">
                                    <asp:TextBox ID="TextBox8" runat="server" data-submit="SAVE_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>
                            
                         </div>

                    <div class="inline fields">
                            <div class="five wide field">

                                <div id="lblSupplierNameAutomatictabsssxxx" class="ui teal horizontal label"><%=GetLocalResourceObject("lblFromProductGroup")%></div>
                            </div>
                            <div class="five wide field">
                                <div class="ui small input">
                                    <asp:TextBox ID="TextBox9" runat="server" data-submit="SAVE_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>
                           
                           
                             </div>
                     <div class="inline fields"> 
                            <div class="five wide field">

                                <div id="lblSupplierNameAutomatictabssssxxx" class="ui teal horizontal label" ><%=GetLocalResourceObject("lblToProductGroup")%></div>
                            </div>
                            <div class="five wide field">
                                <div class="ui small input">
                                    <asp:TextBox ID="TextBox10" runat="server" data-submit="SAVE_SUPPLIER_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>
                            
                         </div>

                        </div>                        
                    </div>
                </div>

                </div>




                
            
                                   

            <div class="modal_auto_divstep3">
                <div class="ui header"><%=GetLocalResourceObject("headPurchaseDetails")%></div>
                <div class="fifteen wide column">
                <div id="autoPOsuggestion-table" class="mytabulatorclass"></div>
            </div>

            </div>
            <div class="modal_auto_divstep4">
                <div class="ui header"><%=GetLocalResourceObject("headArrivalofSpares")%></div>
                <div class="fields">
                    <div class="three wide field">
                    </div>
                    <div id="item-table-modal-confirmedOrdersx" class="mytabulatorclass"></div>
                    
                </div>              

            </div>
              

       
            <div class="modal_auto_divstep5">
                <div class="ui header">Leverte varer og fullførte varelinjer</div>
                <div class="fields">
                    <div class="six wide field">
                        <div class="ui red horizontal label" style="margin-bottom: 2em" ><%=GetLocalResourceObject("lblPurchaseNo")%></div>
                            <a class="detail" id="pomodal_details_ponumber4s"></a>


                            <div class="ui blue horizontal label" style="margin-left: 2em"><%=GetLocalResourceObject("lblSupplier")%></div>
                            <a class="detail" id="pomodal_details_suppliers4"></a>

                            <div class="ui green horizontal label" style="margin-left: 2em""><%=GetLocalResourceObject("lblPurchaseType")%></div>
                            <a class="detail" id="pomodal_details_ordertype4s"></a>
                    </div>                    
                    <div id="item-table-modal-finals" class="mytabulatorclass"></div>
                </div>

            </div>
            

        </div>
        <div class="actions">
            
            <div class="ui disabled yellow enabled right labeled icon button" id="auto_modal_update"> 
                <%=GetLocalResourceObject("btnUpdate")%> 
                <i class="retweet icon"></i>
            </div>
           
            <div class="ui disabled left labeled icon button" id="auto_modal_previous"> 
                <%=GetLocalResourceObject("btnPrevious")%> 
                <i class="chevron left icon"></i>
            </div>      

            <div class="ui positive right labeled icon button" id="auto_modal_next">
                <div><%=GetLocalResourceObject("btnNext")%></div> 
                 
                <i class="chevron right icon"></i>
            </div>

        </div>
    </div>

    </div>
    
    <dx:ASPxCallbackPanel ID="cbPanel" ClientInstanceName="cbPanel" runat="server" OnCallback="cbPanel_Callback"  ClientSideEvents-EndCallback="OnEndCallbackcbOpenReport">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <div>
                        <dx:ASPxPopupControl ID="popupReport" runat="server" ClientInstanceName="popupReport" AllowDragging="false" Modal="True" Theme="iOS" CloseAction="CloseButton" ClientSideEvents-Closing="OnpopupReportClosing">

                            <Windows>
                                <dx:PopupWindow ContentUrl="ReportViewer_SS3.aspx" HeaderText="Report" Name="report"
                                    Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                                </dx:PopupWindow>
                            </Windows>
                        </dx:ASPxPopupControl>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

     <dx:ASPxCallbackPanel ID="cbBOReport" ClientInstanceName="cbBOReport" runat="server" OnCallback="cbBOReport_Callback"  ClientSideEvents-EndCallback="OnEndCallbackcbOpenReport">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <div>
                        <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" ClientInstanceName="popupReport" AllowDragging="false" Modal="True" Theme="iOS" CloseAction="CloseButton" ClientSideEvents-Closing="OnpopupReportClosing">

                            <Windows>
                                <dx:PopupWindow ContentUrl="ReportViewer_SS3.aspx" HeaderText="Report" Name="report"
                                    Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                                </dx:PopupWindow>
                            </Windows>
                        </dx:ASPxPopupControl>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

    <dx:ASPxPopupControl ID="popupSelRepType" runat="server" ShowFooter="false" ClientInstanceName="popupSelRepType" PopupHorizontalAlign="Center" Modal="True" HeaderText=" Select type of Report" PopupVerticalAlign="Middle" Top="250" Left="550" Width="500" Height="200" CloseAction="CloseButton" Theme="Office365" ShowCloseButton="true" AllowDragging="False">
        <ClientSideEvents CloseButtonClick="function(s,e){$('#modal_po_steps').modal('show');}" />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <div>
                    <div class="content">
                        <div class="ui grid">
                            <div class="sixteen wide column">
                                <div class="ui form">
                                    <div class="inline fields">
                                        <div class="ten wide field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" id="rbRptWithAllSpr" checked="checked" name="rbGrp1" value="true" />
                                                <label>Report with all spares</label>
                                            </div>
                                        </div>
                                        <div class="six wide field">
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="ten wide field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" id="rbRptWithOdrSpr" name="rbGrp1" value="false" />
                                                <label>Report with order attached spares</label>
                                            </div>
                                        </div>
                                        <div class="six wide field">
                                        </div>
                                    </div>
                                    <div class="inline fields">
                                        <div class="twelve wide field">
                                        </div>
                                        <div class="four wide field">
                                            <div class="ui button" id="btnPoRepPrint" onclick="RptPrintClick()">Print</div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


</asp:Content>


