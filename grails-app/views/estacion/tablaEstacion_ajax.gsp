<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 12/04/2016
  Time: 20:43
--%>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<g:form name="frmEstacionTabla">

<div class="row col-lg-12">
    <span class="grupo">
        <label for="nombre" class="col-md-2 control-label text-info">
            Nombre
        </label>
        <div class="col-md-6">
            <g:textField name="nombre_name" id="nombre" maxlength="63" required="" class="form-control required" value="${est?.nombre}"/>
        </div>
    </span>
</div>


<div class="row col-lg-12">
    <span class="grupo">
    <label for="comercializadora" class="col-md-2 control-label text-info">
        Comercializadora
    </label>
    <div class="col-md-6" id="divComer">

    </div>
    <div class="col-md-2">
        <a href="#" id="btnAgregarComer" class="btn btn-primary" title="Agregar una comercializadora">
            <i class="fa fa-plus"></i>
        </a>
    </div>
    </span>
</div>

<div class="row col-lg-12">

    <span class="grupo">
        <label for="administrador" class="col-md-2 control-label text-info">
            Administrador
        </label>
        <div class="col-md-4">
            <g:textField name="administrador_name" id="administrador" maxlength="31" required="" class="form-control required" value="${est?.administrador}"/>
        </div>
    </span>


    <span class="grupo">
        <label for="representante" class="col-md-2 control-label text-info">
            Representante
        </label>
        <div class="col-md-4">
            <g:textField name="representante_name" id="representante" maxlength="31" class="form-control required" value="${est?.representante}"/>
        </div>
    </span>
</div>

<div class="row col-lg-12">
    <span class="grupo">
        <label for="mail" class="col-md-2 control-label text-info">
            Mail
        </label>
        <div class="col-md-4">
            <g:textField name="mail_name" id="mail" class="form-control required noEspacios email" value="${est?.mail}"/>
        </div>
    </span>

        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <div class="col-md-4">
                <g:textField name="telefono_name" id="telefono" class="form-control number required noEspacios" value="${est?.telefono}"/>
            </div>
        </span>
</div>

<div class="row col-lg-12">
    <span class="grupo">
        <label for="direccion" class="col-md-2 control-label text-info">
            Dirección
        </label>
        <div class="col-md-6">
            <g:textArea name="direccion_name" id="direccion" cols="40" rows="5" maxlength="255" required="" class="form-control required" value="${est?.direccion}" style="width: 575px; height: 100px; resize: none"/>
        </div>
    </span>
</div>

<div class="row col-lg-12">
    <span class="grupo">
        <label for="provincia" class="col-md-2 control-label text-info">
            Provincia
        </label>
        <div class="col-md-4">
            <g:select id="provincia" name="provincia.id" from="${estacion.Provincia.list()}" optionKey="id" optionValue="nombre"
                      required="" noSelection="[0: 'Seleccione...']" value="${est?.provincia?.id}" class="many-to-one form-control required"/>
        </div>
    </span>

    <span class="grupo">
        <label for="canton" class="col-md-2 control-label text-info">
            Cantón
        </label>
        <div class="col-md-4" id="divCanton">
            %{--<g:textField name="canton_name" id="canton" class="form-control" value="${est?.canton}"/>--}%
        </div>
    </span>

</div>


<div class="row col-lg-12">
    <span class="grupo">
        <label for="observaciones" class="col-md-2 control-label text-info">
            Observaciones
        </label>
        <div class="col-md-6">
            <g:textArea name="observaciones_name" id="observaciones" cols="40" rows="5" maxlength="255" class="form-control" value="${est?.observaciones}" style="width: 575px; height: 100px; resize: none"/>
        </div>
    </span>
</div>

</g:form>




<div class="col-md-12" style="margin-top: 10px">
    <div class="col-md-6"></div>
    <a href="#" id="btnGuardarEstacion" class="btn btn-success" title="Guardar los datos de la estación">
        <i class="fa fa-save"> Guardar</i>
    </a>
</div>

<script type="text/javascript">

       cargarCanton(${est?.provincia?.id});

    //funcion para cargar con ajax el cantón

    function cargarCanton (idPro) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'estacion',action: 'cargarCanton_ajax')}',
            data: {
                id: idPro,
                estacion: '${est?.id}'
            },
            success: function (msg){
            $("#divCanton").html(msg)
            }
        });
    }

    $("#provincia").change(function () {
            var idPro = $("#provincia").val()
            cargarCanton(idPro);
    });

    //agregar una comercializadora a la estación
    $("#btnAgregarComer").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'comercializadora', action:'form_ajax')}",
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCrearComerc",
                        title   : "Comercializadora",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            guardar  : {
                                id        : "btnSave",
                                label     : "<i class='fa fa-save'></i> Guardar",
                                className : "btn-success",
                                callback  : function () {
                                    return submitFormComer();
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                } //success
            }); //ajax
    });


    function submitFormComer() {
        var $form = $("#frmComercializadora");
        var $btn = $("#dlgCrearComerc").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'comercializadora', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
//                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        log("Comercializadora agregada correctamente","success");
                        cargarComercializadora();
                    } else {
                        log("Error al agregar la comercializadora","error");
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }


    cargarComercializadora(${est?.id});

    //función para cargar el combo de la comercializadora
    function cargarComercializadora(idEst){
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'comercializadora', action: 'comercializadora_ajax')}",
            data: {
                id: idEst
            },
            success: function (msg) {
                $("#divComer").html(msg)
            }
        });
    }

    //guardar estación de servicio

    $("#btnGuardarEstacion").click(function () {

        var $form = $("#frmEstacionTabla");
        var nomb = $("#nombre").val();
        var come = $("#comercializadora").val();
        var admi = $("#administrador").val();
        var repre = $("#representante").val();
        var mail = $("#mail").val();
        var tele = $("#telefono").val();
        var dire = $("#direccion").val();
        var cant = $("#canton").val();
        var prov = $("#provincia").val();
        var obse = $("#observaciones").val();

        var esta = $("#estacionServ").val();

        if ($form.valid()) {
            $("#tablaEstacion").removeClass("modificado").addClass("original");
            $("#tabla").removeClass("modificado").addClass("original");
            if(come == 0){
                bootbox.alert("Seleccione una comercializadora!");
            }else{
                if(prov == 0){
                bootbox.alert("Seleccione una provincia!");
                }else{
                    $.ajax({
                    type    : "POST",
                    url     : '${createLink(controller: 'estacion' , action:'guardarEstacion_ajax')}',
                    data    : {
                        nombre: nomb,
                        comercializadora: come,
                        administrador: admi,
                        representante: repre,
                        mail: mail,
                        telefono: tele,
                        direccion: dire,
                        canton: cant,
                        provincia: prov,
                        observaciones: obse,
                        estacion: esta
                    },
                    success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "ok") {
                        if(parts[1] == "guardada"){
                            log(("Estación guardada correctamente"),"success")
                        }else{
                            log(("Estación actualizada correctamente"),"success")
                        }
                        %{--setTimeout(function () {--}%
                            %{--location.href = "${createLink(controller:'preauditoria',action:'crearPaso2')}/" + ${pre?.id};--}%
                        %{--}, 2000);--}%
                        cargarEstacionMain(parts[2]);
                    } else {
                        log(("Error al guardar la estación"),"error")
                    }
                    }
                    });
                }
            }
        } else {
            $("#tablaEstacion").removeClass("original").addClass("modificado");
            $("#tabla").removeClass("original").addClass("modificado");
            return false;
        } //else
    });


//validación de datos de la estación
    var validator = $("#frmEstacionTabla").validate({
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
//            submitForm();
            return false;
        }
        return true;
    });

</script>



















