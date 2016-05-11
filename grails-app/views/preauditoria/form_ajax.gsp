<%@ page import="auditoria.Preauditoria" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!preauditoriaInstance}">
    <elm:notFound elem="Preauditoria" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmPreauditoria" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${preauditoriaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: preauditoriaInstance, field: 'actividad', 'error')} ">
            <span class="grupo">
                <label for="actividad" class="col-md-2 control-label text-info">
                    Actividad
                </label>
                <div class="col-md-6">
                    <g:select id="actividad" name="actividad.id" from="${complemento.Actividad.list()}" optionKey="id" required="" value="${preauditoriaInstance?.actividad?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: preauditoriaInstance, field: 'consultor', 'error')} ">
            <span class="grupo">
                <label for="consultor" class="col-md-2 control-label text-info">
                    Consultor
                </label>
                <div class="col-md-6">
                    <g:select id="consultor" name="consultor.id" from="${consultor.Consultor.list()}" optionKey="id" required="" value="${preauditoriaInstance?.consultor?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: preauditoriaInstance, field: 'estacion', 'error')} ">
            <span class="grupo">
                <label for="estacion" class="col-md-2 control-label text-info">
                    Estacion
                </label>
                <div class="col-md-6">
                    <g:select id="estacion" name="estacion.id" from="${estacion.Estacion.list()}" optionKey="id" required="" value="${preauditoriaInstance?.estacion?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: preauditoriaInstance, field: 'marcoLegal', 'error')} ">
            <span class="grupo">
                <label for="marcoLegal" class="col-md-2 control-label text-info">
                    Marco Legal
                </label>
                <div class="col-md-6">
                    <g:select id="marcoLegal" name="marcoLegal.id" from="${legal.MarcoLegal.list()}" optionKey="id" required="" value="${preauditoriaInstance?.marcoLegal?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: preauditoriaInstance, field: 'periodo', 'error')} ">
            <span class="grupo">
                <label for="periodo" class="col-md-2 control-label text-info">
                    Periodo
                </label>
                <div class="col-md-6">
                    <g:select id="periodo" name="periodo.id" from="${tipo.Periodo.list()}" optionKey="id" required="" value="${preauditoriaInstance?.periodo?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: preauditoriaInstance, field: 'plazo', 'error')} ">
            <span class="grupo">
                <label for="plazo" class="col-md-2 control-label text-info">
                    Plazo
                </label>
                <div class="col-md-6">
                    <g:field name="plazo" type="number" value="${preauditoriaInstance.plazo}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: preauditoriaInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-2 control-label text-info">
                    Tipo
                </label>
                <div class="col-md-6">
                    <g:select id="tipo" name="tipo.id" from="${tipo.Tipo.list()}" optionKey="id" required="" value="${preauditoriaInstance?.tipo?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmPreauditoria").validate({
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