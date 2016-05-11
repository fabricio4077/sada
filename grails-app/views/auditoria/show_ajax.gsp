
<%@ page import="auditoria.Auditoria" %>

<g:if test="${!auditoriaInstance}">
    <elm:notFound elem="Auditoria" genero="o" />
</g:if>
<g:else>

    <g:if test="${auditoriaInstance?.metodologia}">
        <div class="row">
            <div class="col-md-2 text-info">
                Metodologia
            </div>
            
            <div class="col-md-3">
                ${auditoriaInstance?.metodologia?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${auditoriaInstance?.marcoLegal}">
        <div class="row">
            <div class="col-md-2 text-info">
                Marco Legal
            </div>
            
            <div class="col-md-3">
                ${auditoriaInstance?.marcoLegal?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${auditoriaInstance?.fechaAprobacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Aprobacion
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${auditoriaInstance?.fechaAprobacion}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${auditoriaInstance?.fechaFin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Fin
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${auditoriaInstance?.fechaFin}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${auditoriaInstance?.fechaInicio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Inicio
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${auditoriaInstance?.fechaInicio}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${auditoriaInstance?.preauditoria}">
        <div class="row">
            <div class="col-md-2 text-info">
                Preauditoria
            </div>
            
            <div class="col-md-3">
                ${auditoriaInstance?.preauditoria?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>