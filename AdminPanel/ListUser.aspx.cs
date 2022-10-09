using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class AdminPanel_ListUser : System.Web.UI.Page
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
        dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_UserMaster 'GetAll'");
        gvUser.DataSource = dtData;
        gvUser.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void gvUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_UserMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User Successfully Update !!');", true);
                loadgvUser();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_UserMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User Successfully Deleted !!');", true);
                loadgvUser();
            }
        }
    }
}