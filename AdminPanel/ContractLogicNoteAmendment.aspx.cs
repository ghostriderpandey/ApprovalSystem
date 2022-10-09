using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;
using System.Transactions;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.Drawing;

public partial class AdminPanel_ContractLogicNoteAmendment : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    DataTable dtUser = new DataTable();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }

        txtvariationfrombudget.Attributes.Add("readonly", "readonly");
        txtvariationprevsamendment.Attributes.Add("readonly", "readonly");
        txtvariationorignalvsthisamendment.Attributes.Add("readonly", "readonly");
        txtThisCostPerSqft.Attributes.Add("readonly", "readonly");
        txtPreviousCostPerSqft.Attributes.Add("readonly", "readonly");
        if (!IsPostBack)
        {
            //cls.BindDropDownList(ddloriginalContractordernumber, "EXEC sp_ManageContractLogicNote 'GetAllSerialforddl'", "CLNOrderNo", "CLNOrderNo");
            cls.BindDropDownList(ddlDepartment, "EXEC sp_DepartmentMaster 'GetAllforddl'", "DepartmentName", "ID");
            cls.BindDropDownList(ddlapprovalauthrity, "EXEC sp_CommitteeMaster 'GetAllforddl'", "CommitteeName", "ID");
            cls.BindDropDownList(ddlprojectname, "EXEC sp_ProjectMaster 'GetAllforddl'", "ProjectName", "ID");
            ddlprojectname_SelectedIndexChanged(null, null);
            if (Request.QueryString["ID"] != null)
            {
                FillData(int.Parse(Request.QueryString["ID"].ToString()));
            }
            else
            {
                FillDt("0");
                FillDtIH("0");
                FillDtApprover("0");
                FillDtAttachment("0");
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);
            }

        }
        else
        {
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);
        }
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "fillVariationofBudget();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillPrevsThis", "fillPrevsThis();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillOrivsThis", "fillOrivsThis();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ddlChange", "ddlChange();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);
    }
    private void FillData(int id)
    {
        dtData = cls.selectDataTable("EXEC sp_ManageContractAmendmentNote 'GetByID','" + id.ToString() + "'");
        if (dtData.Rows.Count > 0)
        {
            if (dtData.Rows[0]["IsSubmitted"].ToString().ToUpper() == "TRUE" && Request.QueryString["ID"] != null)
            {
                btnSubmit.Enabled = false;
                btnSubmitforApproval.Enabled = false;
            }
            txtoriginalContractordernumber.Text = dtData.Rows[0]["ContractOrderNo"].ToString();
            ddlapprovalauthrity.SelectedValue = dtData.Rows[0]["ApprovalAuthrityID"].ToString();
            txtSubjectScope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
            ddlprojectname.SelectedValue = dtData.Rows[0]["ProjectID"].ToString();
            ddlprojectname_SelectedIndexChanged(null, null);
            ddllocation.SelectedValue = dtData.Rows[0]["LocationID"].ToString();
            hddlocationId.Value = dtData.Rows[0]["LocationID"].ToString();
            ddlDepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
            txtSaleableArea.Text = dtData.Rows[0]["SaleableArea"].ToString();
            txtApprovalBudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
            txtAlreadyaward.Text = dtData.Rows[0]["AlreadyAward"].ToString();
            txtBalancetobeaward.Text = dtData.Rows[0]["BalanceAward"].ToString();
            txtRevisedvalueasperthisamend.Text = dtData.Rows[0]["RevisedValue"].ToString();
            txtvariationfrombudget.Text = dtData.Rows[0]["Variationfombudget"].ToString();
            ddlReasonofvariation.SelectedValue = dtData.Rows[0]["Reasonofvariation"].ToString();
            txtothers.Text = dtData.Rows[0]["OtherDescription"].ToString();
            txtmenstionnameofContractor.Text = dtData.Rows[0]["ContractorName"].ToString();
            txtcostasperoriginalaward.Text = dtData.Rows[0]["OriginalAward"].ToString();
            txtRevisedcostasperPreviousamendment.Text = dtData.Rows[0]["RevCostasperPrevious"].ToString();
            txtrevisedcostasperthisamendment.Text = dtData.Rows[0]["RevCostasperThis"].ToString();
            txtvariationprevsamendment.Text = dtData.Rows[0]["VariationPreviousvsThis"].ToString();
            txtvariationorignalvsthisamendment.Text = dtData.Rows[0]["VariationOriginalvsThis"].ToString();
            txtreccomandationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();
            txtPreviousCostPerSqft.Text = dtData.Rows[0]["PreviousCostPerSqft"].ToString();
            txtThisCostPerSqft.Text = dtData.Rows[0]["ThisCostPerSqft"].ToString();
            // fillVariationofBudget();
        }
        FillDt(id.ToString());
        FillDtIH(id.ToString());
        FillDtApprover(id.ToString());
        FillDtAttachment(id.ToString());
    }
    protected void gvStandardexception_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNew();
        }

        if (e.CommandName == "Delete")
        {
            SetData();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtDetailsSE"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsSE"] = dtData;
                gvStandardexception.DataSource = dtData;
                gvStandardexception.DataBind();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_ManageContractAmendmentNote 'DeleteCANMajorDeviation','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsSE"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsSE"] = dtData;
                gvStandardexception.DataSource = dtData;
                gvStandardexception.DataBind();
            }
        }
    }
    protected void gvStandardexception_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvStandardexception_PreRender(object sender, EventArgs e)
    {
        int count = gvStandardexception.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = gvStandardexception.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = gvStandardexception.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }
    protected void gvStandardexception_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtrecommendation = (e.Row.FindControl("txtrecommendation") as TextBox);
            HiddenField hddRecommendation = (e.Row.FindControl("hddRecommendation") as HiddenField);
            txtrecommendation.Text = hddRecommendation.Value;
        }
    }
    private void AddNew()
    {
        if (ViewState["dtDetailsSE"] != null)
        {
            SetData();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["Standard"] = "";
            dr["Excepetion"] = "";
            dr["Recommendation"] = "";
            dt.Rows.Add(dr);

            ViewState["dtDetailsSE"] = dt;
            gvStandardexception.DataSource = dt;
            gvStandardexception.DataBind();
        }
        else
        {
            FillDt("0");
            AddNew();
        }
    }
    private void SetData()
    {
        if (ViewState["dtDetailsSE"] != null)
        {
            int rowindex = 0;
            DataTable dtData = (DataTable)ViewState["dtDetailsSE"];
            dt = dtData.Clone();
            DataRow dr;
            if (dtData.Rows.Count > 0)
            {
                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    HiddenField hddSEID = (HiddenField)gvStandardexception.Rows[rowindex].Cells[0].FindControl("hddSEID");
                    CKEditor.NET.CKEditorControl ckStandrad = (CKEditor.NET.CKEditorControl)gvStandardexception.Rows[rowindex].Cells[1].FindControl("ckStandrad");
                    CKEditor.NET.CKEditorControl ckExcepetion = (CKEditor.NET.CKEditorControl)gvStandardexception.Rows[rowindex].Cells[2].FindControl("ckExcepetion");
                    TextBox txtrecommendation = (TextBox)gvStandardexception.Rows[rowindex].Cells[3].FindControl("txtrecommendation");
                    dr = dt.NewRow();
                    dr["ID"] = hddSEID.Value;
                    dr["Standard"] = ckStandrad.Text;
                    dr["Excepetion"] = ckExcepetion.Text;
                    dr["Recommendation"] = txtrecommendation.Text;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetailsSE"] = dt;
                gvStandardexception.DataSource = dt;
                gvStandardexception.DataBind();
            }
        }
    }
    private void FillDt(string ID)
    {
        SetData();
        DataTable dtData = cls.selectDataTable("select ID,Standard,Excepetion,Recommendation from tbl_CANMajorDeviation where IsDelete=0 and CANID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsSE"] = dtData;
        }
        else
        {
            ViewState["dtDetailsSE"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("Standard");
            dt.Columns.Add("Excepetion");
            dt.Columns.Add("Recommendation");
            ViewState["dtDetailsSE"] = dt;
        }

        dt = (DataTable)ViewState["dtDetailsSE"];
        if (dt.Rows.Count == 0)
        {
            AddNew();
        }
        gvStandardexception.DataSource = dt;
        gvStandardexception.DataBind();
    }

    protected void gvItemHead_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNewIH();
        }
        else if (e.CommandName == "Delete")
        {
            SetDataIH();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtDetailsIH"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsIH"] = dtData;
                gvItemHead.DataSource = dtData;
                gvItemHead.DataBind();
                CalIHTotal();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_ManageContractAmendmentNote 'DeleteCANBidEvaluation','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsIH"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsIH"] = dtData;
                gvItemHead.DataSource = dtData;
                gvItemHead.DataBind();
                CalIHTotal();
            }
        }
        else if (e.CommandName == "Calculate")
        {
            SetDataIH();
        }
    }
    protected void gvItemHead_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvItemHead_PreRender(object sender, EventArgs e)
    {
        int count = gvItemHead.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = gvItemHead.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = gvItemHead.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }
    protected void gvItemHead_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlItemHead = (e.Row.FindControl("ddlItemHead") as DropDownList);
            HiddenField hddItemHead = (e.Row.FindControl("hddItemHead") as HiddenField);
            ddlItemHead.SelectedValue = hddItemHead.Value;
        }
    }
    private void AddNewIH()
    {
        if (ViewState["dtDetailsIH"] != null)
        {
            SetDataIH();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["ItemHead"] = "";
            dr["ItemName"] = "";
            dr["PreviousAmend"] = "0";
            dr["ThisAmend"] = "0";
            dr["Variation"] = "0";
            dr["Reason"] = "";
            dr["ResponsiblePerson"] = "";
            dt.Rows.Add(dr);

            ViewState["dtDetailsIH"] = dt;
            gvItemHead.DataSource = dt;
            gvItemHead.DataBind();
            CalIHTotal();
        }
        else
        {
            FillDtIH("0");
            AddNewIH();
        }
    }
    private void SetDataIH()
    {
        if (ViewState["dtDetailsIH"] != null)
        {
            int rowindex = 0;
            DataTable dtData = (DataTable)ViewState["dtDetailsIH"];
            dt = dtData.Clone();
            DataRow dr;
            if (dtData.Rows.Count > 0)
            {
                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    HiddenField hddIHID = (HiddenField)gvItemHead.Rows[rowindex].FindControl("hddIHID");
                    DropDownList ddlItemHead = (DropDownList)gvItemHead.Rows[rowindex].FindControl("ddlItemHead");
                    TextBox txtItemName = (TextBox)gvItemHead.Rows[rowindex].FindControl("txtItemName");
                    TextBox txtPreviousAmend = (TextBox)gvItemHead.Rows[rowindex].FindControl("txtPreviousAmend");
                    TextBox txtThisAmend = (TextBox)gvItemHead.Rows[rowindex].FindControl("txtThisAmend");
                    TextBox txtVariation = (TextBox)gvItemHead.Rows[rowindex].FindControl("txtVariation");
                    TextBox txtReason = (TextBox)gvItemHead.Rows[rowindex].FindControl("txtReason");
                    TextBox txtResponsiblePerson = (TextBox)gvItemHead.Rows[rowindex].FindControl("txtResponsiblePerson");
                    dr = dt.NewRow();
                    dr["ID"] = hddIHID.Value;
                    dr["ItemHead"] = ddlItemHead.SelectedValue;
                    dr["ItemName"] = txtItemName.Text;
                    dr["PreviousAmend"] = txtPreviousAmend.Text;
                    dr["ThisAmend"] = txtThisAmend.Text;
                    dr["Variation"] = txtVariation.Text;
                    dr["Reason"] = txtReason.Text;
                    dr["ResponsiblePerson"] = txtResponsiblePerson.Text;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetailsIH"] = dt;
                gvItemHead.DataSource = dt;
                gvItemHead.DataBind();
                CalIHTotal();
            }
        }
    }
    private void FillDtIH(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,ItemHead,ItemName,PreviousAmend,ThisAmend,Variation,Reason,ResponsiblePerson from tbl_CANBidEvaluation where IsDelete=0 and CANID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsIH"] = dtData;
        }
        else
        {
            ViewState["dtDetailsIH"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("ItemHead");
            dt.Columns.Add("ItemName");
            dt.Columns.Add("PreviousAmend", typeof(decimal));
            dt.Columns.Add("ThisAmend", typeof(decimal));
            dt.Columns.Add("Variation", typeof(decimal));
            dt.Columns.Add("Reason");
            dt.Columns.Add("ResponsiblePerson");
            ViewState["dtDetailsIH"] = dt;
        }

        dt = (DataTable)ViewState["dtDetailsIH"];
        if (dt.Rows.Count == 0)
        {
            AddNewIH();
        }
        gvItemHead.DataSource = dt;
        gvItemHead.DataBind();
        CalIHTotal();
    }
    private void CalIHTotal()
    {
        DataTable dt = new DataTable();
        dt = (DataTable)gvItemHead.DataSource;
        gvItemHead.FooterRow.Font.Bold = true;
        gvItemHead.FooterRow.Cells[3].Text = "Total";
        gvItemHead.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;
        decimal dblPreviousAmend = 0;
        decimal dblThisAmend = 0;
        decimal dblVariation = 0;
        dblPreviousAmend = dt.AsEnumerable().Sum(row => row.Field<decimal>("PreviousAmend"));
        dblThisAmend = dt.AsEnumerable().Sum(row => row.Field<decimal>("ThisAmend"));
        dblVariation = dt.AsEnumerable().Sum(row => row.Field<decimal>("Variation"));

        gvItemHead.FooterRow.Cells[4].Text = dblPreviousAmend.ToString();
        gvItemHead.FooterRow.Cells[5].Text = dblThisAmend.ToString();
        gvItemHead.FooterRow.Cells[6].Text = dblVariation.ToString();
        CalCostPersqft();
    }

    protected void gvApprover_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            if (ViewState["dtDetailsApprover"] != null)
            {
                SetDataApprover();
                dt = (DataTable)ViewState["dtDetailsApprover"];
                if (dt.Rows.Count > 0)
                {
                    if (int.Parse(dt.Rows[dt.Rows.Count - 1]["ApproverID"].ToString()) > 0)
                    {
                        AddNewApprover();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Select approver first!')", true);
                    }
                }
                else
                {
                    AddNewApprover();
                }
            }
            else
            {
                AddNewApprover();
            }
        }
        if (e.CommandName == "Delete")
        {
            SetDataApprover();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtDetailsApprover"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsApprover"] = dtData;
                gvApprover.DataSource = dtData;
                gvApprover.DataBind();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_ManageContractAmendmentNote 'DeleteCANApprover','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsApprover"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsApprover"] = dtData;
                gvApprover.DataSource = dtData;
                gvApprover.DataBind();
            }
        }
    }
    protected void gvApprover_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvApprover_PreRender(object sender, EventArgs e)
    {
        int count = gvApprover.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = gvApprover.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = gvApprover.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }
    protected void gvApprover_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlApprover = (e.Row.FindControl("ddlApprover") as DropDownList);
            HiddenField hddApprover = (e.Row.FindControl("hddApprover") as HiddenField);
            cls.BindDropDownList(ddlApprover, "EXEC sp_UserMaster 'GetAllforddl'", "UserName", "ID");
            ddlApprover.SelectedValue = hddApprover.Value;
        }
    }
    private void AddNewApprover()
    {
        if (ViewState["dtDetailsApprover"] != null)
        {
            SetDataApprover();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["ApproverID"] = "0";
            dt.Rows.Add(dr);

            ViewState["dtDetailsApprover"] = dt;
            gvApprover.DataSource = dt;
            gvApprover.DataBind();
        }
        else
        {
            FillDtApprover("0");
            AddNewApprover();
        }
    }
    private void SetDataApprover()
    {
        if (ViewState["dtDetailsApprover"] != null)
        {
            int rowindex = 0;
            DataTable dtData = (DataTable)ViewState["dtDetailsApprover"];
            dt = dtData.Clone();
            DataRow dr;
            if (dtData.Rows.Count > 0)
            {
                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    HiddenField hddAID = (HiddenField)gvApprover.Rows[rowindex].Cells[0].FindControl("hddAID");
                    DropDownList ddlApprover = (DropDownList)gvApprover.Rows[rowindex].Cells[1].FindControl("ddlApprover");

                    dr = dt.NewRow();
                    dr["ID"] = hddAID.Value;
                    dr["ApproverID"] = ddlApprover.SelectedValue;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetailsApprover"] = dt;
                gvApprover.DataSource = dt;
                gvApprover.DataBind();
            }
        }
    }
    private void FillDtApprover(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,ApproverID from tbl_CANApprover where IsDelete=0 and CANID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsApprover"] = dtData;
        }
        else
        {
            ViewState["dtDetailsApprover"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("ApproverID");
            ViewState["dtDetailsApprover"] = dt;
        }

        dt = (DataTable)ViewState["dtDetailsApprover"];
        if (dt.Rows.Count == 0)
        {
            AddNewApprover();
        }
        gvApprover.DataSource = dt;
        gvApprover.DataBind();
    }

    protected void gvAttachment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNewAttachment();
        }

        if (e.CommandName == "Delete")
        {
            SetDataAttachment();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtDetailsAttachment"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsAttachment"] = dtData;
                gvAttachment.DataSource = dtData;
                gvAttachment.DataBind();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_ManageContractAmendmentNote 'DeleteCANAttachment','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsAttachment"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsAttachment"] = dtData;
                gvAttachment.DataSource = dtData;
                gvAttachment.DataBind();
            }
        }
        if (e.CommandName == "Download")
        {
            string[] commandArguments = e.CommandArgument.ToString().Split(',');
            DownloadDocImage(commandArguments[0], commandArguments[1], "PDF");
        }
        if (e.CommandName == "DownloadImage")
        {
            string[] commandArguments = e.CommandArgument.ToString().Split(',');
            DownloadDocImage(commandArguments[0], commandArguments[1], "Image");
        }
    }
    protected void gvAttachment_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvAttachment_PreRender(object sender, EventArgs e)
    {
        int count = gvAttachment.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = gvAttachment.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = gvAttachment.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }
    protected void gvAttachment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlAttechmentCategory = (e.Row.FindControl("ddlAttechmentCategory") as DropDownList);
            HiddenField hddCategory = (e.Row.FindControl("hddCategory") as HiddenField);
            ddlAttechmentCategory.SelectedValue = hddCategory.Value;
        }
    }
    private void AddNewAttachment()
    {
        if (ViewState["dtDetailsAttachment"] != null)
        {
            SetDataAttachment();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["Category"] = "";
            dr["Description"] = "";
            dr["DocFile"] = "";
            dr["DocImage"] = "";
            dt.Rows.Add(dr);

            ViewState["dtDetailsAttachment"] = dt;
            gvAttachment.DataSource = dt;
            gvAttachment.DataBind();
        }
        else
        {
            FillDtAttachment("0");
            AddNewAttachment();
        }
    }
    private void SetDataAttachment()
    {
        if (ViewState["dtDetailsAttachment"] != null)
        {
            int rowindex = 0;
            DataTable dtData = (DataTable)ViewState["dtDetailsAttachment"];
            dt = dtData.Clone();
            DataRow dr;
            if (dtData.Rows.Count > 0)
            {
                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    HiddenField hddAttachmentID = (HiddenField)gvAttachment.Rows[rowindex].Cells[0].FindControl("hddAttachmentID");
                    DropDownList ddlAttechmentCategory = (DropDownList)gvAttachment.Rows[rowindex].FindControl("ddlAttechmentCategory");
                    TextBox txtDescription = (TextBox)gvAttachment.Rows[rowindex].Cells[1].FindControl("txtDescription");
                    FileUpload fudFile = (FileUpload)gvAttachment.Rows[rowindex].Cells[2].FindControl("fudFile");
                    FileUpload fudImage = (FileUpload)gvAttachment.Rows[rowindex].Cells[2].FindControl("fudImage");
                    LinkButton lnkDownloadDocFile = (LinkButton)gvAttachment.Rows[rowindex].FindControl("lnkDownloadDocFile");
                    LinkButton lnkDownloadDocImage = (LinkButton)gvAttachment.Rows[rowindex].FindControl("lnkDownloadDocImage");
                    dr = dt.NewRow();
                    dr["ID"] = hddAttachmentID.Value;
                    dr["Category"] = ddlAttechmentCategory.SelectedValue;
                    dr["Description"] = txtDescription.Text;
                    string strFileName = "";
                    if (fudFile.HasFile)
                    {
                        string fname = Path.GetFileNameWithoutExtension(fudFile.FileName).Replace(" ", "_");
                        if (Request.QueryString["ID"] == null)
                        {
                            strFileName = UploadImage("_Image_", fudImage);
                        }
                        else
                        {
                            strFileName = UploadImage(Request.QueryString["ID"].ToString() + "_" + "_Image_", fudFile);
                        }
                        dr["DocFile"] = strFileName;
                    }
                    else
                        dr["DocFile"] = lnkDownloadDocFile.Text;

                    if (fudImage.HasFile)
                    {
                        string fname = Path.GetFileNameWithoutExtension(fudImage.FileName).Replace(" ", "_");
                        if (Request.QueryString["ID"] == null)
                        {
                            strFileName = UploadImage("_Image_", fudImage);
                        }
                        else
                        {
                            strFileName = UploadImage(Request.QueryString["ID"].ToString() + "_", fudImage);
                        }
                        dr["DocImage"] = strFileName;
                    }
                    else
                        dr["DocImage"] = lnkDownloadDocImage.Text;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetailsAttachment"] = dt;
                gvAttachment.DataSource = dt;
                gvAttachment.DataBind();
            }
        }
    }
    private void FillDtAttachment(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,Category,Description,DocFile,DocImage from tbl_CANAttachment where IsDelete=0 and CANID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsAttachment"] = dtData;
        }
        else
        {
            ViewState["dtDetailsAttachment"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("Category");
            dt.Columns.Add("Description");
            dt.Columns.Add("DocFile");
            dt.Columns.Add("DocImage");
            ViewState["dtDetailsAttachment"] = dt;
        }

        dt = (DataTable)ViewState["dtDetailsAttachment"];
        if (dt.Rows.Count == 0)
        {
            AddNewAttachment();
        }
        gvAttachment.DataSource = dt;
        gvAttachment.DataBind();
    }
    #region Download Attachment
    public void DownloadDocImage(string ID, string DocFile, string Type)
    {
        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/CAN/") + DocFile))
        {
            if (Request.QueryString["ID"] != null)
            {
                string CANID = Request.QueryString["ID"].ToString();
                DataTable dtCANOrderNo = new DataTable();
                dtCANOrderNo = cls.selectDataTable(" select b.CANOrderNo from tbl_CANApprover a inner join tbl_ContractAmendmentNote b on a.CANID=b.ID Where a.IsApprove=1 And  a.CANID='" + CANID + "' and a.IsDelete=0");
                if (dtCANOrderNo.Rows.Count > 0)
                {
                    string filePath = Server.MapPath("../Upload/CAN/") + ID + CANID + Type + DocFile;
                    try
                    {
                        if (Type == "PDF")
                        {
                            PdfReader reader = new PdfReader(Server.MapPath("../Upload/CAN/") + DocFile);
                            PdfStamper stamper = new PdfStamper(reader, new FileStream(filePath, FileMode.Create));
                            int n = reader.NumberOfPages;
                            iTextSharp.text.Rectangle pagesize;
                            for (int i = 1; i <= n; i++)
                            {
                                PdfContentByte over = stamper.GetOverContent(i);
                                pagesize = reader.GetPageSize(i);
                                PdfGState gs = new PdfGState();
                                //gs.FillOpacity = 0.3f;
                                over.SaveState();
                                over.SetGState(gs);
                                over.SetRGBColorFill(3, 37, 126);
                                ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtCANOrderNo.Rows[0]["CANOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15, iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
                                over.RestoreState();
                            }
                            stamper.Close();
                            reader.Close();
                        }
                        else if (Type == "Image")
                        {
                            PointF firstLocation = new PointF(10f, 10f);
                            string imageFilePath = Server.MapPath("../Upload/CAN/") + DocFile;
                            Bitmap newBitmap;
                            using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFilePath))//load the image file
                            {
                                using (Graphics graphics = Graphics.FromImage(bitmap))
                                {
                                    using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12, FontStyle.Bold))
                                    {
                                        System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);
                                        graphics.DrawString(dtCANOrderNo.Rows[0]["CANOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);

                                    }
                                }
                                newBitmap = new Bitmap(bitmap);
                            }
                            newBitmap.Save(filePath);//save the image file
                            newBitmap.Dispose();
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                    try
                    {
                        Response.WriteFile(filePath);
                        Response.Flush();
                        System.IO.File.Delete(filePath);
                    }
                    catch (Exception ex)
                    {

                    }
                    finally
                    {
                        Response.End();
                    }
                }
                else
                {

                    var filePath = Server.MapPath("../Upload/CAN/") + DocFile + "";
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                    try
                    {
                        Response.WriteFile(filePath);
                        Response.Flush();
                    }
                    catch (Exception ex)
                    {

                    }
                    finally
                    {
                        Response.End();
                    }
                }
            }
            else
            {

                var filePath = Server.MapPath("../Upload/CAN/") + DocFile + "";
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                try
                {
                    Response.WriteFile(filePath);
                    Response.Flush();
                }
                catch (Exception ex)
                {

                }
                finally
                {
                    Response.End();
                }
            }
        }





    }
    #endregion Download Attachment
    protected void ddlprojectname_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtProjectaddress.Text = cls.ExecuteStringScalar("EXEC sp_ProjectMaster 'GetAddress','" + ddlprojectname.SelectedValue + "'");
        loadLocation(ddlprojectname.SelectedValue);
    }
    public void loadLocation(string projectid)
    {
        DataTable dtlocation = cls.selectDataTable("exec sp_LocationMaster 'GetByProjectID','" + ddlprojectname.SelectedValue + "'");
        if (dtlocation.Rows.Count > 0)
        {
            ddllocation.DataSource = dtlocation;
            ddllocation.DataTextField = "LocationName";
            ddllocation.DataValueField = "ID";
            ddllocation.DataBind();
            ddllocation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select One", "0"));
        }
        else
        {
            ddllocation.Items.Clear();
            ddllocation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select One", "0"));
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SetData();
        SetDataApprover();
        SetDataAttachment();
        SetDataIH();
        DataTable dtCANMajorDeviation = new DataTable();
        DataTable dtCANBidEvaluation = new DataTable();
        DataTable dtCANApprover = new DataTable();
        DataTable dtCANAttachment = new DataTable();
        if (ViewState["dtDetailsSE"] != null)
            dtCANMajorDeviation = (DataTable)ViewState["dtDetailsSE"];
        if (ViewState["dtDetailsIH"] != null)
            dtCANBidEvaluation = (DataTable)ViewState["dtDetailsIH"];
        if (ViewState["dtDetailsApprover"] != null)
            dtCANApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtCANAttachment = (DataTable)ViewState["dtDetailsAttachment"];
        if (dtCANApprover.Rows.Count == 1)
        {
            int approverid = int.Parse(dtCANApprover.Rows[0]["ApproverID"].ToString());
            if (approverid == 0)
            {
                string message = "Please Select Approver!";
                string script = "window.onload = function(){ alert('";
                script += message;
                script += "');}";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                return;
            }
        }
        string orderNo = AmendmentOrderNo();
        if (orderNo != "")
        {
            txtoriginalContractordernumber.Text = orderNo;
        }
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
                try
                {
                    if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalContractordernumber.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                    }
                    string consString = cls.Connection1();
                    using (SqlConnection con = new SqlConnection(consString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ManageContractAmendmentNote"))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Connection = con;
                            cmd.Parameters.AddWithValue("@Action", "Insert");
                            cmd.Parameters.AddWithValue("@ID", "0");
                            cmd.Parameters.AddWithValue("@CANRefID", "");
                            cmd.Parameters.AddWithValue("@ContractOrderNo", txtoriginalContractordernumber.Text);
                            cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                            cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                            cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                            cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                            cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                            cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                            cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Alreadyaward", txtAlreadyaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevisedValue", txtRevisedvalueasperthisamend.Text.Trim());
                            cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                            cmd.Parameters.AddWithValue("@OtherDescription", txtothers.Text);
                            cmd.Parameters.AddWithValue("@ContractorName", txtmenstionnameofContractor.Text.Trim());
                            cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperPrevious", txtRevisedcostasperPreviousamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperThis", txtrevisedcostasperthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                            cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                            cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                            cmd.Parameters.AddWithValue("@CANMajorDeviation", dtCANMajorDeviation);
                            cmd.Parameters.AddWithValue("@CANBidEvaluation", dtCANBidEvaluation);
                            cmd.Parameters.AddWithValue("@CANApprover", dtCANApprover);
                            cmd.Parameters.AddWithValue("@CANAttachment", dtCANAttachment);
                            con.Open();
                            SqlDataAdapter adp = new SqlDataAdapter(cmd);
                            adp.Fill(dtResult);
                            con.Close();
                        }
                    }
                    if (dtResult.Rows.Count > 0)
                    {
                        string strMessage = dtResult.Rows[0]["Message"].ToString();
                        string strStatus = dtResult.Rows[0]["Status"].ToString();
                        if (strStatus == "0")
                        {
                            //tranScope.Dispose();
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + strMessage + "');}", true);

                            //clear();
                        }
                        else
                        {
                           // tranScope.Complete();
                           // tranScope.Dispose();
                            string message = strMessage;
                            string script = "window.onload = function(){ alert('";
                            script += strMessage;
                            script += "');";
                            script += "window.location = '";
                            script += "ListContractAmendmentNote.aspx";
                            script += "'; }";
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

                        }
                    }
                }
                catch (Exception ex)
                {
                    //tranScope.Dispose();
                    ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + ex.Message.ToString() + "');}", true);
                }
            
        }
        else if (Request.QueryString["ID"] != null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
                try
                {
                    if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalContractordernumber.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                    }
                    string consString = cls.Connection1();
                    using (SqlConnection con = new SqlConnection(consString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ManageContractAmendmentNote"))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Connection = con;
                            cmd.Parameters.AddWithValue("@Action", "Update");
                            cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                            cmd.Parameters.AddWithValue("@CANRefID", "");
                            cmd.Parameters.AddWithValue("@ContractOrderNo", txtoriginalContractordernumber.Text);
                            cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                            cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                            cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                            cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                            cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                            cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                            cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Alreadyaward", txtAlreadyaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevisedValue", txtRevisedvalueasperthisamend.Text.Trim());
                            cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                            cmd.Parameters.AddWithValue("@OtherDescription", txtothers.Text);
                            cmd.Parameters.AddWithValue("@ContractorName", txtmenstionnameofContractor.Text.Trim());
                            cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperPrevious", txtRevisedcostasperPreviousamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperThis", txtrevisedcostasperthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                            cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                            cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                            cmd.Parameters.AddWithValue("@CANMajorDeviation", dtCANMajorDeviation);
                            cmd.Parameters.AddWithValue("@CANBidEvaluation", dtCANBidEvaluation);
                            cmd.Parameters.AddWithValue("@CANApprover", dtCANApprover);
                            cmd.Parameters.AddWithValue("@CANAttachment", dtCANAttachment);
                            con.Open();
                            SqlDataAdapter adp = new SqlDataAdapter(cmd);
                            adp.Fill(dtResult);
                            con.Close();
                        }
                    }
                    if (dtResult.Rows.Count > 0)
                    {
                        string strMessage = dtResult.Rows[0]["Message"].ToString();
                        string strStatus = dtResult.Rows[0]["Status"].ToString();
                        if (strStatus == "0")
                        {
                            //tranScope.Dispose();
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + strMessage + "');}", true);

                        }
                        else
                        {
                           // tranScope.Complete();
                            //tranScope.Dispose();
                            string message = strMessage;
                            string script = "window.onload = function(){ alert('";
                            script += strMessage;
                            script += "');";
                            script += "window.location = '";
                            script += "ListContractAmendmentNote.aspx";
                            script += "'; }";
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

                        }
                    }
                }
                catch (Exception ex)
                {
                   // tranScope.Dispose();
                    ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + ex.Message.ToString() + "');}", true);
                }
            }
        
    }
    private string UploadImage(string strID, FileUpload FileUploader)
    {
        string url = "";
        if (FileUploader.HasFile)
        {
            System.IO.FileInfo info = new System.IO.FileInfo(FileUploader.PostedFile.FileName.ToString());
            string strname = Guid.NewGuid().ToString() + strID + info.Extension.ToLower();
            url = strname;
            FileUploader.PostedFile.SaveAs(Server.MapPath("../Upload/CAN/") + strname);
        }
        return url;
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {

    }

    protected void btnSubmitforApproval_Click(object sender, EventArgs e)
    {
        SetData();
        SetDataApprover();
        SetDataAttachment();
        SetDataIH();
        DataTable dtCANMajorDeviation = new DataTable();
        DataTable dtCANBidEvaluation = new DataTable();
        DataTable dtCANApprover = new DataTable();
        DataTable dtCANAttachment = new DataTable();
        if (ViewState["dtDetailsSE"] != null)
            dtCANMajorDeviation = (DataTable)ViewState["dtDetailsSE"];
        if (ViewState["dtDetailsIH"] != null)
            dtCANBidEvaluation = (DataTable)ViewState["dtDetailsIH"];
        if (ViewState["dtDetailsApprover"] != null)
            dtCANApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtCANAttachment = (DataTable)ViewState["dtDetailsAttachment"];
        if (dtCANApprover.Rows.Count == 1)
        {
            int approverid = int.Parse(dtCANApprover.Rows[0]["ApproverID"].ToString());
            if (approverid == 0)
            {
                string message = "Please Select Approver!";
                string script = "window.onload = function(){ alert('";
                script += message;
                script += "');}";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                return;
            }
        }
        string orderNo = AmendmentOrderNo();
        if (orderNo != "")
        {
            txtoriginalContractordernumber.Text = orderNo;
        }
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
                try
                {
                    if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalContractordernumber.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                    }
                    string consString = cls.Connection1();
                    using (SqlConnection con = new SqlConnection(consString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ManageContractAmendmentNote"))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Connection = con;
                            cmd.Parameters.AddWithValue("@Action", "Insert");
                            cmd.Parameters.AddWithValue("@ID", "0");
                            cmd.Parameters.AddWithValue("@CANRefID", "");
                            cmd.Parameters.AddWithValue("@ContractOrderNo", txtoriginalContractordernumber.Text);
                            cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                            cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                            cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                            cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                            cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                            cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                            cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Alreadyaward", txtAlreadyaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevisedValue", txtRevisedvalueasperthisamend.Text.Trim());
                            cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                            cmd.Parameters.AddWithValue("@OtherDescription", txtothers.Text);
                            cmd.Parameters.AddWithValue("@ContractorName", txtmenstionnameofContractor.Text.Trim());
                            cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperPrevious", txtRevisedcostasperPreviousamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperThis", txtrevisedcostasperthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                            cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                            cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                            cmd.Parameters.AddWithValue("@CANMajorDeviation", dtCANMajorDeviation);
                            cmd.Parameters.AddWithValue("@CANBidEvaluation", dtCANBidEvaluation);
                            cmd.Parameters.AddWithValue("@CANApprover", dtCANApprover);
                            cmd.Parameters.AddWithValue("@CANAttachment", dtCANAttachment);
                            con.Open();
                            SqlDataAdapter adp = new SqlDataAdapter(cmd);
                            adp.Fill(dtResult);
                            con.Close();
                        }
                    }
                    if (dtResult.Rows.Count > 0)
                    {
                        string strMessage = dtResult.Rows[0]["Message"].ToString();
                        string strStatus = dtResult.Rows[0]["Status"].ToString();
                        if (strStatus == "0")
                        {
                           // tranScope.Dispose();
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + strMessage + "');}", true);

                        }
                        else
                        {

                            if (cls.ExecuteIntScalar("select count(*) from tbl_Notification where IsMail=0 and IsWait=0") > 0)
                            {
                                DataTable dtData = new DataTable();
                                dtData = cls.selectDataTable("select a.ID,EmailID,Subject,Body from tbl_Notification a inner join tbl_UserMaster b on a.UserID=b.ID inner join tblUser_Details c on b.ID=c.UserID and c.IsDelete=0 where IsMail=0 and IsWait=0");
                                if (dtData.Rows.Count > 0)
                                {
                                    cls.ExecuteQuery("Update tbl_Notification set IsWait=1 where IsWait=0");
                                    for (int i = 0; i < dtData.Rows.Count; i++)
                                    {
                                        cls.GetMail(dtData.Rows[i]["EmailID"].ToString(), dtData.Rows[i]["Subject"].ToString(), dtData.Rows[i]["Body"].ToString());
                                        cls.ExecuteQuery("Update tbl_Notification set IsMail=1 where ID='" + dtData.Rows[i]["ID"].ToString() + "'");
                                    }
                                }
                            }
                            //tranScope.Complete();
                           // tranScope.Dispose();
                            string message = strMessage;
                            string script = "window.onload = function(){ alert('";
                            script += strMessage;
                            script += "');";
                            script += "window.location = '";
                            script += "ListContractAmendmentNote.aspx";
                            script += "'; }";
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                        }
                    }
                }
                catch (Exception ex)
                {
                   // tranScope.Dispose();
                    ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + ex.Message.ToString() + "');}", true);
                }
            
        }
        else if (Request.QueryString["ID"] != null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
                try
                {
                    if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalContractordernumber.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                    }
                    string consString = cls.Connection1();
                    using (SqlConnection con = new SqlConnection(consString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ManageContractAmendmentNote"))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Connection = con;
                            cmd.Parameters.AddWithValue("@Action", "Update");
                            cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                            cmd.Parameters.AddWithValue("@CANRefID", "");
                            cmd.Parameters.AddWithValue("@ContractOrderNo", txtoriginalContractordernumber.Text);
                            cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                            cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                            cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                            cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                            cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                            cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                            cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Alreadyaward", txtAlreadyaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevisedValue", txtRevisedvalueasperthisamend.Text.Trim());
                            cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                            cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                            cmd.Parameters.AddWithValue("@OtherDescription", txtothers.Text);
                            cmd.Parameters.AddWithValue("@ContractorName", txtmenstionnameofContractor.Text.Trim());
                            cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperPrevious", txtRevisedcostasperPreviousamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@RevCostasperThis", txtrevisedcostasperthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                            cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                            cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                            cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                            cmd.Parameters.AddWithValue("@CANMajorDeviation", dtCANMajorDeviation);
                            cmd.Parameters.AddWithValue("@CANBidEvaluation", dtCANBidEvaluation);
                            cmd.Parameters.AddWithValue("@CANApprover", dtCANApprover);
                            cmd.Parameters.AddWithValue("@CANAttachment", dtCANAttachment);
                            con.Open();
                            SqlDataAdapter adp = new SqlDataAdapter(cmd);
                            adp.Fill(dtResult);
                            con.Close();
                        }
                    }
                    if (dtResult.Rows.Count > 0)
                    {
                        string strMessage = dtResult.Rows[0]["Message"].ToString();
                        string strStatus = dtResult.Rows[0]["Status"].ToString();
                        if (strStatus == "0")
                        {
                           // tranScope.Dispose();
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + strMessage + "');}", true);

                        }
                        else
                        {

                            if (cls.ExecuteIntScalar("select count(*) from tbl_Notification where IsMail=0 and IsWait=0") > 0)
                            {
                                DataTable dtData = new DataTable();
                                dtData = cls.selectDataTable("select a.ID,EmailID,Subject,Body from tbl_Notification a inner join tbl_UserMaster b on a.UserID=b.ID inner join tblUser_Details c on b.ID=c.UserID and c.IsDelete=0 where IsMail=0 and IsWait=0");
                                if (dtData.Rows.Count > 0)
                                {
                                    cls.ExecuteQuery("Update tbl_Notification set IsWait=1 where IsWait=0");
                                    for (int i = 0; i < dtData.Rows.Count; i++)
                                    {
                                        cls.GetMail(dtData.Rows[i]["EmailID"].ToString(), dtData.Rows[i]["Subject"].ToString(), dtData.Rows[i]["Body"].ToString());
                                        cls.ExecuteQuery("Update tbl_Notification set IsMail=1 where ID='" + dtData.Rows[i]["ID"].ToString() + "'");
                                    }
                                }
                            }
                            //tranScope.Complete();
                           // tranScope.Dispose();
                            string message = strMessage;
                            string script = "window.onload = function(){ alert('";
                            script += strMessage;
                            script += "');";
                            script += "window.location = '";
                            script += "ListContractAmendmentNote.aspx";
                            script += "'; }";
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                        }
                    }
                }
                catch (Exception ex)
                {
                   // tranScope.Dispose();
                    ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + ex.Message.ToString() + "');}", true);
                }
            
        }
    }
    protected void txtApprovalBudget_TextChanged(object sender, EventArgs e)
    {
        fillVariationofBudget();
    }

    protected void txtAlreadyAwarded_TextChanged(object sender, EventArgs e)
    {
        fillVariationofBudget();
    }

    protected void txtrevisedvalue_TextChanged(object sender, EventArgs e)
    {
        fillVariationofBudget();
    }

    protected void txtBalancetobeaward_TextChanged(object sender, EventArgs e)
    {
        fillVariationofBudget();
    }

    private void fillVariationofBudget()
    {
        double dblapprovalBudget = 0;
        //double dblAlreadyAwarded = 0;
        double dblrevisedvalue = 0;
        double dblBalancetobeaward = 0;
        double dblVaritaion = 0;
        if (double.TryParse(txtApprovalBudget.Text, out dblapprovalBudget)) { }
        //if (double.TryParse(txtAlreadyaward.Text, out dblAlreadyAwarded)) { }
        if (double.TryParse(txtRevisedvalueasperthisamend.Text, out dblrevisedvalue)) { }
        if (double.TryParse(txtBalancetobeaward.Text, out dblBalancetobeaward)) { }
        dblVaritaion = (dblapprovalBudget - dblrevisedvalue - dblBalancetobeaward);
        txtvariationfrombudget.Text = (decimal.Round(Convert.ToDecimal(dblVaritaion), 2)).ToString();
        if (dblVaritaion > 0)
        {
            txtvariationfrombudget.Style.Add("color", "Green");
        }
        else if (dblVaritaion < 0)
        {
            txtvariationfrombudget.Style.Add("color", "Red");
        }
    }
    protected void txtPreviousAmend_TextChanged(object sender, EventArgs e)
    {
        decimal dblPrevious = 0;
        decimal dblThis = 0;
        decimal dblVariation = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtPreviousAmend = (TextBox)row.FindControl("txtPreviousAmend");
        TextBox txtThisAmend = (TextBox)row.FindControl("txtThisAmend");
        TextBox txtVariation = (TextBox)row.FindControl("txtVariation");
        if (decimal.TryParse(txtPreviousAmend.Text, out dblPrevious)) { }
        if (decimal.TryParse(txtThisAmend.Text, out dblThis)) { }
        dblVariation = (dblThis - dblPrevious);
        txtVariation.Text = dblVariation.ToString();
    }

    protected void txtThisAmend_TextChanged(object sender, EventArgs e)
    {
        decimal dblPrevious = 0;
        decimal dblThis = 0;
        decimal dblVariation = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtPreviousAmend = (TextBox)row.FindControl("txtPreviousAmend");
        TextBox txtThisAmend = (TextBox)row.FindControl("txtThisAmend");
        TextBox txtVariation = (TextBox)row.FindControl("txtVariation");
        if (decimal.TryParse(txtPreviousAmend.Text, out dblPrevious)) { }
        if (decimal.TryParse(txtThisAmend.Text, out dblThis)) { }
        dblVariation = (dblThis - dblPrevious);
        txtVariation.Text = dblVariation.ToString();
    }
    protected void btnGrandTotal_Click(object sender, EventArgs e)
    {
        CalCostPersqft();
    }

    private void CalCostPersqft()
    {
        decimal dblPreviousCostpersqft = 0;
        decimal dblThisCostpersqft = 0;
        decimal dblSaleableArea = 0;
        decimal dblPreviousValue = 0;
        decimal dblThisValue = 0;

        if (decimal.TryParse(txtSaleableArea.Text, out dblSaleableArea)) { }
        if (decimal.TryParse(gvItemHead.FooterRow.Cells[4].Text, out dblPreviousValue)) { }
        if (decimal.TryParse(gvItemHead.FooterRow.Cells[5].Text, out dblThisValue)) { }
        if (dblSaleableArea > 0)
        {
            dblPreviousCostpersqft = dblPreviousValue / dblSaleableArea;
            dblThisCostpersqft = dblThisValue / dblSaleableArea;
        }
        txtPreviousCostPerSqft.Text = Math.Round(dblPreviousCostpersqft, 2).ToString();
        txtThisCostPerSqft.Text = Math.Round(dblThisCostpersqft, 2).ToString();
    }

    protected void txtSaleableArea_TextChanged(object sender, EventArgs e)
    {
        CalCostPersqft();
    }

    protected void ddlReasonofvariation_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlReasonofvariation.SelectedValue == "Other")
        {
            txtothers.Text = "";
            txtothers.ReadOnly = false;
            rvreasonforothers.Visible = true;
        }
        else
        {
            txtothers.Text = "";
            txtothers.ReadOnly = true;
            rvreasonforothers.Visible = false;
        }

    }

    #region Download Attachment
    public void lnkDownloadDocImage_Click(Object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        var filePath = Server.MapPath("../Upload/CAN/") + btn.Text + "";
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + btn.Text + "");
        Response.TransmitFile(filePath);
        Response.End();
    }
    public void lnkDownloadDocFile_Click(Object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        var filePath = Server.MapPath("../Upload/CAN/") + btn.Text + "";
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + btn.Text + "");
        Response.TransmitFile(filePath);
        Response.End();
    }
    #endregion Download Attachment

    public string AmendmentOrderNo()
    {
        string orderNo = cls.ExecuteStringScalar("select ContractOrderNo from tbl_ContractAmendmentNote where CANOrderNo='" + txtoriginalContractordernumber.Text + "'");
        return orderNo;
    }
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetApprovalNo(string prefixText)
    {
        cls_connection_new cls = new cls_connection_new();
        DataTable dt = cls.selectDataTable("select CANOrderNo from tbl_ContractAmendmentNote where CANOrderNo like '%" + prefixText + "%' and IsActive=1 and CANOrderNo is not null and CANOrderNo<>''");
        List<string> list = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            list.Add(dt.Rows[i]["CANOrderNo"].ToString());
        }
        return list;
    }

    #region ProjectAddres And Location
    [WebMethod]
    public static string getPorjectAddress(int projectId)
    {
        cls_connection_new cls = new cls_connection_new();
        return cls.ExecuteStringScalar("EXEC sp_ProjectMaster 'GetAddress','" + projectId + "'"); ;
    }

    [WebMethod]
    public static List<System.Web.UI.WebControls.ListItem> getPorjectLocation(int projectId)
    {
        List<System.Web.UI.WebControls.ListItem> projLocation = new List<System.Web.UI.WebControls.ListItem>();
        cls_connection_new cls = new cls_connection_new();
        DataTable dt = cls.GetDataTable("EXEC sp_LocationMaster 'GetByProjectID','" + projectId + "'");
        foreach (DataRow row in dt.Rows)
        {
            projLocation.Add(new System.Web.UI.WebControls.ListItem
            {
                Value = row["ID"].ToString(),
                Text = row["LocationName"].ToString()
            });

        }
        return projLocation;
    }

    #endregion ProjectAddres And Location

    protected void txtoriginalContractordernumber_TextChanged(object sender, EventArgs e)
    {
        if (txtoriginalContractordernumber.Text != "")
        {
            int ID = cls.ExecuteIntScalar("select ID From tbl_ContractAmendmentNote where CANOrderNo='" + txtoriginalContractordernumber.Text + "' and IsActive=1 and CANOrderNo is not null and CANOrderNo<>''");
            FillData(ID);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "fillVariationofBudget();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillPrevsThis", "fillPrevsThis();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillOrivsThis", "fillOrivsThis();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ddlChange", "ddlChange();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);

        }
    }
}