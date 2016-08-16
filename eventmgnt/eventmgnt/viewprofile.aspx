<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="viewprofile.aspx.vb" Inherits="eventmgnt.viewprofile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/loading_modal.css" rel="stylesheet" />
    <link href="Styles/sticky-footer.css" rel="stylesheet" />
    <link href="Styles/basic.css" rel="stylesheet" />
    <link rel="stylesheet" href='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />
    <script type="text/javascript" src='http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>

    <style type="text/css">
        .container {
            width: auto;
            max-width: 960px;
            padding: 0 15px;
        }

            .container .text-muted {
                margin: 20px 0;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal" role="form">
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
            <div class="panel panel-default">
                <div class="panel-body">
                    <h1 style="font-family: great_vibesregular;">Personal Information</h1>
                    <div class="form-group">
                        <div class="col-sm-4">
                            
                        </div>
                        <div class="col-sm-4">
                            <asp:Image ToolTip="Profile Picture" ID="Image1" runat="server" Height="100%" Width="100%" class="img-rounded"></asp:Image>
                        </div>
                        <div class="col-sm-4">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3">
                        </div>
                        <div class="col-sm-6">
                            <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
                                Width="100%" BorderColor="Transparent" BorderStyle="Solid" BorderWidth="1px" CellPadding="10">

                                <ItemTemplate>
                                    <br />
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Title")%>' Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="#0b1039" />
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("firstName")%>' Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="#0b1039" />
                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("lastName")%>' Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="#0b1039" /><br />
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("eMail")%>' Font-Bold="true" CssClass="someclass" Font-Size="1.2em" Font-Underline="true" ForeColor="#0b1039" /><br />
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Mobile")%>' Font-Bold="true" CssClass="someclass" Font-Size="1.2em" ForeColor="#0b1039" /><br />
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Address")%>' Font-Bold="true" CssClass="someclass" Font-Size="1.2em" ForeColor="#0b1039" /><br />
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("City")%>' Font-Bold="true" CssClass="someclass" Font-Size="1.2em" ForeColor="#0b1039" />
                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("State")%>' Font-Bold="true" CssClass="someclass" Font-Size="1.2em" ForeColor="#0b1039" />
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("Postcode")%>' Font-Bold="true" CssClass="someclass" Font-Size="1.2em" ForeColor="#0b1039" /><br />
                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("Country")%>' Font-Bold="true" CssClass="someclass" Font-Size="1.2em" ForeColor="#0b1039" /><br />


                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                            </asp:DataList>
                        </div>
                        <div class="col-sm-3">
                        </div>
                    </div>




                </div>

            </div>

        </div>


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

