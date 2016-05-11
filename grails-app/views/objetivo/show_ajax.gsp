
<%@ page import="objetivo.Objetivo" %>

<g:if test="${!objetivoInstance}">
    <elm:notFound elem="Objetivo" genero="o" />
</g:if>
<g:else>

    <g:if test="${objetivoInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo de objetivo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${objetivoInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    

    
    <g:if test="${objetivoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-10">
                <g:fieldValue bean="${objetivoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>

    <g:if test="${objetivoInstance?.defecto == '1'}">
        <div class="row">
            <div class="col-md-2 text-info">
                Predeterminado
            </div>

            <div class="col-md-3">
                <g:checkBox name="defecto" disabled="true" checked="true"/>
            </div>

        </div>
    </g:if>
    
</g:else>