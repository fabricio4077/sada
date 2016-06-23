<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 06/06/16
  Time: 10:38 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>

    %{--<link href="${resource(dir: 'js/plugins/fullcalendar-2.7.3', file: 'fullcalendar.css')}" rel="stylesheet">--}%
    %{--<script src="${resource(dir: 'js/plugins/fullcalendar-2.7.3/lib', file: 'moment.min.js')}"></script>--}%
    %{--<script src="${resource(dir: 'js/plugins/fullcalendar-2.7.3/lib', file: 'jquery.min.js')}"></script>--}%
    %{--<script src="${resource(dir: 'js/plugins/fullcalendar-2.7.3', file: 'fullcalendar.js')}"></script>--}%

    %{--<script src='http://fullcalendar.io/js/fullcalendar-2.1.1/lib/moment.min.js'></script>--}%
    %{--<script src="http://fullcalendar.io/js/fullcalendar-2.1.1/lib/jquery-ui.custom.min.js"></script>--}%
    %{--<script src='http://fullcalendar.io/js/fullcalendar-2.1.1/fullcalendar.min.js'></script>--}%

    <link href="${resource(dir: 'js/plugins/fullcalendar-2.2.7-yearview', file: 'fullcalendar.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js/plugins/fullcalendar-2.2.7-yearview/lib', file: 'moment.min.js')}"></script>
    %{--<script src="${resource(dir: 'js/plugins/fullcalendar-2.2.7-yearview/lib', file: 'jquery.min.js')}"></script>--}%
    <script src="${resource(dir: 'js/plugins/fullcalendar-2.2.7-yearview', file: 'fullcalendar.js')}"></script>
    <script src="${resource(dir: 'js/plugins/fullcalendar-2.2.7-yearview', file: 'lang-all.js')}"></script>


    <meta name="layout" content="mainSada">
    <title>Cronograma</title>

    <script>
        //    $(document).ready(function() {
        //
        //      // page is now ready, initialize the calendar...
        //
        //      $('#calendar').fullCalendar({
        //        // put your options and callbacks here
        //      })
        //
        //
        //    });


        $(document).ready(function() {
            $('#calendar').fullCalendar({
                height : 450,
                width  : 650,
                defaultView: 'year',
                lang: 'es',
//                weekends: false,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'year,month,basicWeek,basicDay'
                },

                events : [
                    <g:each in="${planes}" var="p" status="j">
                    {
                        <g:set var="inicio" value="${p?.detalleAuditoria?.auditoria?.fechaAprobacion ? p?.detalleAuditoria?.auditoria?.fechaAprobacion?.format("yyyy-MM-dd") : p?.detalleAuditoria?.auditoria?.fechaFin?.format("yyyy-MM-dd")}"/>
                        title  : '${p?.aspectoAmbiental?.planManejoAmbiental?.nombre}',
                        description:'${p?.medida?.descripcion}',
                        costo: "${"COSTO: " + " " + p?.medida?.costo + " USD"}",
                        start  : '${inicio}'
                        //            start  : '2016-06-06'
                        //            end: moment([2016,6,6]).add(12,'M')

                        <g:if test="${p?.medida?.plazo == 'Bi Anual'}">
                        ,
                        end: (moment('${inicio}').add(24,'M'))
                        </g:if>
                        <g:if test="${p?.medida?.plazo == 'Anual'}">
                        ,
                        end: (moment('${inicio}').add(12,'M'))
                        </g:if>
                        <g:if test="${p?.medida?.plazo == 'Semestral'}">
                        ,
                        end: (moment('${inicio}').add(6,'M'))
                        </g:if>
                        <g:if test="${p?.medida?.plazo == 'Permanente'}">
                        ,
                        <g:if test="${p?.detalleAuditoria?.auditoria?.preauditoria?.tipo?.codigo == 'LCM1'}">
                        end: (moment('${inicio}').add(12,'M'))
                        </g:if>
                        <g:if test="${p?.detalleAuditoria?.auditoria?.preauditoria?.tipo?.codigo == 'INIC'}">
                        end: (moment('${inicio}').add(12,'M'))
                        </g:if>
                        <g:if test="${p?.detalleAuditoria?.auditoria?.preauditoria?.tipo?.codigo == 'CMPM'}">
                        end: (moment('${inicio}').add(24,'M'))
                        </g:if>
                        </g:if>
                        ,
                        color: get_random_color()
                    },
                    </g:each>
                ]
                ,
                eventClick:  function(event, jsEvent, view) {
                    $('#modalTitle').html(event.title);
                    $('#modalBody').html(event.description);
                    $("#divCosto").html(event.costo);
                    $('#eventUrl').attr('href',event.url);
                    $('#calendarModal').modal();
//            $("#calendarModal").data('bs.modal').$backdrop.css('background-color','orange')
//            $("#calendarModal").data('bs.modal').$backdrop.css('background-color',event.color)
                    $(".modal-header").css('background-color',event.color)
                }
            })
        });


        function get_random_color() {
            function c() {
                var hex = Math.floor(Math.random()*256).toString(16);
                return ("0"+String(hex)).substr(-2); // pad with zero
            }
            return "#"+c()+c()+c();
        }

    </script>
</head>
<body>



<header class='masthead' style="margin-top: 120px; position: fixed">
    <nav>
        <div class='nav-container'>
            <div>
                <a class='slide' href='#' id="areasMenu">
                    <span class='element'>Ar</span>
                    <span class='name'>Áreas Estación</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="sitMenu">
                    <span class='element'>Sa</span>
                    <span class='name'>Situación Ambiental</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="evaMenu">
                    <span class='element'>Ev</span>
                    <span class='name'>Evaluación Ambiental</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="planMenu">
                    <span class='element'>Pa</span>
                    <span class='name'>Plan de acción</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="pmaMenu">
                    <span class='element'>Pm</span>
                    <span class='name'>PMA</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="cronoMenu">
                    <span class='element'>Cr</span>
                    <span class='name'>Cronograma</span>
                </a>
            </div>
            %{--<div>--}%
                %{--<a class='slide' href='#'>--}%
                    %{--<span class='element'>Rc</span>--}%
                    %{--<span class='name'>Recomendaciones</span>--}%
                %{--</a>--}%
            %{--</div>--}%
        </div>
    </nav>
</header>



<div id='calendar'></div>

<div id="calendarModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                <h4 id="modalTitle" class="modal-title"></h4>
            </div>
            <div id="modalBody" class="modal-body">

            </div>
            <div id="divCosto" style="text-align: center">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    //mini menu
    $("#areasMenu").click(function () {
        location.href="${createLink(controller: 'area', action: 'areas')}/" + ${pre?.id}
    });

    $("#evaMenu").click(function () {
        location.href="${createLink(controller: 'auditoria', action: 'leyes')}/" + ${pre?.id}
    });

    $("#planMenu").click(function () {
        location.href="${createLink(controller: 'planAccion', action: 'planAccionActual')}/" + ${pre?.id}
    });

    $("#pmaMenu").click(function () {
        location.href="${createLink(controller: 'planManejoAmbiental', action: 'cargarPlanActual')}/" + ${pre?.id}
    });
    $("#sitMenu").click(function () {
        location.href="${createLink(controller: 'situacionAmbiental', action: 'situacion')}/" + ${pre?.id}
    });

    $("#cronoMenu").click(function () {
        location.href="${createLink(controller: 'auditoria', action: 'cronograma')}/" + ${pre?.id}
    });

</script>

</body>
</html>