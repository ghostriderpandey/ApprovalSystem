using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Security.Principal;
using System.Net;

public partial class AdminPanel_ListCRMLogicNote : System.Web.UI.Page
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
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        DataTable dtUser = (DataTable)Session["UserSession"];
        dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_ManageCRMLogicNote 'GetAll','" + dtUser.Rows[0]["ID"].ToString() + "'");
        gvUser.DataSource = dtData;
        gvUser.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void gvUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_ManageCRMLogicNote 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');fnn();", true);
                loadgvUser();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_ManageCRMLogicNote 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Marketing Logic Note Successfully Deleted !!');fnn();", true);
                loadgvUser();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
            }
        }
        else if (e.CommandName == "ViewApprover")
        {
            string title = "";
            dtData = new DataTable();
            dtData = cls.selectDataTable("EXEC sp_ManageCRMLogicNote 'GetAllApprover','" + e.CommandArgument + "'");
            gvPopup.DataSource = dtData;
            gvPopup.DataBind();
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "fnn();ShowPopup('" + title + "');", true);
        }
        else if (e.CommandName == "View")
        {
            try
            {
                Export.ExportReport(e.CommandArgument.ToString(), "CRM Logic Note");

               

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
}