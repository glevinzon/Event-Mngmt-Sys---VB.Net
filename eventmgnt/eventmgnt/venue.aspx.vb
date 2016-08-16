Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data
Public Class venue
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim connectionString As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
            Dim dt As New DataTable()
            Dim conn As New SqlConnection(connectionString)
            Using conn
                Dim ad As New SqlDataAdapter("SELECT * FROM Venues", conn)
                ad.Fill(dt)
            End Using
            GVImages.DataSource = dt
            GVImages.DataBind()
        End If
    End Sub

End Class