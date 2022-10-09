using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_SalesLogicNoteReport : System.Web.UI.Page
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
                dtData = cls.selectDataTable("EXEC sp_ManageSalesLogicNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    if (dtData.Rows[0]["IsApproved"].ToString().ToUpper() == "TRUE")
                    {
                        btnapprove.Enabled = false;
                        btnreject.Enabled = false;
                    }

                    lblcompanyname.Text = dtData.Rows[0]["CompanyName"].ToString();

                    if (dtData.Rows[0]["SLNOrderNo"].ToString() == "")
                    {
                        storderno.Visible = false;
                    }
                    else
                    {
                        storderno.Visible = true;
                        lblorderno.Text = dtData.Rows[0]["SLNOrderNo"].ToString();
                    }
                    lblapprovalauthority.Text = dtData.Rows[0]["CommitteeName"].ToString();
                    lblsubjectscope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
                    lblprojectnaddress.Text = dtData.Rows[0]["ProjectName"].ToString() + " " + dtData.Rows[0]["ProjectAddress"].ToString();//--
                    lbldepartment.Text = dtData.Rows[0]["DepartmentName"].ToString();
                    if (dtData.Rows[0]["ApprovalType"].ToString() == "2")
                    {
                        lblApprovalType.Text = "Amendment";
                    }
                    else
                    {
                        lblApprovalType.Text = "New";
                    }
                    if (dtData.Rows[0]["ApprovalType"].ToString() == "2")
                    {
                        lblorderno.Text = dtData.Rows[0]["ApprovalNo"].ToString();
                        lblApprovalNo.Text = dtData.Rows[0]["SLNOrderNo"].ToString();
                        spaNo.Visible = true;
                        lblApprovalNo.Visible = true;
                    }
                    else
                    {
                        lblorderno.Text = dtData.Rows[0]["SLNOrderNo"].ToString();
                    }
                    lblApprovalPriority.Text = dtData.Rows[0]["ApprovalPriority"].ToString();

                    lblUrgentRemarks.Text = dtData.Rows[0]["UrjentRemarks"].ToString();
                    //lblStatus.Text = dtData.Rows[0]["Status"].ToString();
                    lblReasonOfAmendment.Text = dtData.Rows[0]["ReasonOfAmendent"].ToString();
                    lblOtherDescription.Text = dtData.Rows[0]["OtherDescription"].ToString();
                    lblCustomerName.Text = dtData.Rows[0]["CustomerName"].ToString();
                    lblNegotiationMode.Text = dtData.Rows[0]["NegotiationMode"].ToString();
                    lblChannelPartnerName.Text = dtData.Rows[0]["ChannelPartnerName"].ToString();
                    lblUnitNo.Text = dtData.Rows[0]["UnitNo"].ToString();
                    lblOldUnitNo.Text = dtData.Rows[0]["OldUnitNo"].ToString();
                    lblSuperArea.Text = dtData.Rows[0]["SuperArea"].ToString();
                    lblBSP.Text = dtData.Rows[0]["BSP"].ToString();
                    lblApprovalSought.Text = dtData.Rows[0]["ApprovalSought"].ToString();
                    lblPLC.Text = dtData.Rows[0]["PLC"].ToString();
                    lblEDC.Text = dtData.Rows[0]["EDC_IDC"].ToString();
                    lblEIC.Text = dtData.Rows[0]["EIC"].ToString();
                    lblCarparking.Text = dtData.Rows[0]["CarParking"].ToString();
                    lblTCV.Text = dtData.Rows[0]["TCV"].ToString();
                    lblPossessionCharges.Text = dtData.Rows[0]["PossessionCharges"].ToString();
                    lblOtherCharges.Text = dtData.Rows[0]["OtherCharges"].ToString();
                    lblRegnNo.Text = dtData.Rows[0]["RegNo"].ToString();
                    lblHeadOfDepartment.Text = dtData.Rows[0]["HeadOfDepartment"].ToString();
                    int status = cls.ExecuteIntScalar("select count(1) from tbl_SalesLogicNote where ID=" + Convert.ToInt32(Request.QueryString["ID"]) + " and IsSubmitted=1");
                    if (status == 0)
                    {
                        lblStatus.Text = "Draft";
                    }
                    else
                    {
                        status = cls.ExecuteIntScalar("select count(1) from tbl_SalesLogicNote where ID=" + Convert.ToInt32(Request.QueryString["ID"]) + " and IsCommitteeApproved=1");
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
                        int count = cls.ExecuteIntScalar("select count(1) from tbl_SalesApprover where ApproverID=" + Convert.ToInt32(dtUser.Rows[0]["ID"]) + " and SalesID=" + Convert.ToString(Request.QueryString["ID"]) + " and IsApprove=0");
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
                FillPaymentPlan(Request.QueryString["ID"].ToString());
                FillPaymentDetails(Request.QueryString["ID"].ToString());
                FillDtApprover(Request.QueryString["ID"].ToString());
                FillDtAttachment(Request.QueryString["ID"].ToString());

            }

        }
    }
    private void FillPaymentPlan(string ID)
    {

        DataSet ds = cls.GetDataSet("EXEC sp_ManageSalesLogicNote 'View','" + ID + "'");
        if (ds.Tables[1].Rows.Count > 0)
        {

            gvPaymentPlan.DataSource = ds.Tables[1];
            gvPaymentPlan.DataBind();
        }
    }
    private void FillPaymentDetails(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageSalesLogicNote 'View','" + ID + "'");
        if (ds.Tables[2].Rows.Count > 0)
        {

            gvPaymentDetails.DataSource = ds.Tables[2];
            gvPaymentDetails.DataBind();
        }
    }


    private void FillDtApprover(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageSalesLogicNote 'View','" + ID + "'");
        if (ds.Tables[5].Rows.Count > 0)
        {

            gvApprover.DataSource = ds.Tables[5];
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

        // gvTermsandCondition.DataSource = dt;
        //.DataBind();

    }
    private void FillDtAttachment(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageSalesLogicNote 'View','" + ID + "'");
        if (ds.Tables[4].Rows.Count > 0)
        {
            gvAttachment.DataSource = ds.Tables[4];
            gvAttachment.DataBind();
        }
    }
    private void FillDtdocument(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManageSalesLogicNote 'View','" + ID + "'");
        if (dtData.Tables[6].Rows.Count > 0)
        {
            for (int i = 0; i < dtData.Tables[6].Rows.Count; i++)
            {
                if (dtData.Tables[6].Rows[i]["Category"].ToString() == "Bid Evaluation")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        //lnkdownloadbidevaluation.Visible = true;
                        // lnkdownloadbidevaluation.NavigateUrl = "../Upload/CRM/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
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
                        lnkdeliveryschedule.NavigateUrl = "../Upload/SLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
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
                        lnkbudgetapproval.NavigateUrl = "../Upload/SLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
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
                        lnkPriorApprovalsDownload.NavigateUrl = "../Upload/SLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
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
                        // lnkdrawingdocument.Visible = true;
                        /// lnkdrawingdocument.NavigateUrl = "../Upload/CRM/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
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
                        lnkIndentdownload.NavigateUrl = "../Upload/SLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkIndentdownload.Visible = false;
                    //}
                }
                if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                {
                    lnklogicnoteDownload.Visible = true;
                    lnklogicnoteDownload.NavigateUrl = "../Upload/SLN/" + dtData.Tables[6].Rows[i]["DocFile"].ToString();
                    //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                }
                //else
                //{
                //    lnklogicnoteDownload.Visible = false;


            }
        }
    }


    protected void btnapprove_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'SalesApproverApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sales Logic Note Successfully Approved !!');location.replace('ListApproveCRMLogicNote.aspx');", true);

        }
    }

    protected void btnreject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'SalesApproverReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sales Logic Note Successfully Rejected !!');location.replace('ListApproveCRMLogicNote.aspx');", true);

        }
    }

    protected void btnprint_Click(object sender, EventArgs e)
    {
        try
        {

            Export.ExportReport(Request.QueryString["ID"].ToString(), "Sales Logic Note");
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

            //_reportViewer.ServerReport.ReportPath = "/Reports/SaleslogicNote";

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
            //Response.AddHeader("content-disposition", "inline;    filename = " + "SalesLogicNote" + "." + extension);

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
    public void DownloadDocImage(string ID, string SLNID, string DocFile, string Type)
    {
        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/SLN/") + DocFile))
        {
            DataTable dtCRMOrderNo = new DataTable();
            dtCRMOrderNo = cls.selectDataTable(" select b.SalesOrderNo from tbl_SalesApprover a inner join tbl_SalesLogicNote b on a.SalesID=b.ID Where a.IsApprove=1 And  a.SalesID='" + SLNID + "' and a.IsDelete=0");
            if (dtCRMOrderNo.Rows.Count > 0)
            {
                string filePath = Server.MapPath("../Upload/SLN/") + ID + SLNID + Type + DocFile;
                try
                {
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
                            ColumnText.ShowTextAligned(over, Element.ALIGN_CENTER, new Phrase(dtCRMOrderNo.Rows[0]["SalesOrderNo"].ToString(), new iTextSharp.text.Font(iTextSharp.text.Font.TIMES_ROMAN, 15, iTextSharp.text.Font.BOLD)), pagesize.Width - 250, pagesize.Height - 30, 0);
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
                                using (System.Drawing.Font arialFont = new System.Drawing.Font("TIMES_ROMAN", 12, FontStyle.Bold))
                                {
                                    System.Drawing.Rectangle rect1 = new System.Drawing.Rectangle(400, 10, 400, 130);
                                    graphics.DrawString(dtCRMOrderNo.Rows[0]["SalesOrderNo"].ToString(), arialFont, Brushes.DarkBlue, rect1);

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
                var filePath = Server.MapPath("../Upload/SLN/") + DocFile + "";
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
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'SalesCommitteeApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sales Logic Note Successfully Approved !!');location.replace('ListApproveCommitteeSalesLogicNote.aspx');", true);

        }
    }

    protected void btnCReject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'SalesCommitteeReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sales Logic Note Successfully Rejected !!');location.replace('ListApproveCommitteeSalesLogicNote.aspx');", true);

        }
    }
}