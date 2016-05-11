package estacion


import grails.test.mixin.*
import spock.lang.*

@TestFor(AresController)
@Mock(Ares)
class AresControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.aresInstanceList
        model.aresInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.aresInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def ares = new Ares()
        ares.validate()
        controller.save(ares)

        then: "The create view is rendered again with the correct model"
        model.aresInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        ares = new Ares(params)

        controller.save(ares)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/ares/show/1'
        controller.flash.message != null
        Ares.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def ares = new Ares(params)
        controller.show(ares)

        then: "A model is populated containing the domain instance"
        model.aresInstance == ares
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def ares = new Ares(params)
        controller.edit(ares)

        then: "A model is populated containing the domain instance"
        model.aresInstance == ares
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/ares/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def ares = new Ares()
        ares.validate()
        controller.update(ares)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.aresInstance == ares

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        ares = new Ares(params).save(flush: true)
        controller.update(ares)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/ares/show/$ares.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/ares/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def ares = new Ares(params).save(flush: true)

        then: "It exists"
        Ares.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(ares)

        then: "The instance is deleted"
        Ares.count() == 0
        response.redirectedUrl == '/ares/index'
        flash.message != null
    }
}
