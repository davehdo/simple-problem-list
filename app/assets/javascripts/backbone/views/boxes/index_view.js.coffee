Workspace.Views.Boxes ||= {}

class Workspace.Views.Boxes.IndexView extends Backbone.View
  template: JST["backbone/templates/boxes/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (box) =>
    view = new Workspace.Views.Boxes.BoxView({model : box})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(boxes: @collection.toJSON() ))
    @addAll()

    return this
