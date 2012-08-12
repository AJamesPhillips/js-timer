root = exports ? this

timer = new root.Timer

makeArray_v1 = (size) ->
  return [0...size]

make2Narray_v1 = (sizeX, sizeY) ->
  array2N = [0...sizeX]
  for i in array2N
    array2N[i] = makeArray_v1 sizeY

prepareArrays_v1 = (arrayDimensions = [{x:10,y:10},{x:1000,y:10000},{x:100,y:100}], repeats = 10) ->
  for arraySpec, i in arrayDimensions
    for x in [0...repeats]
      timer.start(i)
      array = make2Narray_v1 arraySpec.x, arraySpec.y
      timer.stop(i)
  return null



outputResults = (resultsString) ->
  document.getElementById('results').innerHTML = resultsString


arrays = prepareArrays_v1()

for activityId, activityAverage of timer.results()
  results += " #{activityId} was #{activityAverage}"
outputResults results