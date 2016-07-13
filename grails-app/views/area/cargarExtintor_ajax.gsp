<%@ page import="estacion.Extintor" %>
<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 15/05/2016
  Time: 16:32
--%>


<div class="row">
    <div class="col-md-3">
        Tipo
    </div>
    <div class="col-md-6">
        <g:select name="tipo_name" id="tipo" from="${Extintor.constraints.tipo.inList}"
                  class="form-control"
                  noSelection="[null: 'Seleccione...']"/>
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        Capacidad
    </div>
    <div class="col-md-6">
        <g:select name="capacidad_name" id="capacidad" from="${Extintor.constraints.capacidad.inList}"
                  class="form-control"
                  noSelection="[null: 'Seleccione...']"/>
    </div>

    <div class="col-md-2" style="margin-left: 10px">
        <a href="#" id="btnAgregarExtintor" class="btn btn-info" title="Agregar extintores al área">
            <i class="fa fa-plus"></i>
        </a>
    </div>
</div>



<div class="row" style="margin-left: 50px">

    <div id="tablaExtintores" >


    </div>

</div>

<script type="text/javascript">

    cargarTabla();

    //funcion para cargar la tabla de los extintores del área correspondiente

    function cargarTabla () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'area', action: 'tablaExtintores_ajax')}',
            data: {
                id: '${ares.id}'
            },
            success: function (msg) {
                $("#tablaExtintores").html(msg)
            }
        });
    }

    //función para agregar los extintores al área

    $("#btnAgregarExtintor").click(function () {
        var tp = $("#tipo").val();
        var cp = $("#capacidad").val();
        if(tp == 'null' || cp == 'null'){
            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x text-info text-shadow'></i>  Debe seleccionar el tipo y la capacidad")
        }else{
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'area',action:  'agregarExtintor_ajax')}',
                %{--url: "${createLink(controller: 'area',action:  'grabarExtintor_ajax')}",--}%
                data:{
                    id: '${ares?.id}',
                    tipo: tp,
                    capacidad: cp
                },
                success: function (msg){
                    if(msg == 'ok'){
                        cargarTabla();
                    }else{
                        log("Error al agregar un extintor al área","error")
                    }

                }
            });
        }
    });

</script>