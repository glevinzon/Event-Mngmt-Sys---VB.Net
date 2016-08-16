Imports System.IO
Imports System.Globalization
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data

Public Class profile
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


            Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("SELECT profileId, userName,Title,firstName,lastName,eMail,Mobile,Address,City,State,Postcode,Country FROM dbo.Profiles WHERE userName=" + "'" + s_userName + "'")
                    Using sda As New SqlDataAdapter()
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        Using dtt As New DataTable()
                            sda.Fill(dtt)
                            If dtt.Rows.Count > 0 Then
                                txt_title.Text = dtt.Rows(0)("Title").ToString()
                                txt_fName.Text = dtt.Rows(0)("firstName").ToString()
                                txt_lName.Text = dtt.Rows(0)("lastName").ToString()
                                txt_email.Text = dtt.Rows(0)("eMail").ToString()
                                txt_Mobile.Text = dtt.Rows(0)("Mobile").ToString()
                                txt_Address.Text = dtt.Rows(0)("Address").ToString()
                                txt_City.Text = dtt.Rows(0)("City").ToString()
                                txt_State.Text = dtt.Rows(0)("State").ToString()
                                txt_Postcode.Text = dtt.Rows(0)("Postcode").ToString()
                                txt_Country.Text = dtt.Rows(0)("Country").ToString()
                                dtt.Clear()
                                cmd.Dispose()
                                sda.Dispose()

                            End If
                        End Using
                    End Using
                End Using
            End Using

        End If



    End Sub
    Protected Sub cmd_Upload_Click(sender As Object, e As System.EventArgs)
        Dim s_Title As String = txt_title.Text.ToString()
        Dim s_fName As String = txt_fName.Text.ToString()
        Dim s_lName As String = txt_lName.Text.ToString()
        Dim s_Email As String = txt_email.Text.ToString()
        Dim s_Mobile As String = txt_Mobile.Text.ToString()
        Dim s_Address As String = txt_Address.Text.ToString()
        Dim s_City As String = txt_City.Text.ToString()
        Dim s_State As String = txt_State.Text.ToString()
        Dim s_Postcode As String = txt_Postcode.Text.ToString()
        Dim s_Country As String = txt_Country.Text.ToString()

        If FileUpload1.PostedFile IsNot Nothing AndAlso FileUpload1.PostedFile.FileName <> "" Then
            Dim n_Image_Size As Byte() = New Byte(FileUpload1.PostedFile.ContentLength - 1) {}
            Dim Posted_Image As HttpPostedFile = FileUpload1.PostedFile
            Posted_Image.InputStream.Read(n_Image_Size, 0, CInt(FileUpload1.PostedFile.ContentLength))

            Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

            Dim cmd As New SqlCommand()
            cmd.CommandText = "UPDATE Profiles SET  Title = @Title, firstName=@First_Name, lastName=@Last_Name, eMail=@Email, Mobile=@Mobile, Address=@Address, City=@City, State=@State, Postcode=@Postcode, Country=@Country, Content=@Image_Content, Size=@Image_Size, Type=@Image_Type WHERE userName='" + s_userName + "'"
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn

            Dim title As New SqlParameter("@Title", SqlDbType.VarChar, 500) 'title
            title.Value = txt_title.Text
            cmd.Parameters.Add(title)

            Dim fName As New SqlParameter("@First_Name", SqlDbType.VarChar, 500) 'firstname
            fName.Value = txt_fName.Text
            cmd.Parameters.Add(fName)
            Dim lName As New SqlParameter("@Last_Name", SqlDbType.VarChar, 500) 'lastname
            lName.Value = txt_lName.Text
            cmd.Parameters.Add(lName)
            Dim email As New SqlParameter("@Email", SqlDbType.VarChar, 500) 'email
            email.Value = txt_email.Text
            cmd.Parameters.Add(email)
            Dim mobile As New SqlParameter("@Mobile", SqlDbType.VarChar, 500) 'mobile
            mobile.Value = txt_Mobile.Text
            cmd.Parameters.Add(mobile)
            Dim address As New SqlParameter("@Address", SqlDbType.VarChar, 500) 'address
            address.Value = txt_Address.Text
            cmd.Parameters.Add(address)
            Dim city As New SqlParameter("@City", SqlDbType.VarChar, 500) 'city
            city.Value = txt_City.Text
            cmd.Parameters.Add(city)
            Dim state As New SqlParameter("@State", SqlDbType.VarChar, 500) 'state
            state.Value = txt_State.Text
            cmd.Parameters.Add(state)
            Dim postcode As New SqlParameter("@Postcode", SqlDbType.VarChar, 500) 'postcode
            postcode.Value = txt_Postcode.Text
            cmd.Parameters.Add(postcode)
            Dim country As New SqlParameter("@Country", SqlDbType.VarChar, 500) 'country
            country.Value = txt_Country.Text
            cmd.Parameters.Add(country)

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