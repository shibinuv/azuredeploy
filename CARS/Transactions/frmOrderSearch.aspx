<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmOrderSearch.aspx.vb" Inherits="CARS.frmOrderSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="Server">
    <style>
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
.ui-dialog .ui-dialog-titlebar button.ui-button.ui-state-hover  {
    outline:none;
}

.ui-dialog .ui-dialog-content{
    overflow:hidden;
}

 </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var fn;
            $('#moSearch, #mcSearch, #mvSearch, #msSearch, #txtLocation, #txtSupplier').on('keyup', function () {
                console.log('Called keyup for: ' + $(this).prop('id'));
                console.log($(this).attr("id"));
                var currentSearch = $(this).attr("id");
                if (fn) {
                    clearTimeout(fn);
                }
                fn = setTimeout(function () {
                    console.log(currentSearch == 'moSearch');
                    if (currentSearch == 'moSearch' && $('#moSearch').val().length > 2) {
                        fetchOrder($('#moSearch').val());
                    }

                }, 200);
            });
            

            $("#OrderSearch-table").tabulator({
                height: 510, // set height of table, this enables the Virtual DOM And improves render speed dramatically (can be any valid css height value)
                //minWidth: 20,
                movableColumns: true, //enable user movable rows
                layout: "fitColumns", //fit columns to width of table (optional) 
                responsiveLayout: true,
                selectable: 1,     //true means we can select a row. 1 means one row Is selectable, 2 means 2 etc...
                placeholder: "No Data Available", //display message to user on empty table
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string
                pagination: "local",
                paginationSize: 30,
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

                    var selectedRows = $("#OrderSearch-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        if (row.getData().ORDNO == selectedRows[0].getData().ORDNO) {
                            return false;
                        }
                    }


                    return true; //alow selection of rows where the age is greater than 18
                },
                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    //openModalTPInfo(); //opens modal and shows information about the items on this order
                    //gets the selected row
                    var selectedRows = $("#OrderSearch-table").tabulator("getSelectedRows");
                    row = selectedRows[0];
                    console.log(row);
                  
                    var woNo = row.getCell("WOSeries").getValue();
                    var woPr = row.getCell("PREFIX").getValue();
                    var mode = 'Edit';
                    var flag = encodeURIComponent('Ser');

                    woNo = encodeURIComponent(woNo);
                    // var uri = '../Transactions/frmWOHead.aspx?Wonumber=' + encodeURIComponent(woNo) + "&WOPrefix=" + encodeURIComponent(woPr) + "&Mode=" + encodeURIComponent(mode) + "&TabId=" + 2 + "&Flag=" + encodeURIComponent(flag) + "&blWOsearch=true";
                    //window.location.replace("../Transactions/frmWOHead.aspx?Wonumber=" + woNo + "&WOPrefix=" + woPr + "&Mode=" + mode + "&TabId=" + 2 + "&Flag=" + flag + "&blWOsearch=" + true);
                    window.parent.window.location.assign("../Transactions/frmWOJobDetails.aspx?Wonumber=" + woNo + "&WOPrefix=" + woPr + "&Mode=" + mode + "&TabId=" + 2 + "&Flag=" + flag + "&blWOsearch=" + true);

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
                       
                        title: "Ordrenr", field: "ORDNO", align: "center", headerFilter: "input", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Kundenr.", field: "IDCUSTOMER", align: "center", headerFilter: "input" },
                    { title: "Navn", field: "CUSTOMER", align: "center", headerFilter: "input" },
                    { title: "Adresse", field: "CUSTADD1", align: "center", headerFilter: "input" },
                    { title: "Postnr", field: "CUSTZIP", align: "center", headerFilter: "input" },
                    { title: "Mobilnr", field: "CUSTPHONEMOBILE", align: "center", headerFilter: "input" },
                    { title: "Fakt.nr.", field: "InvNo", align: "center", headerFilter: "input" },
                    { title: "Fakt.dato", field: "InvDate", align: "center", headerFilter: "input" },
                    { title: "Refnr", field: "REFNO", align: "center", headerFilter: "input" },
                    { title: "Regnr", field: "REGNO", align: "center", headerFilter: "input" },
                    { title: "Prefiks", field: "PREFIX", visible: false, align: "center", headerFilter: "input" },
                    { title: "Ordre", field: "WOSeries", visible: false, align: "center", headerFilter: "input" },
                    { title: "Bettype", field: "PayType", visible: false, align: "center", headerFilter: "input" },
                    { title: "Ordretype", field: "OrderType", visible: false, align: "center", headerFilter: "input" },
                    { title: "Status", field: "STATUS", visible: false, align: "center", headerFilter: "input" },
                    { title: "Ordrestatus", field: "OrderStatus", visible: false, align: "center", headerFilter: "input" },
                    

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]
              
            });

            function fetchOrder(s) {
                var isBargain = "";
                var isOrder = "";
                var isCreditnote = "";
                var isOpenorder = "";
                var isReadyforinvoice = "";

              var pageSize = document.getElementById('<%=hdnPageSize.ClientID%>').value;
              if (s == "") {
                  s = "%";
              }
              if ($('#chkBargain').is(":checked")) {
                  isBargain = "True";
              }
              else {
                  isBargain = "False";
              }
              if ($('#chkOrder').is(":checked")) {
                  isOrder = "True";
              }
              else {
                  isOrder = "False";
              }
              if ($('#chkCredit').is(":checked")) {
                  isCreditnote = "True";
              }
              else {
                  isCreditnote = "False";
              }
            
           
              if ($('#chkOpenOrder').is(":checked")) {
                  isOpenorder = "True";
              }
              else {
                  isOpenorder = "False";
              }
              if ($('#chkReadyForInv').is(":checked")) {
                  isReadyforinvoice = "True";
              }
              else {
                  isReadyforinvoice = "False";
              }
            

              console.log("isbargain: " + isBargain + " isorder: " + isOrder + " iscreditnote: " + isCreditnote + " isopenorder: " + isOpenorder + " isreadyforinvoice " + isReadyforinvoice);

              // console.log("Running fetchOrders");
            
              $("#OrderSearch-table").tabulator("setData", "frmOrderSearch.aspx/Order_Search", { 'q': s, 'isBargain': isBargain, 'isOrder': isOrder, 'isCreditnote': isCreditnote, 'isOpenorder': isOpenorder, 'isReadyforinvoice': isReadyforinvoice });
              $("#OrderSearch-table").tabulator("redraw", true);
              
          }

            /* onclick for listitems(checkboxes) on order search popup*/
            $('#chkBargain, #chkOrder, #chkCredit, #chkOpenOrder, #chkReadyForInv').change(function () {
                if (this.checked) {
                    $(this).prop("value", true);
                }
                else { $(this).prop("value", false); }
                if ($('#moSearch').val() != "" && $('#moSearch').length > 2) {
                    fetchOrder($('#moSearch').val());
                }
                else { fetchOrder('%'); }
            });


            $(function () {
                $.contextMenu({
                    selector: '#OrderSearch-table',
                    callback: function (key, options) {
                        var m = "clicked: " + key;
                        window.console && console.log(m) || alert(m);
                    },
                    items: {
                        "edit": {
                            name: "Invoice",
                            callback: function (key, opt) {
                                var selectedRows = $("#OrderSearch-table").tabulator("getSelectedRows");
                                row = selectedRows[0];
                                var orderNo = row.getCell("WOSeries").getValue();
                                var orderPr = row.getCell("PREFIX").getValue();
                                var custId = row.getCell("IDCUSTOMER").getValue();
                                var invNo = row.getCell("InvNo").getValue();
                                var payType = row.getCell("PayType").getValue();
                                var orderType = row.getCell("OrderType").getValue();
                                var status = row.getCell("STATUS").getValue();
                                var flgBkOrd = "false";

                                if (status == "INV") {
                                    alert("Order is already Invoiced")
                                } else if (status != "RINV") {
                                    alert("Set the Ord status to RINV before Invoice.")
                                }
                                else if (status == "RINV") {
                                    invoiceOrder(orderNo, orderPr, custId, invNo, flgBkOrd, payType, orderType);
                                    fetchOrder($('#moSearch').val());
                                }
                            }
                        },
                        "Delete": {
                            name: "Delete",
                            callback: function (key, opt) {
                                DelOrder($(this)[0])
                                fetchOrder($('#moSearch').val())
                            }
                        },
                        "ViewPdf": {
                            name: "ViewPdf",
                            callback: function (key, opt) {
                                var selectedRows = $("#OrderSearch-table").tabulator("getSelectedRows");
                                row = selectedRows[0];
                                //console.log(row);
                                var orderNo = row.getCell("WOSeries").getValue();
                                var orderPr = row.getCell("PREFIX").getValue();
                                var custId = row.getCell("IDCUSTOMER").getValue();
                                var invNo = row.getCell("InvNo").getValue();
                                var payType = row.getCell("PayType").getValue();
                                if (invNo != "") {
                                    openPdf(orderNo, orderPr, custId, invNo);
                                }
                                else {
                                    alert("No invoice to view");
                                }
                            }
                        },
                        "CreateCreditNoteOrder": {
                            name: "CreateCreditNoteOrder",
                            callback: function (key, opt) {
                                var selectedRows = $("#OrderSearch-table").tabulator("getSelectedRows");
                                row = selectedRows[0];
                                //console.log(row);
                                var orderNo = row.getCell("WOSeries").getValue();
                                var orderPr = row.getCell("PREFIX").getValue();
                                var orderType = row.getCell("OrderType").getValue();
                                var status = row.getCell("STATUS").getValue();
                                if (orderType == "KRE" && status == "INV") {
                                    alert("Credit Note Order is already Invoiced");
                                } else if (orderType == "ORD" && status == "INV") {
                                    CreateCrediNoteOrders(orderNo, orderPr);
                                } else {
                                    alert("Order should be invoiced to create Credit Note Order");
                                }
                            }
                        },
                        "CopyWorkOrder": {
                            name: "CopyWorkOrder",
                            callback: function (key, opt) {
                                var selectedRows = $("#OrderSearch-table").tabulator("getSelectedRows");
                                row = selectedRows[0];
                                //console.log(row);
                                var orderNo = row.getCell("WOSeries").getValue();
                                var orderPr = row.getCell("PREFIX").getValue();
                                var status = row.getCell("STATUS").getValue();
                                CopyWorkOrder(orderNo, orderPr);
                            }
                        }
                    }
                });

                $('.context-menu-one').on('click', function (e) {
                    console.log('clicked', this);
                });
            });

            function CopyWorkOrder(orderNo, orderPr) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmOrderSearch.aspx/CopyWorkOrder",
                    data: "{woNo: '" + orderNo + "',woPr:'" + orderPr + "'}",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        if (Result.d.length > 0) {
                            strWONO = Result.d[0].ORDNO.toString();
                            strWOPrefix = Result.d[0].PREFIX.toString();
                            var mode = 'Edit';
                            var flag = encodeURIComponent('Ser');

                            strWONO = encodeURIComponent(strWONO);
                            window.parent.window.location.assign("../Transactions/frmWOJobDetails.aspx?Wonumber=" + strWONO + "&WOPrefix=" + strWOPrefix + "&Mode=" + mode + "&TabId=" + 2 + "&Flag=" + flag + "&blWOsearch=" + true);
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function CreateCrediNoteOrders(orderNo, orderPr) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmOrderSearch.aspx/CreateCreditNoteOrders",
                    data: "{woNo: '" + orderNo + "',woPr:'" + orderPr + "'}",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        if (Result.d.length > 0) {
                            strWONO = Result.d.toString();
                            alert(strWONO.toString() + " Credit Note Order Created");
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            }

            function openPdf(orderNo, orderPr, custId, invNo) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmOrderSearch.aspx/OpenPdf",
                    data: "{orderNo: '" + orderNo + "',orderPr:'" + orderPr + "',custId:'" + custId + "',invNo:'" + invNo + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        var result = data.d.split(',');
                        if (result[0] == "Err") {
                            alert(result[1]);
                        }
                        else {
                            var Url = result[1]; //"../Reports/frmShowReports.aspx?ReportHeader=YF8c/MYCthcdMZ0D0ra6EQ==&InvoiceType=YF8c/MYCthcdMZ0D0ra6EQ==&Rpt=GPwu6EpyNgg8JACPpv3cVA==&scrid=" + orderPr + orderNo + "&JobCardSett=1"
                            window.open(Url, 'Reports', "menubar=no,location=no,status=no,scrollbars=yes,resizable=yes");
                        }
                    }
                });
            }

            function invoiceOrder(orderNo, orderPr, custId, invNo, flgBkOrd, payType, orderType) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmOrderSearch.aspx/InvoiceOrder",
                    data: "{orderNo: '" + orderNo + "',orderPr:'" + orderPr + "',custId:'" + custId + "',invNo:'" + invNo + "',flgBkOrd:'" + flgBkOrd + "',payType:'" + payType + "',orderType:'" + orderType + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        var result = data.d.split(',');
                        if (result[0] == "Err") {
                            alert(result[1]);
                        }
                        else if (result[0] == "Confirm") {
                            var cf = confirm(result[1]);
                            if (cf) {
                                flgBkOrd = "true"
                                invoiceOrder(orderNo, orderPr, custId, invNo, flgBkOrd, payType, orderType)
                            }
                            else {
                                return false;
                            }
                        }
                        else {
                            var Url = result[1]; //"../Reports/frmShowReports.aspx?ReportHeader=YF8c/MYCthcdMZ0D0ra6EQ==&InvoiceType=YF8c/MYCthcdMZ0D0ra6EQ==&Rpt=GPwu6EpyNgg8JACPpv3cVA==&scrid=" + orderPr + orderNo + "&JobCardSett=1"
                            window.open(Url, 'Reports', "menubar=no,location=no,status=no,scrollbars=yes,resizable=yes");
                        }
                    }
                });
            }

            function DelOrder(grd) {
                var orderxml;
                var orderxmls = "";
                var woNum = grd.cells['11'].title;
                var woPr = grd.cells['10'].title;
                orderxml = '<WO><WONumber>' + woNum + '</WONumber><WOPrefix>' + woPr + '</WOPrefix></WO>'
                orderxml = "<ROOT>" + orderxml + "</ROOT>"
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmOrderSearch.aspx/DeleteOrd",
                    data: "{q: '" + orderxml + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (data) {
                        var msg = data.d[1] + data.d[2];
                        if (data.d[0] == "DEL") {
                            systemMSG('success', msg, 4000);
                        }
                        else if (data.d[0] == "NDEL") {
                            systemMSG('error', msg, 4000);
                        }
                    }
                });
            }

          

          
          fetchOrder("%");
        });
     

    </script>

   <asp:HiddenField ID="hdnPageSize" runat="server"  Value="5"/>
    <div class="ui grid content-width">

        <div class="sixteen wide column">
            
             <div id="idOrder">
                <div class="ui form">
                    <div class="field">
                         <label class="sr-only">Ordresøk</label>
                        Søk etter Ordrenr, navn, kjøretøy, etc.
                        <input id="moSearch" type="text" placeholder="Order search (ordernumber, customer number, vehicle registration, phone number...)" autocomplete="off"/>
                    </div>
                </div>
                <div style="overflow:auto">
                    <div id="OrderSearch-table" class="mytabulatorclass">
                  </div>
                     <div id="pagerOrd"></div>
                </div>
                 <div style="padding:0.5em"></div>
                <div class="ui grid">
                    <div class="one wide column">
                        <div class="ui form">
                        </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui form">
                            <div class="grouped fields">
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkOpenOrder" name="public" />
                                <label>Kun åpne ordre</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox disabled">
                                <input type="checkbox" id="chkSplit" name="public" />
                                <label>Vis splitt</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox disabled">
                                <input type="checkbox" id="chkReclaim" name="public" />
                                <label>Kun reklamasjoner</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkReadyForInv" name="public" />
                                <label>Kun klar for fakt.</label>
                              </div>
                            </div>
                                <div class="field">
                              <div class="ui toggle checkbox disabled">
                                <input type="checkbox" id="chkOnlySplit" name="public" />
                                <label>Kun Vis kun splitt</label>
                              </div>
                            </div>
                          </div>
                            
                        </div>
                    </div>
                    <div class="five wide column">
                       <div class="ui form">
                          <div class="grouped fields">
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkBargain" checked="checked" name="public" />
                                <label>Tilbud</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkOrder" checked="checked" name="public" />
                                <label>Faktura</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkCredit" checked="checked" name="public" />
                                <label>Kreditnota</label>
                              </div>
                            </div>
                            
                          </div>
                        </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui form">
                            <asp:Button ID="btnAll" runat="server" Text="Alle" CssClass="ui btn" TabIndex="11" /><br />
                            <asp:Button ID="btnSearch2" runat="server" Text="Tøm" CssClass="ui btn" TabIndex="11" /><br />
                            <asp:Button ID="btnEmpty" runat="server" Text="Standard" CssClass="ui btn" TabIndex="11" />
                            <asp:CheckBox ID="CheckBox1" Text="Add-on" runat="server" TabIndex="0" CssClass="sr-only"></asp:CheckBox><br />
                        </div>
                    </div>
                </div>
            </div>
            

        </div>

    </div>
</asp:Content>



