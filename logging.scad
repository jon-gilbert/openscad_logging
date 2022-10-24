// LibFile: logging.scad
//   Logging routines for emitting simple and consistent messages into OpenSCAD's console.
//
// FileSummary: Routines for simple and consistent logging to the OpenSCAD console.
// Includes:
//   include <logging.scad>
// Continues:
//   ...and then, set a `LOG_LEVEL` variable somewhere within your model file. See the `LOG_LEVEL` definition in 
//   the "Logging Level Constants" section, below.


// Section: Logging Level Constants
//
// Constant: LOG_LEVEL
// Description:
//   The global `LOG_LEVEL`: denotes the logging level for a given .scad file.  **You must 
//   set this constant within your model file somewhere** for logging to take effect. You may only set `LOG_LEVEL` once.
//   .
//   `LOG_LEVEL` may also be set on the command-line with OpenSCAD's `-D` option: `openscad -o out.echo -D"LOG_LEVEL=1" ./file.scad` 
//   will set `LOG_LEVEL` before your script executes. For this, you'll need the numerical value of the log level you want. 
// Example(NORENDER):
//   LOG_LEVEL = LOG_WARNING;
//   //
//   log_debug("debugging message");   // nothing is emitted to the console
//   log_warning("warning message");   // "ECHO: WARNING: warning message" is emitted to the console. 
// Example(NORENDER): declaring `LOG_LEVEL` before logging.scad is included:
//   // in a file that has not yet declared the logging 
//   // inclusion, the level is set to LOG_WARNING's 
//   // numerical value:
//   LOG_LEVEL = 3; 
//   // ...some lines of code later:
//   include <logging.scad>
//   log_debug("debugging message");   // nothing is emitted to the console
//   log_warning("warning message");   // "ECHO: WARNING: warning message" is emitted to the console. 
// See Also: LOG_FATAL, LOG_ERROR, LOG_WARNING, LOG_INFO, LOG_DEBUG


// Constant: LOG_DEBUG
// Description: 
//   Denotes a logging level. By declaring `LOG_DEBUG` as your global `LOG_LEVEL`, the 
//   only logging messages that will be emitted to the console will be those of 
//   a DEBUG level or lower. That list of levels is
//   `LOG_DEBUG`, `LOG_INFO`, `LOG_WARNING`, `LOG_ERROR`, and `LOG_FATAL`. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
LOG_DEBUG = 1;


// Constant: LOG_INFO
// Description: 
//   Denotes a logging level. By declaring `LOG_INFO` as your global `LOG_LEVEL`, the 
//   only logging messages that will be emitted to the console will be those of 
//   a INFO level or lower. That list of levels is
//   `LOG_INFO`, `LOG_WARNING`, `LOG_ERROR`, and `LOG_FATAL`. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
LOG_INFO = 2;


// Constant: LOG_WARNING
// Description: 
//   Denotes a logging level. By declaring `LOG_WARNING` as your global `LOG_LEVEL`, the 
//   only logging messages that will be emitted to the console will be those of 
//   a WARNING level or lower. That list of levels is 
//   `LOG_WARNING`, `LOG_ERROR`, and `LOG_FATAL`. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
LOG_WARNING = 3;


// Constant: LOG_ERROR
// Description: 
//   Denotes a logging level. By declaring `LOG_ERROR` as your global `LOG_LEVEL`, the 
//   only logging messages that will be emitted to the console will be those of 
//   a ERROR level or lower. That list of levels is
//   `LOG_ERROR` and `LOG_FATAL`.
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
LOG_ERROR = 4;


// Constant: LOG_FATAL
// Description: 
//   Denotes a logging level. By declaring `LOG_FATAL` as your global `LOG_LEVEL`, the 
//   only logging messages that will be emitted to the console will be those of 
//   a FATAL level. This is the highest of the logging levels. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
LOG_FATAL = 5;


// Constant: LOG_NAMES
// Description:
//   A list of the names of the logging levels. This is provided for a simple lookup
//   and labeling of the `LOG_*` level constants above when the log message is formatted. 
//   The element's positions must correspond to the log level's numerical constant value. 
//
LOG_NAMES = [undef, "DEBUG", "INFO", "WARNING", "ERROR", "FATAL"];


// Section: Logging Functions 
//   In general, there are a common collection of logging functions and modules for each log level specified in `LOG_NAMES`, 
//   all doing approximately the same thing. Each function and module has a more detailed write-up in this section
//   below, but at a high level each logging level (WARNING, ERROR, et al) has one the following:
//   .
//   * a basic logging method and function (eg, `log_debug()`)
//   * a conditional "log this message if the test is true" method and function (eg, `log_info_if()`)
//   * a conditional "log this message *unless* the test is true" method and function (eg, `log_warning_unless()`)
//   * an assignment logging function, that logs and assigns in one step (eg, `log_error_assign()`)
// 
// Function&Module: log_debug()
// Usage: as a module
//   log_debug(msg);
// Usage: as a function
//   _ = log_debug(msg);
// Description: 
//   Given a log message as either a single string or list, emit a log message prefixed with "DEBUG" 
//   if the global `LOG_LEVEL` is at or lower than `LOG_DEBUG`. 
//   .
//   When invoked as a module, `log_debug()` produces no model or element for drawing. 
//   .
//   When invoked as a function, `log_debug()` returns `msg` if it should have emitted to the console, or undef. 
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug("log message");
//   // emits to the console:  ECHO: "DEBUG: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug(["message with additional info:", 1]);
//   // emits to the console:  ECHO: "DEBUG: message with additional info: 1"
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_DEBUG;
//   function myfunc(v) = let( _ = log_debug("log message") ) v + 1;
//   new_v = myfunc(1);
//   // emits to the console:  ECHO: "DEBUG: log message"
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_debug(msg) = logger(msg, LOG_DEBUG);
module   log_debug(msg) { logger(msg, LOG_DEBUG); }


// Function&Module: log_debug_if()
// Usage: as a module
//   log_debug_if(test, msg);
// Usage: as a function:
//   bool = log_debug_if(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "DEBUG" if the `test` evaluates to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_DEBUG`. 
//   .
//   When invoked as a module, `log_debug_if()` does not produce a model or element for drawing. 
//   .
//   When invoked as a function, `log_debug_if()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug_if(true, "log message");
//   // emits to the console:  ECHO: "DEBUG: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug_if(1 > 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "DEBUG: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug_if(0 > 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_debug_if(1 > 0, "log message");
//   // emits to the console: ECHO: "DEBUG: log message"
//   // v == true
// Example(NORENDER): when invoked as a function and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_debug_if(0 > 1, "log message");
//   // nothing is emitted to the console
//   // v == false
function log_debug_if(test, msg) = logger_if(test, msg, LOG_DEBUG);
module   log_debug_if(test, msg) { logger_if(test, msg, LOG_DEBUG); }


// Function&Module: log_debug_unless()
// Usage: as a module
//   log_debug_unless(test, msg);
// Usage: as a function:
//   bool = log_debug_unless(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "DEBUG" if the `test` does not evaluate to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_DEBUG`. 
//   .
//   When invoked as a module, `log_debug_unless()` does not produce a model or element for drawing. 
//   .
//   When invoked as a function, `log_debug_unless()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug_unless(false, "log message");
//   // emits to the console:  ECHO: "DEBUG: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug_unless(1 < 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "DEBUG: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to false:
//   LOG_LEVEL = LOG_DEBUG;
//   log_debug_unless(0 < 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_debug_unless(1 < 0, "log message");
//   // emits to the console: ECHO: "DEBUG: log message"
//   // v == false
// Example(NORENDER): when invoked as a function and `test` does not evaluate to false:
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_debug_unless(0 < 1, "log message");
//   // nothing is emitted to the console
//   // v == true
function log_debug_unless(test, msg) = logger_unless(test, msg, LOG_DEBUG);
module   log_debug_unless(test, msg) { logger_unless(test, msg, LOG_DEBUG); }


// Function: log_debug_assign()
// Usage:
//   val = log_debug_assign(val);
//   val = log_debug_assign(val, <msg>);
// Description:
//   Given a value, `log_debug_assign()` will log that the value `val` is being 
//   assigned, and then will return the value `val`. If an optional log message 
//   `msg` is specified, that message will be log instead. 
//   .
//   The log message is emitted according to the logging level as is normally done 
//   via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_DEBUG`, the message 
//   will not be emitted. 
//   .
//   The given value `val` is returned regardless of whether a log message was emitted.
// Arguments:
//   val = An arbitrary value.
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.
// Continues:
//   There is no corresponding `log_debug_assign()` module. 
// Example(NORENDER): logging assignment information at a "debug" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.
//   LOG_LEVEL=LOG_DEBUG;
//   x = log_debug_assign(1, "assigning 1 to x");
//   // emits to the console: ECHO: "DEBUG: assigning 1 to x"
//   // x == 1
// Example(NORENDER): logging at an "info" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "debug", no message is emitted to the console log. 
//   LOG_LEVEL=LOG_INFO;
//   x = log_debug_assign(1, "assigning 1 to x");
//   // nothing is emitted to the console
//   // x == 1
function log_debug_assign(val, msg) = logger_assign(val, msg, LOG_DEBUG);


// Function&Module: log_info()
// Usage: as a module
//   log_info(msg);
// Usage: as a function
//   _ = log_info(msg);
// Description: 
//   Given a log message as either a single string or list, emit a log message prefixed with "INFO" 
//   if the global `LOG_LEVEL` is at or lower than `LOG_INFO`. 
//   .
//   When invoked as a module, `log_info()` produces no model or element for drawing. 
//   .
//   When invoked as a function, `log_info()` returns `msg` if it should have emitted to the console, or undef. 
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_INFO;
//   log_info("log message");
//   // emits to the console:  ECHO: "INFO: log message"
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_INFO;
//   log_info(["message with additional info:", 1]);
//   // emits to the console:  ECHO: "INFO: message with additional info: 1"
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_INFO;
//   function myfunc(v) = let( _ = log_info("log message") ) v + 1;
//   new_v = myfunc(1);
//   // emits to the console:  ECHO: "INFO: log message"
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_info(msg) = logger(msg, LOG_INFO);
module   log_info(msg) { logger(msg, LOG_INFO); }


// Function&Module: log_info_if()
// Usage: as a module
//   log_info_if(test, msg);
// Usage: as a function:
//   bool = log_info_if(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "INFO" if the `test` evaluates to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_INFO`. 
//   .
//   When invoked as a module, `log_info_if()` does not produce no model or element for drawing. 
//   .
//   When invoked as a function, `log_info_if()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_INFO;
//   log_info_if(true, "log message");
//   // emits to the console:  ECHO: "INFO: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = INFO;
//   log_info_if(1 > 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "INFO: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_DEBUG;
//   log_info_if(0 > 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_info_if(1 > 0, "log message");
//   // emits to the console: ECHO: "INFO: log message"
//   // v == true
// Example(NORENDER): when invoked as a function and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_info_if(0 > 1, "log message");
//   // nothing is emitted to the console
//   // v == false
function log_info_if(test, msg) = logger_if(test, msg, LOG_INFO);
module   log_info_if(test, msg) { logger_if(test, msg, LOG_INFO); }


// Function&Module: log_info_unless()
// Usage: as a module
//   log_info_unless(test, msg);
// Usage: as a function:
//   bool = log_info_unless(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "INFO" if the `test` does not evaluate to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_INFO`. 
//   .
//   When invoked as a module, `log_info_unless()` does not produce a model or element for drawing. 
//   .
//   When invoked as a function, `log_info_unless()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable express, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_INFO;
//   log_info_unless(false, "log message");
//   // emits to the console:  ECHO: "INFO: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = INFO;
//   log_info_unless(1 < 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "INFO: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to false
//   LOG_LEVEL = LOG_DEBUG;
//   log_info_unless(0 < 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_info_unless(1 < 0, "log message");
//   // emits to the console: ECHO: "INFO: log message"
//   // v == false
// Example(NORENDER): when invoked as a function and `test` does not evaluate to false
//   LOG_LEVEL = LOG_DEBUG;
//   v = log_info_unless(0 < 1, "log message");
//   // nothing is emitted to the console
//   // v == true
function log_info_unless(test, msg) = logger_unless(test, msg, LOG_INFO);
module   log_info_unless(test, msg) { logger_unless(test, msg, LOG_INFO); }


// Function: log_info_assign()
// Usage:
//   val = log_info_assign(val);
//   val = log_info_assign(val, <msg>);
// Description:
//   Given a value, `log_info_assign()` will log that the value `val` is being 
//   assigned, and then will return the value `val`. If an optional log message 
//   `msg` is specified, that message will be log instead. 
//   .
//   The log message is emitted according to the logging level as is normally done 
//   via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_INFO`, the message 
//   will not be emitted. 
//   .
//   The given value `val` is returned regardless of whether a log message was emitted.
// Arguments:
//   val = An arbitrary value.
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.
// Continues:
//   There is no corresponding `log_info_assign()` module. 
// Example(NORENDER): logging assignment information at a "info" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.
//   LOG_LEVEL=LOG_INFO;
//   x = log_info_assign(1, "assigning 1 to x");
//   // emits to the console: ECHO: "INFO: assigning 1 to x"
//   // x == 1
// Example(NORENDER): logging at an "warning" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "info", no message is emitted to the console log. 
//   LOG_LEVEL=LOG_WARNING;
//   x = log_info_assign(1, "assigning 1 to x");
//   // nothing is emitted to the console
//   // x == 1
function log_info_assign(val, msg) = logger_assign(val, msg, LOG_INFO);


// Function&Module: log_warning()
// Usage: as a module
//   log_warning(msg);
// Usage: as a function
//   _ = log_warning(msg);
// Description: 
//   Given a log message as either a single string or list, emit a log message prefixed with "WARNING" 
//   if the global `LOG_LEVEL` is at or lower than `LOG_WARNING`. 
//   .
//   When invoked as a module, `log_warning()` produces no model or element for drawing. 
//   .
//   When invoked as a function, `log_warning()` returns `msg` if it should have emitted to the console, or undef. 
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_WARNING;
//   log_warning("log message");
//   // emits to the console:  ECHO: "WARNING: log message"
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_WARNING;
//   log_warning(["message with additional info:", 1]);
//   // emits to the console:  ECHO: "WARNING: message with additional info: 1"
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_WARNING;
//   function myfunc(v) = let( _ = log_warning("log message") ) v + 1;
//   new_v = myfunc(1);
//   // emits to the console:  ECHO: "WARNING: log message"
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_warning(msg) = logger(msg, LOG_WARNING);
module   log_warning(msg) { logger(msg, LOG_WARNING); }


// Function&Module: log_warning_if()
// Usage: as a module
//   log_warning_if(test, msg);
// Usage: as a function:
//   bool = log_warning_if(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "WARNING" if the `test` evaluates to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_WARNING`. 
//   .
//   When invoked as a module, `log_warning_if()` does not produce a model or element for drawing. 
//   .
//   When invoked as a function, `log_warning_if()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_WARNING;
//   log_warning_if(true, "log message");
//   // emits to the console:  ECHO: "WARNING: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_WARNING;
//   log_warning_if(1 > 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "WARNING: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_WARNING;
//   log_warning_if(0 > 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_WARNING;
//   v = log_warning_if(1 > 0, "log message");
//   // emits to the console: ECHO: "WARNING: log message"
//   // v == true
// Example(NORENDER): when invoked as a function and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_WARNING;
//   v = log_warning_if(0 > 1, "log message");
//   // nothing is emitted to the console
//   // v == false
function log_warning_if(test, msg) = logger_if(test, msg, LOG_WARNING);
module   log_warning_if(test, msg) { logger_if(test, msg, LOG_WARNING); }


// Function&Module: log_warning_unless()
// Usage: as a module
//   log_warning_unless(test, msg);
// Usage: as a function:
//   bool = log_warning_unless(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "WARNING" if the `test` does not evaluate to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_WARNING`. 
//   .
//   When invoked as a module, `log_warning_unless()` does not produce a model or element for drawing. 
//   .
//   When invoked as a function, `log_warning_unless()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_WARNING;
//   log_warning_unless(false, "log message");
//   // emits to the console:  ECHO: "WARNING: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_WARNING;
//   log_warning_unless(1 < 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "WARNING: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to false
//   LOG_LEVEL = LOG_WARNING;
//   log_warning_unless(0 < 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_WARNING;
//   v = log_warning_unless(1 < 0, "log message");
//   // emits to the console: ECHO: "WARNING: log message"
//   // v == false
// Example(NORENDER): when invoked as a function and `test` does not evaluate to false
//   LOG_LEVEL = LOG_WARNING;
//   v = log_warning_unless(0 < 1, "log message");
//   // nothing is emitted to the console
//   // v == true
function log_warning_unless(test, msg) = logger_unless(test, msg, LOG_WARNING);
module   log_warning_unless(test, msg) { logger_unless(test, msg, LOG_WARNING); }


// Function: log_warning_assign()
// Usage:
//   val = log_warning_assign(val);
//   val = log_warning_assign(val, <msg>);
// Description:
//   Given a value, `log_warning_assign()` will log that the value `val` is being 
//   assigned, and then will return the value `val`. If an optional log message 
//   `msg` is specified, that message will be log instead. 
//   .
//   The log message is emitted according to the logging level as is normally done 
//   via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_WARNING`, the message 
//   will not be emitted. 
//   .
//   The given value `val` is returned regardless of whether a log message was emitted.
// Arguments:
//   val = An arbitrary value.
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.
// Continues:
//   There is no corresponding `log_warning_assign()` module. 
// Example(NORENDER): logging assignment information at a "warning" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.
//   LOG_LEVEL=LOG_WARNING;
//   x = log_warning_assign(1, "assigning 1 to x");
//   // emits to the console: ECHO: "WARNING: assigning 1 to x"
//   // x == 1
// Example(NORENDER): logging at an "error" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "warning", no message is emitted to the console log. 
//   LOG_LEVEL=LOG_ERROR;
//   x = log_warning_assign(1, "assigning 1 to x");
//   // nothing is emitted to the console
//   // x == 1
function log_warning_assign(val, msg) = logger_assign(val, msg, LOG_WARNING);


// Function&Module: log_error()
// Usage: as a module
//   log_error(msg);
// Usage: as a function
//   _ = log_error(msg);
// Description: 
//   Given a log message as either a single string or list, emit a log message prefixed with "ERROR" 
//   if the global `LOG_LEVEL` is at or lower than `LOG_ERROR`. 
//   .
//   When invoked as a module, `log_error()` produces no model or element for drawing. 
//   .
//   When invoked as a function, `log_error()` returns `msg` if it should have emitted to the console, or undef. 
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_ERROR;
//   log_error("log message");
//   // emits to the console:  ECHO: "ERROR: log message"
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_ERROR;
//   log_error(["message with additional info:", 1]);
//   // emits to the console:  ECHO: "ERROR: message with additional info: 1"
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_ERROR;
//   function myfunc(v) = let( _ = log_error("log message") ) v + 1;
//   new_v = myfunc(1);
//   // emits to the console:  ECHO: "ERROR: log message"
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_error(msg) = logger(msg, LOG_ERROR);
module   log_error(msg) { logger(msg, LOG_ERROR); }


// Function&Module: log_error_if()
// Usage: as a module
//   log_error_if(test, msg);
// Usage: as a function:
//   bool = log_error_if(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "ERROR" if the `test` evaluates to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_ERROR`. 
//   .
//   When invoked as a module, `log_error_if()` does not produce a model or element for drawing. 
//   .
//   When invoked as a function, `log_error_if()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable express, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_ERROR;
//   log_error_if(true, "log message");
//   // emits to the console:  ECHO: "ERROR: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_ERROR;
//   log_error_if(1 > 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "ERROR: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_ERROR;
//   log_error_if(0 > 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_ERROR;
//   v = log_error_if(1 > 0, "log message");
//   // emits to the console: ECHO: "ERROR: log message"
//   // v == true
// Example(NORENDER): when invoked as a function and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_ERROR;
//   v = log_error_if(0 > 1, "log message");
//   // nothing is emitted to the console
//   // v == false
function log_error_if(test, msg) = logger_if(test, msg, LOG_ERROR);
module   log_error_if(test, msg) { logger_if(test, msg, LOG_ERROR); }


// Function&Module: log_error_unless()
// Usage: as a module
//   log_error_unless(test, msg);
// Usage: as a function:
//   bool = log_error_unless(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "ERROR" if the `test` does not evaluate to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_ERROR`. 
//   .
//   When invoked as a module, `log_error_unless()` does not produce a model or element for drawing. 
//   .
//   When invoked as a function, `log_error_unless()` returns the evaluated value of `test`. 
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_ERROR;
//   log_error_unless(false, "log message");
//   // emits to the console:  ECHO: "ERROR: log message"
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_ERROR;
//   log_error_unless(1 < 0, ["message with additional info:", 1]);
//   // emits to the console:  ECHO: "ERROR: message with additional info: 1"
// Example(NORENDER): when invoked as a module and `test` does not evaluate to false
//   LOG_LEVEL = LOG_ERROR;
//   log_error_unless(0 < 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_ERROR;
//   v = log_error_unless(1 < 0, "log message");
//   // emits to the console: ECHO: "ERROR: log message"
//   // v == false
// Example(NORENDER): when invoked as a function and `test` does not evaluate to false
//   LOG_LEVEL = LOG_ERROR;
//   v = log_error_unless(0 < 1, "log message");
//   // nothing is emitted to the console
//   // v == true
function log_error_unless(test, msg) = logger_unless(test, msg, LOG_ERROR);
module   log_error_unless(test, msg) { logger_unless(test, msg, LOG_ERROR); }


// Function: log_error_assign()
// Usage:
//   val = log_error_assign(val);
//   val = log_error_assign(val, <msg>);
// Description:
//   Given a value, `log_error_assign()` will log that the value `val` is being 
//   assigned, and then will return the value `val`. If an optional log message 
//   `msg` is specified, that message will be log instead. 
//   .
//   The log message is emitted according to the logging level as is normally done 
//   via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_ERROR`, the message 
//   will not be emitted. 
//   .
//   The given value `val` is returned regardless of whether a log message was emitted.
// Arguments:
//   val = An arbitrary value.
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.
// Continues:
//   There is no corresponding `log_error_assign()` module. 
// Example(NORENDER): logging assignment information at a "error" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.
//   LOG_LEVEL=LOG_ERROR;
//   x = log_error_assign(1, "assigning 1 to x");
//   // emits to the console: ECHO: "ERROR: assigning 1 to x"
//   // x == 1
// Example(NORENDER): logging at an "fatal" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "error", no message is emitted to the console log. 
//   LOG_LEVEL=LOG_FATAL;
//   x = log_error_assign(1, "assigning 1 to x");
//   // nothing is emitted to the console
//   // x == 1
function log_error_assign(val, msg) = logger_assign(val, msg, LOG_ERROR);


// Function&Module: log_fatal()
// Usage: as a module
//   log_fatal(msg);
// Usage: as a function
//   _ = log_fatal(msg);
// Description: 
//   Given a log message as either a single string or list, call `assert()` on a `false` value to 
//   emit a log message prefixed with "FATAL". `log_fatal()` is invokable regardless of the 
//   global `LOG_LEVEL` setting.
//   .
//   When invoked as a module, `log_fatal()` halts execution of the .scad file. 
//   .
//   When invoked as a function, `log_fatal()` halts execution of the .scad file. 
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal("log message");
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ... 
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal(["message with additional info:", 1]);
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: message with addtional info: 1" in file ..., line ... 
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_FATAL;
//   function myfunc(v) = let( _ = log_fatal("log message") ) v + 1;
//   new_v = myfunc(1);
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ... 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_fatal(msg, test=false) = assert(test, format_log(msg, level=LOG_FATAL)) test;
module   log_fatal(msg, test=false) { assert(test, format_log(msg, level=LOG_FATAL)); }


// Function&Module: log_fatal_if()
// Usage: as a module
//   log_fatal_if(test, msg);
// Usage: as a function:
//   bool = log_fatal_if(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "FATAL" if the `test` evaluates to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_FATAL`. 
//   .
//   When invoked as a module, `log_fatal_if()` halts execution of the .scad file.
//   .
//   When invoked as a function, `log_fatal_if()` halts execution of the .scad file.
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal_if(true, "log message");
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ... 
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal_if(1 > 0, ["message with additional info:", 1]);
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: message with additional info: 1" in file ..., line ... 
// Example(NORENDER): when invoked as a module and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal_if(0 > 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console, execution of the .scad file is *not* halted.
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_FATAL;
//   v = log_fatal_if(1 > 0, "log message");
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ... 
//   // v is not evaluatable, because execution will have been halted
// Example(NORENDER): when invoked as a function and `test` does not evaluate to true:
//   LOG_LEVEL = LOG_FATAL;
//   v = log_fatal_if(0 > 1, "log message");
//   // nothing is emitted to the console
//   // v == false
function log_fatal_if(test, msg) = log_fatal(msg, test=!test);
module   log_fatal_if(test, msg) { log_fatal(msg, test=!test); }


// Function&Module: log_fatal_unless()
// Usage: as a module
//   log_fatal_unless(test, msg);
// Usage: as a function:
//   bool = log_fatal_unless(test, msg);
// Description:
//   Given an evaluatable boolean test, and a log message as either a single string or list, emit a 
//   log message prefixed with "FATAL" if the `test` does not evaluate to `true` and if the global 
//   `LOG_LEVEL` is at or lower than `LOG_FATAL`. 
//   .
//   When invoked as a module, `log_fatal_unless()` halts execution of the .scad file.
//   .
//   When invoked as a function, `log_fatal_unless()` halts execution of the .scad file.
// Arguments:
//   test = An evaluatable expression, or a flat boolean expression. No default. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
// Example(NORENDER): when invoked as a module
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal_unless(false, "log message");
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ... 
// Example(NORENDER): when invoked as a module 
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal_unless(1 < 0, ["message with additional info:", 1]);
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: message with additional info: 1" in file ..., line ... 
// Example(NORENDER): when invoked as a module and `test` does not evaluate to false
//   LOG_LEVEL = LOG_FATAL;
//   log_fatal_unless(0 < 1, ["message with additional info:", 1]);
//   // nothing is emitted to the console, execution of the .scad file is *not* halted.
// Example(NORENDER): when invoked as a function
//   LOG_LEVEL = LOG_FATAL;
//   v = log_fatal_unless(1 < 0, "log message");
//   // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ... 
//   // v is not evaluatable, because execution will have been halted
// Example(NORENDER): when invoked as a function and `test` does not evaluate to false
//   LOG_LEVEL = LOG_FATAL;
//   v = log_fatal_unless(0 < 1, "log message");
//   // nothing is emitted to the console
//   // v == true
function log_fatal_unless(test, msg) = log_fatal(msg, test=test);
module   log_fatal_unless(test, msg) { log_fatal(msg, test=test); }


// Section: Core Logging Functions 
//
// Function&Module: logger()
// Usage: as a module
//   logger(msg, msg_level);
// Usage: as a function
//   _ = logger(msg, msg_level);
// Description: 
//   A base function and method on which all `log_` functions use. 
//   Given a log message as either a single string or list, emit a log message prefixed with the 
//   level's prefix from `LOG_NAMES` if the `msg_level` is at or lower than `LOG_LEVEL`.
//   .
//   When invoked as a module, `logger()` produces no model or element for drawing. 
//   .
//   When invoked as a function, `logger()` returns `msg` if it should have emitted to the console, or undef.
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
//   msg_level = The logging level *of the message*. 
function logger(msg, msg_level) = (log_match(msg_level)) ? echo(format_log(msg, level=msg_level)) msg : undef;
module   logger(msg, msg_level) { if (log_match(msg_level)) echo(format_log(msg, level=msg_level)); }


// Function&Module: logger_if()
// Usage: as a module
//   logger_if(test, msg, msg_level);
// Usage: as a function
//   result = logger_if(test, msg, msg_level);
// Description:
//   Conditionally emits given `msg` at the log level `msg_level` if given `test` evaluates to `true`. 
//   `test` is expected to be a boolean comparison result, one of either `true` or `false`. 
//   Mnenomic: "If this test is true, log this message."
//   .
//   When invoked as a module, `logger_if()` produces no model or element for drawing. 
//   .
//   When invoked as a function, `logger_if()` returns the evaluated value of `test`.
//   *This is not the same behavior as `logger()`.*
// Arguments:
//   test = A boolean result from an evaluation test. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
//   msg_level = The logging level *of the message*. 
function logger_if(test, msg, msg_level) = (test) ? logger(msg, msg_level) && test : test;
module   logger_if(test, msg, msg_level) { if (test) logger(msg, msg_level); }


// Function&Module: logger_unless()
// Usage: as a module
//   logger_unless(test, msg, msg_level);
// Usage: as a function
//   result = logger_unless(test, msg, msg_level);
// Description:
//   Conditionally emits given `msg` at the log level `msg_level` if given `test` evaluates to `false`. 
//   `test` is expected to be a boolean comparison result, one of either `true` or `false`. 
//   Mnenomic: "Unless this test is true, log this message."
//   .
//   When invoked as a module, `logger_unless()` produces no model or element for drawing. 
//   .
//   When invoked as a function, `logger_unless()` returns the evaluated value of `test`.
//   *This is not the same behavior as `logger()`.*
// Arguments:
//   test = A boolean result from an evaluation test. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
//   msg_level = The logging level *of the message*. 
function logger_unless(test, msg, msg_level) = logger_if(!test, msg, msg_level);
module   logger_unless(test, msg, msg_level) { logger_if(!test, msg, msg_level); }


// Function: logger_assign()
// Usage:
//   val = logger_assign(val, msg, msg_level);
// Description:
//   Given a value `val`, a log message `msg`, and a logging level `msg_level`, 
//   emit `msg` at the given `msg_level`, and return `val` as-is. 
//   If `msg` is specified as `undef`, a limited placeholder log message will be 
//   generated, incorporating the `val`'s value.
//   .
//   The log `msg` is emitted according to the logging level as is normally done 
//   via `logger()`. The given value `val` is returned regardless of whether a 
//   log message was emitted.
//   . 
//   `val` is not incorporated into `msg`, nor used in evaluating 
//   whether `msg` should be emitted.
// Arguments:
//   val = An arbitrary value. 
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
//   msg_level = The logging level *of the message*. 
// Continues:
//   Because this activity is focused around variable assignment, there is no corresponding 
//   `logger_assign()` module: something is always returned.
// Todo:
//   It sure would be neat if `msg` could be substr'd with `val`, to be emitted to the console log; ideally, without an external lib.
function logger_assign(val, msg, msg_level) = let(_ = logger((msg == undef) ? ["assigning value:", val] : msg, msg_level)) val;


// Function: format_log()
// Description:
//   Given a list of message elements and optionally a log level, construct and return 
//   a log message suitable for logging to the console. Messages are prefixed with the 
//   string-version of the specified logging level. Messages that are lists are 
//   converted to single strings, with each element joined together with a space (` `).
// Usage:
//   string = format_log(msg, <level=LOG_LEVEL>);
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
//   ---
//   level = The logging level at which to create this message. Default: `LOG_LEVEL`. 
function format_log(msg, level=LOG_LEVEL) = str( LOG_NAMES[level], ": ", _rec_format_log(msg) );

function _rec_format_log(msg, s=" ", i=0, acc="") =
    (!is_list(msg))
        ? msg
        : (i >= len(msg) - 1) 
            ? ( i == len(msg) ? acc : str(acc, msg[i]) ) 
            : _rec_format_log( msg, s, i+1, str(acc, msg[i], s) );


// Function: log_match()
// Description:
//   Given a logging level, and optionally a comparison level, return `true` if 
//   the levels match, and `false` if the levels to not match. Both levels must 
//   be an integer. 
// Usage:
//   bool = log_match(level, <global_level=LOG_LEVEL>);
// Arguments:
//   level = The level at which to check. No default. 
//   ---
//   global_level = The level to compare at. Default: `LOG_LEVEL`
// Continues:
//   Evaluation of `LOG_LEVEL` is delayed until only after a `global_level` 
//   isn't available. This is done so that you can still evaluate `log_match()` 
//   comparisons without a globally-set `LOG_LEVEL`.
// Example(NORENDER):
//   LOG_LEVEL = LOG_WARNING;
//   echo(log_match(LOG_DEBUG));
//   // emits:  ECHO: false
//   echo(log_match(LOG_ERROR));
//   // emits:  ECHO: true
// Example(NORENDER):
//   echo(log_match(LOG_ERROR, LOG_ERROR));
//   // emits:  ECHO: true
//   echo(log_match(LOG_DEBUG, LOG_ERROR));
//   // emits:  ECHO: false
function log_match(level, global_level=undef) = 
    let(min_level = (global_level) ? global_level : (LOG_LEVEL) ? LOG_LEVEL : LOG_WARNING)
    is_num(level) && is_num(min_level) && level >= min_level;


