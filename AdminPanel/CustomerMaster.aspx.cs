using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_CustomerMaster : System.Web.UI.Page
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
                dtData = cls.selectDataTable("EXEC sp_CustomerMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    txtCustomerCode.Text = dtData.Rows[0]["CustomerCode"].ToString();
                    txtCustomerName.Text = dtData.Rows[0]["CustomerName"].ToString();
                }
            }
        }
    }
    protected void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_CustomerMaster 'GetAll'");
        gvcustomermaster.DataSource = dtData;
        gvcustomermaster.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DataTable dtResult = new DataTable();
        if (Request.QueryString["ID"] == null)
        {
            dtResult = cls.selectDataTable("EXEC sp_CustomerMaster 'Insert','0','" + txtCustomerCode.Text.Trim() + "','" + txtCustomerName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (dtResult.Rows.Count > 0)
            {
                string strMessage = dtResult.Rows[0]["Message"].ToString();
                string strStatus = dtResult.Rows[0]["Status"].ToString();
                clear();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.href='CustomerMaster.aspx';", true);
                return;
            }
        }
        else
        {
            dtResult = cls.selectDataTable("EXEC sp_CustomerMaster 'Update','" + Request.QueryString["ID"].ToString() + "','" + txtCustomerCode.Text.Trim() + "','" + txtCustomerName.Text.Trim() + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
            if (dtResult.Rows.Count > 0)
            {
                string strMessage = dtResult.Rows[0]["Message"].ToString();
                string strStatus = dtResult.Rows[0]["Status"].ToString();
                clear();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.href='CustomerMaster.aspx';", true);
                return;
            }
        }
    }

    private void clear()
    {
        txtCustomerCode.Text = "";
        txtCustomerName.Text = "";
    }
    protected void gvcustomermaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_CustomerMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');location.href='CustomerMaster.aspx';", true);
                
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_CustomerMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Item Successfully Deleted !!');location.href='CustomerMaster.aspx';", true);
                
            }
        }
    }
}