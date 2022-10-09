<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="UserMaster.aspx.cs" Inherits="AdminPanel_UserMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script language="javascript" type="text/javascript">
      
        function OnTreeClick(evt) {
            var src = window.event != window.undefined ? window.event.srcElement : evt.target;
            var isChkBoxClick = (src.tagName.toLowerCase() == "input" && src.type == "checkbox");
            if (isChkBoxClick) {
                var parentTable = GetParentByTagName("table", src);
                var nxtSibling = parentTable.nextSibling;
                if (nxtSibling && nxtSibling.nodeType == 1)//check if nxt sibling is not null & is an element node
                {
                    if (nxtSibling.tagName.toLowerCase() == "div") //if node has children
                    {
                        //check or uncheck children at all levels
                        CheckUncheckChildren(parentTable.nextSibling, src.checked);
                    }
                }
                //check or uncheck parents at all levels
                CheckUncheckParents(src, src.checked);
            }
        }

        function CheckUncheckChildren(childContainer, check) {
            var childChkBoxes = childContainer.getElementsByTagName("input");
            var childChkBoxCount = childChkBoxes.length;
            for (var i = 0; i < childChkBoxCount; i++) {
                childChkBoxes[i].checked = check;
            }
        }

        function CheckUncheckParents(srcChild, check) {
            var parentDiv = GetParentByTagName("div", srcChild);
            var parentNodeTable = parentDiv.previousSibling;

            if (parentNodeTable) {
                var checkUncheckSwitch;

                if (check) //checkbox checked
                {
                    var isAllSiblingsChecked = AreAllSiblingsChecked(srcChild);
                    if (isAllSiblingsChecked)
                        checkUncheckSwitch = true;
                    else
                        return; //do not need to check parent if any(one or more) child not checked
                }
                else //checkbox unchecked
                {
                    checkUncheckSwitch = false;
                }

                var inpElemsInParentTable = parentNodeTable.getElementsByTagName("input");
                if (inpElemsInParentTable.length > 0) {
                    var parentNodeChkBox = inpElemsInParentTable[0];
                    //parentNodeChkBox.checked = checkUncheckSwitch;
                    //do the same recursively
                    CheckUncheckParents(parentNodeChkBox, checkUncheckSwitch);
                }
            }
        }

        function AreAllSiblingsChecked(chkBox) {
            var parentDiv = GetParentByTagName("div", chkBox);
            var childCount = parentDiv.childNodes.length;
            for (var i = 0; i < childCount; i++) {
                if (parentDiv.childNodes[i].nodeType == 1) //check if the child node is an element node
                {
                    if (parentDiv.childNodes[i].tagName.toLowerCase() == "table") {
                        var prevChkBox = parentDiv.childNodes[i].getElementsByTagName("input")[0];
                        //if any of sibling nodes are not checked, return false
                        if (!prevChkBox.checked) {
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        //utility function to get the container of an element by tagname
        function GetParentByTagName(parentTagName, childElementObj) {
            var parent = childElementObj.parentNode;
            while (parent.tagName.toLowerCase() != parentTagName.toLowerCase()) {
                parent = parent.parentNode;
            }
            return parent;
        }
    </script>
    <script type="text/javascript">
        function SureDelete() {
            return confirm("Are you sure to Delete ?");
        };
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 46 || charCode > 57))
                return false;
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <%--    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
        <ContentTemplate>--%>
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">User Type</label>
                                <asp:DropDownList ID="ddlRole" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlRole_SelectedIndexChanged"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" runat="server" ErrorMessage="Please Select Role" ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlRole"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Department</label>
                                <asp:DropDownList ID="ddldepartment" runat="server" CssClass="form-control selectpicker" data-live-search="true" AutoPostBack="true"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Select Department" ValidationGroup="V" Display="Dynamic" ControlToValidate="ddldepartment" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Designation</label>
                                <asp:DropDownList ID="ddldesignation" runat="server" CssClass="form-control selectpicker" data-live-search="true" AutoPostBack="true"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ForeColor="Red" runat="server" ErrorMessage="Please Select Designation" ValidationGroup="V" Display="Dynamic" ControlToValidate="ddldesignation" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">User Name</label>
                                <asp:TextBox ID="txtUserName" runat="server" placeholder="Enter User name" class="form-control" AutoCompleteType="None"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please Enter User Name" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtUserName"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Address</label>
                                <asp:TextBox ID="txtaddress" runat="server" placeholder="enter address" class="form-control"></asp:TextBox>
                            </div>
                        </div>


                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Image</label>
                                <asp:FileUpload ID="fuimage" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Financial Limit</label>
                                <asp:TextBox ID="txtfinanciallimit" runat="server" onkeypress="return isNumber(event)" CssClass="form-control" MaxLength="10" placeholder="enter financial limit"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Concept Approver</label>
                                <br />
                                <asp:RadioButton ID="rdyes" runat="server" Text="Yes" GroupName="a" CssClass="font-weight-bold" />
                                &nbsp; &nbsp; &nbsp;
                                        <asp:RadioButton ID="rdno" Text="No" runat="server" GroupName="a" CssClass="font-weight-bold" />
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">UserID</label>
                                <asp:TextBox ID="txtUserID" runat="server" placeholder="Enter UserID" class="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" runat="server" ErrorMessage="Please Enter UserID" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtUserID"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" placeholder="Enter Password" TextMode="Password" AutoCompleteType="None" class="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="Red" runat="server" ErrorMessage="Please Enter Password" ValidationGroup="V" Display="Dynamic" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                            </div>
                        </div>




                    </div>
                    <div class="row">


                        <div class="col-sm-8">
                            <div class="col-sm-12">
                                <asp:GridView ID="grdUserDetails" runat="server" AutoGenerateColumns="False"
                                    class="table table-bordered table-hover" OnRowCommand="grdUserDetails_RowCommand" OnRowDeleting="grdUserDetails_RowDeleting" OnPreRender="grdUserDetails_PreRender">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Add">
                                            <ItemTemplate>
                                                <%--<%#Container.DataItemIndex+1%>--%>
                                                <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                                                <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("ID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Mobile">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtMobile" Text='<%#Eval("MobileNo") %>' MaxLength="10" runat="server" onkeypress="return isNumberKey(event)" class="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvPrice" ControlToValidate="txtMobile" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Email">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtEmail" runat="server" Text='<%#Eval("EmailID") %>' class="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvPrice1" ControlToValidate="txtEmail" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <div class="form-group">
                                <br />
                                <label for="exampleInputEmail1" class="font-weight-bold">&nbsp</label>
                                <asp:Button ID="btnsave" runat="server" Text="Submit" ValidationGroup="V" CssClass="btn btn-success" OnClick="btnsave_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-success" OnClick="btnReset_Click" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="font-weight-bold">Manage User Rights</label>
                                <asp:TreeView runat="server" ID="TreeMenu" OnTreeNodePopulate="TreeMenu_TreeNodePopulate"
                                    ShowCheckBoxes="All" ImageSet="XPFileExplorer" ShowLines="True" AfterClientCheck="CheckChildNodes();" PopulateNodesFromClient="true"
                                    onclick="OnTreeClick(event)">
                                    <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                                    <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" HorizontalPadding="10px"
                                        NodeSpacing="0px" VerticalPadding="2px" />
                                    <ParentNodeStyle Font-Bold="False" />
                                    <SelectedNodeStyle Font-Underline="False" HorizontalPadding="0px" VerticalPadding="0px"
                                        BackColor="#B5B5B5" />
                                </asp:TreeView>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

