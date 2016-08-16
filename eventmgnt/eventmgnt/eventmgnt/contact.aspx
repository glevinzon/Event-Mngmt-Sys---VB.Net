<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="contact.aspx.vb" Inherits="eventmgnt.contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/sticky-footer.css" rel="stylesheet" />
    <link href="Styles/basic.css" rel="stylesheet" />
    <style type="text/css">
        .container {
            width: auto;
            max-width: 680px;
            padding: 0 15px;
        }

            .container .text-muted {
                margin: 20px 0;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
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
                    <asp:HyperLink ID="hyperlink2"
                            NavigateUrl="~/about.aspx"
                            Text="slashEvent"
                            runat="server" class="navbar-brand" Font-Bold="true" />
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <p class="navbar-text navbar-right">
                        <asp:LoginStatus ID="LoginStatus1" runat="server" />
                    </p>
                   
                        
                        <div class="navbar-text navbar-right dropdown">
                            Signed in as
                        <asp:HyperLink ID="hyperlink1"
                            NavigateUrl="~/viewprofile.aspx"
                            Text=""
                            runat="server" class="dropdown-toggle"  data-toggle="dropdown" Font-Bold="true" /><span class="caret"></span>
                        <ul class="dropdown-menu">
                            <li><asp:HyperLink ID="hyperlink3"
                            NavigateUrl="~/viewprofile.aspx"
                            Text="View Profile"
                            runat="server"  /></li>
                            <li><asp:HyperLink ID="hyperlink4"
                            NavigateUrl="~/profile.aspx"
                            Text="Edit Profile"
                            runat="server"  /></li>
                            <li><asp:HyperLink ID="hyperlink5"
                            NavigateUrl="~/manage.aspx"
                            Text="Manage Events"
                            runat="server"  /></li>
                            
                         </ul>
                            </div>
                   
                    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" RenderingMode="List"
                        IncludeStyleBlock="false" StaticMenuStyle-CssClass="nav navbar-nav" DynamicMenuStyle-CssClass="dropdown-menu">
                    </asp:Menu>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="well well-sm">
                <fieldset>

                    <!-- Form Name -->
                    <legend class="eventtitle">Contact Us</legend>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="textinput_name">Name</label>
                        <div class="col-md-6">
                            <input id="textinput_name" name="textinput_name" type="text" placeholder="Juan dela Cruz" class="form-control input-md" required="">
                            <span class="help-block">Full Name</span>
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="textinput_email">Email</label>
                        <div class="col-md-6">
                            <input id="textinput_email" name="textinput_email" type="text" placeholder="email address" class="form-control input-md" required="">
                            <span class="help-block">Email Address</span>
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="textinput_concern">Subject</label>
                        <div class="col-md-6">
                            <input id="textinput_concern" name="textinput_concern" type="text" placeholder="concern" class="form-control input-md" required="">
                            <span class="help-block">Subject Concern</span>
                        </div>
                    </div>

                    <!-- Textarea -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="textarea_message">Message</label>
                        <div class="col-md-4">
                            <textarea class="form-control" id="textarea_message" name="textarea_message"></textarea>
                        </div>
                    </div>

                    <!-- Button -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="singlebutton"></label>
                        <div class="col-md-4">
                            <button id="singlebutton" name="singlebutton" class="btn btn-info">Submit</button>
                        </div>
                    </div>

                </fieldset>
            </div>
            </div>
            <!-- /container -->
            <footer class="footer">
                <div class="container">
                    <p class="text-muted">&copy; Web-based Programming ASP.Net + MS SqlServer</p>
                </div>
            </footer>
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
