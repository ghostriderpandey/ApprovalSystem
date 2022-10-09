using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;


public partial class AdminPanel_MenuMaster : System.Web.UI.Page
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
            cls.BindDropDownList(ddlp1, "EXEC sp_MenuMaster 'Fillddllevel1'", "MenuName", "MenuID");
            ddlp1_SelectedIndexChanged(null, null);
            loadgvdata();
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_MenuMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    txtmenuname.Text = dtData.Rows[0]["MenuName"].ToString();
                    ddllevel.SelectedValue = dtData.Rows[0]["MenuLevel"].ToString();
                    ddllevel_SelectedIndexChanged(null, null);
                    if (ddllevel.SelectedValue == "2")
                    {
                        ddlp1.SelectedValue = dtData.Rows[0]["ParentID"].ToString();
                    }
                    else if (ddllevel.SelectedValue == "3")
                    {
                        ddlp1.SelectedValue = cls.ExecuteStringScalar("EXEC sp_MenuMaster 'GetParentbyParent','" + dtData.Rows[0]["ParentID"].ToString() + "'");
                        ddlp1_SelectedIndexChanged(null, null);
                        ddlp2.SelectedValue = dtData.Rows[0]["ParentID"].ToString();
                    }
                    txtlink.Text = dtData.Rows[0]["MenuLink"].ToString();
                    txtPosition.Text = dtData.Rows[0]["Position"].ToString();
                    txtCssClass.Text = dtData.Rows[0]["CssClass"].ToString();
                    btnSubmit.Text = "Update";
                }
            }
        }
    }
    protected void ddllevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt32(ddllevel.SelectedValue) == 1)
        {
            rfvParent1.Visible = false;
            rfvParent2.Visible = false;
            ddlp1.SelectedValue = "0";
            ddlp2.SelectedValue = "0";
            ddlp1.Enabled = false;
            ddlp2.Enabled = false;
        }
        else if (Convert.ToInt32(ddllevel.SelectedValue) == 2)
        {
            rfvParent1.Visible = true;
            rfvParent2.Visible = false;
            ddlp2.SelectedValue = "0";
            ddlp1.Enabled = true;
            ddlp2.Enabled = false;
        }
        else if (Convert.ToInt32(ddllevel.SelectedValue) == 3)
        {
            rfvParent1.Visible = true;
            rfvParent2.Visible = true;
            ddlp1.Enabled = true;
            ddlp2.Enabled = true;
        }
    }

    protected void ddlp1_SelectedIndexChanged(object sender, EventArgs e)
    {
        cls.BindDropDownList(ddlp2, "EXEC sp_MenuMaster 'FillddlbyParent',0,'','',0,'" + ddlp1.SelectedValue + "'", "MenuName", "MenuID");
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        string ParentID = "0";
        if (ddllevel.SelectedValue == "1")
        {
            ParentID = "0";
        }
        else if (ddllevel.SelectedValue == "2")
        {
            ParentID = ddlp1.SelectedValue;
        }
        else if (ddllevel.SelectedValue == "3")
        {
            ParentID = ddlp2.SelectedValue;
        }

        DataTable dtResult = new DataTable();
        if (btnSubmit.Text == "Submit")
        {
            dtResult = cls.selectDataTable("EXEC sp_MenuMaster 'Insert',0,'" + txtmenuname.Text + "','" + txtlink.Text + "','" + ddllevel.SelectedValue + "','" + ParentID + "','" + txtPosition.Text + "','" + txtCssClass.Text + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');fnn();", true);
                    loadgvdata();
                    clear();
                }
            }
        }
        else if (Request.QueryString["ID"] != null)
        {
            dtResult = cls.selectDataTable("EXEC sp_MenuMaster 'Update','" + Request.QueryString["ID"].ToString() + "','" + txtmenuname.Text + "','" + txtlink.Text + "','" + ddllevel.SelectedValue + "','" + ParentID + "','" + txtPosition.Text + "','" + txtCssClass.Text + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('MenuMaster.aspx');", true);
                }
            }
        }
    }

    void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_MenuMaster 'GetAll'");
        gvrmenu.DataSource = dtData;
        gvrmenu.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    private void clear()
    {
        txtmenuname.Text = "";
        ddllevel.SelectedValue = "0";
        ddllevel_SelectedIndexChanged(null, null);
        ddlp1.SelectedValue = "0";
        ddlp1_SelectedIndexChanged(null, null);
        txtlink.Text = "";
        txtPosition.Text = "";
        txtCssClass.Text = "";
        btnSubmit.Text = "Submit";
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("MenuMaster.aspx");
    }

    protected void gvrmenu_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_MenuMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');fnn();", true);
                loadgvdata();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_MenuMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Menu Successfully Deleted !!');fnn();", true);
                loadgvdata();
            }
        }
    }
}