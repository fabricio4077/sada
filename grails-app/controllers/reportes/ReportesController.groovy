package reportes

import Seguridad.Persona
import auditoria.Auditoria
import auditoria.Preauditoria
import consultor.Asignados
import estacion.Canton
import estacion.Coordenadas
import metodologia.Metodologia
import objetivo.ObjetivosAuditoria

class ReportesController {

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

//        println("general " + objetivoGeneral)

        return[pre: pre, especialista: especialista?.persona, general: objetivoGeneral.first(), especificos: objetivosEspecificos, orden: params.orden]

    }
}
