root = exports ? this



makeArray_v1 = (size) ->
  return [0...size]

make2Narray_v1 = (sizeX, sizeY) ->
  array2N = [0...sizeX]
  for i in array2N
    array2N[i] = makeArray_v1 sizeY

prepareArrays = (type, arrayDimensions = [{x:10,y:10},{x:1000,y:1000},{x:100,y:100}], repeats = 10) ->
  timer = new root.Timer
  for arraySpec, i in arrayDimensions
        for x in [0...repeats]
          timer.start(i)
          switch type
            when "v1" then make2Narray_v1 arraySpec.x, arraySpec.y
            when "v2" then make2Narray_v2 arraySpec.x, arraySpec.y
          timer.stop(i)
  return timer

outputResults = (resultsString) ->
  document.getElementById('results').innerHTML = resultsString

timer1 = prepareArrays("v1")
results = "<h3>For prepareArrays_v1 </h3>#{timer1.formatedResults()}<br>"


timer2 = prepareArrays("v2")
results += "<h3>For prepareArrays_v2 </h3>#{timer2.formatedResults()}<br>"

outputResults results