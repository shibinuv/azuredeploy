<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TireDeliveryReport.aspx.vb" Inherits="CARS.TireDeliveryReport" %>

<!DOCTYPE html>
     <style type="text/css">
         #dateInfo{
    position:absolute;
    right:0;  
}
#header{
    position:relative;
    width: 100%;
    height: 100px;
}
#logo{
    position:absolute;
    left:0; 
}
#title{
    text-align:center;
    margin-bottom:100px;
}
#information{
    width:80%;
    margin-bottom:150px;
}
#information td{
    width:50%
}
#signature{
    width: 40%;
    height:75px;
    border-bottom:1px solid #000;
}

     </style>
  <script type="text/javascript">
      $(document).ready(function () {

      });
      </script>

    <form id="form1">
        <div id="header">
    <div id="logo">
        CARS SOFTWARE AS
    </div>
    

        <table id="dateInfo">
            <tr>
                <td>
                    Dato:
                </td>
                <td>
                    <asp:Label ID="lblDateNow" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Tid:
                </td>
                <td>
                    <asp:Label ID="lblTimeNow" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Side:
                </td>
                <td>
                    <asp:Label ID="lblPageNow" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

        <div id="title">
        <h1>DEKK INNLEVERING</h1>
    </div>
      
        <table id="information">
            <tr>
                <td>
                    EIER:
                </td>
                <td>
                    <asp:Label ID="lblOwner" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>INNLEVERING DATO:</td>
                <td><asp:Label ID="lblRegDate" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>PAKKENR:</td>
                <td><asp:Label ID="lblTirePackageNo" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>REGNR.:</td>
                <td><asp:Label ID="lblRegNo" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>ANTALL DEKK:</td>
                <td><asp:Label ID="lblTireQty" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>M/U PIGG:</td>
                <td><asp:Label ID="lblTireSpikes" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>DEKKMERKE</td>
                <td><asp:Label ID="lblTireBrand" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>LOKASJON:</td>
                <td><asp:Label ID="lblTireLocation" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>ANMERKNING:</td>
                <td><asp:Label ID="lblTireAnnot" runat="server"></asp:Label></td>
            </tr>
        </table>
   
        <div id="signature">
            Signatur mottaker av dekk
        </div>
    </form>
    <%--<script type="text/jscript" src="<%: ResolveUrl("~/Scripts/main.js")%>"></script>--%>

