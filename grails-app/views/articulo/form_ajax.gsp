<%@ page import="legal.Articulo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!articuloInstance}">
    <elm:notFound elem="Articulo" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmArticulo" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${articuloInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: articuloInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textArea name="descripcion" cols="40" rows="5" maxlength="1023" class="allCaps form-control" value="${articuloInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: articuloInstance, field: 'norma', 'error')} ">
            <span class="grupo">
                <label for="norma" class="col-md-2 control-label text-info">
                    Norma
                </label>
                <div class="col-md-6">
                    <g:select id="norma" name="norma.id" from="${legal.Norma.list()}" optionKey="id" required="" value="${articuloInstance?.norma?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: articuloInstance, field: 'numero', 'error')} ">
            <span class="grupo">
                <label for="numero" class="col-md-2 control-label text-info">
                    Numero
                </label>
                <div class="col-md-6">
                    <g:field name="numero" type="number" value="${articuloInstance.numero}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmArticulo").validate({
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