
<%@ page import="metodologia.Metodologia" %>

<g:if test="${!metodologiaInstance}">
    <elm:notFound elem="Metodologia" genero="o" />
</g:if>
<g:else>

    <g:if test="${metodologiaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${metodologiaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${metodologiaInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${metodologiaInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>