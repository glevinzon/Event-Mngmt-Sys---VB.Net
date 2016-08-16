Imports System.IO
Imports System.Globalization
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data

Public Class addevent
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
        End If
    End Sub
    Protected Sub cmd_Upload_Click(sender As Object, e As System.EventArgs)

        Dim s_userName As String = User.Identity.Name

        'System.Threading.Thread.Sleep(5000)
        Dim s_Name As String = txt_Name.Text.ToString()
        'Dim deyttaym As DateTime = DateTime.Parse(txt_DateTime.Text)
        Dim deyttaym As String = DateTime.ParseExact(txt_sDateTime.Text, "M/d/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("MMM. dd, yyyy HH:mm:ss")
        Dim enddeyttaym As String = DateTime.ParseExact(txt_eDateTime.Text, "M/d/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("MMM. dd, yyyy HH:mm:ss")

        'MsgBox(txt_DateTime.Text, MsgBoxStyle.Information, "Glevinzon")
        Try
            If FileUpload1.PostedFile IsNot Nothing AndAlso FileUpload1.PostedFile.FileName <> "" Then
                Dim n_Image_Size As Byte() = New Byte(FileUpload1.PostedFile.ContentLength - 1) {}
                Dim Posted_Image As HttpPostedFile = FileUpload1.PostedFile
                Posted_Image.InputStream.Read(n_Image_Size, 0, CInt(FileUpload1.PostedFile.ContentLength))

                Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                Dim cmd As New SqlCommand()
                cmd.CommandText = "INSERT INTO Events(userName, Name,DateTime,endDateTime,Venue,Fee,Approval,[Content],Size,Type,created)" & " VALUES (@UserName,@Name,@Datetime,@endDatetime,@Venue,@Fee,@Approval,@Image_Content,@Image_Size,@Image_Type, GETDATE()) "
                cmd.CommandType = CommandType.Text
                cmd.Connection = conn

                Dim userName As New SqlParameter("@UserName", SqlDbType.VarChar, 500)
                userName.Value = s_userName
                cmd.Parameters.Add(userName)

                Dim Name As New SqlParameter("@Name", SqlDbType.VarChar, 500)
                Name.Value = txt_Name.Text
                cmd.Parameters.Add(Name)

                Dim datetime As New SqlParameter("@Datetime", SqlDbType.DateTime, 500)
                datetime.Value = deyttaym
                cmd.Parameters.Add(datetime)

                Dim enddatetime As New SqlParameter("@endDatetime", SqlDbType.DateTime, 500)
                enddatetime.Value = enddeyttaym
                cmd.Parameters.Add(enddatetime)

                Dim venue As New SqlParameter("@Venue", SqlDbType.VarChar, 500)
                venue.Value = txt_Venue.Text
                cmd.Parameters.Add(venue)

                Dim fee As New SqlParameter("@Fee", SqlDbType.VarChar, 500)
                fee.Value = txt_Fee.Text
                cmd.Parameters.Add(fee)

                Dim approval As New SqlParameter("@Approval", SqlDbType.SmallInt)
                approval.Value = 0
                cmd.Parameters.Add(approval)

                Dim Image_Content As New SqlParameter("@Image_Content", SqlDbType.Image, n_Image_Size.Length)
                Image_Content.Value = n_Image_Size
                cmd.Parameters.Add(Image_Content)

                Dim Image_Size As New SqlParameter("@Image_Size", SqlDbType.BigInt, 99999)
                Image_Size.Value = FileUpload1.PostedFile.ContentLength
                cmd.Parameters.Add(Image_Size)

                Dim Image_Type As New SqlParameter("@Image_Type", SqlDbType.VarChar, 500)
                Image_Type.Value = FileUpload1.PostedFile.ContentType
                cmd.Parameters.Add(Image_Type)



                conn.Open()
                cmd.ExecuteNonQuery()

                conn.Close()
            End If
            Dim meta As New HtmlMeta()
            meta.HttpEquiv = "Refresh"
            meta.Content = "0;url=default.aspx"
            Me.Page.Controls.Add(meta)
        Catch ex As Exception
            MsgBox(ex, MsgBoxStyle.Information, "Something went wrong.")
            Dim meta As New HtmlMeta()
            meta.HttpEquiv = "Refresh"
            meta.Content = "0;url=addevent.aspx"
            Me.Page.Controls.Add(meta)
        End Try
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