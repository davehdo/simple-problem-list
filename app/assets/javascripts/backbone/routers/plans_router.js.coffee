class Workspace.Routers.PlansRouter extends Backbone.Router
  initialize: (options) ->
    @plans = new Workspace.Collections.PlansCollection()
    @plans.reset options.plans

  routes:
    "new"      : "newPlan"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newPlan: ->
    # modified this to create and then go to show    

    plan = new @plans.model()

    @plans.create(plan.toJSON(),
      success: (plan) =>
        @model = plan
        window.location.hash = "/#{@model.id}"

      error: (plan, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    
  index: ->
    @view = new Workspace.Views.Plans.IndexView(collection: @plans)
    $("#plans").html(@view.render().el)

  show: (id) ->
    plan = @plans.get(id)

    @view = new Workspace.Views.Plans.ShowView(model: plan)
    $("#plans").html(@view.render().el)

  edit: (id) ->
    plan = @plans.get(id)

    @view = new Workspace.Views.Plans.EditView(model: plan)
    $("#plans").html(@view.render().el)
