<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmStockValue.aspx.vb" Inherits="CARS.frmStockValue" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <script type="text/javascript">
        var priceType = 1;
        var warehouseID = '';
        var departmentID = '';
        $(document).ready(function () {
            loadInit();

            function loadInit() {
                getDepartmentID();
                getWarehouseID();
            }
            
            $("#<%=chkAveragePrice.ClientID%>").on('click', function (e) {
              
                if ($("#<%=chkAveragePrice.ClientID%>").is(':checked')) {
                   
                    $("#<%=chkAveragePrice.ClientID%>").prop('checked', true);
                    $("#<%=chkCostPrice.ClientID%>").prop('checked', false);
                  
                    priceType = 1;
                }
                else {
                   
                    $("#<%=chkAveragePrice.ClientID%>").prop('checked', false);
                    priceType = 0;
                }
            });
            $("#<%=chkCostPrice.ClientID%>").on('click', function (e) {

                if ($("#<%=chkCostPrice.ClientID%>").is(':checked')) {
                    $("#<%=chkCostPrice.ClientID%>").prop('checked', true);
                    $("#<%=chkAveragePrice.ClientID%>").prop('checked', false);
                 
                    priceType = 2;
                }
                else {
                    $("#<%=chkCostPrice.ClientID%>").prop('checked', false);
                    priceType = 0;
                    
                }
            });
          

            $("#<%=btnPrintStockValue.ClientID%>").on('click', function (e) {
                
                if (priceType == 0) {
                    alert("Du må velge en pristype før du skriver ut!")
                }
                else {
                    getStockValueReport(priceType)
                }
               
             });
          
            //--------------END OF DOCUMENT READY-----------------------------------
        });

        function getDepartmentID() {
            console.log("getdepid inside");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmStockValue.aspx/FetchCurrentDepartment",
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

        function getWarehouseID() {
            //console.log("inside getware");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmStockValue.aspx/LoadWarehouseDetails",
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


        function getStockValueReport(priceTypeValue) {
           
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmStockValue.aspx/FetchCountingReport",
                data: "{'priceTypeValue':'" + priceTypeValue + "', 'wh':'" + warehouseID + "'}",
                dataType: "json",
                async: false,//Very important. If not, then succeeded will not be set, because it will make an asynchronous call
                success: function (data) {

                    console.log("success");
                    //_loginName = data.d;
                    cbStockValue.PerformCallback();


                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                    systemMSG('error', 'Finner ikke bruker. Logg ut og så prøv på nytt!', 5000);
                }
            });


        }
        function OnStockValueEndCallBack() {
            popupStockValueReport.ShowWindow(popupStockValueReport.GetWindow(0));
        }

    </script>

    <div class="ui form stackable two column grid ">
        <div class="eight wide column">
            <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                <h3 id="lblRepPackageSearch" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Lagerverdi parametere</h3>
                
                    <div class="fields">
                        <div class="sixteen wide field">
                            <h3>Velg pristype som ønskes som grunnlag for beregningene:</h3>
                            <div class="ui toggle checkbox">
                                <input id="chkAveragePrice" runat="server" type="checkbox" checked="checked" name="public" />
                                <label>Snittpris</label>
                            </div>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="sixteen wide field">
                            <div class="ui toggle checkbox">
                                <input id="chkCostPrice" runat="server" type="checkbox" name="public" />
                                <label>Kostpris</label>
                            </div>
                        </div>
                    </div>
                   


                    <div class="fields">
                        <div class="eight wide field">
                            <input type="button" id="btnPrintStockValue" runat="server" value="Skriv ut" class="ui btn CarsBoxes" />
                           

                        </div>
                        <div class="eight wide field">
                            
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

    <dx:ASPxCallbackPanel ID="cbStockValue" ClientInstanceName="cbStockValue" runat="server" OnCallback="cbStockValue_Callback" ClientSideEvents-EndCallback="OnStockValueEndCallBack">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <dx:ASPxPopupControl ID="popupStockValueReport" runat="server" ClientInstanceName="popupStockValueReport" AllowDragging="true" Modal="True" Theme="iOS" CloseAction="CloseButton">
                        <Windows>
                            <dx:PopupWindow ContentUrl="../SS3/ReportViewer_SS3.aspx" HeaderText="Stock Value" Name="report"
                                                Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                            </dx:PopupWindow>
                        </Windows>
                    </dx:ASPxPopupControl>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

</asp:Content>
