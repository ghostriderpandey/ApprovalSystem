<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="CRMLogicNoteReport.aspx.cs" Inherits="AdminPanel_CRMLogicNoteReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        table table-bordered {
            border: 2px solid black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row" style="border: 2px solid red">
        <table class="table table-bordered">
            <tr style="border: 1px solid red">
                <td colspan="6" class="text-center red font-weight-bold" style="background-color: #c0c0c0;"><b>CRM Logic Note</b></td>

            </tr>
            <tr style="border: 1px solid red">
                <td class="text-center red" style="background-color: #00b0f0" id="tdpriorapproval" runat="server">
                    <asp:HyperLink ID="lnkPriorApprovalsDownload" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Prior Approvals</asp:HyperLink>
                </td>
                <td colspan="5" class="text-center red" style="background-color: #00b0f0" id="tdlogicnote" runat="server">
                    <asp:HyperLink ID="lnklogicnoteDownload" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Logic Note</asp:HyperLink>
                </td>

            </tr>
            <tr>
                <td>Approval Type </td>
                <td>
                    <asp:Label ID="lblApprovalType" runat="server" Text=""></asp:Label></td>

                <td><strong id="storderno" runat="server">Approval No</strong></td>
                <td>
                    <asp:Label ID="lblorderno" Font-Bold="true" runat="server" Text=""></asp:Label></td>
                <td><span id="spaNo" visible="false" runat="server">Amendment Approval No</span> </td>
                <td>
                    <asp:Label ID="lblApprovalNo" Font-Bold="true" Visible="false" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="border: 1px solid red">
                <td>Approval Authority</td>
                <td>
                    <asp:Label ID="lblapprovalauthority" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Company Name</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblcompanyname" runat="server" Text=""></asp:Label></td>


            </tr>
            <tr>
                <td>Subject & Scope</td>
                <td>
                    <asp:Label ID="lblsubjectscope" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Project & Address</td>
                <td colspan="2">
                    <asp:Label ID="lblprojectnaddress" runat="server" Text=""></asp:Label></td>


            </tr>
            <tr>
                <td>Department</td>
                <td>
                    <asp:Label ID="lbldepartment" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Approval Priority</td>
                <td colspan="2">
                    <asp:Label ID="lblApprovalPriority" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>Urgent Remarks</td>
                <td>
                    <asp:Label ID="lblUrgentRemarks" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Status </td>
                <td colspan="2">
                    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>

                <td>Reason Of Amendment</td>
                <td>
                    <asp:Label ID="lblReasonOfAmendment" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Other Description </td>
                <td colspan="2">
                    <asp:Label ID="lblOtherDescription" runat="server" Text=""></asp:Label></td>

            </tr>
            <tr>
                <td>Customer/ClientName</td>
                <td>
                    <asp:Label ID="lblCustomerName" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Negotiation Mode</td>
                <td colspan="2">
                    <asp:Label ID="lblNegotiationMode" runat="server" Text=""></asp:Label></td>
            </tr>

            <tr>
                <td class="text-center red" style="background-color: #00b0f0" id="tdindent" runat="server">
                    <asp:HyperLink ID="lnkIndentdownload" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Indent</asp:HyperLink>
                </td>
                <td class="text-center red" style="background-color: #00b0f0" id="tdbudgetapproval" runat="server">
                    <asp:HyperLink ID="lnkbudgetapproval" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Budget Approval</asp:HyperLink>
                </td>
                <td colspan="4" class="text-center red" style="background-color: #00b0f0" id="tddeliveryschedule" runat="server">
                    <asp:HyperLink ID="lnkdeliveryschedule" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Delivery Schedule</asp:HyperLink>
                </td>


            </tr>
        </table>
    </div>
    <div class="row" style="border: 2px solid red">
        <table class="table table-bordered">
            <tr>
                <td colspan="2"><strong>Approval Sought</strong></td>
                <td colspan="12">
                    <asp:Label ID="lblApprovalSought" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td><strong>Channel Partner Name</strong></td>
                <td>
                    <asp:Label ID="lblChannelPartnerName" runat="server" Text=""></asp:Label></td>
                <td><strong id="Strong1" runat="server">Unit No.</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblUnitNo" runat="server" Text=""></asp:Label></td>
                <td><strong>Old Unit No.</strong></td>
                <td>
                    <asp:Label ID="lblOldUnitNo" runat="server" Text=""></asp:Label></td>
                <td><strong id="Strong2" runat="server">Super Area</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblSuperArea" runat="server" Text=""></asp:Label></td>
                <td><strong>BSP(Rs./Sqft)</strong></td>
                <td>
                    <asp:Label ID="lblBSP" runat="server" Text=""></asp:Label></td>
                <td><strong id="Strong3" runat="server">PLC(Rs./Sqft)</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblPLC" runat="server" Text=""></asp:Label></td>
            </tr>

            <tr>
                <td><strong>EDC/IDC(Rs./Sqft)</strong></td>
                <td>
                    <asp:Label ID="lblEDC" runat="server" Text=""></asp:Label></td>
                <td><strong id="Strong4" runat="server">EIC(Rs./Sqft)</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblEIC" runat="server" Text=""></asp:Label></td>
                <td><strong>Car Parking</strong></td>
                <td>
                    <asp:Label ID="lblCarparking" runat="server" Text=""></asp:Label></td>
                <td><strong id="Strong5" runat="server">TCV</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblTCV" runat="server" Text=""></asp:Label></td>
                <td><strong>Possession Charges(Rs./Sqft)</strong></td>
                <td>
                    <asp:Label ID="lblPossessionCharges" runat="server" Text=""></asp:Label></td>
                <td><strong id="Strong6" runat="server">Other Charges(Rs./Sqft)</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblOtherCharges" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td><strong>Regn No.</strong></td>
                <td>
                    <asp:Label ID="lblRegnNo" runat="server" Text=""></asp:Label></td>
                <td colspan="12"></td>
            </tr>


        </table>
    </div>
    <div class="row" style="border: 2px solid">
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Payment Plan</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvPaymentPlan" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Payment Terms">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("PaymentTerms").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Amount").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remark">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Remark").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No records found ...!
                        </EmptyDataTemplate>

                    </asp:GridView>
                </td>

            </tr>
        </table>
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Payment Details</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvPaymentDetails" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Amount").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Payment Mode">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("PaymentMode").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remark">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Remark").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No records found ...!
                        </EmptyDataTemplate>

                    </asp:GridView>
                </td>

            </tr>
        </table>

        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Report Approval</b></td>
                <td class="text-center red font-weight-bold" style="background-color: #c0c0c0">Checked/Verified & Recommended by</td>
            </tr>
            <tr>
                <td colspan="13">
                    <asp:GridView ID="gvApprover" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Created By">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Prepared").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Created On">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("CreatedOn").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Department Name">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("DepartmentName").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approver Name">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("UserName").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Status").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approve Date">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("ApproveDate").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Remark").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No records found ...!
                        </EmptyDataTemplate>

                    </asp:GridView>
                </td>

            </tr>
        </table>

        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Attachment</b></td>
            </tr>
            <tr>
                <td colspan="12">

                    <asp:GridView ID="gvAttachment" OnRowCommand="gvAttachment_RowCommand" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocFile">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkAdd" runat="server" Text='<%# Eval("DocFile") %>' CommandArgument='<%# Eval("ID") + "," + Eval("CRMID") + "," + Eval("DocFile")  %>' CommandName="Download" ToolTip="Download"></asp:LinkButton>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocImage">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDocImage" runat="server" Text='<%# Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("CRMID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" ToolTip="Download Image"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No records found ...!
                        </EmptyDataTemplate>

                    </asp:GridView>

                </td>
            </tr>
        </table>
        <table class="table table-bordered">
            <tr>
                <td>Head of Department</td>
                <td>
                    <asp:Label ID="lblHeadOfDepartment" runat="server"></asp:Label></td>

            </tr>
        </table>
        <table class="table table-bordered">
            <tr>
                <td>Remark</td>
                <td>
                    <asp:TextBox ID="txtremark" runat="server" TextMode="MultiLine" CssClass="form-control" ValidationGroup="V"></asp:TextBox></td>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter remark" ControlToValidate="txtremark"></asp:RequiredFieldValidator>--%>
            </tr>
        </table>
        <table class="table table-bordered" runat="server" id="tblApprover">
            <tr>
                <td colspan="12" class="text-center red">
                    <asp:Button ID="btnapprove" runat="server" CssClass="btn btn-primary" Text="Approve" OnClick="btnapprove_Click" />
                    <asp:Button ID="btnreject" runat="server" CssClass="btn btn-primary" Text="Reject" ValidationGroup="V" OnClick="btnreject_Click" OnClientClick="return confirm('Are you sure, you want to reject?');" />
                    <asp:Button ID="btnprint" runat="server" Text="Print" CssClass="btn btn-primary" OnClick="btnprint_Click" />
                    <%--<asp:Button ID="btnback" runat="server" Text="Back" CssClass="btn btn-primary" />--%></td>
            </tr>

        </table>
        <table class="table table-bordered" runat="server" id="tblCommitteeApprover" visible="false">
            <tr>
                <td colspan="12" class="text-center red">
                    <asp:Button ID="btnCApprove" runat="server" CssClass="btn btn-primary" Text="Approve" OnClick="btnCApprove_Click" />
                    <asp:Button ID="btnCReject" runat="server" CssClass="btn btn-primary" Text="Reject" ValidationGroup="V" OnClick="btnCReject_Click" OnClientClick="return confirm('Are you sure, you want to reject?');" />
                    <asp:Button ID="btncprint" runat="server" Text="Print" CssClass="btn btn-primary" OnClick="btnprint_Click" />
                    <%--<asp:Button ID="btnback" runat="server" Text="Back" CssClass="btn btn-primary" />--%></td>
            </tr>

        </table>

    </div>
</asp:Content>
