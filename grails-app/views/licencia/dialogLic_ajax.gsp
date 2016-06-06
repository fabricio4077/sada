<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 05/06/2016
  Time: 14:25
--%>
<g:form class="form-horizontal" name="frmLicencia" role="form" action="save" method="POST">
    <g:hiddenField name="detalle" value="${pre?.id}"/>
<div class="form-group">
    <span class="grupo">
        <label for="descripcion" class="col-md-2 control-label text-info">
            Descripcion:
        </label>
        <div class="col-md-9">
            <g:textArea name="descripcion" maxlength="1023" class="form-control required" style="height: 200px; resize: none"/>
        </div>
    </span>
</div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmLicencia").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });
</script>


