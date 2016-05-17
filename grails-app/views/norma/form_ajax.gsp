<%@ page import="legal.Norma" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!normaInstance}">
    <elm:notFound elem="Norma" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmNorma" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${normaInstance?.id}" />
        <g:hiddenField name="marco" value="${marco}"/>


        <div class="col-md-12">
            <div class="col-md-6 form-group ${hasErrors(bean: normaInstance, field: 'tipoNorma', 'error')} ">
            <span class="grupo">
                <label for="tipoNorma" class="col-md-4 control-label text-info">
                    Tipo de Norma
                </label>
                <div class="col-md-8">
                    <g:select id="tipoNorma" name="tipoNorma.id" from="${legal.TipoNorma.list()}" optionKey="id" optionValue="descripcion" required="" value="${normaInstance?.tipoNorma?.id}" class="many-to-one form-control"/>
                </div>

            </span>
        </div>


            <div class="col-md-6 form-group ${hasErrors(bean: normaInstance, field: 'anio', 'error')} ">
                <span class="grupo">
                    <label for="anio" class="col-md-6 control-label text-info">
                        Año
                    </label>
                    <div class="col-md-6">
                        <g:datePicker name="anio" precision="year" class="form-control required" value="${normaInstance?.anio}"/>
                    </div>

                </span>
            </div>
        </div>

        <div class="form-group ${hasErrors(bean: normaInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textArea name="nombre" cols="40" rows="5" maxlength="254" style="width: 375px; height: 50px; resize: none" required="" class="form-control required" value="${normaInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: normaInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    <g:textArea name="descripcion" cols="40" rows="5" style="height: 120px; width:375px;resize: none " maxlength="1023" required="" class="form-control required" value="${normaInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>


        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmNorma").validate({
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