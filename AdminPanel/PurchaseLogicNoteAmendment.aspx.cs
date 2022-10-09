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


public partial class AdminPanel_PurchaseLogicNoteAmendment : System.Web.UI.Page
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
        //txtPreviousCostPerSqft.Attributes.Add("readonly", "readonly");
        //txtThisCostPerSqft.Attributes.Add("readonly", "readonly");
        if (!IsPostBack)
        {
            //cls.BindDropDownList(ddloriginalpurchaseordernumber, "EXEC sp_ManagePurchaseLogicNote 'GetAllSerialforddl'", "PLNOrderNo", "PLNOrderNo");
            cls.BindDropDownList(ddlDepartment, "EXEC sp_DepartmentMaster 'GetAllforddl'", "DepartmentName", "ID");
            cls.BindDropDownList(ddlapprovalauthrity, "EXEC sp_CommitteeMaster 'GetAllforddl'", "CommitteeName", "ID");
            cls.BindDropDownList(ddlprojectname, "EXEC sp_ProjectMaster 'GetAllforddl'", "ProjectName", "ID");
            cls.BindDropDownList(ddlStockinhandUOM, "EXEC sp_ItemMaster 'GetAllUOMforDDL'", "Name", "Code");
            ddlprojectname_SelectedIndexChanged(null, null);
            //ddlRequirement_SelectedIndexChanged(null, null);
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
        dtData = cls.selectDataTable("EXEC sp_ManagePurchaseAmendmentNote 'GetByID','" + id.ToString() + "'");
        if (dtData.Rows.Count > 0)
        {
            if (dtData.Rows[0]["IsSubmitted"].ToString().ToUpper() == "TRUE" && Request.QueryString["ID"] != null)
            {
                btnSubmit.Enabled = false;
                btnSubmitforApproval.Enabled = false;
            }

            //if (ddlapprovaltype.SelectedValue.ToString() == "Amendment" && txtoriginalpurchaseordernumber.Text.Trim() != "")
            //{
            //    btnSubmit.Enabled = true;
            //    btnSubmitforApproval.Enabled = true;
            //}
            //else if (ddlapprovaltype.SelectedValue.ToString() == "New" && txtoriginalpurchaseordernumber.Text.Trim() != "")
            //{
            //    btnSubmit.Enabled = false;
            //    btnSubmitforApproval.Enabled = false;
            //}

            txtoriginalpurchaseordernumber.Text = dtData.Rows[0]["PurchaseOrderNo"].ToString();
            ddlapprovalauthrity.SelectedValue = dtData.Rows[0]["ApprovalAuthrityID"].ToString();
            txtSubjectScope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
            ddlprojectname.SelectedValue = dtData.Rows[0]["ProjectID"].ToString();
            ddlprojectname_SelectedIndexChanged(null, null);
            ddlDepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
            ddllocation.SelectedValue = dtData.Rows[0]["LocationID"].ToString();
            hddlocationId.Value = dtData.Rows[0]["LocationID"].ToString();
            txtIndentProponent.Text = dtData.Rows[0]["IndentProponent"].ToString();
            txtDateofindent.Text = dtData.Rows[0]["Dateofindent1"].ToString();
            txtMaterialneededby.Text = dtData.Rows[0]["Materialneededby1"].ToString();
            txtStockinHand.Text = dtData.Rows[0]["StockinHand"].ToString();
            ddlStockinhandUOM.SelectedValue = dtData.Rows[0]["StockUOM"].ToString();
            ddlRequirement.SelectedValue = dtData.Rows[0]["Requirement"].ToString();
            txtUrgetResionDescription.Text = dtData.Rows[0]["UrgentReasonDesc"].ToString();
            txtSaleableArea.Text = dtData.Rows[0]["SaleableArea"].ToString();
            txtAlreadyAwarded.Text = dtData.Rows[0]["AlreadyAwarded"].ToString();
            txtApprovalBudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
            txtrevisedvalue.Text = dtData.Rows[0]["RevisedValue"].ToString();
            txtBalancetobeaward.Text = dtData.Rows[0]["BalanceAward"].ToString();
            txtvariationfrombudget.Text = dtData.Rows[0]["Variationfombudget"].ToString();
            ddlReasonofvariation.SelectedValue = dtData.Rows[0]["Reasonofvariation"].ToString();
            txtother.Text = dtData.Rows[0]["OtherDescription"].ToString();
            txtmenstionnameofvendor.Text = dtData.Rows[0]["VendorName"].ToString();
            txtcostasperoriginalaward.Text = dtData.Rows[0]["OriginalAward"].ToString();
            txtRevisedCostasperpreviousamendment.Text = dtData.Rows[0]["PreviousRevCost"].ToString();
            txtrevisedcostasperthisamendment.Text = dtData.Rows[0]["ThisRevCost"].ToString();
            txtvariationprevsamendment.Text = dtData.Rows[0]["VariationPreviousvsThis"].ToString();
            txtvariationorignalvsthisamendment.Text = dtData.Rows[0]["VariationOriginalvsThis"].ToString();
            txtreccomandationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();
            txtPreviousGST.Text = dtData.Rows[0]["PreviousGST"].ToString();
            txtThisGST.Text = dtData.Rows[0]["ThisGST"].ToString();
            txtPreviousFreight.Text = dtData.Rows[0]["PreviousFreight"].ToString();
            txtThisFreight.Text = dtData.Rows[0]["ThisFreight"].ToString();
            txtPreviousHeadlingCharges.Text = dtData.Rows[0]["PreviousHandlingCharges"].ToString();
            txtThisHeadlingCharges.Text = dtData.Rows[0]["ThisHandlingCharges"].ToString();
            txtPreviousGrandTotal.Text = dtData.Rows[0]["PreviousGrandTotal"].ToString();
            txtThisGrandTotal.Text = dtData.Rows[0]["ThisGrandTotal"].ToString();
            txtPreviousCostPerSqft.Text = dtData.Rows[0]["PreviousCostPerSqft"].ToString();
            txtThisCostPerSqft.Text = dtData.Rows[0]["ThisCostPerSqft"].ToString();
            txtPreviousHandlingCharge.Text = Convert.ToString(dtData.Rows[0]["PreviousHandlingCharge"]);
            txtThisHandlingCharge.Text = Convert.ToString(dtData.Rows[0]["ThisHandlingCharge"]);
            txtPreviousOtherCharge.Text = Convert.ToString(dtData.Rows[0]["PreviousOtherCharge"]);
            txtThisOtherCharge.Text = Convert.ToString(dtData.Rows[0]["ThisOtherCharge"]);
            fillVariationofBudget();
            fillPrevsThis();
            fillOrivsThis();

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
                cls.ExecuteQuery("EXEC sp_ManagePurchaseAmendmentNote 'DeletePANMajorDeviation','" + e.CommandArgument + "'");
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
                    TextBox txrecommandation = (TextBox)gvStandardexception.Rows[rowindex].Cells[3].FindControl("txtrecommendation");
                    dr = dt.NewRow();
                    dr["ID"] = hddSEID.Value;
                    dr["Standard"] = ckStandrad.Text;
                    dr["Excepetion"] = ckExcepetion.Text;
                    dr["Recommendation"] = txrecommandation.Text;
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
        DataTable dtData = cls.selectDataTable("select ID,Standard,Excepetion,Recommendation from tbl_PANMajorDeviation where IsDelete=0 and PANID='" + ID + "'");
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
                cls.ExecuteQuery("EXEC sp_ManagePurchaseAmendmentNote 'DeletePANBidEvaluation','" + e.CommandArgument + "'");
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
            DropDownList ddlPreviousItem = (e.Row.FindControl("ddlPreviousItem") as DropDownList);
            HiddenField hddPreviousItem = (e.Row.FindControl("hddPreviousItem") as HiddenField);
            DropDownList ddlPreviousUOM = (e.Row.FindControl("ddlPreviousUOM") as DropDownList);
            HiddenField hddPreviousUOM = (e.Row.FindControl("hddPreviousUOM") as HiddenField);
            DropDownList ddlThisItem = (e.Row.FindControl("ddlThisItem") as DropDownList);
            HiddenField hddThisItem = (e.Row.FindControl("hddThisItem") as HiddenField);
            DropDownList ddlThisUOM = (e.Row.FindControl("ddlThisUOM") as DropDownList);
            HiddenField hddThisUOM = (e.Row.FindControl("hddThisUOM") as HiddenField);
            cls.BindDropDownList(ddlPreviousUOM, "EXEC sp_ItemMaster 'GetAllUOMforDDL'", "Name", "Code");
            cls.BindDropDownList(ddlPreviousItem, "EXEC sp_ItemMaster 'GetAllforDDL'", "ItemName", "ID");
            cls.BindDropDownList(ddlThisUOM, "EXEC sp_ItemMaster 'GetAllUOMforDDL'", "Name", "Code");
            cls.BindDropDownList(ddlThisItem, "EXEC sp_ItemMaster 'GetAllforDDL'", "ItemName", "ID");
            ddlPreviousUOM.SelectedValue = hddPreviousUOM.Value;
            ddlThisUOM.SelectedValue = hddThisUOM.Value;
            ddlPreviousItem.SelectedValue = hddPreviousItem.Value;
            ddlThisItem.SelectedValue = hddThisItem.Value;
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
            dr["PreviousItem"] = "0";
            dr["PreviousUOM"] = "";
            dr["PreviousQuantity"] = "0";
            dr["PreviousRate"] = "0";
            dr["PreviousAmount"] = "0";
            dr["ThisItem"] = "0";
            dr["ThisUOM"] = "";
            dr["ThisQuantity"] = "0";
            dr["ThisRate"] = "0";
            dr["ThisAmount"] = "0";
            dr["BudgetRate"] = "0";
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
                    HiddenField hddIHID = (HiddenField)gvItemHead.Rows[rowindex].Cells[0].FindControl("hddIHID");
                    DropDownList ddlPreviousItem = (DropDownList)gvItemHead.Rows[rowindex].Cells[1].FindControl("ddlPreviousItem");
                    DropDownList ddlPreviousUOM = (DropDownList)gvItemHead.Rows[rowindex].Cells[3].FindControl("ddlPreviousUOM");
                    TextBox txtPreviousQuantity = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtPreviousQuantity");
                    TextBox txtPreviousRate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtPreviousRate");
                    TextBox txtPreviousAmount = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtPreviousAmount");
                    DropDownList ddlThisItem = (DropDownList)gvItemHead.Rows[rowindex].Cells[1].FindControl("ddlThisItem");
                    DropDownList ddlThisUOM = (DropDownList)gvItemHead.Rows[rowindex].Cells[3].FindControl("ddlThisUOM");
                    TextBox txtThisQuantity = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtThisQuantity");
                    TextBox txtThisRate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtThisRate");
                    TextBox txtThisAmount = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtThisAmount");
                    TextBox txtBudgetRate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtBudgetRate");
                    TextBox txtReason = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtReason");
                    TextBox txtResponsiblePerson = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtResponsiblePerson");
                    dr = dt.NewRow();
                    dr["ID"] = hddIHID.Value;
                    dr["PreviousItem"] = ddlPreviousItem.SelectedValue;
                    dr["PreviousUOM"] = ddlPreviousUOM.SelectedValue;
                    dr["PreviousQuantity"] = txtPreviousQuantity.Text;
                    dr["PreviousRate"] = txtPreviousRate.Text;
                    dr["PreviousAmount"] = txtPreviousAmount.Text;
                    dr["ThisItem"] = ddlThisItem.SelectedValue;
                    dr["ThisUOM"] = ddlThisUOM.SelectedValue;
                    dr["ThisQuantity"] = txtThisQuantity.Text;
                    dr["ThisRate"] = txtThisRate.Text;
                    dr["ThisAmount"] = txtThisAmount.Text;
                    dr["BudgetRate"] = txtBudgetRate.Text;
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
        DataTable dtData = cls.selectDataTable("select ID,PreviousItem,PreviousUOM,PreviousQuantity,PreviousRate,PreviousAmount,ThisItem,ThisUOM,ThisQuantity,ThisRate,ThisAmount,BudgetRate,Reason,ResponsiblePerson from tbl_PANBidEvaluation where IsDelete=0 and PANID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsIH"] = dtData;
        }
        else
        {
            ViewState["dtDetailsIH"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("PreviousItem", typeof(int));
            dt.Columns.Add("PreviousUOM");
            dt.Columns.Add("PreviousQuantity", typeof(decimal));
            dt.Columns.Add("PreviousRate", typeof(decimal));
            dt.Columns.Add("PreviousAmount", typeof(decimal));
            dt.Columns.Add("ThisItem", typeof(int));
            dt.Columns.Add("ThisUOM");
            dt.Columns.Add("ThisQuantity", typeof(decimal));
            dt.Columns.Add("ThisRate", typeof(decimal));
            dt.Columns.Add("ThisAmount", typeof(decimal));
            dt.Columns.Add("BudgetRate", typeof(decimal));
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
        decimal dblPreviousQuantity = 0;
        decimal dblPreviousRate = 0;
        decimal dblPreviousValue = 0;
        decimal dblThisQuantity = 0;
        decimal dblThisRate = 0;
        decimal dblThisValue = 0;
        decimal dblBudgetRate = 0;
        dblPreviousQuantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("PreviousQuantity"));
        dblPreviousRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("PreviousRate"));
        dblPreviousValue = dt.AsEnumerable().Sum(row => row.Field<decimal>("PreviousAmount"));
        dblThisQuantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("ThisQuantity"));
        dblThisRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("ThisRate"));
        dblThisValue = dt.AsEnumerable().Sum(row => row.Field<decimal>("ThisAmount"));
        dblBudgetRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("BudgetRate"));

        gvItemHead.FooterRow.Cells[4].Text = dblPreviousQuantity.ToString();
        gvItemHead.FooterRow.Cells[5].Text = dblPreviousRate.ToString();
        gvItemHead.FooterRow.Cells[6].Text = dblPreviousValue.ToString();
        gvItemHead.FooterRow.Cells[9].Text = dblThisQuantity.ToString();
        gvItemHead.FooterRow.Cells[10].Text = dblThisRate.ToString();
        gvItemHead.FooterRow.Cells[11].Text = dblThisValue.ToString();
        gvItemHead.FooterRow.Cells[12].Text = dblBudgetRate.ToString();
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
                cls.ExecuteQuery("EXEC sp_ManagePurchaseAmendmentNote 'DeletePANApprover','" + e.CommandArgument + "'");
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
        DataTable dtData = cls.selectDataTable("select ID,ApproverID from tbl_PANApprover where IsDelete=0 and PANID='" + ID + "'");
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

    #region Attachment
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
                cls.ExecuteQuery("EXEC sp_ManagePurchaseAmendmentNote 'DeletePANAttachment','" + e.CommandArgument + "'");
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
        else if (e.CommandName == "DownloadImage")
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
        DataTable dtData = cls.selectDataTable("select ID,Category,Description,DocFile,DocImage from tbl_PANAttachment where IsDelete=0 and PANID='" + ID + "'");
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
        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/PAN/") + DocFile))
        {
            if (Request.QueryString["ID"] != null)
            {
                string PANID = Request.QueryString["ID"].ToString();
                DataTable dtPANOrderNo = new DataTable();
                dtPANOrderNo = cls.selectDataTable(" select b.PANOrderNo from tbl_PANApprover a inner join tbl_PurchaseAmendmentNote b on a.PANID=b.ID Where a.IsApprove=1 And  a.PANID='" + PANID + "' and a.IsDelete=0");
                if (dtPANOrderNo.Rows.Count > 0)
                {
                    string filePath = Server.MapPath("../Upload/PAN/") + ID + PANID + Type + DocFile;
                    try
                    {
                        if (Type == "PDF")
                        {
                            PdfReader reader = new PdfReader(Server.MapPath("../Upload/PAN/") + DocFile);
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
                                ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtPANOrderNo.Rows[0]["PANOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15, iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
                                over.RestoreState();
                            }
                            stamper.Close();
                            reader.Close();
                        }
                        else if (Type == "Image")
                        {
                            PointF firstLocation = new PointF(10f, 10f);
                            string imageFilePath = Server.MapPath("../Upload/PAN/") + DocFile;
                            Bitmap newBitmap;
                            using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFilePath))//load the image file
                            {
                                using (Graphics graphics = Graphics.FromImage(bitmap))
                                {
                                    using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12, FontStyle.Bold))
                                    {
                                        System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);
                                        graphics.DrawString(dtPANOrderNo.Rows[0]["PANOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);

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
                    var filePath = Server.MapPath("../Upload/PAN/") + DocFile + "";
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                    Response.TransmitFile(filePath);
                    Response.End();
                }
            }
            else
            {
                var filePath = Server.MapPath("../Upload/PAN/") + DocFile + "";
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                Response.TransmitFile(filePath);
                Response.End();

            }
        }
    }
    #endregion Download Attachment
    #endregion Attachment

    protected void ddlprojectname_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtProjectaddress.Text = cls.ExecuteStringScalar("EXEC sp_ProjectMaster 'GetAddress','" + ddlprojectname.SelectedValue + "'");
        cls.BindDropDownList(ddllocation, "EXEC sp_LocationMaster 'GetByProjectID','" + ddlprojectname.SelectedValue + "'", "LocationName", "ID");
    }
    protected void ddlRequirement_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRequirement.SelectedValue == "Urgent")
        {
            txtUrgetResionDescription.Text = "";
            txtUrgetResionDescription.ReadOnly = false;
            RequiredFieldValidator2.Visible = true;
        }
        else
        {
            txtUrgetResionDescription.Text = "";
            txtUrgetResionDescription.ReadOnly = true;
            RequiredFieldValidator2.Visible = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SetData();
        SetDataApprover();
        SetDataAttachment();
        SetDataIH();
        DataTable dtPANMajorDeviation = new DataTable();
        DataTable dtPANBidEvaluation = new DataTable();
        DataTable dtPANApprover = new DataTable();
        DataTable dtPANAttachment = new DataTable();
        if (ViewState["dtDetailsSE"] != null)
            dtPANMajorDeviation = (DataTable)ViewState["dtDetailsSE"];
        if (ViewState["dtDetailsIH"] != null)
            dtPANBidEvaluation = (DataTable)ViewState["dtDetailsIH"];
        if (ViewState["dtDetailsApprover"] != null)
            dtPANApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtPANAttachment = (DataTable)ViewState["dtDetailsAttachment"];
        
            string orderNo = AmendmentOrderNo();
            if (orderNo != "")
            {
                txtoriginalpurchaseordernumber.Text = orderNo;
            }       

        if (dtPANApprover.Rows.Count == 1)
        {

            int approverid = int.Parse(dtPANApprover.Rows[0]["ApproverID"].ToString());
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
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {

            try
            {
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalpurchaseordernumber.Text == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManagePurchaseAmendmentNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@PANRefID", "");
                        cmd.Parameters.AddWithValue("@PurchaseOrderNo", txtoriginalpurchaseordernumber.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@IndentProponent", txtIndentProponent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Dateofindent", txtDateofindent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Materialneededby", txtMaterialneededby.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockinHand", txtStockinHand.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockUOM", ddlStockinhandUOM.SelectedValue);
                        cmd.Parameters.AddWithValue("@Requirement", ddlRequirement.SelectedValue);
                        cmd.Parameters.AddWithValue("@UrgentReasonDesc", txtUrgetResionDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@AlreadyAwarded", txtAlreadyAwarded.Text.Trim());
                        cmd.Parameters.AddWithValue("@RevisedValue", txtrevisedvalue.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                        cmd.Parameters.AddWithValue("@VendorName", txtmenstionnameofvendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisRevCost", txtrevisedcostasperthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousRevCost", txtRevisedCostasperpreviousamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGST", txtPreviousGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGST", txtThisGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousFreight", txtPreviousFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisFreight", txtThisFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousHandlingCharges", txtPreviousHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisHandlingCharges", txtThisHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGrandTotal", txtPreviousGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGrandTotal", txtThisGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@PANMajorDeviation", dtPANMajorDeviation);
                        cmd.Parameters.AddWithValue("@PANBidEvaluation", dtPANBidEvaluation);
                        cmd.Parameters.AddWithValue("@PANApprover", dtPANApprover);
                        cmd.Parameters.AddWithValue("@PANAttachment", dtPANAttachment);

                        cmd.Parameters.AddWithValue("@PreviousHandlingCharge", txtPreviousHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisHandlingCharge", txtThisHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@PreviousOtherCharge", txtPreviousOtherCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisOtherCharge", txtThisOtherCharge.Text);

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
                        //tranScope.Complete();
                        // tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += strMessage;
                        script += "');";
                        script += "window.location = '";
                        script += "ListPurchaseAmendmentNote.aspx";
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
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalpurchaseordernumber.Text == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManagePurchaseAmendmentNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@PANRefID", "");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@PurchaseOrderNo", txtoriginalpurchaseordernumber.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@IndentProponent", txtIndentProponent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Dateofindent", txtDateofindent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Materialneededby", txtMaterialneededby.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockinHand", txtStockinHand.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockUOM", ddlStockinhandUOM.SelectedValue);
                        cmd.Parameters.AddWithValue("@Requirement", ddlRequirement.SelectedValue);
                        cmd.Parameters.AddWithValue("@UrgentReasonDesc", txtUrgetResionDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@AlreadyAwarded", txtAlreadyAwarded.Text.Trim());
                        cmd.Parameters.AddWithValue("@RevisedValue", txtrevisedvalue.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                        cmd.Parameters.AddWithValue("@VendorName", txtmenstionnameofvendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisRevCost", txtrevisedcostasperthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousRevCost", txtRevisedCostasperpreviousamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGST", txtPreviousGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGST", txtThisGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousFreight", txtPreviousFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisFreight", txtThisFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousHandlingCharges", txtPreviousHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisHandlingCharges", txtThisHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGrandTotal", txtPreviousGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGrandTotal", txtThisGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@PANMajorDeviation", dtPANMajorDeviation);
                        cmd.Parameters.AddWithValue("@PANBidEvaluation", dtPANBidEvaluation);
                        cmd.Parameters.AddWithValue("@PANApprover", dtPANApprover);
                        cmd.Parameters.AddWithValue("@PANAttachment", dtPANAttachment);
                        cmd.Parameters.AddWithValue("@PreviousHandlingCharge", txtPreviousHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisHandlingCharge", txtThisHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@PreviousOtherCharge", txtPreviousOtherCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisOtherCharge", txtThisOtherCharge.Text);
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
                        //tranScope.Complete();
                        //tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += strMessage;
                        script += "');";
                        script += "window.location = '";
                        script += "ListPurchaseAmendmentNote.aspx";
                        script += "'; }";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                    }
                }
            }
            catch (Exception ex)
            {
                //tranScope.Dispose();
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "window.onload = function(){ alert('" + ex.Message.ToString() + "');}", true); ;
            }
        }

    }
    private string UploadImage(string strID, FileUpload Fud)
    {
        string url = "";
        if (Fud.HasFile)
        {
            System.IO.FileInfo info = new System.IO.FileInfo(Fud.PostedFile.FileName);
            string strname = Guid.NewGuid().ToString() + strID + info.Extension.ToLower();
            url = strname;
            Fud.SaveAs(Server.MapPath("~/Upload/PAN/") + strname);
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
        DataTable dtPANMajorDeviation = new DataTable();
        DataTable dtPANBidEvaluation = new DataTable();
        DataTable dtPANApprover = new DataTable();
        DataTable dtPANAttachment = new DataTable();
        if (ViewState["dtDetailsSE"] != null)
            dtPANMajorDeviation = (DataTable)ViewState["dtDetailsSE"];
        if (ViewState["dtDetailsIH"] != null)
            dtPANBidEvaluation = (DataTable)ViewState["dtDetailsIH"];
        if (ViewState["dtDetailsApprover"] != null)
            dtPANApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtPANAttachment = (DataTable)ViewState["dtDetailsAttachment"];
        if (dtPANApprover.Rows.Count == 1)
        {
            int approverid = int.Parse(dtPANApprover.Rows[0]["ApproverID"].ToString());
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
            txtoriginalpurchaseordernumber.Text = orderNo;
        }
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
            try
            {
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalpurchaseordernumber.Text == "0")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManagePurchaseAmendmentNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@PANRefID", "");
                        cmd.Parameters.AddWithValue("@PurchaseOrderNo", txtoriginalpurchaseordernumber.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@IndentProponent", txtIndentProponent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Dateofindent", txtDateofindent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Materialneededby", txtMaterialneededby.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockinHand", txtStockinHand.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockUOM", ddlStockinhandUOM.SelectedValue);
                        cmd.Parameters.AddWithValue("@Requirement", ddlRequirement.SelectedValue);
                        cmd.Parameters.AddWithValue("@UrgentReasonDesc", txtUrgetResionDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@AlreadyAwarded", txtAlreadyAwarded.Text.Trim());
                        cmd.Parameters.AddWithValue("@RevisedValue", txtrevisedvalue.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                        cmd.Parameters.AddWithValue("@VendorName", txtmenstionnameofvendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisRevCost", txtrevisedcostasperthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousRevCost", txtRevisedCostasperpreviousamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGST", txtPreviousGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGST", txtThisGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousFreight", txtPreviousFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisFreight", txtThisFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousHandlingCharges", txtPreviousHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisHandlingCharges", txtThisHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGrandTotal", txtPreviousGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGrandTotal", txtThisGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@PANMajorDeviation", dtPANMajorDeviation);
                        cmd.Parameters.AddWithValue("@PANBidEvaluation", dtPANBidEvaluation);
                        cmd.Parameters.AddWithValue("@PANApprover", dtPANApprover);
                        cmd.Parameters.AddWithValue("@PANAttachment", dtPANAttachment);
                        cmd.Parameters.AddWithValue("@PreviousHandlingCharge", txtPreviousHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisHandlingCharge", txtThisHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@PreviousOtherCharge", txtPreviousOtherCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisOtherCharge", txtThisOtherCharge.Text);
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
                        //clear();
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
                        //tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += strMessage;
                        script += "');";
                        script += "window.location = '";
                        script += "ListPurchaseAmendmentNote.aspx";
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
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "" || txtoriginalpurchaseordernumber.Text == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope and Original Purchase Order No');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManagePurchaseAmendmentNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@PANRefID", "");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@PurchaseOrderNo", txtoriginalpurchaseordernumber.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@IndentProponent", txtIndentProponent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Dateofindent", txtDateofindent.Text.Trim());
                        cmd.Parameters.AddWithValue("@Materialneededby", txtMaterialneededby.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockinHand", txtStockinHand.Text.Trim());
                        cmd.Parameters.AddWithValue("@StockUOM", ddlStockinhandUOM.SelectedValue);
                        cmd.Parameters.AddWithValue("@Requirement", ddlRequirement.SelectedValue);
                        cmd.Parameters.AddWithValue("@UrgentReasonDesc", txtUrgetResionDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@Saleablearea", txtSaleableArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalBudget", txtApprovalBudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@AlreadyAwarded", txtAlreadyAwarded.Text.Trim());
                        cmd.Parameters.AddWithValue("@RevisedValue", txtrevisedvalue.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                        cmd.Parameters.AddWithValue("@VendorName", txtmenstionnameofvendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@OriginalAward", txtcostasperoriginalaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisRevCost", txtrevisedcostasperthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousRevCost", txtRevisedCostasperpreviousamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationPreviousvsthis", txtvariationprevsamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@VariationOriginalvsThis", txtvariationorignalvsthisamendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGST", txtPreviousGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGST", txtThisGST.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousFreight", txtPreviousFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisFreight", txtThisFreight.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousHandlingCharges", txtPreviousHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisHandlingCharges", txtThisHeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousGrandTotal", txtPreviousGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisGrandTotal", txtThisGrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@PreviousCostPerSqFt", txtPreviousCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThisCostPerSqFt", txtThisCostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@PANMajorDeviation", dtPANMajorDeviation);
                        cmd.Parameters.AddWithValue("@PANBidEvaluation", dtPANBidEvaluation);
                        cmd.Parameters.AddWithValue("@PANApprover", dtPANApprover);
                        cmd.Parameters.AddWithValue("@PANAttachment", dtPANAttachment);
                        cmd.Parameters.AddWithValue("@PreviousHandlingCharge", txtPreviousHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisHandlingCharge", txtThisHandlingCharge.Text);
                        cmd.Parameters.AddWithValue("@PreviousOtherCharge", txtPreviousOtherCharge.Text);
                        cmd.Parameters.AddWithValue("@ThisOtherCharge", txtThisOtherCharge.Text);
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
                        // tranScope.Complete();
                        //tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += strMessage;
                        script += "');";
                        script += "window.location = '";
                        script += "ListPurchaseAmendmentNote.aspx";
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
        //if (double.TryParse(txtAlreadyAwarded.Text, out dblAlreadyAwarded)) { }
        if (double.TryParse(txtrevisedvalue.Text, out dblrevisedvalue)) { }
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

    protected void txtcostasperoriginalaward_TextChanged(object sender, EventArgs e)
    {
        fillOrivsThis();
    }

    protected void txtRevisedCostasperpreviousamendment_TextChanged(object sender, EventArgs e)
    {
        fillPrevsThis();
    }

    protected void txtrevisedcostasperthisamendment_TextChanged(object sender, EventArgs e)
    {
        fillPrevsThis();
        fillOrivsThis();
    }

    private void fillPrevsThis()
    {
        double dblPrevious = 0;
        double dblThis = 0;
        double dblprevsthis = 0;
        if (double.TryParse(txtRevisedCostasperpreviousamendment.Text, out dblPrevious)) { }
        if (double.TryParse(txtrevisedcostasperthisamendment.Text, out dblThis)) { }
        dblprevsthis = dblPrevious - dblThis;
        txtvariationprevsamendment.Text = (Decimal.Round(Convert.ToDecimal(dblprevsthis), 2)).ToString();
        if (dblprevsthis > 0)
        {
            txtvariationprevsamendment.Style.Add("color", "Green");
        }
        else if (dblprevsthis < 0)
        {
            txtvariationprevsamendment.Style.Add("color", "Red");
        }
    }
    private void fillOrivsThis()
    {
        double dblOriginal = 0;
        double dblThis = 0;
        double dblOrivsthis = 0;
        if (double.TryParse(txtcostasperoriginalaward.Text, out dblOriginal)) { }
        if (double.TryParse(txtrevisedcostasperthisamendment.Text, out dblThis)) { }
        dblOrivsthis = dblOriginal - dblThis;
        txtvariationorignalvsthisamendment.Text = (decimal.Round(Convert.ToDecimal(dblOrivsthis), 2)).ToString();
        if (dblOrivsthis > 0)
        {
            txtvariationorignalvsthisamendment.Style.Add("color", "Green");
        }
        else if (dblOrivsthis < 0)
        {
            txtvariationorignalvsthisamendment.Style.Add("color", "Red");
        }
    }

    protected void txtPreviousQuantity_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblRate = 0;
        decimal dblValue = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtPreviousQuantity = (TextBox)row.FindControl("txtPreviousQuantity");
        TextBox txtPreviousRate = (TextBox)row.FindControl("txtPreviousRate");
        TextBox txtPreviousAmount = (TextBox)row.FindControl("txtPreviousAmount");
        if (decimal.TryParse(txtPreviousQuantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtPreviousRate.Text, out dblRate)) { }
        dblValue = (dblQuanity * dblRate);
        txtPreviousAmount.Text = dblValue.ToString();
    }

    protected void txtPreviousRate_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblRate = 0;
        decimal dblValue = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtPreviousQuantity = (TextBox)row.FindControl("txtPreviousQuantity");
        TextBox txtPreviousRate = (TextBox)row.FindControl("txtPreviousRate");
        TextBox txtPreviousAmount = (TextBox)row.FindControl("txtPreviousAmount");
        if (decimal.TryParse(txtPreviousQuantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtPreviousRate.Text, out dblRate)) { }
        dblValue = (dblQuanity * dblRate);
        txtPreviousAmount.Text = dblValue.ToString();
    }

    protected void txtThisQuantity_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblRate = 0;
        decimal dblValue = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtThisQuantity = (TextBox)row.FindControl("txtThisQuantity");
        TextBox txtThisRate = (TextBox)row.FindControl("txtThisRate");
        TextBox txtThisAmount = (TextBox)row.FindControl("txtThisAmount");
        if (decimal.TryParse(txtThisQuantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtThisRate.Text, out dblRate)) { }
        dblValue = (dblQuanity * dblRate);
        txtThisAmount.Text = dblValue.ToString();
    }

    protected void txtThisRate_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblRate = 0;
        decimal dblValue = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtThisQuantity = (TextBox)row.FindControl("txtThisQuantity");
        TextBox txtThisRate = (TextBox)row.FindControl("txtThisRate");
        TextBox txtThisAmount = (TextBox)row.FindControl("txtThisAmount");
        if (decimal.TryParse(txtThisQuantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtThisRate.Text, out dblRate)) { }
        dblValue = (dblQuanity * dblRate);
        txtThisAmount.Text = dblValue.ToString();
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
        decimal dblPreviousGST = 0;
        decimal dblThisGST = 0;
        decimal dblPreviousFreight = 0;
        decimal dblThisFreight = 0;
        decimal dblPreviousHeandlingCharges = 0;
        decimal dblThisHeandlingCharges = 0;
        decimal dblPreviousGrandTotal = 0;
        decimal dblThisGrandTotal = 0;
        decimal dblPreviousValue = 0;
        decimal dblThisValue = 0;

        decimal dblPreviousHandlingCharge = 0;
        decimal dblThisHandlingCharge = 0;
        decimal dblPreviousOtherCharge = 0;
        decimal dblThisOtherCharge = 0;


        if (decimal.TryParse(txtPreviousHandlingCharge.Text, out dblPreviousHandlingCharge)) { }
        if (decimal.TryParse(txtThisHandlingCharge.Text, out dblThisHandlingCharge)) { }
        if (decimal.TryParse(txtThisOtherCharge.Text, out dblThisOtherCharge)) { }
        if (decimal.TryParse(txtPreviousOtherCharge.Text, out dblPreviousOtherCharge)) { }

        if (decimal.TryParse(txtSaleableArea.Text, out dblSaleableArea)) { }
        if (decimal.TryParse(txtPreviousGST.Text, out dblPreviousGST)) { }
        if (decimal.TryParse(txtThisGST.Text, out dblThisGST)) { }
        if (decimal.TryParse(txtPreviousFreight.Text, out dblPreviousFreight)) { }
        if (decimal.TryParse(txtThisFreight.Text, out dblThisFreight)) { }
        if (decimal.TryParse(txtPreviousHeadlingCharges.Text, out dblPreviousHeandlingCharges)) { }
        if (decimal.TryParse(txtThisHeadlingCharges.Text, out dblThisHeandlingCharges)) { }
        if (decimal.TryParse(gvItemHead.FooterRow.Cells[6].Text, out dblPreviousValue)) { }
        if (decimal.TryParse(gvItemHead.FooterRow.Cells[11].Text, out dblThisValue)) { }
        dblPreviousGrandTotal = (dblPreviousValue + dblPreviousGST + dblPreviousFreight + dblPreviousHeandlingCharges + dblPreviousHandlingCharge + dblPreviousOtherCharge);
        dblThisGrandTotal = (dblThisValue + dblThisGST + dblThisFreight + dblThisHeandlingCharges + dblThisHandlingCharge + dblThisOtherCharge);
        if (dblSaleableArea > 0)
        {
            dblPreviousCostpersqft = dblPreviousGrandTotal / dblSaleableArea;
            dblThisCostpersqft = dblThisGrandTotal / dblSaleableArea;
        }
        txtPreviousGrandTotal.Text = dblPreviousGrandTotal.ToString();
        txtThisGrandTotal.Text = dblThisGrandTotal.ToString();
        txtPreviousCostPerSqft.Text = Math.Round(dblPreviousCostpersqft, 2).ToString();
        txtThisCostPerSqft.Text = Math.Round(dblThisCostpersqft, 2).ToString();
    }

    protected void txtSaleableArea_TextChanged(object sender, EventArgs e)
    {
        CalCostPersqft();
    }

    protected void ddlReasonofvariation_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlReasonofvariation.SelectedValue == "Others")
        {
            txtother.Text = "";
            txtother.ReadOnly = false;
            rvreasonforothers.Visible = true;
        }
        else
        {
            txtother.Text = "";
            txtother.ReadOnly = true;
            rvreasonforothers.Visible = false;
        }
    }

    public string AmendmentOrderNo()
    {
        string orderNo = cls.ExecuteStringScalar("select PurchaseOrderNo from tbl_PurchaseAmendmentNote where PANOrderNo='" + txtoriginalpurchaseordernumber.Text + "'");
        return orderNo;
    }
    #region Download Attachment
    public void lnkDownloadDocImage_Click(Object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        var filePath = Server.MapPath("../Upload/PAN/") + btn.Text + "";
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + btn.Text + "");
        Response.TransmitFile(filePath);
        Response.End();
    }
    public void lnkDownloadDocFile_Click(Object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        var filePath = Server.MapPath("../Upload/PAN/") + btn.Text + "";
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + btn.Text + "");
        Response.TransmitFile(filePath);
        Response.End();
    }
    #endregion Download Attachment

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetApprovalNo(string prefixText)
    {
        cls_connection_new cls = new cls_connection_new();
        DataTable dt = cls.selectDataTable("select PANOrderNo from tbl_PurchaseAmendmentNote where PANOrderNo like '%" + prefixText + "%' and IsActive=1 and PANOrderNo is not null and PANOrderNo<>''");
        List<string> list = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            list.Add(dt.Rows[i]["PANOrderNo"].ToString());
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

    protected void txtoriginalpurchaseordernumber_TextChanged(object sender, EventArgs e)
    {
        if (txtoriginalpurchaseordernumber.Text != "")
        {
            int ID = cls.ExecuteIntScalar("select ID From tbl_PurchaseAmendmentNote where PANOrderNo='" + txtoriginalpurchaseordernumber.Text + "' and IsActive=1 and PANOrderNo is not null and PANOrderNo<>''");
            FillData(ID);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "fillVariationofBudget();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillPrevsThis", "fillPrevsThis();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillOrivsThis", "fillOrivsThis();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ddlChange", "ddlChange();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);

        }
    }

    //protected void ddlapprovaltype_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (txtoriginalpurchaseordernumber.Text != "")
    //    {
    //        int ID = cls.ExecuteIntScalar("select ID From tbl_PurchaseAmendmentNote where PANOrderNo='" + txtoriginalpurchaseordernumber.Text + "' and IsActive=1 and PANOrderNo is not null and PANOrderNo<>''");
    //        FillData(ID);
    //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "fillVariationofBudget();", true);
    //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillPrevsThis", "fillPrevsThis();", true);
    //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillOrivsThis", "fillOrivsThis();", true);
    //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ddlChange", "ddlChange();", true);
    //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);

    //    }
    //}
}