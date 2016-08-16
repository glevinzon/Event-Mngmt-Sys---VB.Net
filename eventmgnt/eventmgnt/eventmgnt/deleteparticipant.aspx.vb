Imports System.Data
Imports System.Globalization
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO
Public Class deleteparticipant
    Inherits System.Web.UI.Page
    Protected s_userName As String = User.Identity.Name

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("attendeeId") IsNot Nothing Then
            Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("DELETE FROM Attendees WHERE attendeeId = @aId")
                    cmd.Parameters.AddWithValue("@aId", Request.QueryString("attendeeId"))
                    cmd.Connection = con
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                End Using
            End Using
            If s_userName = "superadmin" Then
                Dim meta As New HtmlMeta()
                meta.HttpEquiv = "Refresh"
                meta.Content = "0;url=webadmin.aspx"
                Me.Page.Controls.Add(meta)
            Else
                If s_userName = "superadmin" Then
                    Dim meta As New HtmlMeta()
                    meta.HttpEquiv = "Refresh"
                    meta.Content = "0;url=webadmin.aspx"
                    Me.Page.Controls.Add(meta)
                Else
                    Dim meta As New HtmlMeta()
                    meta.HttpEquiv = "Refresh"
                    meta.Content = "0;url=manage.aspx"
                    Me.Page.Controls.Add(meta)
                End If
            End If
        Else
            Dim meta As New HtmlMeta()
            meta.HttpEquiv = "Refresh"
            meta.Content = "0;url=manage.aspx"
            Me.Page.Controls.Add(meta)
        End If
    End Sub

End Class