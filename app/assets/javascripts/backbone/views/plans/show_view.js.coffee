Workspace.Views.Plans ||= {}

class Workspace.Views.Plans.ShowView extends Backbone.View
  template: JST["backbone/templates/plans/show"]
  problem_template: JST["backbone/templates/problems/problem"]
  box_template: JST["backbone/templates/boxes/box"]
  
  render: ->
    @$el.html(@template(@model.toJSON() ))
    @model.parse_content()
    
    @model.problems.each (i) =>
      this.$("#problems-table").append(@problem_template(i.toJSON()))

      i.boxes.each (box) =>
        $form = $('<form>');
        $form.html(@box_template(box.toJSON()))
        $form.backboneLink(box)
        this.$("#boxes-table").append($form)
        
    return this

