// LibFile: logging.scad
//   Logging routines for emitting simple and consistent messages into OpenSCAD's console.
//
// FileSummary: Routines for simple and consistent logging to the OpenSCAD console.
// Includes:
//   include <logging.scad>


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
//   When invoked as a function, `log_debug()` returns undef. 
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
// Todo:
//   There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_debug(msg) = logger(msg, LOG_DEBUG);
module   log_debug(msg) { logger(msg, LOG_DEBUG); }


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
//   When invoked as a function, `log_info()` returns undef. 
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
// Todo:
//   There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_info(msg) = logger(msg, LOG_INFO);
module   log_info(msg) { logger(msg, LOG_INFO); }


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
//   When invoked as a function, `log_warning()` returns undef. 
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
// Todo:
//   There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_warning(msg) = logger(msg, LOG_WARNING);
module   log_warning(msg) { logger(msg, LOG_WARNING); }


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
//   When invoked as a function, `log_error()` returns undef. 
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
// Todo:
//   There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_error(msg) = logger(msg, LOG_ERROR);
module   log_error(msg) { logger(msg, LOG_ERROR); }


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
//   When invoked as a module, `log_fatal()` halts execution of the .scad file.. 
//   .
//   When invoked as a function, `log_fatal()` halts execution of the .scad file.. 
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
// Todo:
//   There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error. 
// See Also: LOG_LEVEL, log_debug(), log_info(), log_warning(), log_error(), log_fatal()
function log_fatal(msg) = assert(false, format_log(msg, level=LOG_FATAL));
module   log_fatal(msg) { assert(false, format_log(msg, level=LOG_FATAL)); }


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
//   When invoked as a function, `logger()` returns undef. 
// Arguments:
//   msg = The message to emit. `msg` can be either a literal string, or a list of elements.
//   msg_level = The logging level *of the message*. 
function logger(msg, msg_level) = (log_match(msg_level)) ? echo(format_log(msg, level=msg_level)) : undef;
module   logger(msg, msg_level) {
    if (log_match(msg_level)) echo(format_log(msg, level=msg_level));
}


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


