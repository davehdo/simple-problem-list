Workspace.Views.Plans ||= {}

class Workspace.Views.Plans.PlanView extends Backbone.View
  template: JST["backbone/templates/plans/plan"]

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
