////using ApprovalSystem.AdminPanel;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using Microsoft.Reporting.WebForms;
using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Export
/// </summary>
public class Export
{
    public static void ExportTopdf(DataTable dt, string filename)
    {

        GridView gv = new GridView();
        HttpContext.Current.Response.ContentType = "application/pdf";
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".pdf");
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        gv.DataSource = dt;
        gv.AllowPaging = false;
        gv.DataBind();
        gv.RenderControl(hw);

        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, HttpContext.Current.Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        HttpContext.Current.Response.Write(pdfDoc);

        HttpContext.Current.Response.End();
    }
    public static void ExportToWord(DataTable dt, string filename)
    {
        GridView GridView1 = new GridView();
        HttpContext.Current.Response.Clear();

        HttpContext.Current.Response.Buffer = true;

        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".doc");

        HttpContext.Current.Response.Charset = "";

        HttpContext.Current.Response.ContentType = "application/vnd.ms-word ";

        StringWriter sw = new StringWriter();

        HtmlTextWriter hw = new HtmlTextWriter(sw);
        GridView1.DataSource = dt;
        GridView1.AllowPaging = false;

        GridView1.DataBind();

        GridView1.RenderControl(hw);

        HttpContext.Current.Response.Output.Write(sw.ToString());

        HttpContext.Current.Response.Flush();

        HttpContext.Current.Response.End();

    }
    public static void ExportTocsv(DataTable dt, string filename)
    {
        GridView GridView1 = new GridView();
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".csv");
        HttpContext.Current.Response.Charset = "";
        HttpContext.Current.Response.ContentType = "application/text";
        GridView1.AllowPaging = false;
        GridView1.DataSource = dt;
        GridView1.DataBind();

        StringBuilder sb = new StringBuilder();
        for (int k = 0; k < GridView1.Columns.Count; k++)
        {
            //add separator
            sb.Append(GridView1.Columns[k].HeaderText + ',');
        }
        //append new line
        sb.Append("\r\n");
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            for (int k = 0; k < GridView1.Columns.Count; k++)
            {
                //add separator
                sb.Append(GridView1.Rows[i].Cells[k].Text + ',');
            }
            //append new line
            sb.Append("\r\n");
        }
        HttpContext.Current.Response.Output.Write(sb.ToString());
        HttpContext.Current.Response.Flush();
        HttpContext.Current.Response.End();
    }
    public static void ExportToExcel(DataTable dt, string filename)
    {
        GridView GridView1 = new GridView();
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Buffer = true;

        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xls");
        HttpContext.Current.Response.Charset = "";
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        GridView1.DataSource = dt;
        GridView1.AllowPaging = false;
        GridView1.DataBind();

        //Change the Header Row back to white color
        GridView1.CssClass = "ExportGridViewStyle";
        //  GridView1.HeaderRow.Style.Add("background-color", "green");
        //GridView1.HeaderRow.Style.Add("background-color", "#FFFFFF");
        GridView1.HeaderStyle.CssClass = "ExportHeaderStyle";

        //Apply style to Individual Cells
        //GridView1.HeaderRow.Cells[0].Style.Add("background-color", "green");
        //GridView1.HeaderRow.Cells[1].Style.Add("background-color", "green");
        //GridView1.HeaderRow.Cells[2].Style.Add("background-color", "green");
        //GridView1.HeaderRow.Cells[3].Style.Add("background-color", "green");
        //Apply Class to all Rows
        GridView1.RowStyle.CssClass = "ExportRowStyle";
        GridView1.AlternatingRowStyle.CssClass = "ExportAltRowStyle";
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            GridViewRow row = GridView1.Rows[i];

            //Change Color back to white
            //row.BackColor = System.Drawing.Color.White;

            //Apply text style to each Row
            row.Attributes.Add("class", "textmode");

            //Apply style to Individual Cells of Alternating Row
            //if (i % 2 != 0)
            //{
            //    row.Cells[0].Style.Add("background-color", "#C2D69B");
            //    row.Cells[1].Style.Add("background-color", "#C2D69B");
            //    row.Cells[2].Style.Add("background-color", "#C2D69B");
            //    row.Cells[3].Style.Add("background-color", "#C2D69B");
            //}
        }
        GridView1.RenderControl(hw);

        //style to format numbers to string
        string style = @"<style> .textmode { mso-number-format:\@; } </style>";
        HttpContext.Current.Response.Write(style);
        HttpContext.Current.Response.Output.Write(sw.ToString());
        HttpContext.Current.Response.Flush(); // Sends all currently buffered output to the client.
        HttpContext.Current.Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
        HttpContext.Current.ApplicationInstance.CompleteRequest();
    }
    public static void ExportReport(string ID, string pageName)
    {
        try
        {
            string ReportType = "P";//
                                    //Convert.ToString(TempData["ReportType"]);
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            ReportViewer _reportViewer = new ReportViewer();
            _reportViewer.ProcessingMode = ProcessingMode.Remote;
            _reportViewer.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ServerName"].ToString());
            _reportViewer.ServerReport.ReportPath = ConfigurationManager.AppSettings["ReportPath"].ToString() + "/" + pageName;

            ReportParameter[] param = new ReportParameter[1];
            param[0] = new ReportParameter("ID", ID);
            //param[0] = new ReportParameter("EmpID", EmpID);
            //param[1] = new ReportParameter("RefNo", RefNo.ToString());

            IReportServerCredentials irsc = new CustomReportCredentials(ConfigurationManager.AppSettings["UserName"].ToString(), ConfigurationManager.AppSettings["Password"].ToString());
            _reportViewer.ServerReport.ReportServerCredentials = irsc;
            _reportViewer.ServerReport.SetParameters(param);
            System.Drawing.Printing.PageSettings ps = new System.Drawing.Printing.PageSettings();
            ps.Landscape = true;
            //ps.PaperSize = new  System.Drawing.Printing.PaperSize("A3", 1169, 827);

            byte[] bytes;
            if (ReportType == "P")
            {
                bytes = _reportViewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
            }
            else
            {
                bytes = _reportViewer.ServerReport.Render("Excel", null, out mimeType, out encoding, out extension,
                    out streamIds, out warnings);
            }

            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = mimeType;
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;    filename = " + "DetailReport" + "." + extension);
            HttpContext.Current.Response.BinaryWrite(bytes); // create the file
            HttpContext.Current.Response.Flush(); // send it to the client to download

        }
        catch (Exception ex)
        {

        }
    }
    public class CustomReportCredentials : IReportServerCredentials
    {
        private string _UserName;
        private string _PassWord;

        public CustomReportCredentials(string UserName, string PassWord)
        {
            _UserName = UserName;
            _PassWord = PassWord;

        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get { return null; }
        }

        public ICredentials NetworkCredentials
        {
            get { return new NetworkCredential(_UserName, _PassWord); }
        }

        public bool GetFormsCredentials(out Cookie authCookie, out string user,
         out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;
        }
    }
}