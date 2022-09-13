<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmMechanicSetting.aspx.vb" Inherits="CARS.frmMechanicSetting" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">
    
    <style>
         #flexTime {
            display: none;
        }
         #mecHidden{
            display: none;
         }

          #mecGroup {
            display: none;
        }
         #tbActions{
            display:none;
        }
        .child1 {
            width: 40%;
            float: left;
            padding: 10px;
        } 
        .child2 {
            width: 60%;
            float: left;
         padding: 10px;
        } 
        .customTimeEdit {
            border-radius: 4px;
            border-color: #dbdbdb;
        }   
         .hiddenLabel{
            display: none;
         }

        .innerPanel {
            display: inline-block;
            width: 10.5%;
            height: 5%;
        }

        .outerPannel {
            width: 100%;
            height: 10%;
        }

        fieldset{ 
            border-color:#00acac; 
            border-radius:4px;       
        }
    </style>

    <style type="text/css">
        @import url("https://fonts.googleapis.com/css?family=Inconsolata:700");

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
    
        #btnAddNewUser:hover {
            background-color: #21BA45 !important;
            color: white !important;
        }

      /*#modUserDetails{
        position: fixed;
        width: 30%;
        height: auto;
        top: 15vh;
        left: 35%;
        right: 35%;
        background-color: #fff;
        z-index: 9999;
    }
    #modUserDetails > .modContent {
        padding-left: 7px;
        padding-right: 7px;
        overflow-y: hidden;
        overflow-x: hidden;
    }*/
    </style>
<script>
        var mechanicFullName = "";
    var mecIdLogin = "";
    var mecLeaveId = 0;
    var leaveCodeMatchFound = true;
    $(document).ready(function () {

        loadinit();
        
        function loadinit() {            
            $('#<%=hdnResourceName.ClientID%>').val('');
            loadSub();
            //loadRole(0, 0);
            //loadDept(0);

            loadDefault();

            // START GEN MOD SCRIPTS
            function overlay(state, mod) {
                $('body').focus();
                if (mod == "") {
                    $('.modal').addClass('hidden');
                }
                else {
                    $('#' + mod).removeClass('hidden');
                }
                if (state == "") {
                    $('.overlayHide').toggleClass('ohActive');
                } else if (state == "on") {
                    $('.overlayHide').addClass('ohActive');
                } else {
                    $('.overlayHide').removeClass('ohActive');
                }
            }
            $(document).bind('keydown', function (e) { // BIND ESCAPE TO CLOSE
                if (e.which == 27) {
                    overlay('off', '');
                }
            });
            $(".modClose").on('click', function (e) {
                overlay('off', '');
            });

        }

        function loadDefault() {
            $('#<%=ddlSubsidiary.ClientID%>')[0].selectedIndex = 1;
            $('#<%=ddlDept.ClientID%>').empty();
             $('#<%=ddlRole.ClientID%>').empty();

            loadDept($('#<%=ddlSubsidiary.ClientID%>').val());
             $('#<%=ddlDept.ClientID%>')[0].selectedIndex = 1;
            loadRole($('#<%=ddlSubsidiary.ClientID%>').val(), $('#<%=ddlDept.ClientID%>').val());

              $('#<%=txtResource.ClientID%>').attr("disabled", "disabled");
        }

         $('#<%=ddlSubsidiary.ClientID%>').change(function (e) {
                var subId = $('#<%=ddlSubsidiary.ClientID%>').val();
                $('#<%=ddlDept.ClientID%>').empty();              
                loadDept(subId);
                loadRole(subId, 0);
            });

            $('#<%=ddlDept.ClientID%>').change(function (e) {
                var subId = $('#<%=ddlSubsidiary.ClientID%>').val();
                var deptId = $('#<%=ddlDept.ClientID%>').val();
                $('#<%=ddlRole.ClientID%>').empty();
                loadRole(subId,deptId);
            });


            $(document).on('click', '#<%=cbMech.ClientID%>', function () {
                $('#<%=cbMech.ClientID%>').attr("checked", function () {
                    if (this.checked == true) {
                        $("#<%=cbMechActive.ClientID%>").removeAttr("disabled");
                    }
                    else {
                        $("#<%=cbMechActive.ClientID%>").attr('disabled', 'disabled');
                    }
                });
            });

          $(document).on('click', '#<%=cbResource.ClientID%>', function () {
                $('#<%=cbResource.ClientID%>').attr("checked", function () {
                    if (this.checked == true) {
                        enableResource();
                        $("#<%=cbMech.ClientID%>").attr('checked', true);
                         $("#<%=cbMechActive.ClientID%>").attr('checked', true);
                    }
                    else {
                        resetResource();
                         $("#<%=cbMech.ClientID%>").attr('checked', false);
                    }
                });
          });

        function enableResource() {
           <%-- $('#<%=cbMech.ClientID%>').attr("disabled", "disabled");
            $('#<%=cbMechActive.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtFName.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtLName.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtLoginName.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtUserId.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtPassword.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtMobile.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtConfirm.ClientID%>').attr("disabled", "disabled");
            $('#<%=txtEmail.ClientID%>').attr("disabled", "disabled");
            $('#<%=ddlDept.ClientID%>').attr("disabled", "disabled");
            $('#<%=ddlSubsidiary.ClientID%>').attr("disabled", "disabled");
            $('#<%=ddlRole.ClientID%>').attr("disabled", "disabled");--%>
            $("#<%=txtResource.ClientID%>").removeAttr("disabled");

            
            $('#<%=cbMech.ClientID%>').addClass('hidden');
            $('#<%=cbMechActive.ClientID%>').addClass('hidden');
            $('#<%=txtFName.ClientID%>').addClass('hidden');
            $('#<%=txtLName.ClientID%>').addClass('hidden');
            $('#<%=txtLoginName.ClientID%>').addClass('hidden');
            $('#<%=txtUserId.ClientID%>').addClass('hidden');
            $('#<%=txtPassword.ClientID%>').addClass('hidden');
            $('#<%=txtMobile.ClientID%>').addClass('hidden');
            $('#<%=txtConfirm.ClientID%>').addClass('hidden');
            $('#<%=txtEmail.ClientID%>').addClass('hidden');
            $('#<%=ddlDept.ClientID%>').addClass('hidden');
            $('#<%=ddlSubsidiary.ClientID%>').addClass('hidden');
            $('#<%=ddlRole.ClientID%>').addClass('hidden');
            $('#<%=lblFName.ClientID%>').addClass('hidden');
            $('#<%=lblLName.ClientID%>').addClass('hidden');
            $('#<%=lblLogin.ClientID%>').addClass('hidden');
            $('#<%=lblUserId.ClientID%>').addClass('hidden');
            $('#<%=lblPassword.ClientID%>').addClass('hidden');
            $('#<%=lblConfirm.ClientID%>').addClass('hidden');
            $('#<%=lblEmail.ClientID%>').addClass('hidden');
            $('#<%=lblMobileNo.ClientID%>').addClass('hidden');
            $('#<%=lblDepartment.ClientID%>').addClass('hidden');
            $('#<%=lblSubsidiary.ClientID%>').addClass('hidden');
            $('#<%=lblRole.ClientID%>').addClass('hidden');
            $('#<%=lblIsMech.ClientID%>').addClass('hidden');
            $('#<%=lblInActive.ClientID%>').addClass('hidden');

        }

        function resetResource() {
          <%--  $("#<%=cbMech.ClientID%>").removeAttr("disabled");
            $("#<%=cbMechActive.ClientID%>").removeAttr("disabled");
            $("#<%=txtFName.ClientID%>").removeAttr("disabled");
            $("#<%=txtLName.ClientID%>").removeAttr("disabled");
            $("#<%=txtLoginName.ClientID%>").removeAttr("disabled");
            $("#<%=txtUserId.ClientID%>").removeAttr("disabled");
            $("#<%=txtPassword.ClientID%>").removeAttr("disabled");
            $("#<%=txtMobile.ClientID%>").removeAttr("disabled");
            $("#<%=txtConfirm.ClientID%>").removeAttr("disabled");
            $("#<%=txtEmail.ClientID%>").removeAttr("disabled");
            $("#<%=ddlDept.ClientID%>").removeAttr("disabled");
            $("#<%=ddlSubsidiary.ClientID%>").removeAttr("disabled");
            $("#<%=ddlRole.ClientID%>").removeAttr("disabled");--%>

            $('#<%=cbMech.ClientID%>').removeClass('hidden');
            $('#<%=cbMechActive.ClientID%>').removeClass('hidden');
            $('#<%=txtFName.ClientID%>').removeClass('hidden');
            $('#<%=txtLName.ClientID%>').removeClass('hidden');
            $('#<%=txtLoginName.ClientID%>').removeClass('hidden');
            $('#<%=txtUserId.ClientID%>').removeClass('hidden');
            $('#<%=txtPassword.ClientID%>').removeClass('hidden');
            $('#<%=txtMobile.ClientID%>').removeClass('hidden');
            $('#<%=txtConfirm.ClientID%>').removeClass('hidden');
            $('#<%=txtEmail.ClientID%>').removeClass('hidden');
            $('#<%=ddlDept.ClientID%>').removeClass('hidden');
            $('#<%=ddlSubsidiary.ClientID%>').removeClass('hidden');
            $('#<%=ddlRole.ClientID%>').removeClass('hidden');

            $('#<%=lblFName.ClientID%>').removeClass('hidden');
            $('#<%=lblLName.ClientID%>').removeClass('hidden');
            $('#<%=lblLogin.ClientID%>').removeClass('hidden');
            $('#<%=lblUserId.ClientID%>').removeClass('hidden');
            $('#<%=lblPassword.ClientID%>').removeClass('hidden');
            $('#<%=lblConfirm.ClientID%>').removeClass('hidden');
            $('#<%=lblEmail.ClientID%>').removeClass('hidden');
            $('#<%=lblMobileNo.ClientID%>').removeClass('hidden');
            $('#<%=lblDepartment.ClientID%>').removeClass('hidden');
            $('#<%=lblSubsidiary.ClientID%>').removeClass('hidden');
            $('#<%=lblRole.ClientID%>').removeClass('hidden');
            $('#<%=lblIsMech.ClientID%>').removeClass('hidden');
            $('#<%=lblInActive.ClientID%>').removeClass('hidden');

            $('#<%=txtResource.ClientID%>').attr("disabled", "disabled");
        }

        $('#btnNewUser').on('click', function () {  
            $('#<%=ddlRole.ClientID%>')[0].selectedIndex = 0;
            $('#<%=txtFName.ClientID%>').val('');
            $('#<%=txtLName.ClientID%>').val('');
            $('#<%=txtConfirm.ClientID%>').val('');
            $('#<%=txtPassword.ClientID%>').val('');
            $('#<%=txtUserId.ClientID%>').val("");
            $('#<%=txtUserId.ClientID%>').val(null);
            $('#<%=txtLoginName.ClientID%>').val("");
            $("#<%=cbMech.ClientID%>").attr('checked', false);
            $("#<%=cbMechActive.ClientID%>").attr('checked', false);
            $('#<%=cbMechActive.ClientID%>').attr("disabled", "disabled");
            $("#<%=cbResource.ClientID%>").attr('checked', false);
            $('#modNewUser').modal('show');
                      
         });

        $('#btnNewUserSave').on('click', function () {
             
            var isResource = $('#<%=cbResource.ClientID%>').is(':checked');
            if (isResource == true) {
                saveUserDetails();
            } else {
                var isresult = fnClientValidate();
                if (isresult == true) {
                    saveUserDetails();
                } else {
                    $('#modNewUser').addClass('show');
                }
            }        
           // $('.overlayHide').removeClass('ohActive');
        });

        $('#btnNewUserCancel').on('click', function () {
            resetAll();
           // $('.overlayHide').removeClass('ohActive');
        });

        function clearAll() {
            $('#<%=txtFName.ClientID%>').val('');
            $('#<%=txtLName.ClientID%>').val('');
            $('#<%=txtLoginName.ClientID%>').val('');
            $('#<%=txtUserId.ClientID%>').val('');
            $('#<%=txtPassword.ClientID%>').val('');
            $('#<%=txtConfirm.ClientID%>').val('');
            $('#<%=txtEmail.ClientID%>').val('');
            $('#<%=txtMobile.ClientID%>').val('');
            $('#<%=txtResource.ClientID%>').val('');
            loadDefault();
        }

        function resetAll() {
            $("#<%=cbResource.ClientID%>").attr('checked', false);
            resetResource();
            clearAll();
        }
                      
        function loadSub() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfUserdetail.aspx/LoadSubsidiary",
                data: '{}',
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    $('#<%=ddlSubsidiary.ClientID%>').prepend("<option value='0'>" + "--- Select ---" + "</option>");
                    Result = Result.d;
                    $.each(Result, function (key, value) {
                        $('#<%=ddlSubsidiary.ClientID%>').append($("<option></option>").val(value.SubsidiaryID).html(value.SubsidiaryName));
                    });                     
                }
            });
        }

        function loadRole(subId, deptId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfUserdetail.aspx/LoadRole",
                data: "{'subId':'" + subId + "',deptId:'" + deptId +"'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    $('#<%=ddlRole.ClientID%>').empty();
                    $('#<%=ddlRole.ClientID%>').prepend("<option value='0'>" + "--- Select ---" + "</option>");
                    Result = Result.d;
                    $.each(Result, function (key, value) {
                        $('#<%=ddlRole.ClientID%>').append($("<option></option>").val(value.Id_Role).html(value.Nm_Role));
                    });
                }
            });
        }

        function loadDept(subId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfUserdetail.aspx/LoadDepartment",
                data: "{'subId':'" + subId + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    $('#<%=ddlDept.ClientID%>').prepend("<option value='0'>" + "--- Select ---" + "</option>");
                    Result = Result.d;
                    $.each(Result, function (key, value) {
                        $('#<%=ddlDept.ClientID%>').append($("<option></option>").val(value.DeptId).html(value.DeptName));
                    });                     
                }
            });
        }

        function saveUserDetails() {
            var hdnCmid = document.getElementById('<%=hdnCommonMechId.ClientID%>').value;
            var pageSize = document.getElementById('<%=hdnPageSize.ClientID%>').value;
            var mode = "Add"; <%--document.getElementById('<%=hdnMode.ClientID%>').value;--%>
            var dept = '';
            var eaccnt = '0';
            var lang = '3';
            var role = '';
            var subsidiary = '';
            var flgResource = $('#<%=cbResource.ClientID%>').is(':checked');
            var flgMech = $('#<%=cbMech.ClientID%>').is(':checked');
            var flgMechActive = $('#<%=cbMechActive.ClientID%>').is(':checked');
            var logName = $('#<%=txtLoginName.ClientID%>').val();
            var usrId = $('#<%=txtUserId.ClientID%>').val();
            var fName = $('#<%=txtFName.ClientID%>').val();
            var lName = $('#<%=txtLName.ClientID%>').val();
            var pwd = $('#<%=txtPassword.ClientID%>').val();
            var confPwd = $('#<%=txtConfirm.ClientID%>').val();
            var mob = $('#<%=txtMobile.ClientID%>').val();
            var resourcename = $('#<%=txtResource.ClientID%>').val();
            var email = $('#<%=txtEmail.ClientID%>').val();          
           

            if ($('#<%=ddlDept.ClientID%>')[0].selectedIndex != 0) {
                dept = $('#<%=ddlDept.ClientID%>').val();
            }            

            if ($('#<%=ddlRole.ClientID%>')[0].selectedIndex != 0) {
                role = $('#<%=ddlRole.ClientID%>').val();
            }

            if ($('#<%=ddlSubsidiary.ClientID%>')[0].selectedIndex != 0) {
                subsidiary = $('#<%=ddlSubsidiary.ClientID%>').val();
            }

            if (flgResource == true) {
                role = $('#ctl00_cntMainPanel_ddlRole option:eq(1)')[0].value;
                var resName = resourcename;
                logName = resourcename;
                usrId = resourcename;
                fName = resourcename;
                lName = resourcename;
                pwd = resourcename;
                confPwd = resourcename;
            }

           $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmCfUserdetail.aspx/SaveUserDetails",
                data: "{subId: '" + subsidiary + "', deptId:'" + dept + "', roleId:'" + role + "', flgMech:'" + flgMech + "', flgMechInactive:'" + flgMechActive + "', loginName:'" + logName + "', userId:'" + usrId + "', fName:'" + fName + "', lName:'" + lName + "', pwd:'" + pwd + "', confPwd:'" + confPwd + "', lang:'" + lang + "', teleNo:'" + "" + "', mobile:'" + mob + "', fax:'" + "" + "', email:'" + "" + "', cmmid:'" + "" + "', autocorrection:'" + "0" + "', ssn:'" + "" + "', worksfrom:'" + "" +
                    "',worksto: '" + "" + "',emailaccnt: '" + eaccnt + "',flgworkhrs: '" + "0" + "',flgDuser: '" + "0" + "',addrline1: '" + "" + "',addrline2: '" + "" + "' ,zipcode: '" + "" + "',country: '" + "" + "',city: '" + "" + "', state:'" + "" + "', mode:'" + mode + "', hdnCmid:'" + "" +"', flgresource:'" + flgResource +"', resourcename:'" + resourcename + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 'PUID' || data.d == 'INSFLG' || data.d == 'UPDFLG') {
                        $('#<%=RTlblError.ClientID%>').text(GetMultiMessage('MSG126', '', ''));
                        $('#<%=RTlblError.ClientID%>').removeClass();
                        $('#<%=RTlblError.ClientID%>').addClass("lblMessage");
                        resetAll();
                        $('#<%=hdnResourceName.ClientID%>').val(logName);                       
                        $('#<%=txtMechanic.ClientID%>').val(logName);

                        mechanicFullName = fName + " " + lName;
                        mecIdLogin = logName;

                        logName = mecIdLogin + " - " + fName + " " + lName;
                        //alert(mechanicFullName);
                        $('#<%=txtMechanic.ClientID%>').val(logName);
                        mecCallback.PerformCallback(mecIdLogin + "%" + dateToYMD(dateSelector.GetDate()));
                        callBkPanel.PerformCallback(mecIdLogin + "%" + dateToYMD(dateSelector.GetDate()));
                        $("#tbActions").show();
                        checkComboBox.SetText("Select");
                        $("#mecGroup").show();
                    }
                    else if (data.d == 'UPDERR' || data.d == 'PLOGINIED' || data.d == 'CMID' || data.d == 'PLOGINIED') {
                        $('#<%=RTlblError.ClientID%>').text(GetMultiMessage('0006', '', ''));
                        $('#<%=RTlblError.ClientID%>').removeClass();
                        $('#<%=RTlblError.ClientID%>').addClass("lblErr");
                    }
                },
                error: function (result) {
                    alert("Error");
                }
            });
                     
        }

        function fnClientValidate() {         

            if ($('#<%=ddlRole.ClientID%>')[0].selectedIndex == 0) {
                var msg = GetMultiMessage('0007', GetMultiMessage('0130', '', ''), '');
                alert(msg);
                $('#<%=ddlRole.ClientID%>').focus();
                return false;
            }
            if (!(gfi_CheckEmpty($('#<%=txtLoginName.ClientID%>'), '0131'))) {
                return false;
            }

            if (!(gfb_ValidateAlphabets($('#<%=txtLoginName.ClientID%>'), '0131'))) {
                return false;
            }
            if (!(gfi_CheckEmpty($('#<%=txtUserId.ClientID%>'), '0132'))) {
                return false;
            }
            if (!(gfi_ValidateAlphaSpace($('#<%=txtUserId.ClientID%>'), '0132'))) {
                return false;
            }
            if (!(gfb_ValidateAlphabets($('#<%=txtUserId.ClientID%>'), '0132'))) {
                return false;
            }
            if (!(gfi_CheckEmpty($('#<%=txtFName.ClientID%>'), '0133'))) {
                return false;
            }

            if (!(gfb_ValidateAlphabets($('#<%=txtFName.ClientID%>'), '0133'))) {
                return false;
            }
            if (!(gfi_CheckEmpty($('#<%=txtLName.ClientID%>'), '0134'))) {
                return false;
            }

            if (!(gfb_ValidateAlphabets($('#<%=txtLName.ClientID%>'), '0134'))) {
                return false;
            }
            if (!(gfi_CheckEmpty($('#<%=txtPassword.ClientID%>'), '0135'))) {
                return false;
            }

            if (!(gfb_ValidateAlphabets($('#<%=txtPassword.ClientID%>'), '0135'))) {
                return false;
            }
            if (!(gfi_CheckEmpty($('#<%=txtConfirm.ClientID%>'), '0136'))) {
                return false;
            }

            if (!(gfb_ValidateAlphabets($('#<%=txtConfirm.ClientID%>'), '0136'))) {
                return false;
            }

            if ($('#<%=txtPassword.ClientID%>').val() != $('#<%=txtConfirm.ClientID%>').val() || $('#<%=txtPassword.ClientID%>').length != $('#<%=txtConfirm.ClientID%>').length) {
                var msg = GetMultiMessage('0137', '', '');
                alert(msg);
                $('#<%=txtConfirm.ClientID%>').val("");
                $('#<%=txtConfirm.ClientID%>').focus();
                return false;
            }

            return true;
            window.scrollTo(0, 0);
        }
        

        $('#<%=txtMechanic.ClientID%>').autocomplete({

            selectFirst: true,
            autoFocus: true,
            source: function (request, response) {
                $('#<%=hdnMechanicId.ClientID%>').val("");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmMechanicSetting.aspx/Mechanic_Search",
                    data: "{q:'" + $('#<%=txtMechanic.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        console.log($('#<%=txtMechanic.ClientID%>').val());
                        if (data.d.length === 0) {
                            response([{ label: 'Unable to find record ', value: '0', val: 'new' }]);
                        } else
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Id_Login + " - " + item.First_Name + " " + item.Last_Name,
                                    val: item.Id_Login,
                                    value: item.Id_Login + " - " + item.First_Name + " " + item.Last_Name
                                }
                            }))
                    },
                    error: function (xhr, status, error) {
                        alert("Error" + error);
                        var err = eval("(" + xhr.responseText + ")");
                        alert('Error: ' + err.Message);
                        $('#<%=hdnMechanicId.ClientID%>').val("");
                    }
                });
                },
                select: function (e, i) {
                   
                    var fullMechanicDetail = i.item.value.split("-");
                    mechanicFullName = fullMechanicDetail[1];
                    mecIdLogin = i.item.val;
                    $('#<%=hdnMechanicId.ClientID%>').val(mecIdLogin);
                    mecCallback.PerformCallback(mechanicFullName + "%" + dateToYMD(dateSelector.GetDate()));
                    callBkPanel.PerformCallback(mechanicFullName + "%" + dateToYMD(dateSelector.GetDate()));                   
                    $("#tbActions").show();                    
                    $("#mecGroup").show();
            }
            
        });
                

        $('#mecSaveBtn').on('click', function (e) {
            saveMechanicDetails();
        });


        function saveMechanicDetails() {
            if ($('#<%=txtMechanic.ClientID%>').val() == "") {
                alert("Select a mechanic");
                    return false;
            }
            else {
                var fullMechanicDetail = $('#<%=txtMechanic.ClientID%>').val().split("-");
                var mechanicId = fullMechanicDetail[0].trim();
                var mechanicName = fullMechanicDetail[1].trim();
            }
            
                if (teStandardFrom.GetValue() > teStandardTo.GetValue()) {
                    alert(" Standard From value cannot be greater than Standard To Value");
                    return false;
                }

                if (teMondayFrom.GetValue() > teMondayTo.GetValue()) {
                    alert(" Monday From value cannot be greater than Monday To Value");
                    return false;
                }
                if (teTuesdayFrom.GetValue() > teTuesdayTo.GetValue()) {
                    alert(" Tuesday From value cannot be greater than Tuesday To Value");
                    return false;
                }
                if (teWednesdayFrom.GetValue() > teWednesdayTo.GetValue()) {
                    alert(" Wednesday From value cannot be greater than Wednesday To Value");
                    return false;
                }
                if (teThursdayFrom.GetValue() > teThursdayTo.GetValue()) {
                    alert(" Thursday From value cannot be greater than Thursday To Value");
                    return false;
                }
                if (teFridayFrom.GetValue() > teFridayTo.GetValue()) {
                    alert(" Friday From value cannot be greater than Friday To Value");
                    return false;
                }
                if (teSaturdayFrom.GetValue() > teSaturdayTo.GetValue()) {
                    alert(" Saturday From value cannot be greater than Saturday To Value");
                    return false;
                }
                if (teSundayFrom.GetValue() > teSundayTo.GetValue()) {
                    alert(" Sunday From value cannot be greater than Sunday To Value");
                    return false;
                }
                if (teLunchFrom.GetValue() > teLunchTo.GetValue()) {
                    alert(" Lunch From value cannot be greater than Lunch To Value");
                    return false;
                }
            var standardFrom = convertDateFormat(teStandardFrom.GetValue());
            
            var mondayFrom = convertDateFormat(teMondayFrom.GetValue());
            var tuesdayFrom = convertDateFormat(teTuesdayFrom.GetValue());
            var wednesdayFrom = convertDateFormat(teWednesdayFrom.GetValue());
            var thursdayFrom = convertDateFormat(teThursdayFrom.GetValue());
            var fridayFrom = convertDateFormat(teFridayFrom.GetValue());
            var saturdayFrom = convertDateFormat(teSaturdayFrom.GetValue());
            var sundayFrom = convertDateFormat(teSundayFrom.GetValue());
            var lunchFrom = convertDateFormat(teLunchFrom.GetValue());

            var standardTo = convertDateFormat(teStandardTo.GetValue());
            var mondayTo = convertDateFormat(teMondayTo.GetValue());
            var tuesdayTo = convertDateFormat(teTuesdayTo.GetValue());
            var wednesdayTo = convertDateFormat(teWednesdayTo.GetValue());
            var thursdayTo = convertDateFormat(teThursdayTo.GetValue());
            var fridayTo = convertDateFormat(teFridayTo.GetValue());
            var saturdayTo = convertDateFormat(teSaturdayTo.GetValue());
            var sundayTo = convertDateFormat(teSundayTo.GetValue());
            var lunchTo = convertDateFormat(teLunchTo.GetValue());

            var altStandardFrom = convertDateFormat(teStandardFromNext.GetValue());
            var altMondayFrom = convertDateFormat(teMondayFromNext.GetValue());
            var altTuesdayFrom = convertDateFormat(teTuesdayFromNext.GetValue());
            var altWednesdayFrom = convertDateFormat(teWednesdayFromNext.GetValue());
            var altThursdayFrom = convertDateFormat(teThursdayFromNext.GetValue());
            var altFridayFrom = convertDateFormat(teFridayFromNext.GetValue());
            var altSaturdayFrom = convertDateFormat(teSaturdayFromNext.GetValue());
            var altSundayFrom = convertDateFormat(teSundayFromNext.GetValue());
            var altLunchFrom = convertDateFormat(teLunchFromNext.GetValue());

            var altStandardTo = convertDateFormat(teStandardToNext.GetValue());
            var altMondayTo = convertDateFormat(teMondayToNext.GetValue());
            var altTuesdayTo = convertDateFormat(teTuesdayToNext.GetValue());
            var altWednesdayTo = convertDateFormat(teWednesdayToNext.GetValue());
            var altThursdayTo = convertDateFormat(teThursdayToNext.GetValue());
            var altFridayTo = convertDateFormat(teFridayToNext.GetValue());
            var altSaturdayTo = convertDateFormat(teSaturdayToNext.GetValue());
            var altSundayTo = convertDateFormat(teSundayToNext.GetValue());
            var altLunchTo = convertDateFormat(teLunchToNext.GetValue());
            var activeRBChecked = rbActive.GetChecked();
            var administrationRBChecked = rbAdministration.GetChecked();

            var flexTimeCbChecked = $("#<%=cbxFlexTime.ClientID%>").is(':checked');
            var idMecGroup = $('#<%=ddlMecGroup.ClientID%>').val();
            //var mecGroupName = $("#<%=ddlMecGroup.ClientID%> option:selected").text();
            var selectedItems = checkListBox.GetSelectedItems();
            var mecGroupName = getSelectedItemsText(selectedItems);
            var mecGroupIds = getSelectedItemsValue(selectedItems);
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "frmMechanicSetting.aspx/SaveMechanicConfigDetails",
                    data: "{mechanicId: '" + mechanicId + "',mechanicName: '" + mechanicName.trim() + "',standardFrom: '" + standardFrom + "',mondayFrom: '" + mondayFrom + "',tuesdayFrom: '" + tuesdayFrom + "',wednesdayFrom: '" + wednesdayFrom +
                    "',thursdayFrom: '" + thursdayFrom + "',fridayFrom: '" + fridayFrom + "',saturdayFrom: '" + saturdayFrom + "',sundayFrom: '" + sundayFrom +
                    "',lunchFrom: '" + lunchFrom + "', standardTo: '" + standardTo + "', mondayTo: '" + mondayTo + "', tuesdayTo: '" + tuesdayTo +
                    "',wednesdayTo: '" + wednesdayTo + "', thursdayTo: '" + thursdayTo + "', fridayTo: '" + fridayTo + "', saturdayTo: '" + saturdayTo +
                    "',sundayTo: '" + sundayTo + "', lunchTo: '" + lunchTo + "', altStandardFrom: '" + altStandardFrom + "', altMondayFrom: '" + altMondayFrom + "', altTuesdayFrom: '" + altTuesdayFrom + "', altWednesdayFrom: '" + altWednesdayFrom +
                    "',altThursdayFrom: '" + altThursdayFrom + "',altFridayFrom: '" + altFridayFrom + "',altSaturdayFrom: '" + altSaturdayFrom + "',altSundayFrom: '" + altSundayFrom +
                    "',altLunchFrom: '" + altLunchFrom + "', altStandardTo: '" + altStandardTo + "', altMondayTo: '" + altMondayTo + "', altTuesdayTo: '" + altTuesdayTo +
                    "',altWednesdayTo: '" + altWednesdayTo + "', altThursdayTo: '" + altThursdayTo + "', altFridayTo: '" + altFridayTo + "', altSaturdayTo: '" + altSaturdayTo +
                        "', altSundayTo: '" + altSundayTo + "', altLunchTo: '" + altLunchTo + "', activeRBChecked: '" + activeRBChecked + "', flexTimeCbChecked: '" + flexTimeCbChecked + "', administrationRBChecked: '" + administrationRBChecked + "', idMecGroup: '" + idMecGroup + "', mecGroupName: '" + mecGroupName + "', mecGroupIds: '" + mecGroupIds + "'}",
                dataType: "json",
                success: function (response) {
                    if (response.d == -1) {
                        alert("Mechanic Configuration has been saved in database");
                    }
                    else {
                        alert("Cannot save the Mechanic Configuration in database")
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error" + error);
                    var err = eval("(" + xhr.responseText + ")");
                    alert('Error: ' + err.Message);
                }
            });
        }

        

        function loadAlternateWeekValue() {
            if ($("#<%=cbxFlexTime.ClientID%>").is(':checked')) {
                $('#flexTime').fadeIn('slow');
                teStandardFromNext.SetValue(teStandardFrom.GetValue());
                teMondayFromNext.SetValue(teMondayFrom.GetValue());
                teTuesdayFromNext.SetValue(teTuesdayFrom.GetValue());
                teWednesdayFromNext.SetValue(teWednesdayFrom.GetValue());
                teThursdayFromNext.SetValue(teThursdayFrom.GetValue());
                teFridayFromNext.SetValue(teFridayFrom.GetValue());
                teSaturdayFromNext.SetValue(teSaturdayFrom.GetValue());
                teSundayFromNext.SetValue(teSundayFrom.GetValue());
                teLunchFromNext.SetValue(teLunchFrom.GetValue());
                //To Copy Current Week's TO timings Valeus to Corresponding next week's TO values
                teStandardToNext.SetValue(teStandardTo.GetValue());
                teMondayToNext.SetValue(teMondayTo.GetValue());
                teTuesdayToNext.SetValue(teTuesdayTo.GetValue());
                teWednesdayToNext.SetValue(teWednesdayTo.GetValue());
                teThursdayToNext.SetValue(teThursdayTo.GetValue());
                teFridayToNext.SetValue(teFridayTo.GetValue());
                teSaturdayToNext.SetValue(teSaturdayTo.GetValue());
                teSundayToNext.SetValue(teSundayTo.GetValue());
                teLunchToNext.SetValue(teLunchTo.GetValue());
            }
            else
                $('#flexTime').fadeOut('slow');
        }

            $("#<%=cbxFlexTime.ClientID%>").click(function () {
                loadAlternateWeekValue();
        });
       

        function convertDateFormat(date) {

            var Str=("00" + (date.getDate() )).slice(-2)
                + "." + ("00" + (date.getMonth() + 1)).slice(-2)
                + "." + date.getFullYear() + " "
                + ("00" + date.getHours()).slice(-2) + ":"
                + ("00" + date.getMinutes()).slice(-2)
                + ":" + ("00" + date.getSeconds()).slice(-2);
            return Str;
        }

    }); // end of document ready

    
    function autoCompleteLeaveCode(s, e) {

        //console.log(s.GetValue())
        $(s.GetInputElement()).autocomplete({
            selectFirst: true,
            autoFocus: true,
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmMechanicSetting.aspx/AutofillLeaveCode",
                    data: "{q:'" + request.term + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length === 0) {
                            response([{ label: 'Unable to find record ', value: '0', val: 'new' }]);
                            leaveCodeMatchFound = false;
                        } else
                            response($.map(data.d, function (item) {
                                leaveCodeMatchFound = true;
                                return {
                                    label: item.Leave_Code + " - " + item.Leave_Description,
                                        val: item.Leave_Code + "-" + item.Leave_Description + "-" + item.Id_Leave_Types,
                                    value: item.Leave_Code
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
                   var result = i.item.val.split("-");
                    s.SetValue(result[0]);
                    //alert('0' + result[0]);                
                   // gvMechanic.batchEditApi.SetCellValue(gvMechanic.GetFocusedRowIndex(), "LEAVE_REASON", result[1])
                    //gvMechanic.SetFocusedCell(gvMechanic.GetFocusedRowIndex(), 10);
                    //gvMechanic.batchEditApi.StartEdit(gvMechanic.GetFocusedRowIndex(), 10);   
                    gvMechanic.batchEditApi.SetCellValue(gvMechanic.GetFocusedCell().rowVisibleIndex, "LEAVE_REASON", result[1]);
                    gvMechanic.SetFocusedCell(gvMechanic.GetFocusedCell().rowVisibleIndex, 10);
                    gvMechanic.batchEditApi.StartEdit(gvMechanic.GetFocusedCell().rowVisibleIndex, 10);     
                }
                else {
                    alert("Failed to fetch leave codes");
                      s.SetValue('');
                }                           
            }
        });
    }

    function BatchEditRowDeleting() {
        if (mechanicFullName == "" || mecIdLogin == "") {
            alert("Please select the mechanic before Deleting Mechanic details");
            e.cancel = true;
        }
    }

    function BatchEditStarting(s, e) {
        if (mechanicFullName == "" || mecIdLogin == "") {
            alert("Please select the mechanic before adding Mechanic details");
            e.cancel = true;
        } else { // put the existing autopopulate mechanic id,mechanic name and focus code here 
            if (e.visibleIndex < 0) {
                if (s.batchEditApi.GetCellValue(e.visibleIndex, "ID_LOGIN") === null) {
                    s.batchEditApi.SetCellValue(e.visibleIndex, "ID_LOGIN", mecIdLogin);
                }
                if (s.batchEditApi.GetCellValue(e.visibleIndex, "MECHANIC_NAME") === null) {
                    s.batchEditApi.SetCellValue(e.visibleIndex, "MECHANIC_NAME", mechanicFullName);
                    gvMechanic.SetFocusedCell(e.visibleIndex, 4);
                    s.batchEditApi.StartEdit(e.visibleIndex, 4);
                }
            }

            if (e.focusedColumn.fieldName === "ID_LOGIN") {
                e.cancel = true; //do not allow edit of the time column, but allow it to be set when adding new row.  
                if (e.visibleIndex >= 0) {
                    gvMechanic.SetFocusedCell(e.visibleIndex, 4);
                    s.batchEditApi.StartEdit(e.visibleIndex, 4);
                }
            }

            if (e.focusedColumn.fieldName === "MECHANIC_NAME") {
                e.cancel = true; //do not allow edit of the time column, but allow it to be set when adding new row. 
            }
        }

        //alert("nnew");
    }

    function BatchEditRowValidating(s, e) {
        var grid = ASPxClientGridView.Cast(s);
        var cellInfo1 = e.validationInfo[grid.GetColumnByField("FROM_DATE").index];
        var cellInfo2 = e.validationInfo[grid.GetColumnByField("TO_DATE").index];
        var cellInfo3 = e.validationInfo[grid.GetColumnByField("FROM_TIME").index];
        var cellInfo4 = e.validationInfo[grid.GetColumnByField("TO_TIME").index];        

        if (cellInfo1.value != null && cellInfo2.value != null && cellInfo3.value != null) {
            if (cellInfo1.value > cellInfo2.value) {
                cellInfo2.isValid = false;
                cellInfo2.errorText = "To Date cannot be lesser than From Date";
            }
            else if (cellInfo1.value.toString() === cellInfo2.value.toString()) {

                if (cellInfo3.value >= cellInfo4.value) {
                    cellInfo4.isValid = false;
                    cellInfo4.errorText = "To Time cannot be lesser than From Time";
                }
            }
        }


        //if (cellLeaveReason.value == null || cellLeaveReason.value == '') {
        //    alert("Invalid Leave Code");
        //    //cellLeaveReason.errorText = "Invalid Leave Code";
        //}
    }

    function cbCheckChanged() {
        var isChecked = cbCopyValues.GetChecked();
        if (isChecked) {
            //To Copy Current Week's FROM timings Valeus to Corresponding next week's FROM values
            teMondayFromNext.SetValue(teMondayFrom.GetValue());
            teTuesdayFromNext.SetValue(teTuesdayFrom.GetValue());
            teWednesdayFromNext.SetValue(teWednesdayFrom.GetValue());
            teThursdayFromNext.SetValue(teThursdayFrom.GetValue());
            teFridayFromNext.SetValue(teFridayFrom.GetValue());
            teSaturdayFromNext.SetValue(teSaturdayFrom.GetValue());
            teSundayFromNext.SetValue(teSundayFrom.GetValue());

            //To Copy Current Week's TO timings Valeus to Corresponding next week's TO values
            teMondayToNext.SetValue(teMondayTo.GetValue());
            teTuesdayToNext.SetValue(teTuesdayTo.GetValue());
            teWednesdayToNext.SetValue(teWednesdayTo.GetValue());
            teThursdayToNext.SetValue(teThursdayTo.GetValue());
            teFridayToNext.SetValue(teFridayTo.GetValue());
            teSaturdayToNext.SetValue(teSaturdayTo.GetValue());
            teSundayToNext.SetValue(teSundayTo.GetValue());
        }
    }

    function syncFromValues() {
        var standardFromValue = teStandardFrom.GetValue();
        //console.log(n1);
        teMondayFrom.SetValue(standardFromValue);
        teTuesdayFrom.SetValue(standardFromValue);
        teWednesdayFrom.SetValue(standardFromValue);
        teThursdayFrom.SetValue(standardFromValue);
        teFridayFrom.SetValue(standardFromValue);
        teSaturdayFrom.SetValue(standardFromValue);
        teSundayFrom.SetValue(standardFromValue);
    }
    function syncFromNextValues() {
        var standardFromNextValue = teStandardFromNext.GetValue();
        //console.log(n1);
        teMondayFromNext.SetValue(standardFromNextValue);
        teTuesdayFromNext.SetValue(standardFromNextValue);
        teWednesdayFromNext.SetValue(standardFromNextValue);
        teThursdayFromNext.SetValue(standardFromNextValue);
        teFridayFromNext.SetValue(standardFromNextValue);
        teSaturdayFromNext.SetValue(standardFromNextValue);
        teSundayFromNext.SetValue(standardFromNextValue);
    }
    function syncToValues() {
        var standardToValue = teStandardTo.GetValue();
        teMondayTo.SetValue(standardToValue);
        teTuesdayTo.SetValue(standardToValue);
        teWednesdayTo.SetValue(standardToValue);
        teThursdayTo.SetValue(standardToValue);
        teFridayTo.SetValue(standardToValue);
        teSaturdayTo.SetValue(standardToValue);
        teSundayTo.SetValue(standardToValue);
    }

    function syncToNextValues() {
        var standardToNextValue = teStandardToNext.GetValue();
        teMondayToNext.SetValue(standardToNextValue);
        teTuesdayToNext.SetValue(standardToNextValue);
        teWednesdayToNext.SetValue(standardToNextValue);
        teThursdayToNext.SetValue(standardToNextValue);
        teFridayToNext.SetValue(standardToNextValue);
        teSaturdayToNext.SetValue(standardToNextValue);
        teSundayToNext.SetValue(standardToNextValue);
    }

    function dateSelectorValueChanged() {
        mecCallback.PerformCallback(mechanicFullName + "%" + dateToYMD(dateSelector.GetDate()));

    }

    function dateToYMD(date) {
        var d = date.getDate();
        var m = date.getMonth() + 1;
        var y = date.getFullYear();
        return '' + y + '-' + (m <= 9 ? '0' + m : m) + '-' + (d <= 9 ? '0' + d : d);
    }
    function CBLabelInit(s,e) {
        if (cbLabel.GetText() == "True") {
            $('#flexTime').fadeIn('slow');
            $("#<%=cbxFlexTime.ClientID%>").attr('checked', true);
        }
        else {
            $("#<%=cbxFlexTime.ClientID%>").attr('checked', false);
        }
        
    }
	
    function RBLabelInit(s, e) {
        
        if (rbLabel.GetText() == "ACTIVE") {
            rbActive.SetChecked(true);
        }
        else if (rbLabel.GetText() == "PASSIVE") {
            rbPassive.SetChecked(true);
        }
        else if (rbLabel.GetText() == "ADMIN"){
            rbAdministration.SetChecked(true);
        }

    }
    function OnSaveClick(s, e) {
        if (ASPxClientEdit.ValidateGroup('entryGroup')) {
            if (validateLeaveCodes()) {

                SaveLeaveTypes();
            }
            else {
                //alert(" Invalid");
                return false;
            }
        }
    }

    function OnResetClick(s, e) {
        mecLeaveId = 0;
        leaveCode.SetEnabled(true);
        leaveCode.SetText("");
        leaveDescription.SetText("");
        approveCode.SetText("");
        leaveCode.Focus();
         saveResultLabel.SetText("");
    }
    function validateLeaveCodes() {
        if (leaveCode.GetText() == "") {
            return false;
        }
        if (leaveDescription.GetText() == "") {
            return false;
        }
        if (approveCode.GetText() == "") {
            return false;
        }
        return true;
    }
    function SaveLeaveTypes() {
        var leaveCodeValue = leaveCode.GetText();
        var leaveDescriptionValue = leaveDescription.GetText();
        var approveCodeValue = approveCode.GetText();       

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "frmMechanicLeaveTypes.aspx/AddLeaveTypes",
            data: "{leaveCode: '" + leaveCodeValue + "',leaveDescription: '" + leaveDescriptionValue + "',mecLeaveId: '" + mecLeaveId + "',approveCode: '" + approveCodeValue + "'}",
            dataType: "json",
            success: function (data) {
                //console.log($('#<%=txtMechanic.ClientID%>').val());
                //data.d.length

                //alert(data.d);
                if (data.d == "INSERTED") {                  
                    saveResultLabel.SetText("Sucessfully Saved");
                    leaveCode.SetText("");
                    leaveDescription.SetText("");
                    approveCode.SetText("");
                    $('#<%=saveResultLabel.ClientID%>').removeClass();
                    $('#<%=saveResultLabel.ClientID%>').addClass("lblMessage");
                    
                    myCallBack.PerformCallback();
                    mecLeaveId = 0;
                    leaveCode.SetEnabled(true);
                }
                else if(data.d == "CODE_EXISTS"){                    
                    saveResultLabel.SetText("Leave code already exists!!");
                    $('#<%=saveResultLabel.ClientID%>').removeClass();
                    $('#<%=saveResultLabel.ClientID%>').addClass("lblErr");
                }
                else {
                    saveResultLabel.SetText("Sucessfully Edited");
                    leaveCode.SetText("");
                    leaveDescription.SetText("");
                    approveCode.SetText("");
                    $('#<%=saveResultLabel.ClientID%>').removeClass();
                    $('#<%=saveResultLabel.ClientID%>').addClass("lblMessage");
                    
                    myCallBack.PerformCallback();
                    mecLeaveId = 0;
                    leaveCode.SetEnabled(true);
                }
            },
            error: function (xhr, status, error) {
                saveResultLabel.SetText("Failed To Save");
                alert("Error" + error);
                var err = eval("(" + xhr.responseText + ")");
                alert('Error: ' + err.Message);

            }
        });
    }

    function InvalidLCode(s, e) {
         //var v = s.GetValue();         
        var v = gvMechanic.batchEditApi.GetCellValue(gvMechanic.GetFocusedCell().rowVisibleIndex, "LEAVE_REASON")         
        if (v == null || v == "" || !leaveCodeMatchFound) {
            gvMechanic.batchEditApi.SetCellValue(gvMechanic.GetFocusedCell().rowVisibleIndex, "LEAVE_CODE", null);
            gvMechanic.batchEditApi.SetCellValue(gvMechanic.GetFocusedCell().rowVisibleIndex, "LEAVE_REASON", "");
            gvMechanic.SetFocusedCell(gvMechanic.GetFocusedCell().rowVisibleIndex, 9);
            gvMechanic.batchEditApi.StartEdit(gvMechanic.GetFocusedCell().rowVisibleIndex, 9); 
           alert("Invalid Leave Code");        
        }
    }
    function selectedItem(s, e) {

        var item = s.GetSelectedItem();
        //alert(mecLeaveId);
        var items = item.text.split(';');
        mecLeaveId = items[0].trim();
        //alert(mecLeaveId);
        //console.log(items);
        leaveCode.SetText(items[1].trim());
        leaveCode.SetEnabled(false);
        leaveDescription.SetText(items[2].trim());
        approveCode.SetText(items[3].trim());
    }
    function popupCloseUp(s, e) {
        mecLeaveId = 0;
        leaveCode.SetEnabled(true);
        //listBoxCallback.PerformCallback();
    }
    function callBkPanelEndCallback(s, e) {
        //alert(callBkPanel.cpMecGroupSelectedValue);
        if (callBkPanel.cpMecGroupSelectedValue != null) {
            $('#<%=ddlMecGroup.ClientID%>').val(callBkPanel.cpMecGroupSelectedValue);
        }
        if (callBkPanel.cpMecGroupName != null) {
            if (callBkPanel.cpMecGroupName == "") {
                checkComboBox.SetText("Select");
            }
            else {
                checkComboBox.SetText(callBkPanel.cpMecGroupName);
            }
        }
    }
    var textSeparator = ";";
    function updateText() {
        var selectedItems = checkListBox.GetSelectedItems();
        //console.log(selectedItems);
        //for (var i = 0; i < selectedItems.length; i++)
        //    console.log(selectedItems[i].value);
        console.log(getSelectedItemsValue(selectedItems));
        checkComboBox.SetText(getSelectedItemsText(selectedItems));
    }
    function synchronizeListBoxValues(dropDown, args) {
        checkListBox.UnselectAll();
        var texts = dropDown.GetText().split(textSeparator);
        var values = getValuesByTexts(texts);
        checkListBox.SelectValues(values);
        updateText(); // for remove non-existing texts
    }
    function getSelectedItemsText(items) {
        var texts = [];
        for (var i = 0; i < items.length; i++)
            texts.push(items[i].text);
        return texts.join(textSeparator);
    }
    function getValuesByTexts(texts) {
        var actualValues = [];
        var item;
        for (var i = 0; i < texts.length; i++) {
            item = checkListBox.FindItemByText(texts[i]);
            if (item != null)
                actualValues.push(item.value);
        }
        return actualValues;
    }
    function getSelectedItemsValue(items) {
        var texts = [];
        for (var i = 0; i < items.length; i++)
            texts.push(items[i].value);
        return texts.join(textSeparator);
    }
</script>
   
     <div class="overlayHide"></div>
    <asp:HiddenField ID="hdnPageSize" runat="server" />
    <asp:HiddenField ID="hdnSelect" runat="server" />
    <asp:HiddenField ID="hdnCommonMechId" runat="server" />  
    <asp:Label ID="RTlblError" runat="server"  CssClass="lblErr"></asp:Label>
    <asp:HiddenField ID="hdnMode" runat="server" />
    <asp:HiddenField ID="hdnEditCap" runat="server" Value="Edit" />
    <asp:HiddenField ID="hdnResourceName" runat="server" />
    <asp:HiddenField ID="hdnMechanicId" runat="server" />
    
     <div class ="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15)">
        <h3 id="lblDPSett" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">ANSATTE</h3>
        <div class="ui action input mini">
            <asp:TextBox ID="txtMechanic" runat="server" CssClass="inp" Width="300px" Height="40px" MaxLength="50" PlaceHolder="Select Mechanic here"></asp:TextBox>
            <%--<input id="btnSearch" type="button" value="Search" class="ui btn" />--%>

            <button class="ui button carsButtonBlueInverted mini" type="button" id="btnNewUser"><i class="user icon" id="exclamIcon" style="color: black;"></i>NewUser</button>
             <dx:ASPxCallback ID="mecCallback" runat="server" ClientInstanceName="mecCallback" OnCallback="mecCallback_Callback">
                 <ClientSideEvents EndCallback="function(s, e){ gvMechanic.Refresh();}" />
             </dx:ASPxCallback>
            <dx:ASPxButton ID="btAddLeaveTypes" runat="server" Text="Add New Leave Type" AutoPostBack="False" UseSubmitBehavior="false" ClientInstanceName="btShowModal" Height="10%" CssClass="ui button carsButtonBlueInverted mini" >
            <ClientSideEvents Click="function(s, e) {  mecLeaveTypesPopup.Show();  saveResultLabel.SetText(''); }" />
        </dx:ASPxButton>
        </div>

        <div class="ten column grid" style="margin-top: 2%; /*float: right; margin-left: 20px*/">            
            <div class="ui radiobutton" style="float: right">
                <dx:ASPxRadioButton runat="server" ID="rbActive" ClientInstanceName="rbActive" GroupName="mechanic" Text="Active Mechanic" Checked="true" Style="display: inline;" Theme="Office2003Blue"></dx:ASPxRadioButton>
                <dx:ASPxRadioButton runat="server" ID="rbPassive" ClientInstanceName="rbPassive" GroupName="mechanic" Text="Passive Mechanic" Checked="false" Style="display: inline;" Theme="Office2003Blue"></dx:ASPxRadioButton>
                <dx:ASPxRadioButton runat="server" ID="rbAdministration" ClientInstanceName="rbAdministration" Text="Administration Mechanic" GroupName="mechanic" Checked="false" Style="display: inline;" Theme="Office2003Blue"></dx:ASPxRadioButton>
            </div>
        
            <div class="ui checkbox"> 
                <input type="checkbox" id="cbxFlexTime" runat="server" />
                <label for="cbxFlexTime">Flex Time</label>               
            </div>

             <div class="mecGroup" id="mecGroup" style="float: right;">
                 <div class="ui input" id="mecHidden">
                     <label for="comboMecGroup">&nbsp;&nbsp;Group Type &nbsp;</label>
                     <asp:DropDownList ID="ddlMecGroup" AppendDataBoundItems="true" CssClass="carsInput" runat="server" ToolTip="Group Type">
                     </asp:DropDownList>
                 </div>
                 <div class="ui input">
                     <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" ID="checkComboBox" Caption ="Group Type" CssClass="customTimeEdit" runat="server" AnimationType="Slide" Theme="Office2010Blue">
                         <%--<DropDownWindowStyle BackColor="#EDEDED" />--%>
                         <DropDownWindowTemplate>
                             <dx:ASPxListBox Width="100%" Height="150" ID="checkListBox" Theme="Office2010Blue" ClientInstanceName="checkListBox" SelectionMode="CheckColumn" runat="server" EnableSelectAll="true">
                                 <FilteringSettings ShowSearchUI="true" />
                                 <Border BorderStyle="None"/>
                                 <%--<Columns>
                                     <dx:ListBoxColumn FieldName="ID_MEC_GROUP" Visible="false"></dx:ListBoxColumn>
                                     <dx:ListBoxColumn FieldName="MEC_GROUP_NAME"></dx:ListBoxColumn>
                                 </Columns>--%>
                                 <%--<BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />--%>
                                 <%--<Items>
                                     <dx:ListEditItem Text="Chrome" Value="0" Selected="true" />
                                     <dx:ListEditItem Text="Firefox" Value="1" />
                                     <dx:ListEditItem Text="IE" Value="2" />
                                     <dx:ListEditItem Text="Opera" Value="3" />
                                     <dx:ListEditItem Text="Safari" Value="4" Selected="true" />
                                 </Items>--%>
                                 <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
                             </dx:ASPxListBox>
                             <%--<table style="width: 100%">
                                 <tr>
                                     <td style="padding: 4px">
                                         <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" Style="float: right">
                                             <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown(); }" />
                                         </dx:ASPxButton>
                                     </td>
                                 </tr>
                             </table>--%>
                         </DropDownWindowTemplate>
                          <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
                     </dx:ASPxDropDownEdit>

                 </div>
             </div>
            <div  class="ten column grid" style="margin-bottom: 2%; margin-top: 2%; /*float: right; margin-left: 20px*/">

                 <dx:ASPxCallbackPanel ID="callBkPanel" ClientInstanceName="callBkPanel" HideContentOnCallback="false" runat="server"  ClientSideEvents-EndCallback="callBkPanelEndCallback" OnCallback="callBkPanel_Callback">
                     <PanelCollection>
                        <dx:PanelContent runat="server">

                              <dx:ASPxLabel runat="server" ID="cbLabel" ClientInstanceName="cbLabel" CssClass="hiddenLabel">
                                    <ClientSideEvents Init ="CBLabelInit" />
                                </dx:ASPxLabel>

                              <dx:ASPxLabel runat="server" ID="rbLabel" ClientInstanceName="rbLabel" CssClass="hiddenLabel">
                                    <ClientSideEvents Init ="RBLabelInit" />
                                </dx:ASPxLabel>                              

                              <asp:Panel ID="mtPanel" runat="server" GroupingText="Mechanic Time(This Week)" Font-Bold="true" CssClass="outerPannel">                              
                                <div>
                                    <asp:Panel ID="Panel8" runat="server" GroupingText="Standard"  CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teStandardFrom" runat="server" AllowNull="false" ClientInstanceName="teStandardFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <ClientSideEvents ValueChanged="syncFromValues" />
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
										</dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teStandardTo" runat="server" AllowNull="false" ClientInstanceName="teStandardTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <ClientSideEvents ValueChanged="syncToValues" />
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="monPanel" runat="server" GroupingText="Monday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teMondayFrom" runat="server" AllowNull="false" ClientInstanceName="teMondayFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teMondayTo" runat="server" AllowNull="false" ClientInstanceName="teMondayTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel2" runat="server" GroupingText="Tuesday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teTuesdayFrom" runat="server" AllowNull="false" ClientInstanceName="teTuesdayFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teTuesdayTo" runat="server" AllowNull="false" ClientInstanceName="teTuesdayTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel1" runat="server" GroupingText="Wednesday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teWednesdayFrom" runat="server" AllowNull="false" ClientInstanceName="teWednesdayFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teWednesdayTo" runat="server" AllowNull="false" ClientInstanceName="teWednesdayTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel3" runat="server" GroupingText="Thursday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teThursdayFrom" runat="server" AllowNull="false" ClientInstanceName="teThursdayFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teThursdayTo" runat="server" AllowNull="false" ClientInstanceName="teThursdayTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel4" runat="server" GroupingText="Friday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teFridayFrom" runat="server" AllowNull="false" ClientInstanceName="teFridayFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teFridayTo" runat="server" AllowNull="false" ClientInstanceName="teFridayTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel5" runat="server" GroupingText="Saturday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teSaturdayFrom" runat="server" AllowNull="false" ClientInstanceName="teSaturdayFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teSaturdayTo" runat="server" AllowNull="false" ClientInstanceName="teSaturdayTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel6" runat="server" GroupingText="Sunday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teSundayFrom" runat="server" AllowNull="false" ClientInstanceName="teSundayFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teSundayTo" runat="server" AllowNull="false" ClientInstanceName="teSundayTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel7" runat="server" GroupingText="Lunch" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teLunchFrom" runat="server" AllowNull="false" ClientInstanceName="teLunchFrom" CaptionSettings-ShowColon="false" Caption="From" DateTime="12:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teLunchTo" runat="server" AllowNull="false" ClientInstanceName="teLunchTo" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="13:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                </div>
                              </asp:Panel>

                              <div class="flexTime" id="flexTime">
                                 <asp:Panel ID="Panel9" runat="server" GroupingText="Mechanic Time(Alternating Week)" Font-Bold="true" CssClass="outerPannel">
                                    <asp:Panel ID="Panel10" runat="server" GroupingText="Standard" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teStandardFromNext" AllowNull="false" runat="server" ClientInstanceName="teStandardFromNext" CaptionSettings-ShowColon="false" EditFormat="Time" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <ClientSideEvents ValueChanged="syncFromNextValues" />
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teStandardToNext" AllowNull="false" runat="server" ClientInstanceName="teStandardToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <ClientSideEvents ValueChanged="syncToNextValues" />
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel11" runat="server" GroupingText="Monday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teMondayFromNext" AllowNull="false" runat="server" ClientInstanceName="teMondayFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teMondayToNext" AllowNull="false" runat="server" ClientInstanceName="teMondayToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel12" runat="server" GroupingText="Tuesday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teTuesdayFromNext" AllowNull="false" runat="server" ClientInstanceName="teTuesdayFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teTuesdayToNext" AllowNull="false" runat="server" ClientInstanceName="teTuesdayToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel13" runat="server" GroupingText="Wednesday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teWednesdayFromNext" AllowNull="false" runat="server" ClientInstanceName="teWednesdayFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teWednesdayToNext" AllowNull="false" runat="server" ClientInstanceName="teWednesdayToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel14" runat="server" GroupingText="Thursday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teThursdayFromNext" AllowNull="false" runat="server" ClientInstanceName="teThursdayFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teThursdayToNext" AllowNull="false" runat="server" ClientInstanceName="teThursdayToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel15" runat="server" GroupingText="Friday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teFridayFromNext" AllowNull="false" runat="server" ClientInstanceName="teFridayFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teFridayToNext" AllowNull="false" runat="server" ClientInstanceName="teFridayToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel16" runat="server" GroupingText="Saturday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teSaturdayFromNext" AllowNull="false" runat="server" ClientInstanceName="teSaturdayFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teSaturdayToNext" AllowNull="false" runat="server" ClientInstanceName="teSaturdayToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel17" runat="server" GroupingText="Sunday" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teSundayFromNext" AllowNull="false" runat="server" ClientInstanceName="teSundayFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="08:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teSundayToNext" AllowNull="false" runat="server" ClientInstanceName="teSundayToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="16:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel18" runat="server" GroupingText="Lunch" CssClass="innerPanel">
                                        <dx:ASPxTimeEdit ID="teLunchFromNext" AllowNull="false" runat="server" ClientInstanceName="teLunchFromNext" CaptionSettings-ShowColon="false" Caption="From" DateTime="12:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                        <p></p>
                                        <dx:ASPxTimeEdit ID="teLunchToNext" AllowNull="false" runat="server" ClientInstanceName="teLunchToNext" CaptionSettings-ShowColon="false" Caption="&nbsp;To &nbsp;&nbsp;" DateTime="13:00" CssClass="customTimeEdit" Width="100%" DisplayFormatString="HH:mm" FocusedStyle-Border-BorderColor="#2185d0" Border-BorderStyle="Double">
                                            <CaptionSettings ShowColon="False"></CaptionSettings>
                                            <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                            <Border BorderStyle="Double"></Border>
                                        </dx:ASPxTimeEdit>
                                    </asp:Panel>
                                </asp:Panel>
                            </div>

                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>                             
              
            </div>

            <div>
                 <dx:ASPxGridView ID="gvMechanic" ClientInstanceName="gvMechanic" runat="server" Width="100%" Style="border-radius: 10px;" OnBatchUpdate="gvMechanic_BatchUpdate" OnRowValidating="gvMechanic_RowValidating" KeyFieldName="ID_MECHANIC_SETTINGS" AutoGenerateColumns="False" Theme="Office2010Blue" CssClass="carsInput" KeyboardSupport="true">
                    <SettingsEditing Mode="Batch" />
                     <ClientSideEvents BatchEditStartEditing="BatchEditStarting" BatchEditRowValidating="BatchEditRowValidating"  BatchEditRowDeleting="BatchEditRowDeleting" />
                    <SettingsPopup>
                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                    </SettingsPopup>
                    <SettingsSearchPanel Visible="False"></SettingsSearchPanel>
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButton="True" VisibleIndex="0" ShowClearFilterButton="True">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID_MECHANIC_SETTINGS" ReadOnly="True" VisibleIndex="1" Visible="false">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        
                        <dx:GridViewDataTextColumn FieldName="ID_LOGIN" VisibleIndex="2" Caption="Login Id"  PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Provide Login Id"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MECHANIC_NAME" VisibleIndex="3" Caption="Mechanic Name" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Provide Mechanic Name"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FROM_DATE" VisibleIndex="4" Caption="From Date" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesDateEdit-ValidationSettings-Display="Dynamic" PropertiesDateEdit-ValidationSettings-RequiredField-ErrorText="Provide From Date" PropertiesDateEdit-ClientSideEvents-KeyDown ="function(s, e){s.ShowDropDown();}" PropertiesDateEdit-ClientSideEvents-KeyUp ="function(s, e){s.ShowDropDown();}"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataTimeEditColumn FieldName="FROM_TIME" VisibleIndex="5" Caption="From time">
                            <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Provide From Time" ValidationSettings-Display="Dynamic"></PropertiesTimeEdit>
                        </dx:GridViewDataTimeEditColumn>
                        <dx:GridViewDataDateColumn FieldName="TO_DATE" VisibleIndex="6" Caption="To Date" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesDateEdit-ValidationSettings-Display="Dynamic" PropertiesDateEdit-ValidationSettings-RequiredField-ErrorText="Provide To Date" PropertiesDateEdit-ClientSideEvents-KeyDown="function(s, e){s.ShowDropDown();}" PropertiesDateEdit-ClientSideEvents-KeyUp ="function(s, e){s.ShowDropDown();}"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataTimeEditColumn FieldName="TO_TIME" VisibleIndex="7" Caption="To Time">
                            <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Provide From Time" ValidationSettings-Display="Dynamic"></PropertiesTimeEdit>
                        </dx:GridViewDataTimeEditColumn>
                        <dx:GridViewDataTextColumn FieldName="LEAVE_CODE" VisibleIndex="8" PropertiesTextEdit-ClientSideEvents-LostFocus="InvalidLCode" PropertiesTextEdit-ClientSideEvents-Init="autoCompleteLeaveCode" Caption="Leave Code" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-Display="Dynamic" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Provide LeaveCode"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="LEAVE_REASON" VisibleIndex="9"  Caption="Leave Reason" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-RequiredField-ErrorText="Provide LeaveCode" PropertiesTextEdit-ValidationSettings-Display="Dynamic"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="COMMENTS" VisibleIndex="10" Caption="Comments"></dx:GridViewDataTextColumn>
                        <%--<dx:GridViewDataTextColumn FieldName="ID_LEAVE_TYPES"  VisibleIndex="11" Visible="false"></dx:GridViewDataTextColumn>--%>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="true" />
                    <Styles>
                        <FocusedRow BackColor="#d6eef2" ForeColor="Black"></FocusedRow>
                    </Styles>
                     <SettingsPager PageSize="10">
                        <PageSizeItemSettings Visible="true" ShowAllItem="true" />
                     </SettingsPager>
                </dx:ASPxGridView>                
            </div>

         </div>
        
         <div id="tabBottomLeft">
            <dx:ASPxDateEdit runat="server" ID="dateSelector" Theme="Office2003Blue" ClientInstanceName="dateSelector" Width="8%"  DropDownButton-Image-Url="../Images/calendar_icon.gif" >
                <ClientSideEvents ValueChanged="dateSelectorValueChanged" />
            </dx:ASPxDateEdit>
              <%--<dx:ASPxCalendar ID="calendar" runat="server" />--%>
         </div>
        <div id="tabBottom">
            <div class="tbActions" id="tbActions">
                <div id="mecSaveBtn" class="ui button positive">Lagre</div>
            </div>
             <dx:ASPxLabel ID="resultLabel" runat="server" ClientInstanceName="resultLabel" Style="display: inline-block;" ></dx:ASPxLabel>
             <dx:ASPxLabel ID="mechanicDetailsLabel" runat="server" ClientInstanceName="mechanicDetailsLabel" ></dx:ASPxLabel>             
         </div>

     </div>

    <div class="ui modal" id="modNewUser">
        <div class="header" style="text-align: center">New User/Resource</div>
        <div class="content">
          <div class="ui form stackable two column grid">
                <div class="sixteen wide column">

                  <div class="inline fields">                      
                        <div class="two wide field">
                            <label id="lblSubsidiary" runat="server">Subsidiary</label>
                        </div>
                       
                        <div class="four wide field">
                            <asp:DropDownList ID="ddlSubsidiary" CssClass="carsInput" runat="server" meta:resourcekey="ddlSubsidiaryResource1"></asp:DropDownList>
                        </div>
                        <div class="one wide field"></div>
                        <div class="two wide field">
                            <label id="lblDepartment" runat="server">Department</label>
                        </div>
 
                        <div class="four wide field">
                            <asp:DropDownList runat="server" ID="ddlDept" CssClass="carsInput"></asp:DropDownList>
                        </div>                      
                                 
                  </div> 
                  <div class="inline fields">
                      <div class="two wide field">
                          <label id="lblRole" runat="server">Role</label>
                      </div>
                      
                      <div class="four wide field">
                          <asp:DropDownList runat="server" ID="ddlRole" CssClass="carsInput"></asp:DropDownList>
                      </div>
                      <div class="one wide field"> </div>
                      <div  class="two wide field">                          
                          <asp:CheckBox runat="server" ID="cbMech" style="margin:0em;"></asp:CheckBox>     
                          <label runat="server" id="lblIsMech" style="margin-bottom:0.5em;padding-left:0.2em">isMechanic</label>
                      </div>
                      
                      <div class="one wide field">
                           <asp:CheckBox runat="server" ID="cbMechActive" style="margin:0em;" ></asp:CheckBox>
                          <label runat="server" id="lblInActive" style="margin-bottom:0.5em;padding-left:0.2em">InActive</label>
                      </div>
                      <div class="three wide field"></div>
                      <div class="one wide field">
                           <asp:CheckBox runat="server" ID="cbResource"  style="margin:0em;"></asp:CheckBox>
                           <label runat="server" style="margin-bottom:0.5em;padding-left:0.2em">IsResource</label>
                      </div>
                      <div class="two wide field"></div>
                  </div>

                  <div class="inline fields">
                      <div class="two wide field">
                            <label id="lblLogin" runat="server">Login Name<span class="mand">*</span></label>
                      </div>
                      <div class="three wide field">
                          <asp:TextBox ID="txtLoginName"  CssClass="carsInput" padding="0em" runat="server" Text=""></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                      <div class="two wide field">
                          <label runat="server" id="lblUserId">User Id<span class="mand">*</span></label>
                      </div>
                      <div class="three wide field">                          
                          <asp:TextBox ID="txtUserId" runat="server" CssClass="carsInput" Text="" autocomplete="Off"></asp:TextBox>                           
                      </div>
                      <div class="one wide field"></div>
                      <div class="three wide field">
                          <asp:TextBox ID="txtResource" runat="server" CssClass="carsInput" ></asp:TextBox>
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
                          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Text="" CssClass="carsInput" autocomplete="new-password"></asp:TextBox>
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

                
                </div>
            </div>
        </div>

        <div class="actions">
            <div class="ui approve success button" id="btnNewUserSave" >Lagre</div>

            <div class="ui cancel button" id="btnNewUserCancel">Avbryt</div>
        </div>
    </div>
    <%-- UserDetail Modal --%>


    <%--Mechanic Leave Types Modal--%>
        <div>
            <dx:ASPxPopupControl ID="mecLeaveTypesPopup" runat="server" CloseAction="CloseButton" ShowFooter="true" FooterStyle-BackColor="White" HeaderStyle-BackColor="White" HeaderText="Mechanic Leave Types"  HeaderStyle-HorizontalAlign="Center" CloseOnEscape="true" Height="250px" Left="500" Width="500px" Modal="True" Top="250" ClientInstanceName="mecLeaveTypesPopup" Theme="iOS" AllowDragging="True">

                <FooterStyle BackColor="White"></FooterStyle>

                <HeaderStyle HorizontalAlign="Center" BackColor="White"></HeaderStyle>
                <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup');myCallBack.PerformCallback(); leaveCode.Focus(); }" CloseUp="popupCloseUp" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <div>
                            <div class="ui small info message">
                                <p id="lblLeaveTypes" runat="server">Add/Edit Mechanic Leave Types</p>
                            </div>
                            <div class="child1">
                                <dx:ASPxLabel ID="lblLeaveList" runat="server" AssociatedControlID="lbLeaveTypes" Text="Leave Code List" Font-Bold="true" ></dx:ASPxLabel>
                                <dx:ASPxCallbackPanel ID="myCallBack" ClientInstanceName="myCallBack" runat="server" OnCallback="myCallBack_Callback">
                                    <PanelCollection>
                                        <dx:PanelContent runat="server">
                                            <dx:ASPxListBox ID="lbLeaveTypes" ClientInstanceName="lbLeaveTypes" runat="server" ValueType="System.String" Width="100%" ItemStyle-Height="1%" Height="200px" ItemStyle-HoverStyle-BackColor="SkyBlue" CssClass="customTimeEdit" CaptionCellStyle-Height="2px">
<ItemStyle Height="1%">
<HoverStyle BackColor="SkyBlue"></HoverStyle>
</ItemStyle>
                                                <ClientSideEvents SelectedIndexChanged="selectedItem" />
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="ID_LEAVE_TYPES" Width="100%" ClientVisible="false" />
                                                    <dx:ListBoxColumn FieldName="LEAVE_CODE" Width="10%" Caption="Leave Code" />
                                                    <dx:ListBoxColumn FieldName="LEAVE_DESCRIPTION" Width="10%" ClientVisible="false" />
                                                    <dx:ListBoxColumn FieldName="APPROVE_CODE" Width="10%" ClientVisible="false" />
                                                </Columns>
<CaptionCellStyle Height="2px"></CaptionCellStyle>
                                            </dx:ASPxListBox>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>                              

                            </div>
                            <div class="one wide column"></div>
                            <div class="child2">
                                <dx:ASPxLabel ID="leaveCodelbl" runat="server" AssociatedControlID="leaveCode" Text="Leave Code" Font-Bold="true"></dx:ASPxLabel>
                                <dx:ASPxTextBox ID="leaveCode" runat="server" Width="80%" ClientInstanceName="leaveCode" CssClass="carsInput" FocusedStyle-Border-BorderColor="#2185d0" Style="border-radius: 5px;">
                                    <ValidationSettings ErrorTextPosition="Bottom" ValidationGroup="entryGroup">
                                        <RequiredField IsRequired="True" ErrorText="Please Enter LeaveCode"></RequiredField>
                                        <RegularExpression ValidationExpression="^[a-zA-Z ]+$" ErrorText="Special Characters and Numerics not allowed" />
                                    </ValidationSettings>
                                    <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                                <dx:ASPxLabel ID="leaveDescriptionlbl" runat="server" AssociatedControlID="leaveDescription" Text="Leave Description" Font-Bold="true"></dx:ASPxLabel>
                                <dx:ASPxTextBox ID="leaveDescription" runat="server" Width="80%" ClientInstanceName="leaveDescription" CssClass="carsInput" FocusedStyle-Border-BorderColor="#2185d0" Style="border-radius: 5px;">
                                    <ValidationSettings ValidationGroup="entryGroup" ErrorTextPosition="Bottom" RequiredField-IsRequired="true" RequiredField-ErrorText="Please Enter Leave Description">
                                        <RequiredField IsRequired="True" ErrorText="Please Enter Leave Description"></RequiredField>
                                        <RegularExpression ValidationExpression="^[a-zA-Z ]+$" ErrorText="Special Characters and Numerics not allowed" />
                                    </ValidationSettings>

                                    <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                                 <dx:ASPxLabel ID="approveCodelbl" runat="server" AssociatedControlID="approveCode" Text="Approve Code" Font-Bold="true"></dx:ASPxLabel>
                                 <dx:ASPxTextBox ID="approveCode" runat="server" Width="80%" ClientInstanceName="approveCode" CssClass="carsInput" FocusedStyle-Border-BorderColor="#2185d0" Style="border-radius: 5px;">
                                    <ValidationSettings ValidationGroup="entryGroup" ErrorTextPosition="Bottom" CausesValidation="True" RequiredField-IsRequired="true" RequiredField-ErrorText="Please Enter Approve Code">
                                        <RequiredField IsRequired="True" ErrorText="Please Enter Approve Code"></RequiredField>
                                        <RegularExpression ValidationExpression="^[a-zA-Z ]+$" ErrorText="Special Characters and Numerics not allowed" />
                                    </ValidationSettings>
                                    <FocusedStyle Border-BorderColor="#2185D0"></FocusedStyle>
                                </dx:ASPxTextBox>
                                <dx:ASPxButton ID="btnReset" runat="server" CssClass="ui approve success button" Text="Reset" Height="10%" AutoPostBack="False" Style="float: left;">
                                    <ClientSideEvents Click="OnResetClick" />
                                </dx:ASPxButton>
                            </div>

                            <dx:ASPxLabel runat="server" ID="saveResultLabel" ClientInstanceName="saveResultLabel" Style="padding-left: 0"></dx:ASPxLabel>

                        </div>
                        

                    </dx:PopupControlContentControl>
                </ContentCollection>
                <FooterContentTemplate>

                    <div style="float: right;">
                        <dx:ASPxButton ID="btnSave" runat="server" CssClass="ui approve success button" Text="Save" Height="10%" AutoPostBack="False" Style="float: left;">
                            <ClientSideEvents Click="OnSaveClick" />
                        </dx:ASPxButton>
                        <dx:ASPxButton ID="btCancel" runat="server" CssClass="ui cancel button" Text="Cancel" Height="10%" AutoPostBack="False" Style="float: left;">
                            <ClientSideEvents Click="function(s, e) { mecLeaveTypesPopup.Hide(); }" />
                        </dx:ASPxButton>

                    </div>

                </FooterContentTemplate>
            </dx:ASPxPopupControl>
        </div>
</asp:Content>
