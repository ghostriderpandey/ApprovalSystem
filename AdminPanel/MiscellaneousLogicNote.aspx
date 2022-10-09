<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="MiscellaneousLogicNote.aspx.cs" Inherits="AdminPanel_MiscellaneousLogicNote" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script type="text/javascript">
      function isNumberKey(evt) {
          evt = (evt) ? evt : window.event;
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          if (charCode > 31 && (charCode < 48 || charCode > 57)) {
              return false;
          }
          return true;
      }

      function process(input) {
          let value = input.value;
          let numbers = value.replace(/[^0-9]/g, "");
          input.value = numbers;
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
            <%--$("#<%=ddlType.ClientID %>").change(function () {
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

           <%-- $("#<%=ddlRequirement.ClientID %>").change(function () {--%>

              <%--  if ($(this).val() == "Urgent") {
                   <%-- $('#<%=txtUrgetResionDescription.ClientID %>').val("");--%>
                        <%--$('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", false);
                        ValidatorEnable($("#<%=RFVUrgetReason.ClientID %>")[0], true);
                    }
                    else {
                       <%-- $('#<%=txtUrgetResionDescription.ClientID %>').val("");
                        $('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", true);
                        ValidatorEnable($("#<%=RFVUrgetReason.ClientID %>")[0], false);
                    }
                }).change();--%>

            <%--$("#<%=ddlReasonofvariation.ClientID %>").change(function () {
                if ($(this).val() == "Others") {
                   // $('#<%=txtother.ClientID %>').val("");
                    $('#<%=txtother.ClientID%>').prop("readonly", false);
                    ValidatorEnable($("#<%=rvreasonforothers.ClientID %>")[0], true);--%>
                <%--}
                else {
                    $('#<%=txtother.ClientID %>').val("");
                    $('#<%=txtother.ClientID%>').prop("readonly", true);
                    ValidatorEnable($("#<%=rvreasonforothers.ClientID %>")[0], false);
                }
            }).change();--%>



            <%--$("#<%=ddlActionType.ClientID %>").change(function () {
                if ($(this).val() == "Manual") {
                    $('#<%=txtDateofAribaAuction.ClientID %>').val("");
                    $('#<%=txtDateofAribaAuction.ClientID%>').prop("readonly", true);

                }
                else {
                   // $('#<%=txtDateofAribaAuction.ClientID %>').val("");
                    $('#<%=txtDateofAribaAuction.ClientID%>').prop("readonly", false);

                }
            }).change();
            <%--$("#<%=ddllocation.ClientID %>").change(function () {
                if ($(this).val() != '' || $(this).val() != 0) {
                    $('#<%=hddlocationId.ClientID %>').val($(this).val());
                }
            })--%>
      };
      function Calander() {
          $('.calander').datepicker({ dateFormat: 'dd/mm/yy', changeYear: true });
      }
      $(document).ready(function () {
          ddlGetProjectName();
          ddlProjectName();
         // Calander();
          ShowTop3Bid();
          ShowDeviation();

          //var valName = document.getElementById("ContentPlaceHolder1_gvItemHead_rfvTop3Description_0");
          //ValidatorEnable(valName,false);
          //valName = document.getElementById("ContentPlaceHolder1_gvItemHead_rfvPrice1_0");
          //ValidatorEnable(valName, false);
      });
      function ShowTop3Bid() {

          if ($("#chktop3bid").prop("checked")) {
              $("#dvtop3bid").css("display", "block");
              var valName = document.getElementById("ContentPlaceHolder1_gvItemHead_rfvTop3Description_0");
              ValidatorEnable(valName, true);
              valName = document.getElementById("ContentPlaceHolder1_gvItemHead_rfvPrice1_0");
              ValidatorEnable(valName, true);
              valName = document.getElementById("ContentPlaceHolder1_rfvVendor1");
              ValidatorEnable(valName, true);
              valName = document.getElementById("ContentPlaceHolder1_rfvV1BidStatus");
              ValidatorEnable(valName, true);
              valName = document.getElementById("ContentPlaceHolder1_rfvVendor1Rating");
              ValidatorEnable(valName, true);
              valName = document.getElementById("ContentPlaceHolder1_rfvVendor1AwardPreference");
              ValidatorEnable(valName, true);
              valName = document.getElementById("ContentPlaceHolder1_RequiredFieldValidator16");
              ValidatorEnable(valName, true);
          }
          else {
              $("#dvtop3bid").css("display", "none");
              var valName = document.getElementById("ContentPlaceHolder1_gvItemHead_rfvTop3Description_0");
              ValidatorEnable(valName, false);
              valName = document.getElementById("ContentPlaceHolder1_gvItemHead_rfvPrice1_0");
              ValidatorEnable(valName, false);
              valName = document.getElementById("ContentPlaceHolder1_rfvVendor1");
              ValidatorEnable(valName, false);
              valName = document.getElementById("ContentPlaceHolder1_rfvV1BidStatus");
              ValidatorEnable(valName, false);

              valName = document.getElementById("ContentPlaceHolder1_rfvVendor1Rating");
              ValidatorEnable(valName, false);
              valName = document.getElementById("ContentPlaceHolder1_rfvVendor1AwardPreference");
              ValidatorEnable(valName, false);
              valName = document.getElementById("ContentPlaceHolder1_RequiredFieldValidator16");
              ValidatorEnable(valName, false);
          }


      }

      function ShowDeviation() {
          if ($("#chkDeviation").prop("checked")) {
              $("#dvDeviation").css("display", "block");
              var valName = document.getElementById("ContentPlaceHolder1_gvDeviationfromtender_rfvDFTStandrad_0");
              ValidatorEnable(valName, true);
          }
          else {
              $("#dvDeviation").css("display", "none");
              var valName = document.getElementById("ContentPlaceHolder1_gvDeviationfromtender_rfvDFTStandrad_0");
              ValidatorEnable(valName, false);

          }
      }

      function ddlGetProjectName() {

          var data = {};
          $("#<%=ddlCompany.ClientID %>").change(function () {
                data.companyId = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "MiscellaneousLogicNote.aspx/GetProjectName",
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
                    }
                });
            });
      }
      function ddlProjectName() {
          var data = {};
          $("#<%=ddlprojectname.ClientID %>").change(function () {
                data.projectId = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "MiscellaneousLogicNote.aspx/getPorjectAddress",
                    data: JSON.stringify(data),
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
                $('#<%=hiddenprojectnamevalue.ClientID %>').val(this.value);
                if ($(this).val() == 0) {
                    deleteAllCookies()
                    setCookie("Projectaddress", "", 30);

                }
            });
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
      function disabledUrgentRemark(item) {
          if ($("#" + item.id + " option:selected").val() == "Normal") {
              $("#<%=txtUrjentRemark.ClientID%>").attr("disabled", "disabled");
            }
            else {
                $("#<%=txtUrjentRemark.ClientID%>").removeAttr("disabled");
                $("#<%=txtReasonOfAmendment.ClientID%>").removeAttr("disabled");
            }
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
.table.table-bordered.table-hover.table-margin-buttom {
	margin-bottom: 0px !important;
}
.table.table-bordered.table-data td {
	/*padding: 9px 68.4px;*/
	border-top: 0px;
}
.table.table-bordered.table-data td:first-child {
/* padding: 9px 159.1px;*/
}
.table.table-bordered.table-data td:last-child {
/*padding: 9px 32px;*/
}
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
      <div class="x_panel tile fixed_height_320">
        <div class="x_title">
          <h2 class="text-center blue">Miscellaneous Logic Note Details</h2>
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
                <asp:RequiredFieldValidator ID="rfvApproval" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Type"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlApproval" InitialValue="0"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Approval No</label>
                <asp:TextBox ID="txtApprovalNo" disabled="disabled" AutoPostBack="true" OnTextChanged="txtApprovalNo_TextChanged" runat="server" CssClass="form-control" placeholder="Approval No"></asp:TextBox>
                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" DelimiterCharacters="" Enabled="True" ServiceMethod="GetApprovalNo" MinimumPrefixLength="1" EnableCaching="true"
                                    ServicePath="MiscellaneousLogicNote.aspx" TargetControlID="txtApprovalNo"> </cc1:AutoCompleteExtender>
                <asp:HiddenField runat="server" ID="hdnApprovalNo" Value="0" />
                <asp:HiddenField runat="server" ID="hdnApprovalType" Value="0" />
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold"> Approval Authority<span class="spnRequired">*</span></label>
                <asp:DropDownList ID="ddlapprovalauthrity" runat="server" class="form-control selectcss"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvapprovalauthrity" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Authrity"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlapprovalauthrity" InitialValue="0"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Company Name<span class="spnRequired">*</span></label>
                <asp:DropDownList ID="ddlCompany" runat="server" ClientIDMode="Static" CssClass="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCompany" ForeColor="Red" runat="server" ErrorMessage="Please Select Company Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlCompany" InitialValue="0"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Subject & Scope<span class="spnRequired">Max 200 Character *</span></label>
                <asp:TextBox ID="txtSubjectScope" TextMode="MultiLine" Rows="1" PlaceHolder="Subject & Scope" runat="server" class="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSubjectScope" ForeColor="Red" runat="server" ErrorMessage="Please Enter Subject Scope"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSubjectScope"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Project Name<span class="spnRequired">*</span></label>
                <asp:DropDownList ID="ddlprojectname" runat="server" class="form-control selectcss"></asp:DropDownList>
                <asp:HiddenField ID="hiddenprojectnamevalue" runat="server" />
                <asp:RequiredFieldValidator ID="rfvProjectname" ForeColor="Red" runat="server" ErrorMessage="Please Select Project Name"
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
                <asp:RequiredFieldValidator ID="rfvDepartment" ForeColor="Red" runat="server" ErrorMessage="Please Select Department Name"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlDepartment" InitialValue="0"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Reason Of Amendment</label>
                <asp:TextBox ID="txtReasonOfAmendment" autocomplete="off" placeholder="Reason Of Amendment" disabled="disabled"  runat="server" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Approval Priority<span class="spnRequired">*</span></label>
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
                <asp:TextBox ID="txtUrjentRemark" runat="server" PlaceHolder="Urgents Remarks" disabled="disabled" CssClass="form-control"></asp:TextBox>
                <%--    <asp:RequiredFieldValidator ID="rfvUrjentRemark" ForeColor="Red" runat="server" ErrorMessage="Please Enter Urjent Remarks"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtUrjentRemark"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-3" runat="server" id="dvStatus" visible="false">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Status<span class="spnRequired">*</span></label>
                <asp:DropDownList ID="ddlstatus" runat="server" Enabled="false" class="form-control selectcss">
                  <asp:ListItem Value="0">--Select One--</asp:ListItem>
                  <asp:ListItem Value="Approved">Approved</asp:ListItem>
                  <asp:ListItem Value="Pending">Pending</asp:ListItem>
                  <asp:ListItem Value="Draft">Draft</asp:ListItem>
                </asp:DropDownList>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Plan Award Date </label>
                <asp:TextBox ID="txtPlanAwardDate" autocomplete="off" type="date" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1"  class="font-weight-bold">Actual Date of Award </label>
                <asp:TextBox ID="txtActualDateOfAward" autocomplete="off" runat="server" type="date" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Approved Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                <asp:TextBox ID="txtApprovalBudget" runat="server" onblur="fillVariationofBudget()" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Approved Budget" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvApprovalBudget" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approved Budget"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtApprovalBudget"></asp:RequiredFieldValidator>
              </div>
            </div>
           <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Already Awarded <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                <asp:TextBox ID="txtAlreadyAwarded" runat="server" onblur="fillVariationofBudget()" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Already Awarded" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAlreadyAwarded" ForeColor="Red" runat="server" ErrorMessage="Please Enter Already Awarded"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtAlreadyAwarded"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Proposed Value of this award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                <asp:TextBox ID="txtProposedvalueofaward" runat="server" onblur="fillVariationofBudget()" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Proposed Value" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvProposedvalueofaward" ForeColor="Red" runat="server" ErrorMessage="Please Enter Proposed Value"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtProposedvalueofaward"></asp:RequiredFieldValidator>
              </div>
            </div>
           <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Balance to be award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                <asp:TextBox ID="txtBalancetobeaward" runat="server" onblur="fillVariationofBudget()" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Balance Value" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBalancetobeaward" ForeColor="Red" runat="server" ErrorMessage="Please Enter Balance to be award"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtBalancetobeaward"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold" style="display: block">Variation from Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                <asp:TextBox ID="txtvariationfrombudget" EnableViewState="true" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Variation from Budget" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvvariationfrombudget" ForeColor="Red" runat="server" ErrorMessage="Please Enter Variation Budget"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtvariationfrombudget"></asp:RequiredFieldValidator>
              </div>
            </div>
           <div class="col-sm-3">
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
           <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold">Others Description <span class="spnRequired">Max 100 Character *</span></label>
                <asp:TextBox ID="txtother" EnableViewState="true" TextMode="MultiLine" Rows="1" runat="server" CssClass="form-control" placeholder="Others Description"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="rvreasonforothers" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reason for Others"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtother"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold"> Name of Proposed Vendor <span class="small spnRequired"> <a href="VendorMaster.aspx" target="_blank" title="Click to add new vendor">Add Vendor</a> </span><span class="spnRequired">*</span></label>
                <asp:DropDownList ID="ddlnameofproposedvendor" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvnameofproposedvendor" ForeColor="Red" runat="server" ErrorMessage="Please Select Name of Proposed Vendor"
                                    ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlnameofproposedvendor"></asp:RequiredFieldValidator>
              </div>
            </div>
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
                <asp:RequiredFieldValidator ID="rfvNegotationMode" ForeColor="Red" runat="server" ErrorMessage="Please Select Negotiation Mode"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlNegotationMode" InitialValue="0"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="col-sm-12">
              <div class="form-group">
                <label for="exampleInputEmail1" class="font-weight-bold" style="display: block;">
                <div class="form-group">
                  <div >
                    <label for="exampleInputEmail1" class="font-weight-bold">Approval Sought </label>
                  </div>
                  <div >
                    <CKEditor:CKEditorControl Toolbar="Basic" ID="txtApproalSought" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                    <asp:RequiredFieldValidator ID="rfvApproalSought" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approved Sought"
                                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtApprovalBudget"></asp:RequiredFieldValidator>
                  </div>
                </div>
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
                            class="table table-bordered table-hover" OnRowDeleting="gvStandardexception_RowDeleting" OnPreRender="gvStandardexception_PreRender" OnRowDataBound="gvStandardexception_RowDataBound">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <a onclick="AddRowInMajordeviation('ContentPlaceHolder1_gvStandardexception')"> <img src="Icons/addicon.png" /></a>
                  <%--<asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>--%>
                  <asp:HiddenField ID="hddSEID" runat="server" Value='<%#Eval("ID") %>' />
                  <asp:HiddenField ID="hddRecommendation" runat="server" Value='<%#Eval("Recommendation") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="SNo">
                <ItemTemplate> <%#Container.DataItemIndex+1%> </ItemTemplate>
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
                  <asp:TextBox ID="txtrecommandation" runat="server" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvrecommandation" ControlToValidate="txtrecommandation" ValidationGroup="V" runat="server" ErrorMessage="Please Enter Recommandation" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate> <a onclick="delRow('ContentPlaceHolder1_gvStandardexception',this)" class="btn btn-primary fa fa-trash"></a>
                  <%--<asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>--%>
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
                  <asp:TextBox ID="txtTotalVendorConsidred" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" placeholder="Total vendor considered" class="form-control" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvTotalVendorConsidred" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total vendor considered"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalVendorConsidred"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Rejected Vendors<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRejectedVendor" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Rejected Vendors" CssClass="form-control" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvRejectedVendor" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rejected Vendors"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRejectedVendor"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">RFQ invited<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRFQInvited" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" placeholer=""></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvRFQInvited" ForeColor="Red" runat="server" ErrorMessage="Please Enter RFQ invited"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRFQInvited"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Not quoted<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtNotQuoted" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" Placeholder="Not quoted" onblur="FillVendorCal()"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvNotQuoted" ForeColor="Red" runat="server" ErrorMessage="Please Enter Not quoted"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtNotQuoted"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Final Considered<span class="spnRequired">*</span></label>
                  <br />
                  <asp:TextBox ID="txtFinalConsidered" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" PlaceHolder="Final Considered"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvFinalConsidered" ForeColor="Red" runat="server" ErrorMessage="Please Enter Final Considered"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtFinalConsidered"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Stipulated Completion Time<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtStipulatedCompletionTime" runat="server" CssClass="form-control" type="date" autocomplete="off" PlaceHolder="Stipulated Completion Time"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvStipulatedCompletionTime" ForeColor="Red" runat="server" ErrorMessage="Please Enter Stipulated Completion Time"
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
                  <asp:RequiredFieldValidator ID="rfvBidType" ForeColor="Red" runat="server" ErrorMessage="Please Select Bid Type"
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
                  <asp:RequiredFieldValidator ID="rfvApprovalType" ForeColor="Red" runat="server" ErrorMessage="Please Enter Select Approval type"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlApprovaltype"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Contractor Name</label>
                  <asp:TextBox ID="txtContratorName" EnableViewState="false" runat="server" PlaceHolder="Contractor Name" CssClass="form-control"></asp:TextBox>
                  <%-- <asp:RequiredFieldValidator ID="rfvContratorName" ForeColor="Red" runat="server" ErrorMessage="Please Enter Contractor Name"
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
                  <asp:RequiredFieldValidator ID="rfvAuctionType" ForeColor="Red" runat="server" ErrorMessage="Please Select Auction Type"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlActionType"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason</label>
                  <asp:TextBox ID="txtReason" placeholder="Reason" runat="server" CssClass="form-control"></asp:TextBox>
                  <%--  <asp:RequiredFieldValidator ID="rfvReason" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reason"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtReason"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">
              <asp:CheckBox runat="server" onchange="ShowTop3Bid()" ClientIDMode="Static" ID="chktop3bid" />
              &nbsp;Final Top Three Bid(Red. High, Green. Lowest) </h2>
            <%--<ul class="nav navbar-right panel_toolbox">
                            <li>
                                <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                        </ul>--%>
            <div class="clearfix"></div>
          </div>
          <div id="dvtop3bid" runat="server" clientidmode="Static" style="display:none;">
            <div class="x_content table-responsive">
              <asp:GridView ID="gvItemHead" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvItemHead_RowDataBound"
                                class="table table-bordered table-hover table-margin-buttom" OnRowDeleting="gvItemHead_RowDeleting" OnPreRender="gvItemHead_PreRender">
                <Columns>
                <asp:TemplateField HeaderText="Add">
                  <ItemTemplate> <a onclick="AddRowInTop3Bid('ContentPlaceHolder1_gvItemHead')"> <img src="Icons/addicon.png" /></a>
                    <asp:HiddenField ID="hddIHID" runat="server" Value='<%#Eval("ID") %>' />
                    <asp:HiddenField ID="hddUOM" runat="server" Value='<%#Eval("UOM") %>' />
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Descriptions">
                  <ItemTemplate>
                    <asp:TextBox ID="txtdesc" Width="120px" runat="server" Text='<%#Eval("Description") %>' class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTop3Description" ControlToValidate="txtdesc" ValidationGroup="V" runat="server" ErrorMessage="Description Required" ForeColor="Red"></asp:RequiredFieldValidator>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="UOM">
                  <ItemTemplate>
                    <asp:DropDownList ID="ddlUOM" Width="120px" runat="server" class="form-control selectcss"> </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlUOM" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="UOM Required" ForeColor="Red"></asp:RequiredFieldValidator>
                  </ItemTemplate>
                  <%--<FooterTemplate>
                                        Total
                                    </FooterTemplate>--%>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                  <ItemTemplate>
                    <asp:TextBox ID='txtQuantity' Width="120px" onchange="QuantityCal('txtQuantity','0')" Text='<%#Eval("Quantity") %>' oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control quantity"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvQuantity" ControlToValidate="txtQuantity" ValidationGroup="V" runat="server" ErrorMessage="Quantity Required" ForeColor="Red"></asp:RequiredFieldValidator>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Party1 Rate">
                  <ItemTemplate>
                    <asp:TextBox ID="txtVendor1Rate" Width="120px" onchange="Party1Cal('txtVendor1Rate','0');" Text='<%#Eval("V1Rate") %>' oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v1rate"></asp:TextBox>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Party1 Value">
                  <ItemTemplate>
                    <asp:TextBox ID="txtVendor1Value" Width="120px" Text='<%#Eval("V1Value") %>' oninput="process(this)" disabled="disabled" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v1value"></asp:TextBox>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Party2 Rate">
                  <ItemTemplate>
                    <asp:TextBox ID="txtVendor2Rate" Width="120px" onchange="Party2Cal('txtVendor2Rate','0');" oninput="process(this)" Text='<%#Eval("V2Rate") %>' onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v2rate"></asp:TextBox>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Party2 Value">
                  <ItemTemplate>
                    <asp:TextBox ID="txtVendor2Value" Width="120px" Text='<%#Eval("V2Value") %>' oninput="process(this)" disabled="disabled" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v2value"></asp:TextBox>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Party3 Rate">
                  <ItemTemplate>
                    <asp:TextBox ID="txtVendor3Rate" Width="120px" onchange="Party3Cal('txtVendor3Rate','0');" Text='<%#Eval("V3Rate") %>' oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v3rate"></asp:TextBox>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Party3 Value">
                  <ItemTemplate>
                    <asp:TextBox ID="txtVendor3Value" Width="120px" Text='<%#Eval("V3Value") %>' oninput="process(this)" disabled="disabled" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control v3value"></asp:TextBox>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Base Rate">
                  <ItemTemplate>
                    <asp:TextBox ID="txtBaseRate" Width="120px" Text='<%#Eval("BaseRate") %>' onchange="SumAll()" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control baserate"></asp:TextBox>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Target Cost">
                  <ItemTemplate>
                    <asp:TextBox ID="txtTargetCost" Width="120px" onchange="SumAll()" OnTextChanged="txtVendor2Rate_TextChanged" Text='<%#Eval("TargetCost") %>' oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control targetcost"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTargetCost" ControlToValidate="txtTargetCost" ValidationGroup="V" runat="server" ErrorMessage="TargetCost Required" ForeColor="Red"></asp:RequiredFieldValidator>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="In HouseEstimated Cost">
                  <ItemTemplate>
                    <asp:TextBox ID="txtEstimatedCost" Width="120px" Text='<%#Eval("EstimatedCost") %>' onchange="SumAll()" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" runat="server" class="form-control estimatedcost"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEstimatedCost" ControlToValidate="txtEstimatedCost" ValidationGroup="V" runat="server" ErrorMessage="Estimated Cost Required" ForeColor="Red"></asp:RequiredFieldValidator>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete">
                  <ItemTemplate> <a onclick="delRow('gvItemHead',this,'True')" class="btn btn-primary fa fa-trash"></a> </ItemTemplate>
                </asp:TemplateField>
                </Columns>
              </asp:GridView>
              <table cellspacing="0" rules="all" class="table table-hover table-bordered table-data" border="1" id="ContentPlaceHolder1_gvItemHead" style="border-collapse: collapse;">
                <tbody>
                  <tr>
                    <td><label class="form-control" style="width: 322px;">Total</label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTotalQuantity" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTotalV1Rate" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTotalV1Value" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTotalV2Rate" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTotalV2Value" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTotalV3Rate" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTotalV3Value" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblBaserate" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblTargetCost" ClientIDMode="Static">0</asp:Label></td>
                    <td><asp:Label class="form-control " Style="width: 120px; overflow: hidden;" runat="server" ID="lblEstimatedCost" ClientIDMode="Static">0</asp:Label></td>
                    <td></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="x_content table-responsive">
              <div class="col-sm-12">
                <div class="col-sm-3"></div>
                <div class="col-sm-3">
                  <h4>Party 1<span class="spnRequired">*</span></h4>
                </div>
                <div class="col-sm-3">
                  <h4>Party 2</h4>
                </div>
                <div class="col-sm-3">
                  <h4>Party 3</h4>
                </div>
              </div>
              <div class="col-sm-12">
                <div class="col-sm-3"> </div>
                <div class="col-sm-3">
                  <asp:DropDownList ID="ddlVendor1" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvVendor1" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1"
                                        ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlVendor1"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-3">
                  <asp:DropDownList ID="ddlVendor2" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                </div>
                <div class="col-sm-3">
                  <asp:DropDownList ID="ddlVendor3" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                </div>
              </div>
              <div class="col-sm-12 mt-1">
                <div class="col-sm-3">
                  <h4>Other Charges</h4>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV1OtherCharges" onchange="SumAll()" ClientIDMode="Static" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvV1OtherCharges" ForeColor="Red" runat="server" ErrorMessage="Please Enter Other Charges"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1OtherCharges"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV2OtherCharges" onchange="SumAll()" ClientIDMode="Static" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV3OtherCharges" onchange="SumAll()" ClientIDMode="Static" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-12 mt-1">
                <div class="col-sm-3">
                  <h4>GST</h4>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV1GST" ClientIDMode="Static" onchange="SumAll()" runat="server" PlaceHolder="GST" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvV1GST" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 GST"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1GST"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV2GST" ClientIDMode="Static" onchange="SumAll()" runat="server" PlaceHolder="GST" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV3GST" runat="server" onchange="SumAll()" ClientIDMode="Static" PlaceHolder="GST" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-12 mt-1">
                <div class="col-sm-3">
                  <h4 style="display: contents;">Grand Total</h4>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV1GrandTotal" ClientIDMode="Static" runat="server" PlaceHolder="Grand Total" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                  <%--   <asp:RequiredFieldValidator ID="rfvV1GrandTotal" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Grand Total"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1GrandTotal"></asp:RequiredFieldValidator>--%>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV2GrandTotal" ClientIDMode="Static" runat="server" PlaceHolder="Grand Total" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV3GrandTotal" ClientIDMode="Static" runat="server" PlaceHolder="Grand Total" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-12 mt-1">
                <div class="col-sm-3">
                  <h4>Delivery Timeline</h4>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV1DeliveryTimeline" runat="server" Text="" type="date" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Delivery Timeline"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1DeliveryTimeline"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV2DeliveryTimeline" runat="server" type="date" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2Freight"></asp:RequiredFieldValidator>--%>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV3DeliveryTimeline" runat="server" type="date" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Freight"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3Freight"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-12 mt-1">
                <div class="col-sm-3">
                  <h4>Bid Status</h4>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV1BidStatus" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvV1BidStatus" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Bid Status"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1BidStatus"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV2BidStatus" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
                </div>
                <div class="col-sm-3">
                  <asp:TextBox ID="txtV3BidStatus" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
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
                  <asp:RequiredFieldValidator ID="rfvVendor1Rating" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1 Vendor Ratings"
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
                  <asp:RequiredFieldValidator ID="rfvVendor1AwardPreference" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1 Award Preference"
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
            </div>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">
              <asp:CheckBox runat="server" onchange="ShowDeviation()" ClientIDMode="Static" ID="chkDeviation" />
              &nbsp;Deviation from Tender/ RFQ, if any</h2>
            <%--<ul class="nav navbar-right panel_toolbox">
                            <li>
                                <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                        </ul>--%>
            <div class="clearfix"></div>
          </div>
          <div class="x_content" runat="server" id="dvDeviation" clientidmode="Static" style="display:none" >
            <asp:GridView ID="gvDeviationfromtender" runat="server" AutoGenerateColumns="False"
                            class="table table-bordered table-hover" OnRowDeleting="gvDeviationfromtender_RowDeleting" OnPreRender="gvDeviationfromtender_PreRender">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate> <a onclick="AddRowInDeviation('ContentPlaceHolder1_gvDeviationfromtender')"> <img src="Icons/addicon.png" /></a>
                  <%--<asp:LinkButton ID="lnkAdd" runat="server" Visible="true" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>--%>
                  <asp:HiddenField ID="hddDFTID" runat="server" Value='<%#Eval("ID") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Standard Terms">
                <ItemTemplate>
                  <CKEditor:CKEditorControl Toolbar="Basic" Text='<%#Eval("StandardTerms") %>' ID="ckDFTStandrad" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
                  <asp:RequiredFieldValidator ID="rfvDFTStandrad" ControlToValidate="ckDFTStandrad" ValidationGroup="V" runat="server" ErrorMessage="Standard Terms Required" ForeColor="Red"></asp:RequiredFieldValidator>
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
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate> <a onclick="delRow('ContentPlaceHolder1_gvDeviationfromtender',this,'False')" class="btn btn-primary fa fa-trash"></a> </ItemTemplate>
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
       
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Recommendations with reasons</label>
                  <CKEditor:CKEditorControl Toolbar="Basic" ID="txtreccomandationwithreason" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                  <asp:RequiredFieldValidator ID="rfvreccomandationwithreason" ForeColor="Red" runat="server" ErrorMessage="Please Enter Recommendations with reasons"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtreccomandationwithreason"></asp:RequiredFieldValidator>
                </div>
           
            <div class="row">
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Turnover last year<span class="small">(in Lacs)</span></label>
                  <asp:TextBox ID="txtTournoverlastyear" runat="server" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Turnover last year" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Turnover last year"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTournoverlastyear"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Total orders with Co. till date</label>
                  <asp:TextBox ID="txtTotalOrderwithcotilldate" oninput="process(this)" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" CssClass="form-control" placeholer=""></asp:TextBox>
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
                            class="table table-bordered table-hover" OnRowDeleting="gvTermsandCondition_RowDeleting">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <a onclick="AddRowInTermsAndConditions('ContentPlaceHolder1_gvTermsandCondition')"> <img src="Icons/addicon.png" /></a>
                  <asp:HiddenField ID="hddTCID" runat="server" Value='<%#Eval("ID") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="SNo">
                <ItemTemplate> <%#Container.DataItemIndex+1%> </ItemTemplate>
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
                <ItemTemplate> <a onclick="delRow('ContentPlaceHolder1_gvTermsandCondition',this,'False')" class="btn btn-primary fa fa-trash"></a> </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
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
                            class="table table-bordered table-hover" OnRowDeleting="gvApprover_RowDeleting" OnRowDataBound="gvApprover_RowDataBound" OnRowCommand="gvApprover_RowCommand" OnPreRender="gvApprover_PreRender" >
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate> 
                    <%--<a onclick="addRow('ContentPlaceHolder1_gvApprover','False')"> <img src="Icons/addicon.png" /></a>--%>
                    <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                  <asp:HiddenField ID="hddAID" runat="server" Value='<%#Eval("ID") %>' />
                  <asp:HiddenField ID="hddApprover" runat="server" Value='<%#Eval("ApproverID") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Approver">
                <ItemTemplate>
                  <asp:DropDownList ID="ddlApprover" runat="server" class="form-control approver"> </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvApprover" ControlToValidate="ddlApprover" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="Approver Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate> 
                    <%--<a onclick="delRow('ContentPlaceHolder1_gvApprover',this,'False')" class="btn btn-primary fa fa-trash"></a> --%>
                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Approver"></asp:LinkButton>
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
                  <a onclick="AddRowInAttachment('ContentPlaceHolder1_gvAttachment')"> <img src="Icons/addicon.png" /></a>
                  <asp:HiddenField ID="hddAttachmentID" runat="server" Value='<%#Eval("ID") %>' />
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
                <ItemTemplate> <a onclick="delRow('ContentPlaceHolder1_gvAttachment',this,'False')" class="btn btn-primary fa fa-trash"></a> </ItemTemplate>
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
            <div class="col-sm-12">
              <CKEditor:CKEditorControl Toolbar="Basic" ID="ckremark" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator35" ForeColor="Red" runat="server" ErrorMessage="Please Enter Remark"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="ckremark"></asp:RequiredFieldValidator>
            </div>
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Miscellaneous Head<span class="spnRequired">*</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
           
              <CKEditor:CKEditorControl Toolbar="Basic" ID="ckPurchaseHead" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator49" ForeColor="Red" runat="server" ErrorMessage="Please Enter Purchase Head"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="ckPurchaseHead"></asp:RequiredFieldValidator>
          
          </div>
        </div>

      <div class="col-md-12 col-sm-12 " style="display: none;">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Head Of Department<span class="spnRequired">*</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="col-sm-12">
              <CKEditor:CKEditorControl Toolbar="Basic" ID="chkHeadOfDepartMent" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
            </div>
          </div>
        </div>
      </div>
        <div>
       
            <asp:Button ID="btnSubmit" runat="server" OnClientClick="SetData();" CssClass="btn btn-primary" Text="Save as Draft"  OnClick="btnSubmit_Click" />
            <asp:Button ID="btnSubmitforApproval" OnClientClick="SetData();" runat="server" CssClass="btn btn-primary" Text="Submit for Approval" ValidationGroup="V" OnClick="btnSubmitforApproval_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />
            <asp:ValidationSummary ID="ValidSum" runat="server" ValidationGroup="V" ShowMessageBox="true" ShowSummary="false" />
            <%--<a onclick="SetAttachment();">test</a>--%>
      
        </div>
      <asp:HiddenField runat="server" ID="hdnSetMajordeviation" Value="" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnTop3Bid" Value="" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnSetDataDeviation" Value="" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnApproverData" Value="" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnSetDataTermsAndConditions" Value="" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnAttachmentData" Value="" ClientIDMode="Static" />
      <asp:HiddenField runat="server" ID="hdnID" Value="" ClientIDMode="Static" />
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="btnSubmit" />
      <asp:PostBackTrigger ControlID="btnSubmitforApproval" />
      <asp:PostBackTrigger ControlID="gvAttachment" />
      <asp:PostBackTrigger ControlID="txtApprovalNo" />
    </Triggers>
  </asp:UpdatePanel>
  <script>


        function addRow(id, isFooter) {

            var x = document.getElementById(id).tBodies[0];  //get the table

            //var node = x.rows[1].cloneNode(true);//clone the previous node or row
            var node = x.rows[1].cloneNode(true);
            var InputType = node.getElementsByTagName("input");// Find textbox

            for (var i = 0; i < InputType.length; i++) {

                if (InputType[i].type == 'checkbox') {
                    InputType[i].checked = false;    // Set  false checked value
                }
                else if (InputType[i].type == 'hidden') {
                    InputType[i].remove(); // remove hidden fields
                    i--;
                }
                else {
                    InputType[i].value = '';      // Set null value
                }
            }

            var SelectType = node.getElementsByTagName("select");
            for (var i = 0; i < SelectType.length; i++) {
                SelectType[i].selectedIndex = 0;
            }


            if (isFooter == 'True') {
                $(`#${id}`).find('tr:last').prev().after(node);

                $(`#${id} tbody tr`).each(function () {
                    $(this).find('td:First a').hide();
                });

                $(`#${id} tbody tr:last`).prev().find('td:First a').show();
            }
            else {
                x.appendChild(node);   //add the node or row to the table

                $(`#${id} tbody tr`).each(function () {
                    $(this).find('td:First a').hide();
                });

                $(`#${id} tbody tr:last`).find('td:First a').show();
            }

        }

        function delRow(id, row, isfooter) {
            var rows = 2;
            if (isfooter == 'True') {
                rows = 3;
            }

            if ($(`#${id} tbody tr`).length > parseInt(rows)) {


                var index = $(`#${id} tr`).index($(row).parents('tr'));
                if (index == 1) {
                    // find hidden fields and move to first row
                    var hiddenType = $(row).parents('tr').find("input[type=hidden]");// Find textbox
                    $(`#${id} tbody tr`).eq(2).find('td:First').append(hiddenType);
                }

                $(row).parents('tr').remove();
                if (isfooter == 'True') {
                    $(`#${id} tbody tr:last`).prev().find('td:First a').show();
                    return;
                }
                $(`#${id} tbody tr:last`).find('td:First a').show();
            }
            else {
                alert('Minimum one row is required!');
            }
        }

        $(document).ready(function () {
            var id = 'ContentPlaceHolder1_gvTermsandCondition';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();
            var id = 'ContentPlaceHolder1_gvStandardexception';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();
            var id = 'ContentPlaceHolder1_gvDeviationfromtender';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();

            var id = 'ContentPlaceHolder1_gvAttachment';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();

            var id = 'ContentPlaceHolder1_gvApprover';
            $(`#${id} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id} tbody tr:last`).find('td:First a').show();


            var id2 = 'ContentPlaceHolder1_gvItemHead';
            $(`#${id2} tbody tr`).each(function () {
                $(this).find('td:First a').hide();
            });

            $(`#${id2} tbody tr:last`).find('td:First a').show();

            SumAll();
            return false;
        });
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


        function SumTargetCost() {
            var TargetCost = 0;
            $(".targetcost").each(function () {
                var rate = parseFloat($(this).val() == "" ? "0" : $(this).val());
                TargetCost = TargetCost + rate;
            });
            $("#lblTotalTargetCost").text(TargetCost);
        }

        function SumOfHouseEstimatedCost() {
            var HouseEstimatedCost = 0;
            $(".HouseEstimatedCost").each(function () {
                var rate = parseFloat($(this).val() == "" ? "0" : $(this).val());
                HouseEstimatedCost = HouseEstimatedCost + rate;
            });
            $("#lblTotalHouseEstimatedCost").text(HouseEstimatedCost);
        }

        function V1GrandTotal() {
            var GrandTotal = 0;// parseFloat($("#lblTotalV1Rate").text() == "" ? "0" : $("#lblTotalV1Rate").text());
            var GST = parseFloat($("#txtV1GST").val() == "" ? "0" : $("#txtV1GST").val());
            var Freight = parseFloat($("#txtV1Freight").val() == "" ? "0" : $("#txtV1Freight").val());
            var TCS = parseFloat($("#txtV1HeadlingCharges").val() == "" ? "0" : $("#txtV1HeadlingCharges").val());
            var v1Rate = 0;
            $(".v1rate").each(function () {
                var rate = parseFloat($(this).val() == "" ? "0" : $(this).val());
                v1Rate = v1Rate + rate;
            });
            $("#lblTotalV1Rate").text(v1Rate);

            GrandTotal = GrandTotal + GST + Freight + TCS + v1Rate;
            $("#txtV1GrandTotal").val(GrandTotal);
        }
        function V2GrandTotal() {
            var GrandTotal = 0;//parseFloat($("#lblTotalV2Rate").text() == "" ? "0" : $("#lblTotalV2Rate").text());
            var GST = parseFloat($("#txtV2GST").val() == "" ? "0" : $("#txtV2GST").val());
            var Freight = parseFloat($("#txtV2Freight").val() == "" ? "0" : $("#txtV2Freight").val());
            var TCS = parseFloat($("#txtV2HeadlingCharges").val() == "" ? "0" : $("#txtV2HeadlingCharges").val());
            var v2Rate = 0;

            $(".v2rate").each(function () {
                var rate = parseFloat($(this).val() == "" ? "0" : $(this).val());
                v2Rate = v2Rate + rate;
            });
            $("#lblTotalV2Rate").text(v2Rate);
            GrandTotal = GrandTotal + GST + Freight + TCS + v2Rate;
            $("#txtV2GrandTotal").val(GrandTotal);
        }
        function V3GrandTotal() {
            var GrandTotal = 0;// parseFloat($("#lblTotalV3Rate").text() == "" ? "0" : $("#lblTotalV3Rate").text());
            var GST = parseFloat($("#txtV3GST").val() == "" ? "0" : $("#txtV3GST").val());
            var Freight = parseFloat($("#txtV3Freight").val() == "" ? "0" : $("#txtV3Freight").val());
            var TCS = parseFloat($("#txtV3HeadlingCharges").val() == "" ? "0" : $("#txtV3HeadlingCharges").val());
            var v3Rate = 0;

            $(".v3rate").each(function () {
                var rate = parseFloat($(this).val() == "" ? "0" : $(this).val());
                v3Rate = v3Rate + rate;
            });
            $("#lblTotalV3Rate").text(v3Rate);
            GrandTotal = GrandTotal + GST + Freight + TCS + v3Rate;
            $("#txtV3GrandTotal").val(GrandTotal);
        }

        function V1Value(item) {
            var rows = getHighlightRow();
            console.log(rows);

            var Q = rows[0].childNodes[5]
            var txtQuantity_html = Q.childNodes[1]

            console.log($("#" + txtQuantity_html.id).val());

            var P1R = rows[0].childNodes[6]
            var txtP1R_html = P1R.childNodes[1]
            console.log($("#" + txtP1R_html.id).val());
        }
        //$(function () {
        //    $('#gvItemHead').on('click', 'tbody tr', function (event) {
        //        $(this).addClass('highlight').siblings().removeClass('highlight');
        //    });

        //    getHighlightRow();
        //});
        //function getHighlightRow() {
        //    return $('#gvItemHead > tbody > tr.highlight');
        //}
        function FindTR(index) {
            //Add a click event to the row of the table
            var tr = $('#gvItemHead').find("tr")//$(item);//Find tr element

            console.log(tr);
            var td = tr.find("td");//Find td element

            var Q = td[4].childNodes[1]//Specify the subscript, Android is normal, iOS returns html code
            console.log($("#" + Q.id).val());
            //Specify the subscript, Android and iOS are normal, and the td data is returned

        }
        function myFunction(vt) {
            var qt = parseFloat($(vt).val());
            var bl = $(vt).parent().next("td").find("input:text")[0];
            $("#" + bl[0].id).val(qt);
            console.log(bl[0].id);
        }
        function test(item) {
            var td = $(item).closest("tr").find('td');
            var childNode = $("#" + td[4].childNodes[1].name).val();
            console.log(childNode);
        }

    </script> 
  <script>

      function AddRowInMajordeviation(containerId) {

          var tableRef = document.getElementById(containerId);
          var lastRow = tableRef.rows.length;
          var newRow = tableRef.insertRow(lastRow);

          var newCell = newRow.insertCell(0);
          var controlRef = document.createElement('a');
          controlRef.type = 'button';
          controlRef.id = containerId + '_link' + (lastRow - 1);
          controlRef.name = controlRef.id;
          controlRef.value = "Add"
          controlRef.className = "addPaymentPlanRow";
          controlRef.innerHTML = "<img src='Icons/addicon.png' />";
          newCell.appendChild(controlRef);
          $("#" + controlRef.id).attr("onclick", "AddRowInMajordeviation('ContentPlaceHolder1_gvStandardexception')")

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
          controlRef2.id = containerId + '_ckStandrad_' + (lastRow - 1);
          controlRef2.name = controlRef2.id;
          // controlRef2.size = 20;
          controlRef2.className = "ckeditor";
          newCell2.appendChild(controlRef2);
          CKEDITOR.replace(controlRef2.name);


          var newCell3 = newRow.insertCell(3);
          var controlRef3 = document.createElement('input');
          controlRef3.type = 'text';
          controlRef3.id = containerId + '_ckExcepetion_' + (lastRow - 1);
          controlRef3.name = controlRef3.id;
          controlRef3.className = "form-control";
          newCell3.appendChild(controlRef3);
          CKEDITOR.replace(controlRef3.id);

          var newCell4 = newRow.insertCell(4);
          var controlRef4 = document.createElement('input');
          controlRef4.type = 'text';
          controlRef4.id = containerId + '_txtrecommandation_' + (lastRow - 1);
          controlRef4.name = controlRef4.id;
          controlRef4.className = "form-control";
          newCell4.appendChild(controlRef4);


          var newCell5 = newRow.insertCell(5);
          var controlRef5 = document.createElement('a');
          controlRef5.type = 'button';
          controlRef5.id = containerId + '_delete_' + (lastRow - 1);
          controlRef5.name = controlRef5.id;
          controlRef5.className = "btn btn-primary fa fa-trash";
          newCell5.appendChild(controlRef5);
          $("#" + controlRef5.id).attr("onclick", "delRow('ContentPlaceHolder1_gvStandardexception',this)")

          var id = 'ContentPlaceHolder1_gvStandardexception';
          $(`#${id} tbody tr`).each(function () {
              $(this).find('td:First a').hide();
          });

          $(`#${id} tbody tr:last`).find('td:First a').show();
          return false;
      }
      function SetDataMajordeviation() {
          var tableRef = document.getElementById("ContentPlaceHolder1_gvStandardexception");
          var lastRow = tableRef.rows.length;
          var AllData = [];
          for (var i = 0; i < lastRow - 1; i++) {
              var data = {};
              data.ID = (i + 1).toString();
              data.Standard = CKEDITOR.instances[tableRef.id + "_ckStandrad_" + i].document.getBody().getText();
              data.Excepetion = CKEDITOR.instances[tableRef.id + "_ckExcepetion_" + i].document.getBody().getText();
              data.Recommendation = $("#" + tableRef.id + "_txtrecommandation_" + i).val();
              AllData.push(data);
          }
          console.log(JSON.stringify(AllData));
          $("#hdnSetMajordeviation").val(JSON.stringify(AllData));
      }
      function AddRowInTop3Bid(containerId) {

          var tableRef = document.getElementById(containerId);
          var lastRow = tableRef.rows.length;
          var newRow = tableRef.insertRow(lastRow);
          var ddlUOM = $("#ContentPlaceHolder1_gvItemHead_ddlUOM_0").html();
          var newCell = newRow.insertCell(0);
          var controlRef = document.createElement('a');
          controlRef.type = 'button';
          controlRef.id = containerId + '_link' + (lastRow - 1);
          controlRef.name = controlRef.id;
          controlRef.value = "Add"

          controlRef.innerHTML = "<img src='Icons/addicon.png' />";
          newCell.appendChild(controlRef);
          $("#" + controlRef.id).attr("onclick", "AddRowInTop3Bid('ContentPlaceHolder1_gvItemHead')")

          var newCell1 = newRow.insertCell(1);
          var controlRef1 = document.createElement('input');
          controlRef1.type = 'text';
          controlRef1.id = containerId + '_txtdesc_' + (lastRow - 1);
          controlRef1.className = "form-control";
          controlRef1.name = controlRef1.id;
          controlRef1.innerText = lastRow;
          newCell1.appendChild(controlRef1);

          var newCell2 = newRow.insertCell(2);
          var controlRef2 = document.createElement('select');
          controlRef2.type = 'select';
          controlRef2.id = containerId + '_ddlUOM_' + (lastRow - 1);
          controlRef2.name = controlRef2.id;
          // controlRef2.size = 20;
          controlRef2.className = "form-control";
          newCell2.appendChild(controlRef2);
          $("#" + controlRef2.id).html(ddlUOM);


          var newCell3 = newRow.insertCell(3);
          var controlRef3 = document.createElement('input');
          controlRef3.type = 'text';
          controlRef3.id = containerId + '_txtQuantity_' + (lastRow - 1);
          controlRef3.name = controlRef3.id;
          controlRef3.className = "form-control quantity";
          controlRef3.value = "0";
          newCell3.appendChild(controlRef3);
          $("#" + controlRef3.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef3.id).attr("oninput", "process(this)");
          $("#" + controlRef3.id).attr("onchange", " QuantityCal('txtQuantity','" + (lastRow - 1) + "')");



          var newCell4 = newRow.insertCell(4);
          var controlRef4 = document.createElement('input');
          controlRef4.type = 'text';
          controlRef4.id = containerId + '_txtVendor1Rate_' + (lastRow - 1);
          controlRef4.name = controlRef4.id;
          controlRef4.className = "form-control v1rate";
          controlRef4.value = "0";
          newCell4.appendChild(controlRef4);
          $("#" + controlRef4.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef4.id).attr("oninput", "process(this)");
          $("#" + controlRef4.id).attr("onchange", "Party1Cal('txtVendor1Rate','" + (lastRow - 1) + "')");


          var newCell5 = newRow.insertCell(5);
          var controlRef5 = document.createElement('input');
          controlRef5.type = 'text';
          controlRef5.id = containerId + '_txtVendor1Value_' + (lastRow - 1);
          controlRef5.name = controlRef5.id;
          controlRef5.className = "form-control v1value";
          controlRef5.value = "0";

          newCell5.appendChild(controlRef5);
          $("#" + controlRef5.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef5.id).attr("oninput", "process(this)");
          $("#" + controlRef5.id).attr("disabled", "disabled");

          var newCell6 = newRow.insertCell(6);
          var controlRef6 = document.createElement('input');
          controlRef6.type = 'text';
          controlRef6.id = containerId + '_txtVendor2Rate_' + (lastRow - 1);
          controlRef6.name = controlRef6.id;
          controlRef6.value = "0";
          controlRef6.className = "form-control v2rate";
          newCell6.appendChild(controlRef6);
          $("#" + controlRef6.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef6.id).attr("oninput", "process(this)");
          $("#" + controlRef6.id).attr("onchange", "Party2Cal('txtVendor2Rate','" + (lastRow - 1) + "')");

          var newCell7 = newRow.insertCell(7);
          var controlRef7 = document.createElement('input');
          controlRef7.type = 'text';
          controlRef7.id = containerId + '_txtVendor2Value_' + (lastRow - 1);
          controlRef7.name = controlRef7.id;
          controlRef7.className = "form-control v2value";
          controlRef7.value = "0";
          newCell7.appendChild(controlRef7);
          $("#" + controlRef7.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef7.id).attr("oninput", "process(this)");
          $("#" + controlRef7.id).attr("disabled", "disabled");
          var newCell8 = newRow.insertCell(8);
          var controlRef8 = document.createElement('input');
          controlRef8.type = 'text';
          controlRef8.id = containerId + '_txtVendor3Rate_' + (lastRow - 1);
          controlRef8.name = controlRef8.id;
          controlRef8.className = "form-control v3rate";
          controlRef8.value = "0";
          newCell8.appendChild(controlRef8);
          $("#" + controlRef8.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef8.id).attr("oninput", "process(this)");
          $("#" + controlRef8.id).attr("onchange", "Party3Cal('txtVendor3Rate','" + (lastRow - 1) + "')");


          var newCell9 = newRow.insertCell(9);
          var controlRef9 = document.createElement('input');
          controlRef9.type = 'text';
          controlRef9.id = containerId + '_txtVendor3Value_' + (lastRow - 1);
          controlRef9.name = controlRef9.id;
          controlRef9.className = "form-control v3value";
          controlRef9.value = "0";
          newCell9.appendChild(controlRef9);
          $("#" + controlRef9.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef9.id).attr("oninput", "process(this)");
          $("#" + controlRef9.id).attr("disabled", "disabled");

          var newCell10 = newRow.insertCell(10);
          var controlRef10 = document.createElement('input');
          controlRef10.type = 'text';
          controlRef10.id = containerId + '_txtBaseRate_' + (lastRow - 1);
          controlRef10.name = controlRef10.id;
          controlRef10.className = "form-control baserate";
          controlRef10.value = "0";
          newCell10.appendChild(controlRef10);
          $("#" + controlRef10.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef10.id).attr("oninput", "process(this)");
          $("#" + controlRef10.id).attr("onchange", 'SumAll()');

          var newCell11 = newRow.insertCell(11);
          var controlRef11 = document.createElement('input');
          controlRef11.type = 'text';
          controlRef11.id = containerId + '_txtTargetCost_' + (lastRow - 1);
          controlRef11.name = controlRef11.id;
          controlRef11.className = "form-control targetcost";
          controlRef11.value = "0";
          newCell11.appendChild(controlRef11);
          $("#" + controlRef11.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef11.id).attr("oninput", "process(this)");
          $("#" + controlRef11.id).attr("onchange", 'SumAll()');

          var newCell12 = newRow.insertCell(12);
          var controlRef12 = document.createElement('input');
          controlRef12.type = 'text';
          controlRef12.id = containerId + '_txtEstimatedCost_' + (lastRow - 1);
          controlRef12.name = controlRef12.id;
          controlRef12.className = "form-control estimatedcost";
          controlRef12.value = "0";
          newCell12.appendChild(controlRef12);
          $("#" + controlRef12.id).attr("onkeypress", "return isDecimalKey(this, event)");
          $("#" + controlRef12.id).attr("oninput", "process(this)");
          $("#" + controlRef12.id).attr("onchange", 'SumAll()');


          var newCell13 = newRow.insertCell(13);
          var controlRef13 = document.createElement('a');
          controlRef13.type = 'button';
          controlRef13.id = containerId + '_delete_' + (lastRow - 1);
          controlRef13.name = controlRef13.id;
          controlRef13.className = "btn btn-primary fa fa-trash";
          newCell13.appendChild(controlRef13);
          $("#" + controlRef13.id).attr("onclick", "delRow('ContentPlaceHolder1_gvItemHead',this)")

          var id = 'ContentPlaceHolder1_gvItemHead';
          $(`#${id} tbody tr`).each(function () {
              $(this).find('td:First a').hide();
          });

          $(`#${id} tbody tr:last`).find('td:First a').show();
          return false;
      }

      function QuantityCal(id, index) {
          var containerId = "ContentPlaceHolder1_gvItemHead";
          var quantity = parseFloat($("#" + containerId + "_" + id + "_" + index).val() == "" ? "0" : $("#" + containerId + "_" + id + "_" + index).val());
          var v1Rate = parseFloat($("#" + containerId + "_txtVendor1Rate_" + index).val() == "" ? "0" : $("#" + containerId + "_txtVendor1Rate_" + index).val());
          var v1Value = quantity * v1Rate;
          $("#" + containerId + "_txtVendor1Value_" + index).val(v1Value);

          var v2Rate = parseFloat($("#" + containerId + "_txtVendor2Rate_" + index).val() == "" ? "0" : $("#" + containerId + "_txtVendor2Rate_" + index).val());
          var v2Value = quantity * v2Rate;
          $("#" + containerId + "_txtVendor2Value_" + index).val(v2Value);


          var v3Rate = parseFloat($("#" + containerId + "_txtVendor3Rate_" + index).val() == "" ? "0" : $("#" + containerId + "_txtVendor3Rate_" + index).val());
          var v3Value = quantity * v3Rate;
          $("#" + containerId + "_txtVendor3Value_" + index).val(v3Value);
          SumAll();
      }

      function Party1Cal(id, index) {
          var containerId = "ContentPlaceHolder1_gvItemHead";
          var quantity = parseFloat($("#" + containerId + "_txtQuantity_" + index).val() == "" ? "0" : $("#" + containerId + "_txtQuantity_" + index).val());
          var v1Rate = parseFloat($("#" + containerId + "_" + id + "_" + index).val() == "" ? "0" : $("#" + containerId + "_" + id + "_" + index).val());
          var v1Value = quantity * v1Rate;
          $("#" + containerId + "_txtVendor1Value_" + index).val(v1Value);
          SumAll();
      }
      function Party2Cal(id, index) {
          var containerId = "ContentPlaceHolder1_gvItemHead";
          var quantity = parseFloat($("#" + containerId + "_txtQuantity_" + index).val() == "" ? "0" : $("#" + containerId + "_txtQuantity_" + index).val());
          var v2Rate = parseFloat($("#" + containerId + "_" + id + "_" + index).val() == "" ? "0" : $("#" + containerId + "_" + id + "_" + index).val());
          var v2Value = quantity * v2Rate;
          $("#" + containerId + "_txtVendor2Value_" + index).val(v2Value);
          SumAll();
      }
      function Party3Cal(id, index) {
          var containerId = "ContentPlaceHolder1_gvItemHead";
          var quantity = parseFloat($("#" + containerId + "_txtQuantity_" + index).val() == "" ? "0" : $("#" + containerId + "_txtQuantity_" + index).val());
          var v3Rate = parseFloat($("#" + containerId + "_" + id + "_" + index).val() == "" ? "0" : $("#" + containerId + "_" + id + "_" + index).val());
          var v3Value = quantity * v3Rate;
          $("#" + containerId + "_txtVendor3Value_" + index).val(v3Value);
          SumAll();
      }
      function SumAll() {
          var total_qty = 0;
          $(".quantity").each(function () {
              total_qty = total_qty + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTotalQuantity").text(total_qty);
          var v1rate = 0;
          $(".v1rate").each(function () {
              v1rate = v1rate + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTotalV1Rate").text(v1rate);
          var v1value = 0;
          $(".v1value").each(function () {
              v1value = v1value + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTotalV1Value").text(v1value);
          var v1OtherCharge = parseFloat($("#txtV1OtherCharges").val() == "" ? "0" : $("#txtV1OtherCharges").val());
          var v1GST = parseFloat($("#txtV1GST").val() == "" ? "0" : $("#txtV1GST").val());
          var V1GrandTotal = v1value + v1OtherCharge + v1GST;
          $("#txtV1GrandTotal").val(V1GrandTotal);

          var v2rate = 0;
          $(".v2rate").each(function () {
              v2rate = v2rate + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTotalV2Rate").text(v2rate);
          var v2value = 0;
          $(".v2value").each(function () {
              v2value = v2value + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTotalV2Value").text(v2value);
          var v2OtherCharge = parseFloat($("#txtV2OtherCharges").val() == "" ? "0" : $("#txtV2OtherCharges").val());
          var v2GST = parseFloat($("#txtV2GST").val() == "" ? "0" : $("#txtV2GST").val());
          var V2GrandTotal = v2value + v2OtherCharge + v2GST;
          $("#txtV2GrandTotal").val(V2GrandTotal);




          var v3rate = 0;
          $(".v3rate").each(function () {
              v3rate = v3rate + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTotalV3Rate").text(v3rate);
          var v3value = 0;
          $(".v3value").each(function () {
              v3value = v3value + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTotalV3Value").text(v3value);

          var v3OtherCharge = parseFloat($("#txtV3OtherCharges").val() == "" ? "0" : $("#txtV3OtherCharges").val());
          var v3GST = parseFloat($("#txtV3GST").val() == "" ? "0" : $("#txtV3GST").val());
          var V3GrandTotal = v3value + v3OtherCharge + v3GST;
          $("#txtV3GrandTotal").val(V3GrandTotal);


          var baserate = 0;
          $(".baserate").each(function () {
              baserate = baserate + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblBaserate").text(baserate);

          var targetcost = 0;
          $(".targetcost").each(function () {
              targetcost = targetcost + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblTargetCost").text(targetcost);

          var estimatedcost = 0;
          $(".estimatedcost").each(function () {
              estimatedcost = estimatedcost + parseFloat($(this).val() == "" ? "0" : $(this).val());
          });
          $("#lblEstimatedCost").text(estimatedcost);
      }

      function SetDataTop3Bid() {
          var tableRef = document.getElementById("ContentPlaceHolder1_gvItemHead");
          var lastRow = tableRef.rows.length;
          var AllData = [];

          var AllData = [];
          for (var i = 0; i < lastRow - 1; i++) {
              var data = {};
              data.ID = (i + 1).toString();
              data.Description = $("#" + tableRef.id + "_txtdesc_" + i).val();
              data.UOM = $("#" + tableRef.id + "_ddlUOM_" + i + " option:selected").val();
              data.Quantity = $("#" + tableRef.id + "_txtQuantity_" + i).val();
              data.V1Rate = $("#" + tableRef.id + "_txtVendor1Rate_" + i).val();
              data.V1Value = $("#" + tableRef.id + "_txtVendor1Value_" + i).val();
              data.V2Rate = $("#" + tableRef.id + "_txtVendor2Rate_" + i).val();
              data.V2Value = $("#" + tableRef.id + "_txtVendor2Value_" + i).val();
              data.V3Rate = $("#" + tableRef.id + "_txtVendor3Rate_" + i).val();
              data.V3Value = $("#" + tableRef.id + "_txtVendor3Value_" + i).val();
              data.BaseRate = $("#" + tableRef.id + "_txtBaseRate_" + i).val();
              data.TargetCost = $("#" + tableRef.id + "_txtTargetCost_" + i).val();
              data.EstimatedCost = $("#" + tableRef.id + "_txtEstimatedCost_" + i).val();
              AllData.push(data);

          }

          $("#hdnTop3Bid").val(JSON.stringify(AllData));


      }

      function AddRowInDeviation(containerId) {

          var tableRef = document.getElementById(containerId);
          var lastRow = tableRef.rows.length;
          var newRow = tableRef.insertRow(lastRow);

          var newCell = newRow.insertCell(0);
          var controlRef = document.createElement('a');
          controlRef.type = 'button';
          controlRef.id = containerId + '_link' + (lastRow - 1);
          controlRef.name = controlRef.id;
          controlRef.value = "Add"
          controlRef.className = "addPaymentPlanRow";
          controlRef.innerHTML = "<img src='Icons/addicon.png' />";
          newCell.appendChild(controlRef);
          $("#" + controlRef.id).attr("onclick", "AddRowInDeviation('ContentPlaceHolder1_gvDeviationfromtender')")



          var newCell2 = newRow.insertCell(1);
          var controlRef2 = document.createElement('input');
          controlRef2.type = 'text';
          controlRef2.id = containerId + '_ckDFTStandrad_' + (lastRow - 1);
          controlRef2.name = controlRef2.id;
          // controlRef2.size = 20;
          controlRef2.className = "ckeditor";
          newCell2.appendChild(controlRef2);
          CKEDITOR.replace(controlRef2.name);


          var newCell3 = newRow.insertCell(2);
          var controlRef3 = document.createElement('input');
          controlRef3.type = 'text';
          controlRef3.id = containerId + '_ckDFTPreference1_' + (lastRow - 1);
          controlRef3.name = controlRef3.id;
          controlRef3.className = "form-control";
          newCell3.appendChild(controlRef3);
          CKEDITOR.replace(controlRef3.id);

          var newCell4 = newRow.insertCell(3);
          var controlRef4 = document.createElement('input');
          controlRef4.type = 'text';
          controlRef4.id = containerId + '_ckDFTPreference2_' + (lastRow - 1);
          controlRef4.name = controlRef4.id;
          controlRef4.className = "form-control";
          newCell4.appendChild(controlRef4);
          CKEDITOR.replace(controlRef4.id);

          var newCell1 = newRow.insertCell(4);
          var controlRef1 = document.createElement('input');
          controlRef1.type = 'test';
          controlRef1.id = containerId + '_ckDFTPrevailingMarket_' + (lastRow - 1);
          controlRef1.name = controlRef1.id;
          controlRef1.innerText = lastRow;
          newCell1.appendChild(controlRef1);
          CKEDITOR.replace(controlRef1.id);

          var newCell5 = newRow.insertCell(5);
          var controlRef5 = document.createElement('a');
          controlRef5.type = 'button';
          controlRef5.id = containerId + '_delete_' + (lastRow - 1);
          controlRef5.name = controlRef5.id;
          controlRef5.className = "btn btn-primary fa fa-trash";
          newCell5.appendChild(controlRef5);
          $("#" + controlRef5.id).attr("onclick", "delRow('ContentPlaceHolder1_gvDeviationfromtender',this)")

          var id = 'ContentPlaceHolder1_gvDeviationfromtender';
          $(`#${id} tbody tr`).each(function () {
              $(this).find('td:First a').hide();
          });

          $(`#${id} tbody tr:last`).find('td:First a').show();
          return false;
      }
      function SetDataDeviation() {
          var tableRef = document.getElementById("ContentPlaceHolder1_gvDeviationfromtender");
          var lastRow = tableRef.rows.length;
          var AllData = [];
          for (var i = 0; i < lastRow - 1; i++) {
              var data = {};
              data.ID = (i + 1).toString();
              data.StandardTerms = CKEDITOR.instances[tableRef.id + "_ckDFTStandrad_" + i].document.getBody().getText().replace("\n", "");
              data.Preference1 = CKEDITOR.instances[tableRef.id + "_ckDFTPreference1_" + i].document.getBody().getText().replace("\n", "");
              data.Preference2 = CKEDITOR.instances[tableRef.id + "_ckDFTPreference2_" + i].document.getBody().getText().replace("\n", "");
              data.PrevailingMarkrtPractise = CKEDITOR.instances[tableRef.id + "_ckDFTPrevailingMarket_" + i].document.getBody().getText().replace("\n", "");
              AllData.push(data);
          }
          $("#hdnSetDataDeviation").val(JSON.stringify(AllData));
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

      function AddRowInTermsAndConditions(containerId) {

          var tableRef = document.getElementById(containerId);
          var lastRow = tableRef.rows.length;
          var newRow = tableRef.insertRow(lastRow);

          var newCell = newRow.insertCell(0);
          var controlRef = document.createElement('a');
          controlRef.type = 'button';
          controlRef.id = containerId + '_link' + (lastRow - 1);
          controlRef.name = controlRef.id;
          controlRef.value = "Add"
          controlRef.className = "addPaymentPlanRow";
          controlRef.innerHTML = "<img src='Icons/addicon.png' />";
          newCell.appendChild(controlRef);
          $("#" + controlRef.id).attr("onclick", "AddRowInTermsAndConditions('ContentPlaceHolder1_gvTermsandCondition')")

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
          controlRef2.id = containerId + '_ckTCTerms_' + (lastRow - 1);
          controlRef2.name = controlRef2.id;
          // controlRef2.size = 20;
          controlRef2.className = "ckeditor";
          newCell2.appendChild(controlRef2);
          CKEDITOR.replace(controlRef2.name);


          var newCell3 = newRow.insertCell(3);
          var controlRef3 = document.createElement('input');
          controlRef3.type = 'text';
          controlRef3.id = containerId + '_ckTCStandrad_' + (lastRow - 1);
          controlRef3.name = controlRef3.id;
          controlRef3.className = "form-control";
          newCell3.appendChild(controlRef3);
          CKEDITOR.replace(controlRef3.id);

          var newCell4 = newRow.insertCell(4);
          var controlRef4 = document.createElement('input');
          controlRef4.type = 'text';
          controlRef4.id = containerId + '_ckTCPreference1_' + (lastRow - 1);
          controlRef4.name = controlRef4.id;
          controlRef4.className = "form-control";
          newCell4.appendChild(controlRef4);
          CKEDITOR.replace(controlRef4.id);

          var newCell5 = newRow.insertCell(5);
          var controlRef5 = document.createElement('input');
          controlRef5.type = 'text';
          controlRef5.id = containerId + '_ckTCPreference2_' + (lastRow - 1);
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
          $("#" + controlRef6.id).attr("onclick", "delRow('ContentPlaceHolder1_gvTermsandCondition',this)")

          var id = 'ContentPlaceHolder1_gvTermsandCondition';
          $(`#${id} tbody tr`).each(function () {
              $(this).find('td:First a').hide();
          });

          $(`#${id} tbody tr:last`).find('td:First a').show();
          return false;
      }

      function SetDataTermsAndConditions() {
          var tableRef = document.getElementById("ContentPlaceHolder1_gvTermsandCondition");
          var lastRow = tableRef.rows.length;
          var AllData = [];
          for (var i = 0; i < lastRow - 1; i++) {
              var data = {};
              data.ID = (i + 1).toString();
              data.Terms = CKEDITOR.instances[tableRef.id + "_ckTCTerms_" + i].document.getBody().getText().replace("\n", "");
              data.StandardTerms = CKEDITOR.instances[tableRef.id + "_ckTCStandrad_" + i].document.getBody().getText().replace("\n", "");
              data.Preference1 = CKEDITOR.instances[tableRef.id + "_ckTCPreference1_" + i].document.getBody().getText().replace("\n", "");
              data.Preference2 = CKEDITOR.instances[tableRef.id + "_ckTCPreference2_" + i].document.getBody().getText().replace("\n", "");
              AllData.push(data);
          }

          $("#hdnSetDataTermsAndConditions").val(JSON.stringify(AllData));
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

      var fileName = "";
      var imageName = "";

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
                  url: "WebService.asmx/UploadMSLNImage?FileName=" + imageName + "",
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
                  url: "WebService.asmx/UploadMSLNFile?FileName=" + fileName + "",
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
              //jsonArray.Category = "";
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
          SetDataTermsAndConditions();
          SetApprover();
          SetDataDeviation();
          SetDataTop3Bid();
          SetDataMajordeviation();
      }
      var prm = Sys.WebForms.PageRequestManager.getInstance();
      prm.add_endRequest(function () {
          //Calander();
      });

      prm.add_beginRequest(function () {

      });
  </script> 
</asp:Content>
