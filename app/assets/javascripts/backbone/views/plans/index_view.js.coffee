Workspace.Views.Plans ||= {}

class Workspace.Views.Plans.IndexView extends Backbone.View
  template: JST["backbone/templates/plans/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (plan) =>
    view = new Workspace.Views.Plans.PlanView({model : plan})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(plans: @collection.toJSON() ))
    @addAll()

    return this
