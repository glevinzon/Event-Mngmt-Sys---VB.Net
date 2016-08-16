Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO
Public Class view
    Inherits System.Web.UI.Page
    Protected s_userName As String = User.Identity.Name
    Protected isAdmin As Boolean = False
    Protected event_starter As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If
        hyperlink4.NavigateUrl = "~/viewprofile.aspx?uname=" + s_userName
        hyperlink1.Text = s_userName
        If s_userName = "superadmin" Then

            hyperlink8.NavigateUrl = "~/webadmin.aspx"
            hyperlink6.NavigateUrl = "~/webadmin.aspx"
        Else

            hyperlink8.NavigateUrl = "~/webadmin.aspx"
            hyperlink6.NavigateUrl = "~/webadmin.aspx"
        End If
        If Not Me.IsPostBack Then
            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)

            If Request.QueryString("eventId") IsNot Nothing Then
                Image1.ImageUrl = "ImageVB.aspx?ImageID=" + Request.QueryString("eventId")
                Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
                Using con As New SqlConnection(constr)
                    Using cmd As New SqlCommand("SELECT userName, Name, CONVERT(VARCHAR(19), DateTime) AS Date,Venue,Fee, Approval FROM Events WHERE eventId=" + Request.QueryString("eventId"))
                        Using sda As New SqlDataAdapter()
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dtt As New DataTable()

                                sda.Fill(dtt)
                                
                                If dtt.Rows.Count > 0 Then
                                    event_starter = dtt.Rows(0)("userName").ToString()
                                    If s_userName.Equals(dtt.Rows(0)("userName").ToString()) Then
                                        isAdmin = True
                                    Else
                                        isAdmin = False
                                    End If
                                    If s_userName.Equals(dtt.Rows(0)("userName").ToString()) Then
                                        hyperlink3.Text = "Joined"
                                        hyperlink3.Enabled = False
                                    End If

                                End If
                                DataList1.DataSource = dtt
                                DataList1.DataBind()
                            End Using
                        End Using
                    End Using
                    Using cmd As New SqlCommand("SELECT Attendees.attendeeId,  Attendees.userName,  Attendees.eventId, CASE WHEN Attendees.payment = 0 THEN 'Pending' WHEN Attendees.payment = 1 THEN 'Verified' ELSE 'Approved' END AS payment ,  Attendees.created,  Attendees.modified,  Profiles.Title,  Profiles.firstName, Profiles.lastName FROM Attendees INNER JOIN Profiles ON  Attendees.userName =  Profiles.userName WHERE eventId=" + Request.QueryString("eventId"))
                        Using sda As New SqlDataAdapter()
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dtt As New DataTable()

                                sda.Fill(dtt)

                                If dtt.Rows.Count > 0 Then
                                    If s_userName.Equals(dtt.Rows(0)("userName").ToString()) Then
                                        hyperlink3.Text = "Joined"
                                        hyperlink3.Enabled = False
                                    End If

                                End If

                                GVImages.DataSource = dtt
                                GVImages.DataBind()
                                
                            End Using
                        End Using
                    End Using
                    Using cmd As New SqlCommand("SELECT * FROM Guests WHERE eventId=" + Request.QueryString("eventId"))
                        Using sda As New SqlDataAdapter()
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dtt As New DataTable()
                                sda.Fill(dtt)
                                GridGuests.DataSource = dtt
                                GridGuests.DataBind()

                            End Using
                        End Using
                    End Using
                    
                End Using



                If isAdmin = True Then
                    hyperlink3.Visible = False
                Else
                    hyperlink6.Visible = False
                End If


                hyperlink3.NavigateUrl = "~/attend.aspx?eventId=" + Request.QueryString("eventId")
                hyperlink6.NavigateUrl = "~/manage.aspx?eventId=" + Request.QueryString("eventId")

            Else
                Dim meta As New HtmlMeta()
                meta.HttpEquiv = "Refresh"
                meta.Content = "0;url=default.aspx"
                Me.Page.Controls.Add(meta)
            End If



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

    

    Private Sub DataList1_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = DataControlRowType.DataRow Then
            Dim GetLink As HyperLink = TryCast(e.Item.FindControl("hlcreator"), HyperLink)
            GetLink.NavigateUrl = "~/viewprofile.aspx?uname=" + event_starter
        End If
    End Sub
End Class