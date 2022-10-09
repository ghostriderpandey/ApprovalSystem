<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="CRMLogicNote.aspx.cs" Inherits="AdminPanel_CRMLoginNote" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            ddlGetProjectName();
            ddlProjectName();

            $("#<%=rfvProjectName.ClientID%>").css("display", "none");
        });

        function ddlGetProjectName() {

            var data = {};
            $("#<%=ddlCompanyName.ClientID %>").change(function () {
                data.companyId = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "CRMLogicNote.aspx/GetProjectName",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddlprojectname = $("[id*=<%=ddlprojectname.ClientID %>]");
                        ddlprojectname.empty().append('<option selected="selected" value="0">Please select</option>');
                        $.each(r.d, function () {
                            ddlprojectname.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddlProjectName();
                        $("#<%=rfvProjectName.ClientID%>").css("display", "none");
                    }
                });
            });
        }


        function process(input) {
            let value = input.value;
            let numbers = value.replace(/[^0-9]/g, "");
            input.value = numbers;
        }

        function isNumberKey(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function isDecimalKey(txt, evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 46) {
                //Check if the text already contains the . character
                if (txt.value.indexOf('.') === -1) {
                    return true;
                } else {
                    return false;
                }
            }
            else if (charCode == 45) {
                if (txt.value.indexOf('-') === -1) {
                    return true;
                } else {
                    return false;
                }
            }
            else {
                if (charCode > 31 &&
                    (charCode < 48 || charCode > 57))
                    return false;
            }
            return true;
        }

        function setCookie(cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toGMTString();
            document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
        }

        function deleteAllCookies() {
            var cookies = document.cookie.split(";");
            for (var i = 0; i < cookies.length; i++) {
                var cookie = cookies[i];
                var eqPos = cookie.indexOf("=");
                var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
                document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
            }
        }

        function getCookie(cname) {
            var name = cname + "=";
            var decodedCookie = decodeURIComponent(document.cookie);
            var ca = decodedCookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }


        <%--function fillVariationofBudget() {
            var dblapprovalBudget = $('#<%=txtApprovalBudget.ClientID %>').val();
            var dblVaritaion = 0;
            dblVaritaion = (dblapprovalBudget - dblAlreadyAwarded - dblProposedvalueofaward - dblBalancetobeaward);
        }--%>

        <%--function FillVendorCal() {
          var dblTotalVendor = $('#<%=txtTotalVendorConsidred.ClientID %>').val();
            var dblRejectedVendor = $('#<%=txtRejectedVendor.ClientID %>').val();
            var dblRFQinvited = 0;
            var dblNotQuoted = $('#<%=txtNotQuoted.ClientID %>').val();;
            var dblFinalConsidered = 0;
            dblRFQinvited = dblTotalVendor - dblRejectedVendor;
            $('#<%=txtRFQInvited.ClientID %>').val(dblRFQinvited.toFixed(2));
            dblFinalConsidered = dblRFQinvited - dblNotQuoted;
            $('#<%=txtFinalConsidered.ClientID %>').val(dblFinalConsidered.toFixed(2));
        }--%>

        function ddlChange() {
            var url = window.location.href;
            if (url.indexOf('?id=') != -1) {
                deleteAllCookies()
                setCookie("Projectaddress", "", 30);
            }

            $('#<%=txtSubjectScope.ClientID %>').keypress(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 200) {
                    alert('You cannot enter more than 200 chars');
                    return false;
                }
            });
            $('#<%=txtSubjectScope.ClientID %>').keyup(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 200) {
                    $(this).val('');
                    alert('You cannot enter more than 200 chars');
                    return false;
                }
            });
            $('#<%=txtother.ClientID %>').keypress(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 100) {
                    alert('You cannot enter more than 100 chars');
                    return false;
                }
            });
            $('#<%=txtother.ClientID %>').keyup(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 100) {
                    $(this).val('');
                    alert('You cannot enter more than 100 chars');
                    return false;
                }
            });

           <%-- $('#<%=txtSingleRepeatOrderReson.ClientID %>').keypress(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 1000) {
                    alert('You cannot enter more than 1000 chars');
                    return false;
                }
            });--%>

            
      <%--      $("#<%=ddlCompanyName.ClientID %>").change(function () {
                if ($(this).val() == "Direct Purchase") {
                   // $('#<%=txtContratorName.ClientID %>').val("");
                    $('#<%=ddlApprovaltype.ClientID %>').val("Actual Purchase");
                    $('#<%=txtContratorName.ClientID%>').prop("readonly", false);
                    $("#<%=ddlApprovaltype.ClientID%>").prop("disabled", true);

                }
                else if ($(this).val() == "Rate Approval") {
                    $('#<%=ddlApprovaltype.ClientID %>').val("Base Rate");
                    $('#<%=txtContratorName.ClientID%>').prop("readonly", false);
                    $("#<%=ddlApprovaltype.ClientID%>").prop("disabled", true);

                }
                else if ($(this).val() == "Regularization of Purchase") {
                    $('#<%=ddlApprovaltype.ClientID %>').val("Regularization of Purchase");
                    $('#<%=txtContratorName.ClientID%>').prop("readonly", false);
                    $("#<%=ddlApprovaltype.ClientID%>").prop("disabled", true);
                }
                else if ($(this).val() == "Regularization of Rate Approval") {
                    $('#<%=ddlApprovaltype.ClientID %>').val("Regularization of Rate Approval");
                    $('#<%=txtContratorName.ClientID%>').prop("readonly", false);
                    $("#<%=ddlApprovaltype.ClientID%>").prop("disabled", true);
                }
                else {
                    $('#<%=ddlApprovaltype.ClientID %>').val("0");
                    $('#<%=txtContratorName.ClientID%>').prop("readonly", false);
                    $("#<%=ddlApprovaltype.ClientID%>").prop("disabled", true);

                }
            }).change();--%>

        };

        function disabledApprovalNo(item) {
            if ($("#" + item.id + " option:selected").val() == "1") {
                $("#<%=txtApprovalNo.ClientID%>").attr("disabled", "disabled");
                $("#<%=txtReasonofAmendment.ClientID%>").attr("disabled", "disabled");
            }
            else {
                $("#<%=txtApprovalNo.ClientID%>").removeAttr("disabled");
                $("#<%=txtReasonofAmendment.ClientID%>").removeAttr("disabled");
            }
        }
        function disabledUrgentRemark(item) {
            if ($("#" + item.id + " option:selected").val() == "Normal") {
                $("#<%=txtUrjentRemarks.ClientID%>").attr("disabled", "disabled");
            }
            else {
                $("#<%=txtUrjentRemarks.ClientID%>").removeAttr("disabled");
            }
        }
        function ddlProjectName() {

            $("#<%=ddlprojectname.ClientID %>").change(function () {
                var ProjectID = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "CRMLogicNote.aspx/getPorjectAddress",
                    data: "{ 'projectId': '" + ProjectID + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        // alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        setCookie("Projectaddress", result.d, 30);
                        $('#<%=txtProjectaddress.ClientID %>').val(result.d);
                    }
                })

                $('#<%=hiddenprojectnamevalue.ClientID %>').val(this.value);
                if ($(this).val() == 0) {
                    deleteAllCookies()
                    setCookie("Projectaddress", "", 30);
                }
            }).change();

        }


    </script>

    <style>
        select.aspNetDisabled {
            display: block;
            width: 100%;
            height: calc(1.5em + .75rem + 2px);
            padding: .375rem .75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div class="loading-overlay">
                <div class="wrapper">
                    <div class="ajax-loader-outer"></div>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2 class="text-center blue">CRM Logic Note</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Approval Type<span class="spnRequired">*</span></label>
                                <asp:DropDownList ID="ddlApproval" onchange="disabledApprovalNo(this)" runat="server" class="form-control selectcss">
                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                    <asp:ListItem Value="1">New</asp:ListItem>
                                    <asp:ListItem Value="2">Amendment</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvApprovalType" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Type"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlApproval" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Approval No</label>
                                <asp:TextBox ID="txtApprovalNo" ClientIDMode="Static" disabled="disabled" runat="server" AutoPostBack="true" OnTextChanged="txtApprovalNo_TextChanged" CssClass="form-control" PlaceHolder="Approval No"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" DelimiterCharacters="" Enabled="True" ServiceMethod="GetApprovalNo" MinimumPrefixLength="1" EnableCaching="true"
                                    ServicePath="CRMLogicNote.aspx" TargetControlID="txtApprovalNo">
                                </cc1:AutoCompleteExtender>
                                <asp:HiddenField runat="server" ID="hdnApprovalNo" Value="0" />
                                <asp:HiddenField runat="server" ID="hdnApprovalType" Value="0" />
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">
                                    Approval Authority<span class="spnRequired">*</span></label>
                                <asp:DropDownList ID="ddlapprovalauthrity" runat="server" class="form-control selectcss"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Authority"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlapprovalauthrity" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Company Name<span class="spnRequired">*</span></label>
                                <asp:DropDownList ID="ddlCompanyName" runat="server" CssClass="form-control selectcss">
                                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Select Company Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlCompanyName" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Subject & Scope<span class="spnRequired">Max 200 Character *</span></label>
                                <asp:TextBox ID="txtSubjectScope" PlaceHolder="Subject & Scope" TextMode="MultiLine" Rows="1" runat="server" class="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvSubjectScope" ForeColor="Red" runat="server" ErrorMessage="Please Enter Subject Scope"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSubjectScope"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Project Name<span class="spnRequired">*</span></label>
                                <asp:DropDownList ID="ddlprojectname" runat="server" ClientIDMode="Static" class="form-control selectcss"></asp:DropDownList>
                                <asp:HiddenField ID="hiddenprojectnamevalue" runat="server" />
                                <asp:RequiredFieldValidator ID="rfvProjectName" ForeColor="Red" runat="server" ErrorMessage="Please Select Project Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlprojectname" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Address</label>
                                <asp:TextBox ID="txtProjectaddress" EnableViewState="true" runat="server" TextMode="MultiLine" Rows="1" placeholder="Project Address" ReadOnly="true" class="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Department Name<span class="spnRequired">*</span></label>
                                <asp:DropDownList ID="ddlDepartment" runat="server" class="form-control selectcss"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Select Department Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlDepartment" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Approval Priority</label>
                                <asp:DropDownList ID="ddlApprovalPriority" onchange="disabledUrgentRemark(this)" runat="server" class="form-control selectcss">
                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                    <asp:ListItem Value="Normal">Normal</asp:ListItem>
                                    <asp:ListItem Value="Urgent">Urgent</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvApprovalPriority" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Priority"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlApprovalPriority" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Urgents Remarks <span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtUrjentRemarks" runat="server" PlaceHolder="Urgents Remarks" CssClass="form-control"></asp:TextBox>
                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Urgents Remarks "
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtUrjentRemarks"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>
                        <div class="col-sm-3" visible="false" id="dvStatus" runat="server">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Status</label>
                                <asp:DropDownList ID="ddlstatus" runat="server" Enabled="false" class="form-control selectcss">
                                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                    <asp:ListItem Value="Approved">Approved</asp:ListItem>
                                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                    <asp:ListItem Value="Draft">Draft</asp:ListItem>
                                </asp:DropDownList>
                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ErrorMessage="Please Select Status"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlstatus" InitialValue="0"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Reason of Amendment</label>
                                <asp:TextBox ID="txtReasonofAmendment" runat="server" PlaceHolder="Reason of Amendment" CssClass="form-control"></asp:TextBox>
                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reason of Amendment"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtReasonofAmendment"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Others Description<span class="spnRequired">Max 100 Character *</span></label>

                                <asp:TextBox ID="txtother" EnableViewState="false" runat="server" TextMode="MultiLine" Rows="1" CssClass="form-control" placeholder="Others Description"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rvreasonforothers" ForeColor="Red" runat="server" ErrorMessage="Please Enter Others Description"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtother"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Customer/Client Name<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtCustomerName" runat="server" PlaceHolder="Customer/Client Name" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" runat="server" ErrorMessage="Please Enter Customer/Client Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtCustomerName"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Negotiation Mode<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtNegotiationMode" runat="server" PlaceHolder="Negotiation Mode" CssClass="form-control"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvNegotiationMode" ForeColor="Red" runat="server" ErrorMessage="Please Enter Negotiation Mode"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtNegotiationMode"></asp:RequiredFieldValidator>
                            </div>
                        </div>


                    </div>

                </div>
                <div class="x_content">
                    <div class="row">
                        <div class="col-sm-12">
                            <label for="exampleInputEmail1" class="font-weight-bold">Approval Sought<span class="spnRequired">*</span></label>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">

                                <CKEditor:CKEditorControl Toolbar="Basic" ID="ckApprovalSought" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                                <asp:RequiredFieldValidator ID="rfvApprovalSought" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approval Sought"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ckApprovalSought"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="x_content">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Channel Partner Name<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtChannelPartnerName" runat="server" placeholder="Channel Partner Name" class="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="Red" runat="server" ErrorMessage="Please Enter Channel Partner Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtChannelPartnerName"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Unit No<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtUnitNo" runat="server" PlaceHolder="Unit No" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="Red" runat="server" ErrorMessage="Please Enter Unit No"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtUnitNo"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Old Unit No</label>
                                <asp:TextBox ID="txtOldUnitNo" runat="server" CssClass="form-control" placeholder="Old Unit No"></asp:TextBox>
                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator26" ForeColor="Red" runat="server" ErrorMessage="Please Enter Old Unit No"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtOldUnitNo"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Super Area<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtSuperArea" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" oninput="process(this)" CssClass="form-control" Placeholder="Super Area"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ForeColor="Red" runat="server" ErrorMessage="Please Enter Super Area"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSuperArea"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">BSP(Rs./Sqft)<span class="spnRequired">*</span></label><br />
                                <asp:TextBox ID="txtBSP" runat="server" CssClass="form-control" oninput="process(this)" Text="0" onkeypress="return isDecimalKey(this, event);" PlaceHolder="BSP"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator28" ForeColor="Red" runat="server" ErrorMessage="BSP"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtBSP"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">PLC(Rs./Sqft)<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtPLC" runat="server" CssClass="form-control" PlaceHolder="PLC" Text="0" oninput="process(this)" onkeypress="return isDecimalKey(this, event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPLC" ForeColor="Red" runat="server" ErrorMessage="Please Enter PLC"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPLC"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">EDC/IDC(Rs./Sqft)<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtEDC_IDC" runat="server" CssClass="form-control" oninput="process(this)" Text="0" PlaceHolder="EDC/IDC" onkeypress="return isDecimalKey(this, event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator29" ForeColor="Red" runat="server" ErrorMessage="Please Enter EDC/IDC"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtEDC_IDC"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">EIC(Rs./Sqft)<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtEIC" runat="server" CssClass="form-control" oninput="process(this)" Text="0" PlaceHolder="EIC" onkeypress="return isDecimalKey(this, event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator30" ForeColor="Red" runat="server" ErrorMessage="Please Enter EIC"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtEIC"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Car Parking<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtCarParking" runat="server" CssClass="form-control" PlaceHolder="Car Parking"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator31" ForeColor="Red" runat="server" ErrorMessage="Please Enter Car Parking"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtCarParking"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">TCV</label>
                                <asp:TextBox ID="txtTCV" EnableViewState="false" runat="server" PlaceHolder="TCV" CssClass="form-control"></asp:TextBox>

                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Possession Charge(Rs./Sqft)<span class="spnRequired">*</span></label>
                                <asp:TextBox ID="txtProfessionCharge" EnableViewState="false" runat="server" Text="0" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" PlaceHolder="Contractor Name" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPossessionCharge" ForeColor="Red" runat="server" ErrorMessage="Please Enter Possession Charge"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtProfessionCharge"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Other Charge(Rs./Sqft)</label>
                                <asp:TextBox ID="txtOtherCharge" EnableViewState="false" Text="0" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" CssClass="form-control"></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">
                                    Reg.No.
                                </label>
                                <asp:TextBox ID="txtRegNo" EnableViewState="false" PlaceHolder="Reg.No." Text="0" oninput="process(this)" runat="server" onkeypress="return isDecimalKey(this, event);" CssClass="form-control"></asp:TextBox>
                                <%--   <asp:RequiredFieldValidator ID="rfvRegNo" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reg.No."
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtRegNo"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2 class="blue">Payment Plan</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-responsive">
                    <asp:GridView ID="gvItemHead" runat="server" AutoGenerateColumns="False" ShowFooter="false"
                        class="table table-bordered table-hover">
                        <Columns>
                            <asp:TemplateField HeaderText="Add">
                                <ItemTemplate>
                                    <a onclick="AddRowInPaymentPlan('ContentPlaceHolder1_gvItemHead')" class="addPaymentPlanRow">
                                        <img src="Icons/addicon.png" /></a>
                                    <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("ID") %>' />
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Payment Terms">
                                <ItemTemplate>
                                    <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("PaymentTerms") %>' ID="ckPaymentTerms" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtAmount" Width="120px" Text='<%#Eval("Amount") %>' oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("Description") %>' ID="ckDescription" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("Remark") %>' ID="ckRemark" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <a onclick="delRow('ContentPlaceHolder1_gvItemHead',this)" class="btn btn-primary fa fa-trash"></a>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>
                </div>

            </div>


            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2 class="blue">Payment Details</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <asp:GridView ID="grdPaymentDetails" runat="server" AutoGenerateColumns="False"
                        class="table table-bordered table-hover" OnRowCommand="grdPaymentDetails_RowCommand" OnRowDeleting="grdPaymentDetails_RowDeleting" OnPreRender="grdPaymentDetails_PreRender" OnRowDataBound="grdPaymentDetails_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Add">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hddAID" runat="server" Value='<%#Eval("ID") %>' />
                                    <a onclick="AddRowInPaymentDetails('ContentPlaceHolder1_grdPaymentDetails')">
                                        <img src="Icons/addicon.png" /></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <CKEditor:CKEditorControl Toolbar="Basic" ID="ckDescription" Text='<%#Eval("Description") %>' CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                                    <asp:RequiredFieldValidator ID="rfvPrice6" ControlToValidate="ckDescription" ValidationGroup="V" runat="server" ErrorMessage="Description Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtAmount" runat="server" Text='<%# Convert.ToString(Eval("Amount"))==""?"0":Eval("Amount")%>' CssClass="form-control" oninput="process(this)" onkeypress="return isDecimalKey(this, event);"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvAmount" ControlToValidate="txtAmount" ValidationGroup="V" runat="server" ErrorMessage="Amount Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PaymentMode">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPaymentMode" runat="server" Text='<%#Eval("PaymentMode") %>' class="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPaymentMode" ControlToValidate="txtPaymentMode" ValidationGroup="V" runat="server" ErrorMessage="Payment Mode Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <CKEditor:CKEditorControl Toolbar="Basic" ID="ckRemarks" Text='<%#Eval("Remark") %>' CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <a onclick="delRow('ContentPlaceHolder1_grdPaymentDetails',this)" class="btn btn-primary fa fa-trash"></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>





            <div class="col-md-12 col-sm-12 " style="display: none">
                <div class="x_panel tile fixed_height_320">
                    <div class="x_title">
                        <h2 class="blue">Marketing Evaluation</h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li>
                                <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label for="exampleInputEmail1" class="font-weight-bold">Recommendations with reasons</label>
                                    <CKEditor:CKEditorControl Toolbar="Basic" ID="txtreccomandationwithreason" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                    <%--<asp:TextBox ID="txtreccomandationwithreason" PlaceHolder="Recommendations with reasons" runat="server" TextMode="MultiLine" Rows="1" class="form-control"></asp:TextBox>--%>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Recommendations with reasons"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtreccomandationwithreason"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label for="exampleInputEmail1" class="font-weight-bold">Vendor Information</label>
                                    <asp:TextBox ID="txtVendorInformation" runat="server" placeholder="Vendor Information" class="form-control"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor Information"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendorInformation"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label for="exampleInputEmail1" class="font-weight-bold">Turnover last year<span class="small">(in Lacs)</span></label>
                                    <asp:TextBox ID="txtTournoverlastyear" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Turnover last year" CssClass="form-control"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Turnover last year"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTournoverlastyear"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label for="exampleInputEmail1" class="font-weight-bold">Total orders with Co. till date</label>
                                    <asp:TextBox ID="txtTotalOrderwithcotilldate" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator50" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total orders with Co. till date"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalOrderwithcotilldate"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label for="exampleInputEmail1" class="font-weight-bold">Last order details with Co.</label>
                                    <asp:TextBox ID="txtLastOrderdetailswithco" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator51" ForeColor="Red" runat="server" ErrorMessage="Please Enter Last order details with Co"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtLastOrderdetailswithco"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>



            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2 class="blue">Add Attachment</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <asp:GridView ID="gvAttachment" runat="server" AutoGenerateColumns="False"
                        class="table table-bordered table-hover" OnRowCommand="gvAttachment_RowCommand" OnRowDataBound="gvAttachment_RowDataBound" OnRowDeleting="gvAttachment_RowDeleting" OnPreRender="gvAttachment_PreRender">
                        <Columns>
                            <asp:TemplateField HeaderText="Add">
                                <ItemTemplate>

                                    <a onclick="AddRowInAttachment('ContentPlaceHolder1_gvAttachment')">
                                        <img src="Icons/addicon.png" /></a>
                                    <asp:HiddenField ID="hddAttachmentID" runat="server" Value='<%#Eval("ID") %>' />

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDescription" runat="server" class="form-control" Text='<%#Eval("Description") %>'></asp:TextBox>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Doc File">
                                <ItemTemplate>

                                    <asp:FileUpload ID="fudFile" EnableViewState="true" runat="server" class="form-control" onchange="return pdfFileValidation(this);"></asp:FileUpload>
                                    <asp:LinkButton ID="lnkDownloadDocFile" Text='<%#Eval("DocFile") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocFile")  %>' CommandName="Download" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Doc Image">
                                <ItemTemplate>

                                    <asp:FileUpload ID="fudImage" EnableViewState="true" runat="server" class="form-control" onchange="return imageFileValidation(this);"></asp:FileUpload>
                                    <asp:LinkButton ID="lnkDownloadDocImage" runat="server" Text='<%# Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" ToolTip="Download Image"></asp:LinkButton>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <a onclick="delRow('ContentPlaceHolder1_gvAttachment',this)" class="btn btn-primary fa fa-trash"></a>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2 class="blue">Add Approver</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <asp:GridView ID="gvApprover" runat="server" AutoGenerateColumns="False"
                  class="table table-bordered table-hover" OnRowCommand="gvApprover_RowCommand" OnRowDeleting="gvApprover_RowDeleting" OnPreRender="gvApprover_PreRender" OnRowDataBound="gvApprover_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Add">
                                <ItemTemplate>
                                    <%--<%#Container.DataItemIndex+1%>--%>
                                    <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                                    <asp:HiddenField ID="hddAID" runat="server" Value='<%#Eval("ID") %>' />
                                    <asp:HiddenField ID="hddApprover" runat="server" Value='<%#Eval("ApproverID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approver">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlApprover" runat="server" class="form-control approver">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlApprover" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="Approver Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                      <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ApproverID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                                   <%-- <a onclick="delRow('ContentPlaceHolder1_gvApprover',this)" class="btn btn-primary fa fa-trash"></a>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2 class="blue">Remark<span class="spnRequired">*</span></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <CKEditor:CKEditorControl Toolbar="Basic" ID="ckremark" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator35" ForeColor="Red" runat="server" ErrorMessage="Please Enter Remark"
                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ckremark"></asp:RequiredFieldValidator>

                </div>
            </div>


            <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                    <h2 class="blue">Head Of Department<span class="spnRequired">*</span></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">


                    <CKEditor:CKEditorControl Toolbar="Basic" ID="chkHeadOfDepartMent" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                    <asp:RequiredFieldValidator ID="rfvHeadOfDepartMent" ForeColor="Red" runat="server" ErrorMessage="Please Enter Head Of DepartMent"
                        ValidationGroup="V" Display="Dynamic" ControlToValidate="chkHeadOfDepartMent"></asp:RequiredFieldValidator>

                </div>
            </div>

            <div class="col-md-12 col-sm-12" style="display: none">
                <div class="x_panel tile fixed_height_320">
                    <div class="x_title">
                        <h2 class="blue">Marketing Head<span class="spnRequired">*</span></h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li>
                                <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div class="col-sm-12">
                            <CKEditor:CKEditorControl Toolbar="Basic" ID="ckPurchaseHead" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator49" ForeColor="Red" runat="server" ErrorMessage="Please Enter Purchase Head"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="ckPurchaseHead"></asp:RequiredFieldValidator>--%>
                        </div>
                    </div>
                </div>
            </div>

            <div class=" ">

                <asp:Button ID="btnSubmit" OnClientClick="SetData();" runat="server" CssClass="btn btn-primary" Text="Save as Draft" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnSubmitforApproval" OnClientClick="SetData();" runat="server" CssClass="btn btn-primary" Text="Submit for Approval" ValidationGroup="V" OnClick="btnSubmitforApproval_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />

                <asp:ValidationSummary ID="ValidSum" runat="server" ValidationGroup="V" ShowMessageBox="true" ShowSummary="false" />

            </div>
            <asp:HiddenField runat="server" ID="hdnSetPaymentPlan" ClientIDMode="Static" />
            <asp:HiddenField runat="server" ID="hdnSetPaymentDetails" ClientIDMode="Static" />
            <asp:HiddenField runat="server" ID="hdnApproverData" ClientIDMode="Static" />
            <asp:HiddenField runat="server" ID="hdnAttachmentData" ClientIDMode="Static" />
            <asp:HiddenField runat="server" ID="hdnID" ClientIDMode="Static" Value="" />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSubmit" />
            <asp:PostBackTrigger ControlID="btnSubmitforApproval" />
            <asp:PostBackTrigger ControlID="gvAttachment" />
            <asp:AsyncPostBackTrigger ControlID="gvApprover" EventName="RowCommand" />
            <%-- <asp:AsyncPostBackTrigger ControlID="txtApprovalNo" EventName="TextChanged" />--%>
        </Triggers>
    </asp:UpdatePanel>
    <script>
        //var grd = document.getElementById(id);
        //var tbod = grd.rows[0].parentNode;
        //var newRow = grd.rows[grd.rows.length - 1].cloneNode(true);

        //console.log(newRow.childNode);
        //tbod.appendChild(newRow);

        function addRow(id, GridID) {

            var x = document.getElementById(id).tBodies[0];  //get the table

            //var node = x.rows[1].cloneNode(true);//clone the previous node or row
            var node = x.rows[x.rows.length - 1].cloneNode(true)
            //console.log(node.find("td:eq(4)"));
            var InputType = node.getElementsByTagName("input");
            for (var i = 0; i < InputType.length; i++) {
                if (InputType[i].type == 'checkbox') {
                    InputType[i].checked = false;
                }
                else if (InputType[i].type == 'hidden') {
                    InputType[i].remove(); // remove hidden fields
                    i--;
                }
                else {
                    InputType[i].value = '';
                }
            }

            var SelectType = node.getElementsByTagName("select");
            for (var i = 0; i < SelectType.length; i++) {
                SelectType[i].selectedIndex = 0;
            }

            x.appendChild(node);   //add the node or row to the table
            // CKEDITOR.replace('ckPaymentTerms');
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();
            //CKEDITOR.replaceClass = "ckeditor";

        }


        $(document).ready(function () {



            var id = 'ContentPlaceHolder1_gvItemHead';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First .addPaymentPlanRow').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First .addPaymentPlanRow').show();
            CKEDITOR.replaceClass = "ckeditor";

            var id = 'ContentPlaceHolder1_gvApprover';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();

            var id = 'ContentPlaceHolder1_grdPaymentDetails';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();

            var id = 'ContentPlaceHolder1_gvAttachment';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();
        });



        function delRow(id, row) {

            if ($(`#${id} tbody tr`).length > 2) {

                var index = $(`#${id} tr`).index($(row).parents('tr'));
                if (index == 1) {
                    // find hidden fields and move to first row
                    var hiddenType = $(row).parents('tr').find("input[type=hidden]");// Find textbox
                    $(`#${id} tbody tr`).eq(2).find('td:First').append(hiddenType);
                }


                $(row).parents('tr').remove();
                $(`#${id} tbody tr:last`).find('td:First a').show();
                $(`#${id} tbody tr:last`).find('td:First .addPaymentPlanRow').show();
            }
            else {
                alert('Minimum one row is required!');
            }
        }


        function imageFileValidation(element) {

            var filePath = element.value;
            // Allowing file type
            var allowedExtensions = /(\.jpg|\.JPG|\.jpeg|\.png|\.PNG)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid image type, Please upload jpg or png image');
                element.value = '';
                return false;
            }
        }
        function pdfFileValidation(element) {

            var filePath = element.value;

            // Allowing file type
            var allowedExtensions = /(\.pdf|\.PDF)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type, Please upload pdf file!!');
                element.value = '';
                return false;
            }
        }

    </script>
    <script type="text/javascript">
<!--
    function AddRowInPaymentPlan(containerId) {
        // Get a reference to the table/GridView...
        var tableRef = document.getElementById(containerId);

        // Get the index of the current last row...
        var lastRow = tableRef.rows.length;

        // Add a row (<tr>) to the table/GridView...
        var newRow = tableRef.insertRow(lastRow);

        // Add a cell (<td>) to the row...
        var newCell = newRow.insertCell(0);
        var controlRef = document.createElement('a');
        controlRef.type = 'button';
        controlRef.id = containerId + '_link' + (lastRow - 1);
        controlRef.name = controlRef.id;
        controlRef.value = "Add"
        controlRef.className = "addPaymentPlanRow";
        controlRef.innerHTML = "<img src='Icons/addicon.png' />";
        newCell.appendChild(controlRef);
        $("#" + controlRef.id).attr("onclick", "AddRowInPaymentPlan('ContentPlaceHolder1_gvItemHead')")

        var newCell1 = newRow.insertCell(1);
        var controlRef1 = document.createElement('label');
        controlRef1.type = 'label';
        controlRef1.id = containerId + '_label' + (lastRow - 1);
        controlRef1.name = controlRef1.id;
        controlRef1.innerText = lastRow;
        newCell1.appendChild(controlRef1);

        var newCell2 = newRow.insertCell(2);
        var controlRef2 = document.createElement('input');
        controlRef2.type = 'text';
        controlRef2.id = containerId + '_ckPaymentTerms_' + (lastRow - 1);
        controlRef2.name = controlRef2.id;
        // controlRef2.size = 20;
        controlRef2.className = "ckeditor";
        newCell2.appendChild(controlRef2);
        CKEDITOR.replace(controlRef2.name);

        var newCell3 = newRow.insertCell(3);
        var controlRef3 = document.createElement('input');
        controlRef3.type = 'text';
        controlRef3.id = containerId + '_txtAmount_' + (lastRow - 1);
        controlRef3.name = controlRef3.id;
        controlRef3.className = "form-control";
        controlRef3.value = "0";
        newCell3.appendChild(controlRef3);
        $("#" + controlRef3.id).attr("onkeypress", "return isDecimalKey(this, event)");
        $("#" + controlRef3.id).attr("oninput", "process(this)");

        var newCell4 = newRow.insertCell(4);
        var controlRef4 = document.createElement('input');
        controlRef4.type = 'text';
        controlRef4.id = containerId + '_ckDescription_' + (lastRow - 1);
        controlRef4.name = controlRef4.id;
        controlRef4.className = "form-control";
        newCell4.appendChild(controlRef4);
        CKEDITOR.replace(controlRef4.id);

        var newCell5 = newRow.insertCell(5);
        var controlRef5 = document.createElement('input');
        controlRef5.type = 'text';
        controlRef5.id = containerId + '_ckRemark_' + (lastRow - 1);
        controlRef5.name = controlRef5.id;
        controlRef5.className = "form-control";
        newCell5.appendChild(controlRef5);
        CKEDITOR.replace(controlRef5.id);

        var newCell6 = newRow.insertCell(6);
        var controlRef6 = document.createElement('a');
        controlRef6.type = 'button';
        controlRef6.id = containerId + '_delete_' + (lastRow - 1);
        controlRef6.name = controlRef6.id;
        controlRef6.className = "btn btn-primary fa fa-trash";
        newCell6.appendChild(controlRef6);
        $("#" + controlRef6.id).attr("onclick", "delRow('ContentPlaceHolder1_gvItemHead',this)")

        var id = 'ContentPlaceHolder1_gvItemHead';
        $(`#${id} tbody tr`).each(function () {
            $(this).find('td:First .addPaymentPlanRow').hide();
        });

        $(`#${id} tbody tr:last`).find('td:First .addPaymentPlanRow').show();
        return false;
    }
    function SetPaymentPlan() {
        var tableRef = document.getElementById("ContentPlaceHolder1_gvItemHead");
        var lastRow = tableRef.rows.length;
        var AllData = [];
        for (var i = 0; i < lastRow - 1; i++) {
            var data = {};
            data.ID = (i + 1).toString();
            data.PaymentTerms = CKEDITOR.instances[tableRef.id + "_ckPaymentTerms_" + i].document.getBody().getText();//$("#" + tableRef.id + "_ckPaymentTerms_" + i).val();
            data.Amount = $("#" + tableRef.id + "_txtAmount_" + i).val();
            data.Description = CKEDITOR.instances[tableRef.id + "_ckDescription_" + i].document.getBody().getText();//$("#" + tableRef.id + "_ckPaymentTerms_" + i).val();
            data.Remark = CKEDITOR.instances[tableRef.id + "_ckRemark_" + i].document.getBody().getText();//$("#" + tableRef.id + "_ckRemark_" + i).val();
            AllData.push(data);
        }
        $("#hdnSetPaymentPlan").val(JSON.stringify(AllData));
    }
    function AddRowInPaymentDetails(containerId) {

        var tableRef = document.getElementById(containerId);
        var lastRow = tableRef.rows.length;

        // Add a row (<tr>) to the table/GridView...
        var newRow = tableRef.insertRow(lastRow);

        // Add a cell (<td>) to the row...
        var newCell = newRow.insertCell(0);
        var controlRef = document.createElement('a');
        controlRef.type = 'button';
        controlRef.id = containerId + '_link' + (lastRow - 1);
        controlRef.name = controlRef.id;
        controlRef.value = "Add"
        //controlRef.className = "addPaymentPlanRow";
        controlRef.innerHTML = "<img src='Icons/addicon.png' />";
        newCell.appendChild(controlRef);
        $("#" + controlRef.id).attr("onclick", "AddRowInPaymentDetails('ContentPlaceHolder1_grdPaymentDetails')")

        var newCell1 = newRow.insertCell(1);
        var controlRef1 = document.createElement('label');
        controlRef1.type = 'label';
        controlRef1.id = containerId + '_label' + (lastRow - 1);
        controlRef1.name = controlRef1.id;
        controlRef1.innerText = lastRow;
        newCell1.appendChild(controlRef1);

        var newCell2 = newRow.insertCell(2);
        var controlRef2 = document.createElement('input');
        controlRef2.type = 'text';
        controlRef2.id = containerId + '_ckDescription_' + (lastRow - 1);
        controlRef2.name = controlRef2.id;
        // controlRef2.size = 20;
        controlRef2.className = "ckeditor";
        newCell2.appendChild(controlRef2);
        CKEDITOR.replace(controlRef2.name);

        var newCell3 = newRow.insertCell(3);
        var controlRef3 = document.createElement('input');
        controlRef3.type = 'text';
        controlRef3.id = containerId + '_txtAmount_' + (lastRow - 1);
        controlRef3.name = controlRef3.id;
        controlRef3.className = "form-control";
        controlRef3.value = "0";
        newCell3.appendChild(controlRef3);
        $("#" + controlRef3.id).attr("onkeypress", "return isDecimalKey(this, event)");
        $("#" + controlRef3.id).attr("oninput", "process(this)");

        var newCell4 = newRow.insertCell(4);
        var controlRef4 = document.createElement('input');
        controlRef4.type = 'text';
        controlRef4.id = containerId + '_txtPaymentMode_' + (lastRow - 1);
        controlRef4.name = controlRef4.id;
        controlRef4.className = "form-control";
        newCell4.appendChild(controlRef4);


        var newCell5 = newRow.insertCell(5);
        var controlRef5 = document.createElement('input');
        controlRef5.type = 'text';
        controlRef5.id = containerId + '_ckRemarks_' + (lastRow - 1);
        controlRef5.name = controlRef5.id;
        controlRef5.className = "form-control";
        newCell5.appendChild(controlRef5);
        CKEDITOR.replace(controlRef5.id);

        var newCell6 = newRow.insertCell(6);
        var controlRef6 = document.createElement('a');
        controlRef6.type = 'button';
        controlRef6.id = containerId + '_delete_' + (lastRow - 1);
        controlRef6.name = controlRef6.id;
        controlRef6.className = "btn btn-primary fa fa-trash";
        newCell6.appendChild(controlRef6);
        $("#" + controlRef6.id).attr("onclick", "delRow('ContentPlaceHolder1_grdPaymentDetails',this)")

        var id = 'ContentPlaceHolder1_grdPaymentDetails';
        $(`#${id} tbody tr`).each(function () {
            $(this).find('td:First a').hide();
        });

        $(`#${id} tbody tr:last`).find('td:First a').show();
        return false;
    }

    function SetPaymentDetails() {
        var tableRef = document.getElementById("ContentPlaceHolder1_grdPaymentDetails");
        var lastRow = tableRef.rows.length;
        var AllData = [];
        for (var i = 0; i < lastRow - 1; i++) {
            var data = {};
            data.ID = (i + 1).toString();
            data.Description = CKEDITOR.instances[tableRef.id + "_ckDescription_" + i].document.getBody().getText();//$("#" + tableRef.id + "_ckPaymentTerms_" + i).val();
            data.Amount = $("#" + tableRef.id + "_txtAmount_" + i).val();
            data.PaymentMode = $("#" + tableRef.id + "_txtPaymentMode_" + i).val();//$("#" + tableRef.id + "_ckPaymentTerms_" + i).val();
            data.Remark = CKEDITOR.instances[tableRef.id + "_ckRemarks_" + i].document.getBody().getText();//$("#" + tableRef.id + "_ckRemark_" + i).val();
            AllData.push(data);
        }
        $("#hdnSetPaymentDetails").val(JSON.stringify(AllData));

    }
    function AddRowInAttachment(containerId) {

        var tableRef = document.getElementById(containerId);
        var lastRow = tableRef.rows.length;

        // Add a row (<tr>) to the table/GridView...
        var newRow = tableRef.insertRow(lastRow);

        // Add a cell (<td>) to the row...
        var newCell = newRow.insertCell(0);
        var controlRef = document.createElement('a');
        controlRef.type = 'button';
        controlRef.id = containerId + '_link' + (lastRow - 1);
        controlRef.name = controlRef.id;
        controlRef.value = "Add"
        //controlRef.className = "addPaymentPlanRow";
        controlRef.innerHTML = "<img src='Icons/addicon.png' />";
        newCell.appendChild(controlRef);
        $("#" + controlRef.id).attr("onclick", "AddRowInAttachment('ContentPlaceHolder1_gvAttachment')")


        var newCell2 = newRow.insertCell(1);
        var controlRef2 = document.createElement('input');
        controlRef2.type = 'text';
        controlRef2.id = containerId + '_txtDescription_' + (lastRow - 1);
        controlRef2.name = controlRef2.id;
        // controlRef2.size = 20;
        controlRef2.className = "form-control";
        newCell2.appendChild(controlRef2);


        var newCell3 = newRow.insertCell(2);
        var controlRef3 = document.createElement('input');
        controlRef3.type = 'file';
        controlRef3.id = containerId + '_fudFile_' + (lastRow - 1);
        controlRef3.name = controlRef3.id;
        controlRef3.className = "form-control";
        newCell3.appendChild(controlRef3);
        $("#" + controlRef3.id).attr("onchange", "return pdfFileValidation(this);");


        var newCell4 = newRow.insertCell(3);
        var controlRef4 = document.createElement('input');
        controlRef4.type = 'file';
        controlRef4.id = containerId + '_fudImage_' + (lastRow - 1);
        controlRef4.name = controlRef4.id;
        controlRef4.className = "form-control";
        newCell4.appendChild(controlRef4);
        $("#" + controlRef4.id).attr("onchange", "return imageFileValidation(this);");



        var newCell6 = newRow.insertCell(4);
        var controlRef6 = document.createElement('a');
        controlRef6.type = 'button';
        controlRef6.id = containerId + '_delete_' + (lastRow - 1);
        controlRef6.name = controlRef6.id;
        controlRef6.className = "btn btn-primary fa fa-trash";
        newCell6.appendChild(controlRef6);
        $("#" + controlRef6.id).attr("onclick", "delRow('ContentPlaceHolder1_gvAttachment',this)")

        var id = 'ContentPlaceHolder1_gvAttachment';
        $(`#${id} tbody tr`).each(function () {
            $(this).find('td:First a').hide();
        });

        $(`#${id} tbody tr:last`).find('td:First a').show();
        return false;
    }


    function SetApprover() {
        var aData = [];
        var i = 1;
        $(".approver").each(function () {
            var data = {};
            data.ID = i;
            data.ApproverID = $(this).val();
            aData.push(data);
            i = i + 1;
        });
        $("#hdnApproverData").val(JSON.stringify(aData));

    }
    var fileName = "";
    var imageName = "";
    var ImageData = [];
    var FileData = [];
    function UploadImage(id, fileName, i) {

        var fileUpload = $("#" + id).get(0);
        var files = fileUpload.files;

        if (files.length > 0) {
            var extension = files[0].name.substring(files[0].name.lastIndexOf('.') + 1);
            imageName = fileName.toUpperCase() + "." + extension;
            //imageName = (files[0].name).replace(".png", "_").replace(".jpg", "_").replace(".jpeg", "_") + fileName.toUpperCase() + "." + extension;// "_" + (files[0].name);

            var formData = new FormData();

            if (files.length > 0) {
                formData.append("UploadedImage", files[0]);
            }
            $.ajax({
                type: "POST",
                url: "WebService.asmx/UploadCRMImage?FileName=" + imageName + "",
                contentType: false,
                processData: false,
                data: formData,
                success: function (result) {
                    console.log(result);
                    var d = JSON.parse(result);
                }
            });
        }
        else {
            if ($("#hdnID").val() != "") {
                imageName = $("#ContentPlaceHolder1_gvAttachment_lnkDownloadDocImage_" + i).text();
            }
            else {
                imageName = "";
            }

        }
    }
    function UploadFile(id, name, i) {

        var fileUpload1 = $("#" + id).get(0);
        var files1 = fileUpload1.files;
        if (files1.length > 0) {
            var extension = files1[0].name.substring(files1[0].name.lastIndexOf('.') + 1);
            fileName = name.toUpperCase() + "." + extension;
            //fileName = (files1[0].name).replace(".pdf", "_") + name.toUpperCase() + "." + extension;// "_" + (files[0].name);

            var formData1 = new FormData();
            if (files1.length > 0) {
                formData1.append("UploadedFile", files1[0]);
            }
            // var ajaxRequest =
            $.ajax({
                type: "POST",
                url: "WebService.asmx/UploadCRMFile?FileName=" + fileName + "",
                contentType: false,
                processData: false,
                data: formData1,
                success: function (result) {
                    var d = JSON.parse(result);
                }
            });
        }
        else {

            if ($("#hdnID").val() != "") {
                fileName = $("#ContentPlaceHolder1_gvAttachment_lnkDownloadDocFile_" + i).text();
            }
            else {
                fileName = "";
            }

        }
    }
    function sleep(milliseconds) {
        const date = Date.now();
        let currentDate = null;
        do {
            currentDate = Date.now();
        } while (currentDate - date < milliseconds);
    }
    function SetAttachment() {
        var tableRef = document.getElementById("ContentPlaceHolder1_gvAttachment");
        var lastRow = tableRef.rows.length;
        var fArray = [];

        for (var i = 0; i < lastRow - 1; i++) {

            var f_id = tableRef.id + "_fudImage_" + i;

            imageName = Date.now().toString(36) + Math.random().toString(36).substring(2);
            UploadImage(f_id, imageName, i);
            var fl_id = tableRef.id + "_fudFile_" + i;
            fileName = Date.now().toString(36) + Math.random().toString(36).substring(2);
            UploadFile(fl_id, fileName, i);
            sleep(1000);

            var jsonArray = {};

            jsonArray.ID = (i + 1).toString();
            jsonArray.Description = $("#" + tableRef.id + "_txtDescription_" + i).val();
            jsonArray.DocFile = fileName;
            jsonArray.DocImage = imageName;
            fArray.push(jsonArray);
        }
        console.log(JSON.stringify(fArray));
        $("#hdnAttachmentData").val(JSON.stringify(fArray));
    }

    function SetData() {
        SetAttachment();
        SetApprover();
        SetPaymentPlan();
        SetPaymentDetails();
    }
// -->
    </script>
</asp:Content>

