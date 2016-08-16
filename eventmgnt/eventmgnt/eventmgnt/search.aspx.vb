Imports System.IO
Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient

Public Class search
    Inherits System.Web.UI.Page
    Private Shared PageSize As Integer = 5
    Protected s_userName As String = User.Identity.Name
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            hyperlink3.NavigateUrl = "~/viewprofile.aspx?uname=" + s_userName
            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)
            BindDummyRow()
        End If
        hyperlink1.Text = s_userName
        If s_userName = "superadmin" Then
            hyperlink5.NavigateUrl = "~/webadmin.aspx"
        Else
            hyperlink5.NavigateUrl = "~/manage.aspx"
        End If
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If
        
    End Sub
    Private Sub BindDummyRow()
        Dim dummy As New DataTable()
        dummy.Columns.Add("eventId")
        dummy.Columns.Add("Name")
        dummy.Columns.Add("DateTime")
        dummy.Columns.Add("endDateTime")
        dummy.Columns.Add("Venue")
        dummy.Columns.Add("Fee")
        dummy.Columns.Add("Approval")
        dummy.Rows.Add()
        gvCustomers.DataSource = dummy
        gvCustomers.DataBind()
    End Sub
    <WebMethod()> _
    Public Shared Function GetCustomers(searchTerm As String, pageIndex As Integer) As String
        Dim query As String = "[GetCustomers_Pager]"
        Dim cmd As New SqlCommand(query)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SearchTerm", searchTerm)
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex)
        cmd.Parameters.AddWithValue("@PageSize", PageSize)
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output
        Return GetData(cmd, pageIndex).GetXml()
    End Function

    Private Shared Function GetData(cmd As SqlCommand, pageIndex As Integer) As DataSet
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
        Using con As New SqlConnection(strConnString)
            Using sda As New SqlDataAdapter()
                cmd.Connection = con
                sda.SelectCommand = cmd
                Using ds As New DataSet()
                    sda.Fill(ds, "Events")
                    Dim dt As New DataTable("Pager")
                    dt.Columns.Add("PageIndex")
                    dt.Columns.Add("PageSize")
                    dt.Columns.Add("RecordCount")
                    dt.Rows.Add()
                    dt.Rows(0)("PageIndex") = pageIndex
                    dt.Rows(0)("PageSize") = PageSize
                    dt.Rows(0)("RecordCount") = cmd.Parameters("@RecordCount").Value
                    ds.Tables.Add(dt)
                    Return ds
                End Using
            End Using
        End Using
    End Function
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