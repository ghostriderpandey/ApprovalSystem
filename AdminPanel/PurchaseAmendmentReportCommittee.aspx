<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="PurchaseAmendmentReportCommittee.aspx.cs" Inherits="AdminPanel_PurchaseAmendmentReportCommittee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
        table table-bordered {
            border: 2px solid black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row" style="border: 2px solid red">
        <table class="table table-bordered">
            <tr style="border: 1px solid red">
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0;"><b>Purchase Amendment Logic Note</b></td>

            </tr>
            <tr style="border: 1px solid red">
                <td colspan="6" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="hprpriorapproval" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Prior Approvals</asp:HyperLink>
                </td>
                <td colspan="6" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="hprlogicnote" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Logic Note</asp:HyperLink>
                </td>

            </tr>
             <tr>
                <td colspan="2"><strong>Company Name</strong></td>
                <td colspan="3">
                    <asp:Label ID="lblcompanyname" runat="server" Text=""></asp:Label></td>
                <td ><strong id="storderno" runat="server">Reference OrderNo</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblorderno" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Purchase Logic Note No.</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblPurchaseOrderNo" Font-Bold="true" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="border: 1px solid red">
                <td colspan="2">Approval Authority</td>
                <td colspan="4">
                    <asp:Label ID="lblapprovalauthority" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Subject & Scope</td>
                <td colspan="4">
                    <asp:Label ID="lblsubjectscope" runat="server" Text=""></asp:Label></td>

            </tr>
            <tr>
                <td colspan="2">Project & Address</td>
                <td colspan="4">
                    <asp:Label ID="lblprojectnaddress" runat="server" Text=""></asp:Label></td>
                <td>Indent Proponent</td>
                <td>
                    <asp:Label ID="lblindentproponent" runat="server" Text=""></asp:Label></td>
                <td>Date Of Indent</td>
                <td>
                    <asp:Label ID="lbldateofindent" runat="server" Text=""></asp:Label></td>
                <td>Material Needed by: </td>
                <td>
                    <asp:Label ID="lblmaterialneededby" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>Stock in Hand</td>
                <td>
                    <asp:Label ID="lblstockinhand" runat="server" Text=""></asp:Label></td>
                <td>Requirement</td>
                <td>
                    <asp:Label ID="lblrequirement" runat="server" Text=""></asp:Label></td>
                <td>Saleable Area<small>(In Sq. Ft)</small></td>
                <td>
                    <asp:Label ID="lblsaleablearea" runat="server" Text=""></asp:Label></td>
                <td>Approve Budget<small>(inLacs)</small></td>
                <td>
                    <asp:Label ID="lblapprovebudget" runat="server" Text=""></asp:Label></td>
                <td>Already Awarded<small>(inLacs)</small></td>
                <td>
                    <asp:Label ID="lblalreadyawarded" runat="server" Text=""></asp:Label></td>
                <td style="background-color: #bfbfbf">Revised Value as per this amend<small>(inLacs)</small></td>
                <td style="background-color: #bfbfbf">
                    <asp:Label ID="lblrevisedvalueasperthisamend" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>Balance to be Award</td>
                <td>
                    <asp:Label ID="lblbalancetobeawarded" runat="server" Text=""></asp:Label></td>
                <td id="tdvariationfrombudgetName" runat="server">Variation From Budget</td>
                <td id="tdvariationfrombudgetvalue" runat="server">
                    <asp:Label ID="lblvariationfrombudget" runat="server" Text=""></asp:Label></td>

                <td>Reason of Variation</td>
                <td>
                    <asp:Label ID="lblreasonofvariation" runat="server" Text=""></asp:Label></td>
                  <td><strong id="reasonofother" runat="server">Reason for Others</strong></td>
                <td colspan="3">
                    <asp:Label ID="lblreasonofother" runat="server" Text=""></asp:Label></td>
                <td>Proposed Vendor Name</td>
                <td colspan="2">
                    <asp:Label ID="lblproposedvendorname" runat="server" Text=""></asp:Label></td>

            </tr>

            <tr>
                <td colspan="4" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="hprindent" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Indent</asp:HyperLink>
                </td>
                <td colspan="4" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="hprbudgetapproval" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Budget Approval</asp:HyperLink>
                </td>
                <td colspan="4" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="hprdeliveryschedule" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Delivery Schedule</asp:HyperLink>
                </td>


            </tr>
        </table>
    </div>
    <div class="row" style="border: 2px solid">
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Major deviation & recommendation in terms-conditions</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvStandardexception" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="As per Agreement">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Standard").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Exception">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Excepetion").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Recommendation">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Recommendation").ToString()) %>
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
                <td colspan="11" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Amendment Details:</b></td>
            </tr>

            <tr>

                <td colspan="2">Mention Name of Vendor with PO no</td>
                <td colspan="2">Cost as per original Award</td>
                <td colspan="2">Rev. Cost as per previous Amendment</td>
                <td colspan="2">Rev. Cost as per this Amendment</td>
                <td colspan="2">Variation Previous vs this amendment</td>
                <td colspan="2" class="red">Variation Original vs this amendment</td>

            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblmentionnameofvendorwithpo" runat="server" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblcostasperoriginalaward" runat="server" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblrevcostasperpreviousamendment" runat="server" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblrevcostasperthisamendment" runat="server" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblvariationprevvsthisamendment" runat="server" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblvariationoriginalvsthisamendmet" runat="server" Text=""></asp:Label></td>
            </tr>

        </table>
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Bid Evaluation</b></td>

            </tr>
            <tr>
                <%--<td>Cost Variation Details</td>--%>
                <td colspan="12">
                    <asp:GridView ID="gvItemHead" runat="server" ShowFooter="true" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">

                        <Columns>
                            <asp:BoundField DataField="SNO" HeaderText="S.No." />
                            <asp:BoundField DataField="PreviousItem1" HeaderText="Prev. Item" />
                            <asp:BoundField DataField="PreviousUOM" HeaderText="Prev. UOM" />
                            <asp:BoundField DataField="PreviousQuantity" HeaderText="Prev. Qty." />
                            <asp:BoundField DataField="PreviousRate" HeaderText=" Prev. Rate" />
                            <asp:BoundField DataField="PreviousAmount" HeaderText="Prev. Amount" />
                            <asp:BoundField DataField="ThisItem1" HeaderText="This Item" />
                            <asp:BoundField DataField="ThisQuantity" HeaderText="This Qty." />
                            <asp:BoundField DataField="ThisRate" HeaderText="This Rate" />
                            <asp:BoundField DataField="ThisAmount" HeaderText="This Amount" />
                            <asp:BoundField DataField="BudgetRate" HeaderText="Bugeted Rate(If any)" />
                            <asp:BoundField DataField="Reason" ControlStyle-CssClass="red" HeaderText="Reasons" />

                        </Columns>

                        <EmptyDataTemplate>
                            No records found ...!
                        </EmptyDataTemplate>

                    </asp:GridView>
                </td>

            </tr>
            <tr>
                <td colspan="2" class="text-right">Frieght</td>
                <td colspan="3">
                    <asp:Label ID="lblfrieghtprev" runat="server" Text=""></asp:Label></td>
                <td colspan="3">
                    <asp:Label ID="lblfrieghtthis" runat="server" Text=""></asp:Label></td>

                <td colspan="4"></td>

            </tr>
            <tr>
                <td colspan="2" class="text-right">Handling/Insurance Charge</td>
                <td colspan="3">
                    <asp:Label ID="lblPreviousHandlingCharge" runat="server" Text=""></asp:Label></td>
                <td colspan="3">
                    <asp:Label ID="lblThisHandlingCharge" runat="server" Text=""></asp:Label></td>

                <td colspan="4"></td>

            </tr>
            <tr>
                <td colspan="2" class="text-right">Other Charge</td>
                <td colspan="3">
                    <asp:Label ID="lblPreviousOtherCharge" runat="server" Text=""></asp:Label></td>
                <td colspan="3">
                    <asp:Label ID="lblThisOtherCharge" runat="server" Text=""></asp:Label></td>

                <td colspan="4"></td>

            </tr>
            <tr>
                <td colspan="2" class="text-right">Handling Charges</td>
                <td colspan="3">
                    <asp:Label ID="lblhandingchargesprev" runat="server" Text=""></asp:Label></td>

                <td colspan="3">
                    <asp:Label ID="lblhandingchargesthis" runat="server" Text=""></asp:Label></td>



                <td colspan="4"></td>
            </tr>
            <tr>
                <td colspan="2" class="text-right">GST</td>
                <td colspan="3">
                    <asp:Label ID="lblgstvprev" runat="server" Text=""></asp:Label></td>

                <td colspan="3">
                    <asp:Label ID="lblgstthis" runat="server" Text=""></asp:Label></td>

                <td colspan="4"></td>
            </tr>

            <tr style="background-color: #bfbfbf">
                <td colspan="2" class="text-right">Grand Total</td>

                <td colspan="3">
                    <asp:Label ID="lblgrandtotalprev" runat="server" Text=""></asp:Label></td>

                <td colspan="3">
                    <asp:Label ID="lblgrandtotalthis" runat="server" Text=""></asp:Label></td>



                <td colspan="4"></td>
            </tr>

            <tr>
                <td colspan="2" class="text-right">Cost/Sq. Ft.</td>
                <td colspan="3">
                    <asp:Label ID="lblcostsqftprev" runat="server" Text=""></asp:Label></td>

                <td colspan="3">
                    <asp:Label ID="lblcostsqftthis" runat="server" Text=""></asp:Label></td>



                <td colspan="4"></td>
            </tr>
            <tr style="border: 1px solid red">
                <td colspan="12" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="hprdrawingdocument" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false"> DRAWINGS Document</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td colspan="3">Recommendations with reasons</td>
                <td colspan="9">
                    <asp:Label ID="lblrecommadationwithreason" runat="server" Text=""></asp:Label></td>

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
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Category").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                      <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                                   <%-- <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "../Upload/PAN/"+ Eval("DocFile") %>' Text='<%# Eval("Category") %>'></asp:HyperLink>--%>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocFile">
                                <ItemTemplate>
                                     <asp:LinkButton ID="lnkAdd" runat="server" Text='<%# Eval("Category") %>' CommandArgument='<%# Eval("ID") + "," + Eval("PANID") + "," + Eval("DocFile")  %>' CommandName="Download" ToolTip="Download"></asp:LinkButton>
                                   <%-- <%# HttpUtility.HtmlDecode(Eval("DocFile").ToString()) %>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocImage">
                                <ItemTemplate>
                                   <asp:LinkButton ID="lnkDocImage" runat="server" Text='<%# Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("PANID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" ToolTip="Download Image"></asp:LinkButton>
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
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Checked/Verified & Recommended By</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvApprover" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Department">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("DepartmentName").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Username").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Status").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("ApproveDate", "{0:dd/MM/yyyy h:mm:ss tt}").ToString()) %>
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
                <td>Prepared By</td>
                <td>
                    <asp:Label ID="lblpreparedby" runat="server" Text=""></asp:Label></td>
                <td>Prepared On</td>
                <td>
                    <asp:Label ID="lblcreatedon" runat="server" Text=""></asp:Label></td>
                <td>Remark</td>
                <td>
                    <asp:TextBox ID="txtremark" runat="server" TextMode="MultiLine" Rows="1" CssClass="form-control" ValidationGroup="v"></asp:TextBox></td>

            </tr>
        </table>
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red">
                    <asp:Button ID="btnapprove" runat="server" CssClass="btn btn-primary" Text="Approve" OnClick="btnapprove_Click" />
                    <asp:Button ID="btnreject" runat="server" CssClass="btn btn-primary" Text="Reject" ValidationGroup="V" OnClick="btnreject_Click" OnClientClick="return confirm('Are you sure, you want to reject?');" />
                    <asp:Button ID="btnprint" runat="server" Text="Print" CssClass="btn btn-primary" OnClick="btnprint_Click" />
                    <%--<asp:Button ID="btnback" runat="server" Text="Back" CssClass="btn btn-primary" />--%></td>
            </tr>

        </table>


    </div>
</asp:Content>

