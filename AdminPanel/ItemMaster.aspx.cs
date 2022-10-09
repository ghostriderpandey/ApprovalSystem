using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class AdminPanel_ItemMaster : System.Web.UI.Page
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
            cls.BindDropDownList(ddlCategory, "EXEC sp_ItemMaster 'GetAllCategoryforDDL'", "CategoryName", "ID");
            loadgvdata();
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_ItemMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    ddlCategory.SelectedValue = dtData.Rows[0]["CID"].ToString();
                    ddlCategory_SelectedIndexChanged(null, null);
                    ddlSubCategory.SelectedValue = dtData.Rows[0]["SCID"].ToString();
                    txtItemName.Text = dtData.Rows[0]["ItemName"].ToString();
                }
            }
        }
    }
    void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_ItemMaster 'GetAll'");
        gvItem.DataSource = dtData;
        gvItem.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            string query = "EXEC sp_ItemMaster 'Insert','0','" + ddlCategory.SelectedValue + "','" + ddlSubCategory.SelectedValue + "','','" + txtItemName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'";
            dtResult = cls.selectDataTable(query);
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
            dtResult = cls.selectDataTable("EXEC sp_ItemMaster 'Update'," + Convert.ToInt32(Request.QueryString["ID"].ToString()) + ",'" + ddlCategory.SelectedValue + "','" + ddlSubCategory.SelectedValue + "','','" + txtItemName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('ItemMaster.aspx');", true);
                }
            }
        }
    }
    private void clear()
    {
        ddlCategory.SelectedValue = "0";
        ddlCategory_SelectedIndexChanged(null, null);
        txtItemName.Text = "";
    }

    protected void gvrregion_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_ItemMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');", true);
                loadgvdata();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_ItemMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Item Successfully Deleted !!');", true);
                loadgvdata();
            }
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        cls.BindDropDownList(ddlSubCategory, "EXEC sp_ItemMaster 'GetAllSubCategoryforDDL','" + ddlCategory.SelectedValue + "'", "SubCategoryName", "ID"); ;
    }
}