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
  for x, i in array2N
    array2N[i] = makeArray_v3 sizeY
  return array2N

prepareArrays = (type, arrayDimensions = [{x:10,y:10},{x:1000,y:1000},{x:100,y:100}], repeats = 10) ->
  timer = new root.Timer
  for arraySpec, i in arrayDimensions
        for x in [0...repeats]
          timer.start(i, "Create #{arraySpec.x}x#{arraySpec.y} array using make2Narray_<b>#{type}</b>")
          switch type
            when "v1" then make2Narray_v1 arraySpec.x, arraySpec.y
            when "v2" then make2Narray_v2 arraySpec.x, arraySpec.y
            when "v3" then make2Narray_v3 arraySpec.x, arraySpec.y
          timer.stop(i)
  return timer


write1sToArray = (array) ->
  console.log "write1sToArray of size #{array.length}"
  for y, i in array
    array[i] = 1
  return array


write1sTo2NArray = (array2N) ->
  console.log "write1sTo2NArray of size #{array2N.length}"
  for x, i in array2N
    array2N[i] = write1sToArray x
  return array2N


useArrays = (type, arrayDimensions = [{x:10,y:10},{x:1000,y:1000},{x:100,y:100}], repeats = 10) ->
  timer = new root.Timer
  for arraySpec, i in arrayDimensions
        for x in [0...repeats]
          array = []
          switch type
            when "v1" then array = make2Narray_v1 arraySpec.x, arraySpec.y
            when "v2" then array = make2Narray_v2 arraySpec.x, arraySpec.y
            when "v3" then array = make2Narray_v3 arraySpec.x, arraySpec.y
          timer.start(i, "Populate #{arraySpec.x}x#{arraySpec.y} array created using make2Narray_<b>#{type}</b> with 1s")
          write1sTo2NArray array
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


results2 = ""
params = [[{x:3,y:3},{x:5,y:5}], 2]
try
  timer = useArrays("v1", params[0], params[1])
  results2 += "<h3>For useArrays with make2Narray_<b>v1</b> </h3>#{timer.formatedResults()}<br>"
catch e
  console.log e

try
  timer = useArrays("v2", params[0], params[1])
  results2 += "<h3>For useArrays with make2Narray_<b>v2</b> </h3>#{timer.formatedResults()}<br>"
catch e
  console.log e
  
try
  timer = useArrays("v3", params[0], params[1])
  results2 += "<h3>For useArrays with make2Narray_<b>v3</b> </h3>#{timer.formatedResults()}<br>"
catch e
  console.log e

outputResults results2


