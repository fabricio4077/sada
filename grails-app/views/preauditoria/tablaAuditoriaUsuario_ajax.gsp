<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 06/07/16
  Time: 12:58 PM
--%>

<div class="row-fluid"  style="width: 99.7%;height: 400px;overflow-y: auto;float: right;">
    <div class="span12">
        <div style="width: 1120px; height: 400px;">

            <table class="table table-condensed table-bordered table-striped">
                <tbody>
                <g:each in="${lista}" status="i" var="preauditoriaInstance" >
                    <tr data-id="${preauditoriaInstance.id}">
                        <g:if test="${preauditoriaInstance?.tipo?.codigo == 'INIC'}">
                            <td style="background-color: #85c5ff; width: 13%">${preauditoriaInstance?.tipo?.descripcion}</td>
                        </g:if>
                        <g:elseif test="${preauditoriaInstance?.tipo?.codigo == 'LCM1'}">
                            <td style="background-color: #77ff6b; width: 13%">${preauditoriaInstance?.tipo?.descripcion}</td>
                        </g:elseif>
                        <g:else>
                            <td style="background-color: #fdff78; width: 13%">${preauditoriaInstance?.tipo?.descripcion}</td>
                        </g:else>
                        <td style="text-align: center; width: 13%">${preauditoriaInstance?.periodo?.inicio?.format("yyyy") + " - " + preauditoriaInstance?.periodo?.fin?.format("yyyy")}</td>
                        <td style="width: 52%">${preauditoriaInstance?.estacion?.nombre}</td>
                        <td style="width: 13%"><util:fechaConFormato fecha="${preauditoriaInstance?.fechaCreacion}"/></td>
                        <td id="porcentaje_${i}" style="margin-left: 20px; width: 7%"></td>
                    </tr>
                </g:each>
                </tbody>
            </table>

        </div>
    </div>
</div>


<script type="text/javascript">

    //función para cargar el porcentaje de avance de la auditoría
    <g:each in="${lista}" status="i" var="preauditoriaInstance">
    cargarPorcentaje(${preauditoriaInstance?.avance?.toInteger()},${i});
    </g:each>

    function cargarPorcentaje (porc, id){
        $("#porcentaje_"+id).radialProgress("init", {
            'size': 60,
            'fill': 4
        }).radialProgress("to", {'perc': porc, 'time': 1500});
    }

    var id = null;
    function submitForm() {
        var $form = $("#frmPreauditoria");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Preauditoria seleccionado? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    location.reload(true);
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Preauditoria",
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
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    $(function () {
        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });


        function revisarEstacion (id) {
            var res
            $.ajax({
                type: 'POST',
                async: false,
                url: '${createLink(controller: 'preauditoria', action: 'revisarEstacion_ajax')}',
                data: {
                    id: id
                },
                success: function (msg){
                    res = msg
                }
            });

            if(res == 'true'){
                return true
            }else{
                return false
            }

        }

        function revisarGrupo (id) {
            return false
        }

        function revisarObjetivos(id){
            var res
            $.ajax({
                type: 'POST',
                async: false,
                url: '${createLink(controller: 'preauditoria', action: 'revisarObjetivos_ajax')}',
                data: {
                    id: id
                },
                success: function (msg){
                    res = msg
                }
            });

            if(res == 'true'){
                return true
            }else{
                return false
            }
        }



        function createContextMenu(node) {
            var $tr = $(node);
            var idF = $tr.data("id");

            var items = {
                header: {
                    label: "Acciones",
                    header: true
                },
                ver      : {
                    label  : "Información",
                    icon   : "fa fa-search text-info",
                    action : function ($element) {
                        var id = $element.data("id");
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'show_ajax')}",
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                bootbox.dialog({
                                    title   : "Información",
                                    message : msg,
                                    buttons : {
                                        ok : {
                                            label     : "Aceptar",
                                            className : "btn-primary",
                                            callback  : function () {
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                editar   : {
                    label  : "Continuar",
                    icon   : "fa fa-pencil text-success",
                    submenu:{
                        configuracion:{
                            label: "Configuración",
                            icon: "fa fa-pencil-square text-success",
                            submenu:{
                                paso1: {
                                    label: "Paso 1 - Tipo y Período",
                                    icon: "fa fa-pencil-square",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearAuditoria')}/" + id
                                    }
                                }

                                ,
                                paso2:{
                                    label: "Paso 2 - Estación",
                                    icon: "fa fa-automobile",
                                    action: function ($element) {
                                        var id = $element.data("id");
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso2')}/" + id
                                    }
                                    ,
                                    disabled: revisarEstacion(idF)
                                }
                                ,
                                paso3:{
                                    label: "Paso 3 - Coordenadas",
                                    icon: "fa fa-area-chart",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso3')}/" + id
                                    }
                                    ,
                                    disabled: revisarEstacion(idF)

                                },
                                paso4:{
                                    label: "Paso 4 - Grupo de Trabajo",
                                    icon: "fa fa-group",
                                    action: function ($element) {
                                        var id = $element.data("id");
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso4')}/" + id
                                    },
                                    disabled: revisarEstacion(idF)
                                },
                                %{--paso5:{--}%
                                %{--label: "Paso 5 - Actividades",--}%
                                %{--icon: "fa fa-tasks",--}%
                                %{--action: function ($element) {--}%
                                %{--var id = $element.data("id");--}%
                                %{--location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso5')}/" + id--}%
                                %{--},--}%
                                %{--disabled: revisarEstacion(idF)--}%

                                %{--},--}%
                                separador: {
                                    separator2: { "type": "cm_seperator" }
                                },
                                ficha: {
                                    label: "Ficha Técnica",
                                    icon: "fa fa-file-text text-info",
                                    action: function ($element) {
                                        var id = $element.data("id");
                                        location.href = "${createLink(controller: 'preauditoria', action: 'fichaTecnica')}/" + id
                                    }
                                    ,
                                    disabled: revisarEstacion(idF)
                                }


                            }
                        },

                        objetivos: {
                            label: "Objetivos",
                            icon: "fa fa-check-circle-o text-success",
                            action: function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'auditoria', action: 'objetivos')}/" + id
                            },
                            disabled: revisarObjetivos(idF)
                        },
                        complemento:{
                            label: "Complementos",
                            icon: "fa fa-file-text-o text-warning",
                            submenu:{
                                paso1: {
                                    label: "Antecedentes",
                                    icon: "fa fa-paste text-warning",
                                    action: function ($element) {
                                        var id = $element.data("id");
                                        location.href = "${createLink(controller: 'antecedente', action: 'antecedente')}/" + id
                                    }
                                } ,
                                paso2:{
                                    label: "Alcance",
                                    icon: "fa fa-file-o text-warning",
                                    action: function ($element) {
                                        var id = $element.data("id");
                                        location.href = "${createLink(controller: 'alcance', action: 'alcance')}/" + id
                                    }
                                },
                                paso3:{
                                    label: "Metodología",
                                    icon: "fa fa-files-o text-warning",
                                    action: function ($element) {
                                        var id = $element.data("id");
                                        location.href = "${createLink(controller: 'metodologia', action: 'verMetodologia')}/" + id
                                    }
                                }
                            }
                        },
                        impresion:{
                            label: "Imprimir",
                            icon: "fa fa-print text-info",
                            action: function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'reportes', action: 'imprimirUI')}/" + id
                            },
                            disabled: revisarObjetivos(idF)
                        }
                    }
                }
                <g:if test="${session.perfil.codigo == 'ADMI'}">
                ,
                eliminar : {
                    label            : "Eliminar",
                    icon             : "fa fa-trash-o text-danger",
                    separator_before : true,
                    action           : function ($element) {
                        var id = $element.data("id");
                        deleteRow(id);
                    }
                }
                </g:if>

            };

            return items
        }

        $(function () {
            $("tr").contextMenu({
                items  : createContextMenu,
                onShow : function ($element) {
                    $element.addClass("trHighlight");
                },
                onHide : function ($element) {
                    $(".trHighlight").removeClass("trHighlight");
                }
            });
        });

        function deleteRow(itemId) {
            bootbox.dialog({
                title   : "Alerta",
                message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar la auditoría seleccionada? </br> <b>Esta acción no se puede deshacer.</b></p>",
                buttons : {
                    cancelar : {
                        label     : "Cancelar",
                        className : "btn-primary",
                        callback  : function () {
                        }
                    },
                    eliminar : {
                        label     : "<i class='fa fa-trash-o'></i> Eliminar",
                        className : "btn-danger",
                        callback  : function () {
                            $.ajax({
                                type    : "POST",
                                url     : '${createLink(action:'borrarAuditoria_ajax')}',
                                data    : {
                                    id : itemId
                                },
                                success : function (msg) {
                                    if(msg == 'ok'){
                                        log("Auditoría borrada correctamente","success");
                                        setTimeout(function () {
                                            location.href = "${createLink(controller: "preauditoria", action: "list" )}"
                                        }, 1500);
                                    }else{
                                        log("Error al borrar la auditoría","error")
                                    }
                                }
                            });
                        }
                    }
                }
            });
        }

    });



</script>