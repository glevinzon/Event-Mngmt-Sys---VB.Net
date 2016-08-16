<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="successredirect.aspx.vb" Inherits="eventmgnt.successredirect" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        .message {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 130px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }
        .textt {
            z-index: 1001;
            
        }

            .center img {
                height: 128px;
                width: 128px;
            }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <center>
                <p>Thank you! See you on the event. The browser will redirect you to the view page in 5 secs. Please wait.</p>
                <p>The browser will redirect you shortly. Please wait.</p>
        </center>
            <div class="center">
                <img src="Public/Images/opm.gif" />
            
        </div>
    </form>
</body>
</html>
