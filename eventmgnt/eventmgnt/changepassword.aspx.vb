Imports System.Drawing
Imports System.Configuration
Imports System.Data.SqlClient

Public Class changepassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'FormsAuthentication.RedirectToLoginPage()
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If
    End Sub
    Protected Sub OnChangingPassword(sender As Object, e As LoginCancelEventArgs)
        If Not ChangePassword1.CurrentPassword.Equals(ChangePassword1.NewPassword, StringComparison.CurrentCultureIgnoreCase) Then
            Dim rowsAffected As Integer = 0
            Dim query As String = "UPDATE [Users] SET [Password] = @NewPassword WHERE [Username] = @Username AND [Password] = @CurrentPassword"
            Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand(query)
                    Using sda As New SqlDataAdapter()
                        cmd.Parameters.AddWithValue("@Username", Me.Page.User.Identity.Name)
                        cmd.Parameters.AddWithValue("@CurrentPassword", ChangePassword1.CurrentPassword)
                        cmd.Parameters.AddWithValue("@NewPassword", ChangePassword1.NewPassword)
                        cmd.Connection = con
                        con.Open()
                        rowsAffected = cmd.ExecuteNonQuery()
                        con.Close()
                    End Using
                End Using
                If rowsAffected > 0 Then
                    lblMessage.ForeColor = Color.Green
                    lblMessage.Text = "Password has been changed successfully."
                Else
                    lblMessage.ForeColor = Color.Red
                    lblMessage.Text = "Password does not match with our database records."
                End If
            End Using
        Else
            lblMessage.ForeColor = Color.Red
            lblMessage.Text = "Old Password and New Password must not be equal."
        End If

        e.Cancel = True
    End Sub

End Class