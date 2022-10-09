<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ListApproveCommitteeContractAmendmentNote.aspx.cs" Inherits="AdminPanel_ListApproveCommitteeContractAmendmentNote" %>

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
      <%--  <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
                                    <asp:GridView ID="gvUser" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" runat="server" AutoGenerateColumns="False" CssClass="table  table-bordered table-responsive" OnRowCommand="gvUser_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#Container.DataItemIndex + 1%>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField DataField="CANRefID" HeaderText="CANRefID" />--%>
                                             <asp:BoundField DataField="CANOrderNo" HeaderText="Logic Note Approval No." />
                                            <asp:BoundField DataField="ContractOrderNo" HeaderText="Contract OrderNo" />
                                            <asp:BoundField DataField="ApprovalAuthrity" HeaderText="Approval Authority" />
                                            <asp:BoundField DataField="SubjectandScope" HeaderText="Subject and Scope" />
                                            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" />
                                            <asp:BoundField DataField="ContractorName" HeaderText="Name of Proposed Vendor" />
                                            <asp:BoundField DataField="AddDate" HeaderText="Add Date" />
                                            <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval Status" />
                                            <asp:BoundField DataField="ApprovalDate" HeaderText="Approval Date" />
                                            <asp:TemplateField HeaderText="Remark">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control" Rows="1" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"pointer-events: fill;": "pointer-events: none;" %>' TextMode="MultiLine" Text='<%#Eval("Remark") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                     <a href="ContractAmendmentLogicNoteReportCommittee.aspx?id=<%#Eval("CANID") %>&AID=<%#Eval("ID") %>" title="Click to view" class="fa fa-eye">                                                        
                                                    </a>
                                                    <asp:LinkButton ID="lnkView" ToolTip="Click to view..!" runat="server" CommandName="View" CommandArgument='<%#Eval("CANID") %>'><img src="Icons/view_16x16.png" /></asp:LinkButton>
                                                  <%--  <a href="ContractLogicNote.aspx?id=<%#Eval("CLNID") %>" title="Edit this record">
                                                        <img src="icons/edit_16x16.png" alt="Edit" />
                                                    </a>--%>
                                                    <asp:LinkButton ID="lnkApprove" ToolTip="Click to approve..!" runat="server" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"Display:contents": "Display:none" %>' OnClientClick="return ApproveItem();" Text="Approve" CommandName="Approve" CommandArgument='<%#Eval("ID") %>'>
<img src="Icons/Approve.png" />
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lnkReject" ToolTip="Click to reject..!" runat="server" OnClientClick="return RejectItem();" Style='<%#Eval("ApprovalStatus").ToString()=="Pending"?"Display:contents": "Display:none" %>' Text="Reject" CommandName="Reject" CommandArgument='<%#Eval("ID") %>'>
<img src="Icons/Reject.png" />
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
     
    <%--   </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

