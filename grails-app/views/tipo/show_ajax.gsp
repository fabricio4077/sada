
<%@ page import="tipo.Tipo" %>

<g:if test="${!tipoInstance}">
    <elm:notFound elem="Tipo" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${tipoInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${tipoInstance?.tiempo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tiempo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoInstance}" field="tiempo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>