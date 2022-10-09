<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/AdminPanel.master" AutoEventWireup="true" CodeFile="CommitteeLevelMaster.aspx.cs" Inherits="AdminPanel_CommitteeLevelMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function SureDelete() {
            return confirm("Are you sure to Delete ?");
        };
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 46 || charCode > 57))
                return false;
            return true;
        }
    </script>
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
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Committee Name</label>
                                        <asp:DropDownList ID="ddlCommitteeName" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCommitteeName_SelectedIndexChanged"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" runat="server" ErrorMessage="Please Select Committee Name" ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlCommitteeName"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">Level of Committee</label>
                                        <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control selectpicker" data-live-search="true" AutoPostBack="true" OnSelectedIndexChanged="ddlLevel_SelectedIndexChanged">
                                            <asp:ListItem Value="0">Select One</asp:ListItem>
                                            <asp:ListItem Value="1">Level - 1</asp:ListItem>
                                            <asp:ListItem Value="2">Level - 2</asp:ListItem>
                                            <asp:ListItem Value="3">Level - 3</asp:ListItem>
                                            <asp:ListItem Value="4">Level - 4</asp:ListItem>
                                            <asp:ListItem Value="5">Level - 5</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ErrorMessage="Please Select Level of committee" ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlLevel" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="font-weight-bold">No of Approval Required</label>
                                        <asp:DropDownList ID="ddlApprovalRequired" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please Select No of Approval Required" ValidationGroup="V" Display="Dynamic" ControlToValidate="ddlApprovalRequired" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="col-sm-12">
                                        <asp:GridView ID="grdCommitteeDetails" runat="server" AutoGenerateColumns="False"
                                            class="table table-bordered table-hover" OnRowDataBound="grdCommitteeDetails_RowDataBound" OnRowCommand="grdCommitteeDetails_RowCommand" OnRowDeleting="grdCommitteeDetails_RowDeleting" OnPreRender="grdCommitteeDetails_PreRender">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo">
                                                    <ItemTemplate>
                                                        <%--<%#Container.DataItemIndex+1 %>--%>
                                                        <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("ID") %>' />
                                                        <asp:HiddenField ID="hddUserID" runat="server" Value='<%#Eval("UserID") %>' />
                                                        <asp:LinkButton ID="lnkAdd" runat="server" Visible="false" CommandName="Add" ToolTip="Add New Record"><img src="Icons/addicon.png" /></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="User">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlUser" runat="server" class="form-control"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvPrice" ControlToValidate="ddlUser" ValidationGroup="V" runat="server" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="IsMandatory">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkMandatory" Checked='<%#Eval("IsMandatory") %>' runat="server" ></asp:CheckBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-primary fa fa-trash" OnClientClick="return SureDelete();" CommandArgument='<%#Eval("ID") %>' ToolTip="Delete Commission Slep"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                    <div class="form-group">
                                        <br />
                                        <label for="exampleInputEmail1" class="font-weight-bold">&nbsp</label>
                                        <asp:Button ID="btnsave" runat="server" Text="Submit" ValidationGroup="V" CssClass="btn btn-success" OnClick="btnsave_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-success" OnClick="btnReset_Click" />
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

