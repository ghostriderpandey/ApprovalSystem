using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class AdminPanel_Default2 : System.Web.UI.Page
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
            cls.BindDropDownList(ddlCompany, "EXEC sp_CompanyMaster 'GetAllforddl'", "CompanyName", "ID");
            
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        dtUser = (DataTable)Session["UserSession"];
        DataTable dtResult = new DataTable();
        if (ddlCompany.SelectedIndex!=0)
        {
            dtResult = cls.selectDataTable("EXEC sp_getconnection '" + ddlCompany.SelectedValue + "'");
            if (dtResult.Rows.Count > 0)
            {
                string connectionstring = dtResult.Rows[0]["connectionstring"].ToString();
                SqlConnection con = new SqlConnection(connectionstring);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter("select * from ApplicationMaster where No='"+txtapprovalno.Text.Trim()+"'", con);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    cksubject.Text = ds.Tables[0].Rows[0]["Subject"].ToString();
                    ckapprovalsought.Text = ds.Tables[0].Rows[0]["ApprovalSought"].ToString();
                    ckpaymentschedule.Text = ds.Tables[0].Rows[0]["PaymentSchedule"].ToString();
                    ckamendmentsummary.Text = ds.Tables[0].Rows[0]["AmendmentSummary"].ToString();
                    ckcontractapprovalstatus.Text = ds.Tables[0].Rows[0]["ContractApprovalStatus"].ToString();
                    ckexceptiontopolicy.Text = ds.Tables[0].Rows[0]["ExceptionToPolicy"].ToString();
                }
                else
                {
                    cksubject.Text = ckapprovalsought.Text = ckpaymentschedule.Text = ckamendmentsummary.Text = null;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Approval Detail not found.Please enter valid approval no.');", true);
                }
            }
            else
            {
                cksubject.Text = ckapprovalsought.Text = ckpaymentschedule.Text = ckamendmentsummary.Text = null;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Connection Detail not found.');", true);
            }
        }
    }

    
}