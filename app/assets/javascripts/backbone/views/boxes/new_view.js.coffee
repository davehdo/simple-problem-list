Workspace.Views.Boxes ||= {}

class Workspace.Views.Boxes.NewView extends Backbone.View
  template: JST["backbone/templates/boxes/new"]

  events:
    "submit #new-box": "save"

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
      success: (box) =>
        @model = box
        window.location.hash = "/#{@model.id}"

      error: (box, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
