
<%@ page import="tipo.Periodo" %>

<g:if test="${!periodoInstance}">
    <elm:notFound elem="Periodo" genero="o" />
</g:if>
<g:else>
    <g:if test="${periodoInstance?.inicio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Inicio
            </div>

            <div class="col-md-3">
                <g:formatDate date="${periodoInstance?.inicio}" format="dd-MM-yyyy" />
            </div>

        </div>
    </g:if>

    <g:if test="${periodoInstance?.fin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fin
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${periodoInstance?.fin}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    

</g:else>