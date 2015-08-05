Workspace.Views.Problems ||= {}

class Workspace.Views.Problems.IndexView extends Backbone.View
  template: JST["backbone/templates/problems/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (problem) =>
    view = new Workspace.Views.Problems.ProblemView({model : problem})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(problems: @collection.toJSON() ))
    @addAll()

    return this
