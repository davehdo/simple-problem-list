Workspace.Views.Boxes ||= {}

class Workspace.Views.Boxes.EditView extends Backbone.View
  template: JST["backbone/templates/boxes/edit"]

  events:
    "submit #edit-box": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (box) =>
        @model = box
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
