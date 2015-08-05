class Workspace.Models.Plan extends Backbone.Model
  paramRoot: 'plan'
  
  initialize: ->
    @leading_rows = ""
    @problems = new Workspace.Collections.ProblemsCollection()

  defaults:
    history: null
    content: "# Problem 1\nDifferential is broad\n[] followup test\n[] call consultant\n\n# Problem 2\nDifferential is broader\n[] call another consultant\n\n# Problem 3\ndifferential is broadest"

  reconstructed_content: ->
    @leading_rows + "\n" + @problems.map( (i) -> i.toText() ).join("\n\n")
  
  reconstruct_content_and_save: ->
    @set "content", @reconstructed_content()
    console.log("reconstructing")
    if @hasChanged("content")
      @save()
      console.log("saved")

  parse_content: ->
    headings = @get("content").match(/[\^|\n]#.*/g)

    problems = @get("content").split(/[\^|\n]#.*/g)
    
    # due to split, there is always one extra problem, which we keep as leading row
    @leading_rows=problems.shift()
    
    # update the subcollection problems
    @problems.reset( $.map problems, (i) =>
      # remove leading endlines and split
      lines = i.trim().split(/\n+/)
      
      title_line = headings.shift().replace(/[\^|\n]#/, "").trim() || "Problem"

      box_lines = []
      text_lines = []
        
      $.map lines, (i) ->
        if i.trim() == ""
          #
        else if i.match(/^\[.?\]/) == null
          text_lines.push i.trim()
        else
          box_lines.push i.trim()
      
      # .concat does not alter the original array
      all_lines = text_lines.concat( $.map(box_lines, (i) -> "- "+i.replace(/^\[.?\]/,"")) )
      {title: title_line, content: all_lines.join("<br />"), text_lines: text_lines, box_lines: box_lines}
    )  

    @problems.each (i) ->
      i.boxes.reset( $.map i.get("box_lines"), (j) ->
        title: j.replace(/^\[.?\]/, "").trim()
        checked: j.match(/^\[\]/) == null
      )
      

class Workspace.Collections.PlansCollection extends Backbone.Collection
  model: Workspace.Models.Plan
  url: '/plans'
