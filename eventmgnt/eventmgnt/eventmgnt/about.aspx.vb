Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Public Class about
    Inherits System.Web.UI.Page
    Protected s_userName As String = User.Identity.Name

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If

        hyperlink1.Text = s_userName
        If s_userName = "superadmin" Then
            hyperlink7.NavigateUrl = "~/webadmin.aspx"
        Else
            hyperlink7.NavigateUrl = "~/manage.aspx"
        End If
        If Not Me.IsPostBack Then
            hyperlink4.NavigateUrl = "~/viewprofile.aspx?uname=" + s_userName
            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)
            Try
                Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
                Using con As New SqlConnection(constr)
                    Using cmd As New SqlCommand("SELECT TOP 5 eventId, userName, Name, CONVERT(VARCHAR(19), DateTime) AS Date,Venue,Fee, Approval FROM Events WHERE Approval = 2 AND endDateTime >= GETDATE() ORDER BY created DESC")
                        Using sda As New SqlDataAdapter()
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dtt As New DataTable()
                                sda.Fill(dtt)

                                If dtt.Rows.Count > 0 Then
                                    Image1.ImageUrl = "ImageVB.aspx?ImageID=" + dtt.Rows(0)("eventId").ToString()
                                    Label1.Text = dtt.Rows(0)("Name").ToString()
                                    Label2.Text = dtt.Rows(0)("Date").ToString()
                                    Label3.Text = dtt.Rows(0)("Venue").ToString()
                                    hyperlink8.NavigateUrl = "~/view.aspx?eventId=" + dtt.Rows(0)("eventId").ToString()
                                    Image2.ImageUrl = "ImageVB.aspx?ImageID=" + dtt.Rows(1)("eventId").ToString()
                                    Label4.Text = dtt.Rows(1)("Name").ToString()
                                    Label6.Text = dtt.Rows(1)("Date").ToString()
                                    Label5.Text = dtt.Rows(1)("Venue").ToString()
                                    hyperlink9.NavigateUrl = "~/view.aspx?eventId=" + dtt.Rows(1)("eventId").ToString()
                                    Image3.ImageUrl = "ImageVB.aspx?ImageID=" + dtt.Rows(2)("eventId").ToString()
                                    Label7.Text = dtt.Rows(2)("Name").ToString()
                                    Label9.Text = dtt.Rows(2)("Date").ToString()
                                    Label8.Text = dtt.Rows(2)("Venue").ToString()
                                    hyperlink10.NavigateUrl = "~/view.aspx?eventId=" + dtt.Rows(2)("eventId").ToString()
                                    Image4.ImageUrl = "ImageVB.aspx?ImageID=" + dtt.Rows(3)("eventId").ToString()
                                    Label10.Text = dtt.Rows(3)("Name").ToString()
                                    Label12.Text = dtt.Rows(3)("Date").ToString()
                                    Label11.Text = dtt.Rows(3)("Venue").ToString()
                                    hyperlink11.NavigateUrl = "~/view.aspx?eventId=" + dtt.Rows(3)("eventId").ToString()
                                    Image5.ImageUrl = "ImageVB.aspx?ImageID=" + dtt.Rows(4)("eventId").ToString()
                                    Label13.Text = dtt.Rows(4)("Name").ToString()
                                    Label15.Text = dtt.Rows(4)("Date").ToString()
                                    Label14.Text = dtt.Rows(4)("Venue").ToString()
                                    hyperlink12.NavigateUrl = "~/view.aspx?eventId=" + dtt.Rows(4)("eventId").ToString()
                                End If

                            End Using
                        End Using
                    End Using
                End Using
            Catch ex As Exception

            End Try

            
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
End Class