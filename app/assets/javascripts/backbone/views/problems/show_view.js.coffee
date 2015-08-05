Workspace.Views.Problems ||= {}

class Workspace.Views.Problems.ShowView extends Backbone.View
  template: JST["backbone/templates/problems/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
