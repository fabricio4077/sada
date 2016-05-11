
<%@ page import="legal.MarcoLegal" %>

<g:if test="${!marcoLegalInstance}">
    <elm:notFound elem="MarcoLegal" genero="o" />
</g:if>
<g:else>

    <g:if test="${marcoLegalInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${marcoLegalInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${marcoLegalInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${marcoLegalInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>