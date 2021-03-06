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
                <g:each in="${leyes}" var="ley" status="j">
                    <tr>
                        <td style="width: 3%; color: #224aff"><b>${ley?.orden != 0 ? ley?.orden : ''}</b></br>
                            <a href="#" class="btn btn-xs btn-primary btnOrdenEva" data-id="${ley?.id}" title="Agregar orden" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td style="width: 10%; font-size: smaller">${ley?.marcoNorma?.norma?.nombre + " - Art. N° " + ley?.marcoNorma?.articulo?.numero}</td>
                        <td style="width: 30%; font-size: smaller">${ley?.marcoNorma?.literal ? (ley?.marcoNorma?.literal?.identificador + ")  " + ley?.marcoNorma?.literal?.descripcion) : ley?.marcoNorma?.articulo?.descripcion}</td>
                        <td style="width: 15%">
                            <table id="tabla_${pre?.id}">
                                <tbody>
                                <tr>
                                    <td>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Calificar <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <g:each in="${evaluacion.Calificacion.list([sort: 'nombre', order: 'asc'])}" var="cal">
                                                    <li style="background-color: ${cal?.tipo}"><a href="#" class="btnCalificacionEva" data-id="${cal?.id}" data-ley="${ley?.id}" title="${cal?.nombre}">${cal?.sigla}</a></li>
                                                </g:each>
                                            </ul>
                                        </div>
                                    </td>
                                    <td style="background-color: ${ley?.calificacion?.tipo};" class="col-md-3">
                                        <div class="divCalificacion_${ley?.id} col-md-4" title="${ley?.calificacion?.nombre}">
                                            ${ley?.calificacion?.sigla}
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                        <td style="width: 15%; font-size: smaller" title="${ley?.hallazgo?.descripcion ? ley?.hallazgo?.descripcion : 'Hallazgo no cargado'}">
                            <g:if test="${ley?.hallazgo?.descripcion}">
                                <g:if test="${ley?.hallazgo?.descripcion?.size() > 100}">
                                    ${ley?.hallazgo?.descripcion?.substring(0,100)}...
                                </g:if>
                                <g:else>
                                    ${ley?.hallazgo?.descripcion}
                                </g:else>
                            </g:if>
                            <g:else>

                            </g:else>

                            <a href="#" class="btn btn-xs btn-primary btnHallazgoEva" data-id="${ley?.id}" title="Agregar hallazgo" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td style="width: 10%">

                            <g:set value="${evaluacion.Anexo.findAllByEvaluacion(evaluacion.Evaluacion.get(ley?.id)).size()}" var="numero"/>

                            <i class="fa fa-folder-open"></i> Anexos : ${numero}

                            <a href="#" class="btn btn-xs btn-primary btnAnexoEva" data-id="${ley?.id}" title="Agregar anexo" style="float: right">
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

    $(".btnOrdenEva").click(function () {
        var idEva = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'orden_ajax')}",
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
                            label     : '<i class="fa fa-close"></i> Cancelar',
                            className : 'btn-primary',
                            callback  : function () {
                            }
                        }
                    }
                }).off("shown.bs.modal")
            }
        });
    });


    //función cargar calificación
    $(".btnCalificacionEva").click(function () {
        var idEva = $(this).data('ley');
        var idCali = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'guardarCalificacion_ajax')}",
            data:{
                id: idEva,
                calificacion: idCali
            },
            success: function (msgEva){
                if(msgEva == 'ok'){
                    cargarTablaEva();
                }else{

                }
            }
        });
    });

    //función para marcar una fila
    $("#tablaH tr").click(function () {
//        $(this).fadeToggle(600)
//        $(this).fadeIn;
        $("#tablaH tr").removeClass("trHighlight");
        $(this).addClass("trHighlight");
    });

    //botón agregar hallazgo

    $(".btnHallazgoEva").click(function () {
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
//                            location.reload(true)
                                cargarTablaEva();
                            }
                        }
                    }
                })
            }
        });
    });


    $(".btnAnexoEva").click(function () {
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
                                cargarTablaEva();
                            }
                        }
                    }
                })
            }
        });
    });


</script>
