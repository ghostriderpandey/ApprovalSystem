<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="MVPurchaseLogicNoteReportCommittee.aspx.cs" Inherits="AdminPanel_MVPurchaseLogicNoteReportCommittee" %>

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
                <td colspan="15" class="text-center red font-weight-bold" style="background-color: #c0c0c0;"><b>MultiVendor Logic Note</b></td>

            </tr>
            <tr style="border: 1px solid red">
                <td colspan="7" class="text-center red" style="background-color: #00b0f0" id="tdpriorapproval" runat="server">
                    <asp:HyperLink ID="hprprior" runat="server" Target="_blank" CssClass="fa fa-download red font-weight-bold" Visible="false">Prior Approvals</asp:HyperLink>
                    
                </td>
                <td colspan="8" class="text-center red" style="background-color: #00b0f0" id="tdlogicnote" runat="server">
                    <asp:HyperLink ID="hprlogicnote" runat="server" Target="_blank" CssClass="fa fa-download red font-weight-bold" Visible="false">Logic Note</asp:HyperLink>
                    
                </td>

            </tr>
            <tr>
                  <td colspan="2">Approval Type</td>
                <td colspan="2">
                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label></td>
                 <td colspan="2" ><strong id="Strong1" runat="server">Approval No</strong></td>
                <td colspan="2">
                    <asp:Label ID="Label2" Font-Bold="true" runat="server" Text=""></asp:Label></td>
                 <td colspan="2"><span id="spaNo" visible="false" runat="server">Amendment Approval No</span> </td>
                <td colspan="4">
                    <asp:Label ID="lblApprovalNo" Font-Bold="true" Visible="false" runat="server" Text=""></asp:Label></td>
                
            </tr>
            <tr>
                <td colspan="2"><strong>Approval Authority</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblapprovalauthority" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Company Name</strong></td>
                <td colspan="3">
                    <asp:Label ID="lblcompanyname" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong id="storderno" runat="server">OrderNo</strong></td>
                <td colspan="4">
                    <asp:Label ID="lblorderno" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="border: 1px solid red">
                
                <td colspan="2"><strong>Subject & Scope</strong></td>
                <td colspan="5">
                    <asp:Label ID="lblsubjectscope" runat="server" Text=""></asp:Label></td>
                 <td colspan="2">Department</td>
                <td colspan="6">
                    <asp:Label ID="lbldepartmentname" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2"><strong>Project & Address</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblprojectnaddress" runat="server" Text=""></asp:Label></td>
                <td colspan="2">Reason Of Amendment</td>
                <td colspan="2">
                    <asp:Label ID="lblReasonOfAmendment" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Indent Proponent</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblindentproponent" runat="server" Text=""></asp:Label></td>
                <td colspan="1"><strong>Date Of Indent</strong></td>
                <td colspan="2">
                    <asp:Label ID="lbldateofindent" runat="server" Text=""></asp:Label></td>
               
            </tr>
            <tr>
                <td colspan="2"><strong>Material Needed by: </strong></td>
                <td colspan="2">
                    <asp:Label ID="lblmaterialneededby" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Stock in Hand</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblstockinhand" runat="server" Text=""></asp:Label></td>
                 <td colspan="1"><strong>Requirement</strong></td>
                <td colspan="1">
                    <asp:Label ID="lblrequirement" runat="server" Text=""></asp:Label></td>
               <td colspan="2"><strong>Urgent Reason Description</strong></td>
               <td colspan="3">
                    <asp:Label ID="lblurgentdescription" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                
                <td colspan="2"><strong>Saleable Area<small>(In Sq. Ft)</small></strong></td>
                <td colspan="1">
                    <asp:Label ID="lblsaleablearea" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong><strong>Approve Budget<small>(inLacs)</small></strong></strong></td>
                <td colspan="1">
                    <asp:Label ID="lblapprovebudget" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Already Awarded<small>(inLacs)</small></strong></td>
                <td colspan="1">
                    <asp:Label ID="lblalreadyawarded" runat="server" Text=""></asp:Label></td>
                <td colspan="1" style="background-color: #bfbfbf"><strong>Proposed Value of this award<small>(inLacs)</small></strong></td>
                <td colspan="1" style="background-color: #bfbfbf">
                    <asp:Label ID="lblproposedvalueofthisaward" runat="server" Text=""></asp:Label></td>
                <td colspan="1"><strong>Balance to be Award</strong></td>
                <td colspan="1">
                    <asp:Label ID="lblbalancetobeawarded" runat="server" Text=""></asp:Label></td>
                <td colspan="1" id="tdvariationfrombudgetName" runat="server"><strong>Variation From Budget</strong></td>
                <td colspan="1" id="tdvariationfrombudgetvalue" runat="server">
                    <asp:Label ID="lblvariationfrombudget" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                
                

                 <td colspan="2"><strong>Reason of Variation</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblreasonofvariation" runat="server" Text=""></asp:Label></td>
                 <td colspan="2"><strong id="reasonofother" runat="server">Reason for Others</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblreasonofother" runat="server" Text=""></asp:Label></td>
                <td colspan="1"><strong>Proposed Vendor Name</strong></td>
                <td colspan="3">
                    <asp:Label ID="lblproposedvendorname" runat="server" Text=""></asp:Label></td>
                <td colspan="1" id="tdnegotiationmodeName" runat="server"><strong>Negotiation Mode</strong></td>
                <td colspan="2" id="tdnegotiationmodeValue" runat="server">
                    <asp:Label ID="lblnegotiationmode" runat="server" Text=""></asp:Label></td>

            </tr>
            <tr>
                
                <td colspan="2"><strong>Commercial Rating</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblcommercialrating" runat="server" Text=""></asp:Label></td>
                <td colspan="2"><strong>Stipulated Time Line</strong></td>
                <td colspan="2">
                    <asp:Label ID="lblstipulatedtimelinebyvendor" runat="server" Text=""></asp:Label></td>

                
            </tr>
             <tr>            
                <td colspan="3"><strong>Responsible Person</strong></td>
                <td colspan="3">
                    <asp:Label ID="lblresponsiblepersone" runat="server" Text=""></asp:Label></td>
                 <td colspan="3">Material Used By Date</td>
                <td colspan="2">
                    <asp:Label ID="lblmaterialusebydate" runat="server" Text=""></asp:Label></td>
                
                <td colspan="2">Place of Use</td>
                <td colspan="2">
                    <asp:Label ID="lblplaceofuse" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td colspan="5" class="text-center red" style="background-color: #00b0f0" id="tdindent" runat="server">
                    <asp:HyperLink ID="hprindent" runat="server" Target="_blank" CssClass="fa fa-download red font-weight-bold" Visible="false">Indent</asp:HyperLink>
                    
                </td>
                <td colspan="5" class="text-center red" style="background-color: #00b0f0" id="tdbudgetapproval" runat="server" >
                    <asp:HyperLink ID="hprbudgetapproval" runat="server" Target="_blank" CssClass="fa fa-download red font-weight-bold" Visible="false">Budget Approval</asp:HyperLink>
                    
                </td>
                <td colspan="5" class="text-center red" style="background-color: #00b0f0" id="tddeliveryschedule" runat="server">
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
                    <asp:HyperLink ID="hprbidevaluation" Target="_blank" CssClass="fa fa-download red font-weight-bold" runat="server" Visible="false">Bid Evaluation Document</asp:HyperLink>
                    
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
                <td>
                    <asp:Label ID="lblstipulatedtimeline" runat="server" Text=""></asp:Label></td>
                <td style="border: 1px solid red">Bid Type:</td>
                <td style="border: 1px solid red" id="tdbidtype" runat="server">
                    <asp:Label ID="lblbidtype" runat="server" Text=""></asp:Label></td>
                <td>Approval Type:</td>
                <td>
                    <asp:Label ID="lblapprovaltype" runat="server" Text=""></asp:Label></td>
                <td>Contractor Name</td>
                <td>
                    <asp:Label ID="lblcontractorname" runat="server" Text=""></asp:Label></td>
                <td style="border: 1px solid red">Auction Type:</td>
                <td style="border: 1px solid red" id="tdauctiontype" runat="server">
                    <asp:Label ID="lblauctiontype" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>Date of Ariba Auction</td>
                <td><asp:Label ID="lbldateofarbiaauction" runat="server" Text=""></asp:Label></td>
                <td>Reason</td>
                <td colspan="8">
                    <asp:Label ID="lblreason" CssClass="red" runat="server" Text=""></asp:Label></td>
            </tr>
        </table>
        <table class="table table-bordered table-responsive">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0"><b>Bid Evaluation</b></td>

            </tr>
            <tr>
                <td colspan="12">
                    <asp:GridView ID="gvItemHead" runat="server" ShowFooter="true" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">

                        <Columns>
                            <asp:BoundField DataField="SNO" HeaderText="S.No." />
                            <asp:BoundField DataField="ItemName" HeaderText="Major Item Heads" />
                            <asp:BoundField DataField="UOM" HeaderText="UOM" />
                            <asp:BoundField DataField="V1Quantity" HeaderText="V1Quantity" />
                            <asp:BoundField DataField="V1Rate" HeaderText="Vendor1 Rate" />
                            <asp:BoundField DataField="V1Value" HeaderText="Vendor1 Value" />
                            <asp:BoundField DataField="V2Quantity" HeaderText="V2Quantity" />
                            <asp:BoundField DataField="V2Rate" HeaderText="Vendor2 Rate" />
                            <asp:BoundField DataField="V2Value" HeaderText="Vendor2 Value" />
                             <asp:BoundField DataField="V3Quantity" HeaderText="V3Quantity" />
                            <asp:BoundField DataField="V3Rate" HeaderText="Vendor3 Rate" />
                            <asp:BoundField DataField="V3Value" HeaderText="Vendor3 Value" />
                             <asp:BoundField DataField="V4Quantity" HeaderText="V4Quantity" />
                             <asp:BoundField DataField="V4Rate" HeaderText="Vendor4 Rate" />
                            <asp:BoundField DataField="V4Value" HeaderText="Vendor4 Value" />
                            <asp:BoundField DataField="BaseRate" HeaderText="Budgeted Base rate" />
                            <asp:BoundField DataField="TargetCost" HeaderText="Target Cost" />
                            <asp:BoundField DataField="PreviousRate" HeaderText="Previous Rates" />
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

                 <td colspan="2">
                    <asp:Label ID="lblvendor4" runat="server" ToolTip="Vendor 4 Name " CssClass="font-weight-bold" Text=""></asp:Label></td>
                <td colspan="3"></td>

            </tr>
            <tr>
                <td colspan="1" class="text-right">Frieght</td>
                <td colspan="2">
                    <asp:Label ID="lblfrieghtv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblfrieghtv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblfrieghtv3" runat="server" Text=""></asp:Label></td>

                 <td colspan="2">
                    <asp:Label ID="lblfrieghtv4" runat="server" Text=""></asp:Label></td>

                <td colspan="3"></td>

            </tr>

            <tr>
                <td colspan="1" class="text-right">Handling/Insurance Charge</td>
                <td colspan="2">
                    <asp:Label ID="lblv1handling" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblv2handling" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblv3handling" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblv4handling" runat="server" Text=""></asp:Label></td>

                <td colspan="3"></td>

            </tr>
            <tr>
                <td colspan="1" class="text-right">Other Charge</td>
                <td colspan="2">
                    <asp:Label ID="lblV1OtherCharge" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV2OtherCharge" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV3OtherCharge" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblV4OtherCharge" runat="server" Text=""></asp:Label></td>

                <td colspan="3"></td>

            </tr>

            <tr>
                <td colspan="1" class="text-right">GST</td>
                <td colspan="2">
                    <asp:Label ID="lblgstv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblgstv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblgstv3" runat="server" Text=""></asp:Label></td>

                  <td colspan="2">
                    <asp:Label ID="lblgstv4" runat="server" Text=""></asp:Label></td>

                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Handling Charges</td>
                <td colspan="2">
                    <asp:Label ID="lblhandingchargesv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblhandingchargesv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblhandingchargesv3" runat="server" Text=""></asp:Label></td>

                 <td colspan="2">
                    <asp:Label ID="lblhandingchargesv4" runat="server" Text=""></asp:Label></td>

                <td colspan="3">
                    </td>
            </tr>
            <tr style="background-color:#bfbfbf">
                <td colspan="1" class="text-right">Grand Total</td>

                <td colspan="2">
                    <asp:Label ID="lblgrandtotalv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblgrandtotalv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblgrandtotalv3" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblgrandtotalv4" runat="server" Text=""></asp:Label></td>

                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Delivery Timelines</td>

                <td colspan="2">
                    <asp:Label ID="lbldeliverytimelinev1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lbldeliverytimelinev2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lbldeliverytimelinev3" runat="server" Text=""></asp:Label></td>

                 <td colspan="2">
                    <asp:Label ID="lbldeliverytimelinev4" runat="server" Text=""></asp:Label></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Comparision with Budgeted Rate(%)</td>

                <td colspan="2" style="background-color:#92d050">
                    <asp:Label ID="lblcomparisionwithbudgetv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color:#ffff00">
                    <asp:Label ID="lblcomparisionwithbudgetv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color:#ff0000">
                    <asp:Label ID="lblcomparisionwithbudgetv3" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color:#ff0000">
                    <asp:Label ID="lblcomparisionwithbudgetv4" runat="server" Text=""></asp:Label></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Bids Status</td>
                <td colspan="2" style="background-color:#92d050">
                    <asp:Label ID="lblbidstatusv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color:#ffff00">
                    <asp:Label ID="lblbidstatusv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2" style="background-color:#ff0000">
                    <asp:Label ID="lblbidstatusv3" runat="server" Text=""></asp:Label></td>

                 <td colspan="2" style="background-color:#ff0000">
                    <asp:Label ID="lblbidstatusv4" runat="server" Text=""></asp:Label></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Vendor Ratings</td>
                <td colspan="2">
                    <asp:Label ID="lblvendorratingv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblvendorratingv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblvendorratingv3" runat="server" Text=""></asp:Label></td>

                 <td colspan="2">
                    <asp:Label ID="lblvendorratingv4" runat="server" Text=""></asp:Label></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Award Preference</td>
                <td colspan="2">
                    <asp:Label ID="lblawardpreferencev1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblawardpreferencev2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblawardpreferencev3" runat="server" Text=""></asp:Label></td>

               <td colspan="2">
                    <asp:Label ID="lblawardpreferencev4" runat="server" Text=""></asp:Label></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="1" class="text-right">Cost/Sq. Ft.</td>
                <td colspan="2">
                    <asp:Label ID="lblcostsqftv1" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblcostsqftv2" runat="server" Text=""></asp:Label></td>

                <td colspan="2">
                    <asp:Label ID="lblcostsqftv3" runat="server" Text=""></asp:Label></td>

               <td colspan="2">
                    <asp:Label ID="lblcostsqftv4" runat="server" Text=""></asp:Label></td>
                <td colspan="3"></td>
            </tr>
            <tr style="border: 1px solid red" id="trdrawing" runat="server">
                <td colspan="12" class="text-center red" style="background-color: #00b0f0">
                    
                    <asp:HyperLink ID="hprdrawingdocument" Target="_blank" runat="server" CssClass="fa fa-download red" Visible="false"> DRAWINGS Document</asp:HyperLink>
                </td>
            </tr>
        </table>
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red font-weight-bold" style="background-color: #c0c0c0" ><b>Deviation from Tender/ RFQ, if any</b></td>

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
               <td colspan="5"></td>
            </tr>

          <tr>
                 <td colspan="1"><asp:Label ID="lblvendor1nameinfo" runat="server" CssClass="font-weight-bold" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblvendorinformation1" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Turnover last year</td>
                <td>
                    <asp:Label ID="lblturnoverlastyear1" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Total orders with Co. till date</td>
                <td>
                    <asp:Label ID="lbltotalorderwithcompany1" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Last order details with Co.</td>
                <td>
                    <asp:Label ID="lbllastorderdetail1" runat="server" Text=""></asp:Label></td>

            </tr>
            <tr>
                 <td colspan="1"><asp:Label ID="lblvendor2nameinfo" runat="server" CssClass="font-weight-bold" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblvendorinformation2" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Turnover last year</td>
                <td>
                    <asp:Label ID="lblturnoverlastyear2" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Total orders with Co. till date</td>
                <td>
                    <asp:Label ID="lbltotalorderwithcompany2" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Last order details with Co.</td>
                <td>
                    <asp:Label ID="lbllastorderdetail2" runat="server" Text=""></asp:Label></td>

            </tr>
             <tr>
                 <td colspan="1"><asp:Label ID="lblvendor3nameinfo" runat="server" CssClass="font-weight-bold" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblvendorinformation3" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Turnover last year</td>
                <td>
                    <asp:Label ID="lblturnoverlastyear3" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Total orders with Co. till date</td>
                <td>
                    <asp:Label ID="lbltotalorderwithcompany3" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Last order details with Co.</td>
                <td>
                    <asp:Label ID="lbllastorderdetail3" runat="server" Text=""></asp:Label></td>

            </tr>
             <tr>
                 <td colspan="1"><asp:Label ID="lblvendor4nameinfo" runat="server" CssClass="font-weight-bold" Text=""></asp:Label></td>
                <td colspan="2">
                    <asp:Label ID="lblvendorinformation4" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Turnover last year</td>
                <td>
                    <asp:Label ID="lblturnoverlastyear4" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Total orders with Co. till date</td>
                <td>
                    <asp:Label ID="lbltotalorderwithcompany4" runat="server" Text=""></asp:Label></td>
                <td colspan="3">Last order details with Co.</td>
                <td>
                    <asp:Label ID="lbllastorderdetail4" runat="server" Text=""></asp:Label></td>

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

                    <asp:GridView ID="gvAttachment" runat="server" OnRowCommand="gvAttachment_RowCommand" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Category").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocFile">
                                <ItemTemplate>
                                     <asp:LinkButton ID="lnkAdd" runat="server" Text='<%# Eval("Category") %>' CommandArgument='<%# Eval("ID") + "," + Eval("MVPLNID") + "," + Eval("DocFile")  %>' CommandName="Download" ToolTip="Download"></asp:LinkButton>
                                 <%--    <asp:HyperLink ID="HyperLink1" runat="server"  NavigateUrl='<%# "../Upload/PLN/"+ Eval("DocFile") %>' Text='<%# Eval("Category") %>'></asp:HyperLink>--%>
                                 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DocImage">
                                <ItemTemplate>
                                   <asp:LinkButton ID="lnkDocImage" runat="server" Text='<%# Eval("DocImage") %>' CommandArgument='<%# Eval("ID") + "," + Eval("MVPLNID") + "," + Eval("DocImage")  %>' CommandName="DownloadImage" ToolTip="Download Image"></asp:LinkButton>
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
                <td class="text-center red" style="background-color: #c0c0c0"><b>Creator Remark</b></td>              
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtcreatorremark" ReadOnly="true" runat="server" Rows="5" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                </td>
               
            </tr>
            
        </table>
        <table class="table table-bordered">
            <tr>
                <td class="text-center red" style="background-color: #c0c0c0"><b>Purchase Head</b></td>
                <td class="text-center red" style="background-color: #c0c0c0">Prepared By</td>
            </tr>
            <tr>
                <td rowspan="2">
                    <asp:TextBox ID="txtpurchasehead" ReadOnly="true" runat="server" Rows="5" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
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
                 <td><asp:TextBox ID="txtremark" runat="server" TextMode="MultiLine" CssClass="form-control" ValidationGroup="V"></asp:TextBox></td>
                 <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter remark" ControlToValidate="txtremark"></asp:RequiredFieldValidator>--%>
             </tr>
             </table>
        <table class="table table-bordered">
            <tr>
                <td colspan="12" class="text-center red">
                    <asp:Button ID="btnapprove" runat="server" CssClass="btn btn-primary" Text="Approve" OnClick="btnapprove_Click"/>
                    <asp:Button ID="btnreject" runat="server" CssClass="btn btn-primary" Text="Reject" ValidationGroup="V" OnClick="btnreject_Click" OnClientClick="return confirm('Are you sure, you want to reject.?');"/>
                    <asp:Button ID="btnprint" runat="server" Text="Print" CssClass="btn btn-primary" OnClick="btnprint_Click" />
                    <%--<asp:Button ID="btnback" runat="server" Text="Back" CssClass="btn btn-primary" />--%></td>
            </tr>

        </table>


    </div>
</asp:Content>



