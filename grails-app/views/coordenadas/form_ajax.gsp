<%@ page import="estacion.Coordenadas" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!coordenadasInstance}">
    <elm:notFound elem="Coordenadas" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmCoordenadas" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${coordenadasInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: coordenadasInstance, field: 'coordenadasX', 'error')} ">
            <span class="grupo">
                <label for="coordenadasX" class="col-md-2 control-label text-info">
                    Coordenadas X
                </label>
                <div class="col-md-6">
                    <g:field name="coordenadasX" type="number" value="${fieldValue(bean: coordenadasInstance, field: 'coordenadasX')}" class="number form-control  required" required=""/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: coordenadasInstance, field: 'coordenadasY', 'error')} ">
            <span class="grupo">
                <label for="coordenadasY" class="col-md-2 control-label text-info">
                    Coordenadas Y
                </label>
                <div class="col-md-6">
                    <g:field name="coordenadasY" type="number" value="${fieldValue(bean: coordenadasInstance, field: 'coordenadasY')}" class="number form-control  required" required=""/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: coordenadasInstance, field: 'estacion', 'error')} ">
            <span class="grupo">
                <label for="estacion" class="col-md-2 control-label text-info">
                    Estacion
                </label>
                <div class="col-md-6">
                    <g:select id="estacion" name="estacion.id" from="${estacion.Estacion.list()}" optionKey="id" required="" value="${coordenadasInstance?.estacion?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCoordenadas").validate({
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