<%@ page import="complemento.Antecedente" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!antecedenteInstance}">
    <elm:notFound elem="Antecedente" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmAntecedente" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${antecedenteInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: antecedenteInstance, field: 'oficio', 'error')} ">
            <span class="grupo">
                <label for="oficio" class="col-md-2 control-label text-info">
                    Oficio
                </label>
                <div class="col-md-6">
                    <g:textField name="oficio" class="allCaps form-control" value="${antecedenteInstance?.oficio}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: antecedenteInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" class="allCaps form-control" value="${antecedenteInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: antecedenteInstance, field: 'detalleAuditoria', 'error')} ">
            <span class="grupo">
                <label for="detalleAuditoria" class="col-md-2 control-label text-info">
                    Detalle Auditoria
                </label>
                <div class="col-md-6">
                    <g:select id="detalleAuditoria" name="detalleAuditoria.id" from="${auditoria.DetalleAuditoria.list()}" optionKey="id" required="" value="${antecedenteInstance?.detalleAuditoria?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: antecedenteInstance, field: 'fechaAprobacion', 'error')} ">
            <span class="grupo">
                <label for="fechaAprobacion" class="col-md-2 control-label text-info">
                    Fecha Aprobacion
                </label>
                <div class="col-md-6">
                    <elm:datepicker name="fechaAprobacion"  class="datepicker form-control required" value="${antecedenteInstance?.fechaAprobacion}"  />
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmAntecedente").validate({
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