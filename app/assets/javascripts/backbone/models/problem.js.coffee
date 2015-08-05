class Workspace.Models.Problem extends Backbone.Model
  paramRoot: 'problem'

  defaults:
    title: null
    content: null
  
  initialize: =>
    @boxes = new Workspace.Collections.BoxesCollection()

class Workspace.Collections.ProblemsCollection extends Backbone.Collection
  model: Workspace.Models.Problem
  url: '/problems'
