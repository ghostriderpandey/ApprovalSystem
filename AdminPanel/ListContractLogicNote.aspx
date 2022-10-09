<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ListContractLogicNote.aspx.cs" Inherits="AdminPanel_ListContractLogicNote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <%--<script type="text/javascript" src="../build/js/jquery-1.8.3.min.js"></script>--%>
    <script type="text/javascript" src='../build/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='../build/css/bootstrap.min.css' media="screen" />
    <style>
        @media (min-width:556px) {
            .modal-dialog {
                max-width: 100% !important;
            }
        }
    </style>
    <script type="text/javascript">
        function ShowPopup(title) {
            $("#MyPopup .modal-title").html(title);
            $("#MyPopup").modal("show");
        }
    </script>
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
        <div class="col-xl-12">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card-body">
                                <div class="w-100">
                                    <asp:GridView ID="gvUser" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" runat="server" AutoGenerateColumns="False" CssClass="table  table-bordered table-responsive" OnRowCommand="gvUser_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#Container.DataItemIndex + 1%>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CLNOrderNo" HeaderText="SerialCode" />
                                            <asp:BoundField DataField="ApprovalAuthrity" HeaderText="Approval Authority" />
                                            <asp:BoundField DataField="SubjectandScope" HeaderText="Subject and Scope" />
                                            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" />
                                              <asp:BoundField DataField="VendorName" HeaderText="Proposed Vendor" />
                                             <asp:BoundField DataField="CreatedBy" HeaderText="Created By" />
                                             <asp:BoundField DataField="AddDate" HeaderText="Created On" />
                                            <asp:BoundField DataField="Status" HeaderText="Status" />
                                            <asp:BoundField DataField="SubmitStatus" HeaderText="Submit for Approval" />
                                            <asp:TemplateField HeaderText="Approval Approver Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApproveStatus" runat="server" Text='<%#Eval("ApproveStatus") %>' />
                                                    <asp:LinkButton ID="btnView" runat="server" CommandName="ViewApprover" CommandArgument='<%#Eval("ID") %>' title="View this record">
                                                                 <i class="fa fa-search"></i>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CommitteeApproveStatus" HeaderText="Approval Committee Status" />
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>

                                                    <asp:LinkButton ID="lnkView" ToolTip="Click to view PDF..!" runat="server" CommandName="View" Style="margin-right: 10px;" CommandArgument='<%#Eval("ID") %>'><img src="Icons/view_16x16.png" /></asp:LinkButton>
                                                    <a href="ContractLogicNote.aspx?id=<%#Eval("ID") %>" title="Edit this record">
                                                        <img src="icons/edit_16x16.png" alt="Edit" />
                                                    </a>
                                                    <asp:LinkButton ID="lnkStatus" runat="server" Style='<%#Eval("IsSubmitted").ToString()=="0"?"Display:initial;margin-right: 10px;": "Display:none;" %>' CommandName="IsStatus" CommandArgument='<%#Eval("ID") %>' ToolTip="click to activate or deactivate..!"><img src='icons/<%#Eval("Status").ToString()=="Active"?"IsActive.png":"IsDeactive.png" %>' alt="Status" /></asp:LinkButton>
                                                    <asp:LinkButton ID="lnkDelete" runat="server" OnClientClick="return DeleteItem();" Style='<%#Eval("IsSubmitted").ToString()=="0"?"Display:initial;margin-right: 10px;": "Display:none;" %>' CommandName="IsDelete" CommandArgument='<%#Eval("ID") %>' ToolTip="click to delete"><img src="icons/icn_trash.png" alt="Status" /></asp:LinkButton>
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
    <div id="MyPopup" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width: 830px;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <%-- <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title"></h4>--%>
                </div>
                <div class="modal-body">
                    <div class="table-responsive" style="height: 50vh; overflow-y: auto;">
                        <asp:GridView ID="gvPopup" CssClass="table table-bordered " runat="server" AutoGenerateColumns="true">
                            <Columns>
                                <asp:TemplateField HeaderText="SNo">
                                    <ItemTemplate>
                                        <itemstyle width="2%" />
                                        <span>
                                            <%#Container.DataItemIndex + 1%>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

