
<%@ page import="legal.Norma" %>

<g:if test="${!normaInstance}">
    <elm:notFound elem="Norma" genero="o" />
</g:if>
<g:else>

    <g:if test="${normaInstance?.tipoNorma}">
        <div class="row">
            <div class="col-md-3 text-info">
                Tipo Norma
            </div>

            <div class="col-md-6">
                ${normaInstance?.tipoNorma?.descripcion?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${normaInstance?.anio}">
        <div class="row">
            <div class="col-md-3 text-info">
                Año
            </div>

            <div class="col-md-4">
                <g:formatDate date="${normaInstance?.anio}" format="yyyy" />
            </div>

        </div>
    </g:if>


    <g:if test="${normaInstance?.nombre}">
        <div class="row">
            <div class="col-md-3 text-info">
                Nombre
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${normaInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${normaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-3 text-info">
                Descripción
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${normaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>

    
</g:else>