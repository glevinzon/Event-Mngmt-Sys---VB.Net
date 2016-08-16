<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="signin.aspx.vb" Inherits="eventmgnt.signin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/signin.css" rel="stylesheet" />
    <link href="Styles/css/bootstrap.min.css" rel="stylesheet" />
    <style type="text/css">
        .nav-tabs a, .nav-tabs a:hover, .nav-tabs a:focus {
            outline: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-signin">
        <div class="container">
            <asp:Login ID="Login1" runat="server" OnAuthenticate="ValidateUser">
                <LayoutTemplate>
                    <h2 class="form-signin-heading">Please sign in</h2>
                    <asp:TextBox type="text" class="form-control" placeholder="Username" ID="UserName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                    <br>
                    <asp:TextBox type="password" class="form-control" placeholder="Password" ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                    <br>
                    <asp:Button class="btn btn-lg btn-primary btn-block" ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1"></asp:Button>
                    <br />
                    <asp:HyperLink ID="hyperlink1"
                        NavigateUrl="~/register.aspx"
                        Text="Create an account!"
                        runat="server" class="navbar-link" Font-Bold="true" />
                    <br>
                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>

                </LayoutTemplate>
            </asp:Login>
        </div>

        <!-- /container -->
    </form>
</body>
</html>
