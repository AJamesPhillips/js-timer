makeArray_v2 = function(size) {
  var array = [];
  array[size-1] = 0;
  return array;
};

make2Narray_v2 = function(sizeX, sizeY) {
  var array2N = [];

  array2N[sizeX-1] = 0;
  for(i = 0; i < sizeX;i +=1) {
    array2N[i] = makeArray_v2(sizeY);
  }
  return array2N;
};