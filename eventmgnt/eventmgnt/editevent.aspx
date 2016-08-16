<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="editevent.aspx.vb" Inherits="eventmgnt.editevent" %>

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

    <!-- Include Required Prerequisites -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jquery/1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://localhost:2352/cdn.jsdelivr.net/bootstrap/latest/css/bootstrap.css" />
 
<!-- Include Date Range Picker -->
<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="http://localhost:2352/cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />

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
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <div class="modal">
                    <div class="center">
                        <img alt="" src="Public/Images/opm.gif" />
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-body">
                    <h1 style="font-family: great_vibesregular;">Edit</h1>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="email">Name:</label>
                        <div class="col-sm-9">
                            <asp:TextBox runat="server" ID="txt_Name" class="form-control"></asp:TextBox><br />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="pwd">Venue:</label>
                        <div class="col-sm-9">
                            <asp:TextBox runat="server" class="form-control" ID="txt_Venue"></asp:TextBox><br />
                        </div>

                        
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="pwd">Start:</label>

                        <div class="col-sm-3">
                            <div class="form-horizontal">
                                <asp:TextBox runat="server" ID="txt_sDateTime" class="form-control" ReadOnly="false"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Required"
                                ControlToValidate="txt_sDateTime" runat="server" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <script type="text/javascript">
                            $(function () {
                                $('input[name="txt_sDateTime"]').daterangepicker({
                                    singleDatePicker: true,
                                    showDropdowns: true,
                                    timePicker: true,
                                    timePicker24Hour: true,
                                    timePickerIncrement: 30,
                                    locale: {
                                        format: 'MM/DD/YYYY h:mm'
                                    }
                                },
                                function (start, end, label) {
                                    var years = moment().diff(start, 'years');
                                    //alert("You are " + years + " years old.");
                                });
                            });
</script>
                        <label class="control-label col-sm-1" for="pwd">End:</label>

                        <div class="col-sm-3">
                            <div class="form-horizontal">
                                <asp:TextBox runat="server" ID="txt_eDateTime" class="form-control" ReadOnly="false"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Required"
                                ControlToValidate="txt_eDateTime" runat="server" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <script type="text/javascript">
                            $(function () {
                                $('input[name="txt_eDateTime"]').daterangepicker({
                                    singleDatePicker: true,
                                    showDropdowns: true,
                                    timePicker: true,
                                    timePicker24Hour: true,
                                    timePickerIncrement: 30,
                                    locale: {
                                        format: 'MM/DD/YYYY h:mm'
                                    }
                                },
                                function (start, end, label) {
                                    var years = moment().diff(start, 'years');
                                    //alert("You are " + years + " years old.");
                                });
                            });
</script>
                        
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-2" for="pwd">Fee:</label>
                        <div class="col-sm-3">
                            <div class="input-group">
      <div class="input-group-addon">₱</div>
      <asp:TextBox runat="server" class="form-control" ID="txt_Fee"></asp:TextBox><br />
      <div class="input-group-addon">.00</div>
    </div>
                        </div>
                        
                        <label class="control-label col-sm-1" for="pwd">Poster:</label>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div style="margin: 20px">
                                    <div class="col-sm-4">
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Please upload a valid JPEG or PNG file."
                                            ControlToValidate="FileUpload1" runat="server" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:Button runat="server" class="btn btn-primary" ID="cmd_Upload" Text="Update Event" OnClick="cmd_Upload_Click" />
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="cmd_Upload" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>
                <script type="text/javascript">
                    window.onsubmit = function () {
                        if (Page_IsValid) {
                            var updateProgress = $find("<%= UpdateProgress1.ClientID %>");
                            window.setTimeout(function () {
                                updateProgress.set_visible(true);
                            }, 100);
                        }
                    }
                </script>
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
