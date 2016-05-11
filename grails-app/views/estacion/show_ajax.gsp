
<%@ page import="estacion.Estacion" %>

<g:if test="${!estacionInstance}">
    <elm:notFound elem="Estacion" genero="o" />
</g:if>
<g:else>

    <g:if test="${estacionInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.administrador}">
        <div class="row">
            <div class="col-md-2 text-info">
                Administrador
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="administrador"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.direccion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Direccion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="direccion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.canton}">
        <div class="row">
            <div class="col-md-2 text-info">
                Canton
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="canton"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.comercializadora}">
        <div class="row">
            <div class="col-md-2 text-info">
                Comercializadora
            </div>
            
            <div class="col-md-3">
                ${estacionInstance?.comercializadora?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.coordenadas}">
        <div class="row">
            <div class="col-md-2 text-info">
                Coordenadas
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.mail}">
        <div class="row">
            <div class="col-md-2 text-info">
                Mail
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="mail"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.observaciones}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observaciones
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.provincia}">
        <div class="row">
            <div class="col-md-2 text-info">
                Provincia
            </div>
            
            <div class="col-md-3">
                ${estacionInstance?.provincia?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.representante}">
        <div class="row">
            <div class="col-md-2 text-info">
                Representante
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="representante"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estacionInstance?.telefono}">
        <div class="row">
            <div class="col-md-2 text-info">
                Telefono
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estacionInstance}" field="telefono"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>