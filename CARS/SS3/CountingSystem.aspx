<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="CountingSystem.aspx.vb" Inherits="CARS.CountingSystem" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/2.3.2/jspdf.plugin.autotable.js"></script>
    <script type="text/javascript">
        var departmentID = '';    //global variable in this file
        var warehouseID = '';     //global variable in this file
        var tabcounter = 0;
        var closed = 0;
        var closedCheckbox = 0;
        var _loginName;
        var errorSpareList = [];
        var line = 0;
        var items = [];
        $(document).ready(function () {
            /*
                This method is called when the page is loaded to initialise different things
            */
          
            loadInit();

            function loadInit() {
                setTab('CountingList');

                getDepartmentID();
                getWarehouseID();
                getLoginName();
                getUsers();

              
                    var now = new Date();
                    var month = (now.getMonth() + 1);
                    var day = now.getDate();
                    if (month < 10)
                        month = "0" + month;
                    if (day < 10)
                        day = "0" + day;
                    var today = now.getFullYear() + '-' + month + '-' + day;
                    $("#<%=browserDate.ClientID%>").attr("min", today);
                    //$("#<%=browserDate.ClientID%>").attr("value", today);
               

            }

            /* HOW TO AVOID GLOBALS:
            https://www.w3.org/wiki/JavaScript_best_practices#Avoid_globals
            globals are bad. So all our global variables should be encapsulated in this "namespace". Here we can change and retrieve values with getters and setters

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
                    $("#CL-table").tabulator("redraw", true);

                }


                tabcounter++;

            }
            //tabs with class .ctab have this onclick func that calls setTab for switching tabs
            $('.cTab').on('click', function (e) {
                setTab($(this));
            });

            function getCLnumber() {
                console.log("inside getclnumber");
                console.log(departmentID + " " + warehouseID);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/GenerateCLnumber",
                    data: "{deptID:'" + departmentID + "',warehouseID:'" + warehouseID + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        {
                            if (data.d.length != 0) {
                                $('#<%=lblSerNumPrefix.ClientID%>').text(data.d[0])
                                $('#<%=lblSerNum.ClientID%>').text(data.d[1]);
                                $('#pomodal_details_ponumber').text(data.d[0] + ' ' + data.d[1]);

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

            function getUsers() {
             $.ajax({
                    type: "POST",
                    url: "CountingSystem.aspx/LoadUsers",
                    data: "{deptID:'" + departmentID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpSignatureList.ClientID%>').empty();
                        $('#<%=drpSignatureList.ClientID%>').prepend("<option value='0'>-- VELG SIGNATUR --</option>");
                        $('#<%=drpSignatureEdit.ClientID%>').empty();
                        $('#<%=drpSignatureEdit.ClientID%>').prepend("<option value='0'>-- VELG SIGNATUR --</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpSignatureList.ClientID%>').append($("<option></option>").val(value.ID_LOGIN).html(value.FIRST_NAME + " " + value.LAST_NAME));
                            $('#<%=drpSignatureEdit.ClientID%>').append($("<option></option>").val(value.ID_LOGIN).html(value.FIRST_NAME + " " + value.LAST_NAME));

                             });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function setCLnumber() {
                console.log("inside getclnumber");
                console.log(departmentID + " " + warehouseID);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/setCLnumber",
                    data: "{deptID:'" + departmentID + "',warehouseID:'" + warehouseID + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        {

                            var newListNo = 0;
                            newListNo = $('#<%=lblSerNum.ClientID%>').text();
                            //alert(newListNo);


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
                //console.log("inside getware");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/LoadWarehouseDetails",
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
                    url: "CountingSystem.aspx/FetchCurrentDepartment",
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

            function loadCLtable() {
                var today = $.datepicker.formatDate('dd.mm.yy', new Date());
                $('#<%=lblOrderDate.ClientID%>').text(today);

                var dateFrom;
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
                }
                $("#CL-table").tabulator("setData", "CountingSystem.aspx/Fetch_CL_No", { 'supplier': $("#<%=txtCLSupplier.ClientID%>").val(), 'wh': warehouseID, 'countingNo': $("#<%=txtbxCLnumbersearch.ClientID%>").val(), 'closed': closed, 'dateFrom': dateFrom, 'dateTo': dateTo, 'spareNo': $("#<%=txtCLSpare.ClientID%>").val()});
                $("#CL-table").tabulator("redraw", true);
            }

            $("#<%=btnCreateCountingList.ClientID%>").on('click', function (e) {
                    getCLnumber();
                    myNameSpace.set("po_modal_state", 1);
                    initFirstModalStepView();
                    $('#modal_cl_steps').modal('show');
                    var stock;
                    var noLocation;
                    if ($('#<%=chkCreateStockOnly.ClientID%>').is(':checked')) {
                        stock = '1';
                    }
                    else {
                        stock = '0';
                    }
                    if ($('#<%=chkCreateNoLocation.ClientID%>').is(':checked')) {
                        noLocation = '1';
                    }
                    else {
                        noLocation = '0';
                    }
                    var rblist = $("#<%=rblCreateSortBy.ClientID%>").find('input[type=radio]:checked').val()
                    //alert(rblist);

                    var stock
                    $("#counting-table-modal").tabulator("setData", "CountingSystem.aspx/Fetch_CL_Items", {'supplier': $("#<%=txtCreateSupplier.ClientID%>").val(), 'wh': warehouseID, 'sparefrom': $("#<%=txtCreateFromSpare.ClientID%>").val(), 'spareto': $("#<%=txtCreateToSpare.ClientID%>").val(), 'locfrom': $("#<%=txtCreateFromLocation.ClientID%>").val(), 'locto': $("#<%=txtCreateToLocation.ClientID%>").val(), 'stock': stock, 'nolocation': noLocation, 'sortby': rblist});
                $("#counting-table-modal").tabulator("redraw", true);
                $('#modal_cl_steps').modal('refresh');

                
            });



            $("#<%=searchbutton.ClientID%>").on('click', function (e) {
                var dateFrom;
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
                }
                $("#CL-table").tabulator("setData", "CountingSystem.aspx/Fetch_CL_No", {'supplier': $("#<%=txtCLSupplier.ClientID%>").val(), 'wh': warehouseID, 'countingNo': $("#<%=txtbxCLnumbersearch.ClientID%>").val(), 'closed': closedCheckbox, 'dateFrom': dateFrom, 'dateTo': dateTo, 'spareNo': $("#<%=txtCLSpare.ClientID%>").val()});
                $("#CL-table").tabulator("redraw", true);
                //$("#CL-table").transition("vertical flip");


            });
            $("#<%=txtbxCLnumbersearch.ClientID%>").on('blur', function (e) {

                if ($("#<%=txtbxCLnumbersearch.ClientID%>").val() != '') {
                    $("#<%=txtCLSupplier.ClientID%>").prop('disabled', true);
                     $("#<%=txtCLSpare.ClientID%>").prop('disabled', true);
                 }
                 else {
                     $("#<%=txtCLSupplier.ClientID%>").prop('disabled', false);
                     $("#<%=txtCLSpare.ClientID%>").prop('disabled', false);
                 }



            });

            $("#<%=txtCLSupplier.ClientID%>, #<%=txtCLSpare.ClientID%>").on('blur', function (e) {

                if ($("#<%=txtCLSupplier.ClientID%>").val() != '' || $("#<%=txtCLSpare.ClientID%>").val() != '') {
                    $("#<%=txtbxCLnumbersearch.ClientID%>").prop('disabled', true);
                 }
                 else {
                     $("#<%=txtbxCLnumbersearch.ClientID%>").prop('disabled', false);
                 }



            });

            $("#<%=chkSearchClosed.ClientID%>").on('click', function (e) {


                if ($("#<%=chkSearchClosed.ClientID%>").is(':checked')) {
                   
                   $("#<%=chkSearchClosed.ClientID%>").prop('checked', true);
                    closedCheckbox = true;
                }

                else {
                  
                    $("#<%=chkSearchClosed.ClientID%>").prop('checked', false);
                    closedCheckbox = false;
                }

           });




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
                dateFormat: "dd.mm.yy",
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
                dateFormat: "dd.mm.yy",
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

            
            $('#<%=txtCreateFromDate.ClientID%>').datepicker({
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



            $('#<%=txtbxCLnumbersearch.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "CountingSystem.aspx/FetchCountingList",
                        data: "{'CLNo': '" + $('#<%=txtbxCLnumbersearch.ClientID%>').val() + "',wh:'" + warehouseID + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Ingen treff på bestillingsnummer', value: '0', val: 'new' }]);
                                $("#<%=txtCLSupplier.ClientID%>").prop('disabled', false);
                                $("#<%=txtCLSpare.ClientID%>").prop('disabled', false);

                            }
                            else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.COUNTING_PREFIX + item.COUNTING_NO + " - " + item.SUP_NAME,
                                        val: item.COUNTING_PREFIX,
                                        value: item.COUNTING_PREFIX + item.COUNTING_NO,
                                        clprefix: item.COUNTING_PREFIX,
                                        clno: item.COUNTING_NO

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
                        alert(i.item.clprefix + i.item.clno);
                        $('#<%=txtbxCLnumbersearch.ClientID%>').val(i.item.clprefix + i.item.clno); //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory

                        //loadCategory();
                    }
                    else {
                        alert(i.item.clprefix);
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?

                    }


                }

            });




            //autocomplete for listing of the supplier


            $('#<%=txtCLSupplier.ClientID%>').autocomplete({
                
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#<%=txtCLSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#<%=txtCLSupplier.ClientID%>').val());

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {

                                response([{ label: 'Fant ingen treff på leverandør', value: '', val: 'new' }]);

                            }
                            else

                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_SUPPLIER_ITEM + " - " + item.SUP_Name + " - " + item.SUPP_CURRENTNO,
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

                        $('#<%=txtCLSupplier.ClientID%>').val(i.item.value);


                        // $('#txtbxSpareNum').prop("disabled", false);
                        //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory
                        //loadCategory();
                    }
                    else {

                        $('#<%=txtCLSupplier.ClientID%>').val('');
                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }

                },


            });

            $('#<%=txtCreateSupplier.ClientID%>').autocomplete({

                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#<%=txtCreateSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#<%=txtCreateSupplier.ClientID%>').val());

                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Fant ingen treff på leverandør', value: '', val: 'new' }]);
                            }
                            else

                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_SUPPLIER_ITEM + " - " + item.SUP_Name + " - " + item.SUPP_CURRENTNO,
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
                        $('#<%=txtCreateSupplier.ClientID%>').val(i.item.value);
                        $('#<%=txtCreateSupplierName.ClientID%>').val(i.item.supName);

                    }
                    else {
                        e.preventDefault(); //prevents default behaviour which is setting input to something else
                        $('#<%=txtCLSupplier.ClientID%>').val('');
                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }

                },


            });



            $('#<%=txtCLSupplier.ClientID%>').on('keyup', function () {

                var rows = $("#item-table").tabulator("getRows");
                // $('#TextBox1').val("");
                $('#txtbxSpareNum').val("");
                if (rows.length > 0) {
                    if (confirm('Endre leverandør? Dette vil medføre at alle varer som er lagt til på ordren fjernes')) {

                        for (i = 0; i < rows.length; i++) {
                            rows[i].delete();

                        }
                        items.length = 0; //clearing the items array is crucial
                    }
                }


            });

            $('#txtbxSpareNum').on('keyup', function () {

                if ($('#txtbxSpareNum').val() == "") {
                    // $('#TextBox1').val("");
                }
            });









            $('#<%=txtCLSpare.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search_Short",
                        data: "{q:'" + $('#<%=txtCLSpare.ClientID%>').val() + "', 'supp': '" + $('#<%=txtCLSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            console.log($('#<%=txtCLSpare.ClientID%>').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager', value: $('#<%=txtCLSpare.ClientID%>').val(), val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
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

                        $('#<%=txtCLSpare.ClientID%>').val(i.item.value);
                        $('#<%=txtCLSupplier.ClientID%>').val(i.item.make);

                    }
                    else {


                    }

                }
            });

            $('#<%=txtCreateFromSpare.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search_Short",
                        data: "{q:'" + $('#<%=txtCreateFromSpare.ClientID%>').val() + "', 'supp': '" + $('#<%=txtCLSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            console.log($('#<%=txtCreateFromSpare.ClientID%>').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager', value: $('#<%=txtCreateFromSpare.ClientID%>').val(), val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
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

                        $('#<%=txtCreateFromSpare.ClientID%>').val(i.item.value);

                    }
                    else {


                    }

                }
            });
            $('#<%=txtCreateToSpare.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search_Short",
                        data: "{q:'" + $('#<%=txtCreateToSpare.ClientID%>').val() + "', 'supp': '" + $('#<%=txtCLSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            console.log($('#<%=txtCreateToSpare.ClientID%>').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager', value: $('#<%=txtCreateToSpare.ClientID%>').val(), val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
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

                        $('#<%=txtCreateToSpare.ClientID%>').val(i.item.value);

                    }
                    else {


                    }

                }
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
                selector: '#CL-table .tabulator-selected',   //only trigger contextmenu on selected rows in table
                items: {
                    open: {
                        name: "Åpne telleliste",
                        icon: "paste",
                        callback: function (key, opt) {
                            openModalCLInfo(); //opens modal and shows information about the items on this order


                        }
                    },


                    deletePO: {
                        name: "Slett telleliste",
                        icon: "delete",
                        callback: function (key, opt) {
                            if (confirm("Er du sikker på at du veil slette tellelisten?")) {

                                var rows = $("#CL-table").tabulator("getSelectedRows");
                                var row = rows[0];
                                //alert(row.getData().CLOSED);
                                if (row.getData().CLOSED == 'False') {
                                    console.log(row);
                                    deleteCountingList(row);
                                    row.delete();

                                }
                                else {
                                    systemMSG('error', 'Telleliste er godkjent og kan ikke slettes!', 5000);

                                }
                            }

                        },
                        disabled: function (key, opt) {
                            var rows = $("#CL-table").tabulator("getSelectedRows");
                            var row = rows[0];

                            if (row.getCell("CLOSED").getValue() == 'True') {
                                return true;
                            }
                            else {
                                return false;
                            }

                        }
                    },

                }
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
                        alert("Ordretype mangler");
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




            //$('#btnErrorSpareListPrint').on('click', function (e) {
            //    $("#error-table-modal").tabulator("download", "csv", "data.csv");
            //});

            $('#btnErrorSpareListPrint').on('click', function (e) {
                e.preventDefault();
                $("#error-table-modal").tabulator("download", "pdf", "data.pdf", {
                    orientation: "portrait", //set page orientation to portrait
                    title: "Varer ikke på lager", //add title to report
                    autoTable: { //advanced table styling

                        styles: {
                            fillColor: [175, 200, 245]
                        },
                        columnStyles: {
                            id: { fillColor: 255 }
                        },
                        margin: { top: 60 },
                    },

                });
            });








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
                    var modby = row.getCell("COUNTED_BY");
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


            $("#CL-table").tabulator({
                height: 510, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                responsiveLayout: true,
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string
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

                    var selectedRows = $("#CL-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        if (row.getData().COUNTING_NO == selectedRows[0].getData().COUNTING_NO) {
                            return false;
                        }
                    }


                    return true; //alow selection of rows where the age is greater than 18
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    openModalCLInfo();
                    //$("#counting-table-edit-modal").tabulator("setData", "CountingSystem.aspx/Fetch_CL_Items", "{'supplier': '" + $("#<%=txtCreateSupplier.ClientID%>").val() + "', 'wh': '" + warehouseID + "'}");
                        //$("#counting-table-modal").tabulator("redraw", true);

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
                        { title: "Telleprefix.", field: "COUNTING_PREFIX", align: "center", headerFilter: "input"},
                        { title: "Tellenr.", field: "COUNTING_NO", align: "center", headerFilter: "input" },
                        { title: "Dato.", field: "DT_CREATED", align: "center", headerFilter: "input" },
                        { title: "Sign", field: "CREATED_BY", align: "center", headerFilter: "input" },
                        { title: "Leverandør", field: "SUP_NAME", align: "center", headerFilter: "input" },
                        { title: "Endringer", field: "DIFFERENCE", align: "center", headerFilter: "input" },
                        { title: "Sperret", field: "CLOSED", align: "center", formatter: "tickCross", headerFilter: "input" },

                    ],
                    footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]

                });


            $("#counting-table-modal").tabulator({
                height: 510, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                responsiveLayout: true,
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string
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





                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component

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
                    { title: "Linjenr.", field: "LINE_NO", width: 100, align: "center", visible: false},
                    { title: "Varenr.", field: "ID_ITEM", align: "center" },
                    { title: "Betegnelse", field: "ITEM_DESC", align: "center" },
                    { title: "Leverandør", field: "SUPP_CURRENTNO", align: "center" },
                    { title: "Lokasjon", field: "LOCATION", align: "center"},
                    { title: "Sist talt", field: "LAST_COUNTED_DATE", sorter: "date", align: "center"},
                    { title: "Signatur", field: "CREATED_BY", align: "center"},
                    { title: "Gl. beh.", field: "STOCKBEFORECOUNT", sorter: "number", align: "center" },
                     { title: "Endring", field: "ADJUSTMENT", sorter: "number", align: "center"},
                      { title: "Ny beh.", field: "STOCKAFTERCOUNT", sorter: "number", align: "center"},
                       { title: "Oppdatert.", field: "DT_MODIFIED", sorter: "date", align: "center"},
                        { title: "Sign.", field: "MODIFIED_BY", align: "center"},
                        { title: "ITEM_CATG", field: "ID_ITEM_CATG", visible: false },
                        { title: "Avg. price", field: "AVG_PRICE", visible: false },
                        { title: "selling price", field: "ITEM_PRICE", visible: false },
                        { title: "cost_price", field: "COST_PRICE1", visible: false },

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]

            });

            $("#counting-table-edit-modal").tabulator({
                height: 510, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                responsiveLayout: true,
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string
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
                renderComplete: function () {
                    //var firstRow;

                    //var rows = $("#counting-table-edit-modal").tabulator("getRows");
                    //console.log('2nd step!!');
                    //console.log(rows);
                    //firstRow = rows[0];
                    //var cell = firstRow.getCell("STOCKAFTERCOUNT");
                    //var cellElement = cell.getElement();
                    //console.log(cellElement);
                    //$(cellElement).focus();
                },
                selectableCheck: function (row) {


                },
                downloadDataFormatter:function(data){
                    //data - active table data array
                    console.log(data)
                    
                    for (i = 0; i < data.length; i++) {
                        data[i].STOCKAFTERCOUNT = "";
                    }
                    //change data

                    //return data for download
                    return data;
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component

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
                    { title: "Linjenr.", field: "LINE_NO", width: 100, align: "center", visible: false },
                    { title: "Varenr.", field: "ID_ITEM", align: "center" },
                    { title: "Betegnelse", field: "ITEM_DESC", align: "center" },
                     { title: "Leverandør", field: "SUPP_CURRENTNO", align: "center" },
                    { title: "Lokasjon", field: "LOCATION", align: "center" },
                    { title: "Sist talt", field: "LAST_COUNTED_DATE", sorter: "date", align: "center"},
                    { title: "Signatur", field: "CREATED_BY", align: "center"},
                    { title: "Gl. beh.", field: "STOCKBEFORECOUNT", sorter: "number", align: "center"},
                     { title: "Endring", field: "DIFFERENCE", sorter: "number", align: "center" },
                      { title: "Ny beh. *", field: "STOCKAFTERCOUNT", sorter: "number", align: "center", editor: customSelectEditor, cssClass: "myEditableCell" },
                       { title: "Oppdatert.", field: "DT_MODIFIED", sorter: "date", align: "center", download: false },
                        { title: "Sign.", field: "COUNTED_BY", align: "center", download: false },
                        { title: "ITEM_CATG", field: "ID_ITEM_CATG", visible: false },
                        { title: "Avg. price", field: "AVG_PRICE", visible: false },
                        { title: "selling price", field: "ITEM_PRICE", visible: false, download: true },
                        { title: "cost_price", field: "COST_PRICE1", visible: false },

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0],
                downloadReady: function (fileContents, blob) {
                    //fileContents - the unencoded contents of the file
                    //blob - the blob object for the download

                    //custom action to send blob to server could be included here

                    window.open(window.URL.createObjectURL(blob));

                    return blob; //must return a blob to proceed with the download, return false to abort download
                },


            });

            $("#counting-table-close-modal").tabulator({
                height: 510, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                responsiveLayout: true,
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string
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
                renderComplete: function () {
                    //var firstRow;

                    //var rows = $("#counting-table-edit-modal").tabulator("getRows");
                    //console.log('2nd step!!');
                    //console.log(rows);
                    //firstRow = rows[0];
                    //var cell = firstRow.getCell("STOCKAFTERCOUNT");
                    //var cellElement = cell.getElement();
                    //console.log(cellElement);
                    //$(cellElement).focus();
                },
                selectableCheck: function (row) {





                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component

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
                    { title: "Linjenr.", field: "LINE_NO", width: 100, align: "center", headerFilter: "input"},
                    { title: "Varenr.", field: "ID_ITEM", align: "center", headerFilter: "input" },
                    { title: "Betegnelse", field: "ITEM_DESC", align: "center", headerFilter: "input" },
                    { title: "Lokasjon", field: "LOCATION", align: "center", headerFilter: "input" },
                    { title: "Sist talt", field: "LAST_COUNTED_DATE", sorter: "date", align: "center", headerFilter: "input" },
                    { title: "Signatur", field: "CREATED_BY", align: "center", headerFilter: "input" },
                    { title: "Gl. beh.", field: "STOCKBEFORECOUNT", sorter: "number", align: "center", headerFilter: "input" },
                     { title: "Endring", field: "DIFFERENCE", sorter: "number", align: "center", headerFilter: "input" },
                      { title: "Ny beh.", field: "STOCKAFTERCOUNT", sorter: "number", align: "center", headerFilter: "input" },
                       { title: "Oppdatert.", field: "DT_MODIFIED", sorter: "date", align: "center", headerFilter: "input" },
                        { title: "Sign.", field: "MODIFIED_BY", align: "center", headerFilter: "input" },
                        { title: "Supplier", field: "SUPP_CURRENTNO", visible: false },
                        { title: "ITEM_CATG", field: "ID_ITEM_CATG", visible: false },
                        { title: "Avg. price", field: "AVG_PRICE", visible: false },
                        { title: "selling price", field: "ITEM_PRICE", visible: false },
                        { title: "cost_price", field: "COST_PRICE1", visible: false },

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]

            });

            $("#error-table-modal").tabulator({
                height: 310, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                responsiveLayout: true,
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string
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
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
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
                        title: "Varenummer.", field: "ID_ITEM", align: "center", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Antall.", field: "ITEM_AVAIL_QTY", align: "center" }
                 

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]

            });


            function openModalCLInfo() {



                //gets the selected row
                var selectedRows = $("#CL-table").tabulator("getSelectedRows");
                row = selectedRows[0];
                console.log(row);
                //checks if its a confirmed order and only to show the last tab in modal or if its not confirmed yet.

                var closed = row.getCell("CLOSED").getValue();
                console.log("conf is " + closed);

                if (closed === "True")   //third
                {
                    //alert('3rd step');
                    initThirdModalStepView(row);
                }

                else  //not finished, not confirmed, so we open the FIRST STEP
                {
                    //alert('2nd step');

                    initSecondModalStepView(row);
                    //var row = cell.getRow();
                    var prefix = row.getCell("COUNTING_PREFIX").getValue();
                    var clno = row.getCell("COUNTING_NO").getValue();
                    console.log(prefix + " - " + clno);
                    $('#pomodal_details_ponumber2').text(prefix + " " + clno);
                    $('#redRibbonPOmodal').text(prefix + clno);
                }
                setTimeout(function () { $('#modal_cl_steps').modal('refresh'); }, 3000);
            }

            function openSavedModalCLInfo2() {



                //gets the selected row

                //alert('2nd step');


                //var row = cell.getRow();
                var countno = $('#pomodal_details_ponumber2').text();
                var array;
                array = countno.split(" ");
                var prefix = array[0];
                var clno = array[1];

                console.log(array[0] + " - " + array[1]);
                $('#pomodal_details_ponumber2').text(prefix + " " + clno);
                $('#redRibbonPOmodal').text(prefix + clno);

                initSecondSaveModalStepView(undefined);
                var firstRow;
                var rows = $("#counting-table-edit-modal").tabulator("getRows");
                console.log(rows);

                firstRow = rows[0];
                //var cell = firstRow.getCell("STOCKAFTERCOUNT");
                //var cellElement = cell.getElement();
                //console.log(cellElement);
                //$(cellElement).focus();




            }

            //Opens the list after it is saved into the new tabulator list "counting-table-edit-modal"
            function openSavedModalCLInfo() {



                //gets the selected row

                //alert('2nd step');


                //var row = cell.getRow();
                var countno = $('#pomodal_details_ponumber2').text();
                var array;
                array = countno.split(" ");
                var prefix = array[0];
                var clno = array[1];

                console.log(array[0] + " - " + array[1]);
                $('#pomodal_details_ponumber2').text(prefix + " " + clno);
                $('#redRibbonPOmodal').text(prefix + clno);

                initSecondModalStepView(undefined);
                var firstRow;
                var rows = $("#counting-table-edit-modal").tabulator("getRows");
                console.log(rows);
                
                firstRow = rows[0];
                //var cell = firstRow.getCell("STOCKAFTERCOUNT");
                //var cellElement = cell.getElement();
                //console.log(cellElement);
                //$(cellElement).focus();




            }
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
                $("#po_modal_save").show();
                $("#po_modal_update").hide();
                $("#po_modal_previous").hide();
                $("#po_modal_next").hide();
                $('#po_modal_close').hide();
                $('#lblfileUpload2').hide();
                $("#fileUpload2").hide();
                $('#btnErrorSpareListView').hide();
                $("#btnEditImport").hide();

                myNameSpace.set("po_modal_state", 1);
                $('#modal_po_steps').modal('show');
                $('#modal_po_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
            }

            function initSecondSaveModalStepView(row) {
                //brings over various variables from grid to the modal window
                if (row != undefined) {
                    var clnumber = row.getCell("COUNTING_NO").getValue();
                    var clprefix = row.getCell("COUNTING_PREFIX").getValue();
                }
                else {
                    var countno = $('#pomodal_details_ponumber2').text();
                    var array;
                    array = countno.split(" ");
                    var clnumber = array[1];
                    var clprefix = array[0];
                }

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
                $("#po_modal_update").show();
                $("#po_modal_previous").hide();
                $("#po_modal_next").show();
                $("#btnEditImport").show();
                $('#po_modal_close').hide();
                $('#lblfileUpload2').show();
                $("#fileUpload2").show();
                $('#btnErrorSpareListView').show();
                $("#btnEditImport").show();

                myNameSpace.set("po_modal_state", 2);

                $('#modal_cl_steps').modal('show');
                //$("#counting-table-edit-modal").tabulator("redraw");

                $("#counting-table-edit-modal").tabulator("setData", "CountingSystem.aspx/Fetch_CountingListDetails", { 'CLPrefix': clprefix, 'CLNo': clnumber, 'wh': warehouseID })
                    .then(function () {
                        //run code after table has been successfuly updated
                         $("#counting-table-edit-modal").tabulator("redraw", true);
                var rows2 = $("#counting-table-edit-modal").tabulator("getRows");
                $('#<%=drpSignatureEdit.ClientID%>').val(rows2[0].getData().COUNTED_BY);
                        $("#counting-table-edit-modal").tabulator("download", "pdf", "Telleliste " + $('#pomodal_details_ponumber').text() + ".pdf", {
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
                                    doc.text("Tellenummer : " + $('#pomodal_details_ponumber').text(), 40, 40);
                                    doc.text("Dato : " + "11/1/11", 40, 80);
                                    doc.text("Bestilt av : " + $('#<%=drpSignatureEdit.ClientID%>').val(), 40, 100);
                                }

                            };
                        },
                        });
                        $('#modal_cl_steps').modal('hide');
                        setTab('CountingList');
                })
                .catch(function (error) {
                    //handle error loading data
                    swal("Finner ikke data!");
                });
               
                $('#modal_cl_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
                //$('#modal_cl_steps').modal('hide');
            }

            function initSecondModalStepView(row) {
                //brings over various variables from grid to the modal window
                if (row != undefined) {
                    var clnumber = row.getCell("COUNTING_NO").getValue();
                    var clprefix = row.getCell("COUNTING_PREFIX").getValue();
                }
                else {
                    var countno = $('#pomodal_details_ponumber2').text();
                    var array;
                    array = countno.split(" ");
                    var clnumber = array[1];
                    var clprefix = array[0];
                }

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
                $("#po_modal_update").show();
                $("#po_modal_previous").hide();
                $("#po_modal_next").show();
                $("#btnEditImport").show();
                $('#po_modal_close').hide();
                $('#lblfileUpload2').show();
                $("#fileUpload2").show();
                $('#btnErrorSpareListView').show();
                $("#btnEditImport").show();

                myNameSpace.set("po_modal_state", 2);

                $('#modal_cl_steps').modal('show');
                $('#modal_cl_steps').modal('refresh');
                //$("#counting-table-edit-modal").tabulator("redraw");

                $("#counting-table-edit-modal").tabulator("setData", "CountingSystem.aspx/Fetch_CountingListDetails", { 'CLPrefix': clprefix, 'CLNo': clnumber, 'wh': warehouseID })
                    .then(function () {
                        //run code after table has been successfuly updated
                $("#counting-table-edit-modal").tabulator("redraw", true);
                var rows2 = $("#counting-table-edit-modal").tabulator("getRows");
                
                })
                .catch(function (error) {
                    //handle error loading data
                    swal("Finner ikke data!");
                });
                
                    
                //$('#modal_cl_steps').modal('hide');
            }

            function initThirdModalStepView(row) {

                if (row != undefined) {
                    var clnumber = row.getCell("COUNTING_NO").getValue();
                    var clprefix = row.getCell("COUNTING_PREFIX").getValue();
                    $('#pomodal_details_ponumber3').text(clprefix + ' ' + clnumber);
                }
                else {
                    var countno = $('#pomodal_details_ponumber3').text();
                    var array;
                    array = countno.split(" ");
                    var clnumber = array[1];
                    var clprefix = array[0];
                }

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
                $('.viewCLClosed').removeClass('hidden');
                $('#modal_cl_steps').modal('show');
                $("#counting-table-edit-modal").tabulator("redraw");

                $("#counting-table-close-modal").tabulator("setData", "CountingSystem.aspx/Fetch_CountingListDetails", {'CLPrefix': clprefix, 'CLNo': clnumber, 'wh': warehouseID});
                $("#counting-table-close-modal").tabulator("redraw", true);
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
                $("#CL-table").tabulator("redraw", true); //trigger full rerender including all data And rows
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
                    setCLnumber();
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
                    openSavedModalCLInfo2();

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

                    var rows = $("#counting-table-edit-modal").tabulator("getRows");
                
                    for (i = 0; i < rows.length; i++) {
                        var success = updateItemToCL(rows[i]);
                        if (!success) {
                            alert("Noe gikk galt med lagring av varer på telleliste");
                        }

                    }
                    //if ($('#modal_po_confirmorder').modal('show'))    //  fix this!
                    if (confirm("Sende bestilling?")) {
                        //content divs
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
                        $("#po_modal_previous").hide();
                        $("#po_modal_cancel").hide();
                        $('#po_modal_close').hide();


                        //update state
                        myNameSpace.set("po_modal_state", 3);
                        console.log("new state: " + myNameSpace.get("po_modal_state"));
                        var ponumber = $('#pomodal_details_ponumber').text();
                        var supp_currentno = $('#pomodal_details_supplier').text();

                        //$("#item-table-modal-confirmedOrder").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", {'POnum': '" + ponumber + "', 'isDeliveryTable': '" + true + "', 'supp_currentno': '" + supp_currentno + "'}");
                    }


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

                    $("#po_modal_update").hide();
                    $('.circle-loader').toggleClass('load-complete');
                    $('.checkmarkX').toggle();
                    $('.circle-loader').addClass('hidden');
                    $('.toggle').addClass('hidden');

                    var ponumber = $('#redRibbonPOmodal').text();

                    var supp_currentno = $('#pomodal_details_supplier4').text();

                    if (myNameSpace.get("po_delivered") == "True") {
                        $("#po_modal_previous").hide();
                        //  $('.circle-loader').toggleClass('circle-loader');
                    }
                    else { $("#po_modal_previous").show(); }
                    //$("#item-table-modal-final").tabulator("setData", "PurchaseOrder.aspx/Fetch_PO_Items", "{'POnum': '" + ponumber + "', 'isDeliveryTable': '" + false + "', 'supp_currentno': '" + supp_currentno + "'}");
                    myNameSpace.set("po_modal_state_canclose", 0);
                    myNameSpace.set("po_modal_state", 4);

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
                    //for (i = 0; i < rows.length; i++) {
                    //    var success = updateItemToCL(rows[i]);
                    //    if (!success) {
                    //        alert("Noe gikk galt med lagring av varer på telleliste");
                    //    }

                    //}
                    var str = "";
                    var countingno = $('#pomodal_details_ponumber2').text();
                    var array = countingno.split(" ");
                
                    for (i = 0; i < rows.length; i++) {
                        str = str + array[0] + ";" + array[1] + ";" + rows[i].getData().ID_ITEM + ";" + rows[i].getData().SUPP_CURRENTNO + ";" + rows[i].getData().STOCKAFTERCOUNT.replace(",", ".") + ";" + rows[i].getData().STOCKBEFORECOUNT.replace(",", ".") + ";" + rows[i].getData().COST_PRICE1.replace(",", ".") + ";" + $('#<%=drpSignatureEdit.ClientID%>').val() + ";" + rows[i].getData().DIFFERENCE.replace(",", ".") + ",";
                        
                    }
                    updateItemToCL(str);
                    
                    $('#modal_cl_steps').modal('hide');
                    console.log(str);
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
                $('#pomodal_details_ponumber3').text($('#pomodal_details_ponumber2').text());
                var countingNo = $('#pomodal_details_ponumber3').text();
                var array = countingNo.split(' ');
                var clprefix = array[0];
                var clno = array[1];
                
                if (myNameSpace.get("po_modal_state") == 2)   //second step in modal
                {

                    var rows = $("#counting-table-edit-modal").tabulator("getRows");
                    var str = "";
                    var countingno = $('#pomodal_details_ponumber2').text();
                    var array = countingno.split(" ");
                
                    for (i = 0; i < rows.length; i++) {
                        str = str + array[0] + ";" + array[1] + ";" + rows[i].getData().ID_ITEM + ";" + rows[i].getData().SUPP_CURRENTNO + ";" + rows[i].getData().STOCKAFTERCOUNT.replace(",", ".") + ";" + rows[i].getData().STOCKBEFORECOUNT.replace(",", ".") + ";" + rows[i].getData().COST_PRICE1.replace(",", ".") + ";" + $('#<%=drpSignatureEdit.ClientID%>').val() + ";" + rows[i].getData().DIFFERENCE.replace(",", ".") + ",";
                        
                    }
                    updateItemToCL(str);
                }

                swal({
                    title: "Vennligst bekreft!",
                    text: "Er du sikker på at du ønsker å avslutte tellelisten og oppdatere til beholdning?",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                .then((willDelete) => {
                    if (willDelete) {
                        var rows = $("#counting-table-edit-modal").tabulator("getRows");
                        for (i = 0; i < rows.length; i++) {
                            var success = closeItemToCL(rows[i]);
                            if (!success) {
                                alert("Noe gikk galt med sperring av varer på telleliste");
                            }

                        }
                        var rows = $("#CL-table").tabulator("getRows");

                        for (i = 0; i < rows.length; i++) {
                            if (rows[i].getData().COUNTING_NO == clno && rows[i].getData().COUNTING_PREFIX == clprefix) {
                                //alert('inni sletterutine');
                                rows[i].delete();
                                break;
                            }

                        }
                        myNameSpace.set("po_modal_state", 3);
                        initThirdModalStepView(undefined);
                    } else {
                        swal("Tellelisten har kun blitt oppdatert!");
                    }
                });
                


              
                $('#modal_cl_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh


            });

            $('#po_modal_previous').on('click', function (e) {
                if (myNameSpace.get("po_modal_state") == 2)     //second step in modal
                {

                    //content divs
                    $('.modal_cl_divstep2').addClass('hidden');
                    $('.modal_cl_divstep1').removeClass('hidden');

                    //header steps

                    $("#step_cl_second").removeClass("disabled step");
                    $("#step_cl_second").removeClass("completed step");
                    $("#step_cl_second").addClass("active step");

                    //buttons
                    $("#po_modal_previous").hide();
                    $("#po_modal_import").show();
                    $("#po_modal_update").show();

                    myNameSpace.set("po_modal_state", 1);
                    console.log("new state: " + myNameSpace.get("po_modal_state"));
                }

                if (myNameSpace.get("po_modal_state") == 3)     //second step in modal
                {

                    //content divs
                    $('.modal_po_divstep4').addClass('hidden');
                    $('.modal_cl_divstep3').removeClass('hidden');

                    //header steps
                    $("#step_cl_second").removeClass("disabled step");
                    $("#step_cl_second").removeClass("completed step");
                    $("#step_cl_second").addClass("active step");

                    //buttons

                    $("#po_modal_cancel").hide();
                    $("#po_modal_update").show();
                    $('#lblfileUpload2').show();
                    $("#fileUpload2").show();
                    $('#btnErrorSpareListView').show();
                    $("#btnEditImport").show();

                    myNameSpace.set("po_modal_state", 2);
                    initSecondModalStepView(undefined);
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
                    var rows = $("#CL-table").tabulator("getRows");
                    var countingNo = $('#pomodal_details_ponumber3').text();
                    var array = countingNo.split(' ');
                    var clprefix = array[0];
                    var clno = array[1];
                    for (i = 0; i < rows.length; i++) {
                        if (rows[i].getData().COUNTING_NO == clno && rows[i].getData().COUNTING_PREFIX == clprefix) {
                            //alert('inni sletterutine');
                            rows[i].delete();
                            break;
                        }

                    }
                }

                $('#modal_cl_steps').modal('hide');


            });

            function addItemToCL(row) {


                var itemobj = createCLItemJSONstring(row);

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/Add_CL_Item",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        systemMSG('success', 'Telleliste lagret', 5000);

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Telleliste feilet ved lagring', 5000);
                    }
                });
                return succeeded

            }

            function updateItemToCL(row) {


                //var itemobj = updateCLItemJSONstring(row);

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/Update_CL_Item",
                    data: "{item:'" + row + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        systemMSG('success', 'Telleliste oppdatert', 5000);

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Telleliste feilet ved oppdatering', 5000);
                    }
                });
                return succeeded

            }

            function closeItemToCL(row) {

                var itemobj = closeCLItemJSONstring(row);
                //var countingNo = $('#pomodal_details_ponumber3').text();
                //var array = countingNo.split(' ');
                //var clprefix = array[0];
                //var clno = array[1];

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/Close_CL_Item",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        systemMSG('success', 'Telleliste er sperret og oppdatert.', 5000);

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Telleliste feilet ved sperring', 5000);
                    }
                });
                return succeeded

            }

            function deleteCountingList(row) {

                var itemobj = deleteCLItemJSONstring(row);

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/Delete_CL_Item",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        systemMSG('success', 'Telleliste er slettet!', 5000);

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Telleliste feilet ved sletting', 5000);
                    }
                });
                return succeeded

            }

            function getLoginName() {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CountingSystem.aspx/getLoginName",
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

            function createCLItemJSONstring(row) {

                var countingListItem = {};

                countingListItem["COUNTING_PREFIX"] = $('#<%=lblSerNumPrefix.ClientID%>').text();
                countingListItem["COUNTING_NO"] = $('#<%=lblSerNum.ClientID%>').text();
                countingListItem["DESCRIPTION"] = row.getData().ITEM_DESC;
                countingListItem["LINE_NO"] = row.getData().LINE_NO;
                countingListItem["ID_ITEM"] = row.getData().ID_ITEM;
                var sac = row.getData().STOCKAFTERCOUNT;
                sac = sac.replace(",", ".");
                countingListItem["STOCKAFTERCOUNT"] = sac;
                var adj = row.getData().ADJUSTMENT;
                adj = adj.replace(",", ".");
                countingListItem["ADJUSTMENT"] = adj;
                countingListItem["DIFFERENCE"] = "0.00";
                countingListItem["SUPP_CURRENTNO"] = row.getData().SUPP_CURRENTNO;
                countingListItem["ID_WH"] = warehouseID;
                var sbc = row.getData().STOCKBEFORECOUNT;
                sbc = sbc.replace(",", ".");
                countingListItem["STOCKBEFORECOUNT"] = sbc;
                var avg = row.getData().AVG_PRICE;
                avg = avg.replace(",", ".");
                countingListItem["AVG_PRICE"] = avg;
                var iprice = row.getData().ITEM_PRICE;
                iprice = iprice.replace(",", ".");
                countingListItem["ITEM_PRICE"] = iprice;
                countingListItem["AVG_PRICE"] = avg;
                var cost = row.getData().COST_PRICE1;
                cost = cost.replace(",", ".");
                countingListItem["COST_PRICE1"] = cost;
                countingListItem["LOCATION"] = row.getData().LOCATION;
                countingListItem["LAST_COUNTED_DATE"] = row.getData().LAST_COUNTED_DATE;
                countingListItem["LAST_COUNTED_DATE"] = row.getData().LAST_COUNTED_DATE;
                countingListItem["ID_ITEM_CATG"] = row.getData().ID_ITEM_CATG;
                if($('#<%=drpSignatureList.ClientID%>').val() != 0){
                    countingListItem["COUNTED_BY"] = $('#<%=drpSignatureList.ClientID%>').val();
                }
                else {
                    countingListItem["COUNTED_BY"] = _loginName;
                }
                var jsonCL = JSON.stringify(countingListItem);
                console.log(jsonCL);


                return jsonCL;
            }


            function updateCLItemJSONstring(row) {

                var countingListItem = {};
                var countingno = $('#pomodal_details_ponumber2').text();
                var array = countingno.split(" ");
                countingListItem["COUNTING_PREFIX"] = array[0];
                countingListItem["COUNTING_NO"] = array[1];
                countingListItem["DESCRIPTION"] = row.getData().ITEM_DESC;
                countingListItem["LINE_NO"] = row.getData().LINE_NO;
                countingListItem["ID_ITEM"] = row.getData().ID_ITEM;
                var sac = row.getData().STOCKAFTERCOUNT;
                sac = sac.replace(",", ".");
                countingListItem["STOCKAFTERCOUNT"] = sac;
                var diff = row.getData().DIFFERENCE;
                diff = diff.replace(",", ".");
                countingListItem["DIFFERENCE"] = diff;
                countingListItem["SUPP_CURRENTNO"] = row.getData().SUPP_CURRENTNO;
                countingListItem["ID_WH"] = warehouseID;
                var sbc = row.getData().STOCKBEFORECOUNT;
                sbc = sbc.replace(",", ".");
                countingListItem["STOCKBEFORECOUNT"] = sbc;
                var avg = row.getData().AVG_PRICE;
                avg = avg.replace(",", ".");
                countingListItem["AVG_PRICE"] = avg;
                var iprice = row.getData().ITEM_PRICE;
                iprice = iprice.replace(",", ".");
                countingListItem["ITEM_PRICE"] = iprice;
                countingListItem["AVG_PRICE"] = avg;
                var cost = row.getData().COST_PRICE1;
                cost = cost.replace(",", ".");
                countingListItem["COST_PRICE1"] = cost;
                countingListItem["LOCATION"] = row.getData().LOCATION;
                countingListItem["LAST_COUNTED_DATE"] = row.getData().LAST_COUNTED_DATE;
                countingListItem["ID_ITEM_CATG"] = row.getData().ID_ITEM_CATG;
                //var moddate = row.getData().DT_MODIFIED;
                //var datetime = moddate.split(" ");
                //var date = datetime[0].split(".");
                //var time = datetime[1].split(":")
                //moddate = date[2] + "." + date[1] + "." + date[0] + " " + time[0] + ":" + time[1] + ":" + time[2];
                countingListItem["DT_MODIFIED"] = row.getData().DT_MODIFIED;;
                if (row.getData().MODIFIED_BY != '') {
                    countingListItem["MODIFIED_BY"] = row.getData().MODIFIED_BY;
                }
                else {
                    countingListItem["MODIFIED_BY"] = _loginName
                }
                 if($('#<%=drpSignatureEdit.ClientID%>').val() != 0){
                   countingListItem["COUNTED_BY"] = $('#<%=drpSignatureEdit.ClientID%>').val();
                }
                else {
                    countingListItem["COUNTED_BY"] = _loginName;
                }
                
                var jsonCL = JSON.stringify(countingListItem);
                console.log(jsonCL);


                return jsonCL;
            }

            function closeCLItemJSONstring(row) {

                var countingListItem = {};
                var countingno = $('#pomodal_details_ponumber3').text();
                var array = countingno.split(" ");
                countingListItem["COUNTING_PREFIX"] = array[0];
                countingListItem["COUNTING_NO"] = array[1];
                countingListItem["DESCRIPTION"] = row.getData().ITEM_DESC;
                countingListItem["LINE_NO"] = row.getData().LINE_NO;
                countingListItem["ID_ITEM"] = row.getData().ID_ITEM;
                var diff = row.getData().DIFFERENCE;
                diff = diff.replace(",", ".");
                countingListItem["DIFFERENCE"] = diff;
                countingListItem["SUPP_CURRENTNO"] = row.getData().SUPP_CURRENTNO;
                countingListItem["ID_WH"] = warehouseID;
                countingListItem["LOCATION"] = row.getData().LOCATION;
                countingListItem["LAST_COUNTED_DATE"] = row.getData().LAST_COUNTED_DATE;
                countingListItem["ID_ITEM_CATG"] = row.getData().ID_ITEM_CATG;
                var sac = row.getData().STOCKAFTERCOUNT;
                sac = sac.replace(",", ".");
                countingListItem["STOCKAFTERCOUNT"] = sac;
                var sbc = row.getData().STOCKBEFORECOUNT;
                sbc = sbc.replace(",", ".");
                countingListItem["STOCKBEFORECOUNT"] = sbc;
                var dc = row.getData().DIFFERENCE;
                dc = dc.replace(",", ".");
                countingListItem["DIFFERENCE"] = dc;
                //var moddate = row.getData().DT_MODIFIED;
                //var datetime = moddate.split(" ");
                //var date = datetime[0].split(".");
                //var time = datetime[1].split(":")
                //moddate = date[2] + "." + date[1] + "." + date[0] + " " + time[0] + ":" + time[1] + ":" + time[2];
                countingListItem["DT_MODIFIED"] = row.getData().DT_MODIFIED;;
                if (row.getData().MODIFIED_BY != '') {
                    countingListItem["MODIFIED_BY"] = row.getData().MODIFIED_BY;
                }
                else {
                    countingListItem["MODIFIED_BY"] = _loginName
                }
                var jsonCL = JSON.stringify(countingListItem);
                console.log(jsonCL);


                return jsonCL;
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

            
            $("#btnErrorSpareListView").bind("click", function () {
                $('#modal_cl_steps').modal('hide');
                setTimeout(function () { $('#errorSpareListModal').modal('show'); }, 1000);
            });

            $("#<%=btnCreateCLBarscan.ClientID%>").bind("click", function () {
                $("#counting-table-modal").tabulator("clearData");
                $("#error-table-modal").tabulator("clearData");
                errorSpareList = [];
                
                 getCLnumber();
                 myNameSpace.set("po_modal_state", 1);
                 initFirstModalStepView();
                 $('#btnErrorSpareListView').show();
                //$('#modal_cl_steps')
                //   .modal({
                //       allowMultiple: true
                       //onVisible: function () {
                       //    $('#errorSpareListModal').modal('show');
                       //},
                   //});
                //$('#modal_cl_steps').modal({
                //    transition: 'fade down'
                //}).modal('show');
                 $('#modal_cl_steps').modal('show');
                
                 var stock;
                 var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
                 if (regex.test($("#fileUpload").val().toLowerCase())) {
                     if (typeof (FileReader) != "undefined") {
                         var reader = new FileReader();
                         reader.onload = function (e) {
                             var rows = e.target.result.split("\n");
                             console.log(rows);
                             console.log("rows sin lengde er: " + rows.length);
                             for (var i = 0; i < rows.length; i++) {
                                 var cells = rows[i].split(",");
                                 //console.log(cells);
                                 var spare = cells[0];
                                 //console.log(spare);
                                 var stockaftercount = cells[1];
                                 //fetchItemDetail
                                 //counting-table-modal må fylles opp med resultatene fra fetch item
                                 //alert(i);
                                 FetchItemDetails(spare, stockaftercount, line, warehouseID);


                             }
                             var z = 1;
                             //alert(errorSpareList.length);
                             if (errorSpareList.length > 0) {
                                 $("#btnErrorSpareListView").removeClass('disabled');
                                 for (var y = 0; y < errorSpareList.length; y = y + 2) {
                                     $("#error-table-modal").tabulator("addData", [{ ID_ITEM: errorSpareList[y].toString(), ITEM_AVAIL_QTY: parseInt(errorSpareList[z]) }], false, 3);
                                     z = z + 2;

                                 }
                             }
                             else {
                                 $("#btnErrorSpareListView").addClass('disabled');
                             }
                         }

                     }
                     $("#counting-table-modal").tabulator("redraw", true);
                     $("#error-table-modal").tabulator("redraw", true);
                     reader.readAsText($("#fileUpload")[0].files[0]);
                 } else {
                     alert("This browser does not support HTML5.");
                 }
                 line = 0;
                

                 //for (var i = 0; i < errorSpareList.length;i+2){

                //}
                //#btnErrorSpareListOK
                 //$('#modal_cl_steps').modal('attach events', '#errorSpareListModal');
                 $('#modal_cl_steps').modal('show');
                
                 //setTimeout(function () { $('#errorSpareListModal').modal('show'); }, 1000);
             });


            //on doing an action on errorsparelist fra om file the window is closed and main window is shown again
            $("#btnErrorSpareListOK").bind("click", function () {
                $('#errorSpareListModal').modal('hide');
                setTimeout(function () { $('#modal_cl_steps').modal('show'); }, 1000);
                $("#error-table-modal").tabulator("clearData");
                errorSpareList = [];
                $('#btnErrorSpareListView').addClass('disabled');

            });
            ////on doing an action on errorsparelist fra om file the window is closed and main window is shown again
            $("#btnErrorSpareListPrint").bind("click", function () {
                $('#errorSpareListModal').modal('hide');
                $("#error-table-modal").tabulator("clearData");
                errorSpareList = [];
                $('#btnErrorSpareListView').addClass('disabled');
                setTimeout(function () { $('#modal_cl_steps').modal('show'); }, 1000);
            });

         
            $("#btnEditPrint").bind("click", function () {
                //alert(warehouseID + " hgfhf " + _loginName + " ghfdg " + departmentID);
                var counting = "";
                if (myNameSpace.get("po_modal_state") !== 3) {
                    counting = $("#pomodal_details_ponumber2").html();
                   // alert("Du er i modal state 1 eller 2 " + myNameSpace.get("po_modal_state"));
                    getCountingReport(counting);
                   
                }
                else {
                    counting = $("#pomodal_details_ponumber3").html();
                    getCountingResult(counting);
                }
                //$('#modal_cl_steps').modal('refresh');
            });

            function FetchItemDetails(spareNo, stockaftercount, lineNo, wh) {
                $.ajax({
                    type: "POST",
                    url: "CountingSystem.aspx/FetchItemDetails",
                    data: "{spareNo: '" + spareNo + "', itemQty: '" + stockaftercount + "', wh: '" + warehouseID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //alert("stock after count is: " +stockaftercount);
                        //console.log(data.d);
                        <%--  $('#<%=txtAdvSpareSubMake.ClientID%>').val(data.d.ENV_ID_MAKE);
                        $('#<%=txtAdvSpareSubWh.ClientID%>').val(data.d.ENV_ID_WAREHOUSE);--%>
                        if (data.d[0].RETURN_VALUE == "EXSIST") {
                            //alert('the spare exist');
                            var adjustmentQty = (parseFloat(stockaftercount) - parseFloat(data.d[0].STOCKBEFORECOUNT)).toFixed(2);
                            //stockaftercount = stockaftercount.toFixed(2);
                            adjustmentQty = adjustmentQty.replace(".", ",")
                            var stockQty = parseFloat(stockaftercount).toFixed(2)
                            stockQty = stockQty.replace(".", ",");
                            //alert(stockQty);
                            line = line + 1;
                            //alert("linjenr: "+line);
                            var exist = 0;
                            var rows = $("#counting-table-modal").tabulator("getRows");
                            for (var m = 0; m < rows.length; m++) {
                                //alert(rows[m].getData().ID_ITEM);
                                if (rows[m].getData().ID_ITEM == spareNo) {
                                    var newValue = parseFloat(rows[m].getData().STOCKAFTERCOUNT) + parseFloat(stockQty);
                                    //alert(rows[m].getData().STOCKAFTERCOUNT + " er verdien");
                                    rows[m].getCell("STOCKAFTERCOUNT").setValue(newValue.toFixed(2).replace(".", ","), true);
                                    exist = 1;
                                }
                                
                            }
                            if(exist == 0){
                                $("#counting-table-modal").tabulator("addData", [{ LINE_NO: line, ID_ITEM: data.d[0].ID_ITEM, ITEM_DESC: data.d[0].ITEM_DESC, LOCATION: data.d[0].LOCATION, LAST_COUNTED_DATE: data.d[0].LAST_COUNTED_DATE, CREATED_BY: data.d[0].CREATED_BY, STOCKBEFORECOUNT: data.d[0].STOCKBEFORECOUNT, ADJUSTMENT: adjustmentQty, STOCKAFTERCOUNT: stockQty, DT_MODIFIED: data.d[0].DT_MODIFIED, MODIFIED_BY: data.d[0].MODIFIED_BY, SUPP_CURRENTNO: data.d[0].SUPP_CURRENTNO, ID_ITEM_CATG: data.d[0].ID_ITEM_CATG, AVG_PRICE: data.d[0].AVG_PRICE, ITEM_PRICE: data.d[0].ITEM_PRICE, COST_PRICE1: data.d[0].COST_PRICE1 }], false, 3); //add new data below existing row with index of 3
                            }
                        }
                        else if (data.d[0].RETURN_VALUE == "NOTEXSIST") {

                            var y = 1;
                            var x = 0;
                            //alert(spareNo);
                         
                            var value = 0;
                            if (spareNo != '') {
                                for (var n = 0; n < errorSpareList.length; n++) {
                                    var o = n + 1;
                                    if (errorSpareList[n] == spareNo) {
                                        var newValue = parseFloat(errorSpareList[o]);
                                        errorSpareList[o] = (newValue + parseFloat(stockaftercount));
                                        value = 1;

                                    }
                                }
                                if (value == 0) {
                                    //if the spare do not exist in the error list it is added to the array
                                    errorSpareList.push([spareNo], [stockaftercount]);
                                }
                            }



                        }


                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });

            };
            
          

            $("#btnEditImport").bind("click", function () {
                
                $("#error-table-modal").tabulator("clearData");
                errorSpareList = [];

                var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
                if (regex.test($("#fileUpload2").val().toLowerCase())) {
                    if (typeof (FileReader) != "undefined") {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var rows = e.target.result.split("\n");
                            console.log(rows);
                            console.log("rows sin lengde er: " + rows.length);
                            var table = $("#counting-table-edit-modal").tabulator("getRows");
                            for (var i = 0; i < rows.length; i++) {
                                var cells = rows[i].split(",");
                                console.log(cells);
                                var spare = cells[0];
                                console.log(spare);
                                var stockaftercount = cells[1];
                                var exist2 = 0;
                                for (var m = 0; m < table.length; m++) {
                                    //update existing spare in tabulator with the correct amount from stockaftercount
                                    if (table[m].getData().ID_ITEM == spare) {
                                        //alert('varen ble funnet i listen og skal oppdateres' + spare);
                                        var newValue = parseFloat(stockaftercount);
                                        //alert(newValue.toFixed(2).replace(".", ","));
                                        if (table[m].getData().DT_MODIFIED == '') {
                                            //alert('modified is set');
                                            table[m].getCell("STOCKAFTERCOUNT").setValue(newValue.toFixed(2).replace(".", ","), true);
                                            exist2 = 1;
                                            var celldate = table[m].getCell("DT_MODIFIED");
                                            var modby = table[m].getCell("COUNTED_BY");
                                            var d = new Date();
                                            var strDate = ('0' + d.getDate()).slice(-2) + "." + ('0' + (d.getMonth() + 1)).slice(-2) + "." + d.getFullYear();
                                            celldate.setValue(strDate, true);
                                            modby.setValue(_loginName);
                                        }
                                        else {
                                            //alert('modified is NOT set');
                                            var oldvalue = parseFloat(table[m].getData().STOCKAFTERCOUNT);
                                            table[m].getCell("STOCKAFTERCOUNT").setValue((oldvalue + newValue).toFixed(2).replace(".", ","), true);
                                            exist2 = 1;
                                            var celldate = table[m].getCell("DT_MODIFIED");
                                            var modby = table[m].getCell("COUNTED_BY");
                                            var d = new Date();
                                            var strDate = ('0' + d.getDate()).slice(-2) + "." + ('0' + (d.getMonth() + 1)).slice(-2) + "." + d.getFullYear();
                                            celldate.setValue(strDate, true);
                                            modby.setValue(_loginName);
                                        }
                                       
                                    }
                                }
                                if (exist2 == 0) {
                                    //if spare do not exist in the tabulator it cycles through the errorlist in case the spare is already added and update the amount there.
                                    var value = 0;
                                    if (spare != '') {
                                            for (var n = 0; n < errorSpareList.length; n++) {
                                                var o = n + 1;
                                                if (errorSpareList[n] == spare) {
                                                    var newValue = parseFloat(errorSpareList[o]);
                                                    errorSpareList[o] = (newValue + parseFloat(stockaftercount));
                                                    value = 1;

                                                }
                                        }
                                            if (value == 0) {
                                                //if the spare do not exist in the error list it is added to the array
                                                errorSpareList.push([spare], [stockaftercount]);
                                        }
                                    }
                                }
                            }
                            var z = 1;
                            //alert(errorSpareList.length);
                            if (errorSpareList.length > 0) {
                                //alert('error listen har data');
                                
                                $("#btnErrorSpareListView").removeClass('disabled');
                                for (var y = 0; y < errorSpareList.length; y = y + 2) {
                                    $("#error-table-modal").tabulator("addData", [{ ID_ITEM: errorSpareList[y].toString(), ITEM_AVAIL_QTY: parseInt(errorSpareList[z]) }], false, 3);
                                    z = z + 2;
                                }
                            }
                            else {
                                $("#btnErrorSpareListView").addClass('disabled');
                            }
                        }

                    }
                    $("#counting-table-edit-modal").tabulator("redraw", true);
                    $("#error-table-modal").tabulator("redraw", true);
                    reader.readAsText($("#fileUpload2")[0].files[0]);
                } else {
                    swal("Feil!", "Du må velge fil før du importerer data fra strekkodeleseren.", "error");
                }
                line = 0;
                

                //for (var i = 0; i < errorSpareList.length;i+2){
                systemMSG('success', 'Fil fra strekkodeleseren er behandlet ferdig!', 5000);
                //}
                //#btnErrorSpareListOK
                //$('#modal_cl_steps').modal('attach events', '#errorSpareListModal');
                //$('#errorSpareListModal').modal('show');
                $('#modal_cl_steps').modal('show');
                //setTimeout(function () { $('#counting-table-edit-modal').modal('show'); }, 1000);
            });
            

             $('#<%=chkCreateNoLocation.ClientID%>').on('click', function (e) {
                if ($('#<%=chkCreateNoLocation.ClientID%>').is(':checked')){
                   var value = "1";
                    var radio = $("[id*=<%=rblCreateSortBy.ClientID%>] input[value=" + value + "]");
                    radio.attr("checked", "checked");
                }
                else {
                    value = "3";
                      var radio = $("[id*=<%=rblCreateSortBy.ClientID%>] input[value=" + value + "]");
                    radio.attr("checked", "checked");
                 }

                
            });
            //prevent from being able to copy/paste/cut. That would break the input restriction logic.
            $('.myEditableCell').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            $('.myEditableCell').keypress(function (event) {

                alert($(this).attr('class'));
                if ($(this).attr('id') === 'txtbxSparepartModal') {
                    return (isValidNumber(event, this) && ($(this).val().length < 30));
                }
                return (isValidNumber(event, this) && ($(this).val().length < 6));
            });

            loadCLtable();
        });

        /*-------------------REPORT FUNCTIONS-----------------------------*/
        function getCountingReport(counting) {
            //alert(counting);
            var clprefix = "";
            var clno = "";
            var countinglistno = counting.split(' ');
            clprefix = countinglistno[0];
            clno = countinglistno[1];
           
            
            //alert(clprefix+clno);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "CountingSystem.aspx/FetchCountingReport",
                data: "{'clprefix':'" + clprefix + "', 'clno':'" + clno + "', 'wh':'" + warehouseID + "', 'login':'" + _loginName + "'}",
                dataType: "json",
                async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                success: function (data) {

                    console.log("success");
                    //_loginName = data.d;
                    succeeded = true;
                    $('#modal_cl_steps').modal('hide');
                    cbCountingList.PerformCallback();


                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                    systemMSG('error', 'Finner ikke bruker. Logg ut og så prøv på nytt!', 5000);
                }
            });


        }

        function getCountingResult(counting) {
            //alert(counting);
            var clprefix = "";
            var clno = "";
            var countinglistno = counting.split(' ');
            clprefix = countinglistno[0];
            clno = countinglistno[1];
            console.log(clprefix + clno);

            //alert(clprefix+clno);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "CountingSystem.aspx/FetchCountingResult",
                data: "{'clprefix':'" + clprefix + "', 'clno':'" + clno + "', 'wh':'" + warehouseID + "', 'login':'" + _loginName + "'}",
                dataType: "json",
                async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                success: function (data) {

                    console.log("success");
                    //_loginName = data.d;
                    succeeded = true;
                    $('#modal_cl_steps').modal('hide');
                    cbCountingListResult.PerformCallback();


                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                    systemMSG('error', 'Finner ikke bruker. Logg ut og så prøv på nytt!', 5000);
                }
            });


        }

        function OnCountingListEndCallBack() {
            popupCountingListReport.ShowWindow(popupCountingListReport.GetWindow(0));
        }
        function OnCountingListResultEndCallBack() {
            popupCountingListResult.ShowWindow(popupCountingListResult.GetWindow(0));
        }

        
    </script>


    <asp:HiddenField ID="hdnSelect" runat="server" />
    <div class="overlayHide">
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
    </div>
    <div id="systemMessage" class="ui message"></div>

    <div class="ui grid">
        <div id="tabFrame" class="sixteen wide column">
            <input type="button" id="btnCountingList" value="Telleliste" class="cTab ui btn" data-tab="CountingList"  meta:resourcekey="btnCountingList"/>
            <input type="button" id="btnNewCountingList" value="Ny telling" class="cTab ui btn" data-tab="NewCountingList"  meta:resourcekey="btnNewCountingList" />
        </div>
    </div>


    <%--Begin tab PurchaseOrders--%>

    <div id="tabCountingList" class="tTab">
        <div class="ui form stackable two column grid ">

            <div class="four wide column">

                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                    <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important" meta:resourcekey="headSearchCountingList"></h3>
                    <label class="inHeaderCheckbox" meta:resourcekey="chkShowHideSearch">
                        
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
                                <label id="lblPOnumber" runat="server" >
                                    <asp:Literal runat="server" ID="litPONum"  meta:resourcekey="lblCountingNo"></asp:Literal>
                                </label>
                                <asp:TextBox ID="txtbxCLnumbersearch" CssClass="carsInput" runat="server" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>


                        </div>

                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblCLSupplier" runat="server" >
                                    <asp:Literal runat="server" meta:resourcekey="lblSupplier"></asp:Literal>
                                </label>
                                <asp:TextBox ID="txtCLSupplier" CssClass="carsInput" runat="server" data-submit="ITEM_DISC_CODE_BUY" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblCLSpare" runat="server" >
                                   <%-- <asp:Literal runat="server" meta:resourcekey="lblSparePart"></asp:Literal>--%>
                                    <%=GetLocalResourceObject("lblSparePart")%>
                                </label>
                                <asp:TextBox ID="txtCLSpare" CssClass="carsInput" runat="server" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblDateFrom" runat="server" ><%=GetLocalResourceObject("lblFromDateResource1")%></label>
                                <asp:TextBox ID="txtbxDateFrom" CssClass="carsInput" runat="server" data-submit="ANNOTATION" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblDateTo" runat="server" ><%=GetLocalResourceObject("lblToDateResource1")%></label>
                                <asp:TextBox ID="txtbxDateTo" CssClass="carsInput" runat="server" data-submit="ANNOTATION" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>

                        <div class="fields">
                            <div class="eight wide field">

                                <div class="ui toggle checkbox">
                                    <input id="chkSearchClosed" runat="server" type="checkbox" name="public" />
                                    <label meta:resourcekey="lblClosed">
                                        <asp:Literal runat="server" meta:resourcekey="lblClosed"></asp:Literal>
                                    </label>
                                </div>


                            </div>
                        </div>


                        <div class="fields">
                            <div class="three wide field">

                                <input type="button" id="searchbutton" runat="server" class="ui btn CarsBoxes" meta:resourcekey="btnSearchbutton" />



                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <%--End of Purchase order segment--%>
            <div class="twelve wide column">
                <div id="CL-table" class="mytabulatorclass">
                </div>
            </div>



        </div>
    </div>

    <%--End tab PurchaseOrders--%>


    <%--Begin tab NewCountingList--%>

    <div id="tabNewCountingList" class="tTab">
        <div class="ui form stackable two column grid ">
            <div class="eight wide column">

                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H2" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headCountingListDetails")%></h3>



                    <asp:Label ID="lblSerialnrPO" class="inHeaderTextField1 hidden" Text="Serienr. Telling:" runat="server" meta:resourcekey="lblSerialnrPOResource1"></asp:Label>
                    <asp:Label ID="lblSerNumPrefix" class="inHeaderTextField2 hidden" runat="server" meta:resourcekey="lblSerNumPrefixResource1"></asp:Label>
                    <asp:Label ID="lblSerNum" class="inHeaderTextField2-5 hidden" runat="server" meta:resourcekey="lblSerNumResource1"></asp:Label>
                    <asp:Label ID="lblOD" class="inHeaderTextField3" Text="Telledato:" runat="server" meta:resourcekey="lblODResource1"></asp:Label>
                    <asp:Label ID="lblOrderDate" class="inHeaderTextField4" runat="server" meta:resourcekey="lblOrderDateResource1"></asp:Label>
                    <label class="inHeaderCheckbox">
                        Vis/Lukk
                            <button id="btnViewDetailsNEWPO" class="ui btn mini">
                                <i class="caret down icon"></i>
                            </button>
                    </label>
                    <div class="itemadd-container">

                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblCreateFromLocation" runat="server"><%=GetLocalResourceObject("lblFromLocation")%></label>
                                <asp:TextBox ID="txtCreateFromLocation" runat="server" CssClass="carsInput" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblCreateToLocation" runat="server"><%=GetLocalResourceObject("lblToLocation")%></label>
                                <asp:TextBox ID="txtCreateToLocation" runat="server" CssClass="carsInput" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        
                        <div class="fields hidden">
                            <div class="eight wide field">
                                <label id="lblCreateFromCatg" runat="server"><%=GetLocalResourceObject("lblFromProductGroup")%></label>
                                <asp:TextBox ID="txtCreateFromCatg" runat="server" CssClass="carsInput" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblCreateToCatg" runat="server"><%=GetLocalResourceObject("lblToProductGroup")%></label>
                                <asp:TextBox ID="txtCreateToCatg" runat="server" CssClass="carsInput" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblCreateFromSpare" runat="server"><%=GetLocalResourceObject("lblFromSparePart")%></label>
                                <asp:TextBox ID="txtCreateFromSpare" runat="server" CssClass="carsInput" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblCreateToSpare" runat="server"><%=GetLocalResourceObject("lblToSparePart")%></label>
                                <asp:TextBox ID="txtCreateToSpare" runat="server" CssClass="carsInput" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblCreateSupplierNo" runat="server"><%=GetLocalResourceObject("lblSupplier")%></label>
                                <asp:TextBox ID="txtCreateSupplier" runat="server" CssClass="carsInput" data-submit="ITEM_DISC_CODE_BUY" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblCreateSupplierName" runat="server"><%=GetLocalResourceObject("lblSupplierName")%></label>
                                <asp:TextBox ID="txtCreateSupplierName" runat="server" Enabled="False" CssClass="carsInput" data-submit="ITEM_DISC_CODE_BUY" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>

                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblCreateFromDate" runat="server"><%=GetLocalResourceObject("lblSparesCountedBeforeDate")%></label>
                                <asp:TextBox ID="txtCreateFromDate" runat="server" CssClass="carsInput" data-submit="ANNOTATION" meta:resourcekey="txtTechMakeResource1" Enabled="False"></asp:TextBox>
                                <input type="date" id="browserDate" runat="server" />
                            </div>
                            <div class="eight wide field">
                                <label id="Label2" runat="server"><%=GetLocalResourceObject("lblSignature")%></label>
                                 <asp:DropDownList ID="drpSignatureList" CssClass="carsInput" runat="server" meta:resourcekey="drpMakeCodesResource1"></asp:DropDownList>
                            </div>

                        </div>

                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnCreateCountingList"  runat="server" class="ui btn CarsBoxes" meta:resourcekey="btnCreateResource1" />
                            </div>
                            <div class="eight wide field">
                              
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="four wide column">
                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H3" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headSorting")%></h3>
                    <div class="fields">
                        <div class="eight wide field">
                            <asp:CheckBox ID="chkCreateStockOnly" runat="server" CssClass="unstackable" Text="Deler med beholdning" meta:resourcekey="chkCreateStockOnlyResource1" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="eight wide field">
                            <asp:CheckBox ID="chkCreateNoLocation" runat="server" CssClass="unstackable" Text="Deler uten lokasjon" meta:resourcekey="chkCreateNoLocationResource1" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="eight wide field">
                            <asp:RadioButtonList ID="rblCreateSortBy" runat="server" meta:resourcekey="rblCreateSortByResource1">
                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">Pr. varenr</asp:ListItem>
                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">Pr. betegnelse</asp:ListItem>
                                <asp:ListItem Value="3" Selected="True" meta:resourcekey="ListItemResource3">Pr. lokasjon</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>

                </div>
                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H1" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("headBarcodeReader")%></h3>
                    <div class="fields">
                        <div class="sixteen wide field">
                           <label id="Label1" runat="server"><%=GetLocalResourceObject("lblUploadFromBarcode")%></label>
                                <input type="file" id="fileUpload" style="height: 60%;" value="C:\Temp\Scan.txt" />
                        </div>
                    </div>
                    <div class="fields">
                        <div class="eight wide field">
                            <input type="button" id="btnCreateCLBarscan" runat="server" class="ui btn CarsBoxes" meta:resourcekey="btnReadIn" />

                                <div id="dvCSV"></div>
                        </div>
                    </div>

                </div>
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
                        <div class="title"><%=GetLocalResourceObject("titleGenerateList")%></div>
                        <div class="description"><%=GetLocalResourceObject("titleGenerateListDesc")%></div>
                    </div>
                </div>
                <div class="disabled step" id="step_cl_second">
                    <i class="pencil icon"></i>
                    <div class="content">
                        <div class="title"><%=GetLocalResourceObject("titleEditList")%></div>
                        <div class="description"><%=GetLocalResourceObject("titleEditListDesc")%></div>
                    </div>
                </div>
                <div class="disabled step" id="step_cl_third">
                    <i class="close alternate icon"></i>
                    <div class="content">
                        <div class="title"><%=GetLocalResourceObject("titleCloseList")%></div>
                        <div class="description"><%=GetLocalResourceObject("titleCloseListDesc")%>Sperr listen slik at beholdning blir oppdatert.</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">

            <div class="modal_cl_divstep1">

                <div class="ui header"><%=GetLocalResourceObject("headCreateCountingList")%></div>
                <div class="fields">
                    <div class="six wide field signature-move">
                        <div class="ui blue horizontal label">Tellelistenummer</div>
                        <a class="detail" id="pomodal_details_ponumber"></a>

                    </div>

                </div>
                
                <div id="counting-table-modal" class="mytabulatorclass"></div>



            </div>

            <div class="modal_cl_divstep2 hidden">
                <div class="ui header"><%=GetLocalResourceObject("titleEditList")%></div>
                <div class="fields">
                    <div class="six wide field signature-move">
                        <div class="ui blue horizontal label">Tellelistenummer</div>
                        <a class="detail" id="pomodal_details_ponumber2"></a>
                        <select class="ui dropdown" id="drpSignatureEdit" runat="server">
                        </select>
                    </div>
                     <div class="three wide field">
                      
                    </div>

                </div>
                <div id="counting-table-edit-modal" class="mytabulatorclass"></div>
            </div>
            <div class="modal_cl_divstep3 hidden">
                <div class="ui header"><%=GetLocalResourceObject("titleCloseList")%></div>
                <div class="fields">
                    <div class="three wide field">
                        <div class="ui blue horizontal label"><%=GetLocalResourceObject("lblCountingListNo")%></div>
                        <a class="detail" id="pomodal_details_ponumber3"></a>
                    </div>
                   
                    <div class="circle-loader hidden" style="margin-left: 50%">
                        <div class="checkmarkX draw"></div>
                    </div>
                    <div class="CLClosed hidden">
                        <br />
                        <div class="ui header">Om du ønsker å avslutte tellelisten og oppdatere varene med korrigert antall til beholdning, trykk på rød sperreknapp nede til høyre.</div>
                    </div>
                    <div class="viewCLClosed">
                        <div id="counting-table-close-modal" class="mytabulatorclass"></div>
                    </div>
                </div>

            </div>

        </div>
        <div class="actions">
           <div class="ui red button disabled" id="btnErrorSpareListView" >
                Meldinger
                <i class="cross icon left"></i>
            </div>
            <label id="lblfileUpload2">Last opp fil fra strekkodeleser: </label>
            <input type="file" id="fileUpload2" style="height: 60%;width:150px" value="C:\Temp\Scan.txt" />
                
            <button class="ui black button" id="btnEditImport">
                <i class="upload icon left"></i>
                Les inn
            </button>
            <button class="ui blue button" id="btnEditPrint">
                <i class="print icon left"></i>
                Skriv ut
            </button>
            
            <div class="ui left labeled icon button" id="po_modal_previous">
                Tilbake 
                <i class="chevron left icon"></i>
            </div>
            <button class="ui red button" id="po_modal_update">
                <i class="refresh icon"></i>
                Avbryt
            </button>
            <div class="ui positive right labeled icon button" id="po_modal_save">
                <div>Lagre</div>

                <i class="chevron right icon"></i>
            </div>
            <div class="ui positive right labeled icon button" id="po_modal_next">
                <div>Oppdater</div>

                <i class="chevron right icon"></i>
            </div>
            <button class="ui red button" id="po_modal_close">
                <i class="save icon"></i>
                Sperre
            </button>


        </div>
    </div>


    <div class="ui modal" style="margin-top:20%" id="errorSpareListModal">
        <i class="close icon"></i>
        <div class="header">
            Disse varene finnes ikke på lager eller ble ikke oppdatert i eksisterende telleliste. Kontroller varene manuelt.
        </div>
        <div class="content">
            <div id="error-table-modal" class="mytabulatorclass"></div>

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

     <div class="ui modal" style="margin-top:20%" id="importBarcodeSpares">
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


    <dx:ASPxCallbackPanel ID="cbCountingList" ClientInstanceName="cbCountingList" runat="server" OnCallback="cbCountingList_Callback" ClientSideEvents-EndCallback="OnCountingListEndCallBack">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <dx:ASPxPopupControl ID="popupCountingListReport" runat="server" ClientInstanceName="popupCountingListReport" AllowDragging="true" Modal="True" Theme="iOS" CloseAction="CloseButton">
                        <Windows>
                            <dx:PopupWindow ContentUrl="../Transactions/ReportViewer_Transaction.aspx" HeaderText="Counting List" Name="report"
                                                Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                            </dx:PopupWindow>
                        </Windows>
                    </dx:ASPxPopupControl>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

    <dx:ASPxCallbackPanel ID="cbCountingListResult" ClientInstanceName="cbCountingListResult" runat="server" OnCallback="cbCountingListResult_Callback" ClientSideEvents-EndCallback="OnCountingListResultEndCallBack">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <dx:ASPxPopupControl ID="popupCountingListResult" runat="server" ClientInstanceName="popupCountingListResult" AllowDragging="true" Modal="True" Theme="iOS" CloseAction="CloseButton">
                        <Windows>
                            <dx:PopupWindow ContentUrl="../Transactions/ReportViewer_Transaction.aspx" HeaderText="Counting List result" Name="report"
                                                Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                            </dx:PopupWindow>
                        </Windows>
                    </dx:ASPxPopupControl>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>


