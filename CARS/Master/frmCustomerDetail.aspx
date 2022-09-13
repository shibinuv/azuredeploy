<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmCustomerDetail.aspx.vb" Inherits="CARS.frmCustomerDetail" MasterPageFile="~/MasterPage.Master" meta:resourcekey="PageResource2" %>

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
        var custvar = {};
        var contvar = {};
        var errSmtngWrong = '<%=GetLocalResourceObject("ErrSmtngWrong")%>';
        var genIns = "";
        var genUpd = "";

        //console.log(errSmtngWrong); //test committing

        $(document).ready(function () {
          
            var debug = true;
            if (debug) {
                console.log('Debug is active');
            }
            var getUrlParameter = function getUrlParameter(sParam) {
                var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;

                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');

                    if (sParameterName[0] === sParam) {
                        return sParameterName[1] === undefined ? true : sParameterName[1];
                    }
                }
            };

            //Check the page name from where it is called before hiding the banners
            var pageNameFrom = getUrlParameter('pageName');
            let arrayOfValues = [];
            if ((pageNameFrom == "OrderHead" || pageNameFrom == "Vehicle" || pageNameFrom=="AppointmentFormCustomer" || pageNameFrom=="TireHotel") && pageNameFrom != undefined) {
                //$('#topBanner').hide();
                //$('#topNav').hide();
                //$('#carsSideBar').hide();
                $('#mainHeader').hide();
                $('#second').hide();



            }

            $('.menu .item')
                .tab()
                ; //activate the tabs

            var cust = getUrlParameter('cust');
            var fetchFLG = false;
            loadInit();
            function loadInit() {
                setCustomerType();
                setTab('Customer');
                setBillAdd();
                FillCustGroup();
                FillPayType();
                FillPayTerms();
                //LoadBrreg();
                loadSalesman();
                loadBranch();
                loadCategory();
                loadSalesGroup();
                loadPaymentTerms();
                loadCardType();
                loadCurrencyType();
                loadContactType();
                LoadCustomerTemplate();
                requiredFields('', '');
                $('#ctl00_cntMainPanel_ddlCustomerTemplate option[value="01"]').prop('selected', true);
                var tempId = $('#<%=ddlCustomerTemplate.ClientID%>').val();
                FetchCustomerTemplate(tempId);
                FetchCustomerDetails(cust);
                setSaveVar();
                fetchSMSConfig2();
                
            }
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
            function collectGroupData(dataTag) {
                dataCollection = {};
                $('[data-' + dataTag + ']').each(function (index, elem) {
                    var st = $(elem).data(dataTag);
                    var dv = '';
                    var elemType = $(elem).prop('nodeName');
                    switch (elemType) {
                        case 'INPUT':
                            dv = $(elem).val();
                            break;
                        case 'TEXTAREA':
                            dv = $(elem).val();
                            break;
                        case 'SELECT':
                            dv = $(elem).val();
                            break;
                        case 'LABEL':
                            dv = $(elem).html();
                            break;
                        case 'SPAN':
                            if ($(elem).children('input').is(':checked')) {
                                dv = '1';
                            } else {
                                dv = '0';
                            }
                            break;
                        default:
                            dv = '01';
                    }
                    if (debug) {
                        console.log(index + ' Added ' + dataTag + ': ' + st + ' with value: ' + dv + ' and type: ' + elemType);
                    }
                    dataCollection[st] = $.trim(dv);
                });
                return dataCollection;
            }
            // END GEN MOD SCRIPTS
            // Context menu test 
            $.contextMenu({
                selector: '#<%=txtAdvSsnNo.ClientID%>',
                items: {
                    copy: {
                        name: '<%=GetLocalResourceObject("CMAdvSsnNoKop")%>', // "Kopier",
                        callback: function (key, opt) {
                            swal($(this).attr('id'));
                        }
                    },
                    brreg: {
                        name:'<%=GetLocalResourceObject("CMAdvSsnNoBron")%>',// "Åpne i Brønnøysundregistrene",
                        callback: function (key, opt) {
                            window.open('https://w2.brreg.no/enhet/sok/detalj.jsp?orgnr=' + $(this).val());
                        }
                    },
                    proff: {
                        name: '<%=GetLocalResourceObject("CMAdvSsnNoProff")%>',//"Åpne i Proff",
                        callback: function (key, opt) {
                            window.open('http://www.proff.no/bransjes%C3%B8k?q=' + $(this).val());
                        }
                    },
                    sub: {
                        "name": '<%=GetLocalResourceObject("CMAdvSsnNoSG")%>', //"Sub group",
                        "items": {
                            copy: {
                                name: '<%=GetLocalResourceObject("CMAdvSsnNoKop")%>' ,//"Kopier",
                                callback: function (key, opt) {
                                    swal($(this).attr('id'));
                                }
                            },
                            brreg: {
                                name: '<%=GetLocalResourceObject("CMAdvSsnNoBron")%>',//"Åpne i Brønnøysundregistrene",
                                callback: function (key, opt) {
                                    window.open('https://w2.brreg.no/enhet/sok/detalj.jsp?orgnr=' + $(this).val());
                                }
                            },
                            proff: {
                                name: '<%=GetLocalResourceObject("CMAdvSsnNoProff")%>',//"Åpne i Proff",
                                callback: function (key, opt) {
                                    window.open('http://www.proff.no/bransjes%C3%B8k?q=' + $(this).val());
                                }
                            }
                        }
                    }
                }
            });

            var testt = 1;
            $.contextMenu({
                selector: '#<%=ddlContactPerson.ClientID%>',
                items: {
                    contactPerson: {
                        name: '<%=GetLocalResourceObject("CMCntPerAdd")%>',//'Add new contact person',
                        callback: function (key, opt) {
                            clearFormElements('#modContactPerson');
                            modContactPersonShow();
                        }
                    },
                    editContact: {
                        name: '<%=GetLocalResourceObject("CMCntPerEdit")%>',//'View/ edit contact information',
                        disabled: function (key, opt) {
                            if ($('#<%=ddlContactPerson.ClientID%>').val() === '' || $('#<%=ddlContactPerson.ClientID%> > option[value!=""]').length === 0) {
                                return !this.data('editContactDisabled');
                            }
                        },
                        callback: function (key, opt) {
                            clearFormElements('#modContactPerson');
                            viewEditCustomerContactPerson($(this).val());
                            modContactPersonShow();
                        }
                    },
                    deleteContact: {
                        name: '<%=GetLocalResourceObject("CMCntPerDel")%>',//'Delete contact person',
                        disabled: function (key, opt) {
                            if ($('#<%=ddlContactPerson.ClientID%>').val() === '' || $('#<%=ddlContactPerson.ClientID%> > option[value!=""]').length === 0) {
                                return !this.data('deleteContactDisabled');
                            }
                        },
                        callback: function (key, opt) {
                            clearFormElements('#modContactPerson');
                            deleteCustomerContactPerson($(this).val())
                        }
                    }
                }
            });
            function modContactPersonShow() {
                $("#modContactPerson").modal('setting', {
                    autofocus: false,
                    onShow: function () {
                        cpChange = $('#<%=ddlContactPerson.ClientID%>').val();
                    },
                    onDeny: function () {
                        if (debug) { console.log('modContactPerson abort mod executed'); }

                    },
                    onApprove: function () {
                        if (debug) { console.log('modContactPerson ok mod executed'); }
                        if (requiredFields(true, 'data-cp-submit') === true) {
                            var contactPerson = collectGroupData('cp-submit');
                            saveCustomerContactPerson(contactPerson);
                            $('#<%=txtContactPersonTitle.ClientID%>').val($('#<%=txtCPTitle.ClientID%>').val());
                        } else {
                            return false;

                        }
                    }
                })
                    .modal('show')
            }
            $('.coupled.modal')
                .modal({
                    allowMultiple: true
                })
                ;
            $("#<%=txtCPBirthday.ClientID%>").datepicker({
                showWeek: true,
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "-110:-16" // D.O.B. must range between 16 and 110 years old.
            });

            $("#<%=txtCPBirthday.ClientID%>").next(".calendar").on('click', function () {
                $("#<%=txtCPBirthday.ClientID%>").focus();
            });

            function saveCustomerContactPerson(contactPerson) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddCustomerContactPerson",
                    data: "{'CustomerCP': '" + JSON.stringify(contactPerson) + "'}",
                    dataType: "json",
                    //async: false,//Very important
                    success: function (data) {
                        $('.loading').removeClass('loading');
                        if (data.d == "INSFLG") {
                            systemMSG('success', '<%=GetLocalResourceObject("CntPerSaved")%>', 4000); //'Kontaktperson ble lagret!'
                        }
                        else if (data.d == "UPDFLG") {
                            systemMSG('success', '<%=GetLocalResourceObject("CntPerUpdated")%>', 4000); //'Kontaktperson ble oppdatert!'
                            setSaveVar();
                        }
                        else if (data.d == "ERRFLG") {
                            systemMSG('error', '<%=GetLocalResourceObject("CntPerError")%>', 4000);
                        }
                        loadCustomerContactPerson('', $('#<%=txtCustomerId.ClientID%>').val());
                        console.log('textvalue' + $('#<%=txtCustomerId.ClientID%>').val());
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }
            var cpChange = '';
            function loadCustomerContactPerson(ID_CP, CP_CUSTOMER_ID) {
                console.log(CP_CUSTOMER_ID);
                if ($('#<%=txtCustomerId.ClientID%>').length > 0) {

                    if (debug) {
                        console.log('Running loadCustomerContactPerson(' + ID_CP + ',' + CP_CUSTOMER_ID + ')');
                    }
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCustomerDetail.aspx/FetchCustomerContactPerson",
                        data: "{'ID_CP': '" + ID_CP + "', 'CP_CUSTOMER_ID': '" + CP_CUSTOMER_ID + "'}",
                        dataType: "json",
                        async: false,
                        success: function (result) {
                            $('#<%=ddlContactPerson.ClientID%>').empty().prop('disabled', false);
                            result = result.d;

                            $('#<%=ddlContactPerson.ClientID%>').prepend('<option selected="selected" value="">-- select contact person --</option>');
                            $.each(result, function (key, value) {
                                $('#<%=ddlContactPerson.ClientID%>').append($("<option></option>").val(value.ID_CP).html(value.CP_FIRST_NAME + " " + value.CP_MIDDLE_NAME + " " + value.CP_LAST_NAME));
                                if (cpChange === '') {
                                    $('#<%=ddlContactPerson.ClientID%>').val(value.CUSTOMER_CONTACT_PERSON);
                                    $('#<%=txtContactPersonTitle.ClientID%>').val(value.CP_TITLE_DESC);
                                } else {
                                    $('#<%=ddlContactPerson.ClientID%>').val(cpChange);
                                    console.log('I should NOT run');
                                }
                            });
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                        }
                    });
                } else {
                    <%--$('#<%=ddlContactPerson.ClientID%>').empty();
                    $('#<%=ddlContactPerson.ClientID%>').prepend('<option selected="selected" value="">-- select contact person --</option>');
                    $.each(contactPersonList, function (key, value) {
                        $('#<%=ddlContactPerson.ClientID%>').append($("<option></option>").val('').html(contactPersonList[key].CP_FIRST_NAME + " " + contactPersonList[key].CP_MIDDLE_NAME + " " + contactPersonList[key].CP_LAST_NAME));
                    });--%>
                    $('#<%=ddlContactPerson.ClientID%>').empty().prop('disabled', true);
                }
            }
            function viewEditCustomerContactPerson(ID_CP) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/FetchCustomerContactPerson",
                    data: "{'ID_CP': '" + ID_CP + "', 'CP_CUSTOMER_ID': ''}",
                    dataType: "json",
                    success: function (result) {
                        r = result.d[0];
                        $('#<%=txtCPID.ClientID%>').val(r.ID_CP);
                        $('#<%=txtCPFirstName.ClientID%>').val(r.CP_FIRST_NAME);
                        $('#<%=txtCPMiddleName.ClientID%>').val(r.CP_MIDDLE_NAME);
                        $('#<%=txtCPLastname.ClientID%>').val(r.CP_LAST_NAME);
                        $('#<%=txtCPPostalAddress.ClientID%>').val(r.CP_PERM_ADD);
                        $('#<%=txtCPVisitAddress.ClientID%>').val(r.CP_VISIT_ADD);
                        $('#<%=txtCPZip.ClientID%>').val(r.CP_ZIP_CODE);
                        $('#<%=txtCPZipCity.ClientID%>').val(r.CP_ZIP_CITY);
                        $('#<%=txtCPEmail.ClientID%>').val(r.CP_EMAIL);
                        $('#<%=txtCPTitleCode.ClientID%>').val(r.CP_TITLE_CODE);
                        if (r.CP_TITLE_CODE.length > 0) {
                            fetchCPTitle(r.CP_TITLE_CODE, function (result) {
                                $('#<%=txtCPTitle.ClientID%>').val(result);
                            });
                        }
                        if (r.CP_FUNCTION_CODE.length > 0) {
                            fetchCPTitle(r.CP_FUNCTION_CODE, function (result) {
                                $('#<%=txtCPFunction.ClientID%>').val(result);
                            });
                        }
                        $('#<%=txtCPFunction.ClientID%>').val(r.CP_FUNCTION_CODE);
                        $('#<%=txtCPPhonePrivate.ClientID%>').val(r.CP_PHONE_PRIVATE);
                        $('#<%=txtCPPhoneMobile.ClientID%>').val(r.CP_PHONE_MOBILE);
                        $('#<%=txtCPPhoneFax.ClientID%>').val(r.CP_PHONE_FAX);
                        $('#<%=txtCPPhoneWork.ClientID%>').val(r.CP_PHONE_WORK);
                        $('#<%=txtCPBirthday.ClientID%>').val(r.CP_BIRTH_DATE);
                        $('#<%=txtCPNotes.ClientID%>').val(r.CP_NOTES);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }
            $('#btnCPDelete').on('click', function (e) {
                e.preventDefault;
                deleteCustomerContactPerson($('#<%=txtCPID.ClientID%>').val());
                $('#modContactPerson').modal('hide');
            });

            function deleteCustomerContactPerson(ID_CP) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/DeleteCustomerContactPerson",
                    data: "{'ID_CP': '" + ID_CP + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d == 'DELFLG') {
                            systemMSG('success', '<%=GetLocalResourceObject("CntPerDeleted")%>', 4000); //'Customer contact person was successfully deleted'
                        }
                        else if (data.d == 'ERRFLG') {
                            systemMSG('error', '<%=GetLocalResourceObject("CntPerDelError")%>', 4000); //'Something went wrong with the deletion process, please try again'
                        }
                        loadCustomerContactPerson('', $('#<%=txtCustomerId.ClientID%>').val())
                    },
                    failure: function () {
                        systemMSG('error', '<%=GetLocalResourceObject("CntPerDelError")%>', 4000); //'Something went wrong with the deletion process, please try again'
                        loadCustomerContactPerson('', $('#<%=txtCustomerId.ClientID%>').val())
                    }
                });
            }

            function fetchCPTitle(id, result) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/Fetch_CCP_Title",
                    data: "{q:'" + id + "'}",
                    dataType: "json",
                    success: function (data) {
                        result(data.d[0].TITLE_DESCRIPTION);
                    },
                    error: function (xhr, status, error) {
                        swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                        var err = eval("(" + xhr.responseText + ")");
                        swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                    }
                });
            }
            function fetchCPFunction(id, result) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/Fetch_CCP_Function",
                    data: "{q:'" + id + "'}",
                    dataType: "json",
                    success: function (data) {
                        result(data.d[0].FUNCTION_DESCRIPTION);
                    },
                    error: function (xhr, status, error) {
                        swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                        var err = eval("(" + xhr.responseText + ")");
                        swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                    }
                });
            }
            $('.disable-tab').on('keydown', function (e) {
                if (e.keyCode == 9 || e.keyCode == 13) {
                    if (e.preventDefault) {
                        e.preventDefault();
                    }
                    $(this).blur();
                    return false;
                }
            });
            var retCount = 0;
            $('#<%=txtCPTitleCode.ClientID%>').autocomplete({ // Autocomplete function for searching title_code
                autoFocus: true,
                selectFirst: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCustomerDetail.aspx/Fetch_CCP_Title",
                        data: "{q:'" + $('#<%=txtCPTitleCode.ClientID%>').val() + "'}",
                        dataType: "json",
                        minLength: 0,
                        success: function (data) {
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                retCount = 0;
                                response([{ label: '<%=GetLocalResourceObject("ACCPTitleAdd")%>', value: $('#<%=txtCPTitleCode.ClientID%>').val(), val: '' }]); //'Cannot find this title code, add new?'
                            } else
                                response($.map(data.d, function (item) {
                                    retCount = 1;
                                    return {
                                        label: item.TITLE_CODE + ' - ' + item.TITLE_DESCRIPTION,
                                        value: item.TITLE_CODE,
                                        titleID: item.ID_CP_TITLE,
                                        titleCode: item.TITLE_CODE,
                                        titleDescription: item.TITLE_DESCRIPTION,
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                            var err = eval("(" + xhr.responseText + ")");
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    if (retCount === 1) {
                        $('#<%=txtCPTitleCode.ClientID%>').val(i.item.titleCode);
                        $('#<%=txtCPTitle.ClientID%>').val(i.item.titleDescription);
                    } else {
                        CCP_TitleADD();
                    }
                    var TABKEY = 9;
                    if (event.keyCode == TABKEY) {
                        event.preventDefault();
                    }
                }
            }).focus(function () { $(this).find('input').select(); $(this).select(); });

            $('#<%=txtCPFunctionCode.ClientID%>').autocomplete({ // Autocomplete function for searching title_code
                autoFocus: true,
                selectFirst: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCustomerDetail.aspx/Fetch_CCP_Function",
                        data: "{q:'" + $('#<%=txtCPFunctionCode.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                retCount = 0;
                                response([{ label: '<%=GetLocalResourceObject("ACFCAdd")%>', value: $('#<%=txtCPFunctionCode.ClientID%>').val(), val: '' }]); //'Cannot find this function code, add new?'
                            } else
                                response($.map(data.d, function (item) {
                                    retCount = 1;
                                    return {
                                        label: item.FUNCTION_CODE + ' - ' + item.FUNCTION_DESCRIPTION,
                                        value: item.FUNCTION_CODE,
                                        functionID: item.ID_CP_FUNCTION,
                                        functionCode: item.FUNCTION_CODE,
                                        functionDescription: item.FUNCTION_DESCRIPTION,
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                            var err = eval("(" + xhr.responseText + ")");
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    if (retCount === 1) {
                        $('#<%=txtCPFunctionCode.ClientID%>').val(i.item.functionCode);
                        $('#<%=txtCPFunction.ClientID%>').val(i.item.functionDescription);
                    } else {
                        CCP_FunctionADD();
                    }
                    var TABKEY = 9;
                    if (event.keyCode == TABKEY) {
                        event.preventDefault();
                    }
                }
            }).focus(function () { $(this).find('input').select(); $(this).select(); });

            var FunctionADD = 0;
            var TitleADD = 0;
            function CCP_FunctionADD() {
                $('#<%=txtCPFunction.ClientID%>').val('').prop('disabled', false).prop('readonly', false).focus();
                FunctionADD = 1;
            }
            function CCP_TitleADD() {
                $('#<%=txtCPTitle.ClientID%>').val('').prop('disabled', false).prop('readonly', false).focus();
                TitleADD = 1
            }
            function CCP_SaveCode(type, code, description) { // For adding new title and function codes
                var typeDef = '';
                var service = '';
                switch (type) {
                    case 'f':
                        typeDef = 'function';
                        service = 'InsertCCPFunction';
                        break;
                    case 't':
                        typeDef = 'title';
                        service = 'InsertCCPTitle';
                        break;
                    default:
                        return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/" + service,
                    data: "{'code': '" + code + "', 'description': '" + description + "'}",
                    dataType: "json",
                    //async: false,//Very important
                    success: function (data) {
                        $('.loading').removeClass('loading');
                        genIns = typeDef;
                        if (data.d[0] == "INSFLG") {
                            systemMSG('success', `<%=GetLocalResourceObject("GenNewIns")%>`, 4000); // 'The ' + typeDef + ' code has been added' 
                        }
                        else if (data.d[0] == "ERRFLG") {
                            systemMSG('error',`<%=GetLocalResourceObject("GenSavingError")%>` , 4000); //'An error occured while trying to add this ' + typeDef + '.' 
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }
            $('#<%=txtCPTitleCode.ClientID%>').on('focus', function () { // Does a blank search when focusing code
                $('#<%=txtCPTitleCode.ClientID%>').autocomplete("search", "%");
            });
            $('#<%=txtCPTitleCode.ClientID%>').on('blur', function () { // Clears descripton field when clearing out the code field
                if ($('#<%=txtCPTitleCode.ClientID%>').val().length <= 0) {
                    $('#<%=txtCPTitle.ClientID%>').val('');

                }
            });

            $('#<%=txtCPFunctionCode.ClientID%>').on('focus', function () { // Does a blank search when focusing code
                $('#<%=txtCPFunctionCode.ClientID%>').autocomplete("search", "%");
            });
            $('#<%=txtCPFunctionCode.ClientID%>').on('blur', function () { // Clears descripton field when clearing out the code field
                if ($('#<%=txtCPFunctionCode.ClientID%>').val().length <= 0) {
                    $('#<%=txtCPFunction.ClientID%>').val('');
                }
            });
            $('#<%=txtCPFunction.ClientID%>, #<%=txtCPTitle.ClientID%>').on('blur', function (e) { // When user tabs out of the description field
                var type = $(this).data('ccp-type');
                var code = '';
                switch (type) {
                    case 'f':
                        code = $('#<%=txtCPFunctionCode.ClientID%>');
                        $('#custCPAddType').text('function');
                        break;
                    case 't':
                        code = $('#<%=txtCPTitleCode.ClientID%>');
                        $('#custCPAddType').text('title');
                        break;
                    default:
                        return false;
                }
                var description = $(this);
                $('#custCPAddCode').text(code.val());
                console.log('asdasd ' + code.val());
                $('#custCPAddDescription').text(description.val())
                if (FunctionADD = 1) {
                    $('#modContactPersonConfirm').modal('setting', {
                        closable: false,
                        allowMultiple: true,
                        onDeny: function () {
                            description.prop('disabled', true).prop('readonly', true).val('');
                            code.focus();
                        },
                        onApprove: function () {
                            description.prop('disabled', true).prop('readonly', true);
                            CCP_SaveCode(type, code.val(), description.val());
                        }
                    }).modal('show');
                    functionAdd = 0;
                }
            });

            $.contextMenu({
                selector: '#updCustomerTemplate',
                items: {
                    mal: {
                        name: '<%=GetLocalResourceObject("CMUpdateTemplate")%>',//"Oppdater mal",
                        callback: function (key, opt) {
                            overlay('on', 'modUpdateCustTemp');
                            $('#<%=txtCustTempPassword.ClientID%>').focus();

                        }
                    }
                }
            });


            $('#<%=txtCPZip.ClientID%>').autocomplete({ // Autocomplete function for searching zip code
                autoFocus: true,
                selectFirst: true,
                source: function (request, callback) {
                    el = this.element;
                    zipSearch($(el).val(), callback)
                },
                select: function (e, i) {
                    $("#<%=txtCPZip.ClientID%>").val(i.item.val);
                    $("#<%=txtCPZipCity.ClientID%>").val(i.item.city);
                },
            });


            function zipSearch(zipcode, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmVehicleDetail.aspx/GetZipCodes",
                    data: "{'zipCode':'" + zipcode + "'}",
                    dataType: "json",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0] + "-" + item.split('-')[3],
                                val: item.split('-')[0],
                                value: item.split('-')[0],
                                country: item.split('-')[1],
                                state: item.split('-')[2],
                                city: item.split('-')[3],
                            }
                        }))
                    },
                    error: function (xhr, status, error) {
                        swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                        var err = eval("(" + xhr.responseText + ")");
                        swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                    }
                })
            }
            $.contextMenu({
                selector: '#<%=drpSalesman.ClientID%> option',
                items: {
                    copy: {
                        name: '<%=GetLocalResourceObject("CMAdvSsnNoKop")%>',//"Kopier",
                        callback: function (key, opt) {
                            swal($(this).val());
                        }
                    }
                }
            });


            $.contextMenu({
                selector: '[data-contact="contact"]',
                items: {
                    delete: {
                        name: '<%=GetLocalResourceObject("CMRemContInfo")%>',//"Fjern kontaktinformasjon",
                        icon: "delete",
                        callback: function (key, opt) {
                            deleteContactField($(this).prop('id'));
                        }
                    },
                    standard: {
                        name: '<%=GetLocalResourceObject("CMSetDefault")%>',//"Sett som standard",
                        icon: "edit",
                        callback: function (key, opt) {
                            standardContact($(this));
                        }
                    },
                    sms: {
                        name: '<%=GetLocalResourceObject("CMSendSms")%>',//"Send SMS",
                        icon: "edit",
                        callback: function (key, opt) {
                            //alert('SMS has been sent!');
                            //sendSMS($(this).val());
                            $('#<%=txtSendSms.ClientID%>').val("");
                            $('#<%=txtNumberSms.ClientID%>').val($(this).val());
                            $('#modSendSms ').modal('show');
                        }
                    },
                    homepage: {
                        name: '<%=GetLocalResourceObject("CMViewHomePage")%>',//"View homepage",
                        icon: "edit",
                        callback: function (key, opt) {
                            window.open("http://"+$(this).val());
                            //alert($(this).val());
                        }
                    },
                    mail: {
                        name: '<%=GetLocalResourceObject("CMSendEmail")%>',//"Send epost",
                        icon: "edit",
                        callback: function (key, opt) {
                            //alert($(this).val());
                            //swal("Hvis du ikke får opp rett epostklient, husk å endre standard epostkonto i Windows! ;)")
                            swal('<%=GetLocalResourceObject("CMSendEmail")%>');
                            window.location.href = "mailto:" + $(this).val();
                        }
                    }
                }

            });

            $('#btnSendSMS').on('click', function (e) {
                //e.preventDefault();
                if ($('#<%=txtSendSms.ClientID%>').val() != "") {
                    sendSMS();
                }
                else {
                    //swal("Du må skrive en tekst før du kan sende SMS til kunden.");
                    swal('<%=GetLocalResourceObject("SendSmsAlert")%>');
                }

            });

            function LoadCustomerTemplate() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadCustomerTemplate",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        Result = Result.d;
                        $('#<%=ddlCustomerTemplate.ClientID%>').empty();
                        $.each(Result, function (key, value) {
                            $('#<%=ddlCustomerTemplate.ClientID%>').append($("<option></option>").val(value.ID_CUSTOMER).html(value.CUST_NAME));
                        });

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>'); //"Failed!"
                    }
                });
            }
            var contactCount = 0;
            var contactPersonList = {};

            function FetchCustomerTemplate(tempId) {
                if (debug) { console.log('Length CID: ' + $('#<%=txtCustomerId.ClientID%>').length); }
                if ($('#<%=txtCustomerId.ClientID%>').val().length == 0) {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/FetchCustomerTemplate",
                        data: "{tempId: '" + tempId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {

                            //$('#<%=txtCustomerId.ClientID%>').val(data.d[0].ID_CUSTOMER);
                            if (data.d[0].ID_CUSTOMER.length > 0) {
                                $('#<%=txtCustomerId.ClientID%>').prop('disabled', true);
                            }
                            $('#<%=txtBillAdd1.ClientID%>').val(data.d[0].CUST_BILL_ADD1);
                            <%--$('#<%=txtBillAdd2.ClientID%>').val(data.d[0].CUST_BILL_ADD2);--%>
                            $('#<%=txtBillZip.ClientID%>').val(data.d[0].ID_CUST_BILL_ZIPCODE);
                            $('#<%=txtBillCity.ClientID%>').val(data.d[0].CUST_BILL_CITY);
                            $('#<%=txtPermAdd1.ClientID%>').val(data.d[0].CUST_PERM_ADD1);
                            $('#<%=txtPermAdd2.ClientID%>').val(data.d[0].CUST_PERM_ADD2);
                            $('#<%=txtPermZip.ClientID%>').val(data.d[0].ID_CUST_PERM_ZIPCODE);
                            $('#<%=txtPermCity.ClientID%>').val(data.d[0].CUST_PERM_CITY);
                            $('#<%=txtFirstname.ClientID%>').val(data.d[0].CUST_FIRST_NAME);
                            $('#<%=txtMiddlename.ClientID%>').val(data.d[0].CUST_MIDDLE_NAME);
                            $('#<%=txtLastname.ClientID%>').val(data.d[0].CUST_LAST_NAME);
                            $('#<%=txtNotes.ClientID%>').val(data.d[0].CUST_NOTES);
                            if ($('#<%=txtNotes.ClientID%>').val() != '') {

                                $('#exclamIcon').show();
                            }
                            else {

                                $('#exclamIcon').hide();
                            }
                            $('#<%=txtCompanyPerson.ClientID%>').val(data.d[0].CUST_COMPANY_NO);
                            $('#lblCompanyPersonName').html(data.d[0].CUST_COMPANY_DESCRIPTION);
                            if (data.d[0].CUST_COMPANY_NO.length > 0) {
                                loadCompanyList(data.d[0].CUST_COMPANY_NO);
                            }
                            else {
                                loadCompanyList(data.d[0].ID_CUSTOMER);
                            }
                            $('#<%=ddlCustGroup.ClientID()%>').val(data.d[0].ID_CUST_GROUP);
                            $('#<%=ddlPayTerms.ClientID()%>').val(data.d[0].ID_CUST_PAY_TERM);
                            $('#<%=ddlPayType.ClientID()%>').val(data.d[0].ID_CUST_PAY_TYPE);
                            $('#<%=txtAdvSparesDiscount.ClientID()%>').val(data.d[0].CUST_DISC_SPARES);
                            $('#<%=txtAdvLabourDiscount.ClientID()%>').val(data.d[0].CUST_DISC_LABOUR);
                            $('#<%=txtAdvGeneralDiscount.ClientID()%>').val(data.d[0].CUST_DISC_GENERAL);
                            $('#<%=txtBirthDate.ClientID()%>').val(data.d[0].CUST_BORN);
                            $('#<%=txtEniroId.ClientID()%>').val(data.d[0].ENIRO_ID);

                            if (data.d[0].FLG_PRIVATE_COMP == 'True') {
                                $("#<%=chkPrivOrSub.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkPrivOrSub.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].ISSAMEADDRESS == 'True') {
                                $("#<%=chkSameAdd.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkSameAdd.ClientID%>").prop('checked', false);
                            }
                            // GEN > DETAILS
                            if (data.d[0].FLG_EINVOICE == 'True') {
                                $("#<%=chkEinvoice.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkEinvoice.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_INV_EMAIL == 'True') {
                                $("#<%=chkInvEmail.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkInvEmail.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_ORDCONF_EMAIL == 'True') {
                                $("#<%=chkOrdconfEmail.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkOrdconfEmail.ClientID%>").prop('checked', false);
                            }
                          
                            
                            // ADVANCED TAB
                            if (data.d[0].FLG_CUST_IGNOREINV == 'False') {
                                $("<%=chkAdvCustIgnoreInv.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustIgnoreInv.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_CUST_FACTORING == 'True') {
                                $("#<%=chkAdvCustFactoring.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustFactoring.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_CUST_BATCHINV == 'True') {
                                $("#<%=chkAdvCustBatchInv.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustBatchInv.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_NO_GM == 'True') {
                                $("#<%=chkAdvNoGm.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvNoGm.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_CUST_INACTIVE == 'True') {
                                $("#<%=chkAdvCustInactive.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustInactive.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_NO_ENV_FEE == 'True') {
                                $("#<%=chkAdvNoEnv.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvNoEnv.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_PROSPECT == 'True') {
                                $("#<%=chkProspect.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkProspect.ClientID%>").prop('checked', false);
                            }
                            clearSaveVar();
                            setSaveVar();
                            loadBranch();
                            setCustomerType();
                            setBillAdd();
                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
            }

            function updateCustomerTemplate() {
                var customer = collectGroupData('submit');
                console.log(customer);
                console.log(customer.CUST_FIRST_NAME);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/InsertCustomerTemplate",
                    data: "{'Customer': '" + JSON.stringify(customer) + "'}",
                    dataType: "json",
                    //async: false,//Very important
                    success: function (data) {
                        console.log('success' + data.d);
                        console.log(data.d[0]);
                        console.log(data.d[1]); //custid
                        $('.loading').removeClass('loading');
                        if (data.d[0] == "UPDFLG") {
                            systemMSG('success','<%=GetLocalResourceObject("CustTempUpd")%>' , 4000); //'Customer template has been updated!' 
                        }
                        else if (data.d[0] == "ERRFLG") {

                            systemMSG('error', '<%=GetLocalResourceObject("CustTempError")%>', 4000); //'An error occured while saving the customer template, check input data.'
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }

            //Contact function for drop down list
            function loadContactType() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadContactType",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpContactType.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpContactType.ClientID%>').append($("<option></option>").val(value.CONTACT_TYPE).html(value.CONTACT_DESCRIPTION));

                        });

                    },
                    failure: function () {
                       swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=ddlCustGroup.ClientID%>').change(function (e) {
                var custGrpId = $('#<%=ddlCustGroup.ClientID%>').val();
                FillPayDet(custGrpId);

            });

            function FillPayDet(IdCustGrp) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../Transactions/frmWOHead.aspx/FillPaymentDet",
                    data: "{IdCustGrp: '" + IdCustGrp + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            if (data.d[0].Pay_Type == 0) {
                                $('#<%=ddlPayType.ClientID%>')[0].selectedIndex = 0;
                           }
                           else {
                               //$('#<%=ddlPayType.ClientID%>').val(data.d[0].Pay_Type);
                               $('#<%=ddlPayType.ClientID%> option:contains("' + data.d[0].Pay_Type + '")').attr('selected', 'selected');
                               $("#<%=ddlPayType.ClientID%>").attr('disabled', 'disabled');
                           }

                           if (data.d[0].Pay_Term == 0) {
                               $('#<%=ddlPayTerms.ClientID%>')[0].selectedIndex = 0;
                           }
                           else {
                               //$('#<%=ddlPayTerms.ClientID%>').val(data.d[0].Pay_Term);
                               $('#<%=ddlPayTerms.ClientID%> option:contains("' + data.d[0].Pay_Term + '")').attr('selected', 'selected');
                               //$("#<%=ddlPayTerms.ClientID%>").attr('disabled', 'disabled');
                           }
                       }

                   },
                   error: function (result) {
                       swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": ");
                   }
               });
            }

            function FillCustGroup() {
                $.ajax({
                    type: "POST",
                    url: "../Transactions/frmWOHead.aspx/LoadCustGroup",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        Result = Result.d;
                        $('#<%=ddlCustGroup.ClientID%>').empty();
                    $('#<%=hdnSelect.ClientID%>').val('-- Velg --');
                    $('#<%=ddlCustGroup.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                    $.each(Result, function (key, value) {
                        $('#<%=ddlCustGroup.ClientID%>').append($("<option></option>").val(value.Id_Cust_Group_Seq).html(value.Cust_Group));
                    });

                },
                failure: function () {
                    swal('<%=GetLocalResourceObject("FailedError")%>');
                }
            });
            }

            function FillPayType() {
                $.ajax({
                    type: "POST",
                    url: "../Transactions/frmWOHead.aspx/LoadPayTypes",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=ddlPayType.ClientID%>').empty();
                    $('#<%=hdnSelect.ClientID%>').val('-- Velg --');
                    $('#<%=ddlPayType.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                    Result = Result.d;
                    $.each(Result, function (key, value) {
                        $('#<%=ddlPayType.ClientID%>').append($("<option></option>").val(value.Id_Settings).html(value.Description));

                    });

                },
                failure: function () {
                    swal('<%=GetLocalResourceObject("FailedError")%>');
                }
            });
            }
            function FillPayTerms() {
                $.ajax({
                    type: "POST",
                    url: "../Transactions/frmWOHead.aspx/LoadPayTerms",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=ddlPayTerms.ClientID%>').empty();
                    $('#<%=hdnSelect.ClientID%>').val('-- Velg --');
                    $('#<%=ddlPayTerms.ClientID%>').prepend("<option value='0'>" + $('#<%=hdnSelect.ClientID%>').val() + "</option>");
                    Result = Result.d;
                    $.each(Result, function (key, value) {
                        $('#<%=ddlPayTerms.ClientID%>').append($("<option></option>").val(value.Id_Settings).html(value.Description));

                    });

                },
                failure: function () {
                    swal('<%=GetLocalResourceObject("FailedError")%>');
                }
            });
            }

            $('#<%=btnSaveTemplate.ClientID%>').on('click', function () {

                if ($('#<%=txtCustTempPassword.ClientID%>').val() == "nironi") {
                    updateCustomerTemplate();
                    $('.overlayHide').removeClass('ohActive');
                    $('#modUpdateCustTemp').addClass('hidden');
                }
                else {
                    swal('<%=GetLocalResourceObject("CustTempPwdError")%>');
                    //alert('Your password was incorrect! Please try again.')
                }
            });
            $('#<%=btnCancelTemplate.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modUpdateCustTemp').addClass('hidden');
                $('#<%=txtCustTempPassword.ClientID%>').val('');
            });

            $('#btnCustNotes').on('click', function () {
                $('#modCustNotes').modal('show');

            });
            $('#btnCustNotesSave').on('click', function () {
                $('.overlayHide').removeClass('ohActive');


                if ($('#<%=txtNotes.ClientID%>').val() != "") {
                    $('#btnCustNotes').addClass('warningAN');
                    $('#exclamIcon').show();

                }
                else {

                    $('#exclamIcon').hide();
                }
            });
            $('#btnCustNotesCancel').on('click', function () {
                $('.overlayHide').removeClass('ohActive');

                $('#<%=txtNotes.ClientID%>').val('');
            });
            $('#btnCompanyReferences').on('click', function () {
                $('#modal_companyreference').modal('show');

            });

            $('#btnContactPreferences').on('click', function () {
                $('#modal_contactPreferences').modal('show');

            });

            $('#btnDates').on('click', function () {
                $('#modal_dates').modal('show');

            });

            $('#btnInvSettings').on('click', function () {
                $('#modal_gdpr').modal('show');
                if ($('#<%=txtCustomerId.ClientID%>').val() != "" && $('#<%=txtGdprResponseId.ClientID%>').val() != "") {
                    gdprResponse();
                }
                
                

            });

            $('#btnWhat').on('click', function () {
                $('#modal_what').modal('show');

            });
            $('#btnBilxtra').on('click', function () {
                $('#modal_bilxtra').modal('show');

            });

            $('#btnDiscountEtc').on('click', function () {
                $('#modal_discountetc').modal('show');

            });

            $('#btnEquipment').on('click', function () {
                $('#modal_equipment').modal('show');

            });




            //MODAL SCRIPTS FOR ADVANCED TAB PAGE
            //Salesman
            $('#btnAdvSalesman').on('click', function () {
                overlay('on', 'modAdvSalesman');
            });
            $('#<%=btnAdvSalesmanSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvSalesman').addClass('hidden');
            });
            $('#<%=btnAdvSalesmanCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvSalesman').addClass('hidden');
            });
            $('#<%=btnAdvSalesmanNew.ClientID%>').on('click', function () {
                $('#<%=txtAdvSalesmanLogin.ClientID%>').val('');
                $('#<%=txtAdvSalesmanFname.ClientID%>').val('');
                $('#<%=txtAdvSalesmanLname.ClientID%>').val('');
                $('#<%=txtAdvSalesmanDept.ClientID%>').val('');
                $('#<%=txtAdvSalesmanPassword.ClientID%>').val('')
                $('#<%=txtAdvSalesmanPhone.ClientID%>').val('')
                $('#<%=lblAdvSalesmanStatus.ClientID%>').html('<%=GetLocalResourceObject("SalesManNew")%>'); //'Oppretter ny selger.'
            });

            //Branch
            $('#btnAdvBranch').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modAdvBranch').removeClass('hidden');
            });
            $('#<%=btnAdvBranchSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvBranch').addClass('hidden');
            });
            $('#<%=btnAdvBranchCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvBranch').addClass('hidden');
            });
            $('#<%=btnAdvBranchNew.ClientID%>').on('click', function () {
                $('#<%=txtAdvBranchCode.ClientID%>').val('');
                $('#<%=txtAdvBranchText.ClientID%>').val('');
                $('#<%=txtAdvBranchNote.ClientID%>').val('');
                $('#<%=txtAdvBranchRef.ClientID%>').val('');
                $('#<%=txtAdvBranchCode.ClientID%>').focus();
            });

            //Category
            $('#btnAdvCategory').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modAdvCategory').removeClass('hidden');
            });
            $('#<%=btnAdvCategorySave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvCategory').addClass('hidden');
            });
            $('#<%=btnAdvCategoryCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvCategory').addClass('hidden');
            });
            $('#<%=btnAdvCategoryNew.ClientID%>').on('click', function () {
                $('#<%=txtAdvCategoryCode.ClientID%>').val('');
                $('#<%=txtAdvCategoryText.ClientID%>').val('');
                $('#<%=txtAdvCategoryNote.ClientID%>').val('');
                $('#<%=txtAdvCategoryRef.ClientID%>').val('');
                $('#<%=txtAdvCategoryCode.ClientID%>').focus();

            });
            //Sales group
            $('#btnAdvSalesgroup').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modAdvSalesGroup').removeClass('hidden');
            });
            $('#<%=btnAdvSalesGroupSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvSalesGroup').addClass('hidden');
            });
            $('#<%=btnAdvSalesGroupCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvSalesGroup').addClass('hidden');
            });
            $('#<%=btnAdvSalesGroupNew.ClientID%>').on('click', function () {
                $('#<%=txtAdvSalesGroupCode.ClientID%>').val('');
                $('#<%=txtAdvSalesGroupText.ClientID%>').val('');
                $('#<%=txtAdvSalesGroupInv.ClientID%>').val('');
                $('#<%=txtAdvSalesGroupVat.ClientID%>').val('');
                $('#<%=txtAdvSalesGroupCode.ClientID%>').focus();

            });
            //Payment terms
            $('#btnAdvPayterms').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modAdvPaymentTerms').removeClass('hidden');
            });
            $('#<%=btnAdvPayTermsSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvPaymentTerms').addClass('hidden');
            });
            $('#<%=btnAdvPayTermsCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvPaymentTerms').addClass('hidden');
            });
            $('#<%=btnAdvPayTermsNew.ClientID%>').on('click', function () {
                $('#<%=txtAdvPayTermsCode.ClientID%>').val('');
                $('#<%=txtAdvPayTermsText.ClientID%>').val('');
                $('#<%=txtAdvPayTermsDays.ClientID%>').val('');
                $('#<%=txtAdvPayTermsCode.ClientID%>').focus();
            });
            //Credit card type
            $('#btnAdvCardtype').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modAdvCreditCardType').removeClass('hidden');
            });
            $('#<%=btnAdvCredCardTypeSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvCreditCardType').addClass('hidden');
            });
            $('#<%=btnAdvCredCardTypeCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvCreditCardType').addClass('hidden');
            });
            $('#<%=btnAdvCredCardTypeNew.ClientID%>').on('click', function () {
                $('#<%=txtAdvCredCardTypeCode.ClientID%>').val('');
                $('#<%=txtAdvCredCardTypeText.ClientID%>').val('');
                $('#<%=txtAdvCredCardTypeCustNo.ClientID%>').val('');
                $('#<%=txtAdvCredCardTypeCode.ClientID%>').focus();
            });

            //Currency Code
            $('#btnAdvCurrcode').on('click', function () {
                $('.overlayHide').addClass('ohActive');
                $('#modAdvCurrencyCode').removeClass('hidden');
                //alert($('#<%=txtAdvCurrcode.ClientID%>').value);
            });
            $('#<%=btnAdvCurCodeSave.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvCurrencyCode').addClass('hidden');
            });
            $('#<%=btnAdvCurCodeCancel.ClientID%>').on('click', function () {
                $('.overlayHide').removeClass('ohActive');
                $('#modAdvCurrencyCode').addClass('hidden');
            });
            $('#<%=btnAdvCurCodeNew.ClientID%>').on('click', function () {
                $('#<%=txtAdvCurCodeCode.ClientID%>').val('');
                $('#<%=txtAdvCurCodeText.ClientID%>').val('');
                $('#<%=txtAdvCurCodeValue.ClientID%>').val('');
                $('#<%=txtAdvCurCodeCode.ClientID%>').focus();
            });

            function loadSalesman() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadSalesman",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpSalesman.ClientID%>').empty();
                        Result = Result.d;
                        $.each(Result, function (key, value) {
                            $('#<%=drpSalesman.ClientID%>').append($("<option></option>").val(value.USER_LOGIN).html(value.USER_FIRST_NAME + " " + value.USER_LAST_NAME));
                        });
                    },
                    failure: function () {
                       swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=drpSalesman.ClientID%>').change(function () {
                var loginId = this.value;
                getSalesman(loginId);
            });

            function getSalesman(loginId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetSalesman",
                    data: "{loginId: '" + loginId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                        $('#<%=txtAdvSalesmanLogin.ClientID%>').val(Result.d[0].USER_LOGIN);
                        $('#<%=txtAdvSalesmanFname.ClientID%>').val(Result.d[0].USER_FIRST_NAME);
                        $('#<%=txtAdvSalesmanLname.ClientID%>').val(Result.d[0].USER_LAST_NAME);
                        $('#<%=txtAdvSalesmanDept.ClientID%>').val(Result.d[0].USER_DEPARTMENT);
                        $('#<%=txtAdvSalesmanPassword.ClientID%>').val(Result.d[0].USER_PASSWORD);
                        $('#<%=txtAdvSalesmanPhone.ClientID%>').val(Result.d[0].USER_PHONE);

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            function customerSalesman(loginId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetSalesman",
                    data: "{loginId: '" + loginId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                        
                        $('#<%=txtAdvSalesman.ClientID%>').val(Result.d[0].USER_FIRST_NAME + " " + Result.d[0].USER_LAST_NAME);
                       

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }
            /*------------END OF SALESMAN CODE-------------------------------------------------------------------------------------------*/

            function loadBranch() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadBranch",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpBranch.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpBranch.ClientID%>').append($("<option></option>").val(value.BRANCH_CODE).html(value.BRANCH_TEXT));
                        });
                    },
                    failure: function () {
                       swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=drpBranch.ClientID%>').change(function () {
                var branchId = this.value;
                getBranch(branchId);
            });

            function getBranch(branchId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetBranch",
                    data: "{branchId: '" + branchId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                        $('#<%=txtAdvBranchCode.ClientID%>').val(Result.d[0].BRANCH_CODE);
                        $('#<%=txtAdvBranchText.ClientID%>').val(Result.d[0].BRANCH_TEXT);
                        $('#<%=txtAdvBranchNote.ClientID%>').val(Result.d[0].BRANCH_NOTE);
                        $('#<%=txtAdvBranchRef.ClientID%>').val(Result.d[0].BRANCH_ANNOT);

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }
            /*Loading the branch based on the code saved on the customer*/
            function customerBranch(branchId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetBranch",
                    data: "{branchId: '" + branchId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                        $('#txtAdvBranchTxt').html(Result.d[0].BRANCH_CODE);
                        $('#<%=txtAdvBranch.ClientID%>').val(Result.d[0].BRANCH_TEXT);
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=btnAdvBranchSave.ClientID%>').on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddBranch",
                    data: "{branchCode: '" + $('#<%=txtAdvBranchCode.ClientID%>').val() + "', branchText:'" + $('#<%=txtAdvBranchText.ClientID%>').val() + "', branchNote:'" + $('#<%=txtAdvBranchNote.ClientID%>').val() + "', branchAnnot:'" + $('#<%=txtAdvBranchRef.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "INSFLG") {
                            var res = '<%=GetLocalResourceObject("CustOccCodeIns")%>'; //'Yrkeskode er lagt til.';
                            swal(res);
                        }
                        else if (data.d == "UPDFLG") {
                            var res = '<%=GetLocalResourceObject("CustOccCodeUpd")%>'; //'Yrkeskode er oppdatert.';
                            swal(res);
                        }
                    },
                    error: function (result) {
                        swal(errSmtngWrong);
                    }
                });
                loadBranch();
            });

            $('#<%=btnAdvBranchDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtAdvBranchCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeleteBranch",
                        data: "{branchId: '" + $('#<%=txtAdvBranchCode.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //console.log(Result);
                            $('#<%=lblAdvBranchStatus.ClientID%>').html($('#<%=txtAdvBranchCode.ClientID%>').val() +" "+ '<%=GetLocalResourceObject("GenDelErrMessage")%>'); //" er slettet."
                        $('#<%=txtAdvBranchCode.ClientID%>').val('');
                        $('#<%=txtAdvBranchText.ClientID%>').val('');
                        $('#<%=txtAdvBranchNote.ClientID%>').val('');
                        $('#<%=txtAdvBranchRef.ClientID%>').val('');
                            loadBranch();

                        },
                        failure: function () {
                           swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                else {
                    //$('#<%=lblAdvBranchStatus.ClientID%>').html('Vennligst først velg yrkeskoden i listen til venstre før du klikker slett.'); 
                    $('#<%=lblAdvBranchStatus.ClientID%>').html('<%=GetLocalResourceObject("CustOccCodeDelErr")%>');
                }


            });

            /*------------END OF BRANCH CODE-------------------------------------------------------------------------------------------*/

            function loadCategory() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadCategory",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpAdvCategory.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpAdvCategory.ClientID%>').append($("<option></option>").val(value.CATEGORY_CODE).html(value.CATEGORY_TEXT));
                        });
                    },
                    failure: function () {
                       swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=drpAdvCategory.ClientID%>').change(function () {
                var categoryId = this.value;
                getCategory(categoryId);
            });

            function getCategory(categoryId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetCategory",
                    data: "{categoryId: '" + categoryId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                        $('#<%=txtAdvCategoryCode.ClientID%>').val(Result.d[0].CATEGORY_CODE);
                        $('#<%=txtAdvCategoryText.ClientID%>').val(Result.d[0].CATEGORY_TEXT);
                        $('#<%=txtAdvCategoryRef.ClientID%>').val(Result.d[0].CATEGORY_ANNOT);

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=btnAdvCategorySave.ClientID%>').on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddCategory",
                    data: "{categoryCode: '" + $('#<%=txtAdvCategoryCode.ClientID%>').val() + "', categoryText:'" + $('#<%=txtAdvCategoryText.ClientID%>').val() + "', categoryAnnot:'" + $('#<%=txtAdvCategoryRef.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "INSFLG") {
                            var res = '<%=GetLocalResourceObject("CategoryIns")%>'; //'Kategori er lagt til.';
                            swal(res);
                        }
                        else if (data.d == "UPDFLG") {
                            var res = '<%=GetLocalResourceObject("CategoryUpd")%>'; //'Kategori er oppdatert.';
                            swal(res);
                        }
                    },
                    error: function (result) {
                        swal(errSmtngWrong);
                    }
                });
                loadCategory();
            });

            $('#<%=btnAdvCategoryDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtAdvCategoryCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeleteCategory",
                        data: "{categoryId: '" + $('#<%=txtAdvCategoryCode.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //console.log(Result);
                            $('#<%=lblAdvCategoryStatus.ClientID%>').html($('#<%=txtAdvCategoryCode.ClientID%>').val() +" "+ '<%=GetLocalResourceObject("GenDelErrMessage")%>'); // " er slettet."
                        $('#<%=txtAdvCategoryCode.ClientID%>').val('');
                        $('#<%=txtAdvCategoryText.ClientID%>').val('');
                        $('#<%=txtAdvCategoryNote.ClientID%>').val('');
                        $('#<%=txtAdvCategoryRef.ClientID%>').val('');
                            loadCategory();

                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                else {
                   // $('#<%=lblAdvCategoryStatus.ClientID%>').html('Vennligst først velg kategori i listen til venstre før du klikker slett.');
                     $('#<%=lblAdvCategoryStatus.ClientID%>').html('<%=GetLocalResourceObject("CategoryDelErr")%>');
                }


            });

            /*------------END OF CATEGORY CODE-------------------------------------------------------------------------------------------*/

            function loadSalesGroup() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadSalesGroup",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpAdvSalesGroup.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpAdvSalesGroup.ClientID%>').append($("<option></option>").val(value.SALESGROUP_CODE).html(value.SALESGROUP_CODE + ' - ' + value.SALESGROUP_TEXT));
                        });
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=drpAdvSalesGroup.ClientID%>').change(function () {
                var salesgroupId = this.value;
                getSalesGroup(salesgroupId);
            });

            function getSalesGroup(salesgroupId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetSalesGroup",
                    data: "{salesgroupId: '" + salesgroupId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                        $('#<%=txtAdvSalesGroupCode.ClientID%>').val(Result.d[0].SALESGROUP_CODE);
                        $('#<%=txtAdvSalesGroupText.ClientID%>').val(Result.d[0].SALESGROUP_TEXT);
                        $('#<%=txtAdvSalesGroupInv.ClientID%>').val(Result.d[0].SALESGROUP_INVESTMENT);
                        $('#<%=txtAdvSalesGroupVat.ClientID%>').val(Result.d[0].SALESGROUP_VAT);

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }
            function customerSalesGroup(salesgroupId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetSalesGroup",
                    data: "{salesgroupId: '" + salesgroupId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                    
                        $('#<%=txtAdvSalesgroup.ClientID%>').val(Result.d[0].SALESGROUP_TEXT);
                       

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=btnAdvSalesGroupSave.ClientID%>').on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddSalesGroup",
                    data: "{salesgroupCode: '" + $('#<%=txtAdvSalesGroupCode.ClientID%>').val() + "', salesgroupText:'" + $('#<%=txtAdvSalesGroupText.ClientID%>').val() + "', salesgroupInv:'" + $('#<%=txtAdvSalesGroupInv.ClientID%>').val() + "', salesgroupVat:'" + $('#<%=txtAdvSalesGroupVat.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "INSFLG") {
                            var res = '<%=GetLocalResourceObject("SalesGrpIns")%>'; //'Salgsgruppe er lagt til.';
                            swal(res);
                        }
                        else if (data.d == "UPDFLG") {
                            var res = '<%=GetLocalResourceObject("SalesGrpUpd")%>'; //'Salgsgruppe er oppdatert.';
                            swal(res);
                        }
                    },
                    error: function (result) {
                        swal(errSmtngWrong);
                    }
                });
                loadSalesGroup();
            });

            $('#<%=btnAdvSalesGroupDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtAdvSalesGroupCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeleteSalesGroup",
                        data: "{salesgroupId: '" + $('#<%=txtAdvSalesGroupCode.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //console.log(Result);
                            $('#<%=lblAdvSalesGroupStatus.ClientID%>').html($('#<%=txtAdvSalesGroupCode.ClientID%>').val() +" "+ '<%=GetLocalResourceObject("GenDelErrMessage")%>'); //" er slettet."
                        $('#<%=txtAdvSalesGroupCode.ClientID%>').val('');
                        $('#<%=txtAdvSalesGroupText.ClientID%>').val('');
                        $('#<%=txtAdvSalesGroupInv.ClientID%>').val('');
                        $('#<%=txtAdvSalesGroupVat.ClientID%>').val('');
                            loadSalesGroup();

                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                else {
                    //$('#<%=lblAdvSalesGroupStatus.ClientID%>').html('Vennligst først velg salgsgruppen i listen til venstre før du klikker slett.');
                    $('#<%=lblAdvSalesGroupStatus.ClientID%>').html('<%=GetLocalResourceObject("SalesGrpErr")%>');
                }


            });

            /*------------END OF SALES GROUP CODE-------------------------------------------------------------------------------------------*/

            function loadPaymentTerms() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadPaymentTerms",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpAdvPaymentTerms.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpAdvPaymentTerms.ClientID%>').append($("<option></option>").val(value.PAYMENT_TERMS_CODE).html(value.PAYMENT_TERMS_CODE + ' - ' + value.PAYMENT_TERMS_TEXT + ' - ' + value.PAYMENT_TERMS_DAYS + ' day(s)'));
                        });
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=drpAdvPaymentTerms.ClientID%>').change(function () {
                var paymentTermsId = this.value;
                getPaymentTerms(paymentTermsId);
            });

            function getPaymentTerms(paymentTermsId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetPaymentTerms",
                    data: "{paymentTermsId: '" + paymentTermsId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        //console.log(Result);
                        $('#<%=txtAdvPayTermsCode.ClientID%>').val(Result.d[0].PAYMENT_TERMS_CODE);
                        $('#<%=txtAdvPayTermsText.ClientID%>').val(Result.d[0].PAYMENT_TERMS_TEXT);
                        $('#<%=txtAdvPayTermsDays.ClientID%>').val(Result.d[0].PAYMENT_TERMS_DAYS);

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=btnAdvPayTermsSave.ClientID%>').on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddPaymentTerms",
                    data: "{paytermsCode: '" + $('#<%=txtAdvPayTermsCode.ClientID%>').val() + "', paytermsText:'" + $('#<%=txtAdvPayTermsText.ClientID%>').val() + "', paytermsDays:'" + $('#<%=txtAdvPayTermsDays.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "INSFLG") {
                            var res = '<%=GetLocalResourceObject("TermsCondIns")%>'; //'Bet.betingelser er lagt til.';
                            swal(res);
                        }
                        else if (data.d == "UPDFLG") {
                            var res = '<%=GetLocalResourceObject("TermsCondUpd")%>'; //'Bet.betingelser er oppdatert.';
                            swal(res);
                        }
                    },
                    error: function (result) {
                        swal(errSmtngWrong);
                    }
                });
                loadPaymentTerms();
            });

            $("#countryChooser").change(function () {
                var flag = $('#countryChooserDrop').dropdown('get value');
                console.log("hey " + flag + "hello");
                flag = flag.trim()

                $('#<%=countrysavebox.ClientID%>').val($('#countryChooserDrop').dropdown('get text'));
                 //alert($('#<%=countrysavebox.ClientID%>').val())
                 $('#<%=flagsavebox.ClientID%>').val(flag);
                 console.log($('#<%=flagsavebox.ClientID%>').val());
                 $('#chkAnotherCountry').removeClass().addClass(flag + " flag");
                 $("#countryChooser").hide();
             });

            $('#btnCustLog').on('click', function (e) {
                // alert(  )
            });

            $('#chkAnotherCountrys').on('click', function (e) {

                if (!$('#countryChooser').is(':visible')) {
                    $("#countryChooser").show();

                }
                else {
                    $("#countryChooser").hide();

                }

            });


            $('#<%=btnAdvPayTermsDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtAdvPayTermsCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeletePaymentTerms",
                        data: "{paymenttermsId: '" + $('#<%=txtAdvPayTermsCode.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //console.log(Result);
                            $('#<%=lblAdvPayTermsStatus.ClientID%>').html($('#<%=txtAdvPayTermsCode.ClientID%>').val() + " " + '<%=GetLocalResourceObject("GenDelErrMessage")%>');  //" er slettet."
                        $('#<%=txtAdvPayTermsCode.ClientID%>').val('');
                        $('#<%=txtAdvPayTermsText.ClientID%>').val('');
                        $('#<%=txtAdvPayTermsDays.ClientID%>').val('');

                            loadPaymentTerms();

                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                else {
                   // $('#<%=lblAdvPayTermsStatus.ClientID%>').html('Vennligst først velg salgsgruppen i listen til venstre før du klikker slett.');
                     $('#<%=lblAdvPayTermsStatus.ClientID%>').html('<%=GetLocalResourceObject("TermsCondErr")%>');
                }


            });

            /*------------END OF PAYMENT TERMS CODE-------------------------------------------------------------------------------------------*/

            function loadCardType() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadCardType",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpAdvCardType.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpAdvCardType.ClientID%>').append($("<option></option>").val(value.CARD_TYPE_CODE).html(value.CARD_TYPE_CODE + ' - ' + value.CARD_TYPE_TEXT));
                        });
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=drpAdvCardType.ClientID%>').change(function () {
                var cardTypeId = this.value;
                getCardType(cardTypeId);
            });

            function getCardType(cardTypeId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetCardType",
                    data: "{cardTypeId: '" + cardTypeId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        console.log(Result);
                        $('#<%=txtAdvCredCardTypeCode.ClientID%>').val(Result.d[0].CARD_TYPE_CODE);
                        $('#<%=txtAdvCredCardTypeText.ClientID%>').val(Result.d[0].CARD_TYPE_TEXT);
                        $('#<%=txtAdvCredCardTypeCustNo.ClientID%>').val(Result.d[0].CARD_TYPE_CUSTNO);

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            function customerCardType(cardTypeId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetCardType",
                    data: "{cardTypeId: '" + cardTypeId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        console.log(Result);
                        $('#<%=txtAdvCardtype.ClientID%>').val(Result.d[0].CARD_TYPE_TEXT);
                       

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=btnAdvCredCardTypeSave.ClientID%>').on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddCardType",
                    data: "{cardtypeCode: '" + $('#<%=txtAdvCredCardTypeCode.ClientID%>').val() + "', cardtypeText:'" + $('#<%=txtAdvCredCardTypeText.ClientID%>').val() + "', cardtypeCustno:'" + $('#<%=txtAdvCredCardTypeCustNo.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "INSFLG") {
                            var res = '<%=GetLocalResourceObject("CreditCardIns")%>';// 'Kredittkortopplysninger er lagt til.';
                            swal(res);
                        }
                        else if (data.d == "UPDFLG") {
                            var res = '<%=GetLocalResourceObject("CreditCardUpd")%>';// 'Kredittkortopplysninger er oppdatert.';
                            swal(res);
                        }
                    },
                    error: function (result) {
                        swal(errSmtngWrong);
                    }
                });
                loadCardType();
            });

            $('#<%=btnAdvCredCardTypeDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtAdvCredCardTypeCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeleteCardType",
                        data: "{cardtypeId: '" + $('#<%=txtAdvCredCardTypeCode.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //console.log(Result);
                            $('#<%=lblAdvCreditCardStatus.ClientID%>').html($('#<%=txtAdvCredCardTypeCode.ClientID%>').val() + " " + '<%=GetLocalResourceObject("GenDelErrMessage")%>');  //" er slettet."
                        $('#<%=txtAdvCredCardTypeCode.ClientID%>').val('');
                        $('#<%=txtAdvCredCardTypeText.ClientID%>').val('');
                        $('#<%=txtAdvCredCardTypeCustNo.ClientID%>').val('');

                            loadCardType();

                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                else {
                   // $('#<%=lblAdvCreditCardStatus.ClientID%>').html('Vennligst først velg kredittkorttype i listen til venstre før du klikker slett.');
                     $('#<%=lblAdvCreditCardStatus.ClientID%>').html('<%=GetLocalResourceObject("CreditCardErr")%>');
                }


            });

            /*------------END OF CARD TYPE CODE-------------------------------------------------------------------------------------------*/

            function loadCurrencyType() {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadCurrencyType",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=drpAdvCurrencyType.ClientID%>').empty();

                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=drpAdvCurrencyType.ClientID%>').append($("<option></option>").val(value.CURRENCY_TYPE_CODE).html(value.CURRENCY_TYPE_CODE + ' - ' + value.CURRENCY_TYPE_TEXT));
                        });
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $('#<%=drpAdvCurrencyType.ClientID%>').change(function () {
                var currencyId = this.value;
                getCurrencyType(currencyId);
            });

            function getCurrencyType(currencyId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetCurrencyType",
                    data: "{currencyId: '" + currencyId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        console.log(Result);
                        $('#<%=txtAdvCurCodeCode.ClientID%>').val(Result.d[0].CURRENCY_TYPE_CODE);
                        $('#<%=txtAdvCurCodeText.ClientID%>').val(Result.d[0].CURRENCY_TYPE_TEXT);
                        $('#<%=txtAdvCurCodeValue.ClientID%>').val(Result.d[0].CURRENCY_TYPE_RATE);

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            function customerCurrencyType(currencyId) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/GetCurrencyType",
                    data: "{currencyId: '" + currencyId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        console.log(Result);
                        $('#<%=txtAdvCurrcode.ClientID%>').val(Result.d[0].CURRENCY_TYPE_TEXT);


                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
             }

            $('#<%=btnAdvCurCodeSave.ClientID%>').on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddCurrencyType",
                    data: "{currencyCode: '" + $('#<%=txtAdvCurCodeCode.ClientID%>').val() + "', currencyText:'" + $('#<%=txtAdvCurCodeText.ClientID%>').val() + "', currencyRate:'" + $('#<%=txtAdvCurCodeValue.ClientID%>').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        genIns = '<%=GetLocalResourceObject("lblCode")%>';  
                        genUpd = '<%=GetLocalResourceObject("lblCode")%>'; 
                      
                        if (data.d == "INSFLG") {                            
                            var res = `<%=GetLocalResourceObject("GenNewIns")%>`; //'Valutakode er lagt til.';
                            swal(res);
                        }
                        else if (data.d == "UPDFLG") {
                            var res = `<%=GetLocalResourceObject("GenNewUpd")%>`; // 'Valutakode er oppdatert.';
                            swal(res);
                        }
                    },
                    error: function (result) {
                        swal(errSmtngWrong);
                    }
                });
                loadCurrencyType();
            });

            $('#<%=btnAdvCurCodeDelete.ClientID%>').on('click', function () {
                if ($('#<%=txtAdvCurCodeCode.ClientID%>').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeleteCurrency",
                        data: "{currencyId: '" + $('#<%=txtAdvCurCodeCode.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //console.log(Result);
                            $('#<%=lblAdvCurrencyStatus.ClientID%>').html($('#<%=txtAdvCurCodeCode.ClientID%>').val() + " " + '<%=GetLocalResourceObject("GenDelErrMessage")%>'); //" er slettet."
                        $('#<%=txtAdvCurCodeCode.ClientID%>').val('');
                        $('#<%=txtAdvCurCodeText.ClientID%>').val('');
                        $('#<%=txtAdvCurCodeValue.ClientID%>').val('');

                            loadCurrencyType();

                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                else {
                   // $('#<%=lblAdvCurrencyStatus.ClientID%>').html('Vennligst først velg valuta i listen til venstre før du klikker slett.');
                     $('#<%=lblAdvCurrencyStatus.ClientID%>').html('<%=GetLocalResourceObject("CurrCodeDelErr")%>');
                }


            });

            /*------------END OF CURRENCY CODE-------------------------------------------------------------------------------------------*/


            // BRREG API
            function LoadBrreg(ssn) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/getBrregDatagetBrregData",
                    data: "{Search: '" + ssn + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {

                        if (data.d.length != 0) {
                            if (data.d[0].konkurs == 'J') {
                                var konkURL = 'https://w2.brreg.no/kunngjoring/hent_nr.jsp?orgnr=' + data.d[0].organisasjonsnummer;
                                $('#konkurs')
                                    .modal('show')
                                    ;
                                $('#konkFirma').html(data.d[0].navn);
                                $('#konkLink').prop('href', konkURL);
                            }
                            $('#<%=txtAdvEmployees.ClientID%>').val(data.d[0].antallAnsatte);
                        }
                        else {
                            console.log('No company was found. Please search with something else as your data.')
                        }
                    },
                    failure: function () {
                        console.log("Failed!");
                    }
                });
            }

            //ENIRO FUNCTIONS
            $('#<%=CustSelect.ClientID%>').change(function () {
                var eniroId = this.value;
                LoadEniroDet(eniroId);
                $('#modNewCust').modal('hide');
            });

            //New customer popup


            $('#btnSearchCustomer').on('click', function () {
                $('#modNewCust').modal('show');
                if ($('#txtCustId').val() != "") {
                    FetchEniro($('#txtCustId').val());
                }
                else {
                    var name = "";
                    if ($('#<%=txtFirstname.ClientID()%>').val() != '') {
                        name = $('#<%=txtFirstname.ClientID()%>').val();
                    }
                    if ($('#<%=txtMiddlename.ClientID()%>').val() != '') {
                        name += " " + $('#<%=txtMiddlename.ClientID()%>').val();
                    }
                    if ($('#<%=txtLastname.ClientID()%>').val() != "") {
                        name += " " + $('#<%=txtLastname.ClientID()%>').val();
                    }
                    name += " " + $('#<%=txtPermAdd1.ClientID()%>').val();
                    if ($('#<%=txtEniroId.ClientID()%>').val() == "") {
                        FetchEniro(name);
                    }
                    else {
                        FetchEniro($('#<%=txtEniroId.ClientID()%>').val());
                    }
                   
                }
            });
            $('#btnWashCustomer').on('click', function () {
                $('#<%=txtWashLocalLastName.ClientID()%>').val($('#<%=txtLastname.ClientID()%>').val());
                $('#<%=txtWashLocalFirstName.ClientID()%>').val($('#<%=txtFirstname.ClientID()%>').val());
                $('#<%=txtWashLocalMiddleName.ClientID()%>').val($('#<%=txtMiddlename.ClientID()%>').val());
                $('#<%=txtWashLocalVisitAddress.ClientID()%>').val($('#<%=txtPermAdd1.ClientID()%>').val());
                $('#<%=txtWashLocalZipCode.ClientID()%>').val($('#<%=txtPermZip.ClientID()%>').val());
                $('#<%=txtWashLocalZipPlace.ClientID()%>').val($('#<%=txtPermCity.ClientID()%>').val());
                $('#<%=txtWashLocalMobile.ClientID()%>').val($('[data-contact-type=1]').val());
                $('#<%=txtWashLocalPhone.ClientID()%>').val($('[data-contact-type=2]').val());
                $('#<%=txtWashLocalBorn.ClientID()%>').val($('#<%=txtBirthDate.ClientID()%>').val());
                $('#<%=txtWashLocalSsnNo.ClientID()%>').val($('#<%=txtAdvSsnNo.ClientID()%>').val());
                WashEniroData();
                if ($('#<%=txtWashLocalLastName.ClientID()%>').val() != $('#<%=txtWashEniroLastName.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroLastName.ClientID()%>').val() != "") {
                        $('#<%=chkWashLastName.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashLastName.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalFirstName.ClientID()%>').val() != $('#<%=txtWashEniroFirstName.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroFirstName.ClientID()%>').val() != "") {
                        $('#<%=chkWashFirstName.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashFirstName.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalMiddleName.ClientID()%>').val() != $('#<%=txtWashEniroMiddleName.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroMiddleName.ClientID()%>').val() != "") {
                        $('#<%=chkWashMiddleName.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashMiddleName.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalVisitAddress.ClientID()%>').val() != $('#<%=txtWashEniroVisitAddress.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroVisitAddress.ClientID()%>').val() != "") {
                        $('#<%=chkWashVisitAddress.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashVisitAddress.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalBillAddress.ClientID()%>').val() != $('#<%=txtWashEniroBillAddress.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroBillAddress.ClientID()%>').val() != "") {
                        $('#<%=chkWashBillAddress.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashBillAddress.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalZipCode.ClientID()%>').val() != $('#<%=txtWashEniroZipCode.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroZipCode.ClientID()%>').val() != "") {
                        $('#<%=chkWashZipCode.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashZipCode.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalZipPlace.ClientID()%>').val() != $('#<%=txtWashEniroZipPlace.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroZipPlace.ClientID()%>').val() != "") {
                        $('#<%=chkWashZipPlace.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashZipPlace.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalPhone.ClientID()%>').val() != $('#<%=txtWashEniroPhone.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroPhone.ClientID()%>').val() != "") {
                        $('#<%=chkWashPhone.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashPhone.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalMobile.ClientID()%>').val() != $('#<%=txtWashEniroMobile.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroMobile.ClientID()%>').val() != "") {
                        $('#<%=chkWashMobile.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashMobile.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalBorn.ClientID()%>').val() != $('#<%=txtWashEniroBorn.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroBorn.ClientID()%>').val() != "") {
                        $('#<%=chkWashBorn.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashBorn.ClientID()%>').prop('checked', false);
                }
                if ($('#<%=txtWashLocalSsnNo.ClientID()%>').val() != $('#<%=txtWashEniroSsnNo.ClientID()%>').val()) {
                    if ($('#<%=txtWashEniroSsnNo.ClientID()%>').val() != "") {
                        $('#<%=chkWashSsnNo.ClientID()%>').prop('checked', true);
                    }
                }
                else {
                    $('#<%=chkWashSsnNo.ClientID()%>').prop('checked', false);
                }
                $('#modWashCustomer').modal({
                    onDeny: function () {

                    },
                    onApprove: function () {
                        if ($('#<%=chkWashLastName.ClientID%>').is(':checked')) {
                            $('#<%=txtLastname.ClientID%>').val($('#<%=txtWashEniroLastName.ClientID%>').val());
                        }
                        if ($('#<%=chkWashFirstName.ClientID%>').is(':checked')) {
                            $('#<%=txtFirstname.ClientID%>').val($('#<%=txtWashEniroFirstName.ClientID%>').val());
                        }
                        if ($('#<%=chkWashMiddleName.ClientID%>').is(':checked')) {
                            $('#<%=txtMiddlename.ClientID%>').val($('#<%=txtWashEniroMiddleName.ClientID%>').val());
                        }
                        if ($('#<%=chkWashVisitAddress.ClientID%>').is(':checked')) {
                            $('#<%=txtPermAdd1.ClientID%>').val($('#<%=txtWashEniroVisitAddress.ClientID%>').val());
                        }
                        if ($('#<%=chkWashBillAddress.ClientID%>').is(':checked')) {
                            $('#<%=txtBillAdd1.ClientID%>').val($('#<%=txtWashEniroBillAddress.ClientID%>').val());
                        }
                        if ($('#<%=chkWashZipCode.ClientID%>').is(':checked')) {
                            $('#<%=txtPermZip.ClientID%>').val($('#<%=txtWashEniroZipCode.ClientID%>').val());
                        }
                        if ($('#<%=chkWashZipPlace.ClientID%>').is(':checked')) {
                            $('#<%=txtPermCity.ClientID%>').val($('#<%=txtWashEniroZipPlace.ClientID%>').val());
                        }
                        if ($('#<%=chkWashPhone.ClientID%>').is(':checked')) {
                            $('[data-contact-type=2]').val($('#<%=txtWashEniroLastName.ClientID%>').val());
                        }
                        if ($('#<%=chkWashMobile.ClientID%>').is(':checked')) {
                            $('[data-contact-type=1]').val($('#<%=txtWashEniroMobile.ClientID%>').val());
                        }
                        if ($('#<%=chkWashBorn.ClientID%>').is(':checked')) {
                            $('#<%=txtBirthDate.ClientID%>').val($('#<%=txtWashEniroBorn.ClientID%>').val());
                        }
                        if ($('#<%=chkWashSsnNo.ClientID%>').is(':checked')) {
                            $('#<%=txtAdvSsnNo.ClientID%>').val($('#<%=txtWashEniroSsnNo.ClientID%>').val());
                        }
                        $('#<%=txtWashDate.ClientID%>').val($.datepicker.formatDate("dd.mm.yy", new Date()));


                    }
                }).modal('show');
            });

            $('#btnEniroFetch ').on('click', function () {
                FetchEniro($('#<%=txtEniro.ClientID()%>').val());
            });

            function FetchEniro(eniroId) {
                $('#txtCustId').val(eniroId);
                $('#<%=txtEniro.ClientID%>').val(eniroId);

                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/FetchEniro",
                    data: "{search: '" + eniroId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length > 0) {
                            $('#<%=CustSelect.ClientID%>').empty();
                            var res = data.d;
                            $.each(res, function (key, value) {
                                if ((value.CUST_FIRST_NAME != "" && value.CUST_FIRST_NAME != undefined && value.CUST_FIRST_NAME != null) || (value.CUST_LAST_NAME != "" && value.CUST_LAST_NAME != undefined && value.CUST_LAST_NAME != null) || (value.CUST_MIDDLE_NAME != "" && value.CUST_MIDDLE_NAME != undefined && value.CUST_MIDDLE_NAME != null)) {
                                    var name = value.CUST_FIRST_NAME + " " + value.CUST_MIDDLE_NAME + " " + value.CUST_LAST_NAME + " - " + value.CUST_PERM_ADD1 + " - " + value.ID_CUST_PERM_ZIPCODE + " " + value.CUST_PERM_ADD2 + " - " + value.CUST_PHONE_MOBILE;
                                    $('#<%=CustSelect.ClientID%>').append($("<option></option>").val(value.ENIRO_ID).html(name));
                                }

                            });
                        }
                        else {
                            //alert('No customer was found. Please search with something else as your data.')
                            swal('<%=GetLocalResourceObject("CustNotFound")%>');
                        }
                    },
                    failure: function () {
                       swal('<%=GetLocalResourceObject("FailedError")%>');
                    },
                    select: function (e, i) {
                        swal('hi');

                    },
                });
            }

            function fetchSMSConfig2() {


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

                            //return arrayOfValues;
                            //var messageType = "Manuell SMS";
                            //saveSMSGlobal(, Result.d[0]., phoneTo, messageType, messageText, time, Result.d[0].USER_ID, Result.d[0].USER_PASSWORD, Result.d[0].SMS_OPERATOR_LINK);
                            //sendXtraCheckWeb();
                        }
                        
                    }
                });
            }

            function sendSMS() {
             

                let deptId = arrayOfValues[0]
                let senderSMS = arrayOfValues[1]
                let userId = arrayOfValues[2]
                let userPassword = arrayOfValues[3]
                let smsOperatorLink = arrayOfValues[4]

                var num = $('#<%=txtNumberSms.ClientID%>').val();
                var message = $('#<%=txtSendSms.ClientID%>').val();
              

                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/SendSMS",
                    data: "{'deptId': '" + deptId + "', 'senderSMS':'" + senderSMS + "', 'userId':'" + userId
                        + "', 'userPsw':'" + userPassword + "', 'smsOperatorLink':'" + smsOperatorLink + "', 'smsNumber':'" + num + "', 'smsText':'" + message + "'}",
                   
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        
                        <%--if (data.d.length != 0) {
                            $('#<%=CustSelect.ClientID%>').empty();
                            var res = data.d;
                            $.each(res, function (key, value) {
                                alert('SMS sent!')
                            });
                        }
                        else {
                            alert('No customer was found. Please search with something else as your data.')
                        }--%>
                        //swal("Sms er sendt til " + num + ".");
                        swal('<%=GetLocalResourceObject("SmsSent")%>'+" " + num + ".");
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    },
                    select: function (e, i) {
                        swal('hi');

                    },
                });
            }

            function LoadEniroDet(eniroId) {
                if ($('#txtCustId').val() == "") {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/LoadEniroDet",
                        data: "{EniroId: '" + eniroId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d.length != 0) {
                                $('#aspnetForm')[0].reset();
                                $('#customerContactPH').html('');
                                FetchCustomerTemplate($('#<%=ddlCustomerTemplate.ClientID%>').val());
                                $('#customerContactPH').html('');
                                $('#<%=txtEniroId.ClientID%>').val(data.d[0].ENIRO_ID);
                                $('#<%=txtFirstname.ClientID%>').val(data.d[0].CUST_FIRST_NAME);
                                $('#<%=txtMiddlename.ClientID%>').val(data.d[0].CUST_MIDDLE_NAME);
                                $('#<%=txtLastname.ClientID%>').val(data.d[0].CUST_LAST_NAME);
                                $('#<%=txtPermAdd1.ClientID%>').val(data.d[0].CUST_PERM_ADD1);
                                $('#<%=txtPermZip.ClientID%>').val(data.d[0].ID_CUST_PERM_ZIPCODE);
                                $('#<%=txtPermCity.ClientID%>').val(data.d[0].CUST_PERM_ADD2);
                                $('#<%=txtPermCounty.ClientID%>').val(data.d[0].CUST_COUNTY);
                                //if (data.d[0].PHONE_TYPE == 'M') {
                                //    insertContactField('1', 'Mobil', data.d[0].CUST_PHONE_MOBILE, 'TRUE', '1');
                                //}
                                //if (data.d[0].PHONE_TYPE == 'T') {
                                //    insertContactField('1', 'Direkte', data.d[0].CUST_PHONE_MOBILE, 'TRUE', '1');
                                //}
                                $('#<%=txtAdvSsnNo.ClientID%>').val(data.d[0].CUST_SSN_NO);
                                if (data.d[0].CUST_SSN_NO.length > 0) {
                                    LoadBrreg(data.d[0].CUST_SSN_NO);
                                }
                                $('#<%=txtBirthDate.ClientID%>').val(data.d[0].CUST_BORN);

                                if (data.d[0].CUST_FIRST_NAME == '') {
                                    $("#<%=chkPrivOrSub.ClientID%>").prop('checked', true);
                                    setCustomerType();
                                }
                                else {
                                    $("#<%=chkPrivOrSub.ClientID%>").prop('checked', false);
                                    setCustomerType();
                                }
                                $('#<%=txtWashDate.ClientID%>').val($.datepicker.formatDate("dd.mm.yy", new Date()));
                                BindContact(data.d[0].ID_CUST);

                                $('.overlayHide').removeClass('ohActive');
                                $('#txtCustId').val('');
                                setBillAdd();
                            }
                            else {
                                //alert('No customer was found. Please search with something else as your data.')
                                swal('<%=GetLocalResourceObject("CustNotFound")%>');
                            }
                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/LoadEniroDet",
                        data: "{EniroId: '" + eniroId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d.length != 0) {
                               
                               
                            FetchCustomerTemplate($('#<%=ddlCustomerTemplate.ClientID%>').val());
                         
                            $('#<%=txtEniroId.ClientID%>').val(data.d[0].ENIRO_ID);
                            $('#<%=txtFirstname.ClientID%>').val(data.d[0].CUST_FIRST_NAME);
                            $('#<%=txtMiddlename.ClientID%>').val(data.d[0].CUST_MIDDLE_NAME);
                            $('#<%=txtLastname.ClientID%>').val(data.d[0].CUST_LAST_NAME);
                            $('#<%=txtPermAdd1.ClientID%>').val(data.d[0].CUST_PERM_ADD1);
                            $('#<%=txtPermZip.ClientID%>').val(data.d[0].ID_CUST_PERM_ZIPCODE);
                            $('#<%=txtPermCity.ClientID%>').val(data.d[0].CUST_PERM_ADD2);
                            $('#<%=txtPermCounty.ClientID%>').val(data.d[0].CUST_COUNTY);
                            //if (data.d[0].PHONE_TYPE == 'M') {
                            //    insertContactField('1', 'Mobil', data.d[0].CUST_PHONE_MOBILE, 'TRUE', '1');
                            //}
                            //if (data.d[0].PHONE_TYPE == 'T') {
                            //    insertContactField('1', 'Direkte', data.d[0].CUST_PHONE_MOBILE, 'TRUE', '1');
                            //}
                            $('#<%=txtAdvSsnNo.ClientID%>').val(data.d[0].CUST_SSN_NO);
                            if (data.d[0].CUST_SSN_NO.length > 0) {
                                LoadBrreg(data.d[0].CUST_SSN_NO);
                            }
                            $('#<%=txtBirthDate.ClientID%>').val(data.d[0].CUST_BORN);

                            if (data.d[0].CUST_FIRST_NAME == '') {
                                $("#<%=chkPrivOrSub.ClientID%>").prop('checked', true);
                                setCustomerType();
                            }
                            else {
                                $("#<%=chkPrivOrSub.ClientID%>").prop('checked', false);
                                setCustomerType();
                            }
                            $('#<%=txtWashDate.ClientID%>').val($.datepicker.formatDate("dd.mm.yy", new Date()));
                            BindContact(data.d[0].ID_CUST);

                            $('.overlayHide').removeClass('ohActive');
                           
                            setBillAdd();
                        }
                        else {
                            //alert('No customer was found. Please search with something else as your data.')
                            swal('<%=GetLocalResourceObject("CustNotFound")%>');
                        }
                    },
                    failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
                
            }

            function BindContact(Id) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/BindContact",
                    data: "{Id: '" + Id + "'}",
                    dataType: "json",
                    async: false,//Very important
                    success: function (Result) {
                        for (var i = 0; i < Result.d.length; i++) {
                            var label = Result.d[i].split('-')[0];
                            if (label == 'M') {
                                insertContactField('1', 'Mobil', Result.d[i].split('-')[1], 'TRUE', '1');
                            }
                            else if (label == 'T') {
                                insertContactField('1', 'Direkte', Result.d[i].split('-')[2], 'TRUE', '2');
                            }
                            else {
                                insertContactField('1', 'Direkte', Result.d[i].split('-')[2], 'TRUE', '2');
                            }
                        }
                    }
                });
            }

            function WashEniroData() {

                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/FetchEniro",
                    data: "{search: '" + $('#<%=txtFirstname.ClientID()%>').val() + " " + $('#<%=txtMiddlename.ClientID()%>').val() + " " + $('#<%=txtLastname.ClientID()%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length != 0) {
                            var res = data.d;
                            $.each(res, function (key, value) {
                                console.log(value.ENIRO_ID);
                                if (value.ENIRO_ID == $('#<%=txtEniroId.ClientID()%>').val()) {
                                    $('#<%=txtWashEniroLastName.ClientID()%>').val(value.CUST_LAST_NAME);
                                    $('#<%=txtWashEniroFirstName.ClientID()%>').val(value.CUST_FIRST_NAME);
                                    $('#<%=txtWashEniroMiddleName.ClientID()%>').val(value.CUST_MIDDLE_NAME);
                                    $('#<%=txtWashEniroVisitAddress.ClientID()%>').val(value.CUST_PERM_ADD1);
                                    $('#<%=txtWashEniroZipCode.ClientID()%>').val(value.ID_CUST_PERM_ZIPCODE);
                                    $('#<%=txtWashEniroZipPlace.ClientID()%>').val(value.CUST_PERM_ADD2);
                                    if (value.PHONE_TYPE == 'M') {
                                        $('#<%=txtWashEniroMobile.ClientID()%>').val(value.CUST_PHONE_MOBILE);
                                    }
                                    if (value.PHONE_TYPE == 'T') {
                                        $('#<%=txtWashEniroPhone.ClientID()%>').val(value.CUST_PHONE_MOBILE);
                                    }

                                    if (value.CUST_SSN_NO != "") {
                                        $('#<%=txtWashEniroSsnNo.ClientID()%>').val(value.CUST_SSN_NO);
                                        $('#bornDate').hide();
                                        $('#ssnNo').show();
                                       
                                    }
                                    else {
                                        $('#<%=txtWashEniroBorn.ClientID()%>').val(value.CUST_BORN);
                                        $('#ssnNo').hide();
                                        $('#bornDate').show();
                                      
                                    }
                                    
                                    
                                }
                            });
                        }
                        else {
                            //alert('No customer was found. Please search with something else as your data.')
                             swal('<%=GetLocalResourceObject("CustNotFound")%>');
                        }
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    },
                    select: function (e, i) {
                        swal('hi');

                    },
                });
            }

            function checkFormType(e) {

                return elemType;
            }
            $("#btnCustEmptyScreen").on('click', function (e) {
                fetchFLG = false;
                $(this).addClass('loading');
                $('#aspnetForm')[0].reset();
                $('#lblName').text('');
                $('#privateIcon').hide();
                $('#businessIcon').hide();
                $('#customerContactPH').html('');
                $('#btnCustNotes').removeClass('warningAN');
                $('#exclamIcon').hide();
                $("#carList-table").tabulator("clearData");
                $("#activities-table").tabulator("clearData");
                console.log($(this).prop('id'));
                if ($(this).prop('id') == 'btnCustNewCust') {
                    $('#txtCustId').focus();
                }
                $('.loading').removeClass('loading');
            });


            $("#btnCustNewCust").on('click', function (e) {
                fetchFLG = false;
                $(this).addClass('loading');
                $("#carList-table").tabulator("clearData");
                $("#activities-table").tabulator("clearData");
                $('#aspnetForm')[0].reset();
                $('#lblName').text('');
                $('#privateIcon').hide();
                $('#businessIcon').hide();
                $('#customerContactPH').html('');
                $('#ctl00_cntMainPanel_ddlCustomerTemplate option[value="01"]').prop('selected', true);
                var tempId = $('#<%=ddlCustomerTemplate.ClientID%>').val();
                FetchCustomerTemplate(tempId);

                $('#exclamIcon').hide();
                console.log($(this).prop('id'));
                if ($(this).prop('id') == 'btnCustNewCust') {
                    $('#txtCustId').focus();
                }
                $('.loading').removeClass('loading');
            });
            //CUSTOMER CONTACT SAVE FUNCTION
            function AddCustomerContact() {
                if ($('#<%=txtCustomerId.ClientID%>').val().length <= 0 || !fetchFLG) {
                    var id = 0;
                    var name = $('#<%=drpContactType.ClientID%> option:selected').text();
                    var value = $('#<%=txtContactType.ClientID%>').val();
                    var type = $('#<%=drpContactType.ClientID%> option:selected').val();
                    var standard = $('#<%=chkContactType.ClientID%>').is(":checked");
                    insertContactField(id, name, value, standard, type);
                } else {
                    var seq = '';
                    var customerID = $('#<%=txtCustomerId.ClientID%>').val();
                    var contactValue = $('#<%=txtContactType.ClientID%>').val();
                    var contactType = $('#<%=drpContactType.ClientID%> option:selected').val();
                    var contactStandard = $('#<%=chkContactType.ClientID%>')[0].checked;
                    SaveCustomerContact(seq, contactType, customerID, contactValue, contactStandard);
                }
            }
            function SaveCustomerContact(seq, contactType, customerID, contactValue, contactStandard) {
                var postData = '{seq: "' + seq + '", contactType: "' + contactType + '", customerId: "' + customerID + '", contactValue: "' + contactValue + '", contactStandard: "' + contactStandard + '" }';
                if (debug) { console.log(postData); }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/AddCustomerContact",
                    data: postData,
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "INSFLG") {
                            if (debug) { console.log('New contact added for customer: ' + customerID); }
                            loadContact(customerID);
                        }
                    },
                    error: function (jqXHR, error, errorThrown) {
                        if (jqXHR.status && jqXHR.status == 400) {
                            swal(jqXHR.responseText);

                        } else {
                            console.log("Unable to process AddCustomerContact");

                        }
                    }
                });
            }

            function saveCustomer() {
                var customer = collectGroupData('submit');
                var fromPage = getUrlParameter('pageName');
                console.log(fromPage);

                if ($('#<%=txtCustomerId.ClientID%>').val() == "" && $('#<%=txtFirstname.ClientID%>').val() == "Kunde" && $('#<%=txtLastname.ClientID%>').val() == "Default") {
                    //swal("Du må legge inn kundens navn!")
                    swal('<%=GetLocalResourceObject("CustNameValidation")%>');
                    $('.loading').removeClass('loading');
                }
                else {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/InsertCustomerDetails",
                    data: "{'Customer': '" + JSON.stringify(customer) + "'}",
                    dataType: "json",
                    //async: false,//Very important
                    success: function (data) {
                        $('.loading').removeClass('loading');
                        if (data.d[0] == "INSFLG") {

                            $('#<%=ddlContactPerson.ClientID%>').empty().prop('disabled', false);
                            $('#<%=txtCustomerId.ClientID%>').val(data.d[1]);

                            setSaveVar();
                            systemMSG('success', '<%=GetLocalResourceObject("CustIns")%>', 4000); //'Kundedetaljer er lagret!'
                            if (window.parent != undefined && window.parent != null && window.parent.length > 0) {
                                if (fromPage == "OrderHead") { window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchCust').value = data.d[1]; }

                                else if (fromPage == "Vehicle") { window.parent.document.getElementById('ctl00_cntMainPanel_txtCustNo').value = data.d[1]; }

                                else if (fromPage == "AppointmentFormCustomer") {
                                    window.parent.tbCustomerNo.SetText(data.d[1]);
                                }
                                <%--else if (fromPage == "TireHotel") {
                                    //debugger;
                                    
                                    window.parent.FetchCustomerDetails($('#<%=txtCustomerId.ClientID%>').val());
                                    window.parent.$('.ui-dialog-content:visible').dialog('close');
                                }--%>
                                
                                saveInputBackToParentWindow(fromPage);
                                window.parent.$('.ui-dialog-content:visible').dialog('close');

                            }
                        }
                        else if (data.d[0] == "UPDFLG") {
                            setSaveVar();
                            systemMSG('success', '<%=GetLocalResourceObject("CustUpd")%>', 4000); //'Kundedetaljer er oppdatert!'
                            if (window.parent != undefined && window.parent != null && window.parent.length > 0) {

                                saveInputBackToParentWindow(fromPage);

                                if (fromPage == "OrderHead") {
                                    //if the textfield in parent is different from the one in the popup window(when new search in popup has been perfomed)
                                    if (window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchCust').value != data.d[1]) {
                                        window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchCust').value = data.d[1];
                                        window.parent.FillCustDet(data.d[1]);
                                        window.parent.FillVehDrpDwn(data.d[1]);
                                        window.parent.LoadNonInvoiceOrderDet(data.d[1]);
                                    }
                                }
                                else if (fromPage == "Vehicle") {

                                    if (window.parent.document.getElementById('ctl00_cntMainPanel_txtCustNo').value != data.d[1]) {
                                        window.parent.document.getElementById('ctl00_cntMainPanel_txtCustNo').value = data.d[1];
                                        window.parent.document.getElementById('ctl00_cntMainPanel_txtCustSearchEniro').value = "";
                                    }

                                }
                                else if (fromPage == "AppointmentFormCustomer") {
                                    if (window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbCustomerNo_I').value != data.d[1]) {
                                        window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbCustomerNo_I').value = data.d[1];
                                        window.parent.FillCustDet(data.d[1]);
                                        window.parent.FillVehDrpDwn(data.d[1]);
                                        //window.parent.LoadNonInvoiceOrderDet(data.d[1]);
                                    }
                                }


                                window.parent.$('.ui-dialog-content:visible').dialog('close');

                            }
                        }
                        else if (data.d[0] == "ERRFLG") { systemMSG('error', '<%=GetLocalResourceObject("CustErr")%>', 4000); }

                        if (data.d[1].length > 0) { buildContactInfo(data.d[1]); }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
                }
            }
            /*
                saveInputBackToParentWindow(fromPage) is a helper funtion to the above function
                simply saves stuff back to the parent window's inputfields when clicking "save" 
            */
            function saveInputBackToParentWindow(fromPage) {
                if (fromPage == "OrderHead") {
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtSrchCust').value = $('#<%=txtCustomerId.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtName').value = $('#<%=txtFirstname.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtMName').value = $('#<%=txtMiddlename.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtLName').value = $('#<%=txtLastname.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_ddlPayType').value = $('#<%=ddlPayType.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_ddlPayTerms').value = $('#<%=ddlPayTerms.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_ddlCusGroup').value = $('#<%=ddlCustGroup.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtAddress1').value = $('#<%=txtPermAdd1.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtZipCode').value = $('#<%=txtPermZip.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtState').value = $('#<%=txtPermCity.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtMail').value = $('#<%=hdnMail.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtMobile').value = $('#<%=hdnMobile.ClientID%>').val();

                }
                else if (fromPage == "Vehicle") {
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustFirstName').value = $('#<%=txtFirstname.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustMiddleName').value = $('#<%=txtMiddlename.ClientID%>').val()
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustLastName').value = $('#<%=txtLastname.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustAdd1').value = $('#<%=txtPermAdd1.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustVisitZip').value = $('#<%=txtPermZip.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustVisitPlace').value = $('#<%=txtPermCity.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustBillAdd').value = $('#<%=txtBillAdd1.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustBillZip').value = $('#<%=txtBillZip.ClientID%>').val();
                    window.parent.document.getElementById('ctl00_cntMainPanel_txtCustBillPlace').value = $('#<%=txtBillCity.ClientID%>').val();

                }
                else if (fromPage == "AppointmentFormCustomer") {

                    window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbFirstName_I').value = $('#<%=txtFirstname.ClientID%>').val();

                    window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbMiddleName_I').value = $('#<%=txtMiddlename.ClientID%>').val();

                    window.parent.document.getElementById('ctl00_cntMainPanel_schdMechanics_formBlock_AptFrmContainer_AptFrmTemplateContainer_AppointmentForm_tbLastName_I').value = $('#<%=txtLastname.ClientID%>').val();

                }
                else if (fromPage == "TireHotel") {
                    window.parent.FetchCustomerDetails($('#<%=txtCustomerId.ClientID%>').val());
                    window.parent.$('.ui-dialog-content:visible').dialog('close');
                  
                }

            }


            function saveGDPR() {
                var customer = collectGroupData('submit');
                var fromPage = getUrlParameter('pageName');
                console.log(fromPage);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/InsertGDPRDetails",
                    data: "{'Customer': '" + JSON.stringify(customer) + "'}",
                    dataType: "json",
                    //async: false,//Very important
                    success: function (data) {
                        $('.loading').removeClass('loading');
                        genIns = "GDPR";
                        genUpd = "GDPR";
                        if (data.d == "INSFLG") {                          
                            systemMSG('success', `<%=GetLocalResourceObject("GenNewIns")%>`, 4000);                           
                        }
                        else if (data.d == "UPDFLG") {
                            systemMSG('success', `<%=GetLocalResourceObject("GenNewUpd")%>`, 4000);                         
                        }
                        else if (data.d == "ERRFLG") {
                            //systemMSG('error', 'An error occured while trying to save the GDPR, please check input data.', 4000);
                            systemMSG('error', `<%=GetLocalResourceObject("GenSavingError")%>`, 4000);
                        }                       
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }

            function saveGdprResponse(custId, manSms, manMail, pkkSms, pkkMail, servSms, servMail, utsTilbSms, utsTilbMail, xtraSms, xtraMail, remSms, remMail, infoSms, infoMail, oppfSms, oppfMail, markSms, markMail, responseDate) {
                console.log("inside the save response: " + manSms);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/InsertGdprResponse",
                    data: "{'custId': '" + custId + "', 'manSms':'" + manSms + "', 'manMail':'" + manMail
                        + "', 'pkkSms':'" + pkkSms + "', 'pkkMail':'" + pkkMail + "', 'servSms':'" + servSms + "', 'servMail':'" + servMail
                        + "', 'utsTilbSms':'" + utsTilbSms + "', 'utsTilbMail':'" + utsTilbMail + "', 'xtraSms':'" + xtraSms + "', 'xtraMail':'" + xtraMail
                        + "', 'remSms':'" + remSms + "', 'remMail':'" + remMail + "', 'infoSms':'" + infoSms + "', 'infoMail':'" + infoMail
                        + "', 'oppfSms':'" + oppfSms + "', 'oppfMail':'" + oppfMail + "', 'markSms':'" + markSms + "', 'markMail':'" + markMail
                        + "', 'responseDate':'" + responseDate + "'}",

                    dataType: "json",
                    //async: false,//Very important
                    success: function (data) {
                        $('.loading').removeClass('loading');
                        genIns = "GDPR";
                        genUpd = "GDPR";
                        if (data.d == "INSFLG") {
                            systemMSG('success',`<%=GetLocalResourceObject("GenNewIns")%>` , 4000);//'GDPR er lagret!'
                            FetchGdprDetails(custId);
                        }
                        else if (data.d == "UPDFLG") {
                            systemMSG('success',`<%=GetLocalResourceObject("GenNewUpd")%>` , 4000); //'GDPR er oppdatert!'
                            FetchGdprDetails(custId);

                        }
                        else if (data.d == "ERRFLG") {
                            //systemMSG('error', 'An error occured while trying to save the GDPR, please check input data.', 4000);
                            systemMSG('error', `<%=GetLocalResourceObject("GenSavingError")%>`, 4000);
                        }


                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }
            
            

            /*Fetches the data you need from sms config to be able to send sms. Username, password etc.*/
            function fetchSMSConfig(type) {


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
                            if (type == "GDPR") {
                                gdprMobile();
                            }
                            else if (type == "BARGAIN") {
                                swal("Not possible from this page!");
                            }

                        }
                    }
                });
            }


            function gdprMobile() {
               
                let deptId = arrayOfValues[0]

                let senderSMS = arrayOfValues[1]
                let userId = encodeURIComponent(arrayOfValues[2])
                let userPassword = encodeURIComponent(arrayOfValues[3])
             
                let smsOperatorLink = arrayOfValues[4]
                let sename = arrayOfValues[5].toString();
                let sephone = arrayOfValues[6].toString();
                let messageType = "GDPR"
                let messageText = '<%=GetLocalResourceObject("GdprMessageText")%>' + " ";
                let time = ""
                let s = [];
                let c = 0;
                let checkmarkString = ""; 
                let first = true;
                let custId = $('#<%=txtCustomerId.ClientID%>').val();
                let cust_mob = $('[data-contact-type=1]').val();
              
                if (cust_mob == "" || cust_mob == undefined) {
                    swal('<%=GetLocalResourceObject("SmsAlert")%>'); //"Kunden må ha et mobilnummer for å kunne sende SMS."
                    $('#btnSendGDPR').removeClass('loading');
                }
                else {
                    let name = "";
                    if ($('#<%=txtMiddlename.ClientID%>').val() == "") {
                        name = $('#<%=txtFirstname.ClientID%>').val() + " " + $('#<%=txtLastname.ClientID%>').val()
                         }
                         else if ($('#<%=txtMiddlename.ClientID%>').val() == "" && $('#<%=txtFirstname.ClientID%>').val() == "") {
                             name = $('#<%=txtLastname.ClientID%>').val()
                     }
                     else {
                         name = $('#<%=txtFirstname.ClientID%>').val() + " " + $('#<%=txtMiddlename.ClientID%>').val() + " " + $('#<%=txtLastname.ClientID%>').val()
                    }
                    var jsonGdprData = '{"dist": "' + 'CAS' + '", "cuno": "' + custId + '", "cuname": "'
                        + name + '", "cumobile": "' + cust_mob + '", "sename": "' + sename
                        + '", "sephone": "' + sephone  + '"}';
                         name = JSON.stringify(name);
                         let cust_mob_json = JSON.stringify(cust_mob);
                         let orderId = "";
                   

                    $.ajax({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCustomerDetail.aspx/GdprSMSNew",
                        data: "{jsonGdprData:'" + jsonGdprData + "'}" ,
                        //data: "{'jsonGdprData':'" + jsonGdprData + "'}" ,
                    dataType: "json",
                        success: function (data) {
                           
                            if (data.d.length > 0) {
                             
                            //Setting up the Hidden Variable for Id Bargain
                            $('#btnSendGDPR').removeClass('loading');
                                 var bargainUrl = "https://carsapp.nodelab.no/consent/"
                                messageText = messageText + " " + bargainUrl + data.d;
                            var num = cust_mob;
                                 var time = ""//getFormatedDateTimeNow(); //To get the current datetime in YYYY-DD-MM hh:mm:ss format
                                var smsid = "P";
                                $('#<%=txtGdprResponseId.ClientID%>').val(data.d);
                                saveGDPR();
                                 $.ajax({
                                     type: "POST",
                                     url: "./frmSendSMS.aspx/SendSMS",
                                     data: "{num: '" + num + "', 'message': '" + messageText + "', 'time': '" + time + "', 'id': '" + smsid + "', 'user': '" + userId + "', 'password': '" + userPassword + "', 'dru': '" + smsOperatorLink + "'}",
                                     contentType: "application/json; charset=utf-8",
                                     dataType: "json",
                                     async: false,
                                     success: function (data) {
                                         if (data.d.length != 0) {
                                             if (data.d == "OK") {
                                                 var msg = "GDPR SMS"
                                                 saveSMS(msg, cust_mob, messageText);
                                                 swal("Sms er sendt til " + cust_mob + " og loggført.");
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
                             }

                         },
                         error: function (result) {
                             alert("Error");
                         }
                     });
                  
                }
            }

            function saveSMS(msg, cust_mob, messageText) {
                var msgType = msg;
                var time = getFormatedDateTimeNow();

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../Master/frmSendSMS.aspx/SaveSMS",
                    data: "{dept: '" + arrayOfValues[0] + "', phoneFrom:'" + arrayOfValues[1] + "', phoneTo:'" + cust_mob + "', messageType:'" + msgType + "', messageText:'" + messageText + "', time:'" + time + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d[0] != "") {
                            swal("SMS ble lagret!")
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
            function getFormatedDateTimeNow() {
                //Since the API takes YYYY-DD-MM hh:mm:ss format to send the SMS
                var today = new Date();
                var mydate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
                var mytime = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var dateTime = mydate + ' ' + mytime;
                return dateTime;
            }

            function gdprResponse() {
                var manSms = "0";
                var manMail = "0";
                var pkkSms = "0";
                var pkkMail = "0";
                var servSms = "0";
                var servMail = "0";
                var utsTilbSms = "0";
                var utsTilbMail = "0";
                var xtraSms = "0";
                var xtraMail = "0";
                var remSms = "0";
                var remMail = "0";
                var infoSms = "0";
                var infoMail = "0";
                var oppfSms = "0";
                var oppfMail = "0";
                var markSms = "0";
                var markMail = "0";
                

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmCustomerDetail.aspx/ResponsArrived",
                    data: '{"responseId": "' + $('#<%=txtGdprResponseId.ClientID%>').val() + '"}',
                    dataType: "json",
                    success: function (data) {
                        var result = JSON.parse(data.d);
                        console.log(result);
                       
                       
                        if (data.d.length > 0) {
                            //alert(result.market_info_mail);
                            if (result.market_info_mail == true) {
                                //alert("markedsføring er true");
                                markMail = "1";
                                infoMail = "1";
                                utsTilbMail = "1";
                            }
                            else {
                                markMail = "0";
                                infoMail = "0";
                                utsTilbMail = "0";
                            }
                            if (result.market_info_sms == true) {
                                markSms = "1";
                                infoSms = "1";
                                utsTilbSms = "1";
                            }
                            else {
                                markSms = "0";
                                infoSms = "0";
                                utsTilbSms = "0";
                            }
                            if (result.reminder_mail == true) {
                                manMail = "1";
                                xtraMail = "1";
                                remMail = "1";
                                oppfMail = "1";
                            }
                            else {
                                manMail = "0";
                                xtraMail = "0";
                                remMail = "0";
                                oppfMail = "0";
                            }
                            if (result.reminder_sms == true) {
                                manSms = "1";
                                xtraSms = "1";
                                remSms = "1";
                                oppfSms = "1";
                            }
                            else {
                                manSms = "0";
                                xtraSms = "0";
                                remSms = "0";
                                oppfSms = "0";
                            }
                            if (result.service_mail == true) {
                                pkkMail = "1";
                                servMail = "1";
                            }
                            else {
                                pkkMail = "0"
                                servMail = "0";
                            }
                            if (result.service_sms == true) {
                                pkkSms = "1";
                                servSms = "1";
                            }
                            else {
                                pkkSms = "0";
                                servSms = "0";
                            }
                            
                            resDate = data.d[19];
                            var responseDate = resDate.replace(/\./g, '-');
                            saveGdprResponse(result.cuno, manSms, manMail, pkkSms, pkkMail, servSms, servMail, utsTilbSms, utsTilbMail, xtraSms, xtraMail, remSms, remMail, infoSms, infoMail, oppfSms, oppfMail, markSms, markMail, result.answered);
                        }
                        

                    },
                    error: function (result) {
                        swal('<%=GetLocalResourceObject("ErrorAlert")%>');
                    }
                });
            }

            

            $('#btnCustSave').on('click', function (e) {
                var errorMsg = '<%=GetLocalResourceObject("RequiredFieldError")%>';
                if (requiredFieldsValidate(true, 'data-submit', errorMsg) === true) {
                    $(this).addClass('loading');
                    saveCustomer();
                    loadCompanyList($('#<%=txtCompanyPerson.ClientID%>').val());
                }
            });

            

            $('#btnSaveGDPR').on('click', function (e) {
                if ($('#<%=txtCustomerId.ClientID%>').val() == "") {
                    swal('<%=GetLocalResourceObject("GDPRValidation")%>'); //"Du må hente opp en kunde før du kan lagre GDPR data."
                }
                else {
                    $(this).addClass('loading');
                    saveGDPR();
                }
                    
                    
                
            });
            $('#btnSendGDPR').on('click', function (e) {

                $('#btnSendGDPR').addClass('loading');
                var sendingValue = "GDPR";
                fetchSMSConfig(sendingValue);


            });

            $('#btnUncheckAllGdpr').on('click', function (e) {

                $("#<%=chkManualSms.ClientID%>").prop('checked', false);
                $("#<%=chkManualMail.ClientID%>").prop('checked', false);
                $("#<%=chkPkkSms.ClientID%>").prop('checked', false);
                $("#<%=chkPkkMail.ClientID%>").prop('checked', false);
                $("#<%=chkServiceSms.ClientID%>").prop('checked', false);
                $("#<%=chkServiceMail.ClientID%>").prop('checked', false);
                $("#<%=chkBargainSms.ClientID%>").prop('checked', false);
                $("#<%=chkBargainMail.ClientID%>").prop('checked', false);
                $("#<%=chkXtracheckSms.ClientID%>").prop('checked', false);
                $("#<%=chkXtracheckMail.ClientID%>").prop('checked', false);
                $("#<%=chkReminderSms.ClientID%>").prop('checked', false);
                $("#<%=chkReminderMail.ClientID%>").prop('checked', false);
                $("#<%=chkInfoSms.ClientID%>").prop('checked', false);
                $("#<%=chkInfoMail.ClientID%>").prop('checked', false);
                $("#<%=chkFollowupSms.ClientID%>").prop('checked', false);
                $("#<%=chkFollowupMail.ClientID%>").prop('checked', false);
                $("#<%=chkMarketingSms.ClientID%>").prop('checked', false);
                $("#<%=chkMarketingMail.ClientID%>").prop('checked', false);
            });

            $('#btnCheckAllGdpr').on('click', function (e) {

                $("#<%=chkManualSms.ClientID%>").prop('checked', true);
                $("#<%=chkManualMail.ClientID%>").prop('checked', true);
                $("#<%=chkPkkSms.ClientID%>").prop('checked', true);
                $("#<%=chkPkkMail.ClientID%>").prop('checked', true);
                $("#<%=chkServiceSms.ClientID%>").prop('checked', true);
                $("#<%=chkServiceMail.ClientID%>").prop('checked', true);
                $("#<%=chkBargainSms.ClientID%>").prop('checked', true);
                $("#<%=chkBargainMail.ClientID%>").prop('checked', true);
                $("#<%=chkXtracheckSms.ClientID%>").prop('checked', true);
                $("#<%=chkXtracheckMail.ClientID%>").prop('checked', true);
                $("#<%=chkReminderSms.ClientID%>").prop('checked', true);
                $("#<%=chkReminderMail.ClientID%>").prop('checked', true);
                $("#<%=chkInfoSms.ClientID%>").prop('checked', true);
                $("#<%=chkInfoMail.ClientID%>").prop('checked', true);
                $("#<%=chkFollowupSms.ClientID%>").prop('checked', true);
                $("#<%=chkFollowupMail.ClientID%>").prop('checked', true);
                $("#<%=chkMarketingSms.ClientID%>").prop('checked', true);
                $("#<%=chkMarketingMail.ClientID%>").prop('checked', true);
            });


            function clearContacts() {
                $('#customerContactPH').html('');
            }

            function loadContact(custId) {
                console.log('Running loadContact with id ' + custId);
                clearContacts();
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/LoadContact",
                    data: "{'custId': '" + custId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        Result = Result.d;
                        $.each(Result, function (key, value) {
                            insertContactField(value.id, value.description, value.value, value.standard, value.type);
                        });
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }
            var countCont = 1;
            var contactOptions = {};
            function insertContactField(id, name, value, standard, type) {
                var elem = "<div class=\"inline fields contactWrapper\"><div class=\"five wide field\"><label for=\"txtContact" + countCont + "\">" + name + "</label></div><div class=\"eleven wide field\"><input type=\"text\" id=\"txtContact" + countCont + "\" data-contact=\"contact\" class=\"twelve char field\" value=\"" + value + "\" data-contact-type=\"" + type + "\" data-contact-id=\"" + id + "\" data-contact-standard=\"" + standard + "\"/><i class='checkmark icon'></i></div></div>";
                $('#customerContactPH').append(elem);
                if (standard == true) {
                    $('#txtContact' + countCont).closest('.contactWrapper').addClass('isStandard');
                }
                countCont = countCont + 1;
                if (standard == true && type == 1) {

                    $('#<%=hdnMobile.ClientID%>').val(value);
                }
                if (standard == true && type == 6) {

                    $('#<%=hdnMail.ClientID%>').val(value);
                }
            }

            function standardContact(obj) {
                if ($('#<%=txtCustomerId.ClientID%>').val().length > 0 || !fetchFLG) {
                    var id = $(obj).data('contact-id');
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/StandardContact",
                        data: "{'CustomerSeq': '" + id + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            systemMSG('success','<%=GetLocalResourceObject("CustContactInfoSave")%>' , 4000); //'Kontaktinformasjonen ble oppdatert på kunden'
                            loadContact($('#<%=txtCustomerId.ClientID%>').val());
                        },
                        failure: function () {
                            systemMSG('error','<%=GetLocalResourceObject("CustContactInfoSaveErr")%>' , 4000);//'Kontaktinformasjonen ble ikke slettet, prøv å åpne kunden på nytt.'
                        }
                    });
                } else {
                    var type = $(obj).data('contact-type');
                    $("input[data-contact-type='" + type + "']").each(function (index, elem) {
                        $(elem).data('contact-standard', 'false');
                        $(elem).parents('.isStandard').removeClass('isStandard');
                    })
                    $(obj).data('contact-standard', 'true');
                    $(obj).parents('.inline.fields').addClass('isStandard');
                }
            }
            function deleteContactField(elem) {
                if ($('#<%=txtCustomerId.ClientID%>').val().length > 0 || fetchFLG == true) {
                    console.log(elem);
                    var id = $('#' + elem).data('contact-id');
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/DeleteContact",
                        data: "{'CustomerSeq': '" + id + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            systemMSG('success', '<%=GetLocalResourceObject("CustContactInfoDel")%>', 4000); //'"Kontaktinformasjonen ble fjernet fra kunden!'
                            //$('#' + elem).parents('.inline.fields').remove();
                            loadContact($('#<%=txtCustomerId.ClientID%>').val());
                        },
                        failure: function () {
                            systemMSG('error', '<%=GetLocalResourceObject("CustContactInfoDelErr")%>', 4000);//'Kontaktinformasjonen ble ikke slettet, prøv å åpne kunden på nytt.'
                            
                        }
                    });
                } else {
                    $('#' + elem).parents('.inline.fields').remove();
                    
                }
            }
            var contactInformation = {};
            function buildContactInfo(customer) {
                contactInformation = {};
                if (debug) { console.log("Running buildContactInfo()"); }
                $('[data-contact]').each(function (index, elem) {
                    var contactCard = [];

                    var seq = $(elem).data('contact-id');
                    if (seq == 0) {
                        seq = '';
                    }
                    var type = $(elem).data('contact-type');
                    var value = $(elem).val();
                    var standard = $(elem).data('contact-standard');
                    contactCard = {
                        customer: customer,
                        seq: seq,
                        type: type,
                        value: value,
                        standard: standard
                    }
                    contactInformation['contactCard' + index] = contactCard;
                    if (debug) { console.log("Testing values Seq: " + seq + " Type: " + type + " Value: " + value + " Standard: " + standard); }
                });
                if (debug) { console.log(contactInformation); }
                $.each(contactInformation, function (index, value) {
                    console.log(index + ' ' + value['customer'] + ' ' + value['seq'] + ' ' + value['type'] + ' ' + value['value'] + ' ' + value['standard']);
                    SaveCustomerContact(value['seq'], value['type'], value['customer'], value['value'], value['standard']);
                });

            }
            function setCustomerType() {
                (companyIsChecked()) ? customerType('c') : customerType();
            }
            $("#panelPermAdd input").bind("change keyup blur", function () {
                setBillAdd();
            });
            function setBillAdd() {
                if (sameAdressIsChecked()) {
                    $('#<%=txtBillAdd1.ClientID%>').val($('#<%=txtPermAdd1.ClientID%>').val()).prop('disabled', true);
                    <%--$('#<%=txtBillAdd2.ClientID%>').val($('#<%=txtPermAdd2.ClientID%>').val()).prop('disabled', true);--%>
                    $('#<%=txtBillZip.ClientID%>').val($('#<%=txtPermZip.ClientID%>').val()).prop('disabled', true);
                    $('#<%=txtBillCity.ClientID%>').val($('#<%=txtPermCity.ClientID%>').val()).prop('disabled', true);
                    $('#<%=txtBillCounty.ClientID%>').val($('#<%=txtPermCounty.ClientID%>').val()).prop('disabled', true);

                }
                else {
                    $('#<%=txtBillAdd1.ClientID%>').prop('disabled', false);
                <%--    $('#<%=txtBillAdd2.ClientID%>').prop('disabled', false);--%>
                    $('#<%=txtBillZip.ClientID%>').prop('disabled', false);
                    $('#<%=txtBillCity.ClientID%>').prop('disabled', false);
                    $('#<%=txtBillCounty.ClientID%>').prop('disabled', false);

                }
            }
            function companyIsChecked() {
                if ($('#<%=chkPrivOrSub.ClientID%>').is(':checked'))
                    return true;
                else
                    return false;
            }
            function sameAdressIsChecked() {
                if ($('#<%=chkSameAdd.ClientID%>').is(':checked'))
                    return true;
                else
                    return false;
            }
            function customerType(d) {
                (d == 'c') ? isCompany() : isPrivate();
                function isCompany() { $('#priv').addClass('company'); $('#<%=txtFirstname.ClientID%>').attr('data-required', 'FALSE'); $('#<%=txtAdvEmployees.ClientID%>').show(); $('#<%=lblAdvEmployees.ClientID%>').show(); $('#<%=txtAdvSsnNo.ClientID%>').show(); $('#<%=lblAdvSsnNo.ClientID%>').show(); }
                function isPrivate() { $('#priv').removeClass('company'); $('#<%=txtFirstname.ClientID%>').attr('data-required', 'REQUIRED'); $('#<%=txtAdvEmployees.ClientID%>').hide(); $('#<%=lblAdvEmployees.ClientID%>').hide(); $('#<%=txtAdvSsnNo.ClientID%>').hide(); $('#<%=lblAdvSsnNo.ClientID%>').hide(); }
            }



            // Binds to elements
            $('#<%=chkPrivOrSub.ClientID%>').on('click', function (e) {
                setCustomerType();
            });
            $('#<%=chkSameAdd.ClientID%>').on('click', function (e) {
                if ($('#<%=chkSameAdd.ClientID%>').is(':checked')) {
                    $('#postalAddressArea').hide();
                }
                else {
                    $('#postalAddressArea').show();
                }
                setBillAdd();
            });


            $('#btnNewContact').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $("#modContact").modal('setting', {
                    autofocus: false,
                    onShow: function () {
                        $('#<%=txtContactType.ClientID%>').focus();
                    },
                    onDeny: function () {
                        if (debug) { console.log('modContact abort mod executed'); }
                        $('#<%=txtContactType.ClientID%>').val('');
                        $('#<%=drpContactType.ClientID%>').val($('#<%=drpContactType.ClientID%> option:first').val());
                        $('#<%=chkContactType.ClientID%>').prop('checked', false);
                    },
                    onApprove: function () {
                        if (debug) { console.log('modContact ok mod executed'); }
                        AddCustomerContact();
                        $('#<%=txtContactType.ClientID%>').val('');

                        $('#<%=chkContactType.ClientID%>').prop('checked', false);
                        if ($('#<%=drpContactType.ClientID%>').val() == "1") {

                            $('#<%=hdnMobile.ClientID%>').val($('#<%=txtContactType.ClientID%>').val());
                        }
                        if ($('#<%=drpContactType.ClientID%>').val() == "6") {

                            $('#<%=hdnMail.ClientID%>').val($('#<%=txtContactType.ClientID%>').val());
                        }
                        $('#<%=drpContactType.ClientID%>').val($('#<%=drpContactType.ClientID%> option:first').val());
                    }
                })
                    .modal('show')
            });

            $('#btnViewCustGroup').on('click', function () {

                $('#hideCustGroup').toggleClass('hidden');

            });

            $('#btnViewDetails').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('#hideDetails').toggleClass('hidden');
                $('#hideDetails').hasClass('hidden') ? $(this).find('i.icon').removeClass('up').addClass('down') : $(this).find('i.icon').removeClass('down').addClass('up');
            });

            function setTab(cTab) {
                var tabID = "";
                tabID = $(cTab).data('tab') || cTab; // Checks if click or function call
                var tab;
                (tabID == "") ? tab = cTab : tab = tabID;

                $('.tTab').addClass('hidden'); // Hides all tabs
                $('#tab' + tabID).removeClass('hidden'); // Shows target tab and sets active class
                $('.cTab').removeClass('tabActive'); // Removes the tabActive class for all 
                $("#btn" + tabID).addClass('tabActive'); // Sets tabActive to clicked or active tab
            }

            $('.cTab').on('click', function (e) {
                setTab($(this));
            });

            $('#btnCustHomepage').on('click', function () {
                var url = $('#txtCustHomepage:text').val();
                if (url.length == 0) return true;
                if (url.toLowerCase().indexOf("http:") < 0)
                    var nurl = "http://" + url;
                window.open(nurl);
            });

            function FetchCustomerDetails(custId) {
                if (custId === undefined) {
                    if (debug) {
                        console.log('No customerID defined, fetch cancelled');
                        $('#<%=ddlContactPerson.ClientID%>').empty().prop('disabled', true);

                    }
                }
                else {
                    loadContact(custId);
                    cpChange = '';
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/FetchCustomerDetails",
                        data: "{custId: '" + custId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {

                            $('#<%=txtCustomerId.ClientID%>').val(data.d[0].ID_CUSTOMER);
                            if (data.d[0].ID_CUSTOMER.length > 0) {
                                $('#<%=txtCustomerId.ClientID%>').prop('disabled', true);
                            }
                            $('#<%=txtBillAdd1.ClientID%>').val(data.d[0].CUST_BILL_ADD1);
                       <%--     $('#<%=txtBillAdd2.ClientID%>').val(data.d[0].CUST_BILL_ADD2);--%>
                            $('#<%=txtBillZip.ClientID%>').val(data.d[0].ID_CUST_BILL_ZIPCODE);
                            $('#<%=txtBillCity.ClientID%>').val(data.d[0].CUST_BILL_CITY);
                            $('#<%=txtPermAdd1.ClientID%>').val(data.d[0].CUST_PERM_ADD1);
                            $('#<%=txtPermAdd2.ClientID%>').val(data.d[0].CUST_PERM_ADD2);
                            $('#<%=txtPermZip.ClientID%>').val(data.d[0].ID_CUST_PERM_ZIPCODE);
                            $('#<%=txtPermCity.ClientID%>').val(data.d[0].CUST_PERM_CITY);

                            $('#<%=txtPermCounty.ClientID%>').val(data.d[0].CUST_COUNTY);

                            $('#<%=txtBillCounty.ClientID%>').val(data.d[0].CUST_COUNTY);
                            //alert(data.d[0].CUST_FLG);
                            $('#countryChooserDrop').dropdown('set selected', data.d[0].CUST_COUNTRY_FLG);
                            $('#<%=txtFirstname.ClientID%>').val(data.d[0].CUST_FIRST_NAME);
                            $('#<%=txtMiddlename.ClientID%>').val(data.d[0].CUST_MIDDLE_NAME);
                            $('#<%=txtLastname.ClientID%>').val(data.d[0].CUST_LAST_NAME);
                            $('#<%=txtNotes.ClientID%>').val(data.d[0].CUST_NOTES);
                            if ($('#<%=txtNotes.ClientID%>').val() != '') {

                                $('#exclamIcon').show();
                            }
                            else {

                                $('#exclamIcon').hide();
                            }
                            $('#<%=txtCompanyPerson.ClientID%>').val(data.d[0].CUST_COMPANY_NO);
                            $('#lblCompanyPersonName').html(data.d[0].CUST_COMPANY_DESCRIPTION);
                            if (data.d[0].CUST_COMPANY_NO.length > 0) {
                                loadCompanyList(data.d[0].CUST_COMPANY_NO);
                            }
                            else {
                                loadCompanyList(data.d[0].ID_CUSTOMER);
                            }
                            $('#<%=txtAdvSsnNo.ClientID%>').val(data.d[0].CUST_SSN_NO);
                            $('#<%=ddlCustGroup.ClientID()%>').val(data.d[0].ID_CUST_GROUP);
                            $('#<%=ddlPayTerms.ClientID()%>').val(data.d[0].ID_CUST_PAY_TERM);
                            $('#<%=ddlPayType.ClientID()%>').val(data.d[0].ID_CUST_PAY_TYPE);
                            $('#<%=txtAdvSparesDiscount.ClientID()%>').val(data.d[0].CUST_DISC_SPARES);
                            $('#<%=txtAdvLabourDiscount.ClientID()%>').val(data.d[0].CUST_DISC_LABOUR);
                            $('#<%=txtAdvGeneralDiscount.ClientID()%>').val(data.d[0].CUST_DISC_GENERAL);
                            $('#<%=txtBirthDate.ClientID()%>').val(data.d[0].CUST_BORN);
                            $('#<%=txtEniroId.ClientID()%>').val(data.d[0].ENIRO_ID);
                            $('#<%=txtWashDate.ClientID()%>').val(data.d[0].DT_CUST_WASH);
                            $('#<%=txtDeathDate.ClientID()%>').val(data.d[0].DT_CUST_DEATH);
                            

                            if (data.d[0].FLG_PRIVATE_COMP == 'True') {
                                $("#<%=chkPrivOrSub.ClientID%>").prop('checked', true);
                                $('#<%=txtCompanyPersonFind.ClientID()%>').attr("disabled", "disabled");
                                $('#<%=txtCompanyPerson.ClientID()%>').attr("disabled", "disabled");
                                $('#privateIcon').hide();
                                $('#businessIcon').show();



                            } else {
                                $("#<%=chkPrivOrSub.ClientID%>").prop('checked', false);
                                $('#<%=txtCompanyPersonFind.ClientID()%>').removeAttr("disabled", "disabled");
                                $('#<%=txtCompanyPerson.ClientID()%>').removeAttr("disabled", "disabled");

                                $('#businessIcon').hide();
                                $('#privateIcon').show();

                            }
                            if (data.d[0].ISSAMEADDRESS == 'True') {


                                $("#<%=chkSameAdd.ClientID%>").prop('checked', true);
                                $('#postalAddressArea').hide();
                            } else {
                                $("#<%=chkSameAdd.ClientID%>").prop('checked', false);
                                $('#postalAddressArea').show();

                            }
                            // GEN > DETAILS
                            if (data.d[0].FLG_EINVOICE == 'True') {
                                $("#<%=chkEinvoice.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkEinvoice.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_INV_EMAIL == 'True') {
                                $("#<%=chkInvEmail.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkInvEmail.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_ORDCONF_EMAIL == 'True') {
                                $("#<%=chkOrdconfEmail.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkOrdconfEmail.ClientID%>").prop('checked', false);
                            }
                           
                          
                            // ADVANCED TAB
                            if (data.d[0].FLG_NO_INVOICEFEE == 'True') {
                                $("#<%=chkAdvCustIgnoreInv.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustIgnoreInv.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_CUST_FACTORING == 'True') {
                                $("#<%=chkAdvCustFactoring.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustFactoring.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_CUST_BATCHINV == 'True') {
                                $("#<%=chkAdvCustBatchInv.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustBatchInv.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_NO_GM == 'True') {
                                $("#<%=chkAdvNoGm.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvNoGm.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_CUST_INACTIVE == 'True') {
                                $("#<%=chkAdvCustInactive.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvCustInactive.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_NO_ENV_FEE == 'True') {
                                $("#<%=chkAdvNoEnv.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvNoEnv.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_PROSPECT == 'True') {
                                $("#<%=chkProspect.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkProspect.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_BANKGIRO == 'True') {
                                $("#<%=chkAdvBankgiro.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvBankgiro.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_HOURLY_ADD == 'True') {
                                $("#<%=chkAdvHourlyMarkup.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkAdvHourlyMarkup.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_NO_ADDITIONAL_COST == 'True') {
                                $("#<%=chkNoAddCost.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkNoAddCost.ClientID%>").prop('checked', false);
                            }
                            if (data.d[0].FLG_NO_HISTORY_PUBLISH == 'True') {
                                $("#<%=chkNoHistoryPublish.ClientID%>").prop('checked', true);
                            } else {
                                $("#<%=chkNoHistoryPublish.ClientID%>").prop('checked', false);
                            }
                            $('#lblSalesmanTxt').html(data.d[0].CUST_SALESMAN);
                            $('#txtAdvBranchTxt').html(data.d[0].CUST_SALESMAN_JOB);
                            $('#txtAdvSalesgroupTxt').html(data.d[0].SALES_GROUP);
                            $('#txtAdvCardtypeTxt').html(data.d[0].PAYMENT_CARD_TYPE);
                            $('#txtAdvCurrcodeTxt').html(data.d[0].CURRENCY_CODE);
                            $('#<%=txtAdvDebitorgroup.ClientID%>').val(data.d[0].DEBITOR_GROUP);
                            $('#<%=txtAdvInvoicelevel.ClientID%>').val(data.d[0].INVOICE_LEVEL);
                            $('#<%=txtAdvHourlyPriceNo.ClientID%>').val(data.d[0].HOURLY_PRICE_NO);
                            $('#<%=txtAdvEmployees.ClientID%>').val(data.d[0].CUST_EMPLOYEE_NO);
                            $('#<%=txtInvCustAdd.ClientID%>').val(data.d[0].CUST_NO_INV_ADDRESS);
                            $('#<%=txtAdvCredlimit.ClientID%>').val(data.d[0].CUST_CREDIT_LIMIT);
                            $('#<%=txtAdvRemainingCredit.ClientID%>').val(data.d[0].CUST_UNUTIL_CREDIT);
                            if (data.d[0].CUST_PRICE_TYPE != "") {
                                $('#<%=cmbAdvPriceType.ClientID%>').val(data.d[0].CUST_PRICE_TYPE);
                            }
                            else {
                                $('#<%=cmbAdvPriceType.ClientID%>').val("2");
                            }
                            $('#<%=txtBilxtraGrossist.ClientID%>').val(data.d[0].BILXTRA_GROSS_NO);
                            $('#<%=txtBilxtraShopNo.ClientID%>').val(data.d[0].BILXTRA_WORKSHOP_NO);
                            $('#<%=txtBilxtraExternalNo.ClientID%>').val(data.d[0].BILXTRA_EXT_CUST_NO);
                            if (data.d[0].BILXTRA_WARRANTY_HANDLING == 'True') {
                                $("#<%=chkBilxtraWarranty.ClientID%>").prop('checked', true);
                            } else {
                                 $("#<%=chkBilxtraWarranty.ClientID%>").prop('checked', false);
                             }
                            $('#<%=txtBilxtraSupplier.ClientID%>').val(data.d[0].BILXTRA_WARRANTY_SUPPLIER_NO);

                            loadBranch();
                            setCustomerType();
                            fetchFLG = true;
                            if (debug) { console.log('Customer fetch flag: ' + fetchFLG) }
                            loadCustomerContactPerson('', data.d[0].ID_CUSTOMER)
                            $('#<%=ddlContactPerson.ClientID%>').val(data.d[0].ID_CP);
                            console.log('ID CP: ' + data.d[0].ID_CP);
                            clearSaveVar();
                            setSaveVar();
                            FetchGdprDetails(data.d[0].ID_CUSTOMER);
                            if (data.d[0].CUST_SALESMAN != "") {
                                customerSalesman(data.d[0].CUST_SALESMAN);
                            }
                            if (data.d[0].CUST_SALESMAN_JOB != "") {
                                customerBranch(data.d[0].CUST_SALESMAN_JOB);
                            }
                            if (data.d[0].SALES_GROUP != "") {
                                customerSalesGroup(data.d[0].SALES_GROUP);
                            }
                            if (data.d[0].PAYMENT_CARD_TYPE != "") {
                                customerCardType(data.d[0].PAYMENT_CARD_TYPE);
                            }
                            if (data.d[0].CURRENCY_CODE != "") {
                                customerCurrencyType(data.d[0].CURRENCY_CODE);
                            }
                           
                                FetchInvCustAdd(data.d[0].CUST_NO_INV_ADDRESS);
                            
                           
                          
                            $("#activities-table").tabulator("setData", "frmCustomerDetail.aspx/fetch_activities", { 'customer_id': $('#<%=txtCustomerId.ClientID%>').val() });
                        },
                        failure: function () {
                           swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
            };


            function FetchGdprDetails(custId) {
                    loadContact(custId);
                    cpChange = '';
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/FetchGdprDetails",
                        data: "{custId: '" + custId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d.length === 0) {
                                //IF NO DATA IN GDPR TABLE, WIPE OUT EVERYTHING FROM EARLIER CUSTOMER
                                $("#<%=chkManualSms.ClientID%>").prop('checked', false);
                                $("#<%=chkManualMail.ClientID%>").prop('checked', false);
                                $("#<%=chkPkkSms.ClientID%>").prop('checked', false);
                                $("#<%=chkPkkMail.ClientID%>").prop('checked', false);
                                $("#<%=chkServiceSms.ClientID%>").prop('checked', false);
                                $("#<%=chkServiceMail.ClientID%>").prop('checked', false);
                                $("#<%=chkBargainSms.ClientID%>").prop('checked', false);
                                $("#<%=chkBargainMail.ClientID%>").prop('checked', false);
                                $("#<%=chkXtracheckSms.ClientID%>").prop('checked', false);
                                $("#<%=chkXtracheckMail.ClientID%>").prop('checked', false);
                                $("#<%=chkReminderSms.ClientID%>").prop('checked', false);
                                $("#<%=chkReminderMail.ClientID%>").prop('checked', false);
                                $("#<%=chkInfoSms.ClientID%>").prop('checked', false);
                                $("#<%=chkInfoMail.ClientID%>").prop('checked', false);
                                $("#<%=chkFollowupSms.ClientID%>").prop('checked', false);
                                $("#<%=chkFollowupMail.ClientID%>").prop('checked', false);
                                $("#<%=chkMarketingSms.ClientID%>").prop('checked', false);
                                $("#<%=chkMarketingMail.ClientID%>").prop('checked', false);
                                $('#<%=txtGdprResponseDate.ClientID%>').val("");
                                $('#<%=txtGdprResponseId.ClientID%>').val("");

                            }
                            else {
                                // GDPR CHECKBOX DETAILS
                                if (data.d[0].MANUAL_SMS == 'True') {
                                    $("#<%=chkManualSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkManualSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].MANUAL_MAIL == 'True') {
                                    $("#<%=chkManualMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkManualMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].PKK_SMS == 'True') {
                                    $("#<%=chkPkkSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkPkkSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].PKK_MAIL == 'True') {
                                    $("#<%=chkPkkMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkPkkMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].SERVICE_SMS == 'True') {
                                    $("#<%=chkServiceSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkServiceSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].SERVICE_MAIL == 'True') {
                                    $("#<%=chkServiceMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkServiceMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].BARGAIN_SMS == 'True') {
                                    $("#<%=chkBargainSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkBargainSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].BARGAIN_MAIL == 'True') {
                                    $("#<%=chkBargainMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkBargainMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].XTRACHECK_SMS == 'True') {
                                    $("#<%=chkXtracheckSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkXtracheckSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].XTRACHECK_MAIL == 'True') {
                                    $("#<%=chkXtracheckMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkXtracheckMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].REMINDER_SMS == 'True') {
                                    $("#<%=chkReminderSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkReminderSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].REMINDER_MAIL == 'True') {
                                    $("#<%=chkReminderMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkReminderMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].INFO_SMS == 'True') {
                                    $("#<%=chkInfoSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkInfoSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].INFO_MAIL == 'True') {
                                    $("#<%=chkInfoMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkInfoMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].FOLLOWUP_SMS == 'True') {
                                    $("#<%=chkFollowupSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkFollowupSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].FOLLOWUP_MAIL == 'True') {
                                    $("#<%=chkFollowupMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkFollowupMail.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].MARKETING_SMS == 'True') {
                                    $("#<%=chkMarketingSms.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkMarketingSms.ClientID%>").prop('checked', false);
                                }
                                if (data.d[0].MARKETING_MAIL == 'True') {
                                    $("#<%=chkMarketingMail.ClientID%>").prop('checked', true);
                                } else {
                                    $("#<%=chkMarketingMail.ClientID%>").prop('checked', false);
                                }
                                $('#<%=txtGdprResponseDate.ClientID%>').val(data.d[0].DT_RESPONSE);
                                $('#<%=txtResponseDate.ClientID%>').val(data.d[0].DT_RESPONSE);
                                $('#<%=txtGdprResponseId.ClientID%>').val(data.d[0].RESPONSE_ID);
                            }
                        },
                        failure: function () {
                           swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                
            };

        /*------------------ Fetching invoice customers address and viewing it next to customer no in modal*/
            function FetchInvCustAdd(custId) {
                if (custId == '') {
                    $('#<%=lblInvAddCustPostAdd.ClientID%>').html('');
                       <%--     $('#<%=txtBillAdd2.ClientID%>').val(data.d[0].CUST_BILL_ADD2);--%>
                    $('#<%=lblInvAddCustPostZipPlace.ClientID%>').html('');
                    $('#<%=lblInvAddCustVisit.ClientID%>').html('');
                    $('#<%=lblInvAddCustZipPlace.ClientID%>').html('');     
                    $('#<%=lblInvAddCustName.ClientID%>').html('');
                }
                else {
                    cpChange = '';
                    $.ajax({
                        type: "POST",
                        url: "frmCustomerDetail.aspx/FetchCustomerDetails",
                        data: "{custId: '" + custId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            
                            


                            $('#<%=txtInvCustAdd.ClientID%>').val(data.d[0].ID_CUSTOMER);
                           
                            $('#<%=lblInvAddCustPostAdd.ClientID%>').html(data.d[0].CUST_BILL_ADD1);
                       <%--     $('#<%=txtBillAdd2.ClientID%>').val(data.d[0].CUST_BILL_ADD2);--%>
                            $('#<%=lblInvAddCustPostZipPlace.ClientID%>').html(data.d[0].ID_CUST_BILL_ZIPCODE + " " + data.d[0].CUST_BILL_CITY);
                           
                            $('#<%=lblInvAddCustVisit.ClientID%>').html(data.d[0].CUST_PERM_ADD1);
                            $('#<%=lblInvAddCustZipPlace.ClientID%>').html(data.d[0].ID_CUST_PERM_ZIPCODE + " " + data.d[0].CUST_PERM_CITY);
                            if (data.d[0].CUST_FIRST_NAME == "" && data.d[0].CUST_MIDDLE_NAME == "") {
                                $('#<%=lblInvAddCustName.ClientID%>').html(data.d[0].CUST_LAST_NAME);
                            }
                            else {
                                if (data.d[0].CUST_MIDDLE_NAME == "") {
                                    $('#<%=lblInvAddCustName.ClientID%>').html(data.d[0].CUST_FIRST_NAME + " " + data.d[0].CUST_LAST_NAME);
                                }
                                else {
                                    $('#<%=lblInvAddCustName.ClientID%>').html(data.d[0].CUST_FIRST_NAME + " " + data.d[0].CUST_MIDDLE_NAME + " " + data.d[0].CUST_LAST_NAME);
                                }
                            }
                            
                           
                        },
                        failure: function () {
                            swal('<%=GetLocalResourceObject("FailedError")%>');
                        }
                    });
                }
            };

            $.datepicker.setDefaults($.datepicker.regional["no"]);


            //autocomplete for cusatomer search in local DB
            $('#txtCustId').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Transactions/frmWoSearch.aspx/Customer_Search",
                        data: "{q:'" + $('#txtCustId').val() + "', 'isPrivate': '" + true + "', 'isCompany': '" + true + "'}",
                        dataType: "json",
                        success: function (data) {

                            console.log($('#txtCustId').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label: '<%=GetLocalResourceObject("CustSearchNoRec")%>' , value: $('#txtCustId').val(), val: 'new' }]); //'Ingen treff i lokalt kunderegister. Hente fra eniro?'
                            } else
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME + " - " + item.CUST_PERM_ADD1 + " - " + item.ID_CUST_PERM_ZIPCODE + " " + item.CUST_PERM_CITY,
                                        val: item.ID_CUSTOMER,
                                        value: item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                            var err = eval("(" + xhr.responseText + ")");
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    //alert(i.item.val);
                    cpChange = '';
                    if (i.item.val != 'new') {
                        $('#aspnetForm')[0].reset();
                        $('#customerContactPH').html('');
                        FetchCustomerDetails(i.item.val);
                        $(this).val('');
                        $('#lblName').text(i.item.value)
                        $("#carList-table").tabulator("setData", "../Transactions/frmWOSearch.aspx/Vehicle_Search", { 'q': $('#<%=txtCustomerId.ClientID%>').val() });

                        return false;
                    }
                    else {
                        $('#modNewCust').modal('show');

                        FetchEniro($('#txtCustId').val());
                    }
                }
            });

            //autocomplete for cusatomer search in local DB
            $('#<%=txtInvCustAdd.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Transactions/frmWoSearch.aspx/Customer_Search",
                        data: "{q:'" + $('#<%=txtInvCustAdd.ClientID%>').val() + "', 'isPrivate': '" + true + "', 'isCompany': '" + true + "'}",
                        dataType: "json",
                        success: function (data) {

                            console.log($('#txtCustId').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label:'<%=GetLocalResourceObject("CustSearchNoRec")%>' , value: $('#txtCustId').val(), val: 'new' }]); //'Ingen treff i lokalt kunderegister. Hente fra eniro?'
                            } else
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME + " - " + item.CUST_PERM_ADD1 + " - " + item.ID_CUST_PERM_ZIPCODE + " " + item.CUST_PERM_CITY,
                                        val: item.ID_CUSTOMER,
                                        value: item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                            var err = eval("(" + xhr.responseText + ")");
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    //alert(i.item.val);
                    cpChange = '';
                    if (i.item.val != 'new') {
                        FetchInvCustAdd(i.item.val);

                        return false;
                    }
                    else {
                        $('#modNewCust').modal('show');

                        FetchEniro($('#txtCustId').val());
                    }
                }
            });

            $('#<%=txtBilxtraSupplier.ClientID%>').autocomplete({


                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../SS3/SupplierDetail.aspx/Supplier_Search",
                        data: "{q:'" + $('#<%=txtBilxtraSupplier.ClientID%>').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                           
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label:'<%=GetLocalResourceObject("SuppSearchNoRec")%>' , value: " ", val: 'new' }]); //'Ingen treff i lokalt lager'

                            } else
                                response($.map(data.d, function (item) {

                                    return {
                                        label: item.SUPP_CURRENTNO + " - " + item.SUP_Name + " - " + item.SUP_CITY + " - " + item.ID_SUPPLIER,
                                        val: item.SUPP_CURRENTNO,
                                        name: item.SUP_Name,
                                        value: item.ITEM_DESC

                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                            var err = eval("(" + xhr.responseText + ")");
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    e.preventDefault();
                    if (i.item.val != 'new') {
                        FetchSupplierDetails(i.item.val);   
                    }
                    else {
                        swal('<%=GetLocalResourceObject("SuppSearchErr")%>');//"Henting av leverandør feilet!"
                    }

                }
            });

            function FetchSupplierDetails(ID_SUPPLIER) {
                cpChange = '';
                $.ajax({
                    type: "POST",
                    url: "../SS3/SupplierDetail.aspx/FetchSupplierDetail",
                    data: "{ID_SUPPLIER: '" + ID_SUPPLIER + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        console.log(data.d[0]);
                        $('#<%=txtBilxtraSupplier.ClientID%>').val(data.d[0].SUPP_CURRENTNO);
                        $('#<%=lblBilxtraSupplierName.ClientID%>').html(data.d[0].SUP_Name);
                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });

            };

            //Autocomplete for zip code field
            $('#<%=txtPermZip.ClientID%>').autocomplete({
                autoFocus: true,
                selectFirst: true,
                source: function (request, callback) {
                    el = this.element;
                    zipSearch($(el).val(), callback)
                },
                select: function (e, i) {
                    $("#<%=txtPermZip.ClientID%>").val(i.item.val);
                        $("#<%=txtPermCity.ClientID%>").val(i.item.city);

                        $("#<%=txtPermCounty.ClientID%>").val(i.item.state);
                },
            });
            $('#<%=txtBillZip.ClientID%>').autocomplete({
                autoFocus: true,
                selectFirst: true,
                source: function (request, callback) {
                    el = this.element;
                    zipSearch($(el).val(), callback)
                },
                select: function (e, i) {
                    $("#<%=txtBillZip.ClientID%>").val(i.item.val);
                    $("#<%=txtBillCity.ClientID%>").val(i.item.city);

                    $("#<%=txtBillCounty.ClientID%>").val(i.item.state);
                },
            });

            //autocomplete for company person to add a company for the chosen customer
            $('#<%=txtCompanyPersonFind.ClientID%>').autocomplete({
                selectFirst: true,
                autoFocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Transactions/frmWoSearch.aspx/Customer_Search",

                        data: "{q:'" + $('#<%=txtCompanyPersonFind.ClientID%>').val() + "', 'isPrivate': '" + false + "', 'isCompany': '" + true + "'}",
                        dataType: "json",
                        success: function (data) {

                            console.log($('#<%=txtCompanyPersonFind.ClientID%>').val());
                            if (data.d.length === 0) { // If no hits in local search, prompt create new, sends user to new vehicle if enter is pressed.
                                response([{ label:'<%=GetLocalResourceObject("CompCustSearchNoRec")%>' }]); //'Kan ikke finne kunde med det oppgitte søkekriteriet' 
                            } else
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.ID_CUSTOMER + " - " + item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME + " - " + item.CUST_PHONE_MOBILE,
                                        val: item.ID_CUSTOMER,
                                        value: item.CUST_FIRST_NAME + " " + item.CUST_MIDDLE_NAME + " " + item.CUST_LAST_NAME
                                    }
                                }))
                        },
                        error: function (xhr, status, error) {
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                            var err = eval("(" + xhr.responseText + ")");
                            swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                        }
                    });
                },
                select: function (e, i) {
                    //alert(i.item.val);
                    $('#<%=txtCompanyPerson.ClientID%>').val(i.item.val)
                    $('#lblCompanyPersonName').html(i.item.value)
                    loadCompanyList($('#<%=txtCompanyPerson.ClientID%>').val());
                }
            });

            $('#<%=txtCompanyPerson.ClientID%>').on('blur', function () {
                if ($('#<%=txtCompanyPerson.ClientID%>').val() == '') {
                    $('#lblCompanyPersonName').html('Ingen tilknytning.');
                    loadCompanyList($('#<%=txtCompanyPerson.ClientID%>').val());
                }
                else {
                    loadCompanyList($('#<%=txtCompanyPerson.ClientID%>').val());
                }

            });

            //Fetch company list function for drop down list
            function loadCompanyList(q) {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/Company_List",
                    data: "{q:'" + q + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (Result) {
                        $('#<%=ddlCompanyList.ClientID%>').empty();
                        Result = Result.d;

                        $.each(Result, function (key, value) {
                            $('#<%=ddlCompanyList.ClientID%>').append($("<option></option>").val(value.ID_CUSTOMER).html(value.ID_CUSTOMER + " - " + value.CUST_FIRST_NAME + " " + value.CUST_MIDDLE_NAME + " " + value.CUST_LAST_NAME));

                        });

                    },
                    failure: function () {
                        swal('<%=GetLocalResourceObject("FailedError")%>');
                    }
                });
            }

            $(function () {
                $('#<%=txtAdvSalesman.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "frmCustomerDetail.aspx/LoadSalesman",
                            data: '{}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d.length === 0) { // If no hits
                                    response([{ label: '<%=GetLocalResourceObject("SalesmanSearchNoRec")%>', value: '0', val: 'new' }]); //'Ingen treff i. Trykk enter for å opprette ny selger.'
                                } else
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.USER_LOGIN + " - " + item.USER_FIRST_NAME + " " + item.USER_LAST_NAME,
                                            val: item.USER_LOGIN,
                                            value: item.USER_LOGIN,
                                            lbluse: item.USER_FIRST_NAME + " " + item.USER_LAST_NAME
                                        }
                                    }))
                            },
                            error: function (xhr, status, error) {
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                                var err = eval("(" + xhr.responseText + ")");
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                            }
                        });

                    },
                    minLength: 0,
                    select: function (e, i) { e.preventDefault(); $('#lblSalesmanTxt').text(i.item.val); $('#<%=txtAdvSalesman.ClientID%>').val(i.item.lbluse); $('#<%=txtAdvSalesman.ClientID%>').blur() }
                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();

                });
            });

            $(function () {
                $('#<%=txtAdvBranch.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "frmCustomerDetail.aspx/LoadBranch",
                            data: '{}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d.length === 0) { // If no hits
                                    response([{ label:'<%=GetLocalResourceObject("BranchSearchNoRec")%>' , value: '0', val: 'new' }]); //'Ingen treff i. Trykk enter for å opprette ny selger.'
                                } else
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.BRANCH_CODE + " - " + item.BRANCH_TEXT,
                                            val: item.BRANCH_CODE,
                                            value: item.BRANCH_CODE,
                                            lbluse: item.BRANCH_TEXT
                                        }
                                    }))
                            },
                            error: function (xhr, status, error) {
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                                var err = eval("(" + xhr.responseText + ")");
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                            }
                        });
                    },
                    minLength: 0,
                    select: function (e, i) { e.preventDefault(); $('#txtAdvBranchTxt').text(i.item.val); $('#<%=txtAdvBranch.ClientID%>').val(i.item.lbluse); $('#<%=txtAdvBranch.ClientID%>').blur() }
                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                });
            });

            $(function () {
                $('#<%=txtAdvCategory.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "frmCustomerDetail.aspx/LoadCategory",
                            data: '{}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d.length === 0) { // If no hits
                                    response([{ label: '<%=GetLocalResourceObject("CategorySearchNoRec")%>', value: '0', val: 'new' }]);
                                } else
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.CATEGORY_CODE + " - " + item.CATEGORY_TEXT,
                                            val: item.CATEGORY_CODE,
                                            value: item.CATEGORY_CODE + " - " + item.CATEGORY_TEXT
                                        }
                                    }))
                            },
                            error: function (xhr, status, error) {
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                                var err = eval("(" + xhr.responseText + ")");
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                            }
                        });
                    },
                    minLength: 0,
                    select: function (e, i) { e.preventDefault(); $('#txtAdvBranchTxt').text(i.item.val); $('#<%=txtAdvBranch.ClientID%>').val(i.item.lbluse); $('#<%=txtAdvBranch.ClientID%>').blur() }
                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                });
            });

            $(function () {
                $('#<%=txtAdvSalesgroup.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "frmCustomerDetail.aspx/LoadSalesGroup",
                            data: '{}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d.length === 0) { // If no hits
                                    response([{ label: '<%=GetLocalResourceObject("SalesgrpSearchNoRec")%>', value: '0', val: 'new' }]);
                                } else
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.SALESGROUP_CODE + " - " + item.SALESGROUP_TEXT,
                                            val: item.SALESGROUP_CODE,
                                            value: item.SALESGROUP_CODE,
                                            lbluse: item.SALESGROUP_TEXT
                                        }
                                    }))
                            },
                            error: function (xhr, status, error) {
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                                var err = eval("(" + xhr.responseText + ")");
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                            }
                        });
                    },
                    minLength: 0,
                    select: function (e, i) { e.preventDefault(); $('#txtAdvSalesgroupTxt').text(i.item.val); $('#<%=txtAdvSalesgroup.ClientID%>').val(i.item.lbluse); $('#<%=txtAdvSalesgroup.ClientID%>').blur() }
                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                });
            });

            $(function () {
                $('#<%=txtAdvPayterms.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "frmCustomerDetail.aspx/LoadPaymentTerms",
                            data: '{}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d.length === 0) { // If no hits
                                    response([{ label: '<%=GetLocalResourceObject("PaymentTermsSearchNoRec")%>', value: '0', val: 'new' }]);
                                } else
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.PAYMENT_TERMS_CODE + " - " + item.PAYMENT_TERMS_TEXT,
                                            val: item.PAYMENT_TERMS_CODE,
                                            value: item.PAYMENT_TERMS_CODE + " - " + item.PAYMENT_TERMS_TEXT,
                                            lbluse: item.PAYMENT_TERMS_TEXT
                                        }
                                    }))
                            },
                            error: function (xhr, status, error) {
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                                var err = eval("(" + xhr.responseText + ")");
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                            }
                        });
                    },
                    minLength: 0,
                    select: function (e, i) { e.preventDefault(); $('#txtAdvPaytermsTxt').text(i.item.val); $('#<%=txtAdvPayterms.ClientID%>').val(i.item.lbluse); $('#<%=txtAdvPayterms.ClientID%>').blur() }
                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                });
            });

            $(function () {
                $('#<%=txtAdvCardtype.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "frmCustomerDetail.aspx/LoadCardType",
                            data: '{}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d.length === 0) { // If no hits
                                    response([{ label: '<%=GetLocalResourceObject("CardTypeSearchNoRec")%>', value: '0', val: 'new' }]);
                                } else
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.CARD_TYPE_CODE + " - " + item.CARD_TYPE_TEXT,
                                            val: item.CARD_TYPE_CODE,
                                            value: item.CARD_TYPE_CODE,
                                            description: item.CARD_TYPE_TEXT
                                        }
                                    }))
                            },
                            error: function (xhr, status, error) {
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                                var err = eval("(" + xhr.responseText + ")");
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + err.Message);
                            }
                        });
                    },
                    minLength: 0,
                    select: function (e, i) { e.preventDefault(); $('#txtAdvCardtypeTxt').text(i.item.val); $('#<%=txtAdvCardtype.ClientID%>').val(i.item.description); $('#<%=txtAdvCardtype.ClientID%>').blur() }
                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                });
            });

            $(function () {
                $('#<%=txtAdvCurrcode.ClientID%>').autocomplete({
                    selectFirst: true,
                    autoFocus: true,
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "frmCustomerDetail.aspx/LoadCurrencyType",
                            data: '{}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d.length === 0) { // If no hits
                                    response([{ label: '<%=GetLocalResourceObject("CurrencySearchNoRec")%>', value: '0', val: 'new' }]);
                                } else
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.CURRENCY_TYPE_CODE + " - " + item.CURRENCY_TYPE_TEXT,
                                            val: item.CURRENCY_TYPE_CODE,
                                            value: item.CURRENCY_TYPE_CODE,
                                            lbluse: item.CURRENCY_TYPE_TEXT
                                        }
                                    }))
                            },
                            error: function (xhr, status, error) {
                                swal('<%=GetLocalResourceObject("ErrorAlert")%>' +": " + error);
                                var err = eval("(" + xhr.responseText + ")");
                                swal('Error: ' + err.Message);
                            }
                        });
                    },
                    minLength: 0,
                    select: function (e, i) { e.preventDefault(); $('#txtAdvCurrcodeTxt').text(i.item.val); $('#<%=txtAdvCurrcode.ClientID%>').val(i.item.lbluse); $('#<%=txtAdvCurrcode.ClientID%>').blur() }
                }).focus(function () {
                    //Use the below line instead of triggering keydown
                    $(this).autocomplete("search", "").select();
                });
            });



            $('#btnVehicle').on('click', function () {

                $("#carList-table").tabulator("setData", "../Transactions/frmWOSearch.aspx/Vehicle_Search", { 'q': $('#<%=txtCustomerId.ClientID%>').val() });
            });





            //Fetch vehicle list function for drop down list




            $('#ID_CUSTOMER_WRAPPER').on('click', function () {
                if ($('#<%=txtCustomerId.ClientID%>').prop('disabled') && $('#<%=txtCustomerId.ClientID%>').val().length == 0) {
                    console.log('read only true');
                    $('#modCustomerLock').modal('setting', {
                        onDeny: function () {
                        },
                        onApprove: function () {
                            $('#<%=txtCustomerId.ClientID%>').removeAttr('disabled').removeAttr('readonly').focus();
                            console.log('Enabled the #ID_CUSTOMER field');
                        },
                        onShow: function () {
                            $(this).children('ui.button.ok.positive').focus();
                        }
                    }).modal('show');
                }
            });

            $('#<%=txtCustomerId.ClientID%>').on('blur', function () {
                $.ajax({
                    type: "POST",
                    url: "frmCustomerDetail.aspx/FetchCustomerDetails",
                    data: "{custId: '" + $('#<%=txtCustomerId.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d[0] == null) {
                            console.log('OK');
                        } else {
                            console.log('Error');
                            genIns = data.d[0].CUST_FIRST_NAME + ' ' + data.d[0].CUST_MIDDLE_NAME + ' ' + data.d[0].CUST_LAST_NAME;
                           // $('#mceMSG').html('Kundenummer er allerede i bruk på kunde ' + data.d[0].CUST_FIRST_NAME + ' ' + data.d[0].CUST_MIDDLE_NAME + ' ' + data.d[0].CUST_LAST_NAME + ', vil du åpne kunden for redigering eller vil du prøve et annet nummer?')
                            $('#mceMSG').html('<%=GetLocalResourceObject("CustAExists")%>');
                            $('#modCustomerExists').modal({
                                onDeny: function () {
                                    $('#<%=txtCustomerId.ClientID%>').val('');
                                    $('#<%=txtCustomerId.ClientID%>').focus();
                                },
                                onApprove: function () {
                                    FetchCustomerDetails($('#<%=txtCustomerId.ClientID%>').val());
                                }
                            }).modal('show');
                        }
                    }
                });
            });

            var tabledata = [
                { ID_ITEM: "Tilbud", ITEM_DESC: "Oli Bob", INDELIVERY: "Tilbud", ITEM_AVAIL_QTY: "22-2-2090", ORDERQTY: "", REST_FLG: "" },
                { ID_ITEM: "Prøvekjøring", ITEM_DESC: "Mary May", INDELIVERY: "Prøve", ITEM_AVAIL_QTY: "11-2-2211", ORDERQTY: "", REST_FLG: "" },

            ];

            $("#activities-table").tabulator({
                height: 300, // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                layout: "fitColumns", //fit columns to width of table (optional)                  
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string


                columns: [ //Define Table Columns
                    { title: '<%=GetLocalResourceObject("tabulatorActSubject")%>', field: "ACTIVITY_NAME", align: "center" },
                    { title: '<%=GetLocalResourceObject("tabulatorActContact")%>', field: "ITEM_DESC", align: "center", },
                    { title: '<%=GetLocalResourceObject("tabulatorActType")%>', field: "ACTIVITY_TYPE", align: "center" },
                    { title: '<%=GetLocalResourceObject("tabulatorActDato")%>', field: "ACTIVITY_DATE", align: "center" },
                    { title: '<%=GetLocalResourceObject("tabulatorActSign")%>', field: "ACTIVITY_SIGN", align: "center" },
                ],

                ajaxResponse: function (url, params, response) {


                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //Return the d Property Of a response json Object
                },


            });

            $("#carList-table").tabulator({
                height: 300, // set height of table, this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                layout: "fitColumns", //fit columns to width of table (optional)                  
                ajaxConfig: "POST", //ajax HTTP request type
                ajaxContentType: "json", // send parameters to the server as a JSON encoded string


                columns: [ //Define Table Columns
                    { title: '<%=GetLocalResourceObject("tabulatorCarRefNr")%>', field: "IntNo", width: 150, align: "center" },
                    { title: '<%=GetLocalResourceObject("tabulatorCarRegnr")%>', field: "VehRegNo", align: "center", },
                    { title: '<%=GetLocalResourceObject("tabulatorCarMake")%>', field: "Make", align: "center" },
                    { title: '<%=GetLocalResourceObject("tabulatorCarType")%>', field: "VehType", align: "center" },
                    { title: '<%=GetLocalResourceObject("tabulatorCarChassis")%>', field: "VehVin", align: "center" },
                ],

                ajaxResponse: function (url, params, response) {

                    //url - the URL of the request
                    //params - the parameters passed with the request
                    //response - the JSON object returned in the body of the response.

                    return response.d; //Return the d Property Of a response json Object
                },
            });


            window.onbeforeunload = confirmExit;
            function confirmExit() {
                if (checkSaveVar()) {

                } else {
                    return '<%=GetLocalResourceObject("GenSaveAlert")%>'; //"Det kan være ulagrede endringer på siden, er du sikker på at du vil lukke siden?";
                }
            }
            function setSaveVar() {
                custvar = collectGroupData('submit');
            }
            function checkSaveVar() {
                contvar = collectGroupData('submit');
                //if (JSON.stringify(custvar) === JSON.stringify(contvar)) {
                if (objectEquals(custvar, contvar)) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function clearSaveVar() {
                custvar = {};
            }
            
        });
  
    </script>
    <asp:HiddenField ID="hdnSave" runat="server" />
    <asp:HiddenField ID="hdnSelect" runat="server" />
    <asp:HiddenField ID="hdnMobile" runat="server" />
    <asp:HiddenField ID="hdnMail" runat="server" />
    <div class="overlayHide"></div>
    <div id="konkurs" class="ui modal">
        <div class="header">
            <%=GetLocalResourceObject("divHeadWarng")%>
        </div>
        <div class="image content">
            <div class="image">
                <i class="warning icon"></i>
            </div>
            <div class="description">
                <p>Firmaet <span id="konkFirma"></span>er ærklert konkurs eller under tvangsavvikling. Se mer informasjon i <a href="https://www.brreg.no/" id="konkLink" title="Brønnøysundregistrene" target="_blank">Brønnøysundregistrene</a>.</p>
            </div>
        </div>
        <div class="actions">
            <div class="ui button ok">Ok</div>
        </div>
    </div>
    <%-- Modal for Eniro search pop up --%>
    <div id="modCustomerLock" class="ui modal">
        <div class="header">
            <asp:Literal runat="server" ID="CustomerLockHead" meta:resourcekey="CustomerLockHeadResource1" Text="Advarsel!"></asp:Literal>
        </div>
        <div class="image content">
            <div class="image">
                <i class="warning icon"></i>
            </div>
            <div class="description">
                <p>
                    <asp:Label runat="server" ID="CustomerLock1" meta:resourcekey="CustomerLock1Resource1" Text="Kundefeltet er låst for manuell inntasting. Kundenummer blir automatisk tildelt ved lagring av kunde."></asp:Label></p>
                <p>
                    <asp:Literal runat="server" ID="CustomerLock2" meta:resourcekey="CustomerLock2Resource1" Text="Ønsker du å søke opp kunde, trykk avbryt og bruk søkefeltet til høyre."></asp:Literal></p>
                <p>
                    <asp:Literal runat="server" ID="CustomerLock3" meta:resourcekey="CustomerLock3Resource1" Text="For å tildele manuelt kundenummer, velg &quot;lås opp&quot; for å låse opp feltet for inntasting."></asp:Literal></p>
            </div>
        </div>
        <div class="actions">
            <div class="ui button ok positive">
                <asp:Literal runat="server" ID="CustomerLockOK" meta:resourcekey="CustomerLockOKResource1" Text="Lås opp"></asp:Literal></div>
            <div class="ui button cancel negative">
                <asp:Literal runat="server" ID="CustomerLockCancel" meta:resourcekey="CustomerLockCancelResource1" Text="Avbryt"></asp:Literal></div>
        </div>
    </div>
    <%-- Modal for adding customer contact person --%>
    <div id="modContactPerson" class="ui modal coupled">
        <i class="close icon"></i>
        <div class="header">
            <asp:Literal runat="server" ID="litCustCPHeader" Text="Kontaktperson" meta:resourcekey="litCustCPHeaderResource1"></asp:Literal>
        </div>
        <div class="content">
            <div class="ui grid form">
                <div class="six wide column">
                    <asp:TextBox ID="txtCPID" runat="server" data-cp-submit="ID_CP" CssClass="sr-only" meta:resourcekey="txtCPIDResource1"></asp:TextBox>
                    <label for="txtCPFirstName" id="lblCPFirstName">
                        <asp:Literal ID="litCPFirstName" runat="server" Text="First name" meta:resourcekey="litCPFirstNameResource1"></asp:Literal></label>
                    <asp:TextBox ID="txtCPFirstName" runat="server" data-cp-submit="CP_FIRST_NAME" data-required="REQUIRED" Text="CPFN" CssClass="carsInput" meta:resourcekey="txtCPFirstNameResource1"></asp:TextBox>
                </div>
                <div class="four wide column">
                    <label for="txtCPMiddleName" id="lblCPMiddleName">
                        <asp:Literal ID="litCPMiddleName" runat="server" Text="Middle name" meta:resourcekey="litCPMiddleNameResource1"></asp:Literal></label>
                    <asp:TextBox ID="txtCPMiddleName" runat="server" data-cp-submit="CP_MIDDLE_NAME" CssClass="carsInput" meta:resourcekey="txtCPMiddleNameResource1"></asp:TextBox>
                </div>
                <div class="six wide column">
                    <label for="txtCPLastName" id="lblCPLastName">
                        <asp:Literal ID="litCPLastName" runat="server" Text="Last name" meta:resourcekey="litCPLastNameResource1"></asp:Literal></label>
                    <asp:TextBox ID="txtCPLastname" runat="server" data-cp-submit="CP_LAST_NAME" data-required="REQUIRED" Text="CPLN" CssClass="carsInput" meta:resourcekey="txtCPLastnameResource1"></asp:TextBox>
                </div>
                <div class="ten wide column">
                    <label for="txtCPPostalAddress" id="lblCPPostalAddress">
                        <asp:Literal ID="litCPPostalAddress" runat="server" Text="Postal address" meta:resourcekey="litCPPostalAddressResource1"></asp:Literal></label>
                    <asp:TextBox ID="txtCPPostalAddress" runat="server" data-cp-submit="CP_PERM_ADD" CssClass="carsInput" meta:resourcekey="txtCPPostalAddressResource1"></asp:TextBox>
                    <label for="txtCPVisitAddress" id="lblCPVisitAddress">
                        <asp:Literal ID="litCPVisitAddress" runat="server" Text="Visit address" meta:resourcekey="litCPVisitAddressResource1"></asp:Literal></label>
                    <asp:TextBox ID="txtCPVisitAddress" runat="server" data-cp-submit="CP_VISIT_ADD" CssClass="carsInput" meta:resourcekey="txtCPVisitAddressResource1"></asp:TextBox>
                    <div class="fields">
                        <div class="four wide field">
                            <label for="txtCPZip" id="lblCPZip">
                                <asp:Literal ID="litCPZip" runat="server" Text="Zip code" meta:resourcekey="litCPZipResource1"></asp:Literal></label>
                            <asp:TextBox ID="txtCPZip" CssClass="carsInput" runat="server" data-cp-submit="CP_ZIP_CODE" meta:resourcekey="txtCPZipResource1"></asp:TextBox>
                        </div>
                        <div class="twelve wide field">
                            <label for="txtCPZipCity" id="lblCPZipCity">
                                <asp:Literal ID="litCPZipCity" runat="server" Text="Zip city" meta:resourcekey="litCPZipCityResource1"></asp:Literal></label>
                            <asp:TextBox ID="txtCPZipCity" runat="server" data-cp-submit="CP_ZIP_CITY" CssClass="carsInput" meta:resourcekey="txtCPZipCityResource1"></asp:TextBox>
                        </div>
                    </div>
                    <label for="txtCPEmail" id="lblCPEmail">
                        <asp:Literal ID="litCPEmail" runat="server" Text="E-mail" meta:resourcekey="litCPEmailResource1"></asp:Literal></label>
                    <asp:TextBox ID="txtCPEmail" runat="server" data-cp-submit="CP_EMAIL" CssClass="carsInput" meta:resourcekey="txtCPEmailResource1"></asp:TextBox>
                    <div class="fields">
                        <div class="four wide field">
                            <label for="txtCPTitleCode" id="lblCPTitleCode">
                                <asp:Literal ID="litCPTitleCOde" runat="server" Text="Title" meta:resourcekey="litCPTitleCOdeResource1"></asp:Literal></label>
                            <asp:TextBox ID="txtCPTitleCode" runat="server" data-cp-submit="CP_TITLE_CODE" CssClass="carsInput" meta:resourcekey="txtCPTitleCodeResource1"></asp:TextBox>
                        </div>
                        <div class="twelve wide field">
                            <label>&nbsp;</label>
                            <asp:TextBox ID="txtCPTitle" runat="server" ReadOnly="True" Enabled="False" data-ccp-type="t" CssClass="carsInput disable-tab" meta:resourcekey="txtCPTitleResource1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="four wide field">
                            <label for="txtCPFunctionCode" id="lblCPFunctionCode">
                                <asp:Literal ID="litCPFunctionCode" runat="server" Text="Function" meta:resourcekey="litCPFunctionCodeResource1"></asp:Literal></label>
                            <asp:TextBox ID="txtCPFunctionCode" runat="server" data-cp-submit="CP_FUNCTION_CODE" CssClass="carsInput" meta:resourcekey="txtCPFunctionCodeResource1"></asp:TextBox>
                        </div>
                        <div class="twelve wide field">
                            <label>&nbsp;</label>
                            <asp:TextBox ID="txtCPFunction" runat="server" ReadOnly="True" Enabled="False" data-ccp-type="f" CssClass="carsInput disable-tab" meta:resourcekey="txtCPFunctionResource1"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="six wide column">
                    <h4 class="ui dividing header">Phone</h4>
                    <div class="inline field">
                        <label for="txtCPPhonePrivate" id="lblCPPhonePrivate">
                            <asp:Literal ID="litCPPhonePrivate" runat="server" Text="Private" meta:resourcekey="litCPPhonePrivateResource1"></asp:Literal></label>
                        <asp:TextBox ID="txtCPPhonePrivate" runat="server" data-cp-submit="CP_PHONE_PRIVATE" CssClass="carsInput" meta:resourcekey="txtCPPhonePrivateResource1"></asp:TextBox>
                    </div>
                    <div class="inline field">
                        <label for="txtCPPhoneMobile" id="lblCPPhoneMobile">
                            <asp:Literal ID="litCPPhoneMobile" runat="server" Text="Mobile" meta:resourcekey="litCPPhoneMobileResource1"></asp:Literal></label>
                        <asp:TextBox ID="txtCPPhoneMobile" runat="server" data-cp-submit="CP_PHONE_MOBILE" CssClass="carsInput" meta:resourcekey="txtCPPhoneMobileResource1"></asp:TextBox>
                    </div>
                    <div class="inline field">
                        <label for="txtCPPhoneFax" id="lblCPPhoneFax">
                            <asp:Literal ID="litCPPhoneFax" runat="server" Text="Fax" meta:resourcekey="litCPPhoneFaxResource1"></asp:Literal></label>
                        <asp:TextBox ID="txtCPPhoneFax" runat="server" data-cp-submit="CP_PHONE_FAX" CssClass="carsInput" meta:resourcekey="txtCPPhoneFaxResource1"></asp:TextBox>
                    </div>
                    <div class="inline field">
                        <label for="txtCPPhoneWork" id="lblCPPhoneWork">
                            <asp:Literal ID="litCPPhoneWork" runat="server" Text="Work" meta:resourcekey="litCPPhoneWorkResource1"></asp:Literal></label>
                        <asp:TextBox ID="txtCPPhoneWork" runat="server" data-cp-submit="CP_PHONE_WORK" CssClass="carsInput" meta:resourcekey="txtCPPhoneWorkResource1"></asp:TextBox>
                    </div>
                    <div class="ui fitted divider"></div>
                    <div class="inline field">
                        <label for="txtCPBirthday" id="lblCPBirthday">
                            <asp:Literal ID="litCPBirthday" runat="server" Text="Birthday" meta:resourcekey="litCPBirthdayResource1"></asp:Literal></label>
                        <asp:TextBox ID="txtCPBirthday" CssClass="carsInput" runat="server" data-cp-submit="CP_BIRTH_DATE" meta:resourcekey="txtCPBirthdayResource1"></asp:TextBox>
                        <i class="calendar icon"></i>
                    </div>
                </div>
                <div class="ten wide field">
                    <label for="txtCPNotes" id="lblCPNotes">
                        <asp:Literal ID="litCPNotes" runat="server" Text="Notes" meta:resourcekey="litCPNotesResource1"></asp:Literal></label>
                    <asp:TextBox ID="txtCPNotes" TextMode="MultiLine" runat="server" data-cp-submit="CP_NOTES" CssClass="carsInput" meta:resourcekey="txtCPNotesResource1"></asp:TextBox>
                </div>
                <div class="six wide field">
                    <div class="ui fitted divider"></div>
                    <div class="ui checkbox">
                        <asp:CheckBox ID="chkContactPerson" runat="server" Text="Contact person" data-cp-submit="CP_CONTACT" meta:resourcekey="chkContactPersonResource1" />
                    </div>
                    <div class="ui checkbox">
                        <asp:CheckBox ID="chkCarUser" runat="server" Text="Car user" data-cp-submit="CP_CAR_USER" meta:resourcekey="chkCarUserResource1" />
                    </div>
                    <div class="ui checkbox">
                        <asp:CheckBox ID="chkEmailReferance" runat="server" Text="E-mail as reference" data-cp-submit="CP_EMAIL_REF" meta:resourcekey="chkEmailReferanceResource1" />
                    </div>
                </div>
            </div>
        </div>
        <div class="actions">
            <div id="btnCPDelete" class="ui button">
                <asp:Literal runat="server" ID="litCustCPDelete" Text="Delete" meta:resourcekey="litCustCPDeleteResource1"></asp:Literal></div>
            <div class="ui button ok positive">
                <asp:Literal runat="server" ID="litCustCPSave" Text="Save" meta:resourcekey="litCustCPSaveResource1"></asp:Literal></div>
            <div class="ui button cancel negative">
                <asp:Literal runat="server" ID="litCustCPCancel" Text="Cancel" meta:resourcekey="litCustCPCancelResource1"></asp:Literal></div>
        </div>
    </div>
    <%-- Modal for sjekking av eksisterende kundenummer --%>
    <div id="modContactPersonConfirm" class="ui modal coupled small">
        <div class="header"><%=GetLocalResourceObject("divConfirm")%></div>
        <div class="content">
            You are adding a new <span id="custCPAddType">PH</span>:
            <br />
            Code: <strong><span id="custCPAddCode">PH</span></strong> Description: <strong><span id="custCPAddDescription">PH</span></strong>.
        </div>
        <div class="actions">
            <div class="ui button ok positive">
                <asp:Literal runat="server" ID="litCustCPAddSave" Text="Continue" meta:resourcekey="litCustCPAddSaveResource1"></asp:Literal></div>
            <div class="ui button cancel negative">
                <asp:Literal runat="server" ID="litCustCPAddCancel" Text="Cancel" meta:resourcekey="litCustCPAddCancelResource1"></asp:Literal></div>
        </div>
    </div>
    <%-- Modal for sjekking av eksisterende kundenummer --%>
    <div id="modCustomerExists" class="ui modal">
        <div class="header">
            Advarsel!
        </div>
        <div class="image content">
            <div class="image">
                <i class="warning icon"></i>
            </div>
            <div class="description">
                <p id="mceMSG"></p>
            </div>
        </div>
        <div class="actions">
            <div class="ui button ok"><%=GetLocalResourceObject("divCustLook")%></div><%--Se på kunde--%>
            <div class="ui button cancel"><%=GetLocalResourceObject("divTryNewNr")%></div><%--Prøv nytt nummer--%>
        </div>
    </div>
    <%-- Modal for Eniro search pop up --%>
    <div id="modNewCust" class="ui modal">
        <i class="close icon"></i>
        <div class="header">
            <%=GetLocalResourceObject("divFindCust")%>
        </div>
        <div class="modContent">

            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form ">

                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label8" runat="server"><%=GetLocalResourceObject("SearchCustPlaceHolder")%></label> <!--Søk etter kunde (Tlf, navn, sted, etc.)-->
                                <asp:TextBox ID="txtEniro" runat="server" meta:resourcekey="txtEniroResource1" CssClass="carsInput"></asp:TextBox>

                            </div>
                            <div class="eight wide field">
                                <button class="ui basic button" id="btnEniroFetch">
                                    <i class="search icon"></i>
                                    <%=GetLocalResourceObject("btnEnSearch")%>
                                </button>

                            </div>
                        </div>
                        <div class="fields">
                            <div class="wide field">
                                <label id="Label3" runat="server"><%=GetLocalResourceObject("CustSelect")%></label><%--Kunder--%>
                                <select id="CustSelect" runat="server" size="13" class="wide dropdownList">
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <!-- JAAAAAA -->






    <div class="ui one column grid">
        <div class="stretched row">
            <div class="sixteen wide column">
                <div class="ui stackable grid">
                    <!-- /# id_customer_wrapper column -->
                    <div class="four wide  column ">
                        <div class="container">
                            <input id="txtCustId" type="text" placeholder="<%=GetLocalResourceObject("SearchPlaceHolder")%>" /> <%--Søk tlf, navn, addresse--%>
                            <div class="search"></div>
                        </div>
                    </div>
                    <div class="six wide column ">
                        <i class="address card icon" id="privateIcon" style="font-size: 28px; display: none;"></i>
                        <i class="briefcase icon" id="businessIcon" style="font-size: 28px; display: none;"></i>
                        <label id="lblName" style="font-size: 22px; font-weight: 800;"></label>
                    </div>
                    <div class="four wide column ">
                        <div class=" fields">

                            <button class="ui basic button" type="button" id="btnSearchCustomer">
                                <i class="cloud download icon"></i>
                               <%=GetLocalResourceObject("btnSearchCust")%>
                            </button>

                            <button class="ui basic button" type="button" id="btnWashCustomer">
                                <i class="sync icon"></i>
                                <%=GetLocalResourceObject("btnSearchWash")%>
                            </button>

                        </div>
                    </div>
                </div>


                <div class="ui top attached tabular menu">
                    <a class="item active" data-tab="first"><%=GetLocalResourceObject("tabGeneral")%></a><%--Generelt--%>
                    <a class="item" data-tab="second"><%=GetLocalResourceObject("tabAdvanced")%></a><%--Avansert--%>
                    <a class="item " data-tab="third"><%=GetLocalResourceObject("tabActivities")%></a><%--Aktiviteter--%>
                    <a class="item " data-tab="fourth" id="btnVehicle"><%=GetLocalResourceObject("tabCars")%></a><%--Bil--%>
                    <a class="item " data-tab="fifth"><%=GetLocalResourceObject("tabCarWish")%></a><%--Bilønske--%>
                </div>


                <%--########################################## CUSTOMER ##########################################--%>
                <div class="ui bottom attached tab segment active" data-tab="first">
                    <div id="tabCustomer">
                        <div class="ui form stackable two column grid ">
                            <div class="eleven wide column">

                                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblVehDet" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrCustDetails")%></h3>
                                    
                                     <div style="margin-bottom: 0.8em !important;margin-top: -2.5em !important; display: block !important">
                                       <div class="fields">
                                        <div class="two wide field">

                                            <asp:Label ID="lblcustId" runat="server" Text="Kundenummer" meta:resourcekey="lHeadResource1"></asp:Label>
                                            <div id="ID_CUSTOMER_WRAPPER" class="four wide computer four wide tablet column">
                                                <asp:TextBox ID="txtCustomerId" runat="server" data-submit="ID_CUSTOMER" data-cp-submit="CP_CUSTOMER_ID" Enabled="False" CssClass="carsInput" meta:resourcekey="txtCustomerIdResource1"></asp:TextBox>
                                            </div>
                                        </div>
                                           </div>
                                    </div>
                                    <label class="inHeaderCheckbox">
                                        <asp:CheckBox ID="chkPrivOrSub" runat="server" Text="Company" data-submit="FLG_PRIVATE_COMP" meta:resourcekey="chkPrivOrSubResource1" />
                                        <asp:CheckBox ID="chkProspect" runat="server" Text="Prospect" data-submit="FLG_PROSPECT" meta:resourcekey="chkProspectResource1" />
                                    </label>


                                    <div class="ui divider"></div>

                                    <div class="fields" id="priv">
                                        <%--Customer info panel--%>

                                        <div class="">
                                            <asp:TextBox ID="txtEniroId" runat="server" data-submit="ENIRO_ID" meta:resourcekey="txtEniroIdResource1" CssClass="CarsBoxes hidden"></asp:TextBox>
                                        </div>
                                        <div class="four wide field" data-type="po">
                                            <asp:Label ID="lblFirstname" Text="First name" runat="server" meta:resourcekey="lblFirstnameResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtFirstname" runat="server" data-submit="CUST_FIRST_NAME" data-required="REQUIRED" meta:resourcekey="txtFirstnameResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>

                                        <div class="four wide field" data-type="po">
                                            <asp:Label ID="lblMiddlename" Text="Middle name" runat="server" meta:resourcekey="lblMiddlenameResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtMiddlename" runat="server" data-submit="CUST_MIDDLE_NAME" meta:resourcekey="txtMiddlenameResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">

                                            <asp:Label ID="lblLastname" Text="Last name" runat="server" data-type="po" meta:resourcekey="lblLastnameResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:Label ID="lblCompany" Text="Company" runat="server" data-type="co" meta:resourcekey="lblCompanyResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtLastname" runat="server" data-submit="CUST_LAST_NAME" data-required="REQUIRED" meta:resourcekey="txtLastnameResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>


                                        <div id="ddlContactPersonContainer" class="four wide field" data-type="co">
                                            <asp:Label ID="lblContactPerson" Text="Kontaktperson" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblContactPersonResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlContactPerson" CssClass="carsInput" runat="server" data-submit="ID_CP" meta:resourcekey="ddlContactPersonResource1"></asp:DropDownList>
                                        </div>


                                        <div data-type="co" class="four wide field">
                                            <asp:Label ID="lblContactPersonTitle" Text="Tittel" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblContactPersonTitleResource1"></asp:Label>
                                            <asp:TextBox ID="txtContactPersonTitle" runat="server" ReadOnly="True" CssClass="carsInput" meta:resourcekey="txtContactPersonTitleResource1"></asp:TextBox>
                                        </div>

                                    </div>



                                    <div class="fields">
                                        <div class="four wide field">
                                            <asp:Label ID="lblPermAdd" Text="Visit address" runat="server" meta:resourcekey="lblPermAddResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtPermAdd1" runat="server" data-submit="CUST_PERM_ADD1" data-required="REQUIRED" meta:resourcekey="txtPermAdd1Resource1" CssClass="carsInput"></asp:TextBox>
                                            <asp:TextBox ID="txtPermAdd2" runat="server" Visible="False" data-submit="CUST_PERM_ADD2" CssClass="mt3" meta:resourcekey="txtPermAdd2Resource1"></asp:TextBox>
                                        </div>


                                        <div class="two wide field">
                                            <asp:Label ID="lblPermZip" Text="Zipcode" runat="server" meta:resourcekey="lblPermZipResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtPermZip" runat="server" data-submit="ID_CUST_PERM_ZIPCODE" meta:resourcekey="txtPermZipResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">
                                            <asp:Label ID="lblPermCity" Text="City" runat="server" meta:resourcekey="lblPermCityResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtPermCity" runat="server" meta:resourcekey="txtPermCityResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="three wide field">
                                            <asp:Label ID="lblPermCounty" Text="County(fyl)" runat="server" meta:resourcekey="lblPermCountyResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtPermCounty" runat="server" data-submit="CUST_COUNTY" meta:resourcekey="txtPermCountyResource1" oninput="this.value = this.value.toUpperCase()" CssClass="carsInput"></asp:TextBox>
                                        </div>

                                        <div class="three wide field">

                                            <label>Land</label>
                                            <i class="hand point right icon link" id="chkAnotherCountrys"></i>
                                            <i class="norway flag" id="chkAnotherCountry"></i>
                                            <div style="display: none">
                                                <asp:TextBox ID="countrysavebox" data-submit="CUST_COUNTRY" runat="server" meta:resourcekey="txtAdvPaytermsResource1" CssClass="carsInput"></asp:TextBox></div>
                                            <div style="display: none">
                                                <asp:TextBox ID="flagsavebox" data-submit="CUST_COUNTRY_FLG" runat="server" meta:resourcekey="txtAdvPaytermsResource1" CssClass="carsInput"></asp:TextBox></div>

                                        </div>

                                    </div>

                                    <div class="fields">
                                        <div class="three wide field" id="countryChooser" style="display: none">
                                            <div class="ui search selection dropdown" id="countryChooserDrop">
                                                <input type="hidden" name="country">
                                                <i class="dropdown icon"></i>
                                                <div class="default text"><%=GetLocalResourceObject("divCountryChooser")%></div>
                                                <div class="menu">
                                                    <div class="item" data-value="af"><i class="af flag"></i>Afghanistan</div>
                                                    <div class="item" data-value="ax"><i class="ax flag"></i>Aland Islands</div>
                                                    <div class="item" data-value="al"><i class="al flag"></i>Albania</div>
                                                    <div class="item" data-value="dz"><i class="dz flag"></i>Algeria</div>
                                                    <div class="item" data-value="as"><i class="as flag"></i>American Samoa</div>
                                                    <div class="item" data-value="ad"><i class="ad flag"></i>Andorra</div>
                                                    <div class="item" data-value="ao"><i class="ao flag"></i>Angola</div>
                                                    <div class="item" data-value="ai"><i class="ai flag"></i>Anguilla</div>
                                                    <div class="item" data-value="ag"><i class="ag flag"></i>Antigua</div>
                                                    <div class="item" data-value="ar"><i class="ar flag"></i>Argentina</div>
                                                    <div class="item" data-value="am"><i class="am flag"></i>Armenia</div>
                                                    <div class="item" data-value="aw"><i class="aw flag"></i>Aruba</div>
                                                    <div class="item" data-value="au"><i class="au flag"></i>Australia</div>
                                                    <div class="item" data-value="at"><i class="at flag"></i>Austria</div>
                                                    <div class="item" data-value="az"><i class="az flag"></i>Azerbaijan</div>
                                                    <div class="item" data-value="bs"><i class="bs flag"></i>Bahamas</div>
                                                    <div class="item" data-value="bh"><i class="bh flag"></i>Bahrain</div>
                                                    <div class="item" data-value="bd"><i class="bd flag"></i>Bangladesh</div>
                                                    <div class="item" data-value="bb"><i class="bb flag"></i>Barbados</div>
                                                    <div class="item" data-value="by"><i class="by flag"></i>Belarus</div>
                                                    <div class="item" data-value="be"><i class="be flag"></i>Belgium</div>
                                                    <div class="item" data-value="bz"><i class="bz flag"></i>Belize</div>
                                                    <div class="item" data-value="bj"><i class="bj flag"></i>Benin</div>
                                                    <div class="item" data-value="bm"><i class="bm flag"></i>Bermuda</div>
                                                    <div class="item" data-value="bt"><i class="bt flag"></i>Bhutan</div>
                                                    <div class="item" data-value="bo"><i class="bo flag"></i>Bolivia</div>
                                                    <div class="item" data-value="ba"><i class="ba flag"></i>Bosnia</div>
                                                    <div class="item" data-value="bw"><i class="bw flag"></i>Botswana</div>
                                                    <div class="item" data-value="bv"><i class="bv flag"></i>Bouvet Island</div>
                                                    <div class="item" data-value="br"><i class="br flag"></i>Brazil</div>
                                                    <div class="item" data-value="vg"><i class="vg flag"></i>British Virgin Islands</div>
                                                    <div class="item" data-value="bn"><i class="bn flag"></i>Brunei</div>
                                                    <div class="item" data-value="bg"><i class="bg flag"></i>Bulgaria</div>
                                                    <div class="item" data-value="bf"><i class="bf flag"></i>Burkina Faso</div>
                                                    <div class="item" data-value="mm"><i class="mm flag"></i>Burma</div>
                                                    <div class="item" data-value="bi"><i class="bi flag"></i>Burundi</div>
                                                    <div class="item" data-value="tc"><i class="tc flag"></i>Caicos Islands</div>
                                                    <div class="item" data-value="kh"><i class="kh flag"></i>Cambodia</div>
                                                    <div class="item" data-value="cm"><i class="cm flag"></i>Cameroon</div>
                                                    <div class="item" data-value="ca"><i class="ca flag"></i>Canada</div>
                                                    <div class="item" data-value="cv"><i class="cv flag"></i>Cape Verde</div>
                                                    <div class="item" data-value="ky"><i class="ky flag"></i>Cayman Islands</div>
                                                    <div class="item" data-value="cf"><i class="cf flag"></i>Central African Republic</div>
                                                    <div class="item" data-value="td"><i class="td flag"></i>Chad</div>
                                                    <div class="item" data-value="cl"><i class="cl flag"></i>Chile</div>
                                                    <div class="item" data-value="cn"><i class="cn flag"></i>China</div>
                                                    <div class="item" data-value="cx"><i class="cx flag"></i>Christmas Island</div>
                                                    <div class="item" data-value="cc"><i class="cc flag"></i>Cocos Islands</div>
                                                    <div class="item" data-value="co"><i class="co flag"></i>Colombia</div>
                                                    <div class="item" data-value="km"><i class="km flag"></i>Comoros</div>
                                                    <div class="item" data-value="cg"><i class="cg flag"></i>Congo Brazzaville</div>
                                                    <div class="item" data-value="cd"><i class="cd flag"></i>Congo</div>
                                                    <div class="item" data-value="ck"><i class="ck flag"></i>Cook Islands</div>
                                                    <div class="item" data-value="cr"><i class="cr flag"></i>Costa Rica</div>
                                                    <div class="item" data-value="ci"><i class="ci flag"></i>Cote Divoire</div>
                                                    <div class="item" data-value="hr"><i class="hr flag"></i>Croatia</div>
                                                    <div class="item" data-value="cu"><i class="cu flag"></i>Cuba</div>
                                                    <div class="item" data-value="cy"><i class="cy flag"></i>Cyprus</div>
                                                    <div class="item" data-value="cz"><i class="cz flag"></i>Czech Republic</div>
                                                    <div class="item" data-value="dk"><i class="dk flag"></i>Denmark</div>
                                                    <div class="item" data-value="dj"><i class="dj flag"></i>Djibouti</div>
                                                    <div class="item" data-value="dm"><i class="dm flag"></i>Dominica</div>
                                                    <div class="item" data-value="do"><i class="do flag"></i>Dominican Republic</div>
                                                    <div class="item" data-value="ec"><i class="ec flag"></i>Ecuador</div>
                                                    <div class="item" data-value="eg"><i class="eg flag"></i>Egypt</div>
                                                    <div class="item" data-value="sv"><i class="sv flag"></i>El Salvador</div>
                                                    <div class="item" data-value="gb"><i class="gb flag"></i>England</div>
                                                    <div class="item" data-value="gq"><i class="gq flag"></i>Equatorial Guinea</div>
                                                    <div class="item" data-value="er"><i class="er flag"></i>Eritrea</div>
                                                    <div class="item" data-value="ee"><i class="ee flag"></i>Estonia</div>
                                                    <div class="item" data-value="et"><i class="et flag"></i>Ethiopia</div>
                                                    <div class="item" data-value="eu"><i class="eu flag"></i>European Union</div>
                                                    <div class="item" data-value="fk"><i class="fk flag"></i>Falkland Islands</div>
                                                    <div class="item" data-value="fo"><i class="fo flag"></i>Faroe Islands</div>
                                                    <div class="item" data-value="fj"><i class="fj flag"></i>Fiji</div>
                                                    <div class="item" data-value="fi"><i class="fi flag"></i>Finland</div>
                                                    <div class="item" data-value="fr"><i class="fr flag"></i>France</div>
                                                    <div class="item" data-value="gf"><i class="gf flag"></i>French Guiana</div>
                                                    <div class="item" data-value="pf"><i class="pf flag"></i>French Polynesia</div>
                                                    <div class="item" data-value="tf"><i class="tf flag"></i>French Territories</div>
                                                    <div class="item" data-value="ga"><i class="ga flag"></i>Gabon</div>
                                                    <div class="item" data-value="gm"><i class="gm flag"></i>Gambia</div>
                                                    <div class="item" data-value="ge"><i class="ge flag"></i>Georgia</div>
                                                    <div class="item" data-value="de"><i class="de flag"></i>Germany</div>
                                                    <div class="item" data-value="gh"><i class="gh flag"></i>Ghana</div>
                                                    <div class="item" data-value="gi"><i class="gi flag"></i>Gibraltar</div>
                                                    <div class="item" data-value="gr"><i class="gr flag"></i>Greece</div>
                                                    <div class="item" data-value="gl"><i class="gl flag"></i>Greenland</div>
                                                    <div class="item" data-value="gd"><i class="gd flag"></i>Grenada</div>
                                                    <div class="item" data-value="gp"><i class="gp flag"></i>Guadeloupe</div>
                                                    <div class="item" data-value="gu"><i class="gu flag"></i>Guam</div>
                                                    <div class="item" data-value="gt"><i class="gt flag"></i>Guatemala</div>
                                                    <div class="item" data-value="gw"><i class="gw flag"></i>Guinea-Bissau</div>
                                                    <div class="item" data-value="gn"><i class="gn flag"></i>Guinea</div>
                                                    <div class="item" data-value="gy"><i class="gy flag"></i>Guyana</div>
                                                    <div class="item" data-value="ht"><i class="ht flag"></i>Haiti</div>
                                                    <div class="item" data-value="hm"><i class="hm flag"></i>Heard Island</div>
                                                    <div class="item" data-value="hn"><i class="hn flag"></i>Honduras</div>
                                                    <div class="item" data-value="hk"><i class="hk flag"></i>Hong Kong</div>
                                                    <div class="item" data-value="hu"><i class="hu flag"></i>Hungary</div>
                                                    <div class="item" data-value="is"><i class="is flag"></i>Iceland</div>
                                                    <div class="item" data-value="in"><i class="in flag"></i>India</div>
                                                    <div class="item" data-value="io"><i class="io flag"></i>Indian Ocean Territory</div>
                                                    <div class="item" data-value="id"><i class="id flag"></i>Indonesia</div>
                                                    <div class="item" data-value="ir"><i class="ir flag"></i>Iran</div>
                                                    <div class="item" data-value="iq"><i class="iq flag"></i>Iraq</div>
                                                    <div class="item" data-value="ie"><i class="ie flag"></i>Ireland</div>
                                                    <div class="item" data-value="il"><i class="il flag"></i>Israel</div>
                                                    <div class="item" data-value="it"><i class="it flag"></i>Italy</div>
                                                    <div class="item" data-value="jm"><i class="jm flag"></i>Jamaica</div>
                                                    <div class="item" data-value="jp"><i class="jp flag"></i>Japan</div>
                                                    <div class="item" data-value="jo"><i class="jo flag"></i>Jordan</div>
                                                    <div class="item" data-value="kz"><i class="kz flag"></i>Kazakhstan</div>
                                                    <div class="item" data-value="ke"><i class="ke flag"></i>Kenya</div>
                                                    <div class="item" data-value="ki"><i class="ki flag"></i>Kiribati</div>
                                                    <div class="item" data-value="kw"><i class="kw flag"></i>Kuwait</div>
                                                    <div class="item" data-value="kg"><i class="kg flag"></i>Kyrgyzstan</div>
                                                    <div class="item" data-value="la"><i class="la flag"></i>Laos</div>
                                                    <div class="item" data-value="lv"><i class="lv flag"></i>Latvia</div>
                                                    <div class="item" data-value="lb"><i class="lb flag"></i>Lebanon</div>
                                                    <div class="item" data-value="ls"><i class="ls flag"></i>Lesotho</div>
                                                    <div class="item" data-value="lr"><i class="lr flag"></i>Liberia</div>
                                                    <div class="item" data-value="ly"><i class="ly flag"></i>Libya</div>
                                                    <div class="item" data-value="li"><i class="li flag"></i>Liechtenstein</div>
                                                    <div class="item" data-value="lt"><i class="lt flag"></i>Lithuania</div>
                                                    <div class="item" data-value="lu"><i class="lu flag"></i>Luxembourg</div>
                                                    <div class="item" data-value="mo"><i class="mo flag"></i>Macau</div>
                                                    <div class="item" data-value="mk"><i class="mk flag"></i>Macedonia</div>
                                                    <div class="item" data-value="mg"><i class="mg flag"></i>Madagascar</div>
                                                    <div class="item" data-value="mw"><i class="mw flag"></i>Malawi</div>
                                                    <div class="item" data-value="my"><i class="my flag"></i>Malaysia</div>
                                                    <div class="item" data-value="mv"><i class="mv flag"></i>Maldives</div>
                                                    <div class="item" data-value="ml"><i class="ml flag"></i>Mali</div>
                                                    <div class="item" data-value="mt"><i class="mt flag"></i>Malta</div>
                                                    <div class="item" data-value="mh"><i class="mh flag"></i>Marshall Islands</div>
                                                    <div class="item" data-value="mq"><i class="mq flag"></i>Martinique</div>
                                                    <div class="item" data-value="mr"><i class="mr flag"></i>Mauritania</div>
                                                    <div class="item" data-value="mu"><i class="mu flag"></i>Mauritius</div>
                                                    <div class="item" data-value="yt"><i class="yt flag"></i>Mayotte</div>
                                                    <div class="item" data-value="mx"><i class="mx flag"></i>Mexico</div>
                                                    <div class="item" data-value="fm"><i class="fm flag"></i>Micronesia</div>
                                                    <div class="item" data-value="md"><i class="md flag"></i>Moldova</div>
                                                    <div class="item" data-value="mc"><i class="mc flag"></i>Monaco</div>
                                                    <div class="item" data-value="mn"><i class="mn flag"></i>Mongolia</div>
                                                    <div class="item" data-value="me"><i class="me flag"></i>Montenegro</div>
                                                    <div class="item" data-value="ms"><i class="ms flag"></i>Montserrat</div>
                                                    <div class="item" data-value="ma"><i class="ma flag"></i>Morocco</div>
                                                    <div class="item" data-value="mz"><i class="mz flag"></i>Mozambique</div>
                                                    <div class="item" data-value="na"><i class="na flag"></i>Namibia</div>
                                                    <div class="item" data-value="nr"><i class="nr flag"></i>Nauru</div>
                                                    <div class="item" data-value="np"><i class="np flag"></i>Nepal</div>
                                                    <div class="item" data-value="an"><i class="an flag"></i>Netherlands Antilles</div>
                                                    <div class="item" data-value="nl"><i class="nl flag"></i>Netherlands</div>
                                                    <div class="item" data-value="nc"><i class="nc flag"></i>New Caledonia</div>
                                                    <div class="item" data-value="pg"><i class="pg flag"></i>New Guinea</div>
                                                    <div class="item" data-value="nz"><i class="nz flag"></i>New Zealand</div>
                                                    <div class="item" data-value="ni"><i class="ni flag"></i>Nicaragua</div>
                                                    <div class="item" data-value="ne"><i class="ne flag"></i>Niger</div>
                                                    <div class="item" data-value="ng"><i class="ng flag"></i>Nigeria</div>
                                                    <div class="item" data-value="nu"><i class="nu flag"></i>Niue</div>
                                                    <div class="item" data-value="nf"><i class="nf flag"></i>Norfolk Island</div>
                                                    <div class="item" data-value="kp"><i class="kp flag"></i>North Korea</div>
                                                    <div class="item" data-value="mp"><i class="mp flag"></i>Northern Mariana Islands</div>
                                                    <div class="item" data-value="no"><i class="no flag"></i>Norge</div>
                                                    <div class="item" data-value="om"><i class="om flag"></i>Oman</div>
                                                    <div class="item" data-value="pk"><i class="pk flag"></i>Pakistan</div>
                                                    <div class="item" data-value="pw"><i class="pw flag"></i>Palau</div>
                                                    <div class="item" data-value="ps"><i class="ps flag"></i>Palestine</div>
                                                    <div class="item" data-value="pa"><i class="pa flag"></i>Panama</div>
                                                    <div class="item" data-value="py"><i class="py flag"></i>Paraguay</div>
                                                    <div class="item" data-value="pe"><i class="pe flag"></i>Peru</div>
                                                    <div class="item" data-value="ph"><i class="ph flag"></i>Philippines</div>
                                                    <div class="item" data-value="pn"><i class="pn flag"></i>Pitcairn Islands</div>
                                                    <div class="item" data-value="pl"><i class="pl flag"></i>Poland</div>
                                                    <div class="item" data-value="pt"><i class="pt flag"></i>Portugal</div>
                                                    <div class="item" data-value="pr"><i class="pr flag"></i>Puerto Rico</div>
                                                    <div class="item" data-value="qa"><i class="qa flag"></i>Qatar</div>
                                                    <div class="item" data-value="re"><i class="re flag"></i>Reunion</div>
                                                    <div class="item" data-value="ro"><i class="ro flag"></i>Romania</div>
                                                    <div class="item" data-value="ru"><i class="ru flag"></i>Russia</div>
                                                    <div class="item" data-value="rw"><i class="rw flag"></i>Rwanda</div>
                                                    <div class="item" data-value="sh"><i class="sh flag"></i>Saint Helena</div>
                                                    <div class="item" data-value="kn"><i class="kn flag"></i>Saint Kitts and Nevis</div>
                                                    <div class="item" data-value="lc"><i class="lc flag"></i>Saint Lucia</div>
                                                    <div class="item" data-value="pm"><i class="pm flag"></i>Saint Pierre</div>
                                                    <div class="item" data-value="vc"><i class="vc flag"></i>Saint Vincent</div>
                                                    <div class="item" data-value="ws"><i class="ws flag"></i>Samoa</div>
                                                    <div class="item" data-value="sm"><i class="sm flag"></i>San Marino</div>
                                                    <div class="item" data-value="gs"><i class="gs flag"></i>Sandwich Islands</div>
                                                    <div class="item" data-value="st"><i class="st flag"></i>Sao Tome</div>
                                                    <div class="item" data-value="sa"><i class="sa flag"></i>Saudi Arabia</div>
                                                    <div class="item" data-value="sn"><i class="sn flag"></i>Senegal</div>
                                                    <div class="item" data-value="cs"><i class="cs flag"></i>Serbia</div>
                                                    <div class="item" data-value="rs"><i class="rs flag"></i>Serbia</div>
                                                    <div class="item" data-value="sc"><i class="sc flag"></i>Seychelles</div>
                                                    <div class="item" data-value="sl"><i class="sl flag"></i>Sierra Leone</div>
                                                    <div class="item" data-value="sg"><i class="sg flag"></i>Singapore</div>
                                                    <div class="item" data-value="sk"><i class="sk flag"></i>Slovakia</div>
                                                    <div class="item" data-value="si"><i class="si flag"></i>Slovenia</div>
                                                    <div class="item" data-value="sb"><i class="sb flag"></i>Solomon Islands</div>
                                                    <div class="item" data-value="so"><i class="so flag"></i>Somalia</div>
                                                    <div class="item" data-value="za"><i class="za flag"></i>South Africa</div>
                                                    <div class="item" data-value="kr"><i class="kr flag"></i>South Korea</div>
                                                    <div class="item" data-value="es"><i class="es flag"></i>Spain</div>
                                                    <div class="item" data-value="lk"><i class="lk flag"></i>Sri Lanka</div>
                                                    <div class="item" data-value="sd"><i class="sd flag"></i>Sudan</div>
                                                    <div class="item" data-value="sr"><i class="sr flag"></i>Suriname</div>
                                                    <div class="item" data-value="sj"><i class="sj flag"></i>Svalbard</div>
                                                    <div class="item" data-value="sz"><i class="sz flag"></i>Swaziland</div>
                                                    <div class="item" data-value="se"><i class="se flag"></i>Sweden</div>
                                                    <div class="item" data-value="ch"><i class="ch flag"></i>Switzerland</div>
                                                    <div class="item" data-value="sy"><i class="sy flag"></i>Syria</div>
                                                    <div class="item" data-value="tw"><i class="tw flag"></i>Taiwan</div>
                                                    <div class="item" data-value="tj"><i class="tj flag"></i>Tajikistan</div>
                                                    <div class="item" data-value="tz"><i class="tz flag"></i>Tanzania</div>
                                                    <div class="item" data-value="th"><i class="th flag"></i>Thailand</div>
                                                    <div class="item" data-value="tl"><i class="tl flag"></i>Timorleste</div>
                                                    <div class="item" data-value="tg"><i class="tg flag"></i>Togo</div>
                                                    <div class="item" data-value="tk"><i class="tk flag"></i>Tokelau</div>
                                                    <div class="item" data-value="to"><i class="to flag"></i>Tonga</div>
                                                    <div class="item" data-value="tt"><i class="tt flag"></i>Trinidad</div>
                                                    <div class="item" data-value="tn"><i class="tn flag"></i>Tunisia</div>
                                                    <div class="item" data-value="tr"><i class="tr flag"></i>Turkey</div>
                                                    <div class="item" data-value="tm"><i class="tm flag"></i>Turkmenistan</div>
                                                    <div class="item" data-value="tv"><i class="tv flag"></i>Tuvalu</div>
                                                    <div class="item" data-value="ug"><i class="ug flag"></i>Uganda</div>
                                                    <div class="item" data-value="ua"><i class="ua flag"></i>Ukraine</div>
                                                    <div class="item" data-value="ae"><i class="ae flag"></i>United Arab Emirates</div>
                                                    <div class="item" data-value="us"><i class="us flag"></i>United States</div>
                                                    <div class="item" data-value="uy"><i class="uy flag"></i>Uruguay</div>
                                                    <div class="item" data-value="um"><i class="um flag"></i>Us Minor Islands</div>
                                                    <div class="item" data-value="vi"><i class="vi flag"></i>Us Virgin Islands</div>
                                                    <div class="item" data-value="uz"><i class="uz flag"></i>Uzbekistan</div>
                                                    <div class="item" data-value="vu"><i class="vu flag"></i>Vanuatu</div>
                                                    <div class="item" data-value="va"><i class="va flag"></i>Vatican City</div>
                                                    <div class="item" data-value="ve"><i class="ve flag"></i>Venezuela</div>
                                                    <div class="item" data-value="vn"><i class="vn flag"></i>Vietnam</div>
                                                    <div class="item" data-value="wf"><i class="wf flag"></i>Wallis and Futuna</div>
                                                    <div class="item" data-value="eh"><i class="eh flag"></i>Western Sahara</div>
                                                    <div class="item" data-value="ye"><i class="ye flag"></i>Yemen</div>
                                                    <div class="item" data-value="zm"><i class="zm flag"></i>Zambia</div>
                                                    <div class="item" data-value="zw"><i class="zw flag"></i>Zimbabwe</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="fields">
                                        <div class="eight wide field">
                                            <label>
                                                <asp:CheckBox ID="chkSameAdd" runat="server" Text="Same as visit address" CssClass="inLblCheckbox" data-submit="ISSAMEADDRESS" meta:resourcekey="chkSameAddResource1" />
                                            </label>
                                        </div>
                                    </div>
                                    <div class="fields" id="postalAddressArea" style="display: none">
                                        <div class="four wide field">
                                            <asp:Label ID="lblBillAdd" Text="Postal address" runat="server" meta:resourcekey="lblBillAddResource1" Style="font-weight: 900 !important"></asp:Label>

                                            <asp:TextBox ID="txtBillAdd1" runat="server" data-submit="CUST_BILL_ADD1" meta:resourcekey="txtBillAdd1Resource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="two wide field">
                                            <asp:Label ID="lblBillZip" Text="Zipcode" runat="server" meta:resourcekey="lblBillZipResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtBillZip" runat="server" data-submit="ID_CUST_BILL_ZIPCODE" meta:resourcekey="txtBillZipResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>
                                        <div class="four wide field">
                                            <asp:Label ID="lblBillCity" Text="City" runat="server" meta:resourcekey="lblBillCityResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtBillCity" runat="server" meta:resourcekey="txtBillCityResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>


                                        <div class="three wide field">
                                            <asp:Label ID="lblBillCounty" Text="County(fyl)" runat="server" meta:resourcekey="lblBillCountyResource1" Style="font-weight: 900 !important"></asp:Label>
                                            <asp:TextBox ID="txtBillCounty" runat="server" meta:resourcekey="txtBillCountyResource1" CssClass="carsInput"></asp:TextBox>
                                        </div>

                                        <div class="three wide field">

                                            <label>&nbsp;</label>
                                            <i class="hand point right icon link" id="chkAnotherCountrysBilling"></i>
                                            <i class="norway flag" id="chkAnotherCountryBilling"></i>

                                        </div>


                                    </div>

                                    <div class="fields" style="margin-top: 3rem;">


                                        <div class="four wide field">
                                            <button class="ui button carsButtonBlueInverted wide" type="button" id="btnCustNotes"><i class="exclamation triangle icon" id="exclamIcon" style="color: red;"></i><%=GetLocalResourceObject("divNotes")%></button>
                                        </div>
                                        
                                         <div class="four wide field">
                                            <button class="ui button carsButtonBlueInverted wide" type="button" id="btnInvSettings"><%=GetLocalResourceObject("divMarketing")%></button>
                                        </div>

                                        <div class="four wide field">
                                            <button class="ui button carsButtonBlueInverted wide" type="button" id="btnContactPreferences">
                                                <%=GetLocalResourceObject("divInvoiceContact")%>
                                            </button>
                                        </div>

                                        <div class="four wide field">
                                            <button class="ui button carsButtonBlueInverted wide" type="button" id="btnDates"><%=GetLocalResourceObject("divDate")%></button>
                                        </div>
                                    </div>
                                    <div class="fields">
                                       
                                    </div> 
                                    
                                    <div class="fields" style="margin-top: 3rem; display: none;">
                                        <asp:Label ID="lblCustomerTemplate" runat="server" Text="Velg mal" meta:resourcekey="lblCustomerTemplateResource1"></asp:Label>
                                        <div id="updCustomerTemplate">
                                            <asp:DropDownList ID="ddlCustomerTemplate" CssClass="dropdowns" runat="server" meta:resourcekey="ddlCustomerTemplateResource1"></asp:DropDownList>
                                        </div>
                                    </div>

                                </div>

                            </div>


                            <div class="five wide column">
                                <div class="ui form">
                                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <h3 id="H22" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrContact")%></h3>
                                        <button class="medium ui button" type="button" id="btnNewContact" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                            <i class="plus icon"></i>
                                        </button>
                                        <div id="customerContactPH">
                                        </div>
                                    </div>

                                </div>


                            </div>


                        </div>

                    </div>
                </div>



                <div class="ui bottom attached tab segment" data-tab="second">

                    <%-- ############################### ADVANCED ##########################################--%>
                    <div id="tabAdvanced">
                        <div class="ui form stackable three column grid ">
                            <div class="stretched row">
                                <div class="eleven wide column">
                                    <%--START Left Column--%>


                                    <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                        <h3 id="H11" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrDetails")%></h3>
                                        <div class="ui divider"></div>

                                        <div class="inline fields">
                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelSeller")%></label>
                                            </div>
                                            <div class="four wide field">
                                                <asp:TextBox ID="txtAdvSalesman" runat="server" meta:resourcekey="txtAdvSalesmanResource1" CssClass="carsInput" ReadOnly="True"></asp:TextBox>
                                            </div>

                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvSalesman" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon" style="margin: auto"></i>
                                                </button>
                                            </div>

                                            <label id="lblSalesmanTxt" data-submit="CUST_SALESMAN" style="visibility: hidden; display: none"></label>


                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelBranch")%></label>
                                                <label style="visibility: hidden; display: none">Bransje</label>
                                            </div>
                                            <div class="four wide field">
                                                <asp:TextBox ID="txtAdvBranch" runat="server" meta:resourcekey="txtAdvSalesmanResource1" CssClass="carsInput" ReadOnly="True"></asp:TextBox>
                                            </div>

                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvBranch" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvBranchTxt" data-submit="CUST_SALESMAN_JOB" style="visibility: hidden; display: none"></label>

                                        </div>




                                        <div class="inline fields">
                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelCategory")%></label>
                                            </div>
                                            <div class="four wide field">
                                                <div class="ui mini input">
                                                    <asp:DropDownList ID="ddlCustGroup" runat="server" class="carsInput" data-submit="ID_CUST_GROUP" meta:resourcekey="ddlCustGroupResource1"></asp:DropDownList>
                                                    <div class="hidden">
                                                        <asp:Label ID="lblPayType" Text="Payment type" runat="server" meta:resourcekey="lblPayTypeResource1"></asp:Label>
                                                        <asp:DropDownList ID="ddlPayType" runat="server" class="dropdowns" data-submit="ID_CUST_PAY_TYPE" meta:resourcekey="ddlPayTypeResource1"></asp:DropDownList>
                                                        <asp:TextBox ID="txtAdvCategory" runat="server" meta:resourcekey="txtAdvCategoryResource1" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvCategory" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvCategoryTxt" style="visibility: hidden; display: none"></label>


                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelSalesGroup")%></label>
                                            </div>

                                            <div class="four wide field">
                                                <div class="ui mini input">
                                                    <asp:TextBox ID="txtAdvSalesgroup" runat="server" meta:resourcekey="txtAdvSalesgroupResource1" CssClass="carsInput" ReadOnly="True"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvSalesgroup" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvSalesgroupTxt" data-submit="SALES_GROUP" style="visibility: hidden; display: none"></label>

                                        </div>




                                        <div class="inline fields">
                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelPayTerms")%></label>
                                            </div>

                                            <div class="four wide field">
                                                <div class="ui mini input">
                                                    <asp:DropDownList ID="ddlPayTerms" runat="server" class="carsInput" data-submit="ID_CUST_PAY_TERM" meta:resourcekey="ddlPayTermsResource1"></asp:DropDownList>

                                                    <div class="hidden">
                                                        <asp:TextBox ID="txtAdvPayterms" runat="server" meta:resourcekey="txtAdvPaytermsResource1" CssClass="carsInput"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvPayterms" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvPaytermsTxt" style="visibility: hidden; display: none"></label>


                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelCardType")%></label>
                                            </div>
                                            <div class="four wide field">
                                                <div class="ui mini input">
                                                    <asp:TextBox ID="txtAdvCardtype" runat="server" data-submit="" meta:resourcekey="txtAdvCardtypeResource1" CssClass="carsInput"></asp:TextBox>

                                                    <div class="hidden">
                                                        <asp:TextBox ID="txtAdvCardtypeP" runat="server" meta:resourcekey="txtAdvCardtypeResource1" CssClass="carsInput"></asp:TextBox>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvCardtype" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvCardtypeTxt" data-submit="PAYMENT_CARD_TYPE" style="visibility: hidden; display: none"></label>

                                        </div>




                                        <div class="inline fields">
                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelCurrencyCode")%></label>
                                            </div>
                                            <div class="four wide field">
                                                <div class="ui mini input">
                                                    <asp:TextBox ID="txtAdvCurrcode" runat="server" meta:resourcekey="txtAdvCurrcodeResource1" CssClass="carsInput" ReadOnly="True"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvCurrcode" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvCurrcodeTxt" data-submit="CURRENCY_CODE" style="visibility: hidden; display: none"></label>


                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelDebtorGroup")%></label>
                                            </div>
                                            <div class="four wide field">
                                                <asp:TextBox ID="txtAdvDebitorgroup" data-submit="DEBITOR_GROUP" runat="server" meta:resourcekey="txtAdvDebitorgroupResource1" CssClass="carsInput"></asp:TextBox>
                                            </div>

                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvDebitorGroup" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvDebitorgroupTxt"  style="visibility: hidden; display: none"></label>



                                        </div>




                                        <div class="inline fields">
                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelInvoiceLevel")%></label>
                                            </div>
                                            <div class="four wide field">
                                                <div class="ui mini input">
                                                    <asp:TextBox ID="txtAdvInvoicelevel" data-submit="INVOICE_LEVEL" runat="server" meta:resourcekey="txtAdvDebitorgroupResource1" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvInvoiceLevel" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvInvoicelevelTxt"  style="visibility: hidden; display: none"></label>

                                            <div class="three wide field">
                                                <label><%=GetLocalResourceObject("labelHourlyrateNo")%></label>
                                            </div>
                                            <div class="four wide field">
                                                <div class="ui mini input">
                                                    <asp:TextBox ID="txtAdvHourlyPriceNo" data-submit="HOURLY_PRICE_NO" runat="server" meta:resourcekey="txtAdvHourlyRateNr" CssClass="carsInput"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="one wide field">
                                                <button class="mini ui button" type="button" id="btnAdvHourlyRateNr" style="color: #21BA45; background-color: white; padding: 0.4rem">
                                                    <i class="plus icon"></i>
                                                </button>
                                            </div>

                                            <label id="txtAdvHourlyRateNrTxt" style="visibility: hidden; display: none"></label>
                                        </div>

                                        <div class="fields" style="margin-top: 3rem;">


                                            <div class="four wide field">
                                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnCompanyReferences"><%=GetLocalResourceObject("divCompanyReferences")%></button>
                                            </div>
                                            <div class="four wide field">
                                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnWhat"><%=GetLocalResourceObject("divBonus")%></button>
                                            </div>

                                            <div class="four wide field">
                                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnDiscountEtc"><%=GetLocalResourceObject("divDiscount")%></button>
                                            </div>
                                              <div class="four wide field">
                                                <button class="ui button carsButtonBlueInverted wide" type="button" id="btnBilxtra"><%=GetLocalResourceObject("divBilXtra")%></button>
                                            </div>
                                        </div>






                                    </div>


                                </div>
                                <%-- innstillinger +disc+economy+misc segment--%>
                                <div class="two wide column"></div>





                            </div>
                        </div>
                    </div>
                </div>


                <div class="ui bottom attached tab segment" data-tab="third">

                    <%--                    ############################### ACTIVITIES ##########################################--%>
                    <div id="tabActivities">
                        <div class="ui form stackable one column grid ">

                            <div class="fourteen wide column">
                                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H20" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrActivities")%></h3>
                                    <div class="ui divider"></div>
                                    <div class="ui internally celled grid">
                                        <div class="row">
                                            <div class="thirteen wide column">
                                                <div id="activities-table" class="mytabulatorclass"></div>
                                            </div>
                                            <div class="three wide column">
                                                <div class="ui vertical basic buttons">
                                                    <button class="ui basic blue button">
                                                        <i class="icon user"></i>
                                                        <%=GetLocalResourceObject("btnActOffer")%>
                                                    </button>
                                                    <button class="ui basic blue button">
                                                        <i class="icon user"></i>
                                                         <%=GetLocalResourceObject("btnActWord")%>
                                                    </button>
                                                    <button class="ui basic blue button">
                                                        <i class="icon user"></i>
                                                       <%=GetLocalResourceObject("btnActExcel")%>
                                                    </button>
                                                    <button class="ui basic blue button">
                                                        <i class="icon user"></i>
                                                          <%=GetLocalResourceObject("btnActMail")%>
                                                    </button>
                                                    <button class="ui basic blue button">
                                                        <i class="icon user"></i>
                                                        <%=GetLocalResourceObject("btnActTele")%>
                                                    </button>
                                                    <button class="ui basic blue button">
                                                        <i class="icon user"></i>
                                                        <%=GetLocalResourceObject("btnActAttachments")%>
                                                    </button>
                                                </div>
                                                <div class="ui icon top left pointing green dropdown button">
                                                    <i class="plus icon"></i>
                                                    <div class="menu">
                                                        <div class="header"><%=GetLocalResourceObject("divMenuSelection")%></div>

                                                        <div class="item">
                                                            <i class="dropdown icon"></i>
                                                            <span class="text">Ny</span> <!-- check -->
                                                            <div class="menu">
                                                                <div class="item" id="icon_newPO">
                                                                    <i class="pencil icon"></i>
                                                                    <%=GetLocalResourceObject("btnActOffer")%>
                                                                </div>
                                                                <div class="item" id="icon_newPOautomatic">
                                                                    <i class="random icon"></i>
                                                                    <%=GetLocalResourceObject("divAutOrd")%>
                                                                </div>
                                                                <div class="item" id="icon_withoutOrder">
                                                                    <i class="question icon"></i>
                                                                    <%=GetLocalResourceObject("divArrWOBook")%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="item"><%=GetLocalResourceObject("divSettings")%></div>

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
                <div class="ui bottom attached tab segment " data-tab="fourth">
                    <%--                    ############################### VEHICLE ##########################################--%>
                    <div id="tabVehicle">
                        <div class="ui grid">
                            <div class="ten wide column">
                                <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="H12" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrCars")%></h3>
                                    <div class="ui divider"></div>
                                    <div id="carList-table" class="mytabulatorclass"></div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>



                <div class="ui bottom attached tab segment " data-tab="fifth">
                    <%--                    ############################### WANTED ##########################################--%>
                    <div id="tabWanted">
                        <div class="ui grid">
                            <div class="eight wide column">
                                <div class="ui form">
                                     <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblWantedVehicle" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrWanterCar")%></h3>

                                        <div class="fields">
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedMake" Text="Make" runat="server" CssClass="centerlabel" meta:resourcekey="lblMakeResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedMake" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedMakeResource1"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedModel" Text="Model" runat="server" CssClass="centerlabel" meta:resourcekey="lblWantedModelResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedModel" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedModelResource1"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedYearFrom" Text="Year model from" runat="server" CssClass="centerlabel" Width="200%" meta:resourcekey="lblWantedYearFromResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedYearFrom" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedYearFromResource1"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedYearTo" Text="Year model to" runat="server" CssClass="centerlabel" Width="200%" meta:resourcekey="lblWantedYearToResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedYearTo" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedYearToResource1"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedPriceFrom" Text="Priceclass from" runat="server" CssClass="centerlabel" Width="200%" meta:resourcekey="lblWantedPriceFromResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedPriceFrom" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedPriceFromResource1"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedPriceTo" Text="Priceclass to" runat="server" CssClass="centerlabel" Width="200%" meta:resourcekey="lblWantedPriceToResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedPriceTo" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedPriceToResource1"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedMileageFrom" Text="Mileage from" runat="server" CssClass="centerlabel" Width="200%" meta:resourcekey="lblWantedMileageFromResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedMileageFrom" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedMileageFromResource1"></asp:TextBox>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblWantedMileageTo" Text="Mileage to" runat="server" CssClass="centerlabel" Width="200%" meta:resourcekey="lblWantedMileageToResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtWantedMileageTo" runat="server" CssClass="carsInput" meta:resourcekey="txtWantedMileageToResource1"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblColor" Text="Color" runat="server" CssClass="centerlabel" meta:resourcekey="lblColorResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtColor" runat="server" CssClass="carsInput" meta:resourcekey="txtColorResource1"></asp:TextBox>
                                            </div>
                                            <div class="two wide field">
                                                <label>
                                                    <asp:CheckBox ID="cbGasoline" runat="server" Text="Gasoline" meta:resourcekey="cbGasolineResource1" />
                                                </label>
                                            </div>
                                            <div class="two wide field">
                                                <label>
                                                    <asp:CheckBox ID="cbDiesel" runat="server" Text="Diesel" meta:resourcekey="cbDieselResource1" />
                                                </label>
                                            </div>
                                            <div class="two wide field">
                                                <label>
                                                    <asp:CheckBox ID="cbElectric" runat="server" Text="El." meta:resourcekey="cbElectricResource1" />
                                                </label>
                                            </div>
                                            <div class="two wide field">
                                                <label>
                                                    <asp:CheckBox ID="cbGas" runat="server" Text="Gas" meta:resourcekey="cbGasResource1" />
                                                </label>
                                            </div>
                                            <div class="four wide field">
                                                <label>
                                                    <asp:Label ID="lblOtherFuel" Text="Other fuel" runat="server" CssClass="centerlabel" meta:resourcekey="lblOtherFuelResource1"></asp:Label></label>
                                                <asp:TextBox ID="txtOtherFuel" runat="server" CssClass="carsInput" meta:resourcekey="txtOtherFuelResource1"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="fields">
                                            <div class="four wide field">
                                                <button class="ui blue button wide" type="button" id="btnEquipment"><%=GetLocalResourceObject("divEquipment")%></button> 
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="four wide column">
                                <div class="ui form">
                                      <div class="ui raised segment" style="box-shadow: 2px 2px 14px 2px rgba(166, 209, 241, 1), 2px 2px 2px 2px rgba(34, 36, 38, 0.15);">
                                    <h3 id="lblVehic" runat="server" class="ui blue top medium header center aligned" style="border-color: blue !important"><%=GetLocalResourceObject("hdrAnnotation")%></h3>
                                        <div class="fields">
                                            <asp:TextBox ID="txtWantedAnnot" runat="server" CssClass="carsInput" TextMode="MultiLine" Height="175px" meta:resourcekey="txtOtherFuelResource1"></asp:TextBox>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="four wide column">
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>


    </div>








    <%--                    ############################### BOTTOM ##########################################--%>
    <div id="tabBottom">
        <div class="tbActions">
            <div id="btnCustEmptyScreen" class="ui button negative"><%=GetLocalResourceObject("divClear")%></div>
            <div id="btnCustLog" class="ui button"><%=GetLocalResourceObject("divLog")%></div>
            <div id="btnCustNewCust" class="ui button blue"><%=GetLocalResourceObject("divNewCustomer")%></div>
            <div id="btnCustSave" class="ui button positive"><%=GetLocalResourceObject("divSave")%></div>
        </div>
    </div>




    <%-- Customer notes Modal --%>
    <div id="modUpdateCustTemp" class="modal hidden">
        <div class="modHeader">
            <h2 id="H9" runat="server"><%=GetLocalResourceObject("hdrCustTempUpd")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("hdrCustTempUpd")%></label>
                    <div class="ui small info message">
                        <p id="PasswordMsg" runat="server"><%=GetLocalResourceObject("divPwdTempUpd")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="sixteen wide field">
                                <label for="txtPassword">
                                    <asp:Literal ID="liPassword" Text="Password" runat="server" meta:resourcekey="liPasswordResource1"></asp:Literal>
                                </label>
                                <asp:TextBox ID="txtCustTempPassword" TextMode="Password" runat="server" meta:resourcekey="txtCustTempPasswordResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            &nbsp;
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnSaveTemplate" runat="server" class="ui btn wide" value="OK"  meta:resourcekey="btnSaveResource1" />
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnCancelTemplate" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- WashCustomer Modal --%>
    <div id="modWashCustomer" class="ui modal">
        <i class="close icon"></i>
        <div class="header">
            <%=GetLocalResourceObject("divWashCustomer")%>
        </div>
        <div class="scrolling content">
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="inline fields">
                            <div class="four wide field">
                                &nbsp;
                            </div>
                            <div class="five wide field">
                                <%=GetLocalResourceObject("divLocalData")%>
                            </div>
                            <div class="five wide field">
                               <%=GetLocalResourceObject("divEniroData")%>
                            </div>
                            <div class="two wide field">
                                <%=GetLocalResourceObject("divUpdate")%>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashLastName" Text="Last name/ Subsidiary" runat="server" meta:resourcekey="lblWashLastNameResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalLastName" runat="server" meta:resourcekey="txtWashLocalLastNameResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroLastName" runat="server" meta:resourcekey="txtWashEniroLastNameResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashLastName" runat="server" meta:resourcekey="chkWashLastNameResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashFirstName" Text="First name" runat="server" meta:resourcekey="lblWashFirstNameResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalFirstName" runat="server" meta:resourcekey="txtWashLocalFirstNameResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroFirstName" runat="server" meta:resourcekey="txtWashEniroFirstNameResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashFirstName" runat="server" meta:resourcekey="chkWashFirstNameResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashMiddleName" Text="Middle name" runat="server" meta:resourcekey="lblWashMiddleNameResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalMiddleName" runat="server" meta:resourcekey="txtWashLocalMiddleNameResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroMiddleName" runat="server" meta:resourcekey="txtWashEniroMiddleNameResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashMiddleName" runat="server" meta:resourcekey="chkWashMiddleNameResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashVisitAdress" Text="Visit address" runat="server" meta:resourcekey="lblWashVisitAdressResource1"></asp:Label></label>
                                <label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalVisitAddress" runat="server" meta:resourcekey="txtWashLocalVisitAddressResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroVisitAddress" runat="server" meta:resourcekey="txtWashEniroVisitAddressResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashVisitAddress" runat="server" meta:resourcekey="chkWashVisitAddressResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashBillAddress" Text="Bill address" runat="server" meta:resourcekey="lblWashBillAddressResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalBillAddress" runat="server" meta:resourcekey="txtWashLocalBillAddressResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroBillAddress" runat="server" meta:resourcekey="txtWashEniroBillAddressResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashBillAddress" runat="server" meta:resourcekey="chkWashBillAddressResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashZipCode" Text="Postnr" runat="server" meta:resourcekey="lblWashZipCodeResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalZipCode" runat="server" meta:resourcekey="txtWashLocalZipCodeResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroZipCode" runat="server" meta:resourcekey="txtWashEniroZipCodeResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashZipCode" runat="server" meta:resourcekey="chkWashZipCodeResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashZipPlace" Text="Sted" runat="server" meta:resourcekey="lblWashZipPlaceResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalZipPlace" runat="server" meta:resourcekey="txtWashLocalZipPlaceResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroZipPlace" runat="server" meta:resourcekey="txtWashEniroZipPlaceResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashZipPlace" runat="server" meta:resourcekey="chkWashZipPlaceResource1"></asp:CheckBox>
                            </div>
                        </div>

                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashPhone" Text="Telefon" runat="server" meta:resourcekey="lblWashPhoneResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalPhone" runat="server" meta:resourcekey="txtWashLocalPhoneResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroPhone" runat="server" meta:resourcekey="txtWashEniroPhoneResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashPhone" runat="server" meta:resourcekey="chkWashPhoneResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashMobile" Text="Mobil" runat="server" meta:resourcekey="lblWashMobileResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalMobile" runat="server" meta:resourcekey="txtWashLocalMobileResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroMobile" runat="server" meta:resourcekey="txtWashEniroMobileResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashMobile" runat="server" meta:resourcekey="chkWashMobileResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields" id="bornDate">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashBorn" Text="Born" runat="server" meta:resourcekey="lblWashBornResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalBorn" runat="server" meta:resourcekey="txtWashLocalBornResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroBorn" runat="server" meta:resourcekey="txtWashEniroBornResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashBorn" runat="server" meta:resourcekey="chkWashBornResource1"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="inline fields" id="ssnNo">
                            <div class="four wide field">
                                <label>
                                    <asp:Label ID="lblWashSsnNo" Text="SSN No" runat="server" meta:resourcekey="lblWashSsnNoResource1"></asp:Label></label>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashLocalSsnNo" runat="server" meta:resourcekey="txtWashLocalSsnNoResource1"></asp:TextBox>
                            </div>
                            <div class="five wide field">
                                <asp:TextBox ID="txtWashEniroSsnNo" runat="server" meta:resourcekey="txtWashEniroSsnNoResource1"></asp:TextBox>
                            </div>
                            <div class="two wide field">
                                <asp:CheckBox ID="chkWashSsnNo" runat="server" meta:resourcekey="chkWashSsnNoResource1"></asp:CheckBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="actions">
            <div class="ui button ok positive"><%=GetLocalResourceObject("divUpdate")%></div>
            <div class="ui button cancel negative"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>


    <div class="ui tiny modal" id="modCustNotes">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divNotes")%></div>
        <div class="content">

            <div class="ui form">
                <div class="field">
                    <label class="sr-only">'<%=GetLocalResourceObject("headNote")%>'</label><%--Notat--%>
                    <div class="ui small info message">
                        <p id="P1" runat="server"><%=GetLocalResourceObject("headPostNote")%></p><%--Legg inn notater på kunden.--%>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="sixteen wide field">
                                <label for="txtNotes">
                                    <asp:Literal ID="liNotes" Text="Notes" runat="server" meta:resourcekey="liNotesResource1"></asp:Literal>
                                </label>
                                <asp:TextBox runat="server" ID="txtNotes" TextMode="MultiLine" CssClass="texttest" Height="181px" data-submit="CUST_NOTES" meta:resourcekey="txtNotesResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            &nbsp;
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="actions">
            <div class="ui approve success button" id="btnCustNotesSave"><%=GetLocalResourceObject("divApprove")%></div>

            <div class="ui cancel button" id="btnCustNotesCancel"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>
    <%-- Customer notes Modal --%>

    <div class="ui tiny modal" id="modSendSms">
        <div class="header" style="text-align: center">'<%=GetLocalResourceObject("CMSendSms")%>'</div>
        <div class="content">

            <div class="ui form">
                <div class="field">
                    <label class="sr-only">'<%=GetLocalResourceObject("headNote")%>'</label><%--Notat--%>
                    <div class="ui small info message">
                        <p id="P2" runat="server">'<%=GetLocalResourceObject("headSendSms")%>'</p><%--Legg inn tekst du ønsker å sende til kunde--%>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="sixteen wide field">
                                
                                <asp:TextBox runat="server" ID="txtSendSms" TextMode="MultiLine" CssClass="carsInput" Height="181px" meta:resourcekey="txtNotesResource1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="six wide field"> 
                                <asp:TextBox runat="server" ID="txtNumberSms" CssClass="carsInput" meta:resourcekey="txtNumberSmsResource1" ></asp:TextBox>
                            </div>
                        </div>
                        <div class="fields">
                            &nbsp;
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="actions">
            <div class="ui approve success button" id="btnSendSMS">'<%=GetLocalResourceObject("CMSendSms")%>'</div>

            <div class="ui cancel button" id="btnSendSMSCancel"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>
    <%-- Customer send sms Modal --%>


    <%-- Contact Preferences Modal --%>
    <div class="ui tiny modal" id="modal_contactPreferences">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divInvoiceAndContactTerms")%></div>
        <div class="content">
            <div class="ui grid">
                <div class="eight wide column">
                    <div class="ui form">
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkEinvoice" runat="server" Text="EHF-Faktura" data-submit="FLG_EINVOICE" meta:resourcekey="chkEinvoiceResource" />
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkInvEmail" runat="server" Text="Invoice by email" data-submit="FLG_INV_EMAIL" meta:resourcekey="chkInvEmailResource" />
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkOrdconfEmail" runat="server" Text="Order confirmation by email" data-submit="FLG_ORDCONF_EMAIL" meta:resourcekey="chkOrdconfEmailResource" />
                            </div>
                        </div>
                       
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvCustIgnoreInv" runat="server" Text="No Invoice Fee" data-submit="FLG_NO_INVOICEFEE" meta:resourcekey="chkAdvCustIgnoreInvResource1" />
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvBankgiro" runat="server" data-submit="FLG_BANKGIRO" Text="Bankgiro" meta:resourcekey="chkAdvBankgiroResource1" />
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvCustFactoring" runat="server" Text="Factoring" data-submit="FLG_CUST_FACTORING" meta:resourcekey="chkAdvCustFactoringResource1" />
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvCustBatchInv" runat="server" Text="Batch Invoicing" data-submit="FLG_CUST_BATCHINV" meta:resourcekey="chkAdvCustBatchInvResource1" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="eight wide column">
                    <div class="ui form">
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvHourlyMarkup" runat="server" Text="Hourly Markup" data-submit="FLG_HOURLY_ADD" meta:resourcekey="chkAdvHourlyMarkupResource1" />
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvNoGm" runat="server" Text="No Garage Material" data-submit="FLG_NO_GM" meta:resourcekey="chkAdvNoGmResource1" />
                            </div>
                        </div>
                       
                        <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvNoEnv" runat="server" Text="No Env. Fee" data-submit="FLG_NO_ENV_FEE" meta:resourcekey="chkAdvNoEnvResource1" />
                            </div>
                        </div>
                         <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkNoAddCost" runat="server" Text="Ikke påkost" data-submit="FLG_NO_ADDITIONAL_COST" meta:resourcekey="chkNoAddCostResource1"  />
                            </div>
                        </div>
                         <div class="field">
                               <div class="ui checkbox">
                                <asp:CheckBox ID="chkNoHistoryPublish" runat="server" Text="Ikke publiser historikk" data-submit="FLG_NO_HISTORY_PUBLISH" meta:resourcekey="chkNoHistoryPublishResource1"  />
                            </div>
                         </div>
                        <div class="field">&nbsp;</div>
                         <div class="field">
                            <div class="ui checkbox">
                                <asp:CheckBox ID="chkAdvCustInactive" runat="server" Text="Inactive" data-submit="FLG_CUST_INACTIVE" meta:resourcekey="chkAdvCustInactiveResource1" />
                            </div>
                        </div>
                    </div>
                </div>
                  <div class="sixteen wide column">
                      <div class="ui divider"></div>
                      <h3 style="margin-top: -1em;text-align: center;"><%=GetLocalResourceObject("divInvoiceAddress")%></h3>
                       <div class="ui form">
                        <div class="fields">
                             <div class="four wide field">
                              <asp:Label ID="Label16" Text="Kundenr" runat="server" Style="font-weight: 900 !important" meta:resourcekey="Label16Resource1"></asp:Label>
                              <asp:TextBox ID="txtInvCustAdd" data-submit="CUST_NO_INV_ADDRESS" runat="server" CssClass="carsInput" meta:resourcekey="txtInvCustAddResource1"></asp:TextBox>
                            </div>
                            <div class="eight wide field">
                              <asp:Label ID="lblInvAddCustName" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblInvAddCustNameResource1"></asp:Label>
                                <br />
                              <asp:Label ID="lblInvAddCustVisit" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblInvAddCustVisitResource1"></asp:Label>
                              <asp:Label ID="lblInvAddCustZipPlace" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblInvAddCustZipPlaceResource1"></asp:Label>
                                <br />
                                  <asp:Label ID="lblInvAddCustPostAdd" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblInvAddCustPostAddResource1"></asp:Label>
                              <asp:Label ID="lblInvAddCustPostZipPlace" runat="server" Style="font-weight: 900 !important" meta:resourcekey="lblInvAddCustPostZipPlaceResource1"></asp:Label>
                            </div>
                            <div class="four wide field">
                            
                            </div>
                            </div>
                           </div>
                  </div>
            </div>

        </div>
        <div class="actions">
            <div class="ui approve success button"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui button"><%=GetLocalResourceObject("divNeutral")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>

    <div class="ui tiny modal" id="modal_gdpr">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divMarketing")%></div>
        <div class="content">
         
            <div class="ui form">
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="lblApprovedValues" runat="server" Text="Godkjente utsendelser" meta:resourcekey="lblApprovedValuesResource1" />
                        </div>
                    <div class="five wide column">
                        <asp:Label ID="lblSMSOption" runat="server" Text="SMS" meta:resourcekey="lblSMSOptionResource1"  />
                    </div>
                    <div class="five wide column">
                        <asp:Label ID="lblMailOptions" runat="server" Text="Epost" meta:resourcekey="lblMailOptionsResource1" />
 
                    </div>
                </div>
                <div class="fields">
                    <div class="sixteen wide column">
                        &nbsp;
                        <div class="ui divider"></div>
                        </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label871" runat="server" Text="Manuell" meta:resourcekey="Label871Resource1"/>
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkManualSms" runat="server" Text="SMS" data-submit="MANUAL_SMS" meta:resourcekey="chkManualSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkManualMail" runat="server" Text="Epost" data-submit="MANUAL_MAIL" meta:resourcekey="chkManualMailResource1"  />
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label961" runat="server" Text="Innkalling til PKK" meta:resourcekey="Label961Resource1" />
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkPkkSms" runat="server" Text="SMS" data-submit="PKK_SMS" meta:resourcekey="chkPkkSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkPkkMail" runat="server" Text="Epost" data-submit="PKK_MAIL" meta:resourcekey="chkPkkMailResource1"  />
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label361" runat="server" Text="Serviceinnkalling" meta:resourcekey="Label361Resource1" />
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkServiceSms" runat="server" Text="SMS" data-submit="SERVICE_SMS" meta:resourcekey="chkServiceSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkServiceMail" runat="server" Text="Epost" data-submit="SERVICE_MAIL" meta:resourcekey="chkServiceMailResource1" />
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label111" runat="server" Text="Utsendelse av tilbud" meta:resourcekey="Label111Resource1" />
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkBargainSms" runat="server" Text="SMS" data-submit="BARGAIN_SMS" meta:resourcekey="chkBargainSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkBargainMail" runat="server" Text="Epost" data-submit="BARGAIN_MAIL" meta:resourcekey="chkBargainMailResource1" />
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label1251" runat="server" Text="Xtrasjekk" meta:resourcekey="Label1251Resource1" />
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkXtracheckSms" runat="server" Text="SMS" data-submit="XTRACHECK_SMS" meta:resourcekey="chkXtracheckSmsResource1"  />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkXtracheckMail" runat="server" Text="Epost" data-submit="XTRACHECK_MAIL" meta:resourcekey="chkXtracheckMailResource1" />
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label12519" runat="server" Text="Påminnelse" meta:resourcekey="Label12519Resource1" />
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkReminderSms" runat="server" Text="SMS" data-submit="REMINDER_SMS" meta:resourcekey="chkReminderSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkReminderMail" runat="server" Text="Epost" data-submit="REMINDER_MAIL" meta:resourcekey="chkReminderMailResource1"/>
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label1621" runat="server" Text="Informasjon" meta:resourcekey="Label1621Resource1"/>
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkInfoSms" runat="server" Text="SMS" data-submit="INFO_SMS" meta:resourcekey="chkInfoSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkInfoMail" runat="server" Text="Epost" data-submit="INFO_MAIL" meta:resourcekey="chkInfoMailResource1" />
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label121" runat="server" Text="Oppfølging" meta:resourcekey="Label121Resource1" />
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkFollowupSms" runat="server" Text="SMS" data-submit="FOLLOWUP_SMS" meta:resourcekey="chkFollowupSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkFollowupMail" runat="server" Text="Epost" data-submit="FOLLOWUP_MAIL" meta:resourcekey="chkFollowupMailResource1" />
                                        </div>

                    </div>
                </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="Label1221" runat="server" Text="Markedsføring" meta:resourcekey="Label1221Resource1" />
                        </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkMarketingSms" runat="server" Text="SMS" data-submit="MARKETING_SMS" meta:resourcekey="chkMarketingSmsResource1" />
                                    </div>
                    </div>
                    <div class="five wide column">
                        <div class="ui checkbox">
                            <asp:CheckBox ID="chkMarketingMail" runat="server" Text="Epost" data-submit="MARKETING_MAIL" meta:resourcekey="chkMarketingMailResource1" />
                                        </div>

                    </div>
                </div>
                  <div class="fields">
                  <div class="sixteen wide column">
                        &nbsp;
                        <div class="ui divider"></div>
                        </div>
                      </div>
                <div class="fields">
                    <div class="five wide column">
                        <asp:Label ID="lblResponseDate" runat="server" Text="Responsdato" meta:resourcekey="lblResponseDateResource1"  />
                        </div>
                    <div class="four wide column">
                            <asp:TextBox ID="txtGdprResponseDate" runat="server" data-submit="DT_RESPONSE" cssClass="carsInput" meta:resourcekey="txtGdprResponseDateResource1" />     
                    </div>
                    <div class="four wide column">
                          <asp:TextBox ID="txtGdprResponseId" runat="server" data-submit="RESPONSE_ID" cssClass="carsInput" />
                    </div>
                    
                </div>
            </div>

        </div>

               
        <div class="actions">
            <div class="ui success button" id="btnSendGDPR"><%=GetLocalResourceObject("divSendSMS")%></div>
            <div class="ui success button" id="btnCheckAllGdpr"><%=GetLocalResourceObject("divAll")%></div>
            <div class="ui success button" id="btnUncheckAllGdpr"><%=GetLocalResourceObject("divClear")%></div>
            <div class="ui approve success button" id="btnSaveGDPR"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divClose")%></div>
        </div>
    </div>


    <div class="ui tiny modal" id="modal_what">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divBonus")%></div>
        <div class="content">
            <div class="ui form">
                <div class="fields">
                    <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvNewCustomer" Text="New customer" runat="server" meta:resourcekey="lblAdvNewCustomerResource1"></asp:Label>
                    </div>
                    <div class="five wide field">
                        <asp:TextBox ID="txtAdvNewCustomer" runat="server" meta:resourcekey="txtAdvNewCustomerResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvVendor" Text="Dealer" runat="server" meta:resourcekey="lblAdvVendorResource1"></asp:Label>
                    </div>
                    <div class="five wide field">
                        <asp:TextBox ID="txtAdvVendor" runat="server" meta:resourcekey="txtAdvVendorResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvFree" Text="Free" runat="server" meta:resourcekey="lblAdvFreeResource1"></asp:Label>
                    </div>
                    <div class="five wide field">
                        <asp:TextBox ID="txtAdvFree" runat="server" meta:resourcekey="txtAdvFreeResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvTruck" Text="Truck/Bus" runat="server" meta:resourcekey="lblAdvTruckResource1"></asp:Label>
                    </div>
                    <div class="five wide field">
                        <asp:TextBox ID="txtAdvTruck" runat="server" meta:resourcekey="txtAdvTruckResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvBonusmember" Text="Bonus member" runat="server" meta:resourcekey="lblAdvBonusmemberResource1"></asp:Label>
                    </div>
                    <div class="five wide field">
                        <asp:TextBox ID="txtAdvBonusmember" runat="server" meta:resourcekey="txtAdvBonusmemberResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvSumBonus" Text="Sum bonus" runat="server" meta:resourcekey="lblAdvSumBonusResource1"></asp:Label>
                    </div>
                    <div class="five wide field">
                        <asp:TextBox ID="txtAdvSumBonus" runat="server" meta:resourcekey="txtAdvSumBonusResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions">
            <div class="ui approve success button"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui button"><%=GetLocalResourceObject("divNeutral")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>

    <div class="ui tiny modal" id="modal_bilxtra">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divBilXtra")%></div>
        <div class="content">
            <div class="ui form">
                <div class="fields">
                    <h3><%=GetLocalResourceObject("hdrBilXtraCoordination")%></h3>
                    </div>
                   <div class="fields">
                    <div class="four wide field">
                        <asp:Label ID="lblBilxtraGrossist" Text="Grossistnr" runat="server" meta:resourcekey="lblBilxtraGrossistResource1"></asp:Label>
                    </div>
                    <div class="four wide field">
                        <asp:TextBox ID="txtBilxtraGrossist" data-submit="BILXTRA_GROSS_NO" runat="server" CssClass="carsInput" meta:resourcekey="txtBilxtraGrossistResource1"></asp:TextBox>
                    </div>
                      <div class="two wide field">
                          &nbsp;
                      </div>
                    
                </div>
                <div class="fields">
                    <div class="four wide field">
                        <asp:Label ID="lblBilxtraShopNo" Text="Verkstednr" runat="server" meta:resourcekey="lblBilxtraShopNoResource1" ></asp:Label>
                    </div>
                    <div class="four wide field">
                        <asp:TextBox ID="txtBilxtraShopNo" data-submit="BILXTRA_WORKSHOP_NO" runat="server" CssClass="carsInput" meta:resourcekey="txtBilxtraShopNoResource1"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="four wide field">
                        <asp:Label ID="lblBilxtraExternalNo" Text="Eksternt kundenr" runat="server" meta:resourcekey="lblBilxtraExternalNoResource1"></asp:Label>
                    </div>
                    <div class="four wide field">
                        <asp:TextBox ID="txtBilxtraExternalNo" data-submit="BILXTRA_EXT_CUST_NO" runat="server" CssClass="carsInput" meta:resourcekey="txtBilxtraExternalNoResource1"></asp:TextBox>
                    </div>
                </div>
                   <div class="fields">
                       <h3><%=GetLocalResourceObject("labelWarrantyHandling")%></h3>
                   </div>
                <div class="fields">
                    
                    <div class="four wide field">
                        <label>
                        <asp:CheckBox ID="chkBilxtraWarranty" data-submit="BILXTRA_WARRANTY_HANDLING" runat="server" Width="200%" Text="Garantibeh." meta:resourcekey="chkBilxtraWarrantyResource1"  />
                    </label>
                    </div>
                    
                </div>
                <div class="fields">
                    <div class="four wide field">
                        <asp:Label ID="lblBilxtraSupplier" Text="Leverandør" runat="server" meta:resourcekey="lblBilxtraSupplierResource1"></asp:Label>
                    </div>
                    <div class="four wide field">
                        <asp:TextBox ID="txtBilxtraSupplier" data-submit="BILXTRA_WARRANTY_SUPPLIER_NO" runat="server" CssClass="carsInput" meta:resourcekey="txtBilxtraSupplierResource1"></asp:TextBox>
                    </div>
                      <div class="eight wide field">
                        <asp:Label ID="lblBilxtraSupplierName" runat="server" meta:resourcekey="lblBilxtraSupplierNameResource1"></asp:Label>
                    </div>
                </div>
                
            </div>
        </div>
        <div class="actions">
            <div class="ui approve success button"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui button"><%=GetLocalResourceObject("divNeutral")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>

    <div class="ui tiny modal" id="modal_discountetc">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divDiscount")%> etc.</div> 
        <div class="content">
            <div class="ui form ">
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvGeneralDiscount" runat="server" Text="General %" meta:resourcekey="lblAdvGeneralDiscountResource1"></asp:Label>
                        <asp:TextBox ID="txtAdvGeneralDiscount" runat="server" data-submit="CUST_DISC_GENERAL" meta:resourcekey="txtAdvGeneralDiscountResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvSparesDiscount" runat="server" Text="Parts %" meta:resourcekey="lblAdvSparesDiscountResource1"></asp:Label>
                        <asp:TextBox ID="txtAdvSparesDiscount" runat="server" data-submit="CUST_DISC_SPARES" meta:resourcekey="txtAdvSparesDiscountResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                    <div class="four wide field">
                        <asp:Label ID="lblAdvLabourDiscount" runat="server" Text="Labour %" meta:resourcekey="lblAdvLabourDiscountResource1"></asp:Label>
                        <asp:TextBox ID="txtAdvLabourDiscount" runat="server" data-submit="CUST_DISC_LABOUR" meta:resourcekey="txtAdvLabourDiscountResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvPriceType" runat="server" Text="Price type" meta:resourcekey="lblAdvPriceTypeResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <select id="cmbAdvPriceType" runat="server" data-submit="CUST_PRICE_TYPE" class="carsInput">
                            <option value="0">Cost price</option>
                            <option value="1">Net price</option>
                            <option value="2" selected="selected">Sales price</option>
                            <option value="3">Retail price</option>
                        </select>
                    </div>
                </div>
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvEmployees" Text="No of employees" runat="server" meta:resourcekey="lblAdvEmployeesResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <asp:TextBox ID="txtAdvEmployees" data-submit="CUST_EMPLOYEE_NO" runat="server" meta:resourcekey="txtAdvEmployeesResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvSsnNo" Text="Org.no." runat="server" meta:resourcekey="lblAdvSsnNoResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <asp:TextBox ID="txtAdvSsnNo" runat="server" data-submit="CUST_SSN_NO" meta:resourcekey="txtAdvSsnNoResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>

                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvCreditLimit" Text="Credit limit" runat="server" meta:resourcekey="lblAdvCreditLimitResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <asp:TextBox ID="txtAdvCredlimit" data-submit="CUST_CREDIT_LIMIT" runat="server" meta:resourcekey="txtAdvCredlimitResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvSumOrder" Text="Sum on orders" runat="server" meta:resourcekey="lblAdvSumOrderResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <asp:TextBox ID="txtAdvSumOrder" runat="server" meta:resourcekey="txtAdvSumOrderResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvSumInvoice" Text="Sum invoiced" runat="server" meta:resourcekey="lblAdvSumInvoiceResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <asp:TextBox ID="txtAdvSumInvoice" runat="server" meta:resourcekey="txtAdvSumInvoiceResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvBalance" Text="Balance" runat="server" meta:resourcekey="lblAdvBalanceResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <asp:TextBox ID="txtAdvBalance" runat="server" meta:resourcekey="txtAdvBalanceResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">
                    <div class="one wide field"></div>
                    <div class="five wide field">
                        <asp:Label ID="lblAdvRemainingCredit" data-submit="CUST_UNUTIL_CREDIT" Text="Remaining credit" runat="server" meta:resourcekey="lblAdvRemainingCreditResource1"></asp:Label>
                    </div>
                    <div class="seven wide field">
                        <asp:TextBox ID="txtAdvRemainingCredit" runat="server" meta:resourcekey="txtAdvRemainingCreditResource1" CssClass="carsInput"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions">
            <div class="ui approve success button"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui button"><%=GetLocalResourceObject("divNeutral")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>


    <div class="ui small modal" id="modal_equipment">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divEquipment")%></div>
        <div class="content">
            <div class="ui form ">
            <div class="fields">
                <div class="two wide column">
                    <label>
                        <asp:CheckBox ID="cbSummerwheels" runat="server" Width="200%" Text="Summer wheels" meta:resourcekey="cbSummerwheelsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbWinterwheels" runat="server" Width="200%" Text="Winter wheels" meta:resourcekey="cbWinterwheelsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbXenon" runat="server" Width="200%" Text="Xenon lights" meta:resourcekey="cbXenonResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbCentrallock" runat="server" Width="200%" Text="Central lock" meta:resourcekey="cbCentrallockResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbElWindows" runat="server" Width="200%" Text="El.windows" meta:resourcekey="cbElWindowsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbElMirrors" runat="server" Width="200%" Text="El.mirrors" meta:resourcekey="cbElMirrorsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbColoredglass" runat="server" Width="200%" Text="Colored glass" meta:resourcekey="cbColoredglassResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbHeatedseats" runat="server" Width="200%" Text="Heated seats" meta:resourcekey="cbHeatedseatsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAlloyrimswinter" runat="server" Width="200%" Text="Alloy rims winter" meta:resourcekey="cbAlloyrimswinterResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAlloywheelssummer" runat="server" Width="200%" Text="Alloy rims summer" meta:resourcekey="cbAlloywheelssummerResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAllyeartires" runat="server" Width="200%" Text="All year tires" meta:resourcekey="cbAllyeartiresResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbServo" runat="server" Width="200%" Text="Servo steering" meta:resourcekey="cbServoResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAirbagfront" runat="server" Width="200%" Text="Airbag front" meta:resourcekey="cbAirbagfrontResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAirbagside" runat="server" Width="200%" Text="Airbag sides" meta:resourcekey="cbAirbagsideResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbSkylight" runat="server" Width="200%" Text="Skylight" meta:resourcekey="cbSkylightResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbClimate" runat="server" Width="200%" Text="Climate control" meta:resourcekey="cbClimateResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAircondition" runat="server" Width="200%" Text="Aircondition" meta:resourcekey="cbAirconditionResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbMetallic" runat="server" Width="200%" Text="Metallic" meta:resourcekey="cbMetallicResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbRadioCD" runat="server" Width="200%" Text="Radio/CD" meta:resourcekey="cbRadioCDResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbCDchanger" runat="server" Width="200%" Text="CD-changer" meta:resourcekey="cbCDchangerResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbDVD" runat="server" Width="200%" Text="DVD" meta:resourcekey="cbDVDResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbTowinghitch" runat="server" Width="200%" Text="Towing hitch" meta:resourcekey="cbTowinghitchResource1" />
                    </label>
                </div>
                <div class="two wide column">
                    <label>
                        <asp:CheckBox ID="CheckBox1" runat="server" Width="200%" Text="ABS brakes" meta:resourcekey="cbABSbrakesResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox2" runat="server" Width="200%" Text="Traction control" meta:resourcekey="cbTractionResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox3" runat="server" Width="200%" Text="Anti-skid" meta:resourcekey="cbAntiskidResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox4" runat="server" Width="200%" Text="Engine immobilizer" meta:resourcekey="cbImmobilizerResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox5" runat="server" Width="200%" Text="Differential lock" meta:resourcekey="cbDifflockResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox6" runat="server" Width="200%" Text="Steel beams" meta:resourcekey="cbSteelbeamsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox7" runat="server" Width="200%" Text="Cruise control" meta:resourcekey="cbCruisecontrolResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox8" runat="server" Width="200%" Text="Alarm" meta:resourcekey="cbAlarmResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox9" runat="server" Width="200%" Text="Engine heater" meta:resourcekey="cbEngineheaterResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox10" runat="server" Width="200%" Text="Leather interior" meta:resourcekey="CheckBox33Resource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox11" runat="server" Width="200%" Text="Partial leather" meta:resourcekey="CheckBox34Resource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbABSbrakes" runat="server" Width="200%" Text="ABS brakes" meta:resourcekey="cbABSbrakesResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbTraction" runat="server" Width="200%" Text="Traction control" meta:resourcekey="cbTractionResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAntiskid" runat="server" Width="200%" Text="Anti-skid" meta:resourcekey="cbAntiskidResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbImmobilizer" runat="server" Width="200%" Text="Engine immobilizer" meta:resourcekey="cbImmobilizerResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbDifflock" runat="server" Width="200%" Text="Differential lock" meta:resourcekey="cbDifflockResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbSteelbeams" runat="server" Width="200%" Text="Steel beams" meta:resourcekey="cbSteelbeamsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbCruisecontrol" runat="server" Width="200%" Text="Cruise control" meta:resourcekey="cbCruisecontrolResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAlarm" runat="server" Width="200%" Text="Alarm" meta:resourcekey="cbAlarmResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbEngineheater" runat="server" Width="200%" Text="Engine heater" meta:resourcekey="cbEngineheaterResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox33" runat="server" Width="200%" Text="Leather interior" meta:resourcekey="CheckBox33Resource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="CheckBox34" runat="server" Width="200%" Text="Partial leather" meta:resourcekey="CheckBox34Resource1" />
                    </label>
                </div>
                <div class="two wide column">
                    <label>
                        <asp:CheckBox ID="cbTV" runat="server" Width="200%" Text="TV" meta:resourcekey="cbTVResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbSportingseats" runat="server" Width="200%" Text="Sporting seats" meta:resourcekey="cbSportingseatsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbCargorails" runat="server" Width="200%" Text="Cargo rails" meta:resourcekey="cbCargorailsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAirsuspension" runat="server" Width="200%" Text="Air suspension" meta:resourcekey="cbAirsuspensionResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbLevelling" runat="server" Width="200%" Text="Levelling" meta:resourcekey="cbLevellingResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbComputer" runat="server" Width="200%" Text="Computer" meta:resourcekey="cbComputerResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbRainsensor" runat="server" Width="200%" Text="Rain sensor" meta:resourcekey="cbRainsensorResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbLuggagecompcover" runat="server" Width="200%" Text="Luggage comp. cover" meta:resourcekey="cbLuggagecompcoverResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbKeyless" runat="server" Width="200%" Text="Keyless go" meta:resourcekey="cbKeylessResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbRemtowinghitch" runat="server" Width="200%" Text="Removable towing hitch" meta:resourcekey="cbRemtowinghitchResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbDieselfilter" runat="server" Width="200%" Text="Diesel particle filter" meta:resourcekey="cbDieselfilterResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbRoofSkirails" runat="server" Width="200%" Text="Roof-/ski rails" meta:resourcekey="cbRoofSkirailsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbNavigation" runat="server" Width="200%" Text="Navigation system" meta:resourcekey="cbNavigationResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbParksensorfront" runat="server" Width="200%" Text="Parking sensor front" meta:resourcekey="cbParksensorfrontResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbParksensorrear" runat="server" Width="200%" Text="Parking sensor rear" meta:resourcekey="cbParksensorrearResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbMultifuncsteering" runat="server" Width="200%" Text="Multifunc. steering wheel" meta:resourcekey="cbMultifuncsteeringResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbElseatmemory" runat="server" Width="200%" Text="El. seat w/memory" meta:resourcekey="cbElseatmemoryResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbElseat" runat="server" Width="200%" Text="El. seat" meta:resourcekey="cbElseatResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbHandsfree" runat="server" Width="200%" Text="Handsfree" meta:resourcekey="cbHandsfreeResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbArmrests" runat="server" Width="200%" Text="Armrests" meta:resourcekey="cbArmrestsResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbOriginalphone" runat="server" Width="200%" Text="Original telephone" meta:resourcekey="cbOriginalphoneResource1" />
                    </label>
                    <label>
                        <asp:CheckBox ID="cbAnnualfeepaid" runat="server" Width="200%" Text="Annual fee paid" meta:resourcekey="cbAnnualfeepaidResource1" />
                    </label>
                </div>
                <div class="two wide column">
                    <label>
                        <asp:CheckBox ID="cbFullservicehistory" runat="server" Width="200%" Text="Full service history" meta:resourcekey="cbFullservicehistoryResource1" />
                    </label>
                    <%--<label>
                                        <asp:CheckBox ID="CheckBox58" runat="server" Width="200%" Text="Bankgiro" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox59" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox60" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox61" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox62" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox63" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox64" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox65" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox66" runat="server" Width="200%" Text="factoring" />
                                    </label>
                                    <label>
                                        <asp:CheckBox ID="CheckBox67" runat="server" Width="200%" Text="factoring" />
                                    </label>--%>
                </div>
            </div>
</div>

        </div>
        <div class="actions">
            <div class="ui approve success button"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui button"><%=GetLocalResourceObject("divNeutral")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>


    <%-- Company reference Modal --%>
    <div class="ui small modal" id="modal_companyreference">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divCompanyReferences")%></div>
        <div class="content">
            <div class="ui form ">
                <div class="fields">

                    <div class="four wide field">
                        <asp:Label ID="lblCompanyPersonFind" Text="Search below to add a company..." runat="server" CssClass="centerlabel" meta:resourcekey="lblCompanyPersonFindResource1"></asp:Label>
                        <asp:TextBox ID="txtCompanyPersonFind" runat="server" CssClass="texttest" meta:resourcekey="txtCompanyPerson2Resource1"></asp:TextBox>
                    </div>
                </div>
                <div class="fields">

                    <div class="four wide field">
                        <asp:Label ID="lblCompanyPersonNo" Text="Company&nbspassociation" runat="server" meta:resourcekey="lblCompanyPersonResource1"></asp:Label>
                        <asp:TextBox ID="txtCompanyPerson" runat="server" CssClass="texttest" data-submit="CUST_COMPANY_NO" meta:resourcekey="txtCompanyPersonResource1"></asp:TextBox>
                    </div>
                    <div class="eight wide field">
                        <asp:Label ID="lblCompanyNameHead" Text="Company name" runat="server" meta:resourcekey="lblCompanyNameHeadResource1"></asp:Label><br />
                        <b>
                            <label id="lblCompanyPersonName" data-submit="CUST_COMPANY_DESCRIPTION">Ingen tilknytning.</label></b>

                    </div>
                </div>


                <div class="fields">
                    <div class="eight wide field">
                        <asp:Label ID="lblEmployees" Text="Employees" runat="server" CssClass="centerlabel" meta:resourcekey="lblEmployeesResource1"></asp:Label>
                        <select id="ddlCompanyList" runat="server" size="10" class="wide dropdownList"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions">
            <div class="ui approve success button"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui button"><%=GetLocalResourceObject("divNeutral")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divCancel")%></div>
        </div>
    </div>


    <%-- Dates Modal --%>
    <div class="ui small modal" id="modal_dates">
        <div class="header" style="text-align: center"><%=GetLocalResourceObject("divDate")%></div>
        <div class="content">
            <div class="ui form ">
                <div class="fields">
                      <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="lblBirthDate" runat="server" Text="Birth date" CssClass="centerlabel" meta:resourcekey="lblBirthDateResource1"></asp:Label>
                        <asp:TextBox ID="txtBirthDate" runat="server" CssClass="carsInput" data-submit="CUST_BORN" meta:resourcekey="txtBirthDateResource1"></asp:TextBox>
                    </div>
                    <div class="four wide field">
                         <asp:Label ID="lblWashDate" runat="server" Text="Wash date" CssClass="centerlabel" meta:resourcekey="lblWashDateResource1"></asp:Label>
                        <asp:TextBox ID="txtWashDate" runat="server" data-submit="DT_CUST_WASH" CssClass="carsInput" meta:resourcekey="txtWashDateResource1"></asp:TextBox>
                    </div>
                      <div class="four wide field">
                          <asp:Label ID="lblDeathDate" runat="server"  Text="Death date" CssClass="centerlabel" meta:resourcekey="lblDeathDateResource1"></asp:Label>
                        <asp:TextBox ID="txtDeathDate" runat="server" data-submit="DT_CUST_DEATH" CssClass="carsInput" meta:resourcekey="txtDeathDateResource1"></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                </div>
                <div class="fields">
                    &nbsp;
                     <div class="sixteen wide field">
                      
                     </div>                   
                </div>
                   <div class="ui divider"></div>
                 <div class="fields">
                      <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="Label1" runat="server" Text="Siste kontakt dato" CssClass="centerlabel" meta:resourcekey="Label1Resource2" ></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="carsInput" meta:resourcekey="TextBox1Resource1"></asp:TextBox>
                    </div>
                    <div class="four wide field">
                         <asp:Label ID="Label9" runat="server" Text="Responsdato" CssClass="centerlabel" meta:resourcekey="Label9Resource1" ></asp:Label>
                        <asp:TextBox ID="txtResponseDate" runat="server" CssClass="carsInput" meta:resourcekey="txtResponseDateResource1" ></asp:TextBox>
                    </div>
                      <div class="four wide field">
                                              </div>
                      <div class="two wide field"></div>
                </div>
               <div class="fields">
                      <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="Label10" runat="server" Text="Siste oppfølging" CssClass="centerlabel" meta:resourcekey="Label10Resource1"></asp:Label>
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="carsInput" Enabled="False" meta:resourcekey="TextBox4Resource1"></asp:TextBox>
                    </div>
                    <div class="four wide field">
                         <asp:Label ID="Label11" runat="server" Text="Type oppfølging" CssClass="centerlabel" meta:resourcekey="Label11Resource1"></asp:Label>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="carsInput" Enabled="False" meta:resourcekey="TextBox5Resource1"></asp:TextBox>
                    </div>
                      <div class="four wide field">
                          <asp:Label ID="Label12" runat="server" Text="Oppfølging sign." CssClass="centerlabel" meta:resourcekey="Label12Resource1"></asp:Label>
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="carsInput" Enabled="False" meta:resourcekey="TextBox6Resource1"></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                </div>
                <div class="fields">
                      <div class="two wide field"></div>
                    <div class="four wide field">
                        <asp:Label ID="Label13" runat="server" Text="Neste oppfølging" CssClass="centerlabel" meta:resourcekey="Label13Resource1" ></asp:Label>
                        <asp:TextBox ID="TextBox7" runat="server" CssClass="carsInput" Enabled="False" meta:resourcekey="TextBox7Resource2"></asp:TextBox>
                    </div>
                    <div class="four wide field">
                         <asp:Label ID="Label14" runat="server" Text="Type oppfølging" CssClass="centerlabel" meta:resourcekey="Label14Resource1"></asp:Label>
                        <asp:TextBox ID="TextBox8" runat="server" CssClass="carsInput" Enabled="False" meta:resourcekey="TextBox8Resource2" ></asp:TextBox>
                    </div>
                      <div class="four wide field">
                          <asp:Label ID="Label15" runat="server" Text="Oppfølging sign." CssClass="centerlabel" meta:resourcekey="Label15Resource1"></asp:Label>
                        <asp:TextBox ID="TextBox9" runat="server" CssClass="carsInput" Enabled="False" meta:resourcekey="TextBox9Resource2" ></asp:TextBox>
                      </div>
                      <div class="two wide field"></div>
                </div>

                </div>
            </div>
      


        <div class="actions">
            <div class="ui approve success button"><%=GetLocalResourceObject("divApprove")%></div>
            <div class="ui button"><%=GetLocalResourceObject("divNeutral")%></div>
            <div class="ui cancel button"><%=GetLocalResourceObject("divCancel")%></div>
        </div>


    </div>




    <%-- Salesman Modal --%>
    <div id="modAdvSalesman" class="modal hidden">
        <div class="modHeader">
            <h2 id="lblAdvSalesman" runat="server"><%=GetLocalResourceObject("labelSeller")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("labNewVeh")%></label>
                    <div class="ui small info message">
                        <p id="lblAdvSalesmanStatus" runat="server"><%=GetLocalResourceObject("labelSeller")%> <%=GetLocalResourceObject("divStatus")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblNewUsed" runat="server"><%=GetLocalResourceObject("labNewOrUsed")%></label>
                                <select id="drpSalesman" runat="server" size="13" class="wide dropdownList"></select>
                                <%--<select id="ddlSalesman" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemNewVehicle">Nytt kjøretøy</option>
                                    <option value="1" id="ddlItemNewImportVehicle">Import Bil</option>
                                    <option value="2" selected="selected" id="ddlItemUsedVehicle">Brukt Bil</option>
                                    <option value="3" id="ddlItemNewElVehicle">Ny Elbil</option>
                                    <option value="4" id="ddlItemNewMachine">Ny maskin</option>
                                    <option value="5" id="ddlItemUsedMachine">Brukt maskin</option>
                                    <option value="6" id="ddlItemNewBoat">Ny Båt</option>
                                    <option value="7" id="ddlItemUsedBoat">Brukt Båt</option>
                                    <option value="8" id="ddlItemNewHouseCar">Ny Bobil</option>
                                    <option value="9" id="ddlItemUsedHouseCar">Brukt Bobil</option>
                                    <option value="10" id="ddlItemRentalVehicle">Leiebil</option>
                                    <option value="11" id="ddlItemCommisionUsed">Kommisjon brukt</option>
                                    <option value="12" id="ddlItemCommissionNew">Kommisjon ny</option>
                                </select>--%>
                            </div>



                            <div class="five wide field">
                                <asp:Label ID="lblAdvSalesmanCode" Text="Kode" runat="server" meta:resourcekey="lblAdvSalesmanCodeResource1"></asp:Label>
                                <div class="ui mini input">
                                    <asp:TextBox ID="txtAdvSalesmanLogin" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesmanLoginResource1"></asp:TextBox>
                                </div>

                            </div>


                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanFname" Text="First name" runat="server" meta:resourcekey="lblAdvSalesmanFnameResource1" Style="font-weight: 900"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanFname" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesmanFnameResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanLname" Text="Last name" runat="server" meta:resourcekey="lblAdvSalesmanLnameResource1" Style="font-weight: 900"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanLname" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesmanLnameResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanDept" Text="Department" runat="server" meta:resourcekey="lblAdvSalesmanDeptResource1" Style="font-weight: 900 !important"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanDept" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesmanDeptResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanPassword" Text="Password" runat="server" meta:resourcekey="lblAdvSalesmanPasswordResource1" Style="font-weight: 900 !important"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanPassword" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesmanPasswordResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesmanPhone" Text="Telefon" runat="server" meta:resourcekey="lblAdvSalesmanPhoneResource1" Style="font-weight: 900 !important"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesmanPhone" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesmanPhoneResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvSalesmanNew" runat="server" class="ui btn wide" value="Ny" meta:resourcekey="btnNewResource1" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvSalesmanDelete" runat="server" class="ui btn wide"  value="Slett" meta:resourcekey="btnDeleteResource1"/>
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesmanSave" runat="server" class="ui btn wide" value="Lagre" meta:resourcekey="btnSaveResource1"/> 
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesmanCancel" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Branch Modal --%>
    <div id="modAdvBranch" class="modal hidden">
        <div class="modHeader">
            <h2 id="H2" runat="server"><%=GetLocalResourceObject("labelBranch")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("labNewBranch")%></label>
                    <div class="ui small info message">
                        <p id="lblAdvBranchStatus" runat="server"><%=GetLocalResourceObject("labelBranch")%> <%=GetLocalResourceObject("divStatus")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label2" runat="server"><%=GetLocalResourceObject("labelBranch")%></label>
                                <select id="drpBranch" runat="server" size="10" class="wide dropdownList"></select>
                                <%--<select id="Select1" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemBranch">bransjeliste</option>
                                    
                                </select>--%>
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchCode" Text="Kode" runat="server" meta:resourcekey="lblAdvBranchCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchCode" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvBranchCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchText" Text="Tekst" runat="server" meta:resourcekey="lblAdvBranchTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchText" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvBranchTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchNote" Text="Merk" runat="server" meta:resourcekey="lblAdvBranchNoteResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchNote" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvBranchNoteResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvBranchRef" Text="Referanse" runat="server" meta:resourcekey="lblAdvBranchRefResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvBranchRef" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvBranchRefResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvBranchNew" runat="server" class="ui btn wide" value="Ny" meta:resourcekey="btnNewResource1" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvBranchDelete" runat="server" class="ui btn wide" value="Slett" meta:resourcekey="btnDeleteResource1"/>
                                    </div>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvBranchSave" runat="server" class="ui btn wide" value="Lagre" meta:resourcekey="btnSaveResource1"/>
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvBranchCancel" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Category Modal --%>
    <div id="modAdvCategory" class="modal hidden">
        <div class="modHeader">
            <h2 id="H3" runat="server"><%=GetLocalResourceObject("labelCategory")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("labNewCategory")%></label>
                    <div class="ui small info message">
                        <p id="lblAdvCategoryStatus" runat="server"><%=GetLocalResourceObject("labelCategory")%> <%=GetLocalResourceObject("divStatus")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label4" runat="server"><%=GetLocalResourceObject("labelCategory")%> <%=GetLocalResourceObject("divList")%></label>
                                <select id="drpAdvCategory" runat="server" size="10" class="wide dropdownList"></select>
                                <%--<select id="Select2" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemCategory">God kunde</option>
                                </select>--%>
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryCode" Text="Kode" runat="server" meta:resourcekey="lblAdvCategoryCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryCode" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCategoryCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryText" Text="Tekst" runat="server" meta:resourcekey="lblAdvCategoryTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryText" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCategoryTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryNote" Text="Merk" runat="server" meta:resourcekey="lblAdvCategoryNoteResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryNote" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCategoryNoteResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCategoryRef" Text="Referanse" runat="server" meta:resourcekey="lblAdvCategoryRefResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCategoryRef" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCategoryRefResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvCategoryNew" runat="server" class="ui btn wide" value="Ny"  meta:resourcekey="btnNewResource1" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvCategoryDelete" runat="server" class="ui btn wide" value="Slett" meta:resourcekey="btnDeleteResource1"/>

                                    </div>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCategorySave" runat="server" class="ui btn wide" value="Lagre" meta:resourcekey="btnSaveResource1"/>
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCategoryCancel" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Salesgroup Modal --%>
    <div id="modAdvSalesGroup" class="modal hidden">
        <div class="modHeader">
            <h2 id="H4" runat="server"><%=GetLocalResourceObject("labelSalesGroup")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("labelSalesGroup")%></label>
                    <div class="ui small info message">
                        <p id="lblAdvSalesGroupStatus" runat="server"><%=GetLocalResourceObject("labelSalesGroup")%> <%=GetLocalResourceObject("divStatus")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="lblAdvSalesGroupList" runat="server"><%=GetLocalResourceObject("labelSalesGroup")%> <%=GetLocalResourceObject("divList")%></label>
                                <select id="drpAdvSalesGroup" runat="server" size="13" class="wide dropdownList"></select>
                                <%--<select id="Select3" runat="server" size="13" class="wide dropdownList">
                                    <option value="0" id="ddlItemSalesGroup0">10 - Salg deler</option>
                                    <option value="1" id="ddlItemSalesGroup1">20 - Salg verksted</option>
                                    <option value="2" id="ddlItemSalesGroup2">30 - Salg brukte biler</option>
                                </select>--%>
                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupCode" Text="Kode" runat="server" meta:resourcekey="lblAdvSalesGroupCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupCode" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesGroupCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupText" Text="Tekst" runat="server" meta:resourcekey="lblAdvSalesGroupTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupText" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesGroupTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupInv" Text="Inv." runat="server" meta:resourcekey="lblAdvSalesGroupInvResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupInv" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesGroupInvResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvSalesGroupVat" Text="Fri/Pl./Utl." runat="server" meta:resourcekey="lblAdvSalesGroupVatResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvSalesGroupVat" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvSalesGroupVatResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvSalesGroupNew" runat="server" class="ui btn wide" value="Ny"  meta:resourcekey="btnNewResource1" />
                                    </div>

                                    <div class="field">
                                        <input type="button" id="btnAdvSalesGroupDelete" runat="server" class="ui btn wide" value="Slett" meta:resourcekey="btnDeleteResource1"/>
                                    </div>
                                </div>
                                <div class="fields">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesGroupSave" runat="server" class="ui btn wide" value="Lagre" meta:resourcekey="btnSaveResource1"/>
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvSalesGroupCancel" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Payment Terms Modal --%>
    <div id="modAdvPaymentTerms" class="modal hidden">
        <div class="modHeader">
            <h2 id="H5" runat="server"><%=GetLocalResourceObject("labelPayTerms")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("labelPayTerms")%></label>
                    <div class="ui small info message">
                        <p id="lblAdvPayTermsStatus" runat="server"><%=GetLocalResourceObject("labelPayTerms")%> <%=GetLocalResourceObject("divStatus")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label5" runat="server"><%=GetLocalResourceObject("labelPayTerms")%></label>
                                <select id="drpAdvPaymentTerms" runat="server" size="13" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvPayTermsCode" Text="Kode" runat="server" meta:resourcekey="lblAdvPayTermsCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvPayTermsCode" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvPayTermsCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvPayTermsText" Text="Tekst" runat="server" meta:resourcekey="lblAdvPayTermsTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvPayTermsText" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvPayTermsTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvPayTermsDays" Text="Dager" runat="server" meta:resourcekey="lblAdvPayTermsDaysResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvPayTermsDays" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvPayTermsDaysResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">
                                    <div class="field">
                                        <input type="button" id="btnAdvPayTermsNew" runat="server" class="ui btn wide" value="Ny" meta:resourcekey="btnNewResource1" />
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvPayTermsDelete" runat="server" class="ui btn wide" value="Slett" meta:resourcekey="btnDeleteResource1"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvPayTermsSave" runat="server" class="ui btn wide" value="Lagre" meta:resourcekey="btnSaveResource1"/>
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvPayTermsCancel" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Credit Card Modal --%>
    <div id="modAdvCreditCardType" class="modal hidden">
        <div class="modHeader">
            <h2 id="H6" runat="server"><%=GetLocalResourceObject("labelCardType")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("labelCardType")%></label>
                    <div class="ui small info message">
                        <p id="lblAdvCreditCardStatus" runat="server"><%=GetLocalResourceObject("labelCardType")%> <%=GetLocalResourceObject("divStatus")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label6" runat="server"><%=GetLocalResourceObject("labelCardType")%></label>
                                <select id="drpAdvCardType" runat="server" size="10" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCredCardTypeCode" Text="Kode" runat="server" meta:resourcekey="lblAdvCredCardTypeCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCredCardTypeCode" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCredCardTypeCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCredCardTypeText" Text="Tekst" runat="server" meta:resourcekey="lblAdvCredCardTypeTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCredCardTypeText" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCredCardTypeTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCredCardTypeCustNo" Text="Kundenr" runat="server" meta:resourcekey="lblAdvCredCardTypeCustNoResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCredCardTypeCustNo" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCredCardTypeCustNoResource1"></asp:TextBox>
                                </div>

                                <div class="two fields">

                                    <div class="field">
                                        <input type="button" id="btnAdvCredCardTypeNew" runat="server" class="ui btn wide" value="Ny" meta:resourcekey="btnNewResource1"/>
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvCredCardTypeDelete" runat="server" class="ui btn wide" value="Slett" meta:resourcekey="btnDeleteResource1"/>
                                    </div>
                                </div>
                                <div class="field">
                                    &nbsp;    
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCredCardTypeSave" runat="server" class="ui btn wide" value="Lagre" meta:resourcekey="btnSaveResource1"/>
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCredCardTypeCancel" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Currency Code Modal --%>
    <div id="modAdvCurrencyCode" class="modal hidden">
        <div class="modHeader">
            <h2 id="H7" runat="server"><%=GetLocalResourceObject("labelCurrencyCode")%></h2>
            <div class="modClose"><i class="remove icon"></i></div>
        </div>
        <div class="modContent">
            <div class="ui form">
                <div class="field">
                    <label class="sr-only"><%=GetLocalResourceObject("labelCurrencyCode")%></label>
                    <div class="ui small info message">
                        <p id="lblAdvCurrencyStatus" runat="server"><%=GetLocalResourceObject("labelCurrencyCode")%> <%=GetLocalResourceObject("divStatus")%></p>
                    </div>
                </div>
            </div>
            <div class="ui grid">
                <div class="sixteen wide column">
                    <div class="ui form">
                        <div class="fields">
                            <div class="eight wide field">
                                <label id="Label7" runat="server"><%=GetLocalResourceObject("labelCurrencyCode")%> type</label>
                                <select id="drpAdvCurrencyType" runat="server" size="10" class="wide dropdownList"></select>

                            </div>
                            <div class="eight wide field">
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCurCodeCode" Text="Kode" runat="server" meta:resourcekey="lblAdvCurCodeCodeResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCurCodeCode" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCurCodeCodeResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCurCodeText" Text="Tekst" runat="server" meta:resourcekey="lblAdvCurCodeTextResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCurCodeText" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCurCodeTextResource1"></asp:TextBox>
                                </div>
                                <div class="field">
                                    <label>
                                        <asp:Label ID="lblAdvCurCodeValue" Text="Nkr." runat="server" meta:resourcekey="lblAdvCurCodeValueResource1"></asp:Label></label>
                                    <asp:TextBox ID="txtAdvCurCodeValue" CssClass="carsInput" runat="server" meta:resourcekey="txtAdvCurCodeValueResource1"></asp:TextBox>
                                </div>
                                <div class="two fields">

                                    <div class="field">
                                        <input type="button" id="btnAdvCurCodeNew" runat="server" class="ui btn wide" value="Ny" meta:resourcekey="btnNewResource1"/>
                                    </div>
                                    <div class="field">
                                        <input type="button" id="btnAdvCurCodeDelete" runat="server" class="ui btn wide" value="Slett" meta:resourcekey="btnDeleteResource1"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCurCodeSave" runat="server" class="ui btn wide" value="Lagre" meta:resourcekey="btnSaveResource1"/>
                            </div>
                            <div class="eight wide field">
                                <input type="button" id="btnAdvCurCodeCancel" runat="server" class="ui btn wide" value="Avbryt" meta:resourcekey="btnCancelResource1"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Modal for adding contact information --%>
    <div id="modContact" class="ui small modal">
        <i class="close icon"></i>
        <div class="header">
            <%=GetLocalResourceObject("labNewContact")%>
        </div>
        <div class="content">
            <div class="description">
                <div class="ui action input">
                    <div class="inline three field">
                        <input id="txtContactType" type="text" runat="server" class="carsInput"/>
                        <asp:DropDownList ID="drpContactType" CssClass="ui compact selection dropdown" runat="server" meta:resourcekey="drpContactTypeResource1"></asp:DropDownList>
                        <asp:CheckBox ID="chkContactType" CssClass="ui checkbox" Text="Standard?" runat="server" meta:resourcekey="chkContactTypeResource1" />
                    </div>
                </div>

            </div>
        </div>
        <div class="actions">
            <div class="ui red button cancel">
                <i class="remove icon"></i>
                <%=GetLocalResourceObject("divCancel")%>
            </div>
            <div class="ui green button ok">
                <i class="checkmark icon"></i>
                 <%=GetLocalResourceObject("divSave")%>
            </div>
        </div>
    </div>
</asp:Content>
