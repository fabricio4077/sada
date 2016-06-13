<%@ page import="situacion.SituacionAmbiental" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!situacionAmbientalInstance}">
    <elm:notFound elem="SituacionAmbiental" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmSituacionAmbiental" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${situacionAmbientalInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: situacionAmbientalInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" class="allCaps form-control" value="${situacionAmbientalInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: situacionAmbientalInstance, field: 'analisisLiquidas', 'error')} ">
            <span class="grupo">
                <label for="analisisLiquidas" class="col-md-2 control-label text-info">
                    Analisis Liquidas
                </label>
                <div class="col-md-6">
                    <g:select id="analisisLiquidas" name="analisisLiquidas.id" from="${situacion.AnalisisLiquidas.list()}" optionKey="id" value="${situacionAmbientalInstance?.analisisLiquidas?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: situacionAmbientalInstance, field: 'componenteAmbiental', 'error')} ">
            <span class="grupo">
                <label for="componenteAmbiental" class="col-md-2 control-label text-info">
                    Componente Ambiental
                </label>
                <div class="col-md-6">
                    <g:select id="componenteAmbiental" name="componenteAmbiental.id" from="${situacion.ComponenteAmbiental.list()}" optionKey="id" value="${situacionAmbientalInstance?.componenteAmbiental?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: situacionAmbientalInstance, field: 'detalleAuditoria', 'error')} ">
            <span class="grupo">
                <label for="detalleAuditoria" class="col-md-2 control-label text-info">
                    Detalle Auditoria
                </label>
                <div class="col-md-6">
                    <g:select id="detalleAuditoria" name="detalleAuditoria.id" from="${auditoria.DetalleAuditoria.list()}" optionKey="id" required="" value="${situacionAmbientalInstance?.detalleAuditoria?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmSituacionAmbiental").validate({
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