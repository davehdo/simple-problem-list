class Workspace.Models.Plan extends Backbone.Model
  paramRoot: 'plan'
  
  initialize: ->
    @problems = new Workspace.Collections.ProblemsCollection()
    @on("change", @say_hello)

  say_hello: ->
    console.log("hi")
    
  defaults:
    history: null
    content: "# Problem 1\nDifferential is broad\n[] followup test\n[] call consultant\n\n# Problem 2 Differential is broader\n[] call another consultant\n# Problem 3"

  parse_content: ->
    problems = @get("content").split(/\n#+/)
    
    # only keep the first problem if it starts with a hash
    if (problems[0] != undefined) and (problems[0].match(/^#/) == null)
      problems.shift()
    
    # update the subcollection problems
    @problems.reset( $.map problems, (i) ->
      lines = i.split(/\n/)
      title_line = lines.shift().replace(/^#/, "")

      box_lines = []
      text_lines = []
        
      $.map lines, (i) ->
        if i.match(/^\[.?\]/) == null
          text_lines.push i
        else
          box_lines.push i    
          
      {title: title_line, content: text_lines.join("<br />"), boxes: box_lines}
    )  

    @problems.each (i) ->
      i.boxes.reset( $.map i.get("boxes"), (j) ->
        title: j.replace(/^\[.?\]/, "")
        checked: j.match(/^\[\]/) == null
      )
      

class Workspace.Collections.PlansCollection extends Backbone.Collection
  model: Workspace.Models.Plan
  url: '/plans'
