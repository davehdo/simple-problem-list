Workspace.Views.Plans ||= {}

class Workspace.Views.Plans.EditView extends Backbone.View
  template: JST["backbone/templates/plans/edit"]

  
  events:
    "submit #edit-plan": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (plan) =>
        @model = plan
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))
    this.$("form").backboneLink(@model)

        

    return this
