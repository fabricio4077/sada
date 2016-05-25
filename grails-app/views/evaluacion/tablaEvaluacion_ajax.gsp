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
                        <td style="width: 2%">${j+1}</td>
                        <td style="width: 10%; font-size: smaller">${ley?.marcoNorma?.norma?.nombre + " - Art. N° " + ley?.marcoNorma?.articulo?.numero}</td>
                        <td style="width: 30%; font-size: smaller">${ley?.marcoNorma?.literal ? (ley?.marcoNorma?.literal?.identificador + ")  " + ley?.marcoNorma?.literal?.descripcion) : ley?.marcoNorma?.articulo?.descripcion}</td>
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
                                                    <li style="background-color: ${cal?.tipo}"><a href="#" class="btnCalificacion" data-id="${cal?.id}" data-ley="${ley?.id}" title="${cal?.nombre}">${cal?.sigla}</a></li>
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

                            <a href="#" class="btn btn-xs btn-primary btnHallazgo" data-id="${ley?.id}" title="Agregar hallazgo" style="float: right">
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td style="width: 10%">
                            <a href="#" class="btn btn-xs btn-primary btnAnexo" data-id="${ley?.id}" title="Agregar anexo" style="float: right">
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

    //función cargar calificación
    $(".btnCalificacion").click(function () {
        var idEva = $(this).data('ley');
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
                    cargarTablaEva();
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


</script>
