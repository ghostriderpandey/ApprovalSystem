<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="MarketingLogicNoteReport.aspx.cs" Inherits="AdminPanel_MarketingLogicNoteReport" %>



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
                <td colspan="15" class="text-center red font-weight-bold" style="background-color: #c0c0c0;"><b>Marketing Logic Note</b></td>

            </tr>
            <tr style="border: 1px solid red">
                <td colspan="8" class="text-center red" style="background-color: #00b0f0" id="tdpriorapproval" runat="server">
                    <asp:HyperLink ID="lnkPriorApprovalsDownload" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Prior Approvals</asp:HyperLink>
                </td>
                <td colspan="7" class="text-center red" style="background-color: #00b0f0" id="tdlogicnote" runat="server">
                    <asp:HyperLink ID="lnklogicnoteDownload" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Logic Note</asp:HyperLink>
                </td>

            </tr>
             <tr>
                  <td colspan="2">Approval Type</td>
                <td colspan="2">
                    <asp:Label ID="lblApprovalType" runat="server" Text=""></asp:Label></td>
                 <td colspan="1" ><strong id="storderno" runat="server">Approval No</strong></td>
                <td colspan="3">
                    <asp:Label ID="lblorderno" Font-Bold="true" runat="server" Text=""></asp:Label></td>
                 <td><span id="spaNo" visible="false" runat="server">Amendment Approval No</span> </td>
                <td colspan="3">
                    <asp:Label ID="lblApprovalNo" Font-Bold="true" Visible="false" runat="server" Text=""></asp:Label></td>
                
            </tr>
            <tr style="border: 1px solid red">
                <td colspan="2">Approval Authority</td>
                <td colspan="2">
                    <asp:Label ID="lblapprovalauthority" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Company Name</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblcompanyname" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Subject & Scope</td>
                <td colspan="2">
                    <asp:Label ID="lblsubjectscope" runat="server" Text=""></asp:Label>
                </td>
                <td colspan="2"><strong>Department Name</strong></td>
                <td colspan="1">
                    <asp:Label ID="lbldepartmentname" runat="server" Text=""></asp:Label>
                </td>

            </tr>
            <tr>
                <td colspan="2">Project & Address</td>
                <td colspan="5">
                    <asp:Label ID="lblprojectnaddress" runat="server" Text=""></asp:Label></td>
                  <td colspan="2">Reason Of Amendment</td>
                <td colspan="2">
                    <asp:Label ID="lblReasonOfAmendment" runat="server" Text=""></asp:Label></td>

                <td>Planned award date as per project schedule:</td>
                <td colspan="2">
                    <asp:Label ID="lblplannedawardasperschedule" runat="server" Text=""></asp:Label></td>
                <td>Actual Date of award:</td>
                <td colspan="2">
                    <asp:Label ID="lblactualdateofaward" runat="server" Text=""></asp:Label></td>

            </tr>
            <tr>
                <td>Status</td>
                <td colspan="2">
                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label></td>
                
                </tr>
            <tr>
                <td>Delay in award: </td>
                <td>
                    <asp:Label ID="lbldelayinaward" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Saleable Area<small>(In Sq. Ft)</small></td>
                <td>
                    <asp:Label ID="lblsaleablearea" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Reason of Delay</td>
                <td colspan="2">
                    <asp:Label ID="lblreasonofdelay" runat="server" Text=""></asp:Label></td>


                <td colspan="3">Approve Budget<small>(inLacs)</small></td>
                <td>
                    <asp:Label ID="lblapprovebudget" runat="server" Text=""></asp:Label></td>
                <td>Already Awarded<small>(inLacs)</small></td>
                <td>
                    <asp:Label ID="lblalreadyawarded" runat="server" Text=""></asp:Label></td>

            </tr>
            <tr>
                <td colspan="3" style="background-color: #bfbfbf">Proposed Value of this award<small>(inLacs)</small></td>
                <td style="background-color: #bfbfbf">
                    <asp:Label ID="lblproposedvalueofthisaward" runat="server" Text=""></asp:Label></td>
                <td>Balance to be Award</td>
                <td>
                    <asp:Label ID="lblbalancetobeawarded" runat="server" Text=""></asp:Label></td>
                <td colspan="3" id="tdvariationfrombudgetName" runat="server">Variation From Budget</td>
                <td id="tdvariationfrombudgetvalue" runat="server">
                    <asp:Label ID="lblvariationfrombudget" runat="server" Text=""></asp:Label></td>

                <td colspan="3">Reason of Variation</td>
                <td>
                    <asp:Label ID="lblreasonofvariation" runat="server" Text=""></asp:Label></td>
                 <td><strong id="reasonofother" runat="server">Reason for Others</strong></td>
                <td colspan="3">
                    <asp:Label ID="lblreasonofother" runat="server" Text=""></asp:Label></td>


            </tr>
            <tr>
                <td colspan="2">Proposed Vendor Name</td>
                <td colspan="2">
                    <asp:Label ID="lblproposedvendorname" runat="server" Text=""></asp:Label></td>
                <td colspan="2" id="tdnegotiationmodeName" runat="server">Negotiation Mode</td>
                <td colspan="3" id="tdnegotiationmodeValue" runat="server">
                    <asp:Label ID="lblnegotiationmode" runat="server" Text=""></asp:Label></td>
                <td colspan="1">Commercial Rating</td>
                <td colspan="3">
                    <asp:Label ID="lblcommercialrating" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Stipulated Time Line</td>
                <td colspan="2">
                    <asp:Label ID="lblstipulatedtimelinebyvendor" runat="server" Text=""></asp:Label></td>




            </tr>
            <tr>
                <td colspan="4" class="text-center red" style="background-color: #00b0f0" id="tdindent" runat="server">
                    <asp:HyperLink ID="lnkIndentdownload" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Indent</asp:HyperLink>
                </td>
                <td colspan="4" class="text-center red" style="background-color: #00b0f0" id="tdbudgetapproval" runat="server">
                    <asp:HyperLink ID="lnkbudgetapproval" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Budget Approval</asp:HyperLink>
                </td>
                <td colspan="4" class="text-center red" style="background-color: #00b0f0" id="tddeliveryschedule" runat="server">
                    <asp:HyperLink ID="lnkdeliveryschedule" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false">Delivery Schedule</asp:HyperLink>
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

                            <asp:TemplateField HeaderText="Standard">
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
                <td colspan="11" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Evaluation</b></td>
            </tr>
            <tr style="border: 1px solid red" id="trbidevaluation" runat="server">
                <td colspan="12" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="lnkdownloadbidevaluation" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false"> Bid Evaluation Document</asp:HyperLink>
                </td>

            </tr>
            <tr>
                <td rowspan="3" style="vertical-align: middle"><b>Tendering Procedure</b></td>
                <td>Total Vendors Considered</td>
                <td>
                    <asp:Label ID="lbltotalvendorconsider" runat="server" Text=""></asp:Label></td>
                <td>Rejected Vendors as per P.Qual.</td>
                <td>
                    <asp:Label ID="lblrejectedvendorasperpqual" runat="server" Text=""></asp:Label></td>
                <td>RFQ invited</td>
                <td>
                    <asp:Label ID="lblrfqinvited" runat="server" Text=""></asp:Label></td>
                <td>Not quoted</td>
                <td>
                    <asp:Label ID="lblnotquoted" runat="server" Text=""></asp:Label></td>
                <td>Final Considered</td>
                <td>
                    <asp:Label ID="lblfinalconsidered" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>Stipulated Completion Time</td>
                <td colspan="2">
                    <asp:Label ID="lblstipulatedtimeline" runat="server" Text=""></asp:Label></td>
                <td style="border: 1px solid red">Bid Type:</td>
                <td style="border: 1px solid red" id="tdbidtype" runat="server">
                    <asp:Label ID="lblbidtype" runat="server" Text=""></asp:Label></td>

                <td>Contract Type:</td>
                <td>
                    <asp:Label ID="lblcontracttype" runat="server" Text=""></asp:Label></td>
                <td style="border: 1px solid red">Auction Type:</td>
                <td style="border: 1px solid red" id="tdauctiontype" runat="server" colspan="2">
                    <asp:Label ID="lblauctiontype" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>Reason</td>
                <td colspan="9">
                    <asp:Label ID="lblreason" CssClass="red" runat="server" Text=""></asp:Label></td>
            </tr>
        </table>
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Bid Evaluation</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvItemHead" runat="server" ShowFooter="true" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">

                        <Columns>
                            <asp:BoundField DataField="SNO" HeaderText="S.No." />
                            <asp:BoundField DataField="ItemHead" HeaderText="Major Item Heads" />
                            <asp:BoundField DataField="UOM" HeaderText="UOM" />                           
                            <asp:BoundField DataField="V1Rate" HeaderText="Vendor1 Rate" />                           
                            <asp:BoundField DataField="V2Rate" HeaderText="Vendor2 Rate" />                         
                            <asp:BoundField DataField="V3Rate" HeaderText="Vendor3 Rate" />
                          
                           <%-- <asp:BoundField DataField="BaseRate" HeaderText="Budgeted Base rate" />--%>
                            <asp:BoundField DataField="TargetCost" HeaderText="Target Cost" />
                            <asp:BoundField DataField="InHouseEstimatedCost" HeaderText="In House EstimatedCost" />
                        </Columns>

                        <EmptyDataTemplate>
                            No records found ...!
                        </EmptyDataTemplate>

                    </asp:GridView>
                </td>

            </tr>
            <tr>
                <td colspan="1" class="text-right">Vendors</td>
                <td colspan="2">
                    <asp:Label ID="lblvendor1" runat="server" ToolTip="Vendor 1 Name " CssClass="font-weight-bold" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblvendor2" runat="server" ToolTip="Vendor 2 Name " CssClass="font-weight-bold" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblvendor3" runat="server" ToolTip="Vendor 3 Name " CssClass="font-weight-bold" Text=""></asp:Label></td>

                <td colspan="5"></td>

            </tr>
              <tr>
                <td colspan="1" class="text-right">GST</td>

                <td colspan="2">
                    <asp:Label ID="lblV1GST" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV2GST" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV3GST" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
             <tr>
                <td colspan="1" class="text-right">Freight</td>

                <td colspan="2">
                    <asp:Label ID="lblV1Freight" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV2Freight" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV3Freight" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Other Charges</td>

                <td colspan="2">
                    <asp:Label ID="lblV1OtherCharges" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV2OtherCharges" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV3OtherCharges" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Grand Total</td>

                <td colspan="2">
                    <asp:Label ID="lblV1GrandTotal" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV2GrandTotal" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV3GrandTotal" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Delivery Timelines</td>

                <td colspan="2">
                    <asp:Label ID="lbldeliverytimelinev1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lbldeliverytimelinev2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lbldeliverytimelinev3" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Comparision with Estimated cost(%)</td>

                <td colspan="2" style="background-color: #92d050">
                    <asp:Label ID="lblcomparisionwithbudgetv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color: #ffff00">
                    <asp:Label ID="lblcomparisionwithbudgetv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color: #ff0000">
                    <asp:Label ID="lblcomparisionwithbudgetv3" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Bids Status</td>
                <td colspan="2" style="background-color: #92d050">
                    <asp:Label ID="lblbidstatusv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color: #ffff00">
                    <asp:Label ID="lblbidstatusv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color: #ff0000">
                    <asp:Label ID="lblbidstatusv3" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Vendor Ratings</td>
                <td colspan="2">
                    <asp:Label ID="lblvendorratingv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblvendorratingv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblvendorratingv3" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Award Preference</td>
                <td colspan="2">
                    <asp:Label ID="lblawardpreferencev1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblawardpreferencev2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblawardpreferencev3" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right" style="width: 350px">Cost/Sq. Ft.</td>
                <td colspan="2">
                    <asp:Label ID="lblcostsqftv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblcostsqftv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblcostsqftv3" runat="server" Text=""></asp:Label></td>

                <td colspan="5"></td>
            </tr>
            <tr style="border: 1px solid red" id="trdrawingdocument" runat="server">
                <td colspan="12" class="text-center red" style="background-color: #00b0f0">
                    <asp:HyperLink ID="lnkdrawingdocument" runat="server" CssClass="fa fa-download red font-weight-bold" Visible="false"> DRAWINGS Document</asp:HyperLink>
                </td>
            </tr>
        </table>
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red" style="background-color: #c0c0c0"><b>Deviation from Tender/ RFQ, if any</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvDeviationfromtender" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Standard Terms">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("StandardTerms").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deviation by Preference-1">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Preference1").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deviation by Preference-2">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Preference2").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Prevailing Markrt Practise">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("PrevailingMarkrtPractise").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <EmptyDataTemplate>
                            No records found ...!
                        </EmptyDataTemplate>

                    </asp:GridView>
            </tr>
            <tr>
                <td colspan="3">Recommendations with reasons</td>
                <td colspan="4">
                    <asp:Label ID="lblrecommadationwithreason" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Vendor Information</td>
                <td colspan="3">
                    <asp:Label ID="lblvendorinformation" runat="server" Text=""></asp:Label></td>
            </tr>

            <tr>
                <td colspan="3">Turnover last year</td>
                <td>
                    <asp:Label ID="lblturnoverlastyear" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Total orders with Co. till date</td>
                <td>
                    <asp:Label ID="lbltotalorderwithcompany" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Last order details with Co.</td>
                <td>
                    <asp:Label ID="lbllastorderdetail" runat="server" Text=""></asp:Label></td>

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
                                    <%# HttpUtility.HtmlDecode(Eval("UserName").ToString()) %>
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
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Terms & Condition</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvTermsandCondition" runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Terms">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Terms").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Standard Terms">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("StandardTerms").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deviations by Preference 1">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Preference1").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deviations by Preference 2">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Preference2").ToString()) %>
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

                    <asp:GridView ID="gvAttachment" OnRowCommand="gvAttachment_RowCommand"  runat="server" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

<%--                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Category").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocFile">
                                <ItemTemplate>
                                   <asp:LinkButton ID="lnkAdd" runat="server" Text='<%# Eval("DocFile") %>' CommandArgument='<%# Eval("ID") + "," + Eval("MLNID") + "," + Eval("DocFile")  %>' CommandName="Download" ToolTip="Download"></asp:LinkButton>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocImage">
                                <ItemTemplate>
                                   <asp:LinkButton ID="lnkDocImage" runat="server" Text='<%# Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("MLNID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" ToolTip="Download Image"></asp:LinkButton>
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
                <td class="text-center red" style="background-color: #c0c0c0"><b>Marketing Head</b></td>
                <td class="text-center red" style="background-color: #c0c0c0">Prepared By</td>
            </tr>
            <tr>
                <td rowspan="2">
                    <asp:TextBox ID="txtcontracthead" ReadOnly="true" runat="server" Rows="5" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="lblpreparedby" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblcreatedon" runat="server" Text=""></asp:Label>
                </td>
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

