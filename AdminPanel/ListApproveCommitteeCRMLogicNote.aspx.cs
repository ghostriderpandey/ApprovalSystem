using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_ListApproveCommitteeCRMLogicNote : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtData = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        if (!IsPostBack)
        {
            cls.BindDropDownList(ddlprojectname, "EXEC sp_ProjectMaster 'GetAllforddl'", "ProjectName", "ID");
            loadgvUser();
        }
    }
    void loadgvUser()
    {

        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        DataTable dtUser = (DataTable)Session["UserSession"];
        dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_ManageCRMLogicNote 'GetAllforCommitteeApproval',@ID='" + dtUser.Rows[0]["ID"].ToString() + "',@ProjectID='" + ddlprojectname.SelectedValue + "',@ApprovalStatus='" + ddlStatus.SelectedValue + "',@ApprovalTodate='" + txtToApprovalDate.Text + "',@ApprovalFromdate='" + txtFromApprovalDate.Text + "'");
        gvUser.DataSource = dtData;
        gvUser.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void gvUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
        int RowIndex = gvr.RowIndex;
        TextBox txtRemark = (TextBox)gvUser.Rows[RowIndex].FindControl("txtRemark");
        if (e.CommandName == "Approve")
        {
            int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'CRMCommitteeApprove','" + e.CommandArgument + "','" + txtRemark.Text + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('CRM Logic Note Successfully Approved !!');", true);
                loadgvUser();
                if (cls.ExecuteIntScalar("select count(*) from tbl_Notification where IsMail=0 and IsWait=0") > 0)
                {
                    DataTable dtData = new DataTable();
                    dtData = cls.selectDataTable("select a.ID,EmailID,Subject,Body from tbl_Notification a inner join tbl_UserMaster b on a.UserID=b.ID inner join tblUser_Details c on b.ID=c.UserID and c.IsDelete=0 where IsMail=0 and IsWait=0");
                    if (dtData.Rows.Count > 0)
                    {
                        cls.ExecuteQuery("Update tbl_Notification set IsWait=1 where IsWait=0");
                        for (int i = 0; i < dtData.Rows.Count; i++)
                        {
                            cls.GetMail(dtData.Rows[i]["EmailID"].ToString(), dtData.Rows[i]["Subject"].ToString(), dtData.Rows[i]["Body"].ToString());
                            cls.ExecuteQuery("Update tbl_Notification set IsMail=1 where ID='" + dtData.Rows[i]["ID"].ToString() + "'");
                        }
                    }
                }
            }
        }
        else if (e.CommandName == "Reject")
        {
            int count = cls.ExecuteQuery("Exec Sp_ManageApproval 'CRMCommitteeReject','" + e.CommandArgument + "','" + txtRemark.Text + "'");
            if (count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('CRM Logic Note Successfully Rejected !!');", true);
                loadgvUser();
            }
        }
        else if (e.CommandName == "View")
        {
            try
            {
                Export.ExportReport(e.CommandArgument.ToString(), "CRM Logic Note");

            }
            catch (Exception ex)
            {

            }
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        loadgvUser();
    }
}