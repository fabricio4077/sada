<%@ page import="estacion.Estacion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!estacionInstance}">
    <elm:notFound elem="Estacion" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmEstacion" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${estacionInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="63" required="" class="allCaps form-control required" value="${estacionInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'administrador', 'error')} ">
            <span class="grupo">
                <label for="administrador" class="col-md-2 control-label text-info">
                    Administrador
                </label>
                <div class="col-md-6">
                    <g:textField name="administrador" maxlength="31" required="" class="allCaps form-control required" value="${estacionInstance?.administrador}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'direccion', 'error')} ">
            <span class="grupo">
                <label for="direccion" class="col-md-2 control-label text-info">
                    Direccion
                </label>
                <div class="col-md-6">
                    <g:textArea name="direccion" cols="40" rows="5" maxlength="255" required="" class="allCaps form-control required" value="${estacionInstance?.direccion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'canton', 'error')} ">
            <span class="grupo">
                <label for="canton" class="col-md-2 control-label text-info">
                    Canton
                </label>
                <div class="col-md-6">
                    <g:textField name="canton" class="allCaps form-control" value="${estacionInstance?.canton}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'comercializadora', 'error')} ">
            <span class="grupo">
                <label for="comercializadora" class="col-md-2 control-label text-info">
                    Comercializadora
                </label>
                <div class="col-md-6">
                    <g:select id="comercializadora" name="comercializadora.id" from="${estacion.Comercializadora.list()}" optionKey="id" required="" value="${estacionInstance?.comercializadora?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'coordenadas', 'error')} ">
            <span class="grupo">
                <label for="coordenadas" class="col-md-2 control-label text-info">
                    Coordenadas
                </label>

            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'mail', 'error')} ">
            <span class="grupo">
                <label for="mail" class="col-md-2 control-label text-info">
                    Mail
                </label>
                <div class="col-md-6">
                    <g:textField name="mail" class="allCaps form-control" value="${estacionInstance?.mail}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-6">
                    <g:textField name="observaciones" class="allCaps form-control" value="${estacionInstance?.observaciones}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'provincia', 'error')} ">
            <span class="grupo">
                <label for="provincia" class="col-md-2 control-label text-info">
                    Provincia
                </label>
                <div class="col-md-6">
                    <g:select id="provincia" name="provincia.id" from="${estacion.Provincia.list()}" optionKey="id" required="" value="${estacionInstance?.provincia?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'representante', 'error')} ">
            <span class="grupo">
                <label for="representante" class="col-md-2 control-label text-info">
                    Representante
                </label>
                <div class="col-md-6">
                    <g:textField name="representante" class="allCaps form-control" value="${estacionInstance?.representante}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estacionInstance, field: 'telefono', 'error')} ">
            <span class="grupo">
                <label for="telefono" class="col-md-2 control-label text-info">
                    Teléfono
                </label>
                <div class="col-md-6">
                    <g:textField name="telefono" class="form-control number" value="${estacionInstance?.telefono}"/>
                </div>

            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmEstacion").validate({
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