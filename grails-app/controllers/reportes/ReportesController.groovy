package reportes

import Seguridad.Persona
import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import complemento.Alcance
import complemento.Antecedente
import consultor.Asignados
import estacion.Ares
import estacion.Canton
import estacion.Coordenadas
import estacion.Extintor
import evaluacion.Calificacion
import evaluacion.Evaluacion
import metodologia.Metodologia
import objetivo.Objetivo
import objetivo.ObjetivosAuditoria
import situacion.AnalisisLiquidas
import situacion.ComponenteAmbiental
import situacion.SituacionAmbiental
import situacion.TablaLiquidas

class ReportesController{

    def index() {}

    def imprimirUI () {

        def pre = Preauditoria.get(params.id)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def arr = ['1','2', '3','4','5','6','7','8','9','10','11','12','13','14','15']
        return [pre:pre, especialista: especialista, arr: arr]
    }


    def fichaTecnicaPdf () {

//        println("params ficha pdf " + params)

        def pre = Preauditoria.get(params.id)
        def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def coordinador = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Coordinador"));
        def biologo = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Biologo"));
        def canton = Canton.get(pre?.estacion?.canton)
        return [pre: pre, coordenadas: coordenadas, especialista: especialista?.persona,
                coordinador: coordinador?.persona, biologo: biologo?.persona,
                canton: canton, orden: params.orden]

    }


    def metodologiaPdf() {

        def pre = Preauditoria.get(params.id)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def metodologia = Metodologia.get(1);


        def text = (metodologia?.descripcion ?: '')

        text = text.replaceAll("&lt;", "*lt*")
        text = text.replaceAll("&gt;", "*gt*")
        text = text.replaceAll("&amp;", "*amp*")
        text = text.replaceAll("<p>&nbsp;</p>", "<br/>")
        text = text.replaceAll("&nbsp;", " ")

        text = text.decodeHTML()

        text = text.replaceAll("\\*lt\\*", "&lt;")
        text = text.replaceAll("\\*gt\\*", "&gt;")
        text = text.replaceAll("\\*amp\\*", "&amp;")
        text = text.replaceAll("\\*nbsp\\*", " ")
        text = text.replaceAll(/<tr>\s*<\/tr>/, / /)

        text = text.replaceAll(~"\\?\\_debugResources=y\\&n=[0-9]*", "")


        return[pre:pre, especialista: especialista?.persona, orden: params.orden, metodologia: metodologia, texto: text]
    }

    def objetivosPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def objetivoGeneral = ObjetivosAuditoria.withCriteria {
                              eq("auditoria",auditoria)

                                objetivo{
                                    eq('tipo', 'General')
                                }
        }

        def objetivosEspecificos = ObjetivosAuditoria.withCriteria {
                            eq("auditoria",auditoria)

                            objetivo{
                                eq('tipo', 'Específico')
                            }
        }

        println("espec "  + objetivosEspecificos)

       def gene = corregirTexto(objetivoGeneral?.first()?.objetivo?.descripcion)
       def espe = ""

        def listaObjetivos = Objetivo.list()

//        objetivosEspecificos.each {
//            espe += "<p style='text-align:justify'><li>" + corregirTexto(it?.objetivo?.descripcion) + "</li></p>"
//        }
//
        listaObjetivos.each {
            espe += "<p style='text-align:justify'><li>" + corregirTexto(it?.descripcion) + "</li></p>"

        }

        return[pre: pre, especialista: especialista?.persona, general: gene, especificos: objetivosEspecificos, orden: params.orden, espe: espe]

    }

    def antecedentePdf () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def antecedente = Antecedente.findByDetalleAuditoria(detalle)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));

        def ant = corregirTexto(antecedente?.descripcion)

        return [antecedente: ant, pre: pre, especialista: especialista?.persona, orden: params.orden]
    }

    def alcancePdf () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def alcance = Alcance.findByAuditoria(auditoria)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def alc = corregirTexto(alcance?.descripcion)

        return [alcance: alc, pre: pre, especialista: especialista?.persona, orden: params.orden]
    }

    def situacionPdf () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def componenteEmi = ComponenteAmbiental.get(1)
        def componenteDescargas = ComponenteAmbiental.get(2)
        def componenteResiduos = ComponenteAmbiental.get(3)
        def componenteBiotico = ComponenteAmbiental.get(4)
        def componenteSocial = ComponenteAmbiental.get(5)
        def emisiones = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalle, componenteEmi)
        def descargas = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalle, componenteDescargas)
        def residuos = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalle, componenteResiduos)
        def biotico = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalle, componenteBiotico)
        def social = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalle, componenteSocial)

        def textoEmi = corregirTexto(emisiones?.descripcion)
        def textoDes = corregirTexto(descargas?.descripcion)
        def textoRes = corregirTexto(residuos?.descripcion)
        def textoBio = corregirTexto(biotico?.descripcion)
        def textoSocial = corregirTexto(social?.descripcion)
        def tablas = TablaLiquidas.findAllBySituacionAmbiental(descargas)


        return [pre: pre, especialista: especialista?.persona, orden: params.orden, emi: textoEmi,
                des: textoDes, res: textoRes, bio: textoBio, soc: textoSocial, tablas: tablas]
    }

    def areasPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def ares = Ares.findAllByEstacion(pre?.estacion, [sort: 'area.nombre', order: 'asc'])
        def extintores = Extintor.findAllByAresInList(ares)

        return [pre: pre, especialista: especialista?.persona, orden: params.orden, ares: ares, extintores: extintores]
    }

    def evaluacionPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def leyes = Evaluacion.findAllByDetalleAuditoriaAndMarcoNormaIsNotNull(detalle, [sort: 'marcoNorma.norma.nombre', order: 'asc'])
        def planes = Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaIsNotNull(detalle, [sort: 'planAuditoria.aspectoAmbiental.planManejoAmbiental.nombre', order: "asc"])
        def licencias = Evaluacion.findAllByDetalleAuditoriaAndLicenciaIsNotNull(detalle, [sort: 'licencia.descripcion', order: 'asc'])

        return [pre: pre, especialista: especialista?.persona, orden: params.orden, leyes: leyes, planes: planes, licencias: licencias]
    }

    def planAccionPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def leyes = Evaluacion.findAllByDetalleAuditoriaAndMarcoNormaIsNotNull(detalle, [sort: 'marcoNorma.norma.nombre', order: 'asc'])
        def planes = Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaIsNotNull(detalle, [sort: 'planAuditoria.aspectoAmbiental.planManejoAmbiental.nombre', order: "asc"])
        def licencias = Evaluacion.findAllByDetalleAuditoriaAndLicenciaIsNotNull(detalle, [sort: 'licencia.descripcion', order: 'asc'])


        def eval = Evaluacion.findAllByDetalleAuditoria(detalle).size()
        def total1 = leyes.size() + planes.size() + licencias.size()

        def listaCalificaciones = ['NC+','nc-','O']
        def calificaciones = Calificacion.findAllBySiglaInList(listaCalificaciones)
        def evaluacionesNo = Evaluacion.findAllByDetalleAuditoriaAndCalificacionInList(detalle,calificaciones, [sort: 'hallazgo.descripcion', order: "asc"])

        def incumplidas = evaluacionesNo.size()

        def porcentaje


        if(incumplidas != 0){
            porcentaje = 100 - ((incumplidas * 100) / eval)
        }else{
            porcentaje = 100
        }

        def por = porcentaje.toDouble().round(2)

        return [pre: pre, especialista: especialista?.persona, orden: params.orden, total: eval, inclumplidas: incumplidas, porcentaje: por, listaNo: evaluacionesNo]
    }


    def corregirTexto (texto) {
        def text = (texto ?: '')

        text = text.replaceAll("&lt;", "*lt*")
        text = text.replaceAll("&gt;", "*gt*")
        text = text.replaceAll("&amp;", "*amp*")
        text = text.replaceAll("<p>&nbsp;</p>", "<br/>")
        text = text.replaceAll("&nbsp;", " ")

        text = text.decodeHTML()

        text = text.replaceAll("\\*lt\\*", "&lt;")
        text = text.replaceAll("\\*gt\\*", "&gt;")
        text = text.replaceAll("\\*amp\\*", "&amp;")
        text = text.replaceAll("\\*nbsp\\*", " ")
        text = text.replaceAll(/<tr>\s*<\/tr>/, / /)

        text = text.replaceAll(~"\\?\\_debugResources=y\\&n=[0-9]*", "")

        return text
    }
}
