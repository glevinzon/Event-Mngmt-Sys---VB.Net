<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="webadmin.aspx.vb" Inherits="eventmgnt.webadmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/basic.css" rel="stylesheet" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $("[src*=plus]").live("click", function () {
            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "Public/Images/minus.png");
        });
        $("[src*=minus]").live("click", function () {
            $(this).attr("src", "Public/Images/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>
</head>
<body>
    <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        Delete dialog.
                    </div>
                    <div class="modal-body">
                        Take heed, cause you are about to delete data entirely from the database.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <a class="btn btn-danger btn-ok">Delete</a>
                    </div>
                </div>
            </div>
        </div>
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
                            runat="server" class="dropdown-toggle" data-toggle="dropdown" Font-Bold="true" /><span class="caret"></span>
                        <ul class="dropdown-menu">
                            <li>
                                <asp:HyperLink ID="hyperlink3"
                                    NavigateUrl="~/viewprofile.aspx"
                                    Text="View Profile"
                                    runat="server" /></li>
                            <li>
                                <asp:HyperLink ID="hyperlink4"
                                    NavigateUrl="~/profile.aspx"
                                    Text="Edit Profile"
                                    runat="server" /></li>
                            <li>
                                <asp:HyperLink ID="hyperlink5"
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
        <!-- Include Required Prerequisites -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jquery/1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="cdn.jsdelivr.net/bootstrap/latest/css/bootstrap.css" />
 
<!-- Include Date Range Picker -->
<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />
                

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          Filter Search
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
          <div class="row">

  <div class="col-md-1 checkbox ">
      <asp:CheckBox ID="CheckBox1" runat="server" />

  </div>
  <div class="col-md-11">
      <div class="form-group form-horizontal"">
                        <label class="control-label col-sm-1" for="pwd">Start:</label>

                        <div class="col-sm-3">
                            
                                <asp:TextBox runat="server" ID="txt_sDateTime" class="form-control" ReadOnly="false"></asp:TextBox>
                            
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
                            
                                <asp:TextBox runat="server" ID="txt_eDateTime" class="form-control" ReadOnly="false"></asp:TextBox>
                           
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
                        
                    </div></div>
  <div class="col-md-1 checkbox">
      <asp:CheckBox ID="CheckBox2" runat="server" />

  </div>
  <div class="col-md-11"><div class="form-group form-horizontal">
                        <label class="control-label col-sm-1" for="pwd">Keyword </label>

                        <div class="col-sm-9">
                            
                                <asp:TextBox runat="server" ID="txt_keyword" class="form-control" ReadOnly="false"></asp:TextBox>
                            
                        </div>
                        
              <div class="col-sm-2">
                                        <asp:Button runat="server" class="btn btn-primary" ID="cmd_searchkey" Text="SEARCH" OnClick="cmd_Search_Click" />
                                    </div>
      </div></div>

              
</div>

          <div class="container-fluid">
                  <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive table-striped"
                    DataKeyNames="eventId" OnRowDataBound="OnRowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <img alt = "" style="cursor: pointer" src="images/plus.png" />
                                <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass = "table">
                                        <Columns>
                                            <asp:BoundField ItemStyle-Width="150px" DataField="userName" HeaderText="Participant(s)" />
                                            <asp:BoundField ItemStyle-Width="150px" DataField="payment" HeaderText="Status" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField ItemStyle-Width="150px" DataField="eventId" HeaderText="Record No." />
                        <asp:BoundField ItemStyle-Width="150px" DataField="Name" HeaderText="Event" />
                        <asp:BoundField ItemStyle-Width="150px" DataField="duration" HeaderText="Duration" />
                        <asp:BoundField ItemStyle-Width="150px" DataField="Approval" HeaderText="Status" />
                        <asp:TemplateField HeaderText="Action"> 
                                        
                            <ItemTemplate>      
                                                <a href='<%# "view.aspx?eventId=" + Convert.ToString(Eval("eventId"))%>'  class="btn btn-info"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>View</a>
                                                <a href='<%# "editevent.aspx?eventId=" + Convert.ToString(Eval("eventId"))%>'  class="btn btn-warning"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span>Edit</a>
                                                <a href="#" data-href="<%# "deleteevent.aspx?eventId=" + Convert.ToString(Eval("eventId"))%>"  data-toggle="modal" data-target="#confirm-delete" class="btn btn-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>Delete</a>
                            </ItemTemplate>

                                    </asp:TemplateField>
                        
                    </Columns>
                </asp:GridView>
</div>
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
    <script>
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));

            $('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-ok').attr('href') + '</strong>');
        });
    </script>
</body>
</html>
