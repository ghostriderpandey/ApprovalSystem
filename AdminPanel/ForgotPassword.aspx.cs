using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_ForgotPassword : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if ((txtEmailId.Text != "") && (txtEmailId.Text != null))
        {          
            if (cls.ExecuteIntScalar("select top 1 count(1) from tblUser_Details where EmailID='" + txtEmailId.Text.Trim() + "' and IsActive=1 and IsDelete=0") > 0)
            {
                string query= "select a.EmailID,'Recover Password' as Subject,'Dear ' + b.UserName + ',<br /><br /> Your Password is ' + convert(varchar(max), (DecryptByPassPhrase(SUBSTRING(cast(b.Salt as varchar(max)), 0, 8),[Password]))) + '' as Body from tblUser_Details as a inner join tbl_usermaster as b on b.ID = a.UserID where a.EmailID = '" + txtEmailId.Text.Trim() + "' and a.IsActive = 1 and a.IsDelete = 0";
                dtData = cls.selectDataTable(query);
                if (dtData.Rows.Count > 0)
                {
                    cls.GetMail(dtData.Rows[0]["EmailID"].ToString(), dtData.Rows[0]["Subject"].ToString(), dtData.Rows[0]["Body"].ToString());
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Password has been sent to your registered mail Id !');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Technical Error , Try After Some Time !');", true);
                }
                txtEmailId.Text = null;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter Valid Email Id');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter Your Registered Email Address !');", true);
        }
    }
}