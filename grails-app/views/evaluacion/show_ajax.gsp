
<%@ page import="evaluacion.Evaluacion" %>

<g:if test="${!evaluacionInstance}">
    <elm:notFound elem="Evaluacion" genero="o" />
</g:if>
<g:else>

    <g:if test="${evaluacionInstance?.anexo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Anexo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${evaluacionInstance}" field="anexo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${evaluacionInstance?.calificacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Calificacion
            </div>
            
            <div class="col-md-3">
                ${evaluacionInstance?.calificacion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${evaluacionInstance?.detalleAuditoria}">
        <div class="row">
            <div class="col-md-2 text-info">
                Detalle Auditoria
            </div>
            
            <div class="col-md-3">
                ${evaluacionInstance?.detalleAuditoria?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${evaluacionInstance?.hallazgo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Hallazgo
            </div>
            
            <div class="col-md-3">
                ${evaluacionInstance?.hallazgo?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>