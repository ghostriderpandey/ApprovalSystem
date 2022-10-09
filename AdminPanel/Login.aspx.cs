using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AdminPanel_Login : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dt = new DataTable();
    DataTable dtMenu = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cls.loginname = txtUserName.Text.Trim();
        cls.password = txtPassword.Text.Trim();
        cls.action = "UserPanel";
        cls.IpAddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
        dt = cls.LoginAuthentication();
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["Status"].ToString() == "1")
            {
                string str = "select * from tbl_MenuMaster where IsActive<>0 and MenuID in (Select Word from dbo.SplitPra('" + dt.Rows[0]["MenuStr"].ToString() + "') UNION Select Word from dbo.SplitPra('" + dt.Rows[0]["MenuIDStr"].ToString() + "')) order by parentid,position";
                dtMenu = cls.GetDataTable(str);
                Session.Add("dtMenu", dtMenu);
                Session.Add("UserSession", dt);
                
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + dt.Rows[0]["Message"].ToString() + "')", true);
                return;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid UserID/password !!')", true);
            return;
        }
    }
}