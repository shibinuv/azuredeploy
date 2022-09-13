    <%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="LocalSPDetail.aspx.vb" Inherits="CARS.LocalSPDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
   
       <style type="text/css">
    
     .ui.tabular.menu  {
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
    .ui.tabular.menu > .disabled.item {
 opacity: 0.45 !important;  
}

.disabled {
   pointer-events: none;
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

   .container {
  position: absolute;
  margin: auto;
  top: 0;
  left: 35%;
  bottom: -45px;
  width: 300px;
  height: 100px;
}
.container .search {
  position: absolute;
  margin: auto;
  top: 0;
  right: 0;
  bottom: -5px;
  left: 35%;
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
  top: 35px;
  right: 0;
  bottom: -30px;
  left: 22%;
  width:220px !important;
  height: 35px;
  outline: none;
  border: none;
  background: white;
  color: black;
  /*text-shadow: 0 0 10px crimson;*/
  padding: 0 80px 0 20px !important;
  border-radius: 30px !important;
  box-shadow: 0 0 25px 0 #2185d0, 0 20px 25px 0 rgba(0, 0, 0, 0.1) !important;
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
        var seperator = '<%= Session("Decimal_Seperator") %>';
        $(document).ready(function () {
            var warehouseID = '';     //global variable in this file
            var departmentID = '';     //global variable in this file
            var debug = true;
            loadInit();
             $('.menu .item')
               .tab()
               ; //activate the tabs
            var mode = 'add';
            /*Verdier for å kunne håndtere endring på salgsprisen*/
            var oldsalesprice, changedsalesprice, newsalesprice = 0.00;
            var clicked = 0;
            var justcreated = 0;

            function loadInit() {
                 $('#aspnetForm')[0].reset(); 
               
                   
                buildItemHistory();
                //setTab('SpareInfo');
                loadMakeCode();
                loadCategory();
                loadUnitItem();
                loadEditMake();
                
                getWarehouseID();
                getDepartmentID();
                
                $('#<%=txtInfoStockQuantity.ClientID%>').val('0');
                <%-- $('#<%=txtAdvCategory.ClientID%>').val('0');--%>
                $('#<%=txtSpareNo.ClientID%>').focus();

                $('#aspnetForm input').attr("disabled", "disabled");
                
                $('#<%=drpCategory.ClientID%>').attr("disabled", "disabled");
                $('#txtSpareSearch').removeAttr("disabled");
                $('#<%=txtSpareNo.ClientID%>').removeAttr("disabled");
                $('#<%=txtSpareNo.ClientID%>').focus();
                $('.ui.attached.tabular.menu > .item').addClass('disabled');
                $('.ui.attached.tabular.menu > .item.active').removeClass('disabled');

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

            var historyIndex = {};
            
            function returnYearLabel(year) { // returns a label for the title based on current year
                var currentYear = new Date().getFullYear();
                var title;
                switch (year) {
                    case currentYear:
                        title = 'Omsetning hittil i år (' + year + ')';
                        break;
                    case currentYear - 1:
                        title = 'Omsetning i fjor (' + year + ')';
                        break;
                    default:
                        title = 'Omsetning i ' + year;
                }
                return title;
            }
            function showSelectedYear(year) {
                $('.ih-year').removeClass('active');
                $('.ih-year[data-year="' + year + '"]').addClass('active');
            }
            function buildItemHistory() { // builds the grid for the item history with all values as 0, also builds the dropdowns for selecting years
                var currentYear = new Date().getFullYear();
                var years = [currentYear];
                var months = ['Januar', 'Februar', 'Mars', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Desember'];
                var yearCount = 1;
                while (yearCount < 5) {
                    years.push(currentYear - yearCount);
                    yearCount++;
                }
                var IPH = $('#itemHistory-PH');
                var IPHobj = '';
                var _select = $('#ddlItemHistory-SelYear, #ddlItemHistory-ComYear'); // grabs the select for selection year
                $.each(years, function (index, year) {
                    _select.append(
                        $('<option></option>').val(year).html(returnYearLabel(year)) // populates the selected year and comparing year ddl
                    );
                    $('#ddlItemHistory-SelYear, #ddlItemHistory-ComYear').dropdown();
                    IPHobj += '\
                        <div class="ih-year" data-year=\"' + year + '\">\
                            <h3>' + returnYearLabel(year) + '</h3>\
                            <div class=\"content\">\
                                <div class=\"ui grid ih-container\">\
                                    <div class=\"four column row ih-header\">\
                                        <div class=\"column ih-period\">Periode</div>\
                                        <div class=\"column ih-quantity\">Antall</div>\
                                        <div class=\"column ih-cost\">Kost</div>\
                                        <div class=\"column ih-amount\">Beløp</div>\
                                    </div>\
                    ';
                    $.each(months, function (index, month) {
                        var thisMonth = index + 1;
                        IPHobj += '\
                            <div class=\"four column row ih-m_' + thisMonth + ' ih-y_' + year + '\">\
                                <div class=\"column ih-period\">' + month + '</div>\
                                <div class=\"column ih-quantity\">'+ fnformatDecimalValue("0,00", seperator) + '</div>\
                                <div class=\"column ih-cost\">'+ fnformatDecimalValue("0,00", seperator) + '</div>\
                                <div class=\"column ih-amount\">'+ fnformatDecimalValue("0,00", seperator) + '</div>\
                            </div>\
                        ';
                    });
                    IPHobj += '\
                            <div class=\"four column row ih-m_total ih-y_' + year + '\">\
                                <div class=\"column ih-period\">Total</div>\
                                <div class=\"column ih-quantity\">'+ fnformatDecimalValue("0,00", seperator) + '</div>\
                                <div class=\"column ih-cost\">'+ fnformatDecimalValue("0,00", seperator) + '</div>\
                                <div class=\"column ih-amount\">'+ fnformatDecimalValue("0,00", seperator) + '</div>\
                            </div>\
                        </div>\
                    </div>\
                </div>\
                    ';
                });
                IPHobj += '</div>';
                IPH.append(IPHobj);

                return true;
            }
            function populateItemHistory(ID_ITEM, ID_MAKE, ID_WAREHOUSE) { // populates the grids based on year from the database
                var currentYear = new Date().getFullYear();
                $.ajax({
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    url: "LocalSPDetail.aspx/FetchItemsHistory",
                    data: '{"ID_ITEM": "' + ID_ITEM + '", "ID_MAKE": "' + ID_MAKE + '", "ID_WAREHOUSE": "' + ID_WAREHOUSE + '"}',
                    dataType: "json",
                    async: false,
                    success: function (result) {
                        array = result.d;
                        for (var i = 0, len = array.length; i < len; i++) {
                            historyIndex[array[i].M_YEAR + '_' + array[i].M_PERIOD] = array[i];
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                   } 
                });
                $.each(historyIndex, function (index, key) {
                    //var quantity = key.M_TOTAL_SOLD_QTY.toFixed(2).replace('.', ',');
                    //var cost = key.M_TOTAL_COST.toFixed(2).replace('.', ',');
                    //var amount = key.M_TOTAL_GROSS.toFixed(2).replace('.', ',');
                    var quantity = fnreformatDecimal(key.M_TOTAL_SOLD_QTY.toFixed(2), seperator);
                    var cost = fnreformatDecimal(key.M_TOTAL_COST.toFixed(2), seperator);
                    var amount = fnreformatDecimal(key.M_TOTAL_GROSS.toFixed(2), seperator);
                    pushItemHistoryValue(key.M_YEAR, key.M_PERIOD, quantity, cost, amount);
                });
                setChartData(currentYear, ''); // updates the chart values
                showSelectedYear(currentYear);
            }
            function pushItemHistoryValue(year, month, quantity, cost, amount) { // function for pushing values into the grid
                var period = '.ih-y_' + year + '.ih-m_' + month + ' >';
                $(period + 'div.ih-quantity').html(quantity);
                $(period + 'div.ih-cost').html(cost);
                $(period + 'div.ih-amount').html(amount);
                
            }
        
            var utilityHistory;
            var ctx = document.getElementById("ihChart");

            window.chartColors = {
                red: 'rgb(255, 99, 132)',
                orange: 'rgb(255, 159, 64)',
                yellow: 'rgb(255, 205, 86)',
                green: 'rgb(75, 192, 192)',
                blue: 'rgb(54, 162, 235)',
                purple: 'rgb(153, 102, 255)',
                grey: 'rgb(231,233,237)'
            };

            window.randomScalingFactor = function () {
                return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100);
            }
            var curYearData = [];
            var cmpYearData = [];
            function setChartData(curYear, cmpYear) {
                if (debug) { console.log('setChartData initiated...'); }
                if (debug) { console.log('Current Year is set to ' + curYear + ' comparing to year ' + cmpYear + '.'); }
                curYearArray = [];
                $('.ih-y_' + curYear + ':not(.ih-m_total) .ih-quantity').each(function (index, key) {
                    //curYearArray.push($(this).html().replace(',', '.'));
                    curYearArray.push(fnformatDecimalValue($(this).html(), seperator));
                });
                curYearData = curYearArray;
                cmpYearArray = [];
                $('.ih-y_' + cmpYear + ':not(.ih-m_total) .ih-quantity').each(function (index, key) {
                    //cmpYearArray.push($(this).html().replace(',', '.'));
                    cmpYearArray.push(fnformatDecimalValue($(this).html(), seperator));
                });
                cmpYearData = cmpYearArray;
                if (debug) { console.log('Data for current year is set to ' + curYearData); }
                if (debug) { console.log('Data for comparing year is set to ' + cmpYearData); }
                buildChart(curYear, cmpYear);
            }
            function buildChart(curYear, cmpYear) {
                if (debug) { console.log('Build chart initiated...'); }
                var currentYear = curYearData
                var compareYear = cmpYearData
                if (window.utilityHistory != null) {
                    window.utilityHistory.destroy();
                }
                var ds = [];
                if (compareYear.length > 0 && currentYear.length > 0) {
                    ds.push(currentYear, compareYear);
                }
                
                else
                {
                    ds.push(currentYear);
                }
                console.log(ds);
                window.utilityHistory = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: ["Januar", "Februar", "Mars", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Desember"],
                        datasets: [{
                            label: curYear,
                            data: currentYear,
                            borderWidth: 1,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)'
                        },
                        {
                            label: cmpYear,
                            data: compareYear,
                            borderWidth: 1,
                            backgroundColor: 'rgba(255, 99, 132, 0.2)'
                        }
                        ]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                });
                window.utilityHistory.update();
                window.utilityHistory.resize();
                $('#spSelYear').html($('#ddlItemHistory-SelYear option:selected').text());
            }


          
            $("#modal_po_steps").modal('setting', {
                autofocus: false,
                onHidden: function () {
                    console.log("NÅ ER JEG BORTEEEEEE");
                    

                    if (clicked == 1) {
                        $('#<%=txtsparedesc.ClientID%>').removeAttr("disabled");
                        setTimeout(function () {
                         $('#<%=txtsparedesc.ClientID%>').focus();
                        }, 10);
                        clicked = 0;
                    }
                    


                },


            });
               
           $("#txtbxStartDate").datepicker({
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
                onSelect: function(date)
                {
                    
                }
                 
                
                
            });

             $("#txtbxEndDate").datepicker({
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
                minDate: 1,
                onSelect: function(date)
                {
                    
                }
                 
                
                
            });


            $('#<%=drpCategory.ClientID%>').on('change', function () {
                //if
                //else
                if ($('#<%=drpCategory.ClientID%>').val() == 0) {
                    swal("Du må velge varegruppe for å få lov å lagre varen videre.")
                }
                else {
                    if ($('#<%=lblNewItem.ClientID%>').css("visibility") !== "hidden") {



                        saveNewItem()
                        $('#<%=lblNewItem.ClientID%>').css("visibility", "hidden");
                    $('#aspnetForm input').removeAttr('disabled');

                    $('#<%=txtSpareNo.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtsparedesc.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtInfoSupplier.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtInfoSupplierName.ClientID%>').attr("disabled", "disabled");
                        $('.ui.attached.tabular.menu > .item').removeClass('disabled');
                        $('.disabledBox').attr("disabled", "disabled");
                        $('#txtbxCampaignPrice').removeClass("disabled");
                    }
                }

            });


            $('#ddlItemHistory-SelYear, #ddlItemHistory-ComYear').on('change', function () {
                var sel = $('#ddlItemHistory-SelYear').val();
                var com = $('#ddlItemHistory-ComYear').val();
                showSelectedYear(sel);
                setChartData(sel, com);
                if (debug) { console.log("sel " + sel + " com " + com); }
            });

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

            var make = getUrlParameter('id_make');
            var item = getUrlParameter('id_item');
            var wh = getUrlParameter('id_wh_item');
            var paramRowId = getUrlParameter('row_id');
            if (typeof make !== "undefined" && item != "undefined") {
                setTimeout(function () { FetchSparePartDetails(item, make, wh); }, 2000);
                
                $('#<%=lblNewItem.ClientID%>').css("visibility", "hidden");
                $('#aspnetForm input').removeAttr('disabled');

                $('#<%=txtSpareNo.ClientID%>').attr("disabled", "disabled");
                $('#<%=txtsparedesc.ClientID%>').attr("disabled", "disabled");  
                 $('#<%=txtInfoSupplier.ClientID%>').attr("disabled", "disabled");  
                $('#<%=txtInfoSupplierName.ClientID%>').attr("disabled", "disabled");
                $('.ui.attached.tabular.menu > .item').removeClass('disabled');
                $('.disabledBox').attr("disabled", "disabled");
                $('#txtbxCampaignPrice').removeAttr("disabled");
            }  
            else if (make == "undefined" || item == "undefined") {
               
                systemMSG('error', 'Not all values were sent over. Please try again!', 4000);
            }

            if ((pageNameFrom == "PurchaseOrder") && pageNameFrom != undefined) {
                $('#mainHeader').hide();
                $('#second').hide();
            }
            if ((pageNameFrom == "frmWOJobDetails") && pageNameFrom != undefined) {
                $('#mainHeader').hide();
                $('#second').hide();
                
            }

            function getWarehouseID() {
                console.log("inside getware");
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "LocalSPDetail.aspx/LoadWarehouseDetails",
                    data: '{}',
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        {
                            if (data.d.length != 0) {
                                data.d[0];
                                
                                warehouseID = data.d[0].WarehouseID;

                                $('#<%=txtAdvWarehouse.ClientID%>').val(warehouseID);
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

          

            $('#<%=txtSpareNo.ClientID%>').keydown(function (e) {
                var code = e.keyCode || e.which;

                if (code === 9) {
                    if ($('#<%=txtSpareNo.ClientID%>').val().trim() !== '') {
                         //tab is hit and value is not empty
                        e.preventDefault();
                       var returnvalue =  SearchSparePartOnlySpare($('#<%=txtSpareNo.ClientID%>').val());
                                           
                        if (returnvalue == 1) {
                             
                            $("#item-table-modal").tabulator("setData", "LocalSPDetail.aspx/SparePart_Search_Only_SparePart", { 'q': $('#<%=txtSpareNo.ClientID%>').val() });

                            $('#modal_po_steps').modal('show');
                            if (!$('#btnModalChooseItem').hasClass("disabled")) {
                                $('#btnModalChooseItem').addClass("disabled");
                            }
                            
                            
                        }

                        else {
                            e.preventDefault();
                            $('#<%=txtsparedesc.ClientID%>').removeAttr("disabled");
                             $('#<%=txtsparedesc.ClientID%>').focus()
                        }
        
                    }
                    
                   
                }
            });

            $('#<%=txtsparedesc.ClientID%>').keydown(function (e) {
                var code = e.keyCode || e.which;

                if (code === 9) {
                    if ($('#<%=txtsparedesc.ClientID %>').val().trim() !== '') {
                         //tab is hit and value is not empty
                        
                          e.preventDefault();
                        $('#<%=txtInfoSupplier.ClientID%>').removeAttr("disabled");
                        $('#<%=drpCategory.ClientID%>').removeAttr("disabled");
                          $('#<%=txtInfoSupplier.ClientID%>').focus()
                    }
                    
                   
                }
            });

         
            $('#<%=txtInfoSupplier.ClientID%>').on('blur', function (e) {
                
                
                    if ($('#<%=txtInfoSupplier.ClientID %>').val().trim() !== '') {
                        //tab is hit and value is not empty
                      
                        

                          
                           // loadCategory()
                            
                             e.preventDefault();
                            $('#<%=drpCategory.ClientID%>').focus()


                        
                        


                    }
                
            });

            

             $('#txtbxCampaignPrice').keydown(function (e) {
                var code = e.keyCode || e.which;

                if (code === 9) { //Triggers on code 9, which is TAB button
                    swal("Legge inn kampanjepris?", {
                            buttons: {
                                cancel: "Avbryt",

                                OK: true,
                            },
                        })
                            .then((value) => {
                                switch (value) {

                                    case null:
                                       

                                        break;

                                    default:
                                        addCampaignPrice();
                                }
                            });
                    
                   
                }
            });



             function convertDate(date)
            {
                var newDateFormat = date.split("-");
                var tmp = newDateFormat[0];
                newDateFormat[0] = newDateFormat[2];
                newDateFormat[2] = tmp;
                newDateFormat = newDateFormat.join("");
                return newDateFormat;
            }

            function addCampaignPrice() {
                var campaignPrice = $('#txtbxCampaignPrice').val();
                campaignPrice = campaignPrice.toString();

                //if (campaignPrice.indexOf(',') > -1) { campaignPrice = parseFloat(campaignPrice.replace(',', '.')); console.log("inside indexof campaignprice " + campaignPrice); }
                if (campaignPrice.indexOf(',') > -1) { campaignPrice = parseFloat(fnformatDecimalValue(campaignPrice, seperator)); console.log("inside indexof campaignprice " + campaignPrice); }
                else {
                    campaignPrice = parseFloat(campaignPrice);
                }

                var lastCostPrice = $('#<%=txtInfoLastCostNok.ClientID%>').val();
                //(string) 700,50 fnformatDecimalValue(data.d.CURRENCY_RATE, seperator);
                if (lastCostPrice.indexOf(',') > -1) { lastCostPrice = parseFloat(fnformatDecimalValue(lastCostPrice, seperator)); console.log("inside indexof lastcostprice " + lastCostPrice); }
                else {
                    lastCostPrice = parseFloat(lastCostPrice);
                }

                if (campaignPrice < lastCostPrice) {
                    swal("Salgspris kan ikke være lavere enn kostpris", {
                        buttons: {
                            OK: true,
                        },
                    })
                        .then((value) => {
                            switch (value) {

                                case null:
                                    return;

                                default:
                                    return;
                            }
                        });
                }
                else {
                    var start = convertDate($('#txtbxStartDate').val());
                    var end = convertDate($('#txtbxEndDate').val());

                    $.ajax({
                        type: "POST",
                        url: "LocalSPDetail.aspx/addCampaignPrice",

                        data: "{suppcurrentno:'" + $('#<%=txtInfoSupplier.ClientID%>').val() + "',id_item:'" + $('#<%=txtSpareNo.ClientID%>').val() + "',start_date:'" + start + "',end_date:'" + end + "',price:'" + $('#txtbxCampaignPrice').val() + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         console.log(data.d);
                         $("#campaign-table-modal").tabulator("addRow", { CAMPAIGNPRICE: $('#txtbxCampaignPrice').val(), START_DATE: $('#txtbxStartDate').val(), END_DATE: $('#txtbxEndDate').val() }, true);
                         $("#campaignIcon").css("color", "red");


                     },
                     failure: function () {
                         alert("Failed!");
                     }
                 });
                }
            }


            function return_item(oldqty, newqty,changeqty) {

                var return_item = {};

                return_item["STOCK_ADJ_WAREHOUSE"] = $('#<%=txtAdvWarehouse.ClientID%>').val(); 
                return_item["STOCK_ADJ_NO"] = ""; 
                return_item["STOCK_ADJ_TYPE"] = "RETUR";
                return_item["STOCK_ADJ_ID_ITEM"] = $('#<%=txtSpareNo.ClientID%>').val()
                return_item["STOCK_ADJ_SIGNATURE"] = "22admin"; 
                return_item["STOCK_ADJ_SUPPLIER"] =        $('#<%=txtInfoSupplier.ClientID%>').val()
                return_item["STOCK_ADJ_CATG"] = $('#<%=drpCategory.ClientID%>').val();
                 return_item["STOCK_ADJ_TEXT"] = ""; 
                 return_item["STOCK_ADJ_OLD_QTY"] = oldqty; 
                 return_item["STOCK_ADJ_NEW_QTY"] = newqty; 
                 return_item["STOCK_ADJ_CHANGED_QTY"] = changeqty; 
              
         
              

                let jsonReturnItem = JSON.stringify(return_item);

                 $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "LocalSPDetail.aspx/return_item",
                    data: "{returned_item:'" + jsonReturnItem + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        {
                            if (data.d.length != 0) {
                             //oppdater beholdning
                                UpdateStockQty(newqty);
                                
                                
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

            function hideStuff() {
                $('#modal_po_steps').modal('hide');

                $('#aspnetForm input').removeAttr('disabled');
                $('.disabledBox').attr("disabled", "disabled");
                
                $('#<%=txtSpareNo.ClientID%>').attr("disabled", "disabled");
                $('#<%=txtsparedesc.ClientID%>').attr("disabled", "disabled");
                $('#<%=txtInfoSupplier.ClientID%>').attr("disabled", "disabled");
                $('#<%=txtInfoSupplierName.ClientID%>').attr("disabled", "disabled");
                $('.ui.attached.tabular.menu > .item').removeClass('disabled');

                $('#<%=lblNewItem.ClientID%>').css("visibility", "hidden");
            }
            
            
            

             $('#btnModalNewItem').on('click', function (e) {
              
                 clicked = 1;
                
            });

            $('#btnModalChooseItem').on('click', function (e) {
              
                var selectedRow = $("#item-table-modal").tabulator("getSelectedRows");
              
                FetchSparePartDetails(selectedRow[0].getData().ID_ITEM, selectedRow[0].getData().SUPP_CURRENTNO, selectedRow[0].getData().ID_WH_ITEM);

                hideStuff();
             

                e.preventDefault()
                
            });
            

             $('#campaignIcon').on('click', function (e) {

                 $('#txtTodaysPrice').val($('#<%=txtInfoSalesPriceNok.ClientID%>').val())
                 $('#txtTodaysPrice').prop('disabled', true);
                $('#modal_campaign').modal('show');

                
            });
            

            $('#eyePriceIcon').on('click', function (e) {

                $(this).toggleClass('fa-eye fa-eye-slash');

                if ( $(".hidePrice").css("visibility") == "hidden") {
                    $(".hidePrice").css('visibility', 'visible')
                }
                else {
                    $(".hidePrice").css('visibility', 'hidden')
                }
                

                
            });


            $('#btnSpareNew').on('click', function (e) {

                 
                $('#aspnetForm')[0].reset();                              //reset all fields
                $('#<%=txtSpareNo.ClientID%>').focus();

                $('#aspnetForm input').attr("disabled", "disabled");
                $('#<%=drpCategory.ClientID%>').attr("disabled", "disabled");
                $('#exclamIconNotes').hide();
                $('#txtSpareSearch').removeAttr("disabled");
                $('#<%=txtSpareNo.ClientID %>').removeAttr("disabled");
                $('#<%=txtSpareNo.ClientID %>').focus();
                $('.ui.attached.tabular.menu > .item').addClass('disabled');
                $('.ui.attached.tabular.menu > .item.active').removeClass('disabled');
                $('#<%=lblNewItem.ClientID%>').css("visibility", "visible");
                
            });
           
           

            $('#btnOrdertypeSet').on('click', function (e) {

                 
                $('#<%=txtInfoReplacementNo.ClientID%>').val($("#ddlReplacementItemsModal").val());

                
            });

            $('#return_item').on('click', function (e) {

                 $('#modal_return_item').modal('show');
           

                
            });

              $('#return_item_confirm').on('click', function (e) {

                  let oldqty = $('#<%=txtInfoStockQuantity.ClientID%>').val()
                  alert(oldqty);
                  let changeqty =  $('#<%=num_return.ClientID%>').val()
        alert(changeqty);
                  let newqty = (oldqty - changeqty)
                  alert(newqty);
                return_item(oldqty, newqty, changeqty);
                
            });


            $('#order_item').on('click', function (e) {
                getOrdertypes($('#<%=txtInfoSupplier.ClientID%>').val());
                var item_num = $('#<%=txtSpareNo.ClientID%>').val()
                var item_name = $('#<%=txtsparedesc.ClientID%>').val();
                $('#para_item_num').text(item_num);
                $('#para_item_name').text(item_name);
                $('#modal_order_item').modal('show');
         
                
            });

            $('#mod_order_item').on('click', function (e) {
                
                saveNewPurchaseOrder();
                
            });
            
             $('#btnOrdertypeSave').on('click', function (e) {

               //check supplier and item if not the same as current item

                
                 saveReplacements($('#<%=txtSpareNo.ClientID%>').val(), $('#<%=txtInfoReplEarlierNo.ClientID%>').val(), $('#txtbxNewReplacementItem').val(), $('#<%=txtInfoSupplier.ClientID%>').val());
                
            });
            
            $('#<%=btnInfoOpenDiscount.ClientID%>').on('click', function () {
           //     $('#txtbxNewOrdertypeSupplier').val($('#txtSupplierId').val());
              //  getDiscountCodes();

                 $('#modDiscountCodes').modal('show');
                 getDiscountCodes();
            });

            
            $('#<%=btnModalReplacementItems.ClientID%>').on('click', function () {
           //     $('#txtbxNewOrdertypeSupplier').val($('#txtSupplierId').val());
                $('#replacement_modal').modal('show');
                if ($('#<%=txtSpareNo.ClientID%>').val() != "" && $('#<%=txtInfoSupplier.ClientID%>').val() != "" && $('#<%=drpCategory.ClientID%>').val() != "") {
                    $("#replacement-table-modal").tabulator("setData", "LocalSPDetail.aspx/GetReplacementList", { 'item': $('#<%=txtSpareNo.ClientID%>').val(), 'supp': $('#<%=txtInfoSupplier.ClientID%>').val(), 'catg': $('#<%=drpCategory.ClientID%>').html() })
                }
                
                
            });

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
                    $('#txtbxNewDiscountCode').prop('disabled', true);
                    $('#txtbxNewDiscountCodeDescription').prop('disabled', true);
                    
                }
                else {
                    
                    $('#txtbxNewDiscountCode').val('');
                    $('#txtbxNewDiscountCodeDescription').val('');
                    $('#txtbxNewDiscountCode').prop('disabled', false);
                    $('#txtbxNewDiscountCodeDescription').prop('disabled', false);
                }
                
           });
      
         
            $('#btnCrosslistSavex').on('click', function () {
                if ($('#ddlDiscountCodesModal').val() != '*') {
                    $('#<%=txtInfoDiscountCode.ClientID%>').val($("#ddlDiscountCodesModal").val());
                }
   
                
            });

            $('#btnItemCategorySet').on('click', function () {
                if ($('#ddlItemCategory').val() != '*') {
                    //$('#<%=txtInfoDiscountCode.ClientID%>').val($("#ddlDiscountCodesModal").val());
                }
   
                
            });
            

            $('#btnItemCategorySave').on('click', function () {

               var alreadyCode = false;
               var newCode = ($('#txtbxNewItemCategory').val()).trim()
               newCode = newCode.toLowerCase();
               $("#ddlItemCategory option").each(function (i) {
                   if ((($(this).val()).trim()).toLowerCase() == newCode) {
                       alreadyCode = true;
              
                       
                   }
               });
               if (alreadyCode) {
                   systemMSG('error', 'Kan ikke lagre, da denne rabattkoden allerede finnes i systemet', 5000);

               }
               else {
                   //saveDiscountCode(($('#txtbxNewDiscountCode').val()).trim(), $('#txtbxNewDiscountCodeDescription').val());
                  addCategory()
               }
            });

            $('#txtbxNewDiscountCode').keyup(function () {
            if ($(this).val() == '') {
                $('#btnDiscountCodeSave').prop('disabled', true);
            } else {
                
                $('#btnDiscountCodeSave').prop('disabled', false);
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
                   $('#txtbxNewDiscountCode').prop('disabled', true);
                   $('#txtbxNewDiscountCodeDescription').prop('disabled', true);
                   $('#btnDiscountCodeSave').prop('disabled', true);
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
                        console.log(data.d);

                      
                       $('#ddlDiscountCodesModal').append($("<option></option>").val( $('#txtbxNewDiscountCode').val()).html( $('#txtbxNewDiscountCode').val()))
                       systemMSG('success', 'Ny rabattkode lagret', 5000);
                       
                       
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
           }

             $('#btnItemCategoryNew').on('click', function () {
              
               var alreadyStar = false;
               $("#ddlItemCategory option").each(function (i) {
                   if ($(this).val() == '*') {
                       alreadyStar = true;
                       
                   }
               });
             
                
               if (!alreadyStar) {
                   $('#ddlItemCategory').append($("<option></option>").val("*").html("*"));
                 
               }
               $('#ddlItemCategory option:eq("*")').prop('selected', true)
               $('option[value="*"]').prop("selected", true);
               $('#txtbxNewItemCategory').val('');
                 $('#txtbxNewItemCategoryDescription').val('');
               
                
                
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
               $('#txtbxNewDiscountCode').prop('disabled', false);
                    $('#txtbxNewDiscountCodeDescription').prop('disabled', false);
                
                
            });

            $('#btnOrdertypeNew').on('click', function () {
              
               var alreadyStar = false;
               $("#ddlReplacementItemsModal option").each(function (i) {
                   if ($(this).val() == '*') {
                       alreadyStar = true;
                       
                   }
               });
             
                
               if (!alreadyStar) {
                   $('#ddlReplacementItemsModal').append($("<option></option>").val("*").html("*"));
                 
               }
               $('#ddlReplacementItemsModal option:eq("*")').prop('selected', true)
               $('option[value="*"]').prop("selected", true);
               $('#txtbxNewReplacementItem').val('');
               $('#txtbxNewOrdertypeDescription').val('');
                
                
           });





       


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
                                alert(data.d[1])
                              return data.d[1]; 
                            
                                
                                
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

            function saveNewPurchaseOrder()
            {
                                     
               
                var suppcurrentno = $('#<%=txtInfoSupplier.ClientID%>').val();
                var ordertype = ""; //actually get the ordertype frm the modal, FIX THIS
                     
                var item = createImportableItemJSONstring( suppcurrentno,  ordertype);
                                           
                var succeeded = false;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "LocalSPDetail.aspx/SaveImportableItem",
                    data: "{item:'" + item + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {
                        
                        if (data.d == 1)
                        {
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
                else
                {
                                   
                           // setPOtoConfirmed($('#redRibbonPOmodal_withoutorder').text(), true);
                            systemMSG('success', ' vellykket', 5000);
                   
                }
                

            }

            function saveReplacements(mainItem, prevItem, newItem, suppCurrentno) {


                var suppcurrentno = $('#<%=txtInfoSupplier.ClientID%>').val();
                var ordertype = ""; //actually get the ordertype frm the modal, FIX THIS

                var item = createImportableItemJSONstring(suppcurrentno, ordertype);

                var succeeded = false;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "LocalSPDetail.aspx/SaveReplacements",
                    data: "{mainItem:'" + mainItem + "', prevItem:'" + prevItem + "', newItem:'" + newItem + "', suppCurrentno:'" + suppCurrentno  + "'}",
                    dataType: "json",
                    async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                    success: function (data) {

                        if (data.d == 1) {
                            

                        }
                       succeeded = true;

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });

                if (!succeeded) { systemMSG('error', 'Noe gikk galt under lagring av bestillingen', 7000); }
                else {

                    // setPOtoConfirmed($('#redRibbonPOmodal_withoutorder').text(), true);
                   

                }


            }


            function addItemToPO(row, ponumber, withoutordertable, autoOrder)
            {
                

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
            function createImportableItemJSONstring(suppcurrentno,  ordertype)
            {
                var importableItem = {};

                importableItem["ID_ITEM"] = $('#<%=txtSpareNo.ClientID%>').val(); 
                importableItem["ID_ITEM_CATG"] =  $('#<%=drpCategory.ClientID%>').val();            
                importableItem["QUANTITY"] = $('#<%=num_of_items.ClientID%>').val(); 
                importableItem["PURCHASE_TYPE"] = ""; //$('#dropdown_modal_ordertype')
                importableItem["SUPP_CURRENTNO"] = $('#<%=txtInfoSupplier.ClientID%>').val();                  
                importableItem["WAREHOUSE"] = warehouseID;
                importableItem["MODULETYPE"] = "SPAREPART";
                importableItem["FLG_IMPORTED"] = false;   
                importableItem["ORDERPREFIX"] = ""
                importableItem["ORDERNUMBER"] = ""
                importableItem["ORDERLINE"] = ""
                importableItem["ORDERSEQ"] = null;
                
                var jsonImportableItem = JSON.stringify(importableItem);
                console.log(jsonImportableItem);

                
                return jsonImportableItem;
            }

            function createPOItemJSONstring(row, ponumber, withoutordertable, autoOrder)
            {

                
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
                else
                {
                    purchaseOrderItem["ID_WOITEM_SEQ"] = "";
                    purchaseOrderItem["REST_FLG"] = false;
                    purchaseOrderItem["ANNOTATION"] = "";
                }
        
                var jsonPO = JSON.stringify(purchaseOrderItem);
                console.log(jsonPO);
                                         
                
                return jsonPO;
            }

            
            $('#btnCreateNewItem').on('click', function (e) {
                saveNewItem("newitem");
               

            });
             function saveNewItem() {
                $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/saveNewItem",
                    data: "{supplier: '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', item_catg:'" + $('#<%=drpCategory.ClientID%>').val() + "', id_item:'" + $('#<%=txtSpareNo.ClientID%>').val() + "', item_desc:'" + $('#<%=txtsparedesc.ClientID%>').val() + "', id_wh:'" + warehouseID  + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //alert($('#txtbxNewItemNum').val()+ " - "+ $('#txtbxSuppcurrentnoModal').val()+ " - " + warehouseID);
                        swal("Opprette vare?", {
                            buttons: {
                                cancel: "Avbryt",

                                OK: true,
                            },
                        })
                            .then((value) => {
                                switch (value) {

                                    case null:
                                        clearNewSpareInfo();

                                        break;

                                    default:

                                        FetchSparePartDetails($('#<%=txtSpareNo.ClientID%>').val(), $('#<%=txtInfoSupplier.ClientID%>').val(), warehouseID, "Y");
                                }
                            });
                       
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                 
            }
            
            


           
            var hasFired = false;

            
            $('#btnCustNotesSave').on('click', function (e) {
                if ($('#<%=txtNotes.ClientID%>').val() != "") {
                            $('#exclamIconNotes').show();
                        }
                        else {
                             $('#exclamIconNotes').hide();
                        }
                saveSparePart();

            });


            $('#aspnetForm input').on('blur', function (e) {
                //need a better check on values
         
                if ($('#<%=txtSpareNo.ClientID%>').attr('disabled') == 'disabled') {
                                  
                    if ($('#<%=lblNewItem.ClientID%>').css("visibility") !== "hidden") console.log("Thius is hwy");

                    else if ($(this).hasClass("donottriggersave"))
                    {
                        console.log("dontsave")
                    }                       
                    
                    else if (this.id == "txtbxNewItemCategory") console.log();
                    else if (this.id == "txtbxNewItemCategoryDescription") console.log();
                    else if (this.id == "txtbxNewDiscountCode") console.log();
                    else if (this.id == "txtbxNewDiscountCodeDescription") console.log();             
                    else if (this.id == "num_return") console.log();
                        
                    else if ($('#<%=txtSpareNo.ClientID%>').val() == "") console.log();
                    else if ($(this).val() != "") {

                        console.log("THIS ID IS : "+this.id)
                        if (this.id == "ctl00_cntMainPanel_txtInfoReplEarlierNo" || this.id == "ctl00_cntMainPanel_txtInfoReplacementNo") {
                            if ($('#<%=txtInfoReplEarlierNo.ClientID%>').val() != "" || $('#<%=txtInfoReplacementNo.ClientID%>').val() != "") {
                                saveReplacements($('#<%=txtSpareNo.ClientID%>').val(), $('#<%=txtInfoReplEarlierNo.ClientID%>').val(), $('#<%=txtInfoReplacementNo.ClientID%>').val(), $('#<%=txtInfoSupplier.ClientID%>').val());
                            }
                             
                        }

                        if (this.id == "ctl00_cntMainPanel_txtInfoBasisPriceNok")
                        {
                            if ($('#<%=txtInfoBasisPriceNok.ClientID%>').val() != "")
                            {
                                if ($('#<%=txtInfoDiscountCode.ClientID%>').val() != "")
                                {                 
                                    
                                    swal("Vil du kalkulere de øvrige prisene på basis av veiledende pris og rabattkode?", {  
                                buttons: {
                                cancel: "Avbryt",

                                    OK: true,
                                },
                            })
                                .then((value) => {
                                    switch (value) {

                                        case null:
                                     

                                            break;

                                        default:
                                            getDiscountandFreight();
                                            FetchCurrencyDetails($('#<%=lblInfoCurrency.ClientID%>').html());
                                          
                                    }
                                });
                                              
                                           
                                    console.log('rabattkode er OK');
                                   
                                }
                                else
                                {
                                    swal('Du må ha rabattkode for at beløp skal kalkuleres.');
                                }

                            }
                            
                           

                        }
                       
                            UpdatePriceAdjustment();
                            
                        
                   
                        $("#soldGridOrder").tabulator("redraw", true);
                      
                        saveSparePart();
                    }
                    



                }
                
                
            

            });

             $('#btnEmptyScreen').on('click', function (e) {
                $('#aspnetForm')[0].reset();
              
                 $('#<%=txtSpareNo.ClientID %>').removeAttr("disabled");
                 $('#<%=txtsparedesc.ClientID %>').removeAttr("disabled");

            });


            $("#item-table-modal").tabulator({
                // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                height: 340,
                layout: "fitColumns", //fit columns to width of table (optional)
                selectable: 1,     //true means we can select multiple rows   
                placeholder: "Ingen varer", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string

                columns: [ //Define Table Columns
                { title: "Warehouse", field: "ID_WH_ITEM", visible: false},
                    { title: "Leverandør", field: "SUPP_CURRENTNO", align: "center" },
                    { title: "Varenr", field: "ID_ITEM", align: "center" },
                    { title: "Varenavn", field: "ITEM_DESC", align: "center" },
                    
                    { title: "Varegruppe", field: "ID_ITEM_CATG", align: "center" },
                    { title: "Beholdning", field: "ITEM_AVAIL_QTY", align: "center" },
                    
                    
                    
                
                ],
                
                rowSelected: function (row) {
                    //row - row component for the selected row
                    $('#btnModalChooseItem').removeClass("disabled");
                   
                },


                rowDeselected: function (row) {
                    //row - row component for the selected row
                    if (!$('#btnModalChooseItem').hasClass("disabled")) {
                        $('#btnModalChooseItem').addClass("disabled");
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

                rowDblClick: function (e, row) {
                        //e - the click event object
                        //row - row component
                    
                    FetchSparePartDetails( row.getData().ID_ITEM,  row.getData().SUPP_CURRENTNO,  row.getData().ID_WH_ITEM);
                    $('#modal_po_steps').modal('hide');
                    
                    $('#aspnetForm input').removeAttr('disabled');
                     $('.disabledBox').attr("disabled", "disabled");
                         
                            $('#<%=txtSpareNo.ClientID%>').attr("disabled", "disabled");
                            $('#<%=txtsparedesc.ClientID%>').attr("disabled", "disabled");
                            $('#<%=txtInfoSupplier.ClientID%>').attr("disabled", "disabled");
                            $('#<%=txtInfoSupplierName.ClientID%>').attr("disabled", "disabled");
                            $('.ui.attached.tabular.menu > .item').removeClass('disabled');
                            
                             $('#<%=lblNewItem.ClientID%>').css("visibility", "hidden");
                        e.preventDefault()

                        
                    },
                
            });

            


            $("#replacement-table-modal").tabulator({
                // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                height: 340,
                layout: "fitColumns", //fit columns to width of table (optional)
                selectable: 1,     //true means we can select multiple rows   
                placeholder: "Ingen varer", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string

                columns: [ //Define Table Columns
             
                    
                    { title: "Erstatningsnr.", field: "EARLIER_REPLACEMENT_ITEM", align: "center" }, 
                    { title: "Beskrivelse", field: "ITEM_DESC", align: "center" },
                    { title: "Beholdning.", field: "ITEM_AVAIL_QTY", align: "center" },
                    
                    
                
                ],
               


              
                ajaxResponse: function (url, params, response) {
                    console.log("url is: " + url);
                    console.log("params is: " + params);                  
                    
                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //return the d property of a response json object
                },

            
                
            });



             $("#campaign-table-modal").tabulator({
                // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                height: 340,
                layout: "fitColumns", //fit columns to width of table (optional)
                selectable: 1,     //true means we can select multiple rows   
                placeholder: "Ingen varer", //display message to user on empty table
                ajaxConfig:"POST", //ajax HTTP request type
                ajaxContentType:"json", // send parameters to the server as a JSON encoded string

                columns: [ //Define Table Columns
                { title: "Warehouse", field: "ID_WH_ITEM", visible: false},
                    { title: "Salgspris", field: "CAMPAIGNPRICE", align: "center" },
                    { title: "Startdato", field: "START_DATE", align: "center" },
                    { title: "Sluttdato", field: "END_DATE", align: "center" },                  
                    { title: "valid_date", field: "VALID_DATE", align: "center", visible: false },
                    
                    
                    
                
                ],
               


              
                ajaxResponse: function (url, params, response) {
                    console.log("url is: " + url);
                    console.log("params is: " + params);                  
                    
                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //return the d property of a response json object
                },

            
                
            });




            
            function collectGroupData(dataTag) {
                dataCollection = {};
                $('[data-' + dataTag + ']').each(function (index, elem) {
                    var st = $(elem).data(dataTag);
                    var dv = '';
                    var elemType = $(elem).prop('nodeName');
                    switch (elemType) {
                        case 'INPUT':
                           
                                dv = $(elem).val();
                            if (st == "ITEM_PRICE" || st == "AVG_PRICE" || st == "NET_PRICE" || st == "COST_PRICE1" || st == "BASIC_PRICE")
                            {
                               
                               dv =  $(elem).val().replace(",", ".");
                            }
               
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

            /* MODAL FUNCTIONS */
            $(document).bind('keydown', function (e) { // BIND ESCAPE TO CLOSE
                if (e.which == 27) {
                    overlay('off', '');
                }
            });
            $(".modClose").on('click', function (e) {
                overlay('off', '');
            });


            //function setTab(cTab) {
            //    var regState = true;
            //    var tabID = "";
            //    //console.log(ctab);
            //    console.log($(cTab).data('tab'));
            //    tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
            //    var tab;
            //    (tabID == "") ? tab = cTab : tab = tabID;

            //    $('.tTab').addClass('hidden'); // Hides all tabs
            //    $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
            //    $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
            //    $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
            //    //(tab == 'SpareInfo') ? regState = false : regState = true; // Check for current tab
               
            //}

            //$('.cTab').on('click', function (e) {
            //    console.log("hey hva skejr");
            //    setTab($(this));
            //});

            $('#btnSpareHistory').on('click', function () {
                console.log("hey hva skejr 4");
                if (btnSHClicked === undefined) {
                    $('.ui.accordion').accordion({
                        onOpen: function () {
                            curYear = $(this).prev('.title').data('year');
                            setChartData(curYear, '');
                            buildChart(curYearData);
                        }, collapsible: false                        
                    }).accordion('open',0);;
                    var btnSHClicked = true;
                }
            });

            $('.modClose').on('click', function () {
                $('#modNewVehicle').addClass('hidden');
                $('.overlayHide').removeClass('ohActive');
                $('#btnSaveVehicle').prop('disabled', true);
            });

            $('#btnCrosslist').on('click', function () {
                $('#modCrosslist').modal('show');
                
            });

            $('#btnParameters').on('click', function () {
                $('#modal_parameters').modal('show');

            });

            $('#btnNotes').on('click', function () {
                $('#modal_notes').modal('show');

            });

                               
                       //Make edit mod scripts
            $('#<%=btnEditMake.ClientID%>').on('click', function () {
             
                $('#modItemCategory').modal('show');
                               
            });
          
            $('#btnSpareSold').on('click', function () {
                var functionValue = 0
                    var id_item = $('#<%=txtSpareNo.ClientID%>').val();
                    if (id_item == "" || id_item == undefined)
                    {
                        id_item = "%";
                    }

                    var supp = $('#<%=txtInfoSupplier.ClientID%>').val();
                    if (supp == "" || supp == undefined)
                    {
                        supp = "%";
                    }
                    var catg = $('#<%=drpCategory.ClientID%>').val();
                    if (catg == "" || catg == undefined)
                    {
                        catg = "%";
                    }
                $("#soldGridOrder").tabulator("setData", "LocalSPDetail.aspx/Fetch_Orders", {'id_item': id_item, 'supplier': supp, 'catg': catg, 'functionValue': functionValue}); //make ajax request with advanced config options
                $("#soldGridOrder").tabulator("redraw", true);
                
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
                    url: "LocalSPDetail.aspx/LoadEditMake",
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
                mode = 'edit';
            });

            function getEditMake(makeId) {
                $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/GetEditMake",
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
                console.log(mode);
                $('.overlayHide').removeClass('ohActive');
                $('#modEditMake').addClass('hidden');
               
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "LocalSPDetail.aspx/AddEditMake",
                    data: "{editMakeCode: '" + $('#<%=txtEditMakeCode.ClientID%>').val() + "', editMakeDesc:'" + $('#<%=txtEditMakeDescription.ClientID%>').val() + "', editMakePriceCode:'" + $('#<%=txtEditMakePriceCode.ClientID%>').val() + "', editMakeDiscount:'" + $('#<%=txtEditMakeDiscount.ClientID%>').val() + "', editMakeVat:'" + $('#<%=txtEditMakeVat.ClientID%>').val() + "', mode:'" + mode + "'}",
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
                            
                            //$('#txtbxNewOrdertypePricetype').val(data.d[0].PRICETYPE);
                            //$('#txtbxNewReplacementItem').val(data.d[0].SUPP_ORDERTYPE);
                            //$('#txtbxNewOrdertypeDescription').val(data.d[0].SUPP_ORDERTYPE_DESC);
                                                     

                        }
                        else
                        {

                           
                            
                            
                            $('#dropdown_modal_ordertype').find('option').not(':first').remove();
                            $.each(data.d, function (key, value) {                            
                                
                                $('#dropdown_modal_ordertype').append($("<option></option>").val(value.SUPP_ORDERTYPE).html(value.SUPP_ORDERTYPE));

                            });
                        }
                       

                },
                    failure: function () {
                        alert("Failed!");
                    }
                });
        }



            $('#<%=btnEditMakeDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtEditMakeCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "LocalSPDetail.aspx/DeleteEditMake",
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
                    url: "LocalSPDetail.aspx/LoadMakeCode",
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


         /*   $('txtAdvTotalQtyInPurchases').popup()*/;

           


       
            function addCategory() {
                $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/SaveSpCatgDetails",
                    data: "{idSupplier:'" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', 'catg': '" + $('#txtbxNewItemCategory').val() + "', 'desc': '" +$('#txtbxNewItemCategoryDescription').val()  + "', 'mode': '" +"Add" +"'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                       

                           
                            $('#<%=drpCategory.ClientID%>').append($("<option></option>").val( $('#txtbxNewItemCategory').val()).html( $('#txtbxNewItemCategory').val()));
                        $('#ddlItemCategory').append($("<option></option>").val($('#txtbxNewItemCategory').val()).html($('#txtbxNewItemCategory').val()));
                        $('#ddlItemCategory').append($("<option></option>").val($('#txtbxNewItemCategory').val()).html($('#txtbxNewItemCategory').val()));
                         $('#txtbxNewItemCatg').append($("<option></option>").val( $('#txtbxNewItemCategory').val()).html( $('#txtbxNewItemCategory').val()));
                       

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }


            function loadCategory() {
                $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/LoadCategory",
                    data: "{q:'" + $('#<%=txtInfoSupplier.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpCategory.ClientID%>').empty();
                        $('#ddlItemCategory').empty()
                        $('#<%=drpCategory.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpCategory.ClientID%>').append($("<option></option>").val(value.ID_ITEM_CATG).html(value.CATEGORY));
                            $('#ddlItemCategory').append($("<option></option>").val(value.ID_ITEM_CATG).html(value.CATEGORY));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }


             function loadCategory2() {
                $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/LoadCategory",
                    data: "{q:'" + $('#txtbxSuppcurrentnoModal').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                       
                        $('#txtbxNewItemCatg').empty()
                       
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                  
                            $('#txtbxNewItemCatg').append($("<option></option>").val(value.ID_ITEM_CATG).html(value.CATEGORY));
                       
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function loadUnitItem() {
                $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/loadUnitItem",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpAdvUnitItem.ClientID%>').empty();
                        $('#<%=drpAdvUnitItem.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpAdvUnitItem.ClientID%>').append($("<option></option>").val(value.ID_UNIT_ITEM).html(value.UNIT_DESC));

                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            /* ------------------------------------------------------------------
                       SPARE PART SEARCH FUNCTIONS
                        -------------------------------------------------------------------*/
            var imake, iid, iwh;
            $('#txtSpareSearch').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search1",
                        data: "{q:'" + $('#txtSpareSearch').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                        
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager. Søke i non-stock register?', value: $('#txtSpareSearch').val() , val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    imake = item.ID_MAKE;
                                    iid = item.ID_ITEM;
                                    iwh = '1';
                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM
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
                select: function (e, i)
                {
                    
                    if(i.item.val != "new")
                    {
                        $('#<%=txtInfoSupplier.ClientID%>').val('');
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
                        $('#txtbxCampaignPrice').removeAttr("disabled");
                    }
                    else
                    {
                        openSparepartGridWindow("LocalSPDetail");
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                        
                    }

                }
            });


       


            function SearchSparePartOnlySpare(item) {
                var returnval;
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search_Only_SparePart",                       
                        data: "{'q': '" +  item + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                returnval = 0;
                            } else {
                                returnval = 1;
                           

                                
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                });
              
                return returnval;
              
            };



            function getSparePart(item, suppcurrentno) {
                var returnval;
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search",                       
                        data: "{'q': '" + item + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + suppcurrentno + "', 'nonStock': '" + false + "', 'accurateSearch': '" + true + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                returnval = 0;
                            } else {
                                returnval = data;
                           

                                
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                });
              
                return returnval;
              
            };


            

            


            $('#<%=txtAdvSpareSubNo.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search",
                        
                        data: "{'q': '" + $('#<%=txtAdvSpareSubNo.ClientID%>').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $('#<%=txtAdvSpareSubSupplier.ClientID%>').val() + "', 'nonStock': '" + false + "', 'accurateSearch': '" + false + "'}",
                        dataType: "json",
                        success: function (data) {
                            
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager. Søke i non-stock register?', value: $('#<%=txtAdvSpareSubNo.ClientID%>').val() , val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    imake = item.ID_MAKE;
                                    iid = item.ID_ITEM;
                                    iwh = '1';
                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM
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
                select: function (e, i)
                {
                    
                    if(i.item.val != "new")
                    {
                       
                    }
                    else
                    {
                        // openSparepartGridWindow("LocalSPDetail");
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                        
                    }

                }
            });

            function FetchSparePartDetails(ID_ITEM_ID, ID_ITEM_MAKE, ID_ITEM_WH, newitem) {
                cpChange = '';
                $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/FetchItemsDetail",
                    data: "{ID_ITEM_ID: '" + ID_ITEM_ID + "', ID_ITEM_MAKE: '" + ID_ITEM_MAKE +"', ID_ITEM_WH: '" + ID_ITEM_WH + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        console.log(data.d);

                  
                        

                       
                        $('#<%=txtSpareNo.ClientID%>').val(data.d.ID_ITEM);
                        
                        
                        $('#<%=txtsparedesc.ClientID%>').val(data.d.ITEM_DESC);
                      
                        $('#<%=drpMakeCodes.ClientID%>').val(data.d.ID_MAKE);
                        $('#<%=txtInfoSupplier.ClientID%>').val(data.d.ID_MAKE);
                        $('#<%=txtAdvBarcodeNo.ClientID%>').val(data.d.BARCODE_NUMBER);
                    
                        $('#<%=txtInfoSupplierName.ClientID%>').val(data.d.SUP_Name);
                        $('#<%=txtInfoNetPrice.ClientID%>').val(data.d.ID_ITEM);
                        $('#<%=txtInfoDiscountCode.ClientID%>').val(data.d.ITEM_DISC_CODE_BUY);
                        $('#<%=txtInfoLocation.ClientID%>').val(data.d.LOCATION);
                       // $('#<%=txtInfoAltLocation.ClientID%>').val(data.d.ALT_LOCATION);
                        $('#<%=txtNotes.ClientID%>').val(data.d.ANNOTATION);
                        if ($('#<%=txtNotes.ClientID%>').val() != "") {
                            $('#exclamIconNotes').show();
                        }
                        else {
                             $('#exclamIconNotes').hide();
                        }
                       

                        $('#<%=txtAdvUnit.ClientID%>').val(data.d.PACKAGE_QTY);
                        $('#<%=txtInfoWeight.ClientID%>').val(data.d.WEIGHT);
                        $('#<%=txtInfoStockQuantity.ClientID%>').val(data.d.ITEM_AVAIL_QTY);                 
                        $('#<%=txtInfoBasisPriceNok.ClientID%>').val(data.d.BASIC_PRICE);
                        $('#<%=txtInfoLastCost.ClientID%>').val(data.d.COST_PRICE1);
                        $('#<%=txtInfoLastCostNok.ClientID%>').val(data.d.COST_PRICE1);
                        $('#<%=txtInfoCostPrice.ClientID%>').val(data.d.AVG_PRICE);
                        $('#<%=txtInfoCostPriceNok.ClientID%>').val(data.d.AVG_PRICE);
                        $('#<%=txtInfoNetPrice.ClientID%>').val(data.d.NET_PRICE);
                        $('#<%=txtInfoNetPriceNok.ClientID%>').val(data.d.NET_PRICE);
                        $('#<%=txtInfoSalesPrice.ClientID%>').val(data.d.ITEM_PRICE);
                        $('#<%=txtInfoSalesPriceNok.ClientID%>').val(data.d.ITEM_PRICE);
                        $('#<%=txtInfoIncludeVat.ClientID%>').val(data.d.ITEM_PRICE);
                       //data.d.TEXT);
                        $('#<%=txtInfoReplEarlierNo.ClientID%>').val(data.d.PREVIOUS_ITEM_ID);
                        $('#<%=txtInfoReplacementNo.ClientID%>').val(data.d.NEW_ITEM_ID);
                        
                        $('#<%=txtInfoDiscountPercentage.ClientID%>').val(data.d.DISCOUNT);
                      
                        
                        data.d.FLG_STOCKITEM === 'True' ? $("#<%=cbInfoStockControl.ClientID%>").prop('checked', true) : $("#<%=cbInfoStockControl.ClientID%>").prop('checked', false);
                        if (data.d.FLG_OBSOLETE_SPARE === 'True') {
                            $("#<%=cbInfoDeadStock.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoDeadStock.ClientID%>").prop('checked', false);
                        }
                        if (data.d.FLG_LABELS === 'True') {
                            $("#<%=cbInfoEtiquette.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoEtiquette.ClientID%>").prop('checked', false);
                        }
                            
                        if (data.d.FLG_VAT_INCL === 'True') {
                            $("#<%=cbInfoVatIncluded.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoVatIncluded.ClientID%>").prop('checked', false);
                        }
                        if (data.d.FLG_BLOCK_AUTO_ORD === 'True') {
                            $("#<%=cbInfoAutoPurchase.ClientID%>").prop('checked', false);
                        } else {
                            $("#<%=cbInfoAutoPurchase.ClientID%>").prop('checked', true);
                        }
                        if (data.d.FLG_ALLOW_DISCOUNT === 'True') {
                            $("#<%=cbInfoDiscountLegal.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoDiscountLegal.ClientID%>").prop('checked', false);
                        }
                        if (data.d.FLG_AUTO_ARRIVAL === 'True') {
                            $("#<%=cbInfoAutoArrival.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoAutoArrival.ClientID%>").prop('checked', false);
                        }
                        if (data.d.FLG_OBTAIN_SPARE === 'True') {
                            $("#<%=cbInfoObtainSpare.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoObtainSpare.ClientID%>").prop('checked', false);
                        }
                        if (data.d.FLG_AUTOADJUST_PRICE === 'True') {
                            $("#<%=cbInfoAutoPriceAdjustment.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoAutoPriceAdjustment.ClientID%>").prop('checked', false);
                        }
                        if (data.d.FLG_REPLACEMENT_PURCHASE === 'True') {
                            $("#<%=cbInfoAllowPurchaseReplacments.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoAllowPurchaseReplacments.ClientID%>").prop('checked', false);
                        }
                        if (data.d.FLG_EFD === 'True') {
                            $("#<%=cbInfoNotEnvFee.ClientID%>").prop('checked', false);
                        } else {
                            $("#<%=cbInfoNotEnvFee.ClientID%>").prop('checked', true);
                        }
                        if (data.d.FLG_SAVE_TO_NONSTOCK === 'True') {
                            $("#<%=cbInfoSaveToNonstock.ClientID%>").prop('checked', true);
                        } else {
                            $("#<%=cbInfoSaveToNonstock.ClientID%>").prop('checked', false);
                        }

                        $('#<%=lblInfoCurrency.ClientID%>').html(data.d.SUP_CURRENCY_CODE);

                        loadCategory();

                        $('#<%=drpCategory.ClientID%>').val(data.d.ID_ITEM_CATG);

                        FetchCurrencyDetails(data.d.SUP_CURRENCY_CODE);
                        //ADVANCED TAB
                        $('#<%=txtAdvWarehouse.ClientID%>').val(data.d.ID_WH_ITEM);
                        $('#<%=txtAdvMinPurchase.ClientID%>').val(data.d.MIN_STOCK);
                        $('#<%=txtAdvMaxPurchase.ClientID%>').val(data.d.MAX_PURCHASE);
                       // Validatenum(field: any, sep: any, dec: any);

                         

                        $('#<%=drpAdvUnitItem.ClientID%>').val(data.d.ID_UNIT_ITEM);
                        <%--$('#<%=txtAdvCategory.ClientID%>').val(data.d.ID_SPCATEGORY);--%>
                        $('#<%=txtAdvLastCostBuy.ClientID%>').val(data.d.LAST_BUY_PRICE);
                        $('#<%=txtAdvLastIRDate.ClientID%>').val(data.d.DT_LAST_BUY);
                        $('#<%=txtAdvSpareSubNo.ClientID%>').val(data.d.ENV_ID_ITEM);
                        $('#<%=txtAdvSpareSubSupplier.ClientID%>').val(data.d.ENV_ID_MAKE);
                         $('#<%=txtInfoRefund.ClientID%>').val(data.d.DEPOSITREFUND_ID_ITEM);
                      
                        
                       

                        <%-- $('#<%=txtAdvSpareSubWh.ClientID%>').val(data.d.ENV_ID_WAREHOUSE);--%>
                        $('#<%=txtAdvPurchaseNo.ClientID%>').val(data.d.PO_NO);
                        $('#<%=txtAdvQtyInPurchase.ClientID%>').val(data.d.PO_QTY);
                        $('#<%=txtAdvTotalQtyInPurchase.ClientID%>').val(data.d.PO_QTY_TOTAL)

                        $('#<%=txtAdvBudgetConsumptions.ClientID%>').val(data.d.CONSUMPTION_ESTIMATED)
                        $('#<%=txtAdvMinQty.ClientID%>').val(data.d.MIN_STOCK)
                        $('#<%=txtAdvMinPurchase.ClientID%>').val(data.d.MIN_PURCHASE)
                        $('#<%=txtAdvMaxPurchase.ClientID%>').val(data.d.MAX_PURCHASE)
                                                    
                        $('#<%=txtAdvPurchaseDate.ClientID%>').val(data.d.PO_DT_CREATED);
                        //var expDelivery = convertToDate(data.d.PO_DT_EXPDLVDATE);
                        var expDelivery = 1;

                        $('#<%=txtAdvArrivalDate.ClientID%>').val(expDelivery);  
                      
                        $('#<%=txtAdvLastIRNo.ClientID%>').val(data.d.IR_NO);       
                        $('#<%=txtAdvLastIRQty.ClientID%>').val(data.d.IR_QTY);
                        $('#<%=txtAdvLastCountingDate.ClientID%>').val(data.d.COUNTING_DATE);
                        $('#<%=txtAdvCountingSignature.ClientID%>').val(data.d.COUNTING_CREATED_BY);
                        $('#<%=txtAdvSignatureName.ClientID%>').val(data.d.COUNTING_CREATED_BY_NAME);
                        
                        $('#<%=txtAdvLastSoldDate.ClientID%>').val(data.d.DT_LAST_SOLD);
                        $('#<%=txtAdvLastBODate.ClientID%>').val(data.d.DT_LAST_BO);
                        $('#<%=txtAdvQtySold.ClientID%>').val(data.d.TOTAL_BO_QTY);
                        $('#<%=txtAdvQtyBO.ClientID%>').val(data.d.TOTAL_ORDER_BO_QTY);
                        
                        $('#<%=txtAdvQtyOffered.ClientID%>').val(data.d.TOTAL_BARGAIN_BO_QTY);
                        populateItemHistory(data.d.ID_ITEM, data.d.ID_MAKE, data.d.ID_WH_ITEM);
                        console.log("ITEM PRICE IS: "+ data.d.ITEM_PRICE)
                        oldsalesprice = data.d.ITEM_PRICE;
                        newsalesprice = data.d.ITEM_PRICE;
                        $('#<%=drpCategory.ClientID%>').removeAttr("disabled", "disabled");
                        if (newitem == "Y") {
                            
                            $('#<%=txtInfoStockQuantity.ClientID%>').removeAttr("disabled", "disabled");
                        }
                        $("#campaign-table-modal").tabulator("setData", "LocalSPDetail.aspx/get_campaignprices", { 'id_item': data.d.ID_ITEM, 'suppcurrentno': data.d.ID_MAKE })
                            .then(function () {
                                //run code after table has been successfuly updated
                                var rows = $("#campaign-table-modal").tabulator("getRows");

                                if (rows.length !== 0) {
                                    console.log("KAMPANJETABULATYOR : " + rows[0].getData().VALID_DATE);
                                    if (rows[0].getData().VALID_DATE < 0) {
                                        $("#campaignIcon").css("color", "");
                                    }
                                    else {
                                        $("#campaignIcon").css("color", "red");
                                    }
                                }
                                else {
                                    $("#campaignIcon").css("color", "");
                                }
                            })
                            .catch(function (error) {
                                //handle error loading data
                            });
                        
                        //getReplacementList(data.d.ID_ITEM, data.d.ID_MAKE, data.d.ID_ITEM_CATG);
                        $("#replacement-table-modal").tabulator("setData", "LocalSPDetail.aspx/GetReplacementList", { 'item': data.d.ID_ITEM, 'supp': data.d.ID_MAKE , 'catg': data.d.ID_ITEM_CATG })
                        $('#<%=txtAccountCode.ClientID%>').val(data.d.ACCOUNT_CODE); 
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                
            }; 



            
            function convertToDate(num)
            {
                var tmp = num.substr(6, 8) + ".";
                             
                tmp = tmp + num.substring(4, 6) +".";
               // alert(tmp) 
                tmp = tmp + num.substring(0, 4)  ;
                //alert(tmp)
                return tmp;
            }
            

            //autocomplete for listing of the supplier
          
            $('#<%=txtInfoSupplier.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#<%=txtInfoSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#<%=txtInfoSupplier.ClientID%>').val());
                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Ingen treff i leverandørregister. Opprette ny?', value: '0', val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    
                                    return {
                                        label:   item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name
                                    }
                                }))
                        },
                        error: function (xhr, status, error)
                        {
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                    });
                },
                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {                                 
                    
                    if (i.item.val != 'new')
                    {                                            
                        $('#<%=txtInfoSupplierName.ClientID%>').val(i.item.supName);
                        $('#<%=txtInfoSupplier.ClientID%>').val(i.item.val); //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory
                        loadCategory();
          
                        
                    }
                    else
                    {
                        moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }
                                 
                }
            });

            $('#<%=txtInfoRefund.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search",
                        
                        data: "{'q': '" + $('#<%=txtInfoRefund.ClientID%>').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', 'nonStock': '" + false + "', 'accurateSearch': '" + false + "'}",
                        dataType: "json",
                        success: function (data) {
                            
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager. Søke i non-stock register?', value: $('#<%=txtInfoRefund.ClientID%>').val() , val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    if (item.ID_ITEM == $('#<%=txtSpareNo.ClientID%>').val()) return;
                                    imake = item.ID_MAKE;
                                    iid = item.ID_ITEM;
                                    iwh = '1';
                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM
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
                select: function (e, i)
                {
                    
                    if(i.item.val != "new")
                    {
                       
                    }
                    else
                    {
                        // openSparepartGridWindow("LocalSPDetail");
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                        
                    }

                }
            });

            $('#<%=txtInfoReplEarlierNo.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search",
                        
                        data: "{'q': '" + $('#<%=txtInfoReplEarlierNo.ClientID%>').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', 'nonStock': '" + false + "', 'accurateSearch': '" + false + "'}",
                        dataType: "json",
                        success: function (data) {
                            
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager. Søke i non-stock register?', value: $('#<%=txtInfoReplEarlierNo.ClientID%>').val() , val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    if (item.ID_ITEM == $('#<%=txtSpareNo.ClientID%>').val()) return;
                                    imake = item.ID_MAKE;
                                    iid = item.ID_ITEM;
                                    iwh = '1';
                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM
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
                select: function (e, i)
                {
                    
                    if(i.item.val != "new")
                    {
                       
                    }
                    else
                    {
                        // openSparepartGridWindow("LocalSPDetail");
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                        
                    }

                }
            });


            $('#<%=txtInfoReplacementNo.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/SparePart_Search",
                        
                        data: "{'q': '" + $('#<%=txtInfoReplacementNo.ClientID%>').val() + "', 'mustHaveQuantity': '" + false + "', 'isStockItem': '" + false + "', 'isNotStockItem': '" + false + "', 'loc': '" + "%" + "', 'supp': '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', 'nonStock': '" + false + "', 'accurateSearch': '" + false + "'}",
                        dataType: "json",
                        success: function (data) {
                            
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager. Søke i non-stock register?', value: $('#<%=txtInfoReplacementNo.ClientID%>').val() , val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                
                                    if (item.ID_ITEM == $('#<%=txtSpareNo.ClientID%>').val()) return;
                                    imake = item.ID_MAKE;
                                    iid = item.ID_ITEM;
                                    iwh = '1';
                                    return {
                                        label: item.ID_MAKE + " - " + item.ID_ITEM + " - " + item.ITEM_DESC + " - " + item.LOCATION + " - " + item.ID_WH_ITEM,
                                        val: item.ID_ITEM,
                                        value: item.ID_ITEM,
                                        make: item.ID_MAKE,
                                        warehouse: item.ID_WH_ITEM
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
                select: function (e, i)
                {
                    
                    if(i.item.val != "new")
                    {
                       
                    }
                    else
                    {
                        // openSparepartGridWindow("LocalSPDetail");
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                        
                    }

                }
            });

            
        


            $('#<%=txtAdvSpareSubSupplier.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#<%=txtAdvSpareSubSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#<%=txtAdvSpareSubSupplier.ClientID%>').val());
                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Ingen treff i leverandørregister. Opprette ny?', value: '0', val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    
                                    return {
                                        label: item.ID_SUPPLIER_ITEM + " - " + item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name
                                    }
                                }))
                        },
                        error: function (xhr, status, error)
                        {
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                    });
                },
                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {                                 
                    
                    if (i.item.val != 'new')
                    {                                            
                        <%--$('#<%=txtInfoSupplierName.ClientID%>').val(i.item.supName);--%>
                        $('#<%=txtAdvSpareSubSupplier.ClientID%>').val(i.item.val); //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory
                        
                        
                    }
                    else
                    {
                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }
                                 
                }
            });


             $('#txtbxNewReplacementSuppcurrentno').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#txtbxNewReplacementSuppcurrentno').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            
                            if (data.d.length === 0) // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            {
                                response([{ label: 'Ingen treff i leverandørregister. Opprette ny?', value: '0', val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    
                                    return {
                                        label: item.ID_SUPPLIER_ITEM + " - " + item.SUP_Name + " - " + item.SUPP_CURRENTNO,
                                        val: item.SUPP_CURRENTNO,
                                        value: item.SUPP_CURRENTNO,
                                        supName: item.SUP_Name
                                    }
                                }))
                        },
                        error: function (xhr, status, error)
                        {
                            alert("Error" + error);
                            var err = eval("(" + xhr.responseText + ")");
                            alert('Error: ' + err.Message);
                        }
                    });
                },
                // select invoken when: autocomplete prompt clicked/enter pressed/tab pressed
                select: function (e, i) {                                 
                    
                    if (i.item.val != 'new')
                    {                                            
                        <%--$('#<%=txtInfoSupplierName.ClientID%>').val(i.item.supName);--%>
                        $('#txtbxNewReplacementSuppcurrentno').val(i.item.val); //crucial so that txtinfosupplier can send correct info to stored procedure in loadcategory
                        
                        
                    }
                    else
                    {
                        //moreInfo("SupplierDetail.aspx?" + "&pageName=SpareInfo");
                    }
                                 
                }
            });

            

            $("#soldGridOrder").tabulator({
                height:400 , // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                //responsiveLayout: true,
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


                ajaxResponse: function (url, params, response) {


                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //Return the d Property Of a response json Object
                },

                headerFilterPlaceholder: "Filtrer data", //set column header placeholder text
                columns: [ //Define Table Columns
                    {
                        title: "OrderNo", field: "ID_WO_NO",  align: "center", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "InvoiceNo", field: "ID_INV_NO", sorter: "string", align: "center" },
                    { title: "Type", field: "TYPEORDER", sorter: "string",align: "center"},
                    { title: "Date", field: "DT_CREATED", sorter: "date", align: "center" },
                    { title: "Customer", field: "CUSTOMER", sorter: "string", align: "center"},
                    { title: "Quantity", field: "JOBI_DELIVER_QTY", sorter: "number", align: "center" },
                    { title: "Salesprice", field: "JOBI_SELL_PRICE", sorter: "number", align: "center"},
                    { title: "Kostprice", field: "JOBI_COST_PRICE", sorter: "number", align: "center" },
                    

                ],
               

            });
            $("#soldGridPurchaseOrder").tabulator({
                height: 400, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                //responsiveLayout: true,
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


                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    ;
                },
                rowContext: function (e, row) {
                    //e - the click event object
                    //row - row component
                    //alert();
                    //e.preventDefault(); // prevent the browsers default context menu form appearing.
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
                        title: "PONo", field: "ID_WO_NO", align: "center",  headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Type", field: "TYPEORDER", sorter: "string", align: "center" },
                    { title: "Date", field: "DT_CREATED", sorter: "date", align: "center" },
                    { title: "Supplier", field: "SUPPLIER_NUMBER", sorter: "date", align: "center"},
                    { title: "OrderNo", field: "ORDERNO", sorter: "string", align: "center" },
                    { title: "Quantity", field: "JOBI_DELIVER_QTY", align: "center" },
                    { title: "Sales price", field: "ITEM_PRICE", align: "center" },
                    { title: "Cost price", field: "COST_PRICE1", align: "center" },
                ],


            });

            $("#soldGridStockAdjustments").tabulator({
                height: 400, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                //responsiveLayout: true,
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


                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    ;
                },
                rowContext: function (e, row) {
                    //e - the click event object
                    //row - row component
                    //alert();
                    //e.preventDefault(); // prevent the browsers default context menu form appearing.
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
                        title: "AdjId", field: "STOCK_ADJ_ID", width: 70, align: "center", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Type", field: "STOCK_ADJ_TYPE", sorter: "string", align: "center" },
                    { title: "Date", field: "DT_CREATED", align: "center" },
                    { title: "Signature", field: "CREATED_BY", sorter: "string", align: "center" },
                    { title: "AdjustmentNo", field: "STOCK_ADJ_NO", align: "center" },
                    { title: "Tekst", field: "STOCK_ADJ_COMMENT", sorter: "date", align: "center" },
                    { title: "Old Qty", field: "STOCK_ADJ_OLD_QTY", align: "center" },
                    { title: "Changed Qty", field: "STOCK_ADJ_CHANGED_QTY", align: "center" },
                    { title: "New Qty", field: "STOCK_ADJ_NEW_QTY", align: "center" },
                    
                ],


            });

            $("#soldGridPriceAdjustments").tabulator({
                height: 400, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                //responsiveLayout: true,
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


                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    ;
                },
                rowContext: function (e, row) {
                    //e - the click event object
                    //row - row component
                    //alert();
                    //e.preventDefault(); // prevent the browsers default context menu form appearing.
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
                        title: "PriceId", field: "PRICE_ADJ_ID", width: 70, align: "center", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component
                        },
                    },  
                    { title: "Date", field: "DT_CREATED", align: "center" },
                    { title: "Signature", field: "CREATED_BY", sorter: "date", align: "center" },
                    { title: "Tekst", field: "PRICE_ADJ_TEXT", sorter: "date", align: "center"},
                    { title: "Old price", field: "PRICE_ADJ_OLD_PRICE", align: "center" },
                    { title: "Changed price", field: "PRICE_ADJ_CHANGED_PRICE", align: "center" },
                    { title: "New price", field: "PRICE_ADJ_NEW_PRICE", align: "center" },

                ],


            });
            
            $('#drpHistoryType').dropdown('setting', 'onChange', function (val)
            {
                var functionValue = val;
           
                 var id_item = $('#<%=txtSpareNo.ClientID%>').val();
                    if (id_item == "" || id_item == undefined)
                    {
                        id_item = "%";
                    }

                    var supp = $('#<%=txtInfoSupplier.ClientID%>').val();
                    if (supp == "" || supp == undefined)
                    {
                        supp = "%";
                    }
                    var catg = $('#<%=drpCategory.ClientID%>').val();
                    if (catg == "" || catg == undefined)
                    {
                        catg = "%";
                    }
                if (functionValue == 0) {
              
                    $("#soldGridOrder").removeClass("hidden");

                    $("#soldGridPurchaseOrder").addClass("hidden");
                    $("#soldGridStockAdjustments").addClass("hidden");
                    $("#soldGridPriceAdjustments").addClass("hidden");
                   
                    $("#soldGridOrder").tabulator("setData", "LocalSPDetail.aspx/Fetch_Orders", { 'id_item': id_item, 'supplier': supp, 'catg': catg, 'functionValue': functionValue }); //make ajax request with advanced config options
                    $("#soldGridOrder").tabulator("redraw", true);
                }
                else if (functionValue == 1) {
                    
                    $("#soldGridPurchaseOrder").removeClass("hidden");
                    $("#soldGridOrder").addClass("hidden");
                    $("#soldGridStockAdjustments").addClass("hidden");
                    $("#soldGridPriceAdjustments").addClass("hidden");
                    $("#soldGridPurchaseOrder").tabulator("setData", "LocalSPDetail.aspx/Fetch_PurchaseOrders", { 'id_item': id_item, 'supplier': supp, 'catg': catg, 'functionValue': functionValue }); //make ajax request with advanced config options
                    $("#soldGridPurchaseOrder").tabulator("redraw", true);
                }
                else if (functionValue == 2) {
                  
                    $("#soldGridStockAdjustments").removeClass("hidden");
                    $("#soldGridOrder").addClass("hidden");
                    $("#soldGridPurchaseOrder").addClass("hidden");
                    $("#soldGridPriceAdjustments").addClass("hidden");
                    $("#soldGridStockAdjustments").tabulator("setData", "LocalSPDetail.aspx/Fetch_StockAdjustments", { 'id_item': id_item, 'supplier': supp, 'catg': catg, 'functionValue': functionValue }); //make ajax request with advanced config options
                    $("#soldGridStockAdjustments").tabulator("redraw", true);
                }
                else if (functionValue == 3) {
        
                    $("#soldGridPriceAdjustments").removeClass("hidden");
                    $("#soldGridStockAdjustments").addClass("hidden");
                    $("#soldGridOrder").addClass("hidden");
                    $("#soldGridPurchaseOrder").addClass("hidden");
                    $("#soldGridPriceAdjustments").tabulator("setData", "LocalSPDetail.aspx/Fetch_PriceAdjustments", { 'id_item': id_item, 'supplier': supp, 'catg': catg, 'functionValue': functionValue }); //make ajax request with advanced config options
                    $("#soldGridPriceAdjustments").tabulator("redraw", true);
                }
            }
            );
            //load sample data into the table
          

            /*Fetching the currency data based on the currency code*/
            function FetchCurrencyDetails(CURRENCY_CODE) {
               console.log(CURRENCY_CODE);
                cpChange = '';
                $.ajax({
                    type: "POST",
                    url: "../SS3/SupplierDetail.aspx/FetchCurrencyDetail",
                    data: "{CURRENCY_CODE: '" + CURRENCY_CODE + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                       
                        console.log(data.d);
                        var rate = '';
                        var unit = '';
                        var BasisPrice = 0;
                        var LastCostPrice = 0;
                        var CostPrice = 0;
                        var NetPrice = 0;
                        var SalesPrice = 0;
                        var Total = '';
                       

                        rate = fnformatDecimalValue(data.d.CURRENCY_RATE, seperator);
                        //rate = rate.replace(',', '.');
                        
                        unit = fnformatDecimalValue(data.d.CURRENCY_UNIT, seperator);
                        //unit = unit.replace(',', '.');

                        if (data.d.CURRENCY_CODE == "NOK") {

                            $(".foreignCurrency").css('visibility', 'hidden')

                        }
                        else {
                             $(".foreignCurrency").css('visibility', 'visible')
                        }
                      
                        console.log('currency basis ' + $('#<%=txtInfoBasisPriceNok.ClientID%>').val());
                        console.log('currency basis: ' +BasisPrice);
                        <%--BasisPrice = $('#<%=txtInfoBasisPriceNok.ClientID%>').val().replace(',', '.');
                        LastCostPrice = $('#<%=txtInfoLastCostNok.ClientID%>').val().replace(',', '.');
                        CostPrice = $('#<%=txtInfoCostPriceNok.ClientID%>').val().replace(',', '.');
                        NetPrice = $('#<%=txtInfoNetPriceNok.ClientID%>').val().replace(',', '.');
                        SalesPrice = $('#<%=txtInfoSalesPriceNok.ClientID%>').val().replace(',', '.');--%>
                        BasisPrice = fnformatDecimalValue($('#<%=txtInfoBasisPriceNok.ClientID%>').val(), seperator);
                        LastCostPrice = fnformatDecimalValue($('#<%=txtInfoLastCostNok.ClientID%>').val(), seperator);
                        CostPrice = fnformatDecimalValue($('#<%=txtInfoCostPriceNok.ClientID%>').val(), seperator);
                        NetPrice = fnformatDecimalValue($('#<%=txtInfoNetPriceNok.ClientID%>').val(), seperator);
                        SalesPrice = fnformatDecimalValue($('#<%=txtInfoSalesPriceNok.ClientID%>').val(), seperator);
                       
                        console.log('rate: ' + rate);
                        console.log('unit: ' + unit);

                        //NetPrice = fnformatDecimalValue($('#<%=txtInfoNetPriceNok.ClientID%>').val(), seperator);
                        //SalesPrice = fnformatDecimalValue($('#<%=txtInfoSalesPriceNok.ClientID%>').val(), seperator);

                        console.log("Before reformat =" + (BasisPrice / rate * unit).toFixed(2));
                        var reBasisPrice = fnreformatDecimal(((BasisPrice / rate * unit).toFixed(2)), seperator);
                        var reCostPrice = fnreformatDecimal(((CostPrice / rate * unit).toFixed(2)), seperator);
                        var reNetPrice = fnreformatDecimal(((NetPrice / rate * unit).toFixed(2)), seperator);
                        var reLastCostPrice = fnreformatDecimal(((LastCostPrice / rate * unit).toFixed(2)), seperator);
                        var reSalesPrice = fnreformatDecimal(((SalesPrice / rate * unit).toFixed(2)), seperator);
                        console.log("After reformat =" + reBasisPrice);

                        //$('#<%=txtInfoBasisPrice.ClientID%>').val((BasisPrice / rate * unit).toFixed(2).replace('.', ','));
                        $('#<%=txtInfoBasisPrice.ClientID%>').val(reBasisPrice);

                        //$('#<%=txtInfoLastCost.ClientID%>').val((LastCostPrice / rate * unit).toFixed(2).replace('.', ','));
                        $('#<%=txtInfoLastCost.ClientID%>').val(reLastCostPrice);

                        //$('#<%=txtInfoCostPrice.ClientID%>').val((CostPrice / rate * unit).toFixed(2).replace('.', ','));
                        $('#<%=txtInfoCostPrice.ClientID%>').val(reCostPrice);

                        //$('#<%=txtInfoNetPrice.ClientID%>').val((NetPrice / rate * unit).toFixed(2).replace('.', ','));
                        $('#<%=txtInfoNetPrice.ClientID%>').val(reNetPrice);

                        //$('#<%=txtInfoSalesPrice.ClientID%>').val((SalesPrice / rate * unit).toFixed(2).replace('.', ','));
                        $('#<%=txtInfoSalesPrice.ClientID%>').val(reSalesPrice);
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
                
           };
            

           
            function saveSparePart(arg) {
                
                var spare = collectGroupData('submit', arg);
                console.log("SPARE IS " + spare);
                console.log("stringify gives: " + JSON.stringify(spare));
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "LocalSPDetail.aspx/InsertSparePart",
                    //data: "{'SparePart': '" + spare.ID_ITEM + "'}",
                    data: "{SparePart:'" + JSON.stringify(spare) + "'}",
                    dataType: "json",
                    //async: false,//Very important
                    success: function (data) {
                        $('.loading').removeClass('loading');
                        //console.log(data.d[0]);
                        if (data.d[0] == "INSFLG") {
                            systemMSG('success', 'Varen har blitt opprettet', 5000);
                            $('#<%=lblNewItem.ClientID%>').css("visibility", "hidden");
                            spare = data.d[1];
                            setSaveVar();
                            if (window.opener != undefined && window.opener != null && !window.opener.closed) {
                                <%--var idModel;
                                 var make = $('#<%=drpMakeCodes.ClientID%>').val();
                                 var model = $('#<%=cmbModelForm.ClientID%> :selected')[0].innerText;--%>
                               
                            }
                        }
                        else if (data.d[0] == "UPDFLG") {
                         
                            $('#<%=lblUpdatedItem.ClientID%>').css("visibility", "visible");
                            setSaveVar();
                            setTimeout(function () {
                                $('#<%=lblUpdatedItem.ClientID%>').css("visibility", "hidden");
                            }, 3000);
                            if (typeof paramRowId !== "undefined" && pageNameFrom=="frmWOJobDetails") {
                                var rowId = paramRowId;
                                var beholdning = $('#<%=txtInfoStockQuantity.ClientID%>').val();
                                var pris = $('#<%=txtInfoSalesPriceNok.ClientID%>').val();
                                var discount = $('#<%=txtInfoDiscountPercentage.ClientID%>').val();
                                var spcostprice = $('#<%=txtInfoLastCostNok.ClientID%>').val(); //txtInfoLastCostNok
                                window.parent.saveSparePartDet(rowId, beholdning, pris, discount,spcostprice);
                            }
                        }
                        else if (data.d[0] == "ERRFLG") {
                            systemMSG('error', 'Noe feil skjedde', 4000);
                        }
                        
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }
           

        function setSaveVar() {
            sparevar = collectGroupData('submit');
        }
        function checkSaveVar() {
            contvar = collectGroupData('submit');
            //if (JSON.stringify(custvar) === JSON.stringify(contvar)) {
            if(objectEquals(sparevar, contvar)){
                return true;
            }
            else {
                return false;
            }
        }
        function clearSaveVar() {
            sparevar = {};
        }

            function UpdateStockQty(newqty) {
                if (newqty == "") {
                    newqty = $('#<%=txtStockAdjNewQty.ClientID%>').val()
                }

            console.log('updating stock value');
            cpChange = '';
            $.ajax({
                type: "POST",
                url: "LocalSPDetail.aspx/UpdateStockQty",
                data: "{id_item: '" + $('#<%=txtSpareNo.ClientID%>').val() + "', supplier: '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', category: '" + $('#<%=drpCategory.ClientID%>').val() + "', warehouse: '" + '1' + "', newqty: '" + newqty + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data.d);
                    $('#<%=txtInfoStockQuantity.ClientID%>').val(newqty);
                    systemMSG('success', 'The spare part stock has been updated!', 4000);
                },
                failure: function () {
                    alert("Failed!");
                }
            });

        };

            $('#<%=btnStockAdjSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modStockAdjustments').addClass('hidden');
                if (($('#<%=txtStockAdjNewQty.ClientID%>').val() == "") || ($('#<%=txtStockAdjComment.ClientID%>').val() == "")) {
                    systemMSG('error', 'Not all values were entered correctly. Please try again!', 4000);
                     $('#<%=txtStockAdjOldQty.ClientID%>').val('');
                    $('#<%=txtStockAdjChangedQty.ClientID%>').val('');
                    $('#<%=txtStockAdjNewQty.ClientID%>').val('');
                    $('#<%=txtStockAdjComment.ClientID%>').val('');
                }
                else
                {
                    $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/UpdateStockAdjustmentValue",
                    data: "{id_item: '" + $('#<%=txtSpareNo.ClientID%>').val() + "', supplier: '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', category: '" + $('#<%=drpCategory.ClientID%>').val() + "', warehouse: '" + '1' + "', oldqty: '" + $('#<%=txtStockAdjOldQty.ClientID%>').val() + "', changedqty: '" + $('#<%=txtStockAdjChangedQty.ClientID%>').val() + "', newqty: '" + $('#<%=txtStockAdjNewQty.ClientID%>').val() + "', signature: '" + $('#<%=txtStockAdjSignature.ClientID%>').val() + "', comment: '" + $('#<%=txtStockAdjComment.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        console.log(data.d);
                        //alert('Data er lagret!');
                        UpdateStockQty();
                        $('#<%=txtInfoStockQuantity.ClientID%>').val($('#<%=txtStockAdjNewQty.ClientID%>').val());
                    },
                    failure: function () {
                        alert("Failed!");
                    }
               })
                $('#<%=txtStockAdjOldQty.ClientID%>').val('');
                $('#<%=txtStockAdjChangedQty.ClientID%>').val('');
                $('#<%=txtStockAdjNewQty.ClientID%>').val('');
                    $('#<%=txtStockAdjComment.ClientID%>').val('');
                }
                });

              $('#<%=btnStockAdjCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modStockAdjustments').addClass('hidden');
                $('#<%=txtStockAdjOldQty.ClientID%>').val('');
                $('#<%=txtStockAdjChangedQty.ClientID%>').val('');
                $('#<%=txtStockAdjNewQty.ClientID%>').val('');
                $('#<%=txtStockAdjComment.ClientID%>').val('');
              });
            $('#<%=txtStockAdjNewQty.ClientID%>').on('blur', function () {
                var oldqty, changedqty, newqty = 0;

                //oldqty = $('#<%=txtStockAdjOldQty.ClientID%>').val().replace(',', '.');
                oldqty = fnformatDecimalValue($('#<%=txtStockAdjOldQty.ClientID%>').val(), seperator);
                //newqty = $('#<%=txtStockAdjNewQty.ClientID%>').val().replace(',', '.');
                newqty = fnformatDecimalValue($('#<%=txtStockAdjNewQty.ClientID%>').val(), seperator);
                //$('#<%=txtStockAdjChangedQty.ClientID%>').val((newqty - oldqty).toFixed(2).replace('.', ','));
                $('#<%=txtStockAdjChangedQty.ClientID%>').val(fnreformatDecimal((newqty - oldqty).toFixed(2), seperator));
            });

        $.contextMenu({
            selector: '#stockContext',   //only trigger contextmenu on selected rows in table
            items: {
                open: {
                    name: "Beh.endring",
                    icon: "edit",
                    callback: function (key, opt) {
                        //openModalItemInformation(); //opens modal and shows information about the items on this order
                        overlay('on', 'modStockAdjustments');
                        $('#<%=txtStockAdjOldQty.ClientID%>').val($('#<%=txtInfoStockQuantity.ClientID%>').val());
                        $('#<%=txtStockAdjNewQty.ClientID%>').focus();
                    }
                },

                
            }
        });

            function UpdatePriceAdjustment() {
                    
                newsalesprice = $('#<%=txtInfoSalesPriceNok.ClientID%>').val();  
                newsalesprice = newsalesprice.toString();
                //700,50
                //if (newsalesprice.indexOf(',') > -1) { newsalesprice = parseFloat(newsalesprice.replace(',', '.')); console.log("inside indexof newprice " + newsalesprice); }
                if (newsalesprice.indexOf(',') > -1) { newsalesprice = parseFloat(fnformatDecimalValue(newsalesprice, seperator)); console.log("inside indexof newprice " + newsalesprice); }
                else {
                    newsalesprice = parseFloat(newsalesprice);
                }
                //(number)700.50
                //newsalesprice =  parseFloat(newsalesprice);
                //oldsalesprice =  parseFloat(oldsalesprice);
                changedsalesprice = 0;
             
                oldsalesprice = oldsalesprice.toString();
                //(string) 700,50
                //if (oldsalesprice.indexOf(',') > -1) { oldsalesprice = parseFloat(oldsalesprice.replace(',', '.')); console.log("inside indexof oldprice " + oldsalesprice); }
                if (oldsalesprice.indexOf(',') > -1) { oldsalesprice = parseFloat(fnformatDecimalValue(oldsalesprice, seperator)); console.log("inside indexof oldprice " + oldsalesprice); }
                else {
                    oldsalesprice = parseFloat(oldsalesprice);
                }
                //(number)700.50
                   console.log("INSIDE UPDATEPRICE, OLDSALEPRICE IS: " + oldsalesprice);
                console.log("INSIDE UPDATEPRICE, type IS: " + typeof (oldsalesprice));
                console.log("after , NEWSALEPRICE IS: " + newsalesprice);
                console.log("after , type IS: " + typeof (newsalesprice));
                //if (newsalesprice.indexOf(',') > -1) { newsalesprice = parseFloat(newsalesprice.replace(',', '.')); console.log("inside indexof newprice " + oldsalesprice); }
                //else {
                //    newsalesprice = parseFloat(newsalesprice);
                //}

                changedsalesprice = newsalesprice - oldsalesprice;




                console.log("VISER PRIS FØR PRISOPPDATERING: " + oldsalesprice + " - " + newsalesprice + typeof (oldsalesprice) + " - " + typeof (newsalesprice));
                if (oldsalesprice != newsalesprice && oldsalesprice != undefined) {
                    //alert("we must update the new salesprice");

                    



                    console.log('updating price value');

                    $.ajax({
                        type: "POST",
                        url: "LocalSPDetail.aspx/UpdatePriceAdjustment",
                        data: "{id_item: '" + $('#<%=txtSpareNo.ClientID%>').val() + "', supplier: '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "', category: '" + $('#<%=drpCategory.ClientID%>').val() + "', warehouse: '" + '1' + "', oldprice: '" + oldsalesprice + "', changedprice: '" + changedsalesprice + "', newprice: '" + newsalesprice + "', signature: '" + $('#<%=txtStockAdjSignature.ClientID%>').val() + "', comment: '" + "Updated manually" + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            console.log(data.d);

                            oldsalesprice = newsalesprice;
                            changedsalesprice = 0;

                        },
                        failure: function () {
                            alert("Failed!");
                        }
                    });
                }
            };

             $('#<%=txtInfoDiscountCode.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "LocalSPDetail.aspx/Fetch_DiscountCodes",
                        data: "{q:'" + $('#<%=txtInfoDiscountCode.ClientID%>').val() + "', supplier: '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log($('#<%=txtSpareNo.ClientID%>').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: 'Ingen treff i lokalt lager. Søke i non-stock register?', value: $('#<%=txtSpareNo.ClientID%>').val() , val: 'new' }]);
                            } else
                                response($.map(data.d, function (item) {
                                    imake = item.ID_MAKE;
                                    iid = item.ID_ITEM;
                                    iwh = '1';
                                    return {
                                        label: item.DISCOUNT + " - " + item.DISCOUNTPERCENT + " - " + item.ID_ORDERTYPE,
                                        val: item.DISCOUNT,
                                        value: item.DISCOUNT
                                        
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
                select: function (e, i)
                {
                    
                    if(i.item.val != "new")
                    {
                        $('#<%=txtInfoDiscountCode.ClientID%>').val(i.item.value);
                        
                     
                    }
                    else
                    {
                       // openSparepartGridWindow("LocalSPDetail");
                        //window.parent.document.getElementById('ctl00_cntMainPanel_txtSpareNo').value = "test"; //hvorfor virker ikke dette?
                        
                    }

                }
             });

            function getDiscountandFreight() {
                var basisprice, costprice, netprice, salesprice,salesincvat, freightlimit, freightpercentabove, freightpercentbelow, discountcode, discountpercent, discountamount = 0;


            $.ajax({
                    type: "POST",
                    url: "LocalSPDetail.aspx/FetchBasicCalcVal",
                    data: "{discount: '" + $('#<%=txtInfoDiscountCode.ClientID%>').val() + "', supplier: '" + $('#<%=txtInfoSupplier.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        console.log(data.d);
                        

                        basisprice = parseFloat($('#<%=txtInfoBasisPriceNok.ClientID%>').val());
                        
                        freightlimit = data.d[0].FREIGHT_LIMIT
                        freightpercentabove = data.d[0].FREIGHT_PERC_ABOVE
                        freightpercentbelow = data.d[0].FREIGHT_PERC_BELOW
                        discountcode = data.d[0].DISCOUNT
                        discountpercent = data.d[0].DISCOUNTPERCENT
                        discountpercent = parseFloat(discountpercent.replace(',', '.'));
                        discountamount = (basisprice * discountpercent) / 100;
                        discountamount = parseFloat(discountamount);
                        costprice = (basisprice - discountamount);
                        //costprice = costprice.toFixed(2).replace('.', ',');
                        //alert(freightlimit + " - " + costprice);
                        if (freightlimit < costprice) {
                            netprice = (((freightpercentabove / 100) + 1) * costprice);
                            salesprice = (((freightpercentabove / 100) + 1) * basisprice);
                            salesincvat = (salesprice * 1.25);

                        }
                        else {
                            netprice = (((freightpercentbelow / 100) + 1) * costprice);
                            salesprice = (((freightpercentbelow / 100) + 1) * basisprice);
                            salesincvat = (salesprice * 1.25);
                            

                        }
                        //basisprice = basisprice.toFixed(2).replace('.', ',');
                        basisprice = fnreformatDecimal(basisprice.toFixed(2), seperator);
                        //netprice = netprice.toFixed(2).replace(".", ",");
                        netprice = fnreformatDecimal(netprice.toFixed(2), seperator);
                        //costprice = costprice.toFixed(2).replace('.', ',');
                        costprice = fnreformatDecimal(costprice.toFixed(2), seperator);
                        //salesprice = salesprice.toFixed(2).replace(".", ",");
                        salesprice = fnreformatDecimal(salesprice.toFixed(2), seperator);
                        //salesincvat = salesincvat.toFixed(2).replace(".", ",");
                        salesincvat = fnreformatDecimal(salesincvat.toFixed(2), seperator);
                        //alert(costprice + " - " + data.d[0].DISCOUNT + " - " + discountpercent + " - " + data.d[0].FREIGHT_LIMIT + " - " + data.d[0].FREIGHT_PERC_ABOVE + " - " + data.d[0].FREIGHT_PERC_BELOW + " - " + data.d[0].FREIGHT_LIMIT);
                        $('#<%=txtInfoBasisPriceNok.ClientID%>').val(basisprice);
                        $('#<%=txtInfoLastCostNok.ClientID%>').val(costprice);
                        $('#<%=txtInfoCostPriceNok.ClientID%>').val(costprice);
                        $('#<%=txtInfoNetPriceNok.ClientID%>').val(netprice);
                        $('#<%=txtInfoSalesPriceNok.ClientID%>').val(salesprice);
                      
                        $('#<%=txtInfoIncludeVat.ClientID%>').val(salesincvat);

                    },
                    failure: function () {
                        alert("Failed!");
                    }
               });

            };
          
        });
         
  
    </script>
    <asp:HiddenField ID="hdnSelect" runat="server" />
    <div class="overlayHide">
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
    </div>
    <div id="systemMessage" class="ui message"></div>



    <div class="ui one column grid">
        <div class="stretched row">
            <div class="sixteen wide column">
                <div class="ui form">
                  
        <div class="sixteen wide column">
            
            <div class="ui form">
                <div class="fields">
                 <div class="two wide field">
                    <label><asp:Label ID="lblNewItem" style="color:blue; font-weight:800; font-size:16px" Text="Ny vare" runat="server" meta:resourcekey="lblRegNoResource12" ></asp:Label></label>
                     <label><asp:Label ID="lblUpdatedItem" style="color:green; font-weight:800; font-size:16px; visibility:hidden;" Text="Vare oppdatert" runat="server" meta:resourcekey="lblRegNoResource12" ></asp:Label></label>
                </div>
                    </div>
                <div class="fields">
                    
                    <div class="two wide field">
                        <label>
                            <asp:Label ID="lblSpareNo" Text="VareNr" runat="server" meta:resourcekey="lblRegNoResource1" ></asp:Label></label>
                        <%--<input type="text" id="txtRegNo" class="texttest">--%>
                        <asp:TextBox ID="txtSpareNo" runat="server" Style="text-transform: uppercase;" meta:resourcekey="txtRegNoResource1" CssClass="carsInput" data-submit="ID_ITEM"></asp:TextBox>
                    </div>
                    <div class="three wide field">
                        <label>
                            <asp:Label ID="lblRefNo" Text="Betegnelse" runat="server" meta:resourcekey="lblRefNoResource1"></asp:Label></label>
                        <asp:TextBox ID="txtsparedesc" runat="server"  meta:resourcekey="txtIntNoResource1" CssClass="carsInput" data-submit="ITEM_DESC"></asp:TextBox>
                    </div>
                    <div class="one wide field">
                        <label>&nbsp;</label>
                        
                    </div>
                    <div class="four wide field"></div>
                    <div class="three wide field">
                        <label>&nbsp;</label>
                       <div class="container">
                            <input id="txtSpareSearch" type="text" class="donottriggersave" placeholder="Søk etter vare.." />
                            <div class="search"></div>
                        </div>

                    </div>
                    
                   
                 
                    
                    
                </div>
            </div>
        </div>
   
                </div>

                <div class="ui top attached tabular menu">
                    <a class="item active" data-tab="SpareInfo">Generelt</a>
                    <a class="item" data-tab="Advanced">Avansert</a>
                    <a class="item" data-tab="SpareHistory" id="btnSpareHistory">Omsetning</a>
                    <a class="item" data-tab="SpareSold" id="btnSpareSold">Historikk</a>
                    <a class="item" data-tab="SpareImages">Bilder</a>
                </div>


                <div class="ui bottom attached tab segment active" data-tab="SpareInfo">
                    <div id="tabSpareInfo">
                        <div class="ui form stackable two column grid ">
                            <div class="ten wide column">
                                <%--left column--%>

                                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <h3 id="lblVehicleModel" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Detaljer</h3>
                                        <div class="ui divider"></div>
                                
                                    <%--vehicle model panel--%>
                                    
                                    <div class="fields">

                                        <div class="two wide field">
                                            <label id="lblInfoSupplier" runat="server">Leverandør</label>
                                            <asp:TextBox ID="txtInfoSupplier" runat="server" data-submit="ID_MAKE"  CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="eight wide field">
                                            <label>&nbsp;</label>
                                            <asp:TextBox ID="txtInfoSupplierName" runat="server" Enabled="false" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="one wide field">
                                            
                                        </div>
                                        
                                        <div class="four wide field">
                                            <label id="lblInfoSpareGroup" runat="server">Varegruppe</label>
                                            <asp:DropDownList ID="drpMakeCodes" CssClass="carsInput" Visible="false" data-submit="ID_SUPPLIER_ITEM" runat="server" ></asp:DropDownList>
                                            <asp:DropDownList ID="drpCategory"  CssClass="carsInput" data-submit="ID_ITEM_CATG" runat="server"></asp:DropDownList>
                                        </div>
                                        <div class="one wide field">
                                            <label>&nbsp;</label>
                                            <div class="ui mini input">
                                                <input type="button" id="btnEditMake" runat="server" class="ui btn mini" value=" + " />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="fields">
                                        
                                        <div class="two wide field">
                                            <label id="lblInfoLocation" runat="server">Lokasjon</label>
                                            <asp:TextBox ID="txtInfoLocation" runat="server" data-submit="LOCATION"  CssClass="carsInput"></asp:TextBox>


                                        </div>
                                        
                                        <div class="two wide field">
                                            <label id="lblInfoAltLocation" runat="server">Alt. lokasjon</label>
                                            <asp:TextBox ID="txtInfoAltLocation" Enabled="false" runat="server" data-submit="ALT_LOCATION"  CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="one wide field">
                                            
                                        </div>

                                        <div class="five wide field">
                                             <label id="lblInfoRefund" runat="server">Pant nr.</label>
                                            <asp:TextBox ID="txtInfoRefund" runat="server" data-submit="DEPOSITREFUND_ID_ITEM" CssClass="carsInput" ></asp:TextBox>
                                        </div>

                                        <div class="three wide field">
                                            <label id="lblInfoStockQuantity" runat="server">Beholdning</label>
                                            <div id="stockContext">
                                                <asp:TextBox ID="txtInfoStockQuantity" Enabled="false" runat="server" data-submit="ITEM_AVAIL_QTY"  CssClass="carsInput disabledBox"></asp:TextBox>

                                            </div>
                                        </div>

                                        <div class="two wide field">
                                            <label id="lblInfoDiscountCode" runat="server">Rabattkode</label>
                                            <asp:TextBox ID="txtInfoDiscountCode" runat="server" data-submit="ITEM_DISC_CODE_BUY"  CssClass="carsInput"></asp:TextBox>

                                        </div>
                                        <div class="one wide field">
                                            <label>&nbsp;</label>
                                            <div class="ui mini input">
                                                <input type="button" id="btnInfoOpenDiscount" title="Open discount code list" runat="server" class="ui btn mini" value=" + " />
                                            </div>
                                        </div>


                                    </div>
                                    <div class="fields">
                                       
                                        
                                        <div class="two wide field">
                                          <label id="lblInfoWeight" runat="server">Vekt</label>
                                            <asp:TextBox ID="txtInfoWeight" runat="server" data-submit="WEIGHT"  CssClass="carsInput"></asp:TextBox>
                                        </div>

                                        <div class="two wide field">
                                             <label id="lblAccountCode" runat="server">Account Code</label>
                                                <asp:TextBox ID="txtAccountCode" runat="server" data-submit="ACCOUNT_CODE"  CssClass="carsInput"></asp:TextBox>
                                        </div>
                                    <div class="one wide field">
                                         
                                        </div>
                                    
                                        <div class="five wide field">
                                            <label id="Labels1" runat="server">Tidligere nr.</label>
                                            <asp:TextBox ID="txtInfoReplEarlierNo" runat="server" CssClass="carsInput"></asp:TextBox>

                                        </div>
                                        
                                        <div class="five wide field">
                                            <label id="Label2" runat="server">Erstatningsnr.</label>
                                            <asp:TextBox ID="txtInfoReplacementNo" runat="server" CssClass="carsInput"></asp:TextBox>
                                        </div>

                                       
                                            <div class="one wide field">
                                            <label>&nbsp;</label>
                                            <div class="ui mini input">
                                                <input type="button" id="btnModalReplacementItems" runat="server" class="ui btn mini" value=" + " />
                                            </div>
                                        </div>
                                        </div>
                           
                                    <div class="fields" style="margin-top: 3rem;">


                                            <div class="four wide field">
                                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnParameters">Parametre</button>

                                            </div>
                       
                                            <div class="four wide field">

                                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnNotes"><i class="exclamation triangle icon" id="exclamIconNotes" style="color: red; display: none;"></i>Notater</button>

                                            </div>
                                            
                                        </div>

                            </div>
                                </div>
                            <%--end left column--%>
                            <div class="six wide column">
                                <%--right column--%>

                                <div class="ui form">
                                     <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <h3  runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Prisdetaljer</h3>
                                        
                                        <div class="ui divider"></div>
                                
                                        <div class="inline fields">
                                            <%--Basis price /Veiledende pris--%>
                                            <div class="six wide field">
                                           
                                           <a href="#"><i  id="eyePriceIcon" class="fas fa-eye-slash" title="Vis/skjul priser"></i></a>
                                           <a href="#"><i  id="campaignIcon" class="fas fa-bullhorn" title="Kampanjepris"></i></a>
                                         
                                            </div>
                                            <div class="six wide field">
                                                <asp:Label ID="lblInfoCurrency" runat="server" Text="NOK"  CssClass="foreignCurrency"></asp:Label>
                                            </div>
                                            <div class="six wide field">
                                                <label>
                                                    <asp:Label ID="lblInfoNOK"  runat="server" Text="Nkr."></asp:Label>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="inline fields">
                                            <%--Basis price /Veiledende pris--%>
                                            <div class="six wide field">
                                                <label>
                                                    <asp:Label ID="lblInfoBasisPrice" runat="server" Text="Veil. pris"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoBasisPrice"  Enabled="false" runat="server" CssClass="carsInput hidePrice foreignCurrency"></asp:TextBox>
                                            </div>
                                            
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoBasisPriceNok" runat="server"  data-submit="BASIC_PRICE" CssClass="carsInput hidePrice"></asp:TextBox>
                                            </div>
                                            
                                        </div>
                                        <div class="inline fields">
                                            <%--Last cost price/ siste kostpris--%>
                                            <div class="six wide field">
                                                <label>
                                                    <asp:Label ID="lblInfoLastCost" runat="server" Text="Siste kostpris"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoLastCost"  Enabled="false" runat="server" CssClass="carsInput hidePrice foreignCurrency"></asp:TextBox>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoLastCostNok" runat="server" data-submit="COST_PRICE1" CssClass="carsInput hidePrice"></asp:TextBox>
                                            </div>
                                           
                                        </div>
                                        <div class="inline fields">
                                            <%--Cost price/ kostpris--%>
                                            <div class="six wide field">
                                                <label>
                                                    <asp:Label ID="lblInfoCostPrice" runat="server" Text="Kostpris"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoCostPrice"  Enabled="false" runat="server" CssClass="carsInput hidePrice foreignCurrency"></asp:TextBox>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoCostPriceNok"  runat="server" data-submit="AVG_PRICE" CssClass="carsInput hidePrice "></asp:TextBox>
                                            </div>
                                            
                                        </div>
                                        <div class="inline fields">
                                            <%--Net price/ nettopris--%>
                                            <div class="six wide field">
                                                <label>
                                                    <asp:Label ID="lblInfoNetPrice" runat="server" Text="Nettopris"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoNetPrice"  Enabled="false" runat="server" CssClass="carsInput hidePrice foreignCurrency"></asp:TextBox>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoNetPriceNok"  runat="server" data-submit="NET_PRICE" CssClass="carsInput hidePrice"></asp:TextBox>
                                            </div>
                                           
                                        </div>
                                        <h3 class="ui dividing header"></h3>
                                        <div class="inline fields">
                                            <%--Sales price/ salgspris--%>
                                            <div class="six wide field">
                                                <label>
                                                    <asp:Label ID="lblInfoSalesPrice" runat="server" Text="Salgspris"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoSalesPrice"   Enabled="false" runat="server" CssClass="carsInput foreignCurrency"></asp:TextBox>
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoSalesPriceNok"  runat="server" data-submit="ITEM_PRICE" CssClass="carsInput"></asp:TextBox>
                                            </div>
                                            
                                        </div>
                                        <div class="inline fields">
                                            <%--Sales price/ salgspris--%>
                                            <div class="six wide field">
                                                <label>
                                                    <asp:Label ID="lblInfoIncludeVat" runat="server" Text="Inkludert MVA"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="six wide field">
                                            </div>
                                            <div class="six wide field">
                                                <asp:TextBox ID="txtInfoIncludeVat"  runat="server" CssClass="carsInput"></asp:TextBox>
                                            </div>
                                           
                                        </div>
                                    </div>
                                </div>
                               
                                    
                                
                            </div>
                        </div>
                    </div>
                </div>
                <%--End tab spareinfo--%>

                <%-- makeEdit Modal --%>

                <%-- New tab for Tecnical --%>
                <div class="ui bottom attached tab segment" data-tab="Advanced">
                    <div id="tabAdvanced">
                        <div class="ui form stackable two column grid ">
                            <div class="eight wide column">
                                <%--left column--%>

                                 <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <h3 id="H2" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Avansert</h3>
                                        <div class="ui divider"></div>
                                    <%--vehicle model panel--%>
                                    <div class="fields">
                                        <div class="six wide field">
                                        </div>
                                        <div class="six wide field">
                                        </div>
                                    </div>
                                   
                                
                                    <div class="fields">
                                        
                                       

                                        <div class="three wide field">
                                            <label id="lblAdvUnit" runat="server">Enhet</label>
                                            <asp:TextBox ID="txtAdvUnit" runat="server" data-submit="PACKAGE_QTY"  CssClass="carsInput"></asp:TextBox>
                                        </div>
                                      
                                        <div class="three wide field">
                                            <label id="lblAdvUnitDesc" runat="server">Enhet</label>
                                            <asp:DropDownList ID="drpAdvUnitItem" CssClass="carsInput" data-submit="ID_UNIT_ITEM" runat="server"  ></asp:DropDownList>
                                        </div>
                                       
                                        <div class="three wide field">
                                            <label id="lblAdvWarehouse" runat="server">Lager</label>
                                            <asp:TextBox ID="txtAdvWarehouse" runat="server"  data-submit="ID_WH_ITEM" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                       
                                        <div class="four wide field">
                                            <label id="lblAdvMaxSale" runat="server">Maks. salg</label>
                                            <asp:TextBox ID="txtAdvMaxSale" runat="server"  CssClass="carsInput"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="fields">
                                        <div class="seven wide field">
                                            <label id="lblAdvBarcodeNo" runat="server">Strekkode nr.</label>
                                            <asp:TextBox ID="txtAdvBarcodeNo" runat="server"  CssClass="carsInput" data-submit="BARCODE_NUMBER"></asp:TextBox>

                                        </div>
                                        <div class="four wide field">
                                            <label id="lblAdvSpareSubMake" runat="server">Lev. subnr.</label>
                                            <asp:TextBox ID="txtAdvSpareSubSupplier" runat="server" data-submit="ENV_ID_MAKE"  CssClass="carsInput"></asp:TextBox>
                                           </div>
                                        <div class="five wide field">
                                            <label id="lblAdvSpareSubNo" runat="server">Vare subnr. </label>
                                            <asp:TextBox ID="txtAdvSpareSubNo" runat="server" data-submit="ENV_ID_ITEM"  CssClass="carsInput"></asp:TextBox>
                                        </div>
                                       
                                    </div>
                                     <div class="four wide field">
                                            <button class="ui button carsButtonBlueInverted wide" type="button" id="btnCrosslist"><i class="exclamation triangle icon" id="exclamIcon" style="color: red;"></i>Crossliste</button>
                                        </div>
                               </div>

                                <%--end vehicle model panel--%>
                                 <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <h3 id="H3" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Bestillingsparametre</h3>
                                        <div class="ui divider"></div>
                                        <div class="inline fields">
                                            <%--Basis price /Veiledende pris--%>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblAdvMinQty" runat="server" Text="Min. beholdning"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="four wide field">
                                                <asp:TextBox ID="txtAdvMinQty" Text="0" runat="server" data-submit="MIN_STOCK"  CssClass="carsInput"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblAdvBudgetConsumption" runat="server" Text="Budsj. forbruk"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="four wide field">
                                                <asp:TextBox ID="txtAdvBudgetConsumptions" Text="0" runat="server" data-submit="CONSUMPTION_ESTIMATED"  CssClass="carsInput"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="inline fields">
                                            <%--Basis price /Veiledende pris--%>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblAdvMinPurchase" runat="server" Text="Min. bestilling"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="four wide field">
                                                <asp:TextBox ID="txtAdvMinPurchase" Text="0" runat="server" data-submit="MIN_PURCHASE" CssClass="carsInput"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblAdvMaxPurchase" runat="server" Text="Max. bestilling"></asp:Label>
                                                </label>
                                            </div>
                                            <div class="four wide field">
                                                <asp:TextBox ID="txtAdvMaxPurchase" Text="0" runat="server" data-submit="MAX_PURCHASE"  CssClass="carsInput"></asp:TextBox>
                                            </div>
                                        </div>
                                                 <div class="fields">
                                         <div class="four wide field">
                                             <div class="ui mini green right labeled icon button" id="order_item">
                                                 Bestill 
                <i class="plus icon"></i>
                                             </div>
                                         </div>

                                         <div class="four wide field">
                                             <div class="ui mini orange right labeled icon button" id="return_item">
                                                 Returner 
                <i class="plus icon"></i>
                                             </div>
                                         </div>
                                         </div>
                                    </div>
                                
                                    <%--vehicle info panel--%>
                                    
                                </div>
             
                            <%--end left column--%>
                            <div class="eight wide column">
                                <%--right column--%>

                             
                                   
                               
                                 <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H17777" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">I nåværende bestilling</h3>
                                    <div class="ui divider"></div>
                               
                                    <div class="fields">
                                        <div class="two wide field">
                                            <label id="Label5" runat="server">Tot. Ant</label>                                
                                            <asp:TextBox ID="txtAdvTotalQtyInPurchase" Text="0" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                            <div class="ui flowing popup top left transition hidden">
                                                <div class="ui three column divided center aligned grid">
                                                    <div class="column">
                                                        <h4 class="ui header">Basic Plan</h4>
                                                        <p><b>2</b> projects, $10 a month</p>
                                                        <div class="ui button">Choose</div>
                                                    </div>
                                                    <div class="column">
                                                        <h4 class="ui header">Business Plan</h4>
                                                        <p><b>5</b> projects, $20 a month</p>
                                                        <div class="ui button">Choose</div>
                                                    </div>
                                                    <div class="column">
                                                        <h4 class="ui header">Premium Plan</h4>
                                                        <p><b>8</b> projects, $25 a month</p>
                                                        <div class="ui button">Choose</div>
                                                    </div>
                                                </div>
                                            </div>

                                           
                                        </div>
                                        <div class="two wide field">
                                            </div>
                                        <div class="two wide field">
                                            <label id="lblAdvQtyInPurchase" runat="server">Antall</label>
                                            <asp:TextBox ID="txtAdvQtyInPurchase" Text="0" runat="server" disabled="disabled"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="three wide field">
                                            <label id="lblAdvPurchaseDate" runat="server">Best. dato</label>
                                            <asp:TextBox ID="txtAdvPurchaseDate" runat="server" disabled="disabled"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">
                                            <label id="lblAdvPurchaseNo" runat="server">Bestnr.</label>
                                            <asp:TextBox ID="txtAdvPurchaseNo" runat="server" disabled="disabled" CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        

                                        <div class="three wide field">
                                            <label id="lblAdvArrivalDate" runat="server">Ankomstdato</label>
                                            <asp:TextBox ID="txtAdvArrivalDate" runat="server" disabled="disabled"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>

                                    </div>

                         
                               
                                </div>
                                 <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H18" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Siste ankomst</h3>
                                    <div class="ui divider"></div>
                               
                               
                                    <div class="fields">
                                        <div class="four wide field">
                                            <label id="lblAdvLastIRQty" runat="server">Antall</label>
                                            <asp:TextBox ID="txtAdvLastIRQty" disabled="disabled" Text="0" runat="server" CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">
                                            <label id="lblAdbLastIRDate" runat="server">Ankomstdato</label>
                                            <asp:TextBox ID="txtAdvLastIRDate" disabled="disabled" runat="server" CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">
                                            <label id="lblAdvLastIRNo" runat="server">Best. nr</label>
                                            <asp:TextBox ID="txtAdvLastIRNo" disabled="disabled" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">
                                            <label id="lblAdvLastCostBuy" runat="server">Siste kostpris</label>
                                            <asp:TextBox ID="txtAdvLastCostBuy" disabled="disabled" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                    </div>
                             
                                <h3 id="H199" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Siste verdier</h3>
                                    <div class="ui divider"></div>
                                    <div class="fields">
                                        <div class="four wide field">
                                            <label id="lblAdvLastCountingDate" runat="server">Siste telling</label>
                                            <asp:TextBox ID="txtAdvLastCountingDate" Text="" runat="server" CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">
                                            <label id="lblAdvCountingSignature" runat="server">Signatur</label>
                                            <asp:TextBox ID="txtAdvCountingSignature" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="eight wide field">
                                            <label id="lblAdvSignatureName" runat="server">Navn</label>
                                            <asp:TextBox ID="txtAdvSignatureName" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>

                                    </div>
                                    <div class="fields">
                                        <div class="four wide field">
                                            <label id="lblAdvLastSoldDate" runat="server">Sist solgt</label>
                                            <asp:TextBox ID="txtAdvLastSoldDate" Text="" runat="server" CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="four wide field"> 
                                            <label id="lblAdvLastBODate" runat="server">Sist restet</label>
                                            <asp:TextBox ID="txtAdvLastBODate" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="two wide field">
                                            <label id="lblAdvQtySold" runat="server">Antall</label>
                                            <asp:TextBox ID="txtAdvQtySold" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="three wide field">
                                            <label id="lblAdvQtyBO" runat="server">Ganger restet</label>
                                            <asp:TextBox ID="txtAdvQtyBO" runat="server" CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                        <div class="three wide field">
                                            <label id="lblAdvQtyOffered" runat="server">Ant. tilbudt</label>
                                            <asp:TextBox ID="txtAdvQtyOffered" Text="0" runat="server"  CssClass="carsInput disabledBox"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <%-- New tab for Economy --%>
                <div class="ui bottom attached tab segment " data-tab="SpareHistory">
                    <div id="tabSpareHistory">
                        <h3 class="ui top attached tiny header">Vareomsetning:</h3>
                        <div class="ui attached segment">
                            <div id="dataSelector">
                            </div>
                            <div class="ui two column stackable grid">
                                <div class="column">
                                    <select id="ddlItemHistory-SelYear" class="ui normal dropdown">
                                        <%--<option value=""> -- velg -- </option>--%>
                                    </select>
                                    <div id="itemHistory-PH" class=""></div>
                                </div>
                                <div class="column">
                                    Sammenlign <span id="spSelYear"></span>
                                    med
                    <select id="ddlItemHistory-ComYear" class="ui normal dropdown">
                        <option value="">-- velg -- </option>
                    </select>
                                    <canvas id="ihChart" width="400" height="300"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--TABCUSTOMER--%>
                <div class="ui bottom attached tab segment " data-tab="SpareSold">
                    <div id="tabSpareSold">
                        <div class="ui grid">
                            <div class="fifteen wide column">
                                
                        
                                        <div class="ui selection dropdown" id="drpHistoryType">
                                                <input type="hidden" name="gender">
                                                <i class="dropdown icon"></i>
                                                <div class="default text">Velg historikk</div>
                                                <div class="menu">
                                                    <div class="item" data-value="0">Ordre</div>
                                                    <div class="item" data-value="1">Ankomst</div>
                                                    <div class="item" data-value="2">Beholdningsendring</div>
                                                    <%--Prisjustering dvs når man endrer salgspris på varen eller når varen blir oppdatert ved prisfiler--%>
                                                    <div class="item" data-value="3">Prisendringer</div>
                                                    <div class="item" data-value="4">Varelogg</div>
                                                     <%-- Referanse benyttes av politiet når varer blir knyttet opp  --%>
                                                    <div class="item" data-value="5">Referanser</div>
                                                    <div class="item" data-value="6">Resting</div>
                                                    <%-- Retur av varer ref bilxtra funksjonalitet. ta denne samtidig som returfunksjonen  utvikles.--%>
                                                    <div class="item" data-value="7">Retur</div>
                                                </div>
                                            </div>
                                        
                                            
                                            <div id="soldGridOrder" class="mytabulatorclass"></div>
                                            <div id="soldGridPurchaseOrder" class="mytabulatorclass hidden"></div>
                                            <div id="soldGridStockAdjustments" class="mytabulatorclass hidden"></div>
                                            <div id="soldGridPriceAdjustments" class="mytabulatorclass hidden"></div>
                                        
                                 
                                
                            </div>

                    
                        </div>
                    </div>
                </div>
                <div class="ui bottom attached tab segment " data-tab="SpareImages">
                    <div id="tabSpareImages">
                        <br />
                        <h3 class="ui top attached tiny header">Varebilder og manualer:</h3>
                        <div class="ui attached segment">
                            <div class="ui grid">
                                <div class="four wide column">
                                    <div class="ui form">

                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebMake" runat="server">Merke</label>
                                                <asp:TextBox ID="txtWebMake" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebModel" runat="server">Modell</label>
                                                <asp:TextBox ID="txtWebModel" runat="server" CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebDescription" runat="server">Description</label>
                                                <asp:TextBox ID="txtWebDesc" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebGearbox" runat="server">Girkasse</label>
                                                <asp:TextBox ID="txtWebGearBox" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebGearboxDescription" runat="server">Gir betegnelse</label>
                                                <asp:TextBox ID="txtWebGearDesc" runat="server" CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebTraction" runat="server">Hjuldrift</label>
                                                <asp:TextBox ID="txtWebTraction" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebTractionDescription" runat="server">Hjulbeskrivelse</label>
                                                <asp:TextBox ID="txtWebTractionDesc" runat="server" CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="four wide column">
                                    <div class="ui form">
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebMainColor" runat="server">Hovedfarge</label>
                                                <asp:TextBox ID="txtWebMainColor" runat="server" CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebColorDescription" runat="server">Farge beskr.</label>
                                                <asp:TextBox ID="txtWebColorDesc" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebInteriorColor" runat="server">Interiør farge</label>
                                                <asp:TextBox ID="txtWebInteriorColor" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="sixteen wide field">
                                                <label id="lblWebChassi" runat="server">Karosseri</label>
                                                <asp:TextBox ID="txtWebChassi" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="eight wide field">
                                                <label id="lblWebFirstTimeReg" runat="server">1. gang reg.</label>
                                                <asp:TextBox ID="txtWebRegDate" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                            <div class="eight wide field">
                                                <label id="lblWebRegno" runat="server">Regnr</label>
                                                <asp:TextBox ID="txtWebRegNo" runat="server" CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="five wide field">
                                                <label id="lblWebDoorQty" runat="server">Antall dører</label>
                                                <asp:TextBox ID="txtWebDoorQty" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                            <div class="five wide field">
                                                <label id="lblWebSeatQty" runat="server">Antall seter</label>
                                                <asp:TextBox ID="txtWebSeatQty" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                            <div class="five wide field">
                                                <label id="lblWebOwnerQty" runat="server">Antall eiere</label>
                                                <asp:TextBox ID="txtWebOwnerQty" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                            </div>
                                            <div class="one wide field">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="tabBottom">
        <div class="tbActions">
            <div id="btnEmptyScreen" class="ui button negative donottriggersave">Tøm</div>
            <div id="btnCustLog" class="ui button donottriggersave">Log</div>
            <div id="btnSpareNew" class="ui button blue donottriggersave" >Ny vare</div>            
            
        </div>
    </div>








    <div id="modal_campaign" class="ui small modal">
        <div class="header">Kampanjepris på vare</div>
        <div class="content">
             <div class="ui stackable form">

                <div class="ui header">Legg til kampanjepris</div>
                <div class="inline fields">
                    <div class="eight wide field">
                        <div class="ui blue label" style="min-width: 120px; text-align: center">
                            Startdato                                            
                        </div>
                        <input type="text" id="txtbxStartDate" class="donottriggersave" style="font-weight: bold;" />

                    </div>

                </div>
                <div class="inline fields">
                    <div class="eight wide field">
                        <div class="ui blue label" style="min-width: 120px; margin-top: 1em; text-align: center">
                            Sluttdato                                            
                        </div>
                        <input type="text" id="txtbxEndDate" style="font-weight: bold;" class="donottriggersave" />

                    </div>

                </div>
                <div class="inline fields">
                    <div class="eight wide field">
                        <div class="ui blue label" style="min-width: 120px; margin-top: 1em; text-align: center">
                            Pris                                            
                        </div>
                        <input type="text" id="txtbxCampaignPrice" class="donottriggersave" />

                    </div>
                     <div class="eight wide field">
                        <div class="ui blue label" style="min-width: 120px; margin-top: 1em; text-align: center">
                            Dagens pris                                            
                        </div>
                        <input type="text" id="txtTodaysPrice" class="donottriggersave"  />

                    </div>

                </div>
               
                



                <div id="campaign-table-modal" style="margin-top: 1em;" class="mytabulatorclass"></div>
            </div>
    </div>
    <div class="actions">
        

        <div class="ui cancel button">Lukk</div>
    </div>
    </div>
   


    
    <div class="ui tiny modal" id="modal_notes">
        <div class="header"  style=" text-align:center ">Varenotat</div>
        <div class="content">

             <div class="ui form">
                <div class="field">
                    <label class="sr-only">Notat</label>
                    <div class="ui small info message">
                        <p id="P3" runat="server">Legg inn notater på varen</p>
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
                                <asp:TextBox runat="server" ID="txtNotes" TextMode="MultiLine" CssClass="texttest" Height="181px"  data-submit="ANNOTATION" meta:resourcekey="txtNotesResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            &nbsp;
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
       
        <div class="actions">
            <div class="ui approve success button" id="btnCustNotesSave">Lagre</div>
          
            <div class="ui cancel button" id="btnCustNotesCancel">Avbryt</div>
        </div>
    </div>



    <div id="modal_order_item" class="ui tiny modal">
        <div class="header">Bestill</div>
        <div class="content">
            <div class="ui grid">
               <div class="ui form">
            <div class="inline fields">
                <div class="sixteen wide field" >
                    <div class="ui blue label" style="min-width: 120px; text-align: center">
                        VareNr.                                          
                    </div>
                    <label id="para_item_num"></label>
                </div>
            </div>
           <div class="inline fields">
               <div class="sixteen wide field" >
                   <div class="ui blue label" style="min-width: 120px; text-align: center">
                       Varenavn                                          
                   </div>
                   <label id="para_item_name"></label>
               </div>
           </div>
            
            <div class="inline fields">
                        <div class="sixteen wide field" >

                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Bestillingstype                                            
                            </div>

                           
                            <select class="carsInput" id="dropdown_modal_ordertype" >
                                
                                <option value="0"></option> 
                            </select>
                               
                        </div>

                            <div id="addOrderType" class="ui mini icon pointing green dropdown button" >
                            <i class="plus icon"></i>
                            </div>
                      
                    </div>

            <div class="inline fields">
                        <div class="ten wide field">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Antall                                            
                            </div>
                             <asp:TextBox ID="num_of_items" runat="server"  CssClass="carsInput"></asp:TextBox>

                        </div>
   
                    </div>
                </div>
                </div>
        </div>
         <div class="actions">
            <div class="ui green approve success button" id="mod_order_item">Bestill</div>
          
            <div class="ui cancel button" ">Avbryt</div>
        </div>
    </div>

     <div id="modal_return_item" class="ui tiny modal">
        <div class="header">Returner</div>
        <div class="content">
            <div class="ui grid">
               <div class="ui form">
            
           <div class="inline fields">
               <div class="sixteen wide field">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Signatur                                            
                            </div>
                             <asp:TextBox ID="signature_box" runat="server"  CssClass="carsInput donottriggersave"></asp:TextBox>

                        </div>
           </div>
            
            

            <div class="inline fields">
                        <div class="ten wide field">
                            <div class="ui blue label" style="min-width: 120px; text-align: center">
                                Antall                                            
                            </div>
                             <asp:TextBox ID="num_return" runat="server"  CssClass="carsInput"></asp:TextBox>

                        </div>
   
                    </div>
                </div>
                </div>
        </div>
         <div class="actions">
            <div class="ui green approve success button" id="return_item_confirm">Returner</div>
          
            <div class="ui cancel button" ">Avbryt</div>
        </div>
    </div>

         <%-- New ordertype Modal, css descrived in cars.css --%>
   



          <%-- New ordertype Modal, css descrived in cars.css --%>
    


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
                                        <asp:Label ID="lblEditMakeCode" Text="Fabrikatkode" runat="server" ></asp:Label></label>
                                    <asp:TextBox ID="txtEditMakeCode" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblEditMakeDescription" Text="Beskrivelse" runat="server" ></asp:Label></label>
                                    <asp:TextBox ID="txtEditMakeDescription" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                </div>
                                <div class="">
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblEditMakePriceCode" Text="Priskode" runat="server" ></asp:Label></label>
                                        <asp:TextBox ID="txtEditMakePriceCode" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblEditMakeDiscount" Text="Rabatt" runat="server" ></asp:Label></label>
                                        <asp:TextBox ID="txtEditMakeDiscount" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblEditMakeVat" Text="Mva kode" runat="server" ></asp:Label></label>
                                        <asp:TextBox ID="txtEditMakeVat" runat="server" CssClass="CarsBoxes"></asp:TextBox>
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
                            <asp:TextBox ID="txtGeneralAnnotation" TextMode="MultiLine" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
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



     <div class="ui modal" id="modal_po_steps">
       
        <i class="close icon"></i>
        <div class="header">
   
        </div>


        <div class="content">

            <div class="modal_po_divstep1">
                    
                    <div class="ui header">Følgende varer finnes i lokalt lager</div>
                   
    
                    <div id="item-table-modal" class="mytabulatorclass"></div>



                </div>
  

        </div>

        <div class="actions">
         <div class="ui green approve success button" id="btnModalChooseItem">Velg vare</div>

         <div class="ui blue approve success button" id="btnModalNewItem">Ny vare</div>
          
            <div class="ui cancel button" id="btnModalCancel">Avbryt</div>

        </div>
    </div>


    

     <div class="ui modal" id="replacement_modal">
       
        <i class="close icon"></i>
        <div class="header">
   
        </div>


        <div class="content">

            <div class="modal_po_divstep1">
                    
                    <div class="ui header">Erstatninger</div>
                   
    
                    <div id="replacement-table-modal" class="mytabulatorclass"></div>



                </div>
  

        </div>

        <div class="actions">
          

        </div>
    </div>









     <div class="ui tiny modal" id="modDiscountCodes">
        <div class="header"  style=" text-align:center ">Rabattkoder</div>
        <div class="content">

             <div class="ui form">
                
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <%--har bruklt drop down fra ddlvehiclestatus fra frmvehicledetails--%>
                            <div class="six wide field">
                            <select id="ddlDiscountCodesModal" size="13" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>Rabattkode</label>
                                    <input type="text" disabled="disabled" id="txtbxNewDiscountCode" />
                                </div>
                                <div class="field">
                                    <label>Beskrivelse</label>
                                    <input type="text" disabled="disabled" id="txtbxNewDiscountCodeDescription" />
                                </div>
                                 

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnDiscountCodeNew" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" disabled="disabled" id="btnDiscountCodeSave"  class="ui btn wide" value="Lagre" />
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        
       
        <div class="actions">
            <div class="ui approve success button" id="btnCrosslistSavex">Sett til kode</div>
          
            <div class="ui cancel button" id="btnCrosslistCancexls">Avbryt</div>
        </div>
    </div>

     

     <div class="ui tiny modal" id="modItemCategory">
        <div class="header"  style=" text-align:center ">Varegrupper</div>
        <div class="content">

             <div class="ui form">
                
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <%--har bruklt drop down fra ddlvehiclestatus fra frmvehicledetails--%>
                            <div class="six wide field">
                            <select id="ddlItemCategory" size="13" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>Varegruppe</label>
                                    <input type="text" id="txtbxNewItemCategory" />
                                </div>
                                <div class="field">
                                    <label>Beskrivelse</label>
                                    <input type="text" id="txtbxNewItemCategoryDescription" />
                                </div>
                                 

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnItemCategoryNew" class="ui btn wide" value="Ny" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnItemCategorySave" class="ui btn wide" value="Lagre" />
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        
       
        <div class="actions">
            <div class="ui approve success button" id="btnItemCategorySet">Sett til kode</div>
          
            <div class="ui cancel button" id="btnItemCategoryCancexl">Avbryt</div>
        </div>
    </div>


    <div class="ui tiny modal" id="modCrosslist">
        <div class="header"  style=" text-align:center ">Header</div>
        <div class="content">

             <div class="ui form">
                <div class="field">
                    <label class="sr-only">Crossliste</label>
                    <div class="ui small info message">
                        <p id="P2" runat="server">Crossliste</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <%--har bruklt drop down fra ddlvehiclestatus fra frmvehicledetails--%>
                            <select id="drpAdvSpareStructure" runat="server" size="5" class="wide dropdownList">
                                <option>Tecdoc - spare name - Spare desc - Text - Quantity - Amount</option>
                            </select>

                        </div>


                    </div>
                </div>
            </div>
        </div>
       
        <div class="actions">
            <div class="ui approve success button" id="btnCrosslistSave">Approve</div>
          
            <div class="ui cancel button" id="btnCrosslistCancel">Cancel</div>
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
                            <asp:TextBox ID="txtGeneralNote" TextMode="MultiLine" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
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

    <%-- Stock Adjustments Modal --%>
    <div id="modStockAdjustments" class="modal hidden">
        <div class="modHeader">
            <h2 id="H8" runat="server"></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only">Stock Adjustments</label>
                    <div class="ui small info message">
                        <p id="P1" runat="server">Stock Adjustments</p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">

                            <div class="tvelve wide field">
                                <div class="two fields">
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblStockAdjOldQty" Text="Gammel beholdning" runat="server" ></asp:Label></label>
                                        <asp:TextBox ID="txtStockAdjOldQty" runat="server" Enabled="false"  CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                    <div class="field">
                                        <div class="field">
                                            <label>
                                                <asp:Label ID="lblStockAdjSignature" Text="Signatur" runat="server"></asp:Label></label>
                                            <asp:TextBox ID="txtStockAdjSignature" runat="server" Enabled="false" CssClass="CarsBoxes"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="two fields">
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblStockAdjNewQty" Text="Ny beholdning" runat="server" ></asp:Label></label>
                                        <asp:TextBox ID="txtStockAdjNewQty" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                    <div class="field">
                                        <label>
                                            <asp:Label ID="lblStockAdjChangedQty" Text="Endring" runat="server" ></asp:Label></label>
                                        <asp:TextBox ID="txtStockAdjChangedQty" runat="server" Enabled="false"  CssClass="CarsBoxes"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblStockAdjComment" Text="Kommentar" runat="server" ></asp:Label></label>
                                    <asp:TextBox ID="txtStockAdjComment" runat="server"  CssClass="CarsBoxes"></asp:TextBox>
                                </div>

                                <div class="field">
                                    &nbsp;
                                </div>
                                <div class="field">
                                    <asp:CheckBox ID="cbStockAdjPrintReport" runat="server" Text="Utskrift av beh. endring" CssClass="" />
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnStockAdjSave" runat="server" class="ui btn wide" value="Lagre" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnStockAdjCancel" runat="server" class="ui btn wide" value="Avbryt" />
                            </div>
                        </div>



                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Parameters Modal --%>
    <div class="ui tiny modal" id="modal_parameters">
        <div class="header"  style=" text-align:center ">Header</div>                                         
        <div class="content">

            <div class="field">
                <div class="ui checkbox">                  
                    <asp:CheckBox ID="cbInfoStockControl" runat="server" Width="200%" Text="Stock quantity control" data-submit="FLG_STOCKITEM"  />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                    <asp:CheckBox ID="cbInfoDeadStock" runat="server" Width="200%" Text="Dead stock" data-submit="FLG_OBSOLETE_SPARE" />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                    <asp:CheckBox ID="cbInfoSaveToNonstock" runat="server" Width="200%" Text="Reg. på non-stock" data-submit="FLG_SAVE_TO_NONSTOCK"  />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                     <asp:CheckBox ID="cbInfoEtiquette" runat="server" Width="200%" Text="Etiquette" data-submit="FLG_LABELS" />
                </div>
            </div>
           
            
            <div class="field">
                <div class="ui checkbox">
                   <asp:CheckBox ID="cbInfoVatIncluded" runat="server" Width="200%" Text="Vat included" data-submit="FLG_VAT_INCL"  />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                    <asp:CheckBox ID="cbInfoAutoPurchase" runat="server" Width="200%" Text="Auto. purchase" data-submit="FLG_BLOCK_AUTO_ORD" />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                   <asp:CheckBox ID="cbInfoDiscountLegal" runat="server" Width="200%" Text="Discount legal" data-submit="FLG_ALLOW_DISCOUNT"/>
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                    <asp:CheckBox ID="cbInfoAutoArrival" runat="server" Width="200%" Text="Auto. arrival" data-submit="FLG_AUTO_ARRIVAL" />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                     <asp:CheckBox ID="cbInfoObtainSpare" runat="server" Width="200%" Text="Skaffevare" data-submit="FLG_OBTAIN_SPARE" />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                     <asp:CheckBox ID="cbInfoAutoPriceAdjustment" runat="server" Width="200%" Text="Price adjustment" data-submit="FLG_AUTOADJUST_PRICE" />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                     <asp:CheckBox ID="cbInfoAllowPurchaseReplacments" runat="server" Width="200%" Text="Allow purchase of replacements" data-submit="FLG_REPLACEMENT_PURCHASE" />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                     <asp:CheckBox ID="CheckBox2" runat="server" Width="200%" Text="Price adjustment" data-submit="FLG_AUTOADJUST_PRICE"  />
                </div>
            </div>
            <div class="field">
                <div class="ui checkbox">
                     <asp:CheckBox ID="cbInfoNotEnvFee" runat="server" Width="200%" Text="Ikke miljøavgift" data-submit="FLG_EFD"  />
                </div>
            </div>
            <div class="field">
                <asp:Literal ID="liInfoDiscountPercentage" Text="Discount %" runat="server"></asp:Literal>
                <asp:TextBox ID="txtInfoDiscountPercentage" runat="server" data-submit="DISCOUNT" CssClass="CarsBoxes"></asp:TextBox>
            </div>
        </div>
        <div class="actions">
            <div class="ui approve success button">Approve</div>
            <div class="ui button">Neutral</div>
            <div class="ui cancel button">Cancel</div>
        </div>
    </div>

         <div class="ui tiny modal" id="modal_invoicePreferences">
        <div class="header"  style=" text-align:center ">Header</div>
        <div class="content">
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvCustIgnoreInv" runat="server" Text="No Invoice Fee" data-submit="FLG_CUST_IGNOREINV"  />
            </div>

            </div>
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvBankgiro" runat="server" Text="Bankgiro"  />
            </div>
                </div>
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvCustFactoring" runat="server" Text="Factoring" data-submit="FLG_CUST_FACTORING" />
            </div>
                </div>
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvCustBatchInv" runat="server" Text="Batch Invoicing" data-submit="FLG_CUST_BATCHINV"  />
            </div>
                </div>
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvHourlyMarkup" runat="server" Text="Hourly Markup" data-submit="FLG_HOURLY_MARKUP"  />
            </div>
                </div>
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvNoGm" runat="server" Text="No Garage Material" data-submit="FLG_NO_GM" />
            </div>
                </div>
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvCustInactive" runat="server" Text="Inactive" data-submit="FLG_CUST_INACTIVE"  />
            </div>
                </div>
            <div class="fields">
            <div class="ui checkbox">
                <asp:CheckBox ID="chkAdvNoEnv" runat="server" Text="No Env. Fee" data-submit="FLG_NO_ENV_FEE" />
            </div>
                </div>
        </div>
        <div class="actions">
            <div class="ui approve success button">Godkjenn</div>
            
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
                                <asp:Label ID="Label1" Text="Søk etter kunde (Tlf, navn, sted, etc.)" runat="server" ></asp:Label>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <asp:TextBox ID="txtEniro" runat="server" CssClass="CarsBoxes"></asp:TextBox>
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







</asp:Content>

