using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Security.Principal;
using System.Data;
using System.Text.RegularExpressions;
using AjaxControlToolkit;
using iTextSharp.text.pdf;
using System.IO;
using iTextSharp.text;
using System.Drawing;

public partial class AdminPanel_PurchaseLogicNoteReport : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null)
            {
                if (Request.QueryString["Con"] != null)
                {
                    btnapprove.Visible = false;
                    btnreject.Visible = false;
                }
                dtData = cls.selectDataTable("EXEC sp_ManagePurchaseLogicNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    if (dtData.Rows[0]["IsApproved"].ToString().ToUpper() == "TRUE")
                    {
                        btnapprove.Enabled = false;
                        btnreject.Enabled = false;
                    }
                    else
                    {
                        btnapprove.Enabled = true;
                        btnreject.Enabled = true;
                    }
                    lblapprovalauthority.Text = dtData.Rows[0]["CommitteeName"].ToString();
                    lblsubjectscope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
                    lblprojectnaddress.Text = dtData.Rows[0]["ProjectName"].ToString() + " : " + dtData.Rows[0]["ProjectAddress"].ToString();

                    //lbld.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
                    //ddlType.SelectedValue = dtData.Rows[0]["Type"].ToString();
                    lblcompanyname.Text = dtData.Rows[0]["CompanyName"].ToString();
                    if (dtData.Rows[0]["OrderNo"].ToString() == "")
                    {
                        storderno.Visible = false;
                    }
                    else
                    {
                        storderno.Visible = true;
                        lblorderno.Text = dtData.Rows[0]["OrderNo"].ToString();

                    }


                    lblindentproponent.Text = dtData.Rows[0]["IndentProponent"].ToString();
                    DateTime indetdate = Convert.ToDateTime(dtData.Rows[0]["Dateofindent1"].ToString());
                    lbldateofindent.Text = indetdate.ToString("dd/MM/yyyy");
                    DateTime materialneededby = Convert.ToDateTime(dtData.Rows[0]["Materialneededby1"].ToString());
                    lblmaterialneededby.Text = materialneededby.ToString("dd/MM/yyyy");

                    lblstockinhand.Text = dtData.Rows[0]["StockinHand"].ToString() + "" + dtData.Rows[0]["StockUOM"].ToString();

                    lblrequirement.Text = dtData.Rows[0]["Requirement"].ToString();
                    //txtUrgetResionDescription.Text = dtData.Rows[0]["UrgentReasonDesc"].ToString();
                    lblsaleablearea.Text = dtData.Rows[0]["SaleableArea"].ToString();
                    lblapprovebudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
                    lblalreadyawarded.Text = dtData.Rows[0]["AlreadyAwarded"].ToString();
                    lblproposedvalueofthisaward.Text = dtData.Rows[0]["Proposedaward"].ToString();
                    lblbalancetobeawarded.Text = dtData.Rows[0]["BalanceAward"].ToString();
                    lblvariationfrombudget.Text = dtData.Rows[0]["Variationfombudget"].ToString();
                    Decimal variationbudget = Convert.ToDecimal(dtData.Rows[0]["Variationfombudget"].ToString());
                    if (variationbudget < 0)
                        tdvariationfrombudgetvalue.Attributes.Add("class", "red");
                    lblreasonofvariation.Text = dtData.Rows[0]["Reasonofvariation"].ToString();
                    if (dtData.Rows[0]["Reasonofvariation"].ToString() != "Others")
                    {
                        reasonofother.Visible = false;
                    }
                    else
                    {
                        reasonofother.Visible = true;
                        lblreasonofother.Text = dtData.Rows[0]["OtherDescription"].ToString();
                    }

                    lblproposedvendorname.Text = dtData.Rows[0]["ProposedVendor"].ToString();
                    lblnegotiationmode.Text = dtData.Rows[0]["NegotiationMode"].ToString();
                    if (dtData.Rows[0]["NegotiationMode"].ToString() == "Manual")
                    {
                        tdnegotiationmodeValue.Attributes.Add("BgColor", "Red");
                    }
                    else
                    {
                        tdnegotiationmodeValue.Attributes.Add("BgColor", "Green");
                    }

                    lblcommercialrating.Text = dtData.Rows[0]["CommercialratingofBid"].ToString();
                    DateTime stipulatedtimeline = Convert.ToDateTime(dtData.Rows[0]["Proposedtimeline1"].ToString());
                    lblstipulatedtimelinebyvendor.Text = stipulatedtimeline.ToString("dd/MM/yyyy");

                    lbltotalvendorconsider.Text = dtData.Rows[0]["Vendorconsidered"].ToString();
                    lblrejectedvendorasperpqual.Text = dtData.Rows[0]["RejectedVendors"].ToString();
                    lblrfqinvited.Text = dtData.Rows[0]["RFQinvited"].ToString();
                    lblnotquoted.Text = dtData.Rows[0]["Notquoted"].ToString();
                    lblfinalconsidered.Text = dtData.Rows[0]["FinalConsidered"].ToString();
                    DateTime stipulatedtimeline1 = Convert.ToDateTime(dtData.Rows[0]["StipulatedCompletionTime1"].ToString() == "" ? System.DateTime.Now.ToShortDateString() : dtData.Rows[0]["StipulatedCompletionTime1"].ToString());
                    lblstipulatedtimeline.Text = stipulatedtimeline1.ToString("dd/MM/yyyy");
                    lblbidtype.Text = dtData.Rows[0]["BidType"].ToString();
                    if (dtData.Rows[0]["BidType"].ToString() == "Single Quote")
                    {
                        tdbidtype.Attributes.Add("BgColor", "Red");
                    }
                    else if (dtData.Rows[0]["BidType"].ToString() == "Repeat Order")
                    {
                        tdbidtype.Attributes.Add("BgColor", "Yellow");
                    }
                    else
                    {
                        tdbidtype.Attributes.Add("BgColor", "Green");
                    }

                    lblapprovaltype.Text = dtData.Rows[0]["Approvaltype"].ToString();
                    lblcontractorname.Text = dtData.Rows[0]["ContractorName"].ToString();
                    lblauctiontype.Text = dtData.Rows[0]["AuctionType"].ToString();
                    if (dtData.Rows[0]["AuctionType"].ToString() == "Manual")
                    {
                        tdauctiontype.Attributes.Add("BgColor", "Red");
                    }
                    else
                    {
                        tdauctiontype.Attributes.Add("BgColor", "Green");
                    }
                    //txtDateofAribaAuction.Text = dtData.Rows[0]["DateofAribaAuction1"].ToString();
                    lblreason.Text = dtData.Rows[0]["Singleorderreason"].ToString();
                    //ddlVendor1.SelectedValue = dtData.Rows[0]["Vendor1"].ToString();
                    //ddlVendor2.SelectedValue = dtData.Rows[0]["Vendor2"].ToString();
                    //ddlVendor3.SelectedValue = dtData.Rows[0]["Vendor3"].ToString();
                    lblvendor1.Text = dtData.Rows[0]["VendorName1"].ToString();
                    lblvendor2.Text = dtData.Rows[0]["vendorName2"].ToString();
                    lblvendor3.Text = dtData.Rows[0]["vendorName3"].ToString();
                    lblgstv1.Text = dtData.Rows[0]["V1GST"].ToString();
                    lblgstv2.Text = dtData.Rows[0]["V2GST"].ToString();
                    lblgstv3.Text = dtData.Rows[0]["V3GST"].ToString();
                    lblfrieghtv1.Text = dtData.Rows[0]["V1Freight"].ToString();
                    lblfrieghtv2.Text = dtData.Rows[0]["V2Freight"].ToString();
                    lblfrieghtv3.Text = dtData.Rows[0]["V3Freight"].ToString();
                    lblhandingchargesv1.Text = dtData.Rows[0]["V1HandlingCharges"].ToString();
                    lblhandingchargesv2.Text = dtData.Rows[0]["V2HandlingCharges"].ToString();
                    lblhandingchargesv3.Text = dtData.Rows[0]["V3HandlingCharges"].ToString();
                    lblgrandtotalv1.Text = dtData.Rows[0]["V1GrandTotal"].ToString();
                    lblgrandtotalv2.Text = dtData.Rows[0]["V2GrandTotal"].ToString();
                    lblgrandtotalv3.Text = dtData.Rows[0]["V3GrandTotal"].ToString();

                    lblhandlinginsurancecharge1.Text = dtData.Rows[0]["V1HandlingCharges1"].ToString();
                    lblhandlinginsurancecharge2.Text = dtData.Rows[0]["V2HandlingCharges1"].ToString();
                    lblhandlinginsurancecharge3.Text = dtData.Rows[0]["V3HandlingCharges1"].ToString();
                    lblothercharge1.Text = dtData.Rows[0]["V1OtherCharges"].ToString();
                    lblothercharge2.Text = dtData.Rows[0]["V2OtherCharges"].ToString();
                    lblothercharge3.Text = dtData.Rows[0]["V3OtherCharges"].ToString();

                    if (dtData.Rows[0]["V1DeliveryTimeline1"].ToString() != "")
                    {
                        DateTime V1DeliveryTimeline1 = Convert.ToDateTime(dtData.Rows[0]["V1DeliveryTimeline1"].ToString());
                        lbldeliverytimelinev1.Text = V1DeliveryTimeline1.ToString("dd/MM/yyyy");
                    }
                    if (dtData.Rows[0]["V2DeliveryTimeline1"].ToString() != "")
                    {
                        DateTime V2DeliveryTimeline1 = Convert.ToDateTime(dtData.Rows[0]["V2DeliveryTimeline1"].ToString());
                        lbldeliverytimelinev2.Text = V2DeliveryTimeline1.ToString("dd/MM/yyyy");
                    }
                    if (dtData.Rows[0]["V3DeliveryTimeline1"].ToString() != "")
                    {
                        DateTime V3DeliveryTimeline1 = Convert.ToDateTime(dtData.Rows[0]["V3DeliveryTimeline1"].ToString());
                        lbldeliverytimelinev3.Text = V3DeliveryTimeline1.ToString("dd/MM/yyyy");
                    }
                    lblcomparisionwithbudgetv1.Text = dtData.Rows[0]["V1BudgetedRate"].ToString();
                    lblcomparisionwithbudgetv2.Text = dtData.Rows[0]["V2BudgetedRate"].ToString();
                    lblcomparisionwithbudgetv3.Text = dtData.Rows[0]["V3BudgetedRate"].ToString();
                    lblbidstatusv1.Text = dtData.Rows[0]["V1BidsStatus"].ToString();
                    lblbidstatusv2.Text = dtData.Rows[0]["V2BidsStatus"].ToString();
                    lblbidstatusv3.Text = dtData.Rows[0]["V3BidsStatus"].ToString();
                    lblvendorratingv1.Text = dtData.Rows[0]["V1VendorRatings"].ToString();
                    lblvendorratingv2.Text = dtData.Rows[0]["V2VendorRatings"].ToString();
                    lblvendorratingv3.Text = dtData.Rows[0]["V3VendorRatings"].ToString();
                    lblawardpreferencev1.Text = dtData.Rows[0]["V1AwardPreference"].ToString();
                    lblawardpreferencev2.Text = dtData.Rows[0]["V2AwardPreference"].ToString();
                    lblawardpreferencev3.Text = dtData.Rows[0]["V3AwardPreference"].ToString();
                    lblcostsqftv1.Text = dtData.Rows[0]["V1CostPerSqFt"].ToString();
                    lblcostsqftv2.Text = dtData.Rows[0]["V2CostPerSqFt"].ToString();
                    lblcostsqftv3.Text = dtData.Rows[0]["V3CostPerSqFt"].ToString();
                    lblrecommadationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();
                    lblvendorinformation.Text = dtData.Rows[0]["VendorInformation"].ToString();
                    lblturnoverlastyear.Text = dtData.Rows[0]["Turnoverlastyear"].ToString();
                    lbltotalorderwithcompany.Text = dtData.Rows[0]["TotalOrderwithco"].ToString();
                    lbllastorderdetail.Text = dtData.Rows[0]["LastorderdetailswithCo"].ToString();
                    txtpurchasehead.Text = Regex.Replace(dtData.Rows[0]["PurchaseHead"].ToString(), "<.*?>", string.Empty);
                    DataSet ds = cls.GetDataSet("EXEC sp_ManagePurchaseLogicNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                    if (ds.Tables[8].Rows.Count > 0)
                    {
                        lblpreparedby.Text = ds.Tables[8].Rows[0]["UserName"].ToString();
                        DateTime createdon = Convert.ToDateTime(ds.Tables[8].Rows[0]["CreatedOn"].ToString());
                        lblcreatedon.Text = createdon.ToString("dd/MM/yyyy h:mm:ss tt");
                        // lblcreatedon.Text = ds.Tables[8].Rows[0]["CreatedOn"].ToString();
                    }
                }
                FillDt(Request.QueryString["ID"].ToString());
                FillDtIH(Request.QueryString["ID"].ToString());
                FillDtDFT(Request.QueryString["ID"].ToString());
                FillDtApprover(Request.QueryString["ID"].ToString());
                FillDtTC(Request.QueryString["ID"].ToString());
                FillDtAttachment(Request.QueryString["ID"].ToString());
                loaddocument(Request.QueryString["ID"].ToString());
            }

        }
    }
    private void FillDt(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManagePurchaseLogicNote 'View','" + ID + "'");
        if (ds.Tables[1].Rows.Count > 0)
        {
            gvStandardexception.DataSource = ds.Tables[1];
            gvStandardexception.DataBind();
        }
    }
    private void FillDtIH(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManagePurchaseLogicNote 'View','" + ID + "'");
        if (ds.Tables[2].Rows.Count > 0)
        {

            gvItemHead.DataSource = ds.Tables[2];
            gvItemHead.DataBind();

            gvItemHead.HeaderRow.Cells[4].Text = lblvendor1.Text == "" ? "Vendor1 Rate" : lblvendor1.Text + " Rate";
            gvItemHead.HeaderRow.Cells[6].Text = lblvendor2.Text == "" ? "Vendor2 Rate" : lblvendor2.Text + " Rate";
            gvItemHead.HeaderRow.Cells[8].Text = lblvendor3.Text == "" ? "Vendor3 Rate" : lblvendor3.Text + " Rate";

            gvItemHead.HeaderRow.Cells[5].Text = lblvendor1.Text == "" ? "Vendor1 Amount" : lblvendor1.Text + " Amount";
            gvItemHead.HeaderRow.Cells[7].Text = lblvendor2.Text == "" ? "Vendor2 Amount" : lblvendor2.Text + " Amount";
            gvItemHead.HeaderRow.Cells[9].Text = lblvendor3.Text == "" ? "Vendor3 Amount" : lblvendor3.Text + " Amount";
            CalIHTotal();
        }
    }
    private void CalIHTotal()
    {

        DataTable dt = new DataTable();
        dt = (DataTable)gvItemHead.DataSource;
        gvItemHead.FooterRow.Font.Bold = true;
        gvItemHead.FooterRow.Cells[2].Text = "Sub Total";
        gvItemHead.FooterRow.Cells[2].HorizontalAlign = HorizontalAlign.Right;
        decimal dblQuantity = 0;
        decimal dblVendor1Rate = 0;
        decimal dblVendor1Value = 0;
        decimal dblVendor2Rate = 0;
        decimal dblVendor2Value = 0;
        decimal dblVendor3Rate = 0;
        decimal dblVendor3Value = 0;
        decimal dblBudgetRate = 0;
        decimal dblTargetCost = 0;
        decimal dblPreviousRate = 0;
        dblQuantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("Quantity"));
        dblVendor1Rate = dt.AsEnumerable().Sum(row => row.Field<decimal>("V1Rate"));
        dblVendor1Value = dt.AsEnumerable().Sum(row => row.Field<decimal>("V1Value"));
        dblVendor2Rate = dt.AsEnumerable().Sum(row => row.Field<decimal>("V2Rate"));
        dblVendor2Value = dt.AsEnumerable().Sum(row => row.Field<decimal>("V2Value"));
        dblVendor3Rate = dt.AsEnumerable().Sum(row => row.Field<decimal>("V3Rate"));
        dblVendor3Value = dt.AsEnumerable().Sum(row => row.Field<decimal>("V3Value"));
        dblBudgetRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("BaseRate"));
        dblTargetCost = dt.AsEnumerable().Sum(row => row.Field<decimal>("TargetCost"));
        dblPreviousRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("PreviousRate"));
        gvItemHead.FooterRow.Cells[3].Text = dblQuantity.ToString();
        gvItemHead.FooterRow.Cells[4].Text = dblVendor1Rate.ToString();
        gvItemHead.FooterRow.Cells[5].Text = dblVendor1Value.ToString();
        gvItemHead.FooterRow.Cells[6].Text = dblVendor2Rate.ToString();
        gvItemHead.FooterRow.Cells[7].Text = dblVendor2Value.ToString();
        gvItemHead.FooterRow.Cells[8].Text = dblVendor3Rate.ToString();
        gvItemHead.FooterRow.Cells[9].Text = dblVendor3Value.ToString();
        gvItemHead.FooterRow.Cells[10].Text = dblBudgetRate.ToString();
        gvItemHead.FooterRow.Cells[11].Text = dblTargetCost.ToString();
        gvItemHead.FooterRow.Cells[12].Text = dblPreviousRate.ToString();


        //CalCostPersqft();
    }
    private void FillDtDFT(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseLogicNote 'View','" + ID + "'");
        if (dtData.Tables[3].Rows.Count > 0)
        {

            gvDeviationfromtender.DataSource = dtData.Tables[3];
            gvDeviationfromtender.DataBind();
        }
    }
    private void FillDtApprover(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseLogicNote 'View','" + ID + "'");
        if (dtData.Tables[5].Rows.Count > 0)
        {

            gvApprover.DataSource = dtData.Tables[5];
            gvApprover.DataBind();
        }
    }
    private void FillDtTC(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,Terms,StandardTerms,Preference1,Preference2 from tbl_PLNTermsandCondition where IsDelete=0 and PLNID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsTC"] = dtData;
        }
        else
        {
            dtData = new DataTable();
            dtData = cls.selectDataTable("select 0 as ID,Terms,StandardTerms,Preference1,Preference2 from tbl_PLNTandC where IsActive=1 order by ID");


        }
        gvTermsandCondition.DataSource = dtData;
        gvTermsandCondition.DataBind();
    }
    private void FillDtAttachment(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseLogicNote 'View','" + ID + "'");
        if (dtData.Tables[4].Rows.Count > 0)
        {
            gvAttachment.DataSource = dtData.Tables[4];
            gvAttachment.DataBind();
        }
    }
    public void loaddocument(string ID)
    {

        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseLogicNote 'View','" + ID + "'");
        if (dtData.Tables[4].Rows.Count > 0)
        {
            for (int i = 0; i < dtData.Tables[4].Rows.Count; i++)
            {
                if (dtData.Tables[4].Rows[i]["Category"].ToString() == "Bid Evaluation")
                {
                    if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprbidevaluation.Visible = true;
                        hprbidevaluation.NavigateUrl = "../Upload/PLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprbidevaluation.Visible = false;
                    }
                }
                //else
                //{
                //    trbidevaluation.Visible = false;
                //}
                if (dtData.Tables[4].Rows[i]["Category"].ToString() == "Delivery Schedule")
                {
                    if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprdeliveryschedule.Visible = true;
                        hprdeliveryschedule.NavigateUrl = "../Upload/PLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprdeliveryschedule.Visible = false;
                    }
                }
                //else
                //{
                //    tddeliveryschedule.Visible = false;
                //}
                if (dtData.Tables[4].Rows[i]["Category"].ToString() == "Budget Approval")
                {
                    if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprbudgetapproval.Visible = true;
                        hprbudgetapproval.NavigateUrl = "../Upload/PLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprbudgetapproval.Visible = false;
                    }
                }
                //else
                //{
                //    tdbudgetapproval.Visible = false;
                //}
                if (dtData.Tables[4].Rows[i]["Category"].ToString() == "Prior Approvals")
                {

                    if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprprior.Visible = true;
                        hprprior.NavigateUrl = "../Upload/PLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprprior.Visible = false;
                        //tdpriorapproval.Attributes.Add("style", "Display:none");
                    }
                }
                //else
                //{
                //    tdpriorapproval.Visible = false;
                //    //tdpriorapproval.Attributes.Add("style", "Display:none");
                //}
                if (dtData.Tables[4].Rows[i]["Category"].ToString() == "Drawings")
                {
                    if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprdrawingdocument.Visible = true;
                        hprdrawingdocument.NavigateUrl = "../Upload/PLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprdrawingdocument.Visible = false;
                    }
                }
                //else
                //{
                //    trdrawing.Visible = false;
                //}
                if (dtData.Tables[4].Rows[i]["Category"].ToString() == "Indent")
                {
                    if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprindent.Visible = true;
                        hprindent.NavigateUrl = "../Upload/PLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprindent.Visible = false;
                    }
                }
                //else
                //{
                //    tdindent.Visible = false;
                //}
                if (dtData.Tables[4].Rows[i]["Category"].ToString() == "Login Note")
                {
                    if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprlogicnote.Visible = true;
                        hprlogicnote.NavigateUrl = "../Upload/PLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprlogicnote.Visible = false;
                    }
                }
                //else
                //{                        
                //        tdlogicnote.Visible = false;                        
                //}
            }
        }
    }
    protected void btnapprove_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'PLNApproverApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Purchase Logic Note Successfully Approved !!');location.replace('ListApprovePurchaseLogicNote.aspx');", true);

        }
    }

    protected void btnreject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'PLNApproverReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Purchase Logic Note Successfully Rejected !!');location.replace('ListApprovePurchaseLogicNote.aspx');", true);

        }
    }

    protected void btnprint_Click(object sender, EventArgs e)
    {
        try
        {
            Export.ExportReport(Request.QueryString["ID"].ToString(), "Purchase Logic Note");
            //string ReportType = "P";
            //Warning[] warnings;
            //string[] streamIds;
            //string mimeType = string.Empty;
            //string encoding = string.Empty;
            //string extension = string.Empty;
            //ReportViewer _reportViewer = new ReportViewer();
            //_reportViewer.ProcessingMode = ProcessingMode.Remote;
            //_reportViewer.ServerReport.ReportServerUrl = new Uri("http://192.168.100.20/Reportserver");

            //_reportViewer.ServerReport.ReportPath = "/Reports/Purchase Logic Note";

            //ReportParameter[] param = new ReportParameter[1];
            //param[0] = new ReportParameter("ID", Request.QueryString["ID"].ToString());
            ////param[0] = new ReportParameter("EmpID", EmpID);
            ////param[1] = new ReportParameter("RefNo", RefNo.ToString());

            //IReportServerCredentials irsc = new CustomReportCredentials("Administrator", "approval@321$#$");
            //_reportViewer.ServerReport.ReportServerCredentials = irsc;
            //_reportViewer.ServerReport.SetParameters(param);
            //System.Drawing.Printing.PageSettings ps = new System.Drawing.Printing.PageSettings();
            //ps.Landscape = true;
            ////ps.PaperSize = new  System.Drawing.Printing.PaperSize("A3", 1169, 827);

            //byte[] bytes;
            //if (ReportType == "P")
            //{
            //    bytes = _reportViewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
            //}
            //else
            //{
            //    bytes = _reportViewer.ServerReport.Render("Excel", null, out mimeType, out encoding, out extension,
            //        out streamIds, out warnings);
            //}

            //Response.Buffer = true;
            //Response.Clear();
            //Response.ContentType = mimeType;
            //Response.AddHeader("content-disposition", "inline;    filename = " + "PurchaseLogicNoteReport" + "." + extension);

            //Response.BinaryWrite(bytes); // create the file
            //Response.Flush(); // send it to the client to download

        }
        catch (Exception ex)
        {

        }
    }

    #region Attachment
    protected void gvAttachment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Download")
        {
            string[] commandArguments = e.CommandArgument.ToString().Split(',');
            DownloadDocImage(commandArguments[0], commandArguments[1], commandArguments[2], "PDF");
        }
        else if (e.CommandName == "DownloadImage")
        {
            string[] commandArguments = e.CommandArgument.ToString().Split(',');
            DownloadDocImage(commandArguments[0], commandArguments[1], commandArguments[2], "Image");
        }
    }
    public void DownloadDocImage(string ID, string PLNID, string DocFile, string Type)
    {

        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/PLN/") + DocFile))
        {

            DataTable dtPLNOrderNo = new DataTable();
            dtPLNOrderNo = cls.selectDataTable(" select b.PLNOrderNo from tbl_PLNApprover a inner join tbl_PurchaseLogicNote b on a.PLNID=b.ID Where a.IsApprove=1 And  a.PLNID='" + PLNID + "' and a.IsDelete=0");
            if (dtPLNOrderNo.Rows.Count > 0)
            {
                if (dtPLNOrderNo.Rows.Count > 0)
                {
                    string filePath = Server.MapPath("../Upload/PLN/") + ID + PLNID + Type + DocFile;
                    try
                    {
                        if (Type == "PDF")
                        {
                            PdfReader reader = new PdfReader(Server.MapPath("../Upload/PLN/") + DocFile);
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
                                ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtPLNOrderNo.Rows[0]["PLNOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15, iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
                                over.RestoreState();
                            }
                            stamper.Close();
                            reader.Close();
                        }
                        else if (Type == "Image")
                        {
                            PointF firstLocation = new PointF(10f, 10f);
                            string imageFilePath = Server.MapPath("../Upload/PLN/") + DocFile;
                            Bitmap newBitmap;
                            using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFilePath))//load the image file
                            {
                                using (Graphics graphics = Graphics.FromImage(bitmap))
                                {
                                    using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12, FontStyle.Bold))
                                    {
                                        System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);
                                        graphics.DrawString(dtPLNOrderNo.Rows[0]["PLNOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);

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
                    var filePath = Server.MapPath("../Upload/PLN/") + DocFile + "";
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                    Response.TransmitFile(filePath);
                    Response.End();
                }
            }
            else
            {
                var filePath = Server.MapPath("../Upload/PLN/") + DocFile + "";
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                Response.TransmitFile(filePath);
                Response.End();

            }
        }


    }

    #endregion Attachment
}