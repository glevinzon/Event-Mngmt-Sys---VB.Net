Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Public Class attend
    Inherits System.Web.UI.Page
    Protected s_userName As String = User.Identity.Name

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If
        hyperlink1.Text = s_userName
        If s_userName = "superadmin" Then
            hyperlink5.NavigateUrl = "~/webadmin.aspx"
        Else
            hyperlink5.NavigateUrl = "~/manage.aspx"
        End If
        If Not Me.IsPostBack Then
            hyperlink3.NavigateUrl = "~/viewprofile.aspx?uname=" + s_userName
            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)

            If Request.QueryString("eventId") IsNot Nothing Then
                'Image1.ImageUrl = "ImageVB.aspx?ImageID=" + Request.QueryString("eventId")
                Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString

                Using con As New SqlConnection(constr)
                    Using cmd As New SqlCommand("SELECT profileId, userName,Title,firstName,lastName,eMail,Mobile,Address,City,State,Postcode,Country FROM dbo.Profiles WHERE userName=" + "'" + s_userName + "'")
                        Using sda As New SqlDataAdapter()
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dtt As New DataTable()

                                sda.Fill(dtt)
                                If dtt.Rows.Count > 0 Then
                                    If s_userName.Equals(dtt.Rows(0)("userName").ToString()) Then
                                        txt_title.Text = dtt.Rows(0)("Title").ToString()
                                        txt_fname.Text = dtt.Rows(0)("firstName").ToString()
                                        txt_lname.Text = dtt.Rows(0)("lastName").ToString()
                                        txt_username.Text = dtt.Rows(0)("userName").ToString()
                                        txt_email.Text = dtt.Rows(0)("eMail").ToString()
                                        txt_mobile.Text = dtt.Rows(0)("Mobile").ToString()
                                        txt_address.Text = dtt.Rows(0)("Address").ToString()
                                        txt_city.Text = dtt.Rows(0)("City").ToString()
                                        txt_state.Text = dtt.Rows(0)("State").ToString()
                                        txt_postcode.Text = dtt.Rows(0)("Postcode").ToString()
                                        txt_country.Text = dtt.Rows(0)("Country").ToString()
                                    Else

                                    End If

                                End If
                            End Using
                        End Using
                    End Using

                    Using cmd As New SqlCommand("SELECT eventId, userName, Name, CONVERT(VARCHAR(19), DateTime) AS Date,Venue,Fee, Approval FROM Events WHERE eventId=" + Request.QueryString("eventId"))
                        Using sda As New SqlDataAdapter()
                            cmd.Connection = con
                            sda.SelectCommand = cmd
                            Using dtt As New DataTable()

                                sda.Fill(dtt)

                                If dtt.Rows.Count > 0 Then
                                    txt_ename.Text = dtt.Rows(0)("Name").ToString()
                                    txt_datetime.Text = dtt.Rows(0)("Date").ToString()
                                    txt_venue.Text = dtt.Rows(0)("Venue").ToString()
                                    txt_Fee.Text = dtt.Rows(0)("Fee").ToString()
                                    If dtt.Rows(0)("Approval").ToString().Equals("0") Then
                                        txt_approval.Text = "Pending"
                                    ElseIf dtt.Rows(0)("Approval").ToString().Equals("1") Then
                                        txt_approval.Text = "Verified"
                                    ElseIf dtt.Rows(0)("Approval").ToString().Equals("2") Then
                                        txt_approval.Text = "Approved"
                                    Else
                                        txt_approval.Text = "Unknown"
                                    End If


                                End If
                            End Using
                        End Using
                    End Using
                End Using

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


    Protected Sub cmd_Attend_Click(sender As Object, e As System.EventArgs)
        Try
            Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

            Dim cmd As New SqlCommand()
            cmd.CommandText = "INSERT INTO Attendees(userName, eventId,payment, created)" & " VALUES (@UserName,@EventId,@Payment,GETDATE())"
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn

            Dim userName As New SqlParameter("@UserName", SqlDbType.VarChar, 500)
            userName.Value = s_userName
            cmd.Parameters.Add(userName)
            Dim eid As New SqlParameter("@EventId", SqlDbType.VarChar, 500)
            eid.Value = Request.QueryString("eventId")
            cmd.Parameters.Add(eid)
            Dim pay As New SqlParameter("@Payment", SqlDbType.SmallInt, 10)
            pay.Value = 0
            cmd.Parameters.Add(pay)

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            Dim meta As New HtmlMeta()
            meta.HttpEquiv = "Refresh"
            meta.Content = "0;url=successredirect.aspx?eventId=" + Request.QueryString("eventId")
            Me.Page.Controls.Add(meta)
        Catch ex As Exception
            'MsgBox(ex, MsgBoxStyle.Information, "Something went wrong.")
            Dim meta As New HtmlMeta()
            meta.HttpEquiv = "Refresh"
            meta.Content = "0;url=default.aspx"
            Me.Page.Controls.Add(meta)
        End Try

    End Sub
End Class