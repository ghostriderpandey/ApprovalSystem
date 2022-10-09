using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text.pdf;
using System.IO;
using System.Text;
using System.Drawing;
using System.Drawing.Imaging;
using iTextSharp.text;
////using ApprovalSystem.AdminPanel;

public partial class AdminPanel_PurchaseAmendmentReport : System.Web.UI.Page
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
                dtData = cls.selectDataTable("EXEC sp_ManagePurchaseAmendmentNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    if (dtData.Rows[0]["IsApproved"].ToString().ToUpper() == "TRUE")
                    {
                        btnreject.Enabled = false;
                        btnapprove.Enabled = false;
                    }
                    //ddloriginalpurchaseordernumber.SelectedValue = dtData.Rows[0]["PurchaseOrderNo"].ToString();
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
                    lblPurchaseOrderNo.Text = dtData.Rows[0]["PurchaseOrderNo"].ToString();
                    lblapprovalauthority.Text = dtData.Rows[0]["CommitteeName"].ToString();
                    lblsubjectscope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
                    lblprojectnaddress.Text = dtData.Rows[0]["ProjectName"].ToString() + " " + dtData.Rows[0]["ProjectAddress"].ToString();

                    // ddlDepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
                    lblindentproponent.Text = dtData.Rows[0]["IndentProponent"].ToString();
                    DateTime dateofindent = Convert.ToDateTime(dtData.Rows[0]["Dateofindent1"].ToString());
                    lbldateofindent.Text = dateofindent.ToString("dd/MM/yyyy");
                    DateTime materialneededby = Convert.ToDateTime(dtData.Rows[0]["Materialneededby1"].ToString());
                    lblmaterialneededby.Text = materialneededby.ToString("dd/MM/yyyy");
                    lblstockinhand.Text = dtData.Rows[0]["StockinHand"].ToString() + " " + dtData.Rows[0]["StockUOM"].ToString();

                    lblrequirement.Text = dtData.Rows[0]["Requirement"].ToString();
                    //txtUrgetResionDescription.Text = dtData.Rows[0]["UrgentReasonDesc"].ToString();
                    lblsaleablearea.Text = dtData.Rows[0]["SaleableArea"].ToString();
                    lblalreadyawarded.Text = dtData.Rows[0]["AlreadyAwarded"].ToString();
                    lblapprovebudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
                    lblrevisedvalueasperthisamend.Text = dtData.Rows[0]["RevisedValue"].ToString();
                    lblbalancetobeawarded.Text = dtData.Rows[0]["BalanceAward"].ToString();
                    lblvariationfrombudget.Text = dtData.Rows[0]["Variationfombudget"].ToString();
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
                    lblproposedvendorname.Text = dtData.Rows[0]["VendorName"].ToString();
                    lblcostasperoriginalaward.Text = dtData.Rows[0]["OriginalAward"].ToString();
                    lblrevcostasperpreviousamendment.Text = dtData.Rows[0]["PreviousRevCost"].ToString();
                    lblrevcostasperthisamendment.Text = dtData.Rows[0]["ThisRevCost"].ToString();
                    lblvariationprevvsthisamendment.Text = dtData.Rows[0]["VariationPreviousvsThis"].ToString();
                    lblvariationoriginalvsthisamendmet.Text = dtData.Rows[0]["VariationOriginalvsThis"].ToString();
                    lblrecommadationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();
                    lblgstvprev.Text = dtData.Rows[0]["PreviousGST"].ToString();
                    lblgstthis.Text = dtData.Rows[0]["ThisGST"].ToString();
                    lblfrieghtprev.Text = dtData.Rows[0]["PreviousFreight"].ToString();
                    lblfrieghtthis.Text = dtData.Rows[0]["ThisFreight"].ToString();
                    lblhandingchargesprev.Text = dtData.Rows[0]["PreviousHandlingCharges"].ToString();
                    lblhandingchargesthis.Text = dtData.Rows[0]["ThisHandlingCharges"].ToString();

                    lblPreviousHandlingCharge.Text = dtData.Rows[0]["PreviousHandlingCharge"].ToString();
                    lblThisHandlingCharge.Text = dtData.Rows[0]["ThisHandlingCharge"].ToString();
                    lblPreviousOtherCharge.Text = dtData.Rows[0]["PreviousOtherCharge"].ToString();
                    lblThisOtherCharge.Text = dtData.Rows[0]["ThisOtherCharge"].ToString();

                    lblgrandtotalprev.Text = dtData.Rows[0]["PreviousGrandTotal"].ToString();
                    lblgrandtotalthis.Text = dtData.Rows[0]["ThisGrandTotal"].ToString();
                    lblcostsqftprev.Text = dtData.Rows[0]["PreviousCostPerSqft"].ToString();
                    lblcostsqftthis.Text = dtData.Rows[0]["ThisCostPerSqft"].ToString();
                    DataSet dtData1 = cls.GetDataSet("EXEC sp_ManagePurchaseAmendmentNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                    if (dtData1.Tables[5].Rows.Count > 0)
                    {

                        lblpreparedby.Text = dtData1.Tables[5].Rows[0]["CreatedBy"].ToString();
                        DateTime createdon = Convert.ToDateTime(dtData1.Tables[5].Rows[0]["CreatedOn"].ToString());
                        lblcreatedon.Text = createdon.ToString("dd/MM/yyyy h:mm:ss tt");

                    }
                }
                FillDt(Request.QueryString["ID"].ToString());
                FillDtIH(Request.QueryString["ID"].ToString());
                FillDtApprover(Request.QueryString["ID"].ToString());
                FillDtAttachment(Request.QueryString["ID"].ToString());
                FillDtdocument(Request.QueryString["ID"].ToString());
            }

        }
    }
    private void FillDt(string ID)
    {

        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseAmendmentNote 'View','" + ID + "'");
        if (dtData.Tables[1].Rows.Count > 0)
        {

            gvStandardexception.DataSource = dtData.Tables[1];
            gvStandardexception.DataBind();
        }
    }
    private void FillDtIH(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseAmendmentNote 'View','" + ID + "'");
        if (dtData.Tables[2].Rows.Count > 0)
        {

            gvItemHead.DataSource = dtData.Tables[2];
            gvItemHead.DataBind();
            CalIHTotal();
        }
    }
    private void CalIHTotal()
    {
        DataTable dt = new DataTable();
        dt = (DataTable)gvItemHead.DataSource;
        gvItemHead.FooterRow.Font.Bold = true;
        gvItemHead.FooterRow.Cells[3].Text = "Sub Total";
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

        gvItemHead.FooterRow.Cells[3].Text = dblPreviousQuantity.ToString();
        gvItemHead.FooterRow.Cells[4].Text = dblPreviousRate.ToString();
        gvItemHead.FooterRow.Cells[5].Text = dblPreviousValue.ToString();
        gvItemHead.FooterRow.Cells[6].Text = dblThisQuantity.ToString();
        gvItemHead.FooterRow.Cells[7].Text = dblThisRate.ToString();
        gvItemHead.FooterRow.Cells[8].Text = dblThisValue.ToString();
        gvItemHead.FooterRow.Cells[9].Text = dblBudgetRate.ToString();

    }
    private void FillDtApprover(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseAmendmentNote 'View','" + ID + "'");
        if (dtData.Tables[4].Rows.Count > 0)
        {

            gvApprover.DataSource = dtData.Tables[4];
            gvApprover.DataBind();
        }
    }
    private void FillDtAttachment(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseAmendmentNote 'View','" + ID + "'");
        if (dtData.Tables[3].Rows.Count > 0)
        {

            gvAttachment.DataSource = dtData.Tables[3];
            gvAttachment.DataBind();
        }
    }
    private void FillDtdocument(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManagePurchaseAmendmentNote 'View','" + ID + "'");
        if (dtData.Tables[3].Rows.Count > 0)
        {
            for (int i = 0; i < dtData.Tables[3].Rows.Count; i++)
            {


                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Delivery Schedule")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprdeliveryschedule.Visible = true;
                        hprdeliveryschedule.NavigateUrl = "../Upload/PAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    hprdeliveryschedule.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Budget Approval")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprbudgetapproval.Visible = true;
                        hprbudgetapproval.NavigateUrl = "../Upload/PAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    hprbudgetapproval.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Prior Approvals")
                {

                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprpriorapproval.Visible = true;
                        hprpriorapproval.NavigateUrl = "../Upload/PAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    hprpriorapproval.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Drawings")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprdrawingdocument.Visible = true;
                        hprdrawingdocument.NavigateUrl = "../Upload/PAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    hprdrawingdocument.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Indent")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprindent.Visible = true;
                        hprindent.NavigateUrl = "../Upload/PAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    else
                    {
                        hprindent.Visible = false;
                    }
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Login Note")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        hprlogicnote.Visible = true;
                        hprlogicnote.NavigateUrl = "../Upload/PAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    hprlogicnote.Visible = false;
                    //}
                }

            }
        }
    }

    protected void btnapprove_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'PANApproverApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Purchase Logic Note Successfully Approved !!');location.replace('ListApprovePurchaseAmendmentNote.aspx');", true);

        }
    }

    protected void btnreject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'PANApproverReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Purchase Logic Note Successfully Rejected !!');location.replace('ListApprovePurchaseAmendmentNote.aspx');", true);

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
            //Response.AddHeader("content-disposition", "inline;    filename = " + "DetailReport" + "." + extension);

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
    public void DownloadDocImage(string ID, string PANID, string DocFile, string Type)
    {

        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/PAN/") + DocFile))
        {
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
    }
    #endregion Attachment
}