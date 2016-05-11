
<%@ page import="consultor.Consultora" %>

<g:if test="${!consultoraInstance}">
    <elm:notFound elem="Consultora" genero="o" />
</g:if>
<g:else>

    <g:if test="${consultoraInstance?.nombre}">
        <div class="row">
            <div class="col-md-3 text-info">
                Nombre
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${consultoraInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${consultoraInstance?.administrador}">
        <div class="row">
            <div class="col-md-3 text-info">
                Representante Legal
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${consultoraInstance}" field="administrador"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${consultoraInstance?.direccion}">
        <div class="row">
            <div class="col-md-3 text-info">
                Dirección
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${consultoraInstance}" field="direccion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${consultoraInstance?.mail}">
        <div class="row">
            <div class="col-md-3 text-info">
                Mail
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${consultoraInstance}" field="mail"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${consultoraInstance?.pagina}">
        <div class="row">
            <div class="col-md-3 text-info">
                Pagina web
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${consultoraInstance}" field="pagina"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${consultoraInstance?.ruc}">
        <div class="row">
            <div class="col-md-3 text-info">
                Ruc
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${consultoraInstance}" field="ruc"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${consultoraInstance?.telefono}">
        <div class="row">
            <div class="col-md-3 text-info">
                Teléfono
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${consultoraInstance}" field="telefono"/>
            </div>
            
        </div>
    </g:if>

    <g:if test="${consultoraInstance?.registro}">
        <div class="row">
            <div class="col-md-3 text-info">
               Registro ambiental
            </div>

            <div class="col-md-6">
                <g:set var="part" value="${consultoraInstance?.registro?.split("_")}"/>
                <strong>MAE:</strong> ${part[0]} <br/>
                <strong>DPA:</strong> ${part[1]}
            </div>

        </div>
    </g:if>
    
</g:else>