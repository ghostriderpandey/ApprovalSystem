<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="ListViewApproveMiscellaneousLogicNote.aspx.cs" Inherits="AdminPanel_ListViewApproveMiscellaneousLogicNote" %>


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
                                                    <asp:ListItem Selected="True" Value="1">Approved</asp:ListItem>
                                                    <asp:ListItem Value="2">Pending</asp:ListItem>
                                                   
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-5">
                                            <div class="form-group filetbtn">
                                                <label for="exampleInputEmail1" class="font-weight-bold">&nbsp;</label>
                                                <br />
                                                <asp:Button ID="btnFilter" runat="server" Text="Filter" ValidationGroup="V" CssClass=" w-100 btn btn-success" OnClick="btnFilter_Click" />
                                            </div>
                                        </div>
                                        </div>

                                <div class="w-100">
                                    <asp:GridView ID="gvUser" runat="server" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" AutoGenerateColumns="False" CssClass="table table-responsive table-responsive" OnRowCommand="gvUser_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#Container.DataItemIndex + 1%>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="MSLNOrderNo" HeaderText="SerialCode" />
                                            <asp:BoundField DataField="ApprovalType" HeaderText="Approval Type" />
                                            <asp:BoundField DataField="ApprovalAuthrity" HeaderText="Approval Authority" />
                                              <asp:BoundField DataField="VendorName" HeaderText="Name of Proposed Vendor" />  
                                            <asp:BoundField DataField="SubjectandScope" HeaderText="Subject and Scope" />
                                            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" />
                                           
                                            <asp:BoundField DataField="CreatedBy" HeaderText="Created By" />
                                            <asp:BoundField DataField="AddDate" HeaderText="Created On" />
                                            <asp:TemplateField HeaderText="Approval Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApproveStatus" runat="server" Text='<%#Eval("ApprovalStatus") %>' />                                                 
                                                    <a  data-toggle="modal" data-target="#MyPopup" title="View this record" onclick="getApprover('<%#Eval("MSLNID") %>')"> <i class="fa fa-search"></i></a>
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
                                                    <a href="MiscellaneousLogicNoteReport.aspx?Con=View&id=<%#Eval("MSLNID") %>&AID=<%#Eval("ID") %>" title="Click to view" class="fa fa-eye  "></a>
                                                    <asp:LinkButton ID="lnkView" ToolTip="Click to view PDF..!" runat="server" CommandName="View" CssClass="fa fa-search" CommandArgument='<%#Eval("MSLNID") %>'><%--<img src="Icons/view_16x16.png" />--%></asp:LinkButton>
                                                    
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
                </div>
                <div class="modal-body">
                    <div class="table-responsive" style="height: 50vh; overflow-y: auto;">
                       
                        <table class="table table-bordered" id="tblApprovar">
                            <thead>
                                <tr>
                                    <th>SNo</th>
                                    <th>Approver Name</th>
                                    <th>Submission Date</th>
                                    <th>Approval Status</th>
                                    <th>Approval Date</th>
                                    <th>Remark</th>
                                </tr>
                            </thead>
                            <tbody id="aptbody">                               
                            </tbody>
                        </table>
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

    <script type="text/javascript">
        function getApprover(id) {
            $("#aptbody").html("");
            var postData = {};
            postData.id = id;
            $.ajax({
                type: "POST",
                url: "ListApproveMiscellaneousLogicNote.aspx/getApprover",
                data: JSON.stringify(postData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }
        function OnSuccess(response) {  
            
            var i = 1;
            var str = "";
            var approvers = response.d;
            $(approvers).each(function () {
                str = "<tr>";
                str += "<td>" + i.toString() + "</td>";
                str += "<td>" + this.ApproverName + "</td>";
                str += "<td>" + this.SubmissionDate + "</td>";
                str += "<td>" + this.ApprovalStatus + "</td>";
                str += "<td>" + this.ApprovalDate + "</td>";
                str += "<td>" + this.Remark + "</td>";
                str += "</tr>";               
                i = i + 1;
            });
            $("#aptbody").append(str);
        }
    </script>
    <%--      
        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

