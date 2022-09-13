<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="LocalizationTest.aspx.vb" Inherits="CARS.LocalizationTest" meta:resourcekey="PageResource1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    <style>
    .myForm {
        width: 382px;
        overflow: hidden;
        margin: auto;
        padding: 80px;
        border-radius: 15px;
        background-color:lavender;
    }
    .label{  
        color: #277582;  
        font-size: 20px;  
        text-align:center;
    }
    .textboxes{  
    width: 200px;  
    height: 30px;  
    border: medium;  
    border-radius: 3px;  
    padding-left: 8px;  
    background-color:azure
}
    .btn {
    width: 100px;
    height: 30px;
    border-radius: 10px;
    padding-left: 7px;
    color: blue;

}
    .mybutton {
  position: relative;
  vertical-align: top;
  width: 100%;
  height: 60px;
  padding: 0;
  font-size: 22px;
  color: white;
  text-align: center;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.25);
  background-color: cornflowerblue;
  border: 0;
  border-bottom: 2px solid cornflowerblue;
  cursor: pointer;
  -webkit-box-shadow: inset 0 -2px cornflowerblue;
  box-shadow: inset 0 -2px cornflowerblue;
}
.mybutton:active {
  top: 1px;
  outline: none;
  -webkit-box-shadow: none;
  box-shadow: none;
}
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=tbDob.ClientID%>').datepicker('setDate', new Date());
        var language = '<%=GetLocalResourceObject("Language")%>';
        var customDateFormat = 'dd.mm.yy'
        if (language == 'en') {
            customDateFormat = 'dd/mm/yy'
        }
        $.datepicker.setDefaults($.datepicker.regional[language]);
        $('#<%=tbDob.ClientID%>').datepicker({
            showWeek: true,
            dateFormat: customDateFormat,
            //showOn: "button",
            //buttonImage: "../images/calendar_icon.gif",
            //buttonImageOnly: true,
            //buttonText: "Velg dato",
            showButtonPanel: true,
            changeMonth: true,
            changeYear: true,
            yearRange: "-50:+1"

        });
    });
</script>
    <div style="text-align: center;" class="myForm">
        <div style="padding-bottom: 30px">
        <asp:Label ID="lblHdr" runat="server" Font-Size="XX-Large" Font-Bold="True"  ForeColor="#3366ff" meta:resourcekey="lblHdrResource1"></asp:Label>
            </div>
        <div>
            <asp:Label ID="lblFirstName" CssClass="label" runat="server" meta:resourcekey="lblFirstNameResource1" ></asp:Label>
            <asp:TextBox ID="tbFirstName" CssClass="textboxes" runat="server" meta:resourcekey="tbFirstNameResource1"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="lblLastName" CssClass="label" runat="server"  meta:resourcekey="lblLastNameResource1" ></asp:Label>
            <asp:TextBox ID="tbLastName" CssClass="textboxes" runat="server"  meta:resourcekey="tbLastNameResource1"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="lblEmail" CssClass="label" runat="server"  meta:resourcekey="lblEmailResource1" ></asp:Label>
            <asp:TextBox ID="tbEmail" CssClass="textboxes" runat="server"  meta:resourcekey="tbEmailResource1"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="lblAddress" CssClass="label" runat="server"  meta:resourcekey="lblAddressResource1" ></asp:Label>
            <asp:TextBox ID="tbAddress" CssClass="textboxes" runat="server"  meta:resourcekey="tbPasswordResource1"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="lblDob" CssClass="label" runat="server"  meta:resourcekey="lblDobResource1" ></asp:Label>
            <asp:TextBox runat="server" ID="tbDob" CssClass="textboxes"  meta:resourcekey="tbDobResource1"></asp:TextBox>
        </div>
        <div style="padding-top:20px;">
        <asp:Button ID="btnSubmit" UseSubmitBehavior="False" CssClass="mybutton"  runat="server" meta:resourcekey="btnSubmitResource1" />
            </div>
    </div>

</asp:Content>
