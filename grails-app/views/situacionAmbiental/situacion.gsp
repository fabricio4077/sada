<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 12/06/2016
  Time: 13:36
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Situación Ambiental</title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-eye"></i> Situación Ambiental</h3>
    </div>

    <div class="panel-group" style="height: 500px">
        <div class="col-md-12" style="margin-top: 10px">
            <ul class="nav nav-pills nav-justified">
                <li class="active col-md-4"><a data-toggle="tab" href="#home"><h4>Físico</h4></a></li>
                <li class="col-md-4"><a data-toggle="tab" href="#menu1"><h4>Biótico</h4></a></li>
                <li class="col-md-4"><a data-toggle="tab" href="#menu2"><h4>Social</h4></a></li>
            </ul>

            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">
                    <div class="col-md-12" style="margin-top: 10px">
                        <ul class="nav nav-pills nav-justified">
                            <li class="col-md-4"><a data-toggle="tab" href="#gaseosas" id="eg"><h5>Emisiones Gaseosas</h5></a></li>
                            <li class="active col-md-4"><a data-toggle="tab" href="#liquidas"><h5>Descargas Líquidas</h5></a></li>
                            <li class="col-md-4"><a data-toggle="tab" href="#residuos"><h5>Resíduos Sólidos y Líquidos</h5></a></li>
                        </ul>

                        <div class="tab-content">
                            <div id="gaseosas" class="tab-pane fade in active">
                                <div class="well" style="text-align: center; height: 200px; margin-top: 10px">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-2 negrilla control-label">Emisor </div>

                                            <div class="col-md-4" id="divEmisor">

                                            </div>

                                            <div class="col-md-5">
                                                <a href="#" id="btnAgregarEmisor" class="btn btn-success" title="">
                                                    <i class="fa fa-plus"></i> Agregar emisor
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div id="liquidas" class="tab-pane fade">
                                <h4>DOSSSS</h4>
                            </div>
                            <div id="residuos" class="tab-pane fade">
                                <h4>TRES</h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu1" class="tab-pane fade">
                    <h4>DOSSSS</h4>
                </div>
                <div id="menu2" class="tab-pane fade">
                    <g:if test="${pre?.tipo?.codigo != 'LCM1'}">
                        <h4></h4>
                        <div class="alert alert-danger" role="alert" style="text-align: center">
                            ESTE COMPONENTE NO ESTÁ DISPONIBLE PARA ESTE TIPO DE AUDITORÍA
                        </div>
                    </g:if>
                    <g:else>

                    </g:else>

                </div>
            </div>
        </div>


    </div>



</div>

<script type="text/javascript">

    cargarComboEmisores();

    function cargarComboEmisores () {
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'situacionAmbiental', action: 'emisor_ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function (msg) {
            $("#divEmisor").html(msg)
            }
        });
    }

//    $("#eg").click(function () {
//            revisarGenerador();
//    });



//    function revisarGenerador () {
        $("#eg").click(function () {
        $.ajax({
            type:'POST',
            url:"${createLink(controller: 'situacionAmbiental', action: 'revisarGenerador_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                if(msg == 'ok'){
                    $.ajax({

                    });


                    var b = bootbox.dialog({
                        id      : "dlgCreateEdit",
                        title   : "Emisor - Generador Eléctrico",
                        message : "Nada",
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

                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                }else{

                }
            }
        })
    })
//    }



</script>


</body>
</html>