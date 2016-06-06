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
//    weekends: false,
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
            description:'${p?.aspectoAmbiental?.planManejoAmbiental?.nombre + " - " + p?.medida?.descripcion}',
            start  : '${inicio}'
            <g:if test="${p?.medida?.plazo == 'Anual'}">
            ,
//            end: moment([2016,6,6]).add(12,'M')
            end: moment('${inicio}').add(12,'M')
            </g:if>
            ,
            color: get_random_color()
          },
          </g:each>
        ],

        eventClick:  function(event, jsEvent, view) {
//        eventMouseover:  function(event, jsEvent, view) {
          $('#modalTitle').html(event.title);
          $('#modalBody').html(event.description);
          $('#eventUrl').attr('href',event.url);
          $('#calendarModal').modal();
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

<div id='calendar'></div>

<div id="calendarModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
        <h4 id="modalTitle" class="modal-title"></h4>
      </div>
      <div id="modalBody" class="modal-body"> </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>


</body>
</html>