class Workspace.Models.Plan extends Backbone.Model
  paramRoot: 'plan'

  defaults:
    history: null
    content: null

class Workspace.Collections.PlansCollection extends Backbone.Collection
  model: Workspace.Models.Plan
  url: '/plans'
