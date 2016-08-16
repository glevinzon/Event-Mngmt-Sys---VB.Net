<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="attend.aspx.vb" Inherits="eventmgnt.attend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/sticky-footer.css" rel="stylesheet" />
    <link href="Styles/basic.css" rel="stylesheet" />

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
        <div class="form-group">
            <div class="col-lg-1"></div>
            <div class="col-lg-5">

                <div class="well well-lg">

                    <div class="form-group">
                        <label class="col-xs-2 control-label">Full name</label>
                        <div class="col-xs-2">
                            <asp:TextBox runat="server" class="form-control" ID="txt_title" ReadOnly="true"></asp:TextBox><br />
                        </div>
                        <div class="col-xs-4">
                            <asp:TextBox runat="server" class="form-control" ID="txt_fname" ReadOnly="true"></asp:TextBox><br />
                        </div>
                        <div class="col-xs-4">
                            <asp:TextBox runat="server" class="form-control" ID="txt_lname" ReadOnly="true"></asp:TextBox><br />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-3 control-label">Username</label>
                        <div class="col-xs-5">
                            <asp:TextBox runat="server" class="form-control" ID="txt_username" ReadOnly="true"></asp:TextBox><br />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-3 control-label">Email address</label>
                        <div class="col-xs-5">
                            <asp:TextBox runat="server" class="form-control" ID="txt_email" ReadOnly="true"></asp:TextBox><br />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-3 control-label">Mobile</label>
                        <div class="col-xs-5">
                            <asp:TextBox runat="server" class="form-control" ID="txt_mobile" ReadOnly="true"></asp:TextBox><br />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-3 control-label">Address</label>
                        <div class="col-xs-5">
                            <asp:TextBox runat="server" class="form-control" ID="txt_address" ReadOnly="true"></asp:TextBox><br />
                        </div>
                    </div>
                    <div class="form-group">

                        <label class="col-xs-2 control-label">City</label>
                        <div class="col-xs-4">
                            <asp:TextBox runat="server" class="form-control" ID="txt_city" ReadOnly="true"></asp:TextBox><br />
                        </div>
                        <label class="col-xs-2 control-label">State</label>
                        <div class="col-xs-4">
                            <asp:TextBox runat="server" class="form-control" ID="txt_state" ReadOnly="true"></asp:TextBox><br />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">Postcode</label>
                        <div class="col-xs-4">
                            <asp:TextBox runat="server" class="form-control" ID="txt_postcode" ReadOnly="true"></asp:TextBox><br />
                        </div>
                        <label class="col-xs-2 control-label">Country</label>
                        <div class="col-xs-4">
                            <asp:TextBox runat="server" class="form-control" ID="txt_country" ReadOnly="true"></asp:TextBox><br />
                        </div>

                    </div>

                    <div class="modal fade" id="payModal" tabindex="-1" role="dialog" aria-labelledby="Payment Scheme" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <legend>Payment</legend>
                                </div>
                                <div class="modal-body">
                                    <fieldset>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label" for="card-holder-name">Name on Card</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="card-holder-name" id="card-holder-name" placeholder="Card Holder's Name">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label" for="card-number">Card Number</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="card-number" id="card-number" placeholder="Debit/Credit Card Number">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label" for="expiry-month">Expiration Date</label>
                                            <div class="col-sm-9">
                                                <div class="row">
                                                    <div class="col-xs-3">
                                                        <select class="form-control col-sm-2" name="expiry-month" id="expiry-month">
                                                            <option>Month</option>
                                                            <option value="01">Jan (01)</option>
                                                            <option value="02">Feb (02)</option>
                                                            <option value="03">Mar (03)</option>
                                                            <option value="04">Apr (04)</option>
                                                            <option value="05">May (05)</option>
                                                            <option value="06">June (06)</option>
                                                            <option value="07">July (07)</option>
                                                            <option value="08">Aug (08)</option>
                                                            <option value="09">Sep (09)</option>
                                                            <option value="10">Oct (10)</option>
                                                            <option value="11">Nov (11)</option>
                                                            <option value="12">Dec (12)</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <select class="form-control" name="expiry-year">
                                                            <option value="13">2013</option>
                                                            <option value="14">2014</option>
                                                            <option value="15">2015</option>
                                                            <option value="16">2016</option>
                                                            <option value="17">2017</option>
                                                            <option value="18">2018</option>
                                                            <option value="19">2019</option>
                                                            <option value="20">2020</option>
                                                            <option value="21">2021</option>
                                                            <option value="22">2022</option>
                                                            <option value="23">2023</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label" for="cvv">Card CVV</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" name="cvv" id="cvv" placeholder="Security Code">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-3 col-sm-9">
                                                <asp:Button runat="server" class="btn btn-primary" ID="cmd_Attend" Text="Pay Now" OnClick="cmd_Attend_Click" />
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Terms and conditions modal -->
                    <div class="modal fade" id="termsModal" tabindex="-1" role="dialog" aria-labelledby="Terms and conditions" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title">Terms and conditions</h3>
                                </div>

                                <div class="modal-body">
                                    <p>Lorem ipsum dolor sit amet, veniam numquam has te. No suas nonumes recusabo mea, est ut graeci definitiones. His ne melius vituperata scriptorem, cum paulo copiosae conclusionemque at. Facer inermis ius in, ad brute nominati referrentur vis. Dicat erant sit ex. Phaedrum imperdiet scribentur vix no, ad latine similique forensibus vel.</p>
                                    <p>Dolore populo vivendum vis eu, mei quaestio liberavisse ex. Electram necessitatibus ut vel, quo at probatus oportere, molestie conclusionemque pri cu. Brute augue tincidunt vim id, ne munere fierent rationibus mei. Ut pro volutpat praesent qualisque, an iisque scripta intellegebat eam.</p>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" id="agreeButton" data-dismiss="modal">Agree</button>
                                    <button type="button" class="btn btn-default" id="disagreeButton" data-dismiss="modal">Disagree</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        $(document).ready(function () {
                            $('#form1').formValidation({
                                framework: 'bootstrap',
                                icon: {
                                    valid: 'glyphicon glyphicon-ok',
                                    invalid: 'glyphicon glyphicon-remove',
                                    validating: 'glyphicon glyphicon-refresh'
                                },
                                fields: {
                                    agree: {
                                        // The plugin will ignore the hidden field
                                        // By setting excluded: false, the field will be validated as usual
                                        excluded: false,
                                        validators: {
                                            callback: {
                                                message: 'You must agree with the terms and conditions',
                                                callback: function (value, validator, $field) {
                                                    return value === 'yes';
                                                }
                                            }
                                        }
                                    }
                                }
                            });

                            // Update the value of "agree" input when clicking the Agree/Disagree button
                            $('#agreeButton, #disagreeButton').on('click', function () {
                                var whichButton = $(this).attr('id');

                                $('#registrationForm')
                                    .find('[name="agree"]')
                                        .val(whichButton === 'agreeButton' ? 'yes' : 'no')
                                        .end()
                                    // Revalidate the field manually
                                    .formValidation('revalidateField', 'agree');
                            });
                        });
                    </script>
                </div>



            </div>
            <div class="col-lg-5">
                <div class="well well-lg">
                    <div class="form-group">
                        <label class="col-xs-2 control-label">Event Name</label>
                        <div class="col-xs-10">
                            <asp:TextBox runat="server" class="form-control" ID="txt_ename" ReadOnly="true"></asp:TextBox><br />
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">Date and Time</label>
                        <div class="col-xs-10">
                            <asp:TextBox runat="server" class="form-control" ID="txt_datetime" ReadOnly="true"></asp:TextBox><br />
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">Venue</label>
                        <div class="col-xs-10">
                            <asp:TextBox runat="server" class="form-control" ID="txt_venue" ReadOnly="true"></asp:TextBox><br />
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">Fee</label>
                        <div class="col-xs-10">
                            <asp:TextBox runat="server" class="form-control" ID="txt_Fee" ReadOnly="true"></asp:TextBox><br />
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">Status</label>
                        <div class="col-xs-10">
                            <asp:TextBox runat="server" class="form-control" ID="txt_approval" ReadOnly="true"></asp:TextBox><br />
                        </div>

                    </div>

                    <div class="form-group">
                        <div class="col-xs-6 col-xs-offset-3">
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#termsModal">Agree with the terms and conditions</button>
                            <input type="hidden" name="agree" value="no" />
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-9 col-xs-offset-3">
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#payModal">Submit</button>

                        </div>
                    </div>

                </div>
            </div>
            <div class="col-lg-2">
            </div>
        </div>
        <hr />
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
