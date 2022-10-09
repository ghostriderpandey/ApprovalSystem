<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="OldApprovalData.aspx.cs" Inherits="AdminPanel_Default2" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
        <ContentTemplate>
            <div class="row mt3">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Company</label>
                                        <asp:DropDownList ID="ddlCompany" runat="server" class="form-control dropdown selectcss"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Please Select Company" ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="ddlCompany" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Approval No</label>
                                        <asp:TextBox ID="txtapprovalno" runat="server" placeholder="Enter Approval No" class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please Enter Approval No." ValidationGroup="V" ForeColor="Red"
                                            ControlToValidate="txtapprovalno" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                              
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">&nbsp;</label>
                                        <br />
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="V" CssClass="btn btn-success" OnClick="btnSubmit_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                 <div class="col-sm-12">
                                    <div class="table-responsive">
                                       <b> Subject</b>
                                         <CKEditor:CKEditorControl Toolbar="Basic" ID="cksubject" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="table-responsive">
                                        <b>Approval Sought</b>
                                         <CKEditor:CKEditorControl Toolbar="Basic" ID="ckapprovalsought" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="table-responsive">
                                       <b> Payment Schedule</b>
                                         <CKEditor:CKEditorControl Toolbar="Basic" ID="ckpaymentschedule" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                                 <div class="col-sm-12">
                                    <div class="table-responsive">
                                        <b>Amendment Summary</b>
                                         <CKEditor:CKEditorControl Toolbar="Basic" ID="ckamendmentsummary" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                                 <div class="col-sm-12">
                                    <div class="table-responsive">
                                        <b>Contract Approval Status</b>
                                         <CKEditor:CKEditorControl Toolbar="Basic" ID="ckcontractapprovalstatus" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                                 <div class="col-sm-12">
                                    <div class="table-responsive">
                                        <b>Exception To Policy</b>
                                         <CKEditor:CKEditorControl Toolbar="Basic" ID="ckexceptiontopolicy" CssClass="form-control" runat="server" Height="150px"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

