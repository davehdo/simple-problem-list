class Workspace.Models.Plan extends Backbone.Model
  paramRoot: 'plan'
  
  initialize: ->
    @leading_rows = ""
    @problems = new Workspace.Collections.ProblemsCollection()
    @on("change", @say_hello)

  say_hello: ->
    console.log("hi")
    
  defaults:
    history: null
    content: "# Problem 1\nDifferential is broad\n[] followup test\n[] call consultant\n\n# Problem 2\nDifferential is broader\n[] call another consultant\n\n# Problem 3\ndifferential is broadest"

  parse_content: ->
    headings = @get("content").match(/[\^|\n]#.*/g)

    problems = @get("content").split(/[\^|\n]#.*/g)
    
    # due to split, there is always one extra problem, which we keep as leading row
    @leading_rows=problems.shift()
    
    # update the subcollection problems
    @problems.reset( $.map problems, (i) =>
      # remove leading endlines and split
      lines = i.replace(/^\n+/, "").split(/\n/)
      
      title_line = headings.shift().replace(/[\^|\n]#/, "").trim() || "Problem"

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
