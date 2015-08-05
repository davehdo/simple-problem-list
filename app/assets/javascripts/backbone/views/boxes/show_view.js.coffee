Workspace.Views.Boxes ||= {}

class Workspace.Views.Boxes.ShowView extends Backbone.View
  template: JST["backbone/templates/boxes/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
