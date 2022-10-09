<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="AdminPanel_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Approval System </title>
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet" />
    <link href="../vendors/animate.css/animate.min.css" rel="stylesheet" />
    <link href="../build/css/custom.min.css" rel="stylesheet" />
    <style>
        .form-control {
            border-radius: 3px;
            -ms-box-shadow: 0 1px 0 #fff,0 -2px 5px rgba(0,0,0,0.08) inset;
            -o-box-shadow: 0 1px 0 #fff,0 -2px 5px rgba(0,0,0,0.08) inset;
            box-shadow: 0 1px 0 #fff, 0 -2px 5px rgba(0,0,0,0.08) inset;
            border: 1px solid #c8c8c8;
            color: #777;
            margin: 0 0 20px;
            width: 100%;
        }
    </style>
</head>
<body style="background-image: url('images/bg.jpg'); background-repeat: no-repeat; background-size: cover;">
    <form id="form1" runat="server">
        <div>
            <a class="hiddenanchor" id="signup"></a>
            <a class="hiddenanchor" id="signin"></a>
            <div class="login_wrapper">
                <div class="animate form login_form" style="padding: 20px; background-color: #a5e3aaad;">
                    <section class="login_content">
                        <img src="images/logo_m3m.png" width="200" height="100" />
                        <h1>Login</h1>
                        <div>
                            <asp:TextBox ID="txtUserName" runat="server" class="form-control" placeholder="Username" required></asp:TextBox>
                        </div>
                        <div>
                            <asp:TextBox ID="txtPassword" runat="server" class="form-control" TextMode="Password" placeholder="Password" required></asp:TextBox>
                        </div>
                        <div>
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success submit" Text="Login" OnClick="btnSubmit_Click" />
                            <a class="reset_pass" href="ForgotPassword.aspx">Lost your password?</a>
                        </div>
                        <div class="clearfix"></div>
                        <div class="separator">
                            <div class="clearfix"></div>
                            <br />
                            <div>
                                <h1><i class="fa fa-paw"></i>Approval System</h1>
                                <p>©2020 All Rights Reserved. Approval System</p>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </form>
</body>
</html>