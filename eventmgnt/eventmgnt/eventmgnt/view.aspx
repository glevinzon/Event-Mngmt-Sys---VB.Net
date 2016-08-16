<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="view.aspx.vb" Inherits="eventmgnt.view" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/basic.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
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
                            <li><asp:HyperLink ID="hyperlink4"
                            NavigateUrl="~/viewprofile.aspx"
                            Text="View Profile"
                            runat="server"  /></li>
                            <li><asp:HyperLink ID="hyperlink5"
                            NavigateUrl="~/profile.aspx"
                            Text="Edit Profile"
                            runat="server"  /></li>
                            <li><asp:HyperLink ID="hyperlink8"
                            NavigateUrl="~/webadmin.aspx"
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
            <div class="form-group">
                <div class="col-sm-8">
                    <div class="well">
                        <asp:Image ToolTip="POSTER" ID="Image1" runat="server" class="img-fluid img-responsive" alt="POSTER"></asp:Image>

                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="well">
                        <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
                            Width="100%" BorderColor="Transparent" BorderStyle="Solid" BorderWidth="1px" CellPadding="10">

                            <ItemTemplate>
                                <br />
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name")%>' Font-Bold="true" CssClass="eventtitle" Font-Size="1.9em" ForeColor="#0b1039" />
                                by 
                                <asp:HyperLink ID="hlcreator"
                                    Text='<%# Eval("userName")%>'
                                    runat="server" class="btn btn-primary" Font-Bold="true" CssClass="eventtitle" Font-Size="1.1em" ForeColor="#ff66ff" />
                                </div>
                                <br />
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Venue")%>' Font-Bold="false" CssClass="eventvenue" Font-Size="1.5em" ForeColor="#00cc00" /><br />
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Date")%>' Font-Bold="false" CssClass="eventdate" Font-Size="1.2em" ForeColor="#ff6600" /><br />
                                &#8369;
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Fee")%>' Font-Bold="false" CssClass="eventfee" Font-Size="1.2em" ForeColor="#660033" /><br />


                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                        </asp:DataList>
                        <hr />
                        <div class="form-group">
                            <div class="col-sm-4">
                                <asp:HyperLink ID="hyperlink3"
                                    NavigateUrl="~/attend.aspx"
                                    Text="Lemme join"
                                    runat="server" class="btn btn-primary" Font-Bold="true" />
                            </div>
                            <div class="col-sm-3">
                                <asp:HyperLink ID="hyperlink6"
                                    NavigateUrl="~/manage.aspx"
                                    Text="Manage"
                                    runat="server" class="btn btn-info" Font-Bold="true" />
                            </div>
                            <div class="col-sm-5">
                                <asp:HyperLink ID="hyperlink7"
                                    NavigateUrl="~/addevent.aspx"
                                    Text="Create own"
                                    runat="server" class="btn btn-warning" Font-Bold="true" />
                            </div>
                            <hr />
                        </div>



                    </div>

                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-6">
                    <div class="well">
                        <a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseGuests" aria-expanded="false" aria-controls="collapseGuests">
                          Participants
                        </a>
                        
                        <div class="collapse" id="collapseGuests">
                          
                            <asp:GridView ID="GridGuests" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive table-striped" >
                                <Columns>

                                    
                                    <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Title")%>'></asp:Label>
                                        &nbsp
                                        <asp:Label ID="lblCustID" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                          
                        </div>
                        

                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="well">
                        <a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                          Participants
                        </a>
                        
                        <div class="collapse" id="collapseExample">
                          
                            <asp:GridView ID="GVImages" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive table-striped" >
                                <Columns>

                                    
                                    <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Title")%>'></asp:Label>
                                        &nbsp
                                        <asp:Label ID="lblCustID" runat="server" Text='<%# Eval("firstName")%>'></asp:Label>
                                        &nbsp    
                                        <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("lastName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                    <asp:BoundField DataField="payment" HeaderText="Status" ItemStyle-Wrap="true" />
                                    <asp:TemplateField HeaderText="Picture" ItemStyle-Wrap="true">
                                        <ItemTemplate>

                                            <asp:Image ImageUrl='<%# "getProfilePic.aspx?uname=" + Eval("userName") %>' ToolTip="Profile Picture" ID="profpic" runat="server" Height="50px" Width="50px" class="img-responsive" alt="Responsive image"></asp:Image>

                                        </ItemTemplate>

                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" ItemStyle-Wrap="true">
                                        <ItemTemplate>

                                            <asp:HyperLink ID="participant"
                                                NavigateUrl='<%# "~/viewprofile.aspx?uname=" + Eval("userName")%>'
                                                Text="View"
                                                runat="server" /></li>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                          
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

            $(function () {

                $('.toggle').click(function (event) {
                    event.preventDefault();
                    var target = $(this).attr('href');
                    $(target).toggleClass('hidden show');
                });

            });
        </script>


    </form>
</body>
</html>
