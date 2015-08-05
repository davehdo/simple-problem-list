Workspace.Views.Problems ||= {}

class Workspace.Views.Problems.NewView extends Backbone.View
  template: JST["backbone/templates/problems/new"]

  events:
    "submit #new-problem": "save"

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
      success: (problem) =>
        @model = problem
        window.location.hash = "/#{@model.id}"

      error: (problem, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
