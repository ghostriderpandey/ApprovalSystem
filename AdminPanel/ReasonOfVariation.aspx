<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ReasonOfVariation.aspx.cs" Inherits="AdminPanel_ReasonOfVariation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
         function fnn() {
             $('#<%= gvReasonofvariation.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvReasonofvariation.ClientID%>").find("tr:first"))).DataTable({
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
                                        <label for="exampleInputEmail1" class="font-weight-bold">Type Name</label>
                                        <asp:DropDownList ID="ddlTypeName" runat="server" class="form-control" data-live-search="true"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Please Select Type Name" InitialValue="0" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="ddlTypeName" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Reason Of Variation</label>
                                        <asp:TextBox ID="txtReasonofvariation" runat="server" placeholder="Reason Of Variation" class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please Enter Reasonofvariation" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="txtReasonofvariation" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                        <asp:GridView ID="gvReasonofvariation" AutoGenerateColumns="false" CssClass="table table-bordered" runat="server" OnRowCommand="gvReasonofvariation_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo">
                                                    <ItemStyle Width="2%" />
                                                    <ItemTemplate>
                                                        <span>
                                                            <%#Container.DataItemIndex + 1%>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="TypeName" HeaderText="Type Name" />
                                                <asp:BoundField DataField="Reasionofvariation" HeaderText="Reasion of Variation" />
                                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <a href="ReasonOfVariation.aspx?id=<%#Eval("ID") %>" style="padding: 5%" title="Edit this record">
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

