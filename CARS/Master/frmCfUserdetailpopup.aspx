<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmCfUserdetailpopup.aspx.vb" Inherits="CARS.frmCfUserdetailpopup" %>

<!DOCTYPE html>
<link href="../semantic/semantic.css" rel="stylesheet" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style type="text/css">
        html,
            body {
              height: 0%; <%-- [[need to recheck later]]--%>
            }

        .mand
        {
	        font: 11px Arial, helvetica, sans-serif;
	        color: #FF0000;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div id="divUserDetails" class="ui raised segment signup inactive"  style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
             <h3 id="lblDPSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important ;text-align: center">User Details </h3>

            <div class="ui form stackable two column grid">
                <div class="sixteen wide column">
                   <div class="inline fields">                      
                        <div class="two wide field">
                            <label id="lblSubsidiary" runat="server">Subsidiary</label>
                        </div>

                        <div class="two wide field">
                            <asp:DropDownList ID="ddlSubsidiary" CssClass="carsInput" runat="server" meta:resourcekey="ddlSubsidiaryResource1"></asp:DropDownList>
                        </div>
                        
                        <div class="two wide field">
                            <label id="lblDepartment" runat="server">Department</label>
                        </div>
 
                        <div class="two wide field">
                            <asp:DropDownList runat="server" ID="ddlDept" CssClass="carsInput"></asp:DropDownList>
                        </div>
                       
                        <div class="one wide field">
                            <label id="lblRole" runat="server">Role</label>
                        </div>
                        <div class="two wide field">
                            <asp:DropDownList runat="server" ID="ddlRole" CssClass="carsInput"></asp:DropDownList>
                        </div>
                        <div class="one wide field">
                            <asp:CheckBox runat="server" ID="cbMech"></asp:CheckBox>                            
                        </div>
                        <div  class="one wide field">
                            <label runat="server">isMechanic</label>
                        </div>             
                       <div class="one wide field"></div>
                       <div class="two wide field">
                           <asp:CheckBox runat="server" ID="cbMechActive" Text="InActive" ></asp:CheckBox>
                       </div>
                  </div> 

                  <div class="inline fields">
                      <div class="two wide field">
                            <label id="lblLogin" runat="server">Login Name<span class="mand">*</span></label>
                      </div>
                      <div class="three wide field">
                          <asp:TextBox ID="txtLoginName"  padding="0em" runat="server"></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                      <div class="two wide field">
                          <label runat="server" id="lblUserId">User Id<span class="mand">*</span></label>
                      </div>
                      <div class="three wide field">
                          <asp:TextBox ID="txtUserId" runat="server" CssClass="carsInput"></asp:TextBox>
                      </div>                    
                  </div>

                  <div class="inline fields">
                      <div class="two wide field">
                          <label id="lblFName" runat="server">First Name<span class="mand">*</span></label>
                      </div>
                      <div class="three wide field">
                           <asp:TextBox ID="txtFName" runat="server" CssClass="carsInput"></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                      <div class="two wide field">
                          <label runat="server" id="lblLName">Last Name<span class="mand">*</span></label>
                      </div>
                      <div class="three wide field">
                           <asp:TextBox ID="txtLName" runat="server" CssClass="carsInput"></asp:TextBox>
                      </div>

                  </div>

                  <div class="inline fields">
                      <div class ="two wide field">
                          <label runat="server" id="lblPassword">Password<span class="mand">*</span></label>
                      </div>

                       <div class="three wide field">
                          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="carsInput"></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                      <div class="two wide field">
                          <label runat="server" id="lblConfirm">Confirm Password<span class="mand">*</span></label>
                      </div>
                      <div class="three wide field">
                          <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="carsInput"></asp:TextBox>
                      </div>
                  </div>   

                  <div class="inline fields">
                      <div class="two wide field">
                          <label runat="server" id="lblMobileNo">Mobile No</label>
                      </div>
                      <div class="three wide field"> 
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="carsInput"></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                      <div class="two wide field">
                          <label runat="server" id="lblEmail">Email</label>
                      </div>
                      <div class="three wide field">
                           <asp:TextBox ID="txtEmail" runat="server" CssClass="carsInput"></asp:TextBox>
                      </div>
                  </div>

                  <div class="inline fields">
                        <div class="three wide field">
                            <input type="button" id="btnAdvSalesmanSave" runat="server" class="ui btn wide" value="Lagre" />
                        </div>
                        <div class="three wide field">
                            <input type="button" id="btnAdvSalesmanCancel" runat="server" class="ui btn wide" value="Avbryt" />
                        </div>
                    </div>
                    
                </div>
            </div>
          </div>
    </form>
</body>
</html>
