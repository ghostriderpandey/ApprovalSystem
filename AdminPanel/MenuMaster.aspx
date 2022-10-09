<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="MenuMaster.aspx.cs" Inherits="AdminPanel_MenuMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        function fnn() {
            $('#<%= gvrmenu.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvrmenu.ClientID%>").find("tr:first"))).DataTable({
                stateSave: true,
            });
        }
    </script>
    <script type="text/javascript">
       
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function DeleteItem() {
            if (confirm("Are you sure you want to delete ...?")) {
                return true;
            }
            return false;
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
            <div class="row">
                <div class="col-xl-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Menu Name</label>
                                        <asp:TextBox ID="txtmenuname" runat="server" placeholder="enter menu name" class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvMenuName" runat="server" ControlToValidate="txtmenuname"
                                            Display="Dynamic" ErrorMessage="Please enter Menu name" ForeColor="Red" SetFocusOnError="True" ValidationGroup="V"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>MenuLevel</label>
                                        <asp:DropDownList ID="ddllevel" runat="server" class="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddllevel_SelectedIndexChanged">
                                            <asp:ListItem Value="0">-- Select One --</asp:ListItem>
                                            <asp:ListItem Value="1">1</asp:ListItem>
                                            <asp:ListItem Value="2">2</asp:ListItem>
                                            <asp:ListItem Value="3">3</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvMenuLevel" runat="server" ControlToValidate="ddllevel"
                                            Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter MenuLevel" SetFocusOnError="True"
                                            ValidationGroup="V" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>ParentID</label>
                                        <%--<asp:Label ID="lblparent" runat="server" Text="Self" Style="background: #e9e9e9; border: solid 1px #000; padding: 5px;"></asp:Label>--%>
                                        <asp:DropDownList ID="ddlp1" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlp1_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvParent1" runat="server" ControlToValidate="ddlp1"
                                            Display="Dynamic" ForeColor="Red" ErrorMessage="Please Select Parent" SetFocusOnError="True"
                                            ValidationGroup="V" InitialValue="0"></asp:RequiredFieldValidator>
                                        <asp:DropDownList ID="ddlp2" runat="server" class="form-control">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvParent2" runat="server" ControlToValidate="ddlp2"
                                            Display="Dynamic" ForeColor="Red" ErrorMessage="Please Select Parent" SetFocusOnError="True"
                                            ValidationGroup="V" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>MenuLink</label>
                                        <asp:TextBox ID="txtlink" runat="server" class="form-control" PlaceHolder="Menu Link"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtlink"
                                            Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter Menu link" SetFocusOnError="True"
                                            ValidationGroup="V" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>Position</label>
                                        <asp:TextBox ID="txtPosition" runat="server" Text="0" onkeypress="return isNumber(event)" class="form-control" MaxLength="2" PlaceHolder="Position"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvPosition" runat="server" ControlToValidate="txtPosition"
                                            Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter Position" SetFocusOnError="True"
                                            ValidationGroup="V" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>CssClass</label>
                                        <asp:TextBox ID="txtCssClass" runat="server" class="form-control" PlaceHolder="CssClass"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" ValidationGroup="V" OnClick="btnSubmit_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-9">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="table-responsive">
                                        <div class="card-body" <%--style="overflow: scroll !important"--%>>
                                            <asp:GridView ID="gvrmenu" runat="server" AutoGenerateColumns="False" CssClass="table  table-bordered" OnRowCommand="gvrmenu_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SNo">
                                                        <ItemStyle Width="2%" />
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#Container.DataItemIndex + 1%>
                                                            </span>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="MenuName" HeaderText="MenuName" />
                                                    <%--<asp:BoundField DataField="MenuLink" HeaderText="MenuLink" />--%>
                                                    <asp:BoundField DataField="Position" HeaderText="Position" />
                                                   <%-- <asp:BoundField DataField="MenuLevel" HeaderText="MenuLevel" />--%>
                                                    <asp:BoundField DataField="ParentMenu" HeaderText="ParentMenu" />
                                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <a href="MenuMaster.aspx?id=<%#Eval("ID") %>" style="padding: 5%" title="Edit this record">
                                                                <img src="icons/edit_16x16.png" alt="Edit" />
                                                            </a>
                                                            <asp:LinkButton ID="lnkStatus" runat="server" Style="padding: 5%" CommandName="IsStatus" CommandArgument='<%#Eval("ID") %>' ToolTip="click to activate or deactivate..!"><img src='icons/<%#Eval("Status").ToString()=="Active"?"IsActive.png":"IsDeactive.png" %>' alt="Status" /></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkDelete" runat="server" OnClientClick="return DeleteItem();" Style="padding: 5%" CommandName="IsDelete" CommandArgument='<%#Eval("ID") %>' ToolTip="click to delete"><img src="icons/icn_trash.png" alt="Status" /></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
            <asp:PostBackTrigger ControlID="btnSubmit" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

