Imports System.Data
Imports System.Globalization
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO


Public Class webadmin
    Inherits System.Web.UI.Page
    Protected eid As String
    Protected s_userName As String = User.Identity.Name



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If

        hyperlink1.Text = s_userName
        If Not IsPostBack Then
            hyperlink3.NavigateUrl = "~/viewprofile.aspx?uname=" + s_userName

            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)

        End If


    End Sub

    Protected Sub cmd_Search_Click(sender As Object, e As System.EventArgs)


        If CheckBox1.Checked = True Then
            Dim deyttaym As String = DateTime.ParseExact(txt_sDateTime.Text, "M/d/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd HH:mm:ss.mmm")
            Dim enddeyttaym As String = DateTime.ParseExact(txt_eDateTime.Text, "M/d/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd HH:mm:ss.mmm")

            gvCustomers.DataSource = GetData("select eventId, userName, Name, DateTime, endDateTime, datediff(hh, DateTime , endDateTime) AS duration, Fee, Approval, created, modified from Events WHERE DateTime between'" + deyttaym + "' and '" + enddeyttaym + "' ")
            gvCustomers.DataBind()
        ElseIf CheckBox2.Checked = True Then
            gvCustomers.DataSource = GetData("select eventId, userName, Name, DateTime, endDateTime, datediff(hh, DateTime , endDateTime) AS duration, Fee, Approval, created, modified from Events WHERE Name LIKE @Key")
            gvCustomers.DataBind()
        ElseIf CheckBox1.Checked = True And CheckBox2.Checked = True Then
            Dim deyttaym As String = DateTime.ParseExact(txt_sDateTime.Text, "M/d/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd HH:mm:ss.mmm")
            Dim enddeyttaym As String = DateTime.ParseExact(txt_eDateTime.Text, "M/d/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd HH:mm:ss.mmm")

            gvCustomers.DataSource = GetData("select eventId, userName, Name, DateTime, endDateTime, datediff(hh, DateTime , endDateTime) AS duration, Fee, Approval, created, modified from Events WHERE DateTime between'" + deyttaym + "' and '" + enddeyttaym + "' AND Name LIKE @Key")
            gvCustomers.DataBind()
        Else
            gvCustomers.DataSource = GetData("select eventId, userName, Name, DateTime, endDateTime, datediff(hh, DateTime , endDateTime) AS duration, Fee, Approval, created, modified from Events")
            gvCustomers.DataBind()
        End If
        'MsgBox(deyttaym)
        'MsgBox(enddeyttaym)
    End Sub


    Public Function GetData(query As String) As DataTable

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
        Using con As New SqlConnection(strConnString)
            Using cmd As New SqlCommand()
                cmd.CommandText = query
                cmd.Parameters.AddWithValue("@Key", "%" + txt_keyword.Text + "%")

                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    Using ds As New DataSet()
                        Dim dt As New DataTable()
                        sda.Fill(dt)
                        Return dt
                    End Using
                End Using
            End Using
        End Using
    End Function
    Protected Sub OnRowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim customerId As String = gvCustomers.DataKeys(e.Row.RowIndex).Value.ToString()
            Dim gvOrders As GridView = TryCast(e.Row.FindControl("gvOrders"), GridView)
            gvOrders.DataSource = GetData(String.Format("select * from Attendees where eventId='{0}'", customerId))
            gvOrders.DataBind()
        End If
    End Sub
    Private Function GetData(parentMenuId As Integer) As DataTable
        Dim query As String = "SELECT [MenuId], [Title], [Description], [Url] FROM [Menus] WHERE ParentMenuId = @ParentMenuId"
        Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
        Using con As New SqlConnection(constr)
            Dim dt As New DataTable()
            Using cmd As New SqlCommand(query)
                Using sda As New SqlDataAdapter()
                    cmd.Parameters.AddWithValue("@ParentMenuId", parentMenuId)
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    sda.Fill(dt)
                End Using
            End Using
            Return dt
        End Using
    End Function

    Private Sub PopulateMenu(dt As DataTable, parentMenuId As Integer, parentMenuItem As MenuItem)
        Dim currentPage As String = Path.GetFileName(Request.Url.AbsolutePath)
        For Each row As DataRow In dt.Rows
            Dim menuItem As New MenuItem() With { _
              .Value = row("MenuId").ToString(), _
              .Text = row("Title").ToString(), _
              .NavigateUrl = row("Url").ToString(), _
             .Selected = row("Url").ToString().EndsWith(currentPage, StringComparison.CurrentCultureIgnoreCase) _
            }
            If parentMenuId = 0 Then
                Menu1.Items.Add(menuItem)
                Dim dtChild As DataTable = Me.GetData(Integer.Parse(menuItem.Value))
                PopulateMenu(dtChild, Integer.Parse(menuItem.Value), menuItem)
            Else
                parentMenuItem.ChildItems.Add(menuItem)
            End If
        Next
    End Sub

    Private Sub gvCustomers_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCustomers.RowDataBound
        Dim idCell As TableCell = e.Row.Cells(1)
        Dim dCell As TableCell = e.Row.Cells(3)
        dCell.Text = dCell.Text + " hour(s)"
        Dim hl As New HyperLink()
        hl.NavigateUrl = "~/approval.aspx?eventId=" + idCell.Text + "&status=approve"
        hl.Text = "<span class='glyphicon glyphicon-thumbs-down' aria-hidden='true'></span> Disapprove"
        hl.CssClass = "btn btn-danger"



        Dim hl1 As New HyperLink()
        hl1.NavigateUrl = "~/approval.aspx?eventId=" + idCell.Text + "&status=disapprove"
        hl1.Text = "<span class='glyphicon glyphicon-thumbs-up' aria-hidden='true'></span> Approve"
        hl1.CssClass = "btn btn-success"

        Dim hl2 As New HyperLink()
        hl2.NavigateUrl = "~/approval.aspx?eventId=" + idCell.Text + "&status=approve"
        hl2.Text = "PENDING"
        hl2.CssClass = "btn btn-warning"

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim statusCell As TableCell = e.Row.Cells(4)
            If statusCell.Text = "0" Then
                statusCell.Controls.Add(hl2)

            ElseIf statusCell.Text = "1" Then
                statusCell.Controls.Add(hl)

            ElseIf statusCell.Text = "2" Then
                statusCell.Controls.Add(hl1)
            End If
        End If
    End Sub
    Protected Sub grid_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim idCell As TableCell = e.Row.Cells(0)
        
        Dim hl As New HyperLink()
        hl.NavigateUrl = "~/approval.aspx?aId=" + idCell.Text + "&attendstatus=approve"
        hl.Text = "<span class='glyphicon glyphicon-thumbs-down' aria-hidden='true'></span> Disapprove"
        hl.CssClass = "btn btn-danger"


        Dim hl1 As New HyperLink()
        hl1.NavigateUrl = "~/approval.aspx?aId=" + idCell.Text + "&attendstatus=disapprove"
        hl1.Text = "<span class='glyphicon glyphicon-thumbs-up' aria-hidden='true'></span> Approve"
        hl1.CssClass = "btn btn-success"

        Dim hl2 As New HyperLink()
        hl2.NavigateUrl = "~/approval.aspx?aId=" + idCell.Text + "&attendstatus=approve"
        hl2.Text = "PENDING"
        hl2.CssClass = "btn btn-warning"

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim statusCell As TableCell = e.Row.Cells(2)
            If statusCell.Text = "0" Then
                statusCell.Controls.Add(hl2)

            ElseIf statusCell.Text = "1" Then
                statusCell.Controls.Add(hl)

            ElseIf statusCell.Text = "2" Then
                statusCell.Controls.Add(hl1)
            End If
        End If

    End Sub
End Class