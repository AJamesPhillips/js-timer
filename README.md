# JS-timer

Used for timing how long a function or set of functions took.

## Example
```
var timer = new Timer();
timer.start();

a_function_to_time();

timer.end();

timer.time;  // =>  {milliseconds: N}
```


# To run the Demo
Run `rake js_timer:build`
Navigate to file://localhost/<path to repo>/js-timer/demo/demo.html
