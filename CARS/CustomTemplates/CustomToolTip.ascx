<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CustomToolTip.ascx.vb" Inherits="CARS.CustomToolTip" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<div runat="server" id="buttonDiv">

    <div class="cToolTipContainer">
        <div class="cToolTipTopLeftCorner">
            &nbsp;</div>
        <div class="cToolTipTopSide">
            &nbsp;</div>
        <div class="cToolTipTopRightCorner">
            &nbsp;</div>
        <div class="cToolTipClearFlow">
            &nbsp;</div>
        <div class="cToolTipLeftSide">
            <div class="cToolTipRightSide">
                <div style="padding: 5px 15px 10px 15px;">
                    <div style="padding-bottom: 35px;">
                        <div style="padding-bottom: 5px;">
                            <div>
                                <dx:ASPxLabel runat="server" ID="lblCustomData" EnableClientSideAPI="true" Font-Size="11pt"
                                    Font-Names="Tahoma" ForeColor="black">
                                </dx:ASPxLabel>
                            </div>
                            <div>
                                <dx:ASPxLabel runat="server" ID="lblSubject" EnableClientSideAPI="true" Font-Size="11pt"
                                    Font-Names="Tahoma" ForeColor="black">
                                </dx:ASPxLabel>
                            </div>
                            <dx:ASPxLabel runat="server" ID="lblInterval" EnableClientSideAPI="true" Font-Size="11pt"
                                Font-Names="Tahoma" ForeColor="black">
                            </dx:ASPxLabel>
                        </div>
                        <div>
                            <dx:ASPxLabel runat="server" ID="lblOrderDetails" EnableClientSideAPI="true" Font-Size="11pt"
                                Font-Names="Tahoma" ForeColor="black">
                            </dx:ASPxLabel>
                        </div>

                        <div>
                            <dx:ASPxLabel runat="server" ID="lblDescription" EnableClientSideAPI="true" Font-Size="11pt"
                                Font-Names="Tahoma" ForeColor="black">
                            </dx:ASPxLabel>
                        </div>
                        <div>
                            <dx:ASPxLabel runat="server" ID="lblOverTime" EnableClientSideAPI="true" Font-Size="11pt"
                                Font-Names="Tahoma" ForeColor="black">
                            </dx:ASPxLabel>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <div class="cToolTipClearFlow">
            &nbsp;</div>
        <div class="cToolTipBottomLeftCorner">
            &nbsp;</div>
        <div class="cToolTipBottomSide">
            <div class="cToolTipBottomSideSizeFixer">
                &nbsp;</div>
        </div>
        <div class="cToolTipBottomRightCorner">
            &nbsp;</div>
        <div class="cToolTipClearFlow">
            &nbsp;</div>
	</div>
</div>
<script type="text/javascript" id="dxss_ASPxClientAppointmentToolTip">
    // <![CDATA[
    ASPxClientAppointmentToolTip = ASPx.CreateClass(ASPxClientToolTipBase, {
        Initialize: function (data) {
            var toolTipMainElement = this.GetToolTipMainElement(this.controls.buttonDiv);
            ASPxClientUtils.AttachEventToElement(toolTipMainElement, "click", ASPx.CreateDelegate(this.OnButtonDivClick, this));
            ASPxClientUtils.AttachEventToElement(toolTipMainElement, "contextmenu", ASPx.CreateDelegate(this.OnContextMenu, this));

            if (data != undefined) {
                var apt = data.GetAppointment();
                this.apt = apt;
                if (!apt.updated) {
                    this.scheduler.RefreshClientAppointmentProperties(apt, AppointmentPropertyNames.Normal, ASPx.CreateDelegate(this.OnAppointmentRefresh, this)); 
                 }
            }        
        },
        Update: function (data) {    
            var apt = data.GetAppointment();
            this.apt = apt;
            //console.log(apt.IsOrder);
            //if (!apt.updated) {
            //    //this.scheduler.RefreshClientAppointmentProperties(apt, AppointmentPropertyNames.Description, ASPx.CreateDelegate(this.OnAppointmentRefresh, this));

            //    this.controls.lblSubject.SetText("Loading...");
            //    this.controls.lblDescription.SetText("Loading...");
            //    this.controls.lblOrderDetails.SetText("Loading...");
            //    this.controls.lblOverTime.SetText("Loading...");
            //    this.controls.lblCustomData.SetText("Loading...");
            //    apt.updated = false;
            //} else {
               // 

            this.controls.lblDescription.SetText(ASPx.Str.EncodeHtml(apt.GetDescription()));
            //var textInterval = this.ConvertIntervalToString(apt.interval);          

            //var aptNew = this.scheduler.GetAppointmentById(apt.appointmentId);   
            //console.log("****" + apt.IsOverTime);

            var CustomData = apt.TooltipDisplayData.split("$");//
            if (CustomData.length == 4) {
                //this.controls.lblCustomData.SetText("Appointment No. " + CustomData[0] + "<br/>" + CustomData[2] + "<br/>" + CustomData[1]);
                this.controls.lblCustomData.SetText("Appointment No. " + apt.AptNumberDisplayData + "<br/>" + CustomData[2] + "<br/>" + CustomData[1]);
                this.controls.lblSubject.SetText(CustomData[3]);
                //this.controls.lblSubject.SetText(ASPx.Str.EncodeHtml(apt.GetSubject()));
            }
            
            if (apt.WONONum == "0") {
                this.controls.lblOrderDetails.SetText("Appointment not yet converted to Order");
            }
            else {
                this.controls.lblOrderDetails.SetText("Order Number : " + ASPx.Str.EncodeHtml(apt.WONONum));
            }
            if (apt.IsOverTime == true) {
                this.controls.lblOverTime.SetText("Working OverTime");
            }
            else {
                this.controls.lblOverTime.SetText("");
            }
            
        },
        OnAppointmentRefresh: function (apt) {
            console.log(apt.GetDescription());
            //console.log("----" + apt.IsOverTime);
            apt.updated = true;
            this.controls.lblSubject.SetText(ASPx.Str.EncodeHtml(apt.GetSubject()));
            this.controls.lblDescription.SetText(ASPx.Str.EncodeHtml(apt.GetDescription()));
            if (apt.WONONum == "0") {
                this.controls.lblOrderDetails.SetText("Appointment not yet converted to Order Yet");
            }
            else {
                this.controls.lblOrderDetails.SetText("Order Number : "+ASPx.Str.EncodeHtml(apt.WONONum));
            }
            if (apt.IsOverTime == true) {
                this.controls.lblOverTime.SetText("Working OverTime");
            }
            else {
                this.controls.lblOverTime.SetText("");
            }
            var CustomData = apt.TooltipDisplayData.split("$");
            if (CustomData.length == 3) {
                this.controls.lblCustomData.SetText("Appointment No. " + CustomData[0] + "<br/>" + CustomData[2] + "<br/>" + CustomData[1]);
            }
        },
        OnButtonDivClick: function (s, e) {           
            this.ShowAppointmentMenu(s);
        },
        //OnBtnEditClick: function () {
        //    this.scheduler.ShowAppointmentFormByClientId(this.apt.GetId());
        //    this.Close();
        //},
        //OnBtnDeleteClick: function () {
        //    this.scheduler.DeleteAppointment(this.apt);
        //},
        OnLblShowMenuClick: function (e) {
            this.ShowAppointmentMenu(e);
        },
        OnContextMenu: function (e) {
            //alert("A");
            ASPxClientUtils.PreventEventAndBubble(e);
            this.ShowAppointmentMenu(e);
        },
        GetToolTipMainElement(element) {
            var parentElement = element.parentElement;
            while (parentElement) {
                if (parentElement.id.indexOf("mainDiv") > -1) return parentElement;
                parentElement = parentElement.parentElement
            }
        }
    });
    // ]]>
</script>
