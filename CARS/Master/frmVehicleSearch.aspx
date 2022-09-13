<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmVehicleSearch.aspx.vb" Inherits="CARS.frmVehicleSearch" %>

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
                    if (currentSearch == 'mvSearch') {
                        fetchVehicle($('#mvSearch').val());
                    }

                }, 200);
            });
            

            $("#VehicleSearch-table").tabulator({
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

                    var selectedRows = $("#VehicleSearch-table").tabulator("getSelectedRows");
                    if (selectedRows.length !== 0) {
                        if (row.getData().IntNo == selectedRows[0].getData().IntNo) {
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
                    var selectedRows = $("#VehicleSearch-table").tabulator("getSelectedRows");
                    row = selectedRows[0];
                    console.log(row);
                    //checks if its a confirmed order and only to show the last tab in modal or if its not confirmed yet.
                    var refNo = row.getCell("IntNo").getValue();
                    var regNo = row.getCell("VehRegNo").getValue();
                    window.parent.window.location.assign("../Master/frmVehicleDetail.aspx?refno=" + refNo + "&regno=" + regNo);

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

                        title: "Refnr", field: "IntNo", align: "center", headerFilter: "input", headerClick: function (e, column) {
                            //e - the click event object
                            //column - column component

                        },
                    },
                    { title: "Regnr.", field: "VehRegNo", align: "center", headerFilter: "input" },
                    { title: "Chassisnr", field: "VehVin", align: "center", headerFilter: "input" },
                    { title: "Merke", field: "Make", align: "center", headerFilter: "input" },
                    { title: "Modell", field: "VehType", align: "center", headerFilter: "input" },
                    { title: "Eier", field: "CustomerName", align: "center", headerFilter: "input" },
                    

                ],
                footerElement: $("<div class='tabulator-footer'><button class='ui big icon button'><i class='globe icon'></i></button></div>")[0]
              
            });

            function fetchVehicle(s) {
                var pageSize = document.getElementById('<%=hdnPageSize.ClientID%>').value;

                $("#VehicleSearch-table").tabulator("setData", "frmVehicleSearch.aspx/Vehicle_Search", { 'q': s});
                $("#VehicleSearch-table").tabulator("redraw", true);   
          }

          
            fetchVehicle("%");
        });
     

    </script>

   <asp:HiddenField ID="hdnPageSize" runat="server"  Value="5"/>
    <div class="ui grid content-width">

        <div class="sixteen wide column">
            
            <div id="idVehicle">
                <div class="ui form">
                   <div class="field">
                        <label class="sr-only">Kjøretøysøk</label>
                        Søk etter regnr, internnr, chassisnr, kundenummer, etc.
                                                <input id="mvSearch" type="text" placeholder="Regnr, Internnr, Chassisnr, Kundenummer, Kundenavn, etc." autocomplete="off" />
                    </div>
                </div>
                <div style="overflow:auto">
                    <div id="VehicleSearch-table" class="mytabulatorclass">
                  </div>
                     <div id="pagerVehicle"></div>
                </div>
                 <div style="padding:0.5em"></div>
                <div class="ui grid">
                    <div class="one wide column">
                        <div class="ui form">
                        </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui form">
                            <asp:RadioButtonList ID="sortVehicles" runat="server">
                                <asp:ListItem Text="Kjøretøy på lager" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Nye på lager" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Brukte på lager" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                    <div class="five wide column">
                        <asp:CheckBoxList ID="vehicleTypes" runat="server">
                            <asp:ListItem Text="Nye kjøretøy" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Brukte biler" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Brukte maskiner" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Leiebiler på lager" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Kjøretøy ventet inn" Value="4"></asp:ListItem>
                        </asp:CheckBoxList>
                    </div>

                    <div class="five wide column">
                        <div class="ui form">
                            <asp:Button ID="all" runat="server" Text="Alle" CssClass="ui btn" TabIndex="11" /><br />
                            <asp:Button ID="empty" runat="server" Text="Tøm" CssClass="ui btn" TabIndex="11" /><br />
                            <asp:Button ID="standard" runat="server" Text="Standard" CssClass="ui btn" TabIndex="11" />
                            <asp:CheckBox ID="chkAddOn" Text="Add-on" runat="server" TabIndex="0" CssClass="sr-only"></asp:CheckBox><br />
                        </div>
                    </div>
                </div>
            </div>
            

        </div>

    </div>
</asp:Content>


