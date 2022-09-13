<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmCustomerSearch.aspx.vb" Inherits="CARS.frmCustomerSearch" %>

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
                    if (currentSearch == 'mcSearch') {

                        fetchCustomer($('#mcSearch').val());
                    }

                }, 200);
            });
            

            $('#chkPrivate, #chkCompany').change(function () {
                if (this.checked) {
                    $(this).prop("value", true);
                }
                else { $(this).prop("value", false); }

                fetchCustomer($('#mcSearch').val());

            });

         

            //Customer Click
            //jQuery("#grdCustomer").click(function (e) {
            //    var el = e.target;
            //    if (el.nodeName !== "TD") {
            //        el = $(el, this.rows).closest("td");
            //    }
            //    var iCol = $(el).index();
            //    var nCol = $(el).siblings().length;
            //    var row = $(el, this.rows).closest("tr.jqgrow");
            //    if (row.length > 0) {
            //        var rowId = row[0].id;
            //        var customerId = row[0].cells['1'].title;
            //        window.parent.window.location.assign("../Master/frmCustomerDetail.aspx?cust=" + customerId);
            //    }

            //});

            $("#CustomerSearch-table").tabulator({
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

                    var selectedRows = $("#CustomerSearch-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        if (row.getData().ID_CUSTOMER == selectedRows[0].getData().ID_CUSTOMER) {
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
                    var selectedRows = $("#CustomerSearch-table").tabulator("getSelectedRows");
                    row = selectedRows[0];
                    console.log(row);
                    //checks if its a confirmed order and only to show the last tab in modal or if its not confirmed yet.
                    var custNo = row.getCell("ID_CUSTOMER").getValue();
                    window.parent.window.location.assign("../Master/frmCustomerDetail.aspx?cust=" + custNo);

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

                        title: "Kundenr", field: "ID_CUSTOMER", align: "center", headerFilter: "input", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Navn.", field: "CUST_NAME", align: "center", headerFilter: "input" },
                    { title: "Adresse", field: "CUST_PERM_ADD1", align: "center", headerFilter: "input" },
                    { title: "Postnr", field: "ID_CUST_PERM_ZIPCODE", align: "center", headerFilter: "input" },
                    { title: "Sted", field: "CUST_PERM_CITY", align: "center", headerFilter: "input" },
                    { title: "Besøksadresse", field: "CUST_VISIT_ADDRESS", align: "center", headerFilter: "input" },
                    

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]
              
            });

            function fetchCustomer(s) {
                var isPrivate = "";
                var isCompany = "";
              if (s == "") {
                  s = "%";
              }
              if ($('#chkPrivate').is(":checked")) {
                  isPrivate = "True"
              }
              else {
                  isPrivate = "False"
              }
              if ($('#chkCompany').is(":checked")) {
                  isCompany = "True"
              }
              else {
                  isCompany = "False"
              }
             
            
              console.log("s= " + s + " - ispriv: " + isPrivate + " - iscom " + isCompany);
              var pageSize = document.getElementById('<%=hdnPageSize.ClientID%>').value;
              console.log("Running fetchCustomer");
            
             $("#CustomerSearch-table").tabulator("setData", "frmCustomerSearch.aspx/Customer_Search", { 'q': s, 'isPrivate': isPrivate, 'isCompany': isCompany });
             $("#CustomerSearch-table").tabulator("redraw", true);
           }
            fetchCustomer("%");
        });
     

    </script>

   <asp:HiddenField ID="hdnPageSize" runat="server"  Value="5"/>
    <div class="ui grid content-width">

        <div class="sixteen wide column">
            
            <div id="idCustomer">
                <div class="ui form">
                    <div class="field">
                        <label class="sr-only">Kjøretøysøk</label>
                        Søk etter Kundenr, navn, Telefonnr, Adresse, Kjøretøy, etc.
                                                <input id="mcSearch" type="text" placeholder="Kundenr, navn, Telefonnr, Adresse, Kjøretøy, etc." autocomplete="off"/>
                    </div>
                </div>
                <div style="overflow:auto">
                    <div id="CustomerSearch-table" class="mytabulatorclass">
                  </div>
                    <div id="pagerCustomer"></div>
                </div>
                 <div style="padding:0.5em"></div>
                <div class="ui grid">
                    <div class="one wide column">
                        <div class="ui form">
                        </div>
                    </div>
                    <div class="seven wide column">
                        <div class="ui form">
                            
                        </div>
                    </div>
                    <div class="three wide column">
                       <div class="ui form">
                          <div class="grouped fields">
                            <label>Outbound Throughput</label>
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkPrivate" checked="checked" name="public" />
                                <label>Privatkunder</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkCompany" checked="checked" name="public" />
                                <label>Firmakunder</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkProspect" name="public" />
                                <label>Prospekter</label>
                              </div>
                            </div>
                            <div class="field">
                              <div class="ui toggle checkbox">
                                <input type="checkbox" id="chkInvAdr" name="public" />
                                <label>Vis fakt adr.</label>
                              </div>
                            </div>
                          </div>
                        </div>
                    </div>

                    <div class="five wide column">
                        <div class="ui form">
                            <asp:Button ID="Button1" runat="server" Text="Alle" CssClass="ui btn" TabIndex="11" /><br />
                            <asp:Button ID="Button2" runat="server" Text="Tøm" CssClass="ui btn" TabIndex="11" /><br />
                            <asp:Button ID="Button3" runat="server" Text="Standard" CssClass="ui btn" TabIndex="11" />
                            <asp:CheckBox ID="CheckBox2" Text="Add-on" runat="server" TabIndex="0" CssClass="sr-only"></asp:CheckBox><br />
                        </div>
                    </div>
                </div>
            </div>
            

        </div>

    </div>
</asp:Content>

