<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 24/05/16
  Time: 10:45 AM
--%>

<script type="text/javascript" src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.css')}"/>

<g:select name="hallazgo_name" id="hallazgoCombo" from="${listaHallazgos}"
          class="many-to-one form-control input-sm selectpicker " noSelection="[null: 'Seleccione...']" optionKey="id" optionValue="descripcion"/>

<script>
    $('.selectpicker').selectpicker({
        width      : "350px",
        limitWidth : true,
        style      : "btn-sm"
    });
</script>