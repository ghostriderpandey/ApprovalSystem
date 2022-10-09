using Microsoft.Reporting.WebForms;
using System.Security.Principal;
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Web.Services;
using System.Transactions;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.Drawing;
using System.Collections.Generic;
using System.Data;
using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.UI;
using System.Linq;

public partial class AdminPanel_MultiVendorLogicNote : System.Web.UI.Page
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
        txtRFQInvited.Attributes.Add("readonly", "readonly");
        txtFinalConsidered.Attributes.Add("readonly", "readonly");


        if (!IsPostBack)
        {
            cls.BindDropDownList(ddlapprovalauthrity, "EXEC sp_CommitteeMaster 'GetAllforddl'", "CommitteeName", "ID");
            cls.BindDropDownList(ddlDepartment, "EXEC sp_DepartmentMaster 'GetAllforddl'", "DepartmentName", "ID");
            //cls.BindDropDownList(ddlprojectname, "EXEC sp_ProjectMaster 'GetAllforddl'", "ProjectName", "ID");
            //cls.BindListBox(ddlnameofproposedvendor, "EXEC sp_VendorMaster 'GetAllforddl'", "VendorName", "ID");
            cls.BindDropDownList(ddlVendor1, "EXEC sp_VendorMaster 'GetAllforddl'", "VendorName", "ID");
            cls.BindDropDownList(ddlVendor2, "EXEC sp_VendorMaster 'GetAllforddl'", "VendorName", "ID");
            cls.BindDropDownList(ddlVendor3, "EXEC sp_VendorMaster 'GetAllforddl'", "VendorName", "ID");
            cls.BindDropDownList(ddlVendor4, "EXEC sp_VendorMaster 'GetAllforddl'", "VendorName", "ID");
            cls.BindDropDownList(ddlStockinhandUOM, "EXEC sp_ItemMaster 'GetAllUOMforDDL'", "Name", "Code");
            cls.BindDropDownList(ddlCompanyName, "EXEC sp_CompanyMaster 'GetAllforddl'", "CompanyName", "ID");
            ddlprojectname_SelectedIndexChanged(null, null);
            // ddlRequirement_SelectedIndexChanged(null, null);
            //ddlReasonofvariation_SelectedIndexChanged(null, null);
            ddlBidType_SelectedIndexChanged(null, null);
            ddlActionType_SelectedIndexChanged(null, null);
            if (Request.QueryString["ID"] != null)
            {
                FillData(Convert.ToInt32(Request.QueryString["ID"]));
                hdnID.Value = Request.QueryString["ID"].ToString();
            }
            else
            {
                ckPurchaseHead.Text = cls.ExecuteStringScalar("Select top 1 PLNHead from tbl_PLNCLNHead");
                FillDt("0");
                FillDtIH("0");
                FillDtDFT("0");
                FillDtApprover("0");
                FillDtTC("0");
                FillDtAttachment("0");
                //ddllocation.SelectedValue = hddlocationId.Value;
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);
            }
        }
        else
        {
            //ddllocation.SelectedValue = hddlocationId.Value;
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);
        }

        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "fillVariationofBudget();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "fillvendor", "FillVendorCal();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ddlChange", "ddlChange();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "ddlProjectName();", true);
        //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ProjectName", "pata();", true);
    }
    public void FillData(int Id)
    {
        dtData = cls.selectDataTable("EXEC sp_ManageMVPurchaseLogicNote 'GetByID','" + Id.ToString() + "'");
        if (dtData.Rows.Count > 0)
        {
            if (dtData.Rows[0]["IsSubmitted"].ToString().ToUpper() == "TRUE")
            {
                btnSubmit.Enabled = false;
                btnSubmitforApproval.Enabled = false;
            }

            ddlApproval.SelectedValue = dtData.Rows[0]["ApprovalType1"].ToString();

            if (dtData.Rows[0]["ApprovalType1"].ToString() == "2")
            {
                txtReasonOfAmendment.Attributes.Remove("disabled");
            }
            if (dtData.Rows[0]["MVPLNOrderNo"].ToString() != "")
            {
                txtApprovalNo.Text = dtData.Rows[0]["MVPLNOrderNo"].ToString();
            }
            else
            {
                txtApprovalNo.Text = dtData.Rows[0]["ApprovalNo"].ToString();
            }
            txtReasonOfAmendment.Text = dtData.Rows[0]["ReasonOfAmendment"].ToString();
            ddlapprovalauthrity.SelectedValue = dtData.Rows[0]["ApprovalAuthrityID"].ToString();
            txtSubjectScope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
            ddlprojectname.SelectedValue = dtData.Rows[0]["ProjectID"].ToString();
            ddlprojectname_SelectedIndexChanged(null, null);
            ddlDepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
           
            ddlType.SelectedValue = dtData.Rows[0]["Type"].ToString();
            ddlType_SelectedIndexChanged(null, null);
            txtIndentProponent.Text = dtData.Rows[0]["IndentProponent"].ToString();
            txtDateofindent.Text = dtData.Rows[0]["Dateofindent1"].ToString();
            txtMaterialneededby.Text = dtData.Rows[0]["Materialneededby1"].ToString();
            txtStockinHand.Text = dtData.Rows[0]["StockinHand"].ToString();
            ddlStockinhandUOM.SelectedValue = dtData.Rows[0]["StockUOM"].ToString();
            ddlRequirement.SelectedValue = dtData.Rows[0]["Requirement"].ToString();
            txtUrgetResionDescription.Text = dtData.Rows[0]["UrgentReasonDesc"].ToString();
            txtSaleableArea.Text = dtData.Rows[0]["SaleableArea"].ToString();
            txtApprovalBudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
            txtAlreadyAwarded.Text = dtData.Rows[0]["AlreadyAwarded"].ToString();
            txtProposedvalueofaward.Text = dtData.Rows[0]["Proposedaward"].ToString();
            txtBalancetobeaward.Text = dtData.Rows[0]["BalanceAward"].ToString();
            txtvariationfrombudget.Text = dtData.Rows[0]["Variationfombudget"].ToString();
            ddlReasonofvariation.SelectedValue = dtData.Rows[0]["Reasonofvariation"].ToString();
            if (ddlReasonofvariation.SelectedItem.Text == "Others")
            {
                txtother.Enabled = true;
            }
            txtother.Text = dtData.Rows[0]["OtherDescription"].ToString();
            //ddlnameofproposedvendor.Text = dtData.Rows[0]["NameofProposedVendor"].ToString();
            //string[] nameofproposedvendo = dtData.Rows[0]["NameofProposedVendor"].ToString().Split(',');
            //foreach (string value in nameofproposedvendo)
            //{
            //    if (value != "")
            //    {
            //        ddlnameofproposedvendor.Items.FindByValue(value).Selected = true;
            //    }            
            //}
            ddlNegotationMode.SelectedValue = dtData.Rows[0]["NegotiationMode"].ToString();
            txtCommercialratingofbid.Text = dtData.Rows[0]["CommercialratingofBid"].ToString();
            txtProposedtimelineDate.Text = dtData.Rows[0]["Proposedtimeline1"].ToString();
            txtresponsibleperson.Text = dtData.Rows[0]["ResponsiblePerson"].ToString();
            txtmaterialuserdate.Text = dtData.Rows[0]["MaterialUseBydate1"].ToString();
            txtplaceofuse.Text = dtData.Rows[0]["PlaceofUse"].ToString();
            txtTotalVendorConsidred.Text = dtData.Rows[0]["Vendorconsidered"].ToString();
            txtRejectedVendor.Text = dtData.Rows[0]["RejectedVendors"].ToString();
            txtRFQInvited.Text = dtData.Rows[0]["RFQinvited"].ToString();
            txtNotQuoted.Text = dtData.Rows[0]["Notquoted"].ToString();
            txtFinalConsidered.Text = dtData.Rows[0]["FinalConsidered"].ToString();
            txtStipulatedCompletionTime.Text = dtData.Rows[0]["StipulatedCompletionTime1"].ToString();
            ddlBidType.SelectedValue = dtData.Rows[0]["BidType"].ToString();
            ddlApprovaltype.SelectedValue = dtData.Rows[0]["Approvaltype"].ToString();
            txtContratorName.Text = dtData.Rows[0]["ContractorName"].ToString();
            ddlActionType.SelectedValue = dtData.Rows[0]["AuctionType"].ToString();
            txtDateofAribaAuction.Text = dtData.Rows[0]["DateofAribaAuction1"].ToString();
            txtSingleRepeatOrderReson.Text = dtData.Rows[0]["Singleorderreason"].ToString();
            ddlVendor1.SelectedValue = dtData.Rows[0]["Vendor1"].ToString();
            hiddenvendor1.Value = dtData.Rows[0]["Vendor1"].ToString();
            ddlVendor2.SelectedValue = dtData.Rows[0]["Vendor2"].ToString();
            hiddenvendor2.Value = dtData.Rows[0]["Vendor2"].ToString();
            ddlVendor3.SelectedValue = dtData.Rows[0]["Vendor3"].ToString();
            hiddenvendor3.Value = dtData.Rows[0]["Vendor3"].ToString();
            ddlVendor4.SelectedValue = dtData.Rows[0]["Vendor4"].ToString();
            hiddenvendor4.Value = dtData.Rows[0]["Vendor4"].ToString();
            txtV1GST.Text = dtData.Rows[0]["V1GST"].ToString();
            txtV2GST.Text = dtData.Rows[0]["V2GST"].ToString();
            txtV3GST.Text = dtData.Rows[0]["V3GST"].ToString();
            txtV4GST.Text = dtData.Rows[0]["V4GST"].ToString();
            txtV1Freight.Text = dtData.Rows[0]["V1Freight"].ToString();
            txtV2Freight.Text = dtData.Rows[0]["V2Freight"].ToString();
            txtV3Freight.Text = dtData.Rows[0]["V3Freight"].ToString();
            txtV4Freight.Text = dtData.Rows[0]["V4Freight"].ToString();
            txtV1HeadlingCharges.Text = dtData.Rows[0]["V1HandlingCharges"].ToString();
            txtV2HeadlingCharges.Text = dtData.Rows[0]["V2HandlingCharges"].ToString();
            txtV3HeadlingCharges.Text = dtData.Rows[0]["V3HandlingCharges"].ToString();
            txtV4HeadlingCharges.Text = dtData.Rows[0]["V4HandlingCharges"].ToString();

            txtV1GrandTotal.Text = dtData.Rows[0]["V1GrandTotal"].ToString();
            txtV2GrandTotal.Text = dtData.Rows[0]["V2GrandTotal"].ToString();
            txtV3GrandTotal.Text = dtData.Rows[0]["V3GrandTotal"].ToString();
            txtV4GrandTotal.Text = dtData.Rows[0]["V4GrandTotal"].ToString();
            txtVendor1DeliveryTimeline.Text = dtData.Rows[0]["V1DeliveryTimeline1"].ToString();
            txtVendor2DeliveryTimeline.Text = dtData.Rows[0]["V2DeliveryTimeline1"].ToString();
            txtVendor3DeliveryTimeline.Text = dtData.Rows[0]["V3DeliveryTimeline1"].ToString();
            txtVendor4DeliveryTimeline.Text = dtData.Rows[0]["V4DeliveryTimeline1"].ToString();
            txtVendor1Comparision.Text = dtData.Rows[0]["V1BudgetedRate"].ToString();
            txtVendor2Comparision.Text = dtData.Rows[0]["V2BudgetedRate"].ToString();
            txtVendor3Comparision.Text = dtData.Rows[0]["V3BudgetedRate"].ToString();
            txtVendor4Comparision.Text = dtData.Rows[0]["V4BudgetedRate"].ToString();
            txtVendor1BidStatus.Text = dtData.Rows[0]["V1BidsStatus"].ToString();
            txtVendor2BidStatus.Text = dtData.Rows[0]["V2BidsStatus"].ToString();
            txtVendor3BidStatus.Text = dtData.Rows[0]["V3BidsStatus"].ToString();
            txtVendor4BidStatus.Text = dtData.Rows[0]["V4BidsStatus"].ToString();
            ddlVendor1Rating.SelectedValue = dtData.Rows[0]["V1VendorRatings"].ToString();
            ddlVendor2Rating.SelectedValue = dtData.Rows[0]["V2VendorRatings"].ToString();
            ddlVendor3Rating.SelectedValue = dtData.Rows[0]["V3VendorRatings"].ToString();
            ddlVendor4Rating.SelectedValue = dtData.Rows[0]["V4VendorRatings"].ToString();
            ddlVendor1AwardPreference.SelectedValue = dtData.Rows[0]["V1AwardPreference"].ToString();
            ddlVendor2AwardPreference.SelectedValue = dtData.Rows[0]["V2AwardPreference"].ToString();
            ddlVendor3AwardPreference.SelectedValue = dtData.Rows[0]["V3AwardPreference"].ToString();
            ddlVendor4AwardPreference.SelectedValue = dtData.Rows[0]["V4AwardPreference"].ToString();
            txtVendor1CostPerSqft.Text = dtData.Rows[0]["V1CostPerSqFt"].ToString();
            txtVendor2CostPerSqft.Text = dtData.Rows[0]["V2CostPerSqFt"].ToString();
            txtVendor3CostPerSqft.Text = dtData.Rows[0]["V3CostPerSqFt"].ToString();
            txtVendor4CostPerSqft.Text = dtData.Rows[0]["V4CostPerSqFt"].ToString();
            txtreccomandationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();

            hiddenvendortext1.Value = dtData.Rows[0]["V1VendorInformation"].ToString();
            txtVendorInformation.Text = dtData.Rows[0]["V1VendorInformation"].ToString();
            txtTournoverlastyear.Text = dtData.Rows[0]["V1Turnoverlastyear"].ToString();
            txtTotalOrderwithcotilldate.Text = dtData.Rows[0]["V1TotalOrderwithco"].ToString();
            txtLastOrderdetailswithco.Text = dtData.Rows[0]["V1LastorderdetailswithCo"].ToString();

            hiddenvendortext2.Value = dtData.Rows[0]["V2VendorInformation"].ToString();
            txtVendor2Information.Text = dtData.Rows[0]["V2VendorInformation"].ToString();
            txtVendor2TurnOverLastYear.Text = dtData.Rows[0]["V2Turnoverlastyear"].ToString();
            txtVendor2TotalorderswithCoDate.Text = dtData.Rows[0]["V2TotalOrderwithco"].ToString();
            txtVendor2LastorderdetailswithCo.Text = dtData.Rows[0]["V2LastorderdetailswithCo"].ToString();

            hiddenvendortext3.Value = dtData.Rows[0]["V3VendorInformation"].ToString();
            txtVendor3Information.Text = dtData.Rows[0]["V3VendorInformation"].ToString();
            txtVendor3TurnOverLastYear.Text = dtData.Rows[0]["V3Turnoverlastyear"].ToString();
            txtVendor3TotalorderswithCoDate.Text = dtData.Rows[0]["V3TotalOrderwithco"].ToString();
            txtVendor3LastorderdetailswithCo.Text = dtData.Rows[0]["V3LastorderdetailswithCo"].ToString();

            hiddenvendortext4.Value = dtData.Rows[0]["V4VendorInformation"].ToString();
            txtVendor4Information.Text = dtData.Rows[0]["V4VendorInformation"].ToString();
            txtVendor4TurnOverLastYear.Text = dtData.Rows[0]["V4Turnoverlastyear"].ToString();
            txtVendor4TotalorderswithCoDate.Text = dtData.Rows[0]["V4TotalOrderwithco"].ToString();
            txtVendor4LastorderdetailswithCo.Text = dtData.Rows[0]["V4LastorderdetailswithCo"].ToString();

            ckPurchaseHead.Text = dtData.Rows[0]["PurchaseHead"].ToString();
            ckremark.Text = dtData.Rows[0]["Remark"].ToString();

            txtV1handling.Text = dtData.Rows[0]["V1HandlingCharges1"].ToString();
            txtV2handling.Text = dtData.Rows[0]["V2HandlingCharges1"].ToString();
            txtV3handling.Text = dtData.Rows[0]["V3HandlingCharges1"].ToString();
            txtV4handling.Text = dtData.Rows[0]["V4HandlingCharges1"].ToString();

            txtV1OtherCharge.Text = dtData.Rows[0]["V1OtherCharges"].ToString();
            txtV2OtherCharge.Text = dtData.Rows[0]["V2OtherCharges"].ToString();
            txtV3OtherCharge.Text = dtData.Rows[0]["V3OtherCharges"].ToString();
            txtV4OtherCharge.Text = dtData.Rows[0]["V4OtherCharges"].ToString();

            fillVariationofBudget();
            FillVendorCal();
            //if (dtData.Rows[0]["ApprovalPriority"].ToString() == "Normal")
            //{
                
            //}
           
            ddlCompanyName.SelectedValue = dtData.Rows[0]["CompanyID"].ToString();
            if (dtData.Rows[0]["ProjectID"].ToString() != "0")
            {
                DataTable dt = cls.selectDataTable("EXEC sp_ProjectMaster 'GetAllforddl',0,'" + dtData.Rows[0]["CompanyID"].ToString() + "'");
                ddlprojectname.DataTextField = "ProjectName";
                ddlprojectname.DataValueField = "ID";
                ddlprojectname.DataSource = dt;
                ddlprojectname.DataBind();
            }
            ddlprojectname.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select", "0"));
            ddlprojectname.SelectedValue = dtData.Rows[0]["ProjectID"].ToString();
            ddlprojectname_SelectedIndexChanged(null, null);
            hiddenprojectnamevalue.Value = dtData.Rows[0]["ProjectID"].ToString();
            ddllocation.SelectedValue = dtData.Rows[0]["LocationID"].ToString();
            hddlocationId.Value = dtData.Rows[0]["LocationID"].ToString();
           
        }
        FillDt(Id.ToString());
        FillDtIH(Id.ToString());
        FillDtDFT(Id.ToString());
        FillDtApprover(Id.ToString());
        FillDtTC(Id.ToString());
        FillDtAttachment(Id.ToString());
    }



    #region MajorDevition
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
                cls.ExecuteQuery("EXEC sp_ManageMVPurchaseLogicNote 'DeleteMVPLNMajorDeviation','" + e.CommandArgument + "'");
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
            TextBox txtrecommandation = (e.Row.FindControl("txtrecommandation") as TextBox);
            HiddenField hddRecommendation = (e.Row.FindControl("hddRecommendation") as HiddenField);
            txtrecommandation.Text = hddRecommendation.Value;
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
                    TextBox txtreccomndation = (TextBox)gvStandardexception.Rows[rowindex].Cells[3].FindControl("txtrecommandation");
                    dr = dt.NewRow();
                    dr["ID"] = hddSEID.Value;
                    dr["Standard"] = ckStandrad.Text;
                    dr["Excepetion"] = ckExcepetion.Text;
                    dr["Recommendation"] = txtreccomndation.Text;
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
        DataTable dtData = cls.selectDataTable("select ID,Standard,Excepetion,Recommendation from tbl_MVPLNMajorDeviation where IsDelete=0 and MVPLNID='" + ID + "'");
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
    #endregion MajorDevition

    #region Item Head
    protected void gvItemHead_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNewIH();
            //ScriptManager.RegisterStartupScript(Page, GetType(), "call", "<script>ValidateVendor();</script>", false);
        }

        if (e.CommandName == "Delete")
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
                cls.ExecuteQuery("EXEC sp_ManageMVPurchaseLogicNote 'DeleteMVPLNBidEvaluation','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsIH"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsIH"] = dtData;
                gvItemHead.DataSource = dtData;
                gvItemHead.DataBind();
                CalIHTotal();
            }
        }
        if (e.CommandName == "Calculate")
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
            DropDownList ddlUOM = (e.Row.FindControl("ddlUOM") as DropDownList);
            DropDownList ddlItemHead = (e.Row.FindControl("ddlItemHead") as DropDownList);
            HiddenField hddUOM = (e.Row.FindControl("hddUOM") as HiddenField);
            HiddenField hddItemHead = (e.Row.FindControl("hddItemHead") as HiddenField);
            cls.BindDropDownList(ddlUOM, "EXEC sp_ItemMaster 'GetAllUOMforDDL'", "Name", "Code");
            cls.BindDropDownList(ddlItemHead, "EXEC sp_ItemMaster 'GetAllforDDL'", "ItemName", "ID");
            ddlUOM.SelectedValue = hddUOM.Value;
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
            dr["ItemHead"] = "0";
            dr["UOM"] = "";
            dr["V1Quantity"] = "0";
            dr["V1Rate"] = "0";
            dr["V1Value"] = "0";
            dr["V2Quantity"] = "0";
            dr["V2Rate"] = "0";
            dr["V2Value"] = "0";
            dr["V3Quantity"] = "0";
            dr["V3Rate"] = "0";
            dr["V3Value"] = "0";
            dr["V4Quantity"] = "0";
            dr["V4Value"] = "0";
            dr["V4Rate"] = "0";
           
            dr["BaseRate"] = "0";
            dr["TargetCost"] = "0";
            dr["PreviousRate"] = "0";
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
                    DropDownList ddlItemHead = (DropDownList)gvItemHead.Rows[rowindex].Cells[1].FindControl("ddlItemHead");
                    DropDownList ddlUOM = (DropDownList)gvItemHead.Rows[rowindex].Cells[3].FindControl("ddlUOM");
                                                                     
                    TextBox txtV1Quantity = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtV1Quantity");
                    TextBox txtVendor1Rate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor1Rate");
                    TextBox txtVendor1Value = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor1Value");
                    TextBox txtV2Quantity = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtV2Quantity");
                    TextBox txtVendor2Rate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor2Rate");
                    TextBox txtVendor2Value = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor2Value");
                    TextBox txtV3Quantity = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtV3Quantity");
                    TextBox txtVendor3Rate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor3Rate");
                    TextBox txtVendor3Value = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor3Value");
                    TextBox txtV4Quantity = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtV4Quantity");
                    TextBox txtVendor4Rate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor4Rate");
                    TextBox txtVendor4Value = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtVendor4Value");
                    TextBox txtBudgetRate = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtBudgetRate");
                    TextBox txtTargetCost = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtTargetCost");
                    TextBox txtPreviousRates = (TextBox)gvItemHead.Rows[rowindex].Cells[1].FindControl("txtPreviousRates");
                    dr = dt.NewRow();
                    dr["ID"] = hddIHID.Value;
                    dr["ItemHead"] = ddlItemHead.SelectedValue;
                    dr["UOM"] = ddlUOM.SelectedValue;
                    dr["V1Quantity"] = txtV1Quantity.Text == "" ? "0":txtV1Quantity.Text;
                    dr["V1Rate"] = txtVendor1Rate.Text == "" ? "0" : txtVendor1Rate.Text;
                    dr["V1Value"] = txtVendor1Value.Text == "" ? "0" : txtVendor1Value.Text;
                    dr["V2Quantity"] = txtV2Quantity.Text == "" ? "0" : txtV2Quantity.Text;
                    dr["V2Rate"] = txtVendor2Rate.Text == "" ? "0" : txtVendor2Rate.Text;
                    dr["V2Value"] = txtVendor2Value.Text == "" ? "0" : txtVendor2Value.Text;
                    dr["V3Quantity"] = txtV3Quantity.Text == "" ? "0" : txtV3Quantity.Text;
                    dr["V3Rate"] = txtVendor3Rate.Text == "" ? "0" : txtVendor3Rate.Text;
                    dr["V3Value"] = txtVendor3Value.Text == "" ? "0" : txtVendor3Value.Text;
                    dr["V4Quantity"] = txtV4Quantity.Text == "" ? "0" : txtV4Quantity.Text;
                    dr["V4Rate"] = txtVendor4Rate.Text == "" ? "0" : txtVendor4Rate.Text;
                    dr["V4Value"] = txtVendor4Value.Text == "" ? "0" : txtVendor4Value.Text;
                    dr["BaseRate"] = txtBudgetRate.Text == "" ? "0" : txtBudgetRate.Text;
                    dr["TargetCost"] = txtTargetCost.Text == "" ? "0" : txtTargetCost.Text;
                    dr["PreviousRate"] = txtPreviousRates.Text == "" ? "0" : txtPreviousRates.Text;
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
        DataTable dtData = cls.selectDataTable("select ID,ItemHead,UOM,cast(V1Quantity as decimal(18,2)) as V1Quantity,V1Rate,V1Value,V2Quantity,V2Rate,V2Value,V3Quantity,V3Rate,V3Value,V4Quantity,V4Rate,V4Value,BaseRate,TargetCost,PreviousRate from tbl_MVPLNBidEvaluation where IsDelete=0 and MVPLNID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsIH"] = dtData;
        }
        else
        {
            ViewState["dtDetailsIH"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID", typeof(int));
            dt.Columns.Add("ItemHead", typeof(int));
            dt.Columns.Add("UOM");
            dt.Columns.Add("V1Quantity", typeof(decimal));
            dt.Columns.Add("V1Rate", typeof(decimal));
            dt.Columns.Add("V1Value", typeof(decimal));
            dt.Columns.Add("V2Quantity", typeof(decimal));
            dt.Columns.Add("V2Rate", typeof(decimal));
            dt.Columns.Add("V2Value", typeof(decimal));
            dt.Columns.Add("V3Quantity", typeof(decimal));
            dt.Columns.Add("V3Rate", typeof(decimal));
            dt.Columns.Add("V3Value", typeof(decimal));
            dt.Columns.Add("V4Quantity", typeof(decimal));
            dt.Columns.Add("V4Rate", typeof(decimal));
            dt.Columns.Add("V4Value", typeof(decimal));
            dt.Columns.Add("BaseRate", typeof(decimal));
            dt.Columns.Add("TargetCost", typeof(decimal));
            dt.Columns.Add("PreviousRate", typeof(decimal));
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
        //DataTable dt = new DataTable();
        //dt = (DataTable)gvItemHead.DataSource;
        //gvItemHead.FooterRow.Font.Bold = true;
        //gvItemHead.FooterRow.Cells[3].Text = "Total";
        //gvItemHead.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;
        //decimal dblV1Quantity = 0;
        //decimal dblV2Quantity = 0;
        //decimal dblV3Quantity = 0;
        //decimal dblV4Quantity = 0;
        //decimal dblVendor1Rate = 0;
        //decimal dblVendor1Value = 0;
        //decimal dblVendor2Rate = 0;
        //decimal dblVendor2Value = 0;
        //decimal dblVendor3Rate = 0;
        //decimal dblVendor3Value = 0;
        //decimal dblVendor4Rate = 0;
        //decimal dblVendor4Value = 0;
        //decimal dblBudgetRate = 0;
        //decimal dblTargetCost = 0;
        //decimal dblPreviousRate = 0;
        //dblV1Quantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("V1Quantity"));
        //dblV2Quantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("V2Quantity"));
        //dblV3Quantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("V3Quantity"));
        //dblV4Quantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("V4Quantity"));
        //dblVendor1Rate = dt.AsEnumerable().Sum(row => row.Field<decimal>("V1Rate"));
        //dblVendor1Value = dt.AsEnumerable().Sum(row => row.Field<decimal>("V1Value"));
        //dblVendor2Rate = dt.AsEnumerable().Sum(row => row.Field<decimal>("V2Rate"));
        //dblVendor2Value = dt.AsEnumerable().Sum(row => row.Field<decimal>("V2Value"));
        //dblVendor3Rate = dt.AsEnumerable().Sum(row => row.Field<decimal>("V3Rate"));
        //dblVendor3Value = dt.AsEnumerable().Sum(row => row.Field<decimal>("V3Value"));
        //dblVendor4Rate = dt.AsEnumerable().Sum(row => row.Field<decimal>("V4Rate"));
        //dblVendor4Value = dt.AsEnumerable().Sum(row => row.Field<decimal>("V4Value"));
        //dblBudgetRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("BaseRate"));
        //dblTargetCost = dt.AsEnumerable().Sum(row => row.Field<decimal>("TargetCost"));
        //dblPreviousRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("PreviousRate"));
        //gvItemHead.FooterRow.Cells[4].Text = dblV1Quantity.ToString();
        //gvItemHead.FooterRow.Cells[5].Text = dblVendor1Rate.ToString();
        //gvItemHead.FooterRow.Cells[6].Text = dblVendor1Value.ToString();
        //gvItemHead.FooterRow.Cells[7].Text = dblV2Quantity.ToString();
        //gvItemHead.FooterRow.Cells[8].Text = dblVendor2Rate.ToString();
        //gvItemHead.FooterRow.Cells[9].Text = dblVendor2Value.ToString();
        //gvItemHead.FooterRow.Cells[10].Text = dblV3Quantity.ToString();
        //gvItemHead.FooterRow.Cells[11].Text = dblVendor3Rate.ToString();
        //gvItemHead.FooterRow.Cells[12].Text = dblVendor3Value.ToString();
        //gvItemHead.FooterRow.Cells[13].Text = dblV4Quantity.ToString();
        //gvItemHead.FooterRow.Cells[14].Text = dblVendor4Rate.ToString();
        //gvItemHead.FooterRow.Cells[15].Text = dblVendor4Value.ToString();
        //gvItemHead.FooterRow.Cells[16].Text = dblBudgetRate.ToString();
        //gvItemHead.FooterRow.Cells[17].Text = dblTargetCost.ToString();
        //gvItemHead.FooterRow.Cells[18].Text = dblPreviousRate.ToString();
        CalCostPersqft();
    }
    #endregion Item Head

    #region Deviation
    protected void gvDeviationfromtender_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNewDFT();
        }

        if (e.CommandName == "Delete")
        {
            SetDataDFT();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtDetailsDFT"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsDFT"] = dtData;
                gvDeviationfromtender.DataSource = dtData;
                gvDeviationfromtender.DataBind();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_ManageMVPurchaseLogicNote 'DeleteMVPLNDeviation','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsDFT"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsDFT"] = dtData;
                gvDeviationfromtender.DataSource = dtData;
                gvDeviationfromtender.DataBind();
            }
        }
    }
    protected void gvDeviationfromtender_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvDeviationfromtender_PreRender(object sender, EventArgs e)
    {
        int count = gvDeviationfromtender.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = gvDeviationfromtender.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = gvDeviationfromtender.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }
    private void AddNewDFT()
    {
        if (ViewState["dtDetailsDFT"] != null)
        {
            SetDataDFT();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["StandardTerms"] = "";
            dr["Preference1"] = "";
            dr["Preference2"] = "";
            dr["PrevailingMarkrtPractise"] = "";
            dt.Rows.Add(dr);

            ViewState["dtDetailsDFT"] = dt;
            gvDeviationfromtender.DataSource = dt;
            gvDeviationfromtender.DataBind();
        }
        else
        {
            FillDtDFT("0");
            AddNewDFT();
        }
    }
    private void SetDataDFT()
    {
        if (ViewState["dtDetailsDFT"] != null)
        {
            int rowindex = 0;
            DataTable dtData = (DataTable)ViewState["dtDetailsDFT"];
            dt = dtData.Clone();
            DataRow dr;
            if (dtData.Rows.Count > 0)
            {
                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    HiddenField hddDFTID = (HiddenField)gvDeviationfromtender.Rows[rowindex].Cells[0].FindControl("hddDFTID");
                    CKEditor.NET.CKEditorControl ckDFTStandrad = (CKEditor.NET.CKEditorControl)gvDeviationfromtender.Rows[rowindex].Cells[1].FindControl("ckDFTStandrad");
                    CKEditor.NET.CKEditorControl ckDFTPreference1 = (CKEditor.NET.CKEditorControl)gvDeviationfromtender.Rows[rowindex].Cells[2].FindControl("ckDFTPreference1");
                    CKEditor.NET.CKEditorControl ckDFTPreference2 = (CKEditor.NET.CKEditorControl)gvDeviationfromtender.Rows[rowindex].Cells[3].FindControl("ckDFTPreference2");
                    CKEditor.NET.CKEditorControl ckDFTPrevailingMarket = (CKEditor.NET.CKEditorControl)gvDeviationfromtender.Rows[rowindex].Cells[4].FindControl("ckDFTPrevailingMarket");

                    dr = dt.NewRow();
                    dr["ID"] = hddDFTID.Value;
                    dr["StandardTerms"] = ckDFTStandrad.Text;
                    dr["Preference1"] = ckDFTPreference1.Text;
                    dr["Preference2"] = ckDFTPreference2.Text;
                    dr["PrevailingMarkrtPractise"] = ckDFTPrevailingMarket.Text;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetailsDFT"] = dt;
                gvDeviationfromtender.DataSource = dt;
                gvDeviationfromtender.DataBind();
            }
        }
    }
    private void FillDtDFT(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,StandardTerms,Preference1,Preference2,PrevailingMarkrtPractise from tbl_MVPLNDeviation where IsDelete=0 and MVPLNID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsDFT"] = dtData;
        }
        else
        {
            ViewState["dtDetailsDFT"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("StandardTerms");
            dt.Columns.Add("Preference1");
            dt.Columns.Add("Preference2");
            dt.Columns.Add("PrevailingMarkrtPractise");
            ViewState["dtDetailsDFT"] = dt;
        }

        dt = (DataTable)ViewState["dtDetailsDFT"];
        if (dt.Rows.Count == 0)
        {
            AddNewDFT();
        }
        gvDeviationfromtender.DataSource = dt;
        gvDeviationfromtender.DataBind();
    }
    #endregion Deviation

    #region Approver
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
                cls.ExecuteQuery("EXEC sp_ManageMVPurchaseLogicNote 'DeleteMVPLNApprover','" + e.CommandArgument + "'");
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
        DataTable dtData = cls.selectDataTable("select ID,ApproverID from tbl_MVPLNApprover where IsDelete=0 and MVPLNID='" + ID + "'");
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

    #region Tearms and Condition
    protected void gvTermsandCondition_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNewTC();
        }

        if (e.CommandName == "Delete")
        {
            SetDataTC();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtDetailsTC"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsTC"] = dtData;
                gvTermsandCondition.DataSource = dtData;
                gvTermsandCondition.DataBind();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_ManageMVPurchaseLogicNote 'DeleteMVPLNTermsandCondition','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetailsTC"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetailsTC"] = dtData;
                gvTermsandCondition.DataSource = dtData;
                gvTermsandCondition.DataBind();
            }
        }
    }
    protected void gvTermsandCondition_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvTermsandCondition_PreRender(object sender, EventArgs e)
    {
        int count = gvTermsandCondition.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = gvTermsandCondition.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = gvTermsandCondition.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }
    private void AddNewTC()
    {
        if (ViewState["dtDetailsTC"] != null)
        {
            SetDataTC();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["Terms"] = "";
            dr["StandardTerms"] = "";
            dr["Preference1"] = "";
            dr["Preference2"] = "";
            dt.Rows.Add(dr);

            ViewState["dtDetailsTC"] = dt;
            gvTermsandCondition.DataSource = dt;
            gvTermsandCondition.DataBind();
        }
        else
        {
            FillDtTC("0");
            AddNewTC();
        }
    }
    private void SetDataTC()
    {
        if (ViewState["dtDetailsTC"] != null)
        {
            int rowindex = 0;
            DataTable dtData = (DataTable)ViewState["dtDetailsTC"];
            dt = dtData.Clone();
            DataRow dr;
            if (dtData.Rows.Count > 0)
            {
                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    HiddenField hddTCID = (HiddenField)gvTermsandCondition.Rows[rowindex].Cells[0].FindControl("hddTCID");
                    CKEditor.NET.CKEditorControl ckTCTerms = (CKEditor.NET.CKEditorControl)gvTermsandCondition.Rows[rowindex].Cells[1].FindControl("ckTCTerms");
                    CKEditor.NET.CKEditorControl ckTCStandrad = (CKEditor.NET.CKEditorControl)gvTermsandCondition.Rows[rowindex].Cells[2].FindControl("ckTCStandrad");
                    CKEditor.NET.CKEditorControl ckTCPreference1 = (CKEditor.NET.CKEditorControl)gvTermsandCondition.Rows[rowindex].Cells[3].FindControl("ckTCPreference1");
                    CKEditor.NET.CKEditorControl ckTCPreference2 = (CKEditor.NET.CKEditorControl)gvTermsandCondition.Rows[rowindex].Cells[4].FindControl("ckTCPreference2");


                    dr = dt.NewRow();
                    dr["ID"] = hddTCID.Value;
                    dr["StandardTerms"] = ckTCStandrad.Text;
                    dr["Preference1"] = ckTCPreference1.Text;
                    dr["Preference2"] = ckTCPreference2.Text;
                    dr["Terms"] = ckTCTerms.Text;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetailsTC"] = dt;
                gvTermsandCondition.DataSource = dt;
                gvTermsandCondition.DataBind();
            }
        }
    }
    private void FillDtTC(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,Terms,StandardTerms,Preference1,Preference2 from tbl_MVPLNTermsandCondition where IsDelete=0 and MVPLNID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsTC"] = dtData;
        }
        else
        {
            dtData = new DataTable();
            dtData = cls.selectDataTable("select 0 as ID,Terms,StandardTerms,Preference1,Preference2 from tbl_PLNTandC where IsActive=1 order by ID");
            if (dtData.Rows.Count > 0)
            {
                ViewState["dtDetailsTC"] = dtData;
            }
            else
            {
                ViewState["dtDetailsTC"] = null;
                dt = new DataTable();
                dt.Columns.Add("ID");
                dt.Columns.Add("Terms");
                dt.Columns.Add("StandardTerms");
                dt.Columns.Add("Preference1");
                dt.Columns.Add("Preference2");
                ViewState["dtDetailsTC"] = dt;
            }
        }

        dt = (DataTable)ViewState["dtDetailsTC"];
        if (dt.Rows.Count == 0)
        {
            AddNewTC();
        }
        gvTermsandCondition.DataSource = dt;
        gvTermsandCondition.DataBind();
    }

    #endregion Tearms and Condition

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
                cls.ExecuteQuery("EXEC sp_ManageMVPurchaseLogicNote 'DeleteMVPLNAttachment','" + e.CommandArgument + "'");
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
                    HiddenField hddAttachmentID = (HiddenField)gvAttachment.Rows[rowindex].FindControl("hddAttachmentID");
                    DropDownList ddlAttechmentCategory = (DropDownList)gvAttachment.Rows[rowindex].FindControl("ddlAttechmentCategory");
                    TextBox txtDescription = (TextBox)gvAttachment.Rows[rowindex].FindControl("txtDescription");
                    FileUpload fudFile = (FileUpload)gvAttachment.Rows[rowindex].FindControl("fudFile");
                    FileUpload fudImage = (FileUpload)gvAttachment.Rows[rowindex].FindControl("fudImage");
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
        DataTable dtData = cls.selectDataTable("select ID,Category,Description,DocFile,DocImage from tbl_MVPLNAttachment where IsDelete=0 and MVPLNID='" + ID + "'");
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
        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/MVPLN/") + DocFile))
        {
            if (Request.QueryString["ID"] != null)
            {
                string PLNID = Request.QueryString["ID"].ToString();
                DataTable dtPLNOrderNo = new DataTable();
                dtPLNOrderNo = cls.selectDataTable(" select b.MVPLNOrderNo from tbl_MVPLNApprover a inner join tbl_MVPurchaseLogicNote b on a.MVPLNID=b.ID Where a.IsApprove=1 And  a.MVPLNID='" + PLNID + "' and a.IsDelete=0");
                if (dtPLNOrderNo.Rows.Count > 0)
                {
                    if (dtPLNOrderNo.Rows.Count > 0)
                    {
                        string filePath = Server.MapPath("../Upload/MVPLN/") + ID + PLNID + Type + DocFile;
                        if (Type == "PDF")
                        {
                            PdfReader reader = new PdfReader(Server.MapPath("../Upload/MVPLN/") + DocFile);
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
                                ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtPLNOrderNo.Rows[0]["MVPLNOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15, iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
                                over.RestoreState();
                            }
                            stamper.Close();
                            reader.Close();
                        }
                        else if (Type == "Image")
                        {
                            PointF firstLocation = new PointF(10f, 10f);
                            string imageFilePath = Server.MapPath("../Upload/MVPLN/") + DocFile;
                            Bitmap newBitmap;
                            using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFilePath))//load the image file
                            {
                                using (Graphics graphics = Graphics.FromImage(bitmap))
                                {
                                    using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12, FontStyle.Bold))
                                    {
                                        System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);
                                        graphics.DrawString(dtPLNOrderNo.Rows[0]["MVPLNOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);

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
                        var filePath = Server.MapPath("../Upload/MVPLN/") + DocFile + "";
                        Response.ContentType = "application/octet-stream";
                        Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                        Response.TransmitFile(filePath);
                        Response.End();
                    }
                }
                else
                {
                    var filePath = Server.MapPath("../Upload/MVPLN/") + DocFile + "";
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                    Response.TransmitFile(filePath);
                    Response.End();

                }
            }
            else
            {
                var filePath = Server.MapPath("../Upload/MVPLN/") + DocFile + "";
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
            RFVUrgetReason.Visible = true;
        }
        else
        {
            txtUrgetResionDescription.Text = "";
            txtUrgetResionDescription.ReadOnly = true;
            RFVUrgetReason.Visible = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        SetData();
        SetDataApprover();
        SetDataAttachment();
        SetDataDFT();
        SetDataIH();
        SetDataTC();
        DataTable dtPLNMajorDeviation = new DataTable();
        DataTable dtPLNBidEvaluation = new DataTable();
        DataTable dtPLNDeviation = new DataTable();
        DataTable dtPLNApprover = new DataTable();
        DataTable dtPLNTermsandCondition = new DataTable();
        DataTable dtPLNAttachment = new DataTable();
        if (ViewState["dtDetailsSE"] != null)
            dtPLNMajorDeviation = (DataTable)ViewState["dtDetailsSE"];
        if (ViewState["dtDetailsIH"] != null)
            dtPLNBidEvaluation = (DataTable)ViewState["dtDetailsIH"];
        if (ViewState["dtDetailsDFT"] != null)
            dtPLNDeviation = (DataTable)ViewState["dtDetailsDFT"];
        if (ViewState["dtDetailsApprover"] != null)
            dtPLNApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsTC"] != null)
            dtPLNTermsandCondition = (DataTable)ViewState["dtDetailsTC"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtPLNAttachment = (DataTable)ViewState["dtDetailsAttachment"];

        string nameofproposedvendor = ddlVendor1.SelectedValue+","+ddlVendor2.SelectedValue+","+ddlVendor3.SelectedValue+","+ddlVendor4.SelectedValue;

        //var query = from System.Web.UI.WebControls.ListItem item in ddlnameofproposedvendor.Items where item.Selected select item;
        //foreach (System.Web.UI.WebControls.ListItem item in query)
        //{
        //    if (item.Selected == true)
        //    {
        //        if (nameofproposedvendor == "")
        //            nameofproposedvendor = item.Value.ToString();
        //        else
        //            nameofproposedvendor += "," + item.Value.ToString();
        //    }
        //}
        dtUser = (DataTable)Session["UserSession"];
        if (ddlApproval.SelectedValue == "2")
        {
            string orderNo = AmendmentOrderNo();
            if (orderNo != "")
            {
                txtApprovalNo.Text = orderNo;
            }

        }
        if (dtPLNApprover.Rows.Count == 1)
        {
            int approverid = int.Parse(dtPLNApprover.Rows[0]["ApproverID"].ToString());
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
                    using (SqlCommand cmd = new SqlCommand("sp_ManageMVPurchaseLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@MVPLNRefID", "");
                        cmd.Parameters.AddWithValue("@ApprovalType1", ddlApproval.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text);
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendment", txtReasonOfAmendment.Text);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
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
                        cmd.Parameters.AddWithValue("@Proposedaward", txtProposedvalueofaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                       
                        cmd.Parameters.AddWithValue("@NameofProposedVendor", nameofproposedvendor);
                        cmd.Parameters.AddWithValue("@NegotiationMode", ddlNegotationMode.SelectedValue);
                        cmd.Parameters.AddWithValue("@CommercialratingofBid", txtCommercialratingofbid.Text.Trim());
                        cmd.Parameters.AddWithValue("@Proposedtimeline", txtProposedtimelineDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@ResponsiblePerson", txtresponsibleperson.Text);
                        cmd.Parameters.AddWithValue("@MaterialUseBydate", txtmaterialuserdate.Text.Trim());
                        cmd.Parameters.AddWithValue("@PlaceofUse", txtplaceofuse.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendorconsidered", txtTotalVendorConsidred.Text.Trim());
                        cmd.Parameters.AddWithValue("@RejectedVendors", txtRejectedVendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@RFQinvited", txtRFQInvited.Text.Trim());
                        cmd.Parameters.AddWithValue("@Notquoted", txtNotQuoted.Text.Trim());
                        cmd.Parameters.AddWithValue("@FinalConsidered", txtFinalConsidered.Text.Trim());
                        cmd.Parameters.AddWithValue("@StipulatedCompletionTime", txtStipulatedCompletionTime.Text.Trim());
                        cmd.Parameters.AddWithValue("@BidType", ddlBidType.SelectedValue);
                        cmd.Parameters.AddWithValue("@Approvaltype", ddlApprovaltype.SelectedValue);
                        cmd.Parameters.AddWithValue("@ContractorName", txtContratorName.Text.Trim());
                        cmd.Parameters.AddWithValue("@AuctionType", ddlActionType.SelectedValue);
                        cmd.Parameters.AddWithValue("@DateofAribaAuction", txtDateofAribaAuction.Text.Trim());
                        cmd.Parameters.AddWithValue("@Singleorderreason", txtSingleRepeatOrderReson.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendor1", ddlVendor1.SelectedValue.ToString() == "0" ? hiddenvendor1.Value : ddlVendor1.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor2", ddlVendor2.SelectedValue.ToString() == "0" ? hiddenvendor2.Value : ddlVendor2.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor3", ddlVendor3.SelectedValue.ToString() == "0" ? hiddenvendor3.Value : ddlVendor3.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor4", ddlVendor4.SelectedValue.ToString() == "0" ? hiddenvendor4.Value : ddlVendor4.SelectedValue);
                        cmd.Parameters.AddWithValue("@V1GST", txtV1GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GST", txtV2GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GST", txtV3GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GST", txtV4GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Freight", txtV1Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Freight", txtV2Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Freight", txtV3Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Freight", txtV4Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1HandlingCharges", txtV1HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges", txtV2HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges", txtV3HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges", txtV4HeadlingCharges.Text.Trim());

                        cmd.Parameters.AddWithValue("@V1HandlingCharges1", txtV1handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges1", txtV2handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges1", txtV3handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges1", txtV4handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1OtherCharges", txtV1OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2OtherCharges", txtV2OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3OtherCharges", txtV3OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4OtherCharges", txtV4OtherCharge.Text.Trim());

                        cmd.Parameters.AddWithValue("@V1GrandTotal", txtV1GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GrandTotal", txtV2GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GrandTotal", txtV3GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GrandTotal", txtV4GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1DeliveryTimeline", txtVendor1DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2DeliveryTimeline", txtVendor2DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3DeliveryTimeline", txtVendor3DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4DeliveryTimeline", txtVendor4DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BudgetedRate", txtVendor1Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BudgetedRate", txtVendor2Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BudgetedRate", txtVendor3Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BudgetedRate", txtVendor4Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BidsStatus", txtVendor1BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BidsStatus", txtVendor2BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BidsStatus", txtVendor3BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BidsStatus", txtVendor4BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorRatings", ddlVendor1Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorRatings", ddlVendor2Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorRatings", ddlVendor3Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorRatings", ddlVendor4Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1AwardPreference", ddlVendor1AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2AwardPreference", ddlVendor2AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3AwardPreference", ddlVendor3AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4AwardPreference", ddlVendor4AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1CostPerSqFt", txtVendor1CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2CostPerSqFt", txtVendor2CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3CostPerSqFt", txtVendor3CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4CostPerSqFt", txtVendor4CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorInformation", txtVendorInformation.Text.Trim() == "" ? hiddenvendortext1.Value : txtVendorInformation.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Turnoverlastyear", txtTournoverlastyear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1TotalOrderwithco", txtTotalOrderwithcotilldate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1LastorderdetailswithCo", txtLastOrderdetailswithco.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorInformation", txtVendor2Information.Text.Trim() == "" ? hiddenvendortext2.Value : txtVendor2Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Turnoverlastyear", txtVendor2TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2TotalOrderwithco", txtVendor2TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2LastorderdetailswithCo", txtVendor2LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorInformation", txtVendor3Information.Text.Trim() == "" ? hiddenvendortext3.Value : txtVendor3Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Turnoverlastyear", txtVendor3TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3TotalOrderwithco", txtVendor3TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3LastorderdetailswithCo", txtVendor3LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorInformation", txtVendor4Information.Text.Trim() == "" ? hiddenvendortext4.Value : txtVendor4Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Turnoverlastyear", txtVendor4TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4TotalOrderwithco", txtVendor4TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4LastorderdetailswithCo", txtVendor4LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@PurchaseHead", ckPurchaseHead.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@MVPLNMajorDeviation", dtPLNMajorDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNBidEvaluation", dtPLNBidEvaluation);
                        cmd.Parameters.AddWithValue("@MVPLNDeviation", dtPLNDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNApprover", dtPLNApprover);
                        cmd.Parameters.AddWithValue("@MVPLNTermsandCondition", dtPLNTermsandCondition);
                        cmd.Parameters.AddWithValue("@MVPLNAttachment", dtPLNAttachment);
                        
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
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += message;
                        script += "');}";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);

                        //clear();
                    }
                    else
                    {
                        //tranScope.Complete();
                        //tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += message;
                        script += "');";
                        script += "window.location = '";
                        script += "ListMultiVendorLogicNote.aspx";
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
                    using (SqlCommand cmd = new SqlCommand("sp_ManageMVPurchaseLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@MVPLNRefID", "");
                        cmd.Parameters.AddWithValue("@ApprovalType1", ddlApproval.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text);
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendment", txtReasonOfAmendment.Text);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
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
                        cmd.Parameters.AddWithValue("@Proposedaward", txtProposedvalueofaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@NameofProposedVendor", nameofproposedvendor);
                        cmd.Parameters.AddWithValue("@NegotiationMode", ddlNegotationMode.SelectedValue);
                        cmd.Parameters.AddWithValue("@CommercialratingofBid", txtCommercialratingofbid.Text.Trim());
                        cmd.Parameters.AddWithValue("@Proposedtimeline", txtProposedtimelineDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@ResponsiblePerson", txtresponsibleperson.Text);
                        cmd.Parameters.AddWithValue("@MaterialUseBydate", txtmaterialuserdate.Text.Trim());
                        cmd.Parameters.AddWithValue("@PlaceofUse", txtplaceofuse.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendorconsidered", txtTotalVendorConsidred.Text.Trim());
                        cmd.Parameters.AddWithValue("@RejectedVendors", txtRejectedVendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@RFQinvited", txtRFQInvited.Text.Trim());
                        cmd.Parameters.AddWithValue("@Notquoted", txtNotQuoted.Text.Trim());
                        cmd.Parameters.AddWithValue("@FinalConsidered", txtFinalConsidered.Text.Trim());
                        cmd.Parameters.AddWithValue("@StipulatedCompletionTime", txtStipulatedCompletionTime.Text.Trim());
                        cmd.Parameters.AddWithValue("@BidType", ddlBidType.SelectedValue);
                        cmd.Parameters.AddWithValue("@Approvaltype", ddlApprovaltype.SelectedValue);
                        cmd.Parameters.AddWithValue("@ContractorName", txtContratorName.Text.Trim());
                        cmd.Parameters.AddWithValue("@AuctionType", ddlActionType.SelectedValue);
                        cmd.Parameters.AddWithValue("@DateofAribaAuction", txtDateofAribaAuction.Text.Trim());
                        cmd.Parameters.AddWithValue("@Singleorderreason", txtSingleRepeatOrderReson.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendor1", ddlVendor1.SelectedValue.ToString() == "0" ? hiddenvendor1.Value : ddlVendor1.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor2", ddlVendor2.SelectedValue.ToString() == "0" ? hiddenvendor2.Value : ddlVendor2.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor3", ddlVendor3.SelectedValue.ToString() == "0" ? hiddenvendor3.Value : ddlVendor3.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor4", ddlVendor4.SelectedValue.ToString() == "0" ? hiddenvendor4.Value : ddlVendor4.SelectedValue);
                        cmd.Parameters.AddWithValue("@V1GST", txtV1GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GST", txtV2GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GST", txtV3GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GST", txtV4GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Freight", txtV1Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Freight", txtV2Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Freight", txtV3Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Freight", txtV4Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1HandlingCharges", txtV1HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges", txtV2HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges", txtV3HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges", txtV4HeadlingCharges.Text.Trim());

                        cmd.Parameters.AddWithValue("@V1HandlingCharges1", txtV1handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges1", txtV2handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges1", txtV3handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges1", txtV4handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1OtherCharges", txtV1OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2OtherCharges", txtV2OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3OtherCharges", txtV3OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4OtherCharges", txtV4OtherCharge.Text.Trim());

                        cmd.Parameters.AddWithValue("@V1GrandTotal", txtV1GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GrandTotal", txtV2GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GrandTotal", txtV3GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GrandTotal", txtV4GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1DeliveryTimeline", txtVendor1DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2DeliveryTimeline", txtVendor2DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3DeliveryTimeline", txtVendor3DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4DeliveryTimeline", txtVendor4DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BudgetedRate", txtVendor1Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BudgetedRate", txtVendor2Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BudgetedRate", txtVendor3Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BudgetedRate", txtVendor4Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BidsStatus", txtVendor1BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BidsStatus", txtVendor2BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BidsStatus", txtVendor3BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BidsStatus", txtVendor4BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorRatings", ddlVendor1Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorRatings", ddlVendor2Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorRatings", ddlVendor3Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorRatings", ddlVendor4Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1AwardPreference", ddlVendor1AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2AwardPreference", ddlVendor2AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3AwardPreference", ddlVendor3AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4AwardPreference", ddlVendor4AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1CostPerSqFt", txtVendor1CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2CostPerSqFt", txtVendor2CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3CostPerSqFt", txtVendor3CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4CostPerSqFt", txtVendor4CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorInformation", txtVendorInformation.Text.Trim() == "" ? hiddenvendortext1.Value : txtVendorInformation.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Turnoverlastyear", txtTournoverlastyear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1TotalOrderwithco", txtTotalOrderwithcotilldate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1LastorderdetailswithCo", txtLastOrderdetailswithco.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorInformation", txtVendor2Information.Text.Trim() == "" ? hiddenvendortext2.Value : txtVendor2Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Turnoverlastyear", txtVendor2TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2TotalOrderwithco", txtVendor2TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2LastorderdetailswithCo", txtVendor2LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorInformation", txtVendor3Information.Text.Trim() == "" ? hiddenvendortext3.Value : txtVendor3Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Turnoverlastyear", txtVendor3TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3TotalOrderwithco", txtVendor3TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3LastorderdetailswithCo", txtVendor3LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorInformation", txtVendor4Information.Text.Trim() == "" ? hiddenvendortext4.Value : txtVendor4Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Turnoverlastyear", txtVendor4TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4TotalOrderwithco", txtVendor4TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4LastorderdetailswithCo", txtVendor4LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@PurchaseHead", ckPurchaseHead.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "0");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@MVPLNMajorDeviation", dtPLNMajorDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNBidEvaluation", dtPLNBidEvaluation);
                        cmd.Parameters.AddWithValue("@MVPLNDeviation", dtPLNDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNApprover", dtPLNApprover);
                        cmd.Parameters.AddWithValue("@MVPLNTermsandCondition", dtPLNTermsandCondition);
                        cmd.Parameters.AddWithValue("@MVPLNAttachment", dtPLNAttachment);
                        
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
                        script += "ListMultiVendorLogicNote.aspx";
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
            Fud.SaveAs(Server.MapPath("../Upload/MVPLN/") + strname);
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
        SetDataDFT();
        SetDataIH();
        SetDataTC();
        DataTable dtPLNMajorDeviation = new DataTable();
        DataTable dtPLNBidEvaluation = new DataTable();
        DataTable dtPLNDeviation = new DataTable();
        DataTable dtPLNApprover = new DataTable();
        DataTable dtPLNTermsandCondition = new DataTable();
        DataTable dtPLNAttachment = new DataTable();
        if (ViewState["dtDetailsSE"] != null)
            dtPLNMajorDeviation = (DataTable)ViewState["dtDetailsSE"];
        if (ViewState["dtDetailsIH"] != null)
            dtPLNBidEvaluation = (DataTable)ViewState["dtDetailsIH"];
        if (ViewState["dtDetailsDFT"] != null)
            dtPLNDeviation = (DataTable)ViewState["dtDetailsDFT"];
        if (ViewState["dtDetailsApprover"] != null)
            dtPLNApprover = (DataTable)ViewState["dtDetailsApprover"];
        if (ViewState["dtDetailsTC"] != null)
            dtPLNTermsandCondition = (DataTable)ViewState["dtDetailsTC"];
        if (ViewState["dtDetailsAttachment"] != null)
            dtPLNAttachment = (DataTable)ViewState["dtDetailsAttachment"];
        string nameofproposedvendor = ddlVendor1.SelectedValue+","+ddlVendor2.SelectedValue+","+ddlVendor3.SelectedValue+","+ddlVendor3.SelectedValue;
        //var query = from System.Web.UI.WebControls.ListItem item in ddlnameofproposedvendor.Items where item.Selected select item;
        //foreach (System.Web.UI.WebControls.ListItem item in query)
        //{
        //    if (item.Selected == true)
        //    {
        //        if (nameofproposedvendor == "")
        //            nameofproposedvendor = item.Value.ToString();
        //        else
        //            nameofproposedvendor += "," + item.Value.ToString();
        //    }
        //}
        dtUser = (DataTable)Session["UserSession"];
        if (ddlApproval.SelectedValue == "2")
        {
            string orderNo = AmendmentOrderNo();
            if (orderNo != "")
            {
                txtApprovalNo.Text = orderNo;
            }

        }
        if (dtPLNApprover.Rows.Count == 1)
        {
            int approverid = int.Parse(dtPLNApprover.Rows[0]["ApproverID"].ToString());
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
                    using (SqlCommand cmd = new SqlCommand("sp_ManageMVPurchaseLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@MVPLNRefID", "");
                        cmd.Parameters.AddWithValue("@ApprovalType1", ddlApproval.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text);
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendment", txtReasonOfAmendment.Text);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
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
                        cmd.Parameters.AddWithValue("@Proposedaward", txtProposedvalueofaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                        cmd.Parameters.AddWithValue("@NameofProposedVendor", nameofproposedvendor);
                        cmd.Parameters.AddWithValue("@NegotiationMode", ddlNegotationMode.SelectedValue);
                        cmd.Parameters.AddWithValue("@CommercialratingofBid", txtCommercialratingofbid.Text.Trim());
                        cmd.Parameters.AddWithValue("@Proposedtimeline", txtProposedtimelineDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@ResponsiblePerson", txtresponsibleperson.Text);
                        cmd.Parameters.AddWithValue("@MaterialUseBydate", txtmaterialuserdate.Text.Trim());
                        cmd.Parameters.AddWithValue("@PlaceofUse", txtplaceofuse.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendorconsidered", txtTotalVendorConsidred.Text.Trim());
                        cmd.Parameters.AddWithValue("@RejectedVendors", txtRejectedVendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@RFQinvited", txtRFQInvited.Text.Trim());
                        cmd.Parameters.AddWithValue("@Notquoted", txtNotQuoted.Text.Trim());
                        cmd.Parameters.AddWithValue("@FinalConsidered", txtFinalConsidered.Text.Trim());
                        cmd.Parameters.AddWithValue("@StipulatedCompletionTime", txtStipulatedCompletionTime.Text.Trim());
                        cmd.Parameters.AddWithValue("@BidType", ddlBidType.SelectedValue);
                        cmd.Parameters.AddWithValue("@Approvaltype", ddlApprovaltype.SelectedValue);
                        cmd.Parameters.AddWithValue("@ContractorName", txtContratorName.Text.Trim());
                        cmd.Parameters.AddWithValue("@AuctionType", ddlActionType.SelectedValue);
                        cmd.Parameters.AddWithValue("@DateofAribaAuction", txtDateofAribaAuction.Text.Trim());
                        cmd.Parameters.AddWithValue("@Singleorderreason", txtSingleRepeatOrderReson.Text.Trim());
                       cmd.Parameters.AddWithValue("@Vendor1", ddlVendor1.SelectedValue.ToString() == "0" ? hiddenvendor1.Value : ddlVendor1.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor2", ddlVendor2.SelectedValue.ToString() == "0" ? hiddenvendor2.Value : ddlVendor2.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor3", ddlVendor3.SelectedValue.ToString() == "0" ? hiddenvendor3.Value : ddlVendor3.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor4", ddlVendor4.SelectedValue.ToString() == "0" ? hiddenvendor4.Value : ddlVendor4.SelectedValue);
                        cmd.Parameters.AddWithValue("@V1GST", txtV1GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GST", txtV2GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GST", txtV3GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GST", txtV4GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Freight", txtV1Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Freight", txtV2Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Freight", txtV3Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Freight", txtV4Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1HandlingCharges", txtV1HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges", txtV2HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges", txtV3HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges", txtV4HeadlingCharges.Text.Trim());

                        cmd.Parameters.AddWithValue("@V1HandlingCharges1", txtV1handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges1", txtV2handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges1", txtV3handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges1", txtV4handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1OtherCharges", txtV1OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2OtherCharges", txtV2OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3OtherCharges", txtV3OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4OtherCharges", txtV4OtherCharge.Text.Trim());

                        cmd.Parameters.AddWithValue("@V1GrandTotal", txtV1GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GrandTotal", txtV2GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GrandTotal", txtV3GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GrandTotal", txtV4GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1DeliveryTimeline", txtVendor1DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2DeliveryTimeline", txtVendor2DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3DeliveryTimeline", txtVendor3DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4DeliveryTimeline", txtVendor4DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BudgetedRate", txtVendor1Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BudgetedRate", txtVendor2Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BudgetedRate", txtVendor3Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BudgetedRate", txtVendor4Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BidsStatus", txtVendor1BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BidsStatus", txtVendor2BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BidsStatus", txtVendor3BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BidsStatus", txtVendor4BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorRatings", ddlVendor1Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorRatings", ddlVendor2Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorRatings", ddlVendor3Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorRatings", ddlVendor4Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1AwardPreference", ddlVendor1AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2AwardPreference", ddlVendor2AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3AwardPreference", ddlVendor3AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4AwardPreference", ddlVendor4AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1CostPerSqFt", txtVendor1CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2CostPerSqFt", txtVendor2CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3CostPerSqFt", txtVendor3CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4CostPerSqFt", txtVendor4CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorInformation", txtVendorInformation.Text.Trim() == "" ? hiddenvendortext1.Value : txtVendorInformation.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Turnoverlastyear", txtTournoverlastyear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1TotalOrderwithco", txtTotalOrderwithcotilldate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1LastorderdetailswithCo", txtLastOrderdetailswithco.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorInformation", txtVendor2Information.Text.Trim() == "" ? hiddenvendortext2.Value : txtVendor2Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Turnoverlastyear", txtVendor2TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2TotalOrderwithco", txtVendor2TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2LastorderdetailswithCo", txtVendor2LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorInformation", txtVendor3Information.Text.Trim() == "" ? hiddenvendortext3.Value : txtVendor3Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Turnoverlastyear", txtVendor3TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3TotalOrderwithco", txtVendor3TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3LastorderdetailswithCo", txtVendor3LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorInformation", txtVendor4Information.Text.Trim() == "" ? hiddenvendortext4.Value : txtVendor4Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Turnoverlastyear", txtVendor4TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4TotalOrderwithco", txtVendor4TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4LastorderdetailswithCo", txtVendor4LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@PurchaseHead", ckPurchaseHead.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@MVPLNMajorDeviation", dtPLNMajorDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNBidEvaluation", dtPLNBidEvaluation);
                        cmd.Parameters.AddWithValue("@MVPLNDeviation", dtPLNDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNApprover", dtPLNApprover);
                        cmd.Parameters.AddWithValue("@MVPLNTermsandCondition", dtPLNTermsandCondition);
                        cmd.Parameters.AddWithValue("@MVPLNAttachment", dtPLNAttachment);
                        
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
                        script += "ListMultiVendorLogicNote.aspx";
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
                    using (SqlCommand cmd = new SqlCommand("sp_ManageMVPurchaseLogicNote"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@MVPLNRefID", "");
                        cmd.Parameters.AddWithValue("@ApprovalType1", ddlApproval.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalNo", txtApprovalNo.Text);
                        cmd.Parameters.AddWithValue("@CompanyID", ddlCompanyName.SelectedValue);
                        cmd.Parameters.AddWithValue("@ReasonOfAmendment", txtReasonOfAmendment.Text);
                        cmd.Parameters.AddWithValue("@ApprovalAuthrityID", ddlapprovalauthrity.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubjectandScope", txtSubjectScope.Text.Trim());
                        cmd.Parameters.AddWithValue("@ProjectID", ddlprojectname.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocationID", ddllocation.SelectedValue == "0" ? hddlocationId.Value : ddllocation.SelectedValue);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddlDepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
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
                        cmd.Parameters.AddWithValue("@Proposedaward", txtProposedvalueofaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@BalanceAward", txtBalancetobeaward.Text.Trim());
                        cmd.Parameters.AddWithValue("@Variationfombudget", txtvariationfrombudget.Text.Trim());
                        cmd.Parameters.AddWithValue("@Reasonofvariation", ddlReasonofvariation.SelectedValue);
                        cmd.Parameters.AddWithValue("@OtherDescription", txtother.Text);
                        cmd.Parameters.AddWithValue("@NameofProposedVendor", nameofproposedvendor);
                        cmd.Parameters.AddWithValue("@NegotiationMode", ddlNegotationMode.SelectedValue);
                        cmd.Parameters.AddWithValue("@CommercialratingofBid", txtCommercialratingofbid.Text.Trim());
                        cmd.Parameters.AddWithValue("@Proposedtimeline", txtProposedtimelineDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@ResponsiblePerson", txtresponsibleperson.Text);
                        cmd.Parameters.AddWithValue("@MaterialUseBydate", txtmaterialuserdate.Text.Trim());
                        cmd.Parameters.AddWithValue("@PlaceofUse", txtplaceofuse.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendorconsidered", txtTotalVendorConsidred.Text.Trim());
                        cmd.Parameters.AddWithValue("@RejectedVendors", txtRejectedVendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@RFQinvited", txtRFQInvited.Text.Trim());
                        cmd.Parameters.AddWithValue("@Notquoted", txtNotQuoted.Text.Trim());
                        cmd.Parameters.AddWithValue("@FinalConsidered", txtFinalConsidered.Text.Trim());
                        cmd.Parameters.AddWithValue("@StipulatedCompletionTime", txtStipulatedCompletionTime.Text.Trim());
                        cmd.Parameters.AddWithValue("@BidType", ddlBidType.SelectedValue);
                        cmd.Parameters.AddWithValue("@Approvaltype", ddlApprovaltype.SelectedValue);
                        cmd.Parameters.AddWithValue("@ContractorName", txtContratorName.Text.Trim());
                        cmd.Parameters.AddWithValue("@AuctionType", ddlActionType.SelectedValue);
                        cmd.Parameters.AddWithValue("@DateofAribaAuction", txtDateofAribaAuction.Text.Trim());
                        cmd.Parameters.AddWithValue("@Singleorderreason", txtSingleRepeatOrderReson.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendor1", ddlVendor1.SelectedValue.ToString() == "0" ? hiddenvendor1.Value : ddlVendor1.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor2", ddlVendor2.SelectedValue.ToString() == "0" ? hiddenvendor2.Value : ddlVendor2.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor3", ddlVendor3.SelectedValue.ToString() == "0" ? hiddenvendor3.Value : ddlVendor3.SelectedValue);
                        cmd.Parameters.AddWithValue("@Vendor4", ddlVendor4.SelectedValue.ToString() == "0" ? hiddenvendor4.Value : ddlVendor4.SelectedValue);
                        cmd.Parameters.AddWithValue("@V1GST", txtV1GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GST", txtV2GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GST", txtV3GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GST", txtV4GST.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Freight", txtV1Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Freight", txtV2Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Freight", txtV3Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Freight", txtV4Freight.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1HandlingCharges", txtV1HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges", txtV2HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges", txtV3HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges", txtV4HeadlingCharges.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1HandlingCharges1", txtV1handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2HandlingCharges1", txtV2handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3HandlingCharges1", txtV3handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4HandlingCharges1", txtV4handling.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1OtherCharges", txtV1OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2OtherCharges", txtV2OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3OtherCharges", txtV3OtherCharge.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4OtherCharges", txtV4OtherCharge.Text.Trim());

                        cmd.Parameters.AddWithValue("@V1GrandTotal", txtV1GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2GrandTotal", txtV2GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3GrandTotal", txtV3GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4GrandTotal", txtV4GrandTotal.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1DeliveryTimeline", txtVendor1DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2DeliveryTimeline", txtVendor2DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3DeliveryTimeline", txtVendor3DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4DeliveryTimeline", txtVendor4DeliveryTimeline.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BudgetedRate", txtVendor1Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BudgetedRate", txtVendor2Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BudgetedRate", txtVendor3Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BudgetedRate", txtVendor4Comparision.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1BidsStatus", txtVendor1BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2BidsStatus", txtVendor2BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3BidsStatus", txtVendor3BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4BidsStatus", txtVendor4BidStatus.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorRatings", ddlVendor1Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorRatings", ddlVendor2Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorRatings", ddlVendor3Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorRatings", ddlVendor4Rating.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1AwardPreference", ddlVendor1AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V2AwardPreference", ddlVendor2AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V3AwardPreference", ddlVendor3AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V4AwardPreference", ddlVendor4AwardPreference.SelectedValue.Trim());
                        cmd.Parameters.AddWithValue("@V1CostPerSqFt", txtVendor1CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2CostPerSqFt", txtVendor2CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3CostPerSqFt", txtVendor3CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4CostPerSqFt", txtVendor4CostPerSqft.Text.Trim());
                        cmd.Parameters.AddWithValue("@Recommendationswithreasons", txtreccomandationwithreason.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1VendorInformation", txtVendorInformation.Text.Trim() == "" ? hiddenvendortext1.Value : txtVendorInformation.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1Turnoverlastyear", txtTournoverlastyear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1TotalOrderwithco", txtTotalOrderwithcotilldate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V1LastorderdetailswithCo", txtLastOrderdetailswithco.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2VendorInformation", txtVendor2Information.Text.Trim() == "" ? hiddenvendortext2.Value : txtVendor2Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2Turnoverlastyear", txtVendor2TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2TotalOrderwithco", txtVendor2TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V2LastorderdetailswithCo", txtVendor2LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3VendorInformation", txtVendor3Information.Text.Trim() == "" ? hiddenvendortext3.Value : txtVendor3Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3Turnoverlastyear", txtVendor3TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3TotalOrderwithco", txtVendor3TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V3LastorderdetailswithCo", txtVendor3LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4VendorInformation", txtVendor4Information.Text.Trim() == "" ? hiddenvendortext4.Value : txtVendor4Information.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4Turnoverlastyear", txtVendor4TurnOverLastYear.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4TotalOrderwithco", txtVendor4TotalorderswithCoDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@V4LastorderdetailswithCo", txtVendor4LastorderdetailswithCo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remark", ckremark.Text.Trim());
                        cmd.Parameters.AddWithValue("@PurchaseHead", ckPurchaseHead.Text.Trim());
                        cmd.Parameters.AddWithValue("@SubmitforApproval", "1");
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@MVPLNMajorDeviation", dtPLNMajorDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNBidEvaluation", dtPLNBidEvaluation);
                        cmd.Parameters.AddWithValue("@MVPLNDeviation", dtPLNDeviation);
                        cmd.Parameters.AddWithValue("@MVPLNApprover", dtPLNApprover);
                        cmd.Parameters.AddWithValue("@MVPLNTermsandCondition", dtPLNTermsandCondition);
                        cmd.Parameters.AddWithValue("@MVPLNAttachment", dtPLNAttachment);
                        
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
                        // tranScope.Dispose();
                        string message = strMessage;
                        string script = "window.onload = function(){ alert('";
                        script += message;
                        script += "');";
                        script += "window.location = '";
                        script += "ListMultiVendorLogicNote.aspx";
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

    protected void txtApprovalBudget_TextChanged(object sender, EventArgs e)
    {
        fillVariationofBudget();
    }

    protected void txtAlreadyAwarded_TextChanged(object sender, EventArgs e)
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
        if (double.TryParse(txtApprovalBudget.Text, out dblapprovalBudget)) { }
        //if (double.TryParse(txtAlreadyAwarded.Text, out dblAlreadyAwarded)) { }
        if (double.TryParse(txtProposedvalueofaward.Text, out dblProposedvalueofaward)) { }
        if (double.TryParse(txtBalancetobeaward.Text, out dblBalancetobeaward)) { }
        dblVaritaion = (dblapprovalBudget - dblProposedvalueofaward - dblBalancetobeaward);
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

    protected void ddlBidType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlBidType.SelectedValue == "Single Quote" || ddlBidType.SelectedValue == "Repeat Order")
        {
            txtSingleRepeatOrderReson.Text = "";
            txtSingleRepeatOrderReson.ReadOnly = false;
        }
        else
        {
            txtSingleRepeatOrderReson.Text = "";
            txtSingleRepeatOrderReson.ReadOnly = true;
        }
    }

    protected void ddlActionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlActionType.SelectedValue == "Manual")
        {
            txtDateofAribaAuction.Text = "";
            txtDateofAribaAuction.ReadOnly = false;
        }
        else
        {
            //txtDateofAribaAuction.Text = "";
            txtDateofAribaAuction.ReadOnly = true;
        }
    }

    protected void txtTotalVendorConsidred_TextChanged(object sender, EventArgs e)
    {
        FillVendorCal();
    }

    protected void txtRejectedVendor_TextChanged(object sender, EventArgs e)
    {
        FillVendorCal();
    }

    protected void txtNotQuoted_TextChanged(object sender, EventArgs e)
    {
        FillVendorCal();
    }

    private void FillVendorCal()
    {
        double dblTotalVendor = 0;
        double dblRejectedVendor = 0;
        double dblRFQinvited = 0;
        double dblNotQuoted = 0;
        double dblFinalConsidered = 0;
        if (double.TryParse(txtTotalVendorConsidred.Text, out dblTotalVendor)) { }
        if (double.TryParse(txtRejectedVendor.Text, out dblRejectedVendor)) { }
        dblRFQinvited = dblTotalVendor - dblRejectedVendor;
        txtRFQInvited.Text = dblRFQinvited.ToString();
        if (double.TryParse(txtRFQInvited.Text, out dblRFQinvited)) { }
        if (double.TryParse(txtNotQuoted.Text, out dblNotQuoted)) { }
        dblFinalConsidered = dblRFQinvited - dblNotQuoted;
        txtFinalConsidered.Text = dblFinalConsidered.ToString();
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType.SelectedValue == "Direct Purchase")
        {
            txtContratorName.Text = "";
            ddlApprovaltype.SelectedValue = "Actual Purchase";
            txtContratorName.ReadOnly = true;
            ddlApprovaltype.Enabled = false;
        }
        else if (ddlType.SelectedValue == "Rate Approval")
        {
            ddlApprovaltype.SelectedValue = "Base Rate";
            txtContratorName.ReadOnly = false;
            ddlApprovaltype.Enabled = false;
        }
        else if (ddlType.SelectedValue == "Regularization of Purchase")
        {
            ddlApprovaltype.SelectedValue = "Regularization of Purchase";
            txtContratorName.ReadOnly = false;
            ddlApprovaltype.Enabled = false;
        }
        else if (ddlType.SelectedValue == "Regularization of Rate Approval")
        {
            ddlApprovaltype.SelectedValue = "Regularization of Rate Approval";
            txtContratorName.ReadOnly = false;
            ddlApprovaltype.Enabled = false;
        }
        else
        {
            ddlApprovaltype.SelectedValue = "0";
            txtContratorName.ReadOnly = false;
            ddlApprovaltype.Enabled = true;
        }
    }

    protected void txtQuantity_TextChanged(object sender, EventArgs e)
    {
        decimal dblV1Quanity = 0;
        decimal dblV2Quanity = 0;
        decimal dblV3Quanity = 0;
        decimal dblV4Quanity = 0;
        decimal dblVendor1Rate = 0;
        decimal dblVendor2Rate = 0;
        decimal dblVendor3Rate = 0;
        decimal dblVendor4Rate = 0;
        decimal dblVendor1Value = 0;
        decimal dblVendor2Value = 0;
        decimal dblVendor3Value = 0;      
        decimal dblVendor4Value = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtV1Quantity = (TextBox)row.FindControl("txtV1Quantity");
        TextBox txtV2Quantity = (TextBox)row.FindControl("txtV2Quantity");
        TextBox txtV3Quantity = (TextBox)row.FindControl("txtV3Quantity");
        TextBox txtV4Quantity = (TextBox)row.FindControl("txtV4Quantity");
        TextBox txtVendor1Rate = (TextBox)row.FindControl("txtVendor1Rate");
        TextBox txtVendor2Rate = (TextBox)row.FindControl("txtVendor2Rate");
        TextBox txtVendor3Rate = (TextBox)row.FindControl("txtVendor3Rate");
        TextBox txtVendor4Rate = (TextBox)row.FindControl("txtVendor4Rate");
        TextBox txtVendor1Value = (TextBox)row.FindControl("txtVendor1Value");
        TextBox txtVendor2Value = (TextBox)row.FindControl("txtVendor2Value");
        TextBox txtVendor3Value = (TextBox)row.FindControl("txtVendor3Value");
        TextBox txtVendor4Value = (TextBox)row.FindControl("txtVendor4Value");

        if (decimal.TryParse(txtV1Quantity.Text, out dblV1Quanity)) { }
        if (decimal.TryParse(txtV2Quantity.Text, out dblV2Quanity)) { }
        if (decimal.TryParse(txtV3Quantity.Text, out dblV3Quanity)) { }
        if (decimal.TryParse(txtV4Quantity.Text, out dblV4Quanity)) { }

        if (decimal.TryParse(txtVendor1Rate.Text, out dblVendor1Rate)) { }
        if (decimal.TryParse(txtVendor2Rate.Text, out dblVendor2Rate)) { }
        if (decimal.TryParse(txtVendor3Rate.Text, out dblVendor3Rate)) { }
        if (decimal.TryParse(txtVendor4Rate.Text, out dblVendor4Rate)) { }

        dblVendor1Value = (dblV1Quanity * dblVendor1Rate);
        dblVendor2Value = (dblV2Quanity * dblVendor2Rate);
        dblVendor3Value = (dblV3Quanity * dblVendor3Rate);
        dblVendor4Value = (dblV4Quanity * dblVendor4Rate);
        txtVendor1Value.Text = dblVendor1Value.ToString();
        txtVendor2Value.Text = dblVendor2Value.ToString();
        txtVendor3Value.Text = dblVendor3Value.ToString();
        txtVendor4Value.Text = dblVendor4Value.ToString();
    }

    protected void txtVendor1Rate_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblVendor1Rate = 0;
        decimal dblVendor1Value = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtV1Quantity = (TextBox)row.FindControl("txtV1Quantity");
        TextBox txtVendor1Rate = (TextBox)row.FindControl("txtVendor1Rate");
        TextBox txtVendor1Value = (TextBox)row.FindControl("txtVendor1Value");
        if (decimal.TryParse(txtV1Quantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtVendor1Rate.Text, out dblVendor1Rate)) { }
        dblVendor1Value = (dblQuanity * dblVendor1Rate);
        txtVendor1Value.Text = dblVendor1Value.ToString();
    }

    protected void txtVendor2Rate_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblVendor2Rate = 0;
        decimal dblVendor2Value = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtV2Quantity = (TextBox)row.FindControl("txtV2Quantity");
        TextBox txtVendor2Rate = (TextBox)row.FindControl("txtVendor2Rate");
        TextBox txtVendor2Value = (TextBox)row.FindControl("txtVendor2Value");
        if (decimal.TryParse(txtV2Quantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtVendor2Rate.Text, out dblVendor2Rate)) { }
        dblVendor2Value = (dblQuanity * dblVendor2Rate);
        txtVendor2Value.Text = dblVendor2Value.ToString();
    }

    protected void txtVendor3Rate_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblVendor3Rate = 0;
        decimal dblVendor3Value = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtV3Quantity = (TextBox)row.FindControl("txtV3Quantity");
        TextBox txtVendor3Rate = (TextBox)row.FindControl("txtVendor3Rate");
        TextBox txtVendor3Value = (TextBox)row.FindControl("txtVendor3Value");
        if (decimal.TryParse(txtV3Quantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtVendor3Rate.Text, out dblVendor3Rate)) { }
        dblVendor3Value = (dblQuanity * dblVendor3Rate);
        txtVendor3Value.Text = dblVendor3Value.ToString();
    }
    protected void txtVendor4Rate_TextChanged(object sender, EventArgs e)
    {
        decimal dblQuanity = 0;
        decimal dblVendor4Rate = 0;
        decimal dblVendor4Value = 0;
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtV4Quantity = (TextBox)row.FindControl("txtV4Quantity");
        TextBox txtVendor4Rate = (TextBox)row.FindControl("txtVendor4Rate");
        TextBox txtVendor4Value = (TextBox)row.FindControl("txtVendor4Value");
        if (decimal.TryParse(txtV4Quantity.Text, out dblQuanity)) { }
        if (decimal.TryParse(txtVendor4Rate.Text, out dblVendor4Rate)) { }
        dblVendor4Value = (dblQuanity * dblVendor4Rate);
        txtVendor4Value.Text = dblVendor4Value.ToString();
    }
    private void CalCostPersqft()
    {
        decimal dblV1Costpersqft = 0;
        decimal dblV2Costpersqft = 0;
        decimal dblV3Costpersqft = 0;
        decimal dblV4Costpersqft = 0;
        decimal dblSaleableArea = 0;
        decimal dblV1GST = 0;
        decimal dblV2GST = 0;
        decimal dblV3GST = 0;
        decimal dblV4GST = 0;
        decimal dblV1Freight = 0;
        decimal dblV2Freight = 0;
        decimal dblV3Freight = 0;
        decimal dblV4Freight = 0;
        decimal dblV1HeandlingCharges = 0;
        decimal dblV2HeandlingCharges = 0;
        decimal dblV3HeandlingCharges = 0;
        decimal dblV4HeandlingCharges = 0;

        decimal dblV1handling = 0;
        decimal dblV2handling = 0;
        decimal dblV3handling = 0;
        decimal dblV4handling = 0;
        decimal dblV1OtherCharges = 0;
        decimal dblV2OtherCharges = 0;
        decimal dblV3OtherCharges = 0;
        decimal dblV4OtherCharges = 0;


        decimal dblV1GrandTotal = 0;
        decimal dblV2GrandTotal = 0;
        decimal dblV3GrandTotal = 0;
        decimal dblV4GrandTotal = 0;
        decimal dblV1Value = 0;
        decimal dblV2Value = 0;
        decimal dblV3Value = 0;
        decimal dblV4Value = 0;

        if (decimal.TryParse(txtSaleableArea.Text, out dblSaleableArea)) { }
        if (decimal.TryParse(txtV1GST.Text, out dblV1GST)) { }
        if (decimal.TryParse(txtV2GST.Text, out dblV2GST)) { }
        if (decimal.TryParse(txtV3GST.Text, out dblV3GST)) { }
        if (decimal.TryParse(txtV4GST.Text, out dblV4GST)) { }
        if (decimal.TryParse(txtV1Freight.Text, out dblV1Freight)) { }
        if (decimal.TryParse(txtV2Freight.Text, out dblV2Freight)) { }
        if (decimal.TryParse(txtV3Freight.Text, out dblV3Freight)) { }
        if (decimal.TryParse(txtV4Freight.Text, out dblV4Freight)) { }
        if (decimal.TryParse(txtV1HeadlingCharges.Text, out dblV1HeandlingCharges)) { }
        if (decimal.TryParse(txtV2HeadlingCharges.Text, out dblV2HeandlingCharges)) { }
        if (decimal.TryParse(txtV3HeadlingCharges.Text, out dblV3HeandlingCharges)) { }
        if (decimal.TryParse(txtV4HeadlingCharges.Text, out dblV4HeandlingCharges)) { }

        if (decimal.TryParse(txtV1handling.Text, out dblV1handling)) { }
        if (decimal.TryParse(txtV2handling.Text, out dblV2handling)) { }
        if (decimal.TryParse(txtV3handling.Text, out dblV3handling)) { }
        if (decimal.TryParse(txtV4handling.Text, out dblV4handling)) { }

        if (decimal.TryParse(txtV1OtherCharge.Text, out dblV1OtherCharges)) { }
        if (decimal.TryParse(txtV2OtherCharge.Text, out dblV2OtherCharges)) { }
        if (decimal.TryParse(txtV3OtherCharge.Text, out dblV3OtherCharges)) { }
        if (decimal.TryParse(txtV4OtherCharge.Text, out dblV4OtherCharges)) { }

        //if (decimal.TryParse(((Label)gvItemHead.FooterRow.Cells[6].FindControl("lblV1TotalValue")).Text, out dblV1Value)) { }
        //if (decimal.TryParse(gvItemHead.FooterRow.Cells[8].Text, out dblV2Value)) { }
        //if (decimal.TryParse(gvItemHead.FooterRow.Cells[10].Text, out dblV3Value)) { }
        //if (decimal.TryParse(gvItemHead.FooterRow.Cells[12].Text, out dblV4Value)) { }

        if (decimal.TryParse(hdnV1Value.Value, out dblV1Value)) { }
        if (decimal.TryParse(hdnV2Value.Value, out dblV2Value)) { }
        if (decimal.TryParse(hdnV3Value.Value, out dblV3Value)) { }
        if (decimal.TryParse(hdnV4Value.Value, out dblV4Value)) { }
        dblV1GrandTotal = (dblV1Value + dblV1GST + dblV1Freight + dblV1HeandlingCharges + dblV1handling + dblV1OtherCharges);
        dblV2GrandTotal = (dblV2Value + dblV2GST + dblV2Freight + dblV2HeandlingCharges + dblV2handling + dblV2OtherCharges);
        dblV3GrandTotal = (dblV3Value + dblV3GST + dblV3Freight + dblV3HeandlingCharges + dblV3handling + dblV3OtherCharges);
        dblV4GrandTotal = (dblV4Value + dblV4GST + dblV4Freight + dblV4HeandlingCharges + dblV4handling + dblV4OtherCharges);
        if (dblSaleableArea > 0)
        {
            dblV1Costpersqft = dblV1GrandTotal / dblSaleableArea;
            dblV2Costpersqft = dblV2GrandTotal / dblSaleableArea;
            dblV3Costpersqft = dblV3GrandTotal / dblSaleableArea;
            dblV4Costpersqft = dblV4GrandTotal / dblSaleableArea;
        }
        txtV1GrandTotal.Text = dblV1GrandTotal.ToString();
        txtV2GrandTotal.Text = dblV2GrandTotal.ToString();
        txtV3GrandTotal.Text = dblV3GrandTotal.ToString();
        txtV4GrandTotal.Text = dblV4GrandTotal.ToString();
        txtVendor1CostPerSqft.Text = Math.Round(dblV1Costpersqft, 2).ToString();
        txtVendor2CostPerSqft.Text = Math.Round(dblV2Costpersqft, 2).ToString();
        txtVendor3CostPerSqft.Text = Math.Round(dblV3Costpersqft, 2).ToString();
        txtVendor4CostPerSqft.Text = Math.Round(dblV4Costpersqft, 2).ToString();
        decimal dblMaxValue = 0;
        //dblMaxValue = Math.Max(dblV1GrandTotal, Math.Max(dblV2GrandTotal, dblV3GrandTotal));
        //if ((dblMaxValue == dblV1GrandTotal) && (dblMaxValue == dblV2GrandTotal) && (dblMaxValue == dblV3GrandTotal))
        //{
        //    txtVendor1BidStatus.Text = "L1";
        //    txtVendor2BidStatus.Text = "L1";
        //    txtVendor3BidStatus.Text = "L1";
        //}
        //else if ((dblMaxValue == dblV1GrandTotal) && (dblMaxValue == dblV2GrandTotal))
        //{
        //    txtVendor1BidStatus.Text = "L1";
        //    txtVendor2BidStatus.Text = "L1";
        //    txtVendor3BidStatus.Text = "L2";
        //}
        //else if ((dblMaxValue == dblV2GrandTotal) && (dblMaxValue == dblV3GrandTotal))
        //{
        //    txtVendor1BidStatus.Text = "L2";
        //    txtVendor2BidStatus.Text = "L1";
        //    txtVendor3BidStatus.Text = "L1";
        //}
        //else if ((dblMaxValue == dblV1GrandTotal) && (dblMaxValue == dblV3GrandTotal))
        //{
        //    txtVendor1BidStatus.Text = "L1";
        //    txtVendor2BidStatus.Text = "L2";
        //    txtVendor3BidStatus.Text = "L1";
        //}
        //else if (dblMaxValue == dblV1GrandTotal)
        //{
        //    txtVendor1BidStatus.Text = "L1";
        //    if (dblV2GrandTotal == dblV3GrandTotal)
        //    {
        //        txtVendor2BidStatus.Text = "L2";
        //        txtVendor3BidStatus.Text = "L2";
        //    }
        //    else if (dblV2GrandTotal > dblV3GrandTotal)
        //    {
        //        txtVendor2BidStatus.Text = "L2";
        //        txtVendor3BidStatus.Text = "L3";
        //    }
        //    else if (dblV3GrandTotal > dblV2GrandTotal)
        //    {
        //        txtVendor2BidStatus.Text = "L3";
        //        txtVendor3BidStatus.Text = "L2";
        //    }
        //}
        //else if (dblMaxValue == dblV2GrandTotal)
        //{
        //    txtVendor2BidStatus.Text = "L1";
        //    if (dblV1GrandTotal == dblV3GrandTotal)
        //    {
        //        txtVendor1BidStatus.Text = "L2";
        //        txtVendor3BidStatus.Text = "L2";
        //    }
        //    else if (dblV1GrandTotal > dblV3GrandTotal)
        //    {
        //        txtVendor1BidStatus.Text = "L2";
        //        txtVendor3BidStatus.Text = "L3";
        //    }
        //    else if (dblV3GrandTotal > dblV1GrandTotal)
        //    {
        //        txtVendor1BidStatus.Text = "L3";
        //        txtVendor3BidStatus.Text = "L2";
        //    }
        //}
        //else if (dblMaxValue == dblV3GrandTotal)
        //{
        //    txtVendor3BidStatus.Text = "L1";
        //    if (dblV1GrandTotal == dblV2GrandTotal)
        //    {
        //        txtVendor1BidStatus.Text = "L2";
        //        txtVendor2BidStatus.Text = "L2";
        //    }
        //    else if (dblV1GrandTotal > dblV2GrandTotal)
        //    {
        //        txtVendor1BidStatus.Text = "L2";
        //        txtVendor2BidStatus.Text = "L3";
        //    }
        //    else if (dblV2GrandTotal > dblV1GrandTotal)
        //    {
        //        txtVendor1BidStatus.Text = "L3";
        //        txtVendor2BidStatus.Text = "L2";
        //    }
        //}
        //if (dblV1GrandTotal == 0)
        //{
        //    txtVendor1BidStatus.Text = "";
        //}
        //if (dblV2GrandTotal == 0)
        //{
        //    txtVendor2BidStatus.Text = "";
        //}
        //if (dblV3GrandTotal == 0)
        //{
        //    txtVendor3BidStatus.Text = "";
        //}
    }

    protected void txtSaleableArea_TextChanged(object sender, EventArgs e)
    {
        CalCostPersqft();
    }

    protected void btnGrandTotal_Click(object sender, EventArgs e)
    {
        SetDataIH();
        ScriptManager.RegisterStartupScript(Page, GetType(), "disp_confirm", "<script>call()</script>", false);
        
    }



    //protected void lnkvendor_Click(object sender, EventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "window.open('VendorMaster.aspx');", true);
    //}

    //protected void lnkitem_Click(object sender, EventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "window.open('ItemMaster.aspx');", true);
    //}

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
        ScriptManager.RegisterStartupScript(Page, GetType(), "disp_confirm", "<script>call()</script>", false);
    }

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetApprovalNo(string prefixText)
    {
        cls_connection_new cls = new cls_connection_new();
        DataTable dt = cls.selectDataTable("select MVPLNOrderNo from tbl_MVPurchaseLogicNote where MVPLNOrderNo like '%" + prefixText + "%' and IsActive=1 and MVPLNOrderNo is not null and MVPLNOrderNo<>''");
        List<string> list = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            list.Add(dt.Rows[i]["MVPLNOrderNo"].ToString());
        }
        return list;
    }
    protected void txtApprovalNo_TextChanged(object sender, EventArgs e)
    {
        if (txtApprovalNo.Text != "")
        {
            int ID = cls.ExecuteIntScalar("select ID From tbl_MVPurchaseLogicNote where MVPLNOrderNo='" + txtApprovalNo.Text + "'");
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
                // ddlDepartment.Enabled = false;
                //txtCustomerName.Enabled = false;
                //txtChannelPartnerName.Enabled = false;
                //txtChannelPartnerName.CssClass = "form-control";
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
            txtReasonOfAmendment.Attributes.Remove("disabled");
        }
    }
    public string AmendmentOrderNo()
    {
        string orderNo = cls.ExecuteStringScalar("select ApprovalNo from tbl_MVPurchaseLogicNote where MVPLNOrderNo='" + txtApprovalNo.Text + "' and MVPLNOrderNo like '%R0%'");
        return orderNo;
    }
    #region ProjectAddres And Location
    [WebMethod]
    public static string getPorjectAddress(int projectId)
    {
        cls_connection_new cls = new cls_connection_new();
        return cls.ExecuteStringScalar("EXEC sp_ProjectMaster 'GetAddress','" + projectId + "'"); ;
    }
    #endregion ProjectAddres And Location   

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

    [WebMethod]
    public static List<System.Web.UI.WebControls.ListItem> GetProjectLocation(string projectId)
    {
        cls_connection_new cls = new cls_connection_new();
        DataTable dt = cls.selectDataTable("EXEC sp_LocationMaster 'GetByProjectID','" + projectId + "'");
        List<System.Web.UI.WebControls.ListItem> list = new List<System.Web.UI.WebControls.ListItem>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow sdr in dt.Rows)
                list.Add(new System.Web.UI.WebControls.ListItem
                {
                    Value = sdr["ID"].ToString(),
                    Text = sdr["LocationName"].ToString()
                });
        }

        return list;

    }

    protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        cls.BindDropDownList(ddlprojectname, "EXEC sp_ProjectMaster 'GetAllforddl',0,'" + ddlCompanyName.SelectedValue.ToString() + "'", "ProjectName", "ID");
    }

    protected void ddlprojectname_SelectedIndexChanged1(object sender, EventArgs e)
    {
        txtProjectaddress.Text = cls.ExecuteStringScalar("EXEC sp_ProjectMaster 'GetAddress','" + ddlprojectname.SelectedValue.ToString() + "'");
        cls.BindDropDownList(ddllocation, "EXEC sp_LocationMaster 'GetByProjectID','" + ddlprojectname.SelectedValue.ToString() + "'", "LocationName", "ID");
    }

   
}