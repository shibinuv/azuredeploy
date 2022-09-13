<%@ Control Language="vb" AutoEventWireup="true" CodeBehind="AppointmentForm.ascx.vb" Inherits="CARS.AppointmentForm" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler.Controls" TagPrefix="dxsc" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<script id="dxss_popupCode" type="text/javascript">
    $(document).ready(function () {
        $('#<%=lst_veh.ClientID%>').hide();
        $('#<%=txtSrchVeh.ClientID%>').hide();

        $('#<%=lst_veh.ClientID%>').change(function (e) {

            $('#<%=lst_veh.ClientID%>').hide();
            //$('#<%=txtSrchVeh.ClientID%>').show();
            tbRegNo.SetClientVisible(true);
            var vehId = $('#<%=lst_veh.ClientID%>')[0].value;
            $('#<%=txtSrchVeh.ClientID%>').val(vehId);
            FillVehDet(vehId);
        });
        $('#<%=txtSrchVeh.ClientID%>').autocomplete({
            selectFirst: true,
            autoFocus: true,
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmWOHead.aspx/GetVehicle",
                    data: "{'vehicleRegNo':'" + $('#<%=txtSrchVeh.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0] + "-" + item.split('-')[1] + "-" + item.split('-')[2],
                                val: item.split('-')[0],
                                value: item.split('-')[0]
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

                $("#<%=txtSrchVeh.ClientID%>").val(i.item.value);
                FillVehDet($("#<%=txtSrchVeh.ClientID%>").val());
            }
        });

        function FillVehDet(VehicleId) {
            $.ajax({
                type: "POST",
                url: "frmWOHead.aspx/LoadVehDet",
                data: "{VehicleId: '" + VehicleId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    tbRegNo.SetText(data.d[0].WO_Veh_Reg_NO);
                    tbChNo.SetText(data.d[0].WO_Veh_Vin);
                    tbRefNo.SetText(data.d[0].Veh_Int_No);
                    //alert(data.d[0].Id_Make);
                    if (data.d[0].Id_Make == 0) {
                        <%--$('#<%=ddlMake.ClientID%>')[0].selectedIndex = 0;--%>
                    }
                    else {
                       <%-- $('#<%=ddlMake.ClientID%> option:contains("' + data.d[0].Id_Make + '")').attr('selected', 'selected');--%>
                        cbMake.SetText(data.d[0].Id_Make);
                    }
                    $('#<%=txtbxModel.ClientID%>').val(data.d[0].Veh_Type);
                    lblVehInfo.SetText(data.d[0].VehColor + " " + data.d[0].WO_Veh_Mileage + " " + data.d[0].Veh_Annot);
                    if (tbFirstName.GetText() == "") {
                        tbCustomerNo.SetText(data.d[0].Cust_ID);
                        <%--$('#<%=txtSrchCust.ClientID%>').val(data.d[0].Cust_ID);
                        $('#<%=txtName.ClientID%>').val(data.d[0].FirstName);
                        $('#<%=txtMName.ClientID%>').val(data.d[0].MiddleName);
                        $('#<%=txtLName.ClientID%>').val(data.d[0].LastName);--%>
                        tbFirstName.SetText(data.d[0].FirstName)
                        tbMiddleName.SetText(data.d[0].MiddleName)
                        tbLastName.SetText(data.d[0].LastName)
                    }
                },
                failure: function () {
                    alert("Failed!");
                }
            });
        }



        $('#<%=txtSrchVeh.ClientID%>').change(function (e) {
            var vehId = $('#<%=txtSrchVeh.ClientID%>').val();
            var retVal = validateVeh(vehId);
            if (retVal == "False") {
                alert("Vehicle does not exist. Do you want to create a new vehicle?");
                // window.open("../Master/frmVehicleDetail.aspx?vehid=" + vehId, "info6", "resizable=no,scrollbars=1,status=yes,width=1000px,height=700px,menubar=0,toolbar=0");
                //  window.showModalDialog("../Master/frmVehicleDetail.aspx?vehid=" + vehId, window.self, "dialogHeight:700px;dialogWidth:1000px;resizable:no;center:yes;scroll:yes;");
                moreInfo("../Master/frmVehicleDetail.aspx?vehId=" + vehId + "&veh=new&pageName=AppointmentFormVehicle");
            }
            //loadXtraCheck();
        });

        function validateVeh(VehicleId) {
            var strRetVal;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmWOHead.aspx/ValidateVehicle",
                data: "{IdVehicle: '" + VehicleId + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    strRetVal = data.d.toString()

                },
                error: function (result) {
                    alert("Error");
                }
            });
            return strRetVal;
        }
        //CustomerDetails Start
        $('#custMoreInfo').click(function (e) {
            e.preventDefault();
            <%--if ($('#<%=txtSrchCust.ClientID%>').val().length > 0) {
                var custId = $('#<%=txtSrchCust.ClientID%>').val();--%>
            if (tbCustomerNo.GetText().length > 0) {
                var custId = tbCustomerNo.GetText();
                moreInfo('../Master/frmCustomerDetail.aspx?cust=' + custId + '&pageName=AppointmentFormCustomer', 'Kundedetaljer');
            }
            else {
                moreInfo('../Master/frmCustomerDetail.aspx?pageName=AppointmentFormCustomer', 'Kundedetaljer');
            }
        });
        $('#vehMoreInfo').click(function (e) {
            e.preventDefault();
            if (tbRefNo.GetText().length > 0) {
                var intNo = tbRefNo.GetText();

                moreInfo('../Master/frmVehicleDetail.aspx?refno=' + intNo + '&pageName=AppointmentFormVehicle', 'KjÃ¸retÃ¸ydetaljer');
            }
            else if ($('#<%=txtSrchVeh.ClientID%>').val().length > 0) {
                var regno = $('#<%=txtSrchVeh.ClientID%>').val();

                moreInfo('../Master/frmVehicleDetail.aspx?regno=' + regno + '&veh=new&pageName=AppointmentFormVehicle', 'KjÃ¸retÃ¸ydetaljer');
            }
            else {
                moreInfo('../Master/frmVehicleDetail.aspx?&pageName=AppointmentFormVehicle', 'KjÃ¸retÃ¸ydetaljer');
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
    });
    function FillVehDetails(VehicleId) {
        //alert(VehicleId + " = VehicleId");
        $.ajax({
            type: "POST",
            url: "frmWOHead.aspx/LoadVehDet",
            data: "{VehicleId: '" + VehicleId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {                
                tbRegNo.SetText(data.d[0].WO_Veh_Reg_NO);
                tbChNo.SetText(data.d[0].WO_Veh_Vin);
                tbRefNo.SetText(data.d[0].Veh_Int_No);
                //alert(data.d[0].Id_Make);
                if (data.d[0].Id_Make == 0) {
                        <%--$('#<%=ddlMake.ClientID%>')[0].selectedIndex = 0;--%>
                }
                else {
                       <%-- $('#<%=ddlMake.ClientID%> option:contains("' + data.d[0].Id_Make + '")').attr('selected', 'selected');--%>
                    //alert(data.d[0].Id_Make);
                    cbMake.SetText(data.d[0].Id_Make);
                }
                $('#<%=txtbxModel.ClientID%>').val(data.d[0].Veh_Type);
                lblVehInfo.SetText(data.d[0].VehColor + " " + data.d[0].WO_Veh_Mileage + " " + data.d[0].Veh_Annot);
                if (tbFirstName.GetText() == "") {
                    tbCustomerNo.SetText(data.d[0].Cust_ID);
                        <%--$('#<%=txtSrchCust.ClientID%>').val(data.d[0].Cust_ID);
                        $('#<%=txtName.ClientID%>').val(data.d[0].FirstName);
                        $('#<%=txtMName.ClientID%>').val(data.d[0].MiddleName);
                        $('#<%=txtLName.ClientID%>').val(data.d[0].LastName);--%>
                    tbFirstName.SetText(data.d[0].FirstName)
                    tbMiddleName.SetText(data.d[0].MiddleName)
                    tbLastName.SetText(data.d[0].LastName)
                }

            },
            failure: function () {
                alert("Failed!");
            }
        });
    }
    function OnOkClick(s, e) {
        if (tbCustomerNo.GetText() != "" && $('#<%=txtSrchVeh.ClientID%>').val() != "" && gvAppointmentDetails.GetVisibleRowsOnPage() < 1) {
            alert("Add Appointment after adding Customer and Vehicle details");
            e.preventDefault = true;
            e.stopPropagation = true;
            e.cancel = true;
            return false;
        }
        return true;
    }

    function BatchEditStarting(s, e) {
		'<%HttpContext.Current.Session("isEditing") = "yes" %>';
        var returnValue = checkEmptyValues();
        if (!returnValue) {
            e.cancel = true;
            return false;
        }
        else {
            if (e.visibleIndex < 0) {
                if (s.batchEditApi.GetCellValue(e.visibleIndex, "START_DATE") === null) {
                    s.batchEditApi.SetCellValue(e.visibleIndex, "START_DATE", edtStartDate.GetValue());
                }
                if (s.batchEditApi.GetCellValue(e.visibleIndex, "END_DATE") === null) {
                    s.batchEditApi.SetCellValue(e.visibleIndex, "END_DATE", edtEndDate.GetValue());
                    //gvMechanic.SetFocusedCell(e.visibleIndex, 4);
                    //s.batchEditApi.StartEdit(e.visibleIndex, 4);
                }
                if (s.batchEditApi.GetCellValue(e.visibleIndex, "START_TIME") === null) {
                    s.batchEditApi.SetCellValue(e.visibleIndex, "START_TIME", edtStartTime.GetValue());
                }
                if (s.batchEditApi.GetCellValue(e.visibleIndex, "END_TIME") === null) {
                    s.batchEditApi.SetCellValue(e.visibleIndex, "END_TIME", edtEndTime.GetValue());
                }
                if (s.batchEditApi.GetCellValue(e.visibleIndex, "RESOURCE_ID") === null) {
                    s.batchEditApi.SetCellValueByKey(e.visibleIndex, "RESOURCE_ID", edtMultiResource.GetValue());
                }
                if (gvAppointmentDetails.cpIsCtrlByStatus == true) {
                    if (s.batchEditApi.GetCellValue(e.visibleIndex, "COLOR_CODE") === null) {
                        s.batchEditApi.SetCellValueByKey(e.visibleIndex, "COLOR_CODE", '#C0C0C0');
                    }
                }
                //var item = ddResource.FindItemByText(ddResource.GetValue());
                //console.log(edtMultiResource.GetValue());
            }
            return true;
        }

    }

    function checkEmptyValues(s, e) {
        if (tbCustomerNo.GetText() == "" && $('#<%=txtSrchVeh.ClientID%>').val() == "") {
            alert("Please select the Customer and the Vehicle before adding Appointment");
            return false;
        }
        else if ($('#<%=txtSrchVeh.ClientID%>').val() == "") {
            alert("Please select the Vehicle before adding Appointment");
            return false;
        }
        else if (tbCustomerNo.GetText() == "") {
            alert("Please select the Customer before adding Appointment");
            return false;
        }
        //else if (tbSubject.GetText() == "") {
        //    alert("Please add Subject before adding Appointment");
        //    return false;
        //}
        else {
            return true;
        }
    }
    function BatchEditRowValidating(s, e) {
        var grid = ASPxClientGridView.Cast(s);
        var cellInfo1 = e.validationInfo[grid.GetColumnByField("START_DATE").index];
        var cellInfo2 = e.validationInfo[grid.GetColumnByField("END_DATE").index];
        var cellInfo3 = e.validationInfo[grid.GetColumnByField("START_TIME").index];
        var cellInfo4 = e.validationInfo[grid.GetColumnByField("END_TIME").index];

        if (cellInfo1.value != null && cellInfo2.value != null && cellInfo3.value != null) {
            if (cellInfo1.value > cellInfo2.value) {
                cellInfo2.isValid = false;
                cellInfo2.errorText = "End Date cannot be lesser than Start Date";
            }
            else if (cellInfo1.value.toString() === cellInfo2.value.toString()) {

                if (cellInfo3.value >= cellInfo4.value) {
                    cellInfo4.isValid = false;
                    cellInfo4.errorText = "End Time cannot be lesser than Start Time";
                }
            }
        }
    }

    <%--function OnCancelClick(s, e) {
        '<%HttpContext.Current.Session("Edit") = "no" %>';
    }--%>

    function EndCallBack(s, e) {
        var StartDate = convertDateFormat(edtStartDate.GetDate());
        var mechName = ddResource.GetValue();
        // alert(s.cpAptValue);
        tbCustomInfo.SetText(s.cpAptValue);
        var rowcount = gvAppointmentDetails.GetVisibleRowsOnPage();
        if (rowcount > 0) {
            var index = gvAppointmentDetails.GetFocusedRowIndex();
            btnSaveState.SetClientVisible(true);
            if (index >= 0) {
                var selectedDate = convertDateFormat(gvAppointmentDetails.batchEditApi.GetCellValue(index, "START_DATE"));
                var selectedMechanicId = gvAppointmentDetails.batchEditApi.GetCellValue(index, "RESOURCE_ID");
                var selectedMechanicName = s.GetEditor("RESOURCE_ID").FindItemByValue(selectedMechanicId).text;
                // alert(selectedDate + " " + selectedMechanicId + " " + selectedMechanicName);
                cbMecDetails.PerformCallback(selectedDate + '$' + selectedMechanicId + "$" + selectedMechanicName);
            }
            else {
                cbMecDetails.PerformCallback();
            }


            if (hdnRowInsert.Get("RowInsert") == "true") {
                s.AddNewRow();
                hdnRowInsert.Set("RowInsert", "false");
            }
        }
        //gvAppointmentDetails.Refresh();
    }

    function OnBatchEditRowDeleting(s, e) {
        if (e.itemValues[5].value.toString() == edtStartDate.GetDate().toString() && e.itemValues[7].value.toString() == edtEndDate.GetDate().toString() && e.itemValues[8].text == ddResource.GetValue()) { //&& e.itemValues[7].value == edtEndDate.GetDate() && e.itemValues[8].text == ddResource.GetValue()
            alert("We cant delete this Appointment , but we can edit.");
            e.cancel = true;
        }
    }


    function convertDateFormat(date) {

        var Str = ("00" + (date.getDate())).slice(-2)
            + "." + ("00" + (date.getMonth() + 1)).slice(-2)
            + "." + date.getFullYear() + " "
            + ("00" + date.getHours()).slice(-2) + ":"
            + ("00" + date.getMinutes()).slice(-2)
            + ":" + ("00" + date.getSeconds()).slice(-2);
        return Str;
    }

    function OnValueChanged(s, e) {
        //alert(cbMake.GetSelectedItem().value);
        //alert(cbMake.GetSelectedItem().GetColumnText(0));
    }

    function OnInit(s, e) {
        s.AddItem(0, "Select");

        $.ajax({
            type: "POST",
            url: "frmWOHead.aspx/LoadVehMake",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;

                //s.InsertItem(0, "Select","0");
                $.each(Result, function (key, value) {
                    var i = 1;
                    s.AddItem(value.Veh_Make.toString(), value.Id_Make);
                    i = i + 1;
                });
            },
            failure: function () {
                alert("Failed!");
            }
        });
    }
    function OnCustNoTextChanged(s, e) {
        var custId = tbCustomerNo.GetText();
        var retVal = validateCust(custId);
        if (retVal == "False") {
            if (tbCustomerNo.GetText().length > 0) {
                alert("Do you want to create that customer?");
                //window.open("../Master/frmCustomerDetail.aspx?cust=" + custId, "info6", "resizable=no,scrollbars=1,status=yes,width=1000px,height=700px,menubar=0,toolbar=0");
                // window.showModalDialog("../Master/frmCustomerDetail.aspx?custId=" + custId, window.self, "dialogHeight:700px;dialogWidth:1000px;resizable:no;center:yes;scroll:yes;");
                moreInfo("../Master/frmCustomerDetail.aspx?custId=" + custId + "&pageName=AppointmentFormCustomer");
            }
        }
    }

    function validateCust(CustomerId) {
        var strRetVal;
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "frmWOHead.aspx/ValidateCustomer",
            data: "{IdCustomer: '" + CustomerId + "'}",
            dataType: "json",
            async: false,
            success: function (data) {
                strRetVal = data.d.toString()

            },
            error: function (result) {
                alert("Error");
            }
        });
        return strRetVal;
    }
    function autoCompleteMechanic(s, e) {

        $(s.GetInputElement()).autocomplete({
            //$('#<%=tbCustomerNo.ClientID%>').autocomplete({
            selectFirst: true,
            autoFocus: true,
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmWoSearch.aspx/Customer_Search",
                    data: "{'q':'" + tbCustomerNo.GetText() + "', 'isPrivate': '" + true + "', 'isCompany': '" + true + "'}",
                    dataType: "json",

                    success: function (data) {
                        response($.map(data.d, function (item) {
                            //We need to check for flag =1 for private company
                            if (item.CUST_FIRST_NAME != "") {
                                return {
                                    label: item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME + " - " + item.CUST_PERM_ADD1 + " - " + item.ID_CUST_PERM_ZIPCODE + " " + item.CUST_PERM_CITY,
                                    val: item.CUST_FIRST_NAME + "$" + item.CUST_MIDDLE_NAME + "$" + item.CUST_LAST_NAME,
                                    value: item.ID_CUSTOMER
                                }
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
                //alert("select");
                tbCustomerNo.SetText(i.item.value);
                var custFullName = (i.item.val).trim().split('$');
                //console.log(custFullName);
                if (custFullName.length == 3) {
                    tbFirstName.SetText(custFullName[0])
                    tbMiddleName.SetText(custFullName[1])
                    tbLastName.SetText(custFullName[2])
                }

                var CustInfo = i.item.label.split("-");
                lblCustInfo.SetText(CustInfo[1] + CustInfo[2]);
                FillVehDrpDwn(tbCustomerNo.GetText());
                // alert("here");                    
                //if (tbFirstName.GetText() == "") {
                //    tbCustomerNo.SetText("");
                //    return false;
                //}

            }
        });
    }

    function FillCustDet(IdCustomer) {
        $.ajax({
            type: "POST",
            url: "frmWOHead.aspx/LoadCustDet",
            data: "{IdCustomer: '" + IdCustomer + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {               
                tbFirstName.SetText(data.d[0].WO_Cust_Name);
            },
            failure: function () {
                alert("Failed!");
            }
        });

    }


    function FillVehDrpDwn(CustID) {
        //alert("here with " + CustID)
            <%-- $('#<%=ddlVeh.ClientID%>').show();--%>
        $('#<%=lst_veh.ClientID%>').show();
        $('#<%=txtSrchVeh.ClientID%>').hide();
        tbRegNo.SetClientVisible(false);
        $.ajax({
            type: "POST",
            url: "frmWOHead.aspx/LoadVehDrpdwn",
            data: "{'IdCustomer':'" + CustID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                if (Result.length != 0) {
                    $('#<%=lst_veh.ClientID%>').empty();
                    if (Result[0].ErrorMessage != "" && tbRegNo.GetText() != "") {

                        $('#mceMSG').html('Do you want to change the owner of the car?')
                        $('#modVehicleChange').modal('setting', {
                            autofocus: false,
                            onShow: function () {
                            },
                            onDeny: function () {
                                // $('.overlayHide').addClass('ohActive');
                                $('#<%=lst_veh.ClientID%>').hide();
                            //$('#<%=txtSrchVeh.ClientID%>').show();
                            tbRegNo.SetClientVisible(true);
                        },
                        onApprove: function () {
                            $('#<%=lst_veh.ClientID%>').hide();
                                    //$('#<%=txtSrchVeh.ClientID%>').show();
                                    tbRegNo.SetClientVisible(true);
                                    var VehicleId = $('#<%=txtSrchVeh.ClientID%>').val();
                            var CustomerId = tbCustomerNo.GetText();
                            updateVehicle(VehicleId, CustomerId);
                            // LoadNonInvoiceOrderDet(CustomerId);

                        }
                    }).modal('show');
                }
                else {
                    //if (Result.length != 0) {
                    $('#<%=lst_veh.ClientID%>').empty();
                    $('#<%=txtSrchVeh.ClientID%>').hide();
                        tbRegNo.SetClientVisible(false);
                        tbRegNo.SetText("");
                        tbRefNo.SetText("");
                        tbChNo.SetText("");

                        $.each(Result, function (key, value) {
                            //console.log(value.Id_Veh_Seq_WO + " -->> " + value.Veh_Det);
                            $('#ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_lst_veh').append($("<option></option>").val(value.Id_Veh_Seq_WO).html(value.Veh_Det));
                        });
                    }

                }
                else {
                    //alert("No Vehicle Details found for this Customer. Please select another customer.")
                    $('#<%=lst_veh.ClientID%>').hide();
                    //$('#<%=txtSrchVeh.ClientID%>').show();
                    tbRegNo.SetClientVisible(true);
                    $('#<%=txtSrchVeh.ClientID%>').val("");
                    $('#<%=txtbxModel.ClientID%>').val("");
                    tbRegNo.SetText("");
                    tbRefNo.SetText("");
                    tbChNo.SetText("");
                    cbMake.SetText("");
                    //tbFirstName.SetText("");
                    //tbMiddleName.SetText("");
                    //tbLastName.SetText("");
                    //lblCustInfo.SetText("");
                        <%--$('#<%=txtSrchVeh.ClientID%>').show();--%>
                }
            },
            failure: function () {
                alert("Failed!");
            }
        });
    }



    function updateVehicle(vehicleId, customerId) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "frmWOJobDetails.aspx/UpdVehicle",
            data: "{'vehicleId':'" + vehicleId + "',customerId:'" + customerId + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d.length > 0) {
                    if (data.d == "UPD") {
                        $('#<%=RTlblError.ClientID%>').text('Owner is updated successfully.');
                        $('#<%=RTlblError.ClientID%>').removeClass();
                        $('#<%=RTlblError.ClientID%>').addClass("lblMessage");
                    }
                }
            },
            error: function (result) {
                alert("Error");
            }
        });
    }

    function GridOnFocussedRowChanged(s, e) {
        var index = gvAppointmentDetails.GetFocusedRowIndex();


        if (index >= 0 && hdnSaveAgain.Get("DoCallback") == "true") {
            var selectedDate = convertDateFormat(gvAppointmentDetails.batchEditApi.GetCellValue(index, "START_DATE"));
            var selectedMechanicId = gvAppointmentDetails.batchEditApi.GetCellValue(index, "RESOURCE_ID");
            var selectedMechanicName = s.GetEditor("RESOURCE_ID").FindItemByValue(selectedMechanicId).text;

            cbMecDetails.PerformCallback(selectedDate + '$' + selectedMechanicId + "$" + selectedMechanicName);
        }
        hdnSaveAgain.Set("DoCallback", "true");
    }

    function OnGridFocusedCellChanging(s, e) {
        if (gvAppointmentDetails.cpIsCtrlByStatus == true) {
            if (e.cellInfo.column.fieldName == 'COLOR_CODE') {
                e.cancel = true;
            }
        }
    }
    function OnBatchEditChangesSaving(s, e) {
        //hdnRowInsert.Set("RowInsert", "false");
        if (Object.keys(e.insertedValues).length != 0) {
            console.log(Object.keys(e.updatedValues).length);
            hdnSaveAgain.Set("SaveAgain", "false");
            hdnRowInsert.Set("RowInsert", "true");
        }
        hdnOverTime.Set("OverTime", false);
         var index = gvAppointmentDetails.GetFocusedRowIndex();
        var startDate = new Date(ConvertToMMDDYYYY(gvAppointmentDetails.batchEditApi.GetCellValue(index, "START_DATE")));
        var endDate = new Date(ConvertToMMDDYYYY(gvAppointmentDetails.batchEditApi.GetCellValue(index, "END_DATE")));       

        if (+startDate === +endDate) {
            var showMessage = isEdiitngAllowedLunch();
            if (!showMessage) {
                if (confirm('Do you want to plan Overtime?')) {
                    hdnOverTime.Set("OverTime", false);
                } else {
                    //Need to look into it
                    hdnOverTime.Set("OverTime", true);
                }
            }
        }

    }
    function ConvertToMMDDYYYY(date) {
        return (("00" + (date.getMonth() + 1)).slice(-2) + "-" + ("00" + (date.getDate())).slice(-2) + "-" + date.getFullYear());
    }


      //Working for Allowing  LunchHours
    function isEdiitngAllowedLunch() {
        var index = gvAppointmentDetails.GetFocusedRowIndex();
        var currentIntervalS = gvAppointmentDetails.batchEditApi.GetCellValue(index, "START_TIME");
        var currentIntervalE = gvAppointmentDetails.batchEditApi.GetCellValue(index, "END_TIME");
        var selectedResource = gvAppointmentDetails.batchEditApi.GetCellValue(index, "RESOURCE_ID");

        var workTimes = schdMechanics.cpLunchCustomWorkTime[selectedResource];
        var intervalStart = currentIntervalS.getHours() * 60 + currentIntervalS.getMinutes();
        var intervalEnd = currentIntervalE.getHours() * 60 + currentIntervalE.getMinutes();
        var dayOfWeek = currentIntervalS.getDay();

        for (var i = 0; i < workTimes.length; i++) {
            if (workTimes[i].StartTime <= intervalStart && workTimes[i].EndTime >= intervalEnd && workTimes[i].DayOfWeek == dayOfWeek) {
                if (workTimes[i].StartTime == 0 && workTimes[i].EndTime == 0) {
                    return false;
                } else {
                    return true;
                }
            }
        }
        return false;
    }

    function OnBatchEditEndEditing(s, e) {
        // hdnRowInsert.Set("RowInsert", "false");
        if (s.cpIsCtrlByStatus == true) {
            setTimeout(function () {
                if (s.batchEditApi.HasChanges()) {

                    if (e.focusedColumn.fieldName === "RESOURCE_ID") {

                        if (hdnSaveAgain.Get("SaveAgain") == "false") {
                            hdnSaveAgain.Set("SaveAgain", "true");
                            e.cancel = true;

                        }
                        else {
                            s.UpdateEdit();
                            hdnSaveAgain.Set("SaveAgain", "true");
                            //05-05-2021
                            hdnSaveAgain.Set("DoCallback", "false");
                        }
                    }
                }
            }, 500);
        }
        else {
            setTimeout(function () {
                if (s.batchEditApi.HasChanges()) {
                    console.log(e.focusedColumn.fieldName);
                    if (e.focusedColumn.fieldName === "COLOR_CODE") {
                        if (hdnSaveAgain.Get("SaveAgain") == "false") {
                            hdnSaveAgain.Set("SaveAgain", "true");
                            e.cancel = true;

                        }
                        else {
                            s.UpdateEdit();
                            hdnSaveAgain.Set("SaveAgain", "true");
                            hdnSaveAgain.Set("DoCallback", "false");
                        }

                    }
                }
            }, 500);
        }
    }
    function OnCustomButtonClick(s, e) {
        if (e.buttonID == 'textButton') {
            popupText.ShowAtElement(gvAppointmentDetails.GetMainElement());
            tbText1.Focus();
        }
    }
    function onPopupTextShown(s, e) {
        var index = gvAppointmentDetails.GetFocusedRowIndex();
        tbText1.SetText(gvAppointmentDetails.batchEditApi.GetCellValue(index, "TEXT_LINE1"));
        tbText2.SetText(gvAppointmentDetails.batchEditApi.GetCellValue(index, "TEXT_LINE2"));
        tbText3.SetText(gvAppointmentDetails.batchEditApi.GetCellValue(index, "TEXT_LINE3"));
        tbText4.SetText(gvAppointmentDetails.batchEditApi.GetCellValue(index, "TEXT_LINE4"));
        tbText5.SetText(gvAppointmentDetails.batchEditApi.GetCellValue(index, "TEXT_LINE5"));

    }
    function onAcceptClick(s, e) {
        var index = gvAppointmentDetails.GetFocusedRowIndex();
        gvAppointmentDetails.batchEditApi.SetCellValue(index, "TEXT_LINE1", tbText1.GetText());
        gvAppointmentDetails.batchEditApi.SetCellValue(index, "TEXT_LINE2", tbText2.GetText());
        gvAppointmentDetails.batchEditApi.SetCellValue(index, "TEXT_LINE3", tbText3.GetText());
        gvAppointmentDetails.batchEditApi.SetCellValue(index, "TEXT_LINE4", tbText4.GetText());
        gvAppointmentDetails.batchEditApi.SetCellValue(index, "TEXT_LINE5", tbText5.GetText());
        popupText.Hide();
        var startDateColumn = gvAppointmentDetails.GetColumnByField("START_DATE");
        var startDateColumnIndex = startDateColumn.index;
        //alert(gvAppointmentDetails.GetFocusedRowIndex());
        gvAppointmentDetails.SetFocusedCell(gvAppointmentDetails.GetFocusedRowIndex(), startDateColumnIndex);
        gvAppointmentDetails.batchEditApi.StartEdit(gvAppointmentDetails.GetFocusedRowIndex(), startDateColumnIndex);
    }
    function OnGridViewInit(s, e) {
        if (hdnAddNewRow.Get("AddRow") && hdnAddNewRow.Get("NewApt") && gvAppointmentDetails.GetVisibleRowsOnPage() > 0) {
            s.AddNewRow();
            hdnAddNewRow.Set('AddRow', false);
            hdnAddNewRow.Set("NewApt", false);
        }
        
        if (gvAppointmentDetails.GetVisibleRowsOnPage() > 0) {
            btnSaveState.SetClientVisible(true);
        }
        //alert(ConvertToDDMMYYYY("Fri Nov 26 2021 00: 00: 00 GMT + 0530(India Standard Time)"));
        hdnSaveAgain.Set("DoCallback", "true");
    }
    function tbRegNoInit(s, e) {
        $(s.GetInputElement()).autocomplete({
            selectFirst: true,
            autoFocus: true,
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmWOHead.aspx/GetVehicle",
                    data: "{'vehicleRegNo':'" + tbRegNo.GetText() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                            response([{ label: 'Ingen treff i kjøretøyregister. Vil du opprette ny?', value: tbRegNo.GetText(), val: 'new' }]);
                        } else {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0] + "-" + item.split('-')[1] + "-" + item.split('-')[2],
                                    val: item.split('-')[0],
                                    value: item.split('-')[0]
                                }

                            }))
                        }
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
                    <%--$("#<%=txtSrchVeh.ClientID%>").val(i.item.value);
                    tbRegNo.SetText(i.item.val);
                    FillVehDetails($("#<%=txtSrchVeh.ClientID%>").val());--%>
                $("#<%=txtSrchVeh.ClientID%>").val(i.item.value);
                if (i.item.val != 'new') {
                    tbRegNo.SetText(i.item.val);
                    FillVehDetails($("#<%=txtSrchVeh.ClientID%>").val());
                    //alert("Not new");
                } else {
                    //var vehId = $('#<%=txtSrchVeh.ClientID%>').val();
                    var vehId = tbRegNo.GetText();
                    //alert("New");
                    tbRegNo.SetText(vehId);
                    moreInfo("../Master/frmVehicleDetail.aspx?vehId=" + vehId + "&veh=new&pageName=AppointmentFormVehicle");
                }
            }
        });
    }
</script>
<style>
    .customStyle {
        border-radius: 4px;
        border-color: #dbdbdb;
    }

    #ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_PW-1[style] {
        width: 1000px !important;
        top: -20px !important;
    }

    .tableColumn {
        padding-right: 180px;
    }

    .LabelCell {
        display: inline-block;
        width: 70px;
    }

    .customTextBox {
        height: 10% !important;
        border-color: #dbdbdb;
        border-radius: 6px;
    }

    .ui.form input[type="text"] {
        padding: 0.15em 0.4em;
        font-size: 1.03em;
    }

    .ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_gvAppointmentDetails_DXPagerBottom_PSI:hover ul li:hover ul {
        position: absolute;
        margin-top: 1px;
        font: 10px;
        bottom: 0px;
    }
</style>


<body>
    <div style="height: 650px; overflow-y: auto; overflow-x: hidden;">
        <div>
            <div class="ui form stackable three column grid " style="max-width: 103%;">
                <div class="three wide column">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H1" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Details</h3>
                        <dx:ASPxHiddenField ID="hdnSaveAgain" ClientInstanceName="hdnSaveAgain" runat="server" Item="SaveAgain,true"></dx:ASPxHiddenField>
                        <dx:ASPxHiddenField ID="hdnRowInsert" ClientInstanceName="hdnRowInsert" runat="server"></dx:ASPxHiddenField>
                    <dx:ASPxHiddenField ID="hdnSaveState" runat="server" ClientInstanceName="hdnSaveState"></dx:ASPxHiddenField>
                        <dx:ASPxHiddenField ID="hdnOverTime" runat="server" ClientInstanceName="hdnOverTime"></dx:ASPxHiddenField>
                        <dx:ASPxCallbackPanel ID="cbMecDetails" ClientInstanceName="cbMecDetails" runat="server" OnCallback="cbMecDetails_Callback">
                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <div style="text-align: center;">
                                        <dx:ASPxLabel ID="lblLeaveDetails" ClientInstanceName="lblLeaveDetails" Font-Size="X-Small" Font-Bold="true" runat="server"></dx:ASPxLabel>
                                    </div>
                                    <div style="text-align: center;">
                                        <dx:ASPxLabel ID="lblSelectedDate" ClientInstanceName="lblSelectedDate" Font-Size="X-Small" Font-Bold="true" runat="server"></dx:ASPxLabel>
                                    </div>
                                    <dx:ASPxListBox ID="lbLeaveDetails" ClientInstanceName="lbLeaveDetails" runat="server" CaptionSettings-Position="Top" CaptionSettings-ShowColon="false" Width="100%" Height="200" Theme="Office2010Blue">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="FROM_TIME" Caption="Fra" Width="10%"></dx:ListBoxColumn>
                                            <dx:ListBoxColumn FieldName="REASON" Caption="Avtale" Width="10%"></dx:ListBoxColumn>
                                            <dx:ListBoxColumn FieldName="TO_TIME" Caption="Till" Width="10%"></dx:ListBoxColumn>
                                        </Columns>

                                    </dx:ASPxListBox>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>

                        <div class="fields">
                            <div class="eight wide field">
                            </div>
                        </div>
                    </div>

                </div>
                <div class="six wide column">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                        <h3 id="H4" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Kunde</h3>
                        <div class="fields">
                            <div class="eight wide field">
                                <asp:Label ID="lblCustomerNo" runat="server" Text="Kundenr."></asp:Label>
                                <dx:ASPxTextBox ID="tbCustomerNo" ClientInstanceName="tbCustomerNo" ClientSideEvents-TextChanged="OnCustNoTextChanged" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" ClientSideEvents-Init="autoCompleteMechanic" runat="server" Width="100%" NullText="Search Customer here"></dx:ASPxTextBox>
                            </div>

                            <div class="two wide field">
                            </div>
                            <div class="two wide field">
                                <%--<div class="ui checkbox">--%>
                                <div>
                                    <dx:ASPxCheckBox ClientInstanceName="cbxFirma" ID="cbxFirma" Width="50%" Height="50" Text="Firma" runat="server" Theme="MetropolisBlue"></dx:ASPxCheckBox>
                                </div>
                            </div>

                        </div>
                        <div class="fields">
                            <div class="four wide field">
                                <asp:Label ID="lblFirstName" runat="server" Text="Fornavn"></asp:Label>
                                <dx:ASPxTextBox ID="tbFirstName" ClientInstanceName="tbFirstName" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" Width="100%" runat="server"></dx:ASPxTextBox>
                            </div>
                            <div class="five wide field">
                                <asp:Label ID="lblMiddleName" runat="server" Text="Mellomnavn"></asp:Label>
                                <dx:ASPxTextBox ID="tbMiddleName" ClientInstanceName="tbMiddleName" CssClass="customTextBox" Width="100%" FocusedStyle-Border-BorderColor="#2185d0" runat="server"></dx:ASPxTextBox>
                            </div>
                            <div class="five wide field">
                                <asp:Label ID="lblLastName" runat="server" Text="Etternavn"></asp:Label>
                                <dx:ASPxTextBox ID="tbLastName" ClientInstanceName="tbLastName" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" Width="100%" runat="server"></dx:ASPxTextBox>
                            </div>
                            <div class="one wide field">
                                <button class="mini ui btn" id="custMoreInfo" title="Se kunde" style="max-height: 25px; margin-top: 19px; width: 2.7em;"><i class="user icon" style="font-size: 20px"></i></button>
                            </div>
                        </div>
                        <dx:ASPxLabel ID="lblCustInfo" ClientInstanceName="lblCustInfo" ClientVisible="false" runat="server"></dx:ASPxLabel>

                        <div class="fields"></div>
                        <div class="fields"></div>
                        <div class="fields"></div>
                        <div class="fields"></div>
                        <div class="fields"></div>
                        <div class="fields"></div>
                        <div class="fields"></div>
                        <div class="fields"></div>

                        <div class="fields">
                            <div class="eight wide field">
                            </div>
                        </div>

                    </div>

                </div>

                <div class="seven wide column">
                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15); padding-bottom: 21px;">
                        <h4 id="H11" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Kjøretøy</h4>
                        <div class="fields">
                            <div class="eleven wide field">
                                <asp:Label ID="lblRegNo" runat="server" Text="Reg.nr"></asp:Label>
                                <dx:ASPxTextBox ID="tbRegNo" ClientInstanceName="tbRegNo" ClientSideEvents-Init="tbRegNoInit" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" Width="100%" runat="server" Text=""></dx:ASPxTextBox>
                                <asp:ListBox ID="lst_veh" runat="server" meta:resourcekey="lst_vehResource1"></asp:ListBox>
                            </div>
                            <div class="two wide field">
                                <asp:Label ID="lblSrchVeh" runat="server"></asp:Label>
                                <asp:TextBox ID="txtSrchVeh" PlaceHolder="Søk etter kjøretøy her..." Width="100%" CssClass="carsInput" FocusedStyle-Border-BorderColor="#2185d0" runat="server"></asp:TextBox>
                            </div>
                            <div class="one wide field">
                                <button class="mini ui btn" id="vehMoreInfo" title="Se kjøretøy" style="max-height: 25px; margin-top: 19px; width: 2.7em;"><i class="fas fa-car" style="font-size: 20px"></i></button>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="five wide field">
                                <asp:Label ID="lblRefNo" runat="server" Text="Ref.nr"></asp:Label>
                                <dx:ASPxTextBox ID="tbRefNo" ClientInstanceName="tbRefNo" CssClass="customTextBox" FocusedStyle-Border-BorderColor="#2185d0" Width="100%" runat="server" Text=""></dx:ASPxTextBox>
                            </div>
                            <div class="five wide field">
                                <asp:Label ID="lblMake" runat="server" Text="Make"></asp:Label>
                                <dx:ASPxComboBox ID="cbMake" ClientInstanceName="cbMake" runat="server" Width="100%" EnableSynchronization="False" FocusedStyle-Border-BorderColor="#2185d0" CssClass="customTextBox" Theme="Metropolis">
                                    <ClientSideEvents ValueChanged="OnValueChanged" />
                                </dx:ASPxComboBox>
                            </div>
                            <div class="five wide field">
                                <asp:Label ID="lblModel" runat="server" Text="Model" meta:resourcekey="lblModelResource1"></asp:Label><span class="mand">*</span>
                                <div class="ui mini input">
                                    <asp:TextBox ID="txtbxModel" CssClass="carsInput" runat="server" class="" meta:resourcekey="ddlModelResource1">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eleven wide field">
                                <asp:Label ID="lblChNo" runat="server" Text="Ch.nr"></asp:Label>
                                <dx:ASPxTextBox ID="tbChNo" ClientInstanceName="tbChNo" CssClass="customTextBox" Width="100%" FocusedStyle-Border-BorderColor="#2185d0" runat="server" Text=""></dx:ASPxTextBox>
                            </div>

                        </div>
                        <div class="fields">
                            <div class="four wide field">
                                <dx:ASPxCheckBox ClientInstanceName="cbxRentalCar" ID="cbxRentalCar" Width="50%" Height="50" Text="Rental Car" runat="server" Theme="MetropolisBlue"></dx:ASPxCheckBox>
                            </div>
                            <div class="four wide field">
                                <dx:ASPxCheckBox ClientInstanceName="cbxPerService" ID="cbxPerService" Width="50%" Height="50" Text="Periodic Service" runat="server" Theme="MetropolisBlue"></dx:ASPxCheckBox>
                            </div>
                            <div class="four wide field">
                                <dx:ASPxCheckBox ClientInstanceName="cbxPerCheck" ID="cbxPerCheck" Width="50%" Height="50" Text="Periodic Check" runat="server" Theme="MetropolisBlue"></dx:ASPxCheckBox>
                            </div>
                        </div>
                        <dx:ASPxLabel ID="lblVehInfo" ClientInstanceName="lblVehInfo" ClientVisible="false" runat="server"></dx:ASPxLabel>
                    </div>
                </div>
                <div class="one wide column">
                    <div class="one wide field"></div>
                </div>
            </div>

            <div class="sixteen wide column">

                <%-- <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">--%>
                <div>
                    <div runat="server" id="ValidationContainer">
                        <table>
                            <tr style="padding-left: 25px;">
                                <td class="tableColumn" style="padding-bottom: 1%">
                                    <table class="dxscLabelControlPair" <%=DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0)%>>
                                        <tr>
                                            <td class="dxscLabelCell">
                                                <dx:ASPxLabel ID="lblStatus" runat="server" ClientVisible="false" AssociatedControlID="edtStatus" Wrap="false" Text="Status" CssClass="LabelCell">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="dxscControlCell">
                                                <dx:ASPxComboBox ClientInstanceName="_dx" ID="edtStatus" ClientVisible="false" runat="server" Width="150%" CssClass="customStyle" DataSource='<%#CType(Container, AppointmentFormTemplateContainer).StatusDataSource%>' />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="dxscSingleCell" style="padding-bottom: 1%">
                                    <table class="dxscLabelControlPair" <%=DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0)%>>
                                        <tr>
                                            <td class="dxscLabelCell">
                                                <dx:ASPxLabel ID="lblLabel" runat="server" ClientVisible="false" AssociatedControlID="edtLabel" Text="Label" CssClass="LabelCell">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="dxscControlCell">
                                                <dx:ASPxComboBox ClientInstanceName="_dx" ID="edtLabel" ClientVisible="false" runat="server" CssClass="customStyle" Width="145%" DataSource='<%#CType(Container, AppointmentFormTemplateContainer).LabelDataSource%>' />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td class="tableColumn" style="padding-bottom: 1%">
                                    <table class="dxscLabelControlPair" <%=DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0)%>>
                                        <tr>
                                            <td class="dxscLabelCell">
                                                <dx:ASPxLabel ID="lblStartDate" runat="server" ClientVisible="false" AssociatedControlID="edtStartDate" Wrap="false" Text="Start " CssClass="LabelCell">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="dxscControlCell">
                                                <dx:ASPxDateEdit ID="edtStartDate" runat="server" ClientInstanceName="edtStartDate" ClientVisible="false" Width="100%" CssClass="customStyle" Date='<%#CType(Container, AppointmentFormTemplateContainer).Start%>' EditFormat="Date" DateOnError="Undo" AllowNull="false" EnableClientSideAPI="true">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidateOnLeave="false" EnableCustomValidation="True" Display="Dynamic"
                                                        ValidationGroup="DateValidatoinGroup">
                                                    </ValidationSettings>
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td class="dxscControlCell" id="edtStartTimeLayoutRoot">
                                                <dx:ASPxTimeEdit ID="edtStartTime" runat="server" ClientInstanceName="edtStartTime" Width="90%" ClientVisible="false" CssClass="customStyle" DateTime='<%#CType(Container, AppointmentFormTemplateContainer).Start%>' DateOnError="Undo" AllowNull="false" EnableClientSideAPI="true">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidateOnLeave="false" EnableCustomValidation="True" Display="Dynamic"
                                                        ValidationGroup="DateValidatoinGroup">
                                                    </ValidationSettings>
                                                </dx:ASPxTimeEdit>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="dxscSingleCell" style="padding-bottom: 1%">
                                    <table class="dxscLabelControlPair" <%=DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0)%>>
                                        <tr>
                                            <td class="dxscLabelCell">
                                                <dx:ASPxLabel runat="server" ID="lblEndDate" Wrap="false" ClientVisible="false" AssociatedControlID="edtEndDate" Text="End" CssClass="LabelCell" />
                                            </td>
                                            <td class="dxscControlCell">
                                                <dx:ASPxDateEdit ID="edtEndDate" ClientInstanceName="edtEndDate" runat="server" ClientVisible="false" Date='<%#CType(Container, AppointmentFormTemplateContainer).End%>' CssClass="customStyle" EditFormat="Date" Width="100%" DateOnError="Undo" AllowNull="false" EnableClientSideAPI="true">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidateOnLeave="false" EnableCustomValidation="True" Display="Dynamic"
                                                        ValidationGroup="DateValidatoinGroup">
                                                    </ValidationSettings>
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td class="dxscControlCell" id="edtEndTimeLayoutRoot">
                                                <dx:ASPxTimeEdit ID="edtEndTime" runat="server" Width="70%" ClientInstanceName="edtEndTime" ClientVisible="false" DateTime='<%#CType(Container, AppointmentFormTemplateContainer).End%>' CssClass="customStyle" DateOnError="Undo" AllowNull="false" EnableClientSideAPI="true" HelpTextSettings-PopupMargins-MarginLeft="50">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidateOnLeave="false" EnableCustomValidation="True" Display="Dynamic"
                                                        ValidationGroup="DateValidatoinGroup">
                                                    </ValidationSettings>
                                                </dx:ASPxTimeEdit>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <dx:ASPxTextBox ID="tbSubject" Caption="Subject" CaptionStyle-Font-Bold="true" ClientVisible="false" ClientInstanceName="tbSubject" Width="100%" CssClass="customStyle" runat="server"></dx:ASPxTextBox>
                            <tr>
                                <td class="tableColumn">
                                    <table class="dxscLabelControlPair" <%=DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0)%>>
                                        <tr>
                                            <td class="dxscLabelCell">
                                                <dx:ASPxLabel ID="lblSubject" ClientVisible="false" runat="server" Text="Subject" CssClass="LabelCell"></dx:ASPxLabel>
                                            </td>
                                            <td class="dxscControlCell">
                                                <dx:ASPxComboBox ID="cbSubject" runat="server" ClientVisible="false" ValueType="System.String" CssClass="customStyle" Width="150%"></dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="dxscSingleCell">
                                    <table class="dxscLabelControlPair" <%=DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0)%>>
                                        <tr>
                                            <td class="dxscLabelCell">
                                                <dx:ASPxLabel ID="lblDescription" runat="server" ClientVisible="false" Text="Description" CssClass="LabelCell"></dx:ASPxLabel>
                                            </td>
                                            <td class="dxscControlCell">
                                                <dx:ASPxMemo ClientInstanceName="_dx" ID="tbDescription" ClientVisible="false" runat="server" Width="185%" Enabled="false" Rows="1" CssClass="customStyle" Text='<%#CType(Container, AppointmentFormTemplateContainer).Appointment.Description%>' />
                                            </td>
                                            <dx:ASPxTextBox ID="tbCustomInfo" ClientInstanceName="tbCustomInfo" ClientVisible="false" Width="50px" Enabled="true" runat="server" />

                                            <td>
                                                <%--<dx:ASPxComboBox ClientInstanceName="_dx" ID="edtResource" ClientVisible="false" runat="server"   Width="50%" DataSource='<%#CType(Container, AppointmentFormTemplateContainer).ResourceDataSource%>' Enabled="false" CssClass="customStyle" />--%>
                                                <%
            If ResourceSharing Then
                                                %>
                                                <dx:ASPxDropDownEdit ID="ddResource" runat="server" ClientVisible="false" Width="100%" ClientInstanceName="ddResource" Enabled='<%#CType(Container, AppointmentFormTemplateContainer).CanEditResource%>' AllowUserInput="false">
                                                    <DropDownWindowTemplate>
                                                        <dx:ASPxListBox ID="edtMultiResource" ClientInstanceName="edtMultiResource" runat="server" Width="100%" SelectionMode="CheckColumn" DataSource='<%#ResourceDataSource%>' Border-BorderWidth="0" />
                                                    </DropDownWindowTemplate>
                                                </dx:ASPxDropDownEdit>
                                                <%
                                                    Else
                                                %>
                                                <dx:ASPxComboBox ClientInstanceName="_dx" ID="edtResource" runat="server" Width="50%" DataSource='<%#ResourceDataSource%>' Enabled='<%#CType(Container, AppointmentFormTemplateContainer).CanEditResource%>' />
                                                <%
                                                    End If
                                                %>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>

                    </div>

                </div>

                <div class="one wide column">
                    <div class="one wide field"></div>
                </div>
            </div>
        </div>
        <div class=""></div>
        <asp:Label ID="RTlblError" runat="server" CssClass="lblErr" meta:resourcekey="RTlblErrorResource1"></asp:Label>
        <div id="modVehicleChange" class="ui modal">
            <i class="close icon"></i>
            <div class="header">
                Vehicle
            </div>
            <div class="image content">
                <div class="description">
                    <p id="mceMSG"></p>
                </div>
            </div>
            <div class="actions">
                <div class="ui button ok positive">Ok</div>
                <div class="ui button cancel negative">Avbryt</div>
            </div>
        </div>
        <div class="sixteen wide column">
            <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                <dx:ASPxGridView ID="gvAppointmentDetails" runat="server" SettingsEditing-BatchEditSettings-ShowConfirmOnLosingChanges="true"
                    KeyFieldName="ID_APPOINTMENT_DETAILS" KeyboardSupport="true" OnCommandButtonInitialize="gvAppointmentDetails_CommandButtonInitialize"
                    ClientInstanceName="gvAppointmentDetails" OnPageIndexChanged="gvAppointmentDetails_PageIndexChanged" OnPageSizeChanged="gvAppointmentDetails_PageSizeChanged"
                    OnRowValidating="gvAppointmentDetails_RowValidating" OnCellEditorInitialize="gvAppointmentDetails_CellEditorInitialize"
                    AutoGenerateColumns="False" OnBatchUpdate="gvAppointmentDetails_BatchUpdate" Width="100%" Theme="DevEx">

                    <ClientSideEvents BatchEditRowDeleting="OnBatchEditRowDeleting" BatchEditEndEditing="OnBatchEditEndEditing" EndCallback="EndCallBack" BatchEditStartEditing="BatchEditStarting" BatchEditRowValidating="BatchEditRowValidating"
                        BatchEditChangesSaving="OnBatchEditChangesSaving" FocusedCellChanging="OnGridFocusedCellChanging" Init="OnGridViewInit" FocusedRowChanged="GridOnFocussedRowChanged" CustomButtonClick="OnCustomButtonClick" />
                    <%--BatchEditRowValidating="BatchEditRowValidating" FocusedRowChanged="GridOnFocussedRowChanged" BatchEditEndEditing="OnBatchEditEndEditing" --%>
                    <SettingsBehavior AllowFocusedRow="true" AllowSort="false" />
                    <SettingsEditing Mode="Batch" NewItemRowPosition="Bottom" />
                    <SettingsPager PageSize="5">
                        <PageSizeItemSettings Visible="true" Items="10,20,50" ShowAllItem="true" />
                    </SettingsPager>
                    <Columns>
                        <dx:GridViewCommandColumn ShowEditButton="false" ShowNewButtonInHeader="true" />
                        <dx:GridViewDataTextColumn FieldName="ID_DISPLAY_DATA" ReadOnly="true" EditFormSettings-Visible="False" VisibleIndex="1" Visible="false" />
                        <dx:GridViewDataTextColumn FieldName="RESERVATION" Caption="Reservation" VisibleIndex="2" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-Display="Dynamic" PropertiesTextEdit-MaxLength="50" />
                        <dx:GridViewDataTextColumn FieldName="SEARCH" Caption="Search" VisibleIndex="3" PropertiesTextEdit-MaxLength="30" />
                        <dx:GridViewDataTextColumn FieldName="TEXT" Caption="Text" VisibleIndex="4" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="false" PropertiesTextEdit-ValidationSettings-Display="Dynamic" Visible="false" />
                        <dx:GridViewCommandColumn VisibleIndex="5" Width="8%" Caption="Text">
                            <CustomButtons>
                                <dx:GridViewCommandColumnCustomButton ID="textButton" Text="Add Text"></dx:GridViewCommandColumnCustomButton>
                            </CustomButtons>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataDateColumn FieldName="START_DATE" Caption="Start Date" VisibleIndex="6" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesDateEdit-ValidationSettings-Display="Dynamic" PropertiesDateEdit-ClientSideEvents-KeyDown="function(s, e){s.ShowDropDown();}" PropertiesDateEdit-ClientSideEvents-KeyUp="function(s, e){s.ShowDropDown();}">
                            <%--<PropertiesDateEdit DisplayFormatString="dd-MM-yyyy"></PropertiesDateEdit>--%>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTimeEditColumn FieldName="START_TIME" Caption="Start Time" VisibleIndex="7" PropertiesTimeEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTimeEdit-ValidationSettings-Display="Dynamic">
                            <PropertiesTimeEdit DisplayFormatString="HH:mm"></PropertiesTimeEdit>
                        </dx:GridViewDataTimeEditColumn>
                        <dx:GridViewDataDateColumn FieldName="END_DATE" Caption="End Date" VisibleIndex="8" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesDateEdit-ClientSideEvents-KeyDown="function(s, e){s.ShowDropDown();}" PropertiesDateEdit-ClientSideEvents-KeyUp="function(s, e){s.ShowDropDown();}" PropertiesDateEdit-ValidationSettings-Display="Dynamic">
                            <%--<PropertiesDateEdit DisplayFormatString="dd-MM-yyyy" ></PropertiesDateEdit>--%>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTimeEditColumn FieldName="END_TIME" Caption="End Time" VisibleIndex="9" PropertiesTimeEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTimeEdit-ValidationSettings-Display="Dynamic">
                            <PropertiesTimeEdit DisplayFormatString="HH:mm"></PropertiesTimeEdit>
                        </dx:GridViewDataTimeEditColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="RESOURCE_ID" Caption="Mechanic" VisibleIndex="10" PropertiesComboBox-ClientInstanceName="cbMechanic" PropertiesComboBox-ValidationSettings-Display="Dynamic">
                            <PropertiesComboBox TextField="ResourceName" ValueField="ResourceID" ValueType="System.String" ValidationSettings-RequiredField-IsRequired="true"></PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <%--<dx:GridViewDataTextColumn FieldName="ID_JOB" VisibleIndex="11" Visible="false" />--%>
                        <dx:GridViewDataColorEditColumn FieldName="COLOR_CODE" Width="14%" Caption="Color" VisibleIndex="11" PropertiesColorEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesColorEdit-ClientSideEvents-KeyUp="function(s, e){s.ShowDropDown();}" PropertiesColorEdit-ValidationSettings-Display="Dynamic">
                            <HeaderStyle />
                            <DataItemTemplate>
                                <div style="width: 100%; height: 20px; border: #9f9f9f 1px solid; background-color: <%#Container.Text%>"></div>
                            </DataItemTemplate>
                        </dx:GridViewDataColorEditColumn>
                        <dx:GridViewDataTextColumn FieldName="TEXT_LINE1" Caption="Text1" VisibleIndex="12" Width="0%">
                            <Settings AllowEllipsisInText="True" ShowEditorInBatchEditMode="false" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TEXT_LINE2" Caption="Text2" VisibleIndex="13" Width="0%">
                            <Settings AllowEllipsisInText="True" ShowEditorInBatchEditMode="false" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TEXT_LINE3" Caption="Text3" VisibleIndex="14" Width="0%">
                            <Settings AllowEllipsisInText="True" ShowEditorInBatchEditMode="false" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TEXT_LINE4" Caption="Text4" VisibleIndex="15" Width="0%">
                            <Settings AllowEllipsisInText="True" ShowEditorInBatchEditMode="false" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TEXT_LINE5" Caption="Text5" VisibleIndex="16" Width="0%">
                            <Settings AllowEllipsisInText="True" ShowEditorInBatchEditMode="false" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewCommandColumn ShowDeleteButton="false" Visible="false" />
                    </Columns>

                </dx:ASPxGridView>
            </div>
            <dx:ASPxPopupControl ID="popupText" runat="server" ClientInstanceName="popupText" CloseAction="CloseButton" ShowHeader="false" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" Theme="Office2010Blue"
                AllowDragging="True">
                <ClientSideEvents Shown="onPopupTextShown" />
                <ContentCollection>
                    <dx:PopupControlContentControl>
                        <dx:ASPxLabel ID="lblText1" runat="server" Text="Text 1" />
                        <dx:ASPxTextBox ID="tbText1" ClientInstanceName="tbText1" runat="server" Theme="Office2010Blue" />
                        <dx:ASPxLabel ID="lblText2" runat="server" Text="Text 2" />
                        <dx:ASPxTextBox ID="tbText2" ClientInstanceName="tbText2" runat="server" Theme="Office2010Blue" />
                        <dx:ASPxLabel ID="lblText3" runat="server" Text="Text 3" />
                        <dx:ASPxTextBox ID="tbText3" ClientInstanceName="tbText3" runat="server" Theme="Office2010Blue" />
                        <dx:ASPxLabel ID="lblText4" runat="server" Text="Text 4" />
                        <dx:ASPxTextBox ID="tbText4" ClientInstanceName="tbText4" runat="server" Theme="Office2010Blue" />
                        <dx:ASPxLabel ID="lblText5" runat="server" Text="Text 5" />
                        <dx:ASPxTextBox ID="tbText5" ClientInstanceName="tbText5" runat="server" Theme="Office2010Blue" />
                        <br />
                        <dx:ASPxButton ID="btnAccept" runat="server" Text="Ok" AutoPostBack="false" Theme="Office2010Blue">
                            <ClientSideEvents Click="onAcceptClick" />
                        </dx:ASPxButton>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
        </div>
        <%--</div>--%>

        <dxsc:AppointmentRecurrenceForm ID="AppointmentRecurrenceForm1" runat="server" Visible="false"
            IsRecurring='<%#CType(Container, AppointmentFormTemplateContainer).Appointment.IsRecurring%>'
            DayNumber='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceDayNumber%>'
            End='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceEnd%>'
            Month='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceMonth%>'
            OccurrenceCount='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceOccurrenceCount%>'
            Periodicity='<%#CType(Container, AppointmentFormTemplateContainer).RecurrencePeriodicity%>'
            RecurrenceRange='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceRange%>'
            Start='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceStart%>'
            WeekDays='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceWeekDays%>'
            WeekOfMonth='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceWeekOfMonth%>'
            RecurrenceType='<%#CType(Container, AppointmentFormTemplateContainer).RecurrenceType%>'
            IsFormRecreated='<%#CType(Container, AppointmentFormTemplateContainer).IsFormRecreated%>'>
        </dxsc:AppointmentRecurrenceForm>

        <table <%=DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0)%> style="width: 100%; height: 35px;">
            <tr>
                <td class="dx-ac" style="width: 100%; height: 100%;" <%=DevExpress.Web.Internal.RenderUtils.GetAlignAttributes(Me, "center", Nothing)%>>
                    <table class="dxscButtonTable" style="height: 100%">
                        <tr>
                            <td class="dxscCellWithPadding">
                        <dx:ASPxButton runat="server" ID="btnSaveState" ClientInstanceName="btnSaveState" Text="Save State" UseSubmitBehavior="false" AutoPostBack="false" 
                            EnableViewState="false" Width="91px" EnableClientSideAPI="true" ClientVisible="false" Theme="Office365">
                            <ClientSideEvents Click="function(s, e) {
                                hdnSaveState.Add('SaveAptState', true);
                                hdnSaveState.Add('UpdateOnOk', true);
                                schdMechanics.AppointmentFormSave();
                                hdnAddNewRow.Set('AddRow',true);
                            }" />
                        </dx:ASPxButton>
                    </td>
                        <td class="dxscCellWithPadding">
                                <dx:ASPxButton runat="server" ID="btnOk" UseSubmitBehavior="false" AutoPostBack="false"
                                    EnableViewState="false" Width="91px" EnableClientSideAPI="true" />
                                <%--ClientSideEvents-Click="OnOkClick"--%>
                            </td>
                            <td class="dxscCellWithPadding">
                                <dx:ASPxButton runat="server" ID="btnCancel" UseSubmitBehavior="false" AutoPostBack="false" EnableViewState="false"
                                    Width="91px" CausesValidation="False" EnableClientSideAPI="true" />
                            </td>
                            <td class="dxscCellWithPadding">
                                <dx:ASPxButton runat="server" ID="btnDelete" UseSubmitBehavior="false"
                                    AutoPostBack="false" EnableViewState="false" Width="91px"
                                    Enabled='<%#CType(Container, AppointmentFormTemplateContainer).CanDeleteAppointment%>'
                                    CausesValidation="False" ClientVisible="false" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

    </div>

</body>
<script id="dxss_ASPxSchedulerAppoinmentForm" type="text/javascript">
    ASPxAppointmentForm = ASPx.CreateClass(ASPxClientFormBase, {
        Initialize: function () {
            this.isValid = true;
            this.isRecurrenceValid = true;
            this.controls.edtStartDate.Validation.AddHandler(ASPx.CreateDelegate(this.OnEdtStartDateValidate, this));
            this.controls.edtEndDate.Validation.AddHandler(ASPx.CreateDelegate(this.OnEdtEndDateValidate, this));
            this.controls.edtStartDate.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateStartDateTimeValue, this));
            this.controls.edtEndDate.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateEndDateTimeValue, this));
            this.controls.edtStartTime.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateStartDateTimeValue, this));
            this.controls.edtEndTime.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateEndDateTimeValue, this));
            //this.controls.chkAllDay.CheckedChanged.AddHandler(ASPx.CreateDelegate(this.OnChkAllDayCheckedChanged, this));
            this.controls.btnOk.Click.AddHandler(ASPx.CreateDelegate(this.OnBtnOk, this));
            this.controls.btnCancel.Click.AddHandler(ASPx.CreateDelegate(this.OnCancelClick, this));
            if (this.controls.AppointmentRecurrenceForm1)
                this.controls.AppointmentRecurrenceForm1.ValidationCompleted.AddHandler(ASPx.CreateDelegate(this.OnRecurrenceRangeControlValidationCompleted, this));
            this.UpdateTimeEditorsVisibility();
            //if (this.controls.chkReminder)
            //    this.controls.chkReminder.CheckedChanged.AddHandler(ASPx.CreateDelegate(this.OnChkReminderCheckedChanged, this));
            if (this.controls.edtMultiResource)
                this.controls.edtMultiResource.SelectedIndexChanged.AddHandler(ASPx.CreateDelegate(this.OnEdtMultiResourceSelectedIndexChanged, this));
            var start = this.controls.edtStartDate.GetValue();
            var end = this.controls.edtEndDate.GetValue();
            var duration = ASPxClientTimeInterval.CalculateDuration(start, end);
            this.appointmentInterval = new ASPxClientTimeInterval(start, duration);
            //this.appointmentInterval.SetAllDay(this.controls.chkAllDay.GetValue());
            this.primaryIntervalJson = ASPx.Json.ToJson(this.appointmentInterval);
            this.UpdateDateTimeEditors();
        },
        OnBtnOk: function (s, e) {
            hdnSaveState.Add("SaveAptState", false);
            e.processOnServer = false;
            var gvRowCount = gvRowCount = gvAppointmentDetails.GetVisibleRowsOnPage();
            if (tbCustomerNo.GetText() != "" && $('#<%=txtSrchVeh.ClientID%>').val() != "" && gvRowCount == 0) {
                alert("Add Appointment after adding Customer and Vehicle details");
                //e.preventDefault = true;
                //e.stopPropagation = true;
                e.cancel = true;
                //return false;
            }
            else {

                var formOwner = this.GetFormOwner();
                if (!formOwner)
                    return;
                if (this.controls.AppointmentRecurrenceForm1 && this.IsRecurrenceChainRecreationNeeded() && this.cpHasExceptions) {
                    formOwner.ShowMessageBox(this.localization.SchedulerLocalizer.Msg_Warning, this.localization.SchedulerLocalizer.Msg_RecurrenceExceptionsWillBeLost, this.OnWarningExceptionWillBeLostOk.aspxBind(this));
                } else {
                    formOwner.AppointmentFormSave();
                }
            }

        },
        IsRecurrenceChainRecreationNeeded: function () {
            var isIntervalChanged = this.primaryIntervalJson != ASPx.Json.ToJson(this.appointmentInterval);
            return isIntervalChanged || this.controls.AppointmentRecurrenceForm1.IsChanged();
        },
        OnWarningExceptionWillBeLostOk: function () {
            this.GetFormOwner().AppointmentFormSave();
        },
        OnEdtMultiResourceSelectedIndexChanged: function (s, e) {
            var resourceNames = new Array();
            var items = s.GetSelectedItems();
            var count = items.length;
            //alert(count);
            if (count > 0) {
                for (var i = 0; i < count; i++)
                    resourceNames.push(items[i].text);
            }
            else
                resourceNames.push(ddResource.cp_Caption_ResourceNone);
            ddResource.SetValue(resourceNames.join(', '));
        },
        OnEdtStartDateValidate: function (s, e) {
            if (!e.isValid)
                return;
            var startDate = this.controls.edtStartDate.GetDate();
            var endDate = this.controls.edtEndDate.GetDate();
            e.isValid = startDate == null || endDate == null || startDate <= endDate;
            e.errorText = "The Start Date must precede the End Date.";
        },
        OnEdtEndDateValidate: function (s, e) {
            if (!e.isValid)
                return;
            var startDate = this.controls.edtStartDate.GetDate();
            var endDate = this.controls.edtEndDate.GetDate();
            e.isValid = startDate == null || endDate == null || startDate <= endDate;
            e.errorText = "The Start Date must precede the End Date.";
        },
        OnUpdateEndDateTimeValue: function (s, e) {
            // var isAllDay = this.controls.chkAllDay.GetValue();
            var date = ASPxSchedulerDateTimeHelper.TruncToDate(this.controls.edtEndDate.GetDate());
            //if (isAllDay)
            //    date = ASPxSchedulerDateTimeHelper.AddDays(date, 1);
            var time = ASPxSchedulerDateTimeHelper.ToDayTime(this.controls.edtEndTime.GetDate());
            var dateTime = ASPxSchedulerDateTimeHelper.AddTimeSpan(date, time);
            this.appointmentInterval.SetEnd(dateTime);
            this.UpdateDateTimeEditors();
            this.Validate();
        },
        OnUpdateStartDateTimeValue: function (s, e) {
            var date = ASPxSchedulerDateTimeHelper.TruncToDate(this.controls.edtStartDate.GetDate());
            var time = ASPxSchedulerDateTimeHelper.ToDayTime(this.controls.edtStartTime.GetDate());
            var dateTime = ASPxSchedulerDateTimeHelper.AddTimeSpan(date, time);
            this.appointmentInterval.SetStart(dateTime);
            this.UpdateDateTimeEditors();
            if (this.controls.AppointmentRecurrenceForm1)
                this.controls.AppointmentRecurrenceForm1.SetStart(dateTime);
            this.Validate();
        },
        OnChkReminderCheckedChanged: function (s, e) {
            var isReminderEnabled = this.controls.chkReminder.GetValue();
            if (isReminderEnabled)
                this.controls.cbReminder.SetSelectedIndex(3);
            else
                this.controls.cbReminder.SetSelectedIndex(-1);
            this.controls.cbReminder.SetEnabled(isReminderEnabled);
        },
        //OnChkAllDayCheckedChanged: function (s, e) {
        //    this.UpdateTimeEditorsVisibility();
        //    var isAllDay = this.controls.chkAllDay.GetValue();
        //    this.appointmentInterval.SetAllDay(isAllDay);
        //    this.UpdateDateTimeEditors();
        //},
        UpdateDateTimeEditors: function () {
            //var isAllDay = this.controls.chkAllDay.GetValue();
            this.controls.edtStartDate.SetValue(this.appointmentInterval.GetStart());
            var end = this.appointmentInterval.GetEnd();
            //if (isAllDay) {
            //    end = ASPxSchedulerDateTimeHelper.AddDays(end, -1);
            //}
            this.controls.edtEndDate.SetValue(end);
            this.controls.edtStartTime.SetValue(this.appointmentInterval.GetStart());
            this.controls.edtEndTime.SetValue(end);
        },
        UpdateTimeEditorsVisibility: function () {
            //var isAllDay = this.controls.chkAllDay.GetValue();
            //var visible = (isAllDay) ? "none" : "";
            var visible = "";
            var startRoot = ASPx.GetParentById(this.controls.edtStartTime.GetMainElement(), "edtStartTimeLayoutRoot");
            var endRoot = ASPx.GetParentById(this.controls.edtEndTime.GetMainElement(), "edtEndTimeLayoutRoot");
            startRoot.style.display = visible;
            endRoot.style.display = visible;
        },
        Validate: function () {
            this.isValid = ASPxClientEdit.ValidateEditorsInContainer(null);
            this.controls.btnOk.SetEnabled(this.isValid && this.isRecurrenceValid);
        },
        OnRecurrenceRangeControlValidationCompleted: function (s, e) {
            if (!this.controls.AppointmentRecurrenceForm1)
                return;
            this.isRecurrenceValid = this.controls.AppointmentRecurrenceForm1.IsValid();
            this.controls.btnOk.SetEnabled(this.isValid && this.isRecurrenceValid);
        },
        //,
        //EndCallBack: function (s, e) {
        //    // alert(s.cpAptValue);
        //    tbCustomInfo.SetText(s.cpAptValue);
        //}
        OnCancelClick: function () {
            //alert("Hi");
            //cbCancel.PerformCallback();
            <%--'<%HttpContext.Current.Session("Edit") = "no" %>';--%>
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDayPlan.aspx/DoCancel",
                data: "{'cancel':'no'}",
                dataType: "json",
                success: function (data) {

                },
                error: function (xhr, status, error) {
                    alert("Error" + error);
                    var err = eval("(" + xhr.responseText + ")");
                    alert('Error: ' + err.Message);
                }
            });
        }
    });
</script>
