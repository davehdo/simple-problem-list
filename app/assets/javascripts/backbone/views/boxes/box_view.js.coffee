Workspace.Views.Boxes ||= {}

class Workspace.Views.Boxes.BoxView extends Backbone.View
  template: JST["backbone/templates/boxes/box"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
