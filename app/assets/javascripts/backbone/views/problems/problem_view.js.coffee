Workspace.Views.Problems ||= {}

class Workspace.Views.Problems.ProblemView extends Backbone.View
  template: JST["backbone/templates/problems/problem"]

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
