using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AdminPanel_ChangePassword : System.Web.UI.Page
{

    cls_connection_new cls = new cls_connection_new();
    DataTable dtUser = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_UserMaster 'CheckPass','" + dtUser.Rows[0]["ID"].ToString() + "','" + txtCurrentPassword.Text + "'");
        if (dtData.Rows.Count > 0)
        {
            if (dtData.Rows[0]["Status"].ToString() == "1")
            {
                int flag = cls.ExecuteQuery("EXEC sp_UserMaster 'ChangePass','" + dtUser.Rows[0]["ID"].ToString() + "','" + txtNewPassword.Text + "'");
                if (flag > 0)
                {
                    Session["UserSession"] = null;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Password successfully changed');location.replace('ChangePassword.aspx');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Details')", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Current Password Invalid')", true);
            }
        }
    }
}