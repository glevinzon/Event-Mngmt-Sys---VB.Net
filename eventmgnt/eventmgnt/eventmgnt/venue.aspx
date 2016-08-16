<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="venue.aspx.vb" Inherits="eventmgnt.venue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:GridView ID="GVImages" runat="server" AutoGenerateColumns="false" HeaderStyle-BackColor="CornflowerBlue" HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White" CellPadding="5">
        <Columns>
     
        <asp:BoundField DataField="Name" HeaderText="Name" />
        <asp:BoundField DataField="Description" HeaderText="Description" />
     
        <asp:TemplateField HeaderText="Image">
        <ItemTemplate>
        <asp:Image ID="Image1" runat="server" Width="200px" Height="200px" 
                   ImageUrl='<%# "VenueImageHandler.ashx?ID=" + Convert.ToString(Eval("venueId"))%>'/>
        </ItemTemplate>
        </asp:TemplateField>
     
        </Columns>        
        </asp:GridView>
    </div>
    </form>
</body>
</html>
