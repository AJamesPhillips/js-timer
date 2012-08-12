root = exports ? this



root.Timer = class Timer
  @nextId = 0
  constructor: () ->
    @id = @nextId++ #just meant to help track which timer this is.

    @activities = {}
    @nextActivityId = 0

  start: (activityId = @nextActivityId++) ->
    @activities[activityId] ||= []
    @activities[activityId].push {start: new Date}
    return activityId

  stop: (activityId = (@nextActivityId-1), runNumber = (@activities[activityId].length - 1)) ->
    @activities[activityId][runNumber].end = new Date
    @activities[activityId][runNumber].total = @activities[activityId][runNumber].end - @activities[activityId][runNumber].start
    console.log "Activity #{activityId}, run number #{runNumber} took #{@activities[activityId][runNumber].total} milli seconds"


  results: ->
    average = {}
    console.log "averaging"
    #average all
    for activityId, runs of @activities
      for run in runs
        total = run.total
      average[activityId] = total / activityId.length
      console.log "Activity #{activityId} averaged #{average[activityId]}"
    return average

  formatedResults: ->
    results = ""
    for activityId, activityAverage of @results()
      results += "Activity #{activityId} averaged #{activityAverage}ms<br>"
    return results



