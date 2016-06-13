<%@ page import="complemento.Alcance" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!alcanceInstance}">
    <elm:notFound elem="Alcance" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmAlcance" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${alcanceInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: alcanceInstance, field: 'auditoria', 'error')} ">
            <span class="grupo">
                <label for="auditoria" class="col-md-2 control-label text-info">
                    Auditoria
                </label>
                <div class="col-md-6">
                    <g:select id="auditoria" name="auditoria.id" from="${auditoria.Auditoria.list()}" optionKey="id" required="" value="${alcanceInstance?.auditoria?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: alcanceInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" class="allCaps form-control" value="${alcanceInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmAlcance").validate({
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
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>