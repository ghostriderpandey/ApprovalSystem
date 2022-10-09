using System;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AdminPanel_AdminPanel : System.Web.UI.MasterPage
{
    cls_connection_new cls = new cls_connection_new();
    DataTable dtmenu = new DataTable();
    DataTable dtUser = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserSession"] != null && Session["dtMenu"] != null)
            {
                dtUser = (DataTable)Session["UserSession"];
                dtmenu = (DataTable)Session["dtMenu"];
                //lblUserName.Text = dtUser.Rows[0]["UserName"].ToString();
                lblUName.Text = dtUser.Rows[0]["UserName"].ToString();
                //lblUMail.Text = dtUser.Rows[0]["EmailID"].ToString();
                DataTable dtmenu1 = dtmenu.Select("MenuLevel=1").CopyToDataTable();
                Repeater1.DataSource = dtmenu1;
                Repeater1.DataBind();
                DataTable dtNotification = new DataTable();
                dtNotification = cls.selectDataTable("select Subject,Body,NoteType,(Case when Datediff(MM,CreatedOn,getdate())>0 then cast(Datediff(MM,CreatedOn,getdate()) as varchar)+' month ago' when Datediff(DD,CreatedOn,getdate())>0 then cast(Datediff(DD,CreatedOn,getdate()) as varchar)+' days ago' when Datediff(HH,CreatedOn,getdate())>0 then cast(Datediff(HH,CreatedOn,getdate()) as varchar)+' hours ago' when Datediff(MI,CreatedOn,getdate())>0 then cast(Datediff(MI,CreatedOn,getdate()) as varchar)+' mins ago' else 'Just now' end) as NotificationTime from tbl_Notification where UserID='" + dtUser.Rows[0]["ID"].ToString() + "' order by CreatedOn desc");
                if (dtNotification.Rows.Count > 0)
                {
                    lblTotalNotification.Text = dtNotification.Rows.Count.ToString();
                    liShowAll.Visible = true;
                    dataNotification.DataSource = dtNotification;
                    dataNotification.DataBind();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater Repeater2 = e.Item.FindControl("Repeater2") as Repeater;
            HiddenField level1 = e.Item.FindControl("hdnlevel1") as HiddenField;
            DataTable dtlevel2 = dtmenu;

            //Users Setting 26
            DataRow[] foundRows;
            foundRows = dtlevel2.Select("ParentID='" + level1.Value + "' AND MenuLevel=2");
            if (foundRows.Length > 0)
            {
                dtlevel2 = dtlevel2.Select("ParentID='" + level1.Value + "' AND MenuLevel=2").CopyToDataTable();
                if (dtlevel2.Rows.Count > 0)
                {
                    Repeater2.DataSource = dtlevel2;
                    Repeater2.DataBind();
                }

            }
        }
    }

    protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater Repeater3 = e.Item.FindControl("Repeater3") as Repeater;
            HiddenField level2 = e.Item.FindControl("hdnlevel2") as HiddenField;
            DataTable dtlevel3 = dtmenu;
            DataRow[] foundRows;

            foundRows = dtlevel3.Select("ParentID='" + level2.Value + "' AND MenuLevel=3");
            if (foundRows.Length > 0)
            {
                dtlevel3 = dtlevel3.Select("ParentID='" + level2.Value + "' AND MenuLevel=3").CopyToDataTable();
                if (dtlevel3.Rows.Count > 0)
                {
                    Repeater3.DataSource = dtlevel3;
                    Repeater3.DataBind();

                }
            }
        }
    }
}
