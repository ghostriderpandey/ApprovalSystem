﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="CustomerMaster.aspx.cs" Inherits="AdminPanel_CustomerMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
    function fnn() {
        $('#<%= gvcustomermaster.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvcustomermaster.ClientID%>").find("tr:first"))).DataTable({
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
                                        <label class="font-weight-bold">Customer/Client Code</label>
                                        <asp:TextBox ID="txtCustomerCode" runat="server" class="form-control" placeholder="Enter Customer/Client Code" data-live-search="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Please Enter Customer/Client Code" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="txtCustomerCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class="font-weight-bold">Customer/Client Name</label>
                                        <asp:TextBox ID="txtCustomerName" runat="server" placeholder="Enter Customer/Client Name" class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please Enter Customer/Client Name" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="txtCustomerName" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                        <asp:GridView ID="gvcustomermaster" AutoGenerateColumns="false" CssClass="table table-bordered" runat="server" OnRowCommand="gvcustomermaster_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo">
                                                    <ItemStyle Width="2%" />
                                                    <ItemTemplate>
                                                        <span>
                                                            <%#Container.DataItemIndex + 1%>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CustomerCode" HeaderText="Code" />
                                                <asp:BoundField DataField="CustomerName" HeaderText="Name" />
                                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <a href="CustomerMaster.aspx?id=<%#Eval("ID") %>" style="padding: 0%" title="Edit this record">
                                                            <img src="icons/edit_16x16.png" alt="Edit" />
                                                        </a>
                                                        <asp:LinkButton ID="lnkStatus" runat="server" Style="padding: 0%;margin-left:10px" CommandName="IsStatus" CommandArgument='<%#Eval("ID") %>' ToolTip="click to activate or deactivate..!"><img src='icons/<%#Eval("Status").ToString()=="Active"?"IsActive.png":"IsDeactive.png" %>' alt="Status" /></asp:LinkButton>
                                                        <asp:LinkButton ID="lnkDelete" runat="server" OnClientClick="return DeleteItem();" Style="padding: 0%;margin-left:10px" CommandName="IsDelete" CommandArgument='<%#Eval("ID") %>' ToolTip="click to delete"><img src="icons/icn_trash.png" alt="Status" /></asp:LinkButton>
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