using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI.WebControls;

public class cls_connection_new
{
    HttpContext ctx = HttpContext.Current;
    DataSet ds = new DataSet();

    DataTable dt = new DataTable();
    SqlCommand cmd;
    static string connString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["Connection_str"].ConnectionString;
    DbCommand dbcommand;
    SqlDatabase db = new SqlDatabase(connString);
    public static SqlConnection scon = new SqlConnection(connString);
    private string _loginname, _password, _action, _IpAddress;
    public string success = "success";
    public string fail = "fail";
    public string pending = "pending";

    public cls_connection_new()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string Connection1()
    {
        try
        {
            string str = connString;
            return str;
        }
        catch (Exception ex)
        {
            return "";
        }
    }
    public void CreateConnection()
    {
        if (scon.State != ConnectionState.Open)
        {
            scon.Open();
        }
    }
    public void CloseConnection()
    {
        scon.Close();
    }
    public void GetMail(string EmailID, string Subject, string Body)
    {
        string To = EmailID;
        SmtpClient smtpClient = new SmtpClient();
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
        NetworkCredential networkCredential = new NetworkCredential("smartworldapproval@gmail.com", "sw@12345");
        MailMessage message = new MailMessage();
        MailAddress mailAddress = new MailAddress("smartworldapproval@gmail.com");
        smtpClient.Host = "smtp.gmail.com";
        smtpClient.Port = 587;//587
        smtpClient.EnableSsl = true;
        smtpClient.UseDefaultCredentials = false;
        smtpClient.Credentials = (ICredentialsByHost)networkCredential;
        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
        try
        {
            foreach (string addr in To.Split(';', ','))
            {
                message.To.Add(new MailAddress(addr));                        //" + Email_To + "
            }
            message.From = mailAddress;
            message.Subject = Subject;
            message.IsBodyHtml = true;
            message.Body = Body;
            smtpClient.Send(message);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message.ToString());
        }
    }
    public DataTable selectDataTable(string SQL)
    {
    NEXT1:
        DataTable dtInv = new DataTable();
        try
        {
            dbcommand = db.GetSqlStringCommand(SQL);
            ds = db.ExecuteDataSet(dbcommand);
            if (ds.Tables.Count > 0)
            {
                dtInv = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
        }
        return dtInv;
    }

    public DataSet GetDataSet(string SQL)
    {
        DataSet dsInv = new DataSet();
        try
        {

            dbcommand = db.GetSqlStringCommand(SQL);
            dsInv = db.ExecuteDataSet(dbcommand);
        }
        catch (Exception ex)
        {
            dsInv = null;
        }
        return dsInv;
    }
    public DataTable GetDataTable(string SQL)
    {
        DataTable dtInv = new DataTable();
        try
        {
            dbcommand = db.GetSqlStringCommand(SQL);
            ds = db.ExecuteDataSet(dbcommand);
            if (ds.Tables.Count > 0)
            {
                dtInv = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
            dtInv = null;
        }
        return dtInv;
    }
    public void BindDropDownList(DropDownList ddl, string sql, string TextField, string ValueField)
    {
        DataTable dt = new DataTable();
        dt = GetDataTable(sql);
        ddl.DataSource = dt;
        ddl.DataTextField = TextField;
        ddl.DataValueField = ValueField;
        ddl.DataBind();
        ddl.Items.Insert(0, new ListItem("--Select--", "0"));

    }
    public void BindDropDownListDatatable(DropDownList ddl, DataTable dt, string TextField, string ValueField)
    {

        ddl.DataSource = dt;
        ddl.DataTextField = TextField;
        ddl.DataValueField = ValueField;
        ddl.DataBind();
        ddl.Items.Insert(0, new ListItem("--Select--", "0"));

    }

    public int ExecuteQuery(string qur)
    {
        int Retval = 0;
        dbcommand = db.GetSqlStringCommand(qur);
        Retval = db.ExecuteNonQuery(dbcommand);
        return Retval;
    }

    public int ExecuteScalar(string qur)
    {
        int Retval = 0;
        dbcommand = db.GetSqlStringCommand(qur);
        Retval = Convert.ToInt32(db.ExecuteScalar(dbcommand));
        return Retval;
    }
    public int ExecuteIntScalar(string qur)
    {
        int Retval = 0;
        dbcommand = db.GetSqlStringCommand(qur);
        Retval = Convert.ToInt32(db.ExecuteScalar(dbcommand));
        return Retval;
    }
    public string ExecuteStringScalar(string qur)
    {
        string Retval = string.Empty;
        dbcommand = db.GetSqlStringCommand(qur);
        Retval = Convert.ToString(db.ExecuteScalar(dbcommand));
        return Retval;
    }
    public DataTable LoginAuthentication()
    {
        DataTable dtUserMaste = new DataTable();
        dbcommand = db.GetStoredProcCommand("sp_LoginMaster", action, loginname, password, IpAddress);
        ds = db.ExecuteDataSet(dbcommand);
        dtUserMaste = ds.Tables[0];
        return dtUserMaste;
    }
    public string loginname
    {
        get { return this._loginname; }
        set { this._loginname = value; }
    }
    public string IpAddress
    {
        get { return this._IpAddress; }
        set { this._IpAddress = value; }
    }
    public string password
    {
        get { return this._password; }
        set { this._password = value; }
    }
    public string action
    {
        get { return this._action; }
        set { this._action = value; }
    }

}
