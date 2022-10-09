using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AdminPanel_ProjectMaster : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    DataTable dtUser = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        if (!IsPostBack)
        {
            loadgvdata();
            cls.BindDropDownList(ddlCompany, "EXEC sp_CompanyMaster 'GetAllforddl'", "CompanyName", "ID");
            if (Request.QueryString["ID"] != null)
            {
                //cls.BindDropDownList(ddlCompany, "EXEC sp_CompanyMaster 'GetAllforddl'", "CompanyName", "ID");
                dtData = cls.selectDataTable("EXEC sp_ProjectMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    ddlCompany.SelectedValue = dtData.Rows[0]["CompanyID"].ToString();
                    txtProjectName.Text = dtData.Rows[0]["ProjectName"].ToString();
                    txtprojectaddress.Text = dtData.Rows[0]["ProjectAddress"].ToString();
                }
            }
        }
    }
    void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_ProjectMaster 'GetAll'");
        gvProject.DataSource = dtData;
        gvProject.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            dtResult = cls.selectDataTable("EXEC sp_ProjectMaster 'Insert','0','" + ddlCompany.SelectedValue + "','" + txtProjectName.Text.Trim() + "','" + txtprojectaddress.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (dtResult.Rows.Count > 0)
            {
                string strMessage = dtResult.Rows[0]["Message"].ToString();
                string strStatus = dtResult.Rows[0]["Status"].ToString();
                if (strStatus == "0")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "')", true);
                    clear();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');", true);
                    loadgvdata();
                    clear();
                }
            }
        }
        else
        {
            dtResult = cls.selectDataTable("EXEC sp_ProjectMaster 'Update','" + Request.QueryString["ID"].ToString() + "','" + ddlCompany.SelectedValue + "','" + txtProjectName.Text.Trim() + "','" + txtprojectaddress.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (dtResult.Rows.Count > 0)
            {
                string strMessage = dtResult.Rows[0]["Message"].ToString();
                string strStatus = dtResult.Rows[0]["Status"].ToString();
                if (strStatus == "0")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "')", true);
                    clear();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('ProjectMaster.aspx');", true);
                }
            }
        }
    }
    private void clear()
    {
        txtProjectName.Text = "";
    }

    protected void gvrregion_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_ProjectMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');", true);
                loadgvdata();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_ProjectMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Project Successfully Deleted !!');", true);
                loadgvdata();
            }
        }
    }
}