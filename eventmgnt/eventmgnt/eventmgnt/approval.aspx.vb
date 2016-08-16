Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO

Public Class approval
    Inherits System.Web.UI.Page
    Protected s_userName As String = User.Identity.Name

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("aId") IsNot Nothing Then
            If Request.QueryString("attendstatus") IsNot Nothing Then
                If Request.QueryString("attendstatus").Equals("approve") Then
                    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                    Dim cmd As New SqlCommand()
                    cmd.CommandText = "UPDATE Attendees SET payment = 2 WHERE attendeeId=" + "'" + Request.QueryString("aId") + "'"
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = conn

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()

                ElseIf Request.QueryString("attendstatus").Equals("disapprove") Then
                    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                    Dim cmd As New SqlCommand()
                    cmd.CommandText = "UPDATE Attendees SET payment = 1 WHERE attendeeId=" + "'" + Request.QueryString("aId") + "'"
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = conn

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                Else
                    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                    Dim cmd As New SqlCommand()
                    cmd.CommandText = "UPDATE Attendees SET payment = 0 WHERE attendeeId=" + "'" + Request.QueryString("aId") + "'"
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = conn

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End If
            End If
            
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


        If Request.QueryString("eventId") IsNot Nothing Then
            If Request.QueryString("status") IsNot Nothing Then
                If Request.QueryString("status").Equals("approve") Then
                    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                    Dim cmd As New SqlCommand()
                    cmd.CommandText = "UPDATE Events SET Approval = 2 WHERE eventId=" + "'" + Request.QueryString("eventId") + "'"
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = conn

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()

                ElseIf Request.QueryString("status").Equals("disapprove") Then
                    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                    Dim cmd As New SqlCommand()
                    cmd.CommandText = "UPDATE Events SET Approval = 1 WHERE eventId=" + "'" + Request.QueryString("eventId") + "'"
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = conn

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                Else
                    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("constr").ConnectionString)

                    Dim cmd As New SqlCommand()
                    cmd.CommandText = "UPDATE Events SET Approval = 0 WHERE eventId=" + "'" + Request.QueryString("eventId") + "'"
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = conn

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End If
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


        End If
    End Sub

End Class