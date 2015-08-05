Workspace.Views.Plans ||= {}

class Workspace.Views.Plans.NewView extends Backbone.View
  template: JST["backbone/templates/plans/new"]

  events:
    "submit #new-plan": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (plan) =>
        @model = plan
        window.location.hash = "/#{@model.id}"

      error: (plan, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
