<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmMechanicLeavetypesPopup.aspx.vb" Inherits="CARS.frmMechanicLeavetypesPopup" %>
<%@ Register assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>
<link href="../semantic/semantic.css" rel="stylesheet" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
     <script type="text/javascript"> 
     function OnBatchStartEdit(s, e) {
         if (e.visibleIndex >= 0 && e.focusedColumn.fieldName == "LEAVE_CODE") {
             e.cancel = true;
         }
     }
</script>
<body>
    <form id="form1" runat="server">
        
            <div id="aGVLeaveTypes" class="ui raised segment signup inactive"  style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15); height =600px">
   
        <h3 id="lblDPSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important ;text-align: center">Mechanic Leave Types </h3>
    
        <dx:ASPxGridView ID="gvLeaveTypes" runat="server" ClientInstanceName="gvLeaveTypes" style= "-moz-border-radius: 10px ;border-radius: 10px;" Width="100%" AutoGenerateColumns="False" OnBatchUpdate="gvLeaveTypes_BatchUpdate" KeyFieldName="ID_LEAVE_TYPES" Theme="Office2010Blue" CssClass="carsInput" >
        <SettingsEditing Mode="Batch" />
            <ClientSideEvents BatchEditStartEditing="OnBatchStartEdit" />
         <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID_LEAVE_TYPES" ReadOnly="True" VisibleIndex="1" Visible="false" >
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LEAVE_CODE" VisibleIndex="2" Caption="Leave Code" >
                    <HeaderStyle Font-Bold="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LEAVE_DESCRIPTION" VisibleIndex="3" Caption="Leave Description">
                    <HeaderStyle Font-Bold="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="APPROVE_CODE" VisibleIndex="4" Caption="Approve Code">
  
                    <HeaderStyle Font-Bold="True" />
                </dx:GridViewDataTextColumn>
                
            </Columns>

    </dx:ASPxGridView>
        </div>
    </form>
</body>
</html>
