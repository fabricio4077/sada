<%@ page import="evaluacion.PlanAccion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!planAccionInstance}">
    <elm:notFound elem="PlanAccion" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmPlanAccion" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${planAccionInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'actividad', 'error')} ">
            <span class="grupo">
                <label for="actividad" class="col-md-2 control-label text-info">
                    Actividad
                </label>
                <div class="col-md-6">
                    <g:textField name="actividad" class="allCaps form-control" value="${planAccionInstance?.actividad}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'responsable', 'error')} ">
            <span class="grupo">
                <label for="responsable" class="col-md-2 control-label text-info">
                    Responsable
                </label>
                <div class="col-md-6">
                    <g:textField name="responsable" class="allCaps form-control" value="${planAccionInstance?.responsable}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'estado', 'error')} ">
            <span class="grupo">
                <label for="estado" class="col-md-2 control-label text-info">
                    Estado
                </label>
                <div class="col-md-6">
                    <g:textField name="estado" class="allCaps form-control" value="${planAccionInstance?.estado}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'avance', 'error')} ">
            <span class="grupo">
                <label for="avance" class="col-md-2 control-label text-info">
                    Avance
                </label>
                <div class="col-md-6">
                    <g:textField name="avance" class="allCaps form-control" value="${planAccionInstance?.avance}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'costo', 'error')} ">
            <span class="grupo">
                <label for="costo" class="col-md-2 control-label text-info">
                    Costo
                </label>
                <div class="col-md-6">
                    <g:textField name="costo" class="allCaps form-control" value="${planAccionInstance?.costo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'verficacion', 'error')} ">
            <span class="grupo">
                <label for="verficacion" class="col-md-2 control-label text-info">
                    Verficacion
                </label>
                <div class="col-md-6">
                    <g:textField name="verficacion" class="allCaps form-control" value="${planAccionInstance?.verficacion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'hallazgo', 'error')} ">
            <span class="grupo">
                <label for="hallazgo" class="col-md-2 control-label text-info">
                    Hallazgo
                </label>
                <div class="col-md-6">
                    <g:select id="hallazgo" name="hallazgo.id" from="${evaluacion.Hallazgo.list()}" optionKey="id" required="" value="${planAccionInstance?.hallazgo?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: planAccionInstance, field: 'plazo', 'error')} ">
            <span class="grupo">
                <label for="plazo" class="col-md-2 control-label text-info">
                    Plazo
                </label>
                <div class="col-md-6">
                    <g:field name="plazo" type="number" value="${planAccionInstance.plazo}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmPlanAccion").validate({
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