using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Security.Principal;
using System.Net;
using System.Web.Services;

public partial class AdminPanel_ListViewApproveMiscellaneousLogicNote : System.Web.UI.Page
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
            cls.BindDropDownList(ddlprojectname, "EXEC sp_ProjectMaster 'GetAllforddl'", "ProjectName", "ID");
            loadgvUser();
            FillApprover();
        }
    }
    void loadgvUser()
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }

        DataTable dtUser = (DataTable)Session["UserSession"];
        dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_ManageMiscellaneousLogicNote 'GetViewAllforApproval','" + dtUser.Rows[0]["ID"].ToString() + "',@ProjectID='" + ddlprojectname.SelectedValue + "',@ApprovalStatus='" + ddlStatus.SelectedValue + "',@ApprovalTodate='" + txtToApprovalDate.Text + "',@ApprovalFromdate='" + txtFromApprovalDate.Text + "'");
        gvUser.DataSource = dtData;
        gvUser.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void gvUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
        int RowIndex = gvr.RowIndex;
        TextBox txtRemark = (TextBox)gvUser.Rows[RowIndex].FindControl("txtRemark");
        if (e.CommandName == "Approve")
        {
            int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'MSLNApproverApprove','" + e.CommandArgument + "','" + txtRemark.Text + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Miscellaneous Logic Note Successfully Approved !!');", true);
                loadgvUser();
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
            }
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "fnn();", true);
        }
        else if (e.CommandName == "Reject")
        {
            int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'MSLNApproverReject','" + e.CommandArgument + "','" + txtRemark.Text + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Miscellaneous Logic Note Successfully Rejected !!');", true);
                loadgvUser();
            }
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "fnn();", true);
        }

        else if (e.CommandName == "View")
        {
            try
            {
                Export.ExportReport(e.CommandArgument.ToString(), "Miscellaneous Logic Note");
                //string ReportType = "P";
                //Warning[] warnings;
                //string[] streamIds;
                //string mimeType = string.Empty;
                //string encoding = string.Empty;
                //string extension = string.Empty;
                //ReportViewer _reportViewer = new ReportViewer();
                //_reportViewer.ProcessingMode = ProcessingMode.Remote;
                //_reportViewer.ServerReport.ReportServerUrl = new Uri("http://192.168.100.20/Reportserver");

                //_reportViewer.ServerReport.ReportPath = "/Reports/Miscellaneous Logic Note";

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
    public class CustomReportCredentials : Microsoft.Reporting.WebForms.IReportServerCredentials
    {
        private string _UserName;
        private string _PassWord;

        public CustomReportCredentials(string UserName, string PassWord)
        {
            _UserName = UserName;
            _PassWord = PassWord;

        }

        public WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;
            }
        }

        public ICredentials NetworkCredentials
        {
            get
            {
                return new NetworkCredential(_UserName, _PassWord);
            }
        }

        public bool GetFormsCredentials(out Cookie authCookie, out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;
        }
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        loadgvUser();
    }
    void FillApprover()
    {
        List<Approvar> listApprovar = new List<Approvar>();
        Approvar ap = new Approvar();
        ap.ApproverName = "";
        ap.SubmissionDate = "";
        ap.ApprovalStatus = "";
        ap.ApprovalDate = "";
        ap.Remark = "";
        listApprovar.Add(ap);
        // rptApprover.DataSource = listApprovar;
        // rptApprover.DataBind();
    }
    [WebMethod]
    public static List<Approvar> getApprover(string id)
    {
        cls_connection_new cls = new cls_connection_new();
        DataTable dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_ManageMiscellaneousLogicNote 'GetAllApprover','" + id + "'");
        List<Approvar> listApprovar = new List<Approvar>();
        if (dtData.Rows.Count > 0)
        {
            for (int i = 0; i < dtData.Rows.Count; i++)
            {
                Approvar ap = new Approvar();
                ap.ApproverName = dtData.Rows[i]["Approver Name"].ToString();
                ap.SubmissionDate = dtData.Rows[i]["Submission Date"].ToString();
                ap.ApprovalStatus = dtData.Rows[i]["Approval Status"].ToString();
                ap.ApprovalDate = dtData.Rows[i]["Approval Date"].ToString();
                ap.Remark = dtData.Rows[i]["Remark"].ToString();
                listApprovar.Add(ap);
            }
        }
        return listApprovar;
    }
    public class Approvar
    {
        public string ApproverName { get; set; }
        public string SubmissionDate { get; set; }
        public string ApprovalStatus { get; set; }
        public string ApprovalDate { get; set; }
        public string Remark { get; set; }
    }
}