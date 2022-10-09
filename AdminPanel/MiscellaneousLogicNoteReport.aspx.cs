using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_MiscellaneousLogicNoteReport : System.Web.UI.Page
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
        dtUser = (DataTable)Session["UserSession"];
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null)
            {
                if (Request.QueryString["Con"] != null)
                {
                    btnapprove.Visible = false;
                    btnreject.Visible = false;
                }
                dtData = cls.selectDataTable("EXEC sp_ManageMiscellaneousLogicNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    if (dtData.Rows[0]["IsApproved"].ToString().ToUpper() == "TRUE")
                    {
                        btnapprove.Enabled = false;
                        btnreject.Enabled = false;
                    }

                    lblcompanyname.Text = dtData.Rows[0]["CompanyName"].ToString();

                    if (dtData.Rows[0]["MSLNOrderNo"].ToString() == "")
                    {

                        storderno.Visible = false;
                    }
                    else
                    {

                        storderno.Visible = true;
                        lblorderno.Text = dtData.Rows[0]["MSLNOrderNo"].ToString();
                    }
                    if (dtData.Rows[0]["Type"].ToString() == "2")
                    {
                        storderno.Visible = true;
                        lblorderno.Text = dtData.Rows[0]["ApprovalNo"].ToString();
                        lblApprovalNo.Text = dtData.Rows[0]["MSLNOrderNo"].ToString();
                        spaNo.Visible = true;
                        lblApprovalNo.Visible = true;
                    }
                    else
                    {
                        lblorderno.Text = dtData.Rows[0]["MSLNOrderNo"].ToString();
                    }
                    lblType.Text = Convert.ToInt16(dtData.Rows[0]["Type"].ToString()) == 1 ? "New" : "Amendment";
                    lblapprovalauthority.Text = dtData.Rows[0]["CommitteeName"].ToString();
                    lblsubjectscope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
                    lblprojectnaddress.Text = dtData.Rows[0]["ProjectName"].ToString() + " " + dtData.Rows[0]["ProjectAddress"].ToString();//--
                    lblDepartment.Text = dtData.Rows[0]["DepartmentName"].ToString();
                    lblReasonOfAmendment.Text = dtData.Rows[0]["ReasonOfAmendment"].ToString();
                    // lblApprovalTYpe.Text = dtData.Rows[0]["TypeName"].ToString();
                    lblApprovalPriority.Text = dtData.Rows[0]["ApprovalPriority"].ToString();
                    //lblApprovalNo.Text= dtData.Rows[0]["ApprovalNo"].ToString();
                    lblUrgentRemarks.Text = dtData.Rows[0]["UrjentRemark"].ToString();
                    // lblStatus.Text = dtData.Rows[0]["Status"].ToString();
                    lblpalnawardDate.Text = Convert.ToDateTime(dtData.Rows[0]["PlanAwardDate"].ToString()).ToString("dd/MM/yyyy");
                    lbldateofReward.Text = Convert.ToDateTime(dtData.Rows[0]["ActualDateOfAward"].ToString()).ToString("dd/MM/yyyy");
                    lblotherDescription.Text = dtData.Rows[0]["OtherDescription"].ToString();
                    lblapprovalsought.Text = dtData.Rows[0]["ApprovalSought"].ToString();
                    DateTime actualdateofaward = Convert.ToDateTime(dtData.Rows[0]["ActualDateofaward"].ToString());

                    lblapprovebudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
                    lblalreadyawarded.Text = dtData.Rows[0]["AlreadyAwarded"].ToString();
                    lblproposedvalueofthisaward.Text = dtData.Rows[0]["Proposedaward"].ToString();
                    lblbalancetobeawarded.Text = dtData.Rows[0]["BalanceAward"].ToString();
                    lblvariationfrombudget.Text = dtData.Rows[0]["Variationfombudget"].ToString();
                    lblreasonofvariation.Text = dtData.Rows[0]["Reasonofvariation"].ToString();

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

                    lbltotalvendorconsider.Text = dtData.Rows[0]["Vendorconsidered"].ToString();
                    lblrejectedvendorasperpqual.Text = dtData.Rows[0]["RejectedVendors"].ToString();
                    lblrfqinvited.Text = dtData.Rows[0]["RFQinvited"].ToString();
                    lblnotquoted.Text = dtData.Rows[0]["Notquoted"].ToString();
                    lblfinalconsidered.Text = dtData.Rows[0]["FinalConsidered"].ToString();
                    DateTime StipulatedCompletionTime1 = Convert.ToDateTime(dtData.Rows[0]["StipulatedCompletionTime1"].ToString());
                    lblstipulatedtimeline.Text = StipulatedCompletionTime1.ToString("dd/MM/yyyy");
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
                    lblcontracttype.Text = dtData.Rows[0]["ContractorName"].ToString();
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
                    // lblreason.Text = dtData.Rows[0]["Singleorderreason"].ToString();
                    //lbl.SelectedValue = dtData.Rows[0]["Vendor1"].ToString();
                    //ddlVendor2.SelectedValue = dtData.Rows[0]["Vendor2"].ToString();
                    //ddlVendor3.SelectedValue = dtData.Rows[0]["Vendor3"].ToString();
                    lblvendor1.Text = dtData.Rows[0]["VendorName1"].ToString();
                    lblvendor2.Text = dtData.Rows[0]["VendorName2"].ToString();
                    lblvendor3.Text = dtData.Rows[0]["VendorName3"].ToString();
                    if (dtData.Rows[0]["V1DeliveryTimeline1"].ToString() != "")
                    {
                        //   DateTime V1DeliveryTimeline1 = Convert.ToDateTime(dtData.Rows[0]["V1DeliveryTimeline1"].ToString());
                        // lbldeliverytimelinev1.Text = V1DeliveryTimeline1.ToString("dd/MM/yyyy");
                    }
                    if (dtData.Rows[0]["V2DeliveryTimeline1"].ToString() != "")
                    {
                        // DateTime V2DeliveryTimeline1 = Convert.ToDateTime(dtData.Rows[0]["V2DeliveryTimeline1"].ToString());
                        // lbldeliverytimelinev2.Text = V2DeliveryTimeline1.ToString("dd/MM/yyyy");
                    }
                    if (dtData.Rows[0]["V3DeliveryTimeline1"].ToString() != "")
                    {
                        // DateTime V3DeliveryTimeline1 = Convert.ToDateTime(dtData.Rows[0]["V3DeliveryTimeline1"].ToString());
                        //lbldeliverytimelinev3.Text = V3DeliveryTimeline1.ToString("dd/MM/yyyy");
                    }
                    lbldeliverytimelinev1.Text = dtData.Rows[0]["V1DeliveryTimeline1"].ToString();
                    lbldeliverytimelinev2.Text = dtData.Rows[0]["V2DeliveryTimeline1"].ToString();
                    lbldeliverytimelinev3.Text = dtData.Rows[0]["V3DeliveryTimeline1"].ToString();
                    // lblcomparisionwithbudgetv1.Text = dtData.Rows[0]["V1BudgetedRate"].ToString();
                    //lblcomparisionwithbudgetv2.Text = dtData.Rows[0]["V2BudgetedRate"].ToString();
                    // lblcomparisionwithbudgetv3.Text = dtData.Rows[0]["V3BudgetedRate"].ToString();
                    lblbidstatusv1.Text = dtData.Rows[0]["V1BidsStatus"].ToString();
                    lblbidstatusv2.Text = dtData.Rows[0]["V2BidsStatus"].ToString();
                    lblbidstatusv3.Text = dtData.Rows[0]["V3BidsStatus"].ToString();
                    lblvendorratingv1.Text = dtData.Rows[0]["V1VendorRatings"].ToString();
                    lblvendorratingv2.Text = dtData.Rows[0]["V2VendorRatings"].ToString();
                    lblvendorratingv3.Text = dtData.Rows[0]["V3VendorRatings"].ToString();
                    lblawardpreferencev1.Text = dtData.Rows[0]["V1AwardPreference"].ToString();
                    lblawardpreferencev2.Text = dtData.Rows[0]["V2AwardPreference"].ToString();
                    lblawardpreferencev3.Text = dtData.Rows[0]["V3AwardPreference"].ToString();
                    //grand.Text = dtData.Rows[0]["V1GrandTotal"].ToString();
                    //txtV2GrandTotal.Text = dtData.Rows[0]["V2GrandTotal"].ToString();
                    //txtV3GrandTotal.Text = dtData.Rows[0]["V3GrandTotal"].ToString();
                    // lblcostsqftv1.Text = dtData.Rows[0]["V1CostPerSqFt"].ToString();
                    // lblcostsqftv2.Text = dtData.Rows[0]["V2CostPerSqFt"].ToString();
                    // lblcostsqftv3.Text = dtData.Rows[0]["V3CostPerSqFt"].ToString();
                    lblrecommadationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();
                    //lblvendorinformation.Text = dtData.Rows[0]["VendorInformation"].ToString();
                    lblturnoverlastyear.Text = dtData.Rows[0]["Turnoverlastyear"].ToString();
                    lbltotalorderwithcompany.Text = dtData.Rows[0]["TotalOrderwithco"].ToString();
                    lbllastorderdetail.Text = dtData.Rows[0]["LastorderdetailswithCo"].ToString();
                    txtMiscellaneousHead.Text = Regex.Replace(dtData.Rows[0]["MiscellaneousHead"].ToString(), "<.*?>", string.Empty);

                    lblV1GST.Text = dtData.Rows[0]["V1GST"].ToString();
                    lblV2GST.Text = dtData.Rows[0]["V2GST"].ToString();
                    lblV3GST.Text = dtData.Rows[0]["V3GST"].ToString();



                    lblV1OtherCharges.Text = dtData.Rows[0]["V1OtherCharges"].ToString();
                    lblV2OtherCharges.Text = dtData.Rows[0]["V2OtherCharges"].ToString();
                    lblV3OtherCharges.Text = dtData.Rows[0]["V3OtherCharges"].ToString();

                    lblV1GrandTotal.Text = dtData.Rows[0]["V1GrandTotal"].ToString();
                    lblV2GrandTotal.Text = dtData.Rows[0]["V2GrandTotal"].ToString();
                    lblV3GrandTotal.Text = dtData.Rows[0]["V3GrandTotal"].ToString();

                    int status = cls.ExecuteIntScalar("select count(1) from tbl_MiscellaneousLogicNote where ID=" + Convert.ToInt32(Request.QueryString["ID"]) + " and IsSubmitted=1");
                    if (status == 0)
                    {
                        lblStatus.Text = "Draft";
                    }
                    else
                    {
                        status = cls.ExecuteIntScalar("select count(1) from tbl_MiscellaneousLogicNote where ID=" + Convert.ToInt32(Request.QueryString["ID"]) + " and IsCommitteeApproved=1");
                        if (status == 0)
                        {
                            lblStatus.Text = "Pending";
                        }
                        else
                        {
                            lblStatus.Text = "Approved";
                        }
                    }
                    if (Request.QueryString["type"] != null)
                    {
                        tblApprover.Visible = false;
                        tblCommitteeApprover.Visible = true;
                        if (dtData.Rows[0]["IsCommitteeApproved"].ToString().ToUpper() == "TRUE")
                        {
                            btnCApprove.Enabled = false;
                            btnCReject.Enabled = false;
                        }
                    }
                    else
                    {
                        if (dtData.Rows[0]["IsApproved"].ToString().ToUpper() == "TRUE")
                        {
                            btnapprove.Enabled = false;
                            btnreject.Enabled = false;
                        }
                        else
                        {
                            int count = cls.ExecuteIntScalar("select count(1) from tbl_MSLNApprover where ApproverID=" + Convert.ToInt32(dtUser.Rows[0]["ID"]) + " and MSLNID=" + Convert.ToString(Request.QueryString["ID"]) + " and IsApprove=0");
                            if (count == 1)
                            {
                                btnapprove.Enabled = true;
                                btnreject.Enabled = true;
                            }
                            else
                            {
                                btnapprove.Enabled = false;
                                btnreject.Enabled = false;
                            }

                        }
                    }
                    if (Convert.ToBoolean(dtData.Rows[0]["IsTop3Bid"].ToString()) == false)
                    {
                        tblBidEvaluation.Visible = false;
                    }
                    if (Convert.ToBoolean(dtData.Rows[0]["IsDeviation"].ToString()) == false)
                    {
                        tblDeviation.Visible = false;
                    }
                }
                FillDt(Request.QueryString["ID"].ToString());
                FillDtIH(Request.QueryString["ID"].ToString());
                FillDtDFT(Request.QueryString["ID"].ToString());
                FillDtApprover(Request.QueryString["ID"].ToString());
                FillDtTC(Request.QueryString["ID"].ToString());
                FillDtAttachment(Request.QueryString["ID"].ToString());
                FillDtCreator(Request.QueryString["ID"].ToString());
                FillDtdocument(Request.QueryString["ID"].ToString());
            }

        }
    }
    private void FillDt(string ID)
    {

        DataSet ds = cls.GetDataSet("EXEC sp_ManageMiscellaneousLogicNote 'View','" + ID + "'");
        if (ds.Tables[1].Rows.Count > 0)
        {

            gvStandardexception.DataSource = ds.Tables[1];
            gvStandardexception.DataBind();
        }
    }
    private void FillDtIH(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageMiscellaneousLogicNote 'View','" + ID + "'");
        if (ds.Tables[10].Rows.Count > 0)
        {

            gvItemHead.DataSource = ds.Tables[10];
            gvItemHead.DataBind();
            gvItemHead.HeaderRow.Cells[4].Text = lblvendor1.Text == "" ? "Vendor1" : lblvendor1.Text;
            gvItemHead.HeaderRow.Cells[6].Text = lblvendor2.Text == "" ? "Vendor2" : lblvendor2.Text;
            gvItemHead.HeaderRow.Cells[8].Text = lblvendor3.Text == "" ? "Vendor3" : lblvendor3.Text;
            CalIHTotal();
        }
    }
    private void CalIHTotal()
    {
        DataTable dt = new DataTable();
        dt = (DataTable)gvItemHead.DataSource;
        gvItemHead.FooterRow.Font.Bold = true;
        gvItemHead.FooterRow.Cells[2].Text = "Total";
        gvItemHead.FooterRow.Cells[2].HorizontalAlign = HorizontalAlign.Right;
        decimal dblQuantity = 0;
        decimal dblVendorValue1 = 0;
        decimal dblVendorValue2 = 0;
        decimal dblVendorValue3 = 0;
        decimal dblBaseRate = 0;
        decimal dblTargetCost = 0;
        decimal dblEstimatedCost = 0;
        dblQuantity = dt.AsEnumerable().Sum(row => row.Field<decimal>("Quantity"));
        dblVendorValue1 = dt.AsEnumerable().Sum(row => row.Field<decimal>("V1Value"));
        dblVendorValue2 = dt.AsEnumerable().Sum(row => row.Field<decimal>("V2Value"));
        dblVendorValue3 = dt.AsEnumerable().Sum(row => row.Field<decimal>("V3Value"));
        dblBaseRate = dt.AsEnumerable().Sum(row => row.Field<decimal>("BaseRate"));
        dblTargetCost = dt.AsEnumerable().Sum(row => row.Field<decimal>("TargetCost"));
        dblEstimatedCost = dt.AsEnumerable().Sum(row => row.Field<decimal>("EstimatedCost"));


        gvItemHead.FooterRow.Cells[3].Text = dblQuantity.ToString();
        gvItemHead.FooterRow.Cells[5].Text = dblVendorValue1.ToString();
        gvItemHead.FooterRow.Cells[7].Text = dblVendorValue2.ToString();
        gvItemHead.FooterRow.Cells[9].Text = dblVendorValue3.ToString();
        gvItemHead.FooterRow.Cells[10].Text = dblBaseRate.ToString();
        gvItemHead.FooterRow.Cells[11].Text = dblTargetCost.ToString();
        gvItemHead.FooterRow.Cells[12].Text = dblEstimatedCost.ToString();

    }
    private void FillDtDFT(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageMiscellaneousLogicNote 'View','" + ID + "'");
        if (ds.Tables[3].Rows.Count > 0)
        {

            gvDeviationfromtender.DataSource = ds.Tables[3];
            gvDeviationfromtender.DataBind();
        }
    }
    private void FillDtApprover(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageMiscellaneousLogicNote 'View','" + ID + "'");
        if (ds.Tables[5].Rows.Count > 0)
        {
            gvApprover.DataSource = ds.Tables[5];
            gvApprover.DataBind();
        }
    }
    private void FillDtTC(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,Terms,StandardTerms,Preference1,Preference2 from tbl_MSLNTermsandCondition where IsDelete=0 and MSLNID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsTC"] = dtData;
        }
        else
        {
            dtData = new DataTable();
            dtData = cls.selectDataTable("select 0 as ID,Terms,StandardTerms,Preference1,Preference2 from tbl_MSLNTermsandCondition where IsActive=1 order by ID");
            ViewState["dtDetailsTC"] = dtData;
        }

        dt = (DataTable)ViewState["dtDetailsTC"];

        gvTermsandCondition.DataSource = dt;
        gvTermsandCondition.DataBind();

    }
    private void FillDtAttachment(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageMiscellaneousLogicNote 'View','" + ID + "'");
        if (ds.Tables[4].Rows.Count > 0)
        {
            gvAttachment.DataSource = ds.Tables[4];
            gvAttachment.DataBind();
        }
    }
    private void FillDtdocument(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManageMiscellaneousLogicNote 'View','" + ID + "'");
        if (dtData.Tables[4].Rows.Count > 0)
        {
            for (int i = 0; i < dtData.Tables[4].Rows.Count; i++)
            {

                if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                {
                    lnkdownloadbidevaluation.Visible = true;
                    lnkdownloadbidevaluation.NavigateUrl = "../Upload/MSLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnkdownloadbidevaluation.Visible = false;
                //}


                if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                {
                    lnkdeliveryschedule.Visible = true;
                    lnkdeliveryschedule.NavigateUrl = "../Upload/MSLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnkdeliveryschedule.Visible = false;
                //}



                if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                {
                    lnkbudgetapproval.Visible = true;
                    lnkbudgetapproval.NavigateUrl = "../Upload/MSLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnkbudgetapproval.Visible = false;
                //}



                if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                {
                    lnkPriorApprovalsDownload.Visible = true;
                    lnkPriorApprovalsDownload.NavigateUrl = "../Upload/MSLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnkPriorApprovalsDownload.Visible = false;
                //}



                if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                {
                    lnkdrawingdocument.Visible = true;
                    lnkdrawingdocument.NavigateUrl = "../Upload/MSLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnkdrawingdocument.Visible = false;
                //}



                if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                {
                    lnkIndentdownload.Visible = true;
                    lnkIndentdownload.NavigateUrl = "../Upload/MSLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnkIndentdownload.Visible = false;
                //}



                if (dtData.Tables[4].Rows[i]["DocFile"].ToString() != "")
                {
                    lnklogicnoteDownload.Visible = true;
                    lnklogicnoteDownload.NavigateUrl = "../Upload/MSLN/" + dtData.Tables[4].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnklogicnoteDownload.Visible = false;
                //}


            }
        }
    }
    private void FillDtCreator(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageMiscellaneousLogicNote 'View','" + ID + "'");
        if (ds.Tables[8].Rows.Count > 0)
        {
            lblpreparedby.Text = ds.Tables[8].Rows[0]["UserName"].ToString();
            if (ds.Tables[8].Rows[0]["CreatedOn"].ToString() != "")
            {
                DateTime CreatedOn = Convert.ToDateTime(ds.Tables[8].Rows[0]["CreatedOn"].ToString());
                lblcreatedon.Text = CreatedOn.ToString("dd/MM/yyyy h:mm:ss tt");
            }
        }
    }

    protected void btnapprove_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'MSLNApproverApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Miscellaneous Logic Note Successfully Approved !!');location.replace('ListApproveMiscellaneousLogicNote.aspx');", true);

        }
    }

    protected void btnreject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'MSLNApproverReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Miscellaneous Logic Note Successfully Rejected !!');location.replace('ListApproveMiscellaneousLogicNote.aspx');", true);

        }
    }

    protected void btnprint_Click(object sender, EventArgs e)
    {
        try
        {

            Export.ExportReport(Request.QueryString["ID"].ToString(), "Miscellaneous Logic Note");

            //string ReportType = "P";//
            //                        //Convert.ToString(TempData["ReportType"]);

            //Warning[] warnings;
            //string[] streamIds;
            //string mimeType = string.Empty;
            //string encoding = string.Empty;
            //string extension = string.Empty;

            //ReportViewer _reportViewer = new ReportViewer();
            //_reportViewer.ProcessingMode = ProcessingMode.Remote;

            //_reportViewer.ServerReport.ReportServerUrl = new Uri("http://192.168.100.20/Reportserver");

            //_reportViewer.ServerReport.ReportPath = "/Reports/MiscellaneousLogicNote";

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
            //Response.AddHeader("content-disposition", "inline;    filename = " + "MiscellaneousLogicNote" + "." + extension);

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
    public void DownloadDocImage(string ID, string MSLNID, string DocFile, string Type)
    {
        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/MSLN/") + DocFile))
        {
            DataTable dtMLNOrderNo = new DataTable();
            dtMLNOrderNo = cls.selectDataTable(" select b.MSLNOrderNo from tbl_MSLNApprover a inner join tbl_MiscellaneousLogicNote b on a.MSLNID=b.ID Where a.IsApprove=1 And  a.MSLNID='" + MSLNID + "' and a.IsDelete=0");
            if (dtMLNOrderNo.Rows.Count > 0)
            {
                string filePath = Server.MapPath("../Upload/MSLN/") + ID + MSLNID + Type + DocFile;
                try
                {
                    if (Type == "PDF")
                    {
                        PdfReader reader = new PdfReader(Server.MapPath("../Upload/MSLN/") + DocFile);
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
                            ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtMLNOrderNo.Rows[0]["MSLNOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15, iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
                            over.RestoreState();
                        }
                        stamper.Close();
                        reader.Close();
                    }
                    else if (Type == "Image")
                    {
                        PointF firstLocation = new PointF(10f, 10f);
                        string imageFilePath = Server.MapPath("../Upload/MSLN/") + DocFile;
                        Bitmap newBitmap;
                        using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFilePath))//load the image file
                        {
                            using (Graphics graphics = Graphics.FromImage(bitmap))
                            {
                                using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12, FontStyle.Bold))
                                {
                                    System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);
                                    graphics.DrawString(dtMLNOrderNo.Rows[0]["MSLNOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);

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
                var filePath = Server.MapPath("../Upload/MSLN/") + DocFile + "";
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                Response.TransmitFile(filePath);
                Response.End();
            }
        }
    }
    #endregion Attachment

    protected void btnCApprove_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'MSLNCommitteeApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('MiscellaneousLogic Logic Note Successfully Approved !!');location.replace('ListApproveCommitteeMiscellaneousLogicNote.aspx');", true);

        }
    }

    protected void btnCReject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'MSLNCommitteeReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('MiscellaneousLogic Logic Note Successfully Rejected !!');location.replace('ListApproveCommitteeMiscellaneousLogicNote.aspx');", true);

        }
    }
}