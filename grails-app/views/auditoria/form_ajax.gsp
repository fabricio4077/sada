<%@ page import="auditoria.Auditoria" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!auditoriaInstance}">
    <elm:notFound elem="Auditoria" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmAuditoria" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${auditoriaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: auditoriaInstance, field: 'metodologia', 'error')} ">
            <span class="grupo">
                <label for="metodologia" class="col-md-2 control-label text-info">
                    Metodologia
                </label>
                <div class="col-md-6">
                    <g:select id="metodologia" name="metodologia.id" from="${metodologia.Metodologia.list()}" optionKey="id" value="${auditoriaInstance?.metodologia?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: auditoriaInstance, field: 'marcoLegal', 'error')} ">
            <span class="grupo">
                <label for="marcoLegal" class="col-md-2 control-label text-info">
                    Marco Legal
                </label>
                <div class="col-md-6">
                    <g:select id="marcoLegal" name="marcoLegal.id" from="${legal.MarcoLegal.list()}" optionKey="id" value="${auditoriaInstance?.marcoLegal?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: auditoriaInstance, field: 'fechaAprobacion', 'error')} ">
            <span class="grupo">
                <label for="fechaAprobacion" class="col-md-2 control-label text-info">
                    Fecha Aprobacion
                </label>
                <div class="col-md-6">
                    <elm:datepicker name="fechaAprobacion"  class="datepicker form-control required" value="${auditoriaInstance?.fechaAprobacion}"  />
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: auditoriaInstance, field: 'fechaFin', 'error')} ">
            <span class="grupo">
                <label for="fechaFin" class="col-md-2 control-label text-info">
                    Fecha Fin
                </label>
                <div class="col-md-6">
                    <elm:datepicker name="fechaFin"  class="datepicker form-control required" value="${auditoriaInstance?.fechaFin}"  />
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: auditoriaInstance, field: 'fechaInicio', 'error')} ">
            <span class="grupo">
                <label for="fechaInicio" class="col-md-2 control-label text-info">
                    Fecha Inicio
                </label>
                <div class="col-md-6">
                    <elm:datepicker name="fechaInicio"  class="datepicker form-control required" value="${auditoriaInstance?.fechaInicio}"  />
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: auditoriaInstance, field: 'preauditoria', 'error')} ">
            <span class="grupo">
                <label for="preauditoria" class="col-md-2 control-label text-info">
                    Preauditoria
                </label>
                <div class="col-md-6">
                    <g:select id="preauditoria" name="preauditoria.id" from="${auditoria.Preauditoria.list()}" optionKey="id" required="" value="${auditoriaInstance?.preauditoria?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmAuditoria").validate({
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