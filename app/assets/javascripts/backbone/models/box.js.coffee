class Workspace.Models.Box extends Backbone.Model
  paramRoot: 'box'

  defaults:
    title: null
    checked: null
  
  toText: ->
    "[#{if @get("checked") then "x" else ""}] #{@get("title")}"

class Workspace.Collections.BoxesCollection extends Backbone.Collection
  model: Workspace.Models.Box
  url: '/boxes'
