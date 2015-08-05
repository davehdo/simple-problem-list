Workspace.Views.Plans ||= {}

class Workspace.Views.Plans.IndexView extends Backbone.View
  template: JST["backbone/templates/plans/index"]
  box_template: JST["backbone/templates/boxes/box"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (plan) =>
    plan.parse_content()
    view = new Workspace.Views.Plans.PlanView({model : plan})
    $div = $(view.render().el)

    # add the checkboxes
    plan.problems.each (problem) =>
      problem.boxes.each (box) =>
        $form = $(@box_template(box.toJSON()))
        $div.find("#boxes-container").append($form)

        # we do our own binding here
        # we bind from UI object to model 
        $form.find("[name=checked]").on "change", (evt) =>
          new_val = $(evt.target).prop("checked")
          if box.get("checked") != new_val
            box.set("checked", new_val)
        
        # when a checkbox value is changed, trigger event
        # this may be best moved into the model
        box.on "change:checked", (i) =>
          plan.reconstruct_content_and_save()

    @$("tbody").append($div)

  render: =>
    @$el.html(@template(plans: @collection.toJSON() ))
    @addAll()
    


    return this
