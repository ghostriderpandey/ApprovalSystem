<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="PurchaseLogicNote.aspx.cs" Inherits="AdminPanel_PurchaseLogicNote" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
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

    function fillVariationofBudget() {
        var dblapprovalBudget = $('#<%=txtApprovalBudget.ClientID %>').val();
        var dblProposedvalueofaward = $('#<%=txtProposedvalueofaward.ClientID %>').val();
        var dblBalancetobeaward = $('#<%=txtBalancetobeaward.ClientID %>').val();
        var dblAlreadyAwarded = $('#<%=txtAlreadyAwarded.ClientID %>').val();
        var dblVaritaion = 0;
        dblVaritaion = (dblapprovalBudget - dblAlreadyAwarded - dblProposedvalueofaward - dblBalancetobeaward);
        $('#<%=txtvariationfrombudget.ClientID %>').val(dblVaritaion.toFixed(2));
        if ($('#<%=txtvariationfrombudget.ClientID %>').val() > 0)
            $('#<%=txtvariationfrombudget.ClientID %>').css("color", "Green");
        else if ($('#<%=txtvariationfrombudget.ClientID %>').val() < 0)
            $('#<%=txtvariationfrombudget.ClientID %>').css("color", "Red");
    }

    function FillVendorCal() {
        var dblTotalVendor = $('#<%=txtTotalVendorConsidred.ClientID %>').val();
        var dblRejectedVendor = $('#<%=txtRejectedVendor.ClientID %>').val();
        var dblRFQinvited = 0;
        var dblNotQuoted = $('#<%=txtNotQuoted.ClientID %>').val();;
        var dblFinalConsidered = 0;
        dblRFQinvited = dblTotalVendor - dblRejectedVendor;
        $('#<%=txtRFQInvited.ClientID %>').val(dblRFQinvited.toFixed(2));
        dblFinalConsidered = dblRFQinvited - dblNotQuoted;
        $('#<%=txtFinalConsidered.ClientID %>').val(dblFinalConsidered.toFixed(2));
    }

    function ddlChange() {
        var url = window.location.href;
        if (url.indexOf('?id=') != -1) {
            deleteAllCookies()
            setCookie("Projectaddress", "", 30);
        }

        $('#<%=txtSubjectScope.ClientID %>').keyup(function () {
            var maxLength = $(this).val().length;
            if (maxLength >= 200) {
                $(this).val('');
                alert('You cannot enter more than 200 chars');
                return false;
            }
        });
        $('#<%=txtSubjectScope.ClientID %>').keypress(function () {
            var maxLength = $(this).val().length;
            if (maxLength >= 200) {
                alert('You cannot enter more than 200 chars');
                return false;
            }
        });

        $('#<%=txtSingleRepeatOrderReson.ClientID %>').keypress(function () {
            var maxLength = $(this).val().length;
            if (maxLength >= 1000) {
                alert('You cannot enter more than 1000 chars');
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
        $('#<%=txtother.ClientID %>').keypress(function () {
            var maxLength = $(this).val().length;
            if (maxLength >= 100) {
                alert('You cannot enter more than 100 chars');
                return false;
            }
        });

        $("#<%=ddlType.ClientID %>").change(function () {
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
        }).change();

        $("#<%=ddlRequirement.ClientID %>").change(function () {

            if ($(this).val() == "Urgent") {
                $('#<%=txtUrgetResionDescription.ClientID %>').val("");
                $('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", false);
                ValidatorEnable($("#<%=RFVUrgetReason.ClientID %>")[0], true);
            }
            else {
                $('#<%=txtUrgetResionDescription.ClientID %>').val("");
                $('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", true);
                ValidatorEnable($("#<%=RFVUrgetReason.ClientID %>")[0], false);
            }
        }).change();

        $("#<%=ddlReasonofvariation.ClientID %>").change(function () {
            if ($(this).val() == "Others") {
                // $('#<%=txtother.ClientID %>').val("");
                $('#<%=txtother.ClientID%>').prop("readonly", false);
                ValidatorEnable($("#<%=rvreasonforothers.ClientID %>")[0], true);
            }
            else {
                $('#<%=txtother.ClientID %>').val("");
                $('#<%=txtother.ClientID%>').prop("readonly", true);
                ValidatorEnable($("#<%=rvreasonforothers.ClientID %>")[0], false);
            }
        }).change();

        $("#<%=ddlBidType.ClientID %>").change(function () {
            if ($(this).val() == "Single Quote" || $(this).val() == "Repeat Order") {
                //$('#<%=txtSingleRepeatOrderReson.ClientID %>').val("");
                $('#<%=txtSingleRepeatOrderReson.ClientID%>').prop("readonly", false);
            }
            else {
                $('#<%=txtSingleRepeatOrderReson.ClientID %>').val("");
                $('#<%=txtSingleRepeatOrderReson.ClientID%>').prop("readonly", true);
            }
        }).change();

        $("#<%=ddlActionType.ClientID %>").change(function () {
            if ($(this).val() == "Manual") {
                $('#<%=txtDateofAribaAuction.ClientID %>').val("");
                $('#<%=txtDateofAribaAuction.ClientID%>').prop("readonly", true);

            }
            else {
                // $('#<%=txtDateofAribaAuction.ClientID %>').val("");
                $('#<%=txtDateofAribaAuction.ClientID%>').prop("readonly", false);

            }
        }).change();
        $("#<%=ddllocation.ClientID %>").change(function () {
            if ($(this).val() != '' || $(this).val() != 0) {
                $('#<%=hddlocationId.ClientID %>').val($(this).val());
            }
        })
    };

    function ddlProjectName() {
        debugger;
        $("#<%=ddlprojectname.ClientID %>").change(function () {

            $.ajax({
                type: "POST",
                url: "PurchaseLogicNote.aspx/getPorjectAddress",
                data: "{ 'projectId': '" + $(this).val() + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (result) {
                    setCookie("Projectaddress", result.d, 30);
                    $('#<%=txtProjectaddress.ClientID %>').val(result.d);
                }
            });

            if ($(this).val() == 0) {
                deleteAllCookies()
                setCookie("Projectaddress", "", 30);

            }
            else {
                $.ajax({
                    type: "POST",
                    url: "PurchaseLogicNote.aspx/getPorjectLocation",
                    data: "{ 'projectId': '" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (r) {
                        var ddllocation = $('#<%=ddllocation.ClientID %>');
                        ddllocation.empty().append('<option  value="0">Please select</option>');
                        $.each(r.d, function () {
                            ddllocation.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });

                        var optionExists = ($("#<%=ddllocation.ClientID %> option[value=" + $('#<%=hddlocationId.ClientID %>').val() + "]").length > 0);

                        if (optionExists == true)
                            $('#<%=ddllocation.ClientID %>').val($('#<%=hddlocationId.ClientID %>').val())
                        else
                            $('#<%=hddlocationId.ClientID %>').val(0);
                    }
                });
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
        transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
      <div class="loading-overlay">
        <div class="wrapper">
          <div class="ajax-loader-outer"> </div>
        </div>
      </div>
    </ProgressTemplate>
  </asp:UpdateProgress>
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="text-center blue">Purchase Logic Note Details</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content PurchaseLogicNote-top">
            <div class="row">
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold"> Approval Authority<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlapprovalauthrity" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Authrity"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlapprovalauthrity" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Type<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Direct Purchase">Direct Purchase</asp:ListItem>
                    <asp:ListItem Value="Rate Approval">Rate Approval</asp:ListItem>
                    <asp:ListItem Value="Regularization of Purchase">Regularization of Purchase</asp:ListItem>
                    <asp:ListItem Value="Regularization of Rate Approval">Regularization of Rate Approval</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Select Type"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlType" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                  <div class="form-group">
                      <label for="exampleInputEmail1" class="font-weight-bold">Subject & Scope <span class="small spnRequired">Max 200 Character *</span></label>
                      <asp:TextBox ID="txtSubjectScope" TextMode="MultiLine" Rows="1" PlaceHolder="Subject & Scope" runat="server" class="form-control"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" runat="server" ErrorMessage="Please Enter Subject Scope"
                          ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSubjectScope"></asp:RequiredFieldValidator>
                  </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Project Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlprojectname" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please Select Project Name"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlprojectname" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Address</label>
                  <asp:TextBox ID="txtProjectaddress" EnableViewState="true" runat="server" TextMode="MultiLine" Rows="1" placeholder="Project Address" ReadOnly="true" class="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Location Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddllocation" EnableViewState="true" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:HiddenField ID="hddlocationId" runat="server" Value="0" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator32" ForeColor="Red" runat="server" ErrorMessage="Please Select Location Name"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddllocation" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Department Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlDepartment" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Select Department Name"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlDepartment" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Indent Proponent</label>
                  <asp:TextBox ID="txtIndentProponent" runat="server" PlaceHolder="Indent Proponent" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Indent Proponent"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtIndentProponent"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Date of indent</label>
                  <asp:TextBox ID="txtDateofindent" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Date of indent"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtDateofindent"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Material needed by</label>
                  <asp:TextBox ID="txtMaterialneededby" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator21" ForeColor="Red" runat="server" ErrorMessage="Please Enter Material needed by"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtMaterialneededby"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Stock in Hand</label>
                  <br />
                    <div class="d-flex">
                  <asp:TextBox ID="txtStockinHand" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" Width="45%" PlaceHolder="Stock"></asp:TextBox>
                  <asp:DropDownList ID="ddlStockinhandUOM" runat="server" Width="50%" class="form-control ml-3 selectcss"> </asp:DropDownList></div>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Stock in Hand"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtStockinHand"></asp:RequiredFieldValidator>--%>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Select Stock UOM"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlStockinhandUOM" InitialValue="0"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Requirement<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlRequirement" runat="server" class="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Normal">Normal</asp:ListItem>
                    <asp:ListItem Value="Urgent">Urgent</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator24" ForeColor="Red" runat="server" ErrorMessage="Please Select Requirement"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlRequirement" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Urgent Reason Desc<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtUrgetResionDescription" runat="server" TextMode="MultiLine" Rows="1" placeholder="Urgent Reason Desc" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RFVUrgetReason" ForeColor="Red" runat="server" ErrorMessage="Please Enter Urgent Reason Desc"
                                        ValidationGroup="V" InitialValue="0" Display="Dynamic" ControlToValidate="txtUrgetResionDescription"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Saleable Area <span class="small">(Sq. Ft.)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtSaleableArea" runat="server" onkeypress="return isNumberKey(event);" Text="0" PlaceHolder="Saleable Area" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtSaleableArea_TextChanged"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Saleable Area"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSaleableArea"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Approved Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtApprovalBudget" runat="server" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Approved Budget" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approved Budget"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtApprovalBudget"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Already Awarded <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtAlreadyAwarded" runat="server" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Already Awarded" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" runat="server" ErrorMessage="Please Enter Already Awarded"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtAlreadyAwarded"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Proposed Value of this award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtProposedvalueofaward" runat="server" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Proposed Value" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" runat="server" ErrorMessage="Please Enter Proposed Value"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtProposedvalueofaward"></asp:RequiredFieldValidator>
                </div>
              </div>
               <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Balance to be award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtBalancetobeaward" runat="server" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Balance Value" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="Red" runat="server" ErrorMessage="Please Enter Balance to be award"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtBalancetobeaward"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold" style="display: block">Variation from Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtvariationfrombudget" EnableViewState="true" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Variation from Budget" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ForeColor="Red" runat="server" ErrorMessage="Please Enter Variation Budget"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtvariationfrombudget"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason of variation<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlReasonofvariation" runat="server" CssClass="form-control selectcss">
                    <asp:ListItem Value="0">Select One</asp:ListItem>
                    <asp:ListItem Value="Architectural Design Change">Architectural Design Change</asp:ListItem>
                    <asp:ListItem Value="Structural design change">Structural design change</asp:ListItem>
                    <asp:ListItem Value="Change in material specifications">Change in material specifications</asp:ListItem>
                    <asp:ListItem Value="Change in price">Change in price</asp:ListItem>
                    <asp:ListItem Value="Change in taxes">Change in taxes</asp:ListItem>
                    <asp:ListItem Value="Non-Budgeted">Non-Budgeted</asp:ListItem>
                    <asp:ListItem Value="Additional Work">Additional Work</asp:ListItem>
                    <asp:ListItem Value="Negotiation">Negotiation</asp:ListItem>
                    <asp:ListItem Value="Others">Others</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rvreasonforvariation" ForeColor="Red" runat="server" ErrorMessage="Please Select Reason of variation"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlReasonofvariation" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason for Others<span class="small spnRequired">Max 100 Character *</span></label>
                 <asp:TextBox ID="txtother" EnableViewState="false" runat="server" CssClass="form-control" placeholder="Reason For Others"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rvreasonforothers" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reason for Others"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtother"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold"> Name of Proposed Vendor <span class="small spnRequired"> <a href="VendorMaster.aspx" target="_blank" title="Click to add new vendor">Add Vendor</a> </span><span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlnameofproposedvendor" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator25" ForeColor="Red" runat="server" ErrorMessage="Please Select Name of Proposed Vendor"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlnameofproposedvendor"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Negotiation Mode<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlNegotationMode" runat="server" CssClass="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Ariba">Ariba</asp:ListItem>
                    <asp:ListItem Value="Manual">Manual</asp:ListItem>
                    <asp:ListItem Value="Both - Ariba & Manual">Both - Ariba & Manual</asp:ListItem>
                    <asp:ListItem Value="Final negotiation after ariba">Final negotiation after ariba</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ForeColor="Red" runat="server" ErrorMessage="Please Select Negotiation Mode"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlNegotationMode" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Commercial rating of Bid<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtCommercialratingofbid" runat="server" PlaceHolder="Commercial Bid" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ForeColor="Red" runat="server" ErrorMessage="Please Enter Commercial rating of Bid"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtCommercialratingofbid"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold" style="display: block;">Proposed time line by vendor<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtProposedtimelineDate" runat="server" Width="80%" CssClass="form-control" type="date"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ForeColor="Red" runat="server" ErrorMessage="Please Enter Proposed time line by vendor"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtProposedtimelineDate"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Responsible Person<span class="small spnRequired">*</span></label>
                  <asp:TextBox ID="txtresponsibleperson" EnableViewState="false" runat="server" CssClass="form-control" placeholder="Responsible Person"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="Red" runat="server" ErrorMessage="Please Enter Responsible Person"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtresponsibleperson"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Material Used By Date<span class="small spnRequired">*</span></label>
                  <asp:TextBox ID="txtmaterialuserdate" EnableViewState="false" type="date" runat="server" CssClass="form-control " ></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator36" ForeColor="Red" runat="server" ErrorMessage="Please Enter Material Used By Date"
                                        ValidationGroup="V" Display="Dynamic"  ControlToValidate="txtmaterialuserdate"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Place of Use<span class="small spnRequired">*</span></label>
                  <asp:TextBox ID="txtplaceofuse" EnableViewState="false" runat="server" CssClass="form-control" placeholder="Place of Use"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator38" ForeColor="Red" runat="server" ErrorMessage="Please Enter Place of Use"
                                        ValidationGroup="V" Display="Dynamic"  ControlToValidate="txtplaceofuse"></asp:RequiredFieldValidator>
                </div>
              </div>
              
            </div>
          </div>
  </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title text-center">
            <h2 class="blue center">Major deviation & recommendation in terms-conditions (if any)/Exception</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <asp:GridView ID="gvStandardexception" runat="server" AutoGenerateColumns="False"
                            class="table table-bordered table-hover" OnRowCommand="gvStandardexception_RowCommand" OnRowDeleting="gvStandardexception_RowDeleting" OnPreRender="gvStandardexception_PreRender" OnRowDataBound="gvStandardexception_RowDataBound">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                  <asp:HiddenField ID="hddSEID" runat="server" Value='<%#Eval("ID") %>' />
                  <asp:HiddenField ID="hddRecommendation" runat="server" Value='<%#Eval("Recommendation") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Standard">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("Standard") %>' ID="ckStandrad" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Exception">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("Excepetion") %>' ID="ckExcepetion" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Recommendation">
                <ItemTemplate>
                  <%--  <asp:DropDownList ID="ddlRecommendation" runat="server" class="form-control">
                                                <asp:ListItem Value="0">Select One</asp:ListItem>
                                                <asp:ListItem Value="May be accepted">May be accepted</asp:ListItem>
                                                <asp:ListItem Value="may be rejected">may be rejected</asp:ListItem>
                                                <asp:ListItem Value="send back for amendent">send back for amendent</asp:ListItem>
                                            </asp:DropDownList>--%>
                  <asp:TextBox ID="txtrecommandation" runat="server" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="txtrecommandation" ValidationGroup="V" runat="server" ErrorMessage="Please Enter Recommandation" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Evaluation</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="row">
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Vendor considered<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtTotalVendorConsidred" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" placeholder="Total vendor considered" class="form-control" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total vendor considered"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalVendorConsidred"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Rejected Vendors<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRejectedVendor" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Rejected Vendors" CssClass="form-control" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rejected Vendors"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRejectedVendor"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">RFQ invited<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRFQInvited" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" placeholer=""></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator26" ForeColor="Red" runat="server" ErrorMessage="Please Enter RFQ invited"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRFQInvited"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Not quoted<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtNotQuoted" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" Placeholder="Not quoted" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ForeColor="Red" runat="server" ErrorMessage="Please Enter Not quoted"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtNotQuoted"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Final Considered<span class="spnRequired">*</span></label>
                  <br />
                  <asp:TextBox ID="txtFinalConsidered" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" PlaceHolder="Final Considered"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator28" ForeColor="Red" runat="server" ErrorMessage="Please Enter Final Considered"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtFinalConsidered"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Stipulated Completion Time<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtStipulatedCompletionTime" runat="server" type="date" CssClass="form-control" PlaceHolder="Stipulated Completion Time"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator29" ForeColor="Red" runat="server" ErrorMessage="Please Enter Stipulated Completion Time"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtStipulatedCompletionTime"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Bid Type<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlBidType" runat="server" class="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Single Quote">Single Quote</asp:ListItem>
                    <asp:ListItem Value="Repeat Order">Repeat Order</asp:ListItem>
                    <asp:ListItem Value="Multiple Quote">Multiple Quote</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator30" ForeColor="Red" runat="server" ErrorMessage="Please Select Bid Type"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlBidType" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Approval type<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlApprovaltype" runat="server" class="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Regularization of Purchase">Regularization of Purchase</asp:ListItem>
                    <asp:ListItem Value="Regularization of Rate Approval">Regularization of Rate Approval</asp:ListItem>
                    <asp:ListItem Value="Base Rate">Base Rate</asp:ListItem>
                    <asp:ListItem Value="Actual Purchase">Actual Purchase</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator31" ForeColor="Red" runat="server" ErrorMessage="Please Enter Select Approval type"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlApprovaltype"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Contractor Name</label>
                  <asp:TextBox ID="txtContratorName" EnableViewState="false" runat="server" PlaceHolder="Contractor Name" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator32" ForeColor="Red" runat="server" ErrorMessage="Please Enter Contractor Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtContratorName"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Auction Type<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlActionType" runat="server" class="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Ariba">Ariba</asp:ListItem>
                    <asp:ListItem Value="Manual">Manual</asp:ListItem>
                    <asp:ListItem Value="Both - Ariba & Manual">Both - Ariba & Manual</asp:ListItem>
                    <asp:ListItem Value="Final negotiation after ariba">Final negotiation after ariba</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator33" ForeColor="Red" runat="server" ErrorMessage="Please Select Auction Type"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlActionType"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Date of Ariba Auction</label>
                  <asp:TextBox ID="txtDateofAribaAuction" EnableViewState="false" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold"> Single quote/repeat order - reason to be mention </label>
                  <asp:TextBox ID="txtSingleRepeatOrderReson" EnableViewState="false" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="1"></asp:TextBox>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Bid Evaluation <span class="small spnRequired"> <a href="ItemMaster.aspx" target="_blank" title="Click to add new Item">Add New Item</a> </span><span class="spnRequired">*</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content table-responsive">
            <asp:GridView ID="gvItemHead" runat="server" AutoGenerateColumns="False" ShowFooter="true"
                            class="table table-bordered table-hover" OnRowCommand="gvItemHead_RowCommand" OnRowDeleting="gvItemHead_RowDeleting" OnPreRender="gvItemHead_PreRender" OnRowDataBound="gvItemHead_RowDataBound">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                  <asp:HiddenField ID="hddIHID" runat="server" Value='<%#Eval("ID") %>' />
                  <asp:HiddenField ID="hddItemHead" runat="server" Value='<%#Eval("ItemHead") %>' />
                  <asp:HiddenField ID="hddUOM" runat="server" Value='<%#Eval("UOM") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="SNo">
                <ItemTemplate> <%#Container.DataItemIndex+1%> </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Item Head">
                <ItemTemplate>
                  <asp:DropDownList ID="ddlItemHead" Width="120px" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvPrice" ControlToValidate="ddlItemHead" ValidationGroup="V" runat="server"
                                            ErrorMessage="Item Head Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Button Text="Calculate" CommandName="Calculate" runat="server" />
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="UOM">
                <ItemTemplate>
                  <asp:DropDownList ID="ddlUOM" Width="120px" runat="server" class="form-control selectcss"> </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlUOM" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="UOM Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                  <asp:TextBox ID="txtQuantity" Width="120px" AutoPostBack="true" OnTextChanged="txtQuantity_TextChanged" Text='<%#Eval("Quantity") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice2" ControlToValidate="txtQuantity" ValidationGroup="V" runat="server" ErrorMessage="Quantity Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor1 Rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor1Rate" Width="120px" AutoPostBack="true" OnTextChanged="txtVendor1Rate_TextChanged" Text='<%#Eval("V1Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice3" ControlToValidate="txtVendor1Rate" ValidationGroup="V" runat="server" ErrorMessage="V1Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor1 Value">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor1Value" Width="120px" Text='<%#Eval("V1Value") %>' ReadOnly="true" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice4" ControlToValidate="txtVendor1Value" ValidationGroup="V" runat="server" ErrorMessage="V1Value Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor2 Rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor2Rate" Width="120px" AutoPostBack="true" OnTextChanged="txtVendor2Rate_TextChanged" Text='<%#Eval("V2Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice5" ControlToValidate="txtVendor2Rate" ValidationGroup="V" runat="server" ErrorMessage="V2Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor2 Value">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor2Value" Width="120px" Text='<%#Eval("V2Value") %>' ReadOnly="true" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice6" ControlToValidate="txtVendor2Value" ValidationGroup="V" runat="server" ErrorMessage="V2Value Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor3 Rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor3Rate" Width="120px" AutoPostBack="true" OnTextChanged="txtVendor3Rate_TextChanged" Text='<%#Eval("V3Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice7" ControlToValidate="txtVendor3Rate" ValidationGroup="V" runat="server" ErrorMessage="V3Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor3 Value">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor3Value" Width="120px" Text='<%#Eval("V3Value") %>' ReadOnly="true" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice8" ControlToValidate="txtVendor3Value" ValidationGroup="V" runat="server" ErrorMessage="V3Value Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Budgeted base rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtBudgetRate" Width="120px" Text='<%#Eval("BaseRate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice9" ControlToValidate="txtBudgetRate" ValidationGroup="V" runat="server" ErrorMessage="BaseRate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Target Cost">
                <ItemTemplate>
                  <asp:TextBox ID="txtTargetCost" Width="120px" Text='<%#Eval("TargetCost") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice10" ControlToValidate="txtTargetCost" ValidationGroup="V" runat="server" ErrorMessage="TargetCost Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Previous Rates">
                <ItemTemplate>
                  <asp:TextBox ID="txtPreviousRates" Width="120px" Text='<%#Eval("PreviousRate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice11" ControlToValidate="txtPreviousRates" ValidationGroup="V" runat="server" ErrorMessage="PreviousRate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
          <div class="x_content table-responsive">
            <div class="col-sm-12">
              <div class="col-sm-3"></div>
              <div class="col-sm-3">
                <h4>Vendor 1<span class="spnRequired">*</span></h4>
              </div>
              <div class="col-sm-3">
                <h4>Vendor 2</h4>
              </div>
              <div class="col-sm-3">
                <h4>Vendor 3</h4>
              </div>
            </div>
            <div class="col-sm-12">
              <div class="col-sm-3">
                <h4>Vendor</h4>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor1" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlVendor1"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor2" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor3" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>GST</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV1GST" runat="server" PlaceHolder="GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 GST"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1GST"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV2GST" runat="server" PlaceHolder="GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV3GST" runat="server" PlaceHolder="GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>Freight</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV1Freight" runat="server" PlaceHolder="Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Freight"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1Freight"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV2Freight" runat="server" PlaceHolder="Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2Freight"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV3Freight" runat="server" PlaceHolder="Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
              <div class="col-sm-12 mt-1">
                  <div class="col-sm-3">
                      <h4>Handling/Insurance Charge</h4>
                  </div>
                  <div class="col-sm-3">
                      <asp:TextBox ID="txtV1handling" runat="server" PlaceHolder="Handling Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator41" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Handling Charges"
                          ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1handling"></asp:RequiredFieldValidator>
                  </div>
                  <div class="col-sm-3">
                      <asp:TextBox ID="txtV2handling" runat="server" PlaceHolder="Handling Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2Freight"></asp:RequiredFieldValidator>--%>
                  </div>
                  <div class="col-sm-3">
                      <asp:TextBox ID="txtV3handling" runat="server" PlaceHolder="Handling Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
                  </div>
              </div>
               <div class="col-sm-12 mt-1">
                  <div class="col-sm-3">
                      <h4>Other Charge</h4>
                  </div>
                  <div class="col-sm-3">
                      <asp:TextBox ID="txtV1OtherCharge" runat="server" PlaceHolder="Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="rfvV1OtherCharge" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Other Charges"
                          ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1OtherCharge"></asp:RequiredFieldValidator>
                  </div>
                  <div class="col-sm-3">
                      <asp:TextBox ID="txtV2OtherCharge" runat="server" PlaceHolder="Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2Freight"></asp:RequiredFieldValidator>--%>
                  </div>
                  <div class="col-sm-3">
                      <asp:TextBox ID="txtV3OtherCharge" runat="server" PlaceHolder="Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
                  </div>
              </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>TCS</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV1HeadlingCharges" runat="server" PlaceHolder="Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Handling Charges"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1HeadlingCharges"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV2HeadlingCharges" runat="server" PlaceHolder="Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV3HeadlingCharges" runat="server" PlaceHolder="Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4 style="display: contents;">Grand Total</h4>
                <asp:Button ID="btnGrandTotal" Style="float: right;" OnClick="btnGrandTotal_Click" Text="Calculate" CommandName="Calculate" runat="server" />
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV1GrandTotal" runat="server" ReadOnly="true" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Grand Total"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1GrandTotal"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV2GrandTotal" runat="server" ReadOnly="true" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV3GrandTotal" runat="server" ReadOnly="true" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>Delivery Timeline</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor1DeliveryTimeline" runat="server" type="date" PlaceHolder="Delivery Timeline" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator34" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Delivery Timeline"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1DeliveryTimeline"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor2DeliveryTimeline" runat="server" type="date" PlaceHolder="Delivery Timeline" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator35" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor3DeliveryTimeline" runat="server" type="date" PlaceHolder="Delivery Timeline" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator36" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>Comparision with Budgeted Rate</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor1Comparision" runat="server" PlaceHolder="Comparision with Budgeted Rate" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator37" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Comparision with Budgeted Rate"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1Comparision"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor2Comparision" runat="server" PlaceHolder="Comparision with Budgeted Rate" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator38" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Comparision with Budgeted Rate"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2Comparision"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor3Comparision" runat="server" PlaceHolder="Comparision with Budgeted Rate" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator39" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Comparision with Budgeted Rate"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3Comparision"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>Bids Status</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor1BidStatus" ReadOnly="false" runat="server" PlaceHolder="Bids Status" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator40" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bids Status"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1BidStatus"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor2BidStatus" ReadOnly="false" runat="server" PlaceHolder="Bids Status" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator41" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bids Status"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2BidStatus"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor3BidStatus" ReadOnly="false" runat="server" PlaceHolder="Bids Status" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator42" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bids Status"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3BidStatus"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>Vendor Ratings</h4>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor1Rating" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="A">A</asp:ListItem>
                  <asp:ListItem Value="B">B</asp:ListItem>
                  <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator43" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1 Vendor Ratings"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlVendor1Rating"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor2Rating" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="A">A</asp:ListItem>
                  <asp:ListItem Value="B">B</asp:ListItem>
                  <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator44" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Vendor Ratings"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2Rating"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor3Rating" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="A">A</asp:ListItem>
                  <asp:ListItem Value="B">B</asp:ListItem>
                  <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator45" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Vendor Ratings"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3Rating"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>Award Preference</h4>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor1AwardPreference" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="P1">P1</asp:ListItem>
                  <asp:ListItem Value="P2">P2</asp:ListItem>
                  <asp:ListItem Value="P3">P3</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator46" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1 Award Preference"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlVendor1AwardPreference"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor2AwardPreference" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="P1">P1</asp:ListItem>
                  <asp:ListItem Value="P2">P2</asp:ListItem>
                  <asp:ListItem Value="P3">P3</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator47" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor3AwardPreference" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="P1">P1</asp:ListItem>
                  <asp:ListItem Value="P2">P2</asp:ListItem>
                  <asp:ListItem Value="P3">P3</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator48" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-12 mt-1">
              <div class="col-sm-3">
                <h4>Cost Per Sqft</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor1CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Cost per Sqft"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1CostPerSqft"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor2CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator47" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor3CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator48" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Deviation from Tender/ RFQ, if any</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <asp:GridView ID="gvDeviationfromtender" runat="server" AutoGenerateColumns="False"
                            class="table table-bordered table-hover" OnRowCommand="gvDeviationfromtender_RowCommand" OnRowDeleting="gvDeviationfromtender_RowDeleting" OnPreRender="gvDeviationfromtender_PreRender">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                  <asp:HiddenField ID="hddDFTID" runat="server" Value='<%#Eval("ID") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Standard Terms">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("StandardTerms") %>' ID="ckDFTStandrad" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Deviation by Preference-1">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("Preference1") %>' ID="ckDFTPreference1" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Deviation by Preference-2">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("Preference2") %>' ID="ckDFTPreference2" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Prevailing Market Practise">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("PrevailingMarkrtPractise") %>' ID="ckDFTPrevailingMarket" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                  <asp:RequiredFieldValidator ID="rfvPrevailing" ControlToValidate="ckDFTPrevailingMarket" ValidationGroup="V" runat="server" ErrorMessage="Prevailing Markrt Practise Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Vendor Evaluation</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="row">
              <div class="col-sm-12">
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
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Add Approver</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
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
                              <asp:DropDownList ID="ddlApprover" runat="server" class="form-control selectcss"></asp:DropDownList>
                              <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlApprover" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="Approver Required" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Delete">
                          <ItemTemplate>
                              <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
              </asp:GridView>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Terms & Conditions</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <asp:GridView ID="gvTermsandCondition" runat="server" AutoGenerateColumns="False"
                            class="table table-bordered table-hover" OnRowCommand="gvTermsandCondition_RowCommand" OnRowDeleting="gvTermsandCondition_RowDeleting" OnPreRender="gvTermsandCondition_PreRender">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                  <asp:HiddenField ID="hddTCID" runat="server" Value='<%#Eval("ID") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Terms">
                <ItemTemplate>
                  <CKEditor:CKEditorControl ID="ckTCTerms" Text='<%#Eval("Terms") %>' runat="server" Toolbar="Basic" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Standard Terms">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" ID="ckTCStandrad" Text='<%#Eval("StandardTerms") %>' CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Deviation by Preference-1">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" ID="ckTCPreference1" Text='<%#Eval("Preference1") %>' CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Deviation by Preference-2">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" ID="ckTCPreference2" Text='<%#Eval("Preference2") %>' CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Add Attachment</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <asp:GridView ID="gvAttachment" runat="server" AutoGenerateColumns="False"
                            class="table table-bordered table-hover" OnRowCommand="gvAttachment_RowCommand" OnRowDataBound="gvAttachment_RowDataBound" OnRowDeleting="gvAttachment_RowDeleting" OnPreRender="gvAttachment_PreRender">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                  <asp:HiddenField ID="hddAttachmentID" runat="server" Value='<%#Eval("ID") %>' />
                  <asp:HiddenField ID="hddCategory" runat="server" Value='<%#Eval("Category") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Category">
                <ItemTemplate>
                  <asp:DropDownList ID="ddlAttechmentCategory" runat="server" class="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Logic Note">Logic Note</asp:ListItem>
                    <asp:ListItem Value="Delivery Schedule">Delivery Schedule</asp:ListItem>
                    <asp:ListItem Value="Budget Approval">Budget Approval</asp:ListItem>
                    <asp:ListItem Value="Bid Evaluation">Bid Evaluation</asp:ListItem>
                    <asp:ListItem Value="Prior Approvals">Prior Approvals</asp:ListItem>
                    <asp:ListItem Value="Drawings">Drawings</asp:ListItem>
                    <asp:ListItem Value="Indent">Indent</asp:ListItem>
                    <asp:ListItem Value="Others">Others</asp:ListItem>
                  </asp:DropDownList>
                  <%--<asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="txtDescription" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Description">
                <ItemTemplate>
                  <asp:TextBox ID="txtDescription" runat="server" class="form-control" Text='<%#Eval("Description") %>'></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="txtDescription" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="File">
                <ItemTemplate>
                  <asp:FileUpload ID="fudFile" EnableViewState="true" runat="server" class="form-control"></asp:FileUpload>
                  <asp:LinkButton ID="lnkDownloadDocFile" Text='<%#Eval("DocFile") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocFile")  %>' CommandName="Download" runat="server" />
                  <asp:RegularExpressionValidator ID="revfudFile" SetFocusOnError="true" ValidationExpression="([a-zA-Z0-9\s_\\~!@$%^*()#&+-\.\-:])+(.pdf|.PDF)$"
                                            ControlToValidate="fudFile" runat="server" ForeColor="Red" ErrorMessage="Please select a valid  PDF file."
                                            Display="Dynamic" />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                  <asp:FileUpload ID="fudImage" EnableViewState="true" runat="server" class="form-control"></asp:FileUpload>
                  <asp:LinkButton ID="lnkDownloadDocImage" runat="server" Text='<%# Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" ToolTip="Download Image"></asp:LinkButton>
                  <asp:RegularExpressionValidator ID="revfudImage" SetFocusOnError="true" ValidationExpression="([a-zA-Z0-9\s_\\~!@$%^*()#&+-\.\-:])+(.jpg|.jpeg|.png|.JPG|.JPEG|.PNG)$"
                                            ControlToValidate="fudImage" runat="server" ForeColor="Red" ErrorMessage="Please select a valid  JPG OR JPEG OR PNG file."
                                            Display="Dynamic" />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Remark<span class="spnRequired">*</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="w-100">
              <CKEditor:CKEditorControl Toolbar="Basic" ID="ckremark" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator35" ForeColor="Red" runat="server" ErrorMessage="Please Enter Remark"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="ckremark"></asp:RequiredFieldValidator>
            </div>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2>Purchase Head<span class="spnRequired">*</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="w-100">
              <CKEditor:CKEditorControl Toolbar="Basic" ID="ckPurchaseHead" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator49" ForeColor="Red" runat="server" ErrorMessage="Please Enter Purchase Head"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="ckPurchaseHead"></asp:RequiredFieldValidator>
            </div>
          </div>
        </div>
      </div>
      <div class="w-100">
  
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Save as Draft" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnSubmitforApproval" runat="server" CssClass="btn btn-primary" Text="Submit for Approval" ValidationGroup="V" OnClick="btnSubmitforApproval_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />
            <asp:ValidationSummary ID="ValidSum" runat="server" ValidationGroup="V" ShowMessageBox="true" ShowSummary="false" />
         
      </div>
        </div>
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="btnSubmit" />
      <asp:PostBackTrigger ControlID="btnSubmitforApproval" />
      <asp:PostBackTrigger ControlID="gvAttachment" />
    </Triggers>
  </asp:UpdatePanel>
</asp:Content>
