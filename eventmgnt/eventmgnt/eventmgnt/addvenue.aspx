<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="addvenue.aspx.vb" Inherits="eventmgnt.addvenue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    Name:        
<asp:TextBox runat="server" ID="txt_Name"></asp:TextBox><br />
 Description:        
<asp:TextBox runat="server" ID="txt_Desc"></asp:TextBox><br />
Image Path:
<asp:FileUpload runat="server" ID="FileUpload1" /><br />
 
<asp:Button runat="server" ID="cmd_Upload" Text="Upload Image" OnClick="cmd_Upload_Click" />
    </div>
    </form>
</body>
</html>
