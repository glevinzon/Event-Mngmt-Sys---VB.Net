<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="about.aspx.vb" Inherits="eventmgnt.about" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/basic.css" rel="stylesheet" />
    <link href="Styles/carousel.css" rel="stylesheet" />
    <link href="Styles/sticky-footer.css" rel="stylesheet" />
    <link href="Styles/justified-nav.css" rel="stylesheet" />
    <style type="text/css">
        

        .row .col-lg-4 {
            margin-bottom: 20px;
            text-align: center;
        }

        .row h2 {
            font-weight: normal;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <link rel="stylesheet" href='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />
        <script type="text/javascript" src='http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
        <script type="text/javascript" src='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
        <div class="navbar-wrapper">
      <div class="container">
          <div class="navbar navbar-inverse navbar-static-top">
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
                            runat="server" class="dropdown-toggle" data-toggle="dropdown" Font-Bold="true" /><span class="caret"></span>
                        <ul class="dropdown-menu">
                            <li>
                                <asp:HyperLink ID="hyperlink4"
                                    NavigateUrl="~/viewprofile.aspx"
                                    Text="View Profile"
                                    runat="server" /></li>
                            <li>
                                <asp:HyperLink ID="hyperlink5"
                                    NavigateUrl="~/profile.aspx"
                                    Text="Edit Profile"
                                    runat="server" /></li>
                            <li>
                                <asp:HyperLink ID="hyperlink7"
                                    NavigateUrl="~/manage.aspx"
                                    Text="Manage Events"
                                    runat="server" /></li>

                        </ul>
                    </div>

                    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" RenderingMode="List"
                        IncludeStyleBlock="false" StaticMenuStyle-CssClass="nav navbar-nav" DynamicMenuStyle-CssClass="dropdown-menu">
                    </asp:Menu>
                </div>
            </div>
        </div>
          </div></div>
        
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
                <li data-target="#myCarousel" data-slide-to="3"></li>
                <li data-target="#myCarousel" data-slide-to="4"></li>
            </ol>
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <asp:Image ToolTip="POSTER" ID="Image1" runat="server" class="first-slide" alt="First slide"></asp:Image>
                    <div class="container">
                        <div class="carousel-caption">
                            <blockquote><h1><asp:Label ID="Label1" runat="server" Text="" Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="WhiteSmoke" /></h1>
                            </blockquote><p><asp:Label ID="Label3" runat="server" Text="" Font-Bold="false" CssClass="eventvenue" Font-Size="1.5em" ForeColor="#00cc00" /> on 
                                <asp:Label ID="Label2" runat="server" Text="" Font-Bold="false" CssClass="eventdate" Font-Size="1.2em" ForeColor="#ff6600" /><br /></p>
                            <p><asp:HyperLink ID="hyperlink8"
                                    Text="Lemme join"
                                    runat="server" class="btn btn-primary" Font-Bold="true" /></p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <asp:Image ToolTip="POSTER" ID="Image2" runat="server" class="second-slide" alt="Second slide"></asp:Image>
                    <div class="container">
                        <div class="carousel-caption">
                            <blockquote><h1><asp:Label ID="Label4" runat="server" Text="" Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="WhiteSmoke" /></h1>
                            </blockquote><p><asp:Label ID="Label5" runat="server" Text="" Font-Bold="false" CssClass="eventvenue" Font-Size="1.5em" ForeColor="#00cc00" /> on 
                                <asp:Label ID="Label6" runat="server" Text="" Font-Bold="false" CssClass="eventdate" Font-Size="1.2em" ForeColor="#ff6600" /><br /></p>
                            <p><asp:HyperLink ID="hyperlink9"
                                    Text="Lemme join"
                                    runat="server" class="btn btn-primary" Font-Bold="true" /></p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <asp:Image ToolTip="POSTER" ID="Image3" runat="server" class="third-slide" alt="Third slide"></asp:Image>
                    <div class="container">
                        <div class="carousel-caption">
                            <blockquote><h1><asp:Label ID="Label7" runat="server" Text="" Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="WhiteSmoke" /></h1>
                            </blockquote><p><asp:Label ID="Label8" runat="server" Text="" Font-Bold="false" CssClass="eventvenue" Font-Size="1.5em" ForeColor="#00cc00" /> on 
                                <asp:Label ID="Label9" runat="server" Text="" Font-Bold="false" CssClass="eventdate" Font-Size="1.2em" ForeColor="#ff6600" /><br /></p>
                            <p><asp:HyperLink ID="hyperlink10"
                                    Text="Lemme join"
                                    runat="server" class="btn btn-primary" Font-Bold="true" /></p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <asp:Image ToolTip="POSTER" ID="Image4" runat="server" class="fourth-slide" alt="Fourth slide"></asp:Image>
                    <div class="container">
                        <div class="carousel-caption">
                            <blockquote><h1><asp:Label ID="Label10" runat="server" Text="" Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="WhiteSmoke" /></h1>
                            </blockquote><p><asp:Label ID="Label11" runat="server" Text="" Font-Bold="false" CssClass="eventvenue" Font-Size="1.5em" ForeColor="#00cc00" /> on 
                                <asp:Label ID="Label12" runat="server" Text="" Font-Bold="false" CssClass="eventdate" Font-Size="1.2em" ForeColor="#ff6600" /><br /></p>
                            <p><asp:HyperLink ID="hyperlink11"
                                    Text="Lemme join"
                                    runat="server" class="btn btn-primary" Font-Bold="true" /></p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <asp:Image ToolTip="POSTER" ID="Image5" runat="server" class="fifth-slide" alt="Fifth slide"></asp:Image>
                    <div class="container">
                        <div class="carousel-caption">
                            <blockquote><asp:Label ID="Label13" runat="server" Text="" Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="WhiteSmoke" /></h1>
                            </blockquote><p><asp:Label ID="Label14" runat="server" Text="" Font-Bold="false" CssClass="eventvenue" Font-Size="1.5em" ForeColor="#00cc00" /> on 
                                <asp:Label ID="Label15" runat="server" Text="" Font-Bold="false" CssClass="eventdate" Font-Size="1.2em" ForeColor="#ff6600" /><br /></p>
                            <p><asp:HyperLink ID="hyperlink12"
                                    NavigateUrl="~/attend.aspx"
                                    Text="Lemme join"
                                    runat="server" class="btn btn-primary" Font-Bold="true" /></p>
                        </div>
                    </div>
                </div>
            </div>
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <!-- /.carousel -->
        <div class="container">
            <div class="well well-lg">
                <!-- Jumbotron -->
                <div class="jumbotron">
                    <h1>Event Management System</h1>
                    <p class="lead">
                        The planning and managing of "events" (banquets, seminars, conferences, athletic competitions, etc.) involves everything from recording the customer's contact information when they first inquire about space to billing them at the completion of their successful event, and everything in between.
                    </p>
                    <p>
                        <asp:HyperLink ID="hyperlink3"
                            NavigateUrl="~/addevent.aspx"
                            Text="Start an event now."
                            runat="server" class="" Font-Size="XX-Large" />
                    </p>
                    or
                    <p>
                        <asp:HyperLink ID="hyperlink6"
                            NavigateUrl="~/default.aspx"
                            Text="Look at the calendar."
                            runat="server" class="" Font-Size="XX-Large" />
                    </p>

                </div>

                <!-- Example row of columns -->
                <div class="row">
                    <div class="col-lg-4">
                        <img class="img-circle" src="Public/Images/glevinzon.jpg" alt="Glevinzon Dapal" width="140" height="140">
                        <h2 style="font-family: great_vibesregular">Developer</h2>
                        <h4 style="font-family: open_sansbold">DAPAL, Glevinzon</h4>

                    </div>
                    <div class="col-lg-4">
                        <img class="img-circle" src="Public/Images/saitama.jpg" alt="Aiyan Philip Jude Rojo" width="140" height="140">
                        <h2 style="font-family: great_vibesregular">Designer</h2>
                        <h4 style="font-family: open_sansbold">ROJO, Aiyan Philip Jude</h4>
                    </div>
                    <div class="col-lg-4">
                        <img class="img-circle" src="Public/Images/cholo.jpg" alt="Pocholo Zoilo Recto" width="140" height="140">
                        <h2 style="font-family: great_vibesregular">Project Manager</h2>
                        <h4 style="font-family: open_sansbold">RECTO, Pocholo Zoilo</h4>

                    </div>
                </div>
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

        <hr />
    </form>
</body>
</html>
