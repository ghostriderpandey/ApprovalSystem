using System;
using System.Data;

public partial class AdminPanel_Dashboard : System.Web.UI.Page
{
    cls_connection_new cls = new cls_connection_new();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserSession"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            DataTable dtUser = (DataTable)Session["UserSession"];
            fill_Dashboard();
        }
    }
    private void fill_Dashboard()
    {
        DataTable dtUser = (DataTable)Session["UserSession"];
        DataTable dtDashboard = new DataTable();
        dtDashboard = cls.selectDataTable("EXEC sp_DashboardData 'Dashboard','" + dtUser.Rows[0]["ID"].ToString() + "'");
        if (dtDashboard.Rows.Count > 0)
        {
            lblTotalUsers.Text = dtDashboard.Rows[0]["TotalUsers"].ToString();
            lblTotalPurchaseLogicNote.Text = dtDashboard.Rows[0]["TotalPurchaseLogicNote"].ToString();
            lblTotalPendingPurchaseLogicNote.Text = dtDashboard.Rows[0]["TotalPendingPurchaseLogicNote"].ToString();
            lblTotalApprovedPurchaseLogicNote.Text = dtDashboard.Rows[0]["TotalApprovedPurchaseLogicNote"].ToString();
            lblTotalPurchaseAmendmentNote.Text = dtDashboard.Rows[0]["TotalPurchaseAmendmentNote"].ToString();
            lblTotalPendingPurchaseAmendmentNote.Text = dtDashboard.Rows[0]["TotalPendingPurchaseAmendmentNote"].ToString();
            lblTotalApprovedPurchaseAmendmentNote.Text = dtDashboard.Rows[0]["TotalApprovedPurchaseAmendmentNote"].ToString();
            lblTotalContractLogicNote.Text = dtDashboard.Rows[0]["TotalContractLogicNote"].ToString();
            lblTotalPendingContractLogicNote.Text = dtDashboard.Rows[0]["TotalPendingContractLogicNote"].ToString();
            lblTotalApprovedContractLogicNote.Text = dtDashboard.Rows[0]["TotalApprovedContractLogicNote"].ToString();
            lblTotalContractAmendmentNote.Text = dtDashboard.Rows[0]["TotalContractAmendmentNote"].ToString();
            lblTotalPendingContractAmendmentNote.Text = dtDashboard.Rows[0]["TotalPendingContractAmendmentNote"].ToString();
            lblTotalApprovedContractAmendmentNote.Text = dtDashboard.Rows[0]["TotalApprovedContractAmendmentNote"].ToString();
        }
    }
}