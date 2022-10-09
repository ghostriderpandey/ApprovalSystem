using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class AdminPanel_DepartmentMaster : System.Web.UI.Page
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
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_DepartmentMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    txtDepartmentName.Text = dtData.Rows[0]["DepartmentName"].ToString();
                    txtDepartmentCode.Text = dtData.Rows[0]["DepartmentCode"].ToString();
                }
            }
        }
    }
    void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_DepartmentMaster 'GetAll'");
        gvdepartment.DataSource = dtData;
        gvdepartment.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            dtResult = cls.selectDataTable("EXEC sp_DepartmentMaster 'Insert','0','" + txtDepartmentCode.Text.Trim() + "','" + txtDepartmentName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
            dtResult = cls.selectDataTable("EXEC sp_DepartmentMaster 'Update','" + Request.QueryString["ID"].ToString() + "','" + txtDepartmentCode.Text.Trim() + "','" + txtDepartmentName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('DepartmentMaster.aspx');", true);
                }
            }
        }
    }
    private void clear()
    {
        txtDepartmentName.Text = "";
        txtDepartmentCode.Text = "";
    }

    protected void gvrregion_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_DepartmentMaster 'ChangeStatus','" + e.CommandArgument + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');", true);
                loadgvdata();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_DepartmentMaster 'Delete','" + e.CommandArgument + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Department Successfully Deleted !!');", true);
                loadgvdata();
            }
        }
    }
}