<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="PurchaseLogicNoteAmendment.aspx.cs" Inherits="AdminPanel_PurchaseLogicNoteAmendment" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
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
            var dblrevisedvalue = $('#<%=txtrevisedvalue.ClientID %>').val();
            var dblBalancetobeaward = $('#<%=txtBalancetobeaward.ClientID %>').val();
            var dblAlreadyAwarded = $('#<%=txtAlreadyAwarded.ClientID %>').val();
            var dblVaritaion = 0;
            dblVaritaion = (dblapprovalBudget - dblAlreadyAwarded - dblrevisedvalue - dblBalancetobeaward);
            $('#<%=txtvariationfrombudget.ClientID %>').val(dblVaritaion.toFixed(2));
            if ($('#<%=txtvariationfrombudget.ClientID %>').val() > 0)
                $('#<%=txtvariationfrombudget.ClientID %>').css("color", "Green");
            else if ($('#<%=txtvariationfrombudget.ClientID %>').val() < 0)
                $('#<%=txtvariationfrombudget.ClientID %>').css("color", "Red");
      }

      function fillOrivsThis() {
          var dblOriginal = $('#<%=txtcostasperoriginalaward.ClientID %>').val();
            var dblThis = $('#<%=txtrevisedcostasperthisamendment.ClientID %>').val();
            var dblOrivsthis = 0;
            dblOrivsthis = dblThis - dblOriginal;
            $('#<%=txtvariationorignalvsthisamendment.ClientID %>').val(Math.round(dblOrivsthis.toFixed(2)));
            if (dblOrivsthis > 0) {
                $('#<%=txtvariationorignalvsthisamendment.ClientID %>').css("color", "Green");
            }
            else if (dblOrivsthis < 0) {
                $('#<%=txtvariationorignalvsthisamendment.ClientID %>').css("color", "Red");
          }
      }

      function fillPrevsThis() {
          var dblPrevious = $('#<%=txtRevisedCostasperpreviousamendment.ClientID %>').val();
            var dblThis = $('#<%=txtrevisedcostasperthisamendment.ClientID %>').val();
            var dblprevsthis = 0;
            dblprevsthis = dblThis - dblPrevious;
            $('#<%=txtvariationprevsamendment.ClientID %>').val(Math.round(dblprevsthis.toFixed(2)));

            if (dblprevsthis > 0) {
                $('#<%=txtvariationprevsamendment.ClientID %>').css("color", "Green");
            }
            else if (dblprevsthis < 0) {
                $('#<%=txtvariationprevsamendment.ClientID %>').css("color", "Red");
          }
      }

      function fillrevisedcostasperthisamendment() {
          fillPrevsThis();
          fillOrivsThis();
      }

      function ddlChange() {
          var url = window.location.href;
          if (url.indexOf('?id=') != -1) {
              deleteAllCookies()
              setCookie("locationId", 0, 30);
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

          $("#<%=ddlRequirement.ClientID %>").change(function () {
                if ($(this).val() == "Urgent") {
                    $('#<%=txtUrgetResionDescription.ClientID %>').val("");
                    $('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", false);
                    ValidatorEnable($("#<%=RequiredFieldValidator2.ClientID %>")[0], true);
                    }
                    else {
                        $('#<%=txtUrgetResionDescription.ClientID %>').val("");
                        $('#<%=txtUrgetResionDescription.ClientID%>').prop("readonly", true);
                        ValidatorEnable($("#<%=RequiredFieldValidator2.ClientID %>")[0], false);
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

            $("#<%=ddllocation.ClientID %>").change(function () {
                if ($(this).val() != '' || $(this).val() != 0)
                    $('#<%=hddlocationId.ClientID %>').val($(this).val());
            })

         

           <%-- $("#<%=ddlprojectname.ClientID %>").change(function () {
                $.ajax({
                    type: "POST",
                    url: "PurchaseLogicNoteAmendment.aspx/getPorjectAddress",
                    data: "{ 'projectId': '" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        $('#<%=txtProjectaddress.ClientID %>').val(result.d);
                }
            });

                 $.ajax({
                     type: "POST",
                     url: "PurchaseLogicNoteAmendment.aspx/getPorjectLocation",
                     data: "{ 'projectId': '" + $(this).val() + "'}",
                     contentType: 'application/json; charset=utf-8',
                     dataType: 'json',
                     error: function (XMLHttpRequest, textStatus, errorThrown) {
                         alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                     },
                     success: function (r) {

                         var ddllocation = $('#<%=ddllocation.ClientID %>');
                      ddllocation.empty().append('<option selected="selected" value="0">Please select</option>');
                      $.each(r.d, function () {
                          ddllocation.append($("<option></option>").val(this['Value']).html(this['Text']));
                      });

                      //$('#<%=txtProjectaddress.ClientID %>').val(result.d);
                  }
              });
            }).change();--%>

        };

        function ddlProjectName() {

            $("#<%=ddlprojectname.ClientID %>").change(function () {
                 $.ajax({
                     type: "POST",
                     url: "PurchaseLogicNoteAmendment.aspx/getPorjectAddress",
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
                        url: "PurchaseLogicNoteAmendment.aspx/getPorjectLocation",
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
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="text-center blue">Purchase Amendment Logic Note Details</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="row">
               <%-- <div class="col-sm-3">
                    <div class="form-group">
                        <label for="exampleInputEmail1" class="font-weight-bold">Approval Type<span class="spnRequired">*</span></label>
                        <asp:DropDownList ID="ddlapprovaltype" AutoPostBack="true" OnSelectedIndexChanged="ddlapprovaltype_SelectedIndexChanged" runat="server" class="form-control selectcss">
                            <asp:ListItem Text="New" Value="New" Enabled="true"></asp:ListItem>
                            <asp:ListItem Text="Amendment" Value="Amendment"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator29" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Type"
                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlapprovaltype" InitialValue="0"></asp:RequiredFieldValidator>
                    </div>
                </div>--%>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Original Purchase Order No.<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtoriginalpurchaseordernumber" AutoPostBack="true" OnTextChanged="txtoriginalpurchaseordernumber_TextChanged" runat="server" class="form-control"></asp:TextBox>
                  <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" DelimiterCharacters="" Enabled="True" ServiceMethod="GetApprovalNo" MinimumPrefixLength="1" EnableCaching="true"
                                    ServicePath="PurchaseLogicNoteAmendment.aspx" TargetControlID="txtoriginalpurchaseordernumber">
                                </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ForeColor="Red" runat="server" ErrorMessage="Please Enter Original Purchase Order no"
                                            ValidationGroup="V" Display="Dynamic"  ControlToValidate="txtoriginalpurchaseordernumber"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Approval Authority<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlapprovalauthrity" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ForeColor="Red" runat="server" ErrorMessage="Please Select Approval Authrity"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlapprovalauthrity" InitialValue="0"></asp:RequiredFieldValidator>
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
                  <asp:DropDownList ID="ddlprojectname" EnableViewState="true" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please Enter Project Name"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlprojectname"></asp:RequiredFieldValidator>
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
                  <asp:DropDownList ID="ddllocation" EnableViewState="true" AppendDataBoundItems="true" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:HiddenField ID="hddlocationId" runat="server" Value="0" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator32" ForeColor="Red" runat="server" ErrorMessage="Please Select Location Name"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddllocation" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Department Name<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlDepartment" runat="server" class="form-control selectcss"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator25" ForeColor="Red" runat="server" ErrorMessage="Please Select Department Name"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlDepartment" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Indent Proponent</label>
                  <asp:TextBox ID="txtIndentProponent" runat="server" PlaceHolder="Indent Proponent" CssClass="form-control"></asp:TextBox>
                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Indent Proponent" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtIndentProponent"></asp:RequiredFieldValidator>--%>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Date of indent</label>
                  <asp:TextBox ID="txtDateofindent" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Material needed by</label>
                  <asp:TextBox ID="txtMaterialneededby" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Stock in Hand<span class="spnRequired">*</span></label>
                <div class="d-flex">
                  <asp:TextBox ID="txtStockinHand" runat="server"  onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control selectcss" Width="45%" PlaceHolder="Stock"></asp:TextBox>
                  <asp:DropDownList ID="ddlStockinhandUOM" runat="server" Width="50%" class="form-control ml-3"> </asp:DropDownList>
               </div> </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Requirement<span class="spnRequired">*</span></label>
                  <asp:DropDownList ID="ddlRequirement" runat="server" class="form-control selectcss" >
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="Normal">Normal</asp:ListItem>
                    <asp:ListItem Value="Urgent">Urgent</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Select Urgent Reason" ValidationGroup="V"
                                            Display="Dynamic" ControlToValidate="ddlRequirement" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Urgent Reason Desc<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtUrgetResionDescription" runat="server" TextMode="MultiLine" Rows="1" placeholder="Urgent Reason Desc" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ErrorMessage="Urgent Reason Desc" ValidationGroup="V"
                                            Display="Dynamic" InitialValue="0" ControlToValidate="txtUrgetResionDescription"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Saleable Area (Sq. Ft.)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtSaleableArea" runat="server" AutoPostBack="true" OnTextChanged="txtSaleableArea_TextChanged" 
                                            ToolTip="Enter decimal value only" onkeypress="return isNumberKey(event);" Text="0" PlaceHolder="Saleable Area" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator24" ForeColor="Red" runat="server" ErrorMessage="Please Enter Saleable Area"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSaleableArea"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Approved Budget (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtApprovalBudget"  ToolTip="Enter decimal value only" onblur="fillVariationofBudget()" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Approved Budget" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approved Budget"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtApprovalBudget"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Already Awarded (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtAlreadyAwarded"  ToolTip="Enter decimal value only" onblur="fillVariationofBudget()" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Already Awarded" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator28" ForeColor="Red" runat="server" ErrorMessage="Please Enter Already Awarded"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtAlreadyAwarded"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Increment/Decrement Value (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtrevisedvalue"  ToolTip="Enter decimal value only" onblur="fillVariationofBudget()" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Revised value for this amendment" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" runat="server" ErrorMessage="Please Enter Revised Value"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtrevisedvalue"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Balance to be award (in Lacs)<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtBalancetobeaward"  ToolTip="Enter decimal value only" onblur="fillVariationofBudget()" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" PlaceHolder="Balance Value" CssClass="form-control"></asp:TextBox>
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
                  <asp:DropDownList ID="ddlReasonofvariation" runat="server" CssClass="form-control selectcss" >
                    <asp:ListItem Value="0">Select One</asp:ListItem>
                    <asp:ListItem Value="Architectural Design Change">Architectural Design Change</asp:ListItem>
                    <asp:ListItem Value="Structural design change">Structural design change</asp:ListItem>
                    <asp:ListItem Value="Change in material specifications">Change in material specifications</asp:ListItem>
                    <asp:ListItem Value="Change in price">Change in price</asp:ListItem>
                    <asp:ListItem Value="Change in taxes">Change in taxes</asp:ListItem>
                    <asp:ListItem Value="Non-Budgeted">Non-Budgeted</asp:ListItem>
                    <asp:ListItem Value="Additional Work">Additional Work</asp:ListItem>
                    <asp:ListItem Value="Others">Others</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="Red" runat="server" ErrorMessage="Please Select Reason of variation"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlReasonofvariation" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Reason For Others<span class="spnRequired">Max 100 Character *</span></label>
                  <asp:TextBox ID="txtother" ClientIDMode="Static" EnableViewState="false" runat="server" PlaceHolder="Reason For Others" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rvreasonforothers" ForeColor="Red" runat="server" ErrorMessage="Please Enter Other Description"
                                            ValidationGroup="V" InitialValue="0" Display="Dynamic" ControlToValidate="txtother"></asp:RequiredFieldValidator>
                </div>
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
              <asp:TemplateField HeaderText="As per Agreement">
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
                  <asp:TextBox ID="txtrecommendation" runat="server" CssClass="form-control" placeholder="Enter Recommendation"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvrecommendation" ControlToValidate="txtrecommendation"  ValidationGroup="V" runat="server" ErrorMessage="Please Enter Recommendation" ForeColor="Red"></asp:RequiredFieldValidator>
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
            <h2 class="blue">Amendment Details</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="row">
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Mention Name of Vendor with PO no.<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtmenstionnameofvendor" runat="server" placeholder="Mention Name of Vendor with PO no." class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" runat="server" ErrorMessage="Please Enter Name of Vendor with PO no."
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtmenstionnameofvendor"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Cost as per original Award<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtcostasperoriginalaward" onblur="fillOrivsThis()" runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" placeholder="Cost as per original Award" class="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="Red" runat="server" ErrorMessage="Please Enter Cost as per original Award"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtcostasperoriginalaward"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Rev. Cost as per Previous Amendment<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtRevisedCostasperpreviousamendment" onblur="fillPrevsThis()" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" PlaceHolder="Rev. Cost as per Previous Amendment" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rev. Cost as per Previous Amendment"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRevisedCostasperpreviousamendment"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Rev. Cost as per this Amendment<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtrevisedcostasperthisamendment" onblur="fillrevisedcostasperthisamendment()" onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" PlaceHolder="Rev. Cost as per this Amendment" CssClass="form-control"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rev. Cost as per this Amendment"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtrevisedcostasperthisamendment"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Variation Previous vs this amendment<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtvariationprevsamendment"  runat="server" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control" Placeholder="Variation Previous vs this amendment"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ForeColor="Red" runat="server" ErrorMessage="Please Enter Variation Previous vs this amendment"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtvariationprevsamendment"></asp:RequiredFieldValidator>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label for="exampleInputEmail1" class="font-weight-bold">Variation Original vs this amendment<span class="spnRequired">*</span></label>
                  <asp:TextBox ID="txtvariationorignalvsthisamendment"  onkeypress="return isDecimalKey(this, event);" Text="0" runat="server" CssClass="form-control" Placeholder="Variation Original vs this amendment"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator23" ForeColor="Red" runat="server" ErrorMessage="Variation Original vs this amendment"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtvariationorignalvsthisamendment"></asp:RequiredFieldValidator>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Cost Variation Details</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content table-responsive">
              <asp:GridView ID="gvItemHead" runat="server" AutoGenerateColumns="False"
                  class="table table-bordered table-hover" OnRowCommand="gvItemHead_RowCommand" ShowFooter="true" OnRowDeleting="gvItemHead_RowDeleting" OnPreRender="gvItemHead_PreRender" OnRowDataBound="gvItemHead_RowDataBound">
                  <Columns>
                      <asp:TemplateField HeaderText="Add">
                          <ItemTemplate>
                              <%--<%#Container.DataItemIndex+1%>--%>
                              <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                              <asp:HiddenField ID="hddIHID" runat="server" Value='<%#Eval("ID") %>' />
                              <asp:HiddenField ID="hddPreviousUOM" runat="server" Value='<%#Eval("PreviousUOM") %>' />
                              <asp:HiddenField ID="hddPreviousItem" runat="server" Value='<%#Eval("PreviousItem") %>' />
                              <asp:HiddenField ID="hddThisItem" runat="server" Value='<%#Eval("ThisItem") %>' />
                              <asp:HiddenField ID="hddThisUOM" runat="server" Value='<%#Eval("ThisUOM") %>' />
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="SNo">
                          <ItemTemplate><%#Container.DataItemIndex+1%> </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Previous Item">
                          <ItemTemplate>
                              <asp:DropDownList ID="ddlPreviousItem" Width="120px" runat="server" class="form-control selectcss"></asp:DropDownList>
                              <asp:RequiredFieldValidator ID="rfvPreviousItem" ControlToValidate="ddlPreviousItem" ValidationGroup="V" runat="server"
                                  ErrorMessage="Previous Item Required" InitialValue="0" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                          <FooterTemplate>
                              <asp:Button Text="Calculate" CommandName="Calculate" runat="server" />
                          </FooterTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Previous UOM">
                          <ItemTemplate>
                              <asp:DropDownList ID="ddlPreviousUOM" Width="120px" runat="server" class="form-control selectcss"></asp:DropDownList>
                              <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlPreviousUOM" InitialValue="0" ValidationGroup="V" runat="server"
                                  ErrorMessage="Previous UOM Required" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Previous Quantity">
                          <ItemTemplate>
                              <asp:TextBox ID="txtPreviousQuantity" Width="120px" AutoPostBack="true" OnTextChanged="txtPreviousQuantity_TextChanged" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("PreviousQuantity") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvPrice2" ControlToValidate="txtPreviousQuantity" ValidationGroup="V" runat="server" ErrorMessage="Previuos Quantity Required"
                                  ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Previous Rate">
                          <ItemTemplate>
                              <asp:TextBox ID="txtPreviousRate" Width="120px" AutoPostBack="true" OnTextChanged="txtPreviousRate_TextChanged" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("PreviousRate") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvPrice3" ControlToValidate="txtPreviousRate" ValidationGroup="V" runat="server" ErrorMessage="Previous Rate Required"
                                  ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Previous Amount">
                          <ItemTemplate>
                              <asp:TextBox ID="txtPreviousAmount" Width="120px" ReadOnly="true" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("PreviousAmount") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvPrice4" ControlToValidate="txtPreviousAmount" ValidationGroup="V" runat="server" ErrorMessage="Previous Amount Required"
                                  ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="This Item">
                          <ItemTemplate>
                              <asp:DropDownList ID="ddlThisItem" Width="120px" runat="server" class="form-control selectcss"></asp:DropDownList>
                              <asp:RequiredFieldValidator ID="rfvThisItem" ControlToValidate="ddlThisItem" ValidationGroup="V" runat="server"
                                  ErrorMessage="This Item Required" InitialValue="0" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="This UOM">
                          <ItemTemplate>
                              <asp:DropDownList ID="ddlThisUOM" Width="120px" runat="server" class="form-control selectcss"></asp:DropDownList>
                              <asp:RequiredFieldValidator ID="rfvThisUOM" ControlToValidate="ddlThisUOM" InitialValue="0" ValidationGroup="V" runat="server"
                                  ErrorMessage="This UOM Required" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="This Quantity">
                          <ItemTemplate>
                              <asp:TextBox ID="txtThisQuantity" Width="120px" AutoPostBack="true" OnTextChanged="txtThisQuantity_TextChanged" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("ThisQuantity") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvThisQuantity" ControlToValidate="txtThisQuantity" ValidationGroup="V" runat="server"
                                  ErrorMessage="This Quantity Required" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="This Rate">
                          <ItemTemplate>
                              <asp:TextBox ID="txtThisRate" Width="120px" AutoPostBack="true" OnTextChanged="txtThisRate_TextChanged" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("ThisRate") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvThisRate" ControlToValidate="txtThisRate" ValidationGroup="V" runat="server" ErrorMessage="This Rate Required"
                                  ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="This Amount">
                          <ItemTemplate>
                              <asp:TextBox ID="txtThisAmount" Width="120px" ReadOnly="true" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("ThisAmount") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvThisAmount" ControlToValidate="txtThisAmount" ValidationGroup="V" runat="server"
                                  ErrorMessage="This Amount Required" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Budgeted Rate">
                          <ItemTemplate>
                              <asp:TextBox ID="txtBudgetRate" Width="120px" onkeypress="return isDecimalKey(this, event);" Text='<%#Eval("BudgetRate") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvPrice9" ControlToValidate="txtBudgetRate" ValidationGroup="V" runat="server"
                                  ErrorMessage="Budget Rate Required" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Reason">
                          <ItemTemplate>
                              <asp:TextBox ID="txtReason" Width="120px" Text='<%#Eval("Reason") %>' TextMode="MultiLine" runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvPrice10" ControlToValidate="txtReason" ValidationGroup="V" runat="server"
                                  ErrorMessage="Reason Required" ForeColor="Red"></asp:RequiredFieldValidator>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="ResponsiblePerson">
                          <ItemTemplate>
                              <asp:TextBox ID="txtResponsiblePerson" Width="120px" Text='<%#Eval("ResponsiblePerson") %>' runat="server" class="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="rfvPrice11" ControlToValidate="txtResponsiblePerson" ValidationGroup="V" runat="server"
                                  ErrorMessage="Responsible Person Required" ForeColor="Red"></asp:RequiredFieldValidator>
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
            <div class="row">
              <div class="col-sm-3"></div>
              <div class="col-sm-3">
                <h4>Previous<span class="spnRequired">*</span></h4>
              </div>
              <div class="col-sm-3">
                <h4>This<span class="spnRequired">*</span></h4>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-3">
                <h4>GST</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtPreviousGST" runat="server" PlaceHolder="Previous GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous GST"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousGST"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtThisGST" runat="server" PlaceHolder="This GST" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="kjhdfsdr993" ForeColor="Red" runat="server" ErrorMessage="Please Enter This This GST"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtThisGST"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-3">
                <h4>Freight</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtPreviousFreight" runat="server" PlaceHolder="Previous Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous Freight"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousFreight"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtThisFreight" runat="server" PlaceHolder="This Freight" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ForeColor="Red" runat="server" ErrorMessage="Please Enter This Freight"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtThisFreight"></asp:RequiredFieldValidator>
              </div>
            </div>
               <div class="row mt-1">
              <div class="col-sm-3">
                <h4>Handling/Insurance Charge</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtPreviousHandlingCharge" runat="server" PlaceHolder="Previous Handling/Insurance Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPreviousHandlingCharge" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous Handling/Insurance Charge"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousHandlingCharge"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtThisHandlingCharge" runat="server" PlaceHolder="This Handling/Insurance Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvThisHandlingCharge" ForeColor="Red" runat="server" ErrorMessage="Please Enter This Handling/Insurance Charge"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtThisHandlingCharge"></asp:RequiredFieldValidator>
              </div>
            </div>
              <div class="row mt-1">
              <div class="col-sm-3">
                <h4>Other Charge</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtPreviousOtherCharge" runat="server" PlaceHolder="Previous Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPreviousOtherCharge" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous Other Charge"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousOtherCharge"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtThisOtherCharge" runat="server" PlaceHolder="This Other Charge" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvThisOtherCharge" ForeColor="Red" runat="server" ErrorMessage="Please Enter This Other Charge"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtThisOtherCharge"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-3">
                <h4>TCS</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtPreviousHeadlingCharges" runat="server" PlaceHolder="Previous Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous Handling Charges"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousHeadlingCharges"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtThisHeadlingCharges" runat="server" PlaceHolder="This Handling Charges" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter This Handling Charges"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtThisHeadlingCharges"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-3">
                <h4 style="display: contents;">Grand Total</h4>
                <asp:Button ID="btnGrandTotal" Style="float: right;" OnClick="btnGrandTotal_Click" Text="Calculate" CommandName="Calculate" runat="server" />
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtPreviousGrandTotal" runat="server" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator26" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous Grand Total"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousGrandTotal"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtThisGrandTotal" runat="server" PlaceHolder="Grand Total" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Handling Charges"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtV2HeadlingCharges"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
            <div class="row mt-1">
              <div class="col-sm-3">
                <h4>Cost Per Sqft</h4>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtPreviousCostPerSqft" EnableViewState="true" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous Cost per Sqft"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousCostPerSqft"></asp:RequiredFieldValidator>
              </div>
              <div class="col-sm-3">
                <asp:TextBox ID="txtThisCostPerSqft"  EnableViewState="true" runat="server" Text="0" ReadOnly="true" PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator47" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2AwardPreference"></asp:RequiredFieldValidator>--%>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="w-100">
        <div class="x_panel tile fixed_height_320">
          <div class="x_title">
            <h2 class="blue">Recommendation</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li> <a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="form-group">
              <label for="exampleInputEmail1" class="font-weight-bold">Recommendations with reasons<span class="spnRequired">*</span></label>
              <CKEditor:CKEditorControl Toolbar="Basic" ID="txtreccomandationwithreason" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
              <%-- <asp:TextBox ID="txtreccomandationwithreason" PlaceHolder="Recommendations with reasons" runat="server" TextMode="MultiLine" Rows="1" class="form-control"></asp:TextBox>--%>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Recommendations with reasons"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtreccomandationwithreason"></asp:RequiredFieldValidator>
            </div>
          </div>
        </div>
      </div>
      <div class="w-100">
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
                  <asp:LinkButton id="lnkDownloadDocFile"    Text='<%#Eval("DocFile") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocFile")  %>' CommandName="Download" runat="server" />
                  <asp:RegularExpressionValidator ID="revfudFile"  SetFocusOnError="true" ValidationExpression="([a-zA-Z0-9\s_\\~!@$%^*()#&+-\.\-:])+(.pdf|.PDF)$"
                                            ControlToValidate="fudFile" runat="server" ForeColor="Red" ErrorMessage="Please select a valid  PDF file."
                                            Display="Dynamic" />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                  <asp:FileUpload ID="fudImage" EnableViewState="true" runat="server" class="form-control"></asp:FileUpload>
                  <asp:LinkButton ID="lnkDownloadDocImage" runat="server" Text='<%# Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" ToolTip="Download Image"></asp:LinkButton>
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
      </div>
      <div class="w-100">
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
