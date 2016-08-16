Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data

Public Class addvenue
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub cmd_Upload_Click(sender As Object, e As System.EventArgs)
        Dim s_Name As String = txt_Name.Text.ToString()
        Dim s_Desc As String = txt_Desc.Text.ToString()
        If FileUpload1.PostedFile IsNot Nothing AndAlso FileUpload1.PostedFile.FileName <> "" Then
            Dim n_Image_Size As Byte() = New Byte(FileUpload1.PostedFile.ContentLength - 1) {}
            Dim Posted_Image As HttpPostedFile = FileUpload1.PostedFile
            Posted_Image.InputStream.Read(n_Image_Size, 0, CInt(FileUpload1.PostedFile.ContentLength))

            Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

            Dim cmd As New SqlCommand()
            cmd.CommandText = "INSERT INTO Venues(Name,Description,[Content],Size,Type)" & " VALUES (@Name,@Description,@Image_Content,@Image_Size,@Image_Type)"
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn

            Dim Name As New SqlParameter("@Name", SqlDbType.VarChar, 500)
            Name.Value = txt_Name.Text
            cmd.Parameters.Add(Name)
            Dim Desc As New SqlParameter("@Description", SqlDbType.VarChar, 500)
            Desc.Value = txt_Desc.Text
            cmd.Parameters.Add(Desc)

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
End Class