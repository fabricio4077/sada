<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 17/04/2016
  Time: 14:11
--%>


<%@ page import="auditoria.Preauditoria" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Lista general de Auditorías</title>

    <style type="text/css">
    .centrar {
        text-align: center;
    }

    td{
        font-weight: bold;
    }
    </style>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<div class="panel panel-info ">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-check-circle-o"></i> Lista general de Auditorías </h3>
    </div>
</div>

<div style="margin-bottom: 20px">
    <div class="col-md-2">
        <label>Tipo</label>
        <g:select name="tipo_name" from="${tipo.Tipo.list()}" id="tipoB" optionKey="id" optionValue="descripcion" class="form-control"/>
    </div>

    <div class="col-md-4">
        <label>Estación</label>
        <g:textField name="estacion_name" value="" id="estacionB" style="width: 350px" maxlength="30" class="form-control"/>
    </div>

    <div class="col-md-2">
        <label>Fecha Creación</label>
        <elm:datepicker name="fechaCreacion" class="datepicker form-control" value=""/>
    </div>

    <div style="padding-top: 25px; padding-bottom: 25px;">
        <a href="#" name="busqueda" class="btn btn-success btnBusqueda col-md-1" title="Buscar auditoría"><i
                class="fa fa-check-square-o" ></i> Buscar</a>
        <a href="#" name="borrar" class="btn btn-primary btnBorrar col-md-1" title="Limpiar campos"><i
                class="fa fa-eraser"></i> Limpiar</a>
    </div>

</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th class="centrar" style="width: 10%"><i class='fa fa-list'></i> Tipo</th>
        <th class="centrar" style="width: 10%"><i class='fa fa-calendar'></i> Período</th>
        <th class="centrar" style="width: 30%"><i class='fa fa-automobile'></i> Estación</th>
        <th class="centrar" style="width: 10%"><i class='fa fa-clock-o'></i> Fecha de creación</th>
        <th class="centrar" style="width: 15%"><i class='fa fa-user'></i> Creador/Usuario</th>
        <th class="centrar" style="width: 7%"> % de Avance</th>
    </tr>
    </thead>
</table>

<div id="tablaAuditoriasGeneral"></div>


<script type="text/javascript">


    cargarTablaGeneral(null, null, null);

    function cargarTablaGeneral (tpo, est, fec) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'preauditoria', action: 'tablaAuditoriaGeneral_ajax')}",
            data:{
                estacion: est,
                tipo: tpo,
                fecha: fec
            },
            success: function (msg) {
                $("#tablaAuditoriasGeneral").html(msg)
            }
        });
    }


    $(".btnBusqueda").click(function () {
        var tipo = $("#tipoB").val();
        var estacion = $("#estacionB").val();
        var fecha = $("#fechaCreacion_input").val();
        cargarTablaGeneral(tipo, estacion, fecha)
    });

    $(".btnBorrar").click(function (){
        $("#estacionB").val('');
        $("#fechaCreacion_input").val('');
        cargarTablaGeneral(null, null, null)
    });

</script>

</body>
</html>
