root = exports ? this



root.Timer = class Timer
  @nextId = 0
  constructor: () ->
    @id = @nextId++ #just meant to help track which timer this is.

    @activities = {}
    @nextActivityId = 0

  start: (activityId = @nextActivityId++, 
          activityDescription = "activityDescription not given", 
          runDescription = "run #{if @activities[activityId]? then @activities[activityId].length else 0}") ->
    @activities[activityId] ||= []
    @activities[activityId].activityDescription = activityDescription
    @activities[activityId].push {start: new Date, runDescription: runDescription}
    return activityId

  stop: (activityId = (@nextActivityId-1), runNumber = (@activities[activityId].length-1)) ->
    @activities[activityId][runNumber].end = new Date
    @activities[activityId][runNumber].total = @activities[activityId][runNumber].end - @activities[activityId][runNumber].start
    console.log "Activity #{activityId}, run number #{runNumber} took #{@activities[activityId][runNumber].total} milli seconds"


  results: ->
    results = {}
    console.log "averaging"
    #average all
    for activityId, runs of @activities
      for run in runs
        total = run.total
      results[activityId] = 
        average: total / activityId.length
        activityDescription: runs.activityDescription
      console.log "Activity #{activityId} \"#{runs.activityDescription}\" averaged #{results[activityId].average}"
    return results

  formatedResults: ->
    results = ""
    for activityId, activityAverage of @results()
      results += "Activity #{activityId} \"#{activityAverage.activityDescription}\" averaged #{activityAverage.average}ms<br>"
    return results



