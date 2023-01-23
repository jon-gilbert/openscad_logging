# Section: Logging Basics
 
## Step: 1. Include logging
*tl;dr:* `include <logging.scad>`

You'll need to include this file somewhere in your .scad file. Near the top of your .scad script, include this `logging.scad` file. 

## Step: 2. Set a logging level 
*tl;dr:* `LOG_LEVEL = LOG_WARNING;`

Somewhere in your .scad file *(ideally, near the start of the execution, but after you've included `logging.scad`)* define the `LOG_LEVEL` variable. 
You define it as one of the `LOG_` constants listed in the **Constants** section above. 

`LOG_LEVEL = LOG_DEBUG;`

If you're doing something esoteric and want to define the `LOG_LEVEL` *before* you've included `logging.scad`, you'll have to use the `LOG_`whatever numerical value and not the name of the constant. 

`LOG_LEVEL = 1;`

Remember, since this is OpenSCAD, you can only define this variable once, and it cannot change once set: you're setting this value for the whole of your script as well as anything that includes it.  

`LOG_LEVEL` doesn't set the priority of the messages emitted: it only limits the messages you *see*. You can think of `LOG_LEVEL` as the minimum log level which will emit a message to OpenSCAD's console, kind of like a noise filter. Only want to see errors? Use `LOG_ERROR`. Want to see every single log message displayed? `LOG_DEBUG`. 

## Step: 3. Call logging when appropriate
*tl;dr:* `log_warning("I'm a warning message.");`

Within your model or function library, when you want to emit a message, call the appropriate logging function. Messages can have varying priority levels, and it's the call to `log_whatever()` that defines the priority of that message. An example:

```
module mymodule(d) {
  log_debug(["mymodule() invoked with arg:", d]);
  if (d > 1000) {
     log_warning("mymodule(): supplied arg 'd' is really big, and may render slow");
  }
  if (d < 0) {
     log_error("Can't have a model with negative dimensions");
  } else {
     cube(d);
  }
}
```

Calls to `mymodule()` with a `d` argument that are exceptionally large will emit a warning; if `d` is negative, `mymodule()` will emit an error and no cube will be rendered. 



