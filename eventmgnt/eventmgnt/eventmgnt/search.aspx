<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="search.aspx.vb" Inherits="eventmgnt.search" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/basic.css" rel="stylesheet" />
    <link href="Styles/sticky-footer.css" rel="stylesheet" />
    <link href="Styles/search_Table.css" rel="stylesheet" />
    <link rel="stylesheet" href='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />
    <script type="text/javascript" src='http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>

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

    <script src="Scripts/ASPSnippets_Pager.min.js"></script>

    <script type="text/javascript">
        $(function () {
            GetCustomers(1);
        });
        $("[id*=txtSearch]").live("keyup", function () {
            GetCustomers(parseInt(1));
        });
        $(".Pager .page").live("click", function () {
            GetCustomers(parseInt($(this).attr('page')));
        });
        function SearchTerm() {
            return jQuery.trim($("[id*=txtSearch]").val());
        };
        function GetCustomers(pageIndex) {
            $.ajax({
                type: "POST",
                url: "search.aspx/GetCustomers",
                data: '{searchTerm: "' + SearchTerm() + '", pageIndex: ' + pageIndex + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }
        var row;
        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Events");
            if (row == null) {
                row = $("[id*=gvCustomers] tr:last-child").clone(true);
            }
            $("[id*=gvCustomers] tr").not($("[id*=gvCustomers] tr:first-child")).remove();
            if (customers.length > 0) {
                $.each(customers, function () {
                    var customer = $(this);

                    $("td", row).eq(0).html($(this).find("Name").text());

                    var d = new Date($(this).find("DateTime").text());
                    var date = d.getDate();
                    var month = d.getMonth() + 1;
                    var year = d.getFullYear();

                    var hours = d.getHours();
                    var mins = d.getMinutes();

                    var datestring = month + "/" + date + "/" + year + " @ " + hours + ":" + mins;
                    $("td", row).eq(1).html(datestring);

                    var ed = new Date($(this).find("endDateTime").text());
                    var edate = ed.getDate();
                    var emonth = ed.getMonth() + 1;
                    var eyear = ed.getFullYear();

                    var ehours = ed.getHours();
                    var emins = ed.getMinutes();

                    var edatestring = emonth + "/" + edate + "/" + eyear + " @ " + ehours + ":" + emins;
                    $("td", row).eq(2).html(edatestring);
                    $("td", row).eq(3).html($(this).find("Venue").text());
                    $("td", row).eq(4).html($(this).find("Fee").text());
                    var str;
                    if ($(this).find("Approval").text() == "0") {
                        str = "<span class='label label-warning'>Pending</span>";
                    }
                    else if ($(this).find("Approval").text() == "1") {
                        str = "<span class='label label-info'>Verified</span>";
                    }
                    else if ($(this).find("Approval").text() == "2") {
                        str = "<span class='label label-success'>Approved</span>";
                    }
                    else {
                        str = "<span class='label label-danger'>Unidentified</span>";
                    }
                    $("td", row).eq(5).html(str);

                    $("td", row).eq(6).html("<a class='btn btn-info' href=http://localhost:2352/" + "view.aspx?eventId=" + $(this).find("eventId").text() + ">View</a>");
                    $("[id*=gvCustomers]").append(row);
                    row = $("[id*=gvCustomers] tr:last-child").clone(true);
                });
                var pager = xml.find("Pager");
                $(".Pager").ASPSnippets_Pager({
                    ActiveCssClass: "current",
                    PagerCssClass: "pager",
                    PageIndex: parseInt(pager.find("PageIndex").text()),
                    PageSize: parseInt(pager.find("PageSize").text()),
                    RecordCount: parseInt(pager.find("RecordCount").text())
                });

                $(".Name").each(function () {
                    var searchPattern = new RegExp('(' + SearchTerm() + ')', 'ig');
                    $(this).html($(this).text().replace(searchPattern, "<span class = 'highlight'>" + SearchTerm() + "</span>"));
                });
                $(".Venue").each(function () {
                    var venuesearchPattern = new RegExp('(' + SearchTerm() + ')', 'ig');
                    $(this).html($(this).text().replace(venuesearchPattern, "<span class = 'highlight'>" + SearchTerm() + "</span>"));
                });
            } else {
                var empty_row = row.clone(true);
                $("td:first-child", empty_row).attr("colspan", $("td", row).length);
                $("td:first-child", empty_row).attr("align", "center");
                $("td:first-child", empty_row).html("No records found for the search criteria.");
                $("td", empty_row).not($("td:first-child", empty_row)).remove();
                $("[id*=gvCustomers]").append(empty_row);
            }
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
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
                    <div class="input-group">
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="button">Search:</button>
                      </span>
                        
                    <asp:TextBox type="text" class="form-control" placeholder="Search for..." ID="txtSearch" runat="server" />
                        </div>
                    
                    <hr />
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField HeaderStyle-Width="150px" DataField="Name" HeaderText="Event Title"
                                        ItemStyle-CssClass="Name" />
                                    <asp:BoundField HeaderStyle-Width="210px" DataField="DateTime" HeaderText="SDateTime" />
                                    <asp:BoundField HeaderStyle-Width="210px" DataField="endDateTime" HeaderText="EDateTime" />
                                    <asp:BoundField HeaderStyle-Width="150px" DataField="Venue" HeaderText="Venue" />
                                    <asp:BoundField HeaderStyle-Width="150px" DataField="Fee" HeaderText="Fee" />
                                    <asp:BoundField HeaderStyle-Width="150px" DataField="Approval" HeaderText="Status" />
                                    <asp:BoundField HeaderStyle-Width="150px" DataField="eventId" HeaderText="Action" />
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="Pager"></div>
                    </div>
                </div>

            </div>
            <br />


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
