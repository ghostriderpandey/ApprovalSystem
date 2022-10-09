using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

public partial class AdminPanel_CommitteeLevelMaster : System.Web.UI.Page
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
            cls.BindDropDownList(ddlCommitteeName, "EXEC sp_CommitteeMaster 'GetAllforDDL'", "CommitteeName", "ID");
            if (Request.QueryString["ID"] != null)
            {
                dtData = cls.selectDataTable("EXEC sp_CommitteeLevelMaster 'GetByID','" + Request.QueryString["ID"].ToString() + "'");
                if (dtData.Rows.Count > 0)
                {
                    ddlCommitteeName.SelectedValue = dtData.Rows[0]["CID"].ToString();
                    ddlLevel.SelectedValue = dtData.Rows[0]["LevelNo"].ToString();
                    ddlLevel_SelectedIndexChanged(null, null);
                    FillDt(Request.QueryString["ID"].ToString());
                    ddlApprovalRequired.SelectedValue = dtData.Rows[0]["ApprovalRequired"].ToString();
                }
                else
                {
                    FillDt(Request.QueryString["ID"].ToString());
                }
            }
            else
            {
                FillDt("0");
            }
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        SetData();
        DataTable dtResult = new DataTable();
        DataTable dtDetails = new DataTable();
        dtUser = (DataTable)Session["UserSession"];
        if (ViewState["dtDetails"] != null)
        {
            dtDetails = (DataTable)ViewState["dtDetails"];
        }
        if (Request.QueryString["ID"] == null)
        {
            try
            {
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_CommitteeLevelMaster"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Insert");
                        cmd.Parameters.AddWithValue("@ID", "0");
                        cmd.Parameters.AddWithValue("@CID", ddlCommitteeName.SelectedValue);
                        cmd.Parameters.AddWithValue("@LevelNo", ddlLevel.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalRequired", ddlApprovalRequired.SelectedValue);
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@CommitteeUserDetails", dtDetails);
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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('ListCommittee.aspx');", true);
                    }
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Something Wrong Please Contact to Admin');location.replace('DashBoard.aspx');", true);
            }
        }
        else if (Request.QueryString["ID"] != null)
        {
            try
            {
                string consString = cls.Connection1();
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_CommitteeLevelMaster"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@Action", "Update");
                        cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                        cmd.Parameters.AddWithValue("@CID", ddlCommitteeName.SelectedValue);
                        cmd.Parameters.AddWithValue("@LevelNo", ddlLevel.SelectedValue);
                        cmd.Parameters.AddWithValue("@ApprovalRequired", ddlApprovalRequired.SelectedValue);
                        cmd.Parameters.AddWithValue("@ByUserID", dtUser.Rows[0]["ID"].ToString());
                        cmd.Parameters.AddWithValue("@CommitteeUserDetails", dtDetails);
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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + strMessage + "');location.replace('ListCommittee.aspx');", true);
                    }
                }
            }
            catch
            { }
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
    private void AddNew()
    {
        if (ViewState["dtDetails"] != null)
        {
            SetData();
            DataRow dr;
            dr = dt.NewRow();
            dr["ID"] = "0";
            dr["UserID"] = "0";
            dr["IsMandatory"] = false;
            dt.Rows.Add(dr);
            ViewState["dtDetails"] = dt;
            grdCommitteeDetails.DataSource = dt;
            grdCommitteeDetails.DataBind();
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
                    bool bolIsMandatory = false;
                    HiddenField hddID = (HiddenField)grdCommitteeDetails.Rows[rowindex].Cells[0].FindControl("hddID");
                    DropDownList ddlUser = (DropDownList)grdCommitteeDetails.Rows[rowindex].Cells[1].FindControl("ddlUser");
                    CheckBox chkMandatory = (CheckBox)grdCommitteeDetails.Rows[rowindex].Cells[1].FindControl("chkMandatory");
                    bolIsMandatory = chkMandatory.Checked;
                    dr = dt.NewRow();
                    dr["ID"] = hddID.Value;
                    dr["UserID"] = ddlUser.SelectedValue;
                    dr["IsMandatory"] = bolIsMandatory;
                    dt.Rows.Add(dr);
                    rowindex++;
                }
                ViewState["dtDetails"] = dt;
            }
        }
    }
    private void FillDt(string ID)
    {
        DataTable dtData = cls.selectDataTable("select ID,UserID,IsMandatory from tbl_CommitteeUserDetails where IsDelete=0 and CDID='" + ID + "'");
        if (dtData.Rows.Count > 0)
        {
            ViewState["dtDetails"] = dtData;
        }
        else
        {
            ViewState["dtDetails"] = null;
            dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("UserID");
            dt.Columns.Add("IsMandatory", typeof(bool));
            ViewState["dtDetails"] = dt;
        }

        dt = (DataTable)ViewState["dtDetails"];
        grdCommitteeDetails.DataSource = dt;
        grdCommitteeDetails.DataBind();
    }

    protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt32(ddlLevel.SelectedValue) > 0)
        {
            if (cls.ExecuteIntScalar("select count(*) from tbl_CommitteeDetails where IsDelete=0 and LevelNo='" + ddlLevel.SelectedValue + "' and CID='" + ddlCommitteeName.SelectedValue + "'") > 0)
            {
                FillDt(cls.ExecuteStringScalar("select isnull((select top 1 ID from tbl_CommitteeDetails where IsDelete=0 and LevelNo='" + ddlLevel.SelectedValue + "' and CID='" + ddlCommitteeName.SelectedValue + "'),0)"));
            }
            else
            {
                FillDt("0");
                AddNew();
            }
        }
        else
        {
            ViewState["dtDetails"] = null;
            grdCommitteeDetails.DataSource = null;
            grdCommitteeDetails.DataBind();
        }
    }

    private void fillAPRequired(int LevelNo)
    {
        DataTable dtData = new DataTable();
        dtData.Columns.Add("TotalAR");
        dtData.Columns.Add("TotalARValue");
        for (int i = 0; i <= LevelNo; i++)
        {
            DataRow dr = dtData.NewRow();
            if (i == 0)
            {
                dr["TotalAR"] = i.ToString();
                dr["TotalARValue"] = "--Select One--";
            }
            else
            {
                dr["TotalAR"] = i.ToString();
                dr["TotalARValue"] = "Any - " + i.ToString();
            }
            dtData.Rows.Add(dr);
        }

        cls.BindDropDownListDatatable(ddlApprovalRequired, dtData, "TotalARValue", "TotalAR");
    }
    int LevelNo = 0;
    protected void grdCommitteeDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlUser = (e.Row.FindControl("ddlUser") as DropDownList);
            HiddenField hddUserID = (e.Row.FindControl("hddUserID") as HiddenField);
            cls.BindDropDownList(ddlUser, "EXEC sp_UserMaster 'GetAllforddl'", "UserName", "ID");
            ddlUser.SelectedValue = hddUserID.Value;
            LevelNo++;
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            fillAPRequired(LevelNo);
            LevelNo = 0;
        }
    }

    protected void grdCommitteeDetails_RowCommand(object sender, GridViewCommandEventArgs e)
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
                grdCommitteeDetails.DataSource = dtData;
                grdCommitteeDetails.DataBind();
            }
            else
            {
                cls.ExecuteQuery("EXEC sp_CommitteeLevelMaster 'DeleteUsers','" + e.CommandArgument + "'");
                DataTable dtData = (DataTable)ViewState["dtDetails"];
                dtData.Rows.RemoveAt(RowIndex);
                ViewState["dtDetails"] = dtData;
                grdCommitteeDetails.DataSource = dtData;
                grdCommitteeDetails.DataBind();
            }
        }
    }

    protected void grdCommitteeDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void grdCommitteeDetails_PreRender(object sender, EventArgs e)
    {
        int count = grdCommitteeDetails.Rows.Count;
        if (count > 0)
        {
            GridViewRow row = grdCommitteeDetails.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkAdd");
            if (lb != null)
                lb.Visible = true;
        }
        if (count == 1)
        {
            GridViewRow row = grdCommitteeDetails.Rows[count - 1];
            LinkButton lb = (LinkButton)row.FindControl("lnkDelete");
            if (lb != null)
                lb.Visible = false;
        }
    }

    protected void ddlCommitteeName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cls.ExecuteIntScalar("select count(*) from tbl_CommitteeDetails where IsDelete=0 and LevelNo='" + ddlLevel.SelectedValue + "' and CID='" + ddlCommitteeName.SelectedValue + "'") > 0)
        {
            FillDt(cls.ExecuteStringScalar("select isnull((select top 1 ID from tbl_CommitteeDetails where IsDelete=0 and LevelNo='" + ddlLevel.SelectedValue + "' and CID='" + ddlCommitteeName.SelectedValue + "'),0)"));
        }
        else
        {
            FillDt("0");
            AddNew();
        }
    }
}