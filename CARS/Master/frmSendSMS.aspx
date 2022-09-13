<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmSendSMS.aspx.vb" Inherits="CARS.frmSendSMS" MasterPageFile="~/MasterPage.Master" %>

<%@ PreviousPageType VirtualPath="~/master/frmCustomerDetail.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="Server">
    <style type="text/css">
        @import url("https://fonts.googleapis.com/css?family=Inconsolata:700");

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .container {
            position: absolute;
            margin: auto;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 300px;
            height: 100px;
        }

            .container .search {
                position: absolute;
                margin: auto;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                width: 33px;
                height: 33px;
                background: #2185d0;
                border-radius: 50%;
                transition: all 1s;
                z-index: 4;
                box-shadow: 0 0 25px 0 rgba(0, 0, 0, 0.4);
            }

                .container .search:hover {
                    cursor: pointer;
                }

                .container .search::before {
                    content: "";
                    position: absolute;
                    margin: auto;
                    top: 16px;
                    right: 0;
                    bottom: 0;
                    left: 14px;
                    width: 10px;
                    height: 2px;
                    background: white;
                    transform: rotate(45deg);
                    transition: all 0.5s;
                }

                .container .search::after {
                    content: "";
                    position: absolute;
                    margin: auto;
                    top: -2.5px;
                    right: 0;
                    bottom: 0;
                    left: -2.5px;
                    width: 9px;
                    height: 9px;
                    border-radius: 50%;
                    border: 2px solid white;
                    transition: all 0.5s;
                }

            .container input {
                font-family: "Inconsolata", monospace;
                position: absolute;
                margin: auto;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 35px;
                outline: none;
                border: none;
                background: white;
                color: black;
                /*text-shadow: 0 0 10px crimson;*/
                padding: 0 80px 0 20px;
                border-radius: 30px;
                box-shadow: 0 0 25px 0 #2185d0, 0 20px 25px 0 rgba(0, 0, 0, 0.1);
                transition: all 1s;
                opacity: 0;
                z-index: 5;
                font-weight: bolder;
                letter-spacing: 0.1em;
            }

                .container input:hover {
                    cursor: pointer;
                }

                .container input:focus {
                    width: 200px;
                    opacity: 1;
                    cursor: text;
                }

                    .container input:focus ~ .search {
                        right: -250px;
                        background: #151515;
                        z-index: 6;
                    }

                        .container input:focus ~ .search::before {
                            top: 0;
                            left: 0;
                            width: 25px;
                        }

                        .container input:focus ~ .search::after {
                            top: 0;
                            left: 0;
                            width: 25px;
                            height: 2px;
                            border: none;
                            background: white;
                            border-radius: 0%;
                            transform: rotate(-45deg);
                        }

                .container input::placeholder {
                    color: white;
                    opacity: 0.5;
                    font-weight: bolder;
                }



        #btnAdvSalesman:hover {
            background-color: #21BA45 !important;
            color: white !important;
        }

        #btnNewContact:hover {
            background-color: #21BA45 !important;
            color: white !important;
        }

        .ui.tabular.menu {
            border-bottom: 2px solid #2185D0;
        }

        .ui.divider {
            margin: -0.4rem 0rem;
        }


        .ui.tabular.menu .item {
            font-weight: bold;
        }

        .ui.tabular.menu .active.item {
            color: #ffffff;
            background-color: #2185D0;
            font-weight: bold;
        }


        .ui.tabular.menu .item:hover {
            background-color: rgba(33, 150, 243, 0.22);
        }

        .ui.tabular.menu .active.item:hover {
            background-color: #2185D0;
        }

        .ui.list .list > .item .header, .ui.list > .item .header {
            font-family: 'Open Sans', sans-serif;
        }

        /*placeholder styling*/

        ::-webkit-input-placeholder { /* Chrome/Opera/Safari */
            color: black !important;
        }

        ::-moz-placeholder { /* Firefox 19+ */
            color: black !important;
        }

        :-ms-input-placeholder { /* IE 10+ */
            color: black !important;
        }

        :-moz-placeholder { /* Firefox 18- */
            color: black !important;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            //$('#txtContactPerson').val("LOADED");;
            fillSMSTexts();
            fillDeptList();
            loadSMSConfig();
            var countmsg = 0;
            
            
            $('.menu .item')
                .tab()
                ; //activate the tabs
            if ($('#rbSendEmail:text').val() == 0) {

                $('#<%=txtSubject.ClientID%>').prop('disabled', true);
            }
            else {

                $('#<%=txtSubject.ClientID%>').prop('disabled', true);
            }
            
            var clickedNew = 0;
            $('#modSMSTexts').addClass('hidden');

            $('#<%=optSMSText.ClientID%>').on('change', function () {
                $('#<%=txtSMSText.ClientID%>').val($('#<%=optSMSText.ClientID%> option:selected').text());
            });

            $('#rbSendSMS').on('click', function () {
                if ($('#rbSendSMS').is(':checked')) {
                    $('#<%=txtSubject.ClientID%>, #<%=txtEmail.ClientID%>').attr("disabled", true)
                    $('#<%=txtMobile.ClientID%>').attr("disabled", false)
                }
            });
            $('#rbSendEmail').on('click', function () {
                if ($('#rbSendEmail').is(':checked')) {
                    $('#<%=txtSubject.ClientID%>, #<%=txtEmail.ClientID%>').attr("disabled", false)
                    $('#<%=txtMobile.ClientID%>').attr("disabled", true)
                }
            });

            $('#<%=btnEditSMSText.ClientID%>').on('click', function () {
                $('#<%=txtEditSMSText.ClientID%>').val($('#<%=txtSMSText.ClientID%>').val());
                $('#editTextValue').val($('#<%=optSMSText.ClientID%>').val());
                $('#modSMSTexts').modal('setting', {
                    onDeny: function () {
                        swal("Ingenting er endret.");
                    },
                    onApprove: function () {
                        swal("Run the savings to the DB: dropdwn verdien er: " + $('#editTextValue').val());

                    },
                    onShow: function () {
                        $(this).children('ui.button.ok.positive').focus();
                    }
                }).modal('show');

            });

            $('#<%=txtEmail.ClientID%>').on('blur', function () {

            });
            $('#<%=txtSubject.ClientID%>').on('blur', function () {

            });

            $("#<%=btnEditSMSNew.ClientID%>").on('click', function () {

                $('#<%=txtEditSMSText.ClientID%>').val('');
                $('#editTextValue').val('');
                alert($('#editTextValue').val());
            });
            $("#smsHistory").on('click', function () {
                loadHistory();
            });
            
           

            $.datepicker.setDefaults($.datepicker.regional["no"]);

           <%-- $('#<%=txtSendDate.ClientID%>').on('click', function () {
                //$(function () {
                $(".txtSendDate").datepicker({
                    altField: '#txtSendDate',
                    showWeek: true
                });
                //$("#txtSendDate").datepicker("show");
            });--%>

            $.datepicker.setDefaults($.datepicker.regional["no"]);
            $('#<%=txtSendDate.ClientID%>').datepicker({
                showWeek: true,
                dateFormat: 'dd.mm.yy',
                //showOn: "button",
                //buttonImage: "../images/calendar_icon.gif",
                //buttonImageOnly: true,
                //buttonText: "Velg dato",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+1"

            });

            //$("#txtSendDate").datepicker({
            //    buttonImage: "../images/calendar_icon.gif",
            //    buttonImageOnly: true,
            //    showOn: "button",
            //    //altField: '#txtSendDate',
            //    showWeek: true
            //});
            //$("#btnSendDate").on('click', function () {

            //    //$.datepicker({
            //    //    altField: '#txtSendDate',
            //    //    showWeek: true
            //    //});
            //    $(".btnSendDate").datepicker("show");
            //    //alert('heisan');
            //});

            //$(".btnSendDate").datepicker("show");

            //function calendar() {
            //    datepicker("show");
            //};

            <%--$("#<%=txtSendDate.ClientID%>").datepicker({
                showWeek: true,
                //showOn: "button",
                //buttonImage: "../images/calendar_icon.gif",
                //buttonImageOnly: true,
                //buttonText: "Select date",
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-50:+1"
            });--%>
            //calendar();
            //$('#txtSendDate').blur(function () {
            //    var str = $('#txtSendDate').val();
            //    if ($('#txtSendDate').val() == "dd") {
            //        $('#txtSendDate').val($.datepicker.formatDate('dd.mm.yy', new Date()));
            //    }
            //    if ($('#txtSendDate').val().length == 6) {
            //        $('#txtSendDate').val($.datepicker.formatDate('dd.mm.yy', new Date("20" + str.substr(4, 2), str.substr(2, 2) - 1, str.substr(0, 2))));
            //    }
            //    if ($('#txtSendDate').val().length == 8) {
            //        $('#txtSendDate').val($.datepicker.formatDate('dd.mm.yy', new Date(str.substr(4, 4), str.substr(2, 2) - 1, str.substr(0, 2))));
            //    }
            //});

            /*   GENERAL FUNCTIONS   */
            $('#click').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('#carsWrapper').toggleClass('on');
            });
            $("#btnSMSSave").on('click', function (e) {
                if ($("#<%=drpDepartmentList.ClientID%>").val() != 0) {
                    saveSMSConfig();

                }
                else {
                    swal("Du må velge avdeling før du lagrer!")
                }
            });


            $('#btnSendMessage').on('click', function (e) {
                if ($("#rbSendSMS").prop('checked')) {
                    if ($("#<%=txtSMSText.ClientID%>").val() != "" && $("#<%=txtMobile.ClientID%>").val() != "") {
                        var msg = "Manuell SMS";
                        sendSMS($("#<%=txtMobile.ClientID%>").val(), $("#<%=txtSMSText.ClientID%>").val(), "" );
                        
                    }
                    else {
                        swal("Du må skrive en tekst og legge til mobilnr før du kan sende sms eller mail.");
                    }
                }
                else {
                    swal("Du forsøker nå å sende epost. Sjekk at felter er utfyult rett.");
                }
                
            });

            $('#<%=txtSMSText.ClientID%>').on('keydown', function (e) {
                countmsg = $('#<%=txtSMSText.ClientID%>').val().length / 160;
                countmsg = parseInt(countmsg + 1);
                $('#<%=lblCountingText.ClientID%>').html($('#<%=txtSMSText.ClientID%>').val().length + " / " + countmsg);
            });

            $('#wrapperSMSSender').on('click', function () {
                $('#<%=txtSenderPassword.ClientID%>').val("");
                if ($('#<%=txtSMSSender.ClientID%>').prop('disabled')) {
                    console.log('read only true');
                    $('#modSMSSender').modal('setting', {
                        onDeny: function () {
                        },
                        onApprove: function () {
                            if ($('#<%=txtSenderPassword.ClientID%>').val() == "nironi") {
                                $('#<%=txtSMSSender.ClientID%>').removeAttr('disabled').removeAttr('readonly').focus();
                            }
                            else {
                                swal("Passordet er feil. Kontakt din systemleverandør.")
                            }
                        },
                        onShow: function () {
                            $(this).children('ui.button.ok.positive').focus();
                        }
                    }).modal('show');
                }
            });

            $("#smsHistory-table").tabulator({
                height: 300, // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                layout: "fitColumns", //fit columns to width of table (optional)                  
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string


                columns: [ //Define Table Columns
                    { title: "Telefonnr.", field: "TILTLF", width: 150, align: "center" },
                    { title: "Dato", field: "DATO", align: "center", },
                    { title: "Tid", field: "TID", align: "center" },
                    { title: "Bruker", field: "LOGIN", align: "center" },
                    { title: "Emne", field: "MELDINGSTYPE", align: "center" },
                    { title: "Sendt tekst", field: "MELDINGSTEKST", align: "center" },

                ],

                ajaxResponse: function (url, params, response) {


                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.
                   // alert(response.d);
                    return response.d; //Return the d Property Of a response json Object
                    
                },


            });

            function sendSMS(mob, text, id) {
                var num = mob;
                var message = text;
                var time = "";
                var smsid = id
                if ($("#<%=txtSendDate.ClientID%>").val() != "" && $('#<%=optTimeToSend.ClientID%>').val() != -1) {
                    var array = $("#<%=txtSendDate.ClientID%>").val().split('.');
                    var date = array[2] + "-" + array[1] + "-" + array[0];
                    time = date + " " + $('#<%=optTimeToSend.ClientID%> option:selected').text() + ":00";
                }
                
                //var password = "Cars%2021";
                var user = encodeURIComponent($('#<%=txtUserId.ClientID%>').val());
                var passres = encodeURIComponent($('#<%=txtPassword.ClientID%>').val());
                var deliveryreporturl = $('#<%=txtSMSOperator.ClientID%>').val()
                //alert(passres);
                $.ajax({
                    type: "POST",
                    url: "frmSendSMS.aspx/SendSMS",
                    data: "{num: '" + num + "', 'message': '" + message + "', 'time': '" + time + "', 'id': '" + smsid + "', 'user': '" + user + "', 'password': '" + passres + "', 'dru': '" + deliveryreporturl + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length != 0) {
                            if (data.d == "OK") {
                                var msg = "MANUELL SMS"
                                saveSMS(msg);
                                swal("Sms er sendt til " + mob + " og loggført.");
                            }
                            else {
                                swal("Sms fikk følgende retursvar: " + data.d);
                            }
                         
                        }
                        else {
                            alert('SMS not sent. Please try again later!')
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    },
                    select: function (e, i) {
                        //alert('hi');
                    },
                });
            };

            function saveSMS(messageType) {
                var msgType = messageType;
                var time = "";
                if ($("#<%=txtSendDate.ClientID%>").val() != "" && $('#<%=optTimeToSend.ClientID%>').val() != -1) {
                    var array = $("#<%=txtSendDate.ClientID%>").val().split('.');
                    var date = array[2] + "-" + array[1] + "-" + array[0];
                    time = date + " " + $('#<%=optTimeToSend.ClientID%> option:selected').text() + ":00";
                }

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSendSMS.aspx/SaveSMS",
                    data: "{dept: '" + $('#<%=drpDepartmentList.ClientID%>').val() + "', phoneFrom:'" + $('#<%=txtSMSSender.ClientID%>').val() + "', phoneTo:'" + $('#<%=txtMobile.ClientID%>').val() + "', messageType:'" + msgType + "', messageText:'" + $('#<%=txtSMSText.ClientID%>').val() + "', time:'" + time + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d[0] != "") {
                           //sendSMS($("#<%=txtMobile.ClientID%>").val(), $("#<%=txtSMSText.ClientID%>").val(), data.d[0]);
                            //swal("SMS er sendt!")
                            $('#<%=txtMobile.ClientID%>').val('');
                            $('#<%=txtSMSText.ClientID%>').val('');
                        }
                        else {
                            swal("SMS ble ikke lagret og derfor ikke sendt.");
                        }
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
            };

            

            function fillSMSTexts() {

                $.ajax({
                    type: "POST",
                    url: "frmSendSMS.aspx/FillSMSTexts",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        var optSMSText = $("[id*=optSMSText]");
                        optSMSText.empty().append('<option selected="selected" value="0">- Velg mal -</option>');
                        $.each(Result.d, function () {
                            optSMSText.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            };

            function fillDeptList() {

                $.ajax({
                    type: "POST",
                    url: "frmSendSMS.aspx/FillDeptList",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        var drpDepartmentList = $("[id*=drpDepartmentList]");
                        drpDepartmentList.empty().append('<option selected="selected" value="0">- Velg avdeling -</option>');
                        $.each(Result.d, function () {
                            drpDepartmentList.append($("<option></option>").val(this['Value']).html(this['Value'] + " - " + this['Text']));
                        });

                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
            };

            function saveSMSConfig() {
                // 0 = good,  1= ok, 2=action should be taken

                //$('input[type=checkbox]').prop('checked');


                //alert("bumper front verdien er: " + $('#txtFormbumperFrontAnnot').val());
                var rbSMSIntouch;
                var rbSMSCerum;
                var rbSMSGlobi;

                if ($('#<%=rbSMSTele.ClientID%>').prop('checked') == true) {
                    rbSMSIntouch = "1";
                    rbSMSCerum = "0";
                    rbSMSGlobi = "0";
                }
                else if ($('#<%=rbSMSCerum.ClientID%>').prop('checked') == true) {
                    rbSMSCerum = "1";
                    rbSMSIntouch = "0";
                    rbSMSGlobi = "0";
                }
                else if ($('#<%=rbSMSGlobi.ClientID%>').prop('checked') == true) {
                    rbSMSCerum = "0";
                    rbSMSIntouch = "0";
                    rbSMSGlobi = "1";
                }


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSendSMS.aspx/SaveSMSConfig",
                    data: "{'userId':'" + $('#<%=txtUserId.ClientID%>').val()
                        + "',userPassword:'" + $('#<%=txtPassword.ClientID%>').val()
                        + "',senderMail:'" + $('#<%=txtEmailSender.ClientID%>').val()
                        + "',senderSMS:'" + $('#<%=txtSMSSender.ClientID%>').val()
                        + "',smsOperator:'" + $('#<%=txtSMSOperator.ClientID%>').val()
                        + "',department:'" + $('#<%=drpDepartmentList.ClientID%>').val()
                        + "',smsIntouch:'" + rbSMSIntouch
                        + "',smsCerum:'" + rbSMSCerum
                        + "',smsGlobi:'" + rbSMSGlobi
                        + "',smsCountingStart:'" + $('#<%=txtStart.ClientID%>').val()
                        + "',smsCountingNo:'" + $('#<%=txtCount.ClientID%>').val()
                        + "',smsType:'" + $('#<%=txtSMSType.ClientID%>').val()
                        + "',postText:'" + $('#<%=txtPostText.ClientID%>').val()
                        + "',cbGreetVisit:'" + $('#<%=cbGreetVisit.ClientID%>').prop('checked')
                        + "',txtGreetVisit:'" + $('#<%=txtGreetVisit.ClientID%>').val()
                        + "',cbGreetMobility:'" + $('#<%=cbGreetMobility.ClientID%>').prop('checked')
                        + "',txtGreetMobility:'" + $('#<%=txtGreetMobility.ClientID%>').val()
                        + "',cbFollowUpAfterVisit:'" + $('#<%=cbFollowupAfterVisit.ClientID%>').prop('checked')
                        + "',cbFollowUpAfterVisitShowSMS:'" + $('#<%=cbFollowUpAfterVisitShowSMS.ClientID%>').prop('checked')
                        + "',txtFollowupAfterVisitDays:'" + $('#<%=txtFollowupAfterVisitDays.ClientID%>').val()
                        + "',txtFollowupAfterVisitAmount:'" + $('#<%=txtFollowupAfterVisitAmount.ClientID%>').val()
                        + "',txtFollowupAfterVisitText:'" + $('#<%=txtFollowupAfterVisitText.ClientID%>').val()
                        + "',cbConfirmAppointment:'" + $('#<%=cbConfirmAppointment.ClientID%>').prop('checked')
                        + "',cbConfirmAppointmentShowSms:'" + $('#<%=cbConfirmAppointmentShowSms.ClientID%>').prop('checked')
                        + "',cbconfirmNoTime:'" + $('#<%=cbconfirmNoTime.ClientID%>').prop('checked')
                        + "',txtConfirmText:'" + $('#<%=txtConfirmText.ClientID%>').val()
                        + "',cbConfirmHandingIn:'" + $('#<%=cbConfirmHandingIn.ClientID%>').prop('checked')
                        + "',cbConfirmHandingInShowSMS:'" + $('#<%=cbConfirmHandingInShowSMS.ClientID%>').prop('checked')
                        + "',cbConfirmHandingInNoTime:'" + $('#<%=cbConfirmHandingInNoTime.ClientID%>').prop('checked')
                        + "',txtHoursBeforeAgreed:'" + $('#<%=txtHoursBeforeAgreed.ClientID%>').val()
                        + "',txtHoursBeforeAgreedClock:'" + $('#<%=txtHoursBeforeAgreedClock.ClientID%>').val()
                        + "',txtConfirmHandingInText:'" + $('#<%=txtConfirmHandingInText.ClientID%>').val()
                        + "',cbConfirmHandingOut:'" + $('#<%=cbConfirmHandingOut.ClientID%>').prop('checked')
                        + "',cbConfirmHandingOutShowSMS:'" + $('#<%=cbConfirmHandingOutShowSMS.ClientID%>').prop('checked')
                        + "',txtMinBeforeFinish:'" + $('#<%=txtMinBeforeFinish.ClientID%>').val()
                        + "',txtConfirmHandingOutText:'" + $('#<%=txtConfirmHandingOutText.ClientID%>').val()
                        + "',cbFollowUp:'" + $('#<%=cbFollowUp.ClientID%>').prop('checked')
                        + "',cbFollowUpShowSMS:'" + $('#<%=cbFollowUpShowSMS.ClientID%>').prop('checked')
                        + "',txtFollowUpDaysAfter:'" + $('#<%=txtFollowUpDaysAfter.ClientID%>').val()
                        + "',txtcbFollowUpText:'" + $('#<%=txtcbFollowUpText.ClientID%>').val()
                        + "',cbConfirmReceive:'" + $('#<%=cbConfirmReceive.ClientID%>').prop('checked')
                        + "',cbConfirmReceiveShowSMS:'" + $('#<%=cbConfirmReceiveShowSMS.ClientID%>').prop('checked')
                        + "',txtArrivalOrdParts:'" + $('#<%=txtArrivalOrdParts.ClientID%>').val() + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (Result) {
                        systemMSG('success', 'SMS innstillinger har blitt lagret!', 4000);
                    },
                    failure: function () {
                        systemMSG('error', 'Se over instillingene. Noe er innfylt feilaktig.!', 4000);
                    }
                });

            }

            function loadSMSConfig() {


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSendSMS.aspx/LoadSMSConfig",
                    data: "{'department':'" + $('#<%=drpDepartmentList.ClientID%>').val() + "'}",
                    dataType: "json",
                    async: true,//Very important
                    success: function (Result) {
                        if (Result.d.length > 0) {

                            $('#<%=txtUserId.ClientID%>').val(Result.d[0].USER_ID);
                            $('#<%=txtPassword.ClientID%>').val(Result.d[0].USER_PASSWORD);
                            $('#<%=txtEmailSender.ClientID%>').val(Result.d[0].SENDER_MAIL);
                            $('#<%=txtSMSSender.ClientID%>').val(Result.d[0].SENDER_SMS);
                            $('#<%=txtSMSOperator.ClientID%>').val(Result.d[0].SMS_OPERATOR_LINK);
                            $('#<%=drpDepartmentList.ClientID%>').val(Result.d[0].DEPARTMENT);
                            //rbSMSIntouch
                            //rbSMSCerum
                            //rbSMSGlobi
                            if (Result.d[0].OPERATOR_TELE == "1") {
                                $('#<%=rbSMSTele.ClientID%>').prop('checked', true);
                            }
                            else {
                                $('#<%=rbSMSTele.ClientID%>').prop('checked', false);
                            }

                            if (Result.d[0].OPERATOR_CERUM == "1") {
                                $('#<%=rbSMSCerum.ClientID%>').prop('checked', true);
                            }
                            else {
                                $('#<%=rbSMSCerum.ClientID%>').prop('checked', false);
                            }
                            if (Result.d[0].OPERATOR_GLOBI == "1") {
                                $('#<%=rbSMSGlobi.ClientID%>').prop('checked', true);
                            }
                            else {
                                $('#<%=rbSMSGlobi.ClientID%>').prop('checked', false);
                            }

                            $('#<%=txtStart.ClientID%>').val(Result.d[0].SMS_COUNTING_START)
                            $('#<%=txtCount.ClientID%>').val(Result.d[0].SMS_COUNTING_NO)
                            $('#<%=txtSMSType.ClientID%>').val(Result.d[0].SMS_TYPE)
                            $('#<%=txtPostText.ClientID%>').val(Result.d[0].POST_TEXT);
                            $('#<%=cbGreetVisit.ClientID%>').prop('checked', Result.d[0].SMS_AFTER_VISIT);
                            $('#<%=txtGreetVisit.ClientID%>').val(Result.d[0].SMS_AFTER_VISIT_TEXT);
                            $('#<%=cbGreetMobility.ClientID%>').prop('checked', Result.d[0].SMS_MOB_WARRANTY);
                            $('#<%=txtGreetMobility.ClientID%>').val(Result.d[0].SMS_MOB_WARRANTY_TEXT);
                            $('#<%=cbFollowupAfterVisit.ClientID%>').prop('checked', Result.d[0].FOLLOWUP_AFTER_VISIT)
                            $('#<%=cbFollowUpAfterVisitShowSMS.ClientID%>').prop('checked', Result.d[0].FOLLOWUP_AFTER_VISIT_SHOW_SMS)
                            $('#<%=txtFollowupAfterVisitDays.ClientID%>').val(Result.d[0].FOLLOWUP_AFTER_VISIT_DAYS)
                            $('#<%=txtFollowupAfterVisitAmount.ClientID%>').val(Result.d[0].FOLLOWUP_AFTER_VISIT_MIN_AMOUNT)
                            $('#<%=txtFollowupAfterVisitText.ClientID%>').val(Result.d[0].FOLLOWUP_AFTER_VISIT_TEXT)
                            $('#<%=cbConfirmAppointment.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_APPOINTMENT)
                            $('#<%=cbConfirmAppointmentShowSms.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_APPOINTMENT_SHOW_SMS)
                            $('#<%=cbconfirmNoTime.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_APPOINTMENT_NO_TIME)
                            $('#<%=txtConfirmText.ClientID%>').val(Result.d[0].AUTO_CONFIRM_APPOINTMENT_TEXT)
                            $('#<%=cbConfirmHandingIn.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_DELIVERY)
                            $('#<%=cbConfirmHandingInShowSMS.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_DELIVERY_SHOW_SMS)
                            $('#<%=cbConfirmHandingInNoTime.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_NO_TIME)
                            $('#<%=txtHoursBeforeAgreed.ClientID%>').val(Result.d[0].AUTO_CONFIRM_DELIVERY_DAYS)
                            $('#<%=txtHoursBeforeAgreedClock.ClientID%>').val(Result.d[0].AUTO_CONFIRM_DELIVERY_HOURS)
                            $('#<%=txtConfirmHandingInText.ClientID%>').val(Result.d[0].AUTO_CONFIRM_DELIVERY_TEXT)
                            $('#<%=cbConfirmHandingOut.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_DELIVERY_OUT)
                            $('#<%=cbConfirmHandingOutShowSMS.ClientID%>').prop('checked', Result.d[0].AUTO_CONFIRM_DELIVERY_OUT_SHOW_SMS)
                            $('#<%=txtMinBeforeFinish.ClientID%>').val(Result.d[0].AUTO_CONFIRM_DELIVERY_OUT_MINS_BEFORE)
                            $('#<%=txtConfirmHandingOutText.ClientID%>').val(Result.d[0].AUTO_CONFIRM_DELIVERY_OUT_TEXT)
                            $('#<%=cbFollowUp.ClientID%>').prop('checked', Result.d[0].AUTO_FOLLOWUP_AFTER_VISIT)
                            $('#<%=cbFollowUpShowSMS.ClientID%>').prop('checked', Result.d[0].AUTO_FOLLOWUP_AFTER_VISIT_SHOW_SMS)
                            $('#<%=txtFollowUpDaysAfter.ClientID%>').val(Result.d[0].AUTO_FOLLOWUP_AFTER_VISIT_DAYS)
                            $('#<%=txtcbFollowUpText.ClientID%>').val(Result.d[0].AUTO_FOLLOWUP_AFTER_VISIT_TEXT)
                            $('#<%=cbConfirmReceive.ClientID%>').prop('checked', Result.d[0].AUTO_ARRIVAL_PURCHASED_SPARES)
                            $('#<%=cbConfirmReceiveShowSMS.ClientID%>').prop('checked', Result.d[0].AUTO_ARRIVAL_PURCHASED_SPARES_SHOW_SMS)
                            $('#<%=txtArrivalOrdParts.ClientID%>').val(Result.d[0].AUTO_ARRIVAL_PURCHASED_SPARES_TEXT)


                        }
                    }
                });
            }


            /*Fetches the data you need from sms config to be able to send sms. Username, password etc.*/
            <%--function fetchSMSConfig() {


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSendSMS.aspx/LoadSMSConfig",
                    data: "{'department':'" + "" + "'}",
                    dataType: "json",
                    async: true,//Very important
                    success: function (Result) {
                        if (Result.d.length > 0) {
                            var messageType = "Manuell SMS";
                            
                           

                            saveSMSGlobal(Result.d[0].DEPARTMENT, Result.d[0].SENDER_SMS, phoneTo, messageType, messageText, time, Result.d[0].USER_ID, Result.d[0].USER_PASSWORD, Result.d[0].SMS_OPERATOR_LINK);
                            //rbSMSIntouch
                            //rbSMSCerum
                            //rbSMSGlobi
                            if (Result.d[0].OPERATOR_TELE == "1") {
                                $('#<%=rbSMSTele.ClientID%>').prop('checked', true);
                            }
                        }
                    }
                });
            }--%>

            <%--function saveSMSGlobal(dept, senderSMS, phoneTo, messageType, messageText, time, userId, userPassword, smsOperatorLink ) {
                var msgType = messageType;
                var time = "";
                if ($("#<%=txtSendDate.ClientID%>").val() != "" && $('#<%=optTimeToSend.ClientID%>').val() != -1) {
                    var array = $("#<%=txtSendDate.ClientID%>").val().split('.');
                    var date = array[2] + "-" + array[1] + "-" + array[0];
                    time = date + " " + $('#<%=optTimeToSend.ClientID%> option:selected').text() + ":00";
                }

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSendSMS.aspx/SendSMSGlobal",
                    data: "{dept: '" + dept + "', senderSMS:'" + senderSMS + "', phoneTo:'" + phoneTo + "', messageType:'" + messageType + "', messageText:'" + messageText + "', time:'" + time + "', userId:'" + userId + "', userPassword:'" + userPassword + "', smsOperator:'" + smsOperatorLink + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d[0] != "") {
                           <%-- sendSMS($("#<%=txtMobile.ClientID%>").val(), $("#<%=txtSMSText.ClientID%>").val(), data.d[0]);
                            swal("SMS er sendt!")
                        }
                        else {
                            swal("SMS ble ikke lagret og derfor ike sendt.");
                        }
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
            };--%>

            function loadHistory() {
                if ($('#<%=drpHistory.ClientID%>').val() == 1) {
                    //alert($('#drpHistory').val())
                    $("#smsHistory-table").tabulator("setData", "frmSendSMS.aspx/Fetch_SMSHistory", {},); //make ajax request with advanced config options
                    $("#smsHistory-table").tabulator("redraw", true);
                }
            }


        });

    </script>

    <div id="carsWrapper">
        <div id="carsContent">
            <%--<div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form ">
                        <div class="ui grid">
                            <div class="sixteen wide column">
                                <input type="button" value="SMS Message" id="btnSMSMessage" class="ui btn" />
                                <input type="button" value="Automation" id="btnAutomation" class="ui btn" />
                                <input type="button" value="Group SMS" id="btnGroupSMS" class="ui btn" />
                                <input type="button" value="SMS History" id="btnSMSHistory" class="ui btn" />
                                <input type="button" value="Email History" id="btnEmailHistory" class="ui btn" />
                                <input type="button" value="Configuration" id="btnConfiguration" class="ui btn" />
                            </div>
                        </div>
                        <div class="ui divider"></div>
                    </div>
                </div>
            </div>--%>


            <div class="ui one column grid">
                <div class="stretched row">
                    <div class="sixteen wide column">

                        <div class="ui top attached tabular menu">
                            <a class="item active" data-tab="first">SMS Melding</a>
                            <a class="item" data-tab="second">Automatikk</a>
                            <a class="item " data-tab="third">Gruppe SMS</a>
                            <a class="item " data-tab="fourth" id="smsHistory">SMS historikk</a>
                            <a class="item " data-tab="fifth">Epost historikk</a>
                            <a class="item " data-tab="sixth">Konfigurasjon</a>
                        </div>


                        <%--                    ############################### tabSMSMessage ##########################################--%>
                        <div class="ui bottom attached tab segment active" data-tab="first">
                            <div id="tabSMSMessage">
                                <div class="ui grid">
                                    <div class="twelve wide column">
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">SMS Melding</h3>
                                            <div class="ui form ">
                                                <div class="fields">
                                                    <div class="six wide field">
                                                        <asp:Label ID="lblName" Text="Name" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <asp:TextBox ID="txtName" runat="server" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                    <div class="one wide field">
                                                        <%--<asp:Label ID="Label17" Text="Name" runat="server" CssClass="centerlabel"></asp:Label>--%>
                                                        <asp:TextBox ID="TextBox8" runat="server" CssClass="carsInput" Visible="false"></asp:TextBox>
                                                    </div>
                                                    <div class="six wide field">
                                                        <label>&nbsp;</label>
                                                        <div class="ui form">
                                                            <div class="inline field">
                                                                <div class="ui radio checkbox">
                                                                    <input type="radio" id="rbSendSMS" name="frequency" checked="checked" />
                                                                    <label>Send SMS</label>
                                                                </div>
                                                                <div class="ui radio checkbox">
                                                                    <input type="radio" id="rbSendEmail" name="frequency" />
                                                                    <label>Send Epost</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="fields">
                                                    <div class="four wide field">
                                                        <asp:Label ID="lblMobile" Text="Mobile" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <asp:TextBox ID="txtMobile" runat="server" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                    <div class="eight wide field">
                                                        <asp:Label ID="lblEmail" Text="Email" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <asp:TextBox ID="txtEmail" runat="server" disabled="true" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="fields">
                                                    <div class="seven wide field">
                                                        <asp:Label ID="lblSMSTexts" Text="SMS Texts" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <select id="optSMSText" class="carsInput" runat="server">
                                                        </select>
                                                    </div>
                                                    <div class="two wide field">
                                                        <%--<asp:Label ID="Label11" Text="&nbsp;" runat="server"></asp:Label>--%>
                                                        <label>&nbsp</label>
                                                        <input type="button" value="Edit" id="btnEditSMSText" class="ui button carsButtonBlueInverted" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="fields">
                                                    <div class="twelve wide field">
                                                        <asp:Label ID="lblSubject" Text="Subject" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <asp:TextBox ID="txtSubject" runat="server" disabled="true" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="fields">
                                                    <div class="twelve wide field">
                                                        <div class="inline fields" style="margin: 0em 0em 0em !important">
                                                            <div class="four wide field">
                                                                <asp:Label ID="lblSMSText" Text="SMS text" runat="server" CssClass="centerlabel"></asp:Label>
                                                            </div>
                                                            <div class="six wide field">
                                                                <asp:Label ID="Label19" Text="Antall tegn / meldinger:" runat="server" CssClass="centerlabel"></asp:Label>
                                                            </div>
                                                            <div class="six wide field">
                                                                <asp:Label ID="lblCountingText" Text="" runat="server" CssClass="centerlabel"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <asp:TextBox ID="txtSMSText" runat="server" CssClass="carsInput" Height="100px" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <%--</div>--%>
                                                <div class="fields">
                                                    <div class="four wide field">
                                                        <asp:Label ID="lblSendDate" Text="Send date" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <asp:TextBox ID="txtSendDate" runat="server" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                    <div class="two wide field">
                                                        <asp:Label ID="lblTimeToSend" Text="Time" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <select id="optTimeToSend" class="carsInput" runat="server">
                                                            <option value="-1">--Velg--</option>
                                                            <option value="0">00:00</option>
                                                            <option value="1">00:30</option>
                                                            <option value="2">01:00</option>
                                                            <option value="3">01:30</option>
                                                            <option value="4">02:00</option>
                                                            <option value="5">02:30</option>
                                                            <option value="6">03:00</option>
                                                            <option value="7">03:30</option>
                                                            <option value="8">04:00</option>
                                                            <option value="9">04:30</option>
                                                            <option value="10">05:00</option>
                                                            <option value="11">05:30</option>
                                                            <option value="12">06:00</option>
                                                            <option value="13">06:30</option>
                                                            <option value="14">07:00</option>
                                                            <option value="15">07:30</option>
                                                            <option value="16">08:00</option>
                                                            <option value="17">08:30</option>
                                                            <option value="18">09:00</option>
                                                            <option value="19">09:30</option>
                                                            <option value="20">10:00</option>
                                                            <option value="21">10:30</option>
                                                            <option value="22">11:00</option>
                                                            <option value="23">11:30</option>
                                                            <option value="24">12:00</option>
                                                            <option value="25">12:30</option>
                                                            <option value="26">13:00</option>
                                                            <option value="27">13:30</option>
                                                            <option value="28">14:00</option>
                                                            <option value="29">14:30</option>
                                                            <option value="30">15:00</option>
                                                            <option value="31">15:30</option>
                                                            <option value="32">16:00</option>
                                                            <option value="33">16:30</option>
                                                            <option value="34">17:00</option>
                                                            <option value="35">17:30</option>
                                                            <option value="36">18:00</option>
                                                            <option value="37">18:30</option>
                                                            <option value="38">19:00</option>
                                                            <option value="39">19:30</option>
                                                            <option value="40">20:00</option>
                                                            <option value="41">20:30</option>
                                                            <option value="42">21:00</option>
                                                            <option value="43">21:30</option>
                                                            <option value="44">22:00</option>
                                                            <option value="45">22:30</option>
                                                            <option value="46">23:00</option>
                                                            <option value="47">23:30</option>

                                                        </select>
                                                    </div>
                                                    <div class="two wide field">
                                                    </div>
                                                    <div class="four wide field">
                                                        <%--<asp:Label ID="Label16" Text="blank" runat="server" CssClass="blanklabel"></asp:Label>--%>
                                                        <label>&nbsp;</label>
                                                        <input type="button" value="Send melding" id="btnSendMessage" class="ui button carsButtonBlueInverted wide" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="eight wide column">
                                                <div class="ui form ">
                                                    <div class="twelve wide field">
                                                        <asp:Label ID="lblStatus" Text="Status" runat="server" CssClass="centerlabel"></asp:Label>
                                                        <asp:TextBox ID="txtStatus" runat="server" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <%--                    ############################### tabAutomation ##########################################--%>
                        <div class="ui bottom attached tab segment" data-tab="second">
                            <div id="tabAutomation">
                                <div class="ui grid">
                                    <div class="eight wide column">
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H1" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Innlevering/ utlevering på verksted</h3>

                                            <%--PART 1--%>

                                            <asp:Label ID="Label2" Text="blank" runat="server" CssClass="blanklabel"></asp:Label>
                                            <div class="ui grid">
                                                <div class="sixteen wide column">
                                                    <div class="ui form ">
                                                        <div class="fields">
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmAppointment" runat="server" Text="Confirm appointment" Checked="false" />
                                                                </label>
                                                            </div>
                                                            <div class="four wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmAppointmentShowSms" runat="server" Text="Show SMS" Checked="false" />
                                                                </label>
                                                            </div>
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbconfirmNoTime" runat="server" Text="ikke angi tidspunkt" Checked="false" />
                                                                </label>
                                                            </div>
                                                        </div>

                                                        <div class="fields">
                                                            <div class="sixteen wide field">
                                                                <asp:TextBox ID="txtConfirmText" runat="server" CssClass="carsInput" TextMode="multiline" Height="50px"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>


                                            <div class="ui divider"></div>

                                            <%--PART 2--%>
                                            <div class="ui grid">
                                                <div class="sixteen wide column">
                                                    <div class="ui form ">
                                                        <div class="fields">
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmHandingIn" runat="server" Text="Confirm handing in" Checked="false" />
                                                                </label>
                                                            </div>
                                                            <div class="four wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmHandingInShowSMS" runat="server" Text="Show SMS" Checked="false" />
                                                                </label>
                                                            </div>
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmHandingInNoTime" runat="server" Text="ikke angi tidspunkt" Checked="false" />
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="two wide field">
                                                                <asp:TextBox ID="txtHoursBeforeAgreed" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                            <div class="four wide field">
                                                                <asp:Label ID="lblHoursBeforeAgreed" Text="Dag(er)" runat="server" CssClass="centerlabel"></asp:Label>
                                                            </div>
                                                            <div class="four wide field">
                                                                <asp:Label ID="Label17" Text="Send kl." runat="server" CssClass="centerlabel"></asp:Label>

                                                            </div>
                                                            <div class="four wide field">
                                                                <asp:TextBox ID="txtHoursBeforeAgreedClock" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="sixteen wide field">
                                                                <asp:TextBox ID="txtConfirmHandingInText" runat="server" CssClass="carsInput" TextMode="multiline" Height="50px"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="ui divider"></div>

                                            <%--PART 3--%>
                                            <div class="ui grid">
                                                <div class="sixteen wide column">
                                                    <div class="ui form ">
                                                        <div class="fields">
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmHandingOut" runat="server" Text="Confirm handing out" Checked="false" />
                                                                </label>
                                                            </div>
                                                            <div class="four wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmHandingOutShowSMS" runat="server" Text="Show SMS" Checked="false" />
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="two wide field">
                                                                <asp:TextBox ID="txtMinBeforeFinish" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <asp:Label ID="lblMinBeforeFinish" Text="min. before agreed finish" runat="server" CssClass="centerlabel"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="sixteen wide field">
                                                                <asp:TextBox ID="txtConfirmHandingOutText" runat="server" CssClass="carsInput" TextMode="multiline" Height="50px"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="eight wide column">
                                        <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                            <h3 id="H2" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Verksted besøk</h3>
                                            <%--PART 4--%>

                                            <asp:Label ID="Label1" Text="blank" runat="server" CssClass="blanklabel"></asp:Label>
                                            <div class="ui grid">
                                                <div class="sixteen wide column">
                                                    <div class="ui form ">
                                                        <div class="fields">
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbFollowUp" runat="server" Text="Followup after visit" Checked="false" />
                                                                </label>
                                                            </div>
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbFollowUpShowSMS" runat="server" Text="Show SMS" Checked="false" />
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="two wide field">
                                                                <asp:TextBox ID="txtFollowUpDaysAfter" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                            <div class="four wide field">
                                                                <asp:Label ID="lblDaysAfter" Text="days after visit" runat="server" CssClass="centerlabel"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="sixteen wide field">
                                                                <asp:TextBox TextBox ID="txtcbFollowUpText" runat="server" CssClass="carsInput" TextMode="multiline" Height="50px"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <%--PART 5--%>
                                            <h3 id="H3" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Ankomst bestilte varer</h3>
                                            <asp:Label ID="Label3" Text="blank" runat="server" CssClass="blanklabel"></asp:Label>
                                            <div class="ui grid">
                                                <div class="sixteen wide column">
                                                    <div class="ui form ">
                                                        <div class="fields">
                                                            <div class="eight wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmReceive" runat="server" Text="Confirm receive parts" Checked="false" />
                                                                </label>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbConfirmReceiveShowSMS" runat="server" Text="Show SMS" Checked="false" />
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="sixteen wide field">
                                                                <asp:TextBox ID="txtArrivalOrdParts" runat="server" CssClass="carsInput" TextMode="multiline" Height="50px"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <%--END PART 5--%>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <%--                    ############################### tabGroupSMS ##########################################--%>
                        <div class="ui bottom attached tab segment" data-tab="third">
                            <div id="tabGroupSMS">

                                <div class="ui grid">
                                    <div class="six wide column">
                                        <div class="ui form ">
                                            <div class="fields">
                                                <div class="six wide field">
                                                    <asp:Label ID="lblSMSGroup" Text="Group name" runat="server" CssClass="centerlabel"></asp:Label>
                                                    <div class="ten wide field">
                                                        <select id="cmbSMSGroup" class="dropdowns">
                                                            <option value="0" selected="selected"></option>
                                                            <option value="1">Test1</option>
                                                            <option value="2">Test2</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--PART 1--%>
                                        <div class="ui form">
                                            &nbsp
                            <div class="eleven wide field">
                                <div class="fields" style="background-color: #E0E0E0">
                                    <h4>
                                        <asp:Label ID="Label4" Text="Import customers" runat="server" CssClass="centerlabel"></asp:Label></h4>
                                </div>
                            </div>
                                            <asp:Label ID="lblSMSCustomer" Text="Customer no." runat="server" CssClass="centerlabel"></asp:Label>
                                            <div class="inline fields">
                                                <div class="four wide field">
                                                    <asp:TextBox ID="txtSMSCustomer" runat="server" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                                <div class="two wide field">
                                                    <input type="button" id="btnSMSCustomer" class="btntest" value="Hent">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ui form">
                                            &nbsp
                             <div class="eleven wide field">
                                 <div class="fields" style="background-color: #E0E0E0">
                                     <h4>
                                         <asp:Label ID="Label6" Text="Import from file" runat="server" CssClass="centerlabel"></asp:Label></h4>
                                 </div>
                             </div>
                                            <asp:Label ID="lblSMSImportfile" Text="File" runat="server" CssClass="centerlabel"></asp:Label>
                                            <div class="inline fields">
                                                <div class="eight wide field">
                                                    <asp:TextBox ID="txtSMSImportfile" runat="server" CssClass="carsInput" Width="100%"></asp:TextBox>
                                                </div>
                                                <div class="two wide field">
                                                    <input type="button" id="btnBrowsefolders" class="btntest" value="Browse">
                                                </div>
                                            </div>
                                            <div class="inline fields">
                                                <div class="three wide field">
                                                    <asp:Label ID="Label10" Text="Name start pos." runat="server" CssClass="centerlabel"></asp:Label>
                                                    <asp:TextBox TextBox ID="TextBox1" runat="server" CssClass="carsInput" Width="50%"></asp:TextBox>
                                                </div>
                                                <div class="three wide field">
                                                    <asp:Label ID="Label13" Text="Name length" runat="server" CssClass="centerlabel"></asp:Label>
                                                    <asp:TextBox ID="TextBox6" runat="server" CssClass="carsInput" Width="50%"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="inline fields">
                                                <div class="three wide field">
                                                    <asp:Label ID="Label12" Text="Mob.no start pos." runat="server" CssClass="centerlabel"></asp:Label>
                                                    <asp:TextBox TextBox ID="TextBox3" runat="server" CssClass="carsInput" Width="50%"></asp:TextBox>
                                                </div>
                                                <div class="three wide field">
                                                    <asp:Label Label ID="Label14" Text="Mob.no length" runat="server" CssClass="centerlabel"></asp:Label>
                                                    <asp:TextBox ID="TextBox7" runat="server" CssClass="carsInput" Width="50%"></asp:TextBox>
                                                </div>
                                                <div class="two wide field">
                                                    <input type="button" id="btnSMSImportfile" class="btntest" value="Import" />
                                                </div>
                                            </div>

                                        </div>


                                        <div class="ui form">
                                            &nbsp
                             <div class="eleven wide field">
                                 <div class="fields" style="background-color: #E0E0E0">
                                     <h4>
                                         <asp:Label ID="Label7" Text="Customers birthday" runat="server" CssClass="centerlabel"></asp:Label></h4>
                                 </div>
                             </div>
                                            <asp:Label Label ID="Label5" Text="Birthday" runat="server" CssClass="centerlabel"></asp:Label>
                                            <div class="inline fields">
                                                <div class="eight wide field">
                                                    <asp:TextBox ID="txtBirthday" runat="server" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                                <div class="two wide field">
                                                    <input type="button" id="btnBirthday" class="btntest" value="Hent">
                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                    <div class="six wide column">
                                        <div class="ui form ">
                                            <div class="fields">
                                                <div class="seven wide field">
                                                    <asp:Label ID="Label8" Text="Group list" runat="server" CssClass="centerlabel"></asp:Label>
                                                    <%--<asp:TextBox ID="TextBox2" runat="server" CssClass="carsInput"></asp:TextBox>--%>
                                                    <table class="ui celled table">
                                                        <thead>
                                                            <tr>
                                                                <th>Name</th>
                                                                <th>Mobile</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>Cell</td>
                                                                <td>Cell</td>
                                                            </tr>
                                                            <tr>
                                                                <td>Cell</td>
                                                                <td>Cell</td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <tr>
                                                                <th colspan="3">
                                                                    <div class="ui right floated pagination menu">
                                                                        <a class="icon item">
                                                                            <i class="left chevron icon"></i>
                                                                        </a>
                                                                        <a class="item">1</a>
                                                                        <a class="item">2</a>
                                                                        <a class="item">3</a>
                                                                        <a class="item">4</a>
                                                                        <a class="icon item">
                                                                            <i class="right chevron icon"></i>
                                                                        </a>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--                    ############################### tabSMSHistory ##########################################--%>

                        <div class="ui bottom attached tab segment" data-tab="fourth">
                            <div id="tabSMSHistory">
                               
                                                <select id="drpHistory" class="ui selection dropdown" runat="server">
                                                    <option value="1" selected="selected">SMS</option>
                                                    <option value="2">Epost</option>
                                                        </select>
                                            
                                            <div id="smsHistory-table" class="mytabulatorclass"></div>
                            </div>
                        </div>

                        <%--                    ############################### tabEmailHistory ##########################################--%>
                        <div class="ui bottom attached tab segment" data-tab="fifth">
                            <div id="tabEmailHistory">
                                <table class="ui celled table">
                                    <thead>
                                        <tr>
                                            <th>Email</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Subject</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="3">
                                                <div class="ui right floated pagination menu">
                                                    <a class="icon item">
                                                        <i class="left chevron icon"></i>
                                                    </a>
                                                    <a class="item">1</a>
                                                    <a class="item">2</a>
                                                    <a class="item">3</a>
                                                    <a class="item">4</a>
                                                    <a class="icon item">
                                                        <i class="right chevron icon"></i>
                                                    </a>
                                                </div>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>

                        <%--                    ############################### tabConfiguration ##########################################--%>
                        <div class="ui bottom attached tab segment" data-tab="sixth">
                            <div id="tabConfiguration">

                                <div class="ui grid">

                                    <div class="sixteen wide column">
                                        <div class="ui form">
                                            <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15); min-height: 30em !important;">
                                                <h3 id="lblTechnicalData" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Tekniske data</h3>
                                                <div class="ui divider"></div>
                                                <div class="fields">
                                                    <div class="eight wide field">

                                                        <div class="fields">
                                                            <div class="eight wide field">
                                                                <asp:Label ID="lblUserId" Text="User ID" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <asp:TextBox TextBox ID="txtUserId" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <asp:Label ID="lblSMSSender" Text="Sender SMS" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <div id="wrapperSMSSender">
                                                                    <asp:TextBox ID="txtSMSSender" runat="server" Enabled="true" CssClass="carsInput"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="eight wide field">
                                                                <asp:Label ID="lblPassword" Text="Password" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <asp:TextBox TextBox ID="txtPassword" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <asp:Label ID="lblSMSOperator" Text="SMS operator" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <asp:TextBox TextBox ID="txtSMSOperator" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="eight wide field">
                                                                <asp:Label ID="lblEmailSender" Text="Sender mail" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <asp:TextBox TextBox ID="txtEmailSender" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                            <div class="eight wide field">
                                                                <asp:Label ID="Label18" Text="Avdeling" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <select id="drpDepartmentList" runat="server" class="carsInput"></select>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="four wide field">

                                                        <div class="fields">
                                                            <div class="ten wide field">
                                                                &nbsp
                                            <label>
                                                <asp:RadioButton ID="rbSMSTele" runat="server" Text="SMS via Intouch" GroupName="SMSOperator" Checked="true" AutoPostBack="false" />
                                            </label>
                                                                <label>
                                                                    <asp:RadioButton ID="rbSMSCerum" runat="server" Text="SMS Cerum" GroupName="SMSOperator" Checked="true" AutoPostBack="false" />
                                                                </label>
                                                                <label>
                                                                    <asp:RadioButton ID="rbSMSGlobi" runat="server" Text="SMS GlobiSMS" GroupName="SMSOperator" Checked="true" AutoPostBack="false" />
                                                                </label>
                                                                <div class="sixteen wide field">
                                                                    <asp:Label ID="lblSMSType" Text="SMS utgave" runat="server" CssClass="centerlabel"></asp:Label>
                                                                    <asp:TextBox ID="txtSMSType" runat="server" CssClass="carsInput"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="four wide field">

                                                        <h3 id="h6" runat="server" class="ui blue top medium header left aligned" style="border-color: blue !important">SMS Counting</h3>
                                                        <div class="fields">
                                                            <div class="ten wide field">
                                                                <asp:Label ID="lblStart" Text="Start" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <asp:TextBox ID="txtStart" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="ten wide field">
                                                                <asp:Label ID="lblCount" Text="Count" runat="server" CssClass="centerlabel"></asp:Label>
                                                                <asp:TextBox ID="txtCount" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="fields">
                                                    <div class="sixteen wide field">
                                                        <h3 id="headingPostText" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">Post text</h3>
                                                        <div class="ui divider"></div>
                                                        <div class="fields">
                                                            <div class="sixteen wide field">
                                                                <asp:TextBox ID="txtPostText" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="fields">
                                                    &nbsp;
                                                </div>
                                                <div class="fields">
                                                    <div class="seven wide field">
                                                        <h3 id="headingGreetVisit" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">BilXtra greeting after visit</h3>
                                                        <div class="fields">
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbGreetVisit" Enabled="true" runat="server" Width="200%" Text="Send SMS etter besøk" />
                                                                </label>
                                                            </div>
                                                            <div class="four wide field">
                                                                <button class="mini ui button" type="button" id="btnConfigGreetAfterVisit" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                                    <i class="plus icon" style="margin: auto"></i>
                                                                </button>
                                                            </div>
                                                        </div>

                                                        <div class="fields">
                                                            <asp:TextBox ID="txtGreetVisit" Enabled="true" TextMode="MultiLine" runat="server" CssClass="carsInput" Height="75px"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="one wide field">
                                                    </div>

                                                    <div class="seven wide field">
                                                        <h3 id="h4" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">BilXtra greeting after mobility warranty</h3>
                                                        <div class="fields">
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbGreetMobility" Enabled="true" runat="server" Width="200%" Text="Send SMS mob garanti" />
                                                                </label>
                                                            </div>
                                                            <div class="four wide field">
                                                                <button class="mini ui button" type="button" id="btnConfigMobWar" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                                    <i class="plus icon" style="margin: auto"></i>
                                                                </button>
                                                            </div>

                                                        </div>
                                                        <div class="fields">
                                                            <asp:TextBox ID="txtGreetMobility" Enabled="true" TextMode="MultiLine" runat="server" CssClass="carsInput" Height="75px"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <h3 id="h5" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important">BilXtra verksted besøk</h3>

                                                <div class="fields">
                                                    <div class="eight wide field">

                                                        <div class="fields">
                                                            <div class="eight wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbFollowupAfterVisit" runat="server" Enabled="true" Width="200%" Text="Oppfølging etter besøk" />
                                                                </label>
                                                            </div>
                                                            <div class="six wide field">
                                                                <label>
                                                                    <asp:CheckBox ID="cbFollowUpAfterVisitShowSMS" runat="server" Width="200%" Text="Vis SMS" />
                                                                </label>
                                                            </div>
                                                            <div class="two wide field">
                                                                <button class="mini ui button" type="button" id="btnConfigFollowupAfterVisit" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                                    <i class="plus icon" style="margin: auto"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <div class="fields">
                                                            <div class="three wide field">
                                                                <asp:TextBox ID="txtFollowupAfterVisitDays" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                            <div class="five wide field">
                                                                <asp:Label ID="Label20" Text="Dager etter besøk" runat="server" CssClass="centerlabel"></asp:Label>

                                                            </div>

                                                            <div class="four wide field">
                                                                <asp:Label Label ID="Label16" Text="Min. beløp Kr." runat="server" CssClass="centerlabel"></asp:Label>
                                                            </div>
                                                            <div class="three wide field">

                                                                <asp:TextBox ID="txtFollowupAfterVisitAmount" Enabled="true" runat="server" CssClass="carsInput"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="eight wide field">

                                                        <div class="fields">
                                                            <div class="sixteen wide field">
                                                                <asp:TextBox ID="txtFollowupAfterVisitText" TextMode="MultiLine" Enabled="true" runat="server" CssClass="carsInput" Height="75px"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>


                            </div>

                        </div>
                        <div id="tabBottom">
                            <div class="ui form">
                                <div class="inline fields">

                                    <div class="eight wide field">
                                        &nbsp;
                                    </div>
                                    <div class="four wide field">
                                        <div id="btnSMSSave" class="ui button positive wide">Lagre</div>
                                    </div>
                                    <div class="four wide field">
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>



                    <%-- ////////////////////Modal section! /////////////////////////////// --%>

                    <%-- Modal for editing and creating new texts --%>
                    <div id="modSMSTexts" class="ui modal">
                        <div class="header">
                            <h2>Edit SMS Text</h2>
                        </div>
                        <div class="image content">
                            <div class="image">
                                <i class="warning icon"></i>
                            </div>
                            <div class="description">
                                <label id="editTextValue">&nbsp;</label>
                                <p>
                                    <asp:Label runat="server" ID="Label11" meta:resourcekey="CustomerLock1Resource1" Text="Rdiger den valgte teksten fra SMS Tekster"></asp:Label>
                                </p>
                                <asp:TextBox ID="txtEditSMSText" runat="server" CssClass="carsInput" TextMode="multiline" Height="8em" Width="400px"></asp:TextBox>
                            </div>
                        </div>
                        <div class="actions">
                            <div class="ui button ok positive" runat="server" id="btnEditSMSSave">Lagre</div>
                            <div class="ui button yellow" id="btnEditSMSNew" runat="server">Ny tekst</div>
                            <div class="ui button cancel negative" runat="server" id="btnEditSMSCancel">Avbryt</div>
                        </div>
                    </div>





                    <%-- Modal for SMS sender text pop up --%>
                    <div id="modSMSSender" class="ui small modal">
                        <div class="header">
                            <asp:Literal runat="server" ID="CustomerLockHead" meta:resourcekey="CustomerLockHeadResource1" Text="Advarsel!"></asp:Literal>
                        </div>
                        <div class="image content">
                            <div class="image">
                                <i class="warning icon"></i>
                            </div>
                            <div class="description">
                                <p>
                                    <asp:Label runat="server" ID="CustomerLock1" meta:resourcekey="CustomerLock1Resource1" Text="Avsenderfeltet er låst for manuell inntasting. Dette blir satt opp av administrator."></asp:Label>
                                </p>
                                <p>
                                    <asp:Literal runat="server" ID="CustomerLock2" meta:resourcekey="CustomerLock2Resource1" Text="Ønsker du å endre på avsender, ta kontakt med Cars Software."></asp:Literal>
                                </p>
                                <asp:TextBox ID="txtSenderPassword" TextMode="Password" runat="server" CssClass="carsInput" Width="200px"></asp:TextBox>
                            </div>
                        </div>
                        <div class="actions">
                            <div class="ui button ok positive">
                                <asp:Literal runat="server" ID="CustomerLockOK" meta:resourcekey="CustomerLockOKResource1" Text="Lås opp"></asp:Literal>
                            </div>
                            <div class="ui button cancel negative">
                                <asp:Literal runat="server" ID="CustomerLockCancel" meta:resourcekey="CustomerLockCancelResource1" Text="Avbryt"></asp:Literal>
                            </div>
                        </div>
                    </div>
                    <%--######### End tabs #############--%>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
