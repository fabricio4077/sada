
<%@ page import="auditoria.Preauditoria" %>

<g:if test="${!preauditoriaInstance}">
    <elm:notFound elem="Preauditoria" genero="o" />
</g:if>
<g:else>


    <g:if test="${preauditoriaInstance?.estacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Estacion
            </div>
            
            <div class="col-md-3">
                ${preauditoriaInstance?.estacion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    

    <g:if test="${preauditoriaInstance?.periodo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Periodo
            </div>
            
            <div class="col-md-3">
                ${preauditoriaInstance?.periodo?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${preauditoriaInstance?.plazo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Plazo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${preauditoriaInstance}" field="plazo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${preauditoriaInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                ${preauditoriaInstance?.tipo?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>