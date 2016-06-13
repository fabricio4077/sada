
<%@ page import="situacion.Emisor" %>

<g:if test="${!emisorInstance}">
    <elm:notFound elem="Emisor" genero="o" />
</g:if>
<g:else>

    <g:if test="${emisorInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${emisorInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>