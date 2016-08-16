Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO

Public Class _default
    Inherits System.Web.UI.Page
    Protected s_userName As String = User.Identity.Name

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If

        hyperlink1.Text = s_userName
        If Not IsPostBack Then
            hyperlink3.NavigateUrl = "~/viewprofile.aspx?uname=" + s_userName
            If s_userName = "superadmin" Then
                hyperlink5.NavigateUrl = "~/webadmin.aspx"
            Else
                hyperlink5.NavigateUrl = "~/manage.aspx"
            End If
            Dim dt As DataTable = Me.GetData(0)
            PopulateMenu(dt, 0, Nothing)

            Dim dDate As DateTime
            If Request("SpecificMonth") IsNot Nothing Then
                dDate = Convert.ToDateTime(Request("SpecificMonth"))
            Else
                dDate = DateTime.Now
            End If

            ' Here you need to made the datastructure in such a way that you can bind the data in your datalist easily.
            ' So give concentration on database query to produce data like below:
            ' You can display each event, description if you can make the data row appropriately.

            Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
            Dim dtEvents As New DataTable("DailyEvents")
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("SELECT * FROM Events WHERE Approval = '2'")
                    cmd.Connection = con
                    Using sda As New SqlDataAdapter(cmd)

                        dtEvents.Columns.Add(New DataColumn("DateTime", System.Type.[GetType]("System.DateTime")))
                        dtEvents.Columns.Add(New DataColumn("Name"))
                        dtEvents.Columns.Add(New DataColumn("Venue"))
                        dtEvents.Columns.Add(New DataColumn("Fee"))
                        dtEvents.Columns.Add(New DataColumn("Approval"))

                        sda.Fill(dtEvents)
                    End Using
                End Using
            End Using



            'dtEvents.Rows.Add(DateTime.Now, "Meeting", "BSSOM", "Attended?", "Agenda: 1)Indexing problem in ABC server. 2) Fix time to go Live. 3) Who will be responsible to maintain it?")
            'dtEvents.Rows.Add(DateTime.Now.AddDays(5), "Travel", " <a href='about.aspx'>Coxsbazar</a>", "Visited?", "Agenda: 1) Go to barmiz market 2) Buy few cloths for my wife 3) Eat rupchanda fish")
            'dtEvents.Rows.Add(DateTime.Now, "Assignment", "Audit", "R&D Done?", "")
            'dtEvents.Rows.Add(DateTime.Now, "Rport", "Fin. report", "Ready?", "")
            'dtEvents.Rows.Add(DateTime.Now.AddDays(5), "Birthday", " <a href='view.aspx?dDate=" & DateTime.Now.AddDays(5).ToString("dd/MM/yyyy") & "'>Shumon</a>", "Send gift?", "")

            Dim datatable As New DataTable()
            datatable.Columns.Add("Day")
            'day contains day of the month
            datatable.Columns.Add("Data")
            'run time produce html & just place on it.
            Dim oRow As DataRow

            For i As Integer = 1 To DateTime.DaysInMonth(dDate.Year, dDate.Month)

                Dim dCalendarDay As New DateTime(dDate.Year, dDate.Month, i)
                oRow = datatable.NewRow()
                ' here i am preparing data for a specific day. 
                ' bworkingday method return: does the day is off or not. 
                ' You can apply you business logic in this function to reurn data. 
                ' by getEvents method i collect this day events from my all data. 
                ' you can add control & event handler in runtime for more interactive calendar.
                If Not bWorkingDay(dCalendarDay) Then
                    oRow("Data") = "<div style='color:Black'>" & i.ToString() & "<br/><div style='color:#778899'>" & dCalendarDay.ToString("ddd") & "<div style='color:Black; text-align: left;'>" & " " & getEvents(dCalendarDay, dtEvents) & "<br/>"
                Else
                    oRow("Data") = "<div style='color:Black'>" & i.ToString() & "<br/><div style='color:Red'>" & dCalendarDay.ToString("ddd") & " " & getEvents(dCalendarDay, dtEvents)
                End If

                datatable.Rows.Add(oRow)
            Next

            dlCalendar.DataSource = datatable
            dlCalendar.DataBind()

            ' here just i am making current date block. 
            If dDate.Year = DateTime.Now.Year AndAlso dDate.Month = DateTime.Now.Month Then
                For Each oItem As DataListItem In dlCalendar.Items
                    If oItem.ItemIndex = DateTime.Now.Day - 1 Then
                        oItem.BorderStyle = BorderStyle.Solid
                        oItem.BorderColor = System.Drawing.Color.DeepSkyBlue
                        oItem.BorderWidth = 2
                        ' if closed 
                    End If
                    ' for closed
                Next
                ' if closed
            End If
        End If
        ' !IsPostBack
    End Sub
    Public Function getEvents(dDate As DateTime, dTable As DataTable) As String

        Dim str As String = "<br/>"
        Dim sUrl As String = ""
        For Each oItem As DataRow In dTable.Rows
            Dim eid As String = oItem("eventId")
            Dim link As HyperLink = New HyperLink()
            link.Text = oItem("Name")
            link.NavigateUrl = "~/view.aspx?eventId=" + eid

            Dim sb As New StringBuilder()
            Dim sw As New StringWriter(sb)
            Dim ht As HtmlTextWriter = New HtmlTextWriter(sw)
            link.RenderControl(ht)
            sw.Close()
            Dim rendered = sw.ToString


            If Convert.ToDateTime(oItem("DateTime").ToString()).ToString("dd MMM, yyyy") = dDate.ToString("dd MMM, yyyy") Then
                str = ((str & " ") + rendered & " @ ") + oItem("Venue") & "<br/> "
            End If
        Next
        Return str
    End Function

    Public Function bWorkingDay(bDate As DateTime) As Boolean
        ' here i am assuming the sunday as holiday but you can make it more efficiently
        ' by using a databse if you want to generate country based calendar.
        ' In different country they have different holidays schedule.
        If bDate.ToString("ddd") = "Sun" Then
            Return True
        End If
        Return False
    End Function


    Protected Sub dlCalendar_ItemDataBound(sender As Object, e As DataListItemEventArgs)
        ' Just populationg my header section
        Dim dDate As DateTime
        If Request("SpecificMonth") IsNot Nothing Then
            dDate = Convert.ToDateTime(Request("SpecificMonth"))
        Else
            dDate = DateTime.Now
        End If
        If e.Item.ItemType = ListItemType.Header Then
            Dim oPrev As DropDownList = DirectCast(e.Item.FindControl("cboPrev"), DropDownList)
            Dim oNext As DropDownList = DirectCast(e.Item.FindControl("cboNext"), DropDownList)
            Dim dtYear As New DataTable()
            dtYear.Columns.Add("year4")
            dtYear.Columns.Add("sValue")
            'here i am assuming that when user click on 2009 he wants to see january 2009 calendar.
            'it will be more interective if you generate the current month(shown in the page) calendar.
            dtYear.Rows.Add("2014", "01 Jan, 2014")
            dtYear.Rows.Add("2015", "01 Jan, 2015")
            dtYear.Rows.Add("2016", "01 Jan, 2016")
            oPrev.DataTextField = "year4"
            oPrev.DataValueField = "sValue"
            oPrev.DataSource = dtYear
            oPrev.DataBind()
            oNext.DataTextField = "year4"
            oNext.DataValueField = "sValue"
            oNext.DataSource = dtYear
            oNext.DataBind()

            DirectCast(e.Item.FindControl("lblLeft"), Label).Text = "<a style=color:Black href=default.aspx?SpecificMonth=" & dDate.AddMonths(-1).ToString("dd-MMMM-yyyy") & ">" & dDate.AddMonths(-1).ToString("MMMM yyyy") & "</a>"
            DirectCast(e.Item.FindControl("lblMiddle"), Label).Text = dDate.ToString("MMMM yyyy")

            DirectCast(e.Item.FindControl("lblRight"), Label).Text = "<a style=color:Black href=default.aspx?SpecificMonth=" & dDate.AddMonths(+1).ToString("dd-MMMM-yyyy") & ">" & dDate.AddMonths(+1).ToString("MMMM yyyy") & "</a>"
        End If
    End Sub

    Protected Sub RfreshData(sender As Object, e As System.EventArgs)
        'redirect by date thats why page can render the calendar according to user selection
        Response.Redirect("default.aspx?SpecificMonth=" + DirectCast(sender, DropDownList).SelectedValue)
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