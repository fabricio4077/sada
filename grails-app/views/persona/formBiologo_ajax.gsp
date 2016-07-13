<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/04/2016
  Time: 12:17
--%>

<%@ page import="Seguridad.Persona" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

 <g:form class="form-horizontal" name="frmBiologo" role="form" action="" method="POST">
        <g:hiddenField name="id" value="${personaInstance?.id}" />

        <div class="row col-lg-12">
            <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} ">
                <span class="grupo">
                    <label for="nombre" class="col-md-4 control-label text-info">
                        Nombres
                    </label>
                    <div class="col-md-8">
                        <g:textField name="nombre_name" id="nombre" maxlength="31" required="" class="form-control required" value="${personaInstance?.nombre}"/>
                    </div>

                </span>
            </div>

            <div class=" col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} ">
                <span class="grupo">
                    <label for="apellido" class="col-md-4 control-label text-info">
                        Apellidos
                    </label>
                    <div class="col-md-8">
                        <g:textField name="apellido_name" id="apellido" maxlength="31" required="" class="form-control required" value="${personaInstance?.apellido}"/>
                    </div>

                </span>
            </div>
        </div>

        <div class="row col-lg-12">
            <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
                <span class="grupo">
                    <label for="telefono" class="col-md-4 control-label text-info" style="margin-right: 17px">
                        Teléfono
                    </label>
                    <div class="input-group col-md-7">
                        <span class="input-group-addon"><i class="fa fa-phone fa-fw"></i></span>
                        <g:textField name="telefono_name" id="telefono" class="form-control number" value="${personaInstance?.telefono}"/>
                    </div>

                </span>
            </div>
            <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'mail', 'error')} ">
                <span class="grupo">
                    <label for="mail" class="col-md-4 control-label text-info" style="margin-right: 17px">
                        Mail
                    </label>
                    <div class="input-group margin-bottom-sm col-md-7">
                        <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></span>
                        <g:textField name="mail_name" id="mail" class="form-control" value="${personaInstance?.mail}" placeholder="Email"/>
                    </div>
                </span>
            </div>
        </div>

     <div class="row col-lg-12">
         <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
             <span class="grupo">
                 <label for="cargo" class="col-md-4 control-label text-info" style="margin-right: 17px">
                     Cargo
                 </label>
                 <div class="input-group col-md-7">
                     <span class="input-group-addon"><i class="fa fa-child fa-fw"></i></span>
                     <g:if test="${tipo == 'coordinador'}">
                         <g:textField name="cargo_name" id="cargo" class="form-control" value="${'Coordinador'}" readonly="true"/>
                     </g:if>
                     <g:if test="${tipo == 'biologo'}">
                         <g:textField name="cargo_name" id="cargo" class="form-control" value="${'Biólogo'}" readonly="true"/>
                     </g:if>
                     <g:if test="${tipo == 'especialista'}">
                         <g:textField name="cargo_name" id="cargo" class="form-control" value="${'Especialista'}" readonly="true"/>
                     </g:if>
                 </div>
             </span>
         </div>

         <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
             <span class="grupo">
                 <label for="titulo" class="col-md-4 control-label text-info" style="margin-right: 17px">
                     Título
                 </label>
                 <div class="input-group col-md-7">
                     <span class="input-group-addon"><i class="fa fa-graduation-cap fa-fw"></i></span>
                     <g:select from="${['Ingeniero','Doctor','Biólogo']}" name="titulo_name" id="titulo" class="form-control" />
                 </div>
             </span>
         </div>
     </div>


        %{--<div class="form-group ${hasErrors(bean: personaInstance, field: 'activo', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="activo" class="col-md-2 control-label text-info">--}%
                    %{--Activo--}%
                %{--</label>--}%
                %{--<div class="col-md-6">--}%
                    %{--<g:select name="activo" from="[1: 'ACTIVO', 0: 'NO ACTIVO']" class="form-control required"--}%
                              %{--value="${personaInstance?.activo}" optionKey="key" optionValue="value" />--}%
                %{--</div>--}%
            %{--</span>--}%
        %{--</div>--}%
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmBiologo").validate({
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
