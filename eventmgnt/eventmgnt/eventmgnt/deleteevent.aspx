<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="deleteevent.aspx.vb" Inherits="eventmgnt.deleteevent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        $('#modal-from-dom').on('show', function () {
            var id = $(this).data('id'),
                removeBtn = $(this).find('.danger');

            removeBtn.attr('href', removeBtn.attr('href').replace(/(&|\?)ref=\d*/, '$1ref=' + id));

            $('#debug-url').html('Delete URL: <strong>' + removeBtn.attr('href') + '</strong>');
        });

        $('.confirm-delete').on('click', function (e) {
            e.preventDefault();

            var id = $(this).data('id');
            $('#modal-from-dom').data('id', id).modal('show');
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="modal-from-dom" class="modal hide fade">
    <div class="modal-header">
        <a href="#" class="close">&times;</a>
         <h3>Delete URL</h3>
    </div>
    <div class="modal-body">
        <p>You are about to delete one track url, this procedure is irreversible.</p>
        <p>Do you want to proceed?</p>
        <p id="debug-url"></p>
    </div>
    <div class="modal-footer">
        <a href="delete.php?ref=" class="btn danger">Yes</a>
        <!-- <a href="delete.php?some=param&ref=" class="btn danger">Yes 2</a> -->
        <a href="#" data-dismiss="modal" class="btn secondary">No</a>
    </div>
</div>

<a href="#" class="confirm-delete" data-id="23">Delete</a><br>
<a href="#" class="confirm-delete" data-id="54">Delete</a>
    </form>
</body>
</html>
