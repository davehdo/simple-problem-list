class Workspace.Models.Problem extends Backbone.Model
  paramRoot: 'problem'

  defaults:
    title: null
    content: null
    text_lines: null
    box_lines: null
    
  initialize: =>
    @boxes = new Workspace.Collections.BoxesCollection()

  toText: ->
    # $.merge alters the original array
    lines = ["# #{@get("title")}"]
    $.merge(lines, @get("text_lines") || [])
    $.merge(lines, @boxes.map((i) -> i.toText()))
    lines.join("\n")
    
class Workspace.Collections.ProblemsCollection extends Backbone.Collection
  model: Workspace.Models.Problem
  url: '/problems'
