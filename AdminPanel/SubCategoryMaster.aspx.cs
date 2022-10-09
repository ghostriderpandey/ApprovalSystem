using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_SubCategoryMaster : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            loadgvdata();

        }
    }
    void loadgvdata()
    {
        dtData = cls.selectDataTable("EXEC sp_ItemMaster 'GetAllSubCategoryforGV'");
        gvsubcategory.DataSource = dtData;
        gvsubcategory.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
}