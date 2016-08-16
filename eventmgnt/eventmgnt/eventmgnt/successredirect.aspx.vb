Public Class successredirect
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If

        Dim meta As New HtmlMeta()
        meta.HttpEquiv = "Refresh"
        meta.Content = "7.5;url=view.aspx?eventId=" + Request.QueryString("eventId")
        Me.Page.Controls.Add(meta)
    End Sub

End Class