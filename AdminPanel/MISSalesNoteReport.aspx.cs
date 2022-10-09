﻿using System;
using System.Data;
using System.Web.UI;

public partial class AdminPanel_MISSalesNoteReport : System.Web.UI.Page
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
            LoadgvMISSalesNoteReport();
        }
    }
    protected void LoadgvMISSalesNoteReport()
    {
        if (Session["UserSession"] == null)
        {
            Response.Redirect("Default.aspx");
            return;
        }
        DataTable dtUser = (DataTable)Session["UserSession"];
        dtData = new DataTable();
        dtData = cls.selectDataTable("EXEC sp_ManageSalesLogicNote 'GetAllMisReport','" + dtUser.Rows[0]["ID"].ToString() + "',@ProjectID='" + ddlprojectname.SelectedValue + "',@ApprovalStatus='" + ddlStatus.SelectedValue + "',@ApprovalTodate='" + txtToApprovalDate.Text + "',@ApprovalFromdate='" + txtFromApprovalDate.Text + "'");
        gvMISSalesNoteReport.DataSource = dtData;
        gvMISSalesNoteReport.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fnn();", true);
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadgvMISSalesNoteReport();
    }
}