<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ListApproveMVPurchaseAmendment.aspx.cs" Inherits="AdminPanel_ListApproveMVPurchaseAmendment" %>

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
    <script type="text/javascript">
        function ApproveItem() {
            if (confirm("Are you sure you want to Approve ...?")) {
                return true;
            }
            return false;
        }
        function RejectItem() {
            if (confirm("Are you sure you want to Reject ...?")) {
                return true;
            }
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                         <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">From Date</label>
                                                <asp:TextBox ID="txtFromApprovalDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">To Date</label>
                                                <asp:TextBox ID="txtToApprovalDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">Project Name</label>
                                                <asp:DropDownList ID="ddlprojectname" runat="server" class="form-control"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">Status</label>
                                                <asp:DropDownList ID="ddlStatus" runat="server" class="form-control">
                                                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                                    <asp:ListItem Value="1">Approved</asp:ListItem>
                                                    <asp:ListItem Value="2">Pending</asp:ListItem>
                                                    <asp:ListItem Value="3">Rejected</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">&nbsp;</label>
                                                <br />
                                                <asp:Button ID="btnFilter" runat="server" Text="Filter" ValidationGroup="V" CssClass="btn btn-success" OnClick="btnFilter_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <asp:GridView ID="gvUser" runat="server" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" AutoGenerateColumns="False" CssClass="table  table-bordered" OnRowCommand="gvUser_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#Container.DataItemIndex + 1%>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField DataField="PANRefID" HeaderText="PANRefID" />--%>
                                             <asp:BoundField DataField="ApprovalType2" HeaderText="ApprovalType" />
                                            <asp:BoundField DataField="ProposedVendor" HeaderText="ProposedVendor" />
                                            <asp:BoundField DataField="PurchaseOrderNo" HeaderText="PurchaseOrderNo" />
                                            <asp:BoundField DataField="ApprovalAuthrity" HeaderText="Approval Authority" />
                                            <asp:BoundField DataField="SubjectandScope" HeaderText="Subject and Scope" />
                                            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" />
                                            <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" />
                                            <asp:BoundField DataField="AddDate" HeaderText="Created By" />
                                            <asp:TemplateField HeaderText="Approval Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApproveStatus" runat="server" Text='<%#Eval("ApprovalStatus") %>' />
                                                    <asp:LinkButton ID="btnView" runat="server" CommandName="ViewApprover" CommandArgument='<%#Eval("PANID") %>' title="View this record">
                                                                 <i class="fa fa-search"></i>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ApprovalDate" HeaderText="Approval Date" />
                                            <asp:TemplateField HeaderText="Remark">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control" Rows="1" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"pointer-events: fill;": "pointer-events: none;" %>' TextMode="MultiLine" Text='<%#Eval("Remark") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <a href="PurchaseAmendmentReport.aspx?id=<%#Eval("PANID") %>&AID=<%#Eval("ID") %>" title="Click to view" class="fa fa-eye"></a>
                                                    <asp:LinkButton ID="lnkView" ToolTip="Click to view PDF..!" runat="server" CommandName="View" CommandArgument='<%#Eval("PANID") %>' CssClass="fa fa-search"></asp:LinkButton>
                                                    <%--  <a href="PurchaseLogicNote.aspx?id=<%#Eval("ID") %>" title="Edit this record" class="fa fa-edit">
                                                        
                                                    </a>--%>
                                                    <asp:LinkButton ID="lnkApprove" CssClass="fa fa-check-square" ToolTip="Click to approve..!" runat="server" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"Display:contents": "Display:none" %>' OnClientClick="return ApproveItem();" Text="" CommandName="Approve" CommandArgument='<%#Eval("ID") %>'>

                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lnkReject" CssClass="fa fa-close" ToolTip="Click to reject..!" runat="server" OnClientClick="return RejectItem();" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"Display:contents": "Display:none" %>' Text="" CommandName="Reject" CommandArgument='<%#Eval("ID") %>'>

                                                    </asp:LinkButton>
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
    <%--  </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

