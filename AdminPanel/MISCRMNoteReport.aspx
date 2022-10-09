<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="MISCRMNoteReport.aspx.cs" Inherits="AdminPanel_MISCRMNoteReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript" src='../build/js/bootstrap.min.js'></script>
<link rel="stylesheet" href='../build/css/bootstrap.min.css' media="screen" />

    <script src="datatables/dataTables.buttons.min.js"></script>
    <script src="datatables/buttons.bootstrap4.min.js"></script>
    <script src="datatables/jszip.min.js"></script>
    <script src="datatables/pdfmake.min.js"></script>
    <script src="datatables/vfs_fonts.js"></script>
    <script src="datatables/buttons.html5.min.js"></script>
    <script src="datatables/buttons.print.min.js"></script>
    <script src="datatables/buttons.colVis.min.js"></script>

    <style>
        .dataTables_length {
            width: 14% !important;
            float: left;
        }
        .btn-secondary {
            color: #fff;
            background-color: #fff;
            border-color: #6c757d;
            padding: 2px 11px !important;
        }
            .btn-secondary:hover {
                color: #fff;
                background-color: #fff;
                border-color: #6c757d;
                padding: 2px 11px !important;
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
        $('#<%= gvMISCRMNoteReport.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvMISCRMNoteReport.ClientID%>").find("tr:first"))).DataTable({
            stateSave: true,
            "dom": 'Blfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {
                        columns: ':visible'
                    },
                    text: '<i class="fa fa-file-excel-o text-success"></i>',
                    titleAttr: 'Excel',
                    title: 'MISCRMNoteReport'
                }
                //,
                //{
                //    extend: 'pdfHtml5',
                //    exportOptions: {
                //        columns: ':visible'
                //    },
                //    text: '<i class="fa fa-file-pdf-o text-success"></i>',
                //    titleAttr: 'pdf',
                //    title: 'MISCRMNoteReport'
                //}
            ]
        });
    }
</script>
<style>
    @media (min-width:556px) {
        .modal-dialog {
            max-width: 100% !important;
        }
    }
</style>
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
    <div class="row">
        <div class="col-xl-12">
            <div class="card">
                <div class="card-body">
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
                                <asp:Button ID="btnFilter" runat="server" Text="Filter" ValidationGroup="V" CssClass="btn btn-success w-100" OnClick="btnFilter_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top:10px">
                        <div class="col-sm-12">
                            <div class="card-body">
                                <div class="">
                                    <asp:GridView ID="gvMISCRMNoteReport" runat="server" AutoGenerateColumns="False" CssClass="table table-responsive table-responsive">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No.">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#Container.DataItemIndex + 1%>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CRMOrderNo" HeaderText="Logic Note Approval No." />
                                            <asp:BoundField DataField="ApprovalType" HeaderText="Type" />
                                            <asp:BoundField DataField="committeeName" HeaderText="Approval Authority" />
                                            <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                                            <asp:BoundField DataField="ProjectName" HeaderText="Project" />
                                            <asp:BoundField DataField="SubjectandScope" HeaderText="Subject and Scope" />
                                            <asp:BoundField DataField="DepartmentName" HeaderText="Department Name" />
                                            <asp:BoundField DataField="CustomerName" HeaderText="Customer/Client Name" />                                            
                                            <asp:BoundField DataField="ApprovalSought" HeaderText="Approval Sought" HtmlEncode="false" />
                                            <asp:BoundField DataField="ChannelPartnerName" HeaderText="Channel Partner Name" />
                                            <asp:BoundField DataField="UnitNo" HeaderText="Unit No" />
                                            <asp:BoundField DataField="OldUnitNo" HeaderText="Old Unit No" />
                                            <asp:BoundField DataField="SuperArea" HeaderText="Super Area" />
                                            <asp:BoundField DataField="BSP" HeaderText="BSP(Rs./Sqft)" />
                                            <asp:BoundField DataField="PLC" HeaderText="PLC(Rs./Sqft)" />
                                            <asp:BoundField DataField="EDC_IDC" HeaderText="EDC/IDC(Rs./Sqft)" />
                                            <asp:BoundField DataField="EIC" HeaderText="EIC(Rs./Sqft)" />
                                            <asp:BoundField DataField="CarParking" HeaderText="Car Parking" />
                                            <asp:BoundField DataField="TCV" HeaderText="TCV" />
                                            <asp:BoundField DataField="PossessionCharges" HeaderText="Possession Charge(Rs./Sqft)" />
                                            <asp:BoundField DataField="OtherCharges" HeaderText="Other Charge(Rs./Sqft)" />
                                            <asp:BoundField DataField="CreatedBy" HeaderText="Created By" />
                                            <asp:BoundField DataField="AddDate" HeaderText="Created On" />
                                            <asp:BoundField DataField="ApprovedDate" HeaderText="Approved On" />
                                            <asp:BoundField DataField="IsApproved" HeaderText="Status" />
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
                    <button type="button" class="btn btn-danger" onclick="fnn();" data-dismiss="modal">
                        Close</button>
                </div>
            </div> 
        </div>
    </div>
</asp:Content>