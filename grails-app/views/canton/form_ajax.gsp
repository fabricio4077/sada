<%@ page import="estacion.Canton" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!cantonInstance}">
    <elm:notFound elem="Canton" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmCanton" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${cantonInstance?.id}" />

        <div class="form-group ${hasErrors(bean: cantonInstance, field: 'provincia', 'error')} ">
            <span class="grupo">
                <label for="provincia" class="col-md-2 control-label text-info">
                    Provincia
                </label>
                <div class="col-md-6">
                    <g:select id="provincia" name="provincia.id" from="${estacion.Provincia.list()}" optionKey="id" optionValue="nombre" required="" value="${cantonInstance?.provincia?.id}" class="many-to-one form-control"/>
                </div>

            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: cantonInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" class="form-control" value="${cantonInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        

        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCanton").validate({
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