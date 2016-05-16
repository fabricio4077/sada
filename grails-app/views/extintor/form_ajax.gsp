<%@ page import="estacion.Extintor" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!extintorInstance}">
    <elm:notFound elem="Extintor" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmExtintor" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${extintorInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: extintorInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-2 control-label text-info">
                    Tipo
                </label>
                <div class="col-md-6">
                    <g:select name="tipo" from="${extintorInstance.constraints.tipo.inList}" class="form-control" value="${extintorInstance?.tipo}" valueMessagePrefix="extintor.tipo" noSelection="['': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: extintorInstance, field: 'capacidad', 'error')} ">
            <span class="grupo">
                <label for="capacidad" class="col-md-2 control-label text-info">
                    Capacidad
                </label>
                <div class="col-md-6">
                    <g:select name="capacidad" from="${extintorInstance.constraints.capacidad.inList}" required="" class="inList form-control required" value="${fieldValue(bean: extintorInstance, field: 'capacidad')}" valueMessagePrefix="extintor.capacidad"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: extintorInstance, field: 'ares', 'error')} ">
            <span class="grupo">
                <label for="ares" class="col-md-2 control-label text-info">
                    Ares
                </label>
                <div class="col-md-6">
                    <g:select id="ares" name="ares.id" from="${estacion.Ares.list()}" optionKey="id" required="" value="${extintorInstance?.ares?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmExtintor").validate({
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