<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 30/05/16
  Time: 10:47 AM
--%>

<%@ page import="evaluacion.Evaluacion" %>
<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 24/05/16
  Time: 03:30 PM
--%>

<div class="row-fluid"  style="width: 99.7%;height: 500px;overflow-y: auto;float: right;">
    <div class="span12">
        <div style="width: 1120px; height: 500px;">
            <table class="table table-condensed table-bordered table-striped" id="tablaH">
                <tbody>
                <g:each in="${planes}" var="plan" status="j">
                    <tr>
                        <td style="width: 3%">${plan?.orden}
                            <a href="#" class="btn btn-xs btn-primary btnOrden" data-id="${plan?.id}" title="Agregar orden" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td style="width: 10%; font-size: smaller">${plan?.planAuditoria?.aspectoAmbiental?.planManejoAmbiental?.nombre}</td>
                        <td style="width: 30%; font-size: smaller">${plan?.planAuditoria?.aspectoAmbiental?.descripcion + " - " + plan?.planAuditoria?.medida?.descripcion}</td>
                        <td style="width: 15%">
                            <table>
                                <tbody>
                                <tr>
                                    <td>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Calificar <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <g:each in="${evaluacion.Calificacion.list([sort: 'nombre', order: 'asc'])}" var="cal">
                                                    <li style="background-color: ${cal?.tipo}"><a href="#" class="btnCalificacion" data-id="${cal?.id}" data-plan="${plan?.id}" title="${cal?.nombre}">${cal?.sigla}</a></li>
                                                </g:each>
                                            </ul>
                                        </div>
                                    </td>
                                    <td style="background-color: ${plan?.calificacion?.tipo};" class="col-md-3">
                                        <div class="divCalificacion_${plan?.id} col-md-4" title="${plan?.calificacion?.nombre}">
                                            ${plan?.calificacion?.sigla}
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                        <td style="width: 15%; font-size: smaller" title="${plan?.hallazgo?.descripcion ? plan?.hallazgo?.descripcion : 'Hallazgo no cargado'}">
                            <g:if test="${plan?.hallazgo?.descripcion}">
                                <g:if test="${plan?.hallazgo?.descripcion?.size() > 100}">
                                    ${plan?.hallazgo?.descripcion?.substring(0,100)}...
                                </g:if>
                                <g:else>
                                    ${plan?.hallazgo?.descripcion}
                                </g:else>
                            </g:if>

                            <a href="#" class="btn btn-xs btn-primary btnHallazgo" data-id="${plan?.id}" title="Agregar hallazgo" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td style="width: 10%">

                            <g:set value="${evaluacion.Anexo.findAllByEvaluacion(evaluacion.Evaluacion.get(plan?.id)).size()}" var="numero"/>

                            <i class="fa fa-folder-open"></i> Anexos : ${numero}

                            <a href="#" class="btn btn-xs btn-primary btnAnexo" data-id="${plan?.id}" title="Agregar anexo" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                    </tr>
                </g:each>

                </tbody>
            </table>

        </div>
    </div>
</div>

<script type="text/javascript">

    $(".btnOrden").click(function () {
        var idEva = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'ordenPlan_ajax')}",
            data:{
                id: idEva
            },
            success: function (msg){
                bootbox.dialog({
                    id: "dlgOrden",
                    title: "Orden",
                    message: msg,
                    buttons: {
                        cancelar :{
                            label     : 'Aceptar',
                            className : 'btn-primary',
                            callback  : function () {
                                cargarTablaEvaPlan();
                            }
                        }
                    }
                })
            }
        });
    });

    //función cargar calificación
    $(".btnCalificacion").click(function () {
        var idEva = $(this).data('plan');
        var idCali = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'guardarCalificacion_ajax')}",
            data:{
                id: idEva,
                calificacion: idCali
            },
            success: function (msg){
                if(msg == 'ok'){
                    cargarTablaEvaPlan();
                }else{

                }
            }
        });
    });
    $.ajax({

    });

    //función para marcar una fila
    $("#tablaH tr").click(function () {
//        $(this).fadeToggle(600)
//        $(this).fadeIn;
        $("#tablaH tr").removeClass("trHighlight");
        $(this).addClass("trHighlight");
    });

    //botón agregar hallazgo

    $(".btnHallazgo").click(function () {
        var idEva = $(this).data("id");
        $.ajax({
            type:'POST',
            url:"${createLink(controller: 'evaluacion', action: 'cargarHallazgo_ajax')}",
            data: {
                id: idEva
            },
            success: function (msg) {
                bootbox.dialog({
                    id: "dlgHallazgo",
                    title: "Hallazgo",
                    message: msg,
                    buttons: {
                        cancelar :{
                            label     : 'Aceptar',
                            className : 'btn-primary',
                            callback  : function () {

                            }
                        }
                    }
                })
            }
        });
    });


    $(".btnAnexo").click(function () {
        var idEva = $(this).data("id");
        $.ajax({
            type:'POST',
            url:"${createLink(controller: 'evaluacion', action: 'anexo_ajax')}",
            data: {
                id: idEva
            },
            success: function (msg) {
                bootbox.dialog({
                    id: "dlgAnexo",
                    title: "Anexo",
                    message: msg,
                    buttons: {
                        cancelar :{
                            label     : 'Aceptar',
                            className : 'btn-primary',
                            callback  : function () {
                                cargarTablaEvaPlan();
                            }
                        }
                    }
                })
            }
        });
    });


</script>
