
<%@ page import="situacion.Desechos" %>

<g:if test="${!desechosInstance}">
    <elm:notFound elem="Desechos" genero="o" />
</g:if>
<g:else>

    <g:if test="${desechosInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${desechosInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${desechosInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${desechosInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>