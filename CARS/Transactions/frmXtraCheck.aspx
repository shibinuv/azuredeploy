<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="frmXtraCheck.aspx.vb" Inherits="CARS.frmXtraCheck" %>
<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntMainPanel" runat="server">


    <script type="text/javascript">
        let mobile = [];
        let arrayOfValues = [];
        let smstext = "";
        $(document).ready(function () {



            myNameSpace = function () {

                var objectOfVariables = {
                    po_modal_state: 1,            //1:means that we are at the state where you still can add more spareparts to order 2:after pressing next and on "send order". 3: is final state
                    po_modal_state_canclose: 0,

                };
                var item_arr = [];


                function set(variableToChange, newvalue, ponumber) {

                    var count = 0;

                    while (Object.keys(objectOfVariables)[count] != undefined)     //while we still have properties to loop over
                    {
                        if (Object.keys(objectOfVariables)[count] === variableToChange) {
                            if (variableToChange == "importedButDeletedRows") {
                                //console.log("Legger inn denne");
                                console.log(newvalue);
                                objectOfVariables[variableToChange].push(newvalue);
                            }
                            else {
                                objectOfVariables[variableToChange] = newvalue;
                                //console.log("Set variable!" + newvalue);
                            }


                        }
                        count++;
                    }
                }

                function get(variableToRetrieve, pop) {
                    var count = 0;
                    while (Object.keys(objectOfVariables)[count] != undefined)     //while we still have properties to loop over
                    {

                        if (Object.keys(objectOfVariables)[count] === variableToRetrieve) {

                            if (variableToRetrieve == "importedButDeletedRows") {
                                if (pop == 1) {
                                    return objectOfVariables[variableToRetrieve].pop();
                                }
                                else {
                                    return objectOfVariables[variableToRetrieve];
                                }

                            }

                            else {
                                return objectOfVariables[variableToRetrieve];
                            }


                        }
                        count++;
                    }

                }



                return {
                    /* public_call : internal call.  Can be the same such as init:init, or different such as set:change */

                    set: set,
                    get: get

                }
            }();

            loadInit();

            $("#btnScheme").on("click", function () {


                //-----------------------------------------ORIGINAL CODE-------------------------------------------------------------------------//
                //alert("inside the run function");
                var array = [];
                var i = 0;
                $('.selectionList').each(function (index, item) {

                    ($(item).is(':checked'));
                    if ($(item).is(':checked') == true) {
                        //alert("is true");
                        if (i <= 20) {
                            //alert("less than 21");
                            array[i] = 2;
                        }
                        else {
                            array[i] = 1;
                        }

                    }
                    else {
                        array[i] = 0;

                    }
                    i++;

                });

                var badmotoroil = array[0];
                //alert(badmotoroil + array[0]);
                var badcflevel = array[1];
                var badcftemp = array[2];
                var badbrakefluid = array[3];
                var badbattery = array[4];
                var badvipesfront = array[5];
                var badvipesrear = array[6];
                var badlightsfront = array[7];
                var badlightsrear = array[8];
                var badshockabsorberfront = array[9];
                var badshockabsorberrear = array[10];
                var badtiresfront = array[11];
                var badtiresrear = array[12];
                var badsuspensionfront = array[13];
                var badsuspensionrear = array[14];
                var badbrakesfront = array[15];
                var badbrakesrear = array[16];
                var badexhaust = array[17];
                var badsealedengine = array[18];
                var badsealedgearbox = array[19];
                var badwindshield = array[20];


                var mediummotoroil = array[21];
                var mediumcflevel = array[22];
                var mediumcftemp = array[23];
                var mediumbrakefluid = array[24];
                var mediumbattery = array[25];
                var mediumvipesfront = array[26];
                var mediumvipesrear = array[27];
                var mediumlightsfront = array[28];
                var mediumlightsrear = array[29];
                var mediumshockabsorberfront = array[30];
                var mediumshockabsorberrear = array[31];
                var mediumtiresfront = array[32];
                var mediumtiresrear = array[33];
                var mediumsuspensionfront = array[34];
                var mediumsuspensionrear = array[35];
                var mediumbrakesfront = array[36];
                var mediumbrakesrear = array[37];
                var mediumexhaust = array[38];
                var mediumsealedengine = array[39];
                var mediumsealedgearbox = array[40];
                var mediumwindshield = array[41];

                $("#modScheme").modal('show');
                $("#car-table").tabulator("setData", "../Master/frmVehicleDetail.aspx/GENERATE_XTRA_VEHICLES", {
                    'badmotoroil': badmotoroil, 'badcflevel': badcflevel, 'badcftemp': badcftemp,
                    'badbrakefluid': badbrakefluid,

                    'badbattery': badbattery,
                    'badvipesfront': badvipesfront,

                    'badvipesrear': badvipesrear,

                    'badlightsfront': badlightsfront,

                    'badlightsrear': badlightsrear,

                    'badshockabsorberfront': badshockabsorberfront,

                    'badshockabsorberrear': badshockabsorberrear,

                    'badtiresfront': badtiresfront,

                    'badtiresrear': badtiresrear,

                    'badsuspensionfront': badsuspensionfront,

                    'badsuspensionrear': badsuspensionrear,

                    'badbrakesfront': badbrakesfront,

                    'badbrakesrear': badbrakesrear,

                    'badexhaust': badexhaust,

                    'badsealedengine': badsealedengine,

                    'badsealedgearbox': badsealedgearbox,

                    'badwindshield': badwindshield,


                    'mediummotoroil': mediummotoroil,

                    'mediumcflevel': mediumcflevel,

                    'mediumcftemp': mediumcftemp,

                    'mediumbrakefluid': mediumbrakefluid,

                    'mediumbattery': mediumbattery,

                    'mediumvipesfront': mediumvipesfront,

                    'mediumvipesrear': mediumvipesrear,

                    'mediumlightsfront': mediumlightsfront,

                    'mediumlightsrear': mediumlightsrear,
                    'mediumshockabsorberfront': mediumshockabsorberfront,

                    'mediumshockabsorberrear': mediumshockabsorberrear,
                    'mediumtiresfront': mediumtiresfront,

                    'mediumtiresrear': mediumtiresrear,

                    'mediumsuspensionfront': mediumsuspensionfront,

                    'mediumsuspensionrear': mediumsuspensionrear,

                    'mediumbrakesfront': + mediumbrakesfront,

                    'mediumbrakesrear': + mediumbrakesrear,

                    'mediumexhaust': mediumexhaust,

                    'mediumsealedengine': mediumsealedengine,

                    'mediumsealedgearbox': mediumsealedgearbox,

                    'mediumwindshield': mediumwindshield
                });

            });

            $('#modal_next').on('click', function (e) {

                var rows = $("#car-table").tabulator("getSelectedRows");
                var str = "";
               
                for (i = 0; i < rows.length; i++) {

                    console.log(rows[i].getData().MOBILE);
                    str += rows[i].getData().CustomerName + " & ";
                    mobile[i] = rows[i].getData().MOBILE;
                }
                //swal("SMS er sendt til følgende kunder: " +str);
                //$("#modScheme").modal('hide');
                console.log(mobile);
                initSecondStep();
            });
            $('#xtracheckSendSms').on('click', function (e) {

                if (myNameSpace.get("po_modal_state") == 2) {
                    //myNameSpace.set("po_modal_state", 1);
                    if ($("#rbSendSMS").prop('checked')) {
                        if ($("#<%=txtSMSText.ClientID%>").val() != "") {
                        var msg = "Manuell SMS";
                             smstext = $("#<%=txtSMSText.ClientID%>").val();
                             fetchSMSConfig(msg)


                         }
                         else {
                             swal("Du må skrive en tekst og legge til mobilnr før du kan sende sms eller mail.");
                         }
                     }
                     else {
                         swal("Du forsøker nå å sende epost. Sjekk at felter er utfyult rett.");
                     }
                    initThirdStep();
                }
            });
            $('#modal_previous').on('click', function (e) {

                if (myNameSpace.get("po_modal_state") == 2) {
                    //myNameSpace.set("po_modal_state", 1);
                    initFirstStep();
                }
                else if (myNameSpace.get("po_modal_state") == 3) {
                    //myNameSpace.set("po_modal_state", 1);
                    initSecondStep();
                }
            });
            $('#modal_close').on('click', function (e) {
                    initFirstStep();
            });


            $('#btnDownloadCSV').on('click', function (e) {
                $("#car-table").tabulator("download", "csv", "export.csv", {


                });

            });

            $('#btnDownloadPDF').on('click', function (e) {
                $("#car-table").tabulator("download", "pdf", "data.pdf", {
                    orientation: "portrait", //set page orientation to portrait
                    title: "Xtrasjekk utvalg", //add title to report
                    autoTable: { //advanced table styling

                        styles: {
                            fillColor: [175, 200, 245]
                        },
                        columnStyles: {
                            id: { fillColor: 255 }
                        },
                        margin: { top: 60 },
                    },

                });

            });

            $('#btnSendMessage').on('click', function (e) {
               

            });

            $('#<%=btnEditSMSText.ClientID%>').on('click', function () {
                $('#<%=txtEditSMSText.ClientID%>').val($('#<%=txtSMSText.ClientID%>').val());
                $('#editTextValue').html($('#<%=optSMSText.ClientID%>').val());
                $('#modSMSTexts').modal('setting', {
                    onDeny: function () {
                        
                       
                    },
                    onApprove: function () {
                        alert($('#editTextValue').html() + " " + $('#<%=txtEditSMSText.ClientID%>').val());
                        if ($('#editTextValue').html() != "" && $('#<%=txtEditSMSText.ClientID%>').val() != "") {
                            saveNewMessageTemplate($('#editTextValue').html(), $('#<%=txtEditSMSText.ClientID%>').val());

                }
                        else if ($('#editTextValue').html() == "" && $('#<%=txtEditSMSText.ClientID%>').val() != "") {
                            saveNewMessageTemplate("", $('#<%=txtEditSMSText.ClientID%>').val());
            }
                       else {
                swal("Error with run the savings to the DB: dropdwn verdien er: " + $('#editTextValue').html())
            }
                       
                    },
                    onShow: function () {
                        $(this).children('ui.button.ok.positive').focus();
                    }
                }).modal('show');
                $("#modScheme").modal('show');
            });

            $('#<%=optSMSText.ClientID%>').on('change', function () {
                $('#<%=txtSMSText.ClientID%>').val($('#<%=optSMSText.ClientID%> option:selected').text());
            });

            $("#<%=btnEditSMSNew.ClientID%>").on('click', function () {

                $('#<%=txtEditSMSText.ClientID%>').val('');
                $('#editTextValue').html('');
                
            });

            $("#car-table").tabulator({
                height: 500, // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                layout: "fitColumns", //fit columns to width of table (optional)                  
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string
                selectable: true,
                selectablePersistence: false,
                selectableCheck: function (row) {

                    return true; //alow selection of rows where the age is greater than 18
                },

                rowDblClick: function (e, row) {
                    //e - the click event object
                    //row - row component
                    // openModalItemInformation(row, "Archived");
                },
                columns: [ //Define Table Columns
                    { title: "Refnr", field: "RefNo", width: 120, align: "center" },
                    { title: "Regnr", field: "VehRegNo", width: 120, align: "center", },
                    { title: "Bil", field: "Make", width: 150, align: "center" },
                    { title: "Modell", field: "Model", width: 180, align: "center" },
                    { title: "Kunde", field: "Customer", width: 120, align: "center", editor: "number" },
                    { title: "Kundenavn", field: "CustomerName", align: "center" },
                    { title: "Telefon", field: "MOBILE", width: 120, align: "center" },
                    { title: "Epost", field: "MAIL", align: "center" }



                ],

                ajaxResponse: function (url, params, response) {


                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //Return the d Property Of a response json Object
                },


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
            //Print button directly on the page before runing the selection
            $('#<%=btnOpenReport.ClientID%>').on('click', function () {
                
                fetchReportValues();
                   // window.parent.$('.ui-dialog-content:visible').dialog('close');
            });

            //Buttonclick on initthirdstep in modal
            $('#btnPrintReport').on('click', function () {
                $("#modScheme").modal('hide');
                fetchReportValues();
                // window.parent.$('.ui-dialog-content:visible').dialog('close');
            });

           

        }); //end of ready



        function fetchReportValues() {
            var array = [];
            var i = 0;
            $('.selectionList').each(function (index, item) {

                ($(item).is(':checked'));
                if ($(item).is(':checked') == true) {
                    //alert("is true");
                    if (i <= 20) {
                        //alert("less than 21");
                        array[i] = 2;
                    }
                    else {
                        array[i] = 1;
                    }

                }
                else {
                    array[i] = 0;

                }
                i++;

            });

            var badmotoroil = array[0];
            //alert(badmotoroil + array[0]);
            var badcflevel = array[1];
            var badcftemp = array[2];
            var badbrakefluid = array[3];
            var badbattery = array[4];
            var badvipesfront = array[5];
            var badvipesrear = array[6];
            var badlightsfront = array[7];
            var badlightsrear = array[8];
            var badshockabsorberfront = array[9];
            var badshockabsorberrear = array[10];
            var badtiresfront = array[11];
            var badtiresrear = array[12];
            var badsuspensionfront = array[13];
            var badsuspensionrear = array[14];
            var badbrakesfront = array[15];
            var badbrakesrear = array[16];
            var badexhaust = array[17];
            var badsealedengine = array[18];
            var badsealedgearbox = array[19];
            var badwindshield = array[20];


            var mediummotoroil = array[21];
            var mediumcflevel = array[22];
            var mediumcftemp = array[23];
            var mediumbrakefluid = array[24];
            var mediumbattery = array[25];
            var mediumvipesfront = array[26];
            var mediumvipesrear = array[27];
            var mediumlightsfront = array[28];
            var mediumlightsrear = array[29];
            var mediumshockabsorberfront = array[30];
            var mediumshockabsorberrear = array[31];
            var mediumtiresfront = array[32];
            var mediumtiresrear = array[33];
            var mediumsuspensionfront = array[34];
            var mediumsuspensionrear = array[35];
            var mediumbrakesfront = array[36];
            var mediumbrakesrear = array[37];
            var mediumexhaust = array[38];
            var mediumsealedengine = array[39];
            var mediumsealedgearbox = array[40];
            var mediumwindshield = array[41];
            console.log('fetchvehicle');
            $.ajax({
                type: "POST",
                url: "frmXtraCheck.aspx/FetchReportValues",
                data: "{'badmotoroil':'" + badmotoroil + "', 'badcflevel':'" + badcflevel + "', 'badcftemp':'" + badcftemp + "', 'badbrakefluid':'" + badbrakefluid + "', 'badbattery':'" + badbattery
                    + "', 'badvipesfront':'" + badvipesfront + "', 'badvipesrear':'" + badvipesrear + "', 'badlightsfront':'" + badlightsfront + "', 'badlightsrear':'" + badlightsrear
                    + "', 'badshockabsorberfront':'" + badshockabsorberfront + "', 'badshockabsorberrear':'" + badshockabsorberrear + "', 'badtiresfront':'" + badtiresfront
                    + "', 'badtiresrear':'" + badtiresrear + "', 'badsuspensionfront':'" + badsuspensionfront + "', 'badsuspensionrear':'" + badsuspensionrear
                    + "', 'badbrakesfront':'" + badbrakesfront + "', 'badbrakesrear':'" + badbrakesrear + "', 'badexhaust':'" + badexhaust
                    + "', 'badsealedengine':'" + badsealedengine + "', 'badsealedgearbox':'" + badsealedgearbox + "', 'badwindshield':'" + badwindshield

                    + "', 'mediummotoroil':'" + mediummotoroil + "', 'mediumcflevel':'" + mediumcflevel + "', 'mediumcftemp':'" + mediumcftemp
                    + "', 'mediumbrakefluid':'" + mediumbrakefluid + "', 'mediumbattery':'" + mediumbattery + "', 'mediumvipesfront':'" + mediumvipesfront + "', 'mediumvipesrear':'" + mediumvipesrear
                    + "', 'mediumlightsfront':'" + mediumlightsfront + "', 'mediumlightsrear':'" + mediumlightsrear
                    + "', 'mediumshockabsorberfront':'" + mediumshockabsorberfront + "', 'mediumshockabsorberrear':'" + mediumshockabsorberrear + "', 'mediumtiresfront':'" + mediumtiresfront
                    + "', 'mediumtiresfront':'" + mediumtiresfront + "', 'mediumtiresrear':'" + mediumtiresrear + "', 'mediumsuspensionfront':'" + mediumsuspensionfront
                    + "', 'mediumsuspensionrear':'" + mediumsuspensionrear + "', 'mediumbrakesfront':'" + mediumbrakesfront + "', 'mediumbrakesrear':'" + mediumbrakesrear
                    + "', 'mediumexhaust':'" + mediumexhaust + "', 'mediumsealedengine':'" + mediumsealedengine + "', 'mediumsealedgearbox':'" + mediumsealedgearbox + "', 'mediumwindshield':'" + mediumwindshield + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    if (data.d.length != 0) {
                        console.log('Success response');
                        // popupXtraChkReport.ShowWindow(popupXtraChkReport.GetWindow(0));                        
                            cbXtraCheck.PerformCallback();
                        }
                        else {
                            var res = GetMultiMessage('0008', '', '');
                        }
                    },
                    failure: function () {
                        alert("Failed!");
                    }
                });
        }

        function initFirstStep() {
            $('.modal_step_one').removeClass('hidden');
            $('.modal_step_two').addClass('hidden');
            $('.modal_step_three').addClass('hidden');


            //header steps
            $("#step_one").removeClass("completed step");
            $("#step_one").removeClass("disabled step");
            $("#step_one").addClass("active step");

            $("#step_two").removeClass("active step");
            $("#step_two").removeClass("completed step");
            $("#step_two").addClass("disabled step");

            $("#step_three").removeClass("active step");
            $("#step_three").removeClass("completed step");
            $("#step_three").addClass("disabled step");


            //buttons
            //$("#po_modal_save").show();
            $("#xtracheckSendSms").hide();
            $("#modal_previous").hide();
            $("#modal_next").show();
            myNameSpace.set("po_modal_state", 1);
        }

        function initSecondStep() {
            //brings over various variables from grid to the modal window
            myNameSpace.set("po_modal_state", 2);
            //content divs(tables)

            $('.modal_step_one').addClass('hidden');
            $('.modal_step_two').removeClass('hidden');
            $('.modal_step_three').addClass('hidden');


            //header steps
            $("#step_one").addClass("completed step");
            $("#step_one").addClass("disabled step");
            $("#step_one").removeClass("active");

            $("#step_two").addClass("active");
            $("#step_two").removeClass("disabled");

            $("#step_three").removeClass("active step");
            $("#step_three").removeClass("completed step");
            $("#step_three").addClass("disabled step");

            //button states
            
            $("#xtracheckSendSms").show();
            $("#modal_previous").show();
            $("#modal_next").hide();

        }

        function initThirdStep() {
            //brings over various variables from grid to the modal window
            myNameSpace.set("po_modal_state", 3);
            //content divs(tables)

            $('.modal_step_one').addClass('hidden');
            $('.modal_step_two').addClass('hidden');
            $('.modal_step_three').removeClass('hidden');


            //header steps
            $("#step_one").addClass("completed step");
            $("#step_one").addClass("disabled step");
            $("#step_one").removeClass("active");

            $("#step_two").addClass("completed step");
            $("#step_two").addClass("disabled step");
            $("#step_two").removeClass("active");

            $("#step_three").addClass("active");
            $("#step_three").removeClass("disabled");

           

            //button states

            $("#xtracheckSendSms").hide();
            $("#modal_previous").show();
            $("#modal_next").hide();
            $("#modal_close").show();

        }

        function fillSMSTexts() {

            $.ajax({
                type: "POST",
                url: "frmXtraCheck.aspx/FillSMSTexts",
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
        function saveNewMessageTemplate(id, text) {
            
            // 0 = good,  1= ok, 2=action should be taken

            //$('input[type=checkbox]').prop('checked');
            var tempType = "XTRACHECK";

            alert("nå er du i lagre funksjon" + id + text + tempType);
          

             $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "frmXtraCheck.aspx/SaveMessageTemplate",
                  data: "{'tempId':'" + id
                        + "',tempText:'" + text
                      + "',tempType:'" + tempType + "'}",
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

        /*Fetches the data you need from sms config to be able to send sms. Username, password etc.*/
        function fetchSMSConfig(type) {
            var phone = mobile;
            var textvalue = smstext;
           // alert("dette er tlfnr " + mobile);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../master/frmSendSMS.aspx/LoadSMSConfig",
                data: "{'department':'" + "" + "'}",
                dataType: "json",
                async: false,//Very important
                success: function (Result) {
                    if (Result.d.length > 0) {
                        arrayOfValues[0] = Result.d[0].DEPARTMENT

                        arrayOfValues[1] = Result.d[0].SENDER_SMS
                        arrayOfValues[2] = Result.d[0].USER_ID
                        arrayOfValues[3] = Result.d[0].USER_PASSWORD
                        arrayOfValues[4] = Result.d[0].SMS_OPERATOR_LINK
                        arrayOfValues[5] = Result.d[0].SUB_NAME
                        arrayOfValues[6] = Result.d[0].SUB_PHONE

                        //return arrayOfValues;
                        //var messageType = "Manuell SMS";
                        //saveSMSGlobal(, Result.d[0]., phoneTo, messageType, messageText, time, Result.d[0].USER_ID, Result.d[0].USER_PASSWORD, Result.d[0].SMS_OPERATOR_LINK);
                        //sendXtraCheckWeb();
                        if (type == "Manuell SMS") {
                            for (var i = 0; i < mobile.length; i++) {
                                //alert(mobile[i]);
                                sendSMS(mobile[i], smstext, "");
                            }
                            
                        }
                        else {
                            swal("SMS ble ikke sendt!")
                        }
                            //xtraCheckMobile()
                        //sendSMS(mobile);
                       

                    }
                }
            });
        }

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
            var user = encodeURIComponent(arrayOfValues[2]);
            var passres = encodeURIComponent(arrayOfValues[3]);
            var deliveryreporturl = arrayOfValues[4];
            //alert(passres);
            $.ajax({
                type: "POST",
                url: "../master/frmSendSMS.aspx/SendSMS",
                data: "{num: '" + num + "', 'message': '" + message + "', 'time': '" + time + "', 'id': '" + smsid + "', 'user': '" + user + "', 'password': '" + passres + "', 'dru': '" + deliveryreporturl + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length != 0) {
                        if (data.d == "OK") {
                            var msg = "UTVALG XTRASJEKK"
                            saveSMS(msg, mob, text);
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

        function saveSMS(messageType, mob, text) {
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
                    url: "../master/frmSendSMS.aspx/SaveSMS",
                    data: "{dept: '" + "22" + "', phoneFrom:'" + arrayOfValues[1] + "', phoneTo:'" + mob + "', messageType:'" + msgType + "', messageText:'" + text + "', time:'" + time + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d[0] != "") {
                           //sendSMS($("#<%=txtMobile.ClientID%>").val(), $("#<%=txtSMSText.ClientID%>").val(), data.d[0]);
                            //swal("SMS er sendt!")
                           
                        }
                        else {
                            swal("SMS ble ikke lagret og derfor ikke sendt.");
                        }
                    },
                    error: function (result) {
                        alert("Error uten at jeg vet hva som feila i savesms");
                    }
                });
        };


        function loadInit() {
            initFirstStep();
            fillSMSTexts();
        }

        function OnXtraCheckEndCallBack() {
            popupXtraChkReport.ShowWindow(popupXtraChkReport.GetWindow(0)); 
        }


    </script>



    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
    <div class="ui form stackable three column grid">
        

        <div class="two wide column">
            <h5 class="ui header">Bør utbedres</h5>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badEngineOil" class="selectionList" name="example" />
                    <label>Motoroljenivå</label>

                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badFreezeLevel" class="selectionList" name="example" />
                    <label>Frostvæskenivå</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badFreezeTemp" class="selectionList" name="example" />
                    <label>Frostvæske-frysepunkt</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badBrakeFluid" class="selectionList" name="example" />
                    <label>Bremsevæskenivå</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badBattery" class="selectionList" name="example" />
                    <label>Batterinivå</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badViperBack" class="selectionList" name="example" />
                    <label>Vindusvisker bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badViperFront" class="selectionList" name="example" />
                    <label>Vindusvisker foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badLightsBack" class="selectionList" name="example" />
                    <label>Lyspærer bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badLightsFront" class="selectionList" name="example" />
                    <label>Lyspærer foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badSuspensionFront" class="selectionList" name="example" />
                    <label>Støtdempere foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badSuspensionBack" class="selectionList" name="example" />
                    <label>Støtdempere bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badTiresFront" class="selectionList" name="example" />
                    <label>Dekk foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badTiresBack" class="selectionList" name="example" />
                    <label>Dekk bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badAxleFront" class="selectionList" name="example" />
                    <label>Drivakslinger høyre</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badAxleBack" class="selectionList" name="example" />
                    <label>Drivakslinger venstre</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badBrakesFront" class="selectionList" name="example" />
                    <label>Bremseklosser foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badBrakesBack" class="selectionList" name="example" />
                    <label>Bremseklosser bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badExhaust" class="selectionList" name="example" />
                    <label>Eksosanlegg</label>
                </div>
            </div>
            <div class="fields">

                <div class="ui checkbox">
                    <input type="checkbox" id="badDensityEngine" class="selectionList" name="example" />
                    <label>Tetthet(motor)</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badDensityGear" class="selectionList" name="example" />
                    <label>Tetthet(gir)</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="badWindshield" class="selectionList" name="example" />
                    <label>Frontrute</label>
                </div>
            </div>
        </div>

        <div class="one wide column"></div>
        <div class="four wide column">
            <h5 class="ui header">Under oppsyn</h5>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumEngineOil" class="selectionList" name="example" />
                    <label>Motoroljenivå</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumFreezeLevel" class="selectionList" name="example" />
                    <label>Frostvæskenivå</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumFreezeTemp" class="selectionList" name="example" />
                    <label>Frostvæske-frysepunkt</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumBrakeFluid" class="selectionList" name="example" />
                    <label>Bremsevæskenivå</label>
                </div>
            </div>
            <div class="fields">

                <div class="ui checkbox">
                    <input type="checkbox" id="mediumBattery" class="selectionList" name="example" />
                    <label>Batterinivå</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumViperBack" class="selectionList" name="example" />
                    <label>Vindusvisker bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumViperFront" class="selectionList" name="example" />
                    <label>Vindusvisker foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumLightsBack" class="selectionList" name="example" />
                    <label>Lyspærer bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumLightsFront" class="selectionList" name="example" />
                    <label>Lyspærer foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumSuspensionFront" class="selectionList" name="example" />
                    <label>Støtdempere foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumSuspensionBack" class="selectionList" name="example" />
                    <label>Støtdempere bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumTiresFront" class="selectionList" name="example" />
                    <label>Dekk foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumTiresBack" class="selectionList" name="example" />
                    <label>Dekk bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumAxleFront" class="selectionList" name="example" />
                    <label>Drivakslinger høyre</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumAxleBack" class="selectionList" name="example" />
                    <label>Drivakslinger venstre</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumBrakesFront" class="selectionList" name="example" />
                    <label>Bremseklosser foran</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumBrakesBack" class="selectionList" name="example" />
                    <label>Bremseklosser bak</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumExhaust" class="selectionList" name="example" />
                    <label>Eksosanlegg</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumDensityEngine" class="selectionList" name="example" />
                    <label>Tetthet(motor)</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumDensityGear" class="selectionList" name="example" />
                    <label>Tetthet(gir)</label>
                </div>
            </div>
            <div class="fields">
                <div class="ui checkbox">
                    <input type="checkbox" id="mediumWindshield" class="selectionList" name="example" />
                    <label>Frontrute</label>
                </div>
            </div>
        </div>
         <div class="fields">

             </div>
        </div>
    </div>
    <div class="actions">
                 <button type="button" id="btnScheme" class="ui button carsButtonBlueInverted" value="SKjema">Kjør utvalg</button>

                   <input id="btnOpenReport" runat="server" class="ui button carsButtonBlueInverted" value="Skriv ut" type="button" />

            </div>
       <div class="fields">
    <div class="two wide field">
      
    </div>
            <div class="two wide field">
         
 </div>
        </div>



    <div class="ui fullscreen modal" id="modScheme">
        <i class="close icon"></i>
        <a class="ui red ribbon label" id="redRibbonPOmodal"></a>
        <div class="header">
            <div class="ui three top attached steps">
                <div class="active step" id="step_one">
                    <i class="dollar sign icon"></i>
                    <div class="content">
                        <div class="title">Utvalg</div>
                        <div class="description">Liste over de som kommer opp i utvalget</div>
                    </div>
                </div>
                <div class="disabled step" id="step_two">
                    <i class="pencil icon"></i>
                    <div class="content">
                        <div class="title">Edit message</div>
                        <div class="description">Skriv og editer det du ønsker at dkal bli sendt</div>
                    </div>
                </div>
                <div class="disabled step" id="step_three">
                    <i class="close alternate icon"></i>
                    <div class="content">
                        <div class="title">Meldinger sendt</div>
                        <div class="description">Bekreftelse på at alt er sendt.</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ui blue top medium header center aligned" style="text-align: center;">Utvalg</div>
        <div class="content">
            <div class="modal_step_one">


                <div class="ui form ">

                    <div class="ui grid">

                        <div class="sixteen wide column">
                            <div class="ui form">
                                <div id="car-table" class="mytabulatorclass"></div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="modal_step_two">


                <div class="ui form ">

                    <div class="ui grid">
                        <div class="two wide column"></div>
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
                                            <input type="button" value="Send melding" id="btnSendMessage" class="ui button carsButtonBlueInverted wide hidden" />
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
                        <div class="two wide column"></div>
                    </div>

                </div>
            </div>
                        <div class="modal_step_three">


                <div class="ui form ">

                    <div class="ui grid">
                        <div class="two wide column">SMS are sent correctly!</div>
                        </div>
                    </div>
            </div>
            </div>
            <div class="actions">
                <div class="ui grey enabled right labeled icon left floated  button" id="btnDownloadCSV">
                    Eksporter
                <i class="file outline icon"></i>
                </div>

                <div class="ui grey enabled right labeled icon left floated button" id="btnDownloadPDF">
                    PDF
                <i class="file pdf icon"></i>
                </div>
                 <div class="ui blue enabled right labeled icon left floated button" id="btnPrintReport">
                    Skriv ut
                <i class="print icon"></i>
                </div>


                <div class="ui black right labeled icon button" id="modal_previous">
                    <div>Tilbake</div>
                    <i class="chevron left icon"></i>
                </div>

                <div class="ui yellow enabled right labeled icon button" id="xtracheckSendSms">
                    Send sms 
                <i class="retweet icon"></i>
                </div>


                <div class="ui green enabled right labeled icon button" id="modal_next">
                    <div>Neste</div>
                    <i class="chevron right icon"></i>

                </div>



                <div class="ui negative cross labeled icon button" id="modal_close">
                    <div>Lukk</div>
                    <i class="chevron right icon"></i>

                </div>
            </div>
        
    </div>

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
                                <label id="editTextValue" class="hidden">&nbsp;</label>
                                <p>
                                    <asp:Label runat="server" ID="Label11" meta:resourcekey="CustomerLock1Resource1" Text="Rediger den valgte teksten fra SMS Tekster"></asp:Label>
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


    <dx:ASPxCallbackPanel ID="cbXtraCheck" ClientInstanceName="cbXtraCheck" runat="server" OnCallback="cbXtraCheck_Callback" ClientSideEvents-EndCallback="OnXtraCheckEndCallBack">
        <PanelCollection>
            <dx:PanelContent>
                <div>
                    <dx:ASPxPopupControl ID="popupXtraChkReport" runat="server" ClientInstanceName="popupXtraChkReport" AllowDragging="true" Modal="True" Theme="iOS" CloseAction="CloseButton">
                        <Windows>
                            <dx:PopupWindow ContentUrl="ReportViewer_Transaction.aspx" HeaderText="XtraCheck" Name="report"
                                                Text="Report" Height="700px" Left="300" Width="1200px" Modal="True" Top="100">
                            </dx:PopupWindow>
                        </Windows>
                    </dx:ASPxPopupControl>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    


</asp:Content>
