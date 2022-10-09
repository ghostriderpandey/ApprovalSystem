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
using iTextSharp.text;
using System.Drawing;
//using ApprovalSystem.AdminPanel;

public partial class AdminPanel_ContractAmendmentLogicNoteReport : System.Web.UI.Page
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
                dtData = cls.selectDataTable("EXEC sp_ManageContractAmendmentNote 'View','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    if (dtData.Rows[0]["IsApproved"].ToString().ToUpper() == "TRUE")
                    {
                        btnapprove.Enabled = false;
                        btnreject.Enabled = false;
                    }
                    //txtoriginalContractordernumber.Text = dtData.Rows[0]["ContractOrderNo"].ToString();
                    lblcompanyname.Text = dtData.Rows[0]["CompanyName"].ToString();

                    if (dtData.Rows[0]["CANOrderNo"].ToString() == "")
                    {
                        storderno.Visible = false;
                    }
                    else
                    {
                        storderno.Visible = true;
                        lblorderno.Text = dtData.Rows[0]["CANOrderNo"].ToString();
                    }
                    lblPurchaseOrderNo.Text = dtData.Rows[0]["ContractOrderNo"].ToString();
                    lblapprovalauthority.Text = dtData.Rows[0]["CommitteeName"].ToString();//--
                    lblsubjectscope.Text = dtData.Rows[0]["SubjectandScope"].ToString();
                    lblprojectnaddress.Text = dtData.Rows[0]["ProjectName"].ToString();//--

                    //ddlDepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
                    lblsaleableareainsqft.Text = dtData.Rows[0]["SaleableArea"].ToString();
                    lblapprovebudget.Text = dtData.Rows[0]["ApprovalBudget"].ToString();
                    lblalreadyawarded.Text = dtData.Rows[0]["AlreadyAward"].ToString();
                    lblbalancetobeawarded.Text = dtData.Rows[0]["BalanceAward"].ToString();
                    lblrevisedvalueasperthisamend.Text = dtData.Rows[0]["RevisedValue"].ToString();
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
                    lblmentionnameofvendorwithpo.Text = dtData.Rows[0]["ContractorName"].ToString();
                    lblcostasperoriginalaward.Text = dtData.Rows[0]["OriginalAward"].ToString();
                    lblrevcostasperpreviousamendment.Text = dtData.Rows[0]["RevCostasperPrevious"].ToString();
                    lblrevcostasperthisamendment.Text = dtData.Rows[0]["RevCostasperThis"].ToString();
                    lblvariationprevvsthisamendment.Text = dtData.Rows[0]["VariationPreviousvsThis"].ToString();
                    lblvariationoriginalvsthisamendmet.Text = dtData.Rows[0]["VariationOriginalvsThis"].ToString();
                    lblrecommadationwithreason.Text = dtData.Rows[0]["Recommendationswithreasons"].ToString();
                    // lblcostsqftprev.Text = dtData.Rows[0]["PreviousCostPerSqft"].ToString();
                    //lblcostsqftthis.Text = dtData.Rows[0]["ThisCostPerSqft"].ToString();
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

        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractAmendmentNote 'View','" + ID + "'");
        if (ds.Tables[1].Rows.Count > 0)
        {

            gvStandardexception.DataSource = ds.Tables[1];
            gvStandardexception.DataBind();
        }
    }
    private void FillDtIH(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractAmendmentNote 'View','" + ID + "'");
        if (ds.Tables[2].Rows.Count > 0)
        {

            gvItemHead.DataSource = ds.Tables[2];
            gvItemHead.DataBind();
            //CalIHTotal();
        }
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

        gvItemHead.FooterRow.Cells[2].Text = dblPreviousAmend.ToString();
        gvItemHead.FooterRow.Cells[3].Text = dblThisAmend.ToString();
        gvItemHead.FooterRow.Cells[4].Text = dblVariation.ToString();

    }
    private void FillDtApprover(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractAmendmentNote 'View','" + ID + "'");
        if (ds.Tables[4].Rows.Count > 0)
        {

            gvApprover.DataSource = ds.Tables[4];
            gvApprover.DataBind();
        }
    }
    private void FillDtAttachment(string ID)
    {
        DataSet ds = cls.GetDataSet("EXEC sp_ManageContractAmendmentNote 'View','" + ID + "'");
        if (ds.Tables[3].Rows.Count > 0)
        {

            gvAttachment.DataSource = ds.Tables[3];
            gvAttachment.DataBind();
        }
    }
    private void FillDtdocument(string ID)
    {
        DataSet dtData = cls.GetDataSet("EXEC sp_ManageContractAmendmentNote 'View','" + ID + "'");
        if (dtData.Tables[3].Rows.Count > 0)
        {
            for (int i = 0; i < dtData.Tables[3].Rows.Count; i++)
            {


                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Delivery Schedule")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkdeliveryschedule.Visible = true;
                        lnkdeliveryschedule.NavigateUrl = "../Upload/CAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkdeliveryschedule.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Budget Approval")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkbudgetapproval.Visible = true;
                        lnkbudgetapproval.NavigateUrl = "../Upload/CAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkbudgetapproval.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Prior Approvals")
                {

                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkPriorApprovalsDownload.Visible = true;
                        lnkPriorApprovalsDownload.NavigateUrl = "../Upload/CAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkPriorApprovalsDownload.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Drawings")
                {
                    if (dtData.Tables[6].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkdrawingdocument.Visible = true;
                        lnkdrawingdocument.NavigateUrl = "../Upload/CAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkdrawingdocument.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Indent")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnkIndentdownload.Visible = true;
                        lnkIndentdownload.NavigateUrl = "../Upload/CAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
                        //lnkbidevaluation.Attributes.Add("href", dtData.Tables[4].Rows[i]["DocFile"].ToString());
                    }
                    //else
                    //{
                    //    lnkIndentdownload.Visible = false;
                    //}
                }

                if (dtData.Tables[3].Rows[i]["Category"].ToString() == "Login Note")
                {
                    if (dtData.Tables[3].Rows[i]["DocFile"].ToString() != "")
                    {
                        lnklogicnoteDownload.Visible = true;
                        lnklogicnoteDownload.NavigateUrl = "../Upload/CAN/" + dtData.Tables[3].Rows[i]["DocFile"].ToString();
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

    protected void btnapprove_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'CANApproverApprove','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Contract Amendment Note Successfully Approved !!');location.replace('ListApproveContractAmendmentNote.aspx');", true);
            Response.Redirect(Request.RawUrl);
        }
    }

    protected void btnreject_Click(object sender, EventArgs e)
    {
        int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'CANApproverReject','" + Request.QueryString["AID"].ToString() + "','" + txtremark.Text + "'");
        if (count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Contract Amendment Note Successfully Rejected !!');location.replace('ListApproveContractAmendmentNote.aspx');", true);
            Response.Redirect(Request.RawUrl);
        }
    }

    protected void btnprint_Click(object sender, EventArgs e)
    {
        try
        {

            Export.ExportReport(Request.QueryString["ID"].ToString(), "Contract Amendment Logic Note");
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

            //_reportViewer.ServerReport.ReportPath = "/Reports/Contract Amendment Logic Note";

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
    public void DownloadDocImage(string ID, string CANID, string DocFile, string Type)
    {

        if (DocFile != "" && File.Exists(Server.MapPath("../Upload/CAN/") + DocFile))
        {
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
                        try
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
                        catch (Exception ex)
                        {
                        }
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



    }

    #endregion Attachment
}