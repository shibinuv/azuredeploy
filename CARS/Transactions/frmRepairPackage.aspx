<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmRepairPackage.aspx.vb" Inherits="CARS.frmRepairPackage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">


    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/2.3.2/jspdf.plugin.autotable.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            /*
                This method is called when the page is loaded to initialise different things
            */
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
                setTab('RepairPackageList');

                getDepartmentID();
                getWarehouseID();
                getLoginName();
                

                //loadTireDepth();
                var today = $.datepicker.formatDate('dd-mm-yy', new Date());


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


            function loadRPtable() {
                $("#RepairPackage-table").tabulator("setData", "frmRepairPackage.aspx/Fetch_RP_List", { 'wh': warehouseID, 'make': $("#<%=txtRPMake.ClientID%>").val(), 'jobid': $("#<%=txtRPJobId.ClientID%>").val(), 'title': $("#<%=txtRPTitle.ClientID%>").val() });
                $("#RepairPackage-table").tabulator("redraw", true);
            }

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
                   
                    setTimeout(function () {

                        editor.focus();
                        //editor.css("height", "100%");
                        editor.select();
                    }, 0);
                });
                return editor[0];

            }

            $("#RepairPackage-table").tabulator({
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
                    var selectedRows = $("#CL-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        if (row.getData().JOB_ID == selectedRows[0].getData().JOB_ID) {
                            return false;
                        }
                    }


                    return true; //alow selection of rows where the age is greater than 18
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    openModalRPInfo(row);
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
                    { title: "Merke.", field: "MAKE", align: "center", headerFilter: "input" },
                    {title: "Jobbpakke.", field: "JOB_ID", align: "center", headerFilter: "input" },
                    { title: "Tittel", field: "JOB_TITLE", align: "center", headerFilter: "input" },
                    { title: "Gruppe", field: "OPERATION_CODE", align: "center",  headerFilter: "input" },
                    { title: "Jobbklasse", field: "JOB_CLASS", align: "center",  headerFilter: "input" },
                    { title: "Fastpris", field: "FIXED_PRICE", align: "center",  formatter: "tickCross", headerFilter: "input" },
                    { title: "VK.Matr.", field: "ADD_GM", align: "center", formatter: "tickCross", headerFilter: "input" },
                    //{ title: "Salgspris", field: "SALESPRICE", align: "center", editor: customSelectEditor, headerFilter: "input" },
                    //{ title: "Inkl. MVA", field: "INC_VAT", align: "center", editor: customSelectEditor, headerFilter: "input" },
                      

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]

            });



            $("#RepairPackageNew-table").tabulator({
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
                     return true; 
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

                        title: "Varenr.", field: "ID_ITEM", align: "center", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Tekst.", field: "ITEM_DESC", align: "center"},
                    { title: "Type", field: "LINE_TYPE", align: "center"},
                    { title: "Antall", field: "ITEM_AVAIL_QTY", align: "center" },
                    { title: "Pris", field: "ITEM_PRICE", align: "center"},
                    { title: "Beløp", field: "TOTAL_PRICE", align: "center", bottomCalc: "sum" },
                    { title: "Leverandør", field: "SUPP_CURRENTNO", visible: false },
                    { title: "ITEM_CATG", field: "ID_ITEM_CATG", visible: false },
                    { title: "ID_RP_CODE", field: "ID_RP_CODE", visible: false },
                    { title: "ID_SPARE_SEQ", field: "ID_SPARE_SEQ", visible: false },

                ],
                footerElement: $("<div class='tabulator-footer'> <div class='ui form stackable two column grid'> <div class='sixteen wide column'><div class='fields'><div class='three wide field'><label id='lbl1' style='text-align: left'>Varenr</label><input type='text' id='txtSearchSpare'></div><div class='seven wide field'><label id='lbl2' style='text-align: left'>Tekst</label><input type='text' id='txtSearchText'></div><div class='two wide field'><label id='lbl3' style='text-align: left'>Type</label><select id='drpSearchType'><option value='0'>Velg..</option><option value='D'>Deler</option><option value='A'>Arbeid</option><option value='T'>Tekst</option><option value='K'>Kommentar</option><option value='T'>Tilbud</option><option value='F'>Fastpris</option></select></div><div class='two wide field'><label style='text-align: left' id='lbl4'>Antall</label><input type='text' id='txtSearchQty'></div><div class='two wide field'><label id='lbl5' style='text-align: left'>Pris</label><input type='text' id='txtSearchPrice'><label id='lblSuppCurrentno' style='display:none'></label><label id='lblItemCatg' style='display:none'></label></div></div></div></div></div>")[0],

            });

            $("#<%=btnRepairPackageNew.ClientID%>").on('click', function (e) {
                resetForms();
                //myNameSpace.set("po_modal_state", 1);
                initFirstModalStepView();
                $('#modal_rp_steps').modal('show');
             

            });
             $("#<%=searchbutton.ClientID%>").on('click', function (e) {
                 alert("søker..");
             
             });

            $("#txtSearchPrice").on('blur', function (e) {
                //alert("søker..");
                if ($('#txtSearchQty').val() != "" && $('#txtSearchPrice').val() != "") {
                    var Qty = $('#txtSearchQty').val()
                    Qty = parseFloat(Qty.replace(",", "."));
                    var Price = $('#txtSearchPrice').val();
                    Price = parseFloat(Price.replace(",", "."));

                    var total = Qty * Price
                    total = total.toFixed(2).replace(".", ",");
                }
                else {
                    total = "";
                }
               
                if ($('#drpSearchType').val() == '0') {
                    alert("Fyll inn alt sammen");
                }
                else {
                    if ($('#drpSearchType').val() == 'D' && $("#txtSearchQty").val() == "") {
                        alert("legg inn antall!");
                        $("#txtSearchQty").focus()
                    }
                    
                    else {
                        $("#RepairPackageNew-table").tabulator("addRow", { ID_ITEM: $('#txtSearchSpare').val(), ITEM_DESC: $('#txtSearchText').val(), LINE_TYPE: $('#drpSearchType').val(), ITEM_AVAIL_QTY: $('#txtSearchQty').val(), ITEM_PRICE: $('#txtSearchPrice').val(), TOTAL_PRICE: total, SUPP_CURRENTNO: $('#lblSuppCurrentno').html(), ID_ITEM_CATG: $('#lblItemCatg').html() }, false);
                        $('#txtSearchSpare').val("");
                        $('#txtSearchText').val("");
                        $('#drpSearchType').val('0');
                        $('#txtSearchQty').val("");
                        $('#txtSearchPrice').val("");
                        $('#txtSearchSpare').focus()
                    }
                }            
            });

            $("#txtSearchText").on('blur', function (e) {
                //alert("søker..");
                if ($("#txtSearchSpare").val() == "") {
                    if ($("#txtSearchText").val() != ""){
                    $("#drpSearchType").val('T');
                    $("#txtSearchQty").focus()
                    }
                    else {
                        $("#drpSearchType").focus();
                    }
                }
            });
           
            $("#txtSearchQty").on('blur', function (e) {
                //alert("søker..");
                if ($("#txtSearchSpare").val() == "" && $("#txtSearchQty").val() != "") {
                    $("#drpSearchType").val('A');
                    $("#txtSearchPrice").val('0,00')
                    $("#txtSearchPrice").select()
                }
            });

              $('#txtSearchSpare').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmWOSearch.aspx/SparePart_Search",
                        data: "{q:'" + $('#txtSearchSpare').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager. Trykk enter for å sjekke non-stock registeret.', value: '0', val: 'new' }]);
                                
                            } else
                                response($.map(data.d, function (item) {
                                    imake = item.ENV_ID_MAKE;
                                    iid = item.ID_ITEM;
                                    iwh = '1';
                                    return {
                                        label: item.ENV_ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        desc: item.ITEM_DESC,
                                        make: item.ENV_ID_MAKE,
                                        warehouse: item.ID_WH_ITEM,
                                        price: item.ITEM_PRICE,
                                        item: item.ID_ITEM,
                                        catg: item.ID_ITEM_CATG
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
                    
                    //alert(i.item.val + " - " + i.item.price + " - " + i.item.value);
                    $('#txtSearchSpare').val(i.item.val);
                    $('#txtSearchText').val(i.item.desc);
                    $('#drpSearchType').val('D');
                    //$('#txtSearchQty').val();
                    $('#txtSearchPrice').val(i.item.price);
                    $('#lblSuppCurrentno').html(i.item.make);
                    $('#lblItemCatg').html(i.item.catg);
                    $('#txtSearchQty').focus();

                }
            });

            function initFirstModalStepView() {
                //brings over various variables from grid to the modal window

                //alert("1st step");

                //content divs(tables)

                $('.modal_rp_divstep1').removeClass('hidden');


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

                $('#po_modal_close').show();

                //myNameSpace.set("po_modal_state", 1);
                $('#modal_rp_steps').modal('show');
                $('#modal_rp_steps').modal('refresh'); //refresh because modal exceeds so u cannot scroll if not refresh
            }

              $("#rp_modal_save").on('click', function (e) {
                  if ($("#<%=txtNewRPJobId.ClientID%>").val() != "" && $("#<%=txtNewRPTitle.ClientID%>").val() != "") {
                      //function add header
                      AddRepairPackageHead();
                      //function add lines
                      var rows = $("#RepairPackageNew-table").tabulator("getRows");
                      for (i = 0; i < rows.length; i++) {                         
                          var success = addItemToRP(rows[i]);
                          if (!success) {
                              alert("Noe gikk galt med lagring av varer på telleliste");
                          }
                      }
                  }
                  else {
                      swal('Legg til jobbid og tittel!');
                  }
                  loadRPtable();
            });
            
             function AddRepairPackageHead() {


                 var itemobj = insertRPHeadJSONstring();

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmRepairPackage.aspx/Add_RP_Head",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");

                        if (data.d == "0") {
                            systemMSG('success', 'pakkehode opprettet!', 5000);
                           

                        }
                        else if (data.d == "1") {
                            systemMSG('success', 'Pakkehode med data har blitt oppdatert!', 5000);
                            
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'Dekkpakke feilet. Se over dataene og korriger der det er feil eller kontakt system administrator.', 5000);

                    }
                });


            }

            function insertRPHeadJSONstring() {

                var RPItem = {};
                RPItem["JOB_ID"] = $('#<%=txtNewRPJobId.ClientID%>').val();
                RPItem["JOB_TITLE"] = $('#<%=txtNewRPTitle.ClientID%>').val();
                RPItem["MAKE"] = $('#<%=txtNewRPMake.ClientID%>').val();
                RPItem["OPERATION_CODE"] = $('#<%=txtNewRPOPCode.ClientID%>').val();
                RPItem["JOB_CLASS"] = $('#<%=txtNewRPJobClass.ClientID%>').val();
                RPItem["SUPPLIER_ID"] = $('#<%=txtNewRPSupId.ClientID%>').val();
                 if ($("#<%=chkFixedPrice.ClientID%>").is(':checked')) {
                     RPItem["FIXED_PRICE"] = 1;
                  }
                  else {
                     RPItem["FIXED_PRICE"] = 0;
                 }
                 if ($("#<%=chkAddGM.ClientID%>").is(':checked')) {
                     RPItem["ADD_GM"] = 1;
                  }
                  else {
                     RPItem["ADD_GM"] = 0;
                  }
                

                  var jsonRP = JSON.stringify(RPItem);
                  console.log(jsonRP);


                  return jsonRP;
            }

            function addItemToRP(row) {


                var itemobj = insertRPDetailJSONstring(row);

                var succeeded = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmRepairPackage.aspx/Add_RP_Item",
                    data: "{item:'" + itemobj + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        console.log("success");
                        succeeded = true;
                        systemMSG('success', 'PAKKEDETALJER OPPRETTET lagret', 5000);

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                        systemMSG('error', 'REPPAKKEDETALJER FEILET feilet ved lagring', 5000);
                    }
                });
                return succeeded

            }

            function insertRPDetailJSONstring(row) {
                var RPItem = {};
                RPItem["JOB_ID"] = $('#<%=txtNewRPJobId.ClientID%>').val();
                RPItem["ID_ITEM"] = row.getData().ID_ITEM;
                RPItem["ITEM_DESC"] = row.getData().ITEM_DESC;
                RPItem["LINE_TYPE"] = row.getData().LINE_TYPE;
                var qty = row.getData().ITEM_AVAIL_QTY;                

                //if (qty != "" || qty != "0") {
                if (qty != "") {                    
                    RPItem["ITEM_AVAIL_QTY"] = qty;
                }
                else {
                    RPItem["ITEM_AVAIL_QTY"] = 0;
                }
                var iprice = row.getData().ITEM_PRICE;
                if (iprice != "") {
                    iprice = iprice.replace(",", ".");
                    RPItem["ITEM_PRICE"] = iprice;
                }
                else {
                    RPItem["ITEM_PRICE"] = 0.00;
                }
                
                var totprice = row.getData().TOTAL_PRICE;
                if (totprice != "") {
                    totprice = totprice.replace(",", ".");
                    RPItem["TOTAL_PRICE"] = totprice;
                }
                else {
                    RPItem["TOTAL_PRICE"] = 0.00;
                }
                RPItem["SUPP_CURRENTNO"] = row.getData().SUPP_CURRENTNO;
                RPItem["ID_ITEM_CATG"] = row.getData().ID_ITEM_CATG;

                var jsonRP = JSON.stringify(RPItem);
                console.log(jsonRP);


                return jsonRP;
            }

            function openModalRPInfo(row) {

                //gets the selected row
               
                console.log(row);
                //checks if its a confirmed order and only to show the last tab in modal or if its not confirmed yet.

                          
                    //alert('1st step');
                    initFirstModalStepView(row);
                    var packageNo = row.getCell("JOB_ID").getValue();
                                       
                    FetchRepairPackageHead(packageNo);
                    FetchRepairPackageDetails(packageNo);
            }

            function FetchRepairPackageHead(packageNo) {
                $.ajax({
                    type: "POST",
                    url: "frmRepairPackage.aspx/FetchRPHead",
                    data: "{packageNo: '" + packageNo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //alert("stock after count is: " + data.d[0].vehicle_group);
                        console.log(data.d);
                        if (data.d[0].ADD_GM == 'True') {
                            $("#<%=chkAddGM.ClientID%>").prop('checked', true);
                        }
                        else {
                            $("#<%=chkAddGM.ClientID%>").prop('checked', false);
                        }
                        if (data.d[0].FIXED_PRICE == 'True') {
                            $("#<%=chkFixedPrice.ClientID%>").prop('checked', true);
                        }
                        else {
                            $("#<%=chkFixedPrice.ClientID%>").prop('checked', false);
                        }
                       
                        $('#<%=txtNewRPJobId.ClientID%>').val(data.d[0].JOB_ID);
                        $('#<%=txtNewRPTitle.ClientID%>').val(data.d[0].JOB_TITLE);
                        $('#<%=txtNewRPMake.ClientID%>').val(data.d[0].MAKE);
                        $('#<%=txtNewRPOPCode.ClientID%>').val(data.d[0].OPERATION_CODE);
                        $('#<%=txtNewRPJobClass.ClientID%>').val(data.d[0].JOB_CLASS);
                        $('#<%=txtNewRPSupId.ClientID%>').val(data.d[0].SUPP_CURRENTNO);
                       

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });

            };
            function FetchRepairPackageDetails(packageNo) {
                //brings over various variables from grid to the modal window
             
                    
                //content divs(tables)

              

                $("#RepairPackageNew-table").tabulator("setData", "frmRepairPackage.aspx/FetchRPDetails", { 'JOB_ID': packageNo })
                    .then(function () {
                        //run code after table has been successfuly updated
                        $("#RepairPackageNew-table").tabulator("redraw", true);
                        var rows2 = $("#RepairPackageNew-table").tabulator("getRows");

                    })
                .catch(function (error) {
                    //handle error loading data
                    swal("Finner ikke data! Kontakt systemadministrator");
                });


                //$('#modal_cl_steps').modal('hide');
            }
            function resetForms() {
                $("#<%=chkAddGM.ClientID%>").prop('checked', false);
                $("#<%=chkFixedPrice.ClientID%>").prop('checked', false);
                $('#<%=txtNewRPJobId.ClientID%>').val("");
                $('#<%=txtNewRPTitle.ClientID%>').val("");
                $('#<%=txtNewRPMake.ClientID%>').val("");
                $('#<%=txtNewRPOPCode.ClientID%>').val("");
                $('#<%=txtNewRPJobClass.ClientID%>').val("");
                $('#<%=txtNewRPSupId.ClientID%>').val("");
                $("#RepairPackageNew-table").tabulator("clearData");
            }


            loadRPtable();
            //end of document ready
            $("#rp_modal_cancel").on('click', function (e) {
                clearAll();
                $('#modal_rp_steps').modal('hide');
            });


            function clearAll() {
                $('#txtSearchSpare').val("");
                $('#txtSearchText').val("");
                $('#drpSearchType').val('0');
                $('#txtSearchQty').val("");
                $('#txtSearchPrice').val("");
            }


            $.contextMenu({
            selector: '#RepairPackage-table .tabulator-selected',   //only trigger contextmenu on selected rows in table
            items: {
                deletePO: {
                    name: "Slett pakke",
                    icon: "attach",
                    callback: function (key, opt) {
                        var rows = $("#RepairPackage-table").tabulator("getSelectedRows");
                        var row = rows[0];
                         var rp_code = row.getCell("JOB_ID").getValue();
                        var id_spareseq = "0";
                        var rp_type = "RP_HEAD"; // for repair package lines
                         console.log(row + "rp_code:"+rp_code+ "id_spareseq:"+id_spareseq+ "rp_type:"+rp_type);
                        if (confirm("Slette pakke?")) {
                            deleteRepairPackageDetails(rp_code,id_spareseq,rp_type);
                        }
                    }                    
                }
            }
        });


        $.contextMenu({
            selector: '#RepairPackageNew-table .tabulator-selected',   //only trigger contextmenu on selected rows in table
            items: {
                deletePO: {
                    name: "Slett pakke",
                    icon: "attach",
                    callback: function (key, opt) {
                        var rows = $("#RepairPackageNew-table").tabulator("getSelectedRows");
                        var row = rows[0];
                        var rp_code =  row.getCell("ID_RP_CODE").getValue();
                        var id_spareseq = row.getCell("ID_SPARE_SEQ").getValue();
                        var rp_type = "RP_LINES"; // for repair package lines

                        console.log(row + "rp_code:"+rp_code+ "id_spareseq:"+id_spareseq+ "rp_type:"+rp_type);
                        if (confirm("Slette Reparasjons pakkedetaljer?")) {
                            deleteRepairPackageDetails(rp_code,id_spareseq,rp_type);
                        }
                    }
                }
            }
        });

            function deleteRepairPackageDetails(rp_code, id_spareseq, rp_type) {
                //var rp_type = "RP_LINES";
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmRepairPackage.aspx/Delete_RepairPackage",
                    data: "{'rp_code':'" + rp_code + "', 'rp_type': '" + rp_type + "', 'id_spareseq': '" + id_spareseq + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        if (data.d == "DELETED") {
                            swal('Record slettet');
                            if (rp_type == "RP_HEAD") {
                                loadRPtable();
                            } else if (rp_type == "RP_LINES") {
                                FetchRepairPackageDetails(rp_code);
                            }
                        }
                        else if (data.d == "NEXISTS") {
                            swal('Reparasjonspakken eksisterer ikke');
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        systemMSG('error', 'Reparasjonspakken feilet. Se over dataene og korriger der det er feil eller kontakt system administrator', 5000);
                    }
                });

            }



        });


        


    </script>

    

    <asp:HiddenField ID="hdnSelect" runat="server" />
    <div class="overlayHide">
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
    </div>
    <div id="systemMessage" class="ui message"></div>

    <div class="ui grid">
        <div id="tabFrame" class="sixteen wide column">
            <input type="button" id="btnRepairPackageList" value="Pakkeoversikt" class="cTab ui btn" data-tab="RepairPackageList" />
            <input type="button" id="btnRepairPackageDetails" value="Pakkedetaljer" class="cTab ui btn" data-tab="RepairPackageDetails" />
        </div>
    </div>


    <%--Begin tab PurchaseOrders--%>

    <div id="tabRepairPackageList" class="tTab">
        <div class="ui form stackable two column grid ">
            <div class="four wide column">
                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                    <h3 id="lblRepPackageSearch" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Søk etter pakke</h3>
                    <label class="inHeaderCheckbox">
                        Vis/Skjul søk
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
                                <label id="lblRPMake" runat="server">Bilmerke</label>
                                <asp:TextBox ID="txtRPMake" runat="server" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="Label1" runat="server">&nbsp;</label>
                                <input type="button" id="btnRPNewMake" runat="server" value="+" class="ui btn CarsBoxes" />
                            </div>


                        </div>

                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblRPJobId" runat="server">Jobb ID</label>
                                <asp:TextBox ID="txtRPJobId" runat="server"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                                <label id="lblRPTitle" runat="server">Tittel</label>
                                <asp:TextBox ID="txtRPTitle" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="sixteen wide field">
                                <div class="ui toggle checkbox">
                                    <input id="chkSearchClosed" runat="server" type="checkbox" name="public" />
                                    <label>Kun dette bilmerket</label>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="sixteen wide field">
                                <div class="ui toggle checkbox">
                                    <input id="Checkbox1" runat="server" type="checkbox" name="public" />
                                    <label>Ta med chassinr.</label>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="sixteen wide field">
                                <div class="ui toggle checkbox">
                                    <input id="Checkbox2" runat="server" type="checkbox" name="public" />
                                    <label>Pluss generelle</label>
                                </div>
                            </div>
                        </div>


                        <div class="fields">
                            <div class="eight wide field">

                                <input type="button" id="searchbutton" runat="server" value="Søk" class="ui btn CarsBoxes" />

                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnRepairPackageNew" runat="server" value="Ny pakke" class="ui btn CarsBoxes" />
                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <%--End of Purchase order segment--%>
            <div class="twelve wide column">
                <div id="RepairPackage-table" class="mytabulatorclass">
                </div>
            </div>




        </div>
    </div>

    <%--End tab PurchaseOrders--%>


    <%--Begin tab NewCountingList--%>

    <div id="tabRepairPackageDetails" class="tTab">
    </div>


    <div class="fullscreen ui modal" id="modal_rp_steps">
        <i class="close icon"></i>
        <a class="ui red ribbon label" id="redRibbonPOmodal"></a>
        <div class="header">
            <div class="ui two top attached steps">
                <div class="active step" id="step_cl_first">
                    <i class="dollar sign icon"></i>
                    <div class="content">
                        <div class="title">Legg til kjøretøy og kunde</div>
                        <div class="description">LEgger til kunde og kjøretøy på dekkpakken.</div>
                    </div>
                </div>
                <div class="disabled step" id="step_cl_second">
                    <i class="pencil icon"></i>
                    <div class="content">
                        <div class="title">Legg til dekkpakke detaljer</div>
                        <div class="description">Legger til rett informasjon på dekkpakken</div>
                    </div>
                </div>

            </div>
        </div>
        <div class="content">

            <div class="modal_rp_divstep1">

                <div class="ui header">Legg til kundedetaljer</div>

                <div class="ui form stackable two column grid ">
                    
                    <div class="four wide column">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblPurchaseDetails" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Generelt</h3>

                            <asp:Label ID="lblOrderDate" class="inHeaderTextField4" Text="" runat="server"></asp:Label>


                            <div class="itemadd-container">

                                <div class="fields">
                                    <div class="eight wide field">
                                        <label id="lblTPVehicleSearch" runat="server">Jobbid</label>
                                        <asp:TextBox ID="txtNewRPJobId" runat="server" ></asp:TextBox>
                                    </div>
                                  
                                </div>
                                <div class="fields">
                                    <div class="sixteen wide field">
                                        <label id="lblCreateFromCatg" runat="server">Tittel</label>
                                        <asp:TextBox ID="txtNewRPTitle" runat="server" CssClass="" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                  
                                </div>
                                <div class="fields">
                                    <div class="eight wide field">
                                        <label id="lblCreateMake" runat="server">Bilmerke</label>
                                        <asp:TextBox ID="txtNewRPMake" runat="server" CssClass="" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                    <div class="eight wide field">
                                        <label id="lblCreateModel" runat="server">Op.kode</label>
                                        <asp:TextBox ID="txtNewRPOPCode" runat="server" CssClass="" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>

                                    </div>
                                </div>
                                <div class="fields">
                                    <div class="eight wide field">
                                        <label id="lblCreateOrgTireDimFront" runat="server">Jobbklasse</label>
                                        <asp:TextBox ID="txtNewRPJobClass" runat="server" CssClass="" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                    <div class="eight wide field">
                                        <label id="lblCreateOrgTireDimBack" runat="server">Lev.id.</label>
                                        <asp:TextBox ID="txtNewRPSupId" runat="server" CssClass="" data-submit="ID_ITEM" meta:resourcekey="txtTechMakeResource1"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="fields">
                                    <div class="eight wide field">
                                         <div class="ui checkbox">
                                    <input id="chkFixedPrice" runat="server" type="checkbox" name="public" />
                                    <label>Fastpris</label>
                                </div>
                                    </div>
                                    <div class="eight wide field">
                                          <div class="ui checkbox">
                                    <input id="chkAddGM" runat="server" type="checkbox" name="public" />
                                    <label>Legg til VM</label>
                                </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="twelve wide column">
                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Pakkeopplysninger</h3>
                           
                         
                               <div id="RepairPackageNew-table" class="mytabulatorclass"></div>
                            
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="actions">
            <button class="ui red button" id="rp_modal_cancel">
                <i class="save icon"></i>
                Avbryt
            </button>
            <div class="ui positive right labeled icon button" id="rp_modal_save">
                <div>Lagre</div>

                <i class="chevron right icon"></i>
            </div>




        </div>
    </div>


</asp:Content>




