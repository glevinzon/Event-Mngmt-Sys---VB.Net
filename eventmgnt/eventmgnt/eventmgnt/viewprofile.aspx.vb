Imports System.IO
Imports System.Globalization
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data

Public Class viewprofile
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
            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)

            If Request.QueryString("uname") IsNot Nothing Then
                Image1.ImageUrl = "getProfilePic.aspx?uname=" + Request.QueryString("uname")
            Else

            End If

            Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("SELECT profileId, userName,Title,firstName,lastName,eMail,Mobile,Address,City,State,Postcode,Country FROM dbo.Profiles WHERE userName=" + "'" + Request.QueryString("uname") + "'")
                    Using sda As New SqlDataAdapter()
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        Using dtt As New DataTable()
                            sda.Fill(dtt)
                            DataList1.DataSource = dtt
                            DataList1.DataBind()
                        End Using
                    End Using
                End Using
            End Using

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