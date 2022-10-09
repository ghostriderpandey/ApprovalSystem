<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ContractLogicNoteAmendment.aspx.cs" Inherits="AdminPanel_ContractLogicNoteAmendment" %>
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
            var dblrevisedvalue = $('#<%=txtRevisedvalueasperthisamend.ClientID %>').val();
            var dblBalancetobeaward = $('#<%=txtBalancetobeaward.ClientID %>').val();
            var dblAlreadyAwarded = $('#<%=txtAlreadyaward.ClientID %>').val();
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
               var dblPrevious = $('#<%=txtRevisedcostasperPreviousamendment.ClientID %>').val();
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
            $('#<%=txtothers.ClientID %>').keypress(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 100) {
                    alert('You cannot enter more than 100 chars');
                    return false;
                }
            });
            $('#<%=txtothers.ClientID %>').keyup(function () {
                var maxLength = $(this).val().length;
                if (maxLength >= 100) {
                    $(this).val('');
                    alert('You cannot enter more than 100 chars');
                    return false;
                }
            });

             $("#<%=ddlReasonofvariation.ClientID %>").change(function () {
                 if ($(this).val() == "Other") {
                   //  $('#<%=txtothers.ClientID %>').val("");
                    $('#<%=txtothers.ClientID%>').prop("readonly", false);
                    ValidatorEnable($("#<%=rvreasonforothers.ClientID %>")[0], true);
                }
                else {
                    $('#<%=txtothers.ClientID %>').val("");
                    $('#<%=txtothers.ClientID%>').prop("readonly", true);
                    ValidatorEnable($("#<%=rvreasonforothers.ClientID %>")[0], false);
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
                    url: "ContractLogicNoteAmendment.aspx/getPorjectAddress",
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
                        url: "ContractLogicNoteAmendment.aspx/getPorjectLocation",
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
                    <div class="ajax-loader-outer">
                    </div>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
           
               
                    <div class="x_panel tile fixed_height_320">
                        <div class="x_title">
                            <h2 class="text-center blue">Contract Amendment Logic Note Details</h2>
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
                                        <label for="exampleInputEmail1" class="font-weight-bold">Original Contract Order No.<span class="spnRequired">*</span></label>
                                        <%--<asp:DropDownList ID="ddloriginalContractordernumber" runat="server" class="form-control"></asp:DropDownList>--%>
                                        <asp:TextBox ID="txtoriginalContractordernumber" AutoPostBack="true" OnTextChanged="txtoriginalContractordernumber_TextChanged" runat="server" class="form-control"></asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" DelimiterCharacters="" Enabled="True" ServiceMethod="GetApprovalNo" MinimumPrefixLength="1" EnableCaching="true"
                                    ServicePath="ContractLogicNoteAmendment.aspx" TargetControlID="txtoriginalContractordernumber">
                                </cc1:AutoCompleteExtender>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ForeColor="Red" runat="server" ErrorMessage="Please Enter Original Contract Order no"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtoriginalContractordernumber"></asp:RequiredFieldValidator>
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
                                        <label for="exampleInputEmail1" class="font-weight-bold">Subject & Scope <span class="spnRequired">Max 200 Character *</span></label>
                                        <asp:TextBox ID="txtSubjectScope" TextMode="MultiLine" Rows="1" PlaceHolder="Subject & Scope" runat="server" class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" runat="server" ErrorMessage="Please Enter Subject Scope" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSubjectScope"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Project Name <span class="spnRequired">*</span></label>
                                        <asp:DropDownList ID="ddlprojectname" runat="server" class="form-control selectcss"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please Enter Project Name"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlprojectname"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Address <span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtProjectaddress" runat="server" TextMode="MultiLine" Rows="1" placeholder="Project Address" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                 <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Location Name<span class="spnRequired">*</span></label>
                                        <asp:DropDownList ID="ddllocation" runat="server" class="form-control selectcss"></asp:DropDownList>
                                        <asp:HiddenField ID="hddlocationId" runat="server" Value="0" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ForeColor="Red" runat="server" ErrorMessage="Please Select Location Name"
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
                                        <label for="exampleInputEmail1" class="font-weight-bold">Saleable Area <span class="small">(Sq.Ft.)</span><span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtSaleableArea" runat="server" AutoPostBack="true" OnTextChanged="txtSaleableArea_TextChanged"
                                            ToolTip="Enter decimal value only" onkeypress="return isNumberKey(event);" Text="0" PlaceHolder="Saleable Area" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ForeColor="Red" runat="server" ErrorMessage="Please Enter Saleable Area"
                                            ValidationGroup="V" Display="Dynamic" ControlToValidate="txtSaleableArea"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                               <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Approved Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtApprovalBudget" onblur="fillVariationofBudget()" runat="server" ToolTip="Enter decimal value only" PlaceHolder="Approved Budget" CssClass="form-control" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" runat="server" ErrorMessage="Please Enter Approved Budget" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtApprovalBudget"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Already Award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtAlreadyaward" onblur="fillVariationofBudget()" runat="server" ToolTip="Enter decimal value only" PlaceHolder="Already Award" CssClass="form-control" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" runat="server" ErrorMessage="Please Enter Already award" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtAlreadyaward"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Balance to be award <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtBalancetobeaward" onblur="fillVariationofBudget()" runat="server" ToolTip="Enter decimal value only" PlaceHolder="Balance Value" CssClass="form-control" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="Red" runat="server" ErrorMessage="Please Enter Balance Value" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtBalancetobeaward"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Increment/Decrement Value as per this amend <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtRevisedvalueasperthisamend" onblur="fillVariationofBudget()" ToolTip="Enter decimal value only" runat="server" PlaceHolder="Revised value as per this amend" CssClass="form-control" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ErrorMessage="Please Enter Revised value as per this amende" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRevisedvalueasperthisamend"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Variation from Budget <span class="small">(in Lacs)</span><span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtvariationfrombudget"  runat="server" ToolTip="Enter decimal value only" PlaceHolder="Variation from Budget" CssClass="form-control" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ForeColor="Red" runat="server" ErrorMessage="Please Enter Variation Budget" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtvariationfrombudget"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Reason of variation</label>
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
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="Red" runat="server" ErrorMessage="Please Select Reason of variation" ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlReasonofvariation" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                 <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Reason For Others<span class="spnRequired">Max 100 Character *</span></label>
                                        <asp:TextBox ID="txtothers" EnableViewState="false" runat="server" PlaceHolder="Reason For Others" TextMode="MultiLine" Rows="1" CssClass="form-control"  ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rvreasonforothers" ForeColor="Red" runat="server" ErrorMessage="Please Enter Reason For Others" ValidationGroup="V" Display="Dynamic" InitialValue="0" ControlToValidate="txtothers"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
             
                    <div class="x_panel tile fixed_height_320">
                        <div class="x_title text-center">
                            <h2 class="blue center">Major deviation & recommendation in terms-conditions (if any)/Exception</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li>
                                    <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
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
                                    <asp:TemplateField HeaderText="As per Contract Agreement">
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
                                           <%-- <asp:DropDownList ID="ddlRecommendation" runat="server" class="form-control">
                                                <asp:ListItem Value="0">Select One</asp:ListItem>
                                                <asp:ListItem Value="May be accepted">May be accepted</asp:ListItem>
                                                <asp:ListItem Value="may be rejected">may be rejected</asp:ListItem>
                                                <asp:ListItem Value="send back for amendent">send back for amendent</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlRecommendation" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                            <asp:TextBox ID="txtrecommendation" runat="server" CssClass="form-control" Placeholder="Recommendation"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="rfvtxtrecommendation" ControlToValidate="txtrecommendation"  ValidationGroup="V" runat="server" ErrorMessage="Please Enter Recommendation" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <h2 class="blue">Amendment Details</h2>
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
                                        <label for="exampleInputEmail1" class="font-weight-bold">Mention Name of Contractor with PO no.<span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtmenstionnameofContractor" runat="server" placeholder="Mention Name of Contractor with PO no." class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" runat="server" ErrorMessage="Please Enter Name of Contractor with PO no." ValidationGroup="V" Display="Dynamic" ControlToValidate="txtmenstionnameofContractor"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Cost as per original Award<span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtcostasperoriginalaward" runat="server" onblur="fillOrivsThis()" placeholder="Cost as per original Award" class="form-control" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="Red" runat="server" ErrorMessage="Please Enter Cost as per original Award" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtcostasperoriginalaward"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Rev. Cost as per Previous Amendment<span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtRevisedcostasperPreviousamendment" onblur="fillPrevsThis()" runat="server" PlaceHolder="Rev. Cost as per Previous Amendment" onkeypress="return isDecimalKey(this, event);" Text="0" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rev. Cost as per Previous Amendment" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtRevisedcostasperPreviousamendment"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Rev. Cost as per this Amendment<span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtrevisedcostasperthisamendment" onblur="fillrevisedcostasperthisamendment()" runat="server" PlaceHolder="Rev. Cost as per this Amendment" CssClass="form-control" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="Red" runat="server" ErrorMessage="Please Enter Rev. Cost as per this Amendment" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtrevisedcostasperthisamendment"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Variation Previous vs this amendment<span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtvariationprevsamendment" onblur="fillrevisedcostasperthisamendment()"  runat="server" CssClass="form-control" Placeholder="Variation Previous vs this amendment" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Variation Original vs this amendment<span class="spnRequired">*</span></label>
                                        <asp:TextBox ID="txtvariationorignalvsthisamendment"  runat="server" CssClass="form-control" Placeholder="Variation Original vs this amendment" onkeypress="return isDecimalKey(this, event);" Text="0"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
       
                    <div class="x_panel tile fixed_height_320">
                        <div class="x_title">
                            <h2 class="blue">Cost Variation Details</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li>
                                    <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content table-responsive">
                            <asp:GridView ID="gvItemHead" runat="server" AutoGenerateColumns="False"
                                class="table table-bordered table-hover" ShowFooter="true" OnRowCommand="gvItemHead_RowCommand" OnRowDeleting="gvItemHead_RowDeleting" OnPreRender="gvItemHead_PreRender" OnRowDataBound="gvItemHead_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Add">
                                        <ItemTemplate>
                                            <%--<%#Container.DataItemIndex+1%>--%>
                                            <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                                            <asp:HiddenField ID="hddIHID" runat="server" Value='<%#Eval("ID") %>' />
                                            <asp:HiddenField ID="hddItemHead" runat="server" Value='<%#Eval("ItemHead") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SNo">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Item Head">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlItemHead" runat="server" class="form-control selectcss">
                                                <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                                <asp:ListItem Value="A1. Correction in Quantity (Increasing)">A1. Correction in Quantity (Increasing)</asp:ListItem>
                                                <asp:ListItem Value="A2. Correction in Quantity (Decreasing)">A2. Correction in Quantity (Decreasing)</asp:ListItem>
                                                <asp:ListItem Value="B1. Design Change (Increasing)">B1. Design Change (Increasing)</asp:ListItem>
                                                <asp:ListItem Value="B2. Design Change (Decreasing)">B2. Design Change (Decreasing)</asp:ListItem>
                                                <asp:ListItem Value="C1. Rate discount">C1. Rate discount</asp:ListItem>
                                                <asp:ListItem Value="D1. Rework">D1. Rework</asp:ListItem>
                                                <asp:ListItem Value="E1. Descope of Work">E1. Descope of Work</asp:ListItem>
                                                <asp:ListItem Value="F1. Substitute/Deviated Items (New Items)">F1. Substitute/Deviated Items (New Items)</asp:ListItem>
                                                <asp:ListItem Value="G1. Additional Scope of Work">G1. Additional Scope of Work</asp:ListItem>
                                                <asp:ListItem Value="H1. Extra Items">H1. Extra Items</asp:ListItem>
                                                <asp:ListItem Value="I1. Miscelleneous">I1. Miscelleneous</asp:ListItem>
                                                <asp:ListItem Value="J1. Other">J1. Other</asp:ListItem>
                                                <asp:ListItem Value="K1. Total unchanged">K1. Total unchanged</asp:ListItem>
                                                <asp:ListItem Value="Z1. Discount">Z1. Discount</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvItemHead" ControlToValidate="ddlItemHead" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Button Text="Calculate" CommandName="Calculate" runat="server" />
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Item Name">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtItemName" Text='<%#Eval("ItemName") %>' runat="server" class="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvtxtitemname" ControlToValidate="txtItemName" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Previous Amend">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPreviousAmend" Width="120px" AutoPostBack="true" OnTextChanged="txtPreviousAmend_TextChanged" Text='<%#Eval("PreviousAmend") %>' runat="server" class="form-control" onkeypress="return isDecimalKey(this, event);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPrice2" ControlToValidate="txtPreviousAmend" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="This Amend">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtThisAmend" Width="120px" AutoPostBack="true" OnTextChanged="txtThisAmend_TextChanged" Text='<%#Eval("ThisAmend") %>' runat="server" class="form-control" onkeypress="return isDecimalKey(this, event);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPrice3" ControlToValidate="txtThisAmend" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Variation">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtVariation" Width="120px" ReadOnly="true" Text='<%#Eval("Variation") %>' runat="server" class="form-control" onkeypress="return isDecimalKey(this, event);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPrice4" ControlToValidate="txtVariation" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reason">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtReason" Text='<%#Eval("Reason") %>' Rows="1" TextMode="MultiLine" runat="server" class="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPrice10" ControlToValidate="txtReason" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ResponsiblePerson">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtResponsiblePerson" Text='<%#Eval("ResponsiblePerson") %>' runat="server" class="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPrice11" ControlToValidate="txtResponsiblePerson" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <div class="row mt-1">
                                <div class="col-sm-3">
                                    <h4>Cost Per Sqft</h4>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtPreviousCostPerSqft"  runat="server" Text="0"  PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ForeColor="Red" runat="server" ErrorMessage="Please Enter Previous Cost per Sqft"
                                        ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPreviousCostPerSqft"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtThisCostPerSqft"  runat="server" Text="0"  PlaceHolder="Cost Per Sqft" CssClass="form-control"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator47" ForeColor="Red" runat="server" ErrorMessage="Please Enter Vendor 2 Award Preference"
                                ValidationGroup="V" Display="Dynamic" ControlToValidate="txtVendor2AwardPreference"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                        </div>
                    </div>
           
                    <div class="x_panel tile fixed_height_320">
                        <div class="x_title">
                            <h2 class="blue">Recommendation</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li>
                                    <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Recommendations with reasons<span class="spnRequired">*</span></label>
          <CKEditor:CKEditorControl Toolbar="Basic" ID="txtreccomandationwithreason" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" runat="server" ErrorMessage="Please enter Recommendations with reasons" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtreccomandationwithreason"></asp:RequiredFieldValidator>
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
                                class="table table-bordered table-hover" OnRowDataBound="gvAttachment_RowDataBound" OnRowCommand="gvAttachment_RowCommand" OnRowDeleting="gvAttachment_RowDeleting" OnPreRender="gvAttachment_PreRender">
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
                                            <asp:TextBox ID="txtDescription" runat="server" class="form-control mt-2" Text='<%#Eval("Description") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="txtDescription" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="File">
                                        <ItemTemplate>
                                            <asp:FileUpload ID="fudFile" EnableViewState="true" runat="server" class="form-control"></asp:FileUpload>
                                              <asp:LinkButton id="lnkDownloadDocFile"   Text='<%#Eval("DocFile") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocFile")  %>' CommandName="Download" runat="server" />
                                        <asp:RegularExpressionValidator ID="revfudFile"  SetFocusOnError="true" ValidationExpression="([a-zA-Z0-9\s_\\~!@$%^*()#&+-\.\-:])+(.pdf|.PDF)$"
                                            ControlToValidate="fudFile" runat="server" ForeColor="Red" ErrorMessage="Please select a valid  PDF file."
                                            Display="Dynamic" />
                                            </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Image">
                                        <ItemTemplate>
                                            <asp:FileUpload ID="fudImage" EnableViewState="true" runat="server" class="form-control "></asp:FileUpload>
                                               <asp:LinkButton id="lnkDownloadDocImage"    Text='<%#Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" runat="server" />
                                       <asp:RegularExpressionValidator ID="revfudImage"  SetFocusOnError="true" ValidationExpression="([a-zA-Z0-9\s_\\~!@$%^*()#&+-\.\-:])+(.jpg|.jpeg|.png|.JPG|.JPEG|.PNG)$"
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
                                            <asp:DropDownList ID="ddlApprover" runat="server" class="form-control selectcss">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="ddlApprover" InitialValue="0" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
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

