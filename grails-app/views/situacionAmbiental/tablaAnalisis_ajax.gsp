<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/06/16
  Time: 11:31 AM
--%>

<table class="table table-bordered table-condensed table-hover" style="width: 550px" id="${tabla?.id}">
    <thead>
    <tr>
        <th style="width: 50%">Descripción</th>
        <th style="width: 30%">Horas de uso al año</th>
        <th style="width: 10%">Mantenimiento</th>
        <th style="width: 10%">Acciones</th>
    </tr>
    </thead>
    <tbody>
    %{--<g:each in="${emisores}" var="e">--}%
        %{--<tr>--}%
            %{--<td>${e?.emisor?.nombre}</td>--}%
            %{--<td>${e?.hora} </td>--}%
            %{--<td>${e?.mantenimiento == 1 ? 'SI' : 'NO'} </td>--}%
            %{--<td style="text-align: center">--}%
                %{--<a href="#" class="btn btn-danger btn-sm btnBorrar" title="Borrar emisor" data-id="${e?.id}">--}%
                    %{--<i class="fa fa-trash"></i>--}%
                %{--</a>--}%
            %{--</td>--}%
        %{--</tr>--}%
    %{--</g:each>--}%
    </tbody>
</table>