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
import plan.PlanAuditoria
import situacion.AnalisisLiquidas
import situacion.ComponenteAmbiental
import situacion.SituacionAmbiental
import situacion.TablaLiquidas

class ReportesController{

    def index() {}

    def imprimirUI () {

        def pre = Preauditoria.get(params.id)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def arr = ['1','2', '3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20']
        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo

        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [pre:pre, especialista: especialista, arr: arr]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }

    }

    def fichaTecnicaPdf () {

//        println("params ficha pdf " + params)

        def pre = Preauditoria.get(params.id)
        def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)
        def canton = Canton.get(pre?.estacion?.canton)

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }

        if(especialista){
            especialista = especialista.first()
        }
        def coordinador = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Coordinador")
            }
        }

        if(coordinador){
            coordinador = coordinador.first()
        }

        def biologo = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Biologo")
            }
        }

        if(biologo){
            biologo = biologo.first()
        }

        return [pre: pre, coordenadas: coordenadas, especialista: especialista?.persona,
                coordinador: coordinador?.persona, biologo: biologo?.persona,
                canton: canton, orden: params.orden, numero: params.numero, mes: params.mes, anio: params.anio ]

    }

    def prueba () {

    }

    def metodologiaPdf() {

        def pre = Preauditoria.get(params.id)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));


        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()



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


        return[pre:pre, especialista: especialista?.persona, orden: params.orden, metodologia: metodologia, texto: text,  numero: params.numero, mes: params.mes, anio: params.anio]
    }

    def objetivosPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()


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

//        println("espec "  + objetivosEspecificos)

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

        return[pre: pre, especialista: especialista?.persona, general: gene, especificos: objetivosEspecificos, orden: params.orden, espe: espe,  numero: params.numero, lista: listaObjetivos, mes: params.mes, anio: params.anio]

    }

    def antecedentePdf () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def antecedente = Antecedente.findByDetalleAuditoria(detalle)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()

        def ant = corregirTexto(antecedente?.descripcion)

        return [antecedente: ant, pre: pre, especialista: especialista?.persona, orden: params.orden,  numero: params.numero, mes: params.mes, anio: params.anio]
    }

    def alcancePdf () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def alcance = Alcance.findByAuditoria(auditoria)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()
        def alc = corregirTexto(alcance?.descripcion)

        return [alcance: alc, pre: pre, especialista: especialista?.persona, orden: params.orden,  numero: params.numero, mes: params.mes, anio: params.anio]
    }

    def situacionPdf () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()
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
                des: textoDes, res: textoRes, bio: textoBio, soc: textoSocial, tablas: tablas,  numero: params.numero, mes: params.mes, anio: params.anio]
    }

    def areasPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()
        def ares = Ares.findAllByEstacion(pre?.estacion, [sort: 'area.nombre', order: 'asc'])
        def extintores = Extintor.findAllByAresInList(ares)

        return [pre: pre, especialista: especialista?.persona, orden: params.orden, ares: ares, extintores: extintores,  numero: params.numero, mes: params.mes, anio: params.anio]
    }

    def evaluacionPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
//        def leyes = Evaluacion.findAllByDetalleAuditoriaAndMarcoNormaIsNotNull(detalle, [sort: 'marcoNorma.norma.nombre', order: 'asc'])
//        def planes = Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaIsNotNull(detalle, [sort: 'planAuditoria.aspectoAmbiental.planManejoAmbiental.nombre', order: "asc"])
//        def licencias = Evaluacion.findAllByDetalleAuditoriaAndLicenciaIsNotNull(detalle, [sort: 'licencia.descripcion', order: 'asc'])


        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()

        def leyes = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalle)
            isNotNull("marcoNorma")
            order("orden","asc")
        }

        def planes = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalle)
            isNotNull("planAuditoria")
            order("orden","asc")
        }

        def licencias = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalle)
            isNotNull("licencia")
            order("orden","asc")
        }

        return [pre: pre, especialista: especialista?.persona, orden: params.orden, leyes: leyes, planes: planes, licencias: licencias,  numero: params.numero, mes: params.mes, anio: params.anio]
    }

    def planAccionPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()

//        def leyes = Evaluacion.findAllByDetalleAuditoriaAndMarcoNormaIsNotNull(detalle, [sort: 'marcoNorma.norma.nombre', order: 'asc'])
//        def planes = Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaIsNotNull(detalle, [sort: 'planAuditoria.aspectoAmbiental.planManejoAmbiental.nombre', order: "asc"])
//        def licencias = Evaluacion.findAllByDetalleAuditoriaAndLicenciaIsNotNull(detalle, [sort: 'licencia.descripcion', order: 'asc'])


        def leyes = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalle)
            isNotNull("marcoNorma")
            order("orden","asc")
        }

        def planes = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalle)
            isNotNull("planAuditoria")
            order("orden","asc")
        }

        def licencias = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalle)
            isNotNull("licencia")
            order("orden","asc")
        }



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

        def totalCosto = 0

        evaluacionesNo.each {pl->
            if(pl?.planAccion && pl?.planAccion?.costo != '0'){
                totalCosto += pl?.planAccion?.costo?.toDouble()
            }
        }

        println("total " + totalCosto)

        return [pre: pre, especialista: especialista?.persona, orden: params.orden, total: eval, inclumplidas: incumplidas, porcentaje: por, listaNo: evaluacionesNo,  numero: params.numero, totalCosto: totalCosto, mes: params.mes, anio: params.anio]
    }

    def manejoAmbientalPdf () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def planAuditoria = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalle, 'ACT', [sort: 'aspectoAmbiental.planManejoAmbiental.id', order: 'asc'])
        def unicos = planAuditoria.aspectoAmbiental.planManejoAmbiental.unique()


        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()


        return [pre: pre, especialista: especialista?.persona, orden: params.orden, unicos: unicos, planes: planAuditoria,  numero: params.numero, mes: params.mes, anio: params.anio]

    }

    def recomendacionesPdf () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
//        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona{
                eq("cargo","Especialista")
            }
        }.first()

        def ant = corregirTexto(detalle?.recomendaciones)

        return [det: ant, pre: pre, especialista: especialista?.persona, orden: params.orden,  numero: params.numero, mes: params.mes, anio: params.anio]
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
