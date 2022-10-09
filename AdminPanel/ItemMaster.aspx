<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ItemMaster.aspx.cs" Inherits="AdminPanel_ItemMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script>
          function fnn() {
              $('#<%= gvItem.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvItem.ClientID%>").find("tr:first"))).DataTable({
                  stateSave: true,
              });
          }
    </script>
    <script type="text/javascript">
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
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Category</label>
                                        <asp:DropDownList ID="ddlCategory" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Please Select Category" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="ddlCategory" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Sub Category</label>
                                        <asp:DropDownList ID="ddlSubCategory" runat="server" class="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Please Select Sub Category" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="ddlSubCategory" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Item Name</label>
                                        <asp:TextBox ID="txtItemName" runat="server" placeholder="Enter Item Name" class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please Enter Item Name" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="txtItemName" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">&nbsp;</label>
                                        <br />
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="V" CssClass="btn btn-success" OnClick="btnSubmit_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="table-responsive">
                                        <asp:GridView ID="gvItem" AutoGenerateColumns="false" CssClass="table table-bordered" runat="server" OnRowCommand="gvrregion_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo">
                                                    <ItemStyle Width="2%" />
                                                    <ItemTemplate>
                                                        <span>
                                                            <%#Container.DataItemIndex + 1%>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />
                                                <asp:BoundField DataField="SubCategoryName" HeaderText="SubCategory Address" />
                                                <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <a href="ItemMaster.aspx?id=<%#Eval("ID") %>" style="padding: 5%" title="Edit this record">
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

