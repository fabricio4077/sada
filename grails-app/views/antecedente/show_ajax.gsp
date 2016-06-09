
<%@ page import="complemento.Antecedente" %>

<g:if test="${!antecedenteInstance}">
    <elm:notFound elem="Antecedente" genero="o" />
</g:if>
<g:else>

    <g:if test="${antecedenteInstance?.oficio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Oficio
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${antecedenteInstance}" field="oficio"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${antecedenteInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${antecedenteInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${antecedenteInstance?.detalleAuditoria}">
        <div class="row">
            <div class="col-md-2 text-info">
                Detalle Auditoria
            </div>
            
            <div class="col-md-3">
                ${antecedenteInstance?.detalleAuditoria?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${antecedenteInstance?.fechaAprobacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Aprobacion
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${antecedenteInstance?.fechaAprobacion}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
</g:else>