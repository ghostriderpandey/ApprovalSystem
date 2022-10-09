using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

public partial class AdminPanel_UserMaster : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    DataTable TreeDT = new DataTable();
    DataTable dtUser = new DataTable();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        if (!IsPostBack)
        {
            cls.BindDropDownList(ddldepartment, "EXEC sp_DepartmentMaster 'GetAllforddl'", "DepartmentName", "ID");
            cls.BindDropDownList(ddldesignation, "EXEC sp_DesignationMaster 'GetAllforddl'", "DesignationName", "ID");
            cls.BindDropDownList(ddlRole, "EXEC sp_RoleMaster 'GetAllforddl'", "Name", "ID");
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_UserMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    ddlRole.SelectedValue = dtData.Rows[0]["RoleID"].ToString();
                    txtUserName.Text = dtData.Rows[0]["UserName"].ToString();
                    ddldepartment.SelectedValue = dtData.Rows[0]["DepartmentID"].ToString();
                    ddldesignation.SelectedValue = dtData.Rows[0]["DesignationID"].ToString();
                    txtaddress.Text = dtData.Rows[0]["Address"].ToString();
                    txtPassword.Attributes["value"] = dtData.Rows[0]["Pass"].ToString();
                    txtfinanciallimit.Text = dtData.Rows[0]["FinancialLimit"].ToString();
                    if (dtData.Rows[0]["ConceptApprover"].ToString() == rdyes.Text)
                    {
                        rdyes.Checked = true;
                    }
                    else if (dtData.Rows[0]["ConceptApprover"].ToString() == rdno.Text)
                    {
                        rdno.Checked = true;
                    }
                    txtUserID.Text = dtData.Rows[0]["UserID"].ToString();
                    btnsave.Text = "Update";
                    BindTree("GetEmployeeRights", Convert.ToInt32(ddlRole.SelectedValue), Convert.ToInt32(Request.QueryString["ID"].ToString()));
                }
                FillDt(Request.QueryString["ID"].ToString());
            }
            else
            {
                BindTree("GetEmployeeRights", Convert.ToInt32(ddlRole.SelectedValue), 0);
                FillDt("0");
            }
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        SetData();
        dtUser = (DataTable)Session["UserSession"];
        string MenuIDStr = "";
        foreach (TreeNode node in TreeMenu.CheckedNodes)
        {
            MenuIDStr = MenuIDStr + node.Value + ",";
        }
        DataTable dtDetails = new DataTable();
        if (ViewState["dtDetails"] != null)
        {
            dtDetails = (DataTable)ViewState["dtDetails"];
        }
        string strImageurl = "";
        string conceptapprove = "";
        if (rdyes.Checked == true)
        {
            conceptapprove = rdyes.Text;
        }
        else if (rdno.Checked == true)
        {
            conceptapprove = rdno.Text;
        }
        DataTable dtResult = new DataTable();
        if (btnsave.Text == "Submit")
        {
            try
            {
                string strID = cls.ExecuteStringScalar("select MAX(ID)+1 from tbl_UserMaster");
                if (fuimage.HasFile)
                {
                    strImageurl = UploadImage(strID, fuimage);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_UserMaster"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@UserName", txtUserName.Text);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddldepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@DesignationID", ddldesignation.SelectedValue);
                        cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                        cmd.Parameters.AddWithValue("@UserID", txtUserID.Text);
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                        cmd.Parameters.AddWithValue("@ImageUrl", strImageurl);
                        cmd.Parameters.AddWithValue("@FinancialLimit", txtfinanciallimit.Text);
                        cmd.Parameters.AddWithValue("@ConceptApprover", conceptapprove);
                        cmd.Parameters.AddWithValue("@RoleID", ddlRole.SelectedValue);
                        cmd.Parameters.AddWithValue("@Menustr", MenuIDStr);
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@UserDetails", dtDetails);
                        con.Open();
                        SqlDataAdapter adp = new SqlDataAdapter(cmd);
                        adp.Fill(dtResult);
                        con.Close();
                    }
                }
                if (dtResult.Rows.Count > 0)
                {
                    string strMessage = dtResult.Rows[0]["Message"].ToString();
                    string strStatus = dtResult.Rows[0]["Status"].ToString();
                    if (strStatus == "0")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "')", true);
                        //clear();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('ListUser.aspx');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Something Wrong Please Contact to Admin');location.replace('DashBoard.aspx');", true);
            }
        }
        else if (Request.QueryString["ID"] != null)
        {
            try
            {
                if (fuimage.HasFile)
                {
                    strImageurl = UploadImage(Request.QueryString["ID"].ToString(), fuimage);
                }
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_UserMaster"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@UserName", txtUserName.Text);
                        cmd.Parameters.AddWithValue("@DepartmentID", ddldepartment.SelectedValue);
                        cmd.Parameters.AddWithValue("@DesignationID", ddldesignation.SelectedValue);
                        cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                        cmd.Parameters.AddWithValue("@UserID", txtUserID.Text);
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                        cmd.Parameters.AddWithValue("@ImageUrl", strImageurl);
                        cmd.Parameters.AddWithValue("@FinancialLimit", txtfinanciallimit.Text);
                        cmd.Parameters.AddWithValue("@ConceptApprover", conceptapprove);
                        cmd.Parameters.AddWithValue("@RoleID", ddlRole.SelectedValue);
                        cmd.Parameters.AddWithValue("@Menustr", MenuIDStr);
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@UserDetails", dtDetails);
                        con.Open();
                        SqlDataAdapter adp = new SqlDataAdapter(cmd);
                        adp.Fill(dtResult);
                        con.Close();
                    }
                }
                if (dtResult.Rows.Count > 0)
                {
                    string strMessage = dtResult.Rows[0]["Message"].ToString();
                    string strStatus = dtResult.Rows[0]["Status"].ToString();
                    if (strStatus == "0")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "')", true);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('ListUser.aspx');", true);
                    }
                }
            }
            catch
            { }
        }
    }
    private string UploadImage(string strID, FileUpload FileUploader)
    {
        string url = "";
        if (FileUploader.HasFile)
        {
            System.IO.FileInfo info = new System.IO.FileInfo(FileUploader.PostedFile.FileName.ToString());
            string strname = strID + info.Extension.ToLower();
            url = strname;
            FileUploader.PostedFile.SaveAs(Server.MapPath("../Upload/UserImages/") + strname);
        }
        return url;
    }
    private void clear()
    {
        ddlRole.SelectedValue = "0";
        txtUserName.Text = "";
        txtaddress.Text = "";
        txtUserID.Text = "";
        txtPassword.Text = "";
        BindTree("GetRoleRights", 0, 0);
        btnsave.Text = "Submit";
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    protected void TreeMenu_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        ShowData(e.Node);
    }
    public void BindTree(string str, int roleid, int userid)
    {
        TreeMenu.Nodes.Clear();
        TreeDT = cls.GetDataTable("exec [sp_ManageMenuRights] '" + str + "','" + roleid + "','" + userid + "'");
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

    protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Request.QueryString["ID"] != null)
        {
            BindTree("GetEmployeeRights", Convert.ToInt32(ddlRole.SelectedValue), Convert.ToInt32(Request.QueryString["ID"].ToString()));
        }
        else
        {
            BindTree("GetEmployeeRights", Convert.ToInt32(ddlRole.SelectedValue), 0);
        }
    }

    protected void grdUserDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            AddNew();
        }

        if (e.CommandName == "Delete")
        {
            SetData();
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int RowIndex = gvr.RowIndex;

            if (e.CommandArgument.ToString() == "0")
            {
                DataTable dtData = (DataTable)ViewState["dtDetails"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetails"] = dtData;
                grdUserDetails.DataSource = dtData;
                grdUserDetails.DataBind();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_UserMaster 'DeleteDetails','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetails"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetails"] = dtData;
                grdUserDetails.DataSource = dtData;
                grdUserDetails.DataBind();
            }
        }
    }

    protected void grdUserDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    private void AddNew()
    {
        if (ViewState["dtDetails"] != null)
        {
            SetData();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["MobileNo"] = "";
            dr["EmailID"] = "";
            dt.Rows.Add(dr);

            ViewState["dtDetails"] = dt;
            grdUserDetails.DataSource = dt;
            grdUserDetails.DataBind();
        }
        else
        {
            FillDt("0");
            AddNew();
        }
    }
    private void SetData()
    {
        if (ViewState["dtDetails"] != null)
        {
            int rowindex = 0;
            DataTable dtData = (DataTable)ViewState["dtDetails"];
            dt = dtData.Clone();
            DataRow dr;
            if (dtData.Rows.Count > 0)
            {
                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    HiddenField hddID = (HiddenField)grdUserDetails.Rows[rowindex].Cells[0].FindControl("hddID");
                    TextBox txtMobile = (TextBox)grdUserDetails.Rows[rowindex].Cells[1].FindControl("txtMobile");
                    TextBox txtEmail = (TextBox)grdUserDetails.Rows[rowindex].Cells[2].FindControl("txtEmail");
                    dr = dt.NewRow();
                    dr["ID"] = hddID.Value;
                    dr["MobileNo"] = txtMobile.Text;
                    dr["EmailID"] = txtEmail.Text;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetails"] = dt;
                grdUserDetails.DataSource = dt;
                grdUserDetails.DataBind();
            }
        }
    }
    private void FillDt(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,MobileNo,EmailID from tblUser_Details where IsDelete=0 and UserID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetails"] = dtData;
        }
        else
        {
            ViewState["dtDetails"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("MobileNo");
            dt.Columns.Add("EmailID");
            ViewState["dtDetails"] = dt;
        }

        dt = (DataTable)ViewState["dtDetails"];
        if (dt.Rows.Count == 0)
        {
            AddNew();
        }
        grdUserDetails.DataSource = dt;
        grdUserDetails.DataBind();
    }

    protected void grdUserDetails_PreRender(object sender, EventArgs e)
    {
        int count = grdUserDetails.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = grdUserDetails.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = grdUserDetails.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }
}