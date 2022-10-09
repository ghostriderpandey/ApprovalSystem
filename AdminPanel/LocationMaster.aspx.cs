using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AdminPanel_LocationMaster : System.Web.UI.Page
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
            cls.BindDropDownList(ddlprojet, "EXEC sp_ProjectMaster 'GetAllforDDL'", "ProjectName", "ID");
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_LocationMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    txtLocationName.Text = dtData.Rows[0]["LocationName"].ToString();
                    ddlprojet.SelectedValue = dtData.Rows[0]["ProjectID"].ToString();
                }
            }
        }
    }
    void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_LocationMaster 'GetAll'");
        gvLocation.DataSource = dtData;
        gvLocation.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            dtResult = cls.selectDataTable("EXEC sp_LocationMaster 'Insert','0','" + txtLocationName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "','" + ddlprojet.SelectedValue + "'");
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
            dtResult = cls.selectDataTable("EXEC sp_LocationMaster 'Update','" + Request.QueryString["ID"].ToString() + "','" + txtLocationName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "','" + ddlprojet.SelectedValue + "'");
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('LocationMaster.aspx');", true);
                }
            }
        }
    }
    private void clear()
    {
        txtLocationName.Text = "";
    }

    protected void gvrregion_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_LocationMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');", true);
                loadgvdata();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_LocationMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Location Successfully Deleted !!');", true);
                loadgvdata();
            }
        }
    }
}