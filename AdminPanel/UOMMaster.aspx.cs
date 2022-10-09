using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_UOMMaster : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    System.Data.DataTable dtUser = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        dtUser = (DataTable)Session["UserSession"];
        if (!IsPostBack)
        {
            loadgvdata();
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_UOMMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    txtItemCode.Text = dtData.Rows[0]["Code"].ToString();
                    txtItemName.Text = dtData.Rows[0]["Name"].ToString();
                }
            }
        }
    }
    protected void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_UOMMaster 'GETALL'");
        gvuom.DataSource = dtData;
        gvuom.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            dtResult = cls.selectDataTable("EXEC sp_UOMMaster 'InsertUOMforDDL','0','" + txtItemCode.Text.Trim() + "','" + txtItemName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (dtResult.Rows.Count > 0)
            {
                string strMessage = dtResult.Rows[0]["Message"].ToString();
                string strStatus = dtResult.Rows[0]["Status"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.href='UOMMaster.aspx';", true);
                return;
            }
        }
        else
        {
            dtResult = cls.selectDataTable("EXEC sp_UOMMaster 'UpdateUOMforDDL','" + Request.QueryString["ID"].ToString() + "','" + txtItemCode.Text.Trim() + "','" + txtItemName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (dtResult.Rows.Count > 0)
            {
                string strMessage = dtResult.Rows[0]["Message"].ToString();
                string strStatus = dtResult.Rows[0]["Status"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.href='UOMMaster.aspx';", true);
                return;
            }
        }
    }
    private void clear()
    {
        txtItemCode.Text = "";
        txtItemName.Text = "";
    }

    protected void gvuom_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_UOMMaster 'ChangeStatusUOMforDDL','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');location.href='UOMMaster.aspx';", true);
                return;
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_UOMMaster 'DeleteUOMforDDL','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Item Successfully Deleted !!');location.href='UOMMaster.aspx';", true);
                return;
            }
        }
    }
}