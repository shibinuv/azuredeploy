<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmDayPlan.aspx.vb" Inherits="CARS.frmDayPlan" %>


<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.XtraScheduler.v21.2.Core, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraScheduler" tagprefix="cc1" %>
<%@ Register assembly="DevExpress.XtraScheduler.v21.2.Core.Desktop, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraScheduler" tagprefix="cc1" %>
<%@ Register Src="~/CustomTemplates/CustomToolTip.ascx" TagPrefix="uc1" TagName="CustomToolTip" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dxtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style type="text/css">
        .popupMenu {/*CSS For Setting Context  Menu Height*/
        max-height: 250px; 
        overflow-y: scroll;
        }
        .closeButtonDisplay {
            display:none;
        }

        .roundedButton {
            
            border-top-left-radius:50%;
            border-top-right-radius: 50%;
            border-bottom-right-radius: 50%;
            border-bottom-left-radius: 50%;
        }
    /*.dxsc-restokens{

        visibility:hidden;
    }*/
    /*#lbExiOdr {
        display: none;
    }*/
        .customAppt .dxsc-apt-status-container {
            width: 25%;
        }
    .pushable {
            height: 100%;
             overflow-x: visible; 
            padding: 0em !important;
        }
    .custom-resource-navigator {
        border: none;
    }

    .custom-resource-navigator .dxsc-restokens,
    .custom-resource-navigator .dxsc-more-button {
        display: none;
    }
    .ctl00_cntMainPanel_schdMechanics_viewVisibleIntervalBlock_ctl00{
        width:100px;
    }
        .container1 {
            display: flex;
            align-items: flex-start;
        }
        .first, .last {
          min-height:24px;
          max-height:24px;
        }
        .content1 {
            align-self: stretch;
            display: flex;
            flex-direction: column;
            justify-content: center;
            width: 100%;
        }

        .Aptcenter {
            background-color: lightgray;
            height: 85%;
        }

        .statusContainer {
            align-self: stretch;
            width: 10%;
        }
         .activeHover {
            background-color: blue !important;
        }
        .ui-draggable-dragging {
            background-color: lightblue;
            color: White;
        }
        .customComboBox {
            /*height: 6px !important;*/
            border-color: #dbdbdb;
            border-radius: 6px;
        }
        /*.gridView .dxgvDataRow_Office2010Blue {
            height: 20px;
            font-size: medium;
        }*/
        /*#ctl00_cntMainPanel_cbAllAptGrid_gvAllAppointments_DXPagerBottom_PSB {
            width: 25% !important;
        }
         #ctl00_cntMainPanel_cbAllAptGrid_gvAllAppointments_DXPagerBottom_PSI {
            width: 22% !important;
        }*/
    </style>
    <script type="text/javascript">
        var needUpdateGrid = false;
        function InitalizejQuery() {
            $('.draggableGrid').draggable({
                helper: 'clone',
                start: function (ev, ui) {
                    var $draggingElement = $(ui.helper);
                    $draggingElement.width(200);
                    //alert(gvOnHold.GetWidth());
                }
            });
            $('.droppableScheduler').droppable({
                tolerance: "intersect",
                hoverClass: "activeHover",
                drop: function (event, ui) {
                    var appGridIndex = ui.draggable.attr("appGridIndex");
                    var appAppointmentId = ui.draggable.attr("appAppointmentId");
                    var appAppointmentDetailsId = ui.draggable.attr("appAppointmentDetailsId");
                    var appRegNo = ui.draggable.attr("appRegNo");
                    var intResource = $(this).attr("intResource");
                    var intStart = $(this).attr("intStart");
                    var intEnd = $(this).attr("intEnd");
                    var appDuration = ui.draggable.attr("appDuration");
                    var intervalStart = $(this).attr("intervalStart");
                    var intDayOfWeek = $(this).attr("intDayOfWeek");
                    var showMessage = isDropFromExternalAllowed(intervalStart, intDayOfWeek, appDuration,schdMechanics.cpLunchCustomWorkTime[intResource]);
                    if (!showMessage) {
                        if (confirm('Do you want to plan Overtime?')) {
                        } else {
                            return;
                        }
                    }

                    var appDuration= ui.draggable.attr("appDuration");
                    //needUpdateGrid = true;
                    hdnRefreshOnHold.Set("RefreshOnHold", "True");
                    gvOnHold.PerformCallback("UPDATE|" + appGridIndex + "|" + intResource + "|" + appAppointmentId + "|" + appAppointmentDetailsId + "|" + intStart + "|" + appRegNo + "|" + intEnd + "|" + appDuration);
                    
                    //schdMechanics.Refresh();
                    //gvOnHold.Refresh();
                }
            });
        }
        function isDropFromExternalAllowed(intervalStart, dayOfWeek, duration, workTimes) {

            //var testStart = start.split('.');
            //var startDate = new Date(testStart[1]+"."+testStart[0]+"."+testStart[2]);
            //console.log(startDate + " " + startDate.getHours() + " " + startDate.getDay());
            //var intervalStart = currentInterval.GetStart().getHours() * 60 + currentInterval.GetStart().getMinutes();

            var intervalEnd = parseInt(intervalStart) + parseInt(duration);

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
        function SelectedIndexChanged(s, e) {
            cbOrderList.PerformCallback("ExistingOrder;" +s.GetSelectedItem().text);
            existOrdersPopup.Hide();
            schdMechanics.Refresh();
        }

        function lbOnHoldAppSelectedIndexChanged(s, e) {
                cbOnHoldList.PerformCallback(s.GetSelectedItem().text);
                //schdMechanics.Refresh();
                popupOnHoldApp.Hide();            
        }

        function OnInit(s, e) {
            if (s.cpRecordExist == "YES") {
                lblHeader.SetText("Existing Records");
            }
            if (s.cpRecordExist == "NO") {
                lblHeader.SetText("No Records Found");
            }
        }

        function OnEndCallBack(s, e) {
            //alert(s.cpRefresh);
           // s.SetWidth(s.cpWidth);
            if (s.cpWidth > 1400) {
                var exceededResourceCount = s.visibleResources.length -7;
                var exceededWidth = exceededResourceCount * 100;
                //alert(exceededWidth);
                s.SetWidth(s.cpWidth - exceededWidth);
                document.getElementById('container2').style.width = parseInt(s.cpWidth - exceededWidth) + "px";
            }
            else {
                s.SetWidth(s.cpWidth);
                document.getElementById('container2').style.width = parseInt(s.cpWidth) + "px";
            }

            //document.getElementById('container2').style.width = parseInt(s.cpWidth) + "px";

            if (s.cpRefresh == "true") {
                schdMechanics.Refresh();
            }

            //hdnRefreshSch.SetText("Refresh")
            if (hdnRefreshSch.Get("Refresh") == "True") {
                schdMechanics.Refresh();
                //alert("Refresh");
                hdnRefreshSch.Set("Refresh", "False");
            }			
			
            if (hdnRefreshOnHold.Get("RefreshOnHold") == "True") {
                schdMechanics.Refresh();
                gvOnHold.Refresh();
                //hdnRefreshOnHold.Set("RefreshOnHold", "False");
                hdnRefreshOnHold.Set("RefreshOnHold", "False");
            }

            if (schdMechanics.cpCallBackParameter == "PasteAppointment") {
                $('#<%=hdCopiedAppointmentID.ClientID%>').val("");
                $('#<%=hdType.ClientID%>').val("");
                 schdMechanics.Refresh();
            }
            
        }

        function onAppointmentDrag(s, e) {
            var selectedAppointment = s.GetAppointmentById(e.dragInformation[0].appointmentId);

            //Based on changes it shd be allowed on Lunch and Non Working Hours
            var newRes = e.dragInformation[0].newResources;
            //e.allow = isEdiitngAllowed(e.dragInformation[0].newInterval, s.cpCustomWorkTime[newRes]); 


            //To handle Holidays
            var selectedResource = newRes;
            var currentInterval = e.dragInformation[0].newInterval;
            var date = currentInterval.start.toDateString();

            var selectedMechHolidays = schdMechanics.cpMechHolidays[selectedResource];

            var intervalStart = currentInterval.GetStart().getHours() * 60 + currentInterval.GetStart().getMinutes();
            var intervalEnd = currentInterval.GetEnd().getHours() * 60 + currentInterval.GetEnd().getMinutes();
            var dayOfWeek = currentInterval.start.getDay();

            if (selectedMechHolidays != undefined) {
                for (var i = 0; i < selectedMechHolidays.length; i++) {
                    var selmechId = selectedMechHolidays[i].MechId;
                    var holiday = selectedMechHolidays[i].MechHolidayDate.toDateString();
                    var holidayFromTime = selectedMechHolidays[i].MechHolidayFromTime;
                    var holidayToTime = selectedMechHolidays[i].MechHolidayToTime;


                    if (holiday == date) {
                        if (selmechId == selectedResource) {
                            // if (intervalStart >= holidayFromTime && intervalEnd <= holidayToTime) {
                            if ((intervalStart >= holidayFromTime && intervalStart < holidayToTime) || (intervalEnd > holidayFromTime && intervalEnd <= holidayToTime)) {
                                e.allow = false;
                            }

                            if (intervalStart < holidayFromTime && intervalEnd > holidayToTime) {
                                e.allow = false;
                            }
                        }
                    }
                }
            }

        }        
                

        function onAppointmentResizing(s, e) {
             //Based on changes it shd be allowed on Lunch and Non Working Hours
                var selectedResource = s.GetSelectedResource();
               // e.allow = isEdiitngAllowed(e.newInterval, s.cpCustomWorkTime[selectedResource]);


                //To handle Holidays
                //var selectedResource = newRes;
                var currentInterval = e.newInterval;
                var date = currentInterval.start.toDateString();
           
                var selectedMechHolidays = schdMechanics.cpMechHolidays[selectedResource];

                var intervalStart = currentInterval.GetStart().getHours() * 60 + currentInterval.GetStart().getMinutes();
                var intervalEnd = currentInterval.GetEnd().getHours() * 60 + currentInterval.GetEnd().getMinutes();
                var dayOfWeek = currentInterval.start.getDay();

                if (selectedMechHolidays != undefined) {
                    for (var i = 0; i < selectedMechHolidays.length; i++) {
                        var selmechId = selectedMechHolidays[i].MechId;
                        var holiday = selectedMechHolidays[i].MechHolidayDate.toDateString();
                        var holidayFromTime = selectedMechHolidays[i].MechHolidayFromTime;
                        var holidayToTime = selectedMechHolidays[i].MechHolidayToTime;
                                             
                        if (holiday == date) {
                            if (selmechId == selectedResource) {
                                if ((intervalStart >= holidayFromTime && intervalStart <= holidayToTime) || ( intervalEnd > holidayFromTime && intervalEnd <= holidayToTime)) {
                                    e.allow = false;
                                }

                                if (intervalStart < holidayFromTime && intervalEnd > holidayToTime)  {
                                     e.allow = false;
                                }
                            }
                        }
                    }
                }
        }

        function OnAppointmentDeleting(s, e) {
            //e.preventDefault = true;
            //e.stopPropagation = true;
            //e.cancel = true;
            e.cancel = !confirm("Do you really want to delete this appointment?");
        }

        function OnClientPopupMenuShowing(s, e) {            
            var selAppmnt = schdMechanics.GetSelectedAppointmentIds();
            var appointmentIds;
            if (selAppmnt.length > 0){
                appointmentIds = schdMechanics.GetSelectedAppointmentIds()[0];
            }            
            var apt = schdMechanics.GetAppointmentById(schdMechanics.GetSelectedAppointmentIds()[0]);

            if (apt != null) {
                var appWONum = apt.WONONum;
                var appIsOrder = apt.IsOrder;
                for (menuItemId in e.item.items) {
                    if (appWONum != "0") {
                        if (e.item.items[menuItemId].name == "ExistingOrder") {
                            e.item.items[menuItemId].SetEnabled(false);
                        }
                        if (e.item.items[menuItemId].name == "CreateOrder") {
                            e.item.items[menuItemId].SetEnabled(false);
                        }
                        if (e.item.items[menuItemId].name == "CreateOrderGoTo") {
                            e.item.items[menuItemId].SetEnabled(false);
                        }
                        if (e.item.items[menuItemId].name == "CreateOrderPrintJC") {
                            e.item.items[menuItemId].SetEnabled(false);
                        }
                        if (e.item.items[menuItemId].name == "CreateBAROrder") {
                            e.item.items[menuItemId].SetEnabled(false);
                        }
                        //Test - Even AppointmentOrder shd be able to put OnHold
                        //if (e.item.items[menuItemId].name == "SetOnHold") {
                        //    e.item.items[menuItemId].SetEnabled(false);
                        //}

                         if (e.item.items[menuItemId].name == "OpenOrder") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }
                        if (e.item.items[menuItemId].name == "TransferToOrder") {
                            e.item.items[menuItemId].SetEnabled(false);
                        }
                           
                    }
                    else {
                        if (e.item.items[menuItemId].name == "ExistingOrder") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }
                        if (e.item.items[menuItemId].name == "CreateOrder") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }
                        if (e.item.items[menuItemId].name == "CreateOrderGoTo") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }
                        if (e.item.items[menuItemId].name == "CreateOrderPrintJC") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }
                        if (e.item.items[menuItemId].name == "CreateBAROrder") {
                            e.item.items[menuItemId].SetEnabled(true);
                        } 
                        //Test
                        if (e.item.items[menuItemId].name == "SetOnHold") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }

                         if (e.item.items[menuItemId].name == "OpenNewApt") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }				
						
						
						if (e.item.items[menuItemId].name == "OpenOrder") {
                            e.item.items[menuItemId].SetEnabled(false);
                        }                         
                        if (e.item.items[menuItemId].name == "TransferToOrder") {
                            e.item.items[menuItemId].SetEnabled(true);
                        }
                    }                   
                    if (e.item.items[menuItemId].name == "OpenAppointment") {
                            e.item.items[menuItemId].SetText("Open Appointment");
                        }
                }
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
        function onContextMenuPopup(s, e) {
            //alert("OnBlankClick");
            for (menuItemId in e.item.items) {
                var res = e.item.items[menuItemId].name.indexOf("New");
                if (res = -1) {
                    if (e.item.items[menuItemId].name == "ExistingOrder") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    if (e.item.items[menuItemId].name == "CreateOrder") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    if (e.item.items[menuItemId].name == "CreateOrderGoTo") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    if (e.item.items[menuItemId].name == "CreateOrderPrintJC") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    if (e.item.items[menuItemId].name == "CreateBAROrder") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    //Order Popup Change Start
                    if (e.item.items[menuItemId].name == "TransferToOrder") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    //Order Popup Change End
                    if (e.item.items[menuItemId].name == "SetOnHold") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    if (e.item.items[menuItemId].name == "JobStatus") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    if (e.item.items[menuItemId].name == "PasteAppointment") {
                        if ($('#<%=hdCopiedAppointmentID.ClientID%>').val() == "") {
                            e.item.items[menuItemId].SetVisible(false);
                        } else {
                            e.item.items[menuItemId].SetVisible(true);
                        }                        
                    }
					
					if (e.item.items[menuItemId].name == "OpenNewApt") {
                        e.item.items[menuItemId].SetVisible(false);
                    }
                    if (e.item.items[menuItemId].name == "OpenOrder") {
                            e.item.items[menuItemId].SetVisible(false);
                    }
                }
            }
            //OnClientPopupMenuShowing(s, e);

            var selectedInterval = schdMechanics.GetSelectedInterval();
            var selectedResource = schdMechanics.GetSelectedResource();

            for (menuItemId in e.item.items) {
                if (e.item.items[menuItemId].name.indexOf("New") > -1) {
                    e.item.items[menuItemId].SetEnabled(isEdiitngAllowed(selectedInterval, schdMechanics.cpCustomWorkTime[selectedResource]));
                }
            }

            var holidays = schdMechanics.cpHolidays;
            var currentInterval = schdMechanics.GetSelectedInterval();
            var date = currentInterval.start.toDateString();

             var intervalStart = currentInterval.GetStart().getHours() * 60 + currentInterval.GetStart().getMinutes();
            var intervalEnd = currentInterval.GetEnd().getHours() * 60 + currentInterval.GetEnd().getMinutes();
            var dayOfWeek = currentInterval.start.getDay();

            var allmechHolidays = schdMechanics.cpMechHolidays;
            var selectedMechHolidays = schdMechanics.cpMechHolidays[selectedResource];

            //This is for Holidays   
            
            if (selectedMechHolidays != undefined) {
                for (var i = 0; i < selectedMechHolidays.length; i++) {
                    var selmechId = selectedMechHolidays[i].MechId;
                    var holiday = selectedMechHolidays[i].MechHolidayDate.toDateString();
                    var holidayFromTime = selectedMechHolidays[i].MechHolidayFromTime;
                    var holidayToTime = selectedMechHolidays[i].MechHolidayToTime;
                    
                    if (holiday == date) {
                        if (selmechId == selectedResource) {
                            for (menuItemId in e.item.items) {
                                var res = e.item.items[menuItemId].name.indexOf("New");
                                if (res > -1) {
                                    if (intervalStart >= holidayFromTime && intervalEnd <= holidayToTime) {
                                        e.item.items[menuItemId].SetEnabled(false);
                                    }                                    
                                }
                            }
                        }
                    }
                }
            }

        }

        function isEdiitngAllowed(currentInterval, workTimes) {
           // console.log(workTimes);
            var intervalStart = currentInterval.GetStart().getHours() * 60 + currentInterval.GetStart().getMinutes();
            var intervalEnd = currentInterval.GetEnd().getHours() * 60 + currentInterval.GetEnd().getMinutes();
            var dayOfWeek = currentInterval.start.getDay();

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

      

        function OnMenuItemClicked(s, e) {
            //alert(e.itemName);//StatusSubMenu
            // cpRefresh == "true" // LabelSubMenu
            if (e.itemName.includes('LabelSubMenu')) {
                schdMechanics.cpRefresh = "true";
                hdnRefreshSch.Set("Refresh","True");
                //alert("schdMechanics.cpRefresh "+schdMechanics.cpRefresh);
            }
            if (e.itemName.includes('StatusSubMenu')) {
                schdMechanics.cpRefresh = "true";
                hdnRefreshSch.Set("Refresh", "True");
                //alert("schdMechanics.cpRefresh "+schdMechanics.cpRefresh);
            }
            if (e.itemName == "ExistingOrder") {
                 cbOrderList.PerformCallback("ExistingOrder");
                existOrdersPopup.Show();
                e.handled = true;
            }
            if (e.itemName == "CreateOrder") {
                cbOrderList.PerformCallback("CreateOrder");
            }
            if (e.itemName == "CreateOrderGoTo") {
                cbOrderList.PerformCallback("CreateOrderGoTo");
            }
            if (e.itemName == "CreateOrderPrintJC") {
                alert("CreateOrderPrintJC");
            }
            if (e.itemName == "CreateBAROrder") {
                alert("CreateBAROrder");
            }
            //Order Popup Change Start
            if (e.itemName == "TransferToOrder") {
                cbOrders.PerformCallback("FETCH");
                ordersPopup.Show();
            }
            //Order Popup Change End

            if (e.itemName == "SetOnHold") {                
                hdnRefreshOnHold.Set("RefreshOnHold", "True");
                cbOrderList.PerformCallback("SetOnHold");
            }
            if (e.itemName == "GetOnHold") {
                cbOrderList.PerformCallback("GetOnHold");
                popupOnHoldApp.Show();
                cbOnHoldList.PerformCallback();
            }
            // For SubMenu
            if (e.itemName.includes('JobStatus')) {
			
			    //schdMechanics.cpRefresh = "true";
                hdnRefreshSch.Set("Refresh", "True");
				cbJobStatus.PerformCallback(e.itemName);
            }

            if (e.itemName == "CopyAppointment") {
                var selectedIds = schdMechanics.GetSelectedAppointmentIds()[0].toString();
                $('#<%=hdCopiedAppointmentID.ClientID%>').val(selectedIds); 
                $('#<%=hdType.ClientID%>').val("copy");           
            } else if (e.itemName == "CutAppointment") {
                var selectedIds = schdMechanics.GetSelectedAppointmentIds()[0].toString();
               
                $('#<%=hdCopiedAppointmentID.ClientID%>').val(selectedIds); 
                $('#<%=hdType.ClientID%>').val("cut");           
            }
            else if (e.itemName == "PasteAppointment") {
                schdMechanics.PerformCallback(e.itemName);
            }
						
			if (e.itemName == "OpenNewApt") {
                schdMechanics.RaiseCallback('MNUVIEW|NewAppointment');
                e.handled = true;
            }
            if (e.itemName == "NewAppointment" || e.itemName == "OpenNewApt") {
                hdnAddNewRow.Set("NewApt", true);
            }
            else {
                hdnAddNewRow.Set("NewApt", false);
            }
			
            if (e.itemName == "OpenOrder") {
                  cbOrderList.PerformCallback("OpenOrder");
            }
            
            
        }

		
        function OnListBoxEndCallback(s, e) {
            schdMechanics.Refresh();
        }
        function OncbOrderEndCallback(s, e) {
            schdMechanics.Refresh();
        }
        //Order Popup Change Ends

        //function OnEndCallBackGrid(s, e) {
        //    popupOnHoldApp.Hide();
        //    schdMechanics.Refresh();
        //}
        function OnFilterScheduler(s, e) {
            var row = event.target.parentElement.parentElement;
            var nodeKey = row.getAttribute("data-nodekey");
            LastSelectedNodeKey.Set("LastSelectedNodeKey", nodeKey);
            LastSelectedNodeKey.Set("IsNodeSelected", s.IsNodeSelected(nodeKey));
            //schdMechanics.Refresh();
        }



        function buttonClick(s, e) {
            resourcePopup.Show();
        }
        function OnExpanded(s, e) {
            //alert(document.getElementById('container1').scrollLeft);
            document.getElementById('container1').scrollLeft += 250;
        }
        function gvOnHoldEndCallback(s, e) {
            //alert("gvOnHoldEndCallback - > " + hdnRefreshOnHold.Get("RefreshOnHold"));
            if (hdnRefreshOnHold.Get("RefreshOnHold") == "True") {
                schdMechanics.Refresh();
                gvOnHold.Refresh();
                hdnRefreshOnHold.Set("RefreshOnHold", "False");
            }
        }
        function OnResourceGroupListInit(s, e) {
            var keys = s.GetVisibleNodeKeys();
            for (var i = 0; i < keys.length; i++) {
                s.SelectNode(keys[i]);
            }
             schdMechanics.Refresh();
            var currView = schdMechanics.GetActiveViewType();
            if (currView == "Day") {
                var currentInterval = schdMechanics.GetSelectedInterval();
                lblDayOfWeek.SetWidth(70);
                lblDayOfWeek.SetText(getDayOfWeekN(currentInterval.start));
            }
            else {
                lblDayOfWeek.SetText("");
            }
        }
        $(document).ready(function () {
            dateSelector.SetEnabled(false);
            $('.menu .item')
                .tab()
                ; //activate the tabs

            //setTab('DayPlan');
            $('#borderAllApt').hide();
            function setTab(cTab) {
                var tabID = "";
                tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
                var tab;
                (tabID == "") ? tab = cTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
                //console.log("tabID = "+tabID);
                if (tabID == "first") {
                    schdMechanics.Refresh();
                }
                 if (tabID == "second") {
                    SearchAppointments();
                }
            }

            $('.cTab').on('click', function (e) {
                setTab($(this));
            });
		$('#resourceNavigatorBlockShowPopup').live('click', function (e) {
                resourcePopup.Show();
        	});
        });


        function DefaultAppointmentMenuHandler(sch, s, args) {
            if (args.item.GetItemCount() <= 0) {
                if (args.item.name == 'DeleteAppointment') {
                    if (!confirm('Are you sure that you want to delete this appointment?'))
                        return;
                    else {
                         sch.RaiseCallback("MNUAPT|" + args.item.name);
                    }
                }
               
            }
        }

        function onAppointmentDrop(s, e) {
            
            var selectedResource = e.dragInformation[0].newResources;
            //var showMessage = isEdiitngAllowed(e.dragInformation[0].newInterval, s.cpCustomWorkTime[selectedResource]);       
            var showMessage = isEdiitngAllowedLunch(e.dragInformation[0].newInterval, s.cpLunchCustomWorkTime[selectedResource]);
            if (!showMessage) {
                e.handled = true;
                schdMechanics.cpOperation = e.operation;
                //confirmAppointmentDragDialog.Show();  -> To Show the Popup Dialog
                if (confirm('Do you want to plan Overtime?')) {
                    schdMechanics.cpOperation.Apply();
                } else {
                    schdMechanics.cpOperation.Cancel();
                }
            }
        }
        				
        function OnAppointmentResize(s, e) {
            var selectedResource = s.GetSelectedResource();
            //var showMessage = isEdiitngAllowed(e.newInterval, s.cpCustomWorkTime[selectedResource]);
            var showMessage = isEdiitngAllowedLunch(e.newInterval, s.cpLunchCustomWorkTime[selectedResource]);
            if (!showMessage) {
                e.handled = true;
                schdMechanics.cpOperation = e.operation;
                //confirmAppointmentDragDialog.Show(); -> To Show the Popup Dialog
                if (confirm('Do you want to plan Overtime?')) {
                    schdMechanics.cpOperation.Apply();
                } else {
                    schdMechanics.cpOperation.Cancel();
                }
            }
        }
		function OnresourceGroupListEndCallback(s, e) {
            if (s.cpShouldUpdated == true)
                schdMechanics.Refresh();
        }
          //Working for Allowing  LunchHours
        function isEdiitngAllowedLunch(currentInterval, workTimes) {
           // console.log(workTimes);
            var intervalStart = currentInterval.GetStart().getHours() * 60 + currentInterval.GetStart().getMinutes();
            var intervalEnd = currentInterval.GetEnd().getHours() * 60 + currentInterval.GetEnd().getMinutes();
            var dayOfWeek = currentInterval.start.getDay();
            
            for (var i = 0; i < workTimes.length; i++) {
                //debugger;
                if (workTimes[i].StartTime <= intervalStart && workTimes[i].EndTime >= intervalEnd && workTimes[i].DayOfWeek == dayOfWeek) {
                    //debugger;
                    //console.log("if --->" + intervalStart + "-" + intervalEnd + " St - " + workTimes[i].StartTime + " End - " + workTimes[i].EndTime);
                    if (workTimes[i].StartTime == 0 && workTimes[i].EndTime == 0) {
                        return false;
                    } else {
                        return true;
                    }
                }        
            }
            return false;
        }
        function OnSelectionChanging(s, e) {
            
            var currView = schdMechanics.GetActiveViewType();
            if (currView == "Day") {
                var currentInterval = schdMechanics.GetSelectedInterval();
                lblDayOfWeek.SetWidth(70);
                lblDayOfWeek.SetText(getDayOfWeekN(currentInterval.start));

            }
            else {
                lblDayOfWeek.SetWidth(10);
                lblDayOfWeek.SetText("");
            }
        }
        function OnActiveViewChanged(s, e) {
            var currView = schdMechanics.GetActiveViewType();

            if (currView == "Day") {
                var currentInterval = schdMechanics.GetSelectedInterval();
                lblDayOfWeek.SetWidth(70);
                lblDayOfWeek.SetText(getDayOfWeekN(currentInterval.start));
            }
            else {
                //alert("");
                lblDayOfWeek.SetWidth(10);
                lblDayOfWeek.SetText("");
                
            }
        }
        function getDayOfWeek(date) {
            const dayOfWeek = new Date(date).getDay();
            return isNaN(dayOfWeek) ? null :
                ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][dayOfWeek];
        }
        function getDayOfWeekN(date) {
            const dayOfWeek = new Date(date).getDay();
            return isNaN(dayOfWeek) ? null :
                ['søndag', 'mandag', 'tirsdag', 'onsdag', 'torsdag', 'fredag', 'lørdag'][dayOfWeek];
        }
         function OnRadioButtonListValueChanged(s, e) {
            if (s.GetSelectedItem().value == "CreateNewOrder") {
                //cbOrders.PerformCallback("CreateNewOrder");
                //ordersPopup.Hide();
                //$('#lbExiOdr').fadeOut('fast');
                lbOrdersList.SetEnabled(false);
            }
            if (s.GetSelectedItem().value == "ExistingOrder") {
                //cbOrders.PerformCallback("ExistingOrder");
                //$('#lbExiOdr').fadeIn('fast');
                lbOrdersList.SetEnabled(true);
            }
             if (s.GetSelectedItem().value == "CreateNewGotoOrder") {                
                 //cbOrders.PerformCallback("CreateNewGotoOrder");
                //$('#lbExiOdr').fadeOut('fast'); 
                 lbOrdersList.SetEnabled(false);
            }
        }
        function OnOrderListInit(s, e) {
            
            if (rbListOrdersMenu.GetSelectedItem().value == "ExistingOrder") {
                lbOrdersList.SetEnabled(true);
            }
            else {
                lbOrdersList.SetEnabled(false);
            }
            //alert(s.cpRecordExist);
            if (s.cpRecordExist == "YES") {
                lblOrderList.SetText("Existing Records");
            }
            if (s.cpRecordExist == "NO") {
                lblOrderList.SetText("No Records Found");
            }
        }
        function OnOrderOkClick(s, e) {
            //alert(rbListOrdersMenu.GetSelectedItem().value);
            if (rbListOrdersMenu.GetSelectedItem().value == "CreateNewOrder") {
                //alert(1);
                cbOrders.PerformCallback("CREATE_ORDER");
            }
            else if (rbListOrdersMenu.GetSelectedItem().value == "CreateNewGotoOrder") {
                //alert(2);
                cbOrders.PerformCallback("CREATE_ORDER_GOTO");
            }
            else if (rbListOrdersMenu.GetSelectedItem().value == "ExistingOrder") {
                if (lbOrdersList.GetSelectedItem() == null) {
                    alert("Please select one existing Order");
                    return;
                }
                else {
                    cbOrders.PerformCallback("EXISTING_ORDER;" + lbOrdersList.GetSelectedItem().text);
                }
            }
            ordersPopup.Hide();
            //schdMechanics.Refresh();
        }
        function OnOrderListDoubleClick(s, e) {
            cbOrders.PerformCallback("EXISTING_ORDER;" + lbOrdersList.GetSelectedItem().text);
            ordersPopup.Hide();
            //schdMechanics.Refresh();

        }
        function SearchAppointments() {
            if (dateSelector.GetDate() != null) {
                cbAllAptGrid.PerformCallback("FETCH");
            }
            else {
                swal("Velg dato for søk")
            }
            
        }
        function OncbAllAptGridEndCallback(s, e) {
            if (gvAllAppointments.GetVisibleRowsOnPage() > 0) {
                gvAllAppointments.SetClientVisible(true);
                $('#borderAllApt').show();
            }
            else {
                gvAllAppointments.SetClientVisible(false);
                $('#borderAllApt').hide();
            }
            '<%HttpContext.Current.Session("isExtOpenApt") = "no" %>';
            console.log(s.cpIsExtNewOpen);
            console.log(s.cpExtApptId);
            if (s.cpIsExtNewOpen != undefined && s.cpIsExtNewOpen != null) {
                if (s.cpIsExtNewOpen == true) {
                    var aptId = s.cpExtApptId;
                    schdMechanics.SelectAppointmentById(aptId);
                    schdMechanics.ShowAppointmentFormByServerId(aptId);
                }
            }

            if (s.cpDelRetVal != undefined && s.cpDelRetVal != null) {
                if (s.cpDelRetVal != "") {
                    if (s.cpDelRetVal == "DELETED") {
                        systemMSG('success', 'Sucessfully deleted appointment', 6000);
                    }
                    else {
                        systemMSG('error', 'Error while deleting appointment', 6000);
                    }
                }
            }
            schdMechanics.Refresh();
        }
        function OngvAllAptContextMenuItemClick(s, e) {
            console.log(e);
            switch (e.item.name) {
                case 'OpenApt':
                    $(document.getElementById('<%=hdnIsOpnAptExtClicked.ClientID%>')).val("yes");
                    var aptId = gvAllAppointments.GetRowKey(e.elementIndex).toString();
                    //swal(aptId);
                    cbAllAptGrid.PerformCallback("OpenApt;" + aptId);
                    //schdMechanics.SelectAppointmentById(aptId);
                    //schdMechanics.ShowAppointmentFormByServerId(aptId);
                    setTabExp('DayPlan');
                    break;
                case 'OpenAptOrder':
                    $(document.getElementById('<%=hdnIsOpnAptExtClicked.ClientID%>')).val("no");
                    var orderNo = gvAllAppointments.batchEditApi.GetCellValue(e.elementIndex, "WO_NUMBER")
                    if (orderNo != undefined && orderNo != null && orderNo != "") {
                        cbAllAptGrid.PerformCallback("OpenAptOrder;" + e.elementIndex);
                    }
                    else {
                        swal("Appointment not yet converted to order");
                    }
                    break;
                case 'TransferAptOrder':
                    var aptId = gvAllAppointments.GetRowKey(e.elementIndex).toString();
                    schdMechanics.SelectAppointmentById(aptId);
                    setTabExp('DayPlan');
                    cbOrders.PerformCallback("FETCH");
                    ordersPopup.Show();
                    break;
                case 'DeleteAptExt':
                    if (confirm('Do you really want to delete this appointment?')) {
                        var aptId = gvAllAppointments.GetRowKey(e.elementIndex).toString();
                        cbAllAptGrid.PerformCallback("DeleteAptExt;" + aptId);
                    } else {
                        return;
                    }
                    break;
            }
        }
        function OngvAllAptContextMenu(s, e) {
            if (e.objectType == "row") {
                var menuOpenAptOrder = e.menu.GetItemByName("OpenAptOrder");
                var menuTransferAptOrder = e.menu.GetItemByName("TransferAptOrder");
                var orderNo = gvAllAppointments.batchEditApi.GetCellValue(e.index, "WO_NUMBER")
                if (orderNo != undefined && orderNo != null && orderNo != "") {
                    menuOpenAptOrder.SetEnabled(true);
                    menuTransferAptOrder.SetEnabled(false);
                }
                else {
                    menuOpenAptOrder.SetEnabled(false);
                    menuTransferAptOrder.SetEnabled(true);
                }
            }
        }
        function setTabExp(tabID) {
            $('#tabDayPlan').removeClass('active'); //To hide all the available tabs in page . 
            $('#tabAllAppointment').removeClass('active');
            //$('#tabWebAppointment').removeClass('active');
            //Need to remove class active for new tab if added any . 
            $('#tab' + tabID).addClass('active'); // Shows target tab and sets active class

            $('.cTab').removeClass('active'); // Removes the active class for all 
            $("#btn" + tabID).addClass('active'); // Sets active to clicked or active tab

        }
        function OncbOrdersEndCallback(s, e) {
            schdMechanics.Refresh();
            if (dateSelector.GetDate() != null) {
                cbAllAptGrid.PerformCallback("FETCH");
            }
        }
        function OnHistoryChkChanged() {
            //console.log($("#<%=chkhistoryApt.ClientID%>").is(':checked'));
            if ($("#<%=chkhistoryApt.ClientID%>").is(':checked')) {
                dateSelector.SetEnabled(true);
                dateSelector.SetValue(null);
                }
            else {
                var today = new Date();
                dateSelector.SetEnabled(false);
                dateSelector.SetDate(today);
                }
        }
        </script>
    
    <div>
        <asp:HiddenField ID="hdCopiedAppointmentID" runat="server" />
        <asp:HiddenField ID="hdType" runat="server" />
        <asp:HiddenField ID="hdnIsOpnAptExtClicked" runat="server" />
        <div id="systemMessage" class="ui message"></div>
    </div>
   
    <div class="ui one column grid">
        <div class="stretched row">
            <div class="sixteen wide column">
                <div class="ui top attached tabular menu">
                    <a class="cTab item active" data-tab="first" id="btnDayPlan">Day Plan</a>
                    <a class="cTab item" data-tab="second" id="btnAllAppointment">All Appointments</a>
                    <%--<a class="cTab item" data-tab="third" id="btnWebAppointment">Web Appointment</a>--%>
                </div>
                <%--########################################## DayPlan ##########################################--%>
                <div class="ui bottom attached tab segment active" data-tab="first" id="tabDayPlan">
                    <div>
                        <div>
                            <div class="sixteen wide column">
    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15); overflow-y: hidden;" id="container1">
        <%--Newly Added--%>
        <div>
        <dx:ASPxPopupControl ID="resourcePopup" runat="server" ClientInstanceName="resourcePopup" PopupHorizontalAlign="Center" ShowHeader="false" PopupVerticalAlign="Middle" Top="160" Left="200" AllowDragging="True">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <dx:ASPxHiddenField runat="server" ID="LastSelectedNodeKey" ClientInstanceName="LastSelectedNodeKey"></dx:ASPxHiddenField>
                    <dxtl:ASPxTreeList ID="resourceGroupList" runat="server" SettingsSearchPanel-Visible="true" ClientInstanceName="resourceGroupList" OnHtmlRowPrepared="resourceGroupList_HtmlRowPrepared" OnSelectionChanged="resourceGroupList_SelectionChanged" DataSourceID="resourceTreeListDataSource" SettingsBehavior-AllowFocusedNode="true" SettingsBehavior-FocusNodeOnLoad="true" ParentFieldName="PARENTRESID" KeyFieldName="ResID" Width="200px" AutoGenerateColumns="false" Theme="Office365">
                        <ClientSideEvents SelectionChanged="OnFilterScheduler" Init="OnResourceGroupListInit" EndCallback="OnresourceGroupListEndCallback"/>
                        <Columns>
                            <dxtl:TreeListDataColumn FieldName="ResID" Caption="Resource" Visible="false"></dxtl:TreeListDataColumn>
                            <dxtl:TreeListDataColumn FieldName="Name" Caption="All Mechanic"></dxtl:TreeListDataColumn>
                            <dxtl:TreeListDataColumn FieldName="MECHANIC_TYPE" Caption="MECHANIC_TYPE" Visible="false"></dxtl:TreeListDataColumn>
                        </Columns>
                        <SettingsBehavior AutoExpandAllNodes="True" />
                        <SettingsSelection Enabled="True" Recursive="True" AllowSelectAll="true" />
                    </dxtl:ASPxTreeList>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

        <%--Newly Added--%>
                                        <div style="display: flex; justify-content: center; position: static;" id="container2">

                <div>
                    <dxwschs:ASPxViewNavigator ID="customViewNav" runat="server" MasterControlID="schdMechanics"></dxwschs:ASPxViewNavigator>
                </div>

                                            <div style="text-align: center; padding-right: 5px">
                    <dx:ASPxLabel ID="lblDayOfWeek" ClientInstanceName="lblDayOfWeek" Font-Size="Medium" runat="server"></dx:ASPxLabel>
                </div>

                <div>
                    <dxwschs:ASPxViewVisibleInterval ID="customVisibleInterval" MasterControlID="schdMechanics" runat="server"></dxwschs:ASPxViewVisibleInterval>
                </div>

            </div>
           <%-- <div class="ui form stackable three column grid " >
                <div class="seven wide column">
                    <div title="Show resources filter window" class="dxscResourceNavigatorButton_Office365 dxsc-filter-button dxbButtonSys" id="resourceNavigatorBlockShowPopup" style="user-select: none; width: 12px; height: 13px;">
                        <div style="font-size: 0px; padding-top: 0px; padding-bottom: 0px;" id="ctl00_cntMainPanel_schdMechanics_resourceNavigatorBlock_ctl00_ShowPopup_CD" class="">
                            <div class="dxb-hbc">
                                <input id="ctl00_cntMainPanel_schdMechanics_resourceNavigatorBlock_ctl00_ShowPopup_I" title="Show resources filter window" class="dxb-hb" value="submit" type="button" name="ctl00$cntMainPanel$schdMechanics$resourceNavigatorBlock$ctl00$ShowPopup" />
                            </div>
                            <img class="dxScheduler_ResourceNavigator_Filter_Office365 dx-vam" src="/DXR.axd?r=1_90-CmEVl" alt="" id="ctl00_cntMainPanel_schdMechanics_resourceNavigatorBlock_ctl00_ShowPopupImg" />
                        </div>
                    </div>
                </div>

                <div class="seven wide column" style="display: flex;">
                    <div>
                        <dxwschs:ASPxViewNavigator ID="customViewNav" runat="server" MasterControlID="schdMechanics"></dxwschs:ASPxViewNavigator>
                    </div>
                    <div>
                        <dx:ASPxLabel ID="lblDayOfWeek" ClientInstanceName="lblDayOfWeek" Font-Size="Small" runat="server"></dx:ASPxLabel>
                    </div>
                    <div>
                        <dxwschs:ASPxViewVisibleInterval ID="customVisibleInterval"  MasterControlID="schdMechanics" runat="server"></dxwschs:ASPxViewVisibleInterval>
                    </div>
                </div>
            
                <div class="one wide column">
                    <dxwschs:ASPxViewSelector ID="customViewSelector" MasterControlID="schdMechanics"  runat="server"></dxwschs:ASPxViewSelector>
                </div>
            </div>--%>
            <p></p>
        <div style="position: relative; height: 700px; display: flex;">
             <div>
                <dx:ASPxCallback ID="cbJobStatus" ClientInstanceName="cbJobStatus" runat="server" OnCallback="cbJobStatus_Callback"></dx:ASPxCallback>
                 <dxwschs:ASPxScheduler ID="schdMechanics" OnAppointmentFormShowing="schdMechanics_AppointmentFormShowing" OnInitNewAppointment="schdMechanics_InitNewAppointment" Width="100%" OnInitAppointmentDisplayText="schdMechanics_InitAppointmentDisplayText" ClientInstanceName="schdMechanics" OnPopupMenuShowing="schedulerDayPlan_PopupMenuShowing" Storage-Appointments-AutoRetrieveId="true" GroupType="Resource" runat="server" Theme="Office365"
                     AppointmentDataSourceID="appointmentDataSource" Styles-PopupForm-CloseButton-CssClass="closeButtonDisplay" OnCustomJSProperties="schdMechanics_CustomJSProperties" OnHtmlTimeCellPrepared="schdMechanics_HtmlTimeCellPrepared" ResourceDataSourceID="resourceDataSource" ClientIDMode="AutoID" OnBeforeExecuteCallbackCommand="schdMechanics_BeforeExecuteCallbackCommand"
                     OnAppointmentRowInserted="schdMechanics_AppointmentRowInserted" ResourceNavigator-Mode="Tokens" OnFilterResource="schdMechanics_FilterResource" ResourceNavigator-Visibility="Never" OnAfterExecuteCallbackCommand="schdMechanics_AfterExecuteCallbackCommand" OnInitClientAppointment="schdMechanics_InitClientAppointment" OnAppointmentChanging="schdMechanics_AppointmentChanging" OnCustomCallback="schdMechanics_CustomCallback">
                     <OptionsToolTips AppointmentToolTipUrl="../CustomTemplates/CustomToolTip.ascx" AppointmentToolTipCornerType="Square" AppointmentToolTipMode="InfoSheet" ShowSelectionToolTip="false"  />
                        <OptionsBehavior ShowFloatingActionButton="false" ShowViewNavigator="false" ShowViewVisibleInterval="false"/>
                                          
                     <Styles>
                         <HorizontalResourceHeader BackColor="White" ForeColor="Black"></HorizontalResourceHeader>
                     </Styles>
					 <OptionsCustomization AllowInplaceEditor="None" />
                     <ClientSideEvents
                         EndCallback="OnEndCallBack" SelectionChanged="OnSelectionChanging" MenuItemClicked="OnMenuItemClicked"
                         AppointmentDrag="onAppointmentDrag" AppointmentDrop="onAppointmentDrop"
                         AppointmentResizing="onAppointmentResizing" AppointmentDeleting="OnAppointmentDeleting" ActiveViewChanged="OnActiveViewChanged"
						  AppointmentResize="OnAppointmentResize" />
                     <Templates>
                         <ToolbarViewNavigatorTemplate>
                                <div style="align-self: center;display: flex;">
                                    <div>
                                 <div title="Show resources filter window" class="dxscResourceNavigatorButton_Office365 dxsc-filter-button dxbButtonSys" id="resourceNavigatorBlockShowPopup" style="user-select: none; width: 12px; height: 13px;">
                                     <div style="font-size: 0px; padding-top: 0px; padding-bottom: 0px;" id="ctl00_cntMainPanel_schdMechanics_resourceNavigatorBlock_ctl00_ShowPopup_CD" class="">
                                     <div class="dxb-hbc">
                                             <input id="ctl00_cntMainPanel_schdMechanics_resourceNavigatorBlock_ctl00_ShowPopup_I" title="Show resources filter window" class="dxb-hb" value="submit" type="button" name="ctl00$cntMainPanel$schdMechanics$resourceNavigatorBlock$ctl00$ShowPopup">
                                     </div>
                                         <img class="dxScheduler_ResourceNavigator_Filter_Office365 dx-vam" src="/DXR.axd?r=1_90-CmEVl" alt="" id="ctl00_cntMainPanel_schdMechanics_resourceNavigatorBlock_ctl00_ShowPopupImg">
                                 </div>
                             </div>
                                    </div>
                                    <%--<div> 
                                 
                                     <dxwschs:ASPxViewNavigator ID="customViewNav" runat="server" MasterControlID="schdMechanics"></dxwschs:ASPxViewNavigator>
                                 </div>
                                <div style="align-self: center; text-align: center;">
                                    <dx:ASPxLabel ID="lblDayOfWeek" ClientInstanceName="lblDayOfWeek"  Font-Size="Medium" runat="server"></dx:ASPxLabel>
                                    </div>--%>
                            </div>
                         </ToolbarViewNavigatorTemplate>
                     </Templates>
                     <Storage>
                         <Appointments ResourceSharing="true">
                             <Mappings AppointmentId="Id" Start="StartTime" End="EndTime" Subject="Subject" AllDay="AllDay" Description="Description" Label="Label" Location="Location"
                                 RecurrenceInfo="RecurrenceInfo" ReminderInfo="ReminderInfo" Status="Status" Type="EventType" ResourceId="OwnerId" />
                             <CustomFieldMappings>
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomCustomerNumber" Name="ApptCustomerNumber" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomCustomerFirm" Name="ApptCustomerFirm" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomFirstName" Name="ApptFirstName" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomMiddleName" Name="ApptMiddleName" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomLastName" Name="ApptLastName" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomInfo" Name="ApptCustomInfo" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehicleRegNo" Name="ApptVehicleRegNo" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehicleRefNo" Name="ApptVehicleRefNo" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehicleChNo" Name="ApptVehicleChNo" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehicleId" Name="ApptCustomVehicleNo" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehicleRentalCar" Name="ApptVehicleRentalCar" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehiclePerService" Name="ApptVehiclePerService" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehiclePerCheck" Name="ApptVehiclePerCheck" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehicleMake" Name="ApptVehicleMake" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomVehicleModel" Name="ApptVehicleModel" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="WONONum" Name="ApptWONONumInfo" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="IsOverTime" Name="ApptIsOverTime" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="TooltipDisplayData" Name="ApptTooltipDisplayData" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="AptNumberDisplayData" Name="ApptAptNumberDisplayData" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="IsOrder" Name="ApptIsOrder" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="AppointmentDetId" Name="ApptAppointmentDetId" ValueType="String" />
                                 <dxwschs:ASPxAppointmentCustomFieldMapping Member="WOPrefix" Name="ApptWOPrefixInfo" ValueType="String" />
                             </CustomFieldMappings>
                         </Appointments>

                         <Resources Mappings-ResourceId="ResID" Mappings-Caption="Name">
                             <CustomFieldMappings>
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="LUNCH_FROM_TIME" Name="LUNCH_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="LUNCH_TO_TIME" Name="LUNCH_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="STANDARD_FROM_TIME" Name="STANDARD_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="STANDARD_TO_TIME" Name="STANDARD_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="MONDAY_FROM_TIME" Name="MONDAY_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="MONDAY_TO_TIME" Name="MONDAY_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="TUESDAY_FROM_TIME" Name="TUESDAY_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="TUESDAY_TO_TIME" Name="TUESDAY_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="WEDNESDAY_FROM_TIME" Name="WEDNESDAY_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="WEDNESDAY_TO_TIME" Name="WEDNESDAY_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="THURSDAY_FROM_TIME" Name="THURSDAY_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="THURSDAY_TO_TIME" Name="THURSDAY_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="FRIDAY_FROM_TIME" Name="FRIDAY_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="FRIDAY_TO_TIME" Name="FRIDAY_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="SATURDAY_FROM_TIME" Name="SATURDAY_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="SATURDAY_TO_TIME" Name="SATURDAY_TO_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="SUNDAY_FROM_TIME" Name="SUNDAY_FROM_TIME" />
                                 <dxwschs:ASPxResourceCustomFieldMapping ValueType="DateTime" Member="SUNDAY_TO_TIME" Name="SUNDAY_TO_TIME" />
                             </CustomFieldMappings>
                         </Resources>
                     </Storage>
                     <Views>
                         <DayView ShowDayHeaders="false" NavigationButtonVisibility="Never">
                             <Templates>
                                 <VerticalAppointmentTemplate>
                                    <dx:ASPxPanel runat="server" ID="panel1" OnInit="panel1_Init" CssClass="container1">
                                         <PanelCollection>
                                             <dx:PanelContent>
                                                 <dx:ASPxPanel ID="status" runat="server" BackColor="YellowGreen" OnInit="panel2_Init" CssClass="statusContainer"></dx:ASPxPanel>
                                                <div class="content1">
                                                     <div class="first"></div>
                                                     <div class="Aptcenter">
                                                         <dx:ASPxLabel runat="server" ID="SubjectLbl" OnInit="SubjectLbl_Init" ></dx:ASPxLabel>
                                                     </div>
                                                    <div class="last"></div>
                                                 </div>
                                             </dx:PanelContent>
                                         </PanelCollection>
                                     </dx:ASPxPanel>
                                 </VerticalAppointmentTemplate>
                             </Templates>
                         </DayView>
                         <WeekView Enabled="false" NavigationButtonVisibility="Never"></WeekView>
                         <MonthView Enabled="true"></MonthView>
                         <AgendaView Enabled="false"></AgendaView>
                         <TimelineView Enabled="false"></TimelineView>
                     </Views>
                     <OptionsForms AppointmentFormTemplateUrl="../CustomTemplates/AppointmentForm.ascx" />
                     <Styles>
                        <%--<Appointment CssClass="customAppt" />--%>
                     </Styles>

                     
                 </dxwschs:ASPxScheduler>
                 <dx:ASPxHiddenField ID="hdnRefreshSch" ClientInstanceName="hdnRefreshSch" runat="server"></dx:ASPxHiddenField>
                    <dx:ASPxHiddenField ID="hdnRefreshOnHold" ClientInstanceName="hdnRefreshOnHold" runat="server"></dx:ASPxHiddenField>
                    <dx:ASPxHiddenField ID="hdnAddNewRow" ClientInstanceName="hdnAddNewRow" runat="server"></dx:ASPxHiddenField>
             </div>
            <div>
                <dx:ASPxPanel ID="ASPxPanel1" Collapsible="true" runat="server" Theme="Office365" ClientSideEvents-Expanded="OnExpanded">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxGridView ID="gvOnHold" runat="server" Theme="Office365" SettingsBehavior-AllowSort="false"  OnCustomCallback="gvOnHold_CustomCallback" OnHtmlRowPrepared="gvOnHold_HtmlRowPrepared" AutoGenerateColumns="false" KeyFieldName="ID_APPOINTMENT_DETAILS" ClientInstanceName="gvOnHold">
                                <ClientSideEvents EndCallback="gvOnHoldEndCallback" />
                                <Columns>
                                    <%--<dx:GridViewDataTextColumn FieldName="APPOINTMENT_NO" Caption="Apt.No."></dx:GridViewDataTextColumn>--%>
                                    <dx:GridViewDataTextColumn FieldName="VEHICLE_REG_NO" Caption="Reg.No." ></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="RESERVATION" Caption="Reservation" ></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID_APPOINTMENT_DETAILS" Visible="false" Caption="Apt Dtl" >
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <Styles>
                                    <Row CssClass="draggableGrid"></Row>
                                </Styles>
                            </dx:ASPxGridView>
                        </dx:PanelContent>
                    </PanelCollection>
                    <SettingsCollapsing ExpandEffect="Slide" ExpandButton-Position="Center" ExpandButton-Visible="true" ExpandButton-GlyphType="ArrowRight" AnimationType="Slide"></SettingsCollapsing>

                </dx:ASPxPanel>
         </div>
     </div>  

        </div>
    </div>
    <dx:ASPxGlobalEvents ID="ge" runat="server">
        <ClientSideEvents ControlsInitialized="InitalizejQuery" EndCallback="InitalizejQuery" />
    </dx:ASPxGlobalEvents>
    <asp:ObjectDataSource ID="resourceDataSource" runat="server" SelectMethod="SelectMethodHandler" TypeName="CARS.CoreLibrary.CustomEventsData.CustomResourceDataSource" OnObjectCreated="resourceDataSource_ObjectCreated"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="appointmentDataSource" runat="server" DataObjectTypeName="CARS.CoreLibrary.CustomEventsData.CustomEvent" TypeName="CARS.CoreLibrary.CustomEventsData.CustomEventDataSource"  SelectMethod="SelectMethodHandler"
        OnObjectCreated="appointmentDataSource_ObjectCreated" InsertMethod="InsertMethodHandler" UpdateMethod="UpdateMethodHandler" DeleteMethod="DeleteMethodHandler"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="resourceTreeListDataSource" runat="server" SelectMethod="SelectMethodHandler" TypeName="CARS.CoreLibrary.CustomEventsData.CustomTreeListResourceDataSource" OnObjectCreated="resourceTreeListDataSource_ObjectCreated"></asp:ObjectDataSource>

    <dx:ASPxPopupControl runat="server" CloseAction="CloseButton"  ClientInstanceName="existOrdersPopup"  ID="existOrdersPopup" ShowFooter="true" FooterStyle-BackColor="White" HeaderStyle-BackColor="White" HeaderText="ExisitingOrders"  HeaderStyle-HorizontalAlign="Center" CloseOnEscape="true" Height="250px" Left="500" Width="500px" Modal="True" Top="250" Theme="iOS" AllowDragging="True">
              
         <FooterStyle BackColor="White"></FooterStyle>
                 <HeaderStyle HorizontalAlign="Center" BackColor="White"></HeaderStyle>
         <ContentCollection>
             <dx:PopupControlContentControl runat="server">
                 <div class="ui small info message">
                    <dx:ASPxLabel ID="lblHeader" runat="server" ClientInstanceName="lblHeader"></dx:ASPxLabel>
                 </div>
                 <dx:ASPxCallbackPanel ID="cbOrderList" ClientInstanceName="cbOrderList" runat="server" OnCallback="cbOrderList_Callback" OnEndCallBack="OncbOrderEndCallback">
                     <PanelCollection>
                         <dx:PanelContent runat="server">
                             <div>
                                 <dx:ASPxListBox ID="lbExisOrders" ClientInstanceName="lbExisOrders" runat="server" ValueType="System.String" OnCustomJSProperties="lbExisOrders_CustomJSProperties" Width="100%" ItemStyle-Height="1%" Height="200px" ItemStyle-HoverStyle-BackColor="SkyBlue" CssClass="customTimeEdit" CaptionCellStyle-Height="2px">
                                     <ClientSideEvents SelectedIndexChanged="SelectedIndexChanged" Init="OnInit"/>
                                     <Columns>
                                         <dx:ListBoxColumn FieldName="ID_WO_NO" Width="10%" Caption="WO NO" />
                                         <dx:ListBoxColumn FieldName="ID_WO_PREFIX" Width="10%" Caption="Prefix" />
                                         <dx:ListBoxColumn FieldName="WO_STATUS" Width="10%" />
                                         <dx:ListBoxColumn FieldName="ID_CUST_WO" Width="10%" />
                                         <dx:ListBoxColumn FieldName="WO_CUST_NAME" Width="10%" />
                                     </Columns>
                                 </dx:ASPxListBox>

                             </div>
                         </dx:PanelContent>
                     </PanelCollection>
                 </dx:ASPxCallbackPanel>
                 <div>
                     <%-- <dx:ASPxButton runat="server" ID="btnSave" OnClick="btnSave_Click" ClientInstanceName="btnSave" CssClass="ui approve success button" Text="Save" Height="10%" AutoPostBack="False" Style="float: left;"></dx:ASPxButton>--%>
                 </div>

             </dx:PopupControlContentControl>
         </ContentCollection>                 
            </dx:ASPxPopupControl>

    <dx:ASPxPopupControl runat="server" CloseAction="CloseButton" ClientInstanceName="popupOnHoldApp" ID="popupOnHoldApp" HeaderStyle-BackColor="White" HeaderText="On Hold Appointment" HeaderStyle-HorizontalAlign="Center" CloseOnEscape="true" Height="400px" Left="500" Width="600px" Modal="True" Top="260" Theme="iOS" AllowDragging="True">
        <HeaderStyle HorizontalAlign="Center" BackColor="White"></HeaderStyle>
        <ContentCollection>
            <dx:PopupControlContentControl runat="server"> 
                <div>
                    <dx:ASPxCallbackPanel ID="cbOnHoldList" ClientInstanceName="cbOnHoldList" OnCallback="cbOnHoldList_Callback" runat="server" ClientSideEvents-EndCallback="OnListBoxEndCallback">

                        <ClientSideEvents EndCallback="OnListBoxEndCallback"></ClientSideEvents>

                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <dx:ASPxListBox ID="lbOnHoldApp" ClientInstanceName="lbOnHoldApp" runat="server" ValueType="System.String" Width="100%" ItemStyle-Height="1%" Height="150px" ItemStyle-HoverStyle-BackColor="SkyBlue" CssClass="customTimeEdit" CaptionCellStyle-Height="2px">
                                    <ClientSideEvents SelectedIndexChanged="lbOnHoldAppSelectedIndexChanged" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="ID_APPOINTMENT_DETAILS" Width="8%" Caption="Details ID" ClientVisible="false" />
                                        <dx:ListBoxColumn FieldName="START_DATE" Width="12%" Caption="Start Time" />
                                        <dx:ListBoxColumn FieldName="END_DATE" Width="12%" Caption="End Time" />
                                        <dx:ListBoxColumn FieldName="RESERVATION" Width="10%" Caption="Reservation" />
                                        <dx:ListBoxColumn FieldName="APPOINTMENT_ID" Width="8%" Caption="AppointmentID" />
                                        <dx:ListBoxColumn FieldName="RESOURCE_ID" Width="10%" />
                                        <dx:ListBoxColumn FieldName="WONO" />
                                    </Columns>

                                    <ItemStyle Height="1%">
                                        <HoverStyle BackColor="SkyBlue"></HoverStyle>
                                    </ItemStyle>

                                    <CaptionCellStyle Height="2px"></CaptionCellStyle>
                                </dx:ASPxListBox>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                </div>
                
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
  
    <dx:ASPxPopupControl runat="server" CloseAction="CloseButton" ClientInstanceName="ordersPopup" ID="ordersPopup" HeaderStyle-BackColor="White" HeaderText="Transfer To Order" HeaderStyle-HorizontalAlign="Center" CloseOnEscape="true" ShowFooter="true" Height="600px" Left="500" Width="900px" Modal="True" Top="180" Theme="Office365" AllowDragging="True">
        <HeaderStyle HorizontalAlign="Center" BackColor="White"></HeaderStyle>
       
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                                            <div style="display: flex">
                                                <div style="width: 28%">
                    <div class="ui small info message">
                    <dx:ASPxLabel ID="lbChooseAction" ClientInstanceName="lbChooseAction" Text="Choose Action" runat="server"></dx:ASPxLabel>
                        </div>
                    <dx:ASPxRadioButtonList ID="rbListOrdersMenu" ClientSideEvents-ValueChanged="OnRadioButtonListValueChanged" Font-Size="Small" OnInit="rbListOrdersMenu_Init" runat="server" ClientInstanceName="rbListOrdersMenu">
                    </dx:ASPxRadioButtonList>
                </div>
                                                <div style="width: 2%">
                        <p></p>
                        </div>
                    <div id="lbExiOdr" style="width: 70%">
                                                    <dx:ASPxCallbackPanel ID="cbOrders" ClientInstanceName="cbOrders" runat="server" ClientSideEvents-EndCallback="OncbOrdersEndCallback" OnCallback="cbOrders_Callback">
                            <PanelCollection>
                                <dx:PanelContent>
                                    <div class="ui small info message">
                                        <dx:ASPxLabel ID="lblOrderList" runat="server" ClientInstanceName="lblOrderList"></dx:ASPxLabel>
                                    </div>
                                    <dx:ASPxListBox ID="lbOrdersList" ClientInstanceName="lbOrdersList" runat="server" ValueType="System.String" Width="100%" ItemStyle-Height="1%" Height="400px" ItemStyle-HoverStyle-BackColor="SkyBlue" CssClass="customTimeEdit" CaptionCellStyle-Height="2px">
                                         <%--SelectedIndexChanged="SelectedIndexChanged"--%>
                                         <ClientSideEvents Init="OnOrderListInit" ItemDoubleClick="OnOrderListDoubleClick"/>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="ID_WO_PREFIX" Width="8%" Caption="Prefix" />
                                            <dx:ListBoxColumn FieldName="ID_WO_NO" Width="10%" Caption="WO No" />
                                            <dx:ListBoxColumn FieldName="WO_STATUS" Width="10%" Caption="WO Status" />
                                            <dx:ListBoxColumn FieldName="ID_CUST_WO" Width="10%" Caption="Customer ID" />
                                            <dx:ListBoxColumn FieldName="WO_CUST_NAME" Width="12%" Caption="Customer Name" />
                                        </Columns>
                                    </dx:ASPxListBox>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                    </div>
            </dx:PopupControlContentControl>

        </ContentCollection>
        <FooterContentTemplate>

                    <div style="float: right;">
                        <dx:ASPxButton ID="btnOk" runat="server" CssClass="ui approve success button" Text="Ok" Height="10%" AutoPostBack="False" Style="float: left;">
                            <ClientSideEvents Click="OnOrderOkClick" />
                        </dx:ASPxButton>
                        <dx:ASPxButton ID="btCancel" runat="server" CssClass="ui cancel button" Text="Cancel" Height="10%" AutoPostBack="False" Style="float: left;">
                            <ClientSideEvents Click="function(s, e) { ordersPopup.Hide(); }" />
                        </dx:ASPxButton>

                    </div>

                </FooterContentTemplate>
    </dx:ASPxPopupControl>
                            </div>
                        </div>
                    </div>
                </div>
                <%--########################################## All Appointment ##########################################--%>
                <div class="ui bottom attached tab segment" data-tab="second"  id="tabAllAppointment">
                    <div>
                        <div id="divAllAppo" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblAllApp" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">AVTALER</h3>
                            <div style="display: flex">
                                <%--class="ui form stackable two column grid "--%>
                                <div style="width: 18%">
                                    <%--class="three wide column"--%>
                                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <h3 id="lblAptSearch" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Search</h3>

                                        <div class="searchvalues-container">
                                            <p></p>

                                            <div class="fields" style="display: flex">
                                                <div class="tewelve wide field" style="width: 90%">
                                                    <asp:Label ID="lblSelDate" runat="server" Text="Date"></asp:Label>
                                                    <dx:ASPxDateEdit runat="server" ID="dateSelector" Theme="Office2010Blue" ClientInstanceName="dateSelector" Width="80%" Font-Size="Small" CssClass="customComboBox">
                                                    </dx:ASPxDateEdit>
                                                </div>

                                            </div>
                                            <p></p>
                                            <div class="fields" style="display: flex">
                                                <div class="eight wide field" style="width: 70%">
                                                    <div class="ui toggle checkbox">
                                                        <input id="chkhistoryApt" runat="server" type="checkbox" name="public" onclick="OnHistoryChkChanged()"/>
                                                        <label>History</label>
                                                    </div>
                                                </div>
                                                <div class="six wide field" style="width: 30%">
                                                    <input type="button" id="btnSearchApt" runat="server" value="Search" class="ui btn" onclick="SearchAppointments()" />
                                                </div>
                                            </div>

                                            <p></p>
                                            <p></p>
                                        </div>
                                    </div>
                                </div>
                                <div style="width: 2%"></div>
                                <%--GridView to List up all appointments--%>
                                <div style="width: 80%">
                                    <%--class="thirteen wide column"--%>
                                    <div class="ui raised segment" id="borderAllApt" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <dx:ASPxCallbackPanel ID="cbAllAptGrid" ClientInstanceName="cbAllAptGrid" runat="server" OnCallback="cbAllAptGrid_Callback">
                                            <ClientSideEvents EndCallback="OncbAllAptGridEndCallback" />
                                            <PanelCollection>
                                                <dx:PanelContent runat="server">
                                                    <div>
                                                        <dx:ASPxGridView ID="gvAllAppointments" ClientInstanceName="gvAllAppointments" runat="server" ClientVisible="false" OnContextMenuInitialize="gvAllAppointments_ContextMenuInitialize" Theme="Office2010Blue" KeyFieldName="APPOINTMENT_ID" Width="100%">
                                                            <ClientSideEvents ContextMenuItemClick="OngvAllAptContextMenuItemClick" ContextMenu="OngvAllAptContextMenu" />
                                                            <SettingsPager PageSize="15">
                                                                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                                                            </SettingsPager>
                                                            <SettingsEditing Mode="Batch"></SettingsEditing>
                                                            <SettingsContextMenu Enabled="true"></SettingsContextMenu>
                                                            <SettingsSearchPanel Visible="true" />
                                                            <Settings ShowPreview="false" ShowStatusBar="Hidden" />
                                                            <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" />
                                                            <Styles>
                                                                <FocusedRow BackColor="#d6eef2" ForeColor="Black"></FocusedRow>
                                                            </Styles>
                                                            <SettingsPopup>
                                                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                            </SettingsPopup>
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn FieldName="APT_ID_DIS" Caption="ID" Visible="true" ReadOnly="true" Width="7%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="APPOINTMENT_STATUS_CODE" Caption="Status" Visible="true" ReadOnly="true" Width="7%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="MECHANIC NAME" Caption="Mechanic" ReadOnly="true" Width="15%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataDateColumn FieldName="START_DATE" Caption="Start Date" ReadOnly="true" Width="8%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataTimeEditColumn FieldName="START_TIME" ReadOnly="true" Width="3%" Caption="Time">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                    <PropertiesTimeEdit DisplayFormatString="HH:mm"></PropertiesTimeEdit>
                                                                </dx:GridViewDataTimeEditColumn>
                                                                <dx:GridViewDataDateColumn FieldName="END_DATE" Caption="End Date" ReadOnly="true" Width="8%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataTimeEditColumn FieldName="END_TIME" ReadOnly="true" Width="3%" Caption="Time">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                    <PropertiesTimeEdit DisplayFormatString="HH:mm"></PropertiesTimeEdit>
                                                                </dx:GridViewDataTimeEditColumn>
                                                                <dx:GridViewDataTextColumn FieldName="CUSTOMER_FULL_NAME" Caption="Customer" ReadOnly="true" Width="15%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VEHICLE_REF_NO" ReadOnly="true" Caption="Ref No." Width="8%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VEHICLE_REG_NO" ReadOnly="true" Caption="Reg No." Width="8%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="VEHICLE" ReadOnly="true" Caption="Vehicle" Width="14%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="WO_NUMBER" ReadOnly="true" Caption="Order No." Width="6%">
                                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ID_WO_PREFIX" ReadOnly="true" Visible="false"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ID_WO_NO" ReadOnly="true" Visible="false"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ID_APT_DTL" ReadOnly="true" Visible="false"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ID_APT_HDR" ReadOnly="true" Visible="false"></dx:GridViewDataTextColumn>
                                                            </Columns>
                                                        </dx:ASPxGridView>
                                                    </div>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </div>
                                </div>
                            </div>
                            <div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--########################################## Web Appointment ##########################################--%>
                <%--<div class="ui bottom attached tab segment" data-tab="third"  id="tabWebAppointment">
                    <div>
                        <div id="divWebAppo" class="ui raised segment signup inactive" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                            <h3 id="lblWebApp" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">BOOKING FROM BILXTRAVERKSTED.NO</h3>

                            <div>
                            </div>
                        </div>

                    </div>
                </div>--%>
            </div>
        </div>
    </div>
    
</asp:Content>
