<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="MultiVendorLogicNote.aspx.cs" Inherits="AdminPanel_MultiVendorLogicNote" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <%--<link href="js/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="js/bootstrap-multiselect.js"></script>--%>
  <%-- <script type="text/javascript">  
        $(function () {

            $('#ddlnameofproposedvendor').multiselect({
                includeSelectAllOption: true,
                enableFiltering: true,
                filterPlaceholder: 'Search....',
                enableCaseInsensitiveFiltering: true
                // dropRight: true
            });
        });
    </script>--%>
  <script type="text/javascript">
      function LenAlert() {
          alert('You cannot enter more than 200 chars');
          return false;
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

          $('#<%=txtSingleRepeatOrderReson.ClientID %>').keypress(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 1000) {
                    alert('You cannot enter more than 1000 chars');
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
                       <%-- $('#<%=txtUrgetResionDescription.ClientID %>').val("");--%>
                    $('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", false);
                    ValidatorEnable($("#<%=RFVUrgetReason.ClientID %>")[0], true);
                }
                else {
                    $('#<%=txtUrgetResionDescription.ClientID %>').val("");
                    $('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", true);
                    ValidatorEnable($("#<%=RFVUrgetReason.ClientID %>")[0], false);
                }
            }).change();

           <%-- $("#<%=ddlReasonofvariation.ClientID %>").change(function () {
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
            }).change();--%>

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
        function disabledApprovalNo(item) {
            if ($("#" + item.id + " option:selected").val() == "1") {
                $("#<%=txtApprovalNo.ClientID%>").attr("disabled", "disabled");
                $("#<%=txtReasonOfAmendment.ClientID%>").attr("disabled", "disabled");
            }
            else {
                $("#<%=txtApprovalNo.ClientID%>").removeAttr("disabled");
                $("#<%=txtReasonOfAmendment.ClientID%>").removeAttr("disabled");
            }
        }
        function ValidateMultiSelect(sender, args) {
            var isValid = false;
            if ($("#ddlnameofproposedvendor option:selected").length > 0) {
                isValid = true;
            } else {
                isValid = false;
            }
            args.IsValid = isValid;
        }
        $(document).ready(function () {
            //ProjectName();
            //ddlProjectName();
            ddlGetProjectName();
            //ddlLocation();
            //filldelayinaward();
        });

        function ddlGetProjectName() {


            $("#<%=ddlCompanyName.ClientID %>").change(function () {
                $('#<%=hiddenprojectnamevalue.ClientID %>').val("");
                //ProjectName();
            });
        }
        <%--function ProjectName() {          
            var companyId = $("#<%=ddlCompanyName.ClientID %> option:selected").val();
            var data = {};
            data.companyId = companyId;
            $.ajax({
                type: "POST",
                url: "MultiVendorLogicNote.aspx/GetProjectName",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    
                    var ddlprojectname = $("[id*=<%=ddlprojectname.ClientID %>]");

                    ddlprojectname.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(r.d, function () {                        
                        ddlprojectname.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    //obj = JSON.parse(r.d);
                    
                    if ($('#<%=hiddenprojectnamevalue.ClientID %>').val() != "") {
                        
                        $("#<%=ddlprojectname.ClientID%>").val($('#<%=hiddenprojectnamevalue.ClientID %>').val());
                        var el = document.getElementById("#<%=ddlprojectname.ClientID %>");                       
                        el.dispatchEvent(new Event('change'));
                    }
                    
                    ddlProjectName();
                }
            });
        }--%>
        function ddlProjectName() {
            <%--var data = {};
            $("#<%=ddlprojectname.ClientID %>").change(function () {
                data.projectId = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "MultiVendorLogicNote.aspx/getPorjectAddress",
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        alert("dsfd");
                        setCookie("Projectaddress", result.d, 30);
                        $('#<%=txtProjectaddress.ClientID %>').val(result.d);
                        ddlLocation();
                    }
                });
                $('#<%=hiddenprojectnamevalue.ClientID %>').val(this.value);
                if ($(this).val() == 0) {
                    deleteAllCookies()
                    setCookie("Projectaddress", "", 30);

                }
            });--%>
        }

        <%--function ddlLocation() {
            var data = {};
            $("#<%=ddlprojectname.ClientID %>").change(function () {

                data.projectId = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "MultiVendorLogicNote.aspx/GetProjectLocation",
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (r) {
                        var ddllocation = $("[id*=<%=ddllocation.ClientID %>]");
                        ddllocation.empty().append('<option selected="selected" value="0">--Select--</option>');
                        $.each(r.d, function () {
                            ddllocation.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        if ($('#<%=hddlocationId.ClientID %>').val() != "") {

                            $("#<%=ddllocation.ClientID%>").val($('#<%=hddlocationId.ClientID %>').val());
                            
                        }
                    }
                });

            });
        }--%>
  </script>
  <style>
.multiselect-container {
	position: absolute;
	list-style-type: none;
	margin: 0px 0px;
	padding: 0px;
	/* z-index: 999;*/
	height: 300px;
	overflow-y: auto;
}
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
.info-v {
	display: none;
}
.multiselect-native-select .btn-group {
	width: 100%;
}
.textboxcss {
	background-color: #e9ecef;
	opacity: 1;
}
        /*.x_panel .x_content .font-weight-bold, .x_panel .x_content span a{
            font-size: 10px;
        }*/
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
      <asp:HiddenField ID="hiddenprojectnamevalue" runat="server" />
      <asp:HiddenField ID="HiddenField2" runat="server" />
      <asp:HiddenField runat="server" ID="hdnID" Value="" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnV1Value" Value="0" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnV2Value" Value="0" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnV3Value" Value="0" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnV4Value" Value="0" ClientIDMode="Static" />
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="text-center blue">Multiple Vendor Logic Note Details</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
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
                  <label for="exampleInputEmail1" class="font-weight-bold">Approval No<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtApprovalNo" runat="server" disabled="disabled" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtApprovalNo_TextChanged" PlaceHolder="Approval No"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvApprovalNo" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approval No."
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtApprovalNo"></asp:RequiredFieldValidator>--%>
                  <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" DelimiterCharacters="" Enabled="True" ServiceMethod="GetApprovalNo" MinimumPrefixLength="1" EnableCaching="true"
                                        ServicePath="MultiVendorLogicNote.aspx" TargetControlID="txtApprovalNo"> </cc1:AutoCompleteExtender>
                  <asp:HiddenField runat="server" ID="hdnApprovalNo" Value="0" />
                  <asp:HiddenField runat="server" ID="hdnApprovalType" Value="0" />
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold"> Approval Authority<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlapprovalauthrity" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Authrity"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlapprovalauthrity" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
             <div class="col-sm-3">
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
           <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Company Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlCompanyName_SelectedIndexChanged" runat="server" CssClass="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvCompanyName" ForeColor="Red" runat="server" ErrorMessage="Please Select Company Name"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlCompanyName" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Subject & Scope<span class="spnRequired">Max 200 Character *</span></label>
                  <asp:TextBox ID="txtSubjectScope" TextMode="MultiLine" Rows="1" PlaceHolder="Subject & Scope" runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" runat="server" ErrorMessage="Please Enter Subject Scope"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSubjectScope"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Project Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlprojectname" AutoPostBack="true" OnSelectedIndexChanged="ddlprojectname_SelectedIndexChanged1" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please Select Project Name"
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
                  <label for="exampleInputEmail1" class="font-weight-bold">Location Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddllocation" EnableViewState="true" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:HiddenField ID="hddlocationId" runat="server" Value="0" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator32" ForeColor="Red" runat="server" ErrorMessage="Please Select Location Name"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="ddllocation" InitialValue="0"></asp:RequiredFieldValidator>
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
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason Of Amendment</label>
                  <asp:TextBox ID="txtReasonOfAmendment" autocomplete="off" placeholder="Reason Of Amendment" disabled="disabled" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Indent Proponent</label>
                  <asp:TextBox ID="txtIndentProponent" runat="server" PlaceHolder="Indent Proponent" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Indent Proponent"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtIndentProponent"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Date of indent</label>
                  <asp:TextBox ID="txtDateofindent" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Date of indent"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtDateofindent"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Material needed by</label>
                  <asp:TextBox ID="txtMaterialneededby" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator21" ForeColor="Red" runat="server" ErrorMessage="Please Enter Material needed by"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtMaterialneededby"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Stock in Hand</label>
              <div class="d-flex">
                  <asp:TextBox ID="txtStockinHand" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control mr-2" Width="45%" PlaceHolder="Stock"></asp:TextBox>
                  <asp:DropDownList ID="ddlStockinhandUOM" runat="server" Width="50%" class="form-control selectcss"> </asp:DropDownList>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Stock in Hand"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtStockinHand"></asp:RequiredFieldValidator>--%>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Select Stock UOM"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlStockinhandUOM" InitialValue="0"></asp:RequiredFieldValidator>--%>
                </div></div>
              </div>
              <div class="col-sm-3">
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
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Urgent Reason Desc<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtUrgetResionDescription" runat="server" TextMode="MultiLine" Rows="1" placeholder="Urgent Reason Desc" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RFVUrgetReason" ForeColor="Red" runat="server" ErrorMessage="Please Enter Urgent Reason Desc"
                                        ValidationGroup="V" InitialValue="0" Display="Dynamic" ControlToValidate="txtUrgetResionDescription"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Saleable Area <span class="small">(Sq. Ft.)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtSaleableArea" runat="server" onkeypress="return isNumberKey(event);" Text="0" PlaceHolder="Saleable Area" CssClass="form-control" onchange="Costpersqft();"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Saleable Area"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSaleableArea"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Approved Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtApprovalBudget" runat="server" onchange="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Approved Budget" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approved Budget"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtApprovalBudget"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Already Awarded <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtAlreadyAwarded" runat="server" onchange="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Already Awarded" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" runat="server" ErrorMessage="Please Enter Already Awarded"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtAlreadyAwarded"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Proposed Value of this award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtProposedvalueofaward" runat="server" onchange="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Proposed Value" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" runat="server" ErrorMessage="Please Enter Proposed Value"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtProposedvalueofaward"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Balance to be award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtBalancetobeaward" runat="server" onchange="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Balance Value" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="Red" runat="server" ErrorMessage="Please Enter Balance to be award"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtBalancetobeaward"></asp:RequiredFieldValidator>
                </div>
              </div>
            <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold" style="display: block">Variation from Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtvariationfrombudget" EnableViewState="true" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Variation from Budget" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ForeColor="Red" runat="server" ErrorMessage="Please Enter Variation Budget"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtvariationfrombudget"></asp:RequiredFieldValidator>
                </div>
              </div>
             <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason of variation<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlReasonofvariation" AutoPostBack="true" OnSelectedIndexChanged="ddlReasonofvariation_SelectedIndexChanged" runat="server" CssClass="form-control selectcss">
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
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason for Others<span class="small spnRequired">Max 100 Character*</span></label>
                  <asp:TextBox ID="txtother" EnableViewState="false" runat="server" TextMode="MultiLine" Rows="1" CssClass="form-control" placeholder="Reason For Others"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rvreasonforothers" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reason for Others"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtother"></asp:RequiredFieldValidator>
                </div>
              </div>
        
              <%--<div class="col-sm-3">
                                <div class="form-group">
                                    <label for="exampleInputEmail1" class="font-weight-bold" style="font-size: 10px;">
                                        Name of Proposed Vendor <span class="small spnRequired">
                                            <a href="VendorMaster.aspx" target="_blank" title="Click to add new vendor" style="font-size: 10px;">Add Vendor</a>
                                        </span><span class="spnRequired">*</span></label>
                                    <asp:ListBox ID="ddlnameofproposedvendor" onchange="ValidateVendor();" runat="server" CssClass="form-control" SelectionMode="multiple" ClientIDMode="Static"></asp:ListBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator25" ForeColor="Red" runat="server" ErrorMessage="Please Select Name of Proposed Vendor"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlnameofproposedvendor"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CustomValidator1"  ErrorMessage="Please select at least one vendor from the list." ForeColor="Red" ClientValidationFunction="ValidateMultiSelect" runat="server"
                                        ValidationGroup="V" Display="Dynamic" />
                                    
                                </div>
                            </div>--%>
              <div class="col-sm-3">
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
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Commercial rating of Bid<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtCommercialratingofbid" runat="server" PlaceHolder="Commercial Bid" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ForeColor="Red" runat="server" ErrorMessage="Please Enter Commercial rating of Bid"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtCommercialratingofbid"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold" style="display: block;">Proposed time line by vendor<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtProposedtimelineDate" runat="server" Width="100%" CssClass="form-control" type="date"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ForeColor="Red" runat="server" ErrorMessage="Please Enter Proposed time line by vendor"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtProposedtimelineDate"></asp:RequiredFieldValidator>
                </div>
              </div>
      
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Responsible Person<span class="small spnRequired">*</span></label>
                  <asp:TextBox ID="txtresponsibleperson" EnableViewState="false" runat="server" CssClass="form-control" placeholder="Responsible Person"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="Red" runat="server" ErrorMessage="Please Enter Responsible Person"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtresponsibleperson"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Material Used By Date<span class="small spnRequired">*</span></label>
                  <asp:TextBox ID="txtmaterialuserdate" EnableViewState="false" type="date" runat="server" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator36" ForeColor="Red" runat="server" ErrorMessage="Please Enter Material Used By Date"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtmaterialuserdate"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Place of Use<span class="small spnRequired">*</span></label>
                  <asp:TextBox ID="txtplaceofuse" EnableViewState="false" runat="server" CssClass="form-control" placeholder="Place of Use"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator38" ForeColor="Red" runat="server" ErrorMessage="Please Enter Place of Use"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtplaceofuse"></asp:RequiredFieldValidator>
                </div>
              </div>
               
            </div>
          </div>
        </div>
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
                  <%--<a onclick="delRow('ContentPlaceHolder1_gvStandardexception',this)" class="btn btn-primary fa fa-trash"></a>--%>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Evaluation</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="row">
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Vendor considered<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtTotalVendorConsidred" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" placeholder="Total vendor considered" class="form-control" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total vendor considered"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalVendorConsidred"></asp:RequiredFieldValidator>
                </div>
              </div>
             <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Rejected Vendors<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRejectedVendor" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Rejected Vendors" CssClass="form-control" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rejected Vendors"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRejectedVendor"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">RFQ invited<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRFQInvited" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" placeholer=""></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator26" ForeColor="Red" runat="server" ErrorMessage="Please Enter RFQ invited"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRFQInvited"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Not quoted<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtNotQuoted" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" Placeholder="Not quoted" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ForeColor="Red" runat="server" ErrorMessage="Please Enter Not quoted"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtNotQuoted"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Final Considered<span class="spnRequired">*</span></label>
                  <br />
                  <asp:TextBox ID="txtFinalConsidered" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" PlaceHolder="Final Considered"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator28" ForeColor="Red" runat="server" ErrorMessage="Please Enter Final Considered"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtFinalConsidered"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Stipulated Completion Time<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtStipulatedCompletionTime" runat="server" type="date" CssClass="form-control" PlaceHolder="Stipulated Completion Time"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator29" ForeColor="Red" runat="server" ErrorMessage="Please Enter Stipulated Completion Time"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtStipulatedCompletionTime"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
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
              <div class="col-sm-3">
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
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Contractor Name</label>
                  <asp:TextBox ID="txtContratorName" EnableViewState="false" runat="server" PlaceHolder="Contractor Name" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator32" ForeColor="Red" runat="server" ErrorMessage="Please Enter Contractor Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtContratorName"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
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
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Date of Ariba Auction</label>
                  <asp:TextBox ID="txtDateofAribaAuction" EnableViewState="false" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold"> Single quote/repeat order - reason to be mention </label>
                  <asp:TextBox ID="txtSingleRepeatOrderReson" EnableViewState="false" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="1"></asp:TextBox>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Bid Evaluation <span class="small spnRequired"> <a href="ItemMaster.aspx" target="_blank" title="Click to add new Item">Add New Item</a> </span><span class="spnRequired">*</span></h2>
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
                  <%--<asp:Button Text="Calculate" CommandName="Calculate" runat="server" />--%>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="UOM" FooterStyle-HorizontalAlign="Right">
                <ItemTemplate>
                  <asp:DropDownList ID="ddlUOM" Width="120px" runat="server" class="form-control selectcss"> </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvUOM" ControlToValidate="ddlUOM" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="UOM Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
                <FooterTemplate> Total </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor1 Quantity">
                <ItemTemplate>
                  <asp:TextBox ID="txtV1Quantity" Width="120px" onchange="CalBidEval('txtV1Quantity','txtVendor1Rate','txtVendor1Value',this)" Text='<%#Eval("V1Quantity") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v1-quantity"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvV1Quantity" ControlToValidate="txtV1Quantity" ValidationGroup="V" runat="server" ErrorMessage="Quantity Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV1TotalQty">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor1 Rate" HeaderStyle-CssClass="abc">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor1Rate" Width="120px" onchange="CalBidEval('txtV1Quantity','txtVendor1Rate','txtVendor1Value',this)" Text='<%#Eval("V1Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v1-rate"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvVendor1Rate" ControlToValidate="txtVendor1Rate" ValidationGroup="V" runat="server" ErrorMessage="V1Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV1TotalRate">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor1 Value">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor1Value" Width="120px" TabIndex="-1" Text='<%#Eval("V1Value") %>' Style="pointer-events: none;" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control textboxcss v1-value"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvVendor1Value" ControlToValidate="txtVendor1Value" ValidationGroup="V" runat="server" ErrorMessage="V1Value Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV1TotalValue">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor2 Quantity">
                <ItemTemplate>
                  <asp:TextBox ID="txtV2Quantity" Width="120px" onchange="CalBidEval('txtV2Quantity','txtVendor2Rate','txtVendor2Value',this)" Text='<%#Eval("V2Quantity") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v2-quantity"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvV1Quantity" ControlToValidate="txtV1Quantity" ValidationGroup="V" runat="server" ErrorMessage="Quantity Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV2TotalQty">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor2 Rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor2Rate" Width="120px" onchange="CalBidEval('txtV2Quantity','txtVendor2Rate','txtVendor2Value',this)" Text='<%#Eval("V2Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v2-rate"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvVendor2Rate" ControlToValidate="txtVendor2Rate" ValidationGroup="V" runat="server" ErrorMessage="V2Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV2TotalRate">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor2 Value">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor2Value" Width="120px" TabIndex="-1" Text='<%#Eval("V2Value") %>' Style="pointer-events: none;" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control textboxcss v2-value"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvVendor2Value" ControlToValidate="txtVendor2Value" ValidationGroup="V" runat="server" ErrorMessage="V2Value Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV2TotalValue">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor3 Quantity">
                <ItemTemplate>
                  <asp:TextBox ID="txtV3Quantity" Width="120px" onchange="CalBidEval('txtV3Quantity','txtVendor3Rate','txtVendor3Value',this)" Text='<%#Eval("V3Quantity") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v3-quantity"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvV1Quantity" ControlToValidate="txtV1Quantity" ValidationGroup="V" runat="server" ErrorMessage="Quantity Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV3TotalQty">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor3 Rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor3Rate" Width="120px" onchange="CalBidEval('txtV3Quantity','txtVendor3Rate','txtVendor3Value',this)" Text='<%#Eval("V3Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v3-rate"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvVendor3Rate" ControlToValidate="txtVendor3Rate" ValidationGroup="V" runat="server" ErrorMessage="V3Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV3TotalRate">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor3 Value">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor3Value" Width="120px" TabIndex="-1" Text='<%#Eval("V3Value") %>' Style="pointer-events: none;" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control textboxcss v3-value"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvVendor3Value" ControlToValidate="txtVendor3Value" ValidationGroup="V" runat="server" ErrorMessage="V3Value Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV3TotalValue">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor4 Quantity">
                <ItemTemplate>
                  <asp:TextBox ID="txtV4Quantity" Width="120px" onchange="CalBidEval('txtV4Quantity','txtVendor4Rate','txtVendor4Value',this)" Text='<%#Eval("V4Quantity") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v4-quantity"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="rfvV1Quantity" ControlToValidate="txtV1Quantity" ValidationGroup="V" runat="server" ErrorMessage="Quantity Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV4TotalQty">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor4 Rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor4Rate" Width="120px" onchange="CalBidEval('txtV4Quantity','txtVendor4Rate','txtVendor4Value',this)" Text='<%#Eval("V4Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v4-rate"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvVendor4Rate" ControlToValidate="txtVendor4Rate" ValidationGroup="V" runat="server" ErrorMessage="V4Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV4TotalRate">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Vendor4 Value">
                <ItemTemplate>
                  <asp:TextBox ID="txtVendor4Value" Width="120px" TabIndex="-1" Text='<%#Eval("V4Value") %>' Style="pointer-events: none;" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control textboxcss v4-value"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvVendor4Value" ControlToValidate="txtVendor4Value" ValidationGroup="V" runat="server" ErrorMessage="V4Value Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblV4TotalValue">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Budgeted base rate">
                <ItemTemplate>
                  <asp:TextBox ID="txtBudgetRate" Width="120px" Text='<%#Eval("BaseRate") %>' onchange="SumCommon('baserate','lblTotalBaseRate')" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control baserate"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvBudgetRate" ControlToValidate="txtBudgetRate" ValidationGroup="V" runat="server" ErrorMessage="BaseRate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblTotalBaseRate">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Target Cost">
                <ItemTemplate>
                  <asp:TextBox ID="txtTargetCost" Width="120px" Text='<%#Eval("TargetCost") %>' onchange="SumCommon('targetcost','lblTotalTargetCost')" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control targetcost"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvTargetCost" ControlToValidate="txtTargetCost" ValidationGroup="V" runat="server" ErrorMessage="TargetCost Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblTotalTargetCost">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Previous Rates">
                <ItemTemplate>
                  <asp:TextBox ID="txtPreviousRates" Width="120px" Text='<%#Eval("PreviousRate") %>' onchange="SumCommon('previousrate','lblTotalPreviousRates')" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control previousrate"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPreviousRates" ControlToValidate="txtPreviousRates" ValidationGroup="V" runat="server" ErrorMessage="PreviousRate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
                <FooterTemplate>
                  <asp:Label runat="server" ID="lblTotalPreviousRates">0</asp:Label>
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <%--<a onclick="delRow('ContentPlaceHolder1_gvStandardexception',this)" class="btn btn-primary fa fa-trash"></a>--%>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
          <div class="x_content table-responsive">
            <div class="row">
              <div class="col-sm-4"></div>
              <div class="col-sm-2">
                <h4>Vendor 1<span class="spnRequired">*</span></h4>
              </div>
              <div class="col-sm-2">
                <h4>Vendor 2</h4>
              </div>
              <div class="col-sm-2">
                <h4>Vendor 3</h4>
              </div>
              <div class="col-sm-2">
                <h4>Vendor 4</h4>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-4">
                <h4>Vendor</h4>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor1" onchange="selectvendor(this,1)" ClientIDMode="Static" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <asp:HiddenField ID="hiddenvendor1" runat="server" />
                <asp:HiddenField ID="hiddenvendortext1" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlVendor1"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor2" onchange="selectvendor(this,2)" ClientIDMode="Static" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <asp:HiddenField ID="hiddenvendor2" runat="server" />
                <asp:HiddenField ID="hiddenvendortext2" runat="server" />
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor3" onchange="selectvendor(this,3)" ClientIDMode="Static" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <asp:HiddenField ID="hiddenvendor3" runat="server" />
                <asp:HiddenField ID="hiddenvendortext3" runat="server" />
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor4" onchange="selectvendor(this,4)" ClientIDMode="Static" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <asp:HiddenField ID="hiddenvendor4" runat="server" />
                <asp:HiddenField ID="hiddenvendortext4" runat="server" />
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>GST</h4>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV1GST" runat="server" PlaceHolder="GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 GST"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1GST"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV2GST" runat="server" PlaceHolder="GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV3GST" runat="server" PlaceHolder="GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV4GST" runat="server" PlaceHolder="GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>Freight</h4>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV1Freight" runat="server" PlaceHolder="Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Freight"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1Freight"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV2Freight" runat="server" PlaceHolder="Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2Freight"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV3Freight" runat="server" PlaceHolder="Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV4Freight" runat="server" PlaceHolder="Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>TCS</h4>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV1HeadlingCharges" runat="server" PlaceHolder="Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Handling Charges"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1HeadlingCharges"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV2HeadlingCharges" runat="server" PlaceHolder="Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV3HeadlingCharges" runat="server" PlaceHolder="Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV4HeadlingCharges" runat="server" PlaceHolder="Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
            </div>

              <div class="row mt-1">
                  <div class="col-sm-4">
                      <h4>Handling/Insurance Charge</h4>
                  </div>
                  <div class="col-sm-2">
                      <asp:TextBox ID="txtV1handling" runat="server" PlaceHolder="Handling Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator41" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Handling Charges"
                          ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1handling"></asp:RequiredFieldValidator>
                  </div>
                  <div class="col-sm-2">
                      <asp:TextBox ID="txtV2handling" runat="server" PlaceHolder="Handling Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2Freight"></asp:RequiredFieldValidator>--%>
                  </div>
                  <div class="col-sm-2">
                      <asp:TextBox ID="txtV3handling" runat="server" PlaceHolder="Handling Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
                  </div>
                   <div class="col-sm-2">
                      <asp:TextBox ID="txtV4handling" runat="server" PlaceHolder="Handling Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
                  </div>
              </div>
               <div class="row mt-1">
                  <div class="col-sm-4">
                      <h4>Other Charge</h4>
                  </div>
                  <div class="col-sm-2">
                      <asp:TextBox ID="txtV1OtherCharge" runat="server" PlaceHolder="Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="rfvV1OtherCharge" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Other Charges"
                          ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1OtherCharge"></asp:RequiredFieldValidator>
                  </div>
                  <div class="col-sm-2">
                      <asp:TextBox ID="txtV2OtherCharge" runat="server" PlaceHolder="Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2Freight"></asp:RequiredFieldValidator>--%>
                  </div>
                  <div class="col-sm-2">
                      <asp:TextBox ID="txtV3OtherCharge" runat="server" PlaceHolder="Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
                  </div>
                    <div class="col-sm-2">
                      <asp:TextBox ID="txtV4OtherCharge" runat="server" PlaceHolder="Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
                  </div>
              </div>

            <div class="row mt-1">
              <div class="col-sm-4">
                <h4 style="display: contents;">Grand Total</h4>
                <input type="button" style="float: right;" onclick="call();" value="Calculate" />
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV1GrandTotal" runat="server" Style="pointer-events: none;" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Grand Total"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1GrandTotal"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV2GrandTotal" runat="server" Style="pointer-events: none;" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV3GrandTotal" runat="server" Style="pointer-events: none;" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtV4GrandTotal" runat="server" Style="pointer-events: none;" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>Delivery Timeline</h4>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor1DeliveryTimeline" runat="server" type="date" PlaceHolder="Delivery Timeline" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator34" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Delivery Timeline"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1DeliveryTimeline"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor2DeliveryTimeline" runat="server" type="date" PlaceHolder="Delivery Timeline" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator35" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor3DeliveryTimeline" runat="server" type="date" PlaceHolder="Delivery Timeline" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator36" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor4DeliveryTimeline" runat="server" type="date" PlaceHolder="Delivery Timeline" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator36" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Delivery Timeline"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3DeliveryTimeline"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>Comparision with Budgeted Rate</h4>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor1Comparision" runat="server" PlaceHolder="Comparision with Budgeted Rate" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator37" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Comparision with Budgeted Rate"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1Comparision"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor2Comparision" runat="server" PlaceHolder="Comparision with Budgeted Rate" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator38" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Comparision with Budgeted Rate"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2Comparision"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor3Comparision" runat="server" PlaceHolder="Comparision with Budgeted Rate" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator39" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Comparision with Budgeted Rate"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3Comparision"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor4Comparision" runat="server" PlaceHolder="Comparision with Budgeted Rate" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator39" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Comparision with Budgeted Rate"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3Comparision"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>Bids Status</h4>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor1BidStatus" ReadOnly="false" runat="server" PlaceHolder="Bids Status" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator40" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bids Status"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1BidStatus"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor2BidStatus" ReadOnly="false" runat="server" PlaceHolder="Bids Status" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator41" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bids Status"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2BidStatus"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor3BidStatus" ReadOnly="false" runat="server" PlaceHolder="Bids Status" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator42" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bids Status"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3BidStatus"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor4BidStatus" ReadOnly="false" runat="server" PlaceHolder="Bids Status" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator42" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bids Status"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3BidStatus"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>Vendor Ratings</h4>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor1Rating" runat="server" CssClass="form-control">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="A">A</asp:ListItem>
                  <asp:ListItem Value="B">B</asp:ListItem>
                  <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator43" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1 Vendor Ratings"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlVendor1Rating"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor2Rating" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="A">A</asp:ListItem>
                  <asp:ListItem Value="B">B</asp:ListItem>
                  <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator44" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Vendor Ratings"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2Rating"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor3Rating" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="A">A</asp:ListItem>
                  <asp:ListItem Value="B">B</asp:ListItem>
                  <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator45" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Vendor Ratings"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3Rating"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor4Rating" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="A">A</asp:ListItem>
                  <asp:ListItem Value="B">B</asp:ListItem>
                  <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator45" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Vendor Ratings"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3Rating"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>Award Preference</h4>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor1AwardPreference" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="P1">P1</asp:ListItem>
                  <asp:ListItem Value="P2">P2</asp:ListItem>
                  <asp:ListItem Value="P3">P3</asp:ListItem>
                  <asp:ListItem Value="P4">P4</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator46" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1 Award Preference"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlVendor1AwardPreference"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor2AwardPreference" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="P1">P1</asp:ListItem>
                  <asp:ListItem Value="P2">P2</asp:ListItem>
                  <asp:ListItem Value="P3">P3</asp:ListItem>
                  <asp:ListItem Value="P4">P4</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator47" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor3AwardPreference" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="P1">P1</asp:ListItem>
                  <asp:ListItem Value="P2">P2</asp:ListItem>
                  <asp:ListItem Value="P3">P3</asp:ListItem>
                  <asp:ListItem Value="P4">P4</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator48" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:DropDownList ID="ddlVendor4AwardPreference" runat="server" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="P1">P1</asp:ListItem>
                  <asp:ListItem Value="P2">P2</asp:ListItem>
                  <asp:ListItem Value="P3">P3</asp:ListItem>
                  <asp:ListItem Value="P4">P4</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator48" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-4">
                <h4>Cost Per Sqft</h4>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor1CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Cost per Sqft"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1CostPerSqft"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor2CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator47" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor3CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator48" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-2">
                <asp:TextBox ID="txtVendor4CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator48" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Deviation from Tender/ RFQ, if any</h2>
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
                  <%--<a onclick="delRow('ContentPlaceHolder1_gvStandardexception',this)" class="btn btn-primary fa fa-trash"></a>--%>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Vendor Evaluation</h2>
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
            </div>
            <div class="row">
              <div class="col-sm-4">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Vendor 1 Information</label>
                  <asp:TextBox ID="txtVendorInformation" ClientIDMode="Static" ReadOnly="true" runat="server" placeholder="Vendor 1 Information" class="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor Information"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendorInformation"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-2">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Turnover last year<span class="small">(in Lacs)</span></label>
                  <asp:TextBox ID="txtTournoverlastyear" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Turnover last year" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Turnover last year"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTournoverlastyear"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Total orders with Co. till date</label>
                  <asp:TextBox ID="txtTotalOrderwithcotilldate" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator50" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total orders with Co. till date"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalOrderwithcotilldate"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Last order details with Co.</label>
                  <asp:TextBox ID="txtLastOrderdetailswithco" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator51" ForeColor="Red" runat="server" ErrorMessage="Please Enter Last order details with Co"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtLastOrderdetailswithco"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-4">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Vendor 2 Information</label>
                  <asp:TextBox ID="txtVendor2Information" ClientIDMode="Static" ReadOnly="true" runat="server" placeholder="Vendor 2 Information" class="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor Information"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendorInformation"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-2">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Turnover last year<span class="small">(in Lacs)</span></label>
                  <asp:TextBox ID="txtVendor2TurnOverLastYear" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Turnover last year" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Turnover last year"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTournoverlastyear"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Total orders with Co. till date</label>
                  <asp:TextBox ID="txtVendor2TotalorderswithCoDate" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator50" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total orders with Co. till date"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalOrderwithcotilldate"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Last order details with Co.</label>
                  <asp:TextBox ID="txtVendor2LastorderdetailswithCo" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator51" ForeColor="Red" runat="server" ErrorMessage="Please Enter Last order details with Co"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtLastOrderdetailswithco"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-4">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Vendor 3 Information</label>
                  <asp:TextBox ID="txtVendor3Information" ClientIDMode="Static" ReadOnly="true" runat="server" placeholder="Vendor 3 Information" class="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor Information"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendorInformation"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-2">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Turnover last year<span class="small">(in Lacs)</span></label>
                  <asp:TextBox ID="txtVendor3TurnOverLastYear" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Turnover last year" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Turnover last year"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTournoverlastyear"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Total orders with Co. till date</label>
                  <asp:TextBox ID="txtVendor3TotalorderswithCoDate" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator50" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total orders with Co. till date"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalOrderwithcotilldate"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Last order details with Co.</label>
                  <asp:TextBox ID="txtVendor3LastorderdetailswithCo" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator51" ForeColor="Red" runat="server" ErrorMessage="Please Enter Last order details with Co"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtLastOrderdetailswithco"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-4">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Vendor 4 Information</label>
                  <asp:TextBox ID="txtVendor4Information" ClientIDMode="Static" ReadOnly="true" runat="server" placeholder="Vendor 4 Information" class="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor Information"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendorInformation"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-2">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Turnover last year<span class="small">(in Lacs)</span></label>
                  <asp:TextBox ID="txtVendor4TurnOverLastYear" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Turnover last year" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Turnover last year"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTournoverlastyear"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Total orders with Co. till date</label>
                  <asp:TextBox ID="txtVendor4TotalorderswithCoDate" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator50" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total orders with Co. till date"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalOrderwithcotilldate"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" style="font-size: 12px;" class="font-weight-bold">Last order details with Co.</label>
                  <asp:TextBox ID="txtVendor4LastorderdetailswithCo" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator51" ForeColor="Red" runat="server" ErrorMessage="Please Enter Last order details with Co"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtLastOrderdetailswithco"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Add Approver</h2>
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
                  <asp:DropDownList ID="ddlApprover" runat="server" class="form-control"> </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlApprover" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="Approver Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <%--<a onclick="delRow('ContentPlaceHolder1_gvStandardexception',this)" class="btn btn-primary fa fa-trash"></a>--%>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Approver"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Terms & Conditions</h2>
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
                  <%--<a onclick="delRow('ContentPlaceHolder1_gvStandardexception',this)" class="btn btn-primary fa fa-trash"></a>--%>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Add Attachment</h2>
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
                  <%--<a onclick="delRow('ContentPlaceHolder1_gvStandardexception',this)" class="btn btn-primary fa fa-trash"></a>--%>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
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
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
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
            <h2 class="blue">Head of Department<span class="spnRequired">*</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
              <CKEditor:CKEditorControl Toolbar="Basic" ID="ckPurchaseHead" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator49" ForeColor="Red" runat="server" ErrorMessage="Please Enter Multi Vendor Head"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="ckPurchaseHead"></asp:RequiredFieldValidator>
          </div>
        </div>
        <div>

            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Save as Draft" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnSubmitforApproval" runat="server" CssClass="btn btn-primary" Text="Submit for Approval" ValidationGroup="V" OnClick="btnSubmitforApproval_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />
            <asp:ValidationSummary ID="ValidSum" runat="server" ValidationGroup="V" ShowMessageBox="true" ShowSummary="false" />
          </div>
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="btnSubmit" />
      <asp:PostBackTrigger ControlID="btnSubmitforApproval" />
      <asp:PostBackTrigger ControlID="gvAttachment" />
    </Triggers>
  </asp:UpdatePanel>
  <script>

      $(function () {

          SumBidVal();
          SumCommon('previousrate', 'lblTotalPreviousRates');
          SumCommon('baserate', 'lblTotalBaseRate');
          SumCommon('targetcost', 'lblTotalTargetCost');
          Costpersqft();
          selectvendorcall();
          //SelectedVendor();
      });
      function call() {

          SumBidVal();
          SumCommon('previousrate', 'lblTotalPreviousRates');
          SumCommon('baserate', 'lblTotalBaseRate');
          SumCommon('targetcost', 'lblTotalTargetCost');
          Costpersqft();
          selectvendorcall();
          //SelectedVendor();
      }
      function CalBidEval(qtyId, rateId, valId, index) {
          //$(`#${pre}${valId}_${rowIndex}`).removeAttr("disabled");
          var pre = 'ContentPlaceHolder1_gvItemHead_';
          var row = index.parentNode.parentNode;
          var rowIndex = row.rowIndex - 1
          var qty = parseFloat($(`#${pre}${qtyId}_${rowIndex}`).val() == "" ? 0 : $(`#${pre}${qtyId}_${rowIndex}`).val());
          var rate = parseFloat($(`#${pre}${rateId}_${rowIndex}`).val() == "" ? 0 : $(`#${pre}${rateId}_${rowIndex}`).val());
          var value = qty * rate;
          $(`#${pre}${valId}_${rowIndex}`).val(value);
          SumBidVal();
          //$(`#${pre}${valId}_${rowIndex}`).attr("disabled", "disabled");
      }
      function SumBidVal() {

          var pre = 'ContentPlaceHolder1_gvItemHead_';
          var pre2 = 'ContentPlaceHolder1_';
          var value = 0;
          $(`.v1-quantity`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#` + pre + `lblV1TotalQty`).text(value); value = 0;
          $(`.v1-rate`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV1TotalRate`).text(value); value = 0;
          $(`.v1-value`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV1TotalValue`).text(value);
          $(`#hdnV1Value`).val(value);
          var dblV1GST = parseFloat($(`#ContentPlaceHolder1_txtV1GST`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV1GST`).val());
          var dblV1Freight = parseFloat($(`#ContentPlaceHolder1_txtV1Freight`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV1Freight`).val());
          var dblV1HeadlingCharges = parseFloat($(`#ContentPlaceHolder1_txtV1HeadlingCharges`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV1HeadlingCharges`).val());
          var dblV1Handling = parseFloat($(`#ContentPlaceHolder1_txtV1handling`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV1handling`).val());
          var dblV1other = parseFloat($(`#ContentPlaceHolder1_txtV1OtherCharge`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV1OtherCharge`).val());
          value = value + dblV1GST + dblV1Freight + dblV1HeadlingCharges + dblV1Handling + dblV1other;
          $(`#${pre2}txtV1GrandTotal`).val(value);
          value = 0;

          $(`.v2-quantity`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#` + pre + `lblV2TotalQty`).text(value); value = 0;
          $(`.v2-rate`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV2TotalRate`).text(value); value = 0;
          $(`.v2-value`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV2TotalValue`).text(value);

          $(`#hdnV2Value`).val(value);

          var dblV2GST = parseFloat($(`#ContentPlaceHolder1_txtV2GST`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV2GST`).val());
          var dblV2Freight = parseFloat($(`#ContentPlaceHolder1_txtV2Freight`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV2Freight`).val());
          var dblV2HeadlingCharges = parseFloat($(`#ContentPlaceHolder1_txtV2HeadlingCharges`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV2HeadlingCharges`).val());
          var dblV2Handling = parseFloat($(`#ContentPlaceHolder1_txtV2handling`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV2handling`).val());
          var dblV2other = parseFloat($(`#ContentPlaceHolder1_txtV2OtherCharge`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV2OtherCharge`).val());
          value = value + dblV2GST + dblV2Freight + dblV2HeadlingCharges + dblV2Handling + dblV2other;
          $(`#${pre2}txtV2GrandTotal`).val(value);

          value = 0;

          $(`.v3-quantity`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#` + pre + `lblV3TotalQty`).text(value); value = 0;
          $(`.v3-rate`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV3TotalRate`).text(value); value = 0;
          $(`.v3-value`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV3TotalValue`).text(value);

          $(`#hdnV3Value`).val(value);

          var dblV3GST = parseFloat($(`#ContentPlaceHolder1_txtV3GST`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV3GST`).val());
          var dblV3Freight = parseFloat($(`#ContentPlaceHolder1_txtV3Freight`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV3Freight`).val());
          var dblV3HeadlingCharges = parseFloat($(`#ContentPlaceHolder1_txtV3HeadlingCharges`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV3HeadlingCharges`).val());
          var dblV3Handling = parseFloat($(`#ContentPlaceHolder1_txtV3handling`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV3handling`).val());
          var dblV3other = parseFloat($(`#ContentPlaceHolder1_txtV3OtherCharge`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV3OtherCharge`).val());
          value = value + dblV3GST + dblV3Freight + dblV3HeadlingCharges + dblV3Handling + dblV3other;
          $(`#${pre2}txtV3GrandTotal`).val(value);
          value = 0;

          $(`.v4-quantity`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#` + pre + `lblV4TotalQty`).text(value); value = 0;
          $(`.v4-rate`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV4TotalRate`).text(value); value = 0;
          $(`.v4-value`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}lblV4TotalValue`).text(value);
          $(`#hdnV4Value`).val(value);
          var dblV4GST = parseFloat($(`#ContentPlaceHolder1_txtV4GST`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV4GST`).val());
          var dblV4Freight = parseFloat($(`#ContentPlaceHolder1_txtV4Freight`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV4Freight`).val());
          var dblV4HeadlingCharges = parseFloat($(`#ContentPlaceHolder1_txtV4HeadlingCharges`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV4HeadlingCharges`).val());
          var dblV4Handling = parseFloat($(`#ContentPlaceHolder1_txtV4handling`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV4handling`).val());
          var dblV4other = parseFloat($(`#ContentPlaceHolder1_txtV4OtherCharge`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV4OtherCharge`).val());

          value = value + dblV4GST + dblV4Freight + dblV4HeadlingCharges + dblV4Handling + dblV4other;
          $(`#${pre2}txtV4GrandTotal`).val(value);
          value = 0;

      }
      function Costpersqft() {

          var saleablearea = parseFloat($(`#ContentPlaceHolder1_txtSaleableArea`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtSaleableArea`).val());
          var v1grandtotal = parseFloat($(`#ContentPlaceHolder1_txtV1GrandTotal`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV1GrandTotal`).val());
          var v2grandtotal = parseFloat($(`#ContentPlaceHolder1_txtV2GrandTotal`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV2GrandTotal`).val());
          var v3grandtotal = parseFloat($(`#ContentPlaceHolder1_txtV3GrandTotal`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV3GrandTotal`).val());
          var v4grandtotal = parseFloat($(`#ContentPlaceHolder1_txtV4GrandTotal`).val() == "" ? 0 : $(`#ContentPlaceHolder1_txtV4GrandTotal`).val());
          var vadd = v1grandtotal / saleablearea;

          var V1Costpersqft = Math.round(v1grandtotal / saleablearea, 0)
          var V2Costpersqft = Math.round(v2grandtotal / saleablearea, 0)
          var V3Costpersqft = Math.round(v3grandtotal / saleablearea, 0)
          var V4Costpersqft = Math.round(v4grandtotal / saleablearea, 0)
          $(`#ContentPlaceHolder1_txtVendor1CostPerSqft`).val(V1Costpersqft);
          $(`#ContentPlaceHolder1_txtVendor2CostPerSqft`).val(V2Costpersqft);
          $(`#ContentPlaceHolder1_txtVendor3CostPerSqft`).val(V3Costpersqft);
          $(`#ContentPlaceHolder1_txtVendor4CostPerSqft`).val(V4Costpersqft);
      }
      function SumCommon(classname, lbl) {
          var pre = 'ContentPlaceHolder1_gvItemHead_';
          var value = 0;
          $(`.${classname}`).each(function () {
              value = value + parseFloat($(this).val() == "" ? 0 : $(this).val());
          });
          $(`#${pre}${lbl}`).text(value); value = 0;
      }
      //function ValidateVendor() {
      //    var selected = $("[id*=ddlnameofproposedvendor] option:selected");
      //    if (selected.length > 4) {
      //        $('#ddlnameofproposedvendor option').attr('selected', false);
      //        $("input[type=checkbox]").prop("checked", false);

      //        $('.dropdown-item').each(function () {
      //            $(this).removeClass("active");
      //        });
      //        alert('You can select only four vendor !');
      //        selected = $("[id*=ddlnameofproposedvendor] option:selected");
      //        resetVendor(selected.length);
      //        return;
      //    }
      //    SelectedVendor();

      //    resetVendor(selected.length);
      //}

      function selectvendor(ddlid, number) {

          if (number == 1) {
              if ($("#" + ddlid.id + " option:selected").val() == "0") {
                  $(`#ContentPlaceHolder1_hiddenvendor1`).val(`0`);
                  $(`#txtVendorInformation`).val(``);
                  $(`#ContentPlaceHolder1_hiddenvendortext1`).val(``);
              }
              else {
                  $(`#ContentPlaceHolder1_hiddenvendor1`).val($("#" + ddlid.id + " option:selected").val());
                  $(`#txtVendorInformation`).val($("#" + ddlid.id + " option:selected").text());
                  $(`#ContentPlaceHolder1_hiddenvendortext1`).val($("#" + ddlid.id + " option:selected").text());
              }
          }
          else if (number == 2) {
              if ($("#" + ddlid.id + " option:selected").val() == "0") {
                  $(`#ContentPlaceHolder1_hiddenvendor2`).val(`0`);
                  $(`#txtVendor2Information`).val(``);
                  $(`#ContentPlaceHolder1_hiddenvendortext2`).val(``);
              }
              else {
                  $(`#ContentPlaceHolder1_hiddenvendor2`).val($("#" + ddlid.id + " option:selected").val());
                  $(`#txtVendor2Information`).val($("#" + ddlid.id + " option:selected").text());
                  $(`#ContentPlaceHolder1_hiddenvendortext2`).val($("#" + ddlid.id + " option:selected").text());
              }
          }
          else if (number == 3) {
              if ($("#" + ddlid.id + " option:selected").val() == "0") {
                  $(`#ContentPlaceHolder1_hiddenvendor3`).val(`0`);
                  $(`#txtVendor3Information`).val(``);
                  $(`#ContentPlaceHolder1_hiddenvendortext3`).val(``);
              }
              else {
                  $(`#ContentPlaceHolder1_hiddenvendor3`).val($("#" + ddlid.id + " option:selected").val());
                  $(`#txtVendor3Information`).val($("#" + ddlid.id + " option:selected").text());
                  $(`#ContentPlaceHolder1_hiddenvendortext3`).val($("#" + ddlid.id + " option:selected").text());
              }
          }
          else if (number == 4) {
              if ($("#" + ddlid.id + " option:selected").val() == "0") {
                  $(`#ContentPlaceHolder1_hiddenvendor4`).val(`0`);
                  $(`#txtVendor4Information`).val(``);
                  $(`#ContentPlaceHolder1_hiddenvendortext4`).val(``);
              }
              else {
                  $(`#ContentPlaceHolder1_hiddenvendor4`).val($("#" + ddlid.id + " option:selected").val());
                  $(`#txtVendor4Information`).val($("#" + ddlid.id + " option:selected").text());
                  $(`#ContentPlaceHolder1_hiddenvendortext4`).val($("#" + ddlid.id + " option:selected").text());
              }
          }
      }
      function selectvendorcall() {

          debugger;
          if ($(`#ContentPlaceHolder1_hiddenvendor1`).val() == "0") {

              $(`#txtVendorInformation`).val(``);
          }
          else {

              //$(`#txtVendorInformation`).val($("#ddlVendor1 option:selected").text());         
              $(`#txtVendorInformation`).val($(`#ContentPlaceHolder1_hiddenvendortext1`).val());
          }

          if ($(`#ContentPlaceHolder1_hiddenvendor2`).val() == "0") {

              $(`#txtVendor2Information`).val(``);
          }
          else {
              $(`#txtVendor2Information`).val($(`#ContentPlaceHolder1_hiddenvendortext2`).val());
              //$(`#txtVendor2Information`).val($("#ddlVendor2 option:selected").text());       
          }

          if ($(`#ContentPlaceHolder1_hiddenvendor3`).val() == "0") {

              $(`#txtVendor3Information`).val(``);
          }
          else {
              $(`#txtVendor3Information`).val($(`#ContentPlaceHolder1_hiddenvendortext3`).val());
              //$(`#txtVendor3Information`).val($("#ddlVendor3 option:selected").text());  
          }

          if ($(`#ContentPlaceHolder1_hiddenvendor4`).val() == "0") {

              $(`#txtVendor4Information`).val(``);
          }
          else {

              $(`#txtVendor4Information`).val($(`#ContentPlaceHolder1_hiddenvendortext4`).val());
              //$(`#txtVendor4Information`).val($("#ddlVendor4 option:selected").text());  
          }
      }
      //function SelectedVendor() {
      //    var selected = $("[id*=ddlnameofproposedvendor] option:selected");
      //    var i = 1;
      //    selected.each(function () {
      //        //values += $(this).html() + " " + $(this).val() + "\n";
      //        if (i == 1) {
      //            $(`#ddlVendor1`).val($(this).val());
      //            $(`#ContentPlaceHolder1_hiddenvendor1`).val($(this).val());
      //            $(`#txtVendorInformation`).val($(this).html());
      //            $(`#info_v1`).removeClass(`info-v`);
      //        }
      //        else if (i == 2) {
      //            $(`#ddlVendor2`).val($(this).val());
      //            $(`#ContentPlaceHolder1_hiddenvendor2`).val($(this).val());
      //            $(`#txtVendor2Information`).val($(this).html());
      //            $(`#info_v2`).removeClass(`info-v`);
      //        }
      //        else if (i == 3) {
      //            $(`#ddlVendor3`).val($(this).val());
      //            $(`#ContentPlaceHolder1_hiddenvendor3`).val($(this).val());
      //            $(`#txtVendor3Information`).val($(this).html());
      //            $(`#info_v3`).removeClass(`info-v`);
      //        }
      //        else if (i == 4) {
      //            $(`#ddlVendor4`).val($(this).val());
      //            $(`#ContentPlaceHolder1_hiddenvendor4`).val($(this).val());
      //            $(`#txtVendor4Information`).val($(this).html());
      //            $(`#info_v4`).removeClass(`info-v`);
      //        }
      //        i = i + 1;
      //    });
      //}
      //function resetVendor(selected) {
      //    if (selected == 0) {
      //        $(`#ddlVendor1`).val(`0`);
      //        $(`#ContentPlaceHolder1_hiddenvendor1`).val(`0`);
      //        $(`#txtVendorInformation`).val(``);
      //        $(`#ddlVendor2`).val(`0`);
      //        $(`#ContentPlaceHolder1_hiddenvendor2`).val(`0`);
      //        $(`#txtVendor2Information`).val(``);
      //        $(`#ddlVendor3`).val(`0`);
      //        $(`#ContentPlaceHolder1_hiddenvendor3`).val(`0`);
      //        $(`#txtVendor3Information`).val(``);
      //        $(`#ddlVendor4`).val(`0`);
      //        $(`#ContentPlaceHolder1_hiddenvendor4`).val(`0`);
      //        $(`#txtVendor4Information`).val(``);
      //        $(`#info_v1`).addClass(`info-v`);
      //        $(`#info_v2`).addClass(`info-v`);
      //        $(`#info_v3`).addClass(`info-v`);
      //        $(`#info_v4`).addClass(`info-v`);
      //    }

      //    else if (selected == 1) {
      //        $(`#ddlVendor2`).val(`0`);
      //        $(`#txtVendor2Information`).val(``);
      //        $(`#ddlVendor3`).val(`0`);
      //        $(`#txtVendor3Information`).val(``);
      //        $(`#ddlVendor4`).val(`0`);
      //        $(`#txtVendor4Information`).val(``);

      //        $(`#info_v2`).addClass(`info-v`);
      //        $(`#info_v3`).addClass(`info-v`);
      //        $(`#info_v4`).addClass(`info-v`);
      //    }
      //    else if (selected == 2) {

      //        $(`#ddlVendor3`).val(`0`);
      //        $(`#txtVendor3Information`).val(``);
      //        $(`#ddlVendor4`).val(`0`);
      //        $(`#txtVendor4Information`).val(``);

      //        $(`#info_v3`).addClass(`info-v`);
      //        $(`#info_v4`).addClass(`info-v`);
      //    }
      //    else if (selected == 3) {
      //        $(`#ddlVendor4`).val(`0`);
      //        $(`#txtVendor4Information`).val(``);

      //        $(`#info_v4`).addClass(`info-v`);
      //    }
      //    else if (selected == 3) {
      //        $(`#ddlVendor4`).val(`0`);
      //        $(`#txtVendor4Information`).val(``);
      //    }
      //}

      var prm = Sys.WebForms.PageRequestManager.getInstance();
      prm.add_endRequest(function () {
          $.when(
              $.getScript("../vendors/select2/dist/js/select2.full.min.js"))
              .then(function () {
                  setTimeout(function () { $(".selectcss").select2(); }, 500);
              });
          selectvendorcall();
      });

      prm.add_beginRequest(function () {

      });


  </script> 
</asp:Content>
