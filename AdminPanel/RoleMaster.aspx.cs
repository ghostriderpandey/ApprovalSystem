using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

public partial class AdminPanel_RoleMaster : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    DataTable TreeDT = new DataTable();
    DataTable dtUser = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Request.UrlReferrer == null)
        //{
        //    Response.Redirect("Default.aspx");
        //    return;
        //}
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        if (!IsPostBack)
        {
            loadRole();
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_RoleMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    txtRolename.Text = dtData.Rows[0]["Name"].ToString();
                    BindTree("GetRoleRights", Convert.ToInt32(dtData.Rows[0]["ID"].ToString()));
                    btnSubmit.Text = "Update";
                }
            }
            else
            {
                BindTree("GetRoleRights", 0);
            }
        }
    }
    void loadRole()
    {
        dtData = cls.selectDataTable("EXEC sp_RoleMaster 'GetAll'");
        gvrRole.DataSource = dtData;
        gvrRole.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        string MenuIDStr = "";
        foreach (TreeNode node in TreeMenu.CheckedNodes)
        {
            MenuIDStr = MenuIDStr + node.Value + ",";
        }
        DataTable dtResult = new DataTable();
        if (btnSubmit.Text == "Submit")
        {
            dtResult = cls.selectDataTable("EXEC sp_RoleMaster 'Insert','0','" + txtRolename.Text.Trim() + "','" + MenuIDStr + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
                    loadRole();
                    clear();
                }
            }
        }
        else if (Request.QueryString["ID"] != null)
        {
            dtResult = cls.selectDataTable("EXEC sp_RoleMaster 'Update','" + Request.QueryString["ID"].ToString() + "','" + txtRolename.Text.Trim() + "','" + MenuIDStr + "','" + dtUser.Rows[0]["ID"].ToString() + "'");
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('RoleMaster.aspx');", true);
                }
            }
        }
    }
    private void clear()
    {
        txtRolename.Text = "";
        BindTree("GetRoleRights", 0);
        btnSubmit.Text = "Submit";
    }

    protected void gvrRole_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IsStatus")
        {
            int count = cls.ExecuteQuery("Exec sp_RoleMaster 'ChangeStatus','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Status Successfully Update !!');", true);
                loadRole();
            }
        }
        else if (e.CommandName == "IsDelete")
        {
            int count = cls.ExecuteQuery("Exec sp_RoleMaster 'Delete','" + e.CommandArgument + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Role Successfully Deleted !!');", true);
                loadRole();
            }
        }
    }

    protected void TreeMenu_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        ShowData(e.Node);
    }
    public void BindTree(string str, int id)
    {
        TreeMenu.Nodes.Clear();
        TreeDT = cls.GetDataTable("exec [sp_ManageMenuRights] '" + str + "','" + id + "'");
        DataRow[] dr = TreeDT.Select("MenuLevel=1");
        for (int i = 0; i < dr.Length; i++)
        {
            TreeNode mNode = new TreeNode();
            mNode.Expanded = false;
            mNode.Text = dr[i]["MenuName"].ToString();
            mNode.Value = dr[i]["MenuID"].ToString();
            mNode.Checked = Convert.ToBoolean(dr[i]["checked"]);
            mNode.SelectAction = TreeNodeSelectAction.Expand;
            mNode.PopulateOnDemand = true;
            TreeMenu.Nodes.Add(mNode);
            mNode.ExpandAll();
        }
        TreeMenu.CollapseAll();
    }
    public void ShowData(TreeNode Tnode)
    {
        DataRow[] drnod = TreeDT.Select("ParentID='" + Tnode.Value + "'");
        for (int j = 0; j < drnod.Length; j++)
        {
            TreeNode nod = new TreeNode();
            nod.Value = drnod[j]["MenuID"].ToString();
            nod.Text = drnod[j]["MenuName"].ToString();
            nod.Checked = Convert.ToBoolean(drnod[j]["Checked"]);
            nod.PopulateOnDemand = true;
            nod.Expanded = false;
            nod.SelectAction = TreeNodeSelectAction.Expand;
            Tnode.ChildNodes.Add(nod);
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("RoleMaster.aspx");
    }
}