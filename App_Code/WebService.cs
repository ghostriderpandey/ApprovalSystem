using System;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
/// <summary>
/// Summary description for WebService1
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadCRMImage()
    {

        cls_connection_new cls = new cls_connection_new();
        string fileName = "";
        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedImage"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                cls.ExecuteQuery("insert into tblError_Log(Error)values('" + fileName + "')");
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/CRM/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }

            }
        }
        catch (Exception ex)
        {
            cls.ExecuteQuery("insert into tblError_Log(Error)values('" + ex.Message.ToString() + "')");
        }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));
    }

    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadCRMFile()
    {
        string fileName = "";

        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/CRM/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }
            }
        }
        catch { }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));

    }
    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadSLNImage()
    {


        string fileName = "";
        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedImage"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/SLN/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }

            }
        }
        catch { }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));
    }

    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadSLNFile()
    {
        string fileName = "";

        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/SLN/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }
            }
        }
        catch { }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));

    }

    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadMLNImage()
    {
        string fileName = "";
        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedImage"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/MLN/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }

            }
        }
        catch { }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));
    }

    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadMLNFile()
    {
        string fileName = "";

        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/MLN/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }
            }
        }
        catch { }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));

    }

    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadMSLNImage()
    {
        cls_connection_new cls = new cls_connection_new();
        string fileName = "";
        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedImage"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                cls.ExecuteQuery("insert into tblError_Log(Error)values('" + fileName + "')");
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/MSLN/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }
            }
        }
        catch (Exception ex) { cls.ExecuteQuery("insert into tblError_Log(Error)values('" + ex.Message.ToString() + "')"); }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));
    }

    [ScriptMethod]
    [WebMethod(EnableSession = true)]
    public void UploadMSLNFile()
    {
        string fileName = "";

        try
        {
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                // Get the uploaded image from the Files collection
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
                fileName = Convert.ToString(HttpContext.Current.Request.QueryString["FileName"]);
                if (httpPostedFile != null)
                {
                    string path = HttpContext.Current.Server.MapPath("~/Upload/MSLN/");
                    string fileNameWitPath = path + fileName;
                    httpPostedFile.SaveAs(fileNameWitPath);
                }
            }
        }
        catch { }
        JavaScriptSerializer js = new JavaScriptSerializer();
        FilData o = new FilData();
        o.fileName = fileName;
        Context.Response.Write(js.Serialize(o));

    }


}
public class FilData
{
    public string fileName { get; set; }
}