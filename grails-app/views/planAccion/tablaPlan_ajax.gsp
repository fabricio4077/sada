<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/05/2016
  Time: 21:11
--%>

<g:each in="${lista}" var="no">
    <div class="row col-md-12" >
        <div class="col-md-5">
            <table class="table table-condensed table-bordered table-striped">
                <tbody>
                <td style="background-color: ${no?.calificacion?.tipo};" class="col-md-2" title="${no?.calificacion?.nombre}">
                    <div class="divCalificacion col-md-4">
                        ${no?.calificacion?.sigla}
                    </div>
                </td>
                <td class="col-md-8">
                    %{--${no?.marcoNorma?.literal ? (no?.marcoNorma?.literal?.identificador + ")  " + no?.marcoNorma?.literal?.descripcion) : no?.marcoNorma?.articulo?.descripcion}--}%
                    ${no?.hallazgo?.descripcion}
                </td>
                </tbody>
            </table>
        </div>
        <div class="col-md-6">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home_${no?.id}">Actividades</a></li>
                <li><a data-toggle="tab" href="#menu1_${no?.id}">Responsable</a></li>
                <li><a data-toggle="tab" href="#menu2_${no?.id}">Plazo</a></li>
                <li><a data-toggle="tab" href="#menu3_${no?.id}">Costo</a></li>
                <li><a data-toggle="tab" href="#menu4_${no?.id}">Verificación</a></li>
            </ul>

            <div class="tab-content">
                <div id="home_${no?.id}" class="tab-pane fade in active">
                    <g:if test="${no?.planAccion}">
                        <h3>Actividades ${no?.id}</h3>
                        <p>
                        </p>
                    </g:if>
                    <g:else>
                        <h4>No existe ningún plan de acción asociado con este hallazgo</h4>
                    </g:else>
                </div>
                <div id="menu1_${no?.id}" class="tab-pane fade">
                    <h3>Menu 1</h3>
                    <p></p>
                </div>
                <div id="menu2_${no?.id}" class="tab-pane fade">
                    <h3>Menu 2</h3>
                    <p></p>
                </div>
                <div id="menu3_${no?.id}" class="tab-pane fade">
                    <h3>Menu 2</h3>
                    <p></p>
                </div>
                <div id="menu4_${no?.id}" class="tab-pane fade">
                    <h3>Menu 2</h3>
                    <p></p>
                </div>
            </div>
        </div>
    </div>


    <div class="col-md-3" style="float: right">
        <div class="btn-group">
            <a href="#" class="btn btn-info btnSeleccionarPlan" data-id="${no?.id}" title="">
                <i class="fa fa-pencil"> Seleccionar Plan</i>
            </a>
        </div>
    </div>
</g:each>

<script type="text/javascript">
        $(".btnSeleccionarPlan").click(function (){
            var idEva = $(this).data('id');
            $.ajax({
                type:'POST',
                url:"${createLink(controller: 'planAccion', action: 'planes_ajax')}",
                data: {
                    id: idEva
                },
                success: function (msg) {
                    bootbox.dialog({
                        id: "dlgPlanes",
                        title: "Planes de Acción",
                        class: 'long',
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


