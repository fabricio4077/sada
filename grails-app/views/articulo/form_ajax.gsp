<%@ page import="legal.Articulo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!articuloInstance}">
    <elm:notFound elem="Articulo" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmArticulo" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${articuloInstance?.id}" />
        <g:hiddenField name="papa" value="${papa}" />
        <g:hiddenField name="mc" value="${mctp?.id}"/>


        <div class="form-group ${hasErrors(bean: articuloInstance, field: 'norma', 'error')} ">
            <span class="grupo">
                <label for="norma" class="col-md-2 control-label text-info">
                    Norma
                </label>
                    <div class="col-md-6">
                        <g:hiddenField name="norma_id" value="${normaExistente?.id}" class="normaFija"/>
                       <g:textField name="norma.id" id="norma" value="${normaExistente?.nombre}" class="form-control" readonly="true"/>
                    </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: articuloInstance, field: 'numero', 'error')} ">
            <span class="grupo">
                <label for="numero" class="col-md-2 control-label text-info">
                    Art. N°
                </label>
                <div class="col-md-3">
                    <g:textField name="numero" value="${articuloInstance.numero}" maxlength="4" class="digits form-control number required noEspacios" required=""/>
                </div>

                <label for="seleccionado" class="col-md-5 control-label text-info">
                    Se usará este artículo en la evaluación ambiental?
                </label>
                <div class="col-md-1">
                    <g:checkBox name="seleccionado" checked="${(mctp?.seleccionado == 1) ? 'true' : 'false'}"/>
                </div>
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: articuloInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    <g:textArea name="descripcion" cols="40" rows="5" maxlength="6000" class="form-control"
                                style="width: 430px; height: 420px; resize: none" value="${articuloInstance?.descripcion}"/>
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
            },
            rules         : {
                numero : {
                    remote: {
                        url : "${createLink(action: 'validar_numero_ajax')}",
                        type: "post",
                        data: {
                            id: $(".normaFija").val()
                        }
                    }
                }
            },
            messages      : {
                numero : {
                    remote: "Ya existe este número de artículo"
                }
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