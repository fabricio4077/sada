<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/05/16
  Time: 12:11 PM
--%>

%{--<div style="margin-top: 40px; width: 750px; height: 50px; margin-left: 150px" class="vertical-container">--}%
    %{--<p class="css-vertical-text" style="margin-top: -10px;">Instalaciones </p>--}%
    %{--<div class="linea"></div>--}%
    %{--<div class="row">--}%

        %{--<div class="panel-group" id="accordion">--}%
                %{--<div class="panel panel-default">--}%
                    %{--<div class="panel-heading">--}%
                        %{--<h4 class="panel-title">--}%
                            %{--<a data-toggle="collapse" data-parent="#accordion" href="#collapse1">--}%
                                %{--1--}%
                            %{--</a>--}%
                        %{--</h4>--}%
                    %{--</div>--}%
                %{--</div>--}%

            %{--<div id="collapse1" class="panel-collapse collapse ">--}%
                %{--<div class="panel-body">--}%

                    %{--<h3>Section 1</h3>--}%
                    %{--<div>--}%
                        %{--<p>--}%
                            %{--Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer--}%
                            %{--ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit--}%
                            %{--amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut--}%
                            %{--odio. Curabitur malesuada. Vestibulum a velit eu ante scelerisque vulputate.--}%
                        %{--</p>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center">
            <i class="fa fa-bank"></i> Instalaciones de la estación de servicio: "${pre?.estacion?.nombre}" </h3>
    </div>

         <div class="panel-group" id="accordion">

             <g:each in="${areas}" var="a" status="n">
                 <div class="panel panel-default">
                     <div class="panel-heading">
                         <h4 class="panel-title">
                             <a data-toggle="collapse" data-parent="#accordion" href="#collapse_${n}">
                                 ${a?.area?.nombre}
                             </a>
                         </h4>
                     </div>
                 </div>

                 <div id="collapse_${n}" class="panel-collapse collapse ">
                     <div class="panel-body">
                         <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px;">
                             <thead>
                             <tr>
                                 %{--<th style="width:40%;">Infraestructura</th>--}%
                                 <th style="width:40%;">Descripción</th>
                                 <th style="width:20%;">Fotografía</th>
                                 <th style="width:20%;">Extintor</th>
                                 <th style="width:20%;">Ext. Capacidad</th>
                             </tr>
                             </thead>
                             <tbody id="tablaAreas">
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                             </tbody>
                         </table>
                     </div>
                 </div>
             </g:each>
         </div>
</div>

<script type="text/javascript">
//    $(function() {
//        $( "#accordion" ).accordion();
//    });
</script>