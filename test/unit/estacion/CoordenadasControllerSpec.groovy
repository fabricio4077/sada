package estacion



import grails.test.mixin.*
import spock.lang.*

@TestFor(CoordenadasController)
@Mock(Coordenadas)
class CoordenadasControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.coordenadasInstanceList
            model.coordenadasInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.coordenadasInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def coordenadas = new Coordenadas()
            coordenadas.validate()
            controller.save(coordenadas)

        then:"The create view is rendered again with the correct model"
            model.coordenadasInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            coordenadas = new Coordenadas(params)

            controller.save(coordenadas)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/coordenadas/show/1'
            controller.flash.message != null
            Coordenadas.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def coordenadas = new Coordenadas(params)
            controller.show(coordenadas)

        then:"A model is populated containing the domain instance"
            model.coordenadasInstance == coordenadas
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def coordenadas = new Coordenadas(params)
            controller.edit(coordenadas)

        then:"A model is populated containing the domain instance"
            model.coordenadasInstance == coordenadas
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/coordenadas/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def coordenadas = new Coordenadas()
            coordenadas.validate()
            controller.update(coordenadas)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.coordenadasInstance == coordenadas

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            coordenadas = new Coordenadas(params).save(flush: true)
            controller.update(coordenadas)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/coordenadas/show/$coordenadas.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/coordenadas/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def coordenadas = new Coordenadas(params).save(flush: true)

        then:"It exists"
            Coordenadas.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(coordenadas)

        then:"The instance is deleted"
            Coordenadas.count() == 0
            response.redirectedUrl == '/coordenadas/index'
            flash.message != null
    }
}
