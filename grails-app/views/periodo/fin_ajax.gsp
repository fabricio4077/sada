<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 10/07/2016
  Time: 10:18
--%>

<span class="grupo">
    <label for="fin" class="col-md-4 control-label text-info">
        Fin
    </label>
    <div class="col-md-2">
        <g:datePicker name="fin" precision="year"  class="form-control required" years="${fin..2050}"/>
    </div>
</span>
