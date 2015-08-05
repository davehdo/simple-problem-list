Workspace.Views.Plans ||= {}

class Workspace.Views.Plans.ShowView extends Backbone.View
  template: JST["backbone/templates/plans/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
