using iTextSharp.text;
using iTextSharp.text.pdf;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_SalesLogicNote : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    DataTable dtUser = new DataTable();
    DataTable dt = new DataTable();
    int rowCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserSession"] == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                cls.BindDropDownList(ddlapprovalauthrity, "EXEC sp_CommitteeMaster 'GetAllforddl'", "CommitteeName", "ID");
                cls.BindDropDownList(ddlCompanyName, "EXEC sp_CompanyMaster 'GetAllforddl'", "CompanyName", "ID");
                cls.BindDropDownList(ddlDepartment, "EXEC sp_DepartmentMaster 'GetAllforddl'", "DepartmentName", "ID");
                //cls.BindDropDownList(ddlprojectname, "EXEC sp_ProjectMaster 'GetAllforddl'", "ProjectName", "ID");
                //ddlprojectname_SelectedIndexChanged(null, null);

                if (Request.QueryString["ID"] != null)
                {
                    FillData(Convert.ToInt32(Request.QueryString["ID"]));
                    hdnID.Value = Request.QueryString["ID"].ToString();
                }
                else
                {
                    BindPaymentPlan("0");
                    FillDtApprover("0");
                    FillDtAttachment("0");
                    FillPaymentDetails("0");
                }
            }
        }
        catch { }
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ddlChange", "ddlChange();", true);
    }
    public void FillData(int ID)
    {
        dtData = cls.selectDataTable("EXEC sp_ManageSalesLogicNote 'GetByID','" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            if (dtData.Rows[0]["IsSubmitted"].ToString().ToUpper() == "TRUE")
            {
                btnSubmit.Enabled = false;
                btnSubmitforApproval.Enabled = false;
            }

            ddlapprovalauthrity.SelectedValue = dtData.Rows[0]["ApprovalAuthrityID"].ToString();
            ddlCompanyName.SelectedValue = dtData.Rows[0]["CompanyID"].ToString();
            txtSubjectScope.Text = dtData.Rows[0]["SubjectandScope"].ToString();

            ddlDepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
            ddlApproval.SelectedValue = dtData.Rows[0]["Approvaltype"].ToString();
            ddlApprovalPriority.SelectedValue = dtData.Rows[0]["ApprovalPriority"].ToString();

            if (dtData.Rows[0]["SLNOrderNo"].ToString() != "")
            {
                txtApprovalNo.Text = dtData.Rows[0]["SLNOrderNo"].ToString();
            }
            else
            {
                txtApprovalNo.Text = dtData.Rows[0]["ApprovalNo"].ToString();
            }


            txtUrjentRemarks.Text = dtData.Rows[0]["UrjentRemarks"].ToString();
            ddlstatus.SelectedItem.Text = dtData.Rows[0]["Status"].ToString();
            txtReasonofAmendment.Text = dtData.Rows[0]["ReasonOfAmendent"].ToString();
            txtother.Text = dtData.Rows[0]["OtherDescription"].ToString();
            txtCustomerName.Text = dtData.Rows[0]["CustomerName"].ToString();
            txtNegotiationMode.Text = dtData.Rows[0]["NegotiationMode"].ToString();
            ckApprovalSought.Text = dtData.Rows[0]["ApprovalSought"].ToString();

            txtChannelPartnerName.Text = dtData.Rows[0]["ChannelPartnerName"].ToString();
            txtUnitNo.Text = dtData.Rows[0]["UnitNo"].ToString();
            txtOldUnitNo.Text = dtData.Rows[0]["OldUnitNo"].ToString();
            txtSuperArea.Text = dtData.Rows[0]["SuperArea"].ToString();
            txtBSP.Text = dtData.Rows[0]["BSP"].ToString();
            txtEDC_IDC.Text = dtData.Rows[0]["EDC_IDC"].ToString();
            txtTCV.Text = dtData.Rows[0]["TCV"].ToString();
            txtOtherCharge.Text = dtData.Rows[0]["OtherCharges"].ToString();
            txtRegNo.Text = dtData.Rows[0]["RegNo"].ToString();
            txtEIC.Text = dtData.Rows[0]["EIC"].ToString();
            txtCarParking.Text = dtData.Rows[0]["CarParking"].ToString();
            txtPLC.Text = dtData.Rows[0]["PLC"].ToString();
            ckremark.Text = dtData.Rows[0]["Remark"].ToString();
            txtProfessionCharge.Text = dtData.Rows[0]["PossessionCharges"].ToString();
            chkHeadOfDepartMent.Text = dtData.Rows[0]["HeadOfDepartment"].ToString();
            int status = cls.ExecuteIntScalar("select count(1) from tbl_SalesLogicNote where ID=" + ID + " and IsSubmitted=1");
            if (status == 0)
            {
                ddlstatus.SelectedValue = "Draft";
            }
            else
            {
                status = cls.ExecuteIntScalar("select count(1) from tbl_SalesLogicNote where ID=" + ID + " and IsCommitteeApproved=1");
                if (status == 0)
                {
                    ddlstatus.SelectedValue = "Pending";
                }
                else
                {
                    ddlstatus.SelectedValue = "Approved";
                }
            }
            dvStatus.Visible = true;
            if (dtData.Rows[0]["ApprovalPriority"].ToString() == "Normal")
            {
                txtUrjentRemarks.Enabled = false;
            }
            if (dtData.Rows[0]["ApprovalType"].ToString() == "1")
            {
                txtReasonofAmendment.Enabled = false;
            }
            if (ddlApproval.SelectedValue == "2")
            {
                txtReasonofAmendment.Enabled = true;
            }

            if (dtData.Rows[0]["ProjectID"].ToString() != "0")
            {
                DataTable dt = cls.selectDataTable("EXEC sp_ProjectMaster 'GetAllforddl',0,'" + dtData.Rows[0]["CompanyID"].ToString() + "'");
                ddlprojectname.DataTextField = "ProjectName";
                ddlprojectname.DataValueField = "ID";
                ddlprojectname.DataSource = dt;
                ddlprojectname.DataBind();
            }
            ddlprojectname.SelectedValue = dtData.Rows[0]["ProjectID"].ToString();
            ddlprojectname_SelectedIndexChanged(null, null);
            hiddenprojectnamevalue.Value = dtData.Rows[0]["ProjectID"].ToString();
        }
        BindPaymentPlan(ID.ToString());
        FillDtApprover(ID.ToString());
        FillDtAttachment(ID.ToString());
        FillPaymentDetails(ID.ToString());

    }
    #region Payment Plan

    private void AddNewPaymentPlanRow()
    {
        if (ViewState["dtPaymentPlan"] != null)
        {
            //SetDataPaymentPlan();
            dt = (DataTable)ViewState["dtPaymentPlan"];
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["PaymentTerms"] = "";
            dr["Amount"] = "";
            dr["Description"] = "";
            dr["Remark"] = "";
            dt.Rows.Add(dr);
            ViewState["dtPaymentPlan"] = dt;
        }
        else
        {
            BindPaymentPlan("0");
        }
    }

    private void SetDataPaymentPlan()
    {
        DataTable dtPaymentPlan = new DataTable();
        if (hdnSetPaymentPlan.Value != "")
        {
            dtPaymentPlan = (DataTable)JsonConvert.DeserializeObject(hdnSetPaymentPlan.Value, (typeof(DataTable)));
            ViewState["dtPaymentPlan"] = dtPaymentPlan;
        }
        else
        {
            dtPaymentPlan.Columns.Add("ID");
            dtPaymentPlan.Columns.Add("PaymentTerms");
            dtPaymentPlan.Columns.Add("Amount");
            dtPaymentPlan.Columns.Add("Description");
            dtPaymentPlan.Columns.Add("Remark");
            int i = 1;
            foreach (GridViewRow row in gvItemHead.Rows)
            {
                DataRow dr = dtPaymentPlan.NewRow();
                TextBox ckPaymentTerms = (TextBox)row.FindControl("ckPaymentTerms");
                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                TextBox ckDescription = (TextBox)row.FindControl("ckDescription");
                TextBox ckRemark = (TextBox)row.FindControl("ckRemark");

                dr["PaymentTerms"] = ckPaymentTerms.Text;
                dr["Amount"] = txtAmount.Text;
                dr["Description"] = ckDescription.Text;
                dr["Remark"] = ckRemark.Text;
                dr["ID"] = i.ToString();
                dtPaymentPlan.Rows.Add(dr);
                i = i + 1;
            }
            ViewState["dtPaymentPlan"] = dtPaymentPlan;
        }
        gvItemHead.DataSource = dtPaymentPlan;
        gvItemHead.DataBind();

    }

    private void BindPaymentPlan(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,PaymentTerms,Amount,[Description],Remark from tbl_SalesPaymentPlan where IsDelete=0 and SalesID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtPaymentPlan"] = dtData;
        }
        else
        {
            dtData = cls.selectDataTable("Select ID, Terms as PaymentTerms,'0' as Amount,'' as Description,'' as Remark from tblpaymentTerms ");
            if (dtData.Rows.Count > 0)
            {
                ViewState["dtPaymentPlan"] = dtData;

            }
            else
            {
                ViewState["dtPaymentPlan"] = null;
                dt = new DataTable();
                dt.Columns.Add("ID", typeof(int));
                dt.Columns.Add("PaymentTerms", typeof(string));
                dt.Columns.Add("Amount", typeof(string));
                dt.Columns.Add("Description", typeof(string));
                dt.Columns.Add("Remark", typeof(string));
                ViewState["dtPaymentPlan"] = dt;
            }
        }

        dt = (DataTable)ViewState["dtPaymentPlan"];
        rowCount = dt.Rows.Count;
        if (dt.Rows.Count == 0)
        {
            AddNewPaymentPlanRow();
        }
        gvItemHead.DataSource = dt;
        gvItemHead.DataBind();
    }
    #endregion Payment Plan

    #region Payment Plan
    protected void grdPaymentDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNewPaymentDetails();
        }

        if (e.CommandName == "Delete")
        {
            SetPaymentDetails();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtPaymentDetails"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtPaymentDetails"] = dtData;
                grdPaymentDetails.DataSource = dtData;
                grdPaymentDetails.DataBind();
            }
            else
            {
                //cls.ExecuteQuery("EXEC sp_ManagePurchaseLogicNote 'DeletePLNApprover','" + e.CommandArgument + "'");
                //DataTable dtData = (DataTable)ViewState["dtDetailsApprover"];
                //dtData.Rows.RemoveAt(RowIndex);
                //ViewState["dtDetailsApprover"] = dtData;
                //gvApprover.DataSource = dtData;
                //gvApprover.DataBind();
            }
        }

    }

    protected void grdPaymentDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void grdPaymentDetails_PreRender(object sender, EventArgs e)
    {
        int count = grdPaymentDetails.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = grdPaymentDetails.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = grdPaymentDetails.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }

    protected void grdPaymentDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        }
    }

    private void AddNewPaymentDetails()
    {
        if (ViewState["dtPaymentDetails"] != null)
        {
            SetPaymentDetails();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["Description"] = "";
            dt.Rows.Add(dr);

            ViewState["dtPaymentDetails"] = dt;
            grdPaymentDetails.DataSource = dt;
            grdPaymentDetails.DataBind();
        }
        else
        {
            FillPaymentDetails("0");
            AddNewPaymentDetails();
        }
    }
    private void FillPaymentDetails(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,Description,Amount,PaymentMode,Remark from tbl_SalesPaymentDetails where IsDelete=0 and SalesID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtPaymentDetails"] = dtData;

        }
        else
        {
            ViewState["dtPaymentDetails"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("Description");
            dt.Columns.Add("Amount");
            dt.Columns.Add("PaymentMode");
            dt.Columns.Add("Remark");
            ViewState["dtPaymentDetails"] = dt;
        }
        dt = (DataTable)ViewState["dtPaymentDetails"];
        if (dt.Rows.Count == 0)
        {
            AddNewPaymentDetails();
        }
        grdPaymentDetails.DataSource = dt;
        grdPaymentDetails.DataBind();
    }
    private void SetPaymentDetails()
    {
        DataTable dtPaymentDetails = new DataTable();
        if (hdnSetPaymentDetails.Value != "")
        {
            dtPaymentDetails = (DataTable)JsonConvert.DeserializeObject(hdnSetPaymentDetails.Value, (typeof(DataTable)));
            ViewState["dtPaymentDetails"] = dtPaymentDetails;
        }
        else
        {

            dtPaymentDetails.Columns.Add("ID");
            dtPaymentDetails.Columns.Add("Description");
            dtPaymentDetails.Columns.Add("Amount");
            dtPaymentDetails.Columns.Add("PaymentMode");
            dtPaymentDetails.Columns.Add("Remark");

            int i = 1;
            foreach (GridViewRow row in grdPaymentDetails.Rows)
            {
                DataRow dr = dtPaymentDetails.NewRow();
                TextBox ckDescription = (TextBox)row.FindControl("ckDescription");
                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                TextBox txtPaymentMode = (TextBox)row.FindControl("txtPaymentMode");
                TextBox ckRemarks = (TextBox)row.FindControl("ckRemarks");
                dr["Description"] = ckDescription.Text;
                dr["Amount"] = txtAmount.Text;
                dr["PaymentMode"] = txtPaymentMode.Text;
                dr["Remark"] = ckRemarks.Text;
                dr["ID"] = i.ToString();
                dtPaymentDetails.Rows.Add(dr);
                i = i + 1;
            }
            ViewState["dtPaymentDetails"] = dtPaymentDetails;
        }
        grdPaymentDetails.DataSource = dtPaymentDetails;
        grdPaymentDetails.DataBind();

    }
    #endregion  #region Payment Plan



    #region Approver
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

    protected void gvApprover_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

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
                cls.ExecuteQuery("EXEC sp_ManageSalesLogicNote 'DeleteSalesApprover','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsApprover"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsApprover"] = dtData;
                gvApprover.DataSource = dtData;
                gvApprover.DataBind();
            }
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
        DataTable dtData = cls.selectDataTable("select ID,ApproverID from tbl_SalesApprover where IsDelete=0 and SalesID='" + ID + "'");
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

    #endregion Approver



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
                cls.ExecuteQuery("EXEC sp_ManagePurchaseLogicNote 'DeletePLNAttachment','" + e.CommandArgument + "'");
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
            //DropDownList ddlAttechmentCategory = (e.Row.FindControl("ddlAttechmentCategory") as DropDownList);
            // HiddenField hddCategory = (e.Row.FindControl("hddCategory") as HiddenField);
            // ddlAttechmentCategory.SelectedValue = hddCategory.Value;
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
        DataTable dtSLNAttachment = new DataTable();

        if (hdnAttachmentData.Value != "")
        {
            dtSLNAttachment = (DataTable)JsonConvert.DeserializeObject(hdnAttachmentData.Value, (typeof(DataTable)));
            ViewState["dtDetailsAttachment"] = dtSLNAttachment;
        }
        else
        {
            dtSLNAttachment.Columns.Add("ID");
            dtSLNAttachment.Columns.Add("Description");
            dtSLNAttachment.Columns.Add("DocFile");
            dtSLNAttachment.Columns.Add("DocImage");

            string strFileName = "";
            int i = 1;
            foreach (GridViewRow row in gvAttachment.Rows)
            {
                DataRow dr = dtSLNAttachment.NewRow();
                TextBox txtDescription = (TextBox)row.FindControl("txtDescription");
                FileUpload fudFile = (FileUpload)row.FindControl("fudFile");
                FileUpload fudImage = (FileUpload)row.FindControl("fudImage");
                LinkButton lnkDownloadDocFile = row.FindControl("lnkDownloadDocFile") as LinkButton;
                LinkButton lnkDownloadDocImage = row.FindControl("lnkDownloadDocImage") as LinkButton;
                if (fudFile.HasFile)
                {
                    string fname = Path.GetFileNameWithoutExtension(fudFile.FileName).Replace(" ", "_");
                    if (Request.QueryString["ID"] == null)
                    {
                        strFileName = UploadImage("_Image_", fudImage);
                    }
                    else
                    {
                        strFileName = UploadImage("_Image_", fudFile);

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

                dr["ID"] = i.ToString();
                dr["Description"] = txtDescription.Text;
                dtSLNAttachment.Rows.Add(dr);
                i = i + 1;

            }
            ViewState["dtDetailsAttachment"] = dtSLNAttachment;
        }
        gvAttachment.DataSource = dtSLNAttachment;
        gvAttachment.DataBind();

    }
    private void FillDtAttachment(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,Description,DocFile,DocImage from tbl_SalesAttachment where IsDelete=0 and SalesID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsAttachment"] = dtData;
        }
        else
        {
            ViewState["dtDetailsAttachment"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
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
        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/SLN/") + DocFile))
        {
            if (Request.QueryString["ID"] != null)
            {
                string PLNID = Request.QueryString["ID"].ToString();
                DataTable dtPLNOrderNo = new DataTable();
                dtPLNOrderNo = cls.selectDataTable(" select b.SLNOrderNo from tbl_SalesApprover a inner join tbl_SalesLogicNote b on a.SalesID=b.ID Where a.IsApprove=1 And  a.SalesID='" + PLNID + "' and a.IsDelete=0");
                if (dtPLNOrderNo.Rows.Count > 0)
                {
                    if (dtPLNOrderNo.Rows.Count > 0)
                    {
                        string filePath = Server.MapPath("../Upload/SLN/") + ID + PLNID + Type + DocFile;
                        if (Type == "PDF")
                        {
                            PdfReader reader = new PdfReader(Server.MapPath("../Upload/SLN/") + DocFile);
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
                                ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtPLNOrderNo.Rows[0]["SLNOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15,iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
                                over.RestoreState();
                            }
                            stamper.Close();
                            reader.Close();
                        }
                        else if (Type == "Image")
                        {
                            PointF firstLocation = new PointF(10f, 10f);
                            string imageFilePath = Server.MapPath("../Upload/SLN/") + DocFile;
                            Bitmap newBitmap;
                            using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFilePath))//load the image file
                            {
                                using (Graphics graphics = Graphics.FromImage(bitmap))
                                {
                                    using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12,FontStyle.Bold))
                                    {                                       
                                        System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);                                       
                                        graphics.DrawString(dtPLNOrderNo.Rows[0]["SLNOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);                                       
                                    }
                                }
                                newBitmap = new Bitmap(bitmap);
                            }
                            newBitmap.Save(filePath);//save the image file
                            newBitmap.Dispose();
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
                        var filePath = Server.MapPath("../Upload/SLN/") + DocFile + "";
                        Response.ContentType = "application/octet-stream";
                        Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                        Response.TransmitFile(filePath);
                        Response.End();
                    }
                }
                else
                {
                    var filePath = Server.MapPath("../Upload/SLN/") + DocFile + "";
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                    Response.TransmitFile(filePath);
                    Response.End();

                }
            }
            else
            {
                var filePath = Server.MapPath("../Upload/SLN/") + DocFile + "";
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
        //cls.BindDropDownList(ddllocation, "EXEC sp_LocationMaster 'GetByProjectID','" + ddlprojectname.SelectedValue + "'", "LocationName", "ID");
    }
    protected void ddlRequirement_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlRequirement.SelectedValue == "Urgent")
        //{
        //txtUrgetResionDescription.Text = "";
        //txtUrgetResionDescription.ReadOnly = false;
        //RFVUrgetReason.Visible = true;

        //txtUrgetResionDescription.Text = "";
        //txtUrgetResionDescription.ReadOnly = true;
        //RFVUrgetReason.Visible = false;

    }
    public string AmendmentOrderNo()
    {
        string orderNo = cls.ExecuteStringScalar("select ApprovalNo from tbl_SalesLogicNote where SLNOrderNo='" + txtApprovalNo.Text + "' and SLNOrderNo like '%R0%'");
        return orderNo;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        SetDataApprover();
        SetDataAttachment();
        SetPaymentDetails();
        SetDataPaymentPlan();

        DataTable dtSLNPaymentPlan = new DataTable();
        DataTable dtSLNPaymnetDetails = new DataTable();
        DataTable dtSLNApprover = new DataTable();
        DataTable dtSLNAttachment = new DataTable();
        if (ViewState["dtPaymentPlan"] != null)
            dtSLNPaymentPlan = (DataTable)ViewState["dtPaymentPlan"];
        if (ViewState["dtPaymentDetails"] != null)
            dtSLNPaymnetDetails = (DataTable)ViewState["dtPaymentDetails"];
        if (ViewState["dtDetailsApprover"] != null)
            dtSLNApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtSLNAttachment = (DataTable)ViewState["dtDetailsAttachment"];

        dtUser = (DataTable)Session["UserSession"];
        if (ddlApproval.SelectedValue == "2")
        {
            string orderNo = AmendmentOrderNo();
            if (orderNo != "")
            {
                txtApprovalNo.Text = orderNo;
            }

        }
        if (dtSLNApprover.Rows.Count == 1)
        {
            int approverid = int.Parse(dtSLNApprover.Rows[0]["ApproverID"].ToString());
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
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
            try
            {
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManageSalesLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@SLNRefID", "");
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@ProjectID", hiddenprojectnamevalue.Value);
                        cmd.Parameters.AddWithValue("@LocationID", 0);
                        cmd.Parameters.AddWithValue("@ApprovalType", ddlApproval.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalPriority", ddlApprovalPriority.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@UrjentRemarks", txtUrjentRemarks.Text.Trim());
                        cmd.Parameters.AddWithValue("@Status", ddlstatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendent", txtReasonofAmendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@NegotiationMode", txtNegotiationMode.Text);
                        cmd.Parameters.AddWithValue("@ApprovalSought", ckApprovalSought.Text.Trim());
                        cmd.Parameters.AddWithValue("@ChannelPartnername", txtChannelPartnerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UnitNo", txtUnitNo.Text);
                        cmd.Parameters.AddWithValue("@OldUnitNo", txtOldUnitNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@CarParking", txtCarParking.Text.Trim());
                        cmd.Parameters.AddWithValue("@SuperArea", txtSuperArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@BSP", txtBSP.Text.Trim());
                        cmd.Parameters.AddWithValue("@PLC", txtPLC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EDC_IDC", txtEDC_IDC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EIC", txtEIC.Text.Trim());
                        cmd.Parameters.AddWithValue("@TCV", txtTCV.Text.Trim());
                        cmd.Parameters.AddWithValue("@PossessionCharges", txtProfessionCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherCharges", txtOtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@RegNo", txtRegNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@HeadOfDepartment", chkHeadOfDepartMent.Text.Trim());
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                        cmd.Parameters.AddWithValue("@SLNApprover", dtSLNApprover);
                        cmd.Parameters.AddWithValue("@SLNAttachment", dtSLNAttachment);
                        cmd.Parameters.AddWithValue("@SLNPaymentPlan", dtSLNPaymentPlan);
                        cmd.Parameters.AddWithValue("@SLNPaymentDetails", dtSLNPaymnetDetails);
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
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += message;
                        script += "');}";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

                        //clear();
                    }
                    else
                    {
                        // tranScope.Complete();
                        // tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += message;
                        script += "');";
                        script += "window.location = '";
                        script += "ListSalesLogicNote.aspx";
                        script += "'; }";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

                    }
                }
            }
            catch (Exception ex)
            {
                // tranScope.Dispose();
                string message = ex.Message.ToString();
                string script = "window.onload = function(){ alert('";
                script += message;
                script += "');}";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);


            }

        }
        else if (Request.QueryString["ID"] != null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
            try
            {
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManageSalesLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@SLNRefID", "");
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@ProjectID", hiddenprojectnamevalue.Value);
                        cmd.Parameters.AddWithValue("@LocationID", 0);
                        cmd.Parameters.AddWithValue("@ApprovalType", ddlApproval.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalPriority", ddlApprovalPriority.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@UrjentRemarks", txtUrjentRemarks.Text.Trim());
                        cmd.Parameters.AddWithValue("@Status", ddlstatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendent", txtReasonofAmendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@NegotiationMode", txtNegotiationMode.Text);
                        cmd.Parameters.AddWithValue("@ApprovalSought", ckApprovalSought.Text.Trim());
                        cmd.Parameters.AddWithValue("@ChannelPartnername", txtChannelPartnerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UnitNo", txtUnitNo.Text);
                        cmd.Parameters.AddWithValue("@OldUnitNo", txtOldUnitNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@CarParking", txtCarParking.Text.Trim());
                        cmd.Parameters.AddWithValue("@SuperArea", txtSuperArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@BSP", txtBSP.Text.Trim());
                        cmd.Parameters.AddWithValue("@PLC", txtPLC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EDC_IDC", txtEDC_IDC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EIC", txtEIC.Text.Trim());
                        cmd.Parameters.AddWithValue("@TCV", txtTCV.Text.Trim());
                        cmd.Parameters.AddWithValue("@PossessionCharges", txtProfessionCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherCharges", txtOtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@RegNo", txtRegNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@HeadOfDepartment", chkHeadOfDepartMent.Text.Trim());
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                        cmd.Parameters.AddWithValue("@SLNApprover", dtSLNApprover);
                        cmd.Parameters.AddWithValue("@SLNAttachment", dtSLNAttachment);
                        cmd.Parameters.AddWithValue("@SLNPaymentPlan", dtSLNPaymentPlan);
                        cmd.Parameters.AddWithValue("@SLNPaymentDetails", dtSLNPaymnetDetails);
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
                        //tranScope.Complete();
                        // tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += strMessage;
                        script += "');";
                        script += "window.location = '";
                        script += "ListSalesLogicNote.aspx";
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

    }
    private string UploadImage(string strID, FileUpload Fud)
    {
        string url = "";
        if (Fud.HasFile)
        {
            System.IO.FileInfo info = new System.IO.FileInfo(Fud.PostedFile.FileName);
            string strname = Guid.NewGuid().ToString() + strID + info.Extension.ToLower();
            url = strname;
            Fud.SaveAs(Server.MapPath("~/Upload/SLN/") + strname);
        }
        return url;
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {

    }

    protected void btnSubmitforApproval_Click(object sender, EventArgs e)
    {

        SetDataApprover();
        SetDataAttachment();
        SetPaymentDetails();
        SetDataPaymentPlan();

        DataTable dtSLNPaymentPlan = new DataTable();
        DataTable dtSLNPaymnetDetails = new DataTable();
        DataTable dtSLNApprover = new DataTable();
        DataTable dtSLNAttachment = new DataTable();
        if (ViewState["dtPaymentPlan"] != null)
            dtSLNPaymentPlan = (DataTable)ViewState["dtPaymentPlan"];
        if (ViewState["dtPaymentDetails"] != null)
            dtSLNPaymnetDetails = (DataTable)ViewState["dtPaymentDetails"];
        if (ViewState["dtDetailsApprover"] != null)
            dtSLNApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtSLNAttachment = (DataTable)ViewState["dtDetailsAttachment"];

        dtUser = (DataTable)Session["UserSession"];
        if (ddlApproval.SelectedValue == "2")
        {
            string orderNo = AmendmentOrderNo();
            if (orderNo != "")
            {
                txtApprovalNo.Text = orderNo;
            }

        }
        if (dtSLNApprover.Rows.Count == 1)
        {
            int approverid = int.Parse(dtSLNApprover.Rows[0]["ApproverID"].ToString());
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

        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
            try
            {
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManageSalesLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@SLNRefID", "");
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@ProjectID", hiddenprojectnamevalue.Value);
                        cmd.Parameters.AddWithValue("@LocationID", 0);
                        cmd.Parameters.AddWithValue("@ApprovalType", ddlApproval.SelectedValue);

                        cmd.Parameters.AddWithValue("@ApprovalPriority", ddlApprovalPriority.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@UrjentRemarks", txtUrjentRemarks.Text.Trim());
                        cmd.Parameters.AddWithValue("@Status", ddlstatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendent", txtReasonofAmendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@NegotiationMode", txtNegotiationMode.Text);
                        cmd.Parameters.AddWithValue("@ApprovalSought", ckApprovalSought.Text.Trim());
                        cmd.Parameters.AddWithValue("@ChannelPartnername", txtChannelPartnerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UnitNo", txtUnitNo.Text);
                        cmd.Parameters.AddWithValue("@OldUnitNo", txtOldUnitNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@CarParking", txtCarParking.Text.Trim());
                        cmd.Parameters.AddWithValue("@SuperArea", txtSuperArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@BSP", txtBSP.Text.Trim());
                        cmd.Parameters.AddWithValue("@PLC", txtPLC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EDC_IDC", txtEDC_IDC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EIC", txtEIC.Text.Trim());
                        cmd.Parameters.AddWithValue("@TCV", txtTCV.Text.Trim());
                        cmd.Parameters.AddWithValue("@PossessionCharges", txtProfessionCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherCharges", txtOtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@RegNo", txtRegNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@HeadOfDepartment", chkHeadOfDepartMent.Text.Trim());
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                        cmd.Parameters.AddWithValue("@SLNApprover", dtSLNApprover);
                        cmd.Parameters.AddWithValue("@SLNAttachment", dtSLNAttachment);
                        cmd.Parameters.AddWithValue("@SLNPaymentPlan", dtSLNPaymentPlan);
                        cmd.Parameters.AddWithValue("@SLNPaymentDetails", dtSLNPaymnetDetails);
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
                        // tranScope.Complete();
                        // tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += strMessage;
                        script += "');";
                        script += "window.location = '";
                        script += "ListSalesLogicNote.aspx";
                        script += "'; }";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                    }
                }
            }
            catch (Exception ex)
            {
                //tranScope.Dispose();
                string message = ex.Message.ToString();
                string script = "window.onload = function(){ alert('";
                script += message;
                script += "');}";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

            }

        }
        else if (Request.QueryString["ID"] != null)
        {
            //using (TransactionScope tranScope = new TransactionScope())
            //{
            try
            {
                if (Convert.ToInt32(ddlapprovalauthrity.SelectedValue) == 0 || txtSubjectScope.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Approval Authrity and Subject and scope');", true);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ManageSalesLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@SLNRefID", "");
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@ProjectID", hiddenprojectnamevalue.Value);
                        cmd.Parameters.AddWithValue("@LocationID", 0);
                        cmd.Parameters.AddWithValue("@ApprovalType", ddlApproval.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalPriority", ddlApprovalPriority.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@UrjentRemarks", txtUrjentRemarks.Text.Trim());
                        cmd.Parameters.AddWithValue("@Status", ddlstatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendent", txtReasonofAmendment.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@NegotiationMode", txtNegotiationMode.Text);
                        cmd.Parameters.AddWithValue("@ApprovalSought", ckApprovalSought.Text.Trim());
                        cmd.Parameters.AddWithValue("@ChannelPartnername", txtChannelPartnerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UnitNo", txtUnitNo.Text);
                        cmd.Parameters.AddWithValue("@OldUnitNo", txtOldUnitNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@CarParking", txtCarParking.Text.Trim());
                        cmd.Parameters.AddWithValue("@SuperArea", txtSuperArea.Text.Trim());
                        cmd.Parameters.AddWithValue("@BSP", txtBSP.Text.Trim());
                        cmd.Parameters.AddWithValue("@PLC", txtPLC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EDC_IDC", txtEDC_IDC.Text.Trim());
                        cmd.Parameters.AddWithValue("@EIC", txtEIC.Text.Trim());
                        cmd.Parameters.AddWithValue("@TCV", txtTCV.Text.Trim());
                        cmd.Parameters.AddWithValue("@PossessionCharges", txtProfessionCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherCharges", txtOtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@RegNo", txtRegNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@HeadOfDepartment", chkHeadOfDepartMent.Text.Trim());
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                        cmd.Parameters.AddWithValue("@SLNApprover", dtSLNApprover);
                        cmd.Parameters.AddWithValue("@SLNAttachment", dtSLNAttachment);
                        cmd.Parameters.AddWithValue("@SLNPaymentPlan", dtSLNPaymentPlan);
                        cmd.Parameters.AddWithValue("@SLNPaymentDetails", dtSLNPaymnetDetails);
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
                        //  tranScope.Dispose();
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
                        // tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += message;
                        script += "');";
                        script += "window.location = '";
                        script += "SalesLogicNote.aspx";
                        script += "'; }";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

                    }
                }
            }
            catch (Exception ex)
            {
                //tranScope.Dispose();
                string message = ex.Message.ToString();
                string script = "window.onload = function(){ alert('";
                script += message;
                script += "'); }";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

            }
        }

    }

    protected void txtReasonofAmendment_TextChanged(object sender, EventArgs e)
    {
        fillVariationofBudget();
    }

    protected void txtCustomerName_TextChanged(object sender, EventArgs e)
    {
        fillVariationofBudget();
    }

    protected void txtProposedvalueofaward_TextChanged(object sender, EventArgs e)
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
        double dblProposedvalueofaward = 0;
        double dblBalancetobeaward = 0;
        double dblVaritaion = 0;
        if (double.TryParse(txtReasonofAmendment.Text, out dblapprovalBudget)) { }
        //if (double.TryParse(txtCustomerName.Text, out dblAlreadyAwarded)) { }
        dblVaritaion = (dblapprovalBudget - dblProposedvalueofaward - dblBalancetobeaward);
    }

    protected void btnGrandTotal_Click(object sender, EventArgs e)
    {
        SetDataPaymentPlan();
    }

    #region ProjectAddres And Location
    [WebMethod]
    public static string getPorjectAddress(string projectId)
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

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetApprovalNo(string prefixText)
    {
        cls_connection_new cls = new cls_connection_new();
        DataTable dt = cls.selectDataTable("select SLNOrderNo from tbl_SalesLogicNote where SLNOrderNo like '%" + prefixText + "%' and IsActive=1 and SLNOrderNo is not null and SLNOrderNo<>''");
        List<string> list = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            list.Add(dt.Rows[i]["SLNOrderNo"].ToString());
        }
        return list;
    }



    protected void txtApprovalNo_TextChanged(object sender, EventArgs e)
    {
        if (txtApprovalNo.Text != "")
        {
            int ID = cls.ExecuteIntScalar("select ID From tbl_SalesLogicNote where SLNOrderNo='" + txtApprovalNo.Text + "'");
            hdnApprovalNo.Value = txtApprovalNo.Text;
            hdnApprovalType.Value = ddlApproval.SelectedValue;
            FillData(ID);
            txtApprovalNo.Text = hdnApprovalNo.Value;
            ddlApproval.SelectedValue = hdnApprovalType.Value;
            //ViewState["CRMID"] = ID;
            if (ID > 0)
            {
                ddlCompanyName.Enabled = false;
                txtSubjectScope.Enabled = false;
                txtSubjectScope.CssClass = "form-control";
                ddlprojectname.Enabled = false;
                ddlDepartment.Enabled = false;
                txtCustomerName.Enabled = false;
                txtChannelPartnerName.Enabled = false;
                txtChannelPartnerName.CssClass = "form-control";
            }
            if (ddlApproval.SelectedValue == "1")
            {
                txtApprovalNo.Attributes["disabled"] = "disabled";
            }
            else
            {
                txtApprovalNo.Attributes.Remove("disabled");
            }
            btnSubmit.Enabled = true;
            btnSubmitforApproval.Enabled = true;
            txtReasonofAmendment.Enabled = true;
        }
    }
    [WebMethod]
    public static List<System.Web.UI.WebControls.ListItem> GetProjectName(string companyId)
    {
        cls_connection_new cls = new cls_connection_new();
        DataTable dt = cls.selectDataTable("EXEC sp_ProjectMaster 'GetAllforddl',0,'" + companyId + "'");
        List<System.Web.UI.WebControls.ListItem> list = new List<System.Web.UI.WebControls.ListItem>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow sdr in dt.Rows)
                list.Add(new System.Web.UI.WebControls.ListItem
                {
                    Value = sdr["ID"].ToString(),
                    Text = sdr["ProjectName"].ToString()
                });
        }

        return list;

    }

    
}