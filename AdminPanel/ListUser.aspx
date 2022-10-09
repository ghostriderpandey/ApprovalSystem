<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ListUser.aspx.cs" Inherits="AdminPanel_ListUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script>
          function fnn() {
              $('#<%= gvUser.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvUser.ClientID%>").find("tr:first"))).DataTable({
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
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
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
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <asp:GridView ID="gvUser" runat="server" AutoGenerateColumns="False" CssClass="table  table-bordered" OnRowCommand="gvUser_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SNo">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#Container.DataItemIndex + 1%>
                                                            </span>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="RoleName" HeaderText="Type" />
                                                    <asp:BoundField DataField="UserID" HeaderText="User ID" />
                                                    <asp:BoundField DataField="UserName" HeaderText="User Name" />
                                                    <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                                                    <asp:BoundField DataField="DesignationName" HeaderText="Designation" />
                                                    <%--<asp:BoundField DataField="Address" HeaderText="Address" />--%>
                                                    <%--<asp:BoundField DataField="FinancialLimit" HeaderText="Financial Limit" />
                                                    <asp:BoundField DataField="ConceptApprover" HeaderText="Concept Approver" />--%>
                                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                                    <asp:TemplateField HeaderText="Image">
                                                        <ItemTemplate>
                                                            <img src='../Upload/UserImages/<%#Eval("Imageurl") %>' width="50px" alt="Edit" />
                                                            <a href='../Upload/UserImages/<%#Eval("Imageurl") %>' target="_blank" <%#Eval("Imageurl").ToString().Length>0?"":"style='display:none'" %>>View</a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <a href="UserMaster.aspx?id=<%#Eval("ID") %>" style="padding: 1%" title="Edit this record">
                                                                <img src="icons/edit_16x16.png" alt="Edit" />
                                                            </a>
                                                            <asp:LinkButton ID="lnkStatus" runat="server" Style="padding: 1%" CommandName="IsStatus" CommandArgument='<%#Eval("ID") %>' ToolTip="click to activate or deactivate..!"><img src='icons/<%#Eval("Status").ToString()=="Active"?"IsActive.png":"IsDeactive.png" %>' alt="Status" /></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkDelete" runat="server" OnClientClick="return DeleteItem();" Style="padding: 1%" CommandName="IsDelete" CommandArgument='<%#Eval("ID") %>' ToolTip="click to delete"><img src="icons/icn_trash.png" alt="Status" /></asp:LinkButton>
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
    </asp:UpdatePanel>
</asp:Content>

