<%@ page import="evaluacion.Evaluacion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!evaluacionInstance}">
    <elm:notFound elem="Evaluacion" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmEvaluacion" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${evaluacionInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: evaluacionInstance, field: 'anexo', 'error')} ">
            <span class="grupo">
                <label for="anexo" class="col-md-2 control-label text-info">
                    Anexo
                </label>
                <div class="col-md-6">
                    <g:textField name="anexo" class="allCaps form-control" value="${evaluacionInstance?.anexo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: evaluacionInstance, field: 'calificacion', 'error')} ">
            <span class="grupo">
                <label for="calificacion" class="col-md-2 control-label text-info">
                    Calificacion
                </label>
                <div class="col-md-6">
                    <g:select id="calificacion" name="calificacion.id" from="${evaluacion.Calificacion.list()}" optionKey="id" required="" value="${evaluacionInstance?.calificacion?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: evaluacionInstance, field: 'detalleAuditoria', 'error')} ">
            <span class="grupo">
                <label for="detalleAuditoria" class="col-md-2 control-label text-info">
                    Detalle Auditoria
                </label>
                <div class="col-md-6">
                    <g:select id="detalleAuditoria" name="detalleAuditoria.id" from="${auditoria.DetalleAuditoria.list()}" optionKey="id" required="" value="${evaluacionInstance?.detalleAuditoria?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: evaluacionInstance, field: 'hallazgo', 'error')} ">
            <span class="grupo">
                <label for="hallazgo" class="col-md-2 control-label text-info">
                    Hallazgo
                </label>
                <div class="col-md-6">
                    <g:select id="hallazgo" name="hallazgo.id" from="${evaluacion.Hallazgo.list()}" optionKey="id" required="" value="${evaluacionInstance?.hallazgo?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmEvaluacion").validate({
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