Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO

Public Class register
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Me.Page.User.Identity.IsAuthenticated Then
            Dim meta As New HtmlMeta()
            meta.HttpEquiv = "Refresh"
            meta.Content = "0;url=default.aspx"
            Me.Page.Controls.Add(meta)
        End If
        If Not IsPostBack Then
            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)
        End If
    End Sub
    Protected Sub RegisterUser(sender As Object, e As EventArgs)
        Dim userId As Integer = 0
        Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("Insert_User")
                Using sda As New SqlDataAdapter()
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim())
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim())
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim())
                    cmd.Connection = con
                    con.Open()
                    userId = Convert.ToInt32(cmd.ExecuteScalar())
                    con.Close()
                End Using
            End Using
            Dim message As String = String.Empty
            Select Case userId
                Case -1
                    message = "Username already exists.\nPlease choose a different username."
                    Exit Select
                Case -2
                    message = "Supplied email address has already been used."
                    Exit Select
                Case Else
                    message = "Registration successful.\nUser Id: " + userId.ToString()
                    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                    Dim cmd As New SqlCommand()
                    cmd.CommandText = "INSERT INTO Profiles(userName)" & " VALUES (@UserName)"
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = conn

                    Dim userName As New SqlParameter("@UserName", SqlDbType.VarChar, 500)
                    userName.Value = txtUsername.Text.Trim()
                    cmd.Parameters.Add(userName)

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                    Exit Select
            End Select
            ClientScript.RegisterStartupScript([GetType](), "alert", (Convert.ToString("alert('") & message) + "');", True)
        End Using
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