root = exports ? this



makeArray_v1 = (size) ->
  return [0...size]

make2Narray_v1 = (sizeX, sizeY) ->
  array2N = [0...sizeX]
  for i in array2N
    array2N[i] = makeArray_v1 sizeY
  return array2N

makeArray_v3 = (size) ->
  array = []
  array[size-1] = 0
  return array

make2Narray_v3 = (sizeX, sizeY) ->
  array2N = []
  array2N[sizeX-1] = 0
  for v in array2N
    array2N.push makeArray_v3 sizeY
  return array2N

prepareArrays = (type, arrayDimensions = [{x:10,y:10},{x:1000,y:1000},{x:100,y:100}], repeats = 100) ->
  timer = new root.Timer
  for arraySpec, i in arrayDimensions
        for x in [0...repeats]
          timer.start(i)
          switch type
            when "v1" then make2Narray_v1 arraySpec.x, arraySpec.y
            when "v2" then make2Narray_v2 arraySpec.x, arraySpec.y
            when "v3" then make2Narray_v3 arraySpec.x, arraySpec.y
          timer.stop(i)
  return timer



outputResults = (resultsString) ->
  document.getElementById('results').innerHTML = resultsString


results = ""
timer = prepareArrays("v1")
results += "<h3>For prepareArrays_v1 </h3>#{timer.formatedResults()}<br>"


timer = prepareArrays("v2")
results += "<h3>For prepareArrays_v2 </h3>#{timer.formatedResults()}<br>"


timer = prepareArrays("v3")
results += "<h3>For prepareArrays_v3 </h3>#{timer.formatedResults()}<br>"


outputResults results