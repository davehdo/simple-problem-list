Workspace.Views.Problems ||= {}

class Workspace.Views.Problems.EditView extends Backbone.View
  template: JST["backbone/templates/problems/edit"]

  events:
    "submit #edit-problem": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (problem) =>
        @model = problem
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
