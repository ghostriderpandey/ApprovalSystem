<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ListApproveCRMLogicNote.aspx.cs" Inherits="AdminPanel_ListApproveCRMLogicNote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
                                        <div class="col-sm-3 col-5">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">From Date</label>
                                                <asp:TextBox ID="txtFromApprovalDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-5">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">To Date</label>
                                                <asp:TextBox ID="txtToApprovalDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-5">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">Project Name</label>
                                                <asp:DropDownList ID="ddlprojectname" runat="server" class="form-control selectcss"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-5">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="font-weight-bold">Status</label>
                                                <asp:DropDownList ID="ddlStatus" runat="server" class="form-control selectcss">
                                                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                                    <asp:ListItem Value="1">Approved</asp:ListItem>
                                                    <asp:ListItem Value="2">Pending</asp:ListItem>
                                                    <asp:ListItem Value="3">Rejected</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="col-sm-3 col-5">
                                            <div class="form-group filetbtn">
                                                <label for="exampleInputEmail1" class="font-weight-bold">&nbsp;</label>
                                                <br />
                                                <asp:Button ID="btnFilter" runat="server" Text="Filter" ValidationGroup="V" CssClass="btn btn-success w-100" OnClick="btnFilter_Click" />
                                            </div>
                                        </div>
                                    </div>
                                
                                <div class="w-100">
                                    <asp:GridView ID="gvUser" runat="server" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" AutoGenerateColumns="False" CssClass="table  table-bordered table-responsive" OnRowCommand="gvUser_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#Container.DataItemIndex + 1%>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CRMOrderNo" HeaderText="SerialCode" />
                                            <asp:BoundField DataField="ApprovalType" HeaderText="Approval Type" />
                                             <asp:BoundField DataField="CustomerName" HeaderText="Client Name/Customer Name" />
                                            <asp:BoundField DataField="ApprovalAuthrity" HeaderText="Approval Authority" />
                                            <asp:BoundField DataField="SubjectandScope" HeaderText="Subject and Scope" />
                                            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" />
                                             <asp:BoundField DataField="UnitNo" HeaderText="Unit No" />
                                            <asp:BoundField DataField="CreatedBy" HeaderText="Created By" />
                                            <asp:BoundField DataField="AddDate" HeaderText="Created On" />
                                            <asp:TemplateField HeaderText="Approval Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApproveStatus" runat="server" Text='<%#Eval("ApprovalStatus") %>' />
                                                    <asp:LinkButton ID="btnView" runat="server" CommandName="ViewApprover" CommandArgument='<%#Eval("CRMID") %>' title="View this record">
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
                                                    <a href="CRMLogicNoteReport.aspx?id=<%#Eval("CRMID") %>&AID=<%#Eval("ID") %>" title="Click to view" class="fa fa-eye  "></a>
                                                    <asp:LinkButton ID="lnkView" ToolTip="Click to view PDF..!" runat="server" CommandName="View" CssClass="fa fa-search" CommandArgument='<%#Eval("CRMID") %>'><%--<img src="Icons/view_16x16.png" />--%></asp:LinkButton>
                                                    <%--<a href="PurchaseLogicNote.aspx?id=<%#Eval("ID") %>" title="Edit this record" class="fa fa-edit">
                                                       
                                                    </a>--%>
                                                    <asp:LinkButton ID="lnkApprove" ToolTip="Click to approve..!" CssClass="fa fa-check-square" runat="server" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"Display:contents": "Display:none" %>' OnClientClick="return ApproveItem();" Text="Approve" CommandName="Approve" CommandArgument='<%#Eval("ID") %>'>
<%--<img src="Icons/Approve.png" />--%>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lnkReject" ToolTip="Click to reject..!" CssClass="fa fa-close" runat="server" OnClientClick="return RejectItem();" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"Display:contents": "Display:none" %>' Text="Reject" CommandName="Reject" CommandArgument='<%#Eval("ID") %>'>
<%--<img src="Icons/Reject.png" />--%>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
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
                        <asp:GridView ID="gvPopup" CssClass="table table-bordered " ClientIDMode="Static" runat="server" AutoGenerateColumns="true">
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
    <%--      
        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>


