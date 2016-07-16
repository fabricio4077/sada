
<%@ page import="evaluacion.Calificacion" %>

<g:if test="${!calificacionInstance}">
    <elm:notFound elem="Calificacion" genero="o" />
</g:if>
<g:else>

    <g:if test="${calificacionInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${calificacionInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${calificacionInstance?.sigla}">
        <div class="row">
            <div class="col-md-2 text-info">
                Sigla
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${calificacionInstance}" field="sigla"/>
            </div>
            
        </div>
    </g:if>
    
    %{--<g:if test="${calificacionInstance?.tipo}">--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-2 text-info">--}%
                %{--Tipo--}%
            %{--</div>--}%
            %{----}%
            %{--<div class="col-md-3">--}%
                %{--<g:fieldValue bean="${calificacionInstance}" field="tipo"/>--}%
            %{--</div>--}%
            %{----}%
        %{--</div>--}%
    %{--</g:if>--}%
    
</g:else>