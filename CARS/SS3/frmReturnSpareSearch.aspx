<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmReturnSpareSearch.aspx.vb" Inherits="CARS.frmReturnSpareSearch" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style type="text/css">
        .statusBar a:first-child {
            display: none;
        }

        .ui.grid > * {
            padding-left: 0rem;
            padding-right: 0rem;
        }

        .gridView .dxgvDataRow_Office2010Blue {
            height: 25px;
            font-size: small;
        }
    </style>
    <script type="text/javascript">

        function OngvRetSprListRowDblClick(s, e) {
            var visibleIndex = e.visibleIndex;
            popupRetSprDtl.Show();
            cbRetSprDtl.PerformCallback(s.GetRowKey(visibleIndex));
        }
        function autoCompleteReturnCode(s, e) {
            console.log(e);
            var leaveCodeMatchFound = true;
            $(s.GetInputElement()).autocomplete({
                selectFirst: true,
                autoFocus: true,
                minLength: 0,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmReturnSpareSearch.aspx/AutofillReturnCode",
                        data: "{q:'" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            console.log();
                            if (data.d.length === 0) {
                                response([{ label: '<%=GetLocalResourceObject("ErrUnableToFindRec")%>', value: '0', val: 'new' }]);
                                leaveCodeMatchFound = false;
                            } else
                                response($.map(data.d, function (item) {
                                    leaveCodeMatchFound = true;
                                    return {
                                        label: item.ReturnCode + " - " + item.ReturnCodeDesc,
                                        val: item.ReturnCode + "-" + item.ReturnCodeDesc ,
                                        value: item.ReturnCode
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
                    if (i.item.val != 'new') {
                        var result = i.item.value;
                        //console.log(result);
                        if (result != '0') {
                            s.SetValue(result);
                            console.log("===>"+ gvRetSprDtl.batchEditApi.HasChanges());
                            gvRetSprDtl.UpdateEdit();
                        }
                        else {
                            s.SetValue('');
                        }
                    }
                    else {
                        alert('<%=GetLocalResourceObject("ErrFailedToFetchCode")%>');
                        s.SetValue('');
                        gvRetSprDtl.UpdateEdit();
                    }
                }
            });
        }
        function OngvRetSprListEndCallback(s, e) {
            console.log(gvRetSprDtl.cpIsRetCodeUpd);
            if (gvRetSprDtl.cpIsRetCodeUpd != undefined) {
                if (gvRetSprDtl.cpIsRetCodeUpd == true) {
                    systemMSG('success', '<%=GetLocalResourceObject("GenRetCodeSaved")%>', 5000);
                }
                else {
                    systemMSG('error', '<%=GetLocalResourceObject("ErrRetCodeSaveFail")%>', 5000);
                }
            }
            
            
        }

        function OngvRetSprListBatchEditRowValidating(s, e) {
            var grid = ASPxClientGridView.Cast(s);
            var bestiltCellInfo = e.validationInfo[grid.GetColumnByField("RETURN_CODE").index];
           
            if (bestiltCellInfo.value != null) {                 
                if (bestiltCellInfo.value < 0) {
                    bestiltCellInfo.isValid = false;
                    bestiltCellInfo.errorText = "Cannot have negative value";
                }
                if (isNaN(bestiltCellInfo.value)) {
                    bestiltCellInfo.isValid = false;
                    bestiltCellInfo.errorText = "Numeric values only";
                }
            }
        }
        function popupRetSprDtlClosing(s, e) {
            gvRetSprDtl.CancelEdit();
            $("#<%=cbxIsCredited.ClientID%>").attr('checked', false);
            cbRetSprHrd.PerformCallback();
        }
        function IsCreditedClick() {
            var culture = '<%= System.Configuration.ConfigurationManager.AppSettings("Culture") %>';
            var todDate = new Date();
            var isCredited = $("#<%=cbxIsCredited.ClientID%>").is(':checked');
            var strDate = GetFormattedDate(todDate, culture);
            var annotation = $("#<%=txtAnnotation.ClientID%>").val();
            
            if (isCredited) {
                UpdateReturnOrder(true, annotation);
                $("#<%=txtDtCredited.ClientID%>").val(strDate);
            }
            else {
                $("#<%=txtDtCredited.ClientID%>").val("");
            }
        }
        function GetFormattedDate(date, culture) {
            var strDate = '';
            if (culture.toUpperCase() == 'NB-NO') {
                strDate = ('0' + date.getDate()).slice(-2) + "." + ('0' + (date.getMonth() + 1)).slice(-2) + "." + date.getFullYear();
                
            }
            else if (culture.toUpperCase() == 'EN-US') {
                strDate = date.toLocaleDateString();
            }
            else {
                strDate = todDate.toLocaleDateString();
            }
            return strDate;
            
        }
        function UpdateReturnOrder(isCredited, annotation) {

            var ReturnNo = $("#<%=txtReturnNum.ClientID%>").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmReturnSpareSearch.aspx/UpdateReturnOrders",
                data: "{isCredited:'" + isCredited + "',ReturnNo:'" + ReturnNo + "',Annotation:'" + annotation + "'}",
                dataType: "json",
                success: function (data) {
                    console.log(data.d);
                    if (data.d == "UPDATED") {
                        swal('<%=GetLocalResourceObject("GenUpRetOdr")%>');
                        cbRetSprDtl.PerformCallback(ReturnNo);
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error" + error);
                    var err = eval("(" + xhr.responseText + ")");
                    alert('Error: ' + err.Message);
                }

            });
        }
        function OntxtAnnotationBlur() {
            var annotation = $("#<%=txtAnnotation.ClientID%>").val();
            console.log(annotation);
            if (annotation != null) {
                UpdateReturnOrder(false, annotation);
            }
        }
        function HentPrisClick() {
            var isSaveSuccess = true;
            var ReturnNo = $("#<%=txtReturnNum.ClientID%>").val();
            var rowcount = gvRetSprDtl.GetVisibleRowsOnPage();
            var suppCurrNo = $("#<%=txtRetSupplier.ClientID%>").val();
            if (rowcount <= 0) {
                return;
            }
            for (var i = 0; i < rowcount; i++) {
                var spIdItem = gvRetSprDtl.batchEditApi.GetCellValue(i, "ID_ITEM");
                //console.log(gvRetSprDtl.GetRowKey(i));
                var idItemRetNo = gvRetSprDtl.GetRowKey(i);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmReturnSpareSearch.aspx/GetSparePrice",
                    data: "{'spIdItem':'" + spIdItem + "',suppCurrNo:'" + suppCurrNo + "',idItemRetNo:'" + idItemRetNo + "',returnNo:'" + ReturnNo +"'}",
                    dataType: "json",
                    async: false,       //Very important
                    success: function (Result) {
                        if (Result.d != null) {
                            if (!Result.d.navnLev.includes("FEIL")) {
                                isSaveSuccess = Result.d.isValid;
                            }
                            else {
                                console.log(Result.d.navnLev + " " + Result.d.spareID);
                            }
                        }
                    },
                    error: function (result) {
                        isSaveSuccess = false;
                        LoadingPanel.Hide();
                        alert("Error");
                    }
                });
            }
            


            if(isSaveSuccess) {
                swal('<%=GetLocalResourceObject("GenSprPriceUpd")%>');
            }
                else {
                swal('<%=GetLocalResourceObject("ErrSprPriceUpdFail")%>');
            }
            cbRetSprDtl.PerformCallback(ReturnNo);
        }
        function OncbRetSprDtlEndCallback(s, e) {
            var ReturnDate = $("#<%=txtDateRetToSup.ClientID%>").val();
            var CreditedDate = $("#<%=txtDtCredited.ClientID%>").val();

            if (ReturnDate.trim() != "") {
                $('#btnHentPris').prop('disabled', true);
            }
            else {
                $('#btnHentPris').prop('disabled', false);
            }

            if (CreditedDate.trim() != "") {
                $('#btnPrintRetSpr').prop('disabled', true);
            }
            else {
                $('#btnPrintRetSpr').prop('disabled', false);
            }
            
        }
        function OnEndCallbackcbOpenReport(s, e) {
            //var ReturnNo = $("#<%=txtReturnNum.ClientID%>").val();
            popupReport.ShowWindow(popupReport.GetWindow(0));
            //cbRetSprDtl.PerformCallback(ReturnNo);
        }
        function PrintReportClick() {
            var ReturnNo = $("#<%=txtReturnNum.ClientID%>").val();
            cbPanel.PerformCallback(ReturnNo);
        }
        function popupReportClosing() {
            var ReturnNo = $("#<%=txtReturnNum.ClientID%>").val();
            cbRetSprDtl.PerformCallback(ReturnNo);
        }



    </script>
    <div class="sixteen wide column">
        <div id="divRetSprList" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
            <dx:ASPxCallbackPanel ID="cbRetSprHrd" runat="server" ClientInstanceName="cbRetSprHrd" OnCallback="cbRetSprHrd_Callback">
                <PanelCollection>
                    <dx:PanelContent>

                        <dx:ASPxGridView ID="gvRetSprList" ClientInstanceName="gvRetSprList" CssClass="gridView" KeyFieldName="ID_RETURN_NUM" Width="100%" runat="server" Style="-moz-border-radius: 12px; border-radius: 12px;" Theme="Office2010Blue" AutoGenerateColumns="False" meta:resourcekey="gvRetSprListResource1">

                            <ClientSideEvents RowDblClick="OngvRetSprListRowDblClick" EndCallback="OngvRetSprListEndCallback" />
                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="True" />
                            <SettingsDataSecurity AllowReadUnlistedFieldsFromClientApi="True" />
                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                            <Styles>
                                <FocusedRow BackColor="#d6eef2" ForeColor="Black"></FocusedRow>
                                <StatusBar CssClass="statusBar"></StatusBar>
                            </Styles>
                            <SettingsPager PageSize="10" ShowNumericButtons="true" ShowSeparators="false">
                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                            </SettingsPager>
                            <Settings ShowPreview="false" ShowStatusBar="Hidden" />
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="ID_RETURN_NUM" SortOrder="Descending" Caption="Returnr." ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataTextColumnResource1"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SUPPLIER_NO" Caption="Leverandør" ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataTextColumnResource2"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="DT_RETURNED" Caption="Returnert dato" ReadOnly="true" Width="30%" meta:resourcekey="GridViewDataDateColumnResource1"></dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="DT_CREDITED" Caption="Kreditert dato" ReadOnly="true" Width="30%" meta:resourcekey="GridViewDataDateColumnResource2"></dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="WONUM" Caption="Ordre nr." ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataTextColumnResource3"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="RETURN_STATUS" Caption="Status" ReadOnly="true" Width="10%" meta:resourcekey="GridViewDataTextColumnResource4"></dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
            

        </div>
    </div>

    <div>
        <dx:ASPxPopupControl ID="popupRetSprDtl" ClientInstanceName="popupRetSprDtl" runat="server" CssClass="gridView" ShowFooter="True" PopupHorizontalAlign="Center" Modal="True" HeaderText="RETUR AV VARER" PopupVerticalAlign="Middle" Top="120" Left="300" Width="1100px" Height="650px" CloseAction="CloseButton" Theme="Office365" AllowDragging="True" meta:resourcekey="popupRetSprDtlResource1">
            <ClientSideEvents Closing="popupRetSprDtlClosing" />
            <ContentCollection>
                <dx:PopupControlContentControl meta:resourcekey="PopupControlContentControlResource1">
                    <dx:ASPxCallbackPanel ID="cbRetSprDtl" ClientInstanceName="cbRetSprDtl" runat="server" OnCallback="cbRetSprDtl_Callback" meta:resourcekey="cbRetSprDtlResource1">
                        <ClientSideEvents EndCallback="OncbRetSprDtlEndCallback" />
                        <PanelCollection>
                            <dx:PanelContent runat="server" meta:resourcekey="PanelContentResource1">
                                <div class="ui stackable grid" style="padding-top: 10px; padding-bottom: 10px;">
                                    <div class="ui form">
                                        <div class="sixteen wide column">
                                        <div class="inline fields">
                                            <div class="one wide field"></div>
                                            <div class="four wide field">
                                                <dx:ASPxLabel ID="lblReturnNum" runat="server" Text="Returnr." Font-Size="Small" meta:resourcekey="lblReturnNumResource1"></dx:ASPxLabel>
                                                <asp:TextBox ID="txtReturnNum" runat="server" Enabled="false" Style="height: 100%" meta:resourcekey="txtReturnNumResource1"></asp:TextBox>
                                            </div>
                                            <div class="three wide field">
                                                <asp:TextBox ID="txtReturnDate" runat="server" Enabled="false" Style="height: 100%" meta:resourcekey="txtReturnDateResource1">
                                                </asp:TextBox>
                                            </div>
                                            <div class="two wide field">
                                                <dx:ASPxLabel ID="lblRetSupplier" runat="server" Text="Leverandør" Font-Size="Small" meta:resourcekey="lblRetSupplierResource1"></dx:ASPxLabel>
                                            </div>
                                            <div class="three wide field">
                                                <asp:TextBox ID="txtRetSupplier" runat="server" Enabled="false" Style="height: 100%" meta:resourcekey="txtRetSupplierResource1"></asp:TextBox>
                                            </div>
                                            <div class="five wide field">
                                                <dx:ASPxLabel ID="lblSupplierName" runat="server" Font-Bold="true" Font-Size="Small" meta:resourcekey="lblSupplierNameResource1"></dx:ASPxLabel>
                                            </div>
                                            <div class="one wide field">
                                                <dx:ASPxLabel ID="lblRetStatus" runat="server" Text="Status" Font-Size="Small" meta:resourcekey="lblRetStatusResource1"></dx:ASPxLabel>
                                            </div>
                                            <div class="three wide field">
                                                <asp:TextBox ID="txtRetStatus" runat="server" Enabled="false" Text="OPEN" Style="height: 100%" meta:resourcekey="txtRetStatusResource1" ></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="inline fields">
                                            <div class="one wide field"></div>
                                            <div class="four wide field">
                                                <dx:ASPxLabel ID="lblDateRetToSup" runat="server" Text="Retunert til leverendør dato" Font-Size="Small" meta:resourcekey="lblDateRetToSupResource1"></dx:ASPxLabel>
                                            </div>
                                            <div class="three wide field">
                                                <asp:TextBox ID="txtDateRetToSup" runat="server" Enabled="false" Style="height: 100%" meta:resourcekey="txtDateRetToSupResource1">
                                                </asp:TextBox>
                                            </div>
                                            <div class="two wide field">
                                                <div class="ui checkbox">
                                                    <input type="checkbox" id="cbxIsCredited" runat="server" onclick="IsCreditedClick()"/>
                                                    <label for="cbxIsCredited" style="font-size: small"><%=GetLocalResourceObject("GenCredited")%></label>
                                                &nbsp;</div>
                                            </div>
                                            <div class="three wide field">
                                                <asp:TextBox ID="txtDtCredited" runat="server" Enabled="false" Style="height: 100%" meta:resourcekey="txtDtCreditedResource1"></asp:TextBox>
                                            </div>
                                            <div class="two wide field">
                                                <dx:ASPxLabel ID="lblAnnotation" runat="server" Text="Annotation" Font-Size="Small" meta:resourcekey="lblAnnotationResource1"></dx:ASPxLabel>
                                            </div>
                                            <div class="seven wide field">
                                                <asp:TextBox ID="txtAnnotation" runat="server" Style="height: 100px" TextMode="MultiLine" onblur="OntxtAnnotationBlur()" meta:resourcekey="txtAnnotationResource1"></asp:TextBox>
                                            </div>
                                            
                                        </div>
                                            </div>
                                    </div>

                                    <div class="sixteen wide column">
                                        <div id="divRetSprDtlList" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <dx:ASPxGridView ID="gvRetSprDtl" ClientInstanceName="gvRetSprDtl" Width="100%" runat="server" Theme="Office2010Blue" KeyFieldName="ID_ITEM_DETAILS_RETURN" OnBatchUpdate="gvRetSprDtl_BatchUpdate" Settings-ShowPreview="false" Settings-ShowStatusBar="Hidden" meta:resourcekey="gvRetSprDtlResource1">
                                                <ClientSideEvents BatchEditRowValidating="OngvRetSprListBatchEditRowValidating" />

                                                <Settings ShowStatusBar="Hidden"></Settings>

                                                <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowSort="false" AllowHeaderFilter="false" />
                                                <SettingsEditing Mode="Batch" />
                                                <Styles>
                                                    <StatusBar CssClass="statusBar">
                                                    </StatusBar>
                                                    <FocusedRow BackColor="AliceBlue" ForeColor="Black"></FocusedRow>
                                                    <SelectedRow BackColor="#e1e6e6" ForeColor="Black"></SelectedRow>
                                                </Styles>
                                                <SettingsPager PageSize="10" ShowNumericButtons="true" ShowSeparators="false">
                                                    <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                                </SettingsPager>
                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                </SettingsPopup>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="ID_ITEM_DETAILS_RETURN" SortOrder="Descending" ReadOnly="true" Visible="false" meta:resourcekey="GridViewDataTextColumnResource5"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID_ITEM" Caption="Varenr." ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource6"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ITEM_DESC" Caption="Varenavn" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource7"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataDateColumn FieldName="DT_CREATED_DTL" Caption="Retur dato" ReadOnly="true" meta:resourcekey="GridViewDataDateColumnResource3"></dx:GridViewDataDateColumn>
                                                    <dx:GridViewDataTextColumn FieldName="QTY_RETURNED" Caption="Antall" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource8"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="WONUM" Caption="Ordrenr." ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource9"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SALE_PRICE" Caption="Salgspris" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource10"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="COST_PRICE" Caption="Kostpris" ReadOnly="true" meta:resourcekey="GridViewDataTextColumnResource11"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="RETURN_CODE" Caption="Kode" PropertiesTextEdit-ClientSideEvents-GotFocus="autoCompleteReturnCode" meta:resourcekey="GridViewDataTextColumnResource12">
                                                        <PropertiesTextEdit>
                                                            <ClientSideEvents GotFocus="autoCompleteReturnCode"></ClientSideEvents>
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridView>
                                        </div>
                                    </div>

                                    </div>
                            </dx:PanelContent>

                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                </dx:PopupControlContentControl>

            </ContentCollection>
            <FooterContentTemplate>
                <div class="ui form">
                    <div class="inline fields">
                        <div class="four wide field">
                            <input id="btnPrintRetSpr" class="ui button" value='<%=GetLocalResourceObject("btnPrintRetSprResource1.Value")%>' type="button" onclick="PrintReportClick()" meta:resourcekey="btnPrintRetSprResource1"/>
                        </div>
                        <div class="two wide field"></div>
                        <div class="four wide field">
                            <input id="btnHentPris" class="ui button" value='<%=GetLocalResourceObject("btnHentPrisResource1.Value")%>' type="button" onclick="HentPrisClick()" meta:resourcekey="btnHentPrisResource1"/>
                            <%--<asp:Button id="btnHentPris" runat="server" class="ui button" value="Hent Pris" type="button" onclick="HentPrisClick()" meta:resourcekey="btnHentPrisResource1"></asp:Button>--%>
                        </div>
                        <div class="two wide field"></div>
                        <div class="four wide field">
                            <input id="btnCancel" runat="server" class="ui button" value="Cancel" type="button" onclick="popupRetSprDtl.Hide();" meta:resourcekey="btnCancelResource1"/>
                        &nbsp;</div>
                    </div>
                </div>
                <div class="ui stackable grid"></div>
            </FooterContentTemplate>
        </dx:ASPxPopupControl>
    </div>
    <div>
        <dx:ASPxCallbackPanel ID="cbPanel" ClientInstanceName="cbPanel" runat="server" OnCallback="cbPanel_Callback" ClientSideEvents-EndCallback="OnEndCallbackcbOpenReport" meta:resourcekey="cbPanelResource1">
            <ClientSideEvents EndCallback="OnEndCallbackcbOpenReport"></ClientSideEvents>
            <PanelCollection>
                <dx:PanelContent meta:resourcekey="PanelContentResource2">
                    <div>
                        <div>
                            <dx:ASPxPopupControl ID="popupReport" runat="server" ClientInstanceName="popupReport" AllowDragging="true" Modal="True" Theme="iOS" CloseAction="CloseButton" meta:resourcekey="popupReportResource1">
                                <ClientSideEvents Closing="popupReportClosing" />
                                <Windows>
                                    <dx:PopupWindow ContentUrl="ReportViewer_SS3.aspx" HeaderText="Report" Name="report"
                                        Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100" meta:resourcekey="PopupWindowResource1">
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server"></dx:PopupControlContentControl>
                                        </ContentCollection>
                                    </dx:PopupWindow>
                                </Windows>
                            </dx:ASPxPopupControl>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
</asp:Content>
