
<%@ page import="evaluacion.Licencia" %>

<g:if test="${!licenciaInstance}">
    <elm:notFound elem="Licencia" genero="o" />
</g:if>
<g:else>

    <g:if test="${licenciaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${licenciaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${licenciaInstance?.detalleAuditoria}">
        <div class="row">
            <div class="col-md-2 text-info">
                Detalle Auditoria
            </div>
            
            <div class="col-md-3">
                ${licenciaInstance?.detalleAuditoria?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>