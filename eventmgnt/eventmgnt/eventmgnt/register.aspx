<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="register.aspx.vb" Inherits="eventmgnt.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/basic.css" rel="stylesheet" />
    <meta charset="utf-8">
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal" role="form">
        <link rel="stylesheet" href='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />
        <script type="text/javascript" src='http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
        <script type="text/javascript" src='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
        <div class="navbar navbar-inverse">

            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                        aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span><span
                            class="icon-bar"></span><span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">slashEvent</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <p class="navbar-text navbar-right">
                        [<asp:LoginStatus ID="LoginStatus1" runat="server" />
                        ]
                    </p>
                    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" RenderingMode="List"
                        IncludeStyleBlock="false" StaticMenuStyle-CssClass="nav navbar-nav" DynamicMenuStyle-CssClass="dropdown-menu" Style="font-family: ;">
                    </asp:Menu>


                </div>

            </div>
        </div>
        <div class="container">
            <div class="form-group">

                <div class="col-sm-6">
                    <div class="well">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="well">
                        <h2>Create an account.</h2>
                        <h4>Start your journey here and create events hassle-free.</h4>
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="email">Username</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtUsername" runat="server" class="form-control" />
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtUsername"
                                    runat="server" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2" for="email">Password</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" class="form-control" />
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtPassword"
                                    runat="server" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2" for="email">Confirm Password</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" class="form-control" />
                            </div>
                            <div class="col-sm-2">
                                <asp:CompareValidator ID="CompareValidator1" ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtPassword"
                                    ControlToValidate="txtConfirmPassword" runat="server" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2" for="email">Email</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtEmail" runat="server" class="form-control" />
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                    ControlToValidate="txtEmail" runat="server" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2"></div>
                            <div class="col-sm-10">
                                <asp:Button ID="Button1" Text="Submit" runat="server" OnClick="RegisterUser" class="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <script type="text/javascript">
            //Disable the default MouseOver functionality of ASP.Net Menu control.
            Sys.WebForms.Menu._elementObjectMapper.getMappedObject = function () {
                return false;
            };
            $(function () {
                //Remove the style attributes.
                $(".navbar-nav li, .navbar-nav a, .navbar-nav ul").removeAttr('style');

                //Apply the Bootstrap class to the SubMenu.
                $(".dropdown-menu").closest("li").removeClass().addClass("dropdown-toggle");

                //Apply the Bootstrap properties to the SubMenu.
                $(".dropdown-toggle").find("a").eq(0).attr("data-toggle", "dropdown").attr("aria-haspopup", "true").attr("aria-expanded", "false").append("<span class='caret'></span>");

                //Apply the Bootstrap "active" class to the selected Menu item.
                $("a.selected").closest("li").addClass("active");
                $("a.selected").closest(".dropdown-toggle").addClass("active");
            });
        </script>
    </form>
</body>
</html>
