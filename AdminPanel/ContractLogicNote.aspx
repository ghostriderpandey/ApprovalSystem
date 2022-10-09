<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ContractLogicNote.aspx.cs" Inherits="AdminPanel_ContractLogicNote" %>
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
          var dblapprovalBudget = $('#<%=txtapprovedbudget.ClientID %>').val();
          var dblProposedvalueofaward = $('#<%=txtproposedvalueofthisqard.ClientID %>').val();
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

      function filldelayinaward() {
          var dtend = $('#<%=txtActualdateofaward.ClientID %>').val();
          var dtstart = $('#<%=txtplanneddate.ClientID %>').val();
          if (dtend != "" && dtstart != "") {
              var days = Math.round((new Date(dtend) - new Date(dtstart)) / (1000 * 60 * 60 * 24));
              $('#<%=txtdelayinaward.ClientID %>').val(days);
          }

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
          $('#<%=txtotherdescription.ClientID %>').keypress(function () {
              var maxLength = $(this).val().length;
              if (maxLength >= 100) {
                  alert('You cannot enter more than 100 chars');
                  return false;
              }
          });
          $('#<%=txtotherdescription.ClientID %>').keyup(function () {
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
                  alert('You cannot enter more than ' + maxLength + ' chars');
                  return false;
              }
          });

          $("#<%=ddlReasonofvariation.ClientID %>").change(function () {
              if ($(this).val() == "Other") {
                    //$('#<%=txtotherdescription.ClientID %>').val("");
                    $('#<%=txtotherdescription.ClientID%>').prop("readonly", false);
                    ValidatorEnable($("#<%=rfvotherdesc.ClientID %>")[0], true);
                }
                else {
                    $('#<%=txtotherdescription.ClientID %>').val("");
                    $('#<%=txtotherdescription.ClientID%>').prop("readonly", true);
                    ValidatorEnable($("#<%=rfvotherdesc.ClientID %>")[0], false);
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
                if ($(this).val() != '' || $(this).val() != 0)
                    $('#<%=hddlocationId.ClientID %>').val($(this).val());
            })
        };
        function ddlProjectName() {
            $("#<%=ddlprojectname.ClientID %>").change(function () {
                $.ajax({
                    type: "POST",
                    url: "ContractLogicNote.aspx/getPorjectAddress",
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
                        url: "ContractLogicNote.aspx/getPorjectLocation",
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
            <h2 class="text-center blue">Contract Logic Note</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="row">
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Approval Authority<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlapprovalauthrity" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Authrity"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlapprovalauthrity" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Subject & Scope <span class="spnRequired">Max 200 Character *</span></label>
                  <asp:TextBox ID="txtSubjectScope" TextMode="MultiLine" Rows="1" PlaceHolder="Subject & Scope"
                      runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" runat="server" ErrorMessage="Please Enter Subject Scope"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSubjectScope"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Project Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlprojectname" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please select Project Name"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlprojectname" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Address </label>
                  <asp:TextBox ID="txtProjectaddress" runat="server" TextMode="MultiLine" Rows="1" placeholder="Project Address" ReadOnly="true" class="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Location Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddllocation" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:HiddenField ID="hddlocationId" runat="server" Value="0" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator32" ForeColor="Red" runat="server" ErrorMessage="Please Select Location Name"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddllocation" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Department Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlDepartment" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Select Department Name"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlDepartment" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Planned Award Date<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtplanneddate" runat="server" PlaceHolder="Planned award date" onblur="filldelayinaward()" CssClass="form-control" type="date"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter planned award date"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtplanneddate"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Actual Date of award<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtActualdateofaward" runat="server" CssClass="form-control" onblur="filldelayinaward()" type="date"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ForeColor="Red" runat="server" ErrorMessage="Please Enter Actual award date"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtActualdateofaward"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Delay in award<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtdelayinaward" runat="server" CssClass="form-control" placeholder="Please enter delay in award" ToolTip="Mention No. of days"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ForeColor="Red" runat="server" ErrorMessage="Please Enter Delay in award"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtdelayinaward"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason of Delay<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlreasonofdelay" runat="server" class="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Due to delay in design finalization">Due to delay in design finalization</asp:ListItem>
                    <asp:ListItem Value="Due to delay in BOQ/Specification finalization">Due to delay in BOQ/Specification finalization</asp:ListItem>
                    <asp:ListItem Value="Due to Change in contracting strategy">Due to Change in contracting strategy</asp:ListItem>
                    <asp:ListItem Value="Due to Change in execution strategy">Due to Change in execution strategy</asp:ListItem>
                    <asp:ListItem Value="Due to delay in receiving bids">Due to delay in receiving bids</asp:ListItem>
                    <asp:ListItem Value="Due to delay in ariba auction">Due to delay in ariba auction</asp:ListItem>
                    <asp:ListItem Value="Due to delay in Vendor selction/evaluation">Due to delay in Vendor selction/evaluation</asp:ListItem>
                    <asp:ListItem Value="Project Hold">Project Hold </asp:ListItem>
                    <asp:ListItem Value="Other">Other</asp:ListItem>
                    <asp:ListItem Value="No Delay">No Delay</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Select Reason of Delay"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlreasonofdelay" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Saleable Area (Sq. Ft.)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtSaleableArea" runat="server" AutoPostBack="true" OnTextChanged="txtSaleableArea_TextChanged"
                                            ToolTip="Enter decimal value only" onkeypress="return isNumberKey(event);" Text="0" PlaceHolder="Saleable Area" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Saleable Area"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSaleableArea"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Approved Budget (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtapprovedbudget" runat="server" ToolTip="Enter decimal value only" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Approved Budget" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approved Budget"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtapprovedbudget"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Already Awarded (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtAlreadyAwarded" runat="server" ToolTip="Enter decimal value only" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Already Awarded" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" runat="server" ErrorMessage="Please Enter Already Awarded"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtAlreadyAwarded"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Proposed Value award (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtproposedvalueofthisqard" ToolTip="Enter decimal value only" runat="server" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" placeholder="Proposed Value of this award" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ErrorMessage="Please Enter Proposed Value award"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtproposedvalueofthisqard"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Balance to be award (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtBalancetobeaward" runat="server" ToolTip="Enter decimal value only" onblur="fillVariationofBudget()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Balance Value" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="Red" runat="server" ErrorMessage="Please Enter Balance Value"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtBalancetobeaward"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold" style="display: block">Variation from Budget (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtvariationfrombudget"  runat="server" ToolTip="Enter decimal value only"  onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Variation from Budget" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ForeColor="Red" runat="server" ErrorMessage="Please Enter Variation Budget"
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
                    <asp:ListItem Value="MEP Design change">MEP Design change</asp:ListItem>
                    <asp:ListItem Value="Interior Design change">Interior Design change</asp:ListItem>
                    <asp:ListItem Value="Design change">Design change</asp:ListItem>
                    <asp:ListItem Value="Change in specifications">Change in specifications</asp:ListItem>
                    <asp:ListItem Value="Change in price">Change in price</asp:ListItem>
                    <asp:ListItem Value="Change in taxes">Change in taxes</asp:ListItem>
                    <asp:ListItem Value="No Change">No Change</asp:ListItem>
                    <asp:ListItem Value="Non-Budgeted">Non-Budgeted</asp:ListItem>
                    <asp:ListItem Value="Additional Work">Additional Work</asp:ListItem>
                    <asp:ListItem Value="Other">Others</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="Red" runat="server" ErrorMessage="Please Select Reason of variation"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlReasonofvariation" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold"> Reason For Others <span class="spnRequired">Max 100 Character *</span></label>
                  <asp:TextBox ID="txtotherdescription" EnableViewState="false" runat="server" CssClass="form-control" Placeholder="Reason for Others" TextMode="MultiLine" Rows="1"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvotherdesc" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reason for Others"
                                            ValidationGroup="V" Display="Dynamic" InitialValue="0"  ControlToValidate="txtotherdescription"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold"> Proposed Vendor <span class="small spnRequired"> <a href="VendorMaster.aspx" target="_blank" title="Click to add new vendor">Add Vendor</a></span><span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlnameofproposedvendor" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Select Name of Proposed Vendor"
                                            ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="ddlnameofproposedvendor"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Negotiation Mode<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlNegotiationMode" runat="server" CssClass="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Ariba">Ariba</asp:ListItem>
                    <asp:ListItem Value="Manual">Manual</asp:ListItem>
                    <asp:ListItem Value="Both - Ariba & Manual">Both - Ariba & Manual</asp:ListItem>
                    <asp:ListItem Value="Final negotiation after ariba">Final negotiation after ariba</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ForeColor="Red" runat="server" ErrorMessage="Please Select Negotiation Mode"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlNegotiationMode" InitialValue="0"></asp:RequiredFieldValidator>
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
                  <asp:TextBox ID="txtProposedtimelineDate" runat="server" Width="80%" CssClass="form-control" type="date"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator21" ForeColor="Red" runat="server" ErrorMessage="Please Enter Proposed timeline Date"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtProposedtimelineDate"></asp:RequiredFieldValidator>
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
                  <%--<asp:DropDownList ID="ddlRecommendation" runat="server" class="form-control">
                                                <asp:ListItem Value="0">Select One</asp:ListItem>
                                                <asp:ListItem Value="May be accepted">May be accepted</asp:ListItem>
                                                <asp:ListItem Value="may be rejected">may be rejected</asp:ListItem>
                                                <asp:ListItem Value="send back for amendent">send back for amendent</asp:ListItem>
                                            </asp:DropDownList>--%>
                  <asp:TextBox ID="txtrecommandation" runat="server" CssClass="form-control "></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvrecommandation" ControlToValidate="txtrecommandation" ValidationGroup="V" runat="server" ErrorMessage="Please Enter Recommandation" ForeColor="Red"></asp:RequiredFieldValidator>
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
                  <asp:TextBox ID="txtTotalVendorConsidred" runat="server" onblur="FillVendorCal()" onkeypress="return isDecimalKey(this, event);" Text="0" placeholder="Total vendor considered" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="Red" runat="server" ErrorMessage="Please Enter Total vendor considered"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalVendorConsidred"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Rejected Vendors<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRejectedVendor" runat="server" onblur="FillVendorCal()" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Rejected Vendors" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rejected Vendors"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRejectedVendor"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">RFQ invited<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRFQInvited"  runat="server"  onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" placeholder="RFQ invited"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter RFQ Invited"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRFQInvited"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Not quoted<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtNotQuoted" runat="server" onblur="FillVendorCal()" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" Placeholder="Not quoted"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Not Quoted"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtNotQuoted"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Final Considered<span class="spnRequired">*</span></label>
                  <br />
                  <asp:TextBox ID="txtFinalConsidered"  runat="server"  onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" PlaceHolder="Final Considered"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator24" ForeColor="Red" runat="server" ErrorMessage="Please Enter Final Considered"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtFinalConsidered"></asp:RequiredFieldValidator>
                </div>
              </div>
         
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Stipulated Completion Time<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtStipulatedCompletionTime" runat="server" type="date" CssClass="form-control" PlaceHolder="Stipulated Completion Time"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator25" ForeColor="Red" runat="server" ErrorMessage="Please Enter Stipulated Completion Time"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtStipulatedCompletionTime"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Bid Type<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlBidType" runat="server" class="form-control selectcss" >
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Single Quote">Single Quote</asp:ListItem>
                    <asp:ListItem Value="Repeat Order">Repeat Order</asp:ListItem>
                    <asp:ListItem Value="Multiple Quote">Multiple Quote</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator26" ForeColor="Red" runat="server" ErrorMessage="Please Select Bid Type"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlBidType" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Contract type<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlcontracttype" runat="server" class="form-control selectcss">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Item Rate">Item Rate</asp:ListItem>
                    <asp:ListItem Value="Lumpsum">Lumpsum</asp:ListItem>
                    <asp:ListItem Value="Design & Built">Design & Built</asp:ListItem>
                    <asp:ListItem Value="Cost Plus">Cost Plus</asp:ListItem>
                    <asp:ListItem Value="Labor Rate">Labor Rate</asp:ListItem>
                    <asp:ListItem Value="per sqft on FAR">per sqft on FAR</asp:ListItem>
                    <asp:ListItem Value="per sqft on BUA">per sqft on BUA</asp:ListItem>
                    <asp:ListItem Value="per sqft on Saleable">per sqft on Saleable</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ForeColor="Red" runat="server" ErrorMessage="Please Select Contract Type"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlcontracttype" InitialValue="0"></asp:RequiredFieldValidator>
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
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator28" ForeColor="Red" runat="server" ErrorMessage="Please Select Auction Type"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlActionType" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Date of Ariba Auction<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtDateofAribaAuction" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator29" ForeColor="Red" runat="server" ErrorMessage="Please Enter Date of Ariba Auction"
                                            ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtDateofAribaAuction"></asp:RequiredFieldValidator>
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
            <h2 class="blue">Bid Evaluation</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content table-responsive">
            <asp:GridView ID="gvItemHead" runat="server" AutoGenerateColumns="False"
                                class="table table-bordered table-hover" OnRowCommand="gvItemHead_RowCommand" ShowFooter="true" OnRowDataBound="gvItemHead_RowDataBound" OnRowDeleting="gvItemHead_RowDeleting" OnPreRender="gvItemHead_PreRender">
              <Columns>
              <asp:TemplateField HeaderText="Add">
                <ItemTemplate>
                  <%--<%#Container.DataItemIndex+1%>--%>
                  <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                  <asp:HiddenField ID="hddIHID" runat="server" Value='<%#Eval("ID") %>' />
                  <%--<asp:HiddenField ID="hddItemHead" runat="server" Value='<%#Eval("ItemHead") %>' />--%>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="SNo">
                <ItemTemplate> <%#Container.DataItemIndex+1%> </ItemTemplate>
                <FooterTemplate>
                  <asp:Button Text="Calculate" CommandName="Calculate" runat="server" />
                </FooterTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Item Head">
                <ItemTemplate>
                  <asp:TextBox ID="txtItemHead" Width="120px" Text='<%#Eval("ItemHead") %>' runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice" ControlToValidate="txtItemHead" ValidationGroup="V" runat="server"
                                                ErrorMessage="Item Head Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Contractor1">
                <ItemTemplate>
                  <asp:TextBox ID="txtContractor1" Width="120px" Text='<%#Eval("Contractor1") %>' runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice3" ControlToValidate="txtContractor1" ValidationGroup="V" runat="server"
                                                ErrorMessage="Contractor 1 Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Contractor2">
                <ItemTemplate>
                  <asp:TextBox ID="txtContractor2" Width="120px" Text='<%#Eval("Contractor2") %>' runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice5" ControlToValidate="txtContractor2" ValidationGroup="V" runat="server"
                                                ErrorMessage="Contractor 2 Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Contractor3">
                <ItemTemplate>
                  <asp:TextBox ID="txtContractor3" Width="120px" Text='<%#Eval("Contractor3") %>' runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice7" ControlToValidate="txtContractor3" ValidationGroup="V" runat="server"
                                                ErrorMessage="Contractor 3 Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Target Cost">
                <ItemTemplate>
                  <asp:TextBox ID="txtTargetCost" Width="120px" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("TargetCost") %>' runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice10" ControlToValidate="txtTargetCost" ValidationGroup="V" runat="server"
                                                ErrorMessage="Target Cost Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="In House Cost">
                <ItemTemplate>
                  <asp:TextBox ID="txtInHouseCost" Width="120px" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("InHouseCost") %>' runat="server" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvPrice9" ControlToValidate="txtInHouseCost" ValidationGroup="V" runat="server"
                                                ErrorMessage="In House Cost Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
            </asp:GridView>
            <asp:Label ID="lblnotquotedmsg" runat="server" CssClass=" text-center red" Text="Note: Contractor Amount is 0 then its means not quoted"></asp:Label>
          </div>
          <div class="x_content table-responsive">
            <div class="row">
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
            <div class="row">
              <div class="col-sm-3">
                <h4>Vendor</h4>
              </div>
              <div class="col-sm-3">
                <asp:DropDownList ID="ddlVendor1" runat="server" CssClass="form-control selectcss"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator35" ForeColor="Red" runat="server" ErrorMessage="Please Select Vendor 1"
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
            <div class="row mt-1">
              <div class="col-sm-3">
                <h4 style="display: contents;">Grand Total</h4>
                <asp:Button ID="btnGrandTotal" Style="float: right;" OnClick="btnGrandTotal_Click" Text="Calculate" CommandName="Calculate" runat="server" />
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV1GrandTotal" ReadOnly="true" runat="server" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator30" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Grand Total"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV1GrandTotal"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV2GrandTotal" ReadOnly="true" runat="server" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtV3GrandTotal" ReadOnly="true" runat="server" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV3HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
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
            <div class="row mt-1">
              <div class="col-sm-3">
                <h4>Comparision with Estimated cost</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor1Comparision" runat="server" PlaceHolder="Comparision with Estimated cost" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator37" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Comparision with Estimated costBudgeted Rate"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor1Comparision"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor2Comparision" runat="server" PlaceHolder="Comparision with Estimated cost" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator38" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Comparision with Budgeted Rate"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2Comparision"></asp:RequiredFieldValidator>--%>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor3Comparision" runat="server" PlaceHolder="Comparision with Estimated cost" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator39" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 3 Comparision with Budgeted Rate"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor3Comparision"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
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
            <div class="row mt-1">
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
            <div class="row mt-1">
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
            <div class="row mt-1">
              <div class="col-sm-3">
                <h4>Cost Per Sqft</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtVendor1CostPerSqft" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator31" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 1 Cost per Sqft"
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
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please Enter Recommendations with reasons" 
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtreccomandationwithreason"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Vendor Information</label>
                  <asp:TextBox ID="txtVendorInformation" runat="server" placeholder="Vendor Information" class="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor Information" 
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTotalVendorConsidred"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Turnover last year (in Lacs)</label>
                  <asp:TextBox ID="txtTournoverlastyear" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Turnover last year" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter Turnover last year" 
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="txtTournoverlastyear"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Total orders with Co. till date</label>
                  <asp:TextBox ID="txtTotalOrderwithcotilldate" runat="server" CssClass="form-control" placeholer="Total orders with Co. till date" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Last order details with Co.</label>
                  <asp:TextBox ID="txtLastOrderdetailswithco" runat="server" CssClass="form-control" placeholer="Last order details with Co."></asp:TextBox>
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
                  <asp:DropDownList ID="ddlApprover" runat="server" class="form-control selectcss"> </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlApprover" InitialValue="0" ValidationGroup="V" runat="server"
                                                ErrorMessage="Approver Required" ForeColor="Red"></asp:RequiredFieldValidator>
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
                  <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="txtDescription" ValidationGroup="V" runat="server"
                                                ErrorMessage="Description Required" ForeColor="Red"></asp:RequiredFieldValidator>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="File">
                <ItemTemplate>
                  <asp:FileUpload ID="fudFile" EnableViewState="true" runat="server" class="form-control"></asp:FileUpload>
                  <asp:LinkButton id="lnkDownloadDocFile"    Text='<%#Eval("DocFile") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocFile")  %>' CommandName="Download" runat="server" />
                  <asp:RegularExpressionValidator ID="revfudFile"  SetFocusOnError="true" ValidationExpression="([a-zA-Z0-9\s_\\~!@$%^*()#&+-\.\-:])+(.pdf|.PDF)$"
                                            ControlToValidate="fudFile" runat="server" ForeColor="Red" ErrorMessage="Please select a valid  PDF file."
                                            Display="Dynamic" />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                  <asp:FileUpload ID="fudImage" EnableViewState="true" runat="server" class="form-control"></asp:FileUpload>
                  <asp:LinkButton id="lnkDownloadDocImage"    Text='<%#Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" runat="server" />
                  <asp:RegularExpressionValidator ID="revfudImage"  SetFocusOnError="true" ValidationExpression="([a-zA-Z0-9\s_\\~!@$%^*()#&+-\.\-:])+(.jpg|.jpeg|.png|.JPG|.JPEG|.PNG)$"
                                            ControlToValidate="fudImage" runat="server" ForeColor="Red" ErrorMessage="Please select a valid  JPG OR JPEG PNG file."
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
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Remark</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            
              <CKEditor:CKEditorControl Toolbar="Basic" ID="ckremark" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator33" ForeColor="Red" runat="server" ErrorMessage="Please Enter Remark"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ckremark"></asp:RequiredFieldValidator>
      
          </div>
        </div>
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Contract Head</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
              <CKEditor:CKEditorControl Toolbar="Basic" ID="ckContractHead" CssClass="form-control" runat="server" Height="150px" Width="100%"></CKEditor:CKEditorControl>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator49" ForeColor="Red" runat="server" ErrorMessage="Please Enter Contract Head"
                                    ValidationGroup="V" Display="Dynamic" ControlToValidate="ckContractHead"></asp:RequiredFieldValidator>
          </div>
        </div>
        <div class="w-100">
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
</asp:Content>
