root = exports ? this



makeArray_v1 = (size) ->
  array = [0...size]
  return array

make2Narray_v1 = (sizeX, sizeY) ->
  array2N = [0...sizeX]
  for i in array2N
    array2N[i] = makeArray_v1 sizeY
  return array2N

#Only change is that the array is populate manually, make2Narray_v1b code is the same as make2Narray_v1
makeArray_v1b = (size) ->
  array = []
  array[size-1] = 0
  for x, i in array
    array[i] = 0
  return array

make2Narray_v1b = (sizeX, sizeY) ->
  array2N = [0...sizeX]
  for i in array2N
    array2N[i] = makeArray_v1b sizeY
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

make2Narray_v4 = (sizeX, sizeY) ->
  array2N = []
  while array2N.length < sizeX 
    array2N.push makeArray_v3 sizeY
  return array2N

make2Narray_v5 = (sizeX, sizeY) ->
  array2N = []
  i = 0
  while i < sizeX
    array2N.push makeArray_v3 sizeY
    i++
  return array2N

makeArray = makeArray_v1c = (size) ->
  array = []
  while array.length < size
    array.push 0
  return array

make2Narray = make2Narray_v4b = (sizeX, sizeY) ->
  array2N = []
  while array2N.length < sizeX 
    array2N.push makeArray_v1c sizeY
  return array2N


prepareArrays = (type, arrayDimensions = [{x:10,y:10},{x:1000,y:1000},{x:100,y:100}], repeats = 10) ->
  timer = new root.Timer
  for arraySpec, i in arrayDimensions
        for x in [0...repeats]
          timer.start(i, "Create #{arraySpec.x}x#{arraySpec.y} array using make2Narray_<b>#{type}</b>")
          switch type
            when "v1" then make2Narray_v1 arraySpec.x, arraySpec.y
            when "v1b" then make2Narray_v1b arraySpec.x, arraySpec.y
            when "v2" then make2Narray_v2 arraySpec.x, arraySpec.y
            when "v3" then make2Narray_v3 arraySpec.x, arraySpec.y
            when "v4" then make2Narray_v4 arraySpec.x, arraySpec.y
            when "v5" then make2Narray_v5 arraySpec.x, arraySpec.y
            when "best" then make2Narray arraySpec.x, arraySpec.y
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
            when "v1b" then array = make2Narray_v1b arraySpec.x, arraySpec.y
            when "v2" then array = make2Narray_v2 arraySpec.x, arraySpec.y
            when "v3" then array = make2Narray_v3 arraySpec.x, arraySpec.y
            when "v4" then array = make2Narray_v4 arraySpec.x, arraySpec.y
            when "v5" then array = make2Narray_v5 arraySpec.x, arraySpec.y
            when "best" then array = make2Narray arraySpec.x, arraySpec.y
          timer.start(i, "Populate #{arraySpec.x}x#{arraySpec.y} array created using make2Narray_<b>#{type}</b> with 1s")
          write1sTo2NArray array
          timer.stop(i)
  return timer


outputResults = (resultsString) ->
  document.getElementById('results').innerHTML = resultsString


###
Now test the array constructors
Using "v1", "best" and "v3" (as of commit #9069634) gave the 
following times (in milliseconds) for preparing the array and using them:
                                v1    16                      41
                                best  10                      41
                                v3    11                      138

Run 1000 times for an array of 1000x1000
Google Chrome 21.0.1180.75 (Official Build 150248)
OS  Mac OS X
WebKit  537.1 (@124502)
JavaScript  V8 3.11.10.17

###


params = [[{x:3,y:3},{x:1000,y:1000}], 1000]
results = ""
types = ["v1", "best", "v3"]
timerTotal = new Timer
timerTotal.start(null, "Total time elapsed")

#Assess preparation of arrays
for type, i in types
  #type = types[types.length-i-1] #reverse the order they're assessed in to see if this has any impact, maybe GC effects are involved
  timer = prepareArrays(type, params[0], params[1])
  results += "<h3>For prepareArrays_#{type} </h3>#{timer.formatedResults()}<br>"

#Assess using arrays
for type, i in types
  #type = types[types.length-i-1] #reverse the order they're assessed in to see if this has any impact, maybe GC effects are involved
  timer = useArrays(type, params[0], params[1])
  results += "<h3>For useArrays made with make2Narray_<b>#{type}</b> </h3>#{timer.formatedResults()}<br>"


 
timerTotal.stop()
results += "<br><br><h3>#{timerTotal.formatedResults()}</h3>"
outputResults results



