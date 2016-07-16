<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 05/06/2016
  Time: 21:30
--%>

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
            <table class="table table-condensed table-bordered table-striped" id="tablaL">
                <tbody>
                <g:each in="${licencias}" var="lic" status="j">
                    <tr>
                        <td style="width: 3%">${lic?.orden}
                            <a href="#" class="btn btn-xs btn-primary btnOrdenLic" data-id="${lic?.id}" title="Agregar orden" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td style="width: 10%; font-size: smaller">Licencia Ambiental</td>
                        <td style="width: 30%; font-size: smaller">${lic?.licencia?.descripcion}</td>
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
                                                    <li style="background-color: ${cal?.tipo}"><a href="#" class="btnCalificacionLic" data-id="${cal?.id}" data-plan="${lic?.id}" title="${cal?.nombre}">${cal?.sigla}</a></li>
                                                </g:each>
                                            </ul>
                                        </div>
                                    </td>
                                    <td style="background-color: ${lic?.calificacion?.tipo};" class="col-md-3">
                                        <div class="divCalificacion_${lic?.id} col-md-4" title="${lic?.calificacion?.nombre}">
                                            ${lic?.calificacion?.sigla}
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                        <td style="width: 15%; font-size: smaller" title="${lic?.hallazgo?.descripcion ? lic?.hallazgo?.descripcion : 'Hallazgo no cargado'}">
                            <g:if test="${lic?.hallazgo?.descripcion}">
                                <g:if test="${lic?.hallazgo?.descripcion?.size() > 100}">
                                    ${lic?.hallazgo?.descripcion?.substring(0,100)}...
                                </g:if>
                                <g:else>
                                    ${lic?.hallazgo?.descripcion}
                                </g:else>
                            </g:if>

                            <a href="#" class="btn btn-xs btn-primary btnHallazgoLic" data-id="${lic?.id}" title="Agregar hallazgo" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td style="width: 10%">

                            <g:set value="${evaluacion.Anexo.findAllByEvaluacion(evaluacion.Evaluacion.get(lic?.id)).size()}" var="numero"/>

                            <i class="fa fa-folder-open"></i> Anexos : ${numero}

                            <a href="#" class="btn btn-xs btn-primary btnAnexoLic" data-id="${lic?.id}" title="Agregar anexo" style="float: right">
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


    $(".btnOrdenLic").click(function () {
        var idEva = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'ordenLicencia_ajax')}",
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
                })
            }
        });
    });


    //función cargar calificación
    $(".btnCalificacionLic").click(function () {
        var idEva = $(this).data('plan');
        var idCali = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'guardarCalificacion_ajax')}",
            data:{
                id: idEva,
                calificacion: idCali
            },
            success: function (msgLic){
                if(msgLic == 'ok'){
                    cargarTablaLicencia();
                }else{

                }
            }
        });
    });

    //función para marcar una fila
    $("#tablaL tr").click(function () {
//        $(this).fadeToggle(600)
//        $(this).fadeIn;
        $("#tablaL tr").removeClass("trHighlight");
        $(this).addClass("trHighlight");
    });

    //botón agregar hallazgo

    $(".btnHallazgoLic").click(function () {
        var idEva = $(this).data("id");
        $.ajax({
            type:'POST',
            url:"${createLink(controller: 'evaluacion', action: 'cargarHallazgo_ajax')}",
            data: {
                id: idEva,
                tipo: 'licencia'
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
                                cargarTablaLicencia();
                            }
                        }
                    }
                })
            }
        });
    });


    $(".btnAnexoLic").click(function () {
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
                                cargarTablaLicencia();
                            }
                        }
                    }
                })
            }
        });
    });


</script>
