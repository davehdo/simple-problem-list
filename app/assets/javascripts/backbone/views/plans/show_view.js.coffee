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
        # backbone link does not work well for checboxes
        #$form.backboneLink(box)
        
        # we do our own binding here
        # we bind from UI object to model 
        $form.find("[name=checked]").on "change", (evt) =>
          new_val = $(evt.target).prop("checked")
          if box.get("checked") != new_val
            box.set("checked", new_val)
        
        # when a checkbox value is changed, trigger change event for the entire plan
        box.on "change:checked", (i) =>
          @model.trigger("change")

        this.$("#boxes-table").append($form)
        
    return this

