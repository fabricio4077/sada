
<%@ page import="situacion.SituacionAmbiental" %>

<g:if test="${!situacionAmbientalInstance}">
    <elm:notFound elem="SituacionAmbiental" genero="o" />
</g:if>
<g:else>

    <g:if test="${situacionAmbientalInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${situacionAmbientalInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${situacionAmbientalInstance?.analisisLiquidas}">
        <div class="row">
            <div class="col-md-2 text-info">
                Analisis Liquidas
            </div>
            
            <div class="col-md-3">
                ${situacionAmbientalInstance?.analisisLiquidas?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${situacionAmbientalInstance?.componenteAmbiental}">
        <div class="row">
            <div class="col-md-2 text-info">
                Componente Ambiental
            </div>
            
            <div class="col-md-3">
                ${situacionAmbientalInstance?.componenteAmbiental?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${situacionAmbientalInstance?.detalleAuditoria}">
        <div class="row">
            <div class="col-md-2 text-info">
                Detalle Auditoria
            </div>
            
            <div class="col-md-3">
                ${situacionAmbientalInstance?.detalleAuditoria?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>