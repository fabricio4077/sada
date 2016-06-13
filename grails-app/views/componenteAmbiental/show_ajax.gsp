
<%@ page import="situacion.ComponenteAmbiental" %>

<g:if test="${!componenteAmbientalInstance}">
    <elm:notFound elem="ComponenteAmbiental" genero="o" />
</g:if>
<g:else>

    <g:if test="${componenteAmbientalInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${componenteAmbientalInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${componenteAmbientalInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${componenteAmbientalInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>