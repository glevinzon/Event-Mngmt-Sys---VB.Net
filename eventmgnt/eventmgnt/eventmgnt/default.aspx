<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="eventmgnt._default" %>

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
            <div class="panel panel-default" style="background-color: rgba(255, 255, 255, 0.8);
background: rgba(255, 255, 255, 0.8);
color: rgba(255, 255, 255, 0.8);">
                <div class="panel-body">
                    <asp:DataList ID="dlCalendar" runat="server" RepeatColumns="7" Width="100%" BorderStyle="None" RepeatDirection="Horizontal" OnItemDataBound="dlCalendar_ItemDataBound">

                        <HeaderTemplate>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background-color: #90EE90; height: 20px">
                                <tr>
                                    <td width="33%">
                                        <asp:DropDownList runat="server" ID="cboPrev" AutoPostBack="true" Width="70px" OnSelectedIndexChanged="RfreshData"></asp:DropDownList>
                                        <asp:Label runat="server" ID="lblLeft"></asp:Label>
                                    </td>
                                    <td width="33%" align="center">
                                        <asp:Label runat="server" ID="lblMiddle">
                                        </asp:Label></td>
                                    <td width="33%" align="right">
                                        <asp:Label runat="server" ID="lblRight"></asp:Label>
                                        <asp:DropDownList runat="server" ID="cboNext" Width="70px" AutoPostBack="true" OnSelectedIndexChanged="RfreshData"></asp:DropDownList></td>
                                </tr>
                            </table>
                        </HeaderTemplate>

                        <ItemTemplate>
                            <table border="0" style="background-color: #fba741; height:100px"  width="130px" cellpasdding="0" cellspacing="0" ><tr><td align="left" valign="top"">
        <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Data") %>' Width="100%"></asp:Label>
        </td></tr></table>
                        </ItemTemplate>
                    </asp:DataList>
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
