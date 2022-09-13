<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmTimeRegistration.aspx.vb" Inherits="CARS.frmTimeRegistration" MasterPageFile="~/MasterPage.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="Server">
    <style type="text/css">
        .ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
            background: #4c6a9e;
            color: white;
        }

        @import url("https://fonts.googleapis.com/css?family=Inconsolata:700");

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .container {
            position: absolute;
            margin: auto;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 300px;
            height: 100px;
        }

            .container .search {
                position: absolute;
                margin: auto;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
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
                }

            .container input {
                font-family: "Inconsolata", monospace;
                position: absolute;
                margin: auto;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 35px;
                outline: none;
                border: none;
                background: white;
                color: black;
                /*text-shadow: 0 0 10px crimson;*/
                padding: 0 80px 0 20px;
                border-radius: 30px;
                box-shadow: 0 0 25px 0 #2185d0, 0 20px 25px 0 rgba(0, 0, 0, 0.1);
                transition: all 1s;
                opacity: 0;
                z-index: 5;
                font-weight: bolder;
                letter-spacing: 0.1em;
            }

                .container input:hover {
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
                }

        .ui.tabular.menu {
            border-bottom: 2px solid #2185D0;
        }

        .ui.divider {
            margin: -0.4rem 0rem;
        }


        .ui.tabular.menu .item {
            font-weight: bold;
        }

        .ui.tabular.menu .active.item {
            color: #ffffff;
            background-color: #2185D0;
            font-weight: bold;
        }


        .ui.tabular.menu .item:hover {
            background-color: rgba(33, 150, 243, 0.22);
        }

        .ui.tabular.menu .active.item:hover {
            background-color: #2185D0;
        }

        .ui.list .list > .item .header, .ui.list > .item .header {
            font-family: 'Open Sans', sans-serif;
        }

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
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            loadInit();
            function loadInit() {
                //setTab('Stempling');
                $('#<%=ddlJobs.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
            }
            $('.menu .item')
                .tab()
                ; //activate the tabs

            function setTab(cTab) {
                var tabID = "";

                tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
                var tab;
                (tabID == "") ? tab = cTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
            }

            $('.cTab').on('click', function (e) {
                setTab($(this));
            });


            idwolabSeq = "0";
            jobId = "0";
            trSeq = "0";
            firstName = "";
            $("#<%=btnClockin.ClientID%>").attr('disabled', 'disabled');
            $("#<%=btnClockout.ClientID%>").attr('disabled', 'disabled');
            $('#<%=txtClockinDt.ClientID%>').attr('disabled', 'disabled');
            $('#<%=txtClockinTime.ClientID%>').attr('disabled', 'disabled');
            $('#<%=txtClockoutDt.ClientID%>').attr('disabled', 'disabled');
            $('#<%=txtClockoutTime.ClientID%>').attr('disabled', 'disabled');
            loadUnsoldTime();

            $.datepicker.setDefaults($.datepicker.regional["no"]);
            $('#<%=txtSearchDate.ClientID%>,#<%=txtDate.ClientID%>').datepicker({
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+1",
                showWeek: true,
                dateFormat: 'dd.mm.yy',
                
            });
            $('#<%=txtSearchDate.ClientID%>, #<%=txtDate.ClientID%>').datepicker('setDate', new Date());
           

            var labGrid = $("#jobgrid");
            pageSize = $('#<%=hdnPageSize.ClientID%>').val();
            mydata = "";

            //Labour Details Grid
            labGrid.jqGrid({
                datatype: "local",
                data: mydata,
                colNames: ['Job.LineNo', 'Labour Desc', 'IdWoLabSeq'],
                colModel: [
                    { name: 'Job_LineNo', index: 'Job_LineNo', width: 160, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Lab_Desc', index: 'Lab_Desc', width: 400, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Id_WoLab_Seq', index: 'Id_WoLab_Seq', sorttype: "string", classes: 'wosearchpointer', hidden: true }

                ],
                multiselect: false,
                pager: jQuery('#pager'),
                rowNum: pageSize,//can fetch from webconfig
                rowList: 5,
                sortorder: 'asc',
                shrinktofit: true,
                viewrecords: true,
                height: "100px",
                caption: "Labour Details",
                async: false, //Very important,
                subgrid: false,
                onSelectRow: function (rowId) {
                    var rowData = $(this).jqGrid("getRowData", rowId);
                    idwolabSeq = rowData.Id_WoLab_Seq;
                    var result;
                    result = rowData.Job_LineNo.split("-");
                    jobId = result[0];
                    MecDetExists();
                }

            });

            jQuery("#jobgrid").jqGrid('bindKeys', {
                "onEnter": function (rowid) {
                    $('#<%=btnClockin.ClientID%>').focus();
                }
            });

            //Mechanic Details Grid
            var mechGrid = $("#mechGrid");
            mechGrid.jqGrid({
                datatype: "local",
                data: mydata,
                colNames: ['OrderNo', 'Job', 'LineNo', 'Mechanic Code', 'Mechanic Name', 'Text', 'Clockin Date', 'Clockin Time', 'Clockout Date', 'Clockout Time', 'Total Time', 'Id_Tr_Seq', 'Id_WoLab_Seq'],
                colModel: [
                    { name: 'OrderNo', index: 'OrderNo', width: 80, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'JobNo', index: 'JobNo', width: 50, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'LineNo', index: 'LineNo', width: 70, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'IdMech', index: 'IdMech', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'MechName', index: 'MechName', width: 130, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Text', index: 'Text', width: 150, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Dt_clockin', index: 'Dt_clockin', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Time_clockin', index: 'Time_clockin', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Dt_clockout', index: 'Dt_clockout', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Time_clockout', index: 'Time_clockout', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'TotalClockedTime', index: 'TotalClockedTime', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Id_Tr_Seq', index: 'Id_Tr_Seq', width: 120, sorttype: "string", classes: 'wosearchpointer', hidden: true },
                    { name: 'Id_WoLab_Seq', index: 'Id_WoLab_Seq', width: 120, sorttype: "string", classes: 'wosearchpointer', hidden: true },
                ],
                multiselect: false,
                pager: jQuery('#mechpager'),
                rowNum: pageSize,//can fetch from webconfig
                rowList: 5,
                sortorder: 'asc',
                viewrecords: true,
                height: "150px",
                caption: "Mechanic Details",
                async: false, //Very important,
                subgrid: false
            });

            //Mechanic Search Grid
            var mechSearchGrid = $("#mechSearchGrid");
            mechSearchGrid.jqGrid({
                datatype: "local",
                data: mydata,
                colNames: ['OrderNo', 'Job', 'LineNo', 'Mechanic Code', 'Mechanic Name', 'Text', 'Clockin Date', 'Clockin Time', 'Clockout Date', 'Clockout Time', 'Total Time', 'Id_Tr_Seq', 'Id_WoLab_Seq'],
                colModel: [
                    { name: 'OrderNo', index: 'OrderNo', width: 80, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'JobNo', index: 'JobNo', width: 50, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'LineNo', index: 'LineNo', width: 70, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'IdMech', index: 'IdMech', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'MechName', index: 'MechName', width: 150, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Text', index: 'Text', width: 150, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Dt_clockin', index: 'Dt_clockin', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Time_clockin', index: 'Time_clockin', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Dt_clockout', index: 'Dt_clockout', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Time_clockout', index: 'Time_clockout', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'TotalClockedTime', index: 'TotalClockedTime', width: 120, sorttype: "string", classes: 'wosearchpointer' },
                    { name: 'Id_Tr_Seq', index: 'Id_Tr_Seq', width: 120, sorttype: "string", classes: 'wosearchpointer', hidden: true },
                    { name: 'Id_WoLab_Seq', index: 'Id_WoLab_Seq', width: 120, sorttype: "string", classes: 'wosearchpointer', hidden: true },
                ],
                multiselect: false,
                pager: jQuery('#mechSearchPager'),
                rowNum: pageSize,//can fetch from webconfig
                rowList: 5,
                sortorder: 'asc',
                viewrecords: true,
                height: "200px",
                caption: "Mechanic Details",
                async: false, //Very important,
                subgrid: false
            });

            $("#history-table").tabulator({

                height: 400, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                //index: "NUMBER",
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string
                persistentSort: true, //Enable sort persistence
                //responsiveLayout: true,

                // Return value + "<span style='color:#d00; margin-left:10px;'>(" + count + Str() + "<span style='margin-right:300px;'>";
                //column definition in the columns array

                selectableCheck: function (row) {

                    var selectedRows = $("#history-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        //if (row.getData().ID_INV_NO == selectedRows[0].getData().ID_INV_NO) {
                        //    return false;
                        //}
                    }


                    return true; //alow selection of rows where the age is greater than 18
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    //initModalView(row);
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

                    { title: "Ord.nr.", field: "OrderNo", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Jobb", field: "JobNo", align: "center", headerFilter: "input", width: 80 },
                    { title: "Linjnr", field: "LineNo", align: "center", headerFilter: "input", width: 80 },
                    { title: "Mekaniker", field: "IdMech", align: "center", headerFilter: "input", minWidth: 120 },
                    { title: "Tekst", field: "Text", align: "center", headerFilter: "input", width: 350 },
                    { title: "Dato inn", field: "Dt_clockin", align: "center", headerFilter: "input", minWidth: 100 },
                    { title: "Tid inn", field: "Time_clockin", align: "center", headerFilter: "input", minWidth: 100 },
                    { title: "Dato ut", field: "Dt_clockout", align: "center", headerFilter: "input", minWidth: 100 },
                    { title: "Tid ut", field: "Time_clockout", align: "center", headerFilter: "input", minWidth: 100 },
                    { title: "Tid brukt", field: "TotalClockedTime", align: "center", headerFilter: "input", minWidth: 100 },
                    { title: "DBiD", field: "Id_Tr_Seq", align: "center", visible: false },
                ],

                downloadReady: function (fileContents, blob) {
                    //fileContents - the unencoded contents of the file
                    //blob - the blob object for the download

                    //custom action to send blob to server could be included here
                    //  sendEmail

                    window.open(window.URL.createObjectURL(blob));

                    return blob; //must return a blob to proceed with the download, return false to abort download
                },

                //footerElement: $("<div class='tabulator-footer'></div>")[0], //sette [0] bak for å fungere,
                footerElement: $('<div class="tabulator-footer"></div>')[0]
            });

            //autocomplete mechanic
            var mech = $('#<%=txtMechId.ClientID%>').val();
            $('#<%=txtMechId.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmTimeRegistration.aspx/Mechanic_Search",
                        data: "{'q':'" + $('#<%=txtMechId.ClientID%>').val() + "'}",
                        dataType: "json",

                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Login_Name,
                                    val: item.Id_Login,
                                    value: item.Id_Login,
                                    fname: item.Mech_FirstName
                                }
                            }))
                        },
                        error: function (xhr, status, error) {
                            alert("Error" + error);
                            <%--$('#systemMSG').hide();--%>
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=txtMechId.ClientID%>").val(i.item.val);
                    $("#<%=hdnFirstName.ClientID%>").val(i.item.fname);
                    LoadMechanicData(i.item.val);
                    MecDetExists();
                    //$("#<%=btnClockin.ClientID%>").removeAttr("disabled");
                    //$("#<%=btnClockout.ClientID%>").removeAttr("disabled");
                },
            });

            $('#<%=txtMechanic.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmTimeRegistration.aspx/Mechanic_Search",
                        data: "{'q':'" + $('#<%=txtMechanic.ClientID%>').val() + "'}",
                        dataType: "json",

                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Login_Name,
                                    val: item.Id_Login,
                                    value: item.Id_Login,
                                    fname: item.Mech_FirstName
                                }
                            }))
                        },
                        error: function (xhr, status, error) {
                            alert("Error" + error);
                            <%--$('#systemMSG').hide();--%>
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=txtMechId.ClientID%>").val(i.item.val);
                },
            });


            $('#<%=txtOrdNo.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmWoSearch.aspx/GetOrder",
                        data: "{'orderNo':'" + $('#<%=txtOrdNo.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0] + "-" + item.split('-')[1] + "-" + item.split('-')[2] + "-" + item.split('-')[3] + "-" + item.split('-')[4],
                                    val: item.split('-')[0],
                                    value: item.split('-')[0],
                                    woNo: item.split('-')[0],
                                    woPr: item.split('-')[5]
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
                    $("#<%=txtOrdNo.ClientID%>").val(i.item.woNo);
                    if ($('#<%=ddlUnsoldTime.ClientID%>')[0].selectedIndex != 0) {
                        $('#<%=ddlUnsoldTime.ClientID%>')[0].selectedIndex = 0;
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmTimeRegistration.aspx/FetchJobDet",
                        data: "{'OrderNo':'" + $('#<%=txtOrdNo.ClientID%>').val() + "'}",
                        dataType: "json",
                        async: false,//Very important
                        success: function (data) {
                            jQuery("#jobgrid").jqGrid('clearGridData');
                            for (i = 0; i < data.d.length; i++) {
                                mydata = data;
                                jQuery("#jobgrid").jqGrid('addRowData', i + 1, mydata.d[i]);
                            }
                        }
                    });

                    jQuery("#jobgrid").setGridParam({ rowNum: pageSize }).trigger("reloadGrid");
                    $("#jobgrid").jqGrid("hideCol", "subgrid");

                    jQuery('#jobgrid').jqGrid('setSelection', 1, true);
                    jQuery('#jobgrid').focus();
                }

            });

            $('#<%=btnClockin.ClientID%>').on('click', function () {
                if (($('#<%=txtOrdNo.ClientID%>').val() != "") && ($('#<%=ddlUnsoldTime.ClientID%>')[0].selectedIndex != 0)) {
                    alert('Either Order Number or unsold Time can be used for clockin');
                    $('#<%=txtOrdNo.ClientID%>').val('');
                    jQuery("#jobgrid").jqGrid('clearGridData');
                }
                else {
                    clockIn();
                }
            });

            $('#<%=btnClockout.ClientID%>').on('click', function () {
                clockOut();
            });


            $('#<%=ddlUnsoldTime.ClientID%>').change(function (e) {
                if ($('#<%=ddlUnsoldTime.ClientID%>')[0].selectedIndex > 0) {
                    if ($('#<%=txtOrdNo.ClientID%>').val() != "") {
                        $('#<%=txtOrdNo.ClientID%>').val('');
                    }
                    $('#<%=btnClockin.ClientID%>').removeAttr("disabled");
                }
                else {
                    $("#<%=btnClockout.ClientID%>").attr('disabled', 'disabled');
                }
            });

            $('#<%=btnManClockin.ClientID%>').on('click', function (e) {
                var bool = fnClientValidate();
                if (bool == true) {
                    var mid = $('#<%=txtMechId.ClientID%>').val();
                    var page = "../Transactions/frmTRegPopUp.aspx?MechanicId=" + mid
                    var $dialog = $('<div id="testdialog" style="width:100%;height:100%"></div>')
                        .html('<iframe id="testifr" style="border: 0px; overflow:scroll" src="' + page + '" width="100%" height="100%"></iframe>')
                        .dialog({
                            autoOpen: false,
                            modal: true,
                            height: 500,
                            width: 800,
                            title: "Manual Clock-In"
                        });
                    $dialog.dialog('open');
                }
            });

            $('#<%=txtSearchOrderNo.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmWoSearch.aspx/GetOrder",
                        data: "{'orderNo':'" + $('#<%=txtSearchOrderNo.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0] + "-" + item.split('-')[1] + "-" + item.split('-')[2] + "-" + item.split('-')[3] + "-" + item.split('-')[4],
                                    val: item.split('-')[0],
                                    value: item.split('-')[0],
                                    woNo: item.split('-')[0],
                                    woPr: item.split('-')[5]
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
                    $("#<%=txtSearchOrderNo.ClientID%>").val(i.item.woNo);

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmTimeRegistration.aspx/FetchJobs",
                        data: "{'OrderNo':'" + $('#<%=txtSearchOrderNo.ClientID%>').val() + "'}",
                        dataType: "json",
                        async: false,//Very important
                        success: function (Result) {
                            $('#<%=ddlJobs.ClientID%>').empty();
                            $('#<%=ddlJobs.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");

                            Result = Result.d;
                            $.each(Result, function (key, value) {
                                $('#<%=ddlJobs.ClientID%>').append($("<option></option>").val(value.JobNo).html(value.JobNo));
                                $('#<%=ddlJobs.ClientID%>')[0].selectedIndex = 1;
                            });
                        }
                    });
                }
            });

            $('#<%=txtOrderNo.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmWoSearch.aspx/GetOrder",
                        data: "{'orderNo':'" + $('#<%=txtOrderNo.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0] + "-" + item.split('-')[1] + "-" + item.split('-')[2] + "-" + item.split('-')[3] + "-" + item.split('-')[4],
                                    val: item.split('-')[0],
                                    value: item.split('-')[0],
                                    woNo: item.split('-')[0],
                                    woPr: item.split('-')[5]
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
                    $("#<%=txtOrderNo.ClientID%>").val(i.item.woNo);

                }
            });

            $('#<%=btnSearch.ClientID%>').on('click', function () {
                searchMechDetails();
            });

            $('#<%=btnReset.ClientID%>').on('click', function () {
                clearSearchFields();
            });

            $('#<%=btnPrint.ClientID%>').on('click', function () {
                printSearchReport();
            });

            $('#<%=btnMechPrint.ClientID%>').on('click', function () {
                if ($('#<%=txtMechId.ClientID%>').val() == "") {
                    alert("Mechanic cannot be blank.")
                    return false;
                } else {
                    printMechReport();
                }

            });

            //autocomplete mechanic search
            var mech = $('#<%=txtSearchMech.ClientID%>').val();
            $('#<%=txtSearchMech.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmTimeRegistration.aspx/Mechanic_Search",
                        data: "{'q':'" + $('#<%=txtSearchMech.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Login_Name,
                                    val: item.Id_Login,
                                    value: item.Id_Login,
                                    mechName: item.Mech_FirstName
                                }
                            }))
                        },
                        error: function (xhr, status, error) {
                            alert("Error" + error);
                            <%--$('#systemMSG').hide();--%>
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=hdnMechName.ClientID%>").val(i.item.mechName);
                }
            });

            $('#clockinHistory').click(function () {
                //alert($('#<%=chkOrderClockIn.ClientID%>').is(":checked"));
                $("#history-table").tabulator("setData", "frmTimeRegistration.aspx/Fetch_History", { 'orderno': $('#<%=txtOrderNo.ClientID%>').val(), 'mech': $('#<%=txtMechanic.ClientID%>').val(), 'clockindate': $('#<%=txtDate.ClientID%>').val(), 'clockin': $('#<%=chkClockIn.ClientID%>').is(":checked"), 'clockinorder': $('#<%=chkOrderClockIn.ClientID%>').is(":checked") });
                $("#history-table").tabulator("redraw", true);
            });

            $('#<%=btnHistorySearch.ClientID%>').click(function () {
                //alert($('#<%=chkOrderClockIn.ClientID%>').is(":checked"));
                $("#history-table").tabulator("setData", "frmTimeRegistration.aspx/Fetch_History", { 'orderno': $('#<%=txtOrderNo.ClientID%>').val(), 'mech': $('#<%=txtMechanic.ClientID%>').val(), 'clockindate': $('#<%=txtDate.ClientID%>').val(), 'clockin': $('#<%=chkClockIn.ClientID%>').is(":checked"), 'clockinorder': $('#<%=chkOrderClockIn.ClientID%>').is(":checked") });
                $("#history-table").tabulator("redraw", true);

                
            });

            $('#<%=btnHistoryPrint.ClientID%>').click(function () {
                $("#history-table").tabulator("download", "pdf", "Stemplingshistorikk.pdf", {
                    orientation: "landscape", //set page orientation to portrait
                    // title:"Bestillingsnummer : " + $('#pomodal_details_ponumber').text(), //add title to report

                    autoTable: function (doc) {
                        //doc - the jsPDF document object

                        //add some text to the top left corner of the PDF
                        //doc.text("Bestillingsnummer " + $('#pomodal_details_ponumber').text(), 15, 15);
                        

                        //return the autoTable config options object
                        return {
                            //styles: {
                            // fillColor: [96, 162, 227]
                            //},
                            margin: { top: 120 },
                            addPageContent: function (data) {
                                doc.text("Dato : " + $('#<%=txtDate.ClientID%>').val(), 40, 40);
                                doc.text("Rapport : " + "Viser historikkstemplinger", 40, 60);
                                
                            }

                        };
                    },
                });


            });

        }); //end of ready


        function fnClientValidate() {
            if ($('#<%=txtMechId.ClientID%>').val() == "") {
                alert("Mechanic cannot be blank.")
                return false;
            }
            if (($('#<%=txtOrdNo.ClientID%>').val() != "") && ($('#<%=ddlUnsoldTime.ClientID%>')[0].selectedIndex == 0)) {
                var selRowIds = $("#jobGrid").jqGrid("getGridParam", "selarrrow");
                //if ($.inArray(rowId, selRowIds) == 0) {
                //    alert("Select atleast one labour line before clockin. ")
                //    return false;
                //}
            }
            return true;
        }
        function clockIn() {
            var bool = fnClientValidate();
            if (bool == true) {
                var reasCode = $('#<%=cbReasCode.ClientID%>').is(':checked');
                var mechId = $('#<%=txtMechId.ClientID%>').val();
                var ordNo = $('#<%=txtOrdNo.ClientID%>').val();
                var jobNo = jobId;
                var dtClockin = $('#<%=txtClockinDt.ClientID%>').val();
                var timeClockin = $('#<%=txtClockinTime.ClientID%>').val();
                var clockIn = "C";
                var id_tr_seq = "0";
                var WoLabSeq = idwolabSeq;
                var unsoldTime = $('#<%=ddlUnsoldTime.ClientID%>').val();
                //var reas_code = "";
                var comp_per = "0";
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmTimeRegistration.aspx/MechClockIn",
                    data: "{'mechId':'" + mechId + "','ordNo':'" + ordNo + "','jobNo':'" + jobNo + "','dtClockin':'" + dtClockin + "','timeClockin':'" + timeClockin + "','clockIn':'" + clockIn + "','id_tr_seq':'" + id_tr_seq + "','reas_code':'" + reasCode + "','comp_per':'" + comp_per + "','idWoLabSeq':'" + WoLabSeq + "','unsoldTime':'" + unsoldTime + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (Result) {
                        if (Result.d.length > 0) {
                            $('#<%=RTlblError.ClientID%>').text('Clocked In Successfully');
                            $('#<%=RTlblError.ClientID%>').removeClass();
                            $('#<%=RTlblError.ClientID%>').addClass("lblMessage");
                            loadClockinData(mechId, ordNo, jobNo, WoLabSeq);
                            LoadMechanicData(mechId);
                            $('#<%=txtMechId.ClientID%>').focus();
                            $('#<%=txtMechId.ClientID%>').val('');
                            $('#<%=txtOrdNo.ClientID%>').val('');
                            $('#<%=ddlUnsoldTime.ClientID%>')[0].selectedIndex = 0;
                            jQuery("#jobgrid").jqGrid('clearGridData');
                        }
                    }
                });
            }

        }

        function clockOut() {
            var bool = fnClientValidate();
            if (bool == true) {
                var reasCode = $('#<%=cbReasCode.ClientID%>').is(':checked');
                var mechId = $('#<%=txtMechId.ClientID%>').val();
                var ordNo = $('#<%=txtOrdNo.ClientID%>').val();
                var jobNo = jobId;
                var dtClockin = $('#<%=txtClockinDt.ClientID%>').val();
                var timeClockin = $('#<%=txtClockinTime.ClientID%>').val();
                var clockIn = "L";
                var id_tr_seq = "0";
                //var reas_code = "94";
                var comp_per = "100";
                var WoLabSeq = idwolabSeq;
                var unsoldTime = $('#<%=ddlUnsoldTime.ClientID%>').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmTimeRegistration.aspx/MechClockIn",
                    data: "{'mechId':'" + mechId + "','ordNo':'" + ordNo + "','jobNo':'" + jobNo + "','dtClockin':'" + dtClockin + "','timeClockin':'" + timeClockin + "','clockIn':'" + clockIn + "','id_tr_seq':'" + id_tr_seq + "','reas_code':'" + reasCode + "','comp_per':'" + comp_per + "','idWoLabSeq':'" + WoLabSeq + "','unsoldTime':'" + unsoldTime + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (Result) {
                        if (Result.d.length > 0) {
                            $('#<%=RTlblError.ClientID%>').text('Clocked Out Successfully');
                            $('#<%=RTlblError.ClientID%>').removeClass();
                            $('#<%=RTlblError.ClientID%>').addClass("lblMessage");
                            LoadMechanicData();
                            $('#<%=txtMechId.ClientID%>').focus();
                            $('#<%=txtMechId.ClientID%>').val('');
                            $('#<%=txtOrdNo.ClientID%>').val('');
                            $('#<%=ddlUnsoldTime.ClientID%>')[0].selectedIndex = 0;
                            jQuery("#jobgrid").jqGrid('clearGridData');
                        }
                    }
                });
            }
        }

        function searchMechDetails() {
            var id = "";
            var mechId = $('#<%=txtSearchMech.ClientID%>').val();
            var mechName = $('#<%=hdnMechName.ClientID%>').val();
            var searchDate = $('#<%=txtSearchDate.ClientID%>').val();
            var ordNo = $('#<%=txtSearchOrderNo.ClientID%>').val();
            var jobNo = $('#<%=ddlJobs.ClientID%>').val();
            var flgOrders = $('#<%=chkorder.ClientID%>').is(':checked');
            var flgUnsold = $('#<%=chkdags.ClientID%>').is(':checked');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmTimeRegistration.aspx/SearchMechanicDetails",
                data: "{'mechId':'" + mechId + "','ordNo':'" + ordNo + "','jobNo':'" + jobNo + "','mechName':'" + mechName + "','searchDate':'" + searchDate + "','flgOrders':'" + flgOrders + "','flgUnsold':'" + flgUnsold + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    jQuery("#mechSearchGrid").jqGrid('clearGridData');
                    if (Result.d.length > 1) {
                        for (i = 0; i < Result.d[0].length; i++) {
                            mydata = Result.d[0];
                            jQuery("#mechSearchGrid").jqGrid('addRowData', i + 1, mydata[i]);
                        }

                        jQuery("#mechSearchGrid").setGridParam({ rowNum: pageSize }).trigger("reloadGrid");
                        $("#mechSearchGrid").jqGrid("hideCol", "subgrid");

                        $('#<%=RTlblError.ClientID%>').text('');
                        $('#<%=RTlblError.ClientID%>').removeClass();

                        var totTimeOnOrder = Result.d[1][0].TotalTimeOnOrder;
                        var totTimeUnsold = Result.d[1][0].TotalTimeUnsold;
                        $('#<%=txtTotOrder.ClientID%>').val(Result.d[1][0].TotalTimeOnOrder);
                        $('#<%=txtTotUnsold.ClientID%>').val(Result.d[1][0].TotalTimeUnsold);
                    } else {
                        $('#<%=RTlblError.ClientID%>').text('No Records found');
                        $('#<%=RTlblError.ClientID%>').addClass("lblErr");
                    }
                }
            });

        }

        function loadUnsoldTime() {
            $.ajax({
                type: "POST",
                url: "frmTimeRegistration.aspx/LoadUnsoldTime",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (Result) {
                    $('#<%=ddlUnsoldTime.ClientID%>').empty();
                    $('#<%=ddlUnsoldTime.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                    Result = Result.d;

                    $.each(Result, function (key, value) {
                        $('#<%=ddlUnsoldTime.ClientID%>').append($("<option></option>").val(value.Id_Settings).html(value.Description));
                    });
                },
                failure: function () {
                    alert("Failed!");
                }
            });
        }

        function MecDetExists() {
            var ordNo = $('#<%=txtOrdNo.ClientID%>').val();
            var mechId = $('#<%=txtMechId.ClientID%>').val();
            var jobNo = jobId;
            var woLabSeq = idwolabSeq;
            $.ajax({
                type: "POST",
                url: "frmTimeRegistration.aspx/MecDetExists",
                data: "{'mechId':'" + mechId + "','ordNo':'" + ordNo + "','jobNo':'" + jobNo + "','idWoLabSeq':'" + woLabSeq + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d[0].Id_Tr_Seq == null) {
                        $('#<%=txtClockinDt.ClientID%>').val(data.d[0].Dt_clockin);
                        $('#<%=txtClockinTime.ClientID%>').val(data.d[0].Time_clockin);
                        $('#<%=txtClockoutDt.ClientID%>').val('');
                        $('#<%=txtClockoutTime.ClientID%>').val('');
                        $('#<%=btnClockin.ClientID%>').removeAttr("disabled");
                        $("#<%=cbReasCode.ClientID%>").attr('disabled', 'disabled');
                        $('#<%=btnClockout.ClientID%>').attr('disabled', 'disabled');
                    }
                    else {
                        if (data.d[0].Id_Tr_Seq == "0") {
                            $('#<%=txtClockoutDt.ClientID%>').val('');
                            $('#<%=txtClockoutTime.ClientID%>').val('');
                            $('#<%=txtClockinDt.ClientID%>').val('');
                            $('#<%=txtClockinTime.ClientID%>').val('');
                            $('#<%=btnClockin.ClientID%>').removeAttr("disabled");
                            //$('#<%=btnClockin.ClientID%>').show();
                            $('#<%=btnClockout.ClientID%>').attr('disabled', 'disabled');
                        }
                        else {
                            trSeq = data.d[0].Id_Tr_Seq;
                            if (data.d[0].Id_UnsoldTime == "") {
                                if (data.d[0].Id_WoLab_Seq == woLabSeq) {
                                    $('#<%=txtClockinDt.ClientID%>').val(data.d[0].Dt_clockin);
                                    $('#<%=txtClockinTime.ClientID%>').val(data.d[0].Time_clockin);
                                    $('#<%=txtClockoutDt.ClientID%>').val(data.d[0].Dt_clockout);
                                    $('#<%=txtClockoutTime.ClientID%>').val(data.d[0].Time_clockout);
                                }
                                else {
                                    $('#<%=txtClockinDt.ClientID%>').val(data.d[0].Dt_clockin);
                                    $('#<%=txtClockinTime.ClientID%>').val(data.d[0].Time_clockin);
                                    $('#<%=txtClockoutDt.ClientID%>').val('');
                                    $('#<%=txtClockoutTime.ClientID%>').val('');
                                }
                            }
                            else {
                                $('#<%=txtClockinDt.ClientID%>').val(data.d[0].Dt_clockin);
                                $('#<%=txtClockinTime.ClientID%>').val(data.d[0].Time_clockin);
                                $('#<%=txtClockoutDt.ClientID%>').val(data.d[0].Dt_clockout);
                                $('#<%=txtClockoutTime.ClientID%>').val(data.d[0].Time_clockout);
                            }

                            //$('#<%=ddlUnsoldTime.ClientID%>').val(data.d[0].Id_UnsoldTime);
                            $('#<%=btnClockin.ClientID%>').removeAttr("disabled");
                            $('#<%=btnClockout.ClientID%>').removeAttr("disabled");
                            $("#<%=cbReasCode.ClientID%>").removeAttr("disabled");
                        }
                    }
                },
                failure: function () {
                    alert("Failed!");
                }
            });
        }

        function loadClockinData(mechId, ordNo, jobNo, WoLabSeq) {
            MecDetExists();
            if (ordNo != "") {
                FetchJobGrid(ordNo);
            }
        }

        function FetchJobGrid(ordNo) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmTimeRegistration.aspx/FetchJobDet",
                data: "{'OrderNo':'" + ordNo + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (data) {
                    jQuery("#jobgrid").jqGrid('clearGridData');
                    for (i = 0; i < data.d.length; i++) {
                        mydata = data;
                        jQuery("#jobgrid").jqGrid('addRowData', i + 1, mydata.d[i]);
                    }
                }
            });

            jQuery("#jobgrid").setGridParam({ rowNum: pageSize }).trigger("reloadGrid");
            $("#jobgrid").jqGrid("hideCol", "subgrid");
        }

        function ClearAll() {
            $('#<%=txtClockoutDt.ClientID%>').val('');
            $('#<%=txtClockoutTime.ClientID%>').val('');
            $('#<%=txtClockinDt.ClientID%>').val('');
            $('#<%=txtClockinTime.ClientID%>').val('');
            $('#<%=txtMechId.ClientID%>').val('');
            $('#<%=txtOrdNo.ClientID%>').val('');
            $('#jobgrid').hide();
            $("#<%=ddlUnsoldTime.ClientID%>").attr('disabled', 'disabled');
        }

        function LoadMechanicData() {
            var mechId = $('#<%=txtMechId.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: "frmTimeRegistration.aspx/FetchMechanicDetails",
                data: "{'mechId':'" + mechId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    //debugger;
                    jQuery("#mechGrid").jqGrid('clearGridData');
                    for (i = 0; i < data.d.length; i++) {
                        mydata = data;
                        jQuery("#mechGrid").jqGrid('addRowData', i + 1, mydata.d[i]);
                        $('#<%=txtTUTime.ClientID%>').val(data.d[i].TotalTimeUnsold);
                        $('#<%=txtTOrdTime.ClientID%>').val(data.d[i].TotalTimeOnOrder);
                    }
                    jQuery("#mechGrid").setGridParam({ rowNum: pageSize }).trigger("reloadGrid");
                    $("#mechGrid").jqGrid("hideCol", "subgrid");

                },
                failure: function () {
                    alert("Failed!");
                }
            });
        }

        function clearSearchFields() {
            $('#<%=txtSearchDate.ClientID%>').val('');
            $('#<%=txtSearchMech.ClientID%>').val('');
            $('#<%=txtSearchOrderNo.ClientID%>').val('');
            $('#<%=ddlJobs.ClientID%>').empty();
            $('#<%=ddlJobs.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
            jQuery("#mechSearchGrid").jqGrid('clearGridData');
            $('#<%=hdnMechName.ClientID%>').val('');
        }

        function printSearchReport() {
            var fromDate = $('#<%=txtSearchDate.ClientID%>').val();
            var toDate = $('#<%=txtSearchDate.ClientID%>').val();
            var mechId = $('#<%=txtSearchMech.ClientID%>').val();
            var mechName = $('#<%=hdnMechName.ClientID%>').val();
            var orderNo = $('#<%=txtSearchOrderNo.ClientID%>').val();
            var jobNo = $('#<%=ddlJobs.ClientID%>').val();
            var flgOrders = $('#<%=chkorder.ClientID%>').is(':checked');
            var flgUnsold = $('#<%=chkdags.ClientID%>').is(':checked');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmTimeRegistration.aspx/PrintSearchReport",
                data: "{'mechId':'" + mechId + "','mechName':'" + mechName + "','orderNo':'" + orderNo + "','jobNo':'" + jobNo + "','fromDate':'" + fromDate + "','toDate':'" + toDate + "','flgOrders':'" + flgOrders + "','flgUnsold':'" + flgUnsold + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    if (Result.d.length > 0) {
                        var strValue = Result.d;
                        if (strValue != "") {
                            var Url = strValue;
                            window.open(Url, 'Reports', "menubar=no,location=no,status=no,scrollbars=yes,resizable=yes");
                        }
                    }
                }
            });
        }

        function printMechReport() {
            var fromDate = $('#<%=txtSearchDate.ClientID%>').val();
            var toDate = $('#<%=txtSearchDate.ClientID%>').val();
            var mechId = $('#<%=txtMechId.ClientID%>').val();
            var mechName = $('#<%=hdnFirstName.ClientID%>').val();
            var orderNo = "";//$('#<%=txtOrdNo.ClientID%>').val();
            var jobNo = "0";//jobId;
            var flgOrders = 'true'; //$('#<%=chkorder.ClientID%>').is(':checked');
            var flgUnsold = 'true';// $('#<%=chkdags.ClientID%>').is(':checked');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmTimeRegistration.aspx/PrintMechReport",
                data: "{'mechId':'" + mechId + "','mechName':'" + mechName + "','orderNo':'" + orderNo + "','jobNo':'" + jobNo + "','fromDate':'" + fromDate + "','toDate':'" + toDate + "','flgOrders':'" + flgOrders + "','flgUnsold':'" + flgUnsold + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    if (Result.d.length > 0) {
                        var strValue = Result.d;
                        if (strValue != "") {
                            var Url = strValue;
                            window.open(Url, 'Reports', "menubar=no,location=no,status=no,scrollbars=yes,resizable=yes");
                        }
                    }
                }
            });
        }

    </script>
    <%--<div class="inline fields">
            <input type="button" value="Stempling" id="btnStempling" class="ui btn cTab" data-tab="Stempling" />
            <input type="button" value="Stemplinger" id="btnStemplinger" class="ui btn cTab" data-tab="Stemplinger" />
        </div>--%><asp:Label ID="RTlblError" runat="server" CssClass="lblErr hidden"></asp:Label>
    <asp:HiddenField ID="hdnPageSize" runat="server" />
    <asp:HiddenField ID="hdnSelect" runat="server" />
    <asp:HiddenField ID="hdnFirstName" runat="server" />
    <asp:HiddenField ID="hdnMechName" runat="server" />
    <div class="ui top attached tabular menu">
        <a class="item active" data-tab="first">Stempling</a>
        <a class="item" data-tab="second">Stemplinger</a>
        <a class="item" id="clockinHistory" data-tab="third">Oversikt</a>
    </div>
    <div class="ui bottom attached tab segment active" data-tab="first">
        <div id="tabStempling" class="tTab">

            <div class="ui form stackable two column grid ">
                <div class="eight wide column">
                    <%--START Left Column--%>

                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Stempling</h3>
                        <div class="ui divider"></div>

                        <div class="fields">
                            <div class="four wide field">
                                <label id="lbMechId" runat="server">Mekaniker</label>
                                <asp:TextBox ID="txtMechId" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="twelve wide field"></div>
                        </div>

                        <div class="fields">
                            <div class="four wide field">
                                <label id="lbOrdNo" runat="server">Order No</label>
                                <asp:TextBox ID="txtOrdNo" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="four wide field">
                                <label id="lbClkInDt" runat="server">Clockin date</label>
                                <asp:TextBox ID="txtClockinDt" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>

                            <div class="four wide field">
                                <label id="lbClkInTime" runat="server">Clockin Time</label>
                                <asp:TextBox ID="txtClockinTime" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="four wide field"></div>
                        </div>
                        <div class="fields">
                            <div class="four wide field">
                                <label id="lbUnsoldTime" runat="server">Unsold Time</label>
                                <asp:DropDownList ID="ddlUnsoldTime" CssClass="carsInput" runat="server"></asp:DropDownList>
                            </div>
                            <div class="four wide field">
                                <label id="lbClkOutDt" runat="server">Clockout date</label>
                                <asp:TextBox ID="txtClockoutDt" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="four wide field">
                                <label id="lbClkOutTime" runat="server">Clockout Time</label>
                                <asp:TextBox ID="txtClockoutTime" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                        </div>
                        <div class="fields">
                            <div class="four wide field">
                                <div class="ui checkbox" style="padding-top: 10px">
                                    <asp:CheckBox ID="cbReasCode" runat="server" Text="Jobb ferdig" />
                                </div>
                            </div>
                            <div class="four wide field">
                                <input type="button" id="btnClockin" runat="server" value="Stemple inn" class="ui button wide positive" />
                            </div>
                            <div class="four wide field">
                                <input type="button" id="btnClockout" runat="server" value="Stemple ut" class="ui button wide negative" />
                            </div>

                        </div>
                        <div class="fields">
                            <div class="four wide field">
                                &nbsp;
                            </div>
                            <div class="four wide field">
                                <input type="button" id="btnManClockin" runat="server" title="Manuell stempling" value="Man. stempling" class="ui button wide blue" />
                            </div>
                            <div class="four wide field">
                                <input type="button" id="btnMechPrint" runat="server" value="Skriv ut" class="ui button wide" />
                            </div>
                            <div class="four wide field">
                            </div>


                        </div>
                    </div>
                </div>
                <%--START Right Column--%>
                <div class="eight wide column">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H1" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Ordrer</h3>

                        <table id="jobgrid"></table>
                        <div id="pager"></div>

                    </div>
                </div>
                <%--START Bottom Column--%>
                <div class="sixteen wide column">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H2" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Mekanikerdetaljer</h3>
                        <div class="fields">
                            <table id="mechGrid"></table>
                            <div id="mechpager"></div>
                        </div>
                        <div class="inline fields">
                            <div class="two wide field">
                                <label id="LbTUTime" runat="server">Sum tid dag</label>
                            </div>
                            <div class="two wide field">
                                <asp:TextBox ID="txtTUTime" runat="server" CssClass="carsInput" Style="text-align: center;"></asp:TextBox>
                            </div>
                            <div class="two wide field"></div>
                            <div class="two wide field">
                                <label id="lbTOrdTime" runat="server">Sum tid order</label>
                            </div>
                            <div class="two wide field">
                                <asp:TextBox ID="txtTOrdTime" runat="server" CssClass="carsInput" Style="text-align: center;"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="ui bottom attached tab segment" data-tab="second">
        <div id="tabOversikt" class="tTab">
            <div class="ui form stackable two column grid ">
                <div class="ten wide column">
                    <%--START Top Left Column--%>

                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H3" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Søk etter stempling</h3>
                        <div class="ui divider"></div>

                        <div class="fields">
                            <div class="four wide field">
                                <asp:Label ID="lblSearchMechanic" Text="Mekaniker" runat="server"></asp:Label>
                                <asp:TextBox ID="txtSearchMech" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="four wide field">
                                <asp:Label ID="lblSearchOrder" Text="Ordernr" runat="server"></asp:Label>
                                <asp:TextBox ID="txtSearchOrderNo" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="four wide field">
                                <asp:Label ID="Label7" Text="Jobnr " runat="server"></asp:Label><br />
                                <asp:DropDownList ID="ddlJobs" runat="server" Width="120px" class="carsInput"></asp:DropDownList>
                            </div>
                            <div class="four wide field">
                            </div>
                        </div>
                        <div class="fields">
                            <div class="four wide field">
                                <asp:Label ID="lblSearchDate" Text="Innstemplet Dato" runat="server" Width="120px"></asp:Label><br />
                                <asp:TextBox ID="txtSearchDate" runat="server" CssClass="carsInput" Width="150px"></asp:TextBox>
                            </div>
                            <div class="four wide field">
                                <asp:CheckBox ID="chkdags" runat="server" Text="Kun dagstemplinger" CssClass="ui checkbox" Width="150px" Checked="true" />
                            </div>
                            <div class="four wide field">
                                <asp:CheckBox ID="chkorder" runat="server" Text="Kun ordrestemplinger" CssClass="ui checkbox" Checked="true" />
                            </div>
                            <div class="four wide field">
                            </div>
                        </div>
                        <div class="fields">
                            <div class="four wide field">
                                <input id="btnSearch" runat="server" class="ui button wide positive" value="Search" type="button" />

                            </div>
                            <div class="four wide field">
                                <input id="btnReset" runat="server" class="ui button wide negative" value="Reset" type="button" />

                            </div>
                            <div class="four wide field">
                                <input id="btnPrint" runat="server" class="ui button wide" value="Skriv Ut" type="button" />
                            </div>
                            <div class="four wide field">
                            </div>
                        </div>


                    </div>
                </div>
                <div class="six wide column"></div>
                <div class="sixteen wide column">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H4" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Oversikt</h3>
                        <div class="fields">
                            <table id="mechSearchGrid"></table>
                            <div id="mechSearchPager"></div>
                        </div>
                        <div class="inline fields">
                            <div class="two wide field">
                                <asp:Label ID="lblTotUnsold" Text="Sum tid dag" runat="server" Width="100px"></asp:Label>
                            </div>
                            <div class="two wide field">
                                <asp:TextBox ID="txtTotUnsold" runat="server" CssClass="carsInput" Width="75px" Style="text-align: center;"></asp:TextBox>
                            </div>
                            <div class="two wide field"></div>
                            <div class="two wide field">
                                <asp:Label ID="lblTotOrder" Text="Sum tid order" runat="server" Width="100px"></asp:Label>
                            </div>
                            <div class="two wide field">
                                <asp:TextBox ID="txtTotOrder" runat="server" CssClass="carsInput" Width="75px" Style="text-align: center;"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="ui bottom attached tab segment" data-tab="third">
        <div id="tabHistory">
            <div class="ui form stackable two column grid ">
                <%--START Top Column--%>
                <div class="sixteen wide column">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H6" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Historikk</h3>
                        <div class="fields">
                            <div class="sixteen wide field">
                                <div id="history-table" class="mytabulatorclass"></div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="two wide field">
                                <asp:Label ID="lblOrderNo" Text="Ordrenr" runat="server"></asp:Label>
                                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:Label ID="lblMechanic" Text="Mekaniker" runat="server"></asp:Label>
                                <asp:TextBox ID="txtMechanic" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:Label ID="lblDate" Text="Innstemplet dato" runat="server"></asp:Label>
                                <asp:TextBox ID="txtDate" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                &nbsp;
                               <label id="lbSumTime" runat="server" style="text-align: center;">Sum tid dag</label>
                            </div>
                            <div class="two wide field">
                                &nbsp;
                    <asp:TextBox ID="txtSumTime" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                            <div class="two wide field"></div>
                            <div class="two wide field">
                                &nbsp;
                              <label id="lbSumTimeOrder" runat="server" style="text-align: center;">Sum tid order</label>
                            </div>
                            <div class="two wide field">
                                &nbsp;
                    <asp:TextBox ID="txtSumTimeOrder" runat="server" CssClass="carsInput"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                              <div class="six wide field">
                                <asp:CheckBox ID="chkClockIn" runat="server" Text="Kun dagstemplinger" CssClass="ui checkbox" Width="150px" Checked="false" />
                                <asp:CheckBox ID="chkOrderClockIn" runat="server" Text="Kun ordrestemplinger" CssClass="ui checkbox" Checked="false" />
                            </div>
                              <div class="two wide field">
                                   <input type="button" id="btnHistorySearch" runat="server" value="Søk" class="ui button wide blue" />
                            </div>
                            <div class="two wide field">
                                   <input type="button" id="btnHistoryPrint" runat="server" value="Skriv ut" class="ui button wide" />
                            </div>
                           

                        </div>
                        <div class="fields">
                            <div class="two wide field">
                              
                            </div>
                            <div class="two wide field">
                                 
                            </div>
                              <div class="two wide field">
                               
                            </div>
                           
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>

</asp:Content>

