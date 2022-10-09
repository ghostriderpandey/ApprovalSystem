using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text.pdf;
using System.IO;
using iTextSharp.text;
using System.Drawing;
//using ApprovalSystem.AdminPanel;

public partial class AdminPanel_ContractLogicNoteReportCommittee : System.Web.UI.Page
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
                dtData = cls.selectDataTable("EXEC sp_ManageContractLogicNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    if (dtData.Rows[0]["IsCommitteeApproved"].ToString().ToUpper() == "TRUE")
                    {
                        btnapprove.Enabled = false;
                        btnreject.Enabled = false;
                    }
                    lblcompanyname.Text = dtData.Rows[0]["CompanyName"].ToString();
                    if (dtData.Rows[0]["CLNOrderNo"].ToString() == "")
                    {
                        storderno.Visible = false;
                    }
                    else
                    {
                        storderno.Visible = true;
                        lblorderno.Text = dtData.Rows[0]["CLNOrderNo"].ToString();
                    }

                    lblapprovalauthority.Text = dtData.Rows[0]["CommitteeName"].ToString();
                    lblsubjectscope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
                    lblprojectnaddress.Text = dtData.Rows[0]["ProjectName"].ToString() + " " + dtData.Rows[0]["ProjectAddress"].ToString();//--

                    //ddlDepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
                    DateTime plannedawarddate = Convert.ToDateTime(dtData.Rows[0]["PlannedAwardDate1"].ToString());
                    lblplannedawardasperschedule.Text = plannedawarddate.ToString("dd/MM/yyyy");
                    DateTime actualdateofaward = Convert.ToDateTime(dtData.Rows[0]["ActualDateofaward1"].ToString());
                    lblactualdateofaward.Text = actualdateofaward.ToString("dd/MM/yyyy");
                    lbldelayinaward.Text = dtData.Rows[0]["Delayinaward"].ToString();
                    lblreasonofdelay.Text = dtData.Rows[0]["ReasonofDelay"].ToString();
                    lblsaleablearea.Text = dtData.Rows[0]["SaleableArea"].ToString();
                    lblapprovebudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
                    lblalreadyawarded.Text = dtData.Rows[0]["AlreadyAwarded"].ToString();
                    lblproposedvalueofthisaward.Text = dtData.Rows[0]["Proposedaward"].ToString();
                    lblbalancetobeawarded.Text = dtData.Rows[0]["BalanceAward"].ToString();
                    lblvariationfrombudget.Text = dtData.Rows[0]["Variationfombudget"].ToString();
                    lblreasonofvariation.Text = dtData.Rows[0]["Reasonofvariation"].ToString();
                    if (dtData.Rows[0]["Reasonofvariation"].ToString() != "Other")
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
                    DateTime proposedtimeline = Convert.ToDateTime(dtData.Rows[0]["Proposedtimeline1"].ToString());
                    lblstipulatedtimelinebyvendor.Text = proposedtimeline.ToString("dd/MM/yyyy");
                    lbltotalvendorconsider.Text = dtData.Rows[0]["Vendorconsidered"].ToString();
                    lblrejectedvendorasperpqual.Text = dtData.Rows[0]["RejectedVendors"].ToString();
                    lblrfqinvited.Text = dtData.Rows[0]["RFQinvited"].ToString();
                    lblnotquoted.Text = dtData.Rows[0]["Notquoted"].ToString();
                    lblfinalconsidered.Text = dtData.Rows[0]["FinalConsidered"].ToString();
                    lblstipulatedtimeline.Text = dtData.Rows[0]["StipulatedCompletionTime1"].ToString();
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
                    lblcontracttype.Text = dtData.Rows[0]["Contracttype"].ToString();
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
                    //lbl.SelectedValue = dtData.Rows[0]["Vendor1"].ToString();
                    //ddlVendor2.SelectedValue = dtData.Rows[0]["Vendor2"].ToString();
                    //ddlVendor3.SelectedValue = dtData.Rows[0]["Vendor3"].ToString();
                    lblvendor1.Text = dtData.Rows[0]["VendorName1"].ToString();
                    lblvendor2.Text = dtData.Rows[0]["VendorName2"].ToString();
                    lblvendor3.Text = dtData.Rows[0]["VendorName3"].ToString();
                    //lbldeliverytimelinev1.Text = dtData.Rows[0]["V1DeliveryTimeline1"].ToString();
                    //lbldeliverytimelinev2.Text = dtData.Rows[0]["V2DeliveryTimeline1"].ToString();
                    //lbldeliverytimelinev3.Text = dtData.Rows[0]["V3DeliveryTimeline1"].ToString();
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
                    //grand.Text = dtData.Rows[0]["V1GrandTotal"].ToString();
                    //txtV2GrandTotal.Text = dtData.Rows[0]["V2GrandTotal"].ToString();
                    //txtV3GrandTotal.Text = dtData.Rows[0]["V3GrandTotal"].ToString();
                    lblcostsqftv1.Text = dtData.Rows[0]["V1CostPerSqFt"].ToString();
                    lblcostsqftv2.Text = dtData.Rows[0]["V2CostPerSqFt"].ToString();
                    lblcostsqftv3.Text = dtData.Rows[0]["V3CostPerSqFt"].ToString();
                    lblrecommadationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();
                    lblvendorinformation.Text = dtData.Rows[0]["VendorInformation"].ToString();
                    lblturnoverlastyear.Text = dtData.Rows[0]["Turnoverlastyear"].ToString();
                    lbltotalorderwithcompany.Text = dtData.Rows[0]["TotalOrderwithco"].ToString();
                    lbllastorderdetail.Text = dtData.Rows[0]["LastorderdetailswithCo"].ToString();
                    txtcontracthead.Text = Regex.Replace(dtData.Rows[0]["ContractHead"].ToString(), "<.*?>", string.Empty);
                    txtcreatorremark.Text = Regex.Replace(dtData.Rows[0]["Remark"].ToString(), "<.*?>", string.Empty);

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

        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractLogicNote 'View','" + ID + "'");
        if (ds.Tables[1].Rows.Count > 0)
        {

            gvStandardexception.DataSource = ds.Tables[1];
            gvStandardexception.DataBind();
        }
    }
    private void FillDtIH(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractLogicNote 'View','" + ID + "'");
        if (ds.Tables[2].Rows.Count > 0)
        {

            gvItemHead.DataSource = ds.Tables[2];
            gvItemHead.DataBind();

            gvItemHead.HeaderRow.Cells[2].Text = lblvendor1.Text == "" ? "Contractor1" : lblvendor1.Text;
            gvItemHead.HeaderRow.Cells[3].Text = lblvendor2.Text == "" ? "Contractor2" : lblvendor2.Text;
            gvItemHead.HeaderRow.Cells[4].Text = lblvendor3.Text == "" ? "Contractor3" : lblvendor3.Text;
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
        decimal dblContractor1 = 0;
        decimal dblContractor2 = 0;
        decimal dblContractor3 = 0;
        decimal dblTargetCost = 0;
        decimal dblInHouseCost = 0;
        dblContractor1 = dt.AsEnumerable().Sum(row => row.Field<decimal>("Contractor1"));
        dblContractor2 = dt.AsEnumerable().Sum(row => row.Field<decimal>("Contractor2"));
        dblContractor3 = dt.AsEnumerable().Sum(row => row.Field<decimal>("Contractor3"));
        dblTargetCost = dt.AsEnumerable().Sum(row => row.Field<decimal>("TargetCost"));
        dblInHouseCost = dt.AsEnumerable().Sum(row => row.Field<decimal>("InHouseCost"));

        gvItemHead.FooterRow.Cells[2].Text = dblContractor1.ToString();
        gvItemHead.FooterRow.Cells[3].Text = dblContractor2.ToString();
        gvItemHead.FooterRow.Cells[4].Text = dblContractor3.ToString();
        gvItemHead.FooterRow.Cells[5].Text = dblTargetCost.ToString();
        gvItemHead.FooterRow.Cells[6].Text = dblInHouseCost.ToString();

    }
    private void FillDtDFT(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractLogicNote 'View','" + ID + "'");
        if (ds.Tables[3].Rows.Count > 0)
        {

            gvDeviationfromtender.DataSource = ds.Tables[3];
            gvDeviationfromtender.DataBind();
        }
    }
    private void FillDtApprover(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractLogicNote 'View','" + ID + "'");
        if (ds.Tables[4].Rows.Count > 0)
        {

            gvApprover.DataSource = ds.Tables[4];
            gvApprover.DataBind();
        }
    }
    private void FillDtTC(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,Terms,StandardTerms,Preference1,Preference2 from tbl_CLNTermsandCondition where IsDelete=0 and CLNID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetailsTC"] = dtData;
        }
        else
        {
            dtData = new DataTable();
            dtData = cls.selectDataTable("select 0 as ID,Terms,StandardTerms,Preference1,Preference2 from tbl_CLNTandC where IsActive=1 order by ID");
            ViewState["dtDetailsTC"] = dtData;
        }

        dt = (DataTable)ViewState["dtDetailsTC"];

        gvTermsandCondition.DataSource = dt;
        gvTermsandCondition.DataBind();

    }
    private void FillDtAttachment(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractLogicNote 'View','" + ID + "'");
        if (ds.Tables[6].Rows.Count > 0)
        {
            gvAttachment.DataSource = ds.Tables[6];
            gvAttachment.DataBind();
        }
    }
    private void FillDtdocument(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManageContractLogicNote 'View','" + ID + "'");
        if (dtData.Tables[6].Rows.Count > 0)
        {
            for (int i = 0; i < dtData.Tables[6].Rows.Count; i++)
            {
                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Bid Evaluation")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkdownloadbidevaluation.Visible = true;
                        lnkdownloadbidevaluation.NavigateUrl = "../Upload/CLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkdownloadbidevaluation.Visible = false;
                    //}
                }

                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Delivery Schedule")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkdeliveryschedule.Visible = true;
                        lnkdeliveryschedule.NavigateUrl = "../Upload/CLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkdeliveryschedule.Visible = false;
                    //}
                }

                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Budget Approval")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkbudgetapproval.Visible = true;
                        lnkbudgetapproval.NavigateUrl = "../Upload/CLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkbudgetapproval.Visible = false;
                    //}
                }

                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Prior Approvals")
                {

                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkPriorApprovalsDownload.Visible = true;
                        lnkPriorApprovalsDownload.NavigateUrl = "../Upload/CLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkPriorApprovalsDownload.Visible = false;
                    //}
                }

                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Drawings")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkdrawingdocument.Visible = true;
                        lnkdrawingdocument.NavigateUrl = "../Upload/CLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkdrawingdocument.Visible = false;
                    //}
                }

                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Indent")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkIndentdownload.Visible = true;
                        lnkIndentdownload.NavigateUrl = "../Upload/CLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkIndentdownload.Visible = false;
                    //}
                }

                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Login Note")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnklogicnoteDownload.Visible = true;
                        lnklogicnoteDownload.NavigateUrl = "../Upload/CLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnklogicnoteDownload.Visible = false;
                    //}
                }

            }
        }
    }
    private void FillDtCreator(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractLogicNote 'View','" + ID + "'");
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
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'CLNCommitteeApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Contract Logic Note Successfully Approved !!');location.replace('ListApproveContractLogicNote.aspx');", true);

        }
    }

    protected void btnreject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'CLNCommitteeReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Contract Logic Note Successfully Rejected !!');location.replace('ListApproveContractLogicNote.aspx');", true);

        }
    }

    protected void btnprint_Click(object sender, EventArgs e)
    {
        try
        {
            Export.ExportReport(Request.QueryString["ID"].ToString(), "ContractlogicNote");

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

            //_reportViewer.ServerReport.ReportPath = "/Reports/ContractlogicNote";

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
            //Response.AddHeader("content-disposition", "inline;    filename = " + "ContractLogicNote" + "." + extension);

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
    public void DownloadDocImage(string ID, string CLNID, string DocFile, string Type)
    {
        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/CLN/") + DocFile))
        {
            DataTable dtCLNOrderNo = new DataTable();
            dtCLNOrderNo = cls.selectDataTable(" select b.CLNOrderNo from tbl_CLNCommitteeApproval a inner join tbl_ContractLogicNote b on a.CLNID=b.ID Where a.IsApprove=1 And  a.CLNID='" + CLNID + "' and a.IsDelete=0");
            if (dtCLNOrderNo.Rows.Count > 0)
            {
                string filePath = Server.MapPath("../Upload/CLN/") + ID + CLNID + Type + DocFile;
                try
                {
                    if (Type == "PDF")
                    {
                        PdfReader reader = new PdfReader(Server.MapPath("../Upload/CLN/") + DocFile);
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
                            ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtCLNOrderNo.Rows[0]["CLNOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15, iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
                            over.RestoreState();
                        }
                        stamper.Close();
                        reader.Close();
                    }
                    else if (Type == "Image")
                    {
                        PointF firstLocation = new PointF(10f, 10f);
                        string imageFilePath = Server.MapPath("../Upload/CLN/") + DocFile;
                        Bitmap newBitmap;
                        using (var bitmap = (Bitmap)System.Drawing.Image.FromFile(imageFilePath))//load the image file
                        {
                            using (Graphics graphics = Graphics.FromImage(bitmap))
                            {
                                using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12, FontStyle.Bold))
                                {
                                    System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);
                                    graphics.DrawString(dtCLNOrderNo.Rows[0]["CLNOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);

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
                var filePath = Server.MapPath("../Upload/CLN/") + DocFile + "";
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + DocFile + "");
                Response.TransmitFile(filePath);
                Response.End();
            }
        }


    }

    #endregion Attachment
}