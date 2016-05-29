<%@ page import="plan.Medida" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!medidaInstance}">
    <elm:notFound elem="Medida" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmMedida" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${medidaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: medidaInstance, field: 'plazo', 'error')} ">
            <span class="grupo">
                <label for="plazo" class="col-md-2 control-label text-info">
                    Plazo
                </label>
                <div class="col-md-6">
                    <g:select name="plazo" from="${medidaInstance.constraints.plazo.inList}" class="form-control" value="${medidaInstance?.plazo}" valueMessagePrefix="medida.plazo" noSelection="['': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: medidaInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" class="allCaps form-control" value="${medidaInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: medidaInstance, field: 'indicadores', 'error')} ">
            <span class="grupo">
                <label for="indicadores" class="col-md-2 control-label text-info">
                    Indicadores
                </label>
                <div class="col-md-6">
                    <g:textField name="indicadores" class="allCaps form-control" value="${medidaInstance?.indicadores}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: medidaInstance, field: 'verificacion', 'error')} ">
            <span class="grupo">
                <label for="verificacion" class="col-md-2 control-label text-info">
                    Verificacion
                </label>
                <div class="col-md-6">
                    <g:textField name="verificacion" class="allCaps form-control" value="${medidaInstance?.verificacion}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmMedida").validate({
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