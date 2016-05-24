<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/05/2016
  Time: 21:39
--%>


<div class="row">
    <div class="col-md-2">
        Hallazgo
    </div>
    <div class="col-md-6">
        <g:select name="hallazgo_name" id="hallazgo" from="${listaHallazgos}"
                  class="form-control"
                  noSelection="[null: 'Seleccione...']"/>
    </div>

    <div class="col-md-3" style="margin-left: 10px">
        <div class="btn-group">
            <a href="#" id="btnSeleccionarHallazgo" class="btn btn-info" title="Seleccionar Hallazgo">
                <i class="fa fa-check-circle-o"></i>
            </a>
            <a href="#" id="btnAgregarHallazgo" class="btn btn-success" title="Agregar Hallazgo">
                <i class="fa fa-plus"> Nuevo</i>
            </a>
        </div>
    </div>
</div>



%{--<div class="row" style="margin-left: 50px">--}%

    %{--<div id="tablaExtintores" >--}%


    %{--</div>--}%

%{--</div>--}%

<script type="text/javascript">

//    cargarTabla();

    //funcion para cargar la tabla de los extintores del área correspondiente

    %{--function cargarTabla () {--}%
        %{--$.ajax({--}%
            %{--type: 'POST',--}%
            %{--url: '${createLink(controller: 'area', action: 'tablaExtintores_ajax')}',--}%
            %{--data: {--}%
                %{--id: ${ares.id}--}%
            %{--},--}%
            %{--success: function (msg) {--}%
                %{--$("#tablaExtintores").html(msg)--}%
            %{--}--}%
        %{--});--}%
    %{--}--}%

    //función para agregar los extintores al área

    %{--$("#btnAgregarExtintor").click(function () {--}%
        %{--var tp = $("#tipo").val();--}%
        %{--var cp = $("#capacidad").val();--}%
        %{--if(tp == 'null' || cp == 'null'){--}%
            %{--bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x text-info text-shadow'></i>  Debe seleccionar el tipo y la capacidad")--}%
        %{--}else{--}%
            %{--$.ajax({--}%
                %{--type: 'POST',--}%
                %{--url: '${createLink(controller: 'area',action:  'agregarExtintor_ajax')}',--}%
                %{--data:{--}%
                    %{--id: ${ares?.id},--}%
                    %{--tipo: tp,--}%
                    %{--capacidad: cp--}%
                %{--},--}%
                %{--success: function (msg){--}%
                    %{--if(msg == 'ok'){--}%
                        %{--cargarTabla();--}%
                    %{--}else{--}%
                        %{--log("Error al agregar un extintor al área","error")--}%
                    %{--}--}%

                %{--}--}%
            %{--});--}%
        %{--}--}%
    %{--});--}%

</script>