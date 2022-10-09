using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_ChannelMaster : System.Web.UI.Page
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
                dtData = cls.selectDataTable("EXEC sp_ChannelMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    txtChannelPartnerCode.Text = dtData.Rows[0]["ChannelPartnerCode"].ToString();
                    txtChannelPartnerName.Text = dtData.Rows[0]["ChannerpartnerName"].ToString();
                }
            }
        }
    }
    protected void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_ChannelMaster 'GetAll'");
        gvuom.DataSource = dtData;
        gvuom.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            dtResult = cls.selectDataTable("EXEC sp_ChannelMaster 'Insert','0','" + txtChannelPartnerCode.Text.Trim() + "','" + txtChannelPartnerName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
            dtResult = cls.selectDataTable("EXEC sp_ChannelMaster 'Update','" + Request.QueryString["ID"].ToString() + "','" + txtChannelPartnerCode.Text.Trim() + "','" + txtChannelPartnerName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
    }

    private void clear()
    {
        txtChannelPartnerCode.Text = "";
        txtChannelPartnerName.Text = "";
    }

    protected void gvuom_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_ChannelMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');", true);
                loadgvdata();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_ChannelMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Item Successfully Deleted !!');", true);
                loadgvdata();
            }
        }
    }
}