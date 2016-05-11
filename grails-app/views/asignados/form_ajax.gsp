<%@ page import="consultor.Asignados" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!asignadosInstance}">
    <elm:notFound elem="Asignados" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmAsignados" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${asignadosInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: asignadosInstance, field: 'persona', 'error')} ">
            <span class="grupo">
                <label for="persona" class="col-md-2 control-label text-info">
                    Persona
                </label>
                <div class="col-md-6">
                    <g:select id="persona" name="persona.id" from="${Seguridad.Persona.list()}" optionKey="id" required="" value="${asignadosInstance?.persona?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: asignadosInstance, field: 'preauditoria', 'error')} ">
            <span class="grupo">
                <label for="preauditoria" class="col-md-2 control-label text-info">
                    Preauditoria
                </label>
                <div class="col-md-6">
                    <g:select id="preauditoria" name="preauditoria.id" from="${auditoria.Preauditoria.list()}" optionKey="id" required="" value="${asignadosInstance?.preauditoria?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmAsignados").validate({
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