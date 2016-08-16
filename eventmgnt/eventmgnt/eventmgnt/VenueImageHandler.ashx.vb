Imports System.Web
Imports System.Web.Services
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data

Public Class VenueImageHandler
    Implements System.Web.IHttpHandler

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
        Dim conn As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand()
        cmd.CommandText = "Select [Content] from Venues where venueId =@ID"
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        Dim ImageID As New SqlParameter("@ID", SqlDbType.BigInt)
        ImageID.Value = context.Request.QueryString("ID")
        cmd.Parameters.Add(ImageID)
        conn.Open()
        Dim dReader As SqlDataReader = cmd.ExecuteReader()
        dReader.Read()
        context.Response.BinaryWrite(DirectCast(dReader("Content"), Byte()))
        dReader.Close()
        conn.Close()
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class