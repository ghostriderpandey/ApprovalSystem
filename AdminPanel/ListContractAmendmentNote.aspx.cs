using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
//using ApprovalSystem.AdminPanel;

public partial class AdminPanel_ListContractAmendmentNote : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        if (!IsPostBack)
        {
            loadgvUser();
        }
    }
    void loadgvUser()
    {
        DataTable dtUser = (DataTable)Session["UserSession"];
        dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_ManageContractAmendmentNote 'GetAll','" + dtUser.Rows[0]["ID"].ToString() + "'");
        gvUser.DataSource = dtData;
        gvUser.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void gvUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_ManageContractAmendmentNote 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Contract Amendment Note Successfully Update !!');", true);
                loadgvUser();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_ManageContractAmendmentNote 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Contract Amendment Note Successfully Deleted !!');", true);
                loadgvUser();
            }
        }
        else if (e.CommandName == "ViewApprover")
        {
            string title = "";
            dtData = new DataTable();
            dtData = cls.selectDataTable("EXEC sp_ManageContractAmendmentNote 'GetAllApprover','" + e.CommandArgument + "'");
            gvPopup.DataSource = dtData;
            gvPopup.DataBind();
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + title + "');", true);
        }
        else if (e.CommandName == "View")
        {
            try
            {

                Export.ExportReport(e.CommandArgument.ToString(), "Contract Amendment Logic Note");
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
                //param[0] = new ReportParameter("ID", e.CommandArgument.ToString());
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
    }
}