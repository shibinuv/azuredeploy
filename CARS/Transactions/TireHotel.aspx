<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="TireHotel.aspx.vb" Inherits="CARS.TireHotel" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">


    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/2.3.2/jspdf.plugin.autotable.js"></script>
    <script type="text/javascript">
        var warehouseIdTP = '';
        let mobile = [];
        let arrayOfValues = [];
        let smstext = "";
        $(document).ready(function () {
            /*
                This method is called when the page is loaded to initialise different things
            */
            myNameSpace = function () {

                var objectOfVariables = {
                    po_modal_state: 1,            //1:means that we are at the state where you still can add more spareparts to order 2:after pressing next and on "send order". 3: is final state
                    po_modal_state_canclose: 0,
                    po_modal_ddlnonstock: false,
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
                    po_delivered: false,
                    last_item_was_nonstock: false,
                    focus_set_once: false,
                    sel_modal_state: 1,
                    sel_modal_state_canclose: 0,

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
                                console.log("Set variable!" + newvalue);
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


            var departmentID = '';    //global variable in this file
            var warehouseID = '';     //global variable in this file
            var tabcounter = 0;
            var closed = 0;
            var _loginName;
            var errorSpareList = [];
            var line = 0;
            var updated = 0;
            var items = [];
            loadInit();

            function loadInit() {
                setTab('TirePackageList');

                getDepartmentID();
                getWarehouseID();
                getLoginName();
                loadTireType();
                loadTireSpike();
                loadRimType();
                loadTireQuality();
                loadTireBrand();
                $('#<%=drpTireSpike.ClientID%>').val(15);
                //loadTireDepth();
                var today = $.datepicker.formatDate('dd-mm-yy', new Date());
                //$('#<%=lblOrderDate.ClientID%>').text(today);
                fillSMSTexts();
                initFirstStep();
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
                    console.log("cha");


                }


                tabcounter++;

            }
            //tabs with class .ctab have this onclick func that calls setTab for switching tabs
            $('.cTab').on('click', function (e) {
                setTab($(this));
            });


            

            function getWarehouseID() {
                console.log("inside getware");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "TireHotel.aspx/LoadWarehouseDetails",
                    data: '{}',
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        {
                            if (data.d.length != 0) {

                                warehouseID = data.d[0].WarehouseID;
                                warehouseIdTP = warehouseID;
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
                    url: "TireHotel.aspx/FetchCurrentDepartment",
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


            $("#<%=searchbutton.ClientID%>").on('click', function (e) {
                var dateFrom;
                var DateTo;
               <%-- if ($("#<%=txtbxDateFrom.ClientID%>").val() != '') {
                    var moddateFrom = $("#<%=txtbxDateFrom.ClientID%>").val();
                    var datetimeFrom = moddateFrom.split("-");
                    dateFrom = datetimeFrom[2] + "-" + datetimeFrom[1] + "-" + datetimeFrom[0] + " 00:00:00.000";
                }
                else {
                    dateFrom = '';
                }
                if ($("#<%=txtbxDateTo.ClientID%>").val() != '') {
                    var moddateTo = $("#<%=txtbxDateTo.ClientID%>").val();
                    var datetimeTo = moddateTo.split("-");
                    dateTo = datetimeTo[2] + "-" + datetimeTo[1] + "-" + datetimeTo[0] + " 23:59:59.999";
                }
                else {
                    dateTo = '';
                }--%>
               
                $("#TirePackage-table").tabulator("setData", "TireHotel.aspx/Fetch_TP_List", { 'wh': warehouseID, 'tpNo': $("#<%=txtSearchTPNo.ClientID%>").val(), 'closed': closed, 'refNo': $("#<%=txtSearchRefNo.ClientID%>").val(), 'custNo': $("#<%=txtSearchCustNo.ClientID%>").val(), 'tireType': $("#<%=drpSearchTireType.ClientID%>").val(), 'tireQuality': $("#<%=drpSearchTireQuality.ClientID%>").val() });
                $("#TirePackage-table").tabulator("redraw", true);
                
               
                //$("#TirePackage-table").transition("vertical flip");


            });

        
            function loadSearch() {
                 var dateFrom;
                var DateTo;
               <%-- if ($("#<%=txtbxDateFrom.ClientID%>").val() != '') {
                    var moddateFrom = $("#<%=txtbxDateFrom.ClientID%>").val();
                    var datetimeFrom = moddateFrom.split("-");
                    dateFrom = datetimeFrom[2] + "-" + datetimeFrom[1] + "-" + datetimeFrom[0] + " 00:00:00.000";
                }
                else {
                    dateFrom = '';
                }
                if ($("#<%=txtbxDateTo.ClientID%>").val() != '') {
                    var moddateTo = $("#<%=txtbxDateTo.ClientID%>").val();
                    var datetimeTo = moddateTo.split("-");
                    dateTo = datetimeTo[2] + "-" + datetimeTo[1] + "-" + datetimeTo[0] + " 23:59:59.999";
                }
                else {
                    dateTo = '';
                }--%>
                $("#TirePackage-table").tabulator("setData", "TireHotel.aspx/Fetch_TP_List", { 'wh': warehouseID, 'tpNo': $("#<%=txtSearchTPNo.ClientID%>").val(), 'closed': closed, 'refNo': $("#<%=txtSearchRefNo.ClientID%>").val(), 'custNo': $("#<%=txtSearchCustNo.ClientID%>").val(), 'tireType': $("#<%=drpSearchTireType.ClientID%>").val(), 'tireQuality': $("#<%=drpSearchTireQuality.ClientID%>").val() });
                $("#TirePackage-table").tabulator("redraw", true);
            }
            $("#<%=txtSearchTPNo.ClientID%>").on('blur', function (e) {

                <%--if ($("#<%=txtbxCLnumbersearch.ClientID%>").val() != '') {
                    $("#<%=txtCLSupplier.ClientID%>").prop('disabled', true);
                    $("#<%=txtCLSpare.ClientID%>").prop('disabled', true);
                }
                else {
                    $("#<%=txtCLSupplier.ClientID%>").prop('disabled', false);
                    $("#<%=txtCLSpare.ClientID%>").prop('disabled', false);
                }--%>



            });

            $("#<%=txtAxleStandardDepth.ClientID%>").on('blur', function (e) {
                if ($("#<%=txtAxleStandardDepth.ClientID%>").val() != "") {
                $("#<%=txtTireDepth1L.ClientID%>").val($("#<%=txtAxleStandardDepth.ClientID%>").val());
                 $("#<%=txtTireDepth2L.ClientID%>").val($("#<%=txtAxleStandardDepth.ClientID%>").val());
                 $("#<%=txtTireDepth1R.ClientID%>").val($("#<%=txtAxleStandardDepth.ClientID%>").val());
                    $("#<%=txtTireDepth2R.ClientID%>").val($("#<%=txtAxleStandardDepth.ClientID%>").val());
                }
             });

            $("#<%=txtAxleStandardTruckDepth.ClientID%>").on('blur', function (e) {
                if ($("#<%=txtAxleStandardTruckDepth.ClientID%>").val() != "") {
                    if ($("#<%=drpAxleNo.ClientID%>").val() == 2) {
                        $("#<%=txtTruckDepth1L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth1R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                    }
                    else if ($("#<%=drpAxleNo.ClientID%>").val() == 3) {
                        $("#<%=txtTruckDepth1L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth1R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                    }
                    else if ($("#<%=drpAxleNo.ClientID%>").val() == 4) {
                        $("#<%=txtTruckDepth1L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth1R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                    }
                    else if ($("#<%=drpAxleNo.ClientID%>").val() == 5) {
                        $("#<%=txtTruckDepth1L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth1R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                    }
                    else if ($("#<%=drpAxleNo.ClientID%>").val() == 6) {
                        $("#<%=txtTruckDepth1L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth1R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth6L.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth6L2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth2R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth3R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth4R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth5R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth6R.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                        $("#<%=txtTruckDepth6R2.ClientID%>").val($("#<%=txtAxleStandardTruckDepth.ClientID%>").val());
                    }
                }
            });



           
            $("#<%=chkSearchClosed.ClientID%>").on('click', function (e) {


                if ($("#<%=chkSearchClosed.ClientID%>").is(':checked')) {
                    $("#<%=chkSearchClosed.ClientID%>").prop('checked', true);
                    closed = 1;
                }

                else {
                    $("#<%=chkSearchClosed.ClientID%>").prop('checked', false);
                    closed = 0;
                }

            });




            /****              DATEPICKERS START                */


            //datepickers should now be bulletproof!! Some magic in onselect!

            $("#<%=txtExpectedOuteDate.ClientID%>").datepicker({
                showWeek: true,
                showOn: "button",
                buttonImage: "../images/calendar_icon.gif",
                buttonImageOnly: true,
                buttonText: "Velg dato",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+10",
                dateFormat: "dd.mm.yy",
                onSelect: function (date) {

                    var startDate = $(this).datepicker('getDate');
                    var minDate = $(this).datepicker('getDate');


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


            $('#modal_cl_steps').modal({
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


                    $("#btnAddItemToTableModal").addClass("disabled");
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


            $.contextMenu({
                selector: '#TirePackage-table .tabulator-selected',   //only trigger contextmenu on selected rows in table
                items: {
                    open: {
                        name: "Åpne dekkpakke",
                        icon: "paste",
                        callback: function (key, opt) {
                            openModalTPInfo(); //opens modal and shows information about the items on this order


                        }
                    },


                    deletePO: {
                        name: "Slett dekkpakke",
                        icon: "delete",
                        callback: function (key, opt) {
                            var rows = $("#TirePackage-table").tabulator("getSelectedRows");
                            var row = rows[0];
                            
                            //deleteTirePackage(row.getData().tirePackageNo);
                            //alert(row.getData().isFinished);
                            if (row.getData().isFinished == 'False') {
                                    deleteTirePackage(row.getData().tirePackageNo);
                                $("#TirePackage-table").tabulator("setData", "TireHotel.aspx/Fetch_TP_List", { 'wh': warehouseID, 'tpNo': $("#<%=txtSearchTPNo.ClientID%>").val(), 'closed': closed, 'refNo': $("#<%=txtSearchRefNo.ClientID%>").val(), 'custNo': $("#<%=txtSearchCustNo.ClientID%>").val(), 'tireType': $("#<%=drpSearchTireType.ClientID%>").val(), 'tireQuality': $("#<%=drpSearchTireQuality.ClientID%>").val() });
                                $("#TirePackage-table").tabulator("redraw", true);
                                }
                                else {
                                    systemMSG('error', 'Dekkpakken er avsluttet og kan derfor ikke slettes.', 5000);

                                }
                           

                        },
                        disabled: function (key, opt) {
                            var rows = $("#TirePackage-table").tabulator("getSelectedRows");
                            var row = rows[0];

                            //if (row.getCell("CLOSED").getValue() == 'True') {
                            //    return true;
                            //}
                            //else {
                            //    return false;
                            //}

                        }
                    },

                }
            });



            $("#<%=btnViewTireDepthSpecs.ClientID%>").on('click', function (e) {
                $(".contentCar, .contentTruck").removeClass('hidden');
                $(".contentTruck").addClass('hidden');
                $(".tire3l, .tire4l, .tire5l, .tire6l").removeClass('hidden');
                $(".tire3r, .tire4r, .tire5r, .tire6r").removeClass('hidden');
                if ($('#<%=drpAxleNo.ClientID%>').val() == 1) {
                    $(".contentCar, .contentTruck").removeClass('hidden');
                    $(".contentTruck").addClass('hidden');
                }
                else if ($('#<%=drpAxleNo.ClientID%>').val() == 2) {
                    $(".tire3l, .tire4l, .tire5l, .tire6l").addClass('hidden');
                    $(".tire3r, .tire4r, .tire5r, .tire6r").addClass('hidden');
                    $(".contentCar").addClass('hidden');
                    $(".contentTruck").removeClass('hidden');
                }
                else if ($('#<%=drpAxleNo.ClientID%>').val() == 3) {
                    $(".tire4l, .tire5l, .tire6l").addClass('hidden');
                    $(".tire4r, .tire5r, .tire6r").addClass('hidden');
                    $(".contentCar").addClass('hidden');
                    $(".contentTruck").removeClass('hidden');
                }
                else if ($('#<%=drpAxleNo.ClientID%>').val() == 4) {
                    $(".tire5l, .tire6l").addClass('hidden');
                    $(".tire5r, .tire6r").addClass('hidden');
                    $(".contentCar").addClass('hidden');
                    $(".contentTruck").removeClass('hidden');
                }
                else if ($('#<%=drpAxleNo.ClientID%>').val() == 5) {
                    $(".tire6l").addClass('hidden');
                    $(".tire6r").addClass('hidden');
                    $(".contentCar").addClass('hidden');
                    $(".contentTruck").removeClass('hidden');
                }

                else if ($('#<%=drpAxleNo.ClientID%>').val() == 6) {
                        $(".contentCar, .contentTruck").removeClass('hidden');
                        $(".contentCar").addClass('hidden');
                    }

                $('#modal_cl_steps').modal('hide');
                $('#vehicleTireDepthSpecification').modal('show');

            });



            /* When clicking delete item(fjern vare) delete the selected row */




            //muy importante lesson learned!!! DYNAMICALLY INSERTED HTML INSIDE JAVASCRIPT like I have done with footer-element inside tabulator-constructors
            //behave differently. They cannot be triggered the same way as if they were coded inside the html bit.
            //instead we use document.on etc..

            /* $('#btnDeleteRowModal').on('click', function (e) {
 
                 if (confirm("Vil du slette varen(e)?"))  {
                     deleteRowsFromTable("#item-table-modal");
                 }
 
             });
             */
            $(document).on('click', '#btnDeleteRowModal', function (e) {
                if (confirm("Vil du slette varen(e)?")) {
                    deleteRowsFromTable("#item-table-modal");
                }
            });

            $(document).on('click', '#btnDeleteRow', function (e) {
                if (confirm("Vil du slette varen(e)?")) {
                    deleteRowsFromTable("#item-table");
                }
            });


            /* On click for searchbutton and the show/hide icon. Hides the container div that contains input fields etc so that only our table is displayed */
            $('#btnViewDetails, #btnViewDetailsNEWPO').on('click', function (e) {
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

                $(containerElement).slideToggle(500);
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



            /**  OUR TABLES CREATED BY THE GREAT TABULATOR PLUGIN. **/
            /**  THE TABULATOR WEBPAGE IS http://tabulator.info    HERE YOU CAN FIND ALL INFO YOU NEED ABOUT THIS TABLE PLUGIN **/



            /* TABLE IN MODAL FOR DISPLAYING ADDED ITEMS TO ORDER */


            var customSelectEditor = function (cell, onRendered, success, cancel) {
                //cell - the cell component for the editable cell
                //onRendered - function to call when the editor has been rendered
                //success - function to call to pass the succesfully updated value to Tabulator
                //cancel - function to call to abort the edit and return to a normal cell

                var editor = $("<input type='decimal'></input>");
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
                editor.on("change blur", function (e) {
                    //Updates the line in the counting list on blur and updated modified by, modified date  and the difference on the values set on stock after and before.
                    success(editor.val());
                    var row = cell.getRow();
                    var celldate = row.getCell("DT_MODIFIED");
                    var modby = row.getCell("MODIFIED_BY");
                    var d = new Date();
                    var strDate = ('0' + d.getDate()).slice(-2) + "." + ('0' + (d.getMonth() + 1)).slice(-2) + "." + d.getFullYear();
                    celldate.setValue(strDate, true);
                    modby.setValue(_loginName);


                    //calculating the stock before and after to set the difference
                    var stockbefore = row.getCell("STOCKBEFORECOUNT").getValue();
                    console.log("sjekker stockbefore: " + stockbefore);
                    var stockafter = row.getCell("STOCKAFTERCOUNT").getValue();
                    stockbefore = parseFloat(stockbefore.replace(",", "."));
                    stockafter = parseFloat(stockafter.replace(",", "."));
                    var difference = row.getCell("DIFFERENCE");

                    var newdifference = stockafter - stockbefore;
                    var newdifference2 = newdifference.toFixed(2).replace('.', ',');
                    difference.setValue(newdifference2);
                    setTimeout(function () {

                        editor.focus();
                        //editor.css("height", "100%");
                        editor.select();
                    }, 0);
                });
                return editor[0];

            }







            /* TABLE IN TAB PURCHASEORDERS FOR SEARCHING FOR POs */


            $("#TirePackage-table").tabulator({
                height: 510, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                responsiveLayout: true,
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string
                //pagination: "local",
                //paginationSize: 30,
                //persistentLayout: true, //Enable column layout persistence
                //groupBy: "PONUMBER",
                //groupStartOpen: false,
                //groupHeader: Function (value, count, data) {
                //value - the value all members of this group share
                //count - the number of rows in this group
                //data - an array of all the row data objects in this group
                /* var str = "";
                 If (count > 1) Then str = " varer)";
                 Else Str = " vare )";

                 Return value + "<span style='color:#d00; margin-left:10px;'>(" + count + Str() + "<span style='margin-right:300px;'>";
             },*/

                selectableCheck: function (row) {

                    var selectedRows = $("#TirePackage-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        if (row.getData().tirePackageNo == selectedRows[0].getData().tirePackageNo) {
                            return false;
                        }
                    }


                    return true; //alow selection of rows where the age is greater than 18
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    openModalTPInfo(); //opens modal and shows information about the items on this order


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
                    {

                        title: "Dekkpakke", field: "tirePackageNo", align: "center", headerFilter: "input", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Refnr.", field: "refNo", align: "center", headerFilter: "input" },
                    { title: "Regnr", field: "regNo", align: "center", headerFilter: "input" },
                    { title: "Kundenr", field: "custNo", align: "center", headerFilter: "input" },
                    { title: "Kundenavn", field: "custName", align: "center", headerFilter: "input" },
                    { title: "Lokasjon", field: "location", align: "center", headerFilter: "input" },
                     { title: "Dekktype", field: "tireTypeDesc", align: "center", headerFilter: "input" },
                      { title: "Dekkvalitet", field: "tireQualityDesc", align: "center", headerFilter: "input" },
                       {
                           title: "Status", field: "isFinished", align: "center", formatter: "tickCross", headerFilter: "input"
                       },

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]

            });


            function openModalTPInfo() {



                //gets the selected row
                var selectedRows = $("#TirePackage-table").tabulator("getSelectedRows");
                row = selectedRows[0];
                console.log(row);
                //checks if its a confirmed order and only to show the last tab in modal or if its not confirmed yet.

                var closed = row.getCell("isFinished").getValue();
                console.log("conf is " + closed);

                if (closed === "False")   //third
                {
                    //alert('3rd step');
                    initSecondModalStepView(row);
                    var packageNo = row.getCell("tirePackageNo").getValue();
                    resetTireDepth();
                    resetForms();
                    FetchTirePackageDetails(packageNo);
                    FetchTirePackageDepth(packageNo);
                }
                else if (closed === "True") {
                    swal("Du kan ikke åpne lukkede dekkpakker!");
                }
                else  //not finished, not confirmed, so we open the FIRST STEP
                {
                    //alert('2nd step');

                    initSecondModalStepView();

                    //var row = cell.getRow();
                    var packageNo = row.getCell("tirePackageNo").getValue();
                    resetTireDepth();
                    resetForms();
                    FetchTirePackageDetails(packageNo);
                    FetchTirePackageDepth(packageNo);

                    $('#redRibbonPOmodal').text(packageNo);
                }
            }
            //Opens the list after it is saved into the new tabulator list "counting-table-edit-modal"

            function initFirstModalStepView() {
                //brings over various variables from grid to the modal window

                //alert("1st step");

                //content divs(tables)

                $('.modal_cl_divstep1').removeClass('hidden');
                $('.modal_cl_divstep2').addClass('hidden');
                $('.modal_cl_divstep3').addClass('hidden');
                $('.modal_cl_divstep4').addClass('hidden');

                //header steps
                $("#step_cl_first").removeClass("completed step");
                $("#step_cl_first").removeClass("disabled step");
                $("#step_cl_first").addClass("active step");

                $("#step_cl_second").removeClass("active step");
                $("#step_cl_second").removeClass("completed step");
                $("#step_cl_second").addClass("disabled step");

                $("#step_cl_third").removeClass("active step");
                $("#step_cl_third").removeClass("completed step");
                $("#step_cl_third").addClass("disabled step");

                //buttons
                $("#po_modal_save").hide();
                $("#po_modal_update").hide();
                $("#po_modal_previous").hide();
                $("#po_modal_next").show();
                $('#po_modal_close').hide();
                $('#lblfileUpload2').hide();
                $("#fileUpload2").hide();
                $('#btnErrorSpareListView').hide();
                $("#btnEditImport").hide();
                $('#btnTPPrint').hide();

                myNameSpace.set("po_modal_state", 1);
                $('#modal_po_steps').modal('show');
                $('#modal_po_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
            }

            function initSecondModalStepView() {
                //brings over various variables from grid to the modal window

                //content divs(tables)

                $('.modal_cl_divstep1').addClass('hidden');
                $('.modal_cl_divstep2').removeClass('hidden');
                $('.modal_cl_divstep3').addClass('hidden');


                //header steps
                $("#step_cl_first").addClass("completed step");
                $("#step_cl_first").addClass("disabled step");
                $("#step_cl_first").removeClass("active");

                $("#step_cl_second").addClass("active");

                $("#step_cl_second").removeClass("disabled");

                $("#step_cl_third").removeClass("active step");
                $("#step_cl_third").removeClass("completed step");
                $("#step_cl_third").addClass("disabled step");

                //button states
                $("#po_modal_save").hide();
                $("#po_modal_update").hide();
                $("#po_modal_previous").show();
                $("#po_modal_next").show();
                $("#btnEditImport").hide();
                $('#po_modal_close').hide();
                $('#lblfileUpload2').hide();
                $("#fileUpload2").hide();
                $('#btnErrorSpareListView').hide();
                $("#btnEditImport").hide();
                $('#btnTPPrint').hide();

                myNameSpace.set("po_modal_state", 2);

                $('#modal_cl_steps').modal('show');
                //$("#counting-table-edit-modal").tabulator("redraw");

            }

            function initThirdModalStepView(row) {

                //content divs

                $('.modal_cl_divstep1').addClass('hidden');
                $('.modal_cl_divstep2').addClass('hidden');
                $('.modal_cl_divstep3').removeClass('hidden');
                $('.viewCLClosed').removeClass('hidden');
                $('.CLClosed').addClass('hidden');


                //header steps

                $("#step_cl_first").addClass("completed step");
                $("#step_cl_first").addClass("disabled step");
                $("#step_cl_second").removeClass("active step");
                $("#step_cl_second").addClass("completed step");
                $("#step_cl_second").addClass("disabled step")
                $("#step_cl_third").removeClass("disabled step");
                $("#step_cl_third").addClass("completed step");
                $("#step_cl_third").addClass("active step");


                //buttons

                $("#po_modal_update").hide();
                $("#po_modal_previous").hide();
                $("#po_modal_next").hide();
                $("#po_modal_close").hide();
                $("#po_modal_save").hide();
                $("#btnEditImport").hide();
                $("#btnEditPrint").show();
                $('#redRibbonPOmodal').text();
                $('#lblfileUpload2').addClass("hidden");
                $("#fileUpload2").addClass("hidden");

                //update state
                myNameSpace.set("po_modal_state", 3);
                //myNameSpace.set("po_modal_state_canclose", 1);
                console.log("new state: " + myNameSpace.get("po_modal_state"));

                $('#modal_cl_steps').modal('show');

                $('#modal_cl_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
            }



            //we add this customheaderfilter so that the user can type "ja" / "nei" instead of true/false. Users are not like us programmers;) true/false makes no sense to them
            function customHeaderFilter(headerValue, rowValue, rowData, filterParams) {
                //headerValue - the value of the header filter element
                //rowValue - the value of the column in this row
                //rowData - the data for the row being filtered
                //filterParams - params object passed to the headerFilterFuncParams property 
                var retval = false;
                if (headerValue === "ja") {
                    console.log("rowval er " + rowValue);
                    if (rowValue === "True") { retval = true; }
                }
                else if (headerValue === "nei") {
                    console.log("rowval er " + rowValue);
                    if (rowValue === "False") { retval = true; }
                }
                return retval; //must return a boolean, true if it passes the filter.
            }

            $(window).resize(function () {
                $("#TirePackage-table").tabulator("redraw", true); //trigger full rerender including all data And rows
            });

            $('#po_modal_save').on('click', function (e) {

                if (myNameSpace.get("po_modal_state") == 1)     //first step in modal
                {

                    //content divs
                    var rows = $("#counting-table-modal").tabulator("getRows");
                    for (i = 0; i < rows.length; i++) {
                        var success = addItemToCL(rows[i]);
                        if (!success) {
                            alert("Noe gikk galt med lagring av varer på telleliste");
                        }

                    }
                    $('.modal_cl_divstep1').addClass('hidden');
                    $('.modal_cl_divstep2').removeClass('hidden');

                    //header steps
                    $("#step_cl_first").removeClass("active step");
                    $("#step_cl_first").addClass("completed step");
                    $("#step_cl_first").addClass("disabled step");
                    $("#step_cl_second").removeClass("disabled step");
                    $("#step_cl_second").addClass("active step");

                    //update state
                    myNameSpace.set("po_modal_state", 2);
                    console.log("new state: " + myNameSpace.get("po_modal_state"));
                    $("#po_modal_import").hide();
                    $("#pomodal_details_ponumber2").text($("#pomodal_details_ponumber").text())
                    openSavedModalCLInfo();

                    //button states
                    $("#po_modal_update").show();
                    $("#po_modal_save").hide();
                    $("#po_modal_next").show();
                    $('#po_modal_close').hide();
                    $('#lblfileUpload2').show();
                    $("#fileUpload2").show();
                    $('#btnErrorSpareListView').show();
                    $("#btnEditImport").show();

                }
                else if (myNameSpace.get("po_modal_state") == 2)   //second step in modal
                {
                    //content divs
                    $('.modal_cl_divstep2').addClass('hidden');
                    $('.modal_cl_divstep3').removeClass('hidden');

                    //header steps
                    $("#step_cl_second").removeClass("active step");
                    $("#step_cl_second").addClass("completed step");
                    $("#step_cl_second").addClass("disabled step")
                    $("#step_cl_third").removeClass("disabled step");
                    $("#step_cl_third").addClass("active step");

                    //buttons                  
                    $("#po_modal_previous").show();
                    $("#po_modal_save").show();
                    $("#po_modal_next").hide();
                    $("#po_modal_cancel").hide();
                    $('#po_modal_close').hide();

                    if ($('#<%=txtTireRefNo.ClientID%>').val().length > 0 && $('#<%=txtNewCustNo.ClientID%>').val().length > 0 && $('#<%=txtTirePackageValue.ClientID%>').val().length > 0) {

                            AddTirePackage();
                            //setTab('TirePackageList');
                        }
                    //update state
                        myNameSpace.set("po_modal_state", 3);
                        console.log("new state: " + myNameSpace.get("po_modal_state"));
                    }

                    else if (myNameSpace.get("po_modal_state") == 3)   //third step in modal and we click next, this is what we want to happen:
                    {
                        //loader and checkmark
                        //$('.circle-loader').addClass('hidden');
                       //$('toggle').addClass('hidden')
                    //alert("Her skal man kunne avslutte");

                        //content divs
                        //$('.modal_cl_divstep3').addClass('hidden');
                        //$('.modal_po_divstep4').removeClass('hidden');

                        //header steps
                        //$("#step_cl_third").removeClass("active step");
                        //$("#step_cl_third").addClass("disabled step")
                        //$("#step_po_fourth").removeClass("disabled step");
                        //$("#step_po_fourth").addClass("active step");

                        //buttons

                        //$("#po_modal_previous").show();
                        //$('#po_modal_close').hide();

                        //$("#po_modal_update").hide();
                        //$('.circle-loader').toggleClass('load-complete');
                        //$('.checkmarkX').toggle();
                        //$('.circle-loader').addClass('hidden');
                        //$('.toggle').addClass('hidden');

                        //var ponumber = $('#redRibbonPOmodal').text();

                        //var supp_currentno = $('#pomodal_details_supplier4').text();

                        //if (myNameSpace.get("po_delivered") == "True") {
                        //    $("#po_modal_previous").hide();
                        //    //  $('.circle-loader').toggleClass('circle-loader');
                        //}
                        //else { $("#po_modal_previous").show(); }
                        //$("#item-table-modal-final").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", "{'POnum': '" + ponumber + "', 'isDeliveryTable': '" + false + "', 'supp_currentno': '" + supp_currentno + "'}", ajaxConfig);
                    myNameSpace.set("po_modal_state", 4);
                    myNameSpace.set("po_modal_state_canclose", 1);
                        

                    }

                    else   //should never enter here. added this in case someone added the wrong value for the modal state.
                    {
                        alert("her skulle vi definitivt ikke havne!");
                    }



            });

            $('#po_modal_update').on('click', function (e) {

                if (myNameSpace.get("po_modal_state") == 2)   //second step in modal
                {

                    var rows = $("#counting-table-edit-modal").tabulator("getRows");
                    for (i = 0; i < rows.length; i++) {
                        var success = updateItemToCL(rows[i]);
                        if (!success) {
                            alert("Noe gikk galt med lagring av varer på telleliste");
                        }

                    }
                    //if ($('#modal_po_confirmorder').modal('show'))    //  fix this!
                    $('.modal_cl_divstep2').addClass('hidden');
                    $('.modal_cl_divstep3').removeClass('hidden');

                    $('#item-table-modal-confirmedOrder').removeClass('hidden');

                    //header steps
                    $("#step_cl_second").removeClass("active step");
                    $("#step_cl_second").addClass("completed step");
                    $("#step_cl_second").addClass("disabled step")
                    $("#step_cl_third").removeClass("disabled step");
                    $("#step_cl_third").addClass("active step");

                    //buttons                  
                    $("#po_modal_previous").show();
                    $('#po_modal_update').hide();
                    $('#po_modal_next').hide();
                    $('#po_modal_close').show();
                    $('#pomodal_details_ponumber3').text($('#pomodal_details_ponumber2').text());
                    $('#btnEditPrint').hide();
                    $('#lblfileUpload2').hide();
                    $("#fileUpload2").hide();
                    $('#btnErrorSpareListView').hide();
                    $("#btnEditImport").hide();


                    //update state
                    myNameSpace.set("po_modal_state", 3);


                }

                else if (myNameSpace.get("po_modal_state") == 3)   //third step in modal and we click next, this is what we want to happen:
                {
                    //loader and checkmark
                    $('.circle-loader').addClass('hidden');
                    $('toggle').addClass('hidden')


                    //content divs
                    $('.modal_cl_divstep3').addClass('hidden');
                    $('.modal_po_divstep4').removeClass('hidden');

                    //header steps
                    $("#step_cl_third").removeClass("active step");
                    $("#step_cl_third").addClass("disabled step")
                    $("#step_po_fourth").removeClass("disabled step");
                    $("#step_po_fourth").addClass("active step");

                    //buttons
                    $("#po_modal_previous").show();
                    $('#po_modal_close').hide();
                    $('#lblfileUpload2').hide();
                    $("#fileUpload2").hide();
                    $('#btnErrorSpareListView').hide();
                    $("#btnEditImport").hide();

                    $("#po_modal_update").hide();
                    $('.circle-loader').toggleClass('load-complete');
                    $('.checkmarkX').toggle();
                    $('.circle-loader').addClass('hidden');
                    $('.toggle').addClass('hidden');


                    myNameSpace.set("po_modal_state_canclose", 0);
                    myNameSpace.set("po_modal_state", 4);

                }

                else   //should never enter here. added this in case someone added the wrong value for the modal state.
                {
                    alert("her skulle vi definitivt ikke havne!");
                }



            });

            $('#po_modal_next').on('click', function (e) {
                if (myNameSpace.get("po_modal_state") == 1)     //second step in modal
                {
                    initSecondModalStepView();
                }

                else if (myNameSpace.get("po_modal_state") == 2)     //second step in modal
                {
                    //content divs
                    $('.modal_cl_divstep2').addClass('hidden');
                    $('.modal_cl_divstep3').removeClass('hidden');

                    //header steps
                    $("#step_cl_second").removeClass("active step");
                    $("#step_cl_second").addClass("completed step");
                    $("#step_cl_second").addClass("disabled step")
                    $("#step_cl_third").removeClass("disabled step");
                    $("#step_cl_third").addClass("active step");

                    //buttons                  
                    $("#po_modal_previous").show();
                    $("#po_modal_save").show();
                    $("#po_modal_next").hide();
                    $("#po_modal_cancel").hide();
                    $('#btnTPPrint').show();

                    if ($('#<%=txtTireRefNo.ClientID%>').val().length > 0 && $('#<%=txtNewCustNo.ClientID%>').val().length > 0 && $('#<%=txtTirePackageValue.ClientID%>').val().length > 0) {

                            AddTirePackage();
                            //alert(updated);
                            if (updated == "1") {
                                //alert("inside the if updated");
                                AddTireDepth();
                            }

                            //setTab('TirePackageList');
                        }
                        else {
                            alert("Husk å legge inn kjøretøy, kunde og pakkedata før du går videre!");
                        }
                    //update statehyperLink1hyperLink1
                        myNameSpace.set("po_modal_state", 3);
                        console.log("new state: " + myNameSpace.get("po_modal_state"));
                    }
                //$('.modal_cl_divstep1').addClass('hidden');
                //$('.modal_cl_divstep2').removeClass('hidden');

                ////header steps
                //$("#step_cl_first").removeClass("active step");
                //$("#step_cl_first").addClass("completed step");
                //$("#step_cl_first").addClass("disabled step");
                //$("#step_cl_second").removeClass("disabled step");
                //$("#step_cl_second").addClass("active step");

                ////update state
                //myNameSpace.set("po_modal_state", 2);
                //console.log("new state: " + myNameSpace.get("po_modal_state"));
                //$("#po_modal_import").hide();



                ////button states
                //$("#po_modal_update").hide();
                //$("#po_modal_save").show();
                //$("#po_modal_next").hide();
                //$('#po_modal_close').hide();
                //$('#lblfileUpload2').hide();
                //$("#fileUpload2").hide();
                //$('#btnErrorSpareListView').hide();
                //$("#btnEditImport").hide();
                //$("#po_modal_previous").show();


                ////update state
                //myNameSpace.set("po_modal_state", 2);



            });

            $('#po_modal_previous').on('click', function (e) {
                if (myNameSpace.get("po_modal_state") == 2)     //second step in modal
                {

                    //content divs
                    $('.modal_cl_divstep2').addClass('hidden');
                    $('.modal_cl_divstep1').removeClass('hidden');

                    //header steps

                    $("#step_cl_first").removeClass("disabled step");
                    $("#step_cl_first").removeClass("completed step");
                    $("#step_cl_first").addClass("active step");
                    $("#step_cl_second").addClass("disabled step");

                    //buttons
                    $("#po_modal_previous").hide();
                    $("#po_modal_save").hide();
                    $("#po_modal_next").show();
                    $('#btnTPPrint').hide();


                    myNameSpace.set("po_modal_state", 1);
                    console.log("new state: " + myNameSpace.get("po_modal_state"));
                }

                if (myNameSpace.get("po_modal_state") == 3)     //second step in modal
                {

                    //content divs
                    $('.modal_po_divstep3').addClass('hidden');
                    $('.modal_cl_divstep2').removeClass('hidden');

                    //header steps
                    $("#step_cl_second").removeClass("disabled step");
                    $("#step_cl_second").removeClass("completed step");
                    $("#step_cl_second").addClass("active step");

                    //buttons

                    $("#po_modal_cancel").hide();
                    $("#po_modal_next").hide();
                    $("#po_modal_update").hide();
                    $('#lblfileUpload2').hide();
                    $("#fileUpload2").hide();
                    $('#btnErrorSpareListView').hide();
                    $("#btnEditImport").hide();
                    $('#btnTPPrint').hide();

                    myNameSpace.set("po_modal_state", 2);
                    initSecondModalStepView();
                }
            });

            $('#tpSelectionSendSms').on('click', function (e) {

                if (myNameSpace.get("sel_modal_state") == 2) {
                    //myNameSpace.set("po_modal_state", 1);
                    if ($("#rbSendSMS").prop('checked')) {
                        if ($("#<%=txtSMSText.ClientID%>").val() != "") {
                            var msg = "Manuell SMS";
                            smstext = $("#<%=txtSMSText.ClientID%>").val();
                            fetchSMSConfig(msg)


                        }
                        else {
                            swal("Du må skrive en tekst og legge til mobilnr før du kan sende sms eller mail.");
                        }
                    }
                    else {
                        swal("Du forsøker nå å sende epost. Sjekk at felter er utfyult rett.");
                    }
                    initThirdStep();
                }
            });

            $('#po_modal_close').on('click', function (e) {
                if (confirm('Er du sikker på at du ønsker å avslutte tellelisten og oppdatere til beholdning?')) {
                    //alert('du har bekrefta at tellelista skal sperres.');
                    //content divs
                    var rows = $("#counting-table-edit-modal").tabulator("getRows");
                    for (i = 0; i < rows.length; i++) {
                        var success = closeItemToCL(rows[i]);
                        if (!success) {
                            alert("Noe gikk galt med sperring av varer på telleliste");
                        }

                    }
                    var rows = $("#TirePackage-table").tabulator("getRows");
                    var countingNo = $('#pomodal_details_ponumber3').text();
                    var array = countingNo.split(' ');
                    var clprefix = array[0];
                    var clno = array[1];
                    for (i = 0; i < rows.length; i++) {
                        if (rows[i].getData().COUNTING_NO == clno && rows[i].getData().COUNTING_PREFIX == clprefix) {
                            alert('inni sletterutine');
                            rows[i].delete();
                            break;
                        }

                    }
                }

                $('#modal_cl_steps').modal('hide');


            });



            function deleteTirePackage(row) {

                //var itemobj = deleteCLItemJSONstring(row);

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "TireHotel.aspx/Delete_TP_Item",
                    data: "{item:'" + row + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        systemMSG('success', 'Dekkpakke er slettet!', 5000);

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Dekkpakke feilet ved sletting', 5000);
                    }
                });
                return succeeded
                
            }

            function getLoginName() {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "TireHotel.aspx/getLoginName",
                    data: "{}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {

                        console.log("success");
                        _loginName = data.d;
                        succeeded = true;


                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Finner ikke bruker. Logg ut og så prøv på nytt!', 5000);
                    }
                });


            }

            function deleteCLItemJSONstring(row) {

                var countingListItem = {};
                countingListItem["COUNTING_PREFIX"] = row.getData().COUNTING_PREFIX;
                countingListItem["COUNTING_NO"] = row.getData().COUNTING_NO;
                countingListItem["CLOSED"] = row.getData().CLOSED;

                var jsonCL = JSON.stringify(countingListItem);
                console.log(jsonCL);


                return jsonCL;
            }

            function loadTireMake() {
                $.ajax({
                    type: "POST",
                    url: "frmVehicleDetail.aspx/LoadMakeCode",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpTireMake.ClientID%>').empty();
                        $('#<%=drpTireMake.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $('#<%=drpSelTireBrands.ClientID%>').empty();
                        $('#<%=drpSelTireBrands.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpTireMake.ClientID%>').append($("<option></option>").val(value.Id_Make_Veh).html(value.MakeName));
                            $('#<%=drpSelTireBrands.ClientID%>').append($("<option></option>").val(value.Id_Make_Veh).html(value.MakeName));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            function loadTireType() {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/LoadTireType",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpTireType.ClientID%>').empty();
                        $('#<%=drpTireType.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $('#<%=drpSearchTireType.ClientID%>').empty();
                        $('#<%=drpSearchTireType.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $('#<%=drpSelTireType.ClientID%>').empty();
                        $('#<%=drpSelTireType.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpTireType.ClientID%>').append($("<option></option>").val(value.tireTypeVal).html(value.tireTypeDesc));
                            $('#<%=drpSearchTireType.ClientID%>').append($("<option></option>").val(value.tireTypeVal).html(value.tireTypeDesc));
                            $('#<%=drpSelTireType.ClientID%>').append($("<option></option>").val(value.tireTypeVal).html(value.tireTypeDesc));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }
            function getTireType(val) {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/getTireType",
                    data: "{value:'" + val + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {

                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=txtTirePackageValue.ClientID%>').val(value.tirePackageVal);
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            function loadTireSpike() {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/LoadTireSpike",
                    data: "{deptID:'" + departmentID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpTireSpike.ClientID%>').empty();
                        $('#<%=drpTireSpike.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $('#<%=drpSelSpikes.ClientID%>').empty();
                        $('#<%=drpSelSpikes.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpTireSpike.ClientID%>').append($("<option></option>").val(value.tireSpikesVal).html(value.tireSpikesDesc));
                            $('#<%=drpSelSpikes.ClientID%>').append($("<option></option>").val(value.tireSpikesVal).html(value.tireSpikesDesc));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            function loadRimType() {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/LoadTireRimType",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpRimType.ClientID%>').empty();
                        $('#<%=drpRimType.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $('#<%=drpSelRimType.ClientID%>').empty();
                        $('#<%=drpSelRimType.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpRimType.ClientID%>').append($("<option></option>").val(value.tireRimVal).html(value.tireRimDesc));
                            $('#<%=drpSelRimType.ClientID%>').append($("<option></option>").val(value.tireRimVal).html(value.tireRimDesc));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            function loadTireQuality() {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/LoadTireQuality",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpTireQuality.ClientID%>').empty();
                        $('#<%=drpTireQuality.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $('#<%=drpSearchTireQuality.ClientID%>').empty();
                        $('#<%=drpSearchTireQuality.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        $('#<%=drpSelTireQuality.ClientID%>').empty();
                        $('#<%=drpSelTireQuality.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpTireQuality.ClientID%>').append($("<option></option>").val(value.tireQualityVal).html(value.tireQualityDesc));
                            $('#<%=drpSearchTireQuality.ClientID%>').append($("<option></option>").val(value.tireQualityVal).html(value.tireQualityDesc));
                            $('#<%=drpSelTireQuality.ClientID%>').append($("<option></option>").val(value.tireQualityVal).html(value.tireQualityDesc));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }
            function loadTireDepth() {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/LoadTireDepth",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpAxleNo.ClientID%>').empty();
                        $('#<%=drpAxleNo.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpAxleNo.ClientID%>').append($("<option></option>").val(value.tireDepthVal).html(value.tireDepthDesc));

                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function loadTireBrand() {

                        $('#<%=drpSelTireBrands.ClientID%>').empty();
                        $('#<%=drpSelTireBrands.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                     
            }

            $('#<%=drpTireType.ClientID%>').change(function () {
                getTireType($('#<%=drpTireType.ClientID%>').val());
                if ($('#<%=drpTireType.ClientID%>').val() == "11") {
                    $('#<%=drpTireSpike.ClientID%>').prop('disabled', true);
                }
                else {
                    $('#<%=drpTireSpike.ClientID%>').prop('disabled', false);
                }

            });
            $('#<%=drpSelTireType.ClientID%>').change(function () {
               
                if ($('#<%=drpSelTireType.ClientID%>').val() == "11") {
                    $('#<%=drpSelSpikes.ClientID%>').prop('disabled', true);
                }
                else {
                    $('#<%=drpSelSpikes.ClientID%>').prop('disabled', false);
                }

            });

            $('#<%=drpRimType.ClientID%>').change(function () {
                if ($('#<%=drpRimType.ClientID%>').val() == "17") {
                    $('#<%=chkCapsDelivered.ClientID%>').prop('disabled', true);
               }
               else {
                   $('#<%=chkCapsDelivered.ClientID%>').prop('disabled', false);
               }

            });

            $('#<%=txtTPVehicleSearch.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TireHotel.aspx/FindVehicleList",
                        data: "{'search': '" + $('#<%=txtTPVehicleSearch.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Finner ikke kjøretøyet du leter etter... Vil du opprette?', value: '0', val: 'new' }]);
                            }
                            else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.refNo + " - " + item.regNo + " - " + item.make,
                                        val: item.refNo,
                                        value: item.refNo


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
                         //alert(i.item.val);
                         FetchVehicleDetails(i.item.val, "");

                         //loadCategory();
                     }
                     else {
                         //alert(i.item.clprefix);
                         moreInfo('../Master/frmVehicleDetail.aspx?vehId=' + $('#<%=txtTPVehicleSearch.ClientID%>').val() + '&veh=new&pageName=TireHotel', 'Kjøretøydetaljer');
                         //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?

                     }


                 }

             });

            function FetchVehicleDetails(refNo, custNo) {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/FetchVehicleDetails",
                    data: "{refNo: '" + refNo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //alert("stock after count is: " + data.d[0].vehicle_group);
                        console.log(data.d);
                        $('#<%=txtTireRefNo.ClientID%>').val(data.d[0].refNo);
                        $('#<%=txtTireRegNo.ClientID%>').val(data.d[0].regNo);
                        $('#<%=txtCreateMake.ClientID%>').val(data.d[0].make);
                        $('#<%=txtCreateModel.ClientID%>').val(data.d[0].model);
                        $('#<%=txtCreateOrgTireDimFront.ClientID%>').val(data.d[0].tireDimFront);
                        $('#<%=txtCreateOrgTireDimBack.ClientID%>').val(data.d[0].tireDimBack);
                        if ($('#<%=txtTireDimFront.ClientID%>').val() == "") {
                             $('#<%=txtTireDimFront.ClientID%>').val(data.d[0].tireDimFront);
                        }
                        if ($('#<%=txtTireDimBack.ClientID%>').val() == "") {
                            $('#<%=txtTireDimBack.ClientID%>').val(data.d[0].tireDimBack);
                        }
                        if (data.d[0].vehicle_group == "101") {
                            $('#<%=drpAxleNo.ClientID%>').val(1)
                            $('#<%=ddlTireQuantity.ClientID%>').val(4)
                        }
                        $('#<%=txtTirePackageNo.ClientID%>').val(data.d[0].refNo.slice(2));
                        if (custNo == "") {
                            if (data.d[0].id_customer != "") {
                                FetchCustomerDetails(data.d[0].id_customer);
                            }
                            else {
                                //alert(data.d[0].id_customer);
                            }
                            
                        }
                        else {
                            FetchCustomerDetails(custNo);
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });

            };

            $('#<%=txtTPCustomerSearch.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TireHotel.aspx/FindCustomerList",
                        data: "{'search': '" + $('#<%=txtTPCustomerSearch.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Finner ikke kunden du leter etter. Trykk enter for å opprette ny..', value: '0', val: 'new' }]);


                            }
                            else
                                response($.map(data.d, function (item) {

                                    return {

                                        label: item.id_customer + " - " + item.custfName + " " + item.custmName + " " + item.custlName + " - " + item.cust_add1 + " - " + item.cust_place + " - " + item.custmobile,
                                        val: item.id_customer,
                                        value: item.id_customer





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
                        //alert(i.item.val);
                        FetchCustomerDetails(i.item.val);
                        loadListCustVehicle(i.item.val);
                        $('.overlayHide').addClass('ohActive');
                        $('#modListCustVehicles').removeClass('hidden');

                        //loadCategory();
                    }
                    else {
                        //alert("Noe gikk galt ved henting!");
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                        moreInfo('../Master/frmCustomerDetail.aspx?cust=' + $('#<%=txtTPCustomerSearch.ClientID%>').val() + 'w&pageName=TireHotel', 'Kundedetaljer');
                    }


                }

            });

            $('#<%=btnFetchVehicle.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modListCustVehicles').addClass('hidden');
                //alert($('#<%=drpListCustVehicle.ClientID%>').val());
                if ($('#<%=drpListCustVehicle.ClientID%>').val() != null) {
                    FetchVehicleDetails( $('#<%=drpListCustVehicle.ClientID%>').val(), "")
                }
                
            });
            $('#<%=btnFetchVehicleCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modListCustVehicles').addClass('hidden');
            });

           <%-- function FetchCustomerDetails(custNo) {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/FetchCustomerDetails",
                    data: "{custNo: '" + custNo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //alert("stock after count is: " + data.d[0].vehicle_group);
                        console.log(data.d);
                        if (data.d[0].flg_private_comp == 'True') {
                            $('#private').addClass('hidden');
                            $('#company').removeClass('hidden');
                            $("#<%=chkCompany.ClientID%>").prop('checked', true);
                            $('#<%=txtNewCompanyName.ClientID%>').val(data.d[0].custlName);

                        }
                        else {
                            $('#private').removeClass('hidden');
                            $('#company').addClass('hidden');
                            $("#<%=chkCompany.ClientID%>").prop('checked', false);
                            $('#<%=txtNewCompanyName.ClientID%>').val("");
                            $('#<%=txtNewFirstName.ClientID%>').val(data.d[0].custfName);
                            $('#<%=txtNewMiddleName.ClientID%>').val(data.d[0].custmName);
                            $('#<%=txtNewLastName.ClientID%>').val(data.d[0].custlName);
                        }
                        $('#<%=txtNewCustNo.ClientID%>').val(data.d[0].id_customer);
                        $('#<%=txtNewAddress.ClientID%>').val(data.d[0].cust_add1);
                        $('#<%=txtNewZipCode.ClientID%>').val(data.d[0].cust_zipcode);
                        $('#<%=txtNewPlace.ClientID%>').val(data.d[0].cust_place);
                        $('#<%=txtNewMobile.ClientID%>').val(data.d[0].custmobile);
                        $('#<%=txtNewMail.ClientID%>').val(data.d[0].custmail);

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });

            };--%>

            function FetchTirePackageDetails(packageNo) {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/FetchTirePackageDetails",
                    data: "{packageNo: '" + packageNo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //alert("stock after count is: " + data.d[0].vehicle_group);
                        console.log(data.d);
                        if (data.d[0].tireBolts == 'True') {
                            $("#<%=chkBoltsDelivered.ClientID%>").prop('checked', true);
                        }
                        else {
                            $("#<%=chkBoltsDelivered.ClientID%>").prop('checked', false);
                        }
                        if (data.d[0].tireCap == 'True') {
                            $("#<%=chkCapsDelivered.ClientID%>").prop('checked', true);
                        }
                        else {
                            $("#<%=chkCapsDelivered.ClientID%>").prop('checked', false);
                        }
                        var TP = data.d[0].tirePackageNo;
                        var array;
                        array = TP.split(" ");
                        var packNo = array[0];
                        var packVal = array[1];
                        $('#<%=txtTirePackageNo.ClientID%>').val(packNo);
                        $('#<%=txtTirePackageValue.ClientID%>').val(packVal);
                        $('#<%=txtTireLocation.ClientID%>').val(data.d[0].location);
                        $('#<%=ddlTireQuantity.ClientID%>').val(data.d[0].qtyTire);
                        $('#<%=drpTireMake.ClientID%>').val(data.d[0].tireBrandVal);
                        $('#<%=drpTireType.ClientID%>').val(data.d[0].tireTypeVal);
                        $('#<%=drpTireSpike.ClientID%>').val(data.d[0].tireSpikesVal);
                        $('#<%=drpTireQuality.ClientID%>').val(data.d[0].tireQualityVal);
                        $('#<%=drpRimType.ClientID%>').val(data.d[0].tireRimVal);
                        $('#<%=drpAxleNo.ClientID%>').val(data.d[0].tireAxleNoVal);
                        $('#<%=txtExpectedOuteDate.ClientID%>').val(data.d[0].outDate);
                        $('#<%=txtAnnotation.ClientID%>').val(data.d[0].tireAnnot);
                        $('#<%=txtTireDimFront.ClientID%>').val(data.d[0].tireDimFront);
                        $('#<%=txtTireDimBack.ClientID%>').val(data.d[0].tireDimBack);
                        $('#<%=hdnSequenceNumber.ClientID%>').val(data.d[0].tireSeqNumber);
                        FetchVehicleDetails(data.d[0].refNo, data.d[0].custNo);
                        //FetchCustomerDetails(data.d[0].custNo);

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });

            };


            $('#<%=btnNewVehicle.ClientID%>').click(function () {
                if ($('#<%=txtTireRefNo.ClientID%>').val().length > 0) {
                    var intNo = $('#<%=txtTireRefNo.ClientID%>').val();
                    //window.open("../Master/frmVehicleDetail.aspx?refno=" + vehId, "info6", "resizable=no,scrollbars=1,status=yes,width=1000px,height=700px,menubar=0,toolbar=0");
                    //window.showModalDialog("../Master/frmVehicleDetail.aspx?refno=" + vehId, window.self, "dialogHeight:700px;dialogWidth:1000px;resizable:no;center:yes;scroll:yes;");
                    moreInfo('../Master/frmVehicleDetail.aspx?refno=' + intNo + '&pageName=TireHotel', 'KjÃ¸retÃ¸ydetaljer');
                }
                else {
                    moreInfo('../Master/frmVehicleDetail.aspx?pageName=TireHotel', 'Kjøretøydetaljer');
                }
            });


            $('#<%=btnNewCustomer.ClientID%>').click(function () {
                if ($('#<%=txtTPCustomerSearch.ClientID%>').val().length > 0) {
                    var custId = $('#<%=txtTPCustomerSearch.ClientID%>').val();
                   //window.open("../Master/frmCustomerDetail.aspx?cust=" + custId, "info6", "resizable=no,scrollbars=1,status=yes,width=1000px,height=700px,menubar=0,toolbar=0");
                   // window.showModalDialog("../Master/frmCustomerDetail.aspx?cust=" + custId, window.self, "dialogHeight:700px;dialogWidth:1000px;resizable:no;center:yes;scroll:yes;");
                   moreInfo('../Master/frmCustomerDetail.aspx?cust=' + custId + '&pageName=TireHotel', 'Kundedetaljer');
               }
               else {
                   moreInfo('../Master/frmCustomerDetail.aspx?pageName=TireHotel', 'Kundedetaljer');
               }
            });

            function moreInfo(page, title) {
                //var page = '../Master/frmCustomerDetail.aspx';

                var $dialog = $('<div id="testdialog"></div>')
                               .html('<iframe id="testifr" style="border: 0px;" src="' + page + '" width="1000px" height="800px"></iframe>')
                               .dialog({
                                   autoOpen: false,
                                   modal: true,
                                   height: 800,
                                   width: '80%',
                                   title: title
                               });
                $dialog.dialog('open');
            }



            function AddTirePackage() {


                var itemobj = createTPJSONstring();

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "TireHotel.aspx/Add_TP_Item",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        if (data.d == "0") {
                            systemMSG('success', 'Dekkpakke opprettet!', 5000);
                            updated = 1;

                        }
                        else if (data.d == "1") {
                            systemMSG('success', 'Dekkpakke med data har blitt oppdatert!', 5000);
                            updated = 1;
                        }
                        var packageNo = $('#<%=txtTirePackageNo.ClientID%>').val() + " " + $('#<%=txtTirePackageValue.ClientID%>').val();
                        FetchTirePackageDetails(packageNo);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Dekkpakke feilet. Se over dataene og korriger der det er feil eller kontakt system administrator.', 5000);
                        updated = 0;
                    }
                });
                return succeeded

            }

            function createTPJSONstring() {

                var TPItem = {};
                TPItem["refNo"] = $('#<%=txtTireRefNo.ClientID%>').val();
                TPItem["regNo"] = $('#<%=txtTireRegNo.ClientID%>').val();
                TPItem["custNo"] = $('#<%=txtNewCustNo.ClientID%>').val();
                 if ($("#<%=chkCompany.ClientID%>").is(':checked')) {
                     TPItem["custName"] = $('#<%=txtNewCompanyName.ClientID%>').val();
                     TPItem["custmName"] = "";
                      TPItem["custlName"] = $('#<%=txtNewCompanyName.ClientID%>').val();
                  }

                  else {
                       TPItem["custName"] = $('#<%=txtNewFirstName.ClientID%>').val();
                       TPItem["custmName"] = $('#<%=txtNewMiddleName.ClientID%>').val();
                       TPItem["custlName"] = $('#<%=txtNewLastName.ClientID%>').val();
                  }
                  TPItem["custName"] = $('#<%=txtNewFirstName.ClientID%>').val();
                  TPItem["tirePackageNo"] = $('#<%=txtTirePackageNo.ClientID%>').val() + " " + $('#<%=txtTirePackageValue.ClientID%>').val();
                  TPItem["qtyTire"] = $('#<%=ddlTireQuantity.ClientID%>').val();
                  TPItem["tireDimFront"] = $('#<%=txtTireDimFront.ClientID%>').val();
                  TPItem["tireDimBack"] = $('#<%=txtTireDimBack.ClientID%>').val();
                  TPItem["location"] = $('#<%=txtTireLocation.ClientID%>').val();
                  TPItem["tireTypeVal"] = $('#<%=drpTireType.ClientID%>').val();
                  TPItem["tireTypeDesc"] = $('#<%=drpTireType.ClientID%> option:selected').text();
                  TPItem["tireSpikesVal"] = $('#<%=drpTireSpike.ClientID%>').val();
                  TPItem["tireSpikesDesc"] = $('#<%=drpTireSpike.ClientID%> option:selected').text();
                  TPItem["tireRimVal"] = $('#<%=drpRimType.ClientID%>').val();
                  TPItem["tireRimDesc"] = $('#<%=drpRimType.ClientID%> option:selected').text();
                  TPItem["tireBrandVal"] = $('#<%=drpTireMake.ClientID%>').val();
                  TPItem["tireBrandDesc"] = $('#<%=drpTireMake.ClientID%> option:selected').text();
                  TPItem["tireQualityVal"] = $('#<%=drpTireQuality.ClientID%>').val();
                  TPItem["tireQualityDesc"] = $('#<%=drpTireQuality.ClientID%> option:selected').text();
                  TPItem["tireAxleNoVal"] = $('#<%=drpAxleNo.ClientID%>').val();
                  TPItem["tireAxleNoDesc"] = $('#<%=drpAxleNo.ClientID%> option:selected').text();
                  if ($("#<%=txtExpectedOuteDate.ClientID%>").val() != '') {
                      <%--var moddateFrom = $("#<%=txtExpectedOuteDate.ClientID%>").val();
                      var datetimeFrom = moddateFrom.split(".");
                      var timeVal = datetimeFrom[2].split(" ");
                      if (timeVal[1] == '') {
                          outDate = datetimeFrom[2] + "-" + datetimeFrom[1] + "-" + datetimeFrom[0] + " 00:00:00.000";
                      }
                      else {
                          outDate = timeVal[0] + "-" + datetimeFrom[1] + "-" + datetimeFrom[0] + " 00:00:00.000";
                      }--%>
                      outDate = $("#<%=txtExpectedOuteDate.ClientID%>").val();
                  }
                  else {
                      outDate = '';
                  }
                  TPItem["outDate"] = outDate;
                  if ($("#<%=chkBoltsDelivered.ClientID%>").is(':checked')) {
                      TPItem["tireBolts"] = 1;
                  }

                  else {
                      TPItem["tireBolts"] = 0;
                  }
                  if ($("#<%=chkCapsDelivered.ClientID%>").is(':checked')) {
                      TPItem["tireCap"] = 1;
                  }
                  else {
                      TPItem["tireCap"] = 0;
                  }
                  TPItem["tireAnnot"] = $('#<%=txtAnnotation.ClientID%>').val();
                
                  TPItem["tirePackageVal"] = $('#<%=txtTirePackageValue.ClientID%>').val();
                TPItem["tireSeqNumber"] = $('#<%=hdnSequenceNumber.ClientID%>').val();
                  var jsonTP = JSON.stringify(TPItem);
                  console.log(jsonTP);


                  return jsonTP;
              }

            function AddTireDepth() {

                var ret = 0;
                var itemobj = createTireDepthJSONstring();
                for (i = 0; i < itemobj.length; i++) {
                    //console.log(itemobj);
                    if (itemobj[i] != "") {
                        ret = 1;
                        //alert(ret);
                        break;
                    }
                }
                if (ret == 1) {
                    var succeeded = false;
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TireHotel.aspx/AddTireDepth",
                        data: "{item:'" + itemobj + "'}",
                        dataType: "json",
                        async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                        success: function (data) {
                            console.log("success");
                            succeeded = true;
                            if (data.d == "0") {
                                systemMSG('success', 'Dekkdybde på dekkpakken har blitt lagret!', 5000);
                            }
                            else if (data.d == "1") {
                                systemMSG('success', 'Dekkdybde på dekkpakken har blitt oppdatert!', 5000);
                            }
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                            systemMSG('error', 'Dekkdybde lagring feilet. Kontakt system administrator.', 5000);
                        }
                    });
                    return succeeded
                }
                else {
                    alert("ingen dekkmønter er satt inn!");
                }
            }

            function createTireDepthJSONstring() {
                var TPDepth = {};
                TPDepth["tirePackageNo"] = $('#<%=txtTirePackageNo.ClientID%>').val() + " " + $('#<%=txtTirePackageValue.ClientID%>').val();
                TPDepth["refNo"] = $('#<%=txtTireRefNo.ClientID%>').val()
                TPDepth["regNo"] = $('#<%=txtTireRegNo.ClientID%>').val()
                TPDepth["tireAxleNoVal"] = $('#<%=drpAxleNo.ClientID%>').val()

                if ($('#<%=drpAxleNo.ClientID%>').val() == 1) {

                    TPDepth["tireDepth1L"] = $('#<%=txtTireDepth1L.ClientID%>').val();
                    TPDepth["tireDepth2L"] = $('#<%=txtTireDepth2L.ClientID%>').val();
                    TPDepth["tireDepth1R"] = $('#<%=txtTireDepth1R.ClientID%>').val();
                    TPDepth["tireDepth2R"] = $('#<%=txtTireDepth2R.ClientID%>').val();
                }
                else {
                    TPDepth["tireDepth1L"] = $('#<%=txtTruckDepth1L.ClientID%>').val();
                    TPDepth["tireDepth2L"] = $('#<%=txtTruckDepth2L.ClientID%>').val();
                    TPDepth["tireDepth2L2"] = $('#<%=txtTruckDepth2L2.ClientID%>').val();
                    TPDepth["tireDepth3L"] = $('#<%=txtTruckDepth3L.ClientID%>').val();
                    TPDepth["tireDepth3L2"] = $('#<%=txtTruckDepth3L2.ClientID%>').val();
                    TPDepth["tireDepth4L"] = $('#<%=txtTruckDepth4L.ClientID%>').val();
                    TPDepth["tireDepth4L2"] = $('#<%=txtTruckDepth4L2.ClientID%>').val();
                    TPDepth["tireDepth5L"] = $('#<%=txtTruckDepth5L.ClientID%>').val();
                    TPDepth["tireDepth5L2"] = $('#<%=txtTruckDepth5L2.ClientID%>').val();
                    TPDepth["tireDepth6L"] = $('#<%=txtTruckDepth6L.ClientID%>').val();
                    TPDepth["tireDepth6L2"] = $('#<%=txtTruckDepth6L2.ClientID%>').val();
                    TPDepth["tireDepth1R"] = $('#<%=txtTruckDepth1R.ClientID%>').val();
                    TPDepth["tireDepth2R"] = $('#<%=txtTruckDepth2R.ClientID%>').val();
                    TPDepth["tireDepth2R2"] = $('#<%=txtTruckDepth2R2.ClientID%>').val();
                    TPDepth["tireDepth3R"] = $('#<%=txtTruckDepth3R.ClientID%>').val();
                    TPDepth["tireDepth3R2"] = $('#<%=txtTruckDepth3R2.ClientID%>').val();
                    TPDepth["tireDepth4R"] = $('#<%=txtTruckDepth4R.ClientID%>').val();
                    TPDepth["tireDepth4R2"] = $('#<%=txtTruckDepth4R2.ClientID%>').val();
                    TPDepth["tireDepth5R"] = $('#<%=txtTruckDepth5R.ClientID%>').val();
                    TPDepth["tireDepth5R2"] = $('#<%=txtTruckDepth5R2.ClientID%>').val();
                    TPDepth["tireDepth6R"] = $('#<%=txtTruckDepth6R.ClientID%>').val();
                    TPDepth["tireDepth6R2"] = $('#<%=txtTruckDepth6R2.ClientID%>').val();

                }


                var jsonTPD = JSON.stringify(TPDepth);
                console.log(jsonTPD);


                return jsonTPD;
            }

            function FetchTirePackageDepth(packageNo) {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/FetchTirePackageDepth",
                    data: "{packageNo: '" + packageNo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //alert("stock after count is: " + data.d[0].vehicle_group);
                        console.log(data.d);
                        if (data.d.length > 0) {
                            if (data.d[0].tireAxleNoVal == 1) {
                                $("#<%=txtTireDepth1L.ClientID%>").val(data.d[0].tireDepth1L);
                            $("#<%=txtTireDepth2L.ClientID%>").val(data.d[0].tireDepth2L);
                            $("#<%=txtTireDepth1R.ClientID%>").val(data.d[0].tireDepth1R);
                            $("#<%=txtTireDepth2R.ClientID%>").val(data.d[0].tireDepth2R);
                        }
                        else {
                            $("#<%=txtTruckDepth1L.ClientID%>").val(data.d[0].tireDepth1L);
                            $("#<%=txtTruckDepth2L.ClientID%>").val(data.d[0].tireDepth2L);
                            $("#<%=txtTruckDepth2L2.ClientID%>").val(data.d[0].tireDepth2L2);
                            $("#<%=txtTruckDepth3L.ClientID%>").val(data.d[0].tireDepth3L);
                            $("#<%=txtTruckDepth3L2.ClientID%>").val(data.d[0].tireDepth3L2);
                            $("#<%=txtTruckDepth4L.ClientID%>").val(data.d[0].tireDepth4L);
                            $("#<%=txtTruckDepth4L2.ClientID%>").val(data.d[0].tireDepth4L2);
                            $("#<%=txtTruckDepth5L.ClientID%>").val(data.d[0].tireDepth5L);
                            $("#<%=txtTruckDepth5L2.ClientID%>").val(data.d[0].tireDepth5L2);
                            $("#<%=txtTruckDepth6L.ClientID%>").val(data.d[0].tireDepth6L);
                            $("#<%=txtTruckDepth6L2.ClientID%>").val(data.d[0].tireDepth6L2);

                            $("#<%=txtTruckDepth1R.ClientID%>").val(data.d[0].tireDepth1R);
                            $("#<%=txtTruckDepth2R.ClientID%>").val(data.d[0].tireDepth2R);
                            $("#<%=txtTruckDepth2R2.ClientID%>").val(data.d[0].tireDepth2R2);
                            $("#<%=txtTruckDepth3R.ClientID%>").val(data.d[0].tireDepth3R);
                            $("#<%=txtTruckDepth3R2.ClientID%>").val(data.d[0].tireDepth3R2);
                            $("#<%=txtTruckDepth4R.ClientID%>").val(data.d[0].tireDepth4R);
                            $("#<%=txtTruckDepth4R2.ClientID%>").val(data.d[0].tireDepth4R2);
                            $("#<%=txtTruckDepth5R.ClientID%>").val(data.d[0].tireDepth5R);
                            $("#<%=txtTruckDepth5R2.ClientID%>").val(data.d[0].tireDepth5R2);
                            $("#<%=txtTruckDepth6R.ClientID%>").val(data.d[0].tireDepth6R);
                            $("#<%=txtTruckDepth6R2.ClientID%>").val(data.d[0].tireDepth6R2);
                        }
                    }

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });

        };
            function resetTireDepth() {
                $("#<%=txtAxleStandardDepth.ClientID%>").val("");
                $("#<%=txtTireDepth1L.ClientID%>").val("");
                $("#<%=txtTireDepth2L.ClientID%>").val("");
                $("#<%=txtTireDepth1R.ClientID%>").val("");
                $("#<%=txtTireDepth2R.ClientID%>").val("");
                $("#<%=txtTruckDepth1L.ClientID%>").val("");
                $("#<%=txtTruckDepth2L.ClientID%>").val("");
                $("#<%=txtTruckDepth2L2.ClientID%>").val("");
                $("#<%=txtTruckDepth3L.ClientID%>").val("");
                $("#<%=txtTruckDepth3L2.ClientID%>").val("");
                $("#<%=txtTruckDepth4L.ClientID%>").val("");
                $("#<%=txtTruckDepth4L2.ClientID%>").val("");
                $("#<%=txtTruckDepth5L.ClientID%>").val("");
                $("#<%=txtTruckDepth5L2.ClientID%>").val("");
                $("#<%=txtTruckDepth6L.ClientID%>").val("");
                $("#<%=txtTruckDepth6L2.ClientID%>").val("");
                $("#<%=txtTruckDepth1R.ClientID%>").val("");
                $("#<%=txtTruckDepth2R.ClientID%>").val("");
                $("#<%=txtTruckDepth2R2.ClientID%>").val("");
                $("#<%=txtTruckDepth3R.ClientID%>").val("");
                $("#<%=txtTruckDepth3R2.ClientID%>").val("");
                $("#<%=txtTruckDepth4R.ClientID%>").val("");
                $("#<%=txtTruckDepth4R2.ClientID%>").val("");
                $("#<%=txtTruckDepth5R.ClientID%>").val("");
                $("#<%=txtTruckDepth5R2.ClientID%>").val("");
                $("#<%=txtTruckDepth6R.ClientID%>").val("");
                $("#<%=txtTruckDepth6R2.ClientID%>").val("");
            }

            function resetForms() {
                $("#<%=txtTireRefNo.ClientID%>").val("");
                $("#<%=txtTireRegNo.ClientID%>").val("");
                $("#<%=txtCreateMake.ClientID%>").val("");
                $("#<%=txtCreateModel.ClientID%>").val("");
                $("#<%=txtCreateOrgTireDimBack.ClientID%>").val("");
                $("#<%=txtCreateOrgTireDimFront.ClientID%>").val("");
                $("#<%=txtNewFirstName.ClientID%>").val("");
                $("#<%=txtNewMiddleName.ClientID%>").val("");
                $("#<%=txtNewLastName.ClientID%>").val("");
                $("#<%=txtNewAddress.ClientID%>").val("");
                $("#<%=txtNewCompanyName.ClientID%>").val("");
                $("#<%=txtNewZipCode.ClientID%>").val("");
                $("#<%=txtNewPlace.ClientID%>").val("");
                $("#<%=txtNewMobile.ClientID%>").val("");
                $("#<%=txtNewMail.ClientID%>").val("");
                $("#<%=txtNewCustNo.ClientID%>").val("");
                $("#<%=txtTirePackageNo.ClientID%>").val("");
                $("#<%=txtTirePackageValue.ClientID%>").val("");
                $("#<%=txtTireLocation.ClientID%>").val("");
                $("#<%=ddlTireQuantity.ClientID%>").val(0);
                $("#<%=drpTireType.ClientID%>").val(0);
                $("#<%=drpTireSpike.ClientID%>").val(15);
                $("#<%=drpTireQuality.ClientID%>").val(0);
                $("#<%=drpRimType.ClientID%>").val(0);
                $("#<%=drpAxleNo.ClientID%>").val(0);
                $("#<%=txtExpectedOuteDate.ClientID%>").val("");
                $("#<%=txtTireDimBack.ClientID%>").val("");
                $("#<%=txtTireDimFront.ClientID%>").val("");
                $("#<%=txtAnnotation.ClientID%>").val("");
                $("#<%=chkBoltsDelivered.ClientID%>").prop('checked', false);
                $("#<%=chkCapsDelivered.ClientID%>").prop('checked', false);

            }


            $('#<%=drpTireType.ClientID%>').change(function () {

            });


            $("#<%=btnTirePackageNew.ClientID%>").on('click', function (e) {
                resetForms();
                resetTireDepth();
                myNameSpace.set("po_modal_state", 1);
                initFirstModalStepView();
                $('#modal_cl_steps').modal('show');

            });

            $("#btnErrorSpareListOK").on('click', function (e) {
                $('#vehicleTireDepthSpecification').modal('hide');

                $('#modal_cl_steps').modal('show');


            });
            $("#tireDepthClose").on('click', function (e) {
                $('#vehicleTireDepthSpecification').modal('hide');

                $('#modal_cl_steps').modal('show');


            });

            $("#btnTPPrint").on('click', function (e) {
                var number = $("#<%=txtTirePackageNo.ClientID%>").val() + " " + $("#<%=txtTirePackageValue.ClientID%>").val();
                if (number != "") {
                    $('#modal_cl_steps').modal('hide');
                    fetchDeliveryReport(number);
                }
                else {
                    swal("Du må få dekkpakkenr før du kan skrive ut.")
                }
                

            });

            //btn on stage 3 that closes the tire package so it is not more visible in the grid. If you want to see it later on, you need to search the history of the vehicle or the details on the order level
            $("#po_modal_quit").on('click', function (e) {
                //confirm("Vil du avslutte pakken?");
                CloseTirePackage();
                $('#modal_cl_steps').modal('hide');
              <%--  var dateFrom;
                var DateTo;
                if ($("#<%=txtbxDateFrom.ClientID%>").val() != '') {
                    var moddateFrom = $("#<%=txtbxDateFrom.ClientID%>").val();
                    var datetimeFrom = moddateFrom.split("-");
                    dateFrom = datetimeFrom[2] + "-" + datetimeFrom[1] + "-" + datetimeFrom[0] + " 00:00:00.000";
                }
                else {
                    dateFrom = '';
                }
                if ($("#<%=txtbxDateTo.ClientID%>").val() != '') {
                    var moddateTo = $("#<%=txtbxDateTo.ClientID%>").val();
                    var datetimeTo = moddateTo.split("-");
                    dateTo = datetimeTo[2] + "-" + datetimeTo[1] + "-" + datetimeTo[0] + " 23:59:59.999";
                }
                else {
                    dateTo = '';
                }--%>
                $("#TirePackage-table").tabulator("setData", "TireHotel.aspx/Fetch_TP_List", { 'wh': warehouseID, 'tpNo': $("#<%=txtSearchTPNo.ClientID%>").val(), 'closed': '0', 'refNo': $("#<%=txtSearchRefNo.ClientID%>").val(), 'custNo': $("#<%=txtSearchCustNo.ClientID%>").val(), 'tireType': $("#<%=drpSearchTireType.ClientID%>").val(), 'tireQuality': $("#<%=drpSearchTireQuality.ClientID%>").val() });
                $("#TirePackage-table").tabulator("redraw", true);

            });
        
            function CloseTirePackage() {
                var itemobj = createTPJSONstring();

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "TireHotel.aspx/Close_TP_Item",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        systemMSG('success', 'Dekkpakke  er meldt ut og avsluttet!', 5000);

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Dekkpakke feilet ved utmelding. Kointakt systemadministrator.', 5000);
                    }
                });
                return succeeded

            }

            function isValidNumber(evt, element) {

                var charCode = (evt.which) ? evt.which : event.keyCode


                if (

                  (charCode != 44 || $(element).val().indexOf(',') != -1) && // “,” CHECK comma, AND ONLY ONE.
                  (charCode < 48 || charCode > 57)
                    )

                    return false;

                return true;
            }


            //prevent from being able to copy/paste/cut. That would break the input restriction logic.
            $('.inputNumberDot').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            $('.inputNumberDot').keypress(function (event) {


                if ($(this).attr('id') === 'txtbxSparepartModal') {
                    return (isValidNumber(event, this) && ($(this).val().length < 30));
                }
                return (isValidNumber(event, this) && ($(this).val().length < 6));
            });

            function loadListCustVehicle(customerId) {
                $.ajax({
                    type: "POST",
                    url: "TireHotel.aspx/LoadListCustVehicle",
                    data: "{custId: '" + customerId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpListCustVehicle.ClientID%>').empty();

                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpListCustVehicle.ClientID%>').append($("<option></option>").val(value.refNo).html(value.regNo + ' - ' + value.make + ' - ' + value.model + ' - ' + value.regDate));
                        });
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                }

            $('#<%=drpListCustVehicle.ClientID%>').change(function () {
                var currencyId = this.value;
                //Commented since it is not defined in this page
               // getCurrencyType(currencyId); 
            });

            loadSearch();

            $('#modTransferOrder').modal({
                closable: false,//so that you cant close by just clicking outside modal
                keyboard: false
            });
            $('#modListCustVehicles').modal({
                closable: false,//so that you cant close by just clicking outside modal
                keyboard: false
            });
            $("#po_modal_goto_order").on('click', function (e) {
                $('#modTransferOrder').modal('show');
                $('#modal_cl_steps').modal('hide');
               // transferOrderPopup.Show();
                
            });
            $("#btnOkTransfer").on('click', function (e) {

                if (rbOrdersMenu.GetSelectedItem().value == "CreateNewOrder") {
                    $('#<%=hdnTransferOrder.ClientID%>').val("CreateNewOrder");
                    var itemobj = createTPJSONstring();
                    cbTransferOrder.PerformCallback(itemobj);

                    $('#modTransferOrder').modal('hide');

                    //$('#modal_cl_steps').modal('show');
                }
                else if (rbOrdersMenu.GetSelectedItem().value == "CreateNewGotoOrder") {
                    $('#<%=hdnTransferOrder.ClientID%>').val("CreateNewGotoOrder");
                    //$('#modTransferOrder').modal('hide');
                    //$('#modal_cl_steps').modal('show');
                    //swal("You will be redirected to frmWOJobDetails.");

                    var itemobj = createTPJSONstring();
                    cbTransferOrder.PerformCallback(itemobj);
                }
            });

            $("#btnCloseTransfer").on('click', function (e) {
                $('#modTransferOrder').modal('hide');

                $('#modal_cl_steps').modal('show');
            });

            $("#modTransferOrderClose").on('click', function (e) {
                $('#modTransferOrder').modal('hide');

                $('#modal_cl_steps').modal('show');
            });

            $("#tpselection-table").tabulator({
                height: 500, // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                layout: "fitColumns", //fit columns to width of table (optional)                  
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string
                selectable: true,
                selectablePersistence: false,
                selectableCheck: function (row) {

                    return true; //alow selection of rows where the age is greater than 18
                },

                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    // openModalItemInformation(row, "Archived");
                },
                columns: [ //Define Table Columns
                    { title: "Refnr", field: "refNo", width: 100, align: "center" },
                    { title: "Regnr", field: "regNo", width: 100, align: "center", },
                    { title: "Kundenr", field: "custNo", width: 100, align: "center" },
                    { title: "Navn", field: "custfName", width: 180, align: "center" },
                    { title: "Tlf.", field: "custmobile", width: 100, align: "center" },
                    { title: "Dekkpakke", field: "tirePackageNo", width: 120, align: "center" },
                    { title: "dim foran", field: "tireDimFront", width: 120, align: "center" },
                    { title: "din bak", field: "tireDimBack", align: "center" },
                    { title: "Lokasjon", field: "location", width: 100, align: "center" },
                    { title: "Dekktype", field: "tireTypeDesc", align: "center" },
                    { title: "Pigg?", field: "tireSpikesDesc", align: "center" },
                    { title: "Felgtype", field: "tireRimDesc", align: "center" },
                    { title: "Dekkmerke", field: "tireBrandDesc", align: "center" },
                    { title: "Kvalitet", field: "tireQualityDesc", align: "center" }

                ],

                ajaxResponse: function (url, params, response) {


                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //Return the d Property Of a response json Object
                },


            });

            $("#<%=searchSelectionbutton.ClientID%>").on('click', function (e) {


                //-----------------------------------------ORIGINAL CODE-------------------------------------------------------------------------//
                //alert("inside the run function");
                var depth;
                var locationFrom = "";
                var locationTo = "";
                if ($("#<%=txtSelTireDepthTo.ClientID%>").val() == "") {
                    depth = 0;
                }
                else {
                    depth = $("#<%=txtSelTireDepthTo.ClientID%>").val();
                }
                if ($("#<%=txtSelLocationFrom.ClientID%>").val() == "") {
                    locationFrom = 0;
                }
                else {
                    locationFrom = $("#<%=txtSelLocationFrom.ClientID%>").val();
                }
                if ($("#<%=txtSelLocationTo.ClientID%>").val() == "") {
                    locationTo = 0;
                }
                else {
                    locationTo = $("#<%=txtSelLocationTo.ClientID%>").val();
                }
                //$('.selectionList').each(function (index, item) {

                //    ($(item).is(':checked'));
                //    if ($(item).is(':checked') == true) {
                //        //alert("is true");
                //        if (i <= 20) {
                //            //alert("less than 21");
                //            array[i] = 2;
                //        }
                //        else {
                //            array[i] = 1;
                //        }

                //    }
                //    else {
                //        array[i] = 0;

                //    }
                //    i++;

                //});

             
              
                $("#modTirePackageSelection").modal('show');
                $("#tpselection-table").tabulator("setData", "TireHotel.aspx/GENERATE_TP_SELECTION", {
                    'warehouse': warehouseID, 'department': departmentID, 'tiretype': $("#<%=drpSelTireType.ClientID%>").val(),
                    'spikesornot': $("#<%=drpSelSpikes.ClientID%>").val(),

                    'rimtype': $("#<%=drpSelRimType.ClientID%>").val(),
                    'tirebrand': $("#<%=drpSelTireBrands.ClientID%>").val(),

                    'tirequality': $("#<%=drpSelTireQuality.ClientID%>").val(),

                    'tiredepth': depth,

                    'locationfrom': locationFrom,

                    'locationto': locationTo
                });

            });

            $('#modal_next').on('click', function (e) {
              
                var rows = $("#tpselection-table").tabulator("getSelectedRows");
                var str = "";

                for (i = 0; i < rows.length; i++) {

                   console.log(rows[i].getData().custmobile);
                    str += rows[i].getData().custfName + " & ";
                    mobile[i] = rows[i].getData().custmobile;
                }
                //swal("SMS er sendt til følgende kunder: " +str);
                //$("#modScheme").modal('hide');
               
                initSecondStep();
            });

            $('#modal_previous').on('click', function (e) {

                if (myNameSpace.get("sel_modal_state") == 2) {
                    //myNameSpace.set("po_modal_state", 1);
                    initFirstStep();
                }
                else if (myNameSpace.get("sel_modal_state") == 3) {
                    //myNameSpace.set("po_modal_state", 1);
                    initSecondStep();
                }
            });

            $('#btnPrintReport').on('click', function () {
                $("#modTirePackageSelection").modal('hide');
                fetchReportValues();
                // window.parent.$('.ui-dialog-content:visible').dialog('close');
            });

            function fetchReportValues() {
                var depth;
                var locationFrom = "";
                var locationTo = "";
                if ($("#<%=txtSelTireDepthTo.ClientID%>").val() == "") {
                     depth = 0;
                 }
                 else {
                     depth = $("#<%=txtSelTireDepthTo.ClientID%>").val();
                 }
                 if ($("#<%=txtSelLocationFrom.ClientID%>").val() == "") {
                     locationFrom = 0;
                 }
                 else {
                     locationFrom = $("#<%=txtSelLocationFrom.ClientID%>").val();
                 }
                 if ($("#<%=txtSelLocationTo.ClientID%>").val() == "") {
                     locationTo = 0;
                 }
                 else {
                     locationTo = $("#<%=txtSelLocationTo.ClientID%>").val();
            }
           
            //console.log('fetchvehicle');
            $.ajax({
                type: "POST",
                url: "TireHotel.aspx/FetchReportValues",
                data: "{'warehouse':'" + warehouseID + "', 'department':'" + departmentID + "', 'tiretype':'" + $("#<%=drpSelTireType.ClientID%>").val() + "', 'spikesornot':'" + $("#<%=drpSelSpikes.ClientID%>").val()
                    + "', 'rimtype':'" + $("#<%=drpSelRimType.ClientID%>").val() + "', 'tirebrand':'" + $("#<%=drpSelTireBrands.ClientID%>").val() + "', 'tirequality':'" + $("#<%=drpSelTireQuality.ClientID%>").val()
                    + "', 'tiredepth':'" + depth + "', 'locationfrom':'" + locationFrom + "', 'locationto':'" + locationTo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    if (data.d.length != 0) {
                        console.log('Success response');
                        // popupXtraChkReport.ShowWindow(popupXtraChkReport.GetWindow(0));                        
                        cbTPSelection.PerformCallback();
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

            $('#<%=btnEditSMSText.ClientID%>').on('click', function () {
                $('#<%=txtEditSMSText.ClientID%>').val($('#<%=txtSMSText.ClientID%>').val());
                $('#editTextValue').html($('#<%=optSMSText.ClientID%>').val());
                $('#modSMSTexts').modal('setting', {
                    onDeny: function () {


                    },
                    onApprove: function () {
                        alert($('#editTextValue').html() + " " + $('#<%=txtEditSMSText.ClientID%>').val());
                        if ($('#editTextValue').html() != "" && $('#<%=txtEditSMSText.ClientID%>').val() != "") {
                            saveNewMessageTemplate($('#editTextValue').html(), $('#<%=txtEditSMSText.ClientID%>').val());
                            fillSMSTexts();
                }
                        else if ($('#editTextValue').html() == "" && $('#<%=txtEditSMSText.ClientID%>').val() != "") {
                            saveNewMessageTemplate("", $('#<%=txtEditSMSText.ClientID%>').val());
                        }
                        else {
                            swal("Error with run the savings to the DB: dropdwn verdien er: " + $('#editTextValue').html())
                        }

                    },
                    onShow: function () {
                        $(this).children('ui.button.ok.positive').focus();
                    }
                }).modal('show');
                $("#modScheme").modal('show');
            });

            $('#<%=optSMSText.ClientID%>').on('change', function () {
                $('#<%=txtSMSText.ClientID%>').val($('#<%=optSMSText.ClientID%> option:selected').text());
            });

            $("#<%=btnEditSMSNew.ClientID%>").on('click', function () {

                $('#<%=txtEditSMSText.ClientID%>').val('');
                $('#editTextValue').html('');

            });



            ////////////////////////////end of document ready////////////////////////////////////////
        });

       

        function FetchCustomerDetails(custNo) {
            //alert("dd");
            $.ajax({
                type: "POST",
                url: "TireHotel.aspx/FetchCustomerDetails",
                data: "{custNo: '" + custNo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    //alert("stock after count is: " + data.d[0].vehicle_group);
                    console.log(data.d);
                    if (data.d[0].flg_private_comp == 'True') {
                        $('#private').addClass('hidden');
                        $('#company').removeClass('hidden');
                        $("#<%=chkCompany.ClientID%>").prop('checked', true);
                            $('#<%=txtNewCompanyName.ClientID%>').val(data.d[0].custlName);

                        }
                        else {
                            $('#private').removeClass('hidden');
                            $('#company').addClass('hidden');
                            $("#<%=chkCompany.ClientID%>").prop('checked', false);
                            $('#<%=txtNewCompanyName.ClientID%>').val("");
                            $('#<%=txtNewFirstName.ClientID%>').val(data.d[0].custfName);
                            $('#<%=txtNewMiddleName.ClientID%>').val(data.d[0].custmName);
                            $('#<%=txtNewLastName.ClientID%>').val(data.d[0].custlName);
                        }
                        $('#<%=txtNewCustNo.ClientID%>').val(data.d[0].id_customer);
                        $('#<%=txtNewAddress.ClientID%>').val(data.d[0].cust_add1);
                        $('#<%=txtNewZipCode.ClientID%>').val(data.d[0].cust_zipcode);
                        $('#<%=txtNewPlace.ClientID%>').val(data.d[0].cust_place);
                        $('#<%=txtNewMobile.ClientID%>').val(data.d[0].custmobile);
                        $('#<%=txtNewMail.ClientID%>').val(data.d[0].custmail);

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });

        };

        function cbTransferOrderEndCallback(s, e) {
            if (rbOrdersMenu.GetSelectedItem().value == "CreateNewOrder") {
                var orderOutputResponses = cbTransferOrder.cpOrderStatus;
                var orderOutputResponse = orderOutputResponses.split(";");
                if (orderOutputResponse.length > 1) {
                    swal('<%=GetLocalResourceObject("odrCreateSuccess")%>' + orderOutputResponse[1] + orderOutputResponse[2]);
                    //$('#modal_cl_steps').modal('hide');
                    $("#TirePackage-table").tabulator("setData", "TireHotel.aspx/Fetch_TP_List", { 'wh': warehouseIdTP, 'tpNo': $("#<%=txtSearchTPNo.ClientID%>").val(), 'closed': 0, 'refNo': $("#<%=txtSearchRefNo.ClientID%>").val(), 'custNo': $("#<%=txtSearchCustNo.ClientID%>").val(), 'tireType': $("#<%=drpSearchTireType.ClientID%>").val(), 'tireQuality': $("#<%=drpSearchTireQuality.ClientID%>").val() });
                    $("#TirePackage-table").tabulator("redraw", true);
                }
                else {
                    swal('<%=GetLocalResourceObject("odrCreateFail")%>');
                }

            }
            
        }

        function fetchDeliveryReport(number) {

            $.ajax({
                type: "POST",
                url: "TireHotel.aspx/FetchDeliveryReport",
                data: "{'number':'" + number  + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    if (data.d.length != 0) {
                        console.log('Success response');
                        // popupXtraChkReport.ShowWindow(popupXtraChkReport.GetWindow(0));                        
                        cbTireDelivery.PerformCallback();
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
        function OnTireDeliveryEndCallBack() {
            popupTireDeliveryReport.ShowWindow(popupTireDeliveryReport.GetWindow(0));
        }
        function OnTPSelectionEndCallBack() {
            popupTPSelectionReport.ShowWindow(popupTPSelectionReport.GetWindow(0));
        }

        function initFirstStep() {
            $('.modal_step_one').removeClass('hidden');
            $('.modal_step_two').addClass('hidden');
            $('.modal_step_three').addClass('hidden');


            //header steps
            $("#step_one").removeClass("completed step");
            $("#step_one").removeClass("disabled step");
            $("#step_one").addClass("active step");

            $("#step_two").removeClass("active step");
            $("#step_two").removeClass("completed step");
            $("#step_two").addClass("disabled step");

            $("#step_three").removeClass("active step");
            $("#step_three").removeClass("completed step");
            $("#step_three").addClass("disabled step");


            //buttons
            //$("#po_modal_save").show();
            $("#tpSelectionSendSms").hide();
            $("#modal_previous").hide();
            $("#modal_next").show();
            myNameSpace.set("sel_modal_state", 1);
        }

        function initSecondStep() {
            //brings over various variables from grid to the modal window
            myNameSpace.set("sel_modal_state", 2);
            //content divs(tables)

            $('.modal_step_one').addClass('hidden');
            $('.modal_step_two').removeClass('hidden');
            $('.modal_step_three').addClass('hidden');


            //header steps
            $("#step_one").addClass("completed step");
            $("#step_one").addClass("disabled step");
            $("#step_one").removeClass("active");

            $("#step_two").addClass("active");
            $("#step_two").removeClass("disabled");

            $("#step_three").removeClass("active step");
            $("#step_three").removeClass("completed step");
            $("#step_three").addClass("disabled step");

            //button states

            $("#tpSelectionSendSms").show();
            $("#modal_previous").show();
            $("#modal_next").hide();

        }

        function initThirdStep() {
            //brings over various variables from grid to the modal window
            myNameSpace.set("sel_modal_state", 3);
            //content divs(tables)

            $('.modal_step_one').addClass('hidden');
            $('.modal_step_two').addClass('hidden');
            $('.modal_step_three').removeClass('hidden');


            //header steps
            $("#step_one").addClass("completed step");
            $("#step_one").addClass("disabled step");
            $("#step_one").removeClass("active");

            $("#step_two").addClass("completed step");
            $("#step_two").addClass("disabled step");
            $("#step_two").removeClass("active");

            $("#step_three").addClass("active");
            $("#step_three").removeClass("disabled");



            //button states

            $("#tpSelectionSendSms").hide();
            $("#modal_previous").show();
            $("#modal_next").hide();
            $("#modal_close").show();

        }

        /*Fetches the data you need from sms config to be able to send sms. Username, password etc.*/
        function fetchSMSConfig(type) {
            var phone = mobile;
            var textvalue = smstext;
            // alert("dette er tlfnr " + mobile);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../master/frmSendSMS.aspx/LoadSMSConfig",
                data: "{'department':'" + "" + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    if (Result.d.length > 0) {
                        arrayOfValues[0] = Result.d[0].DEPARTMENT

                        arrayOfValues[1] = Result.d[0].SENDER_SMS
                        arrayOfValues[2] = Result.d[0].USER_ID
                        arrayOfValues[3] = Result.d[0].USER_PASSWORD
                        arrayOfValues[4] = Result.d[0].SMS_OPERATOR_LINK
                        arrayOfValues[5] = Result.d[0].SUB_NAME
                        arrayOfValues[6] = Result.d[0].SUB_PHONE

                        //return arrayOfValues;
                        //var messageType = "Manuell SMS";
                        //saveSMSGlobal(, Result.d[0]., phoneTo, messageType, messageText, time, Result.d[0].USER_ID, Result.d[0].USER_PASSWORD, Result.d[0].SMS_OPERATOR_LINK);
                        //sendXtraCheckWeb();
                        if (type == "Manuell SMS") {
                            for (var i = 0; i < mobile.length; i++) {
                                //alert(mobile[i]);
                                sendSMS(mobile[i], smstext, "");
                            }

                        }
                        else {
                            swal("SMS ble ikke sendt!")
                        }
                        //xtraCheckMobile()
                        //sendSMS(mobile);


                    }
                }
            });
        }

        function sendSMS(mob, text, id) {
            var num = mob;
            var message = text;
            var time = "";
            var smsid = id
            if ($("#<%=txtSendDate.ClientID%>").val() != "" && $('#<%=optTimeToSend.ClientID%>').val() != -1) {
                var array = $("#<%=txtSendDate.ClientID%>").val().split('.');
                var date = array[2] + "-" + array[1] + "-" + array[0];
                time = date + " " + $('#<%=optTimeToSend.ClientID%> option:selected').text() + ":00";
            }

            //var password = "Cars%2021";
            var user = encodeURIComponent(arrayOfValues[2]);
            var passres = encodeURIComponent(arrayOfValues[3]);
            var deliveryreporturl = arrayOfValues[4];
            //alert(passres);
            $.ajax({
                type: "POST",
                url: "../master/frmSendSMS.aspx/SendSMS",
                data: "{num: '" + num + "', 'message': '" + message + "', 'time': '" + time + "', 'id': '" + smsid + "', 'user': '" + user + "', 'password': '" + passres + "', 'dru': '" + deliveryreporturl + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length != 0) {
                        if (data.d == "OK") {
                            var msg = "Dekkhotell SMSK"
                            saveSMS(msg, mob, text);
                            swal("Sms er sendt til " + mob + " og loggført.");
                        }
                        else {
                            swal("Sms fikk følgende retursvar: " + data.d);
                        }

                    }
                    else {
                        alert('SMS not sent. Please try again later!')
                    }
                },
                failure: function () {
                    alert("Failed!");
                },
                select: function (e, i) {
                    //alert('hi');
                },
            });
        };

        function saveSMS(messageType, mob, text) {
            var msgType = messageType;
            var time = "";
            if ($("#<%=txtSendDate.ClientID%>").val() != "" && $('#<%=optTimeToSend.ClientID%>').val() != -1) {
                    var array = $("#<%=txtSendDate.ClientID%>").val().split('.');
                    var date = array[2] + "-" + array[1] + "-" + array[0];
                    time = date + " " + $('#<%=optTimeToSend.ClientID%> option:selected').text() + ":00";
                }

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../master/frmSendSMS.aspx/SaveSMS",
                    data: "{dept: '" + "22" + "', phoneFrom:'" + arrayOfValues[1] + "', phoneTo:'" + mob + "', messageType:'" + msgType + "', messageText:'" + text + "', time:'" + time + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d[0] != "") {
                            //sendSMS($("#<%=txtMobile.ClientID%>").val(), $("#<%=txtSMSText.ClientID%>").val(), data.d[0]);
                            //swal("SMS er sendt!")

                        }
                        else {
                            swal("SMS ble ikke lagret og derfor ikke sendt.");
                        }
                    },
                    error: function (result) {
                        alert("Error uten at jeg vet hva som feila i savesms");
                    }
                });
        };

        function fillSMSTexts() {

            $.ajax({
                type: "POST",
                url: "TireHotel.aspx/FillSMSTexts",
                data: "{'type':'" + "DEKKHOTELL" + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (Result) {
                    var optSMSText = $("[id*=optSMSText]");
                    optSMSText.empty().append('<option selected="selected" value="0">- Velg mal -</option>');
                    $.each(Result.d, function () {
                        optSMSText.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                },
                failure: function () {
                    alert("Failed!");
                }
            });
        };

        function saveNewMessageTemplate(id, text) {

            // 0 = good,  1= ok, 2=action should be taken

            //$('input[type=checkbox]').prop('checked');
            var tempType = "DEKKHOTELL";

            alert("nå er du i lagre funksjon" + id + text + tempType);


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "TireHotel.aspx/SaveMessageTemplate",
                data: "{'tempId':'" + id
                    + "',tempText:'" + text
                    + "',tempType:'" + tempType + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    systemMSG('success', 'SMS innstillinger har blitt lagret!', 4000);
                },
                failure: function () {
                    systemMSG('error', 'Se over instillingene. Noe er innfylt feilaktig.!', 4000);
                }
            });

        }

    </script>


    <asp:HiddenField ID="hdnSelect" runat="server" />
    <asp:HiddenField ID="hdnTransferOrder" runat="server" />
    <asp:HiddenField ID="hdnSequenceNumber" runat="server" />
    <div class="overlayHide">
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
    </div>
    <div id="systemMessage" class="ui message"></div>

    <div class="ui grid">
        <div id="tabFrame" class="sixteen wide column">
            <input type="button" id="btnTirePackageList" value="Pakkeoversikt" class="cTab ui btn" data-tab="TirePackageList" />
            <input type="button" id="btnNewTirePackage" value="Utvalg" class="cTab ui btn" data-tab="NewTirePackage" />
        </div>
    </div>


    <%--Begin tab PurchaseOrders--%>

    <div id="tabTirePackageList" class="tTab">
        <div class="ui form stackable two column grid ">

            <div class="four wide column">
                 <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("lblSearchTirePackage")%></h3>
                    <label class="inHeaderCheckbox">
                        <%=GetLocalResourceObject("drpSearchShowHide")%>
                            <button id="btnViewDetails" class="ui btn mini">
                                <i class="caret down icon"></i>
                            </button>
                    </label>
                    <div class="searchvalues-container">
                        <div class="fields">
                            <div class="six wide field">
                            </div>
                            <div class="six wide field">
                            </div>

                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblPOnumber" runat="server"><%=GetLocalResourceObject("lblSearchTirePackageNo")%></label>
                                <asp:TextBox ID="txtSearchTPNo" runat="server" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>


                        </div>

                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblCLSupplier" runat="server"><%=GetLocalResourceObject("lblSearchRefNo")%></label>
                                <asp:TextBox ID="txtSearchRefNo" runat="server" data-submit="ITEM_DISC_CODE_BUY" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblCLSpare" runat="server"><%=GetLocalResourceObject("lblSearchCustomerNo")%></label>
                                <asp:TextBox ID="txtSearchCustNo" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblDateFrom" runat="server"><%=GetLocalResourceObject("lblSearchTireType")%></label>
                                  <asp:DropDownList ID="drpSearchTireType" runat="server" meta:resourcekey="drpSearchTireTypeResource1"></asp:DropDownList>
                            </div>
                            <div class="eight wide field">
                                <label id="lblDateTo" runat="server"><%=GetLocalResourceObject("lblSearchTireQuality")%></label>
                                  <asp:DropDownList ID="drpSearchTireQuality" runat="server" meta:resourcekey="drpSearchTireQualityResource1"></asp:DropDownList>
                            </div>

                        </div>

                        <div class="fields">
                            <div class="eight wide field">

                                <div class="ui toggle checkbox">
                                    <input id="chkSearchClosed" runat="server" type="checkbox" name="public" />
                                    <label><%=GetLocalResourceObject("lblSearchComplete")%></label>
                                </div>
                            </div>
                        </div>


                        <div class="fields">
                            <div class="eight wide field">

                                <input type="button" id="searchbutton" runat="server" class="ui btn CarsBoxes" meta:resourcekey="searchButtonResource1" />
                                  <%--<input type="button" id="Button1" runat="server" value="<%=GetLocalResourceObject("searchButton")%>" class="ui btn CarsBoxes" />--%>

                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnTirePackageNew" runat="server" value="New" class="ui btn CarsBoxes" meta:resourcekey="newPackageButtonResource1"/>
                                <%--<input type="button" id="Button1" runat="server" value="<%=GetLocalResourceObject("newPackageButton")%>" class="ui btn CarsBoxes" />--%>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <%--End of Purchase order segment--%>
            <div class="twelve wide column">
                <div id="TirePackage-table" class="mytabulatorclass">
                </div>
            </div>



        </div>
    </div>

    <%--End tab PurchaseOrders--%>


    <%--Begin tab NewCountingList--%>

    <div id="tabNewTirePackage" class="tTab">
        <div class="ui form stackable two column grid ">

            <div class="eight wide column">
                 <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H2" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Utvalg av dekkpakker</h3>
               
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblSelTireType" runat="server">Tire Type</label>
                                  <asp:DropDownList ID="drpSelTireType" runat="server"></asp:DropDownList>
                            </div>
                             <div class="eight wide field">
                                <label id="lblSelSpikes" runat="server">Spikes or not</label>
                                  <asp:DropDownList ID="drpSelSpikes" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                     <div class="fields">
                            <div class="eight wide field">
                                <label id="lblSelRimType" runat="server">Rim type</label>
                                  <asp:DropDownList ID="drpSelRimType" runat="server" ></asp:DropDownList>
                            </div>
                            <div class="eight wide field">
                                <label id="lblSelTireBrands" runat="server">Tire brands</label>
                                  <asp:DropDownList ID="drpSelTireBrands" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblSelTireQuality" runat="server">Tire quality</label>
                               <asp:DropDownList ID="drpSelTireQuality" runat="server"></asp:DropDownList>
                            </div>
                            <div class="eight wide field">
                                <label id="lblSelTireDepth" runat="server">Tire depth up to (mm)</label>
                                <asp:TextBox ID="txtSelTireDepthTo" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblLocationFrom" runat="server">Location from</label>
                                <asp:TextBox ID="txtSelLocationFrom" runat="server"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblSelLocationTo" runat="server">Location to</label>
                                <asp:TextBox ID="txtSelLocationTo" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                        </div>
                        <div class="fields">
                            <div class="eight wide field">

                            </div>
                        </div>


                        <div class="fields">
                            <div class="eight wide field">

                                <input type="button" id="searchSelectionbutton" runat="server" class="ui btn wide" meta:resourcekey="searchButtonResource1" />
                                  <%--<input type="button" id="Button1" runat="server" value="<%=GetLocalResourceObject("searchButton")%>" class="ui btn CarsBoxes" />--%>

                            </div>
                            <div class="eight wide field">
                               
                            </div>

                        </div>

                  
                </div>
            </div>
            <%--End of Purchase order segment--%>
            <div class="eight wide column">
               
            </div>



        </div>
    </div>
















    <%--MODALS--%>


    <div class="fullscreen ui modal" id="modal_cl_steps">
        <i class="close icon"></i>
        <a class="ui red ribbon label" id="redRibbonPOmodal"></a>
        <div class="header">
            <div class="ui three top attached steps">
                <div class="active step" id="step_cl_first">
                    <i class="dollar sign icon"></i>
                    <div class="content">
                        <div class="title"><%=GetLocalResourceObject("step1AddVehicleCustomer")%></div>
                        <div class="description"><%=GetLocalResourceObject("step1AddVehicleCustomerInfo")%></div>
                    </div>
                </div>
                <div class="disabled step" id="step_cl_second">
                    <i class="pencil icon"></i>
                    <div class="content">
                        <div class="title"><%=GetLocalResourceObject("step1AddTirePAckage")%></div>
                        <div class="description"><%=GetLocalResourceObject("step1AddTirePackageInfo")%></div>
                    </div>
                </div>
                <div class="disabled step" id="step_cl_third">
                    <i class="close alternate icon"></i>
                    <div class="content">
                        <div class="title"><%=GetLocalResourceObject("step1CompleteTirePackage")%></div>
                        <div class="description"><%=GetLocalResourceObject("step1CompleteTirePackageInfo")%></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">

            <div class="modal_cl_divstep1">
                <div class="ui form stackable two column grid ">
                    <div class="two wide column">
                    </div>
                    <div class="six wide column">
                         <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H3" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headVehicleDetails")%></h3>

                            <asp:Label ID="lblOrderDate" class="inHeaderTextField4" runat="server" meta:resourcekey="lblOrderDateResource1"></asp:Label>


                            <div class="itemadd-container">


                                <div class="fields">
                                    <div class="ten wide field">
                                        <label id="lblTPVehicleSearch" runat="server"><%=GetLocalResourceObject("lblTPVehicleSearch")%></label>
                                        <asp:TextBox ID="txtTPVehicleSearch" runat="server" PlaceHolder="Søk etter kjøretøy...." meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                    <div class="two wide field">
                                        <label id="Label1" runat="server">&nbsp;</label>
                                        <input type="button" id="btnNewVehicle" value="Ny bil" runat="server" class="ui btn CarsBoxes" />
                                    </div>
                                </div>
                                <div class="fields">
                                    <div class="eight wide field">
                                        <label id="lblCreateFromCatg" runat="server"><%=GetLocalResourceObject("lblVehRefNo")%></label>
                                        <asp:TextBox ID="txtTireRefNo" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                    <div class="eight wide field">
                                        <label id="lblCreateToCatg" runat="server"><%=GetLocalResourceObject("lblVehRegNo")%></label>
                                        <asp:TextBox ID="txtTireRegNo" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="fields">
                                    <div class="eight wide field">
                                        <label id="lblCreateMake" runat="server"><%=GetLocalResourceObject("lblVehMake")%></label>
                                        <asp:TextBox ID="txtCreateMake" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                    <div class="eight wide field">
                                        <label id="lblCreateModel" runat="server"><%=GetLocalResourceObject("lblVehModel")%></label>
                                        <asp:TextBox ID="txtCreateModel" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>

                                    </div>
                                </div>
                                <div class="fields">
                                    <div class="eight wide field">
                                        <label id="lblCreateOrgTireDimFront" runat="server"><%=GetLocalResourceObject("lblVehOrgTireDimFront")%></label>
                                        <asp:TextBox ID="txtCreateOrgTireDimFront" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                    <div class="eight wide field">
                                        <label id="lblCreateOrgTireDimBack" runat="server"><%=GetLocalResourceObject("lblVehOrgTireDimBack")%></label>
                                        <asp:TextBox ID="txtCreateOrgTireDimBack" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="fields">
                                    <div class="eight wide field">
                                        <label id="Label2" runat="server"><%=GetLocalResourceObject("lblVehMileage")%></label>
                                        <asp:TextBox ID="txtMileage" runat="server" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                    <div class="eight wide field">
                                    </div>

                                </div>





                            </div>
                        </div>

                    </div>
                    <div class="six wide column">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H4" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headCustomerDetails")%></h3>
                            <label class="inHeaderCheckbox">
                                 <%--Text="Firma?"--%>
                                <asp:CheckBox ID="chkCompany" runat="server" meta:resourcekey="chkCompanyResource1" /></label>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="lblSearchCustomer" runat="server"><%=GetLocalResourceObject("lblSearchCustomer")%></label>
                                    <asp:TextBox ID="txtTPCustomerSearch" runat="server" Placeholder="Søk etter kunde...." data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="Label5" runat="server">&nbsp;</label>
                                    <input type="button" id="btnNewCustomer" value="Ny kunde" runat="server" class="ui btn CarsBoxes" />
                                </div>
                                <div class="four wide field">
                                    <label id="Label9" runat="server"><%=GetLocalResourceObject("lbCustID")%></label>
                                    <asp:TextBox ID="txtNewCustNo" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields" id="private">
                                <div class="five wide field">
                                    <label id="lblNewFirstName" runat="server"><%=GetLocalResourceObject("lblCustFirstname")%></label>
                                    <asp:TextBox ID="txtNewFirstName" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="five wide field">
                                    <label id="lblNewMiddleName" runat="server"><%=GetLocalResourceObject("lblCustMiddlename")%></label>
                                    <asp:TextBox ID="txtNewMiddleName" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="six wide field">
                                    <label id="lblNewLastName" runat="server"><%=GetLocalResourceObject("lblCustLastname")%></label>
                                    <asp:TextBox ID="txtNewLastName" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>
                            <div class="fields hidden" id="company">
                                <div class="twelve wide field">
                                    <label id="lblNewCompantName" runat="server"><%=GetLocalResourceObject("lblCustCompanyname")%></label>
                                    <asp:TextBox ID="txtNewCompanyName" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="fields">
                                <div class="twelve wide field">
                                    <label id="lblNewAddress" runat="server"><%=GetLocalResourceObject("lblCustAddress")%></label>
                                    <asp:TextBox ID="txtNewAddress" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                </div>
                            </div>
                            <div class="fields">
                                <div class="six wide field">
                                    <label id="lblNewZipCode" runat="server"><%=GetLocalResourceObject("lblCustZipCode")%></label>
                                    <asp:TextBox ID="txtNewZipCode" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="ten wide field">
                                    <label id="lblNewPlace" runat="server"><%=GetLocalResourceObject("lblCustZipPlace")%></label>
                                    <asp:TextBox ID="txtNewPlace" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>
                            <div class="fields">
                                <div class="six wide field">
                                    <label id="lblNewMobile" runat="server"><%=GetLocalResourceObject("lblCustMobile")%>.</label>
                                    <asp:TextBox ID="txtNewMobile" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="ten wide field">
                                    <label id="lblNewMail" runat="server"><%=GetLocalResourceObject("lblCustMail")%></label>
                                    <asp:TextBox ID="txtNewMail" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal_cl_divstep2 hidden">
   <%--             <div class="ui header">Rediger dekkpakken</div>--%>
                <div class="ui form stackable two column grid">
                    <div class="two wide column">
                    </div>
                    <div class="six wide column">
                         <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H1" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headPackageDetails")%></h3>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="Label7" runat="server"><%=GetLocalResourceObject("lblTirePackageNo")%></label>
                                    <asp:TextBox ID="txtTirePackageNo" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="four wide field">
                                    <label id="Label8" runat="server">&nbsp;</label>
                                    <asp:TextBox ID="txtTirePackageValue" Enabled="False" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="lblTireLocation" runat="server"><%=GetLocalResourceObject("lblPackageLocation")%></label>
                                    <asp:TextBox ID="txtTireLocation" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="eight wide field">
                                    <label id="Label3" runat="server"><%=GetLocalResourceObject("lblPackageFindLocation")%></label>
                                    <input type="button" id="btnTireLocation" value="Søk" runat="server" class="ui btn CarsBoxes " />
                                </div>

                            </div>
                            <div class="fields">
                                <div class="five wide field">
                                    <label>&nbsp;</label>
                                    <div class="ui checkbox">
                                        <input type="checkbox" id="chkBoltsDelivered" runat="server" name="bolts" />
                                        <label><%=GetLocalResourceObject("lblPackageBoltsDelivered")%></label>
                                    </div>
                                </div>

                                <div class="five wide field">
                                    <label>&nbsp;</label>
                                    <div class="ui checkbox">
                                        <input type="checkbox" id="chkCapsDelivered" runat="server" name="caps" />
                                        <label><%=GetLocalResourceObject("lblPackageWheelCover")%></label>
                                    </div>
                                </div>
                                <div class="five wide field">
                                    <label id="Label13" runat="server"><%=GetLocalResourceObject("lblPackageExpectedOutDate")%></label>
                                    <asp:TextBox ID="txtExpectedOuteDate" runat="server" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>

                            </div>

                            <div class="fields">
                                <div class="fifteen wide field">
                                    <label id="Label4" runat="server"><%=GetLocalResourceObject("lblAnnotation")%></label>
                                    <asp:TextBox ID="txtAnnotation" runat="server" TextMode="MultiLine" Height="90px" meta:resourcekey="txtAnnotationResource1"></asp:TextBox>
                                </div>
                            </div>


                        </div>
                    </div>
                    <div class="six wide column">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H5" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headTireDetails")%></h3>

                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="lblCreateTireQty" runat="server"><%=GetLocalResourceObject("lblQtyTires")%></label>
                                    <select id="ddlTireQuantity" runat="server">
                                        <option value="0" selected="selected">--- Velg ---</option>
                                        <option value="1">1 dekk</option>
                                        <option value="2">2 dekk</option>
                                        <option value="3">3 dekk</option>
                                        <option value="4">4 dekk</option>
                                        <option value="6">6 dekk</option>
                                        <option value="8">8 dekk</option>
                                        <option value="10">10 dekk</option>
                                        <option value="12">12 dekk</option>
                                    </select>

                                </div>

                                <div class="eight wide field">
                                    <label id="Label14" runat="server"><%=GetLocalResourceObject("lblTireType")%></label>
                                    <asp:DropDownList ID="drpTireType" runat="server" meta:resourcekey="drpMakeCodesResource1"></asp:DropDownList>
                                </div>

                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="Label15" runat="server"><%=GetLocalResourceObject("lblTireSpikeNoSpike")%></label>
                                    <asp:DropDownList ID="drpTireSpike" runat="server" meta:resourcekey="drpMakeCodesResource1"></asp:DropDownList>
                                </div>

                                <div class="eight wide field">
                                    <label id="Label16" runat="server"><%=GetLocalResourceObject("lblTireRimType")%></label>
                                    <asp:DropDownList ID="drpRimType" runat="server" meta:resourcekey="drpMakeCodesResource1"></asp:DropDownList>
                                </div>

                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="Label17" runat="server"><%=GetLocalResourceObject("lblTireBrand")%></label>
                                    <asp:DropDownList ID="drpTireMake" runat="server" meta:resourcekey="drpMakeCodesResource1"></asp:DropDownList>
                                </div>
                                <div class="eight wide field">
                                    <label id="Label18" runat="server"><%=GetLocalResourceObject("lblTireQuality")%></label>
                                    <asp:DropDownList ID="drpTireQuality" runat="server" meta:resourcekey="drpMakeCodesResource1"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="fields">

                                <div class="eight wide field">
                                    <label id="Label19" runat="server"><%=GetLocalResourceObject("lblTireAxleNo")%></label>
                                    <asp:DropDownList ID="drpAxleNo" runat="server" meta:resourcekey="drpMakeCodesResource1">
                                        <asp:ListItem Text="--- Velg ---" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        <asp:ListItem Text="Personbil" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                        <asp:ListItem Text="2 aksler m/tvilling" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                        <asp:ListItem Text="3 aksler" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                        <asp:ListItem Text="4 aksler" Value="4" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                        <asp:ListItem Text="5 aksler" Value="5" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                        <asp:ListItem Text="6 aksler" Value="6" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="eight wide field">
                                    <label id="Label20" runat="server"><%=GetLocalResourceObject("lblTireDepth")%></label>
                                    <input type="button" id="btnViewTireDepthSpecs" value="spesifiser" runat="server" class="ui btn CarsBoxes" />
                                </div>
                            </div>
                            <div class="fields">
                                <div class="eight wide field">
                                    <label id="lblTireDimFront" runat="server"><%=GetLocalResourceObject("lblTireDimFront")%></label>
                                    <asp:TextBox ID="txtTireDimFront" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                                <div class="eight wide field">
                                    <label id="lblTireDimBack" runat="server"><%=GetLocalResourceObject("lblTireDimBack")%></label>
                                    <asp:TextBox ID="txtTireDimBack" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
            <div class="modal_cl_divstep3 hidden">
                <div class="ui header"><%=GetLocalResourceObject("headCompleteTirePackage")%></div>
                <div class="fields">
                    <div class="three wide field">
                    </div>
                    <div class="circle-loader hidden" style="margin-left: 50%">
                        <div class="checkmarkX draw"></div>
                    </div>
                    <div class="CLClosed">
                        <br />
                        <div class="ui header"><%=GetLocalResourceObject("textCompleteInformation")%></div>
                        <button class="ui red button" id="po_modal_quit">
                            <i class="save icon"></i>
                            <%=GetLocalResourceObject("btnCompletePackage")%>
                        </button>
                        <button class="ui red button" id="po_modal_goto_order">
                            <i class="save icon"></i>
                            <%=GetLocalResourceObject("btnCompletePackageOrder")%>
                        </button>
                    </div>
                    <div class="viewCLClosed hidden">
                        <div id="counting-table-close-modal" class="mytabulatorclass"></div>
                    </div>
                </div>

            </div>

        </div>
        <div class="actions">
            <div class="ui red button disabled" id="btnErrorSpareListView">
                Meldinger
                <i class="cross icon left"></i>
            </div>
            <label id="lblfileUpload2">Last opp fil fra strekkodeleser: </label>
            <input type="file" id="fileUpload2" style="height: 60%; width: 150px" value="C:\Temp\Scan.txt" />

            <button class="ui black button" id="btnEditImport">
                <i class="upload icon left"></i>
                Les inn
            </button>
            <button class="ui blue button" id="btnTPPrint">
                <i class="print icon left"></i>
                <%=GetLocalResourceObject("btnPrint")%>
            </button>
            <div class="ui left labeled icon button" id="po_modal_previous">
                <%=GetLocalResourceObject("btnBack")%> 
                <i class="chevron left icon"></i>
            </div>
            <button class="ui yellow button" id="po_modal_update">
                <i class="refresh icon"></i>
                Oppdater
            </button>
            <div class="ui positive right labeled icon button" id="po_modal_save">
                <div><%=GetLocalResourceObject("btnClose")%></div>

                <i class="chevron right icon"></i>
            </div>
            <div class="ui positive right labeled icon button" id="po_modal_next">
                <div>Neste</div>

                <i class="chevron right icon"></i>
            </div>
            <button class="ui red button" id="po_modal_close">
                <i class="save icon"></i>
                Sperre
            </button>


        </div>
    </div>


    <div class="ui modal" style="margin-top: 20%" id="vehicleTireDepthSpecification">
        <i class="close icon" id="tireDepthClose"></i>
        <div class="header">
            <%=GetLocalResourceObject("headTireDepth")%>
        </div>
        <div class="contentTruck hidden" style="margin-left: 30px; margin-top: 10px;">
            <div class="ui form stackable two column grid ">
                <div class="four wide column">

                    <div class="itemadd-container">

                        <div class="fields tire1l">
                            <div class="sixteen wide field">
                                <label id="Label22" runat="server"><%=GetLocalResourceObject("headTireDepthAxle1")%></label>
                                <asp:TextBox ID="txtTruckDepth1L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>
                        <div class="fields tire2l">
                            <div class="eight wide field">
                                <label id="Label23" runat="server"><%=GetLocalResourceObject("headTireDepthAxle2")%></label>
                                <asp:TextBox ID="txtTruckDepth2L2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label42" runat="server"><%=GetLocalResourceObject("headTireDepthAxle2")%></label>
                                <asp:TextBox ID="txtTruckDepth2L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields tire3l">
                            <div class="eight wide field">
                                <label id="Label24" runat="server"><%=GetLocalResourceObject("headTireDepthAxle3")%></label>
                                <asp:TextBox ID="txtTruckDepth3L2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label25" runat="server"><%=GetLocalResourceObject("headTireDepthAxle3")%></label>
                                <asp:TextBox ID="txtTruckDepth3L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>
                        <div class="fields tire4l">
                            <div class="eight wide field">
                                <label id="Label26" runat="server"><%=GetLocalResourceObject("headTireDepthAxle4")%></label>
                                <asp:TextBox ID="txtTruckDepth4L2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label21" runat="server"><%=GetLocalResourceObject("headTireDepthAxle4")%></label>
                                <asp:TextBox ID="txtTruckDepth4L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields tire5l">
                            <div class="eight wide field">
                                <label id="Label27" runat="server"><%=GetLocalResourceObject("headTireDepthAxle5")%></label>
                                <asp:TextBox ID="txtTruckDepth5L2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label35" runat="server"><%=GetLocalResourceObject("headTireDepthAxle5")%></label>
                                <asp:TextBox ID="txtTruckDepth5L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields tire6l">
                            <div class="eight wide field">
                                <label id="Label28" runat="server"><%=GetLocalResourceObject("headTireDepthAxle6")%></label>
                                <asp:TextBox ID="txtTruckDepth6L2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label36" runat="server"><%=GetLocalResourceObject("headTireDepthAxle6")%></label>
                                <asp:TextBox ID="txtTruckDepth6L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>

                    </div>

                </div>
                <div class="four wide column">
                    <div class="fields">
                        <div class="three wide field">
                            </div>
                        <div class="ten wide field">
                             <label id="Label6" runat="server"><%=GetLocalResourceObject("headTireDepthMaster")%></label>
                            <asp:TextBox ID="txtAxleStandardTruckDepth" runat="server" CssClass="inputNumberDot" meta:resourcekey="txtAxleStandardTruckDepthResource1"></asp:TextBox>
                        </div>
                        <div class="three wide field">
                            </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <div class="fields">
                                &nbsp;
                            </div>
                            <div style="text-align: center !important; width: 100%">
                                <img src="../Images/truck_test.png" alt="picture of the vehicle" />
                            </div>
                            <%--<img src="../Images/vehicle_test.jpg" width="100%" alt="picture of the vehicle">--%>
                        </div>

                    </div>




                </div>

                <div class="four wide column">

                    <div class="itemadd-container" style="left: 200px">

                        <div class="fields tire1r">
                            <div class="sixteen wide field">
                                <label id="Label29" runat="server"><%=GetLocalResourceObject("headTireDepthAxle1")%></label>
                                <asp:TextBox ID="txtTruckDepth1R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>
                        <div class="fields tire2r">
                            <div class="eight wide field">
                                <label id="Label30" runat="server"><%=GetLocalResourceObject("headTireDepthAxle2")%></label>
                                <asp:TextBox ID="txtTruckDepth2R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label37" runat="server"><%=GetLocalResourceObject("headTireDepthAxle2")%></label>
                                <asp:TextBox ID="txtTruckDepth2R2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields tire3r">
                            <div class="eight wide field">
                                <label id="Label31" runat="server"><%=GetLocalResourceObject("headTireDepthAxle3")%></label>
                                <asp:TextBox ID="txtTruckDepth3R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label38" runat="server"><%=GetLocalResourceObject("headTireDepthAxle3")%></label>
                                <asp:TextBox ID="txtTruckDepth3R2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields tire4r">
                            <div class="eight wide field">
                                <label id="Label32" runat="server"><%=GetLocalResourceObject("headTireDepthAxle4")%></label>
                                <asp:TextBox ID="txtTruckDepth4R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label39" runat="server"><%=GetLocalResourceObject("headTireDepthAxle4")%></label>
                                <asp:TextBox ID="txtTruckDepth4R2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields tire5r">
                            <div class="eight wide field">
                                <label id="Label33" runat="server"><%=GetLocalResourceObject("headTireDepthAxle5")%></label>
                                <asp:TextBox ID="txtTruckDepth5R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label40" runat="server"><%=GetLocalResourceObject("headTireDepthAxle5")%></label>
                                <asp:TextBox ID="txtTruckDepth5R2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields tire6r">
                            <div class="eight wide field">
                                <label id="Label34" runat="server"><%=GetLocalResourceObject("headTireDepthAxle6")%></label>
                                <asp:TextBox ID="txtTruckDepth6R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label41" runat="server"><%=GetLocalResourceObject("headTireDepthAxle6")%></label>
                                <asp:TextBox ID="txtTruckDepth6R2" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </div>
        <div class="contentCar">
            <div class="ui form stackable two column grid ">
                <div class="four wide column">

                    <div class="itemadd-container">

                        <div class="fields tire1l" style="position: absolute; left: 50px; top: 70px; text-align: center; margin-bottom: -30% !important">
                            <div class="sixteen wide field">
                                <label id="lblTireDepth1L" runat="server"><%=GetLocalResourceObject("headTireDepthAxle1")%></label>
                                <asp:TextBox ID="txtTireDepth1L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>
                        <div class="fields tire2l" style="position: absolute; left: 50px; bottom: 150px; text-align: center; margin-bottom: -30% !important">
                            <div class="sixteen wide field">
                                <label id="lblTireDepth2L" runat="server"><%=GetLocalResourceObject("headTireDepthAxle2")%></label>
                                <asp:TextBox ID="txtTireDepth2L" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>


                    </div>

                </div>
                <div class="four wide column">
                    <div class="fields">
                        <div class="three wide field">
                        </div>
                        <div class="ten wide field">
                            <label id="lblAxleStandardDepth" runat="server"><%=GetLocalResourceObject("headTireDepthMaster")%></label>
                            <asp:TextBox ID="txtAxleStandardDepth" runat="server" CssClass="inputNumberDot" meta:resourcekey="txtAxleStandardDepthResource1"></asp:TextBox>
                        </div>
                        <div class="three wide field">
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <div class="fields">
                                &nbsp;
                            </div>
                            <%--<div style="text-align: center !important;width:100%">
                                <img src="../Images/truck_test.png"alt="picture of the vehicle">   
                                    </div>--%>
                            <img src="../Images/vehicle_test.jpg" width="100%" alt="picture of the vehicle" />
                        </div>

                    </div>




                </div>

                <div class="four wide column">

                    <div class="itemadd-container">

                        <div class="fields tire1r" style="position: absolute; top: 70px; text-align: center; margin-bottom: -30% !important">
                            <div class="sixteen wide field">
                                <label id="lblTireDepth1R" runat="server"><%=GetLocalResourceObject("headTireDepthAxle1")%></label>
                                <asp:TextBox ID="txtTireDepth1R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>
                        <div class="fields tire2r" style="position: absolute; bottom: 150px; text-align: center; margin-bottom: -30% !important">
                            <div class="sixteen wide field">
                                <label id="lblTireDepth2R" runat="server"><%=GetLocalResourceObject("headTireDepthAxle2")%></label>
                                <asp:TextBox ID="txtTireDepth2R" runat="server" CssClass="inputNumberDot" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>


                    </div>

                </div>

            </div>



        </div>
        <div class="actions">

            <div class="ui blue button" id="btnErrorSpareListPrint">
                <i class="print icon left"></i>
                Skriv ut
      
            </div>
            <div class="ui positive right labeled icon button" id="btnErrorSpareListOK">
                OK
      <i class="checkmark icon"></i>
            </div>
        </div>
    </div>

    <div class="ui modal" style="margin-top: 20%" id="importBarcodeSpares">
        <i class="close icon"></i>
        <div class="header">
            Velg fil som skal oppdatere den åpne tellelisten.
        </div>
        <div class="content">
            <label id="lblFileUpdate2" runat="server">Last opp fil fra strekkodeleser.</label>
            <input type="file" id="fileUpload3" style="height: 60%" value="C:\Temp\Scan.txt" />

        </div>
        <div class="actions">
            <div class="ui black button" id="btnImportBarcodeSpares">
                Les inn
      <i class="upload icon left"></i>
            </div>
        </div>
    </div>

    <%-- Currency Code Modal --%>
    <div id="modListCustVehicles" class="modal hidden" style="top:35vh">
        <div class="modHeader">
            <h2 id="H7" runat="server">Vehicle list</h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Currency code</label>
                    <div class="ui small info message">
                        <p id="lblInfoCustVehicles" runat="server">Velg en av kundens kjøretøy for å legge til</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="sixteen wide field">
                                <label id="Label10" runat="server">Kred.kort type</label>
                                <select id="drpListCustVehicle" runat="server" size="10" class="wide dropdownList"></select>

                            </div>
                            
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnFetchVehicle" runat="server" class="ui btn wide" value="Legg til" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnFetchVehicleCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <div class="ui fullscreen modal" id="modTirePackageSelection">
        <i class="close icon"></i>
        <a class="ui red ribbon label" id="redRibbonTPmodal"></a>
        <div class="header">
            <div class="ui three top attached steps">
                <div class="active step" id="step_one">
                    <i class="dollar sign icon"></i>
                    <div class="content">
                        <div class="title">Utvalg</div>
                        <div class="description">Liste over de som kommer opp i utvalget</div>
                    </div>
                </div>
                <div class="disabled step" id="step_two">
                    <i class="pencil icon"></i>
                    <div class="content">
                        <div class="title">Edit message</div>
                        <div class="description">Skriv og editer det du ønsker at dkal bli sendt</div>
                    </div>
                </div>
                <div class="disabled step" id="step_three">
                    <i class="close alternate icon"></i>
                    <div class="content">
                        <div class="title">Meldinger sendt</div>
                        <div class="description">Bekreftelse på at alt er sendt.</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ui blue top medium header center aligned" style="text-align: center;">Utvalg</div>
        <div class="content">
            <div class="modal_step_one">


                <div class="ui form ">

                    <div class="ui grid">

                        <div class="sixteen wide column">
                            <div class="ui form">
                                <div id="tpselection-table" class="mytabulatorclass"></div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="modal_step_two">


                <div class="ui form ">

                    <div class="ui grid">
                        <div class="two wide column"></div>
                        <div class="twelve wide column">
                            <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                <h3 id="H6" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">SMS Melding</h3>
                                <div class="ui form ">
                                    <div class="fields">
                                        <div class="six wide field">
                                            <asp:Label ID="lblName" Text="Name" runat="server" CssClass="centerlabel"></asp:Label>
                                            <asp:TextBox ID="txtName" runat="server" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="one wide field">
                                            <%--<asp:Label ID="Label17" Text="Name" runat="server" CssClass="centerlabel"></asp:Label>--%>
                                            <asp:TextBox ID="TextBox8" runat="server" CssClass="carsInput" Visible="false"></asp:TextBox>
                                        </div>
                                        <div class="six wide field">
                                            <label>&nbsp;</label>
                                            <div class="ui form">
                                                <div class="inline field">
                                                    <div class="ui radio checkbox">
                                                        <input type="radio" id="rbSendSMS" name="frequency" checked="checked" />
                                                        <label>Send SMS</label>
                                                    </div>
                                                    <div class="ui radio checkbox">
                                                        <input type="radio" id="rbSendEmail" name="frequency" />
                                                        <label>Send Epost</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="fields">
                                        <div class="four wide field">
                                            <asp:Label ID="lblMobile" Text="Mobile" runat="server" CssClass="centerlabel"></asp:Label>
                                            <asp:TextBox ID="txtMobile" runat="server" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="eight wide field">
                                            <asp:Label ID="lblEmail" Text="Email" runat="server" CssClass="centerlabel"></asp:Label>
                                            <asp:TextBox ID="txtEmail" runat="server" disabled="true" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="fields">
                                        <div class="seven wide field">
                                            <asp:Label ID="lblSMSTexts" Text="SMS Texts" runat="server" CssClass="centerlabel"></asp:Label>
                                            <select id="optSMSText" class="carsInput" runat="server">
                                            </select>
                                        </div>
                                        <div class="two wide field">
                                            <%--<asp:Label ID="Label11" Text="&nbsp;" runat="server"></asp:Label>--%>
                                            <label>&nbsp</label>
                                            <input type="button" value="Edit" id="btnEditSMSText" class="ui button carsButtonBlueInverted" runat="server" />
                                        </div>
                                    </div>
                                    <div class="fields">
                                        <div class="twelve wide field">
                                            <asp:Label ID="lblSubject" Text="Subject" runat="server" CssClass="centerlabel"></asp:Label>
                                            <asp:TextBox ID="txtSubject" runat="server" disabled="true" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="fields">
                                        <div class="twelve wide field">
                                            <div class="inline fields" style="margin: 0em 0em 0em !important">
                                                <div class="four wide field">
                                                    <asp:Label ID="lblSMSText" Text="SMS text" runat="server" CssClass="centerlabel"></asp:Label>
                                                </div>
                                                <div class="six wide field">
                                                    <asp:Label ID="Label111" Text="Antall tegn / meldinger:" runat="server" CssClass="centerlabel"></asp:Label>
                                                </div>
                                                <div class="six wide field">
                                                    <asp:Label ID="lblCountingText" Text="" runat="server" CssClass="centerlabel"></asp:Label>
                                                </div>
                                            </div>
                                            <asp:TextBox ID="txtSMSText" runat="server" CssClass="carsInput" Height="100px" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                    <%--</div>--%>
                                    <div class="fields">
                                        <div class="four wide field">
                                            <asp:Label ID="lblSendDate" Text="Send date" runat="server" CssClass="centerlabel"></asp:Label>
                                            <asp:TextBox ID="txtSendDate" runat="server" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="two wide field">
                                            <asp:Label ID="lblTimeToSend" Text="Time" runat="server" CssClass="centerlabel"></asp:Label>
                                            <select id="optTimeToSend" class="carsInput" runat="server">
                                                <option value="-1">--Velg--</option>
                                                <option value="0">00:00</option>
                                                <option value="1">00:30</option>
                                                <option value="2">01:00</option>
                                                <option value="3">01:30</option>
                                                <option value="4">02:00</option>
                                                <option value="5">02:30</option>
                                                <option value="6">03:00</option>
                                                <option value="7">03:30</option>
                                                <option value="8">04:00</option>
                                                <option value="9">04:30</option>
                                                <option value="10">05:00</option>
                                                <option value="11">05:30</option>
                                                <option value="12">06:00</option>
                                                <option value="13">06:30</option>
                                                <option value="14">07:00</option>
                                                <option value="15">07:30</option>
                                                <option value="16">08:00</option>
                                                <option value="17">08:30</option>
                                                <option value="18">09:00</option>
                                                <option value="19">09:30</option>
                                                <option value="20">10:00</option>
                                                <option value="21">10:30</option>
                                                <option value="22">11:00</option>
                                                <option value="23">11:30</option>
                                                <option value="24">12:00</option>
                                                <option value="25">12:30</option>
                                                <option value="26">13:00</option>
                                                <option value="27">13:30</option>
                                                <option value="28">14:00</option>
                                                <option value="29">14:30</option>
                                                <option value="30">15:00</option>
                                                <option value="31">15:30</option>
                                                <option value="32">16:00</option>
                                                <option value="33">16:30</option>
                                                <option value="34">17:00</option>
                                                <option value="35">17:30</option>
                                                <option value="36">18:00</option>
                                                <option value="37">18:30</option>
                                                <option value="38">19:00</option>
                                                <option value="39">19:30</option>
                                                <option value="40">20:00</option>
                                                <option value="41">20:30</option>
                                                <option value="42">21:00</option>
                                                <option value="43">21:30</option>
                                                <option value="44">22:00</option>
                                                <option value="45">22:30</option>
                                                <option value="46">23:00</option>
                                                <option value="47">23:30</option>

                                            </select>
                                        </div>
                                        <div class="two wide field">
                                        </div>
                                        <div class="four wide field">
                                            <%--<asp:Label ID="Label16" Text="blank" runat="server" CssClass="blanklabel"></asp:Label>--%>
                                            <label>&nbsp;</label>
                                            <input type="button" value="Send melding" id="btnSendMessage" class="ui button carsButtonBlueInverted wide hidden" />
                                        </div>
                                    </div>
                                </div>
                                <div class="eight wide column">
                                    <div class="ui form ">
                                        <div class="twelve wide field">
                                            <asp:Label ID="lblStatus" Text="Status" runat="server" CssClass="centerlabel"></asp:Label>
                                            <asp:TextBox ID="txtStatus" runat="server" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="two wide column"></div>
                    </div>

                </div>
            </div>
                        <div class="modal_step_three">


                <div class="ui form ">

                    <div class="ui grid">
                        <div class="two wide column">SMS are sent correctly!</div>
                        </div>
                    </div>
            </div>
            </div>
            <div class="actions">
                <div class="ui grey enabled right labeled icon left floated  button" id="btnDownloadCSV">
                    Eksporter
                <i class="file outline icon"></i>
                </div>

                <div class="ui grey enabled right labeled icon left floated button" id="btnDownloadPDF">
                    PDF
                <i class="file pdf icon"></i>
                </div>
                 <div class="ui blue enabled right labeled icon left floated button" id="btnPrintReport">
                    Skriv ut
                <i class="print icon"></i>
                </div>


                <div class="ui black right labeled icon button" id="modal_previous">
                    <div>Tilbake</div>
                    <i class="chevron left icon"></i>
                </div>

                <div class="ui yellow enabled right labeled icon button" id="tpSelectionSendSms">
                    Send sms 
                <i class="retweet icon"></i>
                </div>


                <div class="ui green enabled right labeled icon button" id="modal_next">
                    <div>Neste</div>
                    <i class="chevron right icon"></i>

                </div>



                <div class="ui negative cross labeled icon button" id="modal_close">
                    <div>Lukk</div>
                    <i class="chevron right icon"></i>

                </div>
            </div>
        
    </div>




    <dx:ASPxCallback ID="cbTransferOrder" ClientInstanceName="cbTransferOrder" OnCallback="cbTransferOrder_Callback" ClientSideEvents-EndCallback="cbTransferOrderEndCallback" runat="server"></dx:ASPxCallback>

    <div class="ui modal" style="margin-top:20%" id="modTransferOrder">
        <i class="close icon" id="modTransferOrderClose"></i>
        <div class="header">
            <%=GetLocalResourceObject("hdrTransferOrder")%>
        </div>
        <div>
            <dx:ASPxRadioButtonList ID="rbOrdersMenu" Font-Size="Small" OnInit="rbOrdersMenu_Init" Height="150px" runat="server" ClientInstanceName="rbOrdersMenu"></dx:ASPxRadioButtonList>
        </div>
        <div class="actions">

            <div class="ui left labeled icon button" id="btnCloseTransfer">
                <i class="chevron left icon"></i>
                <%=GetLocalResourceObject("btnClose")%>
      
            </div>
            <div class="ui positive right labeled icon button" id="btnOkTransfer">
                <%=GetLocalResourceObject("btnOk")%>
      <i class="checkmark icon"></i>
            </div>
        </div>
    </div>

    <%-- Modal for editing and creating new texts --%>
                    <div id="modSMSTexts" class="ui modal">
                        <div class="header">
                            <h2>Edit SMS Text</h2>
                        </div>
                        <div class="image content">
                            <div class="image">
                                <i class="warning icon"></i>
                            </div>
                            <div class="description">
                                <label id="editTextValue" class="hidden">&nbsp;</label>
                                <p>
                                    <asp:Label runat="server" ID="Label11" meta:resourcekey="CustomerLock1Resource1" Text="Rediger den valgte teksten fra SMS Tekster"></asp:Label>
                                </p>
                                <asp:TextBox ID="txtEditSMSText" runat="server" CssClass="carsInput" TextMode="multiline" Height="8em" Width="400px"></asp:TextBox>
                            </div>
                        </div>
                        <div class="actions">
                            <div class="ui button ok positive" runat="server" id="btnEditSMSSave">Lagre</div>
                            <div class="ui button yellow" id="btnEditSMSNew" runat="server">Ny tekst</div>
                            <div class="ui button cancel negative" runat="server" id="btnEditSMSCancel">Avbryt</div>
                        </div>
                    </div>


    <dx:ASPxCallbackPanel ID="cbTireDelivery" ClientInstanceName="cbTireDelivery" runat="server" OnCallback="cbTireDelivery_Callback" ClientSideEvents-EndCallback="OnTireDeliveryEndCallBack">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <dx:ASPxPopupControl ID="popupTireDeliveryReport" runat="server" ClientInstanceName="popupTireDeliveryReport" AllowDragging="true" Modal="True" Theme="iOS" CloseAction="CloseButton">
                        <Windows>
                            <dx:PopupWindow ContentUrl="ReportViewer_Transaction.aspx" HeaderText="Tire Delivery" Name="report"
                                                Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                            </dx:PopupWindow>
                        </Windows>
                    </dx:ASPxPopupControl>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

    <dx:ASPxCallbackPanel ID="cbTPSelection" ClientInstanceName="cbTPSelection" runat="server" OnCallback="cbTPSelection_Callback" ClientSideEvents-EndCallback="OnTPSelectionEndCallBack">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <dx:ASPxPopupControl ID="popupTPSelectionReport" runat="server" ClientInstanceName="popupTPSelectionReport" AllowDragging="true" Modal="True" Theme="iOS" CloseAction="CloseButton">
                        <Windows>
                            <dx:PopupWindow ContentUrl="ReportViewer_Transaction.aspx" HeaderText="Dekkhotell utvalg" Name="report"
                                                Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                            </dx:PopupWindow>
                        </Windows>
                    </dx:ASPxPopupControl>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>



</asp:Content>



